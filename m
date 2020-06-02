Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA9EC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 21:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A6D206C3
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 21:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="foY1X90+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A6D206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB9C26E46E;
	Tue,  2 Jun 2020 21:50:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE446E46E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 21:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPpj1M17azw4WfwUeFCFXYtL061icySTVojAzlDmFLI7EaYJAUeQPZNNgfcbHt4VPfN4sS0eY2M++XhxNgauoNAMO7XxfaT3ILvp0tcXUcBv5fegKz1yG/6+kQqoixFOoex8juOFd0nDjGqbPOBqvsSjOoV0jQJGqq8FHrcA+squ75H7v+ApTNxuT1rV6Wfic5g1cwXsXr45aR0OvTXfKsRMJOnof76ldxgYA8KpBwaTd2DAgEfTnwsE2OVToj68sHpJ1E182KVAGcLmjrD1evsQTrQ97dLXygQ8EPjdRKRtbUUEnSQfsA6iOeUrQR4bjf90MZLn8mKIFEgGVpt5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5PpXSdB2VO+YLS4Adl+lr6EBqpiTaikI8nlxhyLH5Y=;
 b=FIYEvmMW42ktVPpqtgIvTi3+K3iXWph1Z42mYmqmbeYD11ob8XR0739wbPHaYAhHJWk54zKL1ZVAoaj1ndkEvbYytRDxg+uSS7Hx9xFbglr/8KVWwTlyhiyeVfQ6EfB4ypLG0yC4sNsSOxae8/MjJWdeQhSkOkacXwxGraEbFmBYdL7D+agLvUILdBDBHgjqHZcXob4uRquJEIYecwWey2sTnrEvx/euPVTVx12ffI7UzpupSoDbAMAMSK/XJM5storhzErMc7lcxakSXZ4pRnzRNG7zX9FL8ecX5zxD5avsa7FgCGIEVDbbcuzcFJuJVbC/Lz4lQ1mhHY82HDg5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5PpXSdB2VO+YLS4Adl+lr6EBqpiTaikI8nlxhyLH5Y=;
 b=foY1X90+PKiqYguZTq+i6g7qRj0eS6sTRkJEPR3Z2+ZPTNewq46mJ/18XcraLqJ288DN4F4B9Y6Qe0tCY6x6cTaB2KWPtEV6eMWBN+TVS9tv8qaLQa+t1fftzdvN8DJRV6PMGXkIhiDL4XkylVxfqLeUQJOnZg9pbO812PxrM1E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3334.namprd12.prod.outlook.com (2603:10b6:a03:df::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 2 Jun
 2020 21:50:07 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 21:50:07 +0000
Subject: Re: [PATCH] drm/amdgpu/display: use blanked rather than plane state
 for sync groups
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200602212533.1621557-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <cdaa19a9-7557-43d6-65f1-a9b0b29c7596@amd.com>
Date: Tue, 2 Jun 2020 17:50:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200602212533.1621557-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::16) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Tue, 2 Jun 2020 21:50:06 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eced157a-2537-4215-101a-08d8073ee9f8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB33343C2FA27FE49322BC871AEC8B0@BYAPR12MB3334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMG1rwgdnLYz5EGHAhjiHY0p8vIAiW91MbldxJ+ufjhMNxBAUwYx7onCxm/IGGemTe8Rjd4HywdxGWYKGuwQQbEMkw04EPTNWPn6P7TYsX9ci7S0zJ5TL+y0QtQwXZyiNRWxPL6hM1ZU6QKXG+qlnVfjG0YxpGMn2OodGcT0ZQnuIjjuuDdqm+jYa6D90NXXlgDSGiz87Vgz6pJrMLF4tnYH5SdWBRWwqKwxfxavegPgfqg+Cq9sYjUyKFTK9dnhigVCfkPsKQFXmZWj1UdJxprwWy5tsbYz9uzB17zsTCA4kJTCRqcyWfuyxFJXjPposkk/tnDph+LYBM0P3ydZ/K1anOTu1Yfs75vcqf7X4Welddon3sQBxlQ/lfVeIbo9PfCwYUBqesDEP6lIzsve7u/jfvPX973vmpPRY+8eZiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(16526019)(186003)(53546011)(4326008)(6666004)(6486002)(52116002)(36756003)(26005)(31696002)(66556008)(66946007)(86362001)(966005)(66476007)(2616005)(956004)(8936002)(5660300002)(478600001)(316002)(31686004)(8676002)(2906002)(16576012)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: m+CR628o/ROpM2ZnQifGmIq+o3APAV52E7P89MBPThJ78SPcop2Hic0w+xtM0CT8S4vc1IWWAOrfIqNQv5GxiNXzqqxC29e0C9IGaQMtv08wkVAC1zbTD0NuJvO0SBRQfqh4HHekj8+QkprqSMAKfKxEDxhN+bRk3KUrWFcHdkZU8CbSTYSiNuB94z0ZLJoh17WmIM26TP3rnYw+xHXvtUB623O+56vIr2BxVlv6B/JWloPJ3crYHx6GDM4D2plOu8wK+TgPD10CNcyJ8B+biZS0ex7y1P7JuKCf7WJvV0VMt4tpk3INwPMZalhjqVbXNmcQbNmgF2isjClK2awu0PqJgrhZzg4GNtwEMu329QF+gj8+V3Sb6adb7b5lJKqYoUg7SVYt0ZOTSSDTWJnBqDoBazNzJh2ola9RlxVD7uzA8TLztTgs7ZwJb4KbeV09tJb1t5fY9/iTEM+ftBr24YWgdOFnHzg8UAahJQwPL+aNr2ShGzmwqH+FEPdzpqg4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eced157a-2537-4215-101a-08d8073ee9f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 21:50:06.9509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXpfN1D0MLlWyuGKbMRJDAYi8H2qUp17nCY3Mn6qrADKz1RHzLgbSBqUkIUBqjBg+7PF3y8jfF0qjnnTYtMaog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3334
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

On 2020-06-02 5:25 p.m., Alex Deucher wrote:
> We may end up with no planes set yet, depending on the ordering, but we
> should have the proper blanking state which is either handled by either
> DPG or TG depending on the hardware generation.  Check both to determine
> the proper blanked state.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/781
> Fixes: 5fc0cbfad45648 ("drm/amd/display: determine if a pipe is synced by plane state")
> Cc: nicholas.kazlauskas@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

This looks good to me now from a conceptual level. I guess we'll find 
out later if it breaks anything.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 04c3d9f7e323..7fdb6149047d 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1017,9 +1017,17 @@ static void program_timing_sync(
>   			}
>   		}
>   
> -		/* set first pipe with plane as master */
> +		/* set first unblanked pipe as master */
>   		for (j = 0; j < group_size; j++) {
> -			if (pipe_set[j]->plane_state) {
> +			bool is_blanked;
> +
> +			if (pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked)
> +				is_blanked =
> +					pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked(pipe_set[j]->stream_res.opp);
> +			else
> +				is_blanked =
> +					pipe_set[j]->stream_res.tg->funcs->is_blanked(pipe_set[j]->stream_res.tg);
> +			if (!is_blanked) {
>   				if (j == 0)
>   					break;
>   
> @@ -1040,9 +1048,17 @@ static void program_timing_sync(
>   				status->timing_sync_info.master = false;
>   
>   		}
> -		/* remove any other pipes with plane as they have already been synced */
> +		/* remove any other unblanked pipes as they have already been synced */
>   		for (j = j + 1; j < group_size; j++) {
> -			if (pipe_set[j]->plane_state) {
> +			bool is_blanked;
> +
> +			if (pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked)
> +				is_blanked =
> +					pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked(pipe_set[j]->stream_res.opp);
> +			else
> +				is_blanked =
> +					pipe_set[j]->stream_res.tg->funcs->is_blanked(pipe_set[j]->stream_res.tg);
> +			if (!is_blanked) {
>   				group_size--;
>   				pipe_set[j] = pipe_set[group_size];
>   				j--;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
