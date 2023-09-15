Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA6CCD379F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 19:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C61310E085;
	Fri, 15 Sep 2023 19:52:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A6710E085
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 19:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfXXPccKhZPxj+3N+QsBHmxSMTi2lWXlM/aHXS+/2w2ok0c/YgvgJf3/zXbq0KFO9OOAPEAMmaD39KhF2ZhQmiipBarMhBRv9zQeZ3M/lROAeBQd9IPzNWrLYVGQPnWfOM+T8a88H6JBEiK879a0oOV5j8p/3Y02hMSbLmHb0SdDhMiZCiw7zPOuesQ+z73ZKwfUt5zKXBJH1EO9fyB7ZHwfbjS7qS04gD/p/Voni4zvZmCXl382g5kWgea4DSH66Gwib4BejDe6EczUoIgzOvPQLLH3YLK0VQv5ZIb8KAGigsFd2Jg6FLNLkvPTa9ZgNDe3ngqkvc5arME0dRe9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxchGbrIsEs31D9pzI6TH9sVOzMZbvwcc/o++1KVS8M=;
 b=S2bl1hP/4o2DOYvMzyxJ2KCfb1/zReActBsdxoz2d9fEW/u0VJZaBIFeMZZxd1NWPp+93OJe1PltXEeQRFD+ofwYuZdtYKYSqQC9qGbsgGy/4eizSAZnUpt4WkTyjiHkRXzJvw1qIFPq0gE8g7lKB4AzC1wCwti54FcovC9NCnsxvyjWeUHhL454XBPyKszl9xYyMC02s3+PmoapCxMK+njrPUFFUTiRvRAtHiCU4G9lsLa9JAN/xAZgu0OV4pOlyDI1RknCj2vTh/07LfzqzFIZgg+nfvA8i0VrWFkVUyeozWnvIvm3k5kpX8s5sgR56nELeTbbvvVMBnbvUTqAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxchGbrIsEs31D9pzI6TH9sVOzMZbvwcc/o++1KVS8M=;
 b=taymLAiLfvN65Q7UeV5//s6OBS4R8DeDsyymbZ6/TVDcwd8iz5RV5lSZzeDjKqbiOr0v15hHQh9+XrlY3n8SquLENttIULXyhYaL5RbzJApZBdQhHtm1YORSl7+fSfJoDPrPNydSUqk0wVGC1O1WHzKQ4j6x/lUANtfpDnMEsuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 19:52:42 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f%3]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 19:52:42 +0000
Message-ID: <eb9b3ad4-b4f6-46e6-831a-a073ff043849@amd.com>
Date: Fri, 15 Sep 2023 15:52:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amd/display: Hook up 'content type' property
 for HDMI
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Melissa Wen <mwen@igalia.com>
References: <20230912160157.107975-1-mwen@igalia.com>
 <20230912160157.107975-2-mwen@igalia.com>
 <CADnq5_PAnv6JVfEhe0OEKhecosshVc-wrHR4pmr-+n0tNsWSwA@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_PAnv6JVfEhe0OEKhecosshVc-wrHR4pmr-+n0tNsWSwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0297.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::22) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e546f7-db5c-46ce-76c1-08dbb62552d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pr5wsrBdw5z/QmYJhZ9a3RO3kylbAJFNI+vHipxEWAICl4Y4cVS+90ujOrlDQBVzUhqbtYF0mkyPbl7y9N5Ljt/sln2jWX9ZlVut7sT3bSH5YoLmbwz/yFjk7ynSg7xoH4FnnCDkr4QNKsocQCobs6uZtdhmjjOiInfPijBCvnonjLljpwM+lWIV3XDm1UYCHobpL8ZKQfqqhDW4Wk1LeTofPxrBn7JBZ8pdxD33o3f7SyoaGLvUm+4RdnTAHDKjY3zbgkfnZcVM0DU7O299aC0ro+PHq+NZkYXcxbNBwXllJQ3xQMocDo31qsK7XSyro5q+yU8rOJaVnYavIjPIOFFpYKooKkVZoQXkkFdTkWdciRI627UojakEDsyquO+5fwmpAX4MbDYp6ZuGMv9JFwm5wschwg6qcpo9uGiNbQDliiS6MK1Xda0KQRN/XNWxcS1yC0fyyFHDdCFLV5sAXfWUeOsNaoWX8ZyWxJiavpElUxTVN3GZh7kO3PgIfu+QKpabW+Ap/rGK0rWhqkJJhSOyvj5dqG+J2/8vRxMPVtdj0mIz+RXLI7GciMvOvvxUllLZcDcuQPiQk8vaZRPOWGpkZWXcQxKA5XuXEBaCXSEowrvNjDCpF1MvMvRirYch9GwFoeN5D2kt41+7ssL4kuWHeOXDz36LwG8q/5wf0nVVXp2H2YbL7R9J9+x8ItGqpFYangfYaBJXNfZFACa5vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(1800799009)(186009)(451199024)(54906003)(110136005)(6666004)(66476007)(66556008)(66946007)(53546011)(44832011)(6506007)(6486002)(6512007)(316002)(478600001)(31686004)(41300700001)(4326008)(8676002)(5660300002)(26005)(8936002)(36756003)(38100700002)(2906002)(2616005)(86362001)(31696002)(83380400001)(52103002)(158003001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjNrQ0VWOElDcFo2ZzQwZmVnR1k3dUJQVHFRTURqUWw4N3B1NE90Q2JwbVBh?=
 =?utf-8?B?MGY0a1Y3MUtaRTFycW1DMnpWMGVjTmpWMHI1S01jbTNCelkzVVE4aFIvTExv?=
 =?utf-8?B?eXh2VXJOQ3d2c1F0RTdRMHJqcGtYM2xCWGFqOFE1TDFWbFFBS05CRTQ2MktF?=
 =?utf-8?B?Q1M1VDBhbFArOVhqdmtkcTN6WUk2L1o1eUJwUDVEclpiYU1lUVdtaUxLT2JB?=
 =?utf-8?B?RlFFSktZbDZ3QUN5OXAvWEViQ1NFSTBqTTdwU0xvUHdGdFhkNkdWVldaWWpH?=
 =?utf-8?B?VDRuaGRhM0U5Nk93anRpUnhoS2FncTZNY09BQWJzNGlGL3N4bndzZk5PL3pY?=
 =?utf-8?B?L0NEbklPQ1ZkRVVXU3pPZ2RYNCtITzZsN1FFYTAwNkthQWk3cHRtZUtIdDVD?=
 =?utf-8?B?SFc2TnNDbWpXR2ZwUG1YWlZaQ2VEdkdTUkN5bVlhSFE3RWlyZmx0NDkwWjZ4?=
 =?utf-8?B?aDF3ZVhLTkxTSjNjaDJlZXZZM2tiNVhCMDlnRWFkcUtwL0hzSlJlR0h5UERr?=
 =?utf-8?B?SlV0UllUNWk5Sm9MNWpMNG1oMmR1UVIrRm1sMDUyYlZGZmxoR205NkpvazBm?=
 =?utf-8?B?K2QxVk9GNXMxODVDeDl5VENudk0vVzM3SjlvbWczUUFtMy9RdW9FMXBKOU50?=
 =?utf-8?B?WlFhOG5lQXQ1d1RFY1FRME5KamM4ZXoxMmVLbkJwdzNwT21FakxYbW1rMmR0?=
 =?utf-8?B?ZStRZVBrTDdRYjdUVzhGUFNCZ1dzQ1BEZGQrNFJzQWdNWE1hOUlvMHo4bHBl?=
 =?utf-8?B?R3NLYms2ZndCaC9XVjl5VlpGNFh5OW9mcnZ0L2xzci9oQVJFSVlFVGdFRTN0?=
 =?utf-8?B?VTZjalozU21LbXdIRTVzQjNoUGgzdy96NlczczcvUkxIR3FZc1ZaejNXRG1L?=
 =?utf-8?B?M0tIUFVpVnVmNHNlSHZmUVVrWVVaWU5EVkRvSUtsUTVDejRvb0hQZ3VPTTEv?=
 =?utf-8?B?RlFxSlZLLytFQU03VzV0YzlVV1FLZUVzbE8xVTBhMVhtOUZib0dUWUsxYktV?=
 =?utf-8?B?Zy9tV042NjJsc2NQcmo3UXRXU0VPUEFtY3Q3ZUtRam40MDU2Mk5pOHp4czFX?=
 =?utf-8?B?TXJnUGozVW5uQXZkR0JTQllGYnFhTEE2aFhldituZnQ4c0NnN0F6T1RGWFdJ?=
 =?utf-8?B?WDhqbUFuM3UxZjUxUTNMMU1JdEk0VGNJSUJnZDNCNHRJQXFnakszTEpUWVRw?=
 =?utf-8?B?aFFYcVZqdkMxbnJiaWN4N1pjNjEzZUpWZnhVYlJCM00yalFWeVh0cHM2UFhZ?=
 =?utf-8?B?OEtjUFdVZGw5WS8xdzBTR2lXSjZiMWVycFFncWxZVTRDTm9NdGM3NnpHbjdl?=
 =?utf-8?B?Zk4vQXVpSjJWZmt1TUszekk3cjRaaTl1NUNEd1p0MVMvdFg2MWc0ZFI3L0lv?=
 =?utf-8?B?UHcvOWpJRXA0bXFCZnpCRFRMb2pwMkF2eFFCeGpmWllJS3BSSFA2bUk3aXJz?=
 =?utf-8?B?eVYrWXROS1pPUWFlM3MwbmRYRWd1T3A3c0VNVFJ0YytwUzljV245TGYvbHJp?=
 =?utf-8?B?SnlxMHU2M3YyWk13bDY4YVNmUDUxM3BnN0VSUC9USG5QRTExb3BLNktwaHVR?=
 =?utf-8?B?WFYveUc3ZUxJbml5MTBNZHJVYVBjNGlqZXFtODQ3eEVpYytuemVNSFRjUi9L?=
 =?utf-8?B?UmRjeW40cS9XYk93UGdwL1VmMDQ2bFErZEJiVVBGTnNVblUxTHBIN1lWc1lQ?=
 =?utf-8?B?S3JSeTdpWExoaGRQRUNaUDBMQjhJekZoR0lNN2NJSnV1VVZoWnlST0xsR2dm?=
 =?utf-8?B?Yk8wZnhUckdTMmFCOU5LVU5ja3lWcW9LYldTVHJtZTgxZ2F3dXN3blJyYWNo?=
 =?utf-8?B?ZGxxMkZYcWw1MEN0dDN6NzBrNEZ6R1JnQmY5ZzJ1OHVCSTNFVlJZc3phdENH?=
 =?utf-8?B?M2J3b0YvRFpjeXRsbWliK2hGY1Vlb3VneWE1VVRYNUtuZ3Bhd29UQ2FLN3lT?=
 =?utf-8?B?bkQ4ZXJ4MDVWbExHMmZ0OXh1WTlpZyttZm91M1JHZnVrZVFpajMxMXdNTUxV?=
 =?utf-8?B?UHRwVldYNGFEM2l0eDM0aWR2dlU4ODVtQ0szLzZja0p1QUs5eDZ4SnNjcVBx?=
 =?utf-8?B?NDYyY3M0eFZ5ZVlMN3ZrcWVLWm80MzAybFpBTFl0TkRwZUZpN2o1N3U2R2ti?=
 =?utf-8?Q?uuG1t2CjLbXa6sElm0/sLe5RL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e546f7-db5c-46ce-76c1-08dbb62552d5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 19:52:42.4576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7bGClZhVBBADTx/hzEd+BX9xF5fmnhfgJOsdE7rLtEOHweU1beD81f8QX+NIc8ozUkefhKZxzdGxWUC3HrXsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, kernel-dev@igalia.com,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-09-12 13:19, Alex Deucher wrote:
> On Tue, Sep 12, 2023 at 12:02 PM Melissa Wen <mwen@igalia.com> wrote:
>>
>> From: Joshua Ashton <joshua@froggi.es>
>>
>> Implements the 'content type' property for HDMI connectors.
>> Verified by checking the avi infoframe on a connected TV.
>>
>> This also simplifies a lot of the code in that area as well, there were
>> a lot of temp variables doing very little and unnecessary logic
>> that was quite confusing.
>>
>> It is not necessary to check for support in the EDID before sending a
>> 'content type' value in the avi infoframe also.
>>
>> v2:
>> - rebase to amd-staging-drm-next
>> - mark CRTC state for reset if content_type differs
>>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com> (v1)
>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>> Co-developed-by: Melissa Wen <mwen@igalia.com>
>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>> ---
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++
>>  .../gpu/drm/amd/display/dc/core/dc_resource.c | 69 ++++++-------------
>>  drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
>>  3 files changed, 54 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 5efebc06296b..811e2223f643 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -5461,6 +5461,24 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
>>         return color_space;
>>  }
>>
>> +static enum display_content_type
>> +get_output_content_type(const struct drm_connector_state *connector_state)
>> +{
>> +       switch (connector_state->content_type) {
>> +       default:
>> +       case DRM_MODE_CONTENT_TYPE_NO_DATA:
>> +               return DISPLAY_CONTENT_TYPE_NO_DATA;
>> +       case DRM_MODE_CONTENT_TYPE_GRAPHICS:
>> +               return DISPLAY_CONTENT_TYPE_GRAPHICS;
>> +       case DRM_MODE_CONTENT_TYPE_PHOTO:
>> +               return DISPLAY_CONTENT_TYPE_PHOTO;
>> +       case DRM_MODE_CONTENT_TYPE_CINEMA:
>> +               return DISPLAY_CONTENT_TYPE_CINEMA;
>> +       case DRM_MODE_CONTENT_TYPE_GAME:
>> +               return DISPLAY_CONTENT_TYPE_GAME;
>> +       }
>> +}
>> +
>>  static bool adjust_colour_depth_from_display_info(
>>         struct dc_crtc_timing *timing_out,
>>         const struct drm_display_info *info)
>> @@ -5595,6 +5613,7 @@ static void fill_stream_properties_from_drm_display_mode(
>>         }
>>
>>         stream->output_color_space = get_output_color_space(timing_out, connector_state);
>> +       stream->content_type = get_output_content_type(connector_state);
>>  }
>>
>>  static void fill_audio_info(struct audio_info *audio_info,
>> @@ -6795,6 +6814,14 @@ amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
>>                 new_crtc_state->mode_changed = true;
>>         }
>>
>> +       if (new_con_state->content_type != old_con_state->content_type) {
>> +               new_crtc_state = drm_atomic_get_crtc_state(state, crtc);
>> +               if (IS_ERR(new_crtc_state))
>> +                       return PTR_ERR(new_crtc_state);
>> +
>> +               new_crtc_state->mode_changed = true;
>> +       }
>> +
>>         if (!drm_connector_atomic_hdr_metadata_equal(old_con_state, new_con_state)) {
>>                 struct dc_info_packet hdr_infopacket;
>>
>> @@ -7430,6 +7457,11 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>>                                 adev->mode_info.abm_level_property, 0);
>>         }
>>
>> +       if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
>> +               /* Content Type is currently only implemented for HDMI. */
>> +               drm_connector_attach_content_type_property(&aconnector->base);
>> +       }
>> +
> 
> This could just be squashed into the clause below.  Either way, looks
> fine to me.  The series is:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 

Series is merged.

Harry

> Alex
> 
> 
>>         if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
>>                 if (!drm_mode_create_hdmi_colorspace_property(&aconnector->base, supported_colorspaces))
>>                         drm_connector_attach_colorspace_property(&aconnector->base);
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>> index 494efbede0b2..5810cf78cf29 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>> @@ -3928,14 +3928,9 @@ static void set_avi_info_frame(
>>         uint32_t pixel_encoding = 0;
>>         enum scanning_type scan_type = SCANNING_TYPE_NODATA;
>>         enum dc_aspect_ratio aspect = ASPECT_RATIO_NO_DATA;
>> -       bool itc = false;
>> -       uint8_t itc_value = 0;
>> -       uint8_t cn0_cn1 = 0;
>> -       unsigned int cn0_cn1_value = 0;
>>         uint8_t *check_sum = NULL;
>>         uint8_t byte_index = 0;
>>         union hdmi_info_packet hdmi_info;
>> -       union display_content_support support = {0};
>>         unsigned int vic = pipe_ctx->stream->timing.vic;
>>         unsigned int rid = pipe_ctx->stream->timing.rid;
>>         unsigned int fr_ind = pipe_ctx->stream->timing.fr_index;
>> @@ -4045,49 +4040,27 @@ static void set_avi_info_frame(
>>         /* Active Format Aspect ratio - same as Picture Aspect Ratio. */
>>         hdmi_info.bits.R0_R3 = ACTIVE_FORMAT_ASPECT_RATIO_SAME_AS_PICTURE;
>>
>> -       /* TODO: un-hardcode cn0_cn1 and itc */
>> -
>> -       cn0_cn1 = 0;
>> -       cn0_cn1_value = 0;
>> -
>> -       itc = true;
>> -       itc_value = 1;
>> -
>> -       support = stream->content_support;
>> -
>> -       if (itc) {
>> -               if (!support.bits.valid_content_type) {
>> -                       cn0_cn1_value = 0;
>> -               } else {
>> -                       if (cn0_cn1 == DISPLAY_CONTENT_TYPE_GRAPHICS) {
>> -                               if (support.bits.graphics_content == 1) {
>> -                                       cn0_cn1_value = 0;
>> -                               }
>> -                       } else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_PHOTO) {
>> -                               if (support.bits.photo_content == 1) {
>> -                                       cn0_cn1_value = 1;
>> -                               } else {
>> -                                       cn0_cn1_value = 0;
>> -                                       itc_value = 0;
>> -                               }
>> -                       } else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_CINEMA) {
>> -                               if (support.bits.cinema_content == 1) {
>> -                                       cn0_cn1_value = 2;
>> -                               } else {
>> -                                       cn0_cn1_value = 0;
>> -                                       itc_value = 0;
>> -                               }
>> -                       } else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_GAME) {
>> -                               if (support.bits.game_content == 1) {
>> -                                       cn0_cn1_value = 3;
>> -                               } else {
>> -                                       cn0_cn1_value = 0;
>> -                                       itc_value = 0;
>> -                               }
>> -                       }
>> -               }
>> -               hdmi_info.bits.CN0_CN1 = cn0_cn1_value;
>> -               hdmi_info.bits.ITC = itc_value;
>> +       switch (stream->content_type) {
>> +       case DISPLAY_CONTENT_TYPE_NO_DATA:
>> +               hdmi_info.bits.CN0_CN1 = 0;
>> +               hdmi_info.bits.ITC = 0;
>> +               break;
>> +       case DISPLAY_CONTENT_TYPE_GRAPHICS:
>> +               hdmi_info.bits.CN0_CN1 = 0;
>> +               hdmi_info.bits.ITC = 1;
>> +               break;
>> +       case DISPLAY_CONTENT_TYPE_PHOTO:
>> +               hdmi_info.bits.CN0_CN1 = 1;
>> +               hdmi_info.bits.ITC = 1;
>> +               break;
>> +       case DISPLAY_CONTENT_TYPE_CINEMA:
>> +               hdmi_info.bits.CN0_CN1 = 2;
>> +               hdmi_info.bits.ITC = 1;
>> +               break;
>> +       case DISPLAY_CONTENT_TYPE_GAME:
>> +               hdmi_info.bits.CN0_CN1 = 3;
>> +               hdmi_info.bits.ITC = 1;
>> +               break;
>>         }
>>
>>         if (stream->qs_bit == 1) {
>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
>> index d5b3e3a32cc6..d4224de13138 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
>> @@ -212,6 +212,7 @@ struct dc_stream_state {
>>         struct dc_csc_transform csc_color_matrix;
>>
>>         enum dc_color_space output_color_space;
>> +       enum display_content_type content_type;
>>         enum dc_dither_option dither_option;
>>
>>         enum view_3d_format view_format;
>> --
>> 2.40.1
>>

