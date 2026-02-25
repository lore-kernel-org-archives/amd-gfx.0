Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11A3FD3762
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 14:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF0010E7C4;
	Wed, 25 Feb 2026 14:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c+JKoNYE";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4252510E7B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 14:55:25 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-127148c2112so575731c88.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 06:55:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772031324; cv=none;
 d=google.com; s=arc-20240605;
 b=PdLd37pmEDDFCG8JjLNQd2op30l96faT92we87Ju8nruAAVpuW9ft1kxZ0/2zUeiAR
 JwDUQ4JmveriQ0ip8b+zBmx/WsmgfF90vdjf/VBu54c96D9mozAwAVWtiLYnPaBRDJow
 4khkvTZulCz4b7PbgC43trljSDE0IHLyBax5ipyCNrEaV9fSNSD/l5/ngMAUCU5wR5hR
 p0TWxMbjuSnAiQQbkg23/8ehhoqzRERV0Q5bNOFgxTnTOZ3IfCIzk7ZDmiTLOuZ+6YLj
 Mk5OEeI3UpHeqVzzU1HGOwIMGwCqp+xexVryicbDFAlhFQVl4yL/hvapC6jwXcH8b6J0
 IxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fNZJ0xlgfHNJMHDff2n0zuiRGlk8llUuEDhpoKZUi5U=;
 fh=MzjOtP5vDMZ0AGIJ74XcxQ1DKKnKPYxAF2qfsl08MOw=;
 b=htSA4SJau8BvgiBc33Xr3R4gkPsS0+u1kg5iZRUbAGD7vCmfCQMc/qE9XuRg0+fra8
 O/9h8vZFLlaEUnyL4koc4tnMCxng6VBs9fixFwwpzYrlysccB1j8y11mjInp0ELiIL3s
 X6aKe8CbbTSkWB6DIHEj4bgYyBBaKCxZlk4uEtzt5DI2mff+FmvUvDRem462bOlOyXc4
 qVGBhAFeRUAZPWgB5hMnTeULJJ3HXNgXnFgm2PZtlFiueFQDl2H+J8ndQu10ybuf2pw4
 Giqo/TQa1KKEzX7PZ454syyXCrmL403tV4uWMIKUQA8YZA5L5JWGvAx3NI91/chseZd0
 kq9w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772031324; x=1772636124; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNZJ0xlgfHNJMHDff2n0zuiRGlk8llUuEDhpoKZUi5U=;
 b=c+JKoNYEhcZjJoI3n4rpu3du6/3+GkqwyTli58EYL/H3zAT0cBkrsftknwhIPzZlUW
 gyIJA/3xlfmKW2CxtLa+guHpFrma1kkArXI3rJ896dPp7XpLVXEwPsJ4Lc7Jm6oiQRAy
 wygKC8qeb2Keo9KEqYqNOKAot7vuvfsDPRIsDOQSF530oNdHRGZJQpkWZ86WaDUjkbGW
 sOJyWGJBqFNFU4GC5JxvyltkIGST3kwflRqEWX6H+IYa0Vy+sJXe61Nr13VFM46qdtRO
 RJs6r+DyxSdPqjllllQ5PG3V9Epvtz0Y45178tJj6JHyMzBuPwfUSzB8LVEqRaB2eMVl
 kHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772031324; x=1772636124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fNZJ0xlgfHNJMHDff2n0zuiRGlk8llUuEDhpoKZUi5U=;
 b=r2jHbv6DuKEUFXwDjN/2AdOxbcaeUCOxoDRgQfIb3c6D4Dlo+NhO3l39bE2ltBdbAN
 HzWi7wu3TZP8ZwI7ABAh6WAf7nbzO+Cmx0exIP+5PnBwlEBJQL7JQlJDC+wuCgtMt+nE
 O64PnifYp5uKl8SpfHf3pRZcpzsafLnhs+00VxTTg1HC2mA/Igc3ddC7K8FQ8bVAY6mb
 uql4qJzZy6kWH6S2MDDm/iRvj7XfX1t8xwQWFudcS9O8OTleaLaylvLbFZSc11x7IPCQ
 hnbJt5SS4jJ5ndc0TclHEjRlGAY55oLbuEkS0FwWzY+I9swZSpxhp7aGyasBn+2wckQT
 DhHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb1C1RWPf3y7FhyNtboJ1NTPAA+e/JIBhB8lnuCwibTPMj+xdWeG7aYvQWnMWd4ad/m6O/FwMM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykQB90tDaYAvpy7PeLnzF2lrCVrD8KFEbCY+W+Yu8r4/D6rN8c
 IZQmHftSXGTJacYCZtH6dQ4MFYZxLjmmOvKHIR7gPL7baIVbz5GZPrLDFT5k1/LyUxb3mVG7iaC
 zdJFSDsASBtV+IK58fgNUpHCBjvT7BGA=
X-Gm-Gg: ATEYQzyYBjtLlBEH7lhpgzNBRUCpAZypeKoqF3EOhLeFlsdSdCsyn5E3+durv+FaePo
 g/eHDIN73vn4WjCR70jJallMDuKIQEMnKE2tlpUGiMN/Mk89KsMzrwsqQ0Uj/Rd2mXSZx9piouK
 BMsVJaThNqDjEMWlt4uG2o9tCgjsdFlYZo4tkCLjgZ8xKnsKVB9EDjb/cpa2U3+ftqq+Lqb7YnQ
 Ko9CDN6eNrrnkw7kJy23senuXku23UHH6xLkS2/R2Yv9uB+O8LumBRHrcNx+amqi1upXOPAzfX4
 ymNSZAt5esoUl88nqLTWm5P/2FF+uIsEpz933ZaCFu2bFtMtPs0CqjzVvRRNgRpCc7HRZw==
X-Received: by 2002:a05:7300:238c:b0:2b9:ddef:2c13 with SMTP id
 5a478bee46e88-2bd7bd7bc8amr3445616eec.5.1772031324265; Wed, 25 Feb 2026
 06:55:24 -0800 (PST)
MIME-Version: 1.0
References: <20260225130520.1655290-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260225130520.1655290-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Feb 2026 09:55:11 -0500
X-Gm-Features: AaiRm53CgWgqC1qViuCjQPC4B5qB48qcD-dQFT8aILx_jacAIw1FrkrimPiymg4
Message-ID: <CADnq5_PsvMD1mrE9Y0b59_1FK5cXanAipBBwb4SNVMcdoXZ93A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Drop redundant timeline handle limit check
 in userq wait ioctl v2
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Feb 25, 2026 at 8:14=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Clang warns that comparing a __u16 value against 65536 is always false.
>
> num_syncobj_timeline_handles is defined as __u16, so it can never exceed
> 65535.
>
> v2: Drop the check instead of changing the limit value. (Christian)
>
> Fixes the below:
> amdgpu_userq_fence.c:642:46: warning: result of comparison of constant 65=
536 with expression of type '__u16' (aka 'unsigned short') is always false =
[-Wtautological-constant-out-of-range-compare]
>             wait_info->num_syncobj_timeline_handles > AMDGPU_USERQ_MAX_HA=
NDLES ||
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Please add a Fixes: line.
With that,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 136071172111..3c30512a6266 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -637,7 +637,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, v=
oid *data,
>                 return -ENOTSUPP;
>
>         if (wait_info->num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES ||
> -           wait_info->num_syncobj_timeline_handles > AMDGPU_USERQ_MAX_HA=
NDLES ||
>             wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
>             wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>                 return -EINVAL;
> --
> 2.34.1
>
