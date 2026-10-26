Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7417C606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Px16t5B/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E2910E151;
	Mon, 26 Oct 2026 17:55:44 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 487E810E151
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 17:55:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3pNGlkwZ9ZnNdG6HCDLM8dkwPcilNByyrHBT2Mv9TquNTPHzt1z4TsCZyB4M7cq9qIU1U2zAPIOO9YMfo3NZtalrrK+C7BTKtBwo+FS08YMlJaijpN2VCwSorX3YuELC0FmkvOyQ9Dn6phCBjUYPJhpmDqdPf+NBan57NWeRRk8FobiMxt3zxpoSi5NC1B3+z+k+yDm13l1Z2wf9ZHAVNTSVzJozpo2QOWEeechaqvR/LRc08WLmbwpMnAw3i94WhjlDEc02c4juerPP0MhOp/1V9TcsNeNc+0+OitqxpbuSqOaAgVroFqhatIrqRAEDGoPUSTM4EQ9pKsHubFu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TAYRlfi1+e4pTqIyQyzDGFnv+Gsa3f8ErWtIo/mcQo=;
 b=f6GpBmtkCEgbCBj3U02EgNAAv6OHLzmWzk+u/PQ1eBbsSrU4mw7bDLYCFi59mQ7En8wU0SJ5UJ1XVoBYk+wRjHDWCH7hwA8/tZx9D1MKGj9fUpU4z2DPoAkicnHb6UvI/rtXV2mvZMuWaGmCNmYs3lf9p93waRcNB+NuPJprdZT8BYs4WyhvFmxPNx2XzPzIXkFIAimIskLt5jM/ynn98UwH6fiJHjnT+/JGp+lcfaWwPvA+mLdevkQ4Ohcr5FosJSuYT8Z/Cb5RVY5oN0yJsnA7zf1yIcPWsvwFUIikcIClIsC6ep33R3DzjytAT8Qy+930os4MjmHlOrkdTfhKOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TAYRlfi1+e4pTqIyQyzDGFnv+Gsa3f8ErWtIo/mcQo=;
 b=Px16t5B/lqSxshcBm+MShHwqvC2zKONtoV8qHXd4SgMOK59ghOk2kLd7dYp67Yt76O0h1x7v4X/GLv3SNVSrmkA76Q+coDW+//eleC8pTTox/EhCwYq/xZYAszdl7ljOPX6+Vi97m5j9gmHI7xclTokdijMXCcBSJ9gf2oMY1hM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by PH0PR12MB7983.namprd12.prod.outlook.com
 (2603:10b6:510:28e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 17:55:31 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 17:55:31 +0000
Message-ID: <7633c059-0418-437b-91e3-5cda0a2260c5@amd.com>
Date: Mon, 26 Oct 2026 13:55:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] drm/amdkfd: fix wedged teardown on surprise removal
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com, xiaogang.chen@amd.com
References: <20261022105503.60372-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261022105503.60372-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0209.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::6) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0a9625-26c3-4b58-572d-08df338a53bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|22082099003|18002099003|261026140227099003|56012099006|11063799006|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261022113327099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: pbXz+bnnU/W5Eu7bCnVot5PL1zP7+uzFFnfPGvY5XQyDvYs8+LDLzp6lXZ7rVhngko+/Ti+QPEtdIeZ2fIjqcwQpTUDpCXxsvGSOwpt79PgOf3mCHGkwRZCu6vmxNQwwuTS2sojIjOsp+j964zcS1jngCCWmHa9JQaKFXBoZG6C7KS51yNIMpkQQ9sEYWX+AK5sU0sO3MpEx7tHEeH76dmXbTEBAKMVEVDGcz+vpZAF+2ilvfhsXz0DKehR0BYgJu6DBpDKthKMTUU6tgqhFYUSKVwhaA/FZtmSi702G8WQuQhKm8WIqR5yLxOMwYCux89m1E9Y558IZf1enDLxSwPKjA9sRFjeL1fVtsTdi4J0dND9j5UPuL49hU3uTbjjPnzCcDxy+hjeTLQYR1HQjE3Gyqa2w0Vm/bjMVCkf1v995GrUAaIW2ocWVQB95XsLFw4+R8b8gpmeITbAlaWSHiOkJ5SyNyh+clWx9EBAOx0guszRdaKd4G39Ru+zw5sb9XxbNanwghKZh9a7CcwM7Ek8lPlzeut7uRrml8VT8p0snMfxUgOPfecSUvHNvRznJKL3N7/1VZ+fjDo8309fKNTmDrhZ6w8593QtYM09veGwUuL6qkWQ8M3iV37v3Ls9V8Me1T1GybLpxYkDZUsSdNKXbP16jisHq7CH1qRde2Ko=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(261026140227099003)(56012099006)(11063799006)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261022113327099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHp6emRqR2lVcFRBdis5MnM0dEhlazgxL1J6VnYveWJ2YlJlRXhlR0FLRm5y?=
 =?utf-8?B?ckFUQUZnRjJleTZDSU5VSk96YXlla1pVc00zYW5rQnVyUGZ2RDhLRDJ0cmU4?=
 =?utf-8?B?TXZBdVM2bVVpM3Z1ZDRkS0M3Z2lLMHVwQjZRTkF4SDd6UW5yVmlZWTNvYjBi?=
 =?utf-8?B?QlU5MnJiWU1MaTQ4M2x2S3ltTTc0bWVFemRuWHMxTEo3NUFlVDYxTmR2UmxJ?=
 =?utf-8?B?UTBIYzlLRitaZHJ3TTdodExZd2hxUS96VWRpaDRFMVh5WkF6aGlFVE51Q2h5?=
 =?utf-8?B?amdUd3V4V0pVb1AzU1lTL1NBemNjWW13WWdNbE9NTW5hcnZuSEZ2KzB6WDgx?=
 =?utf-8?B?WkJwMHB0c3kzaXo3L2x4VUJNT21TTlkzRXVXSFhwLzRCblZuUkNGYjVmME93?=
 =?utf-8?B?LzZFcVJabnFUNWFoWE1yK0NCWEhZK0hRUXRIUHNMWDBlQUVqRVNoc2loYllT?=
 =?utf-8?B?L3hYbXM3R1F4T0phQklBN2pkaUlYamJEbXV4NGpjNnFtVk85MFRYOTVTWTg2?=
 =?utf-8?B?bHVza20zdjJOOXZJbnBuNDFnUHNnSUtTTVFHVW55SkJWMkt5Z0hsc1o2MGtV?=
 =?utf-8?B?cENPV3JrbHlVa29GSU5iWkp6Y1F1NWtXZ2ZsNDdrYnZTM3A5WlkxR2hpVHBF?=
 =?utf-8?B?QWpaOHRneC9XWlAxSm5oZkt1UFU4aDhCNC8wa204Tno4c2laRitXb3lOZjlO?=
 =?utf-8?B?em83TjJJYVd2K3pTbkZFTHJEWHFhKzhFU2dqOG5SVFhLSFpKWncwa05RNzcx?=
 =?utf-8?B?blhISHpqU0tsc2lCNjVCQ3dXb0RJcGpscG8wQzNoTnR4aDJ0a01xbWd1MWZt?=
 =?utf-8?B?RllkK1g3Q2hjUE5SOWRoMU40VTY1RTNkUVJLc05DaExpNStDYVZDZXV2WkpC?=
 =?utf-8?B?S1QyMkZhQjFFTTI3N1lyeTRDVWJ2cmpHQjZnZlZmZ2YzbHFpKzhid0Z0VDR5?=
 =?utf-8?B?bWpwYzBOa1YwOXRIM0lSblF2ZUpPVUU1TStRdnpPaGZwU2EzcjNoUlhTL2hZ?=
 =?utf-8?B?OHF1SkpHbEowemFjVytzTndKaU8ydk1WeU5wWXhUanVKZnNnQmNpWlpXT0hO?=
 =?utf-8?B?ekE3ZGlqYnd6OHpWRDJ6MURKOVlVeWNIMi8rSTFjby95TUZvRW9NRzRiekhC?=
 =?utf-8?B?VGRaWldNMUxFbmVjdVp1b3I2NW1ZdWhCajNXKy93aEhxZlJrQ3ZIaUJueldK?=
 =?utf-8?B?cFpxUE1oSjdQTEhiYy95azR2NFdCN01PckRDWXZYM1RsaXJ0SFNhMDdPV1A2?=
 =?utf-8?B?QjQxdEp2OW5FMWh3cEdYWVhyVFFRZEluNTRXVW9TSUtNcmdqZ1oyeDlYVXFV?=
 =?utf-8?B?eHIxdkl6ZlFhN0xaVG1IY3p2ZEVQTWlzWnQrNTJncDR5V1M2L2hYaDdxbFB2?=
 =?utf-8?B?Y3lucTdwOERZbE5aWDU0ZWl0QlFQZ2U0VVV2NFJPNThBa2hDbU91MXlMK2da?=
 =?utf-8?B?bFlnbUR4T0JlY0haN0xzSnBUMGlZY1ZhME15cXVON3RFWFR0WFdUTGJkYjRy?=
 =?utf-8?B?VjhGUVRtOFFiaVhQdHVFeUljWDkrZ2tlYlBLbWd5L1Iyb05mNXcrZWZ6Zkhi?=
 =?utf-8?B?WnRTVm5rWE9Ob2lpUkY3RjBkOWVIbmowcVZ0TlF2WE5tQzNCZEViU21xTmlX?=
 =?utf-8?B?dkpyOGovRHlBNWRyT1JBZ2s0bGthR0tISTg3OU5LSDNSaXVUaEpxTko5M0F4?=
 =?utf-8?B?RWtJVWhRTVE5UTBLZmhWNHpTZVNzdXBFNUpnMEttck9Dd2Z4akJEL2oyQi9I?=
 =?utf-8?B?V3pwNEY3VFZiY0FJSUgwNk9QY2ZTR0w5SEt3UWQ3ZEt3RmxINEg1WlRsUnBu?=
 =?utf-8?B?RkhOclpsNDQxQ0J4dUV6RE8wdUFWbElTa3BMVDhsUEdnZW85bnRpOFFZRXEy?=
 =?utf-8?B?ZEJvUU9PUk5SYmdKU09PWGZ4NjJIUUhZbkc3ZWtlajFVbjArTDVtUEtHR3JB?=
 =?utf-8?B?d0dHRVlMUDJxUXdBRmtZVVhsaUxDc1UwVDlTT2N2WUg5azVxVURTT2R0Y3My?=
 =?utf-8?B?aXlNU3VnUTY3cjREVGgzVFlVUC9KSGw4ME1XVTgvNEt0N3hia2piYnNTNjRy?=
 =?utf-8?B?Q3ZDaDZHdE9la2VPQjZUOU9WeUZhZ1BUWXFTUWxVUktFOWliZFYwSmcvYnBz?=
 =?utf-8?B?QXFkRmNlTTY1aFRIRGlzS1ltS1hrYU9xQ2lTQ0JvMm43TUhNcHJ5NmpoQUwy?=
 =?utf-8?B?VGNYaEl3Yzl2S08xM2w0SU5HbU9EVkpnMzgydlBnNnBjM0JXL3ZuVENnSDJ3?=
 =?utf-8?B?THI5NGdCdGlqODhuczJJN3JXbUp0ZWRjZDJOR1VCWWdOQUdPaUlZS2NWK2ZN?=
 =?utf-8?B?TWRha1VpWlZiVlNpSXZMNjFpQ1dBNGhvb3RiQjBDTXQyTWRZckl6QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0a9625-26c3-4b58-572d-08df338a53bd
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 17:55:31.5879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQQot8E80z2YeGFmmnFXLGI2Pu/Bsm5RDrzcTvR+AAbcI0w2sKAUG87a2M2dj4UF6JrObkaBCzHUBhrD3Tucfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-22 06:55, Olivier Kaloudoff wrote:
> v7 drops the bounded fence wait entirely per Christian's NAK: fences on
> a removed device must signal immediately, and blocking for all fences
> is the correct shutdown order. svm_migrate_copy_done() now does an
> unbounded dma_fence_wait() and returns the fence's error status, so
> the error path is real rather than a timeout escape hatch.
>
> For that to be sound, jobs pushed to a stopped drm_sched entity must
> not strand their fences. drm_sched_entity_push_job() queues the job
> before drm_sched_rq_add_entity() notices entity->stopped and returns
> NULL; the job is never run and its fence never signals. The fix for
> that orphaning is posted separately to dri-devel:
>
>    drm/scheduler: signal fences of jobs pushed to a stopped entity
>
> Patches 1 and 2 are unchanged from v6.

FWIW, I merged patches 1 and 2 late last week. So you won't need to send 
those again.

Thanks,
   Felix


> Patch 3 is rewritten: the
> timeout is gone, the fence error propagates through both
> svm_migrate_vma_to_vram()/to_ram() callers (with the destination-page
> rollback and migrate->dst clearing Felix requested), and
> drm_dev_enter() guards only the job-submitting sections.
>
> Tested on gfx906 (MI50, 16GB HBM2 behind Thunderbolt 3), vanilla
> 7.3.0-rc5 plus this series plus the scheduler patch:
>
> - SIGBUS'd managed-memory hog mid-migration: process reaps in seconds,
>    kfd_processes_count drains, no D-state tasks.
> - Thunderbolt deauthorization with live KFD processes: SIGBUS to all
>    KFD processes, teardown completes, pciehp removal finishes, host
>    stays alive (previously: immediate wedge/reboot without trace).
> - Re-authorization: clean re-enumeration, KFD usable again.
>
> Changes since v6:
> - p3: removed dma_fence_wait_timeout()/AMDGPU_FENCE_JIFFIES_TIMEOUT;
>    unbounded wait + return mfence->error (Christian)
> - fence orphaning fixed in drm/scheduler instead of worked around
> - v7 split: scheduler fix is a standalone patch on dri-devel
>
> Changes since v5:
> - p3: both svm_migrate_vma_to_* callers check copy_done() and roll
>    back failed migrations (Felix)
>
> Regards,
>    Olivier
>
> Olivier Kaloudoff (3):
>    drm/amdkfd: tear down KFD processes before early fini_sw on disconnect
>    drm/amdkfd: stop restore retries on device unplug
>    drm/amdkfd: propagate SVM migration fence errors and guard submit with drm_dev_enter
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  18 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |   5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c          |   9 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c         | 108 ++++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |   6 +-
>   5 files changed, 109 insertions(+), 37 deletions(-)
>
