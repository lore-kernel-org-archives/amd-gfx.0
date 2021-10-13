Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B3DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E635060FDA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E635060FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642B389C9D;
	Wed, 13 Oct 2021 15:24:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 662B689C9D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 15:24:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4iFXcTEHoSD02dpqo9qbBf+xt1XoSAf+tLeQjWppjM/q7HL8e03rrzIOY+vIu0f6Vzhx+dsjB/6uH0VZEKDP6QHgKpG8LoVaJPUoVwehEAoHyEIsAjWKKYczdhmDIVgntJOG5MBjataNy0/XgQdbcTxs6bpSiT3ecxiy02lHnOlOUH7ixpNRoE7V9gET3XiSm5WiygwzHkkhvdjREIEOAk+TFnEndTvhpjqzgYVm6dclGxHgqbG5FIErQswuvnpsm0MHrBrn63B087cQ25wItiz4Og2alAKjGBecfFjzMYWs4crq5/Vml9ErhYbaHS4urTAsyhCWj/PK4pIR18a9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kxL4VY/s4e2LE3obMZomWN4X9M8K0IehMufdRH8hQ8=;
 b=nOM3tQz7Y8Y+4D7fdFcrX+lIoKoqFAGCFaBMVz/uT6KPCBX77EqGmr/uUq/hHCcvNVhGH89utMsXrNynB8+VpssfMOb+6LEtcAvEDAcSm7sHiEktq2hH7JnmIbvgywVoMMlMMTpleKfxcjAufTVvZXx0itjLoQTu6OuXr86cqOQ914zJjJPbzVJWCltsY2IV6t8SsPKlOjGzqReWg9eqZqZaVRMd4S+xOYCxrWyA+4NTqi9KhHl8xJLPQNVLZo1ObETPuGh1DDcafbTap2nomMRXu4/4kapQacp/0WEi7rIwlYCAljk4FH8z3wbVvWQdTONLk0uWtrSxY0FnEV9hLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kxL4VY/s4e2LE3obMZomWN4X9M8K0IehMufdRH8hQ8=;
 b=Uj5VckhBrHx3u2p53Yc3662/vtaCfpnVq25NWBxJdNVcbkH+Nloeehr47Q237ZcjBICOROfqQQYUuDqnm5aCymVVETuJZDxYhmtcg8jsp6DPQ3BsXlXwSC9Qj59cPSJdJifordx1t6DXwOhUrbVQ7bbxqKEnG2nxIWPqaiN3dIo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 15:24:47 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 15:24:47 +0000
Subject: Re: [PATCH] drm/amdkfd: Separate pinned BOs destruction from general
 routine
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20211011085837.611326-1-lang.yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <9902c8e8-bd54-d750-2030-7065e91201b2@amd.com>
Date: Wed, 13 Oct 2021 11:24:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211011085837.611326-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::31) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YQBPR01CA0131.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 15:24:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae7dd9e4-ac2c-4ce0-50d3-08d98e5d974a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3306:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3306A472E23B2B12E6A390F992B79@DM6PR12MB3306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:196;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ir2lS2BDbpuBucuq2dexAByQhi12w3JqQFG8dUqlltVnDRoosX/oiomgDWkMMcvzg32lzQTO/1t9ltq1Z4z11veVCh0ddVYf0SYC4CwEtZzoFbmqlYKk4ntgZUrjh8EA4Zv+wNoNDV4ADapqcpI2maThs8r4/zSwuIw5hyaJCb86XQ+ClUuipuijSOuZZhzWckKcEsO+WhQcez6ENTy5JQFvmD5tDKX2cthvK81hEKyi/0HiVBhLU2K0rWyHeajHBXI20Ti0W3qlMtVfju8obu2/xXMXpkQ4c0XGodK8zuc6qk72TN/i2ARj4u7zfCKxlUAWf98P9y1mgmYe8c2Gz7SigHfSbVZTPTmarD+3loVzJWCnpOZ1S3CnRz9mwzOIgdNgYVDVUM2vfRVnw1EbpnF99Kj6Zvl5O7VMFhTYbnpu/eNmhHWb3M7E64foIQ7Rw8LXZd3Hz/nBdvD7s/WLma1LHxpOP3OdE4cQeqPoM8DBewAAguXH6YgnhthUDn82SKzW/UePq2EtNns6tJitPDlxAT+7X24LAuOEpnr/woUwM5h5X9NmBzTY1vSS5UhtUd0st8B9EeDJY71NZsHXG7qJG+t1V6CG6tYZgL1xrXcemrgAKUjQhXerN/efftV5ZH571ngpf7zd8g0umWNdo7fsI1bfBratFPZRj9qEsHaWLNZqlSZIuKwnYhNthmCJQ6aO01ijGe7phapqF1WPlKOGHeli5Urqv6ht4UVhLm/sNmUzfqsBwxQo4ivc+d6R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(2906002)(8676002)(8936002)(66556008)(508600001)(2616005)(38100700002)(186003)(66476007)(66946007)(26005)(4001150100001)(86362001)(36756003)(44832011)(31696002)(6486002)(5660300002)(31686004)(30864003)(316002)(54906003)(16576012)(956004)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUtsTTY4V2s0c0E4aWw5Q2h5d3cyTnRGZlhBUUlCUU8xdEU4NzgvM3NpelJq?=
 =?utf-8?B?c0RNcHhrS2daYzYwMnhDcnhMaW5XNkNlYXB6cCtGYXFObzFQUmhmTXZzZHgr?=
 =?utf-8?B?SWxQaGNPWHpMOGFEdTg4cjVPYS9TMGZOcFlibXpXdDM4SHR5WVNSODlVc3Zi?=
 =?utf-8?B?bGI5MEk1QzlBVXp6UnYrdGUwRnM1LzVUU3RrS2VIWUV5czA2VGlVeDMrRmFq?=
 =?utf-8?B?cHlxYlFnb081MlpDdmFPZjdOcy9EWDhsM3BpUWZJalk3eHZ5ZGpUWEkwQUx0?=
 =?utf-8?B?Z05MV015R2FSWEJMZVpETXZ1cXUycnhTRGtVak04dnNvcDJ3bHNkTnF0Y2JR?=
 =?utf-8?B?Nkg2d0dFZnlscG9GZmU1VkRZbzZMWlpiRS9LZU8yRHVHUXAzTlZkaGpsNnV6?=
 =?utf-8?B?TithVWhCN3VkdjNkRzJJSXdwOUlpcythNWV5MFJBbmxVWFRuU1lPTy9nUjUr?=
 =?utf-8?B?K2hCYUVWOTljR2FDTytuNkxieFhDRUVGcnNMNkxaMkg2MWUzQ1duYnZoYW0x?=
 =?utf-8?B?V29iTlp3UFlQbFZoSmVTQU5LNGdaNU1CdXM0ZWxDOWovN3gxSjQ2OTV1cEtm?=
 =?utf-8?B?bHJHTy9xY3JlaHBhMkdPdW9scGlmcG1NNE5IVUxYZGVCZmdhSzh3Sm1pT3JT?=
 =?utf-8?B?UXBRT2ptcVB5QUp3SGJqUy8zRStnNkpSSk55ekc0Nk5sckk2UU1aUi9tRUY2?=
 =?utf-8?B?MXFNNVIwSVBKMDVTTWJqTmUrOVE0RFRtWjhMWmUvQkVPc2lKYzMxV2JwMCsw?=
 =?utf-8?B?T2JwSW4rOU1jSkg4M3U4SU52YkxMeitxSEZSazM3a0ZCekU3SW0vcW94am1N?=
 =?utf-8?B?OFByUTl1THlMUTBLeWcxa29iSEtYdE1aRDRubnBQL0JlMnBic2g1alMrTEto?=
 =?utf-8?B?eDNaMHpQbmhNaW9vaFFCT2kzS3lpdDFoTEFFTVN5bG40RzhnVUJ3azRhb0Ri?=
 =?utf-8?B?elpibzcrUHJmeE1yeU81WUxqOG9lWVVuOGZsUWFCWW02MVdxVWFUaCtEK0tY?=
 =?utf-8?B?aHVCMGgrN0RLME01RStjdG9uVmptNFpEZ2hZMHNKSUJJc2NpM0l3WGRmajFn?=
 =?utf-8?B?V09rc1kzVDVjb3YwR2NoSmtmRFk5c2J4eGwwZ2UrTVpISWNvd2FOQW9vSnBG?=
 =?utf-8?B?NWhJMUpvVVZVc050TTYreUlyS3plQVRta1NicDJraWJjNWZ6MTNmMHF2Z3Nw?=
 =?utf-8?B?TldyazRCVlRZTmhkekNDVXBmYnlQam93MDFYbzFsek5CNDNxTXl3Rml2Yk1K?=
 =?utf-8?B?RklRcTMzNllNMGc1bC82VHZmN05HcTZsMWFnQ1NBeklmb1c1RFBtMDdFWG5H?=
 =?utf-8?B?Vit4YnN3TUdxMG5xa1o2bk8vdVpKQnpaVnFFRzVySzBYZ09zTlFaOUhmWmt3?=
 =?utf-8?B?a29JZFZreHBndWI2WFF5bm9wcTdrdXZHTis5YW1aQ2tZS3FYdmIzei9kSVRP?=
 =?utf-8?B?cXNxdmw3TktrRWxhSzE2bUhiUTJicGZDK3I2cWpTWGllampvY1lPL3VEQXRP?=
 =?utf-8?B?dWJrR0ZaOHBTenk3cU56T3cvSnZkckdWdFZJWGRMTFhrSC9yOENvMVgvcW1V?=
 =?utf-8?B?c0lkTjllc1B3SzV6MVRQaS9DZjBaVWZGd3FRSzhKdHBwelI5L2JwOWpzZ2ps?=
 =?utf-8?B?K3p6SVN2ampUY2F6YkNxOHhJK2RvUEhlOVJlR0hmRjJxOVdmcnl6ZDV2Y1J3?=
 =?utf-8?B?NzB4dDVZWVhoQlNHcWtUZ2tpMFlCblNQczJmYTErbHZEcE8xbUk5eVp2VkF6?=
 =?utf-8?B?T1l5c1ZOMWRDV2FjWDlzTFhnN0REdXJKZElTamx2NmRtNDcyVnhJcW56YVJP?=
 =?utf-8?B?MDJraWtmZ3NhSDh4ZTNaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7dd9e4-ac2c-4ce0-50d3-08d98e5d974a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 15:24:47.2347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6FIjO8evK/GRCY9/jK3Baneky35zXjPCz4DPbr6Q+pYukAEgw3Zs2YvuZ8BM9wrAjiT9ng93zWJVYWQZzdZYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
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

Am 2021-10-11 um 4:58 a.m. schrieb Lang Yu:
> Currently, all kfd BOs use same destruction routine. But pinned
> BOs are not unpinned properly. Separate them from general routine.
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>

I think the general idea is right. However, we need another safeguard
for the signal BO, which is allocated by user mode and can be freed by
user mode at any time. We can solve this in one of two ways:

 1. Add special handling for the signal BO in
    kfd_ioctl_free_memory_of_gpu to kunmap the BO and make sure the
    signal handling code is aware of it
 2. Fail kfd_ioctl_free_memory_of_gpu for signal BOs and only allow them
    to be destroyed at process termination

I think #2 is easier, and is consistent with what current user mode does.

A few more comment inline ...


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  10 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   3 +
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 125 ++++++++++++++----
>  5 files changed, 114 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 69de31754907..751557af09bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -279,6 +279,8 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>  		struct kgd_dev *kgd, struct kgd_mem *mem, bool intr);
>  int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
>  		struct kgd_mem *mem, void **kptr, uint64_t *size);
> +void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_dev *kgd, struct kgd_mem *mem);
> +
>  int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>  					    struct dma_fence **ef);
>  int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 054c1a224def..6acc78b02bdc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1871,6 +1871,16 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
>  	return ret;
>  }
>  
> +void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_dev *kgd, struct kgd_mem *mem)
> +{
> +	struct amdgpu_bo *bo = mem->bo;
> +
> +	amdgpu_bo_reserve(bo, true);
> +	amdgpu_bo_kunmap(bo);
> +	amdgpu_bo_unpin(bo);
> +	amdgpu_bo_unreserve(bo);
> +}
> +
>  int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
>  					      struct kfd_vm_fault_info *mem)
>  {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index f1e7edeb4e6b..0db48ac10fde 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1051,6 +1051,9 @@ static int kfd_ioctl_create_event(struct file *filp, struct kfd_process *p,
>  			pr_err("Failed to set event page\n");

Need to kunmap the signal BO here.


>  			return err;
>  		}
> +
> +		p->signal_handle = args->event_page_offset;
> +
>  	}
>  
>  	err = kfd_event_create(filp, p, args->event_type,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 6d8f9bb2d905..30f08f1606bb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -608,12 +608,14 @@ struct qcm_process_device {
>  	uint32_t sh_hidden_private_base;
>  
>  	/* CWSR memory */
> +	struct kgd_mem *cwsr_mem;
>  	void *cwsr_kaddr;
>  	uint64_t cwsr_base;
>  	uint64_t tba_addr;
>  	uint64_t tma_addr;
>  
>  	/* IB memory */
> +	struct kgd_mem *ib_mem;
>  	uint64_t ib_base;
>  	void *ib_kaddr;
>  
> @@ -808,6 +810,7 @@ struct kfd_process {
>  	/* Event ID allocator and lookup */
>  	struct idr event_idr;
>  	/* Event page */
> +	u64 signal_handle;
>  	struct kfd_signal_page *signal_page;
>  	size_t signal_mapped_size;
>  	size_t signal_event_count;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 21ec8a18cad2..c024f2e2efaa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -72,6 +72,8 @@ static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep);
>  static void evict_process_worker(struct work_struct *work);
>  static void restore_process_worker(struct work_struct *work);
>  
> +static void kfd_process_device_destroy_cwsr_dgpu(struct kfd_process_device *pdd);
> +
>  struct kfd_procfs_tree {
>  	struct kobject *kobj;
>  };
> @@ -685,10 +687,15 @@ void kfd_process_destroy_wq(void)
>  }
>  
>  static void kfd_process_free_gpuvm(struct kgd_mem *mem,
> -			struct kfd_process_device *pdd)
> +			struct kfd_process_device *pdd, void *kptr)
>  {
>  	struct kfd_dev *dev = pdd->dev;
>  
> +	if (kptr) {
> +		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(dev->kgd, mem);
> +		kptr = NULL;
> +	}
> +
>  	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(dev->kgd, mem, pdd->drm_priv);
>  	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, mem, pdd->drm_priv,
>  					       NULL);
> @@ -702,63 +709,46 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
>   */
>  static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
>  				   uint64_t gpu_va, uint32_t size,
> -				   uint32_t flags, void **kptr)
> +				   uint32_t flags, struct kgd_mem **mem, void **kptr)
>  {
>  	struct kfd_dev *kdev = pdd->dev;
> -	struct kgd_mem *mem = NULL;
> -	int handle;
>  	int err;
>  
>  	err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->kgd, gpu_va, size,
> -						 pdd->drm_priv, &mem, NULL, flags);
> +						 pdd->drm_priv, mem, NULL, flags);
>  	if (err)
>  		goto err_alloc_mem;
>  
> -	err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(kdev->kgd, mem,
> +	err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(kdev->kgd, *mem,
>  			pdd->drm_priv, NULL);
>  	if (err)
>  		goto err_map_mem;
>  
> -	err = amdgpu_amdkfd_gpuvm_sync_memory(kdev->kgd, mem, true);
> +	err = amdgpu_amdkfd_gpuvm_sync_memory(kdev->kgd, *mem, true);
>  	if (err) {
>  		pr_debug("Sync memory failed, wait interrupted by user signal\n");
>  		goto sync_memory_failed;
>  	}
>  
> -	/* Create an obj handle so kfd_process_device_remove_obj_handle
> -	 * will take care of the bo removal when the process finishes.
> -	 * We do not need to take p->mutex, because the process is just
> -	 * created and the ioctls have not had the chance to run.
> -	 */
> -	handle = kfd_process_device_create_obj_handle(pdd, mem);
> -
> -	if (handle < 0) {
> -		err = handle;
> -		goto free_gpuvm;
> -	}
> -
>  	if (kptr) {
>  		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kdev->kgd,
> -				(struct kgd_mem *)mem, kptr, NULL);
> +				(struct kgd_mem *)*mem, kptr, NULL);
>  		if (err) {
>  			pr_debug("Map GTT BO to kernel failed\n");
> -			goto free_obj_handle;
> +			goto sync_memory_failed;
>  		}
>  	}
>  
>  	return err;
>  
> -free_obj_handle:
> -	kfd_process_device_remove_obj_handle(pdd, handle);
> -free_gpuvm:
>  sync_memory_failed:
> -	kfd_process_free_gpuvm(mem, pdd);
> -	return err;
> +	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(kdev->kgd, *mem, pdd->drm_priv);
>  
>  err_map_mem:
> -	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, mem, pdd->drm_priv,
> +	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, *mem, pdd->drm_priv,
>  					       NULL);
>  err_alloc_mem:
> +	*mem = NULL;
>  	*kptr = NULL;
>  	return err;
>  }
> @@ -776,6 +766,7 @@ static int kfd_process_device_reserve_ib_mem(struct kfd_process_device *pdd)
>  			KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE |
>  			KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE |
>  			KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
> +	struct kgd_mem *mem;
>  	void *kaddr;
>  	int ret;
>  
> @@ -784,15 +775,26 @@ static int kfd_process_device_reserve_ib_mem(struct kfd_process_device *pdd)
>  
>  	/* ib_base is only set for dGPU */
>  	ret = kfd_process_alloc_gpuvm(pdd, qpd->ib_base, PAGE_SIZE, flags,
> -				      &kaddr);
> +				      &mem, &kaddr);
>  	if (ret)
>  		return ret;
>  
> +	qpd->ib_mem = mem;
>  	qpd->ib_kaddr = kaddr;
>  
>  	return 0;
>  }
>  
> +static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
> +{
> +	struct qcm_process_device *qpd = &pdd->qpd;
> +
> +	if (!qpd->ib_kaddr || !qpd->ib_base)
> +		return;
> +
> +	kfd_process_free_gpuvm(qpd->ib_mem, pdd, qpd->ib_kaddr);
> +}
> +
>  struct kfd_process *kfd_create_process(struct file *filep)
>  {
>  	struct kfd_process *process;
> @@ -947,6 +949,52 @@ static void kfd_process_device_free_bos(struct kfd_process_device *pdd)
>  	}
>  }
>  
> +static void kfd_process_free_signal_bo(struct kfd_process *p)
> +{
> +	struct kfd_process_device *pdd;
> +	struct kfd_dev *kdev;
> +	void *mem;
> +	int i;
> +
> +	kdev = kfd_device_by_id(GET_GPU_ID(p->signal_handle));
> +	if (!kdev)
> +		return;
> +
> +	mutex_lock(&p->mutex);
> +
> +	pdd = kfd_get_process_device_data(kdev, p);
> +	if (!pdd) {
> +		mutex_unlock(&p->mutex);
> +		return;
> +	}
> +
> +	mem = kfd_process_device_translate_handle(
> +		pdd, GET_IDR_HANDLE(p->signal_handle));
> +	if (!mem) {
> +		mutex_unlock(&p->mutex);
> +		return;
> +	}
> +
> +	mutex_unlock(&p->mutex);
> +
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *peer_pdd = p->pdds[i];
> +
> +		if (!peer_pdd->drm_priv)
> +			continue;
> +		amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
> +				peer_pdd->dev->kgd, mem, peer_pdd->drm_priv);
> +	}
> +
> +	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(kdev->kgd, mem);

I think you only need to do the kunmap here. You can leave
"unmap_memory_from_gpu" and "free_memory_of_gpu" and "remove_obj_handle"
to be done in the regular kfd_process_free_outstanding_kfd_bos to avoid
duplicating that code.


> +
> +	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, mem,
> +		pdd->drm_priv, NULL);
> +
> +	kfd_process_device_remove_obj_handle(pdd,
> +		GET_IDR_HANDLE(p->signal_handle));
> +}
> +
>  static void kfd_process_free_outstanding_kfd_bos(struct kfd_process *p)
>  {
>  	int i;
> @@ -965,6 +1013,9 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>  		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
>  				pdd->dev->id, p->pasid);
>  
> +		kfd_process_device_destroy_cwsr_dgpu(pdd);
> +		kfd_process_device_destroy_ib_mem(pdd);
> +
>  		if (pdd->drm_file) {
>  			amdgpu_amdkfd_gpuvm_release_process_vm(
>  					pdd->dev->kgd, pdd->drm_priv);
> @@ -1049,9 +1100,11 @@ static void kfd_process_wq_release(struct work_struct *work)
>  {
>  	struct kfd_process *p = container_of(work, struct kfd_process,
>  					     release_work);
> +
>  	kfd_process_remove_sysfs(p);
>  	kfd_iommu_unbind_process(p);
>  
> +	kfd_process_free_signal_bo(p);
>  	kfd_process_free_outstanding_kfd_bos(p);
>  	svm_range_list_fini(p);
>  
> @@ -1066,6 +1119,7 @@ static void kfd_process_wq_release(struct work_struct *work)
>  	put_task_struct(p->lead_thread);
>  
>  	kfree(p);
> +

Unnecessary, trailing whitespace.

Regards,
  Felix


>  }
>  
>  static void kfd_process_ref_release(struct kref *ref)
> @@ -1198,6 +1252,7 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>  	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_GTT
>  			| KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
>  			| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
> +	struct kgd_mem *mem;
>  	void *kaddr;
>  	int ret;
>  
> @@ -1206,10 +1261,11 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>  
>  	/* cwsr_base is only set for dGPU */
>  	ret = kfd_process_alloc_gpuvm(pdd, qpd->cwsr_base,
> -				      KFD_CWSR_TBA_TMA_SIZE, flags, &kaddr);
> +				      KFD_CWSR_TBA_TMA_SIZE, flags, &mem, &kaddr);
>  	if (ret)
>  		return ret;
>  
> +	qpd->cwsr_mem = mem;
>  	qpd->cwsr_kaddr = kaddr;
>  	qpd->tba_addr = qpd->cwsr_base;
>  
> @@ -1222,6 +1278,17 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>  	return 0;
>  }
>  
> +static void kfd_process_device_destroy_cwsr_dgpu(struct kfd_process_device *pdd)
> +{
> +	struct kfd_dev *dev = pdd->dev;
> +	struct qcm_process_device *qpd = &pdd->qpd;
> +
> +	if (!dev->cwsr_enabled || !qpd->cwsr_kaddr || !qpd->cwsr_base)
> +		return;
> +
> +	kfd_process_free_gpuvm(qpd->cwsr_mem, pdd, qpd->cwsr_kaddr);
> +}
> +
>  void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
>  				  uint64_t tba_addr,
>  				  uint64_t tma_addr)
