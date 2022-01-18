Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99057C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 23:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09EEB10E61A;
	Tue, 18 Jan 2022 23:36:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9846710E61A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 23:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTC2jOlH/+qmpXi9ABQdHtEVvX3VIevVlFGKfFS38oA44FgUQm1zfIiCAhU1YEQt8YZYJfX8wiZWZBbG4VRQdnrt5z+kX7fhX3eBFQBM2f3AvEC2yFIC+P5c9TFzXc190/z8wA6lJpMUrvTIxJUUbq6GMl39Cm4h63K6N7+s62qfTHK9+OyzUQ+pzNBgiTdeLykNl9L8jrCOGuzrDoGdgpPjKizmTr5pZO9/IOSoz86R+325RTxSwl6MtJ5xSsTSo/lwrexTGq1zx8TpETkmXWpesRpH5TUL3jAt3q80Gr8NrL8O49LL4R/c6T5kU55oOV7jU1/LbO82X97BIjYG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jApU9Vv4PFgbzUcVdTQmm/tsssOOe2H/MCbe+FNhQY=;
 b=Ea6H4FBx7tIiwnnY6kXKDGmPP4yQbbjIXgiDItaKzm6Mc+IcGTFCQf/MjGw6gQGSZBlWHhmPsfHBXivg2jxlQVt7jM4TYPMHITSMcXVOOVjRBSQ4IhA4UK3F7bB65DGs/TTPZxXKXhHV2pRM57zvBUa5iAgGFDNp0El2srW2in0DjYlUgyS7fnVWVLoJbxf+jY8xRhUvDv9kFa3YYkxZSTkUZhR3dbaZJEY43oR6OyUZeH7b/8/kuCZlQHFCIRPylSWB43mtjwn4+1Mr/oESLx2f3H1i9b4MzaDvX+WhLkWNm+BUn2b1JO9XjmHAdTB1YneqHSkcdNNF2Lrw22LLBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jApU9Vv4PFgbzUcVdTQmm/tsssOOe2H/MCbe+FNhQY=;
 b=uklIZef1syVVdzV9wBG10UFRTi8i0JGJIS1mE5mscFj44451dNh4M3vjLpPiz2vbN18BPaL+VfzfFxDmyly5GZn48G3QNPxS7iu6p3sESxqreghGuAn4bM1jCMdNIiC6zplKfN/W/RjKQN04mzEpAznVZ1VblzGCvPILeWzgYb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY4PR12MB1575.namprd12.prod.outlook.com (2603:10b6:910:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 23:36:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 23:36:43 +0000
Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220118224513.26563-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b4572e2d-7898-9740-c1f6-15c22aca12bd@amd.com>
Date: Tue, 18 Jan 2022 18:36:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220118224513.26563-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e4edaaa-13c9-498b-4678-08d9dadb6219
X-MS-TrafficTypeDiagnostic: CY4PR12MB1575:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1575B0877A1E364B50D7A9DA92589@CY4PR12MB1575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t72ZC2tpb4c6lznjYiN7iU4cG/BCG7ZGgjfpwdgBL1U4UzrdObN/9mnRcKFQZ6XNBb312WGObFtSL/73zz3UZHcPMvFW8Wuy+4g/yD8G9gMc9hUvfWwRfouKbKnWs30pgvRjDiTFj5S2SIcXbZMCZod923jqA+sJY+GX6hGtyj2acpcG3wGYeFTMR3ENhBm66U16i6ZYmPh0vm8IZC0zsdX2eMgCh9ipJ17jODHYYf0WVPF7gRRJXQDi+piUXa/QtYZh+q1fgeqFC4GSrPrqad4317k+fgqCua1c8qro/tt7vS3tdttxg65xjbLODdG4OsJf8FjudCmALgZ7bFI7u59ktMrXbLkR5g4/XmYF7be7rvB8p+lLMXAkLMzSRgi1hhhvkuFzARE7tEe/aGBgcOqoGjZthZt56I3cWPstZuaSmwRr9/HIrjN7LLx99Epi9krcHgK9g4Dq0XreA+GGi265EVOO7qko9j+WKcGzNXIavzRGcvcm6K6rlpTCbLmJ3WPVLWy90mbdJ42hbzfBEcSBmSLDQCxVcppn/673BS3pay/ug4pcAyHUBUjPq/q1Y46kPY/lzFKSEmYq6HEgUg/Sprc9tARTCNUw5ZypKzov/b/B+PN5W16ImQe9mj8p9U1WtonD7lU/NmaFsxhim7NQwJIJ6G/6+E15AIK0bLHAj93TlNOuvB0Fof0NuZzNg++Z94RarN7h02QdoPUEVzg1y73ibj9q7tI9P2Ftz4urve9WZB7f5wZ0c7rzUobYMOSqEM6ENgHufjLb9g8rCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(66556008)(44832011)(83380400001)(6512007)(31686004)(31696002)(66476007)(36756003)(6486002)(2616005)(186003)(5660300002)(2906002)(8936002)(6506007)(86362001)(26005)(8676002)(316002)(508600001)(38100700002)(16393002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmVwSmhZWDZYZkRkSkdrNkNkWkxpd3ZzbHVuNU1relJudGQzK05wNjhORW9o?=
 =?utf-8?B?a0hSQUFCREpNcmp3NlRqYnhpSWl4cC9VbjJjK1I1UXVkcHhSWHhYbjJ5Z0l0?=
 =?utf-8?B?ckQ4ZFkrbHd3cjJUVzZvRlpHS2dlMHozQkppQktod2NsbjlWZzkvbk02SEZp?=
 =?utf-8?B?N2hDeTIyUEs2VUoxRXAyeEpzT2RZZW1HUytxYmtJZUZQd2ttczU0RGtFNEEw?=
 =?utf-8?B?RXk2dzRnU09YbnBESVhvV3RSZDJZMDFrNnVQTFJ2NFNqVDhlVXBXcWxTbU9S?=
 =?utf-8?B?dGRlRHV3aVBOMCs1UDNWNTdrNWQ4UW13bHlicTNydkVYUE9XcjYyb04wM0di?=
 =?utf-8?B?YW5qSnFKOFh6dlZ0MmJLT0pnaHRCa1VTK09wbWwzVnBpU1QvNVdOREl4V3Zl?=
 =?utf-8?B?d0Y1MjVOQXNaK2tPRzZVYTJ3S1hXMnk1bUo0R013bVJ1UFVMUkI4K0FYb3NC?=
 =?utf-8?B?QUw4dWlhRGVDOXhTMHRNTTQweE5HY2NjQ2ZGTUhlUnh6VndkbDlDbGllNi96?=
 =?utf-8?B?aTYvWFVMMG9qOWRZODBhaEpHc0g0SVBFNmh2aWlKanVvMDlXT0k5bk5kaXhI?=
 =?utf-8?B?d1ZPcVFxMXBsWUp1ZVBWbENxWEVRNzFseEEyYXNLNklsQW9ENnd1Yi93d2ZN?=
 =?utf-8?B?QkZjR1c3OFh6NjF0bDVUeGNGRnRqZjVDN0oyU3BmcUxaN0JPc0MzMWU4MnBI?=
 =?utf-8?B?TExFTTRhc3BzbnZPN2h0ZG1Rci80UnlqaVRnbTdvQmhUYnUzNmRvYzNWNXpl?=
 =?utf-8?B?R0h0MDhvbDRHRlJBRUNFYUljYytkNWxvWnR1WHpDV2p2S2RJOFJyZFEzRHpM?=
 =?utf-8?B?NUJ3bVgycWtnZklnUERLenYzS0NKWmN0NXV2b05CZTRyaUdiUU1zQytnc3lu?=
 =?utf-8?B?M2lDcFZYZUp5LzZFcHhUNC9CeHFLcTdGYmoyT2dneTBjSkIwZSs2dkw5QS9J?=
 =?utf-8?B?Q3pNR2V3N2ZhUEJnZnQ3aDhDcDVJSjNnNXFDMVk2QytyVVFEWnpqZ1oyVzc2?=
 =?utf-8?B?blVNMjNWTFpvamdQbm1rTVk4dC9kR0V2QnJoNE9LMFZ3UGhqdCtZMm1OeHYy?=
 =?utf-8?B?VzlhdXpPNEN6NDJTcUhEcVFOUVBoOEpvQnFFMEJKc1pkOFQ3dUlzQjhDTmlz?=
 =?utf-8?B?WXcwTHFPTjlyQlN6TXBpaVdoMjV0RG1jN0xHOGpQTE1scGhtakJVc0Nock1t?=
 =?utf-8?B?Tjh1TU12Uzh2d3JpRVlMUTlxT2FWOERUeitMRXNFbTR0ZEJpY2VSR1RSY2cr?=
 =?utf-8?B?VXVlVThlajQ0N25vckkrYWpiV1Z0Sk9yZzRaUkhtVkNXckZxcm1jNzNzVDZh?=
 =?utf-8?B?b01maGNjVTJEYzJwV01KTGNJRTRFWnNrY2V0blExQjdpQTR6dFl0bmtQc2JH?=
 =?utf-8?B?akFPdHVpaGx2clFodWFNS3BVT2pRSTJKTEdaSVJGMzFiSlJPMHhWcG1KVkcv?=
 =?utf-8?B?allHWXhLMHp1K3ZtNCtOOVNTbXViOXNrV3VnU1dyK2Fxcm5hMGgxZHRPMm1N?=
 =?utf-8?B?NjhFcnZ3NXB6c0hjT3JVdlNMdE1rMXRJZms3MTM1clpCalNHQkdYTkpGRTBs?=
 =?utf-8?B?MU9qQW5xTDQxSXlZYkgxemtZNUJxZ0xuMVlZZk5veDNjTjNDamQ4SnJPRzBM?=
 =?utf-8?B?QWF0bkJPR3VWL2o2NXNZemo2c3lBS2VzcDhMY1o5UlhGcXdwU1J4cG9zeVRy?=
 =?utf-8?B?SVllYlpoOWtrSTRNalJ6OFNUWGVqUVR2aThxbnJhKzBLdUxrK20xYVVHOURo?=
 =?utf-8?B?cWQ4SVJkc1dYL0pmbStMRVRzckhIMUsvT1FNS0k5cHc2SVYveHl4OXNadU01?=
 =?utf-8?B?elZTNDI2L3JiN2EvL1FTbDc0cjhleUZUalhLN09KaFQ1akJpU2l6bDdXekF2?=
 =?utf-8?B?ZXZNL005c2NmeXRNQlpwcXBNcTNCTkFXM3lISmN5MVVnWTJBbmVsbUw3eSto?=
 =?utf-8?B?emRPamRZNTRUZDVpM0Ezd3hZeWUwK1FIc25WVC8xZkVKSGVNRHVQY21wUDRq?=
 =?utf-8?B?WXJzU3R1YVk3blZ4aGU3b214SFlnbFMvQzAxQlMxdFdkUWFDTHRDTTU4V3ky?=
 =?utf-8?B?eUx1RklqcDVmZzh6VkJ1MnlzY3FKTUZmZlNEclZyNTBGTE1vcGl0bE9tN3da?=
 =?utf-8?B?WVJ0SmhJdCsyeUdXUWhTcy9GUUhBcWVWM1daUlBDaTZ1cFpxWmRTMFF5emVj?=
 =?utf-8?Q?ykGo0y0ya8jMtLnyj3RhjE0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4edaaa-13c9-498b-4678-08d9dadb6219
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 23:36:42.9730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvaONF7l2rDB/Bak9bzNd19Y+ASl8VCgyIrBWaxYdoPYqdpGl8LzJIRCUQOIqwFAqwIiMmVkZLKkToZAQ6PKHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1575
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

Am 2022-01-18 um 5:45 p.m. schrieb Eric Huang:
> SDMA FW fixes the hang issue for adding heavy-weight TLB
> flush on Arcturus, so we can enable it.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  6 ------
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 10 ++++++++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a64cbbd943ba..acb4fd973e60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1892,12 +1892,6 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>  				true);
>  	ret = unreserve_bo_and_vms(&ctx, false, false);
>  
> -	/* Only apply no TLB flush on Aldebaran to
> -	 * workaround regressions on other Asics.
> -	 */
> -	if (table_freed && (adev->asic_type != CHIP_ALDEBARAN))
> -		*table_freed = true;
> -
>  	goto out;
>  
>  out_unreserve:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index b570c0454ce9..485d4c52c7de 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1596,6 +1596,12 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>  	return ret;
>  }
>  
> +static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev) {
> +	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> +	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> +	        dev->adev->sdma.instance[0].fw_version >= 18);
> +}
> +
>  static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>  					struct kfd_process *p, void *data)
>  {
> @@ -1692,7 +1698,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>  	}
>  
>  	/* Flush TLBs after waiting for the page table updates to complete */
> -	if (table_freed) {
> +	if (table_freed || !kfd_flush_tlb_after_unmap(dev)) {
>  		for (i = 0; i < args->n_devices; i++) {
>  			peer = kfd_device_by_id(devices_arr[i]);
>  			if (WARN_ON_ONCE(!peer))
> @@ -1806,7 +1812,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>  	}
>  	mutex_unlock(&p->mutex);
>  
> -	if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
> +	if (kfd_flush_tlb_after_unmap(dev)) {
>  		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
>  				(struct kgd_mem *) mem, true);
>  		if (err) {
