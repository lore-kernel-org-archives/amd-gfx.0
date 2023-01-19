Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57016C004D4
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 19:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FB610E9DD;
	Thu, 19 Jan 2023 19:29:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1002810E9DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 19:29:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3plJRwlUDgGDP87IU16Unf+p0r6CUxY9vJ5Ze5yV8B/hj/TyPTR1GHutKpRHAYUY2LnTqnvnxTJN/iqDQIbzQ0rEmNTzLGVafPiE2xkZYXcZOUDtT9jdL+2fnnSsfsiSNxR/A9CrqqyqmYrVRuXAyUynss98pKUKlkmZ4ZUeHkJ6CsWSW5mEflJhue+utcZVPeQ4ZToEbqEkzAau9fY77e9eeb/FQQkWzBVXSiSS9In0wcPW8F6mn4sHslKD24lFJRjs0tvaMqzEhlqL1+gCQ/CIDyi+9Yy/g3sfXeCyLCuZ5lSi7LN1+aDrxzRer3vPH05bMhFDBUMhOLBmpyqag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkLMJzG3TxhTzThmz5c+O5N+0shF/ApCQhbfDhH2UJk=;
 b=SD5Dnvz9KZOn69HuxUpVgwA8JBjO25saZMWAkRxQQSY2g5h5MnTK1P6v3ZDLdcDF33NxYCWa+NUPbpcnCPODf/vTbdQhbtmHwzbjJUMgwhrgyDHyQU+7osZafD/rQ4syg5u7JJIkGeJNoBAFoUOIKHxjOuaqS8ok4JDg3G3C7AnWXEDtDySBmR2zMHN3ukUpLBxHk8yBSAIgnufZtdPQF0akboGvIUGYXJguo8Tmd7XfllVQqF/ew59oF5Ze7GL+Rf6/YxwoVBY6Ti/8ZpzJ/PjS4VV4OzRAc8V42fn2Hg8uSeY8HuGAEJaIgQyYg/I1vPjfI9A79CPWYgQgFkZH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkLMJzG3TxhTzThmz5c+O5N+0shF/ApCQhbfDhH2UJk=;
 b=L+BqkSWsH8jR9g0pHw78DNHCDd+y3Vr/lh7979d9ZtWITrDnAO0KyUxNGt5JY4PDDGXlcm3bdk5r//uySX+bQZ3kukH/HIQVrKQ0jLI6k6ruoay1suyQxg+rz7vIoMQHVqOo+0FfrEAud6ZY9eFTCAoJeNbN2/IOnU1Y2+emYfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 19:29:10 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::152b:e615:3d60:2bf0]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::152b:e615:3d60:2bf0%5]) with mapi id 15.20.6002.025; Thu, 19 Jan 2023
 19:29:09 +0000
Message-ID: <aec0f9b7-a410-9f1e-f92e-07b1e23e198e@amd.com>
Date: Thu, 19 Jan 2023 14:29:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] drm/amd/display: Hook up 'content type' property for
 HDMI
Content-Language: en-US
To: Melissa Wen <mwen@igalia.com>, Joshua Ashton <joshua@froggi.es>
References: <20230117212620.11262-1-joshua@froggi.es>
 <20230119181458.n4divmninme7o3dr@mail.igalia.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230119181458.n4divmninme7o3dr@mail.igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::31) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f8ccfc-ca74-4d2f-2b12-08dafa537004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q126KHEsyYBJXPR2jmvAyUDXG6j2BtsqRw1/lYitl82PO49YpLXM3yGEE0Q0xob2TmjGdhO9kOe1JXtTTSnhB2VFM8VdnodrmpzCh58goZ2YUZw+cBWVy3RvGZP8S06xNB21Wt01zTcHa2B7YJGdbtT+ljS99X8DW/CoUb6yjERCd2TZEh/E6wATWDiGMb/bO1HAWku2z4b6WxaHqzqn2UaxsFimYhveHrIyRfS9kXQDKIs8VVyCfM10+uyJ8UCjbQjiIsg4ZI6kBqObRww7sDPi9RGYJ4O3Ro3ZlnGGDIt4mEAUEjR8BwsMDJHa8JzZXGMLZohIxRQ+e185RcDGX/efRRRU5tiIj7nr9mftqVS5l2KNyUtwuPuJiVqk6lDbmyLAmA7RaNZXoSE6XMDMsJXF84reW+X6zyoq9AN7IFAd7jyGq/QJDJ/gPPVvPjooHBx6rdy0qH8PLulp5bO5Tvsec1K/QViflkdBOfRWQP6OOlHAR5I0tABPZ7cEdeZGf/R4i/0VOPaaOw8PSMZINizyTLL811f6oQv1wYIU3LKgJo7LaFo8I19CCDxMnWFDWxs4cOcFXQfY0SH6KpzWdrP0xmRZn9YiybJT+y/QuJiRB4GKO/Cup7qAwT4JceLmXRgf0FJlGV0qZC6H8uvmnY37i4lGtUpu1FMZ7c219tC+T1+0Y6s6tnXbtN0GSapgL/iv+tBD8qhQH4acNjoB3aCUUymKTWJ/2AAjMBAbsMgauZOb4cjJ1wafLjBrJER+4mOYcbb/pg0T1YxGyhhl9H84QvNeKU0juFSBxFzeliw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(36756003)(31686004)(66556008)(44832011)(66476007)(66946007)(2906002)(8936002)(5660300002)(31696002)(38100700002)(478600001)(316002)(6666004)(110136005)(53546011)(86362001)(6506007)(6486002)(8676002)(4326008)(41300700001)(186003)(83380400001)(26005)(6512007)(2616005)(52103002)(158003001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlUxVng3OUpjTTRXUFJoTUppcjhmNWZDcmJXSjFGUjBZc2drTHhDYVpZSTlM?=
 =?utf-8?B?VTB3Rnh6eXYwZWZ4NW54T1lNdUd5aXRGY2JhV3c3dWowZ3FROGxvWGQ2TFdU?=
 =?utf-8?B?bWwzRG93OWNpNUNaVlVmMmtNT0hCMDhWZzR6UWVPSmFCMTFJSmdNZTlmc1Jl?=
 =?utf-8?B?a2ppSGlaOGJlSHVmeU4zcnJXYWlIclQ5VUpoT2U4UDhObk9VdkJjTHhGa2RH?=
 =?utf-8?B?WU5WYXF2dEd3b0pKZGhNWkVjZVdCSnI4OUROM3BxN1RmREY0NVdvOTVaUkVy?=
 =?utf-8?B?Nkd5ZkFVcUhwUm9XTEJ6bFpocWhaMHQzSnFaZFV2ZjBwSHpPQXZwRjQzSjRj?=
 =?utf-8?B?TmNPLzd3U2htQ0ZxaFR6bDc2Nk93cVVJeWZEdGp2UDRtRUhmKzVoeUthdHcw?=
 =?utf-8?B?K2JMQnhLUDh0TUoyNFQveG1rd0dHTUpKMDVKaGR6N3dpT1RET05WYlBZSDJv?=
 =?utf-8?B?WTVqdEx4TTFlQUJsWE53V2hZNkxJOGpCazdDZTlLZS9YTUNXQm5Sd2Fsa0lG?=
 =?utf-8?B?dGwrcjRBM3owR3loMXVJK1ZiemZLTjk2TDd4RngyRlhXa3FVdmloazJCMC92?=
 =?utf-8?B?b2VTVTFnZnk3aHZIeHgwNlhaRW9LVW9FRFFwZGFDYnBSL0dyMmdBbDZBUlBI?=
 =?utf-8?B?bVJhZjZ1K0g0UW5iRzhtNEl0VFd1dzhpLzdNMHhjcWNJTmpZYzZYYlE3cXhn?=
 =?utf-8?B?ait0QVFwcDRLUDZJRHNBMHQyZGVMcE1JL0VJaWZUMTBhdU9IckZPMWhId09E?=
 =?utf-8?B?Z0kxU05JeUducGhOYWZPZ3VhWDZDUU1kcXVOSjE1dERiTzVQc2dCVzVXVmp1?=
 =?utf-8?B?emthMHZXSzg1NXBjcGtPV2s4bmZwalFZTjBQanhTbmk0b3o0UU5talMyb0JO?=
 =?utf-8?B?c21aTnJnQVN3UXE2OE1ra3FLbTBTU1pBeHQrSks4RW5nbGNuQWdrYnZmWFE2?=
 =?utf-8?B?c1QraE9NaVNJNkEwNGJUSytDQmc1THZOTzRoaDJOMmZJZ3NrNURGOER2eTlS?=
 =?utf-8?B?M3RtTWxkT0RIcWlhZXdsWVAyaTZTU2ZGSXhGUHpuZ010a1ZXQlk5dndsNlRZ?=
 =?utf-8?B?bXlKOTNqMFYwc2M3a1FZYXRjcVgwMzBwVnVjVUV6d00wTTB3eDR6ZlJrUFln?=
 =?utf-8?B?b2pjSm9wRmpHbTkzdnRTdmhaOE9GLy9RM0p5a1BtbjlPdERuNm5hbEhEQjA0?=
 =?utf-8?B?cTdxcHc2azZNYUxLMGVJYnh5ZnZYaE1hZzFxV3pmT2hGeUVrdXQ2TmIyblZl?=
 =?utf-8?B?aDQrN2Exek1RV3JNWlRTS1Q4WnVLbmVqbytyTGVxYWowUXRoNDVQNVBteHVI?=
 =?utf-8?B?dnIyOUw0K0hLNTREb1VFQmJMZGJGbGFrVnNzSi96anc0MTJNNnlaYUNwZFNs?=
 =?utf-8?B?UU82YjBaVnpiWk85Ky9hc1RWdnNCVlNRZWx2UjJpMGlOWWhRR0V1YmpXZ2c1?=
 =?utf-8?B?V3FSMC9sRHBtcncvbjlRbXFidURKYlI0ZFpLR21WZDVKSDc5WjZuazJ3T3pD?=
 =?utf-8?B?NTlTaFZXbFh3eEdRMk1YOGtaRml5aUV4eThyQWsrOGgwSFA2VlNQQVo5NE04?=
 =?utf-8?B?ci9tc3J5OVZnME9kazlBT3dwODBnMlNEVUtSalpqUkJsRFlvbFpwbXp6eU82?=
 =?utf-8?B?QlQ1ZmF2Y0xRci8vb1BoWUlLQ1J2TWpNMnoraGpHcmIwK0c0SmZqRkI2WEpL?=
 =?utf-8?B?d0tVNlZLbm1QWldCMDcwQ0Q4c09HQU5HMkxvU0VEYjdDU29PNXhJSE9zQnpQ?=
 =?utf-8?B?SzFkdEJ5bEp1NHRudi9VaS9VRHhPRDZ3eCt1dmY5VlJiaDVKcXN5TGtRSEtH?=
 =?utf-8?B?Vk9Od0wxVXI2K2RiQkRrTE14aVpyenlQZUcvYytJTHhyaEdPWlhCRHU0aGsr?=
 =?utf-8?B?T21WMXVTc1dCR0crUkFDQTdyd2hzaHk4K0h4clhUbkN3Smt3dml2Sk1LcVl1?=
 =?utf-8?B?bmlWWTdKbnVhdzlBVHQzSHU2Z29FQ1BVVTNJOVR0M3hlb3lnSGlZbjRuN25r?=
 =?utf-8?B?NHc0OUVLVWxOWWxUelk4MWdlNTlOdEhkQzdzaGVpOVZDSEdmOVZXZVFNbTVC?=
 =?utf-8?B?dXpXeVpOMUVPTDRPd0JEakM5RmQxeHNDL1JqeEQrZHQ0UzlVZFFET1ZHN25K?=
 =?utf-8?Q?ML2WIkoDwP7HrRwOWvVTz5JFq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f8ccfc-ca74-4d2f-2b12-08dafa537004
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 19:29:09.7396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGQYa8mu1+N5RketqVmZHZt/EffWjqA1DTJTSPpRZ62u86DCxF8ITaRcVpglhBRi7LmYfF3kBfQZ2H1c+iiQlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
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



On 1/19/23 13:14, Melissa Wen wrote:
> On 01/17, Joshua Ashton wrote:
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
>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>> ---
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++
>>  .../gpu/drm/amd/display/dc/core/dc_resource.c | 69 ++++++-------------
>>  drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
>>  3 files changed, 46 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 9547037857b6..999965fe3de9 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -5216,6 +5216,24 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
>>  	return color_space;
>>  }
>>  
>> +static enum display_content_type
>> +get_output_content_type(const struct drm_connector_state *connector_state)
>> +{
>> +	switch (connector_state->content_type) {
>> +	default:
>> +	case DRM_MODE_CONTENT_TYPE_NO_DATA:
>> +		return DISPLAY_CONTENT_TYPE_NO_DATA;
>> +	case DRM_MODE_CONTENT_TYPE_GRAPHICS:
>> +		return DISPLAY_CONTENT_TYPE_GRAPHICS;
>> +	case DRM_MODE_CONTENT_TYPE_PHOTO:
>> +		return DISPLAY_CONTENT_TYPE_PHOTO;
>> +	case DRM_MODE_CONTENT_TYPE_CINEMA:
>> +		return DISPLAY_CONTENT_TYPE_CINEMA;
>> +	case DRM_MODE_CONTENT_TYPE_GAME:
>> +		return DISPLAY_CONTENT_TYPE_GAME;
>> +	}
>> +}
>> +
>>  static bool adjust_colour_depth_from_display_info(
>>  	struct dc_crtc_timing *timing_out,
>>  	const struct drm_display_info *info)
>> @@ -5349,6 +5367,7 @@ static void fill_stream_properties_from_drm_display_mode(
>>  	}
>>  
>>  	stream->output_color_space = get_output_color_space(timing_out);
>> +	stream->content_type = get_output_content_type(connector_state);
>>  }
>>  
>>  static void fill_audio_info(struct audio_info *audio_info,
>> @@ -7123,6 +7142,11 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>>  				adev->mode_info.abm_level_property, 0);
>>  	}
>>  
>> +	if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
>> +		/* Content Type is currently only implemented for HDMI. */
>> +		drm_connector_attach_content_type_property(&aconnector->base);
>> +	}
>> +
>>  	if (connector_type == DRM_MODE_CONNECTOR_HDMIA ||
>>  	    connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
>>  	    connector_type == DRM_MODE_CONNECTOR_eDP) {
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>> index a5b5f8592c1b..39ceccdb6586 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>> @@ -2944,14 +2944,9 @@ static void set_avi_info_frame(
>>  	uint32_t pixel_encoding = 0;
>>  	enum scanning_type scan_type = SCANNING_TYPE_NODATA;
>>  	enum dc_aspect_ratio aspect = ASPECT_RATIO_NO_DATA;
>> -	bool itc = false;
>> -	uint8_t itc_value = 0;
>> -	uint8_t cn0_cn1 = 0;
>> -	unsigned int cn0_cn1_value = 0;
>>  	uint8_t *check_sum = NULL;
>>  	uint8_t byte_index = 0;
>>  	union hdmi_info_packet hdmi_info;
>> -	union display_content_support support = {0};
>>  	unsigned int vic = pipe_ctx->stream->timing.vic;
>>  	unsigned int rid = pipe_ctx->stream->timing.rid;
>>  	unsigned int fr_ind = pipe_ctx->stream->timing.fr_index;
>> @@ -3055,49 +3050,27 @@ static void set_avi_info_frame(
>>  	/* Active Format Aspect ratio - same as Picture Aspect Ratio. */
>>  	hdmi_info.bits.R0_R3 = ACTIVE_FORMAT_ASPECT_RATIO_SAME_AS_PICTURE;
>>  
>> -	/* TODO: un-hardcode cn0_cn1 and itc */
>> -
>> -	cn0_cn1 = 0;
>> -	cn0_cn1_value = 0;
>> -
>> -	itc = true;
>> -	itc_value = 1;
>> -
>> -	support = stream->content_support;
>> -
>> -	if (itc) {
>> -		if (!support.bits.valid_content_type) {
>> -			cn0_cn1_value = 0;
>> -		} else {
>> -			if (cn0_cn1 == DISPLAY_CONTENT_TYPE_GRAPHICS) {
>> -				if (support.bits.graphics_content == 1) {
>> -					cn0_cn1_value = 0;
>> -				}
>> -			} else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_PHOTO) {
>> -				if (support.bits.photo_content == 1) {
>> -					cn0_cn1_value = 1;
>> -				} else {
>> -					cn0_cn1_value = 0;
>> -					itc_value = 0;
>> -				}
>> -			} else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_CINEMA) {
>> -				if (support.bits.cinema_content == 1) {
>> -					cn0_cn1_value = 2;
>> -				} else {
>> -					cn0_cn1_value = 0;
>> -					itc_value = 0;
>> -				}
>> -			} else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_GAME) {
>> -				if (support.bits.game_content == 1) {
>> -					cn0_cn1_value = 3;
>> -				} else {
>> -					cn0_cn1_value = 0;
>> -					itc_value = 0;
>> -				}
>> -			}
>> -		}
>> -		hdmi_info.bits.CN0_CN1 = cn0_cn1_value;
>> -		hdmi_info.bits.ITC = itc_value;
>> +	switch (stream->content_type) {
>> +	case DISPLAY_CONTENT_TYPE_NO_DATA:
>> +		hdmi_info.bits.CN0_CN1 = 0;
>> +		hdmi_info.bits.ITC = 0;
> Hmm.. why is ITC value equal zero here ^, instead of the same hardcoded
> `itc_value = 1`? Does it come from a DRM default value?
> 
> Other than that, changes seem fine to me and it's nice to see the code
> wired to the DRM and actually used.
> 
> CC'ing other AMD DC folks since I don't know if these changes affect
> other platforms. Can you guys verify it?
> 

It's on my radar.

Harry

>> +		break;
>> +	case DISPLAY_CONTENT_TYPE_GRAPHICS:
>> +		hdmi_info.bits.CN0_CN1 = 0;
>> +		hdmi_info.bits.ITC = 1;
>> +		break;
>> +	case DISPLAY_CONTENT_TYPE_PHOTO:
>> +		hdmi_info.bits.CN0_CN1 = 1;
>> +		hdmi_info.bits.ITC = 1;
>> +		break;
>> +	case DISPLAY_CONTENT_TYPE_CINEMA:
>> +		hdmi_info.bits.CN0_CN1 = 2;
>> +		hdmi_info.bits.ITC = 1;
>> +		break;
>> +	case DISPLAY_CONTENT_TYPE_GAME:
>> +		hdmi_info.bits.CN0_CN1 = 3;
>> +		hdmi_info.bits.ITC = 1;
>> +		break;
>>  	}
>>  
>>  	if (stream->qs_bit == 1) {
>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
>> index ef33d7d8a2bf..51dc30706e43 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
>> @@ -205,6 +205,7 @@ struct dc_stream_state {
>>  	struct dc_csc_transform csc_color_matrix;
>>  
>>  	enum dc_color_space output_color_space;
>> +	enum display_content_type content_type;
>>  	enum dc_dither_option dither_option;
>>  
>>  	enum view_3d_format view_format;
>> -- 
>> 2.39.0
>>

