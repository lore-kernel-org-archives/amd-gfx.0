Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3E5C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9675961425
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9675961425
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131FB6EAAE;
	Thu, 22 Apr 2021 15:31:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 755C86EAAE
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 15:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKO+YcAgq2dQeyg+GqKOPjih+ZWFL+DSf/eanoB0UgIoOic5fflgW0vDfplmWhz7qlPPE6Q68Y3RfnfvWUPPgSJASGgKtxktclXO+McJgEN0OpU4s/bLZTnAkyZXEJNFhbdEyh2kXpM6QoWKWOO802X6AYJqavoFsINvs7+q0Tj788aWDShwm4Kz56Z5K2oT4uej3NcMsSw2BhuDysx/2K7o+HkY3k2TVDv3BXMAKys5a2KIjn0dyxxeijCKJch30rj/pPEIOwzEA/IcmLP7YG6vVlBkIq2zhgjMaA9TT2fOgwtvpQD2CYSK5Qx6amRSY2ESYPIQWpj2segjLdx3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3aLgwRMQ4g1IZ1QFDAAGMgukdxl6xH3HmE9HzMTmm4=;
 b=mtOqYje2Ys55zDhf49qZnD07QpoB+5Aemdab3KL5no0IfxHdWB8NKd/bMqBx6WxRcPIB3ojMaAyziH0XommqzTyLgixS8ATX/JRUbm6Uuzi5RtrODlcJEmV5FGsX45+udaqekzg8HB73KOravkH4U8Ax1dcwEk76DWk0pfbIL69bEatNA2zQt4a2+WG3Ccz7IpRBi5TgdwhvPluYa/r2UoM7gTWZW6OcVq6Cc/632LcLXdSQsNplap00fe4NVT7v9oKgk2jzZbPLN0gWyOdbg0G/P+0s0YgiJr1ZYk0P3f3BZFdNODRf6BQPGPji/VAAtFwVAB87IhdMUTyDRIbmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3aLgwRMQ4g1IZ1QFDAAGMgukdxl6xH3HmE9HzMTmm4=;
 b=lGqmNvLO88nLcBV88TFNN/J6kE0a8UM4RVmtJNenohqByk7rwSmvwC5xoABPhmPj3NM7LrxzTl2EW/OKmdv2brAE5H06zOREV6a5VR7DLwn8xqdkPH3uiYbFH96cBX2Ojaw2uU/TTyNxxgR9pcrvLmqqF6kKw3e7Xuoskgm8MbA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 22 Apr
 2021 15:31:54 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Thu, 22 Apr 2021
 15:31:54 +0000
Subject: Re: [PATCH] drm/amdkfd: svm ranges creation for unregistered memory
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210422144743.4805-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5ba51d1d-ae23-be35-0fe9-0d7d48e4de85@amd.com>
Date: Thu, 22 Apr 2021 11:31:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210422144743.4805-1-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::9) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Thu, 22 Apr 2021 15:31:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc9fc63c-a047-4d25-6138-08d905a3c1d7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42542081F047189ADCA01D7092469@MN2PR12MB4254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1rKuhLdJeVwIzkmN3bfubFoF7X6rh2E8vy+gQXXC/L3Dxw8JoG4OFvHcq8nkqYlSePjRT2okUczyyCWpdjr3INQQ24BWYhsgJlOoQJVmzqSWyGUk9dKcgrlDDPA/Pit9xWR2o6vT6SwfqXkhcBtF2KrQdQDMqqxYpxgBXVih95YDvOoM+jL+VYfdlpDvY6FA1lE4DluxVhlQ5l6uCXqfwNWSnuLsJ8juDKRHHW+pXgU4VolQl9bkhzTdzomMC19PKJN6AxezvUObrrbiFddRcBP5AkdWumIIfnx6KWXr9qBm9Nx3Ba9O4cLNAMte2DG/rcuYd2qzKebBQ9blVv2+V/E6vcltO546h7TKpp7UHim6mwo6iQEQZ8ZOxWERohzkKvTO+ozp0Futc1urjYmcJSor4GntF4c2GDjcp89STBKkUZATWMFKK03Urw1vo1k/nirhmG5AkD4XIGYqwmYhGCh17mj0XdFR/8fTyYkLfh4EWE+nT+FS71ejDONpCMXVAnDXXFl5XgmlZu/i2sHmHR4Xmh9yyttDZkBdtU29xZ53h6xFJAfP64yw5ywHeFxdxYZd3ZYXaAKuUWleqpLkYlsPbi2TKYe3BQU0WSMvcWZyHgqCWpkha+4TKN5eZjhvuwXJFCSED0QljERmB7V/Bg+Tp30V7nEjh6AcYmQc6S2iIq16LueejefGylV37HM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(186003)(66946007)(83380400001)(66476007)(26005)(66556008)(86362001)(6486002)(31696002)(8676002)(498600001)(31686004)(2616005)(36756003)(2906002)(16576012)(5660300002)(38100700002)(8936002)(16526019)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NUZ3VWhaQ2JyUjJjZFlPU1h0eDl4RFNDa1NKTXpRQ0VETm9HZHRweW93d01Z?=
 =?utf-8?B?SEYzSjArU0RLMnFMditzYk5CQXpVek1QbXM4V3F2N3E2bDVlMjEyRkp1Ynk5?=
 =?utf-8?B?Y0tWNktLTFJoYkNURXlFZDlmc09JTTFyY044Zy9uNWw3KzdNajU2Uis2SHYz?=
 =?utf-8?B?dVR3dS96UEppNUNibW40V0hIRzN5bk1QNDVPSnZtbXhVTjVoUi9UREo0Y2hD?=
 =?utf-8?B?UG56amJ3Z1A0TVcyWXZBTE9EWE5icUFCaStIL0ZOa3BUY3lJWlBxQkpMTlMr?=
 =?utf-8?B?UlRIUjhidk5ZNUpTV0pxS2JYOVdtbzRjQURxYzZxcXh4c2FESkExckM3TUNH?=
 =?utf-8?B?bnVrMzYvWFZZYzFTajdDdW1acXlxeEZMcXhFdmc5VHpTMU5qVnRMUTBwT2lD?=
 =?utf-8?B?NHVoSG5FbUhsdnNKM1JkOGU4bzZmVnNrYW1YM0VZVkF6NWhySlRDSUF0Nnhm?=
 =?utf-8?B?ZlNyM21nQ1hMbHNGTHo5aGx2d3hXdXVNV3p4WU83UjkxbXZRcmNWbzdqc3NL?=
 =?utf-8?B?aEExZmN1V3dnc0xtd3loMzhEMUhKQlUxeUFoa3Z1RGIxY294Umo0YU5GSG5V?=
 =?utf-8?B?bUtFckp2Yy9WaTEvYk9Dc2FEcS96THNXbm16d1I5ZEhTbHFBMlEzcHZDNnJE?=
 =?utf-8?B?OHB0OEdHVFJ0aGtsQjFndmZJQkRoNU1ld0dMUUorRnRxYjlRTmgwQ085eFJH?=
 =?utf-8?B?M2FDVlhYU1o0bGd4UW1FbTlJVHBoWGxwWHV2OVVGTGl1MG1Ld0JuYVkrMEFR?=
 =?utf-8?B?bEFYQ2VER09QNm1ncUs3UlRES09oUGpYZ0FRc3FBU1RtK3pyY1dSR3BkOUZR?=
 =?utf-8?B?SUd4c1R5dEJnVGUyS2NMa05SVk9ZK2RpcmozSk8zcitZL2JhUkt6QjNLczdR?=
 =?utf-8?B?ckgrajh0RkgwQ0pRSkFDUmZJNDFhdS9ZTVBwKzNrdlVzVGpFSU9abFErcHMz?=
 =?utf-8?B?TmVRVzRKSnJtN2V3MzFNYjNidWEvSHVNdndYVERUVEUyN0ZxVW4xRW1aM0cv?=
 =?utf-8?B?WmVCUWFCMll6S3RTeVpQNFhVV0FQUFEybmJOSW9CYkEva1ZwMS9FU3h5UzIz?=
 =?utf-8?B?UUtkMTh5ZjVldmp3cnpzR0ptdWtZUGxPaWF4V1phbkJyQ1VsOHIvOVBWNHd2?=
 =?utf-8?B?NWY5RTM4SXd5Z3BHSFpqellRZ3RySVpqVXc3SVIzQXNBVkE4eWEwNGNXaGRK?=
 =?utf-8?B?WnRES3liSXhKMjdKTXVOOGtvMlhlZDRtN0Vxb0V5ZW05QkVDV3V4Y3QveWwv?=
 =?utf-8?B?TERPbm9pWUpKczlFaW9XenhsZ1hNWEdHMmQ0NHRNelQxakxrYVJLMEdTS3VP?=
 =?utf-8?B?MFhnTDJTTVA1NWlpT2dRUk5nRzhES0pqT2M5SXRkR21MUVY3LzROTFRrQ0ts?=
 =?utf-8?B?SDJNbWRhdTJ3R3pCdi9qLzF6U1JTTjBNNmtheW4wYnlyYmtKL1RNRHlXZXhU?=
 =?utf-8?B?SU9RYmxBdTB1YnM1ZlZpWFdaYWIvNlN6OE93T0s0MWlKcnZwR0F6Wm8wSVk0?=
 =?utf-8?B?N0s0WVFNRjRKYm9PY2taU2FUanpucCtuTWFXckE0c0ZiNG0zTmNtaEthekdl?=
 =?utf-8?B?Q0d6L3JnUkxDcU40MExNL1RKcVNXUlB3NlBQMThPQWhsaHlyNDNRWnZWRGts?=
 =?utf-8?B?c1F0cnZpdkZzVkp1WS84RWJqVnN3a3ZXUlRmWW9wZm9lRnEvVVhZVHFsd1R6?=
 =?utf-8?B?RDlVaTNPbWpsaUdsL3NHa0g1VUlsSENYT0NzMFlGKzNBZ3d6d0M0R3prK1Vo?=
 =?utf-8?Q?L2yHxCk07J1apkA0Zf7ziEMdrLc8u0g0WdI+ytZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9fc63c-a047-4d25-6138-08d905a3c1d7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 15:31:54.1811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWiFkGPZViFwXmbhCoFz0kEAIamkD6zRy+RnYOVTbRJjI+ww9u6lO2S3vuwznEdCsMx5FTPDg2k68I8undiVpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2021-04-22 um 10:47 a.m. schrieb Alex Sierra:
> SVM ranges are created for unregistered memory, triggered
> by page faults. These ranges are migrated/mapped to
> GPU VRAM memory.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 107 ++++++++++++++++++++++++++-
>  1 file changed, 104 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 45dd055118eb..44ff643e3c32 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -274,7 +274,7 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>  	INIT_LIST_HEAD(&prange->deferred_list);
>  	INIT_LIST_HEAD(&prange->child_list);
>  	atomic_set(&prange->invalid, 0);
> -	prange->validate_timestamp = ktime_to_us(ktime_get());
> +	prange->validate_timestamp = 0;
>  	mutex_init(&prange->migrate_mutex);
>  	mutex_init(&prange->lock);
>  	svm_range_set_default_attributes(&prange->preferred_loc,
> @@ -2179,6 +2179,86 @@ svm_range_best_restore_location(struct svm_range *prange,
>  
>  	return -1;
>  }
> +static int
> +svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
> +				unsigned long *start, unsigned long *last)
> +{
> +	struct vm_area_struct *vma;
> +	struct interval_tree_node *node;
> +	unsigned long start_limit, end_limit;
> +
> +	vma = find_vma(p->mm, addr << PAGE_SHIFT);
> +	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
> +		pr_debug("VMA does not exist in address [0x%llx]\n", addr);
> +		return -EFAULT;
> +	}
> +	start_limit = max(vma->vm_start >> PAGE_SHIFT,
> +		      (unsigned long)ALIGN_DOWN(addr, 2UL << 8));
> +	end_limit = min(vma->vm_end >> PAGE_SHIFT,
> +		    (unsigned long)ALIGN(addr + 1, 2UL << 8));
> +	/* First range that starts after the fault address */
> +	node = interval_tree_iter_first(&p->svms.objects, addr + 1, ULONG_MAX);
> +	if (node) {
> +		end_limit = min(end_limit, node->start);
> +		/* Last range that ends before the fault address */
> +		node = container_of(rb_prev(&node->rb),
> +				    struct interval_tree_node, rb);
> +	} else {
> +		/* Last range must end before addr because
> +		 * there was no range after addr
> +		 */
> +		node = container_of(rb_last(&p->svms.objects.rb_root),
> +				    struct interval_tree_node, rb);
> +	}
> +	if (node) {
> +		if (node->last >= addr) {
> +			WARN(1, "Overlap with prev node and page fault addr\n");
> +			return -EFAULT;
> +		}
> +		start_limit = max(start_limit, node->last + 1);
> +	}
> +
> +	*start = start_limit;
> +	*last = end_limit - 1;
> +
> +	pr_debug("vma start: 0x%lx start: 0x%lx vma end: 0x%lx last: 0x%lx\n",
> +		  vma->vm_start >> PAGE_SHIFT, *start,
> +		  vma->vm_end >> PAGE_SHIFT, *last);
> +
> +	return 0;
> +
> +}
> +static struct
> +svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
> +						struct kfd_process *p,
> +						struct mm_struct *mm,
> +						int64_t addr)
> +{
> +	struct svm_range *prange = NULL;
> +	unsigned long start, last;
> +	uint32_t gpuid, gpuidx;
> +
> +	if (svm_range_get_range_boundaries(p, addr, &start, &last))
> +		return NULL;
> +
> +	prange = svm_range_new(&p->svms, start, last);
> +	if (!prange) {
> +		pr_debug("Failed to create prange in address [0x%llx]\\n", addr);
> +		return NULL;
> +	}
> +	if (kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpuidx)) {
> +		pr_debug("failed to get gpuid from kgd\n");
> +		svm_range_free(prange);
> +		return NULL;
> +	}
> +	prange->preferred_loc = gpuid;
> +	prange->actual_loc = 0;
> +	/* Gurantee prange is migrate it */
> +	svm_range_add_to_svms(prange);
> +	svm_range_add_notifier_locked(mm, prange);
> +
> +	return prange;
> +}
>  
>  /* svm_range_skip_recover - decide if prange can be recovered
>   * @prange: svm range structure
> @@ -2228,6 +2308,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  	struct kfd_process *p;
>  	uint64_t timestamp;
>  	int32_t best_loc, gpuidx;
> +	bool write_locked = false;
>  	int r = 0;
>  
>  	p = kfd_lookup_process_by_pasid(pasid);
> @@ -2251,14 +2332,34 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  	}
>  
>  	mmap_read_lock(mm);
> +retry_write_locked:
>  	mutex_lock(&svms->lock);
>  	prange = svm_range_from_addr(svms, addr, NULL);
>  	if (!prange) {
>  		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
>  			 svms, addr);
> -		r = -EFAULT;
> -		goto out_unlock_svms;
> +		if (!write_locked) {
> +			/* Need the write lock to create new range with MMU notifier.
> +			 * Also flush pending deferred work to make sure the interval
> +			 * tree is up to date before we add a new range
> +			 */
> +			mutex_unlock(&svms->lock);
> +			mmap_read_unlock(mm);
> +			svm_range_list_lock_and_flush_work(svms, mm);

Replace svm_range_list_lock_and_flush with mmap_write_lock to avoid the
deadlock we discussed. With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +			write_locked = true;
> +			goto retry_write_locked;
> +		}
> +		prange = svm_range_create_unregistered_range(adev, p, mm, addr);
> +		if (!prange) {
> +			pr_debug("failed to create unregisterd range svms 0x%p address [0x%llx]\n",
> +				 svms, addr);
> +			mmap_write_downgrade(mm);
> +			r = -EFAULT;
> +			goto out_unlock_svms;
> +		}
>  	}
> +	if (write_locked)
> +		mmap_write_downgrade(mm);
>  
>  	mutex_lock(&prange->migrate_mutex);
>  
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
