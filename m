Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76383C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 23:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C978310E2F1;
	Thu, 27 Jan 2022 23:37:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E18CC10E2F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 23:37:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF5Av4LGL8PPYsG+vw2t0PLJwMP3ZAyNZ/w8Aj+/Z9xBGgiA7MQXpESxXQH1VqxF2WrkH+GNUo48wkwwECaKV5GHBIkU/sdqP4Iq5tmAXLqPBV+EHq+p7zzKw3PkFG0nid+wdW/rYbttq/o0WIdG7EvuGi6H+lqKPfHF6Ev2h4Wf7aSukZ0hDtasC0aTOjs00L55OLCN7ohRsSWCXD+9rFVDuon5UK8DrQ89IIykW5Yzg7AQzx/iCKp1Y2ssHgyuhB30iLYB2P/0nu0Hh55wGFjXzCsqGtWIOwRMF9YIS2o5DPzEUKYvsFBNBbLx+OWx5S94WHq0r1a+9L2MwUi7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+G88XTR5rRP8lInQqWkAj710dpmvbet2IXJdieyB+hM=;
 b=V+pmvs4D27yTdfuWnhaAb0PK8Ir9FyzBnrqeerJn1JSP4E/N6lnVq0IfaqlUZI+DNxBXboPOW6G33TSEiqXKerOEfVRddACNwUbgSmOePOkRU3SbekQhV3e5QDga/IW5QpVc26lWUTdYESINY+nXPggxtpVSUcG0IhxeM5j1HT1dhTOo5BZMDUUBJ9O80aXVZdsMlFzzQNTJU7Xlx/70XqUIU3iNMEfZq6hMVDUgA/HLgCA5+ueBwMflBh8KbXtHeWznXtxhhmUoFjfJ02N3C3V+NsP2bMMc6SzwuXvFG8DMmCFyEAyY2afg1idn3OY2OD3LV4H7GApL5ozNH1/mxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G88XTR5rRP8lInQqWkAj710dpmvbet2IXJdieyB+hM=;
 b=mbdyR/qVQF8XneVqioNli1LGS/fP4EtQG1Cmzz1D8iZ7eGZ3ryv97EkI8oBh+/fDlHioAHsBZn089tdoTjLl27B0Fc5+sjwNfrZDSFKlS3YLjwzmVbThkDPeA4j5DxePI9nWX5K1wQ03W/kD26lGwkcnVz7EnySKI+tHGAXVjd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB3643.namprd12.prod.outlook.com (2603:10b6:5:3d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Thu, 27 Jan
 2022 23:37:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4930.018; Thu, 27 Jan 2022
 23:37:39 +0000
Message-ID: <855190d1-a40f-7127-ab3b-dc848ac911f8@amd.com>
Date: Thu, 27 Jan 2022 18:37:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 6/8] drm/amdkfd: Add user queue eviction restore SMI
 event
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220120231322.10321-1-Philip.Yang@amd.com>
 <20220120231322.10321-7-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220120231322.10321-7-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::31) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d377436-b329-4b18-8419-08d9e1ee017f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3643:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3643684A51FA9EF7382C8C6092219@DM6PR12MB3643.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VG7IT2RDiq0IPbjtaQ0opzERhj6otdPAdwkIh+OV7W7+VYXacxt0otwOvNbiTsx8avaz5RXF4jHUruxcdK1wuIwbIb64qgsrT4AD4y3qbBU5dWBgy9bMyLqjCJDqNeQzh1DxDOFYBXKwDg6w7+/Y4eBsdvpZ+U3LDnWYO2rxuW53uUqqTJJbo7XGed3XoxJmgHZ3/Ry0kN5fNhM9iJDWPslDUCZbNVXUYmSUDcYdvZYJNTQfRozQhHGtTKneLEda2JsoM0nFYonuE6soejRmJkJldJ1Ad12fn1K1GnpuLGhWHbMnyH/7gCCSIbJ+akPE2rsnPE15n7zeKLtVV/K3SZcDUtRsg/PyL54eeA6elsvpv7lgCbNqjUuPnPh5PFPERO4Ykn1IHLamhuNUEm75AmTIeAXU24REcsOvwcBZTA1xglT5i2hzIII5l72ru/amlGSE/S1DrtDMCJmAn39a3o2DIv3LRyIHXWKsxqI2DQQuisRuhlAeazJx27Am1W9YcVeHLTWc8EauzQhCa6IebydSdclAnEdMIHRpZLRdUP/M3Cocv1HoMjCcUNmg4EYtBstUizVjGNYQ5+rPY0o6eJwysayDISLslVIVLliPjBA4iLTrtvQz5nujw+eEL3GKWqgUCg3hBc96CcfRGg9dL/h9nIb3LS7pNSe9urPP3aeQWOaM9BNAWX6BDUGEqMIVWiaAA5Zohukc3PxinqyExXXcDPbZ+46HHxm3D7eXad9+XDA4DwjBvEAH4Nswkj5E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(30864003)(26005)(86362001)(316002)(186003)(6486002)(2906002)(2616005)(31696002)(8676002)(6506007)(5660300002)(8936002)(66946007)(38100700002)(31686004)(66556008)(66476007)(44832011)(6512007)(83380400001)(36756003)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1QxMWpkdTNOTHVhekx0R25neWhHSVQ0RmVuOHk0WW1pUkk5UUJFckhZN0Zj?=
 =?utf-8?B?b052VC85cExtMDRacDltMjRYQTg4aWVwaWlYSlpwc0V2WVlwRitySzgyZm9P?=
 =?utf-8?B?ME5UMlIvdU1tVFplTVppYjNyc2RJQVQ1cm5rc0R5bkVYeElTS3dwWU9oc1Jt?=
 =?utf-8?B?SVFUNWZVT1A3ZlRoK0lHd2R2Z0FVNDNsbVNQMjlWV2Z5ZWdXdWZ3WHNjWXcz?=
 =?utf-8?B?L29CZjRoODdpcnVEVTdwOEJaY1Y0VC81V3dDb3VMSGpldkxYMHg2QTdrbzBN?=
 =?utf-8?B?My9vNVA4QkVjZElqYmcrNzlNbHBvU2VNa1I5a3dkRGsyQ1crUlU5a1hKaEJY?=
 =?utf-8?B?aHFYckNlbllKZkZubGFVcUJVcVNFWG9rRmF3TjF4ZEEyZTV2RUZaVTRKa0ZW?=
 =?utf-8?B?aUIvT3BPTzVjYzEzd1hDeFZUUkI5ei9SaDZJQU9sU2UvMXpkUHFQRlFLZWF4?=
 =?utf-8?B?R1QvcS9uWHJQMjZWSzdjeWoyWVNlenBiWld5NTV2VDR5YUhQeG8yM21Bb1ky?=
 =?utf-8?B?Y1UxbW16NkxDTDNkNUI4czF5MVpOeWlUM1Y5MTRlQ2E1T0EwU2ZZcm52SG9L?=
 =?utf-8?B?YlJ5aldXT0xSMk5RL1dnMU5RR041REFVRWIwTFhkanNDTm9KclRFN0pNU2lF?=
 =?utf-8?B?cERIRkJqTm1TOTMyTlFQWHJaTWl2aURuRUZFc3U3NTZNcjlZQ2Z6WjN5R0tl?=
 =?utf-8?B?ZVJmNE9vbzhRUmt1dlEyWWwvU0dMY1RkcnNGN3NPMW9wM3ZwREhFaHVHZDQz?=
 =?utf-8?B?aitTS2l3UXlFMWNJOUZDcHl0TUlyMEJhOUZJbkFYL3N1cStOb0JsZlZhV0dN?=
 =?utf-8?B?ZktQdFMxbEdTNFZJaW9DMFZ1UFdSVHZpMDZ0RExHRXA0QjRYZEc3c1JvTFBp?=
 =?utf-8?B?ZnZCTzRobUFyUFdxUXE3V1oxZ3JGTzVFSi9ESVh6ZUZVenUzZlJTenRXL2Vl?=
 =?utf-8?B?L1BLOUgxa2dTSFRPNzNIeTBCbm8vNGRoOEJFb3JRdTNITllXVnExVXAwcHdl?=
 =?utf-8?B?ODVmN2JzRDBQVng4S1hRWXVJd1oyL0NoS2htSHAxdFR5Mk9NelFaM3FiNmY2?=
 =?utf-8?B?V1p2NWhoTTNKaVZuUHRaQ2xvY2FNdzZIbHYvUGJ1R2M2c2dDS3J4cUkrMHZH?=
 =?utf-8?B?VUVoQjM4SURVYUtJdDJEUENvUkliTkFTdjd2OHZRbHdXY21pZThZbE9KdTI0?=
 =?utf-8?B?Mm5EMlplWXA0VWpNeGNBRmtEM055VVVrWC9Qa0NENzFaMTdLMkJ1dUY5cHJL?=
 =?utf-8?B?a09CRmVIY2ROcHlsWGpvNU9tUFR1VnhmbjlyejVhZ3J3VkYrZTdwSTdJaFRm?=
 =?utf-8?B?bDlYbTV1cmtQUi80bVhJTm1OWEJFOC9FbkQ2RGpmaXhzd09qcjg5RTlRWm1G?=
 =?utf-8?B?Qkp0MUxGN2ZTcnFLblY1RmJWRngybTRYSmN3NC9uK3AwY040MWlRcjNkVWlj?=
 =?utf-8?B?S2JTdFhrMXRtTFFMb0lLWU85bmdaem15ajRWVVoxZXFXc1Y3d3pITHNEbkkx?=
 =?utf-8?B?MWJRd2U1TmpkU2lWWmF3dndycmNhNUE1cHJqSTJrYVBORUNqTXBISEFXcm9o?=
 =?utf-8?B?OUZLQXpEYmNUbTN4NHJUUTNuL0liNnJoaVRUUGxWVDdFSTZyT0ZZbGRWWWRY?=
 =?utf-8?B?bTR2aGlDRVNaNzJ5UTZ0YktPUTVtUlQ4VE1FTXVvdVcwNHNVbVRQc1NYN3Z1?=
 =?utf-8?B?TGhuQ1JYaEJKUStRLy9RY0ZkMjVLWko4eWIyelZ6NkRUMTdvKzZLbmR5RGxM?=
 =?utf-8?B?QVU0aXhad2w0MUJEbUpyV0hGV3h1dlJ6NkdveVJOOVpsY2UzbW9MVVlVd05T?=
 =?utf-8?B?UUVUT05wQzk5QlZkSERIQVV4STkwa2xuSEgwVE1UR2lLbGJuU3ZpdEtTOUMw?=
 =?utf-8?B?TDQwaFo2OVpNVjJ4TmJDTERLNUhzSXNKRG4vUTV5ZVlMMGxlM2ZZVCtlZVNl?=
 =?utf-8?B?MWFBZ1NVYTk2ekZwUHZ4L3FpL045T1JqcmFIeXJ2ZVZWVVZFMlRCdW9rREkv?=
 =?utf-8?B?SlVvMnQvaGJVY2Ywc0dvRXgwU1l4ZVJ6NlN3eC9Dc0ZxVGFHZTY1MTFLcFY5?=
 =?utf-8?B?V1hhN0QwTStNTFdOUFEwbDN1bUhQK1E5WFVkbnJaVVcrVytrOFdZc2xhNE9z?=
 =?utf-8?B?K1pJRk1RTlRIcWdnTzNQQVJ1QVE2dE1jR256cGRQVFZZQ0psVzhwSTJIMWx6?=
 =?utf-8?Q?MMOKgtjxO4Dj4ewwNF6BV1M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d377436-b329-4b18-8419-08d9e1ee017f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 23:37:39.6026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBKdtvqjOv7IGjCBv3YqxOpcaeOAlFNqzzpiobeqfA/eHJ5/ra8C24bbKBFjNdiHLJRdg9p5MmQmVzYnq760RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3643
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


Am 2022-01-20 um 18:13 schrieb Philip Yang:
> Output user queue eviction and restore event. User queue eviction may be
> triggered by migration, MMU notifier, TTM eviction or device suspend.
>
> User queue restore may be rescheduled if eviction happens again while
> restore.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  7 +++-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 11 ++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 37 +++++++++++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 34 +++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  4 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 16 ++++++--
>   8 files changed, 101 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index ac841ae8f5cc..bd3301e2c682 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -309,6 +309,7 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>    */
>   void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
>   void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
> +void kfd_process_smi_event_restore_rescheduled(struct mm_struct *mm);
>   #else
>   static inline
>   void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
> @@ -325,9 +326,13 @@ static inline
>   void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>   {
>   }
> +
> +static inline void kfd_process_smi_event_restore_rescheduled(struct mm_struct *mm)
> +{
> +}
>   #endif
>   /* KGD2KFD callbacks */
> -int kgd2kfd_quiesce_mm(struct mm_struct *mm);
> +int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger);
>   int kgd2kfd_resume_mm(struct mm_struct *mm);
>   int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
>   						struct dma_fence *fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 5df387c4d7fb..c44e8dc0d869 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2066,7 +2066,7 @@ int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem,
>   	evicted_bos = atomic_inc_return(&process_info->evicted_bos);
>   	if (evicted_bos == 1) {
>   		/* First eviction, stop the queues */
> -		r = kgd2kfd_quiesce_mm(mm);
> +		r = kgd2kfd_quiesce_mm(mm, USERPTR_EVICTION);
>   		if (r)
>   			pr_err("Failed to quiesce KFD\n");
>   		schedule_delayed_work(&process_info->restore_userptr_work,
> @@ -2340,13 +2340,16 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>   
>   unlock_out:
>   	mutex_unlock(&process_info->lock);
> -	mmput(mm);
> -	put_task_struct(usertask);
>   
>   	/* If validation failed, reschedule another attempt */
> -	if (evicted_bos)
> +	if (evicted_bos) {
>   		schedule_delayed_work(&process_info->restore_userptr_work,
>   			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
> +
> +		kfd_process_smi_event_restore_rescheduled(mm);
> +	}
> +	mmput(mm);
> +	put_task_struct(usertask);
>   }
>   
>   /** amdgpu_amdkfd_gpuvm_restore_process_bos - Restore all BOs for the given
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 5a47f437b455..ffaa80447d9c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -783,7 +783,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
>   	spin_unlock_irqrestore(&kfd->interrupt_lock, flags);
>   }
>   
> -int kgd2kfd_quiesce_mm(struct mm_struct *mm)
> +int kgd2kfd_quiesce_mm(struct mm_struct *mm, uint32_t trigger)
>   {
>   	struct kfd_process *p;
>   	int r;
> @@ -797,7 +797,7 @@ int kgd2kfd_quiesce_mm(struct mm_struct *mm)
>   		return -ESRCH;
>   
>   	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
> -	r = kfd_process_evict_queues(p);
> +	r = kfd_process_evict_queues(p, trigger);
>   
>   	kfd_unref_process(p);
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index ea68f3b3a4e9..39519084df78 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -906,7 +906,7 @@ static inline struct kfd_process_device *kfd_process_device_from_gpuidx(
>   }
>   
>   void kfd_unref_process(struct kfd_process *p);
> -int kfd_process_evict_queues(struct kfd_process *p);
> +int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger);
>   int kfd_process_restore_queues(struct kfd_process *p);
>   void kfd_suspend_all_processes(void);
>   int kfd_resume_all_processes(void);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 74f162887d3b..e4ba4d537b3c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -43,6 +43,7 @@ struct mm_struct;
>   #include "kfd_dbgmgr.h"
>   #include "kfd_iommu.h"
>   #include "kfd_svm.h"
> +#include "kfd_smi_events.h"
>   
>   /*
>    * List of struct kfd_process (field kfd_process).
> @@ -1701,7 +1702,7 @@ struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm)
>    * Eviction is reference-counted per process-device. This means multiple
>    * evictions from different sources can be nested safely.
>    */
> -int kfd_process_evict_queues(struct kfd_process *p)
> +int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger)
>   {
>   	int r = 0;
>   	int i;
> @@ -1710,6 +1711,9 @@ int kfd_process_evict_queues(struct kfd_process *p)
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
> +		kfd_smi_event_queue_eviction(pdd->dev, p->lead_thread->pid,
> +					     trigger);
> +

If we're always evicting queues on all GPUs, we probably only need one 
event per process, not one event per GPU.


>   		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
>   							    &pdd->qpd);
>   		/* evict return -EIO if HWS is hang or asic is resetting, in this case
> @@ -1734,6 +1738,11 @@ int kfd_process_evict_queues(struct kfd_process *p)
>   
>   		if (n_evicted == 0)
>   			break;
> +
> +		kfd_smi_event_queue_eviction_restore(pdd->dev,
> +						     p->lead_thread->pid,
> +						     false);
> +
>   		if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
>   							      &pdd->qpd))
>   			pr_err("Failed to restore queues\n");
> @@ -1753,6 +1762,10 @@ int kfd_process_restore_queues(struct kfd_process *p)
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
> +		kfd_smi_event_queue_eviction_restore(pdd->dev,
> +						     p->lead_thread->pid,
> +						     false);
> +
>   		r = pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
>   							      &pdd->qpd);
>   		if (r) {
> @@ -1765,6 +1778,24 @@ int kfd_process_restore_queues(struct kfd_process *p)
>   	return ret;
>   }
>   
> +void kfd_process_smi_event_restore_rescheduled(struct mm_struct *mm)
> +{
> +	struct kfd_process *p;
> +	int i;
> +
> +	p = kfd_lookup_process_by_mm(mm);
> +	if (!p)
> +		return;
> +
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +
> +		kfd_smi_event_queue_eviction_restore(pdd->dev,
> +						     p->lead_thread->pid, true);

Same as above. One event per process should be enough.


> +	}
> +	kfd_unref_process(p);
> +}
> +
>   int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id)
>   {
>   	int i;
> @@ -1814,7 +1845,7 @@ static void evict_process_worker(struct work_struct *work)
>   	flush_delayed_work(&p->restore_work);
>   
>   	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
> -	ret = kfd_process_evict_queues(p);
> +	ret = kfd_process_evict_queues(p, TTM_EVICTION);
>   	if (!ret) {
>   		dma_fence_signal(p->ef);
>   		dma_fence_put(p->ef);
> @@ -1881,7 +1912,7 @@ void kfd_suspend_all_processes(void)
>   		cancel_delayed_work_sync(&p->eviction_work);
>   		cancel_delayed_work_sync(&p->restore_work);
>   
> -		if (kfd_process_evict_queues(p))
> +		if (kfd_process_evict_queues(p, SUSPEND_EVICTION))
>   			pr_err("Failed to suspend process 0x%x\n", p->pasid);
>   		dma_fence_signal(p->ef);
>   		dma_fence_put(p->ef);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 97393f4f3549..facc8d7627d8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -343,6 +343,40 @@ void kfd_smi_event_migration(struct kfd_dev *dev, uint16_t pasid,
>   	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_MIGRATION, fifo_in, len);
>   }
>   
> +void kfd_smi_event_queue_eviction(struct kfd_dev *dev, pid_t pid,
> +				  uint32_t trigger)
> +{
> +	char fifo_in[64];
> +	int len;
> +
> +	if (list_empty(&dev->smi_clients))
> +		return;
> +
> +	len = snprintf(fifo_in, sizeof(fifo_in), "%x %lld -%d @%x %d\n",
> +		       KFD_SMI_EVENT_QUEUE_EVICTION, ktime_get_boottime_ns(),
> +		       pid, dev->id, trigger);
> +
> +	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_QUEUE_EVICTION, fifo_in, len);
> +}
> +
> +void kfd_smi_event_queue_eviction_restore(struct kfd_dev *dev, pid_t pid,
> +					  bool rescheduled)
> +{
> +	char fifo_in[64];
> +	int len;
> +
> +	if (list_empty(&dev->smi_clients))
> +		return;
> +
> +	len = snprintf(fifo_in, sizeof(fifo_in), "%x %lld -%d @%x %c\n",
> +		       KFD_SMI_EVENT_QUEUE_EVICTION_RESTORE,
> +		       ktime_get_boottime_ns(), pid, dev->id,
> +		       rescheduled ? 'r' : ' ');
> +
> +	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_QUEUE_EVICTION_RESTORE,
> +			   fifo_in, len);
> +}
> +
>   int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
>   {
>   	struct kfd_smi_client *client;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index 5788728f2879..d85300b5af23 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -39,4 +39,8 @@ void kfd_smi_event_migration(struct kfd_dev *dev, uint16_t pasid,
>   			     uint32_t from, uint32_t to,
>   			     uint32_t prefetch_loc, uint32_t preferred_loc,
>   			     uint32_t trigger, uint64_t ts);
> +void kfd_smi_event_queue_eviction(struct kfd_dev *dev, pid_t pid,
> +				  uint32_t trigger);
> +void kfd_smi_event_queue_eviction_restore(struct kfd_dev *dev, pid_t pid,
> +					  bool rescheduled);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 7dbc724364e6..30aaa9764067 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1712,7 +1712,10 @@ static void svm_range_restore_work(struct work_struct *work)
>   		pr_debug("reschedule to restore svm range\n");
>   		schedule_delayed_work(&svms->restore_work,
>   			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
> +
> +		kfd_process_smi_event_restore_rescheduled(mm);
>   	}
> +	mmput(mm);

Where is the matching mmget for this? If this is a fix for an old 
reference-leak bug in the code, it deserves its own patch.

Regards,
   Felix


>   }
>   
>   /**
> @@ -1732,15 +1735,22 @@ static void svm_range_restore_work(struct work_struct *work)
>    */
>   static int
>   svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
> -		unsigned long start, unsigned long last)
> +		unsigned long start, unsigned long last,
> +		enum mmu_notifier_event event)
>   {
>   	struct svm_range_list *svms = prange->svms;
>   	struct svm_range *pchild;
>   	struct kfd_process *p;
> +	uint32_t trigger;
>   	int r = 0;
>   
>   	p = container_of(svms, struct kfd_process, svms);
>   
> +	if (event == MMU_NOTIFY_MIGRATE)
> +		trigger = SVM_RANGE_MIGRATION;
> +	else
> +		trigger = SVM_RANGE_EVICTION;
> +
>   	pr_debug("invalidate svms 0x%p prange [0x%lx 0x%lx] [0x%lx 0x%lx]\n",
>   		 svms, prange->start, prange->last, start, last);
>   
> @@ -1768,7 +1778,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   			 prange->svms, prange->start, prange->last);
>   
>   		/* First eviction, stop the queues */
> -		r = kgd2kfd_quiesce_mm(mm);
> +		r = kgd2kfd_quiesce_mm(mm, trigger);
>   		if (r)
>   			pr_debug("failed to quiesce KFD\n");
>   
> @@ -2303,7 +2313,7 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>   		svm_range_unmap_from_cpu(mni->mm, prange, start, last);
>   		break;
>   	default:
> -		svm_range_evict(prange, mni->mm, start, last);
> +		svm_range_evict(prange, mni->mm, start, last, range->event);
>   		break;
>   	}
>   
