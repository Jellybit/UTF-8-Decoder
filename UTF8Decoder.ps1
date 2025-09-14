Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# Function to show message box
function Show-MessageBox {
    param (
        [string]$Message,
        [string]$Title = "CivitAI Text Decoder",
        [string]$Type = "Info"
    )
    $image = switch ($Type) {
        "Error" { [System.Windows.MessageBoxImage]::Error }
        "Warning" { [System.Windows.MessageBoxImage]::Warning }
        "Question" { [System.Windows.MessageBoxImage]::Question }
        default { [System.Windows.MessageBoxImage]::Information }
    }
    $button = if ($Type -eq "Question") { [System.Windows.MessageBoxButton]::YesNo } else { [System.Windows.MessageBoxButton]::OK }
    [System.Windows.MessageBox]::Show($Global:Window, $Message, $Title, $button, $image)
}

# XAML for the GUI
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:shell="clr-namespace:System.Windows.Shell;assembly=PresentationFramework"
        Title="CivitAI Text Decoder" Height="550" Width="600"
        WindowStartupLocation="CenterScreen"
        AllowsTransparency="True" WindowStyle="None" Background="Transparent"
        Name="MainWindow" ResizeMode="CanResize">
    <shell:WindowChrome.WindowChrome>
        <shell:WindowChrome ResizeBorderThickness="8"
                            CaptionHeight="30"
                            CornerRadius="0"
                            GlassFrameThickness="0"
                            UseAeroCaptionButtons="False"/>
    </shell:WindowChrome.WindowChrome>
    <Border BorderBrush="#FF007ACC" BorderThickness="1" Background="#FF2D2D30" CornerRadius="0">
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="*"/>
            </Grid.RowDefinitions>
            <Border x:Name="CustomTitleBar" Grid.Row="0" Background="#FF252526" Height="30" CornerRadius="0,0,0,0">
                <Grid>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>
                    <TextBlock Text="CivitAI Text Decoder" VerticalAlignment="Center" HorizontalAlignment="Left" Margin="10,0,0,0" Foreground="White" FontWeight="SemiBold"/>
                    <Button x:Name="MinimizeButton" Grid.Column="1" Content="_" Width="40" Height="30"
                            shell:WindowChrome.IsHitTestVisibleInChrome="True">
                        <Button.Style>
                            <Style TargetType="Button">
                                <Setter Property="Background" Value="#FF252526"/>
                                <Setter Property="Foreground" Value="White"/>
                                <Setter Property="BorderThickness" Value="0"/>
                                <Setter Property="Template">
                                    <Setter.Value>
                                        <ControlTemplate TargetType="Button">
                                            <Border Background="{TemplateBinding Background}">
                                                <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                            </Border>
                                        </ControlTemplate>
                                    </Setter.Value>
                                </Setter>
                                <Style.Triggers>
                                    <Trigger Property="IsMouseOver" Value="True">
                                        <Setter Property="Background" Value="#FF4F4F53"/>
                                    </Trigger>
                                </Style.Triggers>
                            </Style>
                        </Button.Style>
                    </Button>
                    <Button x:Name="CloseButton" Grid.Column="2" Content="✕" Width="40" Height="30"
                            shell:WindowChrome.IsHitTestVisibleInChrome="True">
                        <Button.Style>
                            <Style TargetType="Button">
                                <Setter Property="Background" Value="#FF252526"/>
                                <Setter Property="Foreground" Value="White"/>
                                <Setter Property="BorderThickness" Value="0"/>
                                <Setter Property="Template">
                                    <Setter.Value>
                                        <ControlTemplate TargetType="Button">
                                            <Border Background="{TemplateBinding Background}">
                                                <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                            </Border>
                                        </ControlTemplate>
                                    </Setter.Value>
                                </Setter>
                                <Style.Triggers>
                                    <Trigger Property="IsMouseOver" Value="True">
                                        <Setter Property="Background" Value="#FFE81123"/>
                                    </Trigger>
                                </Style.Triggers>
                            </Style>
                        </Button.Style>
                    </Button>
                </Grid>
            </Border>
            <Grid Grid.Row="1" Margin="10">
                <Grid.Resources>
                    <Style x:Key="ActionButtonStyle" TargetType="Button">
                        <Setter Property="Background" Value="#FF007ACC"/>
                        <Setter Property="Foreground" Value="White"/>
                        <Setter Property="BorderThickness" Value="0"/>
                        <Setter Property="FontWeight" Value="Bold"/>
                        <Setter Property="Padding" Value="10,7"/>
                        <Setter Property="Margin" Value="5,15,5,5"/>
                        <Setter Property="Height" Value="60"/>
                        <Setter Property="Template">
                            <Setter.Value>
                                <ControlTemplate TargetType="Button">
                                    <Border Background="{TemplateBinding Background}" CornerRadius="2">
                                        <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                    </Border>
                                    <ControlTemplate.Triggers>
                                        <Trigger Property="IsMouseOver" Value="True">
                                            <Setter Property="Background" Value="#FF005A9E"/>
                                        </Trigger>
                                        <Trigger Property="IsPressed" Value="True">
                                            <Setter Property="Background" Value="#FF004C87"/>
                                        </Trigger>
                                    </ControlTemplate.Triggers>
                                </ControlTemplate>
                            </Setter.Value>
                        </Setter>
                    </Style>
                    <Style x:Key="CopyButtonStyle" TargetType="Button">
                        <Setter Property="Background" Value="#FF3E3E42"/>
                        <Setter Property="Foreground" Value="White"/>
                        <Setter Property="BorderBrush" Value="#FF007ACC"/>
                        <Setter Property="BorderThickness" Value="1"/>
                        <Setter Property="Padding" Value="8,3"/>
                        <Setter Property="Margin" Value="5,5,0,5"/>
                        <Setter Property="VerticalContentAlignment" Value="Center"/>
                        <Setter Property="Template">
                            <Setter.Value>
                                <ControlTemplate TargetType="Button">
                                    <Border Background="{TemplateBinding Background}"
                                            BorderBrush="{TemplateBinding BorderBrush}"
                                            BorderThickness="{TemplateBinding BorderThickness}"
                                            CornerRadius="2">
                                        <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                    </Border>
                                    <ControlTemplate.Triggers>
                                        <Trigger Property="IsMouseOver" Value="True">
                                            <Setter Property="Background" Value="#FF4F4F53"/>
                                        </Trigger>
                                        <Trigger Property="IsPressed" Value="True">
                                            <Setter Property="Background" Value="#FF007ACC"/>
                                        </Trigger>
                                    </ControlTemplate.Triggers>
                                </ControlTemplate>
                            </Setter.Value>
                        </Setter>
                    </Style>
                </Grid.Resources>
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="150"/>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="150"/>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="Auto"/>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                <Label Content="Corrupted Text:" Grid.Row="0" Grid.Column="0" VerticalAlignment="Center" Foreground="White" Margin="0,0,10,0"/>
                <TextBox Name="TextBoxInputText" Grid.Row="1" Grid.Column="0" Grid.ColumnSpan="3" Margin="5" Padding="5" Background="#FF3E3E42" Foreground="White" BorderBrush="#FF007ACC" AcceptsReturn="True" AcceptsTab="False" VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Auto" TextWrapping="Wrap" Text="Paste text here...">
                    <TextBox.Style>
                        <Style TargetType="TextBox">
                            <Setter Property="Foreground" Value="#808080"/>
                            <Style.Triggers>
                                <Trigger Property="IsFocused" Value="True">
                                    <Setter Property="Foreground" Value="White"/>
                                </Trigger>
                            </Style.Triggers>
                        </Style>
                    </TextBox.Style>
                </TextBox>
                <Label Content="Decoded Text:" Grid.Row="2" Grid.Column="0" VerticalAlignment="Center" Foreground="White" Margin="0,0,10,0"/>
                <TextBox Name="TextBoxOutputText" Grid.Row="3" Grid.Column="0" Grid.ColumnSpan="3" Margin="5" Padding="5" Background="#FF2D2D30" Foreground="White" BorderBrush="#FF007ACC" AcceptsReturn="True" AcceptsTab="False" VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Auto" TextWrapping="Wrap" IsReadOnly="True"/>
                <Button Name="ButtonCopyText" Grid.Row="4" Grid.Column="2" Content="Copy Text" Style="{StaticResource ActionButtonStyle}" Height="32" Width="80"/>
                <Button Name="ButtonDecodeText" Grid.Row="5" Grid.Column="0" Grid.ColumnSpan="3" Content="Decode Text" Style="{StaticResource ActionButtonStyle}"/>
            </Grid>
            <Grid x:Name="ResizeGripVisual" Grid.Row="1" HorizontalAlignment="Right" VerticalAlignment="Bottom" Width="18" Height="18" Margin="0,0,0,0" IsHitTestVisible="False">
                <Path Stroke="#888888" StrokeThickness="1.5">
                    <Path.Data>
                        <LineGeometry StartPoint="5,13" EndPoint="13,5"/>
                    </Path.Data>
                </Path>
                <Path Stroke="#888888" StrokeThickness="1.5">
                    <Path.Data>
                        <LineGeometry StartPoint="9,13" EndPoint="13,9"/>
                    </Path.Data>
                </Path>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

# Load XAML
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
try {
    $Global:Window = [Windows.Markup.XamlReader]::Load($reader)
} catch {
    Write-Error "Error loading XAML: $($_.Exception.Message)"
    Write-Host "--- XAML Content ---"; Write-Host $xaml; Write-Host "--- End XAML Content ---"
    exit 1
}

# Find controls
$CloseButton = $Global:Window.FindName("CloseButton")
$MinimizeButton = $Global:Window.FindName("MinimizeButton")
$TextBoxInputText = $Global:Window.FindName("TextBoxInputText")
$TextBoxOutputText = $Global:Window.FindName("TextBoxOutputText")
$ButtonCopyText = $Global:Window.FindName("ButtonCopyText")
$ButtonDecodeText = $Global:Window.FindName("ButtonDecodeText")

# Temporary Text
$placeholderText = "Paste text here..."
if ($TextBoxInputText.Text -eq $placeholderText) {
    $TextBoxInputText.Foreground = [System.Windows.Media.Brushes]::Gray
}

$TextBoxInputText.Add_GotFocus({
    if ($TextBoxInputText.Text -eq $placeholderText) {
        $TextBoxInputText.Text = ""
        $TextBoxInputText.Foreground = [System.Windows.Media.Brushes]::White
    }
})

$TextBoxInputText.Add_LostFocus({
    if ([string]::IsNullOrWhiteSpace($TextBoxInputText.Text)) {
        $TextBoxInputText.Text = $placeholderText
        $TextBoxInputText.Foreground = [System.Windows.Media.Brushes]::Gray
    }
})

# Button event handlers
$CloseButton.Add_Click({
    $Global:Window.Close()
})

$MinimizeButton.Add_Click({
    $Global:Window.WindowState = 'Minimized'
})

$ButtonDecodeText.Add_Click({
    $inputText = $TextBoxInputText.Text.Trim()
    if ([string]::IsNullOrWhiteSpace($inputText) -or $inputText -eq $placeholderText) {
        Show-MessageBox -Message "Please enter corrupted text to decode." -Type "Error"
        return
    }
    try {
        # Convert the corrupted text to bytes using ISO-8859-1 encoding
        $iso8859Bytes = [System.Text.Encoding]::GetEncoding("ISO-8859-1").GetBytes($inputText)
        # Convert those bytes back to a string using UTF-8 encoding
        $correctedText = [System.Text.Encoding]::UTF8.GetString($iso8859Bytes)
        $TextBoxOutputText.Text = $correctedText
    } catch {
        Show-MessageBox -Message "Error decoding text: $_" -Type "Error"
        $TextBoxOutputText.Text = ""
    }
})

$ButtonCopyText.Add_Click({
    if (-not [string]::IsNullOrWhiteSpace($TextBoxOutputText.Text)) {
        try {
            [System.Windows.Clipboard]::SetText($TextBoxOutputText.Text)
            Show-MessageBox -Message "Decoded text copied to clipboard." -Type "Info"
        } catch {
            Show-MessageBox -Message "Error copying text to clipboard: $_" -Type "Error"
        }
    } else {
        Show-MessageBox -Message "No decoded text to copy." -Type "Error"
    }
})

# Show GUI
$Global:Window.ShowDialog() | Out-Null