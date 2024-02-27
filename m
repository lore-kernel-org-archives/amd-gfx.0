Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E0EC5478C
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Feb 2024 19:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4CA10E05B;
	Tue, 27 Feb 2024 19:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fUJ4+JnV";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B8010E05B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Feb 2024 19:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzEOJ4bHiD6w2Tro/qTf4nA9x1wxVbbFIquc00N2ruig2eSHYEnPxvyoX3LKZjDY4ylekNGvif7DWU5H9JdePHE44OR3V10FIA+tevqRp0xNTJAOeu42ikZkbFsGPIGy0oDjE/eBATUabgve4MEtZC+eyF4/8bW6BBf++GAuxLH0gIwHZ19DyVdyuPcqFSAzRwYoEnxrbJqhDDLpjshzWh6chlSpMFIEcwzK7uYexwQjV9GEvPZ1M5egluL9ZQmyme7o2bRPo23hLBGze7xmegye8GZFr0NVtXwY5gbXiZff2T2oSPMvO1hJ1cuSPas8TKFV7tRmEPBhR/d/QqJdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK4UMGYHVFox5FPveijp8KL05MQkO1S4k+9uV2V/jYU=;
 b=cuzwKVDv6Pf1d0OKkm0ToyZVpvQ97zDXvCtcVNCecf+hAEKKfx8ZBv1giWia6TeBXAVCdNrexcAcA/nJLfxCv5MO9Yphj6ZqxDtDmylSFOdG5dvFCOSzhNy85Gm7CKlueVgsECCHSltT73I42KR5vLI0Cs0sS/YniCVl5UOr5n0OPvBqZVdJh0sYpNobAkTGtkjicrFRslcTTjewANr+y74r3bpBT/4MIA1WoX5MUhhcRHfIZ5ymMNkbXMGRZMcJcF4WYJJGiVDJ7VOr2HwpLdlZ+ElI0MGRniXBu7QyGWK/dbF0NfxhEuDGWQl5uyPxTmvjsmErzPE2VA/ZQDPzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK4UMGYHVFox5FPveijp8KL05MQkO1S4k+9uV2V/jYU=;
 b=fUJ4+JnV9X+SfdU8Kbqlzp+BJWUOJZpdsvPHI/yafg5/mX301RsdAuJBqcP+Ozre6Xe2Jty8O0ikCNsHnA6ew8UKcJ6DufEXSyGyVU3zfFCASwxROlI8NsowEimsFTUP6sjJFikt2MLmRet+VkJcWmQ0liJEAStnyEXaPhTrNe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 19:45:09 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::b355:5f4d:3821:ad01]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::b355:5f4d:3821:ad01%6]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 19:45:08 +0000
Message-ID: <981eaa1a-e548-407b-97e6-4184b332f707@amd.com>
Date: Tue, 27 Feb 2024 14:45:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "drm/amd: Remove freesync video mode amdgpu
 parameter"
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240227184847.3078099-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240227184847.3078099-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::18) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c36629-d088-465c-6e37-08dc37cc9aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wC3UflO5g+k8Vq8Nm7tgW59E/NvNikt2CHFI4I8NSKw+bIeFphDoc0ncYfGcmNuCggtenkqCXOI+kaz+LkUJhYv0Hv1ronwiU8cRJPCo6xmw42kiE5BoPr0I8uSh56yGm1VMsFpG/WghlJOuBJVtKVXW63wDByn+AcVXd0WckHzzpAy1Bh/S8Z/Txk7GpIlsnWgh4C/76uXH4ZEJI8TvmyHtjIY8FSvoqTWCDnXQXZwP6ATJcohHQ3Ls31kCfYr7OcI1utxXhzOoAHXCcyxXy/tKgm+ZwSzN5Jnd/CjJLoJK3daRBULFETpm+8quG2l6z26pysuKTTUdNvNyYw6xPsmOtPbeidIrwSagWKvVQQEY+5A6AS5UB/EEzsFBIjEWEbfRcaIN4WVsKk2btT8N1KeFOK8VYqCmbZK7wLeUgVYmQKMcB0SLANCKIjz9azgvUWKYWUAEDZWQLTGK1mzPWi6yorrI8xycZB5/x9vsqGcER/ExBqJD8YwT8fT47M4O9Gb6N45uFqIp/12eXxz/H4YFTuVYJ8hdrfCyae9pf9UqCvIOBn3K79y9Qt5vFsHQf2r790ktCOPyBsi7ZPA6QyFi5NNKqiCObxDo9y5uU+FTvrv1sCg53ddexXSf8V+G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2pIZmRscnRRVFZyKy9YZ214SkZ4U2lXdVl3N3ZRN2ZlQUMzSUpZWU1wWTk3?=
 =?utf-8?B?S3F6WlRBbS9yZFM4SStsUjhyRmRCWGxTZUowWkVOWlN2UVJzVmVyRTE3SlA5?=
 =?utf-8?B?TU1uUVV4RHc4eTBnMFFXU3JUd211L084dDZ4T2l1dkFNenAza2tEMlJTVkhv?=
 =?utf-8?B?VUlNeUMzTlE1aVpMdUI5VEpGRERGQUZLOUJJVFlSSm51UUJkSEdzdVlNZUEr?=
 =?utf-8?B?V0lYNjRzTmoveHMySk9Qb3JqZzdJZW1WRzhVaXZ4bHI4aXEyWnVJaW1HWVJj?=
 =?utf-8?B?RmttMTVIUTVDaFNEZnFZUXlqWDkrK0UrZVg2MUxzbW5MYVg3TE1PeEhId3Fs?=
 =?utf-8?B?eHI3ZDNnemQzQzJrSjB5aytFa3FaTk9IQXZNalg1bjMzaTNvc3ROVGFhNFNU?=
 =?utf-8?B?NG9XU2FHRnY2ZU9jK3RjWTBjbVhqQVRjeHkwdUFCRXRmZmRyaGw3MUl0M0lK?=
 =?utf-8?B?Y2Y2UVRDYmpLTGZkSmZtWWJLTEQ0Q24yQ0JRSytMcXZyUUx3bzlZNHBpaDNy?=
 =?utf-8?B?M2IyOVZ3ZHI4S0lvV2JOYzBQWVRBTjZGU0tGMUNpOEZWdkU0ZUlpcWEvNWVo?=
 =?utf-8?B?OTlMeVlkMDU3a1FXdGlTc3hVY1Rvb3lyc2MxcDFBLzg5djcyaVJvM2hQd004?=
 =?utf-8?B?SFlHQ0J0bHhHN2dXcXI1aXo1N3ZDZDNCNU9EZ1hwZlAvclVRK2thempuZHVz?=
 =?utf-8?B?TnJGc25SNUNmNHJYeTlOdWRBT0FKMkxNSFl6ZVVjdWNTQzlUcG96MlJWVTBS?=
 =?utf-8?B?b1krcExuQnlUTUFIMzh0aEV5NU1wZG91OHQvbmV5YUJCazFCVGpYM0wrZ21U?=
 =?utf-8?B?ZFdQSW1pVGJlbk9TMlNDRVBaWTN0cXNTQUwrbjluM1RjMTB2Mk40TzFjYWJB?=
 =?utf-8?B?Ym84TlZ5WXREb1ozUmRORFQ3RFNtYkcyUUJLekZlaWM4ck01WGIxMEkzQWhB?=
 =?utf-8?B?WGk4UmRQd3JZSGdOM00ybGFCakg5NUtLd1ZhUEJHSnRCTE1odkpleGk1Rm8w?=
 =?utf-8?B?aHYrRzJXUmVlVUlneXNRdStxT1dMZ05zZmM5djhmVFhqSjFieFpRQzNTZTFv?=
 =?utf-8?B?YnlBMHQvZUZhNDdsamZqM3hocERiYW1BVExjYks0RldZSXVZaVlKaGM2cVVZ?=
 =?utf-8?B?dFFzZEJVc3FEMGdkY2UxZWVSR2sxYkJIRGNMc3J4dGUyMUljTGVlSzE4ZkF5?=
 =?utf-8?B?MjNWL3g5UWJEZkZaNjFIb0JpRys0R21oMDBOMzFLTkFqL2didzFXWFhIQzNB?=
 =?utf-8?B?MllENElUVzJmZS9ITDVzSXV3d1ZUd254dmY4dmlzekRia3o1aGtjdWdodEVH?=
 =?utf-8?B?OFVNY3hPTTYwZnVvL2U4elRTZVlXaEU5NmYreHpHNXJwamhoNzEvd29qNWlr?=
 =?utf-8?B?OUhWbTJTbkhMcjd4WUVYYVhRQkNBdDVucitZeHcreXFGNHdoTUdLSUJzejBh?=
 =?utf-8?B?eGtPYUNwVzJIWk9zcVNZQ01rZEtjc3RNM2plTGZkV1J1ZzVJUFFaRTJ3MU1M?=
 =?utf-8?B?SUZQOUxWaWRSSHA0dkZZcVhEbVlrU293aWtxMERSWGpQSzZKSGdvN2xLUjZS?=
 =?utf-8?B?b1pOdnd0Y3NwV3JYR0pEWmJ2R3h4cGtRckV1SlFHV09NWUFNcWJoSTBoM1F0?=
 =?utf-8?B?ZzB1cHgyZDJDTUN6bFlWem0wdW1XWmhZWlVFb3VuVURKWGtPNTNzVkpNMkhn?=
 =?utf-8?B?ZGhPNEtLSTB2QWVWZlIxUWtGeFA2NStvNFB3b01aUXpRa3NFd3RnYjVoWEJS?=
 =?utf-8?B?eGZyb21jRStibnVRVW5lcjRLS1FseWZDMTljREUxQzFrbWhETnVLc3JOMnhU?=
 =?utf-8?B?bC80cUE3Tzg3L25JRjZpT2YxazF5d2Urd2ZodlhCVzZ6VU5DSHJJTFNNeTBV?=
 =?utf-8?B?QVN0VkJBWmJIVnNVQmc0Z0JPM1h4YnYvL0lTejlYcExSUlBocmlKcTBHVk16?=
 =?utf-8?B?a2FRd2Z4bmh0NVlnRXFkZkNEM2EvaUlhRkVhQWdKY3FsNUhTbk9ZRnpWMllV?=
 =?utf-8?B?Wk9JNEIxSzI0OWNvNm83eWxEV2l3cU9nd083MUp0RGNrRU43ak8xekEzYW96?=
 =?utf-8?B?R1pab3gxMkhRQzQ3NnNyRDAyOVpKaSs1ajQ5ZmVGdmZ2aDBLMFpXTUJLdkh6?=
 =?utf-8?Q?fY9w2Ka0iUYpr8SPteHGIgU7H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c36629-d088-465c-6e37-08dc37cc9aa7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 19:45:08.8733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRw3FagTbWIHNWIqyfG8CIaf026CipENbVTCM4NlUEpE9bII8Q3APR9IL+PMMv0G7nGbGQ2FbaZOTnyGCoiZkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
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

On 2/27/24 13:48, Alex Deucher wrote:
> This reverts commit e94e787e37b99645e7c02d20d0a1ba0f8a18a82a.
> 
> This conflicts with how compositors want to handle VRR.  Now
> that compositors actually handle VRR, we probably don't need
> freesync video.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2985
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series is:
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 27 +++++++++++++++++++++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0e365cadcc3fc..925026c183f41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -194,6 +194,7 @@ extern int amdgpu_emu_mode;
>   extern uint amdgpu_smu_memory_pool_size;
>   extern int amdgpu_smu_pptable_id;
>   extern uint amdgpu_dc_feature_mask;
> +extern uint amdgpu_freesync_vid_mode;
>   extern uint amdgpu_dc_debug_mask;
>   extern uint amdgpu_dc_visual_confirm;
>   extern int amdgpu_dm_abm_level;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 15a8a64fc4e28..82b154b103f43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -199,6 +199,7 @@ int amdgpu_mes_kiq;
>   int amdgpu_noretry = -1;
>   int amdgpu_force_asic_type = -1;
>   int amdgpu_tmz = -1; /* auto */
> +uint amdgpu_freesync_vid_mode;
>   int amdgpu_reset_method = -1; /* auto */
>   int amdgpu_num_kcq = -1;
>   int amdgpu_smartshift_bias;
> @@ -883,6 +884,32 @@ module_param_named(damageclips, amdgpu_damage_clips, int, 0444);
>   MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto (default), 0 = off, 1 = on)");
>   module_param_named(tmz, amdgpu_tmz, int, 0444);
>   
> +/**
> + * DOC: freesync_video (uint)
> + * Enable the optimization to adjust front porch timing to achieve seamless
> + * mode change experience when setting a freesync supported mode for which full
> + * modeset is not needed.
> + *
> + * The Display Core will add a set of modes derived from the base FreeSync
> + * video mode into the corresponding connector's mode list based on commonly
> + * used refresh rates and VRR range of the connected display, when users enable
> + * this feature. From the userspace perspective, they can see a seamless mode
> + * change experience when the change between different refresh rates under the
> + * same resolution. Additionally, userspace applications such as Video playback
> + * can read this modeset list and change the refresh rate based on the video
> + * frame rate. Finally, the userspace can also derive an appropriate mode for a
> + * particular refresh rate based on the FreeSync Mode and add it to the
> + * connector's mode list.
> + *
> + * Note: This is an experimental feature.
> + *
> + * The default value: 0 (off).
> + */
> +MODULE_PARM_DESC(
> +	freesync_video,
> +	"Enable freesync modesetting optimization feature (0 = off (default), 1 = on)");
> +module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);
> +
>   /**
>    * DOC: reset_method (int)
>    * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
-- 
Hamza

