Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8767EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 15:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1576910FCC7;
	Tue, 31 May 2022 15:22:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A5D10FCC7
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 15:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOkL/0UBFTRwGDwVVZezyOJ8STJ1PbTQnDm9J4IpcPpU3OPjZl9GvVIqQBl/z7PAnCb5kFlGMJEeMpqslVQeCZ+p7qqKZl+YlW8AZB7skX7l2yKCALIIvVL+AfM8rLpxwGrgco812Oe7O7KecDGpvFuq6TJi/2d+8LJBVgvUYPTRKATHyUfnTdS7YCU+O1tBp4awOJlvF8NcwsoXBzo/yDTmTxjtRVG23uR2Uu5f2m/bYMa1eX+9bSHIk+QyT1i5FFUJCYTToNOP0JKKB2dyiz0uIgBgwk8fmfkOnl67mv4thkyaQzs8miIAH1CH6mljuu22WTQFOLjIhomMbzXBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yefxmrnfvsP2rYywEQul41GGeTHuc1aruhrYE00PIxw=;
 b=kKG0uEbsZT+11whv6kMp+nlnvF3B49zaSlwG4d/VhCSWq0QdVijXOqpgU47YRhO867Z3XGntbazMgt5jNFfOntQrjDYCds6UBssGtu1YkCC4tF7EQCKBnLXbGhgd+MPCVk7mwke6irqzkxs9aAb3Uckux42+Wm7nRTSgTdY93D8dER4Vg9iBHT6Ps2VMf0PxKMIkCEDiBm/RJDtdgBkkbbLWnwLN4TcQRyuGt4bM2cSGnZmL7Pxt16EPUcAcrS8dZ/rYxoarnl6pbWnfnEFJbStLRPA3HZBPBTiQsNP9i2KbkDVJTpZdScxWVZf7xHlXQ6vZg4rtm9h649h6r4QWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yefxmrnfvsP2rYywEQul41GGeTHuc1aruhrYE00PIxw=;
 b=E/BWfRr1urR+1jj7dD2UCo59GleHPX74TR+A+6kkZAbantSnR5rkwuFbYIo1eG0TygApLpqcFp76Mm1p6+barp/2+WXYRaS/1A1Y/38Lmp89ndcB4RqrVbQm/v6044FT/e1LFMpWvYLIrzfU/N982UpfYsOSWntlkUtmnkhcuqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR12MB1898.namprd12.prod.outlook.com (2603:10b6:3:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Tue, 31 May
 2022 15:22:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 15:22:17 +0000
Message-ID: <eefcf0f9-1fff-3c1d-0ee6-e33573306ed5@amd.com>
Date: Tue, 31 May 2022 11:22:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdkfd: add pinned BOs to kfd_bo_list
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220531083421.1670792-1-Lang.Yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220531083421.1670792-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 385bd856-f7b5-433d-730b-08da43195911
X-MS-TrafficTypeDiagnostic: DM5PR12MB1898:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB189876D7FF9E7E78E6AFC1D892DC9@DM5PR12MB1898.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4CcdWIOE5lO4EtouPNBXfRdwFNWgzjGAi7IODMAmiGNSRqWYf2ZAfZ9Uee7PGz9bypIWOlLJUog2lsuesIyfJ6QsfyozpkRcyPhOmXKY0A2iMdTEDAIm2WihTeAyyHpJchBkEPNOs8P8vQ6Tij0TIl6nhz9MARasDyWJCQ0JL3bRDOLhXHJpec3xduKq9ZutjZze+nbcmKs79A9jmdSeH985gQe5of2ePYWYF5wQfSHj0PsLl+VNctrnnKERY4sS6xZPqk+aDWhxh2nYnq+RqLds2z4rMjVKkz8aX3ptria7/1j1GsT81Ji2V8Vi/4o0tLN+kgozajzmqxc7x2+KeAk5GIvaUqK8NNhXSE2lFZmnhzYZ4u0kIvmb6CfP/3hHSomx3UZkT0gdvGdZNyrA8QTubDrbONJDtSYVPSK+dPmDbVDJe8mrqlTljVV2cNiNsK1nQvaMYe63QAQgLQMJR1fC5aHLYTgsDxoh0Ky/3YP3eeloJcFqVPc5tNRtAqWRnwx1qptfOikGaNtANp5lrcGkl5KsDfSz/mFfcG0DD7Zde+rEOuYOCC7yu7KPe3BG2ZS82ZP7vLO7pR3xgPdWdn5pdAj1kPRuSDw2vuA6N9Pm3cVNZh999/nV2q4AWw5yt10Eg7TzbwTl2ZvKt05mguZZX97WeiFJMpnigZTQNmui2c2TzaoAsu/j1Tf1fh6DpvUnoX3WdVfSfj6lmpPktWH53s/B1/MozaPshLfHQuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(508600001)(5660300002)(66476007)(66556008)(4326008)(8676002)(31696002)(186003)(66946007)(8936002)(86362001)(26005)(6512007)(38100700002)(83380400001)(6506007)(2616005)(44832011)(54906003)(2906002)(36756003)(31686004)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVdlM29YaVhwV0pYd21MRVAzeWNwUGVLUVN4bk41NWRWZHF1VkpaNUlZNTdU?=
 =?utf-8?B?d01jWi9zZzhSdnpwUjBYRUxkc3RPckRpNEZHd29RRjM1U3ZLckNxSEM0Y1NQ?=
 =?utf-8?B?MnVQaUIxbE5PVGFQbVA0Q1dCbklhbHN0c2Z6VlRsQUJNcDF2K0x3UkRubTZS?=
 =?utf-8?B?ZTRWNnFQTjVuNDZDUTY3L3ZOTGp3ck1EdlhDK01BQUZINmlzdWEyK1NnS2Rn?=
 =?utf-8?B?bEo3WlBycTBoV1FhU2lManBpcWM3eUMwZWlRd29mc2FDODU2MUxvN1dKM1ov?=
 =?utf-8?B?eVdOVGRqajRTY0doenNTcEN4STJ4KzR5YTdhVW1Oc0lURGt6K3dEb1J2eUFo?=
 =?utf-8?B?VDlQQjJTcTdFVHlyaXlEOFA4WmNOR095NDJ6RHVFbkNhNnBTRlA0L2JrK091?=
 =?utf-8?B?V2o4SmlSa09PT296OWVOTkEzQjNXbmFBaFB5elVHWmFQWGlkMytpdGZFcXZp?=
 =?utf-8?B?OU9YOXFZcDdQMkdmaW5oOHdVcmxud0NYblN0ZC9VejE4TnBUajBVYlVueHlO?=
 =?utf-8?B?enZhMzhQSHBPWlFGVHhBQmNmdUJELysxZDNFUjg4clV6MEpoRWxKNERWREV0?=
 =?utf-8?B?em9pSnl4S1Zpd25rWlA2cWJ3c3d6blFpMEY2Z2hpLzlwdm5hNFVCNXplUTRq?=
 =?utf-8?B?eWt6d0hIemQ0S1FQdTRpd3pyb1BjRkwzalJXSTkyZVJJVmNFUWp0cUdjMXU2?=
 =?utf-8?B?TzJ3VnRoWi9ONE1HMC9FT1k0Mmh0WG1SRCtzd2pseVhCRGNiYjlweUw1aUVJ?=
 =?utf-8?B?ZUhudXFkMWFTbUVya1ZSV3VxU3VYMWJrZ1EyL2VTNkNSQnBWT2RMcExva0lZ?=
 =?utf-8?B?ZXlKYlhpYjltenUvYTQzQ0x4OWZtUmRlQmtXSmdDbVVCNktLMnh1ci9vSWZu?=
 =?utf-8?B?ZGRRcmRmclB1bzZaaXcxT09Sc3BVYURHUkU3OXRkNFBmb1ZyKzVSeGtmeCs3?=
 =?utf-8?B?M3ZpWlpSUjNXeEQ3Y2Iva0d5dW1TVnAzRGNoQ09KRk1OR3pkanlTbTVVV1V2?=
 =?utf-8?B?Y0NuMU1HWk9BU0x4UFRUMVRrSU1mZVNLQUxybzdIQjU5UVBlclNxMTg0cWRt?=
 =?utf-8?B?eS9YdXc3QWVleWhISGJKbVAzMUJUV1IzM2hGNkthaUtxdjdHR1YvTUtoOXdW?=
 =?utf-8?B?ZGxEQ0p2WXdKVmNLNVR4c1JEZGtDQ1czeXQ3UU5OMmVUUW5CWGhySDBJNjdz?=
 =?utf-8?B?dHF2N1VnVjEyOVFsZmR5QS9mNjlIc3pzU3M1ZHBCYk5XQzROMFlpWDFBS0hJ?=
 =?utf-8?B?OWFobG04eWFYS0FpUzU3ZFFkUzU4bjJ1QitEUzYvQ3c5WjRiZU9QTnZpYWhq?=
 =?utf-8?B?UWtLSWtaZ3VVOHh1OFJkeUpPSDFGU2hKV0hUM0w5dnp6K3NlVEdaRmxra1VP?=
 =?utf-8?B?M3BEN3VSbGdEWDNjYzkwOHJMR2R1RGRGeUl4Vy9MbXQ5djNtcmorc0RkTFox?=
 =?utf-8?B?akxtczJoKzNUeCtGejNzZFpheVRjaEZHT3QrWWNqNmd2Y2p2NnpWbzFaSW9D?=
 =?utf-8?B?NjZkSGplS1BNVjl3TzllcThnYzNCN2dCUFFoeE1DMEhsN0ptSTF4RFdiM0x0?=
 =?utf-8?B?aFpvWmJFZ3c0dG05OThHM2hGMWw4dkVHYmliVmR1bFQ4NVlKSzg3R2ovanY5?=
 =?utf-8?B?UlNPK1BrNlhKNmpCbVY3YlFEdFRGVjl1Q21kSFZlWXdtd01pWmJqTHZWNWVM?=
 =?utf-8?B?YmdyajZvL084V2FTUm14UDgvdldZSGZmS1RiM0pobHo0OExjck1rd1piTWNt?=
 =?utf-8?B?OTdLbEZJbkwxMk9QZEM4UHFlU0pucWRqbnNqS243SXhoU1lQWXk5VUV2YVpz?=
 =?utf-8?B?RkpKaVRmWVJtOFVzbmhoNFlGdFFIZTdNaVB3b1hJLzdibXJYUmdtd2F2Rmcw?=
 =?utf-8?B?YWQyTjZHUVRlTGpqekJXb29oYVZuOU94QlpkYS9UeTZ5U3ozcHdoZm1haExZ?=
 =?utf-8?B?YnQvTU1IcUozaGhWZ0ttZk1BRk1LV2xHRlZVRzFFNGR6N055Q3RHV1g1cVVV?=
 =?utf-8?B?NUN6UkFvVUdmL0ZHVEZPaUNKN1N0ZmhCU2hEUmJxZis5TmlrdHZsR0ZsbG9V?=
 =?utf-8?B?UGlyb0NubDZTbzdZZUtTRExENEp5OHlHZjAvUno1RjdlMFBoTEt1U1pBQm9t?=
 =?utf-8?B?ZjBlaFpyVVNwcmIyaHdmSCt0UXVIYkx2d2FMWDJ2elQ5NDBhNkNsYmpxcDhW?=
 =?utf-8?B?aEdabGF6cWNUOWEyTzE1QjlnTDJOYTFZc0RkS1RLTFFoSDZCamVyK3RuZWR1?=
 =?utf-8?B?T08wU051WGxJUUF0VFNuZnhoLzQ4V2ozTkJNTXRXNmFSQjNMM1Yvc2ZKaGIr?=
 =?utf-8?B?ajdPdTBZOWJYVklNVGhzcmlyVGRHMjEyLytBcUEzYXFyMmFobFllUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385bd856-f7b5-433d-730b-08da43195911
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 15:22:17.5311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VA0BHfE/K+roJaeq4GJr6x+NEO8JKkthyKcxjRqZUSmOrULv6wP5XvbeTPRxm0BC9J1UnL0swlJhQo7wKRpoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1898
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-05-31 um 04:34 schrieb Lang Yu:
> The kfd_bo_list is used to restore process BOs after
> evictions. As page tables could be destroyed during
> evictions, we should also update pinned BOs' page tables
> during restoring to make sure they are valid.
>
> So for pinned BOs,
> 1, Don't validate them, but update their page tables.
> 2, Don't add eviction fence for them.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 39 ++++++++++---------
>   1 file changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 34ba9e776521..67c4bf1944d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1953,9 +1953,6 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
>   		return -EINVAL;
>   	}
>   
> -	/* delete kgd_mem from kfd_bo_list to avoid re-validating
> -	 * this BO in BO's restoring after eviction.
> -	 */
>   	mutex_lock(&mem->process_info->lock);
>   
>   	ret = amdgpu_bo_reserve(bo, true);
> @@ -1978,7 +1975,6 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
>   
>   	amdgpu_amdkfd_remove_eviction_fence(
>   		bo, mem->process_info->eviction_fence);
> -	list_del_init(&mem->validate_list.head);
>   
>   	if (size)
>   		*size = amdgpu_bo_size(bo);
> @@ -2481,24 +2477,26 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>   		uint32_t domain = mem->domain;
>   		struct kfd_mem_attachment *attachment;
>   
> -		total_size += amdgpu_bo_size(bo);
> +		if (!bo->tbo.pin_count) {

I think this special case is not necessary. Validating pinned BOs that 
are already valid should have very low overhead. So adding a special 
case to avoid that is not really worth it.

Other than that, this patch looks good to me.

Regards,
   Felix


> +			total_size += amdgpu_bo_size(bo);
>   
> -		ret = amdgpu_amdkfd_bo_validate(bo, domain, false);
> -		if (ret) {
> -			pr_debug("Memory eviction: Validate BOs failed\n");
> -			failed_size += amdgpu_bo_size(bo);
> -			ret = amdgpu_amdkfd_bo_validate(bo,
> -						AMDGPU_GEM_DOMAIN_GTT, false);
> +			ret = amdgpu_amdkfd_bo_validate(bo, domain, false);
> +			if (ret) {
> +				pr_debug("Memory eviction: Validate BOs failed\n");
> +				failed_size += amdgpu_bo_size(bo);
> +				ret = amdgpu_amdkfd_bo_validate(bo, AMDGPU_GEM_DOMAIN_GTT, false);
> +				if (ret) {
> +					pr_debug("Memory eviction: Try again\n");
> +					goto validate_map_fail;
> +				}
> +			}
> +			ret = amdgpu_sync_fence(&sync_obj, bo->tbo.moving);
>   			if (ret) {
> -				pr_debug("Memory eviction: Try again\n");
> +				pr_debug("Memory eviction: Sync BO fence failed. Try again\n");
>   				goto validate_map_fail;
>   			}
>   		}
> -		ret = amdgpu_sync_fence(&sync_obj, bo->tbo.moving);
> -		if (ret) {
> -			pr_debug("Memory eviction: Sync BO fence failed. Try again\n");
> -			goto validate_map_fail;
> -		}
> +
>   		list_for_each_entry(attachment, &mem->attachments, list) {
>   			if (!attachment->is_mapped)
>   				continue;
> @@ -2544,10 +2542,13 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>   
>   	/* Attach new eviction fence to all BOs */
>   	list_for_each_entry(mem, &process_info->kfd_bo_list,
> -		validate_list.head)
> +		validate_list.head) {
> +		if (mem->bo->tbo.pin_count)
> +			continue;
> +
>   		amdgpu_bo_fence(mem->bo,
>   			&process_info->eviction_fence->base, true);
> -
> +	}
>   	/* Attach eviction fence to PD / PT BOs */
>   	list_for_each_entry(peer_vm, &process_info->vm_list_head,
>   			    vm_list_node) {
