Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E724C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 22:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C05810E115;
	Thu, 10 Nov 2022 22:00:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 988CC10E115
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 22:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uf0NGJ3UtXvGYQ7tAGjsCclDkyuuI7y6ihF3FsRH9l7b5P9KNWIIi5sYbDp5Fg9DptBq30bBlZZWvmMroBQXnlbrSil5pw+yRt5xXsv1gleqbrZZFdR6MpDx7F/DQndfmFW7k1+A0frSKbhuig8iohpqLIAmk8nCYxrfXRDWfKsKx6sAb/E0wuCrntLo2EvO/mlfY77XX6yIRyUhaU4voIiGSvx1D9AqjLV8tc8uvDM3pXVpVI5nuxH8ftljE81g7aAH74DZb45rS03KpA2o47blV17n3ATKpPR+R3UW8lnO0K0PXMjfLl8y/89Sg68gwXKUAm+VAHkVd6E68ptNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMhmcsKCN526faUT0ghNZEWHrLaGdsDsNcRoXNEuaFg=;
 b=S2sDPyIQYzDsTKLFr42CfrpifJXbPcd2vIRpNq/cKbwWoXHowko3M36OvmNZ3GiiaJ0T+pbQnQ9T/SghDQB7Npj8Dhq9BfWeplxhrw1AVMzrldRGmkR5cDYJDy3Qsgrvnbo+rNzhEn8r6OWBX6JELl+oEavL8vgj6ySdtHs/lYPrNgtEHXkhHO63NQfrj0QBCnW9k3hTN84vPBrECpbadbc3AjI2XtyA5U2dIv9F2WkW6Rc8cF9oMPEmjOWvFpOjR4IL80XIAvNHtoIUGLl9rkBcoiphQoY3JT6WB300maIOT02W96KTLaGIxuGXsL1KKsW4YkDvfiDZb1YlZHan7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMhmcsKCN526faUT0ghNZEWHrLaGdsDsNcRoXNEuaFg=;
 b=aeKWm5bRuxmIZwHFDkfLsHC/Fx39eEq9rXxwO2QE4H53bENdZ3dPXb5llS+rsU+AIRyfbNlsiAa+i5tciOQU4qakOnYeUIQEDFOoe+Yx9aocz8e1YaELctGB5GLx5Y44SjTHoogXjvI6ucu+J1eb+J/gE9NAjDSc92LhxBzjw14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB5013.namprd12.prod.outlook.com (2603:10b6:a03:1dc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 22:00:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 22:00:38 +0000
Message-ID: <7894e819-7341-4c9e-2c4f-ed006c314499@amd.com>
Date: Thu, 10 Nov 2022 17:00:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/4] drm/amdgpu: cleanup amdgpu_hmm_range_get_pages
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip.Yang@amd.com, amd-gfx@lists.freedesktop.org
References: <20221110130009.1835-1-christian.koenig@amd.com>
 <20221110130009.1835-4-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221110130009.1835-4-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTBP288CA0031.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::44) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: 64931153-a8cd-44d4-e463-08dac3670092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIEhZktpDjD9zc//0nTpdZ5U/0KA163tPNev5M4tIcR6sM7WdKURnpgDRNkOVaBznyN7akA8GcBbad/IpczMU3Ygot+yEvvs+kMq7ivuBME3Pw+tEbM9y/tq3GKZDsWykDJrknSGFKrTcm98+v+CDhxoH/mZ0lzRhzzcBVi/AC6fwzsK4BTclqSFfjDHybq748H025BUYjeh4ipcWxAYuqWGpLRZ21YwHDtmtMxQh3fk5qLwXfpSDlAsdNh8kkhSnEF7mPw43v4V+cwg5aJFe1OU1VkWclKo2iWQF2O8mfNjL22H7tappDvwwcA72ndJsNsJVx0v8WqFefH1gdEVARJMDJV8fmWWy3HAXvp8UKHAl0ilHpOyQLyPEhzG+j1JWFARd38h24+1arj4otBPd/GzCHKQ83EvzAuzdobCRUZ5QpxySogWcFIL+Hx0E6VXwpLBae1tfXPwCuOOLDYRFXdFUTHIzulmBODls/22Tg0k2MBvM1WZj7oJas4FHO4heWzHc2UtEdVBKmEWA6Dd2D3ndNqPGUIL/HrOOzinVntelhVQGVVAki4AyHfx20zGb9zgwPZF8wQMxDzt1+D/c6YGpTFU8CxqsVfLG6/Px40BPAs7xdtoN+Q6ym0hx716JDB8ZyEbvEcWLV32R9FMM03MrnYGom2S5F24ZdRuLXf+DN3VcyO3K3PwbvT6BiV6trGjTmBY3v0jNiluevmQwWtkHUXcuOpaaBb5n6cxxSRxZzm6y+d/uklvYBW2rhDGzySrtdpaczwtxWqldf4DgME+NVGYQC3g+QEIKlQsb34=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(36756003)(38100700002)(31696002)(4326008)(86362001)(8676002)(5660300002)(41300700001)(8936002)(316002)(66946007)(66476007)(66556008)(66574015)(2616005)(186003)(2906002)(4001150100001)(6486002)(44832011)(6512007)(6506007)(26005)(83380400001)(31686004)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkt4cXpyK0lpSERNb2tWOHNZd2d1MWxHM2VUOWYrdTN3QmQvOU9NalRjTG9I?=
 =?utf-8?B?OE9MTmNnWEF3M09mVy9zY3lPTlVvZ2h6dEYvZ0o2QVlmaWZWN0luS3g0TU8w?=
 =?utf-8?B?dXRJbVdSMHJCdDR4Mmt0eHZZMVMxc1AwYVkxd1ZHcXhnWFU2d0JZNlphZXEw?=
 =?utf-8?B?bXpqdDg0azdHbTdoNWZGRlZkUlBjUlBPeFRiREE4K1A3dXpwaEI2WTJCRG5K?=
 =?utf-8?B?c0tpLytWaGxiZnJ5dVpURlA3dWF5djFpdGFUM3ZHYndiWDM0SDBaWGd3WXdJ?=
 =?utf-8?B?dFdleFA2Sm9teEp0c29sMURDM093SGFCVlJNdFdVbmtVTTFEdFFZT1ZWUWti?=
 =?utf-8?B?aUR2Yk1SNGMzVVNOejVqT1dFQjNBa1hYZWYzMUlUdlF5Qnd3UTF6bkw2K3NU?=
 =?utf-8?B?dHpnbnZrZU92NE8wVm5MN2Nkb2dTS2VxeUN2NzgxOHpkMWFnS2M4ajNNZFpu?=
 =?utf-8?B?SHdUS0IxL1haWmNwc09ZWDlFekVseGgrRmQ3d08yN0pwRE1UT3V0bVdaYmg1?=
 =?utf-8?B?K0Z0ZlBDRVR6SW5jc2N6M3JPZ2VKMGJwaE9RZ1NHTnoyZlFvZ3VoTXg2c0sy?=
 =?utf-8?B?RHJLZVRsYzRyOEVHc2lpNnd1bWFsbFpzdmZPclJ5Q0dqVEY2Z2ppRHZpOFFF?=
 =?utf-8?B?NXNNTE5CcVJNbjB1Ym1uU3A4bkRmOURuZkIrV2xzUC82VmRxQU51WWtPY1Iw?=
 =?utf-8?B?TE9OWS9zdU9RZUxBQk9jL1lMR1pDMkxsdXBCUlRoUTQ5d3NtUzJ5ZlZXQmpT?=
 =?utf-8?B?THY3THNOVzNSRlZ6Y1pKZjZBR2IzOEUyRmhsUnlXTkRKUXNCcFhPV0FmYnNE?=
 =?utf-8?B?Nk8xSW1tWE1rOHM2Y29yUTZFUXU3eTR0OHMrMjdWbnNlWFZwQ2JvRnBIemVu?=
 =?utf-8?B?TVdwM2RncnhNMUpDY3VOQ0cxUWhoMUllKzVGaGV3ODRvbkxhK2hhczBsK01E?=
 =?utf-8?B?VkRjZFJodURWV2M1V0ptRFRrVjJhd0lWdmpoVlU4d0pib1h1Zlo3RnhVV2pt?=
 =?utf-8?B?aGl5Q2QxTzdhUTQzQjBmN29YaDZnQW5hRDV3ekxWL2RIYkg5clhpbmtRYVVp?=
 =?utf-8?B?WFZtZnFJdWM5ajB0emtVK2tSV1BPWXhqbnhNOTdaa0tGQXpsRkZiaEg5aHJD?=
 =?utf-8?B?SEFzRlVrNC8zREJnZlVRTStjaVl5Tlp3dWVHQlZuTFY4WGRLVmFWOGZRYURM?=
 =?utf-8?B?T3RKZnlJeFRuUE52YVpwWVQ3T0hJNU91MXhJdWdtWXA3ZVpuN3laaTBpTnNw?=
 =?utf-8?B?ZWJZaHFlVE9tKzdSRU5DODRKVkkzaFA0YnVBSUxWVVhNTERhL2YwUE5FTjFp?=
 =?utf-8?B?MGxoYlVJYURxUzdRd3EvYnJlZ2pFQ1RGZndJZzByVnZ4SUFGYUFDT2s5ZHpD?=
 =?utf-8?B?UDdsNnVGcVpjMzRMUnRCODEzQVl1dHRBcDlzR2tJTUVCbnpOcTY0QlBSOTVF?=
 =?utf-8?B?bS9Rd09vTkdoUkdRdTBjWEdQVmhWdytjbWFUQmVJTG9WVjBjanhFRnM4bm56?=
 =?utf-8?B?RXBsaTFYM1d4VjZyR2JsZXlUTk5ocW9GTnphOVBlN3l1OC94REVsaXlyMGpU?=
 =?utf-8?B?Umlnbkd2REVSK1VxUmRQSXhQVlhwUUJHaEtLdm5sZ1h4T2xCNHBlbDJDS21a?=
 =?utf-8?B?N1JzQytxWUVrNEF5TFAySytzWDRsS1htb0QxQlh6YjFSbE4xeG1YNTZlL2dr?=
 =?utf-8?B?dXAxTStZQStneG9Jd3NtV1Z4MFdwWElJdjBvQlg4YXBXcmMwZGJmeHAwUXlz?=
 =?utf-8?B?bEsrOGQvTnlqelBETXAwQ2xXWFdYZVArUHBHSXRXcnRxaVQxcVVzNnBmMjBV?=
 =?utf-8?B?MEQrdDFLdFhHTytjcTVKMWNUYXA1V2JwWEFSL052Q2hVMU9ZQ2FSZTBzREJD?=
 =?utf-8?B?Y1FJeTJSTzQ2amg3VEdqUlI5RE5FTU1hcUExTHBMWEpuUHhJZGk2RzA1a25y?=
 =?utf-8?B?enF1by85TFU2MmtUUTAvRUNXaU9HeFQ3MG01YjEyRzNVSUgzaktRb3RkTXFV?=
 =?utf-8?B?ZzBvWDc0Mzg2QUdOTG5FSys1emNDMml1UXNJK2FQWk1KeWllamtoYnNGeFFZ?=
 =?utf-8?B?am0vclJwTE11M1FBaGFZdlJjOFZpanBaUHdDWU1YQWJ5amZlTTdMZ1hMS0lE?=
 =?utf-8?Q?Eljn5XzpRDhclCik5HufINW71?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64931153-a8cd-44d4-e463-08dac3670092
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 22:00:38.7208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWiNG7QB1P7CkH14Bfmz6ch9U8uND1Ms62l+7jQWTtmWpoqt5DlUkHUD9UnxzftO44nIAnXWZLeCWgH5ePno6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5013
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-11-10 um 08:00 schrieb Christian König:
> Remove unused parameters and cleanup dead code.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 14 +++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h |  7 +++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  5 ++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  6 +++---
>   4 files changed, 11 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index a68072f766c7..a48ea62b12b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -158,10 +158,9 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>   }
>   
>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
> -			       struct mm_struct *mm, struct page **pages,
> -			       uint64_t start, uint64_t npages,
> -			       struct hmm_range **phmm_range, bool readonly,
> -			       bool mmap_locked, void *owner)
> +			       uint64_t start, uint64_t npages, bool readonly,
> +			       void *owner, struct page **pages,
> +			       struct hmm_range **phmm_range)
>   {
>   	struct hmm_range *hmm_range;
>   	unsigned long timeout;
> @@ -194,14 +193,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   
>   retry:
>   	hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
> -
> -	if (likely(!mmap_locked))
> -		mmap_read_lock(mm);
> -
>   	r = hmm_range_fault(hmm_range);
> -
> -	if (likely(!mmap_locked))
> -		mmap_read_unlock(mm);
>   	if (unlikely(r)) {
>   		/*
>   		 * FIXME: This timeout should encompass the retry from
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> index 4e596a16d288..13ed94d3b01b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> @@ -31,10 +31,9 @@
>   #include <linux/interval_tree.h>
>   
>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
> -			       struct mm_struct *mm, struct page **pages,
> -			       uint64_t start, uint64_t npages,
> -			       struct hmm_range **phmm_range, bool readonly,
> -			       bool mmap_locked, void *owner);
> +			       uint64_t start, uint64_t npages, bool readonly,
> +			       void *owner, struct page **pages,
> +			       struct hmm_range **phmm_range);
>   int amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
>   
>   #if defined(CONFIG_HMM_MIRROR)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 0668b09d7394..804eb04cac2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -688,9 +688,8 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
>   	}
>   
>   	readonly = amdgpu_ttm_tt_is_readonly(ttm);
> -	r = amdgpu_hmm_range_get_pages(&bo->notifier, mm, pages, start,
> -				       ttm->num_pages, range, readonly,
> -				       true, NULL);
> +	r = amdgpu_hmm_range_get_pages(&bo->notifier, start, ttm->num_pages,
> +				       readonly, NULL, pages, range);
>   out_unlock:
>   	mmap_read_unlock(mm);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index d069e6c096b6..2dc3b04064bd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1596,9 +1596,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		next = min(vma->vm_end, end);
>   		npages = (next - addr) >> PAGE_SHIFT;
>   		WRITE_ONCE(p->svms.faulting_task, current);
> -		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
> -					       addr, npages, &hmm_range,
> -					       readonly, true, owner);
> +		r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> +					       readonly, owner, NULL,
> +					       &hmm_range);
>   		WRITE_ONCE(p->svms.faulting_task, NULL);
>   		if (r) {
>   			pr_debug("failed %d to get svm range pages\n", r);
