Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B299DEEB566
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 18:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E889310E025;
	Fri,  8 Sep 2023 18:20:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAFBC10E025
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 18:20:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+XkeN6nTZK7+JBlyyOiIv0gFAz6trfnPVAXjoeqf8/4xHDDX968FTybMRHySb+8n3yAdV2vQwdrmUhiiVJGAWqGg3JGuVSYET5vp8dO+xSpTDJRpKf3SHC8heSOrOklRbYO7umJ0cRkenoWTwrPA7VmWzCo4YtGxfWoiBLpmAYbM06EeDJw+Ozy/4rYCodVQ/OZDby22G1yYcMsGsBLC3jrlBW5xYrJRP52iSpfiLPTqHUXG0xauLVmn8Lqf2wIN+sEZecfNf/YUDKeJDMkxGKD0dTrZyney/+n0Z6qJzlCPW8qJUWFbAalRflGB5VJG7YjlH1nWt9Cv5VLt3Zpxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zfm93dpHlKcHXrSpxZbDQB3QEozEym8cRKSReOh+Z2M=;
 b=KNvsVJBXo3EvAwe12k+g6WTrr0kPXqQ57gSD/Wp5hR5uYI8wX5gYGgis/chOWiaaNy5Rp4FY5lNaWsI7VQDMY9Gc3KQCsBARP606bkLKNgTHANkyb/qekha8vsNpUAigH1n1DU5qRjeHtCEuKOLnNO6J7u94hErLnqysd2zNZsbtqcJW7WAvMPUb02vaEgl3xkqa54Tl9eZa8CT7hVpuEOgrc6r78auakaL9pbeHPzGmtu9aSOUPzA8oj/Sx2jSdnMFrE7JFChkmt1tmk1ae5Thew6cx6dKxVCNHc1OGmdmEn5AyvEU1Lh57MFoiUJC/m5ZMCaxRR9NLiAwLCqQRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zfm93dpHlKcHXrSpxZbDQB3QEozEym8cRKSReOh+Z2M=;
 b=TZOHUvTR6n98EOEpu+cP5LQPfpJ5n0Jkku8hL2s/vEKTglatPcN4/SjiW/erXsGvkeX0fV3DDhqElrJLLho/eyppkYD4EQjASSlaw4kDf531FBbmQpeXPCxjszX8A79Tu336RjVqjynfYngxyiW23zFT4NmUypDyNfAwLDwRAUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 18:19:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 18:19:59 +0000
Message-ID: <a2c84f9a-62ba-b53e-e013-da1f9cf88444@amd.com>
Date: Fri, 8 Sep 2023 14:19:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amdkfd: Move dma unmapping after TLB flush
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230908174548.21591-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230908174548.21591-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0241.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::31) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH0PR12MB5284:EE_
X-MS-Office365-Filtering-Correlation-Id: 441e4015-1ea2-4adf-6521-08dbb098362c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDlD4qZzJLewBfOfsXcP6ZSFS7dKnvYgM3fLmqYO3+Q4gSP8YSk3P81O1vLl1eLCtqGIuEXT1Pqxx0GuuXwuJRCrS+BY3RQ1H547DXQIqSkMyDbcHOG83hbOilCnWl4XhBGol96ItdqnXitLYLfJwQeKSWJi1RovLMwVpk97Qvok3As4/BBPEksJ3avpjZAYDz7C8ufF9Ktmq+HiDBhyXaTcI3odKfaXk2lL1K42CCTvvWD/tVXRZXbyRRXX9f5zigtvyvCisUjwxW1DRNNXbdRfiuSIhPuL2kBuByKpb2FEtRuhZ8mK8HbgSNjAgGIBRhRgFUfK1EvJg5SCnJHlnztAYANpEVjLWoa6iSt3ByeeHyelsFX69SiYqKr0nYuQwHUlM6uHFxXBz6ZCVpdP9dGtmwHCXkPeALiOp1e0VuXXmZ9wsve8ZIO8anXyzb2EirxPwzj04wAxr+FFvSjqm2QxfS2yey5z6dGJvL+0bx5hwu5gbbu9bTewqgVJ6YO0t6VpIoRZG7DWh9aeAMGDQ7GHdZpqzbutOFebyIIYc2ufY1M1DBOfxExCAV+ULGDVdRL9dFNDeB3G/L7vbZzIb/B6LAiJGkJN8wRkRdLAORZRQdFGugK+3tmEJVoFXfjuw8nfVWNmjP5PtfEh1XiB6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199024)(1800799009)(186009)(53546011)(6486002)(6506007)(36916002)(6512007)(83380400001)(478600001)(2616005)(26005)(2906002)(44832011)(66556008)(316002)(66476007)(66946007)(41300700001)(8676002)(5660300002)(8936002)(86362001)(36756003)(31696002)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWlhQ2NvMDVLZjhPWUxDdVd3ZDFXRzdJZ2NKN292TTc4MEI5aUpnblN5V0Ny?=
 =?utf-8?B?U3JJckdmSUhEaEdXR3dPdXdVblpNMWRIK3MyMGpzakI1QUhnbUZDMXVKK2d3?=
 =?utf-8?B?SnV4RGVzd2JucE1Td1ZNbmJnL3JML1hCNzZyVVZyakVLQlR1RkR1Uncvbks5?=
 =?utf-8?B?RTAwRUsxcXhEVkR1NklmWDAwMVJYWXpDTjM1QzNYWVRma0VFeGRWS2ZsQ0dx?=
 =?utf-8?B?OWNhNlFNUTl4ZU9WMWhEWnYrNTRKNDVCTS9aSmdodFd0NDBmK0hVMGZHRWl1?=
 =?utf-8?B?OEtVT25RT0FVdEd3SkdsTUw4VU9KVnpKMit4N0lna01ieGhBOEJPUFA2S29r?=
 =?utf-8?B?b1lQdExkUG5WY1dpU2lheVczNVcvMG5ReWRWSWZnbGhxdWpMVTdjUnZ2QWtr?=
 =?utf-8?B?cTJQQUxRZmNkektobVhSY3JHb3JNOTNEUDdHNEF6c2xGRlNoK285WG0zZUZI?=
 =?utf-8?B?bXJNSTNWQmt6eUF3ZWxROE0wV0JBVjFDcDREWEdxN2tISnk5SEtBTlkrdVgv?=
 =?utf-8?B?MmlJa0QyS0Q2MzBkeXFFbU90SjN6ZE9UVUxvUEdFRHRreHFUREswSFREMnc2?=
 =?utf-8?B?TVBvdEVCVzZ3YlByUk10cGZzb1ZGUkxnNEQ2L1RhNmsxU2lEMzMzR0txdGsy?=
 =?utf-8?B?UTVPTk9JYnZCcGVFVmVBbGJvREZrbGlMOWRiNmVGNUs1S01UYnJUL3o3M01i?=
 =?utf-8?B?VkpTN0FneVRnbTJtMk1YNlR0ZWtQQlVKSkVBRzg1UEhVU2FsVnJCOEVVdTJ3?=
 =?utf-8?B?S0VwVXNBWU1tV1N4NDNud0lCaHZqMUl3cENBbFl4eEQ3bjJvMVVMSVFzeEF2?=
 =?utf-8?B?NUtnNGF3MTNZOW5rTXp0OEYvY0kvaGhlKzlrS2IvMEtGVTNNNzEzUFNlZ01x?=
 =?utf-8?B?Q1hEcWhaN2Z3TG5CNTJ6Q1hhZ2Fod2QyNDhkK1RBT24yS3JvWWNQSWlsNmVv?=
 =?utf-8?B?bk4ybGt4MWZNaXJtZkw1M0RJR0J1VnM3ZVFyWmpjakFIVmtFeUV1V3RDNERB?=
 =?utf-8?B?MWsxcVRtSENZRk80WXdGQnZnT1FkTnAyUXhqZTkvU2U2R09zYStwcENQQTh3?=
 =?utf-8?B?Y042UnE4UzA2TG9rZmdQYnZneHFEYURNcjYvTW1KMHc0TExjd25mTENJUDk1?=
 =?utf-8?B?aUNlN1U2U3pyMThXcElmek9wR1F5NzhURCtVNFpXQlpNZTFYSk9zUlU5YTkr?=
 =?utf-8?B?TWNLVHNsQ0JrRFlIcVc5K2ZOeittRXFUOG1pMGtHQS84UEE5SjhZVytpcXRp?=
 =?utf-8?B?V1NtVERiZVpVVlVjeVYyMHRhbWdjYzlRNHFSeGJtSUlyT2lvc05qbUFPRjYy?=
 =?utf-8?B?dWZhR1liVmlxbTl4VnlubWRvcVJBckR5SEc4VzhQbm9sOG5HY29rUHhZRDFa?=
 =?utf-8?B?NVZNZy9pOFRrZ2Ird1IvTGRTZ3BwSjczUTVBQm9lcE0wV0F6R0JLUGd6T3JL?=
 =?utf-8?B?ZVFUQWtRVHNtSjlGNG96dG16WWQ3eTdoSE43dFRQNXlVR05rbWtpQjZ3Y1ZZ?=
 =?utf-8?B?WHJkWkc3WWRxUzJRa1FCSCtoVHgzc2s2L2wwMkRISXpidDNyTGhCRCtGempG?=
 =?utf-8?B?d0FvQWxScFFrcXhOMTUxQUVHYlJFS1Zzbzh1MWt4NUtqc0pRQ2lQdDkvRVpO?=
 =?utf-8?B?UmJSUG94SEhGc2pwOTNtRW9wVWxudUhBQVo2U0J0aktIWHFYZzZZVElTS2ND?=
 =?utf-8?B?Wi9kYkczWHNjcDk2bUZnMEloZityRXpRTHMwNUdLODF5blJubjNGMVFQQzdT?=
 =?utf-8?B?aUQycVAxQ0wyMXJWdDg2UEJXVWRJajhGYjBJZXJQaktXS2dUWGpSaDMrcDYv?=
 =?utf-8?B?UFpUTWxOM2pBaUZ3MnR0MDhHaEhFQktQYWtUaGN0bkxnYmRtSTdkQUcyK0pJ?=
 =?utf-8?B?TG85QU5BZThxelVNNit0OENXZ0diY3dtbFNxOVAwdzcrRWNoL0RtcGsrSldj?=
 =?utf-8?B?dXlNL1hLZFhRMHhBVms4YkI4Z3NvdUtJMWxKZDdGVVRQRXB6R0d6enZGRHNB?=
 =?utf-8?B?Tjl3emtLYXRUWllqRnlTZVNkQzFCQkwwMW5sS25kbFVkeHFUUGVUQ2FNNHl5?=
 =?utf-8?B?bm9jZndHZ2NvQUxBbFg3TUUyMVErb0tCdUhEMXY5QkViUTBGcU9ZY1RudDJh?=
 =?utf-8?Q?x0lb9LAwJQLx3Q3lKEcUcRyHk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441e4015-1ea2-4adf-6521-08dbb098362c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 18:19:59.5120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nfM41eCevfmny5BQyeE0cg+tGRa3qYOq8SJ79lzVWa+VxLhkBkZLx+8Y9A/lf+cKjGmS/fbK4q+t426efpMRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5284
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


On 2023-09-08 13:45, Philip Yang wrote:
> Otherwise GPU may access the mapping to cause IOMMU IO_PAGE_FAULT.
>
> Remove dma mapping before free the mem attachment, to fix potential dma
> mapping leaking if failed unmap from GPUs.
>
> For queues restore path, because FW already flush TLB, it is safe to
> leave this unchanged.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h     |  1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 18 +++++++++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c       |  4 ++++
>   3 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 559f14cc0a99..9a1f8d09b1e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -304,6 +304,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
>   					  struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
> +void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem);
>   int amdgpu_amdkfd_gpuvm_sync_memory(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
>   int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index b5b940485059..3c566050bed8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1249,8 +1249,6 @@ static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
>   	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
>   
>   	amdgpu_sync_fence(sync, bo_va->last_pt_update);
> -
> -	kfd_mem_dmaunmap_attachment(mem, entry);

This probably won't work correctly when the same BO is unmapped and then 
mapped again to the same GPU.

Regards,
   Felix


>   }
>   
>   static int update_gpuvm_pte(struct kgd_mem *mem,
> @@ -1910,8 +1908,10 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   		mem->va + bo_size * (1 + mem->aql_queue));
>   
>   	/* Remove from VM internal data structures */
> -	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
> +	list_for_each_entry_safe(entry, tmp, &mem->attachments, list) {
> +		kfd_mem_dmaunmap_attachment(mem, entry);
>   		kfd_mem_detach(entry);
> +	}
>   
>   	ret = unreserve_bo_and_vms(&ctx, false, false);
>   
> @@ -2085,6 +2085,18 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   	return ret;
>   }
>   
> +void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem)
> +{
> +	struct kfd_mem_attachment *entry;
> +
> +	mutex_lock(&mem->lock);
> +
> +	list_for_each_entry(entry, &mem->attachments, list)
> +		kfd_mem_dmaunmap_attachment(mem, entry);
> +
> +	mutex_unlock(&mem->lock);
> +}
> +
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 08687ce0aa8b..fdcc55e324ea 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1443,6 +1443,10 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
>   		}
>   	}
> +
> +	/* Remove IOMMU mapping after tlb flush to avoid IO_PAGE_FAULT race */
> +	amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem);
> +
>   	kfree(devices_arr);
>   
>   	return 0;
