Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84CCC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 04:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5271810E363;
	Wed, 24 Jan 2024 04:13:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993AC10E363
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 04:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0p/rQeYPQXfbQWBZUZv+uKVggalcMlj110dPPxe/lf/XNbMSI/aIUCxGQ4s4hYu533b683tOQt7nFK0/7qd1p7etOSUfaTXbkfqdxRwwso5b+aA+I/HXExxrY5tVawABvyaQVSn+++hX0LI9JJZn7oar3i0NQQ37xx9+//iS0zFTWvyoP6oC9YSeoUjBJH/nGQ0ZV2mHzpqlYc2U3EUmFA32zo7TolFaUKLw3+FDikPfZzSz90+ElVnzg/O8RfE0Z/C8cxmqsD6PTm3M7WU8HZMuGEzT3BEOq44QEh3LcN8ZKyjt1kMDtN9w7ol20rad7gj2dF4+3IfaUw+XVXvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQSSTxqksrUoZI3643TxY27c+IplV20ba1Zc+qU+pDM=;
 b=CkZpcTb9Uqsu2fM5k8T3JoeNZ4bwlpbg4qpdqu1Aq9HJX0PUxtG1z1xvIwlVsezDF+NPNkIsk/BVHYlfogHydv8XqocSDnJ6xxHevhClUooMOC/d0dkEj1qVncI0MHORe5QO2x8I7NOXzbRnJKN6mkyS+sA3or6qH+cOSS3+m3/CWLAUE+4b46yGv2LpA01mP5KneZ34RWjaiSpESNBpXzVqnUD2HYRjgZDF9UH8YrpTuUC45pbj7LssQ3Sam/idXFsouiaqreTAxke9Cat2hQhIeRZhnlk7+uQPKRanA9HeWqKMogIF1imAz23D5MzPeWgxUUA3jqtvHnUru4vyiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQSSTxqksrUoZI3643TxY27c+IplV20ba1Zc+qU+pDM=;
 b=3ySfBy+LME0WEZNUuHGO7fBYYkSIhYLbIS4PFHogNTxzB4YfH9apg6PFjI7eXfxFkaBy1tVtWdRUc+4uIpQTtzhNJunnhkpRJxbKu7r4H8ewU1Hcme5E5hKDZwnLoZbFWrXJzXPb2YNKffJEDd1skxiQxrLbrPZYIuVNEsoFPvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 04:12:59 +0000
Received: from PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e5fc:a681:fb1f:de6e]) by PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e5fc:a681:fb1f:de6e%6]) with mapi id 15.20.7202.034; Wed, 24 Jan 2024
 04:12:59 +0000
Message-ID: <ae8a92f6-17e2-4f1e-a0b1-2622cf36c2d1@amd.com>
Date: Tue, 23 Jan 2024 23:12:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: check flag ring->no_scheduler before usage
To: "Lazar, Lijo" <lijo.lazar@amd.com>, vitaly.prosyak@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 alexander.deucher@amd.com
References: <20240121001951.75950-1-vitaly.prosyak@amd.com>
 <a699ff21-2793-4880-bbfe-0c9bf5107eda@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <a699ff21-2793-4880-bbfe-0c9bf5107eda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::40) To PH7PR12MB6420.namprd12.prod.outlook.com
 (2603:10b6:510:1fc::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6420:EE_|BN9PR12MB5306:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6bb0ad-d3fc-405d-82e5-08dc1c92bfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXfS1UCSHJBT8GlCzsnGJgrlPiOpXxZvG9KOdB5QPGKqr6Vm9J1KuJzwxIQXBZpqXhhURgkn85tCin5SfvXTCR/ac8pMM8wDUOGPp93HBtoV9l5+2LP+o85Ws4ZcL3s2Lw4uzNl8YP9c7cTikhMPJiTPFRXAZFlQGcUSar/S9qvYQDBGpMKkDuELU132X7xnfvMvE7FNAhjj2ZH57rKM2XWP53RGEAOWXzlyMns8vGdMJPlHyjuhDCXfeaoEHZUXI0z7pxpKAjLAQXODv0zyL74hm5td3r6Qi1rVxZ+PTWVDtALYyrgftSfmmKHBuz2VOvDptzKfNWMbLfpW0VOpx1rsx90ZyXqYW71NdLRiHSS/qFYtNTvJO0TcAw3HO5ERgS84m7M4swTu0n4e4Gyw55gfuLwCLXva41dg4I8UH6YCEIrLYoAmqskYE/scxH8i7bWi8UZy8KXGxkWMDVaxOE5sSy3a6zoQ7jWuKK8dxXnSyQ/6Qc+V/V98fCtgfP0bLt1jWaIh17ryrJbJkv9+e+MwZCJSf/W5NVcgyzVmQ34WwyI9WMtwpaGcRHIT+VQCniIyEaxjlf9JcP/GeiVAHjzwSkrz9CtzXoiLrzuBLjEupZbRzlnNa4wwoOL9kb6Ph0vNZcLlsnLo/qsQLIk4Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(316002)(66556008)(66946007)(26005)(66476007)(6512007)(53546011)(6636002)(2616005)(966005)(478600001)(6486002)(6666004)(6506007)(38100700002)(8676002)(8936002)(5660300002)(31686004)(83380400001)(2906002)(31696002)(36756003)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0JTSEpnM2JuVHdYVkxVc0NkbkNXU1Z0SW5TMUp5Q0NyZUpjKzIxa0hCelEy?=
 =?utf-8?B?M2hwV1FKYkdPYzlWNkFpN1RWdmZ6YSszbmx0TitZczZMWklZOXlURXJiMmIr?=
 =?utf-8?B?UVpKVHJxR0RTYnpaWTMxc0JpdmxvMlRwWkVMVG1EVmVkdGlVUWtPc0tFTEpQ?=
 =?utf-8?B?UnllZ2pRbmxXTTNyemZCYXpjbUFQL1JROHY4TWF3aVY2NXdXSUQ3K2FDdjJ6?=
 =?utf-8?B?blJnMUZOMDV3ZXl2QnBGVkdMcmNtQTd4YkNGYVd0RmNhTWxlUUNSNjJoYUZs?=
 =?utf-8?B?K1hFSHlXZDZCYkp4UTlvQXExMUcrcnZvQUEzM3FlYUFnTGpnbWJUVmRIaFFQ?=
 =?utf-8?B?L2phM2VTemxoNWNnUU5sOG40dkZodThoQWJSQ2xiaWpEZzljdGRSc3JSQnZr?=
 =?utf-8?B?Y0ZFa21OckZvdVpGYkhpTExnZjlXQWxSSUZNSDJweUhGQjlESTl5V2h2Sk9a?=
 =?utf-8?B?LzRaeStmak9JL3lKb0d6UHE5a1p2bHdmVkFOWTd4Z2o5Z0RiQjY4UWE3ajE1?=
 =?utf-8?B?QUdWcUhsTWduQml1dGxOUXFLYlkxUkpMUUVKWUJiZjE3N3R2Mk82UkY5eith?=
 =?utf-8?B?dkVGS2FSR1VERlQ2clIxeHJHSU5teW1rZ1BIS3VZUVQvVy9maXp5YVo5bER2?=
 =?utf-8?B?SkhxS0J5WlhFZkxpQVhBUDlTczkxMUFzUWpZSUhab1pxRnhTY2dTZDVLMU0x?=
 =?utf-8?B?SmxYWXhCRTNQRmU4eWh3VHJVQzQyRU00R2VLbUVMQ0NHSklrcmxNblFXZDV6?=
 =?utf-8?B?aEUyRGszMDZvYUNlMkE5NEduUTZqUmltSDN3emREekZaQXR1REs1dEFoTmF2?=
 =?utf-8?B?TDBVamZhMTE3T3pEeHlOczF1UW9COHd3alZsRkVDKytDVVRacGZ5WXdTcXBF?=
 =?utf-8?B?MXg3TDR5Zld2NGdEUTlUdnZFY05UUUNTeVFLYloxWEdUaUpldnpGNjk5dHJm?=
 =?utf-8?B?K1V0WVYyd3FvSjZZemFJanl5THhmMFVWdkk1N1R2blV4VnNhVW43NmJLYkxi?=
 =?utf-8?B?dWprRzBENk8xU3RaMFRJL1FWVUdraXhXNjQrR1J0T0hod2lZQUFFTmpiSmV6?=
 =?utf-8?B?d1hBQXkwRjc0QUNzY3lxTDZ4TTBVR29xV3U0RTdlZVRSUmNWaGJHT1N5ZjBC?=
 =?utf-8?B?QllscE1jenRZVXFpaTZ4R0RDYStrNXArZnlsc2ovT0hCVjFtS3pkbjRzUk4r?=
 =?utf-8?B?Zm1OaW1Jak1GUEpnSGVtK01JRGhEaDRiNHF4Wmo3SXhERjAwRnlDYW1CbFRp?=
 =?utf-8?B?cFczMXJleFZnSS9DbTNKS0RsMTN2Z2dmbm1OT2xtZDJqYXA1aElSc2JNdmh5?=
 =?utf-8?B?WU5oUnJmVUFDN3psUjBMMVh6MkZvRFF4SlU3K0NoZWRWUllKdlJEaEo1YmtB?=
 =?utf-8?B?bnNGOVR3dW5vMzZvb0sydGJSUlVMQVkwckpUME1VYVAyd1VKODA5T0JhZ0JQ?=
 =?utf-8?B?dzhQV0NNYSsvVlZrM0VobCtYN09MZnRHdmpHSjNsVWcrQnhFMFZTUHh5MjB5?=
 =?utf-8?B?cllLbDRSZnFIekpPd0R2MmJRckZsVzBJanZqZlZNUXpVWUJ2NDRBRW9HbDVU?=
 =?utf-8?B?S2k3d3B4SlRmNzdXUm54L09NelpyV2l5Zkc0cEd6eWZTTHcvdk5od0l6d3hn?=
 =?utf-8?B?Y2lyamd3b0RnZWJKb0VCWk0yYUdDcTdGZ0RCdWRYVlY0c3RvTk9UNTdCazJY?=
 =?utf-8?B?R3lQUjNxTnM4amVyNGxSMzFzUkI3eUZycUZ6VGtvaHcyWWFpKzFvLzdEVmNx?=
 =?utf-8?B?ejE0bDgrbU1pc0QyZGVObmg5dHJOY3NxbGNxdUZKZlpiOHNtcUI4N0pFV0NZ?=
 =?utf-8?B?T2EvU0RBbnpzTzY1NVFPU0Q2QkpTR2dkVFJmWFAwVS8yRHR4Zk9SRXhoV0Ir?=
 =?utf-8?B?WFdOdm1KK2tyYVRxWGZZK0xRQXh3aWtVYUhzM01HT0UzdmdCc0FyRnZCSklD?=
 =?utf-8?B?cytPM1pDQnhacEllVnREdjAvUk1RQzZ0cFZNcHI1R3V6a05QZDFmQ05OOW1s?=
 =?utf-8?B?VzFlU1puQ0p4aUE5WWZETVg4ZjgrSjBpZlZaaXArRjl1SHB2RDM1L0RqYUFn?=
 =?utf-8?B?dVRKSFhVR1REV3BzSVh1OUxDWENYZ2Fid3F6bFZUdk5rQWZQeTN4dVNEZVVD?=
 =?utf-8?Q?4CiPqM+ZtrvHHLtwQqlooScu8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6bb0ad-d3fc-405d-82e5-08dc1c92bfd2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 04:12:59.0412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OW+WK/injI+/Ts5paLTiZJhzfT1rp4ZIccvIjx2ZAENoeD4wLvfajpVA9NwqmYTBP7uNxaNmG9w1810Rr6ahw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
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


On 2024-01-23 04:00, Lazar, Lijo wrote:
>
> On 1/21/2024 5:49 AM, vitaly.prosyak@amd.com wrote:
>> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>>
>>    The issue started to appear after the following commit
>>  11b3b9f461c5c4f700f6c8da202fcc2fd6418e1f (scheduler to variable number
>>  of run-queues). The scheduler flag ready (ring->sched.ready) could not be
>>  used to validate multiple scenarios, for example, check job is running,
>>  gpu_reset, PCI errors etc. The reason is that after GPU reset, the flag
>>  is set to true unconditionally even for those rings with an uninitialized scheduler.
>>  As a result, we called drm_sched_stop, drm_sched_start for the uninitialized
>>  schedule and NULL pointer dereference is occured. For example, the following
>>  occurs on Navi10 during GPU reset:
>>
>>  [  354.231044] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019
>>  [  354.239152] Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
>>  [  354.246047] RIP: 0010:__flush_work.isra.0+0x23a/0x250
>>  [  354.251110] Code: 8b 04 25 40 2e 03 00 48 89 44 24 40 48 8b 73 40 8b 4b 30 e9 f9 fe ff ff 40 30 f6 4c 8b 36 e9 37 fe ff ff 0f 0b e9 3a ff ff ff <0f> 0b e9 33 ff ff ff 66
>>  66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
>>  [  354.269876] RSP: 0018:ffffb234c00e3c20 EFLAGS: 00010246
>>  [  354.275121] RAX: 0000000000000011 RBX: ffff9796d9796de0 RCX: 0000000000000000
>>  [  354.282271] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9796d9796de0
>>  [  354.289420] RBP: ffff9796d9796de0 R08: ffff977780401940 R09: ffffffffa1a5c620
>>  [  354.296570] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>  [  354.303720] R13: 0000000000000001 R14: ffff9796d97905c8 R15: ffff9796d9790230
>>  [  354.310868] FS:  0000000000000000(0000) GS:ffff97865f040000(0000) knlGS:0000000000000000
>>  [  354.318963] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  [  354.324717] CR2: 00007fd5341fca50 CR3: 0000002c27a22000 CR4: 00000000003506f0
>>  [  354.324717] CR2: 00007fd5341fca50 CR3: 0000002c27a22000 CR4: 00000000003506f0
>>  [  354.331859] Call Trace:
>>  [  354.334320]  <TASK>
>>  [  354.336433]  ? __flush_work.isra.0+0x23a/0x250
>>  [  354.340891]  ? __warn+0x81/0x130
>>  [  354.344139]  ? __flush_work.isra.0+0x23a/0x250
>>  [  354.348594]  ? report_bug+0x171/0x1a0
>>  [  354.352279]  ? handle_bug+0x3c/0x80
>>  [  354.355787]  ? exc_invalid_op+0x17/0x70
>>  [  354.359635]  ? asm_exc_invalid_op+0x1a/0x20
>>  [  354.363844]  ? __flush_work.isra.0+0x23a/0x250
>>  [  354.368307]  ? srso_return_thunk+0x5/0x5f
>>  [  354.372331]  ? srso_return_thunk+0x5/0x5f
>>  [  354.376351]  ? desc_read_finalized_seq+0x1f/0x70
>>  [  354.380982]  ? srso_return_thunk+0x5/0x5f
>>  [  354.385011]  ? _prb_read_valid+0x20e/0x280
>>  [  354.389130]  __cancel_work_timer+0xd3/0x160
>>  [  354.393333]  drm_sched_stop+0x46/0x1f0 [gpu_sched]
>>  [  354.398143]  amdgpu_device_gpu_recover+0x318/0xca0 [amdgpu]
>>  [  354.403995]  ? __drm_err+0x1/0x70 [drm]
>>  [  354.407884]  amdgpu_job_timedout+0x151/0x240 [amdgpu]
>>  [  354.413279]  drm_sched_job_timedout+0x76/0x100 [gpu_sched]
>>  [  354.418787]  process_one_work+0x174/0x340
>>  [  354.422816]  worker_thread+0x27b/0x3a0
>>  [  354.426586]  ? __pfx_worker_thread+0x10/0x10
>>  [  354.430874]  kthread+0xe8/0x120
>>  [  354.434030]  ? __pfx_kthread+0x10/0x10
>>  [  354.437790]  ret_from_fork+0x34/0x50
>>  [  354.441377]  ? __pfx_kthread+0x10/0x10
>>  [  354.445139]  ret_from_fork_asm+0x1b/0x30
>>  [  354.449079]  </TASK>
>>  [  354.451285] ---[ end trace 0000000000000000 ]---
>>  [  354.455917] BUG: kernel NULL pointer dereference, address: 0000000000000008
>>  [  354.462883] #PF: supervisor read access in kernel mode
>>  [  354.468029] #PF: error_code(0x0000) - not-present page
>>  [  354.473167] PGD 0 P4D 0
>>  [  354.475705] Oops: 0000 [#1] PREEMPT SMP NOPTI
>>  [  354.480066] CPU: 1 PID: 11 Comm: kworker/u64:0 Tainted: G        W          6.7.0-991912.1.zuul.e7596ab24dae4bb686e58b0f1e7842da #1
>>  [  354.491883] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019
>>  [  354.499976] Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
>>  [  354.506855] RIP: 0010:drm_sched_stop+0x61/0x1f0 [gpu_sched]
>>
>>   The solution is every place where we check the ready flag and check
>>  for ring->no_scheduler. The ready flag serves the purpose in case an initialization
>>  is failed, like starting the worker thread, etc.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
>> ---
>>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |  2 ++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  6 +++---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 14 ++++++++------
>>  3 files changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
>> index 899e31e3a5e8..70bbf602df34 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
>> @@ -292,6 +292,8 @@ static int suspend_resume_compute_scheduler(struct amdgpu_device *adev, bool sus
>>  
>>  		if (!(ring && drm_sched_wqueue_ready(&ring->sched)))
>>  			continue;
>> +		if (ring->no_scheduler)
>> +			continue;
>>  
> There was a similar patch before -
>
> https://lore.kernel.org/all/7cd37500-8633-4030-aae3-9b532d60b501@amd.com/T/#t
>
> It introduces amdgpu_ring_sched_ready() to cover the above checks.

Thanks, if only I had seen this patch, it would save me some hours.

Vitaly

>
> Thanks,
> Lijo
>
>>  		/* stop secheduler and drain ring. */
>>  		if (suspend) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index e485dd3357c6..35132aa2c0f4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1678,7 +1678,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>  	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>  		struct amdgpu_ring *ring = adev->rings[i];
>>  
>> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
>> +		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>>  			continue;
>>  		drm_sched_wqueue_stop(&ring->sched);
>>  	}
>> @@ -1694,7 +1694,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>  	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>  		struct amdgpu_ring *ring = adev->rings[i];
>>  
>> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
>> +		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>>  			continue;
>>  		drm_sched_wqueue_start(&ring->sched);
>>  	}
>> @@ -1916,7 +1916,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
>>  
>>  	ring = adev->rings[val];
>>  
>> -	if (!ring || !ring->funcs->preempt_ib ||
>> +	if (!ring || !ring->funcs->preempt_ib || ring->no_scheduler ||
>>  	    !drm_sched_wqueue_ready(&ring->sched))
>>  		return -EINVAL;
>>  
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 2df14f0e79d8..894b657df1d3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5052,7 +5052,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
>>  	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>  		struct amdgpu_ring *ring = adev->rings[i];
>>  
>> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
>> +		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>>  			continue;
>>  
>>  		spin_lock(&ring->sched.job_list_lock);
>> @@ -5191,8 +5191,10 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>  	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>  		struct amdgpu_ring *ring = adev->rings[i];
>>  
>> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
>> +		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>>  			continue;
>> +		 if (ring->no_scheduler)
>> +			 continue;
>>  
>>  		/* Clear job fence from fence drv to avoid force_completion
>>  		 * leave NULL and vm flush fence in fence drv
>> @@ -5658,7 +5660,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>  		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>  			struct amdgpu_ring *ring = tmp_adev->rings[i];
>>  
>> -			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
>> +			if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>>  				continue;
>>  
>>  			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
>> @@ -5727,7 +5729,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>  		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>  			struct amdgpu_ring *ring = tmp_adev->rings[i];
>>  
>> -			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
>> +			if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>>  				continue;
>>  
>>  			drm_sched_start(&ring->sched, true);
>> @@ -6082,7 +6084,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>>  		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>  			struct amdgpu_ring *ring = adev->rings[i];
>>  
>> -			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
>> +			if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>>  				continue;
>>  
>>  			drm_sched_stop(&ring->sched, NULL);
>> @@ -6224,7 +6226,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>>  	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>  		struct amdgpu_ring *ring = adev->rings[i];
>>  
>> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
>> +		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>>  			continue;
>>  
>>  		drm_sched_start(&ring->sched, true);
