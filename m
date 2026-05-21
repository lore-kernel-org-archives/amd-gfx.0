Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED8FCD5BAC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 14:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E6C10E487;
	Thu, 21 May 2026 14:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xgjo0Wlv";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6AED10E487
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 14:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kV63tYMLLXwO4CIZyp0K/c9pHaFc/KGBoKXZRhU2+VeNxnrLLxZzLaB/GoMccJp7S6XcXNEUmJ1m9e8NYyyHZ5zP5BRVflh5dCNTFTl5SNdSN0NG+12Lft2Dtzd/nLSuWNgaruKrA0qCobFyMs1dFQoRrLdcbsMoItRdeZqDxJXf4ZxYvEqc3GJg2aPNlC762kzCfYnZsFOcDavbM0drwGOOmjexQNE0xoJLeR1mtOmRlmJeLNXWFSOUziV1X1Q4Dw4fy9dnq9uIs84wvwLbfgDe5p+6j4rTTTXUAtCLYrXkbC2L/wXS0caW9KmfKFBY7nNJqAMPeogwigMMzEYtrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwrHgYjzbIpG305nJJG5Qz7Sh9SvGyaHDk+NtwrLmLc=;
 b=g2haBHaDackaMvtbKqw4V1/0i0uHqfJ4OCvDzr826CJpdugQKNutKCq23glqYzYZJeX51Bbskdw7g19N1VC6C/99GvmmkabXP70IdWjOvJYjP40gvdgcx1jVB8/u6bCulsQMqOhnsFfl0rvCoW2WMLWBDMa/bXq/R/gok8t8lo6UAH2beHbTXmF2QCfuFgwdSD/G8gJM35m6NxAb6bomi4VblCO7qtiC1CUjEtO8xRoGfsrsecP1O9WBCiOytifEjkewnsjDx/K9cV9br5El4qHesLWIMFxqZVjcbVRJF4ganVnXCQuOC/WT5scxPqXnE9uS1H5Mj3Tceo2Zmb1pVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwrHgYjzbIpG305nJJG5Qz7Sh9SvGyaHDk+NtwrLmLc=;
 b=xgjo0WlvOGJOD5EVqMZ6Dr2aa4s2NtYCCk8u3fViScz+CNDxR3vLDD2FbVSCdJM8VMzH0GhyQuWOocZUsaBhDwUe+YVwJTdCCeY/T9uda1t9c5FIDWfS6lJ/Bp8faJtw3nuntY1oE3ss+7jdCXH1WOAPia1P3bYdm2grXZNLgaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.24; Thu, 21 May 2026 14:21:34 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 14:21:33 +0000
Message-ID: <547f4a5b-1b0a-4d08-ad45-18c8b1219665@amd.com>
Date: Thu, 21 May 2026 19:51:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Use asic specific pte_addr_mask
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260519222524.204872-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260519222524.204872-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0240.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0c5adf-725b-4868-bfb1-08deb74441ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: tGi/izVGRJEKoZttu9/Io8XvWZhF7tWGHplQjqQpPeDdH5mkk5iM09qNP4a1zLPyERpcrOr80UVfjRvIY9XnDQxWF5ObLPvTmpONyK83me/f7X/CslwO+ciOD4AdrqetHAwQ+QoF28IHDuiWz1Bwn/BxCT8AEvm8sDeZzUZTLHySvPTXhcZsmipwruEo6qlVAuLvEZ+o79gPD6fLoQOjExHm0Q+huHQvdiA0rYguiSiPj5tFIaeerEvpSqc5jJTru0oc5/GebKwYhANJW6lyhYeuZs05POmnIwgSGAfHOi9XKnjER11sJSNXSxj/pRdBegLQm8Pd3l7E2YBBvFs+0uKEokKrrUc2FytaKXUgb+nphJrTHbM0XLyDgZHTaivxU4xQcbM2xGhblXr78lhpDkiofv36XGe8WszHzlovLK0I9VzGewtWwoHL0sJQNMcS0Owl5JCBDQ/E5N8Aa7eCRsP7Le1qOBtRhQibHpFfrJNKSLnxLN6HnhJA2sJrSeEazucChP9kZ3QPDttpNqilgf/37NVbxu1g/0Off8z8jZxgKFFm2nyLIDzjb/MEWV06S4WCYF/3VSD//9MpPt6yeVwyqNS92nh3neLTc1VOeUE54bcdoJ9q3Yltxm9hU9lByevBguLDf6QZ91Y8KUjpCm8tC+fDM+42sRb4W6l9HYrM7Lk/1UE4/Mj72ZwoUdnq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHc2K3pyRUtPcnk0eXBrd0NYUllvcXVZUEt1UWQwOEZMVXlBcUhrN2tCeis5?=
 =?utf-8?B?bk5LMUlObmE5MmR3dTB3QUdZYmViU0prdE53MFIvY3doTXNFOSs1Q0VqR29T?=
 =?utf-8?B?WExGUWVsOUM2SjBNdFJiRkxKYmtRUmFLSGtlclgvalZ6QkJpRXY1alFXUE03?=
 =?utf-8?B?a2svWm9SRlFWdWdrbWozdk9RWnZsampvdFd4anNjNWRKSWRHY1E4MTgvblU4?=
 =?utf-8?B?Wmo3Q0NyTlpMZDJpMDZVWTQvbHRkd2g0d3hDOTc2NUh6SmpGK0NvdHNoRTg3?=
 =?utf-8?B?YitKUWN2NVF1WWpXSFhHMUxmaDZwaHJaQ2xpaHhDcnlWeEF2VkRlYXFOQWZJ?=
 =?utf-8?B?MHZET1BMeGxsRjhKbHlONmpvOTN1ZjZlb0k2SXR1NUs5K3NpN0duSGVCSnVq?=
 =?utf-8?B?cGJPa3U2WjcxUk9iTjBmOUM5cFhmZXByMDRCRzFheTZGcG5UZ3lxWWwyS2lQ?=
 =?utf-8?B?RmVvanNKUTRYemw4bXNML201ZlZ6b2FPUUZRVG40a3Y1RUpGMm5aWWU4SXpL?=
 =?utf-8?B?Vk55QUFoUTF1TVllckR6Vit0U21TYmR2dG9tVE9BWGxKVFViQUtOaUFkS2dR?=
 =?utf-8?B?Mm5YUzFTdldqbGtPTEpqNzNOR3JGaGVncko0K25PcHpRLzRWRGVzVytzMHFz?=
 =?utf-8?B?TFZnWUhYbTAwcndNcDhOR3F0WjNQTzhyMWYrTW1maWlhQW9aT1lOKzYzYzFP?=
 =?utf-8?B?ZlpDUFA3d3FPdGoxMHFMN1V3QUVmSHZFcFJMNmhwcThINlRMVlRJZmc2NXJ4?=
 =?utf-8?B?Snk0WXB3L0VPeENyRmxnMnFBa3ZObzJkbGZBRXE4L0NaWnU2T1MxMU1QT0VT?=
 =?utf-8?B?VG9TbXVkY1FLaDRwSkRsbjhTQnJmUFR4bW1NUG1zdTJNbzhDUWxhVEtaSk5R?=
 =?utf-8?B?MXRsZTlDYUNaMHVKd1IrdWlFdi96U3ZuRWdIVjltdVBUaVEySlBPRDdvMWly?=
 =?utf-8?B?QmJRN0tkUkE4Q2NnVTR2Z1RFUEM2NVNyU2FyazhmdW5ycHlhaGxoVGN2UEFo?=
 =?utf-8?B?WmF1dytuZjZva0NBcG1SZWdIbVRlLzRJeDJCQmtsVC94T01LYkloZzVjNkZl?=
 =?utf-8?B?bEdCOUt3RzdzZGd4UG1DTlBDY0ZEdzl6YWJMUWdwLzhJTG0vR0E3akFBK0tZ?=
 =?utf-8?B?OERqd1FNMGpObk95M0FtY0FERW1oczU5NGZjdFJocWw3MWtqVVI4b3N1ZGsv?=
 =?utf-8?B?R3p0R2QycThpRThqMkllMTNKNVR6YnM5eDlFdFFMYnAxZGZtc3hTZlVhM0Y0?=
 =?utf-8?B?ZVV4STl2UzNRb0pPazhjWnltMEpRU0hzcEczdGhKSEZWN29QcElPSytGdWh1?=
 =?utf-8?B?S1Y1Uk1DZTdSNlpXbCtTck5waitFRTN4YVplZ2tDeU5OUzlUdXd2K1VlSGtF?=
 =?utf-8?B?WVQwbHJHSm1XNTNZcHRncTlud0tVTFEzd2tocEw4blR3ZUF2cUxpK0dNU1JG?=
 =?utf-8?B?Vno5WVFRWEg4eHpTQTBTaUV3azduc0c2M2FRdnVuYWxRdjRUWVEvbEhmWVBQ?=
 =?utf-8?B?YWR6dVVnZFRZQVh0cXp5TmJpTGhoOEFEZ2tXNHVRSkJBRjE3b2U1Vk41LzRQ?=
 =?utf-8?B?YzZyQXc1UWNIbi9oSGN0UzBvQjJTYk5NUXlGVXI0bjUrN2lOWU43eTlTTkht?=
 =?utf-8?B?VHF0emtIQ1dDaWRoc1RPcHBlU3lDTkszdGVRWEsxeEovMlZEYzFVMEFXNi8x?=
 =?utf-8?B?WjV2aVc3OUxZcVNXWC8rb0VReTdVaUJCV2FVbmZmWFhUNVBjSDZCcGVSbDA5?=
 =?utf-8?B?T0RzdnV5d0d6eXlOMys3Nldqa3F4dS83QUdBYW1aemRpL2EydTJyWGtKZDZ0?=
 =?utf-8?B?NWdBdVVmdVUzSXVpSjhjSTYweUJ6K0FxSFBCMzZDU1dlUWVhdDVrcUFWcG9k?=
 =?utf-8?B?a1drZjFzMUZ3MmRUT3B1bE9GNDFHbENUMUZGWFRlZzQwSlQrRDZDcDNMK24r?=
 =?utf-8?B?MThLNXcvcWlWdVFQVUY5WEZpSS9QbU5pMHRvWGdnUGhTcDhvbExXZDJ4b3dn?=
 =?utf-8?B?dWV1S3ArRU9oZTBmS2MwMzdhQnRoVmdwTVFmWk9vOWUvZy8wbmNHMk11VWwz?=
 =?utf-8?B?elFzUDBMMWpDSlh5UlY0UUVmbXNMditUemJYMUVZa3lQVTZ6NG9CWkxqRUx4?=
 =?utf-8?B?TUk2WUpkRGg2UmV3aHZFaDh0Q2JmUmJ5TkYrZHdQRFlGL0pRSUJsZk53M1dL?=
 =?utf-8?B?djUrTU5jNG0zRjBvZTBsRHRTUFFMNzBHbFpyWmNQZzNmWTZtQmJZMFgrUFMr?=
 =?utf-8?B?TG4wVjA0UFFLS3ZnTU45NUtiT2NhU3MzY3hlaVk4T0RJSTJrdWRoL09JMStS?=
 =?utf-8?B?UlZJZ3FpYUNlTlg5RTNINlRoSGdxNVlBc2FGdG1xUVpob2FSRVdiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0c5adf-725b-4868-bfb1-08deb74441ff
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:21:33.3322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GbfVkuI68mbQ4hqVDjNleRXVGgzHrusS0Y8kVCgLbxRYvP15KlQSzyrRkrihE2W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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



On 20-May-26 3:55 AM, Harish Kasiviswanathan wrote:
> For PTE creation use asic specific physical page base address mask
> 
> v2: Change variable name from pa_mask to pte_addr_mask
> 
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Series is -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

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
> index 13bec8461cde..b49f5f0e3d87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -170,7 +170,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
>   	/*
>   	 * The following is for PTE only. GART does not have PDEs.
>   	*/
> -	value = addr & 0x0000FFFFFFFFF000ULL;
> +	value = addr & adev->gmc.pte_addr_mask;
>   	value |= flags;
>   	writeq(value, ptr + (gpu_page_idx * 8));
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 676e3aaa1f27..ddb0d500e0fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -280,6 +280,7 @@ struct amdgpu_gmc {
>   	u64			real_vram_size;
>   	int			vram_mtrr;
>   	u64                     mc_mask;
> +	uint64_t		pte_addr_mask;
>   	const struct firmware   *fw;	/* MC firmware */
>   	uint32_t                fw_version;
>   	struct amdgpu_irq_src	vm_fault;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index f2ccf30da324..b5c3b7ba49c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -843,6 +843,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * internal address space.
>   	 */
>   	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
> +	adev->gmc.pte_addr_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
>   
>   	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 93b1912e28c8..8a49ce0cbb6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -818,6 +818,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * internal address space.
>   	 */
>   	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
> +	adev->gmc.pte_addr_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
>   
>   	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 8bea8d0d16b4..0052a40214a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -813,6 +813,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
>   	struct amdgpu_device *adev = ip_block->adev;
> +	uint64_t pte_addr_mask = 0;
>   	int i;
>   
>   	adev->mmhub.funcs->init(adev);
> @@ -842,6 +843,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		 * block size 512 (9bit)
>   		 */
>   		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
> +		pte_addr_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
>   		break;
>   	case IP_VERSION(12, 1, 0):
>   		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0),
> @@ -854,6 +856,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		 * block size 512 (9bit)
>   		 */
>   		amdgpu_vm_adjust_size(adev, 128 * 1024 * 1024, 9, 4, 57);
> +		pte_addr_mask = 0x000FFFFFFFFFF000ULL; /* 52 bit PA */
>   		break;
>   	default:
>   		break;
> @@ -910,6 +913,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * internal address space.
>   	 */
>   	adev->gmc.mc_mask = AMDGPU_GMC_HOLE_MASK;
> +	adev->gmc.pte_addr_mask = pte_addr_mask;
>   
>   	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index b39f37597429..4c3ff0b9b954 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -830,6 +830,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	amdgpu_vm_adjust_size(adev, 64, 9, 1, 40);
>   
>   	adev->gmc.mc_mask = 0xffffffffffULL;
> +	adev->gmc.pte_addr_mask = 0x000000FFFFFFF000ULL;
>   
>   	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index eedd2006bec3..ac838ae5794f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1010,6 +1010,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * internal address space.
>   	 */
>   	adev->gmc.mc_mask = 0xffffffffffULL; /* 40 bit MC */
> +	adev->gmc.pte_addr_mask = 0x000000FFFFFFF000ULL; /* 40 bit PA */
>   
>   	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 347259700dce..74cf597ba54c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1125,6 +1125,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * internal address space.
>   	 */
>   	adev->gmc.mc_mask = 0xffffffffffULL; /* 40 bit MC */
> +	adev->gmc.pte_addr_mask = 0x000000FFFFFFF000ULL; /* 40 bit PA */
>   
>   	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 4cc3f2434677..3e4a25c51498 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1983,6 +1983,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * internal address space.
>   	 */
>   	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
> +	adev->gmc.pte_addr_mask = 0x0000FFFFFFFFF000ULL; /* 48 bit PA */
>   
>   	dma_addr_bits = amdgpu_ip_version(adev, GC_HWIP, 0) >=
>   					IP_VERSION(9, 4, 2) ?

