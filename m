Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7E6FD5F97
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 08:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CBBD10E584;
	Wed,  8 Apr 2026 08:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YZemLWvB";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5710B10E589
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 08:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPf4doa8FPcnXobUH8+gnHPJZFI1trkaFPMkJcy3nG772MRtT92U7c9kNKrnjt6tK12uNR/cETIHwOvGu5TrWoMKCRcIzobCXbfE/IIDxsv7LzfZLyFKoSd4rN70vuArjXDXzqnpiaKo+48MeeueLo5xn7E22tRdNtxnsFuJpf7EYUeZYDl40oeoV2uiGEd/QYIt2Kqj9RuR5Rm7BBJD/heIsa6Yzg+hSLV/7WgvV5flh5ivtKOHANRjjyEBQWiB6hQAhSR5eJcXYafcxp/INz+M3+gy10IT2YFj+m36JsaBOfZFtVtjXdXJMujMO7hN4oOM6uuflJ3XnXFKf+Nd6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gVUEdjgnI/52LAxl5vSRYPDH735b5CtmbzrEEBsTaw=;
 b=H8ac+3okThBjzck1Uw0NziaBW9ryvgYM+VElfUvFlzUBv03WQ4Ptr9ASc7rccxk2qWBWnWlAzgHp0LL7W00E0nfAsJjqn6Go7kjzSb0wwWlCyUBtcdK1TkitQAXttOEThnk8Qi6h2ORgtVgNMO4FIdXFJNBFb7rhDsh71fPrx4lNJ3tn117hubuqujlxtuqhEhJFexeY/Xzq7Vpd3QFKwW5teDD5JUmXXnDP9FIYaYihK83La6tlPKc+FG1iEHEmUZlPD+7cpGS35dIHNpuNgBbReTxLml0qwguSmdtsD9ElQPbIRt1MYqlr6bFJXKXWjAAzO44M7VU3wVEtj/vrxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gVUEdjgnI/52LAxl5vSRYPDH735b5CtmbzrEEBsTaw=;
 b=YZemLWvBgBsDnpw2vb0GhgdWRMitd65LBNHnEnASJjUo5dF9eIqTuFeQVGZ6maXvMN2dvbbbPF7Uor7SOIXxD1+aKsNRqUC+Iwh8xsQhzQxyv1CA69wIcO2jtQM7tVqB8SQWe/yfwuFPbGlbGTX3fmO3I5d5BNDm029vSnjRJ/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 08:33:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 08:33:04 +0000
Message-ID: <003d5670-0e77-4f09-8784-45511dfbd5a3@amd.com>
Date: Wed, 8 Apr 2026 10:32:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] drm/amdgpu/userq: unblock signal ioctl from userq_mutex
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260408083009.3328380-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408083009.3328380-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0380.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d36ad5f-26dc-4874-91d5-08de954973bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: D3QNMo3nYIwQJQfPmPJK5OB8CmFB+2piuBsU6zXVyDBtGO6QRTndlMyg+JcpGmIX0Pds3LqFVqmfhTGYleBB3MWfj4eMxbkzUr+3mwwhD0ZXXFUjqkE8fDvgLaNQUJ4v5o6ukBFjzoYr6G456Z6aupsiJ9wkGABG/rF5IDor3ZnRoWw+9gkSI7k8OUVftNmLDYl17cfWcVWHizLFXHN/NnA6pIPfrsUWk0bvqh56GW2BdUqey6AYs3ZuSBgH/fSTD2XKqmOjiuDPKVovR+xTKE0PXM+h0IoidqwzxlsecLjBnbNZ8ZPv9RVtfenk6VhSbmiOdaSdRi8/y0WcOEzzXdQHyPufEfTz7wHBRG4cNgl09L0G3Gg+uxqkU7/Rc1dBHP41kxB74suL3LuyKuT6PzPTZvp3KA9PHC25trCntaYV0aukKp7Hl3uWH78KJtX148oqkQFLyEBnyPtqNkGO+jtnsCOB4lAgOjKSi07e5LviyRwRwYwiA8MJpfzepGQn4GCrmJrgPNHtzfzVqU3j9U3/E6iSm5vVSxIdhzN4jOtrDzREJLr1JytKULGAI9L55AOo6r4MqemFmoEZ/P5X8ka67M9HZCYhfkHxsmHcWDz96fPC28VZjc/tpU3PWNWf6xf7hsQrL1dcj+F2F5WeRb4fZpMAWmJjrBLgSKN+4ktAYdiblKKnQye1DzaqaviDkc2t1YUDsRJxOmL5xjBaDx4e7rQmDEZvm0xb0qHPuXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REU2cjgxQXVpNE1ER08yazFzRFVBVVV2aDhCbENRUmFzZlRmd0N5a0lrM0o4?=
 =?utf-8?B?M3RlbWlKVndXY2d5T3czUE82NUY1SlA2VWN6S3NYdGgyUkQ2Y0ZTZUt0ZjBU?=
 =?utf-8?B?M1dUV1FDYzgwWXo0UFlDS1pwL0dWRTFxU1pZVWZnTXBnbU41c3F2aUMzcmlO?=
 =?utf-8?B?TFdqNHAvanZTWlp6OEE2Vno0YStaMnFYSnk0ZGx3Y3hWdGlwak4wWGFadGNv?=
 =?utf-8?B?aDZNbnF4YXk4MlUzUkpRT0MwTFFuL2tqNTZqdEVkN1doaks3M2JrSlBKaStZ?=
 =?utf-8?B?ektVTXZoMDRMS0dUSk5CRUtPSEo3WVFWdEswd29qbnBtZ0VVZzNETzc5WVVp?=
 =?utf-8?B?SkxLekxNa3BBZlFrd2QrQjJ5YVlwMnNLTC9rNUZxWjM5eE4yTHlpMURuV1l3?=
 =?utf-8?B?UEVMRFJPL1FVMjkxd2F1Sjhlb3FYbEh5VFlCbU1KRFExaXNUVmd6WHFwcDZ5?=
 =?utf-8?B?dHlqa3hSZm9kMFZvemZzeWZ1YnRFTndWMzZUTUF4MnhsWVdLQndpN0ZHdGZq?=
 =?utf-8?B?Tml0OWVyMW11djJiaW5KT1FFWEhneEZWMVZvNEQ5ck5GMGtySnlXdGJsVE5V?=
 =?utf-8?B?cHBLejFDcFlzN3gyc3phZ3BTWEc0cDE5NDFVaUc3ZkFHREZYR2tsZ2NCa3I0?=
 =?utf-8?B?V0FvRitzZFViSGNyRGdGTWRRRXZqRmRTa2plOHU0MHlOYjJrZXp4TDVpQXEx?=
 =?utf-8?B?ZEJNUmNaZXg4SXZvTEZLZmhnSVN1bCtkamp6TWlJMHF1eGcrQjFxQ2tkTnlu?=
 =?utf-8?B?V3kvaGM2NEFQTVhtbkRBcEw3RlFZeUtHcDNiTUUrR3Vpc1pHdjlJMkFMajNj?=
 =?utf-8?B?eUlHWjRudC9kR1d2RXZsRnB6TWZnUXhDQzZ4RmNQcWFjR2ZjMFVMRFFQZVI2?=
 =?utf-8?B?N0o3d2lnYkZsbXFvSnc3dkJ0Y0JvWjNtalZKTjZDRU9ZcjVRKzAxR2NibjRM?=
 =?utf-8?B?TjNURmpUckpaQ2ZhSDJkS1N1Z2V1c1V2UEpWTmYxaGZkZUFkdDhkZEhkZ1RW?=
 =?utf-8?B?bGQ2MWtCK3AvaVEycEY3emtMY1lXYmIvb1Fqd1lTcXArQmJFV21SaDBIRGNn?=
 =?utf-8?B?QWo4eUp2djlLZyt5SWc0Zk9aOTQrSUFDNkVvZjlZdWdNMmJvamJTZERDM2cy?=
 =?utf-8?B?Nit4cjZFTHdQdmdUalNycUdQZnhMVzl5UGo2MlN4RGZBY3RjVEFuSUViSkdN?=
 =?utf-8?B?MVZHN052dWlzTGdxbnpGVDNDNWM1S3BRVVpiVWMyV0dSVGIxTGoybVhWTm5i?=
 =?utf-8?B?WnNYcEt0UytMZlRlYlhYRHp6Q2JLNFd4YTJMWEpXSlRJOVlmUUpyemFTK1Nh?=
 =?utf-8?B?UDlKYU9STFhXM01PUkJWSU1namdmVi9OdEZFZjZVNGdtVFFLN2NuOTN4bG0v?=
 =?utf-8?B?bThLTEVvUDkvejZsc1dWWlUrcmdFYncrNjN3VFM2cjFqTVo1UWZia1JSb2o3?=
 =?utf-8?B?UU9GU0ZiVTNZazRKSXUrbjJvVXNZTGI1ZzZmeWw2UjZ3anBuVXVDNDNJQlQ1?=
 =?utf-8?B?WXRiMmd5b3N4ZG5IQk11Z2kzblJCNktPS0dQTEN6Q3I2bGpmcmt5RXFXWkNU?=
 =?utf-8?B?KzYwQWVML0hGSk4yZkdqeCtpYTRDMHV2Z1MrYkxCcjg0a2p2dlRSakk0b0JE?=
 =?utf-8?B?Mk9wUGMzSmoyWW1oUUszcnNXK25PTENtZXduRzdTYlFOL2ZuSWVpKzMvNkJl?=
 =?utf-8?B?N0VCeGdsMGhiZEJnTXZMUVFHczhaVUthWjBwaitDVkEwYjRxa2pDaXZ3MU1o?=
 =?utf-8?B?WUFIU3VGS2RTL0FwY0NDTGl5bURWQlZzUXlYQzFJS3lhLzNyZVljdkZrT2Ri?=
 =?utf-8?B?dWM0UU9QZUxBcnpEbmRmRk5iREd2VDFtbFVpRGtNN3lQanR1UHJodEZ3bURP?=
 =?utf-8?B?YzVyR1dRQzF0emtaaXh1VmNpc1ZLZk91bjBxRi9qS1k5bENKNWF0eXpBWHpt?=
 =?utf-8?B?M3ZTc2JwOU54TEdGOUtORnV0QW84bXI3TmhXUERlLzJBeStPclY5czk5b0V1?=
 =?utf-8?B?TlJLN0lOYzJzTStSWHhFazJYNFl2V05seWdTQ2REL3JIUmtObHBNaTQyWE9v?=
 =?utf-8?B?UzF6Y2RtV1FOWGJFOHJmKzQwOVBVZlUwRXRnaTM3SFFabGdHYjE0aHkrZWZw?=
 =?utf-8?B?c3p5M29lRnlPVENIYk5YM2hvN1BjdTVkZ3Y4Z2VpN2swbGpSMWNlVzdJdTNo?=
 =?utf-8?B?blF5YzhuR0tTK0hmd29YYVQ4cHQvWGxLS1dOZTVrYTRyTU81Ymx1Ynoya2JJ?=
 =?utf-8?B?NWFVTkhyZDdHSnV2clg1eWNGelZFa2VVYW4rOFZCY2MvYWJzYS9sNXU0U1FP?=
 =?utf-8?Q?BwhHFoMxOAU27rhf4D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d36ad5f-26dc-4874-91d5-08de954973bc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:33:04.1110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kO+5/qVjzBl3E/0Zk8ZP7nmNFBGtNcubFkRtxmp8Va+EpSqLYNHmM4sOg+XVtwYk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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

On 4/8/26 10:30, Sunil Khatri wrote:
> Signal ioctl does not depend on eviction fence and neither it
> needs to hold userq_mutex as we just wait for userq fences
> to be signalled before we go to suspend state in hardware
> and we prempt and unmap the queues.
> 
> This unblocks other thread which hold userq_mutex to go on
> without breaking the code.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 38 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 18 ---------
>  2 files changed, 38 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 5ae477c49a53..53f0bf6b3ca0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -54,6 +54,41 @@ static const struct dma_fence_ops amdgpu_eviction_fence_ops = {
>  	.enable_signaling = amdgpu_eviction_fence_enable_signaling,
>  };
>  
> +static void
> +amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	struct amdgpu_usermode_queue *queue;
> +	unsigned long queue_id = 0;
> +	struct dma_fence *f;
> +
> +	for (;;) {
> +		xa_lock(&uq_mgr->userq_xa);
> +		queue = xa_find(&uq_mgr->userq_xa, &queue_id, ULONG_MAX,
> +				XA_PRESENT);
> +		if (!queue) {
> +			xa_unlock(&uq_mgr->userq_xa);
> +			break;
> +		}
> +
> +		kref_get(&queue->refcount);
> +		xa_unlock(&uq_mgr->userq_xa);
> +
> +		mutex_lock(&uq_mgr->userq_mutex);
> +		f = dma_fence_get(queue->last_fence);
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		if (!f) {
> +			amdgpu_userq_put(queue);
> +			queue_id++;
> +			continue;
> +		}
> +
> +		dma_fence_wait(f, false);

That doesn't looks correct to me. We need to hold the userq_mutex while waiting for this fence to make sure that userspace doesn't installs a new one.

I've already pointed that out on teams.

Regards,
Christian.

> +		dma_fence_put(f);
> +		amdgpu_userq_put(queue);
> +		queue_id++;
> +	}
> +}
> +
>  static void
>  amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  {
> @@ -66,6 +101,9 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  	struct dma_fence *ev_fence;
>  	bool cookie;
>  
> +	/* Wait for any pending userqueue fence work to finish */
> +	amdgpu_userq_wait_for_signal(uq_mgr);
> +
>  	mutex_lock(&uq_mgr->userq_mutex);
>  
>  	/*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index c4e92113b557..1e8c08b63f65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1269,27 +1269,9 @@ void amdgpu_userq_reset_work(struct work_struct *work)
>  	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>  }
>  
> -static void
> -amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
> -{
> -	struct amdgpu_usermode_queue *queue;
> -	unsigned long queue_id;
> -
> -	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> -		struct dma_fence *f = queue->last_fence;
> -
> -		if (!f)
> -			continue;
> -
> -		dma_fence_wait(f, false);
> -	}
> -}
> -
>  void
>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
>  {
> -	/* Wait for any pending userqueue fence work to finish */
> -	amdgpu_userq_wait_for_signal(uq_mgr);
>  	amdgpu_userq_evict_all(uq_mgr);
>  }
>  

