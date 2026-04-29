Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D3AFF8875
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 12:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4152010E2D1;
	Wed, 29 Apr 2026 12:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gM6PG1+b";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012049.outbound.protection.outlook.com
 [40.107.200.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C047210E2D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 12:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyWU9E2lo0E2iIeXBDtZkxDpQEV5TT/1L3yV7x25W6yKMqbtFzWG4zIWzBduSm13s8RycIstrUslEBlFnxoEWrUzwVRDSLlKygxx24Dqjj5XCe+8i6Qosk5/0aduNr43UJtX+mVj4SgLnaQ8e/bFVfd4KTdycheVXvReGwp7Jnu0tyA1M4To3AsbekUO0eNQnnHb3O64gG1/8IX5eRdeF7YVzG83KRnwhpIP7qZ1PgmS5XYdmZQ03B3Ze+zFrxi2yKmKMDgL7odJ2ZgkfRv0K3ozlS96otI9y6aqZNZLsW4nCtWeM8wEc5LM7cfLzfjKBK6HjTUSPKjm4PIOVXfuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+869TNQIhDQmd0pAbOKR0B8EvJwbCKDrQrZhqzrg/NA=;
 b=cqcrBgBSoeXUSw+ZkbS+1fkklomFL3oi0nVbD/WBe5WN2qCZUB2Hsa4PGmdxOlVL79OqlLSSGtBk4G/6Kzdtv5H/ZtMudlPV4klx6Sdsxn71p6Hs2f7bwkQuThD1NIFkiXIpYkKoSeTC8GQDcKwzdWbliokLbP3YcLsMYrXkYhhw3aADIeyA8jFxnFG3R5jEbAGRs2QsfzNeKCRO5/Si17M8Nd8RotQcIXsK5chMsi38dJXr1VQNYizjs1LyHlUIbnlu0WOUfXp2ePF4XQ8bcYfYfOpfIhYqgc3PH0buO/YMFTE4Mr5M75YSDBL5J4cQwrfNJ5ertaPaUe9Ur84bCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+869TNQIhDQmd0pAbOKR0B8EvJwbCKDrQrZhqzrg/NA=;
 b=gM6PG1+bvmZZ+CGZOXA60dk1MRCsDJXQQbnnViqC7Nh8XecQRbdVmU9zlGKgqo9OqwH3I3VxY7LdOkdwTU9LaX2uxDvy1m9m1gvIlkBRqVAqVGcMRhUDZv0yjodW74wrLnQ1aEEHkU2aPJ2UkEyEidQYqRyZzV6zHEnDq30Hl1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 12:10:44 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516%4]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 12:10:44 +0000
Message-ID: <48c79d55-b84a-4380-a9cd-718e4e1bb3c9@amd.com>
Date: Wed, 29 Apr 2026 08:10:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] drm/amdgpu: add amdgpu_bo_alloc_gtt_mem and
 amdgpu_bo_free_gtt_mem
To: "Ma, Bing" <Bing.Ma@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Francis, David" <David.Francis@amd.com>
Cc: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Liu, Jenny (Jing)" <Jenny-Jing.Liu@amd.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-6-James.Zhu@amd.com>
 <BY5PR12MB4179BA8A303F3D94301DF809FD372@BY5PR12MB4179.namprd12.prod.outlook.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <BY5PR12MB4179BA8A303F3D94301DF809FD372@BY5PR12MB4179.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::30) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: ab426715-7bb0-40bc-9fee-08dea5e856e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 3rusC9GiXBNSgqI7EgTLlQyUtemgVjGWE5Hn/xf89Aw+XsGTcIeXfYzX/eaBUdCg+A0AmceYC81m9kFMYoOJtyMOHXXCNP5tqmrdE+GhpPqzWNL+iVPqZIyB8yJ5til/WD5Igjlqb4/7Wha1LlUe49i/oDRxuwLwLD1pRAzRQgYVdittpjqMlKIuBTLD214D96HDhgBleTq6AYCXELkiECx3XBX5SOPER/HR1BABFKcCG3sg33W3g4dSf+dUH7JwBHoPbVe8IgDj/gN1eRNFh7DMwboS1KEYtwByrIo9imHqKqkOIHGXc1bRu9y/OhbtMAOSoTVd1Ce5DlgECzuGW4FXieS80ssrKvil/pSCEwPIX3XyjsvzqdWWT2J0+tsQZk5T7CM2YHtIj9nE+vG/p6BMlzH2viYq/OmiFZ9WbOg+DDU+b69QtQQtfGOgezq44bVEKAn9j50eC0b8oFuGoJxbqp7ap/2y+rZ+yMlAVrDte3kPX4CFgHBkzfb91SeEd4ZAM1MHHDuuquvkasghiz+MiMUty9mKksVZHEFpJVkypjkpJnssi5mj8jKTIegH//ciIZ0j3L14Ac6wc0bI9wHSCStvFnU/psISfQvx6jmB0ZIHVFDgGiRudodAACbh5TmF6IzdZYZSeAMnBvaE4ANnZBAa2tVRS7MuRYT67tYx1N3Yi366zHAuhTx+OQLSadPAqfrDjDUuspLrbm+cG7OMgQX5ijnXCQhqQs+WQ8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXc5WmxWN0xZZXhqZW4rU0RSdEVicjhDYVRoWUdjb3M5NU1LelZJT3BPSmNL?=
 =?utf-8?B?ZnZwUzZiUnY3aXFsNytJL25DMndhU1ErQXg1MTRQa2JRT0FxTTFTamhiOG53?=
 =?utf-8?B?QTA3UWEyT2w4c0xmVFhVd3FlNkU2eENWWHpEeXVHVDN5dU54OGs2TmVBM1B4?=
 =?utf-8?B?V1VJNUJjekgweVdZcTh0bWlBMEc2UTh6NWo3MVNwNm10NG9zeUkrTkFXWVVw?=
 =?utf-8?B?RlJuMDM0ckNUZG1BSzc0cnRiRGxFcUpGMUlkZ0V4a1JLL0g3d295cnhFdnRE?=
 =?utf-8?B?UVNtTWRGWVA1UkhMc2RQUWlvcE9OaDAyUnNHRjA5aGJoc1k0ZENrWlE5NDNU?=
 =?utf-8?B?R2sreHR5VWFPU3BzbGUxL1dvSlFYblord2hhTGl2eVhsNG5IUXladll0MTVQ?=
 =?utf-8?B?Qm5IYitlenlNU3JOZDc4N21kWHZNZ1gwWndMai9ObndON1E3WFBUZGZyanFY?=
 =?utf-8?B?d3ArOUxneDhaOXpOaCtNb2haaE15aTI3SE5OYjRraHBCVDk5NlNPSXV1MjZ1?=
 =?utf-8?B?OVhTV0VFdnBDek9lRjlEME50NGpIZ1FTd2FDWHRYSnZFL0tubnhmenJMcWs1?=
 =?utf-8?B?Rml4ZjVXVWQ0TjQzNFpYS0huMTNlU3ZwM1g2S2FIaW56bHFxcTVaWTc2SWJj?=
 =?utf-8?B?NnFSM0xSaWRRMC9TVGJuY2x6UEdUVjJTWFRPMFJ6WllpYzBqeGVORmhId3JG?=
 =?utf-8?B?Wm82b2RnNjd0bG1GYTNRRGJZdEliWS9tVlVwNDZuMHhPdDVtbEpabmxPWEJn?=
 =?utf-8?B?NGZvR3gxTEJrc0l5QzdMTnFvamNBVEtwNVNvTS8zMStmSnkyNzczenFkeDhY?=
 =?utf-8?B?ZWlmSWM3Rnp0c0xXUlJKNUhHc1FTQkcyUVczNGIrRVBpKzA5UVJqaVlQOFdX?=
 =?utf-8?B?OXFZaXR6N1JmRnZETVNvZzlFTEFPZjJKdWluYXduZE81Zm4rYXdoaHZFVHhx?=
 =?utf-8?B?d0oxZGpBOUxrVFlvaUNEVFlSY3ZKT01jOFlxamFIZldkSjJUenBZUmFWTlZy?=
 =?utf-8?B?ZVFyTWpYZVlVcU9YMlNRU0kvaGluQWlpRzRzZ2twbVUya3FUOWlXNTBKb0Jh?=
 =?utf-8?B?eFFSK1pSR2I2Z011SnlMdU04YjJTV3dGV2NQUWhTTGU0alNJd2YrOW40bmRo?=
 =?utf-8?B?Q3FtYlIzSkZONmtFNG04YmNEZVRkNWFFcW9rNTgzOCtldFRGMmhGMS90L2Vq?=
 =?utf-8?B?VkYrWFZNN3ZqTDhIZnY1Y3ZrRHNGSVl5VTFSVWNQTk1HWUMyUzNYak9qbWdD?=
 =?utf-8?B?eGt0em05TCtOSnZDUXo3VHAwYlZ2dUVBd3RBVk1aT0ZDNUpldVIrclpCZ2Rh?=
 =?utf-8?B?Q2gyMjRCSlZsWEt1R1U5SlF0cnpvQlhqN3ZMRm9XcG5TN0g4QnZHTkZNWXpw?=
 =?utf-8?B?QjJzSTJYbHBNbE9ZZlRrWG43aFdFRTF0aEVHb21EUms2b0JEbXhzRVpxcDV1?=
 =?utf-8?B?bVB1RVh4NnM5VVdCeEFiSmpRYzA0ampLU3VlL2Z4bEhjQTV5L002UXB4UDhP?=
 =?utf-8?B?bGY5aU8wejFZTFY0Q0REWE8yVit0U3c0WXpuZkk2bXNzelBwMUZRdHV2akUy?=
 =?utf-8?B?ZFVBeXJWNDFpTUYzaXFIYUdHT0hOeFJ5QlRKMjVWMEl3NXUvM25ZeGRFYnFD?=
 =?utf-8?B?T0dyYzhDM0tybUZxU0FkZm1UVm9DdkRXZ0lKY05Sem14N3MxbE5NTlRIK2sw?=
 =?utf-8?B?L1pvQkp0TEZ6Zy9ueFBZMW1RdkpjVXM5UUt0RmJqaDJGV0xsV0psWm5tUVhZ?=
 =?utf-8?B?cG1TY3h3QVVLTXc4ZmZMUk5xWFE4U2FzZFlOeHltVlRlZlZ1MnlyK29XQ3p2?=
 =?utf-8?B?UTdPVEhVcnRXSTlXcjNwb1RHUkdGM2paS3RXTi80Vy90eU00d0RHNGhYQmdx?=
 =?utf-8?B?MWZqcXBQVng5TU9WYUJBeU1tN0cxZ2FCQytCVzdBZ0piVlBxU0ltOHNSUmgw?=
 =?utf-8?B?Y3o5eTk4ekxxb1Q1c2w4U0pzcGFISTdvMmhZa3U5bk1jRHIwRWtlS0FuUEhE?=
 =?utf-8?B?bE8yMDZiTkhoR00rWU9ZT0NhckxSTTZmY1MvNHR0ZEVtVVpBeDRaVGVYbThj?=
 =?utf-8?B?WUpNMDBiQWhvSmFRNklXNXFXenhsc0xoZDhqU2NsbHBRWUhrZDFRRFc1RzB2?=
 =?utf-8?B?M3lWMkN6eENPZ05WWGNDaUxLdVlYRURQZ00xVnEwMjMrZWtxOHN3dStqRXZM?=
 =?utf-8?B?THY5MkU3aFJBa0M3TDFoek1Mb0ZDNGVEWmVIUTcxdDF2dnQzR1NkRTJUb0wz?=
 =?utf-8?B?aTZMQ1BNUkRwcGZmMTZkNDBNMWlvS3hUR1FBNmtoOWpxMzVGMzY0Vlh1Q3lZ?=
 =?utf-8?Q?mpGK4hh75+7ca/r+NK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab426715-7bb0-40bc-9fee-08dea5e856e4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 12:10:44.6666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eBftyHX4A4DUDjXe6B1fjdQEfRDN8sIzOY6oB2j5+96vY1d0Cr/hmKpXoSrynON
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767
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


On 2026-04-27 23:14, Ma, Bing wrote:
> AMD General
>
> Reviewed-by: Bing Ma <Bing.Ma@amd.com>
>
> I didn't realize that these two functions are only used by SPM, no other feature uses GTT memory?
[JZ] only KFD features use them currently. for unified project, we plan 
to migrate them to amdgpu base driver.
>
> -----Original Message-----
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Tuesday, March 24, 2026 2:20 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Bing <Bing.Ma@amd.com>; Francis, David <David.Francis@amd.com>
> Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.Liu@amd.com>; Zhu, James <James.Zhu@amd.com>
> Subject: [PATCH v2 05/17] drm/amdgpu: add amdgpu_bo_alloc_gtt_mem and amdgpu_bo_free_gtt_mem
>
> two helper functions for allocating and freeing kernel-internal GTT (Graphics Translation Table) buffer objects, intended for use by the SPM ring buffer allocation path.
>
> amdgpu_bo_alloc_gtt_mem():
>    Allocates a TTM kernel BO of the requested size in GTT domain,
>    PAGE_SIZE aligned. The bo_ptr_size is set to sizeof(struct amdgpu_bo).
>    After creation the BO is reserved, pinned to GTT, GART-bound via
>    amdgpu_ttm_alloc_gart(), and kernel-mapped via amdgpu_bo_kmap().
>    On success, the caller receives the opaque BO handle (*mem_obj),
>    the GPU virtual address (*gpu_addr), and the kernel virtual address
>    (*cpu_ptr). All intermediate steps are rolled back cleanly on any
>    failure via a chained goto error path.
>
>    Two optional flags control BO creation:
>    - mqd_gfx9=true: sets AMDGPU_GEM_CREATE_CP_MQD_GFX9, required for
>      GFX9 MQD-compatible allocations.
>    - is_uswc_mode=true: sets AMDGPU_GEM_CREATE_CPU_GTT_USWC, enabling
>      uncached speculative write-combining CPU access to the GTT buffer.
>
> amdgpu_bo_free_gtt_mem():
>    Reverses the allocation by reserving the BO, unmapping (kunmap),
>    unpinning, unreserving, and dropping the last reference (unref).
>    Handles NULL gracefully and logs an error if reservation fails.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 97 ++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 -
>   3 files changed, 101 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 1fb956400696..993171979896 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1696,4 +1696,101 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>
>          return size;
>   }
> +
> +int amdgpu_bo_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
> +                               void **mem_obj, uint64_t *gpu_addr,
> +                               void **cpu_ptr, bool mqd_gfx9, bool is_uswc_mode) {
> +       struct amdgpu_bo *bo = NULL;
> +       struct amdgpu_bo_param bp;
> +       int r;
> +       void *cpu_ptr_tmp = NULL;
> +
> +       memset(&bp, 0, sizeof(bp));
> +       bp.size = size;
> +       bp.byte_align = PAGE_SIZE;
> +       bp.domain = AMDGPU_GEM_DOMAIN_GTT;
> +       if (is_uswc_mode)
> +               bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> +       else
> +               bp.flags = 0;
> +       bp.type = ttm_bo_type_kernel;
> +       bp.resv = NULL;
> +       bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +
> +       if (mqd_gfx9)
> +               bp.flags |= AMDGPU_GEM_CREATE_CP_MQD_GFX9;
> +
> +       r = amdgpu_bo_create(adev, &bp, &bo);
> +       if (r) {
> +               dev_err(adev->dev,
> +                       "failed to allocate BO for amdgpu (%d)\n", r);
> +               return r;
> +       }
> +
> +       /* map the buffer */
> +       r = amdgpu_bo_reserve(bo, true);
> +       if (r) {
> +               dev_err(adev->dev, "(%d) failed to reserve bo for amdgpu\n", r);
> +               goto allocate_mem_reserve_bo_failed;
> +       }
> +
> +       r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> +       if (r) {
> +               dev_err(adev->dev, "(%d) failed to pin bo for amdgpu\n", r);
> +               goto allocate_mem_pin_bo_failed;
> +       }
> +
> +       r = amdgpu_ttm_alloc_gart(&bo->tbo);
> +       if (r) {
> +               dev_err(adev->dev, "%p bind failed\n", bo);
> +               goto allocate_mem_kmap_bo_failed;
> +       }
> +
> +       r = amdgpu_bo_kmap(bo, &cpu_ptr_tmp);
> +       if (r) {
> +               dev_err(adev->dev,
> +                       "(%d) failed to map bo to GTT for amdgpu", r);
> +               goto allocate_mem_kmap_bo_failed;
> +       }
> +
> +       *mem_obj = bo;
> +       *gpu_addr = amdgpu_bo_gpu_offset(bo);
> +       *cpu_ptr = cpu_ptr_tmp;
> +
> +       amdgpu_bo_unreserve(bo);
> +
> +       return 0;
> +
> +allocate_mem_kmap_bo_failed:
> +       amdgpu_bo_unpin(bo);
> +allocate_mem_pin_bo_failed:
> +       amdgpu_bo_unreserve(bo);
> +allocate_mem_reserve_bo_failed:
> +       amdgpu_bo_unref(&bo);
> +
> +       return r;
> +}
> +
> +void amdgpu_bo_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
> +{
> +       struct amdgpu_bo **bo = (struct amdgpu_bo **) mem_obj;
> +       int r;
> +
> +       if (!bo || !*bo)
> +               return;
> +
> +       r = amdgpu_bo_reserve(*bo, true);
> +       if (r) {
> +               dev_err(adev->dev,
> +                       "(%d) failed to reserve bo to free", r);
> +               return;
> +       }
> +
> +       amdgpu_bo_kunmap(*bo);
> +       amdgpu_bo_unpin(*bo);
> +       amdgpu_bo_unreserve(*bo);
> +       amdgpu_bo_unref(bo);
> +}
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 912c9afaf9e1..0102d43b2edc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -353,5 +353,8 @@ void amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
>
>   bool amdgpu_bo_support_uswc(u64 bo_flags);
>
> -
> +int amdgpu_bo_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
> +                               void **mem_obj, uint64_t *gpu_addr,
> +                               void **cpu_ptr, bool mqd_gfx9, bool is_uswc_mode); void
> +amdgpu_bo_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 1a3a7229de56..7b88693eb6f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -720,5 +720,4 @@ void amdgpu_vm_print_task_info(struct amdgpu_device *adev,
>                  list_for_each_entry(mapping, &(bo_va)->valids, list)  #define amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) \
>                  list_for_each_entry(mapping, &(bo_va)->invalids, list)
> -
>   #endif
> --
> 2.34.1
>
