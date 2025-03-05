Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00DDC19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 16:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E3710E812;
	Wed,  5 Mar 2025 16:49:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DzG7SXpE";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B730C10E812
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 16:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvxiCBYPTbiCuVT/K7lr/N+htq5ZJQ43aY0/IdMMo5n64i2Z2qCxzrVkiEqneaYZmELXlCFW8LXSJ2L3zfTMt9UoiDoBXPEkKWq647rPlBSnc3Po5YvFfkFvf+bygukbNHQfhq78eQAFy7Hfu87oYx64LLldknIVKxEXQlBLExKiUFikg28hsu4zCQkg7EWgNwLY2OaIjRqs9+jUb+2AA1+x81LCQ0bBQ6X9/iJgpL2NQhKmV3vWntISuyuy8JaIdfenTjXNUqJCwm0L0o3Oz8JYyS8lwQBryLI3aATLIq3Lz/xNbPPfrSIELr3uLBUu+sfU1Ab0UxxltcjbYYt/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZL3qAp8fAeLxygRbscxogbd9QaFDtEbCwt8wawdMkq0=;
 b=JKw5UmDRmbbUouK7nF0WD/+foFgzNYc6WkpDT5aVVFuJmeGQh/RoRwiG4fX9xZf3OnoELCvwkO6G8w10iJ8jgNbc3GmzvPNAM5Hm5is3uhfIJDk8VOa79coeX5Jp8Red+mhftJBBnXAtKFGCTLoW3ZDSOqoXO8EruSzvHDB/DmRWh43hejnj3cplDVNx/66vHVbPgYOcVIwRWIkdyv+AAtbfLDIlzpeEtJ4B27FQtY6TxfB7/AP+tkBaAUnGI0Hc3t1AOga67w5ZuoeZxNGxlmNDgCIv+sDS0Gag9YGrtEsFBuXeEpoEr3j6jZLRAMA187ijsC2jG36Tu7/kM5AI5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZL3qAp8fAeLxygRbscxogbd9QaFDtEbCwt8wawdMkq0=;
 b=DzG7SXpEbFRtJaw7prcGN/bayqLwHIViGeqDUI1HAziV1J+acziSPc6Eu48PuTLgEsfDX0hajjA8gRVxsb96ohtHEKYF0cuBVHIQwpujOxD6tDVkwi2knqz9zbCwtbtUJF6x4PeE8KQqdVkfzdn2t5zV4sfLFYiudRVrEa43qjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 16:49:35 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 16:49:35 +0000
Message-ID: <fac31d8a-30bd-493b-b2f1-15694114476e@amd.com>
Date: Wed, 5 Mar 2025 22:19:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Add missing parameter for
 amdgpu_sdma_register_on_reset_callbacks
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250224114550.2289805-1-srinivasan.shanmugam@amd.com>
 <2dbe7e0b-86c4-46c3-9b0f-4cb5a12668c7@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <2dbe7e0b-86c4-46c3-9b0f-4cb5a12668c7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::19) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ceb6ab5-f636-49f7-d5fc-08dd5c05b5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1V3eEtWT205dGpweUJOb1B2SksxY3FQWUN1U1E2LzI0alpPNWFDQ2wvV3lm?=
 =?utf-8?B?TGgvNXROaU5XaHdZNE43d0Jad1hScnU2N09VT2xiVStkTi9USVVIWTJzdU5K?=
 =?utf-8?B?QUJjMGxrSE5xM2VUYXRibEZVNExVVDU2eVA1SGZqUFlVQ0t3U2JIU0plY1lF?=
 =?utf-8?B?QjNXMlN6NlhPazZJbkdGYjYrUEpWajZlZU5JbDc3c0pQb2pWM25XOHg2Ri96?=
 =?utf-8?B?bXJNSzZwNWN1Z0FBQXovVE5GUUdBL2VGbHU1NHEyZ0pDcGlnMC9UM2EwSkNp?=
 =?utf-8?B?b2FSNzBaU0lwbjE3YnoxSUFQQXhBZm1PemJnTk0xTGhmUzR2STJNYmVGK29F?=
 =?utf-8?B?eGFHVjN4VUxCWmNuOExvWHZEN1BWQ0pRYTc0STdSUjQxeDZMSEk3MGhqeFV1?=
 =?utf-8?B?a1ZPdU1nZDZLdmlZWmVUUERnaXJOQVQ5d3IzdU52TjRLRWVDeEMrTXpNb2RW?=
 =?utf-8?B?LzJ4c0hURXdzbzFULy81eDZxOWhYUmIwRkE0SFFJZ1p5ZnRqdDNSTExoQ004?=
 =?utf-8?B?Z3VPTmNHbE0rcHNvV29CdjVlbUVOaUVDV3lYZ0lxRmVuTGIrUEVqSHNreWVP?=
 =?utf-8?B?Y0tIWGx3MlFjK2xCWjRheG96NDJDZTBvOVM4MWZtOXNYaEh5MGVUKzR3M0N1?=
 =?utf-8?B?VjZ0dmJ1VU5nMzZzemVmQmJncjdwUUFWVGxha05oMUNDandhODN1SXoyRVJi?=
 =?utf-8?B?V0REM3N4c1BDUk9ITVBCRk91RG8rdmg3NWZreEZ4MWE0a2ZqT1ZPcUkzSkFw?=
 =?utf-8?B?YlZoZkpRZzc3M09YWm14ZjVJdndCVFU4K2hKY1lHbUJhbFA3TUlMUExGOENY?=
 =?utf-8?B?aTVQU1JJcWFSbEVrRlgrVjFJS0VqQk93eDF5anJPRU9OOVV5WVU0a2R5NDBw?=
 =?utf-8?B?N0VjYU45R1lLV2dGemh2TWZUYXpZbFE3SGtIa24wRy9ETFVBMUtORmFSRWIv?=
 =?utf-8?B?a2ZzSWsrVmM3TDJvWHRCdmdiVzNVcFpCK0M2TDliL0tveHlMNWZ2aWg4SUVD?=
 =?utf-8?B?b2QyTkFUWit1UUVSWUkrZHFIaWswaFAxeXdaVFJYbmJQZW1vRE9NSWxzclZQ?=
 =?utf-8?B?WjJZeENwd0RYaWVHb1hDVjV6ZGNPUW1XdTdKbkdzVFE4Y1VNaWxTRFAzbW5m?=
 =?utf-8?B?MHFaaXI1MHgrS0FDUlcxaFBUckRndFFRWDIwdS9ZZ0FyVStINDJ1cHE0QUk4?=
 =?utf-8?B?VG1EaGt6bW9VdmZOK2sxNWFLaGxTc2MrU2JmS25COWJabzg1NXdLQ29uNFBx?=
 =?utf-8?B?ZzNvQzVLOW9Rd1RLd2VyZXNsNVhndTByUEg5SUFVeE04Q1BuTjdYeXVRcG8r?=
 =?utf-8?B?OWlRVUJ6UU4yaDcyUnlVT1ZCaWVGbkF6S3hGSEtINGlzZ3FiZHJHNEpKajhy?=
 =?utf-8?B?akpIamZYVTJNZlI2eCs2Zmc5K05HUTNoK3JBbHk2Mmh6KzJ2Tnh3T0I5OWZH?=
 =?utf-8?B?ZnBnSngzamREK2EvNHFnWDVGVENaUk5pWWJRTHIxTldLOWY0cmtDQW5mN0hq?=
 =?utf-8?B?eW56WXUzUDhqbEV6b3lUeS9mb3RxSlFRQXVHdlR4Q3B0OVRkeGRPL1BjdytG?=
 =?utf-8?B?U3IzZTErMFpmOVNvVFA0NHdMYWx5VjU0M0ZSRURHRkhqeXlxZ2pGTVZ1Z0Ew?=
 =?utf-8?B?QkdGUUdmeUZSQkxvRW4rL2JNVldWZGs5YXUrN2ppaGM0NGFjR3JoS0pReUNK?=
 =?utf-8?B?b1RTYVhIZnkrQkJCNHRuajczQzh5a1BqaVBSS0FRb0xtelhjbjhvTU42VWRu?=
 =?utf-8?B?NlZJeHBIR3pYVWhlOWhpRkpueDA4WXpCQmdEaUV5bG41OTF3RDQ3K3dHUkJh?=
 =?utf-8?B?V2d6ZzhjeERQR01ydG5WVGlQWmNjaG5EY0dSMlZ1eVlOVUNmYkUvd1dFTGhX?=
 =?utf-8?Q?NwtBqBCnM+kYR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFhXeWlYenM2QXBCMDlhaUdqUkpkK0UxeHpuS20xOHFuNHlsNTJFVHJOZ3Q2?=
 =?utf-8?B?YzBYakxLcG83bDhaOE9EWXZtdHE1TnpmUGFlK1Q5eWlYa0FacTB4a21paUIz?=
 =?utf-8?B?THFJdkdEZzVmMlAwdUZHd045M1UzQzBGcjdqdWNIdWZzSzB0SDlmYnZyM0ht?=
 =?utf-8?B?TW9Pa0pHQXpydGQ0SXVuVFNWVUEvUko2dGhWSHNOT1hoVTNzbE5UVWZIVTJi?=
 =?utf-8?B?YkQ1bGx2Tm5RbnpMdG81aExvUTZGenFSOGQwbFlUd1RIM2pscmxucEJVLzc4?=
 =?utf-8?B?RzV4RGhhSkhUNGFFanBpeHhhVUxSeEJxcm5DR1k1YUFveXM1aHhPYW1tT1Ns?=
 =?utf-8?B?OE5Zd1dOR0EyWUNnckhDbnBmb01YMGRJRUROQU5CK0NSSlRDVzB2VmJIakM4?=
 =?utf-8?B?ZjZHaVFZME40M3M1OWY0SUlXczVtR0NxSGJkTEIyQzZ4cS9COWRqSVBsZUZv?=
 =?utf-8?B?Ym1sSS9UcWRVcUp1S3lxZDlBMGJ5ZlMyN0phR1Bnenk4Vno5RkNJNExoU0Z1?=
 =?utf-8?B?OXNTQkFaQW00YmU1djBNaEQweURxc2tnYjVpUTRUZWdrU3drRkZkY0xpL1d3?=
 =?utf-8?B?UHpoUnI1cHUvRFZiTkJMRnA2clcxS05ISjlPWE5qbXlzc1J2UTcrcm1YZHNH?=
 =?utf-8?B?WmhqZm42cXZaMTA4RmtFRGhBNk5UM2ZYbTRtMnhWUVBMUTJQWTRzakFrYmtI?=
 =?utf-8?B?SHRoeUxrMGdFVXdIYnFJVlByTE1RRWFkek8rTVJ2bFN4OXN3OHBkZGlDN1Zn?=
 =?utf-8?B?QXlNbUhtV2lwVHJBWkFHWEgyb2ZMbk50WEVFQVEyS0czR0JWRWlQaGRsT3U0?=
 =?utf-8?B?M2lEYjQyVVpySmhMeFhZc0EySVVaQ3pzc3d4Q29EaEdnUTFPM254WDFxMU9l?=
 =?utf-8?B?S1M3NHpBSmhTTmhWZnEvd2hld2wyNk1yc0dFQmF6bjY0bmFpamxCaE1FTWNS?=
 =?utf-8?B?WFFyYWE3RktHa0l3ZVFnQzRWcWladTdOMDFucThzekV3QWtOWFZHNUx3QUZN?=
 =?utf-8?B?dVZNQUhYcG5Qc2Y0UC8zOUZoTG1yd1BtamdqUTFQMXNSNGNHc2N2clJjeFIw?=
 =?utf-8?B?OHNUejJaOGM2RlZ2ZGw4ckQ2T3lwMW03WGtLZG5kQXFZa0lVQzZUaEd6R1pT?=
 =?utf-8?B?SjUrelZJMXRIbUZLQjFDWWJlaWFZTENVRm9ydDZVUnVTdEFDc0EwY1VpSW9H?=
 =?utf-8?B?bU0yOGVBWEsycDZmcmpJKy9VNk9CZ0YwWGVOZk5aQndhcW9UQjJ5bkwwN05R?=
 =?utf-8?B?Qm1ZL1piZXVJRDc0MmMxRzVFMkdGQmo4VnFkYUdzNkhIdHdFTkt1WGRFR0sx?=
 =?utf-8?B?ZWk0TEgwMjhoRnA2amtYTE83dmNXaFFKMlFtS3c5S2tMRlBqNTdHbmFuQ0Iy?=
 =?utf-8?B?S2REWnkxeDBneG5YcjFza01UeG50MiswQjZiYkk5MW1wdWp0N1FEZzR4YkEz?=
 =?utf-8?B?aklPS1RtN3ZJOHZsbWRDajNIWTVlWXFhdldSdUo4a2NDclM2UDFkK3k0cEY5?=
 =?utf-8?B?L2pUeEhUV1V6YnJwRkhXWWN5TTYvWmhZMkI2MGJVM1Z0ei9iOGZVNXZLYzM5?=
 =?utf-8?B?UlppbHJ3d2V5b2x5WlhIMjhsaTkzbE1zY3RYL1RrVnNOenJ5a3BFQjQzUW4w?=
 =?utf-8?B?YUNQT1V3MmtXUVlXMU83aG9yMjdUR05ZOURycXNkREQ3MVZPUzl6Q0s2S29E?=
 =?utf-8?B?ckVvbUJJZU1EalJMZWE1V0RIM2hKYUJDbTdzNFlNTFA5aEJ4aDZhb2tiaHVq?=
 =?utf-8?B?MXRhU2EwWWJjRVYvRWtENEJpdzlmZCtBU0JDUmpqYmVmNTNvOG5DdEd4QThr?=
 =?utf-8?B?ME9VR3dKckJaNkRobndMS0VVQTRlcFVPVnUrWVpCL3RldzdvbkdoZkJobXc2?=
 =?utf-8?B?M0dqRUdhYjRpUDY3aXVxZWY0OWFzb1QvLzJjNzU5UlN0VCtjaUpFYWE0TUN4?=
 =?utf-8?B?VVMrakpldVYvK3hDQTdoeVJuNmczVnJHQW9UYTI4UWNFV2NpUThrd3R0dlRa?=
 =?utf-8?B?OTQvYTNVYlN0Ymo4aVdzV3dwbWUzWXVNRERmYUdLTjVEZ2thZ0JJL09jTWpK?=
 =?utf-8?B?clVLNGozM3lhZFIyYlp3a0xrcUlMelFEQVNmMlFmM216SGJDd1h0bHBPUkdk?=
 =?utf-8?Q?pYRpQ/+XMrB8G6MMWsdFrl5IB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ceb6ab5-f636-49f7-d5fc-08dd5c05b5e6
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 16:49:35.6124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYgUuzbP79bmRJOlGopLNPLeEKkN/RF4wMVOG+dHUqgriSdYT4LASBikvO18pOqieTUOJHrgCFmDlzBT2fZBfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
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


On 2/24/2025 6:54 PM, Christian König wrote:
> Am 24.02.25 um 12:45 schrieb Srinivasan Shanmugam:
>> This commit updates the documentation for the function
>> amdgpu_sdma_register_on_reset_callbacks to include a description
>> for the 'adev' parameter.
>>
>> The 'adev' parameter is a pointer to the amdgpu_device structure,
>> which is necessary for registering SDMA reset callbacks.
>>
>> Fixes the below with gcc W=1:
>> drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:474: warning: Function parameter or struct member 'adev' not described in 'amdgpu_sdma_register_on_reset_callbacks'
>>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> index 42a7b86e41c3..82856592039b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> @@ -464,6 +464,7 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>>   
>>   /**
>>    * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
> Why do we have a function to dynamically register callbacks in the first place?

Hi Christian,

Looks like this change comes from commit:

commit 938b123d7c85971328712c6173268d7de66ba843
Author: Jesse.zhang@amd.com <Jesse.zhang@amd.com>
Date:   Tue Jan 21 09:18:44 2025 +0800

     drm/amdgpu/kfd: Add shared SDMA reset functionality with callback 
support

     This patch introduces shared SDMA reset functionality between 
AMDGPU and KFD.
     The implementation includes the following key changes:

     1. Added `amdgpu_sdma_reset_queue`:
        - Resets a specific SDMA queue by instance ID.
        - Invokes registered pre-reset and post-reset callbacks to allow 
KFD and AMDGPU
          to save/restore their state during the reset process.

     2. Added `amdgpu_set_on_reset_callbacks`:
        - Allows KFD and AMDGPU to register callback functions for 
pre-reset and
          post-reset operations.
        - Callbacks are stored in a global linked list and invoked in 
the correct order
          during SDMA reset.

     This patch ensures that both AMDGPU and KFD can handle SDMA reset 
events
     gracefully, with proper state saving and restoration. It also 
provides a flexible
     callback mechanism for future extensions.

looks like may be design choice though not sure, where this callback 
mechanism is to provides flexibility in handling SDMA reset events. By 
allowing both KFD (Kernel Fusion Driver) and AMDGPU to register their 
own pre-reset and post-reset functions,

May I please have your suggestions, if we might further improve this 
mechanism or any other aspects of the implementation.

Thanks in advance,

Srini

>
> That doesn't seem to make much sense.
>
> Regards,
> Christian.
>
>> + * @adev: Pointer to the amdgpu_device structure
>>    * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
>>    *
>>    * This function allows KFD and AMDGPU to register their own callbacks for handling
