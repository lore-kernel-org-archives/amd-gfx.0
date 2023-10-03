Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAF7E7AD71
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 15:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D408D10E2AB;
	Tue,  3 Oct 2023 15:20:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCBC410E2AB
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 15:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPQ2uZkk1236uuDBXp9ODJ8aVEyWoNhZAjUOmiPyF+hjkJ4vVN6GBuGbeKih5podpJ0jqdDHGdW7ULPCnQaLyV7sMX4PLXg3LptZ8uLRzghpwTimhJgZjEuI8amFWIScaRmKrH4dEZG/5hx0u0tx3fabq31cBJB3mW7BKif8WcsAQ6qo8WZOsu+Rh0CripfIngbFLuplxUAr+WybannNEB3M5ESmpEEtpGzY7nAmN2CSp/M1hUHVT+GvtUrwzyFz4Sz9XqR4xmhLT4R7/LK1JM/5+xPHlz1l5bK3AsdcWIVPLs1VLpBKfUA+Y/98tYEB9kvctc9FDzUSHJupoLsPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxYLijpvb4Wm6t0aZKJzg9TzqKCEsnb02vkKSRAQW1w=;
 b=ksN9qcxmDTRBH0/uQu+WH9CchbHhY57/ZxjPEJgAkb7sbA0e9gaL8fqWBFAUf7thvA6zxCjqLNsCHBOOjsoYF9q4F3ZkCqpyE7I5i6B9iWr/RwnoFgbZDnFkjDlG+efZXMRicWqyd1PAPofA17ZmhiAWnVa4qrbAVMZY3ftUMaX5axyB4F/bNeUQG0+fwV7chFmGeOh+a6bC0un13Ln81ug4HZBXdjNu9G+ZPt/8j7o0Y3qY02MB0pDZfeUtO1249S6WH0iSIXVCJqZdO9qKYaRo3VDAM5c4r16idApBcZpcGmr8AIUBVbdqkmuqVHMWqBPak70N//lBFBFZc/TN3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxYLijpvb4Wm6t0aZKJzg9TzqKCEsnb02vkKSRAQW1w=;
 b=JN+j1QfBs7t/YqYRUBtofU0zb8xi7vH6qw5MSabZLllcwNrTazKJEua8qUz3a4kHAjZ292+Wd1IJessoxbu+uvwml5BUgjXLwVKOew/sCygr+tVz3y2YLBAhch0olYa36QQTEqMeLWnu9AIahE9EkG32vpBBtcS9e4U4yCS2ssE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 15:20:23 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::965c:2865:17b9:fc05]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::965c:2865:17b9:fc05%7]) with mapi id 15.20.6838.016; Tue, 3 Oct 2023
 15:20:23 +0000
Message-ID: <284d3f39-071c-4451-839e-8840aecfc2a7@amd.com>
Date: Tue, 3 Oct 2023 11:20:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for static
 screen use cases"
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231002174754.1596197-1-ivlipski@amd.com>
 <PH8PR12MB7279E1B7634AE630985E4E2EF9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <PH8PR12MB7279E1B7634AE630985E4E2EF9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0197.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::7) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: e3bf39bf-6112-4f5b-4f0e-08dbc424435d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bn7IilMp93Dx5ULyd9h7LJGaCqXq8N5n4/0Y20nWbYOjuLp5XfkBdCu1nRsPIHr2D2NEwc/zapKXA/05BVcVvmGfocLrqAIz+C0sT8zgKa7RnmmrWdT19d+3y2cWnwyk2staCJ7UlRemz2RqIz0vYcmdHzuXMLp7vDThzMqu7PZqdE5VYsBc0HqoSdz3t8CV8nKjtbj79jLF8cavNSfErBRKpAZgx+TzgttwKfoIEhU6uAJDJdacxxTdQ6wUmspjH6E0E7wyltNsAG67Cq9uVCpTYeoomfWxVLC38qSo65VJQebpwD4Xnz8aK+UECX5PzI8R8XjwdDS8++79UJWwdyay2PKsdWlCDScayfMyPMAXXfZPNvE128OYoshgJMLXvFyKQdXppZjwNkLEQnc6jeNvzeB3qJ0EBznQTYzz+mSXoXwZWkbi3NHwp8AN6e5cVNboEk4XtqxdaJx7Q84RNI4OeEgW7RpR83q4tE3K8uKbM/LHF5ImgwJU8sH6uNNUWgEk/m7M+fFC552xV4WDWj9+Mbe6J8XzvgGmFAXa0Os2XuSrNMNxkewc2Xny5/8wyMfZYpCAvGCi3PilQaJw/pzXEFkKlR6HNLc+nEhERjGbS7a0LfD+otoudVMVim1FCRt0ySSDtVlXBSZrGhy5ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(31686004)(53546011)(6512007)(6506007)(6486002)(55236004)(478600001)(38100700002)(86362001)(31696002)(2906002)(83380400001)(2616005)(26005)(36756003)(8936002)(66476007)(8676002)(66946007)(4326008)(66556008)(316002)(110136005)(54906003)(5660300002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rmo2T3g1SFkwU2YxU3Z1ekpRTzRPN2JFNmtweURRdjhDSUtLVHY4eUlKN3Jv?=
 =?utf-8?B?a09BTTl5UEFDVUZMQjNaMEF3d1hTclV1WkZDdk1ERlZkWldpLzNITENtUDNs?=
 =?utf-8?B?bU0rQ2wvNlpibU85ZVBlbUFpaXp1c1p2WHZpSERUYVgyMFJ2ckhzcFRXOXI2?=
 =?utf-8?B?YWdXWVJXNWRsZDFWenpkZ25aUHJ1cVRsaU5RbHFPMWN6ZXo2SWtVNGpWOFBU?=
 =?utf-8?B?ZiszQzlzMUJwZzZ4WDNOYTV3dE5WaWF1ckNKVEc2ZkJXUW5aL1MzaVNPM3BL?=
 =?utf-8?B?V3BMMXdocE5qNkZuSFBBcU5xNnZYYkJ2cThuaEpxVUZvRWNyOU9SeHV2S2VG?=
 =?utf-8?B?VnQwWjZvK25HVnRwQVFtMUJOV0R1THBybjJRMmRWS09iUVh2WjR4SFF3MHNJ?=
 =?utf-8?B?b1UzeG1raEVIVWtPbndWeVpmNW5zQlJDR09vem5WdzV1UHJOeVViaXAxMkhH?=
 =?utf-8?B?bmtVbzFaZTVzZm9aUmpxeE9PNkRuKzVNOVFjUlIwaWYzMHNxaWVlc00xNFBN?=
 =?utf-8?B?SWlPUXFUNDNYcGJ5Z3pYVlVLN0ptUEZjR0xnNDdOSkt3WlBFZUV4NktLNzg3?=
 =?utf-8?B?TmsrMDBMZjUxTC9nQU5qNkxMSjFwOU9RbkdUMHkzbDFhZ1FNK2t0L3dLOVJG?=
 =?utf-8?B?eSt4ZmdxRHREWlpHTk8yMlpvL1h3czI1RzM0UDI1OUwyZzhLa2ZNQ3dGSCt2?=
 =?utf-8?B?NzRQd2sybzVmSW1tVDZMTHlEbGFmMU12S0F2eHRKd1pJQzBrL3VtUENhWDM5?=
 =?utf-8?B?UXJkZW1qU2pGMzE5R0UwTWozOWRXOXh0ZmlTSnVXdWdGdUtXV2hPdWdlUnFP?=
 =?utf-8?B?bnphV0hicUplWUlwaVpZWU9qaWQ0K1NocnFxdUtjeXFyK0VlaDlHLzFHeUo4?=
 =?utf-8?B?Y0hZZmxNUis0WGE2R0UvbHF0aVZaRzIrdXpFQitSUjUram91TytpR0w2eXkz?=
 =?utf-8?B?a0VnQWtvVUpzbHdHOFhOTEJ1TEFKQ25Kb3IwN2NsWXhKaXdVTkZHZnpja0ph?=
 =?utf-8?B?T2l4bW9hb1Q4dCtacjVSQllxV21wazR5Qkc0MTZPSXZNSWpRUXUybEdjZXRL?=
 =?utf-8?B?WEI0ZXhpNmZxczc0MmpGU2lZWU5QYjdlUlhubFI2ZndTQWlXUHFmQklGMkc4?=
 =?utf-8?B?Qi9rMXpWdXp4eDA5bzZZN1U0bGxJQVJWWWJ0TXZ5QmppaHVZSU1GR3RKUGRz?=
 =?utf-8?B?V25JNDJXZmFiSXhTR0tJb2YzWWFEekpuK2RqR0dneDBUN05rNHlZdUhZVUZs?=
 =?utf-8?B?bmRWeGdxRU0zblQ4MGxZMW5GWkhoWk1OcmF2NkNTK0NNS1QyNm9hNFhyaHBh?=
 =?utf-8?B?c081bU5XVmFKSDZ5cHFpSm0wZE1TcDJUOHRmUndTUmhpdlJEZnVqeGtyeWFP?=
 =?utf-8?B?SW9SNUFlT3h5YkpTY2s0Yk95U1lOMVlFMXM0WEVKSG0xb2RzYlJ4WGtwK2xx?=
 =?utf-8?B?dHBFWS8ramhyNSs0djFROU0yOHM2VnhrZi9kQ0lVV3J6UVdhQyt1MXRWM1NL?=
 =?utf-8?B?SUhpYUszaUhaY3dEUUlrLytEdHFZMmlYc09TTGY4OXkxY2Z5VUpnQk40eUN1?=
 =?utf-8?B?cGpkNFpOeStHTHVKczhIOWMxQXlhbnRHd2RoTkI4ZERyQitsTFVINmZPWSs4?=
 =?utf-8?B?NXhVNDMrYzV4VEc0Q3cxQTZjLzZUeFhpbGkxNndOT0ZuRFkvbVJEdGlMWVRV?=
 =?utf-8?B?SmVUOGRQZGlFUzNhbXhiUWQ2bjVWYVpXNjNlZkw3RnA0cjZraEZOYkhrRC9j?=
 =?utf-8?B?NHBXMG5TQ2ozVGRiMnlORVcvdjMzNWN4V1hKZll3c3J6VWpDdUNLNHdQQTYy?=
 =?utf-8?B?ZTZvQ0lmNXlSZ09rVU1nWlV1bU5hRm85K003SnNJWUZ1N3lMZmxvUGVBa0lv?=
 =?utf-8?B?czJ4dnJIU2NSZUpJZWxlYjRTK09RekE1b1JCL3MySklVMTBDRGF4bFlBaEpt?=
 =?utf-8?B?T0R4NEpXUXlSTmxmTEZrcWFaWnZvNi9KUFFEWThTQmdlTzRLSllpQzRUSVVo?=
 =?utf-8?B?NktzK1lnVW1URjV2VGdnN2NXNjgzcG9yREh2MWRzSUlweUZUdlFBL3huWkRF?=
 =?utf-8?B?RE5XTHZlM3UrcENaWldrQ0tSTkhUNTk2ak4vRWtWN2tEekQzcmtNbmpPM1Ew?=
 =?utf-8?Q?1MpE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bf39bf-6112-4f5b-4f0e-08dbc424435d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 15:20:23.2220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKBJk+0jzZuxAAIgKywyrbV9j5vEx2c9qBKWLQzEo71MOpJnV78XzQLRSKB+9Jvm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Chung, ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-10-03 11:13, Lakha, Bhawanpreet wrote:
> [AMD Official Use Only - General]
> 
> 
> Any reason for reverting this instead of looking into 
> "amdgpu_dm_setup_replay()" and "replay_feature_enabled" to see why reply 
> is being enabled?

It causes a regression in amd_psr. Unless there's a quick fix, we should
revert for now. It sounds like this can break existing support for
PSR/PSR SU.

Acked-by: Leo Li <sunpeng.li@amd.com>

- Leo

> 
> Bhawan
> ------------------------------------------------------------------------
> *From:* LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
> *Sent:* October 2, 2023 1:47 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza 
> <Hamza.Mahfooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; 
> Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; 
> Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; LIPSKI, IVAN 
> <IVAN.LIPSKI@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
> *Subject:* [PATCH v2] Revert "drm/amd/display: Enable Replay for static 
> screen use cases"
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
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 -------------------
>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  9 +-------
>   drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
>   3 files changed, 1 insertion(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 32156609fbcf..f69b2e9ecd98 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -66,7 +66,6 @@
>   #include "amdgpu_dm_debugfs.h"
>   #endif
>   #include "amdgpu_dm_psr.h"
> -#include "amdgpu_dm_replay.h"
> 
>   #include "ivsrcid/ivsrcid_vislands30.h"
> 
> @@ -4423,7 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(struct 
> amdgpu_device *adev)
>           enum dc_connection_type new_connection_type = dc_connection_none;
>           const struct dc_plane_cap *plane;
>           bool psr_feature_enabled = false;
> -       bool replay_feature_enabled = false;
>           int max_overlay = dm->dc->caps.max_slave_planes;
> 
>           dm->display_indexes_num = dm->dc->caps.max_streams;
> @@ -4535,21 +4533,6 @@ static int amdgpu_dm_initialize_drm_device(struct 
> amdgpu_device *adev)
>                   }
>           }
> 
> -       if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
> -               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
> -               case IP_VERSION(3, 1, 4):
> -               case IP_VERSION(3, 1, 5):
> -               case IP_VERSION(3, 1, 6):
> -               case IP_VERSION(3, 2, 0):
> -               case IP_VERSION(3, 2, 1):
> -               case IP_VERSION(3, 5, 0):
> -                       replay_feature_enabled = true;
> -                       break;
> -               default:
> -                       replay_feature_enabled = amdgpu_dc_feature_mask 
> & DC_REPLAY_MASK;
> -                       break;
> -               }
> -       }
>           /* loops over all connectors on the board */
>           for (i = 0; i < link_cnt; i++) {
>                   struct dc_link *link = NULL;
> @@ -4618,12 +4601,6 @@ static int amdgpu_dm_initialize_drm_device(struct 
> amdgpu_device *adev)
>                                   
> amdgpu_dm_update_connector_after_detect(aconnector);
>                                   setup_backlight_device(dm, aconnector);
> 
> -                               /*
> -                                * Disable psr if replay can be enabled
> -                                */
> -                               if (replay_feature_enabled && 
> amdgpu_dm_setup_replay(link, aconnector))
> -                                       psr_feature_enabled = false;
> -
>                                   if (psr_feature_enabled)
>                                           amdgpu_dm_set_psr_caps(link);
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index fb51ec4f8d31..440fc0869a34 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -29,7 +29,6 @@
>   #include "dc.h"
>   #include "amdgpu.h"
>   #include "amdgpu_dm_psr.h"
> -#include "amdgpu_dm_replay.h"
>   #include "amdgpu_dm_crtc.h"
>   #include "amdgpu_dm_plane.h"
>   #include "amdgpu_dm_trace.h"
> @@ -124,12 +123,7 @@ static void vblank_control_worker(struct 
> work_struct *work)
>            * fill_dc_dirty_rects().
>            */
>           if (vblank_work->stream && vblank_work->stream->link) {
> -               /*
> -                * Prioritize replay, instead of psr
> -                */
> -               if 
> (vblank_work->stream->link->replay_settings.replay_feature_enabled)
> -                       amdgpu_dm_replay_enable(vblank_work->stream, false);
> -               else if (vblank_work->enable) {
> +               if (vblank_work->enable) {
>                           if 
> (vblank_work->stream->link->psr_settings.psr_version < 
> DC_PSR_VERSION_SU_1 &&
>                               
> vblank_work->stream->link->psr_settings.psr_allow_active)
>                                   
> amdgpu_dm_psr_disable(vblank_work->stream);
> @@ -138,7 +132,6 @@ static void vblank_control_worker(struct work_struct 
> *work)
>   #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
>                              
> !amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base) &&
>   #endif
> -                          
> vblank_work->stream->link->panel_config.psr.disallow_replay &&
>                              
> vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
>                           amdgpu_dm_psr_enable(vblank_work->stream);
>                   }
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h 
> b/drivers/gpu/drm/amd/include/amd_shared.h
> index 314fd44ec018..ce75351204bb 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {
>           DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
>           DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
>           DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by 
> default
> -       DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn 
> < 3.1.4
>   };
> 
>   enum DC_DEBUG_MASK {
> @@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {
>           DC_DISABLE_PSR = 0x10,
>           DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
>           DC_DISABLE_MPO = 0x40,
> -       DC_DISABLE_REPLAY = 0x50,
>           DC_ENABLE_DPIA_TRACE = 0x80,
>   };
> 
> -- 
> 2.34.1
> 
