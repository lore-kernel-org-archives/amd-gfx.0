Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297C5C3ABCC
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 16:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA58810E25D;
	Tue, 13 May 2025 16:45:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hhLgv9uI";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A0210E142
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 16:45:09 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-22e696bbc85so7344385ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747154708; x=1747759508; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9iQw3rPC4MMDwF6PVhxgITs0Pt2hQtRby37OqxvKFq0=;
 b=hhLgv9uIBE3M4/D5wwTTC0u9tzhCLg99GOsQpi4iNGsTyoa19lt0KBkqtNwxTbS/I1
 98R4Hytdw55TG78kX6dEDHPbpNiH62kjBlKHCo7wNf4p4LF139LycEDNthnI/JqJjKq0
 QB43YSMJuPIvds1iCly7hPPAiK27qlpMmaRD3W6vF0gQfPD7nLkrgfSo2odBLViW7qqC
 zcdmbctarqIfTqSxutoLnmNWTS9/1qJLDXlxy9i2yVaShY0S5Yuoq4gUtWROn7urYJqh
 u9InD5DaxupD7npSW3Dtpz/UzwtTrx/7es1JK+nnDGrEXk7YZyDCBjdTD56murE+YyCY
 NRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747154708; x=1747759508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9iQw3rPC4MMDwF6PVhxgITs0Pt2hQtRby37OqxvKFq0=;
 b=Uj/nUoz0SMH5FPCyYj/CqbiZTG0SMyguzL+X6pLsDyiEMNdX1BVqsJhDE9XQfw7rmQ
 nIKDN8W39EYllSo3z7DMMktejoZrgVV1wRTp+6wNkTJVepCjHH6ZxIIYPHJDzZxbu2O2
 YnOD0V3WzaRkSKx8q2K/iQ+TV2UyyU5zDn6pH0H0XD0Qactt9aAeoA/cFv+o84iE0Do+
 5LSrYTYerxUdgYm3hsVmNM0WL3zCMZfJf6ZUkmjUPsYsiFzkp2VxCWfyjRdoL7UD+ty4
 dTqpd5H4ATyeHBoLk3naJMvod1t9dLq1bXOq/N/L8bfnMlF7eAUKPkojfdlae21PwBYi
 riKQ==
X-Gm-Message-State: AOJu0YwxJpdYvzj0mxtayJ2SgfAyCt0eKSelJ2xlJ5ua0HgfNb4b0KbN
 mJ1gekX809Knd6vo7NHeSUW1TGe4wjNz/5RHiZcFK5g1sFxgqJJP5eBilxD5DEvhGVWGlpptpsE
 3rhSDeaz/DeawKrokagw4I+KYrY4ePQ==
X-Gm-Gg: ASbGncu2Yz/rmxoFdPMDhvdAKgXDBuQRUGXXDUihLKhSQu7BGDuiKgHyZBlzycMdkVI
 I2R60+z+yYYzhNd7MQRNU1G64/MLMM40yvx1c6vxFoqs12LTo62cM3fICtNhpydj6vVhRpBL8Ux
 9IUrI3qPwEFdIe2PPj+oY8C4Mu/xJbf/pZEvW2KcVgoIM=
X-Google-Smtp-Source: AGHT+IGCLGVpb7jGjHSHvQsiFCfy3beYXJoE0tWVrDAAN/NSOKrjM86Dp8gLDoK/hgEV834D+BYzby5c4DvUVPfF8Rw=
X-Received: by 2002:a17:903:1984:b0:231:7fbc:19c9 with SMTP id
 d9443c01a7336-2319810ea4cmr807135ad.1.1747154708158; Tue, 13 May 2025
 09:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250513162912.634716-1-David.Wu3@amd.com>
In-Reply-To: <20250513162912.634716-1-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 May 2025 12:44:56 -0400
X-Gm-Features: AX0GCFt_zpQ0P1YWbQqYyOo2zKyDqL46kqlXipx1zxscZ6ePplgD-FIR8Ulo7us
Message-ID: <CADnq5_P5QrYhLEzkwPUMvgYSmk8NkTOusa1dmBFD=veNfshBAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: read back DB_CTRL register after written
 for VCN v4.0.5
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
 alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com, 
 ruijing.dong@amd.com, stable@vger.kernel.org
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

On Tue, May 13, 2025 at 12:38=E2=80=AFPM David (Ming Qiang) Wu
<David.Wu3@amd.com> wrote:
>
> On VCN v4.0.5 there is a race condition where the WPTR is not
> updated after starting from idle when doorbell is used. The read-back
> of regVCN_RB1_DB_CTRL register after written is to ensure the
> doorbell_index is updated before it can work properly.
>
> Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index ed00d35039c1..d6be8b05d7a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1033,6 +1033,8 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_=
vcn_inst *vinst,
>         WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
>                         ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__=
SHIFT |
>                         VCN_RB1_DB_CTRL__EN_MASK);
> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>
>         return 0;
>  }
> @@ -1195,6 +1197,8 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_inst =
*vinst)
>         WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
>                      ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHI=
FT |
>                      VCN_RB1_DB_CTRL__EN_MASK);
> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> +       RREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL);

You might want to move this one down to the end of the function to
post the other subsequent writes.  Arguably all of the VCNs should do
something similar.  If you want to make sure a PCIe write goes
through, you need to issue a subsequent read.  Doing this at the end
of each function should post all previous writes.

Alex

>
>         WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
>         WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_a=
ddr));
> --
> 2.49.0
>
