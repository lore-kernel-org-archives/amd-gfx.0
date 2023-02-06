Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4607CC05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 13:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF86010E3D3;
	Mon,  6 Feb 2023 13:54:31 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F104310E3D3
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 13:54:29 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 l37-20020a05600c1d2500b003dfe46a9801so7366789wms.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 05:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:in-reply-to:to:references:date:subject:mime-version
 :content-transfer-encoding:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dxf4HfJKduzzgqHsJBjeZGtQhsVexTCqX4bf7SXzEPs=;
 b=SeLI8YhBbHGHvY0nqXlPgdS/DVYSqCjRIK/So5DCYe+GE3YybMbPpxXKVw7AiTWQC1
 FZKvJiwlXPfBoh8Zus6P7OU6erKHTLjj3nbrXqQeDaXbkQpLHxksapWNCFqs5hqVEIrE
 LxoDy6a0+/mfT5FAtgdEliM36Yqc/9OuPBzALdu2c1LpH87lxs6qQujf7d21QXO1lEFE
 Cdv6UVgR0nWPdLbUbDXriZmqhSviuSkEA5pcopA/1QmV25Anrxcro474hZa/p06O0gkW
 CsEU8WF4P80xFduUGnIGjAdnajH0HdDCEYzqkplrV0ZC6P0GtpluTnOeUmut0j754Vw8
 uV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=message-id:in-reply-to:to:references:date:subject:mime-version
 :content-transfer-encoding:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dxf4HfJKduzzgqHsJBjeZGtQhsVexTCqX4bf7SXzEPs=;
 b=b2Qisx0ZAxTw0qxNPVWnXx9mprIhqnNA3/1MSjKfztxibSyiWK4x4X0Rp7GEW2bhCJ
 JSU/tF1kQGXOZZqZpWQCXs6439FrFIj1R4KidCfUXOMH+Kc5pKxuxvdVjoWzUx+ZYXc2
 j1Pf1fHiQE3lNAcFXs95FigCYJ45dTZwPd21ZFkzwT3auNGraVAt1XJWtmGSwrUMaE5e
 3RSnB31lkDX5SdkLHnZX76WB9dn1E2YgfSl5iLO+mPi+iI7RC3juxr74DF/uDvul055f
 I/eyjYfX5P/S4PYOpfpoyz+dzdCNOXRrQha8MP1AngysG2gHCREfY2DjzUANMYh1oEvx
 9MEA==
X-Gm-Message-State: AO0yUKWAlyZZ/V6OxayulnZ0SirBqoQHxalWxbJyTk6Guba6rrf/HeyL
 npYKDS45g1cH9yrRpZMI3bStq96m9Pb7Kg==
X-Google-Smtp-Source: AK7set+10E47wZeHs7r32is88RHRKmUZI2zaJx6akGoj4lniaScjde9tpKNZ0fZIn4t6HfreF9LgFg==
X-Received: by 2002:a05:600c:4707:b0:3df:e6bb:768 with SMTP id
 v7-20020a05600c470700b003dfe6bb0768mr11691142wmo.24.1675691667319; 
 Mon, 06 Feb 2023 05:54:27 -0800 (PST)
Received: from smtpclient.apple ([62.74.55.124])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a05600c198600b003dc492e4430sm11514432wmq.28.2023.02.06.05.54.26
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Feb 2023 05:54:26 -0800 (PST)
From: "Visual (VisualDevelopment)" <drherocrafterslab@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: Patched macOS kexts start Raven iGPU, but GPUVM page fault occurs
 on the first GFX and SDMA IB submitted by WindowServer. Help?
Date: Mon, 6 Feb 2023 15:54:15 +0200
References: <A3DBE2A9-F115-4D3B-AFCD-F1AA8FDB5A36@gmail.com>
To: amd-gfx@lists.freedesktop.org
In-Reply-To: <A3DBE2A9-F115-4D3B-AFCD-F1AA8FDB5A36@gmail.com>
Message-Id: <03712C79-9F78-4057-9C04-A7E98250E954@gmail.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
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

While simply waiting for a reply to the email was an attractive option, =
we chose to investigate other parts of the code during the last three =
days.

More precisely, we investigated =
_mmhub_1_0_update_medium_grain_clock_gating and seemed to have =
discovered a register offset mismatch. However, we soon found that the =
HWIP discovery code automatically applies Raven-specific fixes to the =
offset. Therefore, the behaviour is correct in the end.
We also thought of running the WhateverRed kext on a Vega machine to see =
how the kext behaves differently on a dGPU with similar architecture. =
The problem is that we need a tester who owns a Vega card to do that. =
Nyan Cat sent a message to seek assistance on the AMD OS X server but =
got no reply. In the meantime, Visual asked if his friend, who owns a =
Vega card,  were willing to help. However, he also received no response =
to this date.

We realise that we started the thread at an odd time (Saturday) and with =
an unformatted subject, not to mention a few typos we noticed right =
after sending the email. We hope that these flaws won't seize your =
interest in the project.

> On 4 Feb 2023, at 13:24, Visual (VisualDevelopment) =
<drherocrafterslab@gmail.com> wrote:
>=20
> Table of Contents:
> 1. Introduction
> 2. History of WhateverRed
>    2.1. Wrapping/Redirecting kext logic with Lilu
>    2.2. VTables and our Reverse Engineering
>    2.3. Debugging with a black screen
>    2.4. Firmware injection and other HWLibs troubles
>    2.5. AMDRadeonX5000 Video Decoding/Encoding and SDMA engine =
mismatches
>    2.6. SDMA0 power on via SMC
>    2.7. SDMA0 Accel channel skipping memory mapping commands
> 3. Current issue
>    3.1. VM Protection Faults
>    3.2. Analysis of the diagnostic dump
>    3.3. A deeper dive into the protection fault
> 4. What we know so far
>    4.1. The VM Blocks and the PDEs/PTEs
>    4.2. The VM registers
>    4.3. The PDE/PTE flags
>    4.4. The translate_further mode
>    4.5. The VMPTConfig in AMD kexts
>    4.6. How the entryCount is determined on AMDGPU
>    4.7. The GPUVM settings on AMDRadeonX5000 vs. AMDGPU
> 5. What we have tried
>    5.1. PTE/PDE flags experimentations
>    5.2. Experimentation with VMPTConfig and related settings
> 6. How you can help
>    6.1. Unanswered questions
>    6.2. Ways to contact us
>=20
>=20
> -- 1. Introduction --
> Hello everyone.
> We are a small team of 3 people trying to get Hackintoshes (PCs =
running macOS) with AMD (Vega) iGPUs (specifically Raven/Raven2/Renoir =
and their derivatives, such as Picasso) to have graphics acceleration on =
AMD laptops.
> To be precise, we are fixing broken and/or missing logic via patching =
the existing kexts (currently AMDRadeonX5000 for GCN 5 (GFX 9) and =
AMDRadeonX6000 for VCN (GFX 10), AMDRadeonX6000Framebuffer for DCN =
instead of AMD10000Controller since it is DCE).
>=20
> The team members are:
> - Visual, the Project Owner, is a Greek 17 year old CS student with =
extensive knowledge on Operating System development. He writes most of =
the kext code and provides insight on OS and Driver behaviour when =
possible.
> - NyanCatTW1, the Automation Engineer, is a 17-year-old student who =
lives in Taiwan. The NYCU CSIE admitted him last year. He also does most =
of the Reverse Engineering.
> - Allen Chen, the tester with a Renoir laptop, perseverance and some =
ideas; helps with the effort occasionally, currently striving to become =
NyanCatTW1's classmate again, as they were six years ago
>=20
> Our kext, WhateverRed has successfully gotten the aforesaid kexts to =
deterministically power up and start the IPs/MEs in the GPU, such as GFX =
and SDMA. Attached are partial highlights of a dmesg log from the main =
testing system:
>=20
>    [   27.351538]: netdbg: Disabled via boot arg
>    [   27.351543]: rad: patching device type table
>    [   27.351558]: rad: Automagically getting VBIOS from VFCT table
>    ...
>    [   27.505319]: [3:0:0] [Accel] >>> Calling TTL::initialize()
>    [   27.505331]: [AMD INFO] TTL Interface: Boot mode Normal.
>    ...
>    [   27.649777]: [3:0:0] [Accel] <<< TTL::initialize() Completed =
successfully.
>    ...
>    [   27.662027]: Accelerator successfully registered with =
controller.
>    ...
>    [   29.346963]: rad: _SmuRaven_Initialize returned 0x1
>    [   29.346967]: rad: Sending PPSMC_MSG_PowerUpSdma (0xE) to the SMC
>    [   29.347052]: rad: _Raven_SendMsgToSmcWithParameter returned 0x1
>    ...
>    [   29.365343]: rad: powerUpHW: this =3D 0xffffff935ca3d000
>    [   29.377219]: rad: powerUpHW returned 1
>    [   29.377228]: [3:0:0]: Controller is enabled, finish =
initialization
>    [   29.424252]: Adding AGDP mode validate property
>    [   29.425160]: kPEDisableScreen 1
>    [   29.425685]: [3:0:0] [FB:0] =
AmdRadeonFramebuffer::setCursorImage() !!! Driver is offline.
>    [   29.425695]: [3:0:0] [FB:1] =
AmdRadeonFramebuffer::setCursorImage() !!! Driver is offline.
>=20
>=20
> The project is hosted on GitHub =
(https://github.com/NootInc/WhateverRed) with 135 stargazers as of =
2023-02-04.
>=20
> Currently, everything seems to go smoothly up to the point =
WindowServer tries -and fails- to make use of the iGPU (See Chapter 3 =
for details)
> We first ran into the issue on 2022-11-27, but as of 2023-02-04, we =
haven't been able to find a way to fix it.
> This is why we're asking for help on the amd-gfx mailing list. =
However, considering the complexity of both the project and the issue, =
we suspect it would be necessary to give you a brief review of the =
project's history, the issue we currently are facing, everything we know =
about the issue, and what we have tried first.
> It'll be a long ride (about 25 minutes) so feel free to skip right to =
Chapter 6 if you don't have the time.
>=20
> -- 2. History of WhateverRed --
> For your interest, we have documented a large portion of our previous =
work here. But feel free to skip to the problem itself (Chapter 3) in =
case that's more practical for you.
>=20
>=20
> -- 2.1 Wrapping/Redirecting kext logic with Lilu --
> First of all, it is quite probable that you are wondering how we are =
even debugging these kexts, even modifying them; the answer is Lilu. =
Lilu allows you to hook symbols and replace them with your own logic, =
and also save the original to a different place. This is done possible =
by looking for the symbol, saving the original logic, and replacing the =
instructions in the original location with a trampoline to our hook. =
Here is an example log:
>    [   36.334082]: rad: hwWriteReg: this =3D 0xffffffa02c933000 =
regIndex =3D 0x2881 regVal =3D 0x3B
> When hooks aren't sufficient, we can apply find/replace patches, =
called lookup patches. While loopup patches allow us to modify the =
binary code directly, we avoid creating them whenever possible since 1) =
binary may change slightly and 2) it is of higher complexity, as it is =
written in raw machine code.
>=20
>=20
> -- 2.2. VTables and our Reverse Engineering --
> Some of you probably know that the kexts are written in C++, and =
heavily utilise virtual methods. A rough estimate brings us to at least =
thousands, if not tens of thousands, of virtual methods. Therefore, to =
be able to understand the logic of the classes, we must reconstruct the =
VTables and add them as the first field of the respective class. Some =
guides explain how to construct VTables in Ghidra by hand, such as =
http://hwreblog.com/projects/ghidra.html. NyanCatTW1 wrote a script that =
automatically creates structs out of VTables in program memory and =
attaches them to the respective class' structs =
(https://github.com/NyanCatTW1/RedMetaClassAnalyzer/blob/main/RedMetaClass=
Analyzer.py).
> This was done because there are at least hundreds of these structures, =
therefore, it is illogical to attempt reconstructing them by hand. This =
also allows us to apply VTables discovered from one kext to another, =
using the VTable database of the script, which is populated during =
VTable analysis. This has been useful, for instance, when we were trying =
to decipher usages of AMDRadeonX5000_AMDRadeonHWLibs inside other kexts, =
such as AMDRadeonX5000 kext. We also found the VTable database handy =
when trying to infer a class' type from a virtual call's offset =
(findEntryAtIndex.py), and when trying to discover VTable offset =
differences between AMDRadeonX5000_AMDHardware and =
AMDRadeonX6000_AMDHardware (VTableFindDiff.py).
>=20
>=20
> -- 2.3. Debugging with a black screen --
> MacOS has a verbose boot mode, however, the screen goes black after =
the following messages:
>    [  40.450667]: Accelerator successfully registered with controller.
>    [  40.717950]: IOConsoleUsers: gIOScreenLockState 3, hs 0, bs 0, =
now 0, sm 0x0
>    [  40.950416]: kPEDisableScreen 1
>=20
> To continue receiving information after the screen goes black, NetDbg =
was born. The machine sends debug messages to a remote server via a TCP =
socket -as long as a connection to it is available-.
> This was useful enough on its own, but not enough to collect kernel =
panics. We attempted to redirect dmesg messages and panic messages to =
NetDbg; sadly, due to implementation differences of backtrace dumps =
between versions of XNU, and weird SSE exceptions occurring inside the =
logic of wraps of some kernel symbols, we eventually abandoned the plan. =
Nevertheless, we managed to improve NetDbg's stability in the process; =
we reused the same socket throughout and improved the error handling. =
The NetDbg server backend was written in Python and was eventually =
rewritten by Visual in Rust.
> NetDbg lasted us for about four months, after which the driver ceased =
to cause (instant) kernel panics, which allowed us to SSH into the =
device and collect the full dmesg.
>=20
>=20
> -- 2.4. Firmware injection and other HWLibs troubles --
> AMDRadeonX5000HWLibs requires a few PSP firmware to load to finish the =
initialisation. It doesn't support PSP v10 and v12 natively, but =
fortunately, we discovered that they are very similar to PSP v11. We =
spoofed its version by wrapping _psp_sw_init and modifying the version =
inside param1 before calling it.
> All seemed fine and dandy so far. However, the SMU also needed =
spoofing.
> We attempted spoofing the version from SMU v10 to SMU v9.0.1. Still, =
it was not working. This was causing us trouble for a bit. Fortunately, =
after reading the AMDGPU code for a while, we found that the System BIOS =
is the one that loads the SMC firmware on APUs. So, we patched =
_smu_get_fw_constants and _smu_9_0_1_internal_hw_init to do nothing but =
return success.
> Afterwards, we injected up-to-date and correct firmware for the PSP, =
such as ASD, DTM, and HDCP. However, the methods (_psp_*_load) that load =
the firmware do not take a pointer and size to the firmware; the =
firmware is hardcoded in the logic itself. So, we looked at the assembly =
and figured that we can add a few arguments to the original method =
calls, along with some binary patches, which swap the hard-coded values =
out with the values in the registers, to replace the fixed pointers and =
sizes with our selection of firmware for each type of ASIC.
>=20
>=20
> -- 2.5. AMDRadeonX5000 Video Decoding/Encoding and SDMA engine =
mismatches --
> Each GFX version kext in macOS has different engines. AMDRadeonX5000, =
which supports GFX 9 and Vega 10 (which is GCN 5), was the closest one =
to our hardware.
> Everything matches, except for two things: The Video Decoding/Encoding =
engines, and the SDMA engine population in the ASIC.
>=20
> Let's start with the former; the GCN 5 kexts in macOS utilise VCE and =
UVD. But, this is incorrect for our hardware, since, as you probably =
know, Raven/Raven2/Renoir use VCN. Luckily for us, the next revision, =
RDNA 1.0, aka AMDRadeonX6000, has the VCN engine in it. Nonetheless, =
everything else mismatches. So, we somehow have to fool macOS to load =
the X6000 kext, but do nothing and detach, while remaining loaded in =
memory for us to swap the VCE/UVD engines with the VCN engine from it.
> To do so, we added AMDRadeonX6000 to Info.plist, which tells the =
system what to load, in what order, and made it load before =
AMDRadeonX5000, by increasing its probe score from 0 to 1. Afterwards, =
we ensured that it doesn't attach by making the start function always =
return false. This is, as far as we can tell, sufficient to have macOS =
load and keep the kext in the memory, as it doesn't seem to unload kexts =
automatically; however, this newer kext revision doesn't match the =
VTables of the HWEngine and HWChannel class of the X5000 kext, causing =
kernel panics and random unrelated methods to be called.
> So, we needed to patch the VTable offsets of the calls contained =
therein. This was made relatively easily by our scripts, however, was a =
very tiresome and repetitive task, as we still needed to create the =
binary patches by hand. We still went ahead and did it, and so far we =
have had no kernel panics related to it, but we may have still missed a =
few methods that might cause problems in the future.
>=20
> Now for the SDMA engines. As you may know, the iGPUs only have 1 SDMA =
engine, SDMA0. The kexts are not made to have only one SDMA engine; the =
code is structured to have both SDMA0 and SDMA1 utilised. We began by =
removing the SDMA1 Engine from the allocateHWEngines method, then with a =
simple binary patch in AMDRadeonX5000_AMDHardware::startHWEngines, do =
only one iteration of the HWEngine::start loop instead of two (starting =
only SDMA0). n, createAccelChannels was still trying to get the SDMA1 =
HWChannel, which no longer exists. So we created a wrap for the =
getHWChannel function, to redirect SDMA1 queries to return SDMA0, which =
seems to work.
>=20
>=20
> -- 2.6. SDMA0 power on via SMC --
> After convincing the driver not to attempt to initialise or utilise =
the SDMA1 HWEngine or its respective HWChannel, we managed to get the =
controller to enable itself.
>    [  31.377982]: [3:0:0]: Controller is enabled, finish =
initialization
>=20
> However, about 5 seconds after that message, we received the following =
error log:
>    [  36.415551]: [3:0:0]: channel 15 VMPT is hung! =
(lastReadTimestamp=3D0x00000000) channelResetMask 0x00000000
>    [  36.924786]: void IOAccelEventMachine2::restart_channel(): =
GPURestartBegin stampIdx=3D15 type=3D4
>    [  37.325791]: [3:0:0] GPU HangState 0x00000000, HangFlags =
0x00000004: IndividualEngineHang 0, NonEngineBlockHang 0, =
FenceNotRetired 1, PerEngineReset 0, FullAsicReset 1
>    [  37.998126]: GPU Log Version: 2=20
>    Restart Channel: 15 VMPT=20
>    ---THE STATE OF THE DRIVER---
>=20
>    AMDRadeonX5000_AMDVega10GraphicsAccelerator state: DISABLED=20
>     PCIe Device: [3:0:0], DID=3D0x15d8, RID=3D0xdf, SSID=3D0x380a=20
>     TotalVideoRAMBytes: 0x0000000020000000 (536870912)=20
>    Uptime 0:00:37.326026
>    ...
>    [15] Channel: VMPT (HW [05]); Priority 0; last reset at =
0:00:00.000000=20
>     CompletedTS =3D 0x00000000, SubmittedTS =3D 0x00000001=20
>     Sent to HW: TS =3D 0x00000001 (HW TS =3D 0x00000001, WPTR =3D =
0x80) at 0:00:31.372558
>    ...
>    [05] HWChannel: SDMA0, Priority 2, last reset 0:00:00.000000=20
>     CompletedTS =3D 0x00000000, SubmittedTS =3D 0x00000001=20
>     PendingTS =3D 0x1, sent at 0:00:31.372558, AccelChannel: 15, TS =3D =
0x1
>    ...
>=20
> The error occurred on 2022-10-08, but we only managed to fix it on =
2022-11-27. Throughout the period, we investigated the content of the =
command buffer, injected the Raven version of ME/CE/PFP/MEC/MEC JT and =
SDMA firmware, messed with the CAIL properties, and even set up an Arch =
Linux instance on the laptop to experiment with AMDGPU's logic.
> It turns out the Linux instance was what helped us solve the problem. =
More precisely, we came up with the idea of messing with Linux's SDMA =
code until the SDMA engine freezes, just like the error. And as an =
ingenious step, we started by finding and messing with APU-specific =
logic.
> After three days of search and experimentation, we discovered the =
following code in sdma_v4_0.c:
>    static int sdma_v4_0_hw_init(void *handle)
>    {
>        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>        if (adev->flags & AMD_IS_APU)
>            amdgpu_dpm_set_powergating_by_smu(adev, =
AMD_IP_BLOCK_TYPE_SDMA, false);
>        ...
>    }
>=20
> Surprisingly, commenting the power gating line out causes the same =
SDMA freeze, just like on MacOS. After digging into what the =
amdgpu_dpm_set_powergating_by_smu call does, we discover that it =
eventually sends PPSMC_MSG_PowerUpSdma (0xE) to the SMC. To replicate =
this behaviour, we wrapped _SmuRaven_Initialize and called =
_Raven_SendMsgToSmcWithParameter with the message above after the =
original call.
> And at last, the SDMA finally responded, which led us to a different =
problem.
>=20
> -- 2.7. SDMA0 Accel channel skipping memory mapping commands --
> We removed SDMA1, and SDMA0 is responding. But for some reason, the =
memory mapping commands sent by the kexts do not get scheduled in order; =
after a few VMPT (Virtual Memory Page Table) commands get processed, the =
scheduler immediately jumps to process the unmapped IBs (Indirect =
Buffers) from WindowServer, which fails, of course. We tried a variety =
of things:
>    - Hacking the scheduler to wait
>    - Creating a fake SDMA1 engine, redirecting it to SDMA0
>=20
> All in all, it took us months to fix it. Ultimately, the problem was a =
value in a field which seemed to decide the order, two bits of it =
precisely. We still don't know what that field does, but the value gets =
set differently when the engine type is SDMA1. Visual had been =
suspicious of this field for two months. We tried the SDMA1 value, and =
it fixed the problem, leading us to the current issue: GPUVM page faults =
related to IBs (Indirect Buffers) sent by WindowServer.
>=20
>=20
> -- 3. Current issue --
> -- 3.1. VM Protection Faults --
> About five seconds after the "controller enable" message, the =
following errors occur:
>    [   36.626349]: virtual IOReturn =
IOAccelEventMachine2::waitForStamp(int32_t, stamp_t, stamp_t *): initial =
wait for 1 second expired. Continue wait for 4 seconds. stamp 2 =
(gpu_stamp=3D0)
>    [   36.717958]: virtual void =
IOAccelEventMachineFast2::checkGPUProgress() - Signaling hardware error =
on channel 0..
>    [   37.250283]: void =
IOAccelEventMachine2::handleFinishChannelRestart(IOReturn, int32_t, =
uint32_t): GPURestartDequeued stampIdx=3D0 type=3D2 fromWhere=3D1 =
waitingOnIdx=3D0
>    [   37.250289]: [3:0:0]: channel 0 event timeout
>    [   38.978678]: [3:0:0] GPU HangState 0x0000000e, HangFlags =
0x00000005: IndividualEngineHang 1, NonEngineBlockHang 0, =
FenceNotRetired 1, PerEngineReset 1, FullAsicReset 0
>    [   39.661790]: GPU Log Version: 2
>=20
>    Restart Channel: 0 GFX
>=20
>    ---THE STATE OF THE DRIVER---
>=20
>    AMDRadeonX5000_AMDVega10GraphicsAccelerator state: ENABLED
>    ...
>    [00] Channel: GFX (HW [00]); Priority 2; last reset at =
0:00:00.000000
>      CompletedTS =3D 0x00000000, SubmittedTS =3D 0x00000001
>      Sent to HW: TS =3D 0x00000001 (HW TS =3D 0x00000002, WPTR =3D =
0x100) at 0:00:43.375063
>      FirstPendingCB: Process ID =3D 145, Name =3D WindowServer; =
SubmitContext =3D Unknown (0)
>          GPUAddress =3D 0x0000000400480000, Size =3D 0x00000190, VMID =
=3D 1
>    ...
>    [05] Channel: SDMA0 (HW [05]); Priority 2; last reset at =
0:00:00.000000
>      CompletedTS =3D 0x00000000, SubmittedTS =3D 0x0000000f
>      Sent to HW: TS =3D 0x00000001 (HW TS =3D 0x0000001d, WPTR =3D =
0xe80) at 0:00:43.375067
>      ScheduledTS =3D 0x00000005, enqueued at 0:00:37.954289
>      FirstPendingCB: Process ID =3D 145, Name =3D WindowServer; =
SubmitContext =3D Unknown (0)
>          GPUAddress =3D 0x0000000400280000, Size =3D 0x00000007, VMID =
=3D 1
>    ...
>    [00] HWChannel: GFX, Priority 2, last reset 0:00:00.000000
>      CompletedTS =3D 0x00000001, SubmittedTS =3D 0x00000002
>      PendingTS =3D 0x2, sent at 0:00:43.375063, AccelChannel: 0, TS =3D =
0x1
>    ...
>    [05] HWChannel: SDMA0, Priority 2, last reset 0:00:00.000000
>      CompletedTS =3D 0x0000001c, SubmittedTS =3D 0x00000020
>      PendingTS =3D 0x1d, sent at 0:00:43.375067, AccelChannel: 5, TS =3D=
 0x1
>    ...
>    SDMA0: BUSY,  MicroEngine: ACTIVE,  LastCmd: 0x00000000
>      Q0: HALT, ReadPtr =3D 0x00000e10 (0x0000000000003840), WritePtr =3D=
 0x00001000 (0x0000000000004000)
>        IB: ENABLED, GPUAddress =3D 0x0000000400280000, ConsumedSize =3D =
0x00000000, RemainSize=3D0x00000070
>    ...
>    VM Protection Fault (GFX): YES
>        Page GPUAddress =3D 0x0000000400480000, VMID =3D 1
>        Failing Protection =3D VALID, READ, EXECUTE, NACK
>        Memory Client ID =3D 4
>        Memory Client R/W =3D READ
>        Page table: 0x000000040047f000 .. 0x0000000400480000
>    [060000006a931077]=20
>    [0000000069497077]=20
>=20
>    VM Protection Fault (MM): YES
>        Page GPUAddress =3D 0x0000000400280000, VMID =3D 1
>        Failing Protection =3D VALID, READ, NACK
>        Memory Client ID =3D 0
>        Memory Client R/W =3D READ
>        Page table: 0x000000040027f000 .. 0x0000000400280000
>    [000000001018c2f1]=20
>    [06000000691b8077]
>    ...
>=20
> This error occurs several times as it attempts to restart the GFX/SDMA =
channels multiple times, but that doesn't do anything since the issue =
remains, resulting in a black screen for a few minutes before the =
machine eventually restarts due to a watchdogd timeout because =
WindowServer fails to check in successfully.
> The above dump occurs whenever a channel is frozen and is referred to =
as a diagnostic dump in the code, so we follow suit.
>=20
>=20
> -- 3.2. Analysis of the diagnostic dump --
> We shall go through the log one part at a time and observe what might =
be happening.
>=20
>    [05] Channel: SDMA0 (HW [05]); Priority 2; last reset at =
0:00:00.000000
>      CompletedTS =3D 0x00000000, SubmittedTS =3D 0x0000000f
>      Sent to HW: TS =3D 0x00000001 (HW TS =3D 0x0000001d, WPTR =3D =
0xe80) at 0:00:43.375067
>      ScheduledTS =3D 0x00000005, enqueued at 0:00:37.954289
>      FirstPendingCB: Process ID =3D 145, Name =3D WindowServer; =
SubmitContext =3D Unknown (0)
>          GPUAddress =3D 0x0000000400280000, Size =3D 0x00000007, VMID =
=3D 1
> The "TS" here is short for "timestamp", it is the fence of the =
submitted command buffer.
> WindowServer sent a command buffer to the SDMA accel channel, which =
failed, because CompletedTS didn't increase.
> <!-- Iirc VMID 2~15 are also available to userspace -->
> The submitted command buffer refers to VMID 1, which is the VMID used =
for user-submitted command buffers (VMID 0 is the GART, aka)
>=20
>    [05] HWChannel: SDMA0, Priority 2, last reset 0:00:00.000000
>      CompletedTS =3D 0x0000001c, SubmittedTS =3D 0x00000020
>      PendingTS =3D 0x1d, sent at 0:00:43.375067, AccelChannel: 5, TS =3D=
 0x12
> Here we see the HWChannel behind the SDMA0 accel channel. It doesn't =
provide new info, though.
>=20
>    SDMA0: BUSY,  MicroEngine: ACTIVE,  LastCmd: 0x00000000
>      Q0: HALT, ReadPtr =3D 0x00000e10 (0x0000000000003840), WritePtr =3D=
 0x00001000 (0x0000000000004000)
>        IB: ENABLED, GPUAddress =3D 0x0000000400280000, ConsumedSize =3D =
0x00000000, RemainSize=3D0x00000070
> The IB (Indirect Buffer) of the previous TS never got consumed.
>=20
>    VM Protection Fault (MM): YES
>        Page GPUAddress =3D 0x0000000400280000, VMID =3D 1
>        Failing Protection =3D VALID, READ, NACK
>        Memory Client ID =3D 0
>        Memory Client R/W =3D READ
>        Page table: 0x000000040027f000 .. 0x0000000400280000
>    [000000001018c2f1]=20
>    [06000000691b8077]
> A VM protection fault occurred while the SDMA0 was trying to access =
the physical address behind 0x400280000, which is the IB.
>=20
> =46rom the diagnostic dump, we can see that protection faults are =
occurring on VMID 1, which causes the engines to freeze when they try to =
access the IB, and that caused both channels to time out.
>=20
>=20
> -- 3.3. A deeper dive into the protection fault --
> (Prerequisite: Familiarity with Sections 4.1 ~ 4.4)
> There are many types of failing protection. So far we have seen the =
following:
>    - VALID: Failure to find the right PDE/PTE
>    - READ, WRITE, EXECUTE: Permission not set (always happen when =
VALID is set)
>    - NACK: Purpose unknown, but it seems to stand for =
Negative-Acknowledgment.
>    - PDE0: Purpose unknown, but it seems to refer to the PDB0 block =
level.
>    - TRANSLATE FURTHER: This appears to occur when AMDGPU_PTE_TF is =
set, but the address inside the entry is invalid.
>=20
> There are also these weird hex values:
>    [000000001018c2f1]=20
>    [06000000691b8077]
>=20
> After going through the writeMappedEntriesDiagnosisReport/getVMPT =
functions, we have determined that it is the flag value of the PTEs that =
map 0x000000040027f000 ~ 0x0000000400280000. When there is a newline, it =
means that the two PTEs are non-contiguous, aka not within the same VM =
block; also, during a few experiments, the protection fault would go =
away. But the GPU still doesn't consume the IB properly, as seen in this =
dump:
>    IB: ENABLED, GPUAddress =3D 0x0000000400280000, ConsumedSize =3D =
0x00039ee0, RemainSize=3D0x00000070
> We assume whenever this occurs, it means that the GPU got the wrong =
physical address, instead of the one pointing to the IB.
>=20
>=20
> -- 4. What we know so far --
> Even though none of our attempts has successfully resolved the issue, =
we have established a basic understanding of the GPUVM in the process. =
The following info is provided both to introduce how the AMD kexts work =
with the GPUVM, and to allow our misconceptions to be pointed out.
>=20
>=20
> -- 4.1. The VM Blocks and the PDEs/PTEs --
> There are four types of VM Blocks: PDB2, PDB1, PDB0, and PTB. A VM =
block is an array of PDEs/PTEs, with the number of entries mostly =
determined by the block_size and the VM size.
> A PDE contains flags and a GPU address to a VM block of the next =
level. PDEs on PDB2 lead to a PDB1, PDEs on PDB1 lead to a PDB0, and =
PDEs on PDB0 lead to a PTB.
> A PTE contains flags and the physical address of the mapped virtual =
address. We are uncertain whether the physical address is of the CPU or =
the GPU, but we think it's a CPU physical address. A PTE maps 4KB of =
virtual address by default.
> The GPUVM supports down to one level (PTB) and up to four levels =
(PDB2->PDB1->PDB0->PTB).
> There is a root block to each VMID, whose type is determined by the =
number of levels (PTB on 1-level, PDB0 on 2-level, and so on)
>=20
>=20
> -- 4.2. The VM registers --
> Inside mmVM_CONTEXT1_CNTL, there are three relevant fields, other than =
many interrupt-related options:
> ENABLE_CONTEXT determines if the context is enabled. PAGE_BLOCK_SIZE =
is set to block_size - 9 when translate_further is off; when =
translate_further is on, it is set to block_size. When PAGE_TABLE_DEPTH =
is set to x, entries on the first x levels are considered PDEs by =
default. We call these PDE-default levels. The lower levels, where =
entries are considered PTEs by default, are called PTE-default levels; =
for instance, when PAGE_TABLE_DEPTH is set to 2, and the VMPT has three =
levels, PDB1 and PDB0 will be PDE-default levels, whereas PTB becomes a =
PTE-default level.
>=20
> mmVM_CONTEXT1_PAGE_TABLE_START_ADDR and =
mmVM_CONTEXT1_PAGE_TABLE_END_ADDR determine the range of virtual =
addresses mapped by the context; this also implies the VM size.
> mmVM_CONTEXT1_PAGE_TABLE_BASE_ADDR specifies the GPU physical address =
of the root block.
>=20
>=20
> -- 4.3. The PDE/PTE flags --
> The seven lowest bits seem straightforward, so we'll skip to the less =
obvious bits.
> AMDGPU_PTE_FRAG seems to make a PTE on a PTB map more bytes than the =
default. Assume that the value of the frag is x, the PTE will instead =
map 4KB * 2^x bytes of memory.
> AMDGPU_PDE_PTE makes the GPU treat an entry as PTE, even if it's on a =
PDE-default level. Setting this bit to true on PTE-default levels =
appears to cause a VALID fault regardless of the entry's content.
> AMDGPU_PTE_TF makes the GPU treat an entry as PDE, even if it's on a =
PTE-default level. Setting this bit to true on PDE-default levels =
appears to cause a VALID fault regardless of the entry's content.
> AMDGPU_PDE_BFS is set on PDEs on PDB1 only when translate_further is =
on. We are unsure of its purpose.
> We have no idea what AMDGPU_PTE_MTYPE_VG10 is, other than it might be =
related to caching.
>=20
>=20
> -- 4.4. The translate_further mode --
> translate_further is only enabled if the GC version is 9.1.0/9.2.2 and =
rev_id >=3D 2. When it's on, the VM is always set to three levels, but =
with the depth set to one. This means that both PDB0 and PTB are now =
PTE-default levels, instead of just PTB; PDB1 is the only PDE-default =
level.
> To reflect this fact, PDEs on PDB0 have the AMDGPU_PTE_TF bit set, =
which tells the GPU to go to the next level to finish address =
translation (hence the name translate further.)
> We are uncertain of its purpose, but it seems to help extend the VM =
size under certain circumstances.
> The AMDRadeonX5000 kext defaults to using 3-level VMPT with =
translate_further on. The AMDGPU code also uses translate_further by =
default on Raven2. However, according to Visual, AMDGPU code remained =
functional when he forced translate_further off.
>=20
>=20
> -- 4.5. The VMPTConfig in AMD kexts --
> Inside AMDRadeonX5000_AMDGFX9VMM, there is a structure named =
VMPTConfig. The default VMPTConfig in X5000 is:
>    // {incr, entryCount, vmBlockSize}
>    {
>        {0x10000000, 0x200, 0x1000}, // PDB1
>        {0x10000, 0x1000, 0x8000}, // PDB0
>        {0x1000, 0x10, 0x1000}, // PTB
>    }
>=20
> Whereas the one in X4000 is:
>    {
>        {0x10000000, 0x200, 0x1000}, // PDB0
>        {0x1000, 0x10000, 0x80000}, // PTB
>    }
>=20
> As you can see, it's an array of three-element tuples, with every =
tuple representing a level on the VMPT. We will use the X5000 VMPTConfig =
as an example and explain what the three fields mean to our =
understanding.
>=20
> First of all, the second field (entryCount) is the number of entries =
of a block on that level. For instance, PDB0 has an entryCount of =
0x1000, which means that a block on the PDB0 level contains 0x1000 =
entries, each of which is either a PTE or a pointer to a PTB block (PDE)
>=20
> Afterwards, the third field (vmBlockSize) is the size of a block on =
that level in bytes. This is easy to explain on most levels, as every =
entry is 8 bytes in size, so vmBlockSize would be eight times the =
entryCount. However, the X5000 PTB is an exception. This is because the =
blocks are required to be aligned to 4kb. Therefore, it allocates 4kb =
for each PTB block, wasting 0x1000 - 0x80 =3D 3968 bytes of space.
>=20
> Finally, the first field (incr) is the amount of virtual memory =
controlled by an entry of a block at that level.
> Wait, let me explain. This is straightforward on PTB, as every PTE =
maps 4kb by default. As of PDB0, because every PTB block controls 0x1000 =
(incr) * 0x10 (entryCount) =3D 0x10000 bytes of virtual memory, =
therefore, a PDB0 entry pointing to a PTB block also controls 0x10000 =
bytes.
>=20
> An important property of the config is that levels[i].incr =3D =
levels[i + 1].incr * levels[i + 1].entryCount, except for PTB which =
hardcodes the incr to 4KB. We used this property to create and =
experiment with different VMPTConfigs. Another property is that the VM =
size is equal to levels[0].incr * levels[0].entryCount, as the root =
block contains the entire VM.
>=20
> Both X5000 and X4000 have a VM range of 0x400000000 ~ 0x2400000000, =
making the VM size 0x2000000000 =3D 128 GB. We are unsure why the VM =
size in the kexts is smaller than that of AMDGPU which sets the VM size =
to at least 128 TB.
>=20
>=20
> -- 4.6. How the entryCount is determined on AMDGPU --
> There are two main components to it. The first is this function:
>    /**
>     * amdgpu_vm_num_entries - return the number of entries in a PD/PT
>     *
>     * @adev: amdgpu_device pointer
>     * @level: VMPT level
>     *
>     * Returns:
>     * The number of entries in a page directory or page table.
>     */
>    static unsigned amdgpu_vm_num_entries(struct amdgpu_device *adev,
>                          unsigned level)
>    {
>        unsigned shift =3D amdgpu_vm_level_shift(adev,
>                               adev->vm_manager.root_level);
>=20
>        if (level =3D=3D adev->vm_manager.root_level)
>            /* For the root directory */
>            return round_up(adev->vm_manager.max_pfn, 1ULL << shift)
>>> shift;
>        else if (level !=3D AMDGPU_VM_PTB)
>            /* Everything in between */
>            return 512;
>        else
>            /* For the page tables on the leaves */
>            return AMDGPU_VM_PTE_COUNT(adev);
>    }
>=20
> Then the following macro:
>    /* number of entries in page table */
>    #define AMDGPU_VM_PTE_COUNT(adev) (1 << =
(adev)->vm_manager.block_size)
>=20
> According to our understanding, the entryCount is determined as =
follows:
>    1. The PTB has 2^block_size entries. (Notice that block_size !=3D =
PAGE_BLOCK_SIZE in AMDGPU)
>    2. PDB0~PDB2 has 512 entries unless they are the root level.
>    3. The root level has vmSize/incr entries. This is to satisfy the =
property that vmSize =3D levels[0].incr * levels[0].entryCount.
>=20
> These are another set of key info that we used to manually craft =
VMPTConfigs.
>=20
>=20
> -- 4.7. The GPUVM settings of AMD kexts vs. AMDGPU --
> First of all, let's summarize some crucial settings of the GPUVM:
>    - The block_size
>    - The PAGE_BLOCK_SIZE
>    - The number of levels
>    - The PAGE_BLOCK_DEPTH
>    - VMPTConfig aka. the incr, entryCount, and vmBlockSize.
>=20
> With that taken care of, here are four sets of configurations that we =
have seen:
>=20
> AMDRadeonX5000:
>    - block_size is unknown (Because translate_further is on)
>    - PAGE_BLOCK_SIZE =3D 7
>    - Three levels
>    - PAGE_BLOCK_DEPTH =3D 1 (Because translate_further is on)
>    - VMPTConfig:
>        {
>            {0x10000000, 0x200, 0x1000}, // PDB1
>            {0x10000, 0x1000, 0x8000}, // PDB0
>            {0x1000, 0x10, 0x1000}, // PTB
>        }
>=20
> AMDRadeonX4000:
>    - block_size =3D log2(0x10000) =3D 16
>    - PAGE_BLOCK_SIZE =3D 7 (which equals 16 - 9)
>    - Two levels
>    - PAGE_BLOCK_DEPTH =3D 1
>    - VMPTConfig:
>        {
>            {0x10000000, 0x200, 0x1000}, // PDB0
>            {0x1000, 0x10000, 0x80000}, // PTB
>        }
>=20
> AMDGPU with translate_further on:
>    - block_size =3D 9
>    - PAGE_BLOCK_SIZE =3D 9
>    - Three levels
>    - PAGE_BLOCK_DEPTH =3D 1
>    - VMPTConfig is unknown
>=20
> AMDGPU with translate_further off:
>    - block_size =3D 9
>    - PAGE_BLOCK_SIZE =3D 0
>    - Three levels
>    - PAGE_BLOCK_DEPTH =3D 2
>    - VMPTConfig (inferred):
>        {
>            {0x40000000, Unknown, Unknown}, // PDB1
>            {0x200000, 0x200, 0x1000}, // PDB0
>            {0x1000, 0x200, 0x1000}, // PTB
>        }
>=20
> -- 5. What we have tried --
> We attempted dozens of methods to fix the issue. However, none have =
managed to get one VMID 1 IB to work. The following are all that we have =
tried so far.
>=20
> -- 5.1. PTE/PDE flags experimentations --
> (Prerequisite: Familiarity with Sections 4.1 ~ 4.4)
>=20
> The PTE/PDE flags are determined by getPTEValue and getPDEValue, =
respectively. We, therefore, wrapped them and experimented with =
adjusting the flags.
>=20
> Unsetting AMDGPU_PDE_PTE for all PDE values:
>=20
>    Q0: HALT, ReadPtr =3D 0x00001b90 (0x0000000000006e40), WritePtr =3D =
0x00001d80 (0x0000000000007600)=20
>        IB: ENABLED, GPUAddress =3D 0x0000000400280000, ConsumedSize =3D =
0x00000000, RemainSize=3D0x00000070=20
>=20
>    VCN0: Disabled=20
>=20
>    VM Protection Fault (GFX): YES=20
>        Page GPUAddress =3D 0x0000000400480000, VMID =3D 1=20
>        Failing Protection =3D VALID, READ, EXECUTE, PDE0=20
>        Memory Client ID =3D 4=20
>        Memory Client R/W =3D READ=20
>        Page table: 0x000000040047f000 .. 0x0000000400480000=20
>    [060000006645a077] [0000000065b3d077]
>=20
>    VM Protection Fault (MM): YES=20
>        Page GPUAddress =3D 0x0000000400280000, VMID =3D 1=20
>        Failing Protection =3D VALID, READ, PDE0=20
>        Memory Client ID =3D 0=20
>        Memory Client R/W =3D READ=20
>        Page table: 0x000000040027f000 .. 0x0000000400280000=20
>    [06000000673d6077] [060000006841e077]
>=20
>    - Unsetting AMDGPU_PTE_TF and AMDGPU_PDE_BFS
>=20
>    SDMA0: BUSY,  MicroEngine: ACTIVE,  LastCmd: 0x00000000=20
>      Q0: HALT, ReadPtr =3D 0x00001a10 (0x0000000000006840), WritePtr =3D=
 0x00001c00 (0x0000000000007000)=20
>        IB: ENABLED, GPUAddress =3D 0x0000000400280000, ConsumedSize =3D =
0x00000000, RemainSize=3D0x00000070=20
>=20
>    VCN0: Disabled=20
>=20
>    VM Protection Fault (GFX): YES=20
>        Page GPUAddress =3D 0x0000000400480000, VMID =3D 1=20
>        Failing Protection =3D VALID, READ, EXECUTE, NACK=20
>        Memory Client ID =3D 4=20
>        Memory Client R/W =3D READ=20
>        Page table: 0x000000040047f000 .. 0x0000000400480000=20
>    [060000006822b077] [0000000066ad7077] =20
>=20
>    VM Protection Fault (MM): YES=20
>        Page GPUAddress =3D 0x0000000400280000, VMID =3D 1=20
>        Failing Protection =3D VALID, READ, NACK=20
>        Memory Client ID =3D 0=20
>        Memory Client R/W =3D READ=20
>        Page table: 0x000000040027f000 .. 0x0000000400280000=20
>    [060000006743b077] [0600000067977077]
>=20
>    - Unsetting AMDGPU_PDE_BFS
>=20
>    SDMA0: BUSY,  MicroEngine: ACTIVE,  LastCmd: 0x00000000=20
>      Q0: ACTIVE, ReadPtr =3D 0x00001b10 (0x0000000000006c40), WritePtr =
=3D 0x00001d00 (0x0000000000007400)=20
>        IB: ENABLED, GPUAddress =3D 0x0000000400280000, ConsumedSize =3D =
0x00000000, RemainSize=3D0x00000070=20
>=20
>    VCN0: Disabled=20
>=20
>    VM Protection Fault (GFX): NO=20
>=20
>    VM Protection Fault (MM): NO
>=20
> No fault, but stuck.
>=20
> Setting AMDGPU_PDE_BFS to 12:
>=20
>    SDMA0: BUSY,  MicroEngine: ACTIVE,  LastCmd: 0x00000000=20
>      Q0: HALT, ReadPtr =3D 0x00001190 (0x0000000000004640), WritePtr =3D=
 0x00001380 (0x0000000000004e00)=20
>        IB: ENABLED, GPUAddress =3D 0x0000000400280000, ConsumedSize =3D =
0x00000000, RemainSize=3D0x00000070=20
>=20
>    VCN0: Disabled=20
>=20
>    VM Protection Fault (GFX): YES=20
>        Page GPUAddress =3D 0x0000000400480000, VMID =3D 1=20
>        Failing Protection =3D VALID, READ, EXECUTE, TRANSLATE FURTHER=20=

>        Memory Client ID =3D 4=20
>        Memory Client R/W =3D READ=20
>        Page table: 0x000000040047f000 .. 0x0000000400480000=20
>    [060000006d266077] =20
>    [000000006dcea077] =20
>=20
>    VM Protection Fault (MM): YES=20
>        Page GPUAddress =3D 0x0000000400280000, VMID =3D 1=20
>        Failing Protection =3D VALID, READ, NACK=20
>        Memory Client ID =3D 0=20
>        Memory Client R/W =3D READ=20
>        Page table: 0x000000040027f000 .. 0x0000000400280000=20
>    [000000001018c2f1] =20
>    [060000006cccc077]
>=20
>    - Setting AMDGPU_PDE_BFS to 9
>=20
>    VM Protection Fault (GFX): YES
>        Page GPUAddress =3D 0x0000000400480000, VMID =3D 1
>        Failing Protection =3D VALID, READ, EXECUTE, NACK
>        Memory Client ID =3D 4
>        Memory Client R/W =3D READ
>        Page table: 0x000000040047f000 .. 0x0000000400480000
>    [060000006af62077]
>    [000000006a82d077]
>=20
>    VM Protection Fault (MM) YES
>        Page GPUAddress =3D 0x0000000400280000, VMID =3D 1
>        Failing Protection =3D VALID, READ, NACK
>        Memory Client ID =3D 0
>        Memory Client R/W =3D READ
>        Page table: 0x000000040027f000 .. 0x0000000400280000
>    [000000001018c2f1]
>    [060000006b6f8077]
>=20
>=20
>=20
> -- 5.2. Experimentation with VMPTConfig and related settings --
> (Prerequisite: Familiarity with Sections 4.1 ~ 4.7)
>=20
> We have attempted to replicate three-level, two-level, and one-level =
configurations according to what we learned in the AMDGPU code.=20
> We adjust the VM Size, the number of levels, and the depth by =
modifying their respective fields after calling =
AMDRadeonX5000_AMDGFX9VMM::init.
> PAGE_BLOCK_SIZE is set in =
AMDRadeonX5000_AMDGFX9Hardware::initializeVmContextCntlRegs, which in =
turn calls AMDRadeonX5000_AMDHWVMM::getVMPTBCoverage to calculate the =
value to use. We wrap getVMPTBCoverage and change its value to =
indirectly set the PAGE_BLOCK_SIZE.
> We verify that PAGE_BLOCK_SIZE and PAGE_BLOCK_DEPTH have been set =
correctly by wrapping AMDRadeonX5000_AMDHWRegisters::write and checking =
that the value written to mmVM_CONTEXT1_CNTL (0x2881) is correct.
> We set VMPTConfig by modifying the fields directly and then applying a =
binary patch to prevent AMDRadeonX5000_AMDGFX9VMM::init from overriding =
the values.
> No action is required for block_size, as it is equal to the log2 of =
PTB's entryCount.
>=20
> Now, the following are the configurations we tried and the errors they =
yielded:
>=20
> Three-level with translate_further on (the default):
>    - VM Size: 0x2000000000 (128 GB)
>    - block_size is unknown
>    - PAGE_BLOCK_SIZE =3D 7
>    - Three levels
>    - PAGE_BLOCK_DEPTH =3D 1
>    - VMPTConfig:
>    {
>        {0x10000000, 0x200, 0x1000}, // PDB1
>        {0x10000, 0x1000, 0x8000}, // PDB0
>        {0x1000, 0x10, 0x1000}, // PTB
>    }
>    Results:
>        VM Protection Fault (GFX): YES
>            Page GPUAddress =3D 0x0000000400480000, VMID =3D 1
>            Failing Protection =3D VALID, READ, EXECUTE, NACK
>            Memory Client ID =3D 4
>            Memory Client R/W =3D READ
>            Page table: 0x000000040047f000 .. 0x0000000400480000
>        [060000006a931077]=20
>        [0000000069497077]=20
>=20
>        VM Protection Fault (MM): YES
>            Page GPUAddress =3D 0x0000000400280000, VMID =3D 1
>            Failing Protection =3D VALID, READ, NACK
>            Memory Client ID =3D 0
>            Memory Client R/W =3D READ
>            Page table: 0x000000040027f000 .. 0x0000000400280000
>        [000000001018c2f1]=20
>        [06000000691b8077]
>=20
>=20
> Three-level with translate_further off:
>    - VM Size: 0x2000000000 (128 GB)
>    - block_size =3D 9
>    - PAGE_BLOCK_SIZE =3D 0
>    - Three levels
>    - PAGE_BLOCK_DEPTH =3D 2
>    - VMPTConfig:
>    {
>        {0x40000000, 0x80, 0x1000}, // PDB1
>        {0x200000, 0x200, 0x1000}, // PDB0
>        {0x1000, 0x200, 0x1000}, // PTB
>    }
>    Results:
>        VM Protection Fault (GFX): YES
>            Page GPUAddress =3D 0x0000000400480000, VMID =3D 1
>            Failing Protection =3D VALID, READ, EXECUTE, NACK
>            Memory Client ID =3D 4
>            Memory Client R/W =3D READ
>            Page table: 0x000000040047f000 .. 0x0000000400480000
>        [06000000683dc077] [0000000067882077]=20
>=20
>        VM Protection Fault (MM): YES
>            Page GPUAddress =3D 0x0000000400280000, VMID =3D 1
>            Failing Protection =3D VALID, READ, NACK
>            Memory Client ID =3D 0
>            Memory Client R/W =3D READ
>            Page table: 0x000000040027f000 .. 0x0000000400280000
>        [06000000689f8077] [0600000067a94077]=20
>=20
>=20
> Two-level:
>    - VM Size: 0x2000000000 (128 GB)
>    - block_size =3D 16
>    - PAGE_BLOCK_SIZE =3D 7
>    - Two levels
>    - PAGE_BLOCK_DEPTH =3D 1
>    - VMPTConfig:
>    {
>        {0x10000000, 0x200, 0x1000}, // PDB0
>        {0x1000, 0x10000, 0x80000}, // PTB
>    }
>    Results:
>        VM Protection Fault (GFX): YES
>            Page GPUAddress =3D 0x0000000400480000, VMID =3D 1
>            Failing Protection =3D VALID, READ, EXECUTE, NACK
>            Memory Client ID =3D 4
>            Memory Client R/W =3D READ
>            Page table: 0x000000040047f000 .. 0x0000000400480000
>        [060000005fc30077] [000000005d537077]=20
>=20
>        VM Protection Fault (MM): YES
>            Page GPUAddress =3D 0x0000000400280000, VMID =3D 1
>            Failing Protection =3D VALID, READ, NACK
>            Memory Client ID =3D 0
>            Memory Client R/W =3D READ
>            Page table: 0x000000040027f000 .. 0x0000000400280000
>        [000000001019b2f1] [060000005f580077]=20
>=20
>=20
> One-level:
>    - VM Size: 0x400000000 (16 GB, otherwise the VMPT can't fit within =
the 256 MB aperture)
>    - block_size =3D 0
>    - PAGE_BLOCK_SIZE =3D 0 (In accordance to gmc_v9_0_gart_init logic)
>    - One level
>    - PAGE_BLOCK_DEPTH =3D 0
>    - VMPTConfig:
>    {
>        {0x1000, 0x400000, 0x2000000}, // PTB
>    }
>    Results:
>        SDMA0: BUSY,  MicroEngine: ACTIVE,  LastCmd: 0x00000000
>          Q0: HALT, ReadPtr =3D 0x00001b90 (0x0000000000006e40), =
WritePtr =3D 0x00001d80 (0x0000000000007600)
>            IB: ENABLED, GPUAddress =3D 0x0000000400280000, =
ConsumedSize =3D 0x00039ee0, RemainSize=3D0x00000070
>=20
>        VM Protection Fault (GFX): YES
>            Page GPUAddress =3D 0x0000000400480000, VMID =3D 1
>            Failing Protection =3D VALID, READ, EXECUTE, TRANSLATE =
FURTHER
>            Memory Client ID =3D 4
>            Memory Client R/W =3D READ
>            Page table: 0x000000040047f000 .. 0x0000000400480000
>        [0600000068e40077] [0000000067e84077]=20
>=20
>        VM Protection Fault (MM): NO
>=20
> Out of all configurations we have tested, this one has the strangest =
result. The strange things are:
>    1. According to the wraps, the AMDGPU_PTE_TF flag was never set on =
any entries. But if so, where did the TRANSLATE FURTHER protection error =
come from?
>    2. How does the MM(SDMA0) get the wrong physical address, while GFX =
throws a protection fault?
>=20
> This strange result inspired us to seek help on this mailing list.
>=20
> -- 6. How you can help --
> First of all, thank you for investing approximately 25 minutes towards =
reading this far (in case you skipped down here, that's fine too.)
> Now, with all that taken care of, we think it's time that we drop this =
line that you've been waiting for:
> We are asking interested developers to help us by providing us with =
suggestions, guidance, knowledge, or documents that resolves one or =
multiple of the unanswered questions below, as long as it's practical to =
do so.
> Even if you know nothing about questions 1~10, that's fine too! Just =
pointing us to related resources or developers who know this realm =
better is going to help us accelerate this acceleration project, and =
eventually bring full Hackintosh experiences to hundreds of AMD laptop =
users.
>=20
> -- 6.1. Unanswered questions --
> Despite having started working on this as early as 2022-07-10, we =
still have countless questions about the internal of the driver and the =
iGPU itself.
> However, since we are asking for guidance with the VM issue, we'll =
keep that our focus.
> So, here is what we'd like to know and/or figure out:
>    1. What does the NACK failing protection imply, and what actions =
can we take to fix it?
>    2. What does the PDE0 failing protection imply?
>    3. What does the value of PAGE_BLOCK_SIZE mean? We know what =
block_size is, but we still don't know about PAGE_BLOCK_SIZE.
>    4. What are the purposes of AMDGPU_PDE_BFS, and why is it only set =
when translate_further is on?
>    5. What do different AMDGPU_PTE_MTYPE_VG10 values mean, and could =
it be what's causing our issue? All we know is that it's related to =
caching in the MMU.
>    6. What are the purposes of fields in mmVM_L2_CNTL3? Specifically, =
why are BANK_SELECT and L2_CACHE_BIGK_FRAGMENT_SIZE set to different =
values when translate_further is on in AMDGPU?
>    7. What might be causing the strange phenomenon during the =
one-level VMPT test?
>    8. Why does none of the VMPTConfigs work, despite them matching =
everything we see in the AMDGPU code?
>    9. Is there any way to gain more insight into the VM address =
translation process and where it went wrong?
>    10. Have we done any mistakes with our analysis in Chapter 3/4? If =
so, how can we correct it?
>    11. Are there any resources we can refer to, other than the AMDGPU =
code, search engines, and this mailing list?
>=20
>=20
> -- 6.2. Ways to contact us --
>    - Via replying to this thread
>    - Via our Telegram group: https://t.me/+J6GPgy8g-445NDE1

