Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D91AC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 09:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AECBB10E0FA;
	Wed,  8 Jul 2026 09:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xPzshE1R";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF57610E0FA
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 09:53:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zhp7JFv1Zlb4/P5xTJvAP7YEmMGy6xpzece4hKaQUqkF6PpesXmK/souprrai6du0zTjtvhGhsaVUIjD6EoQl6PVpSh//918Lh21t6s9G2HXI5OzYWY2JbIwpmUqHdOJWcg0wGwZkqDAW7P53PCThUqXIGMox18IUj+MD8Y+Ve8LuBI+ozPQnRITESIY2Qov2mnQNXqERWn7m7trBxUmDmsjAryH75yVpHSHWBhvhx00KC/sDvmEjr3p5UPNnIi7DnOcqIs7R5BZxmPN2+q7lyoo4mSJiwqCZUcH6z94cdrCGfb4GsVBj8vUkNgvymvpK/wIsCzdeX8L4T3eK7ksCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3TUBMl1PWWuO2K9qIswsfQW2jsd+taTtg9XqRabKdo=;
 b=f7iiVLrzdFteYq5UpfSxaxlyCqAjRD9J6GWybyf/DZkzBMj0kMXhQsYMm5dZ64oETQ30hhT9FHnxGUnlRCk+er+2tXfoVZmyrQl/805RiVoys54ame8ZJWBzPhG8w1VNPokw2CcBCnmboiMytUgXOufyT2bbQI3IXfKOTLFLLti0NAH5cL6bxVLK+6xrQUvyPm79//+A/pxt374Q+RXHoqHvOXRBkksKKR2mfqXbqVn5icq5nQsmNfToQbbO2OAi1+aB9kk/AlEi1pOhev4XmmKg45M2JDrSbOdwvvHMCUZgXueuYt3/IJhtyAF1UBJsd2LArK8gRTnF4cp+Qs9V3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3TUBMl1PWWuO2K9qIswsfQW2jsd+taTtg9XqRabKdo=;
 b=xPzshE1RDO6jPUUwkf6cla8gQUF3/OCLDK9brP+kQJ1eUc2XVmO82skszdu1NKlziqhhLYPxOYHIMw36m29Otawoe+ml0t8FmkR8m2R7Li2E1WfSg5l+VyAjLaRo5wW/f/EXt8HQG80/bzSG2KMofHsGqxREcC+GqyEKiaLxQCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH8PR12MB999203.namprd12.prod.outlook.com (2603:10b6:610:35a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Wed, 8 Jul
 2026 09:53:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 09:53:40 +0000
Message-ID: <3ac3c6d5-8fad-4b0e-933d-42fa71a43657@amd.com>
Date: Wed, 8 Jul 2026 11:53:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in
 sriov mode
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, Cursor <cursoragent@cursor.com>
References: <20260708083035.186400-1-chongli2@amd.com>
 <d3ffa862-8fff-40cb-8779-97d3bb4a429b@amd.com>
 <DS7PR12MB5768E74BF2292A0F8F87E0CE9BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB5768E74BF2292A0F8F87E0CE9BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:36e::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH8PR12MB999203:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4e2088-4d34-43f0-749b-08dedcd6c9b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /ubMc2+1uhhkCbj4FKo6xiqszisdT2eboav0a2mliY1nmnATfM02VBNJW4cXUiDB5mZnekBJDQR/itqYqm3tS+iAG225EEVVr09NC2UJSZAUny42bymrCuS+z3kbO9hHWLkdZc+NNvNLPjKkK8QSP/wFezkDOPFZITTj5sr4owjNALB3PQjJV+A+ctB5GGSAU5vVDnNhdhnlCTR/qo+hoRKG3fOvLBhB5fHf7akHHZpLe3UaA/ZffDuVarV9vTtuMXZ/gfuDttpI3AJYLYXb+iA7mXBKblvcCyYDZ7+d9E7DLOzDtb3hkCRsXLKOZ3HMFHT0k1vxxxD8E2cGR3OroZorxGHdzi1Dtz3lKxzbG0NFgc9k1XFD03kRkoAnZqXetOZjWsySLECISokmFf1CBxKzhnZYv8/4RR8+9rL5YR86qVUVjmM2di3iP5JqZT8WJMTvk9oI14kADJjOsG3t9ZMYK3JN5MDLqRX6zde4mDm6DHUcuaVRp92Ji60Y8Zm+mc5w6p4yr6aBxCgRQEKd4uIp+cTGAdCySMsuynYhKWFPw6lNnKDyFAGrJYHaxmmHfEklJemVYz8Vx610pbmVkBlE336NZhyl0DddbPxJFgXXs8h+0BNZnK49jfvwTtKGEXjqaLFq3Hy0smYW9tdbNSJQgCG0BFNkwXOTD7G9GoU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sy95YU1mcGZ3SEREenJ3cUQyK1JZWnN0T3VhR3RDbDFFZTNmZVVWUmdRTGtM?=
 =?utf-8?B?cW9OcHFsSm5OK0NBZzRveFBLN0RrWCtFdjgxVUZQRHJqbG1IZWc1VlJpUkx5?=
 =?utf-8?B?NFZhckJHSk8rV3pmVjJLMWNlVEk3eEpjMlFRRUFvUUhhWVNYK2U0czdlZGhS?=
 =?utf-8?B?cncyNzFQeDBJdHFrRjJwL1drNTFrTHE2TGdYYWJEVFJ3MlBKanhNWm1nVUMr?=
 =?utf-8?B?Nk5Nb0FELzNOS1E0eXc0MFladmpsRDNyUnNLNkpHaUpRTVVQd3RYUldoTHQ3?=
 =?utf-8?B?OG1aMW5JL0VaU1NsVWV6TVA1eXNUUHNyZUVzRm9FbTJXMW5BcDFKZERKaGNz?=
 =?utf-8?B?SVRibjRTT3lEYWVFQnluVkFlSGRndXlPdndJUDdRVjBCZXo2ZE5VeUxRU1g3?=
 =?utf-8?B?bk1IekI1TS9vSjduNjVuMExYME0yMmg1eFlGcE9qNkpEUFVHOEZ4RFZ1blBM?=
 =?utf-8?B?TnNzdk12Q0xEY3R5RGttWkpiL2xPV3VTTEVOd1lydW5qV3FRa0RseThlRE1H?=
 =?utf-8?B?ZFE1TEhSUUtxQjRmeDJML0NGbnExaFNYWXhFRGd0OGtZY3lKWU1kV1FuRG1t?=
 =?utf-8?B?dXpzOWZaWDJjZkNDMUJRSUJhRkJ6Z2hYa0RBMDB1OVpXdlErblpIaENMblR4?=
 =?utf-8?B?SnZVcVNXUWx3UEIzdHkvR1JlWSsyWUlGSDRWTmhaQ3JEa3YyeGQxOTJMY05h?=
 =?utf-8?B?SXFiWWVUMGNDTTNnR3ozVmE1WDB4bHRZaGtZMzl4cHFUU0dNbTJuSDZBbE04?=
 =?utf-8?B?cmNoUDZteXFTYjJCdUo1T2RuTlJzRXZLWE9sY3lCb2VXY3pLblVHTjN4cklD?=
 =?utf-8?B?MHlJY0N0UFVxa29FOWlnOEVBS1pVWlErWE43dytkR1gxc0V2VGhyWXdYNkla?=
 =?utf-8?B?V2d0dFRjNXZEeEpFaFFXWlV4QldqdE1HZlpKS2VMbU0xUExWeEx2WWpJazNB?=
 =?utf-8?B?RFc1eTI5Q1prWnM4OXJXYjZMajI1T0xXZWRuMmFtRDNlOFJrMUc0VkNMOUxT?=
 =?utf-8?B?ZEY3NnNvT1ptbmRuTERiT2F2eHFBL2YxRWkxWk9ZYWZ6RVN0ZXQ4SzA5Y2dT?=
 =?utf-8?B?TlpUMysyaGRWM3pOQTNSNzdNU0UyaDNtTzNwdERBZ1RURElidmc3UjRGb0p0?=
 =?utf-8?B?d2Q1TlBoczZ0VmVRQS96eGJ4aytQRmpCWXNKRnFFSmdzTDJJWDNNTVdzYU5r?=
 =?utf-8?B?aDdxeWtBdnRyeXZOWVZvRjZyd3pUaTN6UHBxTjJHVTRRdnZhUlMzQ3JkVk00?=
 =?utf-8?B?V1djZFBXd0ZRQWREYTYwVGZ5d2tNOFVvQ1dmYURrcm1PMzFuVUtWZ2NVYjdY?=
 =?utf-8?B?Wm9EMjVFSE5zNXV1Z0JyaEhKdGYxYjlrODhoQzZadDJ2Y3E3Tlc4aXp5d0dB?=
 =?utf-8?B?MWdvRTJkTlJpczBEM1FJK2EzQXMyTEFlSXd0UW82RkRlMlgxdU0yK05BZERU?=
 =?utf-8?B?WlJpQ0RIcTlMdFY1Yk5LNG41akFkMEhIbzRWTzJyZDN1TXZnMW8rYzdTajFt?=
 =?utf-8?B?eEFMR08wWk1kd3lXNDU0Z2ZrbDE3RXNWcFVWcHEyRENFV1p2aXd6UjJrdzVT?=
 =?utf-8?B?bVY2V0U1OTM5ZXNlVUxmUmtWNElsNU0ydUlJOUNXYVZYeUkzOE5qcTV6VVc4?=
 =?utf-8?B?SHFFTU43eUx0dU1WM0JIS1JmSzZ5aG12UnpEMSt1NUJQbWFTbG1Da0ZLUUY0?=
 =?utf-8?B?WW9FMGZiUlFia0t3MitzeXdteTZpay9hSy8zWFpOVUFWWCs2UmVKUlZMNXZS?=
 =?utf-8?B?dXQveUg5U3FkcWlVY1ArZTM1cUVlUjJIWUo0R0c3amhhN2VjdnFwTmxXQzl0?=
 =?utf-8?B?L0U2bHRvL29NcWpsT3JYMmxoNmFRaXRCdVB0T3B6M2xRa2JjbHBodHlFdkEr?=
 =?utf-8?B?SEFxYkZXelIyUXBYOHlyMmRqYUR6Z1NlQkFpaE9EaTFqazJkWVhEY1YrZjd4?=
 =?utf-8?B?d1ZoUHVRcTFQVHkwaDI4a1psRG1WRGM5MXAvbEc2bHYxMWVQY3lGV0lGaFRy?=
 =?utf-8?B?NlN4MWJpVUtFaFczWXl1QnN2dXc1UXJDUFc2M2RUS1FHbkFWaW9NN1dHblZh?=
 =?utf-8?B?Mk1CWkdIVG13OW5JMnBHU2dBZFkvajI5YnZ0TWtKVTFjSURWRW1Ga01uVHU3?=
 =?utf-8?B?bGJrRzhLSlNMY0pGNFIvdFBnZDlScFR6Y1RYdzEwc3k3eE1adG5qOU03UVlu?=
 =?utf-8?B?UFVTcFlYT1g5VTlHMGxvV0FnTFRLTDFWck5hNEdHODBzdkNqTDdTQmtndFh4?=
 =?utf-8?B?b2dYSkFaaEJFN1JWOHZ0QXFrMTdYeDRnd3dvRGtUY1pBRTUrTTZscm9WOW5i?=
 =?utf-8?Q?2rI7xYEe0LMedzd6/a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4e2088-4d34-43f0-749b-08dedcd6c9b7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:53:40.0783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wDUqayR+sm93vhk50Mb/aS77ciOsWmyhG+gxMzduKGWjuP9c9XdF7a/mWLWylKZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999203
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

On 7/8/26 11:35, Li, Chong(Alan) wrote:
> AMD General
> 
> Hi, Christian.
> 
> This version of the patch is not host-platform dependent; all host platforms follow the same path.
> 
> I verified this patch with KVM in my local environment and with ESXi on a borrowed server.
> 
> Distinguishing the host platform was a mistake,
> and I have explained the situation at the end of the patch email.
> 
> I have pasted the content below:
> 
>         Hi, Christian and Lijo.
> 
>         Sorry, I made a mistake.
>         Host access to the VF FB is not platform-dependent. After the host driver sets VF_FB_EN in response to GPU_INIT_DATA, the host can access the VF FB.
> 
>         I borrowed an ESXi server and tested this patch there.
>         The amdgpu driver works normally.
> 
>         I rewrote the background. Is anything still unclear?

You still have this check here in the code: "early_full_gpu_access = (adev->virt.req_init_data_ver == 0);".

As far as I can see that is Hypervisor specific and a NO-GO.

Regards,
Christian.

> 
> Thanks,
> Chong.
> 
> 
> 
> 
> 
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, July 8, 2026 5:05 PM
> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Cursor <cursoragent@cursor.com>
> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in sriov mode
> 
> On 7/8/26 10:25, chong li wrote:
>> v2:
>> Some legacy ASICs do not send amdgpu_virt_request_init_data().
>> Only keep the full GPU access request early when request_init_data is not sent.
>>
>> v1:
>> Move the initialization of non-GPU resources out of the full GPU
>> access region during AMDGPU device initialization.
>>
>> Background:
>> In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables
>> VF_FB_EN and places early initialization data, such as IP discovery,
>> VBIOS, and PF-VF exchange data, in the VF FB. The guest should then be
>> able to read this data before requesting full GPU access.
>>
>> Before this patch, the VF still requested full GPU access in
>> amdgpu_device_ip_early_init(). At that point TTM is not initialized
>> yet, so the normal VRAM aperture mapping is unavailable and the guest
>> falls back to MM_INDEX/MM_DATA register access. That register path
>> requires full GPU access.
>>
>> Use the BAR0 framebuffer read path, amdgpu_device_read_fb_via_bar0(),
>> for the early init-data copy instead of MM_INDEX/MM_DATA. This lets
>> the driver delay the full GPU access request until after the early
>> init data has been copied.
> 
> That looks like it goes into the right direction, but as far as I can see it is still an ESXi specific change.
> 
> So once more: We can't adjust the driver to the hypervisor!
> 
> Either this works on all hypervisors or I have to reject the change.
> 
> Regards,
> Christian.
> 
>>
>> Signed-off-by: chong li <chongli2@amd.com>
>> Co-authored-by: Cursor <cursoragent@cursor.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 +++++++++++++++++----
>>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 ++--
>>  2 files changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 610d82b79de3..ac66796e8634 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -38,6 +38,10 @@
>>  #include <linux/apple-gmux.h>
>>  #include <linux/nospec.h>
>>
>> +#ifdef CONFIG_X86
>> +#include <asm/hypervisor.h>
>> +#endif
>> +
>>  #include <drm/drm_atomic_helper.h>
>>  #include <drm/drm_client_event.h>
>>  #include <drm/drm_crtc_helper.h>
>> @@ -1987,16 +1991,19 @@ static int amdgpu_device_ip_early_init(struct
>> amdgpu_device *adev)  {
>>       struct amdgpu_ip_block *ip_block;
>>       struct pci_dev *parent;
>> -     bool total, skip_bios;
>> +     bool total, skip_bios, early_full_gpu_access = false;
>>       uint32_t bios_flags;
>>       int i, r;
>>
>>       amdgpu_device_enable_virtual_display(adev);
>>
>>       if (amdgpu_sriov_vf(adev)) {
>> -             r = amdgpu_virt_request_full_gpu(adev, true);
>> -             if (r)
>> -                     return r;
>> +             early_full_gpu_access = (adev->virt.req_init_data_ver == 0);
>> +             if (early_full_gpu_access) {
>> +                     r = amdgpu_virt_request_full_gpu(adev, true);
>> +                     if (r)
>> +                             return r;
>> +             }
>>
>>               r = amdgpu_virt_init_critical_region(adev);
>>               if (r)
>> @@ -2159,6 +2166,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>       if (!total)
>>               return -ENODEV;
>>
>> +     if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>> +             r = amdgpu_virt_request_full_gpu(adev, true);
>> +             if (r)
>> +                     return r;
>> +     }
>> +
>>       if (adev->gmc.xgmi.supported)
>>               amdgpu_xgmi_early_init(adev);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>> index 9a40107a0869..340703d89d6b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>> @@ -185,8 +185,8 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
>>       } else if (req == IDH_REQ_GPU_INIT_DATA){
>>               /* Dummy REQ_GPU_INIT_DATA handling */
>>               r = xgpu_ai_poll_msg(adev, IDH_REQ_GPU_INIT_DATA_READY);
>> -             /* version set to 0 since dummy */
>> -             adev->virt.req_init_data_ver = 0;
>> +             /* Version is set to 1 since GPU_CRIT_REGION_V1 */
>> +             adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
>>       }
>>
>>       return 0;
> 

