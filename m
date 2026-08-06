Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B55C55838
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 07:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3547510F0F9;
	Thu,  6 Aug 2026 07:47:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L08wod/Q";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1820810F0F9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 07:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faQfCF6eWXtsv+1aVEdxOw5eOnevvDYv9HBw5qzAoQ3byIAtC4J/mIA9R7fcfqMTB2cEoqZ+gQKLlRebME5epPD4UeHlOEtjrtcEOq+tZdF0E3c6rBJz95euIUL4g+a9wU6W5CZNBO6QKBSaIV6B4IYmoLHV7P3kd2D0xmlaB2KQwC3DXKA+RO+JMCSlVSz1/uL2kECP+URGyZ1XvCH4hlWxfu8dpgIa9MU4pivaehIYVUBF8LlS/PKh+QAZcgOjoNJOyxOBaJjaxtC8zanEXFucFhSW7SpFUjL9NiCDpO5/stpdu/BF585NnpAnagh6tNZ1dbw8baXUNM2UPmSHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtL4NvOSToH1A6Wixx6u3BS8XU6iyvK5IL3oGIX/jq0=;
 b=sHKMdb96zu6nCu6Jn3nTGrI24YpOeHU7KjttAUx3LqCVKPr+fSXtUN7SN50qQxfE1cfbzv+dAauscVRnOpAD0ZoauqK8+PhLX2ZjAEz4lCgXafzXweXUWrSG5K19rIIqlTPLx8l+hdiguuZ1uGibvpbFHhCp5rDtxId5WSQYoIcqI6iTFZefVwGI1TKc/7+srS5HYoY1JOGEmvsmC0ZnTJnFCqph0CTzKLde9RjLxlLbWtQXk/unMjrPQHfKnu0yS1oYzGwJMk5u9mgszTG9WKIGujlHSrl0gsyqqZiPoihwLOHqKL3y78Wq9noOt7IpxJPALGZnYqPJu4/SdxehSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtL4NvOSToH1A6Wixx6u3BS8XU6iyvK5IL3oGIX/jq0=;
 b=L08wod/QmHMwIIoOA7yrs+HnDoQAFjlU1UEVzK4Y+R5Fui5Sw/MZ8UejBc5vy6OpfASedVqkJ0eLxVxzm7OUh7qyuP3xjTta+ldn5fk4/a9HpWD9fMOYDFIaimgKkhpujiLUmqULzyikoSXXIxZjM4q84anXkaXNaiKKn4zplPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Thu, 6 Aug
 2026 07:47:44 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 07:47:44 +0000
Message-ID: <024580be-2d0c-4ceb-8155-c276c63e0d4c@amd.com>
Date: Thu, 6 Aug 2026 13:17:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Track current PPT limit for restore
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>
References: <20260806061413.3720389-1-lijo.lazar@amd.com>
 <BN9PR12MB52110CD725737790A39A3E8682D22@BN9PR12MB5211.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BN9PR12MB52110CD725737790A39A3E8682D22@BN9PR12MB5211.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4c) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: b30737e3-9e39-428d-0d63-08def38effce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|4143699003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IovzCr1u9Cs8BAlD+ydGqWcLVf9cA2v5PN1kOnm7wjykSam5iPqqQPHtvdYA9ZfvoUbYa3KCSfw/yybTeRIqoIz2DKMXbSVDhAc3W/pdjIOfqwuRmrHQZJSRn/icVd8xumd8BJQW3/XpkOic5bxiLmy0DvIBuzKA2wbeGoZ2YlxV8LRpRnav6CPODjvk1++WwA6fMq9EfufFpNmSFSNLoFCCXineBf1a+v51cTNECuo8M5RJ8jExKbzC+ekPhI9Y3iDF4Xj7YgMQRPeaVPjhoEgU0FboHxv5J7q37+Zl1y1kvzZgXRDX7ojhzmtWNXZ9DD88wF96GvoQDF2K6rbLyhlGoeMtY4WvTbdh94UZW5GMXcwQXFaolBilUukZGEoEnWyDcII3puaVkJEABVXGTsV8h4iZ9KKUgc0vRYoGya9GEAhnivYOxZC/JcmxYlk2L1JFajb5P558dhZ48DEy7PTBN+pJXKGCgc2IbdVYfUDmQbhKg9djWQBX7vFevpfUUWsPSlwXkmf2btTS9RWgg1wJx0jgLSTEmLgJcZzZGTCGrqitIlMi8+qP2m7gfDdl6tYTx+GsmymDurrCzyYt9opq1vy8sHkQAqxuMVwRNcM6aRc1PU80urhzlbY37/bTvrmQJbMOhm8YzDClmTZWsDxbM3pG/L4Rip7rul+Ze/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVFLMHRVeWMxa3ZXbkhBT1k1SC9vTUtER1FoVzcvVFlURW1hR1ExWk9WV0hJ?=
 =?utf-8?B?dHF1RXpVL3lveDQ2cmxJc2xBbWxYMVM0MmNlNTFhQzcwZGxFN0NPaUZ6aVRo?=
 =?utf-8?B?eEJUdzZ3enRMOWJsTzlSc1ZpLzVTZHhpbUZBM1lMMmsvWTByRFVwcXNCQ0pR?=
 =?utf-8?B?TzlUV1pMTE5JdW8yYUhoRzRRZzMvaWxla2xxcXg3OXRYTmhZNjJlRDFkM0RS?=
 =?utf-8?B?ZzgwclJnUzY2dzdhZjEwUXZwZVN2ZGJ1NnVmTytFdDBwaFBrV0l1ejBsdXMw?=
 =?utf-8?B?YU55b2VZejBSSW9nUXNRcjRTOEtmdUp1YWJNaU1sc2JZK05NeXVBZ0t3TGNI?=
 =?utf-8?B?aVI3K255bzJGNStLakpxb0hzTVlnL1M3V2F1bk54TmdqTm5Yd2orRzhSUmxi?=
 =?utf-8?B?aFhYaWlBU0ZhYnByRDViS09GWlkyL1BDZGNlQlI3cE9NL1FKUDR5eE1WTlBT?=
 =?utf-8?B?QlNyK3lsWTNLQVVGRW1mWGE4UGo4NWxXanhhU0pmN2NvcHZ3eGk2enFyMmJZ?=
 =?utf-8?B?dmY1eG1wTGJqZ082NUVhb0dla2g5a1BOQ0d5eWM5enlyOHFLczBPazMyMjZB?=
 =?utf-8?B?WGxxSlZtRi9yYnZGNEpFNkU5bnZ6eVRyMnZScTN6cmxtSkdnUTNLUmIwL2ow?=
 =?utf-8?B?bFhFeVZLNW9pTVdNSWtvMGZWRTVmNWdLbUF4VU9nRDdXZmdobG1IbEZCcHNN?=
 =?utf-8?B?ZEdtMVFybHFyKzg5V0puRld2NVVyc0h5bmMvanpremJxb3JEUTBpbFNjVTA5?=
 =?utf-8?B?Mk9FTUZidDh3UDYwbC9keEJzY0gzb3BHaFNYQTlYOHNwQkZwOWY5dVorZzhN?=
 =?utf-8?B?THpOanN0ZG5kTE5iTVl6RW8wNVV1cWQ4OFl4eEJnNUxlSExDU1FmaEk2NE5P?=
 =?utf-8?B?dUY4OXFIMDVsNzl0U2NsU0FjRkpPRytwcU5VRmxNTE56amdWVzQ0ajNiSmVW?=
 =?utf-8?B?eHZYUi8vUjFvbU1IVnc2QTA0bEdUSDlNTXo2dWNPa0szeTFuRldyZTVmalkw?=
 =?utf-8?B?TDZHVTF0SC9WUWhvNk1SL1pVcGUvcFR0eThReFJlTFF2ekhNL01KaEpOWUsx?=
 =?utf-8?B?djIzV3JkNkNUQURJVnhPWGdhdXJ5ZVpXWFNVT2JKOEJUTkZ5TTNXd2prbE5Y?=
 =?utf-8?B?ZW5BM08yZDBwc2E5azdYb25MNGM5cDU3WUM3NnRTb3NnTVhjcU5aVURuRjY3?=
 =?utf-8?B?ekR1SWpwZHltZlMyK3cwUzNhOTEwVDUyS25aOTMyY2VMSzVtMm15bDZOQWtX?=
 =?utf-8?B?ZVY0NnowckQxWnhTNStaSmJtUkl2UDdJdjhGUER3TWVFNE5kSk5tUFJqa2Zs?=
 =?utf-8?B?R3lYbkErRk5mR2o3bHpHdmg3WWFocUF6eFZBZm9TNUJnQWZ5Vng1TVF3K3Bt?=
 =?utf-8?B?YVFod2lvL01GTnBPRHd1UDFWa2lRNDRPbDNmUUp1bVlPd1JEV3VVT3dQeC9R?=
 =?utf-8?B?NkJDNmVjU2xUZmdrNmswa01kTi9YSmZKaWEyZXdTQzBwTloxc0V6MWlhZnJN?=
 =?utf-8?B?NllLV0NkbE9MZHJFd3Q3dFF5T2VleFlqenBDRHR2dm81N3F0ZHlXOTJISFNr?=
 =?utf-8?B?MDV1dnd0cnh5c3IzUGlPNmpaQmZLMzJFL1dYVXJZQ2RKL2RtQjVwbWVRY25n?=
 =?utf-8?B?WUJYZkVkb0xub2U2Vk43WU9nUWdLYlVyYUNZaEZoRVhJQ0JYRGhiVlJUL2xa?=
 =?utf-8?B?RzhqcEFka0RUekl3OVFkSFNNNU5JMndIdDc3dlU2eTZpRDU2NUlySDJVZlFM?=
 =?utf-8?B?bDNzNStJNHcxTkF2cVh0SXcybmk2bVVqUlJlK0NWbWdXSDBzMGxCRE1kdHVY?=
 =?utf-8?B?YTB1QkRiZUhFVE9jWkVoSGNlOW1USHRkWjFWSkpid1J6eE9HTFBaODJEUmk4?=
 =?utf-8?B?RUlBaUZ0V0dmeW5oZFBLRW9qSldIc1dkWjM4QkphN0ZmMC9FczJRdFhHeEJk?=
 =?utf-8?B?b25GZ2JOeVJGZWdJY2xFazNSZ1hhRzA1aDRzVG9mdVJhVHFDdUJ3QndwQTR0?=
 =?utf-8?B?SGxEUjJIQmlrOElhZXhuMy9FZ21LajRPNSs0anQ5MHQ4WklpSm84eWZMaDhw?=
 =?utf-8?B?ZmkvZng1cDhZdFozdXNGakQ4OHdiMkpUWUdqTW51OElzdGYwU3JPSTNNb29P?=
 =?utf-8?B?dVRSRkNTbEpwQi9NVXJiYzEzSm9sL0lXNXowRzdIaVMyUW4waWg5Qm45dXpC?=
 =?utf-8?B?TmZleG5KMkRTaFBLYTZPQlIrcStoc1FENFhweVFnTHZSSTRCL3kxQ2xhQkd5?=
 =?utf-8?B?NnlpNFl0cEhqb2wxYW96SGNzSWZDcXFQY0N4S1BsSFN5c1lQYkJwOXBBdGhi?=
 =?utf-8?B?S3pPdWY5bENGRllRcEVYUmdGbzlla1duUExhRndmdWpsUERzS1VJUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30737e3-9e39-428d-0d63-08def38effce
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 07:47:44.0271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDAE8c52BWMOtnB7WxQn1KQeSE7Zxmt1ddW1ZJG/hUwTZe7NjgI+Rsh6oR8OFI3r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 06-Aug-26 1:03 PM, Wang, Yang(Kevin) wrote:
> AMD General
> 
> I do not agree with adding a read-to-cache path for the current PPT limit.
> 
> The current limit is PMFW runtime state. A read of that state must remain an observation; it must not implicitly create or update driver-owned persistent policy.
> This separation is intentional: the driver keeps immutable capabilities from the PPTable and restores only limits that it successfully programmed itself.
> 
> Caching a value returned by GetPptLimit would turn a potentially transient or out-of-band PMFW state into a value that the driver replays after suspend or reset.
> 
> There is no ownership, notification, or synchronization mechanism that makes such a cache authoritative, so it can only become stale.
> and the existing user_dpm_profile policy *CACHE ALREADY* handles the supported driver-owned update path.
> 

The existing path also doesn't have any synchronization with 
out-of-band, so the same argument holds. i.e., it overwrites whatever 
set by external source.
> If no bug fix or feature improve, please drop this patch.

Driver triggers resets which could relaod the whole FW. In such cases 
driver remains responsible for restoring the last known power limit. The 
current method doesn't do that.

I will add a bug fix tag as the previous patch doesn't restore the 
current limit properly.

Thanks,
Lijo

> 
> Best Regards,
> Kevin
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, August 6, 2026 2:14 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>;
>> Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
>> Subject: [PATCH] drm/amd/pm: Track current PPT limit for restore
>>
>> Cache the applied PPT limit in the ppt limit range and refresh it on every get
>> and set. Initialize with the default value on fresh load; a value equal to
>> default is treated as unset.
>>
>> On suspend or reset recovery, restore the cached current limit when it differs
>> from the default, falling back to the default otherwise. This replaces the user-
>> mask based restore, covering limits changed outside the user profile path as
>> well.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 39 +++++++++++++----
>> --
>>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
>>   2 files changed, 29 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index f45cd4e31415..7edd919a7832 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -495,16 +495,11 @@ static void smu_restore_ppt_limits(struct
>> smu_context *smu,  {
>>        enum smu_power_src_type power_source;
>>        struct smu_ppt_limit_range *range;
>> -     uint32_t restore_mask;
>>        uint32_t limit;
>>        int i, ret;
>>
>>        power_source = smu->adev->pm.ac_power ?
>>                SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
>> -     restore_mask = smu-
>>> user_dpm_profile.ppt_limit_user_mask[power_source] &
>> -             smu->ppt_limits.supported_mask;
>> -     if (!restore_mask && !restore_defaults)
>> -             return;
>>
>>        smu->user_dpm_profile.flags |=
>> SMU_DPM_USER_PROFILE_RESTORE;
>>
>> @@ -512,14 +507,14 @@ static void smu_restore_ppt_limits(struct
>> smu_context *smu,
>>                if (!(smu->ppt_limits.supported_mask & BIT(i)))
>>                        continue;
>>
>> -             if (restore_mask & BIT(i)) {
>> -                     limit = smu-
>>> user_dpm_profile.ppt_limits[power_source][i];
>> -             } else if (restore_defaults) {
>> -                     range = &smu->ppt_limits.range[power_source][i];
>> +             range = &smu->ppt_limits.range[power_source][i];
>> +             if (range->current_value &&
>> +                 range->current_value != range->default_value)
>> +                     limit = range->current_value;
>> +             else if (restore_defaults)
>>                        limit = range->default_value;
>> -             } else {
>> +             else
>>                        continue;
>> -             }
>>
>>                ret = smu_set_ppt_limit(smu, i, limit);
>>                if (ret)
>> @@ -875,6 +870,21 @@ static int smu_early_init(struct amdgpu_ip_block
>> *ip_block)
>>        return smu_init_microcode(smu);
>>   }
>>
>> +static void smu_init_ppt_limits_current(struct smu_context *smu) {
>> +     struct smu_ppt_limit_range *range;
>> +     int i, j;
>> +
>> +     for (i = SMU_POWER_SOURCE_AC; i < SMU_POWER_SOURCE_COUNT;
>> i++) {
>> +             for (j = SMU_PPT_LIMIT_PPT0; j < SMU_LIMIT_TYPE_COUNT;
>> j++) {
>> +                     if (!(smu->ppt_limits.supported_mask & BIT(j)))
>> +                             continue;
>> +                     range = &smu->ppt_limits.range[i][j];
>> +                     range->current_value = range->default_value;
>> +             }
>> +     }
>> +}
>> +
>>   static int smu_set_default_dpm_table(struct smu_context *smu)  {
>>        struct amdgpu_device *adev = smu->adev; @@ -1911,6 +1921,9 @@
>> static int smu_smc_hw_setup(struct smu_context *smu)
>>        if (ret)
>>                dev_err(adev->dev, "Error during wbrf init call\n");
>>
>> +     if (!adev->in_suspend && !amdgpu_reset_in_recovery(adev))
>> +             smu_init_ppt_limits_current(smu);
>> +
>>        return ret;
>>   }
>>
>> @@ -2999,6 +3012,9 @@ int smu_get_ppt_limit(void *handle,
>>        switch (limit_level) {
>>        case SMU_PPT_LIMIT_CURRENT:
>>                ret = smu_get_asic_ppt_limit(smu, limit_type, limit);
>> +             if (!ret)
>> +                     smu-
>>> ppt_limits.range[power_source][limit_type].current_value =
>> +                             *limit;
>>                break;
>>        case SMU_PPT_LIMIT_DEFAULT:
>>                *limit = smu-
>>> ppt_limits.range[power_source][limit_type].default_value;
>> @@ -3061,6 +3077,7 @@ static int smu_set_ppt_limit(void *handle, uint32_t
>> limit_type, uint32_t limit)
>>        ret = smu->ppt_funcs->set_ppt_limit(smu, limit_type, limit);
>>        if (ret)
>>                return ret;
>> +     range->current_value = limit;
>>        if (!(smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>                smu-
>>> user_dpm_profile.ppt_limits[power_source][limit_type] = limit;
>>                smu->user_dpm_profile.ppt_limit_user_mask[power_source]
>> |= diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> index 92658eb3886d..5222b48eba25 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> @@ -229,6 +229,7 @@ enum smu_ppt_limit_level {
>>
>>   struct smu_ppt_limit_range {
>>        uint32_t default_value;
>> +     uint32_t current_value;
>>        uint32_t min;
>>        uint32_t max;
>>        uint32_t od_min;
>> --
>> 2.49.0
> 

