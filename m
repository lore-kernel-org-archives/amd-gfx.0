Return-Path: <SRS0=VEb6=7A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73E7C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 13:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A625B20674
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 13:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVJ3lUoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A625B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E1956E1A8;
	Mon, 18 May 2020 13:51:42 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD2B6E1A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2020 13:51:41 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id d207so75691wmd.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2020 06:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cQb/RKpf8FbXnAOu6VyIkPqQESDZOW7JHH8IkJAqaZc=;
 b=kVJ3lUohBO/UwZ+TOprX6X1onjZwYjG8N04WYDbytyNC2+jU3LHDvDhvylpF1F2rcZ
 lrfIemvJ8ClCFcXf3mO3W10xPICzaEtZLPFvBr28IVxRuwQNDoopxxLDg7h6p4w4yCT/
 biSNx/bd/TDczBiqRef3/8eMgBIUPoFZ81hFR/2RxiDwP3ghenp+veUE+ZL0NgJYnhzl
 MRLjbcebKYJSfcvU7v5bHj3i0IE2RthZ8Lm6ExoANEaonYypqZKfT3fcoAWyDkBhxoF4
 HXPOYLH8uOt2Fc4vVVmyz6sdlko09Xm6ZNg3uxyitT5YyCcYUi8MFhPbMXiLMkDmyXiB
 zfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cQb/RKpf8FbXnAOu6VyIkPqQESDZOW7JHH8IkJAqaZc=;
 b=nwSbQC3e34d8WJ1LgCb64wt/vNKjTmV/4Y/V9zwNBGz9h2KnyP8zzeECJw4K76XQh7
 UeLALWoRvYcSrNGkslkAkfI1PkrldZ2XWOm0mFq60zSlPuM/JtIgVsjWiYfcQ82GzENs
 O/K7eoBxUaiAvClOiOOJEungP5Qe/h4ud2FX6ILIrpXdn8AVaH859sOpkZPLMcFEjJgN
 1YDc+rBNvBtlokPiClbpBhNH2B+MlgNn+wCH4z9gZDFaEqMw2sV+n779UQ19UDPxjc5G
 KD7O78JhZumKZ9xeoTJqwQiftQMW3zaqn8OrOl02KutsFmiq9MPUzOZZK9yqSs9xOA4G
 I8KQ==
X-Gm-Message-State: AOAM533UFiVHQYnbM88Q0WBYZTT2zpq05QtchuWVfijulCLiIyht79yc
 ENJT3Qby8sA0uzhjGcRMhx997uqHjaEK2RQ2aMVZqg==
X-Google-Smtp-Source: ABdhPJypOp8Fk/rVhYebutcH6WdaAANEgvq03UUPRVI4tubcwkmZ2i8jas1UiGJiDkh6yrH3NtPg/kgJr4OHLbIZJJ4=
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr19800408wmh.39.1589809900438; 
 Mon, 18 May 2020 06:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAEOHGOnvFxBtFixhVWtO=Mx3t2-0YYJM8pHD_FaKhQRTkjJjTw@mail.gmail.com>
 <CAEOHGOkqs3qicXrT_wWZEbedXoT2Mp884aMSLEDBBYKDWbdnKg@mail.gmail.com>
 <CAEOHGOmj3YKRi9zWgGwt4YSvULx=JY7hnVQU_JVTXkMZHQ4Duw@mail.gmail.com>
In-Reply-To: <CAEOHGOmj3YKRi9zWgGwt4YSvULx=JY7hnVQU_JVTXkMZHQ4Duw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 May 2020 09:51:29 -0400
Message-ID: <CADnq5_PzpMWyu_CNQnT_ceMRLi4q-kSSQz_EwW0Fo46pUWvaEA@mail.gmail.com>
Subject: Re: XFX RX 5600 XT Raw II graphics card slow
To: Javad Karabi <karabijavad@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, May 17, 2020 at 5:25 PM Javad Karabi <karabijavad@gmail.com> wrote:
>
> hmm, actually upon digging deeper, it looks like the latest
> linux-firmware doesnt have navi10_mes.bin.
> if i understand correctly, the rx 5600 xt is navi10, right?
> navi10_mes.bin is one of the firmware files that update-initramfs is
> saying is missing.
>
> is there any way i can get my hands on navi10_mes.bin?

It's an optional firmware that is not used by the driver at this
point.  You can ignore it.

Alex

>
>
> On Sun, May 17, 2020 at 4:02 PM Javad Karabi <karabijavad@gmail.com> wrote:
> >
> > oh, i also flashed the card bios with the bios provided at:
> > https://www.xfxforce.com/gpus/xfx-amd-radeon-tm-rx-5600-xt-6gb-gddr6-raw-ii
> >
> > if you scroll down a bit and click on downloads, they have a link to a "performance bios". i flashed that, and nothing changed. after the flash, the card still worked great in windows, and still terrible in linux. so i guess that flash didnt change anything.
> >
> > also, fyi i do have the latest linux-firmware installed (since apparently there was some issue with the firmware for the rx 5600 which was solved in the latest firmware i guess)
> >
> > $ md5sum /lib/firmware/amdgpu/navi10_smc.bin
> > 632de739379e484c0233f6808cba2c7f  /lib/firmware/amdgpu/navi10_smc.bin
> >
> > On Sun, May 17, 2020 at 3:51 PM Javad Karabi <karabijavad@gmail.com> wrote:
> >>
> >> Heres my setup:
> >>
> >> kernel: linux-5.6.13
> >> card: XFX RX 5600 XT Raw II  (https://www.bestbuy.com/site/xfx-amd-radeon-rx-5600-xt-raw-ii-pro-6gb-gddr6-pci-express-4-0-graphics-card/6398005.p?skuId=6398005)
> >>
> >> x1 carbon 7th gen -thunderbolt-> Razer Core X -> rx 5600 xt -> hdmi connection to my monitor (asus mg248)
> >>
> >> when i boot into windows, the card works totally fine (installed the radeon drivers and everything)
> >>
> >> when im in linux, the card works, my monitor works, radeontop shows the gpu being used when i run DRI_PRIME=1 glxgears, etc etc, so it seems that the card is being properly utilized by everything.
> >>
> >> one interesting detail: when i install the kernel, update-initramfs reports that there is "possibly missing firmware". i dont see any errors in dmesg about missing firmware so im assuming thats not a problem?
> >>
> >> problem is, its very low fps. for example, heres my glxinfo/glxgears output:
> >>
> >> $ DRI_PRIME=0 glxgears
> >> 3148 frames in 5.0 seconds = 628.420 FPS
> >> 1950 frames in 5.0 seconds = 389.999 FPS
> >> ^C
> >> $ DRI_PRIME=1 glxgears
> >> 755 frames in 5.0 seconds = 150.698 FPS
> >> 662 frames in 5.0 seconds = 132.296 FPS
> >> ^C
> >> $ DRI_PRIME=0 glxinfo | grep vendor
> >> server glx vendor string: SGI
> >> client glx vendor string: Mesa Project and SGI
> >> OpenGL vendor string: Intel
> >> $ DRI_PRIME=1 glxinfo | grep vendor
> >> server glx vendor string: SGI
> >> client glx vendor string: Mesa Project and SGI
> >> OpenGL vendor string: X.Org
> >>
> >> $ dmesg | egrep -i "amdgpu|radeon"
> >> [    4.798043] amdgpu: unknown parameter 'si_support' ignored
> >> [    4.802600] amdgpu: unknown parameter 'cik_support' ignored
> >> [    4.813305] [drm] amdgpu kernel modesetting enabled.
> >> [    4.813449] amdgpu 0000:0c:00.0: enabling device (0000 -> 0003)
> >> [    5.051950] amdgpu 0000:0c:00.0: VRAM: 6128M 0x0000008000000000 - 0x000000817EFFFFFF (6128M used)
> >> [    5.051952] amdgpu 0000:0c:00.0: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF
> >> [    5.052081] [drm] amdgpu: 6128M of VRAM memory ready
> >> [    5.052084] [drm] amdgpu: 6128M of GTT memory ready.
> >> [    6.125885] amdgpu 0000:0c:00.0: RAS: ras ta ucode is not available
> >> [    6.131800] amdgpu: [powerplay] use vbios provided pptable
> >> [    6.131973] amdgpu: [powerplay] smu driver if version = 0x00000033, smu fw if version = 0x00000035, smu fw version = 0x002a3200 (42.50.0)
> >> [    6.131979] amdgpu: [powerplay] SMU driver if version not matched
> >> [    6.176170] amdgpu: [powerplay] SMU is initialized successfully!
> >> [    6.298473] amdgpu 0000:0c:00.0: fb0: amdgpudrmfb frame buffer device
> >> [    6.310927] amdgpu 0000:0c:00.0: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
> >> [    6.311158] amdgpu 0000:0c:00.0: ring comp_1.0.0 uses VM inv eng 1 on hub 0
> >> [    6.311401] amdgpu 0000:0c:00.0: ring comp_1.1.0 uses VM inv eng 4 on hub 0
> >> [    6.311648] amdgpu 0000:0c:00.0: ring comp_1.2.0 uses VM inv eng 5 on hub 0
> >> [    6.311904] amdgpu 0000:0c:00.0: ring comp_1.3.0 uses VM inv eng 6 on hub 0
> >> [    6.312133] amdgpu 0000:0c:00.0: ring comp_1.0.1 uses VM inv eng 7 on hub 0
> >> [    6.312376] amdgpu 0000:0c:00.0: ring comp_1.1.1 uses VM inv eng 8 on hub 0
> >> [    6.312619] amdgpu 0000:0c:00.0: ring comp_1.2.1 uses VM inv eng 9 on hub 0
> >> [    6.312863] amdgpu 0000:0c:00.0: ring comp_1.3.1 uses VM inv eng 10 on hub 0
> >> [    6.313110] amdgpu 0000:0c:00.0: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
> >> [    6.313355] amdgpu 0000:0c:00.0: ring sdma0 uses VM inv eng 12 on hub 0
> >> [    6.313585] amdgpu 0000:0c:00.0: ring sdma1 uses VM inv eng 13 on hub 0
> >> [    6.313821] amdgpu 0000:0c:00.0: ring vcn_dec uses VM inv eng 0 on hub 1
> >> [    6.314059] amdgpu 0000:0c:00.0: ring vcn_enc0 uses VM inv eng 1 on hub 1
> >> [    6.314298] amdgpu 0000:0c:00.0: ring vcn_enc1 uses VM inv eng 4 on hub 1
> >> [    6.314536] amdgpu 0000:0c:00.0: ring jpeg_dec uses VM inv eng 5 on hub 1
> >> [    6.316101] [drm] Initialized amdgpu 3.36.0 20150101 for 0000:0c:00.0 on minor 1
> >> [   10.797203] snd_hda_intel 0000:0c:00.1: bound 0000:0c:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
> >>
> >> is this perhaps a power management issue?
> >> i can include my kernel config and X logs etc if yall need.
> >>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
