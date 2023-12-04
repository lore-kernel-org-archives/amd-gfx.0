Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F109C4167B
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Dec 2023 16:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E0C510E302;
	Mon,  4 Dec 2023 16:59:01 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E967710E302
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Dec 2023 16:58:53 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c0a03eb87so15286875e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Dec 2023 08:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701709132; x=1702313932; darn=lists.freedesktop.org;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lLEJBAXzKo3Px0U4/jT2hqZLff7YhUl0J8dygi4HjE=;
 b=A0GuT0jJh9wwD9e9Mmoaa44yJYqVYSm8ydMLWKB+OSPOrPIU4ZBA3eaol59wK2+kI3
 2Mczs8lDcqRMsWc++m7ly+8mo1LTg8Qy7FNph1B/vNHX78plpnnfTA7VkNrgsUXC0c/0
 Gl259XOBG090rb7nr/WwPoU3fmIAShIMXWqp89die4hmJwH+aSRDHZbpAKK/cPmScD74
 0Wi3DTAj0LTTXmCeta4V9WtLCRICP40deW7lYop27BlE3J209huXEzwWmuUIDxmpu8OJ
 JAwyPg4J+YjHNVML3xaY6AT0epTw/Xncvvj3K6bELGg2N0EoBf0V8V9/eWZj11R6rRjK
 SQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701709132; x=1702313932;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8lLEJBAXzKo3Px0U4/jT2hqZLff7YhUl0J8dygi4HjE=;
 b=mpqYYV+/hSMFyXOQY92MfO+VDJnvIQvA0mrPgNw2QZopQoRhPjTFlJVE1besmh9epM
 Mvk2Ibnma9j5yGPusdH3AD+ALG3+FejanL0CiWstusKqq+VtRgNQIbjsOM3CZbhw9IxQ
 vLI+VHBY6Pt4o1+Q7I0NP2yNRqXJxSzf1RMyRKZgv5OCTZfcTIAUafBk31zcOUpceVwu
 YJBmQG7KV16gotyrdHI9VFkPTNsoFYk8P5El4SimNIvDKPSOItHdrhq3lyJwd3UAIpFm
 hG/AqEUsjv9aktlxbS/NFTF2kTJWTz2uL5Pe66YU7WtL4540QfUMWdncTe7nA0dqGXbS
 cByQ==
X-Gm-Message-State: AOJu0YwgbVP7YT+/2t4As8BdUTD9ghZTtumGv7lSPOMLIarF9dSal2Hj
 7fcmqsPhDOzmMFHHtb5/68I=
X-Google-Smtp-Source: AGHT+IGCzGH80sYF02cKbZ4RC57CAeRpe4EM4NE1d6Uv8JSiN9qSNo+jsph99Q/AWJVnOrm8af7VtA==
X-Received: by 2002:a1c:7418:0:b0:40b:5e59:f726 with SMTP id
 p24-20020a1c7418000000b0040b5e59f726mr1309523wmc.152.1701709131823; 
 Mon, 04 Dec 2023 08:58:51 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 p23-20020a05600c1d9700b0040b3645a7c2sm19568068wms.40.2023.12.04.08.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 08:58:51 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------WJq1byfXDCXCnw7sPzvdAm4e"
Message-ID: <b4806f6f-b18d-4b49-9762-b2c85ff06bf9@gmail.com>
Date: Mon, 4 Dec 2023 17:58:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: radeon flooding "flip queue failed" in Xorg and system log
Content-Language: en-US
To: smesgr <smesgr@protonmail.com>
References: <u3yh82fTwsugAjP-wALhJy32bKLPaZ6_m4O6YbPTQqf9pk1Jf7b4N3nV-cyRd3wTvr9qWxaOe5z38kADdsWu_tJglXCpshEdMJXwbJ9FV70=@protonmail.com>
 <deebdf5a-0502-4f0b-8bd6-73d2d5cee985@gmail.com>
 <_ghIPI7KEaEIZNuxoFM2Gui55Qu12bw_3fiiU7mO3rwnEBGwLyYT1fCdXb8o4xej6Pw0ApccKIgXRo2_lbeibCDx3EfM1jGkcTcdop9vSww=@protonmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <_ghIPI7KEaEIZNuxoFM2Gui55Qu12bw_3fiiU7mO3rwnEBGwLyYT1fCdXb8o4xej6Pw0ApccKIgXRo2_lbeibCDx3EfM1jGkcTcdop9vSww=@protonmail.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------WJq1byfXDCXCnw7sPzvdAm4e
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Well, essentially we shouldn't print the error from the kernel in the 
first place and just return the correct error code to the userspace 
application.

The userspace application/driver would then say: Oh, I don't have enough 
memory for triple buffering, maybe I should just fallback to double 
buffering....

Retrying the same approach over and over again is not really a good 
implementation from userspace.

But devices with only 64MiB of VRAM are rare today, so....

Regards,
Christian.

Am 04.12.23 um 17:38 schrieb smesgr:
> Hi Chrisitan,
>
> you are right, after bumping the memory in BIOS the error goes away. 
> Still would be nice if the error would point to "out of VMem" or 
> something.
>
> Best Regards
> Christian König <ckoenig.leichtzumerken@gmail.com> schrieb am Montag, 
> 4. Dezember 2023 um 16:18:
>
>> Am 02.12.23 um 20:00 schrieb smesgr:
>>> Hi,
>>>
>>> I have installed Debian 12 on my old Fujitsu S920 with AMD GX-424CC.
>>> After the installation completed, my logs are flooded by the 
>>> following error messages:
>>>
>>> dmesg:
>>> [ 967.869183] radeon 0000:00:01.0: 000000003ba3c813 pin failed
>>> [ 967.869212] [drm:radeon_crtc_page_flip_target [radeon]] *ERROR* 
>>> failed to pin new rbo buffer before flip
>>> [ 967.886254] radeon 0000:00:01.0: 0000000051be2216 pin failed
>>> [ 967.886282] [drm:radeon_crtc_page_flip_target [radeon]] *ERROR* 
>>> failed to pin new rbo buffer before flip
>>> [ 967.907984] radeon 0000:00:01.0: 000000003ba3c813 pin failed
>>> [ 967.908014] [drm:radeon_crtc_page_flip_target [radeon]] *ERROR* 
>>> failed to pin new rbo buffer before flip
>>> [ 967.925551] radeon 0000:00:01.0: 0000000051be2216 pin failed
>>> [ 967.925580] [drm:radeon_crtc_page_flip_target [radeon]] *ERROR* 
>>> failed to pin new rbo buffer before flip
>>>
>>> Xorg.log
>>> [ 47.777] (WW) RADEON(0): flip queue failed: Invalid argument
>>> [ 47.777] (WW) RADEON(0): Page flip failed: Invalid argument
>>> [ 47.777] (EE) RADEON(0): present flip failed
>>>
>>> lspci:
>>> 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc. 
>>> [AMD/ATI] Mullins [Radeon R4/R5 Graphics] (rev 01) (prog-if 00 [VGA 
>>> controller])
>>> Subsystem: Fujitsu Technology Solutions Mullins [Radeon R4/R5 Graphics]
>>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
>>> Stepping- SERR- FastB2B- DisINTx+
>>> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>> Latency: 0, Cache Line Size: 64 bytes
>>> Interrupt: pin A routed to IRQ 35
>>> Region 0: Memory at f8000000 (64-bit, prefetchable) [size=64M]
>>> Region 2: Memory at fc000000 (64-bit, prefetchable) [size=8M]
>>> Region 4: I/O ports at f000 [size=256]
>>> Region 5: Memory at feb00000 (32-bit, non-prefetchable) [size=256K]
>>> Expansion ROM at 000c0000 [disabled] [size=128K]
>>> Capabilities: [48] Vendor Specific Information: Len=08 <?>
>>> Capabilities: [50] Power Management version 3
>>> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
>>> PME(D0-,D1+,D2+,D3hot+,D3cold-)
>>> Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>> Capabilities: [58] Express (v2) Root Complex Integrated Endpoint, MSI 00
>>> DevCap: MaxPayload 256 bytes, PhantFunc 0
>>> ExtTag+ RBE+ FLReset-
>>> DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>> RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>>> MaxPayload 256 bytes, MaxReadReq 512 bytes
>>> DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq+ AuxPwr- TransPend-
>>> DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
>>> 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, 
>>> MaxEETLPPrefixes 1
>>> EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>>> FRS-
>>> AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>>> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 
>>> 10BitTagReq- OBFF Disabled,
>>> AtomicOpsCtl: ReqEn-
>>> Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>> Address: 00000000fee08004 Data: 0023
>>> Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
>>> Len=010 <?>
>>> Capabilities: [270 v1] Secondary PCI Express
>>> LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>>> LaneErrStat: 0
>>> Capabilities: [2b0 v1] Address Translation Service (ATS)
>>> ATSCap: Invalidate Queue Depth: 00
>>> ATSCtl: Enable-, Smallest Translation Unit: 00
>>> Capabilities: [2c0 v1] Page Request Interface (PRI)
>>> PRICtl: Enable- Reset-
>>> PRISta: RF- UPRGI- Stopped+
>>> Page Request Capacity: 00000020, Page Request Allocation: 00000000
>>> Capabilities: [2d0 v1] Process Address Space ID (PASID)
>>> PASIDCap: Exec+ Priv+, Max PASID Width: 10
>>> PASIDCtl: Enable- Exec- Priv-
>>> Kernel driver in use: radeon
>>> Kernel modules: radeon, amdgpu
>>>
>>> I'm a bit confused. Is this an kernel issue, Xorg issue or something 
>>> else?
>>
>> Well, what is connected to the GPU? E.g. what monitor, projector or 
>> other display device do you use?
>>
>> What happens is that only 64MiB is assigned to the device and for 
>> some reason a process (maybe the compositor?) Is trying to do double 
>> or triple buffering and doesn't has enough memory for that.
>>
>> So it falls back to single buffering, that might work but will 
>> probably not look as good and you see tons of error messages.
>>
>> You most likely can go into the BIOS and reserve more memory to the 
>> GPU (it will just be stolen from system memory).
>>
>> Regards,
>> Christian.
>>
>>>
>>> kernel:
>>> Linux debian 6.1.0-13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.55-1 
>>> (2023-09-29) x86_64 GNU/Linux
>>>
>>> Xorg:
>>> [ 33.144]
>>> X.Org <http://X.Org> X Server 1.21.1.7
>>> X Protocol Version 11, Revision 0
>>> [ 33.144] Current Operating System: Linux debian 6.1.0-13-amd64 #1 
>>> SMP PREEMPT_DYNAMIC Debian 6.1.55-1 (2023-09-29) x86_64
>>> [ 33.144] Kernel command line: 
>>> BOOT_IMAGE=/boot/vmlinuz-6.1.0-13-amd64 
>>> root=UUID=4101c568-e073-42f4-8dfe-08373fceb13c ro quiet
>>> [ 33.144] xorg-server 2:21.1.7-3 (https://www.debian.org/support)
>>> [ 33.144] Current version of pixman: 0.42.2
>>> [ 33.144] Before reporting problems, check http://wiki.x.org
>>> to make sure that you have the latest version.
>>>
>>> I searched bug tracker and could only find this issue: 
>>> https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati/-/issues/180 
>>> but I don't have a black screen. The system is rather sluggish but 
>>> seems to work.
>>> I did try older version of Debian back to 10.13. All have this 
>>> issue. I'm very sure the eLux which came with the box did not have this.
>>>
>>> Any hints where to go next is very appreciated.
>>>
>>> Best Regards
>>
>

--------------WJq1byfXDCXCnw7sPzvdAm4e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Well, essentially we shouldn't print the error from the kernel in
    the first place and just return the correct error code to the
    userspace application.<br>
    <br>
    The userspace application/driver would then say: Oh, I don't have
    enough memory for triple buffering, maybe I should just fallback to
    double buffering....<br>
    <br>
    Retrying the same approach over and over again is not really a good
    implementation from userspace.<br>
    <br>
    But devices with only 64MiB of VRAM are rare today, so....<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 04.12.23 um 17:38 schrieb smesgr:<br>
    </div>
    <blockquote type="cite"
cite="mid:_ghIPI7KEaEIZNuxoFM2Gui55Qu12bw_3fiiU7mO3rwnEBGwLyYT1fCdXb8o4xej6Pw0ApccKIgXRo2_lbeibCDx3EfM1jGkcTcdop9vSww=@protonmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div>Hi Chrisitan,</div>
      <div
style="font-family: Arial, sans-serif; font-size: 14px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);"><br>
      </div>
      <div
style="font-family: Arial, sans-serif; font-size: 14px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">you
        are right, after bumping the memory in BIOS the error goes away.
        Still would be nice if the error would point to "out of VMem" or
        something.<br>
      </div>
      <div
style="font-family: Arial, sans-serif; font-size: 14px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);"><br>
      </div>
      <div
style="font-family: Arial, sans-serif; font-size: 14px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">Best
        Regards<br>
      </div>
      <div class="protonmail_quote"> Christian König
        <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a> schrieb am Montag, 4.
        Dezember 2023 um 16:18:<br>
        <br>
        <blockquote class="protonmail_quote" type="cite"> Am 02.12.23 um
          20:00 schrieb smesgr:<br>
          <blockquote type="cite"> <span
              style="background-color: rgb(255, 255, 255);">Hi,</span>
            <div style="background-color: rgb(255, 255, 255);"><br>
            </div>
            <div style="background-color: rgb(255, 255, 255);">I have
              installed Debian 12 on my old Fujitsu S920 with AMD
              GX-424CC.<br>
            </div>
            <div style="background-color: rgb(255, 255, 255);">After the
              installation completed, my logs are flooded by the
              following error messages:</div>
            <div style="background-color: rgb(255, 255, 255);"><br>
            </div>
            <div style="background-color: rgb(255, 255, 255);">dmesg:</div>
            <div style="background-color: rgb(255, 255, 255);"><span>[
                967.869183] radeon 0000:00:01.0: 000000003ba3c813 pin
                failed</span>
              <div><span>[ 967.869212] [drm:radeon_crtc_page_flip_target
                  [radeon]] *ERROR* failed to pin new rbo buffer before
                  flip</span></div>
              <div><span>[ 967.886254] radeon 0000:00:01.0:
                  0000000051be2216 pin failed</span></div>
              <div><span>[ 967.886282] [drm:radeon_crtc_page_flip_target
                  [radeon]] *ERROR* failed to pin new rbo buffer before
                  flip</span></div>
              <div><span>[ 967.907984] radeon 0000:00:01.0:
                  000000003ba3c813 pin failed</span></div>
              <div><span>[ 967.908014] [drm:radeon_crtc_page_flip_target
                  [radeon]] *ERROR* failed to pin new rbo buffer before
                  flip</span></div>
              <div><span>[ 967.925551] radeon 0000:00:01.0:
                  0000000051be2216 pin failed</span></div>
              <span>[ 967.925580] [drm:radeon_crtc_page_flip_target
                [radeon]] *ERROR* failed to pin new rbo buffer before
                flip</span></div>
            <div style="background-color: rgb(255, 255, 255);"><br>
            </div>
            <div style="background-color: rgb(255, 255, 255);">Xorg.log</div>
            <div style="background-color: rgb(255, 255, 255);"><span>[
                47.777] (WW) RADEON(0): flip queue failed: Invalid
                argument</span>
              <div><span>[ 47.777] (WW) RADEON(0): Page flip failed:
                  Invalid argument</span></div>
              <span>[ 47.777] (EE) RADEON(0): present flip failed</span></div>
            <div style="background-color: rgb(255, 255, 255);"><br>
            </div>
            <div style="background-color: rgb(255, 255, 255);">lspci:</div>
            <div style="background-color: rgb(255, 255, 255);"><span>00:01.0
                VGA compatible controller: Advanced Micro Devices, Inc.
                [AMD/ATI] Mullins [Radeon R4/R5 Graphics] (rev 01)
                (prog-if 00 [VGA controller])</span>
              <div><span> Subsystem: Fujitsu Technology Solutions
                  Mullins [Radeon R4/R5 Graphics]</span></div>
              <div><span> Control: I/O+ Mem+ BusMaster+ SpecCycle-
                  MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
                  DisINTx+</span></div>
              <div><span> Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
                  DEVSEL=fast &gt;TAbort- &lt;TAbort- &lt;MAbort-
                  &gt;SERR- &lt;PERR- INTx-</span></div>
              <div><span> Latency: 0, Cache Line Size: 64 bytes</span></div>
              <div><span> Interrupt: pin A routed to IRQ 35</span></div>
              <div><span> Region 0: Memory at f8000000 (64-bit,
                  prefetchable) [size=64M]</span></div>
              <div><span> Region 2: Memory at fc000000 (64-bit,
                  prefetchable) [size=8M]</span></div>
              <div><span> Region 4: I/O ports at f000 [size=256]</span></div>
              <div><span> Region 5: Memory at feb00000 (32-bit,
                  non-prefetchable) [size=256K]</span></div>
              <div><span> Expansion ROM at 000c0000 [disabled]
                  [size=128K]</span></div>
              <div><span> Capabilities: [48] Vendor Specific
                  Information: Len=08 &lt;?&gt;</span></div>
              <div><span> Capabilities: [50] Power Management version 3</span></div>
              <div><span> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
                  PME(D0-,D1+,D2+,D3hot+,D3cold-)</span></div>
              <div><span> Status: D0 NoSoftRst- PME-Enable- DSel=0
                  DScale=0 PME-</span></div>
              <div><span> Capabilities: [58] Express (v2) Root Complex
                  Integrated Endpoint, MSI 00</span></div>
              <div><span> DevCap: MaxPayload 256 bytes, PhantFunc 0</span></div>
              <div><span> ExtTag+ RBE+ FLReset-</span></div>
              <div><span> DevCtl: CorrErr- NonFatalErr- FatalErr-
                  UnsupReq-</span></div>
              <div><span> RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+</span></div>
              <div><span> MaxPayload 256 bytes, MaxReadReq 512 bytes</span></div>
              <div><span> DevSta: CorrErr- NonFatalErr+ FatalErr-
                  UnsupReq+ AuxPwr- TransPend-</span></div>
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
              <div><span> Capabilities: [a0] MSI: Enable+ Count=1/1
                  Maskable- 64bit+</span></div>
              <div><span> Address: 00000000fee08004 Data: 0023</span></div>
              <div><span> Capabilities: [100 v1] Vendor Specific
                  Information: ID=0001 Rev=1 Len=010 &lt;?&gt;</span></div>
              <div><span> Capabilities: [270 v1] Secondary PCI Express</span></div>
              <div><span> LnkCtl3: LnkEquIntrruptEn- PerformEqu-</span></div>
              <div><span> LaneErrStat: 0</span></div>
              <div><span> Capabilities: [2b0 v1] Address Translation
                  Service (ATS)</span></div>
              <div><span> ATSCap: Invalidate Queue Depth: 00</span></div>
              <div><span> ATSCtl: Enable-, Smallest Translation Unit: 00</span></div>
              <div><span> Capabilities: [2c0 v1] Page Request Interface
                  (PRI)</span></div>
              <div><span> PRICtl: Enable- Reset-</span></div>
              <div><span> PRISta: RF- UPRGI- Stopped+</span></div>
              <div><span> Page Request Capacity: 00000020, Page Request
                  Allocation: 00000000</span></div>
              <div><span> Capabilities: [2d0 v1] Process Address Space
                  ID (PASID)</span></div>
              <div><span> PASIDCap: Exec+ Priv+, Max PASID Width: 10</span></div>
              <div><span> PASIDCtl: Enable- Exec- Priv-</span></div>
              <div><span> Kernel driver in use: radeon</span></div>
              <span> Kernel modules: radeon, amdgpu</span></div>
            <div style="background-color: rgb(255, 255, 255);"><br>
            </div>
            <div style="background-color: rgb(255, 255, 255);">I'm a bit
              confused. Is this an kernel issue, Xorg issue or something
              else?</div>
          </blockquote>
          <br>
          Well, what is connected to the GPU? E.g. what monitor,
          projector or other display device do you use?<br>
          <br>
          What happens is that only 64MiB is assigned to the device and
          for some reason a process (maybe the compositor?) Is trying to
          do double or triple buffering and doesn't has enough memory
          for that.<br>
          <br>
          So it falls back to single buffering, that might work but will
          probably not look as good and you see tons of error messages.<br>
          <br>
          You most likely can go into the BIOS and reserve more memory
          to the GPU (it will just be stolen from system memory).<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          <blockquote type="cite">
            <div style="background-color: rgb(255, 255, 255);"><br>
            </div>
            <div style="background-color: rgb(255, 255, 255);">kernel:</div>
            <div style="background-color: rgb(255, 255, 255);"><span>Linux
                debian 6.1.0-13-amd64 #1 SMP PREEMPT_DYNAMIC Debian
                6.1.55-1 (2023-09-29) x86_64 GNU/Linux</span><br>
              <span></span></div>
            <div style="background-color: rgb(255, 255, 255);"><br>
            </div>
            <div style="background-color: rgb(255, 255, 255);">Xorg:<br>
            </div>
            <div style="background-color: rgb(255, 255, 255);"><span>[
                33.144] </span>
              <div><span><a target="_blank"
                    rel="noreferrer nofollow noopener"
                    href="http://X.Org" moz-do-not-send="true">X.Org</a>
                  X Server 1.21.1.7</span></div>
              <div><span>X Protocol Version 11, Revision 0</span></div>
              <div><span>[ 33.144] Current Operating System: Linux
                  debian 6.1.0-13-amd64 #1 SMP PREEMPT_DYNAMIC Debian
                  6.1.55-1 (2023-09-29) x86_64</span></div>
              <div><span>[ 33.144] Kernel command line:
                  BOOT_IMAGE=/boot/vmlinuz-6.1.0-13-amd64
                  root=UUID=4101c568-e073-42f4-8dfe-08373fceb13c ro
                  quiet</span></div>
              <div><span>[ 33.144] xorg-server 2:21.1.7-3 (<a
                    class="moz-txt-link-freetext" target="_blank"
                    rel="noreferrer nofollow noopener"
                    href="https://www.debian.org/support"
                    moz-do-not-send="true">https://www.debian.org/support</a>)
                </span></div>
              <div><span>[ 33.144] Current version of pixman: 0.42.2</span></div>
              <div><span>[ 33.144] Before reporting problems, check <a
                    class="moz-txt-link-freetext" target="_blank"
                    rel="noreferrer nofollow noopener"
                    href="http://wiki.x.org" moz-do-not-send="true">http://wiki.x.org</a></span></div>
              <span> to make sure that you have the latest version.</span></div>
            <div style="background-color: rgb(255, 255, 255);"><span><br>
              </span></div>
            <div style="background-color: rgb(255, 255, 255);"><span>I
                searched bug tracker and could only find this issue: <span><a
                    class="moz-txt-link-freetext" target="_blank"
                    rel="noreferrer nofollow noopener"
href="https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati/-/issues/180"
                    moz-do-not-send="true">https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati/-/issues/180</a></span>
                but I don't have a black screen. The system is rather
                sluggish but seems to work.</span></div>
            <div style="background-color: rgb(255, 255, 255);"><span>I
                did try older version of Debian back to 10.13. All have
                this issue. I'm very sure the eLux which came with the
                box did not have this.<br>
              </span></div>
            <div style="background-color: rgb(255, 255, 255);"><span><br>
              </span></div>
            <div style="background-color: rgb(255, 255, 255);"><span>Any
                hints where to go next is very <span>appreciated</span>.</span></div>
            <div style="background-color: rgb(255, 255, 255);"><span><br>
              </span></div>
            <span style="background-color: rgb(255, 255, 255);"><span>Best
                Regards</span></span>
            <div
              style="font-family: Arial, sans-serif; font-size: 14px;"
              class="protonmail_signature_block"> </div>
          </blockquote>
          <br>
        </blockquote>
        <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------WJq1byfXDCXCnw7sPzvdAm4e--
