Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47EED5B17B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 15:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56BAA10E596;
	Mon, 15 Dec 2025 15:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vM0MdT1l";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85FCC10E596
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 15:15:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wK8bmO7tvNE/QNMMqCDbJ2dHM3+6u13k823RrIQXDL8LadHallt5iMYXQo5ScCOepXELaFGQ5xrnZO7CMwqIYRHCNfa1RBXkD9mzH+WJBE14phn3C9UYNUYv3Tgjlf1eZy4gJGc21MspRsBOxRvTEIEcd/kWdyQbeOogpJb16hUc7Nguh9B3CeUXf0uXWFV/Hv1rzpPRU4zpM0x0HTg/rZ2KjvcQfkAZhczrl36HKsq4D6f4miVf13r2cj2+mA0KVpf6knVSeujkIYatdjQzG627DPkPmcaR1YqkrCKGLfn27+xnHrCrSXVw5Y4SEAecOSoo6Wg+aL+mliVe7D9x/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF4JWdBKNBuNn7ZL+tTM72RsK21GWvo+u+1HV2hPk04=;
 b=B0EnMYGuf6R9JxSoFSSGaPr2i3m+l8jnMm9ZKXeBGhbynnJMf13vkyhA7gPztf0OEJ1yBQjz5PS/+OJyBL+eMbQiFXnnueJlKgxj4JiyjoBbCO5c3emxddNZH5JxXXhQxpyUHvl9H165BzgtyUUwlVuX/n/8eTFppXqFn9/QnbBPsSeYvGxCI+wQ/ReMSPZ1qw/s3A8VBeqR1QqN1LfppRCDdH+mOx/ncd5JEyUjgrG1ViXbFgGZHozD8A87QvSw3bIlu0LqSNgjgZt7wxOlxWJOO0bnS7cjOWlJM6mJxC54VfK6HLUO0SVU9N6s25PXfMd2QygA/QAC5y4yEEQTHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wF4JWdBKNBuNn7ZL+tTM72RsK21GWvo+u+1HV2hPk04=;
 b=vM0MdT1l3vH0xCIOeB+vSxzrdxqZVYUxe2wVD9xrGjB12nTp23tFSEWEqrvcH02K4FZGA8pX7BOAqe8ICqKNC4z25+msFYgUss1e/IgSSYDdpwNwqRDlubHc3JpYsO4GcwmkbFgGfk06f0lItlRufDKRtwf5c0GpelL7YZXTWSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPFDDE56F72B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 15:15:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 15:15:04 +0000
Message-ID: <ee2f2f81-6b5f-4b87-bea1-e3ade42ec772@amd.com>
Date: Mon, 15 Dec 2025 16:14:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] drm/amdgpu: Add helper to alloc GART entries
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251209234328.625670-1-Philip.Yang@amd.com>
 <20251209234328.625670-6-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251209234328.625670-6-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0438.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPFDDE56F72B:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da4c574-a311-43c5-442e-08de3becb92c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yi9pUHVFZjkwTWdMYnpFOHBJM3E3TlBVQkJwNnFHaGpWcFk2UmZ1VkxoK3lr?=
 =?utf-8?B?cFEwNlpQaHNoaDZ6R21yTWUvanR2R1BOWFovRkljWW9NUEVHc3N0QUFBc29m?=
 =?utf-8?B?Vko2RTEvY3hSTUl4WjgxRUJpYVVmQ1JQcHBZSnZ3bEVOQ0ZPbDJQaVZ1WC9p?=
 =?utf-8?B?ZFlZNkR2SDhmcjJMR3BtRnAwV0V3UGc5TXBIc1A4YzdMdEk5Qzh0NEFjQnZT?=
 =?utf-8?B?TVVWdkRsS2svRmZCS21LZW1HS0c1SHdMMFI4NzNvc3RMU0g3T2xoM0ExK1hD?=
 =?utf-8?B?SU1nM3Qya25DYk1UaEpWUVBFeDZlOUdtSjhERXNJWFF5VVYrRWxGVzdHU2JU?=
 =?utf-8?B?alVWVlJjeHEramJmYnVCczd1N0xlNXpOK3lPQjRCYmVCRXJNdUprdDA3OWZF?=
 =?utf-8?B?SmJxTk5vUThmTGNzdGg5RTRyOU8vb2dHbUlKNnJhVVg3bW5odTdnb1B0c0NY?=
 =?utf-8?B?Smd0WVNpcFpFbi85bS9zbzZDQTZuL0NBTmpZemxQYVhOZng1ckdnaVptWXow?=
 =?utf-8?B?RzltMDRBMUg0dHdxN1V6NHNUZHI5L0VKaDh3SmV3RU9ia2NvNm5YNlVaemZ0?=
 =?utf-8?B?Vm5Dbkk0a0tGWnJ0L001cGtPbVU3eTNGYldUUHNPSXdVK05HUFBQcHVTU2Zj?=
 =?utf-8?B?RVpFZmM5d0ZBSzhicklkd0lqdFg5b1hSdnFIUlZLN1QzYzl0OTZXZzV4RmZV?=
 =?utf-8?B?SFlyemRMaTFMZTBrSzlNTmF1YkppQ24vSzM3eWsyUklPQkk0c0lxK3dzN2dW?=
 =?utf-8?B?aXUrdlJkeTlueWovTVYzRG03S3NmUjhkZ0xMb08zZlZRSzc5T2tXTTVoZVhB?=
 =?utf-8?B?STlwMWVybzd3Z0oyenV0ZXNOTlFSTHZZK2xpaXJJRjF2anVNN3FSVE56Q2xr?=
 =?utf-8?B?TDNhbG1JU2N2WFRVMFdMeUx5ZjRFdkxWVzBULzhJbjJYb1lua1M2TEg4blhv?=
 =?utf-8?B?NVlKdTRjMkVnWDVHajhxYWpWcDBja1ZadlFFYUZCbys4YTBKbkRnVE8rcjRj?=
 =?utf-8?B?cXN1U3o3b0gxcTNzb25GSC9pSjNaYkR3SnJGMHF2NDgwcE92eHJRZ3A2bEpI?=
 =?utf-8?B?bHV3Mi9Zc3RBb0R5VXdWcXlPTHY4d2hkUXdvcjhoUjRGZkhHeVJJd3ZtTGdJ?=
 =?utf-8?B?cEJyTXRuMFVWVE9Rc2hKTHVLTVcxWUhja2hqSWNCelZNMm1CZ1hPYkdWZTl6?=
 =?utf-8?B?VmMwcyt3UDMrSzJORzYycjdrSXB5aUZRZ0g1MkMybUtmSmdnME5CWHhIdHJo?=
 =?utf-8?B?d0pEalQzTWQxcFZBQlI0YlArbVduTVo0anlNQnp4ZG9yaDJVUVl0MGVSYmVD?=
 =?utf-8?B?TFpwQWQwMEZlODc4SlhsRGkzQ3NWSktwV0tYc3IrWHZTMjgzK1lMaFR6UkZp?=
 =?utf-8?B?TDJmYVBuanVIQjh3bmpUY1RXbW9tM3BPdmMxRFcxamZFcFhJNmFKRW9zdjJN?=
 =?utf-8?B?NkNNQlZ3U1ZxdjZIS21VWWFEd1BPY0pwQ1YySktPQzUxV3V5RHdzYStHRmtQ?=
 =?utf-8?B?ZFVDWjMxQ045cEdaazRObW9MTytJM1RiZ0xURzdXM0ZrUGxOV1pFbmREV3A4?=
 =?utf-8?B?NjhpaW5UY0g2TWs2dWxqTjA5dXAxeUkycFNTWjQ3ai9HOG5ZTzNSTCtSN0Rj?=
 =?utf-8?B?N2M2ekd5dXExMHFSa3V0ZkQ1N081ejZ6aUF5YlVTcTNKeTF5OXhudUpTSjh0?=
 =?utf-8?B?NysxRTQxRFhZSDVFOHFPTGd0bGRITGlQQjdxNEFtKy9Ra0FybUF6K0EzL05Z?=
 =?utf-8?B?M3QwWVdYbkFWbi9kUjFNWFJRSFRxeDlxa3VPQzlGUVRUK1o4L0JJcUFydW9j?=
 =?utf-8?B?cFdLcVBSWTkvaGF6cTgyVlpiVmlpVDVTaUxTY3ZpRS9SckJTem8wM1E2c213?=
 =?utf-8?B?YndYd3VmRUxac3NHb2dhWnNxSXllRWJvekE4eHF4NDRLeUM0YjIxMW1RWDFy?=
 =?utf-8?Q?BD0VxpynPGeg4AHqwK6if81tvILqovry?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm5Kd0Rkbm9CQW9GQmVOZ1FlSWtIL2dnUEUxRDdVd2RTMWo2Q1FGempjTlpv?=
 =?utf-8?B?ZEl0bG5jTDQ1TitpaFdrdjc5SzZIMTkvdGRqNDB4Q2VmMHZrR3oyNzJwb1pw?=
 =?utf-8?B?T3lwb2hxOE5wSkFnUndSYkU0RFcweUxUVlJldDZVaVVCeUN5blRLeEM4aEho?=
 =?utf-8?B?YXB5ZTJWYVR6KzQ2bmV0ZXlKNXlOQUZjdkY2S0FyRUxFU0F6QWNhYk94VU52?=
 =?utf-8?B?VGhDWXE2bG1MejdZd1g4eXAxa053cGpKZklmTnNydERNZ1lDTzdLV0UwME1N?=
 =?utf-8?B?RWhQT3ZXbUpOMGpoTzg5Lys1K2RMVmRwR1dqdzFna1ZTWWJ2bzU4M3k4cE5K?=
 =?utf-8?B?TXI3QkdTRDNuOUlEQ2ZYa0hKUU9KYWhuSWRMOThSREk0cHpHVGc5RWx2RWZ6?=
 =?utf-8?B?WWN5MGk4M0QwRXYwa1RXU0s3SXExZXZHUEhMOGY0SnEwVlJ3d1R5OGhxMHZs?=
 =?utf-8?B?ejU5dXFiZW1MTWhodndQUmZYQVJhUUI3bk41SkpLUmRYRUZ0MXBNM0RoWWNS?=
 =?utf-8?B?WXlBb2ZJYXduQ3MvN0xnSWJteFRoWldaMElFYkREMlJTZGtVMEVKelZTWXZ0?=
 =?utf-8?B?RnZaa1AwbU12WDNiZlI5M3RrVXc0b09oVi9MM0JoMmg1SE5SdGhjU1Rwb3g2?=
 =?utf-8?B?Z3c0RXIyeUdKTGp4dnFTZ0ZBVzAyMloyTmhKUTFZT0Z0UGtQVGovS3N2cVFG?=
 =?utf-8?B?SGo4UndFQys0VVByOHp1RXRFUml0R2prdEc3UlI2U2VCekZoSGcyVUhEZUx1?=
 =?utf-8?B?NDgvaEUxU1dNZi9XY2VBOUd3MzdhMXZNaUFIUjVjZkpTZUlKUVFNei9BVm45?=
 =?utf-8?B?L3pZZWp1MlljM1RjR1FKdUc2TFRCbWJNSDIxalpCaUdrcGl2ZStka2hlQWpT?=
 =?utf-8?B?WGk0MStDRnAxOVZjYVE2THlKVmcrWXZWcGkwK0xZUkx6UHBSdzdENnF0aGdl?=
 =?utf-8?B?Z3Y4U2VIZndDKzlyWnFVK3UyRVRmQk1OcUVxYzB2UnVwNDlSYitWTlp5VzNp?=
 =?utf-8?B?TVV3cDgwd0ZsRXJaUVdNT3hUUitudGh5TDk5M1R0WU1nTkV4ZU8yVC9VV2RN?=
 =?utf-8?B?TkFsU0g2T3hubzlETjVuQzZicXRualJtckkxdUlwSGpyamtJMDZ2TlhyeHpt?=
 =?utf-8?B?d3pab2RkajlaS0FRWHhzdDR5bWhtNTlLWlVGVmk0b1Y3QitWblh3UkFnemJj?=
 =?utf-8?B?OEx4cGhoLzB1ZGxTR2dNM3BPS005WEt3cWhmZWRWdURNUjEyUFVpS2l0Y3dF?=
 =?utf-8?B?OStaWU9scDBKUzFrd2dGK0RaS0tpeDY1WmZoK1dOOWdIb01xTXZaYU1TOGpl?=
 =?utf-8?B?TTRSd21DQ2ZuZngyamwrZmJtOVkxa094RVpGZjQ5WjlCZmV3bFBGaGd1MWl3?=
 =?utf-8?B?dzdNcmNwby92WW42VkIwcDBSNTEwMzZZd3RTYmN3am9WSVR5YXdyU0EzdlRl?=
 =?utf-8?B?eTByditOSTNXUklFREx1Wmt3cHpUM2N6akYxb3VHSVFCQUEyamZvVllDN2FD?=
 =?utf-8?B?WGVFRlR2NGxZb2s4b0tFTGIvQmVUK3llWmtONzVQNlNMaSs0eTdjOHloZDZ0?=
 =?utf-8?B?UmtUVEZNUlpFMTdzRk5ORmc0RktyNlVWVVhYSlZiVEFraUsyUWdLNS9vaENZ?=
 =?utf-8?B?MEFSY3pSNmpTOEFXU2xqbUI3cEREWmxWbDZSaXQ0T29Va21lb0g2d2F1eUdH?=
 =?utf-8?B?V3ZWVmVrL0RvSzlvSEtadW51VHNBd2FzVDJGRzBQRnhRQ2V4R2xDOHUzdm9L?=
 =?utf-8?B?S2FqYTM0N2RGeExHNkJVaW9QUEJGTlQ1UEVpR0lzZVZEbkdSNUF0MGJzTVFU?=
 =?utf-8?B?cEVNYmFDRjEzeG9WMkM0UWNuSDZzSEh2R3lPQXpPU2hEMDZMaEZXRE9ON21m?=
 =?utf-8?B?aWc5TFl6QmRUNnVMaTVLR1ZDeFJUaXF0aEpnYVNScmliSllvZGYyQlZMUDBo?=
 =?utf-8?B?NlZDOVhiMDRxc1VnN1AxQVUzVlJLKzg5VGt5UXlTcHdaU0VCYWpHa0RaV1pK?=
 =?utf-8?B?aUxIR1BmeGhUQzgvVGhrVXUxRVVWYWwyblJvR0RyT2NXNUJZZkhDZWFvbnJ4?=
 =?utf-8?B?UlNRSVFLdE56MGhYbzFrTCs1VWNoaStxR0diN3prcFRqTDl1ZGJTNVcxcHNY?=
 =?utf-8?Q?WbecYA0ZT75NXyuS9BOFCkuP2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da4c574-a311-43c5-442e-08de3becb92c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 15:15:04.0656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIoKrBBgJ9Ou9gur8OaW8RYtJMU+qnxGU39GMqbVEQ91CDqh9xy7hDkczLHjRRQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDDE56F72B
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

On 12/10/25 00:43, Philip Yang wrote:
> Add helper amdgpu_gtt_mgr_alloc/free_entries, export the configurable drm_mm
> allocator parameters to caller.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 27 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  7 ++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 895c1e4c6747..d21c7187e4aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -321,3 +321,30 @@ void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev)
>  	ttm_resource_manager_cleanup(man);
>  	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_TT, NULL);
>  }
> +
> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *node,
> +				 u64 num_pages, u64 alignment,
> +				 unsigned long color,
> +				 enum drm_mm_insert_mode mode)

The color is unused as far as I remember and the insert mode should be hardcoded, at least I don't see a good reason to expose that.

Any specific reason that was added here?

Regards,
Christian.

> +{
> +	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
> +	int r;
> +
> +	spin_lock(&mgr->lock);
> +	r = drm_mm_insert_node_in_range(&mgr->mm, node, num_pages,
> +					alignment, color, 0,
> +					adev->gmc.gart_size >> PAGE_SHIFT,
> +					mode);
> +	spin_unlock(&mgr->lock);
> +	return r;
> +}
> +
> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *mm_node)
> +{
> +	spin_lock(&mgr->lock);
> +	if (drm_mm_node_allocated(mm_node))
> +		drm_mm_remove_node(mm_node);
> +	spin_unlock(&mgr->lock);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 72488124aa59..28511e66d364 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -141,6 +141,13 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>  bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>  void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>  
> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *node,
> +				 u64 num_pages, u64 alignment,
> +				 unsigned long color,
> +				 enum drm_mm_insert_mode mode);
> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *mm_node);
>  uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>  
>  u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo);

