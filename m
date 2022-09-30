Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200EFC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 09:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19D610EBFE;
	Fri, 30 Sep 2022 09:14:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E641410EBFE
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 09:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QU/Ik3bZlMJ5Kd6rR4/29k9T6hU1NT4bDfJN2aeqjMrRiPNcDKY8/rTPDW5QgqksO50/USGgv1jDzZUS8vcJVqcuxbU6/73oMLLjKv0nFfNzzlg4cU0f4W7CDj8g19Sqs7syTRP9hEr7bgtF5x3uV+ALKB4ODUH6D+8BevVCdE2Y1WxWEqa+iOnht+019rs8VbU1t66bDhz1+qCQSTZS1GWpQW/6MT3x2I2gmuflNY1RjuJeRSmAbTp7rDmuhr/9lLWVP1XaQyidXJewvJyWuQYQqIBomg9r6rAybKFV6eaq/MAgeYgiyYuK55K3aMZRwC4RB7aKKqmMt2FqhwMAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOCjvKRC3ysVYpcYug4xOgm/KYNic3La5GJtndaUhPw=;
 b=KVwL4YXUc7+mgOUtUXFKSxTd21K6EcSGJxg942qpoZdfOOuvEtQXy0Yt/G2Iicvn1OenQ3qCw63jiN4t3f9xuHqRlOGC0HZeYv11ZMwV/mPMgNy021FVp0EBYTSpTzclfMKvwrsoE00e4OPG2IKVmfHqJXveIHxHVE0zRpXg6zoBizypyMO+2M8It38sDyIZzpIxRa62L6a9xIYFFZDwALM5fmfbl0/eDFpPJVpRhUlzs2m5a+PiACMYsAFoM6Pv2KzoxwTHz9AtWP8PTKT0LDpxgdgHPl+tFnAgbQ/4HUUV1p/mFdZodRMIfOuxOgK2bGCQ/t4v4K/bzCgMqAstrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOCjvKRC3ysVYpcYug4xOgm/KYNic3La5GJtndaUhPw=;
 b=Q9U9QSWEbuRDM66xDbzwhTGNOJMJCTEf1UST0sIpQUMzaN5KZqFjcvFEQwOQoROBdw2lkfNZWcs/sMtTckGrtx3WwTEw9VaZapiCVMOTyzpftORN8cbqD3svg4AKqNMeDr2KSSRCP6pMpSv1mj+1rh1lXImL+KL1+zFoiFCbwqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SN7PR12MB6959.namprd12.prod.outlook.com (2603:10b6:806:261::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 09:14:07 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 09:14:01 +0000
Message-ID: <13d0e8ce-d67c-2972-a5d3-595f43945f7b@amd.com>
Date: Fri, 30 Sep 2022 14:43:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
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
 <3df64977-5862-5376-341f-c503987538ab@amd.com>
 <7fa32077-2653-efaa-39d5-f585bec6c2f0@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <7fa32077-2653-efaa-39d5-f585bec6c2f0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::17) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SN7PR12MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 394f6cbe-afdc-4c05-2ba4-08daa2c41cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ks/NSlYghvy95Yt2DNHSP/jNWTMeK5cM6UxEsjv4OY99rMXw1GWaWIGONKYj4cqNInutiFShePwLniPC0U2fjGOjSjs72Ymr/2c08l3/TMDEk40OYosxSU0PiGZPYHZcfLuj9KO7UUodh4dKFzanAm/WTO6Pn/1ZGlTUAP9Tjg43nw2DlyaVV3Z/amV+2cFeuG7KaSHzfwsK2TZmqSlqPjJ05p9h8bo0ZqkIkmti+OPERWDsUt2gf0M048e8h1IkpPzpX+pnwt9OkBFQ7yi5JJvB7lCDmjuToqdTA+M/V2SBJ80hAoQF26JUsug5xzIEgFvI1gd/c7lKysbJ/Q9NtKioiX3s+/o1100ODGwxjmoR1tpbifiKWxAB92JnNQ6Di5zE7OYNpfLTNmc9G6jIyuvaxpxT5PjQtaj6bhQikNltNLWV8cT5GpN1eZJWqReuXqbVl/YsYEJbQQqprBWpneLx3AgHk174rlnXNu9BEKI9yK9swoWDuAvWXprx1LFQLXpz+HkVoSdeFG6GEFCdbXREmmqkBLGO5ytJPkx8sCJc0GIIpPGOxiREV9Kc230e8+mCNsvccRNjkTfGMoHvERLhflmc5VFTPHHMgFffmdIb/NYni8EW14MLAE+0aQJPWAB6A0Cqv7kWq/E2ac4AKn1Zji8GQ7kJnFOkmry1PY3m/UcuHV/gLoZhno/NWtPM8/ebbEyYkloCQBx+vapOmm5CSrEtlz2z/AigCmW526ATkFw1y3OtS3PMNSOFMqpkfbZx5XxAY4opwvDPzgwMZzlJ+b1CZtHcramOZ8G3/oo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199015)(4326008)(8676002)(66946007)(66476007)(66556008)(38100700002)(316002)(6486002)(2616005)(478600001)(186003)(6506007)(53546011)(6666004)(26005)(31696002)(54906003)(110136005)(86362001)(36756003)(83380400001)(6512007)(31686004)(8936002)(41300700001)(5660300002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmtkN1RSMnczOTdVUUVncDRhVUkza3B6ckxHSzBSWTZLZTZ6VjhYRVVlM2tw?=
 =?utf-8?B?V3NwczFYUkJVU2pOQXlPLzNtWTU1cCtDU0c4THJpejY0TkpVaEFYSkJTdG9H?=
 =?utf-8?B?VGorb1dvdGNWTThjcG1LWXQ0aFd4bkRFNWJyRm9taWJNMmlQSjhFUEgxaE9w?=
 =?utf-8?B?S2c2ei9nWm9iTnpvT3F3Z29ua0lJOWhscVg0SDlKUE9MYzN3VG5RWFRMQkli?=
 =?utf-8?B?MkM4cUxhVmdXTFREMldWaDVHbHcyNlhVc25TbWQvZUpPek1pWEZtWmFmT0cv?=
 =?utf-8?B?M01QeGZmZmxDTkM3K280Rm1aVnlCYy9PYVFqYUFrMnkvRCtqeEE3d0lkUzMr?=
 =?utf-8?B?QU1zWDNkTDNOTlhWZkR0RWFsSVArSjRxemUxL3pOQU40MlpMSTd3NWJkOHg1?=
 =?utf-8?B?RXZySTBKKzZjRU1ycXBpYVhTaXYvazFCWjJZOEVOc3h4ZjBjMGFzellMQmVw?=
 =?utf-8?B?L0wrTnhFV1B2WXA1bjNrK3Z3aDk5a2JCSGJhYTZXb2k3cGdmbDVSMzYzZXQz?=
 =?utf-8?B?QUZDZExmb0MzMGRGUm91YVNZenoxbERGS3d4dTlIaGdlcEFnenk3QWg2ZUxF?=
 =?utf-8?B?WFJMSDBuWXZVU2k2QXJFbTRCckUremRpMXVzbTZSeFEvNVM4TU5Nbjg2bTlC?=
 =?utf-8?B?eXRyY2ZWc0JvdXZtRHladW9OTVh1ZFVVZXFLK1ZJb1FYT0xBMW1UaERRYW5V?=
 =?utf-8?B?alRNZS94bWxrSFNKb0JhMndRVTd6YUJrTVJVajhGSzJockFBUXNLeElHZVZm?=
 =?utf-8?B?QW9BTCswUUdFSFc1Ym5kMkl2V2tGa3orMEhES0hJU3Q5OGNXa1E3MndRUmo2?=
 =?utf-8?B?RlQ3UGx2ZXE3eGNLOHVPdkhKMzFBVC81WjduQnZYUCsybVdtUTZxWlYzbWd0?=
 =?utf-8?B?MDhiaVlJWGdUODJKeklFOU5vOUJEMWRTYnU3dC9oQS9WVXFGRml3ei9TTEgr?=
 =?utf-8?B?WTRhcTdGUUVDZk5VUUpXUWZOdjNBN1FZMEZROWRHTHdrbXF0a3hlZUVZT05v?=
 =?utf-8?B?Q3hiL2d6QVczN2NIWEI5UDZDLzRXTnV5b1FNNmJqTXZYN01ncTRubGpJZWtO?=
 =?utf-8?B?amdaNnBnUFplbDVZc1hiK25YME1oTkNzdnNHbVhRMHpLWXFPRTVlNERoM29v?=
 =?utf-8?B?OHhvd04wRUh6WWltZlhrSGdwREJhL2VNZjNpanFqNkZFNlVhbUl2QUJ3amd0?=
 =?utf-8?B?UzE1aTJpWjIzS0IrSkxMdEV5azNOa2VQZHB6WEhxY2hQZml2YkZCOUJrL2Jv?=
 =?utf-8?B?ZDhIbkltNjhDRUVML2p1STNwN09KMXVWS3lUU3NoRUs1ZkRKNWIrVnArZnNR?=
 =?utf-8?B?d3ExSWZUNlNtemI5N1EzVUtYL2lPalB2SVlyZVlpQmpmZmdHNXRiOFZYck1o?=
 =?utf-8?B?K3dvS3g1eHBUbFBPVUovMDVnQzZMbXpoblhkSi9scVd5MXRKTFh5c2dTMm9U?=
 =?utf-8?B?cklxUlQ0UVpvMm5NVHFCelphWGNVZXlOaDhsaXc0UTJPQ2UzamhldTZJelI4?=
 =?utf-8?B?MFRMdlFsaStzQ0xVVHhtcWhKQ1dBZGNqdi92NzlLTFdHWGxwMGlhbTFkQ2Ey?=
 =?utf-8?B?Sjk4ZVd0TTAxVGF4cC9LUTJxMWJLVjlpM3BJcFpXR2t0S21HS3k1bGhNazBr?=
 =?utf-8?B?S09GNStUZUJHSUh2WU9IMnVINDNybm15dzc0M0hRZi9vb281azFBdWIrY3BB?=
 =?utf-8?B?R2gxOEZCbXBaN2pvTWFxZFRPYUR2NHJnMGhXMVR4SWdqTHVyd2Y2dVdEKzhy?=
 =?utf-8?B?eFB4U0dacE4zNU9QK2lXOFF5bHBtSzBWNnJibE1vaWlhSkllMjFhOGlXSFhF?=
 =?utf-8?B?dHNCR3ZtSVRhOHNyM3Z6dnhpVmY1aVdzTW5qekJFUmNoVnBCL0liaGdDeEFH?=
 =?utf-8?B?Q1Zydk44SDl4ZWFXcm5GRXVtdmlOY1RVMDV4Qm1WVTRGM3VFQ3JJY2dMZ3BV?=
 =?utf-8?B?RFJoRlI5bmRycUo4bEZoWE8wdWt1REhJNkZjUFN1ekU2bWNpWGZ5QXhWN3Rw?=
 =?utf-8?B?Unpmb1pFcUJsWDRjUnp2RFE3cnBhSGNnWUJsT0hqbjhvTDlvVSs2cUl6ZnFj?=
 =?utf-8?B?T1lYOXBLclpJZ1hSK2liY2xXWWdrNDB1WGhsMzhVKzBDdFN2OGhvQmlmcjVZ?=
 =?utf-8?Q?fwikBKLdniz3aK6Xr3f25yjBU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394f6cbe-afdc-4c05-2ba4-08daa2c41cff
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 09:14:01.4652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+P01BTH6tLKNXp6M5OLA7Iw3xOOs3nC6n4V8PblhK+YpxkgT96qHX9sbzuK9utt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959
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



On 9/30/2022 2:07 PM, Sharma, Shashank wrote:
> 
> 
> On 9/30/2022 7:08 AM, Lazar, Lijo wrote:
>>
>>
>> On 9/30/2022 12:02 AM, Alex Deucher wrote:
>>> On Thu, Sep 29, 2022 at 10:14 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 9/29/2022 7:30 PM, Sharma, Shashank wrote:
>>>>>
>>>>>
>>>>> On 9/29/2022 3:37 PM, Lazar, Lijo wrote:
>>>>>> To be clear your understanding -
>>>>>>
>>>>>> Nothing is automatic in PMFW. PMFW picks a priority based on the
>>>>>> actual mask sent by driver.
>>>>>>
>>>>>> Assuming lower bits corresponds to highest priority -
>>>>>>
>>>>>> If driver sends a mask with Bit3 and Bit 0 set, PMFW will chose
>>>>>> profile that corresponds to Bit0. If driver sends a mask with Bit4
>>>>>> Bit2 set and rest unset, PMFW will chose profile that corresponds to
>>>>>> Bit2. However if driver sends a mask only with a single bit set, it
>>>>>> chooses the profile regardless of whatever was the previous 
>>>>>> profile. t
>>>>>> doesn't check if the existing profile > newly requested one. That is
>>>>>> the behavior.
>>>>>>
>>>>>> So if a job send chooses a profile that corresponds to Bit0, driver
>>>>>> will send that. Next time if another job chooses a profile that
>>>>>> corresponds to Bit1, PMFW will receive that as the new profile and
>>>>>> switch to that. It trusts the driver to send the proper workload 
>>>>>> mask.
>>>>>>
>>>>>> Hope that gives the picture.
>>>>>>
>>>>>
>>>>>
>>>>> Thanks, my understanding is also similar, referring to the core power
>>>>> switch profile function here:
>>>>> amd_powerplay.c::pp_dpm_switch_power_profile()
>>>>> *snip code*
>>>>> hwmgr->workload_mask |= (1 << hwmgr->workload_prority[type]);
>>>>>           index = fls(hwmgr->workload_mask);
>>>>>           index = index <= Workload_Policy_Max ? index - 1 : 0;
>>>>>           workload = hwmgr->workload_setting[index];
>>>>> *snip_code*
>>>>> hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload, 0);
>>>>>
>>>>> Here I can see that the new workload mask is appended into the 
>>>>> existing
>>>>> workload mask (not overwritten). So if we keep sending new
>>>>> workload_modes, they would be appended into the workload flags and
>>>>> finally the PM will pick the most aggressive one of all these 
>>>>> flags, as
>>>>> per its policy.
>>>>>
>>>>
>>>> Actually it's misleading -
>>>>
>>>> The path for sienna is -
>>>> set_power_profile_mode -> sienna_cichlid_set_power_profile_mode
>>>>
>>>>
>>>> This code here is a picking one based on lookup table.
>>>>
>>>>    workload_type = smu_cmn_to_asic_specific_index(smu,
>>>>
>>>> CMN2ASIC_MAPPING_WORKLOAD,
>>>>
>>>> smu->power_profile_mode);
>>>>
>>>> This is that lookup table -
>>>>
>>>> static struct cmn2asic_mapping
>>>> sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT,
>>>> WORKLOAD_PPLIB_DEFAULT_BIT),
>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,
>>>> WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING,
>>>> WORKLOAD_PPLIB_POWER_SAVING_BIT),
>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,
>>>> WORKLOAD_PPLIB_VIDEO_BIT),
>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,
>>>> WORKLOAD_PPLIB_VR_BIT),
>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,
>>>> WORKLOAD_PPLIB_COMPUTE_BIT),
>>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
>>>> WORKLOAD_PPLIB_CUSTOM_BIT),
>>>> };
>>>>
>>>>
>>>> And this is the place of interaction with PMFW. (1 << workload_type) is
>>>> the mask being sent.
>>>>
>>>>          smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>>>>                                       1 << workload_type, NULL);
>>>>
>>>> In the end, driver implementation expects only one bit to be set.
>>>
>>> Shashank and I had a discussion about this today.  I think there are a
>>> few thing we can do to handle this better:
>>>
>>> 1. Set a flag that if the user changes the default via sysfs that
>>> overrides any runtime setting via an application since presumably that
>>> is what the user wants and we won't change the hint at runtime.
>>> 2. Drop the GET API.  There's no need for this, the hint is just a hint.
>>
>> Double checked again based on Felix's comments on API definition. 
>> Driver decides the priority instead of FW. That way we can still keep 
>> Get API.
>>
>>> 2. Have the driver arbitrate between the available workload profiles
>>> based on the numeric value of the hint (e.g., default < 3D < video <
>>> VR < compute) as the higher values are more aggressive in most cases.
>>> If requests come in for 3D and compute at the same time, the driver
>>> will select compute because it's value is highest.  Each hint type
>>> would be ref counted so we'd know what state to be in every time we go
>>> to set the state.  If all of the clients requesting compute go away,
>>> and only 3D requestors remain, we can switch to 3D.  If all refcounts
>>> go to 0, we go back to default.  This will not require any change to
>>> the current workload API in the SMU code.
>>
>> Since PM layer decides priority, refcount can be kept at powerplay and 
>> swsmu layer instead of any higher level API.
>>
>> User API may keep something like req_power_profile (for any 
>> logging/debug purpose) for the job preference.
> 
> No, I think there has been enough confusion around this implementation 
> so far, we will implement this just as Alex/Felix suggested:
> - No change will be done in pm/SMU layer.

Well, a confusion doesn't justify bad implementation. You could just 
keep the refcount in workload_setting.

Another API that uses power profile indirectly also will need to take 
care of refcount and we don't need every other API to do that separately 
without knowing what is the final outcome.

Thanks,
Lijo

> - The amdgpu_context_workload layer will keep the ref_counting and 
> user_workload_hint management, and it will just call and consume the 
> pm_switch_workload profile() like any other client.

> - We will add a force flag for calls coming from sysfs() interface, and 
> it will take the highest priority. No state machine will be managed for 
> sysfs, and it will work as it is working today.
> 
> - Shashank
> 
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Alex
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Now, when we have a single workload:
>>>>> -> Job1: requests profile P1 via UAPI, ref count = 1
>>>>> -> driver sends flags for p1
>>>>> -> PM FW applies profile P1
>>>>> -> Job executes in profile P1
>>>>> -> Job goes to reset function, ref_count = 0,
>>>>> -> Power profile resets
>>>>>
>>>>> Now, we have conflicts only when we see multiple workloads (Job1 
>>>>> and Job 2)
>>>>> -> Job1: requests profile P1 via UAPI, ref count = 1
>>>>> -> driver sends flags for p1
>>>>> -> PM FW applies profile P1
>>>>> -> Job executes in profile P1
>>>>> -> Job2: requests profile P2 via UAPI, refcount = 2
>>>>> -> driver sends flags for (P1|P2)
>>>>> -> PM FW picks the more aggressive of the two (Say P1, stays in P1)
>>>>> -> Job1 goes to reset function, ref_count = 1, job1 does not reset 
>>>>> power
>>>>> profile
>>>>> -> Job2 goes to reset function, ref_counter = 2, job 2 resets Power 
>>>>> profile
>>>>> -> Power profile resets to None
>>>>>
>>>>> So this state machine looks like if there is only 1 job, it will be
>>>>> executed in desired mode. But if there are multiple, the most 
>>>>> aggressive
>>>>> profile will be picked, and every job will be executed in atleast the
>>>>> requested power profile mode or higher.
>>>>>
>>>>> Do you find any problem so far ?
>>>>>
>>>>> - Shashank
>>>>>
>>>>>
>>>>>> Thanks,
>>>>>> Lijo
