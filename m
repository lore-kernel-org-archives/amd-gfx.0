Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE51CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 08:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BA610EA19;
	Fri, 11 Feb 2022 08:25:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416DD10EA19
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 08:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzlAKHya3ZmhlS3P9J8C5FIelrYkAcJGGCwMsCpsPoxU/2xYWOP3FeaglA2NRbYAUFVXUD3PCtfr78/+sIz1zZL6gsCV0OLLZRr/B5mBpq8Lfg3gT64motuyNzvz6iB1P8pI0ifyhHmLjYQlmWbQwYnsBlFaG27XEdCG73sD5guwKAz43n7+ZnOhXg4k13Avh67+yNrnskG1CoXnjjJGRNdSgTW+Uz5m7GwcOaL8GnnU3GfsRHddn8r/Nb3M+Bm/Imvgss6acplRmGmB1UVSRGJIM4O3QKIIHREwMkdbR431GrJ6VouYw4XZX73qpNzhTJEE+0iGmfrD0TfUZPaHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c875+nrtgGECruyikbT3JYl+x5H4sfUsjiG+IlpbDI8=;
 b=G7D6kCKkawjpykUit+JqW2rl8umFE+P+Hrt+1ksDNQcQRUs8sla+BwOdrQkdQuESdpXVd5BaLp1ZSzEjhtsoV3EVb695tPh7o38NIyxcWILQQH4243WVBozRsMlaEkIqYiiT5BzgS3wKZjibaEiUY+OcoI7/s8ilr3Uf7wh4Nu15EWGzku9niAqEMKgdYDTnd/9IFYD4GW/FN2L+MezErSyLOPd8MN2/MQVKYzfb0sB3ch+46BxFYnwypTGf/bpEtSvakqFcf530TbmkTfyId6lC4WdUvwoPTL3ncQYSgylPUmdpGr2sEZT0WGx4a7AWkLG+Bq9WDHo/Hq1shovggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c875+nrtgGECruyikbT3JYl+x5H4sfUsjiG+IlpbDI8=;
 b=k+C9bqrH/MP/ndbPgtUpAC7emnbhnSopQjbhi+IywcbVIVsGRnEPz+GahIONeFzF3b8NkW1uRT3XIrRRu41xoWKffCgCRd2CIJQ30sd//HDRAFx4wdcHA+Rql1IjX481GUyhVKnMVW8CxSQ3wjnwedlPCi5oft3mN9oLh/kbQj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Fri, 11 Feb
 2022 08:25:17 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3%3]) with mapi id 15.20.4975.012; Fri, 11 Feb 2022
 08:25:17 +0000
Message-ID: <1e120ac1-7f0d-fa88-3e1f-d5d190db9983@amd.com>
Date: Fri, 11 Feb 2022 09:25:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: remove ctx->lock
Content-Language: en-US
To: Ken Xue <Ken.Xue@amd.com>, amd-gfx@lists.freedesktop.org,
 Andrey.Grodzovsky@amd.com
References: <20220211082410.31186-1-Ken.Xue@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220211082410.31186-1-Ken.Xue@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR05CA0003.eurprd05.prod.outlook.com
 (2603:10a6:20b:488::29) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f4f9bc6-d3cd-4600-3643-08d9ed380895
X-MS-TrafficTypeDiagnostic: DS7PR12MB5718:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB57184333A91DF4A3EAFBB2CC83309@DS7PR12MB5718.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRhWr85K8VKZKexKTooHhJ1MpTx7FTDnWFw2oMwR6qB+xstXJwWcLLK+0RwXayweBKvgCJlX7oDdLPBIzfVdV9Ht0PFkdcijlmGzbqOXhdDBY9ca/ht9cxyOSswjN6uWsz+yVjYPWtQ8H4AaXAXZK3PD0O7PpqOEgEHk2s5CtsA+m3i3CHt/P0/wouG2V4aaxXLvn2kdS4Pw5UtdryBVBlk+Mu01PhfhUbZ8n5JWGgDD0GZBHjcv9wi1dysM7A5a4EZoQUGZsUTUpwoij3kWd5zh/HPXwfWxnk/b7F1qdL9TnVZdXtna3N/xu/IEYq41RkbVlSnS9x96oWfq6WsXlxQZMV7CO8hwYkV/hR/cg6KqHCBYSk02zs+LBTVIPa1RDZ6GZKhWU5T/7UuRqZRpZdwGoG5uZnkvyK0p4SoqYgXvGZzBdfV16/m5Z6AgbX2Wfm6fC/gAW+inAe1uGfpoNXwePe5+Q2CS1ORq14KwmQL9IXbSWFNsyBzn3m7uKWYdiUYQ7xp0T8iCsbe0w1rEh4ABuVbqZPARKRV9fE752NlaSQQK7uVEfF03AEAjDVTUMZlFKdWLWNjuMuoIRYp8AQ9TsuydNv68UvVpS8gTUGxtbHMZCcCPaepHyAvxSBhmlQJAsut0Kw7SrR+JkKVWXlrFsx0CAVEsRKgr6xjtY9fZ3lkvakOB8TObPEW7cEfZBh51nwCjSswBi/2bEFdvJfurBUd/8zW3ucnA6g0NsFMoClROwIKaDYSgvjJkh5iY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66574015)(38100700002)(2616005)(36756003)(6666004)(6506007)(6512007)(186003)(83380400001)(26005)(6636002)(2906002)(5660300002)(6486002)(31686004)(31696002)(86362001)(66556008)(66476007)(66946007)(8676002)(8936002)(316002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXc0MzVpQ2J0RzAzc2c4SVFKZHZKdmJLRTVzOW1Kdnhjd2QrM0ZtdnNWc1pC?=
 =?utf-8?B?dWNQRWQ4ZEFmM2FSTENYYjVBWEVhU0xuSmNlY2dSaUJocEo3bVlhWlRlZkRl?=
 =?utf-8?B?ZW1WRWhUODlBdmlwVzFUY0ZSSko2emZlSWNHSjFYV1IrYUs2M0J1UlZpRm41?=
 =?utf-8?B?bUdXSFlpTWs2TW9iVmluWitPOEg0c3FyazJKUEdDbnRUb1B3cEphOXJ4Yzlj?=
 =?utf-8?B?a0NTdGNvczdPdm91OEdzSldTYWxsdEdib1Zuckd5a3E0dFQ1bjkwQWllRGQ0?=
 =?utf-8?B?UnJ3Rm4xSS95REJ2cFVtWFBLSmw4aVVXZUp3MnV0T0E3U1BLeUIvb2g0MVhU?=
 =?utf-8?B?T1RLSE9ENmd4SFloaURlRHVZL1BmRzVzNzMxbmk3T3FqR01nTjBkSjJvaFhZ?=
 =?utf-8?B?QlltMTBQMW9UbWlLQjViRG00SUFoNUlOaStMQ0I4d1NZcXZoM0VTaDR6YXho?=
 =?utf-8?B?K202QU8zMVl4WWFqcStJbndLWkNLQksyNmViaWgwb0ZHVTZrNlVlL2FPZ1NI?=
 =?utf-8?B?bktPdjI4eFM2L1VMT2YwWU5ocFZ5NnhyRmRCV0xyNzRWMjFJWG9QeWJXbmps?=
 =?utf-8?B?WmIxbGlCMmt3VlVaUEQxUmwvc0h3U21PdlpnMm5kbXVzdm9sNWh1Y1h1NjZG?=
 =?utf-8?B?aTBkY1dqT29VQTV1T2t4SFQrbkhpVTc0VkJVSjN6WmJzL1dVV1oyYjFIQUxl?=
 =?utf-8?B?dU11KzZSaFkrb2J6YlhISW13UEEzVzRrSmh2cjc4amo3WGtpek9qd1NRTkZL?=
 =?utf-8?B?NTJ1bzZUa0ZBY2pOenZPZkRtU1FCdktGdE12bHFlVk1rZHBKdFhJeUJCMUxH?=
 =?utf-8?B?bXlmQ2Q1MVBneGdOcHNjUzVVSTY2a0RwZ0x2YmZOMmhQb0pGWGY0SkRYUkhu?=
 =?utf-8?B?Rnd2Zm1RZkVSVFdNV1lvNXo1cUt3aWhVZ0Z2VGhVRFJoTnRwaVlwSnc1UHcx?=
 =?utf-8?B?Um9OWnVsSkdkYWJldVhTRzcrWW9zZTlUNEx0S1FIaXZuYnFKZjkxb2lCQ05r?=
 =?utf-8?B?TUdDTDkwYlo0czgwYWFKcWl3dFdWYlZjbDJQNWtYZ1BtNlA1TzJacE1KeHA0?=
 =?utf-8?B?elIxRzdyZFU2TWxDUmIrUlVNaTJrWkNVTCtTS1F6V2JvUnB5Vy9tQjIybi85?=
 =?utf-8?B?WXpJOGpNajkxa3pPektjKzJqVVgyeE9YVlE5RnFCRGtmOTBPdEtYSW9yVXkr?=
 =?utf-8?B?OUxML3c5YmlYOFp4SlRQODdsWmZEaU52VzRVRzNQcTc2OHNwUW1yMzN3NXk5?=
 =?utf-8?B?cEdEak12SUFGbjlFQStwOVdXVEJnR1JFb2M0OFlTb0Y4UDRrMnlDcXhEYWhr?=
 =?utf-8?B?ZVZ5QWVaVHdTZG04NzFHVU81YWMzMWp1c2x3bU53L1dJT2U3ZGM1ZHhHcTVT?=
 =?utf-8?B?cmlZWHoyZTJpc2txNzB2Tk1oNitrZFlMMW56VGJVbTJBVDE2NmNWK1dOMS9i?=
 =?utf-8?B?R2lRTzhiZnUxMFVER2Uwckh6R3hnSW10cTY2RmlJejZzU3QrMFFYdmN1N042?=
 =?utf-8?B?SmNUa1d3TUhnckdsclE3REFVVUN1Nng3c1ZaTklWQk12dzhpbFYrTXMxYkor?=
 =?utf-8?B?dlRtam0wZGN1QlVXNGNCZWVFTlI0VkpacW9rZk9XRHo4R09qQldYR1JZMitj?=
 =?utf-8?B?RW0wOUdzZUFhb3ROTGdCUlJ0czc3MTJxRFNzWnFYck1NVlNHbTVsWWI0MUgv?=
 =?utf-8?B?NkowY1cvS3U3bTQ4cThlQkVYWktFS3lYSDJpbVY2TkZlUnJKMk9xcEJialV4?=
 =?utf-8?B?cXBJcDMyVXQ0ZUtWSFBlUXZwRXh0SWxNb1N0T0VqdjFNS1JaNEg1eGxDTGFD?=
 =?utf-8?B?Sy9qMk1ydDljZzNNTThwY1B2RWtYT25zQ0JLWjBRNlp6TGFPU25rTWVaWkFv?=
 =?utf-8?B?T1NreUd2M0p1enNsa1RqOU1SenhBNUowOXQxa1M5VWo3NzhaS09QbGdWdjJ0?=
 =?utf-8?B?QVg0ZDlZTVc1R3FiVWpnbDBQTnNqUmR3KzhBckZDOUNGeVVVSDM2aUlIOXFC?=
 =?utf-8?B?T1krMXBKK2w0RTVkdXNyTDF0Sm5OekRKNkk4d3J0Nm96UllMUmNsS0NIUFcx?=
 =?utf-8?B?TlFMSVNXVlFoa2Z3MWI4azl2d2RRZTJkaWI5ZXB2R0J1Ymk0allGZkFrZU12?=
 =?utf-8?Q?EIio=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4f9bc6-d3cd-4600-3643-08d9ed380895
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 08:25:16.9927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCupUEiMqr0MO8eproFj2TlaHAHwySLu17o/aFPoqmKrrg2MN7SDJ4/6lPBMd+Lq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
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

Am 11.02.22 um 09:24 schrieb Ken Xue:
> KMD reports a warning on holding a lock from drm_syncobj_find_fence,
> when running amdgpu_test case “syncobj timeline test”.
>
> ctx->lock was designed to prevent concurrent "amdgpu_ctx_wait_prev_fence"
> calls and avoid dead reservation lock from GPU reset. since no reservation
> lock is held in lates GPU reset any more, ctx->lock can be simply removed
> and concurrent "amdgpu_ctx_wait_prev_fence" call also can be prevented by
> PD root bo reservation lock.
>
> call stacks:
> =================
> //hold lock
> amdgpu_cs_ioctl->amdgpu_cs_parser_init->mutex_lock(&parser->ctx->lock);
> …
> //report warning
> amdgpu_cs_dependencies->amdgpu_cs_process_syncobj_timeline_in_dep \
> ->amdgpu_syncobj_lookup_and_add_to_sync -> drm_syncobj_find_fence \
> -> lockdep_assert_none_held_once
> …
> amdgpu_cs_ioctl->amdgpu_cs_parser_fini->mutex_unlock(&parser->ctx->lock);
>
> Signed-off-by: Ken Xue <Ken.Xue@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 16 +++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 -
>   3 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 1cd677bd5d7e..b32a7cfbe1e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -127,8 +127,6 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   		goto free_chunk;
>   	}
>   
> -	mutex_lock(&p->ctx->lock);
> -
>   	/* skip guilty context job */
>   	if (atomic_read(&p->ctx->guilty) == 1) {
>   		ret = -ECANCELED;
> @@ -571,6 +569,16 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		goto out;
>   	}
>   
> +	/* Move fence waiting after getting reservation lock of
> +	 * PD root. Then there is no need on a ctx mutex lock.
> +	 */
> +	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entity);
> +	if (unlikely(r != 0)) {
> +		if (r != -ERESTARTSYS)
> +			DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> +		goto error_validate;
> +	}
> +
>   	amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
>   					  &p->bytes_moved_vis_threshold);
>   	p->bytes_moved = 0;
> @@ -682,7 +690,6 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
>   	dma_fence_put(parser->fence);
>   
>   	if (parser->ctx) {
> -		mutex_unlock(&parser->ctx->lock);
>   		amdgpu_ctx_put(parser->ctx);
>   	}
>   	if (parser->bo_list)
> @@ -926,7 +933,7 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
>   	if (parser->job->uf_addr && ring->funcs->no_user_fence)
>   		return -EINVAL;
>   
> -	return amdgpu_ctx_wait_prev_fence(parser->ctx, parser->entity);
> +	return 0;
>   }
>   
>   static int amdgpu_cs_process_fence_dep(struct amdgpu_cs_parser *p,
> @@ -1321,7 +1328,6 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		goto out;
>   
>   	r = amdgpu_cs_submit(&parser, cs);
> -
>   out:
>   	amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 2c929fa40379..1c72f6095f08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -230,7 +230,6 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>   
>   	kref_init(&ctx->refcount);
>   	spin_lock_init(&ctx->ring_lock);
> -	mutex_init(&ctx->lock);
>   
>   	ctx->reset_counter = atomic_read(&adev->gpu_reset_counter);
>   	ctx->reset_counter_query = ctx->reset_counter;
> @@ -352,7 +351,6 @@ static void amdgpu_ctx_fini(struct kref *ref)
>   		}
>   	}
>   	amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
> -	mutex_destroy(&ctx->lock);
>   	kfree(ctx);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 142f2f87d44c..d0cbfcea90f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -49,7 +49,6 @@ struct amdgpu_ctx {
>   	bool				preamble_presented;
>   	int32_t				init_priority;
>   	int32_t				override_priority;
> -	struct mutex			lock;
>   	atomic_t			guilty;
>   	unsigned long			ras_counter_ce;
>   	unsigned long			ras_counter_ue;

