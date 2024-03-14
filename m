Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F63CC54E60
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 13:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E2E210E473;
	Thu, 14 Mar 2024 13:23:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l+1se9jn";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63D7210E473
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 13:23:05 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-1dd878da011so6233155ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 06:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710422585; x=1711027385; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fHblCUZ4rGwFmV3PegiTWAX/+WEM/W3TOHdtXIW+DQk=;
 b=l+1se9jnWEld6SkLLgm/HwldAGChN7G24zs9uUrZVZ7xF/WDaPOrPz+6b887oE4of2
 RZa12G2SrU4NxYKXbtFeGREvH0F2OEdN+WTMoUtKnCQcPdtvDfZZCTmettSGTNg4MOy7
 QWQW3i+gZL1TKUUEjIUjCRoZOzYqOTEYo/5nSVWYlAQl/mMU8A/4rJsjKwBsifpetfeh
 FMPbHhPvvKPFgukjtsWxt5X1h1wHzEeI95Xpu1MMNqDMk1lf5omRIjIvB2AVjMGNzdQE
 WYv4Y9NqTxUD8eOX+TEdu8SWFib+KXt2xS4jtG8EHgn5aJ2Af1xpw/QVeDpkZC8oR93h
 rBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710422585; x=1711027385;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fHblCUZ4rGwFmV3PegiTWAX/+WEM/W3TOHdtXIW+DQk=;
 b=OZXhOgw4YaQjKNsXSAUC+V1tLTN5oKkYFx3s/4tNPwMn9Dm69aT56YnherltB+J9KY
 k/Uqp6dPg1y6I87gkYCJzmhMRuE+DtafuwDrPdaZuG/JQWPUrqoeOkuGd+j/5XJPaDdX
 Zmbo78s3LijHMFARZXnnwIRiQzuZT5cg851B91pKoB/OGoNKgG+g3qPGc0xm8LFkjtQb
 e064dvW4fS/80x82ba/XjfkZrDA0l7a9ivkSX3ICn3Ye+TgHEhZcAC2P1zhBn/N4hVO2
 6d/lkZk0m498ol/+2c6qrVzSbtEpBCIVCXZV47T7XaqluHeX8qxe4Qlkh+xeHi0owPj3
 4nJA==
X-Gm-Message-State: AOJu0YyxFBoAuMwuGR1jIt2GEwF4asF+ISAfWpHjUU3h3pI70W/8VPZr
 RFWdfQEPXeqarebngGbGysYro8d/qc9xJhiBX5d4wTuNDMcGQXZoF9p4/KqRPeAEQw86yBplu6m
 DQb+N0RU60n4U/MZSaAdsv6KwMfc=
X-Google-Smtp-Source: AGHT+IGfMtmdNleKvkp1fxg6sonSGf99s2hcptbD0plOE6y2OWRW8xqEmctoUW7xJsp4ZzEjl2sOgwkOQeEldHflDkE=
X-Received: by 2002:a17:902:d584:b0:1dd:8a1b:2131 with SMTP id
 k4-20020a170902d58400b001dd8a1b2131mr2048243plh.25.1710422584696; Thu, 14 Mar
 2024 06:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240314131830.27538-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240314131830.27538-1-Hawking.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Mar 2024 09:22:52 -0400
Message-ID: <CADnq5_NGvtS1L-YfZJDYu2SSYZphg1Vm1CFjq5jbE19SaffWuA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Bypass display ta if display hw is not
 available
To: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Kenneth Feng <Kenneth.Feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Yang Wang <kevinyang.wang@amd.com>
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

On Thu, Mar 14, 2024 at 9:18=E2=80=AFAM Hawking Zhang <Hawking.Zhang@amd.co=
m> wrote:
>
> Do not load/invoke display TA if display hardware is not
> available
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 867397fe2e9d..e7d7fd2cc31d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1830,6 +1830,10 @@ static int psp_hdcp_initialize(struct psp_context =
*psp)
>         if (amdgpu_sriov_vf(psp->adev))
>                 return 0;
>
> +       /* bypass hdcp initialization if dmu is harvested */
> +       if (!amdgpu_device_has_display_hardware(psp->adev))
> +               return 0;
> +
>         if (!psp->hdcp_context.context.bin_desc.size_bytes ||
>             !psp->hdcp_context.context.bin_desc.start_addr) {
>                 dev_info(psp->adev->dev, "HDCP: optional hdcp ta ucode is=
 not available\n");
> @@ -1862,6 +1866,9 @@ int psp_hdcp_invoke(struct psp_context *psp, uint32=
_t ta_cmd_id)
>         if (amdgpu_sriov_vf(psp->adev))
>                 return 0;
>
> +       if (!psp->hdcp_context.context.initialized)
> +               return 0;
> +
>         return psp_ta_invoke(psp, ta_cmd_id, &psp->hdcp_context.context);
>  }
>
> @@ -1897,6 +1904,10 @@ static int psp_dtm_initialize(struct psp_context *=
psp)
>         if (amdgpu_sriov_vf(psp->adev))
>                 return 0;
>
> +       /* bypass dtm initialization if dmu is harvested */
> +       if (!amdgpu_device_has_display_hardware(psp->adev))
> +               return 0;
> +
>         if (!psp->dtm_context.context.bin_desc.size_bytes ||
>             !psp->dtm_context.context.bin_desc.start_addr) {
>                 dev_info(psp->adev->dev, "DTM: optional dtm ta ucode is n=
ot available\n");
> @@ -1929,6 +1940,9 @@ int psp_dtm_invoke(struct psp_context *psp, uint32_=
t ta_cmd_id)
>         if (amdgpu_sriov_vf(psp->adev))
>                 return 0;
>
> +       if (!psp->dtm_context.context.initialized)
> +               return 0;
> +
>         return psp_ta_invoke(psp, ta_cmd_id, &psp->dtm_context.context);
>  }
>
> @@ -2063,6 +2077,10 @@ static int psp_securedisplay_initialize(struct psp=
_context *psp)
>         if (amdgpu_sriov_vf(psp->adev))
>                 return 0;
>
> +       /* bypass securedisplay initialization if dmu is harvested */
> +       if (!amdgpu_device_has_display_hardware(psp->adev))
> +                return 0;
> +
>         if (!psp->securedisplay_context.context.bin_desc.size_bytes ||
>             !psp->securedisplay_context.context.bin_desc.start_addr) {
>                 dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta=
 ucode is not available\n");
> --
> 2.17.1
>
