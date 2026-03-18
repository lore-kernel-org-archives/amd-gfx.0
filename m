Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F5CFCD0C5
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 07:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DB510E6D2;
	Wed, 18 Mar 2026 07:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qu0EJ0Ul";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DD510E6D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 07:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WS4MJwR04dR6ora+IoWcdL3U7J5/ixTuw7ESl66ls7AlYpGXEHcyJD9GW/NtdT2PFaDb+ZKuJc/Bd0+er29z9UaTl/ZmqgO1Y3r6BOUw4xXSrKtgTYCrnK6s6M4aM9lAQSZSrcxbdFMhYUIn+oIEFh0SLWJYKbbD9n6JCy+5YeyM5lskNbUpX2lCKk5im0l4Ja75GJ8r4+ZNpImrtDJxlEnnfzIFlKMPk0ImmEN4wMlP+Vm2UbvmuUORKffPvu5dYF6kK7VmH57dpWmcOr2Q6kf7xfUPYK8EdvLw0LQF0XJNUwW4lDtGxTknDlZiAPMVwbzg8qKDfwoh37Flv4Kdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jfjvb+fWrWQ7kmCwmvYICfDdSFZ+zVMXZVRBBHqnA3o=;
 b=QUAa6gNJRReWBBDdQzCBoSoaCoIYtJ05Mp63apUTFAxA6ZJpAd8DlZdlNLgJcv5TXsIBtHK9BB+qxgTbL+iXgGwFwgJkNB8GFAa8NxMV001ZEAQSY5Czq7LRNf06DUsWJiwZwzFuTTDzdhXoxNQyaMkdWfT1QgH7vBTGWcWGjVYiuZwNz7vuB2tGvTGJyoSiP7694ZqffDqU9SUHNcFtjOvMWNF7pt5QaJF1IsTSaTfKxCRpVZgkR7/MFvDi51Mz6Wv6/6JbSaC4jrhvR7J7uUBdOAXU4RQ/tGDrUZaXPktgcV3pb4PweKaH80Wb79XHpTe/YLMVTiYIlcSCAnpIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jfjvb+fWrWQ7kmCwmvYICfDdSFZ+zVMXZVRBBHqnA3o=;
 b=qu0EJ0Ul/zCw0KJrNWZh1iX3zAa1TOgYdh8ffQI2hp1lZttQZxRnfj+xSR6g9QQ14uT7BQPNqYWwugZAgUjm5MHPj5QS9ESoD0xw9K09jCmfBpHRKRE4M0NdhHJCSCgqZ2UHCtLqofK/1WeBYhGsEp4dxbEZJAXPBCVZu766rVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 07:50:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 07:50:56 +0000
Message-ID: <8289856a-5c23-41d9-a15a-5830ea7cd3d8@amd.com>
Date: Wed, 18 Mar 2026 08:50:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Avoid NULL dereference in discovery topology
 coredump path
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20260318044734.1975271-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260318044734.1975271-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0393.namprd03.prod.outlook.com
 (2603:10b6:408:111::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f06ed59-91fe-4148-37e4-08de84c31687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: xJt59Fw3cCfViB66XuMLau9fSc9Qe1NPpZpjsgOTCkKFctcvOxspTCUDk17ptA+UFbYyjb7NM+wva7i0CLk2/wgIwDOZiilnEu1AJl/3UkDIcKV/zL8XylHFQ5WN8wstquBa8W1eKW3eqLDNaRK8QJ3ttMMfXMW48bz+RJEdhdlVzTSLR/9BW+CbcjjER9p1hFWkAI4rB6GP3I9qaWapjX89U65A9tWMivDyE8u2P08xhguEn4lhV6SW1did8WdKKBlxxS1EqZv+3UmArEVsKWxS9h62L1p5V/pdxqhULBU1ttOcVLGcU8LiU/w6Dm+sGj5kIVJcpo/5K2GqBx5M4cOtwmKb0HpSgNnX+2YGrLQmaaXAFL1BKfbSo+HuMVMNkMam2sb+khMRPlSfO3arDROs0DV7vTzd3ptYw7KdqRbOu2s49KTaKuLdCtkgr8ykRrP+CrRr365G0s97noxwKmBctph4xM4yJirjQ1KIzGo+dWIic8o8qmcs71IAEVrIl/2BbDm/qIFwillqUFEnXmdkqiZyJ7Q8xMQj0QUqRRX4MiAYS2Oeu9zSC2eqO/jyYFd+E9Fq6dijZDDpx6f/0lnY081GQnh+zRbunr9jhEg6FDWc60VAk9iROfxZdPcWhybbMrPpEKyH77b9Hp4HiOCM/Hy+eDTAauzTWoFLuvbVaEMS/n1QMurJ6q/U1mfkg9zzJm6M98FAeu89zIj+vkp+w91RayldnGDK8xD0nUM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UERGV0t4QThxWWNvSDZnYmZ6bmtJRGdVUVUzZ0ZRTDhjbUQyWS9XRXNKSWx0?=
 =?utf-8?B?VE5IcFd3ZUVvMUFERmZJczRiUmxhSUo5N01maHVwZTRIKzBpbkpiaituekNY?=
 =?utf-8?B?VXBoMlI1MjJ6TFUxc0RrK2ZBekp3R0RGazBwRTZDOVhhMWZjOFVIbnRIalRl?=
 =?utf-8?B?RnlFcHA2NlBUN05FYzkxSzI5M2RVVjJZaU9OVFJUbmpjTktmSVN1Vk5vbzJi?=
 =?utf-8?B?ckxrMzJXKys1eG4rNEVDSTBxUHFvcVVwM1phSStMUjlDWFE5WnoyWFB1UFFT?=
 =?utf-8?B?cTZ0MlVsRnAzRWFZcDhlOG95OHhiNGM2aTlHa3kwdVRpMjd1R3JIWGJGRkZ4?=
 =?utf-8?B?MnM5QnMrOC9pWWsxM2l0NkZ3TVF1aW91SmVNZDBaaUJMWjRnazBFUFJESysy?=
 =?utf-8?B?WkNrR2sxOEFSMnl3YjJjekc5aUZYcURVM3p5SGpkQjVVVjQ1MmNDR2Z1bFN6?=
 =?utf-8?B?NWsvanVyNXp2RVo2T1pOMVdHY1NoRU00bDdjMG15R1hRbm5kdWI3d0djM3RK?=
 =?utf-8?B?bmhqOEtpdTFGbVcvMFBIRmpubWJlZ1JPcFFUS1J3YXpkRGhERW91M3pTK3Rm?=
 =?utf-8?B?eXE1aFQwemF2V2xqM1FlVzVnamtod0pKTmo5clI2Z2JyZkVNQVBsR3RHV0Y4?=
 =?utf-8?B?ZzhCdWtBQ1Q0NE5CdENtUGJhVFhiZWJKbStjUW96V1Q4ZUE4NWNBVW1LVjVU?=
 =?utf-8?B?RHFvQnJ0amYvWVpkaVhmeFhDQnFqckNFcHJWcjRla3dKSy92NkVEYm42QmJU?=
 =?utf-8?B?QkcvUmpkanZTWFZndTcxS2s2azYvdTU2WmFNQ3hVYkFzLzlOdUl4L1hWV0Q3?=
 =?utf-8?B?dGRsUFUwZnlhTDF3cHhqc3NqaGFWWERua1B5bDB4U3NCMUc1ckVwWVZLaGhF?=
 =?utf-8?B?dmozYjZKQ2FaUG1JWnowc1N5d1BQL29mVVNOR2FEVGltMkVPVXdsRExyaHgv?=
 =?utf-8?B?THdDWW05ZnRQQWU5d3FzKzZrME5uR2FTVkdkUjBVeHJuMUQ5MDBFYWVERWs4?=
 =?utf-8?B?Uyt0YzRIdkhKZTJRWDhVVlI1b1U5V2ZiWEVJZmdIVG4yZ2pHZmU1QzdFRzlu?=
 =?utf-8?B?N3poUFZGVExXWXdmYklVRlJUbE9PVStLRk9OMzdVT3paTjBiUm5adGVCRlZ1?=
 =?utf-8?B?OHZVSllrUWxlWXlRL1d3U3hUYlhrU2ZaU0hSRVh6M1liRVNEcGZOV0NLdFJO?=
 =?utf-8?B?SkpwSEJtWnI1d0ZaTGMvZTZIM1VpdmdqNWp0aHFhdnNNZjIvWFJZQlFpUEd3?=
 =?utf-8?B?b0FkZm1WeHhCNllOQnR0QXNpWTRFYTFRSjFzZTFveVBDMFhYTjN6V2FhaGc4?=
 =?utf-8?B?ZHhmdFlFZjNtdWhYTFVRZ0t0RTF4Mm90RXFnWTdsdzFkNC9GeXIzMHZDN3lU?=
 =?utf-8?B?TGMvNTlvWnlIK0FIWnVHajdVMmhpVXZPbzQvMHlqSjdsZ2RmVXFHazUwaFVj?=
 =?utf-8?B?UXFTU1F4Z3RGakk0QlprWnlReWNpREJSRlNYKzBQc1RXaHJhUGxGa040cFpK?=
 =?utf-8?B?TlFyV05BNG5XcHA4eTdxakh3R3J3bXJFQXEwRTN2TlVTT0VMQVArbmd1enlo?=
 =?utf-8?B?b1ZQaG53RmkwbmxlV2k4Zk90eVhWS1RFc2ZmZnZhS2ZleHZvNWh5bWorekJx?=
 =?utf-8?B?VzAwbkxxa1U5RFBsWW9RZ3Bwa3ZidGdPZDYyVFM4VmdIYnppbzZFYUZNUTN6?=
 =?utf-8?B?YVE4U3lxK2t0MytTV1FNMDliYlBMVWlyaVYzcUZHbVJmWXVCZkJKOGxNUUVM?=
 =?utf-8?B?MFFmM2JGNTYzdkkzdXpad2dMNFdKVzB5UU5NRmZaT1ZmWkY4QTlDaysvczB2?=
 =?utf-8?B?VFV6TWRTaUd2NnlaS2R5VEMxYlFVUUJSb0NmUm5GL1BmWE5LK0NBRWM3cUNm?=
 =?utf-8?B?VkMrdTVRUG9iQVdiRFJmWS8wbENyWXBTSjRxdHZFQUd4anBrQ1JHR2N5Sndo?=
 =?utf-8?B?U09DVGtPWi9HeVJQN04xMzVVVlFPSWI3dlM0cDUvdnZISVViNWRYSUxjRDd3?=
 =?utf-8?B?Q2FERVlObnk2UkIyd1pIVTVTbmdqZGxtbmNYOGNlOU5USXVsQjZVNXFNL2t5?=
 =?utf-8?B?cHh6TmVrQWFEcG4xalUrMm9QZ2lyb3dnVFJ0UWpzZHUxeDJHWDlMcnI5d0to?=
 =?utf-8?B?RXJVS3lucWhUT2drcmJxVlJudys4bzJveC9jTEhjbkZBYVZGb0NJQlZHZW1q?=
 =?utf-8?B?S1hvNjIrblZUVkJoTHNvdU1DUEphMTF0RGJhQXFKOGlwcEJIeUJtaFgzSnF2?=
 =?utf-8?B?c0xUVDlIZWprUlBHVXo2eXViU2x6OWc5Z3VvZWVBZ2FsbUpGaUZOMDVVUUJE?=
 =?utf-8?Q?5GAYO2s4k9mKyZjnDn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f06ed59-91fe-4148-37e4-08de84c31687
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:50:56.6453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmPSEPyDm1SiR6UuHkGilMqyF4yektijtfAO7b4q8nTC3yeWxLH0lFuxBLqxVwoa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169
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

On 3/18/26 05:47, Srinivasan Shanmugam wrote:
> When a GPU fault or timeout happens, the driver creates a devcoredump
> to collect debug information.
> 
> During this, amdgpu_devcoredump_format() calls
> amdgpu_discovery_dump() to print IP discovery data.
> 
> amdgpu_discovery_dump() uses:
>   adev->discovery.ip_top
> 
> and then accesses:
>   ip_top->die_kset
> 
> However, ip_top is not guaranteed to always be present.
> 
> ip_top is allocated separately in amdgpu_discovery_sysfs_init(),
> and it is explicitly set to NULL in ip_disc_release() during cleanup.
> At the same time, devcoredump generation runs asynchronously in a
> workqueue. This means the dump code can run after ip_top has already
> been freed or was never created.

That isn't 100% correct. It can't be freed concurrently, it can only be never created.

When it would be freed concurrently we would have a massive driver bug referencing bug.

Regards,
Christian.

> 
> The current code does not check for this and directly uses ip_top.
> So when ip_top is NULL, it crashes while taking the spinlock:
> 
>   spin_lock(&ip_top->die_kset.list_lock)
> 
> This leads to a NULL pointer dereference in the coredump worker.
> 
> Fix this by adding a NULL check for ip_top before using it.
> 
> - If ip_top is NULL, print a message and skip the dump
> - Also add the same check in the cleanup path
> 
> This makes the coredump and cleanup paths safe even when the
> discovery topology is not available.
> 
> KASAN trace:
> [  522.228252] [IGT] amd_deadlock: starting subtest amdgpu-deadlock-sdma
> [  522.240681] [IGT] amd_deadlock: starting dynamic subtest amdgpu-deadlock-sdma
> 
> ...
> 
> [  522.952317] Write of size 4 at addr 0000000000000050 by task kworker/u129:5/5434
> [  522.937526] BUG: KASAN: null-ptr-deref in _raw_spin_lock+0x66/0xc0
> [  522.967659] Workqueue: events_unbound amdgpu_devcoredump_deferred_work [amdgpu]
> 
> ...
> 
> [  522.969445] Call Trace:
> [  522.969508]  _raw_spin_lock+0x66/0xc0
> [  522.969518]  ? __pfx__raw_spin_lock+0x10/0x10
> [  522.969534]  amdgpu_discovery_dump+0x61/0x530 [amdgpu]
> [  522.971346]  ? pick_next_task_fair+0x3f6/0x1c60
> [  522.971363]  amdgpu_devcoredump_format+0x84f/0x26f0 [amdgpu]
> [  522.973188]  ? __pfx_amdgpu_devcoredump_format+0x10/0x10 [amdgpu]
> [  522.975012]  ? psi_task_switch+0x2b5/0x9b0
> [  522.975027]  ? __pfx___drm_printfn_coredump+0x10/0x10 [drm]
> [  522.975198]  ? __pfx___drm_puts_coredump+0x10/0x10 [drm]
> [  522.975366]  ? __schedule+0x113c/0x38d0
> [  522.975381]  amdgpu_devcoredump_deferred_work+0x4c/0x1f0 [amdgpu]
> 
> Fixes: 7083eb8982fb ("drm/amdgpu: include ip discovery data in devcoredump")
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index f7f37d93d0ce..40ce95a604ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1395,6 +1395,9 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
>  	struct list_head *el, *tmp;
>  	struct kset *die_kset;
>  
> +	if (!ip_top)
> +		return;
> +
>  	die_kset = &ip_top->die_kset;
>  	spin_lock(&die_kset->list_lock);
>  	list_for_each_prev_safe(el, tmp, &die_kset->list) {
> @@ -1419,9 +1422,15 @@ void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printer *p)
>  	struct ip_hw_instance *ip_inst;
>  	int i = 0, j;
>  
> +	drm_printf(p, "\nHW IP Discovery\n");
> +
> +	if (!ip_top) {
> +		drm_printf(p, "ip discovery topology unavailable\n");
> +		return;
> +	}
> +
>  	die_kset = &ip_top->die_kset;
>  
> -	drm_printf(p, "\nHW IP Discovery\n");
>  	spin_lock(&die_kset->list_lock);
>  	list_for_each(el_die, &die_kset->list) {
>  		drm_printf(p, "die %d\n", i++);
> @@ -3028,7 +3037,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  	}
>  
>  	amdgpu_discovery_init_soc_config(adev);
> -	amdgpu_discovery_sysfs_init(adev);
> +	r = amdgpu_discovery_sysfs_init(adev);
> +	if (r)
> +		drm_warn(&adev->ddev,
> +			 "ip discovery sysfs init failed: %d\n", r);
>  
>  	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>  	case IP_VERSION(9, 0, 1):

