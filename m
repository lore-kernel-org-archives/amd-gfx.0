Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F0ECFC28D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 15:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC1E10E8D4;
	Fri, 21 Nov 2025 15:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dgBD/6oe";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B7ED10E8D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 15:59:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZgo3lZzTH6lGoX1UDssniBgG9nl+9WgxnmSfgJ86M6wO7Vs91EjlCS+XoBOUutcUqPHa5eGfZa9O/AlgF+umPDUKEOrJHKnMibrA5P+29P0MLAGJ6vOu0JUAqkAGwA4xIc/fE8aTO9ROpAU/ZJeP8EK+UQ3W0e8G4uekhA2BamtZvYcrS9A8JZnHgRecPjJlnZ3uA4/LwCjP5IaGdSSj+EI811/hH9hkBj+tkRLCb0YaZd8/uhIeD/l/A8790q0Djcx2+pheT+yAFfdFDdP4IlqwElrFtzDNHSCNHgSunuNhP9nec5dbwQJQGckWwlKkXwaG+bal6LOve5bob3sJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OANWXP/n4lu4MV9v36uHrCUHAgt/2cndiLDiZ6OUCss=;
 b=eyk+zHC/HXI/qcgF4EW2uBIn55zGbd9phyh515RseTmw5WVApGWnguuio9McpqiWZDl0/BNQTj5wge07Vlenusije9sapF03Ub/vV8pvIxhQt4iI65T7aCUazZihh9UCykMMfNeZxdtUFWIqxHu7vW5Kr0oVb/FLikeN81l6Fiqd4bT9Z253EeW5r+li0WpvjL+IZq5//dTgCfTbb0hPS/chjFmdB3PxQ93m0lltdL8lI321kCmmW6iaBB4IwmzxNuXVB7vt13Yy81p4CKEldlyz+SD1WEHHy2n2u0JjwrsuyhUeXGVZhSPC+OhHMY9kqxspbVBvqoDMgMFfAa/XMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OANWXP/n4lu4MV9v36uHrCUHAgt/2cndiLDiZ6OUCss=;
 b=dgBD/6oeqi/DPq0rolT7hTlxJeBB5+t2/FcmHSo+AQTuFxyyTyPd4y5sdE1I/eZKySiLdReqXNpcV1+ypPqHd6YddrF2Ytii5MSAvmFeunKKXI37XS1Y/BXN+sF7+RBPQVzjwRQa5Gc1SyiXgkMtqHPZkcUPEvBYfjX0h5RSVAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 15:59:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.021; Fri, 21 Nov 2025
 15:59:14 +0000
Message-ID: <5eb5b453-136e-4392-a5a9-3c4cbe30a2aa@amd.com>
Date: Fri, 21 Nov 2025 16:59:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Address amdgpu reload issues in APUs
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Robert Beckett <bob.beckett@collabora.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20251121135658.459620-1-siqueira@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251121135658.459620-1-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 149e6820-5f41-414d-88e4-08de2916eac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akhJYWh3T1BTQmtad3ZibDZDYXZBc0pUV3prN0E4Y05wbkFhSDJ6bGhQTVZo?=
 =?utf-8?B?VlJiTTZlMUo1S1kyRFJ0R1l2L3ZVM2t2ZFJvSllnU0RvNHBxLzNNYUQ3MEd4?=
 =?utf-8?B?S0ZuZWZRTVRGMGVLSTAwSjA2c2dQVjhsb2d4RUVCZXZRa0J4TW1qSWlCdE81?=
 =?utf-8?B?UGlWYm9sRXhyZHpaK002VUx0K0UxSUtmU3A2bUh4bGY4RmNFOHpBcndHUlpK?=
 =?utf-8?B?ekgzRHUxY2Z4ZXJycGpYQlE4RTFOai91dmpHbjZKcUtkV1BHVXpiN3hWazN2?=
 =?utf-8?B?Z003aVpna1hxMzdLdXRjdTJ4UXRQQSsvUkZJQ3VEVjZ6UWEycDY1eFlsRkdx?=
 =?utf-8?B?dEJjelFHc0Nra0JSQmRaT0FYajlORXZKeTJvL3cvZTVxK2lleEwyZ1JNTVRm?=
 =?utf-8?B?a1FUTFdpRWVxR1hnZjFqYlR4WmRYaENKZzBLYWZQYkFWbWpOcmI3TW50L0Np?=
 =?utf-8?B?c1Rwek91Z2w0Z1lYZEprWGVIV0RVaGl3NlZxcVAwSFQrWU5oM3A0eWk4UGll?=
 =?utf-8?B?MGhUam9sZTVERGg5NmJBUDN6MURNbnlNeFFPeDFQMEM0Q3NlRk5OaUpZTDZN?=
 =?utf-8?B?d1JSLzNwNzlpUmtwSExOam4wK1JIbzNHNGoxcTNHT01waXBCSjh2WnFiNXlo?=
 =?utf-8?B?RWxPbzRSMW1BN1hDK2dubnRqcC91Q2tlOVJFMnBTNmtnaHBLSkprZCs2RzRZ?=
 =?utf-8?B?ZFZCQk01UStwRjRVOUY5WElFKzRZMk84YzUwN0d3MFhzZnVmUnhhRWJKZXBE?=
 =?utf-8?B?bXRuczdJSGx4RkZWdE9Da2xvZm5lQ1BkYWNubnEzMTRwdlA1a3ZHeXhCdHo2?=
 =?utf-8?B?UUFZSk9obS9mSTdaZEh6YmtWc1Z4ZHlZNUdXVXZaNG8zSHllVFdvaDdiajdk?=
 =?utf-8?B?YTQ4LzVNUTA0cjRmUEdtNG8zVTFGVXF1ZjN3R3ZtRzdMdnY0dXhHODQ5VGc0?=
 =?utf-8?B?N1kvZjhhdXB6WHpqUzM3bnhhMkdvdStZbHVJNi9uQ0Z4bkY2TjNSdnRlRkpC?=
 =?utf-8?B?SDBZMktpNnNyQVUyMnB3aGc0TkZ1S1VXaEVEdWhDY3ByTkVzRkh4ZzREbUVR?=
 =?utf-8?B?UzJ2MFVDbGZOT0RZaDZQem1Ic2tEbE9vOHhDNFdFT0dMUWoyaEVFQTFBdnFF?=
 =?utf-8?B?SkFKWWxSekRnVG9tK29ZYlZmTUhQT21wVG50cGE2dlRkUmdOZWVzMnNSYnpy?=
 =?utf-8?B?SGFwNWRDd0diYnVvMjAzNHNwOEMzZkNtK2NFSlNkMTR2Y3JnMlVnN2ZXZFNW?=
 =?utf-8?B?SVIxRDZTYzNwYWVRTlRiWnkzZ3dHdVlwUUpKMm9BQjVLU2ZQa0kzZStMeUpo?=
 =?utf-8?B?WkVLamtNVU1uaFVQbUl2Z1UvVnVWWVBJUDA5UG56RlJ2dmlxUTVBTkQ5RUJE?=
 =?utf-8?B?bFo1OGoyWFpENnJBZFdkYmczd1dmQ2szdjZQU1JyRm1Ga3NiK3RhcGpvVW9h?=
 =?utf-8?B?cWRzOVZGcVMwaHNNU0NZaXllNVNLYlliT3VPaUZnTWNkdEF3TVl0MWFxZXJy?=
 =?utf-8?B?dThPTFNWTW11bkRaeHFra21vdE82Nm4wTE1wUHZreXlhZlBOZ0UrVWpOWUVM?=
 =?utf-8?B?amx5L2lLcTY2QTBCZnVvVE5tMmhmSHZJMEZqU0ZlM1FqdWhaek9jZmtaNHJZ?=
 =?utf-8?B?TnZtbDlKN01PWUwxbjBrSldjTlArUmZjNnlINUNUMEd2M2d0V2lNTSt6Y3E3?=
 =?utf-8?B?d2NvUWQwV2NDL3FzcmJDOUhuTVhaTkN4WU5xa3NESk41Q2JZWDlyWENEYy9C?=
 =?utf-8?B?cHdMNXJkN3FIckYxVzRJdmZMakRjZGFKL1g1ZXRUVVVCWUFlLzg5bUtqcnNX?=
 =?utf-8?B?MVNubTVVTTZERk9kbktKR2o3eCtFSVVNNzU4N1VGWGwyRytVMFg5L1AwOGVz?=
 =?utf-8?B?UjlDTjFPaUxVNzNaUit6ZjNSYnNSZmV1NGk0NFNVQXVnOEQ3VTdDcTZza2dE?=
 =?utf-8?Q?u9YCuO993HOkpzkS8wQGad+iMoiscyNl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elB5SUFtV2MxM1Z3Mnd3dEx5cVh6MjZQZGsyTVR5S0l6dERYMnBZb2IrdWxL?=
 =?utf-8?B?Y0F1TVdtaGxKcmlEZWlGZFg5M1ZMMllqZEtMSFk4RUV4Z0IvSURxVldXRktZ?=
 =?utf-8?B?UlQ1a0UxOURNMVBmUnlsMysySk1vWUFmbUJvVmgrcVdnSUVaemtRTlJiaW02?=
 =?utf-8?B?ei9uTWxnSFBkamVtbndCMnI5cW5lWXhSL1lBV29Td0RkQkdjZmVHMnVjMDFx?=
 =?utf-8?B?WitWMnk3b3lpb01xUFl4UjVXN1p5RG9pQU1zbDVZVW1EMys0NHgrMUFMUjkx?=
 =?utf-8?B?bGFINEU5WS9xejVTSnFMYUhmWCtjVmVyS1Znc1FoR2EyaEZPbExoYnc3RWk2?=
 =?utf-8?B?cG9mL0xkMkJsaldTSEhwZll6VlVqK2RjMTBBRFdKaXpFTXVENmVpZnpIck95?=
 =?utf-8?B?R2tIZEI1Zk13ZXppVmt1UEljWkVmRWdTSXVyRXNQRHFzbEZZZW5QVmZYNTFN?=
 =?utf-8?B?UTJubDkwekJFeWFsUS9pNzE2VU56VW5GeVpKNkMxSTIydHRpT2I2czFjWWZX?=
 =?utf-8?B?eno4VmtsaGZRNnRTTDd0Z1RMWTJlQjhtTG05YnBORHZ0dDRnb3ZyeUw2aFdu?=
 =?utf-8?B?Q285SU03dWVXYW1xbm1UTmh4cGVZSm5aY2ZpTTN0WkEyRVpneGdlQXA4RTlT?=
 =?utf-8?B?a0tsNlVtQk1zWWd3ZFdwRjFqOHhtOGVWYTNJNjNRaXoyTUFZM29PR2N6ZmU0?=
 =?utf-8?B?Rk5pYXg5RnpQSnNzdkZJbGg2R3kya0tjRG1QOGYyb2licXN5NUxjSGxNK1JO?=
 =?utf-8?B?bThxM1Q2ZzFXV2E0RDhaZUZMaDlmSjNnN25FZitDS3ZHUEliZit0a3VpR3Ju?=
 =?utf-8?B?UVgwaWliWlN0N2ZGK3dRQXdYOFB0czFRU1BKSzZrbHBnZG4wRmtyKzFMcTli?=
 =?utf-8?B?aFNmVDBsZnI1UkI5NnJPSkF0ZUZIWFB6UUNydEd5MXJ6ZUpoZnlBcVJKbWMz?=
 =?utf-8?B?dzJLNEQyRnd1dFFvK1RDaTRqMThVdGdDcy9vT3dONnhZVXF3MU1YZW95aTgv?=
 =?utf-8?B?YmlyTWxock5TT1AwUCtuaVpPSFhzYngwWVRYajUwdGovZ3dsMnQ1ZTNXVFVO?=
 =?utf-8?B?amdFRUR4NVJFbktSdEhiWjR6TEIxQTRlSmN6WCt6UTZVOU5SUng3b2hOTjVv?=
 =?utf-8?B?OTBLZXc4Ky9MQXBpaVQ5Y0s0QlhZaU5RdmgyZ2c5VjdPTUZFaks5R01aSyt5?=
 =?utf-8?B?VmE1c1dFa1VWQTNkYWpPVmhJejYzOThWS0diTGpkRWpkTVl6Um41cm1XR0J1?=
 =?utf-8?B?d002QUpLc05Mb1VwZmhsdTJUWFNOSU9BMVY5S1dQTWZ4ZjcrUlNsTzZEdk1X?=
 =?utf-8?B?cTJOMnp2VGJaU1BhVzVnaEtYY0padzd5cGQ5cS9MUFVUcEt4bTl3aGh6VTkr?=
 =?utf-8?B?eFczb2tyRzRYNUN0bnNPZ0xTTXNZTmo4bUxsdXArYWhrbExIMHNucm1xT1ND?=
 =?utf-8?B?Y0V5Y252N2Raaklla3Nxa0ZqcGhibEFlWkIwY014dzhWMDcvdDRpa2xGMGZY?=
 =?utf-8?B?SGFraWViV0pxTlQvUHBaR29FQVBCMjVMRGVXRFVqU0Qzc3lWSSs4K1d4TnM5?=
 =?utf-8?B?aWEveWtZU1duWlZlQzZlREJ3MHUxMWV6eVBndWduRTZLQ3ZxRElERURxV1hl?=
 =?utf-8?B?RmRxU1BVblZzK2krOVBlaGIvbE91ZU9QT0xwWHFwY2gvZlZRa1VsT0FGdUkx?=
 =?utf-8?B?ZE1zK3VSVW1XQXgvN0lvYVBOVWhPd1poem5kOXczQmVTODRZMzZ2SnM2SkpX?=
 =?utf-8?B?RStUMG9TRkdwSldFcjFxWDB3VHpsanNJV3pLSVRaOXNES2VGNHhKRnVWS0JP?=
 =?utf-8?B?dk1lVHlKSnlPWlRhRFY3ZnBJdGY4QVFHY2g1d2puM0VLbzE4cnZOTktrWHd3?=
 =?utf-8?B?bGdXQlk2WXVCWkRHc20rUUdwa2lDTThHdWZ5c1FOeE90T2FSSm5nM1I4V1Fx?=
 =?utf-8?B?Yjg2Zk8rNTVjM2cvek1YUTh1TTFrZ0RJbitjeHQ2bWZUcHkyWEtXNmNCRnV0?=
 =?utf-8?B?QTBVNlNsRG5IckQ5YXg5bGhxdW03V09qNGRlODluZTVYUGJXVU0wdm9vZHUr?=
 =?utf-8?B?eXV2amZUQ2VtK2tiam9ac0YzeXE0aTkzMUR1WWUvbzMwWXJzWUI0UERZVXZt?=
 =?utf-8?Q?aTpzvHVt4LdlqLzphTbXYVblP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149e6820-5f41-414d-88e4-08de2916eac9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:59:14.2312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdi4A2TaY6KzBnhHjERja/ZM3mammDKs1z6TNY6Or+Z+jCl7jwFKoa6Sq+iNW+In
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807
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

On 11/21/25 14:55, Rodrigo Siqueira wrote:
> This series addresses the issue of amdgpu reload failures in APUs. The
> first commit adds a GPU reset during unload time, and the second commit
> removes a specific fix for the Renoir device that becomes outdated with
> the first patch.
> 
> Changes since V4:
> - Add a code comment about PSP behavior.

Acked-by: Christian König <christian.koenig@amd.com> for the whole series.

> 
> Thanks
> Siqueira
> 
> Rodrigo Siqueira (2):
>   drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is reloaded
>   Revert "drm/amd: fix gfx hang on renoir in IGT reload test"
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 ----
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 

