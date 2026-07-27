Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E823C531D0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 21:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D06B10E4D3;
	Mon, 27 Jul 2026 21:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zygcHvz9";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EDF210E4D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 21:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMh857XS96JglHNo+Ut0NlFd4AYVcHNRKOB+Kvbpin4tXD0YYtSaOShDuLuW95hObAj7tzlet1is/l58S0ZsNmwTO+dpjB8/C6SDRL9nOj6+M5aaB37CTbuCnLLr2uooZcaltwswSZhbFJdzJHWuyU3wyNxdmlcgZQ5XAJXq5/+GFj27++OIE/zteVQPoSSKKSuZ0Zx2ukM2tpfRZRQE858jefE12wnyaUBStvHdX9pD0xXGGZGGczX4AGsVQcTVIedkJiAki1q7fL26RjXnIx4TqB/SzgMMcIiRE2dUcgQ3PgZuouOSFsiw0qAIhSTQUk7lkweErKtKFoP0B+agMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp52nCUYrZHsZYdXWEzxs4hXXIEC2G5OmKI4r5ndAUY=;
 b=yXT+nsd/hV0QJ3rGfAo6h1UBSffAVBibvCZHCwUv3Y6UYzD6dwItVEjgLQoG5MdRMzsW9G/9Aq4c6RqMc0ormoMiC1L9CS2nHmR/PKoYY594b3+vkp+N/MaTl9MzSrH8mYrLhwYsfObljVzf9KeEcGpjfvwZ4cGikOUnnlvQ065A6zV54YCcKVce/FEbFycVEGJVPxlRHb8GVCdrjDQ4fVs3PWlJg3FUzO1kRumoXMNGa42ynlE1dbL8uhMtDtAfQg07avNNgbfCNX0vosAx1BEgIcc/5uSyNlk65T9G+/8e47hfapUIwDpcAHarwZ3AFdilhTbaZMTsN4xCjEodGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp52nCUYrZHsZYdXWEzxs4hXXIEC2G5OmKI4r5ndAUY=;
 b=zygcHvz9zt/jTNBKzRJjRK3aditNycjVWefjDS9vEUi9nXBpGG1iC8ssDh3C5zSNk0v2cGD2RAUS5MR1N9Vn/6YoCIqS5ezTwjBCF3Ku9utWKQDiUHxKi24FKuYatp+H2ox1CI9MyZHtETyLgcLx3BZdCpLZK6VJz7g/OwXyzyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SJ2PR12MB9192.namprd12.prod.outlook.com
 (2603:10b6:a03:55d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 21:45:12 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542%4]) with mapi id 15.21.0223.017; Mon, 27 Jul 2026
 21:45:09 +0000
Message-ID: <bd6b94d5-5ce3-4b63-98a6-b11fea9cc858@amd.com>
Date: Mon, 27 Jul 2026 17:45:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdkfd: Add helper
 svm_range_update_checkpoint_timestamp
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Amir.Shetaia@amd.com, Kent.Russell@amd.com
References: <20260727193930.612490-1-Philip.Yang@amd.com>
 <20260727193930.612490-2-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260727193930.612490-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0329.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::19) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: 430ad2e3-13f7-43b7-0919-08deec2854a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|18002099003|10067099003|11063799006|56012099006|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: D74Q0dRceeGaUOKZdP8hzaQvu7q9RBkXh2NgABO0sOha2Sx1dm58yf83PPpTJ9cLCDkJJ259TURxoRI66jJ0ETp1hl5oA0JWXI7KbEb2spnEvfGzttWqnKtrB/bT6D8yW3HsMAYviZGRqvsmAQb4eF10s5PmjHXLCE+5GWAe35xgnUh30SrLYFFBkr7FX016/o2KiiNkAXQa8uKHrfqp7+38frLH7LR3c0fXEofv4h+jO7joUanhZJL7nPKxh/cmfRUWnq7a0dBhOFiZsTWqxMC6fzQKbOD1HoMhm0NwvA6fve2mfMqJ6zck3ri7/r8qrcD/r3CzouFi11is7eMs1LHBySF+fvpsJQ6ngOUTVu3j0/4vbUMsQWfdJXUK5Z1Sf3JjV13QVJR+EoaklO1cHljg3CGpAEFVejD8dXVKx3QNxDT0iVc+SKIvY1NsZ3+GSBNGu6Pn77Pu/P6JYtkRFy4euxXSNHGxwHY/ZCYkhFCRskV2XAnhs3OxeacDTsGyVuKQKYcW2M8NBxzHaO0IojcSjszKA/4Hj8t8QgwrEPF1MG2lBLUh3TddoKyjV5pD7IQvIUg+ysSKa/SgA0vt0uU7KZ9FLH2kAEZNVyXI9mkNT4l9NsuOpT4S2TYkinprCcmKtFYQaipcpXQq1EecF0mQUZzRmLt4e3D9sf4/5nI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(10067099003)(11063799006)(56012099006)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGE1Z2FDVmRrQ0dpOG5adU9HNXlYaW1yMGszSll5MHkxRTF3US9rbXZJMnQ4?=
 =?utf-8?B?MGpqUlR4Q0pDWC95SFJvNTBnRmlQQXdZZTZIZmw2VXJacGJLSGVwUytXLzh0?=
 =?utf-8?B?NUQrUG1JbWw1YURQUWgrYVhGaFNmODJEQVhFRVZsTmdETndKNEgxTlRwb1p6?=
 =?utf-8?B?WHZ1Nlo0V1dteHpRQW83S0p4UmduKytHVStDdVRmWWc3M3J5dVpLVVlKOEhK?=
 =?utf-8?B?QWJvWkY1aDNjTTZtZkttSnNUQTBJTEtkdmdGQUkyZDR5TGEvenA2OWtac05v?=
 =?utf-8?B?UmEraHVXYkhsaWN4MGMraFUzSXJISGdVV1BheGtqZXFSazk0RVd1QWw3Mk5D?=
 =?utf-8?B?V044RTE0cTJ4VnJCN0dPQVhCNnlhSHVoUUYzVDZCT1NkZnZHZlZkS2NnMmVw?=
 =?utf-8?B?L0NBamVEYTlDSW04Y2FVWVVsUmJlMXJZeXIrVUZqVFNsN2dwdy9FVDZsQjNR?=
 =?utf-8?B?UDBudmNWV3RPK1NrUFBLSkQ3c2tpbkE5dTN5dFJQc29PY2VRNTRseU0rL2dB?=
 =?utf-8?B?c1cwclkvM3oxK1F2cGp3RC9DZWVOT0J6cnV5L0lucm45eVBDSVVTdjg5bHVy?=
 =?utf-8?B?MjY1cnBsaktHQ2hCczN1c0pHbW9RUmF0dVRQTThKQXVWRGljeDF4dDRNZnFK?=
 =?utf-8?B?SUpJWXdRSUx6eFZtbVJXamM1RGV6NmJMdkpGTDZQejM1b3pRaEp4Vmo4encz?=
 =?utf-8?B?NXpYaFAzYlgxL1VRV3M3eHBTbllnM3Z5Y05aTXR0R3IvaHUxYytlVVFCRlBx?=
 =?utf-8?B?NzV2czFTeHJYdGdlRHVqMEluMFU5Q085ZkpKY3N3SUlpQ1grbFZCSnFZd1gr?=
 =?utf-8?B?OCtKUVJoL2JEUEFqRmszalBwQ1FqUEY0bnN4aWcwSjRuY0pteTdFYmFFSGh5?=
 =?utf-8?B?Tk9GaEJyUUQwb0tlSzRWRFVRcG8rRXRpSkR0NnVWcGpQZ1JvTTJwSUliY3Vj?=
 =?utf-8?B?SnAzaGNzUWtQak1yMit0Z0tSZVQ5NUlQTURJNGhSMkZWdFR5blMraVo3eHJi?=
 =?utf-8?B?cWRLYnZVZWs2dzNKMlkrcElma2taOUVDWThlWE54bWphTDZQbVVGNSs4Zy9E?=
 =?utf-8?B?cTU5cSswc1FZbnczSkY0blJsdnJsVFg4VUZrYjBLbktBb3pOWnRuUHZycDhq?=
 =?utf-8?B?YnNEbmx1WG94ZFNYZE1CRWlWUnBTRVJYZXFlSDlDc1RNaWJ5emhxdGI0WXBJ?=
 =?utf-8?B?RWQya3NkNUVvOXBHU3FObk84cUhNbVZaOXFxbVUwbndiTEt0RHNWWllzNi9s?=
 =?utf-8?B?RDdoQklJc0J5V1l4TnRCcHN1TjZnd3JMRVIxclh3Z1dqdXhQS2tGampRaEdh?=
 =?utf-8?B?MUFGWm9scHQ4TE9BTE1CMllTSW41NGw4Y0FqYU1YK0R4YTNMNDc3WldyYzlG?=
 =?utf-8?B?VUtZRFFWdVVXNEg1ak8xZnorTUFyb3lxRVd2R1h3VXJ5dEt2UVdLVUtGVmdR?=
 =?utf-8?B?S1ZZRHlxYVhhdUhZNVgxSXhvWTRyWDBJM3FiT2xXTmFKanlBbEMvL01CUVBZ?=
 =?utf-8?B?UmlVMDlWbkt5dkVaOENnRElMRlFwcWFtZlF6RXVVbGdZT0I5cmNhTEh0WWw3?=
 =?utf-8?B?RHRCMjkxYk1xVnh0S0RJWGZuZHZsSE1pRGhobTV5T1ZTT3MvNFZkVnpDQWFy?=
 =?utf-8?B?eUs0TUh6N09pdHhjQWhPalNieEgvbThQN1djSFBwV3NURVM1NjkyMmxuVnRl?=
 =?utf-8?B?TllwSFZ3Q2RPTWZOYTdoajdmd3JldWMxSWUrTWdHNkU1N0NZT1BtMVhZeUpO?=
 =?utf-8?B?UmU3TEttUjRTYmZibFA5R0ZKYjNqRkxqYVJlRGovWi9UcjVnWmdXeGdTY1RG?=
 =?utf-8?B?VEwvSGFjaG96YnFnNjZJOXV5N2w3czRnUXJzcU9pYkIzV1pEWGRtanlMZXBD?=
 =?utf-8?B?b09YZzdlQ0V3dDRGQ3FrekUzc2ZXYVphb0RhWUZROStPTVNGMWZEcW9JaXht?=
 =?utf-8?B?Y3BkMWNYdVI0SWNkbXNnTWl1SU9rTEhZTk05TXRESzdUcVlHODlXZFNQS1Rh?=
 =?utf-8?B?MEZPQWtEZ2N0MnMvdzlKbDVJUjJmM3RaOC8yZDlCQXAvdnJ6aXUwY3VlZWJv?=
 =?utf-8?B?K1lJenJFcWlLd01iejRPa01Jci9GSFAwSlhSYU5kZ3lJNzJZYnlUdDE0MlBV?=
 =?utf-8?B?S29ObGp2d3Nsd2RySjBCMGVjL3lHSm1uSHhQUUdsWDZ0SmN6MTFoY0JNZlV1?=
 =?utf-8?B?czQzSmwzNXVvWkw5VGQ2SHNjeVpNQlZHa2grNjBhY3hGUVRvdEdBVm94dFBN?=
 =?utf-8?B?N0hpdDVGWnRmd1lDQ3lBUHVCQlB4SlNnbUF2RDFKbFRZTDltNXkzUG56TXI1?=
 =?utf-8?B?elVwWm9HdVc2RERsSGtueTFqdXdlU1RlWW9aLy9iRkxtenEySTJzdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430ad2e3-13f7-43b7-0919-08deec2854a3
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 21:45:09.7137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAiAeJJSmZ4UTcFbOBXLdzIKX4vDCCTgj1M/qcE22WbQZVFyKr4zKwPh1C2WRwO+6Qn7v6oBQfJ/omi24TXpkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
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


On 2026-07-27 15:39, Philip Yang wrote:
> Extract svm_range_update_checkpoint_timestamp() from
> svm_range_unmap_from_cpu(). The next patch calls it when the app sets
> the no-access attribute.
>
> Change checkpoint_ts in svm_range_list from uint64_t to atomic64_t so
> svm_range_restore_pages() can read it from the page fault handler
> without holding the svms lock.
>
> No functional change, preparation for the next patch.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 83 +++++++++++++++------------
>   2 files changed, 48 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 88191a4c1657..bcb929002839 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -895,7 +895,7 @@ struct svm_range_list {
>   	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
>   	struct task_struct		*faulting_task;
>   	/* check point ts decides if page fault recovery need be dropped */
> -	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
> +	atomic64_t			checkpoint_ts[MAX_GPU_INSTANCE];
>   
>   	/* Default granularity to use in buffer migration
>   	 * and restoration of backing memory while handling
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 30ad10bbd47e..c10d4edc8813 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -759,6 +759,48 @@ svm_range_check_attr(struct kfd_process *p,
>   	return 0;
>   }
>   
> +static void svm_range_update_checkpoint_timestamp(struct kfd_process *p)
> +{
> +	struct svm_range_list *svms;
> +	int i;
> +
> +	svms = &p->svms;
> +
> +	/* calculate time stamps that are used to decide which page faults need be
> +	 * dropped or handled before unmap pages from gpu vm
> +	 */
> +	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
> +		struct kfd_process_device *pdd;
> +		struct amdgpu_device *adev;
> +		struct amdgpu_ih_ring *ih;
> +		uint32_t checkpoint_wptr;
> +
> +		pdd = p->pdds[i];
> +		if (!pdd)
> +			continue;
> +
> +		adev = pdd->dev->adev;
> +
> +		/* Check and drain ih1 ring if cam not available */
> +		if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
> +			ih = &adev->irq.ih1;
> +			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> +			if (ih->rptr != checkpoint_wptr) {
> +				atomic64_set(&svms->checkpoint_ts[i],
> +					amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
> +				continue;
> +			}
> +		}
> +
> +		/* check if dev->irq.ih_soft is not empty */
> +		ih = &adev->irq.ih_soft;
> +		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> +		if (ih->rptr != checkpoint_wptr)
> +			atomic64_set(&svms->checkpoint_ts[i],
> +				     amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
> +	}
> +}
> +
>   static void
>   svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>   		      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
> @@ -2556,7 +2598,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   	struct kfd_process *p;
>   	unsigned long s, l;
>   	bool unmap_parent;
> -	uint32_t i;
>   
>   	if (atomic_read(&prange->queue_refcount)) {
>   		int r;
> @@ -2576,38 +2617,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", svms,
>   		 prange, prange->start, prange->last, start, last);
>   
> -	/* calculate time stamps that are used to decide which page faults need be
> -	 * dropped or handled before unmap pages from gpu vm
> -	 */
> -	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
> -		struct kfd_process_device *pdd;
> -		struct amdgpu_device *adev;
> -		struct amdgpu_ih_ring *ih;
> -		uint32_t checkpoint_wptr;
> -
> -		pdd = p->pdds[i];
> -		if (!pdd)
> -			continue;
> -
> -		adev = pdd->dev->adev;
> -
> -		/* Check and drain ih1 ring if cam not available */
> -		if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
> -			ih = &adev->irq.ih1;
> -			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> -			if (ih->rptr != checkpoint_wptr) {
> -				svms->checkpoint_ts[i] =
> -					amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
> -				continue;
> -			}
> -		}
> -
> -		/* check if dev->irq.ih_soft is not empty */
> -		ih = &adev->irq.ih_soft;
> -		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> -		if (ih->rptr != checkpoint_wptr)
> -			svms->checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
> -	}
> +	svm_range_update_checkpoint_timestamp(p);
>   
>   	unmap_parent = start <= prange->start && last >= prange->last;
>   
> @@ -3117,8 +3127,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	mutex_lock(&svms->lock);
>   
>   	/* check if this page fault time stamp is before svms->checkpoint_ts */
> -	if (svms->checkpoint_ts[gpuidx] != 0) {
> -		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
> +	if (atomic64_read(&svms->checkpoint_ts[gpuidx]) != 0) {
> +		if (amdgpu_ih_ts_after_or_equal(ts,
> +		    atomic64_read(&svms->checkpoint_ts[gpuidx]))) {

You lose atomicity here by reading the checkpoint twice. It would be 
better to read it into a local variable once only and then using the 
same value twice.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>   			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
>   			if (write_locked)
>   				mmap_write_downgrade(mm);
> @@ -3128,7 +3139,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
>   			 * to zero to avoid following ts wrap around give wrong comparing
>   			 */
> -			svms->checkpoint_ts[gpuidx] = 0;
> +			atomic64_set(&svms->checkpoint_ts[gpuidx], 0);
>   		}
>   	}
>   
