Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8077CC25B47
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 21:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA4F10E3DE;
	Tue, 24 Oct 2023 21:02:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6794310E3DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 21:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlK+0bvPEj50zMwSP3APoYJki3xuLaPokOFYwjH24BvlUoAZejDLSlNjZpaDkGE8r3uwyKCQhNGQR5OD91qnsXKlbEv7DtD0nQ79k2/zsKVP6uzq1ljxtbdsr+cXkB8rW8eCx2P5xhFpsMmf6qs1P2Oyo6xSnUivtL5RfcQSeE6QdOVbjtNlyq/K8Jv6V/LvcGjZRZ4Ear6iPKlJITldOgfYnuulrRXDf/EYkvBt54P7kkYZjiHsWvUomAo/JQZmlMUW/cVfkALY346/fBtXdbphGeUHvxvsZ03j93LpY3ewKTMKceNpkMWi/u0UtKMXELxehRAj1eZ0CnincMXJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ju/hVKR2xxBKACJhlOsvjIWzQdjhiZ1N03KTxTFFyJM=;
 b=KSvNHV28L1ynfc41W7I9jRY9B9DjmBDRcab5Jyn113YwTnmzSFnzHpoOJR8JoeQ0SKT6BLhj/1tU6q1dYRRJgzOxicMRjp4WL68/jpw0bmIE/v7aaSzuZHkWca/QKl3RtbPjSVmOvbabF3Df24sA8UoTv42HHO5j7hpSX2Dou+zS3nRA901BkpE91VTXtLfylfv7A2ZDyUQFoHPLXpW1OKUMtuZu998OTVy8CCeGYsDLeaWk6rJJXLQtC8CO+BwiJOtAQFeUGoULEonqQvy1vXqlUQq6KHT6Tluy7LsWfDSSKWuhqSFgHxiKUc4Hc05axogKAYnFtnIWpXPLxRmF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ju/hVKR2xxBKACJhlOsvjIWzQdjhiZ1N03KTxTFFyJM=;
 b=WpkSEPMpbZqxQ2zNvrYU/XIOvIazJ7hs6gJP8oJdwvlRl0c5I5jA5SZm92M0u7ybmNFcrJUjuiVk+BH63qpl57yRVzhjnYlBwEWXTD4dang4peEWIPkNIpGQbBs45WFV/o0eAe3Y1N6DqUuev62sMbs/CoGNgmtyKiyIaoj0ICw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 21:02:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 21:02:43 +0000
Message-ID: <8d71fb78-cafa-42f2-b1ef-c89fbc565961@amd.com>
Date: Tue, 24 Oct 2023 17:02:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Acquire ttm locks for dmaunmap
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, David Francis <David.Francis@amd.com>
References: <20231024192043.400319-1-David.Francis@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231024192043.400319-1-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: cf021974-f1b4-4a86-1aed-08dbd4d49123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWTamfkCjyfarKxAJbU6GzzRhmR8+B00OgaJwtq+AymbGA0YOUdOl/4mfrZtO99SkpMbAgnP90jAppEBngD46i1eGaDBqFS8pLd5ZCw1GwhUIw68MpxykvGqG+4foNFoOloTVXj2tfZZggB1FKa9UG8+0N4dl1vG35XNCGPiOQArUyJ+xANiwW9ZG5LXbE/x28wlVEszUjM75xjPgOr+FYr/Cg7Jqo9tf7wXNspCFhbKal85NZ5cfr1w8G7IxqHckJx4GurQMc87gmCe9yEfHvK0o4MGEXQiJtV8C76kg5EBzAip1IRNhSPmi/XSfvFnHM9mHOMKM9oV3kRVMIDyyaATBD/5J00P5iDzGzlDt2fjs6SptHRo5A0TIwbhxmaUDJ/NKUvwzKJaN0g9QYjrRM1ZE97/rVXnjuJTu4FNVtYqIO19anJqedPCc1zxPeR3lABw+CY6xB/prKQWwgCbAivXHGjSMj+WkNiGCCB4EYvTRdX0rFEMLDYveFmIGcDO8/a+hY32+4yBhlsn2bKEr+qfaqrkyemvGf+RTHdBIGK8uQNVRLVz4tamuLmaEF0cW0TUm2w/gDtxhtL5UZ1+u7ZYMPz1quFwM5gb9f3GqQZdw47zISywFG7pSGfGx/3qYUNc6jstcB+n8cFXli6uwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(4001150100001)(5660300002)(66476007)(66946007)(37006003)(86362001)(41300700001)(66556008)(6636002)(6506007)(31696002)(316002)(36916002)(6486002)(478600001)(6512007)(44832011)(36756003)(6862004)(8676002)(2906002)(38100700002)(2616005)(8936002)(26005)(53546011)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3N5QVZkM2wxNnVuWFhtbWIrUXNvdnErS1BOUXgydTVpckxXWUhoUHdiOGt5?=
 =?utf-8?B?U0RPNWJ6YkI4c2tOQS9vZHplaHplb2Q1cnpFMlFSTDA3NmNoUjhNUndOcXht?=
 =?utf-8?B?aDNrUVppRS9LM0s1V2ZwRmNmR3BPc1g0VFdVUU54eXRPQlNMaGtaTFNoUE90?=
 =?utf-8?B?RVJJSmltR3UvWmh3M2dpSUMyT01vU1RKeDFwSDcwZEFLUjlUK2p5QzBVVjRs?=
 =?utf-8?B?Qm9LNVpDckdwZ24xSDI1cGFMZzFFTVUxQU9CZVB0T0ZlcUxJZVlDbXd5Y2xI?=
 =?utf-8?B?eVlrWHBlWjUzUEFWRFlQSU9ubjRzMkJtTHg1a3dycUtOM0pqU2pBRkxUZGY1?=
 =?utf-8?B?T2tGVXlBTS9ja004NGduTTljUjJKYVlwT3dDT3Uya0ZoSmdoMnNhUFJrSkJq?=
 =?utf-8?B?QVdqYmcvZ2N6cHJnOGtoV2ZRakQwV2NwcVcwSnJWU2p6b0szZGEwS3BGRWdr?=
 =?utf-8?B?N2dTRm5Hajl5bWo1aHc4QitTUkVqZXJLS1JRT3VKTlgxdVhGTzduQ0h0N2Q3?=
 =?utf-8?B?N1BUMkdSa0pPOUFHQm1MRDFpVUZrOHVwNWRuOW96enpRY043ajlxOFlHSzJr?=
 =?utf-8?B?bVZlVXFKTlFzZE5mRkVuUFk1eDhmRmVKZ3Q4eDB0a01Ta1ZJWnVJb0tYUjVW?=
 =?utf-8?B?QnQwSGZjSjZCanBIYzdxQms4ZVN3YkhGc2xhOW9PbG1SdzJGUEREUko4dmwy?=
 =?utf-8?B?NXhkZXlvMzQwRzdpaDdmZU85OU1xVUxxU09NTkdkNEEreEhnZXpQZnk5cEhx?=
 =?utf-8?B?c3FJVkhkYzRXcTdXNmJQQ1RURkN0aWhtWXMwaGlidE4wWTNYZXRZRDdkakVS?=
 =?utf-8?B?UVpoYm5BRThQUXJ0dnBRMi9sQjZWNm93YzJxSS9QVFEwYWgzTDR2djcyR2hv?=
 =?utf-8?B?eU1reXBLUXJjV1cxMnR6cDVBQ0ZUV0xLWFAzbGU4RUh0a08wdlFLS0NHV3dX?=
 =?utf-8?B?MmRELzZCK3R1TkN5OHVjUDU3K2FKVC9hYUxWOUtobFpQRW5WeUMweVlOWG90?=
 =?utf-8?B?di9WRXBrWmFlcFZXd3ZIM2YrdkpyVE55dnJpa0l6b1JTNVB4T2xQS24yanlF?=
 =?utf-8?B?OHY4djE5Vyt3M3FnQVdtZ1ZDMGNqM3J5RlNPd2x5bUhGYmpWM2kvY2kyVmFO?=
 =?utf-8?B?TDN4VU1vb1I5ZmpSUkJPUEFZSWxQWHJQMkd5WDRBdnZxRDR3ZFVkRGswMTha?=
 =?utf-8?B?VVRweUZqK0NibXFLSDFSc3V2d1J1RWtMckQxcHZvOW9NeDJORlRiS0RNNlhW?=
 =?utf-8?B?T3J4OVgrSzdDSTVTQ3RyRDIzc202OThOQWI4NWU4Umx5TkM0Q0pmeHJRUGpk?=
 =?utf-8?B?UW1WZ1pESzFkbVVmZW8zUlY5VzdjRGN0K2RCbzlMREZad2IzdkZSK3h0VXJC?=
 =?utf-8?B?bjd5bnJJcmJBclR4SmhuczdCUVlpQjZiUTVHKzk4WERnQUhjUWJqVWxlN0FH?=
 =?utf-8?B?Rm91QXFpWVcxTGNENnpzRU03Z0twaEZpUStjMitPTFNtcEtKeE1hY2J6MVpa?=
 =?utf-8?B?WGF3NkN5c1ovK08yRWsveTNpcmZsSXMyZzY1ZnJBV3hwODllbjkxbDJsUXk4?=
 =?utf-8?B?eVdGejAxbjhhbVZsMCtXY2s4SmwyVEtMOFhzWmdhcU5zWGtiMTRTYWFtRkRm?=
 =?utf-8?B?TEJZR2JOVmh6TTg3NTFJQ2o0bXJxUkZON3JvTHNsYkVNaHdSa2o4eVFYWWU0?=
 =?utf-8?B?bVFQTEJyM2JrSlQ1RkIyN2QxWCtlYmdzc3lrOXlBTlQyUm16VlI5b3hLelJ5?=
 =?utf-8?B?WER1eVU1eHF2eHF2S3BNaEFENUFLQTd4QXZCV0xJd0JrNnJNRXUyK3FOQzVV?=
 =?utf-8?B?ZUtzMFE3Nnp0QkVnUWhqakhpc2RPMEZqN0VtVDdjOUpHdmZuZDRYN3Uxb2ov?=
 =?utf-8?B?S1J6NGlxeTZHMnJ0bDFOdk0rN3RMMjY3eE9Td0NDSFRxVG1TT1hBbDhPQSt5?=
 =?utf-8?B?bTBqNFR5dXlySlYxNDEzaXRCSjdhWkM0VDFEYUNDejcxeHZ3QzhjSE9iZzVp?=
 =?utf-8?B?TldrV2tFVHFVWjV2b042QkVSazVxczUvTElVR3gzbzlyLzBXM3JQY0dSVjJz?=
 =?utf-8?B?cnF5aXFHQi9OcHZYQW5YdkVaV0x3OTYwSHVMNjJPczlPMXo0YXltNktMcUgv?=
 =?utf-8?Q?A0FNll3L6SNcUpPuoygfkipR1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf021974-f1b4-4a86-1aed-08dbd4d49123
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 21:02:43.7069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrHm01zZjmfPIwcRIv+diBJcboUbNi4uIIlTigXdHyr3JXn3rQAKncZu4BPxxM39mR/hN9UD3P9s7DxFDUmQxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019
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

On 2023-10-24 15:20, David Francis wrote:
> dmaunmap can call ttm_bo_validate, which expects the
> ttm dma_resv to be held.
>
> Acquire the locks in amdgpu_amdkfd_gpuvm_dmaunmap_mem.
>
> Because the dmaunmap step can now fail, two new numbers
> need to be tracked. n_dmaunmap_success tracks the number
> of devices that have completed dmaunmap. If a device fails
> to dmaunmap due to a signal interrupt, n_dmaunmap_bos tracks
> the number of bos on that device that were successfully
> dmaunmapped.

I think what you mean here is "tracks the number of attachments on that 
device".


>
> Track those values in struct kgd_mem.
>
> This failure can also cause the sync_memory step of the ioctl
> to be repeated; it is idempotent, so this should not cause any issues.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  6 ++++-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 23 +++++++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 19 ++++++++++-----
>   3 files changed, 37 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 3ad8dc523b42..c60564ec4312 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -86,6 +86,10 @@ struct kgd_mem {
>   
>   	bool aql_queue;
>   	bool is_imported;
> +
> +	/* Used to track successful dmaunmap across retries in unmap ioctl */
> +	uint32_t n_dmaunmap_success;
> +	uint32_t n_dmaunmap_bos;
>   };
>   
>   /* KFD Memory Eviction */
> @@ -302,7 +306,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
>   					  struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_sync_memory(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
>   int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 54f31a420229..c431132d7cc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2102,21 +2102,36 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   	return ret;
>   }
>   
> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
>   {
>   	struct kfd_mem_attachment *entry;
>   	struct amdgpu_vm *vm;
> +	int ret;
> +	int i = 0;
>   
>   	vm = drm_priv_to_vm(drm_priv);
>   
>   	mutex_lock(&mem->lock);
>   
>   	list_for_each_entry(entry, &mem->attachments, list) {
> -		if (entry->bo_va->base.vm == vm)
> -			kfd_mem_dmaunmap_attachment(mem, entry);
> -	}
> +		if (i >= mem->n_dmaunmap_bos) {
> +			ret = amdgpu_bo_reserve(entry->bo_va->base.bo, false);
This will lock and unlock things that aren't needed. This should be 
inside the "if (entry->bo_va->base.vm == vm)" where it's actually 
calling the dmaunmap_attachment.

> +			if (ret) {
> +				mem->n_dmaunmap_bos = i;

This counting approach feels a bit fragile. Also, what you're counting 
with "i" is not the number of attachments per device, but the number of 
attachments overall. So this double counting with two counters in two 
places is probably redundant and could be simplified to using just one 
counter and in one place.

But this may still have issue in corner cases where multiple unmap 
ioctls are happening concurrently. I'm not sure if this happens in 
practice, but it's something that a robust implementation needs to 
handle. The consequences of getting this wrong would be resource leaks 
or DMA mappings or potentially double-frees of dma mappings.

What would be simpler and more robust is, to have a flag in struct 
kfd_mem_attachment that indicates whether it is currently dma-mapped or 
not. If it's not mapped, you assume it was already unmapped and you 
don't unmap it again. That way you wouldn't need to count at all and it 
handles concurrent calls without problems. There is already an is_mapped 
flag there. You could add an is_dmamapped flag.

Regards,
   Felix


> +				goto out;
> +			}
> +
> +			if (entry->bo_va->base.vm == vm)
> +				kfd_mem_dmaunmap_attachment(mem, entry);
>   
> +			amdgpu_bo_unreserve(entry->bo_va->base.bo);
> +		}
> +		i++;
> +	}
> +	mem->n_dmaunmap_bos = 0;
> +out:
>   	mutex_unlock(&mem->lock);
> +	return ret;
>   }
>   
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 06988cf1db51..66dee67ad859 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1366,7 +1366,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   {
>   	struct kfd_ioctl_unmap_memory_from_gpu_args *args = data;
>   	struct kfd_process_device *pdd, *peer_pdd;
> -	void *mem;
> +	struct kgd_mem *mem;
>   	long err = 0;
>   	uint32_t *devices_arr = NULL, i;
>   	bool flush_tlb;
> @@ -1400,7 +1400,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   		goto bind_process_to_device_failed;
>   	}
>   
> -	mem = kfd_process_device_translate_handle(pdd,
> +	mem = (struct kgd_mem *)kfd_process_device_translate_handle(pdd,
>   						GET_IDR_HANDLE(args->handle));
>   	if (!mem) {
>   		err = -ENOMEM;
> @@ -1414,7 +1414,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   			goto get_mem_obj_from_handle_failed;
>   		}
>   		err = amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
> -			peer_pdd->dev->adev, (struct kgd_mem *)mem, peer_pdd->drm_priv);
> +			peer_pdd->dev->adev, mem, peer_pdd->drm_priv);
>   		if (err) {
>   			pr_err("Failed to unmap from gpu %d/%d\n",
>   			       i, args->n_devices);
> @@ -1426,7 +1426,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   	flush_tlb = kfd_flush_tlb_after_unmap(pdd->dev->kfd);
>   	if (flush_tlb) {
>   		err = amdgpu_amdkfd_gpuvm_sync_memory(pdd->dev->adev,
> -				(struct kgd_mem *) mem, true);
> +				mem, true);
>   		if (err) {
>   			pr_debug("Sync memory failed, wait interrupted by user signal\n");
>   			goto sync_memory_failed;
> @@ -1434,7 +1434,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   	}
>   
>   	/* Flush TLBs after waiting for the page table updates to complete */
> -	for (i = 0; i < args->n_devices; i++) {
> +	for (i = mem->n_dmaunmap_success; i < args->n_devices; i++) {
>   		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
>   		if (WARN_ON_ONCE(!peer_pdd))
>   			continue;
> @@ -1442,8 +1442,14 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
>   
>   		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
> -		amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
> +		err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
> +		if (err) {
> +			pr_debug("DMA unmapping failed, acquire interrupted by user signal\n");
> +			goto dmaunmap_failed;
> +		}
> +		mem->n_dmaunmap_success = i+1;
>   	}
> +	mem->n_dmaunmap_success = 0;
>   
>   	mutex_unlock(&p->mutex);
>   
> @@ -1455,6 +1461,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   get_mem_obj_from_handle_failed:
>   unmap_memory_from_gpu_failed:
>   sync_memory_failed:
> +dmaunmap_failed:
>   	mutex_unlock(&p->mutex);
>   copy_from_user_failed:
>   	kfree(devices_arr);
