Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960D2C10DCE
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Dec 2023 15:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0FA310E254;
	Mon,  4 Dec 2023 15:19:06 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 383A910E0AD
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Dec 2023 15:19:00 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3332e351670so3114189f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Dec 2023 07:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701703138; x=1702307938; darn=lists.freedesktop.org;
 h=in-reply-to:from:references:to:content-language:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=o4VuvGo+NefBrlJEOHkTKyshBrHAFAdGKIG54mfClhg=;
 b=iq15hOMR9F5wAZLglzfolYmFPCXpAIY8rqikfPbXnJOFzTRYjzJRoaqyFRLoNdhAMi
 kiCyMVfZMgnVqFRlAEN9Z/NiZFaEKcGBkK/fH6e1zQms2cPYH7NFqa92h1MsTxMdm6ug
 xNONOZFewmqJO2U1TPGWlwLFKwWQKXqcQqVtZf3dp0fOKUEhmEiXXwboA7/9o6frXIZx
 PJV4c3DPSSYwUuQ/v8PdDy6SiHwA/8B9FvBPf3m++fvPQic+UHSYVcLdp86Mv+Y460mY
 u1/s1ZVLoyIkbcEJPFT0qmyaC+HAmKI6v1JfA3XO3PDGyi63TSZge0PuP5SWi6GcPF0D
 CZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701703138; x=1702307938;
 h=in-reply-to:from:references:to:content-language:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=o4VuvGo+NefBrlJEOHkTKyshBrHAFAdGKIG54mfClhg=;
 b=eqBRiCkCOLcD0cmo+14dCMhtF5V9TWowqlaXKoKn69GXblEIFO04N5C5ZBzixLYeJ2
 EZqEJGyOp0wAzMVu1x6bfjohVJFGu4IdJdXb/gPeB8Ndtj2TWSnVhGjfuGcxM+ED198a
 sdJQYoYtYfV4hJuQ2MsNO68AqN97X7thMciLubA7GesRpPDiYp0AuTGWAkk00zJdAIIh
 JRnNf2WnAZnDG6PffNauq9AwpodAUsuGtGAUT2plgVTK+GpUy3URRFsvec5QANfmmJ1Z
 XMIPdnogoi95p3ILuIUgYZYdZVavjTKG8R7F6/pFcV8t3CrgrDC/Z1NKw0gCKSkfhaGT
 Af6A==
X-Gm-Message-State: AOJu0YzVx9tfjAhArJnMQT0/BTt8j8MmvR32qv8cufgkr4BSkxhK410d
 1pQOVaHV+7+DOv1tZmgIRq7EJIJGfNM=
X-Google-Smtp-Source: AGHT+IH13Xinmt9nVA17RMhZEqNBJkDGuoRl4/LIok5dNx6daiewvfOeQC4OsiitDkDvWa9w1n5gsA==
X-Received: by 2002:a5d:5f4c:0:b0:333:3a3f:c116 with SMTP id
 cm12-20020a5d5f4c000000b003333a3fc116mr1183698wrb.97.1701703138141; 
 Mon, 04 Dec 2023 07:18:58 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 dm11-20020a0560000bcb00b0033334625bdbsm8434972wrb.13.2023.12.04.07.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 07:18:57 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------jLZ7rac0QqkZXxKVwOmsKPY1"
Message-ID: <deebdf5a-0502-4f0b-8bd6-73d2d5cee985@gmail.com>
Date: Mon, 4 Dec 2023 16:18:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: radeon flooding "flip queue failed" in Xorg and system log
Content-Language: en-US
To: smesgr <smesgr@protonmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <u3yh82fTwsugAjP-wALhJy32bKLPaZ6_m4O6YbPTQqf9pk1Jf7b4N3nV-cyRd3wTvr9qWxaOe5z38kADdsWu_tJglXCpshEdMJXwbJ9FV70=@protonmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <u3yh82fTwsugAjP-wALhJy32bKLPaZ6_m4O6YbPTQqf9pk1Jf7b4N3nV-cyRd3wTvr9qWxaOe5z38kADdsWu_tJglXCpshEdMJXwbJ9FV70=@protonmail.com>
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
--------------jLZ7rac0QqkZXxKVwOmsKPY1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.12.23 um 20:00 schrieb smesgr:
> Hi,
>
> I have installed Debian 12 on my old Fujitsu S920 with AMD GX-424CC.
> After the installation completed, my logs are flooded by the following 
> error messages:
>
> dmesg:
> [  967.869183] radeon 0000:00:01.0: 000000003ba3c813 pin failed
> [  967.869212] [drm:radeon_crtc_page_flip_target [radeon]] *ERROR* 
> failed to pin new rbo buffer before flip
> [  967.886254] radeon 0000:00:01.0: 0000000051be2216 pin failed
> [  967.886282] [drm:radeon_crtc_page_flip_target [radeon]] *ERROR* 
> failed to pin new rbo buffer before flip
> [  967.907984] radeon 0000:00:01.0: 000000003ba3c813 pin failed
> [  967.908014] [drm:radeon_crtc_page_flip_target [radeon]] *ERROR* 
> failed to pin new rbo buffer before flip
> [  967.925551] radeon 0000:00:01.0: 0000000051be2216 pin failed
> [  967.925580] [drm:radeon_crtc_page_flip_target [radeon]] *ERROR* 
> failed to pin new rbo buffer before flip
>
> Xorg.log
> [  47.777] (WW) RADEON(0): flip queue failed: Invalid argument
> [    47.777] (WW) RADEON(0): Page flip failed: Invalid argument
> [    47.777] (EE) RADEON(0): present flip failed
>
> lspci:
> 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc. 
> [AMD/ATI] Mullins [Radeon R4/R5 Graphics] (rev 01) (prog-if 00 [VGA 
> controller])
> Subsystem: Fujitsu Technology Solutions Mullins [Radeon R4/R5 Graphics]
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 35
> Region 0: Memory at f8000000 (64-bit, prefetchable) [size=64M]
> Region 2: Memory at fc000000 (64-bit, prefetchable) [size=8M]
> Region 4: I/O ports at f000 [size=256]
> Region 5: Memory at feb00000 (32-bit, non-prefetchable) [size=256K]
> Expansion ROM at 000c0000 [disabled] [size=128K]
> Capabilities: [48] Vendor Specific Information: Len=08 <?>
> Capabilities: [50] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [58] Express (v2) Root Complex Integrated Endpoint, MSI 00
> DevCap: MaxPayload 256 bytes, PhantFunc 0
> ExtTag+ RBE+ FLReset-
> DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
> MaxPayload 256 bytes, MaxReadReq 512 bytes
> DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq+ AuxPwr- TransPend-
> DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
> 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, 
> MaxEETLPPrefixes 1
> EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> FRS-
> AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 
> 10BitTagReq- OBFF Disabled,
> AtomicOpsCtl: ReqEn-
> Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
> Address: 00000000fee08004  Data: 0023
> Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
> Len=010 <?>
> Capabilities: [270 v1] Secondary PCI Express
> LnkCtl3: LnkEquIntrruptEn- PerformEqu-
> LaneErrStat: 0
> Capabilities: [2b0 v1] Address Translation Service (ATS)
> ATSCap: Invalidate Queue Depth: 00
> ATSCtl: Enable-, Smallest Translation Unit: 00
> Capabilities: [2c0 v1] Page Request Interface (PRI)
> PRICtl: Enable- Reset-
> PRISta: RF- UPRGI- Stopped+
> Page Request Capacity: 00000020, Page Request Allocation: 00000000
> Capabilities: [2d0 v1] Process Address Space ID (PASID)
> PASIDCap: Exec+ Priv+, Max PASID Width: 10
> PASIDCtl: Enable- Exec- Priv-
> Kernel driver in use: radeon
> Kernel modules: radeon, amdgpu
>
> I'm a bit confused. Is this an kernel issue, Xorg issue or something else?

Well, what is connected to the GPU? E.g. what monitor, projector or 
other display device do you use?

What happens is that only 64MiB is assigned to the device and for some 
reason a process (maybe the compositor?) Is trying to do double or 
triple buffering and doesn't has enough memory for that.

So it falls back to single buffering, that might work but will probably 
not look as good and you see tons of error messages.

You most likely can go into the BIOS and reserve more memory to the GPU 
(it will just be stolen from system memory).

Regards,
Christian.

>
> kernel:
> Linux debian 6.1.0-13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.55-1 
> (2023-09-29) x86_64 GNU/Linux
>
> Xorg:
> [  33.144]
> X.Org <http://X.Org> X Server 1.21.1.7
> X Protocol Version 11, Revision 0
> [    33.144] Current Operating System: Linux debian 6.1.0-13-amd64 #1 
> SMP PREEMPT_DYNAMIC Debian 6.1.55-1 (2023-09-29) x86_64
> [    33.144] Kernel command line: 
> BOOT_IMAGE=/boot/vmlinuz-6.1.0-13-amd64 
> root=UUID=4101c568-e073-42f4-8dfe-08373fceb13c ro quiet
> [    33.144] xorg-server 2:21.1.7-3 (https://www.debian.org/support)
> [    33.144] Current version of pixman: 0.42.2
> [    33.144] Before reporting problems, check http://wiki.x.org
> to make sure that you have the latest version.
>
> I searched bug tracker and could only find this issue: 
> https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati/-/issues/180 
> but I don't have a black screen. The system is rather sluggish but 
> seems to work.
> I did try older version of Debian back to 10.13. All have this issue. 
> I'm very sure the eLux which came with the box did not have this.
>
> Any hints where to go next is very appreciated.
>
> Best Regards

--------------jLZ7rac0QqkZXxKVwOmsKPY1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 02.12.23 um 20:00 schrieb smesgr:<br>
    <blockquote type="cite"
cite="mid:u3yh82fTwsugAjP-wALhJy32bKLPaZ6_m4O6YbPTQqf9pk1Jf7b4N3nV-cyRd3wTvr9qWxaOe5z38kADdsWu_tJglXCpshEdMJXwbJ9FV70=@protonmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <span style="background-color: rgb(255, 255, 255);">Hi,</span>
      <div style="background-color: rgb(255, 255, 255);"><br>
      </div>
      <div style="background-color: rgb(255, 255, 255);">I have
        installed Debian 12 on my old Fujitsu S920 with AMD GX-424CC.<br>
      </div>
      <div style="background-color: rgb(255, 255, 255);">After the
        installation completed, my logs are flooded by the following
        error messages:</div>
      <div style="background-color: rgb(255, 255, 255);"><br>
      </div>
      <div style="background-color: rgb(255, 255, 255);">dmesg:</div>
      <div style="background-color: rgb(255, 255, 255);"><span>[
           967.869183] radeon 0000:00:01.0: 000000003ba3c813 pin failed</span>
        <div><span>[  967.869212] [drm:radeon_crtc_page_flip_target
            [radeon]] *ERROR* failed to pin new rbo buffer before flip</span></div>
        <div><span>[  967.886254] radeon 0000:00:01.0: 0000000051be2216
            pin failed</span></div>
        <div><span>[  967.886282] [drm:radeon_crtc_page_flip_target
            [radeon]] *ERROR* failed to pin new rbo buffer before flip</span></div>
        <div><span>[  967.907984] radeon 0000:00:01.0: 000000003ba3c813
            pin failed</span></div>
        <div><span>[  967.908014] [drm:radeon_crtc_page_flip_target
            [radeon]] *ERROR* failed to pin new rbo buffer before flip</span></div>
        <div><span>[  967.925551] radeon 0000:00:01.0: 0000000051be2216
            pin failed</span></div>
        <span>[  967.925580] [drm:radeon_crtc_page_flip_target [radeon]]
          *ERROR* failed to pin new rbo buffer before flip</span></div>
      <div style="background-color: rgb(255, 255, 255);"><br>
      </div>
      <div style="background-color: rgb(255, 255, 255);">Xorg.log</div>
      <div style="background-color: rgb(255, 255, 255);"><span>[  
           47.777] (WW) RADEON(0): flip queue failed: Invalid argument</span>
        <div><span>[    47.777] (WW) RADEON(0): Page flip failed:
            Invalid argument</span></div>
        <span>[    47.777] (EE) RADEON(0): present flip failed</span></div>
      <div style="background-color: rgb(255, 255, 255);"><br>
      </div>
      <div style="background-color: rgb(255, 255, 255);">lspci:</div>
      <div style="background-color: rgb(255, 255, 255);"><span>00:01.0
          VGA compatible controller: Advanced Micro Devices, Inc.
          [AMD/ATI] Mullins [Radeon R4/R5 Graphics] (rev 01) (prog-if 00
          [VGA controller])</span>
        <div><span> Subsystem: Fujitsu Technology Solutions Mullins
            [Radeon R4/R5 Graphics]</span></div>
        <div><span> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
            VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+</span></div>
        <div><span> Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
            DEVSEL=fast &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR-
            &lt;PERR- INTx-</span></div>
        <div><span> Latency: 0, Cache Line Size: 64 bytes</span></div>
        <div><span> Interrupt: pin A routed to IRQ 35</span></div>
        <div><span> Region 0: Memory at f8000000 (64-bit, prefetchable)
            [size=64M]</span></div>
        <div><span> Region 2: Memory at fc000000 (64-bit, prefetchable)
            [size=8M]</span></div>
        <div><span> Region 4: I/O ports at f000 [size=256]</span></div>
        <div><span> Region 5: Memory at feb00000 (32-bit,
            non-prefetchable) [size=256K]</span></div>
        <div><span> Expansion ROM at 000c0000 [disabled] [size=128K]</span></div>
        <div><span> Capabilities: [48] Vendor Specific Information:
            Len=08 &lt;?&gt;</span></div>
        <div><span> Capabilities: [50] Power Management version 3</span></div>
        <div><span> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
            PME(D0-,D1+,D2+,D3hot+,D3cold-)</span></div>
        <div><span> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0
            PME-</span></div>
        <div><span> Capabilities: [58] Express (v2) Root Complex
            Integrated Endpoint, MSI 00</span></div>
        <div><span> DevCap: MaxPayload 256 bytes, PhantFunc 0</span></div>
        <div><span> ExtTag+ RBE+ FLReset-</span></div>
        <div><span> DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-</span></div>
        <div><span> RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+</span></div>
        <div><span> MaxPayload 256 bytes, MaxReadReq 512 bytes</span></div>
        <div><span> DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq+
            AuxPwr- TransPend-</span></div>
        <div><span> DevCap2: Completion Timeout: Not Supported,
            TimeoutDis- NROPrPrP- LTR-</span></div>
        <div><span> 10BitTagComp- 10BitTagReq- OBFF Not Supported,
            ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1</span></div>
        <div><span> EmergencyPowerReduction Not Supported,
            EmergencyPowerReductionInit-</span></div>
        <div><span> FRS-</span></div>
        <div><span> AtomicOpsCap: 32bit- 64bit- 128bitCAS-</span></div>
        <div><span> DevCtl2: Completion Timeout: 50us to 50ms,
            TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,</span></div>
        <div><span> AtomicOpsCtl: ReqEn-</span></div>
        <div><span> Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable-
            64bit+</span></div>
        <div><span> Address: 00000000fee08004  Data: 0023</span></div>
        <div><span> Capabilities: [100 v1] Vendor Specific Information:
            ID=0001 Rev=1 Len=010 &lt;?&gt;</span></div>
        <div><span> Capabilities: [270 v1] Secondary PCI Express</span></div>
        <div><span> LnkCtl3: LnkEquIntrruptEn- PerformEqu-</span></div>
        <div><span> LaneErrStat: 0</span></div>
        <div><span> Capabilities: [2b0 v1] Address Translation Service
            (ATS)</span></div>
        <div><span> ATSCap: Invalidate Queue Depth: 00</span></div>
        <div><span> ATSCtl: Enable-, Smallest Translation Unit: 00</span></div>
        <div><span> Capabilities: [2c0 v1] Page Request Interface (PRI)</span></div>
        <div><span> PRICtl: Enable- Reset-</span></div>
        <div><span> PRISta: RF- UPRGI- Stopped+</span></div>
        <div><span> Page Request Capacity: 00000020, Page Request
            Allocation: 00000000</span></div>
        <div><span> Capabilities: [2d0 v1] Process Address Space ID
            (PASID)</span></div>
        <div><span> PASIDCap: Exec+ Priv+, Max PASID Width: 10</span></div>
        <div><span> PASIDCtl: Enable- Exec- Priv-</span></div>
        <div><span> Kernel driver in use: radeon</span></div>
        <span> Kernel modules: radeon, amdgpu</span></div>
      <div style="background-color: rgb(255, 255, 255);"><br>
      </div>
      <div style="background-color: rgb(255, 255, 255);">I'm a bit
        confused. Is this an kernel issue, Xorg issue or something else?</div>
    </blockquote>
    <br>
    Well, what is connected to the GPU? E.g. what monitor, projector or
    other display device do you use?<br>
    <br>
    What happens is that only 64MiB is assigned to the device and for
    some reason a process (maybe the compositor?) Is trying to do double
    or triple buffering and doesn't has enough memory for that.<br>
    <br>
    So it falls back to single buffering, that might work but will
    probably not look as good and you see tons of error messages.<br>
    <br>
    You most likely can go into the BIOS and reserve more memory to the
    GPU (it will just be stolen from system memory).<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:u3yh82fTwsugAjP-wALhJy32bKLPaZ6_m4O6YbPTQqf9pk1Jf7b4N3nV-cyRd3wTvr9qWxaOe5z38kADdsWu_tJglXCpshEdMJXwbJ9FV70=@protonmail.com">
      <div style="background-color: rgb(255, 255, 255);"><br>
      </div>
      <div style="background-color: rgb(255, 255, 255);">kernel:</div>
      <div style="background-color: rgb(255, 255, 255);"><span>Linux
          debian 6.1.0-13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.55-1
          (2023-09-29) x86_64 GNU/Linux</span><br>
        <span></span></div>
      <div style="background-color: rgb(255, 255, 255);"><br>
      </div>
      <div style="background-color: rgb(255, 255, 255);">Xorg:<br>
      </div>
      <div style="background-color: rgb(255, 255, 255);"><span>[  
           33.144] </span>
        <div><span><a href="http://X.Org"
              rel="noreferrer nofollow noopener" target="_blank"
              moz-do-not-send="true">X.Org</a> X Server 1.21.1.7</span></div>
        <div><span>X Protocol Version 11, Revision 0</span></div>
        <div><span>[    33.144] Current Operating System: Linux debian
            6.1.0-13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.55-1
            (2023-09-29) x86_64</span></div>
        <div><span>[    33.144] Kernel command line:
            BOOT_IMAGE=/boot/vmlinuz-6.1.0-13-amd64
            root=UUID=4101c568-e073-42f4-8dfe-08373fceb13c ro quiet</span></div>
        <div><span>[    33.144] xorg-server 2:21.1.7-3 (<a
              href="https://www.debian.org/support"
              rel="noreferrer nofollow noopener" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">https://www.debian.org/support</a>)
          </span></div>
        <div><span>[    33.144] Current version of pixman: 0.42.2</span></div>
        <div><span>[    33.144] Before reporting problems, check <a
              href="http://wiki.x.org"
              rel="noreferrer nofollow noopener" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">http://wiki.x.org</a></span></div>
        <span> to make sure that you have the latest version.</span></div>
      <div style="background-color: rgb(255, 255, 255);"><span><br>
        </span></div>
      <div style="background-color: rgb(255, 255, 255);"><span>I
          searched bug tracker and could only find this issue:  <span><a
href="https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati/-/issues/180"
              rel="noreferrer nofollow noopener" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati/-/issues/180</a></span>
          but I don't have a black screen. The system is rather sluggish
          but seems to work.</span></div>
      <div style="background-color: rgb(255, 255, 255);"><span>I did try
          older version of Debian back to 10.13. All have this issue.
          I'm very sure the eLux which came with the box did not have
          this.<br>
        </span></div>
      <div style="background-color: rgb(255, 255, 255);"><span><br>
        </span></div>
      <div style="background-color: rgb(255, 255, 255);"><span>Any hints
          where to go next is very <span>appreciated</span>.</span></div>
      <div style="background-color: rgb(255, 255, 255);"><span><br>
        </span></div>
      <span style="background-color: rgb(255, 255, 255);"><span>Best
          Regards</span></span>
      <div class="protonmail_signature_block"
        style="font-family: Arial, sans-serif; font-size: 14px;">
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------jLZ7rac0QqkZXxKVwOmsKPY1--
