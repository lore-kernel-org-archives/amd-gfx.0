Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035E5CD4F24
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 09:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA7B10E303;
	Wed, 13 May 2026 09:43:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tHD5EeGz";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012042.outbound.protection.outlook.com
 [40.107.200.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9065C10E303
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 09:43:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vg76Ki+v5Zjc8S9HgGRDBzDSzBvow4zbFQAA/ZyFYU9glnBNUiMtu9AeegK/70SPOftYnltOeCyYtSUhvxXwQcgR0pRlJUJ7bbtGDRzzXD9U5+mSxu57EfobPWswEPEWL8STuwfhKLo8dkrn8WvCEGYKtObwskrU3UWfpZSNRtehSESq5TIC3ASXGN5KeFl2DL5w25zgHiFxP/npKbDBNR5J6va+B3MfCDW0XbccxM8JpypfpXJERVBCOavNgRfJ2TwphNc6S2mfBV/5mMreIwoiJ3CCQTMyI/tWQHANH7rdyX6eUG+L0zEGBV7Mns7kcVlzFZa13Ch0PoLtCkxDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqL0cI9kdN/pemxF5Bjx32UWQeou6XQ2DKE7l2facwg=;
 b=nyz/YO6vyXjXyBgVeqSwAGD7+TYJGd2ROXx96mKRSXX6nFPJSWo0e3N5+2y2km7KHbyFVsL3tkSc4iObsKuVznt9lLSsfdIh5BycipXUN4tCtL5KEJTnAA7h99Jeuq54dMdikrngpp+JktcmNvnMgeX4Ht9AAwXjMESa74GuiH3v3+utLjmJ3QTdqVyRWnOmFzHr74KhhHy7BX2GxTFf4NsRHKBReSXy+da9Z3KpDU8IqyZnLbKJcoZAQ2U3NClpbCw0dXgUGyIm/goQTZOVa19zblwneWC0zLlHb4Nm1USjmHhpEaFO484uIZ/wtNLu8lu8VxSXBvS1YEDSOHKFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqL0cI9kdN/pemxF5Bjx32UWQeou6XQ2DKE7l2facwg=;
 b=tHD5EeGzNt5sgzxfugN5nyr/EbMbTRm0Pc4WfR49cK/M0uQCmRWF57T3YWMWMinEayjS5QDvni3D1TOEuKAP/yWM/ssPyHe60aVWE9kFDWsPZzoLlz+tN98MKyvYPXzx0NK9PrPG8I4Xmz0l02fFu3rFn84i3Vh0bjP2gm+5hZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 09:43:32 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:43:31 +0000
Message-ID: <39547ace-1a1f-464f-aea3-2b5a86c1e404@amd.com>
Date: Wed, 13 May 2026 15:13:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Use asic specific pa mask
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260512190047.655578-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260512190047.655578-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 84654210-e7cc-4ab3-117f-08deb0d41817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: 9EiKC4UvczCRpIIOtRI5omp3JqJBRKvoBJSQmslGRWc3u87HYn5lk07pveW5mSM076l9KjBHvreOT0abesazwEmYWHkG8tPmwcwadvwqdHgKMHm89ix9jx89Yy6GP/yoI8+hfH0XQKE8xsB0TQrqdUtho813UkVzfCebwa4EM5XA+GQO73EDhfk/2PJ/3ql2+EKKKCa+A3zZNCCw62X6ywIUciSb46GswI06SyZPBtD+Ij6jTSsKZs/LGm38oE5exBV56vC3Ptue+AsaEMCwRiEueVIVRWslelMEgdYwTb2xAT0RHOZWuGY94wCQGMxQKEa9yFTkeOr55M+c4xQaiGR32qOCx70c22I7a1Rpbxsz455aPMBjYd1b0HNld9tBjAN5PA2n2ct0/Q6+yIRiBBVioa4XXPsVtDIaX+yLNj1lJ557Zt+gqKPjFbP8K8IriTf+9fWfBH2UofKkAe0uw1cmGQokptJiA2JcnaAhCcmBG8HOGTZZFR/t56T1a+nx8Pxa0VT5qs4aQj+1owRyU5+bGSaypf0nHU5vhagt3wlKMNM1z6IpLYhntxkCyeMNuPu6JcqHR2vlIlkKD4yfctsyli92M2YZHudao7uJoB2qYZl9Mfpyl6FnlM0v17RQaZKcImz6VQ/9FJOPQ5DfJLzVV0XDQpeOC1QALN0Z0VQ8IcEvwxAezT/wYtl/fF+J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmpUbnFtYThUNS93bXFiWkt0NzZhNHpaVHVtamNTaDNzQlNyOVhFNVVLYit2?=
 =?utf-8?B?a1IzK0dNdHRpRlRGeE11N1A4NStBY0lqOTgrMHIyWC9FdE1way9zaE1hUndC?=
 =?utf-8?B?U2dVdHc3QUFVdDZLTFJXaGs5N2IvL2tjS25GQW5rTE5rSkJzdUlaYkIycHl5?=
 =?utf-8?B?YUF6cXZadlc3R3pqTmpscUxYenp2aVVxWTBjNkxYalhKQW9oWS8yQWdFZGxy?=
 =?utf-8?B?MUo0RTQwbUVpR1ZHY0VtVWtPajdkOXNjbVNUOFIvdzE2MS84dHRCMjFSME9C?=
 =?utf-8?B?VzF0eFhwMEdUL1FLRGRhY2kybHAxTXdJZFRGT3ZxZElwUDJJYllrQ1diTWpV?=
 =?utf-8?B?MG1FZVZFNWxDUW5EUUR4Qnp4YWQ0bHYyeDJZNUpKWmlCNmRpWVJkQ0l6bFFX?=
 =?utf-8?B?M0UwT2U3Tkthb1M0eFIrNER5bFpSL2Z3enAvNEFMWE1jWnFKWXlUNmdJWE83?=
 =?utf-8?B?THV1OWtNM29Od25Edm9EVTd0ZVd4blRBNlpubXJuM1N5a0pwckRmMUE1ODZN?=
 =?utf-8?B?TkhrUkVZYTMvc1pPakhpUDF3aFlxZjdRSzBBZDQ3c0ZtRFBOa0xYSmkyek1H?=
 =?utf-8?B?MXp4aldmam5mREZ2cDg4ZHhNVXJydUZjS0tkWSs4TitDUVlWaU0zNS9LUHMy?=
 =?utf-8?B?SFBCdHdNSkJYVktzdjVKais4TzRhYjhWV1A1VGJzYko2UEtwY0d2RUVYbmJp?=
 =?utf-8?B?UkliSmVLN2p4VGdyRURqYVdkcTRYQWQwbWhQTHlQMVpkNUM4UkU2QVdsMEVI?=
 =?utf-8?B?elcyZ3NBMzlmRDl4VmdyZXYvVjhrVEIvTTBJZGZtU2IycVJ1aTJsUGNETVJW?=
 =?utf-8?B?c3B4OWJlMGtobko5U1UyZmJxYXpMelozV3FHK1g4Tk16SEp4aVhCcDlGd2gx?=
 =?utf-8?B?YjJIN2p2aVRCOEFldXVLU0RGVEVhU05BeXM2VzBQQW5wUmFXVk84OG1KSUNO?=
 =?utf-8?B?aXlFSE9JUDFqQmY0Q2kzWXF0NEZMNzhkcXFmdW1LalhheGs4WHBOSEsvbHhV?=
 =?utf-8?B?SmdwYnZNKzgzNnBFUzVkS05EcHROWm8wb0pVanRQTUUvM1BUMHExamQ2YWNC?=
 =?utf-8?B?WVZmcDNVRzFvTkpydWVnV3BtV3c2WjNxb1E5QTZ1VWNTYWpWd2dXYUtDRFRW?=
 =?utf-8?B?N2lJTXlrSHVGbVE2R1NhQzdBcUVUbjVDL3NCcXFJa0tvQVE5U0Zoa0tUWXQv?=
 =?utf-8?B?UExoN3U4SWxORTNHNlJkeW9US2lnTDdBWlJRTjNkZ1FQaU16L3ExRFZ6dnZ3?=
 =?utf-8?B?cFB1akRNZ0ErZlQ1bG9JSEtCYm5OYjF3NlJEQTJrYjA2UThaUm1IeDZkU0FV?=
 =?utf-8?B?aFBSZ2ppZnNtRUJlVDBKRjQ3eVB4Vmk0aGNoMllmY01EY0liZ2lEQmlraitx?=
 =?utf-8?B?Vk16NThDV0ZVVllOVkwxTUpEVkJNeHN0UHcvVnZSWlhYOXV0YWVheFE1QlR3?=
 =?utf-8?B?RkNmZDd0NEIwWFBwN0VzMFBYMHh6WDBSTVBZZWs2S2V4cVpnOElEQ0pRR1Rh?=
 =?utf-8?B?RnJlRjRVdTNPY2VyTFc4ai9mZmc0M0Z4TE84WmlDRCtHOHJySG9HbVZUZ3Bq?=
 =?utf-8?B?ajM1ZjBodXdxalZQR0pJTlRtemFjSE5sT01mb0JGcTRHcFErT2lsRTE1Z1ow?=
 =?utf-8?B?Ui9hRjNxaTNhWS95dC9oZnozMVFobVFYcFIrNGlNNU13am9TTGs2QkxkbC82?=
 =?utf-8?B?SThoMFBxS3VkcjdtSGMrQkxSNVN3WEZUQXBzd1hjd0Y2ejVWc2c2Rm1VVTk0?=
 =?utf-8?B?QjBLQjByRFEybWw1QkNZZlZzd3ZoVkdCbE8vdWxHc3FzbHlOaERPTnFEWVhK?=
 =?utf-8?B?Wk1ONG5Ja1NXSGRFeHg5bUlWOTg0b2V1ZXVOa1FYMFl2WTVZTDVwS1kwdHN1?=
 =?utf-8?B?NU15dGtFa2lYK2ZMOFlscU1rSE9HRWVTUC9kMHlSUXpoNFhKNkZrOVozbkUr?=
 =?utf-8?B?NWNWbkxGSVNneExtTlFvWElsQ0dmR3c5M3hHSUNPa3ZXaGZaR0dlYllwbUxQ?=
 =?utf-8?B?eW8rMzh4R3NQUHErcGlyRzZyZHhGUGhhVUxmUDhUdlZwTWc5ekxBcXRVS3Fi?=
 =?utf-8?B?TVMrS2NHVGZBMHU2RWlrdnNZRWdIbVFyeEtiNW56WHVTTE9OTmxRQWZpV3dK?=
 =?utf-8?B?UkZFeFlnOXFIZEJQRXJtOXY5NDFYVGtvUTlDaldsTzBNVjAralJKZ1dEOWhO?=
 =?utf-8?B?UUJDVWZQSWFvb1VDQzEvZ1BybDB2bUlDcy8yeG00bkRyYkYyOW1scFhmdy9o?=
 =?utf-8?B?bFVBQlovK001N1pxL2VIM1dWTEo4U3dHSlNGU0lmWlRMQVU2OHFrd3NjNnVi?=
 =?utf-8?B?ZThQUVFCU0ZIV0hJOEE5aTRETUF4VXBxU2MyUmxkTWdXamw5MXdOUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84654210-e7cc-4ab3-117f-08deb0d41817
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:43:31.8498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDEfWBhmqTsjKYB3olH1MsoaKj88RQpsf4Ypg59Qh0mrZk6Gxy+34bDIZ12d+ERI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
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



On 13-May-26 12:30 AM, Harish Kasiviswanathan wrote:
> For PTE creation use asic specific physical page address mask
> 
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 1 +
>   9 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 13bec8461cde..631c8a7cc99a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -170,7 +170,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
>   	/*
>   	 * The following is for PTE only. GART does not have PDEs.
>   	*/
> -	value = addr & 0x0000FFFFFFFFF000ULL;
> +	value = addr & adev->gmc.pa_mask;
>   	value |= flags;
>   	writeq(value, ptr + (gpu_page_idx * 8));
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 676e3aaa1f27..886311fbc2d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -280,6 +280,7 @@ struct amdgpu_gmc {
>   	u64			real_vram_size;
>   	int			vram_mtrr;
>   	u64                     mc_mask;
> +	uint64_t		pa_mask;
>   	const struct firmware   *fw;	/* MC firmware */
>   	uint32_t                fw_version;
>   	struct amdgpu_irq_src	vm_fault;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index f2ccf30da324..1e98a9eb8e11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -843,6 +843,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * internal address space.
>   	 */
>   	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
> +	adev->gmc.pa_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */

This patch uses pa_mask as a value which represents the max PTE width.
It doesn't represent tha actual physical address capability - as in this 
case it's only 44-bit. Suggest to change pa_mask to reflect actual 
capability or rename the variable.

Thanks,
Lijo

>   
>   	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 93b1912e28c8..4b93afe7ac8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -818,6 +818,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * internal address space.
>   	 */
>   	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
> +	adev->gmc.pa_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
>   
>   	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 8bea8d0d16b4..a921e4c007ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -813,6 +813,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
>   	struct amdgpu_device *adev = ip_block->adev;
> +	uint64_t pa_mask = 0;
>   	int i;
>   
>   	adev->mmhub.funcs->init(adev);
> @@ -842,6 +843,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		 * block size 512 (9bit)
>   		 */
>   		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
> +		pa_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
>   		break;
>   	case IP_VERSION(12, 1, 0):
>   		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0),
> @@ -854,6 +856,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		 * block size 512 (9bit)
>   		 */
>   		amdgpu_vm_adjust_size(adev, 128 * 1024 * 1024, 9, 4, 57);
> +		pa_mask = 0x000FFFFFFFFFF000ULL; /* 52 bit PA */
>   		break;
>   	default:
>   		break;
> @@ -910,6 +913,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * internal address space.
>   	 */
>   	adev->gmc.mc_mask = AMDGPU_GMC_HOLE_MASK;
> +	adev->gmc.pa_mask = pa_mask;
>   
>   	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index b39f37597429..675e0fbec8cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -830,6 +830,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	amdgpu_vm_adjust_size(adev, 64, 9, 1, 40);
>   
>   	adev->gmc.mc_mask = 0xffffffffffULL;
> +	adev->gmc.pa_mask = 0x000000FFFFFFF000ULL;
>   
>   	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index eedd2006bec3..3eedd2b630c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1010,6 +1010,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * internal address space.
>   	 */
>   	adev->gmc.mc_mask = 0xffffffffffULL; /* 40 bit MC */
> +	adev->gmc.pa_mask = 0x000000FFFFFFF000ULL; /* 40 bit PA */
>   
>   	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 347259700dce..a281abb810f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1125,6 +1125,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * internal address space.
>   	 */
>   	adev->gmc.mc_mask = 0xffffffffffULL; /* 40 bit MC */
> +	adev->gmc.pa_mask = 0x000000FFFFFFF000ULL; /* 40 bit PA */
>   
>   	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 4cc3f2434677..0e485da0db8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1983,6 +1983,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * internal address space.
>   	 */
>   	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
> +	adev->gmc.pa_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
>   
>   	dma_addr_bits = amdgpu_ip_version(adev, GC_HWIP, 0) >=
>   					IP_VERSION(9, 4, 2) ?

