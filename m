Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE83C25B50
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jan 2023 00:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 101D510E209;
	Tue, 24 Jan 2023 00:24:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BC210E209
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jan 2023 00:24:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APIVoFmo1UMS5wqJarfSugGDISm9iGpYH4w+c5tOZBLePeTEkkipaTYd9OjDu6VfFO6tyufANQvvCHviQ98IfOOA/II7yXe21H7FCYwp0fiXIqZXXKhJ3bEmBrHOhOnX2osAtaq0YMrArKXV5437luvqJJpiyyCDgWamRoHAOhIQtsaqkVj77fjksR2MFEDiz4sQuVLHpjkIYp/6+Nb5bhQklAHvRIzCR014BeO9ZFzV+zQsR50pyHhKuhH7qTZbNSg9Tv99/LRCGg6wQasqhFZbEXz1zXpQoitDRG8k4/pltB5XWVwbQg++0lBlGGnDnGHq6OBVadIK8p6/FcSJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFT0ma2iURBg4xgJu9CdI9nppKXCqsXExnmSERK8TCY=;
 b=PaTuloNKBtqM4LtrOUKG+M8M5Vnk7jz5Hxfr5LlQNgbDkhAGyj/EvJt834H8fwBF77y5acvOK2UcM5ptA67qwQTxZN0KC4Zo734Kllgd5GFepT/u+fNnwujb8fOxO95+tpqRKsezYNhHn2G15M+kNRCyv5CuPzNX1IwSQAuqWQJnQL/Evfvze3ketHgq6rsPBgfrNlNbXOT4eVaV4HhUmDY0I6q9sTCtMjqUQ4mIJwOWlC3GT27aJ/O6ePGo+elhtdM3FWY89qEr+R+bPMyNGjLnZisfU24IJmOYWGmlcCdsfez428689z3JGIMhLQNjL+4wxXA5YxseJ19olNb5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFT0ma2iURBg4xgJu9CdI9nppKXCqsXExnmSERK8TCY=;
 b=qboDYkTEUWfE7qV5fszG8URK7bMYvusI7AGkRQ2Fk/igPyKAYEoB2/cxKvx4umBPPWshtXUvt8XPlZQo6B1Th2nyHKE8xWztkncFhLHo/cVEks+9phNLVaPN612K0XyNEoJCBY8ApaNt7GbvlMXI3tNLdJDUaTPotKJX7IBXKO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 00:24:23 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::152b:e615:3d60:2bf0]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::152b:e615:3d60:2bf0%6]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 00:24:22 +0000
Message-ID: <208bc529-d954-ab89-17ac-9b01acd93cc5@amd.com>
Date: Mon, 23 Jan 2023 19:24:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Hook up 'content type' property for
 HDMI
To: Joshua Ashton <joshua@froggi.es>, Melissa Wen <mwen@igalia.com>
References: <20230117212620.11262-1-joshua@froggi.es>
 <20230119181458.n4divmninme7o3dr@mail.igalia.com>
 <bfe3d3e0-9a9d-23d8-9527-817faf6ce3d1@froggi.es>
Content-Language: en-US
In-Reply-To: <bfe3d3e0-9a9d-23d8-9527-817faf6ce3d1@froggi.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0287.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::9) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM4PR12MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b304ccc-8ca7-4970-ab75-08dafda1577b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /gH1PCd+drW2rcWimnWNQgCNSiYgGQOIH3GZXq1j/NhVePErzbHNBd3Y1d0gxn05hyqZjQxFuzSOr9b5P3EUJt3WCZQKjvrLIrTHqcgiAkMjvYNhDT+BuNP6EtRlgh8yYyNZVEHiKLB67DbhbwVOoBUAP4d2ex4B8P6ishdjP3/+pdiQmkfCar3FU+U2uD9jvsbvviIay/tFzkQOUy5GH+FJh57BbTzL3yuVmLbjc4OkvW9LuIsQsU2X13hSem62tqm5G1AnLHxMSxzaE0kF+KULeV4h20w3bhQqz1D64s/0e/Xk338ZSmuY1DudKszOIZUyXVG2fgO/BGNmJDmFmOUd5Pu3g54gXX5kX81HBBPrtRQferYaAaAoDx/a+pG53v1PjfyEE/NqpPPCd9vYJ97zQjkVHHWe8a/y+wUXrwXWEfHjOOJ+rWUaRCq2tGjcPe00PDdiGJwK9BaL7EvxQ/WOYhrP/sWq7Cc808AFijgNAvmB4mo7di2Jaod+lDA6vvrfd5FJ+DavkgxXOQmm3daKOPSS8DO2bXsvfeYk+EPRbuxFYO7zTCGrx1Ru9CoWPuWaCAmLSNWvRGc7MGI52gRso4DqyFkBclijM8g39H2OY2HO8ZKmPePbi4LRJ991tnyfWXxuoDvpDR+GwUw2eUcN5jLGDWQq27mH96Z58wCbw7oqfR7UFlXk89z3vdTi/hGMQYCwYrN4EqoDMGfcru8W1vHBxz3u8brQ95omoGRplolx0MOEX7tNYPj2/h3PxlOydDrLb/vzxUvRulxBHuaAnClLYjG3nSWS4rlmBK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199015)(41300700001)(31696002)(83380400001)(86362001)(5660300002)(38100700002)(2906002)(8936002)(44832011)(4326008)(26005)(2616005)(6506007)(53546011)(6512007)(186003)(8676002)(6666004)(66556008)(66946007)(316002)(478600001)(110136005)(66476007)(6486002)(31686004)(36756003)(52103002)(158003001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWRiWGIvZ245bEJ3dkhxZFBiWXZYNjVlNjJya3Y4WlRJb1NwWWNoVnBXeTFv?=
 =?utf-8?B?cHlISUxFTmpWQ09qTGgybENqb0JMb2hNNFJqVzA4K0lURU9vU1VncFJ2SFpX?=
 =?utf-8?B?V2RnM256ODIxOS9zSXdXMEhtZG8rbC9FWFMwVFp3TS8zRFpTbjUwMThSTHNV?=
 =?utf-8?B?b3Z2c3VSU3RmcVZJMmhydG5VTGR6dXBiVDFuZG0ydlpKbTFsNExVMmNXQWJq?=
 =?utf-8?B?WFdTSU9OT0thcklDTnNwK3Y2VlVtSzB2THg0Z2tFWjhwUThudTR4YlphWStl?=
 =?utf-8?B?b0tBNnZuQWRHSitINnBzS2hKVWhFR1pFZXQvSjNjckNMNkRwMnlqaTFLOTU4?=
 =?utf-8?B?eFI0bFMyNWRlUUQ5VENpSGYvRnMvYWZGVEp4VHNQY3RGNWg1aFBLVzJZMjRM?=
 =?utf-8?B?SlNJdmpmQVJ2UzB0OUJQTVRXQjg4MCtEU3ZNYURMSUN1TE1TeWRXdlplTDZL?=
 =?utf-8?B?Y0Z5Ym5iL2pTMXhDcUlvSG5TOTQvNkk0SnRub25QSkFUY3dheXBkVVo1ZzNH?=
 =?utf-8?B?b1BFck40TVU2WVdBaGZjUW11RWQ3YUVPSnlzTStaTUZsbVJlbThUWmV6bmQ5?=
 =?utf-8?B?TjA5ME5LNUswZkZwYkYzU3hCTUU1aUJUVk45TVpKWjlwWjB0TFYzajZrRDBQ?=
 =?utf-8?B?c3hmdmlod3IxS1hzUFZ6ZExhZWJYbHF5Mzg1bzlJTkZ3M2wrNCtuQTU1R0tL?=
 =?utf-8?B?NFJRKzVWMkJ6ZG9NT0h1RmNoRHYwKzlVMDJBaGRBTWFoVFlBbkNHWnhQdW1B?=
 =?utf-8?B?RWVkaVVIQThGUGVBT1JiakV2QUJPWThiaG0vdG1YNFZLck8zZDdDMnJVL3Rs?=
 =?utf-8?B?S2dhSTVxdzhJdFdqbEtOQUxVek12dzlwNS9Wb0g1aE0rdnhNa0d0bWtYYmc1?=
 =?utf-8?B?SVZCNFlPY3ZtcW1XYmVLTlBPMi9wVEwzTEJqU3VycUNqbHNnK2QwTitsOHBN?=
 =?utf-8?B?Z3FIbFpiV2Z5a09vSExCSzBETjVmUlM5anBpTFhXWHJ3YVE1czNKMzJkUGxE?=
 =?utf-8?B?eHg1eXJTM3BYdFJCUUdpK3dZN0Y3R3VYakw2Sllqa3d2UEtIZDBrbkt3VnpR?=
 =?utf-8?B?V1RSRVhNcE9USUtsM2ZrdDgxNzlDUUo5bktnWjh1Ym9pTS9GUzdIdnN5V0h0?=
 =?utf-8?B?RHE2d1paYTBVaHpkVWdLek1NcTJ5amdvbU1zSFBSaGpWbHlRcVVEa20yMzdp?=
 =?utf-8?B?bDR4UXZHMVJPNDdWUXFibG55OTZZRUJueE5kM0dsVU5KR3lXd1VpZnZETHBt?=
 =?utf-8?B?c2pIQUxFTkZLTUYweE1acHVjVGxtM3lhR01xbktzWnh2SXJTbjdRNjhpQ1pL?=
 =?utf-8?B?VFlWZEYzSEdRcUs0ZXZwTVBPNzArV0VuMDczRjNKRE9XTVN2OXdUdE5teVpK?=
 =?utf-8?B?UXBRWTdYYjlPcXBmOWFHQmVVempyZWNSZlhxaVV5aWQyME1ObmdYazF2VFh6?=
 =?utf-8?B?dVFKcmVXR2lGeWYwRDFhakd4VkliWkdWWk9JMWgweVlUdEgwM0lCSzhENWRr?=
 =?utf-8?B?dFBPK21yVnhOSEJKR29iM0xNMEhOK2lTUGJkRHA5RjBGWlJjSXl4cXJsQkh1?=
 =?utf-8?B?bjVaKzVmUVA2NGdKNFdZOGJZK3plVnp6TTN6UHNmbGV3cUZINGNsS1dkdElM?=
 =?utf-8?B?RWpZT0V3eTV1WVpDcTZHSzBRRDltSXU0WWRranpCZmoreTFoMTFJSU9UbnFH?=
 =?utf-8?B?V3k3YlM4THVleEcwVHNSaDlpOUdNdi9xRDNESGQ5anJYQVRjVU5hL0lwbU4w?=
 =?utf-8?B?b1hBVmw2dGpEUzNBNEF3aHR4WTBFcWwyanNtOHZMYkhsTjI2OXpSU3dCcmdt?=
 =?utf-8?B?VmU4dWpKU0YyMGc1aUFVc0E0OTBhRU0vSGpta2E1U1h4aHcrTWlXYitucnBI?=
 =?utf-8?B?U3JTVTdQRW05bk9FQk5xeEo5VVY0SC9QZHl6Mjg4VytFcjUwOVNsOXZaa0hJ?=
 =?utf-8?B?elpjK0tmVnVwYVBDQThGTGdHSEIrQm9WVFZnVDZVZmlOLzVRYVVFdldERXU0?=
 =?utf-8?B?K0VtajQyYnhjTnlmWklXT0h3SzNNMHF4ek1FT09DZldFYTJnNFplTU1CMkdt?=
 =?utf-8?B?RFl2UlAvRzYyd2tpbm51NERIQlJQYjZITGxwOUZFUE9OYmRRS0JwaUs3cVIv?=
 =?utf-8?Q?QN1wwUj4dh+FWlEd1iTzvIWkS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b304ccc-8ca7-4970-ab75-08dafda1577b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 00:24:22.8144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F17V8/Q3rJPMAavgl774UMJf8VavmZpuRDnmAvDUPjt9AuWe0kYKp9XNWKXwkMEoUUKmJskC2Y55XHOf/J7y5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/19/23 17:20, Joshua Ashton wrote:
> 
> 
> On 1/19/23 18:14, Melissa Wen wrote:
>> On 01/17, Joshua Ashton wrote:
>>> Implements the 'content type' property for HDMI connectors.
>>> Verified by checking the avi infoframe on a connected TV.
>>>
>>> This also simplifies a lot of the code in that area as well, there were
>>> a lot of temp variables doing very little and unnecessary logic
>>> that was quite confusing.
>>>
>>> It is not necessary to check for support in the EDID before sending a
>>> 'content type' value in the avi infoframe also.
>>>
>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>> ---
>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++
>>>   .../gpu/drm/amd/display/dc/core/dc_resource.c | 69 ++++++-------------
>>>   drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
>>>   3 files changed, 46 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 9547037857b6..999965fe3de9 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -5216,6 +5216,24 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
>>>       return color_space;
>>>   }
>>>   +static enum display_content_type
>>> +get_output_content_type(const struct drm_connector_state *connector_state)
>>> +{
>>> +    switch (connector_state->content_type) {
>>> +    default:
>>> +    case DRM_MODE_CONTENT_TYPE_NO_DATA:
>>> +        return DISPLAY_CONTENT_TYPE_NO_DATA;
>>> +    case DRM_MODE_CONTENT_TYPE_GRAPHICS:
>>> +        return DISPLAY_CONTENT_TYPE_GRAPHICS;
>>> +    case DRM_MODE_CONTENT_TYPE_PHOTO:
>>> +        return DISPLAY_CONTENT_TYPE_PHOTO;
>>> +    case DRM_MODE_CONTENT_TYPE_CINEMA:
>>> +        return DISPLAY_CONTENT_TYPE_CINEMA;
>>> +    case DRM_MODE_CONTENT_TYPE_GAME:
>>> +        return DISPLAY_CONTENT_TYPE_GAME;
>>> +    }
>>> +}
>>> +
>>>   static bool adjust_colour_depth_from_display_info(
>>>       struct dc_crtc_timing *timing_out,
>>>       const struct drm_display_info *info)
>>> @@ -5349,6 +5367,7 @@ static void fill_stream_properties_from_drm_display_mode(
>>>       }
>>>         stream->output_color_space = get_output_color_space(timing_out);
>>> +    stream->content_type = get_output_content_type(connector_state);
>>>   }
>>>     static void fill_audio_info(struct audio_info *audio_info,
>>> @@ -7123,6 +7142,11 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>>>                   adev->mode_info.abm_level_property, 0);
>>>       }
>>>   +    if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
>>> +        /* Content Type is currently only implemented for HDMI. */
>>> +        drm_connector_attach_content_type_property(&aconnector->base);
>>> +    }
>>> +
>>>       if (connector_type == DRM_MODE_CONNECTOR_HDMIA ||
>>>           connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
>>>           connector_type == DRM_MODE_CONNECTOR_eDP) {
>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>> index a5b5f8592c1b..39ceccdb6586 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>> @@ -2944,14 +2944,9 @@ static void set_avi_info_frame(
>>>       uint32_t pixel_encoding = 0;
>>>       enum scanning_type scan_type = SCANNING_TYPE_NODATA;
>>>       enum dc_aspect_ratio aspect = ASPECT_RATIO_NO_DATA;
>>> -    bool itc = false;
>>> -    uint8_t itc_value = 0;
>>> -    uint8_t cn0_cn1 = 0;
>>> -    unsigned int cn0_cn1_value = 0;
>>>       uint8_t *check_sum = NULL;
>>>       uint8_t byte_index = 0;
>>>       union hdmi_info_packet hdmi_info;
>>> -    union display_content_support support = {0};
>>>       unsigned int vic = pipe_ctx->stream->timing.vic;
>>>       unsigned int rid = pipe_ctx->stream->timing.rid;
>>>       unsigned int fr_ind = pipe_ctx->stream->timing.fr_index;
>>> @@ -3055,49 +3050,27 @@ static void set_avi_info_frame(
>>>       /* Active Format Aspect ratio - same as Picture Aspect Ratio. */
>>>       hdmi_info.bits.R0_R3 = ACTIVE_FORMAT_ASPECT_RATIO_SAME_AS_PICTURE;
>>>   -    /* TODO: un-hardcode cn0_cn1 and itc */
>>> -
>>> -    cn0_cn1 = 0;
>>> -    cn0_cn1_value = 0;
>>> -
>>> -    itc = true;
>>> -    itc_value = 1;
>>> -
>>> -    support = stream->content_support;
>>> -
>>> -    if (itc) {
>>> -        if (!support.bits.valid_content_type) {
>>> -            cn0_cn1_value = 0;
>>> -        } else {
>>> -            if (cn0_cn1 == DISPLAY_CONTENT_TYPE_GRAPHICS) {
>>> -                if (support.bits.graphics_content == 1) {
>>> -                    cn0_cn1_value = 0;
>>> -                }
>>> -            } else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_PHOTO) {
>>> -                if (support.bits.photo_content == 1) {
>>> -                    cn0_cn1_value = 1;
>>> -                } else {
>>> -                    cn0_cn1_value = 0;
>>> -                    itc_value = 0;
>>> -                }
>>> -            } else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_CINEMA) {
>>> -                if (support.bits.cinema_content == 1) {
>>> -                    cn0_cn1_value = 2;
>>> -                } else {
>>> -                    cn0_cn1_value = 0;
>>> -                    itc_value = 0;
>>> -                }
>>> -            } else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_GAME) {
>>> -                if (support.bits.game_content == 1) {
>>> -                    cn0_cn1_value = 3;
>>> -                } else {
>>> -                    cn0_cn1_value = 0;
>>> -                    itc_value = 0;
>>> -                }
>>> -            }
>>> -        }
>>> -        hdmi_info.bits.CN0_CN1 = cn0_cn1_value;
>>> -        hdmi_info.bits.ITC = itc_value;
>>> +    switch (stream->content_type) {
>>> +    case DISPLAY_CONTENT_TYPE_NO_DATA:
>>> +        hdmi_info.bits.CN0_CN1 = 0;
>>> +        hdmi_info.bits.ITC = 0;
>> Hmm.. why is ITC value equal zero here ^, instead of the same hardcoded
>> `itc_value = 1`? Does it come from a DRM default value?
>>
>> Other than that, changes seem fine to me and it's nice to see the code
>> wired to the DRM and actually used.
>>
>> CC'ing other AMD DC folks since I don't know if these changes affect
>> other platforms. Can you guys verify it?
> 
> This is the same logic as before, itc_value is defaulted to 1, yes, but only assigned to hdmi_info.bits.ITC in the path with valid_content_type which was always false as that struct was never filled in.
> So previously, ITC = 0 CN0_CN1 = 0 always.
> 
> The logic added here also matches the logic used by other DRM drivers using the common `drm_hdmi_avi_infoframe_content_type` logic such as Intel.
> 
> It might be nice to clean up the code so we can take advantage of the common helper here at some point, but currently AMDGPU uses its own `avi_info_frame` structure instead of the common one in DRM.
> The structures should match (in theory! I did not look) so it might be possible to just cast `avi_info_frame*` to `hdmi_avi_infoframe*` and use the helper
> 
> Let me know what is preferred.
> 

This series looks good to me and is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

I have not had a chance to test it. Do you have any way to verify
that the receiver gets the correct content type?

I also don't see any IGT tests that exercise these. It might be
good to have those. Even if we can't verify correct functionality
from IGT we can at least ensure setting this property doesn't
lead to bad results in the drivers.

Would you like me to merge it through amd-staging-drm-next?

Harry

> Thanks!
> - Joshie 🐸✨
> 
>>
>>> +        break;
>>> +    case DISPLAY_CONTENT_TYPE_GRAPHICS:
>>> +        hdmi_info.bits.CN0_CN1 = 0;
>>> +        hdmi_info.bits.ITC = 1;
>>> +        break;
>>> +    case DISPLAY_CONTENT_TYPE_PHOTO:
>>> +        hdmi_info.bits.CN0_CN1 = 1;
>>> +        hdmi_info.bits.ITC = 1;
>>> +        break;
>>> +    case DISPLAY_CONTENT_TYPE_CINEMA:
>>> +        hdmi_info.bits.CN0_CN1 = 2;
>>> +        hdmi_info.bits.ITC = 1;
>>> +        break;
>>> +    case DISPLAY_CONTENT_TYPE_GAME:
>>> +        hdmi_info.bits.CN0_CN1 = 3;
>>> +        hdmi_info.bits.ITC = 1;
>>> +        break;
>>>       }
>>>         if (stream->qs_bit == 1) {
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
>>> index ef33d7d8a2bf..51dc30706e43 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
>>> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
>>> @@ -205,6 +205,7 @@ struct dc_stream_state {
>>>       struct dc_csc_transform csc_color_matrix;
>>>         enum dc_color_space output_color_space;
>>> +    enum display_content_type content_type;
>>>       enum dc_dither_option dither_option;
>>>         enum view_3d_format view_format;
>>> -- 
>>> 2.39.0
>>>


