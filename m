Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A338C35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB5020659
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t+hzLquw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB5020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A70956E9B7;
	Wed,  5 Feb 2020 15:31:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C4F6E9B7
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 15:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhP91yUg3kie7EleQTuHKXqpDz/TUgcNvgsnpGVYwoUoZGyEMztQiT/kNVEsTseR1Ppy1mJ1NUL2w8R0sNcIMm7zQRKOYDsr06qFNazljIiw+/u/P5B+iaLGOjlMk04ENXaoIz5uOcmAgw3r/jie82Fwt8422oolFK02ajFyCu5KR6ppj3bJDxxppAKr8J2KLk2RI6FuyYgVezSDYAlDkVUxs0LDaT8gGR7xgONU+O6k2s01lnpKNnyIPX9XyAZ8NJrF4je/2nx2PrYiawXpkCmvyVnF9tv6ITjvfSYEq7mvOSHp6N3r8MIahe3Gt6NxbY0Fg+GbL2Z9BJH38Pjp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyKc+RJR9v12RGzwVXZI7dvfbsG2V9q37UF5YYXj6s0=;
 b=V438lEjOK5x2xWp0ACfqmdPiC7BJLw+f3kUqOZeYWZrsLOOfHaytQaAW5WnJwXbMkr443gHVyRqeJ3bDw/pYJTPmUfPmC8EEJ0IaoebrmLIwci6ABwfiii703EJ83ypgM88tPgTerycpSUCWfAADfCs91Xu8bBYPa79oIYGYQhtIOttETV8fyMtYtw9soM2WMySET69RkZ6kF93r97Mp2Xfk3zv4BztDGUB/udsEhyDblyWENaKJfd7WjcSzNJxiFX73N8z2rWfZAK62LbmnZVfEd+paNmVtOm9VHnqZ743RAE/V4i6SqxD2w6GtCNLxHQu+HfMGhNZy+1tUkPNfCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyKc+RJR9v12RGzwVXZI7dvfbsG2V9q37UF5YYXj6s0=;
 b=t+hzLquwHj660GBbnRYFMlhSFyplg7jRYdudpFebmpGsoi1hgxXW5RHyeYtcIWz+CwIH2PL4bQAHDzODT2P20stKd/JBxLJO2iR7Y9TmrQpsqE5xcOsZNTkiE1wjSvTE+bcDu1Y4L0gC9HaQ7Oz+FNMtQg+ayYGq0chOvNcVtqI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB3196.namprd12.prod.outlook.com (20.179.105.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Wed, 5 Feb 2020 15:31:19 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2686.035; Wed, 5 Feb 2020
 15:31:19 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn2.5: fix DPG mode power off issue on
 instance 1
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1580913918-12026-1-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <1af7deae-3a1c-3c08-2417-d63d67d9e499@amd.com>
Date: Wed, 5 Feb 2020 10:31:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1580913918-12026-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::34) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YQBPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Wed, 5 Feb 2020 15:31:19 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ddc1f420-009b-48e5-b064-08d7aa5072ab
X-MS-TrafficTypeDiagnostic: DM6PR12MB3196:|DM6PR12MB3196:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB319604B40203F2117EEB3558E5020@DM6PR12MB3196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(189003)(199004)(44832011)(2616005)(956004)(6486002)(86362001)(16576012)(31696002)(8676002)(316002)(81166006)(2906002)(81156014)(8936002)(36916002)(52116002)(66556008)(36756003)(66476007)(66946007)(4326008)(5660300002)(31686004)(478600001)(53546011)(186003)(16526019)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3196;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/C2yhduWlmJE1j/b9AT2/F8AhKRkvawGfhn8wbwCcsV4vsw8RZrgOU/Yl1KPWvp1b0VZHICYBJv1kuDPu1cSJU1GOTOZlNXofqJZmN7UGn9BquCGTkarPfrV1jEE0TwcmwT08todYPhMmOCn86P6BqpSgYRx1x8Ai7RdY3b5Kvsbrd5WPcPPEA7InQHxrqmrEhtY5i8sjsqB3XQsC/wEi1qmRQ6wsBPeA1dqM40kYG4kj+u+ZSjEQbBVTXjsbSaeTrYRrFpWQi58WwTDeM7FuwfMVu4etJhIrmy6FUL5V1+xV6yxbcFL0OfFhQQg+QmN4aJfyciu50G0T263h1Bwe48AvjYOr5Gow7ohu8VQoKr9ysJe1LGi4Kd88ozWvAr5z4JO5VkKaEzHhnqqRR9qLYe9lhHzYvk7GNzqghnEJ0dY2yUk9XMyADrmm1qAhVc
X-MS-Exchange-AntiSpam-MessageData: XJ4m1MoRZbN7N/0qVkvxVwTrXCN5TY3KvG+Uj/AY6QQ9acuFUuij+k+prYap7tpcj8gUX6TMRfTtRJ7Tl9RBH06MWCVAVvubTkrMTKU+5NZw4UT6Ol6AJJs69TuSUkFYeiJSH/6h1uREqr/4wqTJSQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc1f420-009b-48e5-b064-08d7aa5072ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 15:31:19.7682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4mfCfcvYbup57j7+xh1HwjVIiq6jDmDSZdw17s/1PJ4NSg4ka5vvXgtlkMwIzhH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3196
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-02-05 9:45 a.m., James Zhu wrote:
> Support pause_state for multiple instance, and it will fix vcn2.5 DPG mode
> power off issue on instance 1.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +--
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 14 ++++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  6 +++---
>   4 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index d6deb0e..fb3dfe3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -179,6 +179,7 @@ struct amdgpu_vcn_inst {
>   	struct amdgpu_irq_src	irq;
>   	struct amdgpu_vcn_reg	external;
>   	struct amdgpu_bo	*dpg_sram_bo;
> +	struct dpg_pause_state pause_state;

Can this variable be aligned with other variables in the structure? With 
that fixed, the patch is

Reviewed-by: Leo Liu <leo.liu@amd.com>


>   	void			*dpg_sram_cpu_addr;
>   	uint64_t		dpg_sram_gpu_addr;
>   	uint32_t		*dpg_sram_curr_addr;
> @@ -190,8 +191,6 @@ struct amdgpu_vcn {
>   	const struct firmware	*fw;	/* VCN firmware */
>   	unsigned		num_enc_rings;
>   	enum amd_powergating_state cur_state;
> -	struct dpg_pause_state pause_state;
> -
>   	bool			indirect_sram;
>   
>   	uint8_t	num_vcn_inst;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 1a24fad..71f61af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1207,9 +1207,10 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
>   	struct amdgpu_ring *ring;
>   
>   	/* pause/unpause if state is changed */
> -	if (adev->vcn.pause_state.fw_based != new_state->fw_based) {
> +	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {
>   		DRM_DEBUG("dpg pause state changed %d:%d -> %d:%d",
> -			adev->vcn.pause_state.fw_based, adev->vcn.pause_state.jpeg,
> +			adev->vcn.inst[inst_idx].pause_state.fw_based,
> +			adev->vcn.inst[inst_idx].pause_state.jpeg,
>   			new_state->fw_based, new_state->jpeg);
>   
>   		reg_data = RREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE) &
> @@ -1258,13 +1259,14 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
>   			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
>   			WREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE, reg_data);
>   		}
> -		adev->vcn.pause_state.fw_based = new_state->fw_based;
> +		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
>   	}
>   
>   	/* pause/unpause if state is changed */
> -	if (adev->vcn.pause_state.jpeg != new_state->jpeg) {
> +	if (adev->vcn.inst[inst_idx].pause_state.jpeg != new_state->jpeg) {
>   		DRM_DEBUG("dpg pause state changed %d:%d -> %d:%d",
> -			adev->vcn.pause_state.fw_based, adev->vcn.pause_state.jpeg,
> +			adev->vcn.inst[inst_idx].pause_state.fw_based,
> +			adev->vcn.inst[inst_idx].pause_state.jpeg,
>   			new_state->fw_based, new_state->jpeg);
>   
>   		reg_data = RREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE) &
> @@ -1318,7 +1320,7 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
>   			reg_data &= ~UVD_DPG_PAUSE__JPEG_PAUSE_DPG_REQ_MASK;
>   			WREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE, reg_data);
>   		}
> -		adev->vcn.pause_state.jpeg = new_state->jpeg;
> +		adev->vcn.inst[inst_idx].pause_state.jpeg = new_state->jpeg;
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 4f72167..c387c81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -1137,9 +1137,9 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
>   	int ret_code;
>   
>   	/* pause/unpause if state is changed */
> -	if (adev->vcn.pause_state.fw_based != new_state->fw_based) {
> +	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {
>   		DRM_DEBUG("dpg pause state changed %d -> %d",
> -			adev->vcn.pause_state.fw_based,	new_state->fw_based);
> +			adev->vcn.inst[inst_idx].pause_state.fw_based,	new_state->fw_based);
>   		reg_data = RREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE) &
>   			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
>   
> @@ -1185,7 +1185,7 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
>   			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
>   			WREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE, reg_data);
>   		}
> -		adev->vcn.pause_state.fw_based = new_state->fw_based;
> +		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 70fae79..97ab44c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1367,9 +1367,9 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>   	int ret_code;
>   
>   	/* pause/unpause if state is changed */
> -	if (adev->vcn.pause_state.fw_based != new_state->fw_based) {
> +	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {
>   		DRM_DEBUG("dpg pause state changed %d -> %d",
> -			adev->vcn.pause_state.fw_based,	new_state->fw_based);
> +			adev->vcn.inst[inst_idx].pause_state.fw_based,	new_state->fw_based);
>   		reg_data = RREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE) &
>   			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
>   
> @@ -1414,7 +1414,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>   			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
>   			WREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE, reg_data);
>   		}
> -		adev->vcn.pause_state.fw_based = new_state->fw_based;
> +		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
>   	}
>   
>   	return 0;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
