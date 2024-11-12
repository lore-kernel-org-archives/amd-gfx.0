Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DC4D42B85
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 14:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5332C10E5FB;
	Tue, 12 Nov 2024 14:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NhFtmrlX";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A91110E5FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 14:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qa5lbY9QNC+ZJRHNqFh19hjgq/bL/3vzXkXpO04Q7CMX2f1D+lxVFGbyQ3JS186epZDhf3C8YAh+ZKzFXY/qZmDWEG66qGiPukirUjEfI06h8PsYteEGh5M1uGmlA75w7L+QDCi4Vwc6mqTVvRbygld+Q4v48T1G8FKksendboFCd7mRet8T466TtaKEKpfIJKSwxntg1QlSDiuiGf5c6Td7sbK+/1DWHTmANHqxxzKEzQPOxHlK0PnqMQoNxbn/2dO/RjnjlB6gpnimpCw9nlXZruqvboE34ricdPGHrXlf5i75r28BTsJxeKuDwYALZdFjf2Pm4Jw0BTXbmnjnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvc5BTvSVuFCAgVQHFNcPgj0TehsyH4e69q4qxeoMV0=;
 b=VZLd6rYCpBSGSThC7X4YBzZ9uv+lE0OKrM2vuROrFePdXq+6kLJp9lNc6OKYeNQ46YEjylHQkdcp36KRHv0RF0ABiR2i1Q6OQIbZon8cma6KvIfgYdayEJtxP8v1kZgSWTAr1ZvsHBjwk474TM/tYlbIVcAq92ismyneB+vVowu27RoGJSNC9Eps0k8/pSeO5BQ81NSAfu/1Td3WzRii3jJftse/uF/jPY87PL3k7I8nsvjHiTURcSRu8i5pIm695cpyo0AuKn6aHeI2xW+S9wHguwM+ERMaJcnang+bW7FvOasTlKbA2RtbZAm5iKVZX8njJV8GtveqjZXNo5y+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvc5BTvSVuFCAgVQHFNcPgj0TehsyH4e69q4qxeoMV0=;
 b=NhFtmrlX/naJqQ+aZlYis4ld3b10EkxJqwlznIuq31DeOILz/wz8erSbCWa8c+tF48z/4nOpMv+qYPeBwkXlQPX1I+/Z3z3QGkZlCtU98ej4GS7IAww4EnLzm971ISboT16DCMAD7I2yd3ZJ3QSq/db6sKQLsBO1oskYuF46c0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 14:54:19 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 14:54:19 +0000
Message-ID: <910caa3a-802a-41d6-ae07-c39292081d4d@amd.com>
Date: Tue, 12 Nov 2024 20:24:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 vitaly.prosyak@amd.com, Tim.Huang@amd.com
References: <20241112143050.1931822-1-jesse.zhang@amd.com>
 <20241112143050.1931822-2-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241112143050.1931822-2-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd0f9cd-01e4-482d-137a-08dd0329e29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THg3Rkt3TmJUSXhRRDN1dUpDZXpWV3pqakdhVXREN2c4b1V1SHhQMWRtbWFG?=
 =?utf-8?B?TjdPV2xJWEFWWlUzQ3Z3ai9tWXVYWnNSMGpXa2RMV0RCZ0hNdmt0a1pSUVFo?=
 =?utf-8?B?QzE4Z3A2cGlHV1lMOUdjV04wQkIrdk1EVkxvZVFzM1NBWERSbFB2TlFGMzc1?=
 =?utf-8?B?Z3RpWHRZM0NQNGNkZjJsb0w0MGkwRW51UmFZSDJkYmJSYjI0bjZtOEpBTUNU?=
 =?utf-8?B?akkxZFI0VnVjSzBTeHlGaEdnMHRsdFNmZ0hrR3hKQWVKQWsxNEhwSlovN3dD?=
 =?utf-8?B?L1BaS29LYm1sSTU1bERTWEpjRVYvY0JzUWtRZmlKRDB2aG9EbGZLMW9yMmVD?=
 =?utf-8?B?eEZsSGJOUWowZHRMRUJUUEpRbU5JZjdtRHZVZjU2Y1Vna3UwWndaN0dBQnhz?=
 =?utf-8?B?SHNNdlR0SHQrbzFLZm51aW05TkRmdWU5dWV2NEpianV3Z3BsSjF4aFZPejg3?=
 =?utf-8?B?MHprSlRsRzZFb2hlZzNnQXBXVE5QdVRFUElFak5DUWk0VTVabTRSNzErOERO?=
 =?utf-8?B?Q1h1SVZ5NFFiREh3WGJZSG15TENLWWNuWERTY0ExODd5dXdONUVWdkxQY3RY?=
 =?utf-8?B?RHRpU0NZYkdiZ0ZCTVNDWnlhcllyMHUwMEdkeGxTNGJFUDcyMkFOWVVLa051?=
 =?utf-8?B?d1BlK05RbUlFZWxyUUpNZjM3dXhmcE50Tjc5RW9Yd01uWG1BeHRCS0xEN05N?=
 =?utf-8?B?aUhPZkcyc2czdTBYUHpSSDhqN2FObEFDaHk1bzZlRERhay9vcVNzQjlLdmFl?=
 =?utf-8?B?dWMvaTFEaU1JNFNDeVhRS0RJWUZ6WCtvMjZDazBQSmg4MEljdEFERjlnREhJ?=
 =?utf-8?B?TXVERmw0WXJGaDhHS3kycFN6eFZtMm1SQlNFdHFSNVFwbzZjM1lCRTEwQlhz?=
 =?utf-8?B?TVdWRGd3K21WUjFOVERrZWsrK1p2TGJ6V0Zjc2VPUjR6TkkwWnVmRkdlOVRM?=
 =?utf-8?B?emJiNGQ3SVBBL1k0T3B4YWFCWU1vWTR2MTlXR01aL2FDMkJmUkNDWFVHaVJa?=
 =?utf-8?B?MFVRQ1VxcTdFRldwUTVtS0RZWHhONFZCYWIrRjVCWHhZK0s1bG1NRzl2ZjBI?=
 =?utf-8?B?Q21aQVhFT1J2Z1lRcGpqN3ZJUzYvemdGWW5iUm93K0lOOXRWZGdwTzh0QzZ4?=
 =?utf-8?B?QkU2blUzMUhqUzQyTFMrclB2SWhhS3RxdFpwRWoyZFMyWFBxaHlIRC9RR0o3?=
 =?utf-8?B?S0VCeE94b1FFZ1cxdGVKdDMrU044VHBBSUhtQXVzdnNiYkwzdjBSNnh4WEE1?=
 =?utf-8?B?SWhQczFIR3Y4U3oxRVdwYk5vYnF3M0hvOGYxYkwyNzJwOVJyZEZCb3BieEly?=
 =?utf-8?B?WVVWZnBRMWZGdHVzd2psTzBIa1lOWmZUdk1vZFp5T0prNk5SZ3IrcFJ2TGFB?=
 =?utf-8?B?U0EwSnJneGJmTmk3SWJlQjRONW0zTmM4MHAva0ExQW5PUTFGKzZPZVZRaHBY?=
 =?utf-8?B?dzgzR1QvaXhYUlR4WFhJdTk3QlAyTDBjSUlXWGFRUkFOT0F0WUtoZFBuSWVt?=
 =?utf-8?B?cS9keHFDSk5kS0pQU1NXWGVxZzhLalRwUUZ6WGZjeExYak02eDRkbFdUYjJM?=
 =?utf-8?B?ZmdZZm84eDlYRVdDMjBoaE5JRTZLZmZqMFllU3FScENQTnhCMFJLRnRkbzE0?=
 =?utf-8?B?T1FxNXd6U3R5RmY5Z3BPNkJOcXhUMWtHbjRWcDdvV1MzMEdHcy9yN0FacWwx?=
 =?utf-8?B?ZUpHM1dySUV4WkpHc0gxTnZjRWtOTmhNNU41TlJjZGpQc0Z0bXdEWHVidzFm?=
 =?utf-8?Q?G+7W2Vj1iWP5p9k1q8yzPteEU6DcWeu0WeYdaag?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG5aQVFuQ1lkWEJPNjRkQzFmUnlKUU1pN3c4RWtRV1NNMjBQVzhzUEtaTmdX?=
 =?utf-8?B?V2U4RjNsaEtNTElISDFteW8wd1QxT0cwRElzSDQydk5oT2h5RnM2cE5KYTdw?=
 =?utf-8?B?OC82Q2ZqNC8zbkszSnNsRFZRcG5sK2c3SmNkNjY4eVExMnplelRsb2tuMy95?=
 =?utf-8?B?NTBXR2xnZk1MQTZYRVovdktnVEM1WW9nb3djWWc2N2RxWGxVTzAyU3l6Z0Jj?=
 =?utf-8?B?S2FqdWl6UlcyYzUzS0JEOXEzZmZqYVJkb2FsMGtsM3RaVHpNSjNNY3VDL0or?=
 =?utf-8?B?KzdqbG5TMWN1NGtTbzFYV2E2enJ5Y0M2bk1xNEVwOVZ5VXZyMC9BL0FEaDJG?=
 =?utf-8?B?Mkc4c2JidUJEdFpZN1A4M0QzR1RmSFVCa1VncUlPd0M1K0RKUVB1dHNIcTRT?=
 =?utf-8?B?MDhHVkpsQkJFb2RGZndCTlAvYlpNa2tZZXNPL0FGNDUxMHROdkdSeW9sRldN?=
 =?utf-8?B?R1VEdFhDbXVsamg3RzZ4MjIreGNnNXVxWXlrSnp6bGpnM0Ewa2ttNmgwSkVU?=
 =?utf-8?B?NnFDbFdRT0lTRndlanZSSldLYXN6Und5Zy9QMmdJWXRacDNnQWw0SFhYbjRt?=
 =?utf-8?B?OE1RQWRBWlhnTlNHU0wvRHhVamR1VGl5Tm8zaFNjei9qN2x5andKYXozcU80?=
 =?utf-8?B?elZJaWtYcUUreldaanQycnA5YWhXeVBzQWQ1SSthTmdyYkpWTFhtYUtaWHYr?=
 =?utf-8?B?ZlNOTVExaEJDaVI0eTRDS2RndlJDeHc3ZG1iZ3dWSG15OXh0dFFVUlBmd3Rn?=
 =?utf-8?B?ejI1MHdrOTNJMVJkQ2dVZFVWWUQ5eFRUUmlPTkI1ZzhLcU1wbDJXcDhZYkZG?=
 =?utf-8?B?dW5GRS9Bd2c3RjdMbUg4M1dNaysyanZzbFdFVUh5WHJLTkFnL2ZQTXJXZHI3?=
 =?utf-8?B?QW5lQXQvUFVaaGpWL1A2T1hjZU5rOExxSkRuZlJKcSt1RkdVWTBlaGh6aDZB?=
 =?utf-8?B?QXhwdG9NbzM0eEltWk1IVzRiQWJIVnl0bW9jM2N1c3JsaDRybmRDRTRMdGI0?=
 =?utf-8?B?SFhEN0JmK1c2TnlMQXRkeGlJdkNzY0pKQ1F1SFhUcUFWdkdaVVRKdm1LTys3?=
 =?utf-8?B?S2UyeDJMc2o1SlJFbHFxdFhIQzZQNDZvQkJpcitjUVorMHlJcm5UK2RIWDdn?=
 =?utf-8?B?aURCVjhhMWxJVzdXM0c4ODd0UzZvVjJUUlRad3Y3M3NRcVp5ZGN0eUN6UlZn?=
 =?utf-8?B?L0dhRFdqcmZ1UXk5elp4b0wxYzh5L3FmNFpLRzhUdm44Q1AyV2MvdUpHLzZ4?=
 =?utf-8?B?NTQwMnU4dk9nQ3F3dWtFTW1CWTNydVErS1VsQ1VMb05NcVIxQjZlYks2V1lI?=
 =?utf-8?B?dTNoWGRiU0tPb3EzS0g3UEFoUUJUc29qaS9GYmpUVGhJNk1PMG0vYWw4Qjg4?=
 =?utf-8?B?cVcrQjVoNER6TjgyQ3pKTThaRjVPdVBOOUNHbVRYVmZiZGdqd3lDamFoRWxG?=
 =?utf-8?B?VXJ4cW82SktsdHJGajl5ZFMzaFQ2bmFjTnAwa21Oa0ZVeXRjeWphZ0xCMEdO?=
 =?utf-8?B?ejZsTmJWN2xieW0yT1B0Q09HMUNFNlcvcUNCYTI5YitCd0VmYzQ2Vm9UMVRt?=
 =?utf-8?B?a2g1cVdpblRGazZld2h0ZmthYmQyUFNzblBMRWQ1VC85VnNXc2V1S0tnMGxy?=
 =?utf-8?B?SVRkZW9VQmpjOWlWa01hdC8rZ1BubzBXOTZtKzBiUWZ4U3BqNG5CNytUd2Zr?=
 =?utf-8?B?RXYxNHhrdGgrREJSakNjeUtVTTRwVmQvRE5PWVIrZEVzSnd3Ry9kaGswYS9R?=
 =?utf-8?B?enpOYmxVeDVCaVowdERuREp4cnl0RDdldTJJbHVDblU2cXhEVk1XakJuNWRB?=
 =?utf-8?B?anMreGl5aTJnbUozZmFRUHd1ZEp4OXdQbzFEc25vdjN1Nk96MWQzUTFWbm9V?=
 =?utf-8?B?NFlYTmsyeDRWMGtraFpGK0dxejRrbklid3d3ck1hY1RrbzZrQkY3dG5aRUFM?=
 =?utf-8?B?OTExK09TeFM1dTZNdTR2ZTY4Kzg5VUViZHNpckQrbVFzRnJTTHBGaU9wY2NX?=
 =?utf-8?B?MHBJZG1ZRDladkJGSXJIanpBZld2MzU2NFl4MFVrVlBLYms2djg5cGZUbWh5?=
 =?utf-8?B?SnphT0R3eVlaUFIwQktwam96TkhBamRMWEIrV1kxMmN6WlF2SFZlbEdqbE9I?=
 =?utf-8?Q?P2Cd13ewmt35KByRHgmWk6Eaq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd0f9cd-01e4-482d-137a-08dd0329e29c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 14:54:18.9821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeEf47Os35msLh4wm7PBJJHxlmNbKyrmcvfCcjVaPQ1A8jFIdwXImd5KXHsNDEvG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
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



On 11/12/2024 8:00 PM, Jesse.zhang@amd.com wrote:
> [ 2875.870277] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP block <vcn_v4_0_3> failed -22
> [ 2875.880494] amdgpu 0000:01:00.0: amdgpu: amdgpu_device_ip_init failed
> [ 2875.887689] amdgpu 0000:01:00.0: amdgpu: Fatal error during GPU init
> [ 2875.894791] amdgpu 0000:01:00.0: amdgpu: amdgpu: finishing device.
> 
> Add irqs with different IRQ source pointer for vcn0 and vcn1.
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index ef3dfd44a022..82b90f1e6f33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -83,6 +83,10 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
>  
>  #define NORMALIZE_VCN_REG_OFFSET(offset) \
>  		(offset & 0x1FFFF)
> +static int amdgpu_ih_clientid_vcns[] = {
> +	SOC15_IH_CLIENTID_VCN,
> +	SOC15_IH_CLIENTID_VCN1

This is not valid for 4.0.3. It uses only the same client id, different
node_id to distinguish. Also, there are max of 4 instances.

I would say that entire IP instance series was done in a haste without
applying thought and breaks other things including ip block mask.

Thanks,
Lijo

> +};
>  
>  static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
>  static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev, int inst);
> @@ -150,9 +154,9 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	/* VCN DEC TRAP */
> -	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
> -		VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst->irq);
> +	/* VCN UNIFIED TRAP */
> +	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> +			VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
>  	if (r)
>  		return r;
>  
> @@ -174,7 +178,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>  
>  	ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[inst].aid_id);
>  	sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[inst].aid_id);
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
>  				 AMDGPU_RING_PRIO_DEFAULT,
>  				 &adev->vcn.inst[inst].sched_score);
>  	if (r)
> @@ -1734,9 +1738,12 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_3_irq_funcs = {
>   */
>  static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int inst)
>  {
> -	adev->vcn.inst->irq.num_types++;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return;
> +
> +	adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
>  
> -	adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
> +	adev->vcn.inst[inst].irq.funcs = &vcn_v4_0_3_irq_funcs;
>  }
>  
>  static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
