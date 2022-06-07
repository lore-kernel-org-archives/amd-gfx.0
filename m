Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A743DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 17:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A9CD10F5C4;
	Tue,  7 Jun 2022 17:40:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3463410F5CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 17:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMJBM9IZ452U9mBTdFsyB2lSq48uro+V+HP9NYKvpy0eCwHS78Vx97y5R0Rwu683GLH8xO41LR8nubY0PynI2SeMbO5fAv7k2RveDVub5VgG8A+LwsxNGrMTc2tO+y6pfSYu1uPZNWvru08lYsmuRiuAgJA6bS56B5x0qykyp0CGf2YsUTvTyci69Z6yFNmeqRGDYWt6iAhM3Gtbf8n45V/MDHI3ATP57vEMCHM4shIhtxNCES94V/9anK8tx+E+b6PkhTdYKHf+rAxvIK23bySd5MMY9xCYz6iedZtVbH/+Gv8Aq7BWntL2gPSzSpFN6Eein2i/SZ+mIr1qgE8hbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYGVIskQf94OLUFPzBSG/+AGE+q3FtPXcNIMOafQ2ks=;
 b=XLrOYzr1Xqkql5gkFtIEblMWTtSOvm31x9js5pTDKAslDfADN/k0/K6K8R/7v4Fzrx7BlndP2yzG8xhpcWbs35NZ1SwJOU6WfMiJ2t03RCgRRFOIfeAPJ/8WZpVC8zkN6TXYQQb/x5AjB3urCQrZ+csNbirHBnWNokkkRAdkJvmR5ThMxnp4dGaIQGocxUoh5famLscB0sTTEJLFxF6vBt4wHj3y3MWcbTXOFl9X0/WZh8cXyNpJ+eI99ekS2v3eeqUsMP2XwPa6LjaZJV7bzJoaeJlh1ByG0m+OXZD7qy3XZjliOLmI6KtnK1qNtyFuDfd7MC9e3VqvqZOIczT5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYGVIskQf94OLUFPzBSG/+AGE+q3FtPXcNIMOafQ2ks=;
 b=xcXYyoEqZM65Ze1NpI30LIwSNBgGvV8aJW16aVD7Np1uHwDE1NdX2d+q/TYE126uW8mUenbVlh+vDLb8cVbfybYu3wmJQgd+MAuylHb3+UsxPtWBrNNMK2qJrPx6OLQ/kU/kdnsDJCM33vn71H8H/KFBKFhJGO2e0hjUjcep0AY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by BL0PR12MB2388.namprd12.prod.outlook.com (2603:10b6:207:4a::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 17:40:44 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::2140:f05:1314:30b6]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::2140:f05:1314:30b6%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 17:40:44 +0000
Message-ID: <a4d82dce-784e-03ca-52aa-abe57b4e5448@amd.com>
Date: Tue, 7 Jun 2022 13:40:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amd/display: fix null pointer deref error
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220607170647.217574-1-aurabindo.pillai@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220607170647.217574-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:207:3d::33) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f0e5ef8-6a4f-4e06-1ee2-08da48acd8fd
X-MS-TrafficTypeDiagnostic: BL0PR12MB2388:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2388701E006AD69DF3E9838F98A59@BL0PR12MB2388.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJo9k4EW1pBKghUQiELf9f30syCVK3WGfvUI0oWg/6CP9qNzgr0sUfKkgBxL5F+93fZWTbh4QrU4smaRcWzfkD4Sx4PliIgAPuFCJAg0DZlcsfTy/NAHkMgxF08nU3FLIcSufmpvBo8V+WPMvoPw1QpoPbzHLePMxN2GM34lpnyOuitVUNZfRLusLaGQNPI7j2tHXFA1ACv+58ZoKs2hYiH+HuMh0wak/3BmZhYXrcfubInnFnBVX3SegDmb0QBvmOs11QYH9rsu13EECM4SyiRGlqFVvAscIYeL9zGtliWcKEfHxp9Mh3TWXcvNxPkI3Q5ZFijqnzKLKNh0BGpuDNKIhP7cnLBw1vEzLFMnHkFwne20O+IWaCqp7suWoNcWA6hb6k52r/+O6x+syJ87xiRjLUcTlfbI30020r9hS6EKWvBOTReQPAQydnxR1iER7XsXv4v/FynfE48Dg0DDbEqlWbOCd85O8tOx+ClxrGjoR4mzXLOhcJYwTZbs6M4FBuKQr964LYkvALpNYhNGFrk+Xgxf0j5q1gqRWrb1+A2KbBTboqDn+1XOZbAmRT1Z4GagHO0+gAVg7Z0MduqtX0YDbfKgE6sMMwlM6K/ChePFTv2X+KS+BrCRVI9RD1z1bjQMLSh4bE+QVMieYkZzhwgwDmZjqC7npCIoH3xher/JkQy8NEN1XdQKF6ESUQ0B739Zs4kkfIg+siYEJAPg0mCWOWXnjNXsgoyd3yVX5/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(38100700002)(31686004)(66476007)(2906002)(36756003)(31696002)(316002)(5660300002)(26005)(6512007)(8676002)(4326008)(6506007)(83380400001)(66556008)(53546011)(66946007)(2616005)(508600001)(6486002)(186003)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlNkcmd2S0pTN3NtcEx2UUdZSWNCeTlIUXBsQTczM3ZKaUdlUUEvdlhEeEFr?=
 =?utf-8?B?dW56VXNNV1NvVkN1RWpKR1ZIUThzOWVuVzRUWUFUaHEyR25DUngvek1WSHJL?=
 =?utf-8?B?ekZGbDVGeWhYczgxMnZuTjVURVhmQlhKb2g4RVdUdlpERnVLYkNDd0FGYkxY?=
 =?utf-8?B?SndSdHhUTlBoS3BXQ2NmU1BoU2JJdlo3VG1FdHFPQldYYWNnL0V3V0FLUS9B?=
 =?utf-8?B?V1RJSUU4S1pndnRCRk95OGJDeWU1akltK2pmNE1yK2lBdGlBNmNHWStIaXN4?=
 =?utf-8?B?eTZYa2pwRGdkMUxiUXRvSlJqQlM2TWZTQUdUbVRCUysyVVdHWG91dDhoY3Zz?=
 =?utf-8?B?bFZpa0hWWm5zdjErbGhQZ2RGWGVob01HWkZjYzkvKzJKQmxkYm1TTmFNbG9O?=
 =?utf-8?B?MVVyMm94d2RIa2k3aFQyZkVJM0ZkbzR1bzVnL0d3MSswWlEyeHNqcG9YV0ZG?=
 =?utf-8?B?L0Q1aUYzOEdjbGxWWXpEMkloZlAyeGZiMnQ3RWwvOVFXUWw2U2VONlo1RGh0?=
 =?utf-8?B?UFozTUhubWQ5N2ZXU29NM2t6UmFmSnNsQm05akEySkFLU2ZMUlZ0dDRNdHEz?=
 =?utf-8?B?QjJCYmVVZGZNcXQ0Tnk0MHZxNU16bjdxQ2xsUUxqSjR2T0taNFQzcHJPeVlQ?=
 =?utf-8?B?SWNyaURTSWhOZlRZOWpaemowMmwwaFNIbTJIRUxGbU5EWklhSUNDSi85YjRt?=
 =?utf-8?B?SlpEN1ROb3R5c0w4L3MvZG9peEtIdTR0amRwTjZ2UWlNekFjN1cxWFMyR2Ev?=
 =?utf-8?B?ZlNvZkFuSnZhK3FUV3p3cStKNmVsbWM2U09tRkZrVjl3K3ZmbWEwQnVHdkhN?=
 =?utf-8?B?cTlSN0ZxYk45WjRuTC9YT0I4cFdPdjNmR0NoMC80cWVXVkFGK3FRaUYrRFY5?=
 =?utf-8?B?MlZ3SmRQU3M2Ymthc2paL0hNTXdQNlNjNDdtK2Mzb0tqb0NDbTZWOHoxbFFK?=
 =?utf-8?B?YWN3VHRicTlKQjh3RnJqd2p3S25QbHkyTkxVTklIMnU4eVc5a1JnM043VjNm?=
 =?utf-8?B?a0ZKUnBZNW4xODNTRlpyaWo1V3hndGJ5N2hMTmpSd1hpV3ZjaWtMVCthRm1T?=
 =?utf-8?B?dG5scmlDbWJpMUtNM2dEczl2eUg3VUgwT0NVVkJwUG53Z3U4UjRQU05Cbmxv?=
 =?utf-8?B?TXQ3a2FEaUs2bVFmNFczM3JyejljRStQbS9YTlJFendBTUg5R2xYWFFBV3lX?=
 =?utf-8?B?TUJiZ1NjUW9pd25jdGtkNlRCaktBZDkwbnpDb0M0azRMSHRVSk0zTUcvbjh5?=
 =?utf-8?B?dEZBejVaMnNsMUI5M3krSUwzT2tIeGt3cVlSdVhQa0d6MUZBV1p2LzBUWGRP?=
 =?utf-8?B?QlRyb2RXSENKMVJOSlpYaHZSSHJvNmplN1BjZ3JIWGxBbXVTMUhkWkNtcFFy?=
 =?utf-8?B?SG80bVN2RmhZUCtuRi9JSjhkOEhPUWY2S0lmWCs3cmpWc01ra1p6UDVZN0d3?=
 =?utf-8?B?dDdNWVNhSGt3QWhLZGxvakI1REQ0Zms0ajBCWnFxSUpXZThHOGpIL1hOdHQw?=
 =?utf-8?B?ZzY1dDcxWUJUSmlhdXErYm5nOFVsNXpXMVB6Sk03SkM5bDgyR3FoMU5ES2t1?=
 =?utf-8?B?ZGZ5SjZBN2V3Z2QvQWphbm1UdnJtNHBkbjdUdWFPU2xRRlJMRHRlRTg2cDB2?=
 =?utf-8?B?blFxNWtBa0p0QkpVVmtoNTVlQlBFd3ROTnBLYXFxTGphalIxSDdDKzV1OTBx?=
 =?utf-8?B?SnE0Z2lmc3hDWGZiWTFSNktVR0ZLVHNCOUc1Zkc2QjBmMXNYVzZXd1hKK05y?=
 =?utf-8?B?KzBZR0l4dzlYNnNsRDdlTTVBY0I0ZFBuUjhESTF5a2QzYmUrU1AyYmVoSXZi?=
 =?utf-8?B?aGR2Z2FRVGQrU0I4SG1VKythMjcxMG9WYSsyR2NJdFl2Q2k3WXBCQmw0THBl?=
 =?utf-8?B?UGJLVjFuQmNMZVFXV01oZnd0bXJFd0l5aEx0NmIzc3Bmd1Fvd05qbmQ0dFU3?=
 =?utf-8?B?VWx6ZVdIOVNXRG9wQisyZDhMVEpoaWptTEVvY1NVWFZHSHVJY295elVLQjBF?=
 =?utf-8?B?bThHR3NKa0d1aGJPd3FkWksxeSs2WHd1Wkc5NVZ0TDkzdkltUmlEaEF6dkxp?=
 =?utf-8?B?V1ZBb3BuL3dlRVV1VVFXT0tsUG9HcGtnT1Z6MWNnbk14UndNRGRXUHJJRFdN?=
 =?utf-8?B?aldaSWVHOUpXNXpNUzhhL1hHK3hLYjJsTGlabGtkb05yT1QvRzg1WWRaNnRn?=
 =?utf-8?B?Q0lvbU9GWWc2MHljblY1MjlCNWhTVlZobDY5TXNMS2RrUUpFbzBzTUNCc1NQ?=
 =?utf-8?B?VWJ3VlhYWUFSRW5EcXpOcHpreVNXczN1OXJhTlNwcGNVeVpXeFdiMFdwWlBt?=
 =?utf-8?B?Vms0bTZHRExua0x2YnZYaSt3eFlReDJMYk9BL0ZNUjRHR1hvcExuQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0e5ef8-6a4f-4e06-1ee2-08da48acd8fd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 17:40:44.0107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFjo71F5mHsKIZ/l8xFzjY2ySbWmHBK2bPxEEpdEsv79SSPwQ2D9sbRtXZ6G8EHeQ+yMs8YPVe2W7vS/Rf5tTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2388
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
Cc: jerry.zuo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-07 13:06, Aurabindo Pillai wrote:
> [Why]
> 0 was passed in place of a pointer which triggered null pointer
> dereference.
> 
> [How]
> Pass in a pointer that contains nullified parameters instead of null
> pointer.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c  | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 631a8a2f9fc3..e7944c881148 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -2191,15 +2191,18 @@ static void dce110_setup_audio_dto(
>   			build_audio_output(context, pipe_ctx, &audio_output);
>   
>   			if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
> -				/* disable audio DTBCLK DTO */
> -				dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
> -					dc->res_pool->dccg, 0);
> +				struct dtbclk_dto_params dto_params = {0};
>   
>   				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
>   						pipe_ctx->stream_res.audio,
>   						pipe_ctx->stream->signal,
>   						&audio_output.crtc_info,
>   						&audio_output.pll_info);
> +
> +				/* disable audio DTBCLK DTO */
> +				dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
> +					dc->res_pool->dccg, &dto_params);
> +
>   			} else
>   				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
>   					pipe_ctx->stream_res.audio,

Maybe it is a good idea to add the Fixes tag that points to the commit 
that introduced this regression. Anyway, I'm ok with this change.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

