Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0002C282DD
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 20:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82AF8206ED
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 20:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY8PQYCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AF8206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 374B16E965;
	Thu,  9 Jan 2020 20:19:39 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BECD6E965
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 20:19:37 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id c9so8792240wrw.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2020 12:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hQSFrnQV+o6YUjLou5DBhj1wVyRldM/8+FmdloMmG5Q=;
 b=lY8PQYCu/0Rxc3uYsrFpU64zAFDaLmVB4onZbttxxNE2/0WEuj85EiCcR6/rmNnuuV
 df0xo9H0f1j9Xhw10Ti66YpH2rnzRwMBoV/l5qIPqxBfmTGI2N3uS6asdYHUMZawn2UQ
 H4fqxcAQlyKgBmcJk5yET/axjoAmXNxZLvVf+cSYR1V2f4Cu3O8DroKBt2qjE/8jyb6T
 iZV2Uxa8K/B/QDNjTYKVKOT7/dLTAg98xQjRxzvJ3y6JIL4tXgsTMM8/mNJNrI+k0nfH
 M9j/IC6ptd2BTUtFNuKZEGGuVqNdPEIGsFelKaaZiKeyrzOxCZQneJULWo99oeyL+DRf
 aPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hQSFrnQV+o6YUjLou5DBhj1wVyRldM/8+FmdloMmG5Q=;
 b=mWpOYAEN6V7MqURhLvdqGsVd1uv5KhiiwhbePYfHUndGDHNjM9t1z4q7q5wW+lpmsI
 x4WZF3s9Lq+NdhgIV7YzD/onTRqv+ORpy8CFwE0QeYpyskVcm4DCXYsmak9tuUga+XjS
 SaYqdFtXqev8++hUcfqtJGvAX08PbqQ9TJVI+uRDeg4n75qQRPbtH29w8M8ZAEHRuXpZ
 6Lhhd+CsCJKYnsUibP8SdTawBDwU8py1xCs9eED1tlokSLcY8X48cvpIp0kuJEnhqqVl
 Pq+xcJTnC4sEiFypOPpwsiWdr4FZfJxByKw0ZDv02dZsEJvlE6ai7inH2LeDGw3ghczH
 1qFg==
X-Gm-Message-State: APjAAAXxv9pHppXmoYk1qnV6yl3/uo8jikw0giGsOuYRWMatJVaDzqhT
 Uw18mbcIZbweOsdfxoizDkUU85YQcCLuZce/hsw=
X-Google-Smtp-Source: APXvYqxXRgPLDuLree+InKjElEqafMLUzb0FwhOXFF9USFJ8h/APZX6fixSBw0yiUCXkLDYpRgekJMPFufXvpzTXAjs=
X-Received: by 2002:a5d:4692:: with SMTP id u18mr13104807wrq.206.1578601175996; 
 Thu, 09 Jan 2020 12:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20200108224910.289731-1-alexander.deucher@amd.com>
 <20200109053603.GB11669@jenkins-Celadon-RN>
In-Reply-To: <20200109053603.GB11669@jenkins-Celadon-RN>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jan 2020 15:19:24 -0500
Message-ID: <CADnq5_NppR=GnqWDC6_tsgtcQ46m-LsRwtF4LZp-y+kzrhZ6eA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/display: set gpu vm flag for all asics
 which support it
To: Huang Rui <ray.huang@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 9, 2020 at 12:36 AM Huang Rui <ray.huang@amd.com> wrote:
>
> On Wed, Jan 08, 2020 at 05:49:08PM -0500, Alex Deucher wrote:
> > It won't get used unless the driver allows the gtt domain for
> > display buffers which is controlled elsewhere.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Series are Acked-by: Huang Rui <ray.huang@amd.com>
>
> Any suggestion for testing, I would like to give a try in my renoir
> platform.

Thanks,  Aaron tested the first patch set which enabled GTT for
display and it didn't work on renoir, so that still needs additional
investigation before we can enable support for renoir.

Alex

>
> Thanks,
> Ray
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 1123f9ce86ee..fdf4d202ea1f 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -906,13 +906,15 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
> >
> >       init_data.dce_environment = DCE_ENV_PRODUCTION_DRV;
> >
> > -     /*
> > -      * TODO debug why this doesn't work on Raven
> > -      */
> > -     if (adev->flags & AMD_IS_APU &&
> > -         adev->asic_type >= CHIP_CARRIZO &&
> > -         adev->asic_type < CHIP_RAVEN)
> > +     switch (adev->asic_type) {
> > +     case CHIP_CARRIZO:
> > +     case CHIP_STONEY:
> > +     case CHIP_RAVEN:
> >               init_data.flags.gpu_vm_support = true;
> > +             break;
> > +     default:
> > +             break;
> > +     }
> >
> >       if (amdgpu_dc_feature_mask & DC_FBC_MASK)
> >               init_data.flags.fbc_support = true;
> > --
> > 2.24.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C2abbd206df9a4078e3d208d7948d01b1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637141205928856098&amp;sdata=T%2Fetyq5T01NBu4x9l3jtZVC2%2BGwQv9z0KUlhJkxaa9I%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
