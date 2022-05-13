Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ACBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 15:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E6710E163;
	Fri, 13 May 2022 15:41:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17E710E163
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 15:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ak1yUgEoWgYLYYdQZmjxdfJ6sbWBCGgkmgRr2YZIJ6G1YINpbz7AW7y5V7yQio11VQGhDRnwVkAq2PBimId9i4puLYvaEI0qFnpOMHb3towwScx7nngCL42juboacF5VFb/WiCDAtL5F8vnQL9OrwZ+jW2B8lzKfbcSffx7msMf2oveVCarmXwBf+05DFRwx+phkJ7hbQ14T6ljfVcwTCL9Q5+BI3pltFhnsuDAx/c2PDlcdLCi0VnTMBHvUQoteSuzsRpM/R+gwgWbJ/XSJXDx/zOCAgL2i7L7/mtNS+e7psTIquf6mMzvW3KeRiZY6BanYIPZOOsLU62aS4GJxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFQbq3I4JKGGEwJfIVuJOGWYymstwSYyx77QzbbnZjs=;
 b=SPsyj0sQ60UKPOpnYurcXhzzrmGaQ1/LcFxEjWzPPmFuXBAYL3YSmkuoLKEbM0iqiYDJRZMmBih0iK7hGQ2yvqib19U75HLGOwq++yWqf+NEm0yOdceEXZYp+ojZwgbwb+ZWo+CQYm6YBl0vOkA+sO8VHH4+cgk16tb6CVnIUDEdV9lA6jl8T2vGVBpwZO8p1GKMcRUYXD3sUtHBF5njwQGW5bnaBY6mP0MneTiPwkxyGMoMDX0dlSIzStNSemzhMmxkAlZuj6lko/olUlXRcmN9efFwWQ+XRlsMnQVy29uUcHkgz4JuL3akkCkZSsYyJln3JjxJEgak/7tBjnGYnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFQbq3I4JKGGEwJfIVuJOGWYymstwSYyx77QzbbnZjs=;
 b=RUgtYTenqnHDK9CWBhiHqT98wK2PPTIUUDFOxmVDkfNhLa4GSJLpIeenF5vDWu0LPo3bl87cl3wWoEe0xsn4AeEC8ixIDLZLwdV6hrsIpDhld1EoiB8ao6cyWBRbBh4DozkxafHUpKNan05KMu+6K1LitSH1eM3BxZAp1jg5gGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 15:41:06 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e%5]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 15:41:06 +0000
Message-ID: <0b2657b0-41b6-53b1-f087-1fa0fb821839@amd.com>
Date: Fri, 13 May 2022 11:41:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <05a18be9-dcc3-9246-b572-e47ccf5e804b@amd.com>
 <5f49de9e-dfa0-3371-c800-581f00556820@amd.com>
 <82cf78c6-9246-e892-bc42-99f6ec668481@amd.com>
 <ffad0f2b-b975-c099-a96d-98f82bc972ab@gmail.com>
 <3cefe63f-1f27-db1c-aeee-3731ca1e6d1d@amd.com>
 <df5deb8c-1a33-e177-ce26-eaccae179786@amd.com>
 <2b9b0047-6eb9-4117-9fa3-4396be39d39a@amd.com>
 <fb066a24-3737-ad5d-d098-ef0b5d4a54d4@amd.com>
 <2d366654-8df3-c6ae-d6fc-4fa94fc32fb1@amd.com>
 <3e0c3d24-2135-b02f-93a3-ab2a597c794f@gmail.com>
 <9cd38f76-13d0-7e99-9c8c-dff847c6cf2b@amd.com>
 <6699d9ec-501d-d2d5-2220-88fb754819a7@amd.com>
 <27535877-a13f-75fc-368f-68105dffc7f8@amd.com>
 <7330c50f-4623-c377-9486-c9a8fa884e15@amd.com>
 <4a52a938-f758-4b51-1f71-599a4af23e20@amd.com>
 <b9fd9cf5-1ae1-a599-576d-74f13b0351d5@amd.com>
 <4e88f5a0-11b7-ac14-ce77-7e69c2ce75c1@amd.com>
 <180c74b2-226f-fd36-b93b-f8b5140e410e@amd.com>
 <14483921-e454-1ad7-ff45-665366158504@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <14483921-e454-1ad7-ff45-665366158504@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::20) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8478bc6-77bb-4c30-599e-08da34f6fe1b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3462:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3462F325B3292C681A7B5131EACA9@BYAPR12MB3462.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eRBKqoLQcmfMS9tHk+DRaMEgaCEUUmcyBmMP3mPRGdtBDu2rQY5o6mVNSQDX9Cnk1kA1Ay+KlwOKIgHfKp7WpP2I6HVRwzS0S1XHm+bUCpRCErMajnkE5Xl3J+vCaBbo3ZYDj438TFPqBJ6idzrOLMrsJ86PJbNscBGmjZwqSZ5hX7BxsNMXbAwUr5A60po5WoTHekg3rTxvJjPhvXrO6Lg2K0LkyhsQufnsv3nXWHk3Hd88AuEoIO1n+FCTEuKEI8YBAKiq3KwQbhTh5QxIiHx5JpqY0JJk1BDNkKS/O216zHVXp2qIsYzJgH9JgR7O6wqrXKoKr0jBHRh1YgSagjuBiZa0B5zy78B6eNZ7d0qsdHwlwqB+6XDEORP7vjUwd8SHJXtcIoXC2SrsnS+dlpfBI6rYhOBgiCmneWU6HBnJ5OgwE6wuOIqvzfp9UIhibLT2VCTFfqLcWlR8iey+WiLSa/Q/i8Ru8GAAscNREW2jwnEMq4pM7StX4s5NZQbkTey0fORcWt3iYv+CGcXaAec9jRSKSrQLj1syGWu2+14hIlbicoe3XBKQVvOltmK/rV92SXPtPJ2ixPXs2wCNMQHChc7wfwsFmfGxGZTTu1aPBRHa9Aqg0mFja2qW4wBlDblez+ENIoRlqrXFErbBjAhh8Gt02BZlM9gLL3rmkQhg/W6lmthJWciDpDG4ySQtBby4H62qcF7UFuxCtWBDPufO925OHuOtEc1Lj2Cc7T4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(6506007)(31696002)(38100700002)(86362001)(6666004)(6512007)(186003)(66574015)(2616005)(31686004)(83380400001)(5660300002)(8936002)(316002)(8676002)(66556008)(4326008)(66476007)(66946007)(36756003)(30864003)(44832011)(2906002)(508600001)(110136005)(6486002)(43740500002)(45980500001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alRGQm9VL2UzYXlEVGZHRmptU0Q5V0hzR0x1alNRTDNNR3I0NXBGZWx6bjVX?=
 =?utf-8?B?R1ptMWF6TWVYaTZaWUVxcnM2L0NHa0E0bEo5blNSOUtGNzFLTHgzNWV4Z0U4?=
 =?utf-8?B?UzFpUVd4KzcwNHZkRTNuSVBPb1U0MkxlNEcrTTFQNGI4Q2VoR0NlUVYwZ2tB?=
 =?utf-8?B?cmYybWNDN0dDaTBudmpQN0RUSEZ5WERZVWtvd1RVc0ZqWnZGaDR6TjNVSkR5?=
 =?utf-8?B?U1hKRGdtZ1dPenFlejRLeXdBSlh1bnJiaW5TdjNRV1ZxOEpXTGhMYnRRYWZa?=
 =?utf-8?B?TnMrRmM1cnBMOWdCa3Z5dXNXbEJuRjRPQ29kZlhHb0tGc0FCQUs2TnhRVFRL?=
 =?utf-8?B?TGs3ZjdTajY5NzRxUHBRQlJIN3VLZm5VWFIvcWlzWG1FYTBXOXBDbEdBQXdW?=
 =?utf-8?B?VXVpMjFKMGN2ejZPL2YrT2J6MmFOQ0VsWTQ5bFBhRWtiT09vNkhWSlNhd3Br?=
 =?utf-8?B?Vm1pNEUvckoxMFB3dG5YaTg2RGN0aDQ0aFVuNENPRHgrWWg5U0pxKzBvaVBS?=
 =?utf-8?B?dStKUG9JRUpycDdyeUgwa0t4c1ZmSlgva05Ub0RFTUpqK1k1V2pQTjFTcUk5?=
 =?utf-8?B?QTlFWjB5V0FXTHF5dkpKb1BwRk9VNzdVZUJnd0R2QU5mUFNvRnVYcis0aStr?=
 =?utf-8?B?UXBjNDcyQzFyY0tnK2s2S05zdktnUWJuYXN6enE5ZVJKU0VwZHN2dy9wU1hD?=
 =?utf-8?B?ZHVFOFdCOVl4SFlPb2FraU5TTDhyVS85S1VCTTNYY2FEc0IwZGtQaStuOEVs?=
 =?utf-8?B?ZURMTThNU1BoYm1zcUI2Y1VPdW84ZDBMelZMK3BJUXFuU2VUVFlyRDBVQmpy?=
 =?utf-8?B?Vk94OXlvaFg0V3ZrWk5ZdUNHT2Jya1FHNDQ1T2ZZenpQS0xlTVlyY1QyMGxO?=
 =?utf-8?B?L2I5a1hlQ1dWTUcyY2d3d1R4aUM1UGdSRi92b0FURTVqZ2VtRW9xS2YxR3Nv?=
 =?utf-8?B?TFdPV1RIWGZQRk91VFExSEtEaUtvcUM4ZklDL0gveVVCT2Z4TG5oK2Jhanhy?=
 =?utf-8?B?aEM5dHpsSW1pUjB1SlRWNXoraW93dGVFSjdLOHd2UGZsRGRxSG9UbEUyaG11?=
 =?utf-8?B?UzZKakNEOUdHYkhYR3ZWNXppMDl3a3VPZFAwT1ZJMWlEbit4WldYTzBEV3JN?=
 =?utf-8?B?MEF3MWhzM0cyOFNWejJpRlhtYU9Ia1Q5UXM3U1ZGbEF2RGhad1dBNFVyZnVv?=
 =?utf-8?B?RWhYTmIvenhQY1k4Tkk2b3ZydEFUYjRwRnFwcTJwazVQTzBCdWE3eGIvV3lY?=
 =?utf-8?B?cEVncklzNVZ1aDNQNHlyd0s5SDNkb3BCMmU4clc2b0N0ZmcxeW1qTGpTcDVB?=
 =?utf-8?B?U2phZW5WQlo0VU5KL01iY3dGTmtIczQrdDNVZGI2cTBGU1JJUVBPdWhCTUl3?=
 =?utf-8?B?MHh3cFFkb3pEM3BlYnUvSjYvMitiOXY3ZWh2RXlFQ0paZHNWcTNCbjRPU1Ji?=
 =?utf-8?B?SHpySTJWaVlsOGc1c2piODZwaTJWYWJSTThwVWhpTVZ2cFgwR2tJMWc0TjZR?=
 =?utf-8?B?ZStRUFRsWTNaZnJMcUlyQ0Mvd1UzekxWNW1ZaGYvTzk5S1g5OTBNVnQ3M00y?=
 =?utf-8?B?ZTlmczdGelVWQ0dNQkhoaUQrellWUVpyWGtSNnNwbTh6S1ZRc1EvZUYrMjNB?=
 =?utf-8?B?Q1N3MnRaSmF5M0RuNGtiWmhsN0EyWWVnYllFR1lYdGxGVGkwbzEyc0dtcHRK?=
 =?utf-8?B?Q3VPRWg3UUNzYytOalFLSExuWGJ1REVteXRhWUdpWk44M1Z1VUpGTXp2RHpV?=
 =?utf-8?B?dTR4YzRWNnJSNFhwVGorMGdwTDBpdHVwRHo0OEpsek5vWTZhbkE0VDQyTCtR?=
 =?utf-8?B?em9tTy80a1M0Qk5uVCt2eGpXMXZWOE9hWVZIYlVGQ1BhSWJJSDB5eTVSUm5W?=
 =?utf-8?B?akZpOG9xaDNJWjRTR0NxTlJGUTZTcTc0bTAwbzZnTmxpN2xHUDM4bDdkblBa?=
 =?utf-8?B?ZnpINHVTa0JCTFFVVHdDMGxCZzVLQ09ZU3dia25kQlRLa1ZsL1lFOFFEWm9i?=
 =?utf-8?B?ZzdDS0lJQ1l2alJTeWNDOTkyTytpcXFZSjh3S1FPekVOcTZ1MC80MmhqVmhG?=
 =?utf-8?B?RlpsZjNiVkExa3d0NjVWN1BmWWdONy9SelorNVFBN2pIUlZsREplRG54Z1pO?=
 =?utf-8?B?ZVppajVjT1J4dUlweklUTkdMV3NqeStEYzlMMnNvUjJTV2Y4ZCs5OVRrczF3?=
 =?utf-8?B?SElEdFlUVnY4OEhtZnM4VzVmSEppUzNtM3ViMUluS0tzSjJxRUdHYSs5OTl4?=
 =?utf-8?B?RVJOSFlqYXRzOUJZNFlCa0hXaDgxQnVmSElsL0hFbW5jbjk0YlU5Q0wwU1ZV?=
 =?utf-8?B?ek04eHY0Y2dJbVlkZWwxQTh6elg3QlpMMENIYVpFOFk1RXliOTFiSTJ4SzdI?=
 =?utf-8?Q?7k1A0hP+OrGrcA7NRggTM2GzibyKO86nYpQOdDo6IzmBe?=
X-MS-Exchange-AntiSpam-MessageData-1: fpLr5ciqJLXOWA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8478bc6-77bb-4c30-599e-08da34f6fe1b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 15:41:06.0525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4S9lqb301h22pXBnBnB88eiEt35tQF8MziQITgga0viSgi8g6JVmJ1N1CwiYXy/s507hi3LFY7IrupbFlD291g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3462
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
Cc: Bai Zoy <Zoy.Bai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-05-12 09:15, Christian König wrote:
> Am 12.05.22 um 15:07 schrieb Andrey Grodzovsky:
>>
>> On 2022-05-12 02:06, Christian König wrote:
>>> Am 11.05.22 um 22:27 schrieb Andrey Grodzovsky:
>>>>
>>>> On 2022-05-11 11:39, Christian König wrote:
>>>>> Am 11.05.22 um 17:35 schrieb Andrey Grodzovsky:
>>>>>> On 2022-05-11 11:20, Lazar, Lijo wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 5/11/2022 7:28 PM, Christian König wrote:
>>>>>>>> Am 11.05.22 um 15:43 schrieb Andrey Grodzovsky:
>>>>>>>>> On 2022-05-11 03:38, Christian König wrote:
>>>>>>>>>> Am 10.05.22 um 20:53 schrieb Andrey Grodzovsky:
>>>>>>>>>>> [SNIP]
>>>>>>>>>>>> E.g. in the reset code (either before or after the reset, 
>>>>>>>>>>>> that's debatable) you do something like this:
>>>>>>>>>>>>
>>>>>>>>>>>> for (i = 0; i < num_ring; ++i)
>>>>>>>>>>>> cancel_delayed_work(ring[i]->scheduler....)
>>>>>>>>>>>> cancel_work(adev->ras_work);
>>>>>>>>>>>> cancel_work(adev->iofault_work);
>>>>>>>>>>>> cancel_work(adev->debugfs_work);
>>>>>>>>>>>> ...
>>>>>>>>>>>>
>>>>>>>>>>>> You don't really need to track which reset source has fired 
>>>>>>>>>>>> and which hasn't, because that would be racy again. Instead 
>>>>>>>>>>>> just bluntly reset all possible sources.
>>>>>>>>>>>>
>>>>>>>>>>>> Christian.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I don't say we care if it fired once or twice (I need to add 
>>>>>>>>>>> a fix to only insert reset work to pending reset list if 
>>>>>>>>>>> it's not already there), the point of using list (or array) 
>>>>>>>>>>> to which you add and from which you remove is that the logic 
>>>>>>>>>>> of this is encapsulated within reset domain. In your way we 
>>>>>>>>>>> need to be aware who exactly schedules reset work and 
>>>>>>>>>>> explicitly cancel them, this also means that for any new 
>>>>>>>>>>> source added in the future you will need to remember to add him
>>>>>>>>>>
>>>>>>>>>> I don't think that this is a valid argument. Additionally to 
>>>>>>>>>> the schedulers we probably just need less than a handful of 
>>>>>>>>>> reset sources, most likely even just one or two is enough.
>>>>>>>>>>
>>>>>>>>>> The only justification I can see of having additional 
>>>>>>>>>> separate reset sources would be if somebody wants to know if 
>>>>>>>>>> a specific source has been handled or not (e.g. call 
>>>>>>>>>> flush_work() or work_pending()). Like in the case of a reset 
>>>>>>>>>> triggered through debugfs.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This is indeed one reason, another is as we said before that 
>>>>>>>>> if you share 'reset source' (meaning a delayed work) with 
>>>>>>>>> another client (i.e. RAS and KFD) it means you make assumption 
>>>>>>>>> that the other client always proceeds with the
>>>>>>>>> reset exactly the same way as you expect. So today we have 
>>>>>>>>> this only in scheduler vs non scheduler reset happening - non 
>>>>>>>>> scheduler reset clients assume the reset is always fully 
>>>>>>>>> executed in HW while scheduler based reset makes shortcuts and 
>>>>>>>>> not always does HW reset hence they cannot share 'reset 
>>>>>>>>> source' (delayed work). Yes, we can always add this in the 
>>>>>>>>> future if and when such problem will arise but no one will 
>>>>>>>>> remember this then and a new bug will be introduced and will 
>>>>>>>>> take time to find and resolve.
>>>>>>>>
>>>>>>>> Mhm, so your main concern is that we forget to correctly handle 
>>>>>>>> the new reset sources?
>>>>>>>>
>>>>>>>> How about we do it like this then:
>>>>>>>>
>>>>>>>> struct amdgpu_reset_domain {
>>>>>>>>      ....
>>>>>>>>      union {
>>>>>>>>          struct {
>>>>>>>>              struct work_item debugfs;
>>>>>>>>              struct work_item ras;
>>>>>>>>              ....
>>>>>>>>          };
>>>>>>>>          struct work_item array[]
>>>>>>>>      } reset_sources;
>>>>>>>> }
>>>>>>>>
>>>>>>>
>>>>>>> If it's only about static array,
>>>>>>>
>>>>>>> enum amdgpu_reset_soruce {
>>>>>>>
>>>>>>> AMDGPU_RESET_SRC_RAS,
>>>>>>> AMDGPU_RESET_SRC_ABC,
>>>>>>> .....
>>>>>>> AMDGPU_RESET_SRC_XYZ,
>>>>>>> AMDGPU_RESET_SRC_MAX
>>>>>>>
>>>>>>> };
>>>>>>>
>>>>>>> struct work_struct reset_work[AMDGPU_RESET_SRC_MAX]; => An index 
>>>>>>> for each work item
>>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>
>>>>>>
>>>>>> It's possible though it makes harder to generalize reset_domain 
>>>>>> later for other drivers.
>>>>>> But still one caveat, look at amdgpu_recover_work_struct and it's 
>>>>>> usage in amdgpu_device_gpu_recover and in gpu_recover_get,
>>>>>> At least for debugfs i need to return back the result of GPU 
>>>>>> reset and so I cannot store actual work items in the array 
>>>>>> mentioned above
>>>>>> but rather pointers to work_item because i need a way to get back 
>>>>>> the return value from gpu_recover like I do now in 
>>>>>> amdgpu_device_gpu_recover.
>>>>>
>>>>> You should try to avoid that as well.
>>>>>
>>>>> See when the debugfs reset is canceled because of a scheduler 
>>>>> reset you won't get a useful return code either.
>>>>>
>>>>> What we should do instead is to cache the status of the last reset 
>>>>> in the reset domain.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>
>>>>
>>>> Another problem with this approach -  to execute  the actaul GPU 
>>>> reset I need accesses  to concrete amdgpu_device pointer from work 
>>>> struct (see xgpu_ai_mailbox_flr_work) as example. If i store all 
>>>> work items in
>>>> array in amdgpu_reset_domain the most i can only retrieve is the 
>>>> reset_domain struct itself which won't help since it's dynamically 
>>>> allocated, not embedded in hive or adev and can can be one per 
>>>> device or per entire hive in case of XGMI and so there is no way 
>>>> for me to reach back to amdgpu_device. Back pointer to adev* from 
>>>> amdgpu_reset_domain will only work for single device but not for 
>>>> XGMI hive where there are multiple devices in a hive.
>>>
>>> Which is exactly the reason why I think we should always allocate 
>>> the hive structure, even if we only have one device. And a GPU reset 
>>> should then always work with the hive data structure and not adev.
>>
>>
>> I am not sure why HIVE is the object we should work with, hive is one 
>> use case, single device is another, then Lijo described something 
>> called partition which is what ? Particular pipe within GPU ?. What 
>> they all share in common
>> IMHO is that all of them use reset domain when they want a recovery 
>> operation, so maybe GPU reset should be oriented to work with reset 
>> domain ?
>
> Yes, exactly that's the idea.
>
> Basically the reset domain knowns which amdgpu devices it needs to 
> reset together.
>
> If you then represent that so that you always have a hive even when 
> you only have one device in it, or if you put an array of devices 
> which needs to be reset together into the reset domain doesn't matter.
>
> Maybe go for the later approach, that is probably a bit cleaner and 
> less code to change.
>
> Christian.


Unfortunately this approach raises also a few  difficulties -
First - if holding array of devices in reset_domain then when you come 
to GPU reset function you don't really know which adev is the one 
triggered the reset and this is actually essential to some procedures 
like emergency restart.

Second - in XGMI case we must take into account that one of the hive 
members might go away in runtime (i could do echo 1 > 
/sysfs/pci_id/remove on it for example at any moment) - so now we need 
to maintain this array and mark such entry with NULL probably on XGMI 
node removal , and then there might be hot insertion and all this adds 
more complications.

I now tend to prefer your initial solution for it's simplicity and the 
result will be what we need -

"E.g. in the reset code (either before or after the reset, that's 
debatable) you do something like this:

for (i = 0; i < num_ring; ++i)
cancel_delayed_work(ring[i]->scheduler....)
cancel_work(adev->ras_work);
cancel_work(adev->iofault_work);
cancel_work(adev->debugfs_work);
"

And while here for each new reset source you need to remember to add 
another line of code here same can said about adev* array in 
reset_context as you will need to remember to add a new source there anyway.

Let me know what you think.

Andrey


>
>>
>> Andrey
>>
>>
>>>
>>> Adding a pointer from your reset work item back to the hive is then 
>>> trivial.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Andrey
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>> Not 100% sure if that works, but something like that should do 
>>>>>>>> the trick.
>>>>>>>>
>>>>>>>> My main concern is that I don't want to allocate the work items 
>>>>>>>> on the stack and dynamic allocation (e.g. kmalloc) is usually 
>>>>>>>> not possible either.
>>>>>>>>
>>>>>>>> Additional to that putting/removing work items from a list, 
>>>>>>>> array or other container is a very common source for race 
>>>>>>>> conditions.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>> to the cancellation list which you showed above. In current 
>>>>>>>>>>> way all this done automatically within reset_domain code and 
>>>>>>>>>>> it's agnostic to specific driver and it's specific list of 
>>>>>>>>>>> reset sources. Also in case we would want to generalize 
>>>>>>>>>>> reset_domain to other GPU drivers (which was
>>>>>>>>>>> a plan as far as i remember) this explicit mention of each 
>>>>>>>>>>> reset works for cancellation is again less suitable in my 
>>>>>>>>>>> opinion.
>>>>>>>>>>
>>>>>>>>>> Well we could put the work item for the scheduler independent 
>>>>>>>>>> reset source into the reset domain as well. But I'm not sure 
>>>>>>>>>> those additional reset sources should be part of any common 
>>>>>>>>>> handling, that is largely amdgpu specific.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> So it's for sure more then one source for the reasons 
>>>>>>>>> described above, also note that for scheduler we already 
>>>>>>>>> cancel delayed work in drm_sched_stop so calling them again in 
>>>>>>>>> amdgpu code kind of superfluous.
>>>>>>>>>
>>>>>>>>> Andrey
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Christian.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Andrey
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The only difference is I chose to do the canceling right 
>>>>>>>>>>>>>>> BEFORE the HW reset and not AFTER. I did this because I 
>>>>>>>>>>>>>>> see a possible race where a new reset request is being 
>>>>>>>>>>>>>>> generated exactly after we finished the HW reset but 
>>>>>>>>>>>>>>> before we canceled out all pending resets - in such case 
>>>>>>>>>>>>>>> you wold not want to cancel this 'border line new' reset 
>>>>>>>>>>>>>>> request.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Why not? Any new reset request directly after a hardware 
>>>>>>>>>>>>>> reset is most likely just falsely generated by the reset 
>>>>>>>>>>>>>> itself.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Ideally I would cancel all sources after the reset, but 
>>>>>>>>>>>>>> before starting any new work.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> You can see that if many different reset sources 
>>>>>>>>>>>>>>>>>> share same work struct what can happen is that the 
>>>>>>>>>>>>>>>>>> first to obtain the lock you describe bellow might 
>>>>>>>>>>>>>>>>>> opt out from full HW reset because his bad job did 
>>>>>>>>>>>>>>>>>> signal for example or because his hunged IP block was 
>>>>>>>>>>>>>>>>>> able to recover through SW reset but in the meantime 
>>>>>>>>>>>>>>>>>> another reset source who needed an actual HW reset 
>>>>>>>>>>>>>>>>>> just silently returned and we end up with unhandled 
>>>>>>>>>>>>>>>>>> reset request. True that today this happens only to 
>>>>>>>>>>>>>>>>>> job timeout reset sources that are handled form 
>>>>>>>>>>>>>>>>>> within the scheduler and won't use this single work 
>>>>>>>>>>>>>>>>>> struct but no one prevents a future case for this to 
>>>>>>>>>>>>>>>>>> happen and also, if we actually want to unify 
>>>>>>>>>>>>>>>>>> scheduler time out handlers within reset domain 
>>>>>>>>>>>>>>>>>> (which seems to me the right design approach) we 
>>>>>>>>>>>>>>>>>> won't be able to use just one work struct for this 
>>>>>>>>>>>>>>>>>> reason anyway.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Just to add to this point - a reset domain is 
>>>>>>>>>>>>>>>>> co-operative domain. In addition to sharing a set of 
>>>>>>>>>>>>>>>>> clients from various reset sources for one device, it 
>>>>>>>>>>>>>>>>> also will have a set of devices like in XGMI hive. The 
>>>>>>>>>>>>>>>>> job timeout on one device may not eventually result in 
>>>>>>>>>>>>>>>>> result, but a RAS error happening on another device at 
>>>>>>>>>>>>>>>>> the same time would need a reset. The second device's 
>>>>>>>>>>>>>>>>> RAS error cannot return seeing that a reset work 
>>>>>>>>>>>>>>>>> already started, or ignore the reset work given that 
>>>>>>>>>>>>>>>>> another device has filled the reset data.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> When there is a reset domain, it should take care of 
>>>>>>>>>>>>>>>>> the work scheduled and keeping it in device or any 
>>>>>>>>>>>>>>>>> other level doesn't sound good.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>> Lijo
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> I'd put the reset work struct into the reset_domain 
>>>>>>>>>>>>>>>>>>> struct. That way you'd have exactly one worker for 
>>>>>>>>>>>>>>>>>>> the reset domain. You could implement a lock-less 
>>>>>>>>>>>>>>>>>>> scheme to decide whether you need to schedule a 
>>>>>>>>>>>>>>>>>>> reset, e.g. using an atomic counter in the shared 
>>>>>>>>>>>>>>>>>>> work struct that gets incremented when a client 
>>>>>>>>>>>>>>>>>>> wants to trigger a reset (atomic_add_return). If 
>>>>>>>>>>>>>>>>>>> that counter is exactly 1 after incrementing, you 
>>>>>>>>>>>>>>>>>>> need to fill in the rest of the work struct and 
>>>>>>>>>>>>>>>>>>> schedule the work. Otherwise, it's already scheduled 
>>>>>>>>>>>>>>>>>>> (or another client is in the process of scheduling 
>>>>>>>>>>>>>>>>>>> it) and you just return. When the worker finishes 
>>>>>>>>>>>>>>>>>>> (after confirming a successful reset), it resets the 
>>>>>>>>>>>>>>>>>>> counter to 0, so the next client requesting a reset 
>>>>>>>>>>>>>>>>>>> will schedule the worker again.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>>>>>   Felix
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Additional to that keep in mind that you can't 
>>>>>>>>>>>>>>>>>>>>> allocate any memory before or during the GPU reset 
>>>>>>>>>>>>>>>>>>>>> nor wait for the reset to complete (so you can't 
>>>>>>>>>>>>>>>>>>>>> allocate anything on the stack either).
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> There is no dynamic allocation here, regarding 
>>>>>>>>>>>>>>>>>>>> stack allocations - we do it all the time when we 
>>>>>>>>>>>>>>>>>>>> call functions, even during GPU resets, how on 
>>>>>>>>>>>>>>>>>>>> stack allocation of work struct in 
>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover is different from any 
>>>>>>>>>>>>>>>>>>>> other local variable we allocate in any function we 
>>>>>>>>>>>>>>>>>>>> call ?
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> I am also not sure why it's not allowed to wait for 
>>>>>>>>>>>>>>>>>>>> reset to complete ? Also, see in 
>>>>>>>>>>>>>>>>>>>> amdgpu_ras_do_recovery and gpu_recover_get 
>>>>>>>>>>>>>>>>>>>> (debugfs) - the caller expects the reset to 
>>>>>>>>>>>>>>>>>>>> complete before he returns. I can probably work 
>>>>>>>>>>>>>>>>>>>> around it in RAS code by calling 
>>>>>>>>>>>>>>>>>>>> atomic_set(&ras->in_recovery, 0) from some callback 
>>>>>>>>>>>>>>>>>>>> within actual reset function but regarding sysfs it 
>>>>>>>>>>>>>>>>>>>> actually expects a result returned indicating 
>>>>>>>>>>>>>>>>>>>> whether the call was successful or not.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> I don't think that concept you try here will work.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> Also in general seems to me it's cleaner approach 
>>>>>>>>>>>>>>>>>>>>>> where this logic (the work items) are held and 
>>>>>>>>>>>>>>>>>>>>>> handled in reset_domain and are not split in each 
>>>>>>>>>>>>>>>>>>>>>> adev or any other entity. We might want in the 
>>>>>>>>>>>>>>>>>>>>>> future to even move the scheduler handling into 
>>>>>>>>>>>>>>>>>>>>>> reset domain since reset domain is supposed to be 
>>>>>>>>>>>>>>>>>>>>>> a generic things and not only or AMD.
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>> Signed-off-by: Andrey Grodzovsky 
>>>>>>>>>>>>>>>>>>>>>>>>>> <andrey.grodzovsky@amd.com>
>>>>>>>>>>>>>>>>>>>>>>>>>> Tested-by: Bai Zoy <Zoy.Bai@amd.com>
>>>>>>>>>>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu.h | 11 +---
>>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 
>>>>>>>>>>>>>>>>>>>>>>>>>> 17 +++--
>>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +
>>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 
>>>>>>>>>>>>>>>>>>>>>>>>>> 73 +++++++++++++++++++++-
>>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 3 +-
>>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 7 ++-
>>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 7 ++-
>>>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 7 ++-
>>>>>>>>>>>>>>>>>>>>>>>>>>   8 files changed, 104 insertions(+), 24 
>>>>>>>>>>>>>>>>>>>>>>>>>> deletions(-)
>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>>>>>>>>>>>>>>>>> index 4264abc5604d..99efd8317547 100644
>>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -109,6 +109,7 @@
>>>>>>>>>>>>>>>>>>>>>>>>>>   #include "amdgpu_fdinfo.h"
>>>>>>>>>>>>>>>>>>>>>>>>>>   #include "amdgpu_mca.h"
>>>>>>>>>>>>>>>>>>>>>>>>>>   #include "amdgpu_ras.h"
>>>>>>>>>>>>>>>>>>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>>>>>>>>>>>>>>>>>>     #define MAX_GPU_INSTANCE 16
>>>>>>>>>>>>>>>>>>>>>>>>>>   @@ -509,16 +510,6 @@ struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_allowed_register_entry {
>>>>>>>>>>>>>>>>>>>>>>>>>>       bool grbm_indexed;
>>>>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>>>>   -enum amd_reset_method {
>>>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_NONE = -1,
>>>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_MODE0,
>>>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_MODE1,
>>>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_MODE2,
>>>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_BACO,
>>>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_PCI,
>>>>>>>>>>>>>>>>>>>>>>>>>> -};
>>>>>>>>>>>>>>>>>>>>>>>>>> -
>>>>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_video_codec_info {
>>>>>>>>>>>>>>>>>>>>>>>>>>       u32 codec_type;
>>>>>>>>>>>>>>>>>>>>>>>>>>       u32 max_width;
>>>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>>>>>>>>>>>>>>> index e582f1044c0f..7fa82269c30f 100644
>>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -5201,6 +5201,12 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover_imp(struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>>>>> tmp_vram_lost_counter = 
>>>>>>>>>>>>>>>>>>>>>>>>>> atomic_read(&((adev)->vram_lost_counter));
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> +    /* Drop all pending resets since we will 
>>>>>>>>>>>>>>>>>>>>>>>>>> reset now anyway */
>>>>>>>>>>>>>>>>>>>>>>>>>> +    tmp_adev = 
>>>>>>>>>>>>>>>>>>>>>>>>>> list_first_entry(device_list_handle, struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device,
>>>>>>>>>>>>>>>>>>>>>>>>>> + reset_list);
>>>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_pending_list(tmp_adev->reset_domain); 
>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>>       /* Actual ASIC resets if needed.*/
>>>>>>>>>>>>>>>>>>>>>>>>>>       /* Host driver will handle XGMI hive 
>>>>>>>>>>>>>>>>>>>>>>>>>> reset for SRIOV */
>>>>>>>>>>>>>>>>>>>>>>>>>>       if (amdgpu_sriov_vf(adev)) {
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -5296,7 +5302,7 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover_imp(struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>>     struct amdgpu_recover_work_struct {
>>>>>>>>>>>>>>>>>>>>>>>>>> -    struct work_struct base;
>>>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_reset_work_struct base;
>>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev;
>>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_job *job;
>>>>>>>>>>>>>>>>>>>>>>>>>>       int ret;
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -5304,7 +5310,7 @@ struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_recover_work_struct {
>>>>>>>>>>>>>>>>>>>>>>>>>>     static void 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work(struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_recover_work_struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> *recover_work = container_of(work, struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_recover_work_struct, base);
>>>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_recover_work_struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> *recover_work = container_of(work, struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_recover_work_struct, base.base.work);
>>>>>>>>>>>>>>>>>>>>>>>>>> recover_work->ret = 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover_imp(recover_work->adev, 
>>>>>>>>>>>>>>>>>>>>>>>>>> recover_work->job);
>>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -5316,12 +5322,15 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover(struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_recover_work_struct work 
>>>>>>>>>>>>>>>>>>>>>>>>>> = {.adev = adev, .job = job};
>>>>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&work.base, 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>>>>>>>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&work.base.base, 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&work.base.node);
>>>>>>>>>>>>>>>>>>>>>>>>>>         if 
>>>>>>>>>>>>>>>>>>>>>>>>>> (!amdgpu_reset_domain_schedule(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>>>>> &work.base))
>>>>>>>>>>>>>>>>>>>>>>>>>>           return -EAGAIN;
>>>>>>>>>>>>>>>>>>>>>>>>>>   - flush_work(&work.base);
>>>>>>>>>>>>>>>>>>>>>>>>>> + flush_delayed_work(&work.base.base);
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>>>>> &work.base);
>>>>>>>>>>>>>>>>>>>>>>>>>>         return work.ret;
>>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>>>>>>>>>>>>>>>>> index c80af0889773..ffddd419c351 100644
>>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -134,6 +134,9 @@ struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain 
>>>>>>>>>>>>>>>>>>>>>>>>>> *amdgpu_reset_create_reset_domain(enum 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_d
>>>>>>>>>>>>>>>>>>>>>>>>>> atomic_set(&reset_domain->in_gpu_reset, 0);
>>>>>>>>>>>>>>>>>>>>>>>>>> init_rwsem(&reset_domain->sem);
>>>>>>>>>>>>>>>>>>>>>>>>>>   + 
>>>>>>>>>>>>>>>>>>>>>>>>>> INIT_LIST_HEAD(&reset_domain->pending_works);
>>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_init(&reset_domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>>       return reset_domain;
>>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>>   diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>>>>>>>>>>>>>>>>> index 1949dbe28a86..863ec5720fc1 100644
>>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -24,7 +24,18 @@
>>>>>>>>>>>>>>>>>>>>>>>>>>   #ifndef __AMDGPU_RESET_H__
>>>>>>>>>>>>>>>>>>>>>>>>>>   #define __AMDGPU_RESET_H__
>>>>>>>>>>>>>>>>>>>>>>>>>>   -#include "amdgpu.h"
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/atomic.h>
>>>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/mutex.h>
>>>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/list.h>
>>>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/kref.h>
>>>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/rwsem.h>
>>>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/workqueue.h>
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_device;
>>>>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_job;
>>>>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_hive_info;
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>>     enum AMDGPU_RESET_FLAGS {
>>>>>>>>>>>>>>>>>>>>>>>>>>   @@ -32,6 +43,17 @@ enum AMDGPU_RESET_FLAGS {
>>>>>>>>>>>>>>>>>>>>>>>>>> AMDGPU_SKIP_HW_RESET = 1,
>>>>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>>>>   +
>>>>>>>>>>>>>>>>>>>>>>>>>> +enum amd_reset_method {
>>>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_NONE = -1,
>>>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_MODE0,
>>>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_MODE1,
>>>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_MODE2,
>>>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_BACO,
>>>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_PCI,
>>>>>>>>>>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_reset_context {
>>>>>>>>>>>>>>>>>>>>>>>>>>       enum amd_reset_method method;
>>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *reset_req_dev;
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -40,6 +62,8 @@ struct amdgpu_reset_context {
>>>>>>>>>>>>>>>>>>>>>>>>>>       unsigned long flags;
>>>>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>>>>   +struct amdgpu_reset_control;
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_reset_handler {
>>>>>>>>>>>>>>>>>>>>>>>>>>       enum amd_reset_method reset_method;
>>>>>>>>>>>>>>>>>>>>>>>>>>       struct list_head handler_list;
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -76,12 +100,21 @@ enum 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_type {
>>>>>>>>>>>>>>>>>>>>>>>>>>       XGMI_HIVE
>>>>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>>>>   +
>>>>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_reset_work_struct {
>>>>>>>>>>>>>>>>>>>>>>>>>> +    struct delayed_work base;
>>>>>>>>>>>>>>>>>>>>>>>>>> +    struct list_head node;
>>>>>>>>>>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_reset_domain {
>>>>>>>>>>>>>>>>>>>>>>>>>>       struct kref refcount;
>>>>>>>>>>>>>>>>>>>>>>>>>>       struct workqueue_struct *wq;
>>>>>>>>>>>>>>>>>>>>>>>>>>       enum amdgpu_reset_domain_type type;
>>>>>>>>>>>>>>>>>>>>>>>>>>       struct rw_semaphore sem;
>>>>>>>>>>>>>>>>>>>>>>>>>>       atomic_t in_gpu_reset;
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> +    struct list_head pending_works;
>>>>>>>>>>>>>>>>>>>>>>>>>> +    struct mutex reset_lock;
>>>>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>>>>     @@ -113,9 +146,43 @@ static inline void 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_put_reset_domain(struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *dom
>>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>>     static inline bool 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_schedule(struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *domain,
>>>>>>>>>>>>>>>>>>>>>>>>>> - struct work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>>>> + struct amdgpu_reset_work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>>> -    return queue_work(domain->wq, work);
>>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_lock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> +    if (!queue_delayed_work(domain->wq, 
>>>>>>>>>>>>>>>>>>>>>>>>>> &work->base, 0)) {
>>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>>> +        return false;
>>>>>>>>>>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> + list_add_tail(&work->node, 
>>>>>>>>>>>>>>>>>>>>>>>>>> &domain->pending_works);
>>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> +    return true;
>>>>>>>>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> +static inline void 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *domain,
>>>>>>>>>>>>>>>>>>>>>>>>>> + struct amdgpu_reset_work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_lock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>>> + list_del_init(&work->node);
>>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> +static inline void 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_pending_list(struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *domain)
>>>>>>>>>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_reset_work_struct *entry, 
>>>>>>>>>>>>>>>>>>>>>>>>>> *tmp;
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_lock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>>> + list_for_each_entry_safe(entry, tmp, 
>>>>>>>>>>>>>>>>>>>>>>>>>> &domain->pending_works, node) {
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> + list_del_init(&entry->node);
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> +        /* Stop any other related pending 
>>>>>>>>>>>>>>>>>>>>>>>>>> resets */
>>>>>>>>>>>>>>>>>>>>>>>>>> + cancel_delayed_work(&entry->base);
>>>>>>>>>>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>>     void 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_lock_reset_domain(struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *reset_domain);
>>>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
>>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>>>>>>>>>>>>>>>>> index 239f232f9c02..574e870d3064 100644
>>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -25,6 +25,7 @@
>>>>>>>>>>>>>>>>>>>>>>>>>>   #define AMDGPU_VIRT_H
>>>>>>>>>>>>>>>>>>>>>>>>>>     #include "amdgv_sriovmsg.h"
>>>>>>>>>>>>>>>>>>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>>>>>>>>>>>>>>>>>>     #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS (1 
>>>>>>>>>>>>>>>>>>>>>>>>>> << 0) /* vBIOS is sr-iov ready */
>>>>>>>>>>>>>>>>>>>>>>>>>>   #define AMDGPU_SRIOV_CAPS_ENABLE_IOV (1 << 
>>>>>>>>>>>>>>>>>>>>>>>>>> 1) /* sr-iov is enabled on this GPU */
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -230,7 +231,7 @@ struct amdgpu_virt {
>>>>>>>>>>>>>>>>>>>>>>>>>>       uint32_t reg_val_offs;
>>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_irq_src ack_irq;
>>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_irq_src rcv_irq;
>>>>>>>>>>>>>>>>>>>>>>>>>> -    struct work_struct flr_work;
>>>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_reset_work_struct flr_work;
>>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_mm_table mm_table;
>>>>>>>>>>>>>>>>>>>>>>>>>>       const struct amdgpu_virt_ops *ops;
>>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_vf_error_buffer vf_errors;
>>>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c 
>>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>>>>>>>>>>>>>>>>> index b81acf59870c..f3d1c2be9292 100644
>>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -251,7 +251,7 @@ static int 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_set_mailbox_ack_irq(struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>>>     static void 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_flr_work(struct work_struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> *work)
>>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, 
>>>>>>>>>>>>>>>>>>>>>>>>>> flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, 
>>>>>>>>>>>>>>>>>>>>>>>>>> flr_work.base.work);
>>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev = 
>>>>>>>>>>>>>>>>>>>>>>>>>> container_of(virt, struct amdgpu_device, virt);
>>>>>>>>>>>>>>>>>>>>>>>>>>       int timeout = 
>>>>>>>>>>>>>>>>>>>>>>>>>> AI_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>>>>>>>>>>>>>>>>>>>   @@ -380,7 +380,8 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_get_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>>>           return r;
>>>>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>>>> INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>>>>>>>>>>>>>>>>         return 0;
>>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -389,6 +390,8 @@ void 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_put_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>>     static int 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_request_init_data(struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c 
>>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>>>>>>>>>>>>>>>>> index 22c10b97ea81..927b3d5bb1d0 100644
>>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -275,7 +275,7 @@ static int 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_set_mailbox_ack_irq(struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>>>     static void 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_flr_work(struct work_struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> *work)
>>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, 
>>>>>>>>>>>>>>>>>>>>>>>>>> flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, 
>>>>>>>>>>>>>>>>>>>>>>>>>> flr_work.base.work);
>>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev = 
>>>>>>>>>>>>>>>>>>>>>>>>>> container_of(virt, struct amdgpu_device, virt);
>>>>>>>>>>>>>>>>>>>>>>>>>>       int timeout = 
>>>>>>>>>>>>>>>>>>>>>>>>>> NV_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>>>>>>>>>>>>>>>>>>>   @@ -407,7 +407,8 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_get_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>>>           return r;
>>>>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>>>> INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>>>>>>>>>>>>>>>>         return 0;
>>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -416,6 +417,8 @@ void 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_put_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>>     const struct amdgpu_virt_ops 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_virt_ops = {
>>>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c 
>>>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>>>>>>>>>>>>>>>>> index 7b63d30b9b79..1d4ef5c70730 100644
>>>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -512,7 +512,7 @@ static int 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_set_mailbox_ack_irq(struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>>>     static void 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_flr_work(struct work_struct 
>>>>>>>>>>>>>>>>>>>>>>>>>> *work)
>>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, 
>>>>>>>>>>>>>>>>>>>>>>>>>> flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, 
>>>>>>>>>>>>>>>>>>>>>>>>>> flr_work.base.work);
>>>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev = 
>>>>>>>>>>>>>>>>>>>>>>>>>> container_of(virt, struct amdgpu_device, virt);
>>>>>>>>>>>>>>>>>>>>>>>>>>         /* wait until RCV_MSG become 3 */
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -610,7 +610,8 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_get_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>>>           return r;
>>>>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>>>> INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>>>>>>>>>>>>>>>>         return 0;
>>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>> @@ -619,6 +620,8 @@ void 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_put_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>>>     const struct amdgpu_virt_ops 
>>>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_virt_ops = {
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
>>>>>
>>>
>
