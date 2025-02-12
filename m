Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5748EC021A0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 16:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0396410E912;
	Wed, 12 Feb 2025 16:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JVNfjoC2";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE98C10E8FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 16:24:12 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-21fa8ca8eedso7071365ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 08:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739377452; x=1739982252; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yd8bgQQIk0eiVic/EZupd2RjgoLO/Bs27d3oKhC6p5Q=;
 b=JVNfjoC2oRFzL3aY6wKTQqlugfNxG22tj2sXtm7CHkoMGbEo5iMr4tQG/M9fDPiWef
 XEUfWXPYs695rnodwYjAb/PtjcqNFLGO3xOh03xbizoanade5pu3cG9ACncP3QyuPEXc
 3WizXl2jn3DIoU40XFFMSoqP8VL9mII9pX73k7n6Z9+6cmJBhqI5H39IEMfd2RWFQ2h4
 RiHKqecxvA0jUlIYaK4zOSEywnI7lNmNfhHGR2ONhCtvypcoIMvFI1db9CA6fZBaiNUf
 LapOb7cBD2oMWtecLd2dJHM3QvEuJk+5HAF8+h60pvCmLgrbD0K+uvj/aIrpujxCTWnt
 HVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739377452; x=1739982252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yd8bgQQIk0eiVic/EZupd2RjgoLO/Bs27d3oKhC6p5Q=;
 b=lyCizRquo4i9HK5UrS9EZL8F3zsZfO7ZuMChcwSJRzrzU3ikKGY30DrSJcvQFr70aV
 2Pk39jkfrWBzK4V9mcjN6NQG+q1WLgakd9Q7fVGalakE1df1KzN4wLtqr3woiXRVmmam
 Ai/60db0pVQCOzTvWG0lM/WO8a9qVQ7ppbGB8SkwvGIxSQJkc72pPe4USI58mK3ZHSnY
 UsDRqQ+koOf4cXfCoby9tGEfFQt5IV5E7hnjPnGjxQak8Zz+pFdq8aTqTqhMMLf1aDar
 LLhGNReSgjNMWu0e6ej232CmcXWrSBomO542Mj+5bKEO8ECHCtn0K0gkFH+MpqBoFArk
 7d+A==
X-Gm-Message-State: AOJu0YzL26U9uhi1u5tZPS4+QHzRVWLRMoBGQCT+/+sA3ujFUIdimg2G
 WCQJSNytJ43aHxP4DQa9/z9gIrn3EbZfOkmMIaZi27mRH8QHi+eS+aoxlex8nSVPTMyQJ1uFWC7
 rtQjnJ6lPpAJVCLVUaMDOl0ScfiQ=
X-Gm-Gg: ASbGncvQcdLFK99AA9Tqqn+LOJDSXI9XyUkGbZtV3l+LpewKuQlGp8Jb1voW/faiyE4
 2DCLSY6Vq2KpVnsY0EnFl7U6v8rv1YQY3KQ7+DGGGyPcuZp3YcvaSfHggmC7EjuDWOuNRvv5W
X-Google-Smtp-Source: AGHT+IGjmbSX4pHtCN3vp4R1THjUMZ5s5Jgb4jjodmrJCLqa96iNuylkebtzDglzkE0j1pbM8ZmdZnDC6sdiLaQkhBw=
X-Received: by 2002:a17:902:f651:b0:220:cddb:5918 with SMTP id
 d9443c01a7336-220cddb59f5mr1946435ad.9.1739377452381; Wed, 12 Feb 2025
 08:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20250212151559.2683916-1-alexander.deucher@amd.com>
 <20250212151559.2683916-3-alexander.deucher@amd.com>
In-Reply-To: <20250212151559.2683916-3-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Feb 2025 11:24:00 -0500
X-Gm-Features: AWEUYZnJezSJ6K9xHdnbybUymROAmbCI65pxBS_CA5c7lJD2Hy208IlmxZtdceI
Message-ID: <CADnq5_Ot5svF0qc4cNV3859f8txLjhJuu4LZ=vVm0MnzO+h_hA@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/amdgpu/vcn2.5: drop dpm power helpers
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Feb 12, 2025 at 10:22=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> VCN 2.5 doesn't support powergating so there is
> no need to call these.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Dropping this one.  VCN 2.5 doesn't support powergating, but this
function gets used for other stuff in the smu code.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index b9be304aa294b..08e73d1685e92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1011,9 +1011,6 @@ static int vcn_v2_5_start(struct amdgpu_device *ade=
v, int i)
>         if (adev->vcn.harvest_config & (1 << i))
>                 return 0;
>
> -       if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, true, i);
> -
>         if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>                 return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirec=
t_sram);
>
> @@ -1465,9 +1462,6 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev=
, int i)
>                  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
>                  ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>
> -       if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_vcn(adev, false, i);
> -
>         return 0;
>  }
>
> --
> 2.48.1
>
