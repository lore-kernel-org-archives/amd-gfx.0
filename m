Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B27FCA6016
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 21:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6AC410EA24;
	Thu,  8 Oct 2026 21:44:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sm1HQYh+";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 413CF10EA24
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 21:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fO9dmO5uAuE689UtxNhUerAagTKBYCOuKdskAH5xZ2oUZo3YSW1GW+kVTwoHrpSNyG1PNj+Fmo6SmpgR+iHOUWa1Y9yXKgh957rDhu+YLRtgeoOn1gNnI3YYJDpLFAFIzfWHegEioM/YUoqS0bNf4ODDwbbqV0jNVMdfZD4/ej4EUap3j6oL2ULUiqVXuakP2IWqn1vSdHJ2ablqdMbA5RAA1PH84y1Oouhc+2wpAQNLqg2XfckRm3C1DRodc5l+Z4SctFgb/32FoM6/ocSCASCROT+PNWUP7puYRMdIH8QblAIIqwPBGSvQFCfTRGrpE8OcfeZQ4pkhb0dwmj4VHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBZnROwB2YreTLUieDKONgA0oJE8bmKKF4BbLEIQwOo=;
 b=t3sC9ct0AxKjusfrleWA3nWZfNiWEKu+uShCtRt45kQ0ffVqW9Mw2DeA5Jk5+DdnPd2PoI+WODmPqJX2vVLqgc9f64hLKd76CWeFUQbYmd4xmlYn38lI3Tdc8TxBqqqguqGPyKuXuWJEoicxPceemds9yfbP5KmuSKzAuVlxcyvp5uwQqFMd90EdhAVWiEy8VN2kYAOh92xjdm+4nWQj6CtdAQC3W4JWbUXt2tzwpBK2Oa0EFcO110malA/Y5GVjR/9j5ULQnpqS2snQgG9x2rf1ybAbc/8NnRhcVDE7DYPfCUhI5RXavxbdDBaKB0XdVwld07hHNS/5wyR0N9ChCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBZnROwB2YreTLUieDKONgA0oJE8bmKKF4BbLEIQwOo=;
 b=Sm1HQYh+OPZuwzGRRvT3TQPKn7hPhgYwS5sh0NgfsI7zheHZA48Bcve+RGP6AO8T9QrLyMY1cXWWXFnRLs6EoiSe0eg5SHcin4mMuxHSAcfJnFhiSCyICsqSYQ8Ibq0xROEtJuee2gasG4G/rqz06uFgh6UTf39jFzuF3CqwxvU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by PH8PR12MB6795.namprd12.prod.outlook.com
 (2603:10b6:510:1c6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 21:44:37 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 21:44:37 +0000
Message-ID: <5a6fd15e-4600-42c4-9b27-d066ad9ac6f0@amd.com>
Date: Thu, 8 Oct 2026 17:44:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] drm/amdkfd: fix wedged teardown on surprise removal
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Olivier Kaloudoff <kaloudoff@icloud.com>
References: <20261008173350.40455-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261008173350.40455-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::15) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|PH8PR12MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: d4895e51-c551-43dc-4b5c-08df258559ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|3023799007|6133799003|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: Mk/gH0t6VD7bBYs3gbsRDZWSglmc197CfaQ3j/Q/NDFtCPxB7hTLELgBkBOr7Ez02tjX7t5B4HQItjnHlzH8TMwAd48Agf1sRdOVTxlszbKLl04Sh/E8i01FqaZK8rKX07INiKz2m7LN/AUuUILMthlrKueyfzyiUmsYiIveMM649ZlSdab7BT6fap503pE/fP2N+7roQbEY5Fa/XypLd3GZyM8bkyu54gizpt7ciP08IRG3Nvi0f5j6OHbilKdHsMdDTqTZZE16ckN02CSmPbjk15wXKKLb/iGN53yXmOIe3VhYVcFlbX76PsuQN1NNQjaQ41Ra566GuuHtYEzz1ZvN0SdZwAdyz4mIMl4wcmJpB5MykZa8rZsOvBpGP1of/vdva8pJHLFP5oaels+63vEVa8iEEsd0oh0lUPW2Ke7hBkenqZYK+nTcZSz4Jm1xZmYDTLKZhUvBplA+tojebpbH3ZIrVUMxCUS0qp6GTIo1IE0/M0F1cFX/Cwu/mSJFsL4KYyEdUl6h2Tu8x+BhhCkDbdTCLLT6itfjayw2IYoQCk8Ttg+w5NhaMcSA6CdPF9ke9qid5aQzPP7IciIPEhhelLphkuaRqJfZEC4ft2SC6SjSCY23pQyb1wFj+KLUXAxqLsnZI0YB4HV8atx+8oSY2ShcKM21oSl5FRjWgFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(6133799003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFp5N29zbFRnMWE5dlcwbXN0M3pQTXhybTNNaDlCREt5Y1BwdTF4RS9UbExt?=
 =?utf-8?B?STVGMWp3b3Z0MkxFWjZCN0FsaUtuVnkzUHJhTUg3OVVDek1uTXo3NGZ2ajRh?=
 =?utf-8?B?SEx3U09oeTVmTmtlUDgyZGk3RGNwVUtzNUd0WXI0TENvWlVHVyt2RzNrTDFy?=
 =?utf-8?B?NzJ2SXdlZlAybHhEQWxxWTRqd0hCR1hQRHpNdEV3Zmo4UVV5TEZpbHR0YU1h?=
 =?utf-8?B?SXN6SDdPV2kvVnNXL05qVVVpZkdoam42Q0tCblI2WHRXSVhjdUo2aG1qaXM5?=
 =?utf-8?B?OHd1aGpSeHN2ekp2K1ZDWUZmUkM2NlZGbDgrZmt5MjZ6UHB5SGZNcEN1U0Qx?=
 =?utf-8?B?dXpyamp3UThaYUwvN0F1VDAyaE5VM2taNFlwUHViU0t3dkFTWlJqTExKL1F2?=
 =?utf-8?B?TTZXL3NJM280REQyZWFlVjNtU25EdXpMSms5MnVmODBTellFRHZFWFdQcHhi?=
 =?utf-8?B?bmxvUVR4SUNtbUVMQmJ1QTV4aXB6Y0xPV2E1OFpUbmtEdjNreHo0VWlwRWs2?=
 =?utf-8?B?Yk9qSDRhRG9naENKTXI1QUhCeFRMRHdLMDR6R01OdVVjRnNCOGZiWjNTSFVj?=
 =?utf-8?B?cm9kNDJqSE95Z0t1T2xFKy9Hb1FZZFdReDBTZ2hYWi9jRHYwR2NiS3pyaTND?=
 =?utf-8?B?MUhUVmFtcHczcU90R3N2d0s0b3pacVM0c2VaYzN5MnFzeDdtcjRGekZXVHh4?=
 =?utf-8?B?R3dTSzZuZzB4aGNkOFkxaVFKbTBCM2VtUHpqcXlEQjQrNk10S2tPSFdMK1oz?=
 =?utf-8?B?OGZVL0lWaHpjdFhJTnE2V2phaHR4eXZVakFDSW5Vd2k5MXZaN0QralNrQ2tz?=
 =?utf-8?B?UWdLY1RiTHNGOVFpMURoNDVDa2lxR2IxZGo2aVBDVWcyV2RUOVQ2clRzNVB3?=
 =?utf-8?B?djRLTHR6dGtGRXNPSW5aZEh3RU5CUS9mcnN2dC9qWUszRlh1RzAvVTVhT251?=
 =?utf-8?B?dUdhR3RhWElGVEVkenBkV2JrUnFxTEJpMmJ6QzFxOEszRUZZQTdJM282YkxM?=
 =?utf-8?B?RjdyR0hIdjNXcnVFWm1ZZlhKblNWOHBvMnJUZklHQXpBU3lZMCszR0UrUDlq?=
 =?utf-8?B?L3RkMnhmYytzVTdSTXBObE5PdU5NWkVDQTlFSVpTL0UzN0tXRUJDb2l3RGs4?=
 =?utf-8?B?RWVzVUxlWEFiMUJpZyt3eEI1cm0yUENaWDliUHBlQ2Y4S1Z6c0J1dU1LWjgw?=
 =?utf-8?B?VFlFRFk0WU9CTE1tS0NPWit2UXNCcXhqT2ExbmJGMXUxYkpIdlNVOGhodlB1?=
 =?utf-8?B?bEhEU1ZGclpCL1FSWnV2dXdIcDNLaU90QjlUb2dYbG1XYXBacHM3ZDVqeXR1?=
 =?utf-8?B?MkkwWHpRdUpMU2YzYUNkeC9WdUI3ampsOUV1VjBZRHI4T25OM0JPeU10ZEVu?=
 =?utf-8?B?UHM0VjJzYjFqbkNHcG1acXRRa2xZamN2NXZENmI4QnFtaVpQQm55bUJJZVJn?=
 =?utf-8?B?aXVBM2t3aGc2S01GMFgxQkVnUm12STJjcENMM3lHUzgvQTBzY2lEalhqWCtU?=
 =?utf-8?B?NFNpSFU4MC9MdWdJQXdtZHZOb1QxeStNMjZzOStvL3lBYlh1ampVZ1Awdjlx?=
 =?utf-8?B?cWpaOFFKQzR6RUdwMG9hcjhZeEVXTHc0a3o0N2FsUGZIUTZOVFIvOVF6OUF6?=
 =?utf-8?B?V2tmMW81bUxYankrZ000ZXBXUTdLcTd3YUkzRnJUb0FPbzFySjk5UXMrMTdx?=
 =?utf-8?B?YWF5bnE2UytlVW96VU5BNlFJQURreFZTU0V6aTA4T2xUcWZodkoyUVpOa0Yr?=
 =?utf-8?B?ZkZ0WmVxdC9aemlJK3lzSnVjeFJzN0hSWFk5am0vTC9FU3Q3ZHIwUlJDZU8w?=
 =?utf-8?B?NzljOGVoS1dFVjZYdmpZcHZBUmJKUWlkcGdJek9WQlIyaHFtcWR3QitFVzQw?=
 =?utf-8?B?K2dnOUVDUUxWZ0lBMmpJSGJCd3RMNkpEZ1JnL29Ta0hScjlkR2xDQlI2ZWM0?=
 =?utf-8?B?WjAxemlEN2RiWHBQOW9aRDNnS2tYaUU2dk1KZEs3WGdKODl3WDcwSkNnOVAz?=
 =?utf-8?B?anpFRWVrSjZPNnlhb1dkVUhYVTZDNVJRcGFCaWRQU0NURjFNeXRnbmFKcEg3?=
 =?utf-8?B?bFBKN2kxK25EZXMzQUJJMDR4cUlTSCtNdndleURDM1NCQ3JkSnhHTlRUSG95?=
 =?utf-8?B?eGdQWVVOcGpPUmxJUk5QL1FxZW9XVnhZdmM2YktEaGRxV2t1VWk0UERGYTE2?=
 =?utf-8?B?YkJYbTlZbUNhbUtROEgyOTVqcnBudDhVckxxOTFYT3lpZzN2NHcxUXMrcWE5?=
 =?utf-8?B?c01BakZHclpiYmRhU250bGhwbFdJdzVxRmFmSVZNQm9HT3JQRnJSSXV2czRY?=
 =?utf-8?Q?PVG8Ipun0NH5ypv7nz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4895e51-c551-43dc-4b5c-08df258559ce
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 21:44:37.8327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHh86Uvl55dGJDHW92MN69n1MQ+1Eo7l90SC7/s6V0p4gc2ILrDW5QO6KaDLRtKQOsS8oz1NGL7t+73xHk1i2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795
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

On 2026-10-08 13:33, Olivier Kaloudoff wrote:
> On surprise removal of a GPU behind Thunderbolt (MI50, PCIe slot
> power cut), the KFD teardown path wedges the host:
>
> - the killed KFD process faults on its own SVM ranges during exit /
>    coredump (SIGBUS -> get_dump_page -> do_swap_page ->
>    svm_migrate_to_ram), submits SDMA work to an already-killed
>    drm_sched entity, and waits uninterruptibly on a fence that can
>    never signal;
> - the dying task holds svms->lock, which wedges
>    svm_range_restore_work() and prevents kfd_processes_count from
>    draining;
> - kgd2kfd_teardown_processes() therefore spins forever in
>    cond_resched() while holding the pciehp removal thread, producing
>    soft-lockup and hung-task splats.
>
> This series:
>
> 1. tears KFD processes down in amdgpu_device_fini_hw() *before*
>     amdgpu_amdkfd_device_fini_sw() frees kfd.dev on disconnect, so the
>     drain happens while kfd.dev is still valid, and guards the second
>     kgd2kfd_teardown_processes() call against kfd.dev already being
>     gone;
>
> 2. makes the userptr and SVM range restore workers stop rescheduling
>     themselves on -ENODEV;
>
> 3. guards the hardware-accessing SVM migration sections with
>     drm_dev_enter()/drm_dev_exit() and bounds the job fence wait with
>     AMDGPU_FENCE_JIFFIES_TIMEOUT, so a migration cannot race with
>     unplug and a fence on a dead device cannot stall the critical
>     section or the faulting task indefinitely.
>
> Verified on MI50 behind Thunderbolt (2 GB SVM workload, PCIe slot
> power cut): the workload takes SIGBUS, coredump completes,
> kfd_processes_count drains in ~7s, pciehp removal finishes without
> warnings, and the device re-enumerates cleanly on slot re-power.
> Previously the same repro wedged the host every time.
>
> Changes in v5:
> - patch 3: dropped the drm_dev_is_unplugged() and
>    pci_dev_is_disconnected() checks entirely; drm_dev_enter()/exit()
>    plus the bounded fence wait is sufficient (Felix Kuehling)

Thanks. Patches 1 and 2 look good now. I found one more problem with the 
handling of the new timeout error conditions in patch 3 that will need 
to be addressed before this can be submitted.

Regards,
   Felix


>
> Changes in v4:
> - patch 3: AMDGPU_FENCE_JIFFIES_TIMEOUT instead of an open-coded 10s;
>    drm_dev_enter()/exit() guarding the whole migration section
>    including the bounded wait (Felix Kuehling)
> - patch 2: folded in the svm_range_restore_work() -ENODEV change;
>    fixed a latent uninitialized ret read on the evicted_bos-mismatch
>    and confirm_valid-WARN paths
>
> Changes in v3:
> - patch 1: NULL guard for the second teardown call (Christian König)
> - patch 3: new, fail fast on gone device in SVM migration paths
>
> Changes in v2:
> - patch 1: drain before fini_sw instead of bounding the wait
>    (Christian König)
> - patch 2: new, stop restore retries on unplug
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Olivier Kaloudoff (3):
>    drm/amdkfd: tear down KFD processes before early fini_sw on disconnect
>    drm/amdkfd: stop restore retries on device unplug
>    drm/amdkfd: bound SVM migration fence wait and guard with drm_dev_enter
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  5 ++-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c      | 29 +++++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c           |  9 ++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c          | 36 ++++++++++++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c              |  2 +-
>   5 files changed, 70 insertions(+), 11 deletions(-)
>
