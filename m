Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AC2C47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 15:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CACD2613B6
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 15:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACD2613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C4346E081;
	Thu, 27 May 2021 15:30:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43CC96E081
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 15:30:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3XbamQo0xgdaaVSAgtRWVZRQiI/6zdqrQPSlDuCCRTcXIsdaKUbjWprmYXIZNH8/2ptCd3wJkx/i+n914B5FurbZZ+/jIl/Sa9TE8oAtpr1DzVn0dsO/K4gB9x8eiWT3qkCby1OnL/A6qiFzVHYOI1U5Z12s2xXQmXikTLVmiJt2KrtytTEPjBlvdAbrCn5chjXfZQTVtWvryoR2DsT1QwLGpTgjUFr/lKrZCjl/8Dymd5g/lHuvcwbsGWpR42TUwuB0wEQYmOwbjrJKh0xe75Pd1g/v7d/xZtb9hPeLvbF2mlXE2WOrq8Ob6DFQ8ud92C07A8LV957bdlxedTSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSw2Gxmtly7NMNpcf1tOjhZLLTOiN/nhCF8qzFcpClM=;
 b=bxiOMeyzQJgOxps6nNiE6gMS0yb2bFOmrt4NKziaZnqHR9K8BqLio+/IaBVsolGRd5kl8pqHoFeuU2uvfT4iqlbhElxKBWKvEqtTz7TMIxg2tdW3kH13jUbmzS3VWl3YXoDtKpV4Ihbnk6+ecdFhzsW2XY2w7qhKKOmqB6baSDlKh30xBJBVM2Tx2Vo/OHoGt3ziTQbXmnl5U0GRZzD6IKDtuPFx4pIgxZsOJPCPRX+yXfyuQ3efpWmUg4jVpmLQ7XxqMbC9OZFaImAiU6baDEqkj/hflleFg7L0TkIS0T0kItJXoIv0tShzTbLXEcsQ/leTnfUhtwgV9FpWjsz4gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSw2Gxmtly7NMNpcf1tOjhZLLTOiN/nhCF8qzFcpClM=;
 b=QSuekSVWTHPjmbct9C2pezTdeixkotCA9m4yMFhwEt0JW2qmy2Fxvm/9xAjda5HHW+1d45E0aDkYrTNaTtpiuUcXilYlw3K1xQ2EwOLgOPIVUm2gj/cH+0xYnZyuK5Y/FJIGA2gNHb1WGgw1Ej8uhTLhNUK8n/FhpXrkUwSgbp0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 15:30:30 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4173.024; Thu, 27 May 2021
 15:30:30 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: convert gtt_window_lock to a spinlock
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210527145425.18161-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3d33a574-b160-1124-a3e8-962d28ccb781@amd.com>
Date: Thu, 27 May 2021 17:30:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210527145425.18161-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ffcf:5811:6cd5:8a3f]
X-ClientProxiedBy: PR1P264CA0014.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::19) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ffcf:5811:6cd5:8a3f]
 (2a02:908:1252:fb60:ffcf:5811:6cd5:8a3f) by
 PR1P264CA0014.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 15:30:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88040f25-14ab-423f-42d1-08d921245c79
X-MS-TrafficTypeDiagnostic: MN2PR12MB4440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44400FCE56E0E24E3E745F8683239@MN2PR12MB4440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3V3eYbjQjiLiKtEolwgwJPkZUCbEtcgjcELXukl+ZTLkeBivCKCExsnfPjFELKuzYzo47TBsefio/Ys3bQNc9Z0Vd/F/w/MK/qBlbOpofxo3azWtU/tvFCf6JzaCLu87QZAZ/aEipohOYX6at/C6nR9EeTEqSNCV8FHsQ8UN5arCXdhC/Il+O5QwQ94V3FZdMVTTnpisTOojqoQHOAHvw32KzaREqD7tsEk8r+4QJiEpo2nuX+b30ij0esh4xhjmBr9ikFcCqMF92bVdTHDdqpHXrd+yUN/c5lnJmFe5InggfHRhlvGExRenjKx6AL/fuHVq+XYYO/8UZ5/ZRYg6MKVu021leFbcW4NhRP6iajjX1fchjCLTDRb6HCRoGeXUlmfSJ1b/5QLbrkqNMfH8OQ6/zqBrUNHSMAh44ysoRn2FKVuOItlt/SWN2AmCFtiTp+ts79mac+KGWt71ujwKhFH+o7ZTvBT9cq4q0WcuWml6dYVV34FHl3uW7oVXFDdJhK69Zc3tEs9dvm8IHGo0HO512y2TQBe18MRP5fQxMNitVHEsf/AD+6oW/KGheZTx0HDmihse2Xz0ySQ5T00a+6u+Qub/vj8vr3GvqQOep9Eo4kiSsK7958jdxchBZXUFWBntOFMPZNG8WW9Mw/dCT30tXCFVoUUldvt28LmXDkllDzN7ZMula6ZfQW7CYTEw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(186003)(2906002)(8936002)(5660300002)(31686004)(16526019)(2616005)(66946007)(66476007)(8676002)(83380400001)(316002)(66556008)(478600001)(4326008)(6666004)(31696002)(86362001)(6486002)(38100700002)(52116002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c1RwYU84UkRrUjJjMEU4azlKWU82clZ1Q0VYcWorQ2RqRC9STitGeXMrVzVI?=
 =?utf-8?B?enkrcExORXZxY291bHBXeEhaRlJKcDllZ0NTTWVzU3ZKMWVaZ21kMkRFZXQ3?=
 =?utf-8?B?dEVJajFTd3pHYTF1M3hnUEJqZmtOdElpZnpOOU9UTWErM1VsTXIvdld4N1dn?=
 =?utf-8?B?SncwRk51ZC9Scy9VdlgvaFg1S2h5dTIvMUY4NjV5QmxDREw3czJ1WTArSGpl?=
 =?utf-8?B?dEZON2w2QnZiTzZOUlQzVVM4MWNFYjg4RHE1bUVCZURHeWRYN0R4YXJibjVG?=
 =?utf-8?B?cU40MnpyRzNFN1VxbE41bHZSN1NiVmFMNi9CUW9BQUErOG9oeGNaeUM1ZGV2?=
 =?utf-8?B?Zm5NT0pTYU8waFNOOEpPNHNJWkFvbzIzWTFGaG10clhVS3BKTkxnM2dGcnVv?=
 =?utf-8?B?K0JZQWFDbk1YNjUrTnNPa2lRa3VHalliRnRoSzRLZk5vL0RRRkR5S3RMTURE?=
 =?utf-8?B?ciszSFhKWDk0ZmQyaWF4ZEJScjJlSExoVDBVYmpTMG9PUGxOQU9IL3g2Ni95?=
 =?utf-8?B?VDVtcklKWDh3dFlUSmFhcUhiamdhRlFRSUxFMXlDV0pUbVFiVG5NSG9LS2hi?=
 =?utf-8?B?ZGJwNTlkR1l2bDlwdHlyWlkvWE0xbURkK293UWphRlgzdXdYQXdqMEgrWm04?=
 =?utf-8?B?azAvNVRnNWxic1k1eTg2SGx5OStFRTh5Z2M4YnRMYVFCT2FJYlVha0dSNndj?=
 =?utf-8?B?dEQyYkZJR2haay9QOXg4ODVjaXNQb0J2dDZuY0ZxVTc3bE90YkJHclorTW91?=
 =?utf-8?B?MlNnd1BMS3lpcXYrNnNCdFhhNkZEcjdjMEppUzhQMHQrcnNXTitQQUxZblU0?=
 =?utf-8?B?dEhnbHpETUZERm0zSHd0MUZuazFLeUdtSVo3YWkvc3ZaNG1oTEFnMk9vV3lt?=
 =?utf-8?B?a095b3pzWUJkc2FDK2ZNL0ExUEE1QnRlYlFyNUh2YW9HUDJrNkhUQTg2aTI2?=
 =?utf-8?B?dE5LeWxBRDdSdS92YlU3TXAxTXRRY2pEVDEvb2d2YUJXNTBxRXJtMTZUSUlr?=
 =?utf-8?B?TlA4MHZLejNUS0IwaFp5YlpNaG0wYnFmaHlmRVJVUldmdUdmRUtrUTN6VUZX?=
 =?utf-8?B?REFoRnQzL2d2VjdXMHNxeHdqOTMxR3kxWThwcFNDWEo4eEhXclVLWVpHOTNa?=
 =?utf-8?B?Q2EwSTEzWTVScnZwL1VCNXlIUmZaK25oeWNDTUdjL3MyUGNFL0ZkQUsrb2o1?=
 =?utf-8?B?RzN4a2YwTjRFQWtSbm9TQWpjZ2FacUJBYUU5NFMwaTc0MHBCd1c2QzBxTG9a?=
 =?utf-8?B?MUUwaCtXd3YvY3drSXV5SldwTE85ZnMyb3djb0k3SnA0Tnp4OVcwaThwUFlS?=
 =?utf-8?B?SmRwQlUxNjhNTHZJRGFWTG43MEU0Sm11ODZKMkUySWN2b1RROVVld1dKdTJQ?=
 =?utf-8?B?Y01FWVVZZE9pZHdCTlVYU0Z6THoxS3hCWTZ5Uzh6VTRBSW9SSWlDRVFicXpJ?=
 =?utf-8?B?Q1U5R245b2l5b01QbGFzZXRHYWJ5emNOL29wc2ZRMU1CMlQ1bGVRWVJoOE5o?=
 =?utf-8?B?VFRxbXZoVVNsOWc3Z3VNY0VHRlE1RmlpU3lqcHFoZXlrN1kvQ0NoVzVkQlFs?=
 =?utf-8?B?L1hTdnBhWmtjVzVvM29SY1BBOUlzSmI0TFdBSTloaVJZZ2pqaXBKUDRERTZS?=
 =?utf-8?B?YjdCaklSUk5CN0dUTmVOVTB4ZXpxTnJvM1Q1T1Q3OVlUZ0FISERhN3RHayth?=
 =?utf-8?B?QllGbldsbWRjUmxrQ1VIK1NvZjVoK0ZTTHdaNlh5bk9oWmNCOG43eis5eHd6?=
 =?utf-8?B?UHFKQ3Z1R0s4d1BmRVhhMHh4Njg3cnRycFlQUnl4MXZncVVyRHpVb3BVQjRQ?=
 =?utf-8?B?Z2lVSWYxUmZ4c1Vsall3M2JIeDYwVDdEN3BnejZmYjhQRzYvdlN0ME1kMzgr?=
 =?utf-8?Q?Q7+bORAHnAdOL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88040f25-14ab-423f-42d1-08d921245c79
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 15:30:30.4455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgGBOp8GLqtH5x8/pDMG6bYU20g6QFfXj5KN7U40CHFDn9OshgpbgTMuApuzWckP
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That won't work, we need to be able to sleep in waiting for the tlb 
flush anyway.

On the other hand flushing the TLB after recovering each BO is nonsense 
to begin with.

So we should probably move that from amdgpu_gart_bind() into 
amdgpu_ttm_alloc_gart().

Regards,
Christian.

Am 27.05.21 um 16:54 schrieb Nirmoy Das:
> amdgpu_device_gpu_recover() will eventually call
> gmc_v10_0_flush_gpu_tlb() with holding a spinlock, which
> puts the process in atomic context. Sleeping in atomic context
> is not allowed so convert gtt_window_lock into a spinlock.
>
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2662, name: cat
> Call Trace:
>   dump_stack+0x8b/0xb0
>   ___might_sleep.cold+0xb6/0xc6
>   ? gmc_v10_0_flush_gpu_tlb+0x72/0x2c0 [amdgpu]
>   __mutex_lock+0x45/0x820
>   ? amdgpu_device_skip_hw_access+0x3e/0x70 [amdgpu]
>   gmc_v10_0_flush_gpu_tlb+0x72/0x2c0 [amdgpu]
>   ? amdgpu_device_skip_hw_access+0x3e/0x70 [amdgpu]
>   amdgpu_gart_bind+0x7a/0xc0 [amdgpu]
>   amdgpu_ttm_gart_bind+0x7d/0xd0 [amdgpu]
>   ? amdgpu_ttm_recover_gart+0x2e/0x70 [amdgpu]
>   amdgpu_gtt_mgr_recover+0x4e/0x70 [amdgpu]
>   amdgpu_do_asic_reset.cold+0x90/0x1c4 [amdgpu]
>   ? amdgpu_device_pre_asic_reset+0xa8/0x250 [amdgpu]
>   amdgpu_device_gpu_recover.cold+0x7bd/0xa23 [amdgpu]
>   ? lock_acquired+0x210/0x390
>   gpu_recover_get+0x29/0x60 [amdgpu]
>   simple_attr_read+0x69/0xf0
>   debugfs_attr_read+0x40/0x60
>   full_proxy_read+0x56/0x80
>   vfs_read+0xd1/0x1d0
>   ksys_read+0x68/0xe0
>   do_syscall_64+0x33/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 10 +++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  4 ++--
>   4 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index c0aef327292a..4cb8fd193b6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -333,7 +333,7 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>   	amdgpu_res_first(src->mem, src->offset, size, &src_mm);
>   	amdgpu_res_first(dst->mem, dst->offset, size, &dst_mm);
>   
> -	mutex_lock(&adev->mman.gtt_window_lock);
> +	spin_lock(&adev->mman.gtt_window_lock);
>   	while (src_mm.remaining) {
>   		uint32_t src_page_offset = src_mm.start & ~PAGE_MASK;
>   		uint32_t dst_page_offset = dst_mm.start & ~PAGE_MASK;
> @@ -373,7 +373,7 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>   		amdgpu_res_next(&dst_mm, cur_size);
>   	}
>   error:
> -	mutex_unlock(&adev->mman.gtt_window_lock);
> +	spin_unlock(&adev->mman.gtt_window_lock);
>   	if (f)
>   		*f = dma_fence_get(fence);
>   	dma_fence_put(fence);
> @@ -1661,7 +1661,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	int r;
>   	u64 vis_vram_limit;
>   
> -	mutex_init(&adev->mman.gtt_window_lock);
> +	spin_lock_init(&adev->mman.gtt_window_lock);
>   
>   	/* No others user of address space so set it to 0 */
>   	r = ttm_device_init(&adev->mman.bdev, &amdgpu_bo_driver, adev->dev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 2877a924086f..afd905dc337b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -70,7 +70,7 @@ struct amdgpu_mman {
>   	struct amdgpu_ring			*buffer_funcs_ring;
>   	bool					buffer_funcs_enabled;
>   
> -	struct mutex				gtt_window_lock;
> +	spinlock_t				gtt_window_lock;
>   	/* Scheduler entity for buffer moves */
>   	struct drm_sched_entity			entity;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index ceab5ef50790..f4ce3eb4d7e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -341,11 +341,11 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		return;
>   	}
>   
> -	mutex_lock(&adev->mman.gtt_window_lock);
> +	spin_lock(&adev->mman.gtt_window_lock);
>   
>   	if (vmhub == AMDGPU_MMHUB_0) {
>   		gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_MMHUB_0, 0);
> -		mutex_unlock(&adev->mman.gtt_window_lock);
> +		spin_unlock(&adev->mman.gtt_window_lock);
>   		return;
>   	}
>   
> @@ -356,7 +356,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	    amdgpu_in_reset(adev) ||
>   	    ring->sched.ready == false) {
>   		gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB_0, 0);
> -		mutex_unlock(&adev->mman.gtt_window_lock);
> +		spin_unlock(&adev->mman.gtt_window_lock);
>   		return;
>   	}
>   
> @@ -379,7 +379,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	if (r)
>   		goto error_submit;
>   
> -	mutex_unlock(&adev->mman.gtt_window_lock);
> +	spin_unlock(&adev->mman.gtt_window_lock);
>   
>   	dma_fence_wait(fence, false);
>   	dma_fence_put(fence);
> @@ -390,7 +390,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	amdgpu_job_free(job);
>   
>   error_alloc:
> -	mutex_unlock(&adev->mman.gtt_window_lock);
> +	spin_unlock(&adev->mman.gtt_window_lock);
>   	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index fd8f544f0de2..e1dad02d400b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -135,7 +135,7 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
>   	uint64_t size;
>   	int r;
>   
> -	mutex_lock(&adev->mman.gtt_window_lock);
> +	spin_lock(&adev->mman.gtt_window_lock);
>   
>   	while (npages) {
>   		size = min(GTT_MAX_PAGES, npages);
> @@ -171,7 +171,7 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
>   	}
>   
>   out_unlock:
> -	mutex_unlock(&adev->mman.gtt_window_lock);
> +	spin_unlock(&adev->mman.gtt_window_lock);
>   
>   	return r;
>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
