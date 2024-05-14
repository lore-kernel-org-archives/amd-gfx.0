Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CD2C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 07:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E574010E3B4;
	Tue, 14 May 2024 07:21:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nBHDfC+7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D488610E3B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 07:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=En1TUc+PoRxeanxn+ne3XwRfQAEFCDNqY2C7lxwOBNR3JTZf2i3pa65wePOpEuXlpCAXQ69ar229K24D5d2woZCQBVxb/7sv16J9d7AtLV0XFzQY0oWmB+jx1SpmFxvvHhlShRNTHU6hU/8aCjf2BIs2wHEBRVjUsIzTpSkoNMazTYi0nkBQwcjWnL+agrcveWMyVhUD0lsOnk7xjBHSN0h6t/+c2SD/9G2qNgzwEcTtEGzmX29o2Q5uqg0LW5+skIj4ZnDvtl4uP0ieRk6YfvisTrrwEkIWzuw//EHR1tjkp0pdLRrYHaFDw5HPnSiMKm5w9WmilDJ0XI9oRWyceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZqsJM9SHFSMB8BwtF4h4QH0XT6sJy7/Dh++0KpZbXo=;
 b=h5/YeiM8Pztf/YDBUp1IEOR1ioZNcEywtO+RasNTwAHLEQKkBxiD78K0FX/tACllDvs5k/RIMt2s5FZ2D2H6appxDd3hxavxzJwGKDjgbrcSwGzYU7CT0ynLVV6QjWa6paNRJ4YMjNJMj7oV3lV0BKuDQxUEO2KvQs7iJeDj2ko5HNjbgXxPHyMBNM8xuxZwlBVyc6f0n5UMEcDqWoIhJySV7g2GA7jZeRcFQu2QoUrhf7GdqnmZjxmhDEcPlh+nCp/iGCDAXxyPEbK9RWY0V9TXDHXlYvxfJSjOyRZoBus7QEG9/x6Hihi+HNHfGKoZ+8AEupd5b3e/aJjAt+YEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZqsJM9SHFSMB8BwtF4h4QH0XT6sJy7/Dh++0KpZbXo=;
 b=nBHDfC+7sy0fH0ahPasAKoYvF1F9wR4CSRly9GIlCxuVy+zd4p25rwE6lrC32CBUvlO0cQse4pB6bUKtjsydupacPKlQPrMaIgilFR2FXzcrs3PHN9CyYZxQallU+8xeFa3s8wmvn4cDJ1R5Dp0/q6rc5hSJbDny+aekE5Dh2Tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 07:21:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 07:21:06 +0000
Message-ID: <42cc0287-09da-4d71-91e9-685287fb56ca@amd.com>
Date: Tue, 14 May 2024 09:21:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Check if NBIO funcs are NULL in
 amdgpu_device_baco_exit
To: Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20240514070638.199124-1-friedrich.vock@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240514070638.199124-1-friedrich.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f790de-269c-4ae4-78ca-08dc73e66b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckVzUlBZQytBNndxQVEwaDRqQ0lJcXJ0ZkhsVmZJYWl3M05ESXNQc3l1MVRZ?=
 =?utf-8?B?NXNaakNKcWM4WlQ4LzJWWG1rQndNVkpDb2YxYjFGZmJrMWwrY0lFRjZKcytW?=
 =?utf-8?B?bjFSWGsyS2xjYVhvUExlcDU5TjZzN2lUU1hqcElwWnVVN2g1aU1ia2Fscjc4?=
 =?utf-8?B?S29BOTVDeFFrZ2VFaUErenRscFhiTk5kSU9pSzFwanVPdlZydGROd1lRaTZm?=
 =?utf-8?B?UzA0NitvUjdHZ1NlTGo0RVAvTy94VTRrSWVRVlpaSVBVNDNqM3R2TEZ6N0Rv?=
 =?utf-8?B?djZrd1dkZ2dLckcza2NSbGp0WVdlcGZqdHhXM3h2ZDc3ZnBtRUtlTWg1VVBH?=
 =?utf-8?B?eGNyUmE5Yi9pQ1I2S3JyMnl3SmlCNHJ6RVZjOGxVTFZsbmFCSTIzNWVYY08w?=
 =?utf-8?B?OVJjZ2lxTHhUZjF4ZTgzbTE2QmdscEtwbjJYNEU0akZLR0FqT2pJSm04aXRj?=
 =?utf-8?B?ZWszR3QvWlVYR29jK05CUDEwWkR2VS9zWWhPQ3phelpGLzZINDJEbit5MEd6?=
 =?utf-8?B?eFRUaDRHUkFPRStHbkoycnM4N2Naa0tFWDBJZ0dmWFkwcWUxVnU1N1BPOFFQ?=
 =?utf-8?B?MnRRYUNuTUxzcXBEeEQwclR2U2JKRjM5NFVRcFlrYXorbm9uVGRLTVVpUGpX?=
 =?utf-8?B?QkVUZFpTQVRkanBMU2FNWWw1ZGJKQ09mUG80QjFtWkYzTjlJT2lFeThRRFdM?=
 =?utf-8?B?Yk1pMHNPWXhtNW5QUWxXTUdraURvT2c2REZhYXJFOWhjU1JSei9HbU1NRHlm?=
 =?utf-8?B?YU9mRzB6d3dlbHJPSDBDbUw3SmpxcWlkeEN0ZmZ4ei9qSzZBL2FWemlqZXhK?=
 =?utf-8?B?Qmlpazl0SVhOdHd5a28vNE8vTUNnR0d5Z3BtTS9YWldFRTRvWjBldG1BN012?=
 =?utf-8?B?ZzJNT1pEOStibURZQjdraEx3SnFRbWs2SENrVHpCQXpoS1pTalNuWXlGYXh3?=
 =?utf-8?B?TFJkOFI3cTV2ZG1KMmhNRUY0MTk3aW56bC9TdkZjYnJQMW1WbkVFaGRLdVlM?=
 =?utf-8?B?Y2xVQXFJaktFZG9wOEFTTU8ySzJEMmp4QVM3U3JFZlhsQjY3N2FVZHVBdmV6?=
 =?utf-8?B?QU1PN0ovNzJqVkRIZFlWdDZQZUpYUWR2R3ZSTEJJT2EzYzl0T3gwT1lmdlQw?=
 =?utf-8?B?MFhhak9vcDFGbXlQemcrMlBEaUtFMnlRNmM4cGxUWVZuUTZNSHhnZnRHTy9n?=
 =?utf-8?B?clZvbnhoMXMzV1dFb2pMcVBubXN5ZUt6T1dvZjVSaC9XUk1nejZMYjlGU0c0?=
 =?utf-8?B?Zlg2em56cEJjMExXcXZlY2toTjhPS1BiSXFEOHg4NWorZjZET1l6TktTanZ3?=
 =?utf-8?B?ekNxUC84WFl3bHRyNktoNFBaQmVtOGQzQyttU0diWk5SazFkWXltZTZxWUVX?=
 =?utf-8?B?bjJuWXN1OVl3YkhCZFVRbXdUNlQrSVBoNjlXdk5JTmlwOWF4OTBjODVvQzF4?=
 =?utf-8?B?NnY4YXE0SFQxdEVSajhKS1hJci9GMHVYZVA5UGFVdlNnMXViVWQ3cnh5SG9x?=
 =?utf-8?B?VnlyUWN6QVVHeUJJQkhncTVML0x5V0M2MFZzM1hYMFpta2Y1Y281enIvODJa?=
 =?utf-8?B?K2YxRnlLK1ZSbDljZklIRWRzd2VOaUthOW5iS3FSdCtPanlPb0hPa2xNSnZy?=
 =?utf-8?B?Vlc3ZW5QQWV2M291NDFuNjQ0ay85b29WQjFEbnJOUjUwY3RmYTFZU1UvRnpt?=
 =?utf-8?B?a1ZtTjFBZzcxZ2NNb1ZwdzJGaWNuSkRnbnMrT2UrWkJQMzVTZVM2cEV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXh6SGh5WlJMS1MydVJoclgxQWRKeGlqWVpaMGxFTEdkNG14UmhGVEVYakZM?=
 =?utf-8?B?VzJ4akRvNkpRVmNQTGZXeHpzbzJoMUc5eEJXMGJTZ1BYZnQrTEh6QkgyZEZk?=
 =?utf-8?B?OXFOdFM1b1JuUSt5bHFVWHowblRia3lIMVdFQzhPaGNpZXNGVXdvQ01KMlJT?=
 =?utf-8?B?MGtVbW9ZQUM5U0NNOVNxSDdLMUpXdkI0WTdHSUFXZTRTQUhSZHZmU3dGcC9r?=
 =?utf-8?B?dUkyZWFUdnBHRVR0VldRdjE0aUIyR3dKQk4vdDVjUjRBRFFtRXZSVkxCb0g0?=
 =?utf-8?B?czYxaHRtSWtYOHBQY004Q3Robmh4TytOaDMvSTI5ZmZha2xXdkZWbnp3bTlE?=
 =?utf-8?B?Ukd6SXZ0MEc5akcrSC9Vc1NGa3JGMDd1a2JOeTJYanNNZC9XWkR4RlNKVnhC?=
 =?utf-8?B?YzV6T0xmYk96aUFTa2dZNUpUU2ttcyttOXR6c2wyaWw5cmZYQ2xGTkVodTJE?=
 =?utf-8?B?SFZYa1FKZUtWVU9TS3ZmSjVvNU1YNWZObm9iU0N4RFFwaWllMnBqSFhoM3VK?=
 =?utf-8?B?b1ZiVHY1RDQwODRjaUJDVjVjNnNVc1U4L3VwRzErc25uc0dxUWxDU2dpQXBw?=
 =?utf-8?B?R3YvKzV4RCtheDFHZFNVNVgyaEN5dGhWeGFsZ0V0NFhwMWg2bS84RjNBTWta?=
 =?utf-8?B?R3krbGtJYk9iRzlMWi83LzRKejUzUzB4YmwzeDNKY1U2SGdHajdxbXlqYTlv?=
 =?utf-8?B?SndTdnIzSVA0WnpEbjV3eGpLMmMrQTlxRitqSGtEamdSWUpIdXFFa0hEUjNX?=
 =?utf-8?B?RGZVL09wWUJpaUN0cFpxN0Y1bDdZQXJrS2hvUGU5L1VBNjFjUXJtSFp6NXNn?=
 =?utf-8?B?aG9iL05pVDhOVUVpcmE5YjdGU0xsbmZ5UzUxck9NeUhYT1dILzdQRy9MVmJr?=
 =?utf-8?B?U1EzU0pldWhBNkJyaFhvdGxVM2lmblpsMTMvbmFNN3E0UzZtN09yd0RlejZk?=
 =?utf-8?B?S0lxS05zaktib0xsL3ZCKzErUzZ5QVJva01uWlNkc1Qxcnl2bXdCUWZrLzcv?=
 =?utf-8?B?T0dqdHg3NGRGR3BTZDFZbHBhdWNuMlVWS1VYZnp3cWhpUUQycEN5QXhXaDlN?=
 =?utf-8?B?VkthMkV4WDd0M3VkMlgxN2VIVy9UQU91b3V6QnI4S3RlcE1lT1RHY3NvNE9q?=
 =?utf-8?B?dEZ2U1Y4M1dUVGRvcjM0MlNPSnNxeHM5QWVIWGwwK25aRSt5VDhwKzA1Tzls?=
 =?utf-8?B?ODhSellLRitnaktTWHVISTh2eDdNZXB2TUhqUDJuaTFHZlkvcFpibG03bUM5?=
 =?utf-8?B?dGlzWlhXeC80RFgrZWNlWDNmcGE4b1VoMU5tVmVFSEcxU0dyVjQ2R29zdXdp?=
 =?utf-8?B?Zng1bDZxcEN1NEZ5eVpMNlJTYzJsTm9CMXVOZEQzQm1uNmp1VS9VS3dmbm5T?=
 =?utf-8?B?VEx2QWcrS3IzWTF6OEtxZWp2UllUVWlCeHFaMkRCRDh1dkZiTWMvUWpNOWdn?=
 =?utf-8?B?OENSZHBucU5EWmE4ZkQwR3JpUFlYaiswVkZKRVhPSE1vMFJkcUNCY1BCbStz?=
 =?utf-8?B?ZnJyT1d0eVhHb2d3YjhoR2w4RldPRkFyVnkva2t6NFpkQllkbTlYb21KcEY4?=
 =?utf-8?B?MU1sZXFpK0l2NVNpT0Rud2JUN3hUQWZETytaYXBsSExmRTRwbFFFdHY5b0tk?=
 =?utf-8?B?MUFOYnFlTXFOTEVDYmlyT2RIZW1JMEN3OFlBVUpvVDZyUFBoaTB6VHBpaEFl?=
 =?utf-8?B?M2ZnMWc5azRIMDlhSXlCUHBrNzVvU3E4NkpuTFNMTDlQN0gwVkc1RVUzR0hD?=
 =?utf-8?B?TFo5VWhVZDNyN211eDQ5bGxkc3FhQWJ1T2paWG1sc3VXTnR1ekZFc0tWTlBE?=
 =?utf-8?B?SURhM0M4Z1VsNUN4YzFPVkcwczZyajhpQU13NytoL3hSSkJLQWtkRkpTRzBh?=
 =?utf-8?B?TkswR0lmcVk5MmdQbHl0dFVpSmJycU5UTVNtQTJuTHd2aUFPUjlwL2ErUHJG?=
 =?utf-8?B?amhoS0ZFYkIyQ3EvbTh6K2ZTWEhsc1hsRCtDZXlPRGw2cG1zWmNXUXVsbDZT?=
 =?utf-8?B?RWhxdStWL3RWZW5qQk1lOURDY1FwUG5qd2x5M0xrSFdnRjEwV3FqS0txdGtS?=
 =?utf-8?B?MmV3SFdMWU5CRHJpbGRSUzRRVWZpWUl0aExtVkQrZUcwNy9vVnlPMTQ5ZEQw?=
 =?utf-8?Q?kTA0lNg1sGEc4ZWiCgFrEfJt+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f790de-269c-4ae4-78ca-08dc73e66b71
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 07:21:06.4184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KDAIi5Uvg41sU2eMzOsEcDK7WoFFncmD0VmOlJWpZXveYeRSNgv63uXUpy+y4fs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
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

Am 14.05.24 um 09:06 schrieb Friedrich Vock:
> The special case for VM passthrough doesn't check adev->nbio.funcs
> before dereferencing it. If GPUs that don't have an NBIO block are
> passed through, this leads to a NULL pointer dereference on startup.
>
> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>

Acked-by: Christian König <christian.koenig@amd.com>

>
> Fixes: 1bece222eab ("drm/amdgpu: Clear doorbell interrupt status for Sienna Cichlid")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 861ccff78af95..83c4533ee75c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6165,7 +6165,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>   	    adev->nbio.funcs->enable_doorbell_interrupt)
>   		adev->nbio.funcs->enable_doorbell_interrupt(adev, true);
>
> -	if (amdgpu_passthrough(adev) &&
> +	if (amdgpu_passthrough(adev) && adev->nbio.funcs &&
>   	    adev->nbio.funcs->clear_doorbell_interrupt)
>   		adev->nbio.funcs->clear_doorbell_interrupt(adev);
>
> --
> 2.45.0
>

