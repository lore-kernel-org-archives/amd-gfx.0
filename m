Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA208C52D6F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 21:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 975E010E330;
	Tue,  6 Aug 2024 21:28:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iXhdSVs0";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BBF010E330
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 21:28:45 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-710afa8d1dfso863440b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Aug 2024 14:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722979725; x=1723584525; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+w65jGjXHCoKbUZfFlz5nrMe+EyxcAF+nCdN72MpM58=;
 b=iXhdSVs0R2FOqBYhG0wW65ueTXLHiQlDjnm3YqyjL3if0Ia38ugejn/6+F8RHaRnQu
 w1GbQNaf/hOFBTiKxD1Yx/k2VWD1ayJJ/TlOGV7Ly3AlTxPS4xOOzIwLla+VkmYyTmTi
 ard/h0jGOGfe4nFC2ruB59ZIrDTTG3mV2552/OEaQNipUtp2gp2DxcEtHw3nd+OTN6R7
 v3+g97W3QtqDc7ZRM0bQTbZSYaAURNWJd3rrgSI8g5SYmVdWGj+GrlC47o2wzISya1Ny
 QBBDbTDr+GdYen9bEWVlB58c1uZM/HRHjcVC5Qag5EM9DrxdgHGjTj2emkmPHrhjTBQd
 RRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722979725; x=1723584525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+w65jGjXHCoKbUZfFlz5nrMe+EyxcAF+nCdN72MpM58=;
 b=wVHB4y3T3c4Th8Qoylmk7GM7W5grZA4HsVvv3+hYw0D0H5uG4CYbGLDWivKnhxktDU
 GZu3+YYkGuXgpwwfi86bOi1sjIvnlL64auOmhSNF/me1B/XKlJsh7kKvPRRiY6QX3+jh
 5U5iz/Ekm4CcNN7+DM433kGbENJLZtVbwwP3OCkF7Z199BhPCVUKUKmVYslwU0TjvalK
 5M9xLT/bc0CM2fwIVVgR5BBRs9zx88tsuH0/FpffGrCnyDKK/Up/k4ztJYG7VrrukBe8
 IRuCh49JGV+DSFcr9fTZbiantH1vgrKOtMJ5EdeVdZHzgdkic5USsWe8a14Ko3R3uIyn
 4vig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSWpba3PFvncfzNbZrn0YnRAAxSDDZobTVGAvUdiK7fTIHZ9ugiOc1tr5mEqWYgWu5UIJpwh2jAhbcGrbHumZqH/gVdSGbFg13vJYuyA==
X-Gm-Message-State: AOJu0YzEdvpH3FH8VlqiBnNxh5NLTSm+R5uSd/v/zldRmmhH3X29bPFl
 its//GrT9ratMfCIS0ODu921cxvCsG3iLmUMRKMIObv5QaOwczBZgRkSZhh2piuiugsnh3fvIn0
 xeIyclAhVVqESEHpT+xY5M2FhFNMfPerS
X-Google-Smtp-Source: AGHT+IFaM7WUUUfqoCKNZrR+Gqy9tOaTlziGiWH5ATX/AklbrkX1uq1M1BHJS+g6Fkh7CBTUauiPCUSRCv/HoHUvPbA=
X-Received: by 2002:a05:6a21:3944:b0:1c0:f33e:aaec with SMTP id
 adf61e73a8af0-1c69964b680mr17478494637.49.1722979724789; Tue, 06 Aug 2024
 14:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240806081825.2422771-1-sunil.khatri@amd.com>
 <20240806081825.2422771-6-sunil.khatri@amd.com>
In-Reply-To: <20240806081825.2422771-6-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Aug 2024 17:28:32 -0400
Message-ID: <CADnq5_NRfRJQn9a44BZw1jge81X+htXjCAGkQue9BNEQ-EqXXQ@mail.gmail.com>
Subject: Re: [PATCH v1 05/15] drm/amdgpu: add vcn_v4_0_3 ip dump support
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Aug 6, 2024 at 4:18=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> Add support of vcn ip dump in the devcoredump
> for vcn_v4_0_3.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 170 +++++++++++++++++++++++-
>  1 file changed, 169 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 9bae95538b62..dd3baccb2904 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -45,6 +45,132 @@
>  #define VCN_VID_SOC_ADDRESS_2_0                0x1fb00
>  #define VCN1_VID_SOC_ADDRESS_3_0       0x48300
>
> +static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] =3D {
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH=
),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH=
),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET0),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET1),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CONTEXT_ID),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA0),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA1),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_CMD),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC1_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC1_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_VMIDS_MULTI),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC_VMIDS_MULTI),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI3),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO3),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI4),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO4),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR3),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR3),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR4),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR4),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_GATE),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_STATUS),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL3),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_CTRL),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_GPGPU_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_GPGPU_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_LO=
W),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_HI=
GH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_=
LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_=
HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_DBW_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_DBW_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_LOW=
),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_HIG=
H),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP0_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP0_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP1_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP1_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP2_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP2_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP3_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP3_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD0_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD0_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD1_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD1_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD2_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD2_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD3_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD3_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD4_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD4_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH=
),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE3_64BIT_BAR_LOW)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE3_64BIT_BAR_HIGH=
),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE4_64BIT_BAR_LOW)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE4_64BIT_BAR_HIGH=
),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE5_64BIT_BAR_LOW)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE5_64BIT_BAR_HIGH=
),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE6_64BIT_BAR_LOW)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE6_64BIT_BAR_HIGH=
),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE7_64BIT_BAR_LOW)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE7_64BIT_BAR_HIGH=
),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR2_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR2_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_=
BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_=
BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BI=
T_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BI=
T_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR=
_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR=
_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_B=
AR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_B=
AR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_STATUS),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_DATA),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_MASK),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_PAUSE),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_L=
OW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_H=
IGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_VCPU_CACHE_OFFSET0),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_VMID),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_CLK_EN_VCPU_REPORT),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SCRATCH1)
> +};
> +
>  #define NORMALIZE_VCN_REG_OFFSET(offset) \
>                 (offset & 0x1FFFF)
>
> @@ -92,6 +218,8 @@ static int vcn_v4_0_3_sw_init(void *handle)
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>         struct amdgpu_ring *ring;
>         int i, r, vcn_inst;
> +       uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_4_0_3);
> +       uint32_t *ptr;
>
>         r =3D amdgpu_vcn_sw_init(adev);
>         if (r)
> @@ -159,6 +287,15 @@ static int vcn_v4_0_3_sw_init(void *handle)
>                 }
>         }
>
> +       /* Allocate memory for VCN IP Dump buffer */
> +       ptr =3D kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32=
_t), GFP_KERNEL);
> +       if (ptr =3D=3D NULL) {
> +               DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
> +               adev->vcn.ip_dump =3D NULL;
> +       } else {
> +               adev->vcn.ip_dump =3D ptr;
> +       }
> +
>         return 0;
>  }
>
> @@ -194,6 +331,8 @@ static int vcn_v4_0_3_sw_fini(void *handle)
>
>         r =3D amdgpu_vcn_sw_fini(adev);
>
> +       kfree(adev->vcn.ip_dump);
> +
>         return r;
>  }
>
> @@ -1684,6 +1823,35 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu=
_device *adev)
>         adev->vcn.inst->irq.funcs =3D &vcn_v4_0_3_irq_funcs;
>  }
>
> +static void vcn_v4_0_3_dump_ip_state(void *handle)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +       int i, j;
> +       bool is_powered;
> +       uint32_t inst_off;
> +       uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_4_0_3);
> +
> +       if (!adev->vcn.ip_dump)
> +               return;
> +
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (adev->vcn.harvest_config & (1 << i))
> +                       continue;
> +
> +               inst_off =3D i * reg_count;
> +               /* mmUVD_POWER_STATUS is always readable and is first ele=
ment of the array */
> +               adev->vcn.ip_dump[inst_off] =3D RREG32_SOC15(VCN, i, regU=
VD_POWER_STATUS);

I think you need to use the GET_INST() macro to properly handle this.  E.g.=
,
vcn_inst =3D GET_INST(VCN, i);

Alex

> +               is_powered =3D (adev->vcn.ip_dump[inst_off] &
> +                               UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) =
!=3D 1;
> +
> +               if (is_powered)
> +                       for (j =3D 1; j < reg_count; j++)
> +                               adev->vcn.ip_dump[inst_off + j] =3D
> +                                       RREG32(SOC15_REG_ENTRY_OFFSET_INS=
T(
> +                                               vcn_reg_list_4_0_3[j], i)=
);
> +       }
> +}
> +
>  static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs =3D {
>         .name =3D "vcn_v4_0_3",
>         .early_init =3D vcn_v4_0_3_early_init,
> @@ -1702,7 +1870,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_func=
s =3D {
>         .post_soft_reset =3D NULL,
>         .set_clockgating_state =3D vcn_v4_0_3_set_clockgating_state,
>         .set_powergating_state =3D vcn_v4_0_3_set_powergating_state,
> -       .dump_ip_state =3D NULL,
> +       .dump_ip_state =3D vcn_v4_0_3_dump_ip_state,
>         .print_ip_state =3D NULL,
>  };
>
> --
> 2.34.1
>
