Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03212C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 05:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A7CE10E9D2;
	Thu, 17 Feb 2022 05:01:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C195210E9D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 05:01:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+OTbzs4DXR6G8u7B9faGeUtkQrtK5BitlvdGyl5S1uMpiY3iH6eygsYBkX+QQiWoVqLF+Gj3qDRy20f/7eZnxPJc3B0pp1LG9iVXRLbqQZUF2kXsUPwOfA93Zlx1mqTACRVeUH9VOTf8abIf70ITNM/gwCfchKBMQCHECuoT9Ns4m/uebnxg7YPfns5JN1wpvXq49oBXojFZ1dOSx2DXGUHoKBryq1kHFArYEfhP6HWEWBQq4nC5h2u/CED0eYDu/W2QKc6Iz4Z4UyGO/dlGCVQyBdP03Neij9fz+5Vv7MdYkx7ZNrdshkZtexkK102frP2LNGGnf8kF54v+ThuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uuB3SlahWIDTXDZ/uUqNhkd0hdpyruLwEyQYSVO/3o=;
 b=l5l1lZ+hgDj09OGbZKvfeL4FfPzTwP8ELsXhl88k06/F6McJUarSuX4MdCIQvauklD1klkdkc3m18fGGNMwikkCFaKO/+0g1f0bawkKa4FZNNgFSSON1rb82fm/z6wyND4+L6TWnbe9JzT+hETZKgfxwOTCAPst1ptGsNENjcnDIfW5xm1ZyAzKxyCXEpuHZQfotBv3RL420ulYqKjg7KF6Z53HY3GBM7ESGhNiEzB0L54h3g8t4nM+X2TQxQHW/DCRTJE5bjBjKL73fIJ6NY3d4/8R9wsqvWjawRHtu6k8qGa+27tKEyBVcDinzeVHykQKt1NH9ZKiqzWcT6L3eKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uuB3SlahWIDTXDZ/uUqNhkd0hdpyruLwEyQYSVO/3o=;
 b=f9WllDyU7UORHzmWJPsK2pWVYNWX5obNnoxFs9zsmJIs7IaZGTMCQUESGusNtdXuxCW4dqrYUwKPKLoUhM208D0ELerau3+FN/GIjXS67+U2cnRAZosFvEZFlhdcZtZXof+ovqb29xB7qQixQcYcsMOL7OVd9oPIUPjsOD3FVhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 05:01:00 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 05:01:00 +0000
Message-ID: <31658056-b098-ebff-890b-5ec0d25ab694@amd.com>
Date: Thu, 17 Feb 2022 10:30:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 07/12] drm/amd/pm: correct the checks for granting gpu
 reset APIs
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220211075209.894833-1-evan.quan@amd.com>
 <20220211075209.894833-7-evan.quan@amd.com>
 <80a49c9c-77f6-5047-6584-da24f49596f7@amd.com>
 <DM6PR12MB2619BDE08C13C9F3FD5C1FADE4369@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619BDE08C13C9F3FD5C1FADE4369@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::14) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f1075b0-daed-4241-b6cd-08d9f1d27da7
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB384899D3CEFA4EF9222A976F97369@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nx/SQ3NmKdqV1x986KivQNVzcPZQdnJyciWWqx51ko8xSnaUZFyEokgZoITBa9CMDK/Ql/gt4BQSGRZZ6tW4xZpJUh3gX/O59YkrNz8Oeqzy1XRbQpPThrvee1xGNOvURcIkFL+AMpHwLNBaFMF44woCSUYX6WLWdrP6L4ajPb9AWHGVdLlggGZ7KEVVy+V+1OClSo4f6ujG577/upShYgIXsr+fzE9uBcjZ0w9lXk4IXfEn8n56OgsgS0Z799CR5ADdQoHJ6vsqc6sGMRQorR/HnftqxEgEB7ucCy8ASfPUFZ7fvqzn8nSCrXJ4842FXYuPfp2pKdhemye2tTxjfI58qvJDy38ZkygQmlqVAwD7g45daUmzUb7htnkgYhHwQ+/EX+7jBTlBwmjz9KsHCfEnMa9EOLa1jY7p5anK1NSygPC3UKXs1MLZvU3/MFncJS/FqoGtt9Bf+e7vUoej8uUgVZ9npXPIe/V32loc5rs1PGs/gUXKw8CjhWMfh+kn7mmkrOE97XJVk9x3Lqe3U/DIFXur+350gFXIlPX4Q5XpTwPRKiM2YCmHQsGCIgVnhVNs1usQVrK/V/HsJW0R2S4wDlpIAg19yp2uFKt+rFQsu2wXKhXNgJVCcUmRLmJfk32vIijB230u/e1nVBQefvRdqJUlAvP8iT4g39wRp9AF5w2JdcGYs+VwEkKOkWsD6vk3ssIkMp0UgORbiMV8lkc1mQ3DVnH7jr7oNsKDuLrb8wJVKrDNgB3MWtyCAI3j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(66556008)(66476007)(6512007)(5660300002)(31686004)(86362001)(30864003)(508600001)(8676002)(4326008)(66946007)(2616005)(36756003)(83380400001)(6486002)(186003)(38100700002)(110136005)(54906003)(316002)(6506007)(2906002)(6666004)(26005)(53546011)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWFadnhKd05TWG5CRXhjT1FkQmc3V3gxREZlV1BzZm8vZFZZalBGaXgrT0pT?=
 =?utf-8?B?ZER4RjFleWlXS3FkVm1mbnhOT0MrTjVyclpxWGQrdGpNSGRpRjhuNTRaM2pM?=
 =?utf-8?B?a0NOTXFJYURVQ3pVT1BJNXNXNlJjMWx0Rng1VFdkMVVoYW9BWlJ0T2RGT2JC?=
 =?utf-8?B?ektGTnhRMFNkYlVzNm80YkdRS3ZsQ2xXUWFYa2dqMlJsejR5a2hVZGt4SVJI?=
 =?utf-8?B?ZzVuV0JFc1Bpd01ZYmd1VE9UR0o4djUweGdiVXdQamFZYWg1aGxIWWNyblVo?=
 =?utf-8?B?bFRGZjlnVHU3VVYrYmlnN0JMamo4VUlZb3Vvd3NSQWlTbCtqT0xlb3o4TVVq?=
 =?utf-8?B?MndEZ2QxUGkrS1BYaWNBQlRIcVNTY2xKNDhYRlBLN25PdDFTQ1RlZ2ZtMzFV?=
 =?utf-8?B?VGg0NW5KS1lGMXF6dm9TVXhYbnVCcmR3V2loSUQvWkR4SjQvN0NNNFZxOVVq?=
 =?utf-8?B?MUNYT01JaXNvMEwzNFVFeGlETTR5MGJNaXMxNm5iWGwxT01aTG5nSTRKNGdJ?=
 =?utf-8?B?Kys2MG9MRFlnUzcrc0JJRWhtWlpmaFR2cnZzMXBqc3ZaV2NRNTFoc2gxVG5T?=
 =?utf-8?B?RmZpU2p0UVJ6SG9qNWJYcmg3WThpcjQrM0VNcVNOS1RCUGErdHZEZTljNmxv?=
 =?utf-8?B?dk12ekg3RG1qMHVGZFJrS0gxNVhaQXJZcXJLRklyQjMvN2tSWHd2UW9FQ2tR?=
 =?utf-8?B?ZjJNRE5Qd0FhRlBLdllJd1B2ZHpWRXErbGJFVGZvZCtUYWNtT0NqUGwxRzIx?=
 =?utf-8?B?Zkd4WHViMEttdEJNanFOdHVxU2xPSCtrMGNtTGhkNytKNWRWSms4MnpXK3R1?=
 =?utf-8?B?Yi85Z3dCZFBFUmFvUE9YRGxLTElra1diYkFteEFBcE5ubHAyMmJVKzlybUtK?=
 =?utf-8?B?WnpOWjFDaG5td0FMbmNSVlJwZFhEd0FnekpDTXFVRUpxSS8wSGpURXBLVVYw?=
 =?utf-8?B?L3IwN29COXVwcGppTnBGL2Jza0lneElaeWZXb0habUR2eU83Zzl3cGplUlJ4?=
 =?utf-8?B?ZlE4c1RlcTNGWjhiSm4wdDRXTlB6WGphVjR2VXdCbzkvNFVyMVhDTUU2bDRL?=
 =?utf-8?B?V1FQV0dkam82eEdBdldPZGxvdS9sN0xhcUJzSU8weVJTWUxnRGNBQzRoRVVX?=
 =?utf-8?B?U2JERHh0WTIxQ1FVWGZ3VS9hOHF3emI0czFyQTVsZXBCSitZTWVJcDBmaGF5?=
 =?utf-8?B?czByS2c0allRYkVDdnBuMUpXb0gyWG5reEVnK2dCMENzUlNLMmJYMStYMDlp?=
 =?utf-8?B?bmlKUDYyaDVQNWlEZTVuNUVEKzArcHl3b0dRSFY2aGFnMGVnYzNSOFNRUUFW?=
 =?utf-8?B?dkUvUGNKYkIrWU9Yb0dlM2FZWEN2NkZFUWxxVTRySjI5enZnQUgrb1htZ0Rp?=
 =?utf-8?B?MXd4LzlXc0pMaHAxMGh1U1cyem5idzNkOU5KQURmZ0VBK0R5c1h3M3NWaVdu?=
 =?utf-8?B?aTFUT1BiZ0tVd250cHR5d0d3LzhLV1VTRGZqaGhqb0tGUUpmTXNSS00xZ3NV?=
 =?utf-8?B?YXp3eWg2SU1NcFNkTjdlZDhycEJIa29WaG44NzR1UVJ5SXQ2clJTWEZaRExv?=
 =?utf-8?B?MUhKdHZNRzBmVmlIcDIwWFNFV3RhZUFUMVdJRTJrUkFnclNRY0l0QzlucUFr?=
 =?utf-8?B?R0doSGhWWktzRC9pSzlpQlB2OG9lWmIybDBaSGRVM0xuNXJUeGJQdnlmV1ZF?=
 =?utf-8?B?ZHp0M0VSdS9tZElSdVN3RE9DcFBveW9ZYnc0MkNzREJxSG5JY2JXOWlJSnhr?=
 =?utf-8?B?TzVlZWFSemZVSDAyZVZaZS9hTTQ2NzlYY2h5T0c5aG5MN256eWUwVFFpYVdY?=
 =?utf-8?B?YmczbnkyUEFTVE44N29lUWYzY0VNZXh6c0dJMk9lTGRsaE9FRDBoMEwwMkQ3?=
 =?utf-8?B?b1E4Y2dLaW9rMmpRMTYycDZiSEhLMFg1VVIwQ1lqemF5ZkpBUG5GczBhdlpZ?=
 =?utf-8?B?aFFnVTQ2c3RLbmxEZDlqd3M5OUk3NzNKZnBTR1dxeEUrNkJ6b3RmMGVRUjNh?=
 =?utf-8?B?aURXeGdqVEFTbndBRFl1M3pQNzl4QmpYUUFodnNrSk1ablRIaTRBLzZXQ3dh?=
 =?utf-8?B?dlF4M3RMYUFJS0UxUmh6bk4vMWFzM0I0RVpvK1ZsNCt2U0VTaFVIeWwxVmxk?=
 =?utf-8?Q?QVho=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1075b0-daed-4241-b6cd-08d9f1d27da7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 05:01:00.7111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1b29PKksUpEjNi+v5GtE5YXWo910qmpWYo8e1qyW32UMwFIN538VAxa082iUrjEz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "rui.huang@amd.com" <rui.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/17/2022 8:18 AM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, February 14, 2022 12:04 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
>> rui.huang@amd.com
>> Subject: Re: [PATCH 07/12] drm/amd/pm: correct the checks for granting gpu
>> reset APIs
>>
>>
>>
>> On 2/11/2022 1:22 PM, Evan Quan wrote:
>>> Those gpu reset APIs can be granted when:
>>>     - System is up and dpm features are enabled.
>>>     - System is under resuming and dpm features are not yet enabled.
>>>       Under such scenario, the PMFW is already alive and can support
>>>       those gpu reset functionalities.
>>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: I8c2f07138921eb53a2bd7fb94f9b3622af0eacf8
>>> ---
>>>    .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
>>>    drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 34 +++++++++++++++
>>>    .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 42
>> +++++++++++++++----
>>>    .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   |  1 +
>>>    .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 17 ++++++++
>>>    drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  1 +
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 32 +++++++-------
>>>    7 files changed, 101 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>> index a4c267f15959..892648a4a353 100644
>>> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>> @@ -409,6 +409,7 @@ struct amd_pm_funcs {
>>>    				   struct dpm_clocks *clock_table);
>>>    	int (*get_smu_prv_buf_details)(void *handle, void **addr, size_t
>> *size);
>>>    	void (*pm_compute_clocks)(void *handle);
>>> +	bool (*is_smc_alive)(void *handle);
>>>    };
>>>
>>>    struct metrics_table_header {
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> index b46ae0063047..5f1d3342f87b 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> @@ -120,12 +120,25 @@ int
>> amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
>> uint32_t block
>>>    	return ret;
>>>    }
>>>
>>> +static bool amdgpu_dpm_is_smc_alive(struct amdgpu_device *adev) {
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	if (!pp_funcs || !pp_funcs->is_smc_alive)
>>> +		return false;
>>> +
>>> +	return pp_funcs->is_smc_alive;
>>> +}
>>> +
>>>    int amdgpu_dpm_baco_enter(struct amdgpu_device *adev)
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>    	void *pp_handle = adev->powerplay.pp_handle;
>>>    	int ret = 0;
>>>
>>> +	if (!amdgpu_dpm_is_smc_alive(adev))
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
>>>    		return -ENOENT;
>>>
>>> @@ -145,6 +158,9 @@ int amdgpu_dpm_baco_exit(struct amdgpu_device
>> *adev)
>>>    	void *pp_handle = adev->powerplay.pp_handle;
>>>    	int ret = 0;
>>>
>>> +	if (!amdgpu_dpm_is_smc_alive(adev))
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
>>>    		return -ENOENT;
>>>
>>> @@ -164,6 +180,9 @@ int amdgpu_dpm_set_mp1_state(struct
>> amdgpu_device *adev,
>>>    	int ret = 0;
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>
>>> +	if (!amdgpu_dpm_is_smc_alive(adev))
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (pp_funcs && pp_funcs->set_mp1_state) {
>>>    		mutex_lock(&adev->pm.mutex);
>>>
>>> @@ -184,6 +203,9 @@ bool amdgpu_dpm_is_baco_supported(struct
>> amdgpu_device *adev)
>>>    	bool baco_cap;
>>>    	int ret = 0;
>>>
>>> +	if (!amdgpu_dpm_is_smc_alive(adev))
>>> +		return false;
>>> +
>>>    	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
>>>    		return false;
>>>
>>> @@ -203,6 +225,9 @@ int amdgpu_dpm_mode2_reset(struct
>> amdgpu_device *adev)
>>>    	void *pp_handle = adev->powerplay.pp_handle;
>>>    	int ret = 0;
>>>
>>> +	if (!amdgpu_dpm_is_smc_alive(adev))
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs || !pp_funcs->asic_reset_mode_2)
>>>    		return -ENOENT;
>>>
>>> @@ -221,6 +246,9 @@ int amdgpu_dpm_baco_reset(struct
>> amdgpu_device *adev)
>>>    	void *pp_handle = adev->powerplay.pp_handle;
>>>    	int ret = 0;
>>>
>>> +	if (!amdgpu_dpm_is_smc_alive(adev))
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
>>>    		return -ENOENT;
>>>
>>> @@ -244,6 +272,9 @@ bool
>> amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev)
>>>    	struct smu_context *smu = adev->powerplay.pp_handle;
>>>    	bool support_mode1_reset = false;
>>>
>>> +	if (!amdgpu_dpm_is_smc_alive(adev))
>>> +		return false;
>>> +
>>>    	if (is_support_sw_smu(adev)) {
>>>    		mutex_lock(&adev->pm.mutex);
>>>    		support_mode1_reset =
>> smu_mode1_reset_is_support(smu); @@ -258,6
>>> +289,9 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev)
>>>    	struct smu_context *smu = adev->powerplay.pp_handle;
>>>    	int ret = -EOPNOTSUPP;
>>>
>>> +	if (!amdgpu_dpm_is_smc_alive(adev))
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	if (is_support_sw_smu(adev)) {
>>>    		mutex_lock(&adev->pm.mutex);
>>>    		ret = smu_mode1_reset(smu);
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> index bba923cfe08c..4c709f7bcd51 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> @@ -844,9 +844,6 @@ static int pp_dpm_set_mp1_state(void *handle,
>> enum pp_mp1_state mp1_state)
>>>    	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>> -	if (!hwmgr->pm_en)
>>> -		return 0;
>>> -
>>>    	if (hwmgr->hwmgr_func->set_mp1_state)
>>>    		return hwmgr->hwmgr_func->set_mp1_state(hwmgr,
>> mp1_state);
>>>
>>> @@ -1305,8 +1302,7 @@ static int pp_get_asic_baco_capability(void
>> *handle, bool *cap)
>>>    	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>> -	if (!(hwmgr->not_vf && amdgpu_dpm) ||
>>> -		!hwmgr->hwmgr_func->get_asic_baco_capability)
>>> +	if (!hwmgr->hwmgr_func->get_asic_baco_capability)
>>>    		return 0;
>>>
>>>    	hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr, cap); @@ -
>> 1321,7
>>> +1317,7 @@ static int pp_get_asic_baco_state(void *handle, int *state)
>>>    	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>> -	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_state)
>>> +	if (!hwmgr->hwmgr_func->get_asic_baco_state)
>>>    		return 0;
>>>
>>>    	hwmgr->hwmgr_func->get_asic_baco_state(hwmgr, (enum
>> BACO_STATE
>>> *)state); @@ -1336,8 +1332,7 @@ static int pp_set_asic_baco_state(void
>> *handle, int state)
>>>    	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>> -	if (!(hwmgr->not_vf && amdgpu_dpm) ||
>>> -		!hwmgr->hwmgr_func->set_asic_baco_state)
>>> +	if (!hwmgr->hwmgr_func->set_asic_baco_state)
>>>    		return 0;
>>>
>>>    	hwmgr->hwmgr_func->set_asic_baco_state(hwmgr, (enum
>>> BACO_STATE)state); @@ -1379,7 +1374,7 @@ static int
>> pp_asic_reset_mode_2(void *handle)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>> -	if (!hwmgr || !hwmgr->pm_en)
>>> +	if (!hwmgr)
>>>    		return -EINVAL;
>>>
>>>    	if (hwmgr->hwmgr_func->asic_reset == NULL) { @@ -1517,6
>> +1512,34 @@
>>> static void pp_pm_compute_clocks(void *handle)
>>>    			      NULL);
>>>    }
>>>
>>> +/* MP Apertures */
>>> +#define MP1_Public					0x03b00000
>>> +#define smnMP1_FIRMWARE_FLAGS
>> 	0x3010028
>>> +#define MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK
>> 	0x00000001L
>>> +
>>> +static bool pp_is_smc_alive(void *handle) {
>>> +	struct pp_hwmgr *hwmgr = handle;
>>> +	struct amdgpu_device *adev = hwmgr->adev;
>>> +	uint32_t mp1_fw_flags;
>>> +
>>> +	/*
>>> +	 * If some ASIC(e.g. smu7/smu8) needs special handling for
>>> +	 * checking smc alive, it should have its own implementation
>>> +	 * for ->is_smc_alive.
>>> +	 */
>>> +	if (hwmgr->hwmgr_func->is_smc_alive)
>>> +		return hwmgr->hwmgr_func->is_smc_alive(hwmgr);
>>> +
>>> +	mp1_fw_flags = RREG32_PCIE(MP1_Public |
>>> +				   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
>>> +
>>
>> The flags check doesn't tell whether PMFW is hung or not. It is a minimal
>> thing that is set after PMFW boot. To call the API this condition is necessary in
>> an implicit way. Driver always check this on boot, if not driver aborts smu init.
>>
>> So better thing is to go ahead and send the message without any check, it will
>> tell the result whether PMFW is really working or not.
>>
>> In short this API is not needed.
> [Quan, Evan] It was not designed to cover "PMFW hung". Instead, it was designed to be support early phase of post-silicon bringup.
> At that time, the SMU may be not enabled/up. We need to prevent this API from wrongly called.
> 

One of the first things done, atleast in swsmu, is hw_init/resume -> 
smu_start_smc_engine -> check_fw_status.

If smu is not up/enabled, this call shouldn't even happen as init itself 
will fail.

Thanks,
Lijo

> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> +	if (mp1_fw_flags &
>> MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK)
>>> +		return true;
>>> +
>>> +	return false;
>>> +}
>>> +
>>>    static const struct amd_pm_funcs pp_dpm_funcs = {
>>>    	.load_firmware = pp_dpm_load_fw,
>>>    	.wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
>> @@
>>> -1582,4 +1605,5 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
>>>    	.gfx_state_change_set = pp_gfx_state_change_set,
>>>    	.get_smu_prv_buf_details = pp_get_prv_buffer_details,
>>>    	.pm_compute_clocks = pp_pm_compute_clocks,
>>> +	.is_smc_alive = pp_is_smc_alive,
>>>    };
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
>>> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
>>> index a1e11037831a..118039b96524 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
>>> @@ -5735,6 +5735,7 @@ static const struct pp_hwmgr_func
>> smu7_hwmgr_funcs = {
>>>    	.get_asic_baco_state = smu7_baco_get_state,
>>>    	.set_asic_baco_state = smu7_baco_set_state,
>>>    	.power_off_asic = smu7_power_off_asic,
>>> +	.is_smc_alive = smu7_is_smc_ram_running,
>>>    };
>>>
>>>    uint8_t smu7_get_sleep_divider_id_from_clock(uint32_t clock, diff
>>> --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
>>> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
>>> index b50fd4a4a3d1..fc4d58329f6d 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
>>> @@ -2015,6 +2015,22 @@ static void smu8_dpm_powergate_vce(struct
>> pp_hwmgr *hwmgr, bool bgate)
>>>    	}
>>>    }
>>>
>>> +#define ixMP1_FIRMWARE_FLAGS
>> 	0x3008210
>>> +#define MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK
>> 	0x00000001L
>>> +
>>> +static bool smu8_is_smc_running(struct pp_hwmgr *hwmgr) {
>>> +	struct amdgpu_device *adev = hwmgr->adev;
>>> +	uint32_t mp1_fw_flags;
>>> +
>>> +	mp1_fw_flags = RREG32_SMC(ixMP1_FIRMWARE_FLAGS);
>>> +
>>> +	if (mp1_fw_flags &
>> MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK)
>>> +		return true;
>>> +
>>> +	return false;
>>> +}
>>> +
>>>    static const struct pp_hwmgr_func smu8_hwmgr_funcs = {
>>>    	.backend_init = smu8_hwmgr_backend_init,
>>>    	.backend_fini = smu8_hwmgr_backend_fini, @@ -2047,6 +2063,7
>> @@
>>> static const struct pp_hwmgr_func smu8_hwmgr_funcs = {
>>>    	.dynamic_state_management_disable = smu8_disable_dpm_tasks,
>>>    	.notify_cac_buffer_info = smu8_notify_cac_buffer_info,
>>>    	.get_thermal_temperature_range =
>>> smu8_get_thermal_temperature_range,
>>> +	.is_smc_alive = smu8_is_smc_running,
>>>    };
>>>
>>>    int smu8_init_function_pointers(struct pp_hwmgr *hwmgr) diff --git
>>> a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>> index 4f7f2f455301..790fc387752c 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>> @@ -364,6 +364,7 @@ struct pp_hwmgr_func {
>>>    					bool disable);
>>>    	ssize_t (*get_gpu_metrics)(struct pp_hwmgr *hwmgr, void **table);
>>>    	int (*gfx_state_change)(struct pp_hwmgr *hwmgr, uint32_t state);
>>> +	bool (*is_smc_alive)(struct pp_hwmgr *hwmgr);
>>>    };
>>>
>>>    struct pp_table_func {
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index 8b8feaf7aa0e..27a453fb4db7 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -1845,9 +1845,6 @@ static int smu_set_mp1_state(void *handle,
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->pm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu->ppt_funcs &&
>>>    	    smu->ppt_funcs->set_mp1_state)
>>>    		ret = smu->ppt_funcs->set_mp1_state(smu, mp1_state);
>> @@ -2513,9
>>> +2510,6 @@ static int smu_get_baco_capability(void *handle, bool *cap)
>>>
>>>    	*cap = false;
>>>
>>> -	if (!smu->pm_enabled)
>>> -		return 0;
>>> -
>>>    	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
>>>    		*cap = smu->ppt_funcs->baco_is_support(smu);
>>>
>>> @@ -2527,9 +2521,6 @@ static int smu_baco_set_state(void *handle, int
>> state)
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->pm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (state == 0) {
>>>    		if (smu->ppt_funcs->baco_exit)
>>>    			ret = smu->ppt_funcs->baco_exit(smu); @@ -2551,9
>> +2542,6 @@ bool
>>> smu_mode1_reset_is_support(struct smu_context *smu)
>>>    {
>>>    	bool ret = false;
>>>
>>> -	if (!smu->pm_enabled)
>>> -		return false;
>>> -
>>>    	if (smu->ppt_funcs && smu->ppt_funcs->mode1_reset_is_support)
>>>    		ret = smu->ppt_funcs->mode1_reset_is_support(smu);
>>>
>>> @@ -2564,9 +2552,6 @@ int smu_mode1_reset(struct smu_context *smu)
>>>    {
>>>    	int ret = 0;
>>>
>>> -	if (!smu->pm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu->ppt_funcs->mode1_reset)
>>>    		ret = smu->ppt_funcs->mode1_reset(smu);
>>>
>>> @@ -2578,9 +2563,6 @@ static int smu_mode2_reset(void *handle)
>>>    	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>> -	if (!smu->pm_enabled)
>>> -		return -EOPNOTSUPP;
>>> -
>>>    	if (smu->ppt_funcs->mode2_reset)
>>>    		ret = smu->ppt_funcs->mode2_reset(smu);
>>>
>>> @@ -2712,6 +2694,19 @@ static int smu_get_prv_buffer_details(void
>> *handle, void **addr, size_t *size)
>>>    	return 0;
>>>    }
>>>
>>> +static bool smu_is_smc_alive(void *handle) {
>>> +	struct smu_context *smu = handle;
>>> +
>>> +	if (!smu->ppt_funcs->check_fw_status)
>>> +		return false;
>>> +
>>> +	if (!smu->ppt_funcs->check_fw_status(smu))
>>> +		return true;
>>> +
>>> +	return false;
>>> +}
>>> +
>>>    static const struct amd_pm_funcs swsmu_pm_funcs = {
>>>    	/* export for sysfs */
>>>    	.set_fan_control_mode    = smu_set_fan_control_mode,
>>> @@ -2765,6 +2760,7 @@ static const struct amd_pm_funcs
>> swsmu_pm_funcs = {
>>>    	.get_uclk_dpm_states              = smu_get_uclk_dpm_states,
>>>    	.get_dpm_clock_table              = smu_get_dpm_clock_table,
>>>    	.get_smu_prv_buf_details = smu_get_prv_buffer_details,
>>> +	.is_smc_alive = smu_is_smc_alive,
>>>    };
>>>
>>>    int smu_wait_for_event(struct smu_context *smu, enum
>> smu_event_type
>>> event,
>>>
