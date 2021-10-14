Return-Path: <SRS0=AM0C=PC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE02C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 00:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9776760BD3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 00:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9776760BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E416EC04;
	Thu, 14 Oct 2021 00:13:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BA216EC04
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Oct 2021 00:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKjN3mV5hCoHmGZfPc721ZJ+dSlzTdPMNHoR6crycJAZki0knHatWtLiLDZE6AYufw+IKctS9Qc3xeGOUzBKGoHZLvfHuoOe2sffixPwnRrGwMRghyjolTdm4/uuoiHey+EMxkSlyLUpR9WdFnt8zn/51orB3FqlwLB8PoRZW0g4SobHpx60MFToEkLU7mVoTDIZ7XHrqWb+Y6SrD1Q8kZdGSs+1Qr0YK7Gr9ONbmSkBCo89iJI86L7Hn9y1eERquwCIPhx3BAdFAYASp65+aKF6CjEWrcsoiSTnYN4RAsTsyOUU3eJzNeBWHIFgDUtdN3dAVOKRnSWFYBkZVm9Dcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Q/Cp2RvABzsaO+mXUu7uwSVvwt8BBwYn05RSnIHWSE=;
 b=fT5JvjDR+Eb6LoyATHslHEP5cDC3ksomt4UdEkIKAgP9k33dOkV5eZ62xgQLOrZurEsutIrUZdL9SwwRBUDnjv2rV4OdBf3g1+GWvyBiRtq0SomK2FJrQiHhrIaEmaKTfQM7YIuDA6CaBOgmqBF8fa8G4Pss5XhM0vA3SvHRdcboIzrHdRzeHWay8sNWrSOa1EIY2i9hdVdnO043wk9L2R7yfx5l2hT3OqPQuFcYeQ7b2ZLU8IIlYdEiRro6I8etbEG/enJD9fWqA0V1bfa64IN8OojCuWvnm4Udg90r522joDshaf10Ug71ysXvLeAMy6pQpIY9irlz30bDs7P6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Q/Cp2RvABzsaO+mXUu7uwSVvwt8BBwYn05RSnIHWSE=;
 b=UyRLCXqUP5oS3dGysPzut8OTdVQfqBCPby9yae/tH/tqOVMunRAR/9kbWvD7Pe8tZ9BoN+mCXU+VOxZN8nIbY3gg8IPuL/5/Y7xFjCd4ObvSrZKiju+gpDToQcaYRclRB/iqahqlx0Km5W60eqsYMFspeVTDjmR0Hr0SZGU9EyE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM5PR12MB1833.namprd12.prod.outlook.com (2603:10b6:3:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Thu, 14 Oct
 2021 00:13:51 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 00:13:51 +0000
Subject: Re: [PATCH v4] drm/amdkfd: unregistered svm range not overlap with
 TTM range
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211013231841.4419-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <12f18a11-2c15-e92b-3416-b44297592277@amd.com>
Date: Wed, 13 Oct 2021 20:13:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211013231841.4419-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::15) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT3PR01CA0075.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 00:13:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13f6e111-3bae-44c4-a2da-08d98ea78006
X-MS-TrafficTypeDiagnostic: DM5PR12MB1833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18335124191018AE23B156B492B89@DM5PR12MB1833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbHpu+vcGaTl0qOAHK68u6OdXKc5gFs7Xr839Tj5ZsC9lKyfHDmakw8SIz6YrJrCXJKR0oUg0c08JPz2ftoOcx/s1vIyKj1o9Wbp9y8W/hJfxyPvLI3NpOeLVQdx55Lj6juNLWDpQSKH/OSikuMPGVsELs1MqKHGHz+gdV+aS3NHFAeD4HbFNSSoVZrM87iH5I1r43+AfLR/y1zOtWfJ387meyFtCCBrfb52T4C5mGGBZqkDvFNr04ed7Uq+cBsDx3fB75L+/LKg4QSe3oAIw3loVpOXFiFE5k168Dvs+/aycgb3p12dS0TpjWwQxq88D6C0rSnvCDjALBnDvuSuDreshdOlgoyTftfhzZs5IpxdpGYLmqdsdvJ2kjmjIABbIx4/6aaMTseSDfJb2dF1LofeAk8JpvKjrCTam6VCTCKYgli2ojcuqkK5nf9s5+IJaxk5EKZa0uwE8U5DnhUYD+dz4KJgs0w+VonBUpgEG7wl8XCkeRt+Eol3yR6046GeHsyvao4EWF2sFApBP9qX7IZdjW+N904SxTAJnoYI0lPBXcMM6WPH+Z++UV7tgmmXfnBrvTYoMhxYJraYHnz3Q5149wItVPGqy6Up9B5cNckMBh56yFm1TZBU/Gc7jU5nygsvfBOu/H+5hezZmi+DccMvdtMP36gC6xFryi48M+EcGoh8Ga8MvB3ISNHYvxbOmWepP1higWccARZzkVqpUag4Zwz6mgCaHo9HyWj2iztQZejldXEnK0KWY9pZV9u1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4001150100001)(66946007)(66476007)(26005)(83380400001)(6486002)(5660300002)(508600001)(66556008)(8676002)(186003)(8936002)(31686004)(2906002)(36756003)(44832011)(38100700002)(2616005)(956004)(86362001)(31696002)(316002)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmhaMFBTWGlqeW92WEpOZ3BNOHpjcDZHcHBNUzdMaHhNWnhzTDQybGl0QWNR?=
 =?utf-8?B?RVhTck5xUFRHWEJoUVhMS1ZCSzdvbmNNL3paRzN1cE9vNmJuQkYxRFgzS1hR?=
 =?utf-8?B?L3R6WnhWZWV5cUN5V045K2svbmVmaW1CZU9DbmI4T2UwVExJNitIby92VHZs?=
 =?utf-8?B?Mnhkb0FLQis4WVY4TDl2Ui95SVpISTVSNGJxOEpxVTl0d2ltaCtKbVlJbWp2?=
 =?utf-8?B?MVV1dWxZV1RaYTVPZ0Y2aDloKzJjMUt6b005emFFMnAwZy8veWoycTFlemVH?=
 =?utf-8?B?UlVhTFRsYXBSUEtpSFVDYjlRUW1UbE5qa0xlMThxTUVtT0dJblI0Ly9vVlFJ?=
 =?utf-8?B?NVQra3NqdnMrbzNudlVYWWtFaFAvVUkvZ1dlQWxWTlREZGc1TlovK01VN3VP?=
 =?utf-8?B?elVDeStRQWJNTEFCWjRWUXZtTWFrdmdVK3AyRU5NM21aMXhkdWhNU3ZlNWI3?=
 =?utf-8?B?d2hoUHNLVytqVk5QbHAvU1VYUFhla1VEOUE2c2pMUkdNdUhnSFFwODJyYVU5?=
 =?utf-8?B?WTN0K3laY1NaZjhYa1ZJQXhTajhOdVlPYm0vWHh3WFBSSzB0dkE2V29lNjE3?=
 =?utf-8?B?QmhzbFZnM0FuODJRWDVyb1pmVUVxNWRkRTI0SVNxYUJleGpONXZTaDNvUjZy?=
 =?utf-8?B?akJrZ3N6T08wcnVoWisvZlplcnZ1RnZwdHM1K2I1S3JadmFmL2xLR2YzbUxl?=
 =?utf-8?B?cisyZnRGa21xT2NRb0QxSVpSYmF1N2tSRFhaTmRQOEpvTGI0eEFVS3lhZ21M?=
 =?utf-8?B?dUxHSXNvK0lPaCs0bk45STlEUkluTlllTXFQQm1wNFFBWHRXekNqL0VoZGx0?=
 =?utf-8?B?bTF6R1liRmxZR3pRUGN1VDBvdmE1UWM5dWMwaEJ1WFhuMzE5RmpMNjFXN3Fj?=
 =?utf-8?B?eTQ3L3I4dTJqb3Y1QzF3ZVhqVUJNbk5SUzFUei9rQU1YUlJJb3U3SHhMT2Vz?=
 =?utf-8?B?UkZIQ1pQdlNxZmYwNFp2d1B2TlU4MTNGdkJOVEgxQ1NtZGFBY0FvT0U3STJO?=
 =?utf-8?B?L2grdjhzYThaUGxFbUt2TWdSZDMyMlY5QlpvZ0lYQ3htSnl1bzl4RC9CenUw?=
 =?utf-8?B?MFR2dnFCVHpta2lvcHcvVURBdHc1ZklBb2RySFEyQ0I0S0ZSV1hSSFp2MTVS?=
 =?utf-8?B?VWJ1VHlTTmlRY0dQdkpQQlNnRkpRSGhUL2F4Qm16dEZwdmpKUHJNREhna2Zl?=
 =?utf-8?B?MEM2cU5RLzk4a3pLRXhpMHlFT242L1oxMjBEZkUyVlBaYzA2VVVWY1VRdyt4?=
 =?utf-8?B?STU4aUpiR0JEeTN5M2JMbUJVMkxVSmJ2aWd3SVRzSWVhR0NuNENuNkg5OGQ2?=
 =?utf-8?B?ZWgzSmV5bld0ZUVtUlErZTViRm81dEdwaVFJSlE5SGoxd3d3YURUbkhQYlpx?=
 =?utf-8?B?VzFsQnRyTDJmZ2FvMlZZQ244K3hKNFdnWHRaVDUxeVpDV2NhRFprWHp3T1NZ?=
 =?utf-8?B?VGtDMDhYYjYzZnN5QmlWazUrY1hWK3FrcnFMQkVHeldOVkRyOVVKa1kzQ1VM?=
 =?utf-8?B?Z1phNVQ4azhURXo1WU9pTFhHU0JTdDZPT2tTb3B2bGFTdUZJL0FGU3BiUjBE?=
 =?utf-8?B?TmZkUmpsemVSWkFCRE1Mc2kvVUliMmdsdytveWsyc3JUV1hvWFlBZmFKZTla?=
 =?utf-8?B?by9COFl2SkZlZVloZEpaREQ2WmJzenp6ZWlsVzlkUUx1MTBKU0RmbGhoY3dm?=
 =?utf-8?B?YzA2RVVubm40a2dGQVVNN1A5ZHQ3VE5uc090eGVLRlZvWVZhMmF3ZHhmMWIr?=
 =?utf-8?B?Z1hwTmkveXFLNjc2Q3VxZzJRQU16UFdqcWxFN01xck9CNW9zTUZERmR2aUo0?=
 =?utf-8?B?TWQ1QUdCc21uNHU0Mm9IZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f6e111-3bae-44c4-a2da-08d98ea78006
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 00:13:51.1685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuGstUV+dwoVJnrq0VPKTessmmubKWvUd90Q0PxUuDsJrZwp+C4iy013XTHVw/LecIVRkHy4BusgVS67vS0bsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1833
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

Am 2021-10-13 um 7:18 p.m. schrieb Philip Yang:
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
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 95 +++++++++++++++++++++++--
>  3 files changed, 94 insertions(+), 7 deletions(-)
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
> index 49c92713c2ad..b691c8495d66 100644
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
> @@ -2366,10 +2420,26 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
>  	struct svm_range *prange = NULL;
>  	unsigned long start, last;
>  	uint32_t gpuid, gpuidx;
> +	uint64_t bo_s = 0;
> +	uint64_t bo_l = 0;
> +	int r;
>  
>  	if (svm_range_get_range_boundaries(p, addr, &start, &last))
>  		return NULL;
>  
> +	r = svm_range_check_vm(p, start, last, &bo_s, &bo_l);
> +	if (r != -EADDRINUSE)
> +		r = svm_range_check_vm_userptr(p, start, last, &bo_s, &bo_l);
> +
> +	if (r == -EADDRINUSE) {
> +		if (addr >= bo_s && addr <= bo_l)
> +			return NULL;
> +
> +		/* Create one page svm range if 2MB range overlapping */
> +		start = addr;
> +		last = addr;
> +	}
> +
>  	prange = svm_range_new(&p->svms, start, last);
>  	if (!prange) {
>  		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
> @@ -2672,6 +2742,8 @@ int svm_range_list_init(struct kfd_process *p)
>   * @p: current kfd_process
>   * @start: range start address, in pages
>   * @last: range last address, in pages
> + * @bo_s: mapping start address in pages if address range already mapped
> + * @bo_l: mapping last address in pages if address range already mapped
>   *
>   * The purpose is to avoid virtual address ranges already allocated by
>   * kfd_ioctl_alloc_memory_of_gpu ioctl.
> @@ -2686,8 +2758,11 @@ int svm_range_list_init(struct kfd_process *p)
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
> @@ -2701,8 +2776,17 @@ svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
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
> @@ -2743,7 +2827,8 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
>  		start = min(end, vma->vm_end);
>  	} while (start < end);
>  
> -	return svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT);
> +	return svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT, NULL,
> +				  NULL);
>  }
>  
>  /**
