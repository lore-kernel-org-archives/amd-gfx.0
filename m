Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9D1D25B59
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 13:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D9C210E2BC;
	Wed, 28 Jan 2026 13:04:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B4jmbIuy";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010007.outbound.protection.outlook.com
 [52.101.193.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9236A10E2BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 13:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdzpqs7bYmdhCHqXI9r3Sm8aVQFjUQ3wDWQEhSWhELbBV4vMN6Z3SyRG5vNXKznOeSKRAPz8uPIss0YAQI2cef6aKYoNmNjDqzUAhfoGbAZR58N1FqyQSdi9Li/RRfh3QxDCiHMHgZt9ShArHrmqg/7aXsCWaQXYq0Albk9tv9IHQrhxKRyVRxYPbznPsMhutHhZBzaX34vCO4Xb5nFC/mwec5/bf9W7nmCD+VrRjuLLLOhy9Lqdo3YoHaTvG1B9DN+AuQaCQa7aPPUR4otOYNeAcpUR8oCxFbQNx7K9P0mf7gkJxt+szTVDQIy9IWTIVS0zkKKOT7o6bqXhEMOXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFSJFG8IZkMceK5A0oWzJV3/OYRYj7rqEcn24ltpX6w=;
 b=DBiopdVypujh+TtMuoiF6FfC/emeNXFemFEhIfY38TxeTUAcc06vdFIizXXSeRH1AuM+pxJjzhp/MWAlKdU8XNbu1ARh5lha52GDAG2BnckVdC3wTXO8nBL8flZ0UMszoND3b+O9YIqyyWMxb0g9C6jIwSuPzWZJc97bT0GBeowirYrYrgIKhP1srYm0pFHOybTTY6sOlamZrP4Jcr4Yr3fhBCGbuS/UXRc5uApsbL53taj1y3R2z+bEXBgJI9DtL/mTQmk5W6BOL4COZYUQ3fgEaUQG5dIU1Y8xcDXOdMeh8shClNwoG4MuJ4klnqGJRg1+ifW389CcHXcYE6hweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFSJFG8IZkMceK5A0oWzJV3/OYRYj7rqEcn24ltpX6w=;
 b=B4jmbIuyJuVLf94q/xwJq+Yg6DeBW9+GiWAmF5ziETi5M7PjXxF0HiaZ+jf6viP56ygv6YndJlT874mGh5vw4Tn5l67eXAXfgy2OWKYe83jKBfSeq52SHJ3yBmi8I7227icQXiKoqvTQ7av147Nus7rTldIgUsgAveBgsKJKIoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 28 Jan
 2026 13:04:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9542.009; Wed, 28 Jan 2026
 13:04:32 +0000
Message-ID: <7a5375e0-5aba-4ff5-a79a-8f6498f0d7b7@amd.com>
Date: Wed, 28 Jan 2026 14:04:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: validate user queue size constraints
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260128110044.2898418-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260128110044.2898418-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:408:142::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ce8e3d-8a99-4959-9f4d-08de5e6dc747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NG00YjNPYmZteVpEenUxWmhMV3lpVzFZUUZmV0xyS0pnNXg2SkZRL1BmaGc1?=
 =?utf-8?B?RVRqaG1zcncyaGFPaEJiM256RjRhSEFJMWdhOXFkVCsxbFFhdFdlc0VSSEVX?=
 =?utf-8?B?Qk5wbmRwRVVTRkdhVjR0TDJjLzBQR3dFem5vbGdGd0VZOFdhSVU4NHZKRHFE?=
 =?utf-8?B?dUN2eXhOdFBnOEozRktyZnhnUkYwVDZ5VGM3MHhBenNlbmRlY1pTR2dITzlx?=
 =?utf-8?B?d3AxZExaSFp2SEFBN3daYmJjTmdFb1IyT0FkdGtQenNBYW1WaTlrUFZUak5x?=
 =?utf-8?B?S1Rnc0l5V3YvbkMyOXFGNFhXTVFYM3d3dXYwNGpSL2c3cVVUdEpNdlFvQ2dR?=
 =?utf-8?B?Sk1XN1NDeG9YbGZjZG9hUzZSNlFKVERQQktnSGZDbmFRUzBlL0ExbGFPSDlj?=
 =?utf-8?B?OGN4anhHOS80WUtZazdLUGFOa2JVOVliaXBCeGI1d25kcWNXUnBVdFhHWXBQ?=
 =?utf-8?B?S3A5Q0Z5TjlKZXJWb0lpVzhQOVdWZm5YeVRYTVNWbnRHZVI4ZXlZemxLQkZF?=
 =?utf-8?B?UHB1SHZGdzl1N1N0d1ZJWG5yRE4xUm5iZFY0cUZZeXZVVXF4WFMwQkRVSWFR?=
 =?utf-8?B?NnBibkpYb2xNS3BEWW1oYlJDOUQwMGNiOXdQWDR5dXJjVy9hdFFBbmYxTWtp?=
 =?utf-8?B?TjBQV1B1dUtvaXBwdjFvN2N4cm11OUdtUlFnL3ZHWENyRkkwTFErVDMxRk5t?=
 =?utf-8?B?dTN5eGo4azMzM1lqZEplNVJKNllsNlpYTFdyeTM3NFQzVzRaRmhJM1lyTi8x?=
 =?utf-8?B?c2FaOVMybENUOTA3MDVrVWk1ekdYNk05M0R0c1JkUXRBRGZ3Z29vYWl1L2Rr?=
 =?utf-8?B?ZG50QW1RUjg1RDRHck00SmczN3N3LzJITzdYMC9IYUc1Mm1TSVFqVERjZkVQ?=
 =?utf-8?B?dVh4bisxY1JDUkc2bXgxdm14bjN5SE50dkF6WGxwWEMyZ2puaHpWNTdtTGs1?=
 =?utf-8?B?eDl0czdSTFBYdHpYWTUzNERyQzZHMDIvZUVNSTg3OVBiV0ZObW8yNnJURE5t?=
 =?utf-8?B?eWt2VnRIRmJKdTZCK3hYelA0dlZEYytNcG0wSk5zckxvWnk3ZW9VWURFODNm?=
 =?utf-8?B?eUV2QVdRbUtDUWZSWVFRRFVERFk4QXBvWGpybmF5S25FUWRISmFZZlBTaGYr?=
 =?utf-8?B?a2tqSUVyaTRrekNjUHpmK0tEQkRQNnU5MnVzaGtSWGFEZkZFZFNoblRKQ3li?=
 =?utf-8?B?SUNkRnpqWnNMNnFmSmcvQmlKRDNmR3NlYWQwbUZBZEp0SnhyRjlNUU04dDBp?=
 =?utf-8?B?bkFuZHFpdTZBemVhQzFlNG9hWC8zTHphY2JxbVRVRlpCN3RXYmZaTkRvSUw5?=
 =?utf-8?B?N3pUNTF5b3VFQjAxOFNVN3k3L2RtOEZjSkNHdjVoN2QySlNzZjR2REhuTW1S?=
 =?utf-8?B?d24xdkRJbjJ2WmlyRlh1VTlRcGZtLzliU3Zjd2d5ZlhUQWdCeEtRMmxzdnBT?=
 =?utf-8?B?eHJST3IrVkZOWGVXLzhXcGNJVHZBRWYwT2s4dGd2Z1N6dzI2aXNNaDNTS3ZG?=
 =?utf-8?B?T3ZvRVRrTXlsUE4ralEySEMwcmRvdnlxdWZyQzQ0aS80VTNVRFdQM1NDMERJ?=
 =?utf-8?B?a3RBa01TSUo2OXNpeG50M0thdW50SVBYelplSTR5UWtVRUJxRit5V1UyRHVk?=
 =?utf-8?B?U0djNm5WYVd0MExkWkdQclNSck01ZTZmZ01BdzNqdmN5TVRSSWtURGY5ZEcy?=
 =?utf-8?B?QTJBYjNRK3VvQ0xzS1F4OTFld1hHdFpvQVBhQk1rTnJpT3lpR3NFYUhoZ1Zn?=
 =?utf-8?B?L1ZhWG5vZG1EdDF2NlBIaUI4V2hiMmZVNmVJbUxxUXhDV0xENCtXd3FRRmJs?=
 =?utf-8?B?UTM5TnNvR3AzYStiMWNJcUswRHBUY1BkVjBWTkwrT0YvN1FhbWlRTDNzWVB6?=
 =?utf-8?B?c2g2Uzd3UWpmQzEvMlF0MW9oaEQwQUNNQ2FDOXdCSUlpVnlFbE53akF6SmlR?=
 =?utf-8?B?ZkhKN1dtZUZtZDdsSUNrdHJpYWpESmd3ZUhaeWVuN1BCb2NnUFFOS0JwbEZn?=
 =?utf-8?B?elN3TU41TEVyeHY5bWZDL3kvbXl6dHJXYXJMNmhGSkhscXE2aE5VenlXT2Np?=
 =?utf-8?B?UEt2R0s0RzR4SjdXRGRsY0tnSHZUQ0JsVmFseDJpZG8wWithcjVzbFRtOWhh?=
 =?utf-8?Q?IcNQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk5ZYTlleXNGT1oweStjZHFwZUZQLzJjdWpiUnJsWVI3aDM5L2xIdTMwYXVn?=
 =?utf-8?B?eFBvUFIyQ0hHUUh6aThxZTVMYmRUR2VtcDRSWStqb09pLzVMeVlkRlFkZ1FQ?=
 =?utf-8?B?ak0xdkRxenNlTjQzdldEUWxzazl3ZENtS05YNnFJVnpISkJHei9Fb0x0UlFB?=
 =?utf-8?B?WFMwVXJrZm9iUnlCSzRiZnZ1TGVBM3RQM0l5UlYzNXR4WUROckVTQzVxc0pC?=
 =?utf-8?B?TzB1Z29SalJJSFlDWHJGOFBDUjk4bU9aV0MzOVA2OHRUUFlBU2VOdkg0ZG1y?=
 =?utf-8?B?MTkyWWJZRkxHMjN5Zmg2b1VLRFNFVjRJV0c5ZXVHVjJ2TGcvSXY3SjdiaE43?=
 =?utf-8?B?NERVWEZBc3NCM2RCUitERy9qQVdQUlJVSFF3aTQvVHgvdmVsQitlQjNMYTFa?=
 =?utf-8?B?c1BqRjBZNkZnNTE3ZG9takZuVFpyblFvRTBFWXAybEVTVzJQM1pzSU5OMXR0?=
 =?utf-8?B?L3BHL3RqVFErY0tKekhNdkdVbzVOK3FsNDlrUFBtOWdOcE0vTUtpa1hpWno0?=
 =?utf-8?B?S1pCZVM1WWFTWDZsL2pWd0E0Q0xZRTZnNlF6ZHUzSFJId1Rhdm5jNjI2dEd2?=
 =?utf-8?B?cTVCOTNBNkpuend1a1VjYjd1S2kvODJSVnhWNmMxVlNzdUdoRGlhQ0YzQ0N3?=
 =?utf-8?B?bWJMUnpzeDV3TFB5YnFmbmkwcEdORnVONXMxTWJiVlZpT0dVUC9Za2JqYWgz?=
 =?utf-8?B?bCtTRUNDOXYvQmcxOXVmYk84UGp5RlJNWmFzbHBMZElvM214NmxtVWVuV1FH?=
 =?utf-8?B?ejBnbDZOS2VJTU5PcDd5RUM4TEhEemZqK0xncEhCcERXOTN0L2pEN0F3WHhI?=
 =?utf-8?B?anZvcXdzS054VEwzVEhjVXIvR3h5emUwTlhIeDltYUZ0Qk9pV2pCVC9TUmFS?=
 =?utf-8?B?OWMrVzYxOHNERDRpQ2RuRUF5UENhWUgwZUswVHBaaVA2QlJqRVZoSE41bXZy?=
 =?utf-8?B?eDVHZ01UejBtcVRCbndPTUEzQ1BtYXJFdEtZelp2Njd2dmZPMVZJa2RIUU5C?=
 =?utf-8?B?N3FuZG0wYTlIcXBGajhWMy9Uc1A2RzA1dDI0ZnV2WEJYTTUvRnpKeVNTYTU5?=
 =?utf-8?B?S0ZzckZTc05sRGZPbUNVaWVOSXdseUtMUWhNRXFoT0dwRVF2Mk5heUFwZlBV?=
 =?utf-8?B?UnN5U25MNnFCZE9rOHRVTjJHUzhMQk5yT3BjS2pEaDdia2sreCs5SUxOV0lP?=
 =?utf-8?B?QnhueDU4UUZhTUpWVDRRSjFkWXhtVjZLOGdDQ05kcEN1NGtBVG1FNGdSblVj?=
 =?utf-8?B?ckdNRWljSzhYNVdJa21HR2gwTVlqR2xiRGlnNVpMdDgzeHB0T0hTTGFWRFNN?=
 =?utf-8?B?WHdBMTRwdnpuWU5kY0dnR0dJNjRTNldUMm9TS0FiK0drTVRIUmo4dVhnRGlm?=
 =?utf-8?B?ZWhHaFk4VUJvNXRoL0dUb3NHaitOWGlSdDJxVytRWFloRm5TUnVoMnB2bGVB?=
 =?utf-8?B?TEkvdFRMbjJ5VnVHZmJJN2w5V05ueS9PcDdiMlJSa0ZIbE1NZzUxNW1qbkRI?=
 =?utf-8?B?SGtqaWRSVXRwbi9SMVVrUmN5N0lhWSsyUUxMeHFlK0JCZkJEVFplVmllWGtP?=
 =?utf-8?B?Tk13K3N1aEVhTFNqcFVJOGhOMG1HVER2QmVUL0V4ZzMybmVmdDJiM2djQXpS?=
 =?utf-8?B?RmFMUjEyV0V0dnBZZ0IvKzJ4b3VzVHFhNmtla1c3VzlobmFFeGo2VG1pbzZK?=
 =?utf-8?B?SjV5ekxSZkxTZTFiTytrRStwam5rZ0s0ak1GSHpFeDh5Q1BIcThCSks4ZXZ2?=
 =?utf-8?B?VkZaQm1XRlB2LzdhcHJraEFmSTd5TDVieWZ2M1lFdngrUUEvZWN2S05MaEN1?=
 =?utf-8?B?dzFmdkdvSVNRRy85QVppalRwMUdFQ2pCRC9GN3A0SXJVa2sxS1RiTUt1TmR4?=
 =?utf-8?B?MnZlblh1NFJiOVQ2anEzUnRHSWlQaFVBMUE3TmNsV3ZralJocFZRS0NiRnpp?=
 =?utf-8?B?NW9acmlzVkdRQVBWNFNISXBLZFVDalhPMklOU1NwRThwZHlTYVhoSnRreE1h?=
 =?utf-8?B?K1RtQXlFcmlGYklRcmRZTUtYRGVib2x6R0U0Rnp2bUZKQzI2WGVXUVZQNUIx?=
 =?utf-8?B?QXB0T1ZoRXQwa1luc29HbjdZM0xXR2tMa2ZTR01tS3Qwd3ZPNGxLVGhzTmJQ?=
 =?utf-8?B?c29xREJ5Q3V4Yy9XR2JyOGJpMFo1M2lGRE1PMVJDUVJGQWZGQ1lFTHVkWmRz?=
 =?utf-8?B?U2lvT2JrdEN0WWpGUUFXbmV3QzZQeldoRm9JODB6b0ZFMjNjMEdvbC9rQUFE?=
 =?utf-8?B?ZWxjaUFicnhBYU5VYmJJNmJrUDg4SjhYamxnTVUrL0xNOEgyQWNBZmgvekUx?=
 =?utf-8?Q?jGhFyFclWN47tPaz01?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ce8e3d-8a99-4959-9f4d-08de5e6dc747
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 13:04:32.3156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jrVPTA4u6GCUQgOTZpoWcS4pFuOq/0+hmemsv7TQ9N64+X4jxZXyt/2ye2meE3H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
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

On 1/28/26 12:00, Jesse.Zhang wrote:
> Add validation to ensure user queue sizes meet hardware requirements:
> - Size must be a power of two for efficient ring buffer wrapping
> - Size must be at least AMDGPU_GPU_PAGE_SIZE to prevent undersized allocations
> 
> This prevents invalid configurations that could lead to GPU faults or
> unexpected behavior.
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3003aba22e1d..998e1fcc0034 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -864,6 +864,17 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
>  			drm_file_err(filp, "invalidate userq queue va or size\n");
>  			return -EINVAL;
>  		}
> +
> +		if (!is_power_of_2(args->in.queue_size)) {
> +			drm_file_err(filp, "Queue size must be a power of 2\n");
> +			return -EINVAL;
> +		}
> +
> +		if (args->in.queue_size < AMDGPU_GPU_PAGE_SIZE) {
> +			drm_file_err(filp, "Queue size smaller than AMDGPU_GPU_PAGE_SIZE\n");
> +			return -EINVAL;
> +		}
> +
>  		if (!args->in.wptr_va || !args->in.rptr_va) {
>  			drm_file_err(filp, "invalidate userq queue rptr or wptr\n");
>  			return -EINVAL;

