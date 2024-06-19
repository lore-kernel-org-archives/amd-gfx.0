Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54083C27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 09:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB1910E113;
	Wed, 19 Jun 2024 09:26:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jpAjLMbe";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCBC710E113
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 09:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ns9CnAO0h6jy/xz44XKa2npaBSSiCu/YmZfdyMX5COJ0hR8rWngCoDHzuQMPoxwoGFN7LTrhnLatrjSnDgkYY/Bje+uf0dHaTP+yPUp2j9ifyyuaAnbqavibcCENJbrgp6d7MJiWDkzoMGh9wu2kmow9cnlihS+nrOMthKkiVKHrEM4y6jqLrME6PH7w7/1zr7W93THacaxCpj2QHpemRdS/EF2SNzoeS1Bn+20PqpQ8o59y/oJ8f+UEzoTNOPG4SSyXBwyFKfAngLcjHSnaLixF7HrqWJIQqsoCh4PBvvqkSjmgSnzEnl3Lwu3WP/jR1oXNWyKt/CIE+WyqBVp39A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfugvmEBpE1Sr6ytZs3X7N7DyJFqrAAl/phJEhTy//Y=;
 b=jG46AdXBdKNaAmTe4HJl4yxj/UkYW6HWihxXP9mAql9BaFdbU7t7YYlhMCJdIsQrmRpAzxagyRiBheGnWt/VPXMN2lDiWGGBi+Y9kzV4Cf58qrd6DkiHjpl+iqjJrE1cTsR5wpj4eTlwrRtpvyPqcsgWWBZmwX2ltQ0NV6MR7Zuud+7sDh8Z/ZvNG8BhRLHnCH6ayybV2FnnGJjswNoZpeNST0Xklry4PXp6/zpNzZd80lhOgkT6sWphHzuIN1nFhiuxhhG/q1OqhddFHTIS7DCZh528eceyxL5a1CkL+yOXtlQ0dSesF2w+hzSh0EYK7MwYzNFbC/vkbN4vrFgMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfugvmEBpE1Sr6ytZs3X7N7DyJFqrAAl/phJEhTy//Y=;
 b=jpAjLMbeqES91jNEgrC75fETaW/cUbiVPXsMMpCwNPXzeiEZbb0wtcZYXdCWJHjph6agH3kUs/8GEepes6Wm9elAM4h8QHSjCkUi9DRsEZHwzvF5d5n5FkMCuWOT/Kns0mIvUhWCVnqE8RiI02FIIIl/Jn83VOclQIDsCuzvOYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 09:26:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 09:26:36 +0000
Message-ID: <c45283a1-98d2-43a2-a73c-71896464c7f9@amd.com>
Date: Wed, 19 Jun 2024 11:26:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amdgpu: allow ioctls to opt-out of runtime pm
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
 <20240618153003.146168-2-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240618153003.146168-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: b0dffea7-24b1-4338-4d28-08dc9041eac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEM0c0xQeGYzbHlqaVcreXBTVkhnT2N5UStielRNQ3h1ampDZ3JvVTJQVmx3?=
 =?utf-8?B?QU9DRlpvVE5uNG5nQUZQVDlTL1FsZ0Q2bWdvbnBJZWVFWTdINmtabUJraTV3?=
 =?utf-8?B?V01YTFhDb3czUi95ZWxkS0NRVzQ5VWllek8vVVlYdmNmTzdHQmJYSXJUWnE1?=
 =?utf-8?B?WDAvcUYwRXRrb3ZzL1c0Z2NlRTdOS2VCSDlaVjVRWWpKbHhWNDdlWHp4U3E1?=
 =?utf-8?B?TTBPOU9Dekt3YlMyNzZlMGc3bUEzZjlzVjdleFBxd2JnL0ZvRURWRXB3aE9O?=
 =?utf-8?B?VmNzdG1uS3E1UlpKbUxtSExDdURYVFFRMEwvUEZJelZxNDQvZXc1R0ZIZks2?=
 =?utf-8?B?SWw2MmR2RXYwWkdFbGU4V0NzN1lPYXQ0NXJ0Nm1yK2hBNHJzYk5SMnJsN0JT?=
 =?utf-8?B?eDFWd3JIc05JS29PdmF5L1FlRDhkMjBwV2NuS3lkQllnb0hReGJtUlBPOE5G?=
 =?utf-8?B?dC9IYk1WTDlrYkxGK1BiTzJ0MG4yM3RyeUwzTTNkOUJkUDVTakRjTkVFWkZ3?=
 =?utf-8?B?Z2NpMDY2UHpJQXk2WW01cHhETk9XQjlmcTgzdGRDcGM3VUUrMHpXMGxwQU55?=
 =?utf-8?B?MHduUlYzemRmOXNMR1JjYTZvMjBhVEZUL1FjZnpkd0NBMTBrbzJWOGlWOFJj?=
 =?utf-8?B?RHZMMjl1YjM4UEdnOUhwU3RtM0lnYlpuelFNSDAzTDhJenNWdEZqYjFOdWZC?=
 =?utf-8?B?aHI0NnhuTjlTOVNuMHpIREJuclZ1THRRR0M3STcwekdYVCtpWkwzT0pkR3U0?=
 =?utf-8?B?MkFIUEZ5QWNvNlBacHd1aS9VMTRQdlhxdkZvZ0NxZ2NEV1ZHZ1RWT3BKRnVB?=
 =?utf-8?B?Y01NcGRqdzNNaGxVeWNDYS9qTFRIbkpFeE9HOW90ZDNnT1RKWCtTWU9LWUtT?=
 =?utf-8?B?VjBSOGJqZlhTZktJRzQycmFNY3QvNU02OE13Um5QWWZ3dFhhNmdaeWd2aUc2?=
 =?utf-8?B?Ulp2YVVXMG93cWxxR1Uxd0xSN3dhOVdFekRHRlRYQUpDWjM0V09yUjlMMHFj?=
 =?utf-8?B?V2JiVVJaaVMyWStwT2pESTJlY21kSmlkZ3VMM0xzL0V6b255YndLS3pQTkZ1?=
 =?utf-8?B?SnpIN2J6VERSZkZ5TUdwSG54eDdsa3RtWGpjOGNyMkZWK1JUVklnbDAzUURE?=
 =?utf-8?B?ZG9rMGlqK2w4Zm5YTE1MdXl0bnl1T2x6TVdWQ0NCRkNTQkZNMjN1eG90dGh0?=
 =?utf-8?B?SXpiTVQvazV2YWVWRzlhNXhlQ3ZxV0VDbnpsM0cvSWlMd0xJalR2eEpGWnNt?=
 =?utf-8?B?SWdIY2dQY0JyakpqSy9rY3lDeUVkN3Q0eVUrSUFBaXRvYU5LSWZEblBjSkM3?=
 =?utf-8?B?TE9pZ2pQMzBDVUwraDVZTDJpTUxzV255blJKdTR2enErOGtYWGNjaEFwSmFI?=
 =?utf-8?B?ZlFpajVEaURIOVlEVk1BUlZMOTFKbFBid25YdHMzUU1uVE9HTStEcWdsY2do?=
 =?utf-8?B?dUhDdnovWWpTcnkzYnNjUXlWTjIzSUswNnJFQnpaU2VTdUhBakM3bGhSR25W?=
 =?utf-8?B?bTMvclVaY0lHN3R3SlZXSFBXMTBxY3QvbUdaMlhSUVlNOE9zL2Rtblh0dlhY?=
 =?utf-8?B?VFRGT001b0NxM1VFRHZZQ0JjaG1wQWZuclY3WnJEd2thMmoyRjBUQ2tweGg0?=
 =?utf-8?B?ZlNiQXR3enhjdlNjQnc5NHpndmMyMmlZczc5NXY1a204VFd6elpESlBtWGpj?=
 =?utf-8?B?bjk5UWxxZ0hnbU5QOWpLa3V1NW54TWR6TTZBenhMZmFaQThXQXFLMXBxV1hH?=
 =?utf-8?Q?hBqG22irkiWZc9308dlHOPTFvVXPU2U2fq8yYqG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0FBY3BTdmNhdDNxbS9RU0ZRdTRPenRsTmpVVkFyRkFBSEtIcHJkT0piSDdL?=
 =?utf-8?B?Ny9ucDdyZ1J5bk55RVo3UEpFMGErZiszUGw1TkE3NXRTZjNWaHh5UjNLd25w?=
 =?utf-8?B?RkxzTmN6ZE5BbW9vWkFNT09uWHFseUNleDluTUwzaTZ0Yk9BZEhMTjZtUDF1?=
 =?utf-8?B?dGtaVEcyM1M5amxWTExhQlVrclQ4ZVlSVW0yYk5zckdpejlHTXJYM2RvWVRR?=
 =?utf-8?B?ckkyc2NjaE5lWnBRL3JaWloyZmxXbnN6TVZDZk9oOGVaNXlNeTVORkV2Nkhp?=
 =?utf-8?B?dHMrSHdNZVROVEhqUU5EMlVVVWFqVVVVa1A0d3gzbzl2WGJ4RUZQaXJkTmt3?=
 =?utf-8?B?UDVudm14ME9yaUM3YnEvV05sRnBCOGhTT1E3U3hyZ0Y1RHc0eGpaUkprM1hl?=
 =?utf-8?B?STJwUzFLdkdhdmRYeC9TSGwzN1RyMjRkWmtRUi9LR1RRRGJ4VWRlaW9aejRo?=
 =?utf-8?B?Vy9TSXlrWFRDSkJHR3l4cFZaYitSR2ZZMmtEVzBRaFpROWNCdE9VWTV0YlZD?=
 =?utf-8?B?bXpDRkV5a3pWbFArcWovNEpiVTZRRXBIRVJMaUE0ZnFqRzY0Tk9FdHdLYVU3?=
 =?utf-8?B?cmRyenY0RERObU5hNGYwNFZSWDVyR1FkOFMrYm9abHJkbE5WT0dicUtSYzdP?=
 =?utf-8?B?cjRlazdaWEdoTkVhaG5uT0hzWkg4Vkp1V0lzcXFCK1N4UFRaQVBCaHpuckc5?=
 =?utf-8?B?eE4zZzlBWnFFc3k1YlRwdlo5dnJxUGZTWjFldzQzOVdpTUU2ZC8xR0JOUlRJ?=
 =?utf-8?B?VVpiZEpEV0RTTndNeG0yNkZXem5RMlVlVld0NVF4TDZWbVNRVzdaL3JCYm0r?=
 =?utf-8?B?REVZaW1zM3pLaVNpTzYwTWxxdE14dUlOSnhta2pldGNqRFhGem4wZnRibXU2?=
 =?utf-8?B?M0hCYVpaWnBJSE5CcXRUWU9WT0w3bFRvQzlVbEF4ck1ldFArUlRKNUdCKyt1?=
 =?utf-8?B?eEQwOWRwL1NocEpYVVFTdU1UV2JRNU85TTV4Wnd0ajFnRFFZMHdMaUJLWHdl?=
 =?utf-8?B?Z2J3aGkydTBFc3lmaUhqNERVQkVqVXdyL2RKd3FyZTVtb1lyaW01UXhnVFVC?=
 =?utf-8?B?YzBWTjh2bjZkU3BnVDV3ZUZyVGwrbVlhSW5adUJabUJ2WUs0M2F4c1pGcXJs?=
 =?utf-8?B?Nk4wYlZYMzVTeGRDVzBCWVdvdkpvVUNyUDRJRXBPdU82cHRRTnNGaGRUSEoz?=
 =?utf-8?B?ZjB0M2dNSlZadkViS1Y4WnpIMnNTU2hJY0tvMnIyZ1RDQmo1TFRvSVZqMVFj?=
 =?utf-8?B?elF0ekJNQk1YaUZUajlPYTZ1SkZ4SU1UdlA2ZFFXMHlyTWcrNkRHR3VZaVZB?=
 =?utf-8?B?Z2ozK0lVTi95dTRCQVk1UExEaStzS3BtUDVvV2dGeENmWXZuUEFYUm5oNDdB?=
 =?utf-8?B?T21yZXF1Umd0VGZncFNkK21xSWdlWlloemc1S0UzcEVHODJtOWNBMThMaDJK?=
 =?utf-8?B?b24vbEVkcTVGSXZWc2lCUm40SWdzT0k4QWkwL1BaQ3czNHNYeVFoM1pFN0V1?=
 =?utf-8?B?Ukh5WUNVUzMrSGRlTEx4VFQ1V2NuNHRseWFLV1l4YXVsakMyUFJ0bi9Cc3ZQ?=
 =?utf-8?B?THFVZmNRNzh0MXRlRmZYajVzcjlERmJiMjJiMUxyZ3cyMUVEeGNWQU5vaFlq?=
 =?utf-8?B?eFRVV0cwdUYwaGVtVkhGM0hHbHdzbHoyWjQzT2MwWFVmN3Y3YS9MTUdlQ284?=
 =?utf-8?B?OTA3VTFQdjMzb05xVFVDeERpbDBKS21PRk9QcXVjWFdXa1BoNVNYMDFjc2lK?=
 =?utf-8?B?ZkJvbzN4dU1EeU5GcnFQNUFqdTZHS20xdzVlWWpQYVNZdys1OTU3amhJcVNG?=
 =?utf-8?B?b1kxSHMrbDNlamlQTHMzZnRLdFE0Snl0aHg0N2d0M05KQmt6TlV0Y0lSVUVn?=
 =?utf-8?B?NUZnWmF1MTJUd1oxS2dvL3dPMGNORG01TEZDQVJheVFtUldkUSs1YVpxR0Ny?=
 =?utf-8?B?cFhsNmM5SXREZk5oYVdXOXhUazg0TXdtd1pScW5jemxqQTRZVkdMRmVacE5E?=
 =?utf-8?B?WTU1L05hVGsxSEJlRGE4RS9mSzZCN3pTUS91MUtXTXFzZTlOdjlhdnlhTEpJ?=
 =?utf-8?B?WnFXZWlNdE5qdlZ2T1ZXcVhGYnBoRXgvUkhPa1hRakltR1N2cFMwdWNCenN4?=
 =?utf-8?Q?XSocYiwh0L/ekdbmW99F74sFD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0dffea7-24b1-4338-4d28-08dc9041eac3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:26:36.7210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GvDAMoMhhyEToMuUNE9uO3s2WvkpSO99FTxMxwTyVYkT+dLDa/jkrG6XiK/TLEQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934
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

Am 18.06.24 um 17:23 schrieb Pierre-Eric Pelloux-Prayer:
> Waking up a device can take multiple seconds, so if it's not
> going to be used we might as well not resume it.
>
> The safest default behavior for all ioctls is to resume the GPU,
> so this change allows specific ioctls to opt-out of generic
> runtime pm.

I'm really wondering if we shouldn't put that into the IOCTL description.

See amdgpu_ioctls_kms and DRM_IOCTL_DEF_DRV() for what I mean.

Regards,
Christian.

>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 60d5758939ae..a9831b243bfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2855,18 +2855,33 @@ long amdgpu_drm_ioctl(struct file *filp,
>   {
>   	struct drm_file *file_priv = filp->private_data;
>   	struct drm_device *dev;
> +	bool needs_device;
>   	long ret;
>   
>   	dev = file_priv->minor->dev;
> -	ret = pm_runtime_get_sync(dev->dev);
> -	if (ret < 0)
> -		goto out;
> +
> +	/* Some ioctl can opt-out of powermanagement handling
> +	 * if they don't require the device to be resumed.
> +	 */
> +	switch (cmd) {
> +	default:
> +		needs_device = true;
> +	}
> +
> +	if (needs_device) {
> +		ret = pm_runtime_get_sync(dev->dev);
> +		if (ret < 0)
> +			goto out;
> +	}
>   
>   	ret = drm_ioctl(filp, cmd, arg);
>   
> -	pm_runtime_mark_last_busy(dev->dev);
>   out:
> -	pm_runtime_put_autosuspend(dev->dev);
> +	if (needs_device) {
> +		pm_runtime_mark_last_busy(dev->dev);
> +		pm_runtime_put_autosuspend(dev->dev);
> +	}
> +
>   	return ret;
>   }
>   

