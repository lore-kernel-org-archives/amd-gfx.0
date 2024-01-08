Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD62C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 08:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F29510E1A6;
	Mon,  8 Jan 2024 08:21:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5947B10E095
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 08:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kef01c0nyiSieOm7Y9d0lIPMcbvHnz5PKuawX+CZpAGTp5sfgsX1NJSQDDYW4ljhEBVc+18qRLvV6y3KYmHhdkJCW+Q/MA7pMw1UmCrAyL3ofheNTsKL+WUudig4k1ay9/LHLh8p2RYRbcsSoYlxWZkmXSzXNsaDUgXTawUSkK2uM64v1QgiPDqPrFJlg23365CXyFayHrobbHjZ8tOcTi94RCF7aViLFbWIYNqXDIQvy3oJYAO9lVFC+BuMy1bhyMRXohBhudXKtEA487GIMWVkFkI83Sn9gn3eMcGjy/qFZs2/FE/1mF7lqANYkjHWcLCEiv9Mv57n6DBtfaXLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOxnBjEA7iLwfVNa91LRABLW+GqAHfeK8LbVvf/8X5g=;
 b=Rx6/To9kbqxQFYp29Rzj6cc+Z2dQcHwyrcng/jkplwpIJT+OeWDKAinHWPd95FxFGDX1qcR4fHktKG6szPnH7Dykeicqr4KmK9MyXXeaMZy3ry9Kh5maid2BvnwtAiAYZN+prc20pEQvfDH4Rl/Sjisd8s8C3O07svs5gP3iNmrBr55JKFBD1FeEo/+/8T+fS42EXYO9ZwezysmOjO2TmjytDPyeH+SGc6pjjS9Tewpvkv7f5t5oaE4/MqrSN2wPeNK9rKBCUBbphyk0jOMERxVXf0EV1UolMhKZrRVV1Wf5RBB7VE5S+mmpWvatk3E3jphacJVDN81lg5ZpjL8uvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOxnBjEA7iLwfVNa91LRABLW+GqAHfeK8LbVvf/8X5g=;
 b=C4SbhvkhlZtlftgzenFreDD0t/Ac2UJZAm+FsiDNuuWJaOjzKHdkZRjVguf67tfPhUbaEQ1wdBoD7XtS2k/rGnparhMwkM+FvNartOYQQtH+PqKcISKDzGNUby+5ZqhFTZ+M58G9yc2PXOtSuUERoiw0cKGq/5Tl1LglAS/n8V8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 08:21:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 08:21:43 +0000
Message-ID: <1309eac6-7b01-4566-a83f-541dbc0a3132@amd.com>
Date: Mon, 8 Jan 2024 09:21:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Update irq disable flow during unload
Content-Language: en-US
To: "Kamal, Asad" <Asad.Kamal@amd.com>
References: <20240105152100.471494-1-asad.kamal@amd.com>
 <5c1863cb-a528-4c12-9ad7-3c9589088863@amd.com>
 <DS7PR12MB60714005DFBD7DFF9754A23B8E6B2@DS7PR12MB6071.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60714005DFBD7DFF9754A23B8E6B2@DS7PR12MB6071.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f31f25-1868-4005-f315-08dc1022d8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Rj7NxEZPOf/LOrUpJkY/QwbLkrA8BTveGXtt1mL4YwgOG8OfudtrU/sMJDmEb3G3/la4e7cORuQr6Hl4kEN9vta9zDI/VV7F4WXVyhWJ4S+W8wcp6NpWhKiwTS2J4JzKtrabzMw8oroYwZwe3YaGDq2YEag0pm4m1JbgF6cGC+3wbDmpjy15EoDKfjGuMtnlEcwqU0oYVAlH9wUw+WnuR29adqLWRBD5EA/mB5M9yZzp4aS9WQm86I/dpl49wXfr6tDqU35HXwOqC9+K6npu8igtykxt/nYex5XC27D+1iaEfogyplzCym77Zl7aJp3Vc6lGpUhGkoKfrBkDJjKVF+GnPjI8UUPKLsMGVhDHd+2SnJHyJerta8fQ3zRg7h97cEXKZe/foBR7K07Cgdig1n7mDxvgzO8FY7GjFg5ldr/Ieq7vjmDXWcUtcAdICZ/aF8GsyG7E932jlxnK7yCx0K/yTgDBh7+tdI0TDV2F9KCL8K/lnQHHRhx583B0kWN2+qcEyj6+SNyjDdtpIufBwetjFYqzQKXLx08Mo6m91puQzX4roWiJsIcj61OIPQH8CVxsNEtd2xBy6As6GBmpT03gKofsuBFa9bVls/t20YMzSHwsl5xZET/SKrzBXmd/lqVJ6RPqP0l4ira7AXcNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(6486002)(2616005)(26005)(66476007)(66556008)(66946007)(41300700001)(31686004)(86362001)(31696002)(36756003)(5660300002)(4326008)(6862004)(15650500001)(316002)(54906003)(37006003)(83380400001)(6506007)(53546011)(6666004)(6512007)(478600001)(6636002)(8936002)(38100700002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnRENFdTL2s2TGZhUGU3eGp5Y1I1OFRtS2o0c2FGMU4zSDJYNGY4bmdHc0ds?=
 =?utf-8?B?MXY3VWYxK2wvRlVnMUcvbDVkMnhiZHBvbzd2eVg3Q0V6a1RDdHBsdW4vMmhJ?=
 =?utf-8?B?aTczeXdreXBRdWxidTd3NEc5N2VJVnlhWEtzWHlLRGVlaUhENjFZZzlCUE1Q?=
 =?utf-8?B?V25GMDNSSGtBamhxLyttM2s2RktHc0tvSmFBZ3B5U1FXcjFOQ2F5cmpUL3k4?=
 =?utf-8?B?T3NoU2NiYnZEVlJlc3ZrWExVUFBYcXJEenMyRjM1UVNQcktsak5VVGhseG5V?=
 =?utf-8?B?by80Wi9vZ0xob085cy9yeUg5d3d2TzRnYnNrbnZESWZtTURiY0Nqd1JXUGwv?=
 =?utf-8?B?My84N1JtK1RBWE12aDRuN0tLdVJGSjBsNmJ0VVFJSUZsRXh3bnY1QkhRbEk0?=
 =?utf-8?B?SVpSc0pZUmhZR09GcHJva25wcWFCWHZNaXhrT0RnbXRwZWIwODM0WCtLbXUw?=
 =?utf-8?B?eWlYUTZRL1pwRjNvZUVLYWIwYVpvYXhXVkdLeU1VcmFyLzg3eEJSUFQvLzl4?=
 =?utf-8?B?QzFmZGNBbUxsaDZES01iOGthMkh6UlBsZExnanRmK0dNQU1Tb1IwcjU0dytj?=
 =?utf-8?B?TnExODRZazZqc2JVdE5KdGxIcTFOQUdERXFjNGlod282NTZ6ZncyZzYzNU9w?=
 =?utf-8?B?ZFY0RkN3SFpnK3g2TUVqNVc3ZllZSEY0QnVxTnlwUmswRVpkelNoVnRtQ1VV?=
 =?utf-8?B?cmdKLzJReHgveDludXVqOEVRS0U5cXBUUjhOMTU1YVBsMkRHVllibGRYTjQy?=
 =?utf-8?B?dFhwL0VoYnhXdDBRNExTYkFWeko4NU5HbXM3ZWRHc0ljdU4xZjkvRHVSN2pW?=
 =?utf-8?B?cldJeWdnUGdEQ0p4UXo0aGRpTnVnSjd0WU9DR0ZkWThoazBvWnBFSklneWU1?=
 =?utf-8?B?VXpRMWF3blRBSzdFRExhL1A2Kzd5WDR4UWVHK0RvWFlIdnFHcnQ1R1lYVzVo?=
 =?utf-8?B?cVJzRDZMb0lPOW8rdUtGWXhMVVJKUkRaaHJNbUhjQUxTcFA3WDRMY3RtSnJy?=
 =?utf-8?B?Nk5QYXhuU3NLYXU4c1RqZEhBM2tXNGdKNHpINDd0bExRdldCT0szM0prTzJo?=
 =?utf-8?B?ajNTWGVSb1hXaUZYSzMwei9CWjVVRFpIUG82NkU3cWpHT2R4NTlsQjJ1dHhm?=
 =?utf-8?B?ZDdQb0lVWTc1dll6dmQvOUFxMWR0RmgvMXRPTXVrakRWVTdGMHZqSVpxR1g5?=
 =?utf-8?B?ZVNMQ3lPdUh0LzRoczFHeDhXUkF6ZThHcFdQd3hYQ0NaTGRDbzVySVhSZFFz?=
 =?utf-8?B?UHc0aEpUZ0FNeVNjVjh6b2lJVFNHbFZEcEpsL1hXdFBwQi9ZMkZ6QUFXSm92?=
 =?utf-8?B?U1FXZTREWVFBYVBGcHVTc2xsQjdqNExLTHNJN0lWNndodnpOOXJkYVlUWW42?=
 =?utf-8?B?QUFUY1dzY0ZoN3QwSmJ2TGNRV2tjS0FpTXJGKzBHV0VGMno4VUpFTURKYTd3?=
 =?utf-8?B?TE9IejN4OUJNV1l2V3RyMHFodmJGS0tGUzhxeEJXekRqUElRSkFHTVBzQ0dL?=
 =?utf-8?B?UVlZb1VyRFFIRSs2Tk1SNU1kL3YwdE5JUjM5Yks4b01HbnNMVWtQM045YkVZ?=
 =?utf-8?B?WjcvU0dyZEVieldYb3g2QldPbG1PV2ZsN2xpUzZYUTBKY0EydHg2cHFWNHYz?=
 =?utf-8?B?b2hSUnFORnNTYmxOdUNsYjNqdEt1Z2VSZE5pSVNuVE1pdHRnYnhvTmlwSjJR?=
 =?utf-8?B?TXRocFNCaTRTczVDM01ZeEdWSEk5cEE3ZWtUQkJEbjlsK3c4NGE1SHZHNjhS?=
 =?utf-8?B?ZURYM0k1QTBVR1N2N01CeXJ2NzY0VVVPUU9BRkhwcGZleS91alMydVFJZXdI?=
 =?utf-8?B?Tm8vaDVwZEwxWEpYVy9zamtzckZtVk1mVEh3ci95ZjhpYjEyVTJRdGRrd1Js?=
 =?utf-8?B?cUlDblQ4SStYYWJEVERHYnpueGw1TkpUSTBFV1c1UzBSQ05MaDgyMmNqR2ZN?=
 =?utf-8?B?UzBFMkFPZ3lCd1NxNlpKSHJjbSswSjNvV3BMRmRDSzNjS2xIZ2IvZ3lVT3VL?=
 =?utf-8?B?YUd4Qm96S0tpWHpFYU9Fc1hiSmZCSFFub2F6TWV6eUc3NEZiVmc1VS9MbEZ5?=
 =?utf-8?B?TWluOW9WU0k1QmpqaWx6YzNONnV6d01UZCtTUWVBcDZPUVBRYXdSZ2pHTGd4?=
 =?utf-8?Q?W7dMFL9LiVRiGO8oLw+u3Kh/I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f31f25-1868-4005-f315-08dc1022d8a2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 08:21:43.0361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2nvO8pwOyPWe8RPAri2BDMQTfRJVgIZbaRUE4Q+mSGt0szdTRHYiZMsTtJpsYgA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.01.24 um 09:13 schrieb Kamal, Asad:
> [AMD Official Use Only - General]
>
> Hi Christian,
>
> Thank you for the comment.
>
> This is not normal reset, it is reset done during unload for smu v_13_0_2.

Yeah, but this doesn't explain the rational for this.

IRQ enable/disable should be balanced in hw_init()/hw_fini(), 
independent of what else you do.

I'm not sure what you are trying to solve but this here is a complete no-go.

Regards,
Christian.

>
> Thanks & Regards
> Asad
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Monday, January 8, 2024 1:33 PM
> To: Kamal, Asad <Asad.Kamal@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Update irq disable flow during unload
>
> Am 05.01.24 um 16:21 schrieb Asad Kamal:
>> In certain special cases, e.g device reset before module unload, irq
>> gets disabled as part of reset sequence and won't get enabled back.
>> Add special check to cover such scenarios
> Well complete NAK to that. Resets shouldn't affect the IRQ state at all!
>
> If this is an issue then something else is broken.
>
> Regards,
> Christian.
>
>> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
>> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 12 ++++++++++--
>>    drivers/gpu/drm/amd/amdgpu/soc15.c    | 13 +++++++++++--
>>    2 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 372de9f1ce59..a4e1b9a58679 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -2361,6 +2361,7 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
>>    static int gmc_v9_0_hw_fini(void *handle)
>>    {
>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +     bool irq_release = true;
>>
>>        gmc_v9_0_gart_disable(adev);
>>
>> @@ -2378,9 +2379,16 @@ static int gmc_v9_0_hw_fini(void *handle)
>>        if (adev->mmhub.funcs->update_power_gating)
>>                adev->mmhub.funcs->update_power_gating(adev, false);
>>
>> -     amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>> +     if (adev->shutdown)
>> +             irq_release = amdgpu_irq_enabled(adev, &adev->gmc.vm_fault, 0);
>>
>> -     if (adev->gmc.ecc_irq.funcs &&
>> +     if (irq_release)
>> +             amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>> +
>> +     if (adev->shutdown)
>> +             irq_release = amdgpu_irq_enabled(adev, &adev->gmc.ecc_irq, 0);
>> +
>> +     if (adev->gmc.ecc_irq.funcs && irq_release &&
>>                amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
>>                amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> index 15033efec2ba..7ee835049d57 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> @@ -1266,6 +1266,7 @@ static int soc15_common_hw_init(void *handle)
>>    static int soc15_common_hw_fini(void *handle)
>>    {
>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +     bool irq_release = true;
>>
>>        /* Disable the doorbell aperture and selfring doorbell aperture
>>         * separately in hw_fini because soc15_enable_doorbell_aperture @@
>> -1280,10 +1281,18 @@ static int soc15_common_hw_fini(void *handle)
>>
>>        if (adev->nbio.ras_if &&
>>            amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
>> -             if (adev->nbio.ras &&
>> +             if (adev->shutdown)
>> +                     irq_release = amdgpu_irq_enabled(adev,
>> +&adev->nbio.ras_controller_irq, 0);
>> +
>> +             if (adev->nbio.ras && irq_release &&
>>                    adev->nbio.ras->init_ras_controller_interrupt)
>>                        amdgpu_irq_put(adev, &adev->nbio.ras_controller_irq, 0);
>> -             if (adev->nbio.ras &&
>> +
>> +             if (adev->shutdown)
>> +                     irq_release = amdgpu_irq_enabled(adev,
>> +                                     &adev->nbio.ras_err_event_athub_irq, 0);
>> +
>> +             if (adev->nbio.ras && irq_release &&
>>                    adev->nbio.ras->init_ras_err_event_athub_interrupt)
>>                        amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
>>        }

