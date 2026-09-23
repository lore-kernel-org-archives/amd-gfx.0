Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E847DC9830D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 21:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7096410F1F0;
	Wed, 23 Sep 2026 21:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gzaH13Dz";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94F6D10E4C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 21:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhrPz9S5ou++Nz2kUq56+FC3gZydO3p1dG2XxYtRBbfdzgT5s8ksdznjmHnaFG3ywWdmlE/sr+uKD54UgJ+lDUuINMNUO4VUFJsopszH6+RW9T/JNbe+MmYRNqkPKe17o4hw09CswtZiC5zMi6mBz11nDjoH1s3CPa/cWy3Fg5gxLTyeRaYc38WOYIwkgWYa7nRA0l6HY0ESyiVoiEka3fGBVuOrPG7OiH6Ia1VGAyo/OE9H1aIY+ts1EjUpNHhO9OaOvr7mfYmbgRbeLdOwV1Jj+QsSl95Vcr3T7ssNVL2IBbmfmC68/yLsBxUGzCNmH0Bmn2qe8lJkjLNIlQJECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acwKQteNhM/cnF9o1JkGwuoCfFVZZujnP2MgA23CnQc=;
 b=hObt1Jf3jFhUdHlciL/ELV4wKXPkpqZmBvpVX1OndrW0nSQKkqqJ2C/jrGwWh2ZMZumQiZhcEn6ZuHd1yW5T1Xv2q85dvW7BN8SW81Rhk+m+KzfEExvfsiuCxWm73Zhv/wA8flugCwU8zhBwIHiXT+mnDb2ghqz6ELlBdU6mJDeQ/Qnzb2BQSsyGlMhyToopSbDeMhQNjk0vokJUz+8TL3W1yxo0gBaft7mHK/0WhiFg6uj33ZrTlg3lzVNO36m/uL1B5fTEPx8w/5afdHqNZBhefCAHeyr9tmjQiiiXTe6rkFC+HAVVCeWfw/Y7YwsavpFad5b+0ww/nzWQ6v+sbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acwKQteNhM/cnF9o1JkGwuoCfFVZZujnP2MgA23CnQc=;
 b=gzaH13DzqP4ZRLymr28T44GjF8FjO4tjAs1FmamyygMZUDgvhh3CisoxSlQEO1T8MhwIMpQ1kVqFOFSOpR4FgOytm4oiEbt796Yj4dnI+4JidUPSnKaNxvoWcK9+ycy1qrRi8+DWFBNMICyRbRa7PQg62bI8S8zWs+mVzfW6Sp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by IA1PR12MB8519.namprd12.prod.outlook.com
 (2603:10b6:208:44c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 21:49:01 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 21:49:01 +0000
Message-ID: <7a82a2c0-4b3d-4a31-876b-ec4110d62340@amd.com>
Date: Wed, 23 Sep 2026 17:48:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: place VRAM-capable dma-buf imports in the
 PREEMPT domain
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com,
 Christian.Koenig@amd.com
References: <20260923212838.1421843-1-mukul.joshi@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260923212838.1421843-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::11) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 04cc1b7d-8aa3-414c-7799-08df19bc7a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|5023799004|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: RP7BEP15ZzvxcUQkd2nxQ/hwGB7eR/XAp1n7YfyOPHSUOPpBP233vrAZ7zA/NqiyC5BQ1H1RcEKlI2JgSPOXg6zRoSuCDK35iGg+5c3hLWICha+E0IEckQdN7QAVbBrZx/jvJDF428iPvnVfNQ5U1Pb8sTO/w/YDO5p+e978eJBqt1//TUs8Y1NcsRGcCWS/59szqmgG24L6OqGlo9CSDl3XoczXueMimZdU3X8dhZ67UvX2mMU1tT/2uUtr3UA+a2HOxEh0/lxnGhuDRMx5H3jgfHfCSlKgSm3RfM7HJWlAv9mQHADiV+nrrKxrzkitR3hlKuvECilLHr9XWcrEEI2J+IcU+SI04cE04HLxPrDaaBPSw/qVtjYaKxNSc3QySKkk6L9AR9oom1RmcC1JAUPTVNq21jDkw5NQlOCHie2sppHwe6iLsiN/2IAZQcpIyj2PiycO3JtaQudgML+DRdEZfzqFcelCUefxST0dpc/DPsbATVY+7n2CIaXWaczmY0LoHr4b5a5O87M+o8ry8iKlEZAyDRQ7bEEo4ZJds6bHDWnst1q9ovKIIHBnmsjcBVPdk66HMgbCqQpY7W/YvI319hI0GvHi+abWzkbS2qRmDJ3cVdL7DrtNCvoCE6WIjpScaKnvGtUiWGxO3pfuK9Ev+H8JBm7y5YxeRPjw8gY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(5023799004)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzVqMTl5eGJ6dnBQSkdiaFFSUmQ4VlArb3BYV0pUZUZxaUo5aGZXdWZnZk1r?=
 =?utf-8?B?OFpEejh2dVdKRFVhUyt0NnVOQW1IUHVzUlBvdmgzcWo2TmJvc1FFdlhIWVVv?=
 =?utf-8?B?elJiYUhXeStYMzVLN1IreFFZRlkzaUV2eXpuaHBXam5GNjVXVExacHM0R2I1?=
 =?utf-8?B?TUpXN3YzNndmT0NtbGcvK21HNWh1cStmaWl6czUzZk5jV2h4UnJCY0dGYWFP?=
 =?utf-8?B?dUl1SFErWnd6bTRkU29VcktsTEpiM1NUelVxVDRwYVFIT3h4Nm8ybE1sR2d4?=
 =?utf-8?B?TWVkVVl5cEF4QUJtNDBaUE92VUdQNVN3a1p5SnVMVUxoR0tmQml0SlVTN1Yv?=
 =?utf-8?B?UE15bnZRSzlHZUZSd25BM01VbHV4NjRiL0IxMCsrUTRrR0IxWUpldlF1ZEw5?=
 =?utf-8?B?T3hoNUppWXRBaFI3ZlJ0WHM2QkVqcHJwOG81Z2c3YVk3V2JkdndSVHdPaS9G?=
 =?utf-8?B?Z1VFOGxCME44ZEkySzV0MExqSHN1YlJ6a1BPL0o3YVBFbGZuU3JZT0g0RXBv?=
 =?utf-8?B?QkswRnUrRktTdHI4T0xIZjNBSG1vanFCcWJ2K2xyRTZyYVJnS0wwRGpxQzU1?=
 =?utf-8?B?eXpHblVHVWhvbVRRaHZIWVhBZTdrWFlPN1B4ZzlQWHY5cWVQWmdmZ0hBVk4y?=
 =?utf-8?B?VThxRml6cU42b3JTUzgyd1pKSi9NbFN6VkVKb2kyeTVBeHBoUUtEWGNzZUFj?=
 =?utf-8?B?VjBiekgyckpIRHRZWjJyclJVMmJLWkR0S0dNNm45VnpKOVVCOXNZRkJFMUxw?=
 =?utf-8?B?VHdqUTdZak5wR0JJelhnQUo2VG9vT1lEMTFQR3lJdXl6djJsYXN5T1BFbGtj?=
 =?utf-8?B?RFg2L3RaVzcrWXVZa2NhNlhuVjg3OHVteWMva2dUbnFheDFJLy9Eam1COS9Z?=
 =?utf-8?B?ZHlydE1SenYwR3QyNVJRUWI5WS9SaEpwMzZGL1F4L05kRHFNek5hdjBCNDZh?=
 =?utf-8?B?a1ducjk1K0hhS2NITmlCaTlmV1FoaWxwTTBjcERhVTR2UEFoNmtLbkpaQ3hW?=
 =?utf-8?B?MlN5UEFXZmhwcllmZ0wzUCtMdE9tRndtejg0U1hxTk9IcHgvZUFlbXdMSHlu?=
 =?utf-8?B?ODJkRmpzcERpQldtOElEd2g2VE1YZlpTeDR6dGZTQUNic3RqT3o5bDN1U211?=
 =?utf-8?B?ejQ0TC9NRWI3MjFuOFVoSkJrYWdvUjZ6K2cwcTAySjNoQnRzWjNNT2FPSEtT?=
 =?utf-8?B?c1ZDdGJmTzMyT3M5K2IvMFJXMWhtZGhFTUpDN3RKVWtWcTZYWnQ3WmhNcmlC?=
 =?utf-8?B?TDkyK3NjdCt5SHN3dFRRekNMbUhRUjFNODRYdC8rQktoM3NjeTkwVVI0akpG?=
 =?utf-8?B?RjIySjkyc3N6MU1JdlZKWFNOOUdsWnhRdTlFNTZTK3NIZ1BOM3NKWGZwMUZk?=
 =?utf-8?B?NGpONm5ncGNGYThzVnJ5QnVPWENrMWpVMDd4K1pZanZobVExQlB2OTZ1OCtX?=
 =?utf-8?B?aDNDeFQ0S0RrMlAxUE8rQy9hMkRPY25CZmY1M0ZEdzFBWUhUY0IxY1VrVC96?=
 =?utf-8?B?bTFrYmErakZKTlF0ZVNMMUhsWnJOdFhYMEVIWkV6ZlNDL2lkaU1SWkFOSlA3?=
 =?utf-8?B?VmJQZWtPQWJxUVFwU2F1bEtXRmdPcGIwUTY2ZXJyOC85cVcvVjJnSlhnWDV3?=
 =?utf-8?B?UXBBMlk2SnViZnlKVTJkUExVWHUwdFV6a0J3NXZSWWZNelkrVmtqQVRqVWxD?=
 =?utf-8?B?QzRMQ0czQ3QwblVGRkxnT2hsZitMSnMyZFFqQ0Q5Y0hrWHpXYUh3VjFWS2NW?=
 =?utf-8?B?VEo0cHd6RVFMWkx1dDdpdDM1aHJoREd3ZHk5S3hGSndzRlNVQjMrcGFmMlVi?=
 =?utf-8?B?S2VNVmRvR29TSmpZYjIvRDVndVVUK3RXRTVqeUkrd01PQ2U2MmVVNFNralJl?=
 =?utf-8?B?UGZacm9lVHV6am9lbEFRcE0xY3lPcEI1SGZ0cE5VKzF1MGNPbWRrWXhWL0tL?=
 =?utf-8?B?dUdnb1dWWXVlSTQwdmN3bndqTHpjL0FYUnJxdk9lTVh1aUVUUko0eTB6SWlk?=
 =?utf-8?B?ME95T2diRDhaOEZscmhDbTRaNG9YRmdvbVlyTzZjOFJQTDkvZFF5QUlnaVBH?=
 =?utf-8?B?SzNUeDFYa3o3Ly9pcWluUVJ3R25tKzM4cFhsaFhSdHVkUFhNOFIwSXR0MWNK?=
 =?utf-8?B?MEtjR1pQZlFPZGhnS0w0THJsZkZYKzA2QlBIMzZjeDJRMnFtRnNuSFpIT3k2?=
 =?utf-8?B?L0tRbnRBUnZpakVEM0J2dUZRWnlvSmRuVTBvQzgxWmtPVzBJQnBHY1JtcFdV?=
 =?utf-8?B?dXNXTkhPa2FpMFh3VlduZ2JKZGtwTGFEcWNwNWVUaHBlcUdjd29FRCtnRXdy?=
 =?utf-8?Q?4WiwFOzcj8xHvk47p7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cc1b7d-8aa3-414c-7799-08df19bc7a7b
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:49:01.0358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O38BymW1ouwJakgU2bhPKDfavn+3a5EuYkR1Vg4MaVAj4HihQC47JfcL06Wkv5BtOPtfJOB04ZfulrKjchBQ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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

On 2026-09-23 17:28, Mukul Joshi wrote:
> An imported dma-buf BO backed by a VRAM-capable exporter holds no host
> pages of its own, yet when validated into TTM_PL_TT it is charged against
> the GTT page budget; importing many such buffers can exhaust that budget
> and fail with -ENOMEM even though no host memory is used. Set
> AMDGPU_GEM_CREATE_PREEMPTIBLE on these imports so they land in the PREEMPT
> domain instead, which is GTT-like and still bound (keeping the exporter
> resident) but carries no host-page limit.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 4031ebe075d8..5bac2474af03 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -472,6 +472,15 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
>   					 AMDGPU_GEM_CREATE_COHERENT |
>   					 AMDGPU_GEM_CREATE_EXT_COHERENT |
>   					 AMDGPU_GEM_CREATE_UNCACHED);
> +
> +		/*
> +		 * A VRAM-capable import is backed by the exporter's device
> +		 * memory, not host pages of its own. Place it in the PREEMPT
> +		 * domain (GTT-like, but with no host-page budget) so many such
> +		 * imports cannot exhaust the GTT limit.
> +		 */
> +		if (other->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)
> +			flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
>   	}
>   
>   	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
