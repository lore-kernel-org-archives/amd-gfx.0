Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF29C4320A
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 17:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374C760F0F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 17:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 374C760F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E07B76E896;
	Tue,  3 Aug 2021 17:01:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B14B6E896
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 17:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fu2xty2ZpF4jSPDt7QXupPBg8K5DkBfrwoKr3JTKCVnsfuRkwVB4ME17kn7Z5o4aMk8sq6E2nztwBFznJC8FZIJxIA+KePV0NZq+93oFxL3hc1IzWeqaBwyQpAXEog708vymV9XBXTffzRuI+x3Y3yE9/8vEt4xGxxKucUkcIM3ZDtOV4t6aGJGV8FbUTVZ29rJn9aOFzL6CY1YvEgRlWLOMWTWiY/LRvr1gtbhYsGGOlyUgpZXxSFie9KZcnWNc+9B5sqD09Y+5H5BHL+Avg/VBxId+a7MzYYP82xaV4UnQO5RC9wHwbiztTdbZZ5xNEjCj7MGI5QNblnjCmkGnEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSDx1e0/2uslghuLubufaMcRIX/spt9TQm0kQV6uChI=;
 b=UPA3ItCx3GqjG7+wuHaj1vF1IJm2hCJgt7V3NBfTe5+vTVhvixMSWDG8jMcP44+QRQoICW3lZnmrG8k2orNS+jB5LkTkCaRCpYeWfYQ0xKA+eHgASWyzYbOiHPjICyzGDT3A5kN7gBCryESZaunI+g3LMaPugoJ1uImyx4er4RDv/hlQwrApsyVJyxDdmWhxQiy8rDVgealZdMBjnzocS3k4Lz2Wrt/19KKeTwVu7DHfysu3vG0RVWlqzxKe7QyAFiTCxgW/M39mKQDHMqUnPuqEpI4ZJv1KcCQstRPa/yGvzBqAKkNJgy4Yw7F7FP6UmGKRAmUiGlC/kRIg/vJ6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSDx1e0/2uslghuLubufaMcRIX/spt9TQm0kQV6uChI=;
 b=iNPdUqEA2uLdPbjMJGF04cUfPPqvu79u/lxanyWKSq+Q47XlkllLnmRS7D2XdZ1YngxhnW8/37MIFmW83t/cW7Vqmpia4ADyS4Au6TtZb8VElBushKtCTDTsHjgqSWQ6OlAHqvYG5ge9/V9sen9bfIA8deFHODt/e42aykjKd7w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 3 Aug
 2021 17:01:53 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4352.033; Tue, 3 Aug 2021
 17:01:53 +0000
Subject: Re: [PATCH] drm/amdkfd: support file backed SVM range
To: amd-gfx@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210802145606.11888-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <9200e997-50c3-bae3-45d6-902e3d47dd4a@amd.com>
Date: Tue, 3 Aug 2021 13:01:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210802145606.11888-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.19 via Frontend Transport; Tue, 3 Aug 2021 17:01:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff2138c2-6f2e-47db-cab6-08d956a064cc
X-MS-TrafficTypeDiagnostic: BN9PR12MB5049:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB504943628600D76C8D3FA7E992F09@BN9PR12MB5049.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jCdl2ztKZFtf2muRSX8ceydvHAtyK5pt0HdGVNgl/nImzsJJB7tP4Qkqk2D46aL3BoOCURcW1MpfOeKZGO6V61Zgd42JQU4DrQjjdXdrfa6Vl4OXoMCW3O7TuTsEWkcPQU93q+KO8is04V6t9EVA2sf4jlD25yLpiiw0FAmp51siwuPd0gNIX0oUr4Zx+A0eRzCEcKMuhTs9u7XKCynyNzQ2FyLu81s8lKh+P7xI7qMRSBzGCyee0EUeS6kwr2bvthDsWnGQ66MsQCZ/qmiCn2GqY+Yj6ulqRqsTQtIIs8yT57VEnRlR0rDgae1zMgEMMhTrJ1V02PtWH5mcvarY+3je8iJBa3V4z5WWH/2WotqKPM0yJuiHAzpPV+HO5Cc7kZGiUnMmWQejJX5HcnkW0SgMnQpBPBJHUyAtgkpRW7n8o46SxK5pwXw5g5gJBJ/yYvqtQOh1xlRp5D+QBIiYwEY1JUuiPKXjBJzqvjwA8C/3uHTt0ZozeAQRB+FnXwG30c9/P6VnwIxWu9/d2fUom6oP1glz61JKrQ2A7DxbWIFKYP5pvbB1dvEby9NIML+PYqO4FFu0kTnOtg7Qm4QVAaASe5wwv6y2P9PsPKoC0/YMYi+9hGHQNme8Sxc4wsK47taBkTGKxxHKWz+oTkl4DycmSbNR1dudNRQT4anXIS0HsxcsQqYn9pYlG/N6sbqEI5KPJuZ3sga7kBj3iYSVNCPbx6QDRGKY52c/2zHZTLr0POJMG5jGKS7VPFX2YOH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(478600001)(66476007)(6636002)(66556008)(66946007)(8676002)(26005)(5660300002)(956004)(2616005)(44832011)(31686004)(6486002)(186003)(86362001)(6862004)(83380400001)(36756003)(316002)(8936002)(2906002)(16576012)(37006003)(31696002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWdxdE5ocURpME5IRVRZR3lNT0FCWklOZ0JDWWE4ZU5FVDR4WCtrVVArZ1VR?=
 =?utf-8?B?V0JSb0llR0ZjZjVTUEFFNnl2ZlJZZ1IzR1o0elI4Nyt3b3BEbktZVU5BN0lv?=
 =?utf-8?B?VXpkcExvdWYvN2ozOHJLb29ycjIrb0UrcVBoTExTTGNNaTRDRWMwM1FXWmZT?=
 =?utf-8?B?T3hEL2hxSnUxNGFXNU1ZQ1F5T2pFMkc5OWMvQS9Xc25ETE4vYTBwMmFCK0tI?=
 =?utf-8?B?bW5wYUVSalpEWUJTRDlVZVAxNGdhcHdmRTc5WlNaZ2svbm9PVHJ6U3BEOEMv?=
 =?utf-8?B?VXd4eSt6bGw3Y3N2cVBHbTMzbXo0NnBJckdDMHRqSWFPRnlZQmNIUDkvd1FH?=
 =?utf-8?B?alIxNnllMTJrbE1kYzNENDN1a2ZGcWpiZno1N1ZFcmEyemtwWGhkZFJKNlRn?=
 =?utf-8?B?dk1mQ1M1SmZTaHNvMnA2bkx2d3gyWDI3SDJNc1pXSmQza2pjT3A4czRwQTJG?=
 =?utf-8?B?aE9HZVR0am5KT1lGYmFsNVI4ZncyZWRPQlN3Z3FBeUVKbmRZTlUxZW4ycjZT?=
 =?utf-8?B?b0tvek0zM1lNWXAxYUZGaHpFQ0x0bXFaTUg2TDEvRUE3WnlQZlIrM1M1T0ZV?=
 =?utf-8?B?eUs0T0plZ1Z1ejVxN0hnUDNtYVVEaHB0NmlRTEFuWUQwdDhqNzFBVzRIem9E?=
 =?utf-8?B?eFZkNC81ZUYrcE9WRmVSOEsyWjBVQ3VQSzJMRXNETmtjOXJIbHQrUjRqUUt2?=
 =?utf-8?B?SjRQUWIxenA1TlAvMEdkK2g2WWtXYzV2QVk4TnlCZDdWbHJteXUrWFRabW1h?=
 =?utf-8?B?SUkvdkNXM2dWOWR6SWJqNkRYNnZPRG83eFpqU0N4RnRMU2htcFRqMXVRTlVW?=
 =?utf-8?B?dHRNTEZOcXdaMjJXNHhuV1lDbUwzVHNldVEwcFFicDZDZmhwQVUzTnEwSitX?=
 =?utf-8?B?WW5vUUZmNkhLTVlNUlVPeEtjUDZkcUYrb3F1VnBOYUoxM05FRk1CcTdsV1NC?=
 =?utf-8?B?NmVqQWFlbkZZdG5iby96Z1NiYlI0QlZNTVRFNnR0bmFHMXRPS01yYU5SNHlv?=
 =?utf-8?B?UDJ6bEExSm9XWmdmR1pmQjJGczNDbDhWNzBYQkRtRkltYTFSTEk4UllrOWNn?=
 =?utf-8?B?eGczSWxFdjROdk1ZQS9oYUo0aktjL2FSYVJEWFBta2ErL3FkZndDM2JDNTFJ?=
 =?utf-8?B?b1NneHJFNk56V3hvT3BqVUQzR0FkVkdneGg3Ymd5WTJaT2V2VEREV1pZNmJU?=
 =?utf-8?B?SlhPTVdLalBIb3h2Sno3MkFPNXlyaTlXYzFkVlBEZ1NocG56MmxnRGg5TEFm?=
 =?utf-8?B?b1VrWmxvSVNoS2R3TEVjSjVicXU1TElZTHlCV01tbVYrRE8rV05hVkhqYi96?=
 =?utf-8?B?MUI5SnJiSkxlOW9uamZRSXI3bUZDMVppcE9Mc0RQSkkrV2hoQ0U4NzVLMmdI?=
 =?utf-8?B?bWxJRGhjS08yNlFSK3dXMHRYWFZXM09KYUFhTVY2dGZwS01DNDloS01KQnlu?=
 =?utf-8?B?bEhHTitrc2V6T1hmeWo5dHpvejlVQ2NpWFBOS3FsVVlSTnBrc2xDKzdKY1ZI?=
 =?utf-8?B?QkRiSEZwUkJzOW5odGVKeW9RU0R5aDVHMjVmcE5rL2ppaG1HVC9uV1ZhU0x2?=
 =?utf-8?B?a1Z5Rm90T2IzWFh2N2RNUUlXRHU3d2dxb0NSMnRKQkt6WGRhNytLSnJJOEt2?=
 =?utf-8?B?Q0VpTURUUFprUVZmTXN4b0tPRXM1TktiWFpCNUx3aXltZWFNQWNxaDlkMXFS?=
 =?utf-8?B?SlN4bDhnMjZ5UkxNNlpKbEd3VmVSU1dhZC9DVFRvVDlvT3QzSTREdjU3SlZw?=
 =?utf-8?Q?TnnU4clu4qt4pNIC88RAHoX5etVxvWtQJSVDijA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2138c2-6f2e-47db-cab6-08d956a064cc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 17:01:53.6719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNsG7q0F5EdPIwGsTAEJpCBXLeZzNwGpbDpITi7xJdvVxsfPwHj5nDbDIhO4Gqtzp89sD/8lyv0Mr5qSYiyR1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
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

Am 2021-08-02 um 10:56 a.m. schrieb Philip Yang:
> HMM migrate helper migrate_vma_pages do not migrate file backed pages to
> replace it with device pages because the pages are used by file cache.
> We can not migrate the file backed range to VRAM, otherwise CPU access
> range will not trigger page fault to migrate updated data from VRAM back
> to system memory.
>
> For file backed range, don't prefetch migrate range to VRAM, always map
> system pages to GPU and also use system pages to recover GPU retry
> fault.
>
> Add helper to check if range is file backed or anonymous mapping.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

This patch should not be submitted to amd-staging-drm-next. As I
understand it, the real fix is in Alex's partial-migration patch series.
This patch is a hack that could be useful for older release branches
that won't get Alex's patch series because it's too invasive. So let's
review this on the internal mailing list.

Thanks,
  Felix


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 40 ++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f811a3a24cd2..69237d2ab2ad 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2400,6 +2400,36 @@ svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
>  		WRITE_ONCE(pdd->faults, pdd->faults + 1);
>  }
>  
> +/**
> + * svm_range_is_file_backed - decide if prange is file backed mmap
> + * @mm: the mm structure
> + * @prange: svm range structure
> + *
> + * Context: caller must hold mmap_read_lock
> + *
> + * Return:
> + * false if entire range is anonymous mapping
> + * true if entire or partial range is file backed, or invalid mapping address
> + */
> +static bool
> +svm_range_is_file_backed(struct mm_struct *mm, struct svm_range *prange)
> +{
> +	struct vm_area_struct *vma;
> +	unsigned long start, end;
> +
> +	start = prange->start << PAGE_SHIFT;
> +	end = (prange->last + 1) << PAGE_SHIFT;
> +
> +	do {
> +		vma = find_vma(mm, start);
> +		if (!vma || !vma_is_anonymous(vma))
> +			return true;
> +		start = min(end, vma->vm_end);
> +	} while (start < end);
> +
> +	return false;
> +}
> +
>  int
>  svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  			uint64_t addr)
> @@ -2496,6 +2526,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  		 svms, prange->start, prange->last, best_loc,
>  		 prange->actual_loc);
>  
> +	/* for file backed range, use system memory pages for GPU mapping */
> +	if (svm_range_is_file_backed(mm, prange))
> +		goto out_validate_and_map;
> +
>  	if (prange->actual_loc != best_loc) {
>  		if (best_loc) {
>  			r = svm_migrate_to_vram(prange, best_loc, mm);
> @@ -2520,6 +2554,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  		}
>  	}
>  
> +out_validate_and_map:
>  	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false);
>  	if (r)
>  		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
> @@ -2850,6 +2885,11 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
>  	int r = 0;
>  
>  	*migrated = false;
> +
> +	/* Don't migrate file backed range to VRAM */
> +	if (svm_range_is_file_backed(mm, prange))
> +		return 0;
> +
>  	best_loc = svm_range_best_prefetch_location(prange);
>  
>  	if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
