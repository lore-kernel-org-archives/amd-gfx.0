Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA897FA1FDB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 18:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C04A10EEF5;
	Wed, 22 Apr 2026 18:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wJmHtalg";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC1910EEEE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 18:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gxe48pzzyds/0P8EH1LzOxHX3T60VYVjLGcFEV+2EK1HmUuGajIcELlsP5HcTty05Y2gL8qpWXnviBXqfiag3zMAqMGCp6SMQa9cXdwtmBaqxlk/tsSVq28qFU47W+2J982dzpukZt+Q4uo9P5qJ0MfLcbxR1yPpuvQesBhF7f8n0Es0/T+bArV+9Qg9UybMOMFtFWCrjAhm9Nj7RQLfcvcpvT/V6IoHncKbQcUlRP6JpF/F1HnZHZVvCXVyTNWBFuZgZST1qeiy447Odz6RI+nfvJgKaHSkE6s5zy0nvi7tKrbNSO7reXcEQEOmpnjup+xyBoJXyIkBBtFFEf5VQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PB7h8PHV9eAIj3DtsjYYhVqCyTcOZkM45Y2H5lc60eI=;
 b=qCiJOIGcHaC4hXfPFshNQvO6ti39iaVXhKAqjWLJ0GYk8kQyPAO+EV8tgazfr/F2ayyk22k9Pc/FoAo1+/vmz3BRnPeDGAOsIcNRabylFnW4sg8ukkfkNWiIZrLSawf9O8C4eYnsCv32qc2iMf+YMBqD3icLhm8/80NBhz/FgI6lNIbay6420rUBs41qcFBixBOJcb0y1T+AsukEmofvQgGLC8dnyKIlmaVuv+xpukZyNknRtejOxakU5Kth8Aef8UGakM0UDIAYJ58FjPjGT8PMSjj6HazyitdOQGLzBqPLoQfHZo0sswfldpJdN5g0yqNKRwnI5T7Y0SyMdpHTbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB7h8PHV9eAIj3DtsjYYhVqCyTcOZkM45Y2H5lc60eI=;
 b=wJmHtalgYocVVWcYfJGR/EYJK+m51N+XEu8xQcz1mUoFdcINtkPGQSCx952U68vNfhJ5BfyuDa1c+8cURy9+6JVk4wnx37bQUn7ECkGAeqXel4rmCRjLpIx/Zz4F5K7DfJDHZrtL1hlEcy0OxmXfyN6HDazqZmKYa6bb3bxSrow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 18:00:12 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 18:00:12 +0000
Content-Type: multipart/alternative;
 boundary="------------1JT8E06DYQX8S69000hPpREs"
Message-ID: <44967ec0-8014-4543-b2a9-70007ba2f2b3@amd.com>
Date: Wed, 22 Apr 2026 14:00:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm/amdgpu: per-PTE MTYPE override for NUMA
 locality
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, Kent.Russell@amd.com,
 Andrew.Martin@amd.com
References: <20260420133705.3721315-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260420133705.3721315-1-Philip.Yang@amd.com>
X-ClientProxiedBy: YT4PR01CA0245.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab22e94-8eb8-4e35-03bb-08dea098ffb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bGHpxOGpZyGDS9KWvd4wF0sEBjhpPLgd0TcU1aisF0UCJB9sY7WXMnlXDrC5X56lsPmkB32GWX62Qhv2j5SWQfn/7gej620+XqPBPjPTE+mc683qMnwMLV2ewMmuwZzUre8ziTPxvhfphnZGrAk0HIE1N8arTvbiPQD5G09/4OnzTKtL2vmq+ZU/AjV/hVLrdI/HzZg53d1st8HT/24TIwJ82Sng63+pUAefLiWVWWi0TmXWp0w5pGGGNT+SjTr2i83U3MbIn3sUQR4U+vuUFLi+9xYWJYntwqb/w/LMuRJ1Bk2X7Ahv/MFJi0yuEsWx01YhYyFdZeNOGVjoe+A68nIg2skFz+KMbDDix+70CeHj90cOjwAjxXn2gQ75EyFlgp9Hd+dCOgCIdhYx6yMZzF26qViI/eeI380KfmJUjVJoYKPBJfSAuaxkVfk5R7uwtoB1LexxtZaZEfQlbqgPxfaPxKvIFPKkw6s3oXqpEK4fVw6qjt/WJE/qg+aHFZacEk+gW2YbGqgx+YeAqeyvWFc+/VfsOSwzRLRiti24G0bXxssSgX3/16QMzVfVM+sC61Y5iM5zQ07GgR3SmXBNlNCDrHl68AS+aSCjicrC54DFB2+uf0HI7Ca7eHDbETy7ZyNyg5PzbJjs8HyFZvfxjVJminenJjElO3cu/LjuqggyDc61WKD7u/vNp/vbn5rHOJU0QOGYpg6bEn7nlPKnPDnYV8m4jdndku5yw8+kCK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmE0dUU3SkxYTnBQSTZ6dWxDajhQVGRrL0llUVgvc2ZBNXRwd1Vaemx5OVdk?=
 =?utf-8?B?ajRxMVZtRS9RMkxpS2VtSUg0dzFNZHYzV3kzbXdDdFQzeFpHK1ZXSEtNK3Rt?=
 =?utf-8?B?QlpseFNPOTZ6d3dINkIzdzRBNkM5MTVxdDJTNXNPQm1OTlkzYzJwNzdiMmF6?=
 =?utf-8?B?Vjl3dEdFd1NNUzFOeUZUcWd2WmdZQlJqdHVERG5uaW53S2E0azhLaE9hVVRM?=
 =?utf-8?B?OUR2N09HL0JPQ1BSR2VXdVQ5ZlFhalBHYi9XNmVJZ292a1FlaFEzSTB0Rjhs?=
 =?utf-8?B?TDZRdGpPVUIyZXdCUXlLTWV4S0tIb0MvaXp5Ti9mY284anBzUUVSTUlaMGZG?=
 =?utf-8?B?elQ0L2daVXFFYytrZk1KbEo5NFdmbG5rclozSVREdFpJZFArcjZ0bUJLaFl5?=
 =?utf-8?B?VzZOeEtteXBUSDN0d1cvaFlzZVloZkx3R2xWWmdidXBETE8wZjBHT0dVbU5L?=
 =?utf-8?B?UEJMVW9NK2hWVUZpMmkva3RSaVRtMFdXYW02eURDdndOcFBqRjlEblRheGc3?=
 =?utf-8?B?cUZnL2d2Sk9tem5ESVEvajF0KzRQbU5ncFNBblh4YW1RUFJMaFlva3Y4Zyt4?=
 =?utf-8?B?RmZqTWp4My91YmNSZVYxR1M5SmZqOGU4YS92SDZST0w5VzBaMFM5WnlaNlQx?=
 =?utf-8?B?OVhubUdONUVxRDhud2J6cmttTnZVdFpNeXNYNDVWdXlCdFIzUzRFd1NyL1dl?=
 =?utf-8?B?Vy9uT3grWHN6aEhBbldVeEUyVEhkcFlOTU9PUVA5akpWVVY4NXBJRWdQZ29z?=
 =?utf-8?B?SVlqb1MreVVleXJKeWZBeXhSQTF3NUdKdURpbHkzZ2x2RWlNM2w5c1IyUDRv?=
 =?utf-8?B?RVByZUNWRXhjMEpmRWlUOGFrYnZJTTFtdjk4ekl5d2JuSWphWmIrMTAwZDEw?=
 =?utf-8?B?SmNnSTRHS09tVE1KM0Z5S0JtaHpnZEVwQjV1Q1ZxbUljZHRRSkp4NCtQaEVO?=
 =?utf-8?B?Tk16V0xVRHpPWGgrZFlYT05jM3RuMmsvbDdNbkhIeHVROVFYRVU4Mzd6bDlU?=
 =?utf-8?B?dHhsK3c2THdPb0szTDB3dFlRMmZqM3M5UGcrellxaVdEem1pN3BBNUtLNzlT?=
 =?utf-8?B?c0pwYkZyWTU3VWkxRjRzMzlRTDBWRHNtNXhDZCtMMmxVanJZdThrMUJKMlN6?=
 =?utf-8?B?TENocGErNCt6WklLRzlFTE5vM09YMHU0Wmo4ZENxRFBzNzU4cU9qanN0Rmhi?=
 =?utf-8?B?cTNLcG5IQmxTZDRRakZTY2hhTlo0QmtZTWlRSDVTMlUxNnYrWmx5MFNRUHhV?=
 =?utf-8?B?Vm81TEdHRDh0aEFIZTllN09ZNHJlVXd1Qk9KRnZtak9UbThXM09yOGRTcG02?=
 =?utf-8?B?L3FKR29iMy96cEVsZkdIZGdwK1hKTVQ1azhXaTlWU1BJZms2dWQ5YVhjaW8w?=
 =?utf-8?B?TnV6UFA1OFE0MFZrWXBYSUJsdjh3YUtiZ3hONytRRXFlUmNMZVZQbW0xNUtR?=
 =?utf-8?B?WkVtVWNqS0pQRGVGZXoxemN1V3JKWkk1WWh4VXlMUjRkQ1hYTnNFdi9BdW9t?=
 =?utf-8?B?UVp0NFJaR1FrMzh4WHlEVFMwTDM5VGdTVzViZXg3OWlCWm51dGk1VWg3L09Z?=
 =?utf-8?B?MUJkYlpLOTJJbytRelNLRTNoZDJLbDk3emFIRWZFbjRXZ3pDNjJiQ2d0ZHNB?=
 =?utf-8?B?SklnUzlCOGZoRkRFcEZwT3JRRzNkYVVpZkU1MGlBVVBpM1BuOHgzei94NWox?=
 =?utf-8?B?dGluOGxMM0ZsZXBWWnVNMTQyQXpac1B5NlpGV2NFaTdVRUtZVW5LRVcyODVE?=
 =?utf-8?B?aE0zWXBEYktHQkdkWk9wb3M0UVJYR0wzUXFCMFVxaUVvR3hqVGpFK0dNQlVp?=
 =?utf-8?B?S1o0TFZTSmtBUk5HZy9DclBhQ0RQL2twMGdGUzgvcXI1aUVrcnJpanlPWUhr?=
 =?utf-8?B?N0JuR3BJWlFHekVweDBJT1RhMlVldGp0Zmp2SjhCUWdOZDFBT0twWFVzUmpY?=
 =?utf-8?B?OU1Zdkd0NnB1WTVtOFFScyt5VVo4VDZHL2U5YXM4cjY5RUovSjc4eTNxTE5M?=
 =?utf-8?B?Z3R0TENjY1dHeFhXY2UzaHBOU1owK2wzUUdRZ0o3SGhsYU45dTd3T3NzOWtZ?=
 =?utf-8?B?cWlxSW9JNVppYnE4UFNaNGpqcG45S2Q5RzI1YUgwcW5PdVJqbEVsR1ZEdUl5?=
 =?utf-8?B?QWJCTlhMM1F6RmFjRHIrVHZaRDhaYjZxbmVQVlZUVVZPMUdSZmkyTTFQWUla?=
 =?utf-8?B?TDZYSnJXK2pjaFh6UWNIQ1BBUkt6eG45NlBtYjA4S2dtWVMxQmJ6YXFhL3RJ?=
 =?utf-8?B?QmZ0RWpYQjVaYnJVRWlNSVhJUlU0dnFMUkJJbHdJdjFJUGMyQ25pT25keW1o?=
 =?utf-8?Q?0Q5ZOFQY9/fAkzUI8v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab22e94-8eb8-4e35-03bb-08dea098ffb8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 18:00:12.2886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsX0fTPv/NQobXyBwaMiH0q68lpmC5rFVTm9mObu2WuB/Q+pQExNXyr9Oa9VPETp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506
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

--------------1JT8E06DYQX8S69000hPpREs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

ping...

On 2026-04-20 09:37, Philip Yang wrote:
> This series refactors the NUMA-aware MTYPE override for VM page table
> entries on GFX 9.4.3 APUs (MI300A). Previously, the override was applied
> once per contiguous range in the centralized amdgpu_vm_pte_update_flags(),
> which missed scattered pages (pages_addr path) that could span multiple
> NUMA nodes.
>
> Patch 1 moves amdgpu_device_check_iommu_direct_map() earlier in device
> init so that ram_is_direct_mapped is available when gmc_funcs are
> configured during IP early init.
>
> Patch 2 moves the MTYPE override into the individual CPU and SDMA update
> backends at per-PTE granularity, enabling correct NUMA-local MTYPE
> selection for scattered pages. It also hoists the eligibility checks
> (APU type, IP version, direct-mapped RAM, multi-NUMA) from runtime to
> init time via a new gmc.override_pte flag, avoiding repeated checks on
> every PTE update.
>
> Philip Yang (2):
>    drm/amdgpu: Move amdgpu_device_check_iommu_direct_map() earlier
>    drm/amdgpu: move VM PTE MTYPE override to per-PTE granularity
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  5 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  6 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  | 11 ++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  9 ------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 11 ++++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 35 +++++++++------------
>   8 files changed, 44 insertions(+), 37 deletions(-)
>

--------------1JT8E06DYQX8S69000hPpREs
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    ping...<br>
    <br>
    <div class="moz-cite-prefix">On 2026-04-20 09:37, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260420133705.3721315-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">This series refactors the NUMA-aware MTYPE override for VM page table
entries on GFX 9.4.3 APUs (MI300A). Previously, the override was applied
once per contiguous range in the centralized amdgpu_vm_pte_update_flags(),
which missed scattered pages (pages_addr path) that could span multiple
NUMA nodes.

Patch 1 moves amdgpu_device_check_iommu_direct_map() earlier in device
init so that ram_is_direct_mapped is available when gmc_funcs are
configured during IP early init.

Patch 2 moves the MTYPE override into the individual CPU and SDMA update
backends at per-PTE granularity, enabling correct NUMA-local MTYPE
selection for scattered pages. It also hoists the eligibility checks
(APU type, IP version, direct-mapped RAM, multi-NUMA) from runtime to
init time via a new gmc.override_pte flag, avoiding repeated checks on
every PTE update.

Philip Yang (2):
  drm/amdgpu: Move amdgpu_device_check_iommu_direct_map() earlier
  drm/amdgpu: move VM PTE MTYPE override to per-PTE granularity

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  5 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  6 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  | 11 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  9 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 11 ++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 35 +++++++++------------
 8 files changed, 44 insertions(+), 37 deletions(-)

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------1JT8E06DYQX8S69000hPpREs--
