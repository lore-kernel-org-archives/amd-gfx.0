Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06586C7619A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 10:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F61F10E0E7;
	Tue, 11 Apr 2023 10:55:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA57C10E0E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 10:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPVjuy0yxZ/qk1P27M66keWjrTlGT9as9t7noZyK//QcgmnrTAznAiAxWD5Q5S5HJ2LrDzTbfZAJlcYCxcsrfGwTaHOqzqJ3sJTxKWq/xvBZRG8307oCQGRtenMKnRbulfiwXdsrZWpGqdZG8TQflDHexKJ6+uF1/fWmL7HaEUaAwK1IXBiMtUU+/PqiTTnVldRVA16/57TOkPTuIXxzs+ZNGdcJw749jhrbGBs0YcZ3OfYzxyfpc9G/jldyuMN7hu/cflHyNvFw9dzWP6GFNWHgfuLxjkvlGRozkW+MKyH3pF4LxblbqQ9nkGJ1Bf7vAgA3Wiv0FA2lTKBbhyBc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lshcNrklhcLlreijJQ0iouyyr26hyhcJL2erEiVRxhY=;
 b=IEhKn3IrdrQ2CJlkRTIZqsO4pPWYxQ7a9UNz4+uhiJjMyiKiBN1GXuI2L+5LEcmZXwVsCakkpGiLKChbtaDZxwE/9dkD6HZPhNUYldpUl7qBklcIBGTUnYYwZ2RSR7pESOdXnQEb3XEiLQ2yL/BhjeB0IudH3mxUscDRtQPpRcSvc8+2TAq/NeXVfHqpMQFaiMOHOhANJYG8K2R9yWq8Pvzcf7bdbr9nBdDGri22IIwzWuihsLIm1fn9gaNDTSiZiQf0QpsZoMRQaKJysjBzBmaY7Pk5mAMeIBi2Z09jdAsldJ2d0hlZwxNjSVFvlH6FRlqu0koKZ3DSil8Ue5Pv6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lshcNrklhcLlreijJQ0iouyyr26hyhcJL2erEiVRxhY=;
 b=dReqjKQzBbOaPX4LdLsaQlRvvno1o2QrZRau5wFrHjgyZFn3OP407sG6z44nUmmFSp3WTuIJddMH9GKhBxLg0tgAbw/YPJ0qL1KmSN14bwVXEvevaYsi7ltRCYAQNYmSx2ff6CswtqUMWpD9SQz+ZnB6scvAl/F/616BK7R6jCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 10:55:25 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 10:55:25 +0000
Message-ID: <98fd63e9-6359-f76e-c65b-0a121ff327e0@amd.com>
Date: Tue, 11 Apr 2023 12:55:16 +0200
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
 <07322367-bbf1-cf82-0a21-15d453fe4dae@amd.com>
 <CAP+8YyEDW7JNQ1C9j0NZqXuLAnXPduSAye7esSOOwPpLNT9yYA@mail.gmail.com>
 <bc5752cd-fe72-a72d-4f35-92bcfdbe289c@amd.com>
 <e144baff-847b-9c59-6792-ff3c6167d19d@amd.com>
 <63178153-bd90-8b82-6fa7-241ec5b3d242@amd.com>
 <CAP+8YyF_oPCbCK2xBEU+=vXKtfTFUZvcQoX_P8fHnS+wcBJhoA@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CAP+8YyF_oPCbCK2xBEU+=vXKtfTFUZvcQoX_P8fHnS+wcBJhoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::18) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 42332b52-f0d3-46be-bf86-08db3a7b413b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lo5gOcOhA2Ty9zzHMnAjWc6fscT5LsJn26CBBV7FKHD1X+4adrpB7GsjhAwaiRVnZqC3MIXCp8USzDLyUbgPKIUzkE9dJbzNTb31IH3tHiT8gkAmxSyq6X1Z8XzCwFP6GVtXKu6MJrOjj0FnF/iOtpl9ZZwx8YaPRZXDf+GJ4oPr2LdEgwsOHo0ZQobQWmHFCkVwa8HXFZauAM+IcPj5oZjBWkIyI6C4jkjTZiotFJa8s42/q1ip191QnlPUJATqB7H2W+Q3tdaRRNp3FEHs1sgnxrrDijgVT6ZUduHlBsgL/9ro7BaS4IJP29a8+WTW5lMH9Ga2b0jTRPsMH0LbH215KRWUdNKLEffbnoFlkfSqEhTFVIuubF8uanVIGIupOIkN4+mNLZYQHk7hn2P4yOwHiHceS5vt+Eg/e2qqzyVVFIln1BBoG9xi9H4+dDjTJt96kQdBkdWdPdmCuTQjDGX6oIymtIyosiuRDcSUjt/HotshWURyF1g9PWfVnrRnycGL5DMrQO6YNW82pA2OVOU9HdVlbu7muUhnoFPuyFUQwe5H+o+nVt/PPuDiAuXf1EAisiVX7wLh9VO/k3ZR2ekAcihY5AIPqLkmdobslsOyZZ3qw5bC6Un2QSxpRvy1o6g1IrG7FV/0XjSlOtYnrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(6666004)(478600001)(6512007)(6506007)(316002)(26005)(186003)(53546011)(54906003)(6486002)(966005)(2906002)(44832011)(30864003)(5660300002)(66476007)(66946007)(66556008)(41300700001)(8676002)(4326008)(8936002)(6916009)(38100700002)(66574015)(86362001)(31696002)(36756003)(83380400001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXQwbVRlY205REVKUHJVYS92RlZrbytESUxzenBOUWZHN0FQdm5FK3FCOWE4?=
 =?utf-8?B?UmVNSmd5NTVLWXZqaG9hc25wZTRnbitCa2Q0RWhKZ2FxL3VMSmJuWjErcmtx?=
 =?utf-8?B?b2xZdVJzWGRhZmE1blkyVUZmaFFiMHlvd0pXNEZyYnd6NExhdExUMFVSRExS?=
 =?utf-8?B?enZJeTFCcE1lWjV0NnVqYTNtVEczZVZBbm9PTnUwUERvTUhiQWZhNzhNV1ZQ?=
 =?utf-8?B?VUEyOW1NTXVGVnFzMXZpUTB3RWtQSVpNQk12dFZSUHRVcmZXSWxGMWJrR0t4?=
 =?utf-8?B?ZjljNzU2SjRPTERWdUhhVFplcHMyS092VUdjTTNqYjlkSFJ0bXJGUjcyL1Nu?=
 =?utf-8?B?Nm1WaFJiMXl0eVFRa3V5U2RZQ3NISFlrY3hBR010L3BMSGpPMnNKK2UvK0Iz?=
 =?utf-8?B?K3gxMytwZ21SZmU1am9QbGpKRmR5WVl4SFI0VzE0WG83VHQ2S0pIb0JRQmxJ?=
 =?utf-8?B?Z0hZbGtlbzV0eGF4NUV6UHQxOEg1eDRsZkQwT0gwS212aWtsc2tBU0N2aGF1?=
 =?utf-8?B?am5TNzh1UnR5L0srdXFDU0RLV1Q3NngvSDhJcnN0UHpoamJaTTFYZ2lEWjVL?=
 =?utf-8?B?eE9hQWVTOHdHb29qSmxJaUUxTGpZNnh2SmZDd2dxRERMOHlVSi93OFFXS21F?=
 =?utf-8?B?SHNocDVjQ1drVlhpYlU3QXlYZ21Kd1dVZ2ZQQUFUUURIdG15cy8rMmVQMlV0?=
 =?utf-8?B?NmNpUFJXRitrT3JITUwwTlFvcDJvOVRqd3dGbkptOW4xUTNDSVpOaitZVzhw?=
 =?utf-8?B?YXplbTFPYjVsaERpb2xMOVByRGdGTC9zMU1nUDRRR2hsSWVubmNRRU01dzl4?=
 =?utf-8?B?MWNyekMyVUF2c0dMcDlkRnptNFF1WDNEMEQxK1NvWUgyRE5pY1JwWG4xSjBZ?=
 =?utf-8?B?YzN6SnhwZ21taDJ1S2pWcnVwenJ5NGZ3dSthRk1hK1hObWR3TmdtMVY2QzhR?=
 =?utf-8?B?Y3N5eG16ZnVTaWVBcDloOGRjMEc3bEEvSjhneDI5dGxlRVpZOXhsOTB6bnov?=
 =?utf-8?B?ditOSCtIWDREMk9YbUNqQWVMeUtmYk5oSjdBN0dmM2dMSm1MWGJYZjl2WDc0?=
 =?utf-8?B?WC9jdVJaU0R4Z2lvK2NVTlMydlQxRkdscjByU0FkUG02RVFTRUxPUlMvMmJF?=
 =?utf-8?B?eUVXdmhVNkl1L0l2bWxrZy9wZUtUVTQrb3FzbWFzVUFXaXpsT1JjSEhkUnY0?=
 =?utf-8?B?L0dya1FodHlBYnI0UEJyaHphbm1YaGdRMitEdkorSEZlNnJrY21ZSEZ0VlFK?=
 =?utf-8?B?aXB3cVFTaWFZZ0NEMmgwYlRncS9YeWt5cTlQb0RKY1JRMWVrYS8vRUhCdUVw?=
 =?utf-8?B?c2Y5NTRUZE1GM2tMOEtqOStYWHFwckVCdVpWenNVcWc2N2FMUkhwdGRGbjNu?=
 =?utf-8?B?NnJKNkxKZ3ZLSTRMeVdsS3g4SFJsUE9kTTFxYnQzb2g3c25hSmNHZWNKdVVt?=
 =?utf-8?B?SlBnVXA0M25BYmZaeFVHdVMzeTAzUDRsTzBEVWlSaFk1aFhLcGYvbHN1cGJu?=
 =?utf-8?B?R1FJbEtYSm9tVktBbE9DMy9wQzNwNHRGOHdBcUVNZXc0U3QrTEpxaFZMTVF5?=
 =?utf-8?B?bFBGWnEwbmErYTBwUjdUVkhodDBBblZaRkR3eSsrelFnSVV3Z3B2c0wrNldt?=
 =?utf-8?B?ZzlPWVNRbU81d3lJcVpIZittNGFYL1NmN3F3Y0FFd3pqKzFGWnZyYzNXRGVm?=
 =?utf-8?B?a0ZaTlNWZmduRk9XQXFFZVo4alpaWWdoL1c5TDVaM1N0eW1va3Q1aW8zQ3Q1?=
 =?utf-8?B?OEluZUN1WEpVaHoyVkVKeEk5TEt2TmpBazNydFpHcFlwRUFNTXd3Y0tscjBT?=
 =?utf-8?B?dkFkNEFDQXdrTWh6dzdtZUhKTHBTN0psUHRrcjBzYzJLWmszdGRSMkFsMDM5?=
 =?utf-8?B?VE1OeHk4ZVJzaEJSQk1FQ0R6N2w2Q3dTaG1KbUM1cmpKMnFnaFJRemp1Q0hm?=
 =?utf-8?B?Vmc3TVBISEhYWmdzWCtrYTJHRkQvaDd6OTNtL29vWEs3eEdrNkE2eHpja2JS?=
 =?utf-8?B?SXY4V09hYWN0MHZKeVhqMnJCV0c1WkNJRk5XL1BJZzEwVmFjVUYxS2p6cEpx?=
 =?utf-8?B?WkZ3Y1o2N2NXR1l2NndEaHdkU1RaNEFNZWcvY3FBVFNMNU80ZlpRNzVQUExR?=
 =?utf-8?Q?519rmK8sPOr39W8n1s9jqE3fR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42332b52-f0d3-46be-bf86-08db3a7b413b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 10:55:25.5830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StXBHXOlBQajHVoy5egcOXYwLhOHN8Xy/8MpIx1/xyRnCx8LFD/a7swVrKehLRCFAlT5j0NURrYRXYc9wLNiUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "Yadav,
 Arvind" <Arvind.Yadav@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 11/04/2023 12:00, Bas Nieuwenhuizen wrote:
> On Tue, Apr 11, 2023 at 11:48 AM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>>
>> On 11/04/2023 11:37, Christian König wrote:
>>> Am 10.04.23 um 16:26 schrieb Shashank Sharma:
>>>> On 10/04/2023 16:04, Bas Nieuwenhuizen wrote:
>>>>> On Mon, Apr 10, 2023 at 4:01 PM Shashank Sharma
>>>>> <shashank.sharma@amd.com> wrote:
>>>>>> On 10/04/2023 15:46, Bas Nieuwenhuizen wrote:
>>>>>>> On Mon, Apr 10, 2023 at 3:40 PM Sharma, Shashank
>>>>>>> <Shashank.Sharma@amd.com> wrote:
>>>>>>>> [AMD Official Use Only - General]
>>>>>>>>
>>>>>>>> Hello Bas,
>>>>>>>>
>>>>>>>> This is not the correct interpretation of the code, the
>>>>>>>> USERQ_IOCTL has both the OPs (create and destroy), but th euser
>>>>>>>> has to exclusively call  it.
>>>>>>>>
>>>>>>>> Please see the sample test program in the existing libDRM series
>>>>>>>> (userq_test.c, it specifically calls amdgpu_free_userq, which
>>>>>>>> does the destroy_OP
>>>>>>>>
>>>>>>>> for the IOCTL.
>>>>>>> In the presence of crashes the kernel should always be able to clean
>>>>>>> this up no? Otherwise there is a resource leak?
>>>>>> The crash handling is the same as any of the existing GPU resource
>>>>>> which
>>>>>> are allocated and freed with IOCTL_OPs.
>>>>> Most of those are handled in the when the DRM fd gets closed (i.e.
>>>>> when the process exits):
>>>>>
>>>>> - buffers through drm_gem_release()
>>>>> - mappings in amdgpu_vm_fini
>>>>> - contexts in amdgpu_ctx_mgr_fini
>>>>>
>>>>> etc.
>>>>>
>>>>> Why would we do things differently for userspace queues? It doesn't
>>>>> look complicated looking at the above patch (which does seem to work).
>>>> As the code is in initial stage, I have not given much thoughts about
>>>> handling resource leak due to app crash, but this seems like a good
>>>> suggestion.
>>>>
>>>> I am taking a note and will try to accommodate this in an upcoming
>>>> version of the series.
>>> Bas is right, the application doesn't necessary needs to clean up on
>>> exit (but it's still good custody to do so).
>>>
>>> See amdgpu_driver_postclose_kms() for how we cleanup (for example) the
>>> ctx manager by calling amdgpu_ctx_mgr_fini() or the BO lists.
>>>
>> Thanks for the pointers Christian,
>>
>> I also feel like that its good to have this cleanup for those apps which
>> did not clean-up themselves (due to crash or coding error).
> I think the patch I linked earlier does exactly this: keep the IOCTL,
> but on fini goes through the list and destroys the queue:
> https://github.com/BNieuwenhuizen/linux/commit/e90c8d1185da7353c12837973ceddf55ccc85d29

Yep, just needs additional check to free only when its not already 
freed, like doble free check. Will try to reuse most of it.

- Shashank

>> So something like,
>>
>> on close_fd,
>>
>> for_idr_each {
>>
>>      get_queue()
>>
>>      if (queue)
>>
>>          free_queue
>>
>> }
>>
>> But we will also keep the queue_free_OP as well, so that if an app
>> allocate multiple queues, and wants to free some in between, it can do it.
>>
>> - Shashank
>>
>>> Regards,
>>> Christian.
>>>
>>>> - Shashank
>>>>
>>>>>> To be honest a crash handling can be very elaborated and complex one,
>>>>>> and hence only can be done at the driver unload IMO, which doesn't
>>>>>> help
>>>>>> at that stage,
>>>>>>
>>>>>> coz anyways driver will re-allocate the resources on next load.
>>>>>>
>>>>>> - Shashank
>>>>>>
>>>>>>>> - Shashank
>>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>>>>>>> Sent: 10 April 2023 11:26
>>>>>>>> To: Sharma, Shashank <Shashank.Sharma@amd.com>
>>>>>>>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
>>>>>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix
>>>>>>>> <Felix.Kuehling@amd.com>; Koenig, Christian
>>>>>>>> <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>
>>>>>>>> Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
>>>>>>>>
>>>>>>>> Hi Shashank,
>>>>>>>>
>>>>>>>> I think I found the issue: I wasn't destroying the user queue in
>>>>>>>> my program and the kernel doesn't clean up any remaining user
>>>>>>>> queues in the postclose hook. I think we need something like
>>>>>>>> https://github.com/BNieuwenhuizen/linux/commit/e90c8d1185da7353c12837973ceddf55ccc85d29
>>>>>>>>
>>>>>>>> ?
>>>>>>>>
>>>>>>>> While running things multiple times now works, I still have
>>>>>>>> problems doing multiple submissions from the same queue. Looking
>>>>>>>> forward to the updated test/sample
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Bas
>>>>>>>>
>>>>>>>> On Mon, Apr 10, 2023 at 9:32 AM Sharma, Shashank
>>>>>>>> <Shashank.Sharma@amd.com> wrote:
>>>>>>>>> [AMD Official Use Only - General]
>>>>>>>>>
>>>>>>>>> Hello Bas,
>>>>>>>>> Thanks for trying this out.
>>>>>>>>>
>>>>>>>>> This could be due to the doorbell as you mentioned, Usermode
>>>>>>>>> queue uses doorbell manager internally.
>>>>>>>>> This week, we are planning to publis the latest libDRM sample
>>>>>>>>> code which uses a doorbell object (instead of the doorbell hack
>>>>>>>>> IOCTL), adapting to that should fix your problem in my opinion.
>>>>>>>>> We have tested this full stack (libDRM test + Usermode queue +
>>>>>>>>> doorbell manager) for 500+ consecutive runs, and it worked well
>>>>>>>>> for us.
>>>>>>>>>
>>>>>>>>> You can use this integrated kernel stack (1+2) from my gitlab to
>>>>>>>>> build
>>>>>>>>> your kernel:
>>>>>>>>> https://gitlab.freedesktop.org/contactshashanksharma/userq-amdgpu/-/tr
>>>>>>>>>
>>>>>>>>> ee/integrated-db-and-uq-v3 Please stay tuned for updated libDRM
>>>>>>>>> changes with doorbell objects.
>>>>>>>>>
>>>>>>>>> Regards
>>>>>>>>> Shashank
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>>>>>>>> Sent: 10 April 2023 02:37
>>>>>>>>> To: Sharma, Shashank <Shashank.Sharma@amd.com>
>>>>>>>>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
>>>>>>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix
>>>>>>>>> <Felix.Kuehling@amd.com>;
>>>>>>>>> Koenig, Christian <Christian.Koenig@amd.com>
>>>>>>>>> Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
>>>>>>>>>
>>>>>>>>> Hi Shashank,
>>>>>>>>>
>>>>>>>>> I tried writing a program to experiment with usermode queues and
>>>>>>>>> I found some weird behavior: The first run of the program works
>>>>>>>>> as expected, while subsequent runs don't seem to do anything
>>>>>>>>> (and I allocate everything in GTT, so it should be zero
>>>>>>>>> initialized consistently). Is this a known issue?
>>>>>>>>>
>>>>>>>>> The linked libdrm code for the uapi still does a doorbell ioctl
>>>>>>>>> so it could very well be that I do the doorbell wrong
>>>>>>>>> (especially since the ioctl implementation was never shared
>>>>>>>>> AFAICT?), but it seems like the kernel submissions (i.e. write
>>>>>>>>> wptr in dwords to the wptr va and to the doorbell). Is it
>>>>>>>>> possible to update the test in libdrm?
>>>>>>>>>
>>>>>>>>> Code: https://gitlab.freedesktop.org/bnieuwenhuizen/usermode-queue
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Bas
>>>>>>>>>
>>>>>>>>> On Wed, Mar 29, 2023 at 6:05 PM Shashank Sharma
>>>>>>>>> <shashank.sharma@amd.com> wrote:
>>>>>>>>>> This patch series introduces AMDGPU usermode queues for gfx
>>>>>>>>>> workloads.
>>>>>>>>>> Usermode queues is a method of GPU workload submission into the
>>>>>>>>>> graphics hardware without any interaction with kernel/DRM
>>>>>>>>>> schedulers.
>>>>>>>>>> In this method, a userspace graphics application can create its
>>>>>>>>>> own
>>>>>>>>>> workqueue and submit it directly in the GPU HW.
>>>>>>>>>>
>>>>>>>>>> The general idea of how this is supposed to work:
>>>>>>>>>> - The application creates the following GPU objetcs:
>>>>>>>>>>      - A queue object to hold the workload packets.
>>>>>>>>>>      - A read pointer object.
>>>>>>>>>>      - A write pointer object.
>>>>>>>>>>      - A doorbell page.
>>>>>>>>>> - The application picks a 32-bit offset in the doorbell page
>>>>>>>>>> for this queue.
>>>>>>>>>> - The application uses the usermode_queue_create IOCTL
>>>>>>>>>> introduced in
>>>>>>>>>>      this patch, by passing the the GPU addresses of these
>>>>>>>>>> objects (read
>>>>>>>>>>      ptr, write ptr, queue base address and 32-bit doorbell
>>>>>>>>>> offset from
>>>>>>>>>>      the doorbell page)
>>>>>>>>>> - The kernel creates the queue and maps it in the HW.
>>>>>>>>>> - The application can start submitting the data in the queue as
>>>>>>>>>> soon as
>>>>>>>>>>      the kernel IOCTL returns.
>>>>>>>>>> - After filling the workload data in the queue, the app must
>>>>>>>>>> write the
>>>>>>>>>>      number of dwords added in the queue into the doorbell
>>>>>>>>>> offset, and the
>>>>>>>>>>      GPU will start fetching the data.
>>>>>>>>>>
>>>>>>>>>> libDRM changes for this series and a sample DRM test program
>>>>>>>>>> can be
>>>>>>>>>> found in the MESA merge request here:
>>>>>>>>>> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287
>>>>>>>>>>
>>>>>>>>>> This patch series depends on the doorbell-manager changes,
>>>>>>>>>> which are
>>>>>>>>>> being reviewed here:
>>>>>>>>>> https://patchwork.freedesktop.org/series/115802/
>>>>>>>>>>
>>>>>>>>>> Alex Deucher (1):
>>>>>>>>>>      drm/amdgpu: UAPI for user queue management
>>>>>>>>>>
>>>>>>>>>> Arvind Yadav (2):
>>>>>>>>>>      drm/amdgpu: add new parameters in v11_struct
>>>>>>>>>>      drm/amdgpu: map wptr BO into GART
>>>>>>>>>>
>>>>>>>>>> Shashank Sharma (6):
>>>>>>>>>>      drm/amdgpu: add usermode queue base code
>>>>>>>>>>      drm/amdgpu: add new IOCTL for usermode queue
>>>>>>>>>>      drm/amdgpu: create GFX-gen11 MQD for userqueue
>>>>>>>>>>      drm/amdgpu: create context space for usermode queue
>>>>>>>>>>      drm/amdgpu: map usermode queue into MES
>>>>>>>>>>      drm/amdgpu: generate doorbell index for userqueue
>>>>>>>>>>
>>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/Makefile           | 3 +
>>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 +-
>>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 2 +
>>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 6 +
>>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 298
>>>>>>>>>> ++++++++++++++++++ .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c |
>>>>>>>>>> ++++++++++++++++++ 230 ++++++++++++++
>>>>>>>>>>     .../gpu/drm/amd/include/amdgpu_userqueue.h    | 66 ++++
>>>>>>>>>>     drivers/gpu/drm/amd/include/v11_structs.h     | 16 +-
>>>>>>>>>>     include/uapi/drm/amdgpu_drm.h                 | 55 ++++
>>>>>>>>>>     9 files changed, 677 insertions(+), 9 deletions(-) create mode
>>>>>>>>>> 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>>>>>>>     create mode 100644
>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>>>>>>>     create mode 100644
>>>>>>>>>> drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> 2.40.0
>>>>>>>>>>
