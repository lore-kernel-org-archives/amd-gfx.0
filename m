Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59F9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 10:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA8D10F6F4;
	Tue, 10 May 2022 10:24:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C9F10F6F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 10:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhXae7uFXEQkfuTt0ar5FcQth0CJxIhngOzgFPTFae+7hGiiVB1EpLnxs3xPuwsnj20zomnbYyQY5vixaEwMjxjk+DMRhrFeW0LyHc28+tiWOLBccckcN0FtEDJg8FE13DtS9LyBcmqGU/CpVgGHLfm2LYSrdrfym/ZIv0klewL7XMdQ6+nCeu+ddg5L4E2CDeQyDZPuzQPUsJdxnZWL0OY+2FctWkvdjH9dKIYGPqqvZKY6/xWMAWgG7S32cM8uKKaliL7I+YN+s+sNMorRoYrowTfqSPPyIUMe8FwwuKQqXWs6ofyKimy+NxD6TSPk9+rO5WckYLE6kvhFyejv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XDIXboOfSr8Cn/VDZhd3FIx3r0wsg8JxTDO07tLqWU=;
 b=SoSsItvm5/6hugS/I4KRC2biKfifK1UNPbcfmoVddXeyos94oj0taBuQaMxcqCECz9PoXmkLEcS2Xq4ijOyBep/30uVFSbiY6G26mM4TYzqmILA1E2PnuVDZNU8nJvpnaGEZPjIbI60qVW1Jpy2noR/DT/eSVks9jtBip/Qehphrr8j9MLvSfbgDSRGPZVp8VgtVe9YzfEYXeVGE6eVHuIaagO3gQUFpuVQn1olfBM9x82Nse1toSqUf73bvTkZ7F5CRWKRHj1McVgELcO+fT09hx1iBmdUXmz/oWXMOBbFF3BMsm9Nm3uTxn/8Q7ZLJXniXunva+veKenguXf1YaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XDIXboOfSr8Cn/VDZhd3FIx3r0wsg8JxTDO07tLqWU=;
 b=FhpZXzAVQkVDz/BZz4mCBzj2KQdaTYzI/G4D8AFlIEi25yBXuK9MHlKctkVz7bbQzj4Hwa4GDFqLP9EqmUbTz4Tr7RDr1pNtDAX4z4MjwGEae/STWiLvCgokoPMhjbk4fscJ1tPJl0YINilISqnJaOEuUzM+Q9MOgzwixmzcl9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 10:24:35 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 10:24:35 +0000
Message-ID: <b6dd6b0d-306f-c84f-af4d-5015030f1aaf@amd.com>
Date: Tue, 10 May 2022 15:54:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu/ctx: only reset stable pstate if the user
 changed it
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220509200335.482514-1-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220509200335.482514-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::8) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 028eeadd-1a25-43d0-910d-08da326f4791
X-MS-TrafficTypeDiagnostic: BN9PR12MB5212:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB521259A511D4F210C74C51E097C99@BN9PR12MB5212.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1obZLdTordeLAom/8sIeT6lAQHJYE8F0/yEYpxn9krZp6KTQcvSL6SOYzJs2BUZc/aVt/X6W95yUw29X78Czw4s7L2G1QaVy/71MeiEelKA565tBmlT+S7bKdb5YC2BrGUHAZp9uySKRa2ilblYlk68tlFCA8WakrpgyWqgy43e3OLBqRq6WugajBlFtD/zkztfw6inomgxR1OXFXHw0tiwWdh0iMJM4l5lFLwmMcpjYnirImrJhEdDRNofZ+88xKpD3xQOCprp68P9bQH4byPV3t3gcwu46xUeCsu96dfxyRf4zRSs25xkF/xFCzYIeCbrrjXsgE2gwowCxIF3Q+gzDz9FjXxj9V3czTVxeUu+SvrBRGyqa2lKBaEJzZRhq8qYlvltzsj5IAgg9PUtVQOL8m3UKgEoHypxO/Wrdhw2xk6UPeMaozm4ql00ta9xr4CLKxUJjFolNzerAqNe7wkjRANLYKNE9yfHpmrbMFOKMXZ2ZNddvClShaLYnzHKLGMGYhL1P1kKrYyXP7LS9rzMP3zvTxZ3VY9C7+a+1QqKDWZDAiRc1DN5EGBPO8OA6QmC6fh+Z88iQiJGMNMevNGM72Zm5OIv5FAqTaLkyUSTjAtw1fP42rBDglG6zPevEQnjNPVf+YnXcjeZw7sZe8017kIsnDJvbPsb8K/f+QWklj3d2D2k1fqt6LcnEermTzVQYKM9SRYOt/DCKkFaUJyX38oiZmVupFa4OriZ6SuQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(2906002)(31696002)(8936002)(31686004)(38100700002)(5660300002)(83380400001)(186003)(508600001)(66476007)(2616005)(66556008)(8676002)(66946007)(316002)(53546011)(6506007)(86362001)(6512007)(6486002)(26005)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUpTdTZKTmNiUytDeXpycXQ2WTloQWg1YzE4ak41T1lYa2p6UlNzTVQvWVBU?=
 =?utf-8?B?czhXNDkrN2Yvb3oxMFVjemlEL3drUUdNWjlHSUJNODBGSVBadFludjZ2VVVz?=
 =?utf-8?B?ZUdvZXBzNVN4V003Y3MrZU5hdzM5TDR6Z0ZrTk5YLzV4ZkxrbDBXVGd1ZVZC?=
 =?utf-8?B?TkFGaXNPVGZ5Q1R6aUhiY1VzeDBxM2luNlRTbWVlNDUxendSQ2dOVXBxRm1k?=
 =?utf-8?B?QnB1M0l2eTYyQkVxM3lTMWpWdlpvcm03L044Wk4xWEpCejFyaytScU05VWVE?=
 =?utf-8?B?RXJNby94a2JPdFFudDlYMnd3YnJSRFM2YXZjR2ZIOVBuZWloQXV0Z1dUSDIr?=
 =?utf-8?B?TndQNVNXWVJZblJwRDNkMjVGZndRa0YwV3l5UDV3Y29TZ21ERmRwS2JuT3Nq?=
 =?utf-8?B?cVJ0UEs5QWVyYWF5RWtnSHRQdmVkU3VoU1pyMWh0NURnNWdEOEFTOHdJMkQ4?=
 =?utf-8?B?WnZwRzEwV2NZZVdnM25PN0k0TXJwTjczSDgxdnl1NlkwL29TYm5Ib3ZVNEVi?=
 =?utf-8?B?ZE02R0JzeDd2U0VzcHEwMWlYT1A0a3d0a1M3YUpCNjZBa1BmSGcvN2VrV1hS?=
 =?utf-8?B?RWR1dHFyZWdILzZLUHo1QmZuc3REamM1LzdFNUJ6UDNQK25Ga1FCMEttbWFz?=
 =?utf-8?B?QVB1K3dEVkpqL3FPN0ZBNFBJQkhuVkZEOFg1a3YxbGlwV3VjM2tnQWpkTVY2?=
 =?utf-8?B?NXUyNm9YOXR4eGRsU2Y0UGhHclVuNmNEb0FRWTRwVk5JQ1czYklWeHZFazNj?=
 =?utf-8?B?Slc2NXZ5bHVYWVdBOUFBWFZ1dUhLYm9pakZGUG1mTEVmVlp6RW5TSGsvQmZS?=
 =?utf-8?B?eGwzZXZmTWN2aEVzU3NDSnd2ZkloY1VtOVZUcENTR2p6U1BJclFuZW4xbkYy?=
 =?utf-8?B?eTkwVlZoZndsZ2ovTDBvTjVCV3FpcnNHWXM2QnkvbmE3R09RQ2hSZ2JWSGlO?=
 =?utf-8?B?UkV1VGpGVlBwRXlCZ21veEtNd2xsUUhLMVlQbWxrS2lwcXhwRmU2RTB1QStn?=
 =?utf-8?B?a0N1bENCMEgxS3BOZitnc2ErOCtyMDQ0NFYzcCttNFFQeUdJUlJpZXRDbVpt?=
 =?utf-8?B?MnZieHN3RzA1aG9KNUQ2V0ZWN216VVh2a0UreG5MUzV3YTdmWFFCV3ZoQXJS?=
 =?utf-8?B?MzlZUUF2ZytKSnlQak15MmEvM1ZQQkgwb2JlSUNMMlA4TmtxK0NqRlBXV3ds?=
 =?utf-8?B?Yktia1dRQTVCLzQ4QXpkb3VDbUZVZDVQTUxFT2lkcE1RbUtCdmd4NDcrSysy?=
 =?utf-8?B?MkJPTzRNQmh1anJmL2poK2ptaXFCVGN5NzBjNVVNK0ZEeUlsYmFCdGVIUmo4?=
 =?utf-8?B?OWdpZEQ3cmdmZkcwWm5ZZVAvSzBvenlzV3YwWEt3NDBsaFFlMkRudXpUOUpl?=
 =?utf-8?B?WWV6MTh2VklsSzdYR3ByTVlCcVVFaDd0TTlNODh2bVg4eXMvYU0ycVhYL0o0?=
 =?utf-8?B?WUxXV085RUUzbEtOenM1TmVRaUJpemJDaW9ibmRVSTdzMDhWU2c5OG5YTlZZ?=
 =?utf-8?B?elNIa2JhZXlRVXRETmdJR2VCYkZzVXdLZ0liQTJXMVUvMDc4SGJLSXJrRmhN?=
 =?utf-8?B?cXphalpvblk3aHpjdDhobGZic1pjWm5ieGZweXBHVnM2RnVpbGQrS0tJM2hH?=
 =?utf-8?B?d0JoQVFqRDQxMHpHMWN5NVhJOWU3SS81R0dHSjI3U1RsUGVWVkR5WW9NdGVa?=
 =?utf-8?B?Z2ZxYXhtczNhSWhYZ3JOTEZUckZSYlJFT0grNXpzL0kvbDVRNTBiZ2hMUTZ1?=
 =?utf-8?B?djlmU3dRN2dhQUh2WEQ5R0d3LzdLSXNUZ0RRWGtBWlpHeVpqd042UXYvYUJM?=
 =?utf-8?B?SDdZVm80SUxyUEZyc2U3dDNwbVV4ZXpUVDFWS21NZnBiUnA1WjhQWDdYWmU3?=
 =?utf-8?B?NGgrbEhqaUhLRkpIS1MrT1dmTHhCOExJU2dWNzlzTUNlMmRsZ2RZSld3VTB3?=
 =?utf-8?B?SmV1ZlpZaUc4aUFMQW93UytHZ2tXeXloSUMvUCtqOE5ibFI4bUk2dUlvbnZF?=
 =?utf-8?B?c0hKdjdubC9JYmNyRjY3QVpCNVhtTzRQSTJna2c1SkxTRVd0WG1lbUVDUGlY?=
 =?utf-8?B?Ujh0NkMxOXVWSlpGTXBmMzZkV1ZnR1cwSk1nbUsrMTlNTGV4T3dmWkk2SjRF?=
 =?utf-8?B?SXkyN0xKOWxPck5GMkdGMjhzVjhXWkZwSTl5aE1XbnVNMjlJQWZ6MktPeDNG?=
 =?utf-8?B?QVBvN2J6ODRjczBUWitvN0lrdDhtN09xeWU0c1FrTWJsaWdaT1VKZERsRWpX?=
 =?utf-8?B?alhKR0cyQkJ6bFVlNWtDRXgvaWJ1RkwyOTNiY0xQRS9ETjdsRjhYSHpSbVJU?=
 =?utf-8?B?RXc5L090dnJEVkFlaFdRV1dJY29JOUFGN1JoSDFaNXpYSEhyY0ZPZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028eeadd-1a25-43d0-910d-08da326f4791
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 10:24:35.2952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/D8Az8XMJaiN7Ke+9tlUZjUSIEXH4BQleOwJpJfyWIXW3gklIFz17U5o5bOXTc8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212
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



On 5/10/2022 1:33 AM, Alex Deucher wrote:
> Track whether the user requested a stable pstate via the ctx
> IOCTL and only reset the pstate on context destroy if the user
> actually changed it.  This avoids changing the pstate on contex
> destroy if the user never changed it in the first place via the
> IOCTL.
> 
> Fixes: 8cda7a4f96e435 ("drm/amdgpu/UAPI: add new CTX OP to get/set stable pstates")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 5 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 1 +
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 5981c7d9bd48..e4b0c6ec227c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -330,6 +330,8 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
>   		adev->pm.stable_pstate_ctx = NULL;
>   	else
>   		adev->pm.stable_pstate_ctx = ctx;
> +
> +	ctx->stable_pstate_requested = true;
>   done:
>   	mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
>   
> @@ -353,7 +355,8 @@ static void amdgpu_ctx_fini(struct kref *ref)
>   	}
>   
>   	if (drm_dev_enter(&adev->ddev, &idx)) {
> -		amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
> +		if (ctx->stable_pstate_requested)
> +			amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);

Why not have the check inside amdgpu_ctx_set_stable_pstate - if current 
stable pstate is not the same as the requested one, then only switch. If 
the user has not made a request, it will be NONE and the call doesn't 
have any effect.

Thanks,
Lijo

>   		drm_dev_exit(idx);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index d0cbfcea90f7..f03e842209b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -53,6 +53,7 @@ struct amdgpu_ctx {
>   	unsigned long			ras_counter_ce;
>   	unsigned long			ras_counter_ue;
>   	uint32_t			stable_pstate;
> +	bool				stable_pstate_requested;
>   };
>   
>   struct amdgpu_ctx_mgr {
> 
