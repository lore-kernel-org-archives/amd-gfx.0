Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0DAC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 07:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBBEB10E8D2;
	Tue, 14 Dec 2021 07:59:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F2310E85D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 07:59:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV9DBi2kiKR+8/Azg6GMD3TkmOCPZCwTZMQr+mUZibRVZ6K02ErJL7G7guvKYSGEtVogtfOTygJea/dED5+Y5u5WGa5Rzs8Tr5IX5Pp78xmOC2xfFKddkmml7iCu99T1BuCj3nKJ6Mjfe/+RWn3Q1OlpD//cvlUpcXuQHcRlM9TiOV+0YuLvSdW9/FugcKuDKqwP3ozVrCYYpsDVhVzQKO3BtPbq2ZHxNXTZDEmsbCzAd3M39Jd6XqDoViv1n1YaMdgGMJTqRQFEAvnZqts9Jxi7kLQLsLlvI9NRwyQEy+8mc0+0czJltA8169dmNQyBHCPL0u+g/i/69wt/eHzA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBvqERc7utmOBOn6uC/dHEesRI9xY/GiNyIm/zvmO38=;
 b=B3bRXZ/HTq3mRce+U3+jRgAK5lvfTOuE3bDek3TTiUJe7qS7Ct1vsgGe9syS7mpLRsc3Vq1MpAJioKFLE7/GNdTSkrxMv0IZXf8bX8FZdeGl5QgiHdIT72vLsTKJY0j0XEnpnEowe6ig/hcK4iDb/k+Gi56S+LcuoiQNeON+deE6TODTyaLkfhLe0aaQhhVLHGGpiUI3QM7bWh3IKyiwp2CdVEgrmMQvztc2+bN17WfufdfopSnBssyUiCWN8nzl2Y4gqciXPSdbsvTBwdP+fpMKvK0nCWRN9h5YK8umPm1lT4vjQ9S2FSBfBKWsgV5zgQEeX/jljgpWjPwqM+clLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBvqERc7utmOBOn6uC/dHEesRI9xY/GiNyIm/zvmO38=;
 b=NZqRTEfTq95s4fObEWSV/0p8LUWd1mDjwbvy4zIMebr66L2mY/WEOcD0XP8YTImkK3zG7JF3gf4Pfdejh/wEuC9iaecZaeGZCL/JSrG5Im33lHVL0RshzfP9tPqHWLU5sffm595Hyc7jVOKJjawJzNrulazNALJ/cFkaAcHIWWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Tue, 14 Dec
 2021 07:59:05 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 07:59:05 +0000
Message-ID: <5d620190-459e-f2f9-6678-3df9e1bb6826@amd.com>
Date: Tue, 14 Dec 2021 13:28:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: correct the wrong cached state for GMC on
 PICASSO
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211214013423.801735-1-evan.quan@amd.com>
 <c3d79f6c-b0f1-bc2b-ab80-30a8db11f140@amd.com>
 <DM6PR12MB261917434000F509CAF9DE2FE4759@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB261917434000F509CAF9DE2FE4759@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::28) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4b140f1-d9b5-4276-76d1-08d9bed79954
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40410D8CCD4C26CBC002977E97759@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F66AR00lnwXjwKP0owITXu0ojGX36vlv1CSBomzUvARrROhNOohDuNOvKR3IU5O7N6G34iMBc+JYXdvXjpUU26qU1ONp1wPIRNZqNscZXPAkvjnndB2rQlgVmXbV/m0bXNmpaXj3f56n4ZonFo/qYG3WglREQNH93QFwNMxIhaXkcWcGSpKJWMzRcQ3OxPQyAmjUw8WLm0YVMYEiWbYYPsmifzV+J9W0SDZSZ2HYf9WQvkJZ08YemJwnaWpeuWE8Jnk5pOciK2bCY/8TEUso/1OFmADFCR5uxfUXzzQu3GxWknbfbQfujADXHgzgvJNGPb/qbjEClhO0hEeriIBSymGM9FTJxzEqoOLGZuAlwb1Mj8Wo4Jp9EuOMcF2CYZpgwoG0x3L/2JdbPS6pIcTSQEx6YtGmYmdm1QAz6RwY27YHd9tMKt27euEUH3fIgd2xWfd4jHWRG0q0tpw7JVdCgP4Dmf3euoaagJF8xtj5E8tE36MS5q7Keo6FWWt4RW8G57A7abfBQyF21FbYP2S5wV2k9OgM7FLP4bzclOsknXG9zrMCp85qE08WkKVhj6ocgI80pFGVmGR6hwUEtNHyqQu3sLMxsdy0X1Yr34dWThkqyfu8l2LhS5P1mZU4Mc+2Asj4euSZ8Nrp4hiztDYchxJuP7KLed2T70LsJoHqvYJ1ufoTPSpExeDWPI+A96XyTzUWmE3BZGQF+PdrS7kdSSfQR3PwJeTWID/kaGZFZNBvAd8ffhYWvKd494YB3Fv4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(6512007)(2906002)(38100700002)(6486002)(316002)(966005)(86362001)(31696002)(4326008)(66946007)(31686004)(186003)(6666004)(54906003)(110136005)(6506007)(53546011)(36756003)(508600001)(26005)(66476007)(83380400001)(66556008)(5660300002)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmtGVCtsbEg5cGxMU2lsdGwxbzBJbU96cGp5NEpkTGtjWVVJKzROTzQ1U1Zj?=
 =?utf-8?B?ODRVSjlqd1A0NkVGZksvT21oSjdKN3hoN2E4QXdGZTl0VHRVbVMwcTAreHZ5?=
 =?utf-8?B?bnlFcmVsMnZUSkZzMVByWldNT0VvOHIxazZQZVdvdHB0VHlVSVZVVVVoUnM1?=
 =?utf-8?B?TWpLWHpjelF4eDdJVkZaL2pCMFY0d1hoYys2cDQ4a0h1d3NycVB4bVc5SndX?=
 =?utf-8?B?Qm9xUXBHOHVUUEVoZVUvRVFsUXVBVVJHUzFzVVlEQnBtdlFESUZJYllnQlM0?=
 =?utf-8?B?bXVISjJRcFJJYW1lemE2YlNWSUZJS1pJeDBOWDlUTVMzeXBPdU4wMERGc0dS?=
 =?utf-8?B?b2ZEVVViSjNVWCtIMWZXY1EyQWxSYVpkRXJWR0RIUU5CMCs3aEwxT2NtdFRZ?=
 =?utf-8?B?Zk1GVzNUbWpWK250QWtyK1dZUXZSaWZhbmhRUGs1NkdqMEEzMWVDaFpGbGx3?=
 =?utf-8?B?cVJ6N2VuNlpaS05tLzNWZU1pb3NnaGtuclBkTzJkZ0djREx0QWdFNDAxQ0lB?=
 =?utf-8?B?cWlVSFB0TUQ1SWtxWU9LQkhmdVowK2toOVFPOWFUd1dmem44UkJxRFJyM2NR?=
 =?utf-8?B?RlR2WDQ3Y2d0bzlTRUxJOHdwMjdwOE94WktoOWxJdEF0Q1FNeU5VQ3R5UzJt?=
 =?utf-8?B?NzB0ZG00YWs0Q1F1ZllFRHZISVpEUFpKWFE4R3pkUTdEbVpxeEJBdG5kSmZz?=
 =?utf-8?B?R3RpcitoUzNCQnRmUTVrc0dudThQd2REUHVseUxnM0VPcTl6MG0wMzFiajk0?=
 =?utf-8?B?RzVpVndzN1U2azYxYnJxQnk3WEtsWWVMbzE1cUxhcmViY2pCNWpyanlWSjEw?=
 =?utf-8?B?ZE1MV0NmbGFwc3hWVzBhYmgyV2g4T055MThVWjhGUTlKbm1kbjR2SjZSMGJ6?=
 =?utf-8?B?djNoOU13ekFRSlh6V1diVlV0WUlpakc4OXJUdS90NnczL2RIYlBHUjdjcHEy?=
 =?utf-8?B?WmFvMzFNZTc5MTJ2RzY4cFczdkV6cjZpR0RGaUxtaXZuak0yM3EreEFQZ1Jz?=
 =?utf-8?B?bmpLcmprN1QxeXpnTEVvUkRCbHc5cldqQ2tJUlB1YWdnQmhXd1VJc3dnUjh5?=
 =?utf-8?B?U0pPcFdQTjFOY0V4Z3ZydWo1cnVHdDRoSnFiWHVpMlJiTkZWWUFHYkdEZEF3?=
 =?utf-8?B?b0ZZTVZtakZMRHpEOXI3TDBLa28wMEtmYUtZdWVpRnpodVlZNUgxSURKZEMx?=
 =?utf-8?B?dFYxL1JXVEk3ZjczeW5XSi9iTVRIajk3SU9oZ1BBS2Z2UXpQY2FNR2ZHeFU1?=
 =?utf-8?B?QlREQlhBZjAxWFU5Z0lTSHZLQ2RyVFBGcWdQQWoza2R4c1g5VVpoZkxWdCtS?=
 =?utf-8?B?QW9xQnhiRXViaEdTTGp5Nm13Mjg3dTNaNTBBRkwrUWp2cUlEaE94YVVBbTlW?=
 =?utf-8?B?TE1QVUFGZTIwS1F4SGJMQldKQWU1VXdUUWtYMk9La3BneFFTR1dDVGtKamtt?=
 =?utf-8?B?YUVmWlNFUVl6TVdRYksvcU9YT1ZNcHluT1Jud1BydHlFUDh1ZzdVMU9jVHdC?=
 =?utf-8?B?RXVzOFhYdXlreCthU0NSRHB1M0Nza1hNU3Z2aHpTdnVXL1Iwb3ZWUTJsc2Jw?=
 =?utf-8?B?TVYvcXptUUdqb2FNS05wdjExVy96eExuWDBIVThjV1ZEczdBSjZReUlES3gv?=
 =?utf-8?B?aGtjeE9uMlUzS3B2RkxReGNxT1RBRWp2SGUzUVF4YmIwMFAzR2hoQjAxNUlD?=
 =?utf-8?B?WDFLNFlGb1o1UTF0SEszNDlXSkRhWXdQNEJiQjdpUkVJNFNFT1p1OFFIdmpH?=
 =?utf-8?B?SkRHVWhxWHc0bGJISDhSRzkwL2JIdEhNR0pPL3NObG1Ibyt0RGVTNVZrd3NE?=
 =?utf-8?B?RHR2V3RVWnlOK3JHcjVWRm1IQk5nTGd5WUZxZGJFeml0cjUxUEVrWW1tbHB2?=
 =?utf-8?B?aUVTUGluanNLM0xmZ00vdmcwWE1WM0luck13ZmZuZVI2VG9OTWpiVVpRQTht?=
 =?utf-8?B?RFAwTGd3VEQ0M0FIWGFwUXhiZFFVUWdSYTk3d05lQlVKTVJLSE5WeVRDcCt2?=
 =?utf-8?B?SmlIQTBDa1BCMjZtRDJDWEhVRUJ0M0hneDlHcmluY3BtNzRjVmUrSUtjVDdj?=
 =?utf-8?B?dGZFLzk0bWFna1dqWWV4c2tQbXl2cWFZdFNBVTlOVVBTc3YyY2d4aFptR0tV?=
 =?utf-8?Q?nlJY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b140f1-d9b5-4276-76d1-08d9bed79954
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 07:59:05.3159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ch4ift+U55cK/iI6Tz7vzFrNgPB4hhekE5+bcEmu+PeNCk200vMFMNqgGPIDiBuu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/14/2021 1:16 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, December 14, 2021 2:13 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: correct the wrong cached state for GMC
>> on PICASSO
>>
>>
>>
>> On 12/14/2021 7:04 AM, Evan Quan wrote:
>>> Pair the operations did in GMC ->hw_init and ->hw_fini. That can help
>>> to maintain correct cached state for GMC and avoid unintention gate
>>> operation dropping due to wrong cached state.
>>>
>>> BUG: https://gitlab.freedesktop.org/drm/amd/-/issues/1828
>>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: I9976672a64464b86bb45eed0c25c9599d3bb4c06
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            | 8 ++++++++
>>>    drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c          | 8 ++++----
>>>    drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 7 ++++++-
>>>    3 files changed, 18 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index db2ec84f7237..c7492db3e189 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -1809,6 +1809,14 @@ static int gmc_v9_0_hw_fini(void *handle)
>>>    		return 0;
>>>    	}
>>>
>>> +	/*
>>> +	 * Pair the operations did in gmc_v9_0_hw_init and thus maintain
>>> +	 * a correct cached state for GMC. Otherwise, the "gate" again
>>> +	 * operation on S3 resuming will fail due to wrong cached state.
>>> +	 */
>>> +	if (adev->mmhub.funcs->update_power_gating)
>>> +		adev->mmhub.funcs->update_power_gating(adev, false);
>>> +
>>>    	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
>>>    	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>>> index b3bede1dc41d..1da2ec692057 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>>> @@ -301,10 +301,10 @@ static void
>> mmhub_v1_0_update_power_gating(struct amdgpu_device *adev,
>>>    	if (amdgpu_sriov_vf(adev))
>>>    		return;
>>>
>>> -	if (enable && adev->pg_flags & AMD_PG_SUPPORT_MMHUB) {
>>> -		amdgpu_dpm_set_powergating_by_smu(adev,
>> AMD_IP_BLOCK_TYPE_GMC, true);
>>> -
>>> -	}
>>> +	if (adev->pg_flags & AMD_PG_SUPPORT_MMHUB)
>>> +		amdgpu_dpm_set_powergating_by_smu(adev,
>>> +						  AMD_IP_BLOCK_TYPE_GMC,
>>> +						  enable);
>>>    }
>>>
>>>    static int mmhub_v1_0_gart_enable(struct amdgpu_device *adev) diff
>>> --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> index 3656a77baea4..9953a77cb987 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> @@ -1167,7 +1167,12 @@ static int pp_set_powergating_by_smu(void
>> *handle,
>>>    		pp_dpm_powergate_vce(handle, gate);
>>>    		break;
>>>    	case AMD_IP_BLOCK_TYPE_GMC:
>>> -		pp_dpm_powergate_mmhub(handle);
>>> +		/*
>>> +		 * For now, this is only used on PICASSO.
>>> +		 * And only "gate" operation is supported.
>>> +		 */
>>> +		if (gate)
>>> +			pp_dpm_powergate_mmhub(handle);
>>
>> This is a generic entry point. Would rather keep PG enable or disable
>> supported in mmhub_v1_0 rather than than here. And this comment also
>> should be in mmhub_v1_0.
> [Quan, Evan] pp_dpm_powergate_mmhub is not a generic interface. It's customized for PICASSO which accepts no parameter("bool gate") as other interfaces.
> Thus some comments which explain why the interface is so special are proper I think.
> 

amd_powerplay is the generic entry point and we should avoid ASIC 
specific things as much as possible. Ideally this should be handled in 
mmhub v1/smu10 hwmgr and not here.

Thanks,
Lijo

> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>>    		break;
>>>    	case AMD_IP_BLOCK_TYPE_GFX:
>>>    		ret = pp_dpm_powergate_gfx(handle, gate);
>>>
