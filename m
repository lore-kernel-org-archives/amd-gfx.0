Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5821CE79A8
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 21:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68FD910E1D4;
	Tue, 19 Sep 2023 21:22:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E80A10E19C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 21:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vv+snMTBeXZASNhvJJtKwYuNrjpUelQNaTbEnOgKh0fV84y60rAtc1sDO0G6snda3K13Nkvn3xoLeo3XhpKy4FaZOn8J4EmMCatlWGHgjgV+uCI3hdFiXBaF9gaLAVbSWAMIca0NZtZ5wOPqH03WnZtSRgpwUspSdbfcaaJLJexS31/IROxuzXtNEExyCQjb7eqZOLUpF+2CFRRUzmw6Rmf1a1ChdC43/cEOaQMDnYFDcLNBXyF/sF48pwsLrmXHCfF3ujP3strR67PaIhBNgZeMjgU0iLKPM+9lNer/6mh+Bzi/MHwcpTtaSBYRBrtQcUNtMLGC+Rdu5aG77SMAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLniVy7hJa+XrY7I4A47zVj8fX/aZNjKAhxVQiBlqSs=;
 b=V8HSmcUYYyYGRrVqEKdf1WTl9p8of7+C9b9iM6qQn3nP/EsUx1ZRfzeM4Tja27igU0LmiRPnXFjX44QorIL/z3PglJre6LEOcKf0+Bw1cWrd4wQDKj0cpsAkqARZm1rXUL0Ua+rRjlumRl8baBcdHeJISyiH9ppQRgONr5njJyKSSaldDA+rFEqf6+n6XTvqwW0KFdlFXM+z7/PunR1fku5yO8CV1NQBkvhRP8QBG/vb7IbqMqkYQPXCE97jh5VdDJN3MetUJdrV6OPoD73VL84czbd2lfzIKztR6JNBsGqRmICcqTOWbYkZS9lJ/WcSiFUxOh2G8pDcLApVbkYA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLniVy7hJa+XrY7I4A47zVj8fX/aZNjKAhxVQiBlqSs=;
 b=u2Z12YxahE0LzpvQl0DCQOAU5+JKDNKiSIbpQKnEpYnwgeg2qzVZg5vIMq7oQj/k9TD7nXwykhrRZEPCiHCSsbyMjGH9HS4Ln3Rbh4j3AqFoOeBEiczjGZgbMnSlUw2zFSqanK2mxo4fYnH9cNTKhFWnxPydOCqYV7pdoD1R3UU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 21:22:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 21:22:16 +0000
Message-ID: <6764ff33-3bd6-bf3e-7379-2dd091bb5a15@amd.com>
Date: Tue, 19 Sep 2023 17:22:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: Seperate dma unmap and free of dma address
 array operations
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230915221353.21242-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230915221353.21242-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 425c03cd-79fb-46b3-7598-08dbb9567f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktDoEvWTAPZj5K/zcsDIsRDPKAkjwIkEbadL1E/W5KEhVmGMnied7a71Vy46T64KP4l0z2kC1LKlJ/WYpPFVtaCzZ/wW0kW1ON0z5TGm6Xv4Ta+Eo40KPUD/FrYsk9R89y0R+SbX5xxVjYd1iLNb1M11Sg9XKTVJv225VQvCqagqMNvtxyseRsvuHiSVIyQkC1c9oSJbAXaysSi9yXVnMy81nqodnjeV6Wli+aWdNQHSc7Q+3VJi621aOCd+npwZP6D1QB/XTr0W+nyOFQ0chnTFGXHHgmVi54SNJkIgM8JZOnp4tMDXU7CLjMW/mM9qm6RAZ6E13BjYnoO4N+Dot6VVwdlcR+ryi98n7NZOmrDV4nwXYWwh/DLu/43NzU4ry/XfiJD35W/fFyTxGmTHB9YCPSVYtOiyJsZk8yEMnj/0FZwbab+fk02jvohmmncRvFpaaM8b30LLGCJbxCjeiPzXglInlajzOyk8updaGQaSaih2FZ3XsXYBcxJ5rNMJN3CEsUYdYo9rIDA9565a4/ckd4GzlHhSKQUjuV15v+kyaHbb0sfsL84OwAW29UzqviIqy0oSt08f/qD/3qVncWjpPNu6PYFAJk8ByjVk7NvP6XWVYiYZ2T/hA6xq5axbyp5lWF3/wn2o4zamv7rgeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(186009)(451199024)(1800799009)(316002)(66476007)(66556008)(66946007)(478600001)(38100700002)(2906002)(31696002)(8936002)(8676002)(41300700001)(86362001)(5660300002)(83380400001)(44832011)(2616005)(6512007)(36916002)(6666004)(53546011)(6486002)(6506007)(26005)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0dWWlRoSFF6MTFwekUwMWlYYlZZazI2OUpWMENPMTBIRXpTV25WVjgxVlFj?=
 =?utf-8?B?RFZiRWN1YWlZUHh4WGVzN3BXVW5aYXpReGlmU25nbnZ5elUyMWZpT091TTJ0?=
 =?utf-8?B?ZlRBcWdJS0NlWXh1aXhnUlJYeERSdS9JKzVUdzRzYVVkNGNkNFUwL0N1b0Zp?=
 =?utf-8?B?cFlzV2xqVUpOU1l5RXZrV3BCOGErOTd1WmV4TFpEODNGTTZIakFJMkpDcVAw?=
 =?utf-8?B?cXRkbjlMQ1ZteGZWSDlRVWkwQStBUklUb0twaUVyUkI4bzhPakkyd294ajgr?=
 =?utf-8?B?TnZtcG83M3dEU2F0UXVUSDBxTTNBVURacEtwdzVoTjdINjNKeGFPdHY3cU1C?=
 =?utf-8?B?amZETDF4dmZUL3R5dEhDOEUyaS9FeTlHMHo2LzFxMkhFcDd1dE5kdmF1ZXRp?=
 =?utf-8?B?Z0VyWjFDazBFUHdCZGRrRGlEMVpoVFlUdHZ1Y08wMDcwVDVNOEhEZ3A5Yjdw?=
 =?utf-8?B?TC9pOU5kcVVPTmw4UnhmMXJxSGZET1QzWlhHSkhKTVQ4R3NXKzdqVkdNS0Np?=
 =?utf-8?B?Wm1Kb0FvTEVPdUlJcnU0NTBqL2RERjhDVHFVOWJGUDlMWmw2cGRUUExKV0JX?=
 =?utf-8?B?Q2xVelQwWFJqMlVxVFJNeklBSHdIdE1LcHArZDhUWDlDd1Q2MkNjZklyWHFp?=
 =?utf-8?B?a2IwUU5HNC9lQlpsbHBOSklrZGR6dkdlVmMvdUhLVk5kenpDWGhkSWNoT3dv?=
 =?utf-8?B?OC9hejE2VGFBMkFNU2NlaXZvNUkrN3JDOWFPN09OT1NhdTYvUkVmeTVLb1FP?=
 =?utf-8?B?QzhGZHRWQlczemErL3Y3L0lwbEVuOVUyOXNRSWhlTUxFYlpJbWpoY3IwMzlP?=
 =?utf-8?B?ZzYvQXlKUW1QNHVlM0NuYnEwajNGUktkZ3JQMmJ2TjZiZTlsR1VnUytraUJn?=
 =?utf-8?B?YW5CYnNNdDQ3Qm9NWnJ1S3dxcFZZNEdvdXFaWUd4WE9VdWtySkZJMDlQc20w?=
 =?utf-8?B?QVJEUVNRYUNyZDFxeTE1bVhZd29ha1RsZ28zejBiZmxkOXh5aDVlOUhKdVY3?=
 =?utf-8?B?TGlQMUVsWXZ0Qkl1ekg2NmxNL1h5TUVLMWp4L3pNczJHOVZrOE5na0h1ekt0?=
 =?utf-8?B?V1lCbFNaL0FwYVZBMVFzY1Z6TlF0VFJMZS9ENDlwVTRaR3BsYnJQLzhUZ3FF?=
 =?utf-8?B?NmRXaHhmaW12SjJObEdSMTNQZ1pjby9tcGl6bkxjbzZ2SjRlMWxianFWbjFY?=
 =?utf-8?B?Z0JGVzBxYTZJUUFIaW5tcFdGSnJOaHZsTmtqNG9JYi9wM0syVjdza1Z2TFJs?=
 =?utf-8?B?MEI1enJHYTE1WnJKNkJDM2tvNDArL3JTQk14ZmlPanRzSkFOdUJwdkFtRXdv?=
 =?utf-8?B?Yno3WXNkM0Y2T0IydUFyZ010YStsa2g4NlVJSmFteGp3RFVLR0NGL0V5QUNp?=
 =?utf-8?B?V0xvemFvVzA5TG1TS1AxVDNDMEsxUFBTU0h6eUNRWDEzRy91SmVpV0tGTHpG?=
 =?utf-8?B?UlByTXJUbHJUZzlrb2NSUW9heU9KdnJxcHJEWEZYVVpCdWVTdFBvd21hT3lQ?=
 =?utf-8?B?Ykk3MzFlWVpUWEROOXRkSzZMOG5DcFNRK2lHTis2ZVhHMUdyMFRJVnZma2lE?=
 =?utf-8?B?OWMxbFoycXBoZFhWYlozODNJVjkzcFpSOC8xSzY3b2h0dnhqZ3luSTVRekJq?=
 =?utf-8?B?UXVjYWtUK3BwMmNGcDVEZ05XcDNYbmdNK0xzYmVvUERkOThDQ3d2SEg2N3RM?=
 =?utf-8?B?SXIveVBwRkQyMlBsN1o5UVRMckNTT25NOGRwOVNGbmxpRWttVTR3RHpEUXRX?=
 =?utf-8?B?VVZtNWJRYnZjNGNiYUt3SFIrOWs3b2JtT1h0b2hSSGc4TjdiUG1ESmpmc1h2?=
 =?utf-8?B?MjRNRVIwUS9zK2JidGoyMHhEMGFHeHhxTWhiTHU1eEhDd25WVlFFZ2hHWTVp?=
 =?utf-8?B?bVpFcXB2WTd2bEVNbTdCZ01kektwS2lVNGJiZ0hENVByUklrVUdtR3c2eTM0?=
 =?utf-8?B?VWI3WWVpUmhkclhYbDlCS2VBY1U1MjBYay9sR0FYdmdNVUpuRGxiSkc0UGNU?=
 =?utf-8?B?RnYranQvUkl0YXdiUlJ6L24rWXprUlVLenBpclFibkVwaFJRMUpuNDlFZVJD?=
 =?utf-8?B?T3VlRnQ0VStvUXdMcFJTMmgrUm5sam1jZWxsUzN6MjFJRVIvdmVOM3hkR1Fj?=
 =?utf-8?Q?dn7I0PClNKpS1n2MSh5momrmu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425c03cd-79fb-46b3-7598-08dbb9567f8a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 21:22:16.2384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61LRFY09yV5UFUwUsll53P+HLQqQliSVJhGBfzLY8B0A3TV6tSpIFwbOPRE4FlU2uhwmBEv/xwDBfhCIhEUiNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049
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

On 2023-09-15 18:13, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> We do not need free dma address array of svm_range each time we do dma unmap
> for pages in svm_range as we can reuse the same array. Only free it when free
> svm_range. Seperate these two operations and use them accordinly.
>
> Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  6 +++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 23 ++++++++++++++++-------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  4 ++--
>   3 files changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 192b0d106413..6c25dab051d5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -460,7 +460,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
>   				    0, node->id, trigger);
>   
> -	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
> +	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>   
>   out_free:
>   	kvfree(buf);
> @@ -544,7 +544,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   
>   	if (cpages) {
>   		prange->actual_loc = best_loc;
> -		svm_range_free_dma_mappings(prange, true);
> +		svm_range_dma_unmap(prange);
>   	} else {
>   		svm_range_vram_node_free(prange);
>   	}
> @@ -745,7 +745,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
>   				    node->id, 0, trigger);
>   
> -	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
> +	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>   
>   out_free:
>   	kvfree(buf);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 5d7ba7dbf6ce..bed0f8bf83c7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -229,7 +229,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>   	return r;
>   }
>   
> -void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
> +void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
>   			 unsigned long offset, unsigned long npages)
>   {
>   	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
> @@ -247,7 +247,7 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
>   	}
>   }
>   
> -void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma)
> +void svm_range_dma_unmap(struct svm_range *prange)
>   {
>   	struct kfd_process_device *pdd;
>   	dma_addr_t *dma_addr;
> @@ -268,10 +268,8 @@ void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma)
>   			continue;
>   		}
>   		dev = &pdd->dev->adev->pdev->dev;
> -		if (unmap_dma)
> -			svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
> -		kvfree(dma_addr);
> -		prange->dma_addr[gpuidx] = NULL;
> +
> +		svm_range_dma_unmap_dev(dev, dma_addr, 0, prange->npages);
>   	}
>   }
>   
> @@ -279,18 +277,29 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>   {
>   	uint64_t size = (prange->last - prange->start + 1) << PAGE_SHIFT;
>   	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
> +	uint32_t gpuidx;
>   
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms, prange,
>   		 prange->start, prange->last);
>   
>   	svm_range_vram_node_free(prange);
> -	svm_range_free_dma_mappings(prange, do_unmap);
> +	if (do_unmap)
> +		svm_range_dma_unmap(prange);
>   
>   	if (do_unmap && !p->xnack_enabled) {
>   		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
>   		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>   					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
>   	}
> +
> +	/* free dma_addr array for each gpu */
> +	for (gpuidx = 0; gpuidx < MAX_GPU_INSTANCE; gpuidx++) {
> +		if (prange->dma_addr[gpuidx]) {
> +			kvfree(prange->dma_addr[gpuidx]);
> +				prange->dma_addr[gpuidx] = NULL;
> +		}
> +	}
> +
>   	mutex_destroy(&prange->lock);
>   	mutex_destroy(&prange->migrate_mutex);
>   	kfree(prange);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 9e668eeefb32..78bfb83cd0c0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -181,9 +181,9 @@ void svm_range_add_list_work(struct svm_range_list *svms,
>   			     struct svm_range *prange, struct mm_struct *mm,
>   			     enum svm_work_list_ops op);
>   void schedule_deferred_list_work(struct svm_range_list *svms);
> -void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
> +void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
>   			 unsigned long offset, unsigned long npages);
> -void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma);
> +void svm_range_dma_unmap(struct svm_range *prange);
>   int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
>   		       uint64_t *svm_priv_data_size);
>   int kfd_criu_checkpoint_svm(struct kfd_process *p,
