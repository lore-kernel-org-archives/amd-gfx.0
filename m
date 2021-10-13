Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48315C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 22:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E1D60E78
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 22:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10E1D60E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68E066E87D;
	Wed, 13 Oct 2021 22:33:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E4796E87D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 22:33:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSDQzXk23fhdFm7vp7SUNSvBOO5DpPOU2OFRd1XRwYfi/YfFQjUFNBGYX0mIPVUcf74vPibXDw0EAp75DGMXl6iBMhgUt2M0RdZ0cx0fExifEleG1vwF7pMdSB+R2QV+s/WaHSB264zmF2suw9z4HuPbs256s+xjSJm7LAAHsSf0rYCsrL4JVEGEHfjAyNhEZKvkdsv+Bt6/HZEj51CByi9QitsdPxmV+XCF0bCz2tOyC7Rz/X+VvYK2GCzhX8BC5Ul8s/eEY79dcmDl4xk++xxV84FTibiIB9jjpu2Zq6QZu++/VjfkOFtSesM6f1H6V4CRSov3HBYDaiT5Ck6/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvW0ZWwsGbBZYBHQv6i05UIOBHTgXv4ljLlpA107RXI=;
 b=jDHXa71l7P5YXVEqyDESTczTTMrreZA3vP26GjosZGBJvSRSAcpG4KHoAEZCdIHiw4CKbodAGE0zQyKVIdPTgS40ym0O73qfw3+qv/MXdhLi77Gye6HHkRSc3S8qA9g7Mqy/nlA9N0WJ81J8v7xyftNLi7ghar6bILA6ea6Skjab7yrHM2NFjrZPlaUjBG045gjctY7IpiHjPRAA5t32QsCFfrTm4eK1RdKhJ/KwH72IU6Z8TfKAC/or2km/lqX+8NbH3j0HeHm8+L7/THye5f8O3vedXhmW0aWlDO0P+n014SBjC8R5LP9T0ZN9ZqqHglBVLoyoFw/EjTHFXX1Z1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvW0ZWwsGbBZYBHQv6i05UIOBHTgXv4ljLlpA107RXI=;
 b=tqkA4iWNH4gupHVbm0I44JHOLvzy5/yIIkWKUkTe9g2au52AOWK3CpQdZiJBtmfINThuCxXtnGNt5UBwAA2L1GVSTLPDmDKGv8xq0pQ8y+1rYqsu7axB1syO/W4ObRPZW983EadahQN6/Xd4ipT3t37i90hllq6zzml9J/uUivo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 22:33:18 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 22:33:18 +0000
Subject: Re: [PATCH v3] drm/amdkfd: unregistered svm range not overlap with
 TTM range
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211013220526.7505-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <7a0a21b5-9619-f3cf-16c8-2308f9b6d46e@amd.com>
Date: Wed, 13 Oct 2021 18:33:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211013220526.7505-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::8) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0069.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.26 via Frontend Transport; Wed, 13 Oct 2021 22:33:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e56a437-59c8-43e2-fc5c-08d98e997477
X-MS-TrafficTypeDiagnostic: DM6PR12MB2938:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2938973766929455D420D46C92B79@DM6PR12MB2938.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1nfAO132gw9ljgco4fP9I286ysYGZSon/C18nUhLegrl78p30oqUOnNvnsHk3UgWlOXUBbN0cO8EZTRNUL0xgfslPbh/vdhRG9TvB87pbKR4o/T4pYQbMgBjp/pxzL0lU8kzjHhOKM+jDhD7Gy0o5H/PVMEElDr5IeS0PGlTXf5P5J59lE4iUm6Id6xAATQQ4DQfQMlAt2mkT/SACb0vxmZ4FX+WdzngOWJz+Ai1xiBrM/nOpCGiuNObCadJqTBZEe0fm5yY6rhqu0GKz5/yMDmeDeMe3i2jUoy1K4Idgmdg9b/LxVIRDul0zUsRyeLAuATEP+plge7HT2vi8Ha2HTJrEultPlCI4u9dYWzEukj8RgJaltfjn5P0KjjTugK44TDxJRnKK7HS4CIXMwrIlonvNMdecSd7zbtcCeS/SCwF55ukmDe3+Vwot4mHY6s4eYJpOveo547wT1GbuDZwwngx4cT0ScpDmE+uzKyzfLzDlcy7dc3/2GZWfEAcxwEsHiBCxeqQ7YddelxzPly/YppT4AmpUo5oEsWy8u1+16a1HzT4zYPKq8jPtQJ7olJTFj+ZcZk/iN/QHGrJ6pa/BZPS3dPb/dMJ1nuIcZGVsNATsQ//0BIFZQYqxPPvCUSzohP5W5AHYHs22Sgr9e/dFot5Vw1Xd0gwi3avmQw4x+5gOwr1NAIquwP5PPDP5RukKaIs0+SKU7/qziKAQ7QSGhzeVAYRHXdwOHePQiMB21ilU07TTG/8Cjb5zqs+5ONv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(86362001)(8936002)(6486002)(31686004)(38100700002)(4001150100001)(16576012)(2906002)(44832011)(186003)(26005)(508600001)(66946007)(5660300002)(83380400001)(8676002)(2616005)(31696002)(956004)(66556008)(66476007)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QndpdGZzYlo1Lyt5c1Y4WHdBaEZidE0rYThnclpteWJvcVFDNHMxQVczb3hH?=
 =?utf-8?B?TGZIdEtuMmJTNFFYRS9mOVZ3WnBUdC9sUGNlZi9WMC9JS2dvemlrZTBNcjB3?=
 =?utf-8?B?SE9FNS91OHdvZG1LU0ZqRUljU0hkbi85Rmlicmw2UGMra3llc3dHdWpleFlC?=
 =?utf-8?B?aEtmbjd4R0FxM2pUcDUwVjdYcWUzZzRYSGJQV3hXVTk0VkhSZUVjRzdzRGZP?=
 =?utf-8?B?WUhxLzk5WlpBdHZCWFZnK05nSGtrb0p1clkycUMwUUZHYTJicXQwT2Nsalhw?=
 =?utf-8?B?N0l2Q2NJOTFmQ1BNWG5WbklzZ3A5bmQwNVZYOVkyZitJN213S2ttZmNWNVZS?=
 =?utf-8?B?ZU9SeG9yQURsb2JQRy90MEF4cGdFRXFGVW5VdUxuZys0WlVwMkpvM013SzZl?=
 =?utf-8?B?RmU3Snh3ZW8xTmNHVkd0L0JtWkpTdnhwSlVJUjB2WFNnNHFJWWJIRzZCdUox?=
 =?utf-8?B?cUJHVVdNVVhXMDlXQ3A1QjhLQlR4N2dzWkl1bW9oUVYwaEpmRWV3SElHcG1G?=
 =?utf-8?B?bk5uemxva2wrNXhON1R1NWZFZlF6YmZ6VCs4eDJEWlRwTlJSbjdqb2taT0JJ?=
 =?utf-8?B?V2k4MTZWMXhJbEFTcVd0TzNtc3VJajZNdU5abDV1N2dENUZpSS9TbDZYMUE1?=
 =?utf-8?B?Ulc4cEFoc09vMkZjeG1rNm84dCswV215RU9RVlFQblpIbzBQbEZkeW9sWjlh?=
 =?utf-8?B?WW5tY2xUdFQ5bGlZWi9Zc29WSy9QdjdoQzJDSU9qbStHRXpqdmEyMjgzbG5n?=
 =?utf-8?B?R3ZmN0RlbjhwdklOd21LU2p2em44ZDFieHJ1STJTWE50enI4emRVTWJLd21Y?=
 =?utf-8?B?L2t0UDBwb0hnZGhpUzg4MXQ0RGxBMWMyMUVTT0ZEOENSMERPRlVkUFVlb1ZH?=
 =?utf-8?B?cGNlRlh3REJLTUYyckluSDVNODMrK3piaUlORlRjZWpkUkJoWGhtU1dTOGc0?=
 =?utf-8?B?YUdja2ZTaENVM05ka0czRXhmMW1hZ0Zvbm5UUnN4KzBGSW43ZVpRWE5GUGEz?=
 =?utf-8?B?d2g4K2cwUGVyYk1lUjh5NnluMjJiSVpmYXlTRVFqYVNENUZtVjNPWmE2cCt1?=
 =?utf-8?B?ZVpIV2dGSnVLaDgxb0cvM2IyTHE1M0Q1dU1ZaVNxR3NjMkl1N0NYUnlWcDI5?=
 =?utf-8?B?MGRwc284RkNuNmY1RzNDcFhlS2FZMkx3YVpRRnc3eHZyQVRzZXk2OGI1ZlpH?=
 =?utf-8?B?T1Nkb2NuUWZpWEFWaXBiK0hqYUJJS1F2QmVVNjZBY0ZrellXSjY4aGNNdU9M?=
 =?utf-8?B?MFBOMkV0Yjk5dTlrQTRGVjVVQmVvTDVHbUhnZm0vdERqV0s4N1RiMkdUcitW?=
 =?utf-8?B?b1NsM0grVXpXd2pDWEZDbVMxMFhudHRVcVJodWtvb0NxeVVCOVFBWTdVUit5?=
 =?utf-8?B?TVowSXM0dW9MS3VWbUlZUE5JQWN5Tkd5MUhlcEV6dG9tdEQycGRRbUNOOG5D?=
 =?utf-8?B?M0ZCeWQ3OVpVVFBnK2owdmNvWmNtM3phbm8wL0tzQjlwTTAvVm1jK2ZsVmlI?=
 =?utf-8?B?SWF5OGZvS20rNDE1Q0xDdCtOeVpLcXZjR1ZIUXpmRk9sOGNIU1JPWFRnY1p2?=
 =?utf-8?B?ck5JVmxzcGJ1MVFQczJmSUs3OEJaZEZKeG1kYzhMUGNGSWxnOStnTkc5OEw1?=
 =?utf-8?B?QSs3cEwrSHQzTmNrc2VwWEFaUXpaSUgvUS9YSTRuVHkrTjZwRFdhRnRmcGtC?=
 =?utf-8?B?bmhUL3JBbzFESUxXdG43a3ZLRWlZMzh1eXVhOTd3b1pnbVZMenlsUXYvb0Zm?=
 =?utf-8?B?ZTdWSTdkSTgxZFlabUgrNy82NGpYdUhhODl6VldkY3piMGYwUXR4RGFVeUZK?=
 =?utf-8?B?OEdwMnNSbnZmS28xWWluQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e56a437-59c8-43e2-fc5c-08d98e997477
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 22:33:18.6565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIbX1S5sCdJAKuEIvgBfKZZVx/7QJyxRzefcPWX9vvJGe4P7S6+lifeJYt5YXy5w8Q3nGf4SCw2hH+3DDdFC3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2938
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


Am 2021-10-13 um 6:05 p.m. schrieb Philip Yang:
> When creating unregistered new svm range to recover retry fault, avoid
> new svm range to overlap with ranges or userptr ranges managed by TTM,
> otherwise svm migration will trigger TTM or userptr eviction, to evict
> user queues unexpectedly.
>
> Change helper amdgpu_ttm_tt_affect_userptr to return userptr which is
> inside the range. Add helper svm_range_check_vm_userptr to scan all
> userptr of the vm, and return overlap userptr bo start, last.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 93 +++++++++++++++++++++++--
>  3 files changed, 92 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index bd5dda8066fa..d784f8d3a834 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1220,7 +1220,7 @@ struct mm_struct *amdgpu_ttm_tt_get_usermm(struct ttm_tt *ttm)
>   *
>   */
>  bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
> -				  unsigned long end)
> +				  unsigned long end, unsigned long *userptr)
>  {
>  	struct amdgpu_ttm_tt *gtt = (void *)ttm;
>  	unsigned long size;
> @@ -1235,6 +1235,8 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
>  	if (gtt->userptr > end || gtt->userptr + size <= start)
>  		return false;
>  
> +	if (userptr)
> +		*userptr = gtt->userptr;
>  	return true;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index ba5c864b8de1..91a087f9dc7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -182,7 +182,7 @@ int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
>  bool amdgpu_ttm_tt_has_userptr(struct ttm_tt *ttm);
>  struct mm_struct *amdgpu_ttm_tt_get_usermm(struct ttm_tt *ttm);
>  bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
> -				  unsigned long end);
> +				  unsigned long end, unsigned long *userptr);
>  bool amdgpu_ttm_tt_userptr_invalidated(struct ttm_tt *ttm,
>  				       int *last_invalidated);
>  bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 49c92713c2ad..95d018fe2287 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -50,7 +50,9 @@ static bool
>  svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>  				    const struct mmu_notifier_range *range,
>  				    unsigned long cur_seq);
> -
> +static int
> +svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last,
> +		   uint64_t *bo_s, uint64_t *bo_l);
>  static const struct mmu_interval_notifier_ops svm_range_mn_ops = {
>  	.invalidate = svm_range_cpu_invalidate_pagetables,
>  };
> @@ -2308,6 +2310,7 @@ svm_range_best_restore_location(struct svm_range *prange,
>  
>  	return -1;
>  }
> +
>  static int
>  svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
>  				unsigned long *start, unsigned long *last)
> @@ -2355,8 +2358,59 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
>  		  vma->vm_end >> PAGE_SHIFT, *last);
>  
>  	return 0;
> +}
> +
> +static int
> +svm_range_check_vm_userptr(struct kfd_process *p, uint64_t start, uint64_t last,
> +			   uint64_t *bo_s, uint64_t *bo_l)
> +{
> +	struct amdgpu_bo_va_mapping *mapping;
> +	struct interval_tree_node *node;
> +	struct amdgpu_bo *bo = NULL;
> +	unsigned long userptr;
> +	uint32_t i;
> +	int r;
>  
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct amdgpu_vm *vm;
> +
> +		if (!p->pdds[i]->drm_priv)
> +			continue;
> +
> +		vm = drm_priv_to_vm(p->pdds[i]->drm_priv);
> +		r = amdgpu_bo_reserve(vm->root.bo, false);
> +		if (r)
> +			return r;
> +
> +		/* Check userptr by searching entire vm->va interval tree */
> +		node = interval_tree_iter_first(&vm->va, 0, ~0ULL);
> +		while (node) {
> +			mapping = container_of((struct rb_node *)node,
> +					       struct amdgpu_bo_va_mapping, rb);
> +			bo = mapping->bo_va->base.bo;
> +
> +			if (!amdgpu_ttm_tt_affect_userptr(bo->tbo.ttm,
> +							 start << PAGE_SHIFT,
> +							 last << PAGE_SHIFT,
> +							 &userptr)) {
> +				node = interval_tree_iter_next(node, 0, ~0ULL);
> +				continue;
> +			}
> +
> +			pr_debug("[0x%llx 0x%llx] already userptr mapped\n",
> +				 start, last);
> +			if (bo_s && bo_l) {
> +				*bo_s = userptr >> PAGE_SHIFT;
> +				*bo_l = *bo_s + bo->tbo.ttm->num_pages - 1;
> +			}
> +			amdgpu_bo_unreserve(vm->root.bo);
> +			return -EADDRINUSE;
> +		}
> +		amdgpu_bo_unreserve(vm->root.bo);
> +	}
> +	return 0;
>  }
> +
>  static struct
>  svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>  						struct kfd_process *p,
> @@ -2366,10 +2420,24 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>  	struct svm_range *prange = NULL;
>  	unsigned long start, last;
>  	uint32_t gpuid, gpuidx;
> +	uint64_t bo_s = 0;
> +	uint64_t bo_l = 0;
>  
>  	if (svm_range_get_range_boundaries(p, addr, &start, &last))
>  		return NULL;
>  
> +	if (svm_range_check_vm(p, start, last, &bo_s, &bo_l) != -EADDRINUSE)
> +		svm_range_check_vm_userptr(p, start, last, &bo_s, &bo_l);
> +
> +	if (addr >= bo_s && addr <= bo_l)
> +		return NULL;
> +
> +	/* Create one page svm range if 2MB range overlaps with TTM range */
> +	if (addr < bo_s || addr > bo_l) {

If no overlapping BO is found, bo_l is 0 and addr > bo_l is true. So you
basically always go into this if-block. You should only use bo_s/l if
the return value from svm_range_check_vm or svm_range_check_vm_userptr
is -EADDRINUSE.

Regards,
  Felix


> +		start = addr;
> +		last = addr;
> +	}
> +
>  	prange = svm_range_new(&p->svms, start, last);
>  	if (!prange) {
>  		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
> @@ -2672,6 +2740,8 @@ int svm_range_list_init(struct kfd_process *p)
>   * @p: current kfd_process
>   * @start: range start address, in pages
>   * @last: range last address, in pages
> + * @bo_s: mapping start address in pages if address range already mapped
> + * @bo_l: mapping last address in pages if address range already mapped
>   *
>   * The purpose is to avoid virtual address ranges already allocated by
>   * kfd_ioctl_alloc_memory_of_gpu ioctl.
> @@ -2686,8 +2756,11 @@ int svm_range_list_init(struct kfd_process *p)
>   * a signal. Release all buffer reservations and return to user-space.
>   */
>  static int
> -svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
> +svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last,
> +		   uint64_t *bo_s, uint64_t *bo_l)
>  {
> +	struct amdgpu_bo_va_mapping *mapping;
> +	struct interval_tree_node *node;
>  	uint32_t i;
>  	int r;
>  
> @@ -2701,8 +2774,17 @@ svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
>  		r = amdgpu_bo_reserve(vm->root.bo, false);
>  		if (r)
>  			return r;
> -		if (interval_tree_iter_first(&vm->va, start, last)) {
> -			pr_debug("Range [0x%llx 0x%llx] already mapped\n", start, last);
> +
> +		node = interval_tree_iter_first(&vm->va, start, last);
> +		if (node) {
> +			pr_debug("range [0x%llx 0x%llx] already TTM mapped\n",
> +				 start, last);
> +			mapping = container_of((struct rb_node *)node,
> +					       struct amdgpu_bo_va_mapping, rb);
> +			if (bo_s && bo_l) {
> +				*bo_s = mapping->start;
> +				*bo_l = mapping->last;
> +			}
>  			amdgpu_bo_unreserve(vm->root.bo);
>  			return -EADDRINUSE;
>  		}
> @@ -2743,7 +2825,8 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
>  		start = min(end, vma->vm_end);
>  	} while (start < end);
>  
> -	return svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT);
> +	return svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT, NULL,
> +				  NULL);
>  }
>  
>  /**
