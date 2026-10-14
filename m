Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676ECCC6B2C
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 20:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBCC310E1BD;
	Wed, 14 Oct 2026 20:53:59 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D4810E55A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 20:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUSQxNzRqwybC+JWz2rL0j/GKm+eO4/zjmHQh/7gM2BFBVVmEmGr1aJWhB+9QiBzhrpb1y7rCvKQNRX4Xgq8Tyw2/ZYjYjVaFx1cm1qUUFIHShnVcQ9een9W/REA26U8zh0iIVngVDXx4TG/VXhcdkVjzLQ4nT0ItCYG6Tyt1d/FI93GN0IsfmqDSJ2BChUACgX4zC+X9w92Q//PAnaDlMgHj89+NiGxYaDqykhb8snWxdP10UxBQ454ia9j0Jm/EhquLPq1eArJ9djiN6xspj6PQ+VGwz8m7nPxGkN4LO/VEqTby1Azb2yaAQvWd/uCN1BduUC6S5K1oPvPBC8eLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gmKsurbaMIdaG8DCfAdgjHLcN9Q6Nt15vJipyCxZqE=;
 b=QIKWa87sBmr1mwrw/a6dMc4sSJYzwL22C6cRnQFmsN44C6zKOoCVFgHhL+hLuu7wweN1WaIJIsP4ZyWqK6FL5G1gpw5jLuPAcj/iH9D800e4AvWu9FMs9Yyjqw0eN88hvCR2obvavz7aCK3Hz4jDm19xA4peT8p8n1m/gEfRbPtm5vYo00FgvyPI5vSvJyuLu9XTwLuIK7BCb6Rk6gYKqn90JYhr5WDNLjR0q31ofiDhjRTS4P+VAWYunhElDeHyy+AeeoUpOlIBGZu3w2hJbgO2w6LOYN9ScYeilP40AGn63fL9RzVquq/QeRAi2WBO0MZremVgMpB86tOFhz5CdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gmKsurbaMIdaG8DCfAdgjHLcN9Q6Nt15vJipyCxZqE=;
 b=sRUXhVFgi3jaJcuZA/BpmyZZly3l+0QIpOycXwsx012X7l6tDDnprbo/y2nXJpja+Kv5PrOmlNXjWxRxtlgoiuPOd11UeotnODppQfyUT4If5mF5BwQNXfr+xGRCJuYT1j92Ol7mMX2vTnJ2XYnT9/vusBAsiJBU9an9DG7GUc4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS0PR12MB6488.namprd12.prod.outlook.com
 (2603:10b6:8:c3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 20:53:46 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 20:53:46 +0000
Message-ID: <0737e039-b4f6-4675-b50e-bd2937375e5a@amd.com>
Date: Wed, 14 Oct 2026 16:53:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] drm/amdkfd: fix wedged teardown on surprise removal
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com, xiaogang.chen@amd.com
References: <20261013185313.33496-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261013185313.33496-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0232.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::7) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e50c78-6ec6-4fdc-fed8-08df2a353d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|261009223027099003|3023799007|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: xWIXCNwydz8QaaehtEsZzQ8YCKDb7LcBkuSJGk5VwEnpiCTvXrjggQO3koi3XpxeiMG4kioYLZi4/4xrxsnk5TmjopsGcs1NsEr9zZuYbfN2TtxNKf9cioVlGI6bmkshCZ2ES6IpPWGkonC6AKIBKtk4XxK6G1Yd420zECW7G7Kna1+g5BvE69vogzy0bdYyW6b7NV0VaE7c4LUHQREza6kwOMy0VZZk589inIBqgMot97BJZzL0+NCCnTvlgEPQKo4OBr9/LDnVkHqGqpvJEYzoI8uaPIBr+abG5uUM+PBG4iom0AOh1DFMJE3KoHEMczyLXu7Vme//+fEkf27IUVEE42R65+E5vLqkIA/3M3bujSmoCwFdiRG7sNbSiHCz/2vRZSPHQkP3vpJQHKOngH8KSN3Xg5cN2NiVBjJdG9Lw1xYX6ayloZf2e7wMt1lOPsSZ2jxkDJkjMuGsTeRiAsD+eq+mRr5U/4OIGZ49cqwAGl+TkfHRYfV7b99sWNjp5G/R8dGe6EFq3wIfJwtnZAqrU3Z5cCbnkk3w/B7uA3Wg7f7tqpr3V4R7hkWqSPM+TF/g676SZFLDax5bZ1jfioH6vgbI2J9xYAqRzlabhcxbYe7mIk4aXY1CnkU+zIIng3dx2LRVFzV4jAOCnZcfzRcnl3HfPqSDVliKTSwQPhU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261009223027099003)(3023799007)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2NLM0E5Slo5ampiS2N6YkRzOHB0aEFpdXhKVFg2SnVvdVRkeStxTDlKNkJn?=
 =?utf-8?B?K2RFY0hzRURBZkE3SHJUR0pUd2pROXdYbzdtczVxcWJxMWJTWG1WaDArUU54?=
 =?utf-8?B?K1dSKzhZNXJUNU1VT3dOd05xWUhUbW83cjFFK2pQeDVucW9XN0ZidlQxNng2?=
 =?utf-8?B?bWJQUzVIRXZYeFV6MUh4dHZiSU5qcjNkOUU3MHBzdVMwUzNUbisyTW12UmZH?=
 =?utf-8?B?c1JLVkE3YTR4L0VJMzBIRmdncjIzU3Vwb1NIdGtBVVV6cnBybjA2R3pHU3N3?=
 =?utf-8?B?b00zNzdiWVJjdi9CenZhT3pxY0xzTkRZcUJVdjdjZFAyZDhJRUUvL3ZYQjNF?=
 =?utf-8?B?bmFxYittOExQeDFuMWNqSEpCelNmYllxWVhuSlFibWxhNkU2c3pGZXgyQjh4?=
 =?utf-8?B?UXpUMlFsNWVzNUE3RGw0dUhIMTlWTXprSGV1TnJxdmJyR1JuTzBMbks1U0Qx?=
 =?utf-8?B?NGg2d0FFUzRiS2FKQzZyVXZZa3pOSnRyS1Y4c1N2dGJBQjJzUnBwVG9LZHR1?=
 =?utf-8?B?RWNwVDR5dE8xS01yYzhpaGQ3VnZtNjBrQm1IVUllY092T3oyMmlnM2tITkVN?=
 =?utf-8?B?QmltQUVac3VEQ0JmdUFTamcvdzI4TXU5K3dhcWZ2ZVVVMHAxMnBVN2IvNmVG?=
 =?utf-8?B?WXpIU3JJLzF6MzFCeWczUUZsdUg0aUxEbSs4YW9aZzFHQU5SQWt2LzdtaXVv?=
 =?utf-8?B?elBqaDlVaGI0VGwrMWU1SU42aFB1WHB5VFpoNi81MHFIdUYyNEpUWFdUOXh3?=
 =?utf-8?B?bVhxWUUwaWxZQVRVV2RrK3Y4Tkd2VkpNQkErOVNaeUQwYXpZMndoRkZBYVBy?=
 =?utf-8?B?V2ROYTRQaGRFdGgrWVFQUEU5NG5rTGdSaDFNSFptd2ZEVFJJYVp1djhzemM1?=
 =?utf-8?B?dGxWN1NEMFVGMmFMb1ptdktDSVJIOGlMZEJwaTJlQ3hsdVNBdGxUd1Y2WHhL?=
 =?utf-8?B?bU1FTHJ3KzlCVHV5NFFMZWY5Y2VqZ2xPSkE3cEI4SG9ZdVFLWXJKczZ4SUJ5?=
 =?utf-8?B?alFOcG1DMW52aXNDUmVER0hTY2JxaitiYmhDZGE5QTgyYXd3UXBWVzdSSFRs?=
 =?utf-8?B?NXZQeDVUTHhMUXVUVldObEZjNWpUTUJBRzdhdFA4bzNTSkRHdXZSVWtIQzFi?=
 =?utf-8?B?Yy8yM0lPLzFDSG0rVXhpK3dZKzBjYWNCRk5DUWR4VkFUbnZPbVEwU0I3TERT?=
 =?utf-8?B?UUwya2RuK1ZYMzNCaDZ6S0ZRYzJaYkRyVGJYSlYzb2toRlJadDBza2NWd3Mz?=
 =?utf-8?B?c3d6aG9wWDFFNUVWbWVPSEsya0FaeFNReEhFdWdPcHFDZjU5QWQvaXlYbGRk?=
 =?utf-8?B?MWNXZmwzTWk1c0Jzc0wxQ29KWE5YaFM4SnVpZGtRSDZRcVhlQmxNRjBRcmNN?=
 =?utf-8?B?QjVpTVVQbzhGVVBybDE4RFNjV2cwWGhKZmJqazVrbmJ2b3huM1V3emNXTUlN?=
 =?utf-8?B?OTRRbGloZ2hZSGpxQTcwWmtDR2IyOUxTcGg0YmNKSXJGTTh5a210TGN5MXpH?=
 =?utf-8?B?NytMdnZ3cVZ1Sjc1U2pWUm5ETnh6NmdoREVkTEtuZk5zZ2FzTkM4c0JXU1Nh?=
 =?utf-8?B?eWpPaEF0UUZBMnBReEJyclI0UmptTUNpT3pxMnY3VVB2bFNVejV6NjVyNEJq?=
 =?utf-8?B?YWwrR3N1R0hHVlAzWitiTG51QURaR3owMGtISkpobHBYa3JsZHYxanFwb0hN?=
 =?utf-8?B?N0xtajA3TTV3Y3B2YnBnTzVDOE50WVRXSXZzNWphVW1CY1FYT21JWWV0UHNl?=
 =?utf-8?B?T0hpL1A1bFdEOFhCM05vanB4V0M4YlVsS1hseDlzd2Z0VWZjNlZBamRxZ1JW?=
 =?utf-8?B?d1c3amNwUWliU2VVT09ucWwrS2FwMVhWajV2QTBJMUlvNGtrcmR5S1owRURX?=
 =?utf-8?B?bXVTQ0dzVDhZRG95YlQ0WWExeEdlbklQQWJPZVpIUGhFQUhLa05GeWY4V1BT?=
 =?utf-8?B?SHpiMnlOT1hCTThCb2RVZWQzdHNyWWt6ZEErK2ZVOE5vTUp1NjErd1FHUmRw?=
 =?utf-8?B?QmpqNE5oem1yTUM2SC9JUFQ3WUFqeEhHU3RvamE5a0pROExHZm1QWXBpM2M5?=
 =?utf-8?B?ZUNYVlJ0bXZKWVVrWnlMMkpRTjBGY3dCZk02WkZRWXJ6VUpoU01yRUN5Wk5a?=
 =?utf-8?B?U1U5dDBpSXQ5aDdrVmFQaWs5eVIreVBCeTd4WTFmeWVKRXdDcnRKZGxqeTB1?=
 =?utf-8?B?OHNpZENVUkhsRkgxeDlHNGpZdk4rQ2gwdFhWbEJzUkJrekJNc2UySEF0TGZn?=
 =?utf-8?B?L1RLcHBteHBtN2pmMWpYSnFjTHR3YkkwSGdvOFRDNEMyZWpDdURDWmQ1WjlU?=
 =?utf-8?B?TmNMK3BmREd6Nno0b2k0L3hEaG4wTVdvM1c0Qk5UZWVkQkoxNVMrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e50c78-6ec6-4fdc-fed8-08df2a353d49
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 20:53:46.2234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSi5+eRqSvlDQPUhaV4e2UARKAlJLp/0Ha9wJq8gsZvTEPVhEzYuwWAHYbpbHm5/W5ItgUNgwysgHZAN8D3rvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488
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


On 2026-10-13 14:53, Olivier Kaloudoff wrote:
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
>     section or the faulting task indefinitely. A failed copy now also
>     rolls back migrate->dst and propagates the error instead of
>     completing as a successful migration.
>
> Verified on MI50 behind Thunderbolt (2 GB SVM workload, PCIe slot
> power cut): the workload takes SIGBUS, coredump completes,
> kfd_processes_count drains in ~9s, pciehp removal finishes without
> warnings, and the device re-enumerates cleanly on slot re-power.
> Previously the same repro wedged the host every time.
>
> Changes in v6:
> - patch 3: check svm_migrate_copy_done() return in both callers; on
>    failure release dst pages, clear migrate->dst before finalize, and
>    propagate the error (Felix Kuehling)
> - patch 3: dropped the dead ret < 0 branch (Christian König)
>
> Changes in v5:
> - patch 3: dropped the drm_dev_is_unplugged() and
>    pci_dev_is_disconnected() checks entirely; drm_dev_enter()/exit()
>    plus the bounded fence wait is sufficient (Felix Kuehling)
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

Patches 1 and 2 are

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

For patch 3 I defer to Christian's expertise. That said, if we don't 
need the dma_fence_wait_timeout there, then we also don't need to 
complicate the error handling/unwinding in the migration functions.

Let me know if you want me to submit patches 1 and 2 independently of 
patch 3.

Regards,
   Felix

>
> Olivier Kaloudoff (3):
>    drm/amdkfd: tear down KFD processes before early fini_sw on disconnect
>    drm/amdkfd: stop restore retries on device unplug
>    drm/amdkfd: bound SVM migration fence wait and guard with drm_dev_enter
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  5 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c      | 29 ++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c           |  9 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c          | 97 ++++++++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c              |  2 +-
>   5 files changed, 113 insertions(+), 29 deletions(-)
>
