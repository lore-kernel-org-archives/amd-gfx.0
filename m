Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C23C55165
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 12:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DBFE10E0AD;
	Thu, 30 Jul 2026 12:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fy/79x7O";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010054.outbound.protection.outlook.com
 [40.93.198.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9AE10E0AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 12:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRe6FQ0pgJy0ErIJ/OIfWye2JICD6cmDL4elESoSPo1yFCcVctK8Y5DwLjz72PeaaWTF/Wtw6LwqtJIDbjjsOmcjzG1uYxo9EktHXXtJv6CxNihFfpp6CZ2JQz70EQ6i/vPbj+m7xt98Z138nYS+MzBvvdvvdQpUQButIpPpEL2vO0bL0r12NSL1oxb9hXXZfhEkubWRyYYyWHEHpbX3CDgKqHbnXd7tAw4nQUfbHzzxcWT6OgIhsXnjV/QQPqwrbz17LCmodmNPzMzxVEpy/3TW5AE/GLI4BbLr7P0uufykZSO7OCzB6RNQ5HQQUOV73WsyP8CE/ml3mV0oOJDr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQjC+2Cp38BZ72rPrWxL98NVphwwXw1mk/J1TSFPPYs=;
 b=PMQtnEAYgVUL1OQgsVl/EMmIZF1/Mc1axdeg1svCRzzKHKrk1BO+ZbDdRq760/fE0Dc+PUD+93nm92XIZA5B46IgIwUcUFwe9XBU0zZiM0iOa9SGsM7jNAgD1cCduh5n02LlK6sYHJIcZB04Fmf4oJkbQKOyfS7k/1yDD8QAnML6KNArROfEULyLS9V1ZhcwKDdp/4NASkOApRcVTjnRu2s8lUkXNLzgGqYErQ+7TIlmja8F09Ib8bno1/1JbkekLglPS/SfrKwNeenyLzSAbJt8M5A0bumkckrsDv2Yv82QxitiYfmzA+t/jca96zgdu/ENVHXiIPWDY5j3KN3Iug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQjC+2Cp38BZ72rPrWxL98NVphwwXw1mk/J1TSFPPYs=;
 b=fy/79x7O+TO6PRnS2WFiTTzu+rnd7lcoOQmza3p2a4/0r7WV6TmGOzsrlJ7UrOlDCG4NNvwavsVNrJjPZYrO8JGsWSvgN/Oh33PIODVaFmBPnkqD+u8SoXVb83aj6jFfDdDJAS/izNbZ1/ABsgeKJNl9xM+1F46Ur26/jm8V/zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Thu, 30 Jul
 2026 12:20:31 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%3]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 12:20:31 +0000
Message-ID: <55d668ad-e603-4899-b02c-1681223fe653@amd.com>
Date: Thu, 30 Jul 2026 17:50:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdgpu: add filelist_mutex to lockdep lock
 ordering annotations
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
References: <20260723221910.85822-1-vitaly.prosyak@amd.com>
 <20260723221910.85822-2-vitaly.prosyak@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20260723221910.85822-2-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0087.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::16) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|SN7PR12MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: fd634aa8-3c2f-4bda-7fbc-08deee34f2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: av/QbLDrNdV7DxXE3uSq8viNhmuffBeiykbKU+qSeqRqTJ15Ki34sQDX5ve4CXFpPzkqvFS7UogpZb2EoDLmfeRAH3Iz9dAOUpNY3vMBDIM34XcTf444FdKs1pWSi+P3WuQjsbYjdJ9b4EJEL0Dq6i0ugTzIqVjTrvj0WI61zxKN42+rr5eXaxtX6P5NT31pziWH4p2vTcq81QNw98RtUSkDJrRnOQtNuVoaCIgw/BtRxfaOa2tor/ONBflREpA8TI5lJXXIGE80Hyy0rtlAWiDDygJd95/gZ1uUhHLAj/6suCL2Kko2/WmprWW+UejQgerp3eTvxjF+UAmts5758Gpbc1LZCkl9LCy2MGG16n1YZh6XTupg4wcv2t9H9PS426tse5sCFLsl0nV2qvjFqselrFyliNcSw3BYVIIWLw3z/4IXBc4ArpxnPMFpBRS0P7clLzLHr5N/J+o5bqzKbMEg/8jv+K9sA/PrpEGab3h13c3uCJYbVh++pKbpBqS68esUxKs5JKBPomN2zQLdhF8pkcFgy5xGVg9ZqMlMwIljfGzF2qEcL1/GKqSw7fP6vVKKvvo28J7wPzXJByHjL9U8OU8pBeyioxkWIdir3M793C9SZUb/bj1ygCnbspPWHPW+woq/9/gSn5uTpx/SWA7vkI6HalKs9XLC2N69g3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnAraC9yMGdNbThNT2FpS1hkaHRjVmlEVGEzdjVrV00yMWZvV2VPUkg4dlhX?=
 =?utf-8?B?NHFwcXRtUnZZU0kxTE5jWURHSWdJWjJINSt4R0crZmVUdXFvWmlOVVZGU2h3?=
 =?utf-8?B?ckoyd2pqVFJRRzBhaXVqZFE3U2NuWXEzNkxTZDdOalBCaTgzUVBSU2dmTUlm?=
 =?utf-8?B?a09MWEg5OG9kOUhHVFl0WE1nays3R200aG9sSzc1cWJYMlJiVDhQSHU1WVhC?=
 =?utf-8?B?TGQ5d1pYL1laSE9iNXA2TUVtYTRuZll1dHRSZ3paRFZKSHFXZTN3UWF1L2RH?=
 =?utf-8?B?ZFVJN3Avb2VkNTM4eGNQNmNQSytpTVVVWjd5WmFmRzVNZEs1eU1ONjRqSjJS?=
 =?utf-8?B?VGJzZVl2NXNKZjdYT2c4RWlMKzZkMSt3Nlc3UUVzUnF2QVMyOG9MdVdReldP?=
 =?utf-8?B?dmZEMDRrSERqM2RiRXJrNmVuWG9LMkNrZ2lwYTE3blBVTWZZSlpOcDZ3ZnI4?=
 =?utf-8?B?L3hvcS9kRVhaSVZ4K04xWFJjWCtiZWwvUi9ld08wbktlTFYzT29YYy9UdzE2?=
 =?utf-8?B?TGgxeVlDcldxcW5tYWVyblY0dk95MVBqRGZHTC9NeG1YSjBiVldVWDlCUy9J?=
 =?utf-8?B?bzh5TVdLOTQvTkYzQk5tZFZGVTNNN29ROUp4S2ptK016VXRSdzVVNnhlZTQv?=
 =?utf-8?B?MGZiS2Z1eEpFbHdGbjNJbHN1T09xNHpuLzF3TWxNWlFxUytWSGozV1pWUVEx?=
 =?utf-8?B?NTBQV3BGbXBoS1V4aHZVeUM5VCtEaU83UVZLdEZtKzFqd2RhQXducGc0QVd4?=
 =?utf-8?B?YWVzaW5HU1F0U281RElzOUR5bjRmNnk2aTAzekVBR3lBQkVLVzhjbXpSaTBi?=
 =?utf-8?B?WnI0aDhTYWVPdmdxS0d3cnBJa0ZGVDNFZG5mNVJqQjVrbEdjaUdDS0NLNWMv?=
 =?utf-8?B?V0QxUWEvTzQ4WFlGVk84WWlYUWc5SzYrbi84dEw4N2FUSTNKZzI5WDFtb29Z?=
 =?utf-8?B?eTRFSnllTDZtSG03NGo0clQwNm9NYWtmYURucHYvazFJOWVMdFd1RGNtOFpI?=
 =?utf-8?B?cHRNZzQ5VUdTRjY5N2VneUd4RkNCYStKS21lM1B4T004T1N0SnBPQlVKa1Z4?=
 =?utf-8?B?bWZqK1ZPQURGbGZVeS80S2tMT1Bxck1iaTMyRzFwK0l3dmxlR3pNN3lZUjBX?=
 =?utf-8?B?NGVYN0JNemg2ZE95QVlvRUlDUjRyVjBNajRTUEozN0FPNWpaRUd4SUlEM2JD?=
 =?utf-8?B?MXVaYmJDM3B5MldiL1JzamFVeGlGRmFVMzlwMnlEVVdmUlMzaDZ5NFYrakRk?=
 =?utf-8?B?MnNaOFBqZUoxLzJvalN0UlFXWFNYZ0hlV3RESXRxRWdocGt5VHg3QU5YTnZ3?=
 =?utf-8?B?bUw1VWVyQWxtRjRTRVMyLzBBOVRIYTNRRXprNi9MVVV0bnljYVpXOWtaczNK?=
 =?utf-8?B?YnBDZVo3RmJFbjF5bDBpa2FIRVl1YjhXZ1IwSVo1Wlh4akR6eWNBOURldnVE?=
 =?utf-8?B?QXZGSzNKd1kvMnZnSDdkdTdRcmU1bC9QcnpJcWxVc1I5SU9LK0RoNVdHODJ0?=
 =?utf-8?B?V002TWtWMkhWczdoczRPblQ2enRZV2diOTRleERDc29NVHFDUXFweldML1h3?=
 =?utf-8?B?WTN6YUdodXlPSHdOZUM5VWpKVllzVXFlN2VaZ2U2WlJSL0F6aHRSVWVFM2V0?=
 =?utf-8?B?QXZvbExKeDZKZTd1cnlsa0szSnRMdk9LdWdEZzJBY3MzSm42ZGZLTmNMRnp1?=
 =?utf-8?B?eUN3SzA4RkQvR3NQOGd1U1E1NUJCUElaamtsVFJsMENoclVBd2JzTkk3c1Zy?=
 =?utf-8?B?QWZubTFWN3BtcG9WcVRTS2grUHRDWFJQTVFnTWVCR05KVC9xcHc3TWl6dUti?=
 =?utf-8?B?dXJiYzg4Mll0QlZrRVNwMTU1Zm8yWi9CVGF5b0xWcWN3VVlIT0hyakZPL0VU?=
 =?utf-8?B?dWJPVHYxRTNOd2dyVS9WV3V0amU0Uk0zUjNwYzErNWZUQTNPN0RVOEZOVnZJ?=
 =?utf-8?B?MG1VSUJqMFpreW1UYTMwaTh4QkhYVWN2VTlzRlRmc0svTy9KbjhVNFNiS0xD?=
 =?utf-8?B?a09Lak1oL1IxamxJekhtakU2dWIzaUQvZjhuMUUvUUJDWEZGRXlDZVFETm5a?=
 =?utf-8?B?UWVrVWMxRmxWWU1MazA4bGl2OEFmTGJ3bmpEMkFOM09UNHllNUhEUUhJOTlH?=
 =?utf-8?B?MmFhU3JsQ2hvWldlUkEwbWZlbmNEaFBreGhsV0J5OFlqVkpxaENSQXFkWDlU?=
 =?utf-8?B?dk1pT1RzLzdlSXN1MW1nSVZPSXVPNCs5bXYyWEROU2NaSzZDM05wLzl5SUg3?=
 =?utf-8?B?bWFEZU0rYTIxT05XUlJ2TGppTzdSb3hIb2pBVmRmYjgwUlV3eEZWNkNJMi82?=
 =?utf-8?B?MitRTE8rU3dBL2VWUVhWcVMra3NGV3EwakVxYmI1SUdyZzdmb1g5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd634aa8-3c2f-4bda-7fbc-08deee34f2c7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 12:20:31.5714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23yKKMhGvnRzXbYrOc64EjDWmWGB0iAvjNSoAGFQ/D+umUATtqYhM87ReJ5yLqtSjUkYrpVPHiTuDTs04yg84Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434
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

Hi Vitaly,

On 7/24/2026 3:48 AM, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> Add ddev->filelist_mutex as level 7 in the lockdep hierarchy, between
> reset_lock (level 6) and srbm_mutex (now level 8). This teaches lockdep
> the correct ordering for filelist_mutex relative to other amdgpu locks.
>
> The ordering evidence comes from the GPU reset path: gpu_recover() holds
> reset_domain->sem (write) and calls amdgpu_device_eventfd_signal_gpu_reset()
> which acquires filelist_mutex to iterate the DRM file list and signal
> eventfds. This places filelist_mutex inner to reset_domain->sem.
>
> Existing filelist_mutex users (amdgpu_gem_force_release, debugfs vm_info)
> do not hold any reset locks, so this ordering is consistent with all
> current call paths.
>
> Updated hierarchy (10 lock levels):
>   1. userq_sch_mutex     - Global userq scheduler
>   2. userq_mutex         - Per-context userq
>   3. notifier_lock       - MMU notifier
>   4. vram_lock           - VRAM allocator
>   5. reset_domain->sem   - GPU reset synchronization
>   6. reset_lock          - Reset control
The reset_domain->sem -> filelist_mutex ordering makes sense. But 
placing it at level 7 also implies reset_lock -> filelist_mutex — is 
there a real path doing that?
Otherwise looks good to me,
Acked-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Regards,
Arun.
>   7. filelist_mutex      - DRM file list iteration (NEW)
>   8. srbm_mutex          - SRBM register access
>   9. grbm_idx_mutex      - GRBM index access
> 10. mmio_idx_lock       - MMIO index (spinlock, innermost)
>
> Requested-by: Christian König <christian.koenig@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Jesse Zhang <jesse.zhang@amd.com>
> Cc: Arunpravin PaneerSelvam <Arunpravin.PaneerSelvam@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 29 ++++++++++++++++-----
>   1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> index 61450af539a6..b251350b1fb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> @@ -18,6 +18,7 @@
>   
>   struct amdgpu_lockdep_dummy_locks {
>   	struct mutex reset_lock;
> +	struct mutex filelist_mutex;
>   	struct mutex userq_sch_mutex;
>   	struct mutex userq_mutex;
>   	struct mutex notifier_lock;
> @@ -34,6 +35,7 @@ static struct lock_class_key amdgpu_notifier_lock_key;
>   static struct lock_class_key amdgpu_vram_lock_key;
>   static struct lock_class_key amdgpu_reset_sem_key;
>   static struct lock_class_key amdgpu_reset_lock_key;
> +static struct lock_class_key amdgpu_filelist_mutex_key;
>   static struct lock_class_key amdgpu_srbm_lock_key;
>   static struct lock_class_key amdgpu_grbm_lock_key;
>   static struct lock_class_key amdgpu_mmio_lock_key;
> @@ -57,6 +59,9 @@ void amdgpu_lockdep_set_class(struct amdgpu_device *adev)
>   	if (adev->reset_domain)
>   		lockdep_set_class(&adev->reset_domain->sem,
>   				  &amdgpu_reset_sem_key);
> +
> +	lockdep_set_class(&adev_to_drm(adev)->filelist_mutex,
> +			  &amdgpu_filelist_mutex_key);
>   }
>   
>   /**
> @@ -74,9 +79,10 @@ void amdgpu_lockdep_set_class(struct amdgpu_device *adev)
>    * 4. vram_lock           - VRAM allocator lock
>    * 5. reset_domain->sem   - GPU reset synchronization
>    * 6. reset_lock          - Reset control lock
> - * 7. srbm_mutex          - SRBM register access
> - * 8. grbm_idx_mutex      - GRBM index access
> - * 9. mmio_idx_lock       - MMIO index access (spinlock)
> + * 7. filelist_mutex      - DRM file list iteration (ddev->filelist_mutex)
> + * 8. srbm_mutex          - SRBM register access
> + * 9. grbm_idx_mutex      - GRBM index access
> + * 10. mmio_idx_lock      - MMIO index access (spinlock)
>    *
>    * Evidence:
>    * - userq_sch_mutex -> userq_mutex: amdgpu_gfx_kfd_sch_ctrl() calls
> @@ -88,6 +94,9 @@ void amdgpu_lockdep_set_class(struct amdgpu_device *adev)
>    *   must be outer to reset_domain->sem
>    * - vram_lock -> reset_domain->sem: VRAM management paths may need to
>    *   wait for ongoing reset to complete
> + * - reset_domain->sem -> filelist_mutex: GPU reset path
> + *   (amdgpu_device_gpu_recover) holds reset_domain->sem and calls
> + *   amdgpu_device_eventfd_signal_gpu_reset() which takes filelist_mutex
>    *
>    * Note: mmap_lock ordering relative to GPU locks is already taught
>    * by dma-resv (drivers/dma-buf/dma-resv.c).
> @@ -117,6 +126,7 @@ int amdgpu_lockdep_init(void)
>   	mutex_init(&locks->notifier_lock);
>   	mutex_init(&locks->vram_lock);
>   	mutex_init(&locks->reset_lock);
> +	mutex_init(&locks->filelist_mutex);
>   	mutex_init(&locks->srbm_mutex);
>   	mutex_init(&locks->grbm_idx_mutex);
>   	spin_lock_init(&locks->mmio_idx_lock);
> @@ -132,6 +142,7 @@ int amdgpu_lockdep_init(void)
>   	lockdep_set_class(&locks->vram_lock, &amdgpu_vram_lock_key);
>   	lockdep_set_class(&reset_domain->sem, &amdgpu_reset_sem_key);
>   	lockdep_set_class(&locks->reset_lock, &amdgpu_reset_lock_key);
> +	lockdep_set_class(&locks->filelist_mutex, &amdgpu_filelist_mutex_key);
>   	lockdep_set_class(&locks->srbm_mutex, &amdgpu_srbm_lock_key);
>   	lockdep_set_class(&locks->grbm_idx_mutex, &amdgpu_grbm_lock_key);
>   	lockdep_set_class(&locks->mmio_idx_lock, &amdgpu_mmio_lock_key);
> @@ -154,18 +165,21 @@ int amdgpu_lockdep_init(void)
>   
>   	/* Level 6: Reset control lock */
>   	mutex_lock(&locks->reset_lock);
> +
> +	/* Level 7: DRM file list mutex */
> +	mutex_lock(&locks->filelist_mutex);
>   	/*
>   	 * Mark potential memory reclaim boundary.
>   	 * GPU operations might trigger memory allocation/reclaim.
>   	 */
>   	fs_reclaim_acquire(GFP_KERNEL);
>   
> -	/* Level 7: SRBM register access */
> +	/* Level 8: SRBM register access */
>   	mutex_lock(&locks->srbm_mutex);
> -	/* Level 8: GRBM index access */
> +	/* Level 9: GRBM index access */
>   	mutex_lock(&locks->grbm_idx_mutex);
>   
> -	/* Level 9: MMIO index access (innermost lock, spinlock) */
> +	/* Level 10: MMIO index access (innermost lock, spinlock) */
>   	spin_lock_irqsave(&locks->mmio_idx_lock, flags);
>   	/*
>   	 * All locks acquired in order.
> @@ -178,6 +192,7 @@ int amdgpu_lockdep_init(void)
>   	mutex_unlock(&locks->srbm_mutex);
>   	fs_reclaim_release(GFP_KERNEL);
>   
> +	mutex_unlock(&locks->filelist_mutex);
>   	mutex_unlock(&locks->reset_lock);
>   	up_read(&reset_domain->sem);
>   
> @@ -190,7 +205,7 @@ int amdgpu_lockdep_init(void)
>   	amdgpu_reset_put_reset_domain(reset_domain);
>   
>   	kfree(locks);
> -	pr_info("AMDGPU: Lockdep annotations initialized (9 lock levels)\n");
> +	pr_info("AMDGPU: Lockdep annotations initialized (10 lock levels)\n");
>   
>   	return 0;
>   }

