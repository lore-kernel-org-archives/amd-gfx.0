Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F26FCC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C27710E176;
	Wed, 14 Oct 2026 12:27:56 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A00010FD10
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 12:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jt84t3lw2tFdOCyU8YQzhAZe/VAsUz7DGJa821+eICL+ePuTipgxgKRowybcFZbhrRmE5H11ybpuW4HV7r/Rm/NiaECW2BWDDLuBwCFtDmCeYgYd9xAsfrL+BUC81+sMpYYQqZJgSFc0kjBIhNdWkpu695byNnTQ328WQLUkMS6Kkp3iCeBA6Ds5n1FdcdFMq/Rx2Xfovfyk4u4Mw8Q84XgNOsJ7irSJlY6FMtkOV5bM1uOvb3/1WO3IrJ2JCJ6mD/GtZ6oyVU0ZD0vg7xNzI+qJsuDeHp5mGJZfe8tC9I6QAVFG1aQXeBKb7yEzFQ1AbgpmlY58SS/mTKQ7jpli3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfSBq/tPgUzcwRGbc+M4VYuyHqH8yoYB0BqMokTacY8=;
 b=ku0NIG1bYNfn4fwtc/YSlqrzKwQ5JUFEpF5e7jksvo1+N2kE2tagef4tJ/78CH7QtRlxGshNI9uIFnuMc4Q23W5UAuhpR3iwoYDDiS4A+EWRNf6KSurwKIJDgvp1gV9PPkrtnLjck1jDm7nWPFhKt3nN5W76A+eBsLJ8KubOu/vJrldGkKpMaWGIJ2YHnEFjVlkYxd98SsnjHG9U00KcjU6PEjyMyu5NEp+e9Gja1p/4w2MlIulRXkErRbH8oMKC0ob8mCBaLKNE/Yl/ve6eeDbMMLioRBTGiD6QvmUyh4AagWI3HNX343u9/VRquBIQbXhAUKmIzdVxt6Jrb/+xAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfSBq/tPgUzcwRGbc+M4VYuyHqH8yoYB0BqMokTacY8=;
 b=415IADoKLr8WoYqnxhBN7MzPLB6nm3+g031KrBCNO3WrkayRJ1b0ToBtleLmddSr092M7hfcOlQ+7lmweXfjzK5aITNofSxhR/8wtPcE1189ae4uL0fnAbWOaSp4WFoot5FcP32eO/hNZYhzU4LVYojj5RKl2n/VEJ0V6FZFgMQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 12:27:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 12:27:45 +0000
Message-ID: <fb2ac81a-59f2-4427-9801-76bacb3c01e3@amd.com>
Date: Wed, 14 Oct 2026 14:27:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Cc: felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org
References: <20261014101257.74329-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261014101257.74329-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4d5cd6-3f88-4d43-0c2f-08df29ee8ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: rMBjs0VXXlGOidLr2zg3ffpm2jWSRV+If9SSv7RnubFATvPT8ENfgb/HvFbowGDToXaQu5sgq5BUknN6PHlO+LsfLuVCBmEfJ+QhEqZybEl1AI23qm+OC2Y9FNYnnZBf06hZpUl/abeph/pqlCRJgj4TKz0eykCdOyg/554Ze4djnIkqjJYkll8Hm+DIkBZKekjSnz0Y083HB5y5FVjB1Gv9CU1WB/5HEZOWZT1JUTAndD0PcnWka8ZlVBv8kpD5Z9Fv3mQmi/ebGmb8wBuOUSQfDyOb+beKo6hzWijjVpeAf0WTLrufWoTQTrHTnYZ1MfSl9Otj1J6CTgWCyMTIsbMm0XCIfIDe9aX48ma899aspZYBntq68J2wOBfo0Tg1oQp30G43SWyfbpdFNG6bvy5Qq7Qxj4ooMSNheuI8XuNCv+RmUAxmQL+gssIUCAhNCC5BiMxiLE6sd4z+RO1FxsHhGJWI6rJVBvdfVWn8JNAofs275n0UXfVlWj6bAuQ6x6+EkM0UfaMW/rgHpd/tNSt5GvW9/Dn+H+AuoIocIn4Ty2ngEFTaOftajyM1udKbkVd9fsG2Oh6OLrmCzO5c0DeBgyLxjyeDB4RmRWY+jTM6UhVV5XQdK7yOUOP0HbnAp4BPbY7RfFyJ8eZKB4R7lEu+PezmLUTRmmbDhWswRb0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWRDU0N2dnd1MXJyN0NPNUZqSGQxamk1OFFJT2E1c0FNYjVwbmtCYXFKQlFG?=
 =?utf-8?B?NjlpRkRYMFBvVWhBcTlBRGg5aFpLQ29qLzFlQjVCdjA4NFMwcFhHd0doMWpj?=
 =?utf-8?B?dGxXWXlpT0RiN1FJSG5iRC9KOFN1UllzYVpUMy9YeUhTZWV1T3VaYURWcUt3?=
 =?utf-8?B?UDl5dXNYQmZ2SG0yMHFmN1pDZkwrSk52eW16cVpMR1hjRFNTdFpPaWFNakNO?=
 =?utf-8?B?MTJrNTVHeGpzQlNDUnlnMHJ1U084WFN2bnUya3ppNkE1ZURxYzlQUUJVRHR4?=
 =?utf-8?B?WWp1Vkt5VTFVTnpoTFkrOTk0UHo5UldYWi8xVitSQTVYKzNDRXdRUVVJU3ht?=
 =?utf-8?B?cVBTQUk1YmVmdEdKMGlNKy80T1V2WXhsRTJyd01qQTFjOWpYaHJ0ZEE1MXY1?=
 =?utf-8?B?c0lYN3hnL09YVE52Z2Nacm9vQkZ3S2lZTzVCMHFNUFpYV1NZVndCd2ZXamEv?=
 =?utf-8?B?TDR3aXo3SFdkVjhlNG1iRWpBMGRPZnhYUEZXQmcvVHN1WngrOEJPS3NpZndh?=
 =?utf-8?B?YWRVSk5PUStKNWV0U2w1K1BybXhaWHJzUWtoN0RQQVJWQ3VneDNwTWRmMGxz?=
 =?utf-8?B?emFzVG1ubG5xUlFiRWJkMmVXM2ZHSGpmZS9qQWdIb3BCR3RpdDZsMlBxa3p3?=
 =?utf-8?B?ZHJOYlhVY2NsTVArMnBOSXc2b01Pa012OXF6TVBlN1Zkd2tlYW11RFF4NjJ0?=
 =?utf-8?B?MUFQN3FiZ0ZaN1krcjFFb04zanV0dGNJK2JhVG5GVzIzSEUzZjJxWXFvSHBW?=
 =?utf-8?B?Rm1MSEpwUkZUeVZySVI0dmQ4QnFCMS9NMWpVZUE1Z2QweGdyNkFxL05jSXdl?=
 =?utf-8?B?VU03dFlzTHk2b1lpL3A1NkZpTFJyTWFYckZyZndLTTYvbW9OWFJseUVDQkcy?=
 =?utf-8?B?VGFiVFhtSlU2UEJjMVBXUXJ6QXM3elkzVHk2Y05SUm02WkxBdDRiT2NVWkJW?=
 =?utf-8?B?OExnalp5Y1A3VlZ6UFNSWEtZS21TMDgycVRyUm5JTTBnbWx0bWZrWTNYcllr?=
 =?utf-8?B?U2dYcDFWTlYyOS8zL3dPUnovcWJUR0V4NEVnb3QveXh3NWlsRHRqK1E2Sk5i?=
 =?utf-8?B?N0V3VHc0QmhuTFpHY054ZkloZzNNckMxRUUzWUN6Y25yd2RnN291c2NQUGlV?=
 =?utf-8?B?aWR0RzVweGNNaHpGSUtRVUp6VXNoRE5FSnJMTXNYZmpiMkxqQmd6eHY1OUtu?=
 =?utf-8?B?RnRIY2dhREZubEcwMWRHc0plZ2tmYTJkMklkczdySnFkOTl1V0ptSXQzd0oz?=
 =?utf-8?B?d2xIVFk1bjV2UUF6U08rTVV5RTRwZGk2ejIrdUE2YmtRd1oyM0k0NlhCOTRR?=
 =?utf-8?B?RU9HamlsL2M2YSt5Wm9KU0ZrSmxXb2JLaHdNdHZaSnJQSGI1UUpwTEhIbFNw?=
 =?utf-8?B?cGt2QlBRY0tMUWJ5R1lTY0pQRmhwcXR0WDdWRVpvekw5R2FKaTRGbGJTMC92?=
 =?utf-8?B?L1FDaEVqTVl2ekR2TjZjV1dBVFZTa1drM1N0ellKVnVqZ1JLZHNHVXRhUWlm?=
 =?utf-8?B?a0hSU0xRL1FZQmJ2SFYvNjQyWks5blVBNTRvTzA3U3R5clRDQ1JsSWVoUVhl?=
 =?utf-8?B?MThKU1drcjFqdjB1UmJpcmRvNTdYK0lnZlBBTi9vRGhwdEVwU1h5Rmd2WkEx?=
 =?utf-8?B?QTFrc1FOL2RjWXFETjdGdTF1K21mclF2ZzJYYVQ4Q1BhcGNzN2RCS1NYaGRF?=
 =?utf-8?B?QmN0SUkyeW5iQnZvZnN5WDJyWS8xN2dvRzhHOHdNR2l2M1FJWUlsQkNGQU1D?=
 =?utf-8?B?SVc3b0JucTJmSDA3eENIZ3kybGM2VE9zV2gxY0Zpck5lcDM2WWhNbVU3N0J6?=
 =?utf-8?B?dzBZY0dIT2ZKUXNmL1JBck52SFBCaE5DSGJpbDFuN1J5MHpQVkkwNCttbEdz?=
 =?utf-8?B?ZUhERVdVRStXMnZuNDhSSE1ybnVXSXBGWHhaZEVyM2VYdmJacW5PbFpSOHI1?=
 =?utf-8?B?L3lyREJ4M3FRa2hMNElTVXlxazVPdkEzdkQ5MnNyYXJkYVJGdVJoYUpwOXp6?=
 =?utf-8?B?dSsySWNpU0h2OFM2U0l0Y2hXMGRCT1ZKZkRBLzhJYndqVFBDTmZ0Wloybm00?=
 =?utf-8?B?aWhMSXlEVVo5ZTE5SVpRZEdFYzMxZVBsL051eUFZUG5STVR2aWtWMDgrcEdy?=
 =?utf-8?B?cU5vc0pwWCtoVktQaG1xUHd1MkVGc3QxRVVSRnJlNzRwUlJtS25CVjdEcy9n?=
 =?utf-8?B?UDNvU2RqR05sbUpOMkpac3lmNlE0bXNmQ1RuWGRBbFY0R3FCQ2FlVCsvTmYx?=
 =?utf-8?B?YTVWSEFsZEpsRWI4bC9DZUQzSmNjTlhDQ2hRYnpIcy9xWnJTR0xuNE5KR3BH?=
 =?utf-8?Q?VmV2zy+2xc+mwCUmnp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4d5cd6-3f88-4d43-0c2f-08df29ee8ca5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 12:27:45.1486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 104HLyTdXd8b5oKdfjRAn0NKfRki5xGHiURvyR2JXUhiMsHC+U2g6HMwE5vgXbqc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
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

On 10/14/26 12:12, Olivier Kaloudoff wrote:
> Hi Christian,
> 
>> Yeah and you need to fix the fence orphaning and *NOT* the wait!
> 
> Agreed — found the exact orphan site. drm_sched_entity_push_job()
> pushes the job onto entity->job_queue first, then
> drm_sched_rq_add_entity() sees entity->stopped (under entity->lock)
> and returns NULL: the scheduler is never woken, the job strands on
> the spsc queue, and its fence never signals. In our repro the dying
> process's fault path submits the migration job on its own killed
> entity — it's the process-kill race, not a device-unplug race at
> all, which is why drm_dev_enter() doesn't cover it.
> 
> This is the same failure Tong Liu reported in August 2025 (task
> hang after job submission during process kill); that fix was
> rejected for checking entity->stopped without the lock. The clean
> fix is not to pre-check but to handle the NULL return while still
> under entity->lock: drain the queue / schedule the kill-jobs work
> so each stranded job's finished fence completes with -ESRCH.
> 
>> Blocking for all fences is correct shutdown order.
> 
> Agreed. v7 drops the timeout entirely — unbounded wait restored.
> With fences guaranteed to signal, the copy_done error path becomes
> genuinely reachable via the fence's error status, so the error
> propagation and migrate->dst rollback Felix asked for stay — now
> on a real error path instead of a timeout.
> 
> v7 is now implemented and tested on this machine (7.3.0-rc5 +
> p1/p2 teardown+restore-stop, sched orphan fix, KFD fence-error
> rework). Hot-unplug test: svmhog2 mid-migration + a second KFD
> process, then Thunderbolt deauthorize. With only the sched fix
> the host still wedges — the kill-jobs drain prevents the orphan,
> but the unplug path additionally needs the KFD teardown ordering
> (processes torn down before device early-fini) and the restore
> worker stopping on -ENODEV. With the full stack: fences complete
> with error instead of orphaning, both KFD processes get SIGBUS
> and reap cleanly, device tears down, host stays alive, and
> re-authorizing gives a clean re-enumeration. So your direction
> was right — the wait was never the bug — but the orphan fix is
> necessary rather than sufficient for unplug.
> 
> One question on layering: the push-to-killed-entity fix belongs to
> drm/sched, which is dri-devel/drm-misc territory — do you want it
> as a standalone patch there, or kept in this series? I can also
> guard the KFD submit side so it doesn't push to a stopped entity
> in the first place, but the sched-side drain is the airtight fix
> since entity kill can always race a locked pre-check.

No that is another race in amdgpu and is not related to the scheduler at all.

entity->stopped should only be set to false *after* all potential users are gone because that potentially also frees up the scheduler.

Otherwise we run into tons of other race conditions with scheduler submission and teardown.

In the case of a hot remove the run_job callback should recognize that the device is gone and return an error, which is then bubbled up into the dma_fence again.

The warning from the scheduler is just pointing out that amdgpu is doing something very nasty here.

Regards,
Christian.

> 
> Regards,
>   Olivier

