Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D1FF54AAE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 13:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B893810E660;
	Tue, 24 Mar 2026 13:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gXbZm1cF";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D74E10E660
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 13:11:36 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1273c690e5bso499012c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 06:11:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774357896; cv=none;
 d=google.com; s=arc-20240605;
 b=hMZM/JoUZqGxixzvQibuGMI1uoGbmGlYAjbmX0YGAGkr5w3lmpsGVkJ0iR5Lm38DVC
 hw4N2uSt4j8JQwE7G3R4JHiCAMJJKwOKNkp0oapqfqEtdc32Bsae+wMBjpbJe+SSyLkI
 L7lvMoKYuZr5x4Y94w1ipjG+z5hYeJX1AEo2lyycL3H/eZzD5xrfeZOqIxM6lGQEHGWu
 L8pvt7o6RUdSjbSyA58JhmylCcjykIr4jAXUXufnrsdAFbUfFxJS4VevbL8WV5h0o3Js
 tlRCB/So/w2IwjpuzXKlaez1C+EzFoLJCBCli4VCfDLB3DFeth4nbmBvIMXcUkK4qRDE
 7XUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HQZx/kvnFzJcbke4KxeXmKPQO4Our1sxl7Tf5UayGA8=;
 fh=enN+75eEHTet0bD/KwLzYfNFOocFpgcZBQrHGRaOAEA=;
 b=gY13o0smNqenuo3CZ+qfAiIm/LlfTFE8ZnmxrV+IX2fIbaiSawFOH0OIA9F4ky5wAY
 U/Mj9MTPz0jpqteU1PxjithiFCrLOde7+YPjmQc4V4AKQJWwpJG10H/yq3l4QceDP+La
 WFfc/zncoQkicvUFt0NIs5/uo2+kZ+lH3NbbA1PP37KH1HQnnSoG0xIkIp/8v5DpN+Jr
 vIco3uuFrj/PdG/ShkQzy6mJBmBfDyS0qrzcn4yJ+IW4TKAef/T0sIPuJquoiH5eIMCU
 Ya0UPXbvbj2YtkY+NCQoW4X3CO7BF27YohUaRl1kuc9eXQSuGXssMrIwNSYrk6wQ8LV2
 wKsg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774357896; x=1774962696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQZx/kvnFzJcbke4KxeXmKPQO4Our1sxl7Tf5UayGA8=;
 b=gXbZm1cFP1GEQ3arec9DgjTty+IDH/MhsytHeno37+85yCPB1/CoNFbfprlwopSpD+
 CxNFyIKGtZF2RiL/PEhxjGPr8wgFc92SqMmyHMV1Q31S/Gz+s9XDiNAfZBCHMKDvDcRo
 9zEeieitLoaYC/oUsvfWTiairu93uyWyxyj4lszBz1epjK/MV1y7ZPaJJQXTEzJ6Kkcb
 p0daMHgZPPX/vkbGKhCFvxZ/nly3woixFPGAi+MFJcZrVkqvg1cQDqZRRSezx2ZE4Ct3
 Bsf5X7gVjsDOVAsCHe/4GCfkbfy0CThfdp6JWzh1K9raTDkIZ3nX2fc3gIkdzOikSz/p
 9DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774357896; x=1774962696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HQZx/kvnFzJcbke4KxeXmKPQO4Our1sxl7Tf5UayGA8=;
 b=CGjpoJ3aXou5jrOXiFD7vAdvXsjrO2R7zrln33NsZAQ54mrGynmV1Z25/z6PhVwAwk
 ocHwOPjWI9dLcIQhwkNVlV9WbyEUCqGHVBgKr5IL/kAdvUWi+raB+fwIQN47+EHwAleL
 M/Y9D5ZSyiUCiB8iNFHetYEJCrEHAkKhdheo3n3UA8ThGO73z4RsZBhV+Ft+b51q4yVt
 Ksxzl4omt5oQrVwT3B2nTUAXLLZnIdJT4ZbF1olEBv2SbF9XGq3kO4S1bj/DBTrECu4i
 e24+YA38ykGEJuFlOxBMrQK5epdjbC7JnxyOYjCL6EmwFTf3NNlTqGygfrxJaNwQ5Bu6
 GP/w==
X-Gm-Message-State: AOJu0Yw8u1aGeSMvVJh2yIUkjufJ3nPhstKAkPfopFbrcQ7tT4epFscL
 Q20uCH3hKini8TxvbAj3GwRYtUfF63cvPWv46eTCoN2q1h/9+5if8YFzsYU04uZ7huHUMPjLBC9
 /h7tbrKVbmh8hZH7DqYUibz+849Yur14=
X-Gm-Gg: ATEYQzz3wtbgFQHI1o1XuzKcPpByuFQYJU6LQQ9ktblHb6KclnUWZDieHatRmMV3hEJ
 yHf3ixmn5Gc5mXppn5HAds6XRk/YwaHFOrhwXDYxXCJKWHW6l95x3ZYrtTFwSECmyttSt+h/oJs
 CScFNDbMXXa/eaPSr7V0yDnoAMiM4B+FfIct836HwDG734KAs9T78sXhxMR5mVlihYPcY2WGoJg
 41gFAb0fh6dyYnszTiuK6OXXs/6reCGLeHSXE9kX+jNqIPUgzTPVDjOToHT0JiafYrsTjfkLHNU
 fyvq0jl1IUt2AiIzhVpQcl6kfONeoYE/s8WSaTAqpdWzw5RcofYCU+b0YVjxS2Jbvyo90w==
X-Received: by 2002:a05:7022:2224:b0:128:d590:2947 with SMTP id
 a92af1059eb24-12a726c143dmr3367139c88.4.1774357895871; Tue, 24 Mar 2026
 06:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260320083247.428482-1-nichen@iscas.ac.cn>
In-Reply-To: <20260320083247.428482-1-nichen@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:11:24 -0400
X-Gm-Features: AaiRm52hZWMu_Hps_nL6ZzI9xC82b-C0ijos6SKmEDSAmtR9aU33yL7mfuLLMkQ
Message-ID: <CADnq5_Ni0AUQYWT1hP2DqA0HGdDgTGPwTa4mPszbD1nNVGqA2w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com, 
 dri-devel@lists.freedesktop.org
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

Applied.  thanks!

Alex

On Fri, Mar 20, 2026 at 4:47=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it seems best to use ';'
> unless ',' is intended.
>
> Found by inspection.
> No functional change intended.
> Compile tested only.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 781896c9fd26..6daec964ca5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -961,13 +961,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev,=
 void *data,
>         }
>
>         num_read_bo_handles =3D wait_info->num_bo_read_handles;
> -       ptr =3D u64_to_user_ptr(wait_info->bo_read_handles),
> +       ptr =3D u64_to_user_ptr(wait_info->bo_read_handles);
>         r =3D drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gob=
j_read);
>         if (r)
>                 goto free_timeline_points;
>
>         num_write_bo_handles =3D wait_info->num_bo_write_handles;
> -       ptr =3D u64_to_user_ptr(wait_info->bo_write_handles),
> +       ptr =3D u64_to_user_ptr(wait_info->bo_write_handles);
>         r =3D drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
>                                    &gobj_write);
>         if (r)
> --
> 2.25.1
>
