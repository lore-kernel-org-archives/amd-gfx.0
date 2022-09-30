Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEB0C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 05:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E74510EB4A;
	Fri, 30 Sep 2022 05:08:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF54010E18A
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 05:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNqJ2hefsBpZ2YIIgcuwj9bxK/O4aZXJCEsYWkmLj4g2hAasqX5CxJ3N3RTL4+1oYIjh/NhZuL5tEiBTMynXsxM5lV+pHphZDTRYA3Em1OVsIDZh454daC+IXQk236ZcfX5w80f75c/oZxllSmJxmJLRdSXUt1VpYZT+RretSCTcTnaQW62NrkHPScebRN9ZOUTI7jBs7HKY4Sw/BzN3NozoccAcl6IR0v7CIlZ+ZHkjrSxv9FcbgvJdy+Jy/XTsTrECExocC7GbA6QHmnJuvDQErf9AEPUz67AAJy3fMkPe8UD1NUacy1kxtn/MIo7PNL9Bml1bFW/ufYUBGoF1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0yb8RA2RlOwxRGljHLp/x7yhUIk13m2kSBUTRQ7+KI=;
 b=GZg6LXT3dy0995E8YC4oLQsCLDszfCpLBYx/FveqfKHRRrfJO1kpGZwM2eEZtfKMyeW1fBONe+s6t5zOePiILkgAwWj4/mEXnBVygJn5DAinW6iv854TwGWBrppVN8wH78i0NwZdP6JSmtYx0YwizhaR6BJp6lCsHcib6yfCnepTs4LDYvjTgiNpINPM9h0uIc4GtwQAR2nZzdlp8coNuxZfd2T7qQYd4r4w1K1cv+AlmBLy5MQsYJ8HtKwPGSsix54HSZG1rebUPj2Ie/L3DHIsSFCVtV8w3Im3Ufw1I37IZqkSkFLiEKDZ+In9jdiZ3HQijiIQ7sCF0HMw5UoB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0yb8RA2RlOwxRGljHLp/x7yhUIk13m2kSBUTRQ7+KI=;
 b=oyxoee8qh2M1mYjtzXr9hL3wQn5TN2C3V+b05atDUz6jjPfDzi8JDONFwMexf0RWvRhnKDzEdFv1ZGaPFMs0qIgqjqK2hLxwcqX4cySDADKkc9vYV8tkX2XlWRFhaKB9Mf/hGRILPMpiGY/VEGIH3oTZmDCCiE6YZQBMHuHQGrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 05:08:37 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 05:08:36 +0000
Message-ID: <3df64977-5862-5376-341f-c503987538ab@amd.com>
Date: Fri, 30 Sep 2022 10:38:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
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
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_O5hdJyQZSUXrZRsauNMwes8GLFOnivfiaLKS_DN3908Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::6) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ed289c-4508-4f66-1989-08daa2a1d477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpUQB+cX8TlKRx9bRe871dNdrmPPAlXvhggEC3HtOibCRtLgtE8CG2yB3d4/Luxet0OHFFiWlRTu30FzXZ1f7SFAHgljpcNku1vfpPTMagf7qBnYS459txJQALlsyb02R5ias2Z1IB0/Az6KHI133m/UB4V4o0RQy1LTEevemR555q/7wNUpRp07aE/ZXTxih6q4+PXu7PgnrnmcVwiMz70bD6vzkwuNvJxLRzqS3NK/RyvCNWrffCwT42IxQ5B0VBkbvKn1niNQJ8awEr+XkHWEtURjRZt2aO9SjKOXYME6peCVQMqSKmwoYAkyP92kqD2bK2YFQc3dCFPbQxUQSMg/cL/JnbPGBE0p05y0pmFLKilWZezH0wRhgc81AHVBaP+KQm4hUblKq7kuwQ2txkR9YGZY9cl1thEyXu8D0vlyNkFb2LTgY0bsKgxzY+Wp36caa9YFdrn74h2WIPjDwBap6zthIzNs/xeB/nd7tJU+N/ZnPzJFG2hzd+BEiiGvu6HgyoknOKN0cmx573NBTxiJ6mZigYfwQJry9VCiWNuLLLvSXjkabIasIswI9flcnMUAXk+8r6YdeawPgcCwIJNymERXOYhv8M67qI5liUKoB0h0SH+SqGFhejcR3E1M5C4i1eQcSamesewq8GdOO1CohEWGNgnzovPr976T5iybu4LC/8KFP8wylfxCMIxS++8iGOHKbY6XDqpNf3WyJbnMA34L+25/+pYe/vbuzqCDXRwANuWh1kg9BVZ408VgdPWsK+bUXpHOd8CuSheO39AXIRpndg/C2FyLyl5Y5ao=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(2616005)(31686004)(478600001)(6486002)(2906002)(54906003)(6916009)(316002)(86362001)(5660300002)(38100700002)(8936002)(26005)(83380400001)(6666004)(41300700001)(186003)(53546011)(6512007)(36756003)(6506007)(31696002)(66476007)(66946007)(66556008)(8676002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTg5TW9pYnRiZ3hnSkJvVDBwL0ZtUkh6eXRiNkJ0ZXBzU2Q3YVRSTENTN3NP?=
 =?utf-8?B?Q28xcnR0RURNeFh3cjQyVDlnNUpNQ1RNWVRQTmZ0bytKSTM2dnIyanV3RXFS?=
 =?utf-8?B?MFl2N29jenpBREZ3cVFoL1pMdjBUS1pzMGIyWjNlMzQ4QTE1dkFOak5TZjVl?=
 =?utf-8?B?bmtHQzVCczJyVk1YdTNlMG0yK2FBcGV2am42QXcvUnFTV3RSUUVWeGVBTG5X?=
 =?utf-8?B?L1hULzBkVWtmb1J3Y0JUekJiMGxPc3FGamgyVlk5SjY1S05Xa24xblczQ2Zk?=
 =?utf-8?B?M2NmT0xIbmN1TzlEUVdvczFCVS9nbW51RXNieE82UEo0d3RyRnRDUnAwcytk?=
 =?utf-8?B?WDVVVzJxM3Z4SjJwSk9MWkdISFZxV0ZmMjlnVlNjdU9DSSt2N3BFd2hNcmdE?=
 =?utf-8?B?SmcrWitPSTlnMkxCZ3FrNmxPSjBJdTQ1ZXZTY0ZabUIzR2hyRUhkdG93b3Vz?=
 =?utf-8?B?QXNmR3E4VVQ2YmFtMUNUclA1NXdNcHF2cUpqK013RlY2T3ZjU3V5TDVJcU9N?=
 =?utf-8?B?Snl4K0YydFpnby9sdWNQSEJSZFVPNGlvL3l4aVlnY2lJbWRRSHI4T0kyUGNN?=
 =?utf-8?B?UTJtdEk5dGxyeW9zUElKVTk0OEczV2xpcmdjTWZsQVFDNzY3N2hUeFdSWjdU?=
 =?utf-8?B?aVNycCtjdTNzbU92ZmpITnVGL1FyNkZJUnJzRCtIL0s5eXk4NjV2TG1WQ1hE?=
 =?utf-8?B?OCtjUHE4NHlKZGd1WVRlMFo4dkRRRWk4ZWVNRmRPNUhjazFFK2tRclMxMjMr?=
 =?utf-8?B?RW0zYURZWUh0NU5RdHN1cmN4OVMxNVYwSHZqbGovbnZISHRtWFBkeGdHb1VB?=
 =?utf-8?B?RmFIc0xhNG5aOGZwK25reUdJTHREUlc2WHcxL0hMUFJhZksyMGRUYXF1S2JO?=
 =?utf-8?B?MTM4V1dSd1FGNFlqeCtHd1VRZUFmRkptRXhyTlh3MVFIT2JYYXcvUTAyOG9x?=
 =?utf-8?B?TnpvU2tvZjgwamxVaHIrSGhZMHR1VExqVGtYaUpYOXdYeE5GRGRkZGdGUklC?=
 =?utf-8?B?VkZFRHNxWWhLN0o0UWhaOWJCNm40bElyYUIvNTI4WlNiTkRrV0ZTQ3pSdnp3?=
 =?utf-8?B?VDNzVUVKQ3JQeGVibkdGUFBLbFhLU0FqdG9CL2ZnWkZWQ3Z5TkVadXEvVlA4?=
 =?utf-8?B?ZEdOUHVOcXoxQ1UwZVhZZEN3amd3TFlVV2VidVNwdG5YRm9QQVhRdjZ6WGF0?=
 =?utf-8?B?ZGRvMldud1F1QXh6VXFtbmF2eU9ydUpPYm5VNmJaMEdzeks0N0hjM2E2Rk5X?=
 =?utf-8?B?VytYM3pqU2tOSWpQaDdDVW5IWWNIQmg0ZkpSOFZ2dzV3QnVzSkZpSGd4SVVl?=
 =?utf-8?B?WEtBa053VmJpcmk3Ky84UUhIVWNublRhdUl1K2dLdFZtazVMOGhWck5zVnIx?=
 =?utf-8?B?S2dRb0JIOUxsM1JkUE15dHFJSjMvdW1YZGpkais3bWxMMmVRcHJIMTZEWGhQ?=
 =?utf-8?B?d1FoVUo1ZnBWZDlsZmlTQ004UVE4WWRDYlJ2cDNKc1dPaWU5Mml1R20wejQ1?=
 =?utf-8?B?WFpRT2xlL3o3cDliSzY0aytEQnlLVHVXWmJoMnZZVHp1SURGYVA1N3BXazc0?=
 =?utf-8?B?VEZpZElOUDV0QW5zSnFtSzNKSUdyR1NrSWJJc2lCRnFsZmF2RVdKU1JUOWc3?=
 =?utf-8?B?NzBtaG9vZW5pQ0IwMElaaUZSejI4d0NaY1lqN0dhMC9JK0JDWHBaaHRFejg0?=
 =?utf-8?B?QlNib2s4T3lwUGlVdjhqOWVKeXNJa0YrdUgvSU1FUHQ2eWVmUnZ6akVsV0lE?=
 =?utf-8?B?ZXJpQ1NIVUVvSWRjcytjYmRrbjhHdDVySTFmQUdkdklYaCtuK0hsZXNKa3hh?=
 =?utf-8?B?aHZwWUQyU0pRQWJNWS9nRnpaQ1AxRzBZa0tIRXZtNk9WMU5ZWCtKdVJkOVQw?=
 =?utf-8?B?RkIxU0pzL2YzSFM0L01BcWQ0SUg5SXMvdEtGT1VwOUc2STQreWpqQzhyOGYy?=
 =?utf-8?B?TzloeXFKMERrRWFjaklWWEJHOHRjSGYzQjE0Y2YrY3BseXFBWk9LUjgvbHBM?=
 =?utf-8?B?VUZkdUpKaEFVTU95QncwbC9JeENZUFZPZFpNZGEzai95MFM2dFE5WjBYQ1Ay?=
 =?utf-8?B?MFJ2QWJZWmtZVng4VVdFOXplQ25CdHZpL0puWWVXajZMVkdkMWJjclp2di9W?=
 =?utf-8?Q?6PcKcXECdVSdYRQ/DwW7nl6Ha?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ed289c-4508-4f66-1989-08daa2a1d477
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 05:08:36.8418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5+9p2OPkU0RXvoOeXW6L4u2BKCV2qqrZbWP1rxBWU2+csbABHEeas++wbQOhr7s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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
Cc: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amaranath.somalapuram@amd.com,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/30/2022 12:02 AM, Alex Deucher wrote:
> On Thu, Sep 29, 2022 at 10:14 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 9/29/2022 7:30 PM, Sharma, Shashank wrote:
>>>
>>>
>>> On 9/29/2022 3:37 PM, Lazar, Lijo wrote:
>>>> To be clear your understanding -
>>>>
>>>> Nothing is automatic in PMFW. PMFW picks a priority based on the
>>>> actual mask sent by driver.
>>>>
>>>> Assuming lower bits corresponds to highest priority -
>>>>
>>>> If driver sends a mask with Bit3 and Bit 0 set, PMFW will chose
>>>> profile that corresponds to Bit0. If driver sends a mask with Bit4
>>>> Bit2 set and rest unset, PMFW will chose profile that corresponds to
>>>> Bit2. However if driver sends a mask only with a single bit set, it
>>>> chooses the profile regardless of whatever was the previous profile. t
>>>> doesn't check if the existing profile > newly requested one. That is
>>>> the behavior.
>>>>
>>>> So if a job send chooses a profile that corresponds to Bit0, driver
>>>> will send that. Next time if another job chooses a profile that
>>>> corresponds to Bit1, PMFW will receive that as the new profile and
>>>> switch to that. It trusts the driver to send the proper workload mask.
>>>>
>>>> Hope that gives the picture.
>>>>
>>>
>>>
>>> Thanks, my understanding is also similar, referring to the core power
>>> switch profile function here:
>>> amd_powerplay.c::pp_dpm_switch_power_profile()
>>> *snip code*
>>> hwmgr->workload_mask |= (1 << hwmgr->workload_prority[type]);
>>>           index = fls(hwmgr->workload_mask);
>>>           index = index <= Workload_Policy_Max ? index - 1 : 0;
>>>           workload = hwmgr->workload_setting[index];
>>> *snip_code*
>>> hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload, 0);
>>>
>>> Here I can see that the new workload mask is appended into the existing
>>> workload mask (not overwritten). So if we keep sending new
>>> workload_modes, they would be appended into the workload flags and
>>> finally the PM will pick the most aggressive one of all these flags, as
>>> per its policy.
>>>
>>
>> Actually it's misleading -
>>
>> The path for sienna is -
>> set_power_profile_mode -> sienna_cichlid_set_power_profile_mode
>>
>>
>> This code here is a picking one based on lookup table.
>>
>>    workload_type = smu_cmn_to_asic_specific_index(smu,
>>
>> CMN2ASIC_MAPPING_WORKLOAD,
>>
>> smu->power_profile_mode);
>>
>> This is that lookup table -
>>
>> static struct cmn2asic_mapping
>> sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT,
>> WORKLOAD_PPLIB_DEFAULT_BIT),
>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,
>> WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING,
>> WORKLOAD_PPLIB_POWER_SAVING_BIT),
>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,
>> WORKLOAD_PPLIB_VIDEO_BIT),
>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,
>> WORKLOAD_PPLIB_VR_BIT),
>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,
>> WORKLOAD_PPLIB_COMPUTE_BIT),
>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
>> WORKLOAD_PPLIB_CUSTOM_BIT),
>> };
>>
>>
>> And this is the place of interaction with PMFW. (1 << workload_type) is
>> the mask being sent.
>>
>>          smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>>                                       1 << workload_type, NULL);
>>
>> In the end, driver implementation expects only one bit to be set.
> 
> Shashank and I had a discussion about this today.  I think there are a
> few thing we can do to handle this better:
> 
> 1. Set a flag that if the user changes the default via sysfs that
> overrides any runtime setting via an application since presumably that
> is what the user wants and we won't change the hint at runtime.
> 2. Drop the GET API.  There's no need for this, the hint is just a hint.

Double checked again based on Felix's comments on API definition. Driver 
decides the priority instead of FW. That way we can still keep Get API.

> 2. Have the driver arbitrate between the available workload profiles
> based on the numeric value of the hint (e.g., default < 3D < video <
> VR < compute) as the higher values are more aggressive in most cases.
> If requests come in for 3D and compute at the same time, the driver
> will select compute because it's value is highest.  Each hint type
> would be ref counted so we'd know what state to be in every time we go
> to set the state.  If all of the clients requesting compute go away,
> and only 3D requestors remain, we can switch to 3D.  If all refcounts
> go to 0, we go back to default.  This will not require any change to
> the current workload API in the SMU code.

Since PM layer decides priority, refcount can be kept at powerplay and 
swsmu layer instead of any higher level API.

User API may keep something like req_power_profile (for any 
logging/debug purpose) for the job preference.

Thanks,
Lijo

> 
> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>> Now, when we have a single workload:
>>> -> Job1: requests profile P1 via UAPI, ref count = 1
>>> -> driver sends flags for p1
>>> -> PM FW applies profile P1
>>> -> Job executes in profile P1
>>> -> Job goes to reset function, ref_count = 0,
>>> -> Power profile resets
>>>
>>> Now, we have conflicts only when we see multiple workloads (Job1 and Job 2)
>>> -> Job1: requests profile P1 via UAPI, ref count = 1
>>> -> driver sends flags for p1
>>> -> PM FW applies profile P1
>>> -> Job executes in profile P1
>>> -> Job2: requests profile P2 via UAPI, refcount = 2
>>> -> driver sends flags for (P1|P2)
>>> -> PM FW picks the more aggressive of the two (Say P1, stays in P1)
>>> -> Job1 goes to reset function, ref_count = 1, job1 does not reset power
>>> profile
>>> -> Job2 goes to reset function, ref_counter = 2, job 2 resets Power profile
>>> -> Power profile resets to None
>>>
>>> So this state machine looks like if there is only 1 job, it will be
>>> executed in desired mode. But if there are multiple, the most aggressive
>>> profile will be picked, and every job will be executed in atleast the
>>> requested power profile mode or higher.
>>>
>>> Do you find any problem so far ?
>>>
>>> - Shashank
>>>
>>>
>>>> Thanks,
>>>> Lijo
