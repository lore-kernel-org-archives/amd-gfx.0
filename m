Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490A1C34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 15:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE3021D56
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 15:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh5XHPPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE3021D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB6D6E328;
	Tue, 18 Feb 2020 15:33:33 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83B16E328
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 15:33:31 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id w15so24482367wru.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 07:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=BzMxpd9nsEievi8p6WdFQP7L4lq3cUkSZqvDjIGuDD4=;
 b=Uh5XHPPaso7X7s6jCoS958Ob3NynkGTHUx3Da0Q2+Lf7iKNdF56Cc1E5As4aIz/6GH
 zk/4rRSJDrsJMe8TjNizNUGzkaBkLOCA3LeL8ITXujJV6robiqRyWfpc6YVDr16X3kcL
 cIIqOoHKfbyD+dOVLZ7SC1kp3iWAjHBgGmLbNgH6WMagd9QXwPpx4YCJHJip9m2Is/tj
 FU+dViZpyBiP2/zuATDpkI11A8WGWid6QbMMDQwxNDu1Wg9ctO0DJIAh9qrAfvjwHeZX
 WuDtF8fJcV1XYsw2iHS8j3p+4aurGL0WXRiVIrTp7yQCjnjqN7ZPjhWRdhJTUSNvuNwd
 7oXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=BzMxpd9nsEievi8p6WdFQP7L4lq3cUkSZqvDjIGuDD4=;
 b=IqXsHkaJJwzzge0oxSdi+qyyQ2vF+j3a4Qrd0C7DybsT2ie+A3QuIbH5atjQQYjmaN
 X4NbhUeLW2O3aEs5A25Q1VcAqHnUmqJB5HdU/2cMlhy6/6ORB394KuFqyF8m/cOea5lP
 7IeSJWv/x/vmbB2ks7tjdFf7uShOl7ag3xZqxjfLNieq6jmIB+Ws0+LUMv16hujS28xn
 E3ZNFP1RKzNqyYxygOl3nUvJod2qRzGSt2B8YIMmoFgKRZ4ZIsx1finXN9AmqUps4NfQ
 W0i0XPB4FNCPKA0xGzwrydTntclIr+TTgWJ/iuHmxDXjHer2cqv7BQWEumZ71E3kkj6t
 DnIA==
X-Gm-Message-State: APjAAAUOpe2L0rShdLNg+Sz+GYv8w9DnG6D7d7AXu4fa3ISW3bxl/1Pm
 +9o3h0P5ZdD/avgyvAIhyh9UQNnn
X-Google-Smtp-Source: APXvYqwpz8ze02sg0I3nV7rQCJQTGB+Q9lPUVsGRRXi1ufjEltLps57DjHFNtzHU0cMqFP1Zd6M3Ng==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr28615187wrw.31.1582040009702; 
 Tue, 18 Feb 2020 07:33:29 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id l15sm6376028wrv.39.2020.02.18.07.33.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Feb 2020 07:33:28 -0800 (PST)
Subject: Re: writing custom driver for VGA emulation ?
To: =?UTF-8?Q?Yusuf_Alt=c4=b1parmak?= <yusufalti1997@gmail.com>,
 "Bridgman, John" <John.Bridgman@amd.com>, amd-gfx@lists.freedesktop.org
References: <CAGzVRjzs8rgaLkWcaxdAn-DUf3Kk70TW=NPM+Hk9SLt7Tcjsfg@mail.gmail.com>
 <CADnq5_MutDzY0fdhX3anCQXFAOLkAbcMS3timfFEDFBqVc-jxA@mail.gmail.com>
 <DM6PR12MB3097CF2E5C2F02FC1C94F4ACE8110@DM6PR12MB3097.namprd12.prod.outlook.com>
 <460d7881-2223-12f1-bc47-b48b851d1138@gmail.com>
 <DM6PR12MB309715C009FB496F1D3B4B56E8110@DM6PR12MB3097.namprd12.prod.outlook.com>
 <CAGzVRjy8DRGxwgkz3-0=Jc06FNQRVzP3OrwdFwMNSAR09qvJgA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cf2ec61f-4a27-262f-ea8f-ad148d7faf8a@gmail.com>
Date: Tue, 18 Feb 2020 16:33:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAGzVRjy8DRGxwgkz3-0=Jc06FNQRVzP3OrwdFwMNSAR09qvJgA@mail.gmail.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Content-Type: multipart/mixed; boundary="===============0716530493=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0716530493==
Content-Type: multipart/alternative;
 boundary="------------DF65EF5AFD3EF1CD5DF1E7DA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------DF65EF5AFD3EF1CD5DF1E7DA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Yusuf,

good to hear that you were able to solve your MMIO problems.

And yes amdgpu has unfortunately some bugs on big endian systems.

But as John noted when you solved the issues with the MMIO BARs you can 
also use the Vesa driver with the VGA emulation.

Regards,
Christian.

Am 18.02.20 um 16:00 schrieb Yusuf Altıparmak:
> *Hello Mr. Alex, Mr. Cönig and Mr. Bridgman, *
> *
> *
> *Mr. Cönig, we have talked about MMIO problem before. You helped me a 
> lot about that and now driver is not giving any error about MMIO. That 
> problem was about bus configuration of my embedded system. It does not 
> proceed more than 4GB besides 0x0 adress is aligned for I/O and MMIO 
> is allowed between 0xE0000000 and 0xffffffff. Fortunately, I now am 
> able to claim 256 MB and other 4 BARs adress between this range. I can 
> attach lspci -v output. *
> *
> *
> *Mr. Bridgman, I am using U-boot as bootloader and the system is 64 
> bit PowerPc e5500 core. This means big endian kernel. *
> *
> *
> *Right now, the driver 'amdgpu' is having error when *
> *it tries to load smc firmware. I ve been trying to solve this problem 
> for months but I haven't solve it yet. *
> *
> *
> *Other firmwares seems loading without any error. I was suspecting 
> that endianness is causing this problem but if it was shouldn't other 
> firmwares get fail before smc firmware gets loaded? *
> *
> *
> *I tried all of the firmwares in repository but result remained same. *
> *
> *
> *Full dmesg:*
> [    5.426009] [drm] amdgpu kernel modesetting enabled.
> [    5.430109] [drm] initializing kernel modesetting (POLARIS12 
> 0x1002:0x6987 0x1787:0x2389 0x80).
> [    5.437591] [drm] register mmio base: 0x20200000
> [    5.440899] [drm] register mmio size: 262144
> [    5.443888] [drm] add ip block number 0 <vi_common>
> [    5.447465] [drm] add ip block number 1 <gmc_v8_0>
> [    5.450953] [drm] add ip block number 2 <tonga_ih>
> [    5.454442] [drm] add ip block number 3 <powerplay>
> [    5.458018] [drm] add ip block number 4 <dm>
> [    5.460979] [drm] add ip block number 5 <gfx_v8_0>
> [    5.464466] [drm] add ip block number 6 <sdma_v3_0>
> [    5.468042] [drm] add ip block number 7 <uvd_v6_0>
> [    5.471531] [drm] add ip block number 8 <vce_v3_0>
> [    5.475047] [drm] UVD is enabled in VM mode
> [    5.477928] [drm] UVD ENC is enabled in VM mode
> [    5.481154] [drm] VCE enabled in VM mode
> [    5.712355] ATOM BIOS: 113-ER16BFC-001
> [    5.714830] [drm] GPU posting now...
> [    5.833704] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, 
> fragment size is 9-bit
> [    5.840950] amdgpu 0001:01:00.0: BAR 2: releasing [mem 
> 0x220000000-0x2201fffff 64bit pref]
> [    5.847930] amdgpu 0001:01:00.0: BAR 0: releasing [mem 
> 0x210000000-0x21fffffff 64bit pref]
> [    5.855688] [drm:.amdgpu_device_resize_fb_bar [amdgpu]] *ERROR* 
> Problem resizing BAR0 (-2).
> [    5.855706] amdgpu 0001:01:00.0: BAR 0: assigned [mem 
> 0x230000000-0x23fffffff 64bit pref]
> [    5.869663] amdgpu 0001:01:00.0: BAR 2: assigned [mem 
> 0x240000000-0x2401fffff 64bit pref]
> [    5.876582] amdgpu 0001:01:00.0: VRAM: 4096M 0x000000F400000000 - 
> 0x000000F4FFFFFFFF (4096M used)
> [    5.884160] amdgpu 0001:01:00.0: GART: 256M 0x0000000000000000 - 
> 0x000000000FFFFFFF
> [    5.890519] [drm] Detected VRAM RAM=4096M, BAR=256M
> [    5.894093] [drm] RAM width 128bits GDDR5
> [    5.896941] [TTM] Zone  kernel: Available graphics memory: 4062380 kiB
> [    5.902177] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
> [    5.907402] [TTM] Initializing pool allocator
> [    5.910464] [TTM] Initializing DMA pool allocator
> [    5.919973] [drm] amdgpu: 4096M of VRAM memory ready
> [    5.923659] [drm] amdgpu: 4096M of GTT memory ready.
> [    5.927358] [drm] GART: num cpu pages 65536, num gpu pages 65536
> [    5.932957] [drm] PCIE GART of 256M enabled (table at 
> 0x000000F400000000).
> [    5.939122] [drm] Chained IB support enabled!
> [    5.948873] [drm] Found UVD firmware Version: 1.79 Family ID: 16
> [    5.953647] [drm] UVD ENC is disabled
> [    5.975818] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
> [    6.404774] amdgpu: [powerplay] Failed to send Message.
> [    6.835902] amdgpu: [powerplay] SMU Firmware start failed!
> [    6.840086] amdgpu: [powerplay] Failed to load SMU ucode.
> [    6.844184] amdgpu: [powerplay] smc start failed
> *[    6.847498] amdgpu: [powerplay] powerplay hw init failed *
> *[    6.852281] [drm:.amdgpu_device_init [amdgpu]] *ERROR* hw_init of 
> IP block <powerplay> failed -22*
> *[    6.859883] amdgpu 0001:01:00.0: amdgpu_device_ip_init failed * *
> [    6.864330] amdgpu 0001:01:00.0: Fatal error during GPU init * *
> [    6.868689] [drm] amdgpu: finishing device. *
> *[    7.339427] pcieport 0001:00:00.0: AER: Corrected error received: 
> 0001:00:00.0
> [    7.345374] pcieport 0001:00:00.0: PCIe Bus Error: 
> severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [    7.353993] pcieport 0001:00:00.0:   device [1957:0824] error 
> status/mask=00001000/00002000
> [    7.361047] pcieport 0001:00:00.0:    [12] Timeout *
> [    7.706137] amdgpu: [powerplay]
>                 last message was failed ret is 0
> [    8.127667] amdgpu: [powerplay]
>                 failed to send message 261 ret is 0
> [    8.966331] amdgpu: [powerplay]
>                 last message was failed ret is 0
> [    9.320290] pcieport 0001:00:00.0: AER: Corrected error received: 
> 0001:00:00.0
> [    9.326226] pcieport 0001:00:00.0: PCIe Bus Error: 
> severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [    9.334845] pcieport 0001:00:00.0:   device [1957:0824] error 
> status/mask=00001000/00002000
> [    9.341899] pcieport 0001:00:00.0:    [12] Timeout
> [    9.387975] amdgpu: [powerplay]
>                 failed to send message 261 ret is 0
> [   10.226636] amdgpu: [powerplay]
>                 last message was failed ret is 0
> [   10.648275] amdgpu: [powerplay]
>                 failed to send message 261 ret is 0
> [   11.486932] amdgpu: [powerplay]
>                 last message was failed ret is 0
> [   11.908570] amdgpu: [powerplay]
>                 failed to send message 261 ret is 0
> [   12.747228] amdgpu: [powerplay]
>                 last message was failed ret is 0
> [   13.168866] amdgpu: [powerplay]
>                 failed to send message 261 ret is 0
> [   14.007523] amdgpu: [powerplay]
>                 last message was failed ret is 0
> [   14.429161] amdgpu: [powerplay]
>                 failed to send message 261 ret is 0
> [   15.267816] amdgpu: [powerplay]
>                 last message was failed ret is 0
> [   15.689456] amdgpu: [powerplay]
>                 failed to send message 261 ret is 0
> [   16.528114] amdgpu: [powerplay]
>                 last message was failed ret is 0
> [   16.949756] amdgpu: [powerplay]
>                 failed to send message 261 ret is 0
> [   17.788411] amdgpu: [powerplay]
>                 last message was failed ret is 0
> [   18.210051] amdgpu: [powerplay]
>                 failed to send message 261 ret is 0
> [   19.048710] amdgpu: [powerplay]
>                 last message was failed ret is 0
> [   19.470347] amdgpu: [powerplay]
>                 failed to send message 261 ret is 0
> [   19.786774] [TTM] Finalizing pool allocator
> [   19.789696] [TTM] Finalizing DMA pool allocator
> [   19.793004] [TTM] Zone  kernel: Used memory at exit: 0 kiB
> [   19.797209] [TTM] Zone   dma32: Used memory at exit: 0 kiB
> [   19.801410] [drm] amdgpu: ttm finalized *
> [   19.804496] amdgpu: probe of 0001:01:00.0 failed with error -22 *
>
>
> 18 Şub 2020 Sal 17:43 tarihinde Bridgman, John <John.Bridgman@amd.com 
> <mailto:John.Bridgman@amd.com>> şunu yazdı:
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>
>     >And we already checked, 256MB is unfortunately the minimum you
>     can resize the VRAM BAR on the E9171 to.
>
>     Ahh, OK... I didn't realize we had already looked into that. I
>     guess that approach isn't going to work.
>
>     Yusef, guessing you are using a 32-bit CPU ? Is it possible to
>     talk to whoever does SBIOS for your platform to see if you could
>     maybe reduce address space allocated to RAM and bump up the MMIO
>     space ?
>
>     ------------------------------------------------------------------------
>     *From:* Christian König <ckoenig.leichtzumerken@gmail.com
>     <mailto:ckoenig.leichtzumerken@gmail.com>>
>     *Sent:* February 18, 2020 9:19 AM
>     *To:* Bridgman, John <John.Bridgman@amd.com
>     <mailto:John.Bridgman@amd.com>>; Alex Deucher
>     <alexdeucher@gmail.com <mailto:alexdeucher@gmail.com>>; Yusuf
>     Altıparmak <yusufalti1997@gmail.com <mailto:yusufalti1997@gmail.com>>
>     *Cc:* amd-gfx list <amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>>
>     *Subject:* Re: writing custom driver for VGA emulation ?
>     The problem Yusuf runs into is that his platform has multiple PCIe
>     root hubs, but only 512MB of MMIO address space. That is not
>     enough to fit all the BARs of an E9171 into.
>
>     But without the BARs neither the VGA emulation nor amdgpu not
>     anything else will work correctly.
>
>     And we already checked, 256MB is unfortunately the minimum you can
>     resize the VRAM BAR on the E9171 to.
>
>     What could maybe work is to trick the upstream bridge of the VGA
>     device into not routing all the addresses to the BARs and actually
>     use only a smaller portion of visible VRAM. But that would be
>     highly experimental and requires a rather big hack into the PCI(e)
>     subsystem in the Linux kernel.
>
>     Regards,
>     Christian.
>
>     Am 18.02.20 um 15:08 schrieb Bridgman, John:
>>
>>     [AMD Official Use Only - Internal Distribution Only]
>>
>>
>>     Does the VBIOS come up with something like a splash screen, ie is
>>     VBIOS able to initialize and drive the card ?
>>
>>     If so then another option might be to use a VESA driver rather
>>     than VGA.
>>
>>
>>     ------------------------------------------------------------------------
>>     *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
>>     <mailto:amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex
>>     Deucher <alexdeucher@gmail.com> <mailto:alexdeucher@gmail.com>
>>     *Sent:* February 18, 2020 8:50 AM
>>     *To:* Yusuf Altıparmak <yusufalti1997@gmail.com>
>>     <mailto:yusufalti1997@gmail.com>
>>     *Cc:* amd-gfx list <amd-gfx@lists.freedesktop.org>
>>     <mailto:amd-gfx@lists.freedesktop.org>
>>     *Subject:* Re: writing custom driver for VGA emulation ?
>>     On Tue, Feb 18, 2020 at 2:56 AM Yusuf Altıparmak
>>     <yusufalti1997@gmail.com> <mailto:yusufalti1997@gmail.com> wrote:
>>     >
>>     > Hello AMD team;
>>     >
>>     > I have E 9171 GPU and want to use it on a embedded system which
>>     has limited MMIO space on PCIe bus (MAX 512 MB).
>>     >
>>     > I received feedbacks that I can only use VGA emulation with
>>     this memory space. I was unable to get 'amdgpu' driver working
>>     with Xorg due to I had many errors(firmwares are not loading) in
>>     each step and tired of solving them one by one.
>>     >
>>     > I want to write a simple custom driver for this GPU with kernel
>>     version 4.19.
>>     > Is it possible to print some colors on screen with a custom
>>     driver over PCIe communication ? or writing some words on screen
>>     as VGA ?
>>     >
>>     > If answer is yes, then which code pieces (on amdgpu driver
>>     folder) or reference documentation should I use? I have Register
>>     Reference Guide.pdf.
>>     >
>>     > I will be appreciated for your guidance.
>>
>>     That is not going to do what you want on your platform.  The VGA
>>     emulation requires that you set up the card first to enable it, which
>>     in turn requires MMIO access and thus you are back to square one.
>>
>>     Alex
>>     _______________________________________________
>>     amd-gfx mailing list
>>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>>     https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cjohn.bridgman%40amd.com%7Ce7bf224775ad487d240708d7b47992f4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176306561328560&amp;sdata=QbfaIN%2F6LvgUihz5O0x41TwvdGYy7QTS5IVJq3RXYlA%3D&amp;reserved=0
>>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7CJohn.Bridgman%40amd.com%7Ccda5469b6f5f4ae43e6d08d7b47d899a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176323587003958&sdata=6eKo51jnHbE1QWkDB%2BN%2FFLMLB40HA2wVN3mU1l%2FeFhk%3D&reserved=0>
>>
>>     _______________________________________________
>>     amd-gfx mailing list
>>     amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7CJohn.Bridgman%40amd.com%7Ccda5469b6f5f4ae43e6d08d7b47d899a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176323587003958&sdata=6eKo51jnHbE1QWkDB%2BN%2FFLMLB40HA2wVN3mU1l%2FeFhk%3D&reserved=0>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------DF65EF5AFD3EF1CD5DF1E7DA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Yusuf,<br>
      <br>
      good to hear that you were able to solve your MMIO problems.<br>
      <br>
      And yes amdgpu has unfortunately some bugs on big endian systems.<br>
      <br>
      But as John noted when you solved the issues with the MMIO BARs
      you can also use the Vesa driver with the VGA emulation.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 18.02.20 um 16:00 schrieb Yusuf Altıparmak:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAGzVRjy8DRGxwgkz3-0=Jc06FNQRVzP3OrwdFwMNSAR09qvJgA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">
        <div style="font-family:sans-serif;font-size:12.8px" dir="auto">
          <div style="width:328px;margin:16px 0px">
            <div dir="ltr">
              <div dir="auto"><b>Hello Mr. Alex, Mr. Cönig and Mr.
                  Bridgman, </b></div>
              <div dir="auto"><b><br>
                </b></div>
              <div dir="auto"><b>Mr. Cönig, we have talked about MMIO
                  problem before. You helped me a lot about that and now
                  driver is not giving any error about MMIO. That
                  problem was about bus configuration of my embedded
                  system. It does not proceed more than 4GB besides 0x0
                  adress is aligned for I/O and MMIO is allowed between
                  0xE0000000 and 0xffffffff. Fortunately, I now am able
                  to claim 256 MB and other 4 BARs adress between this
                  range. I can attach lspci -v output. </b></div>
              <div dir="auto"><b><br>
                </b></div>
              <div dir="auto"><b>Mr. Bridgman, I am using U-boot as
                  bootloader and the system is 64 bit PowerPc e5500
                  core. This means big endian kernel. </b></div>
              <div dir="auto"><b><br>
                </b></div>
              <div dir="auto"><b>Right now, the driver 'amdgpu' is
                  having error when </b></div>
              <div dir="auto"><b>it tries to load smc firmware. I ve
                  been trying to solve this problem for months but I
                  haven't solve it yet. </b></div>
              <div dir="auto"><b><br>
                </b></div>
              <div dir="auto"><b>Other firmwares seems loading without
                  any error. I was suspecting that endianness is causing
                  this problem but if it was shouldn't other firmwares
                  get fail before smc firmware gets loaded? </b></div>
              <div dir="auto"><b><br>
                </b></div>
              <div dir="auto"><b>I tried all of the firmwares in
                  repository but result remained same. </b></div>
              <div dir="auto"><b><br>
                </b></div>
              <div><b>Full dmesg:</b><br>
              </div>
              <div dir="auto">[    5.426009] [drm] amdgpu kernel
                modesetting enabled.                                   
                                                  <br>
              </div>
              [    5.430109] [drm] initializing kernel modesetting
              (POLARIS12 0x1002:0x6987 0x1787:0x2389 0x80).            
                           <br>
              [    5.437591] [drm] register mmio base: 0x20200000      
                                                                       
                       <br>
              [    5.440899] [drm] register mmio size: 262144          
                                                                       
                       <br>
              [    5.443888] [drm] add ip block number 0
              &lt;vi_common&gt;                                        
                                           <br>
              [    5.447465] [drm] add ip block number 1
              &lt;gmc_v8_0&gt;                                          
                                           <br>
              [    5.450953] [drm] add ip block number 2
              &lt;tonga_ih&gt;                                          
                                           <br>
              [    5.454442] [drm] add ip block number 3
              &lt;powerplay&gt;                                        
                                           <br>
              [    5.458018] [drm] add ip block number 4 &lt;dm&gt;    
                                                                       
                             <br>
              [    5.460979] [drm] add ip block number 5
              &lt;gfx_v8_0&gt;                                          
                                           <br>
              [    5.464466] [drm] add ip block number 6
              &lt;sdma_v3_0&gt;                                        
                                           <br>
              [    5.468042] [drm] add ip block number 7
              &lt;uvd_v6_0&gt;                                          
                                           <br>
              [    5.471531] [drm] add ip block number 8
              &lt;vce_v3_0&gt;                                          
                                           <br>
              [    5.475047] [drm] UVD is enabled in VM mode            
                                                                       
                     <br>
              [    5.477928] [drm] UVD ENC is enabled in VM mode        
                                                                       
                     <br>
              [    5.481154] [drm] VCE enabled in VM mode              
                                                                       
                       <br>
              [    5.712355] ATOM BIOS: 113-ER16BFC-001                
                                                                       
                       <br>
              [    5.714830] [drm] GPU posting now...                  
                                                                       
                       <br>
              [    5.833704] [drm] vm size is 64 GB, 2 levels, block
              size is 10-bit, fragment size is 9-bit                    
                         <br>
              [    5.840950] amdgpu 0001:01:00.0: BAR 2: releasing [mem
              0x220000000-0x2201fffff 64bit pref]                      
                       <br>
              [    5.847930] amdgpu 0001:01:00.0: BAR 0: releasing [mem
              0x210000000-0x21fffffff 64bit pref]                      
                       <br>
              [    5.855688] [drm:.amdgpu_device_resize_fb_bar [amdgpu]]
              *ERROR* Problem resizing BAR0 (-2).                      
                     <br>
              [    5.855706] amdgpu 0001:01:00.0: BAR 0: assigned [mem
              0x230000000-0x23fffffff 64bit pref]                      
                       <br>
              [    5.869663] amdgpu 0001:01:00.0: BAR 2: assigned [mem
              0x240000000-0x2401fffff 64bit pref]                      
                       <br>
              [    5.876582] amdgpu 0001:01:00.0: VRAM: 4096M
              0x000000F400000000 - 0x000000F4FFFFFFFF (4096M used)      
                               <br>
              [    5.884160] amdgpu 0001:01:00.0: GART: 256M
              0x0000000000000000 - 0x000000000FFFFFFF                  
                                 <br>
              [    5.890519] [drm] Detected VRAM RAM=4096M, BAR=256M    
                                                                       
                     <br>
              [    5.894093] [drm] RAM width 128bits GDDR5              
                                                                       
                     <br>
              [    5.896941] [TTM] Zone  kernel: Available graphics
              memory: 4062380 kiB                                      
                           <br>
              [    5.902177] [TTM] Zone   dma32: Available graphics
              memory: 2097152 kiB                                      
                           <br>
              [    5.907402] [TTM] Initializing pool allocator          
                                                                       
                     <br>
              [    5.910464] [TTM] Initializing DMA pool allocator      
                                                                       
                     <br>
              [    5.919973] [drm] amdgpu: 4096M of VRAM memory ready  
                                                                       
                       <br>
              [    5.923659] [drm] amdgpu: 4096M of GTT memory ready.  
                                                                       
                       <br>
              [    5.927358] [drm] GART: num cpu pages 65536, num gpu
              pages 65536                                              
                         <br>
              [    5.932957] [drm] PCIE GART of 256M enabled (table at
              0x000000F400000000).                                      
                       <br>
              [    5.939122] [drm] Chained IB support enabled!          
                                                                       
                     <br>
              [    5.948873] [drm] Found UVD firmware Version: 1.79
              Family ID: 16                                            
                           <br>
              [    5.953647] [drm] UVD ENC is disabled                  
                                                                       
                     <br>
              [    5.975818] [drm] Found VCE firmware Version: 52.4
              Binary ID: 3                                              
                         <br>
              [    6.404774] amdgpu: [powerplay] Failed to send Message.
                                                                       
                     <br>
              [    6.835902] amdgpu: [powerplay] SMU Firmware start
              failed!                                                  
                           <br>
              [    6.840086] amdgpu: [powerplay] Failed to load SMU
              ucode.                                                    
                         <br>
              [    6.844184] amdgpu: [powerplay] smc start failed      
                                                                       
                       <br>
              <b>[    6.847498] amdgpu: [powerplay] powerplay hw init
                failed </b>                                             
                                 <br>
              <b>[    6.852281] [drm:.amdgpu_device_init [amdgpu]]
                *ERROR* hw_init of IP block &lt;powerplay&gt; failed -22</b>  
                                   <br>
              <b>[    6.859883] amdgpu 0001:01:00.0:
                amdgpu_device_ip_init failed </b>              <b>     
                                                       <br>
                [    6.864330] amdgpu 0001:01:00.0: Fatal error during
                GPU init  </b>                   <b>                   
                                     <br>
                [    6.868689] [drm] amdgpu: finishing device. </b>     
                                                                       
                           <br>
              <b>[    7.339427] pcieport 0001:00:00.0: AER: Corrected
                error received: 0001:00:00.0                            
                               <br>
                [    7.345374] pcieport 0001:00:00.0: PCIe Bus Error:
                severity=Corrected, type=Data Link Layer, (Transmitter
                ID)            <br>
                [    7.353993] pcieport 0001:00:00.0:   device
                [1957:0824] error status/mask=00001000/00002000        
                                     <br>
                [    7.361047] pcieport 0001:00:00.0:    [12] Timeout  
                 </b>                                                  
                               <br>
              [    7.706137] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              last message was failed ret is 0          
                                                                       
                     <br>
              [    8.127667] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              failed to send message 261 ret is 0      
                                                                       
                       <br>
              [    8.966331] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              last message was failed ret is 0          
                                                                       
                     <br>
              [    9.320290] pcieport 0001:00:00.0: AER: Corrected error
              received: 0001:00:00.0                                    
                     <br>
              [    9.326226] pcieport 0001:00:00.0: PCIe Bus Error:
              severity=Corrected, type=Data Link Layer, (Transmitter ID)
                         <br>
              [    9.334845] pcieport 0001:00:00.0:   device [1957:0824]
              error status/mask=00001000/00002000                      
                     <br>
              [    9.341899] pcieport 0001:00:00.0:    [12] Timeout    
                                                                       
                       <br>
              [    9.387975] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              failed to send message 261 ret is 0      
                                                                       
                       <br>
              [   10.226636] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              last message was failed ret is 0          
                                                                       
                     <br>
              [   10.648275] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              failed to send message 261 ret is 0      
                                                                       
                       <br>
              [   11.486932] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              last message was failed ret is 0          
                                                                       
                     <br>
              [   11.908570] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              failed to send message 261 ret is 0      
                                                                       
                       <br>
              [   12.747228] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              last message was failed ret is 0          
                                                                       
                     <br>
              [   13.168866] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              failed to send message 261 ret is 0      
                                                                       
                       <br>
              [   14.007523] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              last message was failed ret is 0          
                                                                       
                     <br>
              [   14.429161] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              failed to send message 261 ret is 0      
                                                                       
                       <br>
              [   15.267816] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              last message was failed ret is 0          
                                                                       
                     <br>
              [   15.689456] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              failed to send message 261 ret is 0      
                                                                       
                       <br>
              [   16.528114] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              last message was failed ret is 0          
                                                                       
                     <br>
              [   16.949756] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              failed to send message 261 ret is 0      
                                                                       
                       <br>
              [   17.788411] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              last message was failed ret is 0          
                                                                       
                     <br>
              [   18.210051] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              failed to send message 261 ret is 0      
                                                                       
                       <br>
              [   19.048710] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              last message was failed ret is 0          
                                                                       
                     <br>
              [   19.470347] amdgpu: [powerplay]                        
                                                                       
                     <br>
                              failed to send message 261 ret is 0      
                                                                       
                       <br>
              [   19.786774] [TTM] Finalizing pool allocator            
                                                                       
                     <br>
              [   19.789696] [TTM] Finalizing DMA pool allocator        
                                                                       
                     <br>
              [   19.793004] [TTM] Zone  kernel: Used memory at exit: 0
              kiB                                                      
                       <br>
              [   19.797209] [TTM] Zone   dma32: Used memory at exit: 0
              kiB                                                      
                       <br>
              [   19.801410] [drm] amdgpu: ttm finalized                
                                                    <b>                 
                         <br>
                [   19.804496] amdgpu: probe of 0001:01:00.0 failed with
                error -22 </b><br>
            </div>
          </div>
        </div>
        <div style="font-family:sans-serif;font-size:12.8px" dir="auto"><br>
        </div>
        <br>
        <div class="gmail_quote" dir="auto">
          <div dir="ltr" class="gmail_attr">18 Şub 2020 Sal 17:43
            tarihinde Bridgman, John &lt;<a
              href="mailto:John.Bridgman@amd.com" moz-do-not-send="true">John.Bridgman@amd.com</a>&gt;
            şunu yazdı:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div dir="ltr">
              <p
                style="font-family:Arial;font-size:10pt;color:#0078d7;margin:15pt"
                align="Left">
                [AMD Official Use Only - Internal Distribution Only]<br>
              </p>
              <br>
              <div>
                <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">&gt;And
                  we already checked, 256MB is unfortunately the minimum
                  you can resize the VRAM BAR on the E9171 to.<br>
                </div>
                <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><br>
                </div>
                <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">Ahh,
                  OK... I didn't realize we had already looked into
                  that. I guess that approach isn't going to work.
                  <br>
                </div>
                <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><br>
                </div>
                <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">Yusef,
                  guessing you are using a 32-bit CPU ? Is it possible
                  to talk to whoever does SBIOS for your platform to see
                  if you could maybe reduce address space allocated to
                  RAM and bump up the MMIO space ?<br>
                </div>
                <div>
                  <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><br>
                  </div>
                  <hr style="display:inline-block;width:98%">
                  <div id="m_-1727261425459073512divRplyFwdMsg"
                    dir="ltr"><font style="font-size:11pt"
                      face="Calibri, sans-serif" color="#000000"><b>From:</b>
                      Christian König &lt;<a
                        href="mailto:ckoenig.leichtzumerken@gmail.com"
                        target="_blank" rel="noreferrer"
                        moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                      <b>Sent:</b> February 18, 2020 9:19 AM<br>
                      <b>To:</b> Bridgman, John &lt;<a
                        href="mailto:John.Bridgman@amd.com"
                        target="_blank" rel="noreferrer"
                        moz-do-not-send="true">John.Bridgman@amd.com</a>&gt;;
                      Alex Deucher &lt;<a
                        href="mailto:alexdeucher@gmail.com"
                        target="_blank" rel="noreferrer"
                        moz-do-not-send="true">alexdeucher@gmail.com</a>&gt;;
                      Yusuf Altıparmak &lt;<a
                        href="mailto:yusufalti1997@gmail.com"
                        target="_blank" rel="noreferrer"
                        moz-do-not-send="true">yusufalti1997@gmail.com</a>&gt;<br>
                      <b>Cc:</b> amd-gfx list &lt;<a
                        href="mailto:amd-gfx@lists.freedesktop.org"
                        target="_blank" rel="noreferrer"
                        moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                      <b>Subject:</b> Re: writing custom driver for VGA
                      emulation ?</font>
                    <div> </div>
                  </div>
                  <div style="background-color:#ffffff">
                    <div>The problem Yusuf runs into is that his
                      platform has multiple PCIe root hubs, but only
                      512MB of MMIO address space. That is not enough to
                      fit all the BARs of an E9171 into.<br>
                      <br>
                      But without the BARs neither the VGA emulation nor
                      amdgpu not anything else will work correctly.<br>
                      <br>
                      And we already checked, 256MB is unfortunately the
                      minimum you can resize the VRAM BAR on the E9171
                      to.<br>
                      <br>
                      What could maybe work is to trick the upstream
                      bridge of the VGA device into not routing all the
                      addresses to the BARs and actually use only a
                      smaller portion of visible VRAM. But that would be
                      highly experimental and requires a rather big hack
                      into the PCI(e) subsystem in the Linux kernel.<br>
                      <br>
                      Regards,<br>
                      Christian.<br>
                      <br>
                      Am 18.02.20 um 15:08 schrieb Bridgman, John:<br>
                    </div>
                    <blockquote type="cite">
                      <p
style="margin-top:0px;margin-bottom:0px;font-family:Arial;font-size:10pt;color:#0078d7;margin:15pt"
                        align="Left">
                        [AMD Official Use Only - Internal Distribution
                        Only]<br>
                      </p>
                      <br>
                      <div>
                        <div>Does the VBIOS come up with something like
                          a splash screen, ie is VBIOS able to
                          initialize and drive the card ?<br>
                        </div>
                        <div><br>
                        </div>
                        <div>If so then another option might be to use a
                          VESA driver rather than VGA. <br>
                        </div>
                        <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><br>
                        </div>
                        <div>
                          <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><br>
                          </div>
                          <hr style="display:inline-block;width:98%">
                          <div
                            id="m_-1727261425459073512x_divRplyFwdMsg"
                            dir="ltr"><font style="font-size:11pt"
                              face="Calibri, sans-serif" color="#000000"><b>From:</b>
                              amd-gfx
                              <a
                                href="mailto:amd-gfx-bounces@lists.freedesktop.org"
                                target="_blank" rel="noreferrer"
                                moz-do-not-send="true">
&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on behalf of Alex
                              Deucher <a
                                href="mailto:alexdeucher@gmail.com"
                                target="_blank" rel="noreferrer"
                                moz-do-not-send="true">
                                &lt;alexdeucher@gmail.com&gt;</a><br>
                              <b>Sent:</b> February 18, 2020 8:50 AM<br>
                              <b>To:</b> Yusuf Altıparmak <a
                                href="mailto:yusufalti1997@gmail.com"
                                target="_blank" rel="noreferrer"
                                moz-do-not-send="true">
                                &lt;yusufalti1997@gmail.com&gt;</a><br>
                              <b>Cc:</b> amd-gfx list <a
                                href="mailto:amd-gfx@lists.freedesktop.org"
                                target="_blank" rel="noreferrer"
                                moz-do-not-send="true">
                                &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                              <b>Subject:</b> Re: writing custom driver
                              for VGA emulation ?</font>
                            <div> </div>
                          </div>
                          <div><font size="2"><span
                                style="font-size:11pt">
                                <div>On Tue, Feb 18, 2020 at 2:56 AM
                                  Yusuf Altıparmak<br>
                                  <a
                                    href="mailto:yusufalti1997@gmail.com"
                                    target="_blank" rel="noreferrer"
                                    moz-do-not-send="true">&lt;yusufalti1997@gmail.com&gt;</a>
                                  wrote:<br>
                                  &gt;<br>
                                  &gt; Hello AMD team;<br>
                                  &gt;<br>
                                  &gt; I have E 9171 GPU and want to use
                                  it on a embedded system which has
                                  limited MMIO space on PCIe bus (MAX
                                  512 MB).<br>
                                  &gt;<br>
                                  &gt; I received feedbacks that I can
                                  only use VGA emulation with this
                                  memory space. I was unable to get
                                  'amdgpu' driver working with Xorg due
                                  to I had many errors(firmwares are not
                                  loading) in each step and tired of
                                  solving them one by one.<br>
                                  &gt;<br>
                                  &gt; I want to write a simple custom
                                  driver for this GPU with kernel
                                  version 4.19.<br>
                                  &gt; Is it possible to print some
                                  colors on screen with a custom driver
                                  over PCIe communication ? or writing
                                  some words on screen as VGA ?<br>
                                  &gt;<br>
                                  &gt; If answer is yes, then which code
                                  pieces (on amdgpu driver folder) or
                                  reference documentation should I use?
                                  I have Register Reference Guide.pdf.<br>
                                  &gt;<br>
                                  &gt; I will be appreciated for your
                                  guidance.<br>
                                  <br>
                                  That is not going to do what you want
                                  on your platform.  The VGA<br>
                                  emulation requires that you set up the
                                  card first to enable it, which<br>
                                  in turn requires MMIO access and thus
                                  you are back to square one.<br>
                                  <br>
                                  Alex<br>
_______________________________________________<br>
                                  amd-gfx mailing list<br>
                                  <a
                                    href="mailto:amd-gfx@lists.freedesktop.org"
                                    target="_blank" rel="noreferrer"
                                    moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                                  <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CJohn.Bridgman%40amd.com%7Ccda5469b6f5f4ae43e6d08d7b47d899a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176323587003958&amp;sdata=6eKo51jnHbE1QWkDB%2BN%2FFLMLB40HA2wVN3mU1l%2FeFhk%3D&amp;reserved=0"
                                    target="_blank" rel="noreferrer"
                                    moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cjohn.bridgman%40amd.com%7Ce7bf224775ad487d240708d7b47992f4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176306561328560&amp;amp;sdata=QbfaIN%2F6LvgUihz5O0x41TwvdGYy7QTS5IVJq3RXYlA%3D&amp;amp;reserved=0</a><br>
                                </div>
                              </span></font></div>
                        </div>
                      </div>
                      <br>
                      <fieldset></fieldset>
                      <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" rel="noreferrer" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CJohn.Bridgman%40amd.com%7Ccda5469b6f5f4ae43e6d08d7b47d899a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176323587003958&amp;sdata=6eKo51jnHbE1QWkDB%2BN%2FFLMLB40HA2wVN3mU1l%2FeFhk%3D&amp;reserved=0" target="_blank" rel="noreferrer" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                    </blockquote>
                    <br>
                    <br>
                  </div>
                </div>
              </div>
            </div>
          </blockquote>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------DF65EF5AFD3EF1CD5DF1E7DA--

--===============0716530493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0716530493==--
