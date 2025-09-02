Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71264CA1007
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 20:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F410710E00E;
	Tue,  2 Sep 2025 20:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZaZSTe+B";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B9E10E00E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 20:43:23 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-24b132bd90dso2533125ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756845803; x=1757450603; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIgzLbew4LCRZLNDT65U3VFVtMuBP7pCHswUuZMfh8w=;
 b=ZaZSTe+BYOTlGzmWncbTkH7yaSv7yx3QURm4srKUa1sWO08+vP0owtX+NU63aZ3Zw7
 It+hCsoHF80FAUb+MTTJSTkfzzB3Z4D/M73agPHUJn0uxPFONxScdB+vhjBVFo+4Iq/x
 /wW2M0i1mLBD2fyv+7ovMyos4lUkcTv0zEYM/KsdmQn6jF4FnxCG7ZJpThCUzcj39FRt
 sa10c0wep4YGqbNInaEZlSCXHR69h/iAjcTkLjMHCpBlWrKpz9z66rBpHgg5LzGE1cZI
 3UWjb9fBtr9foW6LBkW0fj8mWnMPJdoa1me+1q7xPvL1TFQ//6rh5CTANM1D0+vebau4
 U/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756845803; x=1757450603;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fIgzLbew4LCRZLNDT65U3VFVtMuBP7pCHswUuZMfh8w=;
 b=i3PhlJfjBTvYwOicgDL7Uj/SdS3K/83zv1cvypgIn2vVzNhD+BnyA+QqdxkO9ft+Ay
 TnDSAOfEloZv2mhvq4oONkytH/awTPVHJlfGVye5opLu6a4KlH0Tna8TQjKYicAylhhe
 XdCNtbx0gXLuzsJ7LerIREOtn0RQHTnMhgNH/ikVXp4WI3nKpFlXFBRbOXB40rK6ueUZ
 LRsdNn6YDhY51p7HTIvcMvFFQmxA9gdnZmczEzDDJm0ZjBA/5B6XcdBwCRelX24WeXLE
 K3MJr4rLmIlaz7u00dXme1yTlPtcLhLUIW6vdhs6GbtASMYGLsSvEhmQP5lwFQRio72x
 p9kg==
X-Gm-Message-State: AOJu0Yy3o5ZWKAR8KyZEjjASiXVpMngqv4gYBRVbb0ICL8BCHPPPYSWW
 H81d9rTRNIgdX0shlY0QTWCKhZO15lW0cRe6KYTqIkfd8Y24Ol1Nv/+hiVGmCp1Fzu6NsCK70zY
 RjnANadblQvMOiwRfOPECrYqf3A5TJKE=
X-Gm-Gg: ASbGnct8ti3mKU4J5eTqEUqXc7Vd4jsR9Vfs2lT4celdOi73igts9M0gr3hTfBBiHvL
 rcGP49uVBrgNwWfuPNe+BLTKEbKTTyB4pz97K/tyoV54gFTBJrFl0Ozy98ipRTrCPO4Prez92Pb
 ljbMhITQhR7/ZXPcQOvFdaRPwCO23kvDT0asoWVR8fYXYXbZ4xm8K83lFc8dfb2LSeHXoqTFgkQ
 VAVLLg=
X-Google-Smtp-Source: AGHT+IGbFnHBSjXEySU9cNuj022wUhbvnpPAoCsB0glPzm2t6SAH9UJlobXB5xAbPgxfZ+S9BMUqfVZxa/9gZ4blXO0=
X-Received: by 2002:a17:90b:2dcc:b0:329:d47f:c25b with SMTP id
 98e67ed59e1d1-329d47fe8f4mr3227455a91.7.1756845802794; Tue, 02 Sep 2025
 13:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250902190503.1649105-1-David.Francis@amd.com>
In-Reply-To: <20250902190503.1649105-1-David.Francis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Sep 2025 16:43:10 -0400
X-Gm-Features: Ac12FXz4_EP_y7ASLgGeSTbkcT9RbJ4KwKL4BQAhBL3erau7_VCXKBSLI5v7DkY
Message-ID: <CADnq5_PYyitY67-SJ29S6GyXdvd0R1OY7+gxxYifZR20+NAQxw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Increment drm driver minor version for
 list handles ioctl
To: David Francis <David.Francis@amd.com>
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

On Tue, Sep 2, 2025 at 3:05=E2=80=AFPM David Francis <David.Francis@amd.com=
> wrote:
>
> With the addition of the drm ioctl
> DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES,
> the drm driver version should be incremented (to 65)
>
> Signed-off-by: David Francis <David.Francis@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b42a2a32b0b7..fba38e9ef92e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -126,9 +126,10 @@
>   * - 3.62.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & A=
MDGPU_IDS_FLAGS_MODE_PT
>   * - 3.63.0 - GFX12 display DCC supports 256B max compressed block size
>   * - 3.64.0 - Userq IP support query
> + * - 3.65.0 - Add GEM_LIST_HANDLES ioctl and mapping info option on GEM_=
OP ioctl
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       64
> +#define KMS_DRIVER_MINOR       65
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  /*
> --
> 2.34.1
>
