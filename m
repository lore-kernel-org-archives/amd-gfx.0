Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEE0CD11DD
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 11:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B4610F179;
	Fri, 29 Mar 2024 11:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WdHomOVT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE0610F824
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 11:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eB97sVEhtrAs2tUYhej8xeta1LycMmboqNh9VZ+x2utx9GwhGtwcjYA766gQv6g7Ov/rVwwan6dJCHSEM2I85BfH5WjC16qGOaG/6LIzlGR7ciyHB319t0L++g4IAfvun6mn3gjzoRap8kWTxOsJ1Nf96nD/BGisuYJWLwk32P+dqg3ZjQryp29Fb2zd9mOnL1ApNWWGueY3GjoQMumsI+AzqfABkpSQ8BFBaNQ5gnNgLPSAfRMT+a8MlkYfOHmKS4heGesu0ZpMZ8DWlOdal38ryUDlw8U8Go3c1Oed2jgJSK/P89gScBXibZCbK+6j4Iz4N//HFT+aTa3IavWL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OV4O4Taz1fQVA9PKRZNqxqiXwhWK4CU/ZMQtGDNejRA=;
 b=ktA2ixyA37knCv9KfemhxHF8a9YPfZ5Rt8O8tTOIUEYwLl+OVly18NbZkihm41MF0J/xeI8xGjQZR7tqglNYKq6aL8Nx+yKW3rVcYLucJs+rF/MPruwq6f+Tpg/aNBspZbB3w5aCMhB9VKJ8Cwv9yMNOyqmkI3+Ns+0TpcF/byyMeKk/tzPSOCxaDN+Jp9S78+a91G7ztP9ac2pRB+mLFWhm5kWXUHoUQj4A3VqN5kjXF/7vPgvep6+RWZ+2XgsovOypvOGkxct2Vhq1eOwScNM9CO/APs6aAe1+B6fBYiUEIuK35cSQJwxJCMGqZmnrEDJvD3ka/9fcwmMBBPZPMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV4O4Taz1fQVA9PKRZNqxqiXwhWK4CU/ZMQtGDNejRA=;
 b=WdHomOVTdC/saOzejQV9dEkvtq+PdbQiyNeyEdTCwpnm73EvPpAFVYPLVXFc8lzjF36FZ9pjqaFLK9L8nKRBjmaG2iSh1DmqktJ1JBuubiBxdS4FiLNLdO4A2TgJoR4Dqu29fGkLLHv0P/8EweB54s+lk4jtVDjom7YH46KhDU4=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Fri, 29 Mar
 2024 11:08:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 11:08:05 +0000
Message-ID: <30c0f3a4-6705-4d25-aad6-6c72310b493e@amd.com>
Date: Fri, 29 Mar 2024 12:08:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: use CPU to update VM during GPU reset
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20240325053558.3183164-1-Lang.Yu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240325053558.3183164-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0044.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8014:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZEI1tytjED9mGFbdxrUP5sWUQrweS7IEsxMRK5OoMRAG3cOwUgJgC7BY0aC/UExEh6iRp4SWJJKkUUdakRNBTVS3UYQOIUb6lc753zfKkOimI6rP3HYzWbSyjiNzShjRW8ZUfHNnFj0Hu0JxjARqCEP/3NarFp13HGfgBBh1pW0rMNzdVacDqkR5CEVD26OiFkZfOi5ApscfCr6JUCkQFwgPQDtyCqJzs78SwpQz70vkXebqV6IsGCIyPeTc5cgYQCwt2mMiasemuDPqqsj/D2iqw+An082zUMRrUusN+bj+NMxSQY/de/Qtzw06T/vxs89r0pRpD01usRdKHyXnIevGSIUttUmnbLIumG8zXJ+7WYS76NbMLf5hy46jNEZJ4Jj6kPdQp1pJ68LZLCk1Pb/OCIKDkOaw6NqpJkpN/D90qNzWnUCFKQDUSCTB8MyfSmJ1BTKpG9uO0ruzCQhAHpUtzq0M8vGNzoOG+Y+iQfkVtUY2vR8ud1ubze36zvqbrTzWdO0D3uqeuXxeo8f1+rD32SiNo64hbW6zcjYQbuYlpIUvYnumQWhkmvEmgyzjz40gryDMnOfYQM0/Pc4S9jH2rk1Xyqwk09yDbs3szXRD0VCDAXyIjRH2xav9rZExtpF4hCbGOyGFDJJvH9JY4H9xBZag9um4U3ghAFqdkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUxGNEhkVTNudGhWaUlrbmhlOGVBZytHWFVBTHJZNWFXOWRQMGhqeFdETm1G?=
 =?utf-8?B?UjYzNFI1Zk9MU1Nlc0pHRlN3TVNmR2VmT21ZeDdkdTcxbHFydWtQNzFYa0tH?=
 =?utf-8?B?ZnUzR09NSDBLZ1dKQVZ2Rjg1TXBaNCtvT0tRaFVSMVVxcFdoMlAvRVo0cEVT?=
 =?utf-8?B?eHRJNUNNT0Z1Mlo0QXNFZ282ZVZ2eSs1MXlGNEUxdit4Mi8zQ0xwRGtCcVVn?=
 =?utf-8?B?dDV6VTN6UjlhMnJJUk50Z25QSHhPbTNUUEhpbDBvUmxSbmQrQzB6Vm42cExy?=
 =?utf-8?B?aW9SN2VaMUlhZWR4LzhkQkQ4aHdMV29HMDNwZFArdnVQVGJ3bkZ1SCtoUEht?=
 =?utf-8?B?MjBsZVN4RkgyZmJVZFkvYk9OMzA2M1FTUGJMemZiR0VFZDJuVVlJUVRha05C?=
 =?utf-8?B?Y2xOclFvMTYwRkFLaDVtZWdoYjNiNnB5Um5yZE02NkZXbjFwYm1Ed2tBeE85?=
 =?utf-8?B?VjdsYldqT0ppQ0hiMXhTS09LQ01iV3lQc2FxcUFEOVgzeVVrcm13b081Yzd6?=
 =?utf-8?B?TzFWZTJOUVZpdURITnJQcEd2bHFLZVAvWHljcmMxS0I1bkpSOTZyQXlUNXly?=
 =?utf-8?B?a1BGWHRxNlZqZmxadGl0eGxNelBFKytDLzRGc0NaS0RiSjFCMkF3MUtRM1Q4?=
 =?utf-8?B?Tko0eE14elJLOUFNdGluaExHMXIrRWZFNzhtaHJSVllCSWNNOXZDYTExdGsr?=
 =?utf-8?B?NFJJV09jNFBzcG5nVk5nTy9NMGFoMDN2LzYrV0hWRnhUMjdxN3Q0ZHJBV2ZU?=
 =?utf-8?B?N2dobUhDNUhKektwYnhwb0JhT2lRczAyQms3QkxleWZwQkQ4UHdxSWNJY2o5?=
 =?utf-8?B?TXRPTVlneU5XTkc0Z3hsY1dkQ2Vhd0FGVHVXYWFHdnUwbG1ubWc1d1l1K3M2?=
 =?utf-8?B?UHFQLzMvR05FU3VWelo2NmZiSmlzbG02Lzl2Wlo2RWowazViQnpQcDVodEpX?=
 =?utf-8?B?Tk1uTnRmWDg1eTY5R1dIaUVQSExZeVlrME1ZS2ZMUEZtOXpxTzFaMEJaVjYw?=
 =?utf-8?B?VDNYZFgrOGNUMUs0UVpMUDkrM1ZiMklvNEl6a2tua1VHbkJQUVlUeXhvZHg2?=
 =?utf-8?B?ck5tQUg5amg3MVhKdDdTcFFLdkQ2dWRyaDhJUHNVdWNUaTNQMVBITHpGOFha?=
 =?utf-8?B?WXRsZHViTGpmaGlsN0lKMGhVVEFNeVBZZ3ozdjlzQUw1Z0VxdFE4dWRHdnFk?=
 =?utf-8?B?L09kM2RFM21WQmdCS0NlbkFER3EzbllHQkxjMVd2NmozZ0ZsUy85NVNUdGNo?=
 =?utf-8?B?YjhLazVGSlVTUUpFRGhVZkxxcGpSQkVaaEhiSWYvRTd5a2NKTlNzUVlFRmFi?=
 =?utf-8?B?UHJ3RjNjUmc2Q1pHLzlhU0k1MDRjVzRNcDVhMVlNWVhRL3RVclVGc2k1UkFq?=
 =?utf-8?B?aGMrdmpNZkNTbGxpaUZ2bjJXbURSRG1WWnNFSG5ySXVUY2M0aDBlZVRWcFRN?=
 =?utf-8?B?TkVkOHZHQ3ArQjVibXNXQzFidWhZU0Y2Sjl2RUYrbHZUcEpVT2ltK1VkTDl0?=
 =?utf-8?B?TWZOdTg5eSthNkpLcVVYWWhZUzBrNXkxMnYwL1c0dWZ6eWRaTDdaQTdleVBr?=
 =?utf-8?B?NE03WGRRMnBaaTdBTm9QOG9hYTR3OFAyc2NXYkMwZkRIdzZNYi9Ba295cHIy?=
 =?utf-8?B?QzJHNU9BOWFHbEM2UytsZHZYN040YkFpL3ZnT0ZjZ1NyRDZUekdFd1RBN3FH?=
 =?utf-8?B?M0tpeUJQQUFNNVIyZHBxT3pmUlVyeUs0aE9WQnhQa3BjTUtiQmdOWlhqT2k3?=
 =?utf-8?B?T0RDZWl4VjNjYWtqUk5SZEd1MHorV1dRUUt1SWNobGdiTnI3UGFYOWF1cW5p?=
 =?utf-8?B?cG1yMzl2b3hZc0M3c0dpUkNPRFA1M1V6bVZ2d2srVzNIL09CU212bmR3djFm?=
 =?utf-8?B?VjRiZjJJbEpRcEhCelpqd2FNVEtpT2hmc28ycGNsVzRKMHN3S01ZRDNmNGtm?=
 =?utf-8?B?d2NiRHoxS0NGZVVmajdzbWZHSWdJLzVhV0x0RG1xK3pIb0owRCtiNmVmTCt1?=
 =?utf-8?B?VHVMR3hnL0xSZTRFakFkN0dkSXNNaXZkWW1acFlXVDE5MDFNbk9qV29haHJ2?=
 =?utf-8?B?SUd5MEdKU3hmTDl5WENGTktXbFNEcWZXblhVbWgzWEhOT2J5cVlMU3JtSHQ0?=
 =?utf-8?Q?Uim5mLdrfMjT8qym3Hfmc+Uw5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b25a876-5531-46d0-3f9e-08dc4fe081c9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 11:08:05.1276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6uDKqhGCeHzS0JkLSlTbQ4hn9CFX35UWYIehGsgggwbjw+xTvYulsXa8E14Lm32
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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

Am 25.03.24 um 06:35 schrieb Lang Yu:
> drm sched is stopped and SDMA mode is not available,
> while CPU mode worked well in such a case.
>
> Use case,
> amdgpu_do_asic_reset
> amdgpu_device_ip_late_init
> umsch_mm_late_init
> umsch_mm_test
> amdgpu_vm_init

Well big NAK to that.

The VM updates should just be scheduled and applied as soon as the GPU 
reset is completed.

The problem is rather that a GPU reset should *never* create a VM to do 
a test. During GPU reset no memory allocation whatsoever is allowed.

That's why we only do IB and ring tests with a pre-allocated memory pool 
during a GPU reset.

If the umsch_mm_test abuses the VM tests like this then please remove 
that code immediately.

Regards,
Christian.

>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 8af3f0fd3073..af53f9cfcc40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2404,8 +2404,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	vm->is_compute_context = false;
>   
> -	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
> -				    AMDGPU_VM_USE_CPU_FOR_GFX);
> +	vm->use_cpu_for_update = !!(amdgpu_in_reset(adev) ||
> +		adev->vm_manager.vm_update_mode & AMDGPU_VM_USE_CPU_FOR_GFX);
>   
>   	DRM_DEBUG_DRIVER("VM update mode is %s\n",
>   			 vm->use_cpu_for_update ? "CPU" : "SDMA");

