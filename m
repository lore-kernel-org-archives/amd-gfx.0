Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FB8C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 09:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB77A10EC02;
	Fri, 30 Sep 2022 09:22:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB7E10EC02
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 09:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJuFlndTI1Fe1Wx61CzyMm+u4s97nBt9965x0MPid7y2fqmN1e9KJSXGbp38EHNFY65EoOWDN2p5xgCyAJvGOmGyBvHJ13WkusyHzWzmlFLwxSrJNaXPhupqq2f66k0o5m3rwEQJnpYSwdPdZ9IlyxORRY8J8NcJEV/01pCQ9zNh4f5Pdap6GYhm8koty+0s4+BU/LRLfIDFI/3lNwZl7KvJry88prLKZRklpYv+LM9SRlcPHZWFi6eS19uE9YAixYPWiz8VxCPpAKJ/fouPHisL7icvPZYl9rHvNkom0q8gs+lMUjDz/lD++38KkiMYj8Z/236EIi1GqO5cm6/C8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzlU4nZNwFpsyzw1/KCEa3Jj9XdY0a8YypNiDx0b2PE=;
 b=Qp/7PZZhj3EjrLnzEdLrN93eSLcaDTP1+yCkEji2p+lV5OeokMCJRk38BMQ+OWtTGQ8r4WPHeOBXNB+GcPSnLJQqdPmeKMzEd13TjC69hivVci/doaxHOGCBgndZs2RiceWGW7Y7T/CeUgqL7riYa92HKRBXgoyzZDe0GI4XXlKFL0+fcbqbpAAv0VNcbZ6e4pJY93eMN7TCKEV2+rFTlqqfZrq1cQoksReKZnfF+TxpopzTE/KQ7H2oxUVUOS/IaR2vmWFRVm1816pWCUkwSj9jqQ+tQIleMcfEygufJhsDEeov1aQWZXR3oGY2mDAq7i36vBiineAO+opClzvoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzlU4nZNwFpsyzw1/KCEa3Jj9XdY0a8YypNiDx0b2PE=;
 b=4Wg+hUs8Vw4WvhM0VqtAd4JYmyhBEIF6aC4ogBDF8vS5AUWWB/bXkV/W6g+mzNcCnTvA5DAZtvIZacwOyFHzh9nD9raUpkpCxmixgdeK3XhpfpjyNpNbdDGpwPNFMt2P4goHAft5+/Xz+o1ygxJa55W3fkVlqdDvlyaMx6hk9TA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 09:22:27 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961%5]) with mapi id 15.20.5676.017; Fri, 30 Sep 2022
 09:22:26 +0000
Message-ID: <9ec22af7-29e9-14be-3939-6b0a2e226a8f@amd.com>
Date: Fri, 30 Sep 2022 11:22:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
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
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <13d0e8ce-d67c-2972-a5d3-595f43945f7b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BL0PR12MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f1018a-7eb4-45b4-8bb5-08daa2c54a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZDI39uw9XTiDuwY+mSlWwvqXbS3SoQyVGp/78zQwbrdrOAg0O/3QX0lEDVFKPfBnwQIimTmG21s6vkeUY3cJPUBHsTpuZ+yQah7ROpBUBlomGdkS56ujXcrtJumRzOhMYG8CnnA5SydCfOJayRRVXcYh4u8usQSht8eVp3jEuc8HKJE6nree/K3e7njN+proBF+9626s5nXbWJJBTyvIbkCpq1nfkmn11r30Jd+kdhbGp1YvEUnRjd4gUo5ZN+Vms2QyCYUW7rexWRy4dqYHQqacAoWZ7KzQI4HlntlfMQVDaQ+k8IcAkof4/HG2f/F5VOoXxpHRRchuG8Z9V5JP5YFehBTG6VK2NSTh3UIAi5IqwRqWc6QUwrJysa1pe0U+FwdWNYKXoly6TVA1p5lLYBZiOuvjL688AWHMcW8RTbOjR8sd5eupen1AvqQwNcyiiK7tdD7dCpJTBv1LawgHR/8PX0HdrO0PJbGH0HgzjLwIrhslF4ybUmUiN9f2+u1CV2VY1itEzU4Gh2+StrIoN4lPMNtdrBD8NNKcx/3XrLIfCOOB0Oh1dTTFlgLdBweT1zjx2BVX23XI0syD4fNC/n+bdkNOq075t2XEQFXcBxoMMW5mieMOMUxRZdmxr0m0IBXSZJr9nrWb1UKxI/a5ByiTl/eTbghFi5xYj2naUhqMaI8gbIN/TlJclUzjec2rujjUmS8jdB2xjkLLEqHTGDtoWi5+bXd47co9CBb5vSOuVvK6kTVUo7qFvYXbZfyJ87UfZfi/whY0+0ioHRe4rLblXnz04TNkoEPv4DjxQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199015)(53546011)(478600001)(6512007)(6506007)(6666004)(26005)(83380400001)(186003)(2616005)(2906002)(8936002)(54906003)(110136005)(316002)(8676002)(4326008)(5660300002)(41300700001)(6486002)(66946007)(66476007)(66556008)(86362001)(31696002)(38100700002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1NkZnhIdVFuaHpwNXZVNVhpbkJKQ2pzOTN2clBxMG9DSDFsSVR2V2pVbHZU?=
 =?utf-8?B?U0FMbDRmT1NmSFlyb1JDL0JITEh1N2MrMWxYYW0rUjhFb3ArTm5GZjhNTE5B?=
 =?utf-8?B?M08yL0ZubWVNTGZyMURKSklvR2lRaFpNV0JOVzI2bWE0Lzc0QkdZMmJRcTlU?=
 =?utf-8?B?a1VvOGN5aFI5Uks5YzBZelhnSmVVUjFlZE56cWdoV3RSaGpleTV3VDNvellZ?=
 =?utf-8?B?UUxhK0FsUXlHdENFRHB0VVNGOEUrL0dKb25RaTZKbUUzbXgxcng1ZVovbGY0?=
 =?utf-8?B?Z0J4cVU5a0lHV1hITWdJUThXN3MzSGN1K2xUTFA4WnBNZ0pkSk9oenhiOWpi?=
 =?utf-8?B?dEtsS0RCN3A1QjI1clM3V21JaWh4a3dDWUdtdmQyNkF0eDdXN2pXaDlnWjh4?=
 =?utf-8?B?SkJFZVRiTy9IU0k3SXdxdDZCajc0dkJ5czJrOWQ5YnpnTktoWlArSDZBaUxx?=
 =?utf-8?B?WlN4cjc5NE10WmlwcEJKSHJBL3FKby94aGxvd1dhTXdobDQyZXRTTUhOb2ZX?=
 =?utf-8?B?THR0UzJPcThNdWhUbDNYYjZoT1l4dW1UYlpPT0lVMjhxamxpUTNUcG53OHZ1?=
 =?utf-8?B?VTBCb084UW85K1dkOWNaOGZNZVcwRDBzOTdacWtORUNIRnlyYjJaTWJhczNW?=
 =?utf-8?B?ZDdLa3FneXRYQlBkVXc5MDZXMkRwb3d3VXdHQ1RhMkNsZytyMjNkcGNvTE0x?=
 =?utf-8?B?TEpzeGpaSTNRVUxXMTZJS0VlNFZNNjM4VXlRTjA2NzVjR2FrK29nZDk3M0lR?=
 =?utf-8?B?MVprb2srVG5QRHJMMU1LYk1ubjlrU1hnVkFzUDA0Q0ZSYU1ybGMzTlE2RDdh?=
 =?utf-8?B?YVZJNnNPN1pZbzJndG5LTDZ2T1JTMDlXV3NkZEdJRTRYZEFDVFJNN1hIQklo?=
 =?utf-8?B?VlE5L2k2ZzBVUVZCMUpwV0tVL1BSTFF0K1dWMVFvc0N3Z0ZyNzhOVmNmQnZQ?=
 =?utf-8?B?KzAwZ05DWkpIMjYrYzVMY3k4R2JjS3ovbWF4Q1lkOS9tY3BpL1lSMEowRDVq?=
 =?utf-8?B?ZHlWdTh0UjM3cFNhNlRkNzYxTEltalJUdUtYRXlXQ1FXYmV0dTlEUkZkTklX?=
 =?utf-8?B?WFhwNE5LRlhPSHR3aXowNlJZM053cTdZRFc2YWlXZGVOZis4bWN1RDBHRkd0?=
 =?utf-8?B?QVFMSUptd1VSRS9kYW1Hay9jb0RPQmlTY1RsOU01a2JERlZwRU9jRkp2cnph?=
 =?utf-8?B?OGtoYU44dnJrY09TaEpVS1luR2hPemIxUnpxRGlFSFJXTXFkTWJrZDVUZTNZ?=
 =?utf-8?B?eW01cjk1cEM3OFhwQmlDWFJHYzFlblJ1Zk1iM3FYODE0c2t4aldHZ2Q0cGh4?=
 =?utf-8?B?ZkZMaElRN0FaTWl0OEVpWjExZ2swTmIwWjYvejlDaXBwWm90TjIrUS8vNEln?=
 =?utf-8?B?dVRnMFFtOWhFT2VIRDFwSnZ3V1N2dkZhT1cxbVZQeTdBZDdJd2NlNDZJd2E5?=
 =?utf-8?B?M0k5QUx6dEpzK01XVmR2YlJRNG9ac3hLUlh0VEVwczFOL0I2d0tjb05YeVRr?=
 =?utf-8?B?ampUUk5pV1FMRkE1Nm5UVTRON1RMT1pzbFkxTFJBdnJrNjNiMmZpRmZ6WGp0?=
 =?utf-8?B?OThUbFI2bDArN0xFVitWY1ZldW9rS2R4VHU2Uld4R0NsVm1UbDhWRFloT1FS?=
 =?utf-8?B?LzQ3Z1VaendJdDEwbDgybklDcmduQjNYODM1NVUrbys2QlRPWjU5OEQrdE90?=
 =?utf-8?B?amxDeVR1bVZORzJzVE1oN1pGSFJXR09XaUcvZHRkb0NDK2IxTGNRRXFQd2xY?=
 =?utf-8?B?R0MzRk44cXlGZHFWZkdxM0ZTcG1uWUZzZGQ3U1FSY29wMi9USis4Ni85Wmxo?=
 =?utf-8?B?UVZidFJrRVRIditscHVTQVJXVzVxUzh4Qjh6QmdkRFBjS0tuZHFrK3h4MGxZ?=
 =?utf-8?B?UkhDc3VvZHBoV3JTN2ZVYkNBM0lZdTdJZFNwb0w0amIxSVhrRFI2Q2wyOUtN?=
 =?utf-8?B?WnI5TnlRamFIZnZOWW1ZSWF5d0I1dUlGQ0FIMWU0RVRRK2I4dWlxbkJabHkx?=
 =?utf-8?B?YVlEVGo3TWRnam1xeEJNb1NkZzFYWDZIMkxjY3JHSC92Sk5na3pBSFNlQTVL?=
 =?utf-8?B?Tjl2K3RJUmQyblk0Rks3amt6ZEE0YnU0cTd5MS8yQ2NHSFp1bk11NFJ6a2Nh?=
 =?utf-8?Q?xxwnS52cZexJkhOV+wBCuLyds?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f1018a-7eb4-45b4-8bb5-08daa2c54a3a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 09:22:26.6766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMmZIfNECEsWVOLTaKt7myAOhSknTqE0ziGFA6r2FK7JeBbATJTw7rdKbSEg/D9o9vWwsxFljVsfYzs4ccv18g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
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



On 9/30/2022 11:13 AM, Lazar, Lijo wrote:
> 
> 
> On 9/30/2022 2:07 PM, Sharma, Shashank wrote:
>>
>>
>> On 9/30/2022 7:08 AM, Lazar, Lijo wrote:
>>>
>>>
>>> On 9/30/2022 12:02 AM, Alex Deucher wrote:
>>>> On Thu, Sep 29, 2022 at 10:14 AM Lazar, Lijo <lijo.lazar@amd.com> 
>>>> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 9/29/2022 7:30 PM, Sharma, Shashank wrote:
>>>>>>
>>>>>>
>>>>>> On 9/29/2022 3:37 PM, Lazar, Lijo wrote:
>>>>>>> To be clear your understanding -
>>>>>>>
>>>>>>> Nothing is automatic in PMFW. PMFW picks a priority based on the
>>>>>>> actual mask sent by driver.
>>>>>>>
>>>>>>> Assuming lower bits corresponds to highest priority -
>>>>>>>
>>>>>>> If driver sends a mask with Bit3 and Bit 0 set, PMFW will chose
>>>>>>> profile that corresponds to Bit0. If driver sends a mask with Bit4
>>>>>>> Bit2 set and rest unset, PMFW will chose profile that corresponds to
>>>>>>> Bit2. However if driver sends a mask only with a single bit set, it
>>>>>>> chooses the profile regardless of whatever was the previous 
>>>>>>> profile. t
>>>>>>> doesn't check if the existing profile > newly requested one. That is
>>>>>>> the behavior.
>>>>>>>
>>>>>>> So if a job send chooses a profile that corresponds to Bit0, driver
>>>>>>> will send that. Next time if another job chooses a profile that
>>>>>>> corresponds to Bit1, PMFW will receive that as the new profile and
>>>>>>> switch to that. It trusts the driver to send the proper workload 
>>>>>>> mask.
>>>>>>>
>>>>>>> Hope that gives the picture.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> Thanks, my understanding is also similar, referring to the core power
>>>>>> switch profile function here:
>>>>>> amd_powerplay.c::pp_dpm_switch_power_profile()
>>>>>> *snip code*
>>>>>> hwmgr->workload_mask |= (1 << hwmgr->workload_prority[type]);
>>>>>>           index = fls(hwmgr->workload_mask);
>>>>>>           index = index <= Workload_Policy_Max ? index - 1 : 0;
>>>>>>           workload = hwmgr->workload_setting[index];
>>>>>> *snip_code*
>>>>>> hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload, 0);
>>>>>>
>>>>>> Here I can see that the new workload mask is appended into the 
>>>>>> existing
>>>>>> workload mask (not overwritten). So if we keep sending new
>>>>>> workload_modes, they would be appended into the workload flags and
>>>>>> finally the PM will pick the most aggressive one of all these 
>>>>>> flags, as
>>>>>> per its policy.
>>>>>>
>>>>>
>>>>> Actually it's misleading -
>>>>>
>>>>> The path for sienna is -
>>>>> set_power_profile_mode -> sienna_cichlid_set_power_profile_mode
>>>>>
>>>>>
>>>>> This code here is a picking one based on lookup table.
>>>>>
>>>>>    workload_type = smu_cmn_to_asic_specific_index(smu,
>>>>>
>>>>> CMN2ASIC_MAPPING_WORKLOAD,
>>>>>
>>>>> smu->power_profile_mode);
>>>>>
>>>>> This is that lookup table -
>>>>>
>>>>> static struct cmn2asic_mapping
>>>>> sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT,
>>>>> WORKLOAD_PPLIB_DEFAULT_BIT),
>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,
>>>>> WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING,
>>>>> WORKLOAD_PPLIB_POWER_SAVING_BIT),
>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,
>>>>> WORKLOAD_PPLIB_VIDEO_BIT),
>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,
>>>>> WORKLOAD_PPLIB_VR_BIT),
>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,
>>>>> WORKLOAD_PPLIB_COMPUTE_BIT),
>>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
>>>>> WORKLOAD_PPLIB_CUSTOM_BIT),
>>>>> };
>>>>>
>>>>>
>>>>> And this is the place of interaction with PMFW. (1 << 
>>>>> workload_type) is
>>>>> the mask being sent.
>>>>>
>>>>>          smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>>>>>                                       1 << workload_type, NULL);
>>>>>
>>>>> In the end, driver implementation expects only one bit to be set.
>>>>
>>>> Shashank and I had a discussion about this today.  I think there are a
>>>> few thing we can do to handle this better:
>>>>
>>>> 1. Set a flag that if the user changes the default via sysfs that
>>>> overrides any runtime setting via an application since presumably that
>>>> is what the user wants and we won't change the hint at runtime.
>>>> 2. Drop the GET API.  There's no need for this, the hint is just a 
>>>> hint.
>>>
>>> Double checked again based on Felix's comments on API definition. 
>>> Driver decides the priority instead of FW. That way we can still keep 
>>> Get API.
>>>
>>>> 2. Have the driver arbitrate between the available workload profiles
>>>> based on the numeric value of the hint (e.g., default < 3D < video <
>>>> VR < compute) as the higher values are more aggressive in most cases.
>>>> If requests come in for 3D and compute at the same time, the driver
>>>> will select compute because it's value is highest.  Each hint type
>>>> would be ref counted so we'd know what state to be in every time we go
>>>> to set the state.  If all of the clients requesting compute go away,
>>>> and only 3D requestors remain, we can switch to 3D.  If all refcounts
>>>> go to 0, we go back to default.  This will not require any change to
>>>> the current workload API in the SMU code.
>>>
>>> Since PM layer decides priority, refcount can be kept at powerplay 
>>> and swsmu layer instead of any higher level API.
>>>
>>> User API may keep something like req_power_profile (for any 
>>> logging/debug purpose) for the job preference.
>>
>> No, I think there has been enough confusion around this implementation 
>> so far, we will implement this just as Alex/Felix suggested:
>> - No change will be done in pm/SMU layer.
> 
> Well, a confusion doesn't justify bad implementation. You could just 
> keep the refcount in workload_setting.

So far, none of us have any reason to believe its a bad implementation. 
Why is it so, again ?

> 
> Another API that uses power profile indirectly also will need to take 
> care of refcount and we don't need every other API to do that separately 
> without knowing what is the final outcome.
> 

And why ? The dpm_switch_power_profile API was introduced to be used by 
a higher level API, and if a consumer API wants to keep track of that, 
its their own call. This doesn't affect internal PM APIs. The whole idea 
is to manage the PM calls without any change in PM APIs.


- Shashank

> Thanks,
> Lijo
> 
>> - The amdgpu_context_workload layer will keep the ref_counting and 
>> user_workload_hint management, and it will just call and consume the 
>> pm_switch_workload profile() like any other client.
> 
>> - We will add a force flag for calls coming from sysfs() interface, 
>> and it will take the highest priority. No state machine will be 
>> managed for sysfs, and it will work as it is working today.
>>
>> - Shashank
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>>
>>>> Alex
>>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> Now, when we have a single workload:
>>>>>> -> Job1: requests profile P1 via UAPI, ref count = 1
>>>>>> -> driver sends flags for p1
>>>>>> -> PM FW applies profile P1
>>>>>> -> Job executes in profile P1
>>>>>> -> Job goes to reset function, ref_count = 0,
>>>>>> -> Power profile resets
>>>>>>
>>>>>> Now, we have conflicts only when we see multiple workloads (Job1 
>>>>>> and Job 2)
>>>>>> -> Job1: requests profile P1 via UAPI, ref count = 1
>>>>>> -> driver sends flags for p1
>>>>>> -> PM FW applies profile P1
>>>>>> -> Job executes in profile P1
>>>>>> -> Job2: requests profile P2 via UAPI, refcount = 2
>>>>>> -> driver sends flags for (P1|P2)
>>>>>> -> PM FW picks the more aggressive of the two (Say P1, stays in P1)
>>>>>> -> Job1 goes to reset function, ref_count = 1, job1 does not reset 
>>>>>> power
>>>>>> profile
>>>>>> -> Job2 goes to reset function, ref_counter = 2, job 2 resets 
>>>>>> Power profile
>>>>>> -> Power profile resets to None
>>>>>>
>>>>>> So this state machine looks like if there is only 1 job, it will be
>>>>>> executed in desired mode. But if there are multiple, the most 
>>>>>> aggressive
>>>>>> profile will be picked, and every job will be executed in atleast the
>>>>>> requested power profile mode or higher.
>>>>>>
>>>>>> Do you find any problem so far ?
>>>>>>
>>>>>> - Shashank
>>>>>>
>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
