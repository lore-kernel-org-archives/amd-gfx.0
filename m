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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0244AC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 09:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B1960F45
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 09:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81B1960F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E266E5A2;
	Thu, 26 Aug 2021 09:52:48 +0000 (UTC)
X-Greylist: delayed 81013 seconds by postgrey-1.36 at gabe;
 Thu, 26 Aug 2021 09:52:47 UTC
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (unknown
 [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C3AB6E5A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 09:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlYvq7PcD0O3p342Nynl4Z4NDSHkKZs9hIKYGk7VmQwz5+bze6L2aTkNJBUuaCNC5Yv6RsJjQb79BZ3225WUw5dfwYJy5EpZ7qLJQ2oEURaTXIGjXDbiEn0OE29EdGDKRaFAdXrG159916RRoNW8iw+WMLpvN7/ttBaz4RVwSYAddWk++rGr5ZvltA4lO1azzwwR//G72ieJOXeSrXLybnBDyINHro2VTmEeCoohozwSm8Uu3w+aBpWNI3+L0DrIXllhJ3zQhH2fmjhb4uTLm0zQZGLqZF3wbRX8flMT5UBYAnZDj0gSFaYWxJkno2tkAynH1lSzYsqxfbanbJzZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAkLQ8kB7Yr4Vl0NOYGGPHVlAajt6p9AfxytCRjm6nE=;
 b=GKB0Bc5GuBcHvn/nlcFIjXHosqP98FH4Ht+Eq7znShDcfvfsRcupAP7BDW1bykaGTqvq5l0Lzz7aDhAI8DgjjN4rLMxEeMiYXWVrXwV2XXS2ete0tkZJzrdCbSoqVptfXskYk+HYrrOcuZ5jGfcvhQpS3QdfR5G7jHwiCLYr5hm5Eh6hqIhsuWRQ3RFnmiGFuUz2qywswiGBAyWD2LaXKWl5kONqqp90tV1sx7TcXAPRfZSDSDFhfvVL28eNJmdHvolRfXosKLwD45jYBT7J2ruf5pUTKLc+O7ZzgQH7nE1hKETPRKN/6kh1ytU42Md0zsxj5DYN/5wNHUq7wfZHtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAkLQ8kB7Yr4Vl0NOYGGPHVlAajt6p9AfxytCRjm6nE=;
 b=zJsLPoYwkuD5Px7EAV69CWxNExcavVzODwCS40vBNvk2f9tKv8j+JnSgmqLoy7T3i4kdLgAVALLefHJczywIgMHHqA5SiGa1wA+Pyd+8SxllaQuUEKo2pl4TJJli4MmE3wapfTUfgBcDJkhJQRj/eoQn2r3nPkCSXoP+BKoosUc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5199.namprd12.prod.outlook.com (2603:10b6:5:396::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Thu, 26 Aug
 2021 09:52:45 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4457.019; Thu, 26 Aug 2021
 09:52:45 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: detach ring priority from gfx priority
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, satyajit.sahu@amd.com
References: <20210825154233.4882-1-nirmoy.das@amd.com>
 <b2a5e7d5-5fa1-ec27-8244-98a4a1e0a125@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <524d2862-465d-b85c-f4f5-9cc58c6cfc64@amd.com>
Date: Thu, 26 Aug 2021 11:52:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <b2a5e7d5-5fa1-ec27-8244-98a4a1e0a125@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0192.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::36) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f22:2800:79bc:ffe:47ba:625e]
 (2003:c5:8f22:2800:79bc:ffe:47ba:625e) by
 PR0P264CA0192.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.19 via Frontend Transport; Thu, 26 Aug 2021 09:52:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a11801d-90e1-4c5f-d4cb-08d96877413b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5199:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5199707118AB9EF5CA25CFA38BC79@DM4PR12MB5199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WOPj06ke7dVB8zU+O8YRAiw2ABhq/NC/wKeW5/Q6aACoRD/ht5HgMrB1FOvNQ1n4c4jeeF0v6OTUwIcMmbqkIoCZ/thP3AI03P+1p1ZTPyefHOVgGUr/r6piRK3JcVE4K2VHKM2iMMpuhIhqA9ZjZfbMjM50ud9UCv9kyCGge8Iuc3kAvual1sisZhzVh14yvTXqVWtykh6P1XbF0n/oolZSFVYAzUtiDcScyglCwmIiL4Td5JQ4MynkRmZgon5eKwH2+4Sl6hS8R/U40JZ/uUcdwcsR4VDNFUq8uIUzQdZUfTSOOhrZkmZ5z/v5XJUoEPDEVCLQpBzxh1zMUibMyNt9KhTwjgCA9amQwo1qNVfON/hZNhrLq8fYpIWJGAbVP/D5O3FrvFzQ4pvcuxzOquJ4JGX91QlpgmE4qlhD4IF9M7umWnmRvl76+OYMyyaGo6SoW5U7hVShUolulGtOPrJZ+UprKx1HAJ567lQf22E+KW3KOSSHzRQKNxwy3wa9zHHdvmHdm6ApRWMfaLlygRdgwazg43OQXi79Hp3RTzzQwqQPu80UcMGTyZrBJ9xokH3xFuUod08Qaiy/40OoQRitrIO0tuLXRSgW5mwXaxMoUt2gcp3Xl+RygkpuK7jleaChErNuxYKfSp0ihcEE2FuT+mjfDHUH2+lE2i7NC6zQ+urJsxCsEuxGDS4gkXrxVDAjQ9VUNF8wHe6eMsaUYDK3yiDgZcLOjAOa5DRXWqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(38100700002)(36756003)(83380400001)(31686004)(86362001)(31696002)(4326008)(66946007)(66556008)(478600001)(8936002)(2616005)(8676002)(316002)(53546011)(186003)(6666004)(6486002)(2906002)(66476007)(52116002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWZEdzlsaU1PWWM0ejZLcTg3MkxBQWpTdUx5U0R3UWtLeGxvSkQ2UWlZQWpQ?=
 =?utf-8?B?eGJFY2cxREpYcTJpVC84RWoyVC9uWVd2dVBUamhWQUJteE5XWXplMERQUWVo?=
 =?utf-8?B?bUUvaEF0Y1ZjQ2c1WWptdm12aDRvQ0s2eHlveFNSa2puUnFnYldlYm83M1Iz?=
 =?utf-8?B?ZURFNEdTTldGUVAyOHFOMllOTWlqNzc3V0locWRpRVZSMVJ0ektQb0l5RllL?=
 =?utf-8?B?YStqTjMvUGxuMVFJWkJHL3RzUEhjbHl4TTcxenk2QWovTXNOUFVXR21GK0E4?=
 =?utf-8?B?YTRHZzhjdWk1YVplYkl1cGZOdkZmazBLRTF0cE5RNEt2SEpHZ21jR3g0ZVhN?=
 =?utf-8?B?SnA4UGcyUWdyd1dieDgyNENnQlF5QW04WUJuZVhsUGFCMU1nNUJEbzJ3M2RL?=
 =?utf-8?B?UnZvYUhlRkFzMHVWNUZXWkZyd3dqNWt4bmczQlZIb1pESlJCNVhIcXNybmpa?=
 =?utf-8?B?ak5MWm1lNWdqNm9ieVFPM3FXa3A3bytFL3QwVE9ydXVGSDZ5bFRUdXErcWVU?=
 =?utf-8?B?azZjMHhpMjFFdDBYNUd0ajdMUXZkM2FKRGpGODg4RCtPS3FBODBleit4L1Ri?=
 =?utf-8?B?ZDRuQnVyaGMrbzNVckRDTnljeXRJNFNWYloxMEx6MGRWdGVZbDJwaWFYdXhu?=
 =?utf-8?B?QnFXdG1uWHFOVWRnVkFpZDdNQUdYalp2QUxuOWdkN0dYa2R3SGxHVVlPa3lk?=
 =?utf-8?B?MDVYZWpQTzZLTHJUWXhLZXdJcmU4T0pETWZQODA0S0pRZkMzVTQ1RFVKUmJa?=
 =?utf-8?B?ZUpnc1VjZ2xxOTF2dGdwbjZrS2tIdnE0TlVyV21KR0wyd25maUFjODQyQkNR?=
 =?utf-8?B?ZC9DejJ6anZCajVkdVRldWZuMmM1bEE3S1B1Y01FNUlCck5BZXNBbHJnUEt6?=
 =?utf-8?B?WUhJdHZVb2FmSm5CRzJwaU9sb0FYamdjS2JHNGtpSWw4Rk9waVpoaTVORE00?=
 =?utf-8?B?MTBvYm44WGVWT1FMUnl0bGNFbzZuUEJWUlJicGc5UVlLcG5UUXEzcExOMm9Z?=
 =?utf-8?B?NldBVUoxN1JhZy9oa1VOUk9wQWxXTHJRY1dtbGhaeFRPcDJXTFFCOVlwQzBv?=
 =?utf-8?B?NTk0eFFiOUxucUNBWVZqa1ZkV1hwY2J4SmR0a2hSU3NEdmg4QXl0MGYyYzFB?=
 =?utf-8?B?MXpKVDdZbTdWZFM1S0xMY1l1NzRDVC9VZzc2T2hGd1BMdEFLVVIvRGtFZHZz?=
 =?utf-8?B?NzN0MGNvL05Ja2xobzR5S2JHRUhVRjF4ajFFYWNYdXdIamYzTDQ1d1FCcVBZ?=
 =?utf-8?B?aVFGQnI4MlpBZ1FuNWtneEIvOEtRSjlWVW9Tb09GT2hMR3pRTWw0Q3BoaUpi?=
 =?utf-8?B?Z0IyVWtNaU1qRGVKR3hRcXp0dVY0MVN4MFlXbTV4ejRNbHVZOXFmbnRpVkdV?=
 =?utf-8?B?NEF3OGhhQ1RjNVdCcXZGTVZCaEFoVXY4ZWZkRXpCYVZDb0NXK2x6Ymk5ekdq?=
 =?utf-8?B?Zm1iQXJGQ2Ewck9tbDg3ajFHNkc3NXJEOW1LaktXWktCdVdaWi9wNUZLMFN4?=
 =?utf-8?B?dXhCc044S1AvZWdVaytQVTRpUXovdTdOeTBZbTZWWVAvT1UyOVFnZks4Tmx0?=
 =?utf-8?B?Znh1N3hSU3dZUE1iN0tWZ0V2dkhReENHSGJLbGtXQlRUSGl1ejVJa29oaFZ0?=
 =?utf-8?B?UTVVbG9keWp6b1c1Y0pZaDFudmVjdHB3K1BDRW5uakYxQS9tTmRwL1NvMkNq?=
 =?utf-8?B?bXhTVkk2R2VlSXgrWk5RSHhuS0tXZG03T2NTVEkzNkV3d0VLSm5jNXIzNjZY?=
 =?utf-8?B?emFkKzVzclUxaW1FbnZFd3ZLRG5SaldYdVpqT1JQV091emZTc0hqMUV2Um9x?=
 =?utf-8?B?bE5BMmVjallKdDZhMXFHY0ZIaVpiVEFXWnFpbjZicGUxZzJKK2xlaGJzU2V2?=
 =?utf-8?Q?vlKTatIWQkf5z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a11801d-90e1-4c5f-d4cb-08d96877413b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 09:52:45.5906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3pKlk3xlg4jFgHJc0SLM666ITvs6RGCv9pDEsZaMyurwNcXpA4AFpU/eGe8/n4SZxLyX/IX2P9gsx8JssFp4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5199
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


On 8/26/2021 11:27 AM, Lazar, Lijo wrote:
>
>
> On 8/25/2021 9:12 PM, Nirmoy Das wrote:
>> Currently AMDGPU_RING_PRIO_MAX is redefinition of a
>> max gfx hwip priority, this won't work well when we will
>> have a hwip with different set of priorities than gfx.
>> Also, HW ring priorities are different from ring priorities.
>>
>> Create a global enum for ring priority levels which each
>> HWIP can use to define its own priority levels.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 10 ++++++++--
>>   2 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index d43fe2ed8116..937320293029 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -43,9 +43,9 @@
>>   #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
>>     enum gfx_pipe_priority {
>> -    AMDGPU_GFX_PIPE_PRIO_NORMAL = 1,
>> -    AMDGPU_GFX_PIPE_PRIO_HIGH,
>> -    AMDGPU_GFX_PIPE_PRIO_MAX
>> +    AMDGPU_GFX_PIPE_PRIO_NORMAL = AMDGPU_RING_PRIO_1,
>> +    AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2,
>> +    AMDGPU_GFX_PIPE_PRIO_MAX = AMDGPU_RING_PRIO_3
>
> Is this a valid priority level? If not, better avoid it.
>

Yes, it not. I will resend,  Thanks!

> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
>>   };
>>     /* Argument for PPSMC_MSG_GpuChangeState */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index e713d31619fe..85541005c1ad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -36,8 +36,14 @@
>>   #define AMDGPU_MAX_VCE_RINGS        3
>>   #define AMDGPU_MAX_UVD_ENC_RINGS    2
>>   -#define AMDGPU_RING_PRIO_DEFAULT    1
>> -#define AMDGPU_RING_PRIO_MAX        AMDGPU_GFX_PIPE_PRIO_MAX
>> +enum amdgpu_ring_priority_level {
>> +    AMDGPU_RING_PRIO_0,
>> +    AMDGPU_RING_PRIO_1,
>> +    AMDGPU_RING_PRIO_DEFAULT = 1,
>> +    AMDGPU_RING_PRIO_2,
>> +    AMDGPU_RING_PRIO_3,
>> +    AMDGPU_RING_PRIO_MAX
>> +};
>>     /* some special values for the owner field */
>>   #define AMDGPU_FENCE_OWNER_UNDEFINED    ((void *)0ul)
>>
