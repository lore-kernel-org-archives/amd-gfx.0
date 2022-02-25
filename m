Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680CAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 06:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A774510E2EF;
	Fri, 25 Feb 2022 06:03:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0C210E2EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 06:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAfenfmJk3e6U0rXNG6wVfqeuF/9bKxZNOtrz8VJrRAOjHg4lCl8/D77dkgeGEfZh2rFWPyB1F/6PuJDrVqkRX/TmX3qPMGm816wLVzVGLXyXNyXInNTF+DgMcoIZlxSARA0nfnsfMybaHqQnn6yVhd4p1Al81l3q9gyw3YgJEyWPqtP73QXipbbXCaHTxrlY3mkpTISHsdX20gyHsaPlVWog2+ucY+QFQ93mzpZDd1pMgArmBN48jodzgVmvI4zDo0dBYFjcJmInSCb3mPA7cP0GnuPbQJAgscW7wpc7Wdb/NL3bgSW71uHvjGBCXTse4SGHrg3w3TGZjhpkxNPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuEC40tT7m3ntijV4or35hpshU3EKooPPT9HUaY0Djo=;
 b=G+1M2QuUH+YO90yrZTg9p7NOC38OJGFxrlBRgow1h1c0hkPwqBcmJfM2GqMnRfnK2Lw2BwSz1e4cSQRviiE7e+vAQKjIoPSE3Lku8gyup1uTwbSe0N4WpYzRZhvabRNg8Y4ayptTaUZPgPZkVYO2IpqSYDp5fZzcFclNLjUi0mtG/yRAaCe7jmNAwTX/tK6AjZZtoGGG9Sn9owukDsv8ommKeIrnRM253yle476RFOhfNnJRxhwgKrp+uD/BJiHlcwfObpUxwcwjT8n4Gg/M2Kt5ZGYVYe9qPVh9sR7yqOHzSt6dFsYAqxegf993ppC+nWetbmVkhWcctpMmIr+kUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuEC40tT7m3ntijV4or35hpshU3EKooPPT9HUaY0Djo=;
 b=sgxY7Y7D1jtNBhFygkiUuHzAdTF0XCvx/Uvsd970Yh+O2nZ9vUB2vF1/Q2iruq/FE0PyByaSY5U7ULPhqR+fxtOE+qKr0IDXbFG2oHJYgkg5CcINIdXBhSfIWKTaI/nI72FlRTqpms2haNN583vpLS515UQDMl7uf8AsULJCPiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 25 Feb
 2022 06:03:03 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.5017.022; Fri, 25 Feb 2022
 06:03:03 +0000
Message-ID: <2bb4e178-b224-ff6a-e730-47ab780e44ca@amd.com>
Date: Fri, 25 Feb 2022 11:32:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220225042156.676421-1-lijo.lazar@amd.com>
 <DM6PR12MB2619202956D5AF431734D5C8E43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <BYAPR12MB4614577C233FED50C0EFC80C973E9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <DM6PR12MB26192A826B2B5DF65ED8ED5CE43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB26192A826B2B5DF65ED8ED5CE43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::8) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aed2521d-28fb-441a-b65a-08d9f8247be3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3531:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3531014354FCF2C0736E6302973E9@DM6PR12MB3531.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+59NEtldsTDshJvsurznw7hZzeM/cXNyXM+1ATWTrUEqeFliu34DFawjf7T7Cjb7aZS1hZ//b32ylladYQbMnT96+uqyqO8eX6B7ZYyX92Ac4NazyXsWQwGfh6RFvzzaws+zK4Z2ogDn4+oYN2HTvghsJ7noZUyCfYaE5jhrsXKaKHhdN0XMjAKPjNBYebQUnHP+fN6kZHJwviXPYtIY2XQ5f6FbLaWV9N0JnwO6usbSfwjusp2bBJ08erUxlsX4bjw6s/Wwqxc4faViCfKsYzcL0ZqX3QV9WrlrbJAzZx93YkxyECkTPdoK2PWtcCHSBTBnkngF1cF7c+2GV6GbhCEAIF6ikOsME+MRlzURyzYmuCbIvAB5Uo4qyAAKoeMuoEeJBvq7xyWyWBiDJSE6sqK4uda1Yl4XQ6//dQCp+rV8Pw6tzpDC8tSC+oa5UcVa1e1NKQzsBQA0eOfPMw59tYLSA/Vkvd/UooptO0Xox0QyOfjdViLS4/mzvszFNjYwtqgPQuJsqHkoyp7IBk4S1tsUQfPJz3aGS7kd/DK6jPRBlrHDC+2+an+tVm8z4ufVQoyOk8bGTvzQsHbE68lP4EacQA0B6Ojen9pSjCaT6epJ3rUkM+CJjrUJ2NJvr8WuAtmtkkMYL5OSSHWuej5FDqOb14Lo9CxbZuGldHMU2+tGXIWN2ie9Jarg/SXXPD55FpAsQH3ZfOU3ChOIU7qEBAjZ7SqQpCQ4J4TtCpoJnA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(15650500001)(53546011)(5660300002)(6666004)(110136005)(83380400001)(8936002)(2906002)(54906003)(31686004)(36756003)(6506007)(66556008)(66476007)(86362001)(2616005)(6486002)(508600001)(4326008)(8676002)(316002)(38100700002)(6512007)(26005)(186003)(66946007)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTR6NCtwTUJoQW9tTjk1MUJ3d3RUYjB1YWU4aE5vME5Rc05SWkVYcU5OdXBk?=
 =?utf-8?B?cHV4amZwZGNJWFJORy9FeEs0cEJ6UWdjOHZneVBVa1N5OENRSCtwYXNPQVdN?=
 =?utf-8?B?VHV0UTZGTkpCd2hmWkQ4UWxqT1JxSjc0cXhhSG5mNTFVZklHRVpqbnd0dnJt?=
 =?utf-8?B?K09HSVFtQXJIUHp3djd6YnNZUUMweWJFVVpXTTlXbkowOXVxNUxmSXJ6V1c1?=
 =?utf-8?B?OWZhNi8vcmVVQmp0M0xocjRuSHpIZlQ2cDNra2RZWWt4VEMrMUs5cjF5SU56?=
 =?utf-8?B?cVpOUXNwbHowZVVGZGJkWm1vTjhWd1FuQWNtbUpDc1RFQVBuSWExeUgxUC9P?=
 =?utf-8?B?bW1ySE9HdmZrSW5xTVZvY3pHY2x2aU5nbkUyRXdFTExDQ2VsYWdsaUxoZS82?=
 =?utf-8?B?R1BuYWVza1FwSnpHU2xTL3JxbE5DV3hHemxXTzdOZEZSaXo1anVlcHB3cEd6?=
 =?utf-8?B?MVlPVlFva3JDeGd2L2JyU0hrZ1V0cWNVMHJWaEtUMEREZVJGUHRNWThpTGU2?=
 =?utf-8?B?NHBzS3hoS1dEdjl5cVlZQ3NJVUNQNGFra2RUekV1djV6QnJjL0VlUitjMkda?=
 =?utf-8?B?czMrTVBXVkN5OXo1bVdTNTlaNzcxamlKZWlid1dVSFJmZjVlUk5FcElocU96?=
 =?utf-8?B?dW8rZ0FhZXNtcHdBOTZTTTRIYmJ5N1VLZTltSnpwK3dMWFQ1WGk0NHorNWZj?=
 =?utf-8?B?Vk5OQ0ZRVTZCT2hHbCt1UU5CS3JkUVVpOXVFUVlnSjI1cERSanhCdVVNc2N6?=
 =?utf-8?B?QnFVNCtIZUNYbTZ1WHZUdys3YlB2YTdCWjZPb1YzR2ZXbzBnZHdTM1JVcG5L?=
 =?utf-8?B?SGE4NVI0NTdhNHdUVE1SQllRZlNvMmlBM1dtWU1EcHNlRzBnbWxpMFg0M3M1?=
 =?utf-8?B?OGZlTC9ybGJoV2k0bndaYW42ZXhCMG9yR1d2SlAvOU9QS1B0OUVaTWR1Q2Vt?=
 =?utf-8?B?MWRrdjdKcVltV2ZJQjMrK2w0azJDWEM3UDBXR1ZUUnVXSjcvbWFBZk4vTWlq?=
 =?utf-8?B?V29NdXQ0Nk9tVkNwTU12L0l1a3c5Z0Q4eEhBMU44ZHlaRjNlalR6WEpaRTVN?=
 =?utf-8?B?UEhUSUVQdTRhQzRIZDQyZ2pRNzMvc2h4L3lCSkg2Zm1RNlp2dDV3RE0reVFq?=
 =?utf-8?B?b1k0aG9UYzV4UTQyMllJMjVPQXY1VkorVzFEV05mRlFrMnc3WTZHNHFhY3VZ?=
 =?utf-8?B?UU1qMVpLaGRHUUtpaU1LMmFDcW5IWFE2MUJBVnB3L0V5RzM4TnBUZkd6ajFM?=
 =?utf-8?B?UmpOVXJKMjF5NU1tRUJMQkRHdWROR1NvWFZGMGFEd242WlBTSWlrcyt2dUs4?=
 =?utf-8?B?YUt0bklEN1Q1T1RlY0ZlNmpDMXlOaXByYTNsM2FqZ3B2TEI5WkJMZGJWUFM3?=
 =?utf-8?B?MU5YUVpZU2ZkSjFuNGE0NURPOGRXQUlPT3pCT1NJM0grTlpoY2xidU5FTUlN?=
 =?utf-8?B?QmFvRXFyYnZUbGUycWQ3WkViekVDb0U4RytXNzB2bVR1dnRURW1MdFgwZ09s?=
 =?utf-8?B?dm1ybk5lZjRxMHRRbHhEV3JYbHYvS2h3QlNMbDNGbFhpNFprWS9GcGlOOFdh?=
 =?utf-8?B?TjNmN1piSjNoazY4VTZGZFYwZGl1cTFqdTBLTWVwTkpqTWcxWVl2S3pTdmxu?=
 =?utf-8?B?MTB2cXNBdEJ3dDRHRzZkdVR0emdEUSt3MXQ3MllobWthems1b05RUTI4eXQ4?=
 =?utf-8?B?MU4rck9KUUppWlhueHVpa3E4aG1EM2lReFhWL1hXMmhocVk5dmc2UGJod0VV?=
 =?utf-8?B?bnNDWjNZM0l3c2U1dEd0c0pHSUxpTlJjUUpMa1duR2lWWTR4S2hFV0VjdXVF?=
 =?utf-8?B?QjRnMmdPQzdhR083VHNLMS9nOTRYR2NoSlJLMVNvalBLL0J0clc2amVsczcv?=
 =?utf-8?B?ems5OHJEYW1YM3QrcFc0dFBzYzlHS2xBOENhWG8xaUNTUDJNTTV6bzE2bGFY?=
 =?utf-8?B?enBPcVBxMzhKdjZpOHJLK096R0lnSzI2NzdGTHUvbkNVOFhNYnVLQnBjRTRF?=
 =?utf-8?B?cGxhYWthanQvaU0yUWZMMFZyakpza0pXbGsxeEhqVGVRWE45TzdIRUN6Q0Zi?=
 =?utf-8?B?ejlQSTM1OTZyVHdLcmJpK0szSmMwcnZkTFQwL29HZGcwaThKODYwQnhXUi9N?=
 =?utf-8?Q?dr7g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed2521d-28fb-441a-b65a-08d9f8247be3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 06:03:03.4573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKGOmsEh6HvVQPyztMMf7fhBX6LuKyV1v9/BUyBQxiDCdH2SIjVL2b0kcVaLK0PU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3531
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/25/2022 11:25 AM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, February 25, 2022 1:47 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
>> <KevinYang.Wang@amd.com>
>> Subject: RE: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
>>
>> [AMD Official Use Only]
>>
>>> That is the caller can perform something like issuing the same message
>>> again without prerequisites check on PMFW busy
>>
>> This patch expects this method. Caller may try to resend message again. As
>> part of message sending, driver first checks response register. Current logic
>> blocks sending any message if it sees 0xFC in response register, this patch is
>> to address that.
> [Quan, Evan] Yes, I know. But the caller here could be another one. I mean there may be another caller stepped in.
> 

That shouldn't cause an issue to the second caller if it got message 
mutex. The second caller also should be able to send message if PMFW got 
free by that time. The first caller can retry when it gets back the 
message mutex. FW doesn't maintain any state for 0xFC response. Any 
other message may be sent after that. If driver keeps the state based on 
two callers, that is a logic problem in driver. I don't think we have 
any flow like that.

Basically, 0xFC is not valid pre-condition check for sending any 
message. As per PMFW team - it only means that PMFW was busy when a 
previous message was sent and PMFW won't change the response status when 
it becomes free.

Thanks,
Lijo

> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>> -----Original Message-----
>> From: Quan, Evan <Evan.Quan@amd.com>
>> Sent: Friday, February 25, 2022 11:07 AM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
>> <KevinYang.Wang@amd.com>
>> Subject: RE: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
>>
>> [AMD Official Use Only]
>>
>> This may introduce some problems for two callers scenarios. That is the 2nd
>> one will still proceed even if the 1st one was already blocked.
>> Maybe the logics here should be performed by the caller. That is the caller
>> can perform something like issuing the same message again without
>> prerequisites check on PMFW busy.
>> Or we can just update the smu_cmn_send_smc_msg APIs to give it another
>> try on PMFW busy.
>>
>> BR
>> Evan
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Friday, February 25, 2022 12:22 PM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
>>> <KevinYang.Wang@amd.com>; Quan, Evan <Evan.Quan@amd.com>
>>> Subject: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
>>>
>>> When PMFW is really busy, it will respond with 0xFC. However, it
>>> doesn't change the response register state when it becomes free.
>>> Driver should retry and proceed to send message if the response status is
>> 0xFC.
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> index 590a6ed12d54..92161b9d8c1a 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> @@ -297,7 +297,6 @@ int smu_cmn_send_msg_without_waiting(struct
>>> smu_context *smu,
>>>   	reg = __smu_cmn_poll_stat(smu);
>>>   	res = __smu_cmn_reg2errno(smu, reg);
>>>   	if (reg == SMU_RESP_NONE ||
>>> -	    reg == SMU_RESP_BUSY_OTHER ||
>>>   	    res == -EREMOTEIO)
>>>   		goto Out;
>>>   	__smu_cmn_send_msg(smu, msg_index, param); @@ -391,7 +390,6
>> @@ int
>>> smu_cmn_send_smc_msg_with_param(struct
>>> smu_context *smu,
>>>   	reg = __smu_cmn_poll_stat(smu);
>>>   	res = __smu_cmn_reg2errno(smu, reg);
>>>   	if (reg == SMU_RESP_NONE ||
>>> -	    reg == SMU_RESP_BUSY_OTHER ||
>>>   	    res == -EREMOTEIO) {
>>>   		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>>>   		goto Out;
>>> --
>>> 2.25.1
