Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1DDC87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 08:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15C2C10E5B4;
	Tue, 12 Aug 2025 08:07:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qgaos6jY";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 531E310E5B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 08:07:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j07SnDWsBpQ/UOSoCGD/avv2gTdukmTUr1S3XTyGigYNHzwouW0u7ujlnksHtkz/jjSzu1XlTzcCFhUXkoozpkFbR2GuQJ578oxvoruH1niXrntIVCA5LIiK5Z+aFnVJ5NvZrjIT2OWB1fTfFhb1tUZDcbKxSjUP7GXx6Zzh0EdHg1LJid+pnyJ8gcLFosTQijxhO7EkKaZyYH9nYn/yS+hJ0bx7AX9rA/PsYRu3LmP2+NtYwCvKbBj2GJTLpZb+52mKW5WEUTTJOOz7pjMG2lHHC2HQ4g1TjSKYoXC3fIKShf3nUmP0Tcw5QFTgcFnAT6wCH4m+vG+XpbTVeXpgxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59TyrTB1Wn3vsGnA1J1LdCLn1bbNtTIbjRhSkFBut9w=;
 b=RYlGiKqpHv+OKss5lnHaPewLfX5xg7jE9u1Z1lIlNjpl64FXut6LUg3jiwjNhX4Z00he1sJS1UsFOySZt7Xd4GgWlEzDIS2qJdUazv1/xunLulnrRE5c224rZzpjI6UASKqcbhylYC/tq4grWa5tPvwliUzDHbaantV+na7/KFQr0Ku3Dhvg9P46ZSah/ti1GR8o4ALVLhOEDNB/7/aOeA5w17XiAY3gHyTHJ26ni46VW9nTChf20NLOBCe1cKzQlNni3Mfl5/9c67UBUO3Da0DcH3qAs1c//Fy7NYldYyIGG+Oz3/QJqYEuiPy5wZnSmxjRl7rqzO/44CVb9TyGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59TyrTB1Wn3vsGnA1J1LdCLn1bbNtTIbjRhSkFBut9w=;
 b=Qgaos6jYOaImpYCqIlpqVBNPZse2BgQsHYdQvsj+p8ExO5JzvCeVQOWdMQFFt2J+8sdQJTXxb9J9kBnXIaR1iouAvpA0rLV0G5rJ4XVIsJEm4nBUbg8gbfLJta1qa5NtI7UqFC5GhjeVdaYLfnlc9yUiKxxXYV1003Q8782H1l8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 08:07:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 08:07:17 +0000
Message-ID: <2a4d7d74-fec4-4fbf-a979-0c79869a5d25@amd.com>
Date: Tue, 12 Aug 2025 10:07:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix task hang from failed job submission
 during process kill
To: Liu01 Tong <Tong.Liu01@amd.com>, amd-gfx@lists.freedesktop.org
Cc: gang.ba@amd.com, "Lin . Cao" <lincao12@amd.com>
References: <20250812080056.4072748-1-Tong.Liu01@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250812080056.4072748-1-Tong.Liu01@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0011.namprd14.prod.outlook.com
 (2603:10b6:208:23e::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c6a6a1-226e-472a-41c1-08ddd97740e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rk42WlVaT2hKSlFpYW4xdjRUU01vbjVhOFduMFh0ZlJGaGp0Mmdrcytlb2xq?=
 =?utf-8?B?YnVrMHRBUTlLYmVzcStTV0NRSGFPSWl6THEzUWpxUW50bUY5cCtwbnphK1po?=
 =?utf-8?B?NFhpa1NpeFhuaTk0bm5uV3JBVjZBd2l1T0hQbm1EbEtMalVxRGpuWHhtSWRq?=
 =?utf-8?B?ZXFNUlUwNjEvWUFXNy92YnR6U25wbVRZMXZXUjVCTkt0R0dIV1BTRk1YbXdi?=
 =?utf-8?B?clFtVTMwSG02Ym85UVFEc2VNQ3pEOEhIS1VKRVdYYmxJdUJHWWQxd2tENWJ0?=
 =?utf-8?B?UERQS3hTTERDaTJMZlh1WGs3NjhIdkpuekQwanFqMFJXWklJU3liM2NlQlBr?=
 =?utf-8?B?cXFyUkJobnZlVlkwQ3J4dHJUSFgvRzlZUHU4d3cyOEpsZXQ0S1FxS2toZnNt?=
 =?utf-8?B?QTBHMDlWVUdORGpJampQR1Zkcnl3ZUJKclVyU0ttYlZMeFRTNVJsV0FFUVlT?=
 =?utf-8?B?L3BDWWhUQWhuRXdPbHd3am1icmpsNitFbkRrUDZOVG1yY214YUNDTGZQTWJU?=
 =?utf-8?B?ZXo5Yy9vMW5wc0YvQkpTeWxEazFGc1QyTVFWNXpLMndWWGN6RitiakJCRUNP?=
 =?utf-8?B?Z2dmaW95T3MwR0VocXRPSGs3YzM5VTdadGRabFFYWDdsM2prMzFvWVJNS2Rr?=
 =?utf-8?B?bUtZSTg4UDMrMHh0WVJFSnZLQkV6bThFSktZeDFxU2g2eURabHFDUGZCR1NH?=
 =?utf-8?B?MHV5eVdYMTR2d1RZRnpLdENocWEvUGVydkhWNXpOTW04dnBleEkzSlhqN3Ir?=
 =?utf-8?B?MDZMdEdCUTlTLzB4cXBwTHBSNHhtdjNMU1QveFJtak9qSmNUclVvNG5qY3Fj?=
 =?utf-8?B?Nm5IOFpzZytBUDFQcnFEL0dJV3B5SnFwRDJoeEZFSzlwOS9lZlhtUXZBWERn?=
 =?utf-8?B?TjcxTDYvZXRlSzY4ZlVkYlNrekYvTWt3ZjY0TUEvcVhQT1lYTlpzMXh6M0F6?=
 =?utf-8?B?eVd0NGlVVE1RaVZ4c3lDbFNCNWNYdks4Z0JBOUtzdUhiRkRtVlRucUR4allF?=
 =?utf-8?B?TWd1UTVTZTQ5Z0xkWEN2LzhjM0JmMjdlMUJzRk5ZZVlpZk9JVlBZZjVVMXA2?=
 =?utf-8?B?TzJaN1hkL3NsclgreDRROFpKSklCTUVFNUN1WjZuVHlaUHNTUm5RdUg2WFkx?=
 =?utf-8?B?cS82cHFNTk1Kc2Eyc21WT2p2d2VuWEJQOFNCLzBRWFpxMThpYWMvM2RYdkFk?=
 =?utf-8?B?QXJuc0lSSHFuZ0gzakRocXdkNldaTzZhNk5pL2tjUHQ5SGZTZFlibk9IL2wv?=
 =?utf-8?B?eTVwY0o0cW1yVFpzb09TMmgzNzlGTXA3T3RGVkdobUQ2TXEvWlBBZFlsZjZU?=
 =?utf-8?B?WGc5QUNjMEU2WTF4OFpMMjF3Y3pSb3BldUtsUkdxQVJvSFNCcHo3Q1BOaGh5?=
 =?utf-8?B?a2JXSVdGTjJ6WCtIZUNmSVhZRVlNZ29HYW80eVB0U2JBbUpZWkh1K1ZIRHlm?=
 =?utf-8?B?OVRZeE44WVZXN3c3STNKV1pxQ3ZzUnBRMU9TU2Y4MXRCUHNTeGtFMFBsbDdX?=
 =?utf-8?B?SmJxSnV1bi9nbzA4eUNmR29Ud05BYUlPWFFIaDMzT21GVTRBdVJPd3MzbVVS?=
 =?utf-8?B?RTMvMFdMSnIwbVdBRk9LcWNHZmdaT0IvY2cxRTJIa05yYms3aE5qTEF3Tml6?=
 =?utf-8?B?bXRQS1ErZEdGUUExMXZoSGNPUS93ZUZ4UjU4QzdqM2tRRkdNSXZVcVpta3pG?=
 =?utf-8?B?alNPdzZiUC9XWDZJSW5Sd00zOVdBbWVqVUFadVJJRTVCNFV0WUk2Z3YvdEpM?=
 =?utf-8?B?b2pDY2lQWVdRWkNTVHVJbU1uVm5Gb3JRWTJjc0YyR1dyVDhXTG96QzhVQzF3?=
 =?utf-8?B?V1dBWUxBYk9IYTFoNmdmY3V1V2lOdW9iT3lvSGJVTnczVlNwSVpRdGNtaEVS?=
 =?utf-8?B?MDkzSTRveVN6YmRGSHBBSzZwQXl0V2lhZ2hxV2dPVlhycXJ5czQ4TGwwMUs4?=
 =?utf-8?Q?1r5Gx9XO9B4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0xVMENTYTVRelptR1VUOTd0UFR1ZXg1c0IyT0ljQmR1ZXV6QlVOWHYrWStG?=
 =?utf-8?B?cnU1UlBtNHpEOGZXdkZLSzVRKzFiSXphb2g4K3FpeXladlpPQ0xCN2RBRDhG?=
 =?utf-8?B?N0ZVaWhJczRPVUlaZDh3SHFmUUFrZzEzVitSY2tvbXFSajVoMk5WclBpQXhO?=
 =?utf-8?B?WjI5Z1QxdWd5M3U0c1Y4dlR3TzU4S3ZCcDRoS3NPL3pRVWx4ZmM1djcrQlpM?=
 =?utf-8?B?RmU1VjFER1lIcGl3eUNoaHFrSHlEUmdtWDNLblNGeFhVMlR5OElQQy9IdE1S?=
 =?utf-8?B?QzZoR3ZTRzdqaW5uV0dVSnU3REl2ME5MMk84K3BKSi9VQytpajlMSURGRWRw?=
 =?utf-8?B?ektxTXFJTCtOSDBzRVVjc0l0T1ZPSkVRbUQvRXVrekZCaGhVNXprM2lpZk90?=
 =?utf-8?B?a3diVG4vS2tYNkJTMW82WTJMcUtCei9mazZOSkYzTE42OTllSkxzOHJEMjVk?=
 =?utf-8?B?end4QXdOcE13LzQreVVpdElvc29LTzF6b093RGJKWGdMSC93UHhlUzJORFpS?=
 =?utf-8?B?WWN1Z0phUE9mVzllR3pVLzdlMG1tb3pLV081UXRzQWd3OHF2R09yRHdwTGNw?=
 =?utf-8?B?UllUdlVGOTFGMVE5Z2pBakRpVnZSL21GenF1NXByQ3AxNWdjVkpaT25EUjRt?=
 =?utf-8?B?bnZiQ3hTaXFtL1BwZCtnVkFXUWdpeGVQYzVaZURHNGZEbExqLzlVTTl3eGdv?=
 =?utf-8?B?c3B4NzZSSFJPMWVKRUxLMzZmOGtGYjRYZDJMSlNNdU5OL3dBeDM2WUptOE5w?=
 =?utf-8?B?bXN3QU1uZGFLandId0MrMTluWGljeUhWUlZGS1Q4bzNxZzRyMk5CMmJ0OU05?=
 =?utf-8?B?Sk5JV0F5aGo5MmZRTTFDNXFwQWlHQWlpeHloYVBMdkhpbmFXUkpoc3FPMFpU?=
 =?utf-8?B?enJzb1lKNVZUMzVmNzlnY1c4SGFEdFJ4c1AzQjJQS093d1RDV296b2RzZlp1?=
 =?utf-8?B?QmRJOCtXb1lIcmo3SkE5eUxMcWtOMnBaRE1oSlJDbHRPOXRRSG9qT1dGMGY4?=
 =?utf-8?B?YzJFOWhpNDgvWm1Sa0JqM0lINzl0aFBoSmF2Z2MrR2MzWDUxN1UrbUxMeE5z?=
 =?utf-8?B?djVIMW5mWE5xdU4vbU9EdTJ0dFF4ZGZ3YjBnU0lGRm05NUhhcnpudm5POFln?=
 =?utf-8?B?OE9Sb3RHOGlmVWN0bjVnMXJrQWtuWXVmSXNsQXhBYnllSG84Z01qSmkrbFJm?=
 =?utf-8?B?aWlScGE5WGZHVldsVjlnMFZLc1B1MlJaYnc1SFZkdmo4a2RyclBvUU95Vnp5?=
 =?utf-8?B?cXBaNFd0M2VHa0lSUU15bVpJT0VKaW4wY1NGeGp0QW5PRlFpYm0rRTdhK3JY?=
 =?utf-8?B?L3RGVU9XR1drSWZOWlJrOGhRMmVoVjBWenNOcjFDRHdnaTVmc3JvWFJYWWVj?=
 =?utf-8?B?S1c1UXRxRFRMYjRFWlQzL1ZPU1BxSk05NG9yOE05RDdIWHM4ZHlCTWtLQTdB?=
 =?utf-8?B?MXA5MkZnU3AvTGM5UmdzeEhsRnlwRHF3dXZ2RGhNejBzZ0ZST3JXWk4xY3dH?=
 =?utf-8?B?eXdJclZieFUxL1BHMWJnd2N6ek9BbndwUGVSKzU5RFArSHYrMXcwK1ZYQ2Nu?=
 =?utf-8?B?QTk4LzZaNzNycm5kTjYxYWFFb3FnaEM5K01yMm4xVks3S0RaZjByWW44aElh?=
 =?utf-8?B?MVJFV0U4bElsNjd6UmF2UnFvem83OGl3WXZsamdhOTlIcERHQnRnSTJJT3Zu?=
 =?utf-8?B?RkVnTW5BbnRVdUxKVDZLTkRHSUkxMWVyOWJEREUzb2ZxbFdZeHNBOGcyS1ZL?=
 =?utf-8?B?R1plbExxcm9SUE5NOU8wV2xKMG90ZW8xSnVTTDFoYmpCSGRKZTYrdnI5dk1W?=
 =?utf-8?B?bDl6Q05VMmdqaEpzYjBMWnNTQ1RyOTNCWXIxeXFESFA0dVNNNzU3c0xJMFVI?=
 =?utf-8?B?YVJDWDZmY0Y2M0lBTjNSa3BjTzhmdjh5UHVrby83UTR5UmZvVzhvdFJIVTJO?=
 =?utf-8?B?cXlyZ3BMbW5GTUFQYnloa2t5dlJHOE1hQWtHcW53My84OGFFVG1XdDZNZy9u?=
 =?utf-8?B?cFAxd2lJaTJVL3BaWUI3QnlsRGp6ZmxWeVZMTlQvbG5Qbk9uRXZ2VkhqMGFa?=
 =?utf-8?B?ZWc3SldMSXpPWWFHbWhvZHoycGFiT2N1M2x1MVFleUYra1ZXbGZkenhIeGFS?=
 =?utf-8?Q?FKX2Pm6JYdNVEyqDW9c/4OR/B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c6a6a1-226e-472a-41c1-08ddd97740e0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:07:17.1401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lHRms+p37FkEJI7T6ltc6HIs7YADlasK6G3Zr081BC9NmRr+TCoBWr2AeDQbrWM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749
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

On 12.08.25 10:00, Liu01 Tong wrote:
> During process kill, drm_sched_entity_flush() will kill the vm
> entities. The following job submissions of this process will fail, and
> the resources of these jobs have not been released, nor have the fences
> been signalled, causing tasks to hang and timeout.
> 
> Fix by check entity status in amdgpu_vm_ready() and avoid submit jobs to
> stopped entity.

Looks good to me, but to just be on the safe side please add another call to amdgpu_vm_ready() to the function amdgpu_cs_vm_handling().

Right before we start updating the VM, e.g. after the amdgpu_vmid_uses_reserved() check for the gang submission and before the call to amdgpu_vm_clear_freed().

Regards,
Christian.

> 
> Signed-off-by: Liu01 Tong <Tong.Liu01@amd.com>
> Signed-off-by: Lin.Cao <lincao12@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 283dd44f04b0..bf42246a3db2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -654,11 +654,10 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   * Check if all VM PDs/PTs are ready for updates
>   *
>   * Returns:
> - * True if VM is not evicting.
> + * True if VM is not evicting and all VM entities are not stopped
>   */
>  bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>  {
> -	bool empty;
>  	bool ret;
>  
>  	amdgpu_vm_eviction_lock(vm);
> @@ -666,10 +665,18 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>  	amdgpu_vm_eviction_unlock(vm);
>  
>  	spin_lock(&vm->status_lock);
> -	empty = list_empty(&vm->evicted);
> +	ret &= list_empty(&vm->evicted);
>  	spin_unlock(&vm->status_lock);
>  
> -	return ret && empty;
> +	spin_lock(&vm->immediate.lock);
> +	ret &= !vm->immediate.stopped;
> +	spin_unlock(&vm->immediate.lock);
> +
> +	spin_lock(&vm->delayed.lock);
> +	ret &= !vm->delayed.stopped;
> +	spin_unlock(&vm->delayed.lock);
> +
> +	return ret;
>  }
>  
>  /**

