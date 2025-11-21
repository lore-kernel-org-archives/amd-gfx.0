Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CB3CFA476
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 05:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7446E10E7E7;
	Fri, 21 Nov 2025 05:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lzoyo7WU";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C343D10E110
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 05:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzdZ9AJVM3f+QGrMuSzSiVGtrgO8cKHxCYpaZjJ/xmTAbQ/ObiZuCtzF5mD70y+ySUT2OxFdBqNnbTAMkXXoZF93XexaqAXHxdMSABN7GvERvuYpFF7lGGZMedcSqvGMStgQqgMe1+liSUSGEFcGqWEwyp2k+5IRM9PXP7QCUWoz8JjE58R97aRkN1+PzjQ719FZhBeuEDRtnIqW5Qk9z93xAZ3Ej53I2B0+YtiBKAlF2Yf2gXgNRkNBnqjWRR/CD//ZvmIsJZtzXAF/mAtsRFJ2L7RfxCwMKruon7pKMjmT/mtkdiPpPqI7d1GiM7qFmg6WmkPZZNf6bVoxaPRWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLKiwOwlPwa+iZ5oiFahEUPXIAyUxUgeBuy+N/JAChw=;
 b=DsiSfK43C8tWMkVp0sdl9Wm2cDVrGOTmDjsesRpBbBS2fDxnE6hdN1DF97+jtbW+QW34/Hoa+sPQmIF9n0glH63C2B8yXW3LhfZDtFM9UmAFdSrfV83wJQQ1n3xB/tJ/s/2xpPcvG/4PBo19+G83xxb7Pbsk1Gg5rzoC42Z5SIEqg0sZX9i9mcpgPAoYtmK1HgO6ae8rISD0dYTUHHPw7O12ixyi+VwCTbe0+y/Y0PQSxKNzTbOBj2YHok0QvubM525rKjxECA4oufdFARIeZZvkEGYRNOO/r1/LkH2lgBh7demycTk5vbzRD68CynZNxKAppa3G31lsKxbtk7gI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLKiwOwlPwa+iZ5oiFahEUPXIAyUxUgeBuy+N/JAChw=;
 b=Lzoyo7WUf357qYOER9WdJ0RJ5uehrS9mdMaxFAboDFqDFRlqojy63bujCVc3LkqJXufxJoqdBmxp513teUTej2+f0/GinjjNoFdL+uEVZ8IZYxCKaIC3TjyT0YnO8TcGg/Cv6QsmojyJEqQwnfmtIOeC+87ccSMXtnK8XLA/17Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 05:54:50 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 05:54:50 +0000
Message-ID: <2e6b320e-c5b8-45c3-bcb1-597942c72f87@amd.com>
Date: Fri, 21 Nov 2025 11:24:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amd/pm: adjust the visibility of pp_table sysfs
 node
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com
References: <20251121025358.3060551-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251121025358.3060551-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: f5aa2acc-fedb-474c-c9d5-08de28c27b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1BPdjBlUEJvVTlVSWRGWHo4UVY3aGJ1ZHVIZWZQYjlZTkxDUlo3ZkpZK2xj?=
 =?utf-8?B?NDlUODZWU3paZWxmamFRcXhQQ2JKRnBVOWNtZFdxamd5UFA4SUtoNFJ2K2Nt?=
 =?utf-8?B?REdMMlQ3ZDRBcEZpT2JscUEwaTErelREczBCRGdudWZXU1Rsd250dmNnbzFV?=
 =?utf-8?B?REZ6cTVCR2VzUUt1WWthZWJlV1owNnhPb000a3hBRU9JVW1nY2k0a3ZmRkFh?=
 =?utf-8?B?NVRvTmlES2U0SGs2cnBnK2lOdEh5ZTVsVkM1dUR4VEtROFlQeEliVzVxYlhJ?=
 =?utf-8?B?K3Y5ZmtwNlIycVRtdUxLcGY0U0NaTEhOWUhQYkg0QXovM29ieUV5OFdUU21w?=
 =?utf-8?B?cTBab3lsUC96WVRjdmtzcERUamgxOXdlM0dNUHVpVkZkL29jODgvbUVLdFRE?=
 =?utf-8?B?aWpvYjMvbTRSSDRqV2wyUFJyL0V3M2ZsSW1jRnZmWHFSUTkzVkVKbWRrb3pt?=
 =?utf-8?B?WmdML3hCR01TTWlKSTlYRkFsWSs4REtEelJXR01XVElKODRKSGtLUVh2OWow?=
 =?utf-8?B?OXZYZFBmQVJhS2tzN2FzUHYyT3Z4Nnd4aE96aE1xMnNBSi80VkdwaWhlUDlZ?=
 =?utf-8?B?Nks1a2FORzZBNkd6R2JMdXN5enFHalZ1cklIeW4wZXhrWU0xZGVJUy9UdHli?=
 =?utf-8?B?MmxmWmxtc2wrcW93R1pidDhxVHRkdmVMVGIxdDBERm5rOC90OTN5eEg2NVF4?=
 =?utf-8?B?eCtpaVFjbHFmRk9BcXpzNGd3Y29idmkrY0ZTR0ZFZmg5ak12bDF2cHgyQlYv?=
 =?utf-8?B?WlBqWk40ZTU3dGhiTk5XWlBBY0pnMW1Zd09jU2R5YTJ5ZnhIYUNLVjBndDlY?=
 =?utf-8?B?R2tPN2xOWE1hcG1qeENLMlhnT0gycDEvNzRtWUcxbVRMbEx5VER1ODNrN3p3?=
 =?utf-8?B?anowVXRhL2tiTXF4eXVoNkFNTDJIM250alY1MU40VUVScEJMR0Yvb0tiWFow?=
 =?utf-8?B?QVp5NVIxRkJWSVVLVENPVzZTZEV5Z3p2emJUVStwWVdvOXUxVTM2SmhFU0FD?=
 =?utf-8?B?aXBmRkZ0alBqOVBxRUpwdElTOUw2OUh4VVNUVDRWanF3ZTlCdnYvS0ZEUktv?=
 =?utf-8?B?WmVsbnAyMTl5clltazNhaFQ4QWxMaVRFYlVYdFh4TFhZSFR2dWtoRGRDdDFI?=
 =?utf-8?B?M3ZZdkNMSm9SelhCdXdZQUFTK2d2ZUxMZEF1bm9Xb0kwNHdjbk1ITFFwOUtL?=
 =?utf-8?B?YTdUU2FRUjRVL1ZmQWxxOXJIeVhtQU5TeFJKdDRBUkkxU0hSY1dSdWlaZVFk?=
 =?utf-8?B?YmkzY2lZMXZscm1Sdi94bXRSZXM5V1p1Q1BDZzY4NXhrUkZ6ZEFXTXlWSHBK?=
 =?utf-8?B?alJmR2d3WGpoZk4rdHFXa0FNQVk2di96MnRKa09WMm9tZnk2dmpSOW1MeXpp?=
 =?utf-8?B?ZkFoTWtRamtnUW1FVXphVHhtM2NIUm0xcVJaN2lqZStzUVYzVU0yWWdVY3Ex?=
 =?utf-8?B?M2tibER5SzBNMGczRzF0MEJRN1ZJSGVNZ3JlQkk3ekpkdklYQnFLWGVHb1Yv?=
 =?utf-8?B?bHVQZGZUcVhTSE9LRzRHVW1iVFgrRWlHdlQ1aDRSV2IweHExalNvcmlHaElZ?=
 =?utf-8?B?K0hSbWpwYkJLQlk3TVB4RkJ0N3VKWEdsdldHbWRrU1NyRk1qUXdwZ2pFRWtR?=
 =?utf-8?B?RGxmTFAvc0xPV0c3WmlLU1dpaHJDbTMzQ0VCbjhhbmdDS2llY2Q1UUNWYVFW?=
 =?utf-8?B?RkpoR3JuQTluWUZ3eWxQSG1Jak4wcWxxSUQxVHhMSlROdWNQdTV0c1ExVmtJ?=
 =?utf-8?B?OW00L3piSk9meEErbk9HeG9UbnhPOTJqbUhnYXJXVWJyQXBxQzhPTWlLRUgy?=
 =?utf-8?B?NTloQWRvbzFvOWE0OWI5M1l5QnNUWUU0QWlnTTJselZLOUZqZEZSV242dGt4?=
 =?utf-8?B?aXpqOVBHQytWZ3RhUFJ0KzZzYWp0OVk1R21hUVBTSGhCT0tJd0FPYi9Kc0Ur?=
 =?utf-8?Q?zT+xOk2aIE5atgVVtZSnIHGNoZu4HdpI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDcrOUEvdkV4ZjlnUkdpWXc4ejdvSVJYRVloZ0VYaXJnaTUxTWgvOFoweWJz?=
 =?utf-8?B?MEhaT3UrQVl4RmREZGE2aXB3Uml2ak0xRU8xK3ozR1NwbVVZeWEwckdwSERz?=
 =?utf-8?B?TGFJUVI0N01RWDJjTUpnT0pXRHZTNlpYY0RvaFJjVnFjOEVQYnl2S0NXYVdR?=
 =?utf-8?B?OEh6a1hwa2d4RWpkUXZVL2MzSndIaXJWVHFGMWcrT3pnaVVSNmIxMEJRZW9v?=
 =?utf-8?B?VGlKWTZVcG1YSlBwTEF1TTBTczNkVkxLamk4ZUlodVAxSXR0Sm9WcklWK3I5?=
 =?utf-8?B?djZLOTUvMVZIbDdWeThVNzlCbEUvdHVQblhPb0RVNE1PZWZsNnp2cTk1V05n?=
 =?utf-8?B?N1ZndG9IeXlFQUl0akZSdXNNTFcvTHV3WFlveXcwWkpVeFRsc3JNdm82cUp3?=
 =?utf-8?B?MUtCM2JrckpvU3ovZVBjeGMrSHRUUDUrZy9QSmk1ZEtFQ0JaL3NFR1BwRkpW?=
 =?utf-8?B?VG1jWHM2UEUyTFkrU1ZEYWtIT1RER0F6ZVdFL0QrK2tBQlM4NmVCZy9SMkpp?=
 =?utf-8?B?cndNa3JWdUVPYmR0M1NrcGxKZjVSQzZrZXkyYWNpWXQyclBHY2pjRDl3QS92?=
 =?utf-8?B?M0RyUXdHSDhnMUJxaU5jU3JTUXhIS25zZm9xMDkzYlU4T1ZsOXRCekF5UXJK?=
 =?utf-8?B?eGlkQ2VvZmhESGFxWDRLSkxaU1Bvak9pdVR5L1N3ejVqZ1FYV2d2ZkZWRjMy?=
 =?utf-8?B?NlJEeVBQOFNONGZmczR5bnR3c0pvaFF0SS93SzNubGRyUjkrYXpwcFJFM3R3?=
 =?utf-8?B?U01Ya3FwQ2tOS0xQOUU3UmpwUk1rQjYxbkJUUEt5bjl5OWJVTDBWSHN6NGdl?=
 =?utf-8?B?dGZzRnNDOWFmNnJ1dW52YWRJUXY4VE51SmxwVWJhL0hCaGNVRjRYVXpEMHBL?=
 =?utf-8?B?OWV0bEpBLzBRd0tnL0xIMUgrNEQ3dlRQc2d6Zm1rOWFhNDMybDRadlpnOEpP?=
 =?utf-8?B?K25yb1NnN3FDVzl5ZE96dThtc2FmbkQ0UEN3RjFxcXZmZ2JWbnNVTTBta014?=
 =?utf-8?B?WFFsQUtmU3hmTTRScFRUZEU0dmhnMk9BTThwMWFoWEVXN0RINWd2QlZsV3hz?=
 =?utf-8?B?UGUrRERZZ0dvT0hQSHQzWmRhVGoxSG5yWktHclI3QXFpa3pZeHptNHRjV3Ni?=
 =?utf-8?B?bExvMElSeXhINWdyNDU3SFM1bStlTGREWmgvZmEyT0NMZE4vcTZZNWZIRnhR?=
 =?utf-8?B?U2ZieWM5SlpIam12TmxicHU5eU9GN1NKUUtmK0V5d2lsZ3l0S3pjWno2SFIz?=
 =?utf-8?B?WmYyR1dTTWlqaW4wamV5ZExWdlpyUWNIUnc1STYwdWI0VEJtU0s2T29Kc3VT?=
 =?utf-8?B?NmUzekYwVlRKd0paUUd6MzRnOWk3TkhSeXZyblpiRFkxMFJiVktzRnc1QXVj?=
 =?utf-8?B?TFpXcStXS2p2eHV2WHZzQjY2OTdnUHFJYXBWVmhINkdMVzNXT3daeSttWFZX?=
 =?utf-8?B?cWNpcXlJTEZNTkwvdnRpdmZBWEJlNm41VEJqUXVvNFJ3dW84Y2h5ajZWcnZl?=
 =?utf-8?B?NFZRSXgyUXlFcjlVcEszNEcyMFFXdW1kSHBIZFVXcDIrT2IrdFlJbVVOY3ZT?=
 =?utf-8?B?eUtsZTRjNHZDaGx6Vk05TFJWTkNTK1lBSHpaTStkTHNhTk5hTXYzNStLK2Fu?=
 =?utf-8?B?M3AxbmJRekg5eHJWUHNaV2NNbklIMVZ3VHNobU9Pa21kNGFXTTlyS2RKL1RX?=
 =?utf-8?B?eld1VVVlUGVNelZFSFdRRWh6N25PTnhIQzRCTzhmMVUxOFZkWGMvQnJLRFVK?=
 =?utf-8?B?eE9ERDlvbGc0UG1KeDc2RzBSRGhJOVljeEtTYVYyR2RmRlk5eEUzUTdDTld1?=
 =?utf-8?B?OHdGZDVWS3VjZWxSUncrcGdwQ1hINUJab3NSZ1g0dFM2QlBhVVRobWdhd0ZN?=
 =?utf-8?B?TGQ3L3RXcjFEbGJYTFdmU0drNVA1eGh5SStqRGNqQWJhRENKVjFrNkhGdEQy?=
 =?utf-8?B?R1crQVp1a0hGajlueFZXYlRxRXMxdWtnTUtXbGZiWWNnK3RWUWxkdmhBZnpP?=
 =?utf-8?B?WlJ6d2l3Wlp1WlNQWkpoNGp2ZWIrbnFXNmg3UVhDYTFyT2dSdVkrdW5Vd0gv?=
 =?utf-8?B?emlleVlrOUc3OU96TG9oalhGYy92cmtzcGVjUUxTMi9wMXlRQktwTFprc2tN?=
 =?utf-8?Q?MYo2bxkiKJR3ew2oBgmnujtri?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5aa2acc-fedb-474c-c9d5-08de28c27b7e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 05:54:49.8908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIVmLPCYwVMYgmdVt7sr1o9AZau+isuPndIvSYg/oNN4dZPuQtbJaQKOlpp3YASM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
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



On 11/21/2025 8:23 AM, Yang Wang wrote:
> v1:
> - make pp_table invisible on VF mode (only valid on BM)
> - make pp_table invisible on Mi* chips (Not supported)
> - make pp_table invisible if scpm feature is enabled.
> 
> v2:
> move pp_table invisible code logic into amdgpu_dpm_get_pp_table() function.
> 
> v3:
> add table buffer pointer check both on powerplay & swsmu.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 12 +++++++++---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c               | 11 ++++++++++-
>   drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  5 ++++-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        |  2 +-
>   4 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index c6f55d3522cd..79b174e5326d 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1187,8 +1187,11 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	int ret = 0;
>   
> -	if (!pp_funcs->get_pp_table)
> -		return 0;
> +	if (!table)
> +		return -EINVAL;
> +
> +	if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_enabled)
> +		return -EOPNOTSUPP;
>   
>   	mutex_lock(&adev->pm.mutex);
>   	ret = pp_funcs->get_pp_table(adev->powerplay.pp_handle,
> @@ -1715,7 +1718,10 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	int ret = 0;
>   
> -	if (!pp_funcs->set_pp_table)
> +	if (!buf || !size)
> +		return -EINVAL;
> +
> +	if (amdgpu_sriov_vf(adev) || !pp_funcs->set_pp_table || adev->scpm_enabled)
>   		return -EOPNOTSUPP;
>   
>   	mutex_lock(&adev->pm.mutex);
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 2a9467fe86db..f7103b35a9f1 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2560,7 +2560,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>   	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>   	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>   	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> -	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC),
>   	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
>   			      .attr_update = pp_dpm_clk_default_attr_update),
>   	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
> @@ -2692,6 +2692,15 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   		if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) ==
>   		    -EOPNOTSUPP)
>   			*states = ATTR_STATE_UNSUPPORTED;
> +	} else if (DEVICE_ATTR_IS(pp_table)) {
> +		int ret;
> +		char *tmp = NULL;
> +
> +		ret = amdgpu_dpm_get_pp_table(adev, &tmp);
> +		if (ret == -EOPNOTSUPP || !tmp)
> +			*states = ATTR_STATE_UNSUPPORTED;
> +		else
> +			*states = ATTR_STATE_SUPPORTED;
>   	}
>   
>   	switch (gc_ver) {
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 76a5353d7f4a..3aaf3dd71868 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -631,9 +631,12 @@ static int pp_dpm_get_pp_table(void *handle, char **table)
>   {
>   	struct pp_hwmgr *hwmgr = handle;
>   
> -	if (!hwmgr || !hwmgr->pm_en || !hwmgr->soft_pp_table)
> +	if (!hwmgr || !hwmgr->pm_en || !table)
>   		return -EINVAL;
>   
> +	if (!hwmgr->soft_pp_table)
> +		return -EOPNOTSUPP;
> +
>   	*table = (char *)hwmgr->soft_pp_table;
>   	return hwmgr->soft_pp_table_size;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 2aad25dce009..10575ecba5ae 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -634,7 +634,7 @@ static int smu_sys_get_pp_table(void *handle,
>   		return -EOPNOTSUPP;
>   
>   	if (!smu_table->power_play_table && !smu_table->hardcode_pptable)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>   
>   	if (smu_table->hardcode_pptable)
>   		*table = smu_table->hardcode_pptable;

