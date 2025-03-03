Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C10C282C6
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 21:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03ADC10E2E3;
	Mon,  3 Mar 2025 21:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TdoEmAS4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A1010E2E3
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 21:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8T2nMAhEaqP73a53zoicVGmAkSqD3rjaeRuzFZ1JTJqPMQuyJ4FvjJ+od4mEJzeYSLgTXG2fy24b8pJlyWgwskJijcpmCh7zbiYE1J18p/XJgQxNgqfjRBi34rPvPBJbtnCQAQtGJ0jMwdCE8qikFg1tEe3ToOKvOXCUi1JMgsmVmXSAvZ9FI5+KdZoH1aGlQ03l5kmh0sI6PgVZz+a+lRIkBQ6Cg8wl6QoE1AMVhcxld/1zC2PFgBpp530rZgMy/u1lIZ5bxbEDcUttVxdejzJN2D2SL6xTCafJZMNd4drlZeb3+ixFnTedDs5mN4XGf24lUrmOpT1fdRapAKNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GDcq0rGjs/UbdxplPEYbd0ETUNBkbdULQTvYoKX+8w=;
 b=f2GA/j73dLNS7+HU5mDffZZvvTDHPLNsn4xdeXon5tHQzfMOBVSxTTR389e/pUQit+MhuRiTs9XEIGyt11uifKNVGRnT2f2JkGPVTQW6BGGTEd2wLvhDfhrr+4rPqiYmxAxmYpqZk03d89j8pGiAvqdF7ZJ7md/z4Mmz43OCQTDnruLqxGjzw6ja3Y9C8eWk7BMMmdEx++vVL3bnHdQJgwtWxl8k8smjlyreS5Egi9xLlGE8gk2yW52NLF5sZkyCdPa/JUX2PXbDJi1ZBc8Ko+zNHHo/6gk7HpBzOBjEjJAmbAXoCchAkrMf+EQabfE0+mV284i5kbiqUJ/y985mzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GDcq0rGjs/UbdxplPEYbd0ETUNBkbdULQTvYoKX+8w=;
 b=TdoEmAS4fPb/9UQtw2WBs28riioqNT4Hb2PCJQ4kbxNFg7aSH3c6TZYIH5cZqrsiy89xC7sXNcvqLH4LRdtlJHlJp9RGUEGv3LFQBcWfdMne3QD1anHx4rviEuojBbAsiRWNF+BFM1K/K6dHB/r0R4BHPVo84EqtKlZbhELTfNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Mon, 3 Mar
 2025 21:48:36 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 21:48:36 +0000
Message-ID: <1b98992a-d96c-4481-a74b-dc6a4454c020@amd.com>
Date: Mon, 3 Mar 2025 14:48:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/display: Add a temp w/a for a panel
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com
References: <20250303135051.1177406-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250303135051.1177406-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0332.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::18) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f51e77-b8a4-4899-5306-08dd5a9d26c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVNXaG4renJsbE1HWWlJeFJVOGJGUGwzamdDMmVFYVhvRnlKWEFMbW1Bc2lW?=
 =?utf-8?B?T2ZiWlJYUUh6bUNlbnVqSmhxMWx5UDhjMnVzNGxCQ0VFMW5yRFlnaC9PaUZX?=
 =?utf-8?B?L0NlUmRMSUFFUmw1U3VjSjdmTGVDamVaKy9NVU9mZmlOV251WVNjQUg2UVpM?=
 =?utf-8?B?TElSTnM1UGtqMFhKQ0dFa05WNVMyckgrc3ZEMUJyR2l2aGdyRzc5Tm5KdFNZ?=
 =?utf-8?B?cUovSG5QZTFoUXFUSXdibExNZ1dBQTlpbEpnQzdpTXJGbi9YcGVnelZwa0xD?=
 =?utf-8?B?bWVXUitiUm8wSjhDLy9DZm93cmJDc3AzMWlQbnRaVmtrRU1ZaEdwOGh0Zk1K?=
 =?utf-8?B?dG56SkFzVXIzaWJNWVV3RHBmNWlMQm94NTdYK2Z0eUxMWnFJLzR0VzRiai9i?=
 =?utf-8?B?M1Q2ZWJjenZHalhFU1R1dzVnVWtmcUhxVUgwUVAwNjV6RXhvREJINTVyKzgz?=
 =?utf-8?B?bUI0T1ZJcisxYjJLeEFuTTdIOWw3OGJlRWVQcHovdnVJcVYyTHN2Sm9TYTJs?=
 =?utf-8?B?VDFPbTNPNVI1ckE4NnJuRStoeVdVclVvVlZneHpPZnBZcXBJdUsyK2JycDhE?=
 =?utf-8?B?VzNTVTI2cFNMTmR3WDQ2ZklsdzU4cDdka0h5SGdpNWhlQ2kyMkhMRkMycFpJ?=
 =?utf-8?B?MUx2VGd0RmI0Kyt5Y3grODgyTThURzFsUkhQZmtKbk9lTDZLUyt4ME5ZcGVZ?=
 =?utf-8?B?VUd2S21HZ29YcG1EcVJHL1JVSHFoOElYR2QxMUNlYWtSeHlWWVJXaXdsbW41?=
 =?utf-8?B?WGgveTRBVXNrY1N5enJwQjlHaUxkMmN4N0ZHeEZSTHd1WkVVTURiMCtBYnlK?=
 =?utf-8?B?aWlEc010YVIxS1dkd0ZzeW1LUWVkakZ0K0FvdHpuWnA2c0g2UXFyUE0vQk5n?=
 =?utf-8?B?SW1TdndaVFhMVHVrcGN3TjRteHoxTmVJVnFnY0QweUsva25QWWk5KzBvTlM4?=
 =?utf-8?B?bVF6dmhGeGRBK1B6bjkycnU0RGdWeXExemYra3FHV2JYaDR5bzh4YnZuaFlO?=
 =?utf-8?B?bi9tVzlQdTVZRGZuOVgra3U3cFZYSEJHZEVsVVQra0JweHNTaU43U21BbkRZ?=
 =?utf-8?B?b2hXd2ZadGtMNmEzaVVuaSs0Si8wVCt5YjRQcGJKOVUyZHEzOFZxSkhBS1RI?=
 =?utf-8?B?NW5jcFpwdk5GUHVHWkYyZ3pXdm9Md0txSEhtSDIyRUUrcitGOURIa24rcVVT?=
 =?utf-8?B?RlhkWlNsdmEzUFFKS3FRRjNBMTNyb0hFdFgyS2FkNXhPRVZEYnYxQ015SGxN?=
 =?utf-8?B?VEl3U3JYK0RTQXpxdFRLZzhuNmR3QllTMXlmMkJHcGVnd2lpUDZBYW5FaG0v?=
 =?utf-8?B?QThZWnFCNzdLdnkycXp0V0pldGNNSHBqOGJ0NERqc28xOTZaMUlGekRONlZa?=
 =?utf-8?B?VTgvUFNoMURlREJuOHpUdmJ5UHI0eUhBMnp3Ry90TFhJRnZmMWFzY1BlZVRr?=
 =?utf-8?B?em5MTHBGZFA0a0tWYnRuWWw5K1FkMWlOaWRFOXRTdnpXUWxOTjhYK2ZRdjZY?=
 =?utf-8?B?V3pqRFp6YkxmQ3lwQXhOYnpjWHhMUWl6b0VvR2dhZEx2SjZpcnJXUG42T2hB?=
 =?utf-8?B?TzdGV2lrcWw2RWxOTjVBeThPdEdZZXRGU1ZOazBKU3JBMVc2R2xyeU9lVkdM?=
 =?utf-8?B?djFjbTJlZllURGw4Y3pqMlp4UVFoTHpMUnFmVkNzY2R2UW83VDRPZndxTVR0?=
 =?utf-8?B?V2hIMEVoK2kzSWVVK1h4SlhGYlE1R052UEhhYi84SnA1TkN2SlI3RlhKTnVS?=
 =?utf-8?B?bng3MnBETnNMU3F3aU9VTEFVMkMvSWlNYjdjWjUvZzBlcytQcWExWnJGOStj?=
 =?utf-8?B?aVB6cXFoQjJBYkR3TWpOZGVmank0R05xWnQyVFFaajZCS0N2cjczeENleWNp?=
 =?utf-8?Q?reXRz8BHRj74Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ulp4WHk4aWZjQVhGMDRiRmt1YnVSK084WVJLNk9LZGIxbm5xQWNKeVQvRzdw?=
 =?utf-8?B?bjlVK2ZRM01zZVhRK0drbjRDZ0gxRmpMOFYreUVEMHZpOC94S04vQ1NPRDJm?=
 =?utf-8?B?ZElCYmY4SmVpL1lOVjRxbjU4WFJCNEZiRjlyNUp2L3RITUpGL3BiQlZDeVVJ?=
 =?utf-8?B?cFRLTkR6Z1BzNVVFejk0QjJxeUl2Uk5KdkE3Y1dOVnJSSUVNNDliMkZHUUJv?=
 =?utf-8?B?cXlBNFJYOTZQb1ViTlp1UUhmN0hNRHhMeGZFamVnUk9HYnphSGlNZFpIQUFE?=
 =?utf-8?B?Z0pvWEtHQ3NKZTFVN2lWdXVUVytHd1dtNlV5Q3NLa0FRaDg3ZUk0SFplcXd6?=
 =?utf-8?B?MTVlMnRQZVlyZFRtQ1JRQWRxbGVhQUxhSU81L2hXZGRkNWpzN1Y0MWhoZmNZ?=
 =?utf-8?B?am5JZGJ1OG4yaDVDTWxvd2pOS1lCcW1ETEFyY2hjcVROVzY3aVBKUnp2Ym1v?=
 =?utf-8?B?ZjN6Y1RzWHRYd1RlaWZNTm80Rk1hWGErSEFnSVl1dU9NNExYYm90ZmRNOWt6?=
 =?utf-8?B?eEhsVFpLTUFvUnJvcWlBRkRTTFpWR05yV3VDMmVGbHFWYjNaU25ucGl3M0VP?=
 =?utf-8?B?YjlxQjFJS2xsbjROVVNYQURuemtsNXBaOVV1Z3VtbHYrM3AzbWV0WlJpNVcv?=
 =?utf-8?B?R0FPWEZwalVQcCtqNGoxdzhUeXhkOHZNR0M4MWtINE15dHMzajhZd2FOYXJT?=
 =?utf-8?B?WFR1ejhwODhncDZ2ckZRdGhCaFp5MVd5RUU5ekhIMzE5YjB2V09kaUdqNjIz?=
 =?utf-8?B?dzVJaDNjWFd3dlpKNTc5VW85d2xENjhXT3dEdlBQMlQ0bmNNVTFEcmp4YTVz?=
 =?utf-8?B?WjNYNmNYcUZpU2dSek9WaW93NFQ4RjVqendFY2kwY1JSdUV1WFk1cmhRT2Zm?=
 =?utf-8?B?UzJaK3hDR21oVTZnUkVrQ0c0ay9YSzNRQTd0TGw4Yit0dWZqMXIxUGNnZzRr?=
 =?utf-8?B?RFJjVTNicjYwaHZnbEIvMWtOSHRQYjNBRDlxTFFGSkNxY3oybkF4UEdnUHgw?=
 =?utf-8?B?UzMwMDNJVndmeWZCRnA0cW45V0toVTkzN2xKaDhYQlJzeWRZYWVmM3pkUVcv?=
 =?utf-8?B?b0w3dnRLWjF4WmhiOE1rOVpLZ21KZldxMW0rL1dwa2I2Tml1aGFuVjhKaGF0?=
 =?utf-8?B?Y1Q3YzRFVVIycEV3dkpUb0dURDMwWkprZTN1cUdyUTFFblFJeXp3OG8yNnp4?=
 =?utf-8?B?WCsvaVpVUHkwVzBsUHpsL3pSbXBibjFSazJDYisyaUp2SnBNaDJ1QlpLVnRX?=
 =?utf-8?B?LzZ2dFY3QzU1MEJpbm10RUFmNk9NM25WaWFVYkEyaGxWRWJiK2tDWGR3bVlr?=
 =?utf-8?B?OXFoOFNGMXNMeVFob0FDTm1NUFUvTGRkM0piS3hTdTBPQmpRNEdxUkdZVUd5?=
 =?utf-8?B?c3lLN1ZzWm5OYzIxeWN0Y1MzZlFRNU5vb3k2NTJ0MG4wUnJqdFNkSEVidjB5?=
 =?utf-8?B?dE1uZ29xV1BQT05JZFFhaXFoVmxOWWIxM1FMRFM0aldDRHVucTlNZ3BxUXNB?=
 =?utf-8?B?Uk5TQVBrTE4ycVgrTXhEbzFhekZ0NWNabWJUU1h6eVdTcDYwVHNPSmZhUHVO?=
 =?utf-8?B?WTBubWkxb0VwNC9HUkNmNDRFVHYzRGRKNzhtekhmN1RWYWxIUUgrZ1F1MTFh?=
 =?utf-8?B?a1N6UkVhL1dmT2RpZTZ0czNmWFYwMjlVb2J0OHVMU1k1eGRwZHlzL1Zrb2tU?=
 =?utf-8?B?R01kQUNGbVdBRkY4WWkwY1hJZG5mS3BYbDJpeTJvV0VsWDBnSFRQVUtnQ0Qz?=
 =?utf-8?B?Z205NlBSSUdYNCt0Zngveno4TldxTGIyVUhFZHFqeXNkNi9LWFVxUkJsSHBO?=
 =?utf-8?B?aUtqUDBBdUNmM2UwNnlBbTJ4WDNldUloTHZDQ0Zlcm56NGluczExMGErRUlI?=
 =?utf-8?B?bGpadE0vU0tRdjVjeEFweHlmbm9YdUR3aU14ZFhkUVlzZGZaekNBaUtZWllw?=
 =?utf-8?B?SGdqL3NRZlIyelo3NU9HV0NXVkJEV21KUE1GNkp5L3hBY0hPaXpkNGltQ29l?=
 =?utf-8?B?Q3ZsVXNpTHExL3dtVjgwMlBFSjdoMmRjOEVDSmhEM1RmMllwa2M4UXA5ZXg3?=
 =?utf-8?B?RXROcE5SRVgveGliUjhOV3BJR25LUXQyc3UxTElYdlpJVHVublB4OGova0Jp?=
 =?utf-8?Q?zr/Lx0mv5e5yEBD2E3PjGXu5C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f51e77-b8a4-4899-5306-08dd5a9d26c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 21:48:36.5211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrviKbu0pkigtujQKkki9C1qtBrZ1WPLCnSw2zxYUu2ubRutil1/IFUZEEH+KCZDEQMMZ4dcfml7uvDGyrCA4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
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

This has conflicts to latest asdn and a minor spacing issue below.

The others look good to me.

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 3/3/25 06:50, Aurabindo Pillai wrote:
> Implement w/a for a panel which requires 10s delay after link detect.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++++++++++++++++++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 10 ++++++--
>   drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
>   3 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 73c95c3c39f9..3a2843e3367e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3327,6 +3327,21 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
>   	}
>   }
>   
> +static void apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev, struct dc_sink *sink) {
> +	struct dc_panel_patch *ppatch = NULL;
> +
> +	if (!sink)
> +		return;
> +
> +	ppatch = &sink->edid_caps.panel_patch;
> +	if (ppatch->wait_after_dpcd_poweroff_ms) {
> +		msleep(ppatch->wait_after_dpcd_poweroff_ms);
> +		drm_dbg_driver(adev_to_drm(adev), "%s: adding a %ds delay as w/a for panel\n",
> +				__func__,
> +				ppatch->wait_after_dpcd_poweroff_ms / 1000);
This doesn't look aligned to me, and maybe the two line can fit into 
one. But this is just my opinions.

> +	}
> +}
> +
>   static int dm_resume(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> @@ -3448,6 +3463,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>   	/* Do detection*/
>   	drm_connector_list_iter_begin(ddev, &iter);
>   	drm_for_each_connector_iter(connector, &iter) {
> +		bool ret;
>   
>   		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
>   			continue;
> @@ -3473,7 +3489,11 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>   		} else {
>   			guard(mutex)(&dm->dc_lock);
>   			dc_exit_ips_for_hw_access(dm->dc);
> -			dc_link_detect(aconnector->dc_link, DETECT_REASON_RESUMEFROMS3S4);
> +			ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_RESUMEFROMS3S4);
> +			if (ret) {
> +				/* w/a delay for certain panels */
> +				apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
> +			}
>   		}
>   
>   		if (aconnector->fake_enable && aconnector->dc_link->local_sink)
> @@ -3834,6 +3854,8 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
>   			ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
>   		}
>   		if (ret) {
> +			/* w/a delay for certain panels */
> +			apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
>   			amdgpu_dm_update_connector_after_detect(aconnector);
>   
>   			drm_modeset_lock_all(dev);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index fbd80d8545a8..253aac93e3d8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -55,11 +55,16 @@ static u32 edid_extract_panel_id(struct edid *edid)
>   	       (u32)EDID_PRODUCT_ID(edid);
>   }
>   
> -static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
> +static void apply_edid_quirks(struct drm_device *dev, struct edid *edid, struct dc_edid_caps *edid_caps)
>   {
>   	uint32_t panel_id = edid_extract_panel_id(edid);
>   
>   	switch (panel_id) {
> +	/* Workaround for monitors that need a delay after detecting the link */
> +	case drm_edid_encode_panel_id('G', 'B', 'T', 0x3215):
> +		drm_dbg_driver(dev, "Add 10s delay for link detection for panel id %X\n", panel_id);
> +		edid_caps->panel_patch.wait_after_dpcd_poweroff_ms = 10000;
> +		break;
>   	/* Workaround for some monitors which does not work well with FAMS */
>   	case drm_edid_encode_panel_id('S', 'A', 'M', 0x0E5E):
>   	case drm_edid_encode_panel_id('S', 'A', 'M', 0x7053):
> @@ -101,6 +106,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
>   {
>   	struct amdgpu_dm_connector *aconnector = link->priv;
>   	struct drm_connector *connector = &aconnector->base;
> +	struct drm_device *dev = connector->dev;
>   	struct edid *edid_buf = edid ? (struct edid *) edid->raw_edid : NULL;
>   	struct cea_sad *sads;
>   	int sad_count = -1;
> @@ -130,7 +136,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
>   
>   	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
>   
> -	apply_edid_quirks(edid_buf, edid_caps);
> +	apply_edid_quirks(dev, edid_buf, edid_caps);
>   
>   	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
>   	if (sad_count <= 0)
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
> index e60898c2df01..acd3b373a18e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
> @@ -181,6 +181,7 @@ struct dc_panel_patch {
>   	uint8_t blankstream_before_otg_off;
>   	bool oled_optimize_display_on;
>   	unsigned int force_mst_blocked_discovery;
> +	unsigned int wait_after_dpcd_poweroff_ms;
>   };
>   
>   struct dc_edid_caps {

