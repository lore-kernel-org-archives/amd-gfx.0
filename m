Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51824C07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 04:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083266136E
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 04:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083266136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78EA389C8F;
	Wed, 14 Jul 2021 04:05:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E5E989C8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 04:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0gT5szeB+cLeszH9Dun24O1zqkfzvN93kJS+4/FO1K2pgTUDIZ3HR1QHBahAERFwu/KXW7zxDg6/31f//fNokbLY/A1mpuUYHyoXrk3OW6zt02WgyLrvGQ1C0HRZj20Adb8RKmbAtdGCJme/3bQ+2GzYT4BAwyu0/W7ARzsNNsy1KTvkLYpwgbWwkChGttbrc6im45WRVpdwY4ACjAqY8vFvdv+jTqRuBtXIewebkvclxwzHIHRL824ThI94OSOwjCF5Ij+PJzpYpS1gJo1+gYmhxLuICzTiJ5SLAhvR5qKFpb69b6P5QGeKvdJhmmfZCtLyKKpCfVSHj5uWjdVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1W/JqHHDq8HbJJIP7LOdblM8A/gw+1JWBMVC5y0Lh00=;
 b=lS94I6E1txuNJyL9E0YDa3ayvdotEt4RAc1Z3xglJCOdwZLq+Zr72L7CgXfS6XW13PlLsuT7FtsDGURJUleyHH4KUzLG4+/oM8rdHhdbFIulBj5uAk9UIZLcSjwnyoRTxFZeoYbekDQA3LrJ8L3GY+8uirl2kXPREpJ5b/vtSlnM5ev8zBHC+CxcUGP65Tc3om3GismswBbQbzUrUMkMJ6Ufi2NvgCeMTsdZ2JhIWge1ju+Xz50rU6heFXVGUP19Wt8Q52LvC8T4q8q5KOwbz4iUOWr+DtRfGg7DNb3HAHBxpYpK+qLIiC84kDHWmIVwvTY/ZdkvJ/R/ItTZkD7A0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1W/JqHHDq8HbJJIP7LOdblM8A/gw+1JWBMVC5y0Lh00=;
 b=xZHWlHHUoGDI46g0eICd+pHn3XPVNEHLbk4vShV/HMs/DRmH3PJH8aYVH7CCzrLmBDDbT88hVB34fy26WqNv8O/jflJ60OZroH8NOakaZqbs4dm1Agbu8gcIFu2QGkJj0HgXWpEk1JmbXPHvM1MM/6o586KVul0G2GZn0ULz+fk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1867.namprd12.prod.outlook.com (2603:10b6:3:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 04:05:00 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257%4]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 04:05:00 +0000
Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210712153051.4029-1-luben.tuikov@amd.com>
 <DM6PR12MB2619B19E2BBB61DA3B9DAFE8E4149@DM6PR12MB2619.namprd12.prod.outlook.com>
 <bc0a3dff-890b-16d6-2897-1a459f87cde9@amd.com>
 <DM6PR12MB2619C0AEB13E692BD66B5544E4139@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <3767e5b0-b8b8-a94f-ac82-f174995541b4@amd.com>
Date: Wed, 14 Jul 2021 00:04:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <DM6PR12MB2619C0AEB13E692BD66B5544E4139@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::35) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 04:05:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72498ce8-f560-4578-fcc2-08d9467c8ce8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1867609A31F6DBACB6CC000799139@DM5PR12MB1867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZDv9Y9Ynx5Dmv5IvfZyYU2T+xqfPdHN9Ioh20Z4KYvqXJcC5j5fLEx7sCXM6O0lQFCORKKSd093+EUKJ3PaltK4I5SlGm7a3mhdo4afnQ+B+pVCPAo3fYpg0xj0yrCjlQ6kVtrjUIS3Wp0C+OjIpJ1ONzdXEcMzskEfnXAiIpnJMQMwGz/XEDIvtegxIqZYWace/Pxd57fWfK261qxHptZ+MlPCUsp3YwzqL8NRWSPWRocRkQ1TO95bnr9g8ZuQR8WTJ6M0gCvASrC/kgv/RQNS6VYe3R27FjWGsumMsr3a+xEwNaGmSPwTPAHEcgF+oZMFwcoyKP3P5v2tFS/fli8Zi4RZ/HVwBa/ED0d6XY04OIB26TQPN6pZ3kWQUC6tnJt2z2q3W5u61DoG3HAlfBtkLMOK7H8Pwg2FbUCeYaCQTG3Vo0iw44VdO7XjeMTgxyPUFbL/CvBTrLzBWAxG6Hjk0d9qrnK8zhHCwK3yDOtMCZFUxw/xoUJdd9VoZqaAYgpQKYeFTgVCI0bIcJJFaorBhOWWXhg+EOL3XDFQi8DnXE5ajIrH/7tXtSXgLUIGZuSsW2pmB/H090j+4lk5OoOs5Q7KxITJTkIrSMLl2+uZbPdm0DJe4ipNM/n3bIiUuZ2Mb6yRQyUrAUb3BbGNhxjXeTdlTGfBR8qHHN7ZQGNC1TP9vSE15JZEJ9/xV8O+UgO0RZuyiZnDJ8M0jY9onI3qqhpMFBSJ0Yeijk94gH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(478600001)(55236004)(86362001)(31696002)(26005)(186003)(83380400001)(2906002)(30864003)(8936002)(6506007)(6486002)(316002)(38100700002)(66476007)(956004)(31686004)(66556008)(53546011)(4326008)(8676002)(44832011)(54906003)(66946007)(110136005)(2616005)(6512007)(5660300002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHVaYklLS0NRUW9QVXlRdzVSd2t6WVRFNVNjNjZWdzNXR0loQjdqNSt5TVU4?=
 =?utf-8?B?QW1HT1l6TUxxRE9nRzJRbk0yUnlYbnhSNDhGejBPNm5mR2hUb1NGK2RJRFBJ?=
 =?utf-8?B?L2p6N1o4TGcxL2x0Q2RraXEwSTEwZFo5SWRrTE81VHNjVzlkL1lCQW9NNUtt?=
 =?utf-8?B?dDFqakNTbTZQMCtLRjUrTXg3YlJvV3Y4czdOeDRpbkhHS21DK3UrQUk4ekFo?=
 =?utf-8?B?bytqZGZTWkI1WkRuOCtZL1VOMlc1NjRrMHNRNnpUZkpaeDBjWm5NMU84OWNE?=
 =?utf-8?B?MUQ5cWRxZDY1S3U5UkJ5MXdyRWZWUTdua2R4WDRyaHRzNjBVNG5ONFM3Q3Vz?=
 =?utf-8?B?Ukh3UExDbWYxRDdoYTNkWGZFUDROcGxCZ3RuNlorYVlmWGl6d281dlZWUERY?=
 =?utf-8?B?RDF0WVRqQXM5M01MRVdiT0JONk5jOHN4N245QUQycStQSjBqTXMyWUlMMjFZ?=
 =?utf-8?B?cUtzQUl0a3FhRmMyUElYbFBNUHJTOTJzL0lQZHVISnc2RHdxN2Y0bHVJN2ZR?=
 =?utf-8?B?WEZvMVJ3YUZJYjNCTC93Y05SbUJsU1pyNWU1VkhrZWcvcHYvN1hibEVXR2I2?=
 =?utf-8?B?S1huSWs5N3IvaU9DMlBPcVk5VGxvU3FMdDJZYTNCTkJ2ZG1lMkJkOWxQbHE1?=
 =?utf-8?B?ZHE2VE5BM01BYlBFS3JNMUM0VWswcmNxR3U3VFRGdHhSbitpbDRjQXJxeEdH?=
 =?utf-8?B?b21rUHlQZlM4bU41Q3pNb1lINjFwR0lBVThFWThUeWYvWTNUVEtWa05nZkJO?=
 =?utf-8?B?UmVlQ1V1cm1FbzlaQy8rY3FrOGdYQW45WDNJQTdhd05CYXZSWi9IS3FKM0dl?=
 =?utf-8?B?ajhtY0JsSDIrYnVrM3lxTlc3TWNhYWxnQWhHNTV6S1ExOVpGZkFFT2NSTlFJ?=
 =?utf-8?B?YXBHMVFvVUxvRng5K2NIelRHUkw3K3JXNlY5T3UybWpUMSt2TVZtc2lPN01T?=
 =?utf-8?B?UVFxSUFMRWZ4cjZ0cWwxRy9UQWE5QSttSkFTVG9FcXkwSlFUMnRxcGMzc1Fn?=
 =?utf-8?B?S0lzaW9GQnhEMlBzVERzYjZKaUdFam5RMWlMN3JlREM1YnV0bnJYaVBQMmJy?=
 =?utf-8?B?MXhYWjRaeG9kZGtaQms2c0hmdm0renJmUEIrRnRnVTY5Ukh6SzUyRDNFNW9o?=
 =?utf-8?B?ckEwdy9zcVVOSHVWYVY3VHZ5dTlkOTRnTjVSbStNSFJoQkJ3ZVNZcHdRSEdl?=
 =?utf-8?B?N2VoNXZBWWxkQlJnaUNOcFZhWUgyWkY3d211aWxRNGtnTHN5Y0tPajg2U1BB?=
 =?utf-8?B?ZjVpMWxua05nUGV4Y0V5cUJHSnNEVDlDamFKc3E5bTVGSFlvd0pGa25ZQ1k0?=
 =?utf-8?B?dmdJUzcrdytPLytYUk9vLzNhWHNFMTViTUF5K1NCTVNBc29HeTFZSEZNOHov?=
 =?utf-8?B?eUlmYXpsMlFpUWJsZnV0eENpazZwQ3d2dGJZMTFtNGtUd1JRbzJ3eG1zYUtm?=
 =?utf-8?B?bUxHK3NZTS9SenpiRUI3aDZXM004NEpDNXMvZEs3ZytDMWpzM2VNczdwVlZm?=
 =?utf-8?B?Tm5TWnFhS0FXNWZxR1orTDhtYmZRSitpNDVMYmdGb1VSdUZoa0ZxZFhIUmhF?=
 =?utf-8?B?Mkw2MCtqQ3hKdnpzUTN1NnZtMzdTRHNLVEVWdUw3cHJPY1NMOXRnTVFXSG1m?=
 =?utf-8?B?elhjVG5iUmdRK2U5bUpldS8xZ1Z5dEJPQUEyb1NQSVhkM0Z0NWZmbkFGREdv?=
 =?utf-8?B?Zm41cjJKNW5pNUVuckVSS1lyU3lRTjlreCs5NXBGdTlzM2FFTWQ4aWRwcWlk?=
 =?utf-8?Q?dTZvKcl16V+veZl5xk97gWhDRy9D6PfBNyy7ZUW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72498ce8-f560-4578-fcc2-08d9467c8ce8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 04:05:00.5543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0lSwCwRVupirj1MPLp10lYEpM5vqVjDZY9zCje/y5hgrH/oV23eUjM3hqTIa0zL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
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
 Aaron" <Aaron.Baluja@amd.com>, "Alimucaj, Andi" <Anduil.Alimucaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-07-13 10:01 p.m., Quan, Evan wrote:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>> Sent: Wednesday, July 14, 2021 1:36 AM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Alimucaj, Andi
>> <Anduil.Alimucaj@amd.com>; Baluja, Aaron <Aaron.Baluja@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
>>
>> On 2021-07-13 3:07 a.m., Quan, Evan wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>>>> Sent: Monday, July 12, 2021 11:31 PM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
>>>> Subject: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
>>>>
>>>> This fixes a bug which if we probe a non-existing I2C device, and the
>>>> SMU returns 0xFF,
>>> [Quan, Evan] Do we have to probe I2C device via issuing commands to SMU
>> and check existence via SMU response?
>>
>> Yes, yes we do.
>>
>>> Is there other more friendly way?
>> No, there isn't.
>>
>>> >from then on
>>>> we can never communicate with the SMU, because the code before this
>>>> patch reads and interprets 0xFF as a terminal error, and thus we
>>>> never write 0 into register 90 to clear the status (and subsequently
>>>> send a new command to the SMU.)
>>>>
>>>> It is not an error that the SMU returns status 0xFF. This means that
>>>> the SMU executed the last command successfully (execution status),
>>>> but the command result is an error of some sort (execution result),
>>>> depending on what the command was.
>>>>
>>>> When doing a status check of the SMU, before we send a new command,
>>>> the only status which precludes us from sending a new command is
>>>> 0--the SMU hasn't finished executing a previous command, and
>>>> 0xFC--the SMU is busy.
>>>>
>>>> This bug was seen as the following line in the kernel log,
>>>>
>>>> amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the
>>>> right state!
>>> [Quan, Evan] This was designed to prevent failure scenario from ruin.
>>> Via this, we can prevent those SMU command/response related registers
>> overwritten.
>>> Then PMFW team can known which command invoked the first error.
>> Sorry, this is not correct.
>>
>> The interface cannot block valid access to the SMU firmware, just because a
>> command executed successfully, but with a failed result, i.e. set a clock
>> frequency to such-and-such frequency was executed successfully by the
>> SMU, but the frequency wasn't able to be set as required--the SMU IS NOT
>> BLOCKED, but can execute more commands.
> [Quan, Evan] 
> 1. First of all, if the response from SMU is not 1, it means SMU must detected something wrong.

Not necessarily. The codes I've included in the patch. "something wrong" isn't well defined.

> We(driver) should properly handle that. I do not think it's a good idea to silently ignore that and proceed more commands.

And we do. We do handle properly. Perhaps the best way to handle it is to *send another command* to the SMU as a follow-up, and so on.

> 2. Please be noticed that many commands(SMU messages) have dependence with each other. It means even if the further command
> can be executed "successfully", it may be not executed in the expected way.

Sure, sure. And the client should know this dependency, and should check the result, and should know whether to continue to send more commands or do something else. Either way, you cannot block access to the SMU, when other clients can use it. We've seen plenty of logs where gfxoff was unsuccessful because of this bug.

Here's the gist of it: smu_cmn.c CANNOT BLOCK access to the SMU just because one client doesn't check results and doesn't know how to handle them correctly. smu_cmn.c just facilitates access to the SMU when possible (SMU is not busy).

If there's an error, the client takes that error and decides what to do next, but smu_cmn.c CANNOT block access to the SMU.

>> If the PMFW team wants to know which command invoked "the first error",
>> they can check this explicitly, they can call smu_cmn_wait_for_response(),
>> just like the reset code does--see the reset code.
> [Quan, Evan] Per my knowledge gained during co-work with PMFW team, they expect no further driver-smu interaction(driver stops issuing command)
>  when something went wrong. As they highly rely on SMU internal statistics for their debugging and further interaction may ruin them.

Then that is a different change, and a different patch.

Note however that STILL you cannot block access to the SMU, for instance gfxoff, or RAS may want to write some bad pages to the EEPROM. Nope! You cannot block access to the SMU.

>> The way commit fcb1fe9c9e0031 modified the code, it blocks access to the
>> SMU for various other users of the SMU, not least of which is the I2C.
> [Quan, Evan] I'm wondering can we just list the I2C case as an exception. I means for the SMU command related with I2C we always assume the response is 1.
> For other commands, we just leave them as they are.

Well, it seems you're writing a debug behaviour into the driver out in the field.

We cannot assume that for I2C response is always 1--what if there is no such I2C device on that bus? Upper layers need to know that.

Regards,
Luben



>
> BR
> Evan
>> Regards,
>> Luben
>>
>>> BR
>>> Evan
>>>> when subsequent SMU commands, not necessarily related to I2C, were
>>>> sent to the SMU.
>>>>
>>>> This patch fixes this bug.
>>>>
>>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>>> Cc: Evan Quan <evan.quan@amd.com>
>>>> Fixes: fcb1fe9c9e0031 ("drm/amd/powerplay: pre-check the SMU state
>>>> before issuing message")
>>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 196
>>>> +++++++++++++++++++------
>>>>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
>>>>  2 files changed, 152 insertions(+), 47 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>> index c902fdf322c1be..775eb50a2e49a6 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>> @@ -55,7 +55,7 @@
>>>>
>>>>  #undef __SMU_DUMMY_MAP
>>>>  #define __SMU_DUMMY_MAP(type)	#type
>>>> -static const char* __smu_message_names[] = {
>>>> +static const char * const __smu_message_names[] = {
>>>>  	SMU_MESSAGE_TYPES
>>>>  };
>>>>
>>>> @@ -76,46 +76,161 @@ static void smu_cmn_read_arg(struct
>> smu_context
>>>> *smu,
>>>>  	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);  }
>>>>
>>>> -int smu_cmn_wait_for_response(struct smu_context *smu)
>>>> +/**
>>>> + * __smu_cmn_poll_stat -- poll for a status from the SMU
>>>> + * smu: a pointer to SMU context
>>>> + *
>>>> + * Returns the status of the SMU, which could be,
>>>> + * 0, the SMU is busy with your previous command;
>>>> + * 1,    execution status: success, execution result: success;
>>>> + * 0xFF, execution status: success, execution result: failure;
>>>> + * 0xFE, unknown command;
>>>> + * 0xFD, valid command, but bad (command) prerequisites;
>>>> + * 0xFC, the command was rejected as the SMU is busy;
>>>> + * 0xFB, "SMC_Result_DebugDataDumpEnd".
>>>> + */
>>>> +static u32 __smu_cmn_poll_stat(struct smu_context *smu)
>>>>  {
>>>>  	struct amdgpu_device *adev = smu->adev;
>>>> -	uint32_t cur_value, i, timeout = adev->usec_timeout * 20;
>>>> +	int timeout = adev->usec_timeout * 20;
>>>> +	u32 reg;
>>>>
>>>> -	for (i = 0; i < timeout; i++) {
>>>> -		cur_value = RREG32_SOC15(MP1, 0,
>>>> mmMP1_SMN_C2PMSG_90);
>>>> -		if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>>>> -			return cur_value;
>>>> +	for ( ; timeout > 0; timeout--) {
>>>> +		reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>>>> +		if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>>>> +			break;
>>>>
>>>>  		udelay(1);
>>>>  	}
>>>>
>>>> -	/* timeout means wrong logic */
>>>> -	if (i == timeout)
>>>> -		return -ETIME;
>>>> -
>>>> -	return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>>>> +	return reg;
>>>>  }
>>>>
>>>> -int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>>>> -				     uint16_t msg, uint32_t param)
>>>> +static void __smu_cmn_reg_print_error(struct smu_context *smu,
>>>> +				      u32 reg_c2pmsg_90,
>>>> +				      int msg_index,
>>>> +				      u32 param,
>>>> +				      enum smu_message_type msg)
>>>>  {
>>>>  	struct amdgpu_device *adev = smu->adev;
>>>> -	int ret;
>>>> +	const char *message = smu_get_message_name(smu, msg);
>>>>
>>>> -	ret = smu_cmn_wait_for_response(smu);
>>>> -	if (ret != 0x1) {
>>>> -		dev_err(adev->dev, "Msg issuing pre-check failed(0x%x) and
>>>> "
>>>> -		       "SMU may be not in the right state!\n", ret);
>>>> -		if (ret != -ETIME)
>>>> -			ret = -EIO;
>>>> -		return ret;
>>>> +	switch (reg_c2pmsg_90) {
>>>> +	case 0:
>>>> +		dev_err_ratelimited(adev->dev,
>>>> +				    "SMU: I'm not done with your previous
>>>> command!");
>>>> +		break;
>>>> +	case 1:
>>>> +		/* The SMU executed the command. It completed with a
>>>> +		 * successful result.
>>>> +		 */
>>>> +		break;
>>>> +	case 0xFF:
>>>> +		/* The SMU executed the command. It completed with a
>>>> +		 * unsuccessful result.
>>>> +		 */
>>>> +		break;
>>>> +	case 0xFE:
>>>> +		dev_err_ratelimited(adev->dev,
>>>> +				    "SMU: unknown command: index:%d
>>>> param:0x%08X message:%s",
>>>> +				    msg_index, param, message);
>>>> +		break;
>>>> +	case 0xFD:
>>>> +		dev_err_ratelimited(adev->dev,
>>>> +				    "SMU: valid command, bad prerequisites:
>>>> index:%d param:0x%08X message:%s",
>>>> +				    msg_index, param, message);
>>>> +		break;
>>>> +	case 0xFC:
>>>> +		dev_err_ratelimited(adev->dev,
>>>> +				    "SMU: I'm very busy for your command:
>>>> index:%d param:0x%08X message:%s",
>>>> +				    msg_index, param, message);
>>>> +		break;
>>>> +	case 0xFB:
>>>> +		dev_err_ratelimited(adev->dev,
>>>> +				    "SMU: I'm debugging!");
>>>> +		break;
>>>> +	default:
>>>> +		dev_err_ratelimited(adev->dev,
>>>> +				    "SMU: response:0x%08X for index:%d
>>>> param:0x%08X message:%s?",
>>>> +				    reg_c2pmsg_90, msg_index, param,
>>>> message);
>>>> +		break;
>>>> +	}
>>>> +}
>>>> +
>>>> +static int __smu_cmn_reg2errno(struct smu_context *smu, u32
>>>> reg_c2pmsg_90)
>>>> +{
>>>> +	int res;
>>>> +
>>>> +	switch (reg_c2pmsg_90) {
>>>> +	case 0:
>>>> +		res = -ETIME;
>>>> +		break;
>>>> +	case 1:
>>>> +		res = 0;
>>>> +		break;
>>>> +	case 0xFF:
>>>> +		res = -EIO;
>>>> +		break;
>>>> +	case 0xFE:
>>>> +		res = -EOPNOTSUPP;
>>>> +		break;
>>>> +	case 0xFD:
>>>> +		res = -EIO;
>>>> +		break;
>>>> +	case 0xFC:
>>>> +		res = -EBUSY;
>>>> +		break;
>>>> +	case 0xFB:
>>>> +		res = -EIO;
>>>> +		break;
>>>> +	default:
>>>> +		res = -EIO;
>>>> +		break;
>>>>  	}
>>>>
>>>> +	return res;
>>>> +}
>>>> +
>>>> +static void __smu_cmn_send_msg(struct smu_context *smu,
>>>> +			       u16 msg,
>>>> +			       u32 param)
>>>> +{
>>>> +	struct amdgpu_device *adev = smu->adev;
>>>> +
>>>>  	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
>>>>  	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
>>>>  	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
>>>> +}
>>>>
>>>> -	return 0;
>>>> +int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>>>> +				     uint16_t msg_index,
>>>> +				     uint32_t param)
>>>> +{
>>>> +	u32 reg;
>>>> +	int res;
>>>> +
>>>> +	if (smu->adev->in_pci_err_recovery)
>>>> +		return 0;
>>>> +
>>>> +	mutex_lock(&smu->message_lock);
>>>> +	reg = __smu_cmn_poll_stat(smu);
>>>> +	if (reg == 0 || reg == 0xFC) {
>>>> +		res = __smu_cmn_reg2errno(smu, reg);
>>>> +		goto Out;
>>>> +	}
>>>> +	__smu_cmn_send_msg(smu, msg_index, param);
>>>> +	res = 0;
>>>> +Out:
>>>> +	mutex_unlock(&smu->message_lock);
>>>> +	return res;
>>>> +}
>>>> +
>>>> +int smu_cmn_wait_for_response(struct smu_context *smu) {
>>>> +	u32 reg;
>>>> +
>>>> +	reg = __smu_cmn_poll_stat(smu);
>>>> +	return __smu_cmn_reg2errno(smu, reg);
>>>>  }
>>>>
>>>>  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>> @@
>>>> -123,8 +238,8 @@ int smu_cmn_send_smc_msg_with_param(struct
>>>> smu_context *smu,
>>>>  				    uint32_t param,
>>>>  				    uint32_t *read_arg)
>>>>  {
>>>> -	struct amdgpu_device *adev = smu->adev;
>>>> -	int ret = 0, index = 0;
>>>> +	int res, index;
>>>> +	u32 reg;
>>>>
>>>>  	if (smu->adev->in_pci_err_recovery)
>>>>  		return 0;
>>>> @@ -136,31 +251,20 @@ int
>> smu_cmn_send_smc_msg_with_param(struct
>>>> smu_context *smu,
>>>>  		return index == -EACCES ? 0 : index;
>>>>
>>>>  	mutex_lock(&smu->message_lock);
>>>> -	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
>>>> param);
>>>> -	if (ret)
>>>> -		goto out;
>>>> -
>>>> -	ret = smu_cmn_wait_for_response(smu);
>>>> -	if (ret != 0x1) {
>>>> -		if (ret == -ETIME) {
>>>> -			dev_err(adev->dev, "message: %15s (%d) \tparam:
>>>> 0x%08x is timeout (no response)\n",
>>>> -				smu_get_message_name(smu, msg), index,
>>>> param);
>>>> -		} else {
>>>> -			dev_err(adev->dev, "failed send message: %15s (%d)
>>>> \tparam: 0x%08x response %#x\n",
>>>> -				smu_get_message_name(smu, msg), index,
>>>> param,
>>>> -				ret);
>>>> -			ret = -EIO;
>>>> -		}
>>>> -		goto out;
>>>> +	reg = __smu_cmn_poll_stat(smu);
>>>> +	if (reg == 0 || reg == 0xFC) {
>>>> +		res = __smu_cmn_reg2errno(smu, reg);
>>>> +		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>>>> +		goto Out;
>>>>  	}
>>>> -
>>>> +	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>>>> +	reg = __smu_cmn_poll_stat(smu);
>>>> +	res = __smu_cmn_reg2errno(smu, reg);
>>>>  	if (read_arg)
>>>>  		smu_cmn_read_arg(smu, read_arg);
>>>> -
>>>> -	ret = 0; /* 0 as driver return value */
>>>> -out:
>>>> +Out:
>>>>  	mutex_unlock(&smu->message_lock);
>>>> -	return ret;
>>>> +	return res;
>>>>  }
>>>>
>>>>  int smu_cmn_send_smc_msg(struct smu_context *smu, diff --git
>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>> index 9add5f16ff562a..16993daa2ae042 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>> @@ -27,7 +27,8 @@
>>>>
>>>>  #if defined(SWSMU_CODE_LAYER_L2) ||
>> defined(SWSMU_CODE_LAYER_L3)
>>>> || defined(SWSMU_CODE_LAYER_L4)
>>>>  int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>>>> -				     uint16_t msg, uint32_t param);
>>>> +				     uint16_t msg_index,
>>>> +				     uint32_t param);
>>>>  int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>>>>  				    enum smu_message_type msg,
>>>>  				    uint32_t param,
>>>> --
>>>> 2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
