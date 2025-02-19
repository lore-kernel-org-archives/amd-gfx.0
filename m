Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09F0C021BB
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 09:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1495B10E7B8;
	Wed, 19 Feb 2025 09:32:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l3samM3f";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FA110E7DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 09:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uq//Sh7xo8zoP0/eWbznJhaqRnlm+A3dLlThQF3ifOKvYZGoWqc0a6pBqsTh/9hzNfi22ksQtYZRpPAE0WyvsqjwdXZpWTi+CNWPWyzXhV+KsK603/R45L/2YQHGhog9pFKVSyAJCRheslRFkv54it1QGvly1TsrXlT4xA5cEzOEfUY4ktnydv4QxsKReX/KxArahoUIdM3ZtvAbmyUWCMDc1jGR9PdDZ6fOWrV+6TB17kA7pdmTjnVLxDL0ckCcv44EvXiAMb7jDqvTNK6Q75xW+NfmZO+t3Sej7QA2aoLUGk6t29WZFjtezGphTBiRzYQkmHzM+TnpC9l3lEoKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4OnoZALbnfO80xPE28QXWQYWAG9M4nCBAQZh42VIDw=;
 b=CGtbQgj5jrTAsrzMrlj30112/HfC00hIqqymaoun4kJfbw2eKJGd87Xh3Xsf7VMzJzAyetXT/so/AOeW3yiX/W/rRL3VZUe4J/fJFKUDxhTzL1cBzryPGmqQ79IQ/n6OJozNf85cISZOy4jZ9MxgFEUJrXd5dDZYSWgUUKWUAL2DRgbLw2fWxdxP+rQeEzNw+o/R9Bbweq8dM0I2v88/u0APiBAhRNuCkz6VNf9gFc+LV8ShcWQ4Ptf/mW9jflbQNp6PhOoDz6xC0K89pw9KzFbkjcPz110Icw+IDvEC1Ctnd/ua1HWIxJZmLOfc+suYVtEJiOALUoJFAeCeYqueFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4OnoZALbnfO80xPE28QXWQYWAG9M4nCBAQZh42VIDw=;
 b=l3samM3f6pKrVgydjDf8bY5qYyAZpjzbDRHyqUiIyFW/cdYuOHRPVZnQGEO1xDIKCvE3Q1jN1v27N5YNbdu7Q+31WvwRRLZSEsNUAesIz0Hjr2pssf6hm208375Ufp2Th6L0ILx/J6Y6+7Bw0Y1l/n7Ab11Ym6gemt/3d7rRYjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 19 Feb
 2025 09:32:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 09:32:08 +0000
Message-ID: <1d8c9b4e-60d3-4425-a1cd-9785f4b9c0af@amd.com>
Date: Wed, 19 Feb 2025 10:32:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Optimize VM invalidation engine
 allocation and synchronize GPU TLB flush
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250219062046.3530422-1-jesse.zhang@amd.com>
 <20250219062046.3530422-2-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250219062046.3530422-2-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 475479b8-e5cb-448b-45ec-08dd50c847bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVBXOVdnTmFYMzRJWWJNYlhKYVFPNEFJWmcreXU1RXJrUDNRMVI5bXN5dzdv?=
 =?utf-8?B?V0xUZFduL0lITHlPdVd2SFFzU2tOYjEwK1gxNFpUNDlpK3pDUEY3eWNJOHBY?=
 =?utf-8?B?RG0vbkl3bDYvM015bCtBTlJJYkh5VzErb0drVTRJaTFoNWhhb2JReDVZRHpO?=
 =?utf-8?B?N3FxSFhzYUxRTktYTFFGQ3VjQStNVGMrUFN6SXhJOTlDQzdrQVREU1B1UDNK?=
 =?utf-8?B?d1llTHRmVThGbVB1UU9tSnlCQVJyVSs0azVrRjllU3RvSUxRaGFiSmpFSWRS?=
 =?utf-8?B?RDNkSmsrUytEY0NGY2xSWUZXaUg5RHFXZzFUb3hWQ2ZpS2Z3ekhIMHlvejBr?=
 =?utf-8?B?UVE2cFppQ0ZET2FiNEI1YzhWenpEY0lPV0JXOHN1bmgwWGp1cUM3cmUwaysx?=
 =?utf-8?B?MkFCQkR3bnJyREJyZDcrdEFtcFRZNmhTMWtrbEt1dVZHRXlwMlR2NHhORnRx?=
 =?utf-8?B?aFlRZmRZQmUxa0xxYkFVRkpYZDZMaEhPK2RRcEhXcHhaRE00dHpwZTVoditU?=
 =?utf-8?B?OUhzQkRseFBBUm8veTVDcklGU0l1Y3ZWbXZETGk5ekpUVGIycW5YRVV2a3pJ?=
 =?utf-8?B?R1pJOC9CbStCTzQrSGJ5NVBkOVZPV3FLZ0JDbEUzMkZmdGJzZWsxQ1JHclNn?=
 =?utf-8?B?ME14aXBCc2llb2RhWlFBU241VXAzcFRGODRlR0NwcTI5eTZkdXZzblc0THAy?=
 =?utf-8?B?c1VCaHIxaDVVVFJxV1NxendNY2M1aDJIMHJUWlRCZnJNcks5ZmVXMkVTWUNJ?=
 =?utf-8?B?enRyVzV6MFBKK2VEL0dqc3dpV2lTRHAwZ0NqdmhrcmJzcTMrL1dSUm1pTHZQ?=
 =?utf-8?B?Y1BsSWFYTnBpSjFXeERLZTQ1Z1RSaEd6MzlpN2FSMzRaNDMvRWZpcWNPOFFG?=
 =?utf-8?B?b2JTK3dqTDh6MUlyQWF2WHZpR2JwWTl6QU5NK0RSN3lOeWduenNuaHZuUjJB?=
 =?utf-8?B?YXE1QlpMNXU5UytvdEdQZVI0eG5PRWpMVVBwc012Q204L2wwa3V6RVBZNG40?=
 =?utf-8?B?ZUc4U1pEVENFdUJuUXZYTGhKb1NJRElRcGdRd1QrNDNlcjZPcG5YOU1kUUxR?=
 =?utf-8?B?Mjh5dmxPTUVrczM4cTdiWmxzMGFVdnhzNFNtVzFOUkNWbGdMbTV3c1V5Nkpi?=
 =?utf-8?B?bGFicWpzUWc4RzRqcjlWNy9vYUc4ZmNxN0lYZXhsMkZVSWVIRWNiMzhHY040?=
 =?utf-8?B?MGt6M0xQeldsRVc0YTcvTlNCUUZKS0t0b2ljR1R4ZHQ0cWZUWlFqWWI3QW9p?=
 =?utf-8?B?aG9aZm5BNEYzZ3dQREVKcU44Y0Npa3UyTk1kdjNwWlNpeXBrUWNOc3hqWmlL?=
 =?utf-8?B?K0ZpRk1jdGxRUldYRWQzenNwZ3BvVmVqRldQSlVuR0NKbmNqVG5HWlRIRitP?=
 =?utf-8?B?MWNNdGxhd0FEdkNUZGJ0dDNCc0I5ek5Bb1ZYTGJDVnpmNXFncVV4TUlNVDB0?=
 =?utf-8?B?c0RWQ3ZoUDdERjBWeGZ2QVcxSnZhTGtBRDBPUmFnbmtMWXBGMmdnRVRFc3cr?=
 =?utf-8?B?Zng5SWo5Njg5STNIeFVhc1Vva3U1RHQ2enZGYmJIM2lvUEhvN3oySG9MNEor?=
 =?utf-8?B?cHc3MDVKWStMVkNmSUlUenAyY2F4RWNVb0IrZG5SMDlCWHNWTnlHb1J0VDE1?=
 =?utf-8?B?SmlYaXZRemwxUVJqVENaRkNla1dmR092bExlZkhxVXlkVTF1NXBzQmJsODBt?=
 =?utf-8?B?V2twdnNNaGFSbTd6LzRPYTJqWjhpU1RxTnlxMytwR2NOeFB2dEFobm94YmlN?=
 =?utf-8?B?bC9odE5oK2NJM0h6Zk9wRmVmNG9GU3hMWHJaeDUwYng4eFM2ZTVxc1FiZnJV?=
 =?utf-8?B?NC9hbWZ0N0NwQWVnZDlPb0daNWNNbVRJTmhZd1ROcUNMczQ1MTJqcjcrZk9q?=
 =?utf-8?Q?8I4lELRm1apvK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDEySHdaSW9aeUlBU1lFaHFUTm0yS0hvYnRDNFY0R0JlcWJRTVBYanBERjRW?=
 =?utf-8?B?S0NBTVRvbWFIOUxmRU54aWFIc245U1J4TjRFOE1sc3dYN2JJZVI1YXhDS1lU?=
 =?utf-8?B?eWQ5WWxRWmN0TG95QkluL2hYZUc1WnJBR0M5TXpuZXFHeHRFVEFyYjlXT0xv?=
 =?utf-8?B?eWMwK1VRZ3R3dkkvdjN4TE4yam5Bdm1LSnlxU0oxU0FyMHNCcHB6YWNxUkJP?=
 =?utf-8?B?dXB6S29KdVc5bVhLaEkyMnE5emFpS0pMTklsZE5MYzlDbjNLbHZnT0VnY1Rz?=
 =?utf-8?B?OElmQkpnV2JvbE9xcVlXWVhHeHJqaHI4L2Y0YjQwTy83eWtla0pRbVBtTVE5?=
 =?utf-8?B?ck95cnJsY1h5amZkc1YwOE80bzgyTTJ2bUphb1VZdGtRR3l1cHJicC9kR2g2?=
 =?utf-8?B?cGhCRlVaTFIvSVVqejVsYmIvVVNSYzUzYlU0NjhyRVl6U2RXbEpKaUxKT2Q5?=
 =?utf-8?B?cDJ3VVBIYy9CUzN4Z2VsU05qdzF5YndMaysyRTBaeTZBMGFtVXY5dzRXa21O?=
 =?utf-8?B?SDg0aExub1c5OWVjSmNEbi83Z3F0N3hiQ1YrVDA4UjB5d0tJV3Jza096ek5N?=
 =?utf-8?B?dktGSGdZRUxQR0Niazc0eGUzWTJCMnBnZHFvaHhKaWd1aEtyTmhlZXArV2Zm?=
 =?utf-8?B?YXpQTnJFdEVtMldPcldiRjhJVDlJK2dUa1VSRzJtcTRVMkpHNEpPbnV2R2xB?=
 =?utf-8?B?Zi84RThLYjBDaEdzRmFZVXpRS3pPTVNtNTNwb0owNmFHTmtHNXRObVlPSUlZ?=
 =?utf-8?B?VGplMzR0ZlBlWmE3cDZHMkpUQ1JKNVAvaUp4U3RrMkZoN0x4eENTODJBZlhK?=
 =?utf-8?B?K3dDWE9IUEo2ZTRvK2tkbUVjMVhYVU9BVmJiei9pV1RrWVIvdU8yY2tJZ2Rk?=
 =?utf-8?B?TUFENkFJM0czRTNxQWZjUUxmcXpzZHJTZTkxZWd0b3N5YldzUXN4WVJiMy9z?=
 =?utf-8?B?VDBSN0FabUF2SjR5VjA4S0dNVlZBY3U0eWw1ZEZrNllkZjRZekRQME03aFAy?=
 =?utf-8?B?NEJPNVJnMFdpNkxESElNam9rWDJaZTF6R2FOamF0ZFRNclU5Q1FDdHJxend0?=
 =?utf-8?B?Wk5xQzRuUzB6b1NjZUhVVDFyaEgrWFh6VnJZaE9wZmY1REFPVTdEQUxxYlR2?=
 =?utf-8?B?NUo1WXcxNW9wTzlmRkc3V3ZhQnJlaVBrUTgxZHNkS0pURTBNRzkyR3IvWE5P?=
 =?utf-8?B?WFNpUk5UcW1VWUE2OTY0OHFMNURQN081NWlBZW5sTmN4ckovOXlIUldBT1Fo?=
 =?utf-8?B?c1lGZU5vRFFnR0ZaZW1FSERXVDF6ZWJQTnE2SW1uVkNnOFhzamdhQkttS1hU?=
 =?utf-8?B?K0pCTWIwODRNMjcwYm9RWVIydS84SXRGTi9rVHk0cTY5YU5hVk8yUm9NTWJF?=
 =?utf-8?B?RXArekFrSnJYNitqMTlTaVhIbm1URzVVdSs3OEdvSjdjRHkzaTQ2UGR6SDla?=
 =?utf-8?B?QmEwNWdLbFlJQUdxNEp3NGVJQ3QvZzludDdBNUQyeCtxVG0yZVdPOXQ1SXVW?=
 =?utf-8?B?cFlkb2JxaEkvWjlBN3kzU2JlNXR6VHl5cGhaOFYxQ1JHRysyMTZRZEtKbTZi?=
 =?utf-8?B?YVFFdnp3Z3V5YVl6RGpBNEFYOUtHRmxMQ0tFZ0FtSDAzYStjSHFYUVVmMFVS?=
 =?utf-8?B?eEtvby80KzFNbEJndzJLL3ZXWUI4NWZ2bk5UMW96a1dUdEZ6UGh0SzhLS2dN?=
 =?utf-8?B?THFZMGVSWXRWdksydnYwYzRLYm9iOVlWNzEyWm1lcHFueXJpWXI5YndvZmx2?=
 =?utf-8?B?c01CUVlOaHZDdGdGM0hCV0N1dVlISmtvbFpPS3o1dHUvTGtadnZhbmd3cjZy?=
 =?utf-8?B?My9OYlAxdi9kblkrVmtzNTFpb0ZYcnA3WHEzSnZIUVorZkI1cU8vcmVqZm42?=
 =?utf-8?B?OUFiOFhuaG1ZVkVZQ09KT01uNjBrMCsyOTBMelJDTmdGdk84WSttVHNFT1Mw?=
 =?utf-8?B?MFl2bDYxL1dxb2haVmRkVHBIZFludUlNbjcvM09wK2pjMmpVa1dYYjVPNlFt?=
 =?utf-8?B?WVhCdmxRYjZyY2h4UHc1ZTQ2dHUxQ2FkNWlCVEtTbzdiSlJXTW05b2xZYUN0?=
 =?utf-8?B?dzlpN2dJdS9uaTZyRWNRelg0VTg1OElIdmlmbEl3REZVeEtJSHE0Ymt6U005?=
 =?utf-8?Q?NbEpNv2E4n6hILWxWkscwN48M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475479b8-e5cb-448b-45ec-08dd50c847bf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 09:32:08.5359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuBUPVgXz9IwAfiR5WcP5rkA4hYxCbqRXI92lqayU+R/j2034V8yzGtxl5BRPfAS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781
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

Am 19.02.25 um 07:20 schrieb jesse.zhang@amd.com:
> From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
>
> - Modify the VM invalidation engine allocation logic to handle SDMA page rings.
>   SDMA page rings now share the VM invalidation engine with SDMA gfx rings instead of
>   allocating a separate engine. This change ensures efficient resource management and
>   avoids the issue of insufficient VM invalidation engines.
>
> - Add synchronization for GPU TLB flush operations in gmc_v9_0.c.
>   Use spin_lock and spin_unlock to ensure thread safety and prevent race conditions
>   during TLB flush operations. This improves the stability and reliability of the driver,
>   especially in multi-threaded environments.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 2 ++
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index cb914ce82eb5..013d31f2794b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -601,8 +601,17 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>  			return -EINVAL;
>  		}
>  
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_SDMA &&
> +	    adev->sdma.has_page_queue &&
> +	    (strncmp(ring->name, "sdma", 4) == 0)) {

Clear NAK to that. *Never ever* use strncmp for a technical decision inside the kernel.

Lijo's suggestion sound much cleaner to me.

> +		/* Do not allocate a separate VM invalidation engine for SDMA page rings.
> +		 * Shared VM invalid engine with sdma gfx ring.
> +		 */
> +		ring->vm_inv_eng = inv_eng - 1;
> +	} else {
>  		ring->vm_inv_eng = inv_eng - 1;
>  		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
> +	}
>  
>  		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
>  			 ring->name, ring->vm_inv_eng, ring->vm_hub);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 2aa87fdf715f..2599da8677da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1000,6 +1000,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>  	 * to WA the Issue
>  	 */
>  
> +	spin_lock(&adev->gmc.invalidate_lock);

That makes no sense at all. The commands are written into the ring and executed asynchronously after the lock is already dropped again.

Please completely drop that.

Regards,
Christian.

>  	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
>  	if (use_semaphore)
>  		/* a read return value of 1 means semaphore acuqire */
> @@ -1030,6 +1031,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>  		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
>  				      hub->eng_distance * eng, 0);
>  
> +	spin_unlock(&adev->gmc.invalidate_lock);
>  	return pd_addr;
>  }
>  

