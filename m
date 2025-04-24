Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA3DC369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 18:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE7A10E03A;
	Thu, 24 Apr 2025 18:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dUCIHvrq";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1C010E03A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 18:51:47 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-224172f32b3so2951895ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745520707; x=1746125507; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHqM7ETlXPdm3etcDSO//7VNgw5l+xNoLweXLG0Ra90=;
 b=dUCIHvrqfXBZppCAY7pPVnmmcfEjOWlgKwRbNKkj/MVdGiJxxZlZqLIZCizJzRHw2v
 faVTjXqaY0Bu7OJLMH3POqkYL/5ACwVP3o2Ggc1xD0OOnnXvaSXrLoZXTtj0z09gekxQ
 WWmcTp4xvbtjdlGAEsBt3keQIMO/at1hi1FpqZ9641bT/TaUjO02vpKUV+DuAYRL1UPo
 IwE7plKH6cXcmMX6N/88VEF7TBZIJfY+vP8HWqlzkwyLk99oeO6oYSCVZMVRjC7VFBpP
 bqQbrGMr3QYajBrxe1VI3FBFvhiGbhEJNgwglfPsPXcOfY/Z2MKeR81oLj7VnjjoXSCL
 H2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745520707; x=1746125507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHqM7ETlXPdm3etcDSO//7VNgw5l+xNoLweXLG0Ra90=;
 b=TOKX+I59nh3Lwlz0oXdaaOCdsOth/BBWiotWK63EGTpx5YHcd0yyipLMG+9WLML/XM
 bReT/Fl0EsyjlBhfltVQpKmKytr0/d8Fxw9Dg+d0g5Wvb/9QfqUeNae/zYr4g+XwxVVu
 FLrN4mOHIMnvoFR+d04onzcipbdOBK9lNkjxLXTex3skRygH10IWmjz0cNaa26lI5f57
 f13FHAfCxAImqTo7VcUduSF5jSic+/3mdfDX3t6dWa5q9XbWFN5PoI2G/QCNi1GbOM8U
 tA+Rcx6OFzQHx5eMvYsCl5J9pxKCoVXqhPHh3yiYNwpeZrlFhvI5Ze53+7ispzj7vdtP
 Yc6A==
X-Gm-Message-State: AOJu0Yw3fth6VwKhlXlpIvs0ejqBujBV7l7iHfzisTa7OL5d8hVBw33e
 X/gjvzJjRRE9UQ2gHOU+HoG+foB1+QAkAw+p1Kr3hmg7YLtU3ucdjyne9lbLxGiy22NK87FTA3r
 3WVk8zjgzv9QJrn+nnzmUCLVQXwxkDg==
X-Gm-Gg: ASbGncshM1KKrZGWB9XMU9onuFvEg4PdRRQynHnOTWvdUOUngBA3PxXP6kczYfMAYBq
 sZ0h4r/pbREgpOMYDMyPGkmD4MBCo+4C5DVC5N1pHLfaO8ByCKWX88dYdujr+pNnsbYvymlAwp6
 5O5ALCHT5k0ipyvrAar6gv4g==
X-Google-Smtp-Source: AGHT+IFQSzQro6b3XrNp3D1sY2qB0YeX3GTyPSccLxcIztf+r4Htc337VV6geHEzvWLZ6TQR4AuMMpYIy3GJF/pmGGA=
X-Received: by 2002:a17:90a:8592:b0:309:f0d4:6e7f with SMTP id
 98e67ed59e1d1-309f0d46f1dmr899939a91.5.1745520707080; Thu, 24 Apr 2025
 11:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250403104821.2507-1-nipetrov@amd.com>
In-Reply-To: <20250403104821.2507-1-nipetrov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Apr 2025 14:51:35 -0400
X-Gm-Features: ATxdqUHJv_eHTXKQHePAkVJkqBAolp4ZbiSTAKfhaLQbK51Q9c4x0VtRvPNeoeM
Message-ID: <CADnq5_Ndu6o4Td3LMRYHsR030nRL=_t42ue_NYzAG72BsgKXJQ@mail.gmail.com>
Subject: Re: [PATCH] SWDEV-513979 - Fix for BSOD on Hyper-V host side
To: Nikola Petrovic <nipetrov@amd.com>
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

On Thu, Apr 3, 2025 at 6:58=E2=80=AFAM Nikola Petrovic <nipetrov@amd.com> w=
rote:

Please fix the patch title.  It should say something like:

drm/amdgpu: fix reset handling with Hyper-V

You also need a patch description describing why the change is needed.
And finally, your patch is missing your Signed-off-by.

Alex

>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index a30111d2c3ea..0f337a0bdee8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5307,11 +5307,12 @@ static int amdgpu_device_reset_sriov(struct amdgp=
u_device *adev,
>         struct amdgpu_hive_info *hive =3D NULL;
>
>         if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
> +               r =3D amdgpu_virt_wait_reset(adev);
> +               if(r)
> +                       return r;
>                 if (!amdgpu_ras_get_fed_status(adev))
> -                       amdgpu_virt_ready_to_reset(adev);
> -               amdgpu_virt_wait_reset(adev);
> +                       r =3D amdgpu_virt_reset_gpu(adev);
>                 clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
> -               r =3D amdgpu_virt_request_full_gpu(adev, true);
>         } else {
>                 r =3D amdgpu_virt_reset_gpu(adev);
>         }
> --
> 2.43.0
>
