Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05FEC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 22:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5583010ED99;
	Fri, 22 Apr 2022 22:05:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA3C210ED99
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 22:05:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZQUyzZopaNOJ+xrpq4TTb2BaImVoFRsthSDnRfjJbYUkyoMqLzP+EeotrVYNJScxb3qcFIWV0RK/zEnQJGv/GdV5tOYYl7XaCP9Fsb2yjLZfOHzQaM24zzUdXnsgTANdqZdIqOzqxn4waUvxnw2W2tAqYMakhTsF10I17bWuG71lRtXaIQ4OqW8gyPSecFqEjtwLMfQ6punVslEwoZHlIED5/XP2+vq9A7gECm1+PJ4Nr2JALe7v5kp916LRhyZZ9TXI+w8gqh5AMxb9tpeccisR3g4IWZNyL5+i+E8DryXpb1t7xnz260qH81QtgjBNDGgRfpqzWNVR8Y50o1Ajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3afd6F/hkrmMR4Wke/5bZ52FlntPWKEoQ1yaYhIetbM=;
 b=dByrCFqo8p60mTgPd6bsxbIa4/xMka2rIuAmQnuPXYWMA/MFIYFThsvbwVL7yFNTDIJcejAFiRToak8F2uokwTKuxfmtcdgFFyTzCKy/IQsTgCmzckVwSLCudq2NDqlyFirqQGKGwOtwB9RIRXI7GtXqsu1H8lXkQzC6gGEWwcX/YWRGjrvGvhnH+MuMPBWaWS1Nou5/G/3+HwqZON2+reZYN1rYH8rvASFvt00WdJ23KneUFreS7+QflnKwLQId6G+bKwAUAzeyBBqO6YJbn539KPXYI0HJBvJlX6agBt29re55YxLXavY8NnHA4XpeOqe2mVWpaJvVpttGTXWeCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3afd6F/hkrmMR4Wke/5bZ52FlntPWKEoQ1yaYhIetbM=;
 b=Pv6c/DMViTyrMRzckfUs13Sck6hSsVT3wqUgfNp2A0+iGmUgu9EdWbP92Zm8eAJa/OL3TdV4qMLfPZmnKIuoBAyVQErXdrzxO/XTVFQrVfgj73VH94HBXsWTU+5Il99B7jSieCKyuXpuwVFIiZ9Ol89ekSj8QtDIl6xUJPTmUgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR12MB1674.namprd12.prod.outlook.com (2603:10b6:4:11::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 22:05:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 22:05:31 +0000
Message-ID: <b8af3d1d-5877-d213-5a3a-c1795affb007@amd.com>
Date: Fri, 22 Apr 2022 18:05:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] drm/amdkfd: Update mapping if range attributes
 changed
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220420004742.8780-1-Philip.Yang@amd.com>
 <20220422140640.26783-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220422140640.26783-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0393.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f7614e4-e44c-405e-d8b8-08da24ac37ad
X-MS-TrafficTypeDiagnostic: DM5PR12MB1674:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1674B0B676262FC85A1FFE9A92F79@DM5PR12MB1674.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duz90peWxwalLcPhA1UV+kGFRiIk8Gy7h0gNsmKQArsul/WSr9AVMYOUmP7FvYaAvEldWsxGMk9uaKwJTRJvZm1KdhgkvsS+IBmkV7xwQp5+4CEPAyb0YpW8H9COIzmmYOAJKa5L2UuO4K+aJcqCV+CvM3xrSW5zAQIbmAQjia5utOuUPRRBvIELk2pDEB7QyuEv4JsPvTnslbA6oWhcv14wuf/xc0285La5kX+s1WmOrLfstKCHxAetBlyYgtbnsyZdlIl6G0892jEx1YI4qYApZE7HKLZCMOWEEo9frB/p6/IFhZKiXnR/EE5BsqJpcTgMwjX0pd+ubCQFRUD0jTjSW351zkzxh1VtUZrQU/2rW4x326xtsEpS26X5fNRi9pxFivAZOYDv7sXQANrywZnXdcKYBIsWTNHQTlEyzunwSX+wa/ckwiwWYuW7GAHG6Mg+YUCD+Ywnq2HnGXc+Am9gBhVvu3mONsVwIRGZKQQVAgea4mapPqO9a+cQ/wnk14NWVoG1u8h/1TbL7Szy1EPZPojhwQTaD0EO/2BmQYbPZs9lRWEKRMAbtyNp0ZPMXD3fxBxMyVTrVtJvwgKVEbbDt5HH4eroV6lAegjl7O7gWEG12OYv59GYUnxZ5N0VMhLDzyQFbXDDU0XBYsGgLT9H/JHuA4Q6Rq83RJhZDEhMwURSURWWz1gg+k1pUl69t2e74RXDdNDVjcktUj1UQqWu/QWmgFydeypCjXrPMMWU6j6JATAjF0KHd+Uu3GxL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(316002)(8676002)(44832011)(8936002)(508600001)(6486002)(186003)(15650500001)(31686004)(31696002)(83380400001)(36916002)(6512007)(26005)(5660300002)(2616005)(6506007)(38100700002)(86362001)(66476007)(66556008)(66946007)(53546011)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUdyMlJMc1RJOXYrMnV6NjRnZXFtaTRLdnh5SU54ZVdTdVFkMlhPb3pzS2ds?=
 =?utf-8?B?cksxSDJJY3N0cDNpRmRaSXlFTXd5SnZjV0xnajZmK210TEZIOWVhQ3A3cjFJ?=
 =?utf-8?B?S2FpK3lya3RaSGRya3F2ZFNDUWFRdjR0SlBjYktrYWNwWUNrdUpCbEJyVE1Y?=
 =?utf-8?B?ajhWbVBEak9PZWFCd0l1dWszUkFMbXlNQUJ0c0dGbEdkaTlxeVFyOXpScmVx?=
 =?utf-8?B?d2twM0VyNU5CVGxNWkxMRlh1bk5xTFFnSmh1VXVwbGdnRVl1U0U1dndxUmlk?=
 =?utf-8?B?ZnZ3QisyWU14MXlpVEpDUFVRWU1KVEdtZG1yVVdjQlQyd0dYNnNhclhadk5D?=
 =?utf-8?B?cU56bm8vNkVGVUozNVJ4TjMrY3k5QkRDa09mMkdkVGdZanB0VjFUa29tckZL?=
 =?utf-8?B?dUVSZjIrc0Nya2cyVjBweUM4cXNUblArMllna25UVW81Y0NHSlhDVk1aY2xK?=
 =?utf-8?B?VUpwTUYzMm9IVmgrL0VwSkRFd0tNNDZ6dFI0cUNjMDd3ajlmZ0xqbVNmd2Fl?=
 =?utf-8?B?am5hemhDdEtMTkdMNjFCbmdmZk9OaFZFZnJkVlphYmNydlRvRW1KY0h2NnJh?=
 =?utf-8?B?WWdzUHFnM2dUS3VyM1pIeTZ1bHBHZjFQWFN1cE9rcnRXdTJLWGpYaUtxVFo1?=
 =?utf-8?B?blRQSi95QUdudGMzeGh0eVNJbzA3ajVuYkRMcjV5RVVmcWR2d2k3aE5XVWt3?=
 =?utf-8?B?cWlSUHk3N09OOFJJSEhZTGd2TmFUZWcxRm5sY2E1NGs0Sy9RVGxzU09uWWp0?=
 =?utf-8?B?WTE1L3pOTlNTZVF1MDF0YjBOUXV4ZDNhRVlVa2lkT25BckFtQnJlZDR5TVZ1?=
 =?utf-8?B?L3d3KzBpeXE2cXRuN2w0TEg0RGpmWktsaFV1ODhqcldvSXUyZzNsc1o5RVZs?=
 =?utf-8?B?T3I5eE1lNHpIT24zbUNkaDFFaCtyOFZjcU9uUTY5ZGVTeENhUXprbG1tM3pG?=
 =?utf-8?B?emhIRDNQak43UFo1dkhrNDRDU2pJWG5yQWo0b2MvUGJ0Tit2VGczenhKeUx4?=
 =?utf-8?B?RHVTeEFUelpjdWJvTTJsYWhWNk0rUWFoNTRGOFpmQWE4dEFoSUh5WkE1L3ly?=
 =?utf-8?B?Q3VoRU4vL20xZGtrbVAwRVF0eWF3ZkY4c0h0blN0MlRSSHkvQlhUSXVzdTZz?=
 =?utf-8?B?NTdhQkFabHdRb1k2QkFDdUpxSlc3MGk4emxhenMyVmI0UHBSLzA3aU8xTWdp?=
 =?utf-8?B?d3MyUGRmK3U1NzNaNVh5bjd1OFhCWklPQ2tjYlJUTFkxeVl5KzI3MzVKUTZj?=
 =?utf-8?B?WkZLUXhSK2tVUjVrY0w1WjE4OWFrOXh3VTdwOEw2UnA2RUxnTTdwcWlmT0pn?=
 =?utf-8?B?RUNhWEJtT21hSW9vRXA1Nk5FbHQrMDV6R0svRW52ZWJoQjlJYjlqNDJkTXJ0?=
 =?utf-8?B?WEVQZWxRNFFuaTdna1VRK01MTnROMlRmc0JQM0lGcHZPcDJTQXI0dFUxRCtI?=
 =?utf-8?B?T2xGRXhqQ1FNYnorMHBpMy9hZVR0WEpQLzBSQVpObjBEZUV3U3RXeXhSSHFp?=
 =?utf-8?B?QkxIOHVIV1NoL2UzeTEyZGE2MVg2TFIySE5kaC9jdDd4dnBOZFR5STRTWUwr?=
 =?utf-8?B?WExueUFRUE5aUERQQ2t0ZDN5QkdOaXNuTHN3RVFrY055NWFyNHArT1F0V1Vr?=
 =?utf-8?B?Unk1NkxOYXRhVk1lMHh5N2gyRDZWcVhTWS9EcEhaNUxINm9PNWRVRndxOGRT?=
 =?utf-8?B?Qm1nTlYrTUZkSzV3ODVIaDg1R2p1Y0lvYlh4OG9Sd1FhTEtNTXJnWUlyR2ZS?=
 =?utf-8?B?ajV0TTBmTXZGSDVBOUFIY3FuZXVNV3NlSWF6RXR2czN0Q0wzS2FXN3FRUDJ4?=
 =?utf-8?B?SGNqSUovZVVkeU5TTGVJeEdnNmpreE5DVnJ6KzN4RlJIejdYR0xETXR3QWYy?=
 =?utf-8?B?UTRPdmVlWDNOaE9rUHZuWU54SnMyNUNLTnZuRURWTWFoNStpN3ZLV3RDZjZ6?=
 =?utf-8?B?Q2xBRndzelpkbVhpZGx0NlNUVnpVZHI2K1VYYm9MZWllRTd5L2xQdDQ1anF1?=
 =?utf-8?B?U3p4T2RuREhURERWV1lULzBhM1Z6S3NYM2FQQWNFTlJtYWNteHBNUVF3Wmlu?=
 =?utf-8?B?aDRqQ1I0ZXZNZVV0MndualYxc1ZVTzJqR3dDWmdINlN6b3V1Rnp2enJFVkho?=
 =?utf-8?B?cERFdys5eUVGcDJSTGZSYVEzRzgvU2o4cnAxUWl5RTlKZlE4a200TC9pekRB?=
 =?utf-8?B?Rld2UUVJWFBIN3ZjejZ5VGNDTUx4Z1hiMUErYXF4QzArREh2Vm52WXRxMVkw?=
 =?utf-8?B?dzE0NGtuUnNZaWJsWnpEcHV0S21XWm94emtQZTVYWENWVXVnc2JkR1U3ZG51?=
 =?utf-8?B?bXBIdzVOYWhPN3ZQL3drZklSMS84YUw1VUtId3MzbFFJNFc5bVhTdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7614e4-e44c-405e-d8b8-08da24ac37ad
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 22:05:31.4711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rCYxQRQ/iZiJ2lQydlQG5rMqV4CQVpA3c66eDQNS1T1qELOHXB0NtanChuKOwYPzTvNM2cbY99lWQU9xTcE6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1674
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

On 2022-04-22 10:06, Philip Yang wrote:
> Change SVM range mapping flags or access attributes don't trigger
> migration, if range is already mapped on GPUs we should update GPU
> mapping and pass flush_tlb flag true to amdgpu vm.
>
> Change SVM range preferred_loc or migration granularity don't need
> update GPU mapping, skip the validate_and_map.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 46 +++++++++++++++++++---------
>   1 file changed, 32 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 8a077cd066a1..e740384df9c7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -686,7 +686,8 @@ svm_range_check_attr(struct kfd_process *p,
>   
>   static void
>   svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
> -		      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs)
> +		      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
> +		      bool *update_mapping)
>   {
>   	uint32_t i;
>   	int gpuidx;
> @@ -702,6 +703,7 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>   		case KFD_IOCTL_SVM_ATTR_ACCESS:
>   		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
>   		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
> +			*update_mapping = true;
>   			gpuidx = kfd_process_gpuidx_from_gpuid(p,
>   							       attrs[i].value);
>   			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
> @@ -716,9 +718,11 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>   			}
>   			break;
>   		case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
> +			*update_mapping = true;
>   			prange->flags |= attrs[i].value;
>   			break;
>   		case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
> +			*update_mapping = true;
>   			prange->flags &= ~attrs[i].value;
>   			break;
>   		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
> @@ -1254,7 +1258,7 @@ static int
>   svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   		     unsigned long offset, unsigned long npages, bool readonly,
>   		     dma_addr_t *dma_addr, struct amdgpu_device *bo_adev,
> -		     struct dma_fence **fence)
> +		     struct dma_fence **fence, bool flush_tlb)
>   {
>   	struct amdgpu_device *adev = pdd->dev->adev;
>   	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
> @@ -1292,7 +1296,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>   			 pte_flags);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, false, false, NULL,
> +		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, NULL,
>   					   last_start, prange->start + i,
>   					   pte_flags,
>   					   last_start - prange->start,
> @@ -1326,7 +1330,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   static int
>   svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   		      unsigned long npages, bool readonly,
> -		      unsigned long *bitmap, bool wait)
> +		      unsigned long *bitmap, bool wait, bool flush_tlb)
>   {
>   	struct kfd_process_device *pdd;
>   	struct amdgpu_device *bo_adev;
> @@ -1361,7 +1365,8 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   
>   		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
>   					 prange->dma_addr[gpuidx],
> -					 bo_adev, wait ? &fence : NULL);
> +					 bo_adev, wait ? &fence : NULL,
> +					 flush_tlb);
>   		if (r)
>   			break;
>   
> @@ -1482,8 +1487,8 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
>    * 5. Release page table (and SVM BO) reservation
>    */
>   static int svm_range_validate_and_map(struct mm_struct *mm,
> -				      struct svm_range *prange,
> -				      int32_t gpuidx, bool intr, bool wait)
> +				      struct svm_range *prange, int32_t gpuidx,
> +				      bool intr, bool wait, bool flush_tlb)
>   {
>   	struct svm_validate_context ctx;
>   	unsigned long start, end, addr;
> @@ -1522,8 +1527,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			  prange->bitmap_aip, MAX_GPU_INSTANCE);
>   	}
>   
> -	if (bitmap_empty(ctx.bitmap, MAX_GPU_INSTANCE))
> -		return 0;
> +	if (bitmap_empty(ctx.bitmap, MAX_GPU_INSTANCE)) {
> +		if (!prange->mapped_to_gpu)
> +			return 0;
> +
> +		bitmap_copy(ctx.bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
> +	}
>   
>   	if (prange->actual_loc && !prange->ttm_res) {
>   		/* This should never happen. actual_loc gets set by
> @@ -1595,7 +1604,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		}
>   
>   		r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> -					  ctx.bitmap, wait);
> +					  ctx.bitmap, wait, flush_tlb);
>   
>   unlock_out:
>   		svm_range_unlock(prange);
> @@ -1691,7 +1700,7 @@ static void svm_range_restore_work(struct work_struct *work)
>   		mutex_lock(&prange->migrate_mutex);
>   
>   		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
> -					       false, true);
> +					       false, true, false);
>   		if (r)
>   			pr_debug("failed %d to map 0x%lx to gpus\n", r,
>   				 prange->start);
> @@ -2847,7 +2856,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		}
>   	}
>   
> -	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false);
> +	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
>   	if (r)
>   		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
>   			 r, svms, prange->start, prange->last);
> @@ -3264,6 +3273,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	struct svm_range_list *svms;
>   	struct svm_range *prange;
>   	struct svm_range *next;
> +	bool update_mapping = false;
> +	bool flush_tlb;
>   	int r = 0;
>   
>   	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
> @@ -3302,7 +3313,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   		svm_range_add_notifier_locked(mm, prange);
>   	}
>   	list_for_each_entry(prange, &update_list, update_list) {
> -		svm_range_apply_attrs(p, prange, nattr, attrs);
> +		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
>   		/* TODO: unmap ranges from GPU that lost access */
>   	}
>   	list_for_each_entry_safe(prange, next, &remove_list, update_list) {
> @@ -3335,8 +3346,15 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   			continue;
>   		}
>   
> +		if (!migrated && !update_mapping) {
> +			mutex_unlock(&prange->migrate_mutex);
> +			continue;
> +		}
> +
> +		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
> +

Please check that this doesn't break the XNACK off case. If a new range 
is created, and that does not trigger a migration or any of the 
conditions that set update_mapping, we still need to make sure the GPU 
mapping is created so that a GPU access to the new range won't fault.

Regards,
   Felix


>   		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
> -					       true, true);
> +					       true, true, flush_tlb);
>   		if (r)
>   			pr_debug("failed %d to map svm range\n", r);
>   
