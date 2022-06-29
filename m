Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7A3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 22:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 494F810EC65;
	Wed, 29 Jun 2022 22:20:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9178810EC65
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 22:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bp5UzRRn7ntksLYowpp4Xl1NTMLXzWPbnN8cMp9vPu7N8x6ob+GxqnvB7KdR0u+BBF7pk/EmbHk7xCNQdxOdwYvBNyc7Jgfnvjpb4EvMq6EPxT767hNUvvJVl3vic68Dv4O2dQaWv/hiP/RDjS24JR5uBm7lI9ksyG8xcbLEnjUHBAwKMfQxm6YR6oWPxtVlGzKQS3yuqGlH9/kKG0Bkpqa+edG1cI53RLt4uQy1/wEyJhFCHws72BP4WAmoyw5KlpW3Y9j7h7Qcu0UV5UB09jPiiF4x926O33u/P0NA29YnNu/pULfTTv6Ht47G+icm4PLuTLyuyfG+vxppv3M3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsmPxCjeOIzk5DGISPPhpXsg+mi6h4AXXrJVRwffbL0=;
 b=Zrd03A4Rk9JnDjTSWJOpSe8/bEdrVtx7TI8JKnxM12I8z7hZP0B8zWEDM7RIgclXx5OkdAVk+a/85MSIr7AbqlMNK+25B94MxiqO2Gkdf2YU19LfBMwDADTHi5pFf6K9HKvyfyaaAYXebHTowpFMjlDQ4Zk1CA0SPTEcmRGjZqNYjseASZMyN8L/VNQSJOX1QLJyCbGuPb3jmOywkahCixo/XCOrn+0TjABUa9X4Gb52qN2lGCwIGsGZtbRPY8WWghXcucAeBSO9U58Zlr5NC3QC/7JtJZHiBgJr9sIHeNKew8zVs+VKU1Z2KX8v0GuFtM8u+t6mCGhNj7vK3Zvf7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsmPxCjeOIzk5DGISPPhpXsg+mi6h4AXXrJVRwffbL0=;
 b=ZGYq/+4uVKhYi9ZTvYc07ObxZpIEKrwa3SRTS+JzFF8WN+qm5T+tpPZZBKurQGXVxfSZAcbNjNa9e6vlIPSNNsnmb/ZuywdDtOxFAHGKEtiMlL/W3xhxsAcJQwyvemO9ElEDmx/7D2pr2KISuXRR/vMl6Lm6URnrnNpqyl7GTS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 22:20:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 22:20:37 +0000
Message-ID: <99b8907f-9aa7-7aec-4895-cc94b0b58bec@amd.com>
Date: Wed, 29 Jun 2022 18:20:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] drm/amdkfd: change svm range evict
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220628214315.235160-1-jinhuieric.huang@amd.com>
 <20220628214315.235160-3-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220628214315.235160-3-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccc81f10-d51a-426a-65c3-08da5a1d97d0
X-MS-TrafficTypeDiagnostic: MW5PR12MB5621:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YP5EaHO6qZgrCmth84hpGXtTGe82x91z4v0NfvVN963CHvDdm+M/XeY58rJR5W4LYu6ZYZkFTEDZZ0sycD2pUWW33riI7/gCK9Ds67PLtIRBtacm5+qmr9Hrp858kNhyyYP6JEZS3ZeddEoucIPRW43UfNjXUSHETNt6SHo4A9MwXJcKoSoawd5o0Utnfm9sFHp48FgX1Hi+p7bz3MV3ECDXIjMxmymDO4A/3P7bxU9KqTrDgekc02fzgH/sSkYDB8gMCnMVcDlCv/KQjsH9WOmBVC2AXgoXNpsAbI7D1g28v37sSK3A41VfM1vHVc6blDasIKQ6mjy3hpqYdB1rVKX/eol2o8h1FgbPe1d4gMcHgeU4WuGXCKVDnjRay2Y3Hf9DB+qCGFy3SVk7JUPNhY0LJ3lQ7dd6m/bQ9OIgVq1x97+wPlbCcbKfhxTvAQKh5eY3W1lulUQb1x7xHapTer1r76R7W11MzdBDso61x+UJKHcLjhJa8sVe54jfwdVHSVeiAcJq+1Gs5REU1IOBcgCnvt6Q68RVa1Y2Xb1QqHZPxhRu1Lb/tWRtF+V+SpqpccntF6H6x3DnIPqrt04i87N/trRtf+6iG5DuCaj2TGQeNlHQ2BLsjVHbfsSJEkdevYB0PQjRgaTHx5Mo/ocXV56sZAMx5bjEeumn7mKJ9bflSWIKi7UuniPNLWjBwrC6heawgAQoVJFtoZ721H5lGIdw+t0I0Wcu09kqHfuGFaEdGthr2E68u6OQTxHuc0ZZkG2c8C/QveYHCzCtkQ6QRCqZUaflRPDOYJKe0dMkfr1/97oTj4A7IqXNKTFNMKQOwBmME4lAEECNktDWOoTEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(2616005)(86362001)(478600001)(36756003)(31686004)(316002)(41300700001)(2906002)(38100700002)(53546011)(31696002)(66946007)(66556008)(186003)(8676002)(6512007)(36916002)(5660300002)(83380400001)(6486002)(26005)(44832011)(4326008)(66476007)(8936002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHBvQ0lubUdMbDBIbFFrRjE3dXhyMW9ycUlKQUVBNzBnejlZbnUyVUd4d1E5?=
 =?utf-8?B?ZjFjbERHaHNiV2xwK0JaY2NDTzV2eFJ2b3QyUFo5Qm5qdnBNNVRNTDZFOWRX?=
 =?utf-8?B?WDhHYWcwZUY5VU9WaDI4ajBNbkNwRFZTN3NOZE1VbzZjazJjMDVrcFo3Tk1L?=
 =?utf-8?B?T01Hc09xc0FhN2VWRGpNVzZucXFWSUJqbEluemJXMnRzemFBdnErZTBmNnp0?=
 =?utf-8?B?SHVJWXhLRTQybkIyYTRvdXozR0lJSWdHUVdOTGwvQnEybWxKMGczR3FHSkcz?=
 =?utf-8?B?OS9iaDQ2N2N2ZTZrVWVpcDJJRHUza09kMENZb2Vqci9DOXh3Wnk2TGtOSWVK?=
 =?utf-8?B?dDVOSXVBMlBlckFreTVHOTZsMG9JQzZZam1iSE54VENzRG90cmhQQjhMcWcy?=
 =?utf-8?B?S1VkVm5IbkpjNE1MOUMvNXJ0Z0ZoLzBSRkUyd0tRN1h1VnMzcFdEbDZEckJG?=
 =?utf-8?B?RHVyZ1dBTUJmVW1oa3VYY0Q5TGhwclV2Uk00V1dHRGErYjVOTVFORjhjWG43?=
 =?utf-8?B?MXJPbGJ3UHA0d2RtN1BQOFV0TExkRXpLb2VVYmFyUGFTeDRIQ3FZUmgreks5?=
 =?utf-8?B?ejBZQWRRZ2hYWklWdXN3UVZmUU9tVEkvM3RTa0RnaW9ZaFNaeHdza1JOTUdw?=
 =?utf-8?B?NXc1VHZvQVk3VGQvS3NNYmJRbWNLb1JVNnJQWHJPamcwNm1FR1l1N2I3ZHlt?=
 =?utf-8?B?dG9BL1A0dmgyVmFwZmtOQ1VlS3BYRGRGM3pWTFh2ei9aZkdmL2FyVTBZYllt?=
 =?utf-8?B?WDA0MUNiYWFXSEpBUG1lMHU0RWJ5bWk3RHY2b1U2VXJuRmsyZEh6T1JycGJo?=
 =?utf-8?B?RlVpNVVBdGJXVVd3U3ZWSVVFRnFIZHJab0ZsVko3UmJsNDNFTC9kSnVEUWxz?=
 =?utf-8?B?c2VIbjJaSnl2SWhyM2YxQWJoQVVWb2x3Qkg5NG01U3ZQQTJmeXVkSkV5Z3Nq?=
 =?utf-8?B?cHJvd2Q2eXNPcGJRZURMSmZlU3JSWkVnK0xGUUllMDJhd3dwc3VQaHVIbXZ3?=
 =?utf-8?B?M1lEUTA1NTVWN1NSTCt4U2FSazVtRGxBc3NmbXJNVWFJVDBES3V2alAxS3Ja?=
 =?utf-8?B?U0d0YXNNUlJScEcvb211QkNlS05vWEVqVkd3UXdFMmJOSDlTeWU4M1hEKzAx?=
 =?utf-8?B?aXhWZDVNaGg4Q2NiN094VVE3OHhSTW1OUjdyUUdhUGZqZTZHZlVrL29jRGJz?=
 =?utf-8?B?VzNxY0ErQ21WRXlvM3VzSzBmaFpEbklVNjZJVjIreXpYNHRyMTFuQXNyQUcw?=
 =?utf-8?B?NlEzdHJnWGxFYTZUeTBpd205UUtPTzBBa0NQRTIwN1ZQT0NSZnBoUzhISDlR?=
 =?utf-8?B?QnNxaVF6eGNtQWZkYVpKQ0hBZ0NoU0g5ZFU0dW5kOUJQN0szY3htS01xWlph?=
 =?utf-8?B?SEZTdTRlMlhiN1g4K1FOdTdrSXpLU294dXhhN1FvODBXZHFRYUJTTEdtMFBB?=
 =?utf-8?B?M0F3ZjVMbTQxSjRJWHFMdE0weFlOVndhRExrSW5NNllsM1hGNUI5UUdFcDFI?=
 =?utf-8?B?VW1ISTJCSERrbnhwNFcvNW10cmRLSlg2K1VFcFF2TUhQOFdmeFhKak0zVkQz?=
 =?utf-8?B?eG04Q1M2VFd0cGVtc3N2dURCK081RVBoN2E3ZThZYURPQjA3d08xSE5OKzNw?=
 =?utf-8?B?M0xUYXlhRDkwVTk5bTR3c3d1ajFUY1UvbUdMTjFCL1FpU09OQ0VPRmpyOEk3?=
 =?utf-8?B?MFgwdDJpeUVvRXVDOTZjMjFMdXd6a1F6dmZoN3YxYy9LYytsUG42eThLeWtZ?=
 =?utf-8?B?d3RaL3NQZ05OMFVJZThqOTNFK0hYWDh3Zng5V2RGN2JZN2hXMHBkTEZlN09N?=
 =?utf-8?B?RHJObDVSbnFxZ2F1aUV6bFdhZFlYV1JkazVyczI4K25HWVFyRzdpd1RlcWtF?=
 =?utf-8?B?bk94U1FTbEE1aXhRdStraWZ1ajJpVUJ5Zm1qY1k4aURKYmtmelRYZ2FhUW1h?=
 =?utf-8?B?K2lUa2FHMjkrVXYzQXc1ajFsQWtib3JWZ1VRTDlZekRYaFlhV01qUHkzNFgy?=
 =?utf-8?B?eXZSU1hNZUt2UExIeXRRRVFPK2hvdkF5Rk04WlJia0IybW9VL0ZBNWkrUWpQ?=
 =?utf-8?B?clNrZ2h2YmhNSDRpaHpNQ01laHV0ZUVKang3dG5DRkR2ZTZVY2RwSXd4ZklZ?=
 =?utf-8?Q?Llxm0dY1Cdb/mZF2+WqHt70zD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc81f10-d51a-426a-65c3-08da5a1d97d0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 22:20:37.5321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fX7aYRcldBne8GvKSRbkeN80WDQH7QbH1j13cnkpTbV1/gGTsgUJmt80r+KZuygC7k1ybPn+BkCLwOzfichp/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
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
Cc: Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-28 17:43, Eric Huang wrote:
> Two changes:
> 1. reducing unnecessary evict/unmap when range is not mapped to gpu.
> 2. adding always evict when flags is set to always_mapped.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 4bf2f75f853b..76e817687ef9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1767,12 +1767,16 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   	struct kfd_process *p;
>   	int r = 0;
>   
> +	if (!prange->mapped_to_gpu)
> +		return 0;

This feels like an unrelated optimization that should be in a separate 
patch.

But I'm not sure this is correct, because it doesn't consider child 
ranges. svm_range_unmap_from_gpus already contains this check, so ranges 
should not be unmapped unnecessarily either way. Is there any other 
benefit to this change that I'm missing?

Regards,
   Felix


> +
>   	p = container_of(svms, struct kfd_process, svms);
>   
>   	pr_debug("invalidate svms 0x%p prange [0x%lx 0x%lx] [0x%lx 0x%lx]\n",
>   		 svms, prange->start, prange->last, start, last);
>   
> -	if (!p->xnack_enabled) {
> +	if (!p->xnack_enabled ||
> +	    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
>   		int evicted_ranges;
>   
>   		list_for_each_entry(pchild, &prange->child_list, child_list) {
> @@ -3321,7 +3325,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   		if (r)
>   			goto out_unlock_range;
>   
> -		if (migrated && !p->xnack_enabled) {
> +		if (migrated && (!p->xnack_enabled ||
> +		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
> +		    prange->mapped_to_gpu) {
>   			pr_debug("restore_work will update mappings of GPUs\n");
>   			mutex_unlock(&prange->migrate_mutex);
>   			continue;
