Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D13DC43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 14:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C78B10EAAE;
	Mon,  6 Jun 2022 14:16:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82FE110ECD0
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 14:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/dgkbph4+q9FXT0wUkLdqvfAILrrmozVv4LkPX1ffKvDXNKmT3KsBjymZTlvcyrItCZ4Hfp0oV/m5CPpMn9AFT7ZDpjqy7Xom8B6W1gvJdJxK+Oio3ybI4dH7x0zcJkEC8oGsV5olqwzJAkIQUsAcaDzT2B3KznxQIYu/Mik1CgEBfzO2MPdVg3jDbFdZj4T8mxcV+vdVx7swbwWme7JwZi7EaEdnVjvP3WPA6DvlS0x7H6PHLvdP12f7XUrKtoeJ2e49exdYMgiQG419y0BqpX89JRlVhIrKYzBgTeVXbJhk1Bx4UydPQRtjEGIzjnrEVKTv8Yy7qi8UTCLcRLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvzxoFwsdXc3OcukBKifeLmPAMAMclbuBPut40NLy6w=;
 b=hV0GhTLyX32TDScQ1pMd6bz4VdCAFRMStYtEg1haRujVl/Hmd9LaKnaLQCGerBpPX08V/72QOdxowg//bWn3dpWc4WQAUPWBvs/mQKCjXV6QTiXfoRUzd+O/hJzuLbjEIE1YEgaDT2ZH8fxaqUfd9LG76U0tPqH5/7YC7kAFQKx4yqG95CM3f9gztBoKrsXSichvHG7jGszhIgYGR2bSxzgoT1/EUkb2LtnV4hgx+ecPtiq0dfSc0L25dHHXtY/slE9PlTpWGDwCzLhE/rpokBejZV5C2xgPKlMJe3g+Zx2euj+JcT0X7M2fVk7YdQorvwv06/nAyybNOLj56GYgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvzxoFwsdXc3OcukBKifeLmPAMAMclbuBPut40NLy6w=;
 b=i3Wi7UvORdw4In04Rk2wJVMkgJ1PXCwYxEFP7s/HFQdZupBT3pCJa8l9u45V3WaOxGAuVIZ/Pi0oJKPHweSboMq5wpB501SMEdSWuO09qvSUqs0euL9vKGcgwz8FOKW0kXYerGJE8aqH3U/+3z1coxz7XRxm6FnAJWaFXIrvols=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:13c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 6 Jun
 2022 14:16:46 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:16:46 +0000
Message-ID: <24e1099e-bf3c-dca2-a8a9-8cd0196248a2@amd.com>
Date: Mon, 6 Jun 2022 10:16:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 6/6] Revert "drm/amd/display: Drop unnecessary guard from
 DC resource"
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
 <20220603185042.3408844-7-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220603185042.3408844-7-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::16) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d748c6c-b26c-4820-74d4-08da47c73042
X-MS-TrafficTypeDiagnostic: PH7PR12MB5688:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB56884045323A2972D9860C358CA29@PH7PR12MB5688.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cE+BhKidyvhgAV0vfeM6zSzvz6vqeEupYqWmUiK7IHIzTCqAGlzACEodhFBMPiV6m8a7tdFpSzIzOupttf0ltniggO/tzLOUevRlpwpOCT7dn4KvGHy0CmB3DYfpDsMkDfUHUIivMJ/XPDNz1EnfybiNRsth8lF2co292229at8LkKf4toWGVQO4LEoSS1MXuvU8/VcYuFOYOFiVMg/M2YAX3GZX9vNLJaQcbLiL8RVHzguPJR6UwjcWdcCtKCtf0N6cEOS5WFkgRcHOeJWYYLYasHeu+4MAtPI+FT4gGYYdOs0Mogl6FBdDE3Fm3msyoShpzaa98AEn/gxkj75kf+z8hWYgtVj5Ez1ITO7zpuKo3CmszxL7RGx4u44dgASpxfvPe/t8Ow86gFsGW0nbOuUZkVAgzsETieaVDKtlSmbxMCHMySpAJMuAiwJr3InZ2cwe+h1dMpu5IKGzTJuam2aTO6YcRmdthKMmsUn/FqVOtlio/lpKadlnwLzcPRSGGuGkK4cyKOXTR9bGvSjGz4vV+on2ypt2MNoygyNNstFLdsREoj5j2Z5uOX1Boevwh3/a7kOaPbUnW/H2+hsUDvVMfdQFsMnFQ9vF6fFUwZ7ZyJucqGe0yJjffttEdPvA7r2a0rQeSkSGBReAaQPBwEUSIH2QxzaqPvBlc+nzP9PzKBy/MdYF2UeoforCF4tnKydhfUV/rscoLlHAzE7Ka87/ozxBai37vTR0LjmqKOD6sVbgzYikXPNXTg4AZkc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(2616005)(38100700002)(508600001)(6666004)(6486002)(8936002)(66946007)(31686004)(31696002)(66476007)(5660300002)(66556008)(2906002)(186003)(44832011)(316002)(86362001)(36756003)(83380400001)(6512007)(26005)(4326008)(8676002)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndVNi9qWGxpTWltNGh5MCtkVkplWXZKakR6Y05Kbkd0TUNieEV4NFA5QXhP?=
 =?utf-8?B?QUVzcDdwdy9XeGZyWVB1MXZHZnNHWWZZbFZaR0k0SUpyWm5kMzR5bzVYL2V1?=
 =?utf-8?B?Qjh3Q2JLeUVSeStjUDd5b0QvU0FoWnJIUGJjTW9uR1dpSzc4Z2k3KzJUbW1q?=
 =?utf-8?B?OG9Yc0lmOXFHcXhYb0QvYURKUGFFem1jbnpvWHBHSGQ1b0h1UHdUd0VOVGdV?=
 =?utf-8?B?ZXBNK1FHeGxVWUFrUm9XQVNwQitLNkRBWFRsTHovWHk2OGNaZ3BWOFpqQU9P?=
 =?utf-8?B?UDBEbmJnNElWMlJMS0xsZFZmQ0tGSk84SGQ1a0lWRU5oRlB6VklVQTlHMlVQ?=
 =?utf-8?B?cjM0M1BBcFczUkt5bk83aGx2NnFtSkIyZXI5dGQ2RkZQQitTYzJwSnhEa1ls?=
 =?utf-8?B?Rm5uR0h3SmFLemJSc1JnM1FZUy9CTWFITXNXUXBTamFlUXpSRVFPM3FrZDhP?=
 =?utf-8?B?bVZiWVBkOU8ralRGeWhGRHo2bCs3SGtsblN2bXFHaW80UGFGd2FWeTZjVmNv?=
 =?utf-8?B?c0F1elJPMUdPTTZzcVpzbDIyR1JDcmVpZXR2RnJuYjA1T3ZUYW82RnNPTnZo?=
 =?utf-8?B?Zk1nSTZMOEhBM001bFFFc256UnpaeWtvR1ZUSldNUGhMK1pGeEY3MDhJdW5a?=
 =?utf-8?B?c3BoSVB2b21HVjR2ZXRKa0hKcHo4OHR5RHR5TVArSmZ4d1Q5eDR1alJ6TTJY?=
 =?utf-8?B?a29aQVBpOTFJWndUQkhEUGx3NEszczlrV2JCT2JPRlRuNGVONWpCZExURkpD?=
 =?utf-8?B?eDY3MzhnZENjNlcvSGhEQlgxRUJHQ3FQOWVRSXhMQjF4NS9ma003RDdFSkZ4?=
 =?utf-8?B?ZUk2dkNDaldUc0V1RDZZMXJvU3JQS01CNVgvZUNyNUFiQ0gzaVNMa0hUT0pB?=
 =?utf-8?B?NGxrSVdia2luVWJnYnFmQndJYmErNzY1cWtQQ2xIdWRrWWh4anErTVYwNldv?=
 =?utf-8?B?VFNNbVlMWEFud05VblMzY1FHWEpDaHMwUnhzaFVJSm1WdTBqVXVGL2R3NElL?=
 =?utf-8?B?VTBSdzJiTEF3WGpwZXVDU1hXaTMzV0lUNENFejJJODlqTmZjQUcxSWREbVo3?=
 =?utf-8?B?dXVFYk1QcHgwTlJxdXhSUUZob25GajY1UEc5aThWZU5iMkhCc0NJZVJ6Y1hC?=
 =?utf-8?B?M2Q2a0VaTVNGbDVhc0hvZk5wM25WNjhSazh5dGJpeCtIeTdyMDNpOGxJSGZn?=
 =?utf-8?B?R1RoZ0p3dlFPTjZDQURablYvODlHNDNLbzQxbWxHU0htREc4MkRCNXV0R0FV?=
 =?utf-8?B?aUtVNTgxMFMremxiNEc4VzJCOG9IZDBnbkM4bXZWaTY2aGZteVc1VURPSGN6?=
 =?utf-8?B?MWFuZHFvbWZRL1BTdGNIdU92eGk0akE3dktLdWlOS3d4amJVemc1RiticGJv?=
 =?utf-8?B?QkpGQ00vSWdWNHRJL1VKejV2SDNZTm43NVpOaWNOVFBFQzhrTFFzOW1Yai9K?=
 =?utf-8?B?NXZwMkwzdnNmZGFHYWNXbjBJYW5YNjFHaXU5NjkxQjhsVDZydGlaSUR0eHdh?=
 =?utf-8?B?MkZsWjIwQ05wSHhhbnNHdndpdGlkd3pkNVFNL0FPL1JaUWgrMHluZXFRT1Nh?=
 =?utf-8?B?TVVuQXE5d2dRTzY1NE4vYXZWMjVzUFRlWjNKbkFFRTBiUHNkckNEcGRrSE9a?=
 =?utf-8?B?bUZtNVFLcmlreWhnVGxYQmh3RVF0dW9GaXk4cFFFLzJNS3V1VXMxRXRyQzl0?=
 =?utf-8?B?dDl4L1A3ckI0V2hpM2QzemlxeTlyS0k2VFNybXVrMTd4QWFwTlpyVnJzWVpT?=
 =?utf-8?B?RmFQNGVpbVJoY1JIb0VwV25FTThFSHJEN2pocFVWd0tPQWdFVHd5dVBqYlJ0?=
 =?utf-8?B?QU1oMzZjelZoelJPL3ZSUG9lcWUyaHVycXNpWSszVEJmODlYQ3JhTithSTdn?=
 =?utf-8?B?SjhSTFJVS2lhY3dHQWlDSllPaEF1ZHNQeEtTYmdwVEsvQlhOWUdjSkx3N0hp?=
 =?utf-8?B?MWlSeFFwM0k1ejBoN0ZiVGRxSVpNQ1ZWa3ZhRFdTbm13Ni91Y3BCZUYvcERy?=
 =?utf-8?B?TFJiaENSVkJSWDNhbHBkN2tCV2J5dVNJcGF5SHZpKzh5MU5RRUVHM3poK0Vu?=
 =?utf-8?B?STMyeWtzUnduam1nZ215ZisxSzc5MDVYb3hRazd0VFhsSEpZZXVCVC9EYWR0?=
 =?utf-8?B?V29zUjh3R1FicUNqZkxNbFFzS0RldGY2UDAxVkVtaExkSnV4b1NXN1NYWW5x?=
 =?utf-8?B?UFNxWmJ4MkxQQkhaKythN3BXR3dRdk9XV0t3K0MxNTBHSlpwdVdZb1c1cmhV?=
 =?utf-8?B?c2xRYnNHNFR4dnREU3NrR24rSytCeWxKd1ZRWEQwYWE2ai8zOEV6VmJjMDFj?=
 =?utf-8?B?UVJEUU5KVWp6OEN1cTFlYTRuRkM0OWVwS1cyTG9Sd0xzRy9TSmdsUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d748c6c-b26c-4820-74d4-08da47c73042
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:16:46.1946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGaj4mmoMteCDfc1xClb529/GHN2Uc2KBxSmGArT7JlI6peixv5f0VJt6Nh9u9nBZCsgxBV6eibtDGD/+ZKDwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-03 14:50, Rodrigo Siqueira wrote:
> This reverts commit 78baa3c4dfff4375b109bc5e19663a2f7fad1190.
> 
> This commit introduced the below compilation error when using
> allmodconfig:
> 
> error: implicit declaration of function ‘remove_hpo_dp_link_enc_from_ctx’; did you mean ‘add_hpo_dp_link_enc_to_ctx’? [-Werror=implicit-function-declaration]
>  2010 |   remove_hpo_dp_link_enc_from_ctx(&new_ctx->res_ctx, del_pipe, del_pipe->stream);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |   add_hpo_dp_link_enc_to_ctx
> 
> Fixes: 78baa3c4dfff43 ("drm/amd/display: Drop unnecessary guard from DC resource")
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index 7357efb8b439..9bbdfcd6b3a4 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -2002,6 +2002,7 @@ enum dc_status dc_remove_stream_from_ctx(
>  	if (dc->res_pool->funcs->link_enc_unassign)
>  		dc->res_pool->funcs->link_enc_unassign(new_ctx, del_pipe->stream);
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>  	if (is_dp_128b_132b_signal(del_pipe)) {
>  		update_hpo_dp_stream_engine_usage(
>  			&new_ctx->res_ctx, dc->res_pool,
> @@ -2009,6 +2010,7 @@ enum dc_status dc_remove_stream_from_ctx(
>  			false);
>  		remove_hpo_dp_link_enc_from_ctx(&new_ctx->res_ctx, del_pipe, del_pipe->stream);

Wouldn't a better solution be to drop the DCN guards around
remove_hpo_dp_link_enc_from_ctx and release_hpo_dp_link_enc?
Not sure why those were guarded in the first place.

Harry

>  	}
> +#endif
>  
>  	if (del_pipe->stream_res.audio)
>  		update_audio_usage(

