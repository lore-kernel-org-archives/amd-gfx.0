Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8463DCD3447
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 10:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E539610F423;
	Fri,  8 May 2026 10:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qh4MF5AY";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010002.outbound.protection.outlook.com
 [52.101.193.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D12E10F412
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 10:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YO/LKgtYu4Oife2wtp3kyorOSvZV3iGo9kQuZEgEcxyosBoFTWlOSRGrtF91G7amLzZ7TxwHskCBsTPtUVBTPbyMGW4Og9KGlYpcIvNygptQc5lqsOBP1yFti7DjKTKk8wH1GEOylTVXsFfwKEwSopMaf2qt25mAdb8Yl2t6l+16IztD2mhlnlUZCu8trzBzNIpQ5475L9UHmyuwYCADUqshLfBFTURJeuzk+RJKcOD+2sG6pBhKS8aYULYptLTf8xtJP5Bn2EqgyGIkM4T0J7v9BfEmAThZcDmXou9WA4zwhPeoow4uDBatlyE+vZ/RFuky2fQjlYnG2W3xW3OirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2FAq66xIqUE9X9XeOG5fdhIjiZO8pIAdArxQjbw29s=;
 b=qQ1ALLo1cL+3Bi43k2Jnd1ogIfpxfgcYhAgDRQftPw58E/HM4t/95LoUfomCH3CnuPTB7axr1ukZL2py/GC79wUfrmZ1OfAq1IqTUPQ8znjjg7oPGuyE2fc5GJUBkY4XBCNbIqZdNr8MpmiD2vKDGZawqmaGHq4AFarnEZMEUulAt3lakELn48G5hTCi0g6W9Rq+F21bdvruJ6gRieU3rD5dYUNDQFN9vAhVwfjEbxJDa4t9gWGiAiWqziTepeWVTF6VzXctY9vOOfqW52stRNEgTfnEoLNF6LatsQp9Qm9ID6EoP5epzATIYulPxrGN+C7CVgm4FdBuyy+C26ZGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2FAq66xIqUE9X9XeOG5fdhIjiZO8pIAdArxQjbw29s=;
 b=Qh4MF5AYTSE1if62N3GYZZ8azSzVPQlVDnG/s9pYdgQlQMIAnk6Av+xMb/fxA5fSSYgB79lzl8RoU6OhvQcQZ+Q66ycaaRPGtb4PpcN/V/rA2LSgtTW+L0iLD9Kt/mNxxLGayWVcuMFaQdlz/dNF6cLtzZ0gN0HbqpXWHx/IcjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 10:04:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Fri, 8 May 2026
 10:04:35 +0000
Message-ID: <5ee8a763-f939-4966-b1fc-95a562c6ef43@amd.com>
Date: Fri, 8 May 2026 12:04:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: unmap all user mappings of framebuffer and
 doorbell before mode1 reset
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com, phasta@kernel.org,
 Honglei1.Huang@amd.com, Perry.Yuan@amd.com
References: <20260508061738.1039917-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260508061738.1039917-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: ad288a76-6e33-48dd-74ed-08deace934f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: DsEBKlTJekozqw3vC3WRixakY1CBpLaM5pyx267u8oxgqDCz8Zbmq4sjPMb+t18EubZxN5rdnigdclYhn+89LSkA6vPQHpTKokGh/lPpDM6KuzgzHCxZEsfGBNENWnDbEqzFL8Xf9ZkKmSzQzjJdwsmSaB3DS21zgeulJ/G9HJdlucVwFB7Ujnoo7SqHHyqdyST2EbFsoyVeXC8tnh8b+ko3137m4IS7qBaHUdJ0ToSbA8dAKOqszNouzUUR6O5cWU4uFtz74o+v/+lyn9ToT4Aln6jxgIo43jG4psnItqGnp1erV0n/hdQg1H+9Fjx7ApX0Rqwc3FYC020k7ifUUActN4Vv13MZZ3lZv6K3KyNJizUOuMIMvtt2b4vi3p761O/2CohyKeeBuGtTmY5Ym9r81iXTi13TsMz8wP3/iSM/UyRs0/3dRz4O44lmITfNaEBHBnX7EC9TwqAeYmnoHoisxGHKoFoiSvQeIjC5qpsSB5WaL3p3+t38o3qB4C3D9sQaUPcT4QHpf0xGY2Qz4r8LGIpCIrPPlJd518Q4DLkqNBAonYGrku/g47hpd5NDnd1rmTqjlZ3U51obk+kwOcBl7iKDJJDnxDmsq1bD3OsJhibhG/UZVwfto/erLGV1B4uwFlRFb7JjVAfeqNM/Rs7bInn9NB9Mq8fBfqRdKkXtxJp/iIi5VFJZ11WgBWQh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1hXRnlJNlB1bXdFTzFOeGN2TmZCeGFJcUpRUVA2MVJhd2xCKzRNa2RzRVhU?=
 =?utf-8?B?TFZrcmJJTTlvMHBvM1FkbHBESjByZlFLa250eXJQSkZJaUg4WHlKN1BhbC83?=
 =?utf-8?B?dWNGck1JZzNlM3dSTERvUUZJV3JDSUhTTVgwNnpvZHpuVkJNZzdSZ2R6VzA0?=
 =?utf-8?B?QlJNK3JTTnBEc0N1ZGxJVWw5Qis3Qm5FMStoY2ZBMXlRdlN4WEFiNXFZblRp?=
 =?utf-8?B?VjVEZVZMeW5CaU5hUkFyQWRVYXdtWkY5cFY1d0NtWUJ2ZlRhU0YxR3dwZEor?=
 =?utf-8?B?cTl5dm44UVE2L2p2ekR6elJkZWJpRXMyRnhYbWtvdVpWWFRiQXVpdHc0aEN1?=
 =?utf-8?B?Smk4SWtBV2l6WkxnZEJRb1Q1OTlNZkRhZU5YVG42MTZwMzlQaXpFUkNvUUpt?=
 =?utf-8?B?cHpkeGJaQXk5N1Y2YldGd3o4dWIxbkFsTE1aaVRydVpzR21NL2kxM3pCaW1x?=
 =?utf-8?B?Y2ZwOXJnc0FXR1VQVnFQZGVQdXNVVitWeU0xWVBVN1VWM0MrNjROelFReWZE?=
 =?utf-8?B?SE1xZkhybFN5Mjg3Zk9zYWlRLytubHdZM3FRdkpWQTV4WE41M3RKbXV3M3FT?=
 =?utf-8?B?ZWhFZFE4blh6TGFlL0djRUdRNmJhOGNmeE5tWklscERRMmRvNFpTc1Vqakto?=
 =?utf-8?B?OGFJL1gyY25FcllIVGREWlJyMHlXeDdEUG02Smx5Q0NiTnVGWEFMbDEzeGww?=
 =?utf-8?B?Y1V2MWhDaEo1d1lMYVU0N0pNZHptZjlPbHRpSENmRkNTcGhubEd1RVlwdnRx?=
 =?utf-8?B?YmlGUFB5NUo0OCs5MHl4ek1vSWNEZHZGRi9qVUpBMjY1dmRZeUtIci9mcGVo?=
 =?utf-8?B?NnNMaGpiZ2FXUU4rczJZMTc2OXdWRWRyNTIyYVBpWG00RDJQdkRnUW02WExR?=
 =?utf-8?B?TXVLVGJSY3RveUl0SCt3ZndldjhOaktKTXFMTW80YmZIaHVTdFhYb0M1QU5P?=
 =?utf-8?B?QjhZL3cyMXNNb1hvMnVxY1NFOXEwYnUrbG5lS292OSsyVTNpR1Fpa1NiakRP?=
 =?utf-8?B?Sm1mQkdudSszdkVKSWJmM0Z3cjJJb2p3SDFRUStlWDV0NVdjOTl6RFdMRXZH?=
 =?utf-8?B?MUdHOStWVWtXZHQrMzlCWkorS0wrSUV1Z0lHWThFMG13dEhDVWZXRmZrT292?=
 =?utf-8?B?OHA2VDM0cnpmVHlNaVNwM21hV3REMXJZNk5YdzNFem9mR1FTR3pZWFVCT0tl?=
 =?utf-8?B?VW5jUk1JSXhuZmFFQjVZbkJYTmlYRmtHM256U2pZYjNVUkllbU1mcnJQT3h6?=
 =?utf-8?B?c0dUTXJtYnBsbHhJd2MyOGRwWUZHWlZ4bS9CVXJZenN5WjIxZXNTOCsrVnMr?=
 =?utf-8?B?c0M4Zm5zRm5rajNnOUV4T0RMSCtIUDcwV284b08vaXMvcVFnMGdjbDJyVjFi?=
 =?utf-8?B?bEV0bURrUU1MamQxK1N6TmV3dUxuRHc3d09LMXpEOEF6dmNLSW9kYlZtelkr?=
 =?utf-8?B?dUxQeGlCRjRKNXcvd1B4UForMXgwdCt6cEtUMEVkZHlCZEM3V2xJakFxWE1I?=
 =?utf-8?B?bklWODVOZVYycFp4YlY0SGxYd2k2S25PakpiTWtyQUw5NDNHWE1yWlZiMHBR?=
 =?utf-8?B?NUZ4NGw0QzhCTm4rWmhaMEw5U1hGZnRhK3NmcS9DenlCU3VaTytkMzJ5UExG?=
 =?utf-8?B?NmtuME5GZk1kL1VSTFhWZmdNRE4xd0QvV0I5eE5iazFpSEZKZm9rS2ZXMmRF?=
 =?utf-8?B?K3F1SmdBNlBWRkhXdHo0MjlBZlZnM0dLOUZTa2pZcjR6WmRieGJSY3VKeTRB?=
 =?utf-8?B?cUxCeXZ5RDR4NUFBaUV6czBhQkdyODhsd043bnk5K242Y01ZU1I1Z3RIM01y?=
 =?utf-8?B?RlA1NGd5MlVndUNMbkN1NkplWm9uaGJEMzc4dEkzK00vd215aTRtZGxiU3ds?=
 =?utf-8?B?MWlSZHJyaXJFWVY2R2QweXRHSzNBQXUxaXNoNzlMZVB6VEpIejlrcDcvZjg3?=
 =?utf-8?B?OW1oNlFtN3hqanJXdTUxSDZXMXJ2YTB2WTRJMG13V2FzUmI5UzI1dnlXaDZq?=
 =?utf-8?B?SEJpMFh2MnNJeURTdU9xd09uT3liNUE0Ly96cmZjNTYvM1Y1bFVyTmdwSDF3?=
 =?utf-8?B?RnRWTTQ5Wm5OSFNhTGN2blVSNi9reStzWjFyUDVRdnhhaXNTbDA0Z2hPdW1a?=
 =?utf-8?B?a29VK1d5MTRtdi9hNy9RWUFHN1JXdGROWThDNU1BenlNK1ZxbHB4Y3dNYnBt?=
 =?utf-8?B?RlhLUnBDOVhiRjNYbTRqL0pZWk5FdGRUa1NpaVJFbXNVUjFQZ2Jzb1RkWTha?=
 =?utf-8?B?RTh1cElHSnZxU3dobWl2YUpjblNxM2RZRjMxV3FMNDZlUXM2eEkwaFF1YVM5?=
 =?utf-8?Q?1Y1JpedPfwOvKtXqAf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad288a76-6e33-48dd-74ed-08deace934f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 10:04:35.2059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPyiIHvSESY2SiOufwUC5lTkutHsdn2AIAgXkmekp1wRXrb+r7xZexlgD3lnHVAg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
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

On 5/8/26 08:17, Yifan Zhang wrote:
...
>  static int
>  amdgpu_gem_add_input_fence(struct drm_file *filp,
> @@ -118,13 +119,21 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
>  static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>  {
>  	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>  	struct drm_device *ddev = bo->base.dev;
>  	vm_fault_t ret;
>  	int idx;
>  
> +	/* Prevent new mappings from coming in during reset */
> +
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return VM_FAULT_SIGSEGV;

Please move adding those locks into a separate patch, just add a comment here that we need to handle new incomming mappings.

We basically need to rework TTM and KFD to get this working correctly and that is a huge bunch of extra work.

> +
>  	ret = ttm_bo_vm_reserve(bo, vmf);

That is obviously the wrong order. Adding the adev->reset_domain->sem lock would immediately cause a lockdep splat here.

So you either didn't tested this patch with lockdep enabled or our lockdep annotation doesn't work correctly.

Please always enable lockdep when testing patches which adds locks.

Regards,
Christian.

