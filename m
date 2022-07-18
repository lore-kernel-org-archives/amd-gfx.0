Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F491C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 14:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 848FB8B4BB;
	Mon, 18 Jul 2022 14:37:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25CDA8B4F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 14:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/J/eqHYvn8SyA7MghWoXZOuq8X0mswyXlmMWI5ZXyWeXUvRphxdRpFh8pt1PIvHtVWe0bDYe42au8p/Wcw2roL59ObgwHa7n4gB5sqblhzIYr7Ky62gk35Se8Ob/cnvZfW8N0WHuNABP6/EQt9t8SuzOxVj5Z1wVzonFIifI5JRyq30bkIxRZo4xPdp0KUJepYBR2LyprX7JK6EZsLcsJhhqtsLGqiOnOT8gK35+uI7MRA7Pj000hy3/Ru3ZsOfZz1A1IRUnZDMOpqi12nk9ogiRwa8JFYF4NAq8RihVGYgfd8JEc6tg6Cyj1DfCoLjrh0HC3/m1oTzpDO6FLWlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7K3j0tZznGFEJORGU7eED6DMR70G9p4o66GeGCDknM=;
 b=P8f0h76Bk//4TSW7KZ8WDmBoex8WtONWCvi86+QH8/ELyxofhPZAt7ZBuSEcqHmj1GEU0xPyaotZfoNU1ta1M6AElw3gyoGgatnA0xSBQQRB17k56E7DI8pW9OmkTTuBOi6QZbIr2zG6UIbswBZYSRmL5P65454Gi6cAUiig6xqxKdHgH4Vsu/faN3hHW79ZUD/5vEdlmcZkhRV+ax/Rc2Iedn3IosMGiUCleW6sF/xEfSLijSXSFfKQoNnY7UHKmi3TvG6FlsH643S26K2eL8flRkQRxWB3NZgqZfaMqRC9ROU9DiyFTg1KDJC7ZcQImTCduPTUNK5zvQ7IH3WJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7K3j0tZznGFEJORGU7eED6DMR70G9p4o66GeGCDknM=;
 b=LJ89uwbB95t55K4zC3k9/hYFnMFvKsR7zpfHqLv5Jmu+fEbEAcWdjyiCZWrzo06W0ptA7bmkPxZ9/ii5r06akF1hj7NatPlmaXuiEQrXNOlicWuoxLI7ULCLoJDtEGOesRNg9yxyFumsaAeRWNIR0dvwiixW8ZPcmkgEjmMzJw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Mon, 18 Jul
 2022 14:37:26 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 14:37:26 +0000
Message-ID: <1126fff2-0896-1002-be28-5eb0a83beed5@amd.com>
Date: Mon, 18 Jul 2022 16:37:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Content-Language: en-US
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220715200410.301438-1-ruijing.dong@amd.com>
 <e2dbaab9-de5a-3180-13a8-cec2c8b0285d@amd.com>
 <7beb798d-73ba-7015-7b3d-441a5daef26f@amd.com>
 <4f91384a-bef6-b8da-77c1-0bd5f4e7b3c1@amd.com>
 <SJ1PR12MB61946514C9D9B9DF87C9CF06958C9@SJ1PR12MB6194.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <SJ1PR12MB61946514C9D9B9DF87C9CF06958C9@SJ1PR12MB6194.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0017.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::30) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd764ad2-50c5-4fec-e65c-08da68cb08d2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKH2EaVW2+P04CtzvIZ/WGlYSWJ+zAUzkMeqCmKyna6YoyhemSNm5r1hEW6XIm+HCFXB9oFTO4cnj6TFmhJtKu4Jpb30e5BYvi4YT9PpIa01yg8gWfPLTJY8PBVtaP+JIQAG8jJSMoYTyLmo9Bn+zT9kQnfI20q010Mvyyys1uyq1WSToRey3B2tDoN/UEzfuuH+pNDQwjirVt2kM24Axe50SZsy5deaY9bxeUsrE7Vt3JrED9N0W10kQIv0iXs0u8fkrwI870XskM6n0k6BJKofcEVfzgPn5K5OBCalmP/H0lUcs4nZUiWm6X/QW+Oj9E7T+THjoKzvsu6gzBmV7jL64rDBI6ozd/Y/sq/dEcrgGRRmjQNw1p7skLr+rx9Nlxywxzs1rxblPDhZ0zjohDuTIl/BoniOHcYtsHfBgjYRK6/Dc19KoPSS0d9hPMDuqMZ/aF01FTKP9Xxifrznrkf41W1DKAlu06kLcccIak1keGeAv5lZkQXQBA4CCYQo2/nPVbrFT0HI5d5BvAi2dZL4653tCLYUYY/NQE1QN4qK3m3fGUaRAM+p7mMP+3cSEjsFKxbjMhg/9ZeNyPBWgFZ1uKR9ulePrAj4QSs9ubN43Fa72SxUHgBjTZp6AphDZ70i837ZBLhfDfTQLYMil8aDzzwocaCFSB8ERhzXrmo3c0m0DNwkRpcqfzOftO0/vAn+E2L+j5w5bnMrUWt3p/ASPYxKlmoCJ3LsZ6HRvythIpaz7u9MWAcJkyhJcDkawyAGWPNPOU3/IYSVN9qkxi/QmnjW2av33xxZs1uTbwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(6666004)(41300700001)(316002)(6512007)(966005)(110136005)(6486002)(6506007)(31686004)(36756003)(2906002)(66556008)(38100700002)(5660300002)(66574015)(8676002)(4326008)(66476007)(66946007)(83380400001)(8936002)(186003)(478600001)(53546011)(31696002)(86362001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWpGekcwRkxmQlJ0V0FNWGlxRzUrWFRWZ0VpeVBFeUViS1hWTUp4aGpmMHlY?=
 =?utf-8?B?d0xISkZsbjRwRkoyR09sZ3VFcFZlR1NJYkRnTEFsanRNN25EcXpwR1RGZG41?=
 =?utf-8?B?UHNQblFDNDhLOUdLRmovVGJSTm1PTHBKQ3U0czZNNzZ6R1ZqVlJSQUdtSGIw?=
 =?utf-8?B?eGIxNGJSelBGRFRNR3RPRVI5Q09ZQ3NrRmZRYVJZVVJlRXErUUhzcVJLK256?=
 =?utf-8?B?SWp2QURPYjhpY3hFNkkrbmVDVTZvbjE0MXd2SHVWSDMyUjdSWjFRTnVWU2FR?=
 =?utf-8?B?Z1IyVXl3TTVyMWNOWHp1d2gwQ215MXJYZGxvaUtOc0NDL2I1bWw4MjJPN3Zz?=
 =?utf-8?B?eUU3YXdqbzE1VzYrTlVpa2ZwL3pXNnpBZ0lEc2JhcnV5UWFEOEYrT3JQL1hU?=
 =?utf-8?B?NEY4dzJvZGRiWDl5VkdwWFU1cWZaZTZ2bzFVL1drYUs4L21od1dMMFdjUUZo?=
 =?utf-8?B?Ui9uazloeEl2KzRxNFNZQXRGQjlpcFg3OVRYR0hyNFlkbUNsVEIyM3dqSEVj?=
 =?utf-8?B?U2hBaFVHQlhnSkNlbnFLbnlKMWFFYlpqTmNLMkRGM3RyUE4rcFNJc29LdDRD?=
 =?utf-8?B?ZFdpY2d6V0VwWUpHczVMZDdZSUJGamFnUHJFTTc5ZHcwMmFVSlRScXdDdVd4?=
 =?utf-8?B?RFVjL0RMdFdqR09RcVpiZEVoc3dwSEZScVNsWDl6bExwQWtoSHVRYlNMRFpj?=
 =?utf-8?B?ODhHckV5V2tUaTdxbEV3ZmNhOFBPQWUvYmlzTlkwdGxheHROL0N6endLY1ZB?=
 =?utf-8?B?d0FrVndueVFhWCs5c1o1em1OTHFpdktQRHJIWEZucFVmVEpOTS9PSXJEcHJl?=
 =?utf-8?B?QzNzN1V2dDBCL1FVK1FDNTN3YTZYK1lnWWJzVGRGQzl6dVVaUENqdm1yWUl0?=
 =?utf-8?B?WlpUcmZnQjlvY2lxSXEybnRDcU1wOGhlUUxsS0RrOGMrdXBqZmtGWFVVRkdx?=
 =?utf-8?B?Q1dyYTNQbklLOGpyVlp0M1RSd1JudDZIaDNCcnRucHhGbnViZXRyUGZsd1Zs?=
 =?utf-8?B?NWVxclFHSnZ5NnduWXVzRmpCcXIyQ3hWZ0VHbHNUc0tGSm8rbFlpblJmOGVj?=
 =?utf-8?B?eWduYU8vbVJjRVpUbm8zMUVoZ2dlNHlzUU9aZ3N6U1BraEs1MHBkUHVxQVZk?=
 =?utf-8?B?ZlhWbFFHdVBLL2pKVy9Sd3pmUGp0OUdnSzQzK0VvWHZPTGNkVGxVTmhUQS9K?=
 =?utf-8?B?NTE5czVXMmdJcVNxaTVHdHNjd1JVODdoWXhsRWdIQzFULzlWckNGbC90c0I5?=
 =?utf-8?B?M2JDdHNRS3FqT0FsMUNWdDJhWkdBNGFuS0tvbmlHUTNOU21uSlYvOWJQRnhU?=
 =?utf-8?B?S3ZMR0h4Si9YeHMvVkxhM0JZQS9nay90cUg4aXFXS2ZJMlJmb04yRmFxVUdS?=
 =?utf-8?B?WHMwbzh2a0taTFBJc3RhS0JObEJ6MVdaMkpiQ1UvNk1kQis1b3A0ZDF3d0Vt?=
 =?utf-8?B?S05YeVJRL0pQZmw1SVUxTmp4ejBhWFpjemNndTVxQmpBc0F1MjFpbmFYZEwx?=
 =?utf-8?B?bUtGaHlDMHRzS1RBckR3SEVpVUdFUWkybU5Paks0NTRiUWRvOFhLZURzMTBH?=
 =?utf-8?B?K01mWlJaekxvMTBXL05FSWtWOUlYMDBLcVEyazY1RUt1d1VyOU55S2tkSnpE?=
 =?utf-8?B?TmIzU0JtY1puZWVuTWo1Ti82ZUFFZXlCSzBjSUEvYUU2cVJoOW9oUituQmhT?=
 =?utf-8?B?QUtBY2VhbGo0VWV1ZisrVC9IVTR6b2U1OHU0SFpYVHM3TmZZcFJMKzJPc1cx?=
 =?utf-8?B?RkFoYjhoaUJ2Q28vVkRQemVtNVhacXNaZzhOSVZQRXpJeWZKbUg0U2x2UUZk?=
 =?utf-8?B?ZjVHYzJzQ0pabXhrRXRJazFLbFZJTUlZaDNHaWROdm9ySnQ2WGxQTmlaaFRN?=
 =?utf-8?B?enVtV2NQd3dvWGNMb0hoandpdmFYZkdOSVpwY3ZkQlJJdXpqTHg1OFIxaURG?=
 =?utf-8?B?NXJMRHYwMFZHbm1TQktVVjJEY3J1UndrSkFtaGtIM1Nzb1krejBMZVA3T2lZ?=
 =?utf-8?B?VTZpZFR2Z1R4ejhpMDFHUXFJOW5ya0ZyRzJ1N0NySUVSQkx5WHNKNzdwM0kr?=
 =?utf-8?B?cTNOOHVLc3ZwbnZjdnc0elVwN3FTMEFSa3MzM1F2QWdwZzQ1WFRhUEh0cWpP?=
 =?utf-8?B?ZlQ2Vm50SklXcmszQ3NVT3NzMUVBMWM2bzlSVUVLNGNvblZCM2ZacmJOTHN4?=
 =?utf-8?Q?6RvIdfCXqvyQzhlSJ+WqH8ya5x15lekYr5jGS4s6dn2b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd764ad2-50c5-4fec-e65c-08da68cb08d2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 14:37:26.3129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jl00dB+mnxN6rK+VTEr8rQGxolTgacRBRTAkynwHeZO0+Y3ShjA8944FVdQr2CJs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.07.22 um 16:14 schrieb Dong, Ruijing:
> [AMD Official Use Only - General]
>
>>> What happened is that the encode ring was extended with decode functionality. In other words we still use the same format for encoding, we just added another one for decoding as well.
> Just to clarify the format difference between legacy encoding and unified queue, we can do either way in the code.
>
> Unified queue requires a different format. The original encoding/decoding format cannot be used in unified queue, which requires to have two new headers, "engine info" to indicate the coming IB package type, encoding or decoding; and the "signature header" to guarantee the coming IB package's integrity, if this failed, the whole IB package will be discarded by VCN FW. That is why I was thinking to have a bias of AMDGPU_HW_IP_VCN_ENC could be better in the future.

Yeah, but the remaining packet format is the same. And as far as I know 
you guys don't plan do clone that for some reason, don't you?

Adding another name for the same enum value can potentially be much more 
confusing than the fact that the encode ring now takes a bunch of more 
commands to do both encoding and decoding.

Regards,
Christian.

>
> Thanks,
> Ruijing
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Monday, July 18, 2022 9:54 AM
> To: Liu, Leo <Leo.Liu@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH v4] drm/amdgpu: add HW_IP_VCN_UNIFIED type
>
> Am 18.07.22 um 15:48 schrieb Leo Liu:
>> On 2022-07-18 02:57, Christian König wrote:
>>> Am 15.07.22 um 22:04 schrieb Ruijing Dong:
>>>>   From VCN4, AMDGPU_HW_IP_VCN_UNIFIED is used to support both
>>>> encoding and decoding jobs, it re-uses the same queue number of
>>>> AMDGPU_HW_IP_VCN_ENC.
>>>>
>>>> link:
>>>> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/245/commits
>>>>
>>>> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
>>>> ---
>>>>    include/uapi/drm/amdgpu_drm.h | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h
>>>> b/include/uapi/drm/amdgpu_drm.h index 18d3246d636e..e268cd3cdb12
>>>> 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -560,6 +560,12 @@ struct drm_amdgpu_gem_va {
>>>>    #define AMDGPU_HW_IP_UVD_ENC      5
>>>>    #define AMDGPU_HW_IP_VCN_DEC      6
>>>>    #define AMDGPU_HW_IP_VCN_ENC      7
>>>> +/**
>>> Please don't use "/**" here, that is badly formated for a kerneldoc
>>> comment.
>>>
>>>> + * From VCN4, AMDGPU_HW_IP_VCN_UNIFIED is used to support
>>>> + * both encoding and decoding jobs, it re-uses the same
>>>> + * queue number of AMDGPU_HW_IP_VCN_ENC.
>>>> + */
>>>> +#define AMDGPU_HW_IP_VCN_UNIFIED  AMDGPU_HW_IP_VCN_ENC
>>> I'm still in doubt that adding another define with the same value as
>>> AMDGPU_HW_IP_VCN_ENC is a good idea.
>> Hi Christian,
>>
>>  From VCN4, there is no VCN dec and enc ring type any more, the
>> decode/encode will go through the unified queue, so using
>> AMDGPU_HW_IP_VCN_ENC is no longer accurate . Keeping
>> AMDGPU_HW_IP_VCN_ENC type is for legacy HW, and the new
>> AMDGPU_HW_IP_VCN_UNIFIED just happen to use the same HW ring as legacy
>> encode ring, so reuse the value, and that is the whole idea.
> Yeah, I understand your reasoning I just don't see it this way.
>
> What happened is that the encode ring was extended with decode functionality. In other words we still use the same format for encoding, we just added another one for decoding as well.
>
> Renaming the enum and adding AMDGPU_HW_IP_VCN_UNIFIED suggests that this is something completely new, which is not the case here. The encoding commands stay the same, don't they?
>
> So to sum it up my suggestion is to stick with AMDGPU_HW_IP_VCN_ENC and just document on the definition that this is used for both encode as well as decode starting with VCN4.
>
> Regards,
> Christian.
>
>> Thanks,
>>
>> Leo
>>
>>
>>>
>>> Instead we should just add the comment to AMDGPU_HW_IP_VCN_ENC.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>    #define AMDGPU_HW_IP_VCN_JPEG     8
>>>>    #define AMDGPU_HW_IP_NUM          9

