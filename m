Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E28ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 16:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 361A310E068;
	Wed, 14 Sep 2022 16:30:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF20010E068
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 16:30:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRB4fV426DGZinb3yhxrmeGcoVsfXmy9yCZbUupUt5608NZEhVEEtL1jPzmdrxLtyDg+vrKKAQ8f61L9gxu3HEMciLpBBIHtRF5s6v1Ut43UZHz0KCxC8po406+oumvZrljySTyFw7XAIusaLj0EUJpbYHl6MwlnCExD5nMS+2GQZBsRK3xuOOqV5PK4JZp1ik2GK07HLuFj7JZr4JjLaMvw/8uPRcikejO/FaTk5Q6cw5MznJj0PK+4KNzIEMu3Td++GxcQTGU01tVRJilZU7RjlB8WQDMIL2ajyCRmJr/C6nGUQtretts/tJe+2ikIjpsX5JhRAq9BUgAEmTwTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grQg1/kv9hvNJSfin/UVIKiN5nwdLW4oDM2mljIGwuw=;
 b=kD7oI0yviDNjCuiH7I6jLF6eKy+CaZvfOpkb7cVbFc+Gao0ed+rsGEN0F4gTwQ+N1anG/qwCA8W+QWtaDgUJh7ZSqUNoUCjMnY7Eb6/ff2/fhMpNOAgyRy2ObSSz6PiXVGVncbZ+LxYpqZ3A226gAT9mYKyUn43IBOw/Tou4CBtniXd6eNGyutqRtZ/JUX1FYdycUDWQz3R34/bMAkg3jQlQrHeGhBxhoZsc4bfxdQb6tKEYjZp4bnFWd/QV3TnF5yObjaC57om07qN1oo/XQhoeC+7ZMwARDJDRfS5BJJ0ZZg6TTGszGn1rt7VnA4foM4R7Z0h25EP9oS3F9d2ccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grQg1/kv9hvNJSfin/UVIKiN5nwdLW4oDM2mljIGwuw=;
 b=fKbo0VWRXLa2RCrqMAT+8RSaQ5+OMFYUc0iBkuhwpJAoYvgG3kpA3CozpaUnRtorp+x9qwLIFFo7RQnDCRg07npJc1rkGvWj+R/TC92C+3x6NcOh3+BrTtHcNkGvzATxBEfxqCBeVfX57Uf8Q9mUIRdG1E6TOBuM24zZU7E3plQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by BY5PR12MB4935.namprd12.prod.outlook.com (2603:10b6:a03:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 16:30:27 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::a833:7969:1f8c:df6f]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::a833:7969:1f8c:df6f%7]) with mapi id 15.20.5612.019; Wed, 14 Sep 2022
 16:30:27 +0000
Message-ID: <c429010f-30ea-7abf-a67a-e730c7a6728d@amd.com>
Date: Wed, 14 Sep 2022 10:30:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 46/47] drm/amd/display: Fix failures of disabling
 primary plans
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
 Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
 <20220914051046.1131186-47-Wayne.Lin@amd.com>
 <604a1d7e-1cd9-ad27-6d37-2e8535ce253b@mailbox.org>
 <40e970ca-c0ac-98b3-0549-2d7b1a812f81@mailbox.org>
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <40e970ca-c0ac-98b3-0549-2d7b1a812f81@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:303:6b::30) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|BY5PR12MB4935:EE_
X-MS-Office365-Filtering-Correlation-Id: 2178ec25-a1a9-4661-a7e9-08da966e6d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RK2+42LKx6m+5mntiWm4xhE9Tr+4l9vrCt1ePeB3+n+2S/TtRyH+AKnoNobhtKX+CTRCOzyqjYkBy5QqD43uT0sBRlZDPGE9pRu6N/l6wnQ2WZm4VBNWLYiKNAmRddW33HXTmWbNrwtY3HYdZuADPPBleBr+c69S7s7BFkWzj7MxXckd584jWx+EX4sec5cZtKGmRMwGLzPDGh+ORxWUn80cidrDBxo7PnyF/VWo+Z/1hEe2hoz7aWyKvqdIX01YZGSedIDSnN/wZfFSiVhwo9VnEhoOs3yx7xfvon3RMp/czTBA3Tw87+M4zghNP2SmTeC5YTyKt1pU2fQU8rUQAIWaTiWwr3AuCrPG0LxC/TAoBjyxdOn53xr6gR4nPkjtIAI4T6WufU9huNmsDN49k44R6xzR34T5d16FtgFZBFmWIVFxGcDdpwW7YZWYISWNpbs9OahXxGcwDyVVU5xDv7n/T88A0Txu6xBPJ/MoeG96ypmP01YbuSYDye5C1yGh4Af7vq0SlBeLvwVJfhz1xRDspzzSFJ8jDOyTqbI+R0st9TspkhSZcZUEQPL8RmT/V6NEHQ5zUIQINXq4WedhDCs21MFCK/cXQt9H0yVTJ/rvBgDVIJdVolWDLJHfYgotcYyK/tv4uQXTKMImg1P3qLpQLl6SWXEFh5fr0WB9VvRPQjRyHi4SnqdSHy2S+w5/RpgRrTfJ8ZqMiLijp77MCMBwikqsFZQ5su+1+UHpZGE5gW9o7vCpk4Fczx7LNZgL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199015)(8936002)(86362001)(83380400001)(6666004)(6506007)(186003)(110136005)(6486002)(66574015)(5660300002)(966005)(316002)(31686004)(66946007)(53546011)(41300700001)(2616005)(2906002)(6512007)(31696002)(36756003)(4326008)(44832011)(38100700002)(66556008)(8676002)(478600001)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ky9CMlRzaUpnZGhGMFAzWlhhQTJqcnlRc2NhbHZiYzNKZXBLYjRlbElyTWRE?=
 =?utf-8?B?S0Z4NkJPbjR0Zlc0QmFIZHBzcVpSVjBVL3h1L1NFcXlPUFlyRjdGRkc4M0dJ?=
 =?utf-8?B?RStPVG5yUFZ5NHovNU5QOTRWM2tSbklPdW5LaHpCVVdzbnRPeHRBSmFLNDBE?=
 =?utf-8?B?SzhPRWpNU0V5N0poYTR6TW1kR1dzaFBlMVBnU0VkUFRFV0xIVkhmbWp6YXdF?=
 =?utf-8?B?Y2ZWSVFKdndwSDQ0eTZrUFBZdVk3Y3RJSXlUV0NaZlRpNis3TGM5SzIzTVBC?=
 =?utf-8?B?T3BrWlk5L0lCRytHaU1nT2p2UzBJeXFNc3gzODUrRjdSV2UvaWRxMzJqU2Qv?=
 =?utf-8?B?THBmaFVGdysrRFBzbHg1SHNnREo1aFhLMGRJQ3FPQk5nNVFnQTJEbnhTemlw?=
 =?utf-8?B?Y0J4VGNYdGxuMndFQTZtRFhLc2VSWldEMHZaeXlBZ1ZsQ2xqOGNKOWlTWHA5?=
 =?utf-8?B?U2NGS0JmREVGaVRocncxQzh1NmhWMkhlOVJZNk04NDVjWENCTUUvQ2FaNGFq?=
 =?utf-8?B?STFIckQ2YjZJUkFzS1dmMjh0d1FXdlVicW1xdm9kbkFvTW5lRHJTWFpqV1lX?=
 =?utf-8?B?YzlNOCtHMXBJRUF1d3pDWWdDSFlhT2ZRNGlwQnJZUFBEWkF3N255QTBJdm1l?=
 =?utf-8?B?eHZUN0J5dSt4OGQwd0FGYjdkS2REdVMzNUZ4QkxrQW1nK2xwWXJFK093WjRs?=
 =?utf-8?B?QlFIQlNQTHlZNld2Y05hUnJTSnlKZG1lWCsvZWhmckdtallGUnZwdjNteng3?=
 =?utf-8?B?ZytCejdCWlBhY3UyMWRDN2RSS2FyQTFwb3FURzJMdVZFOHpZV3NQdTdmYTZk?=
 =?utf-8?B?Z0dZdy81MlJOTlliZmkyeUdyMHV6b0plRm01a2ZtU2tZd0hvVjQrRlZQSU1B?=
 =?utf-8?B?dnRWQ01uZHptZWwxQTBLZk9UdlpkbVViSWdOWGJrUXY4NzNIbWlVUDlLWlJx?=
 =?utf-8?B?alFJek4rcjlPOTZ3Ykh5b0hDUEpib25rSXJBVEpyM2N5SnpqVDFBM3VHcTRJ?=
 =?utf-8?B?ckIvZGtJK3k5TEZOa3hLREZpZCtXTkRlT21lRzVOSVhMVnFXMXRaSU9XOHVw?=
 =?utf-8?B?cWdKeWNlV2dRYzNJVndOekJxZkU0VnVzSVVkRUJrMG9CNEwwUkRxa1k5b3hW?=
 =?utf-8?B?UWZ5YlI3QlJMeVd5V2dRaEtvRHN2eXI5NGdGSkJySkVrQlNXMTVDWGRQSTRR?=
 =?utf-8?B?bTJMY3BEUmF2YzVCZzBXcUtZV0dXSnJjWTFHSWlzT3ZWYUJCMVBnRHA0Y1Yw?=
 =?utf-8?B?YXhiUDl3Ujh4OGpjdEE2MGVVN25CMjVYM1pZN24veVlOTm1QVjY5WFBxdlU4?=
 =?utf-8?B?bldRSHNUZDZkOGcrNWVCOVNNNXBWc3VWajRIWDBIbE9iTVRmS1ZXb3EwRUhD?=
 =?utf-8?B?Ujh1dlVVUy9mRUxLNGZkSHRvNEZRQzNIWVZMZzJORXA0ckNsZm85d3h3UkFt?=
 =?utf-8?B?Ky8vcU5ENjJTVW9kYUZlVTQyWkNQS0lQQjFHKzhzcVlXZE4waVR0cFlEa2Ez?=
 =?utf-8?B?SXg0ZE81SHk5S3hFQWhaSWw4M1hVODlINFhpR2NBdnJhWW00T0xuWk1ub01C?=
 =?utf-8?B?K0Jvc2FUS3pVSWNPY2xrNXZyancwb0lRcUdwTHJtSHBXTjJ1b0ppU0FJbi9v?=
 =?utf-8?B?RHY5WmZGSTREYVcxcm92ZG9IZ0dLZEZlR0F1TVljV2N2TWVaRkNDdklvUHhI?=
 =?utf-8?B?cXhLOURnaUhlaU05bjh2TklVY0IxcW1RdnZXSkl5b3pQQWZ4MXYvd1lBdXQ1?=
 =?utf-8?B?aU5XWVdUM0xYaVlPQkFGa1lsZEwwMzhVNVpleWFnZmczdTkvYWx0enllUEZr?=
 =?utf-8?B?RWZxNWlFeFV3bEJZcFBxRU1Bek1ZZll6QzZzMjVjVzI2ZnVibUx0aTd1aXA2?=
 =?utf-8?B?S2JrN2ZqNnFabUZpYlFScEV5b3Z5YnRvbmZhZkhFVFZTVTZoeDZnQy96cVN1?=
 =?utf-8?B?d09kS1BxbFcrcG56YjJlMmd4SlVjQmE1S2ZSOEpHN2g4L2plYUJaSzNETExB?=
 =?utf-8?B?NnBKSDIwZ1NISUErZHN3bVFLS3RMTjdqZWxDb2F3MUNjTkRGWUN0d0N3WENs?=
 =?utf-8?B?S1hDQ05sVjlIWWwvb29IYmpOb0hEMnNNbWFtcDY5aS9helNpb2VSalZ6d0dB?=
 =?utf-8?B?dUNwRTNYRlgrVnZQSStxZVNYMUoxSDZLSURBTzh3Rm4rSEdMaE5teksvK21w?=
 =?utf-8?Q?SCDaGC9J9rjQG6bvTxQq01aTcE4jYrd0yUbmviXcICqY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2178ec25-a1a9-4661-a7e9-08da966e6d6d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 16:30:27.4223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkGerD1C8Xr6Zz3fe30XdzXijc43j/KZrlx/eU0X74hkSPFQghHgd2WmAENL8fjrE25XMhOY0ujI7+9vlEMjNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4935
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-09-14 07:40, Michel Dänzer wrote:
> On 2022-09-14 15:31, Michel Dänzer wrote:
>> On 2022-09-14 07:10, Wayne Lin wrote:
>>> From: Alex Hung <alex.hung@amd.com>
>>>
>>> [Why & How]
>>> This fixes kernel errors when IGT disables primary planes during the
>>> tests kms_universal_plane::functional_test_pipe/pageflip_test_pipe.
>>
>> NAK.
>>
>> This essentially reverts commit b836a274b797 ("drm/amdgpu/dc: Require primary plane to be enabled whenever the CRTC is") (except that it goes even further and completely removes the requirement for any HW plane to be enabled when the HW cursor is), so it would reintroduce the issues described in that commit log.
> 
> Actually not exactly the same issues, due to going even further than reverting my fix.
> 
> Instead, the driver will claim that an atomic commit which enables the CRTC and the cursor plane, while leaving all other KMS planes disabled, succeeds. But the HW cursor will not actually be visible.
> 

I did not observe problems with cursors (GNOME 42.4 - desktop and 
youtube/mpv video playback: windowed/fullscreen). Are there steps to 
reproduce cursor problems?

> 
>> If IGT tests disable the primary plane while leaving the CRTC enabled, those tests are broken and need to be fixed instead.


There are IGT cursor tests fixed by this:

   igt@kms_cursor_legacy@flip-vs-cursor@atomic-transitions
   igt@kms_cursor_legacy@flip-vs-cursor@atomic-transitions-varying-size

It also reduces amdgpu workaround in IGT's kms_concurrent:
   https://patchwork.freedesktop.org/patch/499382/?series=107734&rev=1

The change affect multiple IGT tests. Adding amdgpu-specific workarounds 
to each of the IGT tests is not an ideal solution. If the cursor 
problems can be reproduced, a more specific solution can be developed.

>>
>>
>> P.S. Per above, this patch should never have made it this far without getting in touch with me directly.
>>
>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> index c89594f3a5cb..099a226407a3 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> @@ -376,18 +376,6 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
>>>   		return ret;
>>>   	}
>>>   
>>> -	/*
>>> -	 * We require the primary plane to be enabled whenever the CRTC is, otherwise
>>> -	 * drm_mode_cursor_universal may end up trying to enable the cursor plane while all other
>>> -	 * planes are disabled, which is not supported by the hardware. And there is legacy
>>> -	 * userspace which stops using the HW cursor altogether in response to the resulting EINVAL.
>>> -	 */
>>> -	if (crtc_state->enable &&
>>> -		!(crtc_state->plane_mask & drm_plane_mask(crtc->primary))) {
>>> -		DRM_DEBUG_ATOMIC("Can't enable a CRTC without enabling the primary plane\n");
>>> -		return -EINVAL;
>>> -	}
>>> -
>>>   	/* In some use cases, like reset, no stream is attached */
>>>   	if (!dm_crtc_state->stream)
>>>   		return 0;
>>
> 
