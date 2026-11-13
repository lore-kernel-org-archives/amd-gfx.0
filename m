Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F6606A330
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4XMCg1Uu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB7B11231F;
	Fri, 13 Nov 2026 12:09:05 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8512211231F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 12:08:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMNIvqfxhY2SdJhfKhGeOotaiDi2H21W+Nax0+aD1RuwsxH5v+gBeR9w3p+yy0OficuHJjCnkNmzch9DlQOecIL6eiNEx13kxlucp0Ya80bA100cdX/TDWWIJvsYD7Q0QCJivHpN5BTf5DQAaQsOwb10xW/01EG9Bbe0YZZa54tpBAhgwInBKc+Zg/4jOvBRwWgu+MCLwd3Ggufd8Ff2yglfuIER2CXpq5yMP/ttowUeVRe64/Z6d+ZbArdwgZrjpI5LnZvQmY9oFTbKd4yPQgwWQo8dUnYEkOGZf6/VSdKwO72UMEUurzbt+0ts/XoxETtTCVKoBKrjYHm9E3GIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE1ZXkXnrmAlpjJgCvF+LlBtoPCPH1DNNnTNWTsx0Js=;
 b=Qx+FK/IYs6EQZEFZZkhn+EeY9kQjcV4RdO/YZvpmnOQ8ZTFTdLCaFvbfkD25px1cxUgO81IdsNztqJq+9v7fFWQmmRgy53+pLTu6ONG+KUO+4jr47N4AOihcTvCTMeBMvTDZnU35hfL4cvoSwbL+UNVqBI1n40lvYZAMoasroRMTDaA74d8KrvYYr0NSpEj8yOpm60sxV9SqNqOq+cYUMjeXPTOUfqF5xuyI/SK6iqjTbBy5bapBfhd8KqGpZxX9YtqfF8CK2DgPp4QoZfENWynTpwuWTpXNzXeWxJpmnXT0pl3Pmehw6oqugvBzjPdSqr5hK4xfQRwryna4nvMkmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE1ZXkXnrmAlpjJgCvF+LlBtoPCPH1DNNnTNWTsx0Js=;
 b=4XMCg1UuQOGD+0uen5K3L2Sg7AFGY+yExwdSKDsoKCTrY0yA1hihnLl84lWbnu/BakXHcwt4p/hq5Lw8D5frTgO5NgW0spM0gZkURBryUe9N8lg2haP+Ea0VxzL0yW2vooKzMdyocrmC1ENBrC1GV0ZFFVPm0PWE0XblbDwOB0o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:08:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 12:08:54 +0000
Message-ID: <a1b6a8a0-baf3-42d9-83f7-24892cfe0a3b@amd.com>
Date: Fri, 13 Nov 2026 13:08:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix UserQ fence driver reference race
To: Erhan Bilgili <erhan.bilgili@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20261112211253.82256-1-erhan.bilgili@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261112211253.82256-1-erhan.bilgili@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: dbaa2708-1100-47b1-b794-08df417ee302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|261009223027099003|22082099003|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261026121527099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: MidndoNIZ/3MThzacNgh13QHILXLKLTHTerTj9kavxN18zzfBIH2KjwGET+F2yjKDmGHqfIATo27F/xatx3e6VVZ6nT5tfOEd3CIADywHDAq6VS0X+VnNMMeseWyd9R+wIHWZWZLtaxYGjwiQEjxCZ4xH6Mux0VCE3vPlCTjdGdKxOOJWZKQtjtfbhEE3+S3eqwRLNI+lvqAcVJOjhRmz0QutYyEhFLdVWLyFM1SZxgZwBLu1gH/Mx4RVHhjGbrGlwRxP6rm6nNeHiQvfxpLwcNFzyodfdE91T09oXKhpPLdUWnwVi2XfstcTlnEFFg1M0OWH5jmrwL1VGyfLx1OW7WkzhDL5OSs6/mNBQVNsyIBOgDmd43QkEW86RFkALoeD4uBgra4Z85qYTJQ5bOrzUgbG6OERPxOVyYqxJec7hpCZQZf92ja3ngmPQ16xyzDhPjrP+VSbHXIk8TKnZCpogCKLc6VNQFlKZMsqABKWhdpZbq7BWupdDYt2YaBTRXvxXxIhGP5s/8uLkM7zFPZBRxpO4NVIfR3Szd/ru/vKMNBqpc7WQ2t44ptUD5h5g3XXmCKCz4h9YXvDPoIhuXtl5If4wwk3ytQVqmjvzh3qUfnPQkc2SwLyEq9hvRcsoXCIvll+ZvzhZWTKLT0Ix3r8PvL23YVKmO19cMx9ZDCNPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(261009223027099003)(22082099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261026121527099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmg0c3hnSy80WDdWYXVtaDdwZmJrajlIYkxTZFdqYTk5cUx3K2hHdGhJbVBM?=
 =?utf-8?B?bTZRTGlSNTlQRXJPaVIxQXJwbFcrMHF0UzFBV01vQ2MyZzhYTExhbkVUMFBt?=
 =?utf-8?B?a0NTVC9zNk5jQjBLNnhRbmQ3Qm5KS1loN2VsUEs5M04xRUZ6U0h2a0lkWEIv?=
 =?utf-8?B?a05wY2tZYkNiazBnVkZTUlc0NGQybjg1UFZPMy9QY0dFV0puMkZXS3JORlg2?=
 =?utf-8?B?Znd0dnMveWtjR3NSWEtiVGN3VHQ0S3pZeHB4MTdqbWVVZzRJajN1TlVzR0R4?=
 =?utf-8?B?OUtqZUlBSnozcHRucVVBTThUWUJrL1hYMm5GZFV5T0Znd3M1QnZEUmZVTzdU?=
 =?utf-8?B?dWx4RFc5K0hqN2lYM0Q0QUtyb2NsNzNCbS9XRXBwUzVUdU1SeWFCaGZRcy81?=
 =?utf-8?B?dEhMVFRMbDZWTFZDQ2ltWXpMRFU5WXIwc0hrWEhUdENlaTd2d1drVk1Kb1RM?=
 =?utf-8?B?dzE3OFpFaXlvdkxRT3RzcTE0QnhaTk5wK0NDWitPaGZDM08vQmtKRzR3cjBE?=
 =?utf-8?B?Rjc5SkR6eGxQSGJoaktWVHVPclhVV3YvRVAva0xPNmxuVzRRVFkrU0xnalcv?=
 =?utf-8?B?d3VWLy85U1ZIc0hSZ0l2OElvZ0srcFZCR0dJRW5Sbngwa1ZUY2xXNWU4Q3lU?=
 =?utf-8?B?YVh3bDdrVG5yallLR2dUMW1PekpMcHhhdDgxNkpLVUlsTzBDM2RrUUlVZE1W?=
 =?utf-8?B?TFMwUlhxM2J0L1h0OXZSODBKTlZvYzBzT1J0b2tVcjRZZ3UvZkVGcXJhQnFs?=
 =?utf-8?B?a2YwNnFieUJLNTI3ZDFpTi81aVVGTU9MRkJ5SWlpWTdFa2tvUDRuMVc2N0NN?=
 =?utf-8?B?UVNiV3IrTkJjL2x5RllqK3V1OVJXYnBPVjJrb1JVY0lIbmpURTl3aVA2c1ZS?=
 =?utf-8?B?ZmY1YXNrYWJrc2dHUHo2WEFFOVk1UjNWczRTU2IwNnFhc29RYXpTZkVJL2RV?=
 =?utf-8?B?LzRzdWthdGZjQjFYSXhGd1R1RWVweGdTbTJZYUtIbHdmcjZiM2RSdlBJU2h5?=
 =?utf-8?B?OElsK01IT29NV2d0dG1pRkJoSjFUSm5ZbEZQVUtxQnVLR2EvUFRTVE9KNFl6?=
 =?utf-8?B?d1VjZStKUGY2MnRNd3BZa2kxRWVSSUQ1ZWlLdWlEeUd4cTE3OHlXVndURGR1?=
 =?utf-8?B?OWxVV0Vlb2RDY05KcHBQbDh2ZVIwRE0wK0pOOGVxZ1JsZnZ3N0JSREFoei9W?=
 =?utf-8?B?Q3JyRFdMb3dBcVRJaXpRSk9nUlpMWVA1bXk4UHpkLzlLd0ZyUVc3MnQxY0pi?=
 =?utf-8?B?N1czSnJWRUVEMWNwUXI4dU4vTUFUWm1NZ2Uxa1NuRzlMZmNTQ1pWZVJXWm9x?=
 =?utf-8?B?SWRnL1V5bmdvWWY3bmRwdVlZNm5jSXFaa05jNVF5WXFWc2JJdDlSVG5ja2l5?=
 =?utf-8?B?MjJHTnBuQU45M0llKzJFWHk0YkRSWEtlMitqRUtLVlAxdkwwc3U5TzRMN0Mx?=
 =?utf-8?B?YmJMdjlpa2MxY2ZZajVhQXRlUGh6ZUsySldHRm9velEwQThQRmdhdmlnQy9x?=
 =?utf-8?B?OHUwbjVhN29jSjBLUmg0aXhCdmUxMVM1WUZhR0hzTG9zNzNRZHFIb2dhMGtD?=
 =?utf-8?B?RkRnNW5CMXllcHNpMTZRdFdHOG9QQkJwcDBQUkV0NGV3MXNBWStVem5ZVkRL?=
 =?utf-8?B?MitFNFMxbVBwV1hadjlXWU5qMVFJdVVrMVJ4L0pOay9CYUlyRlpKbXFmU1V6?=
 =?utf-8?B?ZUdvT2F1WFFjNC9kU2tnNzROcytaU3hCYXFxYXpSeDFaeUZQY1ArVy9TUk9L?=
 =?utf-8?B?TFNNYlEyWlpXYjNCdXgzNXN6bytod3BBSlJiTGRraTN3dGNrTXZSdVlzMVdH?=
 =?utf-8?B?NDlEWDVzd3R1SjdEbFFReHJiRWx5TmdsZlYrSHRmWVdTQ2F2bWM1aktJV1Jq?=
 =?utf-8?B?ODNSU2Fpdm9veDBwUUNRbmlxSzVoSzU1OHUxVTV1Z3JmZHQxUndmWkFuOWd1?=
 =?utf-8?B?cHhIOGE3eFRRTjVDaHJ0Q1dRcEJvKzVodUg4Nkhrcy9yZWN6L2pMU2E4QUl3?=
 =?utf-8?B?d0RHN2Yzamh3SUY3aTQwWDYxMmU0NEdUb2NDUXNWZXhTang2blBjdWRReGZ0?=
 =?utf-8?B?Q0REYUZwUGVWbm54YnJDTUZqa09jTHErSWlST2Q3Y1YrQkdWR01xdGxHWmJ0?=
 =?utf-8?B?T2krbU5iMm1OK3pjaXlYcTl2M3E3WWdLdTNuVEpueVVPMjhrb3FVbkJpK3Zn?=
 =?utf-8?B?djRZbVpPK1RIekVVb1B5ckdsak42dVk2bXpweXpCMmZDbzlkdnR0R2gzbW9o?=
 =?utf-8?B?WjQzbWs5bFcrR3JnMlQ1Q0dNRVVva2wyWUZIaFlyK3VTVi9rUVR5NkdZa09N?=
 =?utf-8?Q?jkuThHwU8GXEra/seK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaa2708-1100-47b1-b794-08df417ee302
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:08:54.1876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gd0xUKi1YiN6eltUUFha6CUSQL+34fvH/UrHROsPGTInuzUHnag6YvYaNI3JbWK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
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

On 11/12/26 22:12, Erhan Bilgili wrote:
> USERQ_WAIT adds the driver to fence_drv_xa before taking its
> reference. Once the lock is dropped, USERQ_SIGNAL can remove the
> entry and put the driver before WAIT gets its reference. This can
> free the driver while WAIT is still using it.

The fence is holding the reference to the fence driver so that is completely unnecessary.

> 
> Take the reference before dropping fence_drv_lock.
> 

That just unnecessarily complicates the code.

It could be that we change the userq fence so that it doesn't hold the fence driver reference in the future, but that would require a completely different approach here. 

Regards,
Christian.

> Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
> Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index dd976a50e053..13a339918ee3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -912,12 +912,12 @@ amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *fil
>  		mutex_lock(&waitq->fence_drv_lock);
>  		r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>  			     xa_limit_32b, GFP_KERNEL);
> +		if (!r)
> +			amdgpu_userq_fence_driver_get(fence_drv);
>  		mutex_unlock(&waitq->fence_drv_lock);
>  		if (r)
>  			goto put_waitq;
>  
> -		amdgpu_userq_fence_driver_get(fence_drv);
> -
>  		trace_amdgpu_userq_wait_deps(dev->dev, waitq, userq_fence);
>  
>  		/* Store drm syncobj's gpu va address and value */

