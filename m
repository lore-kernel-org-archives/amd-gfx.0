Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6185C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57FF61400
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57FF61400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59DDC6EE48;
	Fri,  7 May 2021 14:59:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A67C66EE48
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 14:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcLAvQ12SbqUC1uTV5wkpB3PwFi0Yifrj2qnFxdHKWSy5WsWXiQ8+2jWs8IHGIS6K6KYdsLglzguMDXwj5Xk7N0/jEZw1FWknyfFFf15RKlfGx2yey9inzmYg3AaP/o6zIRKA665P9T6SOxcj8XMaySR+BpcoLtpH/eAIx6wjX/CJvotzVSjkYkzt9iGWxMF0CY3dj5xCDgTG9w/AKM4LaMzrEAFAhvQ9KTQYi3AdA35bqIvyw6Jfdwl2RzXGgd8k5FNefabwRMnD8u8PlTac37DSfTdjPa2jO2EWuoquFhPl12jwDoZFDthjhq1UUDZjJMMIQw8yHuyRsWav0lCNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQhsH6Hp/NRIeviCGzuOvASjJrtsBZPfB4g0DK8GpXg=;
 b=DQIIGtU9AeZ7BXN0wB8Vnllc3VvOtBWFCcu+/p15ZTKxxOO82r75D9K121uKkknnk6AdT+rtofJc/cBftk1MCNxP7qcT/USHJ69zFEtHU1FvdKwrssF3MWWpQp2IIbC7Zu3H3S1zuPRVGRZfONp9+XrOLCh1XApgIDDZxmVXLmlIYjLS59rHM79TFf1actR9qZBnnPWpTBBtcaxM48ZvnksT9x6MlM59llaKVq5NpqhfLBhD/g33nyj3Uxag4Z4ZGfuRS8LeTM7DzNbvYkuZgEAnF6ousSUfFMCC1OGfjCvDF1VjkEG+VdxR0+F7jEnmTXq/TNQ2+OfE4S2tKIJVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQhsH6Hp/NRIeviCGzuOvASjJrtsBZPfB4g0DK8GpXg=;
 b=ic7VEGda8bg86gSJSiqb4b94+rNHOWDmOlcPPsSw9vcq6bfE7D/GvuXAgqeK2cGMobf/e6ilQ2e4o3F2KK1Fn47+KRQ3sxD93hDYouiEyijix03oJGTgtF5O52mEuc42yWjWfTOuds95kV1+KOXaT4w16up/K4Rf7MnXvHl+f0M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 14:59:50 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::acf3:1432:d128:3565]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::acf3:1432:d128:3565%3]) with mapi id 15.20.4108.028; Fri, 7 May 2021
 14:59:50 +0000
Subject: Re: [PATCH] drm/amd/display: Make underlay rules less strict
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210507143759.1546044-1-Rodrigo.Siqueira@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <6c7d06e1-b76d-3090-b253-e93c0da100cb@amd.com>
Date: Fri, 7 May 2021 10:59:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210507143759.1546044-1-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YTOPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::16) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.16.155] (165.204.54.211) by
 YTOPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.37 via Frontend
 Transport; Fri, 7 May 2021 14:59:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65f40d73-5e3c-4c1f-2ee0-08d91168c35d
X-MS-TrafficTypeDiagnostic: DM8PR12MB5431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB543161721EB570399A20B1FDEC579@DM8PR12MB5431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBHcEdC0pasY8SMVlC714HuKA35Dq+2hpR2TcyCjhvnUejnRfO9UjGevgu/FR3CWPcoRpHQ5Z4bRdc7jpT8saFDDSdckqGY/jG0e8tKumUTB29jh+MEiGDYwByk9xmZahVYem4kovA7dHZnDi/czs/j3ymoq0c9uTS4RGRAzbgENDAQ9qqjz2GGaXT7o5zsRVi7+FPzGqrbkRbZWcqjLDjzy+LyvEnhDM0dA9Dp+HBq08msx+z363P2+XpX8kOMgTRKlNne4HXWpNhtO7P2ctANwbG/hS610HGeIkXrEaKR8MD43XDq/iqrsqZyhiTi1PZFCXSXZBs0IUh3RlgArgU7Y3rkfHec6DFamVPAHmide2JIPckUW6zM4fvlxGqrbri6JOSThRXJJRryzdsQKRj1SVQX6nr61Sw/bNFCbE//pj/DO3chyG6F1i0ABf//k9JqmOOcd2kzi1CszdTuSkT5/Tebw23w2zkDfLVTpKsfFHwkBP8QW/s6VqQqxHz7qVm5z9PW+sg3WrKdSyqn5o0XfVN4V+cULgrZ9UhbabObGdw36cqBje2nCg/e+IWBiey0utjgn14WgurdAVNskI6JWnpGbd7XSQxJf0EWZvJOCUfOTS+XY95VezW4+GmoBjLjaOFdSe2mKZ7FruEGMBTEE7mQYa1rfRqsTNMxAt8ZO98q91Ldaxdqo7eRTKvIF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(4326008)(66476007)(66556008)(83380400001)(38100700002)(5660300002)(26005)(6666004)(31696002)(66946007)(16526019)(8676002)(53546011)(186003)(31686004)(2906002)(36756003)(478600001)(316002)(16576012)(6486002)(2616005)(8936002)(86362001)(956004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VXlOTktmd1lqa3R3RVhQdWVpV2ZRMUZCM08wenliVWxxYkFJa1ZETnpTellS?=
 =?utf-8?B?d2NicnlTWldrdVlJdWR0T0ptVitmc2dtaDJQVjRsUVN0Rk8vN2ZDL3BNeVJo?=
 =?utf-8?B?dSs0c01YaHMxa0FhWHF5QkxGSE9hZkxsOGJiNlh0M0h0RGlGbFBhTk5uSUR4?=
 =?utf-8?B?VGNmWVpPRWVESkt0eU5KbVptTVVKckEyNkN1M0F2N2dQQ2Fkc2doNlcvdVVG?=
 =?utf-8?B?b3hpS2IvZ1RJSGJaWTJId0NETXVhRk9YODZ2aUNOYUpXUVdITGp2dnR1azJE?=
 =?utf-8?B?NDVkeWNUZ2NDYXY2SzZOcG9XSkxBRkc5eW9jaE5HTmpJblZ4Z2dwY0k0Z2Rl?=
 =?utf-8?B?eTFRbVFDTzZOOWxKd3ptVVh5d2ZKVXVSUDhqVjdPTWlXRHgwNFpoaTZTSzZm?=
 =?utf-8?B?emNIUzNkRXlYRU5STWVXeitCOUdGNi9uRUxCQ3BSNmE1VEJOUWhVdXJmUmFr?=
 =?utf-8?B?QUNGTU5NNVdHVS8wM2hIakJqcmZFbjZBbS82cjRvcERIRHpOeVluR3F1aldi?=
 =?utf-8?B?bU9MUjdrTVQzWkptMm5mRFYvNm5YMm1PaFV3U0VWOHVKKzhUQnJMaVFkZzJa?=
 =?utf-8?B?dFMvUEFVbjEwWXlQRU44UWY3am81NTJpb0NnWjB3WWx2UXdTRUY5cmpVanJI?=
 =?utf-8?B?QnhLVUNLWm9lRHNrRWx2MXBiVTJNcEVJNlUzVVdRZTRwMCtqRGppWnVIdU9h?=
 =?utf-8?B?aTV2Ykh4M1JDbzZxdXFyaXB1NS9aa21qQm5zQTZuTXlWWk4xM2RuYmtEeHp6?=
 =?utf-8?B?K1htK2FmY2ZHR0NCWHFoRVJLSUFpd0xWMWJNQU1TZ2NnQjRHa05aNElaYWY5?=
 =?utf-8?B?OVI2YUhvckxpc0M1U3RieXMxelJJRkp3aVRLWEU0R0d6U0JCSjd1WkNsenE2?=
 =?utf-8?B?eUw5SWZDV3lpdHNCeFBIbmc3VGREUzVIcFBwdGk5Mm1VajdYMkIvYlhFWkh1?=
 =?utf-8?B?cU1FVlhRZDlIOGh0WTNzazZHTjhkRDNMSTFjRDVucG5WVDBoY2dzZXpnWXNG?=
 =?utf-8?B?eGdRMjcvZjFEZ1lUUEI2cVFSV1h1K3p2RU1ZVXBDTWlxNG9MNTFIVUd2YTlF?=
 =?utf-8?B?b0s0OHpHMjBjUEFCR3pHNXFPWURCK0lrZUpyeXdjQXYxQis1UWR0QWhEcHBO?=
 =?utf-8?B?dlJmSWw1NWVOckh2aXJFSm93TnhFMUpUN1pDc254ejZRTFVSWjBJMk9HVkRS?=
 =?utf-8?B?KzlPVFlkVlpreE5CTWxyL0VTSXJtYkJTZW5qWTFtZ1M0M0NoZkllUlByNE9r?=
 =?utf-8?B?OU1zQ0ZRUU85MjJtSmFFZ1ZGc2hGUS9tMkhLS1NTTG5HZWdKMUpXMk12bVJy?=
 =?utf-8?B?LytFYVB3cksyU1MwbWJsWUpPd1JvaTRxUUthcW5LWnZ4R2k5a21tM3Fqbi8w?=
 =?utf-8?B?eDF1a2tjWXhTVnd5Wk5ML2xvY3dJc3hVZXVyaC9XdVZiWEdpSmtNOHFzaTFU?=
 =?utf-8?B?YnEyOEU3enJHUG5IQ3R6VXI5TjJpeHZyTTRuQ3p2ZWtKM0w1b2ZRbldqZ21y?=
 =?utf-8?B?cmJRenl1QUUyMUFxUFhBMEdCVUpVYUJiNDloZE0wVDRRdzBBdXE5eFg4VVAv?=
 =?utf-8?B?ZkR2RGdPa3BZR1RHUUdKWG50aktUUXU5ZFNtU0srcGtubFlHczhaZFR1UlZV?=
 =?utf-8?B?dVhJSGlkNWx6ZUlhR0FySnUrZTk3NEVnV3lGWXpmSkQzS2R5cDJiUVFTa2U0?=
 =?utf-8?B?U3Q4UlV1b3BVNVUwOWY1aHpwTHY0WUtnaHVUTWd1aE1tYytNeEp3T3I3cU9x?=
 =?utf-8?Q?zQ10cQfxJsF3B2xIUdD197uTtqD8ybZ0kfWNh80?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f40d73-5e3c-4c1f-2ee0-08d91168c35d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 14:59:50.3412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcS5BjbNwMosRtDiFO6hYnuDIssrzKyqk6JgfamoJyWFFVuKdwxHtyFvgK7BWi4w9RSff9/X7oFTcRzRWyC2Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5431
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
Cc: hersenxs.wu@amd.com, Bhawanpreet.Lakha@amd.com,
 Harry Wentland <harry.wentland@amd.com>, nicholas.choi@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-05-07 10:37 a.m., Rodrigo Siqueira wrote:
> Currently, we reject all conditions where the underlay plane goes
> outside the overlay plane limits, which is not entirely correct since we
> reject some valid cases like the ones illustrated below:
> 
>    +--------------------+  +--------------------+
>    |   Overlay plane    |  |   Overlay plane    |
>    |                    |  |        +-----------|--+
>    | +--------------+   |  |        |           |  |
>    | |              |   |  |        |           |  |
>    +--------------------+  +--------------------+  |
>      | Primary plane|               +--------------+
>      |  (underlay)  |
>      +--------------+
>    +-+--------------+---+  +--------------------+
>    |    Overlay plane   |  |    Overlay plane   |
> +-|------------+       |  |       +--------------+
> | |            |       |  |       |            | |
> | |            |       |  |       |            | |
> | |            |       |  |       |            | |
> +-|------------+       |  |       +--------------+
>    +--------------------+  +--------------------+
> 
> This patch fixes this issue by only rejecting commit requests where the
> underlay is entirely outside the overlay limits. After applying this
> patch, a set of subtests related to kms_plane, kms_plane_alpha_blend,
> and kms_plane_scaling will pass.
> 
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

What's the size of the overlay plane in your examples? If the overlay 
plane does not cover the entire screen then this patch is incorrect.

We don't want to be enabling the cursor on multiple pipes and the checks 
in DC to allow disabling cursor on bottom pipes only work if the 
underlay is entirely contained within the overlay.

In the case where the primary (underlay) plane extends beyond the screen 
boundaries it should be preclipped by userspace or earlier in the DM 
code before this check.

Feel free to follow up with clarification, but for now this patch is a 
NAK from me.

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index cc048c348a92..15006aafc630 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10098,10 +10098,10 @@ static int validate_overlay(struct drm_atomic_state *state)
>   		return 0;
>   
>   	/* Perform the bounds check to ensure the overlay plane covers the primary */
> -	if (primary_state->crtc_x < overlay_state->crtc_x ||
> -	    primary_state->crtc_y < overlay_state->crtc_y ||
> -	    primary_state->crtc_x + primary_state->crtc_w > overlay_state->crtc_x + overlay_state->crtc_w ||
> -	    primary_state->crtc_y + primary_state->crtc_h > overlay_state->crtc_y + overlay_state->crtc_h) {
> +	if (primary_state->crtc_x + primary_state->crtc_w < overlay_state->crtc_x ||
> +	    primary_state->crtc_x > overlay_state->crtc_x + overlay_state->crtc_w ||
> +	    primary_state->crtc_y > overlay_state->crtc_y + overlay_state->crtc_h ||
> +	    primary_state->crtc_y + primary_state->crtc_h < overlay_state->crtc_y) {
>   		DRM_DEBUG_ATOMIC("Overlay plane is enabled with hardware cursor but does not fully cover primary plane\n");
>   		return -EINVAL;
>   	}
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
