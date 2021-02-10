Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2732BC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 14:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75C664E42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 14:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75C664E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F74C6EC8D;
	Wed, 10 Feb 2021 14:32:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28F3F6EC8D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 14:32:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgXgtTsKg+uG3TNMmzJPq1YyzfVKrCVlslBdkrxBp4zgmCysu/A0ts9kXpiW+1OwengmDHjk/sUV8OISOaJ53b/b4w4ollAZ5wjVjikmtkjWmtCG+SRW0ixFpqtbMfvSJ7xmX8DIoCVyAcy6+cIIfRjNs4eQDE2moqMV0bpzgVFAJqqUFwLRMVVukEXHN5BT7a/zoVrYZJJii71cWnBtCkSmvhW4gksbgyCZ0LEVt9PUnL+8HQOCSJ3ziRKj/m/vRpyF7KyfH02tGUqrpKaAJgqI0Xcd6CVOkIvufog7lQzVwzsIN924Ycioh+CRqHnoVGRcdoKd7WGKYj9kI938cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saBvgxi9miu3aOj4vJuQFYXDMxGbHnpaxfk9j36HAec=;
 b=bx3LXPGG9vnukccealQrZ+aaVcairExdj0f/RoJtq2XNvIZQjfwrvmQlf2mfSU9VJYleFpXdRhl5nLbbWcDeCQA+BRwHLqx9pzotrq+VSn/FXgtKmtSE859ERzHEzLj/d2akorVnACJcjNotQGXaUIqx/JdCJAGV4iLoYLOk7Pi7tH0l5NpfiqzWdoXYsetc9ZKjcEjIGk19L7ByiuEDhirDbAC2K6RWTItXw67QMGrDKys3lur/RJwBppScviS+HGvoUyw5VOwDSGUx9bH8xr9viT9TTgoLiE7C7ZCkRZE1sWhchFCAAhuAYfITTG9QFyYF8E88iKGicaQz63CGLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saBvgxi9miu3aOj4vJuQFYXDMxGbHnpaxfk9j36HAec=;
 b=2P+QLjmCNrq5dT9bekRlvON2Syi8lWqlbN+rMzIY4cPfk8QbUJO/6QsDJIysOXY5R8/gU38XWp0IO4hJroO2BURgSoUAuWgBcrsZ3/ZP6h/gs33iI570KicBFYLOFdSzGSqfQn8KQwUR0zxShQ4n+BTIkvwEdJR6RIUhPfcHU9E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Wed, 10 Feb
 2021 14:32:48 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f073:f3ea:6ce8:1956]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f073:f3ea:6ce8:1956%4]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 14:32:47 +0000
Subject: Re: [PATCH] Revert "drm/amd/display: reuse current context instead of
 recreating one"
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20210210142537.1629905-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <2553a272-ae78-34bf-de8c-30aa7803a755@amd.com>
Date: Wed, 10 Feb 2021 09:32:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210210142537.1629905-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [198.84.165.113]
X-ClientProxiedBy: YQXPR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::40) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.180] (198.84.165.113) by
 YQXPR01CA0111.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:41::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19 via Frontend Transport; Wed, 10 Feb 2021 14:32:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cdac5b3f-9f95-4d28-2f74-08d8cdd0bc86
X-MS-TrafficTypeDiagnostic: BY5PR12MB4292:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4292637DA2BE2F51FACCC61BEC8D9@BY5PR12MB4292.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 77hHTz6vgBMDVhX3omW5GQ0M35DfATVZyt6No7FIGA7MaJ0muLXIq4/QENb2Z3G4lH+xHduBgjZD7PbNofAP0H8TRKOjaKMuXzM/Y8UrdEMScF+b9uP3RGZapBBfZvp9XLnAqvQIwDF8aikuBbGAh+OCu/yPrLk9bwZf4Pay68EK3LE9lX4OoPkxJG3Uqlb8Jng0hoGnruj9K1VSA0XhfrX1f0bjoY3gLDevczZ6qiLiU0KIFyAquvNGBEmT5ZnyLMy21TDxHp0vbAZ+4CeB6e1rppe7Drfiy10Hx071WLVq4+JTFv/vJ3SJL9ITzX4hZgBX3K6Nxf29p/ylKLBBSfLI1IYBT0MfImDEwcL0i3dSkNwCYeenubXf08bjCp1ISZNGV/h7Q8MvN0DYVlE9D8emNxdOaFPjXe+JK/R0WuuaDsq0I9OWrkQEfyNd/vH2Aha2Fu4xmfC+T2XYiMxGLrWVifNiTSWmVAErdf7obiXT8JWo0+442/iXXhVUoR+hpq29NNIsauFdc2Nd67eNvNHtRBuzjIAUWTMV1j+b3AGYkcIGzpvicvDvKkcFitv2Ix+veX7hZO89E+7vzWUo+88usrz7KJDQQlsrTvLd/tov2o5H8yXWAcXXVXDitLyWICElZgd4aG9reXz6mqRO6fnMd7uoqFMForXJymDo8WHv+5P1Px5n4r9SQKKm4VQR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(66556008)(66476007)(316002)(8676002)(4326008)(36756003)(8936002)(186003)(53546011)(83380400001)(66946007)(956004)(478600001)(86362001)(2906002)(52116002)(966005)(31686004)(2616005)(16576012)(5660300002)(26005)(31696002)(6666004)(6486002)(16526019)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T0Zkb0NUQStuOEx5K3ozSCtWaWFKK3c5MFBFdFAzQmRUWGFWNytBMkN4RVdX?=
 =?utf-8?B?M21idXVndDlHL3V1ZngzblorUURKMWFidERkeE0xOVVhUlUrU1Z4TjMrRGdw?=
 =?utf-8?B?M3h1Znp3cmVrNWlFR2U1cUsrT2FtWWJxM3VtKzZlb2d2L0VLWjhmTloxaEM2?=
 =?utf-8?B?Sng1bE5tZFdjQkpueXVEcDU4bTdGM2F4ejJ6LzhXNWtSWnVwc3M2VUdjWis3?=
 =?utf-8?B?Umk5eHh3bUFLVVREVlMzeWExRHRJUFQ5dXRkelo3T1I2Vm9ubkFwUkdic0xm?=
 =?utf-8?B?UGQwS2VIVGM1M0liVzVYeENOOXhvazNCSmoraVUrQjZnc25kMitqUVh1a0hY?=
 =?utf-8?B?OWxTK09KdnNiYVFKWjBMWllzTVNGTTVzb3l0V0FHaXFxQ1creWhYNUJlcUpp?=
 =?utf-8?B?WXZOd21DRGVPblV0N09sMk14TGU2Y2I4YkVrWUZ6OGlBL3AybndZeDBLRzlh?=
 =?utf-8?B?bDJNMlBaOEtpSE9nWmdNb25nRmQ5NG9RQmdVckljQytrUm5yWmVNMklPM2k1?=
 =?utf-8?B?Ym82KzVzekVpN3FibHl6aDdLaEl5MGlrakFjMTJtRVhhbFlyamM0azNlamRr?=
 =?utf-8?B?T2hZSklIaitjSU5WanIzK3RTNWtiL0lPSE05Rmt5aXdtTkI2dGUwbWMyNFgw?=
 =?utf-8?B?UDdVVlpSdXJ0cllhNVVZQWdNalByVk5hUG92Tkl3cVZIMEQ0cEFxNHlCMmdn?=
 =?utf-8?B?YW4ycVNvZmtXcTcyTDI1UUNZb3VTWG14bkxnRHdINUZMSjJ1V2dHdVZKZzh2?=
 =?utf-8?B?UytKWW81YVRZU2RLQThvTEZOTDNBWHlNcUhLdXRjQ2srVmg5aHNUUDE2eVR3?=
 =?utf-8?B?SDZ1bjZsU0pkUytRc1JwRHFZRzhzOXYwdzFERWxpQ0hTSXNiZ05XMDJyOHlB?=
 =?utf-8?B?SFhObTdJUWNxd3VscmQ2YlY2WXZsL2xpV3hlWTBraWRsSXR6M3NjSEtFcTdC?=
 =?utf-8?B?Rk5XSFdReDhQQW9oeEhMelo3RStnRmljazR5dXNUeHNNZ3FtQXF1c1U5Rk1n?=
 =?utf-8?B?bm1MdHBxMVVRZWtWeGFJS0JiMS9oa1BMZ1lXSzJueUF0Z3JUVHp2SkVYajRH?=
 =?utf-8?B?NHdIZlJwVVI2dURUdlhIb1d5eGMweHFlcDFrbGgrSmYrUlpJckVFNTNMQ3FV?=
 =?utf-8?B?R0FPM0RRVm0xS0M2Ukh2cHhPaHpUL3ZrNmpFN05Bc1RlR2lQd1RsZ2dFcEZr?=
 =?utf-8?B?OUFTeWo2NWNGMWZOa21Rb1NHRHdzVHRMd3JZYW1CUlpWM1lyS1Vyd09nSGNp?=
 =?utf-8?B?NDJQZ2FlMGcrT1JTWXBCSXFpYlRCTzJnUHN3dzFTZUQyaVdqVVRRNFR2Zlpp?=
 =?utf-8?B?ak5NYm4yYUVodWptZXAvUkVoUDBBajd6dUd5YldSZ0srNnN2VG15UkRYY1NL?=
 =?utf-8?B?cFl2TVYrdGlpSm5MZFUxT0tSMWQ5UllULzBGSVlKY0FrQkk5K0N3UTdvZlEz?=
 =?utf-8?B?UFkxOXFrR1czNjB3WEc3eVV3a1UzakM2Y2FlZnRuOEYwdGNCTDZHQi91aE9k?=
 =?utf-8?B?eVkvMEcwNTFkcTJMUXlCNEJnblR1WGJMNlJYVTdBWTJOU24vWmtCZm1YMlFK?=
 =?utf-8?B?c0VldHJ4WTErSDVrSFlzUXhDdHA4cW9aOXFibXF2azVyUTF6ekFCbFg4UU5R?=
 =?utf-8?B?Vkxma25pRkhhSFRrUFBtODRUL3FEelhoaUxJUTF4Y1dKV1oyTHA2WDRhYzJS?=
 =?utf-8?B?emNJbllQUm54eUNlSE5wT2RKQjhxNXM0MjdGRDNSYlpZSTRvYzRpODBkbzRI?=
 =?utf-8?Q?EeQ3V4mgwC7GWZntHW0rQaF96nMY5GrL+vG1OYm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdac5b3f-9f95-4d28-2f74-08d8cdd0bc86
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 14:32:47.7284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c47BlDStfTpPL+Fg6/9fLzBERei8xBzbtVCoVeMPfvpu+wEbpjTzQrpTT7pK/ECVhFkETgJpaHQ/uLxwf5sPEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-02-10 9:25 a.m., Alex Deucher wrote:
> This reverts commit 8866a67ab86cc0812e65c04f1ef02bcc41e24d68.
> 
> This breaks hotplug of HDMI on some systems, resulting in
> a blank screen.
> 
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=211649>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---

Hotplug is still working from my side with this patch.

Same with our weekly testing reports that Daniel's been putting out.

This is probably something environment or configuration specific but I 
don't see any logs from the reporter. I'll follow up on the ticket but 
I'd like to understand the problem in more detail before reverting this.

Regards,
Nicholas Kazlauskas

>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++-------
>   drivers/gpu/drm/amd/display/dc/core/dc.c      | 27 ++++++-------------
>   drivers/gpu/drm/amd/display/dc/dc_stream.h    |  3 ++-
>   3 files changed, 23 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 961abf1cf040..e438baa1adc1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1934,7 +1934,7 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
>   		dc_commit_updates_for_stream(
>   			dm->dc, bundle->surface_updates,
>   			dc_state->stream_status->plane_count,
> -			dc_state->streams[k], &bundle->stream_update);
> +			dc_state->streams[k], &bundle->stream_update, dc_state);
>   	}
>   
>   cleanup:
> @@ -1965,7 +1965,8 @@ static void dm_set_dpms_off(struct dc_link *link)
>   
>   	stream_update.stream = stream_state;
>   	dc_commit_updates_for_stream(stream_state->ctx->dc, NULL, 0,
> -				     stream_state, &stream_update);
> +				     stream_state, &stream_update,
> +				     stream_state->ctx->dc->current_state);
>   	mutex_unlock(&adev->dm.dc_lock);
>   }
>   
> @@ -7548,7 +7549,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   				    struct drm_crtc *pcrtc,
>   				    bool wait_for_vblank)
>   {
> -	int i;
> +	uint32_t i;
>   	uint64_t timestamp_ns;
>   	struct drm_plane *plane;
>   	struct drm_plane_state *old_plane_state, *new_plane_state;
> @@ -7589,7 +7590,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   		amdgpu_dm_commit_cursors(state);
>   
>   	/* update planes when needed */
> -	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
> +	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
>   		struct drm_crtc *crtc = new_plane_state->crtc;
>   		struct drm_crtc_state *new_crtc_state;
>   		struct drm_framebuffer *fb = new_plane_state->fb;
> @@ -7812,7 +7813,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   						     bundle->surface_updates,
>   						     planes_count,
>   						     acrtc_state->stream,
> -						     &bundle->stream_update);
> +						     &bundle->stream_update,
> +						     dc_state);
>   
>   		/**
>   		 * Enable or disable the interrupts on the backend.
> @@ -8148,13 +8150,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
>   		struct dm_connector_state *dm_old_con_state = to_dm_connector_state(old_con_state);
>   		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
> -		struct dc_surface_update surface_updates[MAX_SURFACES];
> +		struct dc_surface_update dummy_updates[MAX_SURFACES];
>   		struct dc_stream_update stream_update;
>   		struct dc_info_packet hdr_packet;
>   		struct dc_stream_status *status = NULL;
>   		bool abm_changed, hdr_changed, scaling_changed;
>   
> -		memset(&surface_updates, 0, sizeof(surface_updates));
> +		memset(&dummy_updates, 0, sizeof(dummy_updates));
>   		memset(&stream_update, 0, sizeof(stream_update));
>   
>   		if (acrtc) {
> @@ -8211,15 +8213,16 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   		 * To fix this, DC should permit updating only stream properties.
>   		 */
>   		for (j = 0; j < status->plane_count; j++)
> -			surface_updates[j].surface = status->plane_states[j];
> +			dummy_updates[j].surface = status->plane_states[0];
>   
>   
>   		mutex_lock(&dm->dc_lock);
>   		dc_commit_updates_for_stream(dm->dc,
> -						surface_updates,
> +						     dummy_updates,
>   						     status->plane_count,
>   						     dm_new_crtc_state->stream,
> -						     &stream_update);
> +						     &stream_update,
> +						     dc_state);
>   		mutex_unlock(&dm->dc_lock);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 6cf1a5a2a5ec..58eb0d69873a 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2679,7 +2679,8 @@ void dc_commit_updates_for_stream(struct dc *dc,
>   		struct dc_surface_update *srf_updates,
>   		int surface_count,
>   		struct dc_stream_state *stream,
> -		struct dc_stream_update *stream_update)
> +		struct dc_stream_update *stream_update,
> +		struct dc_state *state)
>   {
>   	const struct dc_stream_status *stream_status;
>   	enum surface_update_type update_type;
> @@ -2698,12 +2699,6 @@ void dc_commit_updates_for_stream(struct dc *dc,
>   
>   
>   	if (update_type >= UPDATE_TYPE_FULL) {
> -		struct dc_plane_state *new_planes[MAX_SURFACES];
> -
> -		memset(new_planes, 0, sizeof(new_planes));
> -
> -		for (i = 0; i < surface_count; i++)
> -			new_planes[i] = srf_updates[i].surface;
>   
>   		/* initialize scratch memory for building context */
>   		context = dc_create_state(dc);
> @@ -2712,21 +2707,15 @@ void dc_commit_updates_for_stream(struct dc *dc,
>   			return;
>   		}
>   
> -		dc_resource_state_copy_construct(
> -				dc->current_state, context);
> +		dc_resource_state_copy_construct(state, context);
>   
> -		/*remove old surfaces from context */
> -		if (!dc_rem_all_planes_for_stream(dc, stream, context)) {
> -			DC_ERROR("Failed to remove streams for new validate context!\n");
> -			return;
> -		}
> +		for (i = 0; i < dc->res_pool->pipe_count; i++) {
> +			struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
> +			struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
>   
> -		/* add surface to context */
> -		if (!dc_add_all_planes_for_stream(dc, stream, new_planes, surface_count, context)) {
> -			DC_ERROR("Failed to add streams for new validate context!\n");
> -			return;
> +			if (new_pipe->plane_state && new_pipe->plane_state != old_pipe->plane_state)
> +				new_pipe->plane_state->force_full_update = true;
>   		}
> -
>   	}
>   
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> index e243c01b9672..b7910976b81a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -283,7 +283,8 @@ void dc_commit_updates_for_stream(struct dc *dc,
>   		struct dc_surface_update *srf_updates,
>   		int surface_count,
>   		struct dc_stream_state *stream,
> -		struct dc_stream_update *stream_update);
> +		struct dc_stream_update *stream_update,
> +		struct dc_state *state);
>   /*
>    * Log the current stream state.
>    */
> 


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
