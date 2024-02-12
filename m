Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D346C4829B
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 10:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B103110EBCA;
	Mon, 12 Feb 2024 10:11:18 +0000 (UTC)
X-Greylist: delayed 461 seconds by postgrey-1.36 at gabe;
 Mon, 12 Feb 2024 10:11:17 UTC
Received: from mx0-45.i-mecca.net (mx0-45.i-mecca.net [76.74.184.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D0610EBBC
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 10:11:17 +0000 (UTC)
Received: from ns14.i-mecca.net (unknown [192.168.1.14])
 by mx0.i-mecca.net (Postfix) with ESMTPS id 4AA8A161E34
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 02:03:27 -0800 (PST)
Received: by ns14.i-mecca.net (Postfix) with ESMTPSA id A402080045
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 02:03:25 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------04nRxjUiPyqtTvJE70CLTL8s"
Message-ID: <6dbb4988-5a8e-4c7f-bb52-9bff82e6f227@fedoraproject.org>
Date: Mon, 12 Feb 2024 02:03:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-CA
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
From: Luya Tshimbalanga <luya@fedoraproject.org>
Subject: Blank screen after enabling amdgpu.seamless on a Barcelo APU
Autocrypt: addr=luya@fedoraproject.org; keydata=
 xsBNBGMWJsUBCADH0In1PH3XhTfqoAwz0PVMlP6Kxk0fy5pu8LOijwplSvitKm3hhHXyd1vK
 fiPObGIdsuwB5q8ed/zdBVh38s64pOKs6RusnnNjiCKmqvafVW96+AzpbXZwjiZ/ZpVl+PcU
 B6N7oBJ+lRJDXRCZjFyW0hstNy4QSu+zLD1s+Y02Av2BO4e+EnN8DcDaCRP0H6CkZEE+8yox
 t+BfnU5DaqUOHLOcVWhboBKF42f7Qzlt4p7G051aHo0JE5622w/jWLFz2dFazRMdK2F2+mkF
 WHUZQSm3lUk2O6mSNtSv7eHHt0s+bnLgEEP3DVPjCUGzTRQhxBoW+cUB3UScULg0WdUpABEB
 AAHNXEx1eWEgVHNoaW1iYWxhbmdhIChDb250cmlidXRvciBzcGVjaWFsaXplZCBpbiBkZXNp
 Z24gYW5kIHBhY2thZ2luZykgPGx1eWFAZmVkb3JhcHJvamVjdC5vcmc+wsCRBBMBCAA7FiEE
 1zcffSlQ2CQ074hlUpmCwmgvVIQFAmMWJsUCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQUpmCwmgvVIRayQgAt3B0OUUgcJXoBhvh/IekwimwBlqAys2m7PBeb6z8JGPOa2jD
 GA8xrRdrZs8zskiO3oanTv+8QvdJKlh5qrhNyoxBCDmQEKlyY4iLYSzB1WEZ28MT4OKYXdbx
 Q8RNSMvoME4EMfkN9r5VmSfbLVfPFB3HHlSAODwyXiLgNVMRPK1poXme8JHXfbFyhyXRElST
 ddAyb8qrs3/eN9E+bVBM8vH9fC5KWH/2qwXRClk3tZeF5VLKEVbHTLrGotW+JFOcUWevpS/S
 v1BNaqW3AM/WQ1D6Mj348IZxJxs/PtVWAVLxeHf/tNsArkYwJ04vGdRPDgOyQ0kHuO+OJ4+/
 Zxmk087ATQRjFibFAQgAlwRqpXl8moY7UXLiuFtIwn2pqVWlU7BE8vA9Zbh9zrXraTBbKjDk
 LJMEuB6S86h28+4WdqztAcZx0QScU4Z1wCNypTTSQvREEzFHMNoWIGjbbuZaMXstMUUnP79/
 ZyJpa2iXdfz6xwiaq3mp5j+ywxoyLfXV4BV7OVI17dOqsoUToX/ZQ9zHt1pMze1KFzHpdFMZ
 X9znFYHXLykMEsX5/NaKw5zPGRtlswk6xtxc9E43+6+ZP/gi+HLVGE3ZTAn+QfTWaC4khWwo
 2Mq4vyXh+ehHubhF/8xZeGcGrs3j6+6Hsp71KaikOhBuaFoRwiHvp+zck7qq8IKSIl3hD2XD
 GQARAQABwsB2BBgBCAAgFiEE1zcffSlQ2CQ074hlUpmCwmgvVIQFAmMWJsUCGwwACgkQUpmC
 wmgvVIS/Awf/fexbF5yKyvwG4Cd5W8T5bqusUg5p/tIoCuRwVnpt+IQWZydoZPeAhC/dNw7i
 Vq0r+nob0lWpbVYXIqkUW5NwNBRoQjDvLhtMCDdFL+0bJ3u5Ib4TPRpvB+7Uh/jRdfrjPFbn
 MUnjK849fWrLjJplOVYjb1tCo/v5LSg1TFZGlSnGqwDaKaYsKHXOQh924qI6Kp/q+2uN9eqY
 EDQUP39iWlPCT7bRS61Mw90yk4cM+tsBEa5Vh1n+nnPdZIYO+qeRdr/OEe9hDEgIJePnv4nh
 LP5a+B6ewexrEYz+X2+Y6Rs0Z2Krq+dfYjnV6IMkpeKHdZueXNSbtuEcqDBxG9qsFw==
Organization: Fedora Project
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------04nRxjUiPyqtTvJE70CLTL8s
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello team,

Testing "amdgpu.seamless=1" on Ryzen 7 5825u using kernel 6.7.4 led to a 
blank screen after the initial boot screen as tested on Dell Inc. 
Inspiron 14 7425 2-in-1 with the following message from boot:

"Feb 11 13:43:37 kernel: amdgpu 0000:04:00.0: [drm] *ERROR* 
[CRTC:73:crtc-0] flip_done timed out"


Here is the journalctl report sorted by amdgpu:

'''

journalctl -b -2 --no-hostname | grep amdgpu
Feb 11 13:43:14 kernel: Command line: 
root=UUID=b8250ad0-059a-4eb7-893d-9757e1c0599d ro rootflags=subvol=root 
rhgb quiet amdgpu.seamless=1 
root=UUID=b8250ad0-059a-4eb7-893d-9757e1c0599d ro rootflags=subvol=root 
rhgb quiet
Feb 11 13:43:14 kernel: Kernel command line: 
root=UUID=b8250ad0-059a-4eb7-893d-9757e1c0599d ro rootflags=subvol=root 
rhgb quiet amdgpu.seamless=1 
root=UUID=b8250ad0-059a-4eb7-893d-9757e1c0599d ro rootflags=subvol=root 
rhgb quiet
Feb 11 13:43:14 dracut-cmdline[398]: Using kernel command line 
parameters:  rd.driver.pre=btrfs 
root=UUID=b8250ad0-059a-4eb7-893d-9757e1c0599d ro rootflags=subvol=root 
rhgb quiet amdgpu.seamless=1 
root=UUID=b8250ad0-059a-4eb7-893d-9757e1c0599d ro rootflags=subvol=root 
rhgb quiet
Feb 11 13:43:16 kernel: [drm] amdgpu kernel modesetting enabled.
Feb 11 13:43:16 kernel: amdgpu: Virtual CRAT table created for CPU
Feb 11 13:43:16 kernel: amdgpu: Topology: Add CPU node
Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: enabling device (0006 -> 0007)
Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS from VFCT
Feb 11 13:43:16 kernel: amdgpu: ATOM BIOS: 113-BARCELO-003
Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: vgaarb: deactivate vga console
Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: Trusted Memory Zone 
(TMZ) feature enabled
Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: MODE2 reset
Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: VRAM: 2048M 
0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: GART: 1024M 
0x0000000000000000 - 0x000000003FFFFFFF
Feb 11 13:43:16 kernel: [drm] amdgpu: 2048M of VRAM memory ready
Feb 11 13:43:16 kernel: [drm] amdgpu: 14960M of GTT memory ready.
Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: Will use PSP to 
load VCN firmware
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: RAS: optional ras 
ta ucode is not available
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: RAP: optional rap 
ta ucode is not available
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: SECUREDISPLAY: 
securedisplay ta ucode is not available
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: SMU is initialized 
successfully!
Feb 11 13:43:17 kernel: amdgpu: HMM registered 2048MB device memory
Feb 11 13:43:17 kernel: kfd kfd: amdgpu: Allocated 3969056 bytes on gart
Feb 11 13:43:17 kernel: kfd kfd: amdgpu: Total number of KFD nodes to be 
created: 1
Feb 11 13:43:17 kernel: amdgpu: Virtual CRAT table created for GPU
Feb 11 13:43:17 kernel: amdgpu: Topology: Add dGPU node [0x15e7:0x1002]
Feb 11 13:43:17 kernel: kfd kfd: amdgpu: added device 1002:15e7
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: SE 1, SH per SE 1, 
CU per SH 8, active_cu_number 8
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring gfx uses VM 
inv eng 0 on hub 0
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring gfx_low uses 
VM inv eng 1 on hub 0
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring gfx_high uses 
VM inv eng 4 on hub 0
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 
uses VM inv eng 5 on hub 0
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 
uses VM inv eng 6 on hub 0
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 
uses VM inv eng 7 on hub 0
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 
uses VM inv eng 8 on hub 0
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 
uses VM inv eng 9 on hub 0
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 
uses VM inv eng 10 on hub 0
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 
uses VM inv eng 11 on hub 0
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 
uses VM inv eng 12 on hub 0
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring kiq_0.2.1.0 
uses VM inv eng 13 on hub 0
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM 
inv eng 0 on hub 8
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_dec uses 
VM inv eng 1 on hub 8
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0 uses 
VM inv eng 4 on hub 8
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_enc1 uses 
VM inv eng 5 on hub 8
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec uses 
VM inv eng 6 on hub 8
Feb 11 13:43:17 kernel: [drm] Initialized amdgpu 3.57.0 20150101 for 
0000:04:00.0 on minor 1
Feb 11 13:43:17 kernel: fbcon: amdgpudrmfb (fb0) is primary device
Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: [drm] fb0: amdgpudrmfb 
frame buffer device
Feb 11 13:43:20 systemd[1]: Starting 
systemd-backlight@backlight:amdgpu_bl1.service - Load/Save Screen 
Backlight Brightness of backlight:amdgpu_bl1...
Feb 11 13:43:20 systemd[1]: Finished 
systemd-backlight@backlight:amdgpu_bl1.service - Load/Save Screen 
Backlight Brightness of backlight:amdgpu_bl1.
Feb 11 13:43:20 audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 
ses=4294967295 subj=system_u:system_r:init_t:s0 
msg='unit=systemd-backlight@backlight:amdgpu_bl1 comm="systemd" 
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Feb 11 13:43:20 kernel: snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 
(ops amdgpu_dm_audio_component_bind_ops [amdgpu])
Feb 11 13:43:25 gnome-shell[1539]: Added device '/dev/dri/card1' 
(amdgpu) using atomic mode setting.
Feb 11 13:43:37 kernel: amdgpu 0000:04:00.0: [drm] *ERROR* 
[CRTC:73:crtc-0] flip_done timed out
'''

Should I submit the issue to the kernel bug report or here?

-- 
Luya Tshimbalanga
Fedora Design Team
Fedora Design Suite maintainer

--------------04nRxjUiPyqtTvJE70CLTL8s
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html data-lt-installed="true">
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <p>Hello team,</p>
    <p>Testing "amdgpu.seamless=1" on Ryzen 7 5825u using kernel 6.7.4
      led to a blank screen after the initial boot screen as tested on
      Dell Inc. Inspiron 14 7425 2-in-1 with the following message from
      boot:</p>
    <p>"Feb 11 13:43:37 kernel: amdgpu 0000:04:00.0: [drm] *ERROR*
      [CRTC:73:crtc-0] flip_done timed out"</p>
    <p><br>
    </p>
    <p>Here is the journalctl report sorted by amdgpu:</p>
    <p>'''</p>
    <p>journalctl -b -2 --no-hostname | grep amdgpu<br>
      Feb 11 13:43:14 kernel: Command line:
      root=UUID=b8250ad0-059a-4eb7-893d-9757e1c0599d ro
      rootflags=subvol=root rhgb quiet amdgpu.seamless=1
      root=UUID=b8250ad0-059a-4eb7-893d-9757e1c0599d ro
      rootflags=subvol=root rhgb quiet<br>
      Feb 11 13:43:14 kernel: Kernel command line:
      root=UUID=b8250ad0-059a-4eb7-893d-9757e1c0599d ro
      rootflags=subvol=root rhgb quiet amdgpu.seamless=1
      root=UUID=b8250ad0-059a-4eb7-893d-9757e1c0599d ro
      rootflags=subvol=root rhgb quiet<br>
      Feb 11 13:43:14 dracut-cmdline[398]: Using kernel command line
      parameters:  rd.driver.pre=btrfs  
      root=UUID=b8250ad0-059a-4eb7-893d-9757e1c0599d ro
      rootflags=subvol=root rhgb quiet amdgpu.seamless=1
      root=UUID=b8250ad0-059a-4eb7-893d-9757e1c0599d ro
      rootflags=subvol=root rhgb quiet<br>
      Feb 11 13:43:16 kernel: [drm] amdgpu kernel modesetting enabled.<br>
      Feb 11 13:43:16 kernel: amdgpu: Virtual CRAT table created for CPU<br>
      Feb 11 13:43:16 kernel: amdgpu: Topology: Add CPU node<br>
      Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: enabling device (0006
      -&gt; 0007)<br>
      Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS
      from VFCT<br>
      Feb 11 13:43:16 kernel: amdgpu: ATOM BIOS: 113-BARCELO-003<br>
      Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: vgaarb: deactivate
      vga console<br>
      Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: Trusted
      Memory Zone (TMZ) feature enabled<br>
      Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: MODE2 reset<br>
      Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: VRAM: 2048M
      0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)<br>
      Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: GART: 1024M
      0x0000000000000000 - 0x000000003FFFFFFF<br>
      Feb 11 13:43:16 kernel: [drm] amdgpu: 2048M of VRAM memory ready<br>
      Feb 11 13:43:16 kernel: [drm] amdgpu: 14960M of GTT memory ready.<br>
      Feb 11 13:43:16 kernel: amdgpu 0000:04:00.0: amdgpu: Will use PSP
      to load VCN firmware<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: RAS: optional
      ras ta ucode is not available<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: RAP: optional
      rap ta ucode is not available<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu:
      SECUREDISPLAY: securedisplay ta ucode is not available<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: SMU is
      initialized successfully!<br>
      Feb 11 13:43:17 kernel: amdgpu: HMM registered 2048MB device
      memory<br>
      Feb 11 13:43:17 kernel: kfd kfd: amdgpu: Allocated 3969056 bytes
      on gart<br>
      Feb 11 13:43:17 kernel: kfd kfd: amdgpu: Total number of KFD nodes
      to be created: 1<br>
      Feb 11 13:43:17 kernel: amdgpu: Virtual CRAT table created for GPU<br>
      Feb 11 13:43:17 kernel: amdgpu: Topology: Add dGPU node
      [0x15e7:0x1002]<br>
      Feb 11 13:43:17 kernel: kfd kfd: amdgpu: added device 1002:15e7<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: SE 1, SH per
      SE 1, CU per SH 8, active_cu_number 8<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring gfx uses
      VM inv eng 0 on hub 0<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring gfx_low
      uses VM inv eng 1 on hub 0<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring gfx_high
      uses VM inv eng 4 on hub 0<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring
      comp_1.0.0 uses VM inv eng 5 on hub 0<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring
      comp_1.1.0 uses VM inv eng 6 on hub 0<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring
      comp_1.2.0 uses VM inv eng 7 on hub 0<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring
      comp_1.3.0 uses VM inv eng 8 on hub 0<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring
      comp_1.0.1 uses VM inv eng 9 on hub 0<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring
      comp_1.1.1 uses VM inv eng 10 on hub 0<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring
      comp_1.2.1 uses VM inv eng 11 on hub 0<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring
      comp_1.3.1 uses VM inv eng 12 on hub 0<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring
      kiq_0.2.1.0 uses VM inv eng 13 on hub 0<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring sdma0
      uses VM inv eng 0 on hub 8<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_dec
      uses VM inv eng 1 on hub 8<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0
      uses VM inv eng 4 on hub 8<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_enc1
      uses VM inv eng 5 on hub 8<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec
      uses VM inv eng 6 on hub 8<br>
      Feb 11 13:43:17 kernel: [drm] Initialized amdgpu 3.57.0 20150101
      for 0000:04:00.0 on minor 1<br>
      Feb 11 13:43:17 kernel: fbcon: amdgpudrmfb (fb0) is primary device<br>
      Feb 11 13:43:17 kernel: amdgpu 0000:04:00.0: [drm] fb0:
      amdgpudrmfb frame buffer device<br>
      Feb 11 13:43:20 systemd[1]: Starting
      <a class="moz-txt-link-abbreviated" href="mailto:systemd-backlight@backlight:amdgpu_bl1.service">systemd-backlight@backlight:amdgpu_bl1.service</a> - Load/Save Screen
      Backlight Brightness of backlight:amdgpu_bl1...<br>
      Feb 11 13:43:20 systemd[1]: Finished
      <a class="moz-txt-link-abbreviated" href="mailto:systemd-backlight@backlight:amdgpu_bl1.service">systemd-backlight@backlight:amdgpu_bl1.service</a> - Load/Save Screen
      Backlight Brightness of backlight:amdgpu_bl1.<br>
      Feb 11 13:43:20 audit[1]: SERVICE_START pid=1 uid=0
      auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
      msg='unit=systemd-backlight@backlight:amdgpu_bl1 comm="systemd"
      exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
      res=success'<br>
      Feb 11 13:43:20 kernel: snd_hda_intel 0000:04:00.1: bound
      0000:04:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])<br>
      Feb 11 13:43:25 gnome-shell[1539]: Added device '/dev/dri/card1'
      (amdgpu) using atomic mode setting.<br>
      Feb 11 13:43:37 kernel: amdgpu 0000:04:00.0: [drm] *ERROR*
      [CRTC:73:crtc-0] flip_done timed out<br>
      '''</p>
    <p>Should I submit the issue to the kernel bug report or here?<br>
    </p>
    <pre class="moz-signature" cols="72">-- 
Luya Tshimbalanga
Fedora Design Team
Fedora Design Suite maintainer</pre>
    <div id="grammalecte_menu_main_button_shadow_host"
      style="width: 0px; height: 0px;"></div>
  </body>
  <lt-container></lt-container>
</html>

--------------04nRxjUiPyqtTvJE70CLTL8s--
