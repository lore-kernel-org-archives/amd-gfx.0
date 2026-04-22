Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA889F9B611
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 10:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6067910E9AC;
	Wed, 22 Apr 2026 10:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n18evD8X";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAA8210E9AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 10:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peLCSA0ixEgpwZt+iWhIZJn2fZF9x3WkWwMS4dtgPwcDunI+P01NbMFwqJZUnf0ESMs9nzUiAult3gH6+ou5kfpblW8XNeorJ3lEYEa0GSl7wIEYmxTYI7zDIZHCAA3ErJi6XZoSXyNAzr2R/kTLqnqa8p3aNp7uzKu6is8I78ysnDefRo4CZUulUYn7vdanR5CvtNiiH9kQC8O48Djz+nH5i7ogP0NPNMxFKhuKE9J+Hc4sl09i5gf0nPP2/iP6tmOheQAEYQbT9Ps1PXcT+qJEpeMDEin4885o57jlDCyNkaM0gzc17ekr9JpJZMXo9wlH7xSVyikNZz58aMFgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBU0dReRM4gzMJpRGe65s5mxJyY7g7kloBc04TFxqCs=;
 b=y6LId0IZOi5BbntpfetgWLbYVPlcLrmoqnkhdOohge+dvs3v9jjRkYzckBwWKzoGJgcXjmDXeYrMLrzVRkz/aRGCaoEN53msAY2qqQw5OEjh88ktbNCaXgp+Wz0XrolUzy1sDq4CuMi5/92mPXEyqHxO7bKFKRQZNAePKOTWSDecFPLv6OmAvxINZy5urYoT5ATkNg5v51AlgaoIUmyKeDUvQ2lZZ+qEXoLQyHZ/p0QB80NFUwkGLnX4RUL4V008lG9fpBXoq997SsxwQeWOR9AhdkU0amKKMG2RLPSZMG740HZrVoJAIVk5RZ2Bw6UUsM63E8fLsEg1Toj57wsgrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBU0dReRM4gzMJpRGe65s5mxJyY7g7kloBc04TFxqCs=;
 b=n18evD8XalYQBJ5uyRafIYdA3n04X2o8pnETnkA0aIEohCrUlqv+pyelOMqyCPQUYfCbv8OiT5MQDvJ0koCgwN98BSVND3I1vkHk77Eygq4SJv7N03wXmFakDt8hVkb+IoVslIADwMqMbr0r3rbej/rMlFc9t1M1mbQRojn7+2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 22 Apr
 2026 10:36:01 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 10:36:00 +0000
Message-ID: <9271fd95-da49-49f6-a21c-fc00de5a74ed@amd.com>
Date: Wed, 22 Apr 2026 16:05:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] drm/amdgpu: fix userq hang detection and reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-7-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260421125513.4545-7-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::19) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: c19e6d34-3c7c-479a-4be8-08dea05af24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: Jz5L2aqT9vbcvH1OFVYBpfxe/Q3ybF+VLvlCs1KHnh/nCb3qwUqIeWQsvveZmmFACcVa9VA9u53aSYGVYpP48/sbO5ainZC39LnkynLY3T6ReWAPgT+vfMT6hWIziljx0ssC7Ge2l8rIFOHbw4t0bL4AYhse1wJe4CvDhFqgRED396X5xSS0KSwtkcDfiv9B+h81ZDD1nNJGac339B8Nalgq/W99kjSrFHB7kdzq2fWiqQGvKdkouVWrYGbjGA/DfZU2HX1dM1AdAiJNz1pgUDzibMxPt8/nqwZbcAlzF/ACBjAok3c0wPjVPe39B/sodeS/fk6pOgTI1haoXRVJx6p32975ShHwYc4SzAw1ksi+n5bRhWDZyy+OZcbz6qdL9TlzrE3/KKugDR9S5kRRC7bnK5PDim66QTWImaiIuLaJ3JDrIwzGMHn1Y14uWkfqR9tkbCqz1PDdSZQg+wzO6vPjwxmYNAZYk6yhf+hnQvXwSrXR8SE5W5xEFHETciQtXlIVT0geRSd/vinr6kOyO2uWv6ih6eMQ+P7CgVr2bXHEPsd0dBi9S87lHj3gPmV0EosLTQnelSLbjJuNSblShLQ83hVsziXPsG8jiwNhsRmSsSNJuBuIthcwlL3g/i6l9EbPahiYXvgfT+ssmY5RZYfhRVbRHQfgT6hxvX3EA7hIf7rZvBPI3/zjigs/XG9V3izgAWRvAyB3C0UXeL8KxaHuEY6SDWuxePKfRZXzhk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW9rUHBTNmp0NThFUnJOQzVZblVpN1BnbDQ0bzdMRGdJa1E0V2lqOUkxalhr?=
 =?utf-8?B?dk5lVHFvdkNxU3lvT2l1MFhSemh2ZWJZZWZLSXFTOHhodE1ZWFR5S1kyNDlM?=
 =?utf-8?B?d0pRYUpQTE5kc0htRmdPWkhLSm5sd3dXQVN1dFhTSEtjMDlxVW9PK3ZwdVNm?=
 =?utf-8?B?VmZiQjZaTjZHUnQwRlRGZWg0SFRjbHk2dkNCS3JxeGpCUVYrZ3NmQVBmVk1J?=
 =?utf-8?B?ZHhVTkpuN0JTMk1zZzhWTFcvbXEvaTdVdmxmTktJTFEvc2dVN0RhR1pycUwr?=
 =?utf-8?B?RUdydHVoaXorUktrWDNhakhZNlllTVIwR25nRExjOUlBb3Zsc2tFaGcySzJ2?=
 =?utf-8?B?dGZIeFh3cGcvQ0hML2dMWVNvbkVxVU9rbGJMMkVSQjBraXQvQ0tEUVlRWUU5?=
 =?utf-8?B?RTRxYk9HQ3R6d2ptQm15R1ErN1pyV1NGNGtCcDVvUkI3ZDZQTStFWWl0YU9C?=
 =?utf-8?B?blpvQWdmem44VFZLWElObDMrYldodGNhWjVVREV1dXZMcFM5aCszVzU1ZWVC?=
 =?utf-8?B?dXowTHFPaFJIWkl3M2lyUWdlR05MWFNvWndVMzhrTm5aUmZrQTk3RkNtdStw?=
 =?utf-8?B?dnRSU3lGK09TWlVFaDNad2IzRGN4eXo4blM5RmlrYzJPazZ2d0F1Wk8rVFJF?=
 =?utf-8?B?KzN1TVlDYWt3clluUW1nTzVuWVlWQUVpdWZSTVJRbGhldjNYMCtHUS9hTDVS?=
 =?utf-8?B?bklsT2RHTE84VS90UHk0ZzI1RGc5bGlKSFlta1NiQmxNWjNScG9vL0hFZUh4?=
 =?utf-8?B?djlncWdKSkp6QjFsNzd2RmVLdEViV3RVdGc3MW5GYjY3N2c0ZUpmeGVuQXBu?=
 =?utf-8?B?WGJVakF5UE5zYXcvdzljU2RrVFVoMUxJU1VydzdvS2pCUGgvL1phZndmcDJ4?=
 =?utf-8?B?OHdCZkFYWHprV3cvWTlmbUpkOURyQ1hEWDZzcjVNVEV5WC8wVE15WEd6L3lD?=
 =?utf-8?B?T2NHWWRRL3c3VjdFV2lKMXZHOXBWbUVXeFJZMWpWNnI5K3h5OVJndWsxb2to?=
 =?utf-8?B?bEEyNUpsRWVHNDBURlZxazg5ZVFrbUk3RDJaSkRFeGd6VGxiWmRlRGtRdHFW?=
 =?utf-8?B?bHpWR2FtQjhRQmFOdzMvd0lFWDZNV2ZVMDB2YjNrV2RjTHF1TnRJekIyM2Fj?=
 =?utf-8?B?VTZBWUJTTnJjdVBxRmhzZ0VmS1pBMFRQR3ZOMFptbUdsc1VuMzNjNFRmN3dQ?=
 =?utf-8?B?YzN4aGx5aCtETXdUR2dIZEJlNmVsK0l6b002ZC9lTWdoL05vZU1VWFNPVHRB?=
 =?utf-8?B?b1B1UEd0SjRLa2JYNzJOc2Y1ajJVSkI4TmhuYkFqa2V2MURnVytMT0JVejlO?=
 =?utf-8?B?eWZGSXIxd2FNaUI3dXRFTStQVElYRUJTZjEzcFdyalRKMnVENEcyTGcvb0Fa?=
 =?utf-8?B?T0V4WHFramQ1TFlpdkNFVlp0YjlobTV2cEJQMnZxQzdocnl0ZU9DdWxKdXZN?=
 =?utf-8?B?Zzk1OXU4RXIwL3Fhem1hZEE0TWd6UFVNWjFQRmVGWkdIdTVqSVZxRk5TOGdu?=
 =?utf-8?B?eDgxbFp4L2h4aHc3SGlLQ0plMWFFN1hpR21wQlZweWdOOVRKOU8rakUwT2hL?=
 =?utf-8?B?bUlabFJ3RXhEM2hBY0NWaWtNNGZGcEZPdThuY1VxanpuRkt3NlEzazdhMlNv?=
 =?utf-8?B?aWNsVUhhZERIOWJWdS9UbGljU1pRMXNRNUU3RlFpb1J5YmloZkJKMHBZdHpQ?=
 =?utf-8?B?cW4xa1ZramU3c3hJWXl5em02MnZGV3ZQUEFoUFdrd01hSnVTWHd5NW9OekdT?=
 =?utf-8?B?akNPVnU3ZUNXM2hSV3VOZk1USG42UVI1S20rRTdrUU44YUVnMHN3SVpQcXh6?=
 =?utf-8?B?WTRBL3UzOWovRUZoOGdOWTFFdTdJV1JlOWVySWROb2JUdUttamtseDNVcjFG?=
 =?utf-8?B?K3lZMDhZd0xxZ2tBdkViSUpSOVQ4MHVTRjN3WlV2Tll6M1pPVmlTcVlFVlpn?=
 =?utf-8?B?MHRYQTQxZzBSTkxSSXVBbjNESWMySUVQNWtPWm56TUtnUFRnczRMUkV6bmtR?=
 =?utf-8?B?SjM1T0h3VmdhWGdXYzRYWGNEcWJEZ0d3cG9MSVdiZmg3NmEvY3NVRW1oSUwx?=
 =?utf-8?B?NjU4STR0bk9ybmNPdXNkVEk3OTQ5blhTSXc0Qms5SnZNNVRpaUhVcmJGVGRU?=
 =?utf-8?B?QmVhZytRV1doVytZK1FiSkZUckVEZGxnaDdwQy9RMTVYckZtUUJuMzZWSmY2?=
 =?utf-8?B?QURSVm5oZ2diYnRSWWVkZkM0Tm5HRjI0a3RDaXRwRmw5eWUvUE4rUmhvcWdO?=
 =?utf-8?B?cjA5MjZCZmg5YWR6blpBcUthTVYyM3JkVWthMVhYdENERkFIcmFkeFZTTDMx?=
 =?utf-8?B?OVZNMGc0SXk1eklKamF4Nm1WTWJyZnNWRUdKMU00R3ozNWdYVUx3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19e6d34-3c7c-479a-4be8-08dea05af24e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 10:36:00.7492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R263IUuOHGX2JmaSw1nuc9aYNJya6KKKSZvVx6oIyxKBJmiJHt8bDNrFvTy78q+6lMMErFYqaNFwq6EgsFvvGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 21-04-2026 06:25 pm, Christian König wrote:
> Fix lock inversions pointed out by Prike and Sunil. The hang detection
> timeout *CAN'T* grab locks under which we wait for fences, especially
> not the userq_mutex lock.
>
> Then instead of this completely broken handling with the
> hang_detect_fence just cancel the work when fences are processed and
> re-start if necessary.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 65 ++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  1 -
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 17 +++--
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  2 +-
>   4 files changed, 40 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 5ccd53ad8efd..0a4c39d83adc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -106,9 +106,6 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>   	int r = 0;
>   	int i;
>   
> -	/* Warning if current process mutex is not held */
> -	WARN_ON(!mutex_is_locked(&uq_mgr->userq_mutex));
> -
>   	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
>   		dev_err(adev->dev, "userq reset disabled by debug mask\n");
>   		return 0;
> @@ -127,9 +124,11 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>   	 */
>   	for (i = 0; i < num_queue_types; i++) {
>   		int ring_type = queue_types[i];
> -		const struct amdgpu_userq_funcs *funcs = adev->userq_funcs[ring_type];
> +		const struct amdgpu_userq_funcs *funcs =
> +			adev->userq_funcs[ring_type];
>   
> -		if (!amdgpu_userq_is_reset_type_supported(adev, ring_type, AMDGPU_RESET_TYPE_PER_QUEUE))
> +		if (!amdgpu_userq_is_reset_type_supported(adev, ring_type,
> +							  AMDGPU_RESET_TYPE_PER_QUEUE))
>   				continue;
>   
>   		if (atomic_read(&uq_mgr->userq_count[ring_type]) > 0 &&
> @@ -150,38 +149,22 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>   
>   static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>   {
> -	struct amdgpu_usermode_queue *queue = container_of(work,
> -							  struct amdgpu_usermode_queue,
> -							  hang_detect_work.work);
> -	struct dma_fence *fence;
> -	struct amdgpu_userq_mgr *uq_mgr;
> -
> -	if (!queue->userq_mgr)
> -		return;
> -
> -	uq_mgr = queue->userq_mgr;
> -	fence = READ_ONCE(queue->hang_detect_fence);
> -	/* Fence already signaled – no action needed */
> -	if (!fence || dma_fence_is_signaled(fence))
> -		return;
> +	struct amdgpu_usermode_queue *queue =
> +		container_of(work, struct amdgpu_usermode_queue,
> +			     hang_detect_work.work);
>   
> -	mutex_lock(&uq_mgr->userq_mutex);
> -	amdgpu_userq_detect_and_reset_queues(uq_mgr);
> -	mutex_unlock(&uq_mgr->userq_mutex);
> +	amdgpu_userq_detect_and_reset_queues(queue->userq_mgr);
>   }
>   
>   /*
>    * Start hang detection for a user queue fence. A delayed work will be scheduled
> - * to check if the fence is still pending after the timeout period.
> -*/
> + * to reset the queues when the fence doesn't signal in time.
> + */
>   void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
>   {
>   	struct amdgpu_device *adev;
>   	unsigned long timeout_ms;
>   
> -	if (!queue || !queue->userq_mgr || !queue->userq_mgr->adev)
> -		return;
> -
>   	adev = queue->userq_mgr->adev;
>   	/* Determine timeout based on queue type */
>   	switch (queue->queue_type) {
> @@ -199,8 +182,6 @@ void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
>   		break;
>   	}
>   
> -	/* Store the fence to monitor and schedule hang detection */
> -	WRITE_ONCE(queue->hang_detect_fence, queue->last_fence);
>   	schedule_delayed_work(&queue->hang_detect_work,
>   		     msecs_to_jiffies(timeout_ms));
>   }
> @@ -210,18 +191,24 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
>   	struct xarray *xa = &adev->userq_doorbell_xa;
>   	struct amdgpu_usermode_queue *queue;
>   	unsigned long flags;
> +	int r;
>   
>   	xa_lock_irqsave(xa, flags);
>   	queue = xa_load(xa, doorbell);
> -	if (queue)
> -		amdgpu_userq_fence_driver_process(queue->fence_drv);
> -	xa_unlock_irqrestore(xa, flags);
> -}
> +	if (queue) {
> +		r = amdgpu_userq_fence_driver_process(queue->fence_drv);
> +		/*
> +		 * We are in interrupt context here, this *can't* wait for
> +		 * reset work to finish.
> +		 */
> +		if (r >= 0)
> +			cancel_delayed_work(&queue->hang_detect_work);
>   
> -static void amdgpu_userq_init_hang_detect_work(struct amdgpu_usermode_queue *queue)
> -{
> -	INIT_DELAYED_WORK(&queue->hang_detect_work, amdgpu_userq_hang_detect_work);
> -	queue->hang_detect_fence = NULL;
> +		/* Restart the timer when there are still fences pending */
> +		if (r == 1)
> +			amdgpu_userq_start_hang_detect_work(queue);
> +	}
> +	xa_unlock_irqrestore(xa, flags);
>   }
>   
>   static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
> @@ -640,7 +627,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>   	amdgpu_bo_unreserve(vm->root.bo);
>   
>   	mutex_lock(&uq_mgr->userq_mutex);
> -	queue->hang_detect_fence = NULL;
>   	amdgpu_userq_wait_for_last_fence(queue);
>   
>   #if defined(CONFIG_DEBUG_FS)
> @@ -853,7 +839,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	up_read(&adev->reset_domain->sem);
>   
>   	amdgpu_debugfs_userq_init(filp, queue, qid);
> -	amdgpu_userq_init_hang_detect_work(queue);
> +	INIT_DELAYED_WORK(&queue->hang_detect_work,
> +			  amdgpu_userq_hang_detect_work);
>   
>   	args->out.queue_id = qid;
>   	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 843ea8ecc5d7..85f460e7c31b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -85,7 +85,6 @@ struct amdgpu_usermode_queue {
>   	int			priority;
>   	struct dentry		*debugfs_queue;
>   	struct delayed_work hang_detect_work;
> -	struct dma_fence *hang_detect_fence;
>   	struct kref		refcount;
>   
>   	struct list_head	userq_va_list;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index b0543fa257ed..beb2a1f679b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -141,7 +141,14 @@ amdgpu_userq_fence_put_fence_drv_refs(struct amdgpu_userq_fence *userq_fence)
>   	userq_fence->fence_drv = NULL;
>   }
>   
> -void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
> +/*
> + * Returns:
> + * -ENOENT when no fences were processes
> + * 1 when more fences are pending
> + * 0 when no fences are pending any more
> + */
> +int
> +amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>   {
>   	struct amdgpu_userq_fence *userq_fence, *tmp;
>   	LIST_HEAD(to_be_signaled);
> @@ -149,9 +156,6 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>   	unsigned long flags;
>   	u64 rptr;
>   
> -	if (!fence_drv)
> -		return;
> -
>   	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>   	rptr = amdgpu_userq_fence_read(fence_drv);
>   
> @@ -164,6 +168,9 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>   				&userq_fence->link);
>   	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>   
> +	if (list_empty(&to_be_signaled))
> +		return -ENOENT;
> +
>   	list_for_each_entry_safe(userq_fence, tmp, &to_be_signaled, link) {
>   		fence = &userq_fence->base;
>   		list_del_init(&userq_fence->link);
> @@ -176,6 +183,8 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>   		dma_fence_put(fence);
>   	}
>   
> +	/* That doesn't need to be accurate so no locking */
> +	return list_empty(&fence_drv->fences) ? 0 : 1;
>   }
>   
>   void amdgpu_userq_fence_driver_destroy(struct kref *ref)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index d355a0eecc07..0bd51616cef1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -63,7 +63,7 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
>   int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   				    struct amdgpu_userq_fence_driver **fence_drv_req);
>   void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
> -void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
> +int amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
>   void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
>   void amdgpu_userq_fence_driver_destroy(struct kref *ref);
>   int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
