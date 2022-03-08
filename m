Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D02DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 17:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FF3610E28C;
	Tue,  8 Mar 2022 17:04:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC84E10E28C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 17:04:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxtYxCFa//aL4eJYUUg3sVnDPMyxEMYVjViOwIscrJePPfvKlGPx3AyITz7qOya33GyK1zw0kdJhaspGP5Qcoq3PMGm9qQXNB/OknwEZ4tsH94SMStUBG+KDmii6jheRyxAR8uwVt2x96O7W/Ib6mm+d9REC7GeJ9l9GyI4gsgEf1HgjqeoRKf+NBJhkY9/IumD85jvpT+GDzJVxZlTsXLk3hr+kxImSyUsh0fDFsdmPf8LShITzNO0lXMKXPJJP32xOIgVUL4PzJWRU+UyL5iz0cPJA85S9kEEVZrVvm/9DUUr/R+EYDd35m4X/oRU3Q6OQQd8VGtdPK7nBwE+yeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH1AcGyxcUdU1n5AwPS9WIR8spJqbwXOOD23yyszRx8=;
 b=javUmsjnYyJUkMUH54q1/USVXZaan/3tZLS40YU2bk2GP65TCuxLENyDgb885fJAxpLnCu568nQN5sUQXC1R6IQj9xYGsBIwfWvsl10eLs+PlxUT25WY73yDR7HBn3xXVS/JbHabeRQcWFePFeLds5785NjN35woyh+9iKlHN39m6J3sH62Lv87+1dJmxEN8QEQlvhsuBs4YCsUDf9zuAFQbHF5amSIjiYIaRcBLZQBJccSxoff1x1XeObKNKqBG6E5OtbFN7poCYdn7I1SjDACj4/llyLDuPDdEw/FI6rPcW49v+QH8C4Bx7amOEEdL8K9dPc3r0wBsv8dT1xdFsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH1AcGyxcUdU1n5AwPS9WIR8spJqbwXOOD23yyszRx8=;
 b=13JUb7gxZchEK2Vp1r3/82PfefwizmLvT+lJhlHMWVF/LXksPIfxSiN9oRFszHKRaUfAOz9JFBmgD10CY7cIh43hX/ebeFQcNqG78e9UEaeBgsqniNEYFxpLjz7WVDMLeZURaWt5sDW5yrMdr4SyEjvrzS7CFDYvjt3FirnYRcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 17:04:44 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::2d51:2dae:ef16:6053]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::2d51:2dae:ef16:6053%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 17:04:44 +0000
Message-ID: <a39197a1-a680-113e-b852-f481fe1e9bb2@amd.com>
Date: Tue, 8 Mar 2022 22:34:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <1eff0822-f410-fd1b-b9c7-6a54862de74a@amd.com>
 <BYAPR12MB461498EFB1E9A3A76A38735497099@BYAPR12MB4614.namprd12.prod.outlook.com>
 <5c32f2d0-e278-529c-be53-ffd5603cd472@amd.com>
 <b16fa66b-2712-633b-ee00-27916dbd32b3@amd.com>
 <975f7416-2f32-3207-c118-cdb56d2bae7c@amd.com>
 <11183b53-bd53-7afc-2fdf-f46183044dd2@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <11183b53-bd53-7afc-2fdf-f46183044dd2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::24) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d864fb99-8883-409d-8251-08da0125bdba
X-MS-TrafficTypeDiagnostic: DM4PR12MB5136:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5136F96583397A78B6DDD402F8099@DM4PR12MB5136.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YluSmfIfqms2jncKwmOeoFUu69zEp73qdPWWrH4t9fJbv68Sz1BEdLyuOPi+kZznyGMgmiNHE1Gc56li4LnortPWMpA+9lws+KlT+T/m/GBISc1qzYrqfGD4s4yEbbTYwGiX40uM8nlJC0t8b5YuZ2RRP1tXcHiHqlLvQ6ITqyDGb4aDSfeeSnFAtmN4G11YToRmibhJr85p5xySLneNjJWtfQaOzJRQVRVrE/t7xspmTfZA7nI0C8mAQJes6nJ4jYgKuIRswJC40U2D77rHhEm1ZJOsQPqQHvcp54XYunaQ3oLUGfVVqo4mATs7904Zsl9S11ILCKcaFW1e0mLtRhx7KrlINvSymDhNYGEhn7yhXhV3Zui01dxg3lBAhyZJYYa4Qk1r4cBVLwUVOG+vblrWT9eFi2gVRvhBSZsebl/ebwoYH/gI9JYyp6VvOaYK42jXnccOZUFVpZMjGPgg0PhI0qNKaenkpCIBeWrklDiw0hgm9wM5p8ZHpMSga6xzkacD6GNnS6U4KYwaDtrGjjW2JEEz6lWWYw5bP+34Rrilfu0+DD6U4jw9e/0TuLCRykA02/0xppBaKrpwlZ0LADHNn/RRgfRHhgj4MZDmLptDpkJAoyfPxumtiY17+Uyr2LiqAPfhiChB9AGGZrGyFkBSzyAUHxRQtbHdHRVf/btYgKWeimg3IJKpExaswkG9wkyXjWTwsV9Sb6pL418sYJyOelKIHiASML5qgLVJGqdnY06Mokj1faxVzW+efLPEVSNiLK4P0vvc81ZoGR9nD3RG8PLXy2vntT1LI9lP8OsK8vMDPuvqvYRwkiPlBWdEK4qHlCdDCTgBqsa3SRcMirHgOnoAocIaaXPLYUtLv3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(38100700002)(66946007)(2906002)(66476007)(53546011)(66556008)(4326008)(54906003)(110136005)(8936002)(5660300002)(45080400002)(31696002)(6486002)(316002)(966005)(508600001)(16799955002)(6506007)(186003)(26005)(36756003)(6512007)(83380400001)(31686004)(6666004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnFyZWlyb2tQUkQyVTVTeDd1dzNiL3o4U1pIcTdZenNNRjVKcVlHcUFDT2xr?=
 =?utf-8?B?SzZwQk9obGxUa0U3Yks1Q3dlVk9VQjJBWnBDK0dyNENMYnpKV2NvYk1GVERt?=
 =?utf-8?B?WmhGbDVBWTRyeDBhVmdKQkF3d3dGWHVzM0l0aUdKcDV3dit6Mlk2Tk5yb0lF?=
 =?utf-8?B?SUc0aVdSVGt4NkwyL2JRMWhyMXcwWHl0SUtxMUhIejFIU3NRK0NRVmw0cU16?=
 =?utf-8?B?ZmxBWDR0bjl3V2JNOUVybkFaQnlNaElrdExFQjlWdENaUWlmR2pCTUozNnJn?=
 =?utf-8?B?Vitac2tGVGFXenpvSUxaWmVHRmFSZGZJUEIzWGUydlpydzBUMElEa3RZbXQ4?=
 =?utf-8?B?NVZlZDQ5TFFlS3VQcjdhQ1dHNzRpMWxwZk5PNDN4dkpFMGlnZkwrR3VGcHNM?=
 =?utf-8?B?TmpPdHpqTTJmcGxsdWJCb0NXQ3Z5eEFzL0RnU2hXOEJuQXkvbHlNdy9KVEpy?=
 =?utf-8?B?QW5zenZ1dk5EMm9vRzRtbFdNYjMyZ0tadFRkQW1WQzdCcnExRlU1OHZZQ2Vs?=
 =?utf-8?B?dDhBZWovSEpMM1lPdWtSUXRrRVNKNng1eCsydEwzdHlZY3RpRTdhY3NPVjNS?=
 =?utf-8?B?RWNHdmZuVGt6NHQzMjZoaGhBWkwyakVmMkRCQTczWjh1L1dEMmZyejRHL2RK?=
 =?utf-8?B?cGtGT3JoanlZakRJTkNkODFLQ1dxTmgrUjBuMjNidDZYRlpac0xqeStIcXFk?=
 =?utf-8?B?Z0twTlgvVVB1TG5JUHVKdngwMUhGWGl3eFRSOGRIc0RHbmN2UUhIUTg3LzhE?=
 =?utf-8?B?OGcyV2psL3gzQ2h5N1RVK2gva1BBU21wbUkyL0p0NkROWDFTSHRDZVpjRHg0?=
 =?utf-8?B?M3NGRzUrU1RMNU81THFpVmJNWEdOWnVRaUdmeUVxbG90UGJpakxGSzc0K2po?=
 =?utf-8?B?TzBkMEF6Q0l2anAwL0dadDFxUFNaTC8wQ1B2d2t4eG9XYmZNTFBNZEZldTd1?=
 =?utf-8?B?WjdFY1pVdnRVMlBBSVcyQlp2THU5VHprMmlUdWdaVHVkRG52dEhuZTBBdHNM?=
 =?utf-8?B?TGhoWlBEUS9aSFh2MDNVMGJzazJXUnV1U1V2cU00UE0rL3I4alNLNFlka05K?=
 =?utf-8?B?WFgzYUMvY0UxMzdRd1lCODZqTkJ4dEtmQW43ZlluSE9CdGI5NVExbXlSdzlj?=
 =?utf-8?B?WnZ5VHE3eithVFdUWEdOeGdLNXNuNjNUc1RNRWsvOUZvcko4ZTJUN3JYQjRS?=
 =?utf-8?B?NkZMK1JhUloxMERrN0lVbEdldGUvV3hVOVMrRWp5dnBETEE1aFR1WWlWTjJ5?=
 =?utf-8?B?bkZhcE5YYWJVSGVITjgwZHViaEk2d09KMkVSbzh6c2kzdmZPcGx6aTdmUGk5?=
 =?utf-8?B?RERSUHE0SmoyUlEwc3VVNWdjTk1QWU9zYzFkbmJsR3FQKzVWZWVQZCtNSGp5?=
 =?utf-8?B?bUNlV0RBazNzc2VuSjRQWE9RTHkxdmlIbVMrM3lkbHRiVG5oUEZ6b21lRHVj?=
 =?utf-8?B?Tmdsb3V5M01EOU5ZMjJ2YStOVTBMQjBaZFgveVh1bHJMeEpWLzFkRXVhY09Y?=
 =?utf-8?B?b0NudjVTSkc5MDI3cmpweGJBM2lZajkrcWtmbEdMTGdaZ1NlY0Fsajl4NXU0?=
 =?utf-8?B?cnFDSllhVGdpOWNsVFNnRGNSYnR1ZUdQN1JMWmFvb1RiVnE4UW9VV2pnMjEx?=
 =?utf-8?B?dWYzYzdJTW1JTDNIbjRqbHFqN0JCR0hjUDF0QnhrbVZHOGxpbXRGWm1hRmpa?=
 =?utf-8?B?NWV2ZFBhbFJ0Rk9YZmZCTm1qb3FNUTE3Y09jMjhHTm9ycEJGWUkzVU9JZnhL?=
 =?utf-8?B?TFdCbmxvOVZPMjcvVGgvWGRsOU05ZkdRbnhpYUdHQWhXRllhSU05clhRN3Vr?=
 =?utf-8?B?bU1QTml1dTM1eDF3SjFHeG85VjZrZ3F3UFYwaDJVbGFKMHcraU9hdGluYmFm?=
 =?utf-8?B?Um5NeHZqNDJUSGVEbFgvajE5cXhrZmJHV1E4NzF0bUorVmhuUi8wajRIOEJj?=
 =?utf-8?B?WTNoYXFyZ2trUUZOOFBoNExQRlB3ZXhHRXJmbXF2SU1neThwejU1MWlsNDBT?=
 =?utf-8?B?RllKVThoRTBpWDZlMUV4OVp1QWZPdzNLeUJtM1RySnJiRWtYM2hRb2dtczB3?=
 =?utf-8?B?SnZpSTBwcTdFRTZ5QjlISG0xRlc0MForMTRhcGtRTnZ3UWJxZld5eEdSbURk?=
 =?utf-8?B?ZlJyNi92cElHVi9HdHlQbkd2c0JHWk54VE9JcmZuckViOUI4UFpPSTF1cmVH?=
 =?utf-8?Q?o6Y0U9hhoxfARBblckKNSkg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d864fb99-8883-409d-8251-08da0125bdba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 17:04:43.9099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfATSJgV9SxMH/UieQr4LUOBUiC1n5mIHfbJWQA5F1y6CSNIPTGNhrGYRtnKyiuhAEqskSdIcHOFdezgc+C+7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5136
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/8/2022 10:27 PM, Sharma, Shashank wrote:
>
>
> On 3/8/2022 5:55 PM, Andrey Grodzovsky wrote:
>> You can read on their side here - 
>> https://www.phoronix.com/scan.php?page=news_item&px=AMD-STB-Linux-5.17 
>> and see their patch. THey don't have as clean
>> interface as we do to retrieve the buffer and currently it's 
>> hard-coded for debugfs dump but it looks like pretty straight forward 
>> to expose their buffer to external
>> client like amdgpu.
>
Customer requirement is to get reset notification for there daemon with 
other info (like PID process name vram status).

Regards,
S.Amarnath
> Noted, thanks for the pointer.
> - Shashank
>>
>> Andrey
>>
>> On 2022-03-08 11:46, Sharma, Shashank wrote:
>>> I have a very limited understanding of PMC driver and its 
>>> interfaces, so I would just go ahead and rely on Andrey's 
>>> judgement/recommendation on this :)
>>>
>>> - Shashank
>>>
>>> On 3/8/2022 5:39 PM, Andrey Grodzovsky wrote:
>>>> As long as PMC driver provides clear interface to retrieve the info 
>>>> there should be no issue to call either amdgpu interface or PMC 
>>>> interface using IS_APU (or something alike in the code)
>>>> We probably should add a wrapper function around this logic in amdgpu.
>>>>
>>>> Andrey
>>>>
>>>> On 2022-03-08 11:36, Lazar, Lijo wrote:
>>>>>
>>>>> [AMD Official Use Only]
>>>>>
>>>>>
>>>>> +Mario
>>>>>
>>>>> I guess that means the functionality needs to be present in amdgpu 
>>>>> for APUs also. Presently, this is taken care by PMC driver for APUs.
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>> ------------------------------------------------------------------------ 
>>>>>
>>>>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf 
>>>>> of Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>> *Sent:* Tuesday, March 8, 2022 9:55:03 PM
>>>>> *To:* Shashank Sharma <contactshashanksharma@gmail.com>; 
>>>>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, 
>>>>> Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian 
>>>>> <Christian.Koenig@amd.com>; Sharma, Shashank 
>>>>> <Shashank.Sharma@amd.com>
>>>>> *Subject:* Re: [PATCH 1/2] drm: Add GPU reset sysfs event
>>>>>
>>>>> On 2022-03-07 11:26, Shashank Sharma wrote:
>>>>> > From: Shashank Sharma <shashank.sharma@amd.com>
>>>>> >
>>>>> > This patch adds a new sysfs event, which will indicate
>>>>> > the userland about a GPU reset, and can also provide
>>>>> > some information like:
>>>>> > - which PID was involved in the GPU reset
>>>>> > - what was the GPU status (using flags)
>>>>> >
>>>>> > This patch also introduces the first flag of the flags
>>>>> > bitmap, which can be appended as and when required.
>>>>>
>>>>>
>>>>> I am reminding again about another important piece of info which 
>>>>> you can add
>>>>> here and that is Smart Trace Buffer dump [1]. The buffer size is HW
>>>>> specific but
>>>>> from what I see there is no problem to just amend it as part of 
>>>>> envp[]
>>>>> initialization.
>>>>> bellow.
>>>>>
>>>>> The interface to get the buffer is smu_stb_collect_info and usage 
>>>>> can be
>>>>> seen from
>>>>> frebugfs interface in smu_stb_debugfs_open
>>>>>
>>>>> [1] - 
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;reserved=0 
>>>>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;reserved=0> 
>>>>>
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>> >
>>>>> > Cc: Alexandar Deucher <alexander.deucher@amd.com>
>>>>> > Cc: Christian Koenig <christian.koenig@amd.com>
>>>>> > Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>> > ---
>>>>> >   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>>>>> >   include/drm/drm_sysfs.h     |  3 +++
>>>>> >   2 files changed, 27 insertions(+)
>>>>> >
>>>>> > diff --git a/drivers/gpu/drm/drm_sysfs.c 
>>>>> b/drivers/gpu/drm/drm_sysfs.c
>>>>> > index 430e00b16eec..52a015161431 100644
>>>>> > --- a/drivers/gpu/drm/drm_sysfs.c
>>>>> > +++ b/drivers/gpu/drm/drm_sysfs.c
>>>>> > @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct 
>>>>> drm_device *dev)
>>>>> >   }
>>>>> >   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>>>>> >
>>>>> > +/**
>>>>> > + * drm_sysfs_reset_event - generate a DRM uevent to indicate 
>>>>> GPU reset
>>>>> > + * @dev: DRM device
>>>>> > + * @pid: The process ID involve with the reset
>>>>> > + * @flags: Any other information about the GPU status
>>>>> > + *
>>>>> > + * Send a uevent for the DRM device specified by @dev. This 
>>>>> indicates
>>>>> > + * user that a GPU reset has occurred, so that the interested 
>>>>> client
>>>>> > + * can take any recovery or profiling measure, when required.
>>>>> > + */
>>>>> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t 
>>>>> pid, uint32_t flags)
>>>>> > +{
>>>>> > +     unsigned char pid_str[21], flags_str[15];
>>>>> > +     unsigned char reset_str[] = "RESET=1";
>>>>> > +     char *envp[] = { reset_str, pid_str, flags_str, NULL };
>>>>> > +
>>>>> > +     DRM_DEBUG("generating reset event\n");
>>>>> > +
>>>>> > +     snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
>>>>> > +     snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", 
>>>>> flags);
>>>>> > + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>>>>> > +}
>>>>> > +EXPORT_SYMBOL(drm_sysfs_reset_event);
>>>>> > +
>>>>> >   /**
>>>>> >    * drm_sysfs_connector_hotplug_event - generate a DRM uevent 
>>>>> for any connector
>>>>> >    * change
>>>>> > diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
>>>>> > index 6273cac44e47..63f00fe8054c 100644
>>>>> > --- a/include/drm/drm_sysfs.h
>>>>> > +++ b/include/drm/drm_sysfs.h
>>>>> > @@ -2,6 +2,8 @@
>>>>> >   #ifndef _DRM_SYSFS_H_
>>>>> >   #define _DRM_SYSFS_H_
>>>>> >
>>>>> > +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
>>>>> > +
>>>>> >   struct drm_device;
>>>>> >   struct device;
>>>>> >   struct drm_connector;
>>>>> > @@ -11,6 +13,7 @@ int drm_class_device_register(struct device 
>>>>> *dev);
>>>>> >   void drm_class_device_unregister(struct device *dev);
>>>>> >
>>>>> >   void drm_sysfs_hotplug_event(struct drm_device *dev);
>>>>> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t 
>>>>> pid, uint32_t reset_flags);
>>>>> >   void drm_sysfs_connector_hotplug_event(struct drm_connector 
>>>>> *connector);
>>>>> >   void drm_sysfs_connector_status_event(struct drm_connector 
>>>>> *connector,
>>>>> >                                      struct drm_property 
>>>>> *property);
