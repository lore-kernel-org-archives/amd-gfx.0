Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B000BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 18:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 295A610EAE6;
	Fri, 11 Feb 2022 18:13:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3345410EAE6
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 18:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCLjSnLDZR3Awc6eG5pORetIxWV9KOOczUTfnu5F1YfOT0PiHTHeGD9Xd/Dy5ek1dPZ/8HfRXk6mCkLu/XGtjti3yaMGby/t2kAx4hInDVBoFI5xxlraigW/gzmWNMCwpgn6s+3/h1tJODTfDi1dp/VCJy/j8d/2A/iPU6NPYKTPgipEMSHcfUAu6X9M6g5tCzVQhGRDZFBe/qgCeCZbkSETuuOvUspdShRONk3Gvmzw3Ba0B6bCoIbEyrPhylYeCe6iw5YcEs+WG6eitmChUAU1PNhiEnfroC03cS82wTUHtUM74o/dkxVQcm8JvkBuf9x3wAfrXYEDwFM+5nvxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsZtsFsgaInHFmKKmNKlr9+qM/mG6rwVbkWmNykVIVw=;
 b=VRihL0RzvTg3RcixycezA8UMz/j6jmdkW7cYeVqPXu7aUT/QXBKnJEZF9tzujxyP6CM8PEkwAuQ/IOGtkitjX827Z1cVn+0YAgg+s1PTZiCm4QmXbFvS02FLMYWGeYP9yjEow1HS3kmkvbjRZLDbSKXYkdxcbGLJ01Lpc3DlSZUxFhCUyh2MUSHiZC5xKEZFVdHwCE/5Ic1eXn0iI98Q4Mfyma22qVVFpcR5DTUkiEO5gnlQZd70vGObStGiZv5+p1g77Cl0YkCZDlGodaqp3WvhKPsO0qHPRR3xrdQPfuGF2N6NSlhd4YZbRCYHzTjcqJ5LQOnQ3S3NHbNKMFehkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsZtsFsgaInHFmKKmNKlr9+qM/mG6rwVbkWmNykVIVw=;
 b=mpB2cHtG+AFCEZfBAz5XzDKgCOpB/n/5cNiS4vLSHggCQQW9hCJcm5H3bToQ1fSsxQ43roHGGsFOGBvxnk7E6xqT+yaxrtVP+l2RiAuuJ2d1rYWizdGCMM57sqjA0rNHxhVHZQGXiUqOCfdEPGX+VCoeNtHnEK4WAOBIJXLMTus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 18:13:23 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.4951.021; Fri, 11 Feb 2022
 18:13:23 +0000
Message-ID: <11104985-f99c-0c7e-490f-c489704d3f3d@amd.com>
Date: Fri, 11 Feb 2022 13:13:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: remove ctx->lock
Content-Language: en-US
To: Ken Xue <Ken.Xue@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian.Koenig@amd.com
References: <20220211082410.31186-1-Ken.Xue@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220211082410.31186-1-Ken.Xue@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::32) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3e0cc54-6450-440e-13e7-08d9ed8a30cc
X-MS-TrafficTypeDiagnostic: CH2PR12MB4069:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4069227352244A3158F06D35EA309@CH2PR12MB4069.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nX46TeAc6Jc3PB7zJ5DpKBfSe2qLELxunx767Pa/7N5DrwTegMf0JTGrjzO9pBjU4jx93mwfH9i9MVMRrEFFJVGuD13bJvJ7aFoDu6b/dqli3WSgmqH9RRW93LqRmvWzOlsLhPp8CiipmFNdDgxbIkGHJuLX5POTs+sDKNkOBLxA1oyOWNROvU5ThW2JugxH4LO+GwkJQYE/BMSaGo5H+uxX11LcyW9qkShgZ0ieaFsJko+SHj8kal/SDgtmTMLhKEvGPV6ePGPA5AIkkAQXM26HLAyZmlYUFEriRZj8A5zQ7Vtd3Jf1lEGQgkOeiozUpNok7x6g+2POlnmUAzMax3uG8aD65RoGlAJqRDFuWAoa/yvisFLse40hRyfmFUPaJegfIq0p6IRzIaYqCJQDzoOj7bsN7GP2giqE9PUg0qHPE/IzWCdAlhYRdbstS8z6MQh/liCJwz4eDllhH31yrOnacL3ozrsrveYamyX6EJxw+xy5zRQWS/fwad0OlC/EsAoN2fN8Oek93bnMmolR2GihPArkp1PLHydOxUrIOLF2GwW/iOD7qwct6hNKBd9BsWhtApFNBCh+gJhiiI8O9djPsq7tptloADEBFdx5Jmox4tU4e+AysuRQcajxPoWMLvWOkACZmLj2aik89esO0C4hOrzjPOZeOmWzz6vGYuHyBDmXydXxMa7KwH/jmVbdI7SpKgiEUmu598OryWF602dHy4j50Vjiyidq99Qqwvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6636002)(8676002)(8936002)(66476007)(6666004)(6486002)(6506007)(508600001)(36756003)(66946007)(316002)(66556008)(31686004)(38100700002)(53546011)(5660300002)(44832011)(31696002)(186003)(2616005)(83380400001)(86362001)(6512007)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEdiYktoYnVJakdEcTFWQk9BTEc1bzNHV3dLR25CampvNEhqNFh0QU5kdU41?=
 =?utf-8?B?OTRDNWFvQTBIYzZSc0lwK2NLSm9QdWNUN1dNT09wd0k3VlM1dkVBQklTeUxv?=
 =?utf-8?B?T3I0N2ZLQ0xyNVJ3SWdacy9UaHk2R3RnNDk0MFdtSXZ3NjR1UWtINVFHdDhw?=
 =?utf-8?B?alVUMmhrTW1NR3Q2bDVQZE9LcjEzMjBkcmtabWpob240TkJSRExQZGI4YnB6?=
 =?utf-8?B?S3JTWTdib3NKbTZqY1pFeXRPK2lDSXNmRUFFVFhmaVgrbUQ1NnRpTjN3cGdR?=
 =?utf-8?B?KzN2UUNuMVhHckRsYldQc0UxRXdQRk1WRWxueXdYT1VCVENCbTBVTHI3c04x?=
 =?utf-8?B?cUlDQWIwRWZneHpJa1I4QzAyeDZkeVdpc1JSOCs1ZGtaMlpMYnJJbDR2Q2Fm?=
 =?utf-8?B?dXYrUXB2Wm15Nkd2SFhPMmMvcWxwNGhVZld1QjhudjE4YjNkVHVCR3BLSGlS?=
 =?utf-8?B?dmYweUx6RmdZbTE0SWRrbTNhQVhmK1k5dEZrUTJORHErdjJOL1U1K0lUVlZ1?=
 =?utf-8?B?c3VnN05qSEh4OFY2d1FIMmZIY3M3blB2TzhUSnhvZXVJMGo3cHlyNnY4bVl5?=
 =?utf-8?B?ZG53TVNhd2NmbnlRbXVhcFlXSmIyZDVjNlZGSWpZQUprZVBqSGdQUXVrM2ZZ?=
 =?utf-8?B?MEJRS1J2YTZGRUxCMXVEWEtmRXVoYlROaURlV3dDaWlqc0pxRktjeXN1YVVi?=
 =?utf-8?B?dCtzUi83aFNaalAyYUJaRmFCcnd2Rm4rZEgwaS95cTZpYncyMUxvSERkL3Fa?=
 =?utf-8?B?WEdmWnhzMGRCYmlLWFR5cnN5SVFJNUpYVnh5Y2NFTXFWUkxMSW14d2FEblBL?=
 =?utf-8?B?d0VzS0xheEIzcmdZQ2pZOVdSUmN0Q1JhNDAzNkNORUhvUk84SVAzdGZ4czc5?=
 =?utf-8?B?UUtBc1FWbTh3QStKZDVTUHFDTXdVRW9YeHNoMkt2K1N2c2pIWGJOZ1RrQjdz?=
 =?utf-8?B?akRsUnVsbDVpbFZUU3hpeGVROS9MM0Y1TUkyUnJGTEM0ZitONGI5TmxzeTlE?=
 =?utf-8?B?VzhPVEJiaHB3SWg3aVVMcUxSUGxRbG9vNExHYWJIL29JekdlY3pnOWZzdm85?=
 =?utf-8?B?NlR5bDViajFHRDQxbGtuNXZMSDdUb3BtRWx1Zk0xOHNWMWNFeHhhb0ZPRDNW?=
 =?utf-8?B?QTA3THBhNUNteHRmVmNlY0JVemRnNzR4NVZxSVBucjFpcXh0Zk54Q3RnZCto?=
 =?utf-8?B?UDZXTzJwZkJXYi9TeEJVdHdWeHhjTFFKUkpYNmdnNW93RHJYcU1XelFSVDFx?=
 =?utf-8?B?TW5ZR09IR0d2WW1WZFliejhHSW5NR1M0MnRpMThsblpscTVlb2kwaFJtc2JQ?=
 =?utf-8?B?Vnd2WHQrUStiOWJsQ0QwVzdGRWpPVmcxRWk1eE54bmtpamZ4bEdJWFhURFhL?=
 =?utf-8?B?SXBxSFp6bEdVRFZFSWFTTW5JOFFhRnVsSHJOd3NBNVA3SjVJMnIwaUU2M1Ar?=
 =?utf-8?B?NVJ6NzZxb3VLYTFCelBDNFQrbE9odGFzbGJ6WFEwcEhHNGdVWGxyc015bDJT?=
 =?utf-8?B?d1RISnljOUtrQlNMcE1DWllueTlWMStBYWY0NUxueFF6RmIvQkhqdzZ2aVBO?=
 =?utf-8?B?YnFmd2pENUZnNXgxeEwrbGdVbENYNVM2Z3MzNll4d3I3ZHdudWZpOFM3bTlR?=
 =?utf-8?B?d0dtR1ptVGFTcjdCVTkvNnRaeGhNeFZJVURNUjIrS0FVUGpLd2NyVTNubFJi?=
 =?utf-8?B?MGM4OWJSZnEyVUw3MVArUzRZR3dCcUxTVFBFeTRiRENHZ2V1RFNyVUV5Q3Rn?=
 =?utf-8?B?M2xEaVJ6eHdEdXFkVmttQlFaYjNhSm0zTkRLQTdwMVYwQVRTVEtSWTBSRWx6?=
 =?utf-8?B?anV0RmFSRTdnNXhST1RqQ2ZGdnNvVXZ4ZlVNaU5Zb3FUUFJBejBWQys1U0da?=
 =?utf-8?B?RGxkUTBWMElxbS9jQ1hnQ3dDZmNWejU2ODNaVWlqbjc4Z0cvd1ZiZGJ3dCtu?=
 =?utf-8?B?TXBKdUpDcTlLSGxBYk1lNmVQalR3aGpZWW9SNEhJeVlFeXR1ZE1seTQ4K1JV?=
 =?utf-8?B?cGtJUGpOMnlkTXRCRElBaWRKS2hFQzNwUCtJazdXYzg0cXR3eVZUYm9HZk1j?=
 =?utf-8?B?QnZjeUgrMzlVV0lkTE5VZkNZVkx2T0hwWXVZMFpxZHRoQXFYcGNDZS9YQlNI?=
 =?utf-8?B?UWRDRXJDZVdGbFMyNTNBRk9ZOEo3c2M1TXNFNUltRjJVdHBDOUgrNzNvejNh?=
 =?utf-8?B?M2hXMVM4Nit4Yy96eVcvSm5nMWN6NitBMFE3V2VqM09jV3FjMFRCQnd5UEVO?=
 =?utf-8?Q?Vmw6GSMdhAl3gg29OeRYT/0D8tzec9rP0udaQXRL3E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e0cc54-6450-440e-13e7-08d9ed8a30cc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 18:13:23.1461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTvWJEuM5E4b9QjS2qPOeQilzIh/kho7FESz1Gu9yD5XrvtXshcVEvb1KiCV1ZKy8u+Yzo6T+ruvW7tH+KzMcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
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



On 2022-02-11 03:24, Ken Xue wrote:
> KMD reports a warning on holding a lock from drm_syncobj_find_fence,
> when running amdgpu_test case “syncobj timeline test”.
> 
> ctx->lock was designed to prevent concurrent "amdgpu_ctx_wait_prev_fence"
> calls and avoid dead reservation lock from GPU reset. 

Just to help me understand - what do you mean by the dead reservation
lock above ? Can you point me to earlier code version where this did 
take place ?

since no reservation
> lock is held in lates GPU reset any more, 

Same here - can you point me when was it was held before and
not being held now ?

Andrey

ctx->lock can be simply removed
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
