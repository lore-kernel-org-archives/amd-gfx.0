Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA415107BCF2
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 10:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FFD10E03E;
	Wed, 18 Mar 2026 10:22:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4AybqZ+V";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F7AB10E03E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 10:22:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmZmsK2WkkYLw4TxqxHaDVwwnpUncYD7mXRvM64dk5kZ+x3CgvSnzXefrY1BG7OUF04Zq2uEDlVDQAIAG6e8iQ7Xsl6bmzEvEirw0YDz8Ym5pRDoX2XGahit+JXhArJ25XmIt+atlVJCCMHlbsIZrjhb9r8S7tycmgWj4fZVr8Bhd5HuCYkbbhvYRWBwMpQYjLsQbUUtMXXHEUZBMIWIGPVZdBx5at4eQRdw9nYHzxvRyWSrTVMl/CPsI5CDRx3yD4ScCH6DVBnitH/GLzEb+TKm5LXbk9JXxkrKgxwYhGDMWQ9emJUnFfdozgwqL1o5AjGo0fhoBqXDt6LJ9AkE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqFe3lF8piAZUAlALYTqqbddBdyQbpWxfUJrdvCrwnI=;
 b=CW0OD+au1BAExhm1nUt9myQAtZBklxauwRPIiMMXKuLaT7QyyNPaHTts8G6p0nP/zRQrtBN7weovA8yXtCh2mcb0pdolXxvxMEuAu5tnjiNKqmyaRTfztSY1S+Et2LG5yzF/2cx9b+XIy63L/g5hfenoC9IaBs9NW0+axbfeBOCmBP+TURJdPUIVXzIpWM9eJMOGi6lL9st7TjGMrUCSxWSNpNExho0aYmDhCAKQHwLu0p6SimiFufYf0DEg3VS/J4VJVI/6H1oXcEGHqLvgkksIYqqAPsON5hQ1AL0geTrsWP6xj/xZryCYgPYOYDykwTGqc8q6IZbujSu99+8B0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqFe3lF8piAZUAlALYTqqbddBdyQbpWxfUJrdvCrwnI=;
 b=4AybqZ+VERSFJNFvnhje6kjT8dMD3XHlHnqBqQ96hSmjBSovQ+YgC3HBSUvlzavzYoEXdizDGh0EeWeNqnXVsNHxQ+6gd+LFCG1Xf050CbKY0LzPVTmNCn1rjTzP5jBOcNxYz7K9rIL6CvJpbt4LQwQz2ormeA2wiOcfOeFY4cA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 10:21:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 10:21:54 +0000
Message-ID: <52105602-a811-4452-8aac-ec8aa58ad606@amd.com>
Date: Wed, 18 Mar 2026 11:21:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Avoid NULL dereference in discovery
 topology coredump path v2
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20260318092314.1975879-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260318092314.1975879-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:408:143::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b19bf76-4aa9-4bdb-d725-08de84d82d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: VFvvjA2CNwSlMuJRckyC7bQuRUU7yU1XcVDCSGi8hkMhFjU8OCzlAkJwqMqciHmkAqXEXrQTiCLw0ITq8x5hIcyAOhlchhvjf0wFMpTQCoqyzMQbVG+xs88D4hFvl7u104jppq/eZrvGqjSsGA3qcsTF4CK0tSAkHXayjPTmCP9SB7bDdiU7zIk/eeEoWKmMLJ6HOylmFxWhWGy0Fp5QppOXXlpu3pZmhRqrNa45q3wMrBbDFA7jK33nSCj9eXQ1zrUq6CBmx42VcYCMAJPPgLJkXcCDSVjLjeS6oKb/qV14cZdk2eLtQ+sQDFdZ8EHewOkoZ96ItqW16M08aSw+oxkYRmMS9jXm057NSjWZBQZZ8NMDcC9m7Z0eTYXjXGdmmEONgW/GwwPpC92pE4j1xWxCw3KLlEThmH6JKDQFzHHmyqPw+AlXu1aD7CUeOUghRnETjBUpqAJepoEyH6jBRCSecVMrJArspnq21IjbbAq5hRVTHLvVUbF4t+ZTl9K7/hxtnDo5GkLZr7QhhL2ZzFSyblJ+n3ZwO7jGJ3TTTT6pHhOeQsh0pc1UzkJ+vebiwiFMYYFSQ1Zem6FhmHvQTf2ipboSYB53A3ZyDPgVy0S3asfeEKjXkoFlXDQg/9y/6kYYO70T0BQoICX+mshXYQTcdVdikB1jX2B56ytWXuZBJUdymFaMQMTrXaUYUgTDb3Zxbc6YSAgpAe667U2NPOfzBrps5SseaDe9I2l+Ttk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk15L1JKbWorRy8yZ29VUXhOTEtYUzgzMG5pMzRJVVFzbHNES2RtaDBlck1y?=
 =?utf-8?B?OUxTQXlRZktqZnZyb0FyM0ZmRDAzUUpWdVZjbFd0R3RVMkcrcmsrRzJtLzZP?=
 =?utf-8?B?d1ZYZFNHTExVTWpUaFViYTJQTGZiMWFlOFRoYTVuYzYzQjl5bmpEQ2szKy9v?=
 =?utf-8?B?ZmZzZlpOMm9xUGFyUUkvN3NCL3lvbEptL240R0w1c0lCVjlVM1pZQWI1M0Zk?=
 =?utf-8?B?bmFURkc5MjUvVDlHTE9VUXd2T3lwa1BDMmtRR2FCWGRHTmtXb3dNb0RkTXdw?=
 =?utf-8?B?Um9EdzhTZ0xuMm4zSG5oUVpEQzl2MndoaXErLy9kaHl6Z2hHaHBlQklxNzBz?=
 =?utf-8?B?Y1dadmZRY1cvcmdiUEZSSHF1L2RtTEcyZjZGNG1INVlEYTN1RzViK1d1UEJU?=
 =?utf-8?B?SEg4c2lDSW4yM0tPQmZROExTdVNxZzZmMlp4cVJhS2t2TUJkc0d5aGZxcEZx?=
 =?utf-8?B?ZzMvMUNuQ2lyWTNUZUdVVmZlcEgxSmFSV3JtRE9UeXN2MDQwd09rRWNIVDl5?=
 =?utf-8?B?MXJuUGorQ2p5emdwZ09tTDFPNUt6alJ4QVpzVkd6bFQ0MlhURU9zZlhzWVAy?=
 =?utf-8?B?YlJEQ2tQQTlRRWt5S05LQjZ4QnFjb3VibGtRNVRQdGxsODgzZUZDUmRjYWpT?=
 =?utf-8?B?L1ZoeFlZUkFjRDBDTHVaNUN1QUJzWVUxcit1aTBjaTdsL1B4UUl1TmxjSkdz?=
 =?utf-8?B?Q0FlVlBYMURPdDk5aTQxZ21iWVlhVkdHeTVzd0didmVxUlpPK1FJQis3aDcz?=
 =?utf-8?B?NWJmUjNQNEJJSkRyaFRxNzFXWUNHT3cwZXBBekxlV2llS3BzcDllTHRyajBG?=
 =?utf-8?B?NjNBeXdZeHdtV3pVMlROZ3NpZ0M2SkliTDNuR2tMUmF3RUZKd3N1OVBxUnR4?=
 =?utf-8?B?ak1lR3R5a25qSGxlRTMzLzRwWjZBNjBRbGhmbkZvbGc3S3VSTDRzN3JuWEhp?=
 =?utf-8?B?Z28vcURoSWFKU2xKMTBib1U4Y01iOSt2Y2l1alJDK3dqZWFjU2c4RGhTbVJq?=
 =?utf-8?B?MEJkY1RHQzFUWkh3SHdsQzJXb3BJbmJ4dzh2bVpxYm5kN09ITm1RaEJ3SkU0?=
 =?utf-8?B?VGdodU8yWDE5UmM1RmlEN2YrL1d6d05LbTFWVFA0YkUxZllhYnB4eERpYTJn?=
 =?utf-8?B?VWR0Ukx5UjF6czVhWUxOL3FlM3JaY0NKTzlvc2RLM3duaVFqUTBEUUpZTDRR?=
 =?utf-8?B?N2pyNDczcGNOcE1VRlIzazV2TlRlTjFDM2pTTXpNR3V4cEgxVCtWb0dtMTRS?=
 =?utf-8?B?OUV4eVhCdWdYQ2Z2b3BqZk1XMGxMbXQxOGVXbW9VVWtjQ1lvMGFwajhaUGZl?=
 =?utf-8?B?ak9mSzg2bTZQYWpnV0NDNEVpdElHRmM1NFNHdkozM2dBYVBKRmxrUnRTdGdJ?=
 =?utf-8?B?M0dJN004NVhSSndUTWtzV2MzeTJ5ZFlzZ29NV2czSkx4TzF0Skc1bkoxb0xy?=
 =?utf-8?B?VFg2T1QwU0ZoUXJYTm9MVXVSU0xWQ2tML2xGV3MxMlNLQjN0eEZaWDFRN2sy?=
 =?utf-8?B?TmVuR1dSb2JhVlhvOHFqcm4xODUxTG9Za0JUY3NucTdyaTBPQXE1SXoyeWdk?=
 =?utf-8?B?bTRCRFJvTmkrSmZ4YlA4blFCZzQvR1ZXSVIyc3ZYTTJVb3VNai9iWSt5bkVh?=
 =?utf-8?B?YzBFUlBZQ3FIaHpqdFJpNjg4VUQ5L2U1MnhldVVSVEpibmVKNnN1YTIyKzRp?=
 =?utf-8?B?NjZwWWVHd0liSlUxTFI2NnNrSlkwMW9ibkpzNVVLcWVDVWgyaFJ1cUlmc3hB?=
 =?utf-8?B?V21ab2k0S3hzV2xMdWFoN3o1dU91RlN6TVVqc3U1dWlCcEFGVjNwZXArbU1F?=
 =?utf-8?B?S1Z2d3FaTFVnNXFHY2twbFlqWkpsVFAzTWZUTGRvM2RlYnp3aC80WUhScThq?=
 =?utf-8?B?THpOWGNWd2R1YVFGd0FkQ3NqVVhncng3QmNqekI3SzdCYlExSG1WOWJBYXpt?=
 =?utf-8?B?bnVWUzB5ZGUycnh4YnlEMnZLVlFFWHhpdEdobllhalNZYkt5NkdsMTE2NXV4?=
 =?utf-8?B?VGlaQlRZNmVnV3RFaURWTW5EMlFIRzdwdS9IUnU1aVhjaTNkc2VieE9BeGZl?=
 =?utf-8?B?TUZFbm1nbkVNMGUxb1M2QzcyY1RheElDbHE0djlqWktZMkx1RDF1cHlWckRW?=
 =?utf-8?B?SzlMUWxFQ2RscFk4UTh1Nm1ZVnJxVUpuYmRUcTN2Mnl1NExBOG9rb3o0RXF1?=
 =?utf-8?B?b3lrWUJEN3VmU1lHcFEwNG0yYWtKeHB1cjV0THgrTm9jb0VXenpFQWtncjQ2?=
 =?utf-8?B?RmFnZ09kV3JYZkYyeDB1MndKdVdta1g2bmhhYVFqYk1JZ2xNdHBIVUFhVXE5?=
 =?utf-8?Q?5jj0uIjoVfy56Qu/I2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b19bf76-4aa9-4bdb-d725-08de84d82d5b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:21:54.3334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fTKP57/KyYPhq1D1AuumsswlccubP1yCtZE77aSdjkv7WDB1yjwVTeSTzlkmdFr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925
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



On 3/18/26 10:23, Srinivasan Shanmugam wrote:
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
> amdgpu_discovery_dump() uses adev->discovery.ip_top. However,
> ip_top may be NULL if the discovery topology was never initialized.
> 
> The current code does not check for this before using ip_top. As a
> result, when ip_top is NULL, the coredump worker crashes while taking
> the spinlock for ip_top->die_kset.
> 
> Fix this by checking for a missing ip_top before walking the discovery
> topology. If it is unavailable, print a short message in the dump and
> return safely.
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
> v2: Updated commit message - Clarified that ip_top is not freed, it can
>     just be NULL if discovery was not initialized. (Christian/Lijo)
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

I think that this is superfluous here.

sysfs itself will complain about files not being able to be created.

Regards,
Christian.

>  
>  	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>  	case IP_VERSION(9, 0, 1):

