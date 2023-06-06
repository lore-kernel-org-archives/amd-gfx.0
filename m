Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0386C7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 15:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9272310E371;
	Tue,  6 Jun 2023 15:29:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B64210E371
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 15:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iN1C0k9M9OgeBOLAAFcQmI/Cne4PopF1+HykuTaZ6tkmPj3t632SwXt3Q7Fas5NwGuaicAN1hif69mZSM8OXjFfoVM1Bm0CbDPq1pG9agawCFbvyv9Vj3QIwQpyKTY3gL7mD0L5QVByCLqWd9OG/Ws0fMwWVjDC8lBKD9qHUjukeUfaCZj0sT7ErqoE7yrPVznY1QfGBZHjkp4Br8OKTAEHZiLbkzh9PlRbr/geL8aN3zUBnbLJEzZQfFCZPHNw0H9e/V0tRlTyqU9yrG7E/6Ud8agbgwznCt8gvSFuItXz3yXvGrAEbu/48fShtwVl1RqU2w1fRMQTIGinOWsGp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbNITIfvBlOAtEu6UYvjas48lbHrau04liXew5yjuXc=;
 b=dLpquznxkRicZmNYHGbR1dRh1+cqhP76D3aqd6VQusnl4t0/hmqrN9DhB8CtZzIzBgiiw3lIs2wfDES0vYDSEd+2irw9WaeSLQtv+jD/+IxymVBPmvu13ifL1JT8KzPiOE2L/NIMV734R8HiOzZOIDvTYJBZz8US2f+CDALAgSoalCtgHBPye9phb6kPCnkLhbHdaPjY0KL1uXRLqZzc/CsGC/EFzvxInD+ZMDXCTcSBLWLkD7/7e616bcJtZWCkRY18omsGo+rThVFpDhUJS4auvnUAmf9kjj51lfKBkwk5IDiTZ8EItuwmk+sAcfKxDUOQNiwY0SXOvLGM3MB3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbNITIfvBlOAtEu6UYvjas48lbHrau04liXew5yjuXc=;
 b=SYvOSs38evRNQPOSCMXRoJ3jWbrQxLWJ8n/b49AHmCqbFDEF1rAxpsA6fUqafaL9Onhdl6YSKm5jTJmwp+hGEjwmWIImNFw3b2A1cAUxTmKHCIoSsZlEeMVOEHxgyRK8wR3GspDbGCcPO9ZHSkfVZz5u+y5w8l6VtJkH+AmhHFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Tue, 6 Jun 2023 15:29:01 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1%7]) with mapi id 15.20.6433.024; Tue, 6 Jun 2023
 15:29:00 +0000
Message-ID: <be2d643a-7d80-92e0-26f0-e51f95c8d7a3@amd.com>
Date: Tue, 6 Jun 2023 11:28:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amd/display: Fix guarding of 'if
 (dc->debug.visual_confirm)'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stylon Wang <stylon.wang@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Jun Lei <jun.lei@amd.com>
References: <20230606131138.2709041-1-srinivasan.shanmugam@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230606131138.2709041-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::32) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 42db2250-65fb-4822-d60f-08db66a2c0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgvGQOyX32WDpXxUWM9UFOFtX9R7WWCzEkpBkiHb7buwJ7Hm2VnD8gfMnNpuJJMvZXEmCTBThU/3xzG1HjpIYj5OelyCFn48wbLmFSAju3CN1zMoQj5axbkzg2JayP2fECUFEiQrlG0+HSzPi7/m6/w8cN1nh1+9G4+1nHqHlbaI/INhJebtnT5AjhVDZScw+av+suMnzl7lIbWyPNwZgtdfSkNx7toW2bgg7UOoZqpk60eBHVwXAZWRB+AQ0KdS2CyEY/lVEPd/UGCIRg6QIqvz5xScQPMfLLJLxM9piSKno1KW57jO2lSWBxiIATG2tnvs7Z84xny3WP+eFRej97S5ycs2Zfr+krj0Rp3NFic1jY23Nx96rZB0yjK5gYCQfqkw7diI1I8G9GE2NRieAVD6lmz/ATnHdKhb5rZ8By2wHf5A7rfsLEaqY5KuAUoSnHpJ1DZI4S31bfNYkhw6Gi7sKy62Sr1yPwYSsTK02QHrAQ/+FsXVrn33ktd5un1Qbwz+wtpDQCdIC3rpXPmxcVR95Hsuk7FEiVzRPWY/OB59YtK5pcsq7Y8xievNCwYvcZZ62SgzpbAYBhMHw/n3UUtaFTbBCzdOTwL/NIX/ueApCPHRtGmlpQPfcr2eoFWywO44dpBBVP3j2aCkQBpGmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199021)(6486002)(36756003)(2616005)(83380400001)(31696002)(86362001)(38100700002)(6506007)(6512007)(26005)(53546011)(186003)(8936002)(5660300002)(41300700001)(8676002)(316002)(2906002)(44832011)(31686004)(110136005)(478600001)(66946007)(4326008)(66476007)(6636002)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUpXL0Y0ckVsb2ZnNVRWWlowZlVEeWJyQ2F5SUJVVGUwYjJGWGMzSUZiMis4?=
 =?utf-8?B?bG16bFRIcGhSajlhQ1lWaWg0ZE1nckIxRDFYRlhZR1NwNi9HNDRkVWNIVGpV?=
 =?utf-8?B?V21GRXA3N2RJQ2FCRDhpSGhIb0o5YVgyWVZsSCtVL29qNUdXMUMwZWpReDcr?=
 =?utf-8?B?c0owbjFWbWdYMmNyMVp6RDJ2ZlQxdXpFZnFIeXhRbExDYmF5Zmt4MUMxK1B3?=
 =?utf-8?B?cU1LUWhrTE84TU40U3gxVlllQUg5d1pnY3BGNHI3ODF0ZHFTWmlzRUVISmNs?=
 =?utf-8?B?eHgrMUlvSjdYRE9vcHF1bXlzWTFGcGZKRkp1QzJWeEF1VEN4eHlzMUZpUkJR?=
 =?utf-8?B?OUZWNTJYb1UwSXlLWDl1ZTNPanoydXZTU3VDVU9KR2o2b2IzeVhGdFlkdThB?=
 =?utf-8?B?OVBRMGJ2TU9vTklMRHlnOW9iWFdNK3NCbmRVMHRQdEhSanNkSkIvOGl3RFZq?=
 =?utf-8?B?Y2dnSlhIVnZOK094L0pIT3ZzRDA5SVVQQUNpREJPalQ5MVI3Y2MzMERhM0xU?=
 =?utf-8?B?YVlZa1JzZEVhbUVTMGRNK01LVEJQSWlYZWNwRHNWQVBSWHVIZk40V09oU2VW?=
 =?utf-8?B?ajlEZFVPd0pWamVBR084aTViTjlObGRQWTUxaGNsUUE3ZG1GdS92VmtpajV5?=
 =?utf-8?B?N3FLNTRuVTV0SS9kcGZsUDgzVExPRjNxUkFUcE5SUlJNWHBLOFRsYWpYcFlC?=
 =?utf-8?B?Q1NtRDIvNERVWlJzRTViSzRQOVJxTlhUbjdqREszaEQvSjJEVDdGelhJOFF3?=
 =?utf-8?B?aGpsVXFmbkpwdnc3N0c2ZFhvNHVOQ3l3NGQ2TTIyS1FGeVRaRUF6WDFFQ1Ey?=
 =?utf-8?B?cTRCMDJvalc3bnFUeUFwQ0ZoRzM5TkpBeVZWNVJpMjVIU1ZIUzRtVkZhWkdP?=
 =?utf-8?B?Ynh3MVYvdFVqZ2dMV0szVjdGcUNKK2JaQzZwbjM0ekVsU0tqTmpzVnlXVmlm?=
 =?utf-8?B?dzdMMlJzUFphMUI0bDFmM01KNWpwUWttaHQ2b2FHMHhTNThtZkhOaHQyc25U?=
 =?utf-8?B?bllUdTN0N2FUN1NmTUFQNnhoSVpiazBxWDRUNVpwL3hvY1BUTUNweFRZV282?=
 =?utf-8?B?dHVGODNyVjk5eTB1YTBKMVB1QkJHZS94N3JVOTd3Wk1GMVVRYzJ2L3NHV0FR?=
 =?utf-8?B?bFF4Y0tEMGZ4WS94Q0w5bDlqZFVOSUtGRmMxdFFOVERBaThuTzRSSVhnemND?=
 =?utf-8?B?MkFiWWd3Z2ZFRjcrM1JCQk5jNjR3azJ4dTlnWUZsNlJkQ0FuWlUwcGRSRWxM?=
 =?utf-8?B?S2FkQjdyRTVmaG5nUGttVkVTUllrZW5VajlYMW5hRHV0Sk5sckQ1REVrMXEr?=
 =?utf-8?B?aEh5dGRzb01jNEt5d1NQRm03dmw3eTRrMER0d1hYVTFpK0UrdXo5bGh5SjBa?=
 =?utf-8?B?ZVVVaFpzZ2Q5c3o1ZTh4TUxuSlhkLzFldWZjdndhd2dvYzB0cUJFNDNyeFJI?=
 =?utf-8?B?OVpDTVYzeXU5QzVONnBJMkdTeGtWdFRvUWFSbDdWbHNCV3JlZTdOYVUwMkUy?=
 =?utf-8?B?VFczdXBzMU95aU5xd242cHpuVStCNmRsMzRTWUw0Mks5b3o4SnRaZExZL3RY?=
 =?utf-8?B?RkVTWnJ0L2thMFdCclUyMi9HeXRaWVdBS2RqblB5c3JGL3F5NFdvMWFlamVW?=
 =?utf-8?B?RmJvdlQ1cFJUMkRiOWoxOWdKa1NnbXVKVWR0UDAydk1ON1ZEMFdHWGgycnNG?=
 =?utf-8?B?OXpWZDVROUxUV3hheURlQi9ZdldOSWNkMFpDWU5pTXFxTzJ2Y0RQNmJlVUJo?=
 =?utf-8?B?WmxHR2JlVnYrQmR4UUJrVDExakhPOHlQbWtwQkh5WEZLUzBGKzBET3EzcUcx?=
 =?utf-8?B?akhVNTdrelFlRmRIUnlnMkJET1lrYmFXeUM4OTRMZGJaeG9lVDFoUU5qVk5w?=
 =?utf-8?B?aFlEMTNpejZXaHVyMTFjc3RBcWR4SFFIMy8rbHFROUVXSTkrVnhqRXNHU0xJ?=
 =?utf-8?B?TlFWMkdUakpEc1R2QW04N1UzZWcxNng5d0RlNVhsS3BtSy9MS0JudlRPTVdo?=
 =?utf-8?B?eW05Qm42QUFNTUV5MWh6cDdEdll5RHJEekNOM0UrWTJiMzhBMUJ6YU9VandD?=
 =?utf-8?B?c3kvckdZanVDa0hPRlFVN0tUUFZHYzFQcXY5NEhHazNlUGl3UHdia20rVCtw?=
 =?utf-8?Q?S7clp1+ff/4OyrKpzfJo7pTna?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42db2250-65fb-4822-d60f-08db66a2c0b7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 15:29:00.8413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NneQmcsMZHC12D10wwwqDyWE/yx10/YXPFMIs9fMtcPQAZ1kUCq+rNujy3RdkFvk3afiCTwn7d2WaOUdSKaNEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/6/23 09:11, Srinivasan Shanmugam wrote:
> Presumably the author intended to guard the for loop with
> condition 'dc->res_pool->pipe_count' under 'if (dc->debug.visual_confirm)'
> so that's what I'm changing the code to. Hopefully to do the right thing.
> 
> Fixes the below compilation error:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3546:3: error: misleading indentation; statement is not part of the previous 'if' [-Werror,-Wmisleading-indentation]
>                  for (i = 0; i < surface_count; i++) {
>                  ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3538:2: note: previous statement is here
>          if (dc->debug.visual_confirm)
>          ^
> 
> 'Fixes: 25e1a6115fc2e ("drm/amd/display: Refactor fast update to use new
> HWSS build sequence")'

replace the lines above with:

Fixes: 25e1a6115fc2e ("drm/amd/display: Refactor fast update to use new 
HWSS build sequence")

With that:

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> Suggested-by: Alvin Lee <alvin.lee2@amd.com>
> Cc: Stylon Wang <stylon.wang@amd.com>
> Cc: Alvin Lee <alvin.lee2@amd.com>
> Cc: Jun Lei <jun.lei@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2:
>   - Guard only 'dc->res_pool->pipe_count' under 'if
>     (dc->debug.visual_confirm)' (Alvin)
>   - Fix indentation issues for forloop with
>     condition 'surface_count'
> 
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 37 +++++++++++++-----------
>   1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 5e18fc0c79d6..51fbf04a9901 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3534,32 +3534,35 @@ static void commit_planes_for_stream_fast(struct dc *dc,
>   		}
>   	}
>   
> -	if (dc->debug.visual_confirm)
> +	if (dc->debug.visual_confirm) {
>   		for (i = 0; i < dc->res_pool->pipe_count; i++) {
>   			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
>   
>   			if (pipe->stream && pipe->plane_state)
>   				dc_update_viusal_confirm_color(dc, context, pipe);
>   		}
> +	}
>   
> -		for (i = 0; i < surface_count; i++) {
> -			struct dc_plane_state *plane_state = srf_updates[i].surface;
> -			/*set logical flag for lock/unlock use*/
> -			for (j = 0; j < dc->res_pool->pipe_count; j++) {
> -				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
> -				if (!pipe_ctx->plane_state)
> -					continue;
> -				if (should_update_pipe_for_plane(context, pipe_ctx, plane_state))
> -					continue;
> -				pipe_ctx->plane_state->triplebuffer_flips = false;
> -				if (update_type == UPDATE_TYPE_FAST &&
> -					dc->hwss.program_triplebuffer != NULL &&
> -					!pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
> -						/*triple buffer for VUpdate  only*/
> -						pipe_ctx->plane_state->triplebuffer_flips = true;
> -				}
> +	for (i = 0; i < surface_count; i++) {
> +		struct dc_plane_state *plane_state = srf_updates[i].surface;
> +		/*set logical flag for lock/unlock use*/
> +		for (j = 0; j < dc->res_pool->pipe_count; j++) {
> +			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
> +
> +			if (!pipe_ctx->plane_state)
> +				continue;
> +			if (should_update_pipe_for_plane(context, pipe_ctx, plane_state))
> +				continue;
> +			pipe_ctx->plane_state->triplebuffer_flips = false;
> +			if (update_type == UPDATE_TYPE_FAST &&
> +			    dc->hwss.program_triplebuffer &&
> +			    !pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
> +				/*triple buffer for VUpdate  only*/
> +				pipe_ctx->plane_state->triplebuffer_flips = true;
>   			}
>   		}
> +	}
> +
>   	build_dmub_cmd_list(dc,
>   			srf_updates,
>   			surface_count,
-- 
Hamza

