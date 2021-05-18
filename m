Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824B3C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444B7600EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444B7600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E9C6EBFF;
	Tue, 18 May 2021 15:37:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5152A6EBFF
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 15:37:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW+ZNEjYzXFQSIe//fqMOXP+pFsC/0jWH3qInEi2mf4kS387rQilGaJ8+aSlkiZGByLnwq+R0YpZ6c8fyIKYjluBL8o6q9rKJDkvqlleOuGQVMUIYWInWZ1iMF7KE5c8bSR3s5GlWpzEIk77ft5ZnnQIlTQVdngQpgwOqiZJWviEBxzwrES3i1KN6swIO6+OQKXB8p2ququju4Io9hy2mX1k0/nVqCNjFVav1eqZrYcNS7bXrXWGbwoZAQdTubCqzStZHaAwo49boXVi2Gvh0nuU5XXDIYFAVqI+rZFP8be88QeFxiFgoftVD1DxktY5+9nuSz6RQyyw78ctHYFNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTxdoytzt4sPK4wa/gRg7GGuoBeI0usyhLzL9zqMNYI=;
 b=YyqITJRTuH6yo7w/88iSPJo0C0aUdDHc1Talf6dQC4MiJWVQhRFI8VCWivvn03SnqO41p/aI4CTG9JCckw/Y14O5MPgXPRM86GNhIoZW8SFLrBwlqIloKyTqGki2kceg/Gbpkf7tPh+FB3TGIysH29mS/E7+g5fOw7mOu3oKydV7oamAKsg9Hs7Sn3x3x1paXZYdNSwO3lCuYHnu/Mun2DoBBOBavp+pqx6d3qcCwypYMeVM+xWYOjiI0C5wXW00dblDxjXixdig++iICkNLoroYUmF/dBsNElF4ThuLGxecY+BRB4MzIsbLANKtxyQVgUiudhPaeOsPlJZ/CS0q4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTxdoytzt4sPK4wa/gRg7GGuoBeI0usyhLzL9zqMNYI=;
 b=f0DMKhHHOadSh0lysUccbl0MWXX1UFZsz0otxgizizPmkEubmN7iGQXv7cMR/tHLGdD4hnmnB5EJH4snuvb4psC/nzfNNq4TIb+Rt+7PpDxPdFfJ5LLIvAzG4bm91VzIaJ/mVUEOEVa4GpSQI/GYGdt+lLdw/PgJR2XYvqOhbOw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR1201MB0254.namprd12.prod.outlook.com (2603:10b6:301:57::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 15:37:43 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25%4]) with mapi id 15.20.4129.033; Tue, 18 May 2021
 15:37:43 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu/display/dc: drop un used variables
To: amd-gfx@lists.freedesktop.org
References: <20210517190809.1943517-1-alexander.deucher@amd.com>
 <20210517190809.1943517-2-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <3f80f93b-12e6-4087-5ae0-4e12b3d88859@amd.com>
Date: Tue, 18 May 2021 11:37:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210517190809.1943517-2-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YQXPR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::28) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YQXPR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:41::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Tue, 18 May 2021 15:37:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91f84bf4-2411-4df3-427c-08d91a12e0b3
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0254:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02540EAE837B4A2D4ADA60208C2C9@MWHPR1201MB0254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLPEXv3zND5w2LQPud2t1ZKPkgVKZSJOYu5usJ9yJurMWRn5dFSTtyuGvci4kOqOBPKUsGKrwaVmTT52sms2/YFhqLnblm/YU+eQeqQdP69ML3aANKsMke5YvueG0CLqJzKoftzSEl86h1lsJ+ix6QSXF33lH7C21ubyzx72cb9MSs7sTq3n3qTBhAQG0++KfFNRzO4SrdQR5vHWpkXyjbaCAewbSFZaS2F54FyrRvDdXrXTN6KiBPlnqxM07B91XzmIfyteWhPiiEOB4+0/lLYAqG6LChBZHHlBugLcWhiUzvEH/RlFjx2JB9cQyae7EIMj6OAUzMUBu0rdYdseX7Xwk1Pa3mHX0778XkQgV3j+Ln7cAEc7zYNadDnO2i4dGI69W3Rbc3hnLEg92dRLhnVKBnym7jmyTJZOzrCzY+7T87LDBrASRK6uYsHJnLr3eyi2jNeuMGlZyNfmtDwwV7vJgI31MkUp/fWLNpOstioQIHOdFZipENiJagW0eTA6VVwqO7DIMp5XBZ/rzNVEdP8PChA2TfVEN+SpCR+nDJ2PSALLNtdAgAc96YiJHswWrZMYDILn5mowPaD4ic9Jz31DAUaO2vPqqCuUYdFW0FfBKtsPebTjj2KXyvnQYr0XGCCwKRKqC3F8CQzXzjNTDY2lJO7X0ynhDUb6kHrLtbTMjkAhEKbaYSzcDKZtDQQ4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(44832011)(478600001)(36756003)(16576012)(38100700002)(2906002)(83380400001)(8676002)(6916009)(316002)(2616005)(956004)(66556008)(31686004)(31696002)(16526019)(66946007)(8936002)(186003)(6486002)(26005)(66476007)(86362001)(5660300002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WU1ZZnJIWklJS0J2UHZQNVdOcFQyMmIzUm5BR0ZIOTNPazhqb1JxK2xQTmF1?=
 =?utf-8?B?WmxHUlF3MkFRZElFK0xxWnhVdjd2RU1tbGFRempoQTB5QWVQbGlOZTdIYXZa?=
 =?utf-8?B?cndmSEZ4MDlZdVgrS3IvRlBrTkRUTHVzMW1ZcTNaVDZWZDNHcTFnUUJIZFBx?=
 =?utf-8?B?NDk2Rlc3Yk1NYjkvWWcyVllBRlNFdVhjMG1sSWh5Ymw0SGYvMjlGTDFMYW1S?=
 =?utf-8?B?RnB5dVpZUndTcjlkYll0V3QzUEhjbjNJcWtoS3R4dTBUdkVIZXRaRkdiZTh4?=
 =?utf-8?B?SVFZZ2ZWRGEzMlN1eFo5dXRQMDJFSEdtSEovM0ZLcEJtRUw5NmJtMjQrTmxM?=
 =?utf-8?B?K0VBTGpIbHo5QlRjTlVnRVh1eXdCS1RCZjJoQWpITnhveG1tTlB4WVVtS3li?=
 =?utf-8?B?cTlRUlRKQ2tEdkZheFZSaFZxNm54V3BzYXIxT001YUo2elB5V0k1THhFZnZk?=
 =?utf-8?B?UlhBT1RGcG4zbC9NZUE4Q0dCWXB3ZlNTZGxTc3JxQk9XdllQMHJzOFBmRmVJ?=
 =?utf-8?B?dTNRN1ZNVEpyTGZ2R0ZCNVE0VWpOOHpKdjJWdm1UQjhJL1FYbml3SGZoSHJU?=
 =?utf-8?B?WDVXc21vZWJOOWQ1ODRFUS91eGcyVnVxS0s0bWNFVG5iaHlzalpnWExZK1lp?=
 =?utf-8?B?WjVhaGdWWGxETHJKQVJoV2o3TGJYeDJGRzJiS2FxZDFsMzNWS3BLektCcEUy?=
 =?utf-8?B?WGNIZkpvQlBkVlIvWC9qa0w4OXkxdHFrczVYam1DTllvd2dYQlhXYm1KRFl6?=
 =?utf-8?B?WlEra3FKYUNMNktLM0s5WDVUeUFVTG1UZFZWRVE3SlZJTm5CcTI2QWlPYUNw?=
 =?utf-8?B?c1UwUDFpV2dDdTZvTlZTNTFCdnI1SXZHVXdzZHZ5cVJyV0lyd2ZVTEw3Yzd4?=
 =?utf-8?B?bTdMd1lUVXM2SkhGZHE3OVlkMFhNM3RCM2gvS1J2ZHNCSkg4LzZ0cjFKWEJ3?=
 =?utf-8?B?RmpRRFVXZUFicVlVSDNGRVZZUDJkYkNDcUVQTHpGSk4wakRuMDFBc0UwSHhx?=
 =?utf-8?B?ZHJMaVRzaS9hK0xkTXBLWCs0MDRIenNiRjJSTjZaMFRQWkNNSDZ5dGN5anAz?=
 =?utf-8?B?QWRhYmN6VlVGd0R1SXBkbE81ZW5MZzhRM0tHZlpXZUd0dFRuaG1SbzN6dzI4?=
 =?utf-8?B?UGRMKzY1d3UrVXdaemNySVRLRXJTTG15eVNNeitnRWZwZ0lleHc3czBFRkJ2?=
 =?utf-8?B?c2FUNEZCUGV5ZWsxUXV5Q0hFNnk4aUNKbEpiRXM3Sk9xZUE2NkErLzEvSm8y?=
 =?utf-8?B?RGZvcG9ISVh4M2F6bHh1T2FhREJTRjBKNEo4aU9XOWVzV3lsdGgxUW5ocVhN?=
 =?utf-8?B?bW1UZEhqU3dhMGpPYnl3Z25lb2tFbnc4QllXdUxidzIvcTB3UEhJV283ZkpS?=
 =?utf-8?B?b0QxSnFuN2E3U3JLRjdkT0RjZnZGOG9aUDNaZURodkR6MHRBQ0tQcmVNNkFi?=
 =?utf-8?B?VUZkRW1zWWJ5VXVjYUtCM25ZaFAvQm56MGxYemg3WFRPZ1F6N2ZDTHlCdTc0?=
 =?utf-8?B?V09Fbm5XT3FmUmY1L3dYNW9sRXpYSms3NEQ0bjIzRkgrbVlNZnFBM00vcXpk?=
 =?utf-8?B?ekxxSUxLZE84NWZNalVxYjdkUDNsNWcrNWM0RVNhRStnM05ZZk5rSVh1YWI1?=
 =?utf-8?B?R3ZxNFptcWZoeEZGOE1CV2ovSFRSUFR0OW9yS1lwakllMFNYcHU4YnhmemdJ?=
 =?utf-8?B?QWorUVQ4elJ5T0ZKdlNmVUQxamNSQTAyYllnL1lUTmhBWFp5c0EyUHk1Y0pX?=
 =?utf-8?Q?E6He1+tBHsvmvcgYnqU3itHteQFDaZnhGf7NM8Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f84bf4-2411-4df3-427c-08d91a12e0b3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 15:37:43.3662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSvBSfygdTcpsctaCK7IRGHvrFNGCK2Vsz6bcYg7k2nPDM+ZABxjBkP1Bw1D3A8FC/ezjYY+a4+A+eIHUG43yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0254
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-05-17 3:08 p.m., Alex Deucher wrote:
> Unused so remove them.
> 
> Fixes: 5791d219561cb6 ("drm/amd/display: Refactor and add visual confirm for HW Flip Queue")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Wyatt Wood <wyatt.wood@amd.com>

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 -
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c        | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 85a947015945..81803463ca9b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -2521,7 +2521,6 @@ void dcn10_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx,
>  
>  void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
>  {
> -	struct dce_hwseq *hws = dc->hwseq;
>  	struct hubp *hubp = pipe_ctx->plane_res.hubp;
>  	struct mpcc_blnd_cfg blnd_cfg = {{0}};
>  	bool per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha && pipe_ctx->bottom_pipe;
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> index 558821e5ed2f..25de15158801 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> @@ -2286,7 +2286,6 @@ void dcn20_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx,
>  
>  void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
>  {
> -	struct dce_hwseq *hws = dc->hwseq;
>  	struct hubp *hubp = pipe_ctx->plane_res.hubp;
>  	struct mpcc_blnd_cfg blnd_cfg = { {0} };
>  	bool per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
