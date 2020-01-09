Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E91CC32771
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 10:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EC420678
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 10:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLYu+BBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EC420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 839696E8F5;
	Thu,  9 Jan 2020 10:29:54 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B7D6E8F5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 10:29:53 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id y11so6797535wrt.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2020 02:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=o3tna6Ixj0WJNcZ09UJ5xYbesyEqFzWhaK5H1+sdZRo=;
 b=BLYu+BBmdc+d95jwg4NKG2v9yHvCW1HXq++eUQbzgsFPedUz1jEevwyFoS1EPqTbDa
 p+mV+IcJitigB3ICXMwQaYZkx9Ssis5YfXbJAi1VJeclZIbBdJF0F9Y7PPm3xt4MqL0H
 +UBB9n/xXS+s12NBDMn60MRAd4TXKkegJMLqLIMqtZiR7BZNe028JZPaTvyLyrbGKmEv
 fgbgSSbgM8ZkmQKpMLLQBwjJtWwAN63UdPOyNMO5pb6Sz9Nucx1yhWI1cupsfsgox0Y4
 yirDpKcYJZeaiGP3wLsL82j/kMYRp5HCgnv+rD46Od3sY6S2FpbeVshBCqC1c7P/UaPl
 jmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=o3tna6Ixj0WJNcZ09UJ5xYbesyEqFzWhaK5H1+sdZRo=;
 b=JYmi22D6o535PenNa3jzSS5Gh4eLb71DYTYRFRE5mI83mwSUxddOrCjQiKWCd9XJOu
 9m8pbYelCk8aK0hQm2WjWY/Mq85GXzO7fPn1IIjogALyUslMJrLQGee2hkuOWAJrcxGm
 A0F3u0NJPYxwp2PCxD/DTUkZ6q2z7h7Ot0oULROTPquWxz3lzH/2Hcto086VsSmpmegt
 hKf+fmv2AZRKN4YsaktDRxIoQ0WUWtZ+bxqD6e5qm1Gm3JJWpXsxM39urSbQ6CJVjhko
 2ld/BfnCSeCiRUBraTpKGavXvUOrXBzzIIeZra3s3PtZ1LZN/WmjCpDscfsAvA9goG4i
 fnsg==
X-Gm-Message-State: APjAAAW+mrJ7zOgIDEJEH0jkVRbTOuHzuQrbs+sz+MxBc6SLoYPB1ufN
 rSkBsiYqDxeo9zucn7SKSqU=
X-Google-Smtp-Source: APXvYqz5so+JhvT5hZMV6WREBTerKkPWC0HspCuVAZSfB8VS9y+blO3fIkg3UoD4Mhn3OxL/Z9MvDw==
X-Received: by 2002:a05:6000:cf:: with SMTP id
 q15mr9896204wrx.393.1578565792461; 
 Thu, 09 Jan 2020 02:29:52 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b68sm2479365wme.6.2020.01.09.02.29.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Jan 2020 02:29:52 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: fix modprobe failure of the 2nd GPU when
 GDDR6 training enabled
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20200108123648.7422-1-tianci.yin@amd.com>
 <ba1754a0-7230-5df7-cfb3-7b0d7c892c47@amd.com>
 <CADnq5_MQ1S60QX3=U2=LYSoiYg965yViTk0Y0WbaFTRXhvNZww@mail.gmail.com>
 <aca36233-68fd-c692-1080-daa9c32efa14@gmail.com>
 <MN2PR12MB29576985DC4A61F99F96052A95390@MN2PR12MB2957.namprd12.prod.outlook.com>
 <CADnq5_OOiV7Ku-QbY7a3MTpQF=CuSgxezq00NVhnVkNQDcBWZw@mail.gmail.com>
 <MN2PR12MB2957F23A709E07E481AD630B95390@MN2PR12MB2957.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <99978066-87ed-9533-0cfb-44cddb7c9226@gmail.com>
Date: Thu, 9 Jan 2020 11:29:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB2957F23A709E07E481AD630B95390@MN2PR12MB2957.namprd12.prod.outlook.com>
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: multipart/mixed; boundary="===============1847616660=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1847616660==
Content-Type: multipart/alternative;
 boundary="------------00AC4A693FE023FF0CA3C231"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------00AC4A693FE023FF0CA3C231
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rico,

maybe it is a good idea to look into the git history and/or google the 
mailing list history a bit more.

I do briefly remember that we disabled freeing up the stolen VGA memory 
on some hardware generations because somebody was accessing that memory 
even after VGA was turned off.

At that time we couldn't figure out what was going wrong, but it is 
perfectly possible that those memory training fixes your are working on 
here are related to that issue.

On the other hand if you can't find anything immediately feel free to go 
with Alex suggestion, if something goes wrong we can still revert the 
change.

Regards,
Christian.

Am 09.01.20 um 04:15 schrieb Yin, Tianci (Rico):
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Ok, thanks very much Alex!
> ------------------------------------------------------------------------
> *From:* Alex Deucher <alexdeucher@gmail.com>
> *Sent:* Thursday, January 9, 2020 11:12
> *To:* Yin, Tianci (Rico) <Tianci.Yin@amd.com>
> *Cc:* Christian König <ckoenig.leichtzumerken@gmail.com>; Koenig, 
> Christian <Christian.Koenig@amd.com>; Long, Gang <Gang.Long@amd.com>; 
> Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xu, Feifei 
> <Feifei.Xu@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>; 
> Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; 
> Zhang, Hawking <Hawking.Zhang@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: fix modprobe failure of the 2nd GPU 
> when GDDR6 training enabled
> On Wed, Jan 8, 2020 at 10:07 PM Yin, Tianci (Rico) 
> <Tianci.Yin@amd.com> wrote:
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> >
> > Thanks Alex and Christian!
> >
> > Hi Christian,
> >
> > On ASICs with gmc v10, I find amdgpu_bo_late_init() is not invoked, 
> so stolen memory never get free, on other ASICs with gmc v9/v8/v7/v6, 
> stolen memory was freed in gmc_v*_0_late_init(). I don't know why, are 
> there some special reasons or just missed by coding?
> >
>
> Looks like it should be added.  Possibly got lost when we merged the
> navi code from the topic branch.
>
> Alex
>
> > Thanks!
> >
> > Rico
> >
> > ________________________________
> > From: Christian König <ckoenig.leichtzumerken@gmail.com>
> > Sent: Wednesday, January 8, 2020 23:04
> > To: Alex Deucher <alexdeucher@gmail.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>
> > Cc: Long, Gang <Gang.Long@amd.com>; Wang, Kevin(Yang) 
> <Kevin1.Wang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yin, Tianci 
> (Rico) <Tianci.Yin@amd.com>; amd-gfx list 
> <amd-gfx@lists.freedesktop.org>; Tuikov, Luben <Luben.Tuikov@amd.com>; 
> Deucher, Alexander <Alexander.Deucher@amd.com>; Yuan, Xiaojie 
> <Xiaojie.Yuan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: fix modprobe failure of the 2nd GPU 
> when GDDR6 training enabled
> >
> > Am 08.01.20 um 15:49 schrieb Alex Deucher:
> > > On Wed, Jan 8, 2020 at 7:52 AM Christian König 
> <christian.koenig@amd.com> wrote:
> > >> Am 08.01.20 um 13:36 schrieb Tianci Yin:
> > >>> From: "Tianci.Yin" <tianci.yin@amd.com>
> > >>>
> > >>> [why]
> > >>> In dual GPUs scenario, stolen_size is assigned to zero on the 
> 2nd GPU,
> > >>> then the bottom region of VRAM was allocated as GTT, unfortunately
> > >>> a small region of bottom VRAM was encroached by UMC firmware during
> > >>> GDDR6 BIST training, this cause pagefault.
> > >> What I'm missing here is why is the stolen size zero on the 2nd GPU?
> > >>
> > >> Maybe we need to read the stolen size after posting the GPU instead?
> > > There is no stolen memory on secondary GPUs because there is no pre-OS
> > > console using that memory.
> >
> > Ah! Yeah that makes sense.
> >
> > But in this case I would say we should change the patch like the 
> following:
> >
> > adev->gmc.stolen_size = min(adev->gmc.stolen_size,
> > AMDGPU_STOLEN_VGA_DEFAULT_SIZE);
> >
> > And in amdgpu_ttm_late_init():
> >
> > /* Can't free the stolen VGA memory when it might be used for memory
> > training again. */
> > if (!adev->fw_vram_usage.mem_train_support)
> >      amdgpu_bo_free_kernel(....
> >
> >
> > Regards,
> > Christian.
> >
> >
> > >
> > > Alex
> > >
> > >> Regards,
> > >> Christian.
> > >>
> > >>> [how]
> > >>> Forcing stolen_size to 3MB, then the bottom region of VRAM was
> > >>> allocated as stolen memory, GTT corruption avoid.
> > >>> The stolen memory of the 2nd GPU will be free in late_init phase,
> > >>> no memory wasted.
> > >>>
> > >>> Change-Id: Icd0ad7de41333282949bb1e3e676c6c307ddd081
> > >>> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> > >>> ---
> > >>> drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  6 ++++++
> > >>> drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 21 +++++++++++++++++++++
> > >>>    2 files changed, 27 insertions(+)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > >>> index c91dd602d5f1..440b793316df 100644
> > >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > >>> @@ -60,6 +60,11 @@
> > >>>     */
> > >>>    #define AMDGPU_GMC_FAULT_TIMEOUT 5000ULL
> > >>>
> > >>> +/*
> > >>> + * Default stolen memory size, 1024 * 768 * 4
> > >>> + */
> > >>> +#define AMDGPU_STOLEN_VGA_DEFAULT_SIZE       0x300000
> > >>> +
> > >>>    struct firmware;
> > >>>
> > >>>    /*
> > >>> @@ -192,6 +197,7 @@ struct amdgpu_gmc {
> > >>>        uint32_t srbm_soft_reset;
> > >>>        bool prt_warning;
> > >>>        uint64_t stolen_size;
> > >>> +     bool stolen_temp_reserved;
> > >>>        /* apertures */
> > >>>        u64 shared_aperture_start;
> > >>>        u64 shared_aperture_end;
> > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > >>> index 7dc8c068c62a..0c96b67d6ca7 100644
> > >>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > >>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > >>> @@ -566,6 +566,11 @@ static int gmc_v10_0_late_init(void *handle)
> > >>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > >>>        int r;
> > >>>
> > >>> +     if (adev->gmc.stolen_temp_reserved) {
> > >>> + amdgpu_bo_late_init(adev);
> > >>> + adev->gmc.stolen_temp_reserved = false;
> > >>> +     }
> > >>> +
> > >>>        r = amdgpu_gmc_allocate_vm_inv_eng(adev);
> > >>>        if (r)
> > >>>                return r;
> > >>> @@ -756,6 +761,22 @@ static int gmc_v10_0_sw_init(void *handle)
> > >>>                return r;
> > >>>
> > >>>        adev->gmc.stolen_size = gmc_v10_0_get_vbios_fb_size(adev);
> > >>> +     /*
> > >>> +      * In dual GPUs scenario, stolen_size is assigned to zero 
> on the 2nd GPU,
> > >>> +      * then the bottom region of VRAM was allocated as GTT, 
> unfortunately
> > >>> +      * a small region of bottom VRAM was encroached by UMC 
> firmware during
> > >>> +      * GDDR6 BIST training, this cause pagefault.
> > >>> +      * The page fault can be fixed by forcing stolen_size to 
> 3MB, then the bottom
> > >>> +      * region of VRAM was allocated as stolen memory, GTT 
> corruption avoid.
> > >>> +      * The stolen memory of the 2nd GPU will be free in 
> late_init phase,
> > >>> +      * no memory wasted.
> > >>> +      */
> > >>> +     if (adev->fw_vram_usage.mem_train_support &&
> > >>> +             adev->gmc.stolen_size == 0) {
> > >>> +             adev->gmc.stolen_size = 
> AMDGPU_STOLEN_VGA_DEFAULT_SIZE;
> > >>> + adev->gmc.stolen_temp_reserved = true;
> > >>> +     } else
> > >>> + adev->gmc.stolen_temp_reserved = false;
> > >>>
> > >>>        /* Memory manager */
> > >>>        r = amdgpu_bo_init(adev);
> > >> _______________________________________________
> > >> amd-gfx mailing list
> > >> amd-gfx@lists.freedesktop.org
> > >> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CTianci.Yin%40amd.com%7Cb9b1622ed60e4ab36c6408d794b1d75e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637141363862418597&amp;sdata=YT8zKlbLX0XdzqcLrZQaV6sKFWXS5nQTNMAMT9BMK70%3D&amp;reserved=0
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CTianci.Yin%40amd.com%7Cb9b1622ed60e4ab36c6408d794b1d75e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637141363862428589&amp;sdata=LLVRzFBxFKqTltpvsK%2F2l9CwnlUFzFKmDoPPHdO5e1I%3D&amp;reserved=0
> >


--------------00AC4A693FE023FF0CA3C231
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Rico,<br>
      <br>
      maybe it is a good idea to look into the git history and/or google
      the mailing list history a bit more.<br>
      <br>
      I do briefly remember that we disabled freeing up the stolen VGA
      memory on some hardware generations because somebody was accessing
      that memory even after VGA was turned off.<br>
      <br>
      At that time we couldn't figure out what was going wrong, but it
      is perfectly possible that those memory training fixes your are
      working on here are related to that issue.<br>
      <br>
      On the other hand if you can't find anything immediately feel free
      to go with Alex suggestion, if something goes wrong we can still
      revert the change.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 09.01.20 um 04:15 schrieb Yin, Tianci (Rico):<br>
    </div>
    <blockquote type="cite"
cite="mid:MN2PR12MB2957F23A709E07E481AD630B95390@MN2PR12MB2957.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p
        style="font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;"
        align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Ok, thanks very much Alex!<br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b> Alex
            Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a><br>
            <b>Sent:</b> Thursday, January 9, 2020 11:12<br>
            <b>To:</b> Yin, Tianci (Rico) <a class="moz-txt-link-rfc2396E" href="mailto:Tianci.Yin@amd.com">&lt;Tianci.Yin@amd.com&gt;</a><br>
            <b>Cc:</b> Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>; Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Long, Gang
            <a class="moz-txt-link-rfc2396E" href="mailto:Gang.Long@amd.com">&lt;Gang.Long@amd.com&gt;</a>; Wang, Kevin(Yang)
            <a class="moz-txt-link-rfc2396E" href="mailto:Kevin1.Wang@amd.com">&lt;Kevin1.Wang@amd.com&gt;</a>; Xu, Feifei
            <a class="moz-txt-link-rfc2396E" href="mailto:Feifei.Xu@amd.com">&lt;Feifei.Xu@amd.com&gt;</a>; amd-gfx list
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Tuikov, Luben
            <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com">&lt;Luben.Tuikov@amd.com&gt;</a>; Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Yuan, Xiaojie
            <a class="moz-txt-link-rfc2396E" href="mailto:Xiaojie.Yuan@amd.com">&lt;Xiaojie.Yuan@amd.com&gt;</a>; Zhang, Hawking
            <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: fix modprobe failure
            of the 2nd GPU when GDDR6 training enabled</font>
          <div> </div>
        </div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt;">
              <div class="PlainText">On Wed, Jan 8, 2020 at 10:07 PM
                Yin, Tianci (Rico) <a class="moz-txt-link-rfc2396E" href="mailto:Tianci.Yin@amd.com">&lt;Tianci.Yin@amd.com&gt;</a> wrote:<br>
                &gt;<br>
                &gt; [AMD Official Use Only - Internal Distribution
                Only]<br>
                &gt;<br>
                &gt;<br>
                &gt; Thanks Alex and Christian!<br>
                &gt;<br>
                &gt; Hi Christian,<br>
                &gt;<br>
                &gt; On ASICs with gmc v10, I find amdgpu_bo_late_init()
                is not invoked, so stolen memory never get free, on
                other ASICs with gmc v9/v8/v7/v6, stolen memory was
                freed in gmc_v*_0_late_init(). I don't know why, are
                there some special reasons or just missed by coding?<br>
                &gt;<br>
                <br>
                Looks like it should be added.  Possibly got lost when
                we merged the<br>
                navi code from the topic branch.<br>
                <br>
                Alex<br>
                <br>
                &gt; Thanks!<br>
                &gt;<br>
                &gt; Rico<br>
                &gt;<br>
                &gt; ________________________________<br>
                &gt; From: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                &gt; Sent: Wednesday, January 8, 2020 23:04<br>
                &gt; To: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a>;
                Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
                &gt; Cc: Long, Gang <a class="moz-txt-link-rfc2396E" href="mailto:Gang.Long@amd.com">&lt;Gang.Long@amd.com&gt;</a>; Wang,
                Kevin(Yang) <a class="moz-txt-link-rfc2396E" href="mailto:Kevin1.Wang@amd.com">&lt;Kevin1.Wang@amd.com&gt;</a>; Xu, Feifei
                <a class="moz-txt-link-rfc2396E" href="mailto:Feifei.Xu@amd.com">&lt;Feifei.Xu@amd.com&gt;</a>; Yin, Tianci (Rico)
                <a class="moz-txt-link-rfc2396E" href="mailto:Tianci.Yin@amd.com">&lt;Tianci.Yin@amd.com&gt;</a>; amd-gfx list
                <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Tuikov, Luben
                <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com">&lt;Luben.Tuikov@amd.com&gt;</a>; Deucher, Alexander
                <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Yuan, Xiaojie
                <a class="moz-txt-link-rfc2396E" href="mailto:Xiaojie.Yuan@amd.com">&lt;Xiaojie.Yuan@amd.com&gt;</a>; Zhang, Hawking
                <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                &gt; Subject: Re: [PATCH] drm/amdgpu: fix modprobe
                failure of the 2nd GPU when GDDR6 training enabled<br>
                &gt;<br>
                &gt; Am 08.01.20 um 15:49 schrieb Alex Deucher:<br>
                &gt; &gt; On Wed, Jan 8, 2020 at 7:52 AM Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a> wrote:<br>
                &gt; &gt;&gt; Am 08.01.20 um 13:36 schrieb Tianci Yin:<br>
                &gt; &gt;&gt;&gt; From: "Tianci.Yin"
                <a class="moz-txt-link-rfc2396E" href="mailto:tianci.yin@amd.com">&lt;tianci.yin@amd.com&gt;</a><br>
                &gt; &gt;&gt;&gt;<br>
                &gt; &gt;&gt;&gt; [why]<br>
                &gt; &gt;&gt;&gt; In dual GPUs scenario, stolen_size is
                assigned to zero on the 2nd GPU,<br>
                &gt; &gt;&gt;&gt; then the bottom region of VRAM was
                allocated as GTT, unfortunately<br>
                &gt; &gt;&gt;&gt; a small region of bottom VRAM was
                encroached by UMC firmware during<br>
                &gt; &gt;&gt;&gt; GDDR6 BIST training, this cause
                pagefault.<br>
                &gt; &gt;&gt; What I'm missing here is why is the stolen
                size zero on the 2nd GPU?<br>
                &gt; &gt;&gt;<br>
                &gt; &gt;&gt; Maybe we need to read the stolen size
                after posting the GPU instead?<br>
                &gt; &gt; There is no stolen memory on secondary GPUs
                because there is no pre-OS<br>
                &gt; &gt; console using that memory.<br>
                &gt;<br>
                &gt; Ah! Yeah that makes sense.<br>
                &gt;<br>
                &gt; But in this case I would say we should change the
                patch like the following:<br>
                &gt;<br>
                &gt; adev-&gt;gmc.stolen_size =
                min(adev-&gt;gmc.stolen_size,<br>
                &gt; AMDGPU_STOLEN_VGA_DEFAULT_SIZE);<br>
                &gt;<br>
                &gt; And in amdgpu_ttm_late_init():<br>
                &gt;<br>
                &gt; /* Can't free the stolen VGA memory when it might
                be used for memory<br>
                &gt; training again. */<br>
                &gt; if (!adev-&gt;fw_vram_usage.mem_train_support)<br>
                &gt;      amdgpu_bo_free_kernel(....<br>
                &gt;<br>
                &gt;<br>
                &gt; Regards,<br>
                &gt; Christian.<br>
                &gt;<br>
                &gt;<br>
                &gt; &gt;<br>
                &gt; &gt; Alex<br>
                &gt; &gt;<br>
                &gt; &gt;&gt; Regards,<br>
                &gt; &gt;&gt; Christian.<br>
                &gt; &gt;&gt;<br>
                &gt; &gt;&gt;&gt; [how]<br>
                &gt; &gt;&gt;&gt; Forcing stolen_size to 3MB, then the
                bottom region of VRAM was<br>
                &gt; &gt;&gt;&gt; allocated as stolen memory, GTT
                corruption avoid.<br>
                &gt; &gt;&gt;&gt; The stolen memory of the 2nd GPU will
                be free in late_init phase,<br>
                &gt; &gt;&gt;&gt; no memory wasted.<br>
                &gt; &gt;&gt;&gt;<br>
                &gt; &gt;&gt;&gt; Change-Id:
                Icd0ad7de41333282949bb1e3e676c6c307ddd081<br>
                &gt; &gt;&gt;&gt; Signed-off-by: Tianci.Yin
                <a class="moz-txt-link-rfc2396E" href="mailto:tianci.yin@amd.com">&lt;tianci.yin@amd.com&gt;</a><br>
                &gt; &gt;&gt;&gt; ---<br>
                &gt; &gt;&gt;&gt;   
                drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  6 ++++++<br>
                &gt; &gt;&gt;&gt;   
                drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 21
                +++++++++++++++++++++<br>
                &gt; &gt;&gt;&gt;    2 files changed, 27 insertions(+)<br>
                &gt; &gt;&gt;&gt;<br>
                &gt; &gt;&gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
                &gt; &gt;&gt;&gt; index c91dd602d5f1..440b793316df
                100644<br>
                &gt; &gt;&gt;&gt; ---
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
                &gt; &gt;&gt;&gt; +++
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
                &gt; &gt;&gt;&gt; @@ -60,6 +60,11 @@<br>
                &gt; &gt;&gt;&gt;     */<br>
                &gt; &gt;&gt;&gt;    #define AMDGPU_GMC_FAULT_TIMEOUT   
                5000ULL<br>
                &gt; &gt;&gt;&gt;<br>
                &gt; &gt;&gt;&gt; +/*<br>
                &gt; &gt;&gt;&gt; + * Default stolen memory size, 1024 *
                768 * 4<br>
                &gt; &gt;&gt;&gt; + */<br>
                &gt; &gt;&gt;&gt; +#define
                AMDGPU_STOLEN_VGA_DEFAULT_SIZE       0x300000<br>
                &gt; &gt;&gt;&gt; +<br>
                &gt; &gt;&gt;&gt;    struct firmware;<br>
                &gt; &gt;&gt;&gt;<br>
                &gt; &gt;&gt;&gt;    /*<br>
                &gt; &gt;&gt;&gt; @@ -192,6 +197,7 @@ struct amdgpu_gmc
                {<br>
                &gt; &gt;&gt;&gt;        uint32_t               
                srbm_soft_reset;<br>
                &gt; &gt;&gt;&gt;        bool                   
                prt_warning;<br>
                &gt; &gt;&gt;&gt;        uint64_t               
                stolen_size;<br>
                &gt; &gt;&gt;&gt; +     bool                   
                stolen_temp_reserved;<br>
                &gt; &gt;&gt;&gt;        /* apertures */<br>
                &gt; &gt;&gt;&gt;        u64                    
                shared_aperture_start;<br>
                &gt; &gt;&gt;&gt;        u64                    
                shared_aperture_end;<br>
                &gt; &gt;&gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
                b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                &gt; &gt;&gt;&gt; index 7dc8c068c62a..0c96b67d6ca7
                100644<br>
                &gt; &gt;&gt;&gt; ---
                a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                &gt; &gt;&gt;&gt; +++
                b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                &gt; &gt;&gt;&gt; @@ -566,6 +566,11 @@ static int
                gmc_v10_0_late_init(void *handle)<br>
                &gt; &gt;&gt;&gt;        struct amdgpu_device *adev =
                (struct amdgpu_device *)handle;<br>
                &gt; &gt;&gt;&gt;        int r;<br>
                &gt; &gt;&gt;&gt;<br>
                &gt; &gt;&gt;&gt; +     if
                (adev-&gt;gmc.stolen_temp_reserved) {<br>
                &gt; &gt;&gt;&gt; +            
                amdgpu_bo_late_init(adev);<br>
                &gt; &gt;&gt;&gt; +            
                adev-&gt;gmc.stolen_temp_reserved = false;<br>
                &gt; &gt;&gt;&gt; +     }<br>
                &gt; &gt;&gt;&gt; +<br>
                &gt; &gt;&gt;&gt;        r =
                amdgpu_gmc_allocate_vm_inv_eng(adev);<br>
                &gt; &gt;&gt;&gt;        if (r)<br>
                &gt; &gt;&gt;&gt;                return r;<br>
                &gt; &gt;&gt;&gt; @@ -756,6 +761,22 @@ static int
                gmc_v10_0_sw_init(void *handle)<br>
                &gt; &gt;&gt;&gt;                return r;<br>
                &gt; &gt;&gt;&gt;<br>
                &gt; &gt;&gt;&gt;        adev-&gt;gmc.stolen_size =
                gmc_v10_0_get_vbios_fb_size(adev);<br>
                &gt; &gt;&gt;&gt; +     /*<br>
                &gt; &gt;&gt;&gt; +      * In dual GPUs scenario,
                stolen_size is assigned to zero on the 2nd GPU,<br>
                &gt; &gt;&gt;&gt; +      * then the bottom region of
                VRAM was allocated as GTT, unfortunately<br>
                &gt; &gt;&gt;&gt; +      * a small region of bottom VRAM
                was encroached by UMC firmware during<br>
                &gt; &gt;&gt;&gt; +      * GDDR6 BIST training, this
                cause pagefault.<br>
                &gt; &gt;&gt;&gt; +      * The page fault can be fixed
                by forcing stolen_size to 3MB, then the bottom<br>
                &gt; &gt;&gt;&gt; +      * region of VRAM was allocated
                as stolen memory, GTT corruption avoid.<br>
                &gt; &gt;&gt;&gt; +      * The stolen memory of the 2nd
                GPU will be free in late_init phase,<br>
                &gt; &gt;&gt;&gt; +      * no memory wasted.<br>
                &gt; &gt;&gt;&gt; +      */<br>
                &gt; &gt;&gt;&gt; +     if
                (adev-&gt;fw_vram_usage.mem_train_support &amp;&amp;<br>
                &gt; &gt;&gt;&gt; +             adev-&gt;gmc.stolen_size
                == 0) {<br>
                &gt; &gt;&gt;&gt; +             adev-&gt;gmc.stolen_size
                = AMDGPU_STOLEN_VGA_DEFAULT_SIZE;<br>
                &gt; &gt;&gt;&gt; +            
                adev-&gt;gmc.stolen_temp_reserved = true;<br>
                &gt; &gt;&gt;&gt; +     } else<br>
                &gt; &gt;&gt;&gt; +            
                adev-&gt;gmc.stolen_temp_reserved = false;<br>
                &gt; &gt;&gt;&gt;<br>
                &gt; &gt;&gt;&gt;        /* Memory manager */<br>
                &gt; &gt;&gt;&gt;        r = amdgpu_bo_init(adev);<br>
                &gt; &gt;&gt;
                _______________________________________________<br>
                &gt; &gt;&gt; amd-gfx mailing list<br>
                &gt; &gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                &gt; &gt;&gt; <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7CTianci.Yin%40amd.com%7Cb9b1622ed60e4ab36c6408d794b1d75e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637141363862418597&amp;amp;sdata=YT8zKlbLX0XdzqcLrZQaV6sKFWXS5nQTNMAMT9BMK70%3D&amp;amp;reserved=0"
                  moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7CTianci.Yin%40amd.com%7Cb9b1622ed60e4ab36c6408d794b1d75e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637141363862418597&amp;amp;sdata=YT8zKlbLX0XdzqcLrZQaV6sKFWXS5nQTNMAMT9BMK70%3D&amp;amp;reserved=0</a><br>
                &gt; &gt;
                _______________________________________________<br>
                &gt; &gt; amd-gfx mailing list<br>
                &gt; &gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                &gt; &gt; <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7CTianci.Yin%40amd.com%7Cb9b1622ed60e4ab36c6408d794b1d75e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637141363862428589&amp;amp;sdata=LLVRzFBxFKqTltpvsK%2F2l9CwnlUFzFKmDoPPHdO5e1I%3D&amp;amp;reserved=0"
                  moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7CTianci.Yin%40amd.com%7Cb9b1622ed60e4ab36c6408d794b1d75e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637141363862428589&amp;amp;sdata=LLVRzFBxFKqTltpvsK%2F2l9CwnlUFzFKmDoPPHdO5e1I%3D&amp;amp;reserved=0</a><br>
                &gt;<br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------00AC4A693FE023FF0CA3C231--

--===============1847616660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1847616660==--
