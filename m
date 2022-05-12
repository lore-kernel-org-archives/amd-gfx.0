Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A541C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 12:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0341310EA69;
	Thu, 12 May 2022 12:16:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83DD10EA69
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 12:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbgrMZ0XLU4bntPG+fbe7B73KLdIPI+QgvG4bcxSyG5Zi+BiJdhJJQRoKPIHPpXaOlX+Ip7d9Ad1kT19azGLKhmS6eI90f69G34pWcy23EsOmUNyTvVRYvM1/ptGh97BXKTWCqOAwvy7GHfpHrWc0Qy8BZkSyOUaqmr3SudYN2Kwco3CASZbKfgYvGjhOeb9EkOszmz11Tfz/dF5hNwjUIqT20dOGTOyNmTC5t2m7lRU9dzsa9SVZIRNpIKswYHRZoysAflQARvSxqNjr7Te/PJjYxJyamx57dvThzo9pTe+pjXasr8ipSN3V91OnzrgxrQqlLnO9jcZ7nWh1VE3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTe4+QANwjAGqlusdzh6Z8ZtWKPMNIWOIb2AYOyw/Ig=;
 b=FKYMtr9QAlxgFt8HJhxrht4E8tnhZuRB0H0WLQ/n2RoH5RFbm6FP+nQRR9TJ8wNxjjwGPxyKxHeyCimuNTopPCaSyg8jRcBQBrVqDdElfT1Uq2Zhnnp/tWIAFEvUMjVlPaK6fVgWdg+q+1FSEXsmskBsYXvCMyAKGzuVWEGrwRikYf+7gL6URcc6Q6+gFFRC4P5zwhV9gTOstfgE8dbwmDI/+E8YeFjPnhln1U7k8ulx8fzSq+31xFVczQM7EjxVfHWMA5lOGi6bSy5jkKb8krZ5XoW/3/uij7lyHmkBG3a5T9hkzXT1BSCFCWzzBcOAYRPmg6z3Eew3MZ7zC7VoPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTe4+QANwjAGqlusdzh6Z8ZtWKPMNIWOIb2AYOyw/Ig=;
 b=x8I/GvUlbYtV5YKirW5qp6a2ujSmd0P5ZLteaynumDZM/q8RW66NNxaWXBGhd5JFGKiccVJu4SumJDjMNmdfrdc2pweVUtvrvabQZHj4xHyXk0F/b0ubFbk9poVZ+vYz4gMjlMnICBhkt9uCa5AMXYAXuGsPbeRCF3E3e/AiXFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN8PR12MB2868.namprd12.prod.outlook.com (2603:10b6:408:9c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 12:16:11 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 12:16:11 +0000
Message-ID: <d3e7247b-c6e8-608d-bb92-56af850a3685@amd.com>
Date: Thu, 12 May 2022 17:46:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] drm/amd/pm: consistent approach for smartshift
Content-Language: en-US
To: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220512105652.3520817-1-sathishkumar.sundararaju@amd.com>
 <ee8d602e-ba20-e0d2-db20-603c65f4fa76@amd.com>
 <8d16aed9-02c3-ec5c-df2e-5be05615797d@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <8d16aed9-02c3-ec5c-df2e-5be05615797d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::13) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd9d9786-fdae-49b4-aae5-08da341133ad
X-MS-TrafficTypeDiagnostic: BN8PR12MB2868:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2868E969444215E3BEFB954097CB9@BN8PR12MB2868.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22PxcSzgSBajR44d2GZaJXZrAYsDKjuGZ1n+35oqnTKgi1IgMWOtSNapOq3eTI+nr6kRsH6VCwmRgZIyzoLbi7L1pQVuEnoXMkT8tdBFe7Wlnz+cunem9XDtbyqXdLaK6VQ4V9GuwRbyIpTNtJyIDdFbYfEwgph8UNAUIHQbcUwAjZL1046WnDoQNpvs6Q7fiZ547YRXCbYBGflDAnPIDdHeMm0Kw/5ywFKcJRnpmBLQ4KkqQKfmOw9gX6LCIT15x30oAfimDqBCgWJUwo57Zqm7ynBs3ln1fcJmoERndbpe5lJBnwIqpo9oHhOGPfIuP8r1f9q0zbzUU03cyxs8YEMQcX1kee4Jot1U6lN+fo7ufz78LF+bm83BaV5EVp8cSDS7DojxXVDVa3bV+fvIvYtrL4V7bYiqHRJjzB/2VARQfFXkBkk4QG/kgCPrYC+KqHcWj/15+Y+acylNISqwcd9fQ7AcB2j7pBFQBIpZhw/xRgXJ9+bshz0HZKcKrNX4fl+r23jf/dMxhQIitGNcCprgL4jFgcw1W4k7XdQ3aQEDvbvK1C2xTPK/MZBUMfEGlciz61zLfWrhwqZUipqy8ZgPD6mCI6Ncpx7KY0JIKldBBLO29vim0xLuqKGHFxcDGHbvVfri3vHHEUgg275vKPggdCdzLmhC1yikc/Nljrl5pSyhbQIxmlshm09Jr5dl/Kpe5TVhSl7HAH2FJ+ZA6iCdI3UaDNkbjXXhXPRNS1AvvNbfjmF/flXbUk5wilHe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(26005)(2616005)(38100700002)(508600001)(36756003)(8676002)(4326008)(31686004)(186003)(316002)(66476007)(66946007)(66556008)(5660300002)(2906002)(6666004)(53546011)(6506007)(31696002)(86362001)(6486002)(8936002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDQyc0s2USs3SXNoMy9PTVdWNGliVUM4N2JZd1hFZ2paN2FPajRCLzJ1b05I?=
 =?utf-8?B?NGFlYldqbzRqZWNBeGxwVTVLVENwTzRzd2VyZ0FBa1lsTzFMaXFkblVoU1RQ?=
 =?utf-8?B?K01XU1NkSjA2NU5zUnZLYkYvL3ZBNk4vU1lpNEVDNGIzNXFpNjFyVnlINjFH?=
 =?utf-8?B?OWk2cnZNWldVUGV4dndZVDAybTg0US9OZmpPSVBLeHlmMjkrS0pkcG5uWEt4?=
 =?utf-8?B?Tk9Wd0JQbjdxdkNnSzMvcGxDZW90TzZSeEh2UW1DTHBYeklBcW9jZFYwdVhn?=
 =?utf-8?B?eHNYVW96TlRCQjA4VHYyTWpUZFNXdzFzUnd2Sm9GeE5PbERzOERaVVRSMkFz?=
 =?utf-8?B?THQvbVpaNUhld0NueEhTVG95TVBQUXRKYnRYcy9JOUlUcmR0ZHhIdVJpMGdQ?=
 =?utf-8?B?OTBEQzJna2d4QXVyTXpIYjBOSnQvS0ozZ012bmU5Um80ZW95c0VKaG8vTzV5?=
 =?utf-8?B?TCtaRy84VHBWWlFkTTZsWmlCV3NEem52VjBDa0QvWjNjNWp1RzFDa21haUJU?=
 =?utf-8?B?WDJZL085a3ZPdlJnNnc5YzNLeXA2aVdmVUVYc2dnU0NMN1M1eUwxVVJFYjl5?=
 =?utf-8?B?NWkyclVycHRWczl0UmxMbk12c090QytpMmtIVHJjQUFxUGp2RXJ0blJPUTZ5?=
 =?utf-8?B?RjVZMk16R2E3TTBEZHlMTTNqRi83d3hYenMrN1VicWh5M256VFYxSXlEYVZx?=
 =?utf-8?B?MERlT1dFUWdma0JaYTV0YlhENVJoU2FPZk9sYXBuVVUzSlkxTW9KOTRWblBR?=
 =?utf-8?B?ZzNyKy81V1YycXYwUmg3TzZOdG9nc0dyZzNab3JtM2xSajhxYzR6V2NSUGth?=
 =?utf-8?B?cUw2Y1RGZ3IvajFrcHFqK2RxTnBoK0RwNUczY0hYUlNvL1dwdDNVTFh3QUky?=
 =?utf-8?B?WGtZUUp0VFdJZFloL08vOXhCSitCRVlrRzhBbTNDdGt5M1BMM2VKM3d3cEt1?=
 =?utf-8?B?R0VGbFdMUHVDZWh0bHdoOW52MVlZSHQ5cmNpdi9iSnBxc0trN3ZwT3NNNzhk?=
 =?utf-8?B?Qk5pVTI5SFZjSVFTK0NveWZNN000SFY1KzJmbWk5NG1MRUR3dUtmOThXbmtX?=
 =?utf-8?B?b2VxbWhEUXlxTEtNcFE4NlRjZ3E2WWdzaWhBZndmaTdVa2lvSnFUUXhYZzBU?=
 =?utf-8?B?aTJrdWFUUEhteEJvdUw3N0ZiWjd4b1hjYWhqK3B5eGNxaFI3Z2hTUkh3aHZH?=
 =?utf-8?B?enJLc0hQUE9iekEwTHBTa2xnVXBCOWxNZzNiM2NMNXJ2cHJoM1drN3Z3bERJ?=
 =?utf-8?B?UXlUNkRhc0RrdHFQVldEUmxrUjZMYUFrdmh1bkljWmpaMzU5NlNRMjZnQkJS?=
 =?utf-8?B?QkI0bFhRbmdwd2I0SW9Zd05GQlQwYkh3ZWg3QktiV2RrVHczTG9wSW1IcnM1?=
 =?utf-8?B?b2lybXVhdGFKZWNPTGZvbnlld3VoNEZlUkIvZitadWkrOWtQRndSMlFuVE5Y?=
 =?utf-8?B?VlVac09HM0UrVW0wWC8vNkxoYi9yVlptbjJvNTBRWFJBdUEzYjZQNkFxcnlh?=
 =?utf-8?B?MWVXY3FjQjdWUjRrREFlV2o0VCtQb1U2MXhwTjlEN2Z3SWtybGZJMW1lenB5?=
 =?utf-8?B?dDYvY1JwbXZKdmx6V3dkSzN0TVNhVkhDOXN0NUNMNmFyN3BNMlYvdm1kQnVZ?=
 =?utf-8?B?Q2g2TWxETVBadnhHRUVZODhpV0c4V2VaTVNEVjhSemtIN3kxdEtiK05hWFZL?=
 =?utf-8?B?T2pBaXRHQUtqWlRPdlhZSFFUa0x0Z1I2UE9MUVR6WDIrNmtYRWFWZXVyS3VU?=
 =?utf-8?B?Zk5yNXp3M3hDdEJxV0NkZXRXdkJyWHZwb3VLV1BiYTRMRUdUbmZxa0pwdDhB?=
 =?utf-8?B?TysvZTI4bkpTTkdrek9CTXduSmsvMndraVFnOFdYK3JVNE5hbkJKVTRKc1BL?=
 =?utf-8?B?NGpxQUJKZy83UCtrRHR2b1p2RjFuK2xqdmJBMzErWFlmeEFJUFRhaWR6MTlG?=
 =?utf-8?B?Vy9zM2d6VlVVRDYvdjZwWHUwNFEyRTNjcXhCMjhvcGdTbVcwb0xhWEJrZnhV?=
 =?utf-8?B?cEl5OGN4S2gwL21KTy9QMWE4R0dDVUVHRnRtL3h6L0dWVzRFcGcycTFwajhk?=
 =?utf-8?B?TkplU3BTdlc5SXprREdhZ2lSRVFZUEN6eGNsTW1MMmhDOEJ4dENFUEpCekJq?=
 =?utf-8?B?eU1XdFR0QXZ4NEJhTUxYTExidEc4OWlWYXJEMjQzMmkwa3Ezc3RxOUlZbjN0?=
 =?utf-8?B?cUVsSVBKZlFZV25sS0FVU1pDS0lmOVdPd3BTNGpaU09JSE9wSkNwbjVSZzVq?=
 =?utf-8?B?eEJobjBtUGlUTlJzUUdYVzFrdDcyRnhjSFgyZS9oeWtWMDVtTjg0ekEvUjZm?=
 =?utf-8?B?WktKdWtndWZsQzNhaVRScjFLVWJHcjlpL0M5MUplY1hpLzR4VWczdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9d9786-fdae-49b4-aae5-08da341133ad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 12:16:11.6204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYx9mWQ4yX68FxptmAr6jkyebdOuR4ERBXSG1T24O6tZ4RmHGN30qHIWiq1FGHxh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2868
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/12/2022 5:42 PM, Sundararaju, Sathishkumar wrote:
> 
> On 5/12/2022 4:37 PM, Lazar, Lijo wrote:
>>
>>
>> On 5/12/2022 4:26 PM, Sathishkumar S wrote:
>>> create smartshift sysfs attributes from dGPU device even
>>> on smartshift 1.0 platform to be consistent. Do not populate
>>> the attributes on platforms that have APU only but not dGPU
>>> or vice versa.
>>>
>>> V2: avoid checking for the number of VGA/DISPLAY devices (Lijo)
>>>
>>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 136 ++++++++++++++++-------------
>>>   1 file changed, 74 insertions(+), 62 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c 
>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> index d3228216b2da..292e8c241597 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> @@ -1734,22 +1734,11 @@ static ssize_t amdgpu_get_gpu_metrics(struct 
>>> device *dev,
>>>       return size;
>>>   }
>>>   -/**
>>> - * DOC: smartshift_apu_power
>>> - *
>>> - * The amdgpu driver provides a sysfs API for reporting APU power
>>> - * share if it supports smartshift. The value is expressed as
>>> - * the proportion of stapm limit where stapm limit is the total APU
>>> - * power limit. The result is in percentage. If APU power is 130% of
>>> - * STAPM, then APU is using 30% of the dGPU's headroom.
>>> - */
>>> -
>>> -static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, 
>>> struct device_attribute *attr,
>>> -                           char *buf)
>>> +static int amdgpu_read_powershift_percent(struct amdgpu_device *adev,
>>> +                        uint32_t *ss_power, bool dgpu_share)
>>>   {
>>> -    struct drm_device *ddev = dev_get_drvdata(dev);
>>> -    struct amdgpu_device *adev = drm_to_adev(ddev);
>>> -    uint32_t ss_power, size;
>>> +    struct drm_device *ddev = adev_to_drm(adev);
>>> +    uint32_t size;
>>>       int r = 0;
>>>         if (amdgpu_in_reset(adev))
>>> @@ -1763,28 +1752,65 @@ static ssize_t 
>>> amdgpu_get_smartshift_apu_power(struct device *dev, struct device
>>>           return r;
>>>       }
>>>   -    r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
>>> -                   (void *)&ss_power, &size);
>>> -    if (r)
>>> -        goto out;
>>> -
>>> -    r = sysfs_emit(buf, "%u%%\n", ss_power);
>>> +    if (dgpu_share)
>>> +        r = amdgpu_dpm_read_sensor(adev, 
>>> AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
>>> +                   (void *)ss_power, &size);
>>> +    else
>>> +        r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
>>> +                   (void *)ss_power, &size);
>>>   -out:
>>>       pm_runtime_mark_last_busy(ddev->dev);
>>>       pm_runtime_put_autosuspend(ddev->dev);
>>>       return r;
>>>   }
>>> +/**
>>> + * DOC: smartshift_apu_power
>>> + *
>>> + * The amdgpu driver provides a sysfs API for reporting APU power
>>> + * shift in percentage if platform supports smartshift. Value 0 
>>> means that
>>> + * there is no powershift and values between [1-100] means that the 
>>> power
>>> + * is shifted to APU, the percentage of boost is with respect to APU 
>>> power
>>> + * limit on the platform.
>>> + */
>>> +
>>> +static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, 
>>> struct device_attribute *attr,
>>> +                           char *buf)
>>> +{
>>> +    struct drm_device *ddev = dev_get_drvdata(dev);
>>> +    struct amdgpu_device *adev = drm_to_adev(ddev);
>>> +    uint32_t ss_power = 0;
>>> +    int r = 0, i;
>>> +
>>> +    r = amdgpu_read_powershift_percent(adev, &ss_power, false);
>>> +    if (r == -EOPNOTSUPP) {
>>> +        /* sensor not available on dGPU, try to read from APU */
>>> +        adev = NULL;
>>> +        mutex_lock(&mgpu_info.mutex);
>>> +        for (i = 0; i < mgpu_info.num_gpu; i++) {
>>> +            if (mgpu_info.gpu_ins[i].adev->flags & AMD_IS_APU) {
>>> +                adev = mgpu_info.gpu_ins[i].adev;
>>> +                break;
>>> +            }
>>> +        }
>>> +        mutex_unlock(&mgpu_info.mutex);
>>> +        if (adev)
>>> +            r = amdgpu_read_powershift_percent(adev, &ss_power, false);
>>> +    }
>>> +
>>> +    if (!r)
>>> +        r = sysfs_emit(buf, "%u%%\n", ss_power);
>>> +
>>
>> In v1 patch comment, I meant something like this
>>     return amdgpu_show_powershift_percent(adev, false);
>>
>> And the above logic is kept in amdgpu_show_powershift_percent();
>>
>> amdgpu_get_smartshift_dgpu_power():
>> return amdgpu_show_powershift_percent(adev, true);
> 
> okay got it, will do that. But will retain 
> amdgpu_read_powershift_percent() as a separate function or rename it to 
> amdgpu_device_read_powershift().
> 
> I hope you also didn't mean to combine them all into 
> amdgpu_show_powershift_percent().

No, I didn't mean to combine all of them. Only the above logic (fetching 
from dGPU, if not fetch from APU) may be kept in a single function. It's 
the same for any device regardless of dGPU or APU.

Thanks,
Lijo

> 
>>
>> Thanks,
>> Lijo
>>
>>> +    return r;
>>> +}
>>>     /**
>>>    * DOC: smartshift_dgpu_power
>>>    *
>>> - * The amdgpu driver provides a sysfs API for reporting the dGPU power
>>> - * share if the device is in HG and supports smartshift. The value
>>> - * is expressed as the proportion of stapm limit where stapm limit
>>> - * is the total APU power limit. The value is in percentage. If dGPU
>>> - * power is 20% higher than STAPM power(120%), it's using 20% of the
>>> - * APU's power headroom.
>>> + * The amdgpu driver provides a sysfs API for reporting dGPU power
>>> + * shift in percentage if platform supports smartshift. Value 0 
>>> means that
>>> + * there is no powershift and values between [1-100] means that the 
>>> power is
>>> + * shifted to dGPU, the percentage of boost is with respect to dGPU 
>>> power
>>> + * limit on the platform.
>>>    */
>>>     static ssize_t amdgpu_get_smartshift_dgpu_power(struct device 
>>> *dev, struct device_attribute *attr,
>>> @@ -1792,31 +1818,28 @@ static ssize_t 
>>> amdgpu_get_smartshift_dgpu_power(struct device *dev, struct devic
>>>   {
>>>       struct drm_device *ddev = dev_get_drvdata(dev);
>>>       struct amdgpu_device *adev = drm_to_adev(ddev);
>>> -    uint32_t ss_power, size;
>>> -    int r = 0;
>>> -
>>> -    if (amdgpu_in_reset(adev))
>>> -        return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>> -
>>> -    r = pm_runtime_get_sync(ddev->dev);
>>> -    if (r < 0) {
>>> -        pm_runtime_put_autosuspend(ddev->dev);
>>> -        return r;
>>> +    uint32_t ss_power = 0;
>>> +    int r = 0, i;
>>> +
>>> +    r = amdgpu_read_powershift_percent(adev, &ss_power, true);
>>> +    if (r == -EOPNOTSUPP) {
>>> +        /* sensor not available on dGPU, try to read from APU */
>>> +        adev = NULL;
>>> +        mutex_lock(&mgpu_info.mutex);
>>> +        for (i = 0; i < mgpu_info.num_gpu; i++) {
>>> +            if (mgpu_info.gpu_ins[i].adev->flags & AMD_IS_APU) {
>>> +                adev = mgpu_info.gpu_ins[i].adev;
>>> +                break;
>>> +            }
>>> +        }
>>> +        mutex_unlock(&mgpu_info.mutex);
>>> +        if (adev)
>>> +            r = amdgpu_read_powershift_percent(adev, &ss_power, true);
>>>       }
>>>   -    r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
>>> -                   (void *)&ss_power, &size);
>>> -
>>> -    if (r)
>>> -        goto out;
>>> -
>>> -    r = sysfs_emit(buf, "%u%%\n", ss_power);
>>> +    if (!r)
>>> +        r = sysfs_emit(buf, "%u%%\n", ss_power);
>>>   -out:
>>> -    pm_runtime_mark_last_busy(ddev->dev);
>>> -    pm_runtime_put_autosuspend(ddev->dev);
>>>       return r;
>>>   }
>>>   @@ -1884,18 +1907,7 @@ static ssize_t 
>>> amdgpu_set_smartshift_bias(struct device *dev,
>>>   static int ss_power_attr_update(struct amdgpu_device *adev, struct 
>>> amdgpu_device_attr *attr,
>>>                   uint32_t mask, enum amdgpu_device_attr_states *states)
>>>   {
>>> -    uint32_t ss_power, size;
>>> -
>>> -    if (!amdgpu_acpi_is_power_shift_control_supported())
>>> -        *states = ATTR_STATE_UNSUPPORTED;
>>> -    else if ((adev->flags & AMD_IS_PX) &&
>>> - !amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
>>> -        *states = ATTR_STATE_UNSUPPORTED;
>>> -    else if (amdgpu_dpm_read_sensor(adev, 
>>> AMDGPU_PP_SENSOR_SS_APU_SHARE,
>>> -         (void *)&ss_power, &size))
>>> -        *states = ATTR_STATE_UNSUPPORTED;
>>> -    else if (amdgpu_dpm_read_sensor(adev, 
>>> AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
>>> -         (void *)&ss_power, &size))
>>> +    if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
>>>           *states = ATTR_STATE_UNSUPPORTED;
>>>         return 0;
>>>
