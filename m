Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA3606A32D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=d/DnIZkT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF61010E0B8;
	Fri, 13 Nov 2026 22:18:50 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA6A10E0B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 22:18:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mV6sY313xGlRxYwfWesi7XS78V4VHuaPD9rk1vY4hGrMq/BLgGXke0DdFA0Gxfcc6eIvoG0OrWD6PeYh3P3Zp4v6/aYHRf9HZOAf1vYwAU7UhgQDF7BFYPwKoZfHuCTdzCZyuGzJlQ6FXl61EQkEq6VVz3INvTurRgkrFDAX/BlKPRi1fY2R/5YRvy6ExKPy08XnGZf7CBU1UgEOMEu4h53UzF1J/S1DMgqqFmdw6cS3K/HoQ0HZWXP2rKyxIcXP+Qs12H1YqWjoI0w9xhjhaJnjP0XuBu9B9wbNb12ArWfYBg/OetRdjsF3VYrnIvkdEj5WycA+z0PEWdfe6rTp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sV/YWOKQKSa6jvfDouayOAXebzTbHLIzfGwSXCQ4cC8=;
 b=AU8pVoYWxIN3KgAIYD104mtuqe5UTd5t5RzmVcNsA+293gv/kNCR58QruUVq+aBw5wdZdroTDov6y2GK6XhcBanebgIH9FUxO+2U2QdSqoe6FGW/k9Ql7NzzFAeCX8FoMul2pNCd7fSZ1/G8NQEu5QtukDGfmgHUCPBdQYiDfhNiUrexPn8FUn9oBpXRwToKdHnzw8zHeh6yokAiUeof8FXkX1EAmWrTPEnVP89t/IIRGVGeDveZRQnBsTgrcBfgke90LgQnfLpi/N3KHDGOB8TwjnyTZ5EjX/cugLsDszxttWKpaLf+qxrl07RgkZPnCVCYE4Jv6R2Arvokb9QF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sV/YWOKQKSa6jvfDouayOAXebzTbHLIzfGwSXCQ4cC8=;
 b=d/DnIZkTwcfWTGjxyYTC18SUx5QS5KDUozHdSpOfRn4MnUDUn78CCoYGyEUzVEQNZF3wyq337dcB2XSeVsX9OmIpkeOsFLqq8X12pnHso/9MX3jjVQ08LXNcpIAUASStvCJ1Ykxvpcked3KPwb1HkJJ0t+UGbakxribYJ4EB4lY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) by LV3PR12MB9216.namprd12.prod.outlook.com
 (2603:10b6:408:1a5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Fri, 13 Nov
 2026 22:18:41 +0000
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::fd82:d106:2d09:2dcc]) by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::fd82:d106:2d09:2dcc%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 22:18:41 +0000
Message-ID: <f0fd0411-1fc8-4751-93c9-6a72df816989@amd.com>
Date: Fri, 13 Nov 2026 17:18:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: keep the DMA addresses of a range intact
 if splitting fails
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20261110074407.3360908-1-Jesse.Zhang@amd.com>
 <20261110074407.3360908-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261110074407.3360908-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0328.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::18) To SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF8ECEC29A9:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee7cc18-0eab-47e5-9806-08df41d4124b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|261102123227099003|56012099006|261028144727099003|11063799006|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261021123027099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: fcRpxToVON255ySCBVfbhF5T6ndZl9Zr0xw3NvPkywZwbPy8MbjbsRZsuMmLOhPj3oOQjd/BLcJR+dDq8eJqz4hSOS94qpegSffDPt0T1yqvxpSMc2fBFx8ZlSsIIHHSrs4eNHfwF7vmNAw8k/3vFJmXpe2MzSeVNNLKr6sDszJKWn1g3zWNC3mbFeMpz2bm1jueFa2QkzeNVetYg5LM0T71rXz7e0ii3/yXX4cmi/1N1LZD6BuCqC3Fiu/pbhZIIbgUGrhVZx71HvDyfqLIrL4MmiOnUIARjgmL80PfwmhOXaOcnOowr00SoZSvmZysOQlemuTZfTKZop17UqdtXSp/Pu4nmqX+OB3yBH84hsIymCN2g4MqMCV1UEL3zA+9+FXlnvB4xBxv+BUsE7Zlpj23NyWaW7C5O+Eeq02RLscYerVorsE3gtDaTIpCEjFc2bWmxKmMz0q9xEeZi8It+Vkj+jDX/5VnYHKuI/JsBBc+efXSZ7uRgs8ogy6vYp1QYXRExiDBDYTyAFPoEj84yBau8V/457ibM+Dzo5/ilt9aWMNM/TNQyhXtQq3u8aauS2p8jrJSAX1BvzQU0v/riFvwYH7n3E6yhe0iaLw3yCQYE2A6iePsc0bm/MNTYWGcIa23VJi1Q2+BkYwV5ssBmhIf50fJ8QjsMP9VsRAEzYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA5PPF8ECEC29A9.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(261102123227099003)(56012099006)(261028144727099003)(11063799006)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261021123027099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE9tYndKZ0dhN0pWS0RmUXJBa3NnMnB5YzY3YlhyOC9NTTE2UDIrWjh5Mndh?=
 =?utf-8?B?S3ZSY0lPQzN0NW1TK0M3Z1pDWHVZc2FFS3REdFRkL3ptS2JydUZUTnhIM3VM?=
 =?utf-8?B?d1ZPL1YzWEtXbWgrVDllSWFSYmxPYWV2SWNaSVVVUDVFc2FzU25NcnpRVXRw?=
 =?utf-8?B?UEZoYlErMm9xWTBFZGtKUS9DQVBvV0FxbVVVNzFORWpJdzkxejczWkJkWnRi?=
 =?utf-8?B?Sm1nMitLS3ZwRlRIL1VnOUljam9jTnJLdHNWUGlldmN2NDZBdG1xMGFNc1l2?=
 =?utf-8?B?REZjU1FVYS9CSWJPYi85dEtkU3cwSlpDeWp4S1diS0FaeUsxQTkyc0dZd0lp?=
 =?utf-8?B?QXRBQ2ducnNYSWd2N3RIUXRyYzBNdytTdnNlV1AwUnZRNUM4L2xTTjh4d01w?=
 =?utf-8?B?QkQxUzhSUThUR1BQZVRYVmRLU2locTBFNkY4bUNEblc2SlRsZGt5MmFDcVdX?=
 =?utf-8?B?MlZsRDhuZ3FERUR0UDhyL09uVGNGcUNNcFRaODBqUTNtWGsrVWozdXBKREY2?=
 =?utf-8?B?OFd3NUIzYlY3eGZPWjZXZFVjaFVRdGVvVm1maHhHWVBOT0syRlVXd01EclBP?=
 =?utf-8?B?R2lvdzg4Y08xSWZaU1h5RkMzTlNscTlHTjBKdVNDcVNMYzlsdXhtLzkzck41?=
 =?utf-8?B?Y1M3MlFGUlJtSWowNnZSVWtBelhMb3pXbm1UY3h1bnpuVlMrUUkxWVpza0Js?=
 =?utf-8?B?VVdPKzNuUGxjTk5JKzNsZWJOd1Y3bnpIUTJqTWVsQnh6MFpPNnpycGYrbTN5?=
 =?utf-8?B?cDJTVk9JL3BraDgxSFFHZlBYNk5jdDhJVit0eVo1cTA1N3NGV1NtS1NWTmpV?=
 =?utf-8?B?OW1HNmdsR2M4ZkxlbXlvNlhiZVNwRXRuOUM0VmkzMVo4bDl3UzRWMVg2aHFt?=
 =?utf-8?B?NFNnelkvZiswamh1aWNNT3graTQxNjREUzFBMGY5L1FhZVZCdFErYlY0Z1hn?=
 =?utf-8?B?eklsN3hwUkduR0g0QmFWSVd2ckpxZmZZajZBS3lReU9jbm8yUnBnejc3czZz?=
 =?utf-8?B?dE5qdzFjSmNtOHExbmxiMjdza2tPZ05FSlJNc3BlTnNRVzFjclBjTzAwbTRz?=
 =?utf-8?B?bWdLTW45VmFoL3JJQTlQNzJkaCtGbEM3Wi9pSGd4dG4zTjBod0xmTW9aTFBB?=
 =?utf-8?B?eUVZclBNaUZqbmFwamc3SUZTSnBUV0lNaWROVS9IcWxhOXVucFE4QURJYkRI?=
 =?utf-8?B?VUJVUGRZOVhYVW94eEM3a1hOT2N4TS83RmZscVo5MEE4ZkxYa0hTTElRK1hv?=
 =?utf-8?B?eWVxanh1blZQSVV4T2pReHZGUk9VYlRXSFZZMm9sTE5JVktPMDdVUUwyRU9F?=
 =?utf-8?B?VTVNNExIdkw4R1B2RzUrUE9TZ01WQjhjaHNiTWpTN0VubVRJbnZ0MjFNZ3Iv?=
 =?utf-8?B?ZUUzcGJIUGNSYVFadisxQ2hRZTVkb29HdzFvMkhhSERxQUhieU9WV1pkTnVy?=
 =?utf-8?B?dzB2WElJY0tNVHlDNjZvWUszMTFrVDJaRSswRER0WDZyS25WZlVyMzExbHpN?=
 =?utf-8?B?cU5YeHAvV3l5b3Jyc25RRUllQjBvaUxzcUtxNzI4UTRLKzdNTkxSbkh2dDNC?=
 =?utf-8?B?SGdESzV5dlZ2Um1tbm1WeGljL3B5aURzTW9nb0VsdGxUaTBqRDBXMlNIei9O?=
 =?utf-8?B?QndzWTR4emtkamk0R0xZOFJUMUFtdFF5a2llNHQ1ZEpPZWdFS28rVk91OTBn?=
 =?utf-8?B?b1YvWWUxeFl5NVBXanhXMUxFcm0vczN4STZFTXE4WmRaRmNOandJVTJXZzdH?=
 =?utf-8?B?WkdQb21vMWZmczN1TTBjQy9lMWlzZUpiWEVaZ2htbTJMZk9DL0poeWx5Rytk?=
 =?utf-8?B?dUdSMUdkL0FJSlRPMkVoVzlka212UVl5a1lRaEFTb3NJY2dFUlM0NnlPb1hr?=
 =?utf-8?B?QWdtTEQ4Z2J4ZlAxMGtMYjR0NzZSSVM0Uk50Wm5lNTlaTlQ4OUNSNExNRDFv?=
 =?utf-8?B?QTNrajhiVEYwNGFtaUdOMFY1alF2VWtWZjJLTUZweHBVUlNlVS9QNEV0bzN5?=
 =?utf-8?B?Z1FFSmR0KzlGVnVpRUlyNHZ4MjhVOHBEbUExOWVFODIzMG5meWVYRTRnR0JP?=
 =?utf-8?B?ZHlRTENLcnRHYmYzV0xEYS9BK2hTVzFJTzBFQkcwWEhLK2NhNkY2NXNkRDFQ?=
 =?utf-8?B?WFc1Nlo5d0tTUXozbVRlTEN5cjBVWk41WG1BSkh6QWhYSG91bjFXdzYxMTNr?=
 =?utf-8?B?Y0t0WGxFWXJRMkJqVXlINEc1dVlpVUJGWFdQK1NHeEZaM1E5QlJKK3VhdlZ0?=
 =?utf-8?B?WnV0TWtuR2tpUmo0b216R2NSL2hoQkI2TUY1NkphVm9VQ1doZEF3VlMvWUk0?=
 =?utf-8?B?czBpcUJkMDhkNHRDanNLc1h0OEhrQm5jMXVzYkpoOTZ2T1hvNkZhQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee7cc18-0eab-47e5-9806-08df41d4124b
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF8ECEC29A9.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 22:18:40.8435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbyWa/OfR/uTXVnf35M64MXXcBk08KU5YJHkWwUJ8Tud0ZHACquWfXxpIqrLija50QoCtzKDho2Nxl0VAaFIlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216
X-OriginatorOrg: amd.com
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-10 02:43, Jesse Zhang wrote:
> svm_range_split_pages() splits the DMA address array of one GPU after
> the other, and each split replaces the old range's array by a shorter
> one. If a later GPU's array can't be allocated, the old range is left
> with the arrays of the earlier GPUs already shortened, but with its old
> size. Unmapping it then walks past their end.
>
> On navi31 with its iGPU, an SVM range accessible by both GPUs, and
> unmapping a page in its middle with allocations failing in turn through
> failslab:
>
>    BUG: KASAN: slab-out-of-bounds in svm_range_dma_unmap_dev+0x13f/0x170 [amdgpu]
>    Read of size 8 at addr ffff88819ac32800 by task kworker/8:1/171
>     svm_range_dma_unmap_dev+0x13f/0x170 [amdgpu]
>     svm_range_dma_unmap+0x119/0x2c0 [amdgpu]
>     svm_range_free+0x312/0x520 [amdgpu]
>     svm_range_handle_list_op+0x326/0x500 [amdgpu]
>     svm_range_deferred_list_work+0x338/0x790 [amdgpu]
>    Allocated by task 2749:
>     svm_range_copy_array.constprop.0+0x55/0x190 [amdgpu]
>     svm_range_split+0x388/0x17b0 [amdgpu]
>     svm_range_unmap_split+0x254/0x370 [amdgpu]
>     svm_range_cpu_invalidate_pagetables+0xb29/0x11d0 [amdgpu]
>    The buggy address is located 0 bytes to the right of
>     allocated 2048-byte region [ffff88819ac32000, ffff88819ac32800)
>
> Split the arrays of all GPUs first and only replace the old ones once
> all succeeded. With that the 2759 unmaps of the same sweep give no
> report.
>
> Fixes: f80fe9d3c114 ("drm/amdkfd: map svm range to GPUs")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

The series is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 0879e37faa71..3dbf8002da76 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1008,7 +1008,7 @@ svm_range_split_array(void *ppnew, void *ppold, size_t size,
>   		kvfree(new);
>   		return -ENOMEM;
>   	}
> -	kvfree(pold);
> +	/* The caller frees pold once all arrays of the range are split */
>   	*(void **)ppold = old;
>   	*(void **)ppnew = new;
>   
> @@ -1019,19 +1019,36 @@ static int
>   svm_range_split_pages(struct svm_range *new, struct svm_range *old,
>   		      uint64_t start, uint64_t last)
>   {
> +	dma_addr_t *old_dma[MAX_GPU_INSTANCE];
>   	uint64_t npages = last - start + 1;
>   	bool has_dma_addr = false;
>   	int i, r;
>   
> +	/*
> +	 * Split the arrays of all GPUs before replacing any of them, the old
> +	 * range must stay intact if one fails.
> +	 */
>   	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
> +		old_dma[i] = old->dma_addr[i];
>   		if (old->dma_addr[i])
>   			has_dma_addr = true;
> -		r = svm_range_split_array(&new->dma_addr[i], &old->dma_addr[i],
> +		r = svm_range_split_array(&new->dma_addr[i], &old_dma[i],
>   					  sizeof(*old->dma_addr[i]), old->start,
>   					  npages, new->start, new->npages,
>   					  old->actual_loc ? &new->vram_pages : NULL);
> -		if (r)
> +		if (r) {
> +			/* new->dma_addr[] goes with the new range */
> +			while (i--)
> +				if (old_dma[i] != old->dma_addr[i])
> +					kvfree(old_dma[i]);
>   			return r;
> +		}
> +	}
> +	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
> +		if (old_dma[i] == old->dma_addr[i])
> +			continue;
> +		kvfree(old->dma_addr[i]);
> +		old->dma_addr[i] = old_dma[i];
>   	}
>   	if (old->actual_loc) {
>   		/*
