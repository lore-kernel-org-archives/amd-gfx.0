Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B59DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 02:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B937011291A;
	Tue, 18 Jan 2022 02:47:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2DE911291A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 02:47:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+eXW9wM6ZE+1aZVlkpLp1Gvm3P9OoEorcHkGKdnXl28KXNe8VS9EYojBw0eTwbYHnIe5LdrM9cYJXeUBwz8ojRF2oBrje67jrKcIXgUJlWD4ttwZMh715nTMtdn9dQvmVTtgYBNs0ay0ZVCR23jFlxc1ohRclrelclqjOy3wdoWAJhlr+DXMsoa/UOk0XoiCgIK7huwWD0pTLc+Kyoxo/uvXvtZsE8fL9aeJNgOX9AwebUZrtsPPF4r9eO2Uz34+sDjdsu1+8cMwLToD9zTmx7VnxD9gfEpsVsP84JGhhm3awQH3m1aMFWuLF1wHoD5lZ5BfnNjXuBYDmJwNcu54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UipXTUCzbL1ON9drWRrf2I111msvqlrWIXuOXV5IOG8=;
 b=GgPmKciy2oyBjtgHDiKb1jEDG0/CYOkMj/ZoqUj+zNl+yIggJQ0nxvY3mAwgYAJ8gxJqCKY35BaGpbhWUhBxjYWgEXXDKMZ4L2QK6g2PO6J8n7d+EOjOE839oQbc/Qcx8HJ7xNIeH6X2OIvMzmmGZDB4PFNL4b5X4DiyuTemHYt3ZwzpYfC6exBI0T0+1eV0ihOoS0h0bOLfinsLNhblkGs3jgRQH7fFOwQq1Cuq7vMULfyYr4hVkZJ579vstYqKkD2QgVxoey1ZH6VteTm4Hl2oU62LaSfvYGF6wAdjiFumM01ogbtEhoSPU/WCiT1sf4MdLY6dyjp591JHHPZlXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UipXTUCzbL1ON9drWRrf2I111msvqlrWIXuOXV5IOG8=;
 b=Qn9m4ZthnYTRG4Z774vzetMvBUf2QLneR9kzjOcSkzvEfyiRi+jO6OcLMFWmnJKYVS/kD6dEnj5TsGRdWYoZ3YNOiFveeR6phOwckxIFkLO87/pvj8Gj1LvbBcdZaAmpCB4tximkFRbV0s2V0MIwqe89uArabKiLdR6B+kio24k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MWHPR12MB1150.namprd12.prod.outlook.com (2603:10b6:300:f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 18 Jan
 2022 02:47:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 02:47:06 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: fix debug sdma vram access checks
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220117234347.3820493-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <da6cd219-5f86-f7f2-ceb3-1c86122b42e0@amd.com>
Date: Mon, 17 Jan 2022 21:47:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220117234347.3820493-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f3e78d1-6366-4dc8-07e6-08d9da2cd070
X-MS-TrafficTypeDiagnostic: MWHPR12MB1150:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB115058A4A7F0C10D23F1D1E892589@MWHPR12MB1150.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lv1gY5Aa3TTC54AKpGjDKrlm1u1AZ6Jgm6SsWgvZGudlf5/pt2t/yyQGN08O/MoXBnoiKHiCZbvvqIbrMKII5mn2D1NLoBC02sxmt+kyWUJmML31gU5jtAPkWRN/a2qL+iuIW6BRWrD1ZVues69ttj7oz7jKLQC+CuLP5kycThmuqSDWBarMAedQ3iMF0Cz5jvVMOfw4dW7XiMtiFASdWtYGAmCtEyxzCqOpMsn/errhmle/v/pTgRm00D2gyyZBc+nh6QfGPVQ9yExwRqYvEsmbdMm8Aj/HhB+tfw0AfzAXq+EJ8HHuDyTmn/AhxfTpo6RgGufo0335MBW5WdYF+jQVWdnQalltv3/GFWRBYLe2hyTzl948RTZROOu+laolqSb6Kj6Uxn9LHupmJKJlh4CRVPzl4G6PX+2DaXA/BDHRfQ5kNv5gEaXYWd1+bO8Bpn0BDzXlVo++SnUFee5byMVM6cMN8PzO5nAc2HO6cCHSEl3A//WKm1Gb1I2T+67mkj4t9BGDq7jUlacZZ21yE3gQe+OXLI0Ypt7lja/hgrVpL3NuA4eAteQE/X1KZ/lZjEuOR5qSXPdFgHslBM0A30vn7NucdNk7mO4JFDzVaCbv+iCnUegDxnYKUkH3eEQQZcKwy9HPPiV6ZnRNPed3gNdAlc1DyH45m4udDZVJosForQPYYFIPfogAFXS+ogZOpI8L0tfeek4s0PpVSYvYxq4C340hoG8YIuTIiLFjK3rfp4+aLz1PUB4kBJcPulMN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(31686004)(86362001)(44832011)(2616005)(6506007)(186003)(508600001)(66556008)(316002)(2906002)(36756003)(31696002)(6512007)(6486002)(83380400001)(26005)(38100700002)(66946007)(4326008)(8676002)(66476007)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3JBVHpEU1h4OXBmSDZVdWR4SlZHSDh0NEpwblVTS3ZYK3NJOGpZamN2QWNz?=
 =?utf-8?B?RTJVQWJjSmptbUVlYzdDL0ZPdm9LUU1KQUp6akw5SmQ1VlNwRmZMZnJzc1VZ?=
 =?utf-8?B?RWFLcG1TdHBZdW9HS1ZLTGpidzRrV0llaW5iY0FJbzNaU3BrdE5nNXljTkMx?=
 =?utf-8?B?NGNkU25rVkJ4empMVUlac1ZyTlFJQitubVpqS3k3K2NXQXM3U2Q2QWtzNHZN?=
 =?utf-8?B?Q1NzV2ZXMmljZnl0aUY0emUxQUxacFByMHFSbngyODlCNGU0SXkwSEswYXBS?=
 =?utf-8?B?RnZvR1c3cU90YjA5S3h2ZmdNZ1ZWaXo0NjE2TjFDb0p5U08xRFQ3aFRNQXE2?=
 =?utf-8?B?dDJiNEx2bWtXZlE0UzZkMG03OVk4QzJhaXh2T1JRVEFNaW1oRGNIbGljTzZD?=
 =?utf-8?B?ekd4bEN4L0dCRVV3TzA4WGpVVGFoVUFHZWxoZElLczhaUlhLWjVzWFg2YlRB?=
 =?utf-8?B?UmFVZEl6K2pjdDhSYk0xV0pLMXhnL2gydFRqQUhJMVo2U0VvSFBwL3ZWeTNX?=
 =?utf-8?B?aUJqVVNaUEZ5YnpCcEEva05OVVBvQjh2OExHMWF1SXh0UUNXOWFLSWNnVXZY?=
 =?utf-8?B?bVpRckhoKzlja25pV0hhaFFTeHRhcGZrSTd6MEZMaXdIMjBFbXZraStDdW5m?=
 =?utf-8?B?SGhKMmg4YUJteGpMVkk4V3lSdkJZcm5pekJoOUZ2MmlqRVltM3RERkJUYVFS?=
 =?utf-8?B?aGNvakR3WDdJNk9uWitxVFA1WVhYbkhLV2hobXNrcFhnYVlFNC96MWRzVlpi?=
 =?utf-8?B?YnU0NWtrN21OYlhTcElwT2JLc1R5RTd4S3ppRVYxelNDUjQ4TkdoS21xcGQ2?=
 =?utf-8?B?UHFvVSsvaUE0VHZTK3EyMjE4b0xFaDF5NnFSL0FwMVpOSERoSFIySnFoVnRW?=
 =?utf-8?B?VWkxdFJJK29GWDJOcmluUWlnbXhGL09JNU1OYUkwb3k4MnJveUt4WTdsM3F6?=
 =?utf-8?B?MG5ENGVmV3BrWVVuTXU1dUFuYmJUdTNVMld4TmhLVTlsS3pLbjExNVByOTdr?=
 =?utf-8?B?ODNwcVV1ayt1eTFpVnUzSWRFU2JlUEJuMEJzdi9KZXk0a2Y2d3pqTnlkNjRr?=
 =?utf-8?B?WkRrV1pDclBrellaSkZZV0hCcHBkSk9GdDYvVlptS09DZUpZYVhWaFhpVU43?=
 =?utf-8?B?MWttaEsvQmtJWDd4QnFUWHRWUytnYUlkaE85M3NkdnV0RjlZUEtUQTFRQVNK?=
 =?utf-8?B?OXVEdmIwZVVHcVJKVHd3SzBJMngxTUprY1AzYTZFSitialdMLzA2L0E3dTdJ?=
 =?utf-8?B?WVJaMGYySFBqY05pdDhBRHp4MDRyQUtPbTlaSldtblNOWkpUbVlQVWpnTjFu?=
 =?utf-8?B?Qm5IL2RDVGl1bnB4RXhxNHRRUFczYmJaNGZURzQxNWEvMWpYMWlwQmtvaVVP?=
 =?utf-8?B?aEYvTFdHMGl6d3FMMnMvcTk2Mi9XV0poWE1UaldoU0NNZWttZkVUNDZnS3ZF?=
 =?utf-8?B?WFgrUEU5aGpYOUdyZ0RhYVhFN3hscVk1SThJeG1qUytuRmlxN0tlamdvdk0r?=
 =?utf-8?B?WFE4K0dKcG0zVUVWSk9FR0hYakx6UUpyUTBwZzRUdDJkOExNeXZGUzhvZTlG?=
 =?utf-8?B?eGtZd1ZIaGFQbmRoSDBMNUpjTS90cnlYcUFRQS8wbFExa0kxVVFPSmYxZnVG?=
 =?utf-8?B?UlJHMHdWU01xRW1HZmRqQ0RMQTFSQXdGQVU3NGpkc2ZSbW8yM212OXJmWjFT?=
 =?utf-8?B?UFRlV2U4R1c4YmQxYVU5VjMwaEhpOEJjTnpOVzVDU3Y2T2FJMkpUZUx6R3gz?=
 =?utf-8?B?U1EwTlFMbWo0a2pjd2tZMlRuOE9hdVVESTl6MThrOE8xRmpVUmxQVmNZeGdZ?=
 =?utf-8?B?U0J6Q3hKa3AvY2VVeXVDOWZxbDE0aW55cmI5cU9sK0tpNWJYSFVURTY5VWVz?=
 =?utf-8?B?cVBaK21ZR2xZWGwrWUoxd0I0Ym9ia3YzaHJGYm5lV3d2Vkd1QS80M1ZkKzA2?=
 =?utf-8?B?ZnRpM0d0VGE2WkQ5ZEhBbnovakFYdG1aakFVMXhTMzUxYW15WEhrYmwvYXVO?=
 =?utf-8?B?TUJwbmhEdHN3cm5tcWdqeVIwMUc4V3ZQQ0d4SXBmSGR1ZVdXaU40QWpRUmsw?=
 =?utf-8?B?QmhNQXhoYW5iSGFvZGtmWDVLZHJPWTZiNHJOdW5tanQrWGNZQnJiYmdCaG1U?=
 =?utf-8?B?TEtNVXYzYktnd1FoQnk2bGNjK1dDZkVMVEJ6YkpLZ1lDZ2I5RVBYeUswbXI5?=
 =?utf-8?Q?LylYOhtje3n3sLU2JReFt+Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3e78d1-6366-4dc8-07e6-08d9da2cd070
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 02:47:06.1617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWgBlGdZFWdrNqcuJofB0yh1HdITLentv/f+70qbZB5OXaek8kJrGwyP3NP42g1F/+Qfjn1DJ/0yQGUbe3teUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1150
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
Cc: Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-01-17 um 6:43 p.m. schrieb Jonathan Kim:
> drm_dev_enter returns true when accessiable so correct the error check.
>
> Source VRAM buffer is reserved by TTM but not pinned so the gpu offset
> fetch throws a warning.  Get the gpu offset without a check and then
> double check to make sure the source buffer hasn't fallen into a hole.
> Otherwise use MMIO access to deal with non-contiguous VRAM cases as
> usual.

There is a way to get the correct offset for non-contiguous memory the
same way amdgpu_ttm_access_memory does, using amdgpu_res_first. Since
you only need a single page, you should never need amdgpu_res_next. Just
make sure that the cursor.size >= len.

Regards,
  Felix


>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6178ae7ba624..0acfd872bfef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1440,6 +1440,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>  	struct dma_fence *fence;
>  	uint64_t src_addr, dst_addr;
>  	unsigned int num_dw;
> +	bool vram_is_contiguous;
>  	int r, idx;
>  
>  	if (len != PAGE_SIZE)
> @@ -1448,9 +1449,8 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>  	if (!adev->mman.sdma_access_ptr)
>  		return -EACCES;
>  
> -	r = drm_dev_enter(adev_to_drm(adev), &idx);
> -	if (r)
> -		return r;
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +		return -ENODEV;
>  
>  	if (write)
>  		memcpy(adev->mman.sdma_access_ptr, buf, len);
> @@ -1460,7 +1460,18 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>  	if (r)
>  		goto out;
>  
> -	src_addr = amdgpu_bo_gpu_offset(abo);
> +	src_addr = amdgpu_bo_gpu_offset_no_check(abo);
> +	vram_is_contiguous = (adev->gmc.real_vram_size - 1 ==
> +				adev->gmc.vram_end - adev->gmc.vram_start) &&
> +				src_addr >= adev->gmc.vram_start &&
> +				src_addr + len <= adev->gmc.vram_end;
> +
> +	if (!vram_is_contiguous) {
> +		amdgpu_job_free(job);
> +		r = -EACCES;
> +		goto out;
> +	}
> +
>  	dst_addr = amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
>  	if (write)
>  		swap(src_addr, dst_addr);
