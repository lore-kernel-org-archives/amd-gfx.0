Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586CEC7EE2C
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 11:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D623C10E671;
	Fri,  2 Jun 2023 11:54:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C44110E670
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 11:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4hSX/rdvQR80g81PqRI5QLFmrKv+y/dJgtXEBSvStDjOBQM2wOc7alxFDr29jYIlSJ+3hQkbtmAMXW4Vpur08UZHur7RYeWJold6KtHl8H8M2/aqPgrzgvJIOdhNRBfwllNGOMOSx8lcw8f6oGem/yGQJAMqSqpN/rO5xZ7O/SnOBK9iiTYhBjezNCe14FOrfS2wiFgWHgeWGtxKlf0+rS5QmtJCq6AH2gChRbzjWd3tvEGPLi4sWX6eY1tYlVWXOX7NumWZlHx1/7GWGIu53hQXlQuZ51vt9DaFkoJMBUm2NyLKwNIH77p8be2ucNpOjDBccNN8+CqQ255C9wlog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXMwXZoYv9vwmxwJqAxxpWlcNMJgHdvaOjtaZIHYAkI=;
 b=KnTWOYM+FFLioC0Xi/ceSw3ry9w1OQkKAAwRXT1sRfHcYznoE3bALgSKAkqy5laEsVM3OLu4rSAwQPqG4Z1u/6L96ICKQBd1b2ZNDCibvNwkPzLGVb4D48M0LoSNRUJKAN/j/JqBLu0hauiSrqGdTtmUOqbdaOHYhNdFfBHG8LWFKZHHrdLcshuB/T9W/crlAPqPzSfSdwFgKNChPs1RmDhPBUZ8xS1U6RozzMlKtrTtTWusgOcwhEerLPBoVrih60e6x4Etoe5ETO7ywT/VkJ31yN3FrgrUZfoVA51QoM7TIpbJZUPDBo017a8RssAEGgUZpoV0wTx5Eb3b+l08Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXMwXZoYv9vwmxwJqAxxpWlcNMJgHdvaOjtaZIHYAkI=;
 b=CK+DUL4ZztBXgwYmeKvouBhBDvIdLTRj0qQp6I5PzZCxPFMVppIvFGkELgdjB4QuJA8jPgQTTlZUp3/Y7S7oy3V7hNm/bsWKZ4br/cXnCGkmPuOn2ZbVG6kYTWk5oJQcXqwL6On0j2D7A9Thi8lt5hMuq9Y3k3pcM5TRKeR1SlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 11:54:35 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::907f:26e2:673a:2ad2]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::907f:26e2:673a:2ad2%6]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 11:54:35 +0000
Message-ID: <3e5d1f84-c5b1-5110-d047-93693b0fffff@amd.com>
Date: Fri, 2 Jun 2023 13:54:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] drm/amdgpu: Implement page table BO fence
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230601193117.13143-1-Philip.Yang@amd.com>
 <20230601193117.13143-2-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230601193117.13143-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e508a53-9d5a-42ba-1f4b-08db6360228c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjMCfMjUqd255iCgFeRuNo1nW8Z8OxKi8Xn+/MTPretFehqy0n9xXyBpRXRo1jspWdwp0WfZjbDvtbluSihv7AmGgIJKNHppObcQ08tAFVyzaE/MBc6qe62SKkHCBi/+R1PVXXKmU6VWoFnBgcRkwZffntqYxEYhDXW6JubgQq/ehEJPWsy4jbC6rRQCsX3nS9OYnBudMiZsnCpuLblM0EchBnRxAdry5gh3BauOc2eR8hzjC2xT7PCKK6gqTp+l4lSzyky+4B0ghbiuztM+0TTSVL4JTjDJ6IRYp8tzhJdbUX0wrkeLKh76w7XGHLKmC1odItJueDIoWxZEFjmnoTdYExBNUlWhqqqSD6ya/N7hjp0NehvfnRH5b+0DlM98TkYWT95GOpERN8/aba7L1JT4Vaxr5t2EjiiBXkRaKd1eMQsn+el6D1d/16eqf7GSlXa/kEMTp+qqgAEFPmfCx9S2zqDw8XJtorXG76JL2hy95cbUjY5G5y2yzxbnG3XgxFkINNXAyv3b5yABfsHSkUCFflJnQJr1cKyoFu1GhusGY+phj7jWUmGY2XARODjtkyJvfwM//LRU7mOWnQQvAx/Abg8K0U+I4hlJe1Y239ABc2iGjlrzxV+yqni6N+NV1y5ladne/sJBJQYZgmgx0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(66556008)(66946007)(31686004)(66476007)(316002)(41300700001)(4326008)(8936002)(5660300002)(2906002)(8676002)(6486002)(6666004)(478600001)(6506007)(83380400001)(36756003)(186003)(2616005)(86362001)(6512007)(31696002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0g3MHo0TGptYU5EOWdIV2h5blBlQTczUVB0a1M3R2tCTlYvVGpJVXMrWFFE?=
 =?utf-8?B?UzMzNnBNTUJDeVEvdXkvamVkTTNicU1hcXUwMjMwcWxWZ1VKN3dkcHo2WXlv?=
 =?utf-8?B?OGJXN21wMEVoWGR0VXB4OWp2K0NLM0RFaW5pSkdRN0xOZ2ZpVnEwSjFXa0Zl?=
 =?utf-8?B?M0RNQm1KenJtc0RFYkc2M0xvYWZCek40aE9tR2YwYWRtancrekQyaFNiZEtY?=
 =?utf-8?B?M3BWazJ4cGd1bGNRbTBPeFZRNG1xdUM3L2lCRWsyQUFHMDZvUjNEemlxYzF4?=
 =?utf-8?B?NndoSkk5SE5reTFLV2pvcE1MQ0V3a1M3MjcrUEdCam0vMDRFTE9KaVBmVEU0?=
 =?utf-8?B?dFBmMWZOSjhHZWxNQWZZMmcrYWV2eWlLM2VLeVlUZ3JzK3EvVlNZM0hHYkhG?=
 =?utf-8?B?Yk5mSENBZm1qd0c4NldENUhQRDdzSndjbHBhL2xCZzZ0NE0xdXZpKzg0am53?=
 =?utf-8?B?U3kzNnVUVVVBUjZ3MkNOWk1QV1F4N0toL05RblJHV1BpR3BKS2laNkM0Qm5W?=
 =?utf-8?B?T05WZjkwNDRUR01FVk5UUW9GSTBQczAxRjQwV1pweVlJVXlBWjdWN3U3Nnpp?=
 =?utf-8?B?cUNOU0JLQ0xyb1J6bnNUSStNTGExRmkyREVGQXZIRHZ6SXNUL1JPRWpoVmoy?=
 =?utf-8?B?R1AvUGVOSXJBSkdDcDArb0RMWEZkeVdOSmZvbmdpTUxvUHlVRnpyL3c2VjBQ?=
 =?utf-8?B?em9uTGlGTWpXMk9Ec2FuN2V2d2o5NUYrQ20vek1ubmN0eXVkbTZiRm1nUCtW?=
 =?utf-8?B?YzcxMTQzTHNSWFpMQmg3ZWNRNTNxQWxZYzRJZ1JOc0N4TE52dDU5MVo4VGFS?=
 =?utf-8?B?WjJqVVM1RUVSaHhlUE5wTit3MXRhY09lTEppY0psaDFSZzBvL2dFNDhPWS9n?=
 =?utf-8?B?RnladUpWYnhvL3FPbU9jMkdQYnFxRCtuM3RXOFoyK0k2bnd6dDFqYnphZUtF?=
 =?utf-8?B?eC9ITFM1dWdoZ1J1VnpDVkVsdDhpOTVQSit2NUtKRm96SEgwM2pKTkVhWkJw?=
 =?utf-8?B?THlpQTNXU056ak0vbHZXNElha2N6b2ptR2xDWDArZTVqWVNqTzIraDhzQzFZ?=
 =?utf-8?B?MmRvSHZEeCtjd1NUSVdtRFY3aU1TeG9OVFJmb3pFc2FPMGQwaC9RQjhMZ2to?=
 =?utf-8?B?ZFJTRzR3dXVaNm4xZWNLWkpCbThOU1JpRjI2ZXBzajNLMVlFK1VlL1lhdmlh?=
 =?utf-8?B?QjVTNmFJV3lPd3dPbU5WWkFnaW84S3pwV282d0xJRk92ZHJ5QXpvcTlmWEp2?=
 =?utf-8?B?L2VYU2hKOWk0MmpTMkllelI2VEloNzhSYjdjSVR1UFROcTBiZE1kdjZaaUo2?=
 =?utf-8?B?K1V4QXZxMDZGdFZERWxvQlJLR2k4SklZVUhseDArRXpLYmxCcm5IOTlYY1Fw?=
 =?utf-8?B?dS9tLzJMYTBHaUpjRTgybm5RdFlOTW41MHg2aFkrSmJRVjVVZXhwOEs1c3BI?=
 =?utf-8?B?YjRBWDFjMXphOUgzbDRXdHFwdks1dzEvOCs3SG0rMGZBb0E0ZG9ibjBPeFdG?=
 =?utf-8?B?bllFeGt2Vkg2Nm1nMHI3aGJ2WXgzRCtGSUJhWUZCWTNSME8vUnpJWUtHSkpT?=
 =?utf-8?B?THRDWitqQTVKTDd5OUxrL2xoMWpDbVE0YXREeEt2TGk0bHBKeGY0eCsxbTE4?=
 =?utf-8?B?d1dvMEJETlI4bkJGK3JGODZCY3JwUGJGVnpLNWdTTUFCM0lPNTdDRjMwc1Uz?=
 =?utf-8?B?UnFBb2FKdnB4SWt0K2FLL3JQeGV4UUVCbkY5Vi93QUorWS9CU1p3aS9HVEc5?=
 =?utf-8?B?Z1ZzVjllM05UUUJzZGF5WjhpUkYxS0VxWEpSWHhXc1dyMVk0RGxvTEsrUFdK?=
 =?utf-8?B?S2pTVzBQQVM5VzhFYi9tQTIvVVN0elZXSHpXbHpqOHVMcjdIc3hJUUZCRmw3?=
 =?utf-8?B?RThSRmR6WDhLWk1NRzJRSnJpNmg5cUJBMldTUGx1OEFXUWlqTzJTK0NEVDI1?=
 =?utf-8?B?UXZqWUtJNlBVT3p6YW0vV2tqTGxJRjY1eERJU3ZCSUt3Z2xaczZEV0NJc2Jj?=
 =?utf-8?B?aGZWcUVTc0kxYXRIL01CT2t1NVgwWUJGeThScEcxY2RKZHRwZERFeVdLbUM3?=
 =?utf-8?B?eUVaMHlJaEdSQlY5TDFWZVdyRDQ3NVg4aHhJQklJZE8yakFFSCtOYVRTSmZ4?=
 =?utf-8?B?K0pUT0t3S3pnM0Voek5PS0YwbGVnRXNuWlV2L0R4a3NrdEgxSkFVSzlZd04x?=
 =?utf-8?Q?hcnXQZDFDoXcbVit1qDLCA2ThjOpLMFR864CD8r9+Yzc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e508a53-9d5a-42ba-1f4b-08db6360228c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 11:54:35.2851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuAY/3fBCmjUBIzUNLXlcpcZt+IWCUYJRbd5wMa5V3G1mkC6kACjwb3f2gyxV0lY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.06.23 um 21:31 schrieb Philip Yang:
> Add pt_fence to amdgpu vm structure and implement helper functions. This
> fence will be shared by all page table BOs of the same amdgpu vm.

Well first of all please don't add anything to amdgpu.h or 
amdgpu_fence.* This should probably all go into a new file.

Then that approach here won't work like this, but I'm going to comment 
on the other patches.

Christian.

>
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 45 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  1 +
>   4 files changed, 52 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5af954abd5ba..09c116dfda31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1499,6 +1499,8 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
>   int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
>   			       enum amd_powergating_state state);
>   
> +struct dma_fence *amdgpu_pt_fence_create(void);
> +
>   static inline bool amdgpu_device_has_timeouts_enabled(struct amdgpu_device *adev)
>   {
>   	return amdgpu_gpu_recovery != 0 &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index c694b41f6461..d9bfb0af3a09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -57,6 +57,16 @@ struct amdgpu_fence {
>   	ktime_t				start_timestamp;
>   };
>   
> +/*
> + * Page table BO fence
> + * Fence used to ensure page table BOs are freed after TLB is flushed, to avoid
> + * H/W access corrupted data if the freed BO page is reused.
> + */
> +struct amdgpu_pt_fence {
> +	struct dma_fence base;
> +	spinlock_t lock;
> +};
> +
>   static struct kmem_cache *amdgpu_fence_slab;
>   
>   int amdgpu_fence_slab_init(void)
> @@ -79,6 +89,7 @@ void amdgpu_fence_slab_fini(void)
>    */
>   static const struct dma_fence_ops amdgpu_fence_ops;
>   static const struct dma_fence_ops amdgpu_job_fence_ops;
> +static const struct dma_fence_ops amdgpu_pt_fence_ops;
>   static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>   {
>   	struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
> @@ -852,6 +863,40 @@ static const struct dma_fence_ops amdgpu_job_fence_ops = {
>   	.release = amdgpu_job_fence_release,
>   };
>   
> +static atomic_t pt_fence_seq = ATOMIC_INIT(0);
> +
> +struct dma_fence *amdgpu_pt_fence_create(void)
> +{
> +	struct amdgpu_pt_fence *fence;
> +
> +	fence = kzalloc(sizeof(*fence), GFP_KERNEL);
> +	if (!fence)
> +		return NULL;
> +
> +	spin_lock_init(&fence->lock);
> +	dma_fence_init(&fence->base, &amdgpu_pt_fence_ops, &fence->lock,
> +		       dma_fence_context_alloc(1), atomic_inc_return(&pt_fence_seq));
> +
> +	dma_fence_get(&fence->base);
> +	return &fence->base;
> +}
> +
> +static const char *amdgpu_pt_fence_get_timeline_name(struct dma_fence *f)
> +{
> +	return "pt_fence_timeline";
> +}
> +
> +static void amdgpu_pt_fence_release(struct dma_fence *f)
> +{
> +	kfree_rcu(f, rcu);
> +}
> +
> +static const struct dma_fence_ops amdgpu_pt_fence_ops = {
> +	.get_driver_name = amdgpu_fence_get_driver_name,
> +	.get_timeline_name = amdgpu_pt_fence_get_timeline_name,
> +	.release = amdgpu_pt_fence_release,
> +};
> +
>   /*
>    * Fence debugfs
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 37b9d8a8dbec..0219398e625c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2147,6 +2147,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   		vm->update_funcs = &amdgpu_vm_sdma_funcs;
>   
>   	vm->last_update = dma_fence_get_stub();
> +	vm->pt_fence = amdgpu_pt_fence_create();
>   	vm->last_unlocked = dma_fence_get_stub();
>   	vm->last_tlb_flush = dma_fence_get_stub();
>   	vm->generation = 0;
> @@ -2270,6 +2271,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	dma_fence_put(vm->last_update);
>   	vm->last_update = dma_fence_get_stub();
> +	dma_fence_put(vm->pt_fence);
> +	vm->pt_fence = amdgpu_pt_fence_create();
>   	vm->is_compute_context = true;
>   
>   	/* Free the shadow bo for compute VM */
> @@ -2358,6 +2361,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	}
>   
>   	dma_fence_put(vm->last_update);
> +	dma_fence_put(vm->pt_fence);
>   	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
>   		amdgpu_vmid_free_reserved(adev, vm, i);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index d551fca1780e..9cc729358612 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -286,6 +286,7 @@ struct amdgpu_vm {
>   	/* contains the page directory */
>   	struct amdgpu_vm_bo_base     root;
>   	struct dma_fence	*last_update;
> +	struct dma_fence	*pt_fence;
>   
>   	/* Scheduler entities for page table updates */
>   	struct drm_sched_entity	immediate;

