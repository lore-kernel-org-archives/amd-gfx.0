Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE63C2BA18
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 18:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02568984C;
	Tue, 18 Jun 2024 18:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DKGOWTZL";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC39010E217
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 18:07:45 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2bfff08fc29so4773402a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 11:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718734065; x=1719338865; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDXcheXNa9dT6T8H8FsDJ7+GMieel5CIsbdW1uOFApM=;
 b=DKGOWTZLRl8OWT6ktD1CEBI0u9n8CCKz2qNtrE+euX2E4w35hGsvzlx7UVjSSNuDsH
 nY/7Pa04LehtG4zN6gj9IO1sF6Hs8fKsaq6/kDfVnGYx+nqDocrYp4ZNJycQNzytw3Gw
 zFpMiAGr0cLR/bmewTVUTuvZM88Pcls0hxdBejjcuTf66N6SpTqZvcre4noUYfcshrfQ
 ZXowuuBRvGk2kR0smKCbBzX6bUYHUMYlmiv4fiTvdpm/0+UKDUvaoPmOTUcSY96DNAaW
 dEsJH9FErmPAY0GsREP4y91UqRye6fqdoNW3PPulxBkQT/lmj9cGE+25p/WxGhxHLnkr
 AiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718734065; x=1719338865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KDXcheXNa9dT6T8H8FsDJ7+GMieel5CIsbdW1uOFApM=;
 b=n7xb8P83HoTsBwfOXHDjOGOgHHxULRO/0wBoJX0tpQu6kSXeb9Zo9804o237dMtSzd
 n9L60t4KGnmjpKMyh2jp4LazIXSb7dgFZNu9p0w/Wuxu6nI1XyE2o7Ua/KgDU/DChBwI
 AA2So80R2JZctedw6AqRArv7zCrmkPE4UvdvZp01+fRf9L2n3lP/OXuiNEjvC518oD7G
 MVlgKieC/we4FijQ43Qi0zIRl0uulqwtZ1bRTPtFlQS7J14yVkVrtwgLCYKLXhcj9N7I
 R5Nh440gRTa6ILACjErsimPtdXkmoIJFCT9okh0/Mb4V58u9jyDpfS8+IFhTrru5V2UH
 DSvw==
X-Gm-Message-State: AOJu0Yw0E8MKCt7KgiP8ssvQR+6DNRDCnGK8hwzxHNk0cNslA7wNc8AI
 iPsxGUWk3WsajDWXvm2BrSC62EBY0JH33hw63rbW1amFv5VbNP0aPjvm/C47C/OhBmLpxywI1Fn
 2NVlnN03IO7tnDGSxvOCdkTUQd6M=
X-Google-Smtp-Source: AGHT+IEganNeyN3r6cd8lG45UnwJ2SFXscptn5PbGIOl9hyrhRA0Pw1cAT8bAedY0X32Ak8A15CF0xWoJ6W5+c/0N+I=
X-Received: by 2002:a17:90b:3717:b0:2bf:f248:3506 with SMTP id
 98e67ed59e1d1-2c7b5b7aa9cmr442932a91.12.1718734065250; Tue, 18 Jun 2024
 11:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240618163953.699473-1-sonny.jiang@amd.com>
In-Reply-To: <20240618163953.699473-1-sonny.jiang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Jun 2024 14:07:33 -0400
Message-ID: <CADnq5_Odu6ev-uFuNkPexmXBy0O+a149Sfbo0zh1tbX5CE26dA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/jpeg5: reprogram doorbell setting after power
 up for each playback
To: Sonny Jiang <sonny.jiang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sonny Jiang <sonjiang@amd.com>
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

On Tue, Jun 18, 2024 at 1:17=E2=80=AFPM Sonny Jiang <sonny.jiang@amd.com> w=
rote:
>
> From: Sonny Jiang <sonjiang@amd.com>
>
> Doorbell needs to be configured after power up during each playback
>
> Signed-off-by: Sonny Jiang <sonjiang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_0.c
> index 68ef29bc70e2..e766b9463759 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -137,10 +137,6 @@ static int jpeg_v5_0_0_hw_init(void *handle)
>         adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>                         (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>
> -       WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
> -                       ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET_=
_SHIFT |
> -                       VCN_JPEG_DB_CTRL__EN_MASK);
> -
>         r =3D amdgpu_ring_test_helper(ring);
>         if (r)
>                 return r;
> @@ -314,6 +310,10 @@ static int jpeg_v5_0_0_start(struct amdgpu_device *a=
dev)
>                 JPEG_SYS_INT_EN__DJRBC0_MASK,
>                 ~JPEG_SYS_INT_EN__DJRBC0_MASK);
>
> +       WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
> +               ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
> +               VCN_JPEG_DB_CTRL__EN_MASK);
> +
>         WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_VMID, 0);
>         WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000=
002L));
>         WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
> --
> 2.45.1
>
