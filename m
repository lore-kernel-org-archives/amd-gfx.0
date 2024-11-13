Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3B9D462AB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 14:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9961810E253;
	Wed, 13 Nov 2024 14:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i6mYEPVP";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D0910E253
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 14:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMV1r11jj/ih+Oc5oGErcxcVnfi43XT6kiKuCv+YooRnfj00RkJXQ0nFPDPaEOrBc2WbsrkUU0bVLI+36hPTIVGibnu+nsrBJNTo+lWyNGNKg1UMZ+TYepSXCjbgoMzDF1TVqTorOisEAiGK+/uYf6afOXUmrtCnjlV+8EDvGPG9k/DLz49ka96KJrPwxBGsPjzpuamvvteiQOOt3NSjbpCsAg552/7e891EJeaJbicE33lJbeMdZywEB4YmBDTbZzsp4nRPAewZixNUsKGbFfxsCG+KuemWDOiZ/VhlSUJybwvI7iK7RmBqGUfWis5a547XhYOaInOTZfxLg+nSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysMDMrFouMV5b9ukeD19Iz5QBPErppmiIcsr6ZnfCY8=;
 b=bLM9eaWFR67NTUSyo/CFyrGLAl0IJsUEp5/MubjySppW/AQT+fM+3+mwwX9CQZ6u4WFJOobMuNxDhnu0wjVeRKIIeccN2+U+KbSGr468dlhZgOkZOiZoaeqcY6xhNfKxQwjTWSVmxG4RJRelY9hMxgfuFjNQlTkIfXgEEJUovtxwIYfaxlgPzJfFmDzkXAgD04Vm8t+NVu7+WIBql31KupNWI1FwnVxD1OlWD+m6lLgNtIb1MDp5Wb5auxOOzV1n7o65+XMLUd6FokT1oF6/HhB0mo+TO/kBtGCCqnA3kAJJPANAmfAnlR2trnUisyjMRzhH4XMXxmrDOMCVt0JcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysMDMrFouMV5b9ukeD19Iz5QBPErppmiIcsr6ZnfCY8=;
 b=i6mYEPVPslsJpfz6jfWibsPjD364fk7/8YQ+oj9ieY0rio31D/TWo+oJWMb592sp1JB62izoKft3DPH9P6Gsb3CVMB8oM4x5ufyXbRpq686fKIndA5DTK9Xtpjj2TvLrhbbRVu4A5RH8dpYguNPlAmasK4rlYjRxtHRJAan/Txo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Wed, 13 Nov
 2024 14:22:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:22:33 +0000
Message-ID: <76af3cc6-5535-47ca-9473-792f3e9c2d13@amd.com>
Date: Wed, 13 Nov 2024 15:22:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20241110154152.592-1-Yunxiang.Li@amd.com>
 <20241110154152.592-5-Yunxiang.Li@amd.com>
 <5d1c88a5-9802-4bb7-b76a-5e501847ced1@gmail.com>
 <SA1PR12MB85998D24DDB5EB93AE88E5A1ED592@SA1PR12MB8599.namprd12.prod.outlook.com>
 <92be210e-b552-45ee-9322-1944a4bfd325@amd.com>
 <cc63f0ef-e152-49fc-90d9-ca695a8918f3@igalia.com>
 <eed6b35e-912a-4d7a-ac18-643d571f6e03@amd.com>
 <SA1PR12MB85999903EC92F7A1329D741CED5A2@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB85999903EC92F7A1329D741CED5A2@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf14652-e9e6-4cc7-29b4-08dd03ee9d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1RodWRyWGlxYUFpL3doUFlPQXVkS3A1QmtkYzl5SHZJMjU2dWdidUw2UkEv?=
 =?utf-8?B?Rm1kVEVTN0kzUXR3bk1SNVpMc1BjS2UxK2ZOSC91WUxZNmZFOEpPSFZDaENh?=
 =?utf-8?B?L3o5U0ptUVJaZktkbSsvMjBMNWtiSXU2KzlqN2k2WDZwUzBhVGxpdDFqNWpx?=
 =?utf-8?B?QmFuOUozZ2wwZXJHVXI5V0Z2WElIdlhadS9ISnZaa0Qvcjh5VlFkSmJDdFJL?=
 =?utf-8?B?a3pnTXJucno0YTZxMHdlUHA0cHEyNmJaclJQZ1ZHUlpEVmNCUHYvL2ZMWi9r?=
 =?utf-8?B?VFlTa1d4V1ovd0wwTzNsbUxGaWw0dTlBWlpKaGFmTFhzcys3YkhPcHNJUlR2?=
 =?utf-8?B?N2RpSGpHZExNTU9QTjVJZUVwU3YydnlwQTRTdmNSUG5VSzZORkdTTUt2b0Fi?=
 =?utf-8?B?WGJidGlucUFVVWpvRGtaL3FEVEVrZzVKbUlwdjRYbzZjeEJzWFJTUVZhWEc0?=
 =?utf-8?B?cENCWUp2SmgyQ2gxTDF6MndLS2ZobzdiNTZBa0N3Y0hzREZYZnRwaVBoTkxR?=
 =?utf-8?B?NXBlTnFkQ0FMcDVkZEFJOVNUVXIyRXdqekxoTVpPd0d3TEtWVFp0bzJIOXBt?=
 =?utf-8?B?N1lnc2lHTk1RMHUrNld4NmxzLzczTld0LzNrRUZsdTJVMVdrTjJxZ1hNZ3J2?=
 =?utf-8?B?ZGF0STJac09LeUZlNlJyek5ZVmhkQWkxWlBPUGpaUTh4M016T2pRMW5VVnNW?=
 =?utf-8?B?M2ZZcE5VSWUxNzk3RUlNcXBaeE4wbEF2UTNJbkEzZ0o4RFpQVjdMbm9ZdEtv?=
 =?utf-8?B?SnRHZ3pxcGhKRjZ3NnBKKy80d2V4LzlOdXFTUklQSjdNLzZEUG52aFpCbE9H?=
 =?utf-8?B?Vk1yazFXR3V6eUpqTmR0bmJyNmMvUXpXVUYvZVd0YkM0Q0hmbklQRERINmtQ?=
 =?utf-8?B?SDcxb2ZIbXNNdW51Y01jVFo3eXp5UzdyTkc5NVl0dFBGakM2RGRuYzlFVW55?=
 =?utf-8?B?SU5jS0ZJUEpsZitTeWhBbnBnSXFKM3ZSR1NqcldmZGRNT09HbFhHUk5NYXVB?=
 =?utf-8?B?aThoNUVzVld2eDBGY25LRHNSbTVoL0FUTDJrRTkwMFh4NS9tbUs4M3BGWjNu?=
 =?utf-8?B?Z3o4MmVsR2Rtdm1sbUx5MWVIQS9NNDZwSjU4YW9udEZCbHJJbTVzWVZBVGhV?=
 =?utf-8?B?RlBsaUhZZjFaT0ZRdWlmRTdaY3VpVkN6SVhIN2U3ZjdoNVB1b1YyREd4RStJ?=
 =?utf-8?B?N1QzdDJxVXNlbS85Q1c3UW8rV0tJMVp2cit2dHJSUStlcVlUVTZpZXZTMFRU?=
 =?utf-8?B?MmovczZjOXQySWhTZ3dtNmxKTzNQcGJWd3ZsTTk2bitlNG4xMVhNT0RxdUlu?=
 =?utf-8?B?cURidFNFMDdadG9yNUFQelBBV1JNM1pNVlorelJDK0VjQzdYOWx2UHlzNXpi?=
 =?utf-8?B?MmRDMWZha2NpRjhUYXlCSE15NkVoT1R0TG5jV21oWHRYUTF6T0ZUS0pNazNO?=
 =?utf-8?B?S3laVitEYUlqdTN3M3ZoYjRrU20rZUZPbmp3UFRZMDc2U1hOazZPT0FObWJZ?=
 =?utf-8?B?bFpXMGNPUlRzT2Fha2E5RWlpWXlnZUczYnpHbjlibUlEVTJnb0tKd29XMkNj?=
 =?utf-8?B?NnhLbU9vTC9IQkFCZFhYU0VxMHpPdis5RDF0WGY1V2pLMDJwWEk5NUloVjlD?=
 =?utf-8?B?TU9yN2JSKytlUm1La0xUNU5UMk5HVlMyaUxBdEZxMkRRVFgrOUpXRmgwYW43?=
 =?utf-8?B?TUUvTnE0UkVnUm5UWDRIb1hBeXU2VnJmY012QzZzOExtbmZwR3VVVi9mMlZR?=
 =?utf-8?Q?Vr6H4WFr+3i7aHWbsI1teQOgFyvL57oc60bAH8a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmRxdzNjNnlKYWkwTHBEemErVVRpaURUWEhFaDQvVHVoQklmcVRPMU92OUVU?=
 =?utf-8?B?dFFxYXoyMFhhS2dyUmFHREYwWkxCdVoza21YK0JTSHFHOHBZdExTRTFYdnR1?=
 =?utf-8?B?L0tSOTc2MWs0aFc4SjFzd1hFUWY5OURkTjhFcGhaa0pQaHAvelQyemw4UVo0?=
 =?utf-8?B?UDZhWHc5V3lWVmo1RGpRaGhmczA2NVhXeWphWnd1eEFHTGRmOGFZcWU2ejVm?=
 =?utf-8?B?bzF4OVFIZkZpNUhkaUtpSG9ZOXJYZmJCNUpOek5TaEEvRWgrdEwzbXJrUVUy?=
 =?utf-8?B?aXBTM2dhbkxDVFpRSnRuRmE0cG9qWXRWeGpkeXFXYXdWa1R4czB6WlJ3WlNz?=
 =?utf-8?B?dlR0dWh6OWZkVXJyKzdaRk5reVJTWVJCMXYxODRXL1BCTSswTGZ2amhhL1B2?=
 =?utf-8?B?RmU1S2tnSHBLR1RBTTdFbUI2TVhtRjJtOEdQTUo5OGFmc1dQVEVMYUZhME9Y?=
 =?utf-8?B?c29wM0tUbmVVVE9USkkxQjg4RXNWd0psM1F5REROYVlUbGViV1drd0VhTHpN?=
 =?utf-8?B?MGtCWGRZRDR4N2tVOTByL3lOMU5qakJyenNZWTZxYU9UUUdhYWh2c2tKOVFo?=
 =?utf-8?B?dkxLalVHNUJQQkwzR1ZrY0h4NEdJWjRZWEVGWWNHM3FSOGhMd0xDQ1JUR05q?=
 =?utf-8?B?WlF4bnFDVlpyR0ZndzVkME5sUDdjV0JjUlJUTnNBcXFINmEvWSt3dkZYV0JF?=
 =?utf-8?B?bGZVOXdtQXo5STZkNjV0djJjekZXdXJHYXFVeXUxN3QvSmFPYWNSYkdVcnda?=
 =?utf-8?B?Slp4UVlneFR3V3I2cmU3aTJrNWNUZ3htbmtMMWFOcENtQW1yZEhxYXNmU05u?=
 =?utf-8?B?SUN0YXlwR3l6dTBmcGV4NHBnL0V1bnJhTXJJelMvaElyNmdYOHcvc3B3SzFJ?=
 =?utf-8?B?MlVhaGx5NnNqcy9oWUZsWURhQTd4Y0FIOEs1RDk4ZWtkNzVtY09GRk91REJi?=
 =?utf-8?B?SE1YSm8ySFZNZU02QStVZHp0bldTWE4vaFhjT3E0cWNsNzVyRTdUTFluOG0w?=
 =?utf-8?B?Zlg1UUxHMEhBMDM2ZFJqTk5VQWpRaTZkK0ZsYlAwdWg5TE4wbXdEQWI3Tmds?=
 =?utf-8?B?NC9hancrQWtaUUhVN2ZkeW1SU2dXcVN5bnBqSTlWeFZVTmNHZnpsZUFhUy84?=
 =?utf-8?B?bG41bzhTWXRnU1A4cUdNK3l3M2E3Z2R5Z29EUmZpemhWRm5QWFpZUTVxV1NB?=
 =?utf-8?B?Nk9BaUdrQ0V1UW83SXNUY2NCSnhJR2x6eVgySytrRXBoMkpyaWZKMXlIYWRa?=
 =?utf-8?B?c3hIMm1MRnlFcU5kUXI4V3h3QThyZ3hGeC9wMkFIdFVTT2ltamN5am82TVBB?=
 =?utf-8?B?TlAwa1NESlM2MEt2MitEcFdHeGZiS1NIOXpRc05GWkxqK0JrTmc4alZsdEhQ?=
 =?utf-8?B?SHlEd3R4N0NMU2FWSVZ5Qmh5d3JYVW5ubHNkT3gvU0x4eFFTcUlSSW4xa044?=
 =?utf-8?B?WXdzWVVuQ1djZ1Yra0JLWHg1bEVLVDFWVFplZjBDZE5tdVo3U2lqenI0OUNI?=
 =?utf-8?B?cHdia3NpUFc1ZHdDcmZDTnBKcG1Vak1WMFI5UFlKd1ptNWRnOGM5UmJnZUN4?=
 =?utf-8?B?ckxjOEpJTlBnY0VaaDZxTnpwbCtTQjBiK0g1WGd3ZXdPb3RUYXRwazFsbXhx?=
 =?utf-8?B?M1lSRVVob2E1NWdOeHFFR0ZpR1JMYnpLMnA3TGNzYVk4MDhUcTlRUmQvVkRt?=
 =?utf-8?B?WkZROUwrQitienhwRW9JSVptUHNZWnFsb1liTHdlSitCdFpkdS90TWVYd0JF?=
 =?utf-8?B?b0ZjNmZmRERHb0VkWWtMc3B4RzF3ODBKOGtQQWoxendBeVFKMlJZNWtYWW5i?=
 =?utf-8?B?cTM3bTBNMVNJSm9SRlpxOWRFeVcyKzhHMllnS3FwVW40Wk9XZkJjWExaamsz?=
 =?utf-8?B?YXR6M1hrNXA5V0prdG9JUkNQWDJaalA3YTVGZFdlOEkwWE53TldxUjFvSWFv?=
 =?utf-8?B?Z0ZyUjlFMDNBSXlaVEl6bjhCeThGM3hYWXc4T3NBcFg1N2VMMDl3Y2tRYTk5?=
 =?utf-8?B?R0VWNmtZOUp4U25FTk5ya3RETWFIS2VVbFhYZmp3VTZkVDE3KytYVDV2RUJK?=
 =?utf-8?B?bzJwdWczMFRGMDdpRGNQN2NWR2U2VjRoMWlmUzV3dVE3SHZDdDR2eTFsYlBP?=
 =?utf-8?Q?MIFm9projmBV7b8FT1ioofgH3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf14652-e9e6-4cc7-29b4-08dd03ee9d79
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:22:33.8235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmUXQi5Lol0v+VrQC/XKXBmdI0avvrXiOiOUkE+wzIFC9mLmlEd5Y+QeNu6cKrzQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986
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

Am 13.11.24 um 14:53 schrieb Li, Yunxiang (Teddy):
> [Public]
>
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, November 13, 2024 6:39
>> Am 13.11.24 um 11:25 schrieb Tvrtko Ursulin:
>>> On 13/11/2024 08:49, Christian König wrote:
>>>> Am 12.11.24 um 19:16 schrieb Li, Yunxiang (Teddy):
>>>>> [SNIP]
>>>>>>> +   size = sign * amdgpu_bo_size(bo);
>>>>>>> +   res = bo->tbo.resource;
>>>>>>> +   type = res ? res->mem_type :
>>>>>>> amdgpu_bo_get_preferred_placement(bo);
>>>>>> Again, it's a clear NAK from my side to do stuff like that.
>>>>>>
>>>>>> When there isn't any backing store the BO should *not* be accounted
>>>>>> to anything.
>>>>> I don't have a preference either way, but I think it should be a
>>>>> separate discussion to properly define what drm-total- means.
>>> Total must show the total size of all BOs which exist even if they
>>> don't currently have a backing store. That's how drm-usage-stats.rst
>>> defines the field and that is how all the other drivers work.
>> In that case we should only look at the preferred placement and not the backing
>> store at all.
>>
>> But that makes the total identical to the requested value, doesn't it?
> Yes, the issue is not which BO needs to be counted but where they should be counted. This gets more complicated if we consider BOs to prefer multiple placements.
>
> IMO it makes sense to have drm-total- to work like the legacy amd-requested- where we look at BO's preferred placement. For multiple preferred placements we say that the implementation needs to pick one of them to avoid double counting, but which one is up to the implementation as long as it's done in a consistent manner. Does that sound reasonable?

Yeah that works for me. Just don't look at both bo->preferred_placement 
and bo->tbo.resource because that will certainly be inconsistent in some 
use cases.

>
>>>>>>> +   type = res ? res->mem_type :
>>>>>>> amdgpu_bo_get_preferred_placement(bo);
>>>>>>> +   shared =
>>>>>>> drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>>>>>>> +
>>>>>>> +   if (type >= __AMDGPU_PL_LAST)
>>>>>>> +           return;
>>>>>>> +
>>>>>>> +   spin_lock(&vm->status_lock);
>>>>>>> +
>>>>>>> +   if (shared)
>>>>>>> +           vm->stats[type].drm.shared += size;
>>>>>>> +   else
>>>>>>> +           vm->stats[type].drm.private += size;
>>>>>>> +   if (res)
>>>>>>> +           vm->stats[type].drm.resident += size;
>>>>>>> +   if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>>>>>>> +           vm->stats[type].drm.purgeable += size;
>>>>>>> +
>>>>>>> +   if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
>>>>>>> +           vm->stats[TTM_PL_VRAM].requested += size;
>>>>>>> +           if (type != TTM_PL_VRAM)
>>>>>>> +                   vm->stats[TTM_PL_VRAM].evicted += size;
>>>>>> Again that is incorrect. BOs can be created with VRAM|GTT as their
>>>>>> placement.
>>>>>>
>>>>>> If such a BO is placed into GTT that doesn't mean it is evicted.
>>>>> In that case, do we count BO with VRAM|GTT in both VRAM and GTT's
>>>>> .requested field? and if they are not in either, they go in both
>>>>> .evicted field?
>>>> Oh, good question depends on the definition of the requested field.
>>>>
>>>> Accounting it to VRAM.evicted while GTT placement is desirable as
>>>> well is certainly not correct.
>>>>
>>>>   From my understanding they should go into the VRAM request, but not
>>>> account to evicted. But Tvrtko might see that differently.
>>> Semantics of requested and evicted are kind of amdgpu 'legacy' thing.
>>> So the question is whether or not they should keep matching.
>>> Originally they were like this (I will edit out parts which deal with
>>> CPU visible for ease of comparison, and which have since been removed
>>> anyway):
>>>
>>>         if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
>>>                 stats->requested_vram += size;
>>>                 if (res->mem_type != TTM_PL_VRAM)
>>>                          stats->evicted_vram += size;
>>>          } else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
>>>                 stats->requested_gtt += size;
>>>          }
>>>
>>> So the part about accounting as evicted with dual preferred placement
>>> was there from the start.
>>>
>>> Then after my changes:
>>>
>>>          if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
>>>                  stats[TTM_PL_VRAM].requested += size;
>>>                  if (type != TTM_PL_VRAM) {
>>>                          stats[TTM_PL_VRAM].evicted += size;
>>>                  }
>>>          } else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
>>>                  stats[TTM_PL_TT].requested += size;
>>>          }
>>>
>>> I mostly kept the same semantics.
>>>
>>> Teddy's version keeps it the same:
>>>
>>>      if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
>>>          vm->stats[TTM_PL_VRAM].requested += size;
>>>          if (type != TTM_PL_VRAM)
>>>              vm->stats[TTM_PL_VRAM].evicted += size;
>>>      } else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
>>>          vm->stats[TTM_PL_TT].requested += size;
>>>      }
>>>
>>> If no AMD tools depend on the legacy semantics for evicted/requested
>>> we can change them. There is some overlap with the standard keys
>>> anyway and the fact preferred mask is unordered made the original
>>> behaviour a bit presumptuous to begin with. In summary I think it
>>> depends on whether we need to keep the legacy semantics, or even the
>>> keys themselves.
>> As far as I know we don't have any dependency on the amdgpu specific keys.
>>
>> But I need to double check what drm-usage-stats.rst actually defines.
>> Maybe that doesn't really match what we have in amdgpu and other TTM drivers as
>> information.
>>
>> Thanks,
>> Christian.
> If we go with the above definition for drm-total-, I can change the amd-requested- fields to just mirror drm-total-, and have amd-evicted-vram check "preferred_domains & amdgpu_mem_type_to_domain(memtype) == 0", that should cover it?

Yeah that should work, especially "preferred_domains & 
amdgpu_mem_type_to_domain(memtype) == 0" looks like a really good idea 
to me since that is generic.

Regards,
Christian.


>
> Teddy
>
>>>
>>> Regards,
>>>
>>> Tvrtko
>>>
>>>>>>> @@ -2612,7 +2707,6 @@ void amdgpu_vm_fini(struct amdgpu_device
>>>>>>> *adev, struct amdgpu_vm *vm)
>>>>>>>
>>>>>>>       root = amdgpu_bo_ref(vm->root.bo);
>>>>>>>       amdgpu_bo_reserve(root, true);
>>>>>>> -   amdgpu_vm_put_task_info(vm->task_info);
>>>>>>>       amdgpu_vm_set_pasid(adev, vm, 0);
>>>>>>>       dma_fence_wait(vm->last_unlocked, false);
>>>>>>>       dma_fence_put(vm->last_unlocked); @@ -2660,6 +2754,15 @@ void
>>>>>>> amdgpu_vm_fini(struct amdgpu_device *adev,
>>>>>> struct amdgpu_vm *vm)
>>>>>>>               }
>>>>>>>       }
>>>>>>>
>>>>>>> +   if (!amdgpu_vm_stats_is_zero(vm)) {
>>>>>>> +           struct amdgpu_task_info *ti = vm->task_info;
>>>>>>> +
>>>>>>> +           dev_warn(adev->dev,
>>>>>>> +                    "VM memory stats for proc %s(%d) task %s(%d)
>>>>>>> is non-zero
>>>>>> when fini\n",
>>>>>>> + ti->process_name, ti->pid, ti->task_name, ti->tgid);
>>>>>>> +   }
>>>>>>> +
>>>>>>> +   amdgpu_vm_put_task_info(vm->task_info);
>>>>>> Please don't move the call to amdgpu_vm_put_task_info().
>>>>> Is keeping the task_info alive a hazard here? I could copy out the
>>>>> info, it just seemed a bit wasteful.
>>>> Ah, now I see why you have moved that.
>>>>
>>>> IIRC we need to free up the task info before releasing the PASID, but
>>>> that info might be outdated. Need to check the code.
>>>>
>>>> Does it work if you move the message further up or does the root PD
>>>> then break your neck because it isn't released yet?
>>>>
>>>> Thanks,
>>>> Christian.
>>>>
>>>>> Regards,
>>>>> Teddy

