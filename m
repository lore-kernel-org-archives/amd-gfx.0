Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8F8C47422
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 10:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A3B10F6D9;
	Mon, 29 Jan 2024 10:06:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C2010F6D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 10:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF8LM4RGND1xEFdJUE1hS3HRfguEsTx2ptdgb96FtE+YxRwPzCsXWP9205g+Y0bx+k/fmcWM7jHQUl0TSRozuj+4F3UHYXVSDyQa9EYjBfPL4IcPJoXbmmSLQmqSKFU3TwwSe7Bk4EyUOXrbmUZiIQ0wKzbUY/57NnoeHG+QFxpPe6uO3XL1p2vwG97xn1S4j2+cO3chiXE8AW3CIo9RuqhIyB2ij9H6oIE46xB535+Ht6RdJBd3MWL9/ESPSfLGkMZ3BePRhrZ3WSE2n2PiPDJytID1ZWc5VImh3iaaJBdL67HA+zBtpXeVn/FWxdo3XOnX8JegiSmrti7dosZlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEC/4jFyy+ggpRv/76Q4RUlsSifsKviwjHL6vGewiOs=;
 b=jHzkuKWaqtL/CxslpdDzHprVerXih9RK7a5aTRmGKcyRFdrH0r3yS1g6EcZG2/tVLvjsuLux4zbNR+KxwBDZD0gnWFwzVPi4iiF/d0AHIwd2mng+ODR8RVtomFvWTucN20eHMtA23g1J46dBANKJsCoYJ+NLloPhi38TKXwG3FeDzAr8h8ZdmxsSuX3ul41WiCXljIy213W/QX3DoWEAafEdl0xTS2RVCg8cejTRBGez51XXPV6OjmrZTeJsS/aS7S5WgNHJit6mRI0MhDFexzYPw8GVS6Hz3NLzWjwWkCPdPJJyDUzV5DiTretkYP6jU2FpSvtx2wLLUXy+UbynTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEC/4jFyy+ggpRv/76Q4RUlsSifsKviwjHL6vGewiOs=;
 b=kMc7y39IQzTQnG9Aax0SxNnKssCIH/+Qf6NwijLfnDIVCl/o61SgU6Fvwqx6IqVlVArQCFWDGpPtLGeYiTaWzUuVF/c6+xPcigzNIkV0RraItcpDgqnIil/k4nELxkjWjprIIq9FxzK6azjPiWn2xitFnm1bwaYbNgDYJ/fjrwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 10:06:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 10:06:22 +0000
Message-ID: <e128767a-9980-4892-a8bc-9acc206dd84e@amd.com>
Date: Mon, 29 Jan 2024 11:06:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Support >=4GB GTT memory mapping
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240126194721.18853-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240126194721.18853-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: bb90576f-546d-43bf-8bed-08dc20b1f1e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hfeLDmd3ZGNDCecOuOokFsQ/RT7b/svSqBSTf+wq8Zbzu04PFswabBlCxsF19OMALn2lsjen2rttGlZDELcuueFA8u0ZuB5hGRkSNXqSzWH1jb64WgvScnHa1WI2ML6L6auf4EZpiEp2YE0KGkACwbGCdMBxZB9Ggc5/UTnUeN6Va9Q7GmjBUaLQb07lCUv3CiVbU9EPxiAe1Cktvk6oOX1wEgRnFT0qBO4cIUb17p9uDZtzZ3DKbWb6SslQBRmAmKlLqaGJs0DwwF0yzI4bWlzXBAHuoCqFzkgvGRyakN1StwfvNXEd5OvSrFGNE87imhwnhBLUnUAH4dyuSy2vo0Obri6TOw+X4TMfyhHWCoqQmskJ7wVw2qC8znZwpU7Ji3TIPGaxAaQroO2aMNUvAosZ6hJpljzPEk39amGPSWuIo1MdM2vk/nOq5CPxGuISn84FeMNFH0NtkRUNETEjtwHDnUOgwBCXskaMcN2jow15smte9ZFo/lxLP9dasSVAy+BiyMq624HW1AETGimBKt7QYcMAb3Dgb2PSVKU2S4obPEJJ1gcXxp3YGn4iBTX+tOt1WCONduyr/SuIeM9v9r+kJunFkBS1x5sTxb548pcgvNECeGA2qCdjDQuuBo+ImlmHbhiMtQV7Y5KzThjOpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6512007)(2616005)(38100700002)(26005)(8676002)(8936002)(5660300002)(4326008)(2906002)(478600001)(6486002)(6506007)(66476007)(66556008)(66946007)(6666004)(316002)(41300700001)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0ZZTHdrdkZTMGZvdUs4Z0h0Y3pKSUNXc05YR0E4a3NPMWtZVmRCeDQ4cHdw?=
 =?utf-8?B?djY0b0FsYXo3a2pjSzJScFpFQ1ZHYjMySThJa3BldmkrMk41VFU2enExeS9j?=
 =?utf-8?B?K3VkaHkyc0Q4a21hNTNmTXgvVHdsMEJYNEhyTWoydEZRVndaM2gzcmdlbSt5?=
 =?utf-8?B?Tk9WeUg3UkhmTkdpaUlsTjNQRmI4Z3dSUzZXK2RsUTZ3cVE5NGFkeFdBWXZI?=
 =?utf-8?B?bFRXaXUyRkx6NXRFNlEyOU92ZSs3WEJKOU45NzJiQWc1VmpiVmdva3VDMDJa?=
 =?utf-8?B?V1djU01IOEZhQTFoMDRPcldtYjFZdEltUTIvQ2s3YnptQzFLRmFDc0lHbFFC?=
 =?utf-8?B?VUYxeFVqUHRLZ01LY3Z1bzFjMG1EeDhzUkJTYjRlT0F6R3lLd3hGMzBwRHFI?=
 =?utf-8?B?TllSQUhGaFVSVFdsNWR2RHp3b1FMYlVrSXVnSGlVUkd2enZqbzFqbVpKSUFO?=
 =?utf-8?B?d3NyL1lWaVYvelk4bjZUWGpvZ3Zpd3hRQUN2MFdGSjR6NEhEdzdPc1dXTTNY?=
 =?utf-8?B?Y2wrMy9wUVVVV3QxUDZwaWl4MUNJckVMcjNCMjZ5Rnl2SlRBbFpxOUQwekNY?=
 =?utf-8?B?aFZ6TDlMM092OWkwNW1CcTVtYzEvMWtRSkF0Z2EydG5RZUlMUHRlSjhZcmdR?=
 =?utf-8?B?L3BsNzJibnVqTk9sK1h2ZG4vVUF6R3dhNHY2aUlMMWxteDVuRVpoY1poc2xa?=
 =?utf-8?B?eUR2aTRYZkt3bi91RVJJNG9mUFF0ZVlYSEdoRFF4ejJHdEhpU3VMa0JncTZj?=
 =?utf-8?B?anJ6NndQc2FaRTMrcSsrNm5GRXR5Z0FYV0lGSEZKemIwM0xhbXZ4TkRFMDJk?=
 =?utf-8?B?SzFKRDI2b2d6WUVjQ0RHU2pBU3NmVjBVdGNxVWlZK2hHM25aYzhGU0JFVEhU?=
 =?utf-8?B?VkVUTXdNRUNxOG53N1BYeVk4L056M3FHNnFacTFOa1NuQzZtaVRxeTFNOTQy?=
 =?utf-8?B?WHNzSTBCY1R6RWorL2grV1NvMkpQSG90YWdDOUZ5Ui81UTAzT25hZzFXQ2Nz?=
 =?utf-8?B?cGFsUzQreEtjTHNZOFdLUFdRTXpvdFRRTFlTSjdra3RJQTJRaVQ5S0ZYOGJx?=
 =?utf-8?B?VVFoRElGVmEwdzkyZEh5aEpEcFl0UGMyK2dTVEdvU09SVUp6ZXpFdmc1anNl?=
 =?utf-8?B?OFpUMk4vMjZ6L01xYU1NR3E0RFZCMnVNemRkR21pditDZVdPbFJqK3FtdWxj?=
 =?utf-8?B?bjJNUDFUbnBTd0RxYk1iMTBuTkE1K0VCb3RySkVSR2lzUDlRU1NFeDA5SHg1?=
 =?utf-8?B?RzlsYVd6Z2laWUlqWHR5anRLNnF5UWg2ajNkQlBBUXJBRGZvcFdFQnc5anF1?=
 =?utf-8?B?aFZWWmptZHpGcmpoU1VKY0RqUTg0NEpFUVU1OFdZaDV3RE1QWmRqTHBjalV1?=
 =?utf-8?B?cVE5blg2T0s0a1lCWWIvZGVJeG5sdFA3TCtYVm5OalhPS2FJQzh3elhTRnRr?=
 =?utf-8?B?TWUweWZwWGpYdGJIY21VbDFxQ2EzSDJhTzBINUJRWi9RWkVPZVVqNU1ZRkw3?=
 =?utf-8?B?M3J6aFNYVVZnRnFzU2pSNlpXZitwdEZHTzdBVUpVTXBBdTlGTmdQbzFkbldM?=
 =?utf-8?B?eDlXaFJvOXNXUmk0KzFGcEkzUkVXdDhvNm1PMnJxa1I3Y2J5d3FTaXMzQlFa?=
 =?utf-8?B?REk5MEc2aDYySlBxSmpSakxFVjU2WU1abjV1eXVhUittNWdnbkN2ZVEvcytK?=
 =?utf-8?B?d2RWZGt4TmV0ODVGWDR2OTN0VW5VR0VrTlg0M3d4bXBtSTExNlJZS1Vsb3BF?=
 =?utf-8?B?SEFIUDVlV2hPU044d2lUdjQ3Z1NqRDdaNWc3SElvVkxFUWNBTTlQN3JiYWhN?=
 =?utf-8?B?dlhhTU1lWFFMM1hjWU9nRDlSUXpoQnlTbEg4NW5MeXpsUHh3ZnJad1BYVmtN?=
 =?utf-8?B?UzJzKzlMSnUwRE1JaDZNeEpyWC9KWElVQ3ZkWmpQRFkvUG5YNzRYVSswaHJh?=
 =?utf-8?B?TGo5a3BrRVBVajNTRldpdGpQNGNiTVNibGx0V0RWbEJOQnIrbDFBd3R5cGUy?=
 =?utf-8?B?ckNTU0FRampZSzEreGc0dXlaM1docFFTa2FURkErb0tUVkNWd2l3UXlJNWxO?=
 =?utf-8?B?OGw2NllxYnN3ZkFrMjltYnRramsrQzdpSXM2L1FpdUU3Z1lYMnQrNldSRGor?=
 =?utf-8?Q?7x1U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb90576f-546d-43bf-8bed-08dc20b1f1e7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 10:06:22.1425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLwtQY+ZENDPWb7T4+kIdgg+VXMRilGSytSXl973XKn+oy/s8r5TV5SUfFeeg7JZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.01.24 um 20:47 schrieb Philip Yang:
> This is to work around a bug in function drm_prime_pages_to_sg if length
> of nr_pages >= 4GB, by doing the same check for max_segment and then
> calling sg_alloc_table_from_pages_segment directly instead.
>
> This issue shows up on APU because VRAM is allocated as GTT memory. It
> also fixes >=4GB GTT memory mapping for mGPUs with IOMMU isolation mode.

Well that was talked about before and rejected. If we really want more 
than 4GiB in DMA-bufs we need to fix drm_prime_pages_to_sg() instead.

Regards,
Christian.

>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 50 ++++++++++++++-------
>   1 file changed, 34 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 055ba2ea4c12..a203633fd629 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -171,18 +171,41 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>   	}
>   
>   	switch (bo->tbo.resource->mem_type) {
> -	case TTM_PL_TT:
> -		sgt = drm_prime_pages_to_sg(obj->dev,
> -					    bo->tbo.ttm->pages,
> -					    bo->tbo.ttm->num_pages);
> -		if (IS_ERR(sgt))
> -			return sgt;
> -
> -		if (dma_map_sgtable(attach->dev, sgt, dir,
> -				    DMA_ATTR_SKIP_CPU_SYNC))
> -			goto error_free;
> -		break;
> +	case TTM_PL_TT: {
> +		size_t max_segment = 0;
> +		u64 num_pages;
> +		int err;
> +
> +		sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
> +		if (!sgt)
> +			return ERR_PTR(-ENOMEM);
> +
> +		if (obj->dev)
> +			max_segment = dma_max_mapping_size(obj->dev->dev);
> +		if (max_segment == 0)
> +			max_segment = UINT_MAX;
> +
> +		/*
> +		 * Use u64, otherwise if length of num_pages >= 4GB then size
> +		 * (num_pages << PAGE_SHIFT) becomes 0
> +		 */
> +		num_pages = bo->tbo.ttm->num_pages;
> +		err = sg_alloc_table_from_pages_segment(sgt, bo->tbo.ttm->pages,
> +							num_pages, 0,
> +							num_pages << PAGE_SHIFT,
> +							max_segment, GFP_KERNEL);
> +		if (err) {
> +			kfree(sgt);
> +			return ERR_PTR(err);
> +		}
>   
> +		if (dma_map_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC)) {
> +			sg_free_table(sgt);
> +			kfree(sgt);
> +			return ERR_PTR(-EBUSY);
> +		}
> +		break;
> +	}
>   	case TTM_PL_VRAM:
>   		r = amdgpu_vram_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
>   					      bo->tbo.base.size, attach->dev,
> @@ -195,11 +218,6 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>   	}
>   
>   	return sgt;
> -
> -error_free:
> -	sg_free_table(sgt);
> -	kfree(sgt);
> -	return ERR_PTR(-EBUSY);
>   }
>   
>   /**

