Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9E7CCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 10:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62DC510E1A1;
	Mon,  3 Nov 2025 10:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mj6olQDP";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011069.outbound.protection.outlook.com
 [40.93.194.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6419410E00F
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 10:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0hdUl48zOWNBm51AHBJqJxV2i13bUOIFvQpKdTPXgTPa0IGRgg8VtxmN411tcqyYBOaZZkdiVAx6yDv5gjfaLPBLKuSr/u7/zoAp9SkI5jhTONDuTGpX4YgSgtPIrXJ+yaR8EvGlD4peQ2qzkj/3emPCvPYnhPGN4rjnTCYdcGygF+P/ME5LcRrrnUMx7EHaBPdbIHmTK1T4HME6Q23zxHIh6Vx9Bsn/oxKLFjAQM3M22s41CjPj1M4BGAUnTcJWyuwIShvCJP5TLCy+mPO77WDrs/jFT++sM4g8rQnXWQ1qUQKp1lYAh+fCJxKL5p+Ay9l8UCye2R83sjlEkUs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fICINylkmZ0TEyc30LAqPAKNEwDrRjRB1K60N7UtTa8=;
 b=FyYSymPHf0QEub1MXdIj8BSJqY3rHlz6X/vIJzKMXW+vqMMt91xcnnKchNjabn9YEv0TosWcGIWL5j1Ssvkj8/SB+4JxgYvACIIrEi2EeayXkeAwTy/EyTcCh2qEjZmxso35pEUAG+qHurGBkVwQfvorLmiNq/MGjNT4bDDdx8pVSAmiyjQsZhlV47qMQAh46zPsxJ3AgUREUkRz504qxi9vjQW3avbTLCutrwyttyO/FTU4TUn+mACjg0PL8Rr1q970JsYuus0ZmeW8EtGCGlLvyl8QmT1CrYR7Td5hlNjkIjia8YEw9IV/+8WRXXegee81PdYOltQ7A1KTD8tBNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fICINylkmZ0TEyc30LAqPAKNEwDrRjRB1K60N7UtTa8=;
 b=mj6olQDPHWh5S4xqItVztdNyo3O9+Wxvh5iEOnjyRI1fXKkRrEg3WcHSEeFjtn0KqRRMua7f4K1XoRLPFBXx3FHXxEF9yfEMEdSVEGc9NvsxAJELV1iejJrhoeI9gs0rIHTZUva8ORw8apJEGzK5q2hmHdSY+ME/Vg6BHQjE+Wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 10:49:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 10:49:11 +0000
Message-ID: <bae23bd9-dc36-46b8-aef8-0f1d2ee575f8@amd.com>
Date: Mon, 3 Nov 2025 11:49:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Don't clear PT after process killed
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Gang.Ba@amd.com
References: <20251031151444.16251-1-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251031151444.16251-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b191a71-3345-478c-963e-08de1ac69f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1o2Y3BLSjhBSlZuTU1MOXgwMU9TSXdFY0JCM00weGFrdlBtcjVabXdLNEJi?=
 =?utf-8?B?NmRqaVdwdHA1NkgyWHhhTFRhclZ2ZFRDejBIVWdyUVBMZC9RZ1AvQWhPRklm?=
 =?utf-8?B?dXVkaitvSmtzWWkrOEluQ01QcVkxY29KeTJ2TUJJUkFKdmsreWFOaVk2anNm?=
 =?utf-8?B?WGVXUW9PZCs3Z2Rjb0lmTWQ5RFdocVJBY09GV1Nwd2hIK1IrbVN2enNOM3Jl?=
 =?utf-8?B?N244dUlwR21XNlZtQWpaaElGMUR3bE9nK0ROemp0TXgzVnhoRkdQYU5QYzQr?=
 =?utf-8?B?V2NXNFJJckpjMUpsNFRvbG93Nk5FTVAwS3ZrRStXSWxtMjN4d2FyNDZRaFM2?=
 =?utf-8?B?UkxNblFnOVQxblFHL1c4T055V0hxOCtFR0c4a2VsUENPQWVNNytlbzJwR1FP?=
 =?utf-8?B?TDlEVFFWS2lJRUx2eGQ2WWsrQ3BIUmFoVkNpTUUrVTRHTVNwZVYvVnY3c015?=
 =?utf-8?B?VnNQRG5VakxMNzFRRVd0K09iRVBnUW45OVBoQllSYnRCQUFKVzVyZnNaWUR4?=
 =?utf-8?B?T0tUR2t0UzNuR2RnSUpScnA2QlcxUHBBeUN3WjJFNkc4bTVpRDJuS2I4WUtK?=
 =?utf-8?B?OTVML3VIazhjMFE0VldqaC8vY2R6RWNuaUNpQ0phUjYxUjRkVjc3eVdsdmZS?=
 =?utf-8?B?VUt5VWI5WWd6MitkWmJpS1YwQmNBcnpIdHJDMFh1bmQ0ZHVSK3hhaDVJSGJY?=
 =?utf-8?B?cXZJL3R4RlRhR1ZiZ251WmZJdVQ2OWZURU1MQktHRlY1cGdwR3ZGMk5oRVBP?=
 =?utf-8?B?aVpwZy9jNVVHZ0F2UE9UekV4aVljQ1E2L0Z5ZC91ajJtVS84RzlxNGcvRHhh?=
 =?utf-8?B?N2orU1V6enlWbjd0T1N4MDRQR3U1b3puQjV1SkNnUHptaTFCSFFicFFKcTRl?=
 =?utf-8?B?WTV4WlhabEJlTnljdld0MEFyclI5aFdIbU5rS0JzeVF6L25lTFJ2Q0QvamlC?=
 =?utf-8?B?UWRRLys1MzlCTGlISmx3NFpTTDFKNGNUNTlUb1EzWG9uckRmMzd2cDk3K2wz?=
 =?utf-8?B?NE9OQnhwMzViSTA5b1VxNFBBa01rOTVTa0xXdzFldzFTSXM3MGU4dUhqd3Bl?=
 =?utf-8?B?RnFnTGl3ZmVWOGIwclJoQ2hULzRvTFBHLzVGL0RaM3hsMncwVzdBdkp5dTky?=
 =?utf-8?B?dkoxYXRRWENnL2hBOWZiOWNHUjZTYk1PY0ZWMkJmTm5VdnRYZk13dGh0RVFS?=
 =?utf-8?B?d2VlSFdTeEpHY3FrRzdhNk9ycmZIenRQLzUwVE9ROWNWOVVlOXlTVk5JYzJR?=
 =?utf-8?B?Sm9VV2dWQ2dxaUNkbEdlMytvUEVDcW5maUREaGNIN1ZPcG8xTHRleThQNWRx?=
 =?utf-8?B?L1ZRZ2p4dWZtcTAyb3ZTakZFejM3cTk0NmxFUXJ3cEFMR2F4RVJBYnRVNDBq?=
 =?utf-8?B?VUltQ1IzZExPU1pwdlFqc0M2cFRHNjFzNGE4NWlxMHFkaGtmVFhta1MxTS8z?=
 =?utf-8?B?L1c5dmtKQTk3VWIwYVFFaDEvaWx3azQrNXBrYllhWEhVcFBDTlJFdG1ta0lF?=
 =?utf-8?B?UWNUTmJTRHFUYy9lSWRRUUpGOFB3dm1Ea3AyTGFyNXgwb0pMano4VDZKaFdH?=
 =?utf-8?B?MXl4UVJHbTd1M0cwYjE3VzBmZ09RK0RWNnY3cXlkeWlkSGs5M0lMU2xHMTNu?=
 =?utf-8?B?LzZ6V29mZnRFTkdsUVhhK0JwVUJZOUM4QUVDTHI1ZThZMS9YNmZZc2wyRmZC?=
 =?utf-8?B?OG5rcWdnY1V1Wk9JeXBqc3lnWGtaUjYyb1JTRlFiR3lURTE1Wk1jRVJ2V3dq?=
 =?utf-8?B?SkFSZ2xqL1B5VDBNeGFXcEYwUG1rUEZXMFpqaStVWUZ5aXRVQ1oraitWUFhy?=
 =?utf-8?B?QnM2a3Vtb2xnV0lWZzkzUnRySURXQ1d0SnFpcGUxbVNXTTR1V0JTVUh2WCt2?=
 =?utf-8?B?TzNVR0NzNWNVY2tHYktvbkNZaEdLdGw1a1hPdzQ5NllnWTZKT3pPS1YzaUJh?=
 =?utf-8?Q?85ZagaJQ6FyfpyjNPxOumjzYqKjf9c1r?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFNtZDZlWjUrRDJ1Vk5GVlZXTEN5dEZORS9obGZ5YWJRdzAxcmtKT01VTU43?=
 =?utf-8?B?ejh6anVwZXNwYzlXZCtTYUhzQURCSjJYVWZBQkUzTEx0SjdtWmdaTXdxRXNm?=
 =?utf-8?B?Rm5GVGZaS1VrWnNOZ0d0YkxuT2VJSDR0MGVTY0Q4TnZNSEF5SXVBWlFCRnhY?=
 =?utf-8?B?RllnMzdOT015V0kzMXZ1NDFXQ1hlVWJ3MzZlRnFEODJOckNqLzh1MitBZ2hv?=
 =?utf-8?B?TURHZDRWQ3FwOTdQSVQ0dmJHRVFWR09MMGpFQVlrZEZmcFNwVFpyMGVWKytk?=
 =?utf-8?B?eCt4VmtzMDMvaEVLelBaQVp2WUYwYStjQ0xxRTVDT3pUMUpLM242UGJDbGJj?=
 =?utf-8?B?M1c1Z2o2MWtDYTFTYlZyTk9sbm1lcVFNVXhCWit6dFlNOUlKajNQWXAxem14?=
 =?utf-8?B?elAwZ2hwdU9yckZtUGZoU0xKTS9XWUMzeUlmUWpRSWxLWTBJZVVDOEI1MTJF?=
 =?utf-8?B?VnA5ZWwrRVdIYy8vWThEcUNkNVptR1hGT3FpWDRZS1FwejZMNXQ3dEp1V1RC?=
 =?utf-8?B?S0NZU20wZ3VFY0JHRjVrSWFDNW5UdUpDNDNueGFOaHQxOVhPS1gzS0ZscS9F?=
 =?utf-8?B?OXU0RzQySFcveVB2RzJIdkQ2ZGE3M2JvdzFyLzFOR3lPWnVLdW1CbkY1NXA2?=
 =?utf-8?B?RUU0WnlnN2svUnFEa0Zwb1FGU3d2elI3akxsWElNRll5MWI1eGtocG85cUJ1?=
 =?utf-8?B?QUFsU0NvSjJESHIvSVV2d0xyYm9BM2hnS1F2UytNUHRHS2tBMEIrM1BCMTNu?=
 =?utf-8?B?UjdnZHBuY05jNnIzcFFaTjZxcCtEUnRaV2ttdU5RT3crcjFvZ294QmRNYUI5?=
 =?utf-8?B?NER2SkRBMnkxZG1mN05SdTVUNzZmd3dlUDNiaFlrYTg1SEEzUkpKWUtXcVV5?=
 =?utf-8?B?czV2MUxrUkFPdUhNbkFMenpvaGNSM2RtRVI1VWd3NFZ5bGV2WklPNWFyVzVa?=
 =?utf-8?B?Yi9Hc0FEQXVxYW5WazJvcDJjRWtBMThKK0tpbFV0T09qUXZNQTRrWm9GcDRS?=
 =?utf-8?B?THJETWJpYnFsc256eHhMKzNEaklSdjVKL2U5NEtLVHd3YnRaR1lHMU9xNUhn?=
 =?utf-8?B?cXE5TVVaeStSL3c5a1FZL3dPM2hTZ3lGeC8zTmtnT09haGxzUjQ2VzZVYnhv?=
 =?utf-8?B?Nmg0bWNTL2NMYkZVcXczbmVTcnc4Yk51bkVqQ3JGZFpzdzl4VlM1SjJxWFdn?=
 =?utf-8?B?MC9UaFVQTnB3ZmRzUGVYSHJzUDNVWFlrWGZ0NVpPNGRUOHRtQk51Q0srektk?=
 =?utf-8?B?alIrdTdQdXFncEJwUmFwcHpyRW9CVUN5RUdTVXJtOE5EREo1cVBzcEZnVG5o?=
 =?utf-8?B?eXpsdVRtSVE4NWhaRlhzeStGL2ljaG1WYVlFVXNKaElqTGNvSEMxaTltcVJB?=
 =?utf-8?B?Mks3b3A1VWYvVVc5dmVWKzNHTmxDUDVkcUJudmYra0sra2V0aFFIRFhpZEJv?=
 =?utf-8?B?cHJrTzRRT0MwV2Exa0FaZ3RDU2d3UHZzcWVnVXgvc1hpVkRZQldYcjljYllo?=
 =?utf-8?B?c0hZak5TekhYQnIxUW5PU3ZlUnpZTGcrUnhYVnNKM1RSbnBEM3ZJdUEvb3Er?=
 =?utf-8?B?TThNRGExSUVNSDBZVUVZc3h1Q2lUMnhaYjltUGtybm1SaUxJWGxEclllQ0lT?=
 =?utf-8?B?QVdOb21kVjdIbWtnbEdmbVFMOFc5b3VFYXJoRFI1QXpvaUx3MVFzaFZaazNk?=
 =?utf-8?B?b3FGNGNEeTF4MEFLR1lCWEgyOVJQbXc3bW10RWNHcVdGYldXRnA3Mm00NEN0?=
 =?utf-8?B?cUpaWExuVDBwS215RU5IaHpyWGwvVFlGU2JwLzNFd0Q1SjlkTjhhQlFOWEFx?=
 =?utf-8?B?cnVncjFNVUZUM1Y2dkxRalJMcU14c3FrZTJOekdXSkVJdDRwN0IrQ1ZINTFs?=
 =?utf-8?B?bUc1NzBCMkFXZjhQb3VYclE5a1dRZENObnRmRHNPOUttVVhvNWNGT05oaVhQ?=
 =?utf-8?B?MEpCTGV6a2E3aC9CN3NKQW1aaTR4Y3EvNFhFNzJOZzRHbkhTY2hhbWd3SEhy?=
 =?utf-8?B?Ym1WYUFnT3ZRbk9TL1lPUTVWcDRxV0ZkQXgxN1dHeFRuUUNKWTNMQXlxdlJw?=
 =?utf-8?B?VHBxMEk2SHhsamVqNGgyakJpNTBNdWsxUkVLak9KTUJwc21oZHUwYVBsaXZQ?=
 =?utf-8?Q?zcjY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b191a71-3345-478c-963e-08de1ac69f2f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 10:49:11.1989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frUdS7OljL32DbzDRzyLIizxuZIKtdy1p2d0h5yFSfEqEE+CPeAGnrVsqkZ6zQO+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693
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

On 10/31/25 16:14, Philip Yang wrote:
> If process is killed. the vm entity is stopped, submit pt update job
> will trigger the error message "*ERROR* Trying to push to a killed
> entity", job will not execute.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 96ccd5ade031..b1c24c8fa686 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1274,6 +1274,10 @@ static int unmap_bo_from_gpuvm(struct kgd_mem *mem,
>  
>  	(void)amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
>  
> +	/* VM entity stopped if process killed, don't clear freed pt bo */
> +	if (!amdgpu_vm_ready(vm))
> +		return 0;
> +
>  	(void)amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
>  
>  	(void)amdgpu_sync_fence(sync, bo_va->last_pt_update, GFP_KERNEL);

