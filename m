Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98FBC04A68
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 14:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42DB611A711;
	Wed, 27 Jul 2022 14:34:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372D711244C
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 14:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEOkbyTPWTP4Ek+4n5zR54CZbWfKLUml3aCCEYOIuXjXRXPqDG70AiA5WuLKgMMmafioKy+rr5K3YwSllTijRu6CgAiu1HwIKp2c0cXbdrnosNgutkaoWs8g9zU/O9qN/IVDwVximyDqaBqiRVhC28LjcjY3VBCkpHm76ifk8TRXetClYi69uwY/le4YyQ44Dk0tHHfeqCY/GC7PRpmCtdODv6O/RDssxM4uQhtCb4G8FU6p8gPEQjG6catDfgpoHZKtoocLSz2M1IChUBFIvhP/l0r/FcjCG4H+alRSzRKWUWzyyAVEVFqMVsR1NGWTECffsrGZusZSG2/l9yAYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJefaT9Hh4SiQ5AOV4XrQOcTl3mutg6I+hPY32wfa4I=;
 b=adpRCkKPLz8k6ElgdR1w2ITlNnSre9Wrrm9bo8QRZ7AMIvNDBlVwTcLEATMu4+4vNe1g+X5EK/9wMP6r0ZMly+NN3IVHIEcKTwf+O2cSXBKANmXOyAXQJ613paSMHdwIia5ty9TLgIqU6+9rYy2q44lZQl6dxWNbnHpBJaDrKVfRqhgbDTcdFDMAvbs/MeZWcD1Tsm1Pj7lL2aEPoz9Ju/FOt66o6HkP8RsHOiWm9n1jxnBo6ldhJ239CJmMbJ11Lf7iDl2scCUaatjdjLZBX+LyIegziB0iYogoymGhctJj3wiq4XaY1hceSIAUQ/KtE5heuVgsHTAu+Ki/ztk9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJefaT9Hh4SiQ5AOV4XrQOcTl3mutg6I+hPY32wfa4I=;
 b=IGn5vvWtWs1EoCXBqpoQ0wBld4LeSo5MNEzBJa+IA3VoxWJn0Uxq4kZA1Wmctq95Q1dw4R+DAMSwelmQjlfBAyGrgNPyUQGdwjz9WuCquvVlMOrILw2Xw/vUyTIyXci4bxVC53qQ3dAv9V+9M/uKzm5bkwmI/D6PpgtKVUCGS14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM5PR12MB1673.namprd12.prod.outlook.com (2603:10b6:4:e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.21; Wed, 27 Jul 2022 14:34:53 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 14:34:52 +0000
Message-ID: <1395644d-0fed-0c83-aaa0-1b644206e730@amd.com>
Date: Wed, 27 Jul 2022 10:34:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/5] drm/amdgpu: reduce reset time
Content-Language: en-US
To: "Zhao, Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220722073403.5171-1-Victor.Zhao@amd.com>
 <20220722073403.5171-5-Victor.Zhao@amd.com>
 <85e76646-4b14-2d33-8143-0fe0095afa25@amd.com>
 <DM6PR12MB4340889B38A77BBCC4E0486CFA949@DM6PR12MB4340.namprd12.prod.outlook.com>
 <933c6777-d658-138f-1350-83c4c547bbf0@amd.com>
 <DM6PR12MB4340A5528AC522964422BFB7FA979@DM6PR12MB4340.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <DM6PR12MB4340A5528AC522964422BFB7FA979@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::34) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 074c2520-4b62-4743-4fad-08da6fdd2ad3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1673:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwtTTTzctBC9m5tRvPqYjGwmv3p8NIy7ogwxsPqWTnB/84kqTpjcOtUeNWFIrKlWNtCbwrdT+Z7WlJdEpQ46abIvD/38VzzTjudMVyhlrvtoDJJoFX++Eh3hzsszaJTQHFucQHrygfxI4ntVJp+HpPDGMSukTuKIHU/VnIsGdSuWPFLF4862sppXBEs0agX7FuW47NXMTPGdAo2OJ6dqLuRF9Afn5m4XGWEwR8f1Ez/RK/2fkwvHql/eTxui12LgRcISjB6YaoNdYkyRe9r0QY7Hle3mqr4Q/uIyazBnCjzGN4gZ70Innx/NBiTbT2AawfoMTwVEMQpCxHgS4ycAshFnVqhB0E3TEExCPItVukwUInRJ1SbGyCHJVO9cKl1Hk+X2rt5jF31ltur12TvEqghT9lwWYh8iLhsUY8tST5Y8oy6XmorASfFc9CfqbbCvdkt2x602OcumEtfBdu+nI9q6KjSkNPwRTLsGDgU9ZN7R6lebP+OtGmczs30LbBFmQUzcS/tugm5dzn1Uk11M/byWsV/2gcWZtqPvDqxtrGagc5SaTLerasLoO7oLYygXqvTGsAFyW2ZmpPMxBr2OTNEsdqbCPWFeCrq5IGYK/mv6ykZFvc20hhb+3OirisQfttQPDLOtz+lzk1tan65qBWTjhloJUGMI/qMY1yL++VzTwbEffTkP+5ypt5upGNghxBt57VAW04oaNCoKQrioUNetDdXHHQtOb1JbUASsQMP+vlyE84cEutk3YIsx4B33GdRMVv0OSdt8a2SPsYqG/qeh6b+4IgegnAOFVh7DPcaeiGe9dnvWgDZmtyUF0q6m8B8MgUd5wE2yZGgWOF6jdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(41300700001)(36756003)(38100700002)(478600001)(86362001)(31686004)(6486002)(83380400001)(6512007)(6506007)(110136005)(2616005)(31696002)(4326008)(8676002)(5660300002)(66556008)(8936002)(186003)(44832011)(66946007)(316002)(54906003)(53546011)(66476007)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXFmSi9NRlB3SWVKdGdQaWYxOS90RVlRSkovdzZYS3NJRU00S29kaURSMDly?=
 =?utf-8?B?VDRNemtVRU1ZNEFzWndFYTlCVHZqRUtpbGZqZWN2SVU2d1Z0dVU2WlVSTG5K?=
 =?utf-8?B?NDRzemJwMCsvQW9sdUJ6MUVDT3YvTEVzSm5neDBTaEZTWnBHVGZSMUdEMnR5?=
 =?utf-8?B?bldLSzRYaFpjcUExUTcrd3hFVC8xdXVGMXV2dTk4UFowS3ZDazhzK0dOZFMy?=
 =?utf-8?B?TERWSHpiTXUzWnkzZERGcnNxTGdSd2YvUTVNaFZNa0xRZzhFWU54VEExWG5L?=
 =?utf-8?B?S29mKzlWMkF5dEkwK1p3Q2pmWGw1clJiRWMxbEVZWm5BZGxXQlM3a3Rsc1NY?=
 =?utf-8?B?Ri9MdVlLUzBXZ0NrQnlDQ3JTQU9LV3dMTGZ5N1BJaGhHV2FuSXQzd1REdkp5?=
 =?utf-8?B?MVBXdzUra2JUcTNWL2xjdlhMNDJVQ211NU1XUHlUNC8zUWl5bm9MeUxtVExL?=
 =?utf-8?B?WnhxWVNVT3grNG1YVWJrMk9mV0FIWk5Zb1NWYWJQVjFFaUFtYndQbGpKS3M1?=
 =?utf-8?B?bnAzV3hmWHFST1VOdmVCZ201NWZpL2o5cjh3a1lxQkVxWnc5ZVA2R29jcWgy?=
 =?utf-8?B?bGhKVnNmSXhhMFdFK1NTdWhyaWg2WU1DTm56UFptS2xVUVpidXBEMWVBWmRW?=
 =?utf-8?B?UHAwSXh0eE4zTjRidGZnalkwUjZKRmszaHRXT3RweTI5OHpnMThEZEVwZi9n?=
 =?utf-8?B?cWFaSWtobnBGNmV3K2FIYTc0T0RQZk5GUkhwOFdZZUJrWjJ5MkxXTHV5K1Z6?=
 =?utf-8?B?UTBSaHN6OFBOZFlQZi9jSjhaYkZkN1dmZ05ZV0JsK2hEMmpaL3oyTG9mbElS?=
 =?utf-8?B?VGlGbHpuWGpuczJ1d3p2MTViMjdEdHU0bk5XNmZYS1E0ZC9PMDk0VjZscEpm?=
 =?utf-8?B?dnhtYWVnRFlDUzNHcXVxOUIxODdWMEVsMjZ2cUt6U0ZYa3NKWmpOTDJ5YUlm?=
 =?utf-8?B?Ty9yNjFUR3RiYmVSbWxYYUdTQU9KZ21aN25XdEJhUU81V05RMWdYSnMvaTZa?=
 =?utf-8?B?Y0hOY2dycG9QNG1NUFFLNXhHU1dVbWozZzhEWkFsVEsra2RrNG1Fek5nTGRp?=
 =?utf-8?B?dFVodDRSdnAya0tLMHdmSXRqQ3o0cmdFVFgzdnZSd1gwNUJkK1BiREJtck5o?=
 =?utf-8?B?ZUtSQXdWdlozS2VEQUsreU5CYTB0bWk4dmVKbW1BWUdqcE1zdkx0VlNTNW00?=
 =?utf-8?B?RG8rNmNsY0h2dURaMU9JOStjUFZ3ZW8xM1AwUzBwaFExcHh1NTJpY0lKb0dY?=
 =?utf-8?B?T25rS3NTVzVrTC8zQUxLMmh4TzZkMmg2UWtmRnVYYXkzZENqUTB5Vi9LSVdB?=
 =?utf-8?B?TFgwZXVUS2lOZE5UWUQva0NadFJTZzBrZC9LTlp1TlNHNm5RVlN0SXFaQjRt?=
 =?utf-8?B?MzN3VUFyN2JjQjZpeDJIeGJHOTJ5d3I3eTNNK0xZQjRFdXgyNDRmd1hrRU1s?=
 =?utf-8?B?ajVzOGVzOTlNbytkRGlaWHI2YStsSVBjRENiRFM2alBMZnFEV2J3SFdMMXhm?=
 =?utf-8?B?T3h1REhvMmJuVnlvRjU1VHpSN1Q2T0I4OU14aXJlbjB0ZzZHNFl5aS8xa3pX?=
 =?utf-8?B?U3JwWG1rWncvbUV3TnB4WVhaVmcrR1pwU1p1aVNmazhKVnpLeCtpSUxTZVJP?=
 =?utf-8?B?WXZScVBIUC8velJtNVBlSmJ0elZmU3BpN1o3L3U3ajBUR2Z0RWZkeDd6a2wy?=
 =?utf-8?B?Y3dQWkZzWUlSd0N5RjBXenE5dmFPcGZLYzVscjJBZ3dRU3ljUVNSajNGREVp?=
 =?utf-8?B?dFVtSUt4MEhoU2E4TzQyanRPK3p0OTdtSjlpT3dyaDU4Uzh4QTA2VVpIVFdt?=
 =?utf-8?B?Q1lzWEhPKys3aS9vMXozbkNONlY2aFFhUHFZQnYrZGM3V2lLbElxaUN4cllw?=
 =?utf-8?B?VnIvbUwzSHVYT2gwODF6NFFra1dkdCsydEI0OHlUSUZqeGVqR0ZXRERCR1Zj?=
 =?utf-8?B?R2plVEt0QjdoaitDenMzWEdWMFpJM2lZb3d6dnFaWmVsNFRvWitSZVEyQjdU?=
 =?utf-8?B?aEZyWXlGTHRDQjA4bW9tN3JiYUw1Nk9aaWg5T0VzY0w1Z2h1NnR5ZmFtbkh2?=
 =?utf-8?B?Sk1JMU85eTV0S0EwRzJKcG1ScWpkSk91cWF6bGsvYmZtL3VqVnZuZkRRcXg2?=
 =?utf-8?B?MTFwaTdMeVY2ek5FUmFCZGkxNU9JSWJrY2VVMEdlWUUyQ0FLYWVrTnllVFhU?=
 =?utf-8?Q?LSYErMOIKKeUrP83Q0j5THwr4xBbQ9ijVGkVoqZuybkR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074c2520-4b62-4743-4fad-08da6fdd2ad3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 14:34:52.8137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbhSlzITCTzuG7wd+kUtjJA4mgSMB4E4I/ZVgr1uqSRhyI0DUrazfWXwn8Kx7pRRPBetkwoVGNbOXI1a7nVQTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1673
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-07-27 06:35, Zhao, Victor wrote:
> [AMD Official Use Only - General]
>
> Hi Andrey,
>
> Problem with status.hang is that it is set at amdgpu_device_ip_check_soft_reset, which is not implemented in nv or gfx10. They have to be nicely implemented first.
> Another option I thought is to mark status.hang or add a flag to amdgpu_gfx when job timeout reported on gfx/comp ring. And this will require some logic to map the relationship for ring and ip blocks. This way does not look good as well.


I don't think we need this at the ring level, its enough to know that 
the reset you are going through is because of one of rings are hanged to 
apply this skip logic, it's pretty easy if we add 'bool hang' flag to 
adev->reset_domain
which u can set in the beginning amdgpu_job_timedout and clear in the 
end. No protection is required as all the resets from all origins are 
serialized with timeout handler in a single threaded queue.

Andrey


>
>
> Thanks,
> Victor
>
>
>
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Wednesday, July 27, 2022 12:57 AM
> To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH 5/5] drm/amdgpu: reduce reset time
>
>
> On 2022-07-26 05:40, Zhao, Victor wrote:
>> [AMD Official Use Only - General]
>>
>> Hi Andrey,
>>
>> Reply inline.
>>
>>
>> Thanks,
>> Victor
>>
>>
>>
>> -----Original Message-----
>> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>> Sent: Tuesday, July 26, 2022 5:18 AM
>> To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Deng, Emily
>> <Emily.Deng@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH 5/5] drm/amdgpu: reduce reset time
>>
>>
>> On 2022-07-22 03:34, Victor Zhao wrote:
>>> In multi container use case, reset time is important, so skip ring
>>> tests and cp halt wait during ip suspending for reset as they are
>>> going to fail and cost more time on reset
>> Why are they failing in this case ? Skipping ring tests is not the best idea as you loose important indicator of system's sanity. Is there any way to make them work ?
>>
>> [Victor]: I've seen gfx ring test fail every time after a gfx engine hang. I thought it should be expected as gfx is in a bad state. Do you know the reason we have ring tests before reset? As we are going to reset the asic anyway.
>> Another approach could be to make the skip mode2 only or reduce the wait time here.
>
> I dug down in history and according to commit 'drm/amdgpu:unmap KCQ in gfx hw_fini(v2)' you need to write to scratch register for completion of queue unmap operation so you defently don't want to just skip it. I agree in case that the ring is hung this has no point but remember that GPU reset can happen not only to a hunged ring but for other reasons (RAS, manual reset e.t.c.) in which case you probably want to shut down gracefully here ?
> I see we have adev->ip_blocks[i].status.hang flag which you maybe can use here instead ?
>
>
>>
>>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  2 +-
>>>     drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 26 +++++++++++++++----------
>>>     2 files changed, 17 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> index 222d3d7ea076..f872495ccc3a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -477,7 +477,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
>>>     		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
>>>     					   RESET_QUEUES, 0, 0);
>>>     
>>> -	if (adev->gfx.kiq.ring.sched.ready)
>>> +	if (adev->gfx.kiq.ring.sched.ready && !amdgpu_in_reset(adev))
>>>     		r = amdgpu_ring_test_helper(kiq_ring);
>>>     	spin_unlock(&adev->gfx.kiq.ring_lock);
>>>     
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index fafbad3cf08d..9ae29023e38f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -5971,16 +5971,19 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
>>>     		WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
>>>     	}
>>>     
>>> -	for (i = 0; i < adev->usec_timeout; i++) {
>>> -		if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
>>> -			break;
>>> -		udelay(1);
>>> -	}
>>> -
>>> -	if (i >= adev->usec_timeout)
>>> -		DRM_ERROR("failed to %s cp gfx\n", enable ? "unhalt" : "halt");
>>> +	if (!amdgpu_in_reset(adev)) {
>>> +		for (i = 0; i < adev->usec_timeout; i++) {
>>> +			if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
>>> +				break;
>>> +			udelay(1);
>>> +		}
>>>     
>>> +		if (i >= adev->usec_timeout)
>>> +			DRM_ERROR("failed to %s cp gfx\n",
>>> +				  enable ? "unhalt" : "halt");
>>> +	}
>>>     	return 0;
>>> +
>>>     }
>> This change has impact beyond container case no ? We had no issue with this code during regular reset cases so why we would give up on this code which confirms CP is idle ? What is the side effect of skipping this during all GPU resets ?
>>
>> Andrey
>>
>> [Victor]: I see "failed to halt cp gfx" with regular reset cases as well when doing a gfx hang test using quark. I haven't seen a side effect with Mode1 reset yet but maybe shorten the wait time could be better?
>
> Same as above i guess, it would indeed time out for a hung ring but GPU reset happens not only because of hung rings but for other reasons.
>
> Andrey
>
>
>>>     
>>>     static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct
>>> amdgpu_device
>>> *adev) @@ -7569,8 +7572,10 @@ static int gfx_v10_0_kiq_disable_kgq(struct amdgpu_device *adev)
>>>     	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>>>     		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.gfx_ring[i],
>>>     					   PREEMPT_QUEUES, 0, 0);
>>> -
>>> -	return amdgpu_ring_test_helper(kiq_ring);
>>> +	if (!amdgpu_in_reset(adev))
>>> +		return amdgpu_ring_test_helper(kiq_ring);
>>> +	else
>>> +		return 0;
>>>     }
>>>     #endif
>>>     
>>> @@ -7610,6 +7615,7 @@ static int gfx_v10_0_hw_fini(void *handle)
>>>     
>>>     		return 0;
>>>     	}
>>> +
>>>     	gfx_v10_0_cp_enable(adev, false);
>>>     	gfx_v10_0_enable_gui_idle_interrupt(adev, false);
>>>     
