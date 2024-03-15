Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECD4C54E66
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 07:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D089610FD87;
	Fri, 15 Mar 2024 07:16:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tSGDiPMX";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F1A10FD87
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 07:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+PGVo8eiviiqJigG7PYMJniUalI/X2irO7qituhze5l3jn1gxFJ/B/rDyIWVCMYvpBzkuStawp78DimAz00Y9v5573r2I0eyy7UP/MEFtvczUtqcG2RfjMcR6f4hgZ9uSwXaIpARi4h4o/hZ5FBEJ/ph18KQ28Rda7EAovoY12+inBOhNoDS+ye/a7iiHUmYB8C5/dJXLfMbZYGrMieOQQMstos2ccNOhHYDLZkldhN8sTWrJ1EEY1HzBHM88ZqEGqWSbul/D/x1C9ZMQpiLYYuSNZTmUOTHLAcSudukFtkDsZEw5fJc0ZREa+L3L5770dYoN0ig1IGnwmaTtPKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0aO0rJL20dHCVSph7F9iEVRe0g9K26kXcmuqksc5Fg=;
 b=a1hkqaifgbvLCLRoil+NwOeT9+2ZMkMDV6pCjOmW04UHMhAVhi9m+iv8BTr9Q/63EYXnZKxtIRee1MiG6p44JvZu6i+YUbulTBtwUCUlHgh4jGNOwI9cVldG7+1Dv0ieOmj5U4/1C+OkRC1u65uqYkM52LYzy9R9D9riSWgKOQh/0Hy1UZ3oYM0eATRhpjNuTf0cvZogAXScK/vMvVdxeVT/IAkBYErCDZSb9Nl/s3FfYW1HEPFKayAsxadSTZqZZhFiUcO37A13ALWIVMSz11Lg0KfIOckQ4PyttwYC/aC4pqOaumaNVVWXBId6LmkeeVkhdTQHo2MRzmK7aJ2whQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0aO0rJL20dHCVSph7F9iEVRe0g9K26kXcmuqksc5Fg=;
 b=tSGDiPMX7G8zpobNYw4Y/ewMWo7Klgqt3bQfxAt9CNkitWeGrF3eMeFWQrJ8j5Fo9CohWXEE2mF2ivZAMffOwA3AJQf8H9rf+KjY7VyihJ/cPPClXcLE+0t3Dpq1rzFWwmh7n54r9VqjV5k3cw8BPvYPa301l1tl1iQIIpA0/2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.39; Fri, 15 Mar
 2024 07:16:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 07:16:22 +0000
Message-ID: <e9917d19-110e-4523-b268-8e79698466e3@amd.com>
Date: Fri, 15 Mar 2024 08:16:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix the iounmap error of rmmio
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
Cc: srinivasan.shanmugam@amd.com
References: <20240315051725.2450734-1-Jun.Ma2@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240315051725.2450734-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 6419b695-0f55-438c-59dd-08dc44bfd146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIzF4+WG0EUadPJ1Z6Ws3i9jsPMU1HpYVB8EXnaEWIQGc84/t7JD1RxaP83jsqhX6f58RlUAtfMtLVwooftzPKmxDy9ufxIlH2zG9x/VfthhKXFhZneDrXZDhOoBQFqk283nAGC0sH2IFblzdBIf7PjCYBMY2WPRhigzPR6LG3X92vZF3N+yo59FynxvtHRJNffdHqmHFReVcMuJT0z+WTvI9BDh2Ty7dvEZ7oy4XxQIS1r2fdB32cpbZLMN14hYIl1CgPzHtX8RIF/Fn2cpTBzw5YfhzGZjrvIn4c3j/5f/DY2ZTE9mHYSGTqUoXkWtkMjLl7jp9kL6kBF8gFHAdmfyIY/B0XZTkjrdZoWDTPtr/DbUGk9mR36Ryv8HMFh5SZGqG7KHHFWwG0bHmBe/jBtt3xP55C/ibLSxKeRdcWWbxeRtrIsCYxm11flyML6AWc+UTrhEEWidLkkaiCdEmu6mFsvc2MOq6zV+U3nqzJt2wI5G1wyxHUUgTfScDCyj9AsvuKhtRIJnjkfeahsaq7L0siMu5H+8mxyqyN9adG8I8Wr6XRYoh1Z5Yq0+243QLHXmZIqaT5g9hInAOMLH6l3/riWbTlUg8rk32v9oCFGMJkPPe+OqiuilL3lCWGbOmNvN9Xu1ugrHqKLTjT0cm9SqPSljv/Fy8b+jAr2acxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0FNZW10TllGdUIzN1o0N1NoUjJaTzJFNm12MFNhdnZ3N1lUckJYN0FNVjFt?=
 =?utf-8?B?VVYzc1Q5a3pZYTBGV2RIc3hLUFA0MjM0c2l5R3RRdDMzRWJ1bHZwYWFRZHNr?=
 =?utf-8?B?SXVUUTRQcWtXS3Z1TmNMMDZZMWZzQzE2RmJwUDF4YmEvSGQzWXpVbmg5TkVM?=
 =?utf-8?B?MjgyUCtWNmRIMGFOajAzV2MyUGE0M1pqUFNUMkFnM25KbWJkWjlsSWlId2JX?=
 =?utf-8?B?YWxsVGJaMUU2Y2phMFd5MDBQN09oZ0UwWm1mVVIvM2VjZXU1L2JnTlFmdnRC?=
 =?utf-8?B?LzNHelAyVHFkd2xGVGVudmh1L29GdkRXeFpoTDlZZjRDRjN2SVRTWnlVNjE5?=
 =?utf-8?B?dnZlNWoreGtwRGJWcTBsQ2syQ2t5eUk3dit2RFdwUkZSbjhYRVBWcVgzSUd3?=
 =?utf-8?B?c0dMdEhjTFZneGVSb2VrVWRSWFJWaDJMSk9McTlobytkczJXajBtTkR2cjJw?=
 =?utf-8?B?STNDY3FZYXJMdkVLcnNSVTB2c3VacXBYTHdBN1NmN2ZwQUYvbkNnMExpSEZ1?=
 =?utf-8?B?UmJlQXZOUG1QV0xBd0thZXhtV1JKN2ViM3pIOForMHpoTk9TMmtmcEEwMTRk?=
 =?utf-8?B?UURvdDlFU21Ud2UvQlJyYUVXNzBhaHIzSzNtTUkyb1NpVmQzZkFDMGV5aDVx?=
 =?utf-8?B?NWl4YndleUdXeThzRjc1bks1cDF3dG92Qlp2OVAwZ1Y4WVVYdjZRZWdZTW1l?=
 =?utf-8?B?QnZCNVZRa2RDTzFjb0taZGV0dGlNUmF6WVFiY1hyVHhxQzZOMkd1RXVWT0Ru?=
 =?utf-8?B?Mll6VVdicEhEM0Y5YU5PVmFPajZSOVRpcmZZZkNiUzkydnd2WU41WlpSWU5F?=
 =?utf-8?B?cmdwckZpZHIvbTFiWmszVTJwaG82R1dZYTB2TkxGZ0NJdGZFQy9MT29BWXlz?=
 =?utf-8?B?N3RsQVh0RE5BaWs4UmJpMlFzOHFmbHE0TlBMa3ZNSDRRK1NEY1FOa0h5V3cw?=
 =?utf-8?B?OTJWaCsydzc3b1grdlFPN29TM251OEJvYWIrbnZYTndxM25qTU1JN1VkbFdo?=
 =?utf-8?B?dkdkdi9wT1BXekNhd0plNW5nLzhmbldIcjE2cU9EK3ZmWllDZkJ6c3hnWlJM?=
 =?utf-8?B?T29FSkN0eVliM0plMlJ3L3dQcDZ1YVlNdkJoTDloU2NnQzN0TUh4QkphcmtZ?=
 =?utf-8?B?dEhjWVRxQTVsd0VZYW81TmVOOXNINUs5WFpYbDVGeTdWTndQb0pGQm1ZZlRF?=
 =?utf-8?B?NEQyNEQvY3VycUFCOExIYm1KNWlSTWJZcEF2QnZaWmRFVEN5R0JLZy8xbzIy?=
 =?utf-8?B?SlJXWC82L0owWlVuTzFHWXUzTDBOZVVYVlE1aDdraHVaUXRCT0szZUZEVXVn?=
 =?utf-8?B?ektrTWVMbnM5MTNsSk1PNmR5Vk5OY083czN5Z1VBQ3Z1WGNuY2tOSitNaGxu?=
 =?utf-8?B?L0lUU05xN3hCQ0xjaytueUtGdFpWTkVMTHUxcWNXUFcwYm01UUp2MUxIQlZF?=
 =?utf-8?B?by9MT2dPcjF0ZG9qMWJITXJwaTA2TFNFem83ZmJtVythZHAyWFUzalBwNGor?=
 =?utf-8?B?NUNsN05TV1gxbktYb3BzQmhXcnVoYWxzWjlubHZCM2xLajErdGJJWWlkK1F0?=
 =?utf-8?B?U2NrVkNOUXo1dCt1V1VDOGZlRUswWVZ4aWt3cDdGd0pzd0lrOFNiY2lZZmZQ?=
 =?utf-8?B?SnZlNWphK1FBamFQTC9IYmQ2RVFvOXhFaXg5MWRmNTlNb0NHM1ZRQktDRFV6?=
 =?utf-8?B?SDFKazVYRlJOZjBUTkpIbk94NU82NXdhOVdqTm91azdqRkZIcU1wVnZxTis5?=
 =?utf-8?B?NkhDTGluQ1E3dEZvT3Q0N2Z5SHMzMThFV0M2V2trbzAxNUVTWXEwdVU3d1o4?=
 =?utf-8?B?emtwN2ZyTTJGMVZmVm1JQnVUK3lyNHVWMG5zdkljZTNzbUpNTXpuZWpDeVNs?=
 =?utf-8?B?dit6dU1BbjNKSy94M1JVc0ZNakhSWU5OczQrSWR3R0ZEa0VCNStaQ0lDNXMr?=
 =?utf-8?B?ZXhLc2xqSjk5YjBNNVQvaVdHSndiKzVldU5zV0hDMmVoUWs0d3JXZ1U0eXEr?=
 =?utf-8?B?M1J0anpQbDZDMW9aYzdYc3h0V0dHczhMTWRLTnBicUlPNzdrMGdjNFprc0tz?=
 =?utf-8?B?WGRPVWhwYllHOWFDaW9YUXVkTzByUVV4TFZQWmlpSm9CWVdtRklucGVncVVY?=
 =?utf-8?Q?B9KsHysbKUFarQQlzf60SfZYw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6419b695-0f55-438c-59dd-08dc44bfd146
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:16:22.2804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZuwW1uWC/gU0UndBYZyBgriwUG//1NavLBOg/9cvAKbmcYpocBJC2mOFxrvPgeT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209
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

Am 15.03.24 um 06:17 schrieb Ma Jun:
> Setting the rmmio pointer to NULL to fix the following
> iounmap error and calltrace.
> iounmap: bad address 00000000d0b3631f
>
> Fixes: 923f7a82d2e1 ("drm/amd/amdgpu: Fix potential ioremap() memory leaks in amdgpu_device_init()")
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 39dd76e57154..d65a6aabefbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4383,6 +4383,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   
>   unmap_memory:
>   	iounmap(adev->rmmio);
> +	adev->rmmio = NULL;

Well that doesn't looks correct to me. You seem to be working around 
broken initialisation code here.

>   	return r;
>   }
>   
> @@ -4514,9 +4515,11 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>   #endif
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {

Ok, well that alone doesn't look correct to me. The MMIO regions needs 
to be unmapped independent if the driver is disconnected or not.

> +		if (adev->rmmio) {

That looks just like a hack to me.

Regards,
Christian.

> +			iounmap(adev->rmmio);
> +			adev->rmmio = NULL;
> +		}
>   
> -		iounmap(adev->rmmio);
> -		adev->rmmio = NULL;
>   		amdgpu_doorbell_fini(adev);
>   		drm_dev_exit(idx);
>   	}

