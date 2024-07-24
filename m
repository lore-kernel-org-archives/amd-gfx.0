Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09557C3DA63
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 16:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 241F910E73F;
	Wed, 24 Jul 2024 16:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OUFKAv3t";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1623310E73F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 16:03:27 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-1fd70ba6a15so17049575ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 09:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721837006; x=1722441806; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JnR92zVXMi7CBtlq8RJKim8J3+gwTVhcYoJ/y/9dA4w=;
 b=OUFKAv3tMQLxzvR/vwInkdU1MP9VVov8Nzh6InH21G2T3TMVZsXdXbfn9nObcZ9trr
 pEOQiQDYoPZ6D6eE4kbfdLjwTDznnyN3YAyJ2q7ze1Sl0LbLcw9slQedFtD4DwUvNq22
 ghcPwLNpShiVQlqAInf+rnuzsCOo0TXTeW75hqcFJdzWWF1a1caRw5YUhPCpfeszSY/r
 npuTP+pLiaJrl6fS96VkfTzY1FD1rvruNz/3I7nvaNudHyAW9wWKIx4z82KJTbwlsDZ9
 1X0ugef+QhfvHU4jAjwp6wzthiGL54tExNZvZ6RwyUn1bfV/rTFD8L8NVnvSORMIS73m
 DFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721837006; x=1722441806;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JnR92zVXMi7CBtlq8RJKim8J3+gwTVhcYoJ/y/9dA4w=;
 b=VrK258+L2CiaiFaSipIbIgE5YvDTc4T3KfftIubY8zVMW14YL3b8joO8bPij6kXYgn
 hu1Bgufc1Iyd4iVnbnxx0Dvdj7er/AfCscMnkwN0jHybXioDC5np9F8RTWCGu5GYJSP6
 rdklNVHy6tVZUKFkkaGTCcLwmksyQRWCOZ8zDUOzj0RK/K+s0j/JEB4Ey88S5C+UVvHx
 yJ+4257iSPPGsrTqNPmupWapui0+BNpPOOJKMYSlJsWjpWq7CV6xLFHQSA2oNkWefPXE
 m16hsFburwQr7Ah97aDfzfh9If3FC5QLpwASp2vK6ts5F+Jb7av+KhDKTryrS8LBnRPg
 hfGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgEoojy5ZyGK6WNfzi39vkHgZCgTsrnNmeSgwCPpc+ul3DJjgKdnB3u6v6Iok4Gtytc8fbZC81e3MiPKoZFsKCOKb5fQyYw3AQJcS96w==
X-Gm-Message-State: AOJu0YwW3c6qW0y+7FOXqwaO0Baj1jDY/quuCMts3yYYTpEzBFa7lNr7
 pJpsEMYVQzBWWxbHjqzgl8I1UKvp0MSFG7EDGg9RWpoSNH8KmoQc3377ETHXmkkdqcWHUHZo+t8
 5EIZxHErS/ZaAvYiQewiVTxBinRFCug==
X-Google-Smtp-Source: AGHT+IFpF1icqmNZ9ODdIym+U+PPN4ExHWEjRppPsFKwnfCd93MiOH7HEasQDqfC9RsHYxNfkD/l1LXID3jmf11o3VI=
X-Received: by 2002:a17:902:e806:b0:1f9:b9ed:e84e with SMTP id
 d9443c01a7336-1fdd223083cmr40802525ad.58.1721837006261; Wed, 24 Jul 2024
 09:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240724113250.2707693-1-sunil.khatri@amd.com>
 <20240724113250.2707693-3-sunil.khatri@amd.com>
In-Reply-To: <20240724113250.2707693-3-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Jul 2024 12:03:14 -0400
Message-ID: <CADnq5_My4-7NdE7Rp4-J4T21o6x-ipgVWC00RNdwNiu-VTJ2BQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] drm/amdgpu: add vcn_v3_0 ip dump support
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>, 
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

On Wed, Jul 24, 2024 at 7:33=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add support of vcn ip dump in the devcoredump
> for vcn_v3_0.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 149 +++++++++++++++++++++++++-
>  1 file changed, 148 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 24f947751c46..544b46ad55bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -60,6 +60,115 @@
>  #define RDECODE_MSG_CREATE                                     0x0000000=
0
>  #define RDECODE_MESSAGE_CREATE                                 0x0000000=
1
>
> +static const struct amdgpu_hwip_reg_entry vcn_reg_list_3_0[] =3D {
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_POWER_STATUS),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RBC_RB_RPTR),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RBC_RB_WPTR),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_STATUS),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CONTEXT_ID),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_GPCOM_VCPU_DATA0),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_GPCOM_VCPU_DATA1),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_GPCOM_VCPU_CMD),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC1_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC1_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_RBC_IB_VMID),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE_VMIDS_MULTI),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC_VMIDS_MULTI),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI3),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO3),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR3),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR3),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE3),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_PGFSM_CONFIG),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_PGFSM_STATUS),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SOFT_RESET),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SOFT_RESET2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CGC_GATE),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CGC_STATUS),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CGC_CTRL),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_GATE),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_STATUS),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_CTRL),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO4),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI4),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE4),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR4),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR4),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_STATUS2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_GATE2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_VCPU_CACHE_OFFSET2),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_GPGPU_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_GPGPU_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_LOW=
),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_HIG=
H),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_L=
OW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_H=
IGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_REF_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_REF_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_DBW_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_DBW_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CM_COLOC_64BIT_BAR_LOW)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CM_COLOC_64BIT_BAR_HIGH=
),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP0_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP0_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP1_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP1_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP2_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP2_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP3_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP3_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD0_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD0_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD1_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD1_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD2_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD2_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD3_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD3_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD4_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD4_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE3_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE3_64BIT_BAR_HIGH)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE4_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE4_64BIT_BAR_HIGH)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE5_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE5_64BIT_BAR_HIGH)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE6_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE6_64BIT_BAR_HIGH)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE7_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE7_64BIT_BAR_HIGH)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_SCLR_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_SCLR_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_SCLR2_64BIT_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_SCLR2_64BIT_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_B=
AR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_B=
AR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT=
_BAR_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT=
_BAR_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_=
LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_=
HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BA=
R_LOW),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BA=
R_HIGH),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_STATUS),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_REF_LUMA_64BIT_BAR_LOW)=
,
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_REF_LUMA_64BIT_BAR_HIGH=
),
> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SCRATCH1)
> +};
> +
>  static int amdgpu_ih_clientid_vcns[] =3D {
>         SOC15_IH_CLIENTID_VCN,
>         SOC15_IH_CLIENTID_VCN1
> @@ -126,6 +235,8 @@ static int vcn_v3_0_sw_init(void *handle)
>         struct amdgpu_ring *ring;
>         int i, j, r;
>         int vcn_doorbell_index =3D 0;
> +       uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_3_0);
> +       uint32_t *ptr;
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
>         r =3D amdgpu_vcn_sw_init(adev);
> @@ -246,6 +357,15 @@ static int vcn_v3_0_sw_init(void *handle)
>         if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>                 adev->vcn.pause_dpg_mode =3D vcn_v3_0_pause_dpg_mode;
>
> +       /* Allocate memory for VCN IP Dump buffer */
> +       ptr =3D kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint=
32_t), GFP_KERNEL);
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
> @@ -284,6 +404,7 @@ static int vcn_v3_0_sw_fini(void *handle)
>
>         r =3D amdgpu_vcn_sw_fini(adev);
>
> +       kfree(adev->vcn.ip_dump);
>         return r;
>  }
>
> @@ -2203,6 +2324,32 @@ static void vcn_v3_0_set_irq_funcs(struct amdgpu_d=
evice *adev)
>         }
>  }
>
> +static void vcn_v3_0_dump_ip_state(void *handle)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +       int i, j;
> +       bool reg_safe;
> +       uint32_t inst_off;
> +       uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_3_0);
> +
> +       if (!adev->vcn.ip_dump)
> +               return;
> +
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (adev->vcn.harvest_config & (1 << i))
> +                       continue;
> +
> +               inst_off =3D i * reg_count;
> +               reg_safe =3D (RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS) &
> +                           UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) !=3D=
 1 ? true : false;

You can drop the ? true : false.

> +
> +               if (reg_safe)
> +                       for (j =3D 0; j < reg_count; j++)
> +                               adev->vcn.ip_dump[inst_off + j] =3D
> +                                       RREG32(SOC15_REG_ENTRY_OFFSET(vcn=
_reg_list_3_0[j]));

How are you handling the per instance register offset?

Alex

> +       }
> +}
> +
>  static const struct amd_ip_funcs vcn_v3_0_ip_funcs =3D {
>         .name =3D "vcn_v3_0",
>         .early_init =3D vcn_v3_0_early_init,
> @@ -2221,7 +2368,7 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs =
=3D {
>         .post_soft_reset =3D NULL,
>         .set_clockgating_state =3D vcn_v3_0_set_clockgating_state,
>         .set_powergating_state =3D vcn_v3_0_set_powergating_state,
> -       .dump_ip_state =3D NULL,
> +       .dump_ip_state =3D vcn_v3_0_dump_ip_state,
>         .print_ip_state =3D NULL,
>  };
>
> --
> 2.34.1
>
