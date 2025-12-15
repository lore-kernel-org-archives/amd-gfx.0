Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D29D41D74
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 10:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4384A10E3ED;
	Mon, 15 Dec 2025 10:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xY9y6RjL";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010023.outbound.protection.outlook.com
 [40.93.198.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB2C010E3C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 10:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C86GRJ2SO/Ju8S6vb08tNmNne4Ks1HO/0/T4irjPyJkCrfUu8HoRK7ZSobfqcYIGVOp6tYFqmi/23EBkBj6FesBWhYeVH11e6htck+NpjDdhb5A4+WEs4KmVADmgkRc4RFr2QCY9zYXIUT3sj9Bpu4pj/iCCXEdFyqCx2HmPRetAfWrCZvoaxXNC6jpJm8zjdOgb0Pv2ttDN8wHncxxMt4gVG40RgUN4rFefPdHD+iePtEv6+is94KDnccDw9AgXlce+7a3syK6yS6f1ha1qFJgTOT6SnOhsBN5JgQMSHy7PDZdKSHLrSW9hCUFPTreksYnOEmaAc9OikvJQVirRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4Fk4bV+496llW76l+waj6JPoqe03B3NntJXywCZYzo=;
 b=C3OiOvlGkHZ2A1RQzd+9bbL6R+vVQLcLL4O7BQUpAhCBIE1x1qbTaDG6ZBlmDYO7UYq1FqlVVOMeXct38KerBttLE6xEl/5vloDp+axKX406MfpA1bYG7vXPBwKAxSrBIIwjEnNEvPejAs8uug5QTi9zxOUPvMmSujJUNlhgEJ8PcMs1xJ5dhq+6kH0DbHkGqLSwK5CLe+GIKV05Ebh15nWk8UkLJzRfijILI3LwoYLoybze+D1vkWufy8kksoyX7tFIWZKldUPrpHT5zNzhasd0qjZbPlNsXALL/oONOqV2Ub0yUcWSPMvOtiejrWq4tZRVvBim5YFNk6LHwhLqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4Fk4bV+496llW76l+waj6JPoqe03B3NntJXywCZYzo=;
 b=xY9y6RjLYTY7p7Jkugn+AtH90tYn58YPvq7R0l+/EBcEHJdNxsQbchKj9RdFJQIaMuW/vGy7dnCMYTnkFjBZOdud3+09TFAb8G89CtCFWS3StXhnknsdqkpOUgNAUBQdKIokV/Q2pUt65fqrIZsKIhMbeJnbcY6iLdwpRaBmR84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 10:19:36 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 10:19:36 +0000
Message-ID: <bc2c2437-a726-482b-9f97-6dacd6978627@amd.com>
Date: Mon, 15 Dec 2025 15:49:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/pm: force send pcie parmater on navi1x
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com
References: <20251215095735.977069-1-kevinyang.wang@amd.com>
 <20251215095735.977069-2-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251215095735.977069-2-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: b170f84e-db53-4693-a310-08de3bc37253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGhaR0NKdUxGOXFzUEtyM25TY0xVcDVaWUZQMmtuKytWQzd2OHc4MDhaMERK?=
 =?utf-8?B?bkJSZWhPaUdqTWk1Tm9PNjJyaGJsMk1nUk5uTHRhcUQ4c3A1djhxckpjQk5r?=
 =?utf-8?B?NjNLNWh2dTdheWJwYzBJRzI2T3JqQmk3T21LbktzQnQ1T0tYNEg1U3pqMjNO?=
 =?utf-8?B?R0I5OWlKODUweTN0b01CR2dLcXJGNjQ2ai9INGFmQkIyTUxlYlE5MEFGVU01?=
 =?utf-8?B?RTN2TCtFYVBsY212MVFlMHZTTEV1WUpsY3FLaUprOUpWYU1EcGc2U3pDOU5S?=
 =?utf-8?B?STJsK1N1ZTNQN2tCUjR6cWRxT2R0UFc0cHhlRFhCQW00WHZndUxGd3draXl3?=
 =?utf-8?B?U0o1dncrMjN1Y2NkUXBEK3Q5K1dnYzl5RG5ZYUlxUmVkRlFaSGFGdS92N2lx?=
 =?utf-8?B?S1dxUHgzd0NaR0V6U3NZV1BWdE9NckM4b0lIbE5abzE4ZXF5QnF6cCtBeXBl?=
 =?utf-8?B?bk9SeHVSQ09RRTM3ZlRicWdlaVRzZWFqRG1uSUpPUHdtTGFFTzFoakZUMUhl?=
 =?utf-8?B?STVWaHlwc0w2Rm00T1c3NFY2bVU4K0ZPMExNNjZGVUVSKzRIdWNrZTAwVDN2?=
 =?utf-8?B?S0tIZUNuTFBjK1VnN0FUdFBkeFRBWmVvd0JsTkpDVFg4dExhaWpyVGhDcU5C?=
 =?utf-8?B?YkFzb1dIWWE4L2JOOWV1WWRnOFhHWE1yWFhMeWY5UmRQVm5wVjltRldPM3ZP?=
 =?utf-8?B?WVdhWWVtMS83ZlBMMWJwQXJmWnE4SkJGczlKdDRsUU9JOHZkV01GOVh2RFoz?=
 =?utf-8?B?ZmJwRFNLVk5vM3JwbkpPNk40M2dXVUV1WnFSSEU2MVNTRjRvTDd5dnRRQmhZ?=
 =?utf-8?B?NGFaL0Znam1hbmNVTHhSM0RhYlVOTXQwbEtLSjNaOUd2cEkrQTFXWE9kYlBm?=
 =?utf-8?B?R2tiNDU2R3Nyak1CZ25jOVBLZGtISjB5LzVtNmtFWFcyMXFvM3U4dnE3UHgx?=
 =?utf-8?B?N2hhWUFBaVZVOE1jUnNoakI2bmZ3TElWeDhBYm42ZmF6bTZ0cXlIVm1GeWwx?=
 =?utf-8?B?bloxZWtkZGQya291anBvejFzWkxjZHRmeVpPNzdjVmJQMVlTbFlrVUZrMXJl?=
 =?utf-8?B?bXVlejV1R3pyY3d0c1R1TEc1cnI5bmJENWF0bkhja2tSMUlRaG8vcVlCd2Zl?=
 =?utf-8?B?ei9vSUh5VVkwVnFTN0I3MFJ4aFRRUS9uYU1XeVlxbzZZcjVKM0NMV09jWkxo?=
 =?utf-8?B?c0dPUyt1c2hSa3ZiNGtKVkE5Ulc3dk9WREFBa2tLaXRaNnlyY2RLNkF2WUVa?=
 =?utf-8?B?T1FHcVk5L2pwNm4xdUNoZ2hRZWFZOE5KOXVaajFaUnlIQi9iejNzZXE2VU5y?=
 =?utf-8?B?UzQxTE0vNUY0MktGOG82anFlbHFrdkdOYm1uV2ZJOHdaL25JY0E2ajE2czdI?=
 =?utf-8?B?UU9yQXlSOXoxWjVnclJmMFhiQ3lJNVVMQmdOQmVDbFc5ZlVraEdPUDBJU21k?=
 =?utf-8?B?TzlXNWFrWEkvNVZCbEp6WC9XOWRJdFZKUCtqbE1VQUVPMTZsYk5XTmFqQ2xJ?=
 =?utf-8?B?ZTZDcTE3SXpRQVZ4L2xDVVdESHVjK0ViR3l6MW5jQ0ZZUHBSWk1odXBCekxn?=
 =?utf-8?B?TVpmZUxQYWlNQ1FmYmtDaDlxVWt3RW9tNk1abUkyMDE0WnFDUENZYVpNOVU2?=
 =?utf-8?B?ajV4YVpyYWppdU1ETk5jTUM0UWRjdWRDRk5BMEF4cWhhS0gydllJMUo4Zkds?=
 =?utf-8?B?czIzYldwNUlsa3I2b21UczhFc1hzRmd6TktnK1lXY0IwdTNzQVJQQjNMWkdx?=
 =?utf-8?B?ZzV0dmQ1dkRUMythRlBuY0JCbUZuZ2E0VjZnS1VUMlZ0Ry9lU1Y0dzRmZldU?=
 =?utf-8?B?RUpmMU5mOC9yczB5U3RIVThWRmEwTFJxVlhCcmN1MXdyUTArZWFQeHJiamh5?=
 =?utf-8?B?WllzRjhZQjdTNE1Rd0JBMFMvdHdsQTh1enF5dGtoRms2RmlYaWcyNWo2K0pw?=
 =?utf-8?Q?sUN7Y8HpSTASHDvBOLHJINyx8NLdiHT+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVA3QU16THZ1L0NYNUxWMHdDRmd1Y3NuNFc5MmtINGNtcFNXUUt0Q0lYcTdB?=
 =?utf-8?B?Z0tvem9qZEw0RmptVERLSHFzNFV5UFQ4c1B5WlVoL1VRWDk3UVFCQWpkbVdE?=
 =?utf-8?B?bk9TRitHYVBDMnNmS3ZhaitUZmIyRVFaMWYzODZxM2ZFV2g4YVVwNnFGcVpj?=
 =?utf-8?B?dFFYdGxtaHY2RExJMEwvQ0dYRkFZU3E1SC9lTnF0YUs0RGplMlNXMzh3WU9C?=
 =?utf-8?B?ZThZaHNXZXR5NktIbkF6YmNMa0FJK0QyVkVNckNyOVhwZHJIRStMT0ROOTU1?=
 =?utf-8?B?WnU3UXk2MmhlbnVKQmNoNVZoa2l4U1pYYy9BOVVlZWNIeG9BeElmY0NwN2x2?=
 =?utf-8?B?UUs4dkJ4cHdOeGU4aHo0RVhTS00xckxyUzhGMkxHOXdocW84K24ra2habmVn?=
 =?utf-8?B?TjM4K2gvRlFxUTkwVUJHUGNyR1BsK1FxV1QwdXQzQlBudGZ3TVRXeXk0L2Rq?=
 =?utf-8?B?cnRudnVpUGJ3cnV1NVJyQmFEVUVlQTFObVhSU3FxSzBYa1BCeSszZDVaRnVV?=
 =?utf-8?B?WEFIUkttODVudGVYMXRsQmg4RzEvSVZLTTFqZjRzVWd1M1hOdUtlRDhFUlRR?=
 =?utf-8?B?M3VUQmRPcEZJYnVxNGo1cERFTjFhZFdMczhzRDRYbnRPNDVJMzVLWkhLKzJJ?=
 =?utf-8?B?NS8ydHJuYU9kZHZITWwwUnBSRGU5L21KWXU1QWRtdTJvVDQ1VWMwVTVFNzNq?=
 =?utf-8?B?WDl2TlVIUmlVMG0xWWlEc2lQdWdHTko5Qk8wVm9keHY3VHEvcWFuVEo2dUFM?=
 =?utf-8?B?dDlramEwY0swd3F5TXFGZm4wclQwNW15WTdMWjhOOTcvQm1DVzhRVHhHUWhy?=
 =?utf-8?B?WGxOdkZtUElIYzVQTFIyYitDTUJ1SUpLb3EyS0FpWS9uYStSS1hmSlhMckdP?=
 =?utf-8?B?VWptNXp6RTlOOGgyTVBQZEhDWmZDUDlML3BoWDFUaC9PR1FRbXJ6b3UvcFlU?=
 =?utf-8?B?WUk0bHBrYlhYSWFDTnk0M0pSVVJ0RjJpN3p3ZTRvd1NLWVA1L1hVUzFvcFEv?=
 =?utf-8?B?K3k4bkpwNjVERStnRmpYZ1FSZEdsbUhreis4WXRJSkJjZWRkWkpBUkUxN3Q1?=
 =?utf-8?B?Nm1SWDArODYxVUNDa0wvTUJjSmpoS0piMTZmSTdCNStXSHhMVXlZN3FNdFBu?=
 =?utf-8?B?czdXTFFkdUJPL1REMzdORnNrOHUxN21ON3UwU2FyTFZRbWtyZHZLbDBBalU2?=
 =?utf-8?B?b3A3bzhYRVQ2ZEdxTk9MbkZWUUZheEdSeWhWNkhWUml1UnRiTDE5dEhXN1dQ?=
 =?utf-8?B?UkcxMFl4bk5zQVZ3YXRzTWw3cHEyVXBLZmQxSklRYTBDcUlzNVV1MW5lcGFQ?=
 =?utf-8?B?QVR6Y1AzT000eVNqcTBkYW9oVjVrNXgvOHNrZXdTRjZNQXYyWWJqODQzWW5V?=
 =?utf-8?B?VGlHbnRMZGUzalBqRloxckVDMG9jNFF4V3JpRE9sOUxLRzRXeGJkVm9xL0tF?=
 =?utf-8?B?Qy9UT3dRZVVtRWdMM1BZcXQwUUxjdm53Z3dGdFpScEFKWGluenhRMnBxSkk5?=
 =?utf-8?B?cW14NEFZbjQ2VXVuQjhrM0hyK2xjR0w0VmZNeUdnMC9xR1kxdkljSkVIaDl1?=
 =?utf-8?B?TFROcmphVEMrb1k0WFhvb3pFMXdreGxQOStPU0Vnd24xMkUxaWlnZUx4ZlVj?=
 =?utf-8?B?bm9FamlXMzV3ZE8wYVFqZ084Y0V3bys5SG9IVFNSSzNJeUVtSGFQKzZzdURw?=
 =?utf-8?B?b0drbDQreXNZZmxZdG1takdBQU82RDZ6WllPQVlTMVJ6SjhaN1FBZ1J3T3Va?=
 =?utf-8?B?K1VPckxhc0E3U08vdjBRY3BkV2hPMnBkazF1R2ZIbmpuV25hV3ZmZEVqYnpS?=
 =?utf-8?B?SmdHcTVTMXUwWDRBQS9jMDR1Q1lINmZTMHphUXBSNzhKcGFTNHg2Y29ZQ2w2?=
 =?utf-8?B?U1VIcHVudUZnZTBUejF4dDZsWFlyUjdaTUo3OHRJQURON0tuQW14b09JV0sv?=
 =?utf-8?B?eGZuQ1FRbTdPckRkVmg5RGlZWmwzVkZEV3V2aUduTFNqYjVEZ21rellBMzVR?=
 =?utf-8?B?bVRjM2hIelZGK0gxd1JJZTlseGprazh0ZVA1SU1OZzBhOUFFODlPSVdGbS92?=
 =?utf-8?B?RHhvcjhRNDVpcTBmK2xsRmtIWGdFT2tlVTBPYXRCbkRrWG15Z3RrK0RhdEI4?=
 =?utf-8?Q?hyYlDxF8oiZHXVtboOfkZw/Mr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b170f84e-db53-4693-a310-08de3bc37253
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 10:19:35.9329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7ZIRBRoe/xm28crGiQbDv40NiLYBeq0IhiXamfTCTp1BYOYVJsIcELSYbfH0Qed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317
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



On 15-Dec-25 3:27 PM, Yang Wang wrote:
> the PMFW didn't initialize the PCIe DPM parameters
> and requires the KMD to actively provide these parameters.
> 

If this needs to be provided always, shouldn't this also revert the if 
check introduced by

1a18607c07bb ("drm/amd/pm: override pcie dpm parameters only if it is 
necessary")

Thanks,
Lijo

> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 0c26fe6fb949..96dbb7a9d9fb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2215,16 +2215,16 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
>   			dpm_context->dpm_tables.pcie_table.pcie_lane[i] =
>   									pptable->PcieLaneCount[i] > pcie_width_cap ?
>   									pcie_width_cap : pptable->PcieLaneCount[i];
> -			smu_pcie_arg = i << 16;
> -			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_gen[i] << 8;
> -			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_lane[i];
> -			ret = smu_cmn_send_smc_msg_with_param(smu,
> -							SMU_MSG_OverridePcieParameters,
> -							smu_pcie_arg,
> -							NULL);
> -			if (ret)
> -				break;
>   		}
> +		smu_pcie_arg = i << 16;
> +		smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_gen[i] << 8;
> +		smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_lane[i];
> +		ret = smu_cmn_send_smc_msg_with_param(smu,
> +						      SMU_MSG_OverridePcieParameters,
> +						      smu_pcie_arg,
> +						      NULL);
> +		if (ret)
> +			return ret;
>   	}
>   
>   	return ret;

