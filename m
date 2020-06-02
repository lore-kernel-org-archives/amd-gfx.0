Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D669C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 13:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E28F20757
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 13:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/8ECYxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E28F20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1595E6E3CE;
	Tue,  2 Jun 2020 13:34:58 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9C7F6E3E1
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 13:34:56 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id k26so3151506wmi.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 06:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lTgAOeAnv9dr2gyWKxGehRc7dH/gCvjqu9sjSqhthvA=;
 b=D/8ECYxQPgjBlHRFrboO5g9XeojQ2sNLjMjhBMW2rpyV5imCP5Brs+sA60ivHDDimn
 5mTbDwV7vNteZuC+pEdWpZZD9rVmlXehq0b8coS6bUPd9rU4vWP5bnFpnyTTTvwyJrbh
 WHJ2gQusQAknQn+RvaHdO8IvxjNqq/lfOMVLM6qJOc43FldzIew/ZWBvr1CLAoBNCV/C
 WQE2yUG+Kt66Xp7fmqFifSbqs9hDJkqY5SRNH+Wkp5G0BqYzxwYtiPw/AxqFWm5AkNze
 Ja+4e9safdwxLj1dvl6yb8BO/m/hZIpKIB3LuY506IY0tCQxvG+jZeqPd+5k9oG1ai1k
 kGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lTgAOeAnv9dr2gyWKxGehRc7dH/gCvjqu9sjSqhthvA=;
 b=cdVM8Fc2z5Lwd+6aSi4tcViwFQLiYXTvevDZEO1+VY2wiRhLse6VffUnLNkZJPpp40
 t1z0ejq9iJvaRDpOV26tGbL1bzoHQ5TNRMI04fow9XkPT6ojaWFXIJ9/ml7A05FqcTYS
 UTjMAYtnG+ZejazCMOAJiEOThBu2Fuu8JXERd0Tbh3/2uYmcqEEvADoY/aUyxpffTTYh
 0HQzD2IrSFC1zWjuJtQ7glOwTKvPykCbD32UtcoZfB2PeOtFXCgfTh9uJvy8NbkoDfvK
 Ay9lq+JpS1o8LaW5AqfLxyV2i8O3JPhkvGAoMoZ83lPObDK1mU6THeQNXYJ6Tu30peM5
 s2VQ==
X-Gm-Message-State: AOAM531HiAqF+aKJ2yqNp7iGfZlPha1sI0DrRtHcLptCOlyLAolJ/xj/
 cJcJns/PTocqyraVbbM9ZlnIc+XG8jTmlyxiVk8/2eEz
X-Google-Smtp-Source: ABdhPJxn/mBfqXL+qpDvOahAv4gOjMrSojgl85jaQJ4g4n+UuhLM0MZDC0bgI8iPLj2x/R1v9VlTQKLGtZI5sJGcXMI=
X-Received: by 2002:a1c:9c85:: with SMTP id f127mr4288096wme.79.1591104895475; 
 Tue, 02 Jun 2020 06:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <1590722887-9333-1-git-send-email-Prike.Liang@amd.com>
 <BY5PR12MB430719B6351D4AD64215A7CBFB8B0@BY5PR12MB4307.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB430719B6351D4AD64215A7CBFB8B0@BY5PR12MB4307.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2020 09:34:43 -0400
Message-ID: <CADnq5_Nndacwux6UQMXBvBPOxLLGT-gnMHOjoHr1u-YGed696Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable renoir discovery for gc info retrieved
To: "Liang, Prike" <Prike.Liang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 1, 2020 at 10:14 PM Liang, Prike <Prike.Liang@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Ping...

Already enabled:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=amd-staging-drm-next&id=e467ab869f5783cf93d4cf24c6ac647cc29d1fb5

Alex

>
> Thanks,
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Friday, May 29, 2020 11:28 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> > <Ray.Huang@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> > Subject: [PATCH] drm/amdgpu: enable renoir discovery for gc info retrieved
> >
> > Use ip discovery GC table instead of gpu info firmware for exporting gpu info
> > to inquire interface.As Renoir discovery has same version with Navi1x
> > therefore just enable it same way as Navi1x.
> >
> > Signed-off-by: Prike.Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23
> > ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 2f0e8da..bff740ccd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -1528,7 +1528,7 @@ static int
> > amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)  {
> >  const char *chip_name;
> >  char fw_name[30];
> > -int err;
> > +int err, r;
> >  const struct gpu_info_firmware_header_v1_0 *hdr;
> >
> >  adev->firmware.gpu_info_fw = NULL;
> > @@ -1578,6 +1578,23 @@ static int
> > amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
> >  chip_name = "arcturus";
> >  break;
> >  case CHIP_RENOIR:
> > +if (amdgpu_discovery) {
> > +/**
> > + * For RENOIR series seems needn't reinitialize the reg base
> > again as it already set during
> > + * early init,if any concern here will need export
> > amdgpu_discovery_init() for this case.
> > + */
> > +r = amdgpu_discovery_reg_base_init(adev);
> > +if (r) {
> > +DRM_WARN("failed to get ip discovery table,
> > "
> > +"fallback to get gpu info in legacy
> > method\n");
> > +goto legacy_gpuinfo;
> > +}
> > +
> > +amdgpu_discovery_get_gfx_info(adev);
> > +
> > +return 0;
> > +}
> > +legacy_gpuinfo:
> >  chip_name = "renoir";
> >  break;
> >  case CHIP_NAVI10:
> > @@ -1617,7 +1634,7 @@ static int
> > amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
> >  (const struct gpu_info_firmware_v1_0 *)(adev-
> > >firmware.gpu_info_fw->data +
> >
> > le32_to_cpu(hdr->header.ucode_array_offset_bytes));
> >
> > -if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10) {
> > +if (amdgpu_discovery && adev->asic_type >= CHIP_RENOIR
> > && !r) {
> >  amdgpu_discovery_get_gfx_info(adev);
> >  goto parse_soc_bounding_box;
> >  }
> > @@ -3364,7 +3381,7 @@ void amdgpu_device_fini(struct amdgpu_device
> > *adev)
> >  sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
> >  if (IS_ENABLED(CONFIG_PERF_EVENTS))
> >  amdgpu_pmu_fini(adev);
> > -if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
> > +if (amdgpu_discovery && adev->asic_type >= CHIP_RENOIR)
> >  amdgpu_discovery_fini(adev);
> >  }
> >
> > --
> > 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
