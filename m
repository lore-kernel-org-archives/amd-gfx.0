Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03786CCF2C3
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 20:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74A1110E078;
	Fri, 16 Oct 2026 20:41:53 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4D710E078
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 20:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeLoDuZphraezO3AUQmlCtcRLgoNgRCSWdZzpxyRPacmHH+GdNs/3w0qNmID03XiP1+xLqHqXKHMJM/rLYPpe4kKoI3fOr+HVHHfwbfIzJlzpOBJ5p5XkH3gCsf6xCH3aXyiiA3cPcb0SQYJrsGqgn/7Lfa4N9ELic/M0l7g003+DWIqteRsceOTBuM79mxDGH5qiEBZd3jMxQxeUX5FYhOGyPBdAx/bTs0jTzZtyXYonDmeQ+UC0v1INdNJw/EoT4WuOQfupBRjW9V2Y18GStBNOqjOA6kgv/NCoMsg+Ws07B83t13NGHTak0AYkdg+BpcewbhSzIk9BSUriqVuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeJxuyhydL4ha2szAzlnjF9/j+/9fe9/mpl84F2IdNQ=;
 b=Brx9Qsrp5lfgZVSNJUE09O9yEXdEiQ8RapfP+uUSkOURLn5OmfS2/GBqe+DReLQ6N2HLigOkuAd+8TEntXxe9E5zt+bFtgsE5G6hDYCPkwy24Q64nFQHQIENq3hO9uaxbo2HdEoHX7BVr+cKtnSQs6n/wvNSc5LY5D+Mk/WtLDmKQeObxhPGIMF9Ut5ukjeC7ryyRZBy2D28sFwecMHtw3Kj7scFnAdCzxce7akXVvXninqmNp04dZSkujPacca69wyDSrIz6XjivRiBxnkMT+ecqPBeOZQUEX587jTm4QbghyhxbdJU2B/sAGryNRu17CAK+KFoQh1ElyNwnON6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeJxuyhydL4ha2szAzlnjF9/j+/9fe9/mpl84F2IdNQ=;
 b=WnI1FPwOzVzjrBtYbkS/bI3JZRNhAfe0pqPnLhlS+K1OQ3r4RIv+9Mv9v/kRVI3FIvB+FMob08mY1Plqjj2XeTxz6JxSLV3gbDHxpO5gOIDadfakYRuJibAj8G9DAB8JgHJgpOCbG6OFIFWgxoKJTfajxuQBRZrYA9oXZNqiY9A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by SA5PPF9BB0D8619.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Fri, 16 Oct
 2026 20:41:44 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 20:41:43 +0000
Content-Type: multipart/alternative;
 boundary="------------WsCwBfvR0ySSqZO18Ebp3nvn"
Message-ID: <7f2c36a2-72b2-40f8-b753-45c6ebdc891d@amd.com>
Date: Fri, 16 Oct 2026 16:41:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdkfd: split vram_pages of SVM ranges prefetched
 without a GPU mapping
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 David Yat Sin <david.yatsin@amd.com>
References: <20261013092158.2261502-1-Jesse.Zhang@amd.com>
 <20261013092158.2261502-4-Jesse.Zhang@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261013092158.2261502-4-Jesse.Zhang@amd.com>
X-ClientProxiedBy: YQBPR0101CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::11) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|SA5PPF9BB0D8619:EE_
X-MS-Office365-Filtering-Correlation-Id: 471cc540-69f1-4f40-aecf-08df2bc5e360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|10067099003|18002099003|8096899003|11063799006|4143699003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: aWVSFjtSGZEvktpyCuYHSbJBX3m5/J6wB28xWk7RPu/3KpPr/+a+doRAnGlV+muai7K8YRWK/tGYZd2A/cMPMjAZB33xHbKM6wIahLEkGtPQMzJwBCTIVh745wjzfOz5mPBo5RUOZ2LCDenL/7Hi2b7EIjqfV+OcAVXaWw+Wq6oghGKZox/W5nksJzM50Yv1+hysC2ty0cWUxmLo4YERQrGwo1ftyv6F6MdLuyqslUfKL1hcH2Ll8jIORmcTBYk70VwifJXs2sg1wWxegV+AiIAV/P4Wk4mYHIYhm1xcgEs18GskSEGAqPdBp9BOWiRR4Se27VNgdqmIWE0qu4yVNUlGeC4l9fGIhU7coItH0XNDaYhyKNxKgugEykheK0VlhNwXIUW04D0NvpC0n9x2aUU6JrsQEuFWYkScGS1yHCkjH2Tz29SzT1Il+iCQHEbwWsP8y6ZLYAszdOIimbQW3i9g5UhXDn5SGQS4qqTRyBGLe7Ag2sgHpqF4y4JnlPBtkwWOa2vzK0EE+hOpRLqwJ2JK++lmxagDey/zrQzbNPpGFOCg5PQAd91PHwZePRKruj7zujJaipIJBNdGOaXXyrZwwotWD4pvmfYPgkf84MZIQHAWEEJ3nvIYLBR9c93IXTnWlJx3Mm3+CoIoxVT3qfre++0B8UzLuUA8zTmG+dw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(10067099003)(18002099003)(8096899003)(11063799006)(4143699003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnFoamd6K2p4U29KQStBLzZQaWpuKzhvK2JlQ09RSmVsVUpxaFd2TkRJT0RZ?=
 =?utf-8?B?VDdTSHFXZUpnZ3pCWDNKWFFTWEtGYm5BMmt2azdYZjVQd1lTUTVDVVZmU1dl?=
 =?utf-8?B?VWtlMGFoekRmMzVLNEZCSCtUQlZtZU84TlM4NzZvVmZNTm52YW9qRkNieWxH?=
 =?utf-8?B?VWFpdE90VFNBZ2JzcG42b0FPMHZLRjJ5ZHZjeU1GZW1qTEZ4SUNnMEg2KzBH?=
 =?utf-8?B?Mk1SREViZi9aQit2Nnkya2dHS0xiQjhnZmgvUWViYTlHZmIzaktuZWwwS2la?=
 =?utf-8?B?ZFNwcUw5YW9udDl5THlyWlpWbUgvQS93Y1N0TndsNnJmMHlTN3UyNUlyejFJ?=
 =?utf-8?B?Rm4zZ3pRdUMwRlpHUTVtZGpDUlRWdE14bUpIK0tNRWpXVk9nVlRhdmtJQVlO?=
 =?utf-8?B?V0JFVlJwNkJwc2pDcEoyM1kzRGtqNDZXU3k3anpxNHRta0lJZWwxU21ST0I4?=
 =?utf-8?B?dzBXS0xlS3RyNHRlbGFWVVVNMlVhci9OT1Z0dXdLZkxZVy85aWtTYUg2Mklz?=
 =?utf-8?B?cXZjd3JTOGRkU2ZDTnhGU25WWlVNd2NCWlJsVmFrZlNteHNTVU9pSVQzTXpX?=
 =?utf-8?B?bXZ6VDEwTEpWSllzZ2Z0bTdibHp3Y3NnaUtUTGlJaFhkRmhtMVhKNS9iSXBM?=
 =?utf-8?B?M2E1Q3k1aEQ1TFpuUTRESC9qVGN0V0hMYS81SERFQSt2Rjc3RFRnODcwRDQ2?=
 =?utf-8?B?UU5wbnRMd1kzUEk5NDRMbUs2dUV6alpmNTBoSHhZYTNoNm9zSkJXdjdxSGpH?=
 =?utf-8?B?OXB2OGpQdXhJMkFicERBTjE0UzRjaVFGQVUzYldQV3dibGlyd3BLWXM3U3N1?=
 =?utf-8?B?OTlhQitIK2JwQjVKdHBOUEcrTk5SMjllU0hUUjhnN3dMRlFIVEJWdVpnNi81?=
 =?utf-8?B?S2VQQTVrcklMZkRHTTlqTTRtZXdaYlZ5M2k2dlhsY1luQzdTUVpkV2lNcmxi?=
 =?utf-8?B?Vzg3TFBpWVhDdVIvWU05MWJRZkxTZEVjeS9ZamRNSkdJMWM1Y1Y0WHoyZDNS?=
 =?utf-8?B?UGhuN3pZRVNQdU9VdHA4eWlHckcwUjA0M0xuczZ1ZUJpWE9neHRQTUNqOGFp?=
 =?utf-8?B?cFhtRHpPNjIwMEFFdkk3RndPTlJ3bXRPRUtxYThPWDNYZkFZYXc2QlZ5eDNL?=
 =?utf-8?B?WGNlaUtFZEpPdUdTQ2tBbHlZN2t5UDlOWjNIWnhyWEhrb0dVSS9veXdRNHFr?=
 =?utf-8?B?WEpQMjhHL0IvczN6Qzl6K0F1aElDZ2hEdVcyTU5RZ29TekRSaVgzS2hBNHo0?=
 =?utf-8?B?NVF0NWE4S3k0OFh1Q2ZoekNJU2NLc1JnbnEvcTJFaHgzOHp4OWNJT01IelA4?=
 =?utf-8?B?MVpSWkhFZzB5bnRtRVJ4ZDU2a3lqcTlxQWNaU0FBNVIyNE82WVJYVjBZQnY5?=
 =?utf-8?B?WHlkT0hyMXZUSWlPVFR5aUhpN0tDaEs4a1hSK3lhUVlrOUEzSzc2SDNHakh1?=
 =?utf-8?B?emk3N09aOVVCQ1h2dDlzWkRTMS9ITElva1VPRGVyS1o1TGcrR1ZIdS9kNk1R?=
 =?utf-8?B?YlhRLzE1b1dFRWh0SkpBbVhCbmZWSGxBZ3hmakQzWUlMWk4xcEUzWVpPSmZy?=
 =?utf-8?B?L0c2NFJ6a3VZcU5UOW5paENDZmk5aW5WVy9LV1ozdmJDc0YvWUFQVUd3VW9O?=
 =?utf-8?B?WEJ0aHBWQXVCWGllVy9Nalg4MllFSUZrZGt5UEhaZ3B3eWRYTXkwM3podVJS?=
 =?utf-8?B?akkrcmdWUnVEL0xUQ1VHQkJNUW9pOXNENmljSThqTHQ0L1F3V2JkV1FWeHNP?=
 =?utf-8?B?NllYRWZCOWI1aUNGZXp2UU4wZ0lYaWtISXpLRUtpdDg2OGE3MHZWTXJmRi9J?=
 =?utf-8?B?RG9KOGRCdnBHUGdjbHBSNUtFaDUwajd2NnVBM2t4NjhWZ3lLZDY0UmpENUtF?=
 =?utf-8?B?azA4UUo2Y05Jc0dFUWtobjgyaXFZb05xTkFhTi9Dem96N0tWZlB1UlIxZGhD?=
 =?utf-8?B?WUlZalpseUZCOWF2Z01UOEl2WTZxOGd2d0pyQVNXeEJGY0Z2R1l4ZnVQUHFa?=
 =?utf-8?B?VVhNZjFOc0pSdkR0YnZFRjg1b0IySDhlZVRIUHlwWE5MTGlrQ2JPTnhPSkR0?=
 =?utf-8?B?MEVLZXBvaXFXbHMyR0tDLzE4Q1p6ZTdYL2VuOThkTUpBbXkwUCtqbHA0TVFD?=
 =?utf-8?B?UnRRaDUzTGlVbk5HdG5YTmhYWjZJK0N0KzhSUnpWOU14bXNwUmJZZk8rVWFy?=
 =?utf-8?B?czMwZ0RJQXBCZW1ldzRYR253ZytKa3ZDQ0JvQjRtS2VkQ1RwZGtGWThvckRl?=
 =?utf-8?B?VVZUditrVUhUeStVSGU2NkpyMEhPYzNaV0NpbGdVd0lua1NBRzhBVnVWc0NL?=
 =?utf-8?Q?5LIPMCwBLoJK67rwi0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471cc540-69f1-4f40-aecf-08df2bc5e360
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 20:41:43.5754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jd8Cd6x0CCW1pFfOZav9CHR6Kmyj09h7tt4poyngPCsIaZCyU/9BI1Axf/6YW+Vs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9BB0D8619
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

--------------WsCwBfvR0ySSqZO18Ebp3nvn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-10-13 05:20, Jesse Zhang wrote:
> When an SVM range is split, svm_range_split_pages() gives the new range
> the number of VRAM pages counted in its part of the dma_addr arrays and
> subtracts it from the old range. Pages migrated to VRAM by a prefetch
> have no dma_addr entries until the range is mapped on a GPU, e.g. with
> no ACCESS attribute or before the first fault, so the new range gets 0
> and the old one keeps the count for both.
>
> Migrating the parts back to system memory then gets the accounting
> wrong: the old part keeps a VRAM page count after all its pages are
> gone, so its svm_bo is never freed, and the new part underflows. On
> navi31, as an unprivileged process: prefetch 4 MiB to the GPU, prefetch
> the upper 2 MiB and then the lower 2 MiB back to system memory:
>
>    Recorded vram pages(0x0) should not be less than migration pages(0x200).
>    WARNING: ../amdkfd/kfd_migrate.c:922 at svm_migrate_vram_to_ram+0xbdc/0xcd0 [amdgpu]
>
> and/sys/class/kfd/kfd/proc/<pid>/vram_<gpu_id> stays at 4194304 until
> the process exits.
>
> Without dma_addr arrays, the split is still exact when the old range is
> completely in VRAM, which is what a prefetch of the whole range leaves.
> Give the new range all its pages in that case. The warning is gone and
> the VRAM usage drops back to 0.
>
> Fixes: 006ad514a50c ("drm/amdkfd: Use partial hmm page walk during buffer validation in SVM")
> Signed-off-by: Jesse Zhang<Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 1f5d73f0ebce..7680fd59ecff 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1020,9 +1020,12 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
>   		      uint64_t start, uint64_t last)
>   {
>   	uint64_t npages = last - start + 1;
> +	bool counted = false;
>   	int i, r;
>   
>   	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
> +		if (old->dma_addr[i])
> +			counted = true;
>   		r = svm_range_split_array(&new->dma_addr[i], &old->dma_addr[i],
>   					  sizeof(*old->dma_addr[i]), old->start,
>   					  npages, new->start, new->npages,
> @@ -1030,8 +1033,15 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
>   		if (r)
>   			return r;
>   	}
> -	if (old->actual_loc)
> +	if (old->actual_loc) {
> +		/*
> +		 * Pages migrated by prefetch have no dma_addr until they are
> +		 * mapped on a GPU. A fully resident range still splits exactly.
> +		 */
> +		if (!counted && old->vram_pages == npages + new->npages)
> +			new->vram_pages = new->npages;
With XNACK off, svm_range_set_attr() leaves the GPU mapping update to 
the delayed restore worker rather than doing it inline, so the dma_addr 
arrays are not populated yet. The bug is a timing window: the prefetch 
back to system memory happens before the scheduled worker gets to run.

The fix, though, assumes prange->vram_pages == npages. That does not 
hold for a partial migration — svm_migrate_ram_to_vram() only adds the 
pages it actually migrated, so the range can be partly resident in VRAM 
with no dma_addr array, and the accounting is still wrong in that case.

Fixing it completely means redesigning the per-range VRAM page 
accounting so residency is tracked per page independently of dma_addr. 
That is a much bigger change, and this simple solution is good enough to 
fix the bug in front of us, so let's go with it. Two suggestions:

Rename bool counted to has_dma_addr

if (!has_dma_addr && old->vram_pages == old->npages)
         new->vram_pages = new->npages;

Please also mention the partial-migration limitation in the commit message.

Regards,
Philip
>   		old->vram_pages -= new->vram_pages;
> +	}
>   
>   	return 0;
>   }
> -- 2.50.1

--------------WsCwBfvR0ySSqZO18Ebp3nvn
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-10-13 05:20, Jesse Zhang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261013092158.2261502-4-Jesse.Zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">When an SVM range is split, svm_range_split_pages() gives the new range
the number of VRAM pages counted in its part of the dma_addr arrays and
subtracts it from the old range. Pages migrated to VRAM by a prefetch
have no dma_addr entries until the range is mapped on a GPU, e.g. with
no ACCESS attribute or before the first fault, so the new range gets 0
and the old one keeps the count for both.

Migrating the parts back to system memory then gets the accounting
wrong: the old part keeps a VRAM page count after all its pages are
gone, so its svm_bo is never freed, and the new part underflows. On
navi31, as an unprivileged process: prefetch 4 MiB to the GPU, prefetch
the upper 2 MiB and then the lower 2 MiB back to system memory:

  Recorded vram pages(0x0) should not be less than migration pages(0x200).
  WARNING: ../amdkfd/kfd_migrate.c:922 at svm_migrate_vram_to_ram+0xbdc/0xcd0 [amdgpu]

and <i class="moz-txt-slash"><span class="moz-txt-tag">/</span>sys/class/kfd/kfd/proc<span class="moz-txt-tag">/</span></i>&lt;pid&gt;/vram_&lt;gpu_id&gt; stays at 4194304 until
the process exits.

Without dma_addr arrays, the split is still exact when the old range is
completely in VRAM, which is what a prefetch of the whole range leaves.
Give the new range all its pages in that case. The warning is gone and
the VRAM usage drops back to 0.

Fixes: 006ad514a50c (&quot;drm/amdkfd: Use partial hmm page walk during buffer validation in SVM&quot;)
Signed-off-by: Jesse Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com" moz-do-not-send="true">&lt;Jesse.Zhang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 1f5d73f0ebce..7680fd59ecff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1020,9 +1020,12 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 		      uint64_t start, uint64_t last)
 {
 	uint64_t npages = last - start + 1;
+	bool counted = false;
 	int i, r;
 
 	for (i = 0; i &lt; MAX_GPU_INSTANCE; i++) {
+		if (old-&gt;dma_addr[i])
+			counted = true;
 		r = svm_range_split_array(&amp;new-&gt;dma_addr[i], &amp;old-&gt;dma_addr[i],
 					  sizeof(*old-&gt;dma_addr[i]), old-&gt;start,
 					  npages, new-&gt;start, new-&gt;npages,
@@ -1030,8 +1033,15 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 		if (r)
 			return r;
 	}
-	if (old-&gt;actual_loc)
+	if (old-&gt;actual_loc) {
+		/*
+		 * Pages migrated by prefetch have no dma_addr until they are
+		 * mapped on a GPU. A fully resident range still splits exactly.
+		 */
+		if (!counted &amp;&amp; old-&gt;vram_pages == npages + new-&gt;npages)
+			new-&gt;vram_pages = new-&gt;npages;</pre>
    </blockquote>
    With XNACK off, svm_range_set_attr() leaves the GPU mapping update
    to the delayed restore worker rather than doing it inline, so the
    dma_addr arrays are not populated yet. The bug is a timing window:
    the prefetch back to system memory happens before the scheduled
    worker gets to run.<br>
    <br>
    The fix, though, assumes prange-&gt;vram_pages == npages. That does
    not hold for a partial migration — svm_migrate_ram_to_vram() only
    adds the pages it actually migrated, so the range can be partly
    resident in VRAM with no dma_addr array, and the accounting is still
    wrong in that case.<br>
    <br>
    Fixing it completely means redesigning the per-range VRAM page
    accounting so residency is tracked per page independently of
    dma_addr. That is a much bigger change, and this simple solution is
    good enough to fix the bug in front of us, so let's go with it. Two
    suggestions:<br>
    <br>
    Rename bool counted to has_dma_addr<br>
    <br>
    if (!has_dma_addr &amp;&amp; old-&gt;vram_pages == old-&gt;npages)<br>
    &nbsp; &nbsp; &nbsp; &nbsp; new-&gt;vram_pages = new-&gt;npages;<br>
    <br>
    Please also mention the partial-migration limitation in the commit
    message.<br>
    <br>
    Regards,<br>
    Philip<br>
    <span style="white-space: pre-wrap"></span>
    <blockquote type="cite" cite="mid:20261013092158.2261502-4-Jesse.Zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		old-&gt;vram_pages -= new-&gt;vram_pages;
+	}
 
 	return 0;
 }
<div class="moz-txt-sig">-- 
2.50.1

</div></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------WsCwBfvR0ySSqZO18Ebp3nvn--
