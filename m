Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437A4C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 15:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F1F23772
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 15:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F1F23772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 715EB6E825;
	Fri,  8 Jan 2021 15:25:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7CD96E825
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 15:25:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+0K70CzAGGn39ykUd3018LP37ODHkwI13llF6VbFGC+5j3lYBOBAgbNpyyHz37kaAtpjN4w/wBbj+ze1Ey9JZos2NITYLMuLifdsZVhQx6G4zCrmOarI4Tz34ECzPSwQNFniGA27LUGBsJ82uRYBALx1J05AL/3yKhbJoO8976+HM1/5FvUYPMBUzvK9VwxUuF/+4ML+tQpQMYIgIyw1rRlwbxYVfnqGt1p8MWdfQKc7y0OO3cBsm1eePc4WLuB/eW/bGz6eLY19TUzS1U2rnXm8SGAyXfCdlrcrCmm9/++r8dOrAwhdEmbimXjKwO0x83A8frx2p/JkNrL0Felvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMkEJYMb1YiNNVwUNhJcel9GDztMuHcxdEeTYNJWKbk=;
 b=FoN+0JcfGhOc89FDTZrf8/hq9D1Fspcd3x5ynP9caXk0DVqBPXLD2p25DyVWVw/mEDN4UA6kKE7oBH+xkF8UH9EhBvILtPVAKuaRKuMvFOQjE/jc7Drh+KUfMA4BIaGex16dDjuzvZn0Qgqtz4jLPwQ5SE+EEPr7Y1LJsu4lk5hUOxFWldSxAoiPhkTmCnPyrJiW8xWolbXu1xyIDgm0kttknaXuXQ+U6KtWDT/8+gjJcUp3JOuXuhOXTt3i4BIlySZfZBRNPb1HOECWXQMDtiMpwGcESbp/GDk2VgMKp9yEYgf7/SqO/W14imiVmexkQ+myF67GaqYQ/dRL8X0+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMkEJYMb1YiNNVwUNhJcel9GDztMuHcxdEeTYNJWKbk=;
 b=06gbrqs3y4ruGF4GNcXXmUeJhd/e4vUABeC3MVbKjq81fD/GpVBai3FI3uB7bLvOHp+LRtV7ybRagZhSRpnLg7/CXCmFuWNBNeufsE9H8gAQPxF54SAvWDKR+6k7r9fuTCV4xwyKP9FTZkgYcE96xeGolTZ1gn6FUnrMQ+GXRZU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 15:25:28 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3742.006; Fri, 8 Jan 2021
 15:25:28 +0000
Subject: Re: [PATCH v2 1/1] drm/amdgpu: cleanup vce,vcn,uvd ring selftests
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <6ef74186-56a2-6f38-b73b-b618fd1b5db0@amd.com>
 <20201218144024.4994-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7c54d56f-5fe3-e874-6749-d08efa1a9f29@amd.com>
Date: Fri, 8 Jan 2021 16:25:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201218144024.4994-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.2 via Frontend Transport; Fri, 8 Jan 2021 15:25:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a1d9e01-00e9-4f9b-688b-08d8b3e9a13e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3933:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3933E2E8E948CA849C3E105A83AE0@MN2PR12MB3933.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGDFaymgyhhyu1z+Zn6MOaVjmYIwMsSt4Y5nkeVLNtIPaKRPh3TX/3/zJ1pkzzV0KhC8vMg4+TS2Blzwsce2srtnB3xV1KHWn143DVDG/qFKp1V9eeMe1xAGrDEleUGNHvQBWnWdpx6oBY831BsGA1TrS5sjb86YNQFvv3+w5IgV2MxXj95Pm4/ldrTDub9suNOiiMc7A9cu+zEhXpFHqichjkLwoGLISw4iReZDLH6QjNeWb/So1K5aslZuPKDA5sFexDC/KRAs2o2MO5FI4hkdY7yczRTZFqMGx+wNw+IoQ+SHitw2JFF1RH8pknrMHWZvYitaxV5uF3qTDIskpEff1UKhLfEEhSqbVctXQSoC7M6X55THQvq2TDsvFtiAHYRTClkh1ERjUvk3dDmRMM49agKCQiVEUknKdjLbcTwIaGqL1hb9ablYS8WKHUJG4twYRt0EULXWvev52kSYJHH8HG6bsayLhP97ith91cM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(8676002)(52116002)(36756003)(31686004)(86362001)(8936002)(66476007)(5660300002)(2906002)(83380400001)(316002)(30864003)(6666004)(31696002)(6486002)(66946007)(2616005)(16526019)(66556008)(478600001)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VWhWbkU2elNrd2pnMWNHRElRMlgzTEp2djJqRTNvSk1Ic2ZJVGh3N2NWdnJF?=
 =?utf-8?B?dWdXWngxOFlkVEMxWmRRVnZzaGFpaFpUSWNlWWhOdjdPOTdQU2k2WDBIa2F0?=
 =?utf-8?B?YUordEJiOGtYaE9WblZyNWFhdVQ3bXNCNU5QTkhZSkR4NlU4TUJKQkNTNVQ1?=
 =?utf-8?B?VFBOWUtQYmhzTURQZ2U4Q0V5TU9LOFFBRFVoQjRBRGZOK2FSaHJ6Y052YzNr?=
 =?utf-8?B?U3JNQ3ZlMlRtYmdFODdDS3JxbEd4OEpmR1YyL3RxNHhObGtMQ2JzZmVUNjBo?=
 =?utf-8?B?dVMrNFdDa1FqZW1CM1d4RnlIZ2tOTHBndjEzUjVqRW9hK1VMNFdBM0l6UTVj?=
 =?utf-8?B?cUlIQis3bjF3NU5MVUphK3hGOEQwZ0JFVUtBaDdDblFHYmdjUVhhazBwcmZW?=
 =?utf-8?B?WGsyMmtWYU85UW4xcEFKL25mTzdNQUJ4VHd2SzNsZ0tjcjU3ZnptN1QyZlZs?=
 =?utf-8?B?SGdkUVZDVEFQbC9Zbm52NGlEZXcwYlF4bGUvTzNVa0pyYzNINC9sRnk5Z2dr?=
 =?utf-8?B?UzNvSFd4TmErS2ZSWk5QV2wrdWVtRDhXcDIwc3hvNG5sRjEvMWt3NzJzWlI4?=
 =?utf-8?B?WDA2ZlFZNW5HZkJnWi9oSEN3M1MrTmw0WERTMlFLQjVPbXBKakM4THRCL29P?=
 =?utf-8?B?RW5QUEpjNU5XNjN0WHhlSGZRMXRGYVQwU3BkYXc5MDZsU1NLVFpFSmN2S0tC?=
 =?utf-8?B?aFVwQUtwYkFQdm16aE1EN0hwRmFVQlRWZVN6M01IVmVqNXB4R0lSM1VBdzAy?=
 =?utf-8?B?US9pRW9wSVpjRVEwQlBjQzV6WlNlS2ZhSjQrSHhMeXRKSjFINU1WNVMyNlVa?=
 =?utf-8?B?MkRHM2NUWWh1ZTVjSXljRWdMWmJka1dVUktLVTh5WXE0U3JzWGYxQzhXWFR2?=
 =?utf-8?B?VkVvNTJsWVp3NGlIS2ZsbTZOYnlkTGJPZTZGKzZRVHJaUWF1QngvY0p4RFN3?=
 =?utf-8?B?ODhVTklBV0VpUmlXZDZzRFZhZ3pwUEpEczdJY0RJdGRvelJaRCs4SUhFSEE4?=
 =?utf-8?B?VGRPZTF0d21sT24rSnh1MlhIR0xxQjBLS2lZeXp2ek9vemF4Qmo1RTk2aTFG?=
 =?utf-8?B?M0NDMHpSSmhNUlFsREdDZVo3dDdnMGwwbkhudkVQbEI5NXljN2RpSUJzVWJD?=
 =?utf-8?B?N1g0OVZMRURMMDZLWmxjZU1mbVA2QlMzV3E2Rm9qSk9CMUFsTVU3Kzl2TE15?=
 =?utf-8?B?ZmVrTi9WaWVWK3AwaW04QmpCcFF4YnZjcGR6M2FjZDkvS0dIUjVGQ2VlUnJT?=
 =?utf-8?B?c1BpSzJ6eThuNnJLd0tDdTB3NkhOZDdZKzloTVB2TFZyeENjY1IvNUxtdDJY?=
 =?utf-8?B?Z25mZVlud28vcUdtSkpiNEdkL3BiWWsyVElTazdYQWRZMW52SEk0ZWliR1cr?=
 =?utf-8?B?Z2h4SHd3OXVKVmJMWkt4MXM5SGRYMW4wU0NEd0tqci90NW9CQTJYSlRjREMw?=
 =?utf-8?Q?A0RYQflI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 15:25:28.5849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1d9e01-00e9-4f9b-688b-08d8b3e9a13e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxYS9731H8ZnMG7GxMhuVO+bYdBYw8uF4yIKw1PI4KwXYxz8oxAppoH1d1V/zTPo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3933
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

Am 18.12.20 um 15:40 schrieb Nirmoy Das:
> Use amdgpu_sa_bo instead of amdgpu_bo.
>
> v2:
> * do not initialize bo to get hint from compiler for -Wuninitialized
> * pass NULL fence to amdgpu_sa_bo_free if fence is undefined.

Found a major bug in this which is probably the reason why that never 
worked before.

See below.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 56 +++++++------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 17 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 47 ++++++++++-----------
>   3 files changed, 45 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 8b989670ed66..13450a3df044 100644
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
> +	amdgpu_sa_bo_free(adev, &bo, NULL);
>   	return r;
>   }
>
> @@ -1165,16 +1135,17 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>   			      struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_sa_bo *bo;
>   	uint32_t *msg;
>   	int r, i;
>
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &bo, NULL, (void **)&msg);
> +	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
> +			     &bo, 1024, PAGE_SIZE);

This 1024 here is wrong. The size is in bytes and not double words. So 
this needs to be 4096.

This only worked because amdgpu_bo_create_reserved always allocated a 
full page instead of 1024 bytes.

Same problem on all other occasions.

Additional to that the direct pool should only be used if we submit 
directly, e.g. during a GPU reset.

Otherwise we need to use the normal pool.

Regards,
Christian.


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
> +	struct amdgpu_sa_bo *bo;
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
> index 4a77c7424dfc..1e46b2f895ba 100644
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
> +	amdgpu_sa_bo_free(adev, &bo, NULL);
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
> +	amdgpu_sa_bo_free(adev, &bo, NULL);
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
> --
> 2.29.2
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
