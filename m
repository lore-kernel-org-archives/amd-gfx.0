Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCAEC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 10:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA1661004
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 10:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2AA1661004
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F9576E252;
	Wed, 20 Oct 2021 10:21:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C5B6E252
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 10:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMIdiEy4FniWeL5cka/A/oD6pP8qTLRR68LplOGyW6/68Kf0ZfXgJ9or9azuqSQp+XBsahRMhwNkvCMrzwe7kG/C3wT1+iynojVjUr0IKczV2YyRnJsIo4z2sbafxWNCUSfTjhKckOTY6m9tqHZ2Zfzky50AwwnJ9t0pIhu0VPs1fhbQOWfSMDw0dwQIIKA/mXWnsFGIdeMW40Ltf3XmVnD6ITzxaYkWFSMoVsC03HHqp6tBdpc1iG805Ulut8A6MAdYD27KNhEJ8r9SKPRK4hve7OKgoTlLWb1WsyugGj/9eki2jyOylZ2gDIbBGhkjaabhWfy7q4Q/5wYvRqGA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgKqyAPcIl7gyPlYzkrpj+08wlwAkyXRm6o7IeRJFPI=;
 b=C2vZnP0IXVs85f5PR0QJvmdQmvKwbuHBL5olHsHF+5s4QewMMVscpf+4fWNonGzxJtw2EoHbSI47KAWktda85T6hBngctx7QsTi7oogS81oHWUmk0P03wZ5Wq8tq2/Nt/RqN3CSfBvvnT9oVAIIezmECvpwWqSYXJhomJSCMPxL1B4wYkLAyT9RuTMl2NVeCtxFRb5neOQq9nVVsYQlmsRgSp4el7bzacx8Ftx7TGISWFldnDnY1AtKgfudGmvsc1a3Z/CbdRBPfaEpCqVye3s7OyCRS42zfs3tRuHCWNUm6B+YxjzvHD9RB6AqWxmkdAIbBHrA+PhVNxiXLlVBCbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgKqyAPcIl7gyPlYzkrpj+08wlwAkyXRm6o7IeRJFPI=;
 b=TIJP6v4I44XFfulvzYtrguPam2LMfCjNe/Ne2Il6GjXasDvQJ8sDiy/UAd3VvvXf3j0mWcE/WIq5nsFtP7cFcdBZGcGQjLuLrsZX7h45dtbzxvDiIiyZP/G68g90TWGG9C66ovP7Ps7Hig5T5R9SF8/xCIOxZhZ9vTzM432vaDo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (13.101.57.247) by
 DM4PR12MB5357.namprd12.prod.outlook.com (13.101.60.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16; Wed, 20 Oct 2021 10:21:07 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 10:21:07 +0000
Message-ID: <cf382da5-a831-241f-4a4e-90c4a2cff2fb@amd.com>
Date: Wed, 20 Oct 2021 12:21:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] drm/amdgpu: recover gart table at resume
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, andrey.grodzovsky@amd.com
References: <20211019181449.12356-1-nirmoy.das@amd.com>
 <20211019181449.12356-3-nirmoy.das@amd.com>
 <10ad459a-01c3-1fa0-837d-42dfe33129d2@amd.com>
 <2715b2e9-4f7e-a356-fbdf-48006985a252@amd.com>
 <4897383c-b931-3bf5-e3c3-04ee9e3467ca@amd.com>
 <968c352a-29db-49c0-0f79-763596785be7@amd.com>
 <039e062b-19b5-bd36-55af-43dd437f60c0@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <039e062b-19b5-bd36-55af-43dd437f60c0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P191CA0065.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::42) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (217.86.117.49) by
 AM6P191CA0065.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18 via Frontend Transport; Wed, 20 Oct 2021 10:21:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8450e962-ab19-47bc-a2d2-08d993b35414
X-MS-TrafficTypeDiagnostic: DM4PR12MB5357:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5357142701519081F381FD4D8BBE9@DM4PR12MB5357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a5dTxtBrp7bQ7wLoGwlKgzilXwU5t9JBcHL6xqS1xw7X6szbG/tltVIFSJOdGunOA1VrsWAgtsDQLFo/0aB5OtqotyMo8J/sDsvaOlkZ0Ns70H6foqwFncxTNulI9xfDolq6tm4cLBc0V0DC6f0f8fy9rT9k33hdDsvvB20nL/fLYkxKpv/U0+MQo/T2y2JbkslH8ymaCNMXWE3G+ACjaPz3R5pPJFJkCM8ufE6WzOxcZTKlBQZHKNmRcRmJYGUN28F0U8vhS0ZA3Ssa82ofMJwTTfSFLbhH6mEM6yaT1gM1yuaawva39DdaIeXg6sKdR1KL8wv4PXtE50HXAxWx85eDmDygtPeG92o386FRHCZ8PhMneadmPKXo6u7CjX7zbeWwo7099qq7A/YSKVOSytWve1VAI3LfxrmwIBarjlS3UMbtzc+u4Csl4BEWtYYQSNLJxxZhF0neXxcKhRBJe0AVHP7O3jXj/j99ASv+qzo3tQAvSoTrbAMz8KDw30sOWyxVn4Jo375lfS3zR1mi0JasdC3Y73nr1KGjJ/B7tkE4N5Iz/S2thx+Q1QnJogHbrhSpL12P19J53YB0MHwcFJyuzkyAykiTspWGlsl9nV6Y/nBfN0H2s7ICfexBQyr4tReSXlsLWJZl2dyMBpyDPg1B+wdIjyfnjZ6xTnL/8d90hIo+w0DLi5uU/Y1p1qz1rG+zaeNn8u6SmVSNh4lOLlncapPd140PuELOA+cfZA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(5660300002)(2906002)(6486002)(86362001)(508600001)(66476007)(4326008)(2616005)(26005)(956004)(83380400001)(66556008)(66946007)(6666004)(38100700002)(16576012)(8936002)(36756003)(53546011)(316002)(31686004)(186003)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TURLTXY5c3lCK0drc1gwaG81U0lqcTB0Y3RKTk1pRFpZSkRmb2liQVBCNSs5?=
 =?utf-8?B?aTdRbjJKM3FNWGhwZWZaVnNoYnNhZHhBNFpCSkxPeFR1YUc3Z1JFTTQ4eTIr?=
 =?utf-8?B?dmZxNWw0MkY2d1JSbFllbnlvZWoyZjRtQ3NkWkhYOXdlTm9uaUt4U25yNEgw?=
 =?utf-8?B?OGU0cFRqTHBpQnBjeWgybW1oVnNSejh2V004eDFUbys0aURiTnNoemI2T05a?=
 =?utf-8?B?Mmh3dG8yYVhjcXZTaU10aGxtczdzOUVrQ1pRLzQwZnVNOFZjaHdaSkJUQnhG?=
 =?utf-8?B?NU5Wa2JwUHNDWnM2MzhSZGlSRms3SWJVUmtCUGRJUkt0ZHFNdlBxdVVOKzdV?=
 =?utf-8?B?eFdTa1pKS0o2dytWK0JZNFBRb3RVVjVDNHFLQXdJZ0c5MXhCUklXQmhzd3dX?=
 =?utf-8?B?VDEwZkZ0VHEyNGxrRC80UHU2L21Va3pNV0tGdU8zV1dBRWZ4MFU5N2QwUjVJ?=
 =?utf-8?B?Ri9uUHVld1h0TlRUallnMHRuekUvVzliQkZrVmJNZDUwTE5mcEFwOXFUVlAx?=
 =?utf-8?B?dEVPaVBydUlpT3V2cE42Z083bU1lUTZSUGJQYU4xTHVidjJDQXY5blQrZFVw?=
 =?utf-8?B?TnNIL1ZMc3RiaEt2NCtCNURFQ0ZueWhmV2x3SGZkWFAzZXVSNS9BMktUaFE5?=
 =?utf-8?B?dElMNG1ZK1NCZlBneThhTUpjYUgvMm04UG5QemVKZmJQbkd2SUZveU5CQmRy?=
 =?utf-8?B?NkpYbkN0emQ2ZlhSNU5IUk9MNWtQRk1TaDRXb2FhZEFKa0R1cEM5Q1BYYkJq?=
 =?utf-8?B?MFJxWDR0Qk1OUUpyVkhUaUVoWkdsYTBNR2IzQ29ua24zanJteHN2ZHJ0QlVr?=
 =?utf-8?B?VXVFZGlqKzRzZHNwOFVzdjNBNlVRSC96YXRtMWF0N01vUm91NzYyWTg2M0E3?=
 =?utf-8?B?SERXZFBoV1ZOSUxveDExR3hjNXN2VTE1RU9qVzZNaHZrSDdFVFBueDdhNGFp?=
 =?utf-8?B?dnIzVkI5SHNCUGszbVRnaHlKcHZ3S1U1OGlrYURMdmdtaEp5cUloMnpHNU5W?=
 =?utf-8?B?YkdpSDJ3VC8zRnRBeWhrakxrWUJCTDZFa2YyZDhtVC9seFlFZHUzd2V6Y2Qz?=
 =?utf-8?B?dVBEV1FNVUpvTGY4RkIyZCtSMy9tMGNyeEo3OXY2ZVBaeWs0Y3h1V29tRzh1?=
 =?utf-8?B?c0I1SHNpSHovNThxYWVoY0dSeEkzYzZ2K3hQSG1Hd0tJaEFiNzU5MlVpRlk1?=
 =?utf-8?B?U2ttVjBhQ21IS2Rzam1WeGFxSHUvZkpyaVZxbElRK2RWbElLUndzcjJDNWtK?=
 =?utf-8?B?bWxObitycDJ3ZWVaTWRNdFJnTkFPaUhhUFBLbDgrY2xtWWxNT0ozeVdlTVZQ?=
 =?utf-8?B?Y1g1eFE3TjF6N0VWNHpTdjVjUUkrQXVZaVhqbXREZVhsVlBOSnhjaUZ1Nkgr?=
 =?utf-8?B?Q0xDVm0rY1I0eWZIRTlNRWp5UEtxcWdiNjdDbHBnV3RoSjJsZkt2MkZiOGhx?=
 =?utf-8?B?ODZWUWtoczN0NkJGQzgwMmVaMERKeGdqbXFKZmlCcFk5dlo2OHBlMktFMWND?=
 =?utf-8?B?SEJsWVNyNkNVQktqQlMvM1R5dGtWMklBWDZpN05EM2ZYMzh6Z3ZSbHMweitH?=
 =?utf-8?B?WFFOQ2w5WDR4b0J4MHEyZHlPZzR6V0M5TWJJVXBQVjBxRTBvUTVHYTVwVVhu?=
 =?utf-8?B?Z09Ea0pqVlp4cERaTmRBSXJudzR2Y2pPMWpNVFN1SldxdzBrL0RaeUx3bkQ5?=
 =?utf-8?B?VWgwQlAydHlBcDZSZFMyQ21pQzdqMlRCZ0VYQXM2NXUyVXpxNGtNaGR6clZy?=
 =?utf-8?B?ZG1IYkFWaWxrRDlBc2Jzd0IxUzl6czhGcnJuU0oxN1Jpd0dzdFY0QjBXYkJV?=
 =?utf-8?B?N25DeFR5cS9lMHRZK3gxcXFwaHk1UGU2SjBxWFU1c2M3NCtFMVQzSmF2WE50?=
 =?utf-8?B?M0JyWmNDOHVvSHhxYlhZWmgrMU5ZSjFWSUUwQUdJa0hubzAyQWRkdGZ4R1g5?=
 =?utf-8?B?Y2JudjRZcWxRc2JFckN1WUl1YVlFQTQrUE94MGI3TWZpYUIwL3pHd0U4cERN?=
 =?utf-8?B?Q2t2MHlDSzYwb25rOHJiSkdpRkx1ZlFaYnNJcFZJaGNCZDJuMWcxL0RmNmQ3?=
 =?utf-8?B?a0IzL0EzV0JTWFVNOXdwaVFJbG9OdXpUQlhZSGNrK3IzSFRIc0ZobU00NkRh?=
 =?utf-8?B?VHdLaC9nZGJqL0laQmpSaGxUODR1eWdlM3hEemJIQXhYNit6RGpib3BIOUVk?=
 =?utf-8?Q?aa1KlJPZBRg8uqB2Oar85Ss=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8450e962-ab19-47bc-a2d2-08d993b35414
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:21:07.0893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hPeDa1qhgZ80xVfMZcD0AS/3tN5aNrBDl3Cpnys2ko/KyCWm1rQG/exRmxwkQ35Z1+0QAJE+mSMqHPABTgKxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
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


On 10/20/2021 12:15 PM, Lazar, Lijo wrote:
>
>
> On 10/20/2021 3:42 PM, Das, Nirmoy wrote:
>>
>> On 10/20/2021 12:03 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 10/20/2021 3:23 PM, Das, Nirmoy wrote:
>>>>
>>>> On 10/20/2021 11:11 AM, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>> On 10/19/2021 11:44 PM, Nirmoy Das wrote:
>>>>>> Get rid off pin/unpin of gart BO at resume/suspend and
>>>>>> instead pin only once and try to recover gart content
>>>>>> at resume time. This is much more stable in case there
>>>>>> is OOM situation at 2nd call to amdgpu_device_evict_resources()
>>>>>> while evicting GART table.
>>>>>>
>>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 42 
>>>>>> ++++++++++++----------
>>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  9 ++---
>>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 10 +++---
>>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 10 +++---
>>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  9 ++---
>>>>>>   6 files changed, 45 insertions(+), 39 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 5807df52031c..f69e613805db 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -3941,10 +3941,6 @@ int amdgpu_device_suspend(struct 
>>>>>> drm_device *dev, bool fbcon)
>>>>>>       amdgpu_fence_driver_hw_fini(adev);
>>>>>>
>>>>>>       amdgpu_device_ip_suspend_phase2(adev);
>>>>>> -    /* This second call to evict device resources is to evict
>>>>>> -     * the gart page table using the CPU.
>>>>>> -     */
>>>>>> -    amdgpu_device_evict_resources(adev);
>>>>>>
>>>>>>       return 0;
>>>>>>   }
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>>> index d3e4203f6217..97a9f61fa106 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>>> @@ -107,33 +107,37 @@ void amdgpu_gart_dummy_page_fini(struct 
>>>>>> amdgpu_device *adev)
>>>>>>    *
>>>>>>    * @adev: amdgpu_device pointer
>>>>>>    *
>>>>>> - * Allocate video memory for GART page table
>>>>>> + * Allocate and pin video memory for GART page table
>>>>>>    * (pcie r4xx, r5xx+).  These asics require the
>>>>>>    * gart table to be in video memory.
>>>>>>    * Returns 0 for success, error for failure.
>>>>>>    */
>>>>>>   int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
>>>>>>   {
>>>>>> +    struct amdgpu_bo_param bp;
>>>>>>       int r;
>>>>>>
>>>>>> -    if (adev->gart.bo == NULL) {
>>>>>> -        struct amdgpu_bo_param bp;
>>>>>> -
>>>>>> -        memset(&bp, 0, sizeof(bp));
>>>>>> -        bp.size = adev->gart.table_size;
>>>>>> -        bp.byte_align = PAGE_SIZE;
>>>>>> -        bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>>>>>> -        bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>>>>>> -            AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>>>> -        bp.type = ttm_bo_type_kernel;
>>>>>> -        bp.resv = NULL;
>>>>>> -        bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>>>>> -
>>>>>> -        r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
>>>>>> -        if (r) {
>>>>>> -            return r;
>>>>>> -        }
>>>>>> -    }
>>>>>> +    if (adev->gart.bo != NULL)
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    memset(&bp, 0, sizeof(bp));
>>>>>> +    bp.size = adev->gart.table_size;
>>>>>> +    bp.byte_align = PAGE_SIZE;
>>>>>> +    bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>>>>>> +    bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>>>>>> +        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>>>> +    bp.type = ttm_bo_type_kernel;
>>>>>> +    bp.resv = NULL;
>>>>>> +    bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>>>>> +
>>>>>> +    r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
>>>>>> +    if (r)
>>>>>> +        return r;
>>>>>> +
>>>>>> +    r = amdgpu_gart_table_vram_pin(adev);
>>>>>> +    if (r)
>>>>>> +        return r;
>>>>>> +
>>>>>>       return 0;
>>>>>>   }
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> index 3ec5ff5a6dbe..75d584e1b0e9 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> @@ -992,9 +992,11 @@ static int gmc_v10_0_gart_enable(struct 
>>>>>> amdgpu_device *adev)
>>>>>>           return -EINVAL;
>>>>>>       }
>>>>>>
>>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>>> -    if (r)
>>>>>> -        return r;
>>>>>> +    if (adev->in_suspend) {
>>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>>
>>>>> When the existing usage of this function is checked, this is 
>>>>> called during reset recovery after ip resume phase1. Can't the 
>>>>> same thing be done in ip_resume() to place this after phase1 
>>>>> resume instead of repeating in every IP version?
>>>>
>>>>
>>>> Placing amdgpu_gtt_mgr_recover() after phase1 generally works but 
>>>> gmc_v10_0_gart_enable() seems to be correct place  to do this
>>>>
>>>> gart specific work.
>>>>
>>>
>>> I see. In that case probably the patch needs to change other call 
>>> places also as this step is already taken care in gart enable.
>>
>>
>> Do you mean amdgpu_do_asic_reset() ?
>>
>
> Yes, and saw it called in one more place related to sriov reset 
> (didn't track the sriov reset path though).


True, hmm looks like this patch going to need multiple tested-by tags 
for gfx6,7 and sriov. I only have gfx8,9,10.


Regards,

Nirmoy


>
> Thanks,
> Lijo
>
>>
>> Nirmoy
>>
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>>
>>>> Regards,
>>>>
>>>> Nirmoy
>>>>
>>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> +        if (r)
>>>>>> +            return r;
>>>>>> +    }
>>>>>>
>>>>>>       r = adev->gfxhub.funcs->gart_enable(adev);
>>>>>>       if (r)
>>>>>> @@ -1062,7 +1064,6 @@ static void gmc_v10_0_gart_disable(struct 
>>>>>> amdgpu_device *adev)
>>>>>>   {
>>>>>>       adev->gfxhub.funcs->gart_disable(adev);
>>>>>>       adev->mmhub.funcs->gart_disable(adev);
>>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>>   }
>>>>>>
>>>>>>   static int gmc_v10_0_hw_fini(void *handle)
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>> index 0a50fdaced7e..02e90d9443c1 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>> @@ -620,9 +620,12 @@ static int gmc_v7_0_gart_enable(struct 
>>>>>> amdgpu_device *adev)
>>>>>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>>>           return -EINVAL;
>>>>>>       }
>>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>>> -    if (r)
>>>>>> -        return r;
>>>>>> +
>>>>>> +    if (adev->in_suspend) {
>>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>>> +        if (r)
>>>>>> +            return r;
>>>>>> +    }
>>>>>>
>>>>>>       table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>>>
>>>>>> @@ -758,7 +761,6 @@ static void gmc_v7_0_gart_disable(struct 
>>>>>> amdgpu_device *adev)
>>>>>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>>>>>       WREG32(mmVM_L2_CNTL, tmp);
>>>>>>       WREG32(mmVM_L2_CNTL2, 0);
>>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>>   }
>>>>>>
>>>>>>   /**
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>> index 492ebed2915b..dc2577e37688 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>> @@ -837,9 +837,12 @@ static int gmc_v8_0_gart_enable(struct 
>>>>>> amdgpu_device *adev)
>>>>>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>>>           return -EINVAL;
>>>>>>       }
>>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>>> -    if (r)
>>>>>> -        return r;
>>>>>> +
>>>>>> +    if (adev->in_suspend) {
>>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>>> +        if (r)
>>>>>> +            return r;
>>>>>> +    }
>>>>>>
>>>>>>       table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>>>
>>>>>> @@ -992,7 +995,6 @@ static void gmc_v8_0_gart_disable(struct 
>>>>>> amdgpu_device *adev)
>>>>>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>>>>>       WREG32(mmVM_L2_CNTL, tmp);
>>>>>>       WREG32(mmVM_L2_CNTL2, 0);
>>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>>   }
>>>>>>
>>>>>>   /**
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>> index cb82404df534..732d91dbf449 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>> @@ -1714,9 +1714,11 @@ static int gmc_v9_0_gart_enable(struct 
>>>>>> amdgpu_device *adev)
>>>>>>           return -EINVAL;
>>>>>>       }
>>>>>>
>>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>>> -    if (r)
>>>>>> -        return r;
>>>>>> +    if (adev->in_suspend) {
>>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>>> +        if (r)
>>>>>> +            return r;
>>>>>> +    }
>>>>>>
>>>>>>       r = adev->gfxhub.funcs->gart_enable(adev);
>>>>>>       if (r)
>>>>>> @@ -1793,7 +1795,6 @@ static void gmc_v9_0_gart_disable(struct 
>>>>>> amdgpu_device *adev)
>>>>>>   {
>>>>>>       adev->gfxhub.funcs->gart_disable(adev);
>>>>>>       adev->mmhub.funcs->gart_disable(adev);
>>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>>   }
>>>>>>
>>>>>>   static int gmc_v9_0_hw_fini(void *handle)
>>>>>> -- 
>>>>>> 2.32.0
>>>>>>
