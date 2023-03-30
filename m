Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87092C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 15:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0069010E88B;
	Thu, 30 Mar 2023 15:16:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C610010E88B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 15:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMNzYqIgAzDWAcO4sFVyjl1AbhSgt4SJj+EntX1tp6KpvZFpyUy8dnN2OhQo7Ce3dKnagwxnY3N0ThB3S2PmJj/jrWWLGjrGnoHs0X84bEcAyWhai+WTe+ls7z3Q8hy4O5kmwuntlx5yZ9dW8DEe4acbSBSy8o1OhLYrng+ffl+X9p2vCaSvapT9MNlpwMMfMV1+KzOEsUVlqkxKl0XfzCjXyo0+ED86ZKgppUws0Mu90CVKSrnqM1P8vjZPptCDRnanc61Uxxacs6JAoB2DCO5jH/ybytaErky0yvJ0LvuIiSvkcXdcWWTjFq/WFb9O4M6TMN/aYA6LmhlKf/eqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZacSdpRroMlZbr9mlu9rEpPEtMMwcx5K7BQ2liItW3s=;
 b=ZIyqlYj4nNEY0tEoUMNhLVnMSjhAtCrqHXGy0HEfTN/z1hV15rEoQReJrl0k2MJ8Rb7Cvn1CjPRn14vr57R6V5JYrGfy2p6y0ZHslIlzVQJboRRs67UNn2CIG9By6a50+I+nMWPUiVdehVFbzj1wb1wGGpEsnO9F2L0Zzkc75fb7UGwTgJSm3zLSBQ2soZPFn9YnoNKYmWiQT2oIPLg9uPmUzGVPa9BQxj7v7siYdV4FJWrTAe8OV7Cz2VKtyWuo0Rs3+OA+Z8QWk35QA22gORbM8uCaCOJXA5M/nNQPFhxiX0tVzhFMtD83IxTxZOuRK3402JtkIU7QRVzTC/jeNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZacSdpRroMlZbr9mlu9rEpPEtMMwcx5K7BQ2liItW3s=;
 b=XFEy9vYl8voKRmtmCfb9UQf6noitmSCJZmx6ts4gOuIrG0vp04oE3f4r2hILobvvv/DH4haWXlp1DXw4hEyIUmYy5dbvy4xoeg1z3+nwPFlbLt9y5isO2NIJZ2L2MfPCBbuXzjPQo2AGK5vlFeWe4o5y6JCGRIB+02xacUpOw+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22; Thu, 30 Mar 2023 15:16:09 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::313d:28ac:3dd9:269]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::313d:28ac:3dd9:269%6]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 15:16:09 +0000
Message-ID: <a704b394-f7cc-cd52-121f-9baad3b99bec@amd.com>
Date: Thu, 30 Mar 2023 11:16:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230327152028.2939908-1-HaoPing.Liu@amd.com>
 <76206089-39dd-c009-f0a3-415f3c02406a@gmail.com>
 <SN1PR12MB24455388D199AD581AC2FA5CF58E9@SN1PR12MB2445.namprd12.prod.outlook.com>
 <842f5527-6992-f579-8749-c49d4f9f6e28@gmail.com>
 <8dc3e40f-c881-9626-85ae-8d41d0ec0343@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <8dc3e40f-c881-9626-85ae-8d41d0ec0343@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::14) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a61e4dd-424b-4294-1ed7-08db3131b084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2FRty0OROztUOxvV411AsRdqtVA2CFrtZpZQ1TW/ycVsw1vLGG+nZnmPhLGYudupqaTysLTXz4fIw9IzW/iuL9MnTQHNg9SeS8txsmjL9SQJcJjNebbSVVKwXiMfg9JWvRNeG7So7u7Z3S0GrCe84ogUNaYQFWdjZRo88ih9ke4Tv8voR8vpetG4Vm7V98dATbkkT2dUgX1l8mQmd5tMYNsjaS5lZBMTOWtM8HXFGOqBP+jZSYb2PTz+Ywgd4Czlc5zGmm+NLu5HVPvqhsP3vlc0CA4HV7RHRtcJWMylpZDzfW9oLQGAiSsfG6ETVmKxeMEIb/SQJyqSKyiS4lz5Fl3zHSMksMaEWEPZlzMZ+GmExNxkYawffRKiwhaJALwfmn5zaPDhgqkcdpz9YjIDZ4y+o4ntIok6XYUSjACco8S+4deDnaO+QlzSgLlTNH4svZLRTthXIdUnAHvtQ0gHl7WaRzkTQoLnQxoABrwk+PjFNXx4W+nSKK33vwsUJ/Qzkj5cBznXlDbHCU8WABaTsf7U7dIQI5VCOHNuw7Um4Ea+ec9GSTqmwQ8AWOs5mfRmQReCm6XCkFJEuTCXwzUzVkkRvTGNc6fVYDS2M1fiEiunjxVvS7qI5ceZISH/o3nGRGXglY36cGDCBFcdX8uDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(41300700001)(5660300002)(2906002)(38100700002)(44832011)(8936002)(86362001)(36756003)(31696002)(110136005)(316002)(31686004)(6486002)(26005)(6506007)(6666004)(6512007)(2616005)(66574015)(478600001)(8676002)(4326008)(66476007)(66946007)(66556008)(53546011)(83380400001)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkZhR2tUU2lENm45QXNaTFNxbmYwOTNQY1BXek1RMjBlbkd0WUU4d2ZpQXhW?=
 =?utf-8?B?ekdRZ25yMWxpL2Vwc3ZjRFNuQloyZmJqQnBzM0k3NjZoNDRQTVNKTlg1QzA3?=
 =?utf-8?B?eDk5SzFQaXArSkNCOC9TUmg5VWR6ZTVWMm1SREFrSEhmUEhuT2pCbUZxRUQy?=
 =?utf-8?B?cnhZOWJ6OXJGVU1FbkRQRlJVSzhZNzcweTAvcU1Xemc2WnhSdjFhM0pNYzkz?=
 =?utf-8?B?OWlWbUVGcTcwOUl0cWJKemp0OWptejFPZHhGYnFNWVlrdzVaY3NGMEVYUGJX?=
 =?utf-8?B?SHdMaURrY1hqR1ZvK1E2Um1STHFZN0tmNTJvYThJVHgwNzVSZTV6cG5xeTJt?=
 =?utf-8?B?VkY3cUtpMncwU0k3V2FKUGd2TTFxaU15ZTYxQ0lkdUphWVdpY1Ird2c2eVNz?=
 =?utf-8?B?ZVJ2SkV1aVJFUmwxaGhEdzloc0tBZnFoc2tSODJoNmlDeGliNXhSSUVQWGtO?=
 =?utf-8?B?UHZhTzNobER1aTZJUkFwTHo4ckNlWmdJRm9JL3l6eE96ODBVTmlySjR0Vk92?=
 =?utf-8?B?aVZYU1BZeDYrOG9xSjEveUZwWnVFM0FRTlBpbHord2wxa2VQNGMwaFJPK3lY?=
 =?utf-8?B?QlFQeUZDMzFyV0FSTVk0cnhwOG9oRlN1SDYrOTB5NEJXRWhWZHZ2N1d2K09L?=
 =?utf-8?B?Nyt2dTRjS09NQ0VYSzJpZ0FHaGw5d2dzU2FVNDFqTkZSYzQ4d2RkVm1DVU00?=
 =?utf-8?B?SmVMQ2pNRFY5dnI0ZEplSXIra21pRFZucWVQeVRLTmV2YWJPUlBwU01haUNz?=
 =?utf-8?B?WG5GQXIvUzlySVpSRHdrOWlFVmRNWVNSSUhkWlhjZ3FHVmZVVHFVZ05LUHll?=
 =?utf-8?B?RGgwS3VqZEh2QmlOZkNMZDA4TWd2SHZJQk5XWGdVaUdKSWsxMlRnS1FRb2No?=
 =?utf-8?B?MW5NdUQrS3J6b1c0RGFhRWZqalZZU04rdGdWQ2NrRUJmZThJaHEwTVYyT21u?=
 =?utf-8?B?ZkZQbWpFSlV0Nmdlc09qeXE5SmcrSm1NdjQ3R2dGSlZjY01ZN0p0bSttT1Fm?=
 =?utf-8?B?RUJWU0I1M2NRZm82WkpoOEtnSnZTbGRXVTJFT3gzVUppaWI4UlE3WFI2SXhV?=
 =?utf-8?B?ZmpMaVVnRzlBSnB4cGk2QjRpbWpHR2c4RVI1aGRNS2s0Rkl3M21FRVd3Z0x6?=
 =?utf-8?B?UjQrYjdraVZyV3lVbFAxTzZubzNNZjhuc3dBTHgwc0pXRnBad1F3Uk1LWmVK?=
 =?utf-8?B?L3BQNjd4MHVVNS82RDJSckMvUTRtWU91YnU0Z1drdGpyL25TOTNoaFlWWlQr?=
 =?utf-8?B?VS9pUXgzS0ZRd3RmRmRrUXR6T256TTQ2QU9keDNqQmJKRFlxYU84SVkxeDMy?=
 =?utf-8?B?OWl1VHo4ZExVYXFYZWtqKzgranowbjRtQ0lVT1JRVGErc1hGM3B1dXZTMEtJ?=
 =?utf-8?B?YzF3ejdNamtlcjQ1TDJ3S2w2cXdZa2QrUXVzdXYyR1FGZGUrcUZwNUwxNmdP?=
 =?utf-8?B?UGRaSFlDTkZsQzdvTndCaVBZamFQamtQUFR5ZUxZQXNVVmlmeFBMOE1NM2xx?=
 =?utf-8?B?R3BXTnhUKzZURlp1ZXV0US9kcEJieFhUeEtidWYycHo0azU5RU1DOVFqV1c0?=
 =?utf-8?B?QytrOVU5djV6VVVyMDYxM3d2Mzl0NWQ1SlZtUzZJQlR3Y2FOUG81YzFTNU8v?=
 =?utf-8?B?elNZc3EvVXhSQXpHL2NwWDE1UFM0b1cxNVpBK0J6b1VrNyswbE40M0lrdDF6?=
 =?utf-8?B?RGpmTzNaeEN1T21VU25jZVl5dTVUc2ZDMloveEU2UytOOXlHRjc3NHRxTGpu?=
 =?utf-8?B?M3FBVlY3UjhHN041T284Q0NGbW81dk9xQ3ZXdmxvN0MySWlNZjdmZGc4dzZ1?=
 =?utf-8?B?bGVyak1nc3dzeGFJMUdodkZtMEVoQ2JqcGlvZmhNcFB5ellkcU9oa0ZVSURW?=
 =?utf-8?B?bTM5ODBZSmhSTktsZk5vSjc5MnlWcExlNHdSK0oxcm9wczBKNzIzYTFqenc2?=
 =?utf-8?B?bFVyazQvdkdsQlFQNjdzcW12Z3RsWlNtbGdwV25WbSs5MEJhL1FXVFc4NERl?=
 =?utf-8?B?YmpWdGNLYmxTR0QrQnp2SGpZZXh4WnoxVWFnR1V0TXdGUkNPQXJ1OTRaODdE?=
 =?utf-8?B?OWZvYXN0VDZsWXc5N0E1S28rY2ZXQW1mTytydkNBWmNFZXRXeVJZWEpCSm9p?=
 =?utf-8?Q?5FemrOlpr0PCfGz/8mugH0c5C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a61e4dd-424b-4294-1ed7-08db3131b084
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 15:16:09.1098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pao3HU9SsBbBcdXbrfb9K+x/EugRqAukp5Aw3Y1gfQnY5Fi7GF8TRdxztmOI7Q0CRPnw/Hvo15A0lb3MT41ztA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
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
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/30/23 09:01, Luben Tuikov wrote:
> Hi Alan,
> 
> Inline:
> 
> On 2023-03-30 06:48, Christian König wrote:
>> Am 30.03.23 um 11:15 schrieb Liu, HaoPing (Alan):
>>>
>>> [AMD Official Use Only - General]
>>>
>>>  
>>>
>>> Hi Christian,
>>>
>>>  
>>>
>>> Thanks for the review. Please see inline.
>>>
>>>  
>>>
>>> Best Regards,
>>>
>>> Alan
>>>
>>>  
>>>
>>> -----Original Message-----
>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>> Sent: Tuesday, March 28, 2023 7:16 PM
>>> To: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
>>>
>>>  
>>>
>>> Am 27.03.23 um 17:20 schrieb Alan Liu:
>>>
>>>> [Why]
>>>
>>>> After gpu-reset, sometimes the driver would fail to enable vblank irq,
>>>
>>>> causing flip_done timed out and the desktop freezed.
>>>
>>>>  
>>>
>>>> During gpu-reset, we will disable and enable vblank irq in
>>>
>>>> dm_suspend() and dm_resume(). Later on in
>>>
>>>> amdgpu_irq_gpu_reset_resume_helper(), we will check irqs' refcount and decide to enable or disable the irqs again.
>>>
>>>>  
>>>
>>>> However, we have 2 sets of API for controling vblank irq, one is
>>>
>>>> dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has
>>>
>>>> its own refcount and flag to store the state of vblank irq, and they
>>>
>>>> are not synchronized.
>>>
>>>  
>>>
>>> This is the source of the problem and you should address this instead.
>>>
>>> The change you suggested below would break in some use cases.
>>>
>>>  
>>>
>>> In struct drm_vblank_crtc we have a vblank irq refcount controlled by drm layer, and in struct amdgpu_irq_src we have enabled_types as refcount for each irq controlled by the dm.
>>>
>>> I think the best solution will be to get rid of the refcount in drm and only maintain the dm one, and add a crtc function for the drm layer to get the refcount/state of vblank.
>>>
>>> But this may be dangerous since it’s a change in drm layer. Do you have any comments?
>>>
>>
>> You don't necessarily need to remove it completely, what you can do as well is properly chaining of them.
>>
>> E.g. when the DRM counter goes from 0->1 or 1->0 it calls some function to enable/disable the hw irq. In this situation you call amdgpu_irq_get()/amdgpu_irq_put() as appropriate.
>>
>> The the code in this patch already looks like it goes into the right direction regarding that. It just seems to be that you have some race issues when you need to add checks that the IRQ counter doesn't goes below 0.
> 
> Changing the DRM layer is generally not a good idea, unless
> there is a compelling reason to do so, like fixing a bug, or adding
> a new feature benefiting all drivers. As there are many drivers using
> DRM, any changes in DRM are vetted thoroughly and need a good reason to
> take place.
> 

While I agree in this case I also observe that we sometimes shy away from
DRM changes when they make sense and instead do weird workarounds in
our driver. I would encourage DRM changes when they make sense but when
one does so one needs to make sure none of the other DRM drivers break.

Harry

> I suggest you follow Christian's advice.
> 
> Note that there's already a callback from drm_vblank_get() down
> to amdgpu_enable_vblank_kms() which calls amdgpu_irq_get(). Perhaps,
> you can leverage that. Similarly for the drm_vblank_put() to
> the amdgpu_vblank_put() path.
> 
>>
>>>  
>>>
>>>>  
>>>
>>>> In drm we use the first API to control vblank irq but in
>>>
>>>> amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.
>>>
>>>>  
>>>
>>>> The failure happens when vblank irq was enabled by dm_vblank_get()
>>>
>>>> before gpu-reset, we have vblank->enabled true. However, during
>>>
>>>> gpu-reset, in amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state
>>>
>>>> checked from
>>>
>>>> amdgpu_irq_update() is DISABLED. So finally it will disable vblank irq
>>>
>>>> again. After gpu-reset, if there is a cursor plane commit, the driver
>>>
>>>> will try to enable vblank irq by calling drm_vblank_enable(), but the
>>>
>>>> vblank->enabled is still true, so it fails to turn on vblank irq and
>>>
>>>> causes flip_done can't be completed in vblank irq handler and desktop
>>>
>>>> become freezed.
>>>
>>>>  
>>>
>>>> [How]
>>>
>>>> Combining the 2 vblank control APIs by letting drm's API finally calls
>>>
>>>> amdgpu_irq's API, so the irq's refcount and state of both APIs can be
>>>
>>>> synchronized. Also add a check to prevent refcount from being less
>>>
>>>> then
>>>
>>>> 0 in amdgpu_irq_put().
>>>
>>>>  
>>>
>>>> Signed-off-by: Alan Liu <HaoPing.Liu@amd.com <mailto:HaoPing.Liu@amd.com>>
>>>
>>>> ---
>>>
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |  3 +++
>>>
>>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 14 ++++++++++----
>>>
>>>>    2 files changed, 13 insertions(+), 4 deletions(-)
>>>
>>>>  
>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>>
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>>
>>>> index a6aef488a822..1b66003657e2 100644
>>>
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>>
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>>
>>>> @@ -597,6 +597,9 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>>>
>>>>             if (!src->enabled_types || !src->funcs->set)
>>>
>>>>                            return -EINVAL;
>>>
>>>>   
>>>
>>>> +         if (!amdgpu_irq_enabled(adev, src, type))
>>>
>>>> +                       return 0;
>>>
>>>> +
>>>
>>>  
>>>
>>> That is racy and won't work. The intention of amdgpu_irq_update() is to always update the irq state, no matter what the status is.
>>>
>>>  
>>>
>>> This is a change to amdgpu_irq_put() to prevent the refcount from being cut to less than 0. Does it break the intention of amdgpu_irq_update()?
>>>
>>
>> Yes, exactly that. The reference count can *never* be below 0 or you have a bug in the caller.
>>
>> What you could do is to add a WARN_ON(!amdgpu_irq_enabled(adev, src, type)), but just ignoring the call is an absolute no-go.
>>
> 
> In addition to adding the WARN_ON() as Christian suggested, and noting that
> you cannot ignore the amdgpu_irq_put() call, perhaps investigate if you can
> allow the decrement to take place and then check for negative--atomic_t is
> an "int". If it is negative, then complain, dump the stack, set to 0 and return.

