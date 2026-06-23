Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67947CDB470
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 10:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA92210EA94;
	Tue, 23 Jun 2026 10:55:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SDIyVjvV";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B4B10EA94
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 10:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMK804zsgXQRs5Id7a/OkYPmG+8zPiRiC1A3eB2JZ6NQdLu+81b1Xq+e8Xx396YGcR4knsHJPuZRr2y4nRYw2S1HLXrspcXPbyPQB328IAtOBv89aaOYTSUozyJGmZkDnanO3DEwrJtns2lgRjNwcjAsXhavVCrCrb76IfdMTSfCNhPItLjkXm4iQereYS+5wQt4bijY3zJ9aI85BgeBm/brxx5F0qWVHFBdcd4igEeDLglC6uf0kgG/ysCl2oC8DepspT+3AChOkGw07OOXjANLndFooAhDZFhsIZxd+0XQ6ka7tPmcLJioPOwN0y68BACF9iuOkCbJrGlE7rI+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPmAV+yB88GdJoJudVD3UBSfsRXpaukAvM9qgwxZkCo=;
 b=vUvE3og3PUkBmMMUHJ6ScuhNrTWjzUYMZy7ZCrcQMi/vhtMjsBqSlxr4nG4Ot+Jc2Pa18AwfXP6gL+9HgTaczAbRNgQJVPDNT1iXf+SXrKg0+BqpkA4PGu8XV0k8mQqO+tJYtH9HHs8ZphXdLzhQjarxZnHGrIgo7nhZjWHgxQnLgPTmLO0c6Hwh/Ws6AkhjiSja0+5UZXWdzhx8wko/V20YniQWtuiD3a4VxHCEzWAGor4dFwbGn0FzXtfDsx98xLdQQnLaCuqsWxFYfpMP0QEjOKl4T7iE6AobD7ULs2caW4JIRC9eGNbQVw7VWfD9MS3gMUKz5LAzIALlemmC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPmAV+yB88GdJoJudVD3UBSfsRXpaukAvM9qgwxZkCo=;
 b=SDIyVjvVAFRnYoZtFx6/AjCxGeo4HA+Mf53iR0oDVjK8gO9gvE/Ukm6pOsvZcLOcLB338ESu03mUjlfgcq9tQNeRkLz3b/q+WwHY3VP8Zg9W0V5r8K24Z3ljGMH1UhZ24ZUYml7MDrZjtiMdaaJByhs0MZTipdGX8GrZgVlujls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 10:55:42 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 10:55:42 +0000
Message-ID: <006655b0-c8c7-467a-b0d3-fdd90be831b9@amd.com>
Date: Tue, 23 Jun 2026 16:25:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: protect XCP scheduler selection
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Xiang Liu <xiang.liu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, Stanley.Yang@amd.com,
 YiPeng.Chai@amd.com
References: <20260623042319.561959-1-xiang.liu@amd.com>
 <5c1d6a5b-e1e7-47f0-962f-55e390fe1da9@amd.com>
Content-Language: en-US
In-Reply-To: <5c1d6a5b-e1e7-47f0-962f-55e390fe1da9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0203.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 82371fa5-54e9-4c01-07fd-08ded115f7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|11063799006|5023799004|56012099006|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: 217pI/TmbffNADRwC9qY8Fz0nBeSeVadgNZ+qLTdeHYpe64LBrYC6WX6C1A6/ySH8zf4UqIMEXx2b/AtPuzVspN3BTtc5zfMXJDTy7yh2kQyyLsOCZyRGYk4vqbAaAmKD4qgVrFJXChbQQDZYAUpC2OK5962/KUO/ZcGAD0RSMz8I/G0xMq5bm2tyjO+oXWIddVxRgK67WQQsIhbHMn4ve1NMWf6VaJRJeFyBQUKTSjTyDWyEzaz+iwYgNtwdcF3MigqNTVe6DQ5Yh5Em0eO8rc47oIiOrHLkSNNE+/R31Do7XeuGOYBl89IJ/j+WRdIpBJRQukBdHBqrVVGwxCQr7Q1VcpF9j8k6q2nkujHmkVf7WTD2HyjG462GoN85aifwAw1gYEOV7Wj7Vww0nsZi0XKAQV4iA0waNtVIWRRx1+S1IfAC1siR+gl7YIQOwf99QQ8oSsHee1pWqDO5VBjlvLJG3aQUp7H7tyoNarnSMFpfBKSYRWSVTwtgyL+X6PK/BVJh2qjurnKyjsiv0b2vmJ51XJwcFUOGfV0xxxKiKFnyrUypydYkJPvSYwuTNujBFh2LP7Kuiwx5gQ/SVMdrAa42TPA8LjxRmzgdK0aLwg6CP3Pvj/Lfs/vKfbWMSkppbSJbij5IG9TBA+l+RkcdY/a0ZIUqzrkRFXUP7guXMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(11063799006)(5023799004)(56012099006)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enlDUFNvYThMS3RLQjBVTjlnNHZ2dWNaWlFyNWZObDE1WXI4WjNza0N4L0tM?=
 =?utf-8?B?b3JHdU1OQk4xWWgwMEpmeTlnVlR6RmVPblZDOGxYdjRoLzMwN2k5YjI3M3Bh?=
 =?utf-8?B?WTgzUVNuUGRoL2c5aHFEd0VnVDA5SVFINlhlZUFCTkNTS0FXd1p3R1NKVlVt?=
 =?utf-8?B?eHZROGUrem9RNk9Nc292YlVVUnFPZlFWY2JZendpcm02V1VEaDlaM0FsTUtJ?=
 =?utf-8?B?cFNkaHhvVnpyR3RDenNlOE53Q1lGUS9aWFlZc1kwcWtlL3k2RlRrTWJEVnJB?=
 =?utf-8?B?S2JlSXVMbUlsT05nVlJ2Yk9hZTZHYjRHZHhuUFVhbnoyQ3hEeW9QTnBrVXNx?=
 =?utf-8?B?Z0FWSFFxS1lvMFBjemxEOWxyRUdFOHVQampRQldLUmx0eDJIRGx2azVEays4?=
 =?utf-8?B?WXlJUUNuRXJ0dGZOVXpjVWgvb1JsaXUxeVpRQUZNSTJUKytYbEdWelpERkNp?=
 =?utf-8?B?a2ZmK3dvQjRKOWNkZnhyU1VXeWhjbCtYYzF6cEN5a1luVC8wa1R1NmRUS1J3?=
 =?utf-8?B?NmJERnl5bVZERFNXdFdJZm8vaEZScitPeXhlN1F6Yzh2RDJTWVlFcHcwWmxy?=
 =?utf-8?B?amNNeUsvbjFMbDlaN1lwNzdQQldqWk5INmc4N3BHVkdXRDZZbkJxdExDTy9w?=
 =?utf-8?B?eEwzcnZBUnFyYkExUFNrMVpYc201TlNmTEFWZkl0eEsvN2VGZUNrWUNjdExV?=
 =?utf-8?B?Z0p6K1VKSjJpc0JuY0RPV05CRTBicmF5VWIvN3FJMEJuSHVMc3JrL0UxcitQ?=
 =?utf-8?B?T1pYTXdSUEVBeVV4RFp1V1IrQ0huQitmQldjSmlsL1prVmFuZzMzRFVpeE5D?=
 =?utf-8?B?VS9vYmJnOFNjZFYvVExHaENLcEZ1SXZVa2RJcno4cnV4eXlhODJUMS9PdE1t?=
 =?utf-8?B?NlFPeDZwamp0UGYxNnRvL0t1T2syUjFuaXRjRUpSSzlmQk1qcmMwaUk5b1pG?=
 =?utf-8?B?dzVYaStIWlRlT2h5UjFtSzVreGlQYUdKZHlRWU53TER1T2V1WUszTGpYTWJW?=
 =?utf-8?B?cys3Q3NNVEZrK2F3Zjd1M1hGVEJwOXlNYXdVUE01bGdGQlRjWkQxRUptM2NH?=
 =?utf-8?B?MndMRDlxa3VIaFNHZ2tWL2ZMVFdxYks4WS9XN0VlWElUNmsvVW5EMW1qb0FP?=
 =?utf-8?B?TERmcUZUSWc0Njg3OHRJUFlGVGxBbVEzS2srM2pnTlFsRXE2ZW1VempvZW9y?=
 =?utf-8?B?ZEJidzc1R1Q1SEo3VzNrb3hKd3RhYjRNMWxEUzZzQ09wTHliN2w1bjdTS2xC?=
 =?utf-8?B?OGNseFM0VVBoYmlHZ0RvbU1wZENla2hUdy9GMHZhM3V6aWdnQTRTRDRtWm9V?=
 =?utf-8?B?TDlCZjJmeXMxSmVOdEsydlZYQmw2KzJSMVVNN2c0OFhGdktGSWdkUTBVcUNC?=
 =?utf-8?B?aVdHTVZMT3U1dEtvQjVLb2lnSzVVOXNhTVM4Q2F5RjZIQVdVb0ZjN3BuZWpH?=
 =?utf-8?B?OER3SkhmbUNaQXR4RXZzVjBnMDRsSkdWYUVxMGJId0NyWEtQY2xhUk5Oc2tt?=
 =?utf-8?B?aFNpZVIzdTZQYUZqdnF5U0VxUWhTYWN4NG5RVk9TWS91WVZiYlRqSXU1cnhZ?=
 =?utf-8?B?S2RibDE5akkrWXJReHUrU0p5blQ3bXdNYXh3S1FiSDBBWUVvbUxmWlhubEl6?=
 =?utf-8?B?azZEdWEvRENMT0V5cGxyR25YMVNMclBOSDFDcFRVK0FGOG4xUDVubmlyUEVI?=
 =?utf-8?B?VU9VSXFlRUFnVDlFc3MwWjZ5SnpDMVpzN05ZSnlWbWt6ei95ZnE2NWZ3UXg3?=
 =?utf-8?B?d3N1RDlrZ3dmcU9rMUxqMFVkeTQraW8vSHNoNGErUjE2eE1QMFhZTnNhdHpI?=
 =?utf-8?B?WTdaMmpaenQxc1lmOFJNSVhDeUhRR1BOMFZ3OSt0eFpxRFVxVzhFWER3SE5n?=
 =?utf-8?B?emVYRTBtMWl4T0xHTm9lSjVKNFI3TmFHb2hrMEFPRWRvN1NlK0tLRmdEQUpi?=
 =?utf-8?B?MjZRUHVJRDAxTTBld2doRUM1M3AzRVhBVVJ1c29RdWJGTExGOHhQdVBWNS9G?=
 =?utf-8?B?bHhteEJzUEh5bnBJYzg5QjlVeExzVXB3WWt6NU5sV0lSdHhJNVV6WHpPQk1J?=
 =?utf-8?B?bDUxR2JpN3JYS1B0K1Z4dndEcFE5M0xTY01aaW9PZ2c4aE9WN0tuKys5Q1Fy?=
 =?utf-8?B?QVhOcmU0ajFZd0V5b1VkMXNTQmUwSjVkTGtKVHpBQ0UyUlNHVjlLT0s1U3Rq?=
 =?utf-8?B?cnAvb0RmWjY0VkhrbGh0dWVhZlF0QW54ZUhsQ240UXhRZVZZTGFkR1R6Ti9w?=
 =?utf-8?B?NkwwUVJaQWNIekg3RjA1bUFCVXV4RkpXZEN3RTUxQmIwcFhxOGxuemo3aEln?=
 =?utf-8?Q?5FUPVs3R4HGA6aHEfj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82371fa5-54e9-4c01-07fd-08ded115f7ff
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 10:55:42.0155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auYbae1DwvKccloo+d8mLElpSTTdbQrsO0KRsWZJsTU6pT8GHmsZgn0/kNUxX6Y7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188
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



On 23-Jun-26 11:22 AM, Lazar, Lijo wrote:
> 
> 
> On 23-Jun-26 9:53 AM, Xiang Liu wrote:
>> amdgpu_xcp_select_scheds() reads the per-XCP scheduler list.
>> Partition switching rebuilds the same table under xcp_lock.
>>
>> Take xcp_lock around XCP scheduler selection and release.
>> This prevents readers from observing partially rebuilt state.
>>
>> Also revalidate the selected XCP id before indexing the table.
>> An open file can outlive a switch to another partition mode.
>>
>> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 37 +++++++++++++++++--------
>>   1 file changed, 26 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_xcp.c
>> index 88e6eab91bc6..1db7d2ad01fc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> @@ -469,16 +469,21 @@ void amdgpu_xcp_release_sched(struct 
>> amdgpu_device *adev,
>>   {
>>       struct drm_gpu_scheduler *sched;
>>       struct amdgpu_ring *ring;
>> +    struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>> -    if (!adev->xcp_mgr)
>> +    if (!xcp_mgr)
>>           return;
>>       sched = entity->entity.rq->sched;
>> -    if (drm_sched_wqueue_ready(sched)) {
>> -        ring = to_amdgpu_ring(entity->entity.rq->sched);
>> -        if (ring->xcp_id < MAX_XCP)
>> -            atomic_dec(&adev->xcp_mgr->xcp[ring->xcp_id].ref_cnt);
>> -    }
>> +    if (!drm_sched_wqueue_ready(sched))
>> +        return;
>> +
>> +    ring = to_amdgpu_ring(sched);
>> +
>> +    mutex_lock(&xcp_mgr->xcp_lock);
>> +    if (ring->xcp_id < xcp_mgr->num_xcps && xcp_mgr->xcp[ring- 
>> >xcp_id].valid)
>> +        atomic_dec(&xcp_mgr->xcp[ring->xcp_id].ref_cnt);
>> +    mutex_unlock(&xcp_mgr->xcp_lock);
>>   }
>>   int amdgpu_xcp_select_scheds(struct amdgpu_device *adev,
>> @@ -490,7 +495,9 @@ int amdgpu_xcp_select_scheds(struct amdgpu_device 
>> *adev,
>>       u32 sel_xcp_id;
>>       int i;
>>       struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>> +    int r = 0;
>> +    mutex_lock(&xcp_mgr->xcp_lock);
>>       if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION) {
>>           u32 least_ref_cnt = ~0;
>> @@ -507,19 +514,27 @@ int amdgpu_xcp_select_scheds(struct 
>> amdgpu_device *adev,
>>       }
>>       sel_xcp_id = fpriv->xcp_id;
>> +    if (sel_xcp_id >= xcp_mgr->num_xcps || !xcp_mgr- 
>> >xcp[sel_xcp_id].valid) {
>> +        dev_err(adev->dev, "Selected partition #%d is not valid.", 
>> sel_xcp_id);
>> +        r = -ENODEV;
>> +        goto out;
>> +    }
>> +
>>       if (xcp_mgr->xcp[sel_xcp_id].gpu_sched[hw_ip] 
>> [hw_prio].num_scheds) {
>>           *num_scheds =
>> -            xcp_mgr->xcp[fpriv->xcp_id].gpu_sched[hw_ip] 
>> [hw_prio].num_scheds;
>> +            xcp_mgr->xcp[sel_xcp_id].gpu_sched[hw_ip] 
>> [hw_prio].num_scheds;
>>           *scheds =
>> -            xcp_mgr->xcp[fpriv->xcp_id].gpu_sched[hw_ip][hw_prio].sched;
>> -        atomic_inc(&adev->xcp_mgr->xcp[sel_xcp_id].ref_cnt);
>> +            xcp_mgr->xcp[sel_xcp_id].gpu_sched[hw_ip][hw_prio].sched;
>> +        atomic_inc(&xcp_mgr->xcp[sel_xcp_id].ref_cnt);
>>           dev_dbg(adev->dev, "Selected partition #%d", sel_xcp_id);
>>       } else {
>>           dev_err(adev->dev, "Failed to schedule partition #%d.", 
>> sel_xcp_id);
>> -        return -ENOENT;
>> +        r = -ENOENT;
> 
> Doesn't this require goto out as well? Or, for simplicity you could use 
> guard(mutex)
> 
> Thanks,
> Lijo>       }
>> -    return 0;

Please ignore. Didn't notice this one earlier.

Thanks,
Lijo

>> +out:
>> +    mutex_unlock(&xcp_mgr->xcp_lock);
>> +    return r;
>>   }
>>   static void amdgpu_set_xcp_id(struct amdgpu_device *adev,
> 

