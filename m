Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E85CF94CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 04:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F2910EF16;
	Wed, 22 Apr 2026 04:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iBvruG0l";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD6E110EF19
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 04:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QopSoW9VZsKKN9kNP0nUGljDuuBSewdRTRO+sxoxTtnMAMITpmOh5F7CH5M+SzKF/CtoaCzKPy/hASqMR05UK2grcY2TVTJQWDALIU161QYz4tCganrzMiWYTHrylkA/kfj0WDHFEU/wMBUN5XCSpwrYKK/szEQKw8BLNRhXcMILLJlJ8quGcqt4QLXbXEuu3a2JsiCxsRp2pQUywQsG2PILkGIbwl6raJFDgeaqKqX5SlatjXkGkSxYESWlThwwUK6cDIcnGnn5oBtzL8K6y4XrDT6tXpicBDStautEzTFAUZeKV3lCouzDozcX8uS61sFYBFMUUEM241dPQVUseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHvnH5+4r12sjwQH+N7vKJHy/SbwBPyJdeq0RDP6LEU=;
 b=WlCIyglIEX34vSKMNvdlWu9edG5zlvQ25spyMp4T1TpTr3+jy+GgOzAiM1PE+pnjXPneq4M/CUCvXGiCk5L6I+rlpIyT0ifKzVrDAFqpFCMzSSel47lEwmz7f9RJKRunDqG780m5cmSdouIZ1SykWlG35LQky9xR7ut+MwfMGaEHwViT8HW5HUukufH7sWAwfpQULZCy02dyhgJR7pzpBwksnuwaMYkfoGHOzR6dTdjdWWIpY3DOxdNy4lBOF1JeQB8UAONsXjhqAoVDUVxjuhxTlw37AdmEEtrNyYtg/KTW6lCTwm9o50OGevudE4i3xKFwBtstzdkdf181yJ9Yqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHvnH5+4r12sjwQH+N7vKJHy/SbwBPyJdeq0RDP6LEU=;
 b=iBvruG0lxkFO7ws9n6sDGSmyiFac+VDDp2CDTnDhS6NtIwmHhbUyJJJe+9eI8T3ol0Uru8yq8IXFpGp2y26tGSu8UZD2IoRVGdOE8ViX7HOYD0ayPPcoz5aOiqcuAi6Ua85EhVJF4rp3taQB2K8HePTIWciAMmw+2XyPtK/zAMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.16; Wed, 22 Apr 2026 04:53:17 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 04:53:17 +0000
Content-Type: multipart/alternative;
 boundary="------------7e0jr2RJ0ylpUCq5zK6vhNCm"
Message-ID: <e0761bb4-6cb5-40ec-b5f4-f57c6ef636e2@amd.com>
Date: Wed, 22 Apr 2026 10:23:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] drm/amdgpu: remove deadlocks from
 amdgpu_userq_pre_reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-2-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260421125513.4545-2-christian.koenig@amd.com>
X-ClientProxiedBy: PN5P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:263::11) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d407667-da0a-424c-3a69-08dea02b1152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: rdQ7il24wSuBmb+emaAGzOJfr5zwWkss64FaWtddG0cnXPK4BfKSAZ4C2yrpvHrpU23Q3wIJLcnM3hWaUpYyUi54fqqmiS8fc+OUEU8V9WccUFD+vrB6ja47KQMJ+UHGDT+bAIwInmZ0OfuE69CFiaFW9t/aHU5bdbr0LIblxnL4BaGDQGfQwEPyvn7vm0AOhT4temEelBOa9VX+HDm/aaHRqugc1Tj+H3tPKD3Ic5E8EdLqeLmf+8jyRHSdZdR8R8CJnSN80AwNT5mE1nhUiczYNeopkluCEC8d1Yw+dMGf+FOHD6+b1n6ErL8WRWJMS/7JQXCZ/Z2fwHgCZfETMLwk5zS5mImRbslNwTLHRc3fQ6IyubmVbwkCNNavnoOZ31GQOCpGv2tSSLyP+ZArCJ15D0PDopFaIxgd/A06cQ8gtrpHd93JkQJZottNr3OpapfxxIibXi/wJqP5qe41/xdefbB5/hkURrK+JNJBFETCt4eijl4q14PZi7lFqcBag/BEYOM/owO6U9BvDDyjcvMIaCON0CqOBRkwatqPxVu12fNGDi+DJKQHtL8oinzt2zdSNA3FM8CLjYuwrA6iaCLshEEW9kEi8sK8gzrqQVvraGApRPjBnsLXh1ITaPDCXuYEv8DLhZRIYXUdf+IGoDB2r+kq5LN+pXv2YXC6TAtYIwzo+n83l0HQ7ksbSaQP7P34qON03QlMH+WQ/CHE3AYlff+y1FJuCR152HF/Iec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2ZVL1VyM1oxblhxUW13U2VpQlBsMTR0bHphbHRyL1AvTkVpUzE3ZXNISUlt?=
 =?utf-8?B?U1M1dWZZTjBSK3p4emI2bStvNDZlZVFPejNBRVhwaDlZUDVpdlFORTV1dlRy?=
 =?utf-8?B?Tlh2RFhmYlpxM3pQVGNSN3pXSHZYUXVUOU0zME1jWDg2ZFVHVzZjWEFOc2Zq?=
 =?utf-8?B?NU96dTNGSWJTQVFoQXdVRnlZUjg0amlkYUVUd2V6dUo4Qlh1bk9IRjJ3a1pH?=
 =?utf-8?B?OTJaN3RiM0dnd2p0T3RBOTlWbG13R3NRRHBBdTU4VkR5WmtETFRnSUFCVlNp?=
 =?utf-8?B?SEVadjl4d2hXK3pGOWdkYTArK1poOC9NcmxKNXVFUjVZL2UyOEVFVnVhcVpt?=
 =?utf-8?B?VEljSnBQTXNrTkprdUtwWEphOUJMYVlmWmxlVHlhMURMdWd4RzExdGNCQ3ZG?=
 =?utf-8?B?WWJxV2FrbmV6SjFzNUVNVUJsVDJYYVVsRnF1U1VqbXBqbXFLblphVjMzdG1Z?=
 =?utf-8?B?M2RqMi95UWxvZEp3R244Mi9DODBKNmh2cjdweTByUllzb1R2c0hoOEJkWnow?=
 =?utf-8?B?NnM4aFl1SXNSNW10NTMvS1RxcHc3TUVJZTgwTGJJU3FzbVVoOXNTaDJlZ1hq?=
 =?utf-8?B?L0o5ck9mc3NpMnlwbSszU05GWm1EVWRmNGRZY2xhOVFIRy94NjI0cjV2UmVh?=
 =?utf-8?B?TGFXSm02c2ZlNldRTUZObW1TMU5UWHUyYlhydWdYK2FDWFVDbDROcm04Ujhp?=
 =?utf-8?B?bHQwUjlleU55SkJDMmZ0SDFsd3EyVGlRWU1VOCtmY3NSUzAyYXRPNk9OeVFS?=
 =?utf-8?B?Yzk4dFBhZzZBczJtdlR5WG9rUEt4U1JuSHRNNDk0bzFZYjdINmVmVHYxOWRH?=
 =?utf-8?B?MTFCRExLZ3J1TS9wUUtWMTlHdlc0ZnNTV0M4dUxESG5IeFFsajZycklwUUlo?=
 =?utf-8?B?VE9yTEZtdlRIVzNBTGNMVXhpUnNRZTkxNVEwRDZxOFBnRlVVRUE0ZE5vZFhC?=
 =?utf-8?B?YlhqZmNCZFV2ZkZBTmdFTlg4WDBydGF4cU8vZERFcHhaU21OMHB4N2t6SjVv?=
 =?utf-8?B?Vm80T0xDa1QwemdlazhUNlgzQ1lUdzExRSsxMnRObDV2eFBOOEJzM0JXTkh6?=
 =?utf-8?B?WlIzMWdCWCtLMlBHRXM4Z0t0RFFTQlcrVzBjNG5heThRd0hhNWVXNFRMVG41?=
 =?utf-8?B?VWdxTTQ1ck14MjdXa252OEhBM29YeVZXNWdkTzdoL0laR1dXM0Izbyt3OC81?=
 =?utf-8?B?Rk53c3JjQXRQdllaWklWejZ1Sy9NNFlEM3YyQTRuK25Rb0NSUXMvOG1QMzVp?=
 =?utf-8?B?aWd0YkhFb0kraDZFQ0FqdG9VZEhaVXJEUHhXMm5CdDJiZmlmZW85Q0tRdVhi?=
 =?utf-8?B?NDQzdFcwR2xqRE9vR2xhUVlyb2FDd2hxbmlPWW9DbG1SNnNlQXFUOE12Vk9w?=
 =?utf-8?B?VVZzTkZuaXpIcUtNT3VZb09GWTlxaFVoMUxTRXVrTnhVeDUzR20ybGlRM2J1?=
 =?utf-8?B?cjVLd0sreGJXSWRTWDFoY2NQT2hMRm9KWDdMSTdYa3hSQmtjNFdVYU53WGJX?=
 =?utf-8?B?UjE0eE4zT1loN0J0bGEvd2wycWtpbDJydmdKOEhxTmYxZ0xKRUVHMk5OM0dW?=
 =?utf-8?B?NGVBV2Zid2RtN2swcjdKMHZURGpXSDZmaHdHb0xIUU45eDBTOU14cGtHUjJW?=
 =?utf-8?B?YlNiZkwrS0N3VlIrS2FXWjFDNVMrVnFqRC9JRzgrZFVyRDlQS0s3dEhQeWVh?=
 =?utf-8?B?dnYvV0c1WjhGYUpHNHg2bEZkYjZRY0dQWVJBclZ1RWtPRC9mU2JCTGR1b1pu?=
 =?utf-8?B?QVQ1S0Z3Wm43anIxdE9qUTBlN3dDeUlXVFRsWWV5N0xKUzd3RUNRRFdQZk16?=
 =?utf-8?B?SzdBd3E5R0VDZUQ2Sy93MFVZYVFGRFZPam9FOUxHbHlpcktRWmowbTU0OG1J?=
 =?utf-8?B?ZUtTemRsRmM1OWNJa1dWTy9IMURTY0hFVjIxeVhYNjlqWHlXTXhSdGp0THVx?=
 =?utf-8?B?aTB3VEUwMk1GcHN5M1MrelI0Skh6NzFYZ05sekxCeDgrOGYxTWVzeXN6NlNn?=
 =?utf-8?B?dVc0MUd2eU5kUWJuUXNsNTh1blk3RzBrelkyRGx6YUt4ZE02dm9CcmtORnNw?=
 =?utf-8?B?bDBWWEZkdFdlTjEzVkhVc1ZsbDB5ajlWMFRCTDcyVFZQaUFmblZVMjczbHcx?=
 =?utf-8?B?eFhUUEJWTWk2R1ZsdC9oNzg3bjFudE4vOEovSE9uODlEQ3Z3VHNHbHdrNTdt?=
 =?utf-8?B?dU9sSzhXeTdOTG4zekQxakZWZEpTbzBwaWpreFRwcXVqOG5uY01OZjZFZlBP?=
 =?utf-8?B?cThWUzR2Y1BTcGNNMm9kV1puTkZXUUZxdlU1QjhKdzF1eVlzRElZTkthd3hl?=
 =?utf-8?B?RGtxaUQ2Z0Y1VGJnUzI5azJkZmViTDZHRGswR25FRGtJTk9Scnl3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d407667-da0a-424c-3a69-08dea02b1152
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 04:53:17.0058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AN4h1Hw4lTH96mhmju8RkOtYMf1TXrNS7VxGqs0VLZhzwQHvuaTIcpUjUe2rvY/52jTsTXnUrkgpSytSQX9YSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
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

--------------7e0jr2RJ0ylpUCq5zK6vhNCm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 21-04-2026 06:25 pm, Christian König wrote:
> The purpose of a GPU reset is to make sure that fence can be signaled
> again and the signal and resume workers can make progress again.
>
> So waiting for the resume worker or any fence in the GPU reset path is
> just utterly nonsense.
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 26 +++++++++++------------
>   1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 8f48520cb822..b632bc3c952b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1496,23 +1496,21 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
>   {
>   	const struct amdgpu_userq_funcs *userq_funcs;
>   	struct amdgpu_usermode_queue *queue;
> -	struct amdgpu_userq_mgr *uqm;
>   	unsigned long queue_id;
>   
> +	/* TODO: We probably need a new lock for the queue state */
>   	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> -		uqm = queue->userq_mgr;
> -		cancel_delayed_work_sync(&uqm->resume_work);
> -		if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
> -			amdgpu_userq_wait_for_last_fence(queue);
> -			userq_funcs = adev->userq_funcs[queue->queue_type];
> -			userq_funcs->unmap(queue);
> -			/* just mark all queues as hung at this point.
> -			 * if unmap succeeds, we could map again
> -			 * in amdgpu_userq_post_reset() if vram is not lost
> -			 */
> -			queue->state = AMDGPU_USERQ_STATE_HUNG;
> -			amdgpu_userq_fence_driver_force_completion(queue);
> -		}
> +		if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
> +			continue;

If the queue is in prempt state and if at that time we are in this 
function we should still be doing force completion for work in those 
queue else the waiters will keep waiting.

> +
> +		userq_funcs = adev->userq_funcs[queue->queue_type];
> +		userq_funcs->unmap(queue);
GPU is already hung if we are here and observation is we are unable to 
unmap as we have tried to reset via the fw and that failed to atleast 
thats what i have seen. Could we skip unmap ???
> +		/* just mark all queues as hung at this point.
> +		 * if unmap succeeds, we could map again
> +		 * in amdgpu_userq_post_reset() if vram is not lost
> +		 */
> +		queue->state = AMDGPU_USERQ_STATE_HUNG;
> +		amdgpu_userq_fence_driver_force_completion(queue);

we should be calling completion irrespective of queue state here. The 
GPU atleast the queue is hung and fw has failed to reset. We have to 
release the fences by foce completion.

Regards
Sunil Khatri

>   	}
>   }
>   
--------------7e0jr2RJ0ylpUCq5zK6vhNCm
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 21-04-2026 06:25 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260421125513.4545-2-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">The purpose of a GPU reset is to make sure that fence can be signaled
again and the signal and resume workers can make progress again.

So waiting for the resume worker or any fence in the GPU reset path is
just utterly nonsense.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 26 +++++++++++------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8f48520cb822..b632bc3c952b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1496,23 +1496,21 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 {
 	const struct amdgpu_userq_funcs *userq_funcs;
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm;
 	unsigned long queue_id;
 
+	/* TODO: We probably need a new lock for the queue state */
 	xa_for_each(&amp;adev-&gt;userq_doorbell_xa, queue_id, queue) {
-		uqm = queue-&gt;userq_mgr;
-		cancel_delayed_work_sync(&amp;uqm-&gt;resume_work);
-		if (queue-&gt;state == AMDGPU_USERQ_STATE_MAPPED) {
-			amdgpu_userq_wait_for_last_fence(queue);
-			userq_funcs = adev-&gt;userq_funcs[queue-&gt;queue_type];
-			userq_funcs-&gt;unmap(queue);
-			/* just mark all queues as hung at this point.
-			 * if unmap succeeds, we could map again
-			 * in amdgpu_userq_post_reset() if vram is not lost
-			 */
-			queue-&gt;state = AMDGPU_USERQ_STATE_HUNG;
-			amdgpu_userq_fence_driver_force_completion(queue);
-		}
+		if (queue-&gt;state != AMDGPU_USERQ_STATE_MAPPED)
+			continue;</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">If the queue is in prempt state and if at that time we are in this function we should still be doing force completion for work in those queue else the waiters will keep waiting.</span></p>
    <blockquote type="cite" cite="mid:20260421125513.4545-2-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">+
+		userq_funcs = adev-&gt;userq_funcs[queue-&gt;queue_type];
+		userq_funcs-&gt;unmap(queue);</pre>
    </blockquote>
    GPU is already hung if we are here and observation is we are unable
    to unmap as we have tried to reset via the fw and that failed to
    atleast thats what i have seen. Could we skip unmap ???
    <blockquote type="cite" cite="mid:20260421125513.4545-2-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		/* just mark all queues as hung at this point.
+		 * if unmap succeeds, we could map again
+		 * in amdgpu_userq_post_reset() if vram is not lost
+		 */
+		queue-&gt;state = AMDGPU_USERQ_STATE_HUNG;
+		amdgpu_userq_fence_driver_force_completion(queue);</pre>
    </blockquote>
    <p>we should be calling completion irrespective of queue state here.
      The GPU atleast the queue is hung and fw has failed to reset. We
      have to release the fences by foce completion.</p>
    <p>Regards<br>
      Sunil Khatri</p>
    <blockquote type="cite" cite="mid:20260421125513.4545-2-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	}
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------7e0jr2RJ0ylpUCq5zK6vhNCm--
