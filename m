Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D42C44536
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 15:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE3BC10E418;
	Wed, 22 Jul 2026 15:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lG3OwLWM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF7F10E418
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 15:13:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B385340247;
 Wed, 22 Jul 2026 15:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F401F000E9;
 Wed, 22 Jul 2026 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784733180;
 bh=rSZGsxAHBGU3vYc1yiCvW0d/D0MTTeIJ4xHa391STK0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lG3OwLWM5I/C7HxF+IoFyVWB7C/VKgnu2tYGwRyHhKWGXh6TxbbSPhW4sqRwkWN3H
 GffBdibQBp1rJdzoDTUoqgJfzzs7zQtNrpWhEWD5hZFSqOGufAGT1wh2HhKMi//jX+
 WlcUrBAmH9D2CNTZT0NDCzonvuTFtn3kGnw33gP9vAjr2NB/VLld9kU7UfI481jkzK
 0rRppu7XHfAtjhKzI8nKMfiu7/2GhcJ8AqaGqGgY92jWokzyhKsiE1YcE3aJgE2xal
 rPlppvtT3su+FkQmG8ATlBH17IKRj64dwieBUcA1ahjRzXPt5gu+VsyOPLa6MG+h+t
 67rEIgJsIYhTA==
Message-ID: <8e657905-5ccf-47de-bec6-6e3aa93d296f@kernel.org>
Date: Wed, 22 Jul 2026 10:12:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix NBIO 7.11.5 offsets
Content-Language: en-US
To: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Sunil.Khatri@amd.com,
 Arunpravin.PaneerSelvam@amd.com
Cc: Veerabadhran.Gopalakrishnan@amd.com, Pratik.Vishwakarma@amd.com
References: <20260722081727.1691277-1-Shubhankar.MilindSardeshpande@amd.com>
 <20260722081727.1691277-2-Shubhankar.MilindSardeshpande@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260722081727.1691277-2-Shubhankar.MilindSardeshpande@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 7/22/26 03:17, Shubhankar Milind Sardeshpande wrote:
> Fix NBIO 7.11.5 related offsets
> 
> Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 146 ++++++++++++-----------
>   1 file changed, 76 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
> index c78f0598637f..000516b5845a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
> @@ -30,70 +30,76 @@
>   #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
>   #include <uapi/linux/kfd_ioctl.h>
>   
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10                                                           0x4f0aeb
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10_BASE_IDX                                                  3
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1_nbif_4_10                                                          0x4f0aec
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1_nbif_4_10_BASE_IDX                                                 3
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10                                                           0x4f0aed
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10_BASE_IDX                                                  3
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1_nbif_4_10                                                          0x4f0aee
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1_nbif_4_10_BASE_IDX                                                 3
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10                                                           0x4f0aef
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10_BASE_IDX                                                  3
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1_nbif_4_10                                                          0x4f0af0
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1_nbif_4_10_BASE_IDX                                                 3
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10                                                           0x4f0af1
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10_BASE_IDX                                                  3
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1_nbif_4_10                                                          0x4f0af2
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1_nbif_4_10_BASE_IDX                                                 3
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10                                                           0x4f0af3
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10_BASE_IDX                                                  3
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1_nbif_4_10                                                          0x4f0af4
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1_nbif_4_10_BASE_IDX                                                 3
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10                                                           0x4f0af5
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10_BASE_IDX                                                  3
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10                                                          0x4f0af6
> -#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10_BASE_IDX                                                 3
> -#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10                                                              0x0021
> -#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10_BASE_IDX                                                     2
> -
> -#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5                                      0x8e13
> -#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5_BASE_IDX                             5
> -#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5                                       0x8e14
> -#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5_BASE_IDX                              5
> -#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5                                           0x8e15
> -#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5_BASE_IDX                                  5
> -
> -#define regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5                                                     0x8e4d
> -#define regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                                            5
> -#define regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5                                                     0x8e4e
> -#define regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                                            5
> -
> -#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5                                                      0xd000
> -#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5_BASE_IDX                                             5
> -
> -#define regBIF_BX0_BIF_FB_EN_nbio_7_11_5                                                                    0x8e20
> -#define regBIF_BX0_BIF_FB_EN_nbio_7_11_5_BASE_IDX                                                           5
> -
> -#define regBIF_BX0_INTERRUPT_CNTL_nbio_7_11_5                                                               0x8e11
> -#define regBIF_BX0_INTERRUPT_CNTL_nbio_7_11_5_BASE_IDX                                                      5
> -#define regBIF_BX0_INTERRUPT_CNTL2_nbio_7_11_5                                                              0x8e12
> -#define regBIF_BX0_INTERRUPT_CNTL2_nbio_7_11_5_BASE_IDX                                                     5
> -
> -#define regBIF_BX_PF0_GPU_HDP_FLUSH_REQ_nbio_7_11_5                                                         0x8e26
> -#define regBIF_BX_PF0_GPU_HDP_FLUSH_REQ_nbio_7_11_5_BASE_IDX                                                5
> -#define regBIF_BX_PF0_GPU_HDP_FLUSH_DONE_nbio_7_11_5                                                        0x8e27
> -#define regBIF_BX_PF0_GPU_HDP_FLUSH_DONE_nbio_7_11_5_BASE_IDX                                               5
> -
> -#define regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5                                              0x8e17
> -#define regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                                     5
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10                                 0x4f0aeb
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10_BASE_IDX                        3
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1_nbif_4_10                                0x4f0aec
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1_nbif_4_10_BASE_IDX                       3
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10                                 0x4f0aed
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10_BASE_IDX                        3
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1_nbif_4_10                                0x4f0aee
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1_nbif_4_10_BASE_IDX                       3
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10                                 0x4f0aef
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10_BASE_IDX                        3
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1_nbif_4_10                                0x4f0af0
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1_nbif_4_10_BASE_IDX                       3
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10                                 0x4f0af1
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10_BASE_IDX                        3
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1_nbif_4_10                                0x4f0af2
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1_nbif_4_10_BASE_IDX                       3
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10                                 0x4f0af3
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10_BASE_IDX                        3
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1_nbif_4_10                                0x4f0af4
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1_nbif_4_10_BASE_IDX                       3
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10                                 0x4f0af5
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10_BASE_IDX                        3
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10                                0x4f0af6
> +#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10_BASE_IDX                       3
> +#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10                                    0x0021
> +#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10_BASE_IDX                           2
> +
> +#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5                  0x8e13
> +#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5_BASE_IDX         5
> +#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5                   0x8e14
> +#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5_BASE_IDX          5
> +#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5                       0x8e15
> +#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5_BASE_IDX              5
> +
> +#define regBIF_BX1_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5                                 0x012d
> +#define regBIF_BX1_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                        2
> +#define regBIF_BX1_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5                                 0x012e
> +#define regBIF_BX1_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                        2
> +
> +#define regRCC_STRAP1_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5                                  0x0021
> +#define regRCC_STRAP1_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5_BASE_IDX                         2
> +
> +#define regBIF_BX1_BIF_FB_EN_nbio_7_11_5                                                0x0100
> +#define regBIF_BX1_BIF_FB_EN_nbio_7_11_5_BASE_IDX                                       2
> +
> +#define regBIF_BX1_INTERRUPT_CNTL_nbio_7_11_5                                           0x00f1
> +#define regBIF_BX1_INTERRUPT_CNTL_nbio_7_11_5_BASE_IDX                                  2
> +#define regBIF_BX1_INTERRUPT_CNTL2_nbio_7_11_5                                          0x00f2
> +#define regBIF_BX1_INTERRUPT_CNTL2_nbio_7_11_5_BASE_IDX                                 2
> +
> +#define regBIF_BX_PF1_GPU_HDP_FLUSH_REQ_nbio_7_11_5                                     0x0106
> +#define regBIF_BX_PF1_GPU_HDP_FLUSH_REQ_nbio_7_11_5_BASE_IDX                            2
> +#define regBIF_BX_PF1_GPU_HDP_FLUSH_DONE_nbio_7_11_5                                    0x0107
> +#define regBIF_BX_PF1_GPU_HDP_FLUSH_DONE_nbio_7_11_5_BASE_IDX                           2
> +
> +#define regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5                          0x00f7
> +#define regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                 2
> +
> +//BIF_BX1_BIF_FB_EN
> +#define BIF_BX1_BIF_FB_EN__FB_READ_EN__SHIFT_nbio_7_11_5                                0x0
> +#define BIF_BX1_BIF_FB_EN__FB_WRITE_EN__SHIFT_nbio_7_11_5                               0x1
> +#define BIF_BX1_BIF_FB_EN__FB_READ_EN_MASK_nbio_7_11_5                                  0x00000001L
> +#define BIF_BX1_BIF_FB_EN__FB_WRITE_EN_MASK_nbio_7_11_5                                 0x00000002L
>   
>   static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
>   {
>   	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5)) {
> -		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5,
> +		WREG32_SOC15(NBIO, 0, regBIF_BX1_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5,
>   			adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> -		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5,
> +		WREG32_SOC15(NBIO, 0, regBIF_BX1_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5,
>   			adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
>   	} else {
>   		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
> @@ -110,7 +116,7 @@ static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device *adev)
>   	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
>   		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10);
>   	else if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
> -		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5);
> +		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP1_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5);
>   	else
>   		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
>   
> @@ -124,11 +130,11 @@ static void nbif_v6_3_1_mc_access_enable(struct amdgpu_device *adev, bool enable
>   {
>   	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5)) {
>   		if (enable)
> -			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_nbio_7_11_5,
> -				     BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
> -				     BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
> +			WREG32_SOC15(NBIO, 0, regBIF_BX1_BIF_FB_EN_nbio_7_11_5,
> +				     BIF_BX1_BIF_FB_EN__FB_READ_EN_MASK_nbio_7_11_5 |
> +				     BIF_BX1_BIF_FB_EN__FB_WRITE_EN_MASK_nbio_7_11_5);
>   		else
> -			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_nbio_7_11_5, 0);
> +			WREG32_SOC15(NBIO, 0, regBIF_BX1_BIF_FB_EN_nbio_7_11_5, 0);
>   	} else {
>   		if (enable)
>   			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
> @@ -383,12 +389,12 @@ static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
>   
>   	/* setup interrupt control */
>   	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
> -		WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2_nbio_7_11_5,
> +		WREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL2_nbio_7_11_5,
>   				adev->dummy_page_addr >> 8);
>   	else
>   		WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2, adev->dummy_page_addr >> 8);
>   
> -	interrupt_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL_nbio_7_11_5);
> +	interrupt_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL_nbio_7_11_5);
>   	/*
>   	 * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=0 - dummy read disabled with msi, enabled without msi
>   	 * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=1 - dummy read controlled by IH_DUMMY_RD_EN
> @@ -401,7 +407,7 @@ static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
>   				       IH_REQ_NONSNOOP_EN, 0);
>   
>   	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
> -		WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL_nbio_7_11_5, interrupt_cntl);
> +		WREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL_nbio_7_11_5, interrupt_cntl);
>   	else
>   		WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL, interrupt_cntl);
>   }
> @@ -427,7 +433,7 @@ nbif_v6_3_1_get_clockgating_state(struct amdgpu_device *adev,
>   static u32 nbif_v6_3_1_get_hdp_flush_req_offset(struct amdgpu_device *adev)
>   {
>   	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
> -		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ_nbio_7_11_5);
> +		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_GPU_HDP_FLUSH_REQ_nbio_7_11_5);
>   	else
>   		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ);
>   }
> @@ -435,7 +441,7 @@ static u32 nbif_v6_3_1_get_hdp_flush_req_offset(struct amdgpu_device *adev)
>   static u32 nbif_v6_3_1_get_hdp_flush_done_offset(struct amdgpu_device *adev)
>   {
>   	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
> -		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE_nbio_7_11_5);
> +		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_GPU_HDP_FLUSH_DONE_nbio_7_11_5);
>   	else
>   		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE);
>   }
> @@ -622,7 +628,7 @@ static void nbif_v6_3_1_set_reg_remap(struct amdgpu_device *adev)
>   	} else {
>   		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
>   			adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
> -				regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5) << 2;
> +				regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5) << 2;
>   		else
>   			adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
>   				regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;

