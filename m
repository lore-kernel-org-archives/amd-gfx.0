Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BD9C021A0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 20:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CBD910E100;
	Thu, 13 Feb 2025 20:40:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WrN9xcMn";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43AF810E100
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 20:40:46 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-21faf4967fdso2986155ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 12:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739479245; x=1740084045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vFe/5msAN00aYHKFxHVI3KkdfOfNlHYgHdnI8K0Yq+Y=;
 b=WrN9xcMnwtNKrnKUXEMP+gjbVs2021RgIuHfsWQC8vK3YZIFRvwWy9JdUW2OOdNp7Z
 mUjfqph6i3ui+lyBHLYJ4QAggRWJtlDcuhHviXAsJ45HBsEXsFwVR0oxQQvei8S6vBWB
 z7V/pC2CL8UAjOhsV0E0A0f/2EwAXTK3QT5d0LZYrgoo/cG0a/DsZgmYNpEiSF3D3g2p
 koNjzEAoKSdwKjj2S1Qv8x80j32tNB2w3ijl8m3Ixxlul/h6rQu4nEbhBSv4vshchM5a
 tWEH5NBvfOUeJumnECsdc+QKK3CSbW61Xk5ajhoPaDhBzrqrCZ/oowXXg0iyjkYrCfvj
 i4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739479245; x=1740084045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFe/5msAN00aYHKFxHVI3KkdfOfNlHYgHdnI8K0Yq+Y=;
 b=nx9V4MVt53gr6OZDXnggd7vVu8JrbnG126mojd3T/b3gb5Sxsm4rP67rzTEkhGZu9Y
 NiYXqUBy0hR2M5nLP5SS24CtNR+YqNhLfwuncNQLWfFn1o+nR7Qu4SFCkPKEevWNBjAK
 XjY6NfMv46CcqVyrvBGW9L9WYZadoe+8OEhdpAaZk4NfhcKAgw7Vh4pn/0oWWY8Dt1pU
 Ei/w7xbpBX/tXJ3EHERrsgHzXYNk3BF83Ut2dQzVRzfkF6WGd9eUzeA94vRvmxkvojZK
 rjQFQfcBknVqllrcDoMz9eI7Gq9QjoHoCV5nD8eukylC+4DvPsM0SDZlcX5t/S/sbDvk
 Vpww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvujcYYLqhZ/JHnLBYX+ol6dhS1q58rKyzt32gAp801hOzAjkqQIyzRPTKtxDJ2la225xxPjs2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjaUc++J6YDaMYnkXOw+x4MyVNkwhuUY7TNO7Q87AL1SlZZsgh
 4gpyzRYx1i+BVk3XEwaVna2KHPM2U3SsKT045UVQtNhRGUom4bW9AewNVk7K6XbsF4dXtHJiOT+
 +LNk8L3/DGvkNhT4A05nKuzeyk/kndg==
X-Gm-Gg: ASbGncsMv7KsO2/duaWgv4iiVt0oReMPsG279I5sRjkszkUkuNv/7OKW7+I3nemiu8P
 Z0yS9Pxh24l7vtQ8/Rd0rkKYmzLRa7CfzNcS6ded0OFwUe5+WBpLa59if+5uc6j6bIPTBR3Ff
X-Google-Smtp-Source: AGHT+IF/iPvfYM5Lh2XpDt+BJcoDtfQFzHnYLhzgfdqaISS/t1KT+Mz9QPVwLEueNW/qD0N22FiImLn/3DxI4Jlve8k=
X-Received: by 2002:a17:902:d4cb:b0:215:b18d:ec with SMTP id
 d9443c01a7336-220ece3062fmr2123385ad.13.1739479245368; Thu, 13 Feb 2025
 12:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20250213181509.619164-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250213181509.619164-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Feb 2025 15:40:33 -0500
X-Gm-Features: AWEUYZmFm0GDHJglOJl0AyX2Iy83xLvGshZ74jdpcLWAAlA3QYCizdsHePTiSwQ
Message-ID: <CADnq5_MKcmFMYvMWPynGPgHYg3uBmzjze51NFFPSucanP-X-wA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Rename VCN clock gating function for
 consistency
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Leo Liu <leo.liu@amd.com>
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

On Thu, Feb 13, 2025 at 1:32=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Change the function name from vcn_v2_5_enable_clock_gating_inst
> to vcn_v2_5_enable_clock_gating to ensure consistency in naming.
>
> Fixes the below with gcc W=3D1:
> drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:781: warning: expecting prototype f=
or vcn_v2_5_enable_clock_gating_inst(). Prototype was for vcn_v2_5_enable_c=
lock_gating() instead
>
> Cc: Leo Liu <leo.liu@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index b9be304aa294..105e59f6132b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -770,7 +770,7 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amd=
gpu_device *adev,
>  }
>
>  /**
> - * vcn_v2_5_enable_clock_gating_inst - enable VCN clock gating
> + * vcn_v2_5_enable_clock_gating - enable VCN clock gating
>   *
>   * @adev: amdgpu_device pointer
>   * @i: instance to enable clockgating on
> --
> 2.34.1
>
