Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE73C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 14:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEBAA60F13
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 14:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AEBAA60F13
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610C989CC1;
	Tue,  7 Sep 2021 14:20:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5249889CC1
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 14:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg81JHJUEIgOwZpwFLGoWYNkF8khcsRdx+Ac2lCrrDNZGMTO9S/sVBCTmJSutS92Vi3fBaAKH75AejRviEZ7loggHeoVtNEKzV5Nv+/rTeGy9tLMmsSb4Ka+T8b3OiarJRbt4Lb8K3rxGdU9U5+zSks+C3PcZgSb480m8bpeFKAMp7slDNZshxXHX1AbB7MJW46bxlTW0L85a5IqI9QKJtpc30pyzQnepqQ8i7zJ6fBueD6/b1ASEkrslTzW654uHYCagytRoFZWkpbUygtmssRWMXa1leWuPIEVcvUI1JQ8R3SHoCeiqH/25L635+OgHMNv1XhdHHX7CA+j8yU8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=zJGAFLUE57AN2butCFI1OOypDQ4H0XOSVaBtvccaQoE=;
 b=X+BmAd9cCHkKQpdQUR8cG0Bbnrgv+BI3y4WMRdlpa8Ek/59bVzKE9piNfwmziYu7uusSiAdjew+ee4DnNoibVXp1b5CmbJ8RXnNyFbE+bWstnSL2YiSpuwAVbRMAthUacdFueINFGpiSwU1NxgJ+bgw1639+7HaM3hiXetKE8Q6iG06vrL+kcPdTqn/sbGLh57NsQ+EU/WDXgqrv2tZLpM8Znba/lx50mFH3Kd3xdcGYuQrFbc62h/c3h9FWORJGTyOSI+UliYCfSXBOjUmG3rrX8AIpFFqX+n/o8faWOLXN+W9cPU5Pkq8SVOqp8x/AirJXHcKrHqK/xWOBRxwi0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJGAFLUE57AN2butCFI1OOypDQ4H0XOSVaBtvccaQoE=;
 b=I3mivXvc8VTtEPVFNcgw/+FZrGS/sWKNUkw4P63MwjztsLbwuf2/veNnu6Mt/fVxXdHlnR2YJfOYgTpT94n/wIsc3Ho3kF04r3Y3CHfquR4LNEMVCROlNJAShxnh75rA3/6FqhTOSdUNpclHpTPmldfhxP57sstfXhPqv25WXGc=
Authentication-Results: fireburn.co.uk; dkim=none (message not signed)
 header.d=none;fireburn.co.uk; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 14:20:09 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 14:20:09 +0000
Subject: Re: [PATCH] drm/amd/display: Add NULL checks for vblank workqueue
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Roman Li <Roman.Li@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Mike Lothian <mike@fireburn.co.uk>
References: <20210907141058.90751-1-nicholas.kazlauskas@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <25922a3f-82e4-efb8-78e2-7292f000aa22@amd.com>
Date: Tue, 7 Sep 2021 10:20:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210907141058.90751-1-nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::16)
 To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.3] (209.195.106.179) by
 YQBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Tue, 7 Sep 2021 14:20:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88886d86-57c2-4a5a-abe6-08d9720a98d0
X-MS-TrafficTypeDiagnostic: CO6PR12MB5443:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54431583769365CE227251F28CD39@CO6PR12MB5443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqX4ZAdaLq3vWgv2kKDhmiAvNm2wpAK9aWHzxicuVccWSAbqTtFpHKRxYS3U3gY8sleQh2F+NTr/KBv+WbnIRemXR91HUPZNtFhUoI42QdsOqZtzD76fkEWrb+7yWTmBC/53tb2TgzBGSwwaYq9wuRNF+/rbDJy0RYpN35n8ZCc1D9AES9zZXwKlxwpveUcBQ/uEeC18meS2YgpAGtobeLk0tYZtjDNKcQ3NhfcsG5b74wZDIHRmio/5mgom66/idaVxo5PHFXLCjQoiZxQfSg1LyWrQ6ZB++/u5ECkmr4S6swcvWhUArqTG0n6I69CHQ5ZG6mVjPj0w5kZVsTbeLkUXK0nn2LpsmUA7kd9oAOgw+vNmXQrRRTUFewFWRj78smLDKrJv+BXASCT1h+ps7zibmoQ2bzJJV/0WlgvSV/7ICpxoA+2B2Nkukq19A04KqBPmipP4iZ5IEeCiZbOG16rdGzLy62FNGqIGUhlo4//6JNBdWPAxTM5qPRLaAieojwCNlBhJORVy2tGzTO5WIl2x0LLxTHuyio69M7FYSj4BCl7JOJDI1obh3CuMZ0/cpzvfQUtLd6IvqUzWD5LBHvKL5RmLX+aWKHw9RHnxvUza5wATtOAAw/u6YbiZy6VBdvZ7LvU9k8JeRXVO35bn1c2kTkT8gSn6thI7WEf+SLHCyzDrWdsoYycmQkkYrOqckd7y8nA57ftvZFQoVvHzWlWtfnWpvx/XQOO1h7uMqdg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(8676002)(2906002)(6666004)(31696002)(8936002)(16576012)(66476007)(53546011)(956004)(316002)(66556008)(54906003)(31686004)(38100700002)(36756003)(6486002)(44832011)(2616005)(966005)(86362001)(26005)(4326008)(186003)(83380400001)(5660300002)(66946007)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzNLcXRFYkdXcnFxTDJvbkdDNXR1KzJIcU1wSWNEeW02OG5FZjkvS3hSMFYz?=
 =?utf-8?B?Uk1mTUJGWENiQzZWaFhBZ1Q4ODg0QTBNRlM5bTBMeXpQb200QW5TVk9ZVzNR?=
 =?utf-8?B?WW13M2d3bFd2QmNuYnhhVGdrUXpNR1BjTHdPVURHeUJINUFhWVUvZm1BRDFM?=
 =?utf-8?B?dGg3N0h4Q0Jhd0E2WU9ZdmQ3NjljNTVaOHQrcTlhUG1sRTlTaGtOVkF6U29u?=
 =?utf-8?B?M0IxSGJIWUlPS1dxSUVxVFlJQUpuOCtVV3FCbkxCYnRUMlplR1Z1Z0RMUnk3?=
 =?utf-8?B?VEdpV2lOd0lqMHdtQk5DdkZxQVliaVJaT21pWWhRb3k1cGlmWVd1aFcvMTZz?=
 =?utf-8?B?UFV0cTI4U3dpa05UWDF1Tk1TMlhCSFJua3N5akh6bzY1L2FzcE5XTDEza0Yw?=
 =?utf-8?B?V2NKWGhoM2RuOGl4WmZUSThlbitQR1YxRU8xUk1oR0ZRSUowc3BBbFFjSFZm?=
 =?utf-8?B?cWcxTWgrRmVqa0pxQVFHUXhjMGRGOFRYaytsR1AxekZlNkIrUTltWVFyTWtJ?=
 =?utf-8?B?aGRxTU5GdDZCSWxCejhEQ0drc3hwNDhJRUNqZjlZcG5xWTRQbisxY3FyMGNu?=
 =?utf-8?B?RFhodFgvZWQzaEFXRDFVQ3BxU0VlKzlRVVdwbHJNb2VRQlE1OVlQTEZ0dnow?=
 =?utf-8?B?T0tmcnYvWEtDaHZzN3JheGVYcURsUWxOcVFNY0VjVkQxcTdFOStyd2pnZkdN?=
 =?utf-8?B?TnpnN3o2bnBDK0tadTVqQkE1L1BnYXRSQ2gzbWJtd0x6aDNJNEh6SE1YeEJl?=
 =?utf-8?B?QVpDWEJsT2pFLzFtMTJpS3NhOUlrZnJON0tzejRJTUpkQWxob0h4TzlBcmhC?=
 =?utf-8?B?bjc2MjRqNmdua1hjaytvU1BvWEFOVmN0VzdIOFNBa0ljMDV3RG1NWmxUK2Vy?=
 =?utf-8?B?UHdJK3JsUHRQL1UrdUF2WmIrWWZ4TkcvRHRpb3JBcEdZZ1YzSVJ5eXJyVVB0?=
 =?utf-8?B?VC9uNG9OMForWDhKam9wSDNHdmhRK1FxSXZJL0hpR2prcTJYNGIrd25rVlVs?=
 =?utf-8?B?MXd2Q0g1WksvY2h3bzNxL0syVkt3aTJQK3U4YjdWbjgxZXlJVFVMVjZ2RjND?=
 =?utf-8?B?NmJLMDhLdmMrUkh6QXEvZ0s3TlFCZzZaZGlKZWpyL3g3TUNnREFLRHE2QnF4?=
 =?utf-8?B?VkdtZ09kbldkRUw4RFlmUm5zQm92a2NwVmtXZFpwT3JCRWxycUpJWXlNdk1L?=
 =?utf-8?B?VDcvWlVtaXdWYVVucWdYd0wxRVZEVW1ud2hwdE9iVENBektLTDJLM2h1M0pY?=
 =?utf-8?B?L1pXTDVLakVYYmYwZU5KcXcyaHRSZUVXZFdtaWpiTTJQTnoyRkRUWmQ4eGJm?=
 =?utf-8?B?M1lVNHlZdTB1UFh1TUxQdTJEVmhyK3ExV3A5bVlzR3QyejVLbnZ2blVmZm1m?=
 =?utf-8?B?ZmJmdzVreW5XZmdOMXRYbWx0RjNTRm1VOC9WTzk5UTNXcmtSZ0JmZERTUERi?=
 =?utf-8?B?MjJUa2RxL294UUNZVTF2aEsyWFYrcUVXSnNVaTVkTS94WlR2bElCa010cmxl?=
 =?utf-8?B?TGplRUdlNXh0MUduL2dxWjZMc1FDK2J5cXZ4V0NTeEt2bVdkNjd5OHBZTFdZ?=
 =?utf-8?B?RS9nb2ZrMUFjeWtvSFBYRHpZUTNjR29RNHRwK0xxcERUYlZDZlVoZ0EwTTky?=
 =?utf-8?B?bzdXT0ZNR0hwbG9sNFcwMmtaeFRKYlB6a2VnaU1md09pRHNtK1NmTnQ5SXZy?=
 =?utf-8?B?NTgyZDA5VzEwNTZLZUJPSlZhRkZXd2hlNzZhcitwMkRqNTdCdWVkaVY3ZTl4?=
 =?utf-8?Q?NajeAf2jQ4j00Y3zjRs3WUt9fGYc3TgL+Kd03xl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88886d86-57c2-4a5a-abe6-08d9720a98d0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 14:20:09.4024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLVn2sEhvcWGe5N9xybMGuMsMJoWuMyIwR49qeCiMFcPmHB7oeYPIAbFhQvlrZuW5Jil9q/XFP4DHMZBlSM7jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-09-07 10:10 a.m., Nicholas Kazlauskas wrote:
> [Why]
> If we're running a headless config with 0 links then the vblank
> workqueue will be NULL - causing a NULL pointer exception during
> any commit.
> 
> [How]
> Guard access to the workqueue if it's NULL and don't queue or flush
> work if it is.
> 
> Cc: Roman Li <Roman.Li@amd.com>
> Cc: Wayne Lin <Wayne.Lin@amd.com>
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Reported-by: Mike Lothian <mike@fireburn.co.uk>
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1700
> Fixes: 91f86d4cce2 ("drm/amd/display: Use vblank control events for PSR enable/disable")
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++++--------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8837259215d..46e08736f94 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6185,21 +6185,23 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>  		return 0;
>  
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
> -	work = kzalloc(sizeof(*work), GFP_ATOMIC);
> -	if (!work)
> -		return -ENOMEM;
> +	if (dm->vblank_control_workqueue) {
> +		work = kzalloc(sizeof(*work), GFP_ATOMIC);
> +		if (!work)
> +			return -ENOMEM;
>  
> -	INIT_WORK(&work->work, vblank_control_worker);
> -	work->dm = dm;
> -	work->acrtc = acrtc;
> -	work->enable = enable;
> +		INIT_WORK(&work->work, vblank_control_worker);
> +		work->dm = dm;
> +		work->acrtc = acrtc;
> +		work->enable = enable;
>  
> -	if (acrtc_state->stream) {
> -		dc_stream_retain(acrtc_state->stream);
> -		work->stream = acrtc_state->stream;
> -	}
> +		if (acrtc_state->stream) {
> +			dc_stream_retain(acrtc_state->stream);
> +			work->stream = acrtc_state->stream;
> +		}
>  
> -	queue_work(dm->vblank_control_workqueue, &work->work);
> +		queue_work(dm->vblank_control_workqueue, &work->work);
> +	}
>  #endif
>  
>  	return 0;
> @@ -8809,7 +8811,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>  		 * If PSR or idle optimizations are enabled then flush out
>  		 * any pending work before hardware programming.
>  		 */
> -		flush_workqueue(dm->vblank_control_workqueue);
> +		if (dm->vblank_control_workqueue)
> +			flush_workqueue(dm->vblank_control_workqueue);
>  #endif
>  
>  		bundle->stream_update.stream = acrtc_state->stream;
> @@ -9144,7 +9147,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  		/* if there mode set or reset, disable eDP PSR */
>  		if (mode_set_reset_required) {
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
> -			flush_workqueue(dm->vblank_control_workqueue);
> +			if (dm->vblank_control_workqueue)
> +				flush_workqueue(dm->vblank_control_workqueue);
>  #endif
>  			amdgpu_dm_psr_disable_all(dm);
>  		}
> 

