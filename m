Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D62C531D0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 21:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4476B10E744;
	Mon, 27 Jul 2026 21:49:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ky/QF7v+";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11BD910E744
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 21:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQl6qs/odJ8B5/e2iJhHWjAr4BM9G0tgftuScujnRmrKYuhAjdHqwIW3hSzuArwpbytOQ+DjmE29AieYjahOz/3ncCzoUw94qAbJG4hUTv3SVaBtm2lh97JI068UDK9FvkHzvzHDKYcCPwQynEq83LtxNsIvBpuAdc9ngkLx33ase1Ny5trJd4tWDHZQVyDNoMZCYy3eOjjPeKNmQE98r3/3gwnzg9C9Xc0AHP0YfY6HK1uW2rUHLW73UXwvaGvuO1+YwE6gc+mogIur66DWzg/xa1ma2phLAuHLn2J2aeRjWGQq2l2D3AYpOZmRY/4gkNE1qxcbKPiHkp5qZ6CXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6s5cfLvCSIOUIEL5h7FJlUjw1YNw36RqfQboH5gf/8=;
 b=VnaqCbSQhzUcHNI54kK6RSDP4cAjJpTAdd55HTDWsQknquiwx/MERyLBdxBDljjocV1nAM75yCj7/G/r33PNi346FNEWTVri9NuN596uMcwSgtwyVs5euqgTdVYg/gNoBt7izJcYF2W0tAdoYaKacepPsQO8KIEZBCFQKf636wtS+NfXkwkfbI62PWaLjQ2z3NTte6e9WPeVN8f0HGWfO3AzX0ebGLu8QjJ5AOLRuWPr1VMu6PMdubF+Y/Irr+jHTSSRbfRHMUi8WYq8kWw4VlN+P8cLvFPhd5ap0FKRq+23L/N3inIEdgkExuKiJAfjbnoU3TFnzCNBZg/6d33zEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6s5cfLvCSIOUIEL5h7FJlUjw1YNw36RqfQboH5gf/8=;
 b=Ky/QF7v+LYG+nokcYm49VRVBNYtGi1Y1e5ogI1tpj3UcYA7Oz4MBRuGJje3vTi4pzCSIdOCESJHjmdU7ncoD/YBAacCeMVx40JTk9UWvZY1DxYdX5sY2GDIRiq5KMr5hk9gabvs7RS9/htYpsFl7oFK1aWKaZ7HhvcGOXU0AQ1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by LV8PR12MB9135.namprd12.prod.outlook.com
 (2603:10b6:408:18c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 21:49:42 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542%4]) with mapi id 15.21.0223.017; Mon, 27 Jul 2026
 21:49:42 +0000
Message-ID: <422f298a-8ad6-4dad-a8a6-653e8640306f@amd.com>
Date: Mon, 27 Jul 2026 17:49:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdkfd: Unmap svm range from GPU set to
 no-access
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Amir.Shetaia@amd.com, Kent.Russell@amd.com
References: <20260727193930.612490-1-Philip.Yang@amd.com>
 <20260727193930.612490-3-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260727193930.612490-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0326.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::14) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e96f6cd-5559-431e-d5a3-08deec28f70b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: 8OycSZZdbeTuvoXytgNaABMdBeLx7VK10ykJU+wOJyJ0HrmN602lqwZThoQzMsriTrOYN6HZoWB3jGzfEgXp8gcDdZQOWz4yDdjgsdMrUHxtL1RB53XfkkPIapItnpCY4dki3WHmSUntvyZvtWbX7P5+9khJ5JDOuQJB7E4BrbWH4+Y0ENBVkT09a9bQSfvdBZMtbHkxktFe4jCPW9KHIr3DwXTWx0ouGqZNE9F2OSNGVkEJAZpXbvjsevs0uG47N5uNRdEDBhU96uffpeFuD7bs4Za7x41Jf/YEkV6bE/EwTR0/h/i/I7MvQlVvpTJd/TY71PFHSQSwIMV2kszptnHSS+b2he5XPasZgPYN6zpVc9nCmlMfF1T0ZFpT1ELK6q/Iu4HBepVGyWvhYbAjmDpPdYj/IT3F8EScEX7M+m/OdVgXOAd5SwtLaZXMbdjV95QUZixAU6mGsJHZ1plq07vi6C+oCyX8IlXJ3r07PvMwlu1IANi3zKtIIhtCSVrrh44tJAx4OXkh3A7Zol9XbVTvjKsU8GZBhKzR5sgy0xTMMl0oc1mvW9jalubipAHSTNmQoFwOT0Fcx/rm2Kh2VUstmY0aYu961yKevaYJXR6XF8VAORNTHOZ6TsvLy5AdlTChYP/okXPX3rHhgimJD1By8iP8crDE+6+9ahQPcOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVBDbFFWQktZVkJYVVNJbW4zWmdsVDNTRzgyaGhYM0dKK1kxbFA4bk14Qzc2?=
 =?utf-8?B?dEMxZWV4TmwyWTJCZzdDcStWSHo1YzZhOGRvZzB5TFJmei9zc2RqTFZZZ0Jy?=
 =?utf-8?B?L1BoWnF0Um85VDFrRjIwaTNNRmtlY3NwVEVzeTljZEtMZ2RSbWN6ZDBtQWFl?=
 =?utf-8?B?RDlGeGdTeFltYWFrV1ZLL0lPNlJ3ekZsTXVIUzlMdHF4cnYrTFpiMTZkalVk?=
 =?utf-8?B?TVpnWFMwclJpSlpXRE9qWStrYURpUy85OHJ1dytpaVhrVGFicUxwRk01Q0o2?=
 =?utf-8?B?ci9kQzc2MTRZNlJIN0ZuRWZaZFdZVnZBamlaNi9XS1g2R3l1Skc1OU00Qzdn?=
 =?utf-8?B?YmRFOUJEZkhqcm04cEJoNTV4RmNTTDJaWXphWlR6VEcwZ1Ezb0s3bi9aaS96?=
 =?utf-8?B?dlpzZi8rN0piYW50MGZHTXcxbjlIU1hOYkpEcjdPSUJFOWFsSnFlakZaNmJj?=
 =?utf-8?B?SFVpaE9YTnpCOVJDaXFPTlhPcndCUVVKYU5VMEhQOS9yL0s4ZzFtRTlreXV6?=
 =?utf-8?B?TmpXMEtzZzAzYUYvM25iMFhEb0VQWmxoazFCbmM5bVNzMWI3Z1h0N3JBT1lH?=
 =?utf-8?B?V04vKytOY3ZkV1VTSUNGZk1LQ3crcUhOK0toT01UNEZaQlZkd25EejRnTUVK?=
 =?utf-8?B?QXNjand6N0UxdTVtendJVnl6RnpPYVhwdXVqSUVWMnlqd2xXVHdUQjRJVXJG?=
 =?utf-8?B?UlFJaEZuMnd2MjBxT2o4VVcrTjVaOEZlTGhlTi9pMm1ER1RmN2ludEwzT1du?=
 =?utf-8?B?dGhFTEtEbU9wMHVoOUd6bEdYdVI1OThSVzl3WmNiU3VsZjR3TkF2ajk5VDZQ?=
 =?utf-8?B?UDJpaTU5cEZ1M1MweGE3bWwyNWw1c2NncmpndjlkMWlHOGd2R3NhL0VjSUFj?=
 =?utf-8?B?cmxqaVBLS1RjQU1ZRHVYWHJsczdQU3M2VDZMR2k4cmRnSmVHSERJTHVnQWpJ?=
 =?utf-8?B?VkxTY2RWY3JJNUhtUmhlOEFOd1pmODJWTTVXODY3Zko5YW9XRUV2VVkzR2Er?=
 =?utf-8?B?VENxbzFBT083S2t3SzQxZHZkZDRJR1UwTCtXcGUwMXVpRDRxN2NudXJyOTJ4?=
 =?utf-8?B?UlVOTUFLbEFzYjVScmhuT0tkOTlJQ3QySGFMY00rUXk3UGoxS0VSZ21PMVkw?=
 =?utf-8?B?Tm1EOC8wbnR1U3h1UG9HcytMV0I1Tk82bnpRTmtlU1lONG44Sjl2azFPYkFw?=
 =?utf-8?B?YWJySi9DVzRhYWQ1MUk3aGtrV0U2NU1ybnpqc0VPK0dyc1RGektHbjlHWkFU?=
 =?utf-8?B?RklTeUtabjNScmtFbndpTFAraExBMVR4Y1A4VDU4QUFNME5wN0hnZ0dDeGlJ?=
 =?utf-8?B?M1FVZDZQcGxseE52aFVLWXBrVkRpZUN4UEs3cHEzZjZ4VllXa3VMWGIvS3lP?=
 =?utf-8?B?MzA5a3ErRW5EdERXcHJ1cFV4VzF5NmhQNklSenRyMVl2Zlp3YlBuQTFYWkZH?=
 =?utf-8?B?WktKejRpcEtvMnJ2bmZVSjRSL2MzZlFlMlJvMFpRQlNJRncyemdkVUtxcG1w?=
 =?utf-8?B?Z0ZSMkJzRjUyVm5HS21jczR0SWN4VEFVUHdYTjcvS1c2TVJTLzFFUk1LOXEz?=
 =?utf-8?B?VUdLR0JINUtCVnQ1S0RzSnNhaW1RTUVFa2g3eEFiclpYY1dEZVZpd2VFRUV5?=
 =?utf-8?B?SXBudy9WT2JxRHQxVWY3RHZ0bU4rUW9ZN2ZzZ3ZwVVhVZHI1ci8waElVV1lC?=
 =?utf-8?B?RDRSR0NUM1NEVWV2ZmZKMTdWTE4vTHJCaWJ4YUNZNHBpemhlclZ4ZUdrcDE0?=
 =?utf-8?B?SkRqSTM5ZHRNcFZhTjBKdTBRUitFcEZqd0xucVpYcCtFT1IrOGhlMHdTb29x?=
 =?utf-8?B?R2tnYTFNTDNjajhGUlJ6cCtueCtFOGpPL2VNY1JtUWVaTWFZVUNwaVpxMDFv?=
 =?utf-8?B?MVdNTGhnV0pwUlBlSFFpREQvVTc2SDd3ZEc3OGVranBUbmNJV1A1UzM3V1RF?=
 =?utf-8?B?aHdhdEpsVEQranZXM3FieEw1eXNqdWFaRzJ3OFVmRDRsclcxWGg2eTN2aVFN?=
 =?utf-8?B?NzZlWEc2VVRYdGU2ZThsaG1JS1cvYlhEM0Y2TTJHZERENUJDUHY5MUkxRDZR?=
 =?utf-8?B?eWZwODM1TTR2bVVsRGpWVHBReHNnOW5QZTY4Vll3dWJCYVVvOVZYZG1ieGQ5?=
 =?utf-8?B?T2hTS1NmV0thR3NaM0VTOUl5by84Z3U0UHVUcDFjZ0tya1U4MW1zRUNVb2VO?=
 =?utf-8?B?T1dFVE1wcnJuTXlDM2dBTjFOTlJRRnUralZTSXhXYjZ3RWhBcU1FUnVWRWxZ?=
 =?utf-8?B?YS9vWEtrdHB6SzI0UGNBK2E4ODNLa1dWVElDR2JoMFBTUDkrd1RsRnk5WTlW?=
 =?utf-8?B?bjVIVUlTWGxuaVV1Y3JLUENMZmxYSVFHajV5cjIrcHMzaE14TitiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e96f6cd-5559-431e-d5a3-08deec28f70b
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 21:49:42.1919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGxW8jDEhsht7NTgLTlmkfcjmCPx30nsDEf+WVBY3hxNq2hHhwcgxlx2kYyAZKH9nQpM/5dEx/Wt2d3CegONVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135
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

On 2026-07-27 15:39, Philip Yang wrote:
> When KFD_IOCTL_SVM_ATTR_NO_ACCESS is applied to a GPU that has an SVM
> range mapped, unmap the range from that GPU. Once no GPU maps the range,
> the MMU notifier can skip queue eviction on CPU page faults.
>
> Replace the mapped_to_gpu boolean with bitmap_mapped to track which
> GPUs currently have the range mapped. Set bits in svm_range_map_to_gpus()
> and clear them in svm_range_unmap_from_gpus(). This is separate from
> bitmap_access/bitmap_aip which track user-requested attributes and must
> not be used to determine mapping state.
>
> Add bitmap_needs_unmap to svm_range, set for each GPU given no-access.
> Add svm_range_needs_unmap() to unmap the range from those GPUs when the
> app sets the no-access attribute.
>
> Bump the checkpoint timestamp on unmap so retry faults queued before the
> no-access unmap are dropped instead of restoring the mapping.
>
> v4:
>   - Rename and set prange->mapping_done to false if validate and map not
>     complete successfully (Felix)
> v3:
>   - Correct error handling, support app retry update mapping (Felix)
> v2:
>   - Add bitmap_mapped to not break get_attr (Felix)
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c |   5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 107 ++++++++++++++++---------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   7 +-
>   3 files changed, 77 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index b249e7d1af48..25954c2c2d91 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -112,12 +112,11 @@ static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u6
>   		if (!prange)
>   			break;
>   
> -		if (!prange->mapped_to_gpu)
> -			break;
> -
>   		r = kfd_process_gpuid_from_node(p, pdd->dev, &gpuid, &gpuidx);
>   		if (r < 0)
>   			break;
> +		if (!test_bit(gpuidx, prange->bitmap_mapped))
> +			break;
>   		if (!test_bit(gpuidx, prange->bitmap_access) &&
>   		    !test_bit(gpuidx, prange->bitmap_aip))
>   			break;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index c10d4edc8813..1a01d089b132 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -826,8 +826,13 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>   			gpuidx = kfd_process_gpuidx_from_gpuid(p,
>   							       attrs[i].value);
>   			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
> +				svm_range_update_checkpoint_timestamp(p);

In the last version I suggested moving this into svm_range_needs_unmap 
so we only update the checkpoint (and drop interrupts) when anything is 
actually unmapped (after the bitmap_empty check for bitmap_needs_unmap). 
Did that not work for some reason?

Regards,
   Felix


> +
>   				bitmap_clear(prange->bitmap_access, gpuidx, 1);
>   				bitmap_clear(prange->bitmap_aip, gpuidx, 1);
> +
> +				if (test_bit(gpuidx, prange->bitmap_mapped))
> +					bitmap_set(prange->bitmap_needs_unmap, gpuidx, 1);
>   			} else if (attrs[i].type == KFD_IOCTL_SVM_ATTR_ACCESS) {
>   				bitmap_set(prange->bitmap_access, gpuidx, 1);
>   				bitmap_clear(prange->bitmap_aip, gpuidx, 1);
> @@ -1118,9 +1123,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>   	new->prefetch_loc = old->prefetch_loc;
>   	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
> -	new->mapped_to_gpu = old->mapped_to_gpu;
> +	new->mapping_done = old->mapping_done;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
> +	bitmap_copy(new->bitmap_mapped, old->bitmap_mapped, MAX_GPU_INSTANCE);
>   	atomic_set(&new->queue_refcount, atomic_read(&old->queue_refcount));
>   
>   	return 0;
> @@ -1421,7 +1427,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   static int
>   svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
> -			  unsigned long last, uint32_t trigger)
> +			  unsigned long last, unsigned long *bitmap_unmap,
> +			  uint32_t trigger)
>   {
>   	struct kfd_process_device *pdd;
>   	struct dma_fence *fence = NULL;
> @@ -1429,21 +1436,15 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   	uint32_t gpuidx;
>   	int r = 0;
>   
> -	if (!prange->mapped_to_gpu) {
> -		pr_debug("prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n",
> -			 prange, prange->start, prange->last);
> -		return 0;
> -	}
> -
> -	if (prange->start == start && prange->last == last) {
> -		pr_debug("unmap svms 0x%p prange 0x%p\n", prange->svms, prange);
> -		prange->mapped_to_gpu = false;
> -	}
> -
>   	p = container_of(prange->svms, struct kfd_process, svms);
>   
> -	for_each_or_bit(gpuidx, prange->bitmap_access, prange->bitmap_aip, MAX_GPU_INSTANCE) {
> -		pr_debug("unmap from gpu idx 0x%x\n", gpuidx);
> +	for_each_set_bit(gpuidx, bitmap_unmap, MAX_GPU_INSTANCE) {
> +		if (prange->start == start && prange->last == last) {
> +			pr_debug("unmap svms 0x%p prange 0x%p from gpu_idx 0x%x\n",
> +				 prange->svms, prange, gpuidx);
> +			clear_bit(gpuidx, prange->bitmap_mapped);
> +		}
> +
>   		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
>   		if (!pdd) {
>   			pr_debug("failed to find device idx %d\n", gpuidx);
> @@ -1596,6 +1597,8 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   			continue;
>   		}
>   
> +		set_bit(gpuidx, prange->bitmap_mapped);
> +
>   		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
>   					 prange->dma_addr[gpuidx],
>   					 bo_adev, wait ? &fence : NULL,
> @@ -1741,7 +1744,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		bitmap_zero(ctx->bitmap, MAX_GPU_INSTANCE);
>   		bitmap_set(ctx->bitmap, gpuidx, 1);
>   	} else if (ctx->process->xnack_enabled) {
> -		bitmap_copy(ctx->bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
> +		/* Update mapping on already mapped or access in place GPU */
> +		bitmap_or(ctx->bitmap, prange->bitmap_mapped, prange->bitmap_aip,
> +			  MAX_GPU_INSTANCE);
>   
>   		/* If prefetch range to GPU, or GPU retry fault migrate range to
>   		 * GPU, which has ACCESS attribute to the range, create mapping
> @@ -1761,14 +1766,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		}
>   
>   		/*
> -		 * If prange is already mapped or with always mapped flag,
> -		 * update mapping on GPUs with ACCESS attribute
> +		 * If prange with always mapped flag, update mapping on GPUs with
> +		 * ACCESS attribute
>   		 */
> -		if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
> -			if (prange->mapped_to_gpu ||
> -			    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
> -				bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
> -		}
> +		if (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
> +			bitmap_or(ctx->bitmap, ctx->bitmap, prange->bitmap_access,
> +				  MAX_GPU_INSTANCE);
>   	} else {
>   		bitmap_or(ctx->bitmap, prange->bitmap_access,
>   			  prange->bitmap_aip, MAX_GPU_INSTANCE);
> @@ -1834,6 +1837,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   				e = min(end, prange->last);
>   				if (e >= s)
>   					r = svm_range_unmap_from_gpus(prange, s, e,
> +						       prange->bitmap_mapped,
>   						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>   				svm_range_unlock(prange);
>   				/* If unmap returns non-zero, we'll bail on the next for loop
> @@ -1896,7 +1900,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		}
>   
>   		if (!r && next == end)
> -			prange->mapped_to_gpu = true;
> +			prange->mapping_done = true;
> +		else
> +			prange->mapping_done = false;
>   
>   		svm_range_unlock(prange);
>   
> @@ -2066,10 +2072,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   	if (!p->xnack_enabled ||
>   	    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
>   		int evicted_ranges;
> -		bool mapped = prange->mapped_to_gpu;
> +		bool mapped = !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
>   
>   		list_for_each_entry(pchild, &prange->child_list, child_list) {
> -			if (!pchild->mapped_to_gpu)
> +			if (bitmap_empty(pchild->bitmap_mapped, MAX_GPU_INSTANCE))
>   				continue;
>   			mapped = true;
>   			mutex_lock_nested(&pchild->lock, 1);
> @@ -2118,13 +2124,14 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   			s = max(start, pchild->start);
>   			l = min(last, pchild->last);
>   			if (l >= s)
> -				svm_range_unmap_from_gpus(pchild, s, l, trigger);
> +				svm_range_unmap_from_gpus(pchild, s, l, prange->bitmap_mapped,
> +							  trigger);
>   			mutex_unlock(&pchild->lock);
>   		}
>   		s = max(start, prange->start);
>   		l = min(last, prange->last);
>   		if (l >= s)
> -			svm_range_unmap_from_gpus(prange, s, l, trigger);
> +			svm_range_unmap_from_gpus(prange, s, l, prange->bitmap_mapped, trigger);
>   	}
>   
>   	return r;
> @@ -2154,10 +2161,11 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   	new->prefetch_loc = old->prefetch_loc;
>   	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
> -	new->mapped_to_gpu = old->mapped_to_gpu;
> +	new->mapping_done = old->mapping_done;
>   	new->vram_pages = old->vram_pages;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
> +	bitmap_copy(new->bitmap_mapped, old->bitmap_mapped, MAX_GPU_INSTANCE);
>   	atomic_set(&new->queue_refcount, atomic_read(&old->queue_refcount));
>   
>   	return new;
> @@ -2277,7 +2285,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   		next_start = min(node->last, last) + 1;
>   
>   		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
> -		    prange->mapped_to_gpu) {
> +		    prange->mapping_done) {
>   			/* nothing to do */
>   		} else if (node->start < start || node->last > last) {
>   			/* node intersects the update range and its attributes
> @@ -2626,14 +2634,14 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   		s = max(start, pchild->start);
>   		l = min(last, pchild->last);
>   		if (l >= s)
> -			svm_range_unmap_from_gpus(pchild, s, l, trigger);
> +			svm_range_unmap_from_gpus(pchild, s, l, prange->bitmap_mapped, trigger);
>   		svm_range_unmap_split(prange, pchild, start, last);
>   		mutex_unlock(&pchild->lock);
>   	}
>   	s = max(start, prange->start);
>   	l = min(last, prange->last);
>   	if (l >= s)
> -		svm_range_unmap_from_gpus(prange, s, l, trigger);
> +		svm_range_unmap_from_gpus(prange, s, l, prange->bitmap_mapped, trigger);
>   	svm_range_unmap_split(prange, prange, start, last);
>   
>   	if (unmap_parent)
> @@ -3723,6 +3731,23 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   	svm_range_bo_unref(svm_bo);
>   }
>   
> +static bool svm_range_needs_unmap(struct kfd_process *p, struct svm_range *prange)
> +{
> +	if (bitmap_empty(prange->bitmap_needs_unmap, MAX_GPU_INSTANCE))
> +		return false;
> +
> +	pr_debug("prange 0x%p no access set for [0x%lx 0x%lx]\n",
> +		 prange, prange->start, prange->last);
> +
> +	svm_range_unmap_from_gpus(prange, prange->start,
> +				  prange->last, prange->bitmap_needs_unmap,
> +				  KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
> +
> +	bitmap_clear(prange->bitmap_needs_unmap, 0, MAX_GPU_INSTANCE);
> +
> +	return bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
> +}
> +
>   static int
>   svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   		   uint64_t start, uint64_t size, uint32_t nattr,
> @@ -3778,10 +3803,10 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   		svm_range_add_to_svms(prange);
>   		svm_range_add_notifier_locked(mm, prange);
>   	}
> -	list_for_each_entry(prange, &update_list, update_list) {
> +
> +	list_for_each_entry(prange, &update_list, update_list)
>   		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
> -		/* TODO: unmap ranges from GPU that lost access */
> -	}
> +
>   	update_mapping |= !p->xnack_enabled && !list_empty(&remap_list);
>   
>   	list_for_each_entry_safe(prange, next, &remove_list, update_list) {
> @@ -3802,6 +3827,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	list_for_each_entry(prange, &update_list, update_list) {
>   		bool migrated;
>   
> +		if (svm_range_needs_unmap(p, prange))
> +			continue;
> +
>   		mutex_lock(&prange->migrate_mutex);
>   
>   		r = svm_range_trigger_migration(mm, prange, &migrated);
> @@ -3810,7 +3838,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   
>   		if (migrated && (!p->xnack_enabled ||
>   		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
> -		    prange->mapped_to_gpu) {
> +		    !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE)) {
>   			pr_debug("restore_work will update mappings of GPUs\n");
>   			mutex_unlock(&prange->migrate_mutex);
>   			continue;
> @@ -3821,7 +3849,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   			continue;
>   		}
>   
> -		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
> +		flush_tlb = !migrated && update_mapping &&
> +			    !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
>   
>   		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
>   					       MAX_GPU_INSTANCE, true, true, flush_tlb);
> @@ -3835,11 +3864,13 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	}
>   
>   	list_for_each_entry(prange, &remap_list, update_list) {
> +		flush_tlb = !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
> +
>   		pr_debug("Remapping prange 0x%p [0x%lx 0x%lx]\n",
>   			 prange, prange->start, prange->last);
>   		mutex_lock(&prange->migrate_mutex);
>   		r = svm_range_validate_and_map(mm,  prange->start, prange->last, prange,
> -					       MAX_GPU_INSTANCE, true, true, prange->mapped_to_gpu);
> +					       MAX_GPU_INSTANCE, true, true, flush_tlb);
>   		if (r)
>   			pr_debug("failed %d on remap svm range\n", r);
>   		mutex_unlock(&prange->migrate_mutex);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index a63dfc95b602..0da635532aff 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -100,6 +100,9 @@ struct svm_work_list_item {
>    * @child_list: list header for split ranges which are not added to svms yet
>    * @bitmap_access: index bitmap of GPUs which can access the range
>    * @bitmap_aip: index bitmap of GPUs which can access the range in place
> + * @bitmap_needs_unmap: index bitmap of GPUs which currently set NO_ACCESS
> + * @bitmap_mapped: index bitmap of GPUs which currently have the range mapped
> + * @mapping_done: true if range_validate_and_map complete successfully
>    *
>    * Data structure for virtual memory range shared by CPU and GPUs, it can be
>    * allocated from system memory ram or device vram, and migrate from ram to vram
> @@ -135,7 +138,9 @@ struct svm_range {
>   	struct list_head		child_list;
>   	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
>   	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
> -	bool				mapped_to_gpu;
> +	DECLARE_BITMAP(bitmap_needs_unmap, MAX_GPU_INSTANCE);
> +	DECLARE_BITMAP(bitmap_mapped, MAX_GPU_INSTANCE);
> +	bool				mapping_done;
>   	atomic_t			queue_refcount;
>   };
>   
