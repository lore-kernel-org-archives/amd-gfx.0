Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D2BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 21:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A356EA0B;
	Tue,  7 Dec 2021 21:59:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 727C76EA0B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 21:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbqHMFmsixtB3Y9ZjfyhoqVyoh2r4VLjsYVl/rHIOtMeb/v7VycTZM2f2tkb1GVSVnB7fRm16FlayevAR9B3beo6yBGlbSkYpZbRfaeQfppM4ThjCsHvzwXykVHSK+20Jj57G52MS++MxPmkzRKsuWPKqwmDOPSrgMtyliUd20aRC4aiTKSuDZhcDcAihH/X3xn6nNJObSHg3T8NwubUhmuTxsoHOPa0D8wIaKNo6+yl/l1PWXf2r2LLdnOxxXSstBIHrquSU+ppAEpj1LJlEoFe0v3f1PElbGgLEcUjokS4Vf/djkh7FN0OBxgb0wtZYxjtYzfmNwkR4yaqPiqm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mllS55JlwOvYqujdCbcbEOiaVgItJ/6lv8vQygo2Ue0=;
 b=C2Wk3OqA7qPJ8jvvfT6z0hY7C2I9tSuMGfLlWAPAEX0ILSbcVURFfgcd2d6Owq3Hxwi8f7xF3O6JIMkNz3l7ZZrL1QPaviGovMnjr6i8b8jPyH3QmOC2ISL0i0Ld1uhy7DKpoo+GJTouYuY6hT798BfDQNusL/5DcySY16jWDQChtu7J2659MCVFW3g+bZlC7N4GbSVxdEmH8M1VLZbnXHh3VPELhCzyTM4RMOgNAUJlYt6WJWkQUfNC2pELl/WQYl6MHUJI2LJkoi8DLJ4nfLMvMkIlpb36sW45jTFBz7HbWhcxKeOdVo0O5yI3YioefQ3SP6gR2icLhsWL2NFcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mllS55JlwOvYqujdCbcbEOiaVgItJ/6lv8vQygo2Ue0=;
 b=0KddXysWmQ+IE6vRPQeT/FbrXTL0c4os94jes+8U/ZHL3z3MkvJtjfEaMODipC4mnLytBYR97EOXNs/KK1l92I2FOzRGe3ZJhaaDOmRD77QnM8Fkb7TVkzkqKcj37vsstPqmAb1ymkuuaf/HGRCGINmwqC6vlt93nvmVxx9emVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5194.namprd12.prod.outlook.com (2603:10b6:408:11b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 21:59:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%7]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 21:59:26 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: Detect if amdgpu in IOMMU isolation mode
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211207145911.2690-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <4e277e05-4bf0-3f24-a28f-6ac7b33b45b4@amd.com>
Date: Tue, 7 Dec 2021 16:59:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211207145911.2690-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BL0PR01CA0022.prod.exchangelabs.com (2603:10b6:208:71::35)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 BL0PR01CA0022.prod.exchangelabs.com (2603:10b6:208:71::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.16 via Frontend Transport; Tue, 7 Dec 2021 21:59:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7984b28-e983-424b-a76b-08d9b9ccd589
X-MS-TrafficTypeDiagnostic: BN9PR12MB5194:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5194AF47BA70E251594449E9926E9@BN9PR12MB5194.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNPCdGRdM6OQTVL6uXKkgiOsylIeV0PN5LT4iwP37DKLpEMtfVuur82Cf1lsuTen8x3s0iaKLkV1aNruT7YQqRCN4uEAm/YrROt+0t3hOYLPw8eNpI/hm8iaKRcv/oQ1IMPBgYffpQcVGCVgzdIW92Ujbra8b5vMO5JIC/cCTtJNyhQLzBgvudL1FlX8cpKhK/fXgAYvNGapzBr35i6HNAhaJhyd1kEYe6DIWuEnUDAEzB2IhbIIe5avyMQeAr378crYA07xvKOe9e/2dIj/uHEM/+KcbCgJRYJCH3z8d0AkWjLVtraaxeiz2vW941LfwPdSi3Un4d6rDjvWmc81BKhpMurALVfD0tUmEkrMRwyH2QZ4COxOrv9vxn7m7zQGk5ySUM0U7JBrxp1s8Wd5vlgfDZNH1vc2Dh/jzU8lKjGmsu6vmSl6u7jWQJG6KnlWD/vVnl66JRci8J6USm8oH1jEnXWZsdBuS0ac5xFcJEPOd5vIynIZk2eqlRsVrpKuTeKO+UOtNIKQqP1Mwafc8rBPvk6yPYbu3hzE9GLST/FAT3CDgy4prZD5h5gc3kUn1cP3Gc1SBf/GY3JSLwLLrsggsGamQRro32tquitLn4jL8VDPmanbNSTOmcVDk8xZeLhaiYQWwRGBmdaOl7llpZ5CYiLAmz2xWmkUDBZwDuNs26p/lPx/2pBwDI4HU5UejBLrMWDnfV0bqpfemxU4sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(44832011)(2906002)(36916002)(8936002)(26005)(5660300002)(186003)(31686004)(38100700002)(31696002)(86362001)(2616005)(6486002)(8676002)(956004)(53546011)(66556008)(508600001)(66946007)(36756003)(316002)(66476007)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVNJTUVtR2dCYS8wWjBhdDcyN0FUNUx3ZHQzcFl4UGpYUlhNMEhPVEZYZmRD?=
 =?utf-8?B?RFpaSm1jbTBkdHVoUDlpQWRaSERrM2VnSlJHTjFRSVR2T3JJeFpwb091Q25k?=
 =?utf-8?B?dHpPellOQWh5STQ0MXhGcjNycU11amxVSmQ1V3AycWNEcys3dVFrUTFwZC8r?=
 =?utf-8?B?MGlpa0NoUk1YcFB1NXdCdFNEb1NPdUJsdnZaWTNKTWZSeFBkeTU4Y0lKQ2Zv?=
 =?utf-8?B?ejJicGJTcS9VcUd5ajlYZkdHZWtGcjhxNDBoZmEvSEw5OUorL211VFNqdVQz?=
 =?utf-8?B?VWxwOE1QcmIzN0JLazUrN1o4Z2lVaFBER21zSGdSL2FTZmlQUzNkaUh5bG9m?=
 =?utf-8?B?NkVrcXVjRHZvclVFemYrUjRFem9NU3hFSlE2R09NNWlGOTVqVzI5QmtkM3Vr?=
 =?utf-8?B?KzdIcVFFNEhtdFhYOGtPaWJDZ3l0V0YxM3hIVXF4RVNjL1lDWFZMK0dteTNh?=
 =?utf-8?B?ZGxMc3N5NTNLRksyZHJHdVNxS1ZNaC91NzBkUEtKZHhhTG4wcjFwWWdPRHpq?=
 =?utf-8?B?L1J2eldGVjYzdzNsY2ZSbEpNN2hiRkJleGw3QjduS0VoNDhIK1JvVE5VMWNt?=
 =?utf-8?B?ZVdlYk9pWnEvT3pQTnM0Qi96ZXpJZnNsYmFKUzM3MWJ5K3ZKY3M5c2lLcldx?=
 =?utf-8?B?SHhDa2o3T3RXVlJwNEVsZCtETzMwMnI4MmEvenhvbXhBb050cWhuZ1JQTW9N?=
 =?utf-8?B?ZjVDa1k4V2ROVHpVWWpzcTFwb1FyVWt3eXNlNzFlUzVMZnBGa1VvcHRyU3Vw?=
 =?utf-8?B?aWtTNTRSZ3ZlOVBCTUMwckY5WCs4bW95aHpDOG9FeDYxQUdEc3hRd3NBdGk1?=
 =?utf-8?B?aWhXTlBrQ0gyOVJEUkh4c1E3TlR5L2hQZ0FjODljTmJweHh0UCtKSE1sUnVr?=
 =?utf-8?B?RmVZM1hoSnFCQ0tjdXNiZllQN2FUWURNM2NxVzFPRzBDbndBZFYzaS9Eb1BM?=
 =?utf-8?B?d0ZKOGlxWTRuYzh4bE5WN2xtS28wS29mbENaeWZ4bG9UTzVvVEJhMGdnZEND?=
 =?utf-8?B?Tkxsc24xdWp1QThBMWRyQmFoeVpmM2hjOXhwU2hFSGNSWmtXSzAxdDhLa3Uv?=
 =?utf-8?B?OGU5NEhTaUJCeEU0SXNTVjRPUEJFekhlVU9TWUtNdU54NUhKZStDQXlXcXZC?=
 =?utf-8?B?VTYxNkVRR1J3Uzd0Wk50QWVMdkNJbmRPRDVENjRlSFNoSm1STFVOeS9VTkEw?=
 =?utf-8?B?QWdJY2MvSmZuZHJJc3RLZkF3RFRXbm56ZC9kN1dOTlNyNi9NcHMrRHRwY3NO?=
 =?utf-8?B?NjQzek9kSzZreXhlNnZIR05oanJJajczaWR4KzhsY2w4blNMMU9Iell2QnV2?=
 =?utf-8?B?MFZoL2dZMldmU3dDQlFCalBpbGc1WUxvYjhIaXkrNnBVOW80VG1wUGhRV2ZI?=
 =?utf-8?B?eGMwVUphSDIzTWdTdTZ4cDdVbmxQQ2JCWTZhNmNkT3BhbW9wUWMyZ242cktQ?=
 =?utf-8?B?S20zeDk5SUZybDFiTTcvT3BIVHQrcDY2d3c1ZU15cE5GeE1DODhvUjVzMENV?=
 =?utf-8?B?dVYvakhQU2F3cHpIeDJpbURiL2hZZTljUGwzbEtFUEV6cWdHV0wxRDNkdWFC?=
 =?utf-8?B?STZkWXIydDBqT2taV2thcmIzMThjZmFoWTAwWmp5Wnd2L1dqODBaUkJsWkJl?=
 =?utf-8?B?bVM5czI1dVkzeWNaUDlWZUdacXBTMGJMcDhVcXRRRHlWVnpxazVCaG12T1NV?=
 =?utf-8?B?Vms0QXlhVDcyTlVkQVJ5MUtwajBRVzEyQ0hvRHBFZDU5dHUvNm00V2FNZU5O?=
 =?utf-8?B?Tnc4OXJBTmdwTjFmd1N3elZhRWgvRSttK0ptd1RubEdsYitIeTBQakl5S0hX?=
 =?utf-8?B?R08wNWhvMDUxTk1jTnN1dFZVUi9XTFpzbDJoUTFjQUN4ZktUVWRqd0t4dTFY?=
 =?utf-8?B?am9vV0dUY2xJbTQwbTMvOVI4dXNvQ1N2SW52NDMvNm5yVktkaWRYQ2ZGSVg4?=
 =?utf-8?B?alhIVjBSbjdjcG1yNDZhMFE0R1ZabTgzd2xWNk1Ba28wNWVjRmxKN1l2d1kw?=
 =?utf-8?B?NjlTVi9hVkZTaEZ1YittZUlmVVVveWcwb1Z4WHFoVkhKdGxxeHVXemxmeXdJ?=
 =?utf-8?B?WnBOR3R4QVh1RjBWN2lRQUo5RFUxNlp3MkxMOXRsZ3hiN2YybE1jOHJ6Zk9i?=
 =?utf-8?B?aCtMN3R0Y0wyQmVXMFV1L1RBaTlCQmpyRGpVZkxqdFMwUUU2U1dLVnY0U3Fy?=
 =?utf-8?Q?RTVYFsvRONk5HN7VLRuLEtA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7984b28-e983-424b-a76b-08d9b9ccd589
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 21:59:25.8732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFTigqncxLyEVOLdLNQhRBGDPdYPpWvvjsI1IsyOD9g/9bjik2WRwToq0RsT8l6vXm1mhDP1xIgx5F+eh0mMdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5194
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

On 2021-12-07 9:59 a.m., Philip Yang wrote:
> If host and amdgpu IOMMU is not enabled or IOMMU is pass through mode,
> dma_map_page return address is equal to page physical address, use this
> to set adev->iommu_isolation flag which will be used to optimize memory
> usage for multi GPU mappings.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++++++++
>   2 files changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index c5cfe2926ca1..fbbe8c7b5d0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1097,6 +1097,8 @@ struct amdgpu_device {
>   
>   	struct amdgpu_reset_control     *reset_cntl;
>   	uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
> +
> +	bool				iommu_isolation;
>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3c5afa45173c..6d0f3c477670 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3364,6 +3364,31 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>   	return ret;
>   }
>   
> +/**
> + * amdgpu_device_check_iommu_isolation - check if IOMMU isolation is enabled
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * device is in IOMMU isolation mode if dma_map_page return address is not equal
> + * to page physical address.
> + */
> +static void amdgpu_device_check_iommu_isolation(struct amdgpu_device *adev)
> +{
> +	struct page *page;
> +	dma_addr_t addr;
> +
> +	page = alloc_page(GFP_KERNEL);
> +	if (!page)
> +		return;
> +	addr = dma_map_page(adev->dev, page, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(adev->dev, addr))
> +		goto out_free_page;
> +	adev->iommu_isolation = (addr != page_to_phys(page));
> +	dma_unmap_page(adev->dev, addr, PAGE_SIZE, DMA_BIDIRECTIONAL);

This is a bit of a hack. Unfortunately it seems there isn't a much 
better way to do this. I guess you could copy the implementation of 
dma_map_direct in kernel/dma/mapping.c, but that's more brittle.

I think this hack only tells you whether system memory is direct-mapped. 
The answer may be different for peer VRAM (which isn't supported 
upstream yet, but it's coming). I think this can happen when the IOMMU 
is in pass-through mode by default but still used to DMA map physical 
addresses that are outside the dma mask of the GPU. So a more future 
proof way would be to store a direct-mapped flag for each GPU-GPU and 
GPU-System pair somehow. For the GPU->GPU direct mapping flag you'd need 
to try to DMA-map a page from one GPU's VRAM to the other device. 
Anyway, that can be done in a later change.

For now I'd just change the name of the flag from iommu_isolation to 
direct_map_ram or ram_is_direct_mapped or similar to be more specific 
about what it means.

Regards,
   Felix


> +out_free_page:
> +	__free_page(page);
> +}
> +
>   static const struct attribute *amdgpu_dev_attributes[] = {
>   	&dev_attr_product_name.attr,
>   	&dev_attr_product_number.attr,
> @@ -3767,6 +3792,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
>   				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>   
> +	amdgpu_device_check_iommu_isolation(adev);
> +
>   	return 0;
>   
>   release_ras_con:
