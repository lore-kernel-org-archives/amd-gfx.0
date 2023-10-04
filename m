Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37514E936E6
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1DBA10E3C7;
	Wed,  4 Oct 2023 21:23:24 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF2F10E3B9
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0hSz+dLw8FKA12eciJerADACzYDDsiasDEhv5RPl5AOkrKdhcDkRHdTBGrTYroSE31JLqt9swiCVj/yXJw19l/Pu8WOFVwfEiAI4UVsBgK5b/iOYoMb2WfkYYg2m24Kpfj5f/RQpdsuOtFt9EPYPoyRefHPjUIhwSSC+4TnrY9raNb2bFD7It+GVLXVvHMZLpZCdGh7kRLeWIHZT5GQE35xHwikLx+V3gHku7hVfhV40F01obuPOweOCkaTRHEaKOc/wEmqgZ1cSCjzqpcqAcC7ggobnPhO7QTZKqiK00KynDPTvrLDWcFp0ATxzF1dindR+AKGFPOcyJzUrk2khw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DxIuRljHTBa3vS8nBCxI1RF/mSD2M9vlO029WsG5/U=;
 b=JSuL6m64iC4HkHS7O2ywOiTEAtWHEkRQCRR0y+hh9heEmNbsDhCa7Rl4Ms8H/6dkH8x8rkHhJdYhK9QfeW37ovvD1ybhyeGexaJCnSR02a9qSb2dUb0KMUTYHg4Yt+1WJtyfcg52QvmSip1SFW36HFy/7PMAuxxigyUv89aC7Ywbn8crdMsNzLIG4T+C6jZu88t9MiRyj20r+ghaKvpro4YKSCskgunv/S6r0WYMCv0qnL+pLCKuPDip107tfb9vU3nDiTV9hN8gb6BOlISEqixMFf6c2MKGxXFBXeY+DJzPC6BWXzMlU3Pu2h1Ra5//r9EZWLwxwyvU302JPBFwLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DxIuRljHTBa3vS8nBCxI1RF/mSD2M9vlO029WsG5/U=;
 b=gY03MfexDsJfJbvdet9YTp4BkaseRJAuZHHI4aPxmTHWW4skQiat5JYWVLg2LKmfReBf2Ri8XGo7QkKKDGpMLK/WuF/MWD+sfiZbkC1mZiPhIqhySy2lcpncGdPJlv9PzToTRqxH+aI0veKKVqKdsGF9MlOtPsYxDLw4ZBbVBLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Wed, 4 Oct
 2023 21:23:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 21:23:17 +0000
Message-ID: <753b6f60-e670-4e6f-99d9-3ba6dcf3f26e@amd.com>
Date: Wed, 4 Oct 2023 17:23:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-2-shashank.sharma@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230908160446.2188-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0170.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 03446978-4a53-45c2-bb4e-08dbc5202034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3RU+btP0oI+gtlEHH4db9vZ59vcKgfk8qXGmXDa3RJoVm8Na8bZQAYRnuL1SdHFEA7JoSjb+qUrugTQ1my3msLElazkXisSxjNKiRTIYoY8bTuu9IlpxDDZtr7DkoQc58iw1xEuhjzuG50udXGtm84+gJp24I02EpRNbtaQvUEigaIFgloGQ3Dj3cOXsvqIIOMrvTk24rLo9oPVfU5Das8I54ZXvv8f5QmWLmPeIAEwhsUrdYg5DWanhyG4KTAvafG+0qx98VnC0gWBvfmk4nGnUS23sGPU8umos+Xh/xl+i8LmNwQXPWV5QEQEnYD4bL+qot9r9AM1weRyNGbwjVBpiEHmmabucv2H8o/7TUI/rYYa4EP12fCtw16AwyRwetii24A9kBiO/dwaW4mvhg0wkuGE4Ebm4SZTOuq58PFF+aG0ldE8doAARo/QW8fQuVK5WNB5TIouf8mEQtArGM6K8Ixhm07tq0xu9JIdZC8QjRfbBOcxqUGHjbQdTn7rXM8MeFXqPdPbNJ3Ipx/jSWLat2DchQrZSJoYRu3e+tEgk3DliKzHABe9iV4Ruds22LzSz/XUHadRr6OZljh3mk761UY0kKSlS06P13s6d9bjYBUTuEf64C+sGR4iZ9JXi3dc+a1p+Slaquu87gtzSSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6666004)(53546011)(2616005)(6486002)(6506007)(36916002)(8936002)(4326008)(66556008)(316002)(2906002)(36756003)(66476007)(66574015)(66946007)(5660300002)(31696002)(54906003)(44832011)(26005)(8676002)(41300700001)(6512007)(83380400001)(38100700002)(86362001)(478600001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clhRUU1NaDE4aHdNQUMxSGkzeGY4QjlvOEJQcXowR0xxV3F1RktwU3F4THJm?=
 =?utf-8?B?aEdNdVJ1VUdWSFZTYjNjbU5nRDQ0Zk1tWWp2bVNzWDJMdFVyMUhsdzlUOGtk?=
 =?utf-8?B?WDlqSWZ4amltVWI3c0tWQWZ6TEJRaHVhOWEwSit6ckR3ZUpUTTBDRVMxQnZX?=
 =?utf-8?B?ZVRnSWdiem15V1FUL09RNUZSeit6M1FRcFVpRHdqSTkyc3RFS3AwemlrcVZC?=
 =?utf-8?B?eXg4SitycE5mNTY5SkFTcHI3a2diUU5DWlFkUURBVm90a1NCYm0xTmFSNG5x?=
 =?utf-8?B?Z1ljNGVRYmZYd0lYSzZmUFM2ckU0Qm01a1VmRy9MbHhGdzdVY01VSGt4Um9K?=
 =?utf-8?B?UzJIM05iRlNiVjNyU0pQV3Y1c1dtY2pwRHFXV014aWNGeHhULzROdmhrbUFh?=
 =?utf-8?B?cytkbnR0UmhLbTBlV21IbmlWNlltbUI4N3IvbVUzK2RwQURsYTNlNjdUK21M?=
 =?utf-8?B?eEpFM2ZsTnUrd0xuS2VBa0o0VXRKYXVPa3loZkJTYUptcXVPTHFhc0ZQWDQx?=
 =?utf-8?B?M0E3RFN2QVduZnYyVTJ5ek95dXdSSjBCT0hUM21VWHR3WVBXTzZKeDJreEh6?=
 =?utf-8?B?UU9YZEFZOHplTHRxMVN4TGdIKzF3diswQjEyN3dmbEppUmticnN0V2FRUVlq?=
 =?utf-8?B?Y1U1WE9NTFdQMFpuQm9PelVqVnFxRG5WbjBHeXRXZmUzaXY4Z1BKVitEc3lB?=
 =?utf-8?B?WnVDMUp5TmxvN3BRYzlnQjJlOGgyallrT0VtdzZpd0llbVo2Q0Nvbkx6TVM4?=
 =?utf-8?B?MlpPd1c5Rkw2NWhlYVFIRENTOTBRaDdEK3BRRTNReCtKRk5NcDYzS2VOd0RC?=
 =?utf-8?B?YUlrbk5Uci9LOW5ZeHArY2xsTTlKR1dRWmxyb2E0aHA0VlozUUltNUYrMEc0?=
 =?utf-8?B?VnNtTHR3QVBNWGJ2U1pkbWhDTER1MEVZNEJBbzFXdEtjN1FYeksvT0lpRDVK?=
 =?utf-8?B?TURwcTFzZmVyTmVPN0FVamJjZThWRllIdVhVRUFwcFJib0hFcU9wN2hORTE4?=
 =?utf-8?B?bEF2VU9oMHVFZ2tORkVSV1ViVUhjcVFzRE1mMldDZFVMSWtWSUhERWViU0xl?=
 =?utf-8?B?bTFGU0JYMVVjNkFlK0VVWmI3N2h0UURqNC9oMFpldC83cytzTHduekVIUE5o?=
 =?utf-8?B?VEt6R2ZKMnY2OWp6VlVjNnlVZnF6eDc3UGhBSUNFbU13ZnIwZEVZTG5hbzNN?=
 =?utf-8?B?Vmt1bGZPb3l4L2o4V2hQMFB0enBBT3ZFMHZzYi9rdFZCNlFjc1ovTzRtS3Ra?=
 =?utf-8?B?UDBIajRlYldrYVg4ZkZwcm1iOWdVV0wxMGU5Vjc4aG51QjMwemQrKzhaM1Zy?=
 =?utf-8?B?QjNzb0VVcVBSNlJqVm4vazZPMG51SXE4ekRMZVRtdk1PbUpFZTZwSGIxT21V?=
 =?utf-8?B?VmQwbUVTTExQaFVVSjBBNVZ5WWcrMm50eHdpVnUyK2hHZ2dwRFJWM1ZiNnM4?=
 =?utf-8?B?K0QySllQdk4zcmxoWFNTYUpmVEFtaDZjVW92ZFI5d0VWSVVGeXAySmM0aTYr?=
 =?utf-8?B?SWFiUXZEZEltYVUrUHk1NTd3eW43MjF5b291OXQvZnUzUVJ6eUJRNm9RT3N1?=
 =?utf-8?B?anFuLzcrSUlBYlp2WUw0by82QTlYSUhKZnEva3F1Q1hqeGxUMU9wYzJQSWVK?=
 =?utf-8?B?NWhtME1HV0FwZmVVbFRCZXc0V3dFcXlaTEJPa21hVEpXajJUK3JvYTRYMTJu?=
 =?utf-8?B?WmZzRU9UNGtSNTNoZHRCemxZaFZJb3ZjNGJNTmpPTUtQMWF5c2hRQUd1ckpa?=
 =?utf-8?B?U0NFK0hSclMzUHh0bG0vZWhuMG8yZjZEb1ZJZzZOSmw2NDdVY09sZ21aRlZi?=
 =?utf-8?B?VlYvK1RIb2ZlRXZIaG9kLzJVdmYzU1I3VDJVRFVCNmRzaHM2LzlzdWZ3aEpt?=
 =?utf-8?B?bXNIdmNCRDRpS21XcC9lbVRIeWdDVzdCMDgyWXJFbFpXNHNTQmx1aUFHc1dw?=
 =?utf-8?B?ZllJTDNEeWY5V2tES0ZJL21EQ3VBdGVSbHBLRXo4dkFpa09PUTA1bDJYeU9n?=
 =?utf-8?B?Slk0YTg4Z21idHdQMUczQ0pTKzZGakxxeFA1US9rUTY2K1pIVlpxa2s4Uy9Q?=
 =?utf-8?B?QVg0dkhINFFjY3BVNElvT1hDV2VWSFE2L2tVME91dXVSWXR4b1c4d2h4NXVI?=
 =?utf-8?Q?11s/wcsOLpzwcVi9nO9Exbeoe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03446978-4a53-45c2-bb4e-08dbc5202034
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:23:17.4402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVtJJr8aGbbLH0AjEAK9cLYWSpZ8t/aUb9ohiSZtNalFm0SHRHHwMGgNspReN3pdGBQ4LU6wadzaBVTGzpsThQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-09-08 12:04, Shashank Sharma wrote:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch intorduces new UAPI/IOCTL for usermode graphics
> queue. The userspace app will fill this structure and request
> the graphics driver to add a graphics work queue for it. The
> output of this UAPI is a queue id.
>
> This UAPI maps the queue into GPU, so the graphics app can start
> submitting work to the queue as soon as the call returns.
>
> V2: Addressed review comments from Alex and Christian
>      - Make the doorbell offset's comment clearer
>      - Change the output parameter name to queue_id
>
> V3: Integration with doorbell manager
>
> V4:
>      - Updated the UAPI doc (Pierre-Eric)
>      - Created a Union for engine specific MQDs (Alex)
>      - Added Christian's R-B
> V5:
>      - Add variables for GDS and CSA in MQD structure (Alex)
>      - Make MQD data a ptr-size pair instead of union (Alex)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 110 ++++++++++++++++++++++++++++++++++
>   1 file changed, 110 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 79b14828d542..627b4a38c855 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -54,6 +54,7 @@ extern "C" {
>   #define DRM_AMDGPU_VM			0x13
>   #define DRM_AMDGPU_FENCE_TO_HANDLE	0x14
>   #define DRM_AMDGPU_SCHED		0x15
> +#define DRM_AMDGPU_USERQ		0x16
>   
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -71,6 +72,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_VM		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>   #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> +#define DRM_IOCTL_AMDGPU_USERQ		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>   
>   /**
>    * DOC: memory domains
> @@ -304,6 +306,114 @@ union drm_amdgpu_ctx {
>   	union drm_amdgpu_ctx_out out;
>   };
>   
> +/* user queue IOCTL */
> +#define AMDGPU_USERQ_OP_CREATE	1
> +#define AMDGPU_USERQ_OP_FREE	2
> +
> +/* Flag to indicate secure buffer related workload, unused for now */
> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE	(1 << 0)
> +/* Flag to indicate AQL workload, unused for now */
> +#define AMDGPU_USERQ_MQD_FLAGS_AQL	(1 << 1)
> +
> +/*
> + * MQD (memory queue descriptor) is a set of parameters which allow

I find the term MQD misleading. For the firmware the MQD is a very 
different data structure from what you are defining here. It's a 
persistent data structure in kernel address space (VMID0) that is shared 
between the driver and the firmware that gets loaded or updated when 
queues are mapped or unmapped. I'd want to avoid confusing the firmware 
MQD with this structure.

Regards,
   Felix


> + * the GPU to uniquely define and identify a usermode queue. This
> + * structure defines the MQD for GFX-V11 IP ver 0.
> + */
> +struct drm_amdgpu_userq_mqd_gfx_v11_0 {
> +	/**
> +	 * @queue_va: Virtual address of the GPU memory which holds the queue
> +	 * object. The queue holds the workload packets.
> +	 */
> +	__u64   queue_va;
> +	/**
> +	 * @queue_size: Size of the queue in bytes, this needs to be 256-byte
> +	 * aligned.
> +	 */
> +	__u64   queue_size;
> +	/**
> +	 * @rptr_va : Virtual address of the GPU memory which holds the ring RPTR.
> +	 * This object must be at least 8 byte in size and aligned to 8-byte offset.
> +	 */
> +	__u64   rptr_va;
> +	/**
> +	 * @wptr_va : Virtual address of the GPU memory which holds the ring WPTR.
> +	 * This object must be at least 8 byte in size and aligned to 8-byte offset.
> +	 *
> +	 * Queue, RPTR and WPTR can come from the same object, as long as the size
> +	 * and alignment related requirements are met.
> +	 */
> +	__u64   wptr_va;
> +	/**
> +	 * @shadow_va: Virtual address of the GPU memory to hold the shadow buffer.
> +	 * This must be a from a separate GPU object, and must be at least 4-page
> +	 * sized.
> +	 */
> +	__u64   shadow_va;
> +	/**
> +	 * @gds_va: Virtual address of the GPU memory to hold the GDS buffer.
> +	 * This must be a from a separate GPU object, and must be at least 1-page
> +	 * sized.
> +	 */
> +	__u64   gds_va;
> +	/**
> +	 * @csa_va: Virtual address of the GPU memory to hold the CSA buffer.
> +	 * This must be a from a separate GPU object, and must be at least 1-page
> +	 * sized.
> +	 */
> +	__u64   csa_va;
> +};
> +
> +struct drm_amdgpu_userq_in {
> +	/** AMDGPU_USERQ_OP_* */
> +	__u32	op;
> +	/** Queue handle for USERQ_OP_FREE */
> +	__u32	queue_id;
> +	/** the target GPU engine to execute workload (AMDGPU_HW_IP_*) */
> +	__u32   ip_type;
> +	/**
> +	 * @flags: flags to indicate special function for queue like secure
> +	 * buffer (TMZ). Unused for now.
> +	 */
> +	__u32   flags;
> +	/**
> +	 * @doorbell_handle: the handle of doorbell GEM object
> +	 * associated to this client.
> +	 */
> +	__u32   doorbell_handle;
> +	/**
> +	 * @doorbell_offset: 32-bit offset of the doorbell in the doorbell bo.
> +	 * Kernel will generate absolute doorbell offset using doorbell_handle
> +	 * and doorbell_offset in the doorbell bo.
> +	 */
> +	__u32   doorbell_offset;
> +	/**
> +	 * @mqd: Queue descriptor for USERQ_OP_CREATE
> +	 * MQD data can be of different size for different GPU IP/engine and
> +	 * their respective versions/revisions, so this points to a __u64 *
> +	 * which holds MQD of this usermode queue.
> +	 */
> +	__u64 mqd;
> +	/**
> +	 * @size: size of MQD data in bytes, it must match the MQD structure
> +	 * size of the respective engine/revision defined in UAPI for ex, for
> +	 * gfx_v11 workloads, size = sizeof(drm_amdgpu_userq_mqd_gfx_v11).
> +	 */
> +	__u64 mqd_size;
> +};
> +
> +struct drm_amdgpu_userq_out {
> +	/** Queue handle */
> +	__u32	queue_id;
> +	/** Flags */
> +	__u32	flags;
> +};
> +
> +union drm_amdgpu_userq {
> +	struct drm_amdgpu_userq_in in;
> +	struct drm_amdgpu_userq_out out;
> +};
> +
>   /* vm ioctl */
>   #define AMDGPU_VM_OP_RESERVE_VMID	1
>   #define AMDGPU_VM_OP_UNRESERVE_VMID	2
