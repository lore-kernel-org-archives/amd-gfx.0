Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DD9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 05:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE16810E21E;
	Fri, 10 Dec 2021 05:53:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC2BE10E201
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 05:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTDq95DQLTgNdI0q2op30loy8oeE7SQmnIE+OJM7FeskKZoxocM6QIVZgA5cS6Il9G+m1dYS7OEld4SLSquuIWEOFIrPGCt3B5fYsjPF+XvimNR4oB/jr04if6tXDkBb11zFXTovmgq26QIGDhX/YJkMPyNN4JOAwJLHrfGtiM8AAyuFnl5jk1vvGOW0H4PdCMBiPSxKg37dH63JcTqHifLNi7bKFKxAbZinooH+wCMTKaqvF8P13PlKKFnDPbxJzZrx2BIfXFdyrs6uHzuCPXr4hIaHWC/CLgAgFnWTG4o0oPSsszd2QxFagKVdwmEfRp205+JGgM/qT7b/oxaPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AU4bKtUyLBF70aMSm26kDbIf57373W7eTNie2MQXhbs=;
 b=SK1X1N7fr7QMfthTMR/9opTEkLCQMZRjVD70MHRNH9wNb2IEVtiniGs1Uc77m9731f/DThSUYT/yNw+ger290pNAoOx5IafNt0Z/ZmP+Pe/Q4KSpYlO57cgjCfJV5TCCwN9lpk9Mx2ajn/wdLBTsDxEdcBFwQ/J+YGAFdt7oGeZyazAsr+0XFIzZo4yXhIUxkcwM79jrDzMPT9aTwgv/UC8U32bWokOE5fxlwROH8zDTe2eOVg6kMxSabYEPgzfu3mSwTZ2tP/bs/tSrdKz6URckxVnW/uGQd43XphnYC/PWTc2svFPNlWQjnrk7xlcqwWiqyro+gmdfv8t8clk/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU4bKtUyLBF70aMSm26kDbIf57373W7eTNie2MQXhbs=;
 b=hsaEg0clLBtkXTGDDnopyrH9IP6P3IVY12qp8dt+AfIpEx7VsPhawjGsobQWAnCrkXfnq+T7kcpj0iogi5ioBuzfQuvfVldNtmKd4puF9DUECDnExuz12eACEl1BX7VrdDp6dNgotNjqv51rRp+ItPLGdjp2+2mc1LVtRwz+1YU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4011.namprd12.prod.outlook.com (2603:10b6:5:1c5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.24; Fri, 10 Dec
 2021 05:53:25 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 05:53:24 +0000
Message-ID: <c8fd7a7f-309d-74c5-baa1-c387a817dac2@amd.com>
Date: Fri, 10 Dec 2021 11:23:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 02/17] drm/amd/pm: do not expose power implementation
 details to amdgpu_pm.c
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211203030540.1710564-1-evan.quan@amd.com>
 <20211203030540.1710564-2-evan.quan@amd.com>
 <62915ae3-64b6-f2a3-d59d-e72dba1e56d1@amd.com>
 <DM6PR12MB2619A1E385175ED9D2A83863E4719@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619A1E385175ED9D2A83863E4719@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::27) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 245dff3f-653a-4f5e-16e4-08d9bba160fa
X-MS-TrafficTypeDiagnostic: DM6PR12MB4011:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40111FB96D19677B94AAF8C397719@DM6PR12MB4011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXhI+X8qNczBA7g0vfGinl+fem8xl410ZvUh4PcAwojtKHjkugYKY0OYEgD80K6DyqVNVaN1KY6qUN7HKFdu/2xQa+VcqLOvaxBeswuwGRDCsIO71s9WmBb1UrH6o/QEqh6udCmI0gmeUWCCNWgflHSUOZnX0K8+jw+xGYdqTCkDxPr9hQ0pwersgkUNYMdBf4/oC//kssYry0WBKqqu2vnW/i1H3+Slz4I8D3yH2iQc5fiHrcfJV12teJuN4xTAvELxzzu4v54pzd7Pd4swv79jYXISH4P6s2BstCp6UXsUmlUjE9rVHSUUDOlaLpi/s0HOxP27BcdPCsWfQyeo96gbsKC62Dw6EmkIpf3p7Te73m5MHQ5r6/OQcEaUYxhKxN+klIRjmWHT7y00OQGy/4c3KDNxxjemjmozbIVkxuAb/9W5Mr/inrUvwgFNs5Hs6dAGBp3pLWzoRTbfMyu40jI/rC4NTV1N61FnwfrrE5KXLrH4xmmmSGeUtdPtMlnM6SgKgqto/2iqlZJVldq61fRhcHQMrsgOwVOHFxoDuM9wnTdFGQBPFBPRzfATd619AtaOJah2VgMcumpKIiAvV4II28+b0wSw98UQE1q1SuRcKt3fVQmcTK+3kCLPecpXesVHyzHgHRWrgolq7W8vwclVI72gtVZrdTIfCk29fYdHsuzgI6A4DcTZYXlzAj24jUe8RMHmtzx+qbonnVVfVUtys9U7nXkpPN1cJ9FpSi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(30864003)(26005)(6486002)(86362001)(186003)(508600001)(8676002)(2616005)(54906003)(110136005)(4326008)(316002)(8936002)(53546011)(6506007)(6512007)(6666004)(38100700002)(5660300002)(31696002)(83380400001)(66946007)(66556008)(66476007)(36756003)(2906002)(45980500001)(43740500002)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFVPczErcTcwNTU4dm5paGdTU1ZWaVQrM1ZEeksyLzdUMmdOczJxUGQ0WXUx?=
 =?utf-8?B?K1NvaldFWjVqcVFPR0x3UXFzT2UxbE1CbDFzZS9SR1J4Tk51dURNZFVXUEgw?=
 =?utf-8?B?ZG85UXRGVjFhMG5udDZHdFZmYVFNUnRUemFzcWhacms3NFBOOXVCdUhvYVFV?=
 =?utf-8?B?ekRJemhybkxUbVNUN2pmcWJZcTROVmdQZUs5dFBUQzVzcHdHeUJsYVhiZmlR?=
 =?utf-8?B?bkpYR3RNVTlLYlZYallIaCtQMmU4UGNwWVRpQTJCZ3QrV1ZjZC9aVzRJS0tY?=
 =?utf-8?B?V3JPNzJZVk9NalFLMEsrN1V6Yys1aTlkSW0xbUFXRFhEUHV5eVFzMHNnamVK?=
 =?utf-8?B?RkdxR3VlRWRpMHg5akxYNjRpKzUrMjl2YUNLa3lTbHJBT2k3aTNjMkNneXlp?=
 =?utf-8?B?UnUyaDlhR09IQUlzRWUzM2lrckx6MnhvaGgraUN1dEV6NzVHbGF2Q3J2eXB3?=
 =?utf-8?B?VktUTlpkT3VBQ0lLZ0NFQm5QMTZ5NzVtd1JMcXNxNE8reW40SDhGRm40M0dl?=
 =?utf-8?B?RUFmODd2OEF1eTd4Vk42OFVaQlB6TUZheEEzZzgxOUdOQmkyQXdrSDgvdW1a?=
 =?utf-8?B?dU9sUVBpdi8rV0NBWjQ1aTRPd3hFSnNBek5zVmhhU1ZMQXUxWUh0MkErVS8z?=
 =?utf-8?B?d0RUUjJkVXlIR1luRmlEYlJBVndmTlVpR0NFeVROMFBqN2p6MFluN2FYeWlJ?=
 =?utf-8?B?eDNlOS9mWlZJNnk5dnVuVVdYclRvV0tFMTdCRjdBU25xQW52eFBIcWtJWFhu?=
 =?utf-8?B?YVp4UDkrUGdjeFVUZzJKTlRGZ3g4UE0zLytSRVNtVnZ3STkyVE1Xd2RUWkFF?=
 =?utf-8?B?VGFRcERmREdWTGZOZnZvdkpRbVlEeHVoZDB1WVJSYit3L1ViNjBjV1k4b0wy?=
 =?utf-8?B?UVp0R29ldXl1M0xvLzVzUFUwY2x1K21ZMG1OOEp6U1c4blpyZHhYQVR4Wk9u?=
 =?utf-8?B?UkhBQllTeUtNK3RCSFN6UWtud3I4eW9Ta1dnNHNQeWxuUjdZOFdiVy9uUk1R?=
 =?utf-8?B?QkpNUFR1RzhJRUdDekNKeFhHMUZxaEpTZjB4bHF4UG0zbll4aWZUYnNKSzgw?=
 =?utf-8?B?akdnaEtEQVFNeitrU2tSNW9BMTMxYXBzV2VZYm90TWhxY1lTcXlvM3QwaWNn?=
 =?utf-8?B?eWdzMDUwS1Nlc0o1ZnBlOGpVajd4V0I0NGh5UnIyakY5TmkveDFnaWNEWTl4?=
 =?utf-8?B?UDFyMit2ZGpwYndDTFZad0ViVXlrZU4rb25ES2pPdnBPS1l6MW9CeHVYSm0y?=
 =?utf-8?B?SEFRVURaNUlyeUg5Tm4vM3I3RTA5ZE52RWxFWCtPZWY3UG9MZURCRFA5YUZv?=
 =?utf-8?B?VXRLRzNNeFhoVi9EYVZCL3N5c2k1RGpzUVRleXQvMzREaDlSeWNGak9ZNXl3?=
 =?utf-8?B?R2h1WW4wTVRvOVFaTnEyL3pDbVdKY29HNTlsWGxqR1RiZkZhUVdQdlAyeDg3?=
 =?utf-8?B?UHVnaGkvVi8vSDZ2djBwbHpEQ21MNDViOGtkZ0Z4aDZibDhreU1wZ3YvQ043?=
 =?utf-8?B?WE5hbWxVZmYxYVlXTlE4UEVRaHpsQXNzZUFEVURTN2VxdldZSDRjcDVycUlR?=
 =?utf-8?B?TUFTSDgzU24yNUpSWkNzWjE5RkZSNHRmdlJ0d3VWOTB2Zkhzd3RhOTlCVkpp?=
 =?utf-8?B?bWdxb0hqKzBYSVlCcFlhSmc4UlUzaTBVRC9oRnAvdXJua0k1SGdmQmJHbFBE?=
 =?utf-8?B?Vm5aRXB5Z05YNHJ5U2QwbDVhTXRLYU41NklKd3dFU3BlMFhKbWRxQ3pqTjZs?=
 =?utf-8?B?aXhVc1pYNU1GNWNXSjR4cEZMUm5UZWZYNUIvWTR2OXFmWGVBT1lHYUVTZmFr?=
 =?utf-8?B?QzM1dlhaQlRMZERUZEZGV3JlN2t4UkNnODBtSHBrQTJLQWlxMkJBMHJxQUNJ?=
 =?utf-8?B?WG1IQk5PelUrYnd1Z2pSTUV1YlQwV0psRmNEVGtQTGxjTkRCN3lIc3F1U0Q4?=
 =?utf-8?B?aTkvMUJLQk5ndVd5V0gyWnRDbCs3bkJPc2ZOOUlMMTBTaHRyeSt2bDFkUnFB?=
 =?utf-8?B?MDczMVVrU0N1L2JZSXV0TUNWTS82K2U4Mk9jQ1l6TmdkY3I3OWl2Mlkrd280?=
 =?utf-8?B?biswUVJoWFpSRFhTblIzV09VMTNHMnNNVTBRK1VnOHFBVDkvMlA0UzAvaTR5?=
 =?utf-8?Q?1Sz0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245dff3f-653a-4f5e-16e4-08d9bba160fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 05:53:24.7563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHPgK5m66uwwQgvRua3OxJTjERxiCDG3z7SVNlWeLcoRuXMe9qlFzlmBuCZqTh8P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4011
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/10/2021 10:50 AM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, December 9, 2021 7:58 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
>> Subject: Re: [PATCH V4 02/17] drm/amd/pm: do not expose power
>> implementation details to amdgpu_pm.c
>>
>>
>>
>> On 12/3/2021 8:35 AM, Evan Quan wrote:
>>> amdgpu_pm.c holds all the user sysfs/hwmon interfaces. It's another
>>> client of our power APIs. It's not proper to spike into power
>>> implementation details there.
>>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: I397853ddb13eacfce841366de2a623535422df9a
>>> --
>>> v1->v2:
>>>     - drop unneeded "return;" in
>> amdgpu_dpm_get_current_power_state(Guchun)
>>> ---
>>>    drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 456
>> ++++++++++++++++++-
>>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 519 ++++++++--------------
>>>    drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h   | 160 +++----
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |   3 -
>>>    4 files changed, 707 insertions(+), 431 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> index 54abdf7080de..2c789eb5d066 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> @@ -1453,7 +1453,9 @@ static void
>> amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>>>    	if (equal)
>>>    		return;
>>>
>>> -	amdgpu_dpm_set_power_state(adev);
>>> +	if (adev->powerplay.pp_funcs->set_power_state)
>>> +		adev->powerplay.pp_funcs->set_power_state(adev-
>>> powerplay.pp_handle);
>>> +
>>>    	amdgpu_dpm_post_set_power_state(adev);
>>>
>>>    	adev->pm.dpm.current_active_crtcs = adev-
>>> pm.dpm.new_active_crtcs;
>>> @@ -1704,3 +1706,455 @@ int amdgpu_dpm_get_ecc_info(struct
>> amdgpu_device *adev,
>>>
>>>    	return smu_get_ecc_info(&adev->smu, umc_ecc);
>>>    }
>>> +
>>> +struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct
>> amdgpu_device *adev,
>>> +						     uint32_t idx)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->get_vce_clock_state)
>>> +		return NULL;
>>> +
>>> +	return pp_funcs->get_vce_clock_state(adev->powerplay.pp_handle,
>>> +					     idx);
>>> +}
>>> +
>>> +void amdgpu_dpm_get_current_power_state(struct amdgpu_device
>> *adev,
>>> +					enum amd_pm_state_type *state)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->get_current_power_state) {
>>> +		*state = adev->pm.dpm.user_state;
>>> +		return;
>>> +	}
>>> +
>>> +	*state = pp_funcs->get_current_power_state(adev-
>>> powerplay.pp_handle);
>>> +	if (*state < POWER_STATE_TYPE_DEFAULT ||
>>> +	    *state > POWER_STATE_TYPE_INTERNAL_3DPERF)
>>> +		*state = adev->pm.dpm.user_state;
>>> +}
>>> +
>>> +void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
>>> +				enum amd_pm_state_type state)
>>> +{
>>> +	adev->pm.dpm.user_state = state;
>>> +
>>> +	if (adev->powerplay.pp_funcs->dispatch_tasks)
>>> +		amdgpu_dpm_dispatch_task(adev,
>> AMD_PP_TASK_ENABLE_USER_STATE, &state);
>>> +	else
>>> +		amdgpu_pm_compute_clocks(adev);
>>> +}
>>> +
>>> +enum amd_dpm_forced_level
>> amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +	enum amd_dpm_forced_level level;
>>> +
>>> +	if (pp_funcs->get_performance_level)
>>> +		level = pp_funcs->get_performance_level(adev-
>>> powerplay.pp_handle);
>>> +	else
>>> +		level = adev->pm.dpm.forced_level;
>>> +
>>> +	return level;
>>> +}
>>> +
>>> +int amdgpu_dpm_force_performance_level(struct amdgpu_device
>> *adev,
>>> +				       enum amd_dpm_forced_level level)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (pp_funcs->force_performance_level) {
>>> +		if (adev->pm.dpm.thermal_active)
>>> +			return -EINVAL;
>>> +
>>> +		if (pp_funcs->force_performance_level(adev-
>>> powerplay.pp_handle,
>>> +						      level))
>>> +			return -EINVAL;
>>> +	}
>>> +
>>> +	adev->pm.dpm.forced_level = level;
>>> +
>>
>> If the function is not implemented, why change the force level and
>> return success?
> [Quan, Evan] Thanks! Will update that.
>>
>>> +	return 0;
>>> +}
>>> +
>>> +int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
>>> +				 struct pp_states_info *states)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->get_pp_num_states)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	return pp_funcs->get_pp_num_states(adev->powerplay.pp_handle,
>> states);
>>> +}
>>> +
>>> +int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
>>> +			      enum amd_pp_task task_id,
>>> +			      enum amd_pm_state_type *user_state)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->dispatch_tasks)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	return pp_funcs->dispatch_tasks(adev->powerplay.pp_handle,
>> task_id, user_state);
>>> +}
>>> +
>>> +int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char
>> **table)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->get_pp_table)
>>> +		return 0;
>>> +
>>> +	return pp_funcs->get_pp_table(adev->powerplay.pp_handle, table);
>>> +}
>>> +
>>> +int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
>>> +				      uint32_t type,
>>> +				      long *input,
>>> +				      uint32_t size)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->set_fine_grain_clk_vol)
>>> +		return 0;
>>> +
>>
>> Better for this also to return -EOPNOTSUPP. There are a few other funcs
>> below also which returns 0, instead they should return EOPNOTSUPP. Let
>> the caller decide what to do when not supported instead of returning
>> 'fake success'.
> [Quan, Evan] Yeah, I know some(this and others mentioned below) of them seem with different/weird error return code. But unfortunately, that's how the original logic.
> We need to fix them in future. But for this patch series, it is not intended to bring any real logic change.

What I meant is let the API implementation be standalone. Let it return 
EOPNOTSUPP and f that is the error code, caller retains the existing logic.

Ex:
	if (!pp_funcs->set_fine_grain_clk_vol) logic in caller is replaced by
	if (amdgpu_dpm_set_fine_grain_clk_vol() == -EOPNOTSUPP)

and then it retains the existing logic for that error code.

Thanks,
Lijo

>>
>>> +	return pp_funcs->set_fine_grain_clk_vol(adev-
>>> powerplay.pp_handle,
>>> +						type,
>>> +						input,
>>> +						size);
>>> +}
>>> +
>>> +int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
>>> +				  uint32_t type,
>>> +				  long *input,
>>> +				  uint32_t size)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->odn_edit_dpm_table)
>>> +		return 0;
>>> +
>>> +	return pp_funcs->odn_edit_dpm_table(adev-
>>> powerplay.pp_handle,
>>> +					    type,
>>> +					    input,
>>> +					    size);
>>> +}
>>> +
>>> +int amdgpu_dpm_print_clock_levels(struct amdgpu_device *adev,
>>> +				  enum pp_clock_type type,
>>> +				  char *buf)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->print_clock_levels)
>>> +		return 0;
>>> +
>>> +	return pp_funcs->print_clock_levels(adev->powerplay.pp_handle,
>>> +					    type,
>>> +					    buf);
>>> +}
>>> +
>>> +int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
>>> +				    uint64_t ppfeature_masks)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->set_ppfeature_status)
>>> +		return 0;
>>> +
>>> +	return pp_funcs->set_ppfeature_status(adev-
>>> powerplay.pp_handle,
>>> +					      ppfeature_masks);
>>> +}
>>> +
>>> +int amdgpu_dpm_get_ppfeature_status(struct amdgpu_device *adev,
>> char *buf)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->get_ppfeature_status)
>>> +		return 0;
>>> +
>>> +	return pp_funcs->get_ppfeature_status(adev-
>>> powerplay.pp_handle,
>>> +					      buf);
>>> +}
>>> +
>>> +int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
>>> +				 enum pp_clock_type type,
>>> +				 uint32_t mask)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->force_clock_level)
>>> +		return 0;
>>> +
>>> +	return pp_funcs->force_clock_level(adev->powerplay.pp_handle,
>>> +					   type,
>>> +					   mask);
>>> +}
>>> +
>>> +int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->get_sclk_od)
>>> +		return 0;
>>> +
>>> +	return pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
>>> +}
>>> +
>>> +int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t
>> value)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->set_sclk_od)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
>>> +
>>> +	if (amdgpu_dpm_dispatch_task(adev,
>>> +				     AMD_PP_TASK_READJUST_POWER_STATE,
>>> +				     NULL) == -EOPNOTSUPP) {
>>> +		adev->pm.dpm.current_ps = adev->pm.dpm.boot_ps;
>>> +		amdgpu_pm_compute_clocks(adev);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->get_mclk_od)
>>> +		return 0;
>>> +
>>> +	return pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
>>> +}
>>> +
>>> +int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t
>> value)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->set_mclk_od)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
>>> +
>>> +	if (amdgpu_dpm_dispatch_task(adev,
>>> +				     AMD_PP_TASK_READJUST_POWER_STATE,
>>> +				     NULL) == -EOPNOTSUPP) {
>>> +		adev->pm.dpm.current_ps = adev->pm.dpm.boot_ps;
>>> +		amdgpu_pm_compute_clocks(adev);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device
>> *adev,
>>> +				      char *buf)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->get_power_profile_mode)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	return pp_funcs->get_power_profile_mode(adev-
>>> powerplay.pp_handle,
>>> +						buf);
>>> +}
>>> +
>>> +int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device
>> *adev,
>>> +				      long *input, uint32_t size)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->set_power_profile_mode)
>>> +		return 0;
>>> +
>>> +	return pp_funcs->set_power_profile_mode(adev-
>>> powerplay.pp_handle,
>>> +						input,
>>> +						size);
>>> +}
>>> +
>>> +int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void
>> **table)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->get_gpu_metrics)
>>> +		return 0;
>>> +
>>> +	return pp_funcs->get_gpu_metrics(adev->powerplay.pp_handle,
>> table);
>>> +}
>>> +
>>> +int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
>>> +				    uint32_t *fan_mode)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->get_fan_control_mode)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	*fan_mode = pp_funcs->get_fan_control_mode(adev-
>>> powerplay.pp_handle);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
>>> +				 uint32_t speed)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->set_fan_speed_pwm)
>>> +		return -EINVAL;
>>
>> To be consistent, use EOPNOTSUPP when the function is not implemented.
>> The return of EINVAL from actual function call shouldn't be mixed with this.
>>
>>> +
>>> +	return pp_funcs->set_fan_speed_pwm(adev-
>>> powerplay.pp_handle, speed);
>>> +}
>>> +
>>> +int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
>>> +				 uint32_t *speed)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->get_fan_speed_pwm)
>>> +		return -EINVAL;
>>> +
>>> +	return pp_funcs->get_fan_speed_pwm(adev-
>>> powerplay.pp_handle, speed);
>>> +}
>>> +
>>> +int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
>>> +				 uint32_t *speed)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->get_fan_speed_rpm)
>>> +		return -EINVAL;
>>> +
>>> +	return pp_funcs->get_fan_speed_rpm(adev->powerplay.pp_handle,
>> speed);
>>> +}
>>> +
>>> +int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
>>> +				 uint32_t speed)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->set_fan_speed_rpm)
>>> +		return -EINVAL;
>>> +
>>> +	return pp_funcs->set_fan_speed_rpm(adev->powerplay.pp_handle,
>> speed);
>>> +}
>>> +
>>> +int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
>>> +				    uint32_t mode)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->set_fan_control_mode)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
>> mode);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
>>> +			       uint32_t *limit,
>>> +			       enum pp_power_limit_level pp_limit_level,
>>> +			       enum pp_power_type power_type)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->get_power_limit)
>>> +		return -ENODATA;
>>> +
>>
>> Again, this is mixing API error code based on caller's usage. In
>> standalone implementatoin, this should also just return EOPNOTSUPP.
>> hwmon API implementation can decide what to return when there is no API
>> support.
>>
>>> +	return pp_funcs->get_power_limit(adev->powerplay.pp_handle,
>>> +					 limit,
>>> +					 pp_limit_level,
>>> +					 power_type);
>>> +}
>>> +
>>> +int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
>>> +			       uint32_t limit)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->set_power_limit)
>>> +		return -EINVAL;
>>> +
>>> +	return pp_funcs->set_power_limit(adev->powerplay.pp_handle,
>> limit);
>>> +}
>>> +
>>> +int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev)
>>> +{
>>> +	if (!is_support_sw_smu(adev))
>>> +		return false;
>>> +
>>> +	return is_support_cclk_dpm(adev);
>>> +}
>>> +
>>> +int amdgpu_dpm_debugfs_print_current_performance_level(struct
>> amdgpu_device *adev,
>>> +						       struct seq_file *m)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->debugfs_print_current_performance_level)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	pp_funcs->debugfs_print_current_performance_level(adev-
>>> powerplay.pp_handle,
>>> +							  m);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device
>> *adev,
>>> +				       void **addr,
>>> +				       size_t *size)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->get_smu_prv_buf_details)
>>> +		return -ENOSYS;
>>> +
>>> +	return pp_funcs->get_smu_prv_buf_details(adev-
>>> powerplay.pp_handle,
>>> +						 addr,
>>> +						 size);
>>> +}
>>> +
>>> +int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>>> +{
>>> +	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
>>> +
>>> +	if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
>>> +	    (is_support_sw_smu(adev) && adev->smu.is_apu) ||
>>> +		(!is_support_sw_smu(adev) && hwmgr->od_enabled))
>>> +		return true;
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
>>> +			    const char *buf,
>>> +			    size_t size)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs->set_pp_table)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	return pp_funcs->set_pp_table(adev->powerplay.pp_handle,
>>> +				      buf,
>>> +				      size);
>>> +}
>>> +
>>> +int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device *adev)
>>> +{
>>> +	return adev->smu.cpu_core_num;
>>> +}
>>> +
>>> +void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev)
>>> +{
>>> +	if (!is_support_sw_smu(adev))
>>> +		return;
>>> +
>>> +	amdgpu_smu_stb_debug_fs_init(adev);
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> index 082539c70fd4..3382d30b5d90 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> @@ -34,7 +34,6 @@
>>>    #include <linux/nospec.h>
>>>    #include <linux/pm_runtime.h>
>>>    #include <asm/processor.h>
>>> -#include "hwmgr.h"
>>>
>>>    static const struct cg_flag_name clocks[] = {
>>>    	{AMD_CG_SUPPORT_GFX_FGCG, "Graphics Fine Grain Clock
>> Gating"},
>>> @@ -132,7 +131,6 @@ static ssize_t
>> amdgpu_get_power_dpm_state(struct device *dev,
>>>    {
>>>    	struct drm_device *ddev = dev_get_drvdata(dev);
>>>    	struct amdgpu_device *adev = drm_to_adev(ddev);
>>> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	enum amd_pm_state_type pm;
>>>    	int ret;
>>>
>>> @@ -147,11 +145,7 @@ static ssize_t
>> amdgpu_get_power_dpm_state(struct device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (pp_funcs->get_current_power_state) {
>>> -		pm = amdgpu_dpm_get_current_power_state(adev);
>>> -	} else {
>>> -		pm = adev->pm.dpm.user_state;
>>> -	}
>>> +	amdgpu_dpm_get_current_power_state(adev, &pm);
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>> @@ -191,19 +185,8 @@ static ssize_t
>> amdgpu_set_power_dpm_state(struct device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (is_support_sw_smu(adev)) {
>>> -		mutex_lock(&adev->pm.mutex);
>>> -		adev->pm.dpm.user_state = state;
>>> -		mutex_unlock(&adev->pm.mutex);
>>
>> Here the code just sets the state and exits. However, when moved to
>> refactored function, it is calling pm_compute_clocks.
> [Quan, Evan] Thanks! Will fix this.
> 
> BR
> Evan
>>
>>> -	} else if (adev->powerplay.pp_funcs->dispatch_tasks) {
>>> -		amdgpu_dpm_dispatch_task(adev,
>> AMD_PP_TASK_ENABLE_USER_STATE, &state);
>>> -	} else {
>>> -		mutex_lock(&adev->pm.mutex);
>>> -		adev->pm.dpm.user_state = state;
>>> -		mutex_unlock(&adev->pm.mutex);
>>> +	amdgpu_dpm_set_power_state(adev, state);
>>>
>>> -		amdgpu_pm_compute_clocks(adev);
>>> -	}
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>>
>>> @@ -290,10 +273,7 @@ static ssize_t
>> amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (adev->powerplay.pp_funcs->get_performance_level)
>>> -		level = amdgpu_dpm_get_performance_level(adev);
>>> -	else
>>> -		level = adev->pm.dpm.forced_level;
>>> +	level = amdgpu_dpm_get_performance_level(adev);
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>> @@ -318,7 +298,6 @@ static ssize_t
>> amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>>>    {
>>>    	struct drm_device *ddev = dev_get_drvdata(dev);
>>>    	struct amdgpu_device *adev = drm_to_adev(ddev);
>>> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	enum amd_dpm_forced_level level;
>>>    	enum amd_dpm_forced_level current_level;
>>>    	int ret = 0;
>>> @@ -358,11 +337,7 @@ static ssize_t
>> amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (pp_funcs->get_performance_level)
>>> -		current_level =
>> amdgpu_dpm_get_performance_level(adev);
>>> -	else
>>> -		current_level = adev->pm.dpm.forced_level;
>>> -
>>> +	current_level = amdgpu_dpm_get_performance_level(adev);
>>>    	if (current_level == level) {
>>>    		pm_runtime_mark_last_busy(ddev->dev);
>>>    		pm_runtime_put_autosuspend(ddev->dev);
>>> @@ -390,25 +365,12 @@ static ssize_t
>> amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>>>    		return -EINVAL;
>>>    	}
>>>
>>> -	if (pp_funcs->force_performance_level) {
>>> -		mutex_lock(&adev->pm.mutex);
>>> -		if (adev->pm.dpm.thermal_active) {
>>> -			mutex_unlock(&adev->pm.mutex);
>>> -			pm_runtime_mark_last_busy(ddev->dev);
>>> -			pm_runtime_put_autosuspend(ddev->dev);
>>> -			return -EINVAL;
>>> -		}
>>> -		ret = amdgpu_dpm_force_performance_level(adev, level);
>>> -		if (ret) {
>>> -			mutex_unlock(&adev->pm.mutex);
>>> -			pm_runtime_mark_last_busy(ddev->dev);
>>> -			pm_runtime_put_autosuspend(ddev->dev);
>>> -			return -EINVAL;
>>> -		} else {
>>> -			adev->pm.dpm.forced_level = level;
>>> -		}
>>> -		mutex_unlock(&adev->pm.mutex);
>>> +	if (amdgpu_dpm_force_performance_level(adev, level)) {
>>> +		pm_runtime_mark_last_busy(ddev->dev);
>>> +		pm_runtime_put_autosuspend(ddev->dev);
>>> +		return -EINVAL;
>>>    	}
>>> +
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>>
>>> @@ -421,7 +383,6 @@ static ssize_t amdgpu_get_pp_num_states(struct
>> device *dev,
>>>    {
>>>    	struct drm_device *ddev = dev_get_drvdata(dev);
>>>    	struct amdgpu_device *adev = drm_to_adev(ddev);
>>> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	struct pp_states_info data;
>>>    	uint32_t i;
>>>    	int buf_len, ret;
>>> @@ -437,11 +398,8 @@ static ssize_t amdgpu_get_pp_num_states(struct
>> device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (pp_funcs->get_pp_num_states) {
>>> -		amdgpu_dpm_get_pp_num_states(adev, &data);
>>> -	} else {
>>> +	if (amdgpu_dpm_get_pp_num_states(adev, &data))
>>>    		memset(&data, 0, sizeof(data));
>>> -	}
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>> @@ -463,7 +421,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct
>> device *dev,
>>>    {
>>>    	struct drm_device *ddev = dev_get_drvdata(dev);
>>>    	struct amdgpu_device *adev = drm_to_adev(ddev);
>>> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	struct pp_states_info data = {0};
>>>    	enum amd_pm_state_type pm = 0;
>>>    	int i = 0, ret = 0;
>>> @@ -479,15 +436,16 @@ static ssize_t amdgpu_get_pp_cur_state(struct
>> device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (pp_funcs->get_current_power_state
>>> -		 && pp_funcs->get_pp_num_states) {
>>> -		pm = amdgpu_dpm_get_current_power_state(adev);
>>> -		amdgpu_dpm_get_pp_num_states(adev, &data);
>>> -	}
>>> +	amdgpu_dpm_get_current_power_state(adev, &pm);
>>> +
>>> +	ret = amdgpu_dpm_get_pp_num_states(adev, &data);
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>>
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>    	for (i = 0; i < data.nums; i++) {
>>>    		if (pm == data.states[i])
>>>    			break;
>>> @@ -525,6 +483,7 @@ static ssize_t amdgpu_set_pp_force_state(struct
>> device *dev,
>>>    	struct drm_device *ddev = dev_get_drvdata(dev);
>>>    	struct amdgpu_device *adev = drm_to_adev(ddev);
>>>    	enum amd_pm_state_type state = 0;
>>> +	struct pp_states_info data;
>>>    	unsigned long idx;
>>>    	int ret;
>>>
>>> @@ -533,41 +492,49 @@ static ssize_t amdgpu_set_pp_force_state(struct
>> device *dev,
>>>    	if (adev->in_suspend && !adev->in_runpm)
>>>    		return -EPERM;
>>>
>>> -	if (strlen(buf) == 1)
>>> -		adev->pp_force_state_enabled = false;
>>> -	else if (is_support_sw_smu(adev))
>>> -		adev->pp_force_state_enabled = false;
>>> -	else if (adev->powerplay.pp_funcs->dispatch_tasks &&
>>> -			adev->powerplay.pp_funcs->get_pp_num_states) {
>>> -		struct pp_states_info data;
>>> -
>>> -		ret = kstrtoul(buf, 0, &idx);
>>> -		if (ret || idx >= ARRAY_SIZE(data.states))
>>> -			return -EINVAL;
>>> +	adev->pp_force_state_enabled = false;
>>>
>>> -		idx = array_index_nospec(idx, ARRAY_SIZE(data.states));
>>> +	if (strlen(buf) == 1)
>>> +		return count;
>>>
>>> -		amdgpu_dpm_get_pp_num_states(adev, &data);
>>> -		state = data.states[idx];
>>> +	ret = kstrtoul(buf, 0, &idx);
>>> +	if (ret || idx >= ARRAY_SIZE(data.states))
>>> +		return -EINVAL;
>>>
>>> -		ret = pm_runtime_get_sync(ddev->dev);
>>> -		if (ret < 0) {
>>> -			pm_runtime_put_autosuspend(ddev->dev);
>>> -			return ret;
>>> -		}
>>> +	idx = array_index_nospec(idx, ARRAY_SIZE(data.states));
>>>
>>> -		/* only set user selected power states */
>>> -		if (state != POWER_STATE_TYPE_INTERNAL_BOOT &&
>>> -		    state != POWER_STATE_TYPE_DEFAULT) {
>>> -			amdgpu_dpm_dispatch_task(adev,
>>> -
>> 	AMD_PP_TASK_ENABLE_USER_STATE, &state);
>>> -			adev->pp_force_state_enabled = true;
>>> -		}
>>> -		pm_runtime_mark_last_busy(ddev->dev);
>>> +	ret = pm_runtime_get_sync(ddev->dev);
>>> +	if (ret < 0) {
>>>    		pm_runtime_put_autosuspend(ddev->dev);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = amdgpu_dpm_get_pp_num_states(adev, &data);
>>> +	if (ret)
>>> +		goto err_out;
>>> +
>>> +	state = data.states[idx];
>>> +
>>> +	/* only set user selected power states */
>>> +	if (state != POWER_STATE_TYPE_INTERNAL_BOOT &&
>>> +	    state != POWER_STATE_TYPE_DEFAULT) {
>>> +		ret = amdgpu_dpm_dispatch_task(adev,
>>> +				AMD_PP_TASK_ENABLE_USER_STATE,
>> &state);
>>> +		if (ret)
>>> +			goto err_out;
>>> +
>>> +		adev->pp_force_state_enabled = true;
>>>    	}
>>>
>>> +	pm_runtime_mark_last_busy(ddev->dev);
>>> +	pm_runtime_put_autosuspend(ddev->dev);
>>> +
>>>    	return count;
>>> +
>>> +err_out:
>>> +	pm_runtime_mark_last_busy(ddev->dev);
>>> +	pm_runtime_put_autosuspend(ddev->dev);
>>> +	return ret;
>>>    }
>>>
>>>    /**
>>> @@ -601,17 +568,13 @@ static ssize_t amdgpu_get_pp_table(struct device
>> *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (adev->powerplay.pp_funcs->get_pp_table) {
>>> -		size = amdgpu_dpm_get_pp_table(adev, &table);
>>> -		pm_runtime_mark_last_busy(ddev->dev);
>>> -		pm_runtime_put_autosuspend(ddev->dev);
>>> -		if (size < 0)
>>> -			return size;
>>> -	} else {
>>> -		pm_runtime_mark_last_busy(ddev->dev);
>>> -		pm_runtime_put_autosuspend(ddev->dev);
>>> -		return 0;
>>> -	}
>>> +	size = amdgpu_dpm_get_pp_table(adev, &table);
>>> +
>>> +	pm_runtime_mark_last_busy(ddev->dev);
>>> +	pm_runtime_put_autosuspend(ddev->dev);
>>> +
>>> +	if (size <= 0)
>>> +		return size;
>>>
>>>    	if (size >= PAGE_SIZE)
>>>    		size = PAGE_SIZE - 1;
>>> @@ -642,15 +605,13 @@ static ssize_t amdgpu_set_pp_table(struct device
>> *dev,
>>>    	}
>>>
>>>    	ret = amdgpu_dpm_set_pp_table(adev, buf, count);
>>> -	if (ret) {
>>> -		pm_runtime_mark_last_busy(ddev->dev);
>>> -		pm_runtime_put_autosuspend(ddev->dev);
>>> -		return ret;
>>> -	}
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>>
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>    	return count;
>>>    }
>>>
>>> @@ -866,46 +827,32 @@ static ssize_t
>> amdgpu_set_pp_od_clk_voltage(struct device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (adev->powerplay.pp_funcs->set_fine_grain_clk_vol) {
>>> -		ret = amdgpu_dpm_set_fine_grain_clk_vol(adev, type,
>>> -							parameter,
>>> -							parameter_size);
>>> -		if (ret) {
>>> -			pm_runtime_mark_last_busy(ddev->dev);
>>> -			pm_runtime_put_autosuspend(ddev->dev);
>>> -			return -EINVAL;
>>> -		}
>>> -	}
>>> +	if (amdgpu_dpm_set_fine_grain_clk_vol(adev,
>>> +					      type,
>>> +					      parameter,
>>> +					      parameter_size))
>>> +		goto err_out;
>>>
>>> -	if (adev->powerplay.pp_funcs->odn_edit_dpm_table) {
>>> -		ret = amdgpu_dpm_odn_edit_dpm_table(adev, type,
>>> -						    parameter,
>> parameter_size);
>>> -		if (ret) {
>>> -			pm_runtime_mark_last_busy(ddev->dev);
>>> -			pm_runtime_put_autosuspend(ddev->dev);
>>> -			return -EINVAL;
>>> -		}
>>> -	}
>>> +	if (amdgpu_dpm_odn_edit_dpm_table(adev, type,
>>> +					  parameter, parameter_size))
>>> +		goto err_out;
>>>
>>
>> This is one example of returning 'fake success' effect. If the function
>> is not implemented it proceeds. There is no need to proceed if there is
>> no support.
>>
>>
>> Thanks,
>> Lijo
>>
>>>    	if (type == PP_OD_COMMIT_DPM_TABLE) {
>>> -		if (adev->powerplay.pp_funcs->dispatch_tasks) {
>>> -			amdgpu_dpm_dispatch_task(adev,
>>> -
>> AMD_PP_TASK_READJUST_POWER_STATE,
>>> -						 NULL);
>>> -			pm_runtime_mark_last_busy(ddev->dev);
>>> -			pm_runtime_put_autosuspend(ddev->dev);
>>> -			return count;
>>> -		} else {
>>> -			pm_runtime_mark_last_busy(ddev->dev);
>>> -			pm_runtime_put_autosuspend(ddev->dev);
>>> -			return -EINVAL;
>>> -		}
>>> +		if (amdgpu_dpm_dispatch_task(adev,
>>> +
>> AMD_PP_TASK_READJUST_POWER_STATE,
>>> +					     NULL))
>>> +			goto err_out;
>>>    	}
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>>
>>>    	return count;
>>> +
>>> +err_out:
>>> +	pm_runtime_mark_last_busy(ddev->dev);
>>> +	pm_runtime_put_autosuspend(ddev->dev);
>>> +	return -EINVAL;
>>>    }
>>>
>>>    static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>> @@ -928,8 +875,8 @@ static ssize_t
>> amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (adev->powerplay.pp_funcs->print_clock_levels) {
>>> -		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
>>> +	size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
>>> +	if (size > 0) {
>>>    		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK,
>> buf+size);
>>>    		size += amdgpu_dpm_print_clock_levels(adev,
>> OD_VDDC_CURVE, buf+size);
>>>    		size += amdgpu_dpm_print_clock_levels(adev,
>> OD_VDDGFX_OFFSET, buf+size);
>>> @@ -985,17 +932,14 @@ static ssize_t amdgpu_set_pp_features(struct
>> device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (adev->powerplay.pp_funcs->set_ppfeature_status) {
>>> -		ret = amdgpu_dpm_set_ppfeature_status(adev,
>> featuremask);
>>> -		if (ret) {
>>> -			pm_runtime_mark_last_busy(ddev->dev);
>>> -			pm_runtime_put_autosuspend(ddev->dev);
>>> -			return -EINVAL;
>>> -		}
>>> -	}
>>> +	ret = amdgpu_dpm_set_ppfeature_status(adev, featuremask);
>>> +
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>>
>>> +	if (ret)
>>> +		return -EINVAL;
>>> +
>>>    	return count;
>>>    }
>>>
>>> @@ -1019,9 +963,8 @@ static ssize_t amdgpu_get_pp_features(struct
>> device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (adev->powerplay.pp_funcs->get_ppfeature_status)
>>> -		size = amdgpu_dpm_get_ppfeature_status(adev, buf);
>>> -	else
>>> +	size = amdgpu_dpm_get_ppfeature_status(adev, buf);
>>> +	if (size <= 0)
>>>    		size = sysfs_emit(buf, "\n");
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>> @@ -1080,9 +1023,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct
>> device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (adev->powerplay.pp_funcs->print_clock_levels)
>>> -		size = amdgpu_dpm_print_clock_levels(adev, type, buf);
>>> -	else
>>> +	size = amdgpu_dpm_print_clock_levels(adev, type, buf);
>>> +	if (size <= 0)
>>>    		size = sysfs_emit(buf, "\n");
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>> @@ -1151,10 +1093,7 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct
>> device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (adev->powerplay.pp_funcs->force_clock_level)
>>> -		ret = amdgpu_dpm_force_clock_level(adev, type, mask);
>>> -	else
>>> -		ret = 0;
>>> +	ret = amdgpu_dpm_force_clock_level(adev, type, mask);
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>> @@ -1305,10 +1244,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct
>> device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (is_support_sw_smu(adev))
>>> -		value = 0;
>>> -	else if (adev->powerplay.pp_funcs->get_sclk_od)
>>> -		value = amdgpu_dpm_get_sclk_od(adev);
>>> +	value = amdgpu_dpm_get_sclk_od(adev);
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>> @@ -1342,19 +1278,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct
>> device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (is_support_sw_smu(adev)) {
>>> -		value = 0;
>>> -	} else {
>>> -		if (adev->powerplay.pp_funcs->set_sclk_od)
>>> -			amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
>>> -
>>> -		if (adev->powerplay.pp_funcs->dispatch_tasks) {
>>> -			amdgpu_dpm_dispatch_task(adev,
>> AMD_PP_TASK_READJUST_POWER_STATE, NULL);
>>> -		} else {
>>> -			adev->pm.dpm.current_ps = adev-
>>> pm.dpm.boot_ps;
>>> -			amdgpu_pm_compute_clocks(adev);
>>> -		}
>>> -	}
>>> +	amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>> @@ -1382,10 +1306,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct
>> device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (is_support_sw_smu(adev))
>>> -		value = 0;
>>> -	else if (adev->powerplay.pp_funcs->get_mclk_od)
>>> -		value = amdgpu_dpm_get_mclk_od(adev);
>>> +	value = amdgpu_dpm_get_mclk_od(adev);
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>> @@ -1419,19 +1340,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct
>> device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (is_support_sw_smu(adev)) {
>>> -		value = 0;
>>> -	} else {
>>> -		if (adev->powerplay.pp_funcs->set_mclk_od)
>>> -			amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
>>> -
>>> -		if (adev->powerplay.pp_funcs->dispatch_tasks) {
>>> -			amdgpu_dpm_dispatch_task(adev,
>> AMD_PP_TASK_READJUST_POWER_STATE, NULL);
>>> -		} else {
>>> -			adev->pm.dpm.current_ps = adev-
>>> pm.dpm.boot_ps;
>>> -			amdgpu_pm_compute_clocks(adev);
>>> -		}
>>> -	}
>>> +	amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>> @@ -1479,9 +1388,8 @@ static ssize_t
>> amdgpu_get_pp_power_profile_mode(struct device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (adev->powerplay.pp_funcs->get_power_profile_mode)
>>> -		size = amdgpu_dpm_get_power_profile_mode(adev, buf);
>>> -	else
>>> +	size = amdgpu_dpm_get_power_profile_mode(adev, buf);
>>> +	if (size <= 0)
>>>    		size = sysfs_emit(buf, "\n");
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>> @@ -1545,8 +1453,7 @@ static ssize_t
>> amdgpu_set_pp_power_profile_mode(struct device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (adev->powerplay.pp_funcs->set_power_profile_mode)
>>> -		ret = amdgpu_dpm_set_power_profile_mode(adev,
>> parameter, parameter_size);
>>> +	ret = amdgpu_dpm_set_power_profile_mode(adev, parameter,
>> parameter_size);
>>>
>>>    	pm_runtime_mark_last_busy(ddev->dev);
>>>    	pm_runtime_put_autosuspend(ddev->dev);
>>> @@ -1812,9 +1719,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct
>> device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (adev->powerplay.pp_funcs->get_gpu_metrics)
>>> -		size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
>>> -
>>> +	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
>>>    	if (size <= 0)
>>>    		goto out;
>>>
>>> @@ -2053,7 +1958,6 @@ static int default_attr_update(struct
>> amdgpu_device *adev, struct amdgpu_device_
>>>    {
>>>    	struct device_attribute *dev_attr = &attr->dev_attr;
>>>    	const char *attr_name = dev_attr->attr.name;
>>> -	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
>>>    	enum amd_asic_type asic_type = adev->asic_type;
>>>
>>>    	if (!(attr->flags & mask)) {
>>> @@ -2076,9 +1980,7 @@ static int default_attr_update(struct
>> amdgpu_device *adev, struct amdgpu_device_
>>>    			*states = ATTR_STATE_UNSUPPORTED;
>>>    	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
>>>    		*states = ATTR_STATE_UNSUPPORTED;
>>> -		if ((is_support_sw_smu(adev) && adev->smu.od_enabled)
>> ||
>>> -		    (is_support_sw_smu(adev) && adev->smu.is_apu) ||
>>> -			(!is_support_sw_smu(adev) && hwmgr-
>>> od_enabled))
>>> +		if (amdgpu_dpm_is_overdrive_supported(adev))
>>>    			*states = ATTR_STATE_SUPPORTED;
>>>    	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
>>>    		if (adev->flags & AMD_IS_APU || asic_type == CHIP_VEGA10)
>>> @@ -2105,8 +2007,7 @@ static int default_attr_update(struct
>> amdgpu_device *adev, struct amdgpu_device_
>>>    		if (!(asic_type == CHIP_VANGOGH || asic_type ==
>> CHIP_SIENNA_CICHLID))
>>>    			*states = ATTR_STATE_UNSUPPORTED;
>>>    	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
>>> -		if (!adev->powerplay.pp_funcs->get_power_profile_mode
>> ||
>>> -		    amdgpu_dpm_get_power_profile_mode(adev, NULL) == -
>> EOPNOTSUPP)
>>> +		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) ==
>> -EOPNOTSUPP)
>>>    			*states = ATTR_STATE_UNSUPPORTED;
>>>    	}
>>>
>>> @@ -2389,17 +2290,14 @@ static ssize_t
>> amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
>>> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> -		return -EINVAL;
>>> -	}
>>> -
>>> -	pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
>>> +	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>>>
>>>    	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>    	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>
>>> +	if (ret)
>>> +		return -EINVAL;
>>> +
>>>    	return sysfs_emit(buf, "%u\n", pwm_mode);
>>>    }
>>>
>>> @@ -2427,17 +2325,14 @@ static ssize_t
>> amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
>>> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> -		return -EINVAL;
>>> -	}
>>> -
>>> -	amdgpu_dpm_set_fan_control_mode(adev, value);
>>> +	ret = amdgpu_dpm_set_fan_control_mode(adev, value);
>>>
>>>    	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>    	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>
>>> +	if (ret)
>>> +		return -EINVAL;
>>> +
>>>    	return count;
>>>    }
>>>
>>> @@ -2469,32 +2364,29 @@ static ssize_t
>> amdgpu_hwmon_set_pwm1(struct device *dev,
>>>    	if (adev->in_suspend && !adev->in_runpm)
>>>    		return -EPERM;
>>>
>>> +	err = kstrtou32(buf, 10, &value);
>>> +	if (err)
>>> +		return err;
>>> +
>>>    	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>    	if (err < 0) {
>>>    		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>    		return err;
>>>    	}
>>>
>>> -	pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
>>> +	err = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>>> +	if (err)
>>> +		goto out;
>>> +
>>>    	if (pwm_mode != AMD_FAN_CTRL_MANUAL) {
>>>    		pr_info("manual fan speed control should be enabled
>> first\n");
>>> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> -		return -EINVAL;
>>> +		err = -EINVAL;
>>> +		goto out;
>>>    	}
>>>
>>> -	err = kstrtou32(buf, 10, &value);
>>> -	if (err) {
>>> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> -		return err;
>>> -	}
>>> -
>>> -	if (adev->powerplay.pp_funcs->set_fan_speed_pwm)
>>> -		err = amdgpu_dpm_set_fan_speed_pwm(adev, value);
>>> -	else
>>> -		err = -EINVAL;
>>> +	err = amdgpu_dpm_set_fan_speed_pwm(adev, value);
>>>
>>> +out:
>>>    	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>    	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>
>>> @@ -2523,10 +2415,7 @@ static ssize_t
>> amdgpu_hwmon_get_pwm1(struct device *dev,
>>>    		return err;
>>>    	}
>>>
>>> -	if (adev->powerplay.pp_funcs->get_fan_speed_pwm)
>>> -		err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
>>> -	else
>>> -		err = -EINVAL;
>>> +	err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
>>>
>>>    	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>    	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> @@ -2556,10 +2445,7 @@ static ssize_t
>> amdgpu_hwmon_get_fan1_input(struct device *dev,
>>>    		return err;
>>>    	}
>>>
>>> -	if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
>>> -		err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
>>> -	else
>>> -		err = -EINVAL;
>>> +	err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
>>>
>>>    	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>    	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> @@ -2653,10 +2539,7 @@ static ssize_t
>> amdgpu_hwmon_get_fan1_target(struct device *dev,
>>>    		return err;
>>>    	}
>>>
>>> -	if (adev->powerplay.pp_funcs->get_fan_speed_rpm)
>>> -		err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
>>> -	else
>>> -		err = -EINVAL;
>>> +	err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
>>>
>>>    	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>    	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> @@ -2681,32 +2564,28 @@ static ssize_t
>> amdgpu_hwmon_set_fan1_target(struct device *dev,
>>>    	if (adev->in_suspend && !adev->in_runpm)
>>>    		return -EPERM;
>>>
>>> +	err = kstrtou32(buf, 10, &value);
>>> +	if (err)
>>> +		return err;
>>> +
>>>    	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>    	if (err < 0) {
>>>    		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>    		return err;
>>>    	}
>>>
>>> -	pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
>>> +	err = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>>> +	if (err)
>>> +		goto out;
>>>
>>>    	if (pwm_mode != AMD_FAN_CTRL_MANUAL) {
>>> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> -		return -ENODATA;
>>> -	}
>>> -
>>> -	err = kstrtou32(buf, 10, &value);
>>> -	if (err) {
>>> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> -		return err;
>>> +		err = -ENODATA;
>>> +		goto out;
>>>    	}
>>>
>>> -	if (adev->powerplay.pp_funcs->set_fan_speed_rpm)
>>> -		err = amdgpu_dpm_set_fan_speed_rpm(adev, value);
>>> -	else
>>> -		err = -EINVAL;
>>> +	err = amdgpu_dpm_set_fan_speed_rpm(adev, value);
>>>
>>> +out:
>>>    	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>    	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>
>>> @@ -2735,17 +2614,14 @@ static ssize_t
>> amdgpu_hwmon_get_fan1_enable(struct device *dev,
>>>    		return ret;
>>>    	}
>>>
>>> -	if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
>>> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> -		return -EINVAL;
>>> -	}
>>> -
>>> -	pwm_mode = amdgpu_dpm_get_fan_control_mode(adev);
>>> +	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>>>
>>>    	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>    	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>
>>> +	if (ret)
>>> +		return -EINVAL;
>>> +
>>>    	return sysfs_emit(buf, "%i\n", pwm_mode ==
>> AMD_FAN_CTRL_AUTO ? 0 : 1);
>>>    }
>>>
>>> @@ -2781,16 +2657,14 @@ static ssize_t
>> amdgpu_hwmon_set_fan1_enable(struct device *dev,
>>>    		return err;
>>>    	}
>>>
>>> -	if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
>>> -		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> -		return -EINVAL;
>>> -	}
>>> -	amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
>>> +	err = amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
>>>
>>>    	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>    	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>
>>> +	if (err)
>>> +		return -EINVAL;
>>> +
>>>    	return count;
>>>    }
>>>
>>> @@ -2926,7 +2800,6 @@ static ssize_t
>> amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>>>    					enum pp_power_limit_level
>> pp_limit_level)
>>>    {
>>>    	struct amdgpu_device *adev = dev_get_drvdata(dev);
>>> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	enum pp_power_type power_type = to_sensor_dev_attr(attr)-
>>> index;
>>>    	uint32_t limit;
>>>    	ssize_t size;
>>> @@ -2937,16 +2810,13 @@ static ssize_t
>> amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>>>    	if (adev->in_suspend && !adev->in_runpm)
>>>    		return -EPERM;
>>>
>>> -	if ( !(pp_funcs && pp_funcs->get_power_limit))
>>> -		return -ENODATA;
>>> -
>>>    	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>    	if (r < 0) {
>>>    		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>    		return r;
>>>    	}
>>>
>>> -	r = pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
>>> +	r = amdgpu_dpm_get_power_limit(adev, &limit,
>>>    				      pp_limit_level, power_type);
>>>
>>>    	if (!r)
>>> @@ -3001,7 +2871,6 @@ static ssize_t
>> amdgpu_hwmon_set_power_cap(struct device *dev,
>>>    		size_t count)
>>>    {
>>>    	struct amdgpu_device *adev = dev_get_drvdata(dev);
>>> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	int limit_type = to_sensor_dev_attr(attr)->index;
>>>    	int err;
>>>    	u32 value;
>>> @@ -3027,10 +2896,7 @@ static ssize_t
>> amdgpu_hwmon_set_power_cap(struct device *dev,
>>>    		return err;
>>>    	}
>>>
>>> -	if (pp_funcs && pp_funcs->set_power_limit)
>>> -		err = pp_funcs->set_power_limit(adev-
>>> powerplay.pp_handle, value);
>>> -	else
>>> -		err = -EINVAL;
>>> +	err = amdgpu_dpm_set_power_limit(adev, value);
>>>
>>>    	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>    	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> @@ -3303,6 +3169,7 @@ static umode_t hwmon_attributes_visible(struct
>> kobject *kobj,
>>>    	struct device *dev = kobj_to_dev(kobj);
>>>    	struct amdgpu_device *adev = dev_get_drvdata(dev);
>>>    	umode_t effective_mode = attr->mode;
>>> +	uint32_t speed = 0;
>>>
>>>    	/* under multi-vf mode, the hwmon attributes are all not supported
>> */
>>>    	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>>> @@ -3367,20 +3234,18 @@ static umode_t
>> hwmon_attributes_visible(struct kobject *kobj,
>>>    	     attr == &sensor_dev_attr_fan1_enable.dev_attr.attr))
>>>    		return 0;
>>>
>>> -	if (!is_support_sw_smu(adev)) {
>>> -		/* mask fan attributes if we have no bindings for this asic to
>> expose */
>>> -		if ((!adev->powerplay.pp_funcs->get_fan_speed_pwm &&
>>> -		     attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't
>> query fan */
>>> -		    (!adev->powerplay.pp_funcs->get_fan_control_mode &&
>>> -		     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr))
>> /* can't query state */
>>> -			effective_mode &= ~S_IRUGO;
>>> +	/* mask fan attributes if we have no bindings for this asic to expose
>> */
>>> +	if (((amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL)
>> &&
>>> +	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't query
>> fan */
>>> +	    ((amdgpu_dpm_get_fan_control_mode(adev, &speed) == -
>> EOPNOTSUPP) &&
>>> +	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't
>> query state */
>>> +		effective_mode &= ~S_IRUGO;
>>>
>>> -		if ((!adev->powerplay.pp_funcs->set_fan_speed_pwm &&
>>> -		     attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't
>> manage fan */
>>> -		    (!adev->powerplay.pp_funcs->set_fan_control_mode &&
>>> -		     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr))
>> /* can't manage state */
>>> -			effective_mode &= ~S_IWUSR;
>>> -	}
>>> +	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL)
>> &&
>>> +	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't
>> manage fan */
>>> +	      ((amdgpu_dpm_set_fan_control_mode(adev, speed) == -
>> EOPNOTSUPP) &&
>>> +	      attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't
>> manage state */
>>> +		effective_mode &= ~S_IWUSR;
>>>
>>>    	if (((adev->family == AMDGPU_FAMILY_SI) ||
>>>    		 ((adev->flags & AMD_IS_APU) &&
>>> @@ -3397,22 +3262,20 @@ static umode_t
>> hwmon_attributes_visible(struct kobject *kobj,
>>>    	    (attr == &sensor_dev_attr_power1_average.dev_attr.attr))
>>>    		return 0;
>>>
>>> -	if (!is_support_sw_smu(adev)) {
>>> -		/* hide max/min values if we can't both query and manage
>> the fan */
>>> -		if ((!adev->powerplay.pp_funcs->set_fan_speed_pwm &&
>>> -		     !adev->powerplay.pp_funcs->get_fan_speed_pwm) &&
>>> -		     (!adev->powerplay.pp_funcs->set_fan_speed_rpm &&
>>> -		     !adev->powerplay.pp_funcs->get_fan_speed_rpm) &&
>>> -		    (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
>>> -		     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr))
>>> -			return 0;
>>> +	/* hide max/min values if we can't both query and manage the fan */
>>> +	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL)
>> &&
>>> +	      (amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL)
>> &&
>>> +	      (amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL)
>> &&
>>> +	      (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL))
>> &&
>>> +	    (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
>>> +	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr))
>>> +		return 0;
>>>
>>> -		if ((!adev->powerplay.pp_funcs->set_fan_speed_rpm &&
>>> -		     !adev->powerplay.pp_funcs->get_fan_speed_rpm) &&
>>> -		    (attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
>>> -		     attr == &sensor_dev_attr_fan1_min.dev_attr.attr))
>>> -			return 0;
>>> -	}
>>> +	if ((amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL)
>> &&
>>> +	     (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL)
>> &&
>>> +	     (attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
>>> +	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr))
>>> +		return 0;
>>>
>>>    	if ((adev->family == AMDGPU_FAMILY_SI ||	/* not implemented
>> yet */
>>>    	     adev->family == AMDGPU_FAMILY_KV) &&	/* not implemented
>> yet */
>>> @@ -3542,14 +3405,15 @@ static void
>> amdgpu_debugfs_prints_cpu_info(struct seq_file *m,
>>>    	uint16_t *p_val;
>>>    	uint32_t size;
>>>    	int i;
>>> +	uint32_t num_cpu_cores =
>> amdgpu_dpm_get_num_cpu_cores(adev);
>>>
>>> -	if (is_support_cclk_dpm(adev)) {
>>> -		p_val = kcalloc(adev->smu.cpu_core_num, sizeof(uint16_t),
>>> +	if (amdgpu_dpm_is_cclk_dpm_supported(adev)) {
>>> +		p_val = kcalloc(num_cpu_cores, sizeof(uint16_t),
>>>    				GFP_KERNEL);
>>>
>>>    		if (!amdgpu_dpm_read_sensor(adev,
>> AMDGPU_PP_SENSOR_CPU_CLK,
>>>    					    (void *)p_val, &size)) {
>>> -			for (i = 0; i < adev->smu.cpu_core_num; i++)
>>> +			for (i = 0; i < num_cpu_cores; i++)
>>>    				seq_printf(m, "\t%u MHz (CPU%d)\n",
>>>    					   *(p_val + i), i);
>>>    		}
>>> @@ -3677,27 +3541,11 @@ static int
>> amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
>>>    		return r;
>>>    	}
>>>
>>> -	if (!adev->pm.dpm_enabled) {
>>> -		seq_printf(m, "dpm not enabled\n");
>>> -		pm_runtime_mark_last_busy(dev->dev);
>>> -		pm_runtime_put_autosuspend(dev->dev);
>>> -		return 0;
>>> -	}
>>> -
>>> -	if (!is_support_sw_smu(adev) &&
>>> -	    adev->powerplay.pp_funcs-
>>> debugfs_print_current_performance_level) {
>>> -		mutex_lock(&adev->pm.mutex);
>>> -		if (adev->powerplay.pp_funcs-
>>> debugfs_print_current_performance_level)
>>> -			adev->powerplay.pp_funcs-
>>> debugfs_print_current_performance_level(adev, m);
>>> -		else
>>> -			seq_printf(m, "Debugfs support not implemented
>> for this asic\n");
>>> -		mutex_unlock(&adev->pm.mutex);
>>> -		r = 0;
>>> -	} else {
>>> +	if (amdgpu_dpm_debugfs_print_current_performance_level(adev,
>> m)) {
>>>    		r = amdgpu_debugfs_pm_info_pp(m, adev);
>>> +		if (r)
>>> +			goto out;
>>>    	}
>>> -	if (r)
>>> -		goto out;
>>>
>>>    	amdgpu_device_ip_get_clockgating_state(adev, &flags);
>>>
>>> @@ -3723,21 +3571,18 @@ static ssize_t
>> amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
>>>    					 size_t size, loff_t *pos)
>>>    {
>>>    	struct amdgpu_device *adev = file_inode(f)->i_private;
>>> -	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> -	void *pp_handle = adev->powerplay.pp_handle;
>>>    	size_t smu_prv_buf_size;
>>>    	void *smu_prv_buf;
>>> +	int ret = 0;
>>>
>>>    	if (amdgpu_in_reset(adev))
>>>    		return -EPERM;
>>>    	if (adev->in_suspend && !adev->in_runpm)
>>>    		return -EPERM;
>>>
>>> -	if (pp_funcs && pp_funcs->get_smu_prv_buf_details)
>>> -		pp_funcs->get_smu_prv_buf_details(pp_handle,
>> &smu_prv_buf,
>>> -						  &smu_prv_buf_size);
>>> -	else
>>> -		return -ENOSYS;
>>> +	ret = amdgpu_dpm_get_smu_prv_buf_details(adev, &smu_prv_buf,
>> &smu_prv_buf_size);
>>> +	if (ret)
>>> +		return ret;
>>>
>>>    	if (!smu_prv_buf || !smu_prv_buf_size)
>>>    		return -EINVAL;
>>> @@ -3770,6 +3615,6 @@ void amdgpu_debugfs_pm_init(struct
>> amdgpu_device *adev)
>>>
>> &amdgpu_debugfs_pm_prv_buffer_fops,
>>>    					 adev->pm.smu_prv_buffer_size);
>>>
>>> -	amdgpu_smu_stb_debug_fs_init(adev);
>>> +	amdgpu_dpm_stb_debug_fs_init(adev);
>>>    #endif
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> index 7289d379a9fb..039c40b1d0cb 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> @@ -262,9 +262,6 @@ enum amdgpu_pcie_gen {
>>>    #define amdgpu_dpm_pre_set_power_state(adev) \
>>>    		((adev)->powerplay.pp_funcs-
>>> pre_set_power_state((adev)->powerplay.pp_handle))
>>>
>>> -#define amdgpu_dpm_set_power_state(adev) \
>>> -		((adev)->powerplay.pp_funcs->set_power_state((adev)-
>>> powerplay.pp_handle))
>>> -
>>>    #define amdgpu_dpm_post_set_power_state(adev) \
>>>    		((adev)->powerplay.pp_funcs-
>>> post_set_power_state((adev)->powerplay.pp_handle))
>>>
>>> @@ -280,100 +277,13 @@ enum amdgpu_pcie_gen {
>>>    #define amdgpu_dpm_enable_bapm(adev, e) \
>>>    		((adev)->powerplay.pp_funcs->enable_bapm((adev)-
>>> powerplay.pp_handle, (e)))
>>>
>>> -#define amdgpu_dpm_set_fan_control_mode(adev, m) \
>>> -		((adev)->powerplay.pp_funcs-
>>> set_fan_control_mode((adev)->powerplay.pp_handle, (m)))
>>> -
>>> -#define amdgpu_dpm_get_fan_control_mode(adev) \
>>> -		((adev)->powerplay.pp_funcs-
>>> get_fan_control_mode((adev)->powerplay.pp_handle))
>>> -
>>> -#define amdgpu_dpm_set_fan_speed_pwm(adev, s) \
>>> -		((adev)->powerplay.pp_funcs-
>>> set_fan_speed_pwm((adev)->powerplay.pp_handle, (s)))
>>> -
>>> -#define amdgpu_dpm_get_fan_speed_pwm(adev, s) \
>>> -		((adev)->powerplay.pp_funcs-
>>> get_fan_speed_pwm((adev)->powerplay.pp_handle, (s)))
>>> -
>>> -#define amdgpu_dpm_get_fan_speed_rpm(adev, s) \
>>> -		((adev)->powerplay.pp_funcs-
>>> get_fan_speed_rpm)((adev)->powerplay.pp_handle, (s))
>>> -
>>> -#define amdgpu_dpm_set_fan_speed_rpm(adev, s) \
>>> -		((adev)->powerplay.pp_funcs-
>>> set_fan_speed_rpm)((adev)->powerplay.pp_handle, (s))
>>> -
>>> -#define amdgpu_dpm_force_performance_level(adev, l) \
>>> -		((adev)->powerplay.pp_funcs-
>>> force_performance_level((adev)->powerplay.pp_handle, (l)))
>>> -
>>> -#define amdgpu_dpm_get_current_power_state(adev) \
>>> -		((adev)->powerplay.pp_funcs-
>>> get_current_power_state((adev)->powerplay.pp_handle))
>>> -
>>> -#define amdgpu_dpm_get_pp_num_states(adev, data) \
>>> -		((adev)->powerplay.pp_funcs->get_pp_num_states((adev)-
>>> powerplay.pp_handle, data))
>>> -
>>> -#define amdgpu_dpm_get_pp_table(adev, table) \
>>> -		((adev)->powerplay.pp_funcs->get_pp_table((adev)-
>>> powerplay.pp_handle, table))
>>> -
>>> -#define amdgpu_dpm_set_pp_table(adev, buf, size) \
>>> -		((adev)->powerplay.pp_funcs->set_pp_table((adev)-
>>> powerplay.pp_handle, buf, size))
>>> -
>>> -#define amdgpu_dpm_print_clock_levels(adev, type, buf) \
>>> -		((adev)->powerplay.pp_funcs->print_clock_levels((adev)-
>>> powerplay.pp_handle, type, buf))
>>> -
>>> -#define amdgpu_dpm_force_clock_level(adev, type, level) \
>>> -		((adev)->powerplay.pp_funcs->force_clock_level((adev)-
>>> powerplay.pp_handle, type, level))
>>> -
>>> -#define amdgpu_dpm_get_sclk_od(adev) \
>>> -		((adev)->powerplay.pp_funcs->get_sclk_od((adev)-
>>> powerplay.pp_handle))
>>> -
>>> -#define amdgpu_dpm_set_sclk_od(adev, value) \
>>> -		((adev)->powerplay.pp_funcs->set_sclk_od((adev)-
>>> powerplay.pp_handle, value))
>>> -
>>> -#define amdgpu_dpm_get_mclk_od(adev) \
>>> -		((adev)->powerplay.pp_funcs->get_mclk_od((adev)-
>>> powerplay.pp_handle))
>>> -
>>> -#define amdgpu_dpm_set_mclk_od(adev, value) \
>>> -		((adev)->powerplay.pp_funcs->set_mclk_od((adev)-
>>> powerplay.pp_handle, value))
>>> -
>>> -#define amdgpu_dpm_dispatch_task(adev, task_id, user_state)
>> 	\
>>> -		((adev)->powerplay.pp_funcs->dispatch_tasks)((adev)-
>>> powerplay.pp_handle, (task_id), (user_state))
>>> -
>>>    #define amdgpu_dpm_check_state_equal(adev, cps, rps, equal) \
>>>    		((adev)->powerplay.pp_funcs->check_state_equal((adev)-
>>> powerplay.pp_handle, (cps), (rps), (equal)))
>>>
>>> -#define amdgpu_dpm_get_vce_clock_state(adev, i)
>> 		\
>>> -		((adev)->powerplay.pp_funcs->get_vce_clock_state((adev)-
>>> powerplay.pp_handle, (i)))
>>> -
>>> -#define amdgpu_dpm_get_performance_level(adev)
>> 		\
>>> -		((adev)->powerplay.pp_funcs-
>>> get_performance_level((adev)->powerplay.pp_handle))
>>> -
>>>    #define amdgpu_dpm_reset_power_profile_state(adev, request) \
>>>    		((adev)->powerplay.pp_funcs-
>>> reset_power_profile_state(\
>>>    			(adev)->powerplay.pp_handle, request))
>>>
>>> -#define amdgpu_dpm_get_power_profile_mode(adev, buf) \
>>> -		((adev)->powerplay.pp_funcs->get_power_profile_mode(\
>>> -			(adev)->powerplay.pp_handle, buf))
>>> -
>>> -#define amdgpu_dpm_set_power_profile_mode(adev, parameter, size)
>> \
>>> -		((adev)->powerplay.pp_funcs->set_power_profile_mode(\
>>> -			(adev)->powerplay.pp_handle, parameter, size))
>>> -
>>> -#define amdgpu_dpm_set_fine_grain_clk_vol(adev, type, parameter,
>> size) \
>>> -		((adev)->powerplay.pp_funcs->set_fine_grain_clk_vol(\
>>> -			(adev)->powerplay.pp_handle, type, parameter,
>> size))
>>> -
>>> -#define amdgpu_dpm_odn_edit_dpm_table(adev, type, parameter, size)
>> \
>>> -		((adev)->powerplay.pp_funcs->odn_edit_dpm_table(\
>>> -			(adev)->powerplay.pp_handle, type, parameter,
>> size))
>>> -
>>> -#define amdgpu_dpm_get_ppfeature_status(adev, buf) \
>>> -		((adev)->powerplay.pp_funcs->get_ppfeature_status(\
>>> -			(adev)->powerplay.pp_handle, (buf)))
>>> -
>>> -#define amdgpu_dpm_set_ppfeature_status(adev, ppfeatures) \
>>> -		((adev)->powerplay.pp_funcs->set_ppfeature_status(\
>>> -			(adev)->powerplay.pp_handle, (ppfeatures)))
>>> -
>>> -#define amdgpu_dpm_get_gpu_metrics(adev, table) \
>>> -		((adev)->powerplay.pp_funcs->get_gpu_metrics((adev)-
>>> powerplay.pp_handle, table))
>>> -
>>>    struct amdgpu_dpm {
>>>    	struct amdgpu_ps        *ps;
>>>    	/* number of valid power states */
>>> @@ -598,4 +508,74 @@ void amdgpu_dpm_gfx_state_change(struct
>> amdgpu_device *adev,
>>>    				 enum gfx_change_state state);
>>>    int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
>>>    			    void *umc_ecc);
>>> +struct amd_vce_state *amdgpu_dpm_get_vce_clock_state(struct
>> amdgpu_device *adev,
>>> +						     uint32_t idx);
>>> +void amdgpu_dpm_get_current_power_state(struct amdgpu_device
>> *adev, enum amd_pm_state_type *state);
>>> +void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
>>> +				enum amd_pm_state_type state);
>>> +enum amd_dpm_forced_level
>> amdgpu_dpm_get_performance_level(struct amdgpu_device *adev);
>>> +int amdgpu_dpm_force_performance_level(struct amdgpu_device
>> *adev,
>>> +				       enum amd_dpm_forced_level level);
>>> +int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
>>> +				 struct pp_states_info *states);
>>> +int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
>>> +			      enum amd_pp_task task_id,
>>> +			      enum amd_pm_state_type *user_state);
>>> +int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char
>> **table);
>>> +int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
>>> +				      uint32_t type,
>>> +				      long *input,
>>> +				      uint32_t size);
>>> +int amdgpu_dpm_odn_edit_dpm_table(struct amdgpu_device *adev,
>>> +				  uint32_t type,
>>> +				  long *input,
>>> +				  uint32_t size);
>>> +int amdgpu_dpm_print_clock_levels(struct amdgpu_device *adev,
>>> +				  enum pp_clock_type type,
>>> +				  char *buf);
>>> +int amdgpu_dpm_set_ppfeature_status(struct amdgpu_device *adev,
>>> +				    uint64_t ppfeature_masks);
>>> +int amdgpu_dpm_get_ppfeature_status(struct amdgpu_device *adev,
>> char *buf);
>>> +int amdgpu_dpm_force_clock_level(struct amdgpu_device *adev,
>>> +				 enum pp_clock_type type,
>>> +				 uint32_t mask);
>>> +int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev);
>>> +int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t
>> value);
>>> +int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev);
>>> +int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t
>> value);
>>> +int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device
>> *adev,
>>> +				      char *buf);
>>> +int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device
>> *adev,
>>> +				      long *input, uint32_t size);
>>> +int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void
>> **table);
>>> +int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
>>> +				    uint32_t *fan_mode);
>>> +int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
>>> +				 uint32_t speed);
>>> +int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
>>> +				 uint32_t *speed);
>>> +int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
>>> +				 uint32_t *speed);
>>> +int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
>>> +				 uint32_t speed);
>>> +int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
>>> +				    uint32_t mode);
>>> +int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
>>> +			       uint32_t *limit,
>>> +			       enum pp_power_limit_level pp_limit_level,
>>> +			       enum pp_power_type power_type);
>>> +int amdgpu_dpm_set_power_limit(struct amdgpu_device *adev,
>>> +			       uint32_t limit);
>>> +int amdgpu_dpm_is_cclk_dpm_supported(struct amdgpu_device *adev);
>>> +int amdgpu_dpm_debugfs_print_current_performance_level(struct
>> amdgpu_device *adev,
>>> +						       struct seq_file *m);
>>> +int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device
>> *adev,
>>> +				       void **addr,
>>> +				       size_t *size);
>>> +int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev);
>>> +int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
>>> +			    const char *buf,
>>> +			    size_t size);
>>> +int amdgpu_dpm_get_num_cpu_cores(struct amdgpu_device *adev);
>>> +void amdgpu_dpm_stb_debug_fs_init(struct amdgpu_device *adev);
>>>    #endif
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index d8cd7c8c4479..51358383f672 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -470,9 +470,6 @@ bool is_support_cclk_dpm(struct amdgpu_device
>> *adev)
>>>    {
>>>    	struct smu_context *smu = &adev->smu;
>>>
>>> -	if (!is_support_sw_smu(adev))
>>> -		return false;
>>> -
>>>    	if (!smu_feature_is_enabled(smu, SMU_FEATURE_CCLK_DPM_BIT))
>>>    		return false;
>>>
>>>
