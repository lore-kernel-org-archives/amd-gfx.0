Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F943C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 09:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EE0A10EC33;
	Fri, 30 Sep 2022 09:54:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2042.outbound.protection.outlook.com [40.107.96.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4AE810EC33
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 09:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Id3ZCkEDV3O9SeILCafUJJHPza3czwa0mivaUlu7tncgHTTp4//Xu/25uwVeXNIfBkU7DBwyrg1+GNAotxasdiKs73TGu/UvqldiQykltB2gvys54isIQKXBcw+2S1r1WURms8qbBP+uPikppBvT4gXcaKsatbhU8vCQMXim0QfNvMDH0NkQcvLMoLvfC1ipzJk49wMYNxp/MeFXrSoPBk6Mpeu6m4ZL2q8TvRKwGg/a/67Tf6khUAqFGs6H4oW9NCTqBxDjrM2+hSe4hxLXDM+t1ncsir0B4C6bDdj8PLedqk23j9jl4S/tLh6/XCwJua1QS7E/bPuYTKpy4MaIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6ODOTK56OGkg7N7gy8+E5TPyQsKemNRVQKAhxWAt+o=;
 b=ZrPDRsrJbEIvdYHXhd8xHaxrDSSLLhrE5HG0vYf/CGvoyl+vPb7jgjOkcPAMzyUSAbMdYk3yDmF9Pvl42fAGICMvCha1zohKSs7JXTAWyCP1BwqOE+3ShtVpe8VJ4daGI1JVy8pXNW6OTOhuLJ1fRSN4DP7KXS3TB3Q8ZrTJcCzKeWGDrfVDGU6cxdzoe0sH2P97P7mswe83K8n7K/L5MmSyFech1+QZvMV5IJ9oU6FKnVze4jrOSv/MwHYStrkT6QhS0CFZgh99GRvUWbXuuajpIjM+24ubnxl8DfqEzj1Jq5+MhbXdBDlY87Z0kwJxIYBINi/cden4A5yr6cI17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6ODOTK56OGkg7N7gy8+E5TPyQsKemNRVQKAhxWAt+o=;
 b=dwIyXGxa1ZHAiQSsObzxRi6Nzir4QjNZ8pZcvQ+oA0zZ/gKxt4TgGVFxM53yJkSUsSADqvW4A1tpMoNRXBAFC6/eZZA025DxZMXcvvSpwZUveXkOWQZl5daKZdmW9ct1TkXJh3sv15bG2BEAOetMrT8rc3K1E2CEsobTddmCqHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB4550.namprd12.prod.outlook.com (2603:10b6:208:24e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 09:54:12 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 09:54:12 +0000
Message-ID: <abdda495-27ae-cf32-6d58-b44773797262@amd.com>
Date: Fri, 30 Sep 2022 15:24:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
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
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <9ec22af7-29e9-14be-3939-6b0a2e226a8f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::13) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MN2PR12MB4550:EE_
X-MS-Office365-Filtering-Correlation-Id: 606d645e-5010-4a03-2c5e-08daa2c9ba4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5VIEL4PJbrBj8blMEXMBwFfxUP5i04RUBS6mdnLNk4Bjefu49tdtAf5Sx481YsxVZWcW8yuatAz/WClPVI/h27dsTN+bSnmJgecZN7Le0t9TA7wGujmMMiG18x0JbYlT4nFczWD3ZJWpdZDtCvL/jrZNpDSyjdGD0To8hwU4szrUTSmSh0AvOcvgwz23SyaQdi/lPR15sLjzZ7262J69p7r3j2tN+0Ku9vZKzINZi36pOiWja/j2x4F+p8QWfgtLZXKJKTyw0+pMZ8bA8mamoNCIDnrj04ELDi6er4ph/rluUj/VGdzPj8cKhak28uMCHW8DfOBYT0TZWzTrpyBampD8KZminSKmGrtY8eYNjIjz89Es9UKlHKJmwFSL7qq/EPP9WyYv2pGyCkZTfITGBhJ6WLnuuod/gYdf6m4JJ2ryqyMLJwbcm1x8/j4Qs5qi2inrYF9d4gkCKhS1j4YPnh8ss2Spo87DnzXEBsAs+FphaWkF1hQQXKMnQH0Jpk56Nv0Rbs1o1MqFh+Seufw1ClyGDOy3hMKi/RH4AMsJ6k2xY5s7TjTlsrDsYeYGXHQIJ1sbcy8JTVC2neiW0kVd7GtOH8XkIuBy7PiK8b9zk7fJwOYJ9YjLvdSOhKt62CO0LKbMDJSuEJ1dWOrRpNfK4MyqGkPjQtnOU7QH7eK9URHgHjigm0Bwt21qZEZ/zQ/UIxxOD2S6WeNVGQw0m9a/vkDfJTB4OpDrWgYik5U+2mL2tdGwSsFCzEFNNv769WzSQf2vuvWye52VCcoi18jb0LF/CZzTTiskPp5tFwdFjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199015)(186003)(2616005)(38100700002)(5660300002)(2906002)(41300700001)(8936002)(83380400001)(6486002)(6666004)(478600001)(53546011)(6512007)(6506007)(316002)(4326008)(8676002)(66476007)(66556008)(66946007)(54906003)(110136005)(36756003)(31686004)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXF0bmRmd2Z0enk0YXZZTGRaMjRoZ2NiUFZUWG54UTlHOHFBaytMdVkxQnhs?=
 =?utf-8?B?NkE0bDdoZmVQRHNmRmlONFNNMEdqMVRMNloyLy9zaS9CSi96RmlibHpsZDln?=
 =?utf-8?B?bEE3dGpoRTdkNTlIRzBHT3RRM2ZIa2tWTUZTd2RDU3R6elRoL0JSUjFiZUQz?=
 =?utf-8?B?bmZRY292cFVSUnB2RjJaVy9kMFBDd2RaUXVOVXhQYktUZFM3a2RBSUhUYlNS?=
 =?utf-8?B?dGwybXByLzZnTVBkMm9rbjFyajRQYmlaaSt0Rk1ERERBREtwUDBRZ3pjTU10?=
 =?utf-8?B?RW03V3NjTzd3TFZGRytIMk5WcXZxV29TRFZ5bWNmOFh1WEovVHJuRVk4bGdY?=
 =?utf-8?B?WEJGZ0RJZzc3QnJOZGhraXcrMkgwaDJFUTFxMzU3L3VNdVZKOVVuRStNMFBD?=
 =?utf-8?B?WmpBTlQrbmNMYkIvU01tZnM0c3E1bFdmOWI4TFFoSUZ2bFpLNmk2TW5IbmJQ?=
 =?utf-8?B?MnFXWEZhRmh1VEdjWjNsUFpCMTRvcEJYMEdRanlwODBPcVozcnRmQmN1QVIw?=
 =?utf-8?B?Q2N4amtZb0dRYTZtNU83d29mL1NwMXZHbW5ORWNFSDN0QWlSNk9FYlFkM0pv?=
 =?utf-8?B?MzhiVCtEZzA4c1pzTWcyUkM1eHBCU1dUdW9IOGlicDBvOVdBS01zWFg3OFpr?=
 =?utf-8?B?OUYxOVNFM2F6Y0xNaURsSEtzNklpUFlSQ0JHZEh1bm1WMHY0aVdJZEJJaGRh?=
 =?utf-8?B?VUFVbEVaOW1oRThxVE02bGxwalp2SGJTa3AwUlN3dml2NWxEeWlkUGNBTy9i?=
 =?utf-8?B?am5JSGVXR2l1L0cwa3VHbFl3QklzNXFTQjVKUjhUajQ2UHNYVFV0YnFEM25C?=
 =?utf-8?B?cDA1Sk9QSXFMMm5OY2huUXpRU3ZLS1prUzVPYkJzTWVJQVMyRVFrZmZMUmda?=
 =?utf-8?B?NVhPR2RHc0V6djhlYTFHSzB2UGNZbXJmMzVxOFdaTHNmdjVmOFl3TUlNS3ZN?=
 =?utf-8?B?QVVaZ3FsT3g0K2w0dGdtWFlRTTVLc3huY0xXTVM2cGY4TEUxQ2ZxSlJkTG9j?=
 =?utf-8?B?emw0RitRRHRaSkRpRUo1djVXUkRmaG42dnhDV0h1M2xzNDZURWkvTjh1bm4w?=
 =?utf-8?B?ZzdQWFVxK0VBRDIyLytwVDdSeVloNjVpQTJVSjRDa0F2NmRDUmRvV0l1Y1Bh?=
 =?utf-8?B?dWZiejJicFd0b2MxNTJFUUkybjh2UEE4bkE1MXZKQ0xZNzU5K1NpTmduRXdR?=
 =?utf-8?B?enRUaTlPM3RPNDFTZTE0UVBTWVM5Wk1Bc2ljZC8rR2JLdHJ0ejUrN01RYlZs?=
 =?utf-8?B?SG9CMGZzYVc1Tm10WUhhRVowUmliejNKOU1RSmNMTk1aTWE0UXk5aHJVZnZQ?=
 =?utf-8?B?THd6cERCaHlTWC9YRXZsemNianMyaG1kVFEvdEFtUXF2NTA0YnMyc01YM0Uz?=
 =?utf-8?B?aEVBemhFWWt2WGhNK2tUcTcyZW9Pc0V0WDhzbUhHSUlhNDF5SHArcEhGTVlJ?=
 =?utf-8?B?ZkMzMFl0UG9IRjZDSDZEajBHZzI3cERtUTBIK3kwVVd2NFJ1QUM3K3dIN1Nt?=
 =?utf-8?B?MFBzV0ZRVUNGajR0Ny9ZTU9HV0Z3ZXUxTk81ekdUNGNpL29aL3B2eEE5M2pk?=
 =?utf-8?B?OGNxYkpUUkpFZmpWcDNNNFVZYkthY0dMdlllZ0tPVHl2cmltVGVmK3QxbTdt?=
 =?utf-8?B?VW83M1RKanR6eGJDRlhDSHB6blZyampXTytUUzh4akpDT0Vzd1AwRmlma1Vq?=
 =?utf-8?B?cjB4UHVwSEVaRmJRZnRKVG82UzlWQ3MvWmh6RXJVSXlzWFdpVGZxQzNzUHJB?=
 =?utf-8?B?Q2xPS20rTVhKUFpxczk2ZlJGWkJrbWNrMHVCcW5DcFR6NS9pb0dzWHZkbTFi?=
 =?utf-8?B?aTNaNytWWjJ6VE5OenVKUE9rY3pteHFpanVmOW1JUDUvc0M3SDA1MXY0YzFE?=
 =?utf-8?B?M2JKVW1xeHlPeGNsOEpkdzArTnd1dEVnazRmTk5seDdnRTRGNTdMSmpKRlI2?=
 =?utf-8?B?MjdJKzdpR2kvZmtrRmllL21VVCs0YTVQTDhGbDdTZTJad29DajVBWTl0RXpO?=
 =?utf-8?B?cXp6eUNVQU8zS2xZaThHWFp3SzdzZWNybWw4TGpTNkc0dVVGMk1IYkRGZVE4?=
 =?utf-8?B?eHNwMHFEbW5rc2xIaldldGVUcExkTyt6MmhpSXd6RldpZTJzSlJtWmIyd3pW?=
 =?utf-8?B?eW5mNzZreVk4c1dlV2NuNUZVaFJRNVBVR1ZzK2N2N09ZN1hKVm41MmFTVDJm?=
 =?utf-8?Q?umMW1jcNKVrau2bcqqBnYtdjMQCqdHF80/zFZlCtZMYD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606d645e-5010-4a03-2c5e-08daa2c9ba4f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 09:54:12.7973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guAPtGipuBa54qwzq4F8zJv4/A3ct6PpMFNXWUlMpUKdejBlYclMDehlMTZ7dSvl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4550
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



On 9/30/2022 2:52 PM, Sharma, Shashank wrote:
> 
> 
> On 9/30/2022 11:13 AM, Lazar, Lijo wrote:
>>
>>
>> On 9/30/2022 2:07 PM, Sharma, Shashank wrote:
>>>
>>>
>>> On 9/30/2022 7:08 AM, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 9/30/2022 12:02 AM, Alex Deucher wrote:
>>>>> On Thu, Sep 29, 2022 at 10:14 AM Lazar, Lijo <lijo.lazar@amd.com> 
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 9/29/2022 7:30 PM, Sharma, Shashank wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 9/29/2022 3:37 PM, Lazar, Lijo wrote:
>>>>>>>> To be clear your understanding -
>>>>>>>>
>>>>>>>> Nothing is automatic in PMFW. PMFW picks a priority based on the
>>>>>>>> actual mask sent by driver.
>>>>>>>>
>>>>>>>> Assuming lower bits corresponds to highest priority -
>>>>>>>>
>>>>>>>> If driver sends a mask with Bit3 and Bit 0 set, PMFW will chose
>>>>>>>> profile that corresponds to Bit0. If driver sends a mask with Bit4
>>>>>>>> Bit2 set and rest unset, PMFW will chose profile that 
>>>>>>>> corresponds to
>>>>>>>> Bit2. However if driver sends a mask only with a single bit set, it
>>>>>>>> chooses the profile regardless of whatever was the previous 
>>>>>>>> profile. t
>>>>>>>> doesn't check if the existing profile > newly requested one. 
>>>>>>>> That is
>>>>>>>> the behavior.
>>>>>>>>
>>>>>>>> So if a job send chooses a profile that corresponds to Bit0, driver
>>>>>>>> will send that. Next time if another job chooses a profile that
>>>>>>>> corresponds to Bit1, PMFW will receive that as the new profile and
>>>>>>>> switch to that. It trusts the driver to send the proper workload 
>>>>>>>> mask.
>>>>>>>>
>>>>>>>> Hope that gives the picture.
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Thanks, my understanding is also similar, referring to the core 
>>>>>>> power
>>>>>>> switch profile function here:
>>>>>>> amd_powerplay.c::pp_dpm_switch_power_profile()
>>>>>>> *snip code*
>>>>>>> hwmgr->workload_mask |= (1 << hwmgr->workload_prority[type]);
>>>>>>>           index = fls(hwmgr->workload_mask);
>>>>>>>           index = index <= Workload_Policy_Max ? index - 1 : 0;
>>>>>>>           workload = hwmgr->workload_setting[index];
>>>>>>> *snip_code*
>>>>>>> hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload, 0);
>>>>>>>
>>>>>>> Here I can see that the new workload mask is appended into the 
>>>>>>> existing
>>>>>>> workload mask (not overwritten). So if we keep sending new
>>>>>>> workload_modes, they would be appended into the workload flags and
>>>>>>> finally the PM will pick the most aggressive one of all these 
>>>>>>> flags, as
>>>>>>> per its policy.
>>>>>>>
>>>>>>
>>>>>> Actually it's misleading -
>>>>>>
>>>>>> The path for sienna is -
>>>>>> set_power_profile_mode -> sienna_cichlid_set_power_profile_mode
>>>>>>
>>>>>>
>>>>>> This code here is a picking one based on lookup table.
>>>>>>
>>>>>>    workload_type = smu_cmn_to_asic_specific_index(smu,
>>>>>>
>>>>>> CMN2ASIC_MAPPING_WORKLOAD,
>>>>>>
>>>>>> smu->power_profile_mode);
>>>>>>
>>>>>> This is that lookup table -
>>>>>>
>>>>>> static struct cmn2asic_mapping
>>>>>> sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
>>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT,
>>>>>> WORKLOAD_PPLIB_DEFAULT_BIT),
>>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,
>>>>>> WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
>>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING,
>>>>>> WORKLOAD_PPLIB_POWER_SAVING_BIT),
>>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,
>>>>>> WORKLOAD_PPLIB_VIDEO_BIT),
>>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,
>>>>>> WORKLOAD_PPLIB_VR_BIT),
>>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,
>>>>>> WORKLOAD_PPLIB_COMPUTE_BIT),
>>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
>>>>>> WORKLOAD_PPLIB_CUSTOM_BIT),
>>>>>> };
>>>>>>
>>>>>>
>>>>>> And this is the place of interaction with PMFW. (1 << 
>>>>>> workload_type) is
>>>>>> the mask being sent.
>>>>>>
>>>>>>          smu_cmn_send_smc_msg_with_param(smu, 
>>>>>> SMU_MSG_SetWorkloadMask,
>>>>>>                                       1 << workload_type, NULL);
>>>>>>
>>>>>> In the end, driver implementation expects only one bit to be set.
>>>>>
>>>>> Shashank and I had a discussion about this today.  I think there are a
>>>>> few thing we can do to handle this better:
>>>>>
>>>>> 1. Set a flag that if the user changes the default via sysfs that
>>>>> overrides any runtime setting via an application since presumably that
>>>>> is what the user wants and we won't change the hint at runtime.
>>>>> 2. Drop the GET API.  There's no need for this, the hint is just a 
>>>>> hint.
>>>>
>>>> Double checked again based on Felix's comments on API definition. 
>>>> Driver decides the priority instead of FW. That way we can still 
>>>> keep Get API.
>>>>
>>>>> 2. Have the driver arbitrate between the available workload profiles
>>>>> based on the numeric value of the hint (e.g., default < 3D < video <
>>>>> VR < compute) as the higher values are more aggressive in most cases.
>>>>> If requests come in for 3D and compute at the same time, the driver
>>>>> will select compute because it's value is highest.  Each hint type
>>>>> would be ref counted so we'd know what state to be in every time we go
>>>>> to set the state.  If all of the clients requesting compute go away,
>>>>> and only 3D requestors remain, we can switch to 3D.  If all refcounts
>>>>> go to 0, we go back to default.  This will not require any change to
>>>>> the current workload API in the SMU code.
>>>>
>>>> Since PM layer decides priority, refcount can be kept at powerplay 
>>>> and swsmu layer instead of any higher level API.
>>>>
>>>> User API may keep something like req_power_profile (for any 
>>>> logging/debug purpose) for the job preference.
>>>
>>> No, I think there has been enough confusion around this 
>>> implementation so far, we will implement this just as Alex/Felix 
>>> suggested:
>>> - No change will be done in pm/SMU layer.
>>
>> Well, a confusion doesn't justify bad implementation. You could just 
>> keep the refcount in workload_setting.
> 
> So far, none of us have any reason to believe its a bad implementation. 
> Why is it so, again ?
> 

It's only about keeping track of requests at client layer.

>>
>> Another API that uses power profile indirectly also will need to take 
>> care of refcount and we don't need every other API to do that 
>> separately without knowing what is the final outcome.
>>
> 
> And why ? The dpm_switch_power_profile API was introduced to be used by 
> a higher level API, and if a consumer API wants to keep track of that, 
> its their own call. This doesn't affect internal PM APIs. The whole idea 
> is to manage the PM calls without any change in PM APIs.
>

Just like per-job-switch-profile is a new usage, there could be other 
new cases as well. Also, there are other APIs which indirectly 
manipulates power profile other than sys.

All I'm saying is keep the refcount at core layer so that regardless of 
wherever it comes from, it keeps the preference.

So instead of this-
                 smu->workload_mask &= ~(1 << smu->workload_prority[type]);

Have something like this -

	smu->workload[type].reqcount--;
	if (!smu->workload[type].reqcount)
                 smu->workload_mask &= ~(1 << smu->workload[type].priority);

I guess, the count was not there because there was no usage of multiple 
clients preferring the same profile at the same time. Now that there is 
a case for this, fix it at where required rather than keeping a track of 
it at client layer.

Thanks,
Lijo

> 
> - Shashank
> 
>> Thanks,
>> Lijo
>>
>>> - The amdgpu_context_workload layer will keep the ref_counting and 
>>> user_workload_hint management, and it will just call and consume the 
>>> pm_switch_workload profile() like any other client.
>>
>>> - We will add a force flag for calls coming from sysfs() interface, 
>>> and it will take the highest priority. No state machine will be 
>>> managed for sysfs, and it will work as it is working today.
>>>
>>> - Shashank
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>
>>>>> Alex
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> Now, when we have a single workload:
>>>>>>> -> Job1: requests profile P1 via UAPI, ref count = 1
>>>>>>> -> driver sends flags for p1
>>>>>>> -> PM FW applies profile P1
>>>>>>> -> Job executes in profile P1
>>>>>>> -> Job goes to reset function, ref_count = 0,
>>>>>>> -> Power profile resets
>>>>>>>
>>>>>>> Now, we have conflicts only when we see multiple workloads (Job1 
>>>>>>> and Job 2)
>>>>>>> -> Job1: requests profile P1 via UAPI, ref count = 1
>>>>>>> -> driver sends flags for p1
>>>>>>> -> PM FW applies profile P1
>>>>>>> -> Job executes in profile P1
>>>>>>> -> Job2: requests profile P2 via UAPI, refcount = 2
>>>>>>> -> driver sends flags for (P1|P2)
>>>>>>> -> PM FW picks the more aggressive of the two (Say P1, stays in P1)
>>>>>>> -> Job1 goes to reset function, ref_count = 1, job1 does not 
>>>>>>> reset power
>>>>>>> profile
>>>>>>> -> Job2 goes to reset function, ref_counter = 2, job 2 resets 
>>>>>>> Power profile
>>>>>>> -> Power profile resets to None
>>>>>>>
>>>>>>> So this state machine looks like if there is only 1 job, it will be
>>>>>>> executed in desired mode. But if there are multiple, the most 
>>>>>>> aggressive
>>>>>>> profile will be picked, and every job will be executed in atleast 
>>>>>>> the
>>>>>>> requested power profile mode or higher.
>>>>>>>
>>>>>>> Do you find any problem so far ?
>>>>>>>
>>>>>>> - Shashank
>>>>>>>
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Lijo
