Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB37C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 17:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4A86117A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 17:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4A86117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C276E103;
	Tue, 13 Jul 2021 17:35:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF74B6E103
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 17:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWGzlb1pY7S5Fn+5xwY5rOpxEf3TzjGfELBxQjGT9mb3nJcidUUDqUbUObTvEni2oH/Nt6Zr2BWQbjr2NmEqMuVyQ5YTfGtzOCsXqtAgmdHTBEB7J1YGs6wRz6LanTuIx7Exw35N+89+VsZbtB5iY4Xq6SW6+P8iXwR1MkkVSYbR3lv7S/RxRDyhEgH6p/K+nSdjzLlku9HpNcDx7B++aW5a8bCTTYCrs+k1xMC3Qdg++ycW/F5UdqxkfTiJcbxOUHNSAVYEL5tr499InZ9+WcVvdGxNIPokIkBH/nH8e6Ar+qylzjLsLxNWAzEOxvR+zl7qNvqc3iYbuLyaqn+avg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHIPbqUt7prcDjm3FKAYo0kwfjSpUa/Yb1QMu2k54Nc=;
 b=TPkQdl8PwE2h/8YtAkZgi3c6daekaw60klGFXCWiyjjHoy4xMqA5hhO9oXKXtb39cMYI5mHG5m6W3qq4EkOApJW5XJ0Z6X0Sva2/c4x0hTzVqbVxNGAZMVxhNX66j+4RVCfGouVbcE2fWhw3+h8qGRzgsDPk5+kt7X1C8wr7XwUhG0SBAftawKBhVytXZcsVIPGym47xXUM5BpcBJF52GXqH2lb8ZvkVCxaOqnJEqujSHHWKdoOslSE5+8RAkGrqJCjExeDVsi1U5ExGYEmuFBJCLmuE3U/jhJYWouXeilzGdjE8bW+PRY/HyDDvAX2eEczw3ndqsuj/JihVrgLpaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHIPbqUt7prcDjm3FKAYo0kwfjSpUa/Yb1QMu2k54Nc=;
 b=Eh9MpJQv+o88qHSHyjGGfoRd3VujQ7Hv1wmanBzx/wqwk6GkAelJVpEsCJjZXvLn2sru8E7q3jvZ3rZULPLnGc9cq4cIg/lUdW5C4mPc6gYCjWW+eUVONRGkIEx5h1VZL/1CelkIFSUGA8Yt8MOw460LFnxj4ghWr00QJNnHS5o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Tue, 13 Jul
 2021 17:35:34 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257%4]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 17:35:34 +0000
Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210712153051.4029-1-luben.tuikov@amd.com>
 <DM6PR12MB2619B19E2BBB61DA3B9DAFE8E4149@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <bc0a3dff-890b-16d6-2897-1a459f87cde9@amd.com>
Date: Tue, 13 Jul 2021 13:35:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <DM6PR12MB2619B19E2BBB61DA3B9DAFE8E4149@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 13 Jul 2021 17:35:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af839311-3452-42ae-0720-08d946249e3e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33691789067D32B731371F2A99149@DM6PR12MB3369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71O9m9hUFctp0DLoJpyvh9EtQleWV5x64ImXqFHXwwzSi6YtNSO2/WyUuYGEBQ3z3ID069UbXZysozAh/nI9r3X13VgJpNWcC6K4k634g43Efcv05hIdLt2jxinCE6uW7hUb2GLjw7D6B0m5SiuP0J9yYuIesOp0F4mxQHMcvQg8UfQhzp96gsxdQsOK0LvsKXuMNJ2pX1gYcSZwYrvTPKwtkxr/p+Qgl56H0oTMEt+R9USZAi7PUGfpp2XYMuEmBcr6Yrq3ElRDR50bBv23rxgt8Muf1t8gSO7U57HbUx2hsV8I+Kyy/sbEUL2NRvimluFTi26Im+jRQsRwynNKz4t6uEqAahr+58VvvO1GxvfXXn22a4griPXrDXJSfbWnfCbdMTkqgawupz2IugQlA3TTUoye9hhjeVJLJ1Z+Ta8Wg7v8PXlpi/2n526uykBssfwVoeVPu4e86wY7S8/P2t9Zax1gZ/BIYPYrLn5EYcI9/4Zsi2s+gscx6yYsKSNoVheG0R6COhUbQ6EyF1lzlqJxLDHRnl0/BHtRociePbH8oMKmMnlMZ1PfXGB7a8WfrVlNkR+OwXayZDKSeIvSQub0YwC/YKiu53uItiGkuieApo+w8MdYwrWxGpM0Y6+EZsZUNZSWEE0akqbA3mgsbjDYFavsUMv+4Ry2liU5kPAtZNv++QNsMs5fsDFCHUvGyAd5y697N7NObEPzpWTKguiix8WKWcF/fA3LriGWKQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(30864003)(478600001)(6512007)(83380400001)(186003)(31696002)(86362001)(36756003)(53546011)(31686004)(55236004)(4326008)(26005)(38100700002)(8936002)(6506007)(8676002)(110136005)(5660300002)(2616005)(44832011)(66476007)(316002)(66556008)(66946007)(6486002)(956004)(54906003)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enZBVTllZ3JZRTJZd0RpOFR0ekVIN2p2aWJsWlQxbFNBWml4ZGhabFhMSWtS?=
 =?utf-8?B?eDNIdUZsVlJmSkg3WENuNzJsUzNITjhLazRCSTJYZ1RaTkZIUlNrNCtyNGlD?=
 =?utf-8?B?aFRmMkJGUUdDS0JETVpxQUhUOUNrWE9yTzFVeW5IOWx2YzJRdkd5RDAxdkJD?=
 =?utf-8?B?bXpPeUVMaFkxNDZwak9zYXNXaG9UMzZ4RU14UXVZWVNBVEttRHFRWGc2azFz?=
 =?utf-8?B?em14a0ExdDYzVVVnS2RDak9qc0lLbys0UFVRMGRUYmFPL29kS0dxeDBVazkv?=
 =?utf-8?B?dUdkSGdJVzNmaDk2Yml5YTJwQ2xHNEVDMG5EWTNqWjgybjJPL1JNendOL0Fy?=
 =?utf-8?B?OS9MTU9oQlV3T1pyYkQyaXhneHQ5aFR0VHY3aUdQVU45QVlOQlZHME9aY3U4?=
 =?utf-8?B?OVYrZW9RbGwvRjF6N3FrYkpJNTd6dC9qTWRvelFnZk9zRVBURVVHbnpPWS9T?=
 =?utf-8?B?Zlh5WEQ5ZHdZU2swMWpRZDM0NlhIZWJQWEtIYmJPMWxNOEJIcS9PUVE5UXd0?=
 =?utf-8?B?dnpOakQyb3FQNW1GN3VTbVlKTHFjN0lhTkg1Z1Z0dTlMMTFKSm1rSE5hQ3hn?=
 =?utf-8?B?b3BuSEh4Q3NWZk4rN3dkR3l2LzRZWVdqUERRem1wT2JVZ2dzZWpoc2JVWU9B?=
 =?utf-8?B?Um9VY1dlZWkzTmFQZ2xLT1hlc21SeTNTUHZQYnUxS3pCb0lUdUtnRFJ5Y0NP?=
 =?utf-8?B?UDhTTU9pRFFQWmtYZU1kamEvRG9YSUxXSFFmV1ZJWUFMRFBkWUt1RUpCSGZD?=
 =?utf-8?B?N3pHNjZobnF4dEFmOXpsQ3FGQkwxQUN1VzZvYUlobVlnMGNGdUhXME1LZjB3?=
 =?utf-8?B?dS84aU9CM0lkVmFaSUtXOGNIZVFkN1o2cm5OV1Rjc0FZK1VEcUVueGg3ZE5Z?=
 =?utf-8?B?Z05FOVJKT1VwemNrckgvbWRObVIxbCtOQWpnQWJNSFp3WFFmdmtYUENrQTlY?=
 =?utf-8?B?OXlHQjlYajViYyt2a2VlN0NMYzY5SUxnbWUydjloUVZTb2p2QWpnMjN5Rjdi?=
 =?utf-8?B?UTFCQ1Qyc3hTU2gzVFRtMGJRL0ZjUnVxdXhDNFJSN0s4ZkkxZ3dQSkJYSFpw?=
 =?utf-8?B?aGNFM0RlQ2xLZG9JcUhyVDlBR0owVmJTZTdqaGJvR0tJemUrdFkzaDBDQkhN?=
 =?utf-8?B?eDVxVG1PTHB5SnJMNmJPUFBEVmRmc0R6ZnBublhMZStVaWJ6eHhFK3kwNTVE?=
 =?utf-8?B?bkQzdE9qRFNuVVY0ZnJGUWZoRjI0Q2ZJOTRiZ1V2c3FoSkRkdGpla3lUdjkv?=
 =?utf-8?B?cVF0eWVKYTRZQWtVeFJtcUREK1p2eDMrTjRGa0YwV0JURmkzYVpZQU4wU3R3?=
 =?utf-8?B?aW8xdmpYbHpjc242R0xCYXpnNlU0U002bDZ3UC9wSzBYcUk5azkxRTZ6eWJY?=
 =?utf-8?B?NmhHZU9HSjRNOXN2d1hHOHZTUzM2VFhndTRyRFlrWGQ0Sko1VjNkSG14M3Jy?=
 =?utf-8?B?THk4cTFLelgxVkwwQ2hQSFh2MUVFSWkzdE5tRm1JRUlvRTVrZmpEMmxTNzA2?=
 =?utf-8?B?Q0VjRWROK0NMRWM3akFvK3NvaExCV0ZEK2hWOGpHTTI4Q3dUYUwwTHhKVzZm?=
 =?utf-8?B?WlFOR0h0VWVzM3JJMWdjMHdVT1JyNWtrTGJFNTQ1bUhGVU5rVFY1ZDRTdElC?=
 =?utf-8?B?K2hEdU84eFRDb0xtcHpWQnFEOUJGWVRVLzhyQXBNcWxZQmtkb1E5MDFCR0Yx?=
 =?utf-8?B?eHdBZDRWU3pUejR6SHp1bjluVXF5RkczcVhnQmtMbFhnYjhhbmhqWnIwMFEy?=
 =?utf-8?Q?iMi1jGQPDM3GAMun1YWjdM4TdzOhmKH/it+YSpH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af839311-3452-42ae-0720-08d946249e3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 17:35:33.8977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8I9KjGO6bS+2WDTam2UoWaRIPAIW+HedNAqBA1Ni69bzMFmZerp88JQ/yUnZgdqT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3369
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, aaron.baluja@amd.com,
 "Alimucaj, Andi" <Anduil.Alimucaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-07-13 3:07 a.m., Quan, Evan wrote:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>> Sent: Monday, July 12, 2021 11:31 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
>> Subject: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
>>
>> This fixes a bug which if we probe a non-existing
>> I2C device, and the SMU returns 0xFF, 
> [Quan, Evan] Do we have to probe I2C device via issuing commands to SMU and check existence via SMU response?

Yes, yes we do.

> Is there other more friendly way?

No, there isn't.

> >from then on
>> we can never communicate with the SMU, because the
>> code before this patch reads and interprets 0xFF
>> as a terminal error, and thus we never write 0
>> into register 90 to clear the status (and
>> subsequently send a new command to the SMU.)
>>
>> It is not an error that the SMU returns status
>> 0xFF. This means that the SMU executed the last
>> command successfully (execution status), but the
>> command result is an error of some sort (execution
>> result), depending on what the command was.
>>
>> When doing a status check of the SMU, before we
>> send a new command, the only status which
>> precludes us from sending a new command is 0--the
>> SMU hasn't finished executing a previous command,
>> and 0xFC--the SMU is busy.
>>
>> This bug was seen as the following line in the
>> kernel log,
>>
>> amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right
>> state!
> [Quan, Evan] This was designed to prevent failure scenario from ruin.
> Via this, we can prevent those SMU command/response related registers overwritten. 
> Then PMFW team can known which command invoked the first error.

Sorry, this is not correct.

The interface cannot block valid access to the SMU firmware, just because a command executed successfully,
but with a failed result, i.e. set a clock frequency to such-and-such frequency was executed successfully by the SMU,
but the frequency wasn't able to be set as required--the SMU IS NOT BLOCKED, but can execute more commands.

If the PMFW team wants to know which command invoked "the first error", they can check this explicitly,
they can call smu_cmn_wait_for_response(), just like the reset code does--see the reset code.

The way commit fcb1fe9c9e0031 modified the code, it blocks access to the SMU for various other users
of the SMU, not least of which is the I2C.

Regards,
Luben

>
> BR
> Evan
>> when subsequent SMU commands, not necessarily
>> related to I2C, were sent to the SMU.
>>
>> This patch fixes this bug.
>>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Cc: Evan Quan <evan.quan@amd.com>
>> Fixes: fcb1fe9c9e0031 ("drm/amd/powerplay: pre-check the SMU state
>> before issuing message")
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 196
>> +++++++++++++++++++------
>>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
>>  2 files changed, 152 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> index c902fdf322c1be..775eb50a2e49a6 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> @@ -55,7 +55,7 @@
>>
>>  #undef __SMU_DUMMY_MAP
>>  #define __SMU_DUMMY_MAP(type)	#type
>> -static const char* __smu_message_names[] = {
>> +static const char * const __smu_message_names[] = {
>>  	SMU_MESSAGE_TYPES
>>  };
>>
>> @@ -76,46 +76,161 @@ static void smu_cmn_read_arg(struct smu_context
>> *smu,
>>  	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
>>  }
>>
>> -int smu_cmn_wait_for_response(struct smu_context *smu)
>> +/**
>> + * __smu_cmn_poll_stat -- poll for a status from the SMU
>> + * smu: a pointer to SMU context
>> + *
>> + * Returns the status of the SMU, which could be,
>> + * 0, the SMU is busy with your previous command;
>> + * 1,    execution status: success, execution result: success;
>> + * 0xFF, execution status: success, execution result: failure;
>> + * 0xFE, unknown command;
>> + * 0xFD, valid command, but bad (command) prerequisites;
>> + * 0xFC, the command was rejected as the SMU is busy;
>> + * 0xFB, "SMC_Result_DebugDataDumpEnd".
>> + */
>> +static u32 __smu_cmn_poll_stat(struct smu_context *smu)
>>  {
>>  	struct amdgpu_device *adev = smu->adev;
>> -	uint32_t cur_value, i, timeout = adev->usec_timeout * 20;
>> +	int timeout = adev->usec_timeout * 20;
>> +	u32 reg;
>>
>> -	for (i = 0; i < timeout; i++) {
>> -		cur_value = RREG32_SOC15(MP1, 0,
>> mmMP1_SMN_C2PMSG_90);
>> -		if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>> -			return cur_value;
>> +	for ( ; timeout > 0; timeout--) {
>> +		reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>> +		if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>> +			break;
>>
>>  		udelay(1);
>>  	}
>>
>> -	/* timeout means wrong logic */
>> -	if (i == timeout)
>> -		return -ETIME;
>> -
>> -	return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>> +	return reg;
>>  }
>>
>> -int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>> -				     uint16_t msg, uint32_t param)
>> +static void __smu_cmn_reg_print_error(struct smu_context *smu,
>> +				      u32 reg_c2pmsg_90,
>> +				      int msg_index,
>> +				      u32 param,
>> +				      enum smu_message_type msg)
>>  {
>>  	struct amdgpu_device *adev = smu->adev;
>> -	int ret;
>> +	const char *message = smu_get_message_name(smu, msg);
>>
>> -	ret = smu_cmn_wait_for_response(smu);
>> -	if (ret != 0x1) {
>> -		dev_err(adev->dev, "Msg issuing pre-check failed(0x%x) and
>> "
>> -		       "SMU may be not in the right state!\n", ret);
>> -		if (ret != -ETIME)
>> -			ret = -EIO;
>> -		return ret;
>> +	switch (reg_c2pmsg_90) {
>> +	case 0:
>> +		dev_err_ratelimited(adev->dev,
>> +				    "SMU: I'm not done with your previous
>> command!");
>> +		break;
>> +	case 1:
>> +		/* The SMU executed the command. It completed with a
>> +		 * successful result.
>> +		 */
>> +		break;
>> +	case 0xFF:
>> +		/* The SMU executed the command. It completed with a
>> +		 * unsuccessful result.
>> +		 */
>> +		break;
>> +	case 0xFE:
>> +		dev_err_ratelimited(adev->dev,
>> +				    "SMU: unknown command: index:%d
>> param:0x%08X message:%s",
>> +				    msg_index, param, message);
>> +		break;
>> +	case 0xFD:
>> +		dev_err_ratelimited(adev->dev,
>> +				    "SMU: valid command, bad prerequisites:
>> index:%d param:0x%08X message:%s",
>> +				    msg_index, param, message);
>> +		break;
>> +	case 0xFC:
>> +		dev_err_ratelimited(adev->dev,
>> +				    "SMU: I'm very busy for your command:
>> index:%d param:0x%08X message:%s",
>> +				    msg_index, param, message);
>> +		break;
>> +	case 0xFB:
>> +		dev_err_ratelimited(adev->dev,
>> +				    "SMU: I'm debugging!");
>> +		break;
>> +	default:
>> +		dev_err_ratelimited(adev->dev,
>> +				    "SMU: response:0x%08X for index:%d
>> param:0x%08X message:%s?",
>> +				    reg_c2pmsg_90, msg_index, param,
>> message);
>> +		break;
>> +	}
>> +}
>> +
>> +static int __smu_cmn_reg2errno(struct smu_context *smu, u32
>> reg_c2pmsg_90)
>> +{
>> +	int res;
>> +
>> +	switch (reg_c2pmsg_90) {
>> +	case 0:
>> +		res = -ETIME;
>> +		break;
>> +	case 1:
>> +		res = 0;
>> +		break;
>> +	case 0xFF:
>> +		res = -EIO;
>> +		break;
>> +	case 0xFE:
>> +		res = -EOPNOTSUPP;
>> +		break;
>> +	case 0xFD:
>> +		res = -EIO;
>> +		break;
>> +	case 0xFC:
>> +		res = -EBUSY;
>> +		break;
>> +	case 0xFB:
>> +		res = -EIO;
>> +		break;
>> +	default:
>> +		res = -EIO;
>> +		break;
>>  	}
>>
>> +	return res;
>> +}
>> +
>> +static void __smu_cmn_send_msg(struct smu_context *smu,
>> +			       u16 msg,
>> +			       u32 param)
>> +{
>> +	struct amdgpu_device *adev = smu->adev;
>> +
>>  	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
>>  	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
>>  	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
>> +}
>>
>> -	return 0;
>> +int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>> +				     uint16_t msg_index,
>> +				     uint32_t param)
>> +{
>> +	u32 reg;
>> +	int res;
>> +
>> +	if (smu->adev->in_pci_err_recovery)
>> +		return 0;
>> +
>> +	mutex_lock(&smu->message_lock);
>> +	reg = __smu_cmn_poll_stat(smu);
>> +	if (reg == 0 || reg == 0xFC) {
>> +		res = __smu_cmn_reg2errno(smu, reg);
>> +		goto Out;
>> +	}
>> +	__smu_cmn_send_msg(smu, msg_index, param);
>> +	res = 0;
>> +Out:
>> +	mutex_unlock(&smu->message_lock);
>> +	return res;
>> +}
>> +
>> +int smu_cmn_wait_for_response(struct smu_context *smu)
>> +{
>> +	u32 reg;
>> +
>> +	reg = __smu_cmn_poll_stat(smu);
>> +	return __smu_cmn_reg2errno(smu, reg);
>>  }
>>
>>  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>> @@ -123,8 +238,8 @@ int smu_cmn_send_smc_msg_with_param(struct
>> smu_context *smu,
>>  				    uint32_t param,
>>  				    uint32_t *read_arg)
>>  {
>> -	struct amdgpu_device *adev = smu->adev;
>> -	int ret = 0, index = 0;
>> +	int res, index;
>> +	u32 reg;
>>
>>  	if (smu->adev->in_pci_err_recovery)
>>  		return 0;
>> @@ -136,31 +251,20 @@ int smu_cmn_send_smc_msg_with_param(struct
>> smu_context *smu,
>>  		return index == -EACCES ? 0 : index;
>>
>>  	mutex_lock(&smu->message_lock);
>> -	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
>> param);
>> -	if (ret)
>> -		goto out;
>> -
>> -	ret = smu_cmn_wait_for_response(smu);
>> -	if (ret != 0x1) {
>> -		if (ret == -ETIME) {
>> -			dev_err(adev->dev, "message: %15s (%d) \tparam:
>> 0x%08x is timeout (no response)\n",
>> -				smu_get_message_name(smu, msg), index,
>> param);
>> -		} else {
>> -			dev_err(adev->dev, "failed send message: %15s (%d)
>> \tparam: 0x%08x response %#x\n",
>> -				smu_get_message_name(smu, msg), index,
>> param,
>> -				ret);
>> -			ret = -EIO;
>> -		}
>> -		goto out;
>> +	reg = __smu_cmn_poll_stat(smu);
>> +	if (reg == 0 || reg == 0xFC) {
>> +		res = __smu_cmn_reg2errno(smu, reg);
>> +		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>> +		goto Out;
>>  	}
>> -
>> +	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>> +	reg = __smu_cmn_poll_stat(smu);
>> +	res = __smu_cmn_reg2errno(smu, reg);
>>  	if (read_arg)
>>  		smu_cmn_read_arg(smu, read_arg);
>> -
>> -	ret = 0; /* 0 as driver return value */
>> -out:
>> +Out:
>>  	mutex_unlock(&smu->message_lock);
>> -	return ret;
>> +	return res;
>>  }
>>
>>  int smu_cmn_send_smc_msg(struct smu_context *smu,
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>> index 9add5f16ff562a..16993daa2ae042 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>> @@ -27,7 +27,8 @@
>>
>>  #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)
>> || defined(SWSMU_CODE_LAYER_L4)
>>  int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>> -				     uint16_t msg, uint32_t param);
>> +				     uint16_t msg_index,
>> +				     uint32_t param);
>>  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>>  				    enum smu_message_type msg,
>>  				    uint32_t param,
>> --
>> 2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
