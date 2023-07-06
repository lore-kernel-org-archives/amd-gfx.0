Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9012EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 07:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CB1310E43D;
	Thu,  6 Jul 2023 07:24:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A93710E43D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 07:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdMvqyaOOFI+Ct5fWOQ2cRUbAoZbdxdSS7m/W+92C/vQei4/losUXUcveLTwubvgr11BiMFjErqecNee048oK3N8kKFFaIpOQGivR1DoaO1RxCGyM3sDwk/Aq7VZhTkOysiXBCaVLEiSb2EfTHCLxUkv5jzoKTMDt8jkiRZdVnrmDZMu09xGr0WlAtxLEbnigTo/YyTUHtpx8fYjiI3dVGBJipii5Kz/EW35U7DPC7C3NqlfzoB1QiOHXahNSbefgyIV9BuGWS89vxkyMo8pSkb4oZ/lUVq3n09LQp3D06bF8a1TZ/+jMPatj621Up/RrWkTIwfpNh3YrRFv4P+WQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slb+u7WuppjTOc+R/xx028Bbe7PNEfYfugEocJ8E4IE=;
 b=DMQdOTidubGko3NZ/bDGZsN0/dBxVKdtWb5lfZtE0tqqoQ7hZqa8hNlj9CSXpkQ92+4EeOrKhpQ1SbSKxkzj701Y35JlSZx9LHh61Y5k33lNmc/k/R9k0fO3znXo+c/KQsOgEg3cwi28dIB+UpfKbx2/rKABNw13SgSrjy8e9XTKjcAeLar1kTje+zxaS6Q5w8RYKzus6oOqQ3QQ7IO8RyvG7HfJPCSNOlzUlY21876ABCn4sE7WeDirY0BsRTFgmrtobFNtXk/eWQVoc3BidpjEYuJRxMO3Zfe0vEOBrvJLHVa9EIV7M0UiHPXPNKC5GB0inX4OCDWK3bdyt6Rkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slb+u7WuppjTOc+R/xx028Bbe7PNEfYfugEocJ8E4IE=;
 b=zqbN9ZZioaMo1pMU8acxEt8Tr8ADUOUq8XiMbBnZ5MKSvMfhnptCieZmx430UCQDCEErmMxUOTc/Cq+yG1Q5WbRBw+VXAd28ASfGeOMJKVpVipNbsCEFGlNXo1L35rDE4TytNRAfH2QK7uFPW0NYENtK+ottrO0ZnGfzX3waNt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH0PR12MB8799.namprd12.prod.outlook.com (2603:10b6:510:28e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:24:31 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:24:29 +0000
Message-ID: <723872f2-b6cc-2ef6-2168-fc855f3dd7b8@amd.com>
Date: Thu, 6 Jul 2023 09:24:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Clear VCN cache when hw_init
Content-Language: en-US
To: Leo Liu <leo.liu@amd.com>, Horace Chen <horace.chen@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230620132950.1121406-1-horace.chen@amd.com>
 <9c19a828-15ed-c37a-2c07-acf29f489541@amd.com>
 <1fb0cf4f-3ea4-cd0a-64e9-9d6f22e968f3@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <1fb0cf4f-3ea4-cd0a-64e9-9d6f22e968f3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH0PR12MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 1955ceec-3910-413e-6878-08db7df20916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbYgffW4c+j1qfvmpCNkwdc5Qtb90YftLqyhsz/dEMtgt9dAXJmUxxdBr/XVgoroKW0JYGALfU00tMW3UtC0vnzsKW5nZlZx/k0OkqPuuQHoceqNn6Aj1grQl3xCYoEtuEUR4TYPeJSncL9u98xmFpnHKIxuG4xdIkmG3+8hh11Brzopda6AYc1qpZclFnyJE74w3q3sazOVHr2ZPb5WYqqLpPurcLSsPeyq+AqXZK0Gr/cPBQv21wq1WhoiXrgMm0YgV+SB9RifLO8LeQWv9fI3GMZyhvVpiL3XasP8RqHWYjHUop86ViyJ7/zbcvcX87XlX3glJMAB0NURDLkqnlO6avmzZIfWC0eVcqNpFDsc/evMRLCxetIs5UrOMYcSLDSC1lYP6squmY6Z63UimmhZMdKL2T0OZ8tt5iWUV8u3M+vRfEQ52N2vo+U1ejyUYPEDo/n3i1v1elB9fmJ5Wj7XBcCTSyNxBWv9y5aN3vo+g9adyNX+dMUUDKVOs/u5kbe5IEZmwCX/9XvAxfgnskhQF0ZnPq0k91Wm2cvc2TZwRhI0TX54NotOPWji3ddDkPk2jE9m+80WUt8wzNKbqK9Rk9uLxmWc9YWZ+ypcJ8yzPBLWbuk68e66+erTDqKysqUAFRwkasPt4VHy9E5vuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199021)(66556008)(66946007)(8676002)(2616005)(2906002)(8936002)(5660300002)(53546011)(6506007)(31686004)(186003)(66476007)(41300700001)(6666004)(6486002)(4326008)(66574015)(36756003)(83380400001)(316002)(54906003)(110136005)(478600001)(6512007)(38100700002)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXRuQk9UejQ5bjdWV3R5cldSR0FYTURwMnkzTFVuZXJmbHIxdzhWWTAyajcx?=
 =?utf-8?B?Ym5EdHdNSFMzdHRkN0FjVnVlNmRueStTZWxHb2poU2FGU2k1Lzd6Z1l0RXA4?=
 =?utf-8?B?c1ZUZ2xPMEZBQldjSXNGdENEUDFsV0NWQVk0REU1bDdzclg5WXJjYTdiRVdr?=
 =?utf-8?B?amdNOU1KSWgzWjFKSWdkMXFBK1JIMVFuVjB2cG5VOHVCRmt6S1pEQ090d3BI?=
 =?utf-8?B?U0dRTWVZTE01VllHRndCSUFFNTJiRUVqTVloMFlUa0ZNRGhMOTNFRCtleElD?=
 =?utf-8?B?S0Nkem9yWjA0SS8vbWpYT3RDUm5UZG5HVlRaYWQ2VkhSR0k5TWppamloRENU?=
 =?utf-8?B?WXVLZUlWRDJXQ1o0N0NQdlVacUNEU3VJdzFxb3REVlFJWEc2emt5TnpqMmll?=
 =?utf-8?B?SGZISXBMS2UxcEtjbFpLOVlWTjNVaEFPZ0IrUjFNaDdyTzJlY1ZDdHFKMG01?=
 =?utf-8?B?R3FwMEVUV0g2ZGpGMXgrdEFSZGdTMzhEeGtnSWdGY2VuYXdaTHBwUGxqb2FM?=
 =?utf-8?B?TkxyeVNQUHppMjNwSnNnR1k0a082QW9jN3NrTnZ5bjFrWldFYUJQS3d3cS9p?=
 =?utf-8?B?LzFTREtnKzFYVW9UaHVDVGg3Uzh4eUtoWFJuaTMzeCtHcHdWRU5RN2Q5NVU4?=
 =?utf-8?B?Ti8yNDJicFFWSFFEMUNMVjAzcXNBSFZ0UG5OTitmRUo3Rlo5eUlMb2xCVlVB?=
 =?utf-8?B?aTA1VUozOFZGL09tS1FwN3NMVmM5akZteVJuV3BYSG5yUldTdGVrNTlxSmpx?=
 =?utf-8?B?VWk2cjFWb2pnZW1OS2tpaCsyTFNla0hpcjFkQ2p1dDhza0pwZkxOOW5EZkR6?=
 =?utf-8?B?YWdTcVpaZUFVVElWRTZMRERRNXh1T0NYUlZ1UTVPeXJGMjVOcmJOWmNualRF?=
 =?utf-8?B?cE5xS1d6QkxRa3E5SEZ5T0pKRXY0ZmFlT3NrV3J1M3BGd0dkTStaUFc5U2ll?=
 =?utf-8?B?bGw5Q2pYRjhERmp3NER4UDJsNFpHcTVFOVlhSzRWMC9yd3ZodUM0ZnppL1RZ?=
 =?utf-8?B?NHV1dm1EQU5jSG1aZEpQeVFiTDhkZDB0cjllT0s4QTNBQ0V3Z0NvU0I4TjFl?=
 =?utf-8?B?VDlaVjhHQWt5TWxJRERtUm81Mkd5dW9JM2dQUlhQWFlWWnduNG1LQTRnMlRu?=
 =?utf-8?B?SDVUYTVZb0xITThjMXpmaUYyRktpbkRGOXNCRnBVMFZrWktPYnM1cWdmR1R5?=
 =?utf-8?B?R0psYWZaREtQcndwSVBsR1VXNVFZU3BaZVRoT2w5U2JqZ09iMlJkNVlZRElm?=
 =?utf-8?B?Sis5YzlLTk0zYWtKamVQc0xKQnpIeG9tRDhLNXNDV3lrbFRRY3AyQTJ2SGlO?=
 =?utf-8?B?Y2MwQjBSdHpkYmpDa2hvUkloa0xWTUY5UWVpeVBMd3NLUDk5a2Q3WGpxS21v?=
 =?utf-8?B?TkhiZkgydHZNREs3M3grS0tETGFXWGRPcXNnM0FEQXN3WGNZb3JpSGdyajc0?=
 =?utf-8?B?N25uSTMrUWZBeDNZV3d5S1Y4OS8xWVF3cFMwVGo1YTB1K0FNb0duOVErdmYv?=
 =?utf-8?B?Rmpva0p2bFAxZVpoSjBlVmJ5UDZOaEZQS1luSEtkdE42eUhLZ2h1R0c5YkN2?=
 =?utf-8?B?djludWgya25zaFhTNERoVnVEN2hVbkZqKzBiZFdweDFNTVpTbHBBdDFLL2hl?=
 =?utf-8?B?Wkx3MC84VW5uUGQ1YmFiLzRQUHB6RVVyWUdjR3pnZFhIYitwUXQ4RzZrUGxG?=
 =?utf-8?B?eHFpcHF0OEo3WHB2RXB5THhhaGZvWEpDWjlQTysvQUNZRjBCQmNYSUhKZnBE?=
 =?utf-8?B?MUFlNkl4djJ3YWIvMjZDZllCZDluS05aQlBJNlNmT2ZkV29QUktCN0tWa2N5?=
 =?utf-8?B?bzN3R1NMdzNucTROTXZqY3BWMWRGamFWVG1BOEVVYTVXb3ZNUlFjNzlMb1pw?=
 =?utf-8?B?bitaakVlV3ZxUGxyblg0bGR6WnFUY3lDbXRxUVk0RE1SYXU5YXRBNHVoWlFl?=
 =?utf-8?B?N3g3eUFqSkJ6NHNZTTJKM203eHlHN3ZxUktOOEVIVk1HakxSeFcrK000V09Q?=
 =?utf-8?B?VzZMQ0NUL1Z4RE9UVXAwbGQ5M0Y2WnY3d3JUTHBEMlBHeXZ2bWZWMjMrZzRG?=
 =?utf-8?B?YTRXb1B5NlpxVjRLeGNCaDQ3bDZ1T2g5ZGFNS1A0eW03dUdsaEFvOFd2V2Vj?=
 =?utf-8?B?MlczdHZ4aEZvOHRYVWZNa3pib2YrU0dYSk93aWtNM1ZnQzViVTlkVVhiSEJJ?=
 =?utf-8?Q?FQW8Gz7JOhWnrVozXDMnuJJ2FyL2tlpnUxUOj/GRK4nL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1955ceec-3910-413e-6878-08db7df20916
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:24:29.6018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBdcDryKcluKdfp5WMLJCxpoHAtl7sNhL7JA/KKSzlZ1lDa/i73lkZcU1tzggkZt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8799
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Haijun Chang <HaiJun.Chang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since this patch was already pushed please revert it until we have a 
technical consent on why this should be necessary.

Regards,
Christian.

Am 05.07.23 um 21:57 schrieb Leo Liu:
> What Christian says is correct, esp. during the playback or encode, 
> when suspend/resume happens, it will save the FW context, and after 
> resume, it will continue the job to where it left during the suspend. 
> Will this apply to SRIOV case? Since the changes only within the SRIOV 
> code, please make sure that also please specify the SRIOV from your 
> patch subject and commit message.
>
> Regards,
>
> Leo
>
>
> On 2023-06-30 07:38, Christian König wrote:
>> Am 20.06.23 um 15:29 schrieb Horace Chen:
>>> [Why]
>>> VCN will use some framebuffer space as its cache. It needs to
>>> be reset when reset happens, such as FLR. Otherwise some error
>>> may be kept after the reset.
>>
>> Well this doesn't make sense at all.
>>
>> The full content of adev->vcn.inst[i].cpu_addr is saved and restored 
>> during suspend/resume and IIRC GPU resets as well.
>>
>> See functions amdgpu_vcn_suspend() and amdgpu_vcn_resume().
>>
>> Please let Leo's team take a look at this and review the change 
>> before it is committed.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Horace Chen <horace.chen@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>> index b48bb5212488..2db73a964031 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>> @@ -1292,6 +1292,7 @@ static int vcn_v4_0_start_sriov(struct 
>>> amdgpu_device *adev)
>>>               cache_size);
>>>             cache_addr = adev->vcn.inst[i].gpu_addr + offset;
>>> +        memset(adev->vcn.inst[i].cpu_addr + offset, 0, 
>>> AMDGPU_VCN_STACK_SIZE);
>>>           MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
>>>               regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
>>>               lower_32_bits(cache_addr));
>>> @@ -1307,6 +1308,8 @@ static int vcn_v4_0_start_sriov(struct 
>>> amdgpu_device *adev)
>>>             cache_addr = adev->vcn.inst[i].gpu_addr + offset +
>>>               AMDGPU_VCN_STACK_SIZE;
>>> +        memset(adev->vcn.inst[i].cpu_addr + offset + 
>>> AMDGPU_VCN_STACK_SIZE, 0,
>>> +            AMDGPU_VCN_STACK_SIZE);
>>>           MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
>>>               regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>>>               lower_32_bits(cache_addr));
>>

