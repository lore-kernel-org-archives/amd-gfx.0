Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87254E8FDB6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 20:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCFE10E0A1;
	Tue,  3 Oct 2023 20:55:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C0710E0A1
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 20:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hr+rbw0er5pS6rizcDK37hHQgEK34069Kza6d+lXCWMeGJSu2i1i6NrxNmuQ7tHzP7FWS7K2OyNjqqKm8rX1vQ6wdlai9jPK/xAw2NR1Rg0ms3qM/q4YnHrFCaI9/XujjROspkAI0E+ySQZrsTV7vCtUiXsblCoLya76iMY0bL9BAwILPV+dfC3b+UeFnrYz1nViMYOIT3zJrOCERo4msezVYnQ5mjV1tkYGRXaQM/pdirhGddP/xJprcbawzcim6XXGuFmvl8pwIg/dCKTL48/WcRJnBWup2eRO8CzN/kAXCyWLfqLM8SrplUnfB4KNEtp4IZ/PAJf5TrZeO7OTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GbGrKt3+xBwNTUdGhLAAWGiDt+nmrj+wR5w2ZlCa4Y=;
 b=odfcKolP6S1SgsxlNIAQICN27F40d6ahEFJL+kUkmbY6/9xflcI/WloYqU85H1OcDkNdf8CvAV1eD1lA0c/N02RuCtzckNyru4ENA1K/WtLEoZxq/KriBUz/JuptZoxjCoL8aFbrFZN5TAnze9OKO1AZf1kiMn6dZ6QtoXkSq6xQiM3NKtXOs5xVEBrXnTyIZ967MeVol+XOqG1BQq5F1LjA/x0P+L5tPA3Q0CIOaYhar91qaWXzoCqpxG1mZfGHnekj/yhhVlRsBELcLS5CRfPBKVS+CARejC+7xPNqhY4TSsSesCBRnZyPhVBUF1z3l+z5q3XIL65r5qsxv5J7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GbGrKt3+xBwNTUdGhLAAWGiDt+nmrj+wR5w2ZlCa4Y=;
 b=GrqFT4+F1v2xXr+ROgwHIRPezrbCySdeAkkPOx3d/pb/LAGI/sBTsXgW1n2JQ2bmVXArOZ1yhg4Z0mdb4v7n2mgAxPRHPKru8tBVECZ1eZQ/ifTwzN5rIndZzKER8mCr6WgqJPjZ5D6WZIid2vPJuxzUa2MfioWgBpAQtQnUxY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Tue, 3 Oct
 2023 20:55:01 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332%7]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 20:55:01 +0000
Message-ID: <1f307005-7e1b-4d96-ab30-04f5ba0147b4@amd.com>
Date: Tue, 3 Oct 2023 16:54:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for static
 screen use cases"
Content-Language: en-US
To: ivlipski@amd.com, amd-gfx@lists.freedesktop.org
References: <20231002174754.1596197-1-ivlipski@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20231002174754.1596197-1-ivlipski@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::43) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|SJ0PR12MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6efa3a-09b0-4f0f-9048-08dbc45302b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9gJnl9DI49xEJCCFZy3iSJUHrmA9+ux6nBqwJX2utL2SXbYbYB83dRaMDYn2jJ2rWEzu1oKo1U5u0dXgZI49DuxZa5YIr0SA7n4zY0nhuHghApiBmB7MmZ2gQEHFwBloiDeGcYtlgOud6YoH5keA1eAWTxDazQuanmJnG167Ms9zIp9wCTOC8JzAa+kNXR43PqEj6CiLZ7GF8ki6gWXF4ft/e0LSl+40vcpa5nazerwWgvtZ8ryiCiv5lfCXjmDw+Ny79I382g+kbhcWnNFc5HBfUtaEJbzdYUrlWKB4A8cE43iAb4MQOWUMx2Hlu2IhWxC0BBqzeUKo5IA7GZvRkLxFndohEoGh6UVLR+/Ub8zYGQruneqxQ2/z8qB+WJpvQLTtIGzeQkptuglBdUs9V/emXWHOY888N5sT2bvKopGcCjY2iwwMEwn1xWz2GbPq9HL6WhsraalLOvFF7Ra8ATOAL3Avvtg4pcn2aSNzBIDWVoUPJ3W7LsmqNT5tQ39YuvyWqzo/c3tw6Qg+wzVdPqNDjzqNGSYJVRpcn7z94cQ2V7UtpyZEjQZ0ojh3njjtbWp/9HazD5CYbU9wVxzP6gugQEauL0S/ynDWisk/zNmz73nzLd4Tuh+xFTucX9u3IXvuDOpwBsj+WyGg9WIFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39860400002)(136003)(366004)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(44832011)(5660300002)(4326008)(83380400001)(8936002)(8676002)(31686004)(2906002)(86362001)(31696002)(41300700001)(36756003)(26005)(66946007)(66476007)(66556008)(2616005)(6486002)(53546011)(6506007)(478600001)(38100700002)(316002)(6512007)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlZWeDRNb3RBSmphYkhzWWtVOE5wU3NYdzBoMEw0T3NzWHp3OUdFa0VKdjVj?=
 =?utf-8?B?b3ArVDAveGEzZXFFWktGYUk4YU0zSWtrcTV5NjJENDFzQ1RkdHR2dEF0Wkg4?=
 =?utf-8?B?ejhhM0IrUVc5RUVrOUJXWVIxVWsydHJUVWtmc09jaEhXbjdLRldLWHpRY0dF?=
 =?utf-8?B?RDB0REpNaXA0TFkxZUZxb3AzSFhOTUd3aXkrN0dlWG56T2RVR25Jd3JOTFNr?=
 =?utf-8?B?V3dHdFJ1VDdJWUl4SXIrNkZUNzhSM1ByV0IzWUk1QkVhSmJnWHZJVmxGNzcv?=
 =?utf-8?B?OERicmhOcERDazBIampzdmZoUmlRbWxqbnl6QTFJMVZHN0VXNDNDb2lKcFB1?=
 =?utf-8?B?UTFIdlZXUUR4czlkMTFMMFcwVThkbnRzbVhrT2RucmNJM0hRYSsrc3lFVmhr?=
 =?utf-8?B?dCs4cHpCdm5jL2xZTFVqdElWTmpBUnN3ZFdwb3U4R2IwWVI1M2ZxenFuUG5z?=
 =?utf-8?B?YUQ0VFZ4UGh0TWZINUlzMm9wMjh6ekc2d09OSkU5UENUNFM2WkVKdkkvd0ZQ?=
 =?utf-8?B?bDN1OGwvUktCMXB1d3ZXRDdQNHhZOUF3N2dEdlRMN3orWHJkdWxwYU9jRTZF?=
 =?utf-8?B?eEJ1NitTbnNZSjY5WVVJL09ZZFpFdUpQSGpQOUQ2ZDRFZGRPM0owZlhHbE9x?=
 =?utf-8?B?MDlrVVA0V3NBKzh4RjV4K1J1T2F6cXhXN2F5c3hxT2hOa1FMTFU5bUZ3b3Ry?=
 =?utf-8?B?dHdMUlV1Wm5MbDlIc04yczBMd0xRQWx1eWF0RERqdURReTlNT1MrQUNnbXZr?=
 =?utf-8?B?M3UyVjdFTy9RTUoyaW83cUlGUHhSdlFid2hWeTRhRmhSampUSS9Fd0M5aHVi?=
 =?utf-8?B?Wi9PTHJLaWNQWVFvVEd2clBZT0VQbmhMb0xJTmI1VlFiWnJVRkpYM1AzS0Fy?=
 =?utf-8?B?M1N1akFkejJkV2JVbXA5WE9nVmd0UG1KdXFiRCtuMmFLTjYyQmxEaC9mSGds?=
 =?utf-8?B?Nk05SFd1bmJEYlhLUVFFRGNYUlpualBRT1Z6akV3MFAwUWpaMkhacStHNXAz?=
 =?utf-8?B?UEFQbG9zL29kMmZzVW5neXAwZ3c0VUZET2RxSm14WlpNNU9CT3RlL3ZsRjgw?=
 =?utf-8?B?UWd5OVR4QW4rdUpDdzVlSVdSUDFzSDc0bkYydVRDUUtBaDc5aUxCcmJHWmJP?=
 =?utf-8?B?MGs4aGVib1FpUGRJSXJIekd5NnJra0hJTjNVOTE2aVVyNlpOMDFFWS9lMTNq?=
 =?utf-8?B?VmwxL2xKdlQ5UVNBL2dWSzcyNzd1M1B2UVptbzRzdnlWaHdqR1lqYXNzRzJr?=
 =?utf-8?B?bk1KK2dtcVllMGZ0aEU0dklWVVZtWnZ4S29hZkNidTIvalBBSFFoS3d4Vm90?=
 =?utf-8?B?azVDZW9OeFBDa1g2c3RHQUR4czB4WWFxQnFjSTZydDlrTld3RWduanVDUWdT?=
 =?utf-8?B?blRacUlLWlc4eDdnU0NmWjM4NGJrdk9IWFlyUjBZdjduWHpOck0xTHZ4T01l?=
 =?utf-8?B?OXdURXNMYXhMSWtjYnEvZ2xvZWE4eE5iaThoUlFEZkVFa2plZkxieVMxbUJz?=
 =?utf-8?B?eVJlS0trdWJpM1k3dXJ4WUIzbjVCbWIyV1BrWEFVTHNGK0VDUnlXUEhha2Jk?=
 =?utf-8?B?TmlUN0VpUXZCdHlQQUIrcnlaK0hxNWVKSnBJUjh0RXlQR2ZoM0VVL21ZNnhq?=
 =?utf-8?B?cWNZZU9Ra0lkYVhmTUNNU2J6bmZta09EZm15dVd2dnk2bzNRbGlQaEIzcnUx?=
 =?utf-8?B?Q2dVYVpFMXZXaWVXdGxSTVFQdzNSS1M3M0YvTkFGTkU5R1p6V1Q1cHEyMS9U?=
 =?utf-8?B?Q3ZPTnRXb2ZoNFJLNENmc1J5YXp3b2krbzFCbFhMYkdKdmYwMTlGdjhqaUFh?=
 =?utf-8?B?TlgyWG5CU2p5am9TNGdEbW5YclBuTVRDRGREYVJqeGNadzh3cHVnVUhEUXd3?=
 =?utf-8?B?THR0clI2YSsxWVJWUjlBNE1GOCt0Nm03bUtrTlNZd21PN3hyWkE3UVBpcnFI?=
 =?utf-8?B?dS8yM0MzalRTMkhOVXY4bjlucW1pZ3U0d1k3S2tzY21kYUx0cTQ1UEc1VzFm?=
 =?utf-8?B?NXlVSGdQRzF3UDVlcHY5bXVVU1JnT0VUMzNrQzNpSXZHTVBxSSthTVFNZTBB?=
 =?utf-8?B?dFFyVmltcENXT2ZRSlBWTS9ZbnVCMkFQT1dmTmIreUtQR2NuVG5GK29LWFZL?=
 =?utf-8?Q?gm3/YMPzXgKsR2c3rbq6lEKl3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6efa3a-09b0-4f0f-9048-08dbc45302b1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 20:55:01.1454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0n4fxFVeXgBWfq1sZAuovOOQOIHt57vbIgIxX7H7GT67XNebV+8oorfevWzAc408jTap6+6h0uFMeFZccbr5bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7082
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
Cc: chiahsuan.chung@amd.com, sunpeng.li@amd.com, harry.wentland@amd.com,
 rodrigo.siqueira@amd.com, alexander.deucher@amd.com, Bhawanpreet.Lakha@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/2/23 13:47, ivlipski@amd.com wrote:
> From: Ivan Lipski <ivlipski@amd.com>
> 
> This reverts commit a92da5bc33ea99a861f6c422192af6072c145d2d.
> 
> V2: Reword commit message
> 
> [WHY]
> This commit caused regression in which eDP's with PSR support,
> but no Replay support (Sink support <= 0x03), failed enabling PSR
> and all IGT amd_psr tests.
> 
> [HOW]
> Reverted the patch.
> 
> Signed-off-by: Ivan Lipski <ivlipskI@amd.com>

Applied, thanks!

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 -------------------
>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  9 +-------
>   drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
>   3 files changed, 1 insertion(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 32156609fbcf..f69b2e9ecd98 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -66,7 +66,6 @@
>   #include "amdgpu_dm_debugfs.h"
>   #endif
>   #include "amdgpu_dm_psr.h"
> -#include "amdgpu_dm_replay.h"
>   
>   #include "ivsrcid/ivsrcid_vislands30.h"
>   
> @@ -4423,7 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   	enum dc_connection_type new_connection_type = dc_connection_none;
>   	const struct dc_plane_cap *plane;
>   	bool psr_feature_enabled = false;
> -	bool replay_feature_enabled = false;
>   	int max_overlay = dm->dc->caps.max_slave_planes;
>   
>   	dm->display_indexes_num = dm->dc->caps.max_streams;
> @@ -4535,21 +4533,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   		}
>   	}
>   
> -	if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
> -		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
> -		case IP_VERSION(3, 1, 4):
> -		case IP_VERSION(3, 1, 5):
> -		case IP_VERSION(3, 1, 6):
> -		case IP_VERSION(3, 2, 0):
> -		case IP_VERSION(3, 2, 1):
> -		case IP_VERSION(3, 5, 0):
> -			replay_feature_enabled = true;
> -			break;
> -		default:
> -			replay_feature_enabled = amdgpu_dc_feature_mask & DC_REPLAY_MASK;
> -			break;
> -		}
> -	}
>   	/* loops over all connectors on the board */
>   	for (i = 0; i < link_cnt; i++) {
>   		struct dc_link *link = NULL;
> @@ -4618,12 +4601,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   				amdgpu_dm_update_connector_after_detect(aconnector);
>   				setup_backlight_device(dm, aconnector);
>   
> -				/*
> -				 * Disable psr if replay can be enabled
> -				 */
> -				if (replay_feature_enabled && amdgpu_dm_setup_replay(link, aconnector))
> -					psr_feature_enabled = false;
> -
>   				if (psr_feature_enabled)
>   					amdgpu_dm_set_psr_caps(link);
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index fb51ec4f8d31..440fc0869a34 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -29,7 +29,6 @@
>   #include "dc.h"
>   #include "amdgpu.h"
>   #include "amdgpu_dm_psr.h"
> -#include "amdgpu_dm_replay.h"
>   #include "amdgpu_dm_crtc.h"
>   #include "amdgpu_dm_plane.h"
>   #include "amdgpu_dm_trace.h"
> @@ -124,12 +123,7 @@ static void vblank_control_worker(struct work_struct *work)
>   	 * fill_dc_dirty_rects().
>   	 */
>   	if (vblank_work->stream && vblank_work->stream->link) {
> -		/*
> -		 * Prioritize replay, instead of psr
> -		 */
> -		if (vblank_work->stream->link->replay_settings.replay_feature_enabled)
> -			amdgpu_dm_replay_enable(vblank_work->stream, false);
> -		else if (vblank_work->enable) {
> +		if (vblank_work->enable) {
>   			if (vblank_work->stream->link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 &&
>   			    vblank_work->stream->link->psr_settings.psr_allow_active)
>   				amdgpu_dm_psr_disable(vblank_work->stream);
> @@ -138,7 +132,6 @@ static void vblank_control_worker(struct work_struct *work)
>   #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
>   			   !amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base) &&
>   #endif
> -			   vblank_work->stream->link->panel_config.psr.disallow_replay &&
>   			   vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
>   			amdgpu_dm_psr_enable(vblank_work->stream);
>   		}
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 314fd44ec018..ce75351204bb 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {
>   	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
>   	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
>   	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
> -	DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn < 3.1.4
>   };
>   
>   enum DC_DEBUG_MASK {
> @@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {
>   	DC_DISABLE_PSR = 0x10,
>   	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
>   	DC_DISABLE_MPO = 0x40,
> -	DC_DISABLE_REPLAY = 0x50,
>   	DC_ENABLE_DPIA_TRACE = 0x80,
>   };
>   
-- 
Hamza

