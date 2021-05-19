Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8120C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9331A611AE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9331A611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83ED16EE92;
	Wed, 19 May 2021 20:48:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EBB46EE92
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 20:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJJtXmpOILeyV/WQx7/IVR7KsObtG6WUogT9yn21UwNegfS+TuPQOCuv9+Lqel4IMRpjME0iqw5O6YrtzZeND988WNOANoFjX5Zv8argSuzT9aeaaUcZZRt20kH9Z8wCDHIeezv5J11dAnO8cEc3paMKjGn8mUeqJbjc06RjoFHn7U/1LmLFuxvJcdH9FossTNw1he4hDVtG/Kvk3uKveTFxh+wwrKg607kw3h8qrCxKsNpWI21UfVF8/YUqT9p/DrglHAD7T6FELZGolXIhOh0jTpvM5Ad9or8kZKd3vZiX680HVLghYvRBlkQGRLeeNiKUFYovjJCj5x8YUDmSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FukBAnSxkj0DXn7yWhsAdOVctBJB+wMxtBoa849rwSY=;
 b=O7lULap9oDx6H9NAIbRA+YzHK+biw1lgJc5ABqN1Irk4N/ZeRsuqPTSl8R0Swxic5bJxbb2ar4ek8u5xS5ryhTIbY1wYXd8FRKoy3NyVujewaI6ejEX8KnNVtB3ZM5Zeb5ohDoOQZKhLkvemwk3tV+hlXPkP5GU7EhxCzLSs3TsvFjZGoTask7f734E8IKZqGE+gPvkbP6T9jGohc7RU2FTLvkJqvcliU6JxCDxq1V6LAQBS6SOb9Iu6EtN4K8+RR8d8DlvZPgc6bNg2JulySp9TNpulzFfxXTW4vFwWGREKQhZOKJ8f45JJDHheGrtwF9v9rTKtcviO5mV1n8scdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FukBAnSxkj0DXn7yWhsAdOVctBJB+wMxtBoa849rwSY=;
 b=IHpA4+AJZOdd2BhxFcvg42Lhj1gwy4UHPaxH1wK0eu/f4/QPYPwDM2wOONUBXWm8eCqNMSVOgMcWvJgHTxPCIxcfuL+n1ftxsfgN5r90aIk5HYUtL0sM/hVr8+WWdSigqzvEErP/PynAI5sVL+wPsWwSZfvYoefVFgSuZPwHY90=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH2PR12MB5514.namprd12.prod.outlook.com (2603:10b6:610:62::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 20:48:05 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1ddc:e4:8412:642d]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1ddc:e4:8412:642d%6]) with mapi id 15.20.4129.034; Wed, 19 May 2021
 20:48:05 +0000
Subject: Re: [PATCH] drm/amd/display: Fix GPU scaling regression by FS video
 support
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210519201219.260847-1-nicholas.kazlauskas@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Message-ID: <22b25c84-c155-08a4-a360-795747e0d6e1@amd.com>
Date: Wed, 19 May 2021 16:48:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210519201219.260847-1-nicholas.kazlauskas@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN0PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:408:eb::19) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.40.134] (165.204.84.11) by
 BN0PR04CA0164.namprd04.prod.outlook.com (2603:10b6:408:eb::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 20:48:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6ce8aa4-0c29-4079-462e-08d91b0766fe
X-MS-TrafficTypeDiagnostic: CH2PR12MB5514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB5514E560EFE45E2EAE19E80E8B2B9@CH2PR12MB5514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h7sy98ZGpPZF33XG1SGfYhom4BxtTbgFHMzJa+//l2uMQAkrjA08m44HE/XsMJ5VtiHSXd6ccLIrjJFKxJLA68ffqICZfV9l+7xnEeUMXH1UjHhh1TNO3FdO3dQiQBZDGcspOzgTT59Qu4wQrUVZHnR1aBYE9NTVNkbnrcSLk/f+274ASzvu/1lojzuWWS6OgaAN7XiGjYAVGmx2x8LYBjSFLfRX3p25wX9gATedJ9kIiT28aJUmdWfy6J0fwBFMMLtxJrWaIw7kD3Ku+lLnVcHAktaaH9QpK1u/dlrQEkLp/T5zk7rrL3TpvVHiqKaUfdNSeGecr4qpVpHM6nWnjpxbVrnOD2xE+lvVaXPk9cMfM13itXrqg9Qn81HemLmeOwC22zsFIDdXRVuv8jESv22BKqiKhCr999VuZuvMpJMUVpBtPJGylUscg/mI4prFH/5JIVBnizrh3b4cB9zEDcZb7Wu9lKjxoHMvHnwpvaHN3Nr2Fa15RNe/xVU/nZ9NUmNYW/nYRF8C5WVcJ0SrD1dz8k1KOGLY0FslOpEv1VsRu44xtst/TOrJPSIXgym9J5YzSoTYhlbpNsV4FXTVt4ukwQxeoSDihDO6DE3q2YBe8vEL/OBQ72KHJ+kJO5C9YAsWfsX1jsV+NF3kToOrbU2dKV9dgYDG/e5sv+IO0ZCIaOjdVG8ouSp+a5W1UxHybLosISiKRoLEZXpJ0I7ldpDlJrkVg4NqahlXtjKLHyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(66476007)(66946007)(8936002)(66556008)(26005)(6486002)(52116002)(8676002)(36756003)(186003)(86362001)(16526019)(53546011)(31686004)(2616005)(31696002)(38350700002)(44832011)(478600001)(38100700002)(316002)(2906002)(5660300002)(16576012)(83380400001)(956004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YmNCZnVaU215SitBYTFmWDJqais1V1lGY1h4Znpwc2FrYVNBaDIrZlFkWkJo?=
 =?utf-8?B?V2hMN1Q0UUpLVlBpTTJkekl0MHB3UHNUVXhMVTNhSWN3VWViRXNtdlR0Y0hU?=
 =?utf-8?B?SDl6SHBvM09wcTlBdGs2TXl4WnhTM1lLZXd5TVVYRlBKaGtIYVJzeEhWN29O?=
 =?utf-8?B?ZmhJRmFGeWJxRVE5TXd4RWtrb0pzamZFK1c1RGJkbms5VEJ6MVQ3MGsyNHRT?=
 =?utf-8?B?V0ZGY2wwajJIR25aRVNHYkxIWHNOQ3dTZHZXVWdZOW1KOTIvWnRZRWVTUnp4?=
 =?utf-8?B?aUc2c2NES2ZmYWtrN2RaQm5xUThFRGpFNVNqYUUvWUY0UXpqRjFnQVhEbkZD?=
 =?utf-8?B?bmQ5WS8wMU1pRWIxb3QvSDhDM3dKOSt4Z1dRbUM1cm9SYW04eis3SEE3MnFl?=
 =?utf-8?B?UVpheXJoS29QNE1KVkI4VUo1MlROTkFZVWxpUENWak1qQ0JWcDZnZTFZSVBF?=
 =?utf-8?B?VnRUQnpMMFJHT2JnQmc5Q3dXblJETVVZcjZDL2c1QmxCL05UaDJQdTlqUDhW?=
 =?utf-8?B?RzJpSVpKYmd1dGtGdFQ4Z0VBR1pxb3dTbXpCSUNoSjU3RThtdW93WGhJbUVN?=
 =?utf-8?B?VktUQk1ULzc3UDVxd0ZEWnAzQnVNeU84N3FPeTdIRGkxU2RhTHFjMVVlVWtH?=
 =?utf-8?B?UzhaaEdydFNQcUtoMHZZblJvM2I3RTBZZ2ZzMi9CekEzMURxT1lDU1lmUzNB?=
 =?utf-8?B?dHhrbkVLbDZHaVovR29LbmI5SHY2TzVEN3laSW1WWVlFTnhaRE9mS0lXVTRD?=
 =?utf-8?B?UHNqdHphYU5haDl1czBPVjlXZE9hRW9FYUd4TTEvQXllcDNkVmVDd056Zkhh?=
 =?utf-8?B?bFBBUGFxUmxOV2Z0NDNFNUdIdi84VkdBNlNETlJielVqV0NiRndWcTZlVlVG?=
 =?utf-8?B?c2JqcTdkSG54MHBVRUVIUkVFbk00bU9rR29MR2JCZ1owYWxSUEVqOFIwb2ZW?=
 =?utf-8?B?MGRidDBEQ3VUY1hVR0xCR3RMV0ZhN2EzaTl5NEdUZWVQUVlDN0Y0OFUyOHNH?=
 =?utf-8?B?eXdwL3hBOUtqU0J5TExSb2ZwOFF4VFBVSjdYMFgwa3JGNXVLZVRvRFI0Qzg0?=
 =?utf-8?B?cExOL2tQdjNQOWJUZzlUd1dJcFo1bFNUNHd1SGdvYXFCRWswK0ZadkdTOHVL?=
 =?utf-8?B?eFNoOGVJUTF1ZlZjbWp4cXU1VTdycUlIRHRDMHZNYlNESm5lcktLZGpNeHpG?=
 =?utf-8?B?bFJYb2NBODRnNE9sOTIzdG1IUVg4N2VBYk9ubW0wV29Mb01VREV6cURqM1Bu?=
 =?utf-8?B?LzB1NmJYK29NRGpuZmxxRVNBT1p4Z3hiVEFLZ1NSVzJXZXkwa1pUcFh6UjhP?=
 =?utf-8?B?bUg0RUVwZTdING9yVDdIWlBkL0lYL0VWSVdhbzhtVDBiSFBJSVBhNGtOeWRa?=
 =?utf-8?B?NVB5K2s3M0pUY1JLNENtTEtlcXRSdkFmQWtES0o0Z1JFYllrckg2Ky91dEh0?=
 =?utf-8?B?SWI4Vm5JU2RvaE1MdFpiSkhnVkt3VGNZaGFySHJ2NVZpMkNNV1YyVzRTTXo4?=
 =?utf-8?B?amFOQ3NiZEdiS3kvUTJnUjVZRXdGNytVN2UveUo2NExTWHIyNUo3eWRlSVdi?=
 =?utf-8?B?MEIzci93TjZ4ZWxmRnJFYVFPdVVqa3lvSFdNZFk0UlFLeThLZC9zeXBLdjhx?=
 =?utf-8?B?cWlsMCtJYVJSd2FQaU4yQXovWGZCRzBGVTBkUCtOek8rNlhKYzlCRWpDVzBk?=
 =?utf-8?B?TUMxUmhHNjA3YkNUWlJIV1RWOTJHcExaRXdVeE5idHUzdUo1ZnF1Yk9yYXVE?=
 =?utf-8?Q?FjNPiaa0zH+8F8/wsAMWxI9PvEHHGaPwL5zflnT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ce8aa4-0c29-4079-462e-08d91b0766fe
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 20:48:05.8696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fErdxNE40Z56czWZzyCt+yTSQWzIgdbhGNllV/SNAmBjy3RihzZxvCGeCxEOCVsXHepcZbykGTaWlf95GLI/2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5514
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 2021-05-19 4:12 p.m., Nicholas Kazlauskas wrote:
> [Why]
> FS video support regressed GPU scaling and the scaled buffer ends up
> stuck in the top left of the screen at native size - full, aspect,
> center scaling modes do not function.
> 
> This is because decide_crtc_timing_for_drm_display_mode() does not
> get called when scaling is enabled.
> 
> [How]
> Split recalculate timing and scaling into two different flags.
> 
> We don't want to call drm_mode_set_crtcinfo() for scaling, but we
> do want to call it for FS video.
> 
> Optimize and move preferred_refresh calculation next to
> decide_crtc_timing_for_drm_display_mode() like it used to be since
> that's not used for FS video.
> 
> We don't need to copy over the VIC or polarity in the case of FS video
> modes because those don't change.
> 
> Fixes: a372f4abec ("drm/amd/display: Skip modeset for front porch change")
> 
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8cd270f129..759621b0e8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5672,7 +5672,8 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   	struct drm_display_mode saved_mode;
>   	struct drm_display_mode *freesync_mode = NULL;
>   	bool native_mode_found = false;
> -	bool recalculate_timing = dm_state ? (dm_state->scaling != RMX_OFF) : false;
> +	bool recalculate_timing = false;
> +	bool scale = dm_state ? (dm_state->scaling != RMX_OFF) : false;
>   	int mode_refresh;
>   	int preferred_refresh = 0;
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
> @@ -5735,7 +5736,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   		 */
>   		DRM_DEBUG_DRIVER("No preferred mode found\n");
>   	} else {
> -		recalculate_timing |= amdgpu_freesync_vid_mode &&
> +		recalculate_timing = amdgpu_freesync_vid_mode &&
>   				 is_freesync_video_mode(&mode, aconnector);
>   		if (recalculate_timing) {
>   			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
> @@ -5743,11 +5744,10 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   			mode = *freesync_mode;
>   		} else {
>   			decide_crtc_timing_for_drm_display_mode(
> -				&mode, preferred_mode,
> -				dm_state ? (dm_state->scaling != RMX_OFF) : false);
> -		}
> +				&mode, preferred_mode, scale);
>   
> -		preferred_refresh = drm_mode_vrefresh(preferred_mode);
> +			preferred_refresh = drm_mode_vrefresh(preferred_mode);
> +		}
>   	}
>   
>   	if (recalculate_timing)
> @@ -5759,7 +5759,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   	* If scaling is enabled and refresh rate didn't change
>   	* we copy the vic and polarities of the old timings
>   	*/
> -	if (!recalculate_timing || mode_refresh != preferred_refresh)
> +	if (!scale || mode_refresh != preferred_refresh)
>   		fill_stream_properties_from_drm_display_mode(
>   			stream, &mode, &aconnector->base, con_state, NULL,
>   			requested_bpc);
> 

-- 
Regards,
Aurabindo Pillai
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
