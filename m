Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4E0C61DD8
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 18:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECD0208D5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 18:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AK95lI+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECD0208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F1B6E7EC;
	Fri, 13 Nov 2020 18:05:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CEC76E7EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 18:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzwP6/qicWzv+1ymtPD3u8/KE91BFiwUk0RRxYNJToIbeUCJrIXWvSayqX0PVTxLymjs+beS4zb25lLS+sxKNrySXbA5GLOs59smUZw1QFG8tgS5ANhEVHdkpGxzZBhQigDbHA1m3JmCLC9REZWJInhkUN1Mlp73ZoV8zuiudY7RvGAw0rpAl2Onqq/NT2spaKQBoLryjeA5ZUngoeyhMPaXCi4Pg6KbjnG82bMArSxMy4RFhf0JDN77NS1sGtPmU+xa5CaNAoPz6YIxt2Ly4Qi4fATWGqqITHh2sCGo/c7CCRvkkWeX2Vih1AQpEXrqVcQKWExgaTBb0Z2PXyH8lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc91+NaxN5422r+cCEsSmQDvDucKtzAIW9rptaKCP+M=;
 b=Z/2TauoaAniEFoagDVcSODzBne7Eg8B28fzrPLmsSzlZH8d6pVyosE49PjRZnKF4iUZBMcv0HrufrPpw/qSxMV0keWgBPak8tB1OLLMs3PmT2/RqG+/KQfanofpgc1hsstMPVVUQm/S54YRd0eFb6X2nl5cho+8Ip/UPDpb3E8wiQp4k7w9Pgfl1lsx4NO0GsE7Da2VLuh2+Be/5IIqIhOFe1lSG7f+SZs+IyUxrs6hICpIi+7fOebIHMm2AhfcPHuZlh0EBHeXu5hSUgqOxUmpQKuyIs+bqlF49BP5EzucfyQDYx0snV4Wo4YrArOZkQSHFDUHhe1H2+zXLZiHUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc91+NaxN5422r+cCEsSmQDvDucKtzAIW9rptaKCP+M=;
 b=AK95lI+rd5O0KDKshdEv4QgI6yy+goB0qAyuT+ediS+myl6jrYJP4Wj24+k1A/s2XxQ9Gl2CB5RlpDWpPEftHM8ZNReuZr3z1Cy9wvcYbOybF4wJ43AQWrGnso91sIYIJ392tAmLk/Xa0e0upl5bEVOrzZngoDLEWWGGpYeSjkI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3237.namprd12.prod.outlook.com (2603:10b6:a03:13a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Fri, 13 Nov
 2020 18:05:56 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999%7]) with mapi id 15.20.3477.037; Fri, 13 Nov 2020
 18:05:56 +0000
Subject: Re: [PATCH] drm/amdgpu/display: fix FP handling in DCN30
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, alexander.deucher@amd.com, 
 harry.wentland@amd.com
References: <20201112220618.3610982-1-Bhawanpreet.Lakha@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <31edbdfb-156d-d10a-9f8e-1bdb44e233e9@amd.com>
Date: Fri, 13 Nov 2020 13:05:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20201112220618.3610982-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTOPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::16) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTOPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 18:05:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4764b690-fb2b-49c1-3f5f-08d887fec49d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB323701273F9A60970E85837EECE60@BYAPR12MB3237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwBZHmuh20tTqTIjIYmhWsX5wBuhhv7kvoOkvkVqmVds2hsy/zRIsoSZpXLvyY3u7AQVWxGnuuIpl2TeExZG6VEv8YXR8gvsKLlYqSHYqpt8sJYiy+K+bvMXzSS4i4Uxx7zTc0jfTx5wvqwN5XW0m1qKOJ2wc++39exxpJblkOgC6CFLA0iM3Mko+O+pkoMd9+FsgdSsFc4KUWNa7HJmeKfHV/M62JZgE3ULAmYA6QXmvt2EyYTgQ+SXNrLRnqgKDKM+ZIv+LO8FwcSmfHmqiFiRLWxgdvQ6imCOrFamYNyCnObVGiGt8i/ApLwXHthNcwrsrGrLK4mOcOU8n2DewNDsUn7LlGRXNlCLJP+n3RUZt6lrGEmyjOhDNn9I4qYd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(66476007)(83380400001)(66946007)(4326008)(2616005)(956004)(31696002)(36756003)(26005)(8936002)(6666004)(8676002)(16526019)(186003)(5660300002)(53546011)(316002)(16576012)(6636002)(31686004)(6486002)(86362001)(2906002)(52116002)(4001150100001)(66556008)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: giqeEQ7ud/Qis9RPJR1S/JizOamXslYBY+YGj/xcUenPGGS+BFgt+wHvFBGa5lnF0z0fs0nhTAKedTYGBYUCmyC9MMUjn1c1nY49hlz45OK1/7A3TN/Iw1XKWkwN3dVd1xDb2ohbrO/0vzPg7cAy8Svepb/ts0t/yBc77efYKNYaR7fhEfbI1BmCbiWu5gWNaOaH4qSrf9U3ak1MSQXVU+XKp0D8thy1KWBg9kjTojgKuCgDRgY3dpu6arBPVgBp87Joar6/5fVxlKLsmPd3+cBQuwB6BjuNFDmMD0ZsLpehyC+S1/H5rAx7FeO8tL9+hJKx5zMHK4aF/fUkwgkTNWke2nxC9KT5IfVmqFgdeBUyYSFKAKQXoqsGDfsif6syVeLtVJU5FH0bX1pHeMmlOhdRt+q60AbpLhxBZOmMM890Wh/VedZjO2yKjiYaJ1Z5CM7KZ1SCPHc+HyJzTln9pPfTB3jfEy1e25w4bCQrwtYaMIxf/EYepPIQF3R5qg0529IBeqaclXIY50ezLwxOiTrn2EUmUS3hq5kDbqqmWMkEw3yBr1hweieaTpP21PMGCrv1gnOg0YFGFbu9nXMXmbIJQj4k4O6mSVKq/6uASCWYqufsdUbq6RJlix0cX8f5rtV0VYoJNv/ZamLBFZjmyA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4764b690-fb2b-49c1-3f5f-08d887fec49d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 18:05:56.6186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYiwRRquNJ5843Btx7JCsNHqpjaMPNFssF8ahu7Wvv/zBg001l3UPOo9sycSwAqG4I9tQ5frMujoydu57V6Rjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3237
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-11-12 5:06 p.m., Bhawanpreet Lakha wrote:
> From: Alex Deucher <alexander.deucher@amd.com>
> 
> Adjust the FP handling to avoid nested calls.
> 
> The nested calls cause the warning below
> WARNING: CPU: 3 PID: 384 at arch/x86/kernel/fpu/core.c:129 kernel_fpu_begin
> 
> Fixes: 26803606c5d6 ("drm/amdgpu/display: FP fixes for DCN3.x (v4)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

I guess dropping the noinline is fine if we're just calling it via the 
function pointer.

Regards,
Nicholas Kazlauskas

> ---
>   .../drm/amd/display/dc/dcn30/dcn30_resource.c | 43 +++----------------
>   1 file changed, 6 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index b379057e669c..d5c81ad55045 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -1470,20 +1470,8 @@ int dcn30_populate_dml_pipes_from_context(
>   	return pipe_cnt;
>   }
>   
> -/*
> - * This must be noinline to ensure anything that deals with FP registers
> - * is contained within this call; previously our compiling with hard-float
> - * would result in fp instructions being emitted outside of the boundaries
> - * of the DC_FP_START/END macros, which makes sense as the compiler has no
> - * idea about what is wrapped and what is not
> - *
> - * This is largely just a workaround to avoid breakage introduced with 5.6,
> - * ideally all fp-using code should be moved into its own file, only that
> - * should be compiled with hard-float, and all code exported from there
> - * should be strictly wrapped with DC_FP_START/END
> - */
> -static noinline void dcn30_populate_dml_writeback_from_context_fp(
> -		struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
> +void dcn30_populate_dml_writeback_from_context(
> +	struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
>   {
>   	int pipe_cnt, i, j;
>   	double max_calc_writeback_dispclk;
> @@ -1571,14 +1559,6 @@ static noinline void dcn30_populate_dml_writeback_from_context_fp(
>   
>   }
>   
> -void dcn30_populate_dml_writeback_from_context(
> -		struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
> -{
> -	DC_FP_START();
> -	dcn30_populate_dml_writeback_from_context_fp(dc, res_ctx, pipes);
> -	DC_FP_END();
> -}
> -
>   unsigned int dcn30_calc_max_scaled_time(
>   		unsigned int time_per_pixel,
>   		enum mmhubbub_wbif_mode mode,
> @@ -1977,7 +1957,7 @@ static struct pipe_ctx *dcn30_find_split_pipe(
>   	return pipe;
>   }
>   
> -static bool dcn30_internal_validate_bw(
> +static noinline bool dcn30_internal_validate_bw(
>   		struct dc *dc,
>   		struct dc_state *context,
>   		display_e2e_pipe_params_st *pipes,
> @@ -1999,6 +1979,7 @@ static bool dcn30_internal_validate_bw(
>   
>   	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
>   
> +	DC_FP_START();
>   	if (!pipe_cnt) {
>   		out = true;
>   		goto validate_out;
> @@ -2222,6 +2203,7 @@ static bool dcn30_internal_validate_bw(
>   	out = false;
>   
>   validate_out:
> +	DC_FP_END();
>   	return out;
>   }
>   
> @@ -2404,7 +2386,7 @@ void dcn30_calculate_wm_and_dlg(
>   	DC_FP_END();
>   }
>   
> -static noinline bool dcn30_validate_bandwidth_fp(struct dc *dc,
> +bool dcn30_validate_bandwidth(struct dc *dc,
>   		struct dc_state *context,
>   		bool fast_validate)
>   {
> @@ -2455,19 +2437,6 @@ static noinline bool dcn30_validate_bandwidth_fp(struct dc *dc,
>   	return out;
>   }
>   
> -bool dcn30_validate_bandwidth(struct dc *dc,
> -		struct dc_state *context,
> -		bool fast_validate)
> -{
> -	bool out;
> -
> -	DC_FP_START();
> -	out = dcn30_validate_bandwidth_fp(dc, context, fast_validate);
> -	DC_FP_END();
> -
> -	return out;
> -}
> -
>   static noinline void get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
>                                                          unsigned int *optimal_dcfclk,
>                                                          unsigned int *optimal_fclk)
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
