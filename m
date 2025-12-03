Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CD0D15D88
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 15:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0DF10E7F9;
	Wed,  3 Dec 2025 15:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ADDY1KlT";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E13B10E7F9
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 15:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMUpyGLAiTm+9TP8VXvh20hZoRnWDH8Anh68u1v/CX+c46uGtxeycv9phtbre3aMpqJhMskA/R53QJnK30EwolllJfmcnjf8ONUKx4Kl22wwmh4BY1ZN5e0k9loNFXH4BwlnEEWSlq1TnoiGMTnHW6HwsZydNUgALRmcQHqK8kPgWzROgG1jn+3Xc/NJr91GVhunDYraiOglfPukDc5EHQfp7+A9MFeer9f4JV8ivTaOEZByC3+Ud364pt8TFNEqMtLRkTgU7PMotpJeMhvJm+UEhc/78lTL6pt4lzPpsHDpCiVTqLV+lLYwwGG3b8fqMx/3Hp5wruzQan+jHq1LCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngwFdH7Qbsqhf5DfoVOmvO4eW7j17p8cqmSucvH3ddk=;
 b=qj3gduqyqCss1niEgKBuWwkMqf7704C0xmyUSAJ1OkyD98D0419J8nocNc5mvxGjN7RVE631JIK/ni1hWsLbnC27AJeKTPH+QnGC5b9hSRZ3nmQ1uhULuDH980KeEkqbDH29dqEta213U9B8fIdaYWw/ktdaWYbXS82ApdCcuDvuZokKYOGRj4NQ1AQjZD0PlkTQIea118q/u0ydFww9LGBVebXoONBBn0l4nDohEqopuBcPKWUNfL45X/pE5bAnSM1kQdFBdjC/Gava6TUH3rz5ECZ4mzDA7Gmkv0tbxoLCMs8TrmXaAWCr+We4GwY5+WWliy/ZONePw/AAqmm6IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngwFdH7Qbsqhf5DfoVOmvO4eW7j17p8cqmSucvH3ddk=;
 b=ADDY1KlTHdiui9X4jqLmudJ+s/2sObRbYYE1sPSEg03BkPC0I0zOXIu7YLLvzEK5MAWSnfyi0xVIVIB8nNfXSI34OvCuZZejOoL9XjP6vEuD6H+3a9kpOKHQGJvCJlqyQUA6JErtW9rVacH5V0cpIKWauti7GYdU1qjt9kQdz5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 15:52:08 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 15:52:07 +0000
Message-ID: <a5a6dc6c-0e91-46ac-a33a-ea556a05189e@amd.com>
Date: Wed, 3 Dec 2025 10:52:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] drm/amdkfd: Move gfx9 MQD to HBM
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, david.yatsin@amd.com
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20251201142838.1516452-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::12) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: a543104e-447e-44d6-b976-08de3283e991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmNRUmROTVFKWE5TYlpjN3M1dW9RaEQyNFFLT1A4RkNjWjViT09uSDZtY2ZK?=
 =?utf-8?B?cFdiV1FTbGJQOVh2bTQ1Y3NHWEVrMlozc0cyRUV0YUN0YUFmZ0FjcFBDQ1JG?=
 =?utf-8?B?R0Vhdnp2OVNNRHRaTE95eWlZeWFzS2Vlby8weEw2U1lpWjlkbVJMTFVydDFG?=
 =?utf-8?B?MEtPZ08wY2RyM24vdlRzOElnMmFZN2JqQmgzNit5bUI0RGVjUFd1MCsxdkgw?=
 =?utf-8?B?U0ExOU5pcDRYY0Vxa05ybXhrYjhHOW1pVnV3QmUvUDRDU3pMeEozQXVpa0p0?=
 =?utf-8?B?N3VxV3o0bFlnNGVoRi96ZGdyN0lsM2RYMUg5MHZ2NThRMEIrK285QlAycFhE?=
 =?utf-8?B?OWlianVBRlZFMGNKUm8wUkdSRjZLMUZoZHgwT0NRN1czeWwrQXF5VTlmTG5h?=
 =?utf-8?B?bm1FYTVuQ08yYXBnc0tpN0dFTlNkK243b2hlOTk1U0JJQnh6ZjZBd01yTHNw?=
 =?utf-8?B?Wkd0bEpMYTNaWkRoRnBoZFBHbUd4WWJWdTJnUXMyZitSYkJXMUtyY1ZBTWg2?=
 =?utf-8?B?dkJNbVd1a0lKMkNPWGdmYTgyN2t1dkl1MUp0ZXVQckt1OWRDZ3k5YVBwVzU2?=
 =?utf-8?B?S2hHcDMrQlBLV2lTd2RKU2ZVdXRDYTVETldSdWJsSHd6dlhEd1MzOUxDSk5D?=
 =?utf-8?B?UlZvNjNXVmZ4aml2Qi83Wm1tRXJKZ2NOempBQXpkRVVQdUw3dmoxelUxTmd0?=
 =?utf-8?B?ZVlPV2srZEwyTDJIU1c1cFB6VTB1WFdCUmxEMVAyY0pteEo3YVk2QjRwelV2?=
 =?utf-8?B?dDBHc2tPeXJqYllqc3JZUWsyZlhXcmw3Q0YrenhJbWQzU2hkenhKVFJZV2py?=
 =?utf-8?B?eWJPcG9qdU1wUDRGVWpkcDB6T2Rsb21PT0xUNFlYclk3WERORFdVNG9FSHhm?=
 =?utf-8?B?NS8xZzN3UzJNY3FUY2VZeGFTZWpPdzFmSzJmeDhuL250NDdOR3hxUTlYMWV2?=
 =?utf-8?B?TVFhRkRzMHlIdU1VL0RicmV6aXZNYmNSdG1QRDJvSjM5aXludGN3dUkrNUZr?=
 =?utf-8?B?dmpNYmlnN3IrVi9Pd3RqRE9UbTV1aG00VEJJUHlGNHFhUFhNMWhNRzZNeTZs?=
 =?utf-8?B?ZEJ1bGRTSWhHRkhlbENKUUF2bU9WYUJsVVQ5MG1naU1JWE5OaWFhNjFESFlF?=
 =?utf-8?B?ZkRoTWhDVjFObGhBTW5CVWpiOVJqUXdiK29xRUhBZmZNT090VlRHb2h6KzNW?=
 =?utf-8?B?WFI3Wnl4Ulk4SHYxV1E3dmlrVUgzTFRwczk4MnlhZ3ZRcDQ3SUR1RWk1SFpW?=
 =?utf-8?B?YWZMYlpERG9FaWJFalhUL2dFeHQ5OWVjcVNNQ2xQam5FS3RMVmZ3SndSakhp?=
 =?utf-8?B?RlZzalFsZWpHN1c4ek5pNCtRbWlIbThFWU93THUySE9wRXdKYTcveE9DZnIx?=
 =?utf-8?B?UFU5UkI2ZVpJSFh0MlJweXR2c2QyZGVpanZrTVYrdVI4V2RXZzlpUEtHYmNV?=
 =?utf-8?B?dGV1bG45RlN3Rk15aGtGUGpnVklWMTNZUW8zYVpEdWpQYzRhRzd1NXlvSGZZ?=
 =?utf-8?B?WUdUdm13Si9KK2JqNFVoWEI3TmlrVGpPN09xMFRwMEUySnRCT3JjV2xVWlZR?=
 =?utf-8?B?VS92V2dDbEVHbWp5WTg4dHFHajJzMkdqTHcvUHA3dmN2WEw2K1RkNFhMaVQ1?=
 =?utf-8?B?RStPS2ZlMDJOZzhzQzRDYVpyQUtFQUgvQWpPSlIvM2E0K1dwb0s2cGd4aTNX?=
 =?utf-8?B?L1hPQlhQeXVZS0R2d2U2elQvdEEzc3AvaDZTVTJ2aFJWWk9SK2RWL1dxTm1y?=
 =?utf-8?B?Q1hib2l4TGkrN3ljTm55ZEwyN3RZOEVhOHpUTlVoZGlHS01KbTJySFJQbEVZ?=
 =?utf-8?B?VWxmUzc1ZzZWUEFNdWtoNDY4c3owN0NIV01pVjkvNzRGZ3RLQlZ6SW50Q3B1?=
 =?utf-8?B?UGxYN0liaEJYa0V2WFVtTk4xR3BTbTU0K2Y5U1dGWDgvMVZBV1NjTEtlaEsw?=
 =?utf-8?Q?DIbxetiu/n0AJOo5bijz2klGxgxZ7xg9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emhhVUxLeEs5a2I5ejd1b0VFbjNXN2VjNk1DUUZUSFhtVTYwblA2YkJIS0lz?=
 =?utf-8?B?bmtVUUFCVWp4WWZqZ3ozRlV4RnR0N2tYV1NZYlBFcEprWDRvekxHUEd2YUxp?=
 =?utf-8?B?WWx6R0x4Qm5td2NRTnhoYVNkbEhJTzRtRzNpN2l4TlhyU0taSmpYQi9xdnRY?=
 =?utf-8?B?WU51RXFta0piNDhpdGwyb2JiVGthTVBBcmo2d1pWSFJ6bHJtc3piVnlKMTdl?=
 =?utf-8?B?bDhueUtNYndoTkZBZjNaY3hkQjhVSUUwL2VvOGhQb005NC9jcU1lZ3dGaS9W?=
 =?utf-8?B?YjBtbFg1S1JGQzFGaDJWQ016aHpDMGJ6UVE1bGEvajN5Zm9yN3Z0emw2MlVW?=
 =?utf-8?B?bEtoZDZvR1ZzMlR5aFMxQW5WTnlKazN4ZkJlR25Ldi9ieFUzY2FFZTdERVVM?=
 =?utf-8?B?S2cyL2d1Tm02dHRPdC9xZzZDVWliRFdSMldtdG1mTVVubWZwY212Rm1MaXRl?=
 =?utf-8?B?SGNQUytzc0xidHpRS3ZPQ1RzZTJ5TUZvajRpbmF3U1dlUFdhV0s5K0d1Z0Yz?=
 =?utf-8?B?dE5BVWsxN2FubThyQkJMQUYxclpING10UGNGSUNlbTVXYm5nWDFXU0Z0WEpa?=
 =?utf-8?B?MVdkODI3Q08yNmFmNjdVR0RSbjhwMENsRWptMzZBRzhKVWVnakRmbnBxUjZx?=
 =?utf-8?B?VjZaVFNmZlc0WEFuOHYreks3WXhvbktueFQ1aDRsbVpYNzVsdENqamJkaWky?=
 =?utf-8?B?NTRRQVZ0SWZ6U1VDakV4YnVENW9ndkRYRzJyRE00aHVHNTNHa0dBdzZMWUsx?=
 =?utf-8?B?Rm1xTGxyRzBkUHdMR1ZJdGtyRXdaZ1RqYmZUdkxQUWgyOFB5bVpzbjZ1eTFM?=
 =?utf-8?B?QUhOK0pxL0Y0VU96Y200eU5VaUVDNmRvczdtcUdpV2ZWSkYyTWlyRklReWl3?=
 =?utf-8?B?WHdiM0JxWmcyeU1UZW5TbDBOWUZURllIdnE4eGNzYkgzemFyeVR0c3FMek1z?=
 =?utf-8?B?WERaRzZ3OGtDNXdLQ2dnUWlJMWVWNEJFZ0lldE84UnlpZjBGVjYvODB5WUEv?=
 =?utf-8?B?eGd0N3NTclRSS2JVNFIxVWMvMXBERzNza1lyU1ZMQndDMHM5V0lyQnhOQlM5?=
 =?utf-8?B?aVZSQWZOUnhBMWRMcHcyTXZzaFAvV0sxQlhRQjQ0MXpFR3RYQ05IOCt6QmdU?=
 =?utf-8?B?QjhNeXZ3NU5QdFJKS1NXSmNCT0NwMDJNREdJQ0I0QXNBTHFndU5BaTJTQzhN?=
 =?utf-8?B?RzE4TExOMlZObExHQU1leUVoZ1hpdUpvT1p0SVdlREVGaEtJcFMxaWFnTXp4?=
 =?utf-8?B?aHRVeXBJS2FuMkd5VXFxSytNbU5kclBqL0xtVjYveko4MUk2ZDNXV25lakI2?=
 =?utf-8?B?UVBab2RKVlBsYkx2ZEtnSlQvODRGaVVvV0V3c2dtVW9Cc1dzdmZ5S0NTK2x0?=
 =?utf-8?B?QTJhMmdFcDBsU0NUZzdTNjdxZDNpSk01UDl3bHlPekxXSVNKSG00OW81MmFn?=
 =?utf-8?B?TUVFeCtKMFpKTUxSN2VQK283b1Vja1MxVTdRWGZ6RDBQMGc2OXd5SEFkSENJ?=
 =?utf-8?B?TVZDcHdZUytzTjZ5czlpazliQ1pFOFdjdTZvOGJnNGRCWmxHc3JVVGZQbndo?=
 =?utf-8?B?V2pVc2taNm1Xa2dGdUNoN3FRVE1UYmtIbkMzLzJxUVR2T3lpU3VHeUVEb3RB?=
 =?utf-8?B?WHVOMllDL2I5blplN1R2L2tFVnFqVlBxOEVHd2FTeGVhZUE4QUZndzVzY3Ry?=
 =?utf-8?B?cit2dXgxYm1laTFEazk5czN2OHFTSUFoV0h3L2JNeVUzdW94TitVTThXT2pJ?=
 =?utf-8?B?bFFIVi9qZ3pRZXU0K3NEblhtUTNuZnZyTlh2QThUNGtrNXdUWmM3YlYwWSti?=
 =?utf-8?B?Yjd2cjJBcWlGWHp6QzFvQnhpdjJVRE9Xc0Z6NlVyVzNja29US2dHYmxxVXh2?=
 =?utf-8?B?bktQNHN0bjk5Q1Zjb1p6WHJpUWFRMGJTbUo2U3FmME5QNSs3UzAwRm16alA3?=
 =?utf-8?B?RVNhVVpXam1wRVhGMTRFRUlqbzluQ3FoY3c1dUFhK3ExRmtPU09RL1ZxcjJ6?=
 =?utf-8?B?cGRxSUNDMHc5V1BsUjJ4d3RLTGYzUGlQcExCbFR2SWpxSnp1QUVpVVNkeDhj?=
 =?utf-8?B?RTU1S0JRTDZ5N0E3N09JVXJJS2Z3TTNJZnNFTlNUN0tpbmYzUUFnU0ZrRWV5?=
 =?utf-8?Q?i5VU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a543104e-447e-44d6-b976-08de3283e991
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 15:52:07.5830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMd3B5BLs3EF9hY9RgtGTIS7cBmCAkVrQj14dhVUCz5nOUS21EgmpOXXiii24KuW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083
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

ping...

On 2025-12-01 09:28, Philip Yang wrote:
> To reduce multiple queues switch latency, move user queues MQD to HBM,
> and map on GART with mtype RW.
>
> v2: patch 4 GART mapping use MC address, vram_base_offset + physical address
>
> Philip Yang (4):
>    drm/amdkfd: Bind gfx9 MQD in GART with mtype RW
>    drm/amdkfd: Add domain parameter to alloc kernel BO
>    drm/amdkfd: Move gfx9 MQD to VRAM domain
>    drm/amdkfd: Map VRAM MQD on GART
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   9 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 115 +++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   3 +-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |   1 +
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   9 ++
>   .../amd/amdkfd/kfd_process_queue_manager.c    |   2 +
>   12 files changed, 124 insertions(+), 24 deletions(-)
>

