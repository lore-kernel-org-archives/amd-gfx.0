Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69EAC5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 13:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A7C10E04E;
	Thu, 13 Aug 2026 13:53:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dS47RINb";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FCEA10E4CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 13:53:07 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-384422b05b5so341898a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 06:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786629187; cv=none;
 d=google.com; s=arc-20260327;
 b=FhEzTEVVOlgiNsIkeXGqfzK1NS8mcaDrPfaVRMcHwGihtb51SgsX0MTXnpjXH0Vknb
 MXpDH/X/km9dXfkFF/jthKSnX56SnxndcFxRZvYXcKXziyB5a04MZKh6FO/EzlJ1O8Mj
 hKsHOR81/xoqc34ot3SqLld3t5Ov9UYuYHyNx+2XxXaFLhVZITTf0FKp59EZj/cls+ez
 2uPS/OEuXDnQ6s0nFHYKGGb8YkpIW0Cexk/dJmQ+vfJ6BXc4AN9MIS8pqZe7TmywmHF3
 3+HWydecA5MbzuwnHq7nwJDiXecEnK3WOU6wGJ+Im1iH63f3+VHi+dgWZtu4uo/n9qM+
 PigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O0wS5q2LBlVv8KM16UENoKlhW+fTYaHOYru0sJIlT+0=;
 fh=Sfl3Hg4vT3GTlXDDf1xSn33E3UgrbzGNtNpm+vWNW7Y=;
 b=ZHCfp3W9PReD5zWnQ7j99RA3QyGTi0lw/UG2Uih8rUg9Cak+khbjVlz3ee19fKv3t7
 4bIEGE2CKrIINKJAYTDgCLX2anblBTWpk/iYs68RVH/kgRRt6DFTimito8olInHX0EOC
 WB8xdJf7+9NE3AQED5LqMPmRuyEPKewvVPxRqX+2ly/A6sFckg2b/m5RHzZOWbhYNxCL
 jcc7ILHu/JFuLD1VRDMXrUOP+J+UHqvUjC0lpjNt0IB6yy2QrqS0dCfUAs4c74aJCgCE
 afdWh34V2Bopbqk1G1qTMRa99i6TBUbgoDMykKjVkxvEq+TJ10/zIoGt64Mgjgnj7jNz
 gxNQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786629187; x=1787233987; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O0wS5q2LBlVv8KM16UENoKlhW+fTYaHOYru0sJIlT+0=;
 b=dS47RINbPCP4AeDzUwqADKwejfZydo0rPFDoQVXXHJL/EGQ2LIphG12nMdwF8fTLFt
 7oHykr3sGlX4RYxTIRjQXmIks2mFNkxJAafhsxoxSsDOtNFc+/ovbrbOdwSoVViV6/T1
 SRdPDjed8DL7xdWmyNf/buJzIdilBCfYXx9H0JdmmYISN2jHTT/BcMYqtvVkCj8Kj+BG
 8CTdQ0M8FB0GIveoq6iw2AaZTUZ/WoGJhx2kqMSbSg6/8RtIKsiClPTbSl82w5WbWNXo
 bIfv8JTuNJGS4ZMkGOPvboQA436K8CQXu6DsLUKOL2Al4AWlVLE9dDyPD61ZbY+7i0U0
 WyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786629187; x=1787233987;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O0wS5q2LBlVv8KM16UENoKlhW+fTYaHOYru0sJIlT+0=;
 b=tAHCWjfe92FU4K0Dvfs86VUCgZ9Xgaw+Dpbpc6ys7HSaIkHKxSSbNTeoBC3SUIujoN
 Abyw43apxo+5InR2Vz3zlvrG5NKerEvqQJOwnj1ojqVW7ShG1JmE/+ndjPkQw8PuEEmJ
 SIt39QnKeTruo7Yj5N81iFjI+bs3goNPiDbchyfLR01t222oelItmBcp/6eOh6OxZ0MW
 zikM8B/bq3wCQNdjjeRpyNl2hy8r4YG+ouMVDx6sSAZoOqwF6wzcyDGceI6rdvJzqkox
 KGtUYfE9gbtpTb2ImSafo9/LTq5Y7AGacY/BwKxsA2pKF2YQ3q0t9GN+MadrmOjgWpMf
 6b3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLL+RpAM82NwyE32EY4VDO/aTx3kUWWZx2oOOnTobjAe6/Cm7nTQ9tYkq1eXYgdO3uF+ZawryO@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9cepm05ZGkqvz8CSxwTe/7fpqXesBKgVL4UE1fY1+1QJ/XIJq
 +kvXFEvaknBPG5pE+VARmwfoscVTfgwi2VvQEYH7vUOg4AWkaY2GKecLIMgVyhwcutRZPyA46JV
 pwKClxCjidFhGKH5iWmT+KLbreVJAY0Y=
X-Gm-Gg: AR+sD11TUTwSE9rnxSuMJgZG4vb7/DBgtfqOkjworQG6PXTQov+VEnC4IZSoHdrJDwH
 u7puq0LrrMNL3AiVnkZtUHcWz2T73JiGUcZ3TO3E+n+BiW4PUaC0mvH+8rje7wHt91ShO4TavAi
 Ha/rS1uCSV97iccE6nfpegG6JO36ePkyRk9nGiBXSO1vrEsDm3csU/a0bY5OF8kBdWl70wcCuZ1
 NOp2M/sYRoHrlUoGbYySQMYDILIac7XSiVF5aQGigdPXwfaiSq+BsVJJJz8xC8VPTDCGbjbcVWt
 Nr+dM4mMXlRebyp1ZNjgFXOWK8kZYQfPqfnYm/0lVTqLjel92s3lisfYDMd2ATzzhvOEGepHXQA
 UM+531PUSLrcDtao+b7KViw06o3i3acU=
X-Received: by 2002:a17:90b:3951:b0:383:5a16:bd67 with SMTP id
 98e67ed59e1d1-3932336b482mr4411037a91.4.1786629186910; Thu, 13 Aug 2026
 06:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260810120218.23000-1-pierre-eric.pelloux-prayer@amd.com>
 <20260810120218.23000-3-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260810120218.23000-3-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2026 09:52:54 -0400
X-Gm-Features: AUfX_mxUv8FpJEmmmjtvZKvLNzlI_tgl2Eg4UmY85dPwI8YNliSZSzf5oAx2JVM
Message-ID: <CADnq5_P6Uz6aRtKrzbd82-rxY2OozNKrz6P0L7x8JVNbc4hXrw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/amdgpu: remove useless enable/disable of ttm
 buffer funcs
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Series still has my RB.

Alex

On Mon, Aug 10, 2026 at 8:03=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> amdgpu_ttm_disable_buffer_funcs and amdgpu_ttm_enable_buffer_funcs should
> each only be called once per amdgpu_device: at startup and teardown.
>
> Therefore the other calls are redundant and can be safely dropped.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 1 -
>  2 files changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 1ec3162cb175..e966e6f7d2fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3379,8 +3379,6 @@ static int amdgpu_device_ip_resume(struct amdgpu_de=
vice *adev)
>
>         r =3D amdgpu_device_ip_resume_phase2(adev);
>
> -       amdgpu_ttm_enable_buffer_funcs(adev);
> -
>         if (r)
>                 return r;
>
> @@ -4511,8 +4509,6 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool notify_clients)
>         if (r)
>                 goto unwind_userq;
>
> -       amdgpu_ttm_disable_buffer_funcs(adev);
> -
>         amdgpu_fence_driver_hw_fini(adev);
>
>         r =3D amdgpu_device_ip_suspend_phase2(adev);
> @@ -4525,7 +4521,6 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool notify_clients)
>         return 0;
>
>  unwind_evict:
> -       amdgpu_ttm_enable_buffer_funcs(adev);
>         amdgpu_fence_driver_hw_init(adev);
>
>  unwind_userq:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 5bcb6a966941..ba99edbfe3a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2137,7 +2137,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>         }
>
>         /* Change the size here instead of the init above so only lpfn is=
 affected */
> -       amdgpu_ttm_disable_buffer_funcs(adev);
>  #ifdef CONFIG_64BIT
>  #ifdef CONFIG_X86
>         if (adev->gmc.xgmi.connected_to_cpu)
> --
> 2.43.0
>
