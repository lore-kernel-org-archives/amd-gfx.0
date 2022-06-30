Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260E0C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 14:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8AB810F366;
	Thu, 30 Jun 2022 14:39:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6955610F366
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 14:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q71BKNUUgw1jFOne1HTBkrAv++lrxmKcPCRm2ukDEaxSSsCeQqjA1r5JDXXeFZBjwEeYfl7z0LMYZgwQxp0tgRGLbIOZJksDuMxKfib4wujNG4ebkupyW6Cy/qIbdqCGzNCG2H35bbiRhMgy7Nupvj50Pm3NMG1DCFQkZJ3mJ2F6ScfF7m/EmgrIj4vA2igsyLOGS5KlJBhaZ/ThnmraqX+IuHr4D+w5yZInBNnYSV68N0IIm7gVPQJKiP0r1iKFZxVPeTvosKIFXg9K7+sbxx3bTErMSuRfFqcb4mZ9M8lJfLbYE+NWbeAr7BA7MKjIyqdWbuX5anI+txNaJaV6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/l1tRVtJUwTges/xk1Gw/1pbEsm6L/3HGs6ha8cYPTM=;
 b=Y5c0XFqjsn0QY0NPf9QLc+IVb27gQwMTcLlJEL8cusPaYem5rVXIC3nYLaVMmRCvgqmPKDmmarulZKS0G4WPDN3g38XzmwksySnc/US1cmvDKXbgTrIMl9zBUIgpIOCgZSpWOgeeMiYQEFUnvVb3RsXboVgbQwRpkDZYknp+avZtX9uvh8ACXr+CwTDjP5gAkv/s9GqZkrh4F0HlOquAC429HtG807VxxdKHvq5MR9SaasReKLp3R0Y5jSG2PLPlMXyZzl44lmHhYyZyE+Z93UAQ4c47ya/HRWpe6l3r+9s836M8vBFq+mxj5QJBzY/1hzqK2B9Z79YMq7QGUacsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/l1tRVtJUwTges/xk1Gw/1pbEsm6L/3HGs6ha8cYPTM=;
 b=pII2/MD71NPJzYJZBcNb4qsL9OWvUmQlQrRNT+OSCKfZl4XXBmSbJRU7e6HwR0m0L0epzmc11lYF+DJc4OmHdJwm/P9oY2v+2UrpynQOw0c4/bcu/C0QgFq6/xiu6urZ1znBNxS/4AtRrV0hkbo+muA2bYvM4RgrLwzh9XPlmds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 14:39:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 14:39:10 +0000
Message-ID: <d8526c4c-69d2-88ec-41ab-61c1b46a9bdf@amd.com>
Date: Thu, 30 Jun 2022 10:39:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 6/11] drm/amdkfd: Add unmap from GPU SMI event
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220628145020.26925-1-Philip.Yang@amd.com>
 <20220628145020.26925-7-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220628145020.26925-7-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 664204b9-e779-4bb9-bde6-08da5aa64b0d
X-MS-TrafficTypeDiagnostic: DM4PR12MB6589:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sXNOYGe+i5XrTTUqPacfQ6UH6+9kH0W4LrgTEwRfh1OvKePgeSj3gqsaRwCsGXu9jfFDj8Qg2zaxBYWTr6uQhgySUHzGXjQIMHnA32YXZXs2JWtwZdWAjCL1I+QrDn2AZzn0LhjTSocRjBQPtGQLIYPYo46NdxjcwlU8qtKcwai9cGBeFK6rgWrg/YGxukjMAO9EsSStnfILqteVu3+GvgdUiUGyo11wwVJ9WJhTqhckLOyL8ZqEn5hiMg88b76SBRmz9plKEEE9QEwCziix+wlTs8UsDErxhPhuWIEvSxFAx4Xx86TLLofUYO9F+vLhuxdvdHz+UISqmS0MQiPxv9nNzAdmmglvBQT5TAuuSnkQMmzKTrM9mqTVihnW9b8Km2G9ZBdFaswUrejq8jimp0P4Xmk3KBswoktf5yP0tL6ydPo9eeQudr7b9bQiEAUm1mlJQK4s9xu3Iu/XymitHGMHgaRYzjL0O2nmyvujq4MmDfCCuoLs04U5Hp7oaInHb8C2y3IESBLON6u8iAA8G/vXaV+9GzTQlD9fxXYGATiraiQh+DV/42FJcvQtDXc0YA1goQ5PUKKoEy856zNncyWTmU1acIb75d4mflzn/RcQQzRKrS7kZstCoKj9G/Vcr+X0vV7WbbZ3tKGBXebDcLs5JmmcpwOIUnJIOfPSTjTUOWoAECOXIepOavXjZPR7QXVIqpSwUv5FvYZ0S9GrBq7PW/eMyIbW3Zf6QLDEkHMNBMderQuE0Amp6yL/uZtoFp6QAznUmkcqRA4S4TuXKzMhgj9Rq/cbhQcUl7Vat49k6F7mDBwTXepHVo88CaVqg1Xia7/7BtM0jFI8fCqluxHhE0o0/gjrELVH94Qktac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(26005)(31686004)(186003)(83380400001)(44832011)(6486002)(38100700002)(36756003)(8936002)(478600001)(2616005)(316002)(66946007)(6666004)(66556008)(2906002)(41300700001)(6506007)(8676002)(66476007)(6512007)(86362001)(5660300002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm9rMnNmanN0RU4yWm00UUtTcGtFdG9iTllRMzVEdVpCeFpBSTZUYlYrWWxr?=
 =?utf-8?B?WkdjRjJjQnRHSzFTVjRaZkZ2cDEwcnJJOCt0elNFUG5EV2tzZW1rYlJ5M0pt?=
 =?utf-8?B?NVJtT0tDcVExU2dualA2UzRtMnFkVElaTm9NWlNUU0dvcDJkUWtkbXVlZnh3?=
 =?utf-8?B?MlNrd3ArYk9kNzRpQTNXZFduWTlFbm5LeWUzQlgyanRZak5tdmZ3TG83OEVG?=
 =?utf-8?B?QjhXSmZjTjZmMUg2NUdNcm1DMkNtTU9oZVBaZ1RNYTRvdGV4ZkJnS2g0bVFS?=
 =?utf-8?B?REZ6ZTZORTZ5VTZRMFh1NzFiK1ZZaGdLOXFTYUNJRzBWYUh3N2VKUTNRQXdw?=
 =?utf-8?B?RnJNa3J2cXVldi9DUjk2dlNUOEptR0MvSjROMGVxT2gyaGdSNkQ3M3hZUDlS?=
 =?utf-8?B?T0RlWkdDU1VTcXJIUUY5eFBzcXEwRklvV2t2bkl5a0ZiSmMvd3dJOUorQUdP?=
 =?utf-8?B?cWtFamhJWHVSOXdQTEtHUDl4bW9ZUnpSOE9EczZuKzNLTHZISTBjNU1BY2VI?=
 =?utf-8?B?ZXg2bUhpY0FVWlNicER4VUlOL1BFV2o3QU5GMXZ3YjhIbndJb3I5R1BtZ0dG?=
 =?utf-8?B?S0IvcU5US0d4SXZ1VlRkNVhKWWdaMURxNWRzdnNQZGEwSzNRa2tkNFByU1Jo?=
 =?utf-8?B?QVNnMXRhZXZMRVlMNUJTQlZxZWRWdWJCeDJBeXF4dXEyYXdaZjA1UHpUMjdT?=
 =?utf-8?B?cTA0RWpkTm1CV0o4YU51THdkRURDUFhGblg4cTdCRVdxVEdubk9aMHAveXJO?=
 =?utf-8?B?SExxcFRqVmt5M010SFhsVHdqVStsK24wR2p6QklNRFpHSUIyUFU0VmlaRG51?=
 =?utf-8?B?ZnpKY2N2enJqM2tHbEFyRGNHT3BKeDUrTTVFMCthb3pWd1AyVjFuNU43OWM0?=
 =?utf-8?B?SVVGQmhMdi9TMlBVZlh6ajZEaG1PUWQ0MlpscjJQZENLaDVZNkw3dUpVclN2?=
 =?utf-8?B?L1B2WnROM1pFdjZicXE0S1VhbEhaT1lvMm5jUmdENkY2UVFZd3JaQXdrZTVv?=
 =?utf-8?B?OGkreHVlWkFVeFRxZHZjRHdmdSsyOVdUNUsvT0Q0OWNNdlEraHgrL1I2VHhx?=
 =?utf-8?B?dnFmN1ppbSt5N2tYMUtZRUJHQWR0MHVpa2luWkowbkgxMktlbDZjM2hVU3JJ?=
 =?utf-8?B?dFB1am9FWlZaMnVtN2JTUDRPTXZrcmFOSVVvTE1BREtPQXNjTVExL1QzWE1y?=
 =?utf-8?B?bkEyL0Q2aEJGWGFEKzEwRkN5VjBCT1dUTEV3dGtBOHc3d240RFptamtXWXZI?=
 =?utf-8?B?cjVRU3JuTFRNRDA2YVpOUC9FakFhQnl6VGdqL09ieWlNckpYVmhGQ1lEa1g3?=
 =?utf-8?B?RU9idEdLNGtNWjZjeEZ4bWQxKzdaelZ6MzNyaDMzaHkzc3Vlc1lGUm1xSEhC?=
 =?utf-8?B?bHFDUEd0bi9CalFlRUdReFlqMGlHWnlIUWNDZENCZjNMU3FHMnpyTGxjczdm?=
 =?utf-8?B?N1AyOGtrRXRGVGNnMmZOa0J2dnZTNCtiTTJRZFR4anF1NWw0S25vSmFleGF0?=
 =?utf-8?B?TEhOa1RRWXRaQno0eWIxSm1SRXM0ZEl6dzRLWXhDN2FMc0ZwUzZaeWkvTVRm?=
 =?utf-8?B?ZFUzejVSTjhjejRyYlpMWUVXaFFwRW0reEVzZUQzOEF4VkVUOWl2YWxjZ1ZD?=
 =?utf-8?B?Rk95dnFXWFdqVXJxRysxS1hyQk9DWC91ZEhiWU5qUzFpUDRjVG5iemVkRHUz?=
 =?utf-8?B?NFVVbFYzKzRIS0lxOWViQ2Z5V1ptSkxyZmNncXh6K1V5WE1tQmltb3pQMGps?=
 =?utf-8?B?Q2t0Yml2eUw0ejBQUCs4QnR2SFhJUWZSR25LS25wN3Q0aExvcUFOcXdtdE1C?=
 =?utf-8?B?TXVGcVJBYXlxQnFFMjVtRHJFc0Z0ZlFzZ1ROZFN1bjJXZkEvdDFQMFdwMkJr?=
 =?utf-8?B?azVZZDVWWmRSMVp5T0VWVllFTzdvbjhzbmFCNEZUMlc3VGpWOVZVODZBYWQ0?=
 =?utf-8?B?VGM3KzNoVWFpZUFaYUJsWGhxQTEwQnNpRlBLVC8zc0FHbTlPYXo4b1FRVUhB?=
 =?utf-8?B?QjBnbFNhcXVncmNId0pXeU9vVGVocUFqUmxGODZHTEtwZUV5T2VyTVErL21h?=
 =?utf-8?B?eVFQTlBZbC9DZFZMNWFnbFpsdStrK0Y0bE8yN2NseTY3K2pJOHp6Y0FIQm91?=
 =?utf-8?Q?egs7MjShiL3ZIGHklYWkGr7p8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664204b9-e779-4bb9-bde6-08da5aa64b0d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 14:39:10.0997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGJKqxsxydD2WcHGqXIbUQ5g1WA+NZwP8wNFL5dDgLIAHC96G3tM/XCShxg/npMjoQTVOsOw2I+/cSk9B8/EBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589
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

Am 2022-06-28 um 10:50 schrieb Philip Yang:
> SVM range unmapped from GPUs when range is unmapped from CPU, or with
> xnack on from MMU notifier when range is evicted or migrated.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  9 ++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  3 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 25 +++++++++++++++------
>   3 files changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 3917c38204d0..e5896b7a16dd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -318,6 +318,15 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
>   	kfd_unref_process(p);
>   }
>   
> +void kfd_smi_event_unmap_from_gpu(struct kfd_dev *dev, pid_t pid,
> +				  unsigned long address, unsigned long last,
> +				  uint32_t trigger)
> +{
> +	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_UNMAP_FROM_GPU,
> +			  "%lld -%d @%lx(%lx) %x %d\n", ktime_get_boottime_ns(),
> +			  pid, address, last - address + 1, dev->id, trigger);
> +}
> +
>   int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
>   {
>   	struct kfd_smi_client *client;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index b23292637239..76fe4e0ec2d2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -46,4 +46,7 @@ void kfd_smi_event_queue_eviction(struct kfd_dev *dev, pid_t pid,
>   				  uint32_t trigger);
>   void kfd_smi_event_queue_restore(struct kfd_dev *dev, pid_t pid);
>   void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm);
> +void kfd_smi_event_unmap_from_gpu(struct kfd_dev *dev, pid_t pid,
> +				  unsigned long address, unsigned long last,
> +				  uint32_t trigger);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index ddc1e4651919..bf888ae84c92 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1200,7 +1200,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   static int
>   svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
> -			  unsigned long last)
> +			  unsigned long last, uint32_t trigger)
>   {
>   	DECLARE_BITMAP(bitmap, MAX_GPU_INSTANCE);
>   	struct kfd_process_device *pdd;
> @@ -1232,6 +1232,9 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   			return -EINVAL;
>   		}
>   
> +		kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread->pid,
> +					     start, last, trigger);
> +
>   		r = svm_range_unmap_from_gpu(pdd->dev->adev,
>   					     drm_priv_to_vm(pdd->drm_priv),
>   					     start, last, &fence);
> @@ -1759,7 +1762,8 @@ static void svm_range_restore_work(struct work_struct *work)
>    */
>   static int
>   svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
> -		unsigned long start, unsigned long last)
> +		unsigned long start, unsigned long last,
> +		enum mmu_notifier_event event)
>   {
>   	struct svm_range_list *svms = prange->svms;
>   	struct svm_range *pchild;
> @@ -1804,6 +1808,12 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
>   	} else {
>   		unsigned long s, l;
> +		uint32_t trigger;
> +
> +		if (event == MMU_NOTIFY_MIGRATE)
> +			trigger = KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE;
> +		else
> +			trigger = KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY;
>   
>   		pr_debug("invalidate unmap svms 0x%p [0x%lx 0x%lx] from GPUs\n",
>   			 prange->svms, start, last);
> @@ -1812,13 +1822,13 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   			s = max(start, pchild->start);
>   			l = min(last, pchild->last);
>   			if (l >= s)
> -				svm_range_unmap_from_gpus(pchild, s, l);
> +				svm_range_unmap_from_gpus(pchild, s, l, trigger);
>   			mutex_unlock(&pchild->lock);
>   		}
>   		s = max(start, prange->start);
>   		l = min(last, prange->last);
>   		if (l >= s)
> -			svm_range_unmap_from_gpus(prange, s, l);
> +			svm_range_unmap_from_gpus(prange, s, l, trigger);
>   	}
>   
>   	return r;
> @@ -2232,6 +2242,7 @@ static void
>   svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   			 unsigned long start, unsigned long last)
>   {
> +	uint32_t trigger = KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU;
>   	struct svm_range_list *svms;
>   	struct svm_range *pchild;
>   	struct kfd_process *p;
> @@ -2259,14 +2270,14 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   		s = max(start, pchild->start);
>   		l = min(last, pchild->last);
>   		if (l >= s)
> -			svm_range_unmap_from_gpus(pchild, s, l);
> +			svm_range_unmap_from_gpus(pchild, s, l, trigger);
>   		svm_range_unmap_split(mm, prange, pchild, start, last);
>   		mutex_unlock(&pchild->lock);
>   	}
>   	s = max(start, prange->start);
>   	l = min(last, prange->last);
>   	if (l >= s)
> -		svm_range_unmap_from_gpus(prange, s, l);
> +		svm_range_unmap_from_gpus(prange, s, l, trigger);
>   	svm_range_unmap_split(mm, prange, prange, start, last);
>   
>   	if (unmap_parent)
> @@ -2333,7 +2344,7 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>   		svm_range_unmap_from_cpu(mni->mm, prange, start, last);
>   		break;
>   	default:
> -		svm_range_evict(prange, mni->mm, start, last);
> +		svm_range_evict(prange, mni->mm, start, last, range->event);
>   		break;
>   	}
>   
