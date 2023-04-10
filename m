Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1C6C76196
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 14:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 784E210E085;
	Mon, 10 Apr 2023 14:01:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E68510E358
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 14:01:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLcXU1O3qTICZL/uPF0QLtFrKMrtesgbpoCgov8KAL1taEqZ2NlGwlFHtzQgwUja3Z/q6G6qNhGMv484Wur7eLSnlTIaBflZOBCt50m2m9IYYVysfJ8rcq2nrAlTEx2/lOuV62NGWO9kVimWE1b2a8HrM59Q1t07z236QzQR6JooEvDGZMuXdwt0tHgly9kHLOsYo9vuKf7u0X5Cdsil6oIyPdcAEXxEByerDx4oALhPZCMc9wTWQvQqVqvY6L3OtegJmjB0+1lcwOC4dIdS41lbD4wWhwXMU3So89VATqBXHQjRQkOJzwZjfNE/GkN6F90QjmliFRLWERy07UldzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tod8DPOi36mDbzT29kwGSWzoD5F6+V8EsDoiC+0zIPA=;
 b=WmPi9fndQ2TiwFlqP/SYBWqY9uNOIvcQXsmnyaDFW0bl6h35FKhqwZX0L72hL/N1KhzwAxKJ7xZdJ2e/UYJYSyeB20PL+Te0xh2TGm7M1X9uRmnDDe0uYRld+Pyep96MjHmFSV8aV59NizMJGaGaXOLyOcEqff0B+4LeF/5+V3xgp83Nd008pk3Ema5uuVNj9MrU4c3B6lPYTQEiDksvwH13H9ISwCLRJZhN7gNhEfUCpQBe3HFsLf+f4r6H3NJs24uMhAB1x5alhcklRQoxABN8gSgiKwHsLwzmNW1GgOVEXCz7LS4aoFymCdXMfbd7TD7oj4ZjkmdA0205SqsqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tod8DPOi36mDbzT29kwGSWzoD5F6+V8EsDoiC+0zIPA=;
 b=CZRMP1ToSPvdJrzbf7Ly2nij1tqMJCJHgBxhSbo+EzVXVcLuVCkRGuvmqfqsSlvo6IrhcvRiDjalNkAkpL4LmZGznL+hZLJHISiMF/Odb2nsfAMklIADPbLLp+vWEKINUk1ro4RuXpAFxboMiC4Cwy3yyMocWbNiIBnzI2jicAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 14:01:50 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 14:01:50 +0000
Message-ID: <07322367-bbf1-cf82-0a21-15d453fe4dae@amd.com>
Date: Mon, 10 Apr 2023 16:01:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <CAP+8YyFgbru=1HkLo1Kfm1jKPrk5sXenUmmkzzysWbSh05q2tg@mail.gmail.com>
 <MW4PR12MB5667D4837CFDEE7230F5423DF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
 <CAP+8YyGthhzm6291=jiydsNgK3suGdi4cMM7GMhTW_j3mdgCgQ@mail.gmail.com>
 <MW4PR12MB5667EC2D2E57FDDE93EE546FF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
 <CAP+8YyH9GsyiUPvyeHfgG=TOOywxA42vubsYPWB9mPiexHBG_A@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CAP+8YyH9GsyiUPvyeHfgG=TOOywxA42vubsYPWB9mPiexHBG_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::23) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 53552045-e14c-4c3d-68a0-08db39cc213f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAB6AxrU5Q1xyVPX3RlokBHHlzF9/zj4743WFoykhDyUCobTFQFbH2iAn8xcqTTK/ZrTUPbVtry/2Njsu7gHQSylt4jZFaxj8+kXbPG9iZBw/UfZprtWdl7jFAcVYDYi0awqc5MhHu63aK4nojndSx3Afrxn7KqAB4hZU6lJSDCyBI82mFAbBjB1LiUoBmVG3kz+/n83VqF8Q0j+zjN/HRVWY8dTSjcmEmwLIcC5ArpnacCiXOlNG+MiorYo9VNHXw0XbMJgE0SHJHAwwiK/aviBU1WABnVIyRJg2maVOHWsoMqfWABJkOOCmaGfd09dG6SGklks0aZLNaQc1OGFXN1Xv6a1GhVfT51N45KRI+ELNH8J5I8zvdx+sqRBg6KWsSda0at0v3DS19trSWNYaF24cc51F++yk7KWwFzHwzM79NUN3lYcBXArOoMVh/SoekSmqzq/RUIYI9rsUkyyY2H0Yo/0ILooi0juD7PIeHbe70QhjSNB1ufprg1fn94LOqlntwF0pWF4/hqbZt7vi9kFRLmgThQCfzpUVTseXGfQjjhZFhDPD2CZ3qsBGnzaMwfrangmMQkxsIXStw/1VVunAt1o/QEkQgBpwufmNW7zG2X/L9bMHaVXQRNsnwC/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199021)(478600001)(316002)(54906003)(53546011)(6512007)(6506007)(26005)(186003)(6486002)(966005)(6666004)(2906002)(44832011)(66556008)(4326008)(66946007)(41300700001)(8936002)(6916009)(5660300002)(66476007)(8676002)(38100700002)(86362001)(31696002)(36756003)(83380400001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTNoRy9Pb2ZCM1FVTllFbnFaeVVHYkt5dWdGTFIxRHFPd0VJUkJjOUh3V1NG?=
 =?utf-8?B?emdsQWhaTll6Qy9LaUtqeXlJQ0hxWGhNRklGWnJBVzZhR1EyQ08rODBzV2Z0?=
 =?utf-8?B?UGgxeWY4K0tvQ0VRVWhDRFBHLyt1b1gyOHllcUpOdDRtdXoyR25SUC9FdVR5?=
 =?utf-8?B?VkNWZ3FQYWg2dEhSMUJRRXdSV2w2ZUN2VnQwdGpKSTJxVW1RVkZhb2MwUm14?=
 =?utf-8?B?dm5YSUxrelNxYWhuTVpiNTBLYzNTaXcxc2crU0VHL1lRWWpnTWczMWxTZmh6?=
 =?utf-8?B?RzRWdWhwUmhheUpEVDF3aVkrN0srZ3k0clRSOW1yNk1KYS9lbEEwM0hkbDNK?=
 =?utf-8?B?U2hoWm9ZVEhyM0pLdlZQTjQwRlJSeTM1Vjh4TlU1YnExQzU3eDQ2VTB6cU5w?=
 =?utf-8?B?ZDZCVkk5Q01PSG50dUlRYkVOVkxVb004SFAvMVdxUVhSVUdjMnRhd1ZYQ1RR?=
 =?utf-8?B?d3JvYzVMbTFyZkM3SGsyNExZSUhsVnp3QSs4NlAvaFpFRmZpcVUzaG9xejA1?=
 =?utf-8?B?Z1VMbTZ3WUNlNlNmTk1WbjU2bEFlRHkxWjhoMUVocDJ2K2tZdEtvVXBPb09U?=
 =?utf-8?B?dTNsQmZmL3JFOEFEYXZOb081TTdFcUVzRmpOSXJWWE9YRjhlZHRQUWtnN3Jo?=
 =?utf-8?B?RmFIUEphWjh1VkFDaC9oRUxmdnNCNGRUSGZpTUR2Q3pzZ0Y1UVAydEQxYktU?=
 =?utf-8?B?V0lpUm4wWHFrd2JmYVpsZGZLdUhNTXpCcU5ZcWhtVUt3cUR0MWZLM0lTVkts?=
 =?utf-8?B?WG96TVhkZmlzckpMWFluNnhCU2tnRlcvWHhNanhHT1QyZnRzcjhFUFlaQVBj?=
 =?utf-8?B?SUVXRFlrREhISHF4T0lKWURHUDh2U2tjNTl6QjB2ZlZMV0dvOHIrY1dEcm5Q?=
 =?utf-8?B?NjVodFhkcUM2ekR2YkMzSTA0bk53Z3UydlNCYzhyRGsyL2RSYUNMWDd5Z3Y5?=
 =?utf-8?B?QjJOSUM0akhYUDBLdGx1aFBmYmtMbEFzVTl3SXFDMXU4Y0FSZ3k4ZWNXSTF3?=
 =?utf-8?B?RGxXdktIV2NGcEtzcWlFajJDT3BxTTlPS0FRbm1rRldqQkk0Sm9kL203MUtr?=
 =?utf-8?B?Zlh3M0RTOWlzeDNUQk1GK2R0QVQrNmY4YjdSd2RVSnA1SmtiQm1ETkhWTHR1?=
 =?utf-8?B?MUw4Ym9oMGlWcnhnLzVkdU9nWS9JTXdIdEd4RWc1YStrM0pLNnZhZ1Q5SDQ1?=
 =?utf-8?B?S3QvMGRwMnM0NWt4QjJHNlpHU2FRWWlpbFZEQ3MvQ0FiOEhEekxZQ3RJeC9r?=
 =?utf-8?B?TllXQ3V2N1ZVdEgwQlhrZEM1dy9yK3hjY2RYUGFGcmR4QkZDbzIvdUdrQVpZ?=
 =?utf-8?B?a1QyMEVoU1E1NEhHZnA4T3R5VVF1a0VTT1ZFZDRCNHpPRlE4aStJanpGMmM3?=
 =?utf-8?B?cmU1YTVUWFZ0R0V6WG92MkYrUzBXdm5OekZIL2x5aHZZNlNLWXJZeitkZEx1?=
 =?utf-8?B?UC81bHNUQ2t1OUpnTjloa1hteFVrU2xRVERWblBrWkNOTG54aTJZbDJUV0hq?=
 =?utf-8?B?b0t4T2VDdUY5L3hzUVZxM1F0ZWpROW01Z3gzSXhOMldHdXMwOGpsT0dOd0V1?=
 =?utf-8?B?Vk5UUEFOMzBmM2V3ekhKeU9FVmQ3cG1kZFRPcWVJeVB2amdhUkpkdkNTQVlP?=
 =?utf-8?B?N0UzbnU3OVdzSnpJTHpSMjhxTXUxR1VPYjBOUHhVMGVidnZrZ0FXR2szY3dF?=
 =?utf-8?B?TUhyWW1zL1V4NUhwQU9mcGlGdkxqTU1yZitrVEtxQjVvWG9lNFZZeUVHVGFO?=
 =?utf-8?B?aUdvUGN4YTRhTWpTM2NaOXNCZ05GWVNJTmpqU2lpZWtYaXRxWEdNUUYvS1dR?=
 =?utf-8?B?bWduMjFEemdTY1R0RFloNkIyUTA5QUt1ZC9XRnd4LzEvRlJ3K0JJZGtsWDFn?=
 =?utf-8?B?Qk43akFJaGxlZGdrYjRGYjZBT0FpZVdtVWxXc3RWc0FsamRYQTduNWhnQUY5?=
 =?utf-8?B?eVl2cEp3cUtVQ2VkQ3NRL1VmbENOcEt5aDhuQUF6N0xqMU5CcU1IQkRKckpS?=
 =?utf-8?B?TmZsajNiMnhCa3BpcWFHRmtRYnBxeTJMT1M2RHMzaVFrTi9PV05zV255NWVJ?=
 =?utf-8?B?cFd1YnlMVDR2b3pWc3MxNnFlRUQ3a1h2dDBjeVdrYVNNd01IWjVuTHNtKzJv?=
 =?utf-8?Q?H9xCqNeGfy+I2mF94GbH9Q8TE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53552045-e14c-4c3d-68a0-08db39cc213f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 14:01:50.0127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NjduxZ2fMyB382pVpxTz8Y3jD6XQsI/WIEmDb7Jw46Pkt8VcmQRbJRiKm2t8aNxnXM5Gea6QS6yvc7LOJgUdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
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
 Felix" <Felix.Kuehling@amd.com>, "Yadav, Arvind" <Arvind.Yadav@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/04/2023 15:46, Bas Nieuwenhuizen wrote:
> On Mon, Apr 10, 2023 at 3:40 PM Sharma, Shashank
> <Shashank.Sharma@amd.com> wrote:
>> [AMD Official Use Only - General]
>>
>> Hello Bas,
>>
>> This is not the correct interpretation of the code, the USERQ_IOCTL has both the OPs (create and destroy), but th euser has to exclusively call  it.
>>
>> Please see the sample test program in the existing libDRM series (userq_test.c, it specifically calls amdgpu_free_userq, which does the destroy_OP
>>
>> for the IOCTL.
> In the presence of crashes the kernel should always be able to clean
> this up no? Otherwise there is a resource leak?

The crash handling is the same as any of the existing GPU resource which 
are allocated and freed with IOCTL_OPs.

To be honest a crash handling can be very elaborated and complex one, 
and hence only can be done at the driver unload IMO, which doesn't help 
at that stage,

coz anyways driver will re-allocate the resources on next load.

- Shashank

>
>> - Shashank
>>
>> -----Original Message-----
>> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> Sent: 10 April 2023 11:26
>> To: Sharma, Shashank <Shashank.Sharma@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>
>> Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
>>
>> Hi Shashank,
>>
>> I think I found the issue: I wasn't destroying the user queue in my program and the kernel doesn't clean up any remaining user queues in the postclose hook. I think we need something like
>> https://github.com/BNieuwenhuizen/linux/commit/e90c8d1185da7353c12837973ceddf55ccc85d29
>> ?
>>
>> While running things multiple times now works, I still have problems doing multiple submissions from the same queue. Looking forward to the updated test/sample
>>
>> Thanks,
>> Bas
>>
>> On Mon, Apr 10, 2023 at 9:32 AM Sharma, Shashank <Shashank.Sharma@amd.com> wrote:
>>> [AMD Official Use Only - General]
>>>
>>> Hello Bas,
>>> Thanks for trying this out.
>>>
>>> This could be due to the doorbell as you mentioned, Usermode queue uses doorbell manager internally.
>>> This week, we are planning to publis the latest libDRM sample code which uses a doorbell object (instead of the doorbell hack IOCTL), adapting to that should fix your problem in my opinion.
>>> We have tested this full stack (libDRM test + Usermode queue + doorbell manager) for 500+ consecutive runs, and it worked well for us.
>>>
>>> You can use this integrated kernel stack (1+2) from my gitlab to build
>>> your kernel:
>>> https://gitlab.freedesktop.org/contactshashanksharma/userq-amdgpu/-/tr
>>> ee/integrated-db-and-uq-v3 Please stay tuned for updated libDRM
>>> changes with doorbell objects.
>>>
>>> Regards
>>> Shashank
>>> -----Original Message-----
>>> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>> Sent: 10 April 2023 02:37
>>> To: Sharma, Shashank <Shashank.Sharma@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
>>> Koenig, Christian <Christian.Koenig@amd.com>
>>> Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
>>>
>>> Hi Shashank,
>>>
>>> I tried writing a program to experiment with usermode queues and I found some weird behavior: The first run of the program works as expected, while subsequent runs don't seem to do anything (and I allocate everything in GTT, so it should be zero initialized consistently). Is this a known issue?
>>>
>>> The linked libdrm code for the uapi still does a doorbell ioctl so it could very well be that I do the doorbell wrong (especially since the ioctl implementation was never shared AFAICT?), but it seems like the kernel submissions (i.e. write wptr in dwords to the wptr va and to the doorbell). Is it possible to update the test in libdrm?
>>>
>>> Code: https://gitlab.freedesktop.org/bnieuwenhuizen/usermode-queue
>>>
>>> Thanks,
>>> Bas
>>>
>>> On Wed, Mar 29, 2023 at 6:05 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>>> This patch series introduces AMDGPU usermode queues for gfx workloads.
>>>> Usermode queues is a method of GPU workload submission into the
>>>> graphics hardware without any interaction with kernel/DRM schedulers.
>>>> In this method, a userspace graphics application can create its own
>>>> workqueue and submit it directly in the GPU HW.
>>>>
>>>> The general idea of how this is supposed to work:
>>>> - The application creates the following GPU objetcs:
>>>>    - A queue object to hold the workload packets.
>>>>    - A read pointer object.
>>>>    - A write pointer object.
>>>>    - A doorbell page.
>>>> - The application picks a 32-bit offset in the doorbell page for this queue.
>>>> - The application uses the usermode_queue_create IOCTL introduced in
>>>>    this patch, by passing the the GPU addresses of these objects (read
>>>>    ptr, write ptr, queue base address and 32-bit doorbell offset from
>>>>    the doorbell page)
>>>> - The kernel creates the queue and maps it in the HW.
>>>> - The application can start submitting the data in the queue as soon as
>>>>    the kernel IOCTL returns.
>>>> - After filling the workload data in the queue, the app must write the
>>>>    number of dwords added in the queue into the doorbell offset, and the
>>>>    GPU will start fetching the data.
>>>>
>>>> libDRM changes for this series and a sample DRM test program can be
>>>> found in the MESA merge request here:
>>>> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287
>>>>
>>>> This patch series depends on the doorbell-manager changes, which are
>>>> being reviewed here:
>>>> https://patchwork.freedesktop.org/series/115802/
>>>>
>>>> Alex Deucher (1):
>>>>    drm/amdgpu: UAPI for user queue management
>>>>
>>>> Arvind Yadav (2):
>>>>    drm/amdgpu: add new parameters in v11_struct
>>>>    drm/amdgpu: map wptr BO into GART
>>>>
>>>> Shashank Sharma (6):
>>>>    drm/amdgpu: add usermode queue base code
>>>>    drm/amdgpu: add new IOCTL for usermode queue
>>>>    drm/amdgpu: create GFX-gen11 MQD for userqueue
>>>>    drm/amdgpu: create context space for usermode queue
>>>>    drm/amdgpu: map usermode queue into MES
>>>>    drm/amdgpu: generate doorbell index for userqueue
>>>>
>>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  10 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   6 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 298
>>>> ++++++++++++++++++  .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c |
>>>> ++++++++++++++++++ 230 ++++++++++++++
>>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  66 ++++
>>>>   drivers/gpu/drm/amd/include/v11_structs.h     |  16 +-
>>>>   include/uapi/drm/amdgpu_drm.h                 |  55 ++++
>>>>   9 files changed, 677 insertions(+), 9 deletions(-)  create mode
>>>> 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>   create mode 100644
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>
>>>> --
>>>> 2.40.0
>>>>
