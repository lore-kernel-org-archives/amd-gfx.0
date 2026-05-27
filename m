Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27F0CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 20:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BFA710E9D3;
	Wed, 27 May 2026 20:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LL8rNmWq";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013022.outbound.protection.outlook.com
 [40.107.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E297A10E9D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 20:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBxsO8wptxXh7eBiHkYzeW2VrnRVAOljR8FIOooertH8Q8/dQpmodZc7wB8l1gAxirCNSg6shzItiyJx0+8aPSi79e4hbpTt0FJgF650+eeqgFGoSOqiU8iLYJpbO4LUZrlxq21Pu87dQ8BlFgB18KNglTajBLyxaTzuADoKazrTA0SaVtKp3c/7kkGGdmMPikaTLiAX9rzUdimCfr8wzJZLkr7yd2Ncdr7wUe8e3JFqiElQEf9G6lsmH5qlY8TTkMoj77y+2F+oK002A6SfscbJuoAxqTtxFPM6sc/BOJ/OWMEEXb06+Wruf+mTqLJm5Onqt1qGj6XKwYNKFf5ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDGGAPR/56YR5zz5gZ+bDNlKidqHHjzgrjlTK7PqOg4=;
 b=DkPkQ/kVGFshBm/hv+RX/+HLk6zijfle5n5P4WuDbO6t/cl9z5caygFNzmF+/BKNzj3JkUT1dDDaJZj35y4Dxnx4IyLEOI9/DakEThfGpwJYwSvc+i2nPct/Dq6OY4UTZb7siM82pO+vPVYlk4y6azEm1mE4WqF/mcYRoGIiuKzsRGOWFRAhWjsqHm7GnHHtk+RQI711uSDKIAR7ep8KBrgkNthCPiJq8BAzQXgIA2KbigKk4T4tzxjc+i1BsupuoWZYmZw9Fk3kidTnJ6OxZlA78w600+FVi0MuaGw8UbVj66UF8TJ6BcXiMGa7yqvZVTxLFdF3CxFUD9qMF7R4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDGGAPR/56YR5zz5gZ+bDNlKidqHHjzgrjlTK7PqOg4=;
 b=LL8rNmWqw/+z0vydgqZ4sI9QJ/J7wvsTsqGzJFD+P92nS7dh+P75Q1/nAxwSjv5p+x7lXc0MmeKeyKb2/CSX0BHc8Eim7TcpVqha/ljVvJ1Ig4U7R7K8Cp25SMMuEUzxtBg+aGz+wbASSqFflV/U4wh6BO7+Ww/C+soUv1M51vM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CY8PR12MB8314.namprd12.prod.outlook.com (2603:10b6:930:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 20:30:18 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 20:30:18 +0000
Message-ID: <2ca1a5f7-7882-4f30-b0a5-6c190cfdd86d@amd.com>
Date: Wed, 27 May 2026 14:30:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add a default case for dc_status_to_str
To: IVAN.LIPSKI@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
References: <20260527194151.2253853-1-IVAN.LIPSKI@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260527194151.2253853-1-IVAN.LIPSKI@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:303:2b::6) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CY8PR12MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 678bc19f-6c0a-43f5-8981-08debc2ec47c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3rHvfw3nuJc2Mn5loQQimA1hw++V3C3nIeUp9v6GY1Gku8IPFMptol+H7gvnjGdRkAhp9/w/mhD4OQv3uyVKoPc+yeRGBmnUzm0K4pxIBCQ1afBLFRovhgAmX6QSHuXisvQF+LJWUEW02DolIa620QzzsOH+N8vgwrtY30X/vqkNEKPxgXuU/xSzarl1BIH22hERpf9FsnMSuB+7WrDfLAq+XncM0NAMW9kufIOtKP4p9yyu6i7gnrO41TBcUMNBhKHUBJt9ElTeZO1yXFgbybvvTiRCpdOJPXx7BO7x+asOfYf/Ffdkh3njCFU5ZrkxILFkL+RknsNHQFJoLC1J1sUGum3mPoYdhiAm47ebixhzeHeaXVGVgM5d1twKg/hvfH4bm8YL6BQY1TwOr0naAW8jAOzw5SErU1pdowG3BVxi5SncPNdu9AaW38Sij28O31as4sbsgdKon3/7IYNVF3y0LkSc35JgstV/ezQ2leSBvirx+ZVZ8eR/d8sIxnkndn/vjJs/z48IArP1EW8K87FUN9k+WD751FvKoUs9Kgn0Gy8fhTwrrIxiaU5AnwOSeNRRbpGtgf4Ul2TZhYYagWP22KOQqDeXKiAx8oIFRRPB+sAOi8MTWp31DsZ6PhIQVbFbTS8J+JfGyAhUNuNJ1b4Xt10+uONTpaRuOBPQkLCv0AVgHz/E8aZM3Nsgcn/3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnN6ZVZxOVRTT01lREM4M3BFSU5iZ1pRNElaMmtYSnQyWWFGTHFIV3gxMG9l?=
 =?utf-8?B?ODRyaTZLbk1CWHJwZ2ZKZDYwcnF3cVJDYnJFQmFST3MrQzdWcnBaOG9UTUlK?=
 =?utf-8?B?cUJMTUw1UXMvODBRMlB0Z0ZKQUJnOExJY3AvRExka0lrYWpTUkkvM1F2NEd6?=
 =?utf-8?B?c0Q4Q2lIQ1B5MitYV3lSWGRna0FvcW1TRHpqa3VRTC9iYzA1ZDN0WnRoTFpX?=
 =?utf-8?B?ZlIwOCtwRk9HZ1FKS1pmQ3hveEJ5SlVXNHo3bXE0TmVlc2Rqc0FYTFMvTFhF?=
 =?utf-8?B?S2hsUzJyVVRjMzNWM2VMU2U4SHp3TElHZG5Ld3JDVnJ6ZHJwOGw5Yk5WUHJR?=
 =?utf-8?B?Vkgrb0dEU1VNbDhrKzg1L25PUmJ5NnBZY0xOYVpqMkpyTnprdkRlZmY1and1?=
 =?utf-8?B?bEdWdVVGbFV0enUzcTBRbUJjcDdiUVdNZXVyR3VLM3drb3NmOTltYVRNZ0xh?=
 =?utf-8?B?b0FWdnEzam1INXBwUlhySzVaOTJSUDFPWmtabmsyVTU3THFEVGo5NFozN2Rm?=
 =?utf-8?B?ZVg4cFBtYm5yMkc2WjdRaVlzNlFod3M2SVl6V0w3MlJoQUg3dyt2TGtBaW9r?=
 =?utf-8?B?T1J5dnFkVm04UkJ5MGc3djVlQ21DTHdiYzJUUUVsdWlpT0pZTDVoZjFDTkxp?=
 =?utf-8?B?ZTZnTjJVY0FzUE1PeEExcG9wNDIrZk83aW1MSXlNTmR5VTlCblkxc1VtM2kw?=
 =?utf-8?B?bm44TWRkTlFFVDAvRk02aEFCQmREblBsU0FMQ2YyMmtTaTZ4clJmRk42OG5P?=
 =?utf-8?B?SndrM0pFOFl6NHczWnhxQmluQ1Nlem53L2ZtMHpSZFhEdHNhcHFxVy9TdmJW?=
 =?utf-8?B?ZEIwWmZRRlA5YU9seGpCTW50WUU2eHY1NXE4NnoxeGtoSzhVcU9ZaWp5dkhR?=
 =?utf-8?B?cXk4KzNqMGZkVmkwcVUzWVlyTXhEbzhUWWhyZnV1L2ZYN0dKSFB1VW5CRXBk?=
 =?utf-8?B?UmlOZWNEdFNVeVRnS0k2bnNDNkhmYnFGTjJPRG0rNVJQbVM0THJrODA2U1Z6?=
 =?utf-8?B?NUE5eUQ0bTdrSFI0TGRZUituOGpNUUZBZjdwTW5FTlVrYjU2Y0VCaGZVY1Uz?=
 =?utf-8?B?QzhVS1RLbFhLZS84eWRCNEJaQi8xdHlUck9vYU9wVU9zLzRQeXE4YS96NHVy?=
 =?utf-8?B?SlAyL1JuVkVESDB0NG9HSEdGcnZzRXlTbXR3Vm40V3Q1QUFmZ1N3R253U2hQ?=
 =?utf-8?B?azQ5ZHZ5ditCN0lRaHFpOE1iYjh0bnJRUlJiQjREVEsyZUFEaHRTcmVCc2U3?=
 =?utf-8?B?ajhLM3BLNFQzclNJNkFhcjRrenJsR3I3cFZISUppTU4vWFluSmxNQ0I1MU8r?=
 =?utf-8?B?dHltU2s4ZXREL1hSczFsUFBkTHRqNEdLRnorQWhscGF0TGhtTS9JSDRsNTN5?=
 =?utf-8?B?ekc1aHBaS01pYlI3YnRtdURSN25LU0VWdGRyRWlXdGFydGM1bTlOUDRXQ1V1?=
 =?utf-8?B?UE5EZnE1eVpxUUdKTDlkRkU5eTdiWlkrUitXU041Y3V0N2pweVFqbXpBTnVJ?=
 =?utf-8?B?TjZMcjZjVENyaWRlWjlsYmE1VjM4cnV5cTdyejNzS3Fldm9pYmt1TS9XQ0RK?=
 =?utf-8?B?M08rNGRiNUl2QzJia00veTdYTmtlVksycDlFSHc3U252dXBGQ1Nhekc3NS9R?=
 =?utf-8?B?WmVHQWhtYVoxNjJKZk1ubENRLzVhUVJJTWJCQU13TXRDcHRrd0VoSnM2dkJh?=
 =?utf-8?B?N1IxeUh5cmpTY2MrVlM4SFFWVzlpR2RKZm51OXF1Q1hOQW9HSmJuK0RxY1dM?=
 =?utf-8?B?T2U4a042UUp2Z09peVBHZXpIUlJlNkRJNGJsV0J4eVlNY2hiK0FtRHRESWNa?=
 =?utf-8?B?cnZ6ZXYwc0RIYm0zT0FkMklDWVJZTUEvSEJibm1RcVdCVUtHajluVWI4ekFk?=
 =?utf-8?B?M1YxaGtjeFpCbE41czVzdXh0MkowQi9sUFNYRmZUZVdLMkpqc0pmeUhONWJh?=
 =?utf-8?B?YTRnWk82bXI1NjFFVElWMU96SXVMNzJSc3pSZ1EzUHFzejNQUWV3cWF4V294?=
 =?utf-8?B?eG8wSWJGWjIrRDg3SW56WldqZjFLYVMvRFZDVnFmcHhZeUM0SkVMSEFwaStV?=
 =?utf-8?B?SEF3VVpoU3dYRWZNc0IxU2VLY2RnNXdJbnlmUHkwd3NZZG5QYlB0Mnc4Z1FJ?=
 =?utf-8?B?aVQ3TjZQZEk5elovWGVwTURIeDNwcm45Ti8vbGYvVDU0NDdmaDRTdUx4Zk4v?=
 =?utf-8?B?N2NyN3ZWc09kUWhSTWw3WTVna3FWdjRhZWZUNFArYjBhd3hIN2FESWo5TjY5?=
 =?utf-8?B?WGNIQUl0a1kvaDVkK3BWTmJhMkxmeDZ6dkRqN1lKakNmekpvWTkvOW84T1BT?=
 =?utf-8?B?NUJMdjZ6QXJ1OXc4RUV0ODJZMnNmY3dvOSs4REp6N2NFcDc5cjhOUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678bc19f-6c0a-43f5-8981-08debc2ec47c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 20:30:18.6846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4wb81N0fh/EPVvJih0TzplL+9Q4/+zqp6nuVTZ5ZboRLh5WUoxI+7n9bg+IiRCFbJtRoSeE7+V97XAjwd0XmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8314
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 5/27/26 13:41, IVAN.LIPSKI@amd.com wrote:
> From: Ivan Lipski <ivan.lipski@amd.com>
> 
> [Why&How]
> If a parsed dc_status case is not covered by the dc_status_to_str, the
> switch case is skipped, and the function returns
> "Unexpected status error".
> 
> This causes build failures when new dc_status enums are introduced.
> Changing the 'return "Unexpected status error"' into default resolves it.
> 
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_debug.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
> index bbce751b485f..44028ba88f80 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
> @@ -272,9 +272,9 @@ char *dc_status_to_str(enum dc_status status)
>   		return "Fail DP Tunnel BW validation";
>   	case DC_ERROR_UNEXPECTED:
>   		return "Unexpected error";
> +	default:
> +		return "Unexpected status error";
>   	}
> -
> -	return "Unexpected status error";
>   }
>   
>   char *dc_pixel_encoding_to_str(enum dc_pixel_encoding pixel_encoding)

