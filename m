Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6A6C88E50
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 09:44:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD62B10E336;
	Fri, 11 Sep 2026 09:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0/sEtgDF";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2E9310E336
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 09:44:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2wcuPReHgeBx9pWQf2RU5aDHVxR814F7AZYEcuDWq1x9BaYiHPphSVA2XJ0kjtflrOnloEPOHLw7524pTveEXR3u4aRBtB3JFMohzA1dZ89pIoqL3jQHAKUGBT2NiMwD/WFE7YiyvAdjC7qHzFchqqojdoTGHRCjR9+MKHL6adKWZDWP0O428lFC8Ah9gOGCESEZ9OfAOWSDLpp5HbVpVJohdkkQpXaXFaOoisA3RmwTh4Tec34mW8tvavNzvoztGx/AW2ge0YxN7SZldUc/W7L8wO0wqeR4D5f8dngQlkvXT4Nl2/7tvMrUBFXHTRyaWrdMZzi/bD1EqpquV4O7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez372r8UQyHHUqWx6BAPB82vCw7dZMOJgOjGr9+htDA=;
 b=gedGle4pYRp3IcwP69MyRhSs4lp2V4nfUf4mh1p0ovVuaQg5WoKhq//9PqrynC+gGQxFlKvFKr+yEBG80L3eixZBPPId4AKzH/O95RlLbbiNDM+G7q8OwjXyjoss1eoFyS8X6V/xn23Wtj2+G5xpCb0fPkdpw0yaHAeuf9zMDyj8M/JyHHmHLuQYf9YmB/JBlG21CipVnatojWQI+ZgPcTzTWbS6MBJwRL0AbLvt3zuNWBnZtdBZDnQOf+5Uvapmq8zwdkjSD0FCKG4DRER6l8ID+ZoCk/E2oWtgDWB6/ZZ0SkfeeHXCINuUe6xEYIQuFE9/qhn7nJMJ7flZCQdpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez372r8UQyHHUqWx6BAPB82vCw7dZMOJgOjGr9+htDA=;
 b=0/sEtgDFXeUImSs3yI2hbNiN1v1jih1tkdyBSrTSK6iFeQUkK3HtIT1tWl2Q+eXM8kc5zde5J27qHXb0dAlxLQhv1ShJI9xBdbLU9PuJB6wfjNzzkfaGTH/PgFogTwXWnPbleZ00FXIgRboK59K5B8q5uEStG9db04L1urI11g8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:44:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 09:44:41 +0000
Message-ID: <391de10d-5d59-4397-ac44-57b10051d9a6@amd.com>
Date: Fri, 11 Sep 2026 11:44:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu: mark queue and process as guilty on
 resetting userq fault
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Pierre-eric.Pelloux-prayer@amd.com
References: <20260911082233.694414-1-Prike.Liang@amd.com>
 <20260911082233.694414-5-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260911082233.694414-5-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 2869d513-a3c5-4ca4-7af4-08df0fe94d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|18002099003|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: nqfK7vqSkzkrBjqKknrDYjhUumNjz7GCp4IuLPIWbXOLPUFwDdhpxlTYFqznAG7Xog5yArsC5qEYJS8RxayTwVjSJt559mS96l00Zm9m/r7PY+ZqRqqy0MNTRVwoAGZl6WZYHmewy4SwOGFhMRXJMvFSYWGxGYMFij/2vzWRuyDV/PJ05srznP92IXu1YvcvrX3r4E0jxKoJUFQPLMNqfWDU29/stKDdTAui5nWgJ8iVkEzeX4aukuN/lSmNsxg6/T/f8Gx3fLKFjuO0SJVdlgKi3VMsYElMT56GgUiWe0ujVDXVck3XXv40wYAofMgo2W2Anb4JDIHWiff0VgEr4fOwBIvObLGg+Cygf6zVTe9QrNfqbhn7VJZEom7WnlY3diUxZk8Jp5jN/Q9NeBTWq3OCGYoawkOJcd7NoHp2/rip/wcAYtEdvPrzlDhdbjTzddswAW6yY63/J8QW7EJkt6teCEYqzjiNa+3Y6LNOAvHFo283Lf9gMJNdpyVkXQswa1oIq71eeFbA+3XGHK1VFkaCtJlLii1DU48LUA2eZjcwTDkSgdOVWFwC1nRGzZvM2CQiR8ZsvVoulwQy1ViMzFZvywt48fIZfb30ogFH3VHhrH+79cVQYskBs74qnzQtMI1cgcGFNkeJm83AtKuBGUBrcM12uH/v6ohR5stupNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(18002099003)(11063799006)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWJVT1pUNkQwK0M1c0pXdkdhZmJnRWJnSnpHV3ViOFYzWlkrVEVaeTZtNG50?=
 =?utf-8?B?b2ZHQUVtODBtN1FnNTYzRitkemlKL0ZXeDRzSHNBKzN5bTdRcUEwNktHVTVr?=
 =?utf-8?B?cUJwWWdVWmtiQXh1cVZqS0tZci9zUWtydHJ3ZkhNanhPQmFlbU9HYUVlZDhV?=
 =?utf-8?B?emJtRGF4TTEzdE1GcUx5QWNGQUZNRXJHTXNna1dVVXo0dmxHeWtjYlNuR2E4?=
 =?utf-8?B?dENVaWJRKzl2MkRWQ1NURTVvOW9Ca3RJandJdWFEVVYxa1hXbUdXb2ZCUXRx?=
 =?utf-8?B?ODgzbGxnbUVDR29wU2J2Y3pobnR3bEVZZHhhS0R3b0VPZ0NRNFEvcXZERU5u?=
 =?utf-8?B?aUp0TERqSkhIQTZXODN0b3dJdk1FbnJROXhPT1lxZm42MkhrWUhicksva0da?=
 =?utf-8?B?NEY3VXlzcDZ3VWFHSEkxTXFhYWF6ZHdnYXE4UlQzaGxBcFk3T0RVSExvRDRS?=
 =?utf-8?B?QUVmVzBtSU9GakxFRDE4YTlUZW1Ec0FVMzRXbW40R3lrcGgvQVhXS2Q1R0xN?=
 =?utf-8?B?SVdyYUxOQUkxZjltYmo3QTk1bFZVdUc3bjBkN29JZUo2MGpQKzIzVWZYMDll?=
 =?utf-8?B?R1ZwOHA2UTlhZGtyb0M2ZTdoQnovU2dGSlQvR2ZhRWF4ai9Lcm92MjJlYWtq?=
 =?utf-8?B?clhYeXBSNGhPaXZGQ2hEWE1ySDNmQjhydlhIQWVOZXJsR0J0aUtteGQ0cWNy?=
 =?utf-8?B?cEJuM2JWaFJKY1RuZ21BYm1LWnE2QTFlcWhaOStKNHBxMks5dVJvNFExbUdj?=
 =?utf-8?B?cnNiZ1A3c2orWDR2SXJYaG5IUFhUc1oyWUtEWXpCQTd5K3BQbGw0NGUvS0lC?=
 =?utf-8?B?bWtPZjBYeStYTFlNU1N5RGtwTVNqR0dHY0VxQjNENHEvaTFHeUZnYUJBZmNN?=
 =?utf-8?B?SDJQZlphNEFGMmY0RkR4NVRaSFRLU3hwSStkUGRES2RiNktjWVMyMGZhcElS?=
 =?utf-8?B?MjlmdlZNcCtLT24xTENNampsWVhqdzJUWXBva2FVVVYyYVB4NUU4aHVoZTNI?=
 =?utf-8?B?eVdqOW1KMkQ1bENQRno5dCtYY0N5OFEzNjRpOUpYTzkwYWFoWlhTRmtOSmdI?=
 =?utf-8?B?WmhEMTEwK0RBTVpjOG5SdXVMWjczVHYwQStLdHpXbGUzVjlJQWF1UlJKV2lo?=
 =?utf-8?B?R1l0L2NRNzRadWJXK1gxWGYrZmszUTA5TGtTZjB2UmhPd2RLK2tabVNTWVlr?=
 =?utf-8?B?TnIwSk1QS3dMUFIzNDM0YmFXTlhoK01WOFQ5U0VNRG9jYURIU2FDMXA1S2hK?=
 =?utf-8?B?UVNKd1hqTnJVNHBHR3Mwbll3eldlSlc1K1ZZVzZmcFFjdWtqSUxFT2FLdE0w?=
 =?utf-8?B?bi9JTnVrdXBhNC85U1pCM0xLNkZDNTlQN2NtSW9OdDhQTVhDQy9KRDBieHRT?=
 =?utf-8?B?eFV2VlVMcEFRK3htcGJoWnpRMDhtbFNzQ1BoaUYxVnNUdEFXdktVK2M3cktr?=
 =?utf-8?B?VGIwNk5uM2FGMlo3eU9WTThvYnY5UzA2cXNJNFc1cGJOZHhGTFlpUURucktS?=
 =?utf-8?B?VWpncHcxZ3VhWUlZeHJkSE9ZSUtpQ0wyZXRtLzN6VmZnelkyeHcwNkFNcVBM?=
 =?utf-8?B?TnFxaTc2bFdwMzBVazBleHBCNW1FZ1JqS2Y2Nlkxd25RakxDYWtsa2RWRHc4?=
 =?utf-8?B?ODNLemlDeDUyeVMvS244ZHM3MWRKTU05cjlkdkVwSmdzaHd2Z1RxR3NXNTU3?=
 =?utf-8?B?VE1LV3BLcWxuTmJ2QmdwQ0FCK1ZEMlkwUzlKS2hEbHNLMlI4cXZwcWpCQTE5?=
 =?utf-8?B?NzU1OEFJQTIwQml5NnVkc1I1SGJ6YUVQd2h0NkFyNTc1cE1iUjE2YlBIREVX?=
 =?utf-8?B?Y21nUFFkTHd0ZjlLeE5LN1prUHovRjExb3hNVWlhV0NPUGoxUXJoU2FxNzhv?=
 =?utf-8?B?aDg0bmRRWU8rb1RVVk55d0k3VndIWnhhc01jMUFJU09Qc2orRUFwRGxqU1Ri?=
 =?utf-8?B?aWMzUi8wdTR0d2VzWVNRVDNyRVlVaXV6Z2V0RFU2Vzh2d0lnKzZGdkFjeTlk?=
 =?utf-8?B?d1M5RVIyWXRQRkxlbnQ3dFFPRTMwdjlhUFZOSlFnc0E3ZGFZSjh6NkN4Q3pJ?=
 =?utf-8?B?b1Q3NjJ3dGVaZi9SbkIycVVWaXdVeUw1cU9QS0cyaHJsdFVwQzlGY1lwbVNJ?=
 =?utf-8?B?VEowdGxJandXS1dCbjFtRU9tV1d1ai9KMWllM3NiTmpDOXhVMWxsTnJnaUFN?=
 =?utf-8?B?S012cHhXTlpVY2tXMHQ3VGEvQzNRVXF6V2ExL0JDWkovNXQ1aTJ1ZHliSWVO?=
 =?utf-8?B?aVNJYkxQa3FGdTZ0bnpvMHFZd1A2dGlyald3V2IrdjFIVzlCbUcwV2dEdmJT?=
 =?utf-8?Q?hWdnUZxptLypObBHcB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2869d513-a3c5-4ca4-7af4-08df0fe94d7b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:44:41.3618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdsNSJE9J4/BIbefXQ9uuuLKF670hzHftWXgQNcqVtOzS7K2kMR4+IwruslChgm2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445
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

On 9/11/26 10:22, Prike Liang wrote:
> When a queue encounters a reset error and fallback to device reset,
> mark both the queue and its owning process as guilty so that userspace
> is notified that the offending queue is no longer usable and should
> recreate the context before resubmitting work.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 24 ++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  5 ++++-
>  3 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index b15ed4a534f1..038d18faf344 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -589,7 +589,9 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
>  	if (ctx->generation != amdgpu_vm_generation(adev, &fpriv->vm))
>  		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_VRAMLOST;
>  
> -	if (amdgpu_ctx_guilty(ctx))
> +	if (amdgpu_ctx_guilty(ctx) ||
> +	   ((out->state.flags & AMDGPU_CTX_QUERY2_FLAGS_RESET) &&
> +	   fpriv->userq_mgr.guilty))
>  		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
>  
>  	if (amdgpu_in_reset(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 6c92575213c1..7098d550c0ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -173,8 +173,12 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>  	 * Don't schedule the work here! Scheduling or queue work from one reset
>  	 * handler to another is illegal if you don't take extra precautions!
>  	 */
> -	if (gpu_reset)
> +	if (gpu_reset) {
> +		/* Block re-map until userspace recreates the queue. */
> +		queue->guilty = true;
> +		queue->userq_mgr->guilty = true;

Clear NAK to having a global guilty flag in the userq_mgr. Each queue should be handled completely separated.

The only case where that makes sense would be gang submitted queues, but we haven't implemented those.

Regards,
Christian.

>  		amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
> +	}
>  }
>  
>  /*
> @@ -389,8 +393,17 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
>  	int r;
>  
>  	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
> -		trace_amdgpu_userq_state_start(queue);
>  
> +		if (queue->guilty) {
> +			/*
> +			 * A queue that was reset for hanging must not be
> +			 * re-mapped: replaying its command stream faults
> +			 * again. Leave it unmapped for userspace to recreate.
> +			 */
> +			return 0;
> +		}
> +
> +		trace_amdgpu_userq_state_start(queue);
>  		r = userq_funcs->map(queue);
>  		if (r) {
>  			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
> @@ -833,7 +846,8 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	args->out_qs.flags = 0;
>  	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
>  		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
> -	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
> +	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm) ||
> +	   fpriv->userq_mgr.guilty)
>  		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
>  	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
>  		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
> @@ -1594,6 +1608,10 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>  	int ret = 0, r;
>  
>  	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +		 /* Guilty queues are not restored; userspace recreates them. */
> +		if (queue->guilty)
> +			continue;
> +
>  		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
>  			trace_amdgpu_userq_state_start(queue);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 40228c60a1ea..f2eca744a3c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -51,6 +51,8 @@ struct amdgpu_userq_obj {
>  struct amdgpu_usermode_queue {
>  	int			queue_type;
>  	enum amdgpu_userq_state state;
> +	/* Reset due to a hang; must not be re-mapped, userspace recreates. */
> +	bool			guilty;
>  	uint64_t		doorbell_handle;
>  	uint64_t		doorbell_index;
>  	u32			doorbell_offset;
> @@ -132,7 +134,8 @@ struct amdgpu_userq_mgr {
>  	struct drm_file			*file;
>  	struct mutex			proc_ctx_lock;
>  	struct amdgpu_userq_obj		proc_ctx_obj;
> -
> +	/* Set when any queue owned by this process is reset guilty */
> +	bool                            guilty;
>  	bool				proc_ctx_allocated;
>  	uint32_t			proc_ctx_array_index;
>  	/**

