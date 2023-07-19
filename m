Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3479C001DC
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 19:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70C6F10E4FC;
	Wed, 19 Jul 2023 19:33:48 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9257810E4FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 19:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJNrcUSfEXe8M0op2yxoawtty5bKZtrZoS80vnyDYW9EqU7aKtThFF3iu3+1e/mTZ89AF3h8hD3ceRtdlIb+NopkmMEqj1tgaWaIg6kCllSQ1TbLyG4qTmNRTGdBNUDhdsohO+euiQqnfSmNWRFkI9mAfT8y8xhC/PEr78O44yHYgJpkhBXFQSsqELn8HLNeX/9FVDaUoeu9fd0uZAPyryMNAax89+/UYe0/RWUUGLM9qv/dCeui8UJKdC162aMDDTPIM/ESb0/rdW20XgB4LzJppM7mz5FcK9fIKGnCAYqL/emwhP0lDJRsowejAP4X0PCWZK9KHepxQJt7T6Z92w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaMa4zqpWMgn9X/aIoOZlCjEyxdMJywLYEpze4TKnPY=;
 b=Bo/0j9kyH9DnZVYH8T2dbtfjgymmDd3MoEFj3k+GYyh6DJ0ovAJZVFU1RFnvIao4SLApEJRsyRaaHvLQsZ0/9239nyBQJkT6JgqubCcid8hP8Kx1W65SSjSXH5PVyxj3C88ZSQxtugOFXmxXqGtF6TTlKieJuPMKNoyXBvpXs1I1ZUGXyX/Gx5h0z8qLNOwgunKUI7JQV0wkVHvkOnf/zSRdW9ho8k+nbonTEwX/0EYP8lTu3btObUXCQGDj7IN7Of+hhlpFYwIWA1RVTdxflzwZzA9JutYl64JJBMfNW1UqKp/ZG7xa7meU8M3Yad6lc94w0TZKMAkPOni7fKfOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaMa4zqpWMgn9X/aIoOZlCjEyxdMJywLYEpze4TKnPY=;
 b=h5pRBq6jv35glwJJKleWp3QFKQb10ABlOjo2svaYauulVFL5/2cx9pb1QBWVQQqwMiOFf2Y3Ep4fTLVvJcqWWQ7BJb0+cRc5KYs9ASFoWNnIKcobLY6BT5Ev1D61/dQC/T4ijV6BQiZHTZTjCaTVFihTb6ODl7R41E1FpST/Nas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH0PR12MB5449.namprd12.prod.outlook.com (2603:10b6:510:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 19:33:42 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1a2e:ca36:f117:d2b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1a2e:ca36:f117:d2b%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 19:33:42 +0000
Message-ID: <864bbe15-ffc6-81fc-ad69-a26972c65962@amd.com>
Date: Wed, 19 Jul 2023 15:33:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/10] drm/amd/display: Enable Replay for static screen
 use cases
Content-Language: en-US
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-11-Bhawanpreet.Lakha@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230710192733.1344403-11-Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0494.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH0PR12MB5449:EE_
X-MS-Office365-Filtering-Correlation-Id: def56e51-1460-4f3c-6deb-08db888f0f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XP7+jy1bLfBY1sfzyQpexzBO1DqnOYUXEKhVwLZwfPKA1MGV5x30rxjgdgHiW04gYN6fe00ByYsNEYeBWLbtkznFAxsdIO5L/EnAsVT2XZxod4RY26xbkfKAr8VlVLEAWC0c1RWHoikZaVujBq9Ny8g9bhGLtlVuwaYZLj5qMArCCNsR543MP70jnSDrrC3ubSat6L/VeukaSoKeH11H9z1K542Lo1JeLMjBZcJlxXmoTATQTF+N+k8VNkQpEBfxw37sW9PwdbW2OXbr+jNq4dT/L9EDce/rs+zOgZYrReuThdi7ScFKYHLPLu4yU8JVMhTCqs/4QLrAv//e+JDGGTVIUMwS1pSxZqFnz/KNt3qvyc4Lntcj1GrwoULwRKJLcJXLTJtjxLIS//4yhZ6u5O/WF76tPzSfalQ/eXvou43tGrX9kUsenY9DTLKJi9hPadLmPgJl6xbpiwtyuuxHfGe23Gyqt1Ok2ybi1efOq7SLwOJ6O2lMb7l+FVhzeY/lMQ5kAXZNonLrCoB9v8o5ZR8Nvl3w6kmWr2jDRsHDhoM6g21JpaLCrY/owJKtx8KbEasbY4yrJlHia2ZWozYQE2ejan4RWLwTzlxmBAl+ByJU8Q4EV+VRJzzYFeSMXbyucFPhiT5l4xHsUCZ8is+nKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(38100700002)(2906002)(6512007)(6666004)(6486002)(83380400001)(2616005)(36756003)(6506007)(53546011)(186003)(31696002)(26005)(86362001)(478600001)(6636002)(44832011)(31686004)(41300700001)(8936002)(8676002)(66556008)(316002)(66476007)(66946007)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWgwd3JaQjdZRnplQTd6QWdkMTVOcVU1ckQ0dlE4NHFmd0ZIVXZRU3JsbEF5?=
 =?utf-8?B?akFENlVvK0ZoVU9YaEZWQjdZUWFjUU5leURwVmNzbTN2ZFBoczVXZzJmdmVh?=
 =?utf-8?B?WHRpV3Y3SGwwaTBHZnIzZzdDS3NEa1NEWmVTZzRPcUVoQ1F5OEJGVkdnY0hu?=
 =?utf-8?B?NzBOL1doODJ6WDhvaGFwUHE0SldxdUkrTTdFM0tJNlA4OHpaNlNRTDZGMmNQ?=
 =?utf-8?B?QmFYVitLdVJLLzhQS3BValdGNFVRZXFTQWdmd00xcUJTdWVsOVhHTFRkWUtu?=
 =?utf-8?B?QXJDRUs0dlhXOTZHc3d4Sm1QZmtuSStBV1FCb2FSSDlrMm5ML0ZZNkxZT3Ry?=
 =?utf-8?B?NVdKNE1ESFlwcTFydU9nazVwZDFrU1ZOZWZETDVYZTdLTC9sdEtDaEZhajVM?=
 =?utf-8?B?UW9BRDB3cG52eFgzai9QOGNWUi81dUdpNExaUE5qRWlmTURYOXZFbEdjVG5o?=
 =?utf-8?B?Z0E0REdaN1M2Q2g1VWlpeVJBMkdBN0d2T3U1WUt4Z0w1aWNDUllOWkIrbHFk?=
 =?utf-8?B?cC9CcTMzMjVsNjBjTHM4QnNvWWF1ZHpWNGs1MXRvSGE1VEJ4eVlGM0NjMFI5?=
 =?utf-8?B?SncyamwwOUplTm1WNi9YYzF4UFFJbmpXS2U2YWpaUTNsNGtMK2VqdVRxNEx3?=
 =?utf-8?B?WWFuWUlKcm9nU3dpa09kQW5SZEFLaWp5N3BlQ2gwaUgxT21OWTdqZ3B2ZHBt?=
 =?utf-8?B?cVNtbzlycWE4NzdCUDF6SXFRdFlhTGJRSmdGekQxTWZjc0VPRHpNY21uZGFv?=
 =?utf-8?B?cVZuWXJpYUtnMVRVS05rVXFNZXl2a2dqayszSG12ZjVwTG1JWXpDWG1WeEZK?=
 =?utf-8?B?bU9NZDFJRW5melQ2OVdqcDZpOHNiQ0tSS0FIak1BYTlCYkVoMWl0dXI0U0Qy?=
 =?utf-8?B?UDhOMkcxV0laSVZCV1hrRjYraFBUaVZxM1hMY083SjdGbk1NSndzR3dOSWc1?=
 =?utf-8?B?cXNWQ3ZzTFJCWjNaS3UzZ3hzWEpCVk5DbG5ZQ3dPSDd0ZXhrb0FjVlUxZWUr?=
 =?utf-8?B?bFUvLy9MV25pVWl5NVM5YTlYeEFJMzdUZmJXRGZPVjlncEZjSStKZlVzTXBF?=
 =?utf-8?B?MUUrYnVVZmE4RkR1UG5IbDhsVG9NV3VuNktYbW9yWWMwUEZJN2RYTUswZDRR?=
 =?utf-8?B?bzcrMnQrRWYzd2lBajBYTWE3MWRaRnh2TFFIQU9xZkZqWkc4Q2FnVTlOdW5j?=
 =?utf-8?B?b3diQlBUNjVFci9hY29ZalJjSHl6cEVQQkllemdsZ0JYRkRrRTAvby9mUXA1?=
 =?utf-8?B?bTZwYXVaWi84Z21yZnVOMmh6ajhJa3NPdDBNSFJaSmswS2N6MG0zMlBicWlz?=
 =?utf-8?B?UW9ycjE1dlhVOElvcncramZLMElnN05KR29NeFpDcUtKdGhyVTRkeEQ3REI0?=
 =?utf-8?B?STUvOXZ1a2V5VHNWei83WGZHaDhnUTJwTTNDUU01dEtBVWdhY2pHT3d0Z3Z2?=
 =?utf-8?B?a093MWM2RkgydXJFQmIybDdUSXBnRGQ1VzRHV0hZanFRQTBTdXVpN2VsdkYv?=
 =?utf-8?B?azl2QXM1ZmJBb0xRWXg2RURCV2g3YnJOQWhqMkp4dEdKU1ZCUTJuelNzbVhT?=
 =?utf-8?B?Q3ZjbDVpZXYraUNFYWc4VlFvRmI3ZGgwYmxBRXFtTHlpR3R0TDF3M0I1N1hB?=
 =?utf-8?B?ZXVxenRoQWNVT015UHBwZEFJWmwrNllJd0RvWC91UGZzaXVoblU1U3kzNWJm?=
 =?utf-8?B?MFl4QmpRT3NxY0d1QUhhS3M0cnBxeTBXemcweklmcEUwNUd2SWhlR01NQXNG?=
 =?utf-8?B?bVV6SEpVRnh6U2ZjU0QrWFhXRVRqY01pSVA0NHRPd2xyN1lJVzhmc3Q3ZVBH?=
 =?utf-8?B?NEQ3dlhpVy9GZ0hwMXlKclJ3VXNhNEZOSUV3QWpDNFdMS0pHM01Ta2VLbnVh?=
 =?utf-8?B?bTRkL3Y5VjhQRk1pYm9xK2F3cXJDczNQR0ZLL3EzdFVRK0tGOVdUQVJUZ01O?=
 =?utf-8?B?c29RcE5ndzRHaXg5WGhZUTZ2QTlleEpVOVNEMnZieWkvdHpIYlJQR0JwYTFa?=
 =?utf-8?B?Tnd4alJBRVJTQUZsQVR6NjZacHYwa2R5RDRYcE9BUzhwUFVtc05TQzlZNUlB?=
 =?utf-8?B?S3VHRWp3QlAvQXgvV3JMUiswZG8xNUpBNUlEcWozUGFSMHlJL0RlUFdkWEM4?=
 =?utf-8?Q?9TkKW7OTNt4j778jFarYFIaGU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def56e51-1460-4f3c-6deb-08db888f0f37
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 19:33:42.1632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVd9une8PRmcoBEvb0+w5RPI1Fy/495lG1t0uT7bMDg7Q5Ss+SzdK3f8RyvaAYpFcIInKS4AFusBWPu5YSe0wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5449
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



On 2023-07-10 15:27, Bhawanpreet Lakha wrote:
> - Setup replay config on device init.
> - Enable replay if feature is enabled (prioritize replay over PSR, since
> it can be enabled in more usecases)
> - Add debug masks to enable replay on supported ASICs
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++++++++++
>  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  9 +++++++-
>  drivers/gpu/drm/amd/include/amd_shared.h      |  2 ++
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 90bc32a29356..b5aeae693417 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -65,6 +65,7 @@
>  #include "amdgpu_dm_debugfs.h"
>  #endif
>  #include "amdgpu_dm_psr.h"
> +#include "amdgpu_dm_replay.h"
>  
>  #include "ivsrcid/ivsrcid_vislands30.h"
>  
> @@ -4315,6 +4316,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  	enum dc_connection_type new_connection_type = dc_connection_none;
>  	const struct dc_plane_cap *plane;
>  	bool psr_feature_enabled = false;
> +	bool replay_feature_enabled = false;
>  	int max_overlay = dm->dc->caps.max_slave_planes;
>  
>  	dm->display_indexes_num = dm->dc->caps.max_streams;
> @@ -4424,6 +4426,20 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  		}
>  	}
>  
> +	if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
> +		switch (adev->ip_versions[DCE_HWIP][0]) {
> +		case IP_VERSION(3, 1, 4):
> +		case IP_VERSION(3, 1, 5):
> +		case IP_VERSION(3, 1, 6):
> +		case IP_VERSION(3, 2, 0):
> +		case IP_VERSION(3, 2, 1):

I imagine we'll want to support replay on all generations going forward. Can
was just do a check for >= IP_VERSION(3, 1, 4)?

> +			replay_feature_enabled = true;
> +			break;
> +		default:
> +			replay_feature_enabled = amdgpu_dc_feature_mask & DC_REPLAY_MASK;
> +			break;
> +		}
> +	}
>  	/* loops over all connectors on the board */
>  	for (i = 0; i < link_cnt; i++) {
>  		struct dc_link *link = NULL;
> @@ -4472,6 +4488,12 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  				amdgpu_dm_update_connector_after_detect(aconnector);
>  				setup_backlight_device(dm, aconnector);
>  
> +				/*
> +				 * Disable psr if replay can be enabled
> +				 */
> +				if (replay_feature_enabled && amdgpu_dm_setup_replay(link, aconnector))
> +					psr_feature_enabled = false;
> +
>  				if (psr_feature_enabled)
>  					amdgpu_dm_set_psr_caps(link);
>  
> @@ -4480,6 +4502,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  				 */
>  				if (link->psr_settings.psr_feature_enabled)
>  					adev_to_drm(adev)->vblank_disable_immediate = false;
> +

nit: stray newline

>  			}
>  		}
>  		amdgpu_set_panel_orientation(&aconnector->base);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 440fc0869a34..fb51ec4f8d31 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -29,6 +29,7 @@
>  #include "dc.h"
>  #include "amdgpu.h"
>  #include "amdgpu_dm_psr.h"
> +#include "amdgpu_dm_replay.h"
>  #include "amdgpu_dm_crtc.h"
>  #include "amdgpu_dm_plane.h"
>  #include "amdgpu_dm_trace.h"
> @@ -123,7 +124,12 @@ static void vblank_control_worker(struct work_struct *work)
>  	 * fill_dc_dirty_rects().
>  	 */
>  	if (vblank_work->stream && vblank_work->stream->link) {
> -		if (vblank_work->enable) {
> +		/*
> +		 * Prioritize replay, instead of psr
> +		 */
> +		if (vblank_work->stream->link->replay_settings.replay_feature_enabled)
> +			amdgpu_dm_replay_enable(vblank_work->stream, false);
> +		else if (vblank_work->enable) {
>  			if (vblank_work->stream->link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 &&
>  			    vblank_work->stream->link->psr_settings.psr_allow_active)
>  				amdgpu_dm_psr_disable(vblank_work->stream);
> @@ -132,6 +138,7 @@ static void vblank_control_worker(struct work_struct *work)
>  #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
>  			   !amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base) &&
>  #endif
> +			   vblank_work->stream->link->panel_config.psr.disallow_replay &&
>  			   vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
>  			amdgpu_dm_psr_enable(vblank_work->stream);
>  		}
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index f175e65b853a..c6d4cca646c2 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -240,6 +240,7 @@ enum DC_FEATURE_MASK {
>  	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
>  	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
>  	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
> +	DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn < 3.1.4

That "<" should be a ">=", right?

Harry

>  };
>  
>  enum DC_DEBUG_MASK {
> @@ -250,6 +251,7 @@ enum DC_DEBUG_MASK {
>  	DC_DISABLE_PSR = 0x10,
>  	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
>  	DC_DISABLE_MPO = 0x40,
> +	DC_DISABLE_REPLAY = 0x50,
>  };
>  
>  enum amd_dpm_forced_level;

