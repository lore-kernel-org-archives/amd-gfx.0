Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDB9C00454
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DBD2054F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FF1e0KqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DBD2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761306E046;
	Thu, 12 Dec 2019 17:59:42 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680082.outbound.protection.outlook.com [40.107.68.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120DD6E046
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 17:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZq9+OC7TEfChSNXEIj4nDMqQBW6yJgq/F17wKGaZyG66i19KLEcNceCafLg7osE+URW+rdAR48A0Wxy1IloXbAiE/Lkctx8ugdmNeNI/hTnCQdxI3NEKqkZcIMpJxDvGlRlxH0giMNkvVtPDJJlkkLDauz6kF7teTBil7+delbdk7RLY9X2/mBO2CZBbM4SlgBhw17Xv+G2IWfSxHcyAlPwEbEUIOgYLQpe+Pg0MYWDiVq8UyL8seEjl/ljftBWBG4/L/EDrg0jg3uyk254hNlnqKzX1R6S2GnFicQmP5NWB2+E4QhnZxvLAk+a+1yxMBTT6GIwUgl8nKqRUM894A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDG5pS02l/TKfyp7AvKx6BEHG1ru69juK76YmnKGqco=;
 b=ogX7ENCFlTFD/PYzL0bC4a8ZRSPnyOo8ta8IVS75fpLyt10Zf/I2RQBbcQ0F/6DEsZXjjFpuwZdQcO0IDWO2ChYUDl6h8dAj6OCEcPfq/WIsXlDYOKovnqA8V0Jv0L6BwFY8VeKZCSg9UA+N7GCrFeBo5gq3yjNA0qtNtAzGAw5cQq22c78tCOtNl4joVEIgvz+KtAUsURY6HHM8X8fFhhpkEyLP4KzHEJb+WFGYxgZtVpKk2m6BeVS8kCn4kZrWEziPjRJZ9FPkkwnlHiF9goygsZtoMIoUULTdYH0trRGOSyHVQbBtHRWsp9lsjiXwtEtLE3siwXb3PyNUUzzxWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDG5pS02l/TKfyp7AvKx6BEHG1ru69juK76YmnKGqco=;
 b=FF1e0KqQLr5a9kSrCHaTc4QIwjKgrYYudGtWQ2tdIzCNyENtpBqLFfofiWkwyVzAiD9hhVy6Dn+Gyparzio0UiQnmhn8YYFf3bwvTrVS/dx8TVKUwMQ2Ers9LJh2QzlNY8qP7wr5ZYyLnn/q/ihZOXPDLsOXlxCdKdLJ5fDuYQg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from CY4PR12MB1254.namprd12.prod.outlook.com (10.168.169.17) by
 CY4PR12MB1623.namprd12.prod.outlook.com (10.172.67.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Thu, 12 Dec 2019 17:59:39 +0000
Received: from CY4PR12MB1254.namprd12.prod.outlook.com
 ([fe80::a4e2:1fed:2676:7d16]) by CY4PR12MB1254.namprd12.prod.outlook.com
 ([fe80::a4e2:1fed:2676:7d16%6]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 17:59:39 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu/vcn1.0: use its own idle handler and begin
 use funcs
To: amd-gfx@lists.freedesktop.org
References: <20191211194824.11146-1-leo.liu@amd.com>
 <20191212160649.20375-1-leo.liu@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <7b9f2ce9-113d-85a0-9250-b5a3f20c691e@amd.com>
Date: Thu, 12 Dec 2019 12:59:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20191212160649.20375-1-leo.liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::15)
 To CY4PR12MB1254.namprd12.prod.outlook.com
 (2603:10b6:903:41::17)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62dfeb8f-1a15-4919-f125-08d77f2d0e78
X-MS-TrafficTypeDiagnostic: CY4PR12MB1623:
X-Microsoft-Antispam-PRVS: <CY4PR12MB162397E073E5B707AC7BCE7DE4550@CY4PR12MB1623.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(199004)(189003)(81156014)(4001150100001)(5660300002)(8676002)(31686004)(26005)(2616005)(66476007)(316002)(8936002)(81166006)(66556008)(66946007)(186003)(6916009)(6512007)(52116002)(2906002)(6486002)(478600001)(6506007)(36756003)(31696002)(53546011)(36916002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1623;
 H:CY4PR12MB1254.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kiVqPN+qeMGMq5GRIO0ukokgo804cxhw/g/r73+S0p8mftkUvGG/TdSLtiOUEtHWa5voyfAhmDedX/7JZbKdoNORhN92CibbI3prOsu2Lv3uvS2E4gShVKKtwGvmpASN/Ebjof1ZTPBJqv2naIWNzWiN6Hb/zgGNqcDhtsCBQyGXpVXZN4kMxzqXHNw3YeVHk3pM3eorE4zic/Qky868u5Cm86jZkf8uug5J0f/aU4XYErmAgAsW7Axw3avKwPglERH7bHqmwPjx7VUZQ+Yh5tnMQI2SAJCujwWuJXS+3SOx8Nlq95eJQSV+ZYUWgLxkuNUMWH2kgwHgEcygumbsgJ6UR2bQzbWcp4Lg8UqqObboNp1MjGRryW2ZxDuylUnrLKFtZd9MuOUii9BwZKMAXSbtkjQaYQnYUFGrcdJBJvgrpKpa6V+etfSFV/ODW8XP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dfeb8f-1a15-4919-f125-08d77f2d0e78
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 17:59:39.2156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouEYthFy7fAQHwmuK95j7j0xd67ikfu2HRJXO/POvG50hF4fRg3AM4p6ipD1sT+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1623
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: James Zhu <James.Zhu@amd.com> for the series.

On 2019-12-12 11:06 a.m., Leo Liu wrote:
> Because VCN1.0 power management and DPG mode are managed together with
> JPEG1.0 under both HW and FW, so separated them from general VCN code.
> Also the multiple instances case got removed, since VCN1.0 HW just have
> a single instance.
>
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +
>   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c  |  3 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 88 ++++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h   |  2 +
>   5 files changed, 96 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 428cfd58b37d..e962c87d04cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -39,9 +39,6 @@
>   #include "vcn/vcn_1_0_offset.h"
>   #include "vcn/vcn_1_0_sh_mask.h"
>   
> -/* 1 second timeout */
> -#define VCN_IDLE_TIMEOUT	msecs_to_jiffies(1000)
> -
>   /* Firmware Names */
>   #define FIRMWARE_RAVEN		"amdgpu/raven_vcn.bin"
>   #define FIRMWARE_PICASSO	"amdgpu/picasso_vcn.bin"
> @@ -71,7 +68,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   	unsigned char fw_check;
>   	int i, r;
>   
> -	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
> +	/* For VCN2.0 and above */
> +	if (adev->asic_type >= CHIP_ARCTURUS)
> +		INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
>   
>   	switch (adev->asic_type) {
>   	case CHIP_RAVEN:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 402a5046b985..3484ead62046 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -56,6 +56,9 @@
>   #define VCN_VID_IP_ADDRESS_2_0		0x0
>   #define VCN_AON_IP_ADDRESS_2_0		0x30000
>   
> +/* 1 second timeout */
> +#define VCN_IDLE_TIMEOUT	msecs_to_jiffies(1000)
> +
>   #define RREG32_SOC15_DPG_MODE(ip, inst, reg, mask, sram_sel) 				\
>   	({	WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_MASK, mask); 			\
>   		WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_CTL, 				\
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> index a141408dfb23..0debfd9f428c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -25,6 +25,7 @@
>   #include "amdgpu_jpeg.h"
>   #include "soc15.h"
>   #include "soc15d.h"
> +#include "vcn_v1_0.h"
>   
>   #include "vcn/vcn_1_0_offset.h"
>   #include "vcn/vcn_1_0_sh_mask.h"
> @@ -561,7 +562,7 @@ static const struct amdgpu_ring_funcs jpeg_v1_0_decode_ring_vm_funcs = {
>   	.insert_start = jpeg_v1_0_decode_ring_insert_start,
>   	.insert_end = jpeg_v1_0_decode_ring_insert_end,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
> -	.begin_use = amdgpu_vcn_ring_begin_use,
> +	.begin_use = vcn_v1_0_ring_begin_use,
>   	.end_use = amdgpu_vcn_ring_end_use,
>   	.emit_wreg = jpeg_v1_0_decode_ring_emit_wreg,
>   	.emit_reg_wait = jpeg_v1_0_decode_ring_emit_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 652cecc030b3..7395286540e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -25,6 +25,7 @@
>   
>   #include "amdgpu.h"
>   #include "amdgpu_vcn.h"
> +#include "amdgpu_pm.h"
>   #include "soc15.h"
>   #include "soc15d.h"
>   #include "soc15_common.h"
> @@ -51,6 +52,8 @@ static int vcn_v1_0_set_powergating_state(void *handle, enum amd_powergating_sta
>   static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
>   				struct dpg_pause_state *new_state);
>   
> +static void vcn_v1_0_idle_work_handler(struct work_struct *work);
> +
>   /**
>    * vcn_v1_0_early_init - set function pointers
>    *
> @@ -101,6 +104,7 @@ static int vcn_v1_0_sw_init(void *handle)
>   			return r;
>   	}
>   
> +	INIT_DELAYED_WORK(&adev->vcn.idle_work, vcn_v1_0_idle_work_handler);
>   	r = amdgpu_vcn_sw_init(adev);
>   	if (r)
>   		return r;
> @@ -1758,6 +1762,86 @@ static int vcn_v1_0_set_powergating_state(void *handle,
>   	return ret;
>   }
>   
> +static void vcn_v1_0_idle_work_handler(struct work_struct *work)
> +{
> +	struct amdgpu_device *adev =
> +		container_of(work, struct amdgpu_device, vcn.idle_work.work);
> +	unsigned int fences = 0, i;
> +
> +	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> +		fences += amdgpu_fence_count_emitted(&adev->vcn.inst->ring_enc[i]);
> +
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +		struct dpg_pause_state new_state;
> +
> +		if (fences)
> +			new_state.fw_based = VCN_DPG_STATE__PAUSE;
> +		else
> +			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
> +
> +		if (amdgpu_fence_count_emitted(&adev->jpeg.inst->ring_dec))
> +			new_state.jpeg = VCN_DPG_STATE__PAUSE;
> +		else
> +			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
> +
> +		adev->vcn.pause_dpg_mode(adev, &new_state);
> +	}
> +
> +	fences += amdgpu_fence_count_emitted(&adev->jpeg.inst->ring_dec);
> +	fences += amdgpu_fence_count_emitted(&adev->vcn.inst->ring_dec);
> +
> +	if (fences == 0) {
> +		amdgpu_gfx_off_ctrl(adev, true);
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_uvd(adev, false);
> +		else
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> +			       AMD_PG_STATE_GATE);
> +	} else {
> +		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
> +	}
> +}
> +
> +void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
> +
> +	if (set_clocks) {
> +		amdgpu_gfx_off_ctrl(adev, false);
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_uvd(adev, true);
> +		else
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> +			       AMD_PG_STATE_UNGATE);
> +	}
> +
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +		struct dpg_pause_state new_state;
> +		unsigned int fences = 0, i;
> +
> +		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> +			fences += amdgpu_fence_count_emitted(&adev->vcn.inst->ring_enc[i]);
> +
> +		if (fences)
> +			new_state.fw_based = VCN_DPG_STATE__PAUSE;
> +		else
> +			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
> +
> +		if (amdgpu_fence_count_emitted(&adev->jpeg.inst->ring_dec))
> +			new_state.jpeg = VCN_DPG_STATE__PAUSE;
> +		else
> +			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
> +
> +		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
> +			new_state.fw_based = VCN_DPG_STATE__PAUSE;
> +		else if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
> +			new_state.jpeg = VCN_DPG_STATE__PAUSE;
> +
> +		adev->vcn.pause_dpg_mode(adev, &new_state);
> +	}
> +}
> +
>   static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
>   	.name = "vcn_v1_0",
>   	.early_init = vcn_v1_0_early_init,
> @@ -1804,7 +1888,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>   	.insert_start = vcn_v1_0_dec_ring_insert_start,
>   	.insert_end = vcn_v1_0_dec_ring_insert_end,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
> -	.begin_use = amdgpu_vcn_ring_begin_use,
> +	.begin_use = vcn_v1_0_ring_begin_use,
>   	.end_use = amdgpu_vcn_ring_end_use,
>   	.emit_wreg = vcn_v1_0_dec_ring_emit_wreg,
>   	.emit_reg_wait = vcn_v1_0_dec_ring_emit_reg_wait,
> @@ -1836,7 +1920,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_enc_ring_vm_funcs = {
>   	.insert_nop = amdgpu_ring_insert_nop,
>   	.insert_end = vcn_v1_0_enc_ring_insert_end,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
> -	.begin_use = amdgpu_vcn_ring_begin_use,
> +	.begin_use = vcn_v1_0_ring_begin_use,
>   	.end_use = amdgpu_vcn_ring_end_use,
>   	.emit_wreg = vcn_v1_0_enc_ring_emit_wreg,
>   	.emit_reg_wait = vcn_v1_0_enc_ring_emit_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h
> index 2a497a7a4840..f67d7391fc21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h
> @@ -24,6 +24,8 @@
>   #ifndef __VCN_V1_0_H__
>   #define __VCN_V1_0_H__
>   
> +void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring);
> +
>   extern const struct amdgpu_ip_block_version vcn_v1_0_ip_block;
>   
>   #endif
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
