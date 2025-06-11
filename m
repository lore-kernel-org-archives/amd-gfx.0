Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B7BC71134
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 06:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B84F510E376;
	Wed, 11 Jun 2025 06:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MDugLWJf";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB4F10E376
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 06:15:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhCFS3tuBqS6QHBpWhCvd1JIMecM4MBqOAtx5fGeYCQc5/DbiAH79rxbuQCS6F3TjeCT2NRRzk5iPEBG+O0cCrEox6EpTn249kV7YqlSd5IG7CjhrZlCozbccIOJ497ijdiPXoBHYF2Q3v/S3QxwbYhxRaGEm9utsqEg910/w0QMoKkNHaiGjUOa70iVvWR+S6NPspCK9jX1TOWJQhOMqIA5Q9HRlSU4X2pgT3iM7fco1mMFLvnYS/AyNHy26UjuBo9oaN9QGoml5YL9+Mgy2xAc5x6r1A1sbFmF5WB9sBPxwM3v1ztG/y6sSWQo0p1QzbAYsHXzXXWFpLZZuQz+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6nqFmpu5NCwGTB9GgSsOVwy2zJx6sGUIKyvIEtkHX0=;
 b=goER/9cyUSqUrGQMsVV7wUG0sE5pCTB5OIlPEQ770f0fN1yG8y/S0PF2uyhRT2hMI6pBXVHeb2CO6AO5ojY66X2VhFHMu+cTrKdKOJAZvUZgbMgJRbQwiDnqu4qlaEhSHHJSwsYN6ONph8HFQbws0FPRpm9H+H/xkNMLiR1lDc/Th0X22WhXaa+BS3+YfzMRl5a1dhz+b8C974aKT8fFe6EAbL/JbanTopduLkvqg1pj0uSpUGTUmMpBNDrCb6R3rnN0roo1DJDGB9p2/saWqvigzMzU1p8/zBZcUjRAWsWyOFfrJAHSgGKckoh8ccR5SSGUvLGU6dDzbsN9M4CDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6nqFmpu5NCwGTB9GgSsOVwy2zJx6sGUIKyvIEtkHX0=;
 b=MDugLWJf1v16iOR6FD/nNfIpXuFKExiR2U6HHK2aCP+NHw3Z6Vs/dFnEFq1FHv9lnzM7CeJrnnSJ7bzjS1swVwjk0TTbVB8qv7WMUnvvNZsc7YSoC5/ONQvtMhNbOEPHWwnqMT33qjMvd6Rc9V9m8NAsUqnsPrV88W2j/N/G3Ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 06:14:59 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8792.033; Wed, 11 Jun 2025
 06:14:59 +0000
Message-ID: <6dd9bb8a-cbe2-4428-b0bd-266ab706d83b@amd.com>
Date: Wed, 11 Jun 2025 11:44:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Implement instance ID remapping for
 harvested SDMA engines
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 jonathan.kim@amd.com, jiadong.zhu@amd.com
References: <20250611055604.3303818-1-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250611055604.3303818-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0112.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 204318ce-7f4c-45a0-2e83-08dda8af4b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmVYOERPZUsyb0tJS2pSNklxNFB0SVVkZUJSSm9vRDczZkNoN0Y2eW1KOVVO?=
 =?utf-8?B?V3d6L2NHMDFkQVd5anh6SjFtT0s3ZER4SWxmMFBjbzI5My9VQ3dZNUpOcWNo?=
 =?utf-8?B?OUdXYkdTNk5OZjlRRUxvTmFBNlZMaStrVWJPVVJ6clA4SCtncHJaVHcvSXE4?=
 =?utf-8?B?am5UV3JXSy9QekpHbnlWV09ycDc0alE4TkxPTFExZmYzREh6R2trN3N3QVZD?=
 =?utf-8?B?K2ZsdCtJNllBd1crbDJ5RzRmbTIzY2pCcHJyRUg3QWkydDllY1pERVdwVFd2?=
 =?utf-8?B?MDVvbmgwckNNTkViRTYrL0E2SFZqRXdaeUsyZlM2dzhxZWZOK0JZUU5JckxM?=
 =?utf-8?B?bk51YlM3ZHBaYWZvWHFOcmlkcjhGcC9LUytqR0xJeXFCR04rc09QdEV3b3Rt?=
 =?utf-8?B?VWp6R1Q4VkFISmZDaUxIdnkrR29LZ1AvRXMxRHY5TkRTNW9KTGNuZDh6cHJC?=
 =?utf-8?B?UE5yRGk2N0Rpd3dRUFhuMGZUNkIva0crOFI2L0dQSE55anp4NFM3WEl0Znov?=
 =?utf-8?B?TTVCM2hYUUNmMHFMc2cvK3lPdlFoWEVYREdTalpYcXZhZVh3SGN5bjUrMXJa?=
 =?utf-8?B?WmJzTGR3c0VORy9ncTRMak55ek1DMzF6RnFLM3p0NjEvRCtlM1huYVg2NXVt?=
 =?utf-8?B?cWtIeE9iKzBMeGgvTkRFWTI0Z0praVNmN29xbmFFcjdvbmU5Y0Zwc0YyQlV3?=
 =?utf-8?B?TlIwQjFrQThid1pQb1Ftc0RqVndrZitHQlhub3dGb2ZrT2w1K1BXQ3hWZXph?=
 =?utf-8?B?dnY4Zkwxa3NKMVJDNWxKc2oyWElxTDR6MVVBamJjNzB2QXVwQkNKaUxiOERF?=
 =?utf-8?B?N25CSEtQS2pReFpRTENseEpKdUdwV1JHQlpKV2wxT3djMk9raGtiR2VZb2lz?=
 =?utf-8?B?MTIzeUFvRDU1YUlmclRxSmV6Q2lFUU9KM3BYVVN4QzdwVE9URDE1MHBTNzht?=
 =?utf-8?B?YzZIaXViTFNmVW9IZWFTMWo3SE92NDB0NzRyb3MvUlZ6ZDBkNEpmV3J4OTZk?=
 =?utf-8?B?SnZQWGxZUEYzTEdwNGloZFpRakFjK1VJMkJxWTJ2R3hPVFdPU3Q2Wmx4VWlK?=
 =?utf-8?B?cnJpMjJ1M0I4NXNBWXRVTVNZOFNhcURxVzF3SWJrS0F4QkgxTUJ6VVJSMnpt?=
 =?utf-8?B?RkRQQ3BOOFIyV01xWUJUczVTWFZVTVFnWHR5WXR5VnhBd2pqY3hGVlpBNHAr?=
 =?utf-8?B?UEJvUXFmeHV5RjFybVVibzcyUS8zaUIrOWh6OE1ZMk42N2tRYWVCU3NuempS?=
 =?utf-8?B?OUxOcTFqalc1cjBDcWo5YmVBaEVqUHBURkJieklXWWFyTHQ0bVBMb3ZXemdJ?=
 =?utf-8?B?RkpFcG5qWlA1aUF0Q2RsM1dTSndqMmlaN1FvbEY3MzdRSVdLTklZR1JGSVg0?=
 =?utf-8?B?Rm5PQzZsL2JvNDlKVVJubkZwM25XNlhwV3F0WWxDNEZEWDVNSzNRZXMrT0pE?=
 =?utf-8?B?eDZydENmNlQ4Q1Fud2N3NEw1U01HTFpCRW9vcldHaEZ2Z1ZxcGNVS2FRNkRv?=
 =?utf-8?B?cTR5cHNhZVR2ZUptWGp1MFExUVFVWHRiVWJRQkF1ckpoeDl6K2xnRFRDRGlY?=
 =?utf-8?B?aENTcEJ0Uk1iTzZ1TW02MTVweW5LRnozQWdlZWRGdmdWdkU2TWFibjF5NXpk?=
 =?utf-8?B?ZitPVjB1WmFRK0x6YXF3QkxsY2xQYjAvVGtVVXNwNTkxcDFsY1dWTXd3N1Zz?=
 =?utf-8?B?RjJHZ2JRNlR1dWUxZjNVZ1E1LzhFZm9iTlhEYVVSWXI1MW1QNzZsbjNWK0dn?=
 =?utf-8?B?UXJ6WFMzYlJRNnlack1aTzFSaElBcFJaL3BQTkRKVFQzbW56cEtmUE1odGNi?=
 =?utf-8?B?VjF6N2NTUldlVWZBaFY5aTU0T0hNaU56S0Q3WmN6WnhacStza0JvUnVSdy9B?=
 =?utf-8?B?S2VkY1g4WDZGcUhFTkZKcXpNaHNuck55YkM1VFgwcXZJckNCM2w0ZEhUNDVk?=
 =?utf-8?Q?e2lcFyO2aaA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjZJZUVrMWFmQnBkbThVRFI1UE4rUlJBNVdOTUljNUpqQ1pmcGhaQnpwTDNX?=
 =?utf-8?B?c2J1SjdvcjNKNTlHcFVBZmVBWEJIWjR4YkFMMlJJa0tyWW54YmpvSmJhWE42?=
 =?utf-8?B?Mk1TOWdTZS9QRnJ4VlFycUpMbllpdjltQ3Rka3BBNDVPZmJhS3pKMGpWakVO?=
 =?utf-8?B?Yk54VzhuODVEcDQxWFE1VVpZdnhKdmpXajZpRWZlalVkVGcyWlQ4MTlUQkRV?=
 =?utf-8?B?Q3Aza2E0am9hOUdVd2xRMHNVT2pVR0ZqMGZaeWF2WUJUNncyeDN0Vm9hWWpB?=
 =?utf-8?B?ZTdHa1VWTHM4STRqT0dhRndEUHlkMXpUM1VYaWRDdlhYNlFlVlhUcUx0RVAy?=
 =?utf-8?B?enQvdEpMcDN3cm5PTkxPV09LMGtieUROZzk3VU5EL2NET3FrVnl2djQvSmxL?=
 =?utf-8?B?MTl6Y1VGY3hoYzdub09rYlFBUXY4Q25MVVpWNmg4S1luNmwwTkhMUkY0MUM3?=
 =?utf-8?B?c29iMWNMQTllUERHU2xpSHBmK1BWalJob3ZPOFBVT1l5UHdxaWR4YWlPaGxJ?=
 =?utf-8?B?WnQwNFRIZWRTMnl6S0R5R2ZQNHROZ3RoUHkrdjRQcTFuR0ZOTTBoam9NZGlR?=
 =?utf-8?B?bmpWZm9nTzFEc2tNVlFtcDlkUGVPbVE2OTNLZ3FnUnpreEJoOTRyQlJSdUpS?=
 =?utf-8?B?amM3NGJ5UTdTMjQ4dHJieGZ6UW4vRFJzaVE3WVFtREVuYm04R1YrTXVxNTg2?=
 =?utf-8?B?V1YxTks3YmVJRUZqcmZOeUdUbTVtRWRSSE9WSWlZSjF6dFVHd2d2TXhVdG5W?=
 =?utf-8?B?VUVtWTY0RjVaNmZPbjNWUEN4NnFFbFB1STR6KysxUHI4c1VDSG9XTWROZ2Fr?=
 =?utf-8?B?QS96d1BKMzJkMWtUSlZRM28wMHRDcmQ2U2FUV3VxbVJWU1U0Zkw0RG9ndlJh?=
 =?utf-8?B?QkgyN1FYWnlPMWFiZ2lLSW5NZ0oraGNTdmhjTUtNVzZLVXZQTUtXTmFHZndZ?=
 =?utf-8?B?MkZqR0ZCOExWSy9oSVhaZURPRzA2Zy8vV200QVNBbk40Wll6M0VaZEFsTjZz?=
 =?utf-8?B?czRvRGZXYVlDVkIvSFY5amd3SGkyODFMMnBoS1M5cm9LNldDTVhVdldrUFVV?=
 =?utf-8?B?MU1PL1Y2d283Y1UxdXduaG0wK0pmRUFrMDZSanZYVjFVeFVkaGNndzBwK0lL?=
 =?utf-8?B?TlRGYjJWMW1oeklhNW9hNXlJVUR2NmFHU0NjdkdDdDZaa2t3UUU0TWFFdDhx?=
 =?utf-8?B?d3I2dmMzbDU4UFEyVHUzTlhpQndHNUJGUFJST01hd2RHQnVVdFh5cEcvL1ln?=
 =?utf-8?B?WEdHSk1PTUozMndFd3pYbjkvNUtMZXd6RXhVOEMxZmMvbkN2V0RaMTRXTFo5?=
 =?utf-8?B?SG8yMXRFL01LeS9MVEk0MnpoKzRsVStpSnM5ZnpzZFd5M2c0Z1haSDk0R2xk?=
 =?utf-8?B?TUlBcm5hZFdrWWlESWdjRzA0a05hV1d4Sm9oMXY1U2pRb09rdGNRc0NKMmNU?=
 =?utf-8?B?RDd2R3ZlVW1ia1RSaXd2VzVOYkNreXpiVnRaVmFLS0tPcWc1cDlNRkwxS2E3?=
 =?utf-8?B?V2RHeDVqakFsdnRDUWZPKzJ2dWVLaFdUUi93ck5Ec3pETno1WWFwcllsZEVN?=
 =?utf-8?B?di9nclBvUjExRW53T2VJbmZ5cG9hMnhNWVVldHVVK0c5ZE8zY3M2QkxLOHBR?=
 =?utf-8?B?MTQ2c1dmN1FpRXptQlF3UXNIUWVQbXRDaS9zcXpybkVTVnhHeE40d3U2Mnky?=
 =?utf-8?B?TUVuYWhOaXA2Tmxza3ZLQkpBa1BQdjZBL0l0V29Uem4xKzBoSXBJbU5yQnJG?=
 =?utf-8?B?ckpkNTB6L3lYNGZVZ0FWVXFNYTFsN041ek1YMWFiT0pKMWt2TUxnV0lkMkNN?=
 =?utf-8?B?dnE4UXkvYUZCZS82UWl4UHpLNFVJd1p0VWZMWGZtNDNjYTJ3Zk04RVZIT012?=
 =?utf-8?B?c2syZWxVdmFsaHhaaU1tOVBqRlBjc0VMcEZPb2pGQjRhUXJ2NGZ6SG1WY1Vl?=
 =?utf-8?B?RDZBQmMvTFVtaFdGU3JvUWVCZ24yaTk4Z3hER1VnblhXYVRWUDFFTk4zNU9S?=
 =?utf-8?B?cmZyMVpsRFprTlNWQllxNkwyK3hYYlFHY2EweUlsL0lyOUdPMEpVR2VQOU4z?=
 =?utf-8?B?Mmg0ZmFqN1ZMM1JaYm14ajNoZkkzc0ZESDladDBQVnhKenc2alRXRWR1cldE?=
 =?utf-8?Q?2zS6SpbXpagLOQDSHUMPWpcAR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204318ce-7f4c-45a0-2e83-08dda8af4b52
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 06:14:59.4433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r23kgILVCDhLf+NJnoVEFq2pKTudl3gtB8WHEsZovhlI+bx79gCPBWQTOEsh6Jhq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147
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



On 6/11/2025 11:26 AM, Jesse Zhang wrote:
> Adds logic to handle instance ID conversion during SDMA engine reset
> when harvest_config is active. This ensures correct physical engine
> addressing when some SDMA instances are harvested.
> 
> Changes include:
> 1. Added instance ID remapping using GET_INST macro when harvest_config
>    is non-zero
> 2. Conversion happens before engine reset procedure begins
> 3. Maintains existing reset flow for non-harvested configurations
> 
> This fixes hardware initialization issues on devices with harvested
> SDMA instances where the logical instance IDs don't match physical
> hardware mapping.
> 

This shouldn't be required. Without harvest-awareness, driver won't load
properly on MI308.

Thanks,
Lijo

> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index a0e9bf9b2710..4282f60a0cef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -759,6 +759,7 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
>  				~(1U << harvest_info->list[i].number_instance);
>  			break;
>  		case SDMA0_HWID:
> +			adev->sdma.harvest_config |= (1U << harvest_info->list[i].number_instance);
>  			adev->sdma.sdma_mask &=
>  				~(1U << harvest_info->list[i].number_instance);
>  			break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 6716ac281c49..0bfd2c138d24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -581,6 +581,9 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
>  	bool gfx_sched_stopped = false, page_sched_stopped = false;
>  
>  	mutex_lock(&sdma_instance->engine_reset_mutex);
> +
> +	if (adev->sdma.harvest_config)
> +		instance_id = GET_INST(SDMA0, instance_id);
>  	/* Stop the scheduler's work queue for the GFX and page rings if they are running.
>  	* This ensures that no new tasks are submitted to the queues while
>  	* the reset is in progress.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index e5f8951bbb6f..fed00854a1a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -123,6 +123,7 @@ struct amdgpu_sdma {
>  
>  	int			num_instances;
>  	uint32_t 		sdma_mask;
> +	uint32_t		harvest_config;
>  	int			num_inst_per_aid;
>  	uint32_t                    srbm_soft_reset;
>  	bool			has_page_queue;

