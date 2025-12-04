Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1117DD2A551
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 22:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E90710E9D6;
	Thu,  4 Dec 2025 22:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pIzVSqlw";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31ADF10E9D6
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 22:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSKmNO51keAzUU1CaBvlHiVlkqCfLjsGBAIz3aQd+KHnYUqPp/6r6Vm2fLDjNbjnhh1zGQsXqQ2SCOH6Ki6ovIwUUuGUy7QH2TTzNAMMBJhvTt9VhVXdygSH4L+CFWEdrBYCDxMTGLTPXw22U6YmoZtOXpHWgKdkyBcuiE7ovTWMkJyNZ/cp9vXgE6pgcme5ChqPhkkniwmwRUm+QP6dGA5trfE9Tw9uGt6LDQU3yf+0VUp4OClElXCId/M/PaFQ47aj0YTWIvOnCoIbjdAMrtSYdw+rZRoIteV49mcczijoWk9oXt17mf4S5X61WxOxDuccNModjWY+LdiC5kbhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO5/tFe0BQrS/on19OfLUQk/iNdM+Kl9K3QCk1eMJAM=;
 b=EHRyhhKp60xFWwpoMdJS4ZXOONd6cz4yaAIir8L0Dt+5JyLVBUF4476HYuplh4BjDHNOwjUaA22ND+Olvy2KqlghKg5WNq52vX9OPK2HLnedWbGAgk9CE0rlqSpmgGJpxX9wGpdCZX+WkjV1835ot+0n1zasG7WDqTQOmPwC/D0iBURT2dgZQMkDXfINnZ+9850IbQ+/QHVvZ10gF/5pkBHsALQJnTbaUmBHGzzwuZuQT/w4r2TjN9PN149WZIoI9UggsfukyrrapXDng5X9o4Ux4btY6X0CS31MFUunV0oIqKrmNlJOaP2wXFKuWfdqvXztdZaQSiCeAMhpkOMWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO5/tFe0BQrS/on19OfLUQk/iNdM+Kl9K3QCk1eMJAM=;
 b=pIzVSqlw7GOS2oLkc7jQhX/C5pHYQeE7RaFptBHof4IQ3fVgg66N/o84UO0YuP6uu3/RLrrSG/zVuRSPEreqkbva6AI6D/bAwJtYu1HSJuRqzBPLdG9ugGUpoNntensONBayxYDBM/xiJXZdAvBL6aFHQVax1tbWTnAzIWbbgLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 22:43:27 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 22:43:27 +0000
Message-ID: <61c8b00f-ec7a-482b-a3d0-b37d3a8fcedb@amd.com>
Date: Thu, 4 Dec 2025 17:43:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/amdkfd: Map VRAM MQD on GART
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
 <20251201142838.1516452-5-Philip.Yang@amd.com>
 <ba907ce9-8a80-4aa7-8d41-11880b56c0c0@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <ba907ce9-8a80-4aa7-8d41-11880b56c0c0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::22) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 851e471f-6c23-42ed-8bc0-08de33868a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEVWMlFNODRDK1lnSGF2Vmx4Z3hZa0tRcGxndjFoWHl3TjcrakRTY2ZrN3pJ?=
 =?utf-8?B?c3FxUFV6NXQ3R0srb3dPZU1XY3FORmE3QzVBTVM5YVVQbVhmSFlHTFpKakZo?=
 =?utf-8?B?VHZXRisrWVoxSUdzNVdaUVpCNmZPVjdYWmJBOGNlRmhrVzFJTytFdndMTHlB?=
 =?utf-8?B?Wm9ORGxheDRDRWE3OEs3bWkwOTJLY1pRYTNWVUZ1YTVINDJad3hQbGFsNTRU?=
 =?utf-8?B?d0Jad05zUm40VGg4ckVQdjRMM1lyUURSLzhjNlQzNG1GalFyR2hseWl2K2lz?=
 =?utf-8?B?LzhTNjl6YysxYXVXTjBUb1RIOUoyT256bTl0cFl1Y2FjNk42UmJTRkpJUWF6?=
 =?utf-8?B?UTF0NE5WMUYrYm1Gam5oWkxLMWVpaTliQlFmUXhSMjlYSmhRNlQ3TWNaRk5V?=
 =?utf-8?B?QXliK3lmdytvNy8va1VhbWo4M25TaUlKSTdSQURFQnRMOWNNdUlrbWw3RWk2?=
 =?utf-8?B?Yk14anArYjNLZ2FORXJjbFJtWEtIM1U4RXFOVkJMdFZ3SnZxa1d0REoxNWFv?=
 =?utf-8?B?eTYxRldRVmp5cWlkRzZTaFZ5aG9yRUJTNGlTNU1lamw1ZGJCclBsQWMyWi9w?=
 =?utf-8?B?NHVzTWg0RVRQWStaOXd5VlNaOTVaNlZoQW5yL2VSQ2x0U0Nub1E0YUt5VEhY?=
 =?utf-8?B?NXF6c2xVNkdxV1VjSG14WDlBMWJwSHdWbStxVE92TENhaUVKVFlRamR5L3ND?=
 =?utf-8?B?TEFQa3VheUNONURLcHE3YmZ1alNzNUlZYUQ1VFdIZ3VGMWRnVlJaMWVyL3Bw?=
 =?utf-8?B?ZW9lN1RnVVlhYmdvM1hqZjFQMFNWVXdrVDJZbmEvdERRMEZmSVh4VFRpQkRl?=
 =?utf-8?B?ZVNBTG9mVXpnVzZDalZoQnNlQmpmRHQyeTV3K2plZEJFM1E2Qk5MNWZqYW1G?=
 =?utf-8?B?ejl6K0tJanhrZXRGczhjenNUdHU4eEpBQUkxb1NoVHFYQTYvaEdtbjIyMEpD?=
 =?utf-8?B?ZWtGbFh1eGhlMGNlbjhoWjVUYkVOWEpCWTdHZE5OUGRydEZiOEpXT0YyQlpq?=
 =?utf-8?B?NmJ3bjZhMEphSGgwR25DcGtHZ3BNUHZVNGRLaVpIbFB6dU9jaWpXTnBKcWxx?=
 =?utf-8?B?d0pvTjlyb3h2ZURReXFMeENWcFJMbWxpdGx6M1dKQVZvWURkSTd0K0x6bVVD?=
 =?utf-8?B?a09PU1BNSEZKNUpJNUZLTmdXTW1uK1NuYmJ5Tk1OSURhYXFhRjhoRHU4VlAx?=
 =?utf-8?B?cmRHS3hNU0JrdHMyK3hSWWVXNXBXMHFFTUEyeURqTS9kazdRS3pTbGxnRmNj?=
 =?utf-8?B?M3U4aVJGd1BHSStTZWRmeGRjTFo0bWdUKzB4ekgwejIwWGNPYkYzNDNvVHBF?=
 =?utf-8?B?NDhwa3Q3Z0NRUmdFYWY2czhCeStmWDlodDNDS3dHclhvNVV4Mk13aGVaeWFC?=
 =?utf-8?B?eHNKTThadDVnZUlPR1N2ck01NXQwUjVaZDBwUDdQeG02Y00vV0V5Mit3cGZC?=
 =?utf-8?B?OFRFcmpiQkVrYytNS3J1d3dKazJtQTA1Z0FkN3lYMXczY2hVcE54ZFlTMG82?=
 =?utf-8?B?RExFeEFjbTV4cWw0ZUhVaGJRd1BGU1JWZC9kQW5xNFUyT0FyK2l2dU5kKytD?=
 =?utf-8?B?eFV1UU9laVl2c01zMVpGbmRXUWZTMTVLWWE1d05aTGxnMDI2NGRMaDBUQUJr?=
 =?utf-8?B?Rm0rZ05OUkpZYzhwYmc4dUk5a2ZYMERXRHR5ek1SS3N5UEtJdXlkZUhwYXJn?=
 =?utf-8?B?WGtJZWZIaWJCaUFwQjVEeExYendRYzJrUnQrVUZ4MnNwNnVwVFFJVnQxazd0?=
 =?utf-8?B?SXhDNEFtY2QwTFFBT2Q1WTlsbmtiZEVtWTFMaERPU3Y2VGJvTkRGUnJZanNq?=
 =?utf-8?B?ZGlXWE9qL1plWmFMazRlMHNhMkhUT3RSK01yeEIxQjA3QXZKNnpCeFBOZEFN?=
 =?utf-8?B?OUNLdm1uYnBCUjZoNHo0SHZGL1pITUJEb1JIeVVzNC9veEMwSmVYZTJWUGE3?=
 =?utf-8?Q?I/YfA17GpTpQ5kb95/m94+l9HVQBP/3A?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDF0SURGUEVKNUllSUVTWUNmemJ2Qmk5WHVNbW1uU0lhM2NQLzhuakd2Mmdo?=
 =?utf-8?B?VDhrZFN2WmdDVzhtaitlV1ArWG82MWhiOFRIRGRpQmlZaFoxeE9mdUFDSndk?=
 =?utf-8?B?OW1uRXhCWWFOZm5WdjJ2aUVqczRKS0YrNmpPYXZzTVB0UjVUZzJidzFpNXVQ?=
 =?utf-8?B?TnE4WDI2YXlqNi9TWk1Va1d1K293LzMraEdtcEJGR20vTll3OGZBRU8zTkk3?=
 =?utf-8?B?RStjdUN1ZnVxb0d3aGZ2U3RFQlZkZEg0Uk14djc2V2dGaWZySERlaEIxeWxN?=
 =?utf-8?B?ZWlWU2ZTMHBHbzltak5TdFozWGpkL1liZURBWSswamY5L24zL0dlSTQ2T0tq?=
 =?utf-8?B?SzQyMmE1SXRGcGRLdThCclBwaHdxTEpqYnFLTlVUa0JpR2FqR1VkS1JvRjBx?=
 =?utf-8?B?amk2U0hkcmJsYTd0THBVd2NVUFhMZTFtV2p3bm8zdjNIUCtad2Q1WlE0VDI3?=
 =?utf-8?B?S3BFUHRyNlByZDBpMUxSOTg3aG44MkZ3NEt2c1FhdmUwVEI5azZjZ3dVd045?=
 =?utf-8?B?VjVLTDNrS3lUMTFWbUpoT2txdFVOUEVCYzRsdmxrN25ZamxXZTVBRWViWFFG?=
 =?utf-8?B?RmJyRzk1VXlTVW1DNTRtWWtKVGpHRDlqejhvbmNFemJDWnhtL3J6dVBYUE1t?=
 =?utf-8?B?cUhZZG9TaTRrbjc0R05UWTZyd0FESFFhbmw0bnhNSGZGcFZWNHF2YVJyMFBS?=
 =?utf-8?B?WmJSQ3JZdnpwTVJJV3FRV2hza0QwVmxiUldNMitvSDAvVlk4MW00TlVCcmgx?=
 =?utf-8?B?NVNjK2t3dDJMZGFNaGhRSEpmbGJWWW00L1Z0STROc3FnYVdUREFWUWloKy9Q?=
 =?utf-8?B?M2EyRkpmUWtoQUMzRVVvMVVoMXhKaWdXNzVTVm5PSWUyVm5IWW9jV3lCZmRX?=
 =?utf-8?B?S2hYbER1YVJ4NE1sU0dZVjBmTVN6VjBqa2YrS0l6ZXBvaGp4TVYzMEI5eTlL?=
 =?utf-8?B?T1c5UEZ0bWRDN1BKU0tqZk1XUUpsVTNqWk1YVU1yK1ZTVXVkVXY4VGczSzVM?=
 =?utf-8?B?MTcvWWFyQTdLWlVacWxTNVp3L1VTUVpjY2lQalNhQzNoZWNyeUNnRXp1ZEZ2?=
 =?utf-8?B?SGFVVGhtNmwwK281ZGRQNjNNV2p5VFBlWGtaVXY0RXl3M0NVdVpibFJHZElx?=
 =?utf-8?B?aXBXWmJXRms2VUZoV242eUhIdXRvZEs5ZmdHOFpLVTFablpYT1JTL0pCRTZk?=
 =?utf-8?B?UVk4MGlvM2Qwczl4TWZQQklRRUFuMTdISkZBeDI3RGx2MkE3eFRrN3hCbHhn?=
 =?utf-8?B?Z3lIbFFjNzJxNWFhRTM0OGtrYkREd1BHYURGUnJnajBVVE1QNld5QW5vSE1p?=
 =?utf-8?B?WitZUk9LdkU2YWIvZUdmYkJ3M2ZOVWhkM0JXZ3kxS1R6L3BDdW54aVdvaity?=
 =?utf-8?B?UkRYZ0ZwUFAzOE82c0xrTFd2Y3UvdXd1Ryt5d1c0U2RpQ1BVaEhGY0dyQmZl?=
 =?utf-8?B?cUNPRDFCa2NSRHFrUE5LTk1yRnQ0MHAxMlQ3dGdSSy8zL2dOK2h5Qzh3YXpP?=
 =?utf-8?B?UldlUDRZNFg1WEJkbjlHQW0wbTA2THRMd0wyaU0zQmg4Z3ZtWEdKdGtTYzB4?=
 =?utf-8?B?aGs4T2NFMFhaaFRiYXJ2SC8yem1iK2FkdHF2ZXIyUlBNOEtNckI5ZnBnQnR2?=
 =?utf-8?B?citMRnlqV21nK0d5WFllTUlEOUoya2VEUEQ2L0lWOGV2TlJtQ3Vud3dPeHBS?=
 =?utf-8?B?aVJ3cWE3M3hmclhvdUVTOWpLMExxVmFiZUhrbnR1b2pBSjFkeXVVU2dsUHJH?=
 =?utf-8?B?VjNRM0E0ajNTQkVmN2JObnJqREJ0Q2dndEFFSEk0dXV2MTRENUwzUlpNYXgv?=
 =?utf-8?B?VERZZVhMK1BzT0RZUFUxSHVJQ3FqUjZmYzZTWnMxSGZqcHZjeno4WE1wZFRQ?=
 =?utf-8?B?cCtyY0p5cTN6NDhYUStEQUNvU09NYVNTOE9UMVJtZUJrYmo3bWJZcktHQmVx?=
 =?utf-8?B?MWtiU1dNZmY1bnZ5eFE1SmdCZCtWaVUxWEEvV2tBRHA5azUyRjI5YUhiK2Jj?=
 =?utf-8?B?ak5WbDViMmEvaWpVSFNNMFlCZThGMXp5UUNaTEJJR3hDYllmcFJNcll0Z1RF?=
 =?utf-8?B?dVUrSmR1OVNEbE8vRG1teVVyOGR5OHZNdXNFdlArdVljK2hJMnVmMkpqSTlP?=
 =?utf-8?Q?gMCs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851e471f-6c23-42ed-8bc0-08de33868a32
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 22:43:27.1661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRtQbSxxuYlC//fU6JLAfFlI/XvDO0Z0vhvLET9wwXJUQSltkPB26FFkK1tZjzWs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
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



On 2025-12-03 11:06, Christian König wrote:
> On 12/1/25 15:28, Philip Yang wrote:
>> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map to GART
>> as mtype RW caching, to reduce queue switch latency.
>>
>> TTM bo only has one resource, add GART resource to amdgpu_bo in order to
>> support dynamic GART resource and VRAM BO resource.
>>
>> Update amdgpu_ttm_gart_bind_gfx9_mqd to map MQD in system or VRAM.
>>
>> Add helper amdgpu_ttm_alloc_gart_for_vram_bo to alloc GART entries resource
>> for MQD bo->gart_res and bind to GART mapping.
> Clear NAK to that approach! That would completely confuse TTM.
>
> We need to talk about that on the weekly meeting first.
I think that is becausettm_bo_mem_space also add GART resource into ttm 
bo, which already hold
VRAM resource. Felix suggest to alloc gart space via drm_mm and store in 
mqd structure, not in amdgpu_bo.
I will implement it in next version and we can discuss details in the 
meeting.

Regards,
Philip
>
> Regards,
> Christian.
>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   3 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 113 +++++++++++++++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   1 +
>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   8 ++
>>   5 files changed, 108 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 926a3f09a776..d267456cd181 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -1297,6 +1297,9 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>>   
>>   	abo = ttm_to_amdgpu_bo(bo);
>>   
>> +	if (abo->gart_res)
>> +		ttm_resource_free(bo, &abo->gart_res);
>> +
>>   	WARN_ON(abo->vm_bo);
>>   
>>   	if (abo->kfd_bo)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index 52c2d1731aab..a412f5ec2a09 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -106,6 +106,7 @@ struct amdgpu_bo {
>>   	struct ttm_place		placements[AMDGPU_BO_MAX_PLACEMENTS];
>>   	struct ttm_placement		placement;
>>   	struct ttm_buffer_object	tbo;
>> +	struct ttm_resource		*gart_res;
>>   	struct ttm_bo_kmap_obj		kmap;
>>   	u64				flags;
>>   	/* per VM structure for page tables and with virtual addresses */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 5f58cff2c28b..1d8f5fc66acc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -832,14 +832,27 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
>>    * Ctrl stack and modify their memory type to NC.
>>    */
>>   static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>> -				struct ttm_tt *ttm, uint64_t flags)
>> +				struct ttm_buffer_object *tbo,
>> +				uint64_t flags)
>>   {
>> +	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(tbo);
>> +	struct ttm_tt *ttm = tbo->ttm;
>>   	struct amdgpu_ttm_tt *gtt = (void *)ttm;
>> -	uint64_t total_pages = ttm->num_pages;
>> +	uint64_t total_pages;
>>   	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
>>   	uint64_t page_idx, pages_per_xcc;
>> -	int i;
>>   	uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
>> +	int i;
>> +
>> +	if (!ttm && !abo->gart_res)
>> +		return;
>> +
>> +	if (ttm) {
>> +		total_pages = ttm->num_pages;
>> +	} else {
>> +		WARN_ON_ONCE(abo->gart_res->size != tbo->resource->size);
>> +		total_pages = (abo->gart_res->size) >> PAGE_SHIFT;
>> +	}
>>   
>>   	flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_RW);
>>   
>> @@ -847,19 +860,33 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>>   	do_div(pages_per_xcc, num_xcc);
>>   
>>   	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
>> -		/* MQD page: use default flags */
>> -		amdgpu_gart_bind(adev,
>> -				gtt->offset + (page_idx << PAGE_SHIFT),
>> -				1, &gtt->ttm.dma_address[page_idx], flags);
>> -		/*
>> -		 * Ctrl pages - modify the memory type to NC (ctrl_flags) from
>> -		 * the second page of the BO onward.
>> -		 */
>> -		amdgpu_gart_bind(adev,
>> -				gtt->offset + ((page_idx + 1) << PAGE_SHIFT),
>> -				pages_per_xcc - 1,
>> -				&gtt->ttm.dma_address[page_idx + 1],
>> -				ctrl_flags);
>> +		if (ttm) {
>> +			/* MQD page: use default flags */
>> +			amdgpu_gart_bind(adev,
>> +					gtt->offset + (page_idx << PAGE_SHIFT),
>> +					1, &gtt->ttm.dma_address[page_idx], flags);
>> +			/*
>> +			 * Ctrl pages - modify the memory type to NC (ctrl_flags) from
>> +			 * the second page of the BO onward.
>> +			 */
>> +			amdgpu_gart_bind(adev,
>> +					gtt->offset + ((page_idx + 1) << PAGE_SHIFT),
>> +					pages_per_xcc - 1,
>> +					&gtt->ttm.dma_address[page_idx + 1],
>> +					ctrl_flags);
>> +		} else {
>> +			u64 pa = (tbo->resource->start + page_idx) << PAGE_SHIFT;
>> +			u64 start_page = abo->gart_res->start + page_idx;
>> +
>> +			pa += adev->vm_manager.vram_base_offset;
>> +			amdgpu_gart_map_vram_range(adev, pa, start_page, 1,
>> +						   flags, NULL);
>> +
>> +			amdgpu_gart_map_vram_range(adev, pa + PAGE_SIZE,
>> +						   start_page + 1,
>> +						   pages_per_xcc - 1,
>> +						   ctrl_flags, NULL);
>> +		}
>>   	}
>>   }
>>   
>> @@ -875,12 +902,14 @@ static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>   		flags |= AMDGPU_PTE_TMZ;
>>   
>>   	if (abo->flags & AMDGPU_GEM_CREATE_CP_MQD_GFX9) {
>> -		amdgpu_ttm_gart_bind_gfx9_mqd(adev, ttm, flags);
>> +		amdgpu_ttm_gart_bind_gfx9_mqd(adev, tbo, flags);
>>   	} else {
>>   		amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>>   				 gtt->ttm.dma_address, flags);
>>   	}
>> -	gtt->bound = true;
>> +
>> +	if (ttm)
>> +		gtt->bound = true;
>>   }
>>   
>>   /*
>> @@ -1000,6 +1029,54 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>>   	return 0;
>>   }
>>   
>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>> +				  u64 *gpu_addr)
>> +{
>> +	struct ttm_buffer_object *bo = &abo->tbo;
>> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>> +	struct ttm_operation_ctx ctx = { false, false };
>> +	struct ttm_placement placement;
>> +	struct ttm_place placements;
>> +	struct ttm_resource *res;
>> +	uint64_t flags;
>> +	int r;
>> +
>> +	/* Only for valid VRAM bo resource */
>> +	if (bo->resource->start == AMDGPU_BO_INVALID_OFFSET)
>> +		return 0;
>> +
>> +	r = amdgpu_bo_reserve(abo, false);
>> +	if (unlikely(r))
>> +		return r;
>> +
>> +	/* allocate GART space */
>> +	placement.num_placement = 1;
>> +	placement.placement = &placements;
>> +	placements.fpfn = 0;
>> +	placements.lpfn = adev->gmc.gart_size >> PAGE_SHIFT;
>> +	placements.mem_type = TTM_PL_TT;
>> +	placements.flags = bo->resource->placement;
>> +
>> +	r = ttm_bo_mem_space(bo, &placement, &res, &ctx);
>> +	if (unlikely(r))
>> +		goto out_unreserve;
>> +
>> +	/* compute PTE flags for this buffer object */
>> +	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
>> +
>> +	/* Bind VRAM pages */
>> +	abo->gart_res = res;
>> +
>> +	amdgpu_ttm_gart_bind(adev, bo, flags);
>> +	amdgpu_gart_invalidate_tlb(adev);
>> +
>> +	*gpu_addr = res->start << PAGE_SHIFT;
>> +
>> +out_unreserve:
>> +	amdgpu_bo_unreserve(abo);
>> +	return r;
>> +}
>> +
>>   /*
>>    * amdgpu_ttm_recover_gart - Rebind GTT pages
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 15e659575087..707654732759 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -179,6 +179,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>   			u64 k_job_id);
>>   
>>   int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo, u64 *gpu_addr);
>>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> index c6945c842267..d96de02c6bb9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> @@ -148,6 +148,14 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>>   			kfree(mqd_mem_obj);
>>   			return NULL;
>>   		}
>> +
>> +		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->gtt_mem,
>> +						       &(mqd_mem_obj->gpu_addr));
>> +		if (retval) {
>> +			amdgpu_amdkfd_free_gtt_mem(node->adev, &(mqd_mem_obj->gtt_mem));
>> +			kfree(mqd_mem_obj);
>> +			return NULL;
>> +		}
>>   	} else {
>>   		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>>   				&mqd_mem_obj);

