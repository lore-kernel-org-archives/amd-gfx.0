Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E9606A337
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lE4HwogU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C96110FFFE;
	Fri, 13 Nov 2026 12:00:47 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C83410FFFE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 12:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdFxv9bCV9KnCP+vvLRxavwCkEhAxGF/Tb4G+qfxLjzZWl/rpmjKAaogRqfqUp1o6ycZzUF0R8etMWdnvqm/cQRJ4PWNuZ51019At0htcLUnO7rxiSZJv2p4pC4fF4fAyIDNc1BptXHmVgo31U9hei33b0R69Y3JIf1BU9X/twlXutbb7SIrWA91IAUAOKgMpP0PlNcrbCsZ5YccWVFMh4GshvSSwlmh7unltyV2UzrJoGZ9RnsIStPx8cJN1CCjoUND6WZV63LnWvUCCWqRRhC1bL2FJDia+w9V4KbxFxOFmORGISnLdujxtWzejbFAJteKBly5rSaHLMih6zT32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJzRmqFeDkISwZg1s2J5i89LgFLH4ASYAPEoH9SYwfE=;
 b=amPO9NM3avYEraeMEb08csWTHGuPrWtoKPH286NrVmfneDfGlNpAxwu1MENYUvActr77L9EsxgtKtDEkXYY7qtuCDqiK0q/NWF60sn/qt1TMiXfZaDOU8Ej6zQM0GJaUPrGAoDPzG4aDU42mfPfx1NvQbFa4gNzNKrltNuzUtpBfkiNuBbjgl0NhWmnHJlaDSzHkODfa2AXOVIJLnHS4VXhmKfhVgehrrF5vSeHEgNSAF+iRT4HxxNuAbKdUqxBYQdYyjOBl8TO72grNteUWnExuEULMrGLR8oUqvqKGCjtzJTqSWFb+Bn1ajGJiYuZG+BWevnh0qePWb05T3hvZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJzRmqFeDkISwZg1s2J5i89LgFLH4ASYAPEoH9SYwfE=;
 b=lE4HwogUs9scuUO3k8FC/eZhr+wbaWSdnxaATrpr8tBnYeH7H5thRvtmWGYepLpD3EuX+hFVV1IWp7BuTzS6M5Js14bnXSPRaTtyTzXbBVcugPePxLUYLZ1B1NdbY4PJQqgmBbjenQRhjN6mfAHVSqElcd56cafG1qW0n8q5R6U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 12:00:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 12:00:37 +0000
Message-ID: <f99b863b-9ad1-4fba-b6e0-b838849d5b1b@amd.com>
Date: Fri, 13 Nov 2026 13:00:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu/uvd: stop using amdgpu_bo_fence
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <20261112164408.1748006-1-benjamin.cheng@amd.com>
 <20261112164408.1748006-3-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261112164408.1748006-3-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 294500ea-2683-48c1-57fa-08df417dbac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261028144727099003|261026140227099003|261021123027099003|261009223027099003|261021121427099003|261022105027099003|261102123227099003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Pich/IcoL89vPO+21+09fW0v5C7rpb5n/DmHJ5CkIC2FiuoLXV302xrMcUMQpAcWmhuDEDwaJLLKd8am36ckNLqQ6rXXzjXZTtOy6ymQuAKPcHsetwBxUpLhITK0Gu1LF3bOWqIOx+3XFf+QOtiQLl9bvVRy6YKk2eGt6z8cuaNBcuT7OVvmt1k5CyRcW22uuy0ARjy36wX0D/sp810Mbmws1cAzXGWdKnf1uOPGf+3bJChWEOjrQG1zL87MHIMipLznTrCAB86w7GlAdRGgUF4xeVmD74WWTEe4tcZpyKwzWwTKU0hoRJq8rWcfN/LUQvUmtRdhlSf84XkVV5cGvDZzJq+suQNL4e8LTWreDj7gqt9gmQj1uH8efbN1ZLmFRasl8a5M3vq9NRxcu09InNNoV2gA9jkS+82CcyyT2jmC1h4zNE5avJEFEEqo8HdiCn8G9UxvNhzU1YSoMKMHwus7mTbwmgLIuJ+SC2vFDhxoRkbGtRPKnKDW42uybJclqAU0h9UXYaDr1ffRmGcpE4CS4NR+y+SESltKmuliYdM7g8JRKsknSioHa1lkuHNFYwKQYIMLn7PQC1FpRoX0kCWB8CKfMsC3KFNqpDkuBTlOON4+jxH4sfgmI6MSeb/HYgYN5GdlrTJE53yt+5YV3AX9U1Q5BopSTSxgSKmikss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261028144727099003)(261026140227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261022105027099003)(261102123227099003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1lZNjhXdnlrMmVmdlpmWUlZbzluUTVMbmZ1STdMYVJuOTYrMENEMU5kQnZQ?=
 =?utf-8?B?TGVmZFd0Vm9uSWlmR3VURXA4WlMzZWp5dTVmWCtpR01TSTBYbWJ2V01OOEpl?=
 =?utf-8?B?czRNVkJZSld2UXJqUjNHSUVyWDVjdEhXSmh0TXNKS1A1cjBRcFg3WnVYM0Rx?=
 =?utf-8?B?Mm00TEl4THp4V3NpekYvdERCSnhPOEF1OE0rN1JlRkZuenc3cU50YUJWWjFs?=
 =?utf-8?B?TnY0OUU2OEcwUFZxYVZOSnRnWUZiY1hGalU4MGtFcGR2cDFQWkNqQjg2bDk1?=
 =?utf-8?B?VHpWQ2dFZGgvNVVwZXZYdDErRHEyVkZWS3ZWSnErNDVKUENhcWw1OXc0UUhu?=
 =?utf-8?B?SEtVQlMyeDhzL2FpUUJxQzczSGJOeVhKOXJ1QWFJWGJrUXpvWmxpK2ZqR2xm?=
 =?utf-8?B?QmFmWlEyUUJTakxYRll4SHUwdlltTFEzQW1mWmlqRkQycE5mUk5rM1NOckhJ?=
 =?utf-8?B?NUlyNEZnUkVlUTBJeTJ6bjh0SGRFRzZNSDRCb2t2eXd2T3NvRFhaMWtObHRO?=
 =?utf-8?B?NDJTc3VWVjhKLzJYVk5LZkROT1BhVytDNjlLbTIxNms1QVhYa0FnNlNKRVhL?=
 =?utf-8?B?cnBObVhQR3ljeGRmaTFGSXY2VlNLQXpyZ2E0cnBKYnZYT1NrZWw3K1M1L2E3?=
 =?utf-8?B?eEN2UjdvampXT3hhbkVNMkZST0V2aERGbWZDM3RPaU40cTFrc2FFM09MdDlC?=
 =?utf-8?B?TGZnbWZjQXUvUUUwQnpRb2dkZ2hNeTBLelNmY25WeVhXZmpENEZPT1VJcjRM?=
 =?utf-8?B?K1k5Z2Y5VTRrbyt1aEViWkpyWGhVYmlyV1kyVFc1VTN5WjFSWXR1QXQvOXA0?=
 =?utf-8?B?d2E1QmJjSGNpRUsrbE9ONnFsZFZIUzNwYUVUU3dFTWc0VDN1K0h5TUpCOXJh?=
 =?utf-8?B?N0IvT2JaVlFPbXZ5elQ0U3BSZWdoWE9XN0RsNGl6dXZXa2tqSlkxVDhRRit1?=
 =?utf-8?B?L0NpbndtenU0MmZLK044ZGU1Y240cmluZ2Zua1pkY2Z0VXVwTjdhMnRabVlU?=
 =?utf-8?B?QklmYUhjeSsreG5SRlRyS2YrcGtHWUdYYmJCUEtjN2pVQ3Z3SjVVQzBUREVJ?=
 =?utf-8?B?dGdFNGVtZjhtcllxUFd0ZHRHU3c2RGRWclFsZ1JpOVlxWThtc1grMmZiSjJB?=
 =?utf-8?B?dnVlellCR21VT3hwVmoxZXRWL2t0c2wvMjhLeDg4NWQrVzdLSG56N1FKUkhU?=
 =?utf-8?B?V1FKejhDa3JPZnNSQjBQTHYwMzFmZVZJNW1kdWN4cGNIMHhDT1MyY21OYm1t?=
 =?utf-8?B?RXpQNTlUUUxzMGtHeDB4dkdsSVlmRDlHSlFpTFBRYm4yRG1CZ2x5clZBdEQv?=
 =?utf-8?B?TkNuazlWNXJwMytaa0RodVNpOFYwRFRqdWt4MHhOTXhaTFh5MmRxcTNyeURC?=
 =?utf-8?B?dHoya3NabFZ1WjNrWi9NQnR4ZG9Dckw1UFgxZTB0NlIxK2RsMFByeG5QS2w5?=
 =?utf-8?B?OW5ZSkVPNVlaUEx3WWFEZ0YvUEdzT2dsTHFXazZQc1BUWmloMjQxUnVGRHc4?=
 =?utf-8?B?TFhPZ1dLTWJBUUVyOW90SzFSNFh4WkJRUmNtMzAxYzJRWnd4RTl1TnRWaXlu?=
 =?utf-8?B?RzNXYitWVFR0NERpQUc4ZkRWQnk0Z3Fjam9lc0hNSkY1NCtzVlBjcmhLOHVp?=
 =?utf-8?B?L29pakEyeXVzQWoxMDJRRStoVG92a09TeUdUbno3VHA5MEV5TXNwUWo2NXlD?=
 =?utf-8?B?MElHZkdIVmw1SnRtZ2VVWkpvTEhHVnpRK21OOTl5cjJLUTVZMnl1WHJUVTJk?=
 =?utf-8?B?alZGZ05JUG9TT3pNSXVjZnlMb21IbitIcDdWT2VqRUpJUDN1c09PYXlZZXRv?=
 =?utf-8?B?YjVnQmtmb1hZaGNKK2lUbmNScnlMNTRBTk9odSt2VTgyOXcvUW1HQUIxM3Ux?=
 =?utf-8?B?SEo5Yi9xRUMxSzhBUjRsam5xS28yeEFqNHVUOE5waFZDUUkwQlRGV29Vc2xv?=
 =?utf-8?B?MnNlYjZObTY3L1pvWlVta2hrY2U3REJGR2VTRDVwc20zSDloVytWN0gySnRZ?=
 =?utf-8?B?NEtHS3FlWnJSVW45dk40bHRCUXZISlZvMExqbHcxVm9xZ0FsZWo0UFJzMkdI?=
 =?utf-8?B?SzNSZlIzVDI4aXh5SitrWFBabksxdTA3bmJFUmhvdmRXQXJtM2FjcU90ekJs?=
 =?utf-8?B?dGhKTWRScWp0eXpPdG1GM3VSYmFKOFJ1K25IK1VvTFV3a2RtOGZXclMzY2t0?=
 =?utf-8?B?Zi9OMTZBN0RrYXVKMVNoRHFSTVg1cllhNTlQMU5DbkhaZFR0WTZ5OTk2cDhk?=
 =?utf-8?B?S05lN0NrWStVR2RmQUU2L2x3blJ2VnIzdGJpUmcxU2NuMDJoY1hsZVBMZlZt?=
 =?utf-8?Q?rU/+3uvVSnEY578M8N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294500ea-2683-48c1-57fa-08df417dbac4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:00:37.1962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bag3A55VJ46kVQLAxDs4/MSxXpqHdXVQE+E5It5oSXJ2/ww5nMJMmoBlhNYcO/gK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
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

On 11/12/26 17:44, Benjamin Cheng wrote:
> This helper is deprecated since it is incorrect in most circumstances.
> This was a circumstance where it is correct but it is the only remaining
> usage, so get rid of it here to remove it.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index d88dde859615..9570db033b18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1154,16 +1154,24 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>  		if (r)
>  			goto err_free;
>  	} else {
> +		r = amdgpu_bo_reserve(bo, true);
> +		if (r)
> +			goto err_free;
> +
>  		r = drm_sched_job_add_resv_dependencies(&job->base,
>  							bo->tbo.base.resv,
>  							DMA_RESV_USAGE_KERNEL);
>  		if (r)
> -			goto err_free;
> +			goto err_unreserve;
>  
>  		f = amdgpu_job_submit(job);
>  
> -		amdgpu_bo_reserve(bo, true);
> -		amdgpu_bo_fence(bo, f, false);
> +		r = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
> +		if (r) {
> +			dma_fence_wait(f, false);
> +			r = 0;
> +		} else
> +			dma_resv_add_fence(bo->tbo.base.resv, f, DMA_RESV_USAGE_BOOKKEEP);
>  		amdgpu_bo_unreserve(bo);
>  	}
>  
> @@ -1173,6 +1181,9 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>  
>  	return 0;
>  
> +err_unreserve:
> +	amdgpu_bo_unreserve(bo);
> +
>  err_free:
>  	amdgpu_job_free(job);
>  	return r;

