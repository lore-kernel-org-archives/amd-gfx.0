Return-Path: <SRS0=8SIX=IZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164A0C433C1
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Mar 2021 14:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51DD6192F
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Mar 2021 14:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51DD6192F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED906E1BD;
	Sat, 27 Mar 2021 14:29:00 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 877956E1BD
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Mar 2021 14:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzN7ZB3ErRghFLn9BQv80MeDlDkt+bylieh4hLr2RI3a6h78yana8pyGSA9NBEfTWrqbLSdqsMUmyU1J73rnBg6ujVbnNPnc5zE9bG/0FBh5NwlxgRj/sQJWXjtLVqapWZSIXThuRYlRGUcIJcg0MN1D6YzbU2NNzniPDUGppHxfoz6p85vuKsk2Ivk1YfTYL3mooVl87ec8NoZB3o4pP+CuXVKpLaaYj5IJCJmp7nmh5bspCrFAEaDc65QIrTulVLZBju2ue5VFjFJgVckfxjXb8WeVCcunp19UtroxIU7TT6DSBvs6znGt1g7bHtK/LYfThUpCvqEsz7Gst4WkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1LFa9FOFsCGacuFizEcmHOQPbJmSBwbem7uel+pizU=;
 b=JQGYQz1Nk209zYIS8lQUIQS941rfaCBiYOaGonhOP/Pjpsw9MeFSfwEDktG3X2p4nJeMBjh8loYDTNA/SbhIFF23LlEkYPvR2pU9e3SajyGsxgo9AC2eLIPEdcdHRF0/qWmiB+nUYtIe1aka6u7VJJKDjs2pAecS2FoO4erY21bV+4kKM4En4Qqdut4do3bipUOAii80vujjmTIWYxk9NQWH5CAzCe+TApijQwUiPB2BwkJTmRt15WuKjlHkgNeJxaiC+IOQujrJZUzofwE/+u3LANl0Z4/zcrfUo7OBT3Np+HX+GMhCtH5Bw9c89iH8nz+polLPhxgzgwoetL3p2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1LFa9FOFsCGacuFizEcmHOQPbJmSBwbem7uel+pizU=;
 b=LsJSlmTyeHNv5qjpe+5ncM6PxMLMUDiJSm5/Wz9eBYmlgcU1Gz6mlbAeBS9ye98iV+VylXl5mECQZSPqP/YzISkB5C2Fjn25byQP121KwftHcSjk8eCQhosBymUHqjwWwCijN9rlnci38TNwDjpeG0eQF3I/6NrIqk3sxGATQE0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH0PR12MB5028.namprd12.prod.outlook.com (2603:10b6:610:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Sat, 27 Mar
 2021 14:28:56 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::6c8a:904f:7403:8d60]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::6c8a:904f:7403:8d60%5]) with mapi id 15.20.3977.032; Sat, 27 Mar 2021
 14:28:55 +0000
Subject: Re: [PATCH] drm/amd/display: Fix black screen with scaled modes on
 some eDP panels
To: Nikola Cornij <nikola.cornij@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210326231352.17827-1-nikola.cornij@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Message-ID: <28ba9614-7064-7605-723c-bafbd4412e4b@amd.com>
Date: Sat, 27 Mar 2021 10:28:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210326231352.17827-1-nikola.cornij@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTOPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::41) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.29.1.132] (165.204.55.250) by
 YTOPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend
 Transport; Sat, 27 Mar 2021 14:28:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef60b301-cca9-418f-f23a-08d8f12ca6ef
X-MS-TrafficTypeDiagnostic: CH0PR12MB5028:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB502857A87718DE8D88D8AA5E8B609@CH0PR12MB5028.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPO9Go8WG2dGLuo7ZBctVizs91QO7QLcri54hESNKIHylN2iWprBNLXWY7p+tZyeAvWB9yJ5RWuPdyUER/Io090f1u6yw3rGGO8AnJDzC9IkL/goaClnZoQCLlplvh6F6WV9aJOhWEXcOLov11DVdKpiz0mOmg3L0+307ZzRSYDZwdspjwtzOo9IKqW/L2mfn7hBl1bJyOHU1dyFz120w1MdQ95lG60VD4S03Mfdhofrmcuc2NfKOj+JaEAzdSzARUWXGdWex1mh+m91d52eHJVvodmywdOZahmtfdG2jfcPOkK1GigZ/TF3jKiTe89Pi10nHuMsya9I6dYd6F7zkvVG43kOJ+J+QThm2fWRlQrQDRDVP9ZFyDUOnBWqQUzQ+Vu2rUkMCB/0b24kDGo9krUAkoEkryI5oxUWJcPsdpmrVwvL59wbveJCr4M+NIDpaHls4HZ73umzCtBy0zkeoPjvDTcD+uME/aWQ4m3NgfNAGQR46wACMpBTGpMS0Vod1C2Y9VbC3mfr72+bjkkUlxEfrN6sFDmLMO2yXpV4H7W7buQcDeu3Afyd/M5B313g1PUuOTNw2kFhGugi6RYk7s4E7hLwthfGWUalUFeMwiVHPr4avjeYNijbhjqQD+c1drLxMHydeGcQi25efhNVTO39AJ4RV3h0+oGVVdxonpPWvikgieNxuPs1RnAUzAE4BfvpxYBqgCW4pyVqqjKTORX3z3fR1tAGurSQR9KkwNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(31696002)(53546011)(8936002)(316002)(16576012)(86362001)(52116002)(5660300002)(6486002)(478600001)(8676002)(4326008)(44832011)(186003)(38100700001)(83380400001)(2906002)(31686004)(66476007)(66556008)(66946007)(36756003)(16526019)(2616005)(956004)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RFk1b3lUY2NJdE9yZDRWT21STzhwVkRjYnV1M1hyNmVXOFRhM3FXajBiS25h?=
 =?utf-8?B?dHRUK3hPZkYwR2VDUUZic1k0bDU5Mm5wZHZKVDhmWUZ0ckNUOXpOa25RZzAr?=
 =?utf-8?B?QzFjVFdkY2NMbzg5aDZRZisvcGRpWTBzblA4ZUdodUNWbCtTSFV0S3JGRGxn?=
 =?utf-8?B?MWtlSzdDRWl1OGJsdmhFVERLOTJDdWFrcy9qZ0w5cTZaN1lvWUh5MDYzZEdl?=
 =?utf-8?B?NjFwSkxLamRIak5DL3lsQUpaTnhLTG1ERHJIMjZOVzhVTTNsekNVbkxZWlhq?=
 =?utf-8?B?M1pHUWFHSVJrUGVpRkpERWZzaVh0T1lFWkRrakoxUm54bWZBaEFxbDlROTYr?=
 =?utf-8?B?bG1ONGpnbWZ3elVoSmNrMVU0NVFDL25IYkF5UzZpVkVtU0Zpdmt6UmVXRHlm?=
 =?utf-8?B?YXBHYXQ3dE1kNTk0WWVzS3lXdFZ5YzRHZ2JmQ1dBNlFDNzlVOEs5ZDhEbC9X?=
 =?utf-8?B?RXg0WElZYUpQaEw3YnFYYlpobllJR0thZVpZOElsUW01aURWL0lNZWFwZ01M?=
 =?utf-8?B?b3JXeVpnN1c1cTBiRG9WZUEvaFpZY3pZVXNZTzNmTFdPQ0lDSW4zbkpwY1No?=
 =?utf-8?B?L0dqMmZiK2tSSzB5U21JN09haWdPeW5qYVNKcnc5U25qMFJsbEpZRVlGcnpq?=
 =?utf-8?B?REl3bk1CblgwY2QzNnNOUG51dG4rZEJWUDRQemF4T3YwSHBya2hVclZKMVBY?=
 =?utf-8?B?WnNHWSs2MHg0eTBlSzlGZFZFYkU0OTU2K210Vnoxc1Y1Q3ArdGpjVFBVVkl6?=
 =?utf-8?B?d0hKSUdTOWIrcERGeklaS1ZtZlRGVmVwVllqOXE4TFhLSXJJNWFGK0lCTlVR?=
 =?utf-8?B?L3RxendONEJ5Nm5IbjdyRFc4eGd2ZGRTRVBWbmx1cndFOVJ6S3FxYng3NUxl?=
 =?utf-8?B?c3d3MW9QKzBIS0J5UjBMbTU5OVd6WUpsMmZ5MlpocXpObjRVdDBQNGN4dmhQ?=
 =?utf-8?B?MGl1UjRMS1BNV2hvaStPaFZKbUt1eGlvRURibFowbkNneGw1U0NiRGd2elB1?=
 =?utf-8?B?VTN5d3NnRHMwN3p4MzNqdnZmYVVCSlEwcXpnTFFFbXhOb3BldmZ4Y0dpYzlO?=
 =?utf-8?B?WTQ5dVVUa3JnZVNwcTV5OE9leDdWKzdzWFEvYStFVEM1enZUZC9YTzJvUWh6?=
 =?utf-8?B?RWhMSWRJSGY5WkRHQXlVVzNVYlRmQ1RQRTFmeHFsdHJvYnVmWWpNL3ZIYW5C?=
 =?utf-8?B?TGdVME5yM0FmUW82aldCT00wc3ZrREs2dE56RnpxUkh0dEM4eVorb0lZa21G?=
 =?utf-8?B?cFU3dDcrZk8rM3pFaFRlMlRJRjNPNjNJQWtnZkorYTZ6dStTRnQrSDV5bkFk?=
 =?utf-8?B?R1B0UDBlaERadXlzeml4Q2ZPaitJY0pTeEFremg2NHNvOHNUWXFJM2NPOVpJ?=
 =?utf-8?B?NXNHQzB0b2xrWmtReS8wOVovK2pleFFENlRmc3V3ZkRnWVhZc25jTHdLeXNG?=
 =?utf-8?B?ekFzVjV2YUdVei8wY1REMlZqVktZdU9tUFZRMHFPUnI2Z2o1dzNJeXRteVpO?=
 =?utf-8?B?dFVkUHpTVE5uMmx2MmVjUDV1Rkx6YVoxRXZrOU5YWVQ5ZldwVVM5U2FhbTNW?=
 =?utf-8?B?dUE1QVRTYVZ5K2FEOW92UlFyWFpNdUFJam0xRXFRMEYyMU92TVpFNEc1c3Mv?=
 =?utf-8?B?a0FrOHoyNitSazU1QkZzYVp6dThYdGxhbmgvUlFqMjYybllid3l3TW5qOGdj?=
 =?utf-8?B?UWRRSjJMWGlsZVhPUDB0bWZia25wQVdWK2cwZGpXbEI4Z0F2Y1pQOHNncXF4?=
 =?utf-8?Q?kMNXTxcNV4XnXdlxZkw7lASJdUtiX0+8GPaFoKg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef60b301-cca9-418f-f23a-08d8f12ca6ef
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2021 14:28:55.6066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pp0DsmtWcIUDzzpHV0DJdR8yiAgPMjHcwAqFHCcxJHWmNu4pQCLoi+JqeRVNyW2iHRmMinWa4Nd/fiO5uNDA2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5028
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
Cc: nicholas.kazlauskas@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-03-26 7:13 p.m., Nikola Cornij wrote:
> [why]
> This was a regression introduced by commit
> 
> c1218dbe223f - 'drm/amd/display: Skip modeset for front porch change'

Its a good idea to add the regression info along with rest of the tags
at the end of the commit message, like so:

Fixes: a372f4abecb1 (drm/amd/display: Skip modeset for front porch change)


Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

> 
> Due to the change how timing parameters were set, scaled modes would
> cause a black screen on some eDP panels. Would probably apply to
> other displays (i.e. even non-eDP) that only have scaled modes,
> but such case is not that usual for external displays.
> 
> [how]
> Pick up crtc frame dimensions when programming the timing unless
> it's FreeSync video mod
> 
> Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 39 ++++++++++++-------
>   1 file changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4c02373a707a..ad31591070c9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -130,6 +130,7 @@ MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
>   /* basic init/fini API */
>   static int amdgpu_dm_init(struct amdgpu_device *adev);
>   static void amdgpu_dm_fini(struct amdgpu_device *adev);
> +static bool is_freesync_video_mode(const struct drm_display_mode *mode, struct amdgpu_dm_connector *aconnector);
>   
>   static enum drm_mode_subconnector get_subconnector_type(struct dc_link *link)
>   {
> @@ -5239,15 +5240,27 @@ static void fill_stream_properties_from_drm_display_mode(
>   		timing_out->hdmi_vic = hv_frame.vic;
>   	}
>   
> -	timing_out->h_addressable = mode_in->hdisplay;
> -	timing_out->h_total = mode_in->htotal;
> -	timing_out->h_sync_width = mode_in->hsync_end - mode_in->hsync_start;
> -	timing_out->h_front_porch = mode_in->hsync_start - mode_in->hdisplay;
> -	timing_out->v_total = mode_in->vtotal;
> -	timing_out->v_addressable = mode_in->vdisplay;
> -	timing_out->v_front_porch = mode_in->vsync_start - mode_in->vdisplay;
> -	timing_out->v_sync_width = mode_in->vsync_end - mode_in->vsync_start;
> -	timing_out->pix_clk_100hz = mode_in->clock * 10;
> +	if (is_freesync_video_mode(mode_in, aconnector)) {
> +		timing_out->h_addressable = mode_in->hdisplay;
> +		timing_out->h_total = mode_in->htotal;
> +		timing_out->h_sync_width = mode_in->hsync_end - mode_in->hsync_start;
> +		timing_out->h_front_porch = mode_in->hsync_start - mode_in->hdisplay;
> +		timing_out->v_total = mode_in->vtotal;
> +		timing_out->v_addressable = mode_in->vdisplay;
> +		timing_out->v_front_porch = mode_in->vsync_start - mode_in->vdisplay;
> +		timing_out->v_sync_width = mode_in->vsync_end - mode_in->vsync_start;
> +		timing_out->pix_clk_100hz = mode_in->clock * 10;
> +	} else {
> +		timing_out->h_addressable = mode_in->crtc_hdisplay;
> +		timing_out->h_total = mode_in->crtc_htotal;
> +		timing_out->h_sync_width = mode_in->crtc_hsync_end - mode_in->crtc_hsync_start;
> +		timing_out->h_front_porch = mode_in->crtc_hsync_start - mode_in->crtc_hdisplay;
> +		timing_out->v_total = mode_in->crtc_vtotal;
> +		timing_out->v_addressable = mode_in->crtc_vdisplay;
> +		timing_out->v_front_porch = mode_in->crtc_vsync_start - mode_in->crtc_vdisplay;
> +		timing_out->v_sync_width = mode_in->crtc_vsync_end - mode_in->crtc_vsync_start;
> +		timing_out->pix_clk_100hz = mode_in->crtc_clock * 10;
> +	}
>   
>   	timing_out->aspect_ratio = get_aspect_ratio(mode_in);
>   
> @@ -5468,7 +5481,7 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
>   	return m_pref;
>   }
>   
> -static bool is_freesync_video_mode(struct drm_display_mode *mode,
> +static bool is_freesync_video_mode(const struct drm_display_mode *mode,
>   				   struct amdgpu_dm_connector *aconnector)
>   {
>   	struct drm_display_mode *high_mode;
> @@ -5591,7 +5604,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   
>   	if (recalculate_timing)
>   		drm_mode_set_crtcinfo(&saved_mode, 0);
> -	else
> +	else if (!dm_state)
>   		drm_mode_set_crtcinfo(&mode, 0);
>   
>          /*
> @@ -7436,7 +7449,7 @@ static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connect
>   
>   	if (!(amdgpu_freesync_vid_mode && edid))
>   		return;
> -	
> +
>   	if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
>   		amdgpu_dm_connector->num_modes +=
>   			add_fs_modes(amdgpu_dm_connector);
> @@ -8771,7 +8784,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   #endif
>   		mutex_unlock(&dm->dc_lock);
>   	}
> -			
> +
>   	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>   		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>   
> 

-- 
Regards,
Aurabindo Pillai
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
