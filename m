Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BD4C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 08:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B541212A9AB;
	Mon, 10 Jan 2022 08:31:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D430E12A9A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 08:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvPqM4WmOHk1iiA4fhn0ga/A96FDgHpK5JyAm/YbALNFd+xgdNLA/r7mhhXQG4ZaC68oRdyPmz2yPFFsU/6PchBFVzZ3w8tqL1qYSumzO9p+kSj3QlaJj0lIq9nyoDdLiRIGg1kvB9FOpyQH3pde5dW4/1TIWs+0/T104SfUqwxSgzsDBw3vAz6TrWlQXZwjAhhgXw2mM8K6ck0hOQ1Yk4KLMSFmb5J+HQtOd9w+Q+dLb+tPoZmxHrIaK6uWwNDp4uFV35WLgI6/R8h1S0Ba8aOHvCKfTWLCYwRNY81C237nAeVCJNNI85IwCtVBKQcuhn3HECyc+XojsBJNJnMdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6glzmI+bNw1r1y/J68RBYbYSH9li8Czz85CB6ADu3sU=;
 b=kIiyrFOwWgQcme90RbreHfW1PAk3TWq33G6GrdaiXsT9P0cH9R40Z/W5P7F4yoY38GJjU/VEl2QTQzwS2cClfOo/nv+a42i9AxlaTbASjwQlbwowEgWyk46JCohYlT7H9lD0357+nFn9nXLpevoCwKaqiTyUg1dmKofJ3KqK+n9rJ+7k3c/sHFSwqPnyfLpp87SxIIbHgEILu1FwQf1q9sGuyw2p7D8ev/p5YC0oaguOHlZzqtdUAGTASy34DTNH44f/tBc9YAd9bUFtOFvdraiEYvNa74XY9zkOwJgxgu3JZyQFI0V8ep81bPkPsnnwwn0SBZC72aZu3rhhbMM+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6glzmI+bNw1r1y/J68RBYbYSH9li8Czz85CB6ADu3sU=;
 b=HS0w8D4AJGxOEkQrM2HlsVuwsdCw/A5GF7YdEKtl3NCxYShZ0hemxMbw6/Q4CxXgVe5F9OMuw5kIYXyVRoeDkxYZWYKDnvazg/OjmWiqT3+y9hKyChWIOXsbUDJyaE47CSrxUq03xoHYa3TMfoUgHxj5gviHV0leEXpbiP61ZlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB4744.namprd12.prod.outlook.com (2603:10b6:a03:9e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 08:31:15 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%5]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 08:31:15 +0000
Message-ID: <bd2c0fd8-5cc9-fd6b-b091-538f943db640@amd.com>
Date: Mon, 10 Jan 2022 14:01:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: correct the checks for fan attributes support
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220110060042.3159997-1-evan.quan@amd.com>
 <1a71e156-5e04-6d49-53c2-c8ec83e2ce47@amd.com>
 <DM6PR12MB2619C547B8EF3BAA36534AA5E4509@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619C547B8EF3BAA36534AA5E4509@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 277a0e79-7624-492b-12f7-08d9d41390dc
X-MS-TrafficTypeDiagnostic: BYAPR12MB4744:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB47446932D1D9AF788C84EE5A97509@BYAPR12MB4744.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /WrRVj8FANdagGRfQV6KX+MwU+lEGi4s5CP0W6l/dNmeqUd+NimDSlbWsLinW8xjUGWxNHnOjrPAo2jBf38thFFUM3m7A8mS5uF4bs9aZzNmvelDNSbCqb/3b28k3JHaE1LUYJq+ogWUY3D26q1+HwF03FvDFlSs6A8SdMKGZLiXGXZ49LG3EchjiprFftZOUE67pv/DsX0bXuQjePakc9OzMSiXa8oFjdNQZxuXEZ9yGhhvL/prA8fhBl2XNIGqQZ2K02K7fMr+u2ajSpJot15m/WcnAtoTxlvZ+wIM+mjo4Cc7j9efk0fOVOVEPC8V+rEI68CCQ8h74GVErN1itTEO7EdWi2E0gXmhpvpZX50lMoHpi/t3YA1vjD8j0TgGa/ze9WZFzQb6PVYfG2JBCOOLqUPMihTSYlah3m7hxCoczUuzGasw3F9a0DBdnuly7syvnt9wqLWpXc96UelrW8TdKqrFAHxdUk8o3W8zygSEHoiaSLlJz3Jc1Wh3L3PLhmZeWpuS9bpVLpq/V72mn9R3g9hxCPDi64SxyJDfw+iIu/5aZUJYxiZtJFV307kUZl5ns0ab0Vph/WoZ/IAHAlToQ8U76folToDHDvgBjl1qasP1OcOSjUTYNC0B/pzJ3S6H/qn7KqNwn/wc5eU10rxT3yxFWcB0t+rbpHCX5rQR98u+KVbIPD2mfSMoi6ENfH8Qyj/dGP2/IEJh8bNC/ZI53vjyh5feovVp2f7gdFdoRUZN065SIzE2TsbvPKDj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(8936002)(36756003)(4326008)(2616005)(508600001)(31686004)(86362001)(2906002)(8676002)(66946007)(66556008)(6666004)(6486002)(110136005)(66476007)(186003)(31696002)(38100700002)(26005)(53546011)(6506007)(316002)(6512007)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWFoSTlnRit1L2wxRTdET2JTVXJYbWlCNloxRmRIdW1tOFFJOGRtcVVkdkV2?=
 =?utf-8?B?aG1IQ2lRYTlaZzZJeUp5WEdRdUg1VmJJbEYrRjhTbENLeHlCcHVheW9JVEJ1?=
 =?utf-8?B?WWpHbTgvODZNcU9pb2xPY0RBMHJUWU1WUDUvRUh5ZG91QWl5a0JCUDVmN3NR?=
 =?utf-8?B?Nm83WGlHUUwzNVlPY0FYZGdNeUp4ZUZRMzE5RnpLaHdVaFFzVFJDVXc4R1FQ?=
 =?utf-8?B?QklrTStZd0x0L3lUclUyZlhVTTJPTi94T2FpR0c2WENEZmt1d0hxa1Z4ajZL?=
 =?utf-8?B?SG5udUF4VU9yMU0rZnFQVnN4eVlBVmp6ZkNvL1NRa20wSjdETVl1N3E2VGJp?=
 =?utf-8?B?S3B6dmFpWUN3Y1J1d2VFOEppMXRBWDZ6N2dpQ2MrNTZmSllXVmJTTkNvZDdF?=
 =?utf-8?B?TTZrZHl3SVZnRTNLL0l5ZTU5ZHp3MVhwRXRzWS9BWjgxS1d5RjRpZzByYjdq?=
 =?utf-8?B?NU15R1J2eDJ6YTN6dERyQmhWU3pHMENrMWZ4UXdVcnp4Z2c5ZUZCWHJ0LytL?=
 =?utf-8?B?RFhGREhKWHBRSDJqemdHVGxpR1I5RGFIQUlZWDh1MWRlOTAxaEdWM2tpL3NJ?=
 =?utf-8?B?OG51Z0tuaXFmODBSelJEcGEvZjdIV1VhQmpYNlU3YXFTQ1Y0aE45MUlxTDIr?=
 =?utf-8?B?bUVqMkRlQ2hxVGZWeHk1cUNJa0tPQkc5Y05TNW5kWnBNeE9VVFA3V2U4NGhP?=
 =?utf-8?B?T21ZU0luYnl5K3Zoa2VWVE8zNjNiOVhxc3VtMjhIZWJLLytGeHNtQXp5c1ZH?=
 =?utf-8?B?K3BBUVNCZ0Vta1AwYWhuYnpOeGl4U0J6RndnTy9talBaRlAzY2FTdmJoczdZ?=
 =?utf-8?B?T2V3d2N6ZnY0YUY3eUREczNYQnVoWlV0aVAzVGEyaUt4VHBYcUFmQW9rcEUx?=
 =?utf-8?B?NldmOSttQkMwcHhtaVRBNHBPd3llWjF3NVp6WHIxeDRmcERJS3JDbWhHUFVo?=
 =?utf-8?B?d1h5ZTRvOGNuRFlzb25sKzkvbE1rUFMrK3ZISTRrUnRkUE42cHA0aFc4RDBQ?=
 =?utf-8?B?Vk5nejBsc0ord2IyQ3RXNGRLeUxSLzFjTnFQOHA3MzdFWXJFU2VqYUtZNkNq?=
 =?utf-8?B?Z0JzUjJhVFRlSmhDU01NQWYrdXF6YkxOYTZPN1FVaEtVYlpNS21VMmRUN2ND?=
 =?utf-8?B?MDA1UlN5QlI4cnZ1VTZGS3VuVCsrSVZWYW1SRjRXS0lKTW1PSjlRM0NBYllR?=
 =?utf-8?B?a096MFJ1eU83eTNiSUhGNEZVNnNNY0tkTTNRTmg3dDZTdFpqY1czK093TzdF?=
 =?utf-8?B?UHJWRjRUajdqbXRrQjZhLzhyd0k1WVJuMXVDSFFnRWhVN2ZydDk4UWdBcUUr?=
 =?utf-8?B?YXMzU2FqRFBGWjJ2TEZ0MkQ3VUFrbDdScTYvV0dOcGdBbWZSYTY2bGFKcGlt?=
 =?utf-8?B?RXJUcCs2ckVWTE9iTWh1NmJ4NzY4Yk1GM29naHlrc3ZHYXlCdTBBOG5UYlE1?=
 =?utf-8?B?Y2tpc3FqY3pJejd2R0t5YzdOS3hMWGVPcUdsY0RqcXRqOGRmWmlkdUIyd0VO?=
 =?utf-8?B?K0NkTlQ2N0RWVVlpcmZ3YmRGVVdjSHJJNW1PUjRWemtDL1RKeXlCMVVSdzlS?=
 =?utf-8?B?U0x6MkE3d0p2TGNMUnB4THRLS1pndHYxM1RFZ0N6eVZuYk5rTDFPcE03T3Bq?=
 =?utf-8?B?M1o2RCs2Y2xpMCtGUG1RaFc2Y2RVRitMNDFvYTQ2NUlkZUF2YmhLYys1TkpW?=
 =?utf-8?B?TFlrazgzVndBRHZKanZEN0xpenY0K1FpVW5YMm0rUHpLZzg4eFFNRU5qN3oz?=
 =?utf-8?B?MXVwZFNRNk1YY0FtMWxMQ21Dc2xFc1l4QXd4MFNORFdnb3RtSGwyR3dNVVBn?=
 =?utf-8?B?TmN5RnFVZ3p4cDA1RzBwdlhnMFJkeUJKV1NmbWkxZ2RzZWJZeWhsK2IrcW5y?=
 =?utf-8?B?R2JwWWRjVFAzc2svWGc3R3g0VmJDZlRLZVVMaGhCdlB5QzNSQkozTWVYb3lW?=
 =?utf-8?B?L0VzQXVRYUh2ZkdLSVFQbllXNGQxQnIzRjdqTTBKYWxjb1NtRmJSTlZHaXhZ?=
 =?utf-8?B?d0ZTdktmMitnekJqdGxiYmh2SXcwR01hUjJkSll4VzR4UmNXa2JiUTBtUFJ5?=
 =?utf-8?B?TnNqM0hCQ09LNUZpL2NRSlU5VkQ0cmhIZnI5Y3JrUVlZUWRaVTVmYUxVU0gy?=
 =?utf-8?Q?oW2M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277a0e79-7624-492b-12f7-08d9d41390dc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 08:31:15.3819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkJsD8m5f7gZUolok4HirDtWNoPuHwrigiMHFlNV7Fu2+Op75muoPHvcOVKz1EBw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4744
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/10/2022 1:25 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, January 10, 2022 3:36 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: correct the checks for fan attributes
>> support
>>
>>
>>
>> On 1/10/2022 11:30 AM, Evan Quan wrote:
>>> Before we relied on the return values from the corresponding interfaces.
>>> That is with low efficiency. And the wrong intermediate variable used
>>> makes the fan mode stuck at manual mode which then causes overheating
>> in
>>> 3D graphics tests.
>>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: Ia93ccf3b929c12e6d10b50c8f3596783ac63f0e3
>>> ---
>>>    drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 23
>> +++++++++++++++++++++++
>>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 20 ++++++++++----------
>>>    drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 12 ++++++++++++
>>>    3 files changed, 45 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> index 68d2e80a673b..e732418a9558 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> @@ -1547,3 +1547,26 @@ int amdgpu_dpm_get_dpm_clock_table(struct
>> amdgpu_device *adev,
>>>
>>>    	return ret;
>>>    }
>>> +
>>> +int amdgpu_dpm_is_fan_operation_supported(struct amdgpu_device
>> *adev,
>>> +					  enum fan_operation_id id)
>>> +{
>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +
>>> +	switch (id) {
>>> +	case FAN_CONTROL_MODE_RETRIEVING:
>>> +		return pp_funcs->get_fan_control_mode ? 1 : 0;
>>> +	case FAN_CONTROL_MODE_SETTING:
>>> +		return pp_funcs->set_fan_control_mode ? 1 : 0;
>>> +	case FAN_SPEED_PWM_RETRIEVING:
>>> +		return pp_funcs->get_fan_speed_pwm ? 1 : 0;
>>> +	case FAN_SPEED_PWM_SETTING:
>>> +		return pp_funcs->set_fan_speed_pwm ? 1 : 0;
>>> +	case FAN_SPEED_RPM_RETRIEVING:
>>> +		return pp_funcs->get_fan_speed_rpm ? 1 : 0;
>>> +	case FAN_SPEED_RPM_SETTING:
>>> +		return pp_funcs->set_fan_speed_rpm ? 1 : 0;
>>> +	default:
>>> +		return 0;
>>> +	}
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> index d3eab245e0fe..57721750c51a 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> @@ -3263,15 +3263,15 @@ static umode_t
>> hwmon_attributes_visible(struct kobject *kobj,
>>>    		return 0;
>>>
>>>    	/* mask fan attributes if we have no bindings for this asic to expose
>> */
>>> -	if (((amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL)
>> &&
>>> +	if ((!amdgpu_dpm_is_fan_operation_supported(adev,
>> FAN_SPEED_PWM_RETRIEVING) &&
>>
>> As per the current logic, it's really checking the hardware registers.
> [Quan, Evan] I probably should mention the "current" version you see now is actually a regression introduced by the commit below:
> 801771de0331 drm/amd/pm: do not expose power implementation details to amdgpu_pm.c
> 
> The very early version(which works good) is something like below:
> -       if (!is_support_sw_smu(adev)) {
> -               /* mask fan attributes if we have no bindings for this asic to expose */
> -               if ((!adev->powerplay.pp_funcs->get_fan_speed_pwm &&
> -                    attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't query fan */
> -                   (!adev->powerplay.pp_funcs->get_fan_control_mode &&
> -                    attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't query state */
> -                       effective_mode &= ~S_IRUGO;
> 
> So, the changes here are really just back to old working version. It aims to provide a quick fix for the failures reported by CQE.

I see. Could you model on it based on below one? This is preferrable 
rather than introducing new API.

drm/amdgpu/pm: Don't show pp_power_profile_mode for unsupported devices.

Thanks,
Lijo

>> For ex: we could have some SKUs that have PMFW based fan control and for
>> some other SKUs, AIBs could be having a different cooling solution which
>> doesn't make use of PMFW.
>>
>>
>>>    	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't query
>> fan */
>>> -	    ((amdgpu_dpm_get_fan_control_mode(adev, &speed) == -
>> EOPNOTSUPP) &&
>>> +	    (!amdgpu_dpm_is_fan_operation_supported(adev,
>> FAN_CONTROL_MODE_RETRIEVING) &&
>>>    	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't
>> query state */
>>>    		effective_mode &= ~S_IRUGO;
>>>
>>> -	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL)
>> &&
>>> +	if ((!amdgpu_dpm_is_fan_operation_supported(adev,
>> FAN_SPEED_PWM_SETTING) &&
>>>    	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't
>> manage fan */
>>> -	      ((amdgpu_dpm_set_fan_control_mode(adev, speed) == -
>> EOPNOTSUPP) &&
>>> +	    (!amdgpu_dpm_is_fan_operation_supported(adev,
>> FAN_CONTROL_MODE_SETTING) &&
>>>    	      attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't
>> manage state */
>>>    		effective_mode &= ~S_IWUSR;
>>>
>>> @@ -3291,16 +3291,16 @@ static umode_t
>> hwmon_attributes_visible(struct kobject *kobj,
>>>    		return 0;
>>>
>>>    	/* hide max/min values if we can't both query and manage the fan */
>>> -	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL)
>> &&
>>> -	      (amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL)
>> &&
>>> -	      (amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL)
>> &&
>>> -	      (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL))
>> &&
>>> +	if ((!amdgpu_dpm_is_fan_operation_supported(adev,
>> FAN_SPEED_PWM_SETTING) &&
>>> +	     !amdgpu_dpm_is_fan_operation_supported(adev,
>> FAN_SPEED_PWM_RETRIEVING) &&
>>> +	     !amdgpu_dpm_is_fan_operation_supported(adev,
>> FAN_SPEED_RPM_SETTING) &&
>>> +	     !amdgpu_dpm_is_fan_operation_supported(adev,
>> FAN_SPEED_RPM_RETRIEVING)) &&
>>
>> If this is the case, I think we should set pm.no_fan since nothing is
>> possible.
> [Quan, Evan] Yep, I agree a more optimized version should be something like that.
> Let's take this a quick solution and do further optimizations later.
> 
> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>>    	    (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
>>>    	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr))
>>>    		return 0;
>>>
>>> -	if ((amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL)
>> &&
>>> -	     (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL)
>> &&
>>> +	if ((!amdgpu_dpm_is_fan_operation_supported(adev,
>> FAN_SPEED_RPM_SETTING) &&
>>> +	     !amdgpu_dpm_is_fan_operation_supported(adev,
>> FAN_SPEED_RPM_RETRIEVING)) &&
>>>    	     (attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
>>>    	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr))
>>>    		return 0;
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> index ba857ca75392..9e18151a3c46 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> @@ -330,6 +330,16 @@ struct amdgpu_pm {
>>>    	bool			pp_force_state_enabled;
>>>    };
>>>
>>> +enum fan_operation_id
>>> +{
>>> +	FAN_CONTROL_MODE_RETRIEVING = 0,
>>> +	FAN_CONTROL_MODE_SETTING    = 1,
>>> +	FAN_SPEED_PWM_RETRIEVING    = 2,
>>> +	FAN_SPEED_PWM_SETTING       = 3,
>>> +	FAN_SPEED_RPM_RETRIEVING    = 4,
>>> +	FAN_SPEED_RPM_SETTING       = 5,
>>> +};
>>> +
>>>    u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
>>>    int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum
>> amd_pp_sensors sensor,
>>>    			   void *data, uint32_t *size);
>>> @@ -510,4 +520,6 @@ enum pp_smu_status
>> amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
>>>    						  unsigned int *num_states);
>>>    int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
>>>    				   struct dpm_clocks *clock_table);
>>> +int amdgpu_dpm_is_fan_operation_supported(struct amdgpu_device
>> *adev,
>>> +					  enum fan_operation_id id);
>>>    #endif
>>>
