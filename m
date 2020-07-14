Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39900C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 15:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC55F20663
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 15:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3bCDaleA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC55F20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E02A6E996;
	Tue, 14 Jul 2020 15:07:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 917F86E996
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 15:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhO68pOeEbKBtVeYRaVqzgtdhtMbrWYWCsV3XnBCj9USi6IcdE2fKy755PS4AdWbOhFovQJ+PAiqTm0aqpwT9v19/9vKAKo8O+nLTs5Bhn0b1GW6aarJC/S5SFdmfBF5L1BawoAOGGpK0RNrKq0WINLMA7Nk1QMfZ6p1KRjAxtENt6bxlLp1dTM9XOMQzfihkEL4CTrgoirRq/fJKVHs7rdK7WMJ1Lpe/VQr0LLeMsSHPa5MQo3aM6KRH1HQKgjSFq0fdI1hMbGFqt81PoUE3KGF9q8IYEwlwBN55WHoPAe51IyYzTMkuJCWO2GOvUFKTrZayfHgeuv8i1qr9mBQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlaDXQo0bjR3stk9ThwzJBRGEivGFs/ZRl+kcEqH2oA=;
 b=iU8uU+HYysMi5TJT3YgWNo0tA2O5hMyqdgE1wxPTCcNxX3GbeHTEXX2VJxydlsCCAO30rJkMK7HbMDYGe5W1PGVHdTGfo87oDqZ8q5KftXBgPgHkFaZeXBSyqJtyXPYqiMT8wEduK/hY7BZLujjfj6Xnbw98o57v3lqba0WqxO7CPjXiiCZ8GzLOrlEzt/XHoV4xgX5LOiq2eh1aD/SDfMH4unKSiNTwxIL8PCW4SUPfHt5GLU3X6dlKqiDHKT+wK18SNfFC3f0cSv5jn7ap1R7kiLNxIkVurRuCpcxFEi5083urUOD8k9+hQWdMjlBDypME85jxBVHjS8c0m/QIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlaDXQo0bjR3stk9ThwzJBRGEivGFs/ZRl+kcEqH2oA=;
 b=3bCDaleAIbU7q4mViaTN/NaZ2K2qCOJ1BbszQcTUY01A4TzxSvUph8UA9pEaQCuypNQTb3973SWyqvToE1ZkSJ5wpWgulwODogPvmPgqQC5uMJeycx9Bernu4Ymv3kOMLKmViwVjj9wqZnBqQNc4mzGEkAo338Qdre9m4aAfzm8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 15:06:59 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::f4f8:d7fb:5d5d:e4e6]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::f4f8:d7fb:5d5d:e4e6%4]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 15:06:58 +0000
Subject: Re: [PATCH 4/5] drm/amd/sriov porting sriov cap to vcn3.0
To: Jack Zhang <Jack.Zhang1@amd.com>, amd-gfx@lists.freedesktop.org
References: <1594694821-7747-1-git-send-email-Jack.Zhang1@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <1323638e-a404-308a-39d3-2c8925ebba80@amd.com>
Date: Tue, 14 Jul 2020 11:06:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594694821-7747-1-git-send-email-Jack.Zhang1@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::8) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:a3c0:203:107c:af05:3460:3e70]
 (2607:fea8:a3c0:203:107c:af05:3460:3e70) by
 YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 15:06:58 +0000
X-Originating-IP: [2607:fea8:a3c0:203:107c:af05:3460:3e70]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ff55b3c-c8c1-4355-4b27-08d828078de4
X-MS-TrafficTypeDiagnostic: DM6PR12MB2844:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28449FD371900A0B9FCC93ABE5610@DM6PR12MB2844.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUeySavSg1UAx/7+4r2ZFiU4I2rISNaz+g6pCpa/WUCGaa+R2etnBlLsU3YA0bm5QgYIiDxL/Chuoc0ACOTkFr3NHmiDb8HhqRLCOZIMK8IwCY+cLhiLEjABLIEOA9C+rdH/Vu5g5VjEMLzUhkA8o0z0fRigg7IPSj5Hx0R2IfG9nC+IXSYMGLgYB2PkSC3LbWmwlmUYoxuVb2kmL1YsFqHAkMx29gvc77MkCoQdPdP1Huo2m1RIncf8DCbNf8BYsQI3vEHk5XxUKnPIC0+tgxPoa1AFg7scn4m3uanA7IzU/qe2jQUOJWXOmDPL12HH4E8tsjTTmihrngoQn9msxC7NL0ymIwazO0rrfWY2s75t314labL8k2xIHvaeZFsN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(83380400001)(53546011)(30864003)(31686004)(2906002)(5660300002)(6486002)(31696002)(44832011)(8936002)(86362001)(8676002)(2616005)(52116002)(478600001)(186003)(16526019)(4326008)(66476007)(66946007)(316002)(66556008)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pXyM/oIwM32hORYZRLgIv7w47JFe6AUO/uA0dV+hX8B7tJM5TSrIZNH4DQAyKll/8C7PTe098zVozkISim6XAv1EE97ZIfxh5Dzrn2XWcbq+m1+9SJHHVJSj5fAd9Y6V6oVnD5IksqOSoVbdlphzTQGYxpZWhZ/5O90+gQH1VVAYPJtZlQMyYiiMpGE/mbiS8FKJRWohIV8yXBnBxCb82rLBfRIhN8JZIEy/vNsS/6y71ixZZyFnNX4PahktHzEUMba3h3XoXrwQH1auijJPaXham6TGh21T1MvEOYB1TRmt4wakaxqHTLw8Ph7ejowQjRYM4mTDAAn0vVqIF4tBfW/zDtzA2YA/zzPTukf9cUcL7kCl7VSrUd2uf90x9VRiy9cCzNzncdlaqx+FdJKIBG/mDARySMZtGFSwKfgxWDM1DQ7KpKwh8q2JxNjThe5DLNCQYC5RxJiGwQ7a+A/v4KmBCEBuqMw7OzawcDM3NcpZ+DDeD93nBummbNd3qVLJ/V7iZnslvTZN3TuODM67GBI58w5ncH0N6yak4i9wsLxfT6ORAWc+V70z0inhz98X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff55b3c-c8c1-4355-4b27-08d828078de4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 15:06:58.7774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hnXb/ecc4Wvu/vcTY5AA09dpt3wNM5ieScul4GafsxdcaSsJXqSY7U/xzq1zOY8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2844
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
Cc: Hawking.Zhang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is:

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2020-07-13 10:47 p.m., Jack Zhang wrote:
> 1.In early_init and for sriov, hardcode
>    harvest_config=0, enc_num=1
>
> 2.sw_init/fini
>    alloc & free mm_table for sriov
>    doorbell setting for sriov
>
> 3.hw_init/fini
>    Under sriov, add start_sriov to config mmsch
>    Skip ring_test to avoid mmio in VF, but need to initialize wptr for vcn rings.
>
> 4.Implementation for vcn_v3_0_start_sriov
>
> V2:Clean-up some uneccessary funciton declaration.
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 350 +++++++++++++++++++++++---
>   1 file changed, 318 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 90fe95f345e3..0a0ca10bf55b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -28,6 +28,7 @@
>   #include "soc15.h"
>   #include "soc15d.h"
>   #include "vcn_v2_0.h"
> +#include "mmsch_v3_0.h"
>   
>   #include "vcn/vcn_3_0_0_offset.h"
>   #include "vcn/vcn_3_0_0_sh_mask.h"
> @@ -48,6 +49,17 @@
>   
>   #define VCN_INSTANCES_SIENNA_CICHLID	 				2
>   
> +static int amdgpu_ih_clientid_vcns[] = {
> +	SOC15_IH_CLIENTID_VCN,
> +	SOC15_IH_CLIENTID_VCN1
> +};
> +
> +static int amdgpu_ucode_id_vcns[] = {
> +       AMDGPU_UCODE_ID_VCN,
> +       AMDGPU_UCODE_ID_VCN1
> +};
> +
> +static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
>   static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
> @@ -56,10 +68,8 @@ static int vcn_v3_0_set_powergating_state(void *handle,
>   static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>   			int inst_idx, struct dpg_pause_state *new_state);
>   
> -static int amdgpu_ih_clientid_vcns[] = {
> -	SOC15_IH_CLIENTID_VCN,
> -	SOC15_IH_CLIENTID_VCN1
> -};
> +static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
> +static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
>   
>   /**
>    * vcn_v3_0_early_init - set function pointers
> @@ -71,25 +81,33 @@ static int amdgpu_ih_clientid_vcns[] = {
>   static int vcn_v3_0_early_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	if (adev->asic_type == CHIP_SIENNA_CICHLID) {
> -		u32 harvest;
> -		int i;
>   
> +	if (amdgpu_sriov_vf(adev)) {
>   		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
> -		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -			harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
> -			if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
> -				adev->vcn.harvest_config |= 1 << i;
> -		}
> +		adev->vcn.harvest_config = 0;
> +		adev->vcn.num_enc_rings = 1;
>   
> -		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
> -			 AMDGPU_VCN_HARVEST_VCN1))
> -			/* both instances are harvested, disable the block */
> -			return -ENOENT;
> -	} else
> -		adev->vcn.num_vcn_inst = 1;
> +	} else {
> +		if (adev->asic_type == CHIP_SIENNA_CICHLID) {
> +			u32 harvest;
> +			int i;
> +
> +			adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
> +			for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +				harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
> +				if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
> +					adev->vcn.harvest_config |= 1 << i;
> +			}
>   
> -	adev->vcn.num_enc_rings = 2;
> +			if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
> +						AMDGPU_VCN_HARVEST_VCN1))
> +				/* both instances are harvested, disable the block */
> +				return -ENOENT;
> +		} else
> +			adev->vcn.num_vcn_inst = 1;
> +
> +		adev->vcn.num_enc_rings = 2;
> +	}
>   
>   	vcn_v3_0_set_dec_ring_funcs(adev);
>   	vcn_v3_0_set_enc_ring_funcs(adev);
> @@ -109,6 +127,7 @@ static int vcn_v3_0_sw_init(void *handle)
>   {
>   	struct amdgpu_ring *ring;
>   	int i, j, r;
> +	int vcn_doorbell_index = 0;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
>   	r = amdgpu_vcn_sw_init(adev);
> @@ -136,6 +155,12 @@ static int vcn_v3_0_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> +	if (amdgpu_sriov_vf(adev)) {
> +		vcn_doorbell_index = adev->doorbell_index.vcn.vcn_ring0_1;
> +		/* get DWORD offset */
> +		vcn_doorbell_index = vcn_doorbell_index << 1;
> +	}
> +
>   	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
> @@ -166,7 +191,13 @@ static int vcn_v3_0_sw_init(void *handle)
>   
>   		ring = &adev->vcn.inst[i].ring_dec;
>   		ring->use_doorbell = true;
> -		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
> +		if (amdgpu_sriov_vf(adev)) {
> +			ring->doorbell_index = vcn_doorbell_index;
> +			/* NOTE: increment so next VCN engine use next DOORBELL DWORD */
> +			vcn_doorbell_index++;
> +		} else {
> +			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
> +		}
>   		if (i != 0)
>   			ring->no_scheduler = true;
>   		sprintf(ring->name, "vcn_dec_%d", i);
> @@ -184,7 +215,13 @@ static int vcn_v3_0_sw_init(void *handle)
>   
>   			ring = &adev->vcn.inst[i].ring_enc[j];
>   			ring->use_doorbell = true;
> -			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
> +			if (amdgpu_sriov_vf(adev)) {
> +				ring->doorbell_index = vcn_doorbell_index;
> +				/* NOTE: increment so next VCN engine use next DOORBELL DWORD */
> +				vcn_doorbell_index++;
> +			} else {
> +				ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
> +			}
>   			if (i != 1)
>   				ring->no_scheduler = true;
>   			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
> @@ -195,6 +232,11 @@ static int vcn_v3_0_sw_init(void *handle)
>   		}
>   	}
>   
> +	if (amdgpu_sriov_vf(adev)) {
> +		r = amdgpu_virt_alloc_mm_table(adev);
> +		if (r)
> +			return r;
> +	}
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>   		adev->vcn.pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
>   
> @@ -213,6 +255,9 @@ static int vcn_v3_0_sw_fini(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int r;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		amdgpu_virt_free_mm_table(adev);
> +
>   	r = amdgpu_vcn_suspend(adev);
>   	if (r)
>   		return r;
> @@ -235,24 +280,50 @@ static int vcn_v3_0_hw_init(void *handle)
>   	struct amdgpu_ring *ring;
>   	int i, j, r;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (amdgpu_sriov_vf(adev)) {
> +		r = vcn_v3_0_start_sriov(adev);
> +		if (r)
> +			goto done;
>   
> -		ring = &adev->vcn.inst[i].ring_dec;
> +		/* initialize VCN dec and enc ring buffers */
> +		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
> +
> +			ring = &adev->vcn.inst[i].ring_dec;
> +			ring->wptr = 0;
> +			ring->wptr_old = 0;
> +			vcn_v3_0_dec_ring_set_wptr(ring);
> +			ring->sched.ready = true;
> +
> +			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +				ring = &adev->vcn.inst[i].ring_enc[j];
> +				ring->wptr = 0;
> +				ring->wptr_old = 0;
> +				vcn_v3_0_enc_ring_set_wptr(ring);
> +				ring->sched.ready = true;
> +			}
> +		}
> +	} else {
> +		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
>   
> -		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> -						     ring->doorbell_index, i);
> +			ring = &adev->vcn.inst[i].ring_dec;
>   
> -		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> -			goto done;
> +			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> +						     ring->doorbell_index, i);
>   
> -		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> -			ring = &adev->vcn.inst[i].ring_enc[j];
>   			r = amdgpu_ring_test_helper(ring);
>   			if (r)
>   				goto done;
> +
> +			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +				ring = &adev->vcn.inst[i].ring_enc[j];
> +				r = amdgpu_ring_test_helper(ring);
> +				if (r)
> +					goto done;
> +			}
>   		}
>   	}
>   
> @@ -1137,6 +1208,221 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
> +{
> +	int i, j;
> +	struct amdgpu_ring *ring;
> +	uint64_t cache_addr;
> +	uint64_t rb_addr;
> +	uint64_t ctx_addr;
> +	uint32_t param, resp, expected;
> +	uint32_t offset, cache_size;
> +	uint32_t tmp, timeout;
> +	uint32_t id;
> +
> +	struct amdgpu_mm_table *table = &adev->virt.mm_table;
> +	uint32_t *table_loc;
> +	uint32_t table_size;
> +	uint32_t size, size_dw;
> +
> +	struct mmsch_v3_0_cmd_direct_write
> +		direct_wt = { {0} };
> +	struct mmsch_v3_0_cmd_direct_read_modify_write
> +		direct_rd_mod_wt = { {0} };
> +	struct mmsch_v3_0_cmd_direct_polling
> +		direct_poll = { {0} };
> +	struct mmsch_v3_0_cmd_end end = { {0} };
> +	struct mmsch_v3_0_init_header header;
> +
> +	direct_wt.cmd_header.command_type =
> +		MMSCH_COMMAND__DIRECT_REG_WRITE;
> +	direct_rd_mod_wt.cmd_header.command_type =
> +		MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
> +	direct_poll.cmd_header.command_type =
> +		MMSCH_COMMAND__DIRECT_REG_POLLING;
> +	end.cmd_header.command_type =
> +		MMSCH_COMMAND__END;
> +
> +	header.version = MMSCH_VERSION;
> +	header.total_size = sizeof(struct mmsch_v3_0_init_header) >> 2;
> +	for (i = 0; i < AMDGPU_MAX_VCN_INSTANCES; i++) {
> +		header.inst[i].init_status = 0;
> +		header.inst[i].table_offset = 0;
> +		header.inst[i].table_size = 0;
> +	}
> +
> +	table_loc = (uint32_t *)table->cpu_addr;
> +	table_loc += header.total_size;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
> +		table_size = 0;
> +
> +		MMSCH_V3_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(VCN, i,
> +			mmUVD_STATUS),
> +			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
> +
> +		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
> +
> +		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> +			id = amdgpu_ucode_id_vcns[i];
> +			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +				mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +				adev->firmware.ucode[id].tmr_mc_addr_lo);
> +			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +				mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
> +				adev->firmware.ucode[id].tmr_mc_addr_hi);
> +			offset = 0;
> +			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +				mmUVD_VCPU_CACHE_OFFSET0),
> +				0);
> +		} else {
> +			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +				mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +				lower_32_bits(adev->vcn.inst[i].gpu_addr));
> +			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +				mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
> +				upper_32_bits(adev->vcn.inst[i].gpu_addr));
> +			offset = cache_size;
> +			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +				mmUVD_VCPU_CACHE_OFFSET0),
> +				AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
> +		}
> +
> +		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +			mmUVD_VCPU_CACHE_SIZE0),
> +			cache_size);
> +
> +		cache_addr = adev->vcn.inst[i].gpu_addr + offset;
> +		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +			mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
> +			lower_32_bits(cache_addr));
> +		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +			mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
> +			upper_32_bits(cache_addr));
> +		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +			mmUVD_VCPU_CACHE_OFFSET1),
> +			0);
> +		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +			mmUVD_VCPU_CACHE_SIZE1),
> +			AMDGPU_VCN_STACK_SIZE);
> +
> +		cache_addr = adev->vcn.inst[i].gpu_addr + offset +
> +			AMDGPU_VCN_STACK_SIZE;
> +		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +			mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
> +			lower_32_bits(cache_addr));
> +		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +			mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
> +			upper_32_bits(cache_addr));
> +		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +			mmUVD_VCPU_CACHE_OFFSET2),
> +			0);
> +		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +			mmUVD_VCPU_CACHE_SIZE2),
> +			AMDGPU_VCN_CONTEXT_SIZE);
> +
> +		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +			ring = &adev->vcn.inst[i].ring_enc[j];
> +			ring->wptr = 0;
> +			rb_addr = ring->gpu_addr;
> +			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +				mmUVD_RB_BASE_LO),
> +				lower_32_bits(rb_addr));
> +			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +				mmUVD_RB_BASE_HI),
> +				upper_32_bits(rb_addr));
> +			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +				mmUVD_RB_SIZE),
> +				ring->ring_size / 4);
> +		}
> +
> +		ring = &adev->vcn.inst[i].ring_dec;
> +		ring->wptr = 0;
> +		rb_addr = ring->gpu_addr;
> +		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +			mmUVD_LMI_RBC_RB_64BIT_BAR_LOW),
> +			lower_32_bits(rb_addr));
> +		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +			mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH),
> +			upper_32_bits(rb_addr));
> +		/* force RBC into idle state */
> +		tmp = order_base_2(ring->ring_size);
> +		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, tmp);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> +		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> +		MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> +			mmUVD_RBC_RB_CNTL),
> +			tmp);
> +
> +		/* add end packet */
> +		MMSCH_V3_0_INSERT_END();
> +
> +		/* refine header */
> +		header.inst[i].init_status = 1;
> +		header.inst[i].table_offset = header.total_size;
> +		header.inst[i].table_size = table_size;
> +		header.total_size += table_size;
> +	}
> +
> +	/* Update init table header in memory */
> +        size = sizeof(struct mmsch_v3_0_init_header);
> +	table_loc = (uint32_t *)table->cpu_addr;
> +	memcpy((void *)table_loc, &header, size);
> +
> +	/* message MMSCH (in VCN[0]) to initialize this client
> +	 * 1, write to mmsch_vf_ctx_addr_lo/hi register with GPU mc addr
> +	 * of memory descriptor location
> +	 */
> +	ctx_addr = table->gpu_addr;
> +	WREG32_SOC15(VCN, 0, mmMMSCH_VF_CTX_ADDR_LO, lower_32_bits(ctx_addr));
> +	WREG32_SOC15(VCN, 0, mmMMSCH_VF_CTX_ADDR_HI, upper_32_bits(ctx_addr));
> +
> +	/* 2, update vmid of descriptor */
> +	tmp = RREG32_SOC15(VCN, 0, mmMMSCH_VF_VMID);
> +	tmp &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
> +	/* use domain0 for MM scheduler */
> +	tmp |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
> +	WREG32_SOC15(VCN, 0, mmMMSCH_VF_VMID, tmp);
> +
> +	/* 3, notify mmsch about the size of this descriptor */
> +	size = header.total_size;
> +	WREG32_SOC15(VCN, 0, mmMMSCH_VF_CTX_SIZE, size);
> +
> +	/* 4, set resp to zero */
> +	WREG32_SOC15(VCN, 0, mmMMSCH_VF_MAILBOX_RESP, 0);
> +
> +	/* 5, kick off the initialization and wait until
> +	 * MMSCH_VF_MAILBOX_RESP becomes non-zero
> +	 */
> +	param = 0x10000001;
> +	WREG32_SOC15(VCN, 0, mmMMSCH_VF_MAILBOX_HOST, param);
> +	tmp = 0;
> +	timeout = 1000;
> +	resp = 0;
> +	expected = param + 1;
> +	while (resp != expected) {
> +		resp = RREG32_SOC15(VCN, 0, mmMMSCH_VF_MAILBOX_RESP);
> +		if (resp == expected)
> +			break;
> +
> +		udelay(10);
> +		tmp = tmp + 10;
> +		if (tmp >= timeout) {
> +			DRM_ERROR("failed to init MMSCH. TIME-OUT after %d usec"\
> +				" waiting for mmMMSCH_VF_MAILBOX_RESP "\
> +				"(expected=0x%08x, readback=0x%08x)\n",
> +				tmp, expected, resp);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>   {
>   	uint32_t tmp;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
