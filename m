Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79937606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HclQjqqb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E5210E18A;
	Mon, 26 Oct 2026 14:32:42 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D2310E18A
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 14:32:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpPbUESJxtXfL1seDAuunP7nqSATaXGnC7Cf4PKzwHYLY6S+k0RyvTQVEtz4LnHVHchjRwP1HJJfjOmWVE6quegaMTzHG8ldttXzmxeFCol6ugoCZSVRp0jTVlMN7jwvn8KPfuEtVUzpYhXN+MgIbHWpc4NCsJYWu1cLcKJbr6HcGC3SXydGVwxVzFZgR26MZFe3rPLCFf4g5IQl9veasWW7J/KAadEzceab7EOetfm/XCylX84pz5o5UmVHuzM5Wys5Wv0VqnzAsXuLzF7ZhPMddqkYrUJfQ1MkAURP6IzG2bC7MhEJgASKHkqnFYMDCSI+47Hs1zSeZj06gs83hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHYKlyqaDQ/WJp8RzzXgzF/SIJ5Uih4bMEomjubnz8I=;
 b=uxF/uLoA9tRPNgByzOSsISlNNgTZaMAQbAqX+dFtlfj8qIS+JzPZBQ/60mrCPzS9IQuZd23q6c/OMm0eju0wdq1vOPFtPq3ZUxKLLukM8DVOT2Dng53PMi0iHLGFA/o4GNhV3ooPvcDcNDqdlkUU5oKoT/9wsyl9YeUjJhsD23wxHyUvCpUS9gMJuvHxffQjUbQdhhuBi1zIWRQHSH+8gnVB3tl5kIzpkCZCk9mmvF3j3lH1T42VMeGxfQCQxmt9329uz8x7GvUZBW2uYuxPqc7d3LgPsUNnv7l7FswQYpgspM9S3kpgzLNMESo4v/rODqhUpwMXQ6B0eqxJhh4hhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHYKlyqaDQ/WJp8RzzXgzF/SIJ5Uih4bMEomjubnz8I=;
 b=HclQjqqbdlSr3qIS+LCYWv7NB5MBFSEvKb9jUNrzb51ElleScctq6K3jkqPyntSWPlffdXpPTv84IM1nklZhS1dEzyibhpG/u6K2Uv10DcnrGWHBnsuBE0HpjLP8pyn073tOK7g8GQj71ty2wbPJc3C6h/W9a/Hdg8F+7S3uHGw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 14:32:31 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 14:32:31 +0000
Content-Type: multipart/alternative;
 boundary="------------gnPbW0lCsvdYVx26DHzbAnQg"
Message-ID: <53899e72-b727-42ab-81ee-8587a10f16b7@amd.com>
Date: Mon, 26 Oct 2026 09:32:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still
 referenced
To: Apurv Mishra <Apurv.Mishra@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Alex.Sierra@amd.com,
 Harish.Kasiviswanathan@amd.com
References: <20261023171722.46301-1-Apurv.Mishra@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20261023171722.46301-1-Apurv.Mishra@amd.com>
X-ClientProxiedBy: PH7P220CA0048.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::19) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: f05e617a-e79d-42be-22f4-08df336df7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|3023799007|8096899003|56012099006|11063799006|261021121427099003|10067099003|261009223027099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: klJvcSMV4il1Ce0fDMPyjWM2vVelykXjApsbzM/HGlMzcewpnF6SQq1p+Urc0mnYRJcXk9IgBC41gA9RoZWJPzBK1vj3EK1msocRBd1TyfW+HPkOwJhwtrit5EtyAvouXYj5bXLLnePG7gX6L2ee+DUx3ORP8zTrBohsHSVyp7Kl7as0c1uTRc8s2Bt1k2BnzmS4VASO0bse5jBeBGXgLxZqrbrE7v3+0eCU1bx0EUUWVxOPZt66Ii3vIx72PBAIYhDAuVoRBRlLlW7rCBX58YI/cEUseysXOKSbCZTQ6nkb7bbker2oPeToXbZt+BoOZJfI1sU8mk1AGSgb1y08rlDDJzQCT48GAd8GohFbaN8ejGPymzGW7IiCQglmD53n3PnDN/MX5Fd4x/mLV1VOaRbc/UBiFTgPqcQl0xzXpssPnYAjKXEJxZgpjAiC5ibGzV7ePcFwMcTUoalR4En8ts8NrmttBBDIqt3a++bFDCLSkE0A9pBokx/OMUynXFDu2JFT+dWeeBZ3vi7OOFHJOImU+BgrpYEZqHhmGygFFBiieRl5l0yb7JCrv+SL4zVxuS5ZRu6jr8hFoVbOhvMv0s8vMqTPguSA1xWIjD89k5zH8Jc8WXA0y/8Nw2EOUfqW5DfPhLWfvFtf8MiM8b/EmCjCQcYS4c6mHvTFf5dEFWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(8096899003)(56012099006)(11063799006)(261021121427099003)(10067099003)(261009223027099003)(261022105027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEtiZTBaQUJOZnlhUm9iRzZRRnRIM3EvSEljaUhpMjhZblhUcXBCZGVTczIw?=
 =?utf-8?B?V09HTklBWFNVaU1SKyt2bHJUVkRnRnFFV2Z4L1RHb0d1Y2RhZjZYWUlGR0Fq?=
 =?utf-8?B?M0VGZXJJdWpjYXNhRlBoRGs4c2dFVFNVT21CSm83RGhjOFlMZEUvRHVMbWVR?=
 =?utf-8?B?OWpzQUp3L0RXbmE4ZFlXNUQrTGcxRklTaTZjM1NCaFZ4d250cGRDdjVkcFIy?=
 =?utf-8?B?VlRSTUZheW1XSUJzTVQ5RXFZK1Q4Y0V6TUgwR3QycHp6TVJuSmdrT0VyK1BB?=
 =?utf-8?B?UkNYUFpUcmVJYW1ySFN0M2lNMGJEMU9KVk0yQ2tBVmViVjZnRXIzL1U5bEU2?=
 =?utf-8?B?WkcraGRVSUdOc2o5MFo1L3VKMjZ1MzBIcmtFSHhuSFA5VnRTSHRPN05TdExZ?=
 =?utf-8?B?YTN2c2lrcXNqMGV6Q0hPTm5CNDBRM2dJYVBiME1VWEM1UHBqTVNucU1hOUFY?=
 =?utf-8?B?bnJCMVZOblg0eTJJZlZQTFNhcGV6TlZNaGV2MWYrSFVTUHJnaGFVendNdzNM?=
 =?utf-8?B?ZTdyb042V05xOTVuUkVxT3VBS1g5alpISGZsTVB4TTNJVi9wbG95eDg3M0RT?=
 =?utf-8?B?TDBTWlFNM3QxYzBJQkE2dFkvbWNnd0NtaG1rNmhqV2FKeUxDUU9ZNjQxQWNS?=
 =?utf-8?B?a0dtSGdoZFZyRmxqSUYvZGFjSkw1TkZCRGQrNjZNK3JBVVA1bE9SY09yMkk1?=
 =?utf-8?B?aE9CZ0lYSmdreHhTRTVhM0FOSUpRR043YlNoMTA5NVNrTm1keG1XWVF2dURa?=
 =?utf-8?B?cnJaZy85TG9ZUFUxdW5vTkxKb0E3MXpOTElJK1dmbzloNHMzUDZyRk1Lc2tJ?=
 =?utf-8?B?U0dnbnFmWWJBWGxQZzBFY0RqajBYTXZodXpCakNBY3h0ZUhzTkRuWjNRWlNK?=
 =?utf-8?B?QW40VlJkNHNzVG5tem9mb2s0SGw2QlFEZVVvRWEwbEJtL2FlTjZnUzRLZC9C?=
 =?utf-8?B?d3NXNDhHZDQra0NTTjNGNlRqMS90MXRJKzNSREV1UkxRT1I5Nks1NEo2OElF?=
 =?utf-8?B?MTlMM1JPT1hjNXcrOHpjQUlPciszeXdFTnZrY3E1SW8yYkdRQjVTTkFybFZn?=
 =?utf-8?B?dUQ1Um5wckpFOUw3SGlPOUE5RGduQ1A4NzhveURndnZmbkZtUTVpV3NSQlV3?=
 =?utf-8?B?Y2JtWEFQVDNhSFluR2pLQ0xuTUZFTlRieFpaOVA4ZzQzWDdwYURyM2V6L3lW?=
 =?utf-8?B?TGxGdXBnT3J5NkN5ekJCMWRWMVJuM1FSbXFWb212T1c1QnpUamo1NTlLZ25w?=
 =?utf-8?B?NVlzQ1FYeUZkb1FhMnlhMWUzMWl3dUdocHpLbG56SWNkR0ptRkExVlVpRVRq?=
 =?utf-8?B?cHNEUG5DYXNlSTVQNEJQS1I3aE4wa2hINzBIZFJZUElOc3FGTDlydWVZZUIz?=
 =?utf-8?B?WllNZXphL1dzcGFEbGh0alVaSkh0Tm1IdnBZNWpYbDNZTVdFZVJ5Q3JKdVVP?=
 =?utf-8?B?bFcvLzNDZmEzZWJOSFN5ZFV5bGNvWjZDUUpCQjlXNW10N3pBdlFRRHBiMDBX?=
 =?utf-8?B?TGdaVHA0L3U3QlZpL2VNRnhMcEgrMytZSnhZN0lJNGpndHB4d3B6WiswWURS?=
 =?utf-8?B?M0NxdjRhTXhVR3ZLcUhaMFBYNE5JM3p4a3NZaHNXUkpVYTkrRUNxNFhGQjFl?=
 =?utf-8?B?elBzdHNFekkyU1NRb3JDbjg2QXA0Z1NvUjBEVmE2UDc5clpLTFBraHdTdUFJ?=
 =?utf-8?B?Z0Q4R3NtdXNOMW52REo1aXdwZFJZVlVCZkFqa1kybGVmOC81cXJFUFNGLzlU?=
 =?utf-8?B?d3BwVE1WbVp4cWVMeVVQMkpVNnQrdlpic1dRTmNVeUxoc2lNZHNYcTVTWm10?=
 =?utf-8?B?TG5VbUs2cThUWVV2MDRBVUFIck13b1dyaEl1L1VUbmp5aUFWYkxxNUh3RTdY?=
 =?utf-8?B?VFBmMzhzcVovcnFQMUNBRWtmNDcwYnJNajJYT1hFVlRqMjV6Z1ZGYjlYN0ox?=
 =?utf-8?B?L1o0YURPMkdqZFQ0RDM2SWtmcHJYUk54MTArUjFieFo2czF1UTFXcGpwekRC?=
 =?utf-8?B?RzZ3OXJlMFlBL3pZWEVJMnpDVHdQbi9JNG1vV2l0cjJQY0VoZEpkbFgvM0tk?=
 =?utf-8?B?VVlVZnUvbUE3UXo1eGUyekZsU1RwUmVDUGNKdVhwSURNekxEVmdGWDlXYmVn?=
 =?utf-8?B?V05UdklzcGg0Ry83UzlqTy9tYmxjOWExdFJUYlpSN2pqZkVQemdEUUYzV3kv?=
 =?utf-8?B?cXNieUdPSCtOeDQzSXBmYjFsaXI5cXNzL2RMM3RkT1dDNUJmMG9JMktyZjV1?=
 =?utf-8?B?dW1WQVNxZWwvYVZHQ01xUWMvUkJ0RjJza2NSVVJoMVQ2RktOZEsyd0s0ZFRW?=
 =?utf-8?Q?qcpd87bETsg87kwpTC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05e617a-e79d-42be-22f4-08df336df7ed
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 14:32:31.5717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3dIF4UQQA1TTZ4qPJ9nZUpxxGW9GTdB20pn1w9Ogf2ho8RSR382UkysBw9EGCrM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------gnPbW0lCsvdYVx26DHzbAnQg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/23/2026 12:17 PM, Apurv Mishra wrote:
> In svm_migrate_copy_to_vram(), skip VRAM pages with a non-zero refcount
> and leave those pages in system memory for this migration.
>
> When an svm_bo is reused, a VRAM page can still be held by an in-flight
> CPU fault (do_swap_page -> svm_migrate_to_ram). Migrating to VRAM then
> re-initializes the page via zone_device_page_init(), resetting its
> refcount. The fault's late put_page() frees the page mid-migration, so
> migrate_vma_finalize() never restores that PTE. It is left pointing at a
> freed system page and hmm_range_fault() hits BUG_ON in
> pfn_swap_entry_to_page() (swapops.h).

If there is cpu fault the data is in vram page. If at same time driver 
is migrating data from sys->vram  migrate->src[i] & MIGRATE_PFN_MIGRATE 
should be false since the data is already at device side.

Then if you got a MIGRATE_PFN_MIGRAT sys ram page at 
svm_migrate_copy_to_vram after migrate_vma_setup, but cpu page fault 
also happened on same page there is a contradict.

So, I do not see this scenario can happen or the real cause is revealed.

Regards

Xiaogang

> Signed-off-by: Apurv Mishra<Apurv.Mishra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 8b96e1fe741a..1eb92ac6eb05 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -297,16 +297,26 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>   			 npages << PAGE_SHIFT, &cursor);
>   	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
> -		struct page *spage;
> +		struct page *spage = migrate_pfn_to_page(migrate->src[i]);
>   
>   		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>   			dst[i] = cursor.start + (j << PAGE_SHIFT);
>   			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
> -			svm_migrate_get_vram_page(prange, migrate->dst[i]);
> -			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
> -			mpages++;
> +			/*
> +			 * A reused svm_bo page may still be held by a CPU fault.
> +			 * Reinitializing it would free it under this migration,
> +			 * so leave this page in system memory.
> +			 */
> +			if (page_ref_count(pfn_to_page(migrate->dst[i]))) {
> +				dst[i] = 0;
> +				migrate->dst[i] = 0;
> +				spage = NULL;
> +			} else {
> +				svm_migrate_get_vram_page(prange, migrate->dst[i]);
> +				migrate->dst[i] = migrate_pfn(migrate->dst[i]);
> +				mpages++;
> +			}
>   		}
> -		spage = migrate_pfn_to_page(migrate->src[i]);
>   		if (spage && !is_zone_device_page(spage)) {
>   			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
>   					      DMA_BIDIRECTIONAL);
--------------gnPbW0lCsvdYVx26DHzbAnQg
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/23/2026 12:17 PM, Apurv Mishra
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261023171722.46301-1-Apurv.Mishra@amd.com">
      <pre wrap="" class="moz-quote-pre">In svm_migrate_copy_to_vram(), skip VRAM pages with a non-zero refcount
and leave those pages in system memory for this migration.

When an svm_bo is reused, a VRAM page can still be held by an in-flight
CPU fault (do_swap_page -&gt; svm_migrate_to_ram). Migrating to VRAM then
re-initializes the page via zone_device_page_init(), resetting its
refcount. The fault's late put_page() frees the page mid-migration, so
migrate_vma_finalize() never restores that PTE. It is left pointing at a
freed system page and hmm_range_fault() hits BUG_ON in
pfn_swap_entry_to_page() (swapops.h).</pre>
    </blockquote>
    <p>If there is cpu fault the data is in vram page. If at same time
      driver is migrating data from sys-&gt;vram&nbsp; migrate-&gt;src[i]
      &amp; MIGRATE_PFN_MIGRATE should be false since the data is
      already at device side.</p>
    <p>Then if you got a&nbsp;&nbsp;<span style="white-space: pre-wrap">MIGRATE_PFN_MIGRAT </span>sys
      ram page <span style="white-space: pre-wrap">at svm_migrate_copy_to_vram after migrate_vma_setup, but cpu page fault also happened on same page there is a contradict.</span></p>
    <p><span style="white-space: pre-wrap">So, I do not see this scenario can happen or the real cause is revealed.</span></p>
    <p>Regards</p>
    <p>Xiaogang</p>
    <blockquote type="cite" cite="mid:20261023171722.46301-1-Apurv.Mishra@amd.com">
      <pre wrap="" class="moz-quote-pre">
Signed-off-by: Apurv Mishra <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8b96e1fe741a..1eb92ac6eb05 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -297,16 +297,26 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	amdgpu_res_first(prange-&gt;ttm_res, ttm_res_offset,
 			 npages &lt;&lt; PAGE_SHIFT, &amp;cursor);
 	for (i = j = 0; (i &lt; npages) &amp;&amp; (mpages &lt; migrate-&gt;cpages); i++) {
-		struct page *spage;
+		struct page *spage = migrate_pfn_to_page(migrate-&gt;src[i]);
 
 		if (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {
 			dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
 			migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-			svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
-			migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
-			mpages++;
+			/*
+			 * A reused svm_bo page may still be held by a CPU fault.
+			 * Reinitializing it would free it under this migration,
+			 * so leave this page in system memory.
+			 */
+			if (page_ref_count(pfn_to_page(migrate-&gt;dst[i]))) {
+				dst[i] = 0;
+				migrate-&gt;dst[i] = 0;
+				spage = NULL;
+			} else {
+				svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
+				migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
+				mpages++;
+			}
 		}
-		spage = migrate_pfn_to_page(migrate-&gt;src[i]);
 		if (spage &amp;&amp; !is_zone_device_page(spage)) {
 			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
 					      DMA_BIDIRECTIONAL);
</pre>
    </blockquote>
  </body>
</html>

--------------gnPbW0lCsvdYVx26DHzbAnQg--
