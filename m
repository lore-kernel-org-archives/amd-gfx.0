Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324F6C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 15:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE92D10EEC6;
	Thu, 30 Mar 2023 15:21:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F3C10EEC4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 15:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9hLV1d3jxrK9WfcVQEqw157ycZmCzvlDf3kKF6gEHm/xOWpyaE9Z2PoVLu1zgyS/EesTfEMIPxtZBX738bt4GKgC44UFrbVGVRsIP/5P+WHFRbiKaaZ2eEtn6I54fS1ceU1ImRqJoc52fodmNqu17/U8jYsOotnY/EHXoJR2zsFYDM+TfhIozJM4e3g4iicwWICDxc+UZX9EYukMMMXI7VFhD6nM+v/A/cZ9buDhmhpIO1OABIk5WSEwK56F8aPVSpmMQlonZebMHd9U8CZVSJM9IW2nKSfChSV3Iz74EidiwYiVP7agluL1pcslVQTLpLjhoL+W3nzMpvGTSyPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nC35Ly71a6WH/6TYM6rFhgdRH9+CAintfOKxwnFkC8M=;
 b=Y9Qgiciwk/r2KM7fVffCgQESkvcaQMxSOAjvcAsxQlkb0TeOYxzDUicm7vem8dclc9ut9vaVH6NtaI3BRIE4SRsuKnpe8hiTv/F6ObwCymmaZPl3dzhA5iec3krvoQrOQpl4cdlX2hFWiNGhvDMa6rkUkEh0V00DduqO27a0Ov4bhnKyGWzVoLOXRGE3c2gBBW0Fnnpv30u/UvlF1M3pMWx09ZTkzw6883IZQg7XsP47aag+Uq3fXSJWDRobz1vtB//qmzoJXEm1oTXCieUG+lB5mIsu/PEmugRdC98M+Ac+S5l2l9w3AYCOAOdgLPSxR+dK7KfpeSIzv0QjP81foA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC35Ly71a6WH/6TYM6rFhgdRH9+CAintfOKxwnFkC8M=;
 b=iwiEzRMb7YqLMzbJ4kLWrF743vGFc/06u7Bcjxo3xdTXQF69UFEGTlmzgfApCN6BBnfGbs0sgYwH/xEHY38ClbLqYTwYpr5QoyTqIMAIOCs0/i7Coe5sSIkwKeXxKyj95GzksbEXaQ1YvTc/0yOzeO22q5mcVZCLEB7vql5uKvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CO6PR12MB5457.namprd12.prod.outlook.com (2603:10b6:5:355::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 15:21:29 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 15:21:29 +0000
Message-ID: <8dca209b-e508-5e4a-d72f-7090fa99519e@amd.com>
Date: Thu, 30 Mar 2023 17:21:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 07/16] drm/amdgpu: add helper to create doorbell pages
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-8-shashank.sharma@amd.com>
 <d03dba54-9f68-60ef-67ab-0d58245632d6@amd.com>
 <128791c7-2b84-386d-cb65-55cae5f5c835@amd.com>
 <cd1ca61d-c31b-4e91-9fa3-c41f3f8339e4@amd.com>
 <de8de75c-d561-7d53-e042-a1f4f8eef837@amd.com>
 <CADnq5_O_rJYcUXhf+tDaeog2cEZLvDnzz5d=AJ5pTHcWvyrdCA@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_O_rJYcUXhf+tDaeog2cEZLvDnzz5d=AJ5pTHcWvyrdCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::20) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CO6PR12MB5457:EE_
X-MS-Office365-Filtering-Correlation-Id: ea496a50-d4d2-45e8-841a-08db31326f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkw3O/JtHLQdYJl0LLMu2U80zVfzshHu1HlNr7cGvq8MN3S3mB27yAegkvv2gi9sokt8sB0fcKz8h0vyU1hP7ynzAEXlNVr6avhNVJbC+fGabCgcRIZVPlX8ihLDuOiee8L8gm5E20RNe+MMcDZhcjm81Rp055DUVgcfBB530nI7EEDdAghbzq9+1on5ghXd3jSTZQzqoF/unYS77KAF/f57GD704bw5+cYMJRucf7khmtABzXDNiNkPCPCjI8PZG9lxrPN5w3drguIvg0NdkO7fUhbMtpzi2f6wwrbLisiDftOiidPoX5BXezCZz4PgEwU95SyLVQhTR5fEyJXNmxgyRjIMEH8ezStQVw9id/X3ANFp3ggx4vphxymxcSf8Jl4wzu54qK1deGfDRluPmuh+uJLxd8f7qZq10OqaKExahumzX+FB4URlls+w9D9SAkgXp8FpWZtJ2CipMQqr8pjgs/StenLE/67u/jFIxNlvmA3Wp1SnLJnl+Qa0C9pAFwSgRF3geCuALlaXal5Z8c6evT5pqeRpkCTp8djDu4/p69zVmh0KAP5FCtLxvdsz66K5GBrUUCjZH6x3C54aSyMDtQaoYm1xo6hgxEBC2fVm6raEbs8u+D1LuOiacNzVaV9QCdae5Cw2xxM/KIidLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(31686004)(36756003)(4326008)(38100700002)(8936002)(6916009)(44832011)(5660300002)(8676002)(66946007)(86362001)(41300700001)(66556008)(31696002)(66476007)(6486002)(83380400001)(2616005)(53546011)(26005)(6666004)(2906002)(54906003)(6512007)(6506007)(478600001)(316002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHFMZHE2R2M3T0oxWDZGSlEzOFJNY0NDejNqWEhPalFxc083aHhWTEJuYkFL?=
 =?utf-8?B?RnhHcy84SndWdGZCMmo4dzN0MGdWc1p3U2k3T2ZHdzZhSjZCMlNBeHZ3ellV?=
 =?utf-8?B?Z0hQOHdVOHplenNKczFCaHlEdDNtTis4Y2hBbWNFSTcyTzEwSWJReklkdGIx?=
 =?utf-8?B?d0hkclY0OG0rcDFKeG15dWwxU0JJWjh0amxtaFpLdUt6WU9MQ3hzQXliejJB?=
 =?utf-8?B?YUtTeWhNc3ppWEhDRTFMaXMxMDc1WkZXekZEcXgya3poMWErUGdvQWUzRmJC?=
 =?utf-8?B?azNNNEZKRW04WlorWFhvay9weXRmcjNWQ0JFVUZpUmZRR1BTL0orSHF3bWw3?=
 =?utf-8?B?S1VzbkhVOVNWcUptYzBUYnZrRWYyaE1aMFBjeEF0dEFGTkNWUXgxM2xLNnFs?=
 =?utf-8?B?M085TjFrS0lHM2toWnhNN3pWWURwY25aYlhKd1AzUkVkK003L3pRTG12bnNJ?=
 =?utf-8?B?Y1FMQ3p6cW5NR3hWY25xMEJFVWJtZU9pZUlqQjFzYkhaQ2o4b0Mwb05uaWZ3?=
 =?utf-8?B?YWVPODgxN3V6NnVFSHpzVnhLSDYwREYzdi9CRlVnQmJiaWd4SWZpak03RHVM?=
 =?utf-8?B?Si9QbGU5MVMxTDMxbUNaaEEwaXVXS2dCTnk2aFlVNVI2VnE3SzB0NmxqYzRT?=
 =?utf-8?B?OC9MUGVGVVBHWmZtdExUSk1lNE82TFFqbE13ODdVN2dxZHBFQmFIaXdWOU5m?=
 =?utf-8?B?YnF1bWdXNERTNUc5eks5S2EvNlNoWW1HY29KZjZJbDlEOHhOTWNsTEpMTEc4?=
 =?utf-8?B?clVEOTBON1U5YmJEVExaOFN4dnJsa2c4UThvN2wyQ1NvZlpXNVZOTkdTNXJu?=
 =?utf-8?B?OUpaVTcrWEtoK0dsdm56dzBhTUpsVGhSY3hEM3hzZld3NkFhcTQ3ei85TjRB?=
 =?utf-8?B?eDJGaExSYTBCdEFRRHhJN0tJNmlxdVp0L2I1VXI5VzRTQXkvNDltOFh5SXJq?=
 =?utf-8?B?SWkrNFZLZWNmdmZ1ZHExSlJ4cC9sMEZpUWtTWjFDM0Zxb2FmRUpQZXZNZ0p2?=
 =?utf-8?B?N0dQcThPMHpUVy84V0t0TzZaMEluNndiaUZTOUJLQ0hZK0VFd1AxWDVIeXZv?=
 =?utf-8?B?WjFXMEZlVE5ZaEVpZzhrbXRqZEYrZlhaNlMrbDBJajdoQlpndFRQNk55aElE?=
 =?utf-8?B?dERLWkJuRGo1QVBuWVJUK3hHcUNDNEJSWmNoUGphQXpma055NFpsWXRmZU9k?=
 =?utf-8?B?VDNXa3lDTVNDODU5MHpoN0xvQ1VualRCMkw0MGtDTGo5OFNxNnEvbENPZ0p6?=
 =?utf-8?B?OVFyMTBHKytLTTNGTGt6RUlRUFgxWi8vMGd4N1NZMDMrVEpqQ1dJVDZLU3FS?=
 =?utf-8?B?b3dkeGd5ejNtRUxUM1FUMnpRUVBvdEJQcjA4c3NXVHZIQzZzUlVlRW03TkRK?=
 =?utf-8?B?bGJaNXoyRHRKajZMWWFoUXNuMmNvN3VWZTRiayt5RmFKUkQ1T3F4MHc3T2RD?=
 =?utf-8?B?NjRBUGFrTzZVZWRTOXVrTTNjcVpVVEhYMVRYZHIwM29pT2VMUldGUnB0K2Ny?=
 =?utf-8?B?YUFXWE85S1NYNEUvS2NQMUorampXS1JDZklBOVVDT296d3BUM3JUYzBiOXF6?=
 =?utf-8?B?bStFUU8wdERxK2xHNi9jZmdqdzRudlhLTU0vR0RnMGRtbVRoVksrNFpBSlZs?=
 =?utf-8?B?KzIwYkRDWTREQmE4RWR6WW5YVG1ldnk0SWpVODErdTBJdUNWZ2hGSjV2RXpF?=
 =?utf-8?B?V2NWczgzR25CdlhTRFNUSG43YnBaR0g2ZEJ5dHBNTnNoT2kya1FKQ1RmWEMv?=
 =?utf-8?B?RFBKbmwzSnlMZytTNmlnYktBc3YrRUN1MkRJVXRSMEZDeGNpcFRCdWdnRjlo?=
 =?utf-8?B?SVpReGNTZ0d3Z2xWeUViNFBoL0p6bWZpZWthS1puQU5lTUlEYkkrWUR1Wkxt?=
 =?utf-8?B?d3pIckFZZk1FUUtpUjRORjljSXVONlE5UWJTc1RLa2MwcFc3QkdudllJZ1d6?=
 =?utf-8?B?UFNaV2NQdFdDaFQwUkZiY1pEenV1WXl3dnFya0NEZWxIRXp0K050NHhWeCtn?=
 =?utf-8?B?aWU1TEFFbHpTUE56Z09YMW9Fdm9BeXFLNjNlWE5RNXNNL1hjSTVHbnVVSjhX?=
 =?utf-8?B?Y0NIMjdRNHFDSTh5eEtQSkI3T3A3M2wvK3dGNEN6QmNsN0drNGNRMzc4Z3hF?=
 =?utf-8?Q?Jstq5zIwHqwuWutW59gmxBYxT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea496a50-d4d2-45e8-841a-08db31326f93
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 15:21:29.6088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMyzV7gdYhLMA6EiaKK2v2W+APxPuLK/14WyGdehI17isjqeQgi2ZRO+aRLfRNlkoV+ytY6nZfzcgIVjqR6HsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5457
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, Luben Tuikov <luben.tuikov@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 16:55, Alex Deucher wrote:
> On Thu, Mar 30, 2023 at 10:34 AM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>>
>> On 30/03/2023 16:15, Luben Tuikov wrote:
>>> On 2023-03-30 10:04, Shashank Sharma wrote:
>>>> On 30/03/2023 15:42, Luben Tuikov wrote:
>>>>> On 2023-03-29 11:47, Shashank Sharma wrote:
>>>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>>>
>>>>>> This patch adds helper functions to create and free doorbell
>>>>>> pages for kernel objects.
>>>>>>
>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 41 ++++++++++++++++
>>>>>>     .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 49 +++++++++++++++++++
>>>>>>     2 files changed, 90 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>> index f9c3b77bf65d..6581b78fe438 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>> @@ -27,6 +27,24 @@
>>>>>>     /*
>>>>>>      * GPU doorbell structures, functions & helpers
>>>>>>      */
>>>>>> +
>>>>>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
>>>>>> +struct amdgpu_doorbell_obj {
>>>>> In the comment you say "Structure to hold ...";
>>>>> it is a C structure, but then in the name of a function we see "obj".
>>>>> (Object is something which is defined like in memory, i.e. it exists, not
>>>>> something which is only declared.)
>>>>> This is just a declaration of a structure, not an object per se.
>>>>> I'd call it "struct amdgpu_doorbell_struct" or just "struct amdgpu_doorbell".
>>>> It is similar to struct amdgpu buffer object (struct amdgpu_bo), and
>>>> many more existing structure.
>>> The amdpgu_bo is very different than a structure describing a doorbell.
>>> The doorbell description isn't really "an object". I understand
>>> the enthusiasm, but it is really not "an object". It's just a doorbell
>>> description. :-)
>> amdgpu_bo is page of ttm_memory with additional information,
>>
>> amdgpu_doorbell_obj is a page of ttm_doorbells with additional information
>>
>> (it is not just one doorbell description)
>>
>> I don't see a problem here.
> I find the new API confusing.  I would expect to see
> amdgpu_bo_create_kernel(...DOORBELL...), amdgpu_bo_reserve(),
> amdgpu_bo_kmap(), etc.  That makes it consistent with the other
> resource pools that we manage in ttm.

I am assuming here you are talking about why do we need 
amdgpu_doorbell_page_create()/free() API here.

The wrappers here allow us to do additional book keeping work.

For example:

- We need to validate kernel doorbell writes, which means we need the 
range of kernel doorbells.

- There are 3 kernel doorbell pages, for KGD, KFD and MES. These are non 
consecutive pages.

- While we do doorbell_write in kernel, we need to check if this index 
is correct, which means:

kgd_doobrell_min < index < kgd_doorbell_max

kfd_doobrell_min < index < kgd_doorbell_max

mes_doobrell_min < index < kgd_doorbell_max

- which means we need start/end limits set at every object.

- we have to either do this work at each place where we want to call 
amdgpu_bo_create(DOORBELL)

   which means KFD, KGD and MES all places (which will look irrelevant 
in the context)

  or we can do this in one place, which is the doorbell wrapper API.


Please see patch 10 for this range check.


- Shashank


now kfd is setting start/end limits by calling 
amdgpu_get_doorbell_index() function.

>
> Alex
>
>> - Shashank
>>
>>> Regards,
>>> Luben
>>>
>>>> - Shashank
>>>>
>>>>> Then in the definition, you can call it an object/objects, if you'd like,
>>>>> like "struct amdgpu_doorbell *doorb_object[];" then you can say
>>>>> "db = doorb_object[i]";
>>>>>
>>>>> Regards,
>>>>> Luben
>>>>>
>>>>>> +  struct amdgpu_bo *bo;
>>>>>> +  uint64_t gpu_addr;
>>>>>> +  uint32_t *cpu_addr;
>>>>>> +  uint32_t size;
>>>>>> +
>>>>>> +  /* First index in this object */
>>>>>> +  uint32_t start;
>>>>>> +
>>>>>> +  /* Last index in this object */
>>>>>> +  uint32_t end;
>>>>>> +
>>>>>> +  /* bitmap for dynamic doorbell allocation from this object */
>>>>>> +  unsigned long *doorbell_bitmap;
>>>>>> +};
>>>>>> +
>>>>>>     struct amdgpu_doorbell {
>>>>>>             /* doorbell mmio */
>>>>>>             resource_size_t         base;
>>>>>> @@ -328,6 +346,29 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
>>>>>>      */
>>>>>>     void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
>>>>>>
>>>>>> +/**
>>>>>> + * amdgpu_doorbell_free_page - Free a doorbell page
>>>>>> + *
>>>>>> + * @adev: amdgpu_device pointer
>>>>>> + *
>>>>>> + * @db_age: previously allocated doobell page details
>>>>>> + *
>>>>>> + */
>>>>>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>>>>>> +                          struct amdgpu_doorbell_obj *db_obj);
>>>>>> +
>>>>>> +/**
>>>>>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>>>>>> + *
>>>>>> + * @adev: amdgpu_device pointer
>>>>>> + *
>>>>>> + * @db_age: doobell page structure to fill details with
>>>>>> + *
>>>>>> + * returns 0 on success, else error number
>>>>>> + */
>>>>>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>>>> +                          struct amdgpu_doorbell_obj *db_obj);
>>>>>> +
>>>>>>     #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>>>>     #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>>>>>     #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>> index 1aea92363fd3..8be15b82b545 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>> @@ -111,6 +111,55 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>>>>>             }
>>>>>>     }
>>>>>>
>>>>>> +/**
>>>>>> + * amdgpu_doorbell_free_page - Free a doorbell page
>>>>>> + *
>>>>>> + * @adev: amdgpu_device pointer
>>>>>> + *
>>>>>> + * @db_age: previously allocated doobell page details
>>>>>> + *
>>>>>> + */
>>>>>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>>>>>> +                                  struct amdgpu_doorbell_obj *db_obj)
>>>>>> +{
>>>>>> +  amdgpu_bo_free_kernel(&db_obj->bo,
>>>>>> +                        &db_obj->gpu_addr,
>>>>>> +                        (void **)&db_obj->cpu_addr);
>>>>>> +
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>>>>>> + *
>>>>>> + * @adev: amdgpu_device pointer
>>>>>> + *
>>>>>> + * @db_age: doobell page structure to fill details with
>>>>>> + *
>>>>>> + * returns 0 on success, else error number
>>>>>> + */
>>>>>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>>>> +                          struct amdgpu_doorbell_obj *db_obj)
>>>>>> +{
>>>>>> +  int r;
>>>>>> +
>>>>>> +  db_obj->size = ALIGN(db_obj->size, PAGE_SIZE);
>>>>>> +
>>>>>> +  r = amdgpu_bo_create_kernel(adev,
>>>>>> +                              db_obj->size,
>>>>>> +                              PAGE_SIZE,
>>>>>> +                              AMDGPU_GEM_DOMAIN_DOORBELL,
>>>>>> +                              &db_obj->bo,
>>>>>> +                              &db_obj->gpu_addr,
>>>>>> +                              (void **)&db_obj->cpu_addr);
>>>>>> +
>>>>>> +  if (r) {
>>>>>> +          DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
>>>>>> +          return r;
>>>>>> +  }
>>>>>> +
>>>>>> +  return 0;
>>>>>> +}
>>>>>> +
>>>>>>     /*
>>>>>>      * GPU doorbell aperture helpers function.
>>>>>>      */
