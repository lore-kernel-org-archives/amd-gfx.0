Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F87C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 15:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7CEC10F1D7;
	Tue, 31 May 2022 15:24:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CA8210F3FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 15:24:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvzIMC2MDN3pPCOHyysQsN52+mE1C1zxEuozvZLgSgpSt84TrXBZGR9vOqXPTAjttwWjcEpwePV1MuvCSY+BxEhqm4QUqU2I30jSAOw2rKPsTm+DwJvXngrpjzybe8lVnie7jF2LGRsy79DSTKOmSEcUMW1FHcfzhJR5kzaRQ7Kw/QtUKBxZn8VHBu6jOSypSBU9ggLs5MiJMm9dgLR8fCC8/2T1S1C14UQQkg+gkHGfRxPWgznOxYsaEg6Yq+FQiqi+yfc+z8MHsA3PXuirCYiDlYoZCqRKtd3W8gV5Sq4iXKEZNlNa/JxWzUxie5UXnUMhFDvd/AOn0vd7rlGy7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPK92im9xTXVE6lF4PazxAw5eTVMhaf3AhGGYvMzL3U=;
 b=VuGyShChtOf4Ypi/Gme88Ohx2OKsRcV+oTKLwumhM5u2tEHbVo/AsbfN1BFcaOKCNbfMYwyHIc5drT0T5kjWEjmAI5FGsWAnGY6B1GPg9nHu3PgZB9fYryprpuyMa6ojJYXWGu+DWn4fJrbaFqt9h3pmriuyZWMzzT3x6vt3bcef7WWXBYXbtWv8WlQtk4pZT3ESt6Zsbs1Ketl/Vusv/RK3d5KZDSSyLp9MnUPUM266K1yOalGQZpnR+zA/a29A/GdQ1Fb0GVhT8jjgo3Z5VvWscaR0RWjb/s5OqVhy8ZW1x/EfLih1LbF/o2t4YFs33VfweVInSvnI1CovWtvyMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPK92im9xTXVE6lF4PazxAw5eTVMhaf3AhGGYvMzL3U=;
 b=LfXrMtINmtP8eW42mhjGj6yDlSHZHL+YSCvl/O1S/H/bSpQlqpsiTMBM5rsjBoUL9TawbsqhZ57bmDyC+LhxYE7o7kxAbQ0212dL2rWpQBmmupTzI+d8Mvv+5FGVClxMQel5WxtkdFxDPPovE3h0BL4Y/EyI9Mmt7A8rXArnlSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB3859.namprd12.prod.outlook.com (2603:10b6:a03:1a8::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 15:24:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 15:24:52 +0000
Message-ID: <cfb2e132-3887-6a7f-82e6-5698a0245616@amd.com>
Date: Tue, 31 May 2022 11:24:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdkfd: Fix GTT BO CPU mapping
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org, Lang Yu <Lang.Yu@amd.com>
References: <20220531151405.150932-1-Felix.Kuehling@amd.com>
In-Reply-To: <20220531151405.150932-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7809b4f2-fe2e-4451-0f5e-08da4319b586
X-MS-TrafficTypeDiagnostic: BY5PR12MB3859:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB38594A4C80339EACE5515A3192DC9@BY5PR12MB3859.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xv0b+O1ZWopF7Iuh+RfkVwIoNW+0NS234gjflS0tZsGCdv/bv8Vt15ao/Ot3UHQJda3bP9xZ/jIXPGXq35gYpIZFXvXPeKwL2/Natz63Mxz+cnu2hvjipR/thuD4YO+1hz2Fk1Hn0ICa2G8Umi2TxMXRfJjcbxl5cdYfSYOlnT1iWIHLt2wNQlSvBu6+PVzmV8M5s7A4J6JDZjwxizmHY5UmcLzS/3yHtZrnQOI1b5dXA+VAQJmibvWqYxipNuVrNUBMjV2aPvma+7xgYYvMUmzfDLPjkmf3BJZ5a0ZsW+57DdeO+yaIuLi8MDqeOZpOueeO8bpOOntssSUnaJA2GzF3wo7pP4hKmjYMRoV1gDK41kZU1USi+MgLX1RMNdAw6l2lP6/R162i9mTGiKehJS2e7Zr2ugB6M75G9Inpu+MTXNq0YV67tiYin/7qU4QuYG7pYmFjHH8l/sz3d0Y/VETZRmFzUtZtYd92aEz4XKcOjlsdrnRzLjAHn39tUZI9H79kdyGyu0bujtBcaguXnAiwt1h+JStSzwVKj01LmGHRWbs1x24jU5CsfFADnBHHFxE6sH9ntadTMjnNl8xzxWNxDGMvN26GFuMdNN9AeJUqT/U674wbE1VM/YUUJ4TBS1dkZnNlGQRoDbRiox19BfAVnlGphpPGPeLCsAULbPYLRSduFOx+jen016IsJjSkM1wfSD6jS7fI3ifoXNuPOxCPGHuXRskfOxmeuJK5fpGZzSindTZFqhkHD8vPPZJl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(86362001)(83380400001)(66476007)(66946007)(66556008)(4326008)(8676002)(2906002)(36756003)(31686004)(8936002)(6862004)(5660300002)(44832011)(38100700002)(508600001)(6486002)(6512007)(6506007)(26005)(6636002)(37006003)(186003)(2616005)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUlZcEF4Um03VkF4bmp3NjVKR1FsRFp5djM5VnZhY0JOelhnM0hvWTZnblRC?=
 =?utf-8?B?MlRTM0d0Zy9JZ2tEblhDUnFXaHpnVzFtMk5SUjRxT3Jac3ZuNFE5Y3YyVjFy?=
 =?utf-8?B?MGxQeEFZUFpVUVVINWxMTUV2RWVZbVBKcDhteXJzSzdENTZ3NmdHd0dwYkI3?=
 =?utf-8?B?Q3JXWUNsVEdscENsMms1U25ZS3NnL0REWkF1VHFPQXBlblBVRFhsVXpjYjV1?=
 =?utf-8?B?bGo5eHZMYnJGblBNb1JqQ2l0cGJpRlVJbzE1aXZ2QkNEK1NKa2NGbjBFLy9p?=
 =?utf-8?B?ZXQyb2w2dUQydnh6M0tDaE1qd2syaHp0RHZSSTFyU0ZPNWhzYTVLSnlKeUN2?=
 =?utf-8?B?d0JQSWhxSm9zOGo5cEd1dlEzT1Q3cEF0eXpZQXArLzMrOXlBcG5mVWhXRFZS?=
 =?utf-8?B?Mzc5Z0h3SEM3UlBGc0JrZGR2TXpDOGJmaEpEUGUrQ2gydld4WnhIcy9rMEJl?=
 =?utf-8?B?SVN0TW90YWZ6SnhHRzhJZ2UvenBiVzF3MEJPYjlWU0hnbnNSclVsN1d0SGw0?=
 =?utf-8?B?ZXE5RzdkaHJ5ZXUwTUdXUnF5bmJTMnpwY0t5VHl3bGxlVWN1KzNNVHhWZ3gy?=
 =?utf-8?B?ZXhpeUQvZngyd3hIWXc4NkxPZ0lJMFB6SWlBUlRkUVRGRjlBNW1Dand0SWlP?=
 =?utf-8?B?ampEM0FKSWl0cjQySVR6S0lEamhHOVptN29QbkIyV01qbDdoSktpMG5DZWs2?=
 =?utf-8?B?cDRqVS8xYUdaSnltYkxlNnVGWXpKWGxlRHNld2M4RTJlYmZEWWdiUG5lS0JF?=
 =?utf-8?B?MlJkUk5NVVVsSVRiL01iUXgvcWFMdEZGcHZOOVBwWmRlYUN0ZUw3M204b21G?=
 =?utf-8?B?aUVaTU9Ma2ZLRzkxcU93L2grcVFVSXVzZW5iUXMxRFdoSWNBWVVYcW45SVpr?=
 =?utf-8?B?OVJwV1ZKUnZ6OW1aTWR5Wmh3Vy9JWFE5VkszUkRxUk5sU1dTVnpkcjZyYmx4?=
 =?utf-8?B?N1BZOXF3anBZRkZ0MHdtY2dNOUpIVzhTRFdJeWNQdUcxbVRMZjNQK2dhaitJ?=
 =?utf-8?B?TXcvRWF1RnhWVnlsVTdUSVhFNXBqR2w1dk1Ea3gxL0EwTzRTanFzQ1ZoYS8v?=
 =?utf-8?B?QStaQkU3K3pBRnlBcUNETHpGbmxKNFhwSk5OVDBCNlN0ODFvc3BMaFVwNzFC?=
 =?utf-8?B?KzZwY2hiOHpMOFltMHU5bXZwenRKWWU3SENFdWdXWWZKcEVxYXZBeGRQS0hi?=
 =?utf-8?B?UFU2VXpjWlo2ZlAzK1FHSlkrT3lqMFdSeVhmankxM09RL25ac2tGTXN4elFZ?=
 =?utf-8?B?bUFBOXM4bXd3Mkp2Um9oQTMrb3ErNzZrOUpZMXJGa3FETCtISmN2UHRHeFV6?=
 =?utf-8?B?Q0s4RjZQQWZsZ1lBZTQxWDg5TGtZL1grcUlGN1V3WjJDeC9LbmtGWDBPRVoy?=
 =?utf-8?B?V0tsUGswQ1kzekprck5UaXJyUEorKytaNE5XaGtxZzdYS1IvUkoyS2JqNHlG?=
 =?utf-8?B?c05qN3pmZHRmUi82SkE5cy9wZTlIcEw1MTg5WE9GVlRaQkN1WlQzSmlTOEgw?=
 =?utf-8?B?VnpWMVdEMUpkazFwdm5qOHVBOGRGak85VXlzb2VlRkVTaVBFamxiVk4vdUdy?=
 =?utf-8?B?N1lSUGpKMjlIKzdXTHV0WENrVGVsVHl3QTl3Rk5sNloycmx1VTFNc1IxVWt6?=
 =?utf-8?B?MDhZbjdtdWFMR3hSTkhXbGpLWDZwUUlBbkJLR2U3U2hDdWdUMm05dDJ3QlNX?=
 =?utf-8?B?eXJrSUFQTTZsbFE4TldwMkVzbFRUMlN2a2lTOU96VHZtdXBldVlMQTVlQmEz?=
 =?utf-8?B?VjlUNXZjbHFQR3Rta1FodzM3Z2IwY2d6Qm5xZkV5U2ZLdWZnOWFnbDFRSWlY?=
 =?utf-8?B?ODNBTHMyZm4wRmJ0M1kwaWM4TGI5bTkrNG5FTVBsOFpWOVpGdHVXWnZTNlBp?=
 =?utf-8?B?akp5eDV6M251eTVZcndDQzNjK2lWcWRpYVJmWTZNNnlaNENvQTJ3SE1nQ3hG?=
 =?utf-8?B?RkNzOHNvVzdoVkNsUzhHMzBrZlUzMExUbmRzOEJ4cWc3TytNNk1aWXBEQ0xH?=
 =?utf-8?B?STYxME9GcUowWURSVWRsWG83VmlwVVh6V3VTWURTZGI4N2Y5ME5Wdm12WHhY?=
 =?utf-8?B?QmVtbUpLbDZsaUJheXVyeVY1MmlxaFE1TEdZNmpjUlZTYW9iS3hUUmpxZ2lN?=
 =?utf-8?B?SS8wdXNFcFp2WEE2d3JlT1NxVlFvc0YxczhxUUh0UGIwbjgrNTJ0S3IvSG5F?=
 =?utf-8?B?NEd4aGxFWkt5Q1pvaTdqdjZuWlplbzdYbWo1anptOUJFaGdQWEUwTmVCWEhn?=
 =?utf-8?B?cUVGVjl4YnErSzRlYnBnTzNHYzFORm8vanVLdklBb2NNdExBK1lYRTJEanR4?=
 =?utf-8?B?WGtJdFdKOEpyZE9uV0UwcThQb05Xa1lqTlo2bmV4N0tvcVZ2M3FWZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7809b4f2-fe2e-4451-0f5e-08da4319b586
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 15:24:52.6457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1DncKJGAyCXI0ayYOuu3WxlW+htHHSBCNcf/99MxabmeQMf3ZC51dUUkmsSLPFbFBOL6xsTNcdiZyKzaAJY/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3859
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
Cc: Christian Koenig <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please ignore this patch. Lang's patch already handles this and also 
covers a corner case I missed (not adding eviction fences to pinned BOs 
after restore). I will update my patch later to only remove the unused 
parameter and add kernel-doc comments.

Regards,
   Felix


Am 2022-05-31 um 11:14 schrieb Felix Kuehling:
> Leave CPU-mapped BOs on the validate list to allow restoring their GPU
> mappings after page tables were evicted.
>
> Also removed an unused parameter and added kernel-doc comments.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> CC: Christian Koenig <Christian.Koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  7 ++---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 29 +++++++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  5 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  6 ++--
>   4 files changed, 32 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index f8b9f27adcf5..38c1a685cb24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -279,10 +279,9 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_sync_memory(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
> -int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
> -		struct kgd_mem *mem, void **kptr, uint64_t *size);
> -void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct amdgpu_device *adev,
> -		struct kgd_mem *mem);
> +int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
> +					     void **kptr, uint64_t *size);
> +void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
>   
>   int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>   					    struct dma_fence **ef);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 34ba9e776521..839321839ee9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1942,8 +1942,21 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>   	return ret;
>   }
>   
> -int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
> -		struct kgd_mem *mem, void **kptr, uint64_t *size)
> +/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Map a GTT BO for kernel CPU access
> + *
> + * @mem: Buffer object to be mapped for CPU access
> + * @kptr[out]: pointer in kernel CPU address space
> + * @size[out]: size of the buffer
> + *
> + * Pins the BO and maps it for kernel CPU access. The eviction fence is removed
> + * from the BO, since pinned BOs cannot be evicted. The bo must remain on the
> + * validate_list, so the GPU mapping can be restored after a page table was
> + * evicted.
> + *
> + * Return: 0 on success, error code on failure
> + */
> +int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
> +					     void **kptr, uint64_t *size)
>   {
>   	int ret;
>   	struct amdgpu_bo *bo = mem->bo;
> @@ -1978,7 +1991,6 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
>   
>   	amdgpu_amdkfd_remove_eviction_fence(
>   		bo, mem->process_info->eviction_fence);
> -	list_del_init(&mem->validate_list.head);
>   
>   	if (size)
>   		*size = amdgpu_bo_size(bo);
> @@ -1998,8 +2010,15 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
>   	return ret;
>   }
>   
> -void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct amdgpu_device *adev,
> -						  struct kgd_mem *mem)
> +/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Unmap a GTT BO for kernel CPU access
> + *
> + * @mem: Buffer object to be unmapped for CPU access
> + *
> + * Removes the kernel CPU mapping and unpins the BO. It does not restore the
> + * eviction fence, so this function should only be used for cleanup before the
> + * BO is destroyed.
> + */
> +void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
>   {
>   	struct amdgpu_bo *bo = mem->bo;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 4df9c36146ba..3942a56c28bb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -377,8 +377,7 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
>   		return -EINVAL;
>   	}
>   
> -	err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kfd->adev,
> -					mem, &kern_addr, &size);
> +	err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(mem, &kern_addr, &size);
>   	if (err) {
>   		pr_err("Failed to map event page to kernel\n");
>   		return err;
> @@ -387,7 +386,7 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
>   	err = kfd_event_page_set(p, kern_addr, size, event_page_offset);
>   	if (err) {
>   		pr_err("Failed to set event page\n");
> -		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(kfd->adev, mem);
> +		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
>   		return err;
>   	}
>   	return err;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index e3d64ec8c353..a13e60d48b73 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -693,7 +693,7 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
>   	struct kfd_dev *dev = pdd->dev;
>   
>   	if (kptr) {
> -		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(dev->adev, mem);
> +		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
>   		kptr = NULL;
>   	}
>   
> @@ -733,7 +733,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
>   	}
>   
>   	if (kptr) {
> -		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kdev->adev,
> +		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(
>   				(struct kgd_mem *)*mem, kptr, NULL);
>   		if (err) {
>   			pr_debug("Map GTT BO to kernel failed\n");
> @@ -999,7 +999,7 @@ static void kfd_process_kunmap_signal_bo(struct kfd_process *p)
>   	if (!mem)
>   		goto out;
>   
> -	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(kdev->adev, mem);
> +	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
>   
>   out:
>   	mutex_unlock(&p->mutex);
