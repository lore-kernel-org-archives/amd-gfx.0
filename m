Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0F9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 17:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F0610E370;
	Tue,  8 Mar 2022 17:28:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F50010E414
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 17:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mc5SJzbaSg4XkDN1E2gXQyRY2Uz2WDpXo668w+Q2sFP3kWh7FqbwVke5S4ZcP6u35wnDMOgodkVuJ7jqiZDwprMAcGtmNOOjv7xuJ0xmZQp3isVyBi3yKItKAyEorF0rlE2aE45JxPfcJ0gSdWftjSzdMezxTMu6BGet3thCF130nNWQ78kHbwpU5qNgpzQV+V7DRGYbZt/J3NqkRqmJK6Wth8ByqO7LlSgaw/XP8xayf8VJHTiwtcXrp29ukOTXA8sE6Hw/Ngp3GWMlfrCLPWmuLNiXztvZ8PLTY84udTgRnpP3eou9dhRfWOA1Sm360K5IaZQjKqdsa+zmuvsVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCkpvJwy97p0pmlImuyBJH00RB7givw+snfdWvGzEZY=;
 b=N4SHmMgRAom2pBJt42wtNic/jM4kjx/JLGkXLCjaS3vZTJuknkVBQRJiwPV6xRJMPkoS/g94rnAj7k7cP61ZQW7ks2/E1iwaa7Dlu5+WASrqPUydF0OXsxDYS7TIIHR3qs8h5pye1iU1oGzJbZmfFQqj5QKAmtnxbaUD8xzkiLLPmZzYLuCDweqWMB8/GAE8QP3TwrIhIHWd25AG+bIEPw8YYKy8B+ZjrIOpVEEJzQPSdygPtDrthVnzhzEogMIJKwhGEz4bcRMYEbN5tpL7tOKMOGcVJ3PtNXXYe4IUpQP8F2BXt8AL8iL3q3zpJa1gjbU+DJJJkG8oyFI6o8tHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCkpvJwy97p0pmlImuyBJH00RB7givw+snfdWvGzEZY=;
 b=DdnIN6lr9EA48SNKJYwTQPmS+6IoLOi+9GVyIYZe2XvXAVfIQfOhUHhZrjoSILRJDodzfdKb5zCnfzvcNMPPFijgbKPXCKdpLQ1zuyQG9PNdwgVlSGlGIzwMM/5Esr1VX54hBLcM/SKGGt/4j8pSlATrKBZbDTEpaOY0oD4vi+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BN7PR12MB2706.namprd12.prod.outlook.com (2603:10b6:408:2a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 17:27:55 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 17:27:55 +0000
Message-ID: <c7c3ec4c-5345-b8b9-486f-e3d15e19c452@amd.com>
Date: Tue, 8 Mar 2022 11:27:49 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
 Sanket Goswami <Sanket.Goswami@amd.com>
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <1eff0822-f410-fd1b-b9c7-6a54862de74a@amd.com>
 <BYAPR12MB461498EFB1E9A3A76A38735497099@BYAPR12MB4614.namprd12.prod.outlook.com>
 <5c32f2d0-e278-529c-be53-ffd5603cd472@amd.com>
 <b16fa66b-2712-633b-ee00-27916dbd32b3@amd.com>
 <975f7416-2f32-3207-c118-cdb56d2bae7c@amd.com>
 <11183b53-bd53-7afc-2fdf-f46183044dd2@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <11183b53-bd53-7afc-2fdf-f46183044dd2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:610:5a::40) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35d0f996-e09d-44bf-a728-08da0128fb1a
X-MS-TrafficTypeDiagnostic: BN7PR12MB2706:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB27063C2B66A13CE0F07206CBE2099@BN7PR12MB2706.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpao7yVU1/YPCLEgMJd5tvsOktz6zaw4C9cxcIkNoE8R42NlC+85z+rSvXtUWfYsVfUBceldUGtAgEggrGEIC0XnrbVub2Wr7L8I83qONUiLh5PkYjeJn87vU9YrGHRmZuYsMp+l6uBwi/yLL2w8B89GCj3mMZGTlz2TqBE63a9fGrJfuzolDf4P0xPpsSmEL2GimxA0JPSJho4F36xZM9XIlCH8qf3R31w8GjWFGs/q6ZrLMwlhTEiS4kq4jrZIXc9i9514eNqGU2JLI1FoMxJ9saDOJ0lYI/ltleSlje8g6881jZ+GPm6u1BBf5TFMPsuyNdSCNrTyJD2hdJvoAU53g3c6mR8wmgeCh47v+868sJNH8/91H7ThgdriPyc8mYU2W0qBgE1DRKGVcZhDhpb6NVMoOYtoaO9+UnHN3FpT/YrY1fJv4aSiL3887NJhg6E2l3SayF+fdh+R/3ij5tmo21VIgKehy+4rlJNWr/jvsbV1jxCrwfvNAAslldsS7WD185fm+6FH7iEUhl7eyO021wOIFz6FHP2mqXrC538z67HX3z84bhJKPUZMdV+wWi+9s4L5LMfHSmCbsr+fD2TG7sXJxQ+DL5BqyQaiKqD9LyZsfLV/v3TXqqOzQEjogij9il7f57IwkBna6YGmAV1xDHvY0S6RlcZhlXyznKls3EqHopJId1+WE/lr/EVh55pQ1lcDj73GaYxK293HfGrSAmXgb8q0Fp3wWv9EtUPZeNv+qr4qw2+3b0MOxUsyZQp9LtwrLIkPiukEOMuxfO3tKCxYlJg1c/wxsFKpYYVDIsMY92RuPYoV57DgXkHyawCfW7oG1l9cAY/MYZaWDBWP60D08lRMvrfn03qhPcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(53546011)(86362001)(8936002)(2616005)(508600001)(5660300002)(6666004)(6486002)(2906002)(6512007)(186003)(26005)(4326008)(8676002)(31696002)(66476007)(66946007)(66556008)(45080400002)(38100700002)(110136005)(31686004)(316002)(54906003)(16799955002)(36756003)(83380400001)(966005)(6636002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VExnUWk3bEFXN2xhSXdOc2RDNXNrV0xFSWVYQ1JoTSswNi9JN1RsYy9wclhY?=
 =?utf-8?B?dldNaTNzRERTUzFwZUkzUmFUZ1l3OFlWa0phV1A1WnZ3czRuOVgwWG5ibm1F?=
 =?utf-8?B?bHN4Y0JKaEZmMW10WnB3MG43Y1JpQndFOTJSVFJmaTFmQkVGUUQ5NWJ2dXp1?=
 =?utf-8?B?aENtSkhUa2FSY0xMYTJicDU4L2FFRVhGYzhRbS9zUVBDS1dDT2hBWitOTkhT?=
 =?utf-8?B?SjNyU1U4YlNvSFVlQlBHampkdVMrVHN1bDNJRVFVMU5UQnNuRExVMVppaWxH?=
 =?utf-8?B?RGJpZVo3QzBRODZvSVhuMFhKREpxeVVaejZjZnZRZjZhSGc2Y1JMaDg3SGxD?=
 =?utf-8?B?SVBXSlNuYjkxQWpYdzFPSDFPVjRkT0RvaXh2NEdEa0RqTlNtTmt3c0pMeS9R?=
 =?utf-8?B?bTRFWmM4cWNQSmYrNXliNXI4K2VGTjhadFNmR2FPL1RyMHlFaGZSQldZVGJ4?=
 =?utf-8?B?b1hpMzV5cmJ3UTIvdVdNS1JpVG4rK3dNQzhTUE9hZWtxbFpnY0txcHFnR1d6?=
 =?utf-8?B?V1BOZnZ4cW5UbGxIZkJYa05wY2xFaUxIaEp5VmZHQS9jTDVqckZHVmYreEZ5?=
 =?utf-8?B?OVJtQzh5WXhUUUpXSzd1aVBibkZYdVhhY3FNUCtvYW5XaDYwSXlKamdJWTlP?=
 =?utf-8?B?byt3SkkyRC9OTENpR3U1STNFRWpodGE5aVM3eXhGUFhlRjRoN0ZkbHlTelNX?=
 =?utf-8?B?NU5HNmJIZ0dvcXF6czByV1FBalhYOW1tc0RPVFlJV2grWXpwRlRSc1lqSnRQ?=
 =?utf-8?B?L2RxcHkvUWFIUFpncE5CcjR4TWZvVEEyanc3ZjZWZmd2SkpWZGt5WXozT1Jx?=
 =?utf-8?B?SzZWZmlWSFUvSXBrU0JwSE05OG9BalU2d0k1QkdFbklOMGNvUm5qRjBuREw3?=
 =?utf-8?B?TnMrVXo1RzZGS3ZmRXdmRHQzcnFKRHVrSHo2b1ROa2R2a2ZSRURYMnlqcUNS?=
 =?utf-8?B?MVNhM0ZONk9QWEE2aFZOODBoQ3Q3QUExZVFNQnpPZFhFamdSejR3NGlUUUlV?=
 =?utf-8?B?UXorZFJIUDNwT05oZjIwaVFDQVUyZWl6TEZ1eXpaS2srb3FPQ3J6ZC9pMTFB?=
 =?utf-8?B?a2FzSjg5MlJhT0o5d09EKyttZkRKb3hpRFBPRzBhMzBkbHlFelN1Qklpc3ZE?=
 =?utf-8?B?N3p6WTVYSjJUYlVGMUlIZ0dRRWY1RzdnM2FyR1FRY2tybWE3R1d5TE1hUmNk?=
 =?utf-8?B?VVNyVGRuZ2JDaXIrUks5dS8zblNFd2pzbFEzaW5qdk53eHZyaDFnWWFNTndN?=
 =?utf-8?B?UU9iN1N5VzcweW8wdkNPWU82SFNtdVRQcHdFd21iYVBTUlBnTDNmL3ZSd25V?=
 =?utf-8?B?TngyK2VianVSNFZOTXZ1VEdld1kvUDRabWNWeTJWZ2pXaENQTm9aWTNKL2xs?=
 =?utf-8?B?Wkx4WnRNc1ZUWWF0amVEWUJRU2s1dXVlVlY1QmJHcW1EMzhkYzZ6R2V6VVNP?=
 =?utf-8?B?TmVNVlhJTWtkbVB3RjhuNXIrMFlpcXJPRVRyZFlEOW1IUmVnU3FPaHFtSXJB?=
 =?utf-8?B?czgwcmM0SGRVN0hiWGt1c09wVk1nYkpGNmVmeUhNck0waGxvblpDdFVmbFdU?=
 =?utf-8?B?K2VpeXBLSWExZTRpMHVJY28vZ0JCNXdXaG9DbkFENXhOK0ZNOHFNckxXcHNm?=
 =?utf-8?B?Z01nNGVXb0lNUmloSmJaSktSc1cxM2xzZXZUdzY1VHkwVWVNNzFXekNnREFW?=
 =?utf-8?B?eDRaZkNWNWlWYU9qdHRPUVhDeUlId0R6UkRrSUlwV1hYdVZuQmJmQXFsTVVW?=
 =?utf-8?B?STI3OXdlSEEzOVN4UVc4WU1ZVTVFN2JrdkdVNzd4eHZKL214a0dXWEdJYjF4?=
 =?utf-8?B?RFhqWEV2QzVoZnE1UnoxeHVJa1VHak1RMTFqSkd5UmxnbjBMZTB1em44TEpR?=
 =?utf-8?B?MHZybmdvcVZ0SUN5YWs1TlpyT2Qvemd5M2IwbUFSUWxOK0RhYzRpQzRsQnJY?=
 =?utf-8?B?QnNPbEN0NytIZWF0UlkzY0VOSHFwV3d2d09iL1BDQXpsN1VMUGNxSU44SHpQ?=
 =?utf-8?B?VXFJZFNIOVZ6ZTNJOG55SStEZGdIVGgxZHJwL2VsaDdvKzd3Y0c0RHNXcG9X?=
 =?utf-8?B?MnEzOTNWRkI0bm1RbVErZ2gvOFNGNFdjZkZtcVowZlUwbDZhaGZuU1hXOHJD?=
 =?utf-8?B?QWVFYmhLVzJXSU1zMFRWMkFqNkpBQS8rNjRDMUJQcnIzSGhtWXBHanU2Vm9Y?=
 =?utf-8?Q?eE4FHKGhmdIXdueXfUsi4g8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d0f996-e09d-44bf-a728-08da0128fb1a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 17:27:55.1993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCW51jHGmSztotqiFxw9c4pNz03yin/4Xz8Jfk+GIPnweut56Lj340o+Y1p/zhaYWIEJ1E6zIiYGIXl9oQW2cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2706
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
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 3/8/2022 10:57, Sharma, Shashank wrote:
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
> Noted, thanks for the pointer.
> - Shashank

Yeah I think this is a great idea for APU, but need to keep in mind 
amd-pmc is only activated if APU is configured for s0i3.  So in the 
IS_APU check you will need to test for set for s0i3 and return an error 
code if not set.

For APU it's currently fetched on demand from debugfs.  If you can 
"easily" export a symbol I say go for it and include a patch in your 
series.  If not my suggestion is to stub this out and let Shyam and 
Sanket fill in the stub after they can sort out the exporting it to 
another driver.

>>
>> Andrey
>>
>> On 2022-03-08 11:46, Sharma, Shashank wrote:
>>> I have a very limited understanding of PMC driver and its interfaces, 
>>> so I would just go ahead and rely on Andrey's 
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
>>>>> <Christian.Koenig@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>
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
>>>>> from what I see there is no problem to just amend it as part of envp[]
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
>>>>> > + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU 
>>>>> reset
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
>>>>> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>>>> uint32_t flags)
>>>>> > +{
>>>>> > +     unsigned char pid_str[21], flags_str[15];
>>>>> > +     unsigned char reset_str[] = "RESET=1";
>>>>> > +     char *envp[] = { reset_str, pid_str, flags_str, NULL };
>>>>> > +
>>>>> > +     DRM_DEBUG("generating reset event\n");
>>>>> > +
>>>>> > +     snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
>>>>> > +     snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
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
>>>>> > @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
>>>>> >   void drm_class_device_unregister(struct device *dev);
>>>>> >
>>>>> >   void drm_sysfs_hotplug_event(struct drm_device *dev);
>>>>> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>>>> uint32_t reset_flags);
>>>>> >   void drm_sysfs_connector_hotplug_event(struct drm_connector 
>>>>> *connector);
>>>>> >   void drm_sysfs_connector_status_event(struct drm_connector 
>>>>> *connector,
>>>>> >                                      struct drm_property *property);

