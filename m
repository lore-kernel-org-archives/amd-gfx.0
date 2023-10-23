Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050D2C00A8F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 22:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2231310E275;
	Mon, 23 Oct 2023 22:21:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 736C110E275
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 22:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKoE04kGkW3uHIEjVZ5LNC20+jBQqr5J/bRJerehj1Qc/jTnAw6rUWlxgkwpBOXm8CVHJhX4bIVJ2whMg3g/hBVhPmhu8gsj+cRJUO5FkMUrRNCMsGdsVd9UiEFUCLi/ae5fZs/gi+KsTXTekRZdkXo7crrdX56Tca5YSkmfGwir8felKjH7KrPF+7O2/+aXQLvXZ/XkUPqfOLxJr6tpn56SpUJyioICL7mrIc76gPk2X0T8dACi65ARvptyW1GpnrdC+y0FwKxvTyb/ZT2s5LY/F2ylHnspeB8BNZ0H9wAknECS1soI1lzNNn6ug0YonDMI9jqL2rw+PiujpRfivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssVzSRqdSUBPkdWOxDDImgTKTbxOgCcEc669nb6nmb4=;
 b=AaxmzDMC4tOGGQU/W7Wed0y/prboMrRvuqo1d8MmEa7mw7pBvKDgfrotAgBODa+LcqY6+zhM2SpQb1+JyVYptsGkbm8OhnJf6DW7TOaxbrdRCzDDHpkKiLTTyQDQuLBBLwJzXbQohq6TU2hgCKDuqyMCVpkJlrMGNtX1YcEwbq02DKUWAxk/ttzhgf5zUeTiaoEPuo67cELSqs9YicCbEa32ekQlXKFHQPSEq5vQu31DpgXLrXrZodFqgrhfkn0mQ9XNQYY5qt5fuxThTpBoooziGDal2GoY7iqP+dB9k1HQ+WuJEvflpd1IE9yqFu0ktyNcI1mf9WormOlooX/lUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssVzSRqdSUBPkdWOxDDImgTKTbxOgCcEc669nb6nmb4=;
 b=RP/Nyxr5vzao9VAZ3oKnkOhqq4FKY8p6nXi8TDYleLuGDcF8SsgAfGyWfUACWNRNY9McliaoKt8HTk0U99wJR9sroVZ42iM01TzeOXkWMu6dxt8KptJ7gxpEP42HHyy1Ku1ApbcBx78EG4FzU+JFAZCkDLby4t/tAIFdehFdh8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 22:21:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31%4]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 22:21:03 +0000
Message-ID: <a56debc7-f016-486f-9eea-03abda7c8c77@amd.com>
Date: Mon, 23 Oct 2023 18:21:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] Revert "[PATCH] drm/amdkfd: Use partial migrations in
 GPU page faults"
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231023203703.31664-1-Philip.Yang@amd.com>
 <20231023203703.31664-3-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20231023203703.31664-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1fe4cd-3bb2-4cb0-e437-08dbd4165799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31YtHy0OHVu69yIdah0hD6E3UZVBsiykZ0Is2sLJlNlVPemWwoLMRDGAuR5vz07oV356660QDeWCLMH1H+woIjTauD8VpNizPfFPnUlRaEuwckzeWJe+Tjx1ssM1CmhxntUu2NtLNFq8wk04jdhZPW30JSo7UU2T57oeu3F/LqsglubU/gpyn/DtbgNWIrKoxuhqbzNbdy7TMu1ZzUBXoY2XO9AueyVZKTqJfBf5wRDdpDOWKB1DKTWk/wKx4f24EVr1V3yF1fURsO+QuFQijGskSf4G7xh/YkV1K8y4A4tp76mNE8pBCDndyeTz9emurIc3anSBAvjhPSYk22G77IHpPtaOlUDak6/KQg5OLVjVJVd0QBXneoaC5xDLDeUZWaKbZPEUtzkB71Oh+ZoH/cKTAgkglTpASbaisaQEO61TTCwiHUNo0uo2hTL4Ot/mBlvXfK9xQW7GgS7eK5bH0RTBUj8qD7W7pomWjF+qs5brhBh2JL79j9xBus29k+Zy+Q9OxluM9p9edpF1TP3fzddwJl2QOzlj7TJkD2r5sRJ8njjiTuZlyQbdOPB3uhWZO+HhRtwlzDJnTJiU3mG/HAMDDkXTAnxG6dqty6o3xg1/Ba7fuBMl1dNNgC0++wiH1kF+J6eCQUmkMOCaM5jT5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31686004)(86362001)(30864003)(2906002)(4001150100001)(5660300002)(8936002)(36756003)(8676002)(44832011)(41300700001)(38100700002)(316002)(6506007)(66556008)(6486002)(478600001)(31696002)(53546011)(6512007)(2616005)(26005)(83380400001)(66476007)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVFYamczUzdoaDB3emZhZjNOb0J1WHlmQTZocEltS0NkYjl0Z0ppMHFlSURO?=
 =?utf-8?B?bXBpYzhxRjRraUU3aktzaUxTUlNqTU9SRkhiZ0swYVBCbUljdGljcDI1SnI3?=
 =?utf-8?B?U2tPK3NIYWZxODhONnlTQ3IrMzNlczFkamZkUTczWkY4Z0gxcWVMVjlXdWJM?=
 =?utf-8?B?ampLK3N1OThnN1JOZWkvb054ZDJna1BxcGtiLzlLVWhmNmRHOHRpd1NScHRH?=
 =?utf-8?B?OGpTWHdoVWJES0htTmxnbnFRYlVaY2J1ZENaSUg5WHJ2WWZCMkJTZ1ZXRURB?=
 =?utf-8?B?cGpJTWFqTnBZM00wVkxPb05qM3pLczVOQkduams3Vi91V3JzSFJMcW1rbTdH?=
 =?utf-8?B?bzB0aEozT2NoWnhXNzk4WEQ4U2tFemF3eGhsYWRLOHU2ZERGUWkwVnlUOEJs?=
 =?utf-8?B?Vzl2Q1VaK1IvaEE4N1E4d21LdERSTzhkck9IWlJ4RDlndXQzd0kxNHluSDFr?=
 =?utf-8?B?dTNmOFBzSE5zK3JJL1pYZkdMRkNtWG8yQUk0U2ZyM1pNRjNLVE1JS1RVa1lT?=
 =?utf-8?B?K1BUYzc4alJNMkZXaVp0NG1Hb2VoOU0wa28zblZpZU94RXQwVHJGMXlIT1Ru?=
 =?utf-8?B?Y045ZEZQR0NVSGZKNnVQMUFIS3dubkxieW11cXBiREhSajNXUlRZVGlkK09i?=
 =?utf-8?B?SktEZW1qbG1ra0dnQmpYa2w3dk5aZ3RjRGZyeE9KMTVWeStRRWc2bWw2RWxQ?=
 =?utf-8?B?KzdBNWtOUzd2VnptNVh0V0ptRlVTQmdyYUtuSkJIRnFPQjNvbnArZDFqb1h2?=
 =?utf-8?B?cXdUUlJXajd1NnE4VXgwdGR4SGozNkxYbEJYMWJCbkQwWmo1c3grei94L0Qx?=
 =?utf-8?B?YmdQVkNUQnVCSWVLbkhNUmMzSnB6THBOUG9pQStxK0pKbFZwcitrRUQzaUFw?=
 =?utf-8?B?WjA0cFA0eWdaUDBaaXhqTTN4cnhlaDZlcFhFbjNlSGFGMUtIR1JxcFNHbXJB?=
 =?utf-8?B?b2JINzZPQm84OGx5dGpEbCtERXd3V0ZHRzZCSXYxVnJGVWw2VlZEQXg5Y2d3?=
 =?utf-8?B?ZWVBTGNlTUZYQkxJck5Vdk9pY2x1cUxMRlRva0FnQzc5cHNLOVNPdXlVYjJQ?=
 =?utf-8?B?R3FWYnErTkFFYXRYQXhRakZSb1ZQYmdrNkcyR0l3NGsvbWxhOU9XeWNuL0Qz?=
 =?utf-8?B?NHE0WmNIL2VyZ2tMRXE2bjNkWnpWWEpRVi9VSVlWZEIwYUxYVUZQRTVkTGUx?=
 =?utf-8?B?QjFYMFd2ckEvcnluWkxpWWZZNkRpNTRhYThlUlFkYnhHbnkzc1JPN0g1d2Ri?=
 =?utf-8?B?MEF6RnV1Wm01ZGx1Y3IwTHFoYVRCTFB4b0ExZWdqaWxPNStFODduYTByL1pu?=
 =?utf-8?B?d3RWWWQ2U0IvUFQycVE5U2NnSVdRR2JnYk54alArTlBYMGVyVHh3TGpBUHlD?=
 =?utf-8?B?UDNMNEdsUkJlU3kzL3J6STZvaE1EZXpLcTZ3bTRnd3BhdHpYTFIwTWlmQnda?=
 =?utf-8?B?S0xSM0dDK3F2QVM0eER2cFFEWGJuNkg4U2JEYUVkalVHV1JjTHBkeElMOVB2?=
 =?utf-8?B?WTRITHRlREpkVVdMcVA0VmtxVXF1clNZall3WUpjUGtNUXlBUDBTSXREZG15?=
 =?utf-8?B?cG93TTFZY2s2ZzJ6WS9LSmMwOFVGbHF5czR4bTNBUkpCTFVrZGE4REtEeGVI?=
 =?utf-8?B?cm5tZ3hCYkhzWWVLUnJaVnk3aVRPTmhVS29Xb2o2TnRaMUJxb0JCREE0QUN4?=
 =?utf-8?B?bmtSQlBXSmFEZXRoQ05PR1hlbTI5NkQrNldGaC9RVG9EcHAxNEpBUGNWSjNL?=
 =?utf-8?B?M1VaWnllOXZYWmNsQ05Vay9YSTB6QUsva005SkxrazhLMDROSndjL2o0Z0Z3?=
 =?utf-8?B?WWZUK0lBbWRmMjJrQ2FCWFEvYnovTXd0MTZRd3kxdTE2TVk2aG9jKzNLcmpU?=
 =?utf-8?B?U3BxQzBMb0FjL3VHR0duLzNQZ0FQRXM3enVjc2ZnVk5tMk5zd0grUjh6bnN4?=
 =?utf-8?B?YzZPa0dYenV5MFdxWWVKWDJEQVBjU3lMY1A5L2NvZzd1b2pKbVh2R29ob1Q3?=
 =?utf-8?B?czRSTkJzSVlNYlZXRXgzRkRlMTBsQVNYclI1cldybjZtUE92OEhuY3Ewcms4?=
 =?utf-8?B?Wmo3MEMxelFObzM0YjUwRXp0YUdjRFo5RVRjcGR6aEpMU0ZFL1BKSjdCZE9u?=
 =?utf-8?Q?UYMGKStU8MLDpafEB9Dqft8/o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1fe4cd-3bb2-4cb0-e437-08dbd4165799
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 22:21:02.9781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/RAvNROBA6WQ3VqfSXptbyr08k5Wj4jnhHnlyo+sMIMwYcP0iZCc7owBbvwZupkVY08v0H6wmw143nPpL5ijw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
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

On 2023-10-23 16:37, Philip Yang wrote:
> This reverts commit 1fd60d88c4b57d715c0ae09794061c0cc53009e3.
>
> The change prevents migrating the entire range to VRAM because retry
> fault restore_pages map the remaining system memory range to GPUs. It
> will work correctly to submit together with partial mapping to GPU
> patch later.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

The series is Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 150 ++++++++++-------------
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |   6 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  83 +++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |   6 +-
>   4 files changed, 85 insertions(+), 160 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 81d25a679427..6c25dab051d5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -442,10 +442,10 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   		goto out_free;
>   	}
>   	if (cpages != npages)
> -		pr_debug("partial migration, 0x%lx/0x%llx pages collected\n",
> +		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
>   			 cpages, npages);
>   	else
> -		pr_debug("0x%lx pages collected\n", cpages);
> +		pr_debug("0x%lx pages migrated\n", cpages);
>   
>   	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
>   	migrate_vma_pages(&migrate);
> @@ -479,8 +479,6 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>    * svm_migrate_ram_to_vram - migrate svm range from system to device
>    * @prange: range structure
>    * @best_loc: the device to migrate to
> - * @start_mgr: start page to migrate
> - * @last_mgr: last page to migrate
>    * @mm: the process mm structure
>    * @trigger: reason of migration
>    *
> @@ -491,7 +489,6 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>    */
>   static int
>   svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
> -			unsigned long start_mgr, unsigned long last_mgr,
>   			struct mm_struct *mm, uint32_t trigger)
>   {
>   	unsigned long addr, start, end;
> @@ -501,30 +498,23 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	unsigned long cpages = 0;
>   	long r = 0;
>   
> -	if (!best_loc) {
> -		pr_debug("svms 0x%p [0x%lx 0x%lx] migrate to sys ram\n",
> -			prange->svms, start_mgr, last_mgr);
> +	if (prange->actual_loc == best_loc) {
> +		pr_debug("svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n",
> +			 prange->svms, prange->start, prange->last, best_loc);
>   		return 0;
>   	}
>   
> -	if (start_mgr < prange->start || last_mgr > prange->last) {
> -		pr_debug("range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n",
> -				 start_mgr, last_mgr, prange->start, prange->last);
> -		return -EFAULT;
> -	}
> -
>   	node = svm_range_get_node_by_id(prange, best_loc);
>   	if (!node) {
>   		pr_debug("failed to get kfd node by id 0x%x\n", best_loc);
>   		return -ENODEV;
>   	}
>   
> -	pr_debug("svms 0x%p [0x%lx 0x%lx] in [0x%lx 0x%lx] to gpu 0x%x\n",
> -		prange->svms, start_mgr, last_mgr, prange->start, prange->last,
> -		best_loc);
> +	pr_debug("svms 0x%p [0x%lx 0x%lx] to gpu 0x%x\n", prange->svms,
> +		 prange->start, prange->last, best_loc);
>   
> -	start = start_mgr << PAGE_SHIFT;
> -	end = (last_mgr + 1) << PAGE_SHIFT;
> +	start = prange->start << PAGE_SHIFT;
> +	end = (prange->last + 1) << PAGE_SHIFT;
>   
>   	r = svm_range_vram_node_new(node, prange, true);
>   	if (r) {
> @@ -554,11 +544,8 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   
>   	if (cpages) {
>   		prange->actual_loc = best_loc;
> -		prange->vram_pages = prange->vram_pages + cpages;
> -	} else if (!prange->actual_loc) {
> -		/* if no page migrated and all pages from prange are at
> -		 * sys ram drop svm_bo got from svm_range_vram_node_new
> -		 */
> +		svm_range_dma_unmap(prange);
> +	} else {
>   		svm_range_vram_node_free(prange);
>   	}
>   
> @@ -676,8 +663,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>    * Context: Process context, caller hold mmap read lock, prange->migrate_mutex
>    *
>    * Return:
> + *   0 - success with all pages migrated
>    *   negative values - indicate error
> - *   positive values or zero - number of pages got migrated
> + *   positive values - partial migration, number of pages not migrated
>    */
>   static long
>   svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
> @@ -688,7 +676,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
>   	unsigned long upages = npages;
>   	unsigned long cpages = 0;
> -	unsigned long mpages = 0;
>   	struct amdgpu_device *adev = node->adev;
>   	struct kfd_process_device *pdd;
>   	struct dma_fence *mfence = NULL;
> @@ -738,10 +725,10 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   		goto out_free;
>   	}
>   	if (cpages != npages)
> -		pr_debug("partial migration, 0x%lx/0x%llx pages collected\n",
> +		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
>   			 cpages, npages);
>   	else
> -		pr_debug("0x%lx pages collected\n", cpages);
> +		pr_debug("0x%lx pages migrated\n", cpages);
>   
>   	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
>   				    scratch, npages);
> @@ -764,21 +751,17 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	kvfree(buf);
>   out:
>   	if (!r && cpages) {
> -		mpages = cpages - upages;
>   		pdd = svm_range_get_pdd_by_node(prange, node);
>   		if (pdd)
> -			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
> +			WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
>   	}
> -
> -	return r ? r : mpages;
> +	return r ? r : upages;
>   }
>   
>   /**
>    * svm_migrate_vram_to_ram - migrate svm range from device to system
>    * @prange: range structure
>    * @mm: process mm, use current->mm if NULL
> - * @start_mgr: start page need be migrated to sys ram
> - * @last_mgr: last page need be migrated to sys ram
>    * @trigger: reason of migration
>    * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is CPU page fault callback
>    *
> @@ -788,7 +771,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>    * 0 - OK, otherwise error code
>    */
>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
> -			    unsigned long start_mgr, unsigned long last_mgr,
>   			    uint32_t trigger, struct page *fault_page)
>   {
>   	struct kfd_node *node;
> @@ -796,33 +778,26 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   	unsigned long addr;
>   	unsigned long start;
>   	unsigned long end;
> -	unsigned long mpages = 0;
> +	unsigned long upages = 0;
>   	long r = 0;
>   
> -	/* this pragne has no any vram page to migrate to sys ram */
>   	if (!prange->actual_loc) {
>   		pr_debug("[0x%lx 0x%lx] already migrated to ram\n",
>   			 prange->start, prange->last);
>   		return 0;
>   	}
>   
> -	if (start_mgr < prange->start || last_mgr > prange->last) {
> -		pr_debug("range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n",
> -				 start_mgr, last_mgr, prange->start, prange->last);
> -		return -EFAULT;
> -	}
> -
>   	node = svm_range_get_node_by_id(prange, prange->actual_loc);
>   	if (!node) {
>   		pr_debug("failed to get kfd node by id 0x%x\n", prange->actual_loc);
>   		return -ENODEV;
>   	}
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n",
> -		 prange->svms, prange, start_mgr, last_mgr,
> +		 prange->svms, prange, prange->start, prange->last,
>   		 prange->actual_loc);
>   
> -	start = start_mgr << PAGE_SHIFT;
> -	end = (last_mgr + 1) << PAGE_SHIFT;
> +	start = prange->start << PAGE_SHIFT;
> +	end = (prange->last + 1) << PAGE_SHIFT;
>   
>   	for (addr = start; addr < end;) {
>   		unsigned long next;
> @@ -841,21 +816,14 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   			pr_debug("failed %ld to migrate prange %p\n", r, prange);
>   			break;
>   		} else {
> -			mpages += r;
> +			upages += r;
>   		}
>   		addr = next;
>   	}
>   
> -	if (r >= 0) {
> -		prange->vram_pages -= mpages;
> -
> -		/* prange does not have vram page set its actual_loc to system
> -		 * and drop its svm_bo ref
> -		 */
> -		if (prange->vram_pages == 0 && prange->ttm_res) {
> -			prange->actual_loc = 0;
> -			svm_range_vram_node_free(prange);
> -		}
> +	if (r >= 0 && !upages) {
> +		svm_range_vram_node_free(prange);
> +		prange->actual_loc = 0;
>   	}
>   
>   	return r < 0 ? r : 0;
> @@ -865,23 +833,17 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>    * svm_migrate_vram_to_vram - migrate svm range from device to device
>    * @prange: range structure
>    * @best_loc: the device to migrate to
> - * @start: start page need be migrated to sys ram
> - * @last: last page need be migrated to sys ram
>    * @mm: process mm, use current->mm if NULL
>    * @trigger: reason of migration
>    *
>    * Context: Process context, caller hold mmap read lock, svms lock, prange lock
>    *
> - * migrate all vram pages in prange to sys ram, then migrate
> - * [start, last] pages from sys ram to gpu node best_loc.
> - *
>    * Return:
>    * 0 - OK, otherwise error code
>    */
>   static int
>   svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
> -			unsigned long start, unsigned long last,
> -			struct mm_struct *mm, uint32_t trigger)
> +			 struct mm_struct *mm, uint32_t trigger)
>   {
>   	int r, retries = 3;
>   
> @@ -893,8 +855,7 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
>   
>   	do {
> -		r = svm_migrate_vram_to_ram(prange, mm, prange->start, prange->last,
> -								trigger, NULL);
> +		r = svm_migrate_vram_to_ram(prange, mm, trigger, NULL);
>   		if (r)
>   			return r;
>   	} while (prange->actual_loc && --retries);
> @@ -902,21 +863,17 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	if (prange->actual_loc)
>   		return -EDEADLK;
>   
> -	return svm_migrate_ram_to_vram(prange, best_loc, start, last, mm, trigger);
> +	return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
>   }
>   
>   int
>   svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
> -			unsigned long start, unsigned long last,
> -			struct mm_struct *mm, uint32_t trigger)
> +		    struct mm_struct *mm, uint32_t trigger)
>   {
> -	if  (!prange->actual_loc || prange->actual_loc == best_loc)
> -		return svm_migrate_ram_to_vram(prange, best_loc, start, last,
> -						mm, trigger);
> -
> +	if  (!prange->actual_loc)
> +		return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
>   	else
> -		return svm_migrate_vram_to_vram(prange, best_loc, start, last,
> -						mm, trigger);
> +		return svm_migrate_vram_to_vram(prange, best_loc, mm, trigger);
>   
>   }
>   
> @@ -932,9 +889,10 @@ svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
>    */
>   static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   {
> -	unsigned long start, last, size;
>   	unsigned long addr = vmf->address;
>   	struct svm_range_bo *svm_bo;
> +	enum svm_work_list_ops op;
> +	struct svm_range *parent;
>   	struct svm_range *prange;
>   	struct kfd_process *p;
>   	struct mm_struct *mm;
> @@ -971,31 +929,51 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   
>   	mutex_lock(&p->svms.lock);
>   
> -	prange = svm_range_from_addr(&p->svms, addr, NULL);
> +	prange = svm_range_from_addr(&p->svms, addr, &parent);
>   	if (!prange) {
>   		pr_debug("failed get range svms 0x%p addr 0x%lx\n", &p->svms, addr);
>   		r = -EFAULT;
>   		goto out_unlock_svms;
>   	}
>   
> -	mutex_lock(&prange->migrate_mutex);
> +	mutex_lock(&parent->migrate_mutex);
> +	if (prange != parent)
> +		mutex_lock_nested(&prange->migrate_mutex, 1);
>   
>   	if (!prange->actual_loc)
>   		goto out_unlock_prange;
>   
> -	/* Align migration range start and size to granularity size */
> -	size = 1UL << prange->granularity;
> -	start = max(ALIGN_DOWN(addr, size), prange->start);
> -	last = min(ALIGN(addr + 1, size) - 1, prange->last);
> +	svm_range_lock(parent);
> +	if (prange != parent)
> +		mutex_lock_nested(&prange->lock, 1);
> +	r = svm_range_split_by_granularity(p, mm, addr, parent, prange);
> +	if (prange != parent)
> +		mutex_unlock(&prange->lock);
> +	svm_range_unlock(parent);
> +	if (r) {
> +		pr_debug("failed %d to split range by granularity\n", r);
> +		goto out_unlock_prange;
> +	}
>   
> -	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm, start, last,
> -						KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page);
> +	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm,
> +				    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
> +				    vmf->page);
>   	if (r)
>   		pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 0x%lx]\n",
> -			r, prange->svms, prange, start, last);
> +			 r, prange->svms, prange, prange->start, prange->last);
> +
> +	/* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
> +	if (p->xnack_enabled && parent == prange)
> +		op = SVM_OP_UPDATE_RANGE_NOTIFIER_AND_MAP;
> +	else
> +		op = SVM_OP_UPDATE_RANGE_NOTIFIER;
> +	svm_range_add_list_work(&p->svms, parent, mm, op);
> +	schedule_deferred_list_work(&p->svms);
>   
>   out_unlock_prange:
> -	mutex_unlock(&prange->migrate_mutex);
> +	if (prange != parent)
> +		mutex_unlock(&prange->migrate_mutex);
> +	mutex_unlock(&parent->migrate_mutex);
>   out_unlock_svms:
>   	mutex_unlock(&p->svms.lock);
>   out_unref_process:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> index 9e48d10e848e..487f26368164 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> @@ -41,13 +41,9 @@ enum MIGRATION_COPY_DIR {
>   };
>   
>   int svm_migrate_to_vram(struct svm_range *prange,  uint32_t best_loc,
> -			unsigned long start, unsigned long last,
>   			struct mm_struct *mm, uint32_t trigger);
> -
>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
> -			unsigned long start, unsigned long last,
> -			uint32_t trigger, struct page *fault_page);
> -
> +			    uint32_t trigger, struct page *fault_page);
>   unsigned long
>   svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 3422eee8d0d0..eedce1259e94 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -156,13 +156,12 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
>   static int
>   svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>   		      unsigned long offset, unsigned long npages,
> -		      unsigned long *hmm_pfns, uint32_t gpuidx, uint64_t *vram_pages)
> +		      unsigned long *hmm_pfns, uint32_t gpuidx)
>   {
>   	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
>   	dma_addr_t *addr = prange->dma_addr[gpuidx];
>   	struct device *dev = adev->dev;
>   	struct page *page;
> -	uint64_t vram_pages_dev;
>   	int i, r;
>   
>   	if (!addr) {
> @@ -172,7 +171,6 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>   		prange->dma_addr[gpuidx] = addr;
>   	}
>   
> -	vram_pages_dev = 0;
>   	addr += offset;
>   	for (i = 0; i < npages; i++) {
>   		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
> @@ -182,7 +180,6 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>   		if (is_zone_device_page(page)) {
>   			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
>   
> -			vram_pages_dev++;
>   			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
>   				   bo_adev->vm_manager.vram_base_offset -
>   				   bo_adev->kfd.pgmap.range.start;
> @@ -199,14 +196,13 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>   		pr_debug_ratelimited("dma mapping 0x%llx for page addr 0x%lx\n",
>   				     addr[i] >> PAGE_SHIFT, page_to_pfn(page));
>   	}
> -	*vram_pages = vram_pages_dev;
>   	return 0;
>   }
>   
>   static int
>   svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>   		  unsigned long offset, unsigned long npages,
> -		  unsigned long *hmm_pfns, uint64_t *vram_pages)
> +		  unsigned long *hmm_pfns)
>   {
>   	struct kfd_process *p;
>   	uint32_t gpuidx;
> @@ -225,7 +221,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>   		}
>   
>   		r = svm_range_dma_map_dev(pdd->dev->adev, prange, offset, npages,
> -					  hmm_pfns, gpuidx, vram_pages);
> +					  hmm_pfns, gpuidx);
>   		if (r)
>   			break;
>   	}
> @@ -351,7 +347,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	INIT_LIST_HEAD(&prange->child_list);
>   	atomic_set(&prange->invalid, 0);
>   	prange->validate_timestamp = 0;
> -	prange->vram_pages = 0;
>   	mutex_init(&prange->migrate_mutex);
>   	mutex_init(&prange->lock);
>   
> @@ -398,8 +393,6 @@ static void svm_range_bo_release(struct kref *kref)
>   			 prange->start, prange->last);
>   		mutex_lock(&prange->lock);
>   		prange->svm_bo = NULL;
> -		/* prange should not hold vram page now */
> -		WARN_ON(prange->actual_loc);
>   		mutex_unlock(&prange->lock);
>   
>   		spin_lock(&svm_bo->list_lock);
> @@ -980,11 +973,6 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
>   	new->svm_bo = svm_range_bo_ref(old->svm_bo);
>   	new->ttm_res = old->ttm_res;
>   
> -	/* set new's vram_pages as old range's now, the acurate vram_pages
> -	 * will be updated during mapping
> -	 */
> -	new->vram_pages = min(old->vram_pages, new->npages);
> -
>   	spin_lock(&new->svm_bo->list_lock);
>   	list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>   	spin_unlock(&new->svm_bo->list_lock);
> @@ -1631,7 +1619,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   	struct svm_validate_context *ctx;
>   	unsigned long start, end, addr;
>   	struct kfd_process *p;
> -	uint64_t vram_pages;
>   	void *owner;
>   	int32_t idx;
>   	int r = 0;
> @@ -1700,13 +1687,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		}
>   	}
>   
> -	vram_pages = 0;
>   	start = prange->start << PAGE_SHIFT;
>   	end = (prange->last + 1) << PAGE_SHIFT;
>   	for (addr = start; !r && addr < end; ) {
>   		struct hmm_range *hmm_range;
>   		struct vm_area_struct *vma;
> -		uint64_t vram_pages_vma;
>   		unsigned long next = 0;
>   		unsigned long offset;
>   		unsigned long npages;
> @@ -1735,11 +1720,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		if (!r) {
>   			offset = (addr - start) >> PAGE_SHIFT;
>   			r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
> -					      hmm_range->hmm_pfns, &vram_pages_vma);
> +					      hmm_range->hmm_pfns);
>   			if (r)
>   				pr_debug("failed %d to dma map range\n", r);
> -			else
> -				vram_pages += vram_pages_vma;
>   		}
>   
>   		svm_range_lock(prange);
> @@ -1765,19 +1748,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		addr = next;
>   	}
>   
> -	if (addr == end) {
> -		prange->vram_pages = vram_pages;
> -
> -		/* if prange does not include any vram page and it
> -		 * has not released svm_bo drop its svm_bo reference
> -		 * and set its actaul_loc to sys ram
> -		 */
> -		if (!vram_pages && prange->ttm_res) {
> -			prange->actual_loc = 0;
> -			svm_range_vram_node_free(prange);
> -		}
> -	}
> -
>   	svm_range_unreserve_bos(ctx);
>   	if (!r)
>   		prange->validate_timestamp = ktime_get_boottime();
> @@ -2030,7 +2000,6 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
>   	new->mapped_to_gpu = old->mapped_to_gpu;
> -	new->vram_pages = old->vram_pages;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>   
> @@ -2940,7 +2909,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   			uint32_t vmid, uint32_t node_id,
>   			uint64_t addr, bool write_fault)
>   {
> -	unsigned long start, last, size;
>   	struct mm_struct *mm = NULL;
>   	struct svm_range_list *svms;
>   	struct svm_range *prange;
> @@ -3076,35 +3044,32 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
>   				       write_fault, timestamp);
>   
> -	if (prange->actual_loc != 0 || best_loc != 0) {
> +	if (prange->actual_loc != best_loc) {
>   		migration = true;
> -		/* Align migration range start and size to granularity size */
> -		size = 1UL << prange->granularity;
> -		start = max_t(unsigned long, ALIGN_DOWN(addr, size), prange->start);
> -		last = min_t(unsigned long, ALIGN(addr + 1, size) - 1, prange->last);
> -
>   		if (best_loc) {
> -			r = svm_migrate_to_vram(prange, best_loc, start, last,
> -					mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
> +			r = svm_migrate_to_vram(prange, best_loc, mm,
> +					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>   			if (r) {
>   				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
>   					 r, addr);
>   				/* Fallback to system memory if migration to
>   				 * VRAM failed
>   				 */
> -				if (prange->actual_loc && prange->actual_loc != best_loc)
> -					r = svm_migrate_vram_to_ram(prange, mm, start, last,
> -						KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
> +				if (prange->actual_loc)
> +					r = svm_migrate_vram_to_ram(prange, mm,
> +					   KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
> +					   NULL);
>   				else
>   					r = 0;
>   			}
>   		} else {
> -			r = svm_migrate_vram_to_ram(prange, mm, start, last,
> -					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
> +			r = svm_migrate_vram_to_ram(prange, mm,
> +					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
> +					NULL);
>   		}
>   		if (r) {
>   			pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
> -				 r, svms, start, last);
> +				 r, svms, prange->start, prange->last);
>   			goto out_unlock_range;
>   		}
>   	}
> @@ -3458,24 +3423,18 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
>   	*migrated = false;
>   	best_loc = svm_range_best_prefetch_location(prange);
>   
> -	/* when best_loc is a gpu node and same as prange->actual_loc
> -	 * we still need do migration as prange->actual_loc !=0 does
> -	 * not mean all pages in prange are vram. hmm migrate will pick
> -	 * up right pages during migration.
> -	 */
> -	if ((best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED) ||
> -	    (best_loc == 0 && prange->actual_loc == 0))
> +	if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
> +	    best_loc == prange->actual_loc)
>   		return 0;
>   
>   	if (!best_loc) {
> -		r = svm_migrate_vram_to_ram(prange, mm, prange->start, prange->last,
> +		r = svm_migrate_vram_to_ram(prange, mm,
>   					KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
>   		*migrated = !r;
>   		return r;
>   	}
>   
> -	r = svm_migrate_to_vram(prange, best_loc, prange->start, prange->last,
> -				mm, KFD_MIGRATE_TRIGGER_PREFETCH);
> +	r = svm_migrate_to_vram(prange, best_loc, mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>   	*migrated = !r;
>   
>   	return r;
> @@ -3530,11 +3489,7 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   
>   		mutex_lock(&prange->migrate_mutex);
>   		do {
> -			/* migrate all vram pages in this prange to sys ram
> -			 * after that prange->actual_loc should be zero
> -			 */
>   			r = svm_migrate_vram_to_ram(prange, mm,
> -					prange->start, prange->last,
>   					KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
>   		} while (!r && prange->actual_loc && --retries);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index be11ba0c4289..c528df1d0ba2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -78,7 +78,6 @@ struct svm_work_list_item {
>    * @update_list:link list node used to add to update_list
>    * @mapping:    bo_va mapping structure to create and update GPU page table
>    * @npages:     number of pages
> - * @vram_pages: vram pages number in this svm_range
>    * @dma_addr:   dma mapping address on each GPU for system memory physical page
>    * @ttm_res:    vram ttm resource map
>    * @offset:     range start offset within mm_nodes
> @@ -89,9 +88,7 @@ struct svm_work_list_item {
>    * @flags:      flags defined as KFD_IOCTL_SVM_FLAG_*
>    * @perferred_loc: perferred location, 0 for CPU, or GPU id
>    * @perfetch_loc: last prefetch location, 0 for CPU, or GPU id
> - * @actual_loc: this svm_range location. 0: all pages are from sys ram;
> - *              GPU id: this svm_range may include vram pages from GPU with
> - *              id actual_loc.
> + * @actual_loc: the actual location, 0 for CPU, or GPU id
>    * @granularity:migration granularity, log2 num pages
>    * @invalid:    not 0 means cpu page table is invalidated
>    * @validate_timestamp: system timestamp when range is validated
> @@ -115,7 +112,6 @@ struct svm_range {
>   	struct list_head		list;
>   	struct list_head		update_list;
>   	uint64_t			npages;
> -	uint64_t			vram_pages;
>   	dma_addr_t			*dma_addr[MAX_GPU_INSTANCE];
>   	struct ttm_resource		*ttm_res;
>   	uint64_t			offset;
