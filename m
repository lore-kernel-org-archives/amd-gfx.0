Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC4ACD1284
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 11:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF97A10FC87;
	Tue,  2 Apr 2024 11:40:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F05vDk2F";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2095.outbound.protection.outlook.com [40.107.243.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B23E910FC8A
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 11:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1I1LBpTPBEkMdbydqSY/yqKMo7wgSWuxKTslJZZZGwDZUvXR9yLaEeOpGcOZoIUmYpnyA7Be2wumQQ0sMho81PlqL+Zyp5Vs49pHiX63KK4AqEEyEEZROQ5rh40k15EWl+bwWptTnr0JKIFSffZIpuLABjmuuq02+1iIHbaqrnCUy/SCKhaOSbeeJcw4GXE6p1Q0MKzhOlCsgVz4O/uHj0rkhaYqeKybslAtgE4I/sU2ODYlXUHPircam3puhkfuaeX1O9nHm96Xkwx9zCs3uq1ximJCiet86xJ5Ph4T62JzEF6K98NCVqs7DggHPlMqTnAqbiCdx9hk6/hCF4Apg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YuKkOczKjtwzgebKxFOV7fInpHL/2o/RBV5v+DR7aE=;
 b=FnU3xQROiErl1Hc2lffDtQ4XTuikjX8p5w3sV2cwxwcDO7FgrV51DnN0nmAOm5PWwsxucJJxw9MKMhw9yA1Npi7Y1ymX20OnpbQhNY8gkxENFJbNd0F9nyJH3ujyVRytIeCVabtFXjTgf7Z6m8YRtuLZ6IWNFOksJg8Gkg/3gf26uxS8Dp9M+IIu1ei5owgXeQp5yliHih3zW0UfVyr9pXKZslTpqU97o9DgkimsspnOKclXdExYD3d2Rdnfw5QnufUR4pJ19ZZBMnQ/m9bfBiB2qXGz3SjfvRtHqRLRbOKZ0hQS6eZ0jNGOGvSmzTaaeA4jA09uQOKRnYOhNsaVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YuKkOczKjtwzgebKxFOV7fInpHL/2o/RBV5v+DR7aE=;
 b=F05vDk2FaPWPSxbLD9Q1XNDUEdv+ziSultQBSCscICQG8S1x27M1A2bPdoUCtS6o9p+7dMRT9dtJ2LlDPoJUsz2gwkm68sL9Qc+fvQ+Riia6mBSWgy5rpNHuLfxjODcpY2LE0TQCakJQD039ACMJMWH2ve/N+lWHokX4G0nhFd0=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:40:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:40:04 +0000
Message-ID: <b33a7e1f-ad28-4f81-821f-be6b34bed876@amd.com>
Date: Tue, 2 Apr 2024 13:40:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: use CPU to update VM during GPU reset
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240325053558.3183164-1-Lang.Yu@amd.com>
 <30c0f3a4-6705-4d25-aad6-6c72310b493e@amd.com>
 <MW6PR12MB88985692468C5B0EC00BC55FFB3E2@MW6PR12MB8898.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <MW6PR12MB88985692468C5B0EC00BC55FFB3E2@MW6PR12MB8898.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7745:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CwHt/T0jGmMa1o3RAHZx8lJ37HOYIx/7o+SZluJLHeK4y+ldb2bf37Z9snVzUiO0PVohoWv4Ik3cvT8flhwbfRj5Fv+fwolyl4dFII6pVDMhIkwnTkTY3uW20bLb6DtIf7Bv4I247HZfEXgnFpVtmh6eoKw/8H8e+/14yAo3yvac6RmV5MixsT/igGJow1gru1cxuth8dSFyfs02z6WR1Zqd6KcaHUBCE0sV/lDmsz3zu4sE1c1mcMpKJmthrY+u+uwROOP7J2oxwaxffQgVYp2veVQWOtFYmRcL3MGIJqQUJ4X6iCsJIa83yEdXNbVDTn1Af96F0+OSpI4hfSlrH4k8BK9zKFJjOo1E2XltLMJZy4BTCfHAJOBOlRLBzx7DwanpZXi9F3zevEijqMliz9ji6RWHCfWt81XUzEahMkFa5sIeJjdaxd6YY0K4s1t23/k4w1Zn3IHsPxUNiqas5tFR+yY/AgzloPRzdomzgg1sRMwxWWxJAOaZ+I4GpXumFpSaRgwIIg3woBto7pKF5/Yc7I0H0XdpRWdwV3ibKvCX9HZuoPv3AHbpyKwo4bdFI2sS8bm/wsgggEp4mSuOWgMrv3CQbXGX3EWJOCx0bENe7FFNNeD4nEtW205Ms8UvgmkudWLhTz6pJPplp8VBbJEvyLPdC+qB5Ne7GnkbR/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU40eUNkY0ZmeDk1QzNuZS9KWGJtS3gvUnE4TlRsNTBld216N0ZNcU5iNGtO?=
 =?utf-8?B?alZSeUoxaURub2ZMd2c1aWNZeGM5TUpjNHJnS01CUUdSdVFsNTdEZi8vTUpU?=
 =?utf-8?B?MllIVnFPaVZIbEc0c3c3cVU3SkRTc2dMWjNpeXRyZDJ5S0F1VlVVWVM0ZXJI?=
 =?utf-8?B?YjVocXhNcTZocXFFTERBb1RpcGNaYmdweVJ2bWZQUUlRMzNwUEZXQVRaVEVH?=
 =?utf-8?B?MmJxWkxxT2JOM2dpVlJVWWpLVUppc2xUZ2xDckhmeEZaQ1ZOUlc3ZkNXazla?=
 =?utf-8?B?MGhKbUl4dDJmRUZydFRyZHNSYUlQWDlhY0dQZEJndmkxTnpjRUZEZThhd2JT?=
 =?utf-8?B?VmRYMmJWbzdNZ2cxMnNCc09uVFpkZXQ0Nis1aDd6MFI5WnRMOXFhRVNGd244?=
 =?utf-8?B?Y2Qxd1Q3TjJkYmdBR2diUE92Q2pjNUgwVHE2WkI5NlZwY2FTcGU2bjZsWGFs?=
 =?utf-8?B?MStHNWllYXF2cTlrL01oc2hFNHlEdEhCSjJrNHU3bmdxSlFoWFpCelhmazE1?=
 =?utf-8?B?eDBsWGJlb1Q3anJ1bGJIZW1BSFlTeDhHNGZITnpnM1FYbkx2aGlxcVkzOVFq?=
 =?utf-8?B?enpsZW9RVzJpVTdyN0ovamc2UXVmU2drNkZiVEJxQzJTMW02N1pPd1VSOVJR?=
 =?utf-8?B?c1pOSTNBVVFmMnV4VVhPOW1xZ3lUYnltLzMzOVRkbXgwUHh1ekwvVloyU3JC?=
 =?utf-8?B?eGNldU1veW1NVjRMQ3NYMW5iaGltTUNkMzhQaFhpOThJTi9wdjdpZlpsUk92?=
 =?utf-8?B?RkRRTWx3elpaZnVzMjdhT1FLVTgwdnRITUlYQ1ozd0Zhb2lObEFaanRhbG9w?=
 =?utf-8?B?UFZpTlR3eE1uOSs0clJrcFhTNnhWWFFwVFlJWTVHQWpSbFpzQnoyTVV5dXdB?=
 =?utf-8?B?ZnU2MzlBTVdjUUdhZ3doakkrY3VTamp3djdkdGhkWmFLNW10bm5WVWxYRjYv?=
 =?utf-8?B?aS83RENLbHVuSzRYWkVoR0RvRUJxaDNGdEw0K0ozUFQ4MVJGNi9tcXREcDd1?=
 =?utf-8?B?eGRmV0xXNmxDMkFvbmZML2JHMXJCUkNCeGVRWjFIVnRwZVZaSW9tTVRDTitv?=
 =?utf-8?B?eG10ZlFzeUtWWXAzZ1ZGZ2pWK0V3endNUWxkZ3BNbTFlalVNRW1SMzRaRFZM?=
 =?utf-8?B?dHdENG9DM0lqME5DZG1TVDlwMEhzUE16TGFTelFqWnl1TnNaZlpGaHF3VUxG?=
 =?utf-8?B?aGptTnZCUVNsT1h3TTJubW5OaVFNYTdXSTBwY3A4aFUvMTMzamFjbFE0aith?=
 =?utf-8?B?V25UckR4WHpYVVBBeDYvMHkwR1NRV2t5VmpFN1ZjaFdLblREb2kzYkRuNFUy?=
 =?utf-8?B?Vy9XRlZYdCtNRzVuOVEwNUNGV0lxN3pSMkZHa0cxYlFPeU95dGEzUWtPcG1G?=
 =?utf-8?B?ckpDbVZ4ZjVLK1JmdVV0WWtiemZQdW42a01YUllpNWxqakxzbnVwcUYyYXlK?=
 =?utf-8?B?dFAvRFlxQmkzOFF0M3JsRk9wT2U5SFNwK3JmK1I4bjlqb2dhMG1yTFNlT29P?=
 =?utf-8?B?ZWFoVEdoWjJDMVdlaitudnhCenhhdUhwR1FFellVY0diZEVqVVE4N2lkeTVY?=
 =?utf-8?B?M0pXVGx3YTZwLzFKTjhFZDFVN0dsTWRlT09iZFVFcStwWnp3SlJldkhHZDI0?=
 =?utf-8?B?QlZ1SDJmMUxTYnZta3l4OXkwaEN3cjAwcUdraTNsbkNaSW1yRmFrQ25Ea3Jh?=
 =?utf-8?B?bndvaE83RExPalJnUDBxWW8vU3hSWnkyWTNyMnRrbThuUkJMQmluQWUrbUxY?=
 =?utf-8?B?Nmlwa0t2RGRUVHd4V29EZ3F4OXBxcGUwMUxHaTFkNzNqVkdNRGNuNllleXI4?=
 =?utf-8?B?TmkwVDRCNFNaT1g4ZDFZalZzZWZTaWNZTkxqUnBZYlQ4U2dTaG9ITnpiSnd2?=
 =?utf-8?B?dGJvSjRzSmV1cld1ZnRNUkxJV3dSak1ENVB3N0cvTmFJZG9OVHBncHU1b0dw?=
 =?utf-8?B?YUIvaE1rbmladEtLeEdlemhvUjk5WnNRL0prOGNsSm1EZmpuN3BtR2p6Rk9i?=
 =?utf-8?B?WWVveGtmMXMvbnBhMWNxMStsVWtKejI4Q2haWTN2YTJLdUVUTU1JNEE3WElI?=
 =?utf-8?B?aUpFRktQa29kbUZYcEdoVTdJVCsyenk1Q3RDNXFBOGJzc1ZRU0RKMTArNFJU?=
 =?utf-8?Q?jJbeivUVaGUnGArq+4vmpa/8h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b164abf6-1d5f-43dc-6c22-08dc5309a39a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:40:04.5316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njz+Ti10nDgOAc7//dW9u6nrJzOO/6HpruQR+N/sAb4a4a7Gzkv+2PitkIRWRcF4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745
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

Am 02.04.24 um 10:47 schrieb Yu, Lang:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, March 29, 2024 7:08 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 1/2] drm/amdgpu: use CPU to update VM during GPU
>> reset
>>
>> Am 25.03.24 um 06:35 schrieb Lang Yu:
>>> drm sched is stopped and SDMA mode is not available, while CPU mode
>>> worked well in such a case.
>>>
>>> Use case,
>>> amdgpu_do_asic_reset
>>> amdgpu_device_ip_late_init
>>> umsch_mm_late_init
>>> umsch_mm_test
>>> amdgpu_vm_init
>> Well big NAK to that.
>>
>> The VM updates should just be scheduled and applied as soon as the GPU
>> reset is completed.
>>
>> The problem is rather that a GPU reset should *never* create a VM to do a
>> test. During GPU reset no memory allocation whatsoever is allowed.
> But user space can still create a VM via open("/dev/dri/card0", ...) during GPU reset,
> driver doesn't prevent user space from doing that. So is this reasonable? Thanks.

Yes the UMD can still create VMs during reset, but this is completely 
unproblematic since all submissions will wait till after the reset 
before they start executing.

This includes both VM updates as well as userspace submissions.

Regards,
Christian.

>
> Regards,
> Lang
>
>> That's why we only do IB and ring tests with a pre-allocated memory pool
>> during a GPU reset.
>>
>> If the umsch_mm_test abuses the VM tests like this then please remove that
>> code immediately.
>>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 8af3f0fd3073..af53f9cfcc40 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2404,8 +2404,8 @@ int amdgpu_vm_init(struct amdgpu_device
>> *adev,
>>> struct amdgpu_vm *vm,
>>>
>>>       vm->is_compute_context = false;
>>>
>>> -    vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode
>> &
>>> -                                AMDGPU_VM_USE_CPU_FOR_GFX);
>>> +    vm->use_cpu_for_update = !!(amdgpu_in_reset(adev) ||
>>> +            adev->vm_manager.vm_update_mode &
>> AMDGPU_VM_USE_CPU_FOR_GFX);
>>>       DRM_DEBUG_DRIVER("VM update mode is %s\n",
>>>                        vm->use_cpu_for_update ? "CPU" : "SDMA");

