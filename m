Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF20C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 11:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4024820663
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 11:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NrL8Ql5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4024820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A356C6E05D;
	Tue, 10 Dec 2019 11:28:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED9B6E05D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 11:28:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ys/AwZ1Is9VVI/hVaVGyw8aloLAPp8xVddu+I6TKwaiIjzhxV8Kbf48LjH6owGD8pY3xthyVcOPnTvTUonlCaVSRjwc2hfXKwm0aRLGujRArxW60wipfLj+PP9eAgDE6BYlDperfM99r4lGovb40AW3WZwbR5p+suSwrPCJ+ws85hjLUwFY+gJqpqsdaEG/nVh4YM9cxgu2LkyQB1PUDCD/QEM6hjzXw3i56jhjX9DJgb8vSA/Vju+RQkkV/4EjgenOOEpJKBdQl3CQ23Q5/RPoUaqdkLYYj7+A5ZG/sGmC1xx+4rZPq1gQvBwh0ozxkgJXv70p0+R5BhjCi35nvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDFPVBdK3qWPo/czO8c4orOFMEO6jtXKd+dnyEN4aAA=;
 b=JStRpNQOY3IJCwi7hHCHOWrw6aaHCV73Gp798LyaLB6YiWTdYPHpbHhXLXnsbGU+6wGzp8RAf/G8iUWp+808cIHnK5sKtDQwVXdtee/9OuZcCN7rulBHbCcqSKxSOaNw1DnpfzslHePYeJ99Jl2NbX6EuKbXgZP5KWob/Hk1gRw2K5iGAhYlpEGABv3uOYapS1zu1hndYYpA7tuTcnJHr8fgk868qACRsZQCVQl7Ucg4UmgkESxouFoCMHmoLr4f+dfMNHpBjilixvfX+K7b2rvDb9/rsu7blQK8B8vzYIPqh6baH//LZQdA3l+vhJCtlTUBg746XgZQv8NQkBIKew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDFPVBdK3qWPo/czO8c4orOFMEO6jtXKd+dnyEN4aAA=;
 b=NrL8Ql5C9Ish/Qr2BtO6WUt5vPhgm9rwX8PXxz1TUAAXWvYQ/KaRj5RcxuE57q5hxu4ZkU9Pq9nxUKyGWfDKpqnkpSI7r0WaySxRsuSf0/+xBSUQmLVOr3fSjLBvJgr/bqDyREQLJtWAS+V2hT7xZtzr43ZHUd27OYHi3R3ex08=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2552.namprd12.prod.outlook.com (52.132.141.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Tue, 10 Dec 2019 11:28:37 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 11:28:37 +0000
Subject: Re: [PATCH 3/4] amd/amdgpu: add sched list to IPs with multiple
 run-queues
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, alexander.deucher@amd.com,
 kenny.ho@amd.com
References: <20191209215349.26994-1-nirmoy.das@amd.com>
 <20191209215349.26994-3-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f3af0e66-ed90-4d2c-9e7c-45441e7bc0d2@amd.com>
Date: Tue, 10 Dec 2019 12:28:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191209215349.26994-3-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0074.eurprd02.prod.outlook.com
 (2603:10a6:208:154::15) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7910eb6b-2894-491c-32a8-08d77d641963
X-MS-TrafficTypeDiagnostic: DM5PR12MB2552:|DM5PR12MB2552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB255221DB4F43A9BE76F53C70835B0@DM5PR12MB2552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(8936002)(31696002)(6486002)(478600001)(86362001)(66946007)(2906002)(6512007)(31686004)(81166006)(66556008)(8676002)(81156014)(6506007)(6666004)(36756003)(5660300002)(2616005)(316002)(4326008)(6636002)(52116002)(186003)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2552;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUN15VXFowODit27hSwdjHxc9egsQan2gXRRbs9BRBJ/0KRhZTrm6Q9DGAz5vNIX+zX4RFOSRFdlce0x0o88IHTY6RasA/phs/qk6AO9qf5YvMnMnc8puLftgHzwwl+8LchMCZw/8Mzl9fDdwo4LeTOqq7JKoWvPW8KyeCYGTFxtFvrD+fT9wDx7Vz3De7pDmG57ErKlYy+0u4+h+Xr0RJ+owqbuHGf2o8ccfD2tcmAc6SatoZzcZiomnLV8z3EoQNBmZ0rU19PySy6mkQ3kdW0JGjF+qeuHTD7Ss1IGdYOnfm/+UHs5XrDhHykEXlOammA0wYeH2o9VS2jE1e9Jh+3Hc8tCxOdhCBT1uQ0JIkrwth0IBI8FBSuqMxpaDelTRODu0LY78OWTOSM7mQBDvdkEDT/4TyS8EhxCVXDcou98czgHNfZrILUZns2lHnVC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7910eb6b-2894-491c-32a8-08d77d641963
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 11:28:37.4496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfMQNgrT2ijV1H6yPu3D+uNyC9O9zKOJWygf4yfaR+iPfxdS+SPGN58K7F9PTk4i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2552
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.12.19 um 22:53 schrieb Nirmoy Das:
> This sched list can be passed on to entity creation routine
> instead of manually creating such sched list on every context creation.

Please drop the "_list" from the names here. A list usually means a 
linked list and those are actually arrays.

Additional to that amdgpu_device_init_sched_list() should probably go 
into amdgpu_ctx.c instead. That is actually not really device related, 
but more UAPI/ctx stuff.

Apart from that looks good to me,
Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 69 ++++++++--------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  4 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h   |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h    |  9 ++-
>   6 files changed, 85 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 1d6850af9908..c1fc75299b7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -74,7 +74,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>   			   struct amdgpu_ctx *ctx)
>   {
>   	unsigned num_entities = amdgpu_ctx_total_num_entities();
> -	unsigned i, j, k;
> +	unsigned i, j;
>   	int r;
>   
>   	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
> @@ -121,73 +121,56 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>   	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
>   
>   	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -		struct amdgpu_ring *rings[AMDGPU_MAX_RINGS];
> -		struct drm_gpu_scheduler *sched_list[AMDGPU_MAX_RINGS];
> -		unsigned num_rings = 0;
> -		unsigned num_rqs = 0;
> +		struct drm_gpu_scheduler **sched_list;
> +		struct drm_gpu_scheduler *sched;
> +		unsigned num_scheds = 0;
>   
>   		switch (i) {
>   		case AMDGPU_HW_IP_GFX:
> -			rings[0] = &adev->gfx.gfx_ring[0];
> -			num_rings = 1;
> +			sched_list = adev->gfx.gfx_sched_list;
> +			num_scheds = 1;
>   			break;
>   		case AMDGPU_HW_IP_COMPUTE:
> -			for (j = 0; j < adev->gfx.num_compute_rings; ++j)
> -				rings[j] = &adev->gfx.compute_ring[j];
> -			num_rings = adev->gfx.num_compute_rings;
> +			sched_list = adev->gfx.compute_sched_list;
> +			num_scheds = adev->gfx.num_compute_rings;
>   			break;
>   		case AMDGPU_HW_IP_DMA:
> -			for (j = 0; j < adev->sdma.num_instances; ++j)
> -				rings[j] = &adev->sdma.instance[j].ring;
> -			num_rings = adev->sdma.num_instances;
> +			sched_list = adev->sdma.sdma_sched_list;
> +			num_scheds = adev->sdma.num_instances;
>   			break;
>   		case AMDGPU_HW_IP_UVD:
> -			rings[0] = &adev->uvd.inst[0].ring;
> -			num_rings = 1;
> +			sched = &adev->uvd.inst[0].ring.sched;
> +			sched_list = &sched;
> +			num_scheds = 1;
>   			break;
>   		case AMDGPU_HW_IP_VCE:
> -			rings[0] = &adev->vce.ring[0];
> -			num_rings = 1;
> +			sched = &adev->vce.ring[0].sched;
> +			sched_list = &sched;
> +			num_scheds = 1;
>   			break;
>   		case AMDGPU_HW_IP_UVD_ENC:
> -			rings[0] = &adev->uvd.inst[0].ring_enc[0];
> -			num_rings = 1;
> +			sched = &adev->uvd.inst[0].ring_enc[0].sched;
> +			sched_list = &sched;
> +			num_scheds = 1;
>   			break;
>   		case AMDGPU_HW_IP_VCN_DEC:
> -			for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
> -				if (adev->vcn.harvest_config & (1 << j))
> -					continue;
> -				rings[num_rings++] = &adev->vcn.inst[j].ring_dec;
> -			}
> +			sched_list = adev->vcn.vcn_dec_sched_list;
> +			num_scheds =  adev->vcn.num_vcn_dec_sched_list;
>   			break;
>   		case AMDGPU_HW_IP_VCN_ENC:
> -			for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
> -				if (adev->vcn.harvest_config & (1 << j))
> -					continue;
> -				for (k = 0; k < adev->vcn.num_enc_rings; ++k)
> -					rings[num_rings++] = &adev->vcn.inst[j].ring_enc[k];
> -			}
> +			sched_list = adev->vcn.vcn_enc_sched_list;
> +			num_scheds =  adev->vcn.num_vcn_enc_sched_list;
>   			break;
>   		case AMDGPU_HW_IP_VCN_JPEG:
> -			for (j = 0; j < adev->jpeg.num_jpeg_inst; ++j) {
> -				if (adev->vcn.harvest_config & (1 << j))
> -					continue;
> -				rings[num_rings++] = &adev->jpeg.inst[j].ring_dec;
> -			}
> +			sched_list = adev->jpeg.jpeg_sched_list;
> +			num_scheds =  adev->jpeg.num_jpeg_sched_list;
>   			break;
>   		}
>   
> -		for (j = 0; j < num_rings; ++j) {
> -			if (!rings[j]->adev)
> -				continue;
> -
> -			sched_list[num_rqs++] = &rings[j]->sched;
> -		}
> -
>   		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
>   			r = drm_sched_entity_init(&ctx->entities[i][j].entity,
>   						  priority, sched_list,
> -						  num_rqs, &ctx->guilty);
> +						  num_scheds, &ctx->guilty);
>   		if (r)
>   			goto error_cleanup_entities;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index cf4953c4e2cf..f973b61a26da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2738,6 +2738,48 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>   	return ret;
>   }
>   
> +static void amdgpu_device_init_sched_list(struct amdgpu_device *adev)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +		adev->gfx.gfx_sched_list[i] = &adev->gfx.gfx_ring[i].sched;
> +		adev->gfx.num_gfx_sched_list++;
> +	}
> +
> +	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +		adev->gfx.compute_sched_list[i] = &adev->gfx.compute_ring[i].sched;
> +		adev->gfx.num_compute_sched_list++;
> +	}
> +
> +	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		adev->sdma.sdma_sched_list[i] = &adev->sdma.instance[i].ring.sched;
> +		adev->sdma.num_sdma_sched_list++;
> +	}
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		adev->vcn.vcn_dec_sched_list[adev->vcn.num_vcn_dec_sched_list++] =
> +			&adev->vcn.inst[i].ring_dec.sched;
> +	}
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		for (j = 0; j < adev->vcn.num_enc_rings; ++j)
> +			adev->vcn.vcn_enc_sched_list[adev->vcn.num_vcn_enc_sched_list++] =
> +				&adev->vcn.inst[i].ring_enc[j].sched;
> +	}
> +
> +	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		adev->jpeg.jpeg_sched_list[adev->jpeg.num_jpeg_sched_list++] =
> +			&adev->jpeg.inst[i].ring_dec.sched;
> +	}
> +}
> +
>   /**
>    * amdgpu_device_init - initialize the driver
>    *
> @@ -3024,6 +3066,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		goto failed;
>   	}
>   
> +	amdgpu_device_init_sched_list(adev);
> +
>   	adev->accel_working = true;
>   
>   	amdgpu_vm_check_compute_bug(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 0ae0a2715b0d..b2264d4cd510 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -269,8 +269,12 @@ struct amdgpu_gfx {
>   	bool				me_fw_write_wait;
>   	bool				cp_fw_write_wait;
>   	struct amdgpu_ring		gfx_ring[AMDGPU_MAX_GFX_RINGS];
> +	struct drm_gpu_scheduler	*gfx_sched_list[AMDGPU_MAX_GFX_RINGS];
> +	uint32_t			num_gfx_sched_list;
>   	unsigned			num_gfx_rings;
>   	struct amdgpu_ring		compute_ring[AMDGPU_MAX_COMPUTE_RINGS];
> +	uint32_t			num_compute_sched_list;
> +	struct drm_gpu_scheduler	*compute_sched_list[AMDGPU_MAX_COMPUTE_RINGS];
>   	unsigned			num_compute_rings;
>   	struct amdgpu_irq_src		eop_irq;
>   	struct amdgpu_irq_src		priv_reg_irq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> index 5131a0a1bc8a..5ce6ab05eeac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> @@ -43,6 +43,8 @@ struct amdgpu_jpeg {
>   	uint8_t	num_jpeg_inst;
>   	struct amdgpu_jpeg_inst inst[AMDGPU_MAX_JPEG_INSTANCES];
>   	struct amdgpu_jpeg_reg internal;
> +	struct drm_gpu_scheduler *jpeg_sched_list[AMDGPU_MAX_JPEG_INSTANCES];
> +	uint32_t num_jpeg_sched_list;
>   	unsigned harvest_config;
>   	struct delayed_work idle_work;
>   	enum amd_powergating_state cur_state;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index b3134655789f..0f6cb6768398 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -52,6 +52,8 @@ struct amdgpu_sdma_instance {
>   
>   struct amdgpu_sdma {
>   	struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
> +	struct drm_gpu_scheduler    *sdma_sched_list[AMDGPU_MAX_SDMA_INSTANCES];
> +	uint32_t		    num_sdma_sched_list;
>   	struct amdgpu_irq_src	trap_irq;
>   	struct amdgpu_irq_src	illegal_inst_irq;
>   	struct amdgpu_irq_src	ecc_irq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 402a5046b985..ae65cb8f07e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -31,6 +31,7 @@
>   #define AMDGPU_VCN_MAX_ENC_RINGS	3
>   
>   #define AMDGPU_MAX_VCN_INSTANCES	2
> +#define AMDGPU_MAX_VCN_ENC_RINGS  AMDGPU_VCN_MAX_ENC_RINGS * AMDGPU_MAX_VCN_INSTANCES
>   
>   #define AMDGPU_VCN_HARVEST_VCN0 (1 << 0)
>   #define AMDGPU_VCN_HARVEST_VCN1 (1 << 1)
> @@ -186,8 +187,12 @@ struct amdgpu_vcn {
>   	uint32_t		*dpg_sram_curr_addr;
>   
>   	uint8_t	num_vcn_inst;
> -	struct amdgpu_vcn_inst	inst[AMDGPU_MAX_VCN_INSTANCES];
> -	struct amdgpu_vcn_reg	internal;
> +	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
> +	struct amdgpu_vcn_reg	 internal;
> +	struct drm_gpu_scheduler *vcn_enc_sched_list[AMDGPU_MAX_VCN_ENC_RINGS];
> +	struct drm_gpu_scheduler *vcn_dec_sched_list[AMDGPU_MAX_VCN_INSTANCES];
> +	uint32_t		 num_vcn_enc_sched_list;
> +	uint32_t		 num_vcn_dec_sched_list;
>   
>   	unsigned	harvest_config;
>   	int (*pause_dpg_mode)(struct amdgpu_device *adev,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
