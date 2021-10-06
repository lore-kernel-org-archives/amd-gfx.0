Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EEDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 17:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881E8603E7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 17:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 881E8603E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E9246EDCE;
	Wed,  6 Oct 2021 17:22:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBE3A6EDCE
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 17:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIMeZfNhJqAyvZ0UKuuSF3E8iHQ+jpwd8LDD2tnnPkxVgz4LAMYl1XH7do2Adibk60FfP2YwjgY+VUmiCo4kqbmeThy9q1LYR+JxhqmRI9uqq29yTSJcX8XyCEUl4tQdRVIbqrZkXIdCbu5pKMoxbwq/MoJBB7TAki4Ip6D44e1Sq51zX+9oMsgEtTQSlhhsF4aQ+VGVonnnF8c/kiwNtL9ElsdX4AKJ+xIemgHechIAT/l7aUNyUN1SgXinGBk8e9F6DsqBzgfUCPkfeqodIFBUD7BeF3qxAxrR2bNSIW04ymLtuWJKrJkbnz3QVBnDL2mclxJG2PDH8Yoad6KyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqR2nDpA1KhOqCZvWzzfo5ZA5vODMiDqddqRoNpkmMI=;
 b=irDjuYIxjbrPZ6dW7o0tWuly17+bR7jGeL3fgo109isddnhzTgS0xsIhGwgSUodFgNOjkukisfoXVccHwQx22VPssrSN44Zq1bk4YFBSxFK82d88QnFu96XVsDvuE7qWy3Vgwk3HXhk8jrMsdXkTFR5vPL1gmagaJfJMZ6ZsZ5RnBP5mqE9Y50YR4LyV8aVw8GTYPkZQ80annTUjqrgZR6tw6xLu1CJPqOvQ+mPvQSA5fe0P9xGPe04Q1bT7HXcV73RqUNhQA3xldjKdKJ2f3gWIi1A+X+T2NAoFOZLK0ualUgZHGcIJO32y3UklXT5+dcew2Uw1VC3cJ6/yZD3zew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqR2nDpA1KhOqCZvWzzfo5ZA5vODMiDqddqRoNpkmMI=;
 b=RnudsrtKtmN9JttBzeWf/Pg2mjqtHMpFULk/jkrSYSrXFHa113yoQXHqRChSo9RXiBFF3bro6QFEEJfZ7uNUSLNXC2c3MXcwV4qRRzNI9ZWUMk/3yvUYQmtATZtqx9851g+izS59TJni6xq+6VuwYsygXART+JafuvhVQk0Fm7o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3017.namprd12.prod.outlook.com (2603:10b6:5:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 6 Oct
 2021 17:22:32 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::70bf:51ab:7cba:45c2]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::70bf:51ab:7cba:45c2%2]) with mapi id 15.20.4566.023; Wed, 6 Oct 2021
 17:22:32 +0000
Subject: Re: [PATCH 3/4] drm/amdkfd: avoid svm conflicting with userptr address
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211006143210.4954-1-Philip.Yang@amd.com>
 <20211006143210.4954-3-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5fb56030-ac37-3162-48b7-41cd70c08f0f@amd.com>
Date: Wed, 6 Oct 2021 13:22:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211006143210.4954-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::13) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT3PR01CA0120.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.22 via Frontend Transport; Wed, 6 Oct 2021 17:22:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38274d67-1e95-41bc-6e83-08d988ede165
X-MS-TrafficTypeDiagnostic: DM6PR12MB3017:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30178DC67019A404E96E192F92B09@DM6PR12MB3017.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L/ZEmqL5G1kQaIlaAqs2zWLMy4NUFTL5HNeFnfLTKMH2UQO4+KHTBwdb6DYM2lppbVrgs51XDnl8krFqYjIUMRzjJQS+Mv/dS08q29d3NvAnYWNvwgQHdl0c+MiX8agcjEV8l2o+KCBp2qAv9+BPUh9P7Mtk2DfXwqaBHUx0MnmRi4K9+hQFI2fSYB8yJGVqn3Ul0L9a+pTul+hs/uxHHJy3Z29dilsVNk7g1S2Re9Qjs3Ugh8f1s/3rJvvYx+WBYwvgwPm17yOEg7ylx/K3lu6aUojdAtHc2EQAVygc79tZE25QuIrouc/0ioZUMwQQlA/8LGF9rcUN8zaHz+5XRRjgYrWnS85k/fzNYGU3VrJTYG/t0ebv4oU3nUM+bSlxAOKXbw9ja6zuy4FfUyNRRbykq1hDMiRJQHeqE1YhxJUZl3XRFogHZZ7wmq00sFNllphuMkj687pEtWCUvIna2acnzBFcd3RUmtDto07e7GndaIq5BZX2STgdsyQFy7qfAwV+fyA/pli80COUoyfkEU2eo5/gXG6HzJIiWzJN7BaRTqlQwUvhKF92mESOsQ0ci31JjgJ917Fae4A+aDO1XgZAZSBucmtSfQLmSDA03kWwu22urPw+hQwoFzSdBIdkobS/uEPqOsBiRYOuSYhNF2X15Iz4EoUOHQQF4J9YUbDjSlRw7+RLqy+prkaYxUosPxRVq5I9MJ2T/nffofOlYG3g7/wp5RhQuEHcszR9orNY/xsM9zPo04VB06s6p/EV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(31696002)(16576012)(508600001)(66946007)(66476007)(316002)(66556008)(26005)(8676002)(36756003)(38100700002)(31686004)(956004)(44832011)(186003)(86362001)(6486002)(83380400001)(5660300002)(8936002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzQvRjdYZ3FsMFFGZjE3MjVYdFg4UjlSY1gvY0dHQnVweWd5bmJxYS93Yk1w?=
 =?utf-8?B?SXBFbUR6L1FEVEpvdjhKbzhVZkc3djRYOXp5Y0ZDM1ROMVQ0allTQTh2OWVU?=
 =?utf-8?B?cXFKM3Axdk44TndGUE1UWGc1ZTVUMllQTGdqMUJuWEYrV0VXTFpKSStEWko0?=
 =?utf-8?B?NU1jSHBwRWxieW9FTGFqNGhqQ2x5c0tqZHJtVTVSUzJDZmtBQTV2c2IrWnNu?=
 =?utf-8?B?YWF6UnhPMHFvZUIwTzhFUzN5WE9oMEhyd3hSS0JheXpMR3BEZE9wVFRDYXJa?=
 =?utf-8?B?UDl2K1pMQUJvU1VjaDRLdFYrcTd1VFNIUUpJU3IyOTY3TnI2aEF2UCtXMTAy?=
 =?utf-8?B?TFphdk5tTksreEMrcUZKdjN4OExLeE9TWGZlUld6V3A0SmVkdlo0cEFNd2d6?=
 =?utf-8?B?VUFtQlkxbkhHOEM4c0gxZlg0eXhmUHM1czFNTENnRFQyQzc1N1IyUGVqTk8x?=
 =?utf-8?B?UzdwczdLVHQrdUJydHBTRzJySDhORjBJbm5rcXR6TVBNMG42bmNRckdoa25v?=
 =?utf-8?B?TmtTdXZkN0FjZGg2RkU0Vm1BNnlqWHRtZzZXQ29GZGtJRnJqRHFqcFVuaTJt?=
 =?utf-8?B?MmtZMCtVWTZta09HaSs1ekppemJkVng0VFBSSE9CTFJOeEVZM1FZMFgvRzFj?=
 =?utf-8?B?YkhRZ1hZSCtpRjNzYnlrREJxQlBuVjJoa0hpa29kN2RSK0RWWHZqWTVsbFl1?=
 =?utf-8?B?LzZranVQVGY1ZlBlNTlyNXV3VGlrUGVaNS9tcGluYVdZV0FGMU16czk2MkNO?=
 =?utf-8?B?R0UwTnJ2Q3Q5RGRSblBBYmRIdXJLVTVISUF0NDRTODR4MXJ2RWZOeExFR1g5?=
 =?utf-8?B?K1FuR250dWhsOWRYU0VzSVVoY001STZXTTV4NXI4dGUzZEQ2VXBvYnlENmpt?=
 =?utf-8?B?cVZYb3FyaGllNkc3bzRTdCtSWUFSUEp6OE8zQlNsVHZOSXZKVnUvQWRsa0dY?=
 =?utf-8?B?dHZBdjI3anY5Q3ZlVHJ3MzNoZU9GRVovdGtxMTE1N01tRG13VzNoRFlQTCtZ?=
 =?utf-8?B?MENuWUJlZ2xKWkFXSlRaMWd2MWMrMlJldlE1aS8yVnVUWVFRdFhVc0pOWnNY?=
 =?utf-8?B?Nm83MU9iU091NXp2MVRCVDRYSWNOZVN3N01SNVJlTDQwN0tGR1Vsa1RLQUZx?=
 =?utf-8?B?alJmMTFaZUF3L0pjMm1GZU5xdFQ0Vkw2Zjh2alNGZS95SU1uL2R3KzVHQTE5?=
 =?utf-8?B?LzlpVUp3eG9kVVI3R3ZuTUhIKzRpOG90TlVVaEVLaDRaRXVYbWMrNmkzbHI1?=
 =?utf-8?B?czZIOFpzYTF0R0p3TXZvb205RkhSRmZrN3duVTE2U3hMTHpsUHh2Y3lmNmxE?=
 =?utf-8?B?cW91TU1XWmZpdXhZeWhpcnRBaktBMk1tMHF4REkxbWIvclZuamN6aUtYZWsw?=
 =?utf-8?B?VjRialFNRTlGcXFtZWJYYldCN0ZDOGdtMTk4ektvUjBod1ZpKzR4ZmVKeE5j?=
 =?utf-8?B?bXBodmFHOFVyRVV4NjRibWhGUUxuK1lCZ3UxYWVFMHZaQ04xdkZWQ0lTZnF4?=
 =?utf-8?B?SjF6SjFyL1VRckl2eFRtd2laWW1EdnVGeExXUXZjSmo5cjlrQ2dtbDU4MVp2?=
 =?utf-8?B?VkxwQ2I5ZnhDR1M5TStQSnBkbU5QVS91RjB4ckE5Zkl4UTlGMnFoNHNlVDRr?=
 =?utf-8?B?WmhsNTM2UDE2dUVEcjk0aUxUUXdoaGdIMThtRkd6YndzOFZsd3BiNkFwR3lj?=
 =?utf-8?B?SWFXZlpxNlJFS3hMK0poeGxzZzFqeGVncXU5WDY4MkZnSFFqcWxGaklrQjdJ?=
 =?utf-8?Q?b15tC2X7EbmdZ95IC1EMMbNvUtjybPfzbXg2MWe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38274d67-1e95-41bc-6e83-08d988ede165
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 17:22:32.8239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAJpj5FOeOgjNSFjbBwyDufd8i8GhVQ9W1HwjTYlOihfizdJ22Mq5zRypOgJ3ACoE3WzuuH3myRplBGAQMtmhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3017
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

Am 2021-10-06 um 10:32 a.m. schrieb Philip Yang:
> For ioctl_alloc_memory_of_gpu to alloc userptr bo, check userptr address
> does not exist in svm->objects.
>
> For svm range allocation, look for address in the userptr range of
> interval tree VA nodes.

Why? The purpose of the check is to prevent the same GPU virtual address
being managed by the two different memory managers. So checking
args->va_addr should be correct even for userptr BOs. The CPU virtual
address should be OK to be mapped with userptr and SVM at the same time
as long as the userptr uses a distinct GPU virtual address.

Regards,
  Felix


>
> Change helper svm_range_check_vm to return amdgpu_bo, which will be used
> to avoid creating new svm range overlap with bo later.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 17 +++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 55 +++++++++++++++++++-----
>  2 files changed, 57 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index f1e7edeb4e6b..34dfa6a938bf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1255,6 +1255,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>  	long err;
>  	uint64_t offset = args->mmap_offset;
>  	uint32_t flags = args->flags;
> +	unsigned long start, last;
>  
>  	if (args->size == 0)
>  		return -EINVAL;
> @@ -1266,11 +1267,17 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>  	svm_range_list_lock_and_flush_work(&p->svms, current->mm);
>  	mutex_lock(&p->svms.lock);
>  	mmap_write_unlock(current->mm);
> -	if (interval_tree_iter_first(&p->svms.objects,
> -				     args->va_addr >> PAGE_SHIFT,
> -				     (args->va_addr + args->size - 1) >> PAGE_SHIFT)) {
> -		pr_err("Address: 0x%llx already allocated by SVM\n",
> -			args->va_addr);
> +
> +	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
> +		start = args->mmap_offset >> PAGE_SHIFT;
> +		last = (args->mmap_offset + args->size - 1) >> PAGE_SHIFT;
> +	} else {
> +		start = args->va_addr >> PAGE_SHIFT;
> +		last = (args->va_addr + args->size - 1) >> PAGE_SHIFT;
> +	}
> +
> +	if (interval_tree_iter_first(&p->svms.objects, start, last)) {
> +		pr_err("[0x%lx 0x%lx] already allocated by SVM\n", start, last);
>  		mutex_unlock(&p->svms.lock);
>  		return -EADDRINUSE;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 7f0743fcfcc3..d49c08618714 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2679,15 +2679,18 @@ int svm_range_list_init(struct kfd_process *p)
>   *
>   * Context: Process context
>   *
> - * Return 0 - OK, if the range is not mapped.
> + * Return NULL - if the range is not mapped.
> + * amdgpu_bo - if the range is mapped by old API
>   * Otherwise error code:
> - * -EADDRINUSE - if address is mapped already by kfd_ioctl_alloc_memory_of_gpu
>   * -ERESTARTSYS - A wait for the buffer to become unreserved was interrupted by
>   * a signal. Release all buffer reservations and return to user-space.
>   */
> -static int
> +static struct amdgpu_bo *
>  svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
>  {
> +	struct amdgpu_bo_va_mapping *mapping;
> +	struct interval_tree_node *node;
> +	struct amdgpu_bo *bo = NULL;
>  	uint32_t i;
>  	int r;
>  
> @@ -2700,16 +2703,42 @@ svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
>  		vm = drm_priv_to_vm(p->pdds[i]->drm_priv);
>  		r = amdgpu_bo_reserve(vm->root.bo, false);
>  		if (r)
> -			return r;
> -		if (interval_tree_iter_first(&vm->va, start, last)) {
> -			pr_debug("Range [0x%llx 0x%llx] already mapped\n", start, last);
> -			amdgpu_bo_unreserve(vm->root.bo);
> -			return -EADDRINUSE;
> +			return ERR_PTR(r);
> +		node = interval_tree_iter_first(&vm->va, start, last);
> +		if (node) {
> +			pr_debug("range [0x%llx 0x%llx] already TTM mapped\n",
> +				 start, last);
> +			mapping = container_of((struct rb_node *)node,
> +					       struct amdgpu_bo_va_mapping, rb);
> +			bo = mapping->bo_va->base.bo;
> +			goto out_unreserve;
> +		}
> +
> +		/* Check userptr by searching entire vm->va interval tree */
> +		node = interval_tree_iter_first(&vm->va, 0, ~0ULL);
> +		while (node) {
> +			mapping = container_of((struct rb_node *)node,
> +					       struct amdgpu_bo_va_mapping, rb);
> +			bo = mapping->bo_va->base.bo;
> +
> +			if (amdgpu_ttm_tt_affect_userptr(bo->tbo.ttm,
> +							 start << PAGE_SHIFT,
> +							 last << PAGE_SHIFT)) {
> +				pr_debug("[0x%llx 0x%llx] userptr mapped\n",
> +					 start, last);
> +				goto out_unreserve;
> +			}
> +			bo = NULL;
> +			node = interval_tree_iter_next(node, 0, ~0ULL);
>  		}
> +
> +out_unreserve:
>  		amdgpu_bo_unreserve(vm->root.bo);
> +		if (bo)
> +			break;
>  	}
>  
> -	return 0;
> +	return bo;
>  }
>  
>  /**
> @@ -2732,6 +2761,7 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
>  	struct vm_area_struct *vma;
>  	unsigned long end;
>  	unsigned long start_unchg = start;
> +	struct amdgpu_bo *bo;
>  
>  	start <<= PAGE_SHIFT;
>  	end = start + (size << PAGE_SHIFT);
> @@ -2743,7 +2773,12 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
>  		start = min(end, vma->vm_end);
>  	} while (start < end);
>  
> -	return svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT);
> +	bo = svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT);
> +	if (IS_ERR(bo))
> +		return PTR_ERR(bo);
> +	if (bo)
> +		return -EADDRINUSE;
> +	return 0;
>  }
>  
>  /**
