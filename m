Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4115DC77B6F
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 09:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25B610E1B7;
	Tue, 11 Apr 2023 09:38:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A49910E1DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 09:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/gIdlMLbTFVOcqvVZtQToC67XvyBaIIa9RuCdbwBkz5v9F4nEMOxaP/fPXLTwyaQm61i8lDuQi51hT/eovAl+OeqPCsWyEySTrXXWQeb6L3KtiXaooLnWQ2jF6zBabJ5ZrmObS2/83y2qiHvXutEjtQ3RIAKbmBYdyAoTxh7mQ6QHHMIvw9iQOGYnHsgW5O8EG1q+fZ5iJQVHPxsj8i2mc5xYtBlsfJkmrT/lKTyB5JtIwBvvvcn5jsKV0WVWx1iPjNZWsPEcaHjbQM7G2Z8bItb+9M1ESxe5R0taXa37a1SQKVoymxbJYLOTVcZpiddkZQpNo4eDM4+L/hEWfb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5T5Hp8E6cUzOKkzlbFBoUwqluAIZFk4BvgkYBJNEcs=;
 b=EPQbKQrCKKXR6wh5dxNiGmEMoR6BtS6LdnnvwPFi6S6JywP9yhcbYxaZDBcfvD71LQcxdQGRYyHllmwi3azX7IhXjQme6wXkUlxFAYMJg3Uaf0nJ9C6BuVaSMMYyYumPm6EDqkAPiouHVF+PadAEpqvL9hGIeHJ6iDkNLAnaFywOyeNKDNSTfbifv8leWLcqfgsC8bo7nkSkTCN74Etz5K0QLXpohDvhuMAj6jEbEULhrR7qWovesuwBH9nFR8JSFxFbVgr8PF+DDIQqXixtuwMO2iKD1moH/lVOsiAwB6ZShoSikX24SKWsz7CjOSmMDL1rOQvmwFl+nyWWIZvs1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5T5Hp8E6cUzOKkzlbFBoUwqluAIZFk4BvgkYBJNEcs=;
 b=0nCvxYkXsFjZyECaC99Pq6GTp2gnYQ6Hw+30v7xdy+sXArYc3/fcvMuLHNmPWhgY4djFvpV/9dCtNDmU8pQ3VMNpE2pB7koqUcc2/F8VWNbmDtkpboFoXGDVzJ5axCRXn0Uh2vDbeinGJP8HZGGaf7D1BA6RrPmizItUJVVn5gs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 09:38:05 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 09:38:05 +0000
Message-ID: <e144baff-847b-9c59-6792-ff3c6167d19d@amd.com>
Date: Tue, 11 Apr 2023 11:37:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <CAP+8YyFgbru=1HkLo1Kfm1jKPrk5sXenUmmkzzysWbSh05q2tg@mail.gmail.com>
 <MW4PR12MB5667D4837CFDEE7230F5423DF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
 <CAP+8YyGthhzm6291=jiydsNgK3suGdi4cMM7GMhTW_j3mdgCgQ@mail.gmail.com>
 <MW4PR12MB5667EC2D2E57FDDE93EE546FF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
 <CAP+8YyH9GsyiUPvyeHfgG=TOOywxA42vubsYPWB9mPiexHBG_A@mail.gmail.com>
 <07322367-bbf1-cf82-0a21-15d453fe4dae@amd.com>
 <CAP+8YyEDW7JNQ1C9j0NZqXuLAnXPduSAye7esSOOwPpLNT9yYA@mail.gmail.com>
 <bc5752cd-fe72-a72d-4f35-92bcfdbe289c@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <bc5752cd-fe72-a72d-4f35-92bcfdbe289c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH2PR12MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f47bcc-3d4a-44dd-c99d-08db3a707391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiRAJyhbPyUXpVnFCvTly1fh7GUS0Yk124+JrlkxR+FHWbSdad//3qj+Ux1kMJLBbUKBb9m9nboGSkQyjrwhbZwH/Oe5647sOnclKVjtR4Rj3997JenkpVpMnvAuxqKUlv4a1clZPv8+ExJH+3fwWUikjjaxFnIumfdhqcRV50SypiOVH6EGz5UFce+pVXXFpd4bW0cQ7PTV1SQXWS3eXK6C/Qb0U6UuImiN2yZ+4H5qB7DFNOWSOqfAI6Q2pJJ7TvpTroElzKmCkLO4IF1Al7HbTU7IDvhj2U8AAY0Kwxd+TjFAaiXdzqbJRhCXzn+36nM1Ts8RhEW6FnXRUlr7BEdqIMnMK33TL9GK+pHmUjLwjdF8A64S3kaPt5v8eLn9yvp84aq7B8mPBsAsoQcjHRTSOwjlRkh++dWRj1CLZlYjFDOUujjB/PPbyw3VffIcnv7JM/ZfN306KLeYHdqN5LD0qwjRk1OXeCJGTy4+DqGWC/rc7iN5/EPI48U7p2iPbY5k8AsA9aDX0fp2lMbKkItwhFcFzcekNQZ2aH75oxpdq3dCCviAyuy8164T92uynMrdcw9EtAN+L+twRXuHgEXrxHI9aJoLi9o1UuZX8PWBBKMc7jpAWwgBuCvayqiq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199021)(41300700001)(38100700002)(186003)(2616005)(83380400001)(110136005)(54906003)(478600001)(66476007)(66556008)(66946007)(4326008)(8676002)(316002)(2906002)(86362001)(36756003)(6506007)(6512007)(53546011)(26005)(6666004)(31696002)(6486002)(966005)(5660300002)(8936002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEgvQk16ZTErUGROYzFDazRLOTZWSlVIKzh4VTMwWVE5dHI1SjJYbUV6TEMy?=
 =?utf-8?B?U25pcUVleUFEMm9aTlVCc09yRWhrUWV2bEhhMVAvUXVJZjBmekFwdHdxMmo1?=
 =?utf-8?B?OHEvQnRFVmZkMVh0ekh3ajFTbTIyM2lQQmthSXlmZytmQjVUdERHN0VwZU81?=
 =?utf-8?B?ODJiY09Ca1R0ZGlOaDEyTkRpTHZiVVBzZFl1ejU5ZzVBM0lOTkNLVGRDellu?=
 =?utf-8?B?a09lenlNNEtmZ245RWUzUFRJcmNPNUt2dW5wOUVQOWp1TXR6T2RXY0JCajgr?=
 =?utf-8?B?MXFKZitBOG1kM0t3eHZRdDQ4UXIydTJQS0t6MlBJRjZCV0hlMnN0WmtlTVJh?=
 =?utf-8?B?ekVrRzl1YnJYaG0yWUoycWd0YXRlVkZLRlhJREhMS0tPUThPN1ZaUFA5eldr?=
 =?utf-8?B?d0R6ZlFldnFLUHVFOEdEM3RhK250VGw4endSUG9nbS9sV041VlhndWxybUND?=
 =?utf-8?B?NUo1QVZ5V3FNZElacU8xcldVc0RQZFNlU1lvTUF1eGF1Vy9YU0xQRjlTOWho?=
 =?utf-8?B?NExoYmYzeHh6cHd2SmxWdThBOHd3WVZ3bEt4Q0lBbnZrSjMraXZlT3RwTUpR?=
 =?utf-8?B?Uk11S3NzMHprSHJpVWIzNGxJbFU2Vm5qc3VkU1hQek5uUmRUUE5rY0R1RzRW?=
 =?utf-8?B?SGF4SkFWam1qWUhQMVg5dXdBdjRzWUQyclVSNEdyaGVpejRzdHN0Qld2ME0y?=
 =?utf-8?B?b004UHhLdjJtSEZzYzQvVnl1Y05zM2dIV0hlbHR5VVlYZWcrTnlzcXQxS09X?=
 =?utf-8?B?bE4zS2JrbFd6V0lWSWN4by9aM1l5bFNjajFvWU9rR0I2K0FQSVhEL2hZYnhy?=
 =?utf-8?B?NWl0cW9NS3dONXUzZmFtNGVSdzByZVR4SGMyVTRYQXY5dUFKOUF3eUtHNHhL?=
 =?utf-8?B?cnBxd2tLdlVBQTVGSWlQSXpQaHVvTGt6S0tiNzlmSkZQdXVwWm5tWEFEeHcw?=
 =?utf-8?B?Q0pXTDAvOVArR2I4dm94bFdteExXNnIvMW9rWCtBODNMZVpobE9GYWRmNUtU?=
 =?utf-8?B?bTd0YVpwbFRNY3E4V0cycHpFYmR2MHpsbHVtUzJkYjVMK3dVeVFWVnVSWWxu?=
 =?utf-8?B?WnF5T0FJcitNUkpzTUF4WEZWTk9pUWdSNlRXYnpLRmQzMHo1MXlpRW4wdklD?=
 =?utf-8?B?bFIyTFp5dzFyQ3U0c2Y4ajdwRWJNem05bDNXZE4vZjA1OUlydzlFbDVJbUdN?=
 =?utf-8?B?QTM1Z2VhUnZ6eDc1a3Z6NUJNY3lJcjVHMVlRMzRYajVrWGlPajNJcFZJQXJa?=
 =?utf-8?B?ZDhHUUhlREtqakE3SXJ4bkhrNHBLOEsyUmpqSWFJTEM5a1hXT2x3eW5qWHFT?=
 =?utf-8?B?cUJvKzRxZkZPczI1b2FVaUVEWDFUOTEvN01kZGY1bnNiRks3c0JsTU0vZmNo?=
 =?utf-8?B?alVtMThLRkF3ang3amV3MjhtVkFyTkZwa1Y1ZVNHY2orNmZzdzVFdDZOUlk2?=
 =?utf-8?B?N3VMNnBiNTdNODR3dkNxSmpIRDJuR0pzVElha0tQOHExeWRpYi9LNkhFUTVF?=
 =?utf-8?B?K0ZlSnlwQVRjVHdwSkNrU1NZUjQvQnd1UHVjS3ZhN2g2dGdYZFJCd28wOURP?=
 =?utf-8?B?eW1LZEdMZVA4WGxsMHpDVjNRTThMYzRsR2xWS2pjVnM0YWFxczhQOXAyWGY2?=
 =?utf-8?B?N1VWUXowTlRPTjNMTnRKTVd1MFo1a295TlliNVlmV3NuZjF0TURGTW9ncllQ?=
 =?utf-8?B?cGRGa0dPTHo0N0ZVNGI4c2phRkdSR3AxcytuS2o3UFRWTHdoOUpabXEzUnpm?=
 =?utf-8?B?dXQvOWFXY2crQU1tTzVjeVdCVUV6V2ovRkc5cnNkR1dqcW51Q2hOZlZFZ2Jo?=
 =?utf-8?B?L1NDZjZiR3NjNVlVb1pQWDNqMlpCblhZTVF1K1hVZU9Gc0o5bjJCQXh6SGZM?=
 =?utf-8?B?d1Q4dXZtTFBpbExWcDdtTnlwb3dGWUJkR2dQNnNCQUdZQ3lHcHZENFo0VFp1?=
 =?utf-8?B?WXlYZlZUanlmMVIrdVo0THZOOWVyZ2N2NWtoWmRSNUJ4b1l4R1p5d29ORVJi?=
 =?utf-8?B?OTNPL2JPTGxGSFRBUFM0cUF3Z3U0MUFYZTFoemQrVGw4YmZjRzAzVEMzUUpl?=
 =?utf-8?B?d3RCVktWRHNIS3R0ZkRkNXZ2RFlzUnA1VjVoTUh4MXk4dlQrazNWdFBzOXpW?=
 =?utf-8?Q?tnznHLcuBjpCZJbupDcxIk0sr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f47bcc-3d4a-44dd-c99d-08db3a707391
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 09:38:05.5116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eHGSPdDpZBPN5HlbyAobtBHR47VpWzK7MCWZdb23TOuoSD5NhJh28LfySOKKn97
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yadav, Arvind" <Arvind.Yadav@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.04.23 um 16:26 schrieb Shashank Sharma:
>
> On 10/04/2023 16:04, Bas Nieuwenhuizen wrote:
>> On Mon, Apr 10, 2023 at 4:01 PM Shashank Sharma 
>> <shashank.sharma@amd.com> wrote:
>>>
>>> On 10/04/2023 15:46, Bas Nieuwenhuizen wrote:
>>>> On Mon, Apr 10, 2023 at 3:40 PM Sharma, Shashank
>>>> <Shashank.Sharma@amd.com> wrote:
>>>>> [AMD Official Use Only - General]
>>>>>
>>>>> Hello Bas,
>>>>>
>>>>> This is not the correct interpretation of the code, the 
>>>>> USERQ_IOCTL has both the OPs (create and destroy), but th euser 
>>>>> has to exclusively call  it.
>>>>>
>>>>> Please see the sample test program in the existing libDRM series 
>>>>> (userq_test.c, it specifically calls amdgpu_free_userq, which does 
>>>>> the destroy_OP
>>>>>
>>>>> for the IOCTL.
>>>> In the presence of crashes the kernel should always be able to clean
>>>> this up no? Otherwise there is a resource leak?
>>> The crash handling is the same as any of the existing GPU resource 
>>> which
>>> are allocated and freed with IOCTL_OPs.
>> Most of those are handled in the when the DRM fd gets closed (i.e.
>> when the process exits):
>>
>> - buffers through drm_gem_release()
>> - mappings in amdgpu_vm_fini
>> - contexts in amdgpu_ctx_mgr_fini
>>
>> etc.
>>
>> Why would we do things differently for userspace queues? It doesn't
>> look complicated looking at the above patch (which does seem to work).
>
> As the code is in initial stage, I have not given much thoughts about 
> handling resource leak due to app crash, but this seems like a good 
> suggestion.
>
> I am taking a note and will try to accommodate this in an upcoming 
> version of the series.

Bas is right, the application doesn't necessary needs to clean up on 
exit (but it's still good custody to do so).

See amdgpu_driver_postclose_kms() for how we cleanup (for example) the 
ctx manager by calling amdgpu_ctx_mgr_fini() or the BO lists.

Regards,
Christian.

>
> - Shashank
>
>>> To be honest a crash handling can be very elaborated and complex one,
>>> and hence only can be done at the driver unload IMO, which doesn't help
>>> at that stage,
>>>
>>> coz anyways driver will re-allocate the resources on next load.
>>>
>>> - Shashank
>>>
>>>>> - Shashank
>>>>>
>>>>> -----Original Message-----
>>>>> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>>>> Sent: 10 April 2023 11:26
>>>>> To: Sharma, Shashank <Shashank.Sharma@amd.com>
>>>>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander 
>>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix 
>>>>> <Felix.Kuehling@amd.com>; Koenig, Christian 
>>>>> <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>
>>>>> Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
>>>>>
>>>>> Hi Shashank,
>>>>>
>>>>> I think I found the issue: I wasn't destroying the user queue in 
>>>>> my program and the kernel doesn't clean up any remaining user 
>>>>> queues in the postclose hook. I think we need something like
>>>>> https://github.com/BNieuwenhuizen/linux/commit/e90c8d1185da7353c12837973ceddf55ccc85d29 
>>>>>
>>>>> ?
>>>>>
>>>>> While running things multiple times now works, I still have 
>>>>> problems doing multiple submissions from the same queue. Looking 
>>>>> forward to the updated test/sample
>>>>>
>>>>> Thanks,
>>>>> Bas
>>>>>
>>>>> On Mon, Apr 10, 2023 at 9:32 AM Sharma, Shashank 
>>>>> <Shashank.Sharma@amd.com> wrote:
>>>>>> [AMD Official Use Only - General]
>>>>>>
>>>>>> Hello Bas,
>>>>>> Thanks for trying this out.
>>>>>>
>>>>>> This could be due to the doorbell as you mentioned, Usermode 
>>>>>> queue uses doorbell manager internally.
>>>>>> This week, we are planning to publis the latest libDRM sample 
>>>>>> code which uses a doorbell object (instead of the doorbell hack 
>>>>>> IOCTL), adapting to that should fix your problem in my opinion.
>>>>>> We have tested this full stack (libDRM test + Usermode queue + 
>>>>>> doorbell manager) for 500+ consecutive runs, and it worked well 
>>>>>> for us.
>>>>>>
>>>>>> You can use this integrated kernel stack (1+2) from my gitlab to 
>>>>>> build
>>>>>> your kernel:
>>>>>> https://gitlab.freedesktop.org/contactshashanksharma/userq-amdgpu/-/tr 
>>>>>>
>>>>>> ee/integrated-db-and-uq-v3 Please stay tuned for updated libDRM
>>>>>> changes with doorbell objects.
>>>>>>
>>>>>> Regards
>>>>>> Shashank
>>>>>> -----Original Message-----
>>>>>> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>>>>> Sent: 10 April 2023 02:37
>>>>>> To: Sharma, Shashank <Shashank.Sharma@amd.com>
>>>>>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
>>>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix 
>>>>>> <Felix.Kuehling@amd.com>;
>>>>>> Koenig, Christian <Christian.Koenig@amd.com>
>>>>>> Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
>>>>>>
>>>>>> Hi Shashank,
>>>>>>
>>>>>> I tried writing a program to experiment with usermode queues and 
>>>>>> I found some weird behavior: The first run of the program works 
>>>>>> as expected, while subsequent runs don't seem to do anything (and 
>>>>>> I allocate everything in GTT, so it should be zero initialized 
>>>>>> consistently). Is this a known issue?
>>>>>>
>>>>>> The linked libdrm code for the uapi still does a doorbell ioctl 
>>>>>> so it could very well be that I do the doorbell wrong (especially 
>>>>>> since the ioctl implementation was never shared AFAICT?), but it 
>>>>>> seems like the kernel submissions (i.e. write wptr in dwords to 
>>>>>> the wptr va and to the doorbell). Is it possible to update the 
>>>>>> test in libdrm?
>>>>>>
>>>>>> Code: https://gitlab.freedesktop.org/bnieuwenhuizen/usermode-queue
>>>>>>
>>>>>> Thanks,
>>>>>> Bas
>>>>>>
>>>>>> On Wed, Mar 29, 2023 at 6:05 PM Shashank Sharma 
>>>>>> <shashank.sharma@amd.com> wrote:
>>>>>>> This patch series introduces AMDGPU usermode queues for gfx 
>>>>>>> workloads.
>>>>>>> Usermode queues is a method of GPU workload submission into the
>>>>>>> graphics hardware without any interaction with kernel/DRM 
>>>>>>> schedulers.
>>>>>>> In this method, a userspace graphics application can create its own
>>>>>>> workqueue and submit it directly in the GPU HW.
>>>>>>>
>>>>>>> The general idea of how this is supposed to work:
>>>>>>> - The application creates the following GPU objetcs:
>>>>>>>     - A queue object to hold the workload packets.
>>>>>>>     - A read pointer object.
>>>>>>>     - A write pointer object.
>>>>>>>     - A doorbell page.
>>>>>>> - The application picks a 32-bit offset in the doorbell page for 
>>>>>>> this queue.
>>>>>>> - The application uses the usermode_queue_create IOCTL 
>>>>>>> introduced in
>>>>>>>     this patch, by passing the the GPU addresses of these 
>>>>>>> objects (read
>>>>>>>     ptr, write ptr, queue base address and 32-bit doorbell 
>>>>>>> offset from
>>>>>>>     the doorbell page)
>>>>>>> - The kernel creates the queue and maps it in the HW.
>>>>>>> - The application can start submitting the data in the queue as 
>>>>>>> soon as
>>>>>>>     the kernel IOCTL returns.
>>>>>>> - After filling the workload data in the queue, the app must 
>>>>>>> write the
>>>>>>>     number of dwords added in the queue into the doorbell 
>>>>>>> offset, and the
>>>>>>>     GPU will start fetching the data.
>>>>>>>
>>>>>>> libDRM changes for this series and a sample DRM test program can be
>>>>>>> found in the MESA merge request here:
>>>>>>> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287
>>>>>>>
>>>>>>> This patch series depends on the doorbell-manager changes, which 
>>>>>>> are
>>>>>>> being reviewed here:
>>>>>>> https://patchwork.freedesktop.org/series/115802/
>>>>>>>
>>>>>>> Alex Deucher (1):
>>>>>>>     drm/amdgpu: UAPI for user queue management
>>>>>>>
>>>>>>> Arvind Yadav (2):
>>>>>>>     drm/amdgpu: add new parameters in v11_struct
>>>>>>>     drm/amdgpu: map wptr BO into GART
>>>>>>>
>>>>>>> Shashank Sharma (6):
>>>>>>>     drm/amdgpu: add usermode queue base code
>>>>>>>     drm/amdgpu: add new IOCTL for usermode queue
>>>>>>>     drm/amdgpu: create GFX-gen11 MQD for userqueue
>>>>>>>     drm/amdgpu: create context space for usermode queue
>>>>>>>     drm/amdgpu: map usermode queue into MES
>>>>>>>     drm/amdgpu: generate doorbell index for userqueue
>>>>>>>
>>>>>>>    drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  10 +-
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   6 +
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 298
>>>>>>> ++++++++++++++++++ .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c |
>>>>>>> ++++++++++++++++++ 230 ++++++++++++++
>>>>>>>    .../gpu/drm/amd/include/amdgpu_userqueue.h    |  66 ++++
>>>>>>>    drivers/gpu/drm/amd/include/v11_structs.h     |  16 +-
>>>>>>>    include/uapi/drm/amdgpu_drm.h                 |  55 ++++
>>>>>>>    9 files changed, 677 insertions(+), 9 deletions(-) create mode
>>>>>>> 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>>    create mode 100644
>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>>>>    create mode 100644 
>>>>>>> drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>>>
>>>>>>> -- 
>>>>>>> 2.40.0
>>>>>>>

