Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F8606A331
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fjaJKZNz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D3310E527;
	Tue, 17 Nov 2026 09:38:05 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1462710E527
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 09:37:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9atScS8BYnQzOC4LkE6kuSf4wfgW/Mwc7s6UTAKzpk1E9no8w9eOe8YAStwmGAak0xw3XbqWftBi7ANDzK1sUgJ2jBkhf9mdTziTpFeHLjDhB9M9wozSEDnjqBb4f3qoyL4LdXlgeYLhPYL4Y5bRgRj35jPRueXGpu+ep+1CX6pVMlwVx+Qempibe5VLcgu4AyCKXk+karr4P1t+G2pWFsFTc7um4jKgyyzvXNcCKMncaTnJlu/i9bXaUbtI3Sw8W8C39sLqxwHdjjSwi+V1RZ1NWjD+HmfScziOUrBH1khxp47FDCuD8Vb3wDWnI8ZgMqLGZSz+91IoXmxaKzuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhMVtFq2jEqAJK9DVnYnrzbcL1qa+CZxvKbyyokjIr4=;
 b=mdsVGtd1PQyiclqe7+DaaoTEdkEXotSfXmOO6o0WCTjiN07VE5Sfs3WwrB8kqbSREKIm9pifxeF+hb2oQh5NW5ZV88+APOVHabF2weiDo83bYpT3OFPUAGbkuctqOogXEWUn4l10VI4CzdY0c8GtBi3w9A7DKnEQGkkGJy65XkoDbWWe9d7t+fwiSLc13CK7TNKZ2Y1hqEStgESs0pZFZlK4VemJCXmN6Mo+BwYwaj9KT4cLzndFBNWIGejZqrEFFRndXHYWtY8adEqQiThLHSVvhChMoQRdA3YmaYaVUiAmp1XMzeImfiR8nLYzZrd5HcW5SfRLBwlpubFnJi5U/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhMVtFq2jEqAJK9DVnYnrzbcL1qa+CZxvKbyyokjIr4=;
 b=fjaJKZNzvOfY1WdV68GGPazdniogXT7x4RfSeFWmab5Rglt7iT0aGOSeKvv5p+3HsupMZ5rkW3xjNNsAJimpfv/5dq84yeO5VOT9ZxqAwZtR7Tgt8bjr8wFrgGDLsWRCsslAM6vzjhEKYrC0IgfXgoaNayxnM3XJcSw6odZPJ6Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 09:37:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 09:37:10 +0000
Message-ID: <5e22b2e1-2379-4583-968f-78217ce5525f@amd.com>
Date: Tue, 17 Nov 2026 10:37:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Logatharshan Thothiralingam <Logatharshan.Thothiralingam@amd.com>
References: <20261116-superm1-drain-submissions-v1-1-e3ffee977a28@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261116-superm1-drain-submissions-v1-1-e3ffee977a28@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0247.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b83131f-f541-4f4e-9d47-08df448e59eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|11063799006|5023799004|56012099006|10067099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022075727099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: El6/BaAaRKWZuELoGeCFhpZiL4S5JC8B6QViNgvgVRNJiU/3/tx8StAKywh1isrm+a3hu/4FGt78GFH2KN/0+j55TWVGk0MCYV31eRnwQBWWrQjaXR/LrYjb7Jvfy8jk8SrU/Dpmx1ObT46dJVTFiB+Eq1hduG6TK4MhgfBgb74cEFaHKUn2ch004h5GlJ0QqyraMjjICGueUcBDDY8v+XVB6Ox6zoEczJGCVyLq5JMwMDar6OJB4DYUjryGk7S/fdES7aO8etpskYl67feelcprZY1YtSkAKrlgKUN77iKqf/Gs77EHVQw2sRV0ZGFOiQZuxRfymu+/XVDrtFFRGd/3nHObXGwl714RCrkEdJJE4r9shVnGq+WtTfRMJz9IRxnwOcEpxVw6j7Gq7xhGGVlEr4YTNOyMydrvsJnkVg/ym8zk8EYCp6Sz6XOMVtNVQik0JwvyljSWgr9WKrm3pRIdHtu4pW8kkq3Nd13qHWU+K1h3ge9kc8hU8XQpP7AsatuYG7YYiknbkAmfNSYa5PMV+mqLFED4tQXwQVzp5/dFMoLigc1oNLe1rfAHGP8wIIELBjgroQgyYTBxZRY9TuWtN2eE74GzPeiSuD9ySCswwgPdFfWEwEory6gC4lQ9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(5023799004)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2Jlek1pdDA3SzhXb2E2OExCdWVrOVlIUmZ3VGtHL3Q1S2d2Q3YrcDFhUEFV?=
 =?utf-8?B?bHlaUzJhOXdOZkFZdEl6ZVhVTDNVNWJKQUw1ZDNKNFVjckM0d0xaSzAwZEZP?=
 =?utf-8?B?RGNtN0JHWTM0RjBqVEhrUXNhejVuSGRYN1AvM0tEV0VYZzdUWjdTNk1qUHlH?=
 =?utf-8?B?RTR3NHhqVElzUExqSHNtZUd1N3RCU3F6NG45M2ZPbmkxRksrK1ppdHY1THJs?=
 =?utf-8?B?R1hIVjZIRjJpVU0zcGlSYWs1c2xBQnZsbHhVdTcyRnRHWWt0eU5sRk9UL2Vn?=
 =?utf-8?B?Qm9iOUJFNSs1ZzFsdms5UWkwRFFYSE45RUV3RmNOQjNLR0lXVG1McDRmZUFJ?=
 =?utf-8?B?T3FadkdKZTEzTmtpU05pZmY2eDc0bzExd0E2NzRYcXREdVdDWGdBWURDcVZY?=
 =?utf-8?B?SmFIMG9jMnczY0VWWmFHczc0Q0ZFYjlOeGJhT0lBZzFjUmFtMXg1dzAxWWJP?=
 =?utf-8?B?QkxwaGV1S2FjY21XdmlSeThyT1hMVTZwTjBzcDRzUzQzeXpDdnFkckRyTHBm?=
 =?utf-8?B?NlFzOHNCME0yMVh2aU5pZHoxYjJOajY5ckcrb1Z4RlZMK3NIcy9weFhxaXhC?=
 =?utf-8?B?UXdCZXF5MXRta1NFeE5uSzhsWDhBZlZ5V0Yzazd4a3VaaWpEUkNvV2hCcHhX?=
 =?utf-8?B?d1lhWERSQTJWUi91SnUyNmZvOVZaLzBCandtbzVGUGVHRHJpc002anZLMUIx?=
 =?utf-8?B?WVcxYjAzcmRqb2Z6Tmx3MFpsMDFHcHRQWG9pRm14YUY2M3BQZmdXZ3ZzazI4?=
 =?utf-8?B?Vktqck9lNkY4SDgzR0VMZDV0WSsvbHVLMVdqVkI5Q3crSXJzaDYyd1huVjRG?=
 =?utf-8?B?RmpSRExZdi9nTE1hbFd6NkpOc0VSVHVtdjdjWXo1Y3JmamhIa2RxbHlEMncv?=
 =?utf-8?B?MEQ0YzFUd3FTWFlyUytBbWt2MzZ1TUFhRE9DWkF2OFFEVnk3c3ZwYjlnQlZN?=
 =?utf-8?B?bkdoZjg3cGhIUzZ2UFppeE1oT00xUjk5K2VlYnVKSkR1S2ZMZEFwMW5wb28z?=
 =?utf-8?B?eVNFdVVZc0RKYkVhUzJEOW1GcTlJSG53Y2dzOW5ReTNINVI4d1N1RUpva2tm?=
 =?utf-8?B?VC9LaGtOVWozdzBSRU9OM3pjMVc2RGZDOHRweEEvR0UzK0RSNDBLRm9ZOUh1?=
 =?utf-8?B?aXdSYWtBZWlsWjRTQXFmYmZ5WloyTXRVLzZrL0xvYVZQSWNiRURwV0ZlTTVG?=
 =?utf-8?B?UlhLd3ZMN3hLakl6c0hONlhNLy9ZZmtDdzZjYU9JK0Z1bllwa2gxdnN4aWhl?=
 =?utf-8?B?QzBtUEZucmduSm1vZU1ycXNJRWQxRXp1UUl2akxFTFRZMVE0SUJYeWdMV09K?=
 =?utf-8?B?QmFpOHZ5dHN1S2UxSzlwYStZR0FDZUUxQXJjcG94L3BORzdtZ1FydmZTM0xw?=
 =?utf-8?B?clJRZ0xvOFdWWWpLTi9ZbVozSXdVUWdORzA1UG5yWFFUL3J5Y0hBREFMTW9Y?=
 =?utf-8?B?cTZ5K0czSVdqZms5U0ZVQUFQTGpseXFaYkJFWjU1dThTTkpSKzN3QWhXMzk3?=
 =?utf-8?B?NlpnTE90SXExNU1PZXlGWTAvbUlkY0d5bS9jZ1N0Qk5iUEVWdzdJVHZMSkZ2?=
 =?utf-8?B?dmQ0ZzJZaWs0UUpXQ1FXTGszUU5OcDNnVTJ0dXcxS004ZVhjT0d4TGtuc0xz?=
 =?utf-8?B?ZnN1aWYyL2s3QzBLNEpDR1htSHczRER6aDg0MTd4MHVjUE0vdjhrQTcxbjBo?=
 =?utf-8?B?RUZaVUFqWjFxOURrVExVRFUwK1dQV01tVXlHKytQQmZCUmF0OGtqUkpNdW9x?=
 =?utf-8?B?ZXMwWklBUEs1K3BjWER2ZmFlb01DSVdkN3hDWVhYa0JDMzBPaHlrNWU3UE1T?=
 =?utf-8?B?dmZtYWRhamRVeFVxQXpzZFhXSWkvQm02VHp5c3EveW5qSDZaaUo3SG8vMnI5?=
 =?utf-8?B?ZTd0b0hFbkNMY1BXSmFEd1o3aFA0dGI3OEZHV01rRFBVbDQ4QWErRGY1VW02?=
 =?utf-8?B?TVJDN1lkSnUvZFFTRDZyOXZaQmFiSHI1Sm9OcnlMcGpZZi81MVJwT3pDNFV3?=
 =?utf-8?B?T1lpYXJ2am51bjlISE9OT2R2UVhmNW1kdXl2UUlFNlB5SC9lRjhqRWgyRE1H?=
 =?utf-8?B?R1NId3A3dCtqbjJCY1NNcEZuUUZvVWJWc3NTdFp5dUZqTXRDVHBvM2lwR0R1?=
 =?utf-8?B?MmlqMndDWGMvQUc4Zkp5RjZNL1B4OWxtaEVPUlJlS3N2YUxWTVJuWUlncG5L?=
 =?utf-8?B?Y2UyVGxZQzZ4VEkrVkl5WW5BcndxWnl0dW1oWmthNzR1WlI0dUF1K0pjdWhR?=
 =?utf-8?B?YjlzU29PanlsYkk3Q01IN1pmZEt1djE3eEJGWkFudzhNYVd6N2tnQmI5SDNx?=
 =?utf-8?Q?MXBBcYk0qxs9G+YuJS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b83131f-f541-4f4e-9d47-08df448e59eb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 09:37:09.9110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjzkwTgsmeBxeqcaTU5qsmphQG4HdKH0VB/EXscx+QkIteIv+LSF4XzYaOXE4r18
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 21:40, Mario Limonciello wrote:
> At suspend, amdgpu_fence_driver_hw_fini() only waits for the last fence
> emitted to each ring. Jobs still queued in a scheduler entity have not
> reached run_job() yet and so have no hardware fence. Userspace is frozen
> at this point, but such jobs can become runnable later, for example once
> a dependency signals, and the scheduler then pushes them into the ring
> after the hardware wait has finished and before the IP blocks are torn
> down. On resume the ring write pointer is reset, those jobs never
> signal and the GFX ring times out and hangs.
> 
> This was observed as a rare (about 2 in 400 cycles) GFX hang on S3 resume
> on Picasso.
> 
> Flush the context and VM scheduler entities of every open file
> before evicting resources, mirroring what amdgpu_flush() does on file
> close. Like for any other dma_fence there is no timeout, the wait is
> not bounded.
> 
> Reported-by: Logatharshan Thothiralingam <Logatharshan.Thothiralingam@amd.com>
> Closes: https://lore.kernel.org/amd-gfx/SA1SPRMB0073292C113C6B98D9282092F87F2@SA1SPRMB0073.namprd12.prod.outlook.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 19a566187dfb5..d18348116d3f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4538,6 +4538,30 @@ void amdgpu_device_complete(struct drm_device *dev)
>  	}
>  }
>  
> +/**
> + * amdgpu_device_flush_file_entities - drain scheduler entities of open files
> + * @adev: amdgpu device object
> + *
> + * Wait for the scheduler entities owned by all open files (the context
> + * entities used for command submission and the VM entities used for page
> + * table updates) to run out of queued jobs, so that nothing can slip into
> + * the rings after the hardware fences were waited on at suspend time.
> + */
> +static void amdgpu_device_flush_file_entities(struct amdgpu_device *adev)
> +{
> +	struct drm_device *ddev = adev_to_drm(adev);
> +	struct drm_file *file;
> +
> +	guard(mutex)(&ddev->filelist_mutex);
> +	list_for_each_entry(file, &ddev->filelist, lhead) {
> +		struct amdgpu_fpriv *fpriv = file->driver_priv;
> +
> +		amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr,
> +					    MAX_SCHEDULE_TIMEOUT);

That is actually superfluous and even a little bit dangerous.

amdgpu_ctx_mgr_entity_flush() is only supposed to be called from the process which has the file descriptor open and is closing it.

We use that to detect if that process using the file descriptor was killed and we should discard queued up work instead of waiting for it to finish executing.

> +		amdgpu_vm_wait_idle(&fpriv->vm, MAX_SCHEDULE_TIMEOUT);

That here should be enough to wait for all work to complete.

Regards,
Christian.

> +	}
> +}
> +
>  /**
>   * amdgpu_device_suspend - initiate device suspend
>   *
> @@ -4587,6 +4611,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	if (r)
>  		goto unwind_ip_phase1;
>  
> +	amdgpu_device_flush_file_entities(adev);
> +
>  	r = amdgpu_device_evict_resources(adev);
>  	if (r)
>  		goto unwind_userq;
> 
> ---
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> change-id: 20261116-superm1-drain-submissions-17d4414ab3b9
> 
> Best regards,
> --  
> Mario Limonciello <mario.limonciello@amd.com>
> 

