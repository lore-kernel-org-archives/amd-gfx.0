Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE7FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 08:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F07C710EBB9;
	Fri, 30 Sep 2022 08:37:42 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B339210EBB9
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 08:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOa5eSjgXjyuSHV8NIEcQg9iAn6KgzQNwBB8t2fXDvV1X90f+WIqlu6GwQojYyT5E1Jaiumzb+ZZieN1VAZgFn8PCEqAn/hxUyDd7eOxX+YpgiAlJo4jg8eQYN54CcYyMSaEMlMT3fETV9jDJjDKbD0kqZr0mBebCGd5VLhwR4GBWqS/C6K2WMNlXtKqEpwxMS4yIguPDCyHSeNEUmTILTYtuAjx+s/BMJ0QQXNAgZitci5b8pCww7q13FsRvpXBQ5xQjA0sr2PxCDczBPsfMvSp2j+kcuPrL2dQVZ8l7/0iMqLD16kHGlyi+pZiJ0nlO0mdxll4UpMIW2cEClSAbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7GOeeOfCa3sRZhd/rcrsGVT12vGy3ttpeAq6mA5GJQ=;
 b=MEe5Q0x0T377ud1lxB30jcd7Gjz8uHT1uEWLZMsba6Dn0BHxPJJxHJBiuz0SXZhuBKa263kH7Hj5Jj/fVB2E+xsoruUy0uPlgmHlJSqf0THeCtUcARj8Su7dk9uIJqXFLi2m/xyqrUT/sQi/x1eQxFfyabrY+dzQ7EVTOmgX2l39gMfSR0wWfVqrOH3m16m4fZ7PxRqFHV3f2rq5tErj96RGH7QboGZG0Euah/i7EgXwiIOrrSXYrZTVzsvYks78IJHylnaMI/3JyCfb5SUnnCkMDPB+NtQViCnDgB1bnmOyty3f3hiqvoUc9S82gcq+8biwVXncFrtQJtFjadhB8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7GOeeOfCa3sRZhd/rcrsGVT12vGy3ttpeAq6mA5GJQ=;
 b=XkLUewSS8yznyozMnKcyH3zG33mSFGH4TUJVNsRoO5MuHnsQXI7Xe7bcQHdmf7uWvn+c2ec48QhnqS7A4mlQmxfkOW2z8BqcIL8HLeHV1IEy6Eazh9e+kiOHJFB4LsBeh5ekaH2ltQ7wsmgQaB3QCAkV0u7bDnRkRM3sWUKX2jM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Fri, 30 Sep
 2022 08:37:35 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::fb8b:ad89:85c3:c961%5]) with mapi id 15.20.5676.017; Fri, 30 Sep 2022
 08:37:34 +0000
Message-ID: <7fa32077-2653-efaa-39d5-f585bec6c2f0@amd.com>
Date: Fri, 30 Sep 2022 10:37:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
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
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <3df64977-5862-5376-341f-c503987538ab@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::8) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: aecd837a-1c19-48f2-6c64-08daa2bf056e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7B62AzqRevm79T4ysCeOKyiJkwgQn7ty1+tVB9VM3gLLIPYld8gXoHEM2MCNXn5PbqTT8+er1irPp4TFqQ+Oi66uZCgU+Y7eQPyECoqtJOPyGuJpto7SCwtFUGzVsTr6C/Mi4zlFDF2w1PEVDXBXYuQEIFfyZ40DN7psfxNHAt2KO/QnzGRZhttfmepV7dQTvPTYXcPEL2/9L8ssy6Ns0bd3VP/s+Q99tVJNPQLnBHpymbZcrR4YumEl6F1xXI9PDm1ruYKF4hCRMm6kslWWuO6s4ifX9b51/rMNiwjmjaAwQQyQn1uTW12LxVU7g6CvaEiPKoAWuQ6/LS8rD00f9lzeeu9GCSJPTs3tB4FI0KObU+OWKLE1VNdYbR4yw22kd4Rc8uU5PcwKQqneNjXi0I2I4n18u1Swul9jM1WMKoX0kCQyXfw1H8SxkHpK8SDKiiCB56bwhCjnhErbYmPAY0jsKORPXC5vRRMmI9UZL2O7ssjKZma46ZmGEH9W0Lm5+ntsSv0E1wsbO0UC6ZuI3vqrWwAxEXdvbhqQpFZ7iylH772VxDHNhFEwvSfe8+SohhySEkKi4saiJfq/u6rOYgaWSX35K2SzdrrIugfnMohAjqmlZByc/XTZk4c/r4Xl+per9q0/M3604lGqaQX6/sMDaR3ZoIS5xgHLWcpBCZudkqKK287kOYpx21M5aJ42gLSwwZd9V7p5bveTadP6Gx4nQayV4lOznLpgR5mYNAy9jK+ikU0t8ykKOVgG5LQMhTU3QL/8NzpAJUwjBjUJOFq4OD9BFer5G7TYGCGjqpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(83380400001)(66946007)(5660300002)(66556008)(38100700002)(36756003)(110136005)(86362001)(66476007)(53546011)(2906002)(26005)(31696002)(2616005)(478600001)(186003)(8676002)(41300700001)(6486002)(6666004)(6506007)(6512007)(4326008)(316002)(54906003)(8936002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UStYT1lDdXREMEFJdTJHVGRGVzNFWkRkR2V2SlJZbVdMbVRScVM2K29GdE5U?=
 =?utf-8?B?S3k1QWZHSEl6MlZvMkpNUDI3Y09meHhlVGZGSUtrYXk2eFdjLzNJTGhhbmV0?=
 =?utf-8?B?eE43Y2laTnFQSGhuUlR2bC9NY0g0WVNpZlFjYnFqUzFKbHBNdWRYeThQenY1?=
 =?utf-8?B?MDZVbCtPV2pwZzFoSmtKNjZBbkRaWHZEa1pKWVFZY1VYNjc1MEd0VTVZZlRH?=
 =?utf-8?B?NDNBRUdkei9uMGM5ek5YWmJoUlVXTEV1NCtrT3RwNG5sUTV5NXNBWjFiMnJz?=
 =?utf-8?B?dm1QVVJiOEVoSXFFc2pWcHBQVkhPdk9oZGs1Y3YrMVBLV0hYOXRtaU85RDRI?=
 =?utf-8?B?TlAxOThGUmZnWjlQWnN1YW1vdlIvL2VjNUptRzdFVXJXMFFDbWhNcDhGZC9Q?=
 =?utf-8?B?RlpSQjlndGxDUm9wTmt4Tng3clNENzMrT3BscVZXdUxxOEg4SkxrRkFjRmJy?=
 =?utf-8?B?TWg0S2g4aXVNamswbUQvMmNoeTNiQVF4anVRVUpRUTNKR0xrOTFoa3NCcFlt?=
 =?utf-8?B?NG83VktPeENNYlR0d09IRVhLUHc1SWplTUFYWHkwRjI2Q2EwTEtXZFA2c2F3?=
 =?utf-8?B?T0J1c2o2V3lBWkcyRDNiM2JDS3l1OHFTeUtQMUtmYm0yNlZmaWcvc0s2RFNQ?=
 =?utf-8?B?M2c2YnBGSUl3RW9pVzlYMHc2SzVYSy9GM0c3eTJiUTVFcHd0M0xhaDVtMm02?=
 =?utf-8?B?UzFxRWI3cW5kQUVROHBCSGc4aWdLRmJldXlyU0ovN2d5MEpuTDYwckhFbFVt?=
 =?utf-8?B?eTVzNWVCbTViS1doeXBNcFBXUitEbmtnU1lXdzlkWUw2a21oWVlDc3pmVVNt?=
 =?utf-8?B?UFRGQitrVnFNMi9FYit6ZzhJWkpSUFFXbmNRSnR4eWxKbm5LeDY2aVpjNW9F?=
 =?utf-8?B?M1dPYVhIa0ZrcU5aMDJVV01PR3hyNlRJNHRIZDVmZEQ1RzMweld6K1Q0VG8y?=
 =?utf-8?B?NFVaQXVjLzhoM2dPakwvYXdKd1hZN2RMbVhuSEZRUjRiMnk1OWlNeWdKaTNv?=
 =?utf-8?B?UXY3dXRUWWdqK3NhakM0M1dJRkNQUzhpdnczNmtBUTBEUENDSDE2cEtUMndT?=
 =?utf-8?B?Mi94YS9KWkplS2ZadU5KaVpOTTJLU1hiRm9MMUhDVThyNG1CVzZlNmtmUnA2?=
 =?utf-8?B?clNHUHRPeUNoU0RlbUg5MWJtamJUc0FFK1RrZkVmUlQ4WktCU2NrUjFOMTNS?=
 =?utf-8?B?U0RWaEdhc3RlbkNMT0JhbDh6dzgzQmxSaE1vUHJwUEw4ekY1U1p6d3Z5Wlgv?=
 =?utf-8?B?bDlTQ2VxTW05TkZCckFVTkxWeFExVEJwMXR2dXY1NC95RzdsSldNYlpMWUFz?=
 =?utf-8?B?dm9sU29iT0pZQ2VWNTgyTlcrb09kSGR6K3RXTG92VSt5NkNNWTdYM2RrcE9a?=
 =?utf-8?B?VmFtNHV3UWJxQitiMVFrNlJEeER5eUk0TWJVSEJrZHE5bGoxSUowSlRIQitI?=
 =?utf-8?B?NlZTb0NJR0I1bWZIdUJGeXUwMW5HUU9CTkxqTFNIU01YVFg0MEx0Wkc1b2gy?=
 =?utf-8?B?L2tQSXNKZnZYT1VOYnB2elhybzZLMlRuL1lESUxXL01QUWN2cDk3L1haNkJt?=
 =?utf-8?B?bE9NWm85ME9xZU1uQnFvdGNWT0EvYUMzdjB0MjZVN1F2VUVHNmN5L0FrWVp2?=
 =?utf-8?B?L0xML2pIQVhqTWxjQlkxWlY2VkZXdlFlMGUyMmpFOHR5Z2lOK1J1ZXZmS1Zy?=
 =?utf-8?B?dUJBbG9icStEalRZVlFQVXpSR3lRUm5zYXRrVWVMSjJVTlNVakgrbW5wenJw?=
 =?utf-8?B?SUw2SzJqM2tLUlpzb1UwVzZzYkJTWGExeXBaMlEzZEpxT0FHaFlTcjhVT3F5?=
 =?utf-8?B?RjJQaUxmdms4L2VITThWRHJ5WUtDbk4zMWwzU0puWW9pclRLQzF6eUhaZE9u?=
 =?utf-8?B?KzVvTUx4Q3pOUFpmYnkrWkZGWVNYZ2lSYUt3c1JneHRNMlUzay9UTVlDU21T?=
 =?utf-8?B?RFpwbllhWXJjUlRSbDNXdWZDL1g2OFZGSlplQzMwYUhMMlpnRVU1cTc2RHhY?=
 =?utf-8?B?RWErYjVsWUFsQnUyNGY4d2R1MCs0K3NLVjJBWGQ2bCtDY1pNc0NBZHVIWGxu?=
 =?utf-8?B?aVB3Y3drZVVXeWJYWGNMMDRNeEw1N2ZBQUhldVZqTWI5bW9QWTVXbERKLzdY?=
 =?utf-8?Q?DNDkCAG88dtW0s3FxvAscNKJs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecd837a-1c19-48f2-6c64-08daa2bf056e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 08:37:34.2851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02rlBNR8rLHtipKxwjKd9h9cLcufQtia8p7COpV7p+e/8a/NK1l7Nk6qoASpqsgbO3TmDuiWn1n7b+Ty9SK8dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034
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



On 9/30/2022 7:08 AM, Lazar, Lijo wrote:
> 
> 
> On 9/30/2022 12:02 AM, Alex Deucher wrote:
>> On Thu, Sep 29, 2022 at 10:14 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>
>>>
>>>
>>> On 9/29/2022 7:30 PM, Sharma, Shashank wrote:
>>>>
>>>>
>>>> On 9/29/2022 3:37 PM, Lazar, Lijo wrote:
>>>>> To be clear your understanding -
>>>>>
>>>>> Nothing is automatic in PMFW. PMFW picks a priority based on the
>>>>> actual mask sent by driver.
>>>>>
>>>>> Assuming lower bits corresponds to highest priority -
>>>>>
>>>>> If driver sends a mask with Bit3 and Bit 0 set, PMFW will chose
>>>>> profile that corresponds to Bit0. If driver sends a mask with Bit4
>>>>> Bit2 set and rest unset, PMFW will chose profile that corresponds to
>>>>> Bit2. However if driver sends a mask only with a single bit set, it
>>>>> chooses the profile regardless of whatever was the previous profile. t
>>>>> doesn't check if the existing profile > newly requested one. That is
>>>>> the behavior.
>>>>>
>>>>> So if a job send chooses a profile that corresponds to Bit0, driver
>>>>> will send that. Next time if another job chooses a profile that
>>>>> corresponds to Bit1, PMFW will receive that as the new profile and
>>>>> switch to that. It trusts the driver to send the proper workload mask.
>>>>>
>>>>> Hope that gives the picture.
>>>>>
>>>>
>>>>
>>>> Thanks, my understanding is also similar, referring to the core power
>>>> switch profile function here:
>>>> amd_powerplay.c::pp_dpm_switch_power_profile()
>>>> *snip code*
>>>> hwmgr->workload_mask |= (1 << hwmgr->workload_prority[type]);
>>>>           index = fls(hwmgr->workload_mask);
>>>>           index = index <= Workload_Policy_Max ? index - 1 : 0;
>>>>           workload = hwmgr->workload_setting[index];
>>>> *snip_code*
>>>> hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload, 0);
>>>>
>>>> Here I can see that the new workload mask is appended into the existing
>>>> workload mask (not overwritten). So if we keep sending new
>>>> workload_modes, they would be appended into the workload flags and
>>>> finally the PM will pick the most aggressive one of all these flags, as
>>>> per its policy.
>>>>
>>>
>>> Actually it's misleading -
>>>
>>> The path for sienna is -
>>> set_power_profile_mode -> sienna_cichlid_set_power_profile_mode
>>>
>>>
>>> This code here is a picking one based on lookup table.
>>>
>>>    workload_type = smu_cmn_to_asic_specific_index(smu,
>>>
>>> CMN2ASIC_MAPPING_WORKLOAD,
>>>
>>> smu->power_profile_mode);
>>>
>>> This is that lookup table -
>>>
>>> static struct cmn2asic_mapping
>>> sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT,
>>> WORKLOAD_PPLIB_DEFAULT_BIT),
>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,
>>> WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING,
>>> WORKLOAD_PPLIB_POWER_SAVING_BIT),
>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,
>>> WORKLOAD_PPLIB_VIDEO_BIT),
>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,
>>> WORKLOAD_PPLIB_VR_BIT),
>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,
>>> WORKLOAD_PPLIB_COMPUTE_BIT),
>>>           WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
>>> WORKLOAD_PPLIB_CUSTOM_BIT),
>>> };
>>>
>>>
>>> And this is the place of interaction with PMFW. (1 << workload_type) is
>>> the mask being sent.
>>>
>>>          smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>>>                                       1 << workload_type, NULL);
>>>
>>> In the end, driver implementation expects only one bit to be set.
>>
>> Shashank and I had a discussion about this today.  I think there are a
>> few thing we can do to handle this better:
>>
>> 1. Set a flag that if the user changes the default via sysfs that
>> overrides any runtime setting via an application since presumably that
>> is what the user wants and we won't change the hint at runtime.
>> 2. Drop the GET API.  There's no need for this, the hint is just a hint.
> 
> Double checked again based on Felix's comments on API definition. Driver 
> decides the priority instead of FW. That way we can still keep Get API.
> 
>> 2. Have the driver arbitrate between the available workload profiles
>> based on the numeric value of the hint (e.g., default < 3D < video <
>> VR < compute) as the higher values are more aggressive in most cases.
>> If requests come in for 3D and compute at the same time, the driver
>> will select compute because it's value is highest.  Each hint type
>> would be ref counted so we'd know what state to be in every time we go
>> to set the state.  If all of the clients requesting compute go away,
>> and only 3D requestors remain, we can switch to 3D.  If all refcounts
>> go to 0, we go back to default.  This will not require any change to
>> the current workload API in the SMU code.
> 
> Since PM layer decides priority, refcount can be kept at powerplay and 
> swsmu layer instead of any higher level API.
> 
> User API may keep something like req_power_profile (for any 
> logging/debug purpose) for the job preference.

No, I think there has been enough confusion around this implementation 
so far, we will implement this just as Alex/Felix suggested:
- No change will be done in pm/SMU layer.
- The amdgpu_context_workload layer will keep the ref_counting and 
user_workload_hint management, and it will just call and consume the 
pm_switch_workload profile() like any other client.
- We will add a force flag for calls coming from sysfs() interface, and 
it will take the highest priority. No state machine will be managed for 
sysfs, and it will work as it is working today.

- Shashank

> 
> Thanks,
> Lijo
> 
>>
>> Alex
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Now, when we have a single workload:
>>>> -> Job1: requests profile P1 via UAPI, ref count = 1
>>>> -> driver sends flags for p1
>>>> -> PM FW applies profile P1
>>>> -> Job executes in profile P1
>>>> -> Job goes to reset function, ref_count = 0,
>>>> -> Power profile resets
>>>>
>>>> Now, we have conflicts only when we see multiple workloads (Job1 and 
>>>> Job 2)
>>>> -> Job1: requests profile P1 via UAPI, ref count = 1
>>>> -> driver sends flags for p1
>>>> -> PM FW applies profile P1
>>>> -> Job executes in profile P1
>>>> -> Job2: requests profile P2 via UAPI, refcount = 2
>>>> -> driver sends flags for (P1|P2)
>>>> -> PM FW picks the more aggressive of the two (Say P1, stays in P1)
>>>> -> Job1 goes to reset function, ref_count = 1, job1 does not reset 
>>>> power
>>>> profile
>>>> -> Job2 goes to reset function, ref_counter = 2, job 2 resets Power 
>>>> profile
>>>> -> Power profile resets to None
>>>>
>>>> So this state machine looks like if there is only 1 job, it will be
>>>> executed in desired mode. But if there are multiple, the most 
>>>> aggressive
>>>> profile will be picked, and every job will be executed in atleast the
>>>> requested power profile mode or higher.
>>>>
>>>> Do you find any problem so far ?
>>>>
>>>> - Shashank
>>>>
>>>>
>>>>> Thanks,
>>>>> Lijo
