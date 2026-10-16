Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A01CCC6B38
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 02:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B24A110E20B;
	Fri, 16 Oct 2026 02:59:07 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013070.outbound.protection.outlook.com
 [40.107.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F3210E20B
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 02:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9H6PPErRe/AkLaDd3lF8eP8mAY0qrq02dVHpnBV+B/khx82tmN+AcCtbwmoh/y2F1pKTfjTgTuAOA8rd7nGcIGImVy5KeMcQh7hYMCnGTV97L/uiE7XD+lePEQgcaThRpDjP0rFBECnQ4hXv+1SNz2SApWc+Y4lS9hw6YtWt6TrGfaAnYV8LmQkgdy60YkvVbnhaEhX+NKFaP0OgCaoJhXG29rwbMJKRvgOtm9qyKRFJ80MBUcblLCUTkB7hGbuIbpTPWTmMGsn6zd5X3pvKtlubyuLvj/0AWWozITvfax4tukNE7jdY7d2/PbkNHjPT23qJeykNebjrhzLWCFpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwlyW7zaqEbL30Mya/JzhTsNZO6mAcWs2vR1FbmIZsM=;
 b=K+5vDka5aj+qe7K4CzCQC3O9aGEZD28LQvYQGViApE1gZrKlAEA7rcxjhl/Dk7C8UBU3hsZpjtWq66kxXFp72DU9EA6z4BwPOV+fpJyY9SmunfdXuSOGLBGYxkVb7S75qtineSgQ5VeV1Fn4TKoS1XzIvLgwLdIeBrk0ls1TsbpEV25/mi+k4PCwuPgWlNWe4iYZDTutg0L+lm9MaowluX3A/yaW7YoKiqKBsk+5yW7iyuHGAw4TtfUsfFuqsDZpjjfl/7JM28H8m/azd5NRQcZ4OvCDprBjx8nI8nT1i+iFWD3+ZB4Tjj0zYE1QGzrJEiiQk8qwbH7ECA1HexDfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwlyW7zaqEbL30Mya/JzhTsNZO6mAcWs2vR1FbmIZsM=;
 b=fX/LAqyIv/3jxf0+TPSirM1IYJutYpWpMTAYgX/xvuz4yN5e9cOzWg/S3X81Ipvg1VX3JKMnvMRatvp63o8HToamRKj3mEwN9H1lf16l3x0CO0rPCTt3pZQ0zLv/uwd58QJdgm2yXjxunmnxxIZ0d7zmpVJxAPxwT+NQRWdQBfg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by IA0PPF44635DB8D.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Fri, 16 Oct
 2026 02:58:56 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 02:58:56 +0000
Message-ID: <99bfd8d4-8839-44f4-996e-8f903af60abf@amd.com>
Date: Fri, 16 Oct 2026 08:28:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu/userq: commit seq64 BO mapping at queue
 creation
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261015174444.948651-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20261015174444.948651-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::13) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|IA0PPF44635DB8D:EE_
X-MS-Office365-Filtering-Correlation-Id: 444ca809-e767-4b67-a295-08df2b316b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /V0gMXY28WYrzmr4mTJrrz7Ht9CKgtTY6BkzN/plYmlY095gQ4mqSQnWZGJPZMMRzASLZvulVXPE71FZWH8HCxuPnCFkBomI9xwx1Zqrnf+69vpAtvus7zs6WRK11GGa4NIPGLDJqe+VzVM+8p7mN3dV2zKiN3tDhhi45KZGwEAFfs/X3u5B05dnnoECYwg+pwXq6mSp82VLngX5ByBzIFUngqxh5XJUD0QGOc5Do0mNv9LYPz35s9qHDj+gHLmZQH0qOzBzoJn3BMGe5Lo3lb2Et2RoGvFKLAuKNow8Ej/v2IDeKThpOW4oV45Nq7N5a8eEV8iynD+e9Bp/X2fydMJoncaJkLwO2EMZ/o7To//4yh1CwULXjqsiy+uH2Hz7SOqtHttaAIaC4vNlp+deSz2kOJBlVmFD+R6Y2/bSP7J8dFiN6FwH1mQE7nX74HP78ZaTQvMqANSdLgv8iQccozLPq2icdrWk8BkDYapW06CM7VbjOkeSoi/uiLhd5YIqOwmIW7ojAxxygz/gUGewTtKF2oqGzl9MRayNgthbH4FFEetpXtfC42QXViT4eko4ARHZX+XSveQlwdXwJa0QwgLTsYibfnh4BmK7aEN8+t2gFEUsQM7+1bGMGQbqkJJpHgP73OLEESDd75GHAWYKUc0JOMUcSmNEJRhG1YnHeoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sll1c3JnUk5yTUd1TTZWQWNjUWJML051WGQrQXVLSnM3OFRwaEJhWXFOUFVO?=
 =?utf-8?B?ak9NcDhqYnE1ZUdiNGZnVkdaeFRySFlYZjBPQ1JEazJPZEJDTlA3SGdycTF0?=
 =?utf-8?B?a3JDOEw0dzQvK0s5OTVsZXRLZDlINGg3M1h2Q3pacmJ1WEZqK0k5aW0rdDR5?=
 =?utf-8?B?VzgyVXFrdkp6VkRVLzBZTzVJZ2h4Nys1SFhITzZGR2p0SEVpR3hhRmk1cFQ1?=
 =?utf-8?B?NERxNkNuT1lqSmwzKzY4SFZqUmYrcmQ3VHZ4Zk5GWjNiVlJNTUhHUzNZaE01?=
 =?utf-8?B?OCsweStMOWdzWlpmRUtlNHBVajN0b0srNENvUWJzM3BPYnFRamQwU1I2d2E0?=
 =?utf-8?B?cGVET2VRclNIV2Q4SVMrM2pMSnIxQmptZ2FBaUJlbkZ3VVV3REtkVUVCRnYv?=
 =?utf-8?B?RnpVVllEWXFFcnUyZGVkYy92NGpKZVhRblptTklFaUlpZmFTZU1OZ1BKZGox?=
 =?utf-8?B?UnkvUUNiZ0swRUZoK2FtSFVrSGo5STlOZkFpSTBVR2FuVThsU1dwVVdmWDVD?=
 =?utf-8?B?UTNpdlEreHFhbzRqSEUzRXh2SDV2ZFhacklEaU1Jc2J0NjZiRDJ3YlkxZXZC?=
 =?utf-8?B?S2MzTnV3OWtqLzYxaU90R0FMbCtzY25xZkpJWGErN1Rmd1djRWFjZWJWdGQz?=
 =?utf-8?B?K2ZzMUxBbDkvUDdQZGhRaENSOGo1ZU4zckdjU0lsTStkUWVUU2hNaTl0WHM4?=
 =?utf-8?B?eGZESSs5OGxPdWQ2WnM5UFF6RVRzK0tIVDBMbEhPZ2c3a280clM2UXk4OFNU?=
 =?utf-8?B?T0ttbmRrTkpMU3A0SnMxbzdWa3RQR0Z1VSt0RkJxR3V0Mk5GaDVpcVgvVDVq?=
 =?utf-8?B?Kzl0L2krMnFsZmJTdU5KbUc4cjhGaXoyZ3VvcXI2cUlvRm9iWU1NemNmMDBo?=
 =?utf-8?B?VTRLcHExZDBMTW5vd2c0TmZ2ekQyNlBQOEIzZnlzK3duT3RIQ3VRclFyekxn?=
 =?utf-8?B?eFc4T1VpQ1djZEx0M2tBRjlESHhDQWVDV1NmenBRcjV1S1Y2ZzM3UXFQRlY1?=
 =?utf-8?B?WmU3ZGgzZi94UFpKNmtyNG14MTJzUHZzRkZZZlc1akRQUHdqUTh0d2c4U0VF?=
 =?utf-8?B?enlXWURkaFpHZi9JWTZlSWEvNmR3MnhBYjIxWThqT2lvaEFZYmk3TmJqRlpr?=
 =?utf-8?B?dzYwVHlVTndUdU5qU3JKT3lENDFpay9pcUh1TlJwcVMwMFJVaExCSWJBd09P?=
 =?utf-8?B?cGNIKzE3TllYWTdPNCtFT3hXZFZHRzRzQzJwSVpXWWU5VHM3bEh4SjFycnhU?=
 =?utf-8?B?VUVMUTRnSFl5OU1LRmtVUExNQzhUV2Z4WWREQ081Sjg1MTl4amI5ZHRSa3J2?=
 =?utf-8?B?UjR2VnkwSEQzdmVGbVQrczIySUVscjdISVJKTzVtMVhMbTB6d2VVdTlIQ2dt?=
 =?utf-8?B?K2dINFMrQi9zcGlqZllPdkNWMUlDZlFmVmEvd3p1eWlnVkljU3JQcW5YUlFr?=
 =?utf-8?B?NlJKdnZhd3grd2ZRM3pnVzg3dzhXMElldnhJRGV4TTE4Y2R6SnQ3U1FrdXI4?=
 =?utf-8?B?V3pSL2FXVVZzaUp6Rkkzc2NJQ2FQR1M0Ung5RExqZDA3Z05uTXRVTXhMTFhp?=
 =?utf-8?B?KzhMWnRuZE5ldUZFWFJrVnZSbDVweHZBUkNpNDFaTkxMai9tUFJFcWNvMXFZ?=
 =?utf-8?B?QVI1c1phdHl2ckxJenlMbVpEaGduaERnMG9SdzdCK2ZOZUJZY1RnWmpPNUJ2?=
 =?utf-8?B?cGFEMDNxenB2S2R5ZGpEUTlLNGM0ZHNqcHNlb2xpMWNUUGpTd1hFaDNQS0dX?=
 =?utf-8?B?bjE3Q0RYTjkwOEpNS1JwMnBaMzMxQkNuV1ZqVyswWHl0NC9MQ2tBQitiME9R?=
 =?utf-8?B?U3hkaVFVaktlWFJRTXJiajFZVnhMZzVpUXYrSm8rRVd3Yk5rT1JYVmpzWmdw?=
 =?utf-8?B?TmFMeXVSakJxM3lqblI4ZTFDTGJNSzZCazJDcVNvbU9jcEpUdEYwdmFsazNw?=
 =?utf-8?B?ZVV3Qm9GQmMrS1A4Z3JCcmFXdVFwUG05RXJJTEJGLzFxK2d2QTlzYUFZWUNU?=
 =?utf-8?B?dmVqcGxNNHpVMXRoOTc0QUhyVVYzeHVmaGliZmwvQWx0MjJIWGFnRmQ5c3B2?=
 =?utf-8?B?Zjg2eFYwMVdUMFA2K3pXcjNHem9JVkFBcXk0ekZKcGs4blVlMXRSb2l6YzUx?=
 =?utf-8?B?Z0VOSVNxK295UVJTK2dJeVpWblphaUdzSlY2QmxlKzZwWEcyZ3NvMkcyQ1g2?=
 =?utf-8?B?YzhweEtCdFBIczRlY3gvT29Ya3RxZFVwZzhqYjBDb3RZU0F1bERwT3M5SnN4?=
 =?utf-8?B?VER5eDR3aHJYeFZvM01WREdIbnhpWnd3b2lzYnVKYXY5cUltUldONDBJV05C?=
 =?utf-8?B?S0M2WWFMdE01VUp3a2c1MDgxYlhrWWpvSmF6SWNxWGNlNWorOHlNZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444ca809-e767-4b67-a295-08df2b316b43
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 02:58:56.4689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xIgd/+Ns0dNVOuj7FsQYx55AnOtmiWjxwKDpHED+rMjohFWCYs/jVAya4MtkbV5t8uA5UxNnl/8fm8cc/8khA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF44635DB8D
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

Ignore please. Sent new patch.

On 15-10-2026 11:14 pm, Sunil Khatri wrote:
> The seq64 sync BO's PTE update only ran from the legacy CS path, so
> userqueue-only clients never got it mapped and their fence_drv could
> never signal completion. Add support for userqueues too.
>
> Fixes: ae05e3f3d02b812c ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location")
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 4dca1ab48410a..44cf25946a21c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -720,6 +720,27 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	if (r)
>   		goto free_fence_drv;
>   
> +	/* Update the seq64 BO mapping in VM for User Queues */
> +	if (fpriv->seq64_va) {
> +		struct amdgpu_bo *seq64_bo = fpriv->seq64_va->base.bo;
> +
> +		r = amdgpu_bo_reserve(seq64_bo, false);
> +		if (r) {
> +			amdgpu_bo_unreserve(fpriv->vm.root.bo);
> +			goto free_fence_drv;
> +		}
> +
> +		r = amdgpu_vm_bo_update(adev, fpriv->seq64_va, false);
> +		if (r) {
> +			amdgpu_bo_unreserve(seq64_bo);
> +			amdgpu_bo_unreserve(fpriv->vm.root.bo);
> +			goto free_fence_drv;
> +		}
> +
> +		dma_fence_wait(fpriv->seq64_va->last_pt_update, false);
> +		amdgpu_bo_unreserve(seq64_bo);
> +	}
> +
>   	if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va,
>   					   args->in.queue_size,
>   					   &queue->userq_vas.va.queue_rb) ||
