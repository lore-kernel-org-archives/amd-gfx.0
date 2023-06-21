Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99E4EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 15:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62ACC10E3DB;
	Wed, 21 Jun 2023 15:57:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DD810E3DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 15:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRS14ULusGZYUENQDPzV/evODuGk+/OnbbX9+T24BnzRzUREvGV6PShAY5nwlOeBnEWWp+znobSybG10vpMrVl1hf6x+oy9Y/QLrXu/ei4yRXjL6VKVdh3gCGIY5G/4kA9KhwfxKQykjjKGAkplE627vVQ4YIV9lPjG0dyKhKHip8DFgM2/gBpM7v+oJH4M59OrTvBCLsZKJYDexgqqBG12V+zedSQt/f/UfSkEs1REIcvpzKsI30MmGrMjxF7wwHXww4V11OJxs6nvLoh+66NH96SgBdfpF9asGYdRcDlVxEWw7SFve3FasMQIst+RTLF1PqxrCI0GjF2MJS5nHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3q198nkruy2i0UU2VzJbEYC7D3D6HLvcKiD4PpZCU40=;
 b=EuIw3PumluerhAxq8qz2ReJl9MrrvlbfUQsWmMuB1G6RS/M/cFztIHFoF+8kydL8bAUAdlqiAZDRtMwrmnVCPhLu+NWgnR+AZ8eFnHe+H2ZqGgd8Pm24YW+F7KXzjV1K1QgegsLT0zdZ00uIkH3sEkdaTwYFFMvHMMYkegxKCnpk54gBtUOybFASg/RSQ0GQJGUCzw5q/0T7snkIcomQTy4aik+OBHTuiKtuI3GqqEOZsOvKQ8QmACu1/82cREXhcwDj8IzgzspQ8EJ2plJT2I22zSiM0qFbZxZTqIzdQxHsZSvhl8pfGHssN3lwum7rxflyzWsHkX9pInUfChJOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q198nkruy2i0UU2VzJbEYC7D3D6HLvcKiD4PpZCU40=;
 b=5o5cwJohVAjORLljj6hv9Rl7bPWTOWQtVPMs8vlJlNTHC9kV+mMzLbJaxBt3fY0TY7JvizsoQRj6i5nxkJmG7A+qkhOVfX90+6F/lMo3ISNMI/mY9tq6SDQMRR1ZCylZYfqwcxFDshpzrGlhvi5FD94tHydn34ogknB7mekIgQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 15:57:29 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%5]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 15:57:29 +0000
Message-ID: <740c0baa-2fb9-68dc-8b19-d6e436b6a4d6@amd.com>
Date: Wed, 21 Jun 2023 09:57:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amd/display: Remove else after return statement in
 'dm_update_plane_state'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
References: <20230619120250.4168839-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230619120250.4168839-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0558.namprd03.prod.outlook.com
 (2603:10b6:408:138::23) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 57afce0b-9c46-4426-d1a2-08db72703733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /swL56b3dEpoXXZGCiuvw0TBeFNEAb7/NQTpeN5MJmHMrsbNxSj6r0segxIrAys6+FY8mdfnrO6E/2WwBIlvcG6XPyltoL7UDE3f9E+ZeY8eij/gQMeFIk3/g0XYExZwp/s9TRJsRujQmlGU7noh8TGUOEShdnCPbcbFTvRK6FIUTkPe+D8IQQmmAyN/KKE6vZiq2yPoTF+bbb/uqhiQvLKbRF72e3Ons+Wl0o9ehWANGfutHZJVPNY6rP1IB9vnO3lRqhj+LJ4NbYqicO9RCmP3pTCddpsrm8im9oQsWDo4mDfBObbeJwdRO8uS+mSp1RBbdg0E2M0qsJSfV07j8HJ81u9oWVBw+iluSux2P/o3IlWbMQSFU1JKXM+03Q/THhIJFw7h5WiWTA4JzgzlbylWR/U/j8ldMLVlw/ho46qQ03aKNVvcUbvYqGjIiaH9nGcTpcOKYg8l7B40TfK4Rfzk9Q/m/1a4Gb5gjf5mLAokYZYSvS6ChiWOYbhiQMOJCl1nJEM8HxcTmHDRoGqq8n6O0zVHIvQj6oE0Pl3RKdxMp8yizTfuR6RpwQbqBlLAofEIired04+HHWoUVVy7BFHwB/bKhUHR8goZKXqylsuDlxLEnSuRNNbjLN17C2XbZzjjFrmS2D85PEyIGD5StQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(31696002)(83380400001)(31686004)(6486002)(6666004)(110136005)(316002)(38100700002)(8936002)(2616005)(8676002)(6512007)(36756003)(86362001)(4326008)(6636002)(186003)(6506007)(66476007)(41300700001)(5660300002)(53546011)(66946007)(66556008)(478600001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGtSczdvdGdkYjBTUnhkWmxYWkJJeFJWUmx0a1NxLzlnVUtwdGRFK1BiTndE?=
 =?utf-8?B?VDlTVTk4WHh6MUVFdmJDU2s2bjRsVEdGS1UwK3MxRmZ6WFZBZDlNQWRFb0ww?=
 =?utf-8?B?c0FVV0hlTi9DRVRYdFVnajhtZmRMaklMajM2OHJvM2RmeEdZNGR0RUdyM1dx?=
 =?utf-8?B?cTlxcm0rSlUvcHpicFQ3aUw5ZFBvS1dWMlAvWGxLaHVVTXY1MWZ1d1FJVFhi?=
 =?utf-8?B?ZXFMdERmV0tRTmxUTEltY2IwNDhCLzlIK29oY0k1eEhsS2F2WWdoNERtWWZ3?=
 =?utf-8?B?M2k5OTBDbGsrTWNmRytoaGFkYmFsTERZL1lHRFR5ajludEFYTGhiYU1nTFlG?=
 =?utf-8?B?dFBuZ3VDVEFiRnlpK2NiVVNVN05pN2V1WHNJbHh1Y09sRDhkYktBUHpMVDRo?=
 =?utf-8?B?cXRzenc1RlQwQ0ZKMUd5SDJEZ1UrNG5SenlOQWtDTjFvQWV6S1B2OWNaRkVl?=
 =?utf-8?B?YXNVMkhXdGoxMkE3N09aZzNGV2V1c0pHeEdBZkZyT3lZRGtXVkFmd1FXaVln?=
 =?utf-8?B?K01YZm9wL1NBMFFUWXVEbGxRVDJrTFJ0RUdKcm1KK1gyVVdVRmlpcjNDWWMr?=
 =?utf-8?B?VTBUV1ptcERib0tCUGVwcUxVY2VXeENHZzV1R0pCSzE5T2xQaVVINHhrWFg2?=
 =?utf-8?B?bTdKTEtMMUs2TnZ6MTMyOEx2Q1lRdjJTTFMyT2ZTOW9UK1BVYW5vVFAxZW1Z?=
 =?utf-8?B?eEc4Y29nT1VoellYVndkeUhOVGdTL0FoclJUVGZoNWE3MVpKaXFINDVXZ092?=
 =?utf-8?B?ZmEyc0dtMEREaTU3VkcrQjZaWXMzZ012anBjeDhOMjQ5ZUhZM2xEUE9XVjlG?=
 =?utf-8?B?NWUvU2pHd2dUc3hKd3FSV1BKWGoxcmpiYVQ2dUpHTXhGd2Jzckw2UHBvUUVa?=
 =?utf-8?B?ZUoxM3dTQzhldFpCRHNiS0M2TkxxMjZBbXNpTks2RTZBb3JUaCtxcE4xUWZi?=
 =?utf-8?B?NU1NRDRKS1B1NFplVTIwNUNMejhEK2QxdElob0R6WGpCaHljZG14UkhWR2ZI?=
 =?utf-8?B?RnZTUDJhZlArUjc4cXZSSlZkWjV5M1RYY1R6Wk5Ca0diYngwbFdkREJKenoz?=
 =?utf-8?B?TWJUUGdpQXNTQ2UrWENoNitLMWdET2tRT2NjVzN1dW9vME1sRGZsRmc5TDFP?=
 =?utf-8?B?TWtwTlA3TFRnQ0FaY29xVG9WZlR6VURLT2VoVng3aTRLRlpzUXBuRmxrVGJ3?=
 =?utf-8?B?ZXZMWHhYRHBPdTgwL3pGYVNvY0IxVkgrRGcrSFFTZ1JtcXR5ODNaUDhyU09B?=
 =?utf-8?B?d3Z2VzVkaSswdHB1NjlzSHEvL2FEWGIyUytySTJnMkJ5ZWNxSGwzTERXMnQr?=
 =?utf-8?B?WmMwTXdIQjdXOVVtcUlTQUQ5M05GbEtPd21GUXE3T1pBdWVxTnZBazVHVlhO?=
 =?utf-8?B?UmlxQ1p5bmZmMnFKMXZ3bU44cFdsWWpOQ2FUSUNEWGRiMHJtcUNJN2IzSWRo?=
 =?utf-8?B?ZTlSd2FLVldsYVhKbjBmQzc1bGFpNjU0dktLMmNtZGJxMzZoYzB4RmFQOEtX?=
 =?utf-8?B?cnNmVlJkelFwVy82QmY2VHc0dEpOaFk0QXZIUlczdE5EditoblF0VU1MRXU2?=
 =?utf-8?B?MHYwMzFzUEo2WlhxMHF2TEsyYUhKekVQWjRiK2JNazF4STl0cmRWUUNoUXcv?=
 =?utf-8?B?QVNjQUFHQkR4ZkZwUkNpU3RNT2hCOE0vd0JaTTlNSk13M2J5dmc4dktxTDQ0?=
 =?utf-8?B?U1pVMWlNTXFiZVcxaXpXMmVUMk1velZML0JuNWhVd0pTbzJKbDZLaS9xTzlw?=
 =?utf-8?B?dzdmSEJpdkNLaGRrQS85Snoxb3BXSjhVQXF4dWNObVk1eW81OFRxbllSa1B6?=
 =?utf-8?B?Nm9MdjlIU0g0UHNkWHdIRVI3UFpHWWlkYVEvQjNTNEFjYTZZRmpDMmxmdHNy?=
 =?utf-8?B?NnAzS01QamJXWThFank4dExudkFBNytjRFQwRkhLOTYvV1FKMCs0RHNGeUhy?=
 =?utf-8?B?RTVibWR6NVU2Y2gxc3VjUk55V2xoNm1Gb3BURklHTzBJNm51S0REN1JYald2?=
 =?utf-8?B?RkhvRkR3S0pKbnZrbWhqaGdEODVPZjNJeHFObjZmZDNDOCtNYmhxTVJPdkxQ?=
 =?utf-8?B?VmR0bHNpZUZrVURPMFdyQ1pncXhSblFkZnpFc1JkdGk3Y3d0OWgzQWRrVlM2?=
 =?utf-8?B?MFhwTXpmamltRUZIdEVLWFpiQTZHdkxKWWxIVGVYUVlEM0hHLzdPdEpjUlVa?=
 =?utf-8?Q?cdMqy4KFhdbJhRUZDUmfTzimtGKMT3uzX51wFveEvz21?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57afce0b-9c46-4426-d1a2-08db72703733
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 15:57:29.2595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eu0Mmy8k9Ob0kLRgGUJwUdxf1hQ3Iu+JOJQbInAT3beKFK7WhBUKK5AZoGWlO3hGpRnK7mtkR+xoxN0lRu/LwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/19/23 06:02, Srinivasan Shanmugam wrote:
> Else is not necessary after return statements, hence remove it.
> 
> Reported by checkpatch:
> 
> WARNING: else is not generally useful after a break or return
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:9776:
>                                 return -EINVAL;
>                         else
> 
> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2446529c329a..e657214e0104 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9777,8 +9777,8 @@ static int dm_update_plane_state(struct dc *dc,
>   		if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
>   			if (is_video_format(new_plane_state->fb->format->format) && *is_top_most_overlay)
>   				return -EINVAL;
> -			else
> -				*is_top_most_overlay = false;
> +
> +			*is_top_most_overlay = false;
>   		}
>   
>   		DRM_DEBUG_ATOMIC("Enabling DRM plane: %d on DRM crtc %d\n",

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
