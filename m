Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360D6CA5FA1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 22:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DDC110E177;
	Mon, 28 Sep 2026 22:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OBsCWqa6";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAB3A10E177
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 22:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qch08/4xOq9oNnsLMeDaPgQSRReu+035veOG3SAUVRSo+3exjemHXa8vD42lfKrEDpUnCr9uDBWQ7IdSXDGFSAeg5C/rzczWkj/SZLwwFRtCYXj5mk99ButFOqmoMGHfTpmf+s5H3ID54wNTnUDB8neCjal9WABP6ENhk3LTZkW0yikZ0k4aPG6NWRlyOA3qS4kFYbp+Qyvd0t6mX58tv9XHMPJSGVzpdTAVwyCZWJcRlfWFQDLq0b1hXM7Y0eLbz/+PdvEcsEN8ZXQlcZiQ7+C61js05Pv4h0akLUXRY0ZGtdmjQzqs/jLR6hhgnGeJ24s+z+JFDhseRny1CNSOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gif/pYrZDTpxwj9wkbe0iW9EKzWuVb9sLw8+ON3UmLo=;
 b=OBZ3yUboPOyZriTo6DzY0HDXcxoDFx73+cGS08PezRcodcmPzMdZ3GOWQAT/bCqFr+5K9MVBfYLxyIds1ntgFaJCGHfGb1MmX281bDkkkEdJ2Xr3Tv8i1TwKh3KjbEnGn4jZZs9BO9OMOWf68k0/5P9OgoMsTOPEtuO6m8RxVKglq+dj5VoXEUe86KlwWRGFsoo2ZZR87PU5o6b56PjEbpGuE99oTb9G9o9+QPhJsLc9d19JSEooVpLmReHpDj67CnX0YQdpOjRExtQfzCdou7rH8fMi43zV7BWdkuiO6xQJmP3qwDMrccXvj3WPqlW78ZpjBTG9Ytbwa6zFH+JhsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gif/pYrZDTpxwj9wkbe0iW9EKzWuVb9sLw8+ON3UmLo=;
 b=OBsCWqa6/kLrWDmd9yKQb3VS43K4GLe6nUEQouXpEpirT6oqjb/4LM/kaLX6loihJ5CHpeSxgcLaLsrZoRmaG+ZDaQ4N1V7WwXBQ4xrEHC5bOAILiqj7gN9Ys74udF0aAm+zlQpiQ20MEv1e2J3XEGeXPACcj1THzpP4R+DHJK8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Mon, 28 Sep
 2026 22:49:32 +0000
Received: from IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de]) by IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 22:49:28 +0000
Message-ID: <123fa18d-1bf7-48e7-bace-cdf429148128@amd.com>
Date: Mon, 28 Sep 2026 18:49:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] drm/amdgpu: don't block wait gpu reset whthin userq
 lock
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Vitaly.Prosyak@amd.com
References: <20260902125001.621629-1-Prike.Liang@amd.com>
 <20260902125001.621629-12-Prike.Liang@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20260902125001.621629-12-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0061.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::15) To IA1PR12MB8190.namprd12.prod.outlook.com
 (2603:10b6:208:3f2::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8190:EE_|CY5PR12MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: ef969340-e5b0-4e06-c2ee-08df1db2c038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|4143699003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 35lztFvmbmZ81ubajHXGwk5weEF7yEPAjHVHEOTD9pCAxuv92BiGLAx+bqBsm7G4SS6MAJY5USvjO3j8qmGkuvlJL9Jc4sjX7w22rTc2PnGx9wjcc2+AB3sP78mBdk2XOIHpWeEPBwm+WH4BazsHGSO30prB8WBxDUgDZcsXuHw7t7kGQ+qnyQhzOhT44YxeWOZbdzHMS2wQOkFusdK2iPAJi55JI7Zkvxaat6wUHUqy5cq3Bs8mreGz2z69xnnvBSw8VVCyz1v34fV1jJvjNoz5cSKiGOFnLPAOsBdGhkBbw7cZ9RHdhKN15Lj+vIJTC5KlVeFyrEKqAVjWK+o+FIJgetcKzaWSecAhmrDguiXT2ppVL2ggUB8u9gL85TXeA7sHUh1vHkRW8lW9a27r1K3B7KlhLOiuiomN2N7zzA+TjYGAll+VtX3vPO+sdn77laQ5EvZ2KWsjVF6YFivb+laplRkwyirIiKqRna3/CPiJS0gCTposT3xiE52K46WbpNW8a21zQcS5y7zUJmanGEqw3fnaqDDvQt5WO/7BRCugGgv0nZTuQOgMdnZdNoPCPqz7pLO4UO1IKiw4/y4RLXoEwbOjgOw3h6/JTWxl0B1qEEsNUrkLEWh0PIOZz9nBYBN5QFXZLxb7T5lYCRrnUi5yFLApnVsgPlwUCaA4NhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8190.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vnd3ZksrWGxVb0JmQjlJVmFkWVFobDMzbGtxZFVPQ2RWOEwvUFVKWGlGajJ5?=
 =?utf-8?B?aXY0djlxV0s1N1hzc0ZIVVZoUkNWcElnN0NkYTRRczNsQUtaK3lhaU85aDR4?=
 =?utf-8?B?SEkreXY3eW5GWW9FdkpxYWVsdTBmU2t3WHJtTE12YVN0SjFiRUlnY1cyd3h3?=
 =?utf-8?B?ME5PRDkzazRadjJrVm8xOGo0cU9iYWJwczh4TCtmMkZOajhqa09yWE9FNmdQ?=
 =?utf-8?B?ZHlrZG1ZNEdOaVdTVXo3Und0dXVzUHN0am55S0tOSUdtUjNBWlRZR1U5TU1C?=
 =?utf-8?B?MVZSRlZzblRBVENkRVVUUEZOUXZyVE9UeUJNNkNnZnZDSU5aQUhUM3RteEk0?=
 =?utf-8?B?ZmtpUU1hYmw5WXZOYTdMZjZKbHQyY1lJSlduVmUwejhrcVYwTVozMnUwNURQ?=
 =?utf-8?B?OEZWWUlzaWtxamYxblFJQkFIUDdzWU9SenJONnJtWmFKTGFrckRDVVZia1Q5?=
 =?utf-8?B?SFdqUFB2T3ZhMzk1R1A2VEhFYUdWTDFFYVRxcUpjRTBqOUhtaytNWWhYd1Rl?=
 =?utf-8?B?dWxwdGx3TlN0aXlCY3Q0V0NMTGYvNmIyMXFReklOZlNuNWMrT2sxRC9Eamdn?=
 =?utf-8?B?aTIyYWFGdGp4UUlLNThHMml3Y2NIanRocnl4eVgwMVJ3QWhuNEgyL3JDVks2?=
 =?utf-8?B?TXF6Zk5WSGVUWWNDSklaMWFQMjNBbVd5V2VJRHlFc2JxVjVNbWg4KzJQbzhx?=
 =?utf-8?B?U0VoejViYksxSzhWc2RtK0lXV1NiZWxsRTRmVEh6djNHVHRWdmJINGdvcXIy?=
 =?utf-8?B?T21mV3FtcWlpTjlNQTFMa3phekJpcjZvSWV5N05sUDZydmxTaEFkQVlFV2d0?=
 =?utf-8?B?TEQyVCttWjBkRzZia1E3R0FxWnJDeUdvcnVMWDZmUlFreHk3WmdubHB4cHVX?=
 =?utf-8?B?bjFhdmxNOUFJU0ZualhvZUZRZlpaNklSY1V1bzJHRGNVK2pFd3MrTnFFN3BU?=
 =?utf-8?B?MkFjNnVIVWd0SGhLR1BqK1dFVEczd3BoTXBxRExGMmhhUDJrbGRkcmhENTJS?=
 =?utf-8?B?MUNGLzRRRXRnNUw3ZU1pVE1XUnh3azgwSFJvWWExWFRJMFpQK1diREZlRjFO?=
 =?utf-8?B?MlYrTm0rQ0FmZ1BqUkRkc0c4a0lUTkxoYzJuYkZXYWNNN044ankrOXNjVE5v?=
 =?utf-8?B?dmxBQ0laZXR4Njd3Z0FuK0lEOU9OZ3pKSEc3UGRHcEJvMnlBQ3p2Q01ZN3pr?=
 =?utf-8?B?MnlOSWtpNkxMME9wWmxWWnBPWjhsSG1LKzduNUU3S1E1VmNzbU85Q3BoOXk0?=
 =?utf-8?B?WEl1VnNpcGRHSTRpY2R0ZDlURzQzMUZVdHp5ZjE5UEh0cFlrTWloam9hOGh3?=
 =?utf-8?B?THZKZnhnSGdVYkp6cEgzS2djMnRia1oxbTJhR2R2QXJNNmZCdEZjbEI4K2pq?=
 =?utf-8?B?M0I0YkViUWZaTThUV3BkOUIrd3Q1a3FoVHVNRlZJVmI0TVNZeDB3ZU96VjFu?=
 =?utf-8?B?TUlHK1Z2NUVZUTROM3J1VmdjQ0oyMVNZanFSTmdoZzgxekZyNU1ibE1DY1pu?=
 =?utf-8?B?ZFZjSnNrRnZwYnZ5RmVjdTAxcWVaeFFobU1ZNXFnOGZNT2pZcnFoekpPTDNU?=
 =?utf-8?B?a1VMOXlvblAvUEh0NWdneWJ6bjhzdlg5cW5INE8rcWN2V0pldWhCZDhtSm1j?=
 =?utf-8?B?NUVmelYrclhOYVBibCtRQ3hsRFJqSDVuZWNQYWhIWVR5L2NNRUJiTFMrZWIv?=
 =?utf-8?B?Y2lLbk1YWkVVZmFSZFY0bmt5R1htV3dwU2xPWEMvcHJ1Z3V4dXpseVNUelpL?=
 =?utf-8?B?N2hOUVcvTVF3STlWVUxrYnRkTHJXTFpjSHpxYURyeE1lajNQdk9sWXJ0RFl0?=
 =?utf-8?B?cUZTQ2UwZkdYdHI2aXBESFZESjYrNVA0amQxVG0va08rdDNSb3g4M0paQ2Ny?=
 =?utf-8?B?NjhIMVJLSUxWVUJ3YndqQWN0UmFKeW5mbkxvcWc3bVNtdTBRQzBIaDVoaEo5?=
 =?utf-8?B?WCsrMEtwaCtPRFFKOFRlclJoYWZjL3o3ZmxwMFAvdkpuWmZTVU01VEVxTDZ6?=
 =?utf-8?B?ampBMEFxaXNJVUJXREM2bjNTUERyM1NGSDd6TSthNk5sc3pDZE5IYUprU3Fm?=
 =?utf-8?B?SjFvWWh0QVh6TTRTNXVub1BtWmJjREErQ1k3Qkg3amdRbHBMb0U1bEVZRnNp?=
 =?utf-8?B?SGlSbURRRXExZzN6RjNFYW9vLzlMRDhBWkxSUVJPM0tuR3R1bXRUdGg5NlJa?=
 =?utf-8?B?U1ZPZDdqaExGb28xY2V1cldOWUdwbjU2aG9vdUZiRjZMa0luN2gvMlNpclMw?=
 =?utf-8?B?eHFvTmU1VENLR1RqcnR2QWdDeEpnMnZJVndaN0RiNHI1V0puZDI4WDNSSmJY?=
 =?utf-8?B?SWpqaVlGZGg5eWY0OFhQRVh3MW40VDZqSWhnMUtLYjdqUzR2THlJZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef969340-e5b0-4e06-c2ee-08df1db2c038
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8190.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 22:49:28.1016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcOMG5dT5cRjWQr8vRDJpEcE5BW38iwopQl7AITotfzMCyYrkDBojGKEPN6GNvF70MNGijr7YkrUKD9U8h1iUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105
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

Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com> 

I have tested this patch on nv31. It successfully resolves the lockdep deadlock warning triggered during the reverse 

ordering of &reset_domain->sem and &userq_mgr->userq_mutex. Please note that this patch requires a rebase to apply

 cleanly onto the current target branch. Once rebased, the lock inversion issue is gone, and the trylock-and-retry logic 

works cleanly to unblock recovery execution path interactions. We can safely enable this on the CI.

On 2026-09-02 08:49, Prike Liang wrote:
> The offending edge was code that did a blocking
> down_read(&adev->reset_domain->sem) as following, while
> holding userq_mutex. Since GPU recovery takes reset_domain
> ->sem for write and then transitively acquires userq_mutex,
> the reverse ordering could deadlock.
>
> .569196]
>                other info that might help us debug this:
>
> [  307.569516] Chain exists of:
>                  &adev->firmware.mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem
>
> [  307.570011]  Possible unsafe locking scenario:
>
> [  307.570250]        CPU0                    CPU1
> [  307.570438]        ----                    ----
> [  307.570624]   lock(&reset_domain->sem);
> [  307.570785]                                lock(&userq_mgr->userq_mutex);
> [  307.571061]                                lock(&reset_domain->sem);
> [  307.571320]   lock(&adev->firmware.mutex);
> [  307.571491]
>                 *** DEADLOCK ***
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 51 ++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 2534e4a1a530..a7d5ca741a3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -422,9 +422,12 @@ static void amdgpu_userq_detach_doorbell(struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_device *adev = queue->userq_mgr->adev;
>  
> -	down_read(&adev->reset_domain->sem);
> +	/*
> +	 * The caller serializes doorbell removal against an in-progress GPU
> +	 * reset by holding adev->reset_domain->sem for read.
> +	 */
> +	lockdep_assert_held_read(&adev->reset_domain->sem);
>  	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
> -	up_read(&adev->reset_domain->sem);
>  }
>  
>  /**
> @@ -544,11 +547,34 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  
>  	cancel_delayed_work_sync(&uq_mgr->resume_work);
>  
> +	/*
> +	 * Cancel hang detection before serializing against a GPU reset. Hang
> +	 * detection triggers recovery, which takes reset_domain->sem for write,
> +	 * so it must not be canceled while that semaphore is held for read.
> +	 * A reset IRQ can restart hang detection, so this is repeated on retry.
> +	 */
> +	cancel_delayed_work_sync(&queue->hang_detect_work);
> +retry:
>  	mutex_lock(&uq_mgr->userq_mutex);
>  	amdgpu_userq_wait_for_last_fence(queue);
>  
> +	/*
> +	 * Serialize queue teardown (doorbell detach and MES unmap) against an
> +	 * in-progress GPU reset. Do not block on the reset semaphore while
> +	 * holding userq_mutex: recovery takes the semaphore for write and then
> +	 * (transitively) userq_mutex, so blocking here would invert that order
> +	 * and deadlock. If the trylock fails, drop userq_mutex, wait for
> +	 * recovery to finish, and retry.
> +	 */
> +	if (!down_read_trylock(&adev->reset_domain->sem)) {
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +
> +		down_read(&adev->reset_domain->sem);
> +		up_read(&adev->reset_domain->sem);
> +		goto retry;
> +	}
> +
>  	amdgpu_userq_detach_doorbell(queue);
> -	cancel_delayed_work_sync(&queue->hang_detect_work);
>  
>  #if defined(CONFIG_DEBUG_FS)
>  	debugfs_remove_recursive(queue->debugfs_queue);
> @@ -557,6 +583,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
>  	amdgpu_userq_fence_driver_free(queue);
>  	queue->fence_drv = NULL;
> +	up_read(&adev->reset_domain->sem);
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  
>  	/*
> @@ -734,16 +761,28 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	if (r)
>  		goto clean_mqd;
>  
> +map_retry:
>  	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>  
>  	/* don't map the queue if scheduling is halted */
>  	if (!adev->userq_halt_for_enforce_isolation ||
>  	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
>  	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
> -		/* Serialize the map against an in-progress GPU reset (MES is
> -		 * unresponsive during recovery), matching amdgpu_userq_detach_doorbell().
> +		/*
> +		 * Serialize the map against an in-progress GPU reset (MES is
> +		 * unresponsive during recovery). Do not block on the reset
> +		 * semaphore while holding userq_mutex: recovery takes the
> +		 * semaphore for write and then (transitively) userq_mutex, so
> +		 * blocking here would invert that order and deadlock. If the
> +		 * trylock fails, drop userq_mutex, wait for recovery, and retry.
>  		 */
> -		down_read(&adev->reset_domain->sem);
> +		if (!down_read_trylock(&adev->reset_domain->sem)) {
> +			mutex_unlock(&uq_mgr->userq_mutex);
> +
> +			down_read(&adev->reset_domain->sem);
> +			up_read(&adev->reset_domain->sem);
> +			goto map_retry;
> +		}
>  		r = amdgpu_userq_map_helper(queue);
>  		up_read(&adev->reset_domain->sem);
>  		if (r) {
