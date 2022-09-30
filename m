Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DFBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 10:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9682110E104;
	Fri, 30 Sep 2022 10:09:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6557410E104
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 10:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flXDGiyX6nJ6GQXfXJ8eA3NiSLMqcfmVrXlIKv9Kb7tl3OCAOOK6miaE0P4/ZPnj3+uNg8EOmPppVdb/pNC7Su6iWVU22G/hVCVaBVHoWwy/ovlWyJx7KnHsxpBw0V953aX/MRyhVcCfW8Wyzaw+VJUGsDKR4dGF1fcr9LWAhN5bRa0m/ZACD5oYxgD5Oi/NQ1I9Qt8+wtlBL/0y+Y46/ItDaOiJ7AbBBnM6gKQQFp8THRJI0gPAxwPTBESouRNlb9ilRsQGyagESn2U55dRmLSrinGDZb8+wHmBeiNpztyaOwIfcemCtx8iFvtfdB0i5SCPrEmvx3CQB7ZOU6lglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHcxQx6KjDP0DVfd0PtYGCpd8y+oPIohhH/iAI3Pe8o=;
 b=J1JVDJXs2BTg/+hkRFqlY0bgM/brpiIX7TcI5lcwlTC1i7YK1c2RxfmPmTIBKe+DyH6C2aqerxQg+4l1I1bmZzpUjUzn2aAhpYRK+KWR+Py9x6s3UAPxF+tOK9R+aClvcHxkFOfylYJZtFneEnBeHdm5KRQEnpoiszyUHepUmred6jXY9rSvjHHYh2uFWlEG3SnZ4KSbNKi9Y61yVIw4S5dJCLu0jffTmH0JpPVJB9zPmXwFRZ9PU9BZjKLauAKXO4fDBdEFc2sP6tuukerp1GAn9UeJnyUQPQ7p2EsBOU4FYWzXVzGZvR/leGhqitqJp4W8y9RJN4nh46bbITEzJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHcxQx6KjDP0DVfd0PtYGCpd8y+oPIohhH/iAI3Pe8o=;
 b=ZES7ODcQ+AtWE+slW1j0Ir9NL5R8ISHP0GO1WynJVxAd33wRYW1ZTJzny5+VtcaY7a/WHLCP6z5LOImCxmf+Gy525h7j7IQG/+DKv7nCc9jAvvjMBqHPeT1R2ZvXnFguiCel0PB3b8r1Dwr+YY3rMQXYFVcBhqQJzW9c6CYbeQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 10:09:43 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961%5]) with mapi id 15.20.5676.017; Fri, 30 Sep 2022
 10:09:43 +0000
Message-ID: <3c69d3e3-d4a5-5119-7d48-8e60304b34b4@amd.com>
Date: Fri, 30 Sep 2022 12:09:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
 <d4037915-2281-b12b-e38b-2e947fb34c75@amd.com>
 <72aa5f24-8f66-2a8b-3338-a082541dd4aa@amd.com>
 <CADnq5_PavsH-=7hQjWn7aBSCVs30AYdNa_ixDUn7o-BRLh=78A@mail.gmail.com>
 <546cc67c-f17b-de76-afa1-2823f09120e8@amd.com>
 <CADnq5_Mg7GFW=s6W5xeGa5vG7_GmedsP6uQG_dpZKkzp1CDJqg@mail.gmail.com>
 <5bf6d05a-58e4-0057-1445-9369b20b1a67@amd.com>
 <369b2225-87a3-b976-bbd1-6f73f190b44a@amd.com>
 <05b4b97e-422d-dc00-bc3f-4dd04758a3c9@amd.com>
 <4cfb549b-9a76-f950-119d-e6e345841d5c@amd.com>
 <fc87e88d-4de0-f307-1fb2-658df564a3a1@amd.com>
 <46b27eb5-1807-044f-111a-bb67622e7fd6@amd.com>
 <CADnq5_O5hdJyQZSUXrZRsauNMwes8GLFOnivfiaLKS_DN3908Q@mail.gmail.com>
 <3df64977-5862-5376-341f-c503987538ab@amd.com>
 <7fa32077-2653-efaa-39d5-f585bec6c2f0@amd.com>
 <13d0e8ce-d67c-2972-a5d3-595f43945f7b@amd.com>
 <9ec22af7-29e9-14be-3939-6b0a2e226a8f@amd.com>
 <abdda495-27ae-cf32-6d58-b44773797262@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <abdda495-27ae-cf32-6d58-b44773797262@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P194CA0071.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::48) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: 572572ca-444d-47b1-29a9-08daa2cbe4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpebnrJDGwcdQHBobB02Ns01vy3MdOhJ4dOamg7iZm44pd0HfxayNUL0r8PGvnfp3ZaFsF4MBcroUNvkVuuzb/2UzHWfMWZeFWbCbzNO9jUaGEqWPtA3CtOB5wNkaqLp8MOBWafBWwWCiY5Jqw+NCzw2fbyUrW3fRu6pTThRZyO/YIMv6wTKRYguE0xceNCRLUStbCCvw14miFfF7aURFZyIe8tYvA3KUT8FJ2SxMzAm0aOzMHaeZEW2y6oGggAcn8nWcsIgqO8FNQKqpIcg1ZxErXeH4f3gBEhXK2+43OdnnctQqDlTzlG7+eRPnMTqWPlHn/Criv3y8QsSa3yjxVnPZR839/9dejp1ztWZGylvdQfm79KRfnnskiHhO5uzVosLd+3hwIKF1fdQ/RqNMzpD80yKk4+aSC22mxKA7kCvDANV4m0fSvvNqbZhl4FbQf7m4Xfi2Rtlytki2I0HicGQfEnvoLVgYsON8J2UxdMYJgDdIq6tuMR9YBSOE4D9BJEZ45M48shnH7quHcBWxOD/fwMLHK6pIa/yQTuLw3HSKsvJHFrglJt0mvB1hp2ey7gncaPBi4S7TbqZYwDqaiglXQqUKWdgVpsHHstncLw+qd0qWRfonPhuTouFl6gX3egLwvquI6OCZD93Aey3BHMJK5SGbDD2uFAJQLQMrhsbEyEKHWG0iiq9sg2sngEeJvQzmQrISJgkbZnGrJSJagQwTQcyyky2i7WHAgXZIr5/4jKnhikCoTcU7To9YhXVqu46pFQOZQr8rpPyH7ap/0Pe97/FQMkGqlR7oy1exVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(41300700001)(31686004)(5660300002)(38100700002)(31696002)(8936002)(30864003)(478600001)(66946007)(4326008)(66556008)(8676002)(66476007)(2906002)(86362001)(316002)(110136005)(54906003)(2616005)(186003)(83380400001)(6486002)(6666004)(53546011)(6512007)(36756003)(26005)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEFyeUUwWUZHL1piSDVPOGdlemU1bm1DaEVYQzZKeEJuQWRUTmlHazd1ZEwy?=
 =?utf-8?B?WEx1dkZJdlRiQk53ejY2Y0NNLytoN2d3SmZlbUhkUjJxMVRWbEl0ZFFKU3E0?=
 =?utf-8?B?RHBlRUtwdWxTOUpsV2pscDFrOWxSNmRyeFVucTJiclhnY2hIQk4vZFRmQXdG?=
 =?utf-8?B?V2pEOTlyT3NrTHVMUXNDVHlzTm9BTjYvcU9SWjJjejI3OERaM1hlS2dtWlJB?=
 =?utf-8?B?MDJxb0lDMVdmSTNNMVFxVnl6ZjVFdUN5ak1YYTcycndHRVNWeTJCYWtNV2Q3?=
 =?utf-8?B?M1FiZTdTM1BrWWFCMlowMGVZWGJJVGNtQllFVW9TcXhuYThPVnNtZWdnYnNG?=
 =?utf-8?B?ZSswS0wzZWVUODJoYTJVUmJQd09JVWQ3UXd2UWFaS1gxMlNxdm1yZGdxV3I3?=
 =?utf-8?B?Z2hFUld6cWNmNUYzQWc3QURMdWJFSGdMYW1VMGs5RXBCZDgzcUM0cFhKejJI?=
 =?utf-8?B?UGJ1enphNyt5ZDc0RWRJbU5MbVIzNSticHV4VTYvMHc1aEc3UTM3QmlOaVBQ?=
 =?utf-8?B?S05ZTFVwUnI1QzR0SUlFZ0hqMTIxdHZUYS9PK1FjbHBOS1llRElNdHlXbVpj?=
 =?utf-8?B?TzlvVHFKSFNqVVRsQ2N1VXJ4ci94TVpkQ3Y1TmJVY1RWZmF2YUdTV3R6dXdQ?=
 =?utf-8?B?NFNKVG0xN0hETGVGUWF0L0dVOGpubzNsQzdnemczT0Q5RzdNT0JQQlRONGRG?=
 =?utf-8?B?eE1pb3NHN1lNcTFjaDZyUlNtUnI3VmIwRDFVZjZRT2FkMUpNN2pwc2lNSnF4?=
 =?utf-8?B?VXZvTG9IMTlCdEg0VmhUcUUvRk9iTVY4WWNjU0dQaFlmTkZyb3YzQ20rTEdo?=
 =?utf-8?B?NjBEMkNkNXpQUFducXJVd1dQbGZMYUVueVFYcHl3aE5EWktibEFZazVKRUtW?=
 =?utf-8?B?Skw0UVF1MmsrWWJaQVJxejRsVmpvYXM5aW9jdjBkdVZXVGtZV2NCUkwyTThs?=
 =?utf-8?B?UmkwU2Z6ejlEd3VHd0M1QXpTRHp3QUw5bFpBNXMxQktmWUI1TzZ5YnRwOFpw?=
 =?utf-8?B?V21Mb1VHRkRHUWFvK3JLdUd1Y0dmMTM4cjhkNXhXSWVPYWZrYTYxZ1phTWpj?=
 =?utf-8?B?bXdSeExOdSs5L05BVVBvcGYzejVSTFhKOHRRRDJyd21iTkYrTzZLYTdoWnNS?=
 =?utf-8?B?ZG8xVVdoajdGTjhaK2hZaEhla0FqZmFsajFOcThhTGVFcUZKRFlvSFFkSDhq?=
 =?utf-8?B?QUVzaXV1ZzJ1bkg1WDFiNC94RURyVHhGUytZUXNoOVpZOWFWREQzWUxQc3Ba?=
 =?utf-8?B?S2dpQW1ENndvbk0xV05sRGtvR1dwd2VIWDVlT0tEYWNZQzViSW95NGh6RjF4?=
 =?utf-8?B?SGpZZ2xGLzBRUnZBWWFqZFo5S3ZSUEZXNFpFRzFDVi9MY3Q0b3BzblZOZ21o?=
 =?utf-8?B?SHJsb1RaVjU4d1hxVU1tTFRnL0NNbk81bDFNU0wwQkhDL3p5dVNhYXpPR2VE?=
 =?utf-8?B?cFJLenNLeDRmRjZxb1lpVDlFcHZEemNGSzZlaVNPK3Q3Q0lpcGhxWHBZL1FN?=
 =?utf-8?B?Tnl1bHpHQVJFaHpna1p3cHBOZThKYmxlZGt2RlplSlgxNGJiNDFDWXBRQjJp?=
 =?utf-8?B?K3lkY3BJSFZvaFhPVTc5aWphd291SUE4Z1ZIUlNTNTZZQ1hSMmRmcmRtUHk1?=
 =?utf-8?B?N1dhTVhGUFJJc1RlL0MreXNod2NoRjZ1YVBFM0c1d2RWeHFNNVNaNlphdmlP?=
 =?utf-8?B?d2w0RmdheURGRE1NV250Y2lWM0Z4bkFUbG1wL3BJTFNSZm1jT2E3SktzR1NT?=
 =?utf-8?B?Y2VPUlJmaFpxZkdQTVRubFJlb2tuR0ZCMzBjei9SS05wS0o2Ni85emk1MlFv?=
 =?utf-8?B?Mm41amlxeXFhNTB6cU1WelBPblkzSVgzM1ZhYytiRU90Mk9WblZ6cmRPOEpo?=
 =?utf-8?B?UjJDeDdRYzZEWk1HY2NMWHRwMzhXcE4rOStVaGU3dktpTHl4aHgrZnI2ajNM?=
 =?utf-8?B?c3BIM0pNUlVtYlBmRzJNbm54ZDRDZVFaQkF6R25peEdhNGJSWURLWGJZWEly?=
 =?utf-8?B?QW5XNTJjK2ZNUER2dElTUm5TV1BKS3RndHlScmRDRTlpR2ZKL1R6bDlFdG9W?=
 =?utf-8?B?bHo5dWFMWDg4cU5ZcE81azluSU1DNWplWHQ1RVhPc1ErdmFEV3Z0elkzd3FB?=
 =?utf-8?Q?btpjOw2WuULH71hOuJiynv42f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572572ca-444d-47b1-29a9-08daa2cbe4d0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 10:09:42.9922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsLmjZOcv1lfA0hfM3DsJCX1ygeWHjPcwLEkzJHh89A7aaJLpSwQDU5JTzgnrKmu4DwKN7x9rfv3pjJE9u7fvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
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
Cc: alexander.deucher@amd.com, Felix Kuehling <felix.kuehling@amd.com>,
 amaranath.somalapuram@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/30/2022 11:54 AM, Lazar, Lijo wrote:
> 
> 
> On 9/30/2022 2:52 PM, Sharma, Shashank wrote:
>>
>>
>> On 9/30/2022 11:13 AM, Lazar, Lijo wrote:
>>>
>>>
>>> On 9/30/2022 2:07 PM, Sharma, Shashank wrote:
>>>>
>>>>
>>>> On 9/30/2022 7:08 AM, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>> On 9/30/2022 12:02 AM, Alex Deucher wrote:
>>>>>> On Thu, Sep 29, 2022 at 10:14 AM Lazar, Lijo <lijo.lazar@amd.com> 
>>>>>> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 9/29/2022 7:30 PM, Sharma, Shashank wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 9/29/2022 3:37 PM, Lazar, Lijo wrote:
>>>>>>>>> To be clear your understanding -
>>>>>>>>>
>>>>>>>>> Nothing is automatic in PMFW. PMFW picks a priority based on the
>>>>>>>>> actual mask sent by driver.
>>>>>>>>>
>>>>>>>>> Assuming lower bits corresponds to highest priority -
>>>>>>>>>
>>>>>>>>> If driver sends a mask with Bit3 and Bit 0 set, PMFW will chose
>>>>>>>>> profile that corresponds to Bit0. If driver sends a mask with Bit4
>>>>>>>>> Bit2 set and rest unset, PMFW will chose profile that 
>>>>>>>>> corresponds to
>>>>>>>>> Bit2. However if driver sends a mask only with a single bit 
>>>>>>>>> set, it
>>>>>>>>> chooses the profile regardless of whatever was the previous 
>>>>>>>>> profile. t
>>>>>>>>> doesn't check if the existing profile > newly requested one. 
>>>>>>>>> That is
>>>>>>>>> the behavior.
>>>>>>>>>
>>>>>>>>> So if a job send chooses a profile that corresponds to Bit0, 
>>>>>>>>> driver
>>>>>>>>> will send that. Next time if another job chooses a profile that
>>>>>>>>> corresponds to Bit1, PMFW will receive that as the new profile and
>>>>>>>>> switch to that. It trusts the driver to send the proper 
>>>>>>>>> workload mask.
>>>>>>>>>
>>>>>>>>> Hope that gives the picture.
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks, my understanding is also similar, referring to the core 
>>>>>>>> power
>>>>>>>> switch profile function here:
>>>>>>>> amd_powerplay.c::pp_dpm_switch_power_profile()
>>>>>>>> *snip code*
>>>>>>>> hwmgr->workload_mask |= (1 << hwmgr->workload_prority[type]);
>>>>>>>>           index = fls(hwmgr->workload_mask);
>>>>>>>>           index = index <= Workload_Policy_Max ? index - 1 : 0;
>>>>>>>>           workload = hwmgr->workload_setting[index];
>>>>>>>> *snip_code*
>>>>>>>> hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload, 0);
>>>>>>>>
>>>>>>>> Here I can see that the new workload mask is appended into the 
>>>>>>>> existing
>>>>>>>> workload mask (not overwritten). So if we keep sending new
>>>>>>>> workload_modes, they would be appended into the workload flags and
>>>>>>>> finally the PM will pick the most aggressive one of all these 
>>>>>>>> flags, as
>>>>>>>> per its policy.
>>>>>>>>
>>>>>>>
>>>>>>> Actually it's misleading -
>>>>>>>
>>>>>>> The path for sienna is -
>>>>>>> set_power_profile_mode -> sienna_cichlid_set_power_profile_mode
>>>>>>>
>>>>>>>
>>>>>>> This code here is a picking one based on lookup table.
>>>>>>>
>>>>>>>    workload_type = smu_cmn_to_asic_specific_index(smu,
>>>>>>>
>>>>>>> CMN2ASIC_MAPPING_WORKLOAD,
>>>>>>>
>>>>>>> smu->power_profile_mode);
>>>>>>>
>>>>>>> This is that lookup table -
>>>>>>>
>>>>>>> static struct cmn2asic_mapping
>>>>>>> sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
>>>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT,
>>>>>>> WORKLOAD_PPLIB_DEFAULT_BIT),
>>>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,
>>>>>>> WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
>>>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING,
>>>>>>> WORKLOAD_PPLIB_POWER_SAVING_BIT),
>>>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>> WORKLOAD_PPLIB_VIDEO_BIT),
>>>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,
>>>>>>> WORKLOAD_PPLIB_VR_BIT),
>>>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,
>>>>>>> WORKLOAD_PPLIB_COMPUTE_BIT),
>>>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
>>>>>>> WORKLOAD_PPLIB_CUSTOM_BIT),
>>>>>>> };
>>>>>>>
>>>>>>>
>>>>>>> And this is the place of interaction with PMFW. (1 << 
>>>>>>> workload_type) is
>>>>>>> the mask being sent.
>>>>>>>
>>>>>>>          smu_cmn_send_smc_msg_with_param(smu, 
>>>>>>> SMU_MSG_SetWorkloadMask,
>>>>>>>                                       1 << workload_type, NULL);
>>>>>>>
>>>>>>> In the end, driver implementation expects only one bit to be set.
>>>>>>
>>>>>> Shashank and I had a discussion about this today.  I think there 
>>>>>> are a
>>>>>> few thing we can do to handle this better:
>>>>>>
>>>>>> 1. Set a flag that if the user changes the default via sysfs that
>>>>>> overrides any runtime setting via an application since presumably 
>>>>>> that
>>>>>> is what the user wants and we won't change the hint at runtime.
>>>>>> 2. Drop the GET API.  There's no need for this, the hint is just a 
>>>>>> hint.
>>>>>
>>>>> Double checked again based on Felix's comments on API definition. 
>>>>> Driver decides the priority instead of FW. That way we can still 
>>>>> keep Get API.
>>>>>
>>>>>> 2. Have the driver arbitrate between the available workload profiles
>>>>>> based on the numeric value of the hint (e.g., default < 3D < video <
>>>>>> VR < compute) as the higher values are more aggressive in most cases.
>>>>>> If requests come in for 3D and compute at the same time, the driver
>>>>>> will select compute because it's value is highest.  Each hint type
>>>>>> would be ref counted so we'd know what state to be in every time 
>>>>>> we go
>>>>>> to set the state.  If all of the clients requesting compute go away,
>>>>>> and only 3D requestors remain, we can switch to 3D.  If all refcounts
>>>>>> go to 0, we go back to default.  This will not require any change to
>>>>>> the current workload API in the SMU code.
>>>>>
>>>>> Since PM layer decides priority, refcount can be kept at powerplay 
>>>>> and swsmu layer instead of any higher level API.
>>>>>
>>>>> User API may keep something like req_power_profile (for any 
>>>>> logging/debug purpose) for the job preference.
>>>>
>>>> No, I think there has been enough confusion around this 
>>>> implementation so far, we will implement this just as Alex/Felix 
>>>> suggested:
>>>> - No change will be done in pm/SMU layer.
>>>
>>> Well, a confusion doesn't justify bad implementation. You could just 
>>> keep the refcount in workload_setting.
>>
>> So far, none of us have any reason to believe its a bad 
>> implementation. Why is it so, again ?
>>
> 
> It's only about keeping track of requests at client layer.
> 

There is absolutely nothing bad or wrong with that, as a matter of fact, 
some driver designs prefer to keep it like this, and let the core API 
minimal and focused on core functionality. This is just about choice.

>>>
>>> Another API that uses power profile indirectly also will need to take 
>>> care of refcount and we don't need every other API to do that 
>>> separately without knowing what is the final outcome.
>>>
>>
>> And why ? The dpm_switch_power_profile API was introduced to be used 
>> by a higher level API, and if a consumer API wants to keep track of 
>> that, its their own call. This doesn't affect internal PM APIs. The 
>> whole idea is to manage the PM calls without any change in PM APIs.
>>
> 
> Just like per-job-switch-profile is a new usage, there could be other 
> new cases as well. Also, there are other APIs which indirectly 
> manipulates power profile other than sys.
> 
Understand that there was no reference counting for pm profile change so 
far, as it was probably written considering sysfs interface and never 
considered a multi-client environment.

Like workload context, If there are other current/future clients who 
could also use these APIs, it would be a very important reason to add 
this workload reference counting in central pm structure (rather than 
multiple scattered places), so that every new API/consumer can 
understand and use this, and consider a system-wide scenario of DPM 
power profile, instead of a narrow view of its own thread. The central 
counter will indicate that more than one consumers/clients can change 
the power profile, not only this thread.

- Shashank

> All I'm saying is keep the refcount at core layer so that regardless of 
> wherever it comes from, it keeps the preference.
> 
> So instead of this-
>                  smu->workload_mask &= ~(1 << smu->workload_prority[type]);
> 
> Have something like this -
> 
>      smu->workload[type].reqcount--;
>      if (!smu->workload[type].reqcount)
>                  smu->workload_mask &= ~(1 << 
> smu->workload[type].priority);
> 
> I guess, the count was not there because there was no usage of multiple 
> clients preferring the same profile at the same time. Now that there is 
> a case for this, fix it at where required rather than keeping a track of 
> it at client layer.
> 
> Thanks,
> Lijo
> 
>>
>> - Shashank
>>
>>> Thanks,
>>> Lijo
>>>
>>>> - The amdgpu_context_workload layer will keep the ref_counting and 
>>>> user_workload_hint management, and it will just call and consume the 
>>>> pm_switch_workload profile() like any other client.
>>>
>>>> - We will add a force flag for calls coming from sysfs() interface, 
>>>> and it will take the highest priority. No state machine will be 
>>>> managed for sysfs, and it will work as it is working today.
>>>>
>>>> - Shashank
>>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>> Now, when we have a single workload:
>>>>>>>> -> Job1: requests profile P1 via UAPI, ref count = 1
>>>>>>>> -> driver sends flags for p1
>>>>>>>> -> PM FW applies profile P1
>>>>>>>> -> Job executes in profile P1
>>>>>>>> -> Job goes to reset function, ref_count = 0,
>>>>>>>> -> Power profile resets
>>>>>>>>
>>>>>>>> Now, we have conflicts only when we see multiple workloads (Job1 
>>>>>>>> and Job 2)
>>>>>>>> -> Job1: requests profile P1 via UAPI, ref count = 1
>>>>>>>> -> driver sends flags for p1
>>>>>>>> -> PM FW applies profile P1
>>>>>>>> -> Job executes in profile P1
>>>>>>>> -> Job2: requests profile P2 via UAPI, refcount = 2
>>>>>>>> -> driver sends flags for (P1|P2)
>>>>>>>> -> PM FW picks the more aggressive of the two (Say P1, stays in P1)
>>>>>>>> -> Job1 goes to reset function, ref_count = 1, job1 does not 
>>>>>>>> reset power
>>>>>>>> profile
>>>>>>>> -> Job2 goes to reset function, ref_counter = 2, job 2 resets 
>>>>>>>> Power profile
>>>>>>>> -> Power profile resets to None
>>>>>>>>
>>>>>>>> So this state machine looks like if there is only 1 job, it will be
>>>>>>>> executed in desired mode. But if there are multiple, the most 
>>>>>>>> aggressive
>>>>>>>> profile will be picked, and every job will be executed in 
>>>>>>>> atleast the
>>>>>>>> requested power profile mode or higher.
>>>>>>>>
>>>>>>>> Do you find any problem so far ?
>>>>>>>>
>>>>>>>> - Shashank
>>>>>>>>
>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Lijo
