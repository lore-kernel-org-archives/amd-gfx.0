Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F80C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 23:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3394610C8
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 23:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3394610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81E2C89A8B;
	Wed, 17 Nov 2021 23:18:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A3589A8B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 23:18:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwpKnN/EhhuvFhIN/szrphG+HaPEtmyDSMKqQkJKeuPnJMbLiu/VSUlq6XWOHn7gtNDjG5hO+jOUax9yk1y8urS5ZPYuEE7aPBCjrC+CLpS2FSO4jNP53VzmmlKh4dFgxbMLRb6YXmutQtWtWCM5upl+Ng64P2SPjGTkUNPirUOUb/wspmsQXgQdgq1s1HkTuN8/g0XBI8oNK4CrjFO50Bg6g6NRQms0LLaGpsAb4UsXNrUdXz/lafzxG9M1XRJc9xa7lBArCXppznwuaO9FPwi6gozc8IO8WQhyPeJRCw7yVJsv2oQZKpPjQwJUn7odPZRnCOrtLpXo6yNgf5J6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5WOrtoeCnKmqryvsy04WuBTjPfNfSxL7W860BZN1FI=;
 b=Edp6OmlX7tysyUbq9scLbTlWKgnbBMPsIOI4XCFlrLJQs+LRsGNyaG5bKG13WR0NBJiJW2KMN0LBVieH/kD/xkcyfHf9zuCGqNIiJv0C1Yb19h16FzXDMUfGOf6EXyQdvuxL2mi23ujSksgqxCHnLMJ1zEyxWrHrOkf5b7QGhbEvOJqRFbqUL6AlaI5sNf5sB9E+/kH5Bu6TC5PIzvIVlEwZTXpE1+CIomTrEvKQluHDDnR8NvVRBK0zkCe3XgHqEXfULPcnt1whSLeffBePTfrs5w5ABmI79/Ws5eUOSjCtMDTXP+OWYQoZmtQzzLNDekBAAir78PJrWq90+dkinA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5WOrtoeCnKmqryvsy04WuBTjPfNfSxL7W860BZN1FI=;
 b=CBIEOrR1d3lrz+5RKe7KSQVCHAHqzBZeu11bGBb/rqEsW1EowGh+c/lYYU8WYqWMZD5qpjX5x5TDpt3AXWp8LLkM1j4Qd4y5fQ08sly8TqfuSpMIecXOqVzEWJKOfzLURWnH42CHQNpiHbKZinBcKTTrRC3wB3qDX22WfsFq4k0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 17 Nov
 2021 23:18:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.021; Wed, 17 Nov 2021
 23:18:50 +0000
Subject: Re: [PATCH 1/3] drm/amdkfd: process exit and retry fault race
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211117034324.4663-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <fb6b3750-56e4-8a79-c479-10c4cbbd3e4a@amd.com>
Date: Wed, 17 Nov 2021 18:18:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211117034324.4663-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BL0PR01CA0016.prod.exchangelabs.com (2603:10b6:208:71::29)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 BL0PR01CA0016.prod.exchangelabs.com (2603:10b6:208:71::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26 via Frontend Transport; Wed, 17 Nov 2021 23:18:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e08f8312-8574-4c95-90e1-08d9aa209d11
X-MS-TrafficTypeDiagnostic: BN9PR12MB5131:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5131492A413356550E98334E929A9@BN9PR12MB5131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4a4lVCd5oULrBrs0ZAtG0Ld6k+fdBQjLhY8JSsPx5+ngpCeowPZ2Hx9mcTmrWudDTcvMQeRSQci7Nzt4QGyjQEHl+O2QE3Vp5HdvuY4ntkFhvkoXdugk8PIijV5LtRnh7J7UBlcVAdEwP49+D7Gfg+RCxWxtJLeWOIlbW9q9LyXwt1SJ6lIc9sOzdAN5aw9f81lI56ZFDfvTiahLPlcrqx/tiEI1JHmex4xCMDWXR2Q1JrB6GxmfnmbCgwkG9/x4PBC+9/NWrnY80NU5jm7ZZ28z7my4vCGoKgFBZ0RLUCbhguG/IKLIh/iituhVV2smvu+cQPMfrUNRDcyr4SkpGwH1aI7QTRyBAMQpCKyHSQH7HhHAhhGA94t+Qx7Jo0UtCts+5dXplbKwkxYsySk+y2bOQDcMLMIxecNQNuVZ1hwDWG42VVeB6J9GfOXMoXn+a2FKeLZUuhHEcjrFXvo49MkSq3nQ6TQrewy1lE/n4y8cqc4uqYJCpWCGmAFJ3YQywo011cxZamcMQf6d2M/Umpmg4sAwB3xcr5t0UqtinJnO5dbJ1eibxWiq3WMHbkuuOpejvB354K8nP3nqhPY67/7+OZw17wOjr7QRPMz7abP/ZKxkKcFxQNlg+XPkyxzHjkl16QQTNzoAeF+oZ51WtSjMX9VDOtwGRK8jSW5Y8sRvernk3G7DiJlVq0Wg/mmYwc7jycH5Evc8o5VNOhBr+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(83380400001)(31696002)(2906002)(4001150100001)(36916002)(53546011)(8676002)(5660300002)(66556008)(66476007)(508600001)(66946007)(44832011)(86362001)(16576012)(956004)(31686004)(316002)(36756003)(8936002)(38100700002)(2616005)(186003)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2p0YktwUTFRb1c1dnRkdnZWemFsRUpOVUVjL051TFZtcU1wQ253MTJhaUVQ?=
 =?utf-8?B?SUFkYkhKdkhFWEp3b25IUmF3R25JRWVWVlg2ZXpYVXYyMTZVZVBxL3NaSHJM?=
 =?utf-8?B?Y3F1eTNBR21QajErQ1kvMVEyKzJoUnlCanB2TzdNN1NuSTA4MVZTalJLQVdr?=
 =?utf-8?B?VEhlWG04Y3A5b2RIaTlqZW5MMzVDK0ZNV0ljbk91MEJkN3pOODlKbHRySWVv?=
 =?utf-8?B?bVJqUk00eG51azJsYTYxYWtTNmpNY1BWS0lxYjQzWlljTjNIRHp2dWpYbno4?=
 =?utf-8?B?OGFCUWxycXlBb2VpR2ZLb0cydzBJb0IxVGJSa0RiY0w5UitqclRzWXBWeVhE?=
 =?utf-8?B?ZFFoQ3o4bmFVWHVmaFA1b0RhRjlocWVBVnpvTXM1VlhUbVI0bmJ1cnJOdytF?=
 =?utf-8?B?Wkt2MCsxTTdSYXI0SjVBWVlhcWF5azVXeVNlWFBjTXJNaWNoUVJ2dU5JYU44?=
 =?utf-8?B?cjB1ckNUV2ZaaXB5Q2xzaW93bzMzTHFXQzVVRWF3ZktUR2pqd1FBUjY2Vmdq?=
 =?utf-8?B?aEVUY3FaNGl6cStERzh5NEFjdEhBRnp4dTNJOTMyL0Q5cTdUd0dQaytsdHpB?=
 =?utf-8?B?VDBGd2QrTm4weis4TEljVlIzNVVNOEw2a3JSMllmWVo4czhWVklYejJheTQ2?=
 =?utf-8?B?bFVJQmlOdWFvc01xc2FhaE1WaFI5a0IxMmpCZkRGNEt6TmU0NXN6VU9uVnQy?=
 =?utf-8?B?Zk43YTRzRmVZMDlxMVJvU2V1LzJ6MlFmMEpjdGVlUVVHeDQ1N05tRS93bWhS?=
 =?utf-8?B?OVhteWJ1K0FoemJPY3ZWL0N6dVhrSlBFSjEzTXVxQnFYRFFnTi83dkRKTm5u?=
 =?utf-8?B?RjljM0c4NWdaak5tNUZlTlloa3czYkhNd0lmVXNZdlh2T0NLSmlJVkVDQ0tW?=
 =?utf-8?B?ZmlDYjk2d3N1YjE4cTVYeGdwcGVhR09ndkp5bzR6dFVocTJ2b0NRL3dzMUVJ?=
 =?utf-8?B?VncrU0hSSlZkZ0pIWFp0Z0ZNNkY1RDVJK0JManV4T3lnUkVxNEVoOExXVVNR?=
 =?utf-8?B?cFZpdWc5STNoaVVUNHZoWkE4QVVGbmpNWGJLQ09hN3RtZ2psazdTN1BaVFQv?=
 =?utf-8?B?V3RDRkRwUWxvWGFram1PeTJreTVtUHU5UmVaNndlZUpTTE5nVEZ1VTNDNGJh?=
 =?utf-8?B?MW1yU2VzczgvSzZXWW43dEp4d2hiaVZlN1ZLTkZjcmRWUmVONnVNZ2wxSDgx?=
 =?utf-8?B?QjNNQ0lyM2Q2Z1dyamVQRTNKZmNRdTFxMnlKT1p3dnVqZCt1Wit3YlBkR3pJ?=
 =?utf-8?B?TVBlR044RSt2dHNiSE5uckYvVXhOaTkvV3orYjZ5WjF0TnJ3R1NFbzBaQmIv?=
 =?utf-8?B?Y0lreDJ6aW9rZytzU2ZVckIrMjlDV280djdFc2RsY0hISmwvM1VPTnlXNU8y?=
 =?utf-8?B?YlpsSVB6WDIza2JUZ3g3TEZ3S0cvSVpadVBtS08vVEVsQkdNSkp3WDdDN0hJ?=
 =?utf-8?B?UlM4N0VnVHhkZnFQeTYxdE5NU2xyL3ZZWEFXb3FuOGp3ODNGdDJpc0pnaGdJ?=
 =?utf-8?B?cC9jbHpjbFRMWUxkeWY3bXNKcG00dWRmY2N3em52MXNSL2dseGNjVHhUOEJK?=
 =?utf-8?B?dTBkVVhJcUNVVGNucURxUnJvSVRaOUNQajd3OXZtaXVtdDFURGpFOWtsT3FM?=
 =?utf-8?B?U203azhPMFJ3RXpFUi9hbXprSm4xWlREaEJVZzhHYzYzNk03dU5lbWdMN2Nk?=
 =?utf-8?B?eTUzUFN6ZzU0cENtdUpBOUVxa1pRdEw1SzN1emF2QmVrenczQzlPSFZVZ0p6?=
 =?utf-8?B?bUpyRUphSCtnb1ZlcTloTW9zdFBkbG1WNlVuUk84b1hXSUVCZlZoZjJ1WTNP?=
 =?utf-8?B?ZStPY0FGREp1ZG9JVTJHc3BwR2RGY2ZVUDhLbkhUcUhYQytkN1JrZWVNZzZY?=
 =?utf-8?B?amp2QmUwelRYK1gwVjU2M1ArQ2NYbzZGWDR6U2RVak93eTVBQzIvaDRXajUz?=
 =?utf-8?B?MHl5VUUxbkhkM0RvTjVVRkZqcytDSHBjemF1akFOYmNEUGo5dVNmQm5nR2g0?=
 =?utf-8?B?S3lrVTExdVE0WHhhRlp3VGJZUVg1ZUwxWFRzZjJ2Sk8rQ3VBVFRBN3FMdVJx?=
 =?utf-8?B?WUN0L0JmVEkxajM0Nk41MXlLTnlYOGIrOGdZd3M4Mkg2T3RmYVN2UjNLZU96?=
 =?utf-8?B?NDVyZmNrcVNneTkvWWNiQWx6NmliSlczQmlFY0ZpaVJYZXQ2NWVyd0dyTGsv?=
 =?utf-8?Q?rrBxE/41jxhDZ+wR0Gp5Tfg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08f8312-8574-4c95-90e1-08d9aa209d11
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 23:18:50.1919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ax4SuyehrpJ/anQR8jJy2VsECmdNRoecRfxiraMcGRFkTRwVYxdU111i5KNVjvZpexEGopyb2YozAUdBoxvf5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
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

On 2021-11-16 10:43 p.m., Philip Yang wrote:
> kfd process mmu release notifier callback drain retry fault to ensure no
> retry fault comes after removing kfd process from the hash table,
> otherwise svm page fault handler will fail to recover the fault and dump
> GPU vm fault log.
>
> Drain retry fault needs flush restore page fault work to wait for
> the last fault is handled because IH dispatch increase rptr first and
> then calls restore_pages, so restore pages may still handle the last
> fault but amdgpu_ih_has_checkpoint_processed return true.

This fixes the problem, but it will result in waiting longer than 
necessary because the worker only finishes when the IH ring is empty.


>
> restore pages can not call mmget because mmput may call mmu notifier
> release to cause deadlock.

See my comment inline.


>
> Refactor deferred list work to call mmget and take mmap write lock to
> handle all ranges, to avoid mm is gone while inserting mmu notifier.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c |  6 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 69 ++++++++++++------------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
>   3 files changed, 41 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d4c8a6948a9f..8b4b045d5c92 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1143,6 +1143,12 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
>   	if (WARN_ON(p->mm != mm))
>   		return;
>   
> +	/*
> +	 * Ensure no retry fault comes in afterwards, as page fault handler will
> +	 * not find kfd process and take mm lock to recover fault.
> +	 */
> +	svm_range_drain_retry_fault(&p->svms);
> +
>   	mutex_lock(&kfd_processes_mutex);
>   	hash_del_rcu(&p->kfd_processes);
>   	mutex_unlock(&kfd_processes_mutex);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 88360f23eb61..c1f367934428 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1953,9 +1953,10 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange)
>   	}
>   }
>   
> -static void svm_range_drain_retry_fault(struct svm_range_list *svms)
> +void svm_range_drain_retry_fault(struct svm_range_list *svms)
>   {
>   	struct kfd_process_device *pdd;
> +	struct amdgpu_device *adev;
>   	struct kfd_process *p;
>   	uint32_t i;
>   
> @@ -1967,9 +1968,11 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
>   			continue;
>   
>   		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
> +		adev = pdd->dev->adev;
> +		amdgpu_ih_wait_on_checkpoint_process(adev, &adev->irq.ih1);
>   
> -		amdgpu_ih_wait_on_checkpoint_process(pdd->dev->adev,
> -						     &pdd->dev->adev->irq.ih1);
> +		/* Wait for the last page fault is handled */
> +		flush_work(&adev->irq.ih1_work);
>   		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
>   	}
>   }
> @@ -1979,43 +1982,43 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>   	struct svm_range_list *svms;
>   	struct svm_range *prange;
>   	struct mm_struct *mm;
> +	struct kfd_process *p;
>   
>   	svms = container_of(work, struct svm_range_list, deferred_list_work);
>   	pr_debug("enter svms 0x%p\n", svms);
>   
> +	p = container_of(svms, struct kfd_process, svms);
> +	mm = p->mm;
> +
> +	/* Take mm->mm_users to avoid mm is gone when inserting mmu notifier */
> +	if (!mm || !mmget_not_zero(mm)) {

get_task_mm would be safer than relying on p->mm. I regret ever adding 
that to the process structure.


> +		pr_debug("svms 0x%p process mm gone\n", svms);
> +		return;
> +	}
> +retry:
> +	mmap_write_lock(mm);
> +
> +	/* Checking for the need to drain retry faults must be inside
> +	 * mmap write lock to serialize with munmap notifiers.
> +	 */
> +	if (unlikely(READ_ONCE(svms->drain_pagefaults))) {
> +		WRITE_ONCE(svms->drain_pagefaults, false);
> +		mmap_write_unlock(mm);
> +		svm_range_drain_retry_fault(svms);
> +		goto retry;
> +	}
> +
>   	spin_lock(&svms->deferred_list_lock);
>   	while (!list_empty(&svms->deferred_range_list)) {
>   		prange = list_first_entry(&svms->deferred_range_list,
>   					  struct svm_range, deferred_list);
> +		list_del_init(&prange->deferred_list);
>   		spin_unlock(&svms->deferred_list_lock);
> +
>   		pr_debug("prange 0x%p [0x%lx 0x%lx] op %d\n", prange,
>   			 prange->start, prange->last, prange->work_item.op);
>   
> -		mm = prange->work_item.mm;
> -retry:
> -		mmap_write_lock(mm);
>   		mutex_lock(&svms->lock);
> -
> -		/* Checking for the need to drain retry faults must be in
> -		 * mmap write lock to serialize with munmap notifiers.
> -		 *
> -		 * Remove from deferred_list must be inside mmap write lock,
> -		 * otherwise, svm_range_list_lock_and_flush_work may hold mmap
> -		 * write lock, and continue because deferred_list is empty, then
> -		 * deferred_list handle is blocked by mmap write lock.
> -		 */
> -		spin_lock(&svms->deferred_list_lock);
> -		if (unlikely(svms->drain_pagefaults)) {
> -			svms->drain_pagefaults = false;
> -			spin_unlock(&svms->deferred_list_lock);
> -			mutex_unlock(&svms->lock);
> -			mmap_write_unlock(mm);
> -			svm_range_drain_retry_fault(svms);
> -			goto retry;
> -		}
> -		list_del_init(&prange->deferred_list);
> -		spin_unlock(&svms->deferred_list_lock);
> -
>   		mutex_lock(&prange->migrate_mutex);
>   		while (!list_empty(&prange->child_list)) {
>   			struct svm_range *pchild;
> @@ -2031,12 +2034,13 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>   
>   		svm_range_handle_list_op(svms, prange);
>   		mutex_unlock(&svms->lock);
> -		mmap_write_unlock(mm);
>   
>   		spin_lock(&svms->deferred_list_lock);
>   	}
>   	spin_unlock(&svms->deferred_list_lock);
>   
> +	mmap_write_unlock(mm);
> +	mmput(mm);
>   	pr_debug("exit svms 0x%p\n", svms);
>   }
>   
> @@ -2600,12 +2604,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   
>   	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
>   
> -	mm = get_task_mm(p->lead_thread);
> -	if (!mm) {
> -		pr_debug("svms 0x%p failed to get mm\n", svms);
> -		r = -ESRCH;
> -		goto out;
> -	}
> +	/* mm is available because kfd_process_notifier_release drain fault */
This is not a valid assumption because the mm_users count is 0 when the 
notifier_release runs. So you can't rely on the mm being usable here 
while you're draining faults in notifier_release.

A better way to avoid the deadlock would be to drain faults not in 
notifier_release, but in kfd_process_wq_release.

Regards,
   Felix


> +	mm = p->mm;
>   
>   	mmap_read_lock(mm);
>   retry_write_locked:
> @@ -2708,7 +2708,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   
>   	svm_range_count_fault(adev, p, gpuidx);
>   
> -	mmput(mm);
>   out:
>   	kfd_unref_process(p);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 6dc91c33e80f..0a8bcdb3dddf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -189,6 +189,7 @@ void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
>   struct kfd_process_device *
>   svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev);
>   void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);
> +void svm_range_drain_retry_fault(struct svm_range_list *svms);
>   
>   /* SVM API and HMM page migration work together, device memory type
>    * is initialized to not 0 when page migration register device memory.
