Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBC1C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 11:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447016102A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 11:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 447016102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDCD96E7D7;
	Thu, 26 Aug 2021 11:15:11 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2493D6E7D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 11:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrvEDTUgzHCPbNEs+F8HB+rMY8BRJfkzsYisvwNR+Lqk9Nrh77ELr7Gv7z8VBJ+n38dzzkt6TPhYw4gq+MQs/1sDbVA2gO0Lh2oxeDH7LLJoHBDACLVaE5hMD1x90k4yR9uCfRICh1qWSfGRHC2/2djbVectfriXixkyJXbdc33W5F46A1CSc0M4lA/Zmg0a2gWvvgHEGn77QQo8zTtkdzPTahEsnqBQ8SgSTezqddBJcZE+0MxUbkDxYC+UIlSs2kb2/z7phzP1AVLLEjXXikZH56oyutm7GLuLwxN+T22uRw7fJ8zPLuVkO2HzNzAhMK6vuz/wJaKU9nCbGNkA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojnIm6cQohWFNUXf6/ttnCQgfiPzUjcQWW4u0lnh8sw=;
 b=DocPRix0KU+mAHR8MNFRo/la0+F0WZavJ7CiKEv9WCscZZmesSTVZgki2rKV6F4vP6T6W+9u6Jsz9IzBTXsnBOkeVMs9J4yJw2TnfzOHBkEj73AsSrOJ/Y7MPwvGDR+xJ7f28VVy1WF+zUAX8nGhtsSfXMNhetnrUQGILyldJr39SUGLFtxWuYRBzz7ok8rpsCShcWpapSQbw7OqRc8ezSun9LF9sI3kaMA5kswO7XdyNLWmueGYXxjyH+10cb+9jR6UUgyCtAyKIf00TQOFk9AlQov/E5SGBwoAsz5EnzmzSkBfEmFNA3wV50xy+tfQ5tq6AbvEh8rSFno/P86uSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojnIm6cQohWFNUXf6/ttnCQgfiPzUjcQWW4u0lnh8sw=;
 b=u2SBez/8zkH3tc0Xsmr+8tgm+oFWwVyWwI54zUhXKeE1u7RynZLrKxTzmzwsogF0ns0yEXLNAwQtn5hlz/DglsBSqcAu81+V5krfrpj80ku9iUHPuJ7S94G2IbZfmm1t9Juvaw1+d/KJQpKeOMk5nYBo/MoQKAeTFlwPQMJtv+w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Thu, 26 Aug
 2021 11:15:02 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Thu, 26 Aug 2021
 11:15:01 +0000
Subject: Re: [PATCH v2 1/1] drm/amdgpu: detach ring priority from gfx priority
To: "Das, Nirmoy" <nirmoy.das@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: satyajit.sahu@amd.com
References: <20210826100824.38041-1-nirmoy.das@amd.com>
 <0f3102bc-b5a4-b892-82a3-0e16f0bdcae6@amd.com>
 <45ccb8ab-f0fc-8807-28db-f2937eb509d1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <ea2fb2ab-b9b9-8edb-18f9-bed2f2a1a118@amd.com>
Date: Thu, 26 Aug 2021 16:44:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <45ccb8ab-f0fc-8807-28db-f2937eb509d1@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::32) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0117.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:27::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Thu, 26 Aug 2021 11:14:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4e4b622-0a46-4ecd-0c7f-08d96882bf83
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5320F6D5397B806B03859FCB97C79@BL1PR12MB5320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DDrKcTWb5ZUJi9Xs+qqvUZIdHxaO1GUA7JeMHiHIo0I59hVXuNZWyIkvpLRD67bRuN5YFvX9c6qmuzQLdkK1kuhR7/ojg2HqMxLjwZwc8el2jldi2mT8Xstlym77OSv7TLkpfWhR5KCRJ2Zd1rDJ2qFGtp80vLWOwY5t2G0P3jDR1S8QvRLlqcX73c0jGcxX04xqWE0vqZxcXLgzo0uf/m0D5ozVYvpIiXLVJ9y8uNL2qHMg2a8TyH9YnK6KPX32tk3zpVthiTM4h71KzMMp6zRCnL1VIuFADrBoihTbngLJ8a3XSSgGM4jhded24woOmQmsHLGUQY3i/g/HiEMyf+x1hihFbhbMvo21evDf7qo2e2GWSDyoVdaa5e+lb1q2na19zCdcd3GP+XTQSzVHerHAIRK+7F+rnqprTU3VfyRQqDKYpIKa1xEWOaOFp4q3WdP95f2EEtHe30C0Hr91mk6hGkMkRyafaWw9Xowy9P3KqJseRv2t6BTussycYRTNc7jCKuo1DCFUhhq/seRuSK2MslzVO5UzmSgJYHGK1SEbCSifv+b7l5fUuQwWafFU9FueqKNE8A88m2eD2f3GjVVOfxkVV8UfDRfoXy2JaaBs5/xnihPTb3EU1VtaImo/Jlpr3ic7zduq7ZCwzTcjOLvkghbUAW6JRpIX1+JNlk0hkGcE1Xf9m9fM9SpeoOPsSZQUt5h0IJZiwgWuxxSkdB6S2wyKjSaegMjvS4/rLNo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(31686004)(6666004)(38100700002)(316002)(4326008)(110136005)(16576012)(478600001)(2616005)(66556008)(66476007)(66946007)(956004)(186003)(36756003)(83380400001)(8936002)(5660300002)(26005)(53546011)(6486002)(31696002)(8676002)(66574015)(86362001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elJBVjFEYU1OQll4TTEweU42bUNMWmdGNzYrdC92NGxEYUpLZldPOUZ3Q1U0?=
 =?utf-8?B?S1lWR3BTS1V1L2RxNkNQYUttZzEzZ2dLOWRJMENyRUpmT2RKMG5VWW8vdXdy?=
 =?utf-8?B?Rzh2OEJoa0hqREVvZWk3KzMydm5ab00zOWtaNGlSOStkUUZON216MFNSRzJS?=
 =?utf-8?B?Y1RBeXU2TWgrRndPYjcxaFNUUUROMG56aWdyWUtJei93aFVlVWpoQ3RySWo3?=
 =?utf-8?B?RHBDZHM5NSt2UDhHYklSYy9BZFFMdFpMcjIyUXJUdFpBNGkrUVNQWlFhYW1C?=
 =?utf-8?B?MDFFK3NPWWRrdUR2TE95OVVOaVpJOXJESFBicHJ2czh5ZDNVcFFXMVkzMUxx?=
 =?utf-8?B?OWR1bU4xODFxVGloWCt2OHFabDhncVFwUnpNR2w2TVgya1U1Y0pJRU42bThZ?=
 =?utf-8?B?enlVOE9ETVpBa2pGbTFzQXZQeTliRnlQVkZmczl4bzBObUR1V01JODNnaUsr?=
 =?utf-8?B?QzdHdmNkbEtWaHljdnphY3luZFJDRUlZcVpMbUVaOHp0OHFLa2tuTTRFblRZ?=
 =?utf-8?B?TEplYXFiRGJLRkRJRWxmeG8wdU9PRlVIVVQ5QnNWUTRhbHZsRTB4MFp3bmZh?=
 =?utf-8?B?Y05PUHZFR01jMVNYR2JKMXl4Nm5zeGhGalppMDZ5T2lhY3JQdFNGSUNWb0cx?=
 =?utf-8?B?R1psK3RhNU5CM0dkQ0UvVWdZK2lRWFNoODA5Y2ZQSGFzU2k3ZGV6UkNibnVj?=
 =?utf-8?B?azFzb0hEL05lQVd4T2c3UkVuTHo3UDNuZ3grZlZmL1k0YWY1R3pMR3JpRTBR?=
 =?utf-8?B?Y2Yra2ExcTQvazd5OER6WWovV0d4K0JPRmVZV2ZTOERucXBvSHJhaWU3QlJY?=
 =?utf-8?B?dmVrZXFoNjBiRVVWZzVSOXRpNmtRcjcvcWl4RzVBUGc3OGVPZUhNRllCdm1o?=
 =?utf-8?B?U3RvREl4aFUrcFJGUVAwb1RxelJQNXpRRmJLRkxqT1JoSU1PUlY0RnRCTUpv?=
 =?utf-8?B?Zlp6ZUdqT0tkSVlhLytpRk8waGVZeFVKMW1TaWdjOEl5V2lNRG1lR0dqZGwx?=
 =?utf-8?B?ejJxcXRTNzR3dlRNT0tndC95MXQ5T0VvYlExQnZhUmZGbEpjcStMU085OU9h?=
 =?utf-8?B?R01SYXVlRzRqaEduTUVRN1BoVzR0cDVFM3hMSWw0R05PT1dKbWJKcDZiYm92?=
 =?utf-8?B?eUZ3bmx6WFNCYlpaL1R6dHk3RXVoRSsvTlZvOWNEcm1ibm82aGFJeU9LeW1B?=
 =?utf-8?B?OVRDRVNzOWFWWVAzQWczNVFLTTlsWTZVRllWUEQ4enNRM05maERCZEpzK3Jk?=
 =?utf-8?B?dkZOeldJcVR0ZnllTUhONHlzMlhBaVVGOE5VRXVFUE9LM1YxNjF2eWNRUWhs?=
 =?utf-8?B?UUIyVkFlUVRnN3FVMlV4emxlMDJ6c1BqcG0yRjBGNzg3cHM5U3ovWmdacVZw?=
 =?utf-8?B?ZlJla3lwbjczZzlnZUVWMGNGeDlnZzVacXlDemt2eXdvK0l6YW1oTldMSVZY?=
 =?utf-8?B?cmhGT1ZLeE5rWWdlRmJyRnVseHh4SWpLQzMrU3V2dy95VHFLN2l0cFJNZ1hs?=
 =?utf-8?B?M21ocmY4QjN4YVQ4VHYxWjdwVmNHdjQ1WEVyQUlsVFZOZXA4Nnk2YWc1aXhx?=
 =?utf-8?B?NEZ4cStxU3FFRVY1amxqeVgrL3cwTkNUM0pGK05adU1SU3VVNkkvbmdTbnNQ?=
 =?utf-8?B?ZjZ3TWJkbmszRG8xMlBPbjA1eG9HR1hXak95cDdDZm8yUk1IWlBQTnpOcFIx?=
 =?utf-8?B?OWVrOW9OZWx2dFo1eFRkZHJpRGhnRHFkelJJS1V1eWNpYTBpaUtGNG5nMk5z?=
 =?utf-8?Q?4RMV3DF/LNyx3YqMHNrN5xLspJG0vVpy3C9t/oF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e4b622-0a46-4ecd-0c7f-08d96882bf83
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 11:15:01.8964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOC6eKBtotTr09RNSEGF12MtJdvlf3CUHZx85VH1KiAcZvZbO7tK92AUzHNwtKNQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
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



On 8/26/2021 4:21 PM, Das, Nirmoy wrote:
> 
> On 8/26/2021 12:48 PM, Christian König wrote:
>>
>>
>> Am 26.08.21 um 12:08 schrieb Nirmoy Das:
>>> Currently AMDGPU_RING_PRIO_MAX is redefinition of a
>>> max gfx hwip priority, this won't work well when we will
>>> have a hwip with different set of priorities than gfx.
>>> Also, HW ring priorities are different from ring priorities.
>>>
>>> Create a global enum for ring priority levels which each
>>> HWIP can use to define its own priority levels.
>>>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 5 ++---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 9 +++++++--
>>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> index d43fe2ed8116..7f747a4291f3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> @@ -43,9 +43,8 @@
>>>   #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
>>>
>>>   enum gfx_pipe_priority {
>>
>> While at it can you add an amdgpu_ prefix before the enum name?
>>
>> And if the enum isn't really used maybe even replace the enum with 
>> defines?
> 
> 
> Yes makes sense, I will resend with defines.
> 

Recommend against that so that ctx_to_ip priority returns a typed enum 
for that IP instead of something mapped randomly.

Thanks,
Lijo

>>
>> Thanks,
>> Christian.
>>
>>> -    AMDGPU_GFX_PIPE_PRIO_NORMAL = 1,
>>> -    AMDGPU_GFX_PIPE_PRIO_HIGH,
>>> -    AMDGPU_GFX_PIPE_PRIO_MAX
>>> +    AMDGPU_GFX_PIPE_PRIO_NORMAL = AMDGPU_RING_PRIO_1,
>>> +    AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2
>>>   };
>>>
>>>   /* Argument for PPSMC_MSG_GpuChangeState */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index e713d31619fe..88d80eb3fea1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -36,8 +36,13 @@
>>>   #define AMDGPU_MAX_VCE_RINGS        3
>>>   #define AMDGPU_MAX_UVD_ENC_RINGS    2
>>>
>>> -#define AMDGPU_RING_PRIO_DEFAULT    1
>>> -#define AMDGPU_RING_PRIO_MAX        AMDGPU_GFX_PIPE_PRIO_MAX
>>> +enum amdgpu_ring_priority_level {
>>> +    AMDGPU_RING_PRIO_0,
>>> +    AMDGPU_RING_PRIO_1,
>>> +    AMDGPU_RING_PRIO_DEFAULT = 1,
>>> +    AMDGPU_RING_PRIO_2,
>>> +    AMDGPU_RING_PRIO_MAX
>>> +};
>>>
>>>   /* some special values for the owner field */
>>>   #define AMDGPU_FENCE_OWNER_UNDEFINED    ((void *)0ul)
>>> -- 
>>> 2.32.0
>>>
>>
