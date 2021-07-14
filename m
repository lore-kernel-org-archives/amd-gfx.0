Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45265C07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 16:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF2D60FDB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 16:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF2D60FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40F26E424;
	Wed, 14 Jul 2021 16:54:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 361AE6E424
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 16:54:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+aYKlq6m2eSmB98Ls8besg/pVvgNuIXudmOBkEqc4ADsf6kL3Uls5DERLHrj847RxVwJGshNza9AAXn4Bj1X6cer0uPDZtJhYwN6z6EZJexemMjT9I5kT+JNouYn4YcS9xyl4aiKQVmnPxcS557D/zT6DuZ7dLb2vZoPw4IRHsE9yo+b3RzSD0aDj3K7SPcW6x3TjwmWJheC/kUpfPmakynr930+ZtsHE3p+sBobCC6mIRDNaiwDyvNHzYqRrvo182gY30GgdDUppM9iVyd/40uJqmLkafks2BRtYDemJociOm/czCz/i+y+5U/7ilieUrJMfQznSEyJlbvGusinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph/AWBIgkJR12vQVGlwmtrxMgupqsgCDZqKBTQelQIY=;
 b=LuQOnJatGOHKQoV92/XuisYgR3G1iX63PJSr38c3dsyT+W6IYhUoQa9lezNmFu+YWKlOQr1HaT3bM+k+j9nZhngU2mZxHTheTThEFGKHNqZ2KbXon7HflKDPeTOGRX1LvfxGc58jUU4Ce5LKBkDmG38k8FvF8nDKpK4jwClfltZFJr/1RxiB7bsCQOOhnlExjpxL3F3An4ZbldZvdOMzldCUTk1jJMTjQwkvp8qKszSLd0/z1UNfIcbaoUIXS6alRaX382oJIH7HTz93kS/swyoIHDoTgPtD8Yg/15wJN5TaJfwQJrhAcgjrcD6bKYLaBp3XeQ0mxlvr330nnlNOsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph/AWBIgkJR12vQVGlwmtrxMgupqsgCDZqKBTQelQIY=;
 b=c56gxMdDooKRxxBNEOU8viBAuwU0gNAp/JEvMsoc7ABAKUnfVccTnBPVh2jFFOSP8zlaytnLxVWg49Tm+BXjwaIyIsWpQ29uopZLHlCAUbLmsVWCuIPQk2rfQ7ZVY0A0SIpexF7sL7Ay5fErMTrwlO6ucfpslhSDlPyd9ahu1LU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 16:54:07 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257%4]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 16:54:07 +0000
Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
To: Alex Deucher <alexdeucher@gmail.com>, "Quan, Evan" <Evan.Quan@amd.com>
References: <20210712153051.4029-1-luben.tuikov@amd.com>
 <DM6PR12MB2619B19E2BBB61DA3B9DAFE8E4149@DM6PR12MB2619.namprd12.prod.outlook.com>
 <bc0a3dff-890b-16d6-2897-1a459f87cde9@amd.com>
 <DM6PR12MB2619C0AEB13E692BD66B5544E4139@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_Nqx8JOUj2imXddGTxLCULSxunH6Oy_a2v20gyeMj6udQ@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <8bbb636e-f57d-cbc8-90b5-5e9d119d2995@amd.com>
Date: Wed, 14 Jul 2021 12:54:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CADnq5_Nqx8JOUj2imXddGTxLCULSxunH6Oy_a2v20gyeMj6udQ@mail.gmail.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::12) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 16:54:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e605871-16cb-4df6-dcad-08d946e7fe5f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4385:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43858B72A61161680FD789CF99139@DM6PR12MB4385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FLHldy1kPK3zso/LlBlG9lEzRpWyWTpS0kXnt/O+xLY7RWPrHx3Khb17OIcuXrVlbn2L+VtcbIfZhIV9PhI3ILy8of8Qtn2QworzzpA91x2TaJrAFeIBji9ppNi1FqNbkSPN4zW6sh+p0Zs/mdqZuNtP1V58Kr1dBWRiYaFFO+lbmdUtYWZq+W2umUaWk2/U66yPwEk7Rp1Qn8EBKxq4VPNHG+fVVEzfl0LORYLWb5ZYKISX/Erk1n+L3XaswKKd9LnpD054WI9MDArTuy+vcvRC0K3hIk82Iqz8kF3bfrgYVHcGUIG/rjNyVNp6pmYOQYpH5Mu+7bRpgGrAG7u98S+K5vuDH2WJ8qTX+lj2Mc+JU42P0hr4+YPeFr8nKaHMrqUOhHdRlUd7md2iE0nZ3IaetKKmNIbJLqBd9mr5Uhc+tKYo2cgzJ16pB6/0kC4EF4TyQFYF3Tl1xdFGNQP1vtThnceyLce1SXR+7a0s/hugUsbo7OpJjuT/IP2l+fa1mZ5MT3G4GmSvC6Ih93GKGPbyb6zsEl/3/Phq9KuGoBmnW6PqOUMMuKnAHNma1a7mH6dFyTkkljNewagVitTzJatbiA5H52RSx8Ajj+R/KIowiLAjVW5uPlwV9rh6ZPLRE2kkkdiBxUSds7qKUFYnrDKzQZzchbh5KRLwjxTv5mH2nqfdRMHAMmnZ9q9JXZxrIn8oHrLvmMF/6Uqn3tt9WLn30SbVyfxhkAH4R3/KOTDWA3ndFPZLplCiYzkReOFn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(110136005)(316002)(54906003)(6512007)(31686004)(83380400001)(8936002)(38100700002)(6486002)(2906002)(86362001)(6636002)(8676002)(478600001)(30864003)(966005)(55236004)(5660300002)(26005)(186003)(45080400002)(6506007)(53546011)(4326008)(36756003)(66476007)(31696002)(66556008)(66946007)(44832011)(956004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHlJM2FJaEswbWRrQXByck13bitBNlpBVm9QOEhuSERPZ0JZcFBSb3NsR2lM?=
 =?utf-8?B?bzBURzh0SThXdzc3SVplWnV5dUlDa29hWXpzdWUzemI5cnY2YzFjUDBaUksy?=
 =?utf-8?B?RzZXTklRVHhXb0FyZmExZkRxcmFXRndYNkd1aUNXb3lzcU9rWTYvOXFZZXRk?=
 =?utf-8?B?cjNMVmFTd1piMks5SUp5N3gwK0Z0M2JGZDhDQWZuUVNNV2RNUXVsRlNTSXVO?=
 =?utf-8?B?b2VIVG4yWkppS25YSG9Dck1YeW02M0xjQjlqUzJzbnQvT0dSRi9PVWVWQ0VU?=
 =?utf-8?B?VW9QQ3JLTDBidVRvTHFBNEtQQWNPZE9KbjdTSzF3UVVVdy9RQUEraUVZWm90?=
 =?utf-8?B?VUorVGQ2U2xDdnE2d0hCMjVxOUNiMXZ2ZmNRcHFJdFVDaEVmY2lpRDZSSDRz?=
 =?utf-8?B?QzRjelJXQ0xkSVZFY2hXVnlteHdrNkM1ZW9DNVBHeHNvOUgxR004Z29UT0hR?=
 =?utf-8?B?YnJmNmkvVlVVMTRBdjRWNjJvUlZoSWRHODV2eklNN25YengyQ1g4UTR6Yms5?=
 =?utf-8?B?Y2NGbUNBTkdwclduV2dkMTArMU1XSmpyWnpBT1FSeEtPeXFjeGY4YmZRbCtK?=
 =?utf-8?B?dFlUWGkveWNEQmxzbGg0Y0tIaEgvNWtaS1BCT3Zuc0tYajVGUWhycmh6MytR?=
 =?utf-8?B?cWxVQzJhbC9GVm9DOWE4eEtqb0xuendJSmZqS1hHakNmck5mUjZWdkJaR04v?=
 =?utf-8?B?M2QvRkJKUFJFZ3VZbEFPdlhRaWdlSVRhWjJ3bWpOY2VMQ2QrQWNrbzVyRGNC?=
 =?utf-8?B?VlVJTUQ1TXBUZFNHazNZUHVuZm1Obnp2TXEyTWo3bTVoNGQrZzFWMlppVng5?=
 =?utf-8?B?MXdlVWpvbm1tL0IrUnV5R2wvVUZQNWpFZlVOV0ZMeS9IVVJQSE4rRFprZUNj?=
 =?utf-8?B?MFJBN0hDeVFQUFRnV1l3Z2xkQXVPNE1ZUkRiS0pzUnNaUHhDanc1R2VKQmVm?=
 =?utf-8?B?VzV1aHg0cVFTcnQ0MTAwbGJmMHBXK08xTUJVMENDVHFoTVZhd2JZbWhhMC9O?=
 =?utf-8?B?ZU9DU01hSUJrMSsrNUxJUGZiTEpGM2x3UFBaamVMMWdXbFRGaGJIZWVxTUNY?=
 =?utf-8?B?VS9MZ1BBK01LWWdMWlR5Y2oxdFpVbUtwQU5oL3RPNVJLTGhESmNxV0I4VWww?=
 =?utf-8?B?L1J5ck92eFo5V0RFRnFocUhudFRjenJRZ2tCdFlFTC92bGJVWE52RzVUaEt3?=
 =?utf-8?B?SHNnM2p5dTRiM0REZnF5SVZ3SXp3S1RLaURsSU9VS2FDOFRJcVVmb09qQjYw?=
 =?utf-8?B?QVFIWlR3cTB5K0dVWWtnUDlRa0dWcVZLeTQ2ZmFvTlJaZVR4dUFFRmZJZ2pq?=
 =?utf-8?B?VCtYeDJ6K1dkR1BuRFpVcmNscHJHWitvQ3d3NE56U3crYjYwTjRwa1BxUVMr?=
 =?utf-8?B?Qm5jRTVRcmViSDRrRnI5cGlad0RpaktrS2FiTlNIKzIxRTc4aFJ0RjgwWWRN?=
 =?utf-8?B?VWtCVWdzQmsyUWIwRm5nU29CZVE0Nk16YzA0SS9KY0ZQbjVPTk1qcFdTZlJG?=
 =?utf-8?B?UGg3eDFDTHFYK1ZMeXlQR2o2ZEVCb0M4MkFsWkN3T2VFMzZsa2duSzVnL3Q1?=
 =?utf-8?B?WW9oT0E2L2F2bnBoNmVBK0xNMWZ5SHpaSHJiM0VzdVlvYnlZMXI5T3NXMERH?=
 =?utf-8?B?K1R3UGFJajc4ckJHeXhKZE04M0N0b1NoeHhwZDJYaDBxZGxwMnNwRlVPeXF5?=
 =?utf-8?B?cWtSRjdodkxWcXFkRjlzVkNZNjFRVjRiUUQvL1NhQnBZZ215L1d2UWdCbTBk?=
 =?utf-8?Q?MkNNE9XNdYT8XZjK8QtUlMhab0S+3FkmVifRYdT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e605871-16cb-4df6-dcad-08d946e7fe5f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 16:54:07.1089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfoSATY4hucUu3r/GaCzosuVvUrAeHcG4a76iozW6SqP6NN1RlGTpvTWkFAJC59t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Baluja,
 Aaron" <Aaron.Baluja@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Alimucaj,
 Andi" <Anduil.Alimucaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-07-14 11:22 a.m., Alex Deucher wrote:
> On Tue, Jul 13, 2021 at 10:01 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>> [AMD Official Use Only]
>>
>>
>>
>>> -----Original Message-----
>>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>>> Sent: Wednesday, July 14, 2021 1:36 AM
>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Alimucaj, Andi
>>> <Anduil.Alimucaj@amd.com>; Baluja, Aaron <Aaron.Baluja@amd.com>
>>> Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
>>>
>>> On 2021-07-13 3:07 a.m., Quan, Evan wrote:
>>>> [AMD Official Use Only]
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>>>>> Sent: Monday, July 12, 2021 11:31 PM
>>>>> To: amd-gfx@lists.freedesktop.org
>>>>> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander
>>>>> <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
>>>>> Subject: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
>>>>>
>>>>> This fixes a bug which if we probe a non-existing I2C device, and the
>>>>> SMU returns 0xFF,
>>>> [Quan, Evan] Do we have to probe I2C device via issuing commands to SMU
>>> and check existence via SMU response?
>>>
>>> Yes, yes we do.
>>>
>>>> Is there other more friendly way?
>>> No, there isn't.
>>>
>>>> >from then on
>>>>> we can never communicate with the SMU, because the code before this
>>>>> patch reads and interprets 0xFF as a terminal error, and thus we
>>>>> never write 0 into register 90 to clear the status (and subsequently
>>>>> send a new command to the SMU.)
>>>>>
>>>>> It is not an error that the SMU returns status 0xFF. This means that
>>>>> the SMU executed the last command successfully (execution status),
>>>>> but the command result is an error of some sort (execution result),
>>>>> depending on what the command was.
>>>>>
>>>>> When doing a status check of the SMU, before we send a new command,
>>>>> the only status which precludes us from sending a new command is
>>>>> 0--the SMU hasn't finished executing a previous command, and
>>>>> 0xFC--the SMU is busy.
>>>>>
>>>>> This bug was seen as the following line in the kernel log,
>>>>>
>>>>> amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the
>>>>> right state!
>>>> [Quan, Evan] This was designed to prevent failure scenario from ruin.
>>>> Via this, we can prevent those SMU command/response related registers
>>> overwritten.
>>>> Then PMFW team can known which command invoked the first error.
>>> Sorry, this is not correct.
>>>
>>> The interface cannot block valid access to the SMU firmware, just because a
>>> command executed successfully, but with a failed result, i.e. set a clock
>>> frequency to such-and-such frequency was executed successfully by the
>>> SMU, but the frequency wasn't able to be set as required--the SMU IS NOT
>>> BLOCKED, but can execute more commands.
>> [Quan, Evan]
>> 1. First of all, if the response from SMU is not 1, it means SMU must detected something wrong.
>> We(driver) should properly handle that. I do not think it's a good idea to silently ignore that and proceed more commands.
>> 2. Please be noticed that many commands(SMU messages) have dependence with each other. It means even if the further command
>> can be executed "successfully", it may be not executed in the expected way.
>>> If the PMFW team wants to know which command invoked "the first error",
>>> they can check this explicitly, they can call smu_cmn_wait_for_response(),
>>> just like the reset code does--see the reset code.
>> [Quan, Evan] Per my knowledge gained during co-work with PMFW team, they expect no further driver-smu interaction(driver stops issuing command)
>>  when something went wrong. As they highly rely on SMU internal statistics for their debugging and further interaction may ruin them.
>>> The way commit fcb1fe9c9e0031 modified the code, it blocks access to the
>>> SMU for various other users of the SMU, not least of which is the I2C.
>> [Quan, Evan] I'm wondering can we just list the I2C case as an exception. I means for the SMU command related with I2C we always assume the response is 1.
>> For other commands, we just leave them as they are.
> Maybe we need to just bubble this up to the callers and let each one
> handle it as appropriate.  I don't think just throwing up our hands on
> any error is the right thing to do.  The i2c case is a good example.
> In other cases, we could probably just retry the transaction or just
> ignore the error.

My thoughts exactly. I'll generate a v3 of the patch to address the issues brought here and elsewhere.

Regards,
Luben

>
> Alex
>
>
>> BR
>> Evan
>>> Regards,
>>> Luben
>>>
>>>> BR
>>>> Evan
>>>>> when subsequent SMU commands, not necessarily related to I2C, were
>>>>> sent to the SMU.
>>>>>
>>>>> This patch fixes this bug.
>>>>>
>>>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>>>> Cc: Evan Quan <evan.quan@amd.com>
>>>>> Fixes: fcb1fe9c9e0031 ("drm/amd/powerplay: pre-check the SMU state
>>>>> before issuing message")
>>>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 196
>>>>> +++++++++++++++++++------
>>>>>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
>>>>>  2 files changed, 152 insertions(+), 47 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> index c902fdf322c1be..775eb50a2e49a6 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> @@ -55,7 +55,7 @@
>>>>>
>>>>>  #undef __SMU_DUMMY_MAP
>>>>>  #define __SMU_DUMMY_MAP(type)     #type
>>>>> -static const char* __smu_message_names[] = {
>>>>> +static const char * const __smu_message_names[] = {
>>>>>    SMU_MESSAGE_TYPES
>>>>>  };
>>>>>
>>>>> @@ -76,46 +76,161 @@ static void smu_cmn_read_arg(struct
>>> smu_context
>>>>> *smu,
>>>>>    *arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);  }
>>>>>
>>>>> -int smu_cmn_wait_for_response(struct smu_context *smu)
>>>>> +/**
>>>>> + * __smu_cmn_poll_stat -- poll for a status from the SMU
>>>>> + * smu: a pointer to SMU context
>>>>> + *
>>>>> + * Returns the status of the SMU, which could be,
>>>>> + * 0, the SMU is busy with your previous command;
>>>>> + * 1,    execution status: success, execution result: success;
>>>>> + * 0xFF, execution status: success, execution result: failure;
>>>>> + * 0xFE, unknown command;
>>>>> + * 0xFD, valid command, but bad (command) prerequisites;
>>>>> + * 0xFC, the command was rejected as the SMU is busy;
>>>>> + * 0xFB, "SMC_Result_DebugDataDumpEnd".
>>>>> + */
>>>>> +static u32 __smu_cmn_poll_stat(struct smu_context *smu)
>>>>>  {
>>>>>    struct amdgpu_device *adev = smu->adev;
>>>>> -  uint32_t cur_value, i, timeout = adev->usec_timeout * 20;
>>>>> +  int timeout = adev->usec_timeout * 20;
>>>>> +  u32 reg;
>>>>>
>>>>> -  for (i = 0; i < timeout; i++) {
>>>>> -          cur_value = RREG32_SOC15(MP1, 0,
>>>>> mmMP1_SMN_C2PMSG_90);
>>>>> -          if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>>>>> -                  return cur_value;
>>>>> +  for ( ; timeout > 0; timeout--) {
>>>>> +          reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>>>>> +          if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>>>>> +                  break;
>>>>>
>>>>>            udelay(1);
>>>>>    }
>>>>>
>>>>> -  /* timeout means wrong logic */
>>>>> -  if (i == timeout)
>>>>> -          return -ETIME;
>>>>> -
>>>>> -  return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>>>>> +  return reg;
>>>>>  }
>>>>>
>>>>> -int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>>>>> -                               uint16_t msg, uint32_t param)
>>>>> +static void __smu_cmn_reg_print_error(struct smu_context *smu,
>>>>> +                                u32 reg_c2pmsg_90,
>>>>> +                                int msg_index,
>>>>> +                                u32 param,
>>>>> +                                enum smu_message_type msg)
>>>>>  {
>>>>>    struct amdgpu_device *adev = smu->adev;
>>>>> -  int ret;
>>>>> +  const char *message = smu_get_message_name(smu, msg);
>>>>>
>>>>> -  ret = smu_cmn_wait_for_response(smu);
>>>>> -  if (ret != 0x1) {
>>>>> -          dev_err(adev->dev, "Msg issuing pre-check failed(0x%x) and
>>>>> "
>>>>> -                 "SMU may be not in the right state!\n", ret);
>>>>> -          if (ret != -ETIME)
>>>>> -                  ret = -EIO;
>>>>> -          return ret;
>>>>> +  switch (reg_c2pmsg_90) {
>>>>> +  case 0:
>>>>> +          dev_err_ratelimited(adev->dev,
>>>>> +                              "SMU: I'm not done with your previous
>>>>> command!");
>>>>> +          break;
>>>>> +  case 1:
>>>>> +          /* The SMU executed the command. It completed with a
>>>>> +           * successful result.
>>>>> +           */
>>>>> +          break;
>>>>> +  case 0xFF:
>>>>> +          /* The SMU executed the command. It completed with a
>>>>> +           * unsuccessful result.
>>>>> +           */
>>>>> +          break;
>>>>> +  case 0xFE:
>>>>> +          dev_err_ratelimited(adev->dev,
>>>>> +                              "SMU: unknown command: index:%d
>>>>> param:0x%08X message:%s",
>>>>> +                              msg_index, param, message);
>>>>> +          break;
>>>>> +  case 0xFD:
>>>>> +          dev_err_ratelimited(adev->dev,
>>>>> +                              "SMU: valid command, bad prerequisites:
>>>>> index:%d param:0x%08X message:%s",
>>>>> +                              msg_index, param, message);
>>>>> +          break;
>>>>> +  case 0xFC:
>>>>> +          dev_err_ratelimited(adev->dev,
>>>>> +                              "SMU: I'm very busy for your command:
>>>>> index:%d param:0x%08X message:%s",
>>>>> +                              msg_index, param, message);
>>>>> +          break;
>>>>> +  case 0xFB:
>>>>> +          dev_err_ratelimited(adev->dev,
>>>>> +                              "SMU: I'm debugging!");
>>>>> +          break;
>>>>> +  default:
>>>>> +          dev_err_ratelimited(adev->dev,
>>>>> +                              "SMU: response:0x%08X for index:%d
>>>>> param:0x%08X message:%s?",
>>>>> +                              reg_c2pmsg_90, msg_index, param,
>>>>> message);
>>>>> +          break;
>>>>> +  }
>>>>> +}
>>>>> +
>>>>> +static int __smu_cmn_reg2errno(struct smu_context *smu, u32
>>>>> reg_c2pmsg_90)
>>>>> +{
>>>>> +  int res;
>>>>> +
>>>>> +  switch (reg_c2pmsg_90) {
>>>>> +  case 0:
>>>>> +          res = -ETIME;
>>>>> +          break;
>>>>> +  case 1:
>>>>> +          res = 0;
>>>>> +          break;
>>>>> +  case 0xFF:
>>>>> +          res = -EIO;
>>>>> +          break;
>>>>> +  case 0xFE:
>>>>> +          res = -EOPNOTSUPP;
>>>>> +          break;
>>>>> +  case 0xFD:
>>>>> +          res = -EIO;
>>>>> +          break;
>>>>> +  case 0xFC:
>>>>> +          res = -EBUSY;
>>>>> +          break;
>>>>> +  case 0xFB:
>>>>> +          res = -EIO;
>>>>> +          break;
>>>>> +  default:
>>>>> +          res = -EIO;
>>>>> +          break;
>>>>>    }
>>>>>
>>>>> +  return res;
>>>>> +}
>>>>> +
>>>>> +static void __smu_cmn_send_msg(struct smu_context *smu,
>>>>> +                         u16 msg,
>>>>> +                         u32 param)
>>>>> +{
>>>>> +  struct amdgpu_device *adev = smu->adev;
>>>>> +
>>>>>    WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
>>>>>    WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
>>>>>    WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
>>>>> +}
>>>>>
>>>>> -  return 0;
>>>>> +int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>>>>> +                               uint16_t msg_index,
>>>>> +                               uint32_t param)
>>>>> +{
>>>>> +  u32 reg;
>>>>> +  int res;
>>>>> +
>>>>> +  if (smu->adev->in_pci_err_recovery)
>>>>> +          return 0;
>>>>> +
>>>>> +  mutex_lock(&smu->message_lock);
>>>>> +  reg = __smu_cmn_poll_stat(smu);
>>>>> +  if (reg == 0 || reg == 0xFC) {
>>>>> +          res = __smu_cmn_reg2errno(smu, reg);
>>>>> +          goto Out;
>>>>> +  }
>>>>> +  __smu_cmn_send_msg(smu, msg_index, param);
>>>>> +  res = 0;
>>>>> +Out:
>>>>> +  mutex_unlock(&smu->message_lock);
>>>>> +  return res;
>>>>> +}
>>>>> +
>>>>> +int smu_cmn_wait_for_response(struct smu_context *smu) {
>>>>> +  u32 reg;
>>>>> +
>>>>> +  reg = __smu_cmn_poll_stat(smu);
>>>>> +  return __smu_cmn_reg2errno(smu, reg);
>>>>>  }
>>>>>
>>>>>  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>>> @@
>>>>> -123,8 +238,8 @@ int smu_cmn_send_smc_msg_with_param(struct
>>>>> smu_context *smu,
>>>>>                                uint32_t param,
>>>>>                                uint32_t *read_arg)
>>>>>  {
>>>>> -  struct amdgpu_device *adev = smu->adev;
>>>>> -  int ret = 0, index = 0;
>>>>> +  int res, index;
>>>>> +  u32 reg;
>>>>>
>>>>>    if (smu->adev->in_pci_err_recovery)
>>>>>            return 0;
>>>>> @@ -136,31 +251,20 @@ int
>>> smu_cmn_send_smc_msg_with_param(struct
>>>>> smu_context *smu,
>>>>>            return index == -EACCES ? 0 : index;
>>>>>
>>>>>    mutex_lock(&smu->message_lock);
>>>>> -  ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
>>>>> param);
>>>>> -  if (ret)
>>>>> -          goto out;
>>>>> -
>>>>> -  ret = smu_cmn_wait_for_response(smu);
>>>>> -  if (ret != 0x1) {
>>>>> -          if (ret == -ETIME) {
>>>>> -                  dev_err(adev->dev, "message: %15s (%d) \tparam:
>>>>> 0x%08x is timeout (no response)\n",
>>>>> -                          smu_get_message_name(smu, msg), index,
>>>>> param);
>>>>> -          } else {
>>>>> -                  dev_err(adev->dev, "failed send message: %15s (%d)
>>>>> \tparam: 0x%08x response %#x\n",
>>>>> -                          smu_get_message_name(smu, msg), index,
>>>>> param,
>>>>> -                          ret);
>>>>> -                  ret = -EIO;
>>>>> -          }
>>>>> -          goto out;
>>>>> +  reg = __smu_cmn_poll_stat(smu);
>>>>> +  if (reg == 0 || reg == 0xFC) {
>>>>> +          res = __smu_cmn_reg2errno(smu, reg);
>>>>> +          __smu_cmn_reg_print_error(smu, reg, index, param, msg);
>>>>> +          goto Out;
>>>>>    }
>>>>> -
>>>>> +  __smu_cmn_send_msg(smu, (uint16_t) index, param);
>>>>> +  reg = __smu_cmn_poll_stat(smu);
>>>>> +  res = __smu_cmn_reg2errno(smu, reg);
>>>>>    if (read_arg)
>>>>>            smu_cmn_read_arg(smu, read_arg);
>>>>> -
>>>>> -  ret = 0; /* 0 as driver return value */
>>>>> -out:
>>>>> +Out:
>>>>>    mutex_unlock(&smu->message_lock);
>>>>> -  return ret;
>>>>> +  return res;
>>>>>  }
>>>>>
>>>>>  int smu_cmn_send_smc_msg(struct smu_context *smu, diff --git
>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> index 9add5f16ff562a..16993daa2ae042 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> @@ -27,7 +27,8 @@
>>>>>
>>>>>  #if defined(SWSMU_CODE_LAYER_L2) ||
>>> defined(SWSMU_CODE_LAYER_L3)
>>>>> || defined(SWSMU_CODE_LAYER_L4)
>>>>>  int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>>>>> -                               uint16_t msg, uint32_t param);
>>>>> +                               uint16_t msg_index,
>>>>> +                               uint32_t param);
>>>>>  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>>>>>                                enum smu_message_type msg,
>>>>>                                uint32_t param,
>>>>> --
>>>>> 2.32.0
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CLuben.Tuikov%40amd.com%7C0034eccb90234c6ba0d908d946db48a1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637618729900432066%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=DYigx7bg6kAoZOeQKP2olVlwmrombaAnVpVNDXhqwzg%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
