Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F133EC61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 14:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B3810E00E;
	Fri, 28 Aug 2026 14:12:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rWQgSBme";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013019.outbound.protection.outlook.com
 [40.93.196.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B858F10F3C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 14:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozWaah2eCdBFKoBRalLbGTCQ1RSzcNE2TuYqPDal6jp0Ow23NHTfsKdz9bHaR50e/ZYJE0aK0I+YNEhDJ+TWeG00ZDOJtPinbpwfvd8g7zn3CAb+fs4PVo7lBtoja9eb2V4MBOEcd3Vl+/t0Jks8cDFVqYe/vzo2PovLH48Kkvih4z/S92Yd3DaPYCSpbuU0GFikBz8YZccAJ4KrjT/hKjr2kBN04GeJzwfGsqLWIwRcQrZY5+aY60HxdhKeUnSv69oy8RcQDUQXdnpAu/PeJvCCYyHCF3fUeuFPr7ESAvSpZgcdSztv4CI5fix4Jr97tmVNhzAu3Ve14CWVrCVIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtOdt76Zk8eDDFFjGxyHtDg4BxaIeWZSDJnAKDT4ZA0=;
 b=jR+bYbvxDldsakkww+a/+T/xDH0qpe8Rjvl2DmfVEcURZtS5SsR3sbTEok+G4gLkxiqUVgTGyfG3fbspb7I4Rr0enCL9ar7tfvoHHKeXCOSRClg7BMHQdMYoEx9iR6itEZBdMEthcKOcot4/yhQ1pbqg81KyVICtuwOvxmtiZRI8do6YIJYuUo+RXVEs5dkcjFxRTyOwf1wzrY5NtedgkKRPZW/d9CXn9RasvSboJdRgPbOeXSBNrIRx1yWu/UT4q1Ree7v8W869U70MQCMa7867b7i3IN9iPaDw+iMMgEJ+XXQjqp2SpIg54e1PN3aupw/zUCgTSHdC/csjVv+jEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtOdt76Zk8eDDFFjGxyHtDg4BxaIeWZSDJnAKDT4ZA0=;
 b=rWQgSBmes7KpoGk1ClCzmxbgRAXw0wvCKqnEiJEHzVoOagEyIDf2+2K2b1HU9iqYrF4D9rcTi9iPS9h7F3PB+BOCJiKxJZqpn3ibIzysfP3L94e7k8m/Oqu/KXMxWrXAPdT89SCmexWMswkh7Y5q73Cuv2x/JZqdQiNGK+BZf1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Fri, 28 Aug
 2026 14:11:52 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 14:11:52 +0000
Message-ID: <efaaf188-bfe0-4fb4-9a13-23cfe386367c@amd.com>
Date: Fri, 28 Aug 2026 19:41:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu/sdma: In legacy queue reset function,
 check if KFD is initialized
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
 <20260828120729.25908-6-timur.kristof@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260828120729.25908-6-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0180.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 797b9a50-8b52-4bb8-0949-08df050e4ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|5023799004|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fOmHIGseq97+VnX+1KgkpaWm3tg9dsbRij+7TD6p9JR5O1Uf//ZI/5eulWUtvZ2HdlyQwjLUMtuSOwESEk5bjRh48H0Cr/lIv2ejCCtFDnRztAdEWHYO7GkRHOv8taCg05z89g0AEs2+XrVJUgY+fz/5QiCQWX+f8ZGlDvWbQmIL0tyoNLqO5MEXYRlgwOQAwxZ2nJ+e/M1VzAN64JlHMlvAvgBExQ6hpvY2WFQV3ca33BIE/1OGGY5xYFdwfhB871WnVijMCjE788xadwfHmYPILyS42hpfvNE7GHblMmN0lU1+gXr6mrPeFAb3RetvEKwC38ENzaenSdUtj377LMPFwFmwip0bl5KtePMiP8cf/jOh/3xr1ewOTHCwLf8RrfNNabWZGdHT4gy4rEWVdaf9dUGR+6rl7l6PuRqvchle0Ltu80lu4CVYYvcbY0g82uFzaWnxINSToelTrZeO5edLvDVCPQOogcSggxIsk42WMEYLQlxaoEkozoX/hQ35hB5y6JhAWdiGYIT+dm4Sv/mpjgumm5oYtNvBrAfbtT1BdZ3ZCtpi4iYPPE3NqWr8EpFcPU8idwQ3SXxG1wJZdFM7NHcvNiiwS3s7QkWL6+o6f+9k0UtbIY4hLMZkf6RtobvACmOiPKhBPwjP1LXDdBtyR+6VKi4AGiYgQnlPGek=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(5023799004)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTZ5WDl5ZHFuWCsvUWRqOWRJcElURnNveXcrWkxxcGpuVU0zeE8vNUpuaUJJ?=
 =?utf-8?B?c3V5cXRTWURHbDlBQUtWcTJpcytMcGlSamdHSXhoU2xvNGlDTVZhMDUrUE9r?=
 =?utf-8?B?Z0tDQTlHTTBSQWpTcFM2anR2VW9yMk5jTitpTG9MU0Zha2VvT0pRQUxUbFZC?=
 =?utf-8?B?VGROeFRZMTJyWHRleEk2cjlBVWlGWmNnYUg1WHJFbjZaRFZPWVlOSGpaV1RG?=
 =?utf-8?B?ZFgyN1l3QzR1cm9iTTlkMDl6YjBUOFgwWktOL1Z5YTNQVFc0eXVSTTFLQjRQ?=
 =?utf-8?B?OXprRHJpSGx4bXlDS1lWdWduMUVrL0lxOER0WUQwSzRkTTl2V081VDlQUGNo?=
 =?utf-8?B?SGlNV1M3dXJaR2Q4U1N2WVUzRXdtNGE3Ym90Y0NLSFpwaTFkenBuTXUxYUU5?=
 =?utf-8?B?NmRoL1BDUytjdE9KdS84ZGk1VkxkeWVwQ3hXVzMyc1RKaGhhTFBzOHNyRmdh?=
 =?utf-8?B?UER4SkRMUnNiZE1MT25jWTZHSUJaMElEejFKenVJdWVEbnpPL0JyTG5CREVj?=
 =?utf-8?B?N0JCcW1pdWdnRS80R202ZjZNc2dWS1dvTmtjY3VKaUFJSWZjNjRWbnE1TVhZ?=
 =?utf-8?B?MFRFNlJNaFhsb1VvVVlIVnVDWHVSMjdab0lPR1kvck1LZUw3djhmUDJZM0Nt?=
 =?utf-8?B?cTZDcjZ6VTNaVkhvME1MNndZeHZWQjBhTllpL1ZnOTJ6NzQwUDZEN3FUbUdJ?=
 =?utf-8?B?dmMzbjFUOEdVUzlhMVBSZCtJck56SGlYdHVDaW9haWorNGxDTk5EZy9WTXk1?=
 =?utf-8?B?QUpQRFBjSnFqbFROT29yM3BHNzhONndacU1wcEI4cVRtK1ZnWXBKUVVqV24v?=
 =?utf-8?B?ak5oQjBiaHIrVGZRQmdab2d1VTlMdit1Z2srdFFBYXlXdUF3NXpuSUQ4YzA3?=
 =?utf-8?B?QTEvUlR4d3NpeEt3UTVQMmdQZ3ZHODU5Y0JraWpZTkh4VEJFUCtMU0dRVWRF?=
 =?utf-8?B?N0hreSswQmovRjBtNVdFMFJmMkxWQVRIZGxlNGc3NTNWeE1vbEw3a3JYY0tL?=
 =?utf-8?B?UzAxTGRBam9KRHh3SFc1Y0F0TnVDc3BUT0Q2S2p1c2hUd2d2QzV5czk2eEYy?=
 =?utf-8?B?eUVuQ21mUWhLbGRlSUhtY2ZMR3hnclMzSE1HTVNHMk5DT3lRakxNUkhUc3NZ?=
 =?utf-8?B?b1Q1TzdKZVlkdmlncjBvMVVzaVFES1YyR1BuVzk0WnVyazdrSEVkUHFxSWlC?=
 =?utf-8?B?d1J3NDlUU3hUSHVrZDYxVWtXQm1hOFFZT0Z2S0JzenpaTW11eEV2VnFQckJV?=
 =?utf-8?B?SnZhei9wMkhVbUFHaENHaEtYeVlycldlSC9CWEJlRjZmVDZLWVpDMnFvcmN6?=
 =?utf-8?B?N3V6V1U2dEx4RGxrQ2Z5RGNSWFU2YzB5SThYaU4xYkZlRDhXQWw1VnIraUJH?=
 =?utf-8?B?RUtqK2daSVUxakh3Z2lzSG5EaFZSaTNsaGt6QmRPbmIvcjJhOWc4R1pyYkhD?=
 =?utf-8?B?OFRpeFpUbG9OMVFLVDM4TVFGRGVxS3JTY0pkTTRFZURDUkpWME1BVk82c1h4?=
 =?utf-8?B?R0VZRlNoYmJzeDhTYzM4NlBTemcyZUZWMytyclBCVGpUaklpdFhZNFlBU2t5?=
 =?utf-8?B?V1dYaFltMjcwL3BPYURVeEhOU3FNSGtJNTM3QS9NM1ZXbXlXOWEyQjBXQTMx?=
 =?utf-8?B?bEFJWXBhV2hEVWZ6S3hCNGZZMjEvT0txd1hRZkc2ZklzTExadCtxYzA3K1NN?=
 =?utf-8?B?WmxxYUtDSWt4c1Z4SlpzV0N6TzUyQk9mKzkrTWhTWSt0TThseFJXSEdka1gz?=
 =?utf-8?B?ZUh5OWptUjlRRFY4MWpJMU9iMFVTdHpGNDkvckd6WWd4bktURkJodFRUaGVa?=
 =?utf-8?B?SjA5YkFaVEZXT2R1RzRwSGx1OWE4TXBzVlc0UWJEY0x3ZGFPZldjeDV4Zjgz?=
 =?utf-8?B?bFFzeHhBQmlybHA4TTdIUy9KRHQxNXgrN21IWTBCbFRRZkppSjk4Q2U3bURM?=
 =?utf-8?B?SlNPUWFLMFE4aUhHRENzU2MvYjJwTTc4b1VNSDBuS1BTTDlsdW94aXhEZGFN?=
 =?utf-8?B?UE1Rend5cnc3WlNQckh5MFh4MmNGU0pzV2dmdTBLYzhIdU1DMUFBVUxISEFW?=
 =?utf-8?B?T1pYTmw4TnFEaURaa2E4clBXUHZJRjhWR3lxS0tVREFUSzkyTFBoazdqWFFr?=
 =?utf-8?B?YU1YMmxXRUY5SDJoaHdpamRURUdScWFiQk0rRjl5RlM5anM4UjV4KzN6bmZx?=
 =?utf-8?B?SDdyNHJFUEZUWk85bUJacWNDRVNLblpsZk8wd0tXUXR4VGpZM2ZPeWE5QkZ6?=
 =?utf-8?B?eXJxVnozQVM0RjJTeFVKdnk5ZGNDNExaQzV2WHdvTTJwVmlmNXhuendtcWMy?=
 =?utf-8?Q?iqNiqjtt+dyd+jyANi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797b9a50-8b52-4bb8-0949-08df050e4ec9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 14:11:52.3657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1/uB4jGvlCKRfq+MjBjOAFjHj0YQV+9AOuvlbonmOXhcmDpkUXqaPZkzZFe/gps
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360
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



On 28-Aug-26 5:37 PM, Timur Kristóf wrote:
> Avoid calling amdgpu_amdkfd_suspend() and amdgpu_amdkfd_resume()
> when the KFD device is not initialized.
> 
> This allows the function to be used on GPUs where KFD is
> not supported or the support is hidden behind an experimental
> flag, such as CIK, in the future.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 9eebd8380834..8798caed1ff1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -664,9 +664,14 @@ int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
>   
>   	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>   
> -	amdgpu_amdkfd_suspend(adev, true);
> +	if (adev->kfd.dev)
> +		amdgpu_amdkfd_suspend(adev, true);

The right place would have been suspend/resume functions and that check 
is already there.

Thanks,
Lijo

> +
>   	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
> -	amdgpu_amdkfd_resume(adev, true);
> +
> +	if (adev->kfd.dev)
> +		amdgpu_amdkfd_resume(adev, true);
> +
>   	if (r)
>   		return r;
>   

