Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC57CA5FFF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 19:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 240E110E66D;
	Wed,  7 Oct 2026 19:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0ge2W8IT";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60CD110E66D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 19:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGYb01zCk2TnlfspIK36qcCzWHS7ceyteZCv/ZInocv3PSv07zVgj51eS/mPizghMEsA2jA5o2mBTAUofbmNDtFyJ5eALyJrxaJ4ijsm/kjK1RYbyh9tXhiNn9IB9KyDk8Ttpxs3NPL0QIpJ9rVvMKBTia4fUhCPNd5ckyDVz/U5nCMRkzU/UdSups6wxVpPs6YsccePhTOnNHTMl86u+PbI6Z+Us3psPi9xmMFNi7hHXm9sAr1y+Y5sVyiGWSS9/iEQ4bAVwT/I+g9hdqCtQQR1ymegZIJn+wjOgzbPXbSFqFhfnlSERYc0FvYXpNtnIHEO7Kiom5Pba4v5qHh7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdHDjxezBb+cEtDM6TkVHXaAJkW9BDDLMHJFihgvcj8=;
 b=L6X4NDOd+AicEm4pzYWzXhFZRR81aplszSmwvhNVXQZYOhTTN51OB/tAki6nsdnhG7tRD/1AEz+h4rWmGOGG9k0HAAyBsC0ZNGegb95Z3fORF3DtH8OIlkNbORvHd94F0KeUXrUEDarlobiT3UWeR0R36ACy8PHd5OE1AbjHdOLGcuQr6kE/EpgAHVwsJn6sFGKhi9Irn1U9xjS+/B4QG2Iuqa7ffTe0mKpPIOkdVBp/TcUThilaqa8IvsDFt21HvUD7o+wOVvQSS4pchxKG3qiH4kPnygN9/SJnhncRywwUkZMM1NM+I+5a41FAb+sVUR5ZD+5Z2/c9hoY9jHQB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdHDjxezBb+cEtDM6TkVHXaAJkW9BDDLMHJFihgvcj8=;
 b=0ge2W8IToPE5L0jihSLufoERlmY4xHt0kratwK92gB0ubcAn7cUsHM09uD2mIS5RVj2SUMnSgB74wpodd4teNUJ2kLM6vmqH9ctG8YUl9vPIJVb5hBS4U0Kbxs2XzANcQv6thrHipiG3Vq4IdarjVjGOEJxjiFANZNWwznUoSlU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DM3PR12MB9389.namprd12.prod.outlook.com
 (2603:10b6:0:46::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 19:51:24 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 19:51:24 +0000
Message-ID: <7e0e576a-f3e1-4f30-94c2-c5d34b01b41b@amd.com>
Date: Wed, 7 Oct 2026 15:51:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: stop userptr restore retries on device
 unplug
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20261007172402.11248-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261007172402.11248-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::27) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d70880-b8a7-41fc-499a-08df24ac5e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: slXBLTvCV8M86152Eijv9SARdFbxfXkHRX1zIaCrOrAUL5ayUURUtZQfAXm3pjj7ZttnLqC0IIUJuLkj+y1NGMY9NdYr4zxbTJrw3IkDzV1TNzm5vtEos6Mcxc43HvwYbPNO1YedI7TzCti2i5e4U5vAMw29ispN1ZyGSfl18z/1omfrj8qV+pNmUgnc1mJqasKRv+nkS+m9MQrJMvEFVYL8kmA9hVdlD9tUWKDv1ivdLmzglxRtOP+bjtIQIVztQ+P5g0xwsssrhwSmgCVm59Qu8xMsYlKEmxLV9cIrt54l1xx+wSjFbZ56BGpMlsavd13zh6RtSyu/oTzUuq6OtDt5oFQz4c74h2AJon0UF6mo8cwmTtUFLjZ0oYmJesjfntHhJzob6GzsAOWeIDQeehcSdE4KGvH35o7mTXiybuMTU2IyQbC+hn95nTKfWIr49l5WNOuwTW4xw4xsOWz7mdg/WC1am8EOX7pThr5GTmG6fnmNLsYaeq2BmUt1iBYWfY1IHXY2iMJBGHZkdF11S5fdgDDYm01lVVJajS+Wo26pBbjMVbOMkxvKJVUJxhlugHboy+kpxtwN+VLeeDIm1LvDAnnHdXUvfB27oa+FmoBXGQbjaqzd71tiExTcI99q+wNpvV37LFhVN8fv8zDo3iTMAoAYwyMCWN7yKFwHcM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFRwVkRSa2Q1WlVsR21hS2owcFJ2a25PYld4dzNIem9hSUJQbGZEMVVnbVA0?=
 =?utf-8?B?UmYyaTZySUFobk9MRzQ2clVUMmNvUkpOaGdOaU9ySGRJRE9RVmxyaEFQeHFh?=
 =?utf-8?B?czR6SEhUWWZDaXRZNWl3MXlLQWZQSkxqelVnOWM2MFBET3hrcTIzdE1Ma1hX?=
 =?utf-8?B?ZktBN1BCcTBvOU1rbmRORmRzdlczK0ZxS1krZmdwRmx2a0Y2MWFzR2JWUzJz?=
 =?utf-8?B?czlMZSsxWUxjeGQydlNpejlnMXRSNjR5RnpzWnc3K3UzQlBYSXNFOFdaSTJY?=
 =?utf-8?B?RVlLQVd3N2NmYzY3c081Y3dKajdWeW9WK3hvcmc1bk5VMzhUSndzSmZsYm95?=
 =?utf-8?B?WU4yVkxIM1NFYVBXanp0VkRlMXpKT2xqc3FYUmh3cytyeE9QMUsxK1RZTDVq?=
 =?utf-8?B?UytEWHN4ekordXFlSFJKODBrRFhhdWFFL3J1STl4NmlKUkQ0bzBCM0JraUgx?=
 =?utf-8?B?UmZ4TXM1YUpCQnFMV0Foa09yUjkwUllVWFR1NW9aYVcyb1YvNGhuelpRNlN2?=
 =?utf-8?B?TkxRcEd1b3c1akpxTjYwN1QzWHpyR3hmQnBnUElhb3paRU9DNFBvaFN6S3NZ?=
 =?utf-8?B?RG9jVFcrMUVQaW1naC8xQnZidEFObjRLQm9ZejhobUhaZm5DRzQvcFNFeFhS?=
 =?utf-8?B?dkZiV1hjcDJ4ZTRhdCtzTjI5c2hrdmF2U0lRMWY5eTJ6ZGpYWW90QU5aWGZZ?=
 =?utf-8?B?cWVMUDh6NTErcUhJUGlWeFN2elNPdEIzZlA1QkxEL0ppdUFxdjhJdjdaN3BI?=
 =?utf-8?B?VC9oY0FBR2E5K21GNUZrZ0V2MVV1TDJ4bWZQWml5SWZoZXVscCtiVTlPeXo1?=
 =?utf-8?B?T1NnL24vTnloWkx0bnA4Mm8zZEhVRDZ3amZncmZiZkUvRjBSeFg3MFQxVysw?=
 =?utf-8?B?MTRNSm1QMWxNRy85ai93VmQ2SmFFcU9WRmQwV2VhTUM0ZlpNNFBZODlXbzJw?=
 =?utf-8?B?TmdYRmZjaWtLRTI4L1dGMmFZUkE1dnpPS3Z2US85SnY2RGxrc0t4RElKNEVh?=
 =?utf-8?B?T3h2S1BVZ2IvSnpXWEc1K1dlcjBESXRmaEttNGdSclhUYXZQME9rZHpFQ0Iy?=
 =?utf-8?B?bW1sUEhvRHZoYmxVYm1LM3RiMlhmY0ZtREFRa25PK0JKMytvODBxT0lqOE9Z?=
 =?utf-8?B?Uk5WRmRFU2hNR0pjTU1GRmRuTmdGQUtYV1RjdjZPZ0NZSGRJeGFmQTBxZUE5?=
 =?utf-8?B?cmhRMjJaN0Z0Y3VZN2w4VDMrWXVPaEVHNnkvVkNUVGRYQXozMnhxY0xZbVlZ?=
 =?utf-8?B?bjNaWlQwRVNKYlJzYktuY1M3N3orOE9VSTdvbEdXOC9HL3p4dW5uYjlpSExm?=
 =?utf-8?B?Vm9kV1VCR1pEb0VWanA5R3ovbmxrR0ZYTjJtWnpDQnVaMTZsK2JoWEExL1Yr?=
 =?utf-8?B?RXBWMUMyLzZtcmVuQUJ0NUhCVUhBaTZ2ajBRS290dHFFVDhnWUR2cWxScExW?=
 =?utf-8?B?emU1VnI4bkdQQjk2RElDeTFnWk1UUzI3bkU0NWRpMjJSQWI0SXZmWHc0U2N0?=
 =?utf-8?B?aE82UGFUZXRRVGRDSFg5RHBieXVUVUlucCt3RGlvTVBGSXBQRCtHNjNnN0No?=
 =?utf-8?B?aUd6dW9kZ1VDT1cycEJ0eUN6Z3EwMmgwWk5WZmJtUXhERzd0MVlGZnA4RXh5?=
 =?utf-8?B?QVhNZ0lLVUdWbmNrOFBHRTk4ZnBzZCtDbXlrTU55OTJQakNsRHhaTlJhWUR5?=
 =?utf-8?B?VHJCeEVYZWtRSkM4UHVJeXVzbVhpRUhxay9EWnYzSElRalM5WEY4L00zeWRD?=
 =?utf-8?B?RzRWL2w3SFk4TmpFSlJyL1NaemdHK1h0T1pjSk1hbjYzQS9OdU45T25Dc2FZ?=
 =?utf-8?B?cEs3OXhHZ2t1dEN0TW9vemppQjVjTTFGampmU25WY2tjYkZyS1pPemtlZUp0?=
 =?utf-8?B?Vmpyd0RKayt6RWpoWGIvMHlQdCszTDdPQkJnVXVoL00zOVBaNXkrUzRvdFFt?=
 =?utf-8?B?VXJBMlZkRS9jeGJKSnl5dDBCcjdzTWZFRnVlWFY0VVJoVG1jRlRhZXVvVFlD?=
 =?utf-8?B?ak01akVLRllIcklpeE84RjJianpPcjA2TGxGK2hYQUsyRG9nRWJSZXZqQ0M2?=
 =?utf-8?B?NlRzQWpqREwvZjAxZ0ZLOVFEYTFQT3pPL0UzU05PQ2lNWDIvNHNZSDJIOXk1?=
 =?utf-8?B?K3Mva0RLUk54TitmbEk4ZktFdFVLZzVFSy9nbjRPUWNoZzBuSzk0Uisyajdv?=
 =?utf-8?B?cTI2cE1rUXJHaGo4RGk3TUxkZ2phQzNSajhFYnAxT09jZExFci8wb2h1bjc1?=
 =?utf-8?B?VCs3OGRVd3NhdC9KSUtoY2drdFRJdlVtRVJpSzFjRFlKS3lwTU4yTGFMdFF1?=
 =?utf-8?B?aThPUUZDbWE2V2crdHFKZlhsVnpwK1hCTk91bEZub1FyRDcwekNyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d70880-b8a7-41fc-499a-08df24ac5e24
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 19:51:24.3970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gj3VetyhuGKLF/uFmPrPMknzzBGdNsxEgWGRrbyDLtJFF9EC7dbV9jkyUTECCNymAoyDv5Nb1w7q96+mYMtSTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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

On 2026-10-07 13:24, Olivier Kaloudoff wrote:
> Hi Felix,
>
>> Shouldn't cancel_delayed_work_sync wait for the worker function to
>> exit? I don't see how that can race with the re-scheduling in the
>> worker function itself.
> You're right, my UAF framing was wrong on current kernels. I checked
> the workqueue code: __cancel_work_sync() marks the work disabled in
> its off-queue data while it flushes, and queue_delayed_work_on() drops
> the requeue via clear_pending_if_disabled(). Self-reschedule from a
> running handler, delayed or not, can't survive the cancel.
>
> The argument that does stand: the cancel only runs at last-VM destroy
> during process exit (gpuvm_destroy_cb, when n_vms hits 0). On surprise
> removal that path itself can stall — the SIGBUS'd task deadlocks in
> its own exit path (SVM migrate -> fence that never signals, patch
> 3/3), so process_info teardown never runs and nobody ever calls the
> cancel.

On that path you changed the dma_fence_wait to dma_fence_wait_timeout. 
That should be sufficient to prevent the stall. I believe the extra 
checks for pci_dev_is_disconnected are unnecessary. IMO the cleanest 
solution is the one with the least special case handling deep in the KFD 
code. drm_dev_enter/exit is meant to abstract that away from most of the 
driver code. Therefore, just guarding the critical sections that need HW 
access between drm_dev_enter/exit, and not having any unbounded 
fence-wait inside those critical sections, should be sufficient.

Regards,
   Felix


>   That whole window is where the ~11k-cycle spin at 1ms delay
> happened, holding process_info->lock and notifier_lock each round
> until soft-lockup.
>
> So the -ENODEV check isn't about racing the cancel — it's the stop
> condition for the window where the device's lifetime has ended but
> process_info's hasn't. Transient errors still retry as before.
>
> Olivier
