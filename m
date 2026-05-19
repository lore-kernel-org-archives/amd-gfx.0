Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FDECD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 12:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78FAC10EC9B;
	Tue, 19 May 2026 12:38:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QjmJqJmK";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B2DF10EC9B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 12:38:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqZYR3vmi/xz+2l8Y4HS/GBMox73ikKEuzALVHdYpXAqo7My7B+PjsMlww6x9bB9U41bSWtGPsiAsgUBgtxlcMd4Jy8aT6eUJwWQQXV5cRpRDyHKSKTiXRbsKXuhtHmKYlBO2zwyXzIBoRRNwlCJn4im3EnuzoySr+e9+nvm63c5caUiE3p3JQtDqcyRy3Uirma56zr3yvYoa2A9CDvmorsKAVNqmELN5oUB1QGrtbH7xR5oNXo++yaeU0ubU+PnLEQQZFkx52rG8H++cTQRZSPgeLF95A0ZVkn2nI7TQ8TnFB6/uihI19fS//UGSEDAIhHzFpMac+bCqw0Xr2tPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHMdarIIfpZG5jzjd6W2ngsW7+mvaOTQHnJ0/2jJK+w=;
 b=QL1CXEBR9BEny9c724yK+SIG7PVm6Layudgb9zcnVzBp2pa3F0VzCCB9dZ+ow8B/3nTR7HVJ/6WjcrPTSTI/sQF/crBLsrNHiWg2z+ggQ057M34w9/s2ga+002lLWHr0vWGt2p612OsR/1/n9pQUwV3Qaa9e6sUQVTOT8ozKD1c24CIvev9Y/e1LMCbt2pENVH85lm70HfnZHAu+D6eQb0y6v1NC8SwqPduynxq3xKYmsQknxfK/sSM3Ic5WxXlsszHLj/hr/GFqEgGrSX1CH412RGpFw6+RaY08JYT88Mk20NU98ldcZePIL8GyGG5dXPtVO5lWaHaskIofbI1Y2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHMdarIIfpZG5jzjd6W2ngsW7+mvaOTQHnJ0/2jJK+w=;
 b=QjmJqJmKL2fkEQoB4PN5C+Imsc1UmFnwNxWUVczecnStz6/jpvAaujZn90RmGmMCXGPZyqd1p37kao1Tlwc7BitIqYT3UUuAIlBgpduqDd7n7/A1kVGBYVgS+cQYz9DcK+1rU5sRfGOsqdFz7Dwyks870hsUT8tX9d+KCTo9h4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 12:38:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 12:38:52 +0000
Message-ID: <316ff7e5-b665-4a40-9a8e-f1f5ea07f794@amd.com>
Date: Tue, 19 May 2026 14:38:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] drm/amdgpu/userq: Fix the mutex_init cleanup for
 fence_drv_lock
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260519111801.1435954-1-sunil.khatri@amd.com>
 <20260519111801.1435954-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260519111801.1435954-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbd2ba5-50b0-43f3-6464-08deb5a3956b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: gTReqnfmDjFpNTZnLIbL9L0ZofqcL1xDcVXmtcLF747UXurUSOJPRiWle2hbi0x9YLqLgV2jQmzEgdegYgJO+ayjuso1chyYhxU2q/L0gfn+6pPW7yPqiRYag9Vthgwu87OnlVTrUEVHLVK3IOqGCxu+jXeLTcE3qljmGLD1YYkqg8tnuAIpH2uUWF0zvzb1xrMhhP4URzK9v6zikHVX3+7FfU/tFuiLqjqRtrSnHwCF7ckT4fmmgll3ZXrsf7lWXWXBVRMutfzSdH9Rme4fQCQ9eY3BJZB9qY5tgt5HFcuSHToie5KaSwEhlpGhJ/FcwAg/svNiq1ZSd594h6QcsoCjrpJ/KjP4om9sMvI21Q2zs7zGztPGk2SOeLJi4B5iol0Kct5zwDOZ3kUMHpXw+T6wK2IPZ71vL7eIJNQAXWUUIA2ULKOkbC+oTOQzbCwqJqrWS85bAlnuuaj32dbomSzwDpTFhVqYRTz9w0jOO03/slaAEktVlAgV31YgDtNuOr2ACEy2t5P2p69d3eE4NE8II0c0eE5ZtpNlWt/ucr14tHh1XqpLogeKJl20pxSVUgBkoKigJhc0Qi3J0M+07e4MeuLrovXcSsp694MEBzKMz1j1swQoXtK5ZJo2IjSUlDb1aNLfe6Go2E7hAVJ5XckmJLC4vzX/MWz9774DldUKAEFk96cO0lPSf0XRPkPa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NENaWnA0d1N1eTNnNWM4MkhTVm1iWGVPWEtaV1ZnNUYyMXVwZW4yUGdaY2Vr?=
 =?utf-8?B?Z1pVQVFGT3RObUVrWTVqNGlGTmFuNmdNaks2STBZSEJ1VjdlamsxdElXQjBP?=
 =?utf-8?B?eXIvYXBsd0l1TXRwdTZwMjNnZE9BdmVpRHdXa1pzcmRkOE1mQUR1aTRWMVdH?=
 =?utf-8?B?SjRFWElrYmRPcU1KOUNHN1FrUHZ4S3hYaklrY2ZtbkZWSCtlK3NCNThrM2Qy?=
 =?utf-8?B?akVPY3MrNlI0dGIyaEN3d1ExQ291b0NzdU1yWnF0TXdsaVJoM2NBZnM0WGsr?=
 =?utf-8?B?ZGpJbExtemNqZ3pBYXRMa1dUcHZNd2l4SWYvVGZxZTBmTHlOVWZ4eFMwcmhO?=
 =?utf-8?B?YzNLNElCV2xzUExFNFl3MmcyanFEcmJreGVmeVdBTzRsNUhWRFFYTTU2UE82?=
 =?utf-8?B?c0YrYUx2S0dyVnRXZzVUL3VXbWIyakJXSGYzRkl4Y2owQ3hud0ZBSlVNT0ow?=
 =?utf-8?B?MjlnU3pvc0UzbHlkU3k5aWowT1dhTU9pM2MvWklRWEFvYVhrOG5XeDVvaVRJ?=
 =?utf-8?B?am5mTzFZRy9CY2ZHcWRrREh0YzV3bEpIYVRjelAraFRPcVcvOTRFem5jZEFj?=
 =?utf-8?B?YzlsZ2VUR0p4YWdjQVlZVUZtNlhrcDM4MzdKUkhaTk10b2p3aXlhNTlvbkdj?=
 =?utf-8?B?RXFXbSsxNGxnMmh2U3NYNzc5bzVacG44ZlJXMlBoUVQ2dTE3b2R5YW5uaXhq?=
 =?utf-8?B?S1hZSTVyRWZpMm84a0F6U3ZPUmViTFl6MFM3SGhNbkVJN1pRT1IrUFVZT1RH?=
 =?utf-8?B?ZkFCMGRPL2RiUFN6bWo4NjVTOWpkSWZBVzhPK0hUMXA3R0NJeGR1WG9EWGF2?=
 =?utf-8?B?TFJBOUtsV0dtMWdSaEJBWWw0ajdvS1B0TkZQeWpXTFNqaWdTNVN6bVpiMXg5?=
 =?utf-8?B?aDF6SjQ3VFhJY2ZmMkp6QmEzdXMvTjNveUJKOW9lUWtaRHpJMlNWdy9oRm5k?=
 =?utf-8?B?VDRPY09tbzVocWNjR2s5TkZYbU9ZZ1lwak9Gc3phV2VxbEdTQWhPNWt0N1J1?=
 =?utf-8?B?UFNOaU40eWJKNGN5V0RubmN1UnQxTE5va3hjVlNlNDFKNWJZWkVOK3ZzRlRE?=
 =?utf-8?B?RHNFUFR0Z1NpZmRFc25UdkFUcjdVdTdhZFdwUUVqallUTG9RQ2Z5STVQbm1n?=
 =?utf-8?B?ZW1abzBoNHpqeVpLb2dqTU11QnZMbXdoemJmZjMvUEhDTmtlK3A3OG55SEpG?=
 =?utf-8?B?ZGtpeVlZbTlKSEFFUmJoelhhbTgybXNFemZObGJxWFlYZVA5RVVVbTc4Ky93?=
 =?utf-8?B?clpPeXRrMmRJUXR3ZFRtTVJ5MmczZXV6QXZZRmp1TkdTdCtCeWxtZWRKT3hM?=
 =?utf-8?B?ckJYTlBSSER5R29GUVBQOTZGM1BVN3hFb2k0UnZ2TFJWZ0pCdEJSaTVxOU05?=
 =?utf-8?B?OUpkNnRmektlQ050ckMySXFqdGFYaFNkWnpSWnRBN0FiRW1ONFZPVC9HaDJN?=
 =?utf-8?B?bDBZMlBSVVpKR1R3REtUQjM0T29YbXZ2eWlCMytQZWZVbzhQZUZUV0ZrU1NT?=
 =?utf-8?B?Nzc4L3RxaWxMZFREcVBkT3JxTzhrRTRVcmpGL3lvay9McG94TE1KdzVITmRM?=
 =?utf-8?B?bEVVSXpnMG9Nd0RySG1ENTZkYm5NbjVCR0t2SFdXdHhMckd3ZnJTRGI4SlBO?=
 =?utf-8?B?emlQWFVOL1oxZHYvMWVPUmZqUFpWVUhEbElRcTN4MDk4OFpWOURDZFgrUzRp?=
 =?utf-8?B?TG96T053eVdLT2JDVDJQTldlK2hnSzhtSklYOXNuenkzSU4yRDlDYm00ay9N?=
 =?utf-8?B?cGIxUXVIZ1o3Y3N3T1ZqejBJR2kwVEdJc3VxcStKK1QxeGpUc1FGY0k0eGZq?=
 =?utf-8?B?ajhsMG5DM0pIbWJicE9RRkVQeWRTdUM1UEtTNmZvL3R0bUlwcEM1bFloWm43?=
 =?utf-8?B?d3QzbGxGaVlEbmZhb0ZPaW5iK0ZTK2cyUzl6eldqRm5pZFNkUUZ6dnQzR1VM?=
 =?utf-8?B?cGxCV285VzRTTXFSS2hISXRXNTN1MUtQMm9wRWdhaDNnbzBYamx5b0JwaDZa?=
 =?utf-8?B?U0UxQmc4ZERORENYT1F0TWE5V0tOQzBjOXFiWmdYNVFmVkpUeGFXMWFVQ3Bi?=
 =?utf-8?B?UW5PK2d6TDFsMGt6dVBUeHozWkwyU2w0NFFQaG9qTUNYQytBamVVd1pKb3Ry?=
 =?utf-8?B?L3NJWjFzMG9VcFZXZ2UvWjZrMTJUSHJSaUZYRkszU3ZjVm5xYnRuSWszMFdj?=
 =?utf-8?B?dE1YL3NKUks1bldVcFdnU0VJeEFuZWRTa3pSV3ZKTFBMd0hjeGM4RlJRZmQr?=
 =?utf-8?B?ZkY1L3M0bUYvWndacGR2MWpvdnoyTmJXSVloK1NCclVXSGRWVkMwVTN2MURx?=
 =?utf-8?Q?zqJzCkF6V6xblpnHeE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbd2ba5-50b0-43f3-6464-08deb5a3956b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:38:52.6207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMXUrkkB6EI5G7pC0QxJNP6y7vTFEQGliZZKqcs7JbbYzIG3vgDAjfE/d/QyMyQo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817
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

On 5/19/26 13:17, Sunil Khatri wrote:
> mutex fence_drv_lock is destroyed in amdgpu_userq_fence_driver_free
> also in one of the jump condition mutex_destroy is also called leading
> to double mutex_destroy.
> 
> So rearranging the code so amdgpu_userq_fence_driver_free takes care
> of the clean up along with mutex_destroy.

Please also move amdgpu_userq_fence_driver_free() into amdgpu_userq.c or eventually completely drop it.

The cleanup done in there is actually on the queue and not the fence driver.

Regards,
Christian.

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index eedea84c5e0f..3bfb9ae2cb3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -748,12 +748,12 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	INIT_DELAYED_WORK(&queue->hang_detect_work,
>  			  amdgpu_userq_hang_detect_work);
>  
> -	mutex_init(&queue->fence_drv_lock);
> -	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>  	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
>  	if (r)
>  		goto free_queue;
>  
> +	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
> +	mutex_init(&queue->fence_drv_lock);
>  	/* Make sure the queue can actually run with those virtual addresses. */
>  	r = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
>  	if (r)
> @@ -844,7 +844,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
>  	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>  	amdgpu_bo_unreserve(fpriv->vm.root.bo);
> -	mutex_destroy(&queue->fence_drv_lock);
>  free_fence_drv:
>  	amdgpu_userq_fence_driver_free(queue);
>  free_queue:

