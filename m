Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9C4C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 22:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F7010E06C;
	Mon, 28 Jul 2025 22:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qkZ7tYBy";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2332D10E06C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 22:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDv/+BTIuyWL5TDSdv4otq9fSAt//9hSjp2Y4zQTUXQIT9eiiitkNMegaN5SLEohluoPCJPQNRPv12T3FU9iAYcN+KwbhhhonabLqVEgPoXUsGcUBiW7sHqlIRfvua9PGrBZjEn2LdgiAataH6MtY+NdSgoru/rA2O1HMjM1+V/AamWGd938nau7PtHCYs1tPw0TQWINPMtiljdJ8dILD3jJD8CovHyU5dxu1KcOrF719Bx9ZZZnJjhYSnkkNtoWlFx3z6f+9AmGKnYWPNf8wE4X7D4Qm7MYln9fWeGYfVXBYRd43a/tvjYrrJgK+sxdzwr6RgBXzI8VtsSwsU01eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/gxNkU3iqDu4sZFpZFAii0n1kS/qPJrY9nCDhrpbwc=;
 b=q+YINcC1tC8Q5ePCv6G3/BHxD3rOKgpylcIfVbYycd7FVlyNPe2/gGqRn93vzkfp5it08hsbm7unPFvixjMJBUT1hO07ZaoEW31NEoWjKtGpGRfdMXwdWtJRF1cWydeYYvS+aT2SiSQWE4pogWBxYmFgvXpN0TTYKRmhXSwbjHBhUOk+pQhk1SuSV+DYglPN0Lq2MYKTf98lx4bI/VR2pc/OWYOyWgg/RUIvHOk6/Cd+pOBDOUsOa7qdJjYzmKazyqKTKcluIFzmYkI5LdOi2GmrAMPAXn6g/Vqeji5c3LkkREudy+NUjKRfzTSno2JgbP84OgMHK+uymJcEohqXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/gxNkU3iqDu4sZFpZFAii0n1kS/qPJrY9nCDhrpbwc=;
 b=qkZ7tYBy8XdSrekmh5Cnov5p0M+0meQjUoels0HLIwqa5HrdzQ9rLk+DvOGCsflkHfsFv2SovfM7nzQUtuQcawoZrz6BZigwQg4p1HWN2hsAwyWNZ0ZJhppBoJAI0lzuTm/0oiuq+N6sbicxChoJnKPdZbMIh6Opl2YUzfSV56Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 22:39:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 22:39:51 +0000
Message-ID: <7fd95adc-0fe2-4494-b1b2-3ec147f92553@amd.com>
Date: Tue, 29 Jul 2025 04:09:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: update APU and dGPU tables with MP0/1
 info
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250728173733.27723-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250728173733.27723-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: c6338637-de4b-4b84-c03b-08ddce27a9f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVkzVFNXaWZ1WGwwWStuam9VcTdGNHJoNGZzM2VVMkw0WTc3TFU2d25BTDdu?=
 =?utf-8?B?M3dXbTMzU3JnSlA2dk92NWI0aXpCVDJ0VmtUSVBrbkZFc25OWDhKekcvNHJ1?=
 =?utf-8?B?bWFGYm56WHEyMEpKajNmNElNK2xZbGlTaS8wM0IvMHlXNjc1TzJoTnVIMHY4?=
 =?utf-8?B?TTJkZTlBQlhtRzlmS1JveWlVdzFOd3hOOXhaM2J2TFVydHRjOWZ5OUtwMGIx?=
 =?utf-8?B?MEFkNmtWSnhkakh1cFdKaWlDdU1XNU1TemUyU09RbFZFWGQ1SnA0OTZIcGR0?=
 =?utf-8?B?ZCtWUUFLUjUwWHpMZ0xmSm5YaHZvcWFudzZvT0xVcXh1Y3NHZ2hBakxCMW40?=
 =?utf-8?B?TWEwbnIySUdaYmpnbU9IR25yLzMzMURiQklCTGtYaFA3WklnWmdUcDJVbWpE?=
 =?utf-8?B?MDBZTFdnVHoyUmNZNW9Qb2x1czFRL2c4WVdoeXFMa3BjaWNKL1ZEL1dIbEk3?=
 =?utf-8?B?aXQ4MHJrQVlzUnJXUnFZU2ZHMGF3YlFONHVNTlpObVpMek5BL2pUNi9EUmsy?=
 =?utf-8?B?R0pRclV6eG44TWRYL3pKRStBZjhpNm5RbEJVNXlhKzNCcklYdXV3U2RQZHli?=
 =?utf-8?B?QTgxczYrMnlVdFFEcnZGSUoyOFRIbGE1dW9tanQwa3dvSEhHc3Q4REY0U3RJ?=
 =?utf-8?B?aXFYTmRkalY5aGpQUjgxajkrL1k4TVR1MXBrOGZWMWhWVW05V1FON0ZhcXNs?=
 =?utf-8?B?Nms3K1N0NTF3SURFMHl5elA2dGlzdTI5dTZDTnhJZUFDWHBmU0xFbmJOL3NL?=
 =?utf-8?B?OVNFcVh5ZDZXUXVTVUN3Y1hqYnFoVk5KRk5sTDdlOXBGWnlGajlVb3RtZkJ5?=
 =?utf-8?B?eU5BTTU1Sk4vTHJMUDlVMVRlcnRBRmdBQlhEVGlIKzk4QzBKelhRd3VCU2dL?=
 =?utf-8?B?Zno2czhaRkd2Um9wU1l1MTVMc2hYWjNwSkMzRnZ4c1M4YlU5MEI0R1BNK3l2?=
 =?utf-8?B?dndlU29tZDdzT2FTbGRSZjFJSEdKZUVRMlMvZytLdWFRbGVKd2l1blhEdHla?=
 =?utf-8?B?N3RjdURWclJoekNrRG43by9OUTVSejArN3lYT3hDaHAydk9NQTZpUzIxcEpP?=
 =?utf-8?B?LzZ0b3MvQTYyU3VoYzZtdlYvakt1MmRIWkJGdHpFYWY0VmRJenNXdW1XM2Qr?=
 =?utf-8?B?cW1kQkM4bm9qR1N5dTlrTGZOcFZWSDhyYmRYNWErRXlMVjBaUk1VUVgrR3hV?=
 =?utf-8?B?dGtTQWJTallQa1FpMUdOMDNsOWI1alNCWWE5RXRqL3dmYmFRYnVTZVNVSUc1?=
 =?utf-8?B?djNwcGx1RmlEU2RKeThUdUlXWkZBOGxKak5URXRweTIraDRXT1hDcnBmM3Bt?=
 =?utf-8?B?Tys2OEtHZ2RBOS90WEN0OEVuVS9pY1puWU5qYTZWaHhhWU4vV2hxcDBxdWxw?=
 =?utf-8?B?TGYvMVlnU0RzUlUxMjJtb01iMjFjam1TUjRLT3FaSVlGSWFsVkdrSlpJdVpP?=
 =?utf-8?B?K2gxM2ZpWVZjeG03NHlwVUtiRndMeUh2QXp2VUEvQWo1SGVEZ2VMRUgwQmV1?=
 =?utf-8?B?NHhESGVwU2hiNDJrWWR2bHhXaDJFT0txWDdDNGphVUpMK0Q1L1Q1YXU5SHNL?=
 =?utf-8?B?ZTVaR0ZLNWVNbVYySEsxNmNjSmNYSEYvRmc2VkNtNk50STVvZUZBaEpVdUx4?=
 =?utf-8?B?amhKZHF5WCtBSlYzTG5ETEFPcjZBSCtUYlFndFJsNXRVVnBNbysraHZVZnp4?=
 =?utf-8?B?L1V2V0cwRUtDTVdlS1l4ckJ5S3Z4Z3g0WktMNi9tTjU0U1hPY2VLWTFjTkdz?=
 =?utf-8?B?YjR4akZud0w0aGhLanNtNDd0M05QdVRhcmJSUUxKV2pIM3hEMVJrd01xb3Zo?=
 =?utf-8?Q?3H6SYP/W3neu2nKCt3FHR8qbeBSKE3sd6kCEY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ykx4cWFjWmVsZHI4ekVaU1UvSzlLNnpwS0hwZEh2amt2cGNxQjdLemVRS04y?=
 =?utf-8?B?cW5zU056bC8zaWx4U0lOMkY4VGRTYmdFOWlyYjRtdG1vWFJKNUtueXJTOVp4?=
 =?utf-8?B?VnFOS2JuSFhwUkw5d0ZRZDdueENrRjBaTit5blZHaDB5b1pxS1dkckVvUlhR?=
 =?utf-8?B?VWM3QnlHakhUa1A1MmZiOE44dmNWTHNTeGc0QVYwK0pQZnZkeDdlc1dXQ2h3?=
 =?utf-8?B?SkVwMjJYMTQ3RktUeHFxOHFOa3ZkTWJPbW9RSmZSb0kyV3VqWGNtLzdwT1h1?=
 =?utf-8?B?dXVnUjNuZUtnR043aTNPdGhkMjN5ajlPbW5GUkV1M0t5S2pxV2pUN1dzVUZr?=
 =?utf-8?B?Y0N3R3k1eUkzWkRrZTduWGZwNWtDTHp3V0FDcEUyWmt5K1hpVE9xWjZ5dUYz?=
 =?utf-8?B?K0ZQcHdPNDd3SGRvVHdNa2VIWWxuS2JZQTB3aUZzVlk2VEw0NGxoQjc2UWFi?=
 =?utf-8?B?WkZ3azMxWE11aXdVSFFITjdnM2dSUXJEaDFuNGhVZnNQMk0yQjNHbW40enMx?=
 =?utf-8?B?WkRQeS9oNVRiSXVKdDR5bTJBWml2OVRxNWVsSk10TnU0c1N0K2sxa0FIOVRE?=
 =?utf-8?B?c2huSFVGSXc2YmgwU25oQ2o0VnlIbVJrOWtBdTFZMGFlVHBjWUdjOVd1Tno1?=
 =?utf-8?B?ejZhM0JOelIrUzlFOVpXWC9hWHlGdlNPRUM0Y2NFWFJpR0hKMXhhblplQTcr?=
 =?utf-8?B?dkVqTndHcFFuaFJJZ3dQcFVPcC9EeUJidFl4cnRmeHV6ZmJYYW1KZ044MjRJ?=
 =?utf-8?B?dDlNcHhwR3V3U1p5cDExdm4yUFF0bFUxYXhhZDNvQVpXZzdKQUE5NXVSR2ZM?=
 =?utf-8?B?MVdYWXdoS2kycUJEYUFIdkt2Y3NxMTNUeEFmQnIrbjRtYktUQ0Q0VkpVcVJD?=
 =?utf-8?B?L25LcXJOdWNxYkdCYjhSZjl2QVdDRDZHZzVma1NNSFNGV0hXKzg4RHRSRnBa?=
 =?utf-8?B?Y1ZNWElyVU4ycTBiS29iUjQwcEZJbWREODJVYnJkUW9Wc294Q1NIUEx4MnhS?=
 =?utf-8?B?M0hlZ1k5WllqZmYvSEFnbXYvNVBWai95OUVSNXphS1BhL1FaS0JBNHJSMkxQ?=
 =?utf-8?B?UmxoWDhLVDByUGIyei9NSWx0SnM2N2tPNHBZYU10emlPZExxNUVpWmk3Vloz?=
 =?utf-8?B?Qi9sc2hLSXZIYm05UTcwc3A3d3JZcWgyMVZwWUh0K2NxZEd3ajhLdzZLSUtH?=
 =?utf-8?B?SWhUOUNSK1FlSkw1M1VMV3RUWTFZNnk2bGZwMTB1dzhjaVA0NVdTL2pBV1E1?=
 =?utf-8?B?TDEwbHU1cXBMM1hoTzV5bHRZUW1kZG5hL2NQbzlzZVQ5VmhSc29HRVpHY0s1?=
 =?utf-8?B?My9IVERoTHFyaUtPOE9HTHVqcTZqMC93cjNZdDJERyttUTQzSk5RMTN4WmZo?=
 =?utf-8?B?OFNLR04yRXczUVhQWHBxZWFHNlh0WW11MzNtcEJZcCtxSWRLcjJSekNUaDlS?=
 =?utf-8?B?QUlpeWJwTGcrN2NGMUZLcHg2MGhKekJYc1JRSHppY1BOQkpzOXo0UjhnQ3J4?=
 =?utf-8?B?Qk9DcnUyTFhyZ3cveUFDb203YzRwbWFlQXFTZ3NOanUxcEl6dERWT1Z3bkJD?=
 =?utf-8?B?RU9UUTVFbjdrYTFPSHZyNzV0Qnk4QXdUTTdQNFNuZmU2QlN3TkpKcTNhZmJX?=
 =?utf-8?B?MXF6aTRSRGZJcjJxNjNvWjIyODM2WnEwN1JxVityQkw0dUU2RHJOa0UrUFIr?=
 =?utf-8?B?aU1yc3dmTlJ5TE11WjQ3SHpkb3B3REFQT2VRUmJhSTYrZmNOYzZyK2p4S3V2?=
 =?utf-8?B?Sml5b3hyKzNMUE1JeDFMYlJIdVU5TVdaSFpNT2hLb3BjOGtMVk1xQ1JCNEs1?=
 =?utf-8?B?Wi8xcjkxUlZXdlh0clcwWHFKRGxxUFFsdktCNndqZkVuNTBUY2FqVVhhSWJl?=
 =?utf-8?B?NjhuaUxGcU05bzNjQkxQOHFRckZFbkUwV0lOSGI4YWhxTndRa2lRSldsL21H?=
 =?utf-8?B?bThCV1B0SE5Senc4aThaeHF3VXZGQ2lqRGtEdzlaaENmVUFWSHd0OXJwQjVU?=
 =?utf-8?B?VWprVzg2cXd3ZzVqc3NlalRHcnZyc3N6eWVTQWhUZDVlejBiRWxoeFIxRW4r?=
 =?utf-8?B?RHJYN2xrQThTMndNQjRrNmNFVGJTT0JFaVR6bmJZdGRXa3VQSGZoNUl6VlZa?=
 =?utf-8?Q?5Gf86sk6mbQbLnIFhLttHFiEA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6338637-de4b-4b84-c03b-08ddce27a9f0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 22:39:51.1036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRhTdMk8qCjSpr3LDQEPJ40KGO2BukT5KN56/Wa7kLCFbePeeXOUiD6EkUnQVbAYFR77ctEmIJGxoqPIOr4Q1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188
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

On 7/28/2025 11:07 PM, Alex Deucher wrote:
> Add MP1 for APUs and MP0 and MP1 details for dGPUs.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3905
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   .../gpu/amdgpu/amd-hardware-list-info.rst     |  4 +-
>   .../gpu/amdgpu/apu-asic-info-table.csv        | 34 +++++------
>   .../gpu/amdgpu/dgpu-asic-info-table.csv       | 56 +++++++++----------
>   3 files changed, 47 insertions(+), 47 deletions(-)
> 
> diff --git a/Documentation/gpu/amdgpu/amd-hardware-list-info.rst b/Documentation/gpu/amdgpu/amd-hardware-list-info.rst
> index 1786544fe7c11..e72f4ff770c45 100644
> --- a/Documentation/gpu/amdgpu/amd-hardware-list-info.rst
> +++ b/Documentation/gpu/amdgpu/amd-hardware-list-info.rst
> @@ -10,7 +10,7 @@ Accelerated Processing Units (APU) Info
>   
>   .. csv-table::
>      :header-rows: 1
> -   :widths: 3, 2, 2, 1, 1, 1, 1
> +   :widths: 3, 2, 2, 1, 1, 1, 1, 1
>      :file: ./apu-asic-info-table.csv
>   
>   Discrete GPU Info
> @@ -18,6 +18,6 @@ Discrete GPU Info
>   
>   .. csv-table::
>      :header-rows: 1
> -   :widths: 3, 2, 2, 1, 1, 1
> +   :widths: 3, 2, 2, 1, 1, 1, 1, 1
>      :file: ./dgpu-asic-info-table.csv
>   
> diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> index 1d50b539677f0..b479c5629146f 100644
> --- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> +++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> @@ -1,17 +1,17 @@
> -Product Name, Code Reference, DCN/DCE version, GC version, VCE/UVD/VCN version, SDMA version, MP0 version
> -Radeon R* Graphics, CARRIZO/STONEY, DCE 11, 8, VCE 3 / UVD 6, 3, n/a
> -Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN/PICASSO, DCN 1.0, 9.1.0, VCN 1.0, 4.1.0, 10.0.0
> -Ryzen 4000 series, RENOIR, DCN 2.1, 9.3, VCN 2.2, 4.1.2, 11.0.3
> -Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1, 10.0.1
> -SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11.5.0
> -Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barcelo / Barcelo-R, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1
> -Ryzen 6000 series / Ryzen 7x35 series / Ryzen 7x36 series, YELLOW CARP / Rembrandt / Rembrandt-R, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
> -Ryzen 7000 series (AM5), Raphael, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
> -Ryzen 9000 series (AM5), Granite Ridge, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
> -Ryzen 7x45 series (FL1), Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
> -Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
> -Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
> -Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
> -Ryzen AI 300 series, Strix Point, 3.5.0, 11.5.0, 4.0.5, 6.1.0, 14.0.0
> -Ryzen AI 350 series, Krackan Point, 3.5.0, 11.5.2, 4.0.5, 6.1.2, 14.0.4
> -Ryzen AI Max 300 series, Strix Halo, 3.5.1, 11.5.1, 4.0.6, 6.1.1, 14.0.1
> +Product Name, Code Reference, DCN/DCE version, GC version, VCE/UVD/VCN version, SDMA version, MP0 version, MP1 version
> +Radeon R* Graphics, CARRIZO/STONEY, DCE 11, 8, VCE 3 / UVD 6, 3, n/a, 8
> +Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN/PICASSO, DCN 1.0, 9.1.0, VCN 1.0, 4.1.0, 10.0.0, 10.0.0
> +Ryzen 4000 series, RENOIR, DCN 2.1, 9.3, VCN 2.2, 4.1.2, 11.0.3, 12.0.1
> +Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1, 10.0.1, 10.0.1
> +SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11.5.0, 11.5.0
> +Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barcelo / Barcelo-R, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1, 12.0.1
> +Ryzen 6000 series / Ryzen 7x35 series / Ryzen 7x36 series, YELLOW CARP / Rembrandt / Rembrandt-R, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3, 13.0.3
> +Ryzen 7000 series (AM5), Raphael, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5, 13.0.5
> +Ryzen 9000 series (AM5), Granite Ridge, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5, 13.0.5
> +Ryzen 7x45 series (FL1), Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5, 13.0.5
> +Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8, 13.0.8
> +Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11, 13.0.4 / 13.0.11
> +Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11, 13.0.4 / 13.0.11
> +Ryzen AI 300 series, Strix Point, 3.5.0, 11.5.0, 4.0.5, 6.1.0, 14.0.0, 14.0.0
> +Ryzen AI 350 series, Krackan Point, 3.5.0, 11.5.2, 4.0.5, 6.1.2, 14.0.4, 14.0.4
> +Ryzen AI Max 300 series, Strix Halo, 3.5.1, 11.5.1, 4.0.6, 6.1.1, 14.0.1, 14.0.1
> diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> index d2f10ee69dfcb..0f822a252fcb3 100644
> --- a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> +++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> @@ -1,28 +1,28 @@
> -Product Name, Code Reference, DCN/DCE version, GC version, VCN version, SDMA version
> -AMD Radeon (TM) HD 8500M/ 8600M /M200 /M320 /M330 /M335 Series, HAINAN, --,  6, --, --
> -AMD Radeon HD 7800 /7900 /FireGL Series, TAHITI, DCE 6, 6, VCE 1 / UVD 3, --
> -AMD Radeon R7 (TM|HD) M265 /M370 /8500M /8600 /8700 /8700M, OLAND, DCE 6, 6, VCE 1 / UVD 3, --
> -AMD Radeon (TM) (HD|R7) 7800 /7970 /8800 /8970 /370/ Series, PITCAIRN, DCE 6, 6, VCE 1 / UVD 3, --
> -AMD Radeon (TM|R7|R9|HD) E8860 /M360 /7700 /7800 /8800 /9000(M) /W4100 Series, VERDE, DCE 6, 6, VCE 1 / UVD 3, --
> -AMD Radeon HD M280X /M380 /7700 /8950 /W5100, BONAIRE, DCE 8, 7, VCE 2 / UVD 4.2, 1
> -AMD Radeon (R9|TM) 200 /390 /W8100 /W9100 Series, HAWAII, DCE 8, 7, VCE 2 / UVD 4.2, 1
> -AMD Radeon (TM) R(5|7) M315 /M340 /M360, TOPAZ, *, 8, --, 2
> -AMD Radeon (TM) R9 200 /380 /W7100 /S7150 /M390 /M395 Series, TONGA, DCE 10, 8, VCE 3 / UVD 5, 3
> -AMD Radeon (FirePro) (TM) R9 Fury Series, FIJI, DCE 10, 8, VCE 3 / UVD 6, 3
> -Radeon RX 470 /480 /570 /580 /590 Series - AMD Radeon (TM) (Pro WX) 5100 /E9390 /E9560 /E9565 /V7350 /7100 /P30PH, POLARIS10, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
> -Radeon (TM) (RX|Pro WX) E9260 /460 /V5300X /550 /560(X) Series, POLARIS11, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
> -Radeon (RX/Pro) 500 /540(X) /550 /640 /WX2100 /WX3100 /WX200 Series, POLARIS12, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
> -Radeon (RX|TM) (PRO|WX) Vega /MI25 /V320 /V340L /8200 /9100 /SSG MxGPU, VEGA10, DCE 12, 9.0.1, VCE 4.0.0 / UVD 7.0.0, 4.0.0
> -AMD Radeon (Pro) VII /MI50 /MI60, VEGA20, DCE 12, 9.4.0, VCE 4.1.0 / UVD 7.2.0, 4.2.0
> -MI100, ARCTURUS, *, 9.4.1, VCN 2.5.0, 4.2.2
> -MI200 Series, ALDEBARAN, *, 9.4.2, VCN 2.6.0, 4.4.0
> -MI300 Series, AQUA_VANJARAM, *, 9.4.3, VCN 4.0.3, 4.4.2
> -AMD Radeon (RX|Pro) 5600(M|XT) /5700 (M|XT|XTB) /W5700, NAVI10, DCN 2.0.0, 10.1.10, VCN 2.0.0, 5.0.0
> -AMD Radeon (Pro) 5300 /5500XTB/5500(XT|M) /W5500M /W5500, NAVI14, DCN 2.0.0, 10.1.1, VCN 2.0.2, 5.0.2
> -AMD Radeon RX 6800(XT) /6900(XT) /W6800, SIENNA_CICHLID, DCN 3.0.0, 10.3.0, VCN 3.0.0, 5.2.0
> -AMD Radeon RX 6700 XT / 6800M / 6700M, NAVY_FLOUNDER, DCN 3.0.0, 10.3.2, VCN 3.0.0, 5.2.2
> -AMD Radeon RX 6600(XT) /6600M /W6600 /W6600M, DIMGREY_CAVEFISH, DCN 3.0.2, 10.3.4, VCN 3.0.16, 5.2.4
> -AMD Radeon RX 6500M /6300M /W6500M /W6300M, BEIGE_GOBY, DCN 3.0.3, 10.3.5, VCN 3.0.33, 5.2.5
> -AMD Radeon RX 7900 XT /XTX, , DCN 3.2.0, 11.0.0, VCN 4.0.0, 6.0.0
> -AMD Radeon RX 7800 XT, , DCN 3.2.0, 11.0.3, VCN 4.0.0, 6.0.3
> -AMD Radeon RX 7600M (XT) /7700S /7600S, , DCN 3.2.1, 11.0.2, VCN 4.0.4, 6.0.2
> +Product Name, Code Reference, DCN/DCE version, GC version, VCN version, SDMA version, MP0 version, MP1 version
> +AMD Radeon (TM) HD 8500M/ 8600M /M200 /M320 /M330 /M335 Series, HAINAN, --,  6, --, --, --, 6
> +AMD Radeon HD 7800 /7900 /FireGL Series, TAHITI, DCE 6, 6, VCE 1 / UVD 3, --, --, 6
> +AMD Radeon R7 (TM|HD) M265 /M370 /8500M /8600 /8700 /8700M, OLAND, DCE 6, 6, VCE 1 / UVD 3, --, --, 6
> +AMD Radeon (TM) (HD|R7) 7800 /7970 /8800 /8970 /370/ Series, PITCAIRN, DCE 6, 6, VCE 1 / UVD 3, --, --, 6
> +AMD Radeon (TM|R7|R9|HD) E8860 /M360 /7700 /7800 /8800 /9000(M) /W4100 Series, VERDE, DCE 6, 6, VCE 1 / UVD 3, --, --, 6
> +AMD Radeon HD M280X /M380 /7700 /8950 /W5100, BONAIRE, DCE 8, 7, VCE 2 / UVD 4.2, 1, --, 7
> +AMD Radeon (R9|TM) 200 /390 /W8100 /W9100 Series, HAWAII, DCE 8, 7, VCE 2 / UVD 4.2, 1, --, 7
> +AMD Radeon (TM) R(5|7) M315 /M340 /M360, TOPAZ, *, 8, --, 2, n/a, 7
> +AMD Radeon (TM) R9 200 /380 /W7100 /S7150 /M390 /M395 Series, TONGA, DCE 10, 8, VCE 3 / UVD 5, 3, n/a, 7
> +AMD Radeon (FirePro) (TM) R9 Fury Series, FIJI, DCE 10, 8, VCE 3 / UVD 6, 3, n/a, 7
> +Radeon RX 470 /480 /570 /580 /590 Series - AMD Radeon (TM) (Pro WX) 5100 /E9390 /E9560 /E9565 /V7350 /7100 /P30PH, POLARIS10, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3, n/a, 7
> +Radeon (TM) (RX|Pro WX) E9260 /460 /V5300X /550 /560(X) Series, POLARIS11, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3, n/a, 7
> +Radeon (RX/Pro) 500 /540(X) /550 /640 /WX2100 /WX3100 /WX200 Series, POLARIS12, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3, n/a, 7
> +Radeon (RX|TM) (PRO|WX) Vega /MI25 /V320 /V340L /8200 /9100 /SSG MxGPU, VEGA10, DCE 12, 9.0.1, VCE 4.0.0 / UVD 7.0.0, 4.0.0, 9.0.0, 9.0.0
> +AMD Radeon (Pro) VII /MI50 /MI60, VEGA20, DCE 12, 9.4.0, VCE 4.1.0 / UVD 7.2.0, 4.2.0, 11.0.2, 11.0.2
> +MI100, ARCTURUS, *, 9.4.1, VCN 2.5.0, 4.2.2, 11.0.4, 11.0.2
> +MI200 Series, ALDEBARAN, *, 9.4.2, VCN 2.6.0, 4.4.0, 13.0.2, 13.0.2
> +MI300 Series, AQUA_VANJARAM, *, 9.4.3, VCN 4.0.3, 4.4.2, 13.0.6, 13.0.6
> +AMD Radeon (RX|Pro) 5600(M|XT) /5700 (M|XT|XTB) /W5700, NAVI10, DCN 2.0.0, 10.1.10, VCN 2.0.0, 5.0.0, 11.0.0, 11.0.0
> +AMD Radeon (Pro) 5300 /5500XTB/5500(XT|M) /W5500M /W5500, NAVI14, DCN 2.0.0, 10.1.1, VCN 2.0.2, 5.0.2, 11.0.5, 11.0.5
> +AMD Radeon RX 6800(XT) /6900(XT) /W6800, SIENNA_CICHLID, DCN 3.0.0, 10.3.0, VCN 3.0.0, 5.2.0, 11.0.7, 11.0.7
> +AMD Radeon RX 6700 XT / 6800M / 6700M, NAVY_FLOUNDER, DCN 3.0.0, 10.3.2, VCN 3.0.0, 5.2.2, 11.0.11, 11.0.11
> +AMD Radeon RX 6600(XT) /6600M /W6600 /W6600M, DIMGREY_CAVEFISH, DCN 3.0.2, 10.3.4, VCN 3.0.16, 5.2.4, 11.0.12, 11.0.12
> +AMD Radeon RX 6500M /6300M /W6500M /W6300M, BEIGE_GOBY, DCN 3.0.3, 10.3.5, VCN 3.0.33, 5.2.5, 11.0.13, 11.0.13
> +AMD Radeon RX 7900 XT /XTX, , DCN 3.2.0, 11.0.0, VCN 4.0.0, 6.0.0, 13.0.0, 13.0.0
> +AMD Radeon RX 7800 XT, , DCN 3.2.0, 11.0.3, VCN 4.0.0, 6.0.3, 13.0.10, 13.0.10
> +AMD Radeon RX 7600M (XT) /7700S /7600S, , DCN 3.2.1, 11.0.2, VCN 4.0.4, 6.0.2, 13.0.7, 13.0.7

