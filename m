Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E02C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 14:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC5F110E5E7;
	Thu, 29 Sep 2022 14:14:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7A2410E5E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 14:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQNcSZkMDnILQTcdedxpGU8nkzpCPGrP5ucnV7Md+4eOryuP7Fkl/PhqEpUGU8cIvXBBBNEQyr7Fn3QVdyjvB2WybGSIUR4RkHOO0f8bgxVPUMUIka+fb6RYRYt2Gm+UiLGZcffuVZaSBm20tbsiQ6tidoTy+GMDjaOD9KKxFvNX6KYRdN1EFbLHkWdGBJnN35dQ+swTHrxhPcPHOdZDfbzbz7Ml2Do4tNz/l/eoIXZ4xSEGn84Qnkt/qR1n1e42JQSdF8k0LAStZlE6GchB7z3Pk4Ztsf1OnWUy0dJDMAv5F3n15oZTzBmSkK6mDV1WDvB+EWpkAJpo4zPUtPfhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDdTaQr/hkwMfXen7kuPEM7pcrR466M067xK6Da5tk0=;
 b=i7EO2IcVpkjYQkHwhmSUrmy3IgM9PW1WqMOH3JbXSVj0Y5337EJ8P/C4uzvRWQHULXZJ0KmnUfsAptP5tRkHbg6ynMs2PGII7OYMmVtwktRcs+7QwQsHRi8yRZZkPGBI55uUHhJN7Qubmgr/zBhw+kOwd9WIHxtnokzeIQ62qqpnGELIU5FBAvi79MrJnTLztE2GIXOckhHZgnvOjJLoQJ09XVOU2S2X8o7WWoOf+/eyO4LudDBcJLnFcxgG9oUHF5VE8gfU62A+L9HNgfQlkyswiKVqx/Y4aylXB2w1mbK38fAY90e7n2FfJjHvTsxz/jt6i0SwpzKvEWxouWGFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDdTaQr/hkwMfXen7kuPEM7pcrR466M067xK6Da5tk0=;
 b=CEopMN0S+ZbuNh/ntK1fZqAHWtBMU4tJu7AoPR3fTZUavxXi0j8BV3sKM0FThc9g2ZkgJofJ/1qH1LY6CF4NrKG3LhjAAX80IJt3AZR8kyFB2XwmaBqa4fZy7bZr8OzRs9AEck8DTSV8LrskAMvQfiJIhVJZpDIwrJ9wQe8IKZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Thu, 29 Sep
 2022 14:14:47 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 14:14:47 +0000
Message-ID: <46b27eb5-1807-044f-111a-bb67622e7fd6@amd.com>
Date: Thu, 29 Sep 2022 19:44:37 +0530
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
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <fc87e88d-4de0-f307-1fb2-658df564a3a1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::16) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d1c619-bbcb-4219-7117-08daa224f6dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuaAo+gfLJ23sBIyuKr+kQRib8r8Vxrcfc9Gs/+CpPJtNMLd31jpi0Vz+9hDAK7l4pOdh/6QvcT4vix0RPuLspJbwv0T0A8qxPsarYBnzWeywe0Y7HRTVltEo/leakwTnznIzct4XOCARAQ2Q+ptib39d/GZRtaBOY6PlsfaPSjuCLQCIXHQmZ04wYl4vkdlE96MjX+b5oA2wG7YY7npfIzE+aShtTm/VYzwmaFGO4TnxeoAvFszjepL6wQTkA6BsaN3kW4VNExViNpGx/dVPdxsAaNUUmHgFiXpaXieZFkgm6rZo1TgASkFkAvWJ/8CmUUIZ7/aCY+MgPkI/3cuG3Ofuv44JVXh2tkAJd/mgB4G+SiV4CCkKErbdhj/mhALzJ48sSmOxfCaoyWJyUWEekvQzTGfwopl1VFs/HHOadLHZatd3Eekbaj5P23fQvWFaY6vn1WyS3Peki+2PzuxZXig6QFjzB73D10tCliEFTwvbbSFJcq+aNKU56Thj9nzGYG1t8hBFnij1D7aqq7YwTRCsoMhgk3eA4BjXSE8hpRzmifcrs7+FcN0Wvn1+vy+n/wzqXhkvW1dRgSmv/8W2tUcvU78S6rypAotgdMYUoMBU4NK7oYxSfcR2Tjj8k9DXKJ7Oj/XQS5/VO+9Cs34Of9QHr17urSNruLeXQ46eDY1snq480O5kai9392XeKhb4u8Fgq1YxAztxGyRv7ll70luPqIKegeguGSSG33AO2o1GOeg62M6180w7Udhd974LEHnHecbok2ZZnmIqtrNnNto4RuzRr3ndFTKIonVBik=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199015)(38100700002)(83380400001)(31686004)(26005)(6486002)(478600001)(2616005)(6666004)(316002)(6512007)(186003)(110136005)(54906003)(86362001)(53546011)(6506007)(31696002)(8676002)(2906002)(41300700001)(5660300002)(8936002)(66556008)(66476007)(66946007)(36756003)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUczNkFuNnhQaERhNDMvNmFDVXFEeGpWY3pVUDR2NGREVnYwc0tmRm1GVGUv?=
 =?utf-8?B?bitOUWFjWk0rdXdiSTd6L2FUaXlCTTEra05KRVpNRTA3VjVKOTNsbXJqRFFD?=
 =?utf-8?B?K2RXZkVVRk5sVnh5MHAydXk3MjluTWdTNjhNdnJ2N000a1Z1Q3pvYVp3aTRj?=
 =?utf-8?B?a043a0U2ZXYwSTBlWkUxWWtsOW96SUFCOXZXL1NlbFlLL3VoczlqV1gxdDZK?=
 =?utf-8?B?Q1BRcXRVUElidU9wK3YrSFRxRXhoczlsdHpNcExzemhIUUdxaEVuZXZnQUNR?=
 =?utf-8?B?ZHBoald0R0xSdFpxb3dBcmc1Y1BlUHpaeTZ0dGMyQWREdkg3bzNhUzVnMi9t?=
 =?utf-8?B?eWFNVDdGaDFNZUxUQjZYb0lzeWhBYXJTTFdSMzBmZlRxU3lWUDRSTTFwa3Qr?=
 =?utf-8?B?RHJ1Z0pWQUkySHNEek5BcWd6WXh3SUlLWnJBRUpxeXZNSGRQekVtTnZXYkYv?=
 =?utf-8?B?VFdNZHRRSHVpTjU2RkZZTWU4SEVNTG5FMDFmRzhtSkZsU1BXeHRFekpRSTJX?=
 =?utf-8?B?ZnZsckxqTGl5ZEk0SU1BcmVIaGcxOWp6OWEzaThmaVV6elh3cTNNZ20rTm1l?=
 =?utf-8?B?MmkzVE12R1hJL2RTQVBrN3cycXFjT3N1aGVRWmlDdCtYcjlPYlBLaXRGTFRH?=
 =?utf-8?B?SkNwL0tsVWZiN2NITG0vekNpRTJ6WDJXbksyQUMrVDMrdDJJeGxHY2JYRExy?=
 =?utf-8?B?d0U1YjZBczYvdVFzRTkxdTBiT2pjOHhCWmwxc2h6TDlsa0hscGpZdHdUSW4w?=
 =?utf-8?B?aUJIazhTc3EzdGpSd2EzbXdOd29oNmxaeWVLdW16aVBTdXoveDBBVHdJZ1B4?=
 =?utf-8?B?azhlWkxrdWNNbU5va0s2YjZYVDFPdGQ0MEpUK2FlUkExOUdpYStpWDBDOFMx?=
 =?utf-8?B?YTlGOElxWUt3cnBzbm4xd1dtYTdpSUtQWHBCRDVhcDVxZjRNblgzdnFHWTdQ?=
 =?utf-8?B?UFE1Z1hrbUNMZkh1c2FTM0oxdTVGRTFlb2svaWFnaEJydFF0NFR2cm5vNFJK?=
 =?utf-8?B?UVpkUzZHazJNell0eW9KRS9xaTMvWmxuQmJLOGM2RjdET3RnZjNUVTV3N0ZI?=
 =?utf-8?B?T0l5WEt3elhkeHc5TFFqSHEzcHNwM0xmVWlvdkE1ZzQvTElNMnZtTm5Md1dj?=
 =?utf-8?B?djBSZlYvYkVsdDF0cVVJTWMvZnliUTh1Njc2V1FtdUhiZzlMcUllTVFZdjVq?=
 =?utf-8?B?akJXRCtMa0l2aW1WSUVTbDlsZncrUlo1aVp5azRwd0ZqeWdKZ0dIODVVWkMz?=
 =?utf-8?B?RlVER1dtZ1ppT3JyYm1SN0hyeE82d0dUVTVGSUVnVDdyY05ZRG1WSlpyazVz?=
 =?utf-8?B?WUljS1AvMGtNUkt5Z2dNTkJzanlOcjFqUVVuT2VtZ1hHZXBFcnpYc21KWE5P?=
 =?utf-8?B?TmtWR0tOQnljWnNXQTNSTlp4cXFPY0VrSEl3Y24wVjR0aE5WZHFmcGhiSGhQ?=
 =?utf-8?B?NkI5aEFRa3lzOXRLamd3THlKZ0VNeTczVWl5OVdLN0hMS01kdExGQVU5MVFL?=
 =?utf-8?B?aUMrMTJQeHdaU2J6YlR1cldCcEpZOEdEZjE5cnhjdHU3WkJYODZWdjRIZHJJ?=
 =?utf-8?B?cVlDeXRlTnd3cGJWZVJ3T3BnM3JXUVhvZm9EU0NRN24wUnl1cG9JcXNhdU1a?=
 =?utf-8?B?SFd1b1FnODFQeXErRmlSSUJOUUpESkxRdFVObzZPbmZEMkZCWnZyK1hXdW1r?=
 =?utf-8?B?WUNjQTRIRzhqeHcxYkhETmR1MlRReXMrQlk3bEg3a0M3TU5TcUlhbmVFL0Rx?=
 =?utf-8?B?alI2TGUzODBjNlVvejVHaklRZnF5ODJxSUJaNHdtT25ORXI3YVB4Zkp4dVhE?=
 =?utf-8?B?WDBUM1FwdEMvU0RDdjZ0Q1llQVl0cnpyMnlYZ3MzTFJaY210eGtnODNYclFY?=
 =?utf-8?B?bmtzSVMyYlFESDROc0RwcEhHOHJKWm4zZTFGN1FKUHRtNE5wUDByUXRpeDJG?=
 =?utf-8?B?NjZHYkVmWXhjYUtMZW1zVHhFajM1THBORitadk5XKzB4Um5PQ3ZHVnpSU3NG?=
 =?utf-8?B?aTFpek8rTTJQUTI2dXZJdjRWdEVMSG9RbnN0NEgxMXlVcnFPWlFxbS9uNWhs?=
 =?utf-8?B?K21uNGJ3S21USkNlSy8zZEg1WStjaXRPeEEzc3lZbExudlU0Mk4yNFJUYlV3?=
 =?utf-8?Q?WbPepbEaBMRSrQapWQ2GjRLTj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d1c619-bbcb-4219-7117-08daa224f6dc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 14:14:47.3635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOKNMbz8IV8sNTfHy9/5XpSTjLRTtZ1VjfyV2lJZWC8SEx3/HPY7pxxVI+di1wSp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729
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



On 9/29/2022 7:30 PM, Sharma, Shashank wrote:
> 
> 
> On 9/29/2022 3:37 PM, Lazar, Lijo wrote:
>> To be clear your understanding -
>>
>> Nothing is automatic in PMFW. PMFW picks a priority based on the 
>> actual mask sent by driver.
>>
>> Assuming lower bits corresponds to highest priority -
>>
>> If driver sends a mask with Bit3 and Bit 0 set, PMFW will chose 
>> profile that corresponds to Bit0. If driver sends a mask with Bit4 
>> Bit2 set and rest unset, PMFW will chose profile that corresponds to 
>> Bit2. However if driver sends a mask only with a single bit set, it 
>> chooses the profile regardless of whatever was the previous profile. t 
>> doesn't check if the existing profile > newly requested one. That is 
>> the behavior.
>>
>> So if a job send chooses a profile that corresponds to Bit0, driver 
>> will send that. Next time if another job chooses a profile that 
>> corresponds to Bit1, PMFW will receive that as the new profile and 
>> switch to that. It trusts the driver to send the proper workload mask.
>>
>> Hope that gives the picture.
>>
> 
> 
> Thanks, my understanding is also similar, referring to the core power 
> switch profile function here: 
> amd_powerplay.c::pp_dpm_switch_power_profile()
> *snip code*
> hwmgr->workload_mask |= (1 << hwmgr->workload_prority[type]);
>          index = fls(hwmgr->workload_mask);
>          index = index <= Workload_Policy_Max ? index - 1 : 0;
>          workload = hwmgr->workload_setting[index];
> *snip_code*
> hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload, 0);
> 
> Here I can see that the new workload mask is appended into the existing 
> workload mask (not overwritten). So if we keep sending new 
> workload_modes, they would be appended into the workload flags and 
> finally the PM will pick the most aggressive one of all these flags, as 
> per its policy.
> 

Actually it's misleading -

The path for sienna is -
set_power_profile_mode -> sienna_cichlid_set_power_profile_mode


This code here is a picking one based on lookup table.

  workload_type = smu_cmn_to_asic_specific_index(smu,
 
CMN2ASIC_MAPPING_WORKLOAD,
 
smu->power_profile_mode);

This is that lookup table -

static struct cmn2asic_mapping 
sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
         WORKLOAD_MAP(PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT, 
WORKLOAD_PPLIB_DEFAULT_BIT),
         WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D, 
WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
         WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING, 
WORKLOAD_PPLIB_POWER_SAVING_BIT),
         WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO, 
WORKLOAD_PPLIB_VIDEO_BIT),
         WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR, 
WORKLOAD_PPLIB_VR_BIT),
         WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE, 
WORKLOAD_PPLIB_COMPUTE_BIT),
         WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM, 
WORKLOAD_PPLIB_CUSTOM_BIT),
};


And this is the place of interaction with PMFW. (1 << workload_type) is 
the mask being sent.

        smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
                                     1 << workload_type, NULL);

In the end, driver implementation expects only one bit to be set.

Thanks,
Lijo

> Now, when we have a single workload:
> -> Job1: requests profile P1 via UAPI, ref count = 1
> -> driver sends flags for p1
> -> PM FW applies profile P1
> -> Job executes in profile P1
> -> Job goes to reset function, ref_count = 0,
> -> Power profile resets
> 
> Now, we have conflicts only when we see multiple workloads (Job1 and Job 2)
> -> Job1: requests profile P1 via UAPI, ref count = 1
> -> driver sends flags for p1
> -> PM FW applies profile P1
> -> Job executes in profile P1
> -> Job2: requests profile P2 via UAPI, refcount = 2
> -> driver sends flags for (P1|P2)
> -> PM FW picks the more aggressive of the two (Say P1, stays in P1)
> -> Job1 goes to reset function, ref_count = 1, job1 does not reset power 
> profile
> -> Job2 goes to reset function, ref_counter = 2, job 2 resets Power profile
> -> Power profile resets to None
> 
> So this state machine looks like if there is only 1 job, it will be 
> executed in desired mode. But if there are multiple, the most aggressive 
> profile will be picked, and every job will be executed in atleast the 
> requested power profile mode or higher.
> 
> Do you find any problem so far ?
> 
> - Shashank
> 
> 
>> Thanks,
>> Lijo
