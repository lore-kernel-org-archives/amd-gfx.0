Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A07610AB807
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 19:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F4210E1E5;
	Thu, 26 Mar 2026 19:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IBd4HxqC";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 275AB10E1E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 19:39:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dn90FIXFqqFRLJfhobgSmhZ0WwJO2kvYbrNjzktshFSz8oO9oKO6s9lbAWL5mCIdMlOmfAO3TbfNO4sWStG3S75u04noh045/E7XGXuNWaFQKX4hivBnssbZiVge7MUn67zVDqHHcuItW+9GUo2J9Ag0asYJkWZY5Mgher2Qv1Zl/NMZb6NTVC4FLA9PJImUtMclkgnBz0HlZHo7G13JlDW+oLnNrNulkxW/G9XzbYZijxnvRwXceIUYe9RH817B0zp4pm43YfFCIa7IcFDDaNpSX7NT1jG7BT9O7EW8YXcbklPsyNWVvhQ1sc4YOneqTGvsx+X9z9vjG3PRX5M8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljpIcK6SdLq+WDT9nQdN8oz1sE+wjxAOti4fHZEuM7Q=;
 b=vhZInORLhYK5fBBXBUPeb0cRy+IA6rMCLZbY5AXw31cR8/1v0Xhet6Fx2gvzAkwgO+6Cf8fAMjAeFs7U7AM9hqACFKbT6R7ZXHhCuJun8Lt36rXDrm8KfKyO+NJuBNDHJUkHnMvoJK0CJr5OJ+IXNVB9bEyxMAqoxT5haLp+oOS82CmvdFI4k5ipiJTsXRPdc4+TLZ8zBc7ft1W2BzAZT6r3b0plifRPl/CTwrnXc44nWw5cvesSCW0PKp21OCE6srrt58bUWtP8cCVyRxMpexHvZ4tdJj2+C9Ui3y5V1NTWLI2ybwW0nJjv/fLy0yVIZCjOgNc5GnLJBmVh9DWU/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljpIcK6SdLq+WDT9nQdN8oz1sE+wjxAOti4fHZEuM7Q=;
 b=IBd4HxqCl4klma2tNvxgWA+133kJdPpNmWLjCJ4fvLDyqxjTi2rUQ/3JCcUVyxSedrVKuTXdF88kBD9jvMfPK0fbxQ9DS5QArmB55fN3wZQH+QH6pMQQDX/EMRPMmbXj1Dw678TUcTGeRO0sXRZSBZoj/D/8wpOShwU5CzCczEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 19:38:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 19:38:53 +0000
Message-ID: <e42b75af-068c-48c6-b8a3-1db62331c113@amd.com>
Date: Thu, 26 Mar 2026 15:38:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to
 64KB
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, stable@vger.kernel.org
References: <cover.1774521183.git.donettom@linux.ibm.com>
 <2e3d4c1dafc6d2780ca502c9d78e8ac250122d96.1774521183.git.donettom@linux.ibm.com>
 <9c9c73e1-abe4-4307-9d44-37544fbd1596@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <9c9c73e1-abe4-4307-9d44-37544fbd1596@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 098c0199-a022-4bd0-cf0f-08de8b6f4fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: HFlRfUUcZcWJ8rdEASwSzalFj7TlWBzNFlSR1pU+FlmP8TH2YJdTD+r6kdMReXU3Bl1N5C8LrNkNCGO5v0T/+AXRg8ogVRUXhQrb6BMu1KkQuXkpid+42jw0TZDIDBk8g7N/IJs4+nhCqS99fUK+DNIzfzevUA9MsBFwPVjOAK5Dpff9Wu0rOEAp17N5ZuV59EKDpUbapCPyNY4iHlnfboKPJZmCX57cjGHpHTNMzFXSogoBSxrv5azqJ9mj0nR+YcXucr65hs2g66YVRpBB1WGZYXSPoyS4Wju3fAmjQ+q+qtZZzMm8b2TKEMZ7PdXMeQWRvoRbguKeVu/cxm66K6M2YIXF5zWQ/F9EzsdcqZbcb2/nYaViIV5Yy/y6zgH1wDF12i9vZFStb7Eu0o/TVnMLKy3mGFGd/KKPPeDqVe1l4l1TkXJUT6japgeHYyw67sH1G5mXmpn6B7l0VsXoZTHnxv1Z6H4Krxk3o/rCecJVR4JOsX7YRTGjkYtYqVsMX3Cnv4ZsYjANcMRa7F0Lb1ebb3Vyl+KaUwjsAofXZ9UkdhOR3dQFZOR36IifAvPnFcuOaLcMJj1QO8rq4bcmpcCWxdq6EQdb5gp5p9WM8k7TI1WFb1bOPxi9H8Gzb3hbLtzGW7INQCchjF4lMe73DCUKH2s2uVOjKkJzYl/0pvYcL/cYTN7XGb+2BXzV2RmuWy1XAGmt3o2wkWYB4QqXhXFpTM5vbmXQkXT1XW+UOkM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDRhWEwvWC9jNldSVHBXR3NoTHNYdTlZTDc5b3k0VHVEU1VhWW9PV0REaHZN?=
 =?utf-8?B?Zk5xd1lWaGRubHhtWmdCTUZhQlFFR0tFVTY3RjRGbGRDTlljSk1oVitXbk5u?=
 =?utf-8?B?S2dBNEhFT0hyRVVsZytsZy9rOVRnMjh4WGZ0NTdmSGY4OE1oYnpxUTN6UFhx?=
 =?utf-8?B?SklqbXB4TGkvLzRQRmhmNysvc01TSkZxUzBqWTNidGh6K0J6M3pma3JhbnV3?=
 =?utf-8?B?WXRJMTNZMGx3K3phRDVjUEE2Rk5kbC9MckJKcmVJaXduTnBoMXBhOGIrRVB0?=
 =?utf-8?B?TzFnVG9hNGhhTkdqWlNIREFLdkJES25KeTVqNWo1QS9ndGI4OE80eU0rS04z?=
 =?utf-8?B?YUlFcHpPelhrbngrSVVQMHFRVWdJOWxiYmllbTJQV1EvMGh0MGROVU45YTBB?=
 =?utf-8?B?QlJLTmNzeXlMd0g1amtpSDN5SGNIOTZwTEZhS2ducXUxZGRnOWNlU0JXYTRy?=
 =?utf-8?B?MFZLT1VsdE9taHloNTJVTi94cS9Cb2w1dzJ2bFhLSEZldEZTZUdTMjhVemow?=
 =?utf-8?B?TlZIN1oxSERxSlNvMHpwVG5EYXIxRWgyakc4anZ5c3hhVWRXVU9BYytkREhS?=
 =?utf-8?B?Q2NGTmRiUlVvNTdYcU9JbzIvTmNiZjR2VkhWSmQxb0lySndxZjRQSGRUc2V0?=
 =?utf-8?B?cnVZakdMNFFuUnBFdlBoa2JZK2JheURBK3dvUW1BRXJIRm41UXFzWStsUmQ4?=
 =?utf-8?B?Z2puZENvK1JnY3NyazdlODRBenJLTzFxNjBnRVRvVXBEVnorK3VJbWt1NG9T?=
 =?utf-8?B?R2hDeG92T3JmdEFrRG9uMW5SaldxMUYrNlV2c3dnemE4b0xWN3pXcG9BQ0pU?=
 =?utf-8?B?Z2ZDRENKOVJmVjI1eklqNWtyNDFIbWtUQ2liUVJwMU5DT3J1b21FKzhPazJG?=
 =?utf-8?B?UngxR21ZTTNLdEJ4TngrRDB5WTJUaTBtUkJQL25iKy9UM2J1alV1VVdBOXNH?=
 =?utf-8?B?TzRFWEMyQVRKeGN4bnllamxZaG9iL2FiY29vVUFLTVlWUmxRNGNiYzh3UjVD?=
 =?utf-8?B?bVo2WnQ5VHBvamV4VmNQRFNRbkZ2eDNvYlpRdjZyNHAwZ05DbTJTOThRdXpO?=
 =?utf-8?B?cFg0dnNWVUxaTWMxQzlOMG1FeXNaVmZEUXljd0dVcVVqSTRKQWR3Yk1PN1pm?=
 =?utf-8?B?NWszejhqMWQ1Sk5scmtQdDE5TXJtT00vTVA4V2V4WUpjNWtCeHhXR3owUUNR?=
 =?utf-8?B?YmkxTzZnNVNTdEdpQWpZT0ZsQlNYMUpZMXhxc0hZNFVqc1h3L2dKYkM0blND?=
 =?utf-8?B?VHVJaWRxb2ZXQmIrQ1BLS3krZTZ4UVlNT3JEc2tLVnh4ejlHR0hCQUp1OVVk?=
 =?utf-8?B?RlRoQ3lQcWJORUs4NExFMml0REttNjFpU2tZbnZvZm1ETFdrb0tWbVVFaUtW?=
 =?utf-8?B?cFBaTWI3eGJHUjRVZHBINndYei91ZlZzYnkzTTkycjA2REJjTFUrS0tjcEN3?=
 =?utf-8?B?bHNtdmVTcWxJSjJZWDZkMDFraDhlK1ZLSU5qR0lWMnlNV0VXVW9PVk5aa255?=
 =?utf-8?B?STRKSXJPNmdET29BeDZUNHhlUTZic2hieER3MDd2L3YyOXdOMHpzRE1GL0Fv?=
 =?utf-8?B?cXVIM1RKaFNDSG1Db1RtdmZuTmVuNHIwQnMwSlVoOGlURGVJRmlhc2NVL0NC?=
 =?utf-8?B?TlRyb016eHF1OUNlUjZPajl3NE9MakszY3IrWlZheXFEaGU4MDlQLzdGZndF?=
 =?utf-8?B?TCszZ1haWEdseVdzeXVTeFlqa1RETTZ4SWtNMGtRSE8xTDZqQzNKaXI4ZDda?=
 =?utf-8?B?S1IraHpaV3VzNE5YbDRBM3d0enFhbTMxMzBYZktLZlVEOXNPOFVuWWgwanhJ?=
 =?utf-8?B?ZXNkU201T29OeXNvTzNyV3BJU2FqakpvUTNOSW56a0U0dml5TGtHUkxsb2Fi?=
 =?utf-8?B?dTRvWWd6RzhudzNqRnNQdWlkdTJ3SzdlOTBIU3dqQmtXWWdNU0lDdjM1aFRW?=
 =?utf-8?B?TVZQRkIzdVNKM3FJSS95SXJ0OEdtbWNyT2xWbXpvK0JqRTlkVTZIK2RnY2hy?=
 =?utf-8?B?N3FERzB6anZMdnpydlZWYW5GSFZ5bDZDVm01eStvMGxlRTBSZ0dJRDNaMXVK?=
 =?utf-8?B?ZXE3eXVaSkR4bk93RXdLUGlidFdFeThnVjQxb2RFaUdiNTBQTWk5ZnBVK0Yz?=
 =?utf-8?B?TG80a1ZzUmo3bUxWbk5hMnY2c05LSWI4c0EzU2tnMXhiVHdTalNRVThZUWc5?=
 =?utf-8?B?cDl4N0crUkI1Zk9Ba0JiMXI3SUNCSEd1c3gwYWQ1WTJPY0tCVFpBcnhWUDVh?=
 =?utf-8?B?U1AyWE5IUmtyOTNoSGFpMFVIUGNvL21wWnlQaHNOckZtNjh6ZXV3SUplQU5w?=
 =?utf-8?B?eGJjQlliUnRQVitOV054bG8zZ3NZYk1LMnd2Z3Z3WTVhYitwTHFJdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098c0199-a022-4bd0-cf0f-08de8b6f4fed
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 19:38:53.3605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9dm5+RvlDGTucUaa2wdDwrphZgpqP5+VRyeGQdYHILcY7tPVJyYLj3XRCPbVjSk4Yc+9pGvbE+yrosL3DQuWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085
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


On 2026-03-26 08:36, Christian König wrote:
> On 3/26/26 13:21, Donet Tom wrote:
>> Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
>> KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
>> 4K pages, both values match (8KB), so allocation and reserved space
>> are consistent.
>>
>> However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
>> while the reserved trap area remains 8KB. This mismatch causes the
>> kernel to crash when running rocminfo or rccl unit tests.
>>
>> Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
>> BUG: Kernel NULL pointer dereference on read at 0x00000002
>> Faulting instruction address: 0xc0000000002c8a64
>> Oops: Kernel access of bad area, sig: 11 [#1]
>> LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
>> CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
>> 6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
>> Tainted: [E]=UNSIGNED_MODULE
>> Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
>> of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
>> NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
>> REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
>> MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
>> XER: 00000036
>> CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
>> IRQMASK: 1
>> GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
>> c00000013d814540
>> GPR04: 0000000000000002 c00000013d814550 0000000000000045
>> 0000000000000000
>> GPR08: c00000013444d000 c00000013d814538 c00000013d814538
>> 0000000084002268
>> GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
>> 0000000000020000
>> GPR16: 0000000000000000 0000000000000002 c00000015f653000
>> 0000000000000000
>> GPR20: c000000138662400 c00000013d814540 0000000000000000
>> c00000013d814500
>> GPR24: 0000000000000000 0000000000000002 c0000001e0957888
>> c0000001e0957878
>> GPR28: c00000013d814548 0000000000000000 c00000013d814540
>> c0000001e0957888
>> NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
>> LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
>> Call Trace:
>> 0xc0000001e0957890 (unreliable)
>> __mutex_lock.constprop.0+0x58/0xd00
>> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
>> kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
>> kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
>> kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
>> kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
>> kfd_ioctl+0x514/0x670 [amdgpu]
>> sys_ioctl+0x134/0x180
>> system_call_exception+0x114/0x300
>> system_call_vectored_common+0x15c/0x2ec
>>
>> This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 64 KB and
>> KFD_CWSR_TBA_TMA_SIZE to the AMD GPU page size. This means we reserve
>> 64 KB for the trap in the address space, but only allocate 8 KB within
>> it. With this approach, the allocation size never exceeds the reserved
>> area.
>>
>> cc: stable@vger.kernel.org
>> Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
>> Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h  | 4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index bb276c0ad06d..d5b7061556ba 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>>   #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
>>   #define AMDGPU_VA_RESERVED_SEQ64_START(adev)	(AMDGPU_VA_RESERVED_CSA_START(adev) \
>>   						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
>> -#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE		(1ULL << 16)
>>   #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>>   						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
>>   #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index e5b56412931b..035687a17d89 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -102,8 +102,8 @@
>>    * The first chunk is the TBA used for the CWSR ISA code. The second
>>    * chunk is used as TMA for user-mode trap handler setup in daisy-chain mode.
>>    */
>> -#define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
>> -#define KFD_CWSR_TMA_OFFSET (PAGE_SIZE + 2048)
>> +#define KFD_CWSR_TBA_TMA_SIZE (AMDGPU_GPU_PAGE_SIZE * 2)
>> +#define KFD_CWSR_TMA_OFFSET (AMDGPU_GPU_PAGE_SIZE + 2048)
>>   
>>   #define KFD_MAX_NUM_OF_QUEUES_PER_DEVICE		\
>>   	(KFD_MAX_NUM_OF_PROCESSES *			\
