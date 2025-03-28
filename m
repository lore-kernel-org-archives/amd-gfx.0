Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A4CC28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 12:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC13310E168;
	Fri, 28 Mar 2025 12:54:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WfJOMrO0";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92CD710E168
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 12:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfUl3BrxXW3qvq6KWocHUvkqayhxgI+4UEFV5WzZRaykQ9Wmjd/XlZS9b1Df5blVZYs2qd1rWE9ZrLSHMiCLkrMOTu2n5uyL2JgILCYF9HejF27tL6HWktAN+RZdaFtPfEkhrulL6S+nCKGnuicdUT4E9wteg22dsMS3BfOkDvWZDOfmT6a14twlkZoJ60GMrq64sIjs1wCa/9tG7IHt6lu6uZTERiM6dQJCEqcE9niudFeF24xStKKHsuBBVxw089XtqoynKWIPu8r68gaIfwKGuyGx2TgqtHoNuZafG/0FB/xrKXSEbTu2BW75HGgqS4+7t6wMy969ZCrDdz3EOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IljtepIrvd8juPyHE3vjVYyjpobFG4Ps+DPpxUx1TxA=;
 b=VemCJCRZUrEhzQnAJvyRSQtP6urHuzQqfTAYRXmiWCFnvgWM6AasvEh1BtAO7+yI4rCjiLxxEVO0RKDBy7zRd3oTzGZYg/szuRSik1jq6aZABclnuf8JrrAICyG4VDQWAdgczx1Uwc5HBd/JT34iWbGP2cKAJFsQX8inrZjeOuZBTotAZCBrwLafTJ1Hxxh0F0Qa7dxFu+9/X7XO4Ye6uOTnyY1uO4SkH/Kog9rxV60Z5BYi5hoyNJAjV0wMUU+DHQXgop53HIFkykvtf24juZJQYJNdyxNb+yLXWOl8RxdtP3YjWbGGzQvXHaN8ctwevIKlweOuB6GL5m3VdGDkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IljtepIrvd8juPyHE3vjVYyjpobFG4Ps+DPpxUx1TxA=;
 b=WfJOMrO0MJXbLje1uKSxws3NtV5q3HQCmnBw8m+PCWMhdb3JBPWWa2VR7sw09p/MxXou8UX5RgRFB6JY9+VaTVg+e63nHhzNMgoGfVnMob1311Jwq+DMsQJ3x7fwtAMnAXg4mVTtgXbc3exB+59ls/zCY+iH6vqflQDMw3oCTkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Fri, 28 Mar
 2025 12:54:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 12:54:41 +0000
Message-ID: <95e48cb3-2b9c-46ea-85e4-7ce730dbb816@amd.com>
Date: Fri, 28 Mar 2025 13:54:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add cgroups implementation
To: Natalie Vock <natalie.vock@gmx.de>, amd-gfx@lists.freedesktop.org
Cc: Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>
References: <20250327195400.130758-1-natalie.vock@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250327195400.130758-1-natalie.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d6de8e-1891-4f2b-67d6-08dd6df7b4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGhWbXdhTzFtOXJxRk0rZUwxY2R0QllIamVFUHVESDlmZDMzN05pT1F5WW5y?=
 =?utf-8?B?M0czRzZVUzczOW5HSDh3SkZQaks2QklxWSt6b2lSMXhRdGxzcFZKOXVteUdB?=
 =?utf-8?B?UGwwL3RaaHppRVU3V2FxMXRhdlJ0M0RIM3o4NGhnSWttRVVtM1F6aXZuWUZ6?=
 =?utf-8?B?M0p4QzdWWVNhV1d3blp0bmxhaDFXQkQxVkZ2VTdxcDlMVXNoSk9uSFJ5UGlV?=
 =?utf-8?B?TnRrOEE3cUJqRmo5bGdzNjUyL2duTFBxNFZ6WXJBaGxobUJLYWFpSXZKWElN?=
 =?utf-8?B?elJua29jV0lFV2NHZVVVblYyZUUrNGFFdzkxMlZUWVFYdjZZTVRGbUhkWlhx?=
 =?utf-8?B?QW1TdWhwVmFJalJFT0VTemd1YnJmL1Y0MC8ybnhmTzZpUU5BMzRrZUhTZEpX?=
 =?utf-8?B?a3JTZyt5UVVSM3pNd2JOc3hKYUVLaFlITWhTdlZ4MGR2OURydzUyejdKdzVK?=
 =?utf-8?B?c1crdkdXUW1iUGhkUUlsZ3NoTnA3d0Z0NVBGaDZLa2x0ZnZ5M3dzWWVMWWto?=
 =?utf-8?B?ZEZVY2J0UkRyWUlwb2V3ZUFSbWxMaWQ2STVMeG81K0xXc29TNUZhVlBZOWFC?=
 =?utf-8?B?SFFNcFlLVVI1WHV6ZkJITWJKQnVIQlh0OG9YZ0crM2dhMzZmUU5GWGFkdVRw?=
 =?utf-8?B?TUpvR0F6L2lwckxVblpXNlRScmU3VmRLQ3NYaFlITlhwbm01eWdPVnBIL1dv?=
 =?utf-8?B?UlFiNDlPL2E1ZEZCdjVySmlUenRETUVkTmlaclFFcnFWbkNDM3RkeUlBZ1FD?=
 =?utf-8?B?bTVlNUNHcGllZWxMSUFVdVV6aGtoVFF1RCtJZStqSC9ERmdjRG5KTEF5TEoz?=
 =?utf-8?B?MmhPdzdQRUVTaTVkYndoTmgreDZDYWxmYlJNMEUzZmxGRjYwUGJPSjQrR25N?=
 =?utf-8?B?RUkwcDhoUmVnbWdCTkVodUlOQllmc1gzMWxrVkdUejZ3MEZwTndRdm5RVDRF?=
 =?utf-8?B?WElnamF4c3V5WHBmRzBJaVdtTGFralZaUGMxUEVkcHdzMHJWeGlXN044WmRO?=
 =?utf-8?B?a3hrY0IyOGZEZ0ZrbTJiM3F0RGtVaWpUcFdBdEd2RWJEdGNtbHVQbkUrQmlO?=
 =?utf-8?B?WW11K0dqRjUyTkhMK1BOeTNKNDlLYlNVRzBLYTBtc3QreE5ZRSs5VEJTZHZk?=
 =?utf-8?B?QXJyWUVUTVFXWlRMcDBRaXZIenZxdUJLK24vOWhsRmVOSGU2cjJjM2lEWFFX?=
 =?utf-8?B?b3pDemV3SWhpanVNUUo0UTB2dm03Q0IzVE94d1R0cjNBUFpBcHZrV1AwMUg2?=
 =?utf-8?B?ODR3S2FaM1RhWWFaY3pJeVVYNTQ0WW9TdXZkZ25RR0R1Q1FIZXBCYWdFVXNl?=
 =?utf-8?B?aXk0YTlTNkFGYW9xVWhkU2dNWmdid0ZLYkFRRzNOdVJtb2czTWFzVkpoU21N?=
 =?utf-8?B?cUV0MExDSCtaeHhhZ2VFSWRvRFlGaWhxdmdEdVJ6M3ZlUmpmQzFGOWpCT29y?=
 =?utf-8?B?bldDYXVkWUJUR1MwUWIvN0c3RG03UTlwRGxEQkJrMFZWM3dFbTJMMVhaR244?=
 =?utf-8?B?b0pjUGwvb0xvTlp3bllvNno5bWlvRVNjdldRSmt5dDlzUitTbXdnWlhXWEt6?=
 =?utf-8?B?N2pHbHFnVVpjMWhXUUFrVzI0cnhaTm1yMlhwVWVhejhlN3ZlRFltaEk1S2NS?=
 =?utf-8?B?L1NoNFJBZGJTZlZFSlRtUzlpMHl2bWpndlBpbHpNL1dCUFM5cUU3KzVscU13?=
 =?utf-8?B?eHcvd2VObXdubGRBY1ZMNVFWcWd1cWNMV3dYSGxJVEFncnZMM3lyS1hDMkJF?=
 =?utf-8?B?K2NHeVVCd28rWWVvVU9Dd2VPMXJlQ2xZVG1yRFBMSzBXTzNGeUNGaVFwNVdk?=
 =?utf-8?B?d2RXVHZRK28xdWdvK2JWMklCVlNWSjZjc3JPZWpUcldHQ2NvMmovdGhQMGF2?=
 =?utf-8?Q?Dl0b4dSaOM/xZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEx3VTJZQWZGSUk5b1dYcFBkNytnSjhUdzMwRmFuY0Q4eUNRanViK1FJSWdK?=
 =?utf-8?B?emJSVDRFSjJydG94T1dUOSt4Yksyb3VwcUZVcUp1NmQvaVorcTVtMFdtRkl3?=
 =?utf-8?B?RTZZRkVoY3lEOVc1QUpXc3FtK3JQbTdRb3VBK0d4YmJVODhPelN3M21XZFJw?=
 =?utf-8?B?ZGNBNktieGh3bytRUytFT2t0ZS9ERXBFVXB5SVZ6czJDdk4rREh3QU9qcVZz?=
 =?utf-8?B?bDlpWmo4Vk1YaVA2c2pkS0xuMk12Q3FuMUp3cXU2NzRkU1BqMklNRWxQVGt4?=
 =?utf-8?B?Y01WV014UWdTZkprUVUwK2h2RGV0cVhYWDBOa2d3TCt6VXpXMVJvWENsQ0hP?=
 =?utf-8?B?dXBEM0J5ZUJjZlA5ejR6R1hSclIwMjZDczNBKy9pNldLS3pWZllFelRkUk9h?=
 =?utf-8?B?cWFvY3RFWSt4aml4bDY5T0FHRy92RXBHYm15U1J3QnZYNlFKSEdjeUFKU0hq?=
 =?utf-8?B?VXRuZmJ6TWJJSXYwc2IrZ003dmE0Z0pCWlFGK0FNcXEvbWFUQzd5Y2Q5bTVv?=
 =?utf-8?B?RkFsQldZQWJMSk1Gc2Q5dk5sNWtsUG5SUW8rbmZlMVlzSDg1MXVkckNZVStx?=
 =?utf-8?B?cVd4OVpVaGx1N09oMHV6ZW8wS3JrR2RrSjlibTNDajQzZU9YVTQ0Z2pWSDQx?=
 =?utf-8?B?U01kMkJYSXJMdFhpVTZGbHpVQjgzNGRVZlpLMFhyT3dFTGk5MmdTa0d1ZENB?=
 =?utf-8?B?Y3REQWdzTWNVWmYzYXN5VncwTmhhZUg5TENjNFVaZEl1bENlUERkTzN6Tjdl?=
 =?utf-8?B?QlZ4Q2gxS0FzL241THN4TVhEeUNiRkRLSmNZaWpYMUdBOURTbWJISGVIdjRH?=
 =?utf-8?B?elMyMlJVblM2ellLWk1IbmI3WmkwSHNNS2RLdVoxT0Z5NzRiMWplMnM5TDl1?=
 =?utf-8?B?eUtjWjJOVXp2RmRhZGcvNzkwVVhSb2RUVFNwWWNhb1dWcWErenpqRVlMenQw?=
 =?utf-8?B?VGhJczMyYityTEpUd2VlZERuRkprcFc3SFpCd0ZqbGEvbGNONXRZNVlVZkpa?=
 =?utf-8?B?S0t0QVJ5TndleVJYMHF0bk9TVy9rb3Q5Z1hocExoNDF0Vlc1WEtvejhCdnRV?=
 =?utf-8?B?ZGpmZ1FJUmk2dGJGckl0UldHeXNWaE51TWcxWmNDMnBDOU9qd3lMK2pNNVZ6?=
 =?utf-8?B?VHJrSVhaVkJHa2dWay9oV1lQQzlTSDd5NE5uVGd4ek12RXY1YU1DVld0dE9B?=
 =?utf-8?B?cHlWSCs2WHZXWHVHeHVibFhwdDhYWTRFZlFBNlhLT1NYMlhKNFV5M05Ya2h0?=
 =?utf-8?B?cjVXa1V0RnhoZExYMkFhSEYzY2hSNVJmOHlXVUkvak9TSzhmQzBadDZ2dHBH?=
 =?utf-8?B?UURGQVdBbGF1YUd2MytjcWtsRnAzaTk3S1hKQjN1Q3NaVFduekI2dDJBWUlR?=
 =?utf-8?B?VWd2TnJOdFN2MzJXTmRjbURlZ3Y3cFJsQk5DamtpRElmQVVLMDBVeXZuQTdq?=
 =?utf-8?B?V1MzWnFMYVlQV0s5a281bDY5SjlISkxRZUdPa3l0SCsva0F3VE9vY3JFY2Jv?=
 =?utf-8?B?c3JPQ3FMOWxhNm9iWURhRmxVUk45UTM4YnhnQjBVcXNEazEyVzViN3JpM0tL?=
 =?utf-8?B?OUJZRE03bWNEcllMcmVDZjVJQnpkQ2xyZFBlM0VmYjZ6QzJKV0JtTjRkY3BB?=
 =?utf-8?B?Q3U2bDhzRmdqQVY1V0pYRktSM0xlMkMvalBqL1hwVmpRNzF4TnlRRVFkWDl6?=
 =?utf-8?B?blcvYmJ4VzdpbVZwZU1xdVhLZU5MNU9zTFZVL1ZRQjIwKzNaTk8ybG5pNm43?=
 =?utf-8?B?a0dGRTN6Vk5ZSjIxY09meG4zOUpXSE8wOWd0dnVTRlVHN0RzNmpMM0hiNk51?=
 =?utf-8?B?WjhsQ1pXZDZ2M3ZSK3V4b29Ld3V6eVlESE9aQ1VNcldrZkxWTStJUTlCZHdu?=
 =?utf-8?B?RzQ2byszeXVEbTZYZFRNUDVkeWNFeUxoUnByWDRBaGl0c1ZjU0VQNUw4WG51?=
 =?utf-8?B?NlIrNUxuUUMrMmxIRXgxaFFrOHVTZXV0eFRYR0pGZ2M3MXYxUGt0RzBNWGJ5?=
 =?utf-8?B?di91VkJjcjdMUTl1MmNLWDhISXp1SlQ0S1FnOHVDTTVBb2NuV3ZUaEo1U095?=
 =?utf-8?B?dnRoMHp5c0l3SVo4Z0x6UkpPTFdocHArQ01NbjNFY3kvT0tqdkpTRHhhL09w?=
 =?utf-8?Q?fbDCNbWteObb5QgYBmZnsIVZ5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d6de8e-1891-4f2b-67d6-08dd6df7b4bd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 12:54:41.5833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LqQZOmyqEwcXXHMphVHrzauiWRcAPpa56KNJQ7UlVvIshXE87ZDOWJNM4mqvaTE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448
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

Am 27.03.25 um 20:51 schrieb Natalie Vock:
> From: Maarten Lankhorst <dev@lankhorst.se>
>
> Similar to xe, enable some simple management of VRAM only.
>
> Co-developed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>
> Resending this one since it got lost in the initial dmem cgroup
> submission. Probably needs to be merged through drm-misc-next since
> amd-staging-drm-next doesn't have dmem cgroups yet.
>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index ff5e52025266c..7b86d7f9d5d56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -24,6 +24,7 @@
>
>  #include <linux/dma-mapping.h>
>  #include <drm/ttm/ttm_range_manager.h>
> +#include <drm/drm_drv.h>
>
>  #include "amdgpu.h"
>  #include "amdgpu_vm.h"
> @@ -908,6 +909,9 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>  	struct ttm_resource_manager *man = &mgr->manager;
>  	int err;
>
> +	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev->gmc.real_vram_size);
> +	if (IS_ERR(man->cg))
> +		return PTR_ERR(man->cg);
>  	ttm_resource_manager_init(man, &adev->mman.bdev,
>  				  adev->gmc.real_vram_size);
>
>
> base-commit: 1822532477cb5f007313de4c70079c09aaa270d5
> --
> 2.49.0
>

