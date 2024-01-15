Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D22AC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 19:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD0010E1CF;
	Mon, 15 Jan 2024 19:20:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D13D210E1CF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 19:20:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQJO5188dDLuUVaHkZROYzcVL9B/pHi0/QUSHAe1ltIyCtTVYpiP63vS2I4vSJAucIhbfR2AEo3OqscTT4HtxyvZmUIIKBDQpoNkqUvXbL0lW7o+L4zKQF9wNfX/V0YV8tf/08GYBogKkBRCwXO2OQLu+I+6c2EBuUcSHEMHZDfrvt1CoiJ1NYMBMKGIx69Lyy24w2scb31NPHYfg07w1oPxGc9N4+CgzfVIeGY8xXUqJTIO55IwfLaOtsQyHFH8tSaGqCIhXApbz2oAiqxgOurqQCTO+X0+6qxXxKqcYPOlClY0Ni/d+6asO6DCLVMPrQ096tq4FVxsUz9B5Xj1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH1I/xe+zJwbZXACnnuiZbfOfEl5mRSotV8nuU1Gw48=;
 b=U1XDmDImUuKYSKL9TzuBJOdWLvqIL4JT+6mXBHe0EPDo9V6GydxAHwZ/yLUksjMeA20QjcRTI3T3Q0lK9IywnAbMpttNb9AqdE3qsl9oYM4NyoTZE8HYU4UcH7ts+8e3YylEJFzHGvLo4Ku0K/ThCoHU9UNjEGyjQUSLNFGfZXHGHzQmiwi4h3CKv6IIcznHVWuuBHl/gH6Qh7NmyvvBwzx38BIPrwtH0jq8mrlACyJchgI82u+uTwU1KGHFS7qhK9aadl1Puyi6Mpd99xlCBOCGWSrsRwKy3VIrx1XCDDOOYl3GJ5tUvO0G3XqgCgSoI+CqDHj/MbcEoFu/qe2B7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH1I/xe+zJwbZXACnnuiZbfOfEl5mRSotV8nuU1Gw48=;
 b=3rK11ChgVyYPRM5ggmHe/r62o+Iq76Q0wtcwf3owlwTbKci8l4Oailgf6djWa9ifRQe0M0uAJdSdbg4pTZ4+Fupl1AaSL4VslsTa6p2ix1k1BNXYsfhztUKX3ElCQ1cRy6poNAuY/w30qIRW+F5WD6JRH/B7HZXli2fGf4UVnMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Mon, 15 Jan
 2024 19:19:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.020; Mon, 15 Jan 2024
 19:19:57 +0000
Message-ID: <bfe79411-7f77-48ab-8cfd-4727704739e8@amd.com>
Date: Mon, 15 Jan 2024 20:19:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Friedrich Vock <friedrich.vock@gmx.de>
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
 <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
 <aca706e6-58bc-4c38-bbfe-19137f38c897@gmail.com>
 <9a07c4e4-321c-4f75-aeae-81ed90038365@daenzer.net>
 <f2153219-e791-4e97-96eb-26094d7acf87@froggi.es>
 <5c99ec8c-142d-4877-9624-c8ce0373fccd@gmx.de>
 <5ff32f43-46ea-4e74-8db4-c23e0b03b429@daenzer.net>
 <8e5cd59e-075a-480e-8452-87924580122d@froggi.es>
 <1dbe811f-64a0-4ccd-88cf-3fd30f79f7bc@daenzer.net>
 <c36400bd-b8f2-4026-b989-f4e1854b05ca@gmx.de>
 <7194a09a-afe8-4eae-8288-c72e2ac7d0a6@daenzer.net>
 <51b9ffc3-9ab3-4a06-9307-6b2a343f6bc6@gmx.de>
 <CAP+8YyGg91f_z2ktrd7HQMtOSHn34F-8x7O2iRv=TTrXo2NNoA@mail.gmail.com>
 <81a82ffc-c2e6-4ce6-9cc0-4f01dc8b9891@froggi.es>
 <bff749b8-5531-46bd-8e21-97d094e6b4c2@amd.com>
 <9e6fec7b-3786-4221-8024-6b949efd08e7@froggi.es>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9e6fec7b-3786-4221-8024-6b949efd08e7@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9f82f9-0185-4c29-4345-08dc15fef5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MY+XMZ0fL5ZvV+LWlE9ZGwliXWQGP5OWTMOzloMogVK487aKZtHA55+Qc9MM1Rn+t5SjejGLQ2TKxKQczAKQ6QzJm2vIPSZA44DF1Jbvb9fclWiXDWCkh/T6B1ieu7xRFO99BLyytJvGKEeLFHdRRUShRvLnvkDvrRw7E1KlYF6FHyMyjEoHcqhcAuFxfv++G27oG0WmTRFEgzT0j6T8bJseS3LPr/rIKm9dnuIL65amHT9pVpSJ6tW6NFglgXFz8KXoqL6T3kV02D9kTUCiBzrdF5GqhP/Pkr4wX9uPivoGea1AXJLC2uVcYmo1u4OHcCP0Q/a+AOAI7gsgLNbaQt/gjTgFD5T2ZCSxHw3Tsk82Kl+nxMyWpanZ8q40DVxarPcq7zrNwv5escNsRBmyDNQhisPJwqj2F4ax5SpQoyseLzsTRqzjtS5zn7jPogQjO4yzAq3qkOfztObIThIjTNw/W2zIhhqniUG/ue5wrl30FyKVXvcRbm3kLn8oS5tlhhhRyEXQx25jaH2ycX8qXkWVT1ZqQ1G02ADOVd/s8pvPCGWmC69ZwJT9FsFWpZfuqnyhCLzBhyX3dwssYC4jXKPrv/hHhF8te0Ytaurq8RUqk9vCV69w18pxw8CbCNgEUA6j8AWhVLiE56H/m38xFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(53546011)(8936002)(8676002)(6486002)(478600001)(4326008)(6506007)(316002)(5660300002)(6512007)(86362001)(2616005)(66556008)(31696002)(36756003)(66946007)(26005)(2906002)(38100700002)(66476007)(54906003)(110136005)(66574015)(31686004)(41300700001)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU1EL28wbkFCcHVmaVRqVjBkOEFiV1QydmdpY1FXSTVJYnIvZXdweWU4VXgx?=
 =?utf-8?B?RUczZUZaYmdTT0FqNkJWNkdIYWI2RWIyRWVPN1RCWWZtWnp3aGZ3ZUkvbll0?=
 =?utf-8?B?Y2twZ0tSZXhQVytlNEpTUmlRdEJ2WldMS1hiVE9zUjNDdTJUYTI4OVlrU2s4?=
 =?utf-8?B?T09tQUZveVFhZVpBKytmTnIwcDJza3dGWlI4NldxWDV0U1M3SnExNFdERHFw?=
 =?utf-8?B?enlYUWVuYklvOUdNdE8rVURNSXB4aE95bEpUWUpwdldveXNQMUJjRXk4TmVt?=
 =?utf-8?B?aWpkVUtpall0MkkyblJ2Unk3N0hOYTR1bWNUTmFhT3BYS1FzbXF4TkUzOWJj?=
 =?utf-8?B?R2xuWFY0eXNYMnVPaytBNndmZ3NCajlnYlVIbmVHbkFpTDFWMWxrVlQ1Q1ha?=
 =?utf-8?B?YXhaa2R0MnZheGRTTjRRODRZVWhKTWpCWXRvTXhGTERjMDJ3TVlnOW1VU2FT?=
 =?utf-8?B?ZEtCYmhkRlhJcndudUFZTnJZWHJIQ1JwclZ4clVlbXMxcFRncVF6aGVTMkd2?=
 =?utf-8?B?S3hNT0pmMUEyYXJVRE5JT1gxNy90WVNzU2NVVEFJN1hJWC9HbTV2M0dHeDlq?=
 =?utf-8?B?U3BqNGRjN3RBdEZESFdNakpTNmZFOFY1WFYvRUVTblhMa09RSk5JUnJQNjZX?=
 =?utf-8?B?aHZXbDVOUHV0SW1qSXUwd1BzRm1iSUJZcTNOc2RsK3dPSGpySUxpYnkrdUls?=
 =?utf-8?B?WEVxOFNIMnlCZ2FoTUtIQzc4c3czOW9sTDhyMS9mVlF4UW5nU2FKMTkyeEFY?=
 =?utf-8?B?NDZFK1lJYTJRZHNXQm11NjhZZFNMa1hUN1Vsa1lRc0syTjVCc0poWUJFV2ZR?=
 =?utf-8?B?SFdOS0poN3loS2x2SHdleEE0WENBVkRCcE9SWFlKWURpMkV6YVFkYlN5SzY3?=
 =?utf-8?B?OVRJYWJKbmpkTGpqdDd6ZkR4eW5IcWdrdkl2OXZ6L1hTTW95UFVRcnZPNFJT?=
 =?utf-8?B?SjNETkczQ0p4SDRHaEFwYUR5bDFNL250em1tTlVYT0I0eVgwcXNIbG9QMDlG?=
 =?utf-8?B?Mk5tbUNnMFhrVSt3aVB4cFY4L1NOYXJCQkd6TUlFNUI0a2hnMXRwZ0c1ZHoz?=
 =?utf-8?B?SlhTWVc5YjVjcGhSMkRRSFhGMUhuTUZXVUp6RE4zVmVUQWplNFk2TXlZMDVB?=
 =?utf-8?B?ek1YK2QvSXhqa0hhMFphbkQ4RTNaS0Vqdk5Ta2dxMTRYTFR5YVZMQlhjMWty?=
 =?utf-8?B?RHpuVGlYT25RNmhlckZXbEorekJaVDBKUi9LbW9GSGl1emx0VFY2d053Z2VB?=
 =?utf-8?B?ZUFiRENIVnNQeGpRMlpLSlhLTEkxbDNObDFobUVDSVVIN01RUVJjMHFzTVJu?=
 =?utf-8?B?dXAyNnE4ZjdnSHk5UUY0cVBQVlFCd0J5c2FscEhVWW0wRmc3RkNRbXBZM3U3?=
 =?utf-8?B?cEV3TTlVazNjYVRiNlZld0U0UG1OL08xeUd6OHAzV0J1QzJzQ1V2QnVqNytH?=
 =?utf-8?B?MWNJRm9rQ2E4ejNDVUpjanJseUlqMkwyQzI4bWk1a3QzZE0rNWFPWW95N3pD?=
 =?utf-8?B?NWtwSzFDangwdzN4VmxPajBMUVROM3lrVlBwU2xVM0l1TFdlMFFFNmYvLzlW?=
 =?utf-8?B?S1RmSVIvV0U5SWdwU0VpcG41SDdHVXRWRkZKOW9yR1ZXZGtSbnQxdDZhbEl3?=
 =?utf-8?B?ZXhPWm9RcVY4MUxkSisxUDBHbzNGOEpGSHFCaGlwZWNSZitrbk9QVmVYTDB3?=
 =?utf-8?B?VXlBbmxTdEVjV2lta09FR2EweldoQWZ5Tlkzb1duaGZTVUUyc2kzbE0rdkNs?=
 =?utf-8?B?OUVSQ01kd0pvL3lnUHBHNHk4MzEzOHFmMWdyemZRSzhTTXhkSVc2dkZ4MHpx?=
 =?utf-8?B?a2ZncGduMTBsNUgxVDNiZzQvemxYTHpSc3dpci9xV1pvSmJqTFJNT3BBRG43?=
 =?utf-8?B?ZFB5NEdtRHlPaldrVDE1dGg3SENyOUVuaEpQcVF2UDQ2UXpWUm9jeWpYbE5o?=
 =?utf-8?B?Q1JUSFJxRHJTaUk1SGNxVnVxYklYSWxoT012WlVNVnFUYXJZc2NRbW4wdXI0?=
 =?utf-8?B?ZXpQRzNnT2NzVkZUK0tOUkJGRnQ4YXdtNFQ3eTlDRjZhMWR0cThsY1VJNEhm?=
 =?utf-8?B?dmUrRU8reFlKQjk2QzFaRS96OGdKakwweWsxaGNoVytzRkhXTzdYR2VMTEZU?=
 =?utf-8?Q?NUuGMZuhq4fABc0Li8ICk+vik?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9f82f9-0185-4c29-4345-08dc15fef5d6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 19:19:57.3043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVhZG/UC78Q2wOgeUZKge1GpZYQcW3jEfYXY1Pui7ikS9c/lGjjh4GLMdx14KfZG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.01.24 um 20:13 schrieb Joshua Ashton:
> On 1/15/24 18:53, Christian König wrote:
>> Am 15.01.24 um 19:35 schrieb Joshua Ashton:
>>> On 1/15/24 18:30, Bas Nieuwenhuizen wrote:
>>>> On Mon, Jan 15, 2024 at 7:14 PM Friedrich Vock 
>>>> <friedrich.vock@gmx.de <mailto:friedrich.vock@gmx.de>> wrote:
>>>>
>>>>     Re-sending as plaintext, sorry about that
>>>>
>>>>     On 15.01.24 18:54, Michel Dänzer wrote:
>>>>      > On 2024-01-15 18:26, Friedrich Vock wrote:
>>>>      >> [snip]
>>>>      >> The fundamental problem here is that not telling 
>>>> applications that
>>>>      >> something went wrong when you just canceled their work 
>>>> midway is an
>>>>      >> out-of-spec hack.
>>>>      >> When there is a report of real-world apps breaking because of
>>>>     that hack,
>>>>      >> reports of different apps working (even if it's convenient 
>>>> that they
>>>>      >> work) doesn't justify keeping the broken code.
>>>>      > If the breaking apps hit multiple soft resets in a row, I've 
>>>> laid
>>>>     out a pragmatic solution which covers both cases.
>>>>     Hitting soft reset every time is the lucky path. Once GPU work is
>>>>     interrupted out of nowhere, all bets are off and it might as well
>>>>     trigger a full system hang next time. No hang recovery should 
>>>> be able to
>>>>     cause that under any circumstance.
>>>>
>>>>
>>>> I think the more insidious situation is no further hangs but wrong 
>>>> results because we skipped some work. That we skipped work may e.g. 
>>>> result in some texture not being uploaded or some GPGPU work not 
>>>> being done and causing further errors downstream (say if a game is 
>>>> doing AI/physics on the GPU not to say anything of actual GPGPU 
>>>> work one might be doing like AI)
>>>
>>> Even worse if this is compute on eg. OpenCL for something 
>>> science/math/whatever related, or training a model.
>>>
>>> You could randomly just get invalid/wrong results without even knowing!
>>
>> Well on the kernel side we do provide an API to query the result of a 
>> submission. That includes canceling submissions with a soft recovery.
>>
>> What we just doesn't do is to prevent further submissions from this 
>> application. E.g. enforcing that the application is punished for bad 
>> behavior.
>
> You do prevent future submissions for regular resets though: Those 
> increase karma which sets ctx->guilty, and if ctx->guilty then 
> -ECANCELED is returned for a submission.
>
> ctx->guilty is never true for soft recovery though, as it doesn't 
> increase karma, which is the problem this patch is trying to solve.
>
> By the submission result query API, I you assume you mean checking the 
> submission fence error somehow? That doesn't seem very ergonomic for a 
> Vulkan driver compared to the simple solution which is to just mark it 
> as guilty with what already exists...

Well as I said the guilty handling is broken for quite a number of reasons.

What we can do rather trivially is changing this code in 
amdgpu_job_prepare_job():

         /* Ignore soft recovered fences here */
         r = drm_sched_entity_error(s_entity);
         if (r && r != -ENODATA)
                 goto error;

This will bubble up errors from soft recoveries into the entity as well 
and makes sure that further submissions are rejected.

Regards,
Christian.

>
> - Joshie 🐸✨
>
>>
>>>
>>> Now imagine this is VulkanSC displaying something in the car 
>>> dashboard, or some medical device doing some compute work to show 
>>> something on a graph...
>>>
>>> I am not saying you should be doing any of that with RADV + AMDGPU, 
>>> but it's just food for thought... :-)
>>>
>>> As I have been saying, you simply cannot just violate API contracts 
>>> like this, it's flatout wrong.
>>
>> Yeah, completely agree to that.
>>
>> Regards,
>> Christian.
>>
>>>
>>> - Joshie 🐸✨
>>>
>>>>
>>>>      >
>>>>      >
>>>>      >> If mutter needs to be robust against faults it caused 
>>>> itself, it
>>>>     should be robust
>>>>      >> against GPU resets.
>>>>      > It's unlikely that the hangs I've seen were caused by mutter
>>>>     itself, more likely Mesa or amdgpu.
>>>>      >
>>>>      > Anyway, this will happen at some point, the reality is it 
>>>> hasn't
>>>>     yet though.
>>>>      >
>>>>      >
>>>>
>>
>
> - Joshie 🐸✨

