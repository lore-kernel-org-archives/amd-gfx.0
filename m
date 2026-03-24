Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C01E9A75A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 10:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E0A10E653;
	Tue, 24 Mar 2026 10:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mtcEDHDr";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B145610E64A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 10:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCm54G+ch4G6MY42IQJZZP3HZCAuK204MCzw2YybBVgKN5BGHy0IwfsyjR6O7/yK43ojRT+XAe2wA2NfsFVT1UL4tinYYvrc4D4yYAyGzs8OVUlZ/0J6cJ2Y34Oj4VaQ+dMWpS1d29wE0K7UUc34UgMe/Z9k5d2i1HwCiV13k7kb54811FYjOKNinlLRCY4h4KtrCKrXiA2dN0pz9wZ/0a33GSL2rMfWlO9Yua1bEdjPk6SSkYDm+XSP55vJr3b8rX+Jox6b56Br7hobbgb0uj2vXWA+7aeaSnN/H1zzYKec03uLeKvt8vevDkpl3/9HUI4eN+32KMPn2MSz+vuxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edvDd0DK+SAA5M0vMYdoJXIQUIloSU7e6u7qvHghA6I=;
 b=KfuLZnlqlcito0nIzlmCBrhaoP09x50Ssh3CPSWn3GzVIJmUi0NfoiJcFy6pT6ebTXakQD0wkhA5wnYAmoFZ+cQYNIXAg0CHfTJ/QZwhIbHJk/YFR1W0Zrcyo70pCd/nOvERQsGq7xuUc5+FgtbTzJdMbiAA+gmAS8vGnzl+hMpVyYajXDc7N8ruol51Ze+OhKx5ZRsrSNK16ByrOHlmyXrKFL5WxH6ZAwHPS2+WD0ssgQvtG98Tc/H3nrJ0cN15LpFdqWisl8/pIp/uqJ9rKjvbkDQBVEIA7QKjQWb37lkKnXfnO5EtMvYQEg7FT+lgxKlzEzVw+o7Ie+6QFqNjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edvDd0DK+SAA5M0vMYdoJXIQUIloSU7e6u7qvHghA6I=;
 b=mtcEDHDrpO21R5QW/JKt9cEXxdvnt68i/PszhF+t1imMwZkafmTdLuskxiuIR1VNCxSj2bk+zEjsMsDaU2TZT8eXuXHKr5STyEf5p4QTaV/LD4u3517yZYRhacev1WdxUMBXJNhsJx20/RS2Wk4plSYizxrd8Ix0uZaJNZZp1qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 10:04:07 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 10:04:06 +0000
Message-ID: <2d9c0d04-7b68-4091-9774-37ab9ed39a0a@amd.com>
Date: Tue, 24 Mar 2026 15:34:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amd/pm: add variant func smu_cmn_send_msg() to
 unify msg sending logic
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>
References: <20260323231206.722067-1-kevinyang.wang@amd.com>
 <ec7369d6-8f6d-4c2b-bbd8-b43fe11a41e1@amd.com>
 <DM6PR12MB2972AF9E1A2818BFA249ED7B8248A@DM6PR12MB2972.namprd12.prod.outlook.com>
 <042cf542-683d-435a-b54b-0c7161003d1b@amd.com>
Content-Language: en-US
In-Reply-To: <042cf542-683d-435a-b54b-0c7161003d1b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bf9843-8307-46a4-dc90-08de898caf69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 9E6llYzw4HIYRgX9u5kbgFa56/4o/TDedKzTWV9og0hiSeCFzgHVATQB06jFEDJXmiCB0A8UpeAkOo+V3+60ZHRNeeomwSLCGM27Uf1j6HUaUx0uuhZH0OMV7km9PdEDannRPBbT9atjZij91NLyxGtcw/kZYNeptlFdZTZPr1mxXjvUQQnPclSBtwzkRlN0x7jAjfEaGHTIV5IAYihLJcaFg03aBmZSGooVWh5cb3WsmDfgiBHuAr1XO6ydNHr8Lo/ymnffPCGWgazvOvUcPV1w8eTPNaaesahfkR69Z5ocGMVzvYC5dnWQYBVCN3sJbiDjjggLDokTjgqsmUvkEZNQpyQTA3NI+G73Cj3Bfag9XzMCnUI8xfbAcEp3J5QfXTG0ncAO7DjJhcB4kVigJjE+teK4qU72lscdYkq8wJKddjV1M8FrnnK/LdtMfkOoSXcLH1c4L2qbJh/R56sGivb2N5dczYNCJpZm6Soh8d87Nle/vNn5rxvFMpaWkx26cxjZ5/qYolcEY3O/OnoxXqDB1XKvqLiYvAacxZBiuG3Uv7NpI7bgBaCbhOJb9BxjY7VRXXtBt/72IXSqMOUcSyWF/A5NeSSg3S1C1O4hH4A8WxqI9y4lHfSBoOCJ5QTMp8LKqbjo4ViE1Z0bbpTA4AB+BUTZXl9QvGwe1ueK9cSDgFG+hf1RN1OiQgHkwfXv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVpEUWVRSjFMNVVWMHBGbGU0VnoxeGQ2aFFNaVEyQ3djR2x0cGZ1V1prMmxr?=
 =?utf-8?B?NzNnMUltZjNISlhhdEZ0YS80alFMbHhieDRVbHY0S2YrVEJuKytTNjVScko5?=
 =?utf-8?B?ODUxNG1MY1NOQjRZSWZMaGpJOFhYZEhqNCtTRUoxejBVbjJlTGlKOXNVNkgv?=
 =?utf-8?B?Wmd5c1Jrb0U3K2xqOVJ4TE5jQVVPWmExbWs1YytseVBrNlFYWnE4eE9KdWE5?=
 =?utf-8?B?V2VXbGt1WHVudnhjMDMyWVIraXEyTnM2Z2k5dHdxVThLMnNkSit2S2pYb05y?=
 =?utf-8?B?TUV2ejJUS1NBdmpqYWlycmhldEhyZWMvL3ViU2R1dVRzY2FjQWFFaFVManF5?=
 =?utf-8?B?SDJsTHBZbEpkTDRrc0F1WXlOZ014Yjkzajc0ZXIxM3RKT3lHejF1anMxMUJp?=
 =?utf-8?B?Nm9oK0V3djU1TnFiaVJWKzY0VHlSUXFMajBlb2M3RmhnbGNZS3FkUGh2MUdW?=
 =?utf-8?B?dS9MaDJDTkJlanJlY0FEdC9CYzZnRVA0NUtWUWt4bkZlSnlVZitHa0dKWDBY?=
 =?utf-8?B?Uk9yZzdLOUVXQTQzM3FrUjJ5L0c2emVXenlOTk1PRlY4VDkwMmcyUHJPNmdS?=
 =?utf-8?B?R3E5NVozTXNXWkdSVDhkb0pMaTVCdk1od3Z5WmN1dXU5dWh3VVlKS1dxOFlp?=
 =?utf-8?B?NE1SOEZ0V1BUaUsyajJNMmQrUS9zd3pWYnowZG5FS3BiU1FleGZLcVJkK0s4?=
 =?utf-8?B?V2lrM3VKSWVWcDdHZHYveVh4OXBjVjZNN2QwRkN5NnluRXpUbzc0akVWTTFn?=
 =?utf-8?B?Mmh0SmRnQVBUOXo4ZVNqaDI1OEt6WXhKMXNCd05VcERXQnRHVGE2Sjg0SDJR?=
 =?utf-8?B?cnpnRUNFSHQzMnVnU1QyNG56Ull4WWRuU3RSVWQzV01iRkpuZ3dTU1JzVzBy?=
 =?utf-8?B?QVRRMmZnZW9URlZGZnIvemgxcDRCZmw0Rmk0MG11M21od0hMM21OTUZNTEpQ?=
 =?utf-8?B?dE1wcjlwZFd2K296L055L0cycGg0YUtDZ2dhSGRsaHdtZVJMcXN6czZHR0Qx?=
 =?utf-8?B?eHFLTWM4VTlZQkFlVzNPSHc3N0lPSHBsakcwcTMra0loM3ZKdXFMVXM5WXB1?=
 =?utf-8?B?TGlKRnJWUXFDdmp0Um9KQW5jdFFRdjNRT0FoUDE5VzBYa1dxUUF2R0p1Tll1?=
 =?utf-8?B?Y0JJckowU3BSNmtWZnZXTkQvSncvOTliV1pXSnhEZTZraSt1aFdwWVJ6YU1R?=
 =?utf-8?B?NkdpbXk4YkE1QXJrTkwwR2NlSmcyUVNMeFhNL2xPaXVxdHdhMW9QUThZZk9p?=
 =?utf-8?B?MFBQV1NhS2lEUzNmMWVVQ1lEOEZVcXUrTlRUZHc1M05xUUFnMXZWS2NCUHkr?=
 =?utf-8?B?aGg4dnNkLysvMmdqQk80aFZGLzNrRzdiMjlUb0gvVTVNNTBlWFNUdUIrLzQ3?=
 =?utf-8?B?eUdhamhnWjNXNFY2OFRKNHA3eEVsdk93TmJpbVh6eGZtQkdzZkpWR1hzMXVK?=
 =?utf-8?B?d0pEd0I5aXpUbmkxQUZ3b1ZJd0xJaER0bEtTNEJnRitieW95SFpaZDJRdElZ?=
 =?utf-8?B?VTYxcitaU1ZCbjA2N1l0dUZNamRvT09TanhSVERRbFYvRTBXam5vbWNxVklr?=
 =?utf-8?B?SVhidnBvNC85Y21uaXFQMm5leEdUUmo1RnhUNXVUVWs0eHZWY25MQTk5c05E?=
 =?utf-8?B?UUpTUTFnQktwd3FxWll5ZmQwYnVmTFJKNFdnUnd1YjR4RGRBM21hczZ1b2Ri?=
 =?utf-8?B?T2hoWk1BMzM5bXBpdjhQczlyMUplNjg0NndwM0xYNVcrMGQ2R1cxeWRvTTZi?=
 =?utf-8?B?UXJWOTNNNlRJcUFDT2tScG5RYzZNeW4wSXNkeURTRWI3eXJ3Q3dUM1RaS0Vx?=
 =?utf-8?B?MTgwbVhMbE5TMGJ0eXVIdHZEYmJQbldoemRTTWRxNmVHQkU5eE1sUUpTRVFy?=
 =?utf-8?B?bzJualhnZ05IcEJXd0R4R0xjdlRiZjYvOHdGYVBJZ1MxYlVEM0FkTE50Misw?=
 =?utf-8?B?OGo5Z2VTTkt5RCs2SlJ3eUtGc010RVc4RUdVUTJUSFFRdG9iTkxwMkJVZG10?=
 =?utf-8?B?MnlTSHduRVVCWWhhNjBncVJPc1Q3UFJYVllsR3BzbTFSYUtYdzJHaDM5OUN6?=
 =?utf-8?B?N0Q3K1lUQWJ5d0txejZ4VVdNRVEwOTJvQWhNVU9uM0drUjM0SFM0NVJCcHMz?=
 =?utf-8?B?RWdrUUJmM0tTUlFVNTlLTStVL2Z0Rys5WHgwYXVIVlFpaDJRTVBHV1doa1Ez?=
 =?utf-8?B?WmF4S1dOSXo0WVQ2cncyYkdWN3NNSm44SWppRnZkUFJSN2JTSWVEbFdWenJJ?=
 =?utf-8?B?MGlIZ3FBZ0NoQldaODgzeEhqZllFRno4VUNaTDk5RU5ZRzFXZ3FnUnRENm00?=
 =?utf-8?B?NFdIUlJLa0tMRnMrbkdBdDkzaFUvN2NQVExlWUh0TFR1Kzk2WDV6dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bf9843-8307-46a4-dc90-08de898caf69
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 10:04:06.8389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcGoOxSbu1xTJO+Rw398JNdyzW3HNrfBmgDqcLqtKTHDF6NCvif+ReML3wjWYE8V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913
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


To add - the existing usage also avoids redundant memory copies of 
in/out arguments which is there with the new series.

On 24-Mar-26 3:26 PM, Lazar, Lijo wrote:
> 
> 
> On 24-Mar-26 3:00 PM, Wang, Yang(Kevin) wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Your comments rely on subjective assumptions ("I don't think") lacking 
>> technical justification.
>> this increases review cost and slows progress without clear technical 
>> basis.
>>
>> my approach stays simple: this patch optimizes common message paths 
>> and hides unnecessary low-level details.
>> And the original low‑level APIs remain available, so, developers can 
>> still use them whenever fine‑grained control is required.
> 
> These are the ones in case you missed -
> 
> 1) This uses same function with multiple variants and it is difficult to 
> figure out which form to use.
> 
> 2) It also becomes reading coding the difficult. Refer back the same 
> message to figure out which form is being used.
> 
> 3) The existing implementation is not complicated, there is nothing 
> lowlevel in that. It's just a form of API which takes a struct instead 
> of 11 parameters for in/out (at it fullest level it can have 12 
> parameters in this form). It's much clearer to read the code in that 
> usage and it presents a uniform API rather than multiple forms of usage.
> 
> Thanks,
> Lijo
> 
>>
>> Best Regards,
>> Kevin
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, March 24, 2026 2:12 PM
>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd- 
>> gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking 
>> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
>> Subject: Re: [PATCH 1/4] drm/amd/pm: add variant func 
>> smu_cmn_send_msg() to unify msg sending logic
>>
>>
>>
>> On 24-Mar-26 4:42 AM, Yang Wang wrote:
>>> add variant func smu_cmn_send_msg() to unify smu message sending
>>> logic, and enabling support for newer ASIC interfaces such as SMU v15 
>>> and upcoming devices.
>>> (support multi-param/multi-response, standardize code across all smu
>>> code layers)
>>>
>>> The smu_cmn_send_msg() API will expand to the following prototypes 
>>> based on the number of input parameters.
>>> e.g:
>>> 1. r = smu_cmn_send_msg(smu, msg_id);
>>> 2. r = smu_cmn_send_msg(smu, msg_id, &read_arg); 3. r =
>>> smu_cmn_send_msg(smu, msg_id, param, &read_arg); 4. r =
>>> smu_cmn_send_msg(smu, msg_id,
>>>                        num_param, [param0, param1, ...],
>>>                        num_response, [arg0, arg1, ...]
>>
>> As mentioned earlier, I don't think this helps with readability of the 
>> code. This commit message has to be referred always regarding usage. For
>> ex: if I want to send a message which has only one output argument and 
>> no input argument, it takes a while to figure out which form to use.
>>
>> Instead, it's better to expose args structure directly to user. I 
>> don't think it's so complicated to use like this.
>>
>> https://gitlab.freedesktop.org/agd5f/linux/-/blob/drm-next/drivers/ 
>> gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c#L627
>>
>> Maybe I've a biased view, I feel like it's easier to read this way 
>> about what is being done.
>>
>> Thanks,
>> Lijo
>>
>>
>>>
>>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 79 ++++++++++++++++++++++ 
>>> ++++
>>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 22 +++++++
>>>    2 files changed, 101 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> index 7bd8c435466a..480d91d88957 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> @@ -193,6 +193,85 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
>>>                                               read_arg);
>>>    }
>>>
>>> +static inline int smu_cmn_send_msg_internal(struct smu_context *smu, 
>>> enum smu_message_type msg,
>>> +                                         int num_in_args, u32 *in_args,
>>> +                                         int num_out_args, u32 
>>> *out_args) {
>>> +     struct smu_msg_ctl *ctl = &smu->msg_ctl;
>>> +     struct smu_msg_args args = { 0 };
>>> +     int ret;
>>> +
>>> +     if (msg >= SMU_MSG_MAX_COUNT)
>>> +             return -EINVAL;
>>> +
>>> +     if ((num_in_args >= ARRAY_SIZE(args.args) || num_in_args < 0) ||
>>> +         (num_out_args >= ARRAY_SIZE(args.out_args) || num_out_args 
>>> < 0))
>>> +             return -EINVAL;
>>> +
>>> +     if ((num_in_args > 0 && !in_args) || (num_out_args > 0 && ! 
>>> out_args))
>>> +             return -EINVAL;
>>> +
>>> +     if (!ctl->ops || !ctl->ops->send_msg)
>>> +             return -EOPNOTSUPP;
>>> +
>>> +     args.msg = msg;
>>> +     args.num_args = num_in_args;
>>> +     args.num_out_args = num_out_args;
>>> +     args.flags = 0;
>>> +     args.timeout = 0;
>>> +
>>> +     if (num_in_args)
>>> +             memcpy(&args.args[0], in_args, num_in_args * sizeof(u32));
>>> +
>>> +     ret = ctl->ops->send_msg(ctl, &args);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     if (num_out_args)
>>> +             memcpy(out_args, &args.out_args[0], num_out_args * 
>>> sizeof(u32));
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +/*
>>> + * NOTE: To ensure compatibility with the behavioral logic of the
>>> +legacy API,
>>> + * it is required to explicitly set the parameter "param" to 0 when
>>> +invoking
>>> + * the msg_0 and msg_1 functions.
>>> + * */
>>> +
>>> +int __smu_cmn_send_msg_0(struct smu_context *smu, enum
>>> +smu_message_type msg) {
>>> +     return __smu_cmn_send_msg_2(smu, msg, 0, NULL); }
>>> +
>>> +int __smu_cmn_send_msg_1(struct smu_context *smu, enum 
>>> smu_message_type msg,
>>> +                      u32 *read_arg)
>>> +{
>>> +     return __smu_cmn_send_msg_2(smu, msg, 0, read_arg); }
>>> +
>>> +int __smu_cmn_send_msg_2(struct smu_context *smu, enum 
>>> smu_message_type msg,
>>> +                      u32 param, u32 *read_arg)
>>> +{
>>> +     int ret;
>>> +
>>> +     if (read_arg)
>>> +             ret = smu_cmn_send_msg_internal(smu, msg, 1, &param, 1, 
>>> read_arg);
>>> +     else
>>> +             ret = smu_cmn_send_msg_internal(smu, msg, 1, &param, 0, 
>>> NULL);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +int __smu_cmn_send_msg_4(struct smu_context *smu, enum 
>>> smu_message_type msg,
>>> +                      int num_in_args, u32 *in_args,
>>> +                      int num_out_args, u32 *out_args)
>>> +{
>>> +     return smu_cmn_send_msg_internal(smu, msg,
>>> +                                      num_in_args, in_args,
>>> +                                      num_out_args, out_args);
>>> +}
>>> +
>>>    int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
>>>                         uint32_t msg)
>>>    {
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> index b76e86df5da7..5c14ed9ed9b4 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> @@ -210,6 +210,28 @@ int smu_cmn_dpm_pcie_gen_idx(int gen);
>>>    int smu_cmn_dpm_pcie_width_idx(int width);
>>>    int smu_cmn_check_fw_version(struct smu_context *smu);
>>>
>>> +int __smu_cmn_send_msg_0(struct smu_context *smu, enum
>>> +smu_message_type msg); int __smu_cmn_send_msg_1(struct smu_context 
>>> *smu, enum smu_message_type msg,
>>> +                      u32 *read_arg);
>>> +int __smu_cmn_send_msg_2(struct smu_context *smu, enum 
>>> smu_message_type msg,
>>> +                      u32 param, u32 *read_arg);
>>> +int __smu_cmn_send_msg_4(struct smu_context *smu, enum 
>>> smu_message_type msg,
>>> +                      int num_in_args, u32 *in_args,
>>> +                      int num_out_args, u32 *out_args);
>>> +
>>> +/*
>>> +* The smu_cmn_send_msg() API will expand to the following prototypes 
>>> based on the number of input parameters.
>>> +* e.g:
>>> +* 1. r = smu_cmn_send_msg(smu, msg_id);
>>> +* 2. r = smu_cmn_send_msg(smu, msg_id, &read_arg);
>>> +* 3. r = smu_cmn_send_msg(smu, msg_id, param, &read_arg);
>>> +* 4. r = smu_cmn_send_msg(smu, msg_id,
>>> +*                      num_param, [param0, param1, ...],
>>> +*                      num_response, [arg0, arg1, ...]
>>> +*/
>>> +#define smu_cmn_send_msg(smu, msg, ...) \
>>> +     CONCATENATE(__smu_cmn_send_msg_, COUNT_ARGS(__VA_ARGS__))(smu, 
>>> msg,
>>> +##__VA_ARGS__)
>>> +
>>>    /*SMU gpu metrics */
>>>
>>>    /* Attribute ID mapping */
>>
> 

