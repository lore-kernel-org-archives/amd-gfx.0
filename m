Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372FAC71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 03:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9C010E273;
	Mon, 16 Jun 2025 03:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ddCc0g0P";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D35B10E275
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 03:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4suk55Kzlwn1yIMgnAZGkmsbzKvYa79cOUo4rI5vxbFWIkGwEqh1/GbNxuoAf788c0SqFfD2ZVGt21AFbSn6qtTfpAxxsp2JCW1EgQ9zB4VRbgVptmMCwU8fipPbO55hJOPt5Ary0xzmrmV7GvNBEuem6KTgrbikVaYeTzgymm3ZhMDNjwCnCDXnL066uqcsnnP6meq6LXoXtVU1ZAdRp2LLj3UehmtGx+nT+fznmvjohyDFO7t+51cR8jk1fgZB8NalP4Z4yXG9UbjyUyxI0AZkbqfS5Dy81ypehtnWBAPII1BwlgRquZHZ9A46C1ss8iDbQIOsXtUSMpm4CUSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag4kUgGy2vxbyGvtNWs2vNXS4gpweBX1PIxYp4MwLVE=;
 b=BpY20N9+RbJIdPoXHronH8XEMscn+7bI9qUnMxN11nUEXYb5mn6TQLxlb1dducJWw1xW8OJ6Pax+RkUz9R8k3R7mvsOqdmyJfalw5qNhG4Hzyu5txO8jMNykq3J6DGrVOY+uIGn7FXN1Sv4CbI8PXSnPPxnS/4/d2KGtNXkl885PqON7t8P0Rzs9QYymmpMgiy3vGfawPW9y/9QQNU5F9W816b9knG+3Q8h2fiWC0qUm7PlJV7qoBufR1KUJpCgTYqVrNNf4mpRsAcTmm+GINL9QGPumqDeUYAQQGvqA/ogqA7dl4s+hV/wYDwewoZ2ZkPEdrjqiJ7YeQzldclpUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag4kUgGy2vxbyGvtNWs2vNXS4gpweBX1PIxYp4MwLVE=;
 b=ddCc0g0P/Opd4khI/VzvapldHUpASSuUdYIm06LkWAaeuRsHy8gvOPTUKC8BaoTm+K99F9iSVAIGW+qg6XhCwQD8Yx+kWltr4fXPnrVz5DXjLX1I0Z+DEmBP2h1JWlylVWPGViX5Bc0g8jtsWxbC1oQiA0hYFZoNzfm1FLVQ97Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.25; Mon, 16 Jun 2025 03:46:45 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 03:46:45 +0000
Message-ID: <b1ffaaaf-2f16-452f-ae0a-6847e4439675@amd.com>
Date: Mon, 16 Jun 2025 09:16:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/27] drm/amdgpu: move guilty handling into ring resets
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, sasundar@amd.com
References: <20250613214748.5889-1-alexander.deucher@amd.com>
 <20250613214748.5889-8-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250613214748.5889-8-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::35) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1f5e7d-de5b-498f-36de-08ddac8869dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3JYeldudDhNcHNGL1JaTklOOXFiYzIvUWVlSjE0VzEzeHBmTUF1bW1PYmVx?=
 =?utf-8?B?TGJxUSt4OGtOU2JWaW8veEY1Rm50TnlrVGk4bm1KMU9CY2NHMEtyQU03QzNY?=
 =?utf-8?B?M0htUG9GSzJyVnJJdXNRQUdPS04wWlBZaHYzVCt4ajEreVFmcFZ6bDFTNHpY?=
 =?utf-8?B?S0l5dndvMHdPdWgrV1BTaTNwRk5uUW9ZcUZXNUhOMitGQnlGMEJHUEJhZ3Nq?=
 =?utf-8?B?UFlUOEFpdXFJL3lDamdVWTRsVXNkK2dPL3dKMmpLais1U2pWMjA3UHFzeklQ?=
 =?utf-8?B?dVJFQ2VaL3hXdTI1cnh4Rjd4b0ZvWEdHL1dpNHUrZHd3ekRuQTBIK3E0T1FF?=
 =?utf-8?B?WnJTejNhaUQ0c1lvYmp0Q3haM3pZUEZOb2Y3dkVrZXFDUDkrVURFWmltYVRh?=
 =?utf-8?B?R24yZTYwV1lIeTRNbnkrTDlWYk42Rm14aFV5QTBSWjNTbExpdFJaNHZJOVJB?=
 =?utf-8?B?bk5Eajk4NmhHenpVZVNIQXFxN0w2akdxOSsxNmpsZXd3cW1UcG4zYURYWGN0?=
 =?utf-8?B?Nkd6WnBOSHMxRGV3QlVRZE5OUDc3RmtaM3hjK1FpQU13amQrRUZ1b2VnL1NT?=
 =?utf-8?B?N0NQdmIxaGRQVitwaFFLSjdzNVgweXFSaFA5NksvOTZOQjh1MVlLbjNBeU4x?=
 =?utf-8?B?amNJYVhCQm5LU0lQWGs1OEQ2U3hrZEo0QXNSL3hSRmFaZnk0bzBFWTVwbzZ0?=
 =?utf-8?B?ak5VRVR5MFI4WnBDUjd3a0JWUzR5SlhFenczcXRPWHQxdFM0ZmR0Q3VNYUk1?=
 =?utf-8?B?U1B4eDNtK3FPSVBuVGdma2RyRTROcWhIYWFsaHZJZ01WbmRCMlN0NUdhYTQ1?=
 =?utf-8?B?RERnWTVWb3B3d1Y1THJmVStrVzdBM0ZVd1BldzdKRU81V2h3d3BDM2R4UnlZ?=
 =?utf-8?B?UTNoZEhEM0kxUzRNWE1wK2Q2cU8wcDRsTkZTNWV0Y1dNdGxzSWF4R0g4V2l6?=
 =?utf-8?B?c2w3eTRoa3I2czQ3WDRIRW5URmtuM0d3Y3Z2WmFFVHEwZGxoVzY2byt4anVX?=
 =?utf-8?B?YUtxenU3NEcyd29mUDRJWGlpVEQ4eWNRbXZicXpLOGtlNDR2cytrSTVzRGFP?=
 =?utf-8?B?WVUyZDhtSGRtekFvYVc5Q0s5cVVmd05vL05CQW5LdlhXUjVjVnd1eVRzdjUr?=
 =?utf-8?B?a04xbWszbWM5N3Z6eitrbE5XcEJTRmVGVnd1RWJpSjBkQVlqSmdHR1pqOUNL?=
 =?utf-8?B?S0JiRXE0bXlxZm9Cbk9saEJVME1OWkY1TFJYYlpSZnVsQ21YOUY0OUlTb0NL?=
 =?utf-8?B?T2JQbVhjdXdNQ3F0RUlXQU01T3YwZldVc3hqOWhVeU03cCthVThwc3hlbnc0?=
 =?utf-8?B?eDV4OXFpR2VtRnBpT1RpelNvczJUVXNSMnFiQlRNayt4YmVMZ1czenA1aDZk?=
 =?utf-8?B?MVV2akptVU5rZW1uTmErZ2ZkSmsrUGhqV0hqSDMwMmE5Zlp0cXhzRVE0Ym9S?=
 =?utf-8?B?dTNyMDlnb2hxWFpTbjBzeWQ5UXF6QXZ2aGdQZ08rcHNQM0czdm0raEVMeTg3?=
 =?utf-8?B?dkJHTDZCU3dqamFxQWpWbUFEbXZycjVMeCsxQTh0WkRQWHdnbFEvdkFkb3E4?=
 =?utf-8?B?ZHlYMVQ2TmRRTE9IUXpJUjNlZzQzcGh0bDRzNDJhcThCMzN2aHFyTGNsaFMv?=
 =?utf-8?B?TGdkemlRWUltNnhvOHlRRUs0dFhVaHJuVXJMK3N0em52NFFHL0FyM2tqOFFJ?=
 =?utf-8?B?TUtKQjRUd0ZyQmhVWm04MUloOXFTeldFM0pXS3JGRzlnUWxtVDZacGlyZ2NF?=
 =?utf-8?B?ZktLL2MrclVTQ05sLzlCQkMzcmdqZlJUQ1BQcnJrbVNheElPTmZjWWtJUTRZ?=
 =?utf-8?B?ODhXaVUzb29MWnB1ZXVJMzhhL2ZyT25uSWFGVzRrMHljamVzWWZENDNJSklZ?=
 =?utf-8?B?eEdBczRyN01qRGVNNFJSSDE4RkUrdXRkWURta1RrUlVBVmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXJuU3Z2QXdER0x5V3p3bEpHVHJoM2hjcEdwdkxUbHpRWmlUa0VpWmdCSm81?=
 =?utf-8?B?a2NEY2pqS0oxR0lPMllQSVpCNWMxMzB6dXBxV0dZU2EwNkVkQVcvcEhZdnQ4?=
 =?utf-8?B?N2hRWDdaV24vbEh2ak0rMFhkY25meXZVMEtCODBGUmlVU2s3UmVtQXFKRWl0?=
 =?utf-8?B?eGpNcHRYRzdFRUIvWUlHSHZQZDluYVVOWlhDNGF3RFBnVUtvbXBUZ2VHTmNv?=
 =?utf-8?B?dklaQjY3MHpxU0J3c3FsV2J5STV2YXBDOUJmSm1TTGVXRUszWTFHMlI3WXBQ?=
 =?utf-8?B?STZlYjJIc3E3Q294MGQ2RUpSNGt1ZnNhN1BjbnhZYWxoeFdRODh2dm8yU0ZH?=
 =?utf-8?B?YmUvSmVGQk1VZTQ4Q2I1bzlqbUx2aFozM3k3ckcxU25BRElNT1FtaUZwTEtU?=
 =?utf-8?B?ZzQ2YUJSRFhSNmE0OWhLczcwWXcyK0xkMU40SmxVWityWE5PalNsZlp1WEZ2?=
 =?utf-8?B?V0E1eGQrOFpkbUZhSTMxN2I2eU9GT1dHRkhqWjBucnRyNmk2cXhCc1dWYXVx?=
 =?utf-8?B?bWpWb1g0WFNHREtTOHF6QzJJTTJFQzJycUcybjRORHZhYlpFc2hZVHhXWlNl?=
 =?utf-8?B?WUdRMlI0SkJwYXpDY1hqTm50NytsOVJEVjZSZEsrcnZzVFRlWDhvVEZ4eC96?=
 =?utf-8?B?OHdkeitSVEtWMGFWZnZTWjRTUm9SZGlDdlVSVHp4aVQxWUMyNUNoaXBjWFlF?=
 =?utf-8?B?TE5udThTYXYyazNoaE1vNG5lVERVQ2l0d2NES3oxNXFnaGlsNXN3WFYya0ly?=
 =?utf-8?B?SmxCTG9jUDBtMmt3c3dKZHppME4zV0ZRQ1BwMUxweW55K1ZWWkMwYjNlTWZ5?=
 =?utf-8?B?RVFtKzZlZTBHdnZnQnlDRi9WT1Y0d1U2Zi9IRCs1UVo5d1htQUFVcUhEem1t?=
 =?utf-8?B?NkI3V2FkVjg2TFJyYkg2ODlCNWNsWVA1M2JsaVpoVEoyMW9hckxPdklVUjJs?=
 =?utf-8?B?Q1lpTUxXdnRZdjBSOC9Yc003QW5iODhGM25Oc2l1REhFbmpVa3doTDEwZEVO?=
 =?utf-8?B?ZkdJMG03dTFneDAyaW80RjdGUWZucjJTZzczZ1ZXbTZXMk5iVk1aM2FIdExT?=
 =?utf-8?B?MFpQR3JqaEtzYzJlcEFPVlIvSnZKeXFXTVI0eXZzKzR6YVlYaDFsRGlJc0VX?=
 =?utf-8?B?Vjl3K2Zick5scVdrM29SU3hzTGhMdWFsMEZ5dndrM3hvTHFDQnJZNzVVYXd1?=
 =?utf-8?B?ZmhoRXdCUlFKYkI2UmI4b0xWczJvVnJVMEtmOExrY0RUem5SUXBrclkxL0xO?=
 =?utf-8?B?andzN2dmTllycHNMa1EycTFUZVVCM1pldU03ZU8rSXBwWHJ3YUJPYjVUK3Rm?=
 =?utf-8?B?aHhld1ZscExTUnp2Y0ozMVpEdGdXZUJqOGJBNmhZNW5xamhsVFErRDF0bDQr?=
 =?utf-8?B?Y1VCazF5MnhoYmdDeGJBcW5wdWhEVUw5aGpqdTk4dG9ocWRyYjVWTGlDSUUv?=
 =?utf-8?B?andZcGVIbDI3VzNmcWdZdDRoOUFjVCtGQlIvb1RpZlVvMWZENGI5TXpaUkVa?=
 =?utf-8?B?eUNWSkRXYVQza3JnYmFHaFg5bDJzUjhOckNuQkxRZTZaUkJsYzNNQjJ5ekto?=
 =?utf-8?B?TkhLN3FDR051S2EybGt0aVNvckRHWFhiZ0VUR3lLdXB0WExJY0lYblZPZG92?=
 =?utf-8?B?emdwZmZBcmZVV20yVHNkQXNnZHVzSnlPdG5GUVVvemk1MlZJNGE3aWhpK2li?=
 =?utf-8?B?cWRtZkMwemZlMWw2SXRCZXZ4Yk1FS3dPNEM2MExDK1dJcitmQjlVVGNIY0ZZ?=
 =?utf-8?B?V3JUMlRrTUhKN1B0NjNNb2NBTmY0QWJKSE1MNmNHZ2JGVXZ0LzVvMlFEZ0NK?=
 =?utf-8?B?K1E2OFN0ZnlNTURYdE40OEl3N1dXa1hjZGl2NHR4b3UxQ3VubXJVRDZENmtJ?=
 =?utf-8?B?QVRFeWQzYWNjRzMzZStJc29XMExpQjFsWjBIOG10TlR3a2R6alR1OHIySFBk?=
 =?utf-8?B?NVhpbzRMNWwrVUJDbEtHWVFwbXk5bkt1eklwLzF0VkZwcGZibDNXbHVVVThF?=
 =?utf-8?B?eDdSSkdHbG1HMTYxcTZCMWp4VVlMYjB0dldIL2hKMURGOHN1QTUrN3VETC9V?=
 =?utf-8?B?eERsUXpPdGR3OGw4K3pFcklGbWREL1R6RllXM2ZpbGtiZXBSa1UxYlUrVERy?=
 =?utf-8?Q?SpZ+H51RdOvQ3V+4GhdC15k0H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1f5e7d-de5b-498f-36de-08ddac8869dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 03:46:45.2033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AleYQcKAZzWH64X9b+Mp3XTofzhwr5XjzehXt/QX+lHj4op82KNlrcnUw+rDbpUy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363
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



On 6/14/2025 3:17 AM, Alex Deucher wrote:
> Move guilty logic into the ring reset callbacks.  This
> allows each ring reset callback to better handle fence
> errors and force completions in line with the reset
> behavior for each IP.  It also allows us to remove
> the ring guilty callback since that logic now lives
> in the reset callback.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 22 +---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 -
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 52 ++++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 23 ++++++++++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 25 ++++++++++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  1 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  1 +
>  22 files changed, 89 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 177f04491a11b..680cdd8fc3ab2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -91,7 +91,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	struct amdgpu_job *job = to_amdgpu_job(s_job);
>  	struct amdgpu_task_info *ti;
>  	struct amdgpu_device *adev = ring->adev;
> -	bool set_error = false;
>  	int idx, r;
>  
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> @@ -134,8 +133,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
>  		dev_err(adev->dev, "Ring reset disabled by debug mask\n");
>  	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
> -		bool is_guilty;
> -
>  		dev_err(adev->dev, "Starting %s ring reset\n",
>  			s_job->sched->name);
>  
> @@ -145,24 +142,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  		 */
>  		drm_sched_wqueue_stop(&ring->sched);
>  
> -		/* for engine resets, we need to reset the engine,
> -		 * but individual queues may be unaffected.
> -		 * check here to make sure the accounting is correct.
> -		 */
> -		if (ring->funcs->is_guilty)
> -			is_guilty = ring->funcs->is_guilty(ring);
> -		else
> -			is_guilty = true;
> -
> -		if (is_guilty) {
> -			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> -			set_error = true;
> -		}
> -
>  		r = amdgpu_ring_reset(ring, job->vmid, NULL);
>  		if (!r) {
> -			if (is_guilty)
> -				atomic_inc(&ring->adev->gpu_reset_counter);
>  			drm_sched_wqueue_start(&ring->sched);
>  			dev_err(adev->dev, "Ring %s reset succeeded\n",
>  				ring->sched.name);
> @@ -173,8 +154,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
>  	}
>  
> -	if (!set_error)
> -		dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> +	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>  
>  	if (amdgpu_device_should_recover_gpu(ring->adev)) {
>  		struct amdgpu_reset_context reset_context;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index ff3a4b81e51ab..c1d14183abfe6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -271,7 +271,6 @@ struct amdgpu_ring_funcs {
>  	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid,
>  		     struct amdgpu_fence *guilty_fence);
>  	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
> -	bool (*is_guilty)(struct amdgpu_ring *ring);
>  };
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index b4f4ad966db82..a9d26d91c8468 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9581,6 +9581,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> @@ -9658,6 +9659,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5707ce7dd5c82..3dd2e04830dc6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6846,6 +6846,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> @@ -7012,6 +7013,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 259a83c3acb5d..d2ee4543ce222 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5341,6 +5341,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> @@ -5460,6 +5461,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e0dec946b7cdc..1b767094dfa24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7228,6 +7228,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index e5fcc63cd99df..05abe86ecd9ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3625,6 +3625,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 0b1fa35a441ae..dbc28042c7d53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -776,6 +776,7 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 7a9e91f6495de..f8af473e2a7a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -655,6 +655,7 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 81ee1ba4c0a3c..83559a32ed3d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -567,6 +567,7 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 06f75091e1304..b0f80f2a549c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -735,6 +735,7 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 10a7b990b0adf..4fd9386d2efd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -1158,6 +1158,7 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index 88dea7a47a1e5..beca4d1e941b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -849,6 +849,7 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index c5e0d2e730740..0199d5bb5821d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1651,37 +1651,21 @@ static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t i
>  	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
>  }
>  
> -static bool sdma_v4_4_2_ring_is_guilty(struct amdgpu_ring *ring)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -	uint32_t instance_id = ring->me;
> -
> -	return sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
> -}
> -
> -static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -	uint32_t instance_id = ring->me;
> -
> -	if (!adev->sdma.has_page_queue)
> -		return false;
> -
> -	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
> -}
> -
>  static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
>  				   unsigned int vmid,
>  				   struct amdgpu_fence *guilty_fence)
>  {
> -	bool is_guilty = ring->funcs->is_guilty(ring);
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 id = ring->me;
> +	bool is_guilty;
>  	int r;
>  
>  	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
>  		return -EOPNOTSUPP;
>  
> +	is_guilty = sdma_v4_4_2_is_queue_selected(adev, id,
> +						  &adev->sdma.instance[id].page == ring);
> +
>  	amdgpu_amdkfd_suspend(adev, false);
>  	r = amdgpu_sdma_reset_engine(adev, id);
>  	amdgpu_amdkfd_resume(adev, false);
> @@ -1689,7 +1673,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
>  		return r;
>  
>  	if (is_guilty)
> -		amdgpu_fence_driver_force_completion(ring);
> +		atomic_inc(&ring->adev->gpu_reset_counter);

This may not be related to this patch as such. SDMA reset happened
regardless of page/sdma queue being guilty. Why this increment is done
conditionally in that case?

Thanks,
Lijo

>  
>  	return 0;
>  }
> @@ -1735,8 +1719,8 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
>  static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	u32 inst_mask;
> -	int i;
> +	u32 inst_mask, tmp_mask;
> +	int i, r;
>  
>  	inst_mask = 1 << ring->me;
>  	udelay(50);
> @@ -1753,7 +1737,25 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
>  		return -ETIMEDOUT;
>  	}
>  
> -	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
> +	r = sdma_v4_4_2_inst_start(adev, inst_mask, true);
> +	if (r) {
> +		return r;
> +	}
> +
> +	tmp_mask = inst_mask;
> +	for_each_inst(i, tmp_mask) {
> +		ring = &adev->sdma.instance[i].ring;
> +
> +		amdgpu_fence_driver_force_completion(ring);
> +
> +		if (adev->sdma.has_page_queue) {
> +			struct amdgpu_ring *page = &adev->sdma.instance[i].page;
> +
> +			amdgpu_fence_driver_force_completion(page);
> +		}
> +	}
> +
> +	return r;
>  }
>  
>  static int sdma_v4_4_2_soft_reset_engine(struct amdgpu_device *adev,
> @@ -2159,7 +2161,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>  	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>  	.reset = sdma_v4_4_2_reset_queue,
> -	.is_guilty = sdma_v4_4_2_ring_is_guilty,
>  };
>  
>  static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
> @@ -2192,7 +2193,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
>  	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>  	.reset = sdma_v4_4_2_reset_queue,
> -	.is_guilty = sdma_v4_4_2_page_ring_is_guilty,
>  };
>  
>  static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 09419db2d49a6..4a36e5199f248 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1538,18 +1538,34 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> +static bool sdma_v5_0_is_queue_selected(struct amdgpu_device *adev,
> +					uint32_t instance_id)
> +{
> +	u32 context_status = RREG32(sdma_v5_0_get_reg_offset(adev, instance_id,
> +							     mmSDMA0_GFX_CONTEXT_STATUS));
> +
> +	/* Check if the SELECTED bit is set */
> +	return (context_status & SDMA0_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
> +}
> +
>  static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
>  				 unsigned int vmid,
>  				 struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 inst_id = ring->me;
> +	bool is_guilty = sdma_v5_0_is_queue_selected(adev, inst_id);
>  	int r;
>  
> +	amdgpu_amdkfd_suspend(adev, false);
>  	r = amdgpu_sdma_reset_engine(adev, inst_id);
> +	amdgpu_amdkfd_resume(adev, false);
>  	if (r)
>  		return r;
> -	amdgpu_fence_driver_force_completion(ring);
> +
> +	if (is_guilty)
> +		atomic_inc(&ring->adev->gpu_reset_counter);
> +
>  	return 0;
>  }
>  
> @@ -1617,7 +1633,10 @@ static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring)
>  
>  	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
>  	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> -	return r;
> +	if (r)
> +		return r;
> +	amdgpu_fence_driver_force_completion(ring);
> +	return 0;
>  }
>  
>  static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 365c710ee9e8c..84d85ef30701c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1451,18 +1451,34 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  	return -ETIMEDOUT;
>  }
>  
> +static bool sdma_v5_2_is_queue_selected(struct amdgpu_device *adev,
> +					uint32_t instance_id)
> +{
> +	u32 context_status = RREG32(sdma_v5_2_get_reg_offset(adev, instance_id,
> +							     mmSDMA0_GFX_CONTEXT_STATUS));
> +
> +	/* Check if the SELECTED bit is set */
> +	return (context_status & SDMA0_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
> +}
> +
>  static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
>  				 unsigned int vmid,
>  				 struct amdgpu_fence *guilty_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 inst_id = ring->me;
> +	bool is_guilty = sdma_v5_2_is_queue_selected(adev, inst_id);
>  	int r;
>  
> +	amdgpu_amdkfd_suspend(adev, false);
>  	r = amdgpu_sdma_reset_engine(adev, inst_id);
> +	amdgpu_amdkfd_resume(adev, false);
>  	if (r)
>  		return r;
> -	amdgpu_fence_driver_force_completion(ring);
> +
> +	if (is_guilty)
> +		atomic_inc(&ring->adev->gpu_reset_counter);
> +
>  	return 0;
>  }
>  
> @@ -1529,11 +1545,12 @@ static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
>  	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
>  	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
>  	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
> -
>  	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
> -
>  	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> -	return r;
> +	if (r)
> +		return r;
> +	amdgpu_fence_driver_force_completion(ring);
> +	return 0;
>  }
>  
>  static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 746f14862d9ff..595e90a5274ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1565,6 +1565,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 2e4c658598001..3e036c37b1f5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -830,6 +830,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 0d73b2bd4aad6..d5be19361cc89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1985,6 +1985,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index bf9edfef2107e..c7c2b7f5ba56d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1626,6 +1626,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 3a3ed600e15f0..af75617cf6df5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1483,6 +1483,7 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index c7953116ad532..64f2b64da6258 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1210,6 +1210,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> +	atomic_inc(&ring->adev->gpu_reset_counter);
>  	return 0;
>  }
>  

