Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AB2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 20:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7807C10E604;
	Fri, 17 Dec 2021 20:29:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C5610E604
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 20:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVJWwM8bhUPH1sk6T3GyjUwWUzl5f5Lm4Kqiir+ZfJaIGFoaeMoRnFJyEPtPtkYPVmWiJ7ffGtHEwO65rrtlHHzqG/QRD7oHzSsIvQlTENXlPxdN6eogMQiRZCyVPmr6940d3RO2KxwB3dIGRePhlWhKa7jr3v4dvxF77yWBa4KExARzp08pRcMGYcBX7aKYNfVBrrziRc114xIaqPWHc57QuyE1zZJv2gN0SR43+Htcq0DHdAk3/z1Bfjw6enmBop4oWLB3KOlOOgL/m3qQt3EwQVbfLGYcXIxL+Ia+5OZnSny3pLfvzAEKVqVkkRHi3ka/EUHN2ywg1RUvCKocGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=za60ClF2S3sMcRDkLDvEp0M51zBusPRJza9b9nE+sag=;
 b=nhU0fu3GPjOCaukyQQB/7YhwTeEYZO4BSuLs0pM1U2ZTqjN29T1JiG2CwSWnHJhgjq+6ItIk3g/29EQwP/PAJwaUnS62KGu2SQZk2/VOBPFRjwX+4OIQCy0SM0dIapy/ktBDf0j8bJyw100wcgWtjsdyyouQol9QHheRR+Njd89oCWyg+qGnAjrfw/j3ypsd53vlt5HtHM+imPU17jb9EKqn8TvUYhGxyuEm8IUpS3JU3TNHm0al+2Zdz5rp1szuHplCSRZd7SkSLUcLyUWcesLTliCTjmoixipLPsMZXZb1H0JqsfnNey00bqBjZqNJIwGkM3dJE7S6TpuOSBHxrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=za60ClF2S3sMcRDkLDvEp0M51zBusPRJza9b9nE+sag=;
 b=xZgcl9UR/599mAED3WoSLmvZzxDstq8RsmgFggAY6IKu9q4QmI+/WPjs5lXtrRJHDHcv22+MQ4BJFfYaDcsHxpbC5CT8CCdoNV7uI+zQzws3hWiakHSdKVlzcmxEBCgLLJhPbJHlE5fIyzqM8TLSZ6k6ODIolrrh6CKtClJxgds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5491.namprd12.prod.outlook.com (2603:10b6:303:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 20:29:31 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46%6]) with mapi id 15.20.4755.021; Fri, 17 Dec 2021
 20:29:31 +0000
Message-ID: <ea8a0b23-cef3-2b90-941c-c3566e995000@amd.com>
Date: Fri, 17 Dec 2021 15:29:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] drm/amd/display: Fix USB4 null pointer dereference in
 update_psp_stream_config
Content-Language: en-US
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211217192502.104068-1-nicholas.kazlauskas@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211217192502.104068-1-nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::30)
 To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.107) by
 YQBPR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 17 Dec 2021 20:29:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba28bbd2-54bf-4e0a-4a10-08d9c19bee0e
X-MS-TrafficTypeDiagnostic: CO6PR12MB5491:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5491CDB209BD01F3458DD8548C789@CO6PR12MB5491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5VLnGRMRKbr+eCDcwk2kcUdIYDw/TqJ5Y0vrU4PCSTJONIkOURsg7HMGTDeaCgBTTNV7bCN+y49wM5XyH45x4MuFV0L3ZGJ532aYEIHCm3Qigw7CGkahtWgaxx5+n9A+U2fWdIC205TkyQA4eYajPtiug0TwQG/zfrdJ5ymTKVPvBEmzWOP3OJMsqUvHr2jKSVgegPWfs0Wdy5YbmmX61AhzgFs61Pf75e7IAxqDwktG7ae1WsUDxQPI+eIPoGCQSrkQxKTCofmuwygcBjLwxgZtad/E6T5gwHZwWSb3igyk1avWycHwXzqHYmmojb8K6/vw8s94XstHS8xh0CgVhLx+leOO0Bt07hpdi2Tb2PpNXfSd9TDEraPoKuV7szOTJ8KHHsBTepsuyailTq1B4/N2dGj0WSoZFxJjmE5mzhgms2jAxQOK4g+IRMaLXcbm6Nz5GREl3AXN6f1H9nywOHK3b8eWXvjxeWXuJoxszclUgh76mID31Nxv9LRg3I/3FvhYasnh14/h+Wt4AM/JkH1O5IX86AWX+54bDsR1y9ouseDO/kUp/eccrBTZR4egTWMUL9THF3AYMNivi95ldEwFXDJIdHOIwumouabxqFLVvBjXwY9m3QsJj2FhkISrAfUw7rVIMahmCkFQp3ixvrNWAunDlpreCSHQVg+2RsxO3n8TRlKf30eVGJlStVN7CBfv+rR1s/TBi06dPUjPsFm0A+Fx5JxuROZ0EyBu2t57bGfiT030AZk2CDNNKsEB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(15650500001)(316002)(16576012)(86362001)(31696002)(31686004)(508600001)(36756003)(2906002)(186003)(26005)(6666004)(956004)(44832011)(2616005)(53546011)(8936002)(66476007)(38100700002)(66556008)(6486002)(8676002)(66946007)(5660300002)(83380400001)(4326008)(4001150100001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2VLeGFvZVVFKzEyUHhkT29CYTJ3RnZqVVB5OU5nZ2RkNlFDbEh4R2xGNHZw?=
 =?utf-8?B?WDJwL210Z0FGRGU1VWg3OEE0U3RtZU93Z2kzQ0pnMjdsbnhuRDRUcFYwaDcw?=
 =?utf-8?B?b2RuSnAwSWxrZlYrNGVUd2dpYzNwdHpkcGdPbXhiVTEvRllnYWhrSzJxK0FV?=
 =?utf-8?B?bGI5Wkt2Y0hPc290S3lJRlF6WkY3eXFWQzNSMG54R0lTNjNNM3plS2VqN0RV?=
 =?utf-8?B?MzdhWER4akx2THozTGlvS0Uycmg4S2ZCK0VXTWZTV3h6YlNHRWpyRTVpc0Q1?=
 =?utf-8?B?c0VmTS93U29VTkozNC9SbWJRZityV0p6bHkzUTQwQ0NZVkZLZkdZRVZOZ0sv?=
 =?utf-8?B?cXBDa0ZEOFQvNUh3MmJLUDlFNlZaQmJuNXdJdWxqeFo0OWY1RlBKc216Y2Zr?=
 =?utf-8?B?V3BWT3B1N2FVMC9HZlNoQTFENkx3bVVGTjhOYWpid3NERWRvM3BvZUFudXQw?=
 =?utf-8?B?MGdqZHBHNHByRmNnSDlKTGg4MXlsR3ZxQ1RtMWREaGIwbDBIVk5uZlNSTzZN?=
 =?utf-8?B?eEpmSk1UYU0xVzZUeWdzdjJYb3Yxbk5jdXMxQ1NSWVBmNm82dE9ZRDJLbExY?=
 =?utf-8?B?VFRycGlueng2eFVYVThVcWo3UXZzbWlkSmhrSGxXVEFpWmpKUFZGUytDK3Br?=
 =?utf-8?B?dW13NjlQenlIcytVNWV0dzZKNzJvT0pWUTBmajRTQmp1c1llQ3hhdVpyYjNU?=
 =?utf-8?B?SlF1blhyeExCbXI3bUtNNHFVVW5KNUcvRGF5aFdwZjJ2dlR4cU1heitoMUpR?=
 =?utf-8?B?WnMwZU8rT0NvRFcwUXhGMytxZHlHbzUzMndzS1NXdFBYZU5MbTdHejBhQitD?=
 =?utf-8?B?V0lqNENyb3duM0liMnlHSnR0c0tEUU9ZcHhrTlEwK3E1SWZXRzNXbHlNbmFa?=
 =?utf-8?B?QUxyaEN4K29ScjNOdWZrcHJOa0I2ajlxWGFBaUFhV0lpZWxWdmUrRVMwOUZn?=
 =?utf-8?B?UXZCVkZFMG9tdmNQcG11YmtWUi9WUlBBZ3YxNmdoL0Vtd2NRbGZrWWpXSDVI?=
 =?utf-8?B?VjREek1ub3J2MldKOUVRazdHamo3TGZ2cmdmWUJ2N0ptVUJ5dzdvSUNTT1V6?=
 =?utf-8?B?WHFsSWxkdnVxb0VnSjRKZ3ZKQTNxQ3VYT0NKUXJMU2VBRWQ5eGY0OG01N2lO?=
 =?utf-8?B?bmJ0bzdUWlUyOUppTzNkc2RtODVFMmFsUTBYbWo3Q3orbUNPak5hTVBaR1BY?=
 =?utf-8?B?S2FrcFkvVk91WVViK1YvcjVTYkFQajY3cWtvSlpXZG9mOUo0VjNZRktNdXhM?=
 =?utf-8?B?MUtQbXNsQ1FYVFZnc3VzRVJ0bW14ZkgvTEZrOUxhNmF2TFRXc1NYSkF5eFVy?=
 =?utf-8?B?aWpxciszZW4yNW9YU3hDN0Q5VlY4eUFWRzM4WVRVL2NPRWkyZjBUbzAzVldr?=
 =?utf-8?B?NEdRdzBtTDlsZThvLzlzRHVFdityTUowTStLMWZCZ1d1b1ZiOW9ZdEtuUkl6?=
 =?utf-8?B?NkM2c1JKTk1WbGdoV0hSQzd3dmtFbk4xdytvUFdBUEhxOVdJL25CRjVabnVi?=
 =?utf-8?B?WWkxWExGNXRSVVpsZmFmNzMxZCs5cHRjcmV0NmowSTYrMS9oTnRRVi8zZ3o4?=
 =?utf-8?B?OStRU2MveDYwRXpsQzB6anZ0bjJoN0NiY2NmU1pobCtnWmN6aHBVMTd1cUhz?=
 =?utf-8?B?MC9hVTlYRjV0OGJPQWduUlJtYWl3VmNBdzdjOTVuQ3pZMjZnNWJWM1lNZFNq?=
 =?utf-8?B?czVESTF2ckVzZHZzYWp6aHFnMXBjTGdCOWFRRmFud2dEblpCN2JLa2xKZ25M?=
 =?utf-8?B?OTBqM0paT3R6TVNhLytxZzlMRTNnNTd5V1J4bzRBWndGRXNwQkkyZkQyZEhm?=
 =?utf-8?B?UGN1dnd1QjRHSDF1VGd0alQyd1pjWXVGbExyWlBteDRCSEEzUjhWek5hYmRq?=
 =?utf-8?B?MUptYXovVWpmbm91ZURrOVRLc2hUTnc2Z1paczRaS3IwcUNMQkc4ay8yL1Ex?=
 =?utf-8?B?V3dsczZBbnVkOVByS2h0dm1WcmpSd2lvTVhaZzQwRGpWZ2luNkVmdWg2cHZh?=
 =?utf-8?B?MmgySGIzZ3ExZzFic0hKUTU1bnJYU05FcTdKNDdZV1Z6Z3k5ZjA5d1VhRG45?=
 =?utf-8?B?N0wyVnlPVDR1R1dqOTl0cUo4a3lZNEFsMkJSMDVLQ0UxOHJnUEV6cG1ZUllZ?=
 =?utf-8?B?YmlNQk1SZE1kaU1oUkpMZnpqUFBLU3M3YW5CQyt5OW0zZlVSTUNiNUo4UHMy?=
 =?utf-8?Q?BgOe0OBACe3eifRhabTm7C4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba28bbd2-54bf-4e0a-4a10-08d9c19bee0e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 20:29:31.0409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qm2otePhXWS5W6sR//Ieq+OFbNfqIz8yrGV2bXLYFkJjql8lTLYrYiP+3Lrr/hGlNy2lQy8tQgH123fYuHldBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5491
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
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-12-17 14:25, Nicholas Kazlauskas wrote:
> [Why]
> A porting error on a previous patch left the block of code that
> causes the crash from a NULL pointer dereference.
> 
> More specifically, we try to access link_enc before it's assigned in
> the USB4 case in the following assignment:
> 
> config.dio_output_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
> 
> [How]
> That assignment occurs later depending on the ASIC version. It's only
> needed on DCN31+ and only after link_enc is already assigned.
> 
> Fixes: 35b6fe499be7 ("drm/amd/display: fix a crash on USB4 over C20 PHY")
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 3d75f56a939c..857941d83f1f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -4009,12 +4009,9 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
>  		config.dig_be = pipe_ctx->stream->link->link_enc_hw_inst;
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  		config.stream_enc_idx = pipe_ctx->stream_res.stream_enc->id - ENGINE_ID_DIGA;
> -		
> +
>  		if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_PHY ||
>  				pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
> -			link_enc = pipe_ctx->stream->link->link_enc;
> -			config.dio_output_type = pipe_ctx->stream->link->ep_type;
> -			config.dio_output_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
>  			if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_PHY)
>  				link_enc = pipe_ctx->stream->link->link_enc;
>  			else if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)

