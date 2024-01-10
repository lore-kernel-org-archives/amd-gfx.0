Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51101C4707C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 15:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B648910E611;
	Wed, 10 Jan 2024 15:44:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B273510E611
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 15:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RumaQ0d2y1DtUY/qmG15iQq08oBhykvLpLqHIZpX8S3xc22qBZprbv9v5axeIbI9grx4pPrzlXyUYCPNgAMLn5e8MmD3FS+XJmMeSTYdlDCTOni3KXlSTL/ClZtNYdI7VZzZ6qAHQNSOiGPEpt872Hl8oiyiO2QALm1HBp3TdmOGfDgduQjpGukDs1viwRv2DxIXpsg4zBz9d1WqX7jp0UH32KlKxNvafIe3D+C7lLjOK2JDJs82K/LVdGxWJFYqLOVHG1wgkp1IIJz9eHOV1fODaK26AB5mURG6T48Pw2EVIVpCsUdXR7Ho6L2mrRKCdb2svgTPqGWGpfc8cohUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hutM7qSIt/QaqfHcoOAl/jkABH70oqY7O6WY7ahKI6E=;
 b=B+FprgyN82WiA4Xzt/UCc2yTTJhErtqvThqKll+7UXIS5WrsN+e7h04Xb9VCdkeegTAQ67YpDbBlMi67AMWeiUxC5OfrVVosAxFBZrxrykc0GmSXD9CBWjWM36N+o5GWu753/CBiGbsYKvM4eDsErW67oPDG7Xs9x+SBpste9pgdybfxi/jXoAdbJpyMkf3SvPv0vvnU1qpLJs709l32wLgghrLhopGg6uY5VZXOdpZl3DyEGd9ypEjfzSOD2qTfS56mO0chIjDfUmwnspL2uJfT3Uh6WbmNpst7LbkR8Lq6z+PGy4swwShu8cQvHefDC53WECHVY+domcjV/iknHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hutM7qSIt/QaqfHcoOAl/jkABH70oqY7O6WY7ahKI6E=;
 b=w9GNmWRF6soUJFQp3o94G0nDFMzCUa9xoOEptrobHbKEVNne3VW8kdSCbnOGixLBJcsIeL245aHzYr70fOGxPIPaN7YMVs/6j5qWqWVx+xaWwuAGNic15TfbP7hJtrJsvg8qNyOW6mF3upBZfv0jgTJIbHUAQp2HJTc5djN/EYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Wed, 10 Jan
 2024 15:44:14 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 15:44:14 +0000
Message-ID: <745e628e-5f6f-4650-be4e-be226b4f0a7a@amd.com>
Date: Wed, 10 Jan 2024 10:44:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix 'node' NULL check in
 'svm_range_get_range_boundaries()'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20240110082644.405086-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240110082644.405086-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: db5115b6-f191-499a-24a7-08dc11f2ff51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n22WkXswrfLWak0gzrvsIovTVWvA0ZMmVV/qd2p4nGIHMFf8V6bHg4SjF8PQi3UIoeOGvjYOljy4GiSCbzxIIF64zwJ8uJXKl7t100ktQNzdR8ZlWTfdaTlgs3zKZZvvlIB1pLYDvqlwyeuYxOuMZkboA5HGBHb3pBbtrDk7/8ykF5+c2JDdyMCPNgxqs1aZopAl26m+UbmNwP6RI3wexT8+clGS/CG2JLn7yF4LIXXqLSRlTjj48lv+5/UcvSamlQJ5/157nF85FUJh7CYi2TOZYSN+A1dav2IIdiyviAwJFfINbaKPQ8s8luJsjts5zMdk63quLYrDkO20rIelqwyeYHQqtQj47wg6jOZfu7gYcNt2U7lhYjvsVADQkcbUAJzec2ObnlQ09HvL35Q7kHwWdr1IGA6eid4gHRZxRtJyi38vx7xrgw3z5QzBQk+VAQDrymuGOrIvx6O5FfRSvEtwTh4+E9UgzRIDxFRVVlB5sjBZl6HqXoyeGxYMxEgTntr786ZX/qzBu7TGrTW7987UvLTqWH+Jeqbwo51Dk5/RNAgCp1VOpmvGTONjAm9aqYuviiu8vd+XU8LiZXv+P4yyQZV2wQe/+L3KKd4Ycz0lwpetGn9rAwORMB7nvjrI+ZQDrWFhJC4HS/GwQ6jkhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(2906002)(5660300002)(478600001)(4326008)(44832011)(38100700002)(66946007)(316002)(66476007)(66556008)(6636002)(36756003)(41300700001)(110136005)(6512007)(31696002)(6486002)(8676002)(36916002)(6506007)(53546011)(2616005)(86362001)(26005)(8936002)(83380400001)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk5MS3VtRkZwM3J5aE51NThDZUdmZ0FMcVdvR1NZMUtRV1BSUWxrRGh1MWxk?=
 =?utf-8?B?V2tuMUJHTWhpcDAva1VZU005R3Y2TEdUNllKSmlXSlJtY1FPTXJ1WXhjVXFK?=
 =?utf-8?B?MTBlN2hUSkxSRXRzQUFPc25aZmtpaityN2VIQ05FT2JHZjN4d1lZbVc0clpY?=
 =?utf-8?B?MVZEc1NvMXhleHZkY3MrYkt5NEV5WDFSWjJJZGFoUHEvM2dTbHZzV0tFZEtE?=
 =?utf-8?B?NE5NYm16Q1JVQUx2bTNtOXJ5aTBSOU5idEtJam5IU0xQcnZwRzUzNGlBTU14?=
 =?utf-8?B?Ym1ZS1M4aHFuVmNQTzIwWXM1Y21jYmc3aDNBczF1dkJlTEVMdnd1Z2lMcHVS?=
 =?utf-8?B?UkgwOEtHNFkrMVFycmpaMmNHSXIvSnk3UEJEVDN4STZsUUJNN05Obm5HMm5q?=
 =?utf-8?B?TTZqWWtuWERjRm5NVi9BL21TZmZmZmhYQ3dIT0NLb3J1RklFQkVHd3p0RjBq?=
 =?utf-8?B?Z2VBbE9URkR1STVUdDVIN1Y3OW9xZ2dJaTZ2d2xJZUFrb204bzhKa25vRWpR?=
 =?utf-8?B?Y0s1STZPZXZjOTRueHBoNkIzSzY4MnlUalAzMi9LK1pKcS9qTXdqZXZpN0lU?=
 =?utf-8?B?OXJFOU1QK09JQTU2QWFSOVFoZlZKMXBFSDJLSC8vdW5HR2Q3bEZ2NGo4NlAr?=
 =?utf-8?B?T25lWFNZN0RFd0ltb0tMVmkrYVB3N00xNUFHNEhXVExwVzVKSXl4eFpXWTJY?=
 =?utf-8?B?Q2h2eDZPWW9lL1ZQbXl4QlB2dEJWN3d6NC9HUmkyQ21IVm0wYUYxOFA0ZVE5?=
 =?utf-8?B?ZU1vMHVLUWV4dHdNRklCQm02S0JkSVBjUmk3MVBESm9pdThpV1Rldnh0K3R5?=
 =?utf-8?B?eDRmMWM0NHp0czJ2SzNuR3lMU0pac0s4MWpPd3ZnSjExVnZOMXpuWFZNWlNY?=
 =?utf-8?B?bWFpZ1Q3ZFdSVGhRNzN4RDBVY1NvcnJBZnM4dFhJbVp1L0w3K3l0U2JiSnE1?=
 =?utf-8?B?cWtqZE1RdldDTGlBYWl0dExud0R2SmgyQ3N3Zk4rczJoVXpMVUxCODdCN25Q?=
 =?utf-8?B?SEx3eGVQRU93YXZKWFptSFN3TlRaVzloTEpXbFh4Q3pDMGI1SFA0ajNxRGxQ?=
 =?utf-8?B?NzZCYmVYaFQ0bkhTOHhNdzltNzYvQWVGNisyOEtYeTQvUUVuYmFNMmNkdFdi?=
 =?utf-8?B?L3pndkxXQVZGN2pIYVB0ZzI5L3BqSklZL0FISHFZWkJub1E4OFBVb0xyZllX?=
 =?utf-8?B?WkhrdnBHdTN1c2l4VUZGeXFRRktDbTZaVEJ2ZlN3U28vcjdKSm9Vcm96RDQw?=
 =?utf-8?B?ZFNxTDJyZGlieVJZY3hINUx3Y2RXd2F2bENuNWNrZWRZZGpwRTRkL1AwcTJh?=
 =?utf-8?B?TStEalM0a0svMitIRUFqN3RhWDlZZnllMkdFTzY3VnBlSnpXV1JldUZyV2Jw?=
 =?utf-8?B?Yi8xUjVQbkY3YlV5Vm0xUmVneGFBYzJrSDJ1QWEzUjRjV3laS3JrU3FFVEU0?=
 =?utf-8?B?bmowMGNIQTNhckptS2Z4Um84UzNJVGtxTTdOUnJwOStQUDdSNE1wYjBrNnZT?=
 =?utf-8?B?Q1JtNGY4VlJxVDAyZUdLZm94ZnAzZUlXWmRDaGl4TnY4dFhuK2Q0N09ZOGZv?=
 =?utf-8?B?aGRVV3FYd2ZqVlBaSG84OHk5SGRvTTZSR2pLaDlZV3ZnMHpEai9jS3h0VVlm?=
 =?utf-8?B?enc2NmlSR29lRDNOMXBmWjErYlVyRThUMWgyOTRnMkd4Z3hKck9aK3ExSXdW?=
 =?utf-8?B?eW9Oa2YxNm1xeU1ieWVuK29ncHdmdWgxdGU3bk9mWlNrZ1ZKc25SOXdzUnM5?=
 =?utf-8?B?d0RPQk5aa1RiWitLdzJuazdYbHA3ZzgyNno0bDg3d0pLVDdNVUJRRm5oR3JC?=
 =?utf-8?B?Sll3eXZnTU1WQ0ZsbXFhNDc0MWtxelk0UDQwT202TjJYeGJCRlZKVmFHU1NG?=
 =?utf-8?B?NmJtZ1JBRG9YeWpFREg2K1BuZGxQdTl3NmZHZjFVOTFicUlXQTJQSnIxQjND?=
 =?utf-8?B?anpzZVV6OEtHdlBPZjY5SkdKUU9LMjJTSjMxTmpBdkJQdVIrbnpySkJsWTNn?=
 =?utf-8?B?UHRjdTNyZWNXZnBQVTVNMkU0eHMrRGYwOU5sUThKUjN3amRub1ZQR1lHM0xz?=
 =?utf-8?B?SnEwVXMrdkVSNGNIdzV4aXlPanpoTFFNY3hBUldIVDN3eHhOMmJvR2xSNnZV?=
 =?utf-8?Q?FNF2PItS8tZYnBk/lPs3LkTnT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5115b6-f191-499a-24a7-08dc11f2ff51
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 15:44:14.5396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jIj0+FR6xFp0ZOUsPQlnOxZKclbTLwrOHsiYuKvC1Wv4IUIKx9cGFTBu3W5+G9/Zb1j2GPhP5A9t82v0b2g/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
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
Cc: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2024-01-10 03:26, Srinivasan Shanmugam wrote:
> Range interval [start, last] is ordered by rb_tree, rb_prev, rb_next
> return value still needs NULL check, thus modified from "node" to "rb_node".
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:2691 svm_range_get_range_boundaries() warn: can 'node' even be NULL?
>
> Suggested-by: Philip Yang <Philip.Yang@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 3b78e48832e9..6aa032731ddc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2656,6 +2656,7 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
>   {
>   	struct vm_area_struct *vma;
>   	struct interval_tree_node *node;
> +	struct rb_node *rb_node;
>   	unsigned long start_limit, end_limit;
>   
>   	vma = vma_lookup(p->mm, addr << PAGE_SHIFT);
> @@ -2678,16 +2679,15 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
>   	if (node) {
>   		end_limit = min(end_limit, node->start);
>   		/* Last range that ends before the fault address */
> -		node = container_of(rb_prev(&node->rb),
> -				    struct interval_tree_node, rb);
> +		rb_node = rb_prev(&node->rb);
>   	} else {
>   		/* Last range must end before addr because
>   		 * there was no range after addr
>   		 */
> -		node = container_of(rb_last(&p->svms.objects.rb_root),
> -				    struct interval_tree_node, rb);
> +		rb_node = rb_last(&p->svms.objects.rb_root);
>   	}
> -	if (node) {
> +	if (rb_node) {
> +		node = container_of(rb_node, struct interval_tree_node, rb);
>   		if (node->last >= addr) {
>   			WARN(1, "Overlap with prev node and page fault addr\n");
>   			return -EFAULT;
