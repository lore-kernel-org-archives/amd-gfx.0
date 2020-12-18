Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9D8C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 14:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F125023A9F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 14:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F125023A9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A13BE89E86;
	Fri, 18 Dec 2020 14:02:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F5889E86
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 14:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5s4FEMsw67OqAQg/Q9jIXmi3/afhwiE57nOt3iwYfSCqxUM/wdFri7VoTi4UP0+YrN5xrT/Ko5Dyo4rOQYBPz8Bi92Xsu5bx/1wZ+H3fCTTMTBE/MMm+XSi8ILocXKCfrt29jeWMshrkdVhgb4hov8OtVE1Fexa2/Kby0qw/oTpGG5lG5b2W8FNk/CtKwqX5xgPYgTkdkff47YXJ6hp8yVRM4ZNSQ+hA9kmvvtIK8vyMkjSKpzz1DKOBiNZQl/xeDd0hJVlJUd3UaTK3JV1D0iXD6cNUb+ZMX9qKEZG2pbvZdFWuNZPymxmFVdiIqHRWp9oskKd3l9k8J578muUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHf/uRaV/IKwbohowr4pyhIMuscsIAey9zyYeM0L1Cg=;
 b=OASGD7h6tlMQv/zrR/fkai3f9lN87/rf1ZME09QWoOr/WpJoTrkaenhkpXot+6T+l3iIB2zUwlvyjPpY6VKILWm9mIlE9BAN2wcwvezb2+a/un/RE0uQeNU7OuHxA7A3llfbsIVR3ppGFD2kPqM+p3LddSt4t1S5z+2nmb3KxT77PKTwYKjm6nwCicnYUyGfMGxE0Gm+VHO53XbXn3AjPBcurrCBtX0mHGhdDcr+j/+U8XFR3//dwYCNkXHyqN5YrsRmgk6G9iS0sWjjTTMi86mnMQEey47+SX+euT+vqpv2GR9CthJa6LV5dbTjQ1ZNMVrkeu7Dh6dOYOFz6eZjxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHf/uRaV/IKwbohowr4pyhIMuscsIAey9zyYeM0L1Cg=;
 b=tXhNhFD9srzMqVZEO9mkpiZr1RTu6ziQbb51VLYtSLsm1bOTaaeaclEIqv+4QuLlI/6XriQAOQRRgOSIBEJRaoxitWbnMRv+hY5Nj46gya3yXbz1Gx0CvO83Gw81DPwY/LsMgl9qbWapG99WVePpf8DzgL1cQBFDm/knepXOApw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 14:02:08 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3654.025; Fri, 18 Dec 2020
 14:02:08 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: cleanup vce,vcn,uvd ring selftests
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201218135547.5921-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6ef74186-56a2-6f38-b73b-b618fd1b5db0@amd.com>
Date: Fri, 18 Dec 2020 15:02:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201218135547.5921-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM8P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM8P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Fri, 18 Dec 2020 14:02:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 07908488-7763-49f6-71d3-08d8a35d8232
X-MS-TrafficTypeDiagnostic: MN2PR12MB4440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4440FF6CA18BCFCD5AEE01CC83C30@MN2PR12MB4440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FQEgW8YOj7JHbWdFmr3L/qdf3RbFGUvdnm64ja3QzkCrdjNiddwSb0X45chMXUOYjzGzzVThvLVbbJPiCT444yEAggOlcHPqUZESjIOSPjiH5cc7bkPdXQ6ltlcac2zdYYgSUjM8AQpq5sIB8AyFuuwfkrDzKufvrWYqLRIJ1Xwb8Bl08RiqO4z8tx3SRUoB4aHpMrUpyposeOdzI44r5dDjfLeElSiA1NAufWlsEknDFlLBpJhdhJsKkkiJf/nZbx1Lca/oPbDleWaqdIVnbziUes17J3VKm9/20KBEXgbCeBAti+GpEXWpZwFJV5TXi3xIp/dS5L0DwP6MmxMeNEParorzU6ugTC/MsIOEy3Cy2rufEVL+r4m2zweUZ5yJ9AQQba8QiU2Asi3uboW6JENwGApRZ+/Z8ThFGQ6yh1bdo+RCpaBDfIl6+9eOHPYi0Re1gXsAJEgdDlxoIDNlb1fBHLUQZSZNd5fh5/f1mU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(30864003)(6486002)(66556008)(2616005)(31686004)(66476007)(6666004)(52116002)(2906002)(31696002)(66946007)(16526019)(8676002)(478600001)(8936002)(316002)(5660300002)(36756003)(186003)(86362001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q2lIZkxWdittODdXdGJvVHdDSlZ4TGdNa1NnZUh1ZU1GMnN2cnN4ekVZV1Fz?=
 =?utf-8?B?dHZvSGFWRnp5YnJSakhWajhJSlljOU9qQ0R6YXVOL3MwS1Q2L0hlQ3JJOW9S?=
 =?utf-8?B?ZktTZk5YdnhwRDZKSEhxZmZsTkFOM0ZkSC9uaE1OR0ZYSjBYZTFYVCt3U0p2?=
 =?utf-8?B?V2wreFl4N1k2NXNlKzNmakQ1azA4VitFWlMrU1Y5Q1V4azNCbFByMFJZMUtW?=
 =?utf-8?B?TFBWZG1wOFVVSkxFKzAzQlZHaU5yL0VENUlzOE5zQnVIaFhYTkRXaSswQVNE?=
 =?utf-8?B?SWM5UWNaV1pjYU03cG44d3hRUXNNWnE4TVRkb0lXTWsrQ3VIeXlPYVNhd0lo?=
 =?utf-8?B?cnl2ZTlhUlVvWWI1YXV3a2RrYkx1ZmtXbE1pTEZabjBZOXByZndqS2hUcGVP?=
 =?utf-8?B?ZlBqK3h0WjEyUk5teGRjeDlUT3I1cHk4YlQzL2I4ZUplQUZSRGVWR2o5MVoy?=
 =?utf-8?B?N3JpZnY1SStFRG5aQXlFVlA4VTNxVEFtajN6d0IzeW5xK0FOV0c3UGtZTmdz?=
 =?utf-8?B?RWRJNkxKdkZaVExOTEdLL3pIL2ZVM2tlS2EvZktOeE0xc0pKY01iNjNKUnRj?=
 =?utf-8?B?QTV1MUtvQUNDcDc4Umx5VTJSSEliN1ZvR3dOamNTODdHaDgvUHkvSDBkVDA4?=
 =?utf-8?B?WmFMTTdYOTBzUVE3dWY2Q0dLK2VLRHdWQjNGQ0hrWk9JV3U5SlRlek8wVUhr?=
 =?utf-8?B?T29rWW1jWHI0K0xTNDFveGFGaUZsSzc5WkM3bEY2eTNnWHVxaWZ6NHNxeTZo?=
 =?utf-8?B?d2IxRzRmTWJUdFFXNUtRVXNxYTV4NTVKcHRhSkVKbzNLVjQ5Sk9ndEg0WmJx?=
 =?utf-8?B?Sk4rRjRXaGxya3dVVHYxajZsUk5zV3Mwc1krRENBUmRKcC9qbkNCL0wySGZi?=
 =?utf-8?B?bEhjcmVVcmlpTGxtYWJZL2dvRXREMmh5c05HcGdVOGpvZ2g2VXgydFloZU9i?=
 =?utf-8?B?Zk1tQ2drb1F4VkxNMjF1QWJjam5Oa0dUaXpNejM5V3NleVFweXhWb084NHFF?=
 =?utf-8?B?bVFSVVg1NW5FZW1jMnA0Z1Z2Y3p6eU5rUWZuN3hMOGFNSmxEZGFsY2tvYTFj?=
 =?utf-8?B?U3JnZGZKTi81TkxPVklmd2tlbVNtUktCZjJKTmxUWTllNVRXbnJVa0lvN1g2?=
 =?utf-8?B?QjZuNXpVV1RnUGV1L0ZhZjhSQkFNMVovcDlSZlptN0E4bGFTbFo4MlYreExt?=
 =?utf-8?B?RWRidG1PSVRBd1Q4cWFmQlJxQ0lLVTlQVzA2aXVYd2lpaUhyVWpPckVocE1Z?=
 =?utf-8?B?TmtuQ3ZSaUFPcFA3eFdpd0dxdm5QZWNjQkFQL3BRdWRTOHZ5L3prb1VYME1l?=
 =?utf-8?B?NTVwR2VVSEpuL0h5Sm5IeUQ0bDBlTHl4aGQ5cmNIb0h5ei94d1k1T0lZTkY5?=
 =?utf-8?B?RFZVUmNqa2cxV1U0NnQ3eEtFU2Q3UEVQTGgrWHkveXY3cUpWcWJIV2c1cGhh?=
 =?utf-8?Q?Fhvfq+Mq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 14:02:08.2646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 07908488-7763-49f6-71d3-08d8a35d8232
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YXBZjhSi/YqJcOTcOQnBQeE3VsiWt97fSMPPgp0yWk1Zkc/BAvo7urpI851HZbU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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

Am 18.12.20 um 14:55 schrieb Nirmoy Das:
> Use amdgpu_sa_bo instead of amdgpu_bo.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 56 +++++++------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 17 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 47 ++++++++++-----------
>   3 files changed, 45 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 8b989670ed66..3c723e25dd5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1057,7 +1057,7 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser, uint32_t ib_idx)
>   	return 0;
>   }
>   
> -static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
> +static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_sa_bo *bo,
>   			       bool direct, struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> @@ -1071,19 +1071,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	unsigned offset_idx = 0;
>   	unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
>   
> -	amdgpu_bo_kunmap(bo);
> -	amdgpu_bo_unpin(bo);
> -
> -	if (!ring->adev->uvd.address_64_bit) {
> -		struct ttm_operation_ctx ctx = { true, false };
> -
> -		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> -		amdgpu_uvd_force_into_uvd_segment(bo);
> -		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -		if (r)
> -			goto err;
> -	}
> -
>   	r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
>   				     AMDGPU_IB_POOL_DELAYED, &job);
>   	if (r)
> @@ -1101,7 +1088,7 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
>   
>   	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
> +	addr = amdgpu_sa_bo_gpu_addr(bo);
>   	ib->ptr[0] = data[0];
>   	ib->ptr[1] = addr;
>   	ib->ptr[2] = data[1];
> @@ -1115,33 +1102,17 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	ib->length_dw = 16;
>   
>   	if (direct) {
> -		r = dma_resv_wait_timeout_rcu(bo->tbo.base.resv,
> -							true, false,
> -							msecs_to_jiffies(10));
> -		if (r == 0)
> -			r = -ETIMEDOUT;
> -		if (r < 0)
> -			goto err_free;
> -
>   		r = amdgpu_job_submit_direct(job, ring, &f);
>   		if (r)
>   			goto err_free;
>   	} else {
> -		r = amdgpu_sync_resv(adev, &job->sync, bo->tbo.base.resv,
> -				     AMDGPU_SYNC_ALWAYS,
> -				     AMDGPU_FENCE_OWNER_UNDEFINED);
> -		if (r)
> -			goto err_free;
> -
>   		r = amdgpu_job_submit(job, &adev->uvd.entity,
>   				      AMDGPU_FENCE_OWNER_UNDEFINED, &f);
>   		if (r)
>   			goto err_free;
>   	}
>   
> -	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_sa_bo_free(adev, &bo, f);
>   
>   	if (fence)
>   		*fence = dma_fence_get(f);
> @@ -1153,8 +1124,7 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	amdgpu_job_free(job);
>   
>   err:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_sa_bo_free(adev, &bo, f);

The fence is undefined here and should probably be replaced with NULL. 
Same for other places.

>   	return r;
>   }
>   
> @@ -1165,16 +1135,17 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>   			      struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_sa_bo *bo = NULL;
>   	uint32_t *msg;
>   	int r, i;
>   
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &bo, NULL, (void **)&msg);
> +	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
> +			     &bo, 1024, PAGE_SIZE);
> +
>   	if (r)
>   		return r;
>   
> +	msg = amdgpu_sa_bo_cpu_addr(bo);
>   	/* stitch together an UVD create msg */
>   	msg[0] = cpu_to_le32(0x00000de4);
>   	msg[1] = cpu_to_le32(0x00000000);
> @@ -1197,16 +1168,17 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   			       bool direct, struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_sa_bo *bo = NULL;

Please don't set the variable to NULL. The compiler should complain when 
we use this uninitialized. Same for other places.

Apart from that looks good to me,
Christian.

>   	uint32_t *msg;
>   	int r, i;
>   
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &bo, NULL, (void **)&msg);
> +	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
> +			     &bo, 1024, PAGE_SIZE);
> +
>   	if (r)
>   		return r;
>   
> +	msg = amdgpu_sa_bo_cpu_addr(bo);
>   	/* stitch together an UVD destroy msg */
>   	msg[0] = cpu_to_le32(0x00000de4);
>   	msg[1] = cpu_to_le32(0x00000002);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 0d5284b936e4..bce29d6975d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -81,7 +81,7 @@ MODULE_FIRMWARE(FIRMWARE_VEGA20);
>   
>   static void amdgpu_vce_idle_work_handler(struct work_struct *work);
>   static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -				     struct amdgpu_bo *bo,
> +				     struct amdgpu_sa_bo *bo,
>   				     struct dma_fence **fence);
>   static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   				      bool direct, struct dma_fence **fence);
> @@ -437,7 +437,7 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
>    * Open up a stream for HW test
>    */
>   static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -				     struct amdgpu_bo *bo,
> +				     struct amdgpu_sa_bo *bo,
>   				     struct dma_fence **fence)
>   {
>   	const unsigned ib_size_dw = 1024;
> @@ -454,7 +454,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>   
>   	ib = &job->ibs[0];
>   
> -	addr = amdgpu_bo_gpu_offset(bo);
> +	addr = amdgpu_sa_bo_gpu_addr(bo);
>   
>   	/* stitch together an VCE create msg */
>   	ib->length_dw = 0;
> @@ -1130,16 +1130,16 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
>   int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_sa_bo *bo = NULL;
> +	struct amdgpu_device *adev = ring->adev;
>   	long r;
>   
>   	/* skip vce ring1/2 ib test for now, since it's not reliable */
>   	if (ring != &ring->adev->vce.ring[0])
>   		return 0;
>   
> -	r = amdgpu_bo_create_reserved(ring->adev, 512, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &bo, NULL, NULL);
> +	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
> +			     &bo, 512, PAGE_SIZE);
>   	if (r)
>   		return r;
>   
> @@ -1158,8 +1158,7 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   		r = 0;
>   
>   error:
> +	amdgpu_sa_bo_free(adev, &bo, fence);
>   	dma_fence_put(fence);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 4a77c7424dfc..ae4a80724ce2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -488,7 +488,7 @@ int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring)
>   }
>   
>   static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
> -				   struct amdgpu_bo *bo,
> +				   struct amdgpu_sa_bo *bo,
>   				   struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> @@ -504,7 +504,8 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   		goto err;
>   
>   	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
> +	addr = amdgpu_sa_bo_gpu_addr(bo);
> +
>   	ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
>   	ib->ptr[1] = addr;
>   	ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
> @@ -521,9 +522,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   	if (r)
>   		goto err_free;
>   
> -	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_sa_bo_free(adev, &bo, f);
>   
>   	if (fence)
>   		*fence = dma_fence_get(f);
> @@ -535,25 +534,27 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   	amdgpu_job_free(job);
>   
>   err:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_sa_bo_free(adev, &bo, f);
>   	return r;
>   }
>   
>   static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -					 struct amdgpu_bo **bo)
> +					 struct amdgpu_sa_bo **bo)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	uint32_t *msg;
>   	int r, i;
>   
>   	*bo = NULL;
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      bo, NULL, (void **)&msg);
> +
> +	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
> +			     bo, 1024, PAGE_SIZE);
> +
>   	if (r)
>   		return r;
>   
> +	msg = amdgpu_sa_bo_cpu_addr(*bo);
> +
>   	msg[0] = cpu_to_le32(0x00000028);
>   	msg[1] = cpu_to_le32(0x00000038);
>   	msg[2] = cpu_to_le32(0x00000001);
> @@ -575,18 +576,19 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   }
>   
>   static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
> -					  struct amdgpu_bo **bo)
> +					  struct amdgpu_sa_bo **bo)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	uint32_t *msg;
>   	int r, i;
>   
>   	*bo = NULL;
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      bo, NULL, (void **)&msg);
> +	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
> +			     bo, 1024, PAGE_SIZE);
> +
>   	if (r)
>   		return r;
> +	msg = amdgpu_sa_bo_cpu_addr(*bo);
>   
>   	msg[0] = cpu_to_le32(0x00000028);
>   	msg[1] = cpu_to_le32(0x00000018);
> @@ -603,7 +605,7 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo;
> +	struct amdgpu_sa_bo *bo;
>   	long r;
>   
>   	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
> @@ -633,7 +635,7 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   }
>   
>   static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
> -				   struct amdgpu_bo *bo,
> +				   struct amdgpu_sa_bo *bo,
>   				   struct dma_fence **fence)
>   {
>   	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
> @@ -651,7 +653,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   		goto err;
>   
>   	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
> +	addr = amdgpu_sa_bo_gpu_addr(bo);
>   	ib->length_dw = 0;
>   
>   	ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
> @@ -671,9 +673,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	if (r)
>   		goto err_free;
>   
> -	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_sa_bo_free(adev, &bo, f);
>   
>   	if (fence)
>   		*fence = dma_fence_get(f);
> @@ -685,15 +685,14 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	amdgpu_job_free(job);
>   
>   err:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_sa_bo_free(adev, &bo, f);
>   	return r;
>   }
>   
>   int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo;
> +	struct amdgpu_sa_bo *bo;
>   	long r;
>   
>   	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
