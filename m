Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE4BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 20:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E9310E955;
	Fri, 25 Feb 2022 20:59:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C21110E955
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 20:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOATzXGSyseQ/YNeyN+RuX0f0oXdMaksw4g+RzHVaYOUEWyn39BUncOqECtRDuQdzr85ZH6QDlgvNZYWtf2HlpE3+pnOPYuIlixkOWYKKNVwLW5Pcca0lDPGnWMkYpGsh46BLw7rs4H/R1MqcNBbqZvKsFI1e8GzJLDFkLesXawIL+HCJh5Of0McJ54lA9rsfj+xY0uJpBs95bMODV5t4VEbwat9gpJ8yjZyWe/rHYUyFMV6G/9482qXpZASqFpCM9pDevG6xo4t6QNtTWm/iMZ8IllToocxufmxuksqs7bdnAAmU2KXOlpq8SbI19PRgca9Q/yMwSWNgnA6nQw1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWQcxkxrGB8xevVAToUbbViVjgA7fhwYG6vgUnBWzUI=;
 b=cdnD3pFuQCEnEBG+wHjGl3o0t8XZ9Kb8rpmzZbVljU1UIs1tA5UtL60NsIplTEhWl+9I41ZM3Y4weBtCdkD2UjWtj32AP+fRTeIhH+X+hjDvjmhA81bbVMVNxfaAjq3iMWH/csDaNybEAALo/t8vE1P3BGgIWyqi8pUw1+QD6AXF+4XzD1dmiWj2bMj/4MVngPitId/c9pqQGrLR4Uq/KnY2wrl4LXWgwdvsiiC6M/TJMONI7BrVEnDTsOI5CT1IL1r9ekBZnvqHXF0fPpoTmaUn2ByayUNElHYFH7i4r8khXgmIGchf8Fddq4U7Y3uKzLLKpDcxT+Ir1Zx+dPvSlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWQcxkxrGB8xevVAToUbbViVjgA7fhwYG6vgUnBWzUI=;
 b=a9JEWk2boqhGSGxbDvp76+3jUIjwXySZa1sSipIPsQ/3rdVp20CF5IUqcMzC0UbShzG9DO7XZw9E9belk60avgci34FV5qvAhxwKHeLGdXjBUtc5CQZYljPmnyVEMYyHPx0W4OBgZexpMB3iwN9uvU4l0376mmmQHpCuz10+07I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BYAPR12MB4693.namprd12.prod.outlook.com (2603:10b6:a03:98::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 20:59:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::410c:b456:62cb:e3f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::410c:b456:62cb:e3f%5]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 20:59:18 +0000
Message-ID: <41a573df-9580-24c0-ad4a-5e6a4937ac71@amd.com>
Date: Fri, 25 Feb 2022 15:59:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] Revert "drm/amdkfd: process_info lock not needed for
 svm"
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220225201230.6441-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220225201230.6441-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4617e1f8-c961-4873-4cbc-08d9f8a1b045
X-MS-TrafficTypeDiagnostic: BYAPR12MB4693:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4693BBFBDC2288196B7F3D5C923E9@BYAPR12MB4693.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4qX8KM7Z3r0d9F1DcMDF/3y2tJ0594i6M3wMUosi4XhQOpiVaUkLsk87LGIX2NanSE0hKXWMOrENprdyvwjiroFCniHC26UkPzj23Igw0/TrrlmrdCh73UUmkLSnCbiXrY05FKMUUwWjQhVwtjnKpZ8WnQP+s2ATep/BMYoLwucpGL2ead+tlHphc6A//X5I9E+ngeUN1qTWW58wOXVZKS/tgkBZbId8AMXfSvtd+8Xntvn9YFC3/rt/Yoa9jXHRo7/X4YM8jcHJpRy+dUby00ixGbnuiooAWZiwBEjbfoGAzXZyzOArbKuFLZZQXVbhrJ6K40GjI7RDqv1RQoJuRNhyj32l48udejPSF1vJvfMCgBTwGcqcugWTlf+kkc6KKM8O7dSlBnQI1tpVw6T72HY5oXoqwWW/pu8743Qgn7q2wLyM00zxj0fPg+0Vso+9QfOSMPoPHHpB62LXy1ZR1SEDF3HwdKda6OTlSZGGnj4flp7ITEAYTmyr7RN+sDeD6t8g4ttUOkYsxZbbDwW1XDHo2/5pJpzEQvCBGzkgNPXamz7QnOjIM0NWccdkhUEX8rk0lX9Sap+o1hkoF0TAwlTJXMc9D8PdZVC1Frlak8blHkE4g7/brOYSHkLKcutrG5t+Q25UlJgJgT7on/a6xtHuZ8SNmBHpYfUMK3yP52T7euPKxJd1vGwMiseYMgObzmF2kCxuTVI+/xTA9Yn6JMwRfOofmJoTO+tK/9ePRflSfHM5SR3Y1Vg35CwjqBL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66476007)(36756003)(44832011)(6486002)(2906002)(186003)(26005)(2616005)(31686004)(8936002)(5660300002)(316002)(66556008)(8676002)(508600001)(38100700002)(86362001)(31696002)(6506007)(6512007)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c05yZzRmalNTV1kzUXRCWEVDdUo4YWJpcWhsNzk1VjVYWDZZU0RLalZNM1hn?=
 =?utf-8?B?aHpXVUNab2x5RnovcG1ONkZmSk9OQnNJdElFU2p5ZlFTNGVvSXZKa05US2Y3?=
 =?utf-8?B?cDcwUXdtYjJZT2tjR1VGVlNQc2VGeEhiWjFUbVdNMzVCOXA4VkdqQ1JwZ2hn?=
 =?utf-8?B?Q2dnNUZ5clpCNWtGT1RWVnBWYkpEbVV6OS9yall6OElhUjdlZGUxMjY0bWZZ?=
 =?utf-8?B?M0NxaUduTkhCc3pwdnJ0TFhYZTVQUzdPcmN4a3dwbXd6RGE0S25ETUVnR0o0?=
 =?utf-8?B?MzN1ZWFXM04yeUxXYlpveTU0VkZ5em45RGczWnp2M21ERXQ1S3lBZ1pqYnE0?=
 =?utf-8?B?M3JWenpXdm5TVUIvZDR5S0FhSXNTb1drV1VVSjd0K0VEVXFXbWdaTzhrK0VW?=
 =?utf-8?B?T3poMzBhK3F6aE4xZFJmeDMwMlVWNjRSbUhEa283TzJDKzlqWmR3WVd0Q0ND?=
 =?utf-8?B?V05Qc0ZBbHlPekE5RHZQSVdGdjlWRTBORkdLQ1RxakFvUWVHZmhITjg3TWFZ?=
 =?utf-8?B?dXhCMlhBRFk0RTVDTE9tZVR2KzlnaGVEcTBubWwybm5HV1FUdWJDaE5DbjVz?=
 =?utf-8?B?bHFxUTk3ZFYxUkg1MkkwMUg4emRSdXNSbFJEWWttM3FPVlBTSkJiZjlCbHdY?=
 =?utf-8?B?bzl6YTF4Mzk1SHFTUmhOVHlsL2JOdWZmbjVLaW5yWGcwb2tFT2FtS0FSOThR?=
 =?utf-8?B?eEt5L0gvWFRHYVU4V29NRkhlWldsd0gyV1g3LzU5MVlUaEszTzUvdUd3U1JJ?=
 =?utf-8?B?N2NqZ0QxSDdxdXJoTmdBNGdsclc0Mkd2KzJYcUcrZllUemRVSEJIeTRycnha?=
 =?utf-8?B?TGlIZm56MCs0czc4TTZrUmJjWFFQd2VRZ1J0by9wTFNscUxycURYcFUxQ25Z?=
 =?utf-8?B?M0FqYndNTHMxTmNBclp2ZHlOc3piZjhVUTh4WUR3cVdsZGl6ekw4bjVsSXFi?=
 =?utf-8?B?T3VXNGdwN25rNGxDTnp5VUtFZ2ZFcXM1Y2YwcnUwVHpwRi9kSURCT3lSQmtj?=
 =?utf-8?B?MHVWaFg5SVNadE1iWWRJdFA5a3I2c0RjNUFDaWo4aWlxbFRtdFBWRlA0bmls?=
 =?utf-8?B?ODc3WitVa1Q1Q2pyNFg1K21kMVhwMnlxMTM5S2k2d296SmFXb2JXaTJ0Q01l?=
 =?utf-8?B?aVk5OHQ1V2VtQVFOL0RqUG80WW8rZFowalV5NE9Ha3EyT1ZzblluL3VlSVIz?=
 =?utf-8?B?b2w5NkhZajFuRVNyekt6Q05xTGFCRHBldVpIOVVDVTE5eStDS1U2ZVgvWmpU?=
 =?utf-8?B?cTRJZU1JUjdrV0ZESlNoc0paS3YzcjZNOWVVbUlJczNjMmJNZ1poWHg4U2Jm?=
 =?utf-8?B?WmMvTFM4M0xkZTVvUG1FTHRvSmVOTkNlWmVxSGMybTUrMTRXam1lWW12ZFJ6?=
 =?utf-8?B?YVVydTE2S21xeUpIZk4yai9yT2RTZmRvOU0wSUdDa0ZUSEFtWDZIMmQ4aVlV?=
 =?utf-8?B?Z0tSc3dmazg2M05Ob1ZLUjJnU0FZZHFUQm5Kd0QvQWpUNFRXTkwyeG0vcHZy?=
 =?utf-8?B?by9aMDBDOSs2aWVRekZSa29wSEhaVDE4MnlVV1ZTKzdpbk5XYnhmUzZJUDRN?=
 =?utf-8?B?dHZpc0NaWXB0RWRaZldrUGJCU2tyZlhIQXVnSitQa1RzaVV0d1UybDJkelZK?=
 =?utf-8?B?cWtrS0M4TVV0a3hUMlVCaDA4bUo0N2NFRUxWZDBJZTc0djZ1YU9QV0pBNzRh?=
 =?utf-8?B?RDc3aUNWNXBDQ2pRcjNDZjFTSytVaHVVMDBXOU5oM3d6VEg0VkdlQTNmNS9v?=
 =?utf-8?B?VVRXZkNzVitVTEZnVG90eFRwNHQzZHN1eE9vdDRBUU9ScUVyVmR1V3pSM3ho?=
 =?utf-8?B?U014ZDFxNnNVREE3R21NaWVhQ3M0U0xzRkRJT0NrQXRaM0tTUHV6RFRNWEtl?=
 =?utf-8?B?b3dUZmdhdlpVNmdVeGpuV0ZsL3BkeStBUzlYU2Vmc1czdVlnb2FVeXFYTi9R?=
 =?utf-8?B?cE8rSE5UaWlWVlFtU0NFK3k4L2ZFUVJQSkdhV2VuZ1JJeG5sdklsSFU2T3k2?=
 =?utf-8?B?ZkRxdjlJcXRPTHVLQ2pyb2xVWjc1cjlCc1V5VGs4RjZ3aTJMZ0tOVll4QWt2?=
 =?utf-8?B?TS9jOGZqaGZ4SG82S0R1WG84M1BFRjNuelpSaTFIeWhJWlZkc2s5eURUN2RE?=
 =?utf-8?B?YzBIN2NrYm9HaE94bWpnQ2J3QXFDbndocUZxeXlxVHQvVFFxSE0xdkYwNVZk?=
 =?utf-8?Q?hWbFo6AIShEPZKQCl107VFs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4617e1f8-c961-4873-4cbc-08d9f8a1b045
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 20:59:18.2421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3HaBxgMqPlkTP0ten//D7A59Y1q9L2o9wbG9mDEdkG4Pyy16lZUWWYLhnvAuZReUQWmoBW8dRBLc15zT5VtWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4693
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

Am 2022-02-25 um 15:12 schrieb Philip Yang:
> This reverts commit 3abfe30d803e62cc75dec254eefab3b04d69219b.
>
> To fix deadlock in kFDSVMEvictTest when xnack off.

Please add your Signed-off-by. With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b71d47afd243..509d915cbe69 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1629,6 +1629,7 @@ svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
>   static void svm_range_restore_work(struct work_struct *work)
>   {
>   	struct delayed_work *dwork = to_delayed_work(work);
> +	struct amdkfd_process_info *process_info;
>   	struct svm_range_list *svms;
>   	struct svm_range *prange;
>   	struct kfd_process *p;
> @@ -1645,6 +1646,7 @@ static void svm_range_restore_work(struct work_struct *work)
>   	pr_debug("restore svm ranges\n");
>   
>   	p = container_of(svms, struct kfd_process, svms);
> +	process_info = p->kgd_process_info;
>   
>   	/* Keep mm reference when svm_range_validate_and_map ranges */
>   	mm = get_task_mm(p->lead_thread);
> @@ -1653,6 +1655,7 @@ static void svm_range_restore_work(struct work_struct *work)
>   		return;
>   	}
>   
> +	mutex_lock(&process_info->lock);
>   	svm_range_list_lock_and_flush_work(svms, mm);
>   	mutex_lock(&svms->lock);
>   
> @@ -1705,6 +1708,7 @@ static void svm_range_restore_work(struct work_struct *work)
>   out_reschedule:
>   	mutex_unlock(&svms->lock);
>   	mmap_write_unlock(mm);
> +	mutex_unlock(&process_info->lock);
>   	mmput(mm);
>   
>   	/* If validation failed, reschedule another attempt */
> @@ -3209,6 +3213,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   		   uint64_t start, uint64_t size, uint32_t nattr,
>   		   struct kfd_ioctl_svm_attribute *attrs)
>   {
> +	struct amdkfd_process_info *process_info = p->kgd_process_info;
>   	struct list_head update_list;
>   	struct list_head insert_list;
>   	struct list_head remove_list;
> @@ -3226,6 +3231,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   
>   	svms = &p->svms;
>   
> +	mutex_lock(&process_info->lock);
> +
>   	svm_range_list_lock_and_flush_work(svms, mm);
>   
>   	r = svm_range_is_valid(p, start, size);
> @@ -3300,6 +3307,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	mutex_unlock(&svms->lock);
>   	mmap_read_unlock(mm);
>   out:
> +	mutex_unlock(&process_info->lock);
> +
>   	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", p->pasid,
>   		 &p->svms, start, start + size - 1, r);
>   
