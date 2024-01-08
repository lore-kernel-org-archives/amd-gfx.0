Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0BBC3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 16:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D326D10E12A;
	Mon,  8 Jan 2024 16:28:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B124310E12A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 16:28:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljBjM5yhGcnsJ8u840LYlp7v4B0zuWdocWBA6hhXm+kvc3eamE9lMQ4p/8xTXS1/F44DwO5JtncbBkOZ8aIABaOYBpzNwYF0ffDCDR/v+CfstfGrQp3K4tlffupuhcNlG5qSjC8nB5hbXMs9DCnsU8aKjswi1CU2i88upXMv1hPnY9mThiNlOc6f1oW32kyImxrXP7UULWYQm8xqke+o+Pv9Nk1SxHq6zYLn4VbfRoYRQsTkBHTvSL3OhbUkSApbac5k9345sAzD38+7bwNPE6PrPD36Kcj+eCHMHitjrgJb1aFHKF1Q4DAbcQUQKjmv3aQPj2QmZpn3+L262wWn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yW5BCT4HeKWDWc0Z0mWO1x7fMdB4tPveXpFCIidRb10=;
 b=KnHeETj4TNRVU8hmlT0J1rovsFOBuLd0qYJquHC7YMgmK5r90vlan4FzEzvB15b67DZ1i5+cpmJFTAKjS7r6T+r2z4nBf7enlG8ctmiGvC98kGyirihnNS/v7Q4/zBEFYZSSy8qrFkUloV/DpXQIXYkl/QxlWiU9vk0Md1CbuKWZFM3FL/Ji1hn+oNW7pHuzvhvHitUEJsmlHDgPnhxHDR27gNmiBbteM0cai4Bozy9T69Dvp/sb+p/LgorC5bSvA5lJNeEBkTEOKAJ2pa9YqdhFjYtc7cYBf9tat89GYxQX8rHX8Cb4quBVzcY7AEGt3q7CvZmsyFQYZRAgQsYvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yW5BCT4HeKWDWc0Z0mWO1x7fMdB4tPveXpFCIidRb10=;
 b=t+yAVtp7WMnSXD8CYIrbd+632WTKOlBAwUx6t4R+cPU4dvk6mS2/vSHJpGTzisea6a9U9vt/EgpW3FQX2oadc1t0vnHGpUJjHXx7c6yjQ82KMMRE0nrOJtqFgizgvqhwnK7Vg6UimS4Vvj+4C4d5yHUVwtFkWRNWexTBVurZxHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 16:28:06 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::194a:56d:a41d:3c79]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::194a:56d:a41d:3c79%6]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 16:28:06 +0000
Message-ID: <70a1d20c-702e-4c2d-8a66-372f26d85f47@amd.com>
Date: Mon, 8 Jan 2024 11:28:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix variable deferencing before NULL
 check in edp_setup_replay()
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20240108161920.3973404-1-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20240108161920.3973404-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::17) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fb185c-cbb1-48c1-1417-08dc1066caea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjJ0drBU7X1xqWN9lSVP4fzdNWuBH6jOmDip4YzY2vmLuRAIv1H4Z2dGNXMjJyqI/oAxSpK1WM9RrHhV2f7pvYnq8289o5F+3DHaCj9owmYjeiHYQVNUP1htj4paiVD9tpmD8lKhMnMDOJjbXWs1nR8lSgcHHMzRfPnSqt5z46lrXhBLP8R7KuNYt88/C8vkmrc+9NmLyO4lh4ld6+4XS4iBCZ9JH0hoJAuJ6GhNlzwp8khusjFvOqXai80z3MaR/LhCTn2WzBEV21GoNomxTCfh5/sRyvBuCLYtoDM7RuowSZqxlIYCDK2xxpiASsMPLIzFBVzQcS5MCaHiUSxYiyle2nwbHdF400oCV/EPwrZAfpw4p8XJRc/NRBe/GAz+PTCUP9gYmufnwLG6zSKUw7PmRwkefFNpYvoWkiFWOgM2QhE+c34fMcusD8gE0GHQ6QrNXUWhKC7gKMXr++Ws/krLftcEpCOGiLA7hnIUzdm5EsmuzhEmMEAebAnbgffp2s2Ytbb6arhrau7XDWY9q/1x0NSXTt34qViUcdPzVR981/CI3OYHcKSufIjf0Yi/OD9e198g/XGwxQUTgVQKZfk6aC3YkrQ7YkUt3tNykr2FaeC2YTBmIx4lMszQB3LJWFbvvwH2FncmfsDVX0Z+zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(53546011)(2616005)(26005)(38100700002)(6506007)(478600001)(6486002)(6512007)(36756003)(31696002)(86362001)(2906002)(5660300002)(41300700001)(83380400001)(66946007)(54906003)(6636002)(66556008)(66476007)(8676002)(316002)(4326008)(44832011)(8936002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzJBZEE3b1JNeTJrdW5TRlkyTCtPVElhTnZKbVk5RUxpc0hJdWYyMmZJbk4z?=
 =?utf-8?B?TzR6di9zT2ttd3k0SUxBMTJKemhFcThQdDhTcUsyanVEdFJHb040bmY1RkhM?=
 =?utf-8?B?cjN0TTE3bnd6cklTOTA4MHFYYzBMdjNEU1FXV25ROUtzbmRvaGVvZitjbFRE?=
 =?utf-8?B?cHRudnFyOFkweVUzUDlWRmFBdlVlMWhzcTRHVkYvdXVJWFRKSU9WQy9yejhZ?=
 =?utf-8?B?TDBqNEZla1hZU3ZlSzZvOHE2bUoxTHJock1IcWxXMllOSVhLamdaRUI2L3Jo?=
 =?utf-8?B?Z0pHZzhlcHdUMjJ3NE1Fc3dpK1dEOHNvMkdqWHRiYmNBR1ExRmJGT1pabDI1?=
 =?utf-8?B?QjZ4TXNVS1cxSUF4WXMvL21yK2grUWhkTnlvSTQ3MnkyZzlZcXJtRS9peENm?=
 =?utf-8?B?TzlON0kwK2U0Ry9rUHVIVEI2dnZrSUJmNFREOThZZWJtMm5penZDNE5PT0pE?=
 =?utf-8?B?K1lVRmRSdHJEbC9YdExHQURXZHNyU2FRbjliT01WRWJrM1V4b2IrUGN0bVpq?=
 =?utf-8?B?UUpKbFNJWEFoNXM0MElvdmd2Wm9ncGdQOFRIRWgvUy95TlI5VkpxUCs1bnRN?=
 =?utf-8?B?aUhqcllxdHA3NFRpQVp0SzFYdkI0aWxnZTVPWlJRNTIvaVQzWCs1M0htdGVC?=
 =?utf-8?B?bVUrNExPVG5Vb0VNTnVlZmpLdk1pMEZOR2RhMzJjaVJKUlFVS2d3OWFaMFhO?=
 =?utf-8?B?Rm1EQkhPUmsxNUZnSVdoSHIrOGh5M043SEVpMk5YbW5KR0F6QWNqNHJYWVRx?=
 =?utf-8?B?a25lS1p4eURpUUN3clk1NnFHNzBMK3NvQVhQTUt3K3M5dVc3amdzVzdqaXhK?=
 =?utf-8?B?MGRBaVNXTjhQc0ZyMEdzTTZrMndSR0tQbDh1UHZ5NjVlMUtEaDJBdWFpRncz?=
 =?utf-8?B?MDF6WW15RllMRVZobDBzUlN5KzdNSDNoTzZaZVdwTzl0aTBTaXVaRGlxVE5P?=
 =?utf-8?B?dGtiaXFsVmFKcVlxSUEwbGFweCtzZ1JDRU8weVU3WVhMM2k4Y0VPR1lrUDFY?=
 =?utf-8?B?d3dKVUpjZmtZVUxFOXlQSEVXamE3Qndmakp1Sm9jUFpZMWdJc0c1c3hST292?=
 =?utf-8?B?RXU1eVowMExYOVFMdXdzRjhwR05Ub1dkcThUT3I0YUk0Y1kvS0tlMFdrUCtZ?=
 =?utf-8?B?RHpqdTVYUitNekloTGg2YVIzQnppUE0vYmdsdklMeUdsLzRCbEllcDlGNk53?=
 =?utf-8?B?TitMdndwRlpsempFbDJaZXlRRlcxSmUrdnBrbVZrc0dLRWl5dTE3TEhxK2JV?=
 =?utf-8?B?bmNNNFpjb1lVSmRIdURBTlNCdUlpVGhhSEJreHN3RW5ubDUwWDdmWjIvWnZZ?=
 =?utf-8?B?NEFmdFc5Z2RiUHFhcEZMY3RPa3Z6TjV0WTNXYWtTcGZuNjRDMXE0bUpvWG5L?=
 =?utf-8?B?dzF5NUVoOGZMVHZiVkkvaTF4NU1PcjdyNzZZUTdyL05jRXZ4ekthTGRvRlpV?=
 =?utf-8?B?emc3K1ZtQmhqc2hrZXV4VE92eTZzQXhhdVNiREZEZUxKWUxmRm5ER05kUS9I?=
 =?utf-8?B?aG9GOEdKS2Uwcm9OUXpTQmN0clA3STZ5eWs0R2xoM2RZR2xpUS9pdWN6Y0hF?=
 =?utf-8?B?OTI5bjZ6bDU5bzdRek1yZTVvenBxbDNzSStpUXVnekJkUm9FZEFiK1JzaTBZ?=
 =?utf-8?B?MXViUTh4a1MyWVdXVUxCNnBQRUo2T1pFUXF1K2poWmIwUGlHTHl1ZEZyK2ha?=
 =?utf-8?B?QU9PMWdhRUJBNHowTmYreEFJamVsWmYzSzlzTDhySmFqbUtqV1NDS3hkTmhU?=
 =?utf-8?B?b3VtYS8xZWtaMXYvZlJDMUhLL1drL0ZkeWtobVlFQnNZaDdLL2hlbUcvVDAw?=
 =?utf-8?B?RXpNSERCTEpBbUVIaUZaeThuSTlqTmpJMWlTSHFzQ1dYZDZONWluN2srOXZv?=
 =?utf-8?B?QVA3UncxVkxWdXZCVkh2Sk8yZGpmRW8rTVI2UHhMenI3cWIyUi9MTnkwSGk1?=
 =?utf-8?B?VWd5eFlJYTlkY2RhWFFldjJOR24rNUZGa2pIMzhWOWQrT2NIR2ZIYVcwYUxq?=
 =?utf-8?B?UGxXWGJKTDVZanlPeEhURnJ2eS9WdUdJSmwyaXNLbXIrQ0l5Wm1tOGVSU1ZW?=
 =?utf-8?B?OUxpZE5nb0lDcDRjOW15OE9rY2F6SFBRa0xCNFc3T2EwRzd1K3VadXdISXdU?=
 =?utf-8?Q?scsCZdc9pGUpayMaqli3gjjKF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fb185c-cbb1-48c1-1417-08dc1066caea
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 16:28:06.2681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnXNvUtUlxhhUXF4t3eFA3fWXtsRkDHFUyPDZGvEorIGwRbExQpoW4YAgCH5zFoVaPh+xFmArP4MwlWaPL2d3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2024-01-08 11:19, Srinivasan Shanmugam wrote:
> In edp_setup_replay(), 'struct dc *dc' & 'struct dmub_replay *replay'
> was dereferenced before the pointer 'link' & 'replay' NULL check.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c:947 edp_setup_replay() warn: variable dereferenced before check 'link' (see line 933)
> 
> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../dc/link/protocols/link_edp_panel_control.c        | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
> index 7f1196528218..046d3e205415 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
> @@ -930,8 +930,8 @@ bool edp_get_replay_state(const struct dc_link *link, uint64_t *state)
>   bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream)
>   {
>   	/* To-do: Setup Replay */
> -	struct dc *dc = link->ctx->dc;
> -	struct dmub_replay *replay = dc->res_pool->replay;
> +	struct dc *dc;
> +	struct dmub_replay *replay;
>   	int i;
>   	unsigned int panel_inst;
>   	struct replay_context replay_context = { 0 };
> @@ -947,6 +947,10 @@ bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream
>   	if (!link)
>   		return false;
>   
> +	dc = link->ctx->dc;
> +
> +	replay = dc->res_pool->replay;
> +
>   	if (!replay)
>   		return false;
>   
> @@ -975,8 +979,7 @@ bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream
>   
>   	replay_context.line_time_in_ns = lineTimeInNs;
>   
> -	if (replay)
> -		link->replay_settings.replay_feature_enabled =
> +	link->replay_settings.replay_feature_enabled =
>   			replay->funcs->replay_copy_settings(replay, link, &replay_context, panel_inst);
>   	if (link->replay_settings.replay_feature_enabled) {
>   

Please add Cc: stable@vger.kernel.org in description.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
