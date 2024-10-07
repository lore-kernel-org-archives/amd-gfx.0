Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2945ECFB43F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 14:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C5510E339;
	Mon,  7 Oct 2024 14:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dniE7sJF";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19BA410E339
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 14:29:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nr8Q9uTyOw0eKSQ5b5rEAATMB05yX+27ohlvPR771Hr4P+oH3UrNfs59yi6VdXb3qVAaOMag3KwtMbaWf96vZIgcZjpOQ/y3XE3d43vJHf0JuE5GDvhGYFrGKpCLbTj8JBaJedtYa31IuiLvTj8AbX4MPf0fNW2App69oi/8PMcvGsnL/eViRXJ1nqvtSoGJ2ACY12Kt9GNQVFAc6AxHJxa9j3DGWITo3GmmLW1Ezzwiq1C/I/rrpTa1zafqX8mq2jF1mUNty2rqJLUB+TuSZ8956bjkPoJ1LOVLbMajc2JULu6F243ySHABWCHM5aSQ4VistPvD1gvg/UDxypc/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RD51iiyBy64efnvvAhH5PoP6+ZvJsVib/lvlw2Zayg=;
 b=I2QzbN7LoukUba6JbX8pGesYcgCMTaIq0jco0W0gAEmhPFRNXNMh34c17dfsGY1QERn38DzQZHIMXHMSV6HFYIG9auW4z9effy9pLQl7CGeJ42YiyHaE6TaHLE8dP+xy2G5hPjFSyYJj2Pbm9ujGIhTeIwyHnnQDe6e53zDc7ZQDUrkuBoKBP299h865lv5vOh/sopiqTd3k6PjzJma9JaV9hzWm36B1o5dlqb4JlJMr7WVNXkZ6evP6TK28b87Lr/vw7DmzSPRcjKSChregDx8XHrW9aCu57XbA8EvQUzc5e3/h7SbucS378Uz3TNmJG12Apw6msAomoKfDy2Qrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RD51iiyBy64efnvvAhH5PoP6+ZvJsVib/lvlw2Zayg=;
 b=dniE7sJFfxBw4qF30eM9dWFwaXs2nE8ZYbkOUOljHGBFR5Z4/Mk8kOttIsl1B4KYaS1BM6qGfalJ0tgR3BWWLTmYUEElaOoJlFb2xA+Kga7bzh+sQnClXXOhmoFssq2XH7Zmfl98dyWtPqrKUCuqXfxK5796+XuLp6BdN6E9wqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 14:29:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 14:29:17 +0000
Message-ID: <62340f5c-6d5f-49f3-9481-dc24adb5177e@amd.com>
Date: Mon, 7 Oct 2024 16:29:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] drm/amdgpu: power vcn 2_5 by instance
To: Alex Deucher <alexdeucher@gmail.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Boyuan Zhang <Boyuan.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 leo.liu@amd.com, alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
 <20241004184444.435356-12-boyuan.zhang@amd.com>
 <4a7b5736-f60b-433b-a021-fef2cf4f2338@amd.com>
 <2d260d2c-d052-4b07-9cbf-0e5fc4199f98@amd.com>
 <5f4babf7-f8b9-4a93-8858-849b8b32c3b9@amd.com>
 <CADnq5_NK2fQMo=N=KEnnw3Not9PnWAw4nBK4+JUfY-Km7dX1Aw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_NK2fQMo=N=KEnnw3Not9PnWAw4nBK4+JUfY-Km7dX1Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0445.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b818f9-10e4-4730-7a8f-08dce6dc6cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sld1aXpEaTcyVFMvQnlqRGVMVlJBVXR1ZVhHanpjN3lMQlRFM0I0VUpCeEdB?=
 =?utf-8?B?djJpT0doWndWZ2lCMkQzY0dYdDJuZGNyVTRUbGl5QmtBNUJyRlhTc1psdXVW?=
 =?utf-8?B?bk9HNEl0WW9DR0luVXpLZ0FKZktHRUgvUUxBK2JzcnphZzQxQ1J2d1Q5d0Zj?=
 =?utf-8?B?eG13VjdxVWIyUnJHR0d2ZjY5ZmFPLzd2K3FnaTVVdWEzU1JBVDM2VXlkbHVp?=
 =?utf-8?B?eWtmUXloelRISWltK3d2TDhZTmlNMzBNdEloRVRCaFhkeTdPdE5nRzJBWmdQ?=
 =?utf-8?B?aGFjRm91Q0V2cDNNSE5sRFo4ODY3blVQV0ZSSDUvc1FBMCs2aHhVdDBxekJm?=
 =?utf-8?B?NlhmaldicWF2UEpDQXNabitFRzd5OE11V0Z3a1AvRlBzU3JRVjB6YjZXaTlm?=
 =?utf-8?B?RWFFYlpYWHF2dDhvVWJLUzY0WDJGWTFZaGhmVitsZ2RUNUp4L0J3dGhnWjg2?=
 =?utf-8?B?bWM0THI0WkkyOWNGUzFySEJpV05rOVgzMzNiWUR0TklwR2FyQW52RVNCZTN1?=
 =?utf-8?B?WUEwQ211RVlMSnhucWFQc1krQmwvRHA0SldLUXNabk8vZ0ZNdzZzTnp5N1Fp?=
 =?utf-8?B?cnUyV0lmRVlSV2tDR1JFVzVjZzgvMTBNL05zYVhuY2N1TlNHYU5WeGdkaFdi?=
 =?utf-8?B?RHNoa2MwU09aeEFYQWZ1RHJTOEFyMEJUWVFVMllDOEwwT3ltNmxkVS93a2JJ?=
 =?utf-8?B?LzNIQVVBR1p3SWhvcy8yN1NoRVVHWkZzVnIrbWxMdXNBbEhWTXROcTEwQTNV?=
 =?utf-8?B?bWREM2g3RFNKOS9VRnhqL3VsS292dy9qS0RzaEZMdENiZHN2Q05vZ29oa21V?=
 =?utf-8?B?bVR2TzA5ejkxajlMaUtGVlVtZU54QzladGErWWs4WEhETXMweFZqNitaaURm?=
 =?utf-8?B?R3FPdVZGeHJaZUZCYUtYN0RHQWdvcTlRNlVSQ0pJZ3dyUUIrZnV4M2FPbzNq?=
 =?utf-8?B?QW9jQlpUU2tDaDdBRWw0RjRBWjhCdzUyOUl2SUlGNDdQbHJMZEZ6MndlaE5w?=
 =?utf-8?B?b3JIWWYxOU8reWt3Y3M1d3dnZy83R0RyVTVXWWxPa1o0WUdJMys0bUlmeFUr?=
 =?utf-8?B?WCtrSk9qZStUQkpMSWRGOTB3Y3hWL1pJMWFvWmtNQngvekJNTGVWVUJiWm9r?=
 =?utf-8?B?eExLTGhOMVE2SUVNY0cxS1U1VHc2SkhaS3JMaFBHQ2h4enV0RGRldlBsdTVo?=
 =?utf-8?B?T1FvOENPeDJJQ0ROTmNPL0dkR2NjSjBRSVVKTHl4MG1ZL2E2YWdTMm8wVmF4?=
 =?utf-8?B?TG5rb0hSVVhqVWRIWVlnZlpSUUN1NW5hOEp5dkdESE9ndTMxM3VHMi9mWmRH?=
 =?utf-8?B?RHU4c1ZXMmhZSlQ2eUtaaGx0YUhpcUZ4MTd6WHAwbk5VVHJVNGZPTlhyQVRQ?=
 =?utf-8?B?Q2Q1SGpCUFg2cXpmbm9XdjhuUUpjVWd2UE9SSzVwelZMK0VhUlgvNXp2UkJX?=
 =?utf-8?B?d3ZIemsyOHZnRWZQZTlZbUFxYmJRYVlJbU1wYlp4WUUzanhDWkwyS0crNVF5?=
 =?utf-8?B?YnUzMWRBY0JGeFcyM0lQRm5iazcxMWd0V29YOVh5S2pZNUJRa0FRQVFuYWlr?=
 =?utf-8?B?d0NMQ3UxWnY5SU1PSTF3SXhyeno1NEkwSGRFR2NhWTdXK3RpbzlaOVNoZ3I5?=
 =?utf-8?B?T1hZMEtkdnRUaTgySG9PNE5sa29vblllRjR4UE9POHRrY2M2U0NQc05HcWJ5?=
 =?utf-8?B?UTU1UmRDTkNKODV5Sk1ERGtjRERzR05hakVLSWVKaGZKaHFRZi9MNGdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmxMS2VmMzN2cTZXS01RRmRIbndnZXZJMWYzZjFXcTZnYWVpTEpjWGVlQ0RP?=
 =?utf-8?B?Ly9XTkRndkhxQm4rdkpPaEg1Q2daS25yQklUaU93Y2NXdzdZWFNkVmxZZWtJ?=
 =?utf-8?B?S3h2SnpFYW1xVDhvRHIrd2IvZWUwZVo4ek91VkxwWFdZVm5HMEJBV3BKYnk4?=
 =?utf-8?B?SFV0YUZHTDBFVExrZUtVZGFpUTZOTFVlbCtDb0lBLzIraFM2TnBlSk1LMEZv?=
 =?utf-8?B?UjhlZ2lDVk9YbS9TS2U4ZndEaWNDTk5OdkVTbHNEY2tmTEtCbk0rNUpic084?=
 =?utf-8?B?M3lqRVhDT1gvK1lGMUNsaEw3bDZMcVlWZU95M2FaSVhPZU14QUlSd1E2T3hX?=
 =?utf-8?B?bnJ4czlESHhBVWI1a0pWRmhWY0JoRW9pN2dGRGtYRXB1L01SVGIwYi9HU0ZW?=
 =?utf-8?B?OWxBemhydFVTaXVmRm8xMnAwVkJRSXMxejIyQVhtMlBvTCtZbklaaEtNNTRH?=
 =?utf-8?B?OC82YURXREp5QVU1SFNsaGczSm5SRDVlQUtNU2JnOFEzV2NiQmYyWXBsUThq?=
 =?utf-8?B?Ykc1UXNiVHRFTDdJWjlFV3NzNzdKcUhabVlyT1JMNEVYanV2a3BhU0paVlda?=
 =?utf-8?B?YWljNE9XUU5MTkM0bEY4MGpncTAzVklLZTVlR0pLUGk1Y00wVUQ3ZHpUM2Na?=
 =?utf-8?B?bUZaT3NSNngwbnBTKzlrYWwyanVNNFo3SDE2K1Z4clFYWjVnbjhkU1h6eG14?=
 =?utf-8?B?cG9Ja2ZlWVI5am4rUGErNTFlOTFtUldLUXMwQUk4QWlFdVZDUVhBZ0p3T2Yr?=
 =?utf-8?B?cWJqSTVRRWk5REdBeUcyTytWcmJhS05ML1dtby9seDN1OVdTbSs4amlwYy9D?=
 =?utf-8?B?ZWNzQWk2RnlGYWIyOVUyNU9WV3o5WFZ5QmkySGR1aitobTFGek1WbkZuTEFn?=
 =?utf-8?B?Ry91OG8yRDFsUVo5WGpUOHBxSDAzR3MvTFBMOC9SVHFtaEdBK3pZWmY4Mm1a?=
 =?utf-8?B?QnBIa0YxOXBKNkQ4SXArQ1JYN21ScVlxM1BBQ2kzRWQzampwdHZsU0RlbTJ1?=
 =?utf-8?B?R0VTNjg1MmVLQlZMNkNpNVV6ZXRFM1RJMlRoR0JxQzBwcTAvaUVENzZlT1VH?=
 =?utf-8?B?YTRHSVBxWS8wa1pBN3A3YnRHVnU5c2xIbDVERG5WQWZFNVkvakxxS01VZlZW?=
 =?utf-8?B?ZDlXNXY4ODZJdHFVOFV4d2RQZ2Q4YjcvU1lzSjJZa05BSzNxN1BmUDhRanRU?=
 =?utf-8?B?MnU5WHNXUGczYTVHdEM5L3ZZMzZnMi9hQkYvMU1VWTFrcUNJdFJIaEVsU1ZV?=
 =?utf-8?B?akwyLzdzenJ3bjNqbmxIZkpIdzFVL2l3cU1JckdqM0N5ZWprRElib05RcnNm?=
 =?utf-8?B?VXRRb0ZPK2hFTVpWaHc5anRweDhKYjZOTlhzY2d2dmFITzdHT05OVVhwTTJ6?=
 =?utf-8?B?M08vRERZYitDb0NidTZVQXUySjkvU3k5bTMxMmdnYjhQM0k3OThQRGJqK0dk?=
 =?utf-8?B?M0ZBSnhCWm1rU2kwVnB2cXVPcTBpYkN5cU5mMk8vYVJORVRLdEo5R3dHVjZn?=
 =?utf-8?B?TWhDelhhSHdCMCtsaVZKaXNKME84Sk5NaldxNGhHa0JidFFuVHgyTi8vVTVy?=
 =?utf-8?B?TzBrb3orazFRVnpDYk40NDZTbmJZZUlMVmtmRXl4YjJwdkhuRWJqeTBLclRa?=
 =?utf-8?B?TlNlQnM1LzBQeWVJejdVR1pDVEZOb3M5OVVGSVMyTEVWVkJPeFZlV1FJYWVk?=
 =?utf-8?B?S2xWMjNuUEtvQzNmZC9mWDFDblJTOGxvb3lwWGtLWVlPRzE2TTByOTVwSzNv?=
 =?utf-8?B?Q0M2RjN0dkZaWjlmbUdiMzd6Z1VGUU43ZHd4NWJIQU5YTWxVaWw3ZEJVS3hw?=
 =?utf-8?B?V0Vld2dkZmlEVUdleXZuSTI5SndMeitkci9NTFBLTDdJSEo0a3BlQjA2ckJl?=
 =?utf-8?B?TVVMbXFqSmxIVDRvS3ZYSnZmOG5jWnA3M2lneHY2ZHdkeDkvclFKR1Y0ZkVP?=
 =?utf-8?B?WGY0aUlxS0ppWDMrN1VVMFpPL3pyNzhjWUJ5alVldjlOSm5IQysvRE9MZmU5?=
 =?utf-8?B?SklLNEErZ0svQ0xjVlR3VVJCNjVPb01adzdhNkpNQzNEWGtEVzVhTTlqVkl2?=
 =?utf-8?B?UFo3a1FxeHYwYVpOaTNnbnJwVitPZnF6ZldJOG40MnNsdHNnejFYVnVCay92?=
 =?utf-8?Q?8/U/2evbFvAmprmLscF26tEts?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b818f9-10e4-4730-7a8f-08dce6dc6cdb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 14:29:17.6153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzpK+2yFfWVJk2K7b2FOYXaaTOzh47NRuLMoHXSwcmsDmMF5Ts8jxWwNAouCy86V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280
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

Am 07.10.24 um 16:17 schrieb Alex Deucher:
> On Mon, Oct 7, 2024 at 9:58 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>> On 10/7/2024 7:03 PM, Boyuan Zhang wrote:
>>> On 2024-10-07 01:22, Lazar, Lijo wrote:
>>>> On 10/5/2024 12:14 AM, boyuan.zhang@amd.com wrote:
>>>>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>>>>
>>>>> For vcn 2_5, add ip_block for each vcn instance during discovery stage.
>>>>>
>>>>> And only powering on/off one of the vcn instance using the
>>>>> instance value stored in ip_block, instead of powering on/off all
>>>>> vcn instances. Modify the existing functions to use the instance value
>>>>> in ip_block, and remove the original for loop for all vcn instances.
>>>>>
>>>>> v2: rename "i"/"j" to "inst" for instance value.
>>>>>
>>>>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +-
>>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 565 +++++++++---------
>>>>>    2 files changed, 280 insertions(+), 289 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>> index 9f9a1867da72..de1053cc2a2b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>> @@ -2278,6 +2278,7 @@ static int
>>>>> amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
>>>>>      static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device
>>>>> *adev)
>>>>>    {
>>>>> +    int i;
>>>>>        if (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
>>>>>            switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
>>>>>            case IP_VERSION(7, 0, 0):
>>>>> @@ -2321,7 +2322,8 @@ static int
>>>>> amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>>>>>            case IP_VERSION(2, 0, 3):
>>>>>                break;
>>>>>            case IP_VERSION(2, 5, 0):
>>>>> -            amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
>>>>> +            for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
>>>>> +                amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
>>>> This introduces a totally confusing design now. At a higher level an IP
>>>> block type manages multiple instances and their power states. Now there
>>>> is a mix where no definition can be attributed to an IP block. Or, if
>>>> this were to be done uniformly for other IPs, then for some SOCs there
>>>> could be 16 SDMA blocks, 8 GFX blocks and so forth.
>>>>
>>>> What is the reason to do this way? Can't VCN IP block maintain the state
>>>> of multiple instances within itself?
>>>>
>>>> Thanks,
>>>> Lijo
>>> This is part of the fundamental design change for separating IP block
>>> per instance, in order to
>>> handle each instance separately within same IP block (e.g. separate
>>> power/clock management).
>>>
>>> Part 1, Change all adev ptr handle to amdgpu_ip_block ptr in all
>>> callbacks (hw_init/fini, sw_init/fini,
>>> suspend, etc...) for all IP blocks, so that each IP knows which IP_block
>>> (and which instance) the
>>> callback is for. Most parts of this changes have been submitted by Sunil.
>>>
>>> Part 2, Separate IP block per instance.
>>>
>>> Part 3, Since callbacks can pass in IP_block now after Part 1 change and
>>> instance value can be
>>> obtained from each IP block in Part 2, IP can then choose to handle
>>> callbacks ONLY for the given
>>> instance of a given IP block (or still handling for all instances as
>>> before).
>>> For VCN, all callbacks will be handled only for the given one instance,
>>> instead of the original for-
>>> loop for all instance. As a result, each VCN instance can be
>>> start/stop/int/fini/suspend separately.
>>>
>>> Part 4, Change all VCN helper functions to handle only the given
>>> instance, instead of the original
>>> for-loop for all instance.
>>>
>>> Each instance can have its own states, so we think it makes more sense
>>> to separate them on IP
>>> block level to handle each of them separately.
>>
>> Such a change should not be done unless all IPs follow the same design.
>> You didn't answer the question - what necessitates this change? What is
>> special about VCN that it cannot manage the states of multiple instances
>> within the IP block?
> We want to be able to manage the powergating independently for each
> VCN instance for both power management and VCN reset.  Right now power
> gating is handled at the IP level so it's not easy or clean to handle
> powergating of individual IP instances.

Longer story short the design should be applied to all IPs, but VCN is 
just the block were we current ran into problems.

So yes long term plan is to change all designs with multiple blocks into 
this per instance format IP block format.

Christian.

>
> Alex
>
>> Thanks,
>> Lijo
>>
>>> Thanks,
>>> Boyuan
>>>>>                amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
>>>>>                break;
>>>>>            case IP_VERSION(2, 6, 0):
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>>>> index d00df51bc400..1f8738ae360a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>>>> @@ -158,35 +158,34 @@ static int vcn_v2_5_early_init(struct
>>>>> amdgpu_ip_block *ip_block)
>>>>>    static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>>>>>    {
>>>>>        struct amdgpu_ring *ring;
>>>>> -    int i, j, r;
>>>>> +    int i, r;
>>>>>        uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
>>>>>        uint32_t *ptr;
>>>>>        struct amdgpu_device *adev = ip_block->adev;
>>>>> +    int inst = ip_block->instance;
>>>>>    -    for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
>>>>> -        if (adev->vcn.harvest_config & (1 << j))
>>>>> -            continue;
>>>>> -        /* VCN DEC TRAP */
>>>>> -        r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>>>>> -                VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT,
>>>>> &adev->vcn.inst[j].irq);
>>>>> -        if (r)
>>>>> -            return r;
>>>>> -
>>>>> -        /* VCN ENC TRAP */
>>>>> -        for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>>>> -            r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>>>>> -                i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
>>>>> &adev->vcn.inst[j].irq);
>>>>> -            if (r)
>>>>> -                return r;
>>>>> -        }
>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>> +        goto sw_init;
>>>>> +    /* VCN DEC TRAP */
>>>>> +    r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>>>>> +            VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT,
>>>>> &adev->vcn.inst[inst].irq);
>>>>> +    if (r)
>>>>> +        return r;
>>>>>    -        /* VCN POISON TRAP */
>>>>> -        r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>>>>> -            VCN_2_6__SRCID_UVD_POISON,
>>>>> &adev->vcn.inst[j].ras_poison_irq);
>>>>> +    /* VCN ENC TRAP */
>>>>> +    for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>>>> +        r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>>>>> +            i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
>>>>> &adev->vcn.inst[inst].irq);
>>>>>            if (r)
>>>>>                return r;
>>>>>        }
>>>>>    +    /* VCN POISON TRAP */
>>>>> +    r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>>>>> +        VCN_2_6__SRCID_UVD_POISON,
>>>>> &adev->vcn.inst[inst].ras_poison_irq);
>>>>> +    if (r)
>>>>> +        return r;
>>>>> +sw_init:
>>>>>        r = amdgpu_vcn_sw_init(adev);
>>>>>        if (r)
>>>>>            return r;
>>>>> @@ -197,76 +196,74 @@ static int vcn_v2_5_sw_init(struct
>>>>> amdgpu_ip_block *ip_block)
>>>>>        if (r)
>>>>>            return r;
>>>>>    -    for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
>>>>> -        volatile struct amdgpu_fw_shared *fw_shared;
>>>>> +    volatile struct amdgpu_fw_shared *fw_shared;
>>>>>    -        if (adev->vcn.harvest_config & (1 << j))
>>>>> -            continue;
>>>>> -        adev->vcn.internal.context_id =
>>>>> mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
>>>>> -        adev->vcn.internal.ib_vmid =
>>>>> mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
>>>>> -        adev->vcn.internal.ib_bar_low =
>>>>> mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
>>>>> -        adev->vcn.internal.ib_bar_high =
>>>>> mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
>>>>> -        adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
>>>>> -        adev->vcn.internal.gp_scratch8 =
>>>>> mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
>>>>> -
>>>>> -        adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
>>>>> -        adev->vcn.inst[j].external.scratch9 = SOC15_REG_OFFSET(VCN,
>>>>> j, mmUVD_SCRATCH9);
>>>>> -        adev->vcn.internal.data0 =
>>>>> mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
>>>>> -        adev->vcn.inst[j].external.data0 = SOC15_REG_OFFSET(VCN, j,
>>>>> mmUVD_GPCOM_VCPU_DATA0);
>>>>> -        adev->vcn.internal.data1 =
>>>>> mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
>>>>> -        adev->vcn.inst[j].external.data1 = SOC15_REG_OFFSET(VCN, j,
>>>>> mmUVD_GPCOM_VCPU_DATA1);
>>>>> -        adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
>>>>> -        adev->vcn.inst[j].external.cmd = SOC15_REG_OFFSET(VCN, j,
>>>>> mmUVD_GPCOM_VCPU_CMD);
>>>>> -        adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
>>>>> -        adev->vcn.inst[j].external.nop = SOC15_REG_OFFSET(VCN, j,
>>>>> mmUVD_NO_OP);
>>>>> -
>>>>> -        ring = &adev->vcn.inst[j].ring_dec;
>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>> +        goto done;
>>>>> +    adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
>>>>> +    adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
>>>>> +    adev->vcn.internal.ib_bar_low =
>>>>> mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
>>>>> +    adev->vcn.internal.ib_bar_high =
>>>>> mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
>>>>> +    adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
>>>>> +    adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
>>>>> +
>>>>> +    adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
>>>>> +    adev->vcn.inst[inst].external.scratch9 = SOC15_REG_OFFSET(VCN,
>>>>> inst, mmUVD_SCRATCH9);
>>>>> +    adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
>>>>> +    adev->vcn.inst[inst].external.data0 = SOC15_REG_OFFSET(VCN,
>>>>> inst, mmUVD_GPCOM_VCPU_DATA0);
>>>>> +    adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
>>>>> +    adev->vcn.inst[inst].external.data1 = SOC15_REG_OFFSET(VCN,
>>>>> inst, mmUVD_GPCOM_VCPU_DATA1);
>>>>> +    adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
>>>>> +    adev->vcn.inst[inst].external.cmd = SOC15_REG_OFFSET(VCN, inst,
>>>>> mmUVD_GPCOM_VCPU_CMD);
>>>>> +    adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
>>>>> +    adev->vcn.inst[inst].external.nop = SOC15_REG_OFFSET(VCN, inst,
>>>>> mmUVD_NO_OP);
>>>>> +
>>>>> +    ring = &adev->vcn.inst[inst].ring_dec;
>>>>> +    ring->use_doorbell = true;
>>>>> +
>>>>> +    ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 <<
>>>>> 1) +
>>>>> +            (amdgpu_sriov_vf(adev) ? 2*inst : 8*inst);
>>>>> +
>>>>> +    if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
>>>>> +        ring->vm_hub = AMDGPU_MMHUB1(0);
>>>>> +    else
>>>>> +        ring->vm_hub = AMDGPU_MMHUB0(0);
>>>>> +
>>>>> +    sprintf(ring->name, "vcn_dec_%d", inst);
>>>>> +    r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq,
>>>>> +                 0, AMDGPU_RING_PRIO_DEFAULT, NULL);
>>>>> +    if (r)
>>>>> +        return r;
>>>>> +
>>>>> +    for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>>>> +        enum amdgpu_ring_priority_level hw_prio =
>>>>> amdgpu_vcn_get_enc_ring_prio(i);
>>>>> +
>>>>> +        ring = &adev->vcn.inst[inst].ring_enc[i];
>>>>>            ring->use_doorbell = true;
>>>>>              ring->doorbell_index =
>>>>> (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>>>>> -                (amdgpu_sriov_vf(adev) ? 2*j : 8*j);
>>>>> +                (amdgpu_sriov_vf(adev) ? (1 + i + 2*inst) : (2 + i +
>>>>> 8*inst));
>>>>>    -        if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2,
>>>>> 5, 0))
>>>>> +        if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
>>>>> +            IP_VERSION(2, 5, 0))
>>>>>                ring->vm_hub = AMDGPU_MMHUB1(0);
>>>>>            else
>>>>>                ring->vm_hub = AMDGPU_MMHUB0(0);
>>>>>    -        sprintf(ring->name, "vcn_dec_%d", j);
>>>>> -        r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq,
>>>>> -                     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
>>>>> +        sprintf(ring->name, "vcn_enc_%d.%d", inst, i);
>>>>> +        r = amdgpu_ring_init(adev, ring, 512,
>>>>> +                     &adev->vcn.inst[inst].irq, 0,
>>>>> +                     hw_prio, NULL);
>>>>>            if (r)
>>>>>                return r;
>>>>> -
>>>>> -        for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>>>> -            enum amdgpu_ring_priority_level hw_prio =
>>>>> amdgpu_vcn_get_enc_ring_prio(i);
>>>>> -
>>>>> -            ring = &adev->vcn.inst[j].ring_enc[i];
>>>>> -            ring->use_doorbell = true;
>>>>> -
>>>>> -            ring->doorbell_index =
>>>>> (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>>>>> -                    (amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i
>>>>> + 8*j));
>>>>> -
>>>>> -            if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
>>>>> -                IP_VERSION(2, 5, 0))
>>>>> -                ring->vm_hub = AMDGPU_MMHUB1(0);
>>>>> -            else
>>>>> -                ring->vm_hub = AMDGPU_MMHUB0(0);
>>>>> -
>>>>> -            sprintf(ring->name, "vcn_enc_%d.%d", j, i);
>>>>> -            r = amdgpu_ring_init(adev, ring, 512,
>>>>> -                         &adev->vcn.inst[j].irq, 0,
>>>>> -                         hw_prio, NULL);
>>>>> -            if (r)
>>>>> -                return r;
>>>>> -        }
>>>>> -
>>>>> -        fw_shared = adev->vcn.inst[j].fw_shared.cpu_addr;
>>>>> -        fw_shared->present_flag_0 =
>>>>> cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
>>>>> -
>>>>> -        if (amdgpu_vcnfw_log)
>>>>> -            amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>>>>>        }
>>>>>    +    fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
>>>>> +    fw_shared->present_flag_0 =
>>>>> cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
>>>>> +
>>>>> +    if (amdgpu_vcnfw_log)
>>>>> +        amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>>>>> +done:
>>>>>        if (amdgpu_sriov_vf(adev)) {
>>>>>            r = amdgpu_virt_alloc_mm_table(adev);
>>>>>            if (r)
>>>>> @@ -1005,197 +1002,192 @@ static int vcn_v2_5_start_dpg_mode(struct
>>>>> amdgpu_device *adev, int inst_idx, boo
>>>>>        return 0;
>>>>>    }
>>>>>    -static int vcn_v2_5_start(struct amdgpu_device *adev)
>>>>> +static int vcn_v2_5_start(struct amdgpu_device *adev, unsigned int
>>>>> inst)
>>>>>    {
>>>>>        struct amdgpu_ring *ring;
>>>>>        uint32_t rb_bufsz, tmp;
>>>>> -    int i, j, k, r;
>>>>> +    int j, k, r;
>>>>>    -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>> -        if (adev->pm.dpm_enabled)
>>>>> -            amdgpu_dpm_enable_vcn(adev, true, i);
>>>>> -    }
>>>>> -
>>>>> -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>> -        if (adev->vcn.harvest_config & (1 << i))
>>>>> -            continue;
>>>>> -        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>>>> -            r = vcn_v2_5_start_dpg_mode(adev, i,
>>>>> adev->vcn.indirect_sram);
>>>>> -            continue;
>>>>> -        }
>>>>> +    if (adev->pm.dpm_enabled)
>>>>> +        amdgpu_dpm_enable_vcn(adev, true, inst);
>>>>>    -        /* disable register anti-hang mechanism */
>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
>>>>> -            ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>> +        return 0;
>>>>>    -        /* set uvd status busy */
>>>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) |
>>>>> UVD_STATUS__UVD_BUSY;
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
>>>>> +    if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>>>> +        r = vcn_v2_5_start_dpg_mode(adev, inst,
>>>>> adev->vcn.indirect_sram);
>>>>> +        return r;
>>>>>        }
>>>>>    +    /* disable register anti-hang mechanism */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS), 0,
>>>>> +        ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>>> +
>>>>> +    /* set uvd status busy */
>>>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_STATUS, tmp);
>>>>> +
>>>>>        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>>>>>            return 0;
>>>>>          /*SW clock gating */
>>>>>        vcn_v2_5_disable_clock_gating(adev);
>>>>>    -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>> -        if (adev->vcn.harvest_config & (1 << i))
>>>>> -            continue;
>>>>> -        /* enable VCPU clock */
>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>>>>> -            UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>>>>> -
>>>>> -        /* disable master interrupt */
>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
>>>>> -            ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>>>> -
>>>>> -        /* setup mmUVD_LMI_CTRL */
>>>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
>>>>> -        tmp &= ~0xff;
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
>>>>> -            UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK    |
>>>>> -            UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
>>>>> -            UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
>>>>> -            UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
>>>>> -
>>>>> -        /* setup mmUVD_MPC_CNTL */
>>>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
>>>>> -        tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
>>>>> -        tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
>>>>> -
>>>>> -        /* setup UVD_MPC_SET_MUXA0 */
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
>>>>> -            ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>>>>> -            (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>>>>> -            (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>>>>> -            (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
>>>>> -
>>>>> -        /* setup UVD_MPC_SET_MUXB0 */
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
>>>>> -            ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>>>>> -            (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>>>>> -            (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>>>>> -            (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
>>>>> -
>>>>> -        /* setup mmUVD_MPC_SET_MUX */
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
>>>>> -            ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>>>>> -            (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>>>>> -            (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>>>>> -    }
>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>> +        return 0;
>>>>> +
>>>>> +    /* enable VCPU clock */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>>>>> +        UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>>>>> +
>>>>> +    /* disable master interrupt */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN), 0,
>>>>> +        ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>>>> +
>>>>> +    /* setup mmUVD_LMI_CTRL */
>>>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL);
>>>>> +    tmp &= ~0xff;
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL, tmp | 0x8|
>>>>> +        UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK    |
>>>>> +        UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
>>>>> +        UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
>>>>> +        UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
>>>>> +
>>>>> +    /* setup mmUVD_MPC_CNTL */
>>>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL);
>>>>> +    tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
>>>>> +    tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL, tmp);
>>>>> +
>>>>> +    /* setup UVD_MPC_SET_MUXA0 */
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXA0,
>>>>> +        ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>>>>> +        (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>>>>> +        (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>>>>> +        (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
>>>>> +
>>>>> +    /* setup UVD_MPC_SET_MUXB0 */
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXB0,
>>>>> +        ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>>>>> +        (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>>>>> +        (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>>>>> +        (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
>>>>> +
>>>>> +    /* setup mmUVD_MPC_SET_MUX */
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUX,
>>>>> +        ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>>>>> +        (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>>>>> +        (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>>>>>          vcn_v2_5_mc_resume(adev);
>>>>>    -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>> -        volatile struct amdgpu_fw_shared *fw_shared =
>>>>> adev->vcn.inst[i].fw_shared.cpu_addr;
>>>>> -        if (adev->vcn.harvest_config & (1 << i))
>>>>> -            continue;
>>>>> -        /* VCN global tiling registers */
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
>>>>> -            adev->gfx.config.gb_addr_config);
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
>>>>> -            adev->gfx.config.gb_addr_config);
>>>>> +    volatile struct amdgpu_fw_shared *fw_shared =
>>>>> adev->vcn.inst[inst].fw_shared.cpu_addr;
>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>> +        return 0;
>>>>> +
>>>>> +    /* VCN global tiling registers */
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
>>>>> +        adev->gfx.config.gb_addr_config);
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
>>>>> +        adev->gfx.config.gb_addr_config);
>>>>>    -        /* enable LMI MC and UMC channels */
>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
>>>>> -            ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>>>>> +    /* enable LMI MC and UMC channels */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_LMI_CTRL2), 0,
>>>>> +        ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>>>>>    -        /* unblock VCPU register access */
>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
>>>>> -            ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>>>> +    /* unblock VCPU register access */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL), 0,
>>>>> +        ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>>>>    -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>>>>> -            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>>>>> +        ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>    -        for (k = 0; k < 10; ++k) {
>>>>> -            uint32_t status;
>>>>> -
>>>>> -            for (j = 0; j < 100; ++j) {
>>>>> -                status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
>>>>> -                if (status & 2)
>>>>> -                    break;
>>>>> -                if (amdgpu_emu_mode == 1)
>>>>> -                    msleep(500);
>>>>> -                else
>>>>> -                    mdelay(10);
>>>>> -            }
>>>>> -            r = 0;
>>>>> +    for (k = 0; k < 10; ++k) {
>>>>> +        uint32_t status;
>>>>> +
>>>>> +        for (j = 0; j < 100; ++j) {
>>>>> +            status = RREG32_SOC15(VCN, inst, mmUVD_STATUS);
>>>>>                if (status & 2)
>>>>>                    break;
>>>>> +            if (amdgpu_emu_mode == 1)
>>>>> +                msleep(500);
>>>>> +            else
>>>>> +                mdelay(10);
>>>>> +        }
>>>>> +        r = 0;
>>>>> +        if (status & 2)
>>>>> +            break;
>>>>>    -            DRM_ERROR("VCN decode not responding, trying to reset
>>>>> the VCPU!!!\n");
>>>>> -            WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>>>>> -                UVD_VCPU_CNTL__BLK_RST_MASK,
>>>>> -                ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>> -            mdelay(10);
>>>>> -            WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>>>>> -                ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>> +        DRM_ERROR("VCN decode not responding, trying to reset the
>>>>> VCPU!!!\n");
>>>>> +        WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>>>>> +            UVD_VCPU_CNTL__BLK_RST_MASK,
>>>>> +            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>> +        mdelay(10);
>>>>> +        WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>>>>> +            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>    -            mdelay(10);
>>>>> -            r = -1;
>>>>> -        }
>>>>> +        mdelay(10);
>>>>> +        r = -1;
>>>>> +    }
>>>>>    -        if (r) {
>>>>> -            DRM_ERROR("VCN decode not responding, giving up!!!\n");
>>>>> -            return r;
>>>>> -        }
>>>>> +    if (r) {
>>>>> +        DRM_ERROR("VCN decode not responding, giving up!!!\n");
>>>>> +        return r;
>>>>> +    }
>>>>>    -        /* enable master interrupt */
>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
>>>>> -            UVD_MASTINT_EN__VCPU_EN_MASK,
>>>>> -            ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>>>> +    /* enable master interrupt */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN),
>>>>> +        UVD_MASTINT_EN__VCPU_EN_MASK,
>>>>> +        ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>>>>    -        /* clear the busy bit of VCN_STATUS */
>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
>>>>> -            ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>>>>> +    /* clear the busy bit of VCN_STATUS */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_STATUS), 0,
>>>>> +        ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>>>>>    -        WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_VMID, 0);
>>>>>    -        ring = &adev->vcn.inst[i].ring_dec;
>>>>> -        /* force RBC into idle state */
>>>>> -        rb_bufsz = order_base_2(ring->ring_size);
>>>>> -        tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
>>>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
>>>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
>>>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
>>>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
>>>>> +    ring = &adev->vcn.inst[inst].ring_dec;
>>>>> +    /* force RBC into idle state */
>>>>> +    rb_bufsz = order_base_2(ring->ring_size);
>>>>> +    tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
>>>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
>>>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
>>>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
>>>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_CNTL, tmp);
>>>>>    -        fw_shared->multi_queue.decode_queue_mode |=
>>>>> FW_QUEUE_RING_RESET;
>>>>> -        /* program the RB_BASE for ring buffer */
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>>>>> -            lower_32_bits(ring->gpu_addr));
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
>>>>> -            upper_32_bits(ring->gpu_addr));
>>>>> +    fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
>>>>> +    /* program the RB_BASE for ring buffer */
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>>>>> +        lower_32_bits(ring->gpu_addr));
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
>>>>> +        upper_32_bits(ring->gpu_addr));
>>>>>    -        /* Initialize the ring buffer's read and write pointers */
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
>>>>> +    /* Initialize the ring buffer's read and write pointers */
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR, 0);
>>>>>    -        ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
>>>>> -                lower_32_bits(ring->wptr));
>>>>> -        fw_shared->multi_queue.decode_queue_mode &=
>>>>> ~FW_QUEUE_RING_RESET;
>>>>> +    ring->wptr = RREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR);
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_WPTR,
>>>>> +            lower_32_bits(ring->wptr));
>>>>> +    fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
>>>>>    -        fw_shared->multi_queue.encode_generalpurpose_queue_mode |=
>>>>> FW_QUEUE_RING_RESET;
>>>>> -        ring = &adev->vcn.inst[i].ring_enc[0];
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI,
>>>>> upper_32_bits(ring->gpu_addr));
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
>>>>> -        fw_shared->multi_queue.encode_generalpurpose_queue_mode &=
>>>>> ~FW_QUEUE_RING_RESET;
>>>>> -
>>>>> -        fw_shared->multi_queue.encode_lowlatency_queue_mode |=
>>>>> FW_QUEUE_RING_RESET;
>>>>> -        ring = &adev->vcn.inst[i].ring_enc[1];
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2,
>>>>> lower_32_bits(ring->wptr));
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2,
>>>>> lower_32_bits(ring->wptr));
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2,
>>>>> upper_32_bits(ring->gpu_addr));
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
>>>>> -        fw_shared->multi_queue.encode_lowlatency_queue_mode &=
>>>>> ~FW_QUEUE_RING_RESET;
>>>>> -    }
>>>>> +    fw_shared->multi_queue.encode_generalpurpose_queue_mode |=
>>>>> FW_QUEUE_RING_RESET;
>>>>> +    ring = &adev->vcn.inst[inst].ring_enc[0];
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO, ring->gpu_addr);
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI,
>>>>> upper_32_bits(ring->gpu_addr));
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE, ring->ring_size / 4);
>>>>> +    fw_shared->multi_queue.encode_generalpurpose_queue_mode &=
>>>>> ~FW_QUEUE_RING_RESET;
>>>>> +
>>>>> +    fw_shared->multi_queue.encode_lowlatency_queue_mode |=
>>>>> FW_QUEUE_RING_RESET;
>>>>> +    ring = &adev->vcn.inst[inst].ring_enc[1];
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI2,
>>>>> upper_32_bits(ring->gpu_addr));
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE2, ring->ring_size / 4);
>>>>> +    fw_shared->multi_queue.encode_lowlatency_queue_mode &=
>>>>> ~FW_QUEUE_RING_RESET;
>>>>>          return 0;
>>>>>    }
>>>>> @@ -1424,72 +1416,69 @@ static int vcn_v2_5_stop_dpg_mode(struct
>>>>> amdgpu_device *adev, int inst_idx)
>>>>>        return 0;
>>>>>    }
>>>>>    -static int vcn_v2_5_stop(struct amdgpu_device *adev)
>>>>> +static int vcn_v2_5_stop(struct amdgpu_device *adev, unsigned int inst)
>>>>>    {
>>>>>        uint32_t tmp;
>>>>> -    int i, r = 0;
>>>>> +    int r = 0;
>>>>>    -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>> -        if (adev->vcn.harvest_config & (1 << i))
>>>>> -            continue;
>>>>> -        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>>>> -            r = vcn_v2_5_stop_dpg_mode(adev, i);
>>>>> -            continue;
>>>>> -        }
>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>> +        goto done;
>>>>>    -        /* wait for vcn idle */
>>>>> -        r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS,
>>>>> UVD_STATUS__IDLE, 0x7);
>>>>> -        if (r)
>>>>> -            return r;
>>>>> +    if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>>>> +        r = vcn_v2_5_stop_dpg_mode(adev, inst);
>>>>> +        goto done;
>>>>> +    }
>>>>>    -        tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
>>>>> -            UVD_LMI_STATUS__READ_CLEAN_MASK |
>>>>> -            UVD_LMI_STATUS__WRITE_CLEAN_MASK |
>>>>> -            UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
>>>>> -        r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
>>>>> -        if (r)
>>>>> -            return r;
>>>>> +    /* wait for vcn idle */
>>>>> +    r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS,
>>>>> UVD_STATUS__IDLE, 0x7);
>>>>> +    if (r)
>>>>> +        return r;
>>>>>    -        /* block LMI UMC channel */
>>>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
>>>>> -        tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
>>>>> +    tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
>>>>> +        UVD_LMI_STATUS__READ_CLEAN_MASK |
>>>>> +        UVD_LMI_STATUS__WRITE_CLEAN_MASK |
>>>>> +        UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
>>>>> +    r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
>>>>> +    if (r)
>>>>> +        return r;
>>>>>    -        tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
>>>>> -            UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
>>>>> -        r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
>>>>> -        if (r)
>>>>> -            return r;
>>>>> +    /* block LMI UMC channel */
>>>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2);
>>>>> +    tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2, tmp);
>>>>>    -        /* block VCPU register access */
>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
>>>>> -            UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
>>>>> -            ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>>>> +    tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
>>>>> +        UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
>>>>> +    r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
>>>>> +    if (r)
>>>>> +        return r;
>>>>>    -        /* reset VCPU */
>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>>>>> -            UVD_VCPU_CNTL__BLK_RST_MASK,
>>>>> -            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>> +    /* block VCPU register access */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL),
>>>>> +        UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
>>>>> +        ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>>>>    -        /* disable VCPU clock */
>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>>>>> -            ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>>>>> +    /* reset VCPU */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>>>>> +        UVD_VCPU_CNTL__BLK_RST_MASK,
>>>>> +        ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>    -        /* clear status */
>>>>> -        WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
>>>>> +    /* disable VCPU clock */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>>>>> +        ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>>>>>    -        vcn_v2_5_enable_clock_gating(adev);
>>>>> +    /* clear status */
>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
>>>>>    -        /* enable register anti-hang mechanism */
>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
>>>>> -            UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
>>>>> -            ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>>> -    }
>>>>> +    vcn_v2_5_enable_clock_gating(adev);
>>>>>    -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>> -        if (adev->pm.dpm_enabled)
>>>>> -            amdgpu_dpm_enable_vcn(adev, false, i);
>>>>> -    }
>>>>> +    /* enable register anti-hang mechanism */
>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS),
>>>>> +        UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
>>>>> +        ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>>> +done:
>>>>> +    if (adev->pm.dpm_enabled)
>>>>> +        amdgpu_dpm_enable_vcn(adev, false, inst);
>>>>>          return 0;
>>>>>    }
>>>>> @@ -1838,9 +1827,9 @@ static int
>>>>> vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>>>>            return 0;
>>>>>          if (state == AMD_PG_STATE_GATE)
>>>>> -        ret = vcn_v2_5_stop(adev);
>>>>> +        ret = vcn_v2_5_stop(adev, inst);
>>>>>        else
>>>>> -        ret = vcn_v2_5_start(adev);
>>>>> +        ret = vcn_v2_5_start(adev, inst);
>>>>>          if (!ret)
>>>>>            adev->vcn.cur_state[inst] = state;

