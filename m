Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEC8C47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5786139A
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5786139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E506ECDC;
	Wed, 26 May 2021 12:39:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D686ECDC
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 12:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEoteyfOHBBXEz63TJAVQzsn2UG19fZwcU3TO0PhQZT0SPM1S6LDCTy3ntQ9JcumQ758so/3dwCzj4W9nI5Q5Lya2UdDXGbT/eKFR4vpA4MqsxGi53f31nGbgBQMTWn0Bp/lZXqnBKw4iTnkzpF9voBxtBWxqHN+EfGUSWOd/93B8/YR8siYpfqbSCtIcZbQPIYEOVF4QfOWMAumQh1HxYLhAPTAy5JOQEXQOOIXky8G0X5V648A5z9d67Aizk0yDKMcpYD9/iqRlJiQc9QQVIZzTFoHM1NAGBF6VvGwVFUwG5n/RLxQ/FR5W9P7Ki/4FnSVQLYdBk35HpHE3LPpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJofM2ncRvKAvyLLBL9LT9IlNkMPWaSos3Z+L9vy+eg=;
 b=UBXNA9obTclx7ACxXdmHxtw8UgtMvmXE3VpmRiW414yomcRiqXrgl4s/AJ5nHfINBPnevqu+oCuGmIS24pcrsasrv9AAAqMEuZ7fYGO4x6okKB+XaKXZY7Qga9iJGJzyhYSNd0ojtq5pZ93rctiwvkK+uzB8v89nHM7wB9cTuptaViTrqsPlWKxE6T9BTiv5iUQ/gLRB81jJZOGo2+NY2LFqiaGUdyF6q0Newc8qARb41/F7krc1EOXBWdJKxCNejiNf+sPOr+SG2QOqPplCRnrRb0wkMt5HpJAXaRvqK3Y41IrOk+FW9jumbTHRQ8mL5lcf9fBGfIMvaMTyi+L5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJofM2ncRvKAvyLLBL9LT9IlNkMPWaSos3Z+L9vy+eg=;
 b=FhPhTfxKPDbrw/TAA0qJBrb8RU9PT+iN7bwH5KDQD1Ulfz88I+QWDctau8YOG8qtGG5MB3rzS1/7OpAkQziYkXWDw6nd6nGlOQcfoZkXVjC+HDH7hz9szstD1ROxaDMKEoz0+ffT2i+VBhZ6ramXP4ywU9MlPNT2UMAZd5QOYx0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 12:39:48 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 12:39:48 +0000
Subject: Re: [PATCH 3/7] drm/amdgpu: use amdgpu_bo_vm for vm code
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210526101027.14936-1-nirmoy.das@amd.com>
 <20210526101027.14936-3-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3d857c73-6f96-ef12-5a16-3282624153bc@amd.com>
Date: Wed, 26 May 2021 14:39:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210526101027.14936-3-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:3ecd:562c:67c6:4afe]
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:3ecd:562c:67c6:4afe]
 (2a02:908:1252:fb60:3ecd:562c:67c6:4afe) by
 FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.12 via Frontend Transport; Wed, 26 May 2021 12:39:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c39e45df-7fec-4257-31ab-08d920435989
X-MS-TrafficTypeDiagnostic: MN2PR12MB4536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB453632C89641C3AD527CFBF983249@MN2PR12MB4536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPcB9PNOQnT23Ije7pC+qDdIalVT0fCeNpLd7zORSZbh09qoLkDmRS9pvikUEdEkeuNh8NyMrwZbkdBfxL0NX/Cn1N0vfPm6M3gLoFki7HApeAfDfeF399fWuUs2lni+swRWQ+4xKVagnt+L4JwSYiUKrxJ0wcoG6/URTQHwjXF9mhbheydf7VppsTA/r47z9eTulSfrQ53u5k5Dqr67hQP+HtH8HEKqTTPXfo8zw9jPUHG0O4OJdE4nC6JOf0xq5ByvUXR31eMhYqy/09KbxEqwvpT5BaTJixPj65u1uv+keQhiK/6HxancYS/gFGCrjmPMxdrBbuK3UdQs+Q4zmKMUrDb7qjiIt4mrBsZiVFze4T1KPJve/+W9UywZU4k4yqgWpL5F7/pPqhvK2LpfdRkuVufObu5DSylr+SKY4s6fEyY7EWZmKul/sMb7VI2OeEQnyNpcWA3EhcnmrQrb+aYWHJwrzpilXKZzczHMlpRDodWunbAONN4bSOMOUKAloz1JSe/GmJ6kwAB3rgg2kypPJVBdfswzR8UfFZCYEkfuMkAy4yIOegeC8wL0NR7if0Wxb4r5lXLkTlhBk2bqNhYgKfGfJ7Qhgt91krXVkHioUZ6ccP4hVbdUt1s6ffWsT4Eun/183vVzYvTNPF8FWk3qfHM623Moj0hb00CrqOQhSPAi6uvK2Rjv5m1BL4Iz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(86362001)(83380400001)(66476007)(38100700002)(31686004)(6666004)(66556008)(2616005)(478600001)(52116002)(2906002)(66946007)(16526019)(186003)(4326008)(8676002)(6486002)(31696002)(316002)(36756003)(5660300002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WW1ONW8yMy9BZGxuOTlzSEJoNWNZc0h6cFZWSUNyVlluWm1iWDc5VUltV1px?=
 =?utf-8?B?Rlg0Sm1nVE83NjlvL3NXaEc3K3FBalFjVUliQ0xjRjF6VFcwaERrM0NYZy8v?=
 =?utf-8?B?dlVBZis0REdxOEJZeDRUTUl0N2t5WlBBbzhOTUxjOU53RXpJRjlnS28wYTVi?=
 =?utf-8?B?MjhlcllWbU1LanA4YVJ1cGRoTkdnZjR5aXJwdjBRRVJkTFZOSk1RQllXWWF2?=
 =?utf-8?B?N0laektRTUdhZzJ6VnRYUVk2eStPcWlHYzI1M0g5Sk1mUXR2M01TaFZsUURD?=
 =?utf-8?B?VjZuSnUvVUZoYUVBTGQ2VjhhWngwbk10UTZnUCtwamI3c2VFZnNETzdCN1c4?=
 =?utf-8?B?VG9mRmFJaTVjMklTNWZCSW9KcU1PWUxtTE1yWDhScWl4T2N6ZklXN2JvWDBM?=
 =?utf-8?B?QVJTMUl1YTdQZWgyZEhmd3VGVkoxS1hHTEJVSXdmQVNzcXBsK01nWUREZEI0?=
 =?utf-8?B?NmRhbW5DUlBBL2kyVWg3NG9zNm1mbW15ZzBucHlBZDdKOGhvVWZZQzAxZnVy?=
 =?utf-8?B?aUpSbFF1UGhVV3JoWUlRcVpseU1mYnhWT0IyQjJHL1YzcXAzdXBhcnl1OE9O?=
 =?utf-8?B?bkJBOG1uUjZyQmd6dERlUThwaG5jT2YwK0NVUVhqaTZMWUhtZUpjWXRpdG1y?=
 =?utf-8?B?MHB6b1h2VHdmcWtnSi9pWVpNYVBqUlVMSlNDZk95UEJ2TE54cFpZdGIvdWdu?=
 =?utf-8?B?bUlVNGNpYTd3clpkZlpxNGZMQUZaNWlldmZ2bnpONzV3b2NqUGgrdERKRks0?=
 =?utf-8?B?T1paV25Hc2ZlZHY5NkI5MkxFT0FNNUZMdml6dWxHSTA2Z1JWYWM0SytvK05L?=
 =?utf-8?B?MmpMVE9HeCtGNzFaUlVPY0dXNFBaSmNVdXpUYlpnNGl3cVZ3R1BQL2dxRVI4?=
 =?utf-8?B?ejNyKzBZU3RodGtwMURrRWRaTEIvTk1TcnZIc3V0ZWd0MXM0VGR1R1lNTmdY?=
 =?utf-8?B?NDJMMVRSZTlFblR0a2dxQ1ZKL3BDUlJWV01Ia3l2WXdLU3VucytibW4zUll1?=
 =?utf-8?B?WWxYQkgrWjNlaWtQU1VKRGZWeWxCSDNscUtBZXlFUzFTQlUyMXNEQ1VjOHhz?=
 =?utf-8?B?QUMxM3p6eDh0QXAxTmswNko3UXhwV3lxUmtIQXNXWUdjdGsxMHdRUTRpdnJP?=
 =?utf-8?B?c0tRU24vTkxxVHVORUxKbG9KK3VaSm9Pb1VZNW02M2kxMHB5bW9TZVhOVEFa?=
 =?utf-8?B?eFkzaEVPcWRmc2VheVl5SFg5ZE95YS9lZGRzMGlaNXlDQVN6MnpWeUlLUlRC?=
 =?utf-8?B?aVdmQjJyZmpTaEZhZ1dvemxUNGc2M0FIVU1QbXFXK3lmWnEvRFNWaFJQR0dm?=
 =?utf-8?B?NlRTWmRZaWNQajM3WEtRaGx0K1YxZVFRNkkrYVRlUVl0dnM3WUtzTzRKeHg4?=
 =?utf-8?B?cmtnalBkL1dDcmo2NUdOVXB5T09Vek85dXgwd1BzYnZPMzRIdGkwNU1HMnhm?=
 =?utf-8?B?a3dSbHJzOUhmT0pNVDUzMEs3QUhnL3FwWm1oSDcvdm8vWkVJSnhxdnFHNzVz?=
 =?utf-8?B?WlRBU04vL3RYeXdjUVNreHhWbTd4NjhOMllFeGxpWndOOHkzOEN5WmRjRlhN?=
 =?utf-8?B?bDdOYkdEbzF4MUY5TVkzMFNuYWJzT3FjOGwvN1hQYnVGQ3ovVFl1Z25RcWhK?=
 =?utf-8?B?R0ZxOWtrQXgvN2FPRjhYb2JBV1VkeHBsMFNTWnptQnhDeEtZdHB3bm80OERR?=
 =?utf-8?B?QW96d2FRb28xTFhRam56S1ZleXFDc0JVRXVCL29aenYvUlp5NHhqdEx5OUpS?=
 =?utf-8?B?OUc4bW1mZ2o3UDJaQ0hJN3NYaEV0WjVKaC9XcjloNC9HNHVqOHk3L2hBTE1F?=
 =?utf-8?B?clliK1UyR2FWS2h5VmE5M0oySjBNRGoxOUkvVi9BZkMzajVZbXl4L1BlZVhq?=
 =?utf-8?Q?aEf1RmXkXYIN/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39e45df-7fec-4257-31ab-08d920435989
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 12:39:48.8295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqvzfRPa/RcZplScUY878WNn/rikwf9WVB38oozYJSrIl2aYouSZIJEbTlo3o+Df
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
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

Am 26.05.21 um 12:10 schrieb Nirmoy Das:
> Use amdgpu_bo_vm subclass for creating BOs related to PD/PT.

I think it would be better if you just squash patch #3, #4 and #5 together.

Apart from that looks good to me, but still need to double check patch #7.

Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 43 ++++++++++++++------------
>   1 file changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f474f15ba344..2c97d67d9cfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -868,9 +868,10 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>   static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
>   			       struct amdgpu_vm *vm,
>   			       int level, bool immediate,
> -			       struct amdgpu_bo **bo)
> +			       struct amdgpu_bo_vm **vmbo)
>   {
>   	struct amdgpu_bo_param bp;
> +	struct amdgpu_bo *bo;
>   	int r;
>   
>   	memset(&bp, 0, sizeof(bp));
> @@ -881,7 +882,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
>   	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
>   	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>   		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> -	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo_vm);
>   	if (vm->use_cpu_for_update)
>   		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>   
> @@ -890,23 +891,24 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
>   	if (vm->root.base.bo)
>   		bp.resv = vm->root.base.bo->tbo.base.resv;
>   
> -	r = amdgpu_bo_create(adev, &bp, bo);
> +	r = amdgpu_bo_create_vm(adev, &bp, vmbo);
>   	if (r)
>   		return r;
>   
> +	bo = &(*vmbo)->bo;
>   	if (vm->is_compute_context && (adev->flags & AMD_IS_APU))
>   		return 0;
>   
>   	if (!bp.resv)
> -		WARN_ON(dma_resv_lock((*bo)->tbo.base.resv,
> +		WARN_ON(dma_resv_lock(bo->tbo.base.resv,
>   				      NULL));
> -	r = amdgpu_bo_create_shadow(adev, bp.size, *bo);
> +	r = amdgpu_bo_create_shadow(adev, bp.size, bo);
>   
>   	if (!bp.resv)
> -		dma_resv_unlock((*bo)->tbo.base.resv);
> +		dma_resv_unlock(bo->tbo.base.resv);
>   
>   	if (r) {
> -		amdgpu_bo_unref(bo);
> +		amdgpu_bo_unref(&bo);
>   		return r;
>   	}
>   
> @@ -933,7 +935,8 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   			       bool immediate)
>   {
>   	struct amdgpu_vm_pt *entry = cursor->entry;
> -	struct amdgpu_bo *pt;
> +	struct amdgpu_bo *pt_bo;
> +	struct amdgpu_bo_vm *pt;
>   	int r;
>   
>   	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
> @@ -957,18 +960,19 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   	/* Keep a reference to the root directory to avoid
>   	 * freeing them up in the wrong order.
>   	 */
> -	pt->parent = amdgpu_bo_ref(cursor->parent->base.bo);
> -	amdgpu_vm_bo_base_init(&entry->base, vm, pt);
> +	pt_bo = &pt->bo;
> +	pt_bo->parent = amdgpu_bo_ref(cursor->parent->base.bo);
> +	amdgpu_vm_bo_base_init(&entry->base, vm, pt_bo);
>   
> -	r = amdgpu_vm_clear_bo(adev, vm, pt, immediate);
> +	r = amdgpu_vm_clear_bo(adev, vm, pt_bo, immediate);
>   	if (r)
>   		goto error_free_pt;
>   
>   	return 0;
>   
>   error_free_pt:
> -	amdgpu_bo_unref(&pt->shadow);
> -	amdgpu_bo_unref(&pt);
> +	amdgpu_bo_unref(&pt_bo->shadow);
> +	amdgpu_bo_unref(&pt_bo);
>   	return r;
>   }
>   
> @@ -2843,7 +2847,8 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>    */
>   int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   {
> -	struct amdgpu_bo *root;
> +	struct amdgpu_bo *root_bo;
> +	struct amdgpu_bo_vm *root;
>   	int r, i;
>   
>   	vm->va = RB_ROOT_CACHED;
> @@ -2897,18 +2902,18 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   				false, &root);
>   	if (r)
>   		goto error_free_delayed;
> -
> -	r = amdgpu_bo_reserve(root, true);
> +	root_bo = &root->bo;
> +	r = amdgpu_bo_reserve(root_bo, true);
>   	if (r)
>   		goto error_free_root;
>   
> -	r = dma_resv_reserve_shared(root->tbo.base.resv, 1);
> +	r = dma_resv_reserve_shared(root_bo->tbo.base.resv, 1);
>   	if (r)
>   		goto error_unreserve;
>   
> -	amdgpu_vm_bo_base_init(&vm->root.base, vm, root);
> +	amdgpu_vm_bo_base_init(&vm->root.base, vm, root_bo);
>   
> -	r = amdgpu_vm_clear_bo(adev, vm, root, false);
> +	r = amdgpu_vm_clear_bo(adev, vm, root_bo, false);
>   	if (r)
>   		goto error_unreserve;
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
