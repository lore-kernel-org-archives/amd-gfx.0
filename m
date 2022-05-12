Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F069EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 12:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4483910EB7C;
	Thu, 12 May 2022 12:12:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA6310EB7C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 12:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCSr4bwFZOIQ3nFK6S/YrKzuJbUqnMhKpHAUCgYQMjpqTfqKbZaNHewsMNtnkRi1pZQnqYFPgW8734kAMioWsHbbRmCM/nj3ekVayNwIL4fm3Q087tAwK6iaevUL8v7y3hNtqNbU2J6g4zPgZhpN/7eX9eczEiBHqt2giI8Kw73fZvIb2ELwGg6WBM7OEsgldZ7f/N3h1Silse4FU/gerE7WVEf4YiJa946k4TawSWWQUHmbWFt/XcpC/I+QV2jLbpJ0Cqz6gM0WGVZuEi9Jo7qXu0miIpiMiAvZpFAP0YVkhbpr96NeliU542hGAQ0Dvaz2baaPY5mjPEkEpVK6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFSNCTQmKWsMo3bMCrDNGGwlIEvS1b1qAAuWyfbOs8M=;
 b=NvMcjT/Q1ry6dy3MuOkFhPOJ4XfRl8HOrA7Ts1SrTci+RBRFtEQphGEENoagnwVMOo/Uq1BW7LuXUL5b8TjbOaC5FHqqmFFFlRHBh8zzRCKr7eNfh4pbRt7ieK4tdtZhrlnZ8g3xq17SyA0SPL0bjSRHW+G6TNwOI9zKvKLWN+EMB2xTQXRB6J2H/hCYUjPpDhcblOjJ0X/BR5I6OXRU0Gb8uEjfSun4tv2XwvEc4lSHCTpa/dloe8oeg/JBrWS6RpkQxCSSuyx4NrwVvJabQa9B6adydk0biveVovkT77zLcT1DjXfdbj5tKWjavyKAOlY9Joe6asjo8FkY14RN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFSNCTQmKWsMo3bMCrDNGGwlIEvS1b1qAAuWyfbOs8M=;
 b=wfg/tTCBWLhfe/S5MFssnZHjqYMbyw6ppke3aOHQJQo5wQeIaHjgA6E8tTqWKcNqSTf4dh0OgghGM/XlQFVOPzmmGk251AV8U5PYLFKKMJ5fawUbdVTAXOjtK/BBpsdLxJqIIDoCQMDcZo8ApyYLd8JWA4Loy4iXYRrPpJkhKzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 12:12:41 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::b1ff:aa06:4620:8ed]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::b1ff:aa06:4620:8ed%9]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 12:12:41 +0000
Message-ID: <8d16aed9-02c3-ec5c-df2e-5be05615797d@amd.com>
Date: Thu, 12 May 2022 17:42:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/amd/pm: consistent approach for smartshift
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220512105652.3520817-1-sathishkumar.sundararaju@amd.com>
 <ee8d602e-ba20-e0d2-db20-603c65f4fa76@amd.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <ee8d602e-ba20-e0d2-db20-603c65f4fa76@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::22) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3b5c58e-3041-45bb-bfb6-08da3410b691
X-MS-TrafficTypeDiagnostic: DM4PR12MB6661:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB66615853544506AEF8F801469DCB9@DM4PR12MB6661.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uePBNU51yPHOsMnatAX3MdWkXB2/IL52xq7matllPuwcrIzf2BqOlA6uMhSR05vTJWjAgt5JhYNwyRTojI9vNy0g2y1kFmAqzv1Jxz1bPp8VeThlLUQnEg8sov+8/J9jbhF6ST6zAbGc8aZvubyEl/xrpF0ff6NCzkmCYUG6mx2zQMGfTHlKguO2bqQ+PAcN+xTMiYQZATqfvhmUEsseioRZ7VyD+P7P7NkuAgcGBnXV0CAUCJ6yuQWUUZBdq934BlQawOk5e785MKKB6ibX7eHhAGmIrMYtnNaexfqlQJlg/nJcKh80hl1uI+EXnIPVog6P5RNo/AQhQXMmAf2Y5FCymCATkRv6v431jc1sTkZEsdbYG1Q2/RWJyF6XWUFAtJNZXareni5YbGTS58LaD7I2OkBsbaebt8cVjyEtQL0jNGpscU8DCEUdbbJsDrdgARYBCnpL2hDo/XZ5UZEl5mTtht5TXxNIykEiSDWYhkH3UiGEg4xzw2Ovi2agVuvGwFa6GwRC1groPaEwHf2WvbOJRC4ovteT8ujxMxzqZWz2OiwERlyfBpJmf4KxCS3MjRX9jEGOJAP4adcCdDCx4MAktMHBBRY6KifeYzZ8rzCanyxMgY2r0I7ziHcCh8Lwl3Bo9H+mch2jxpq6Y9Zcr17KN235zOu6EvuZ6SeqmFxYEj+CW6Gr3iGH8OIwq8g4Yl20ldNyWfmKwLDq4tUEhQfNA5hO2MjFJ3kKAY9FdoQPgrE6LRBUdyEXwHkq04/T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(5660300002)(83380400001)(8676002)(4326008)(31696002)(186003)(86362001)(66946007)(66476007)(66556008)(31686004)(8936002)(2616005)(6486002)(38100700002)(6666004)(316002)(508600001)(6506007)(2906002)(53546011)(6512007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm42bGdZcFZGU2VVUkVLbklvOXUyQVNpVFE5L1NNUFBsaUxCcFVsZmlnanNk?=
 =?utf-8?B?ZkdERjk2aWpGeGlZVEZSOURRR2poT0tDR0dLNnRLbHJhYXFaL05kaHNrMEw0?=
 =?utf-8?B?STBoS3dlWHFkd0RETG1keXgwNHdCT1hETHFYT210S0hTbUJLdS9XaE80aXpT?=
 =?utf-8?B?b1A4SWs3Z2QySFQ3UnNhcWFEZzM3TVltRVZLT2N5Y1l4MCtYeWtxZTJvM0Fv?=
 =?utf-8?B?bXJLb2ZjY2tQYWhBT1c1R0s5ZHVvcU1CaDVtdFZleTNSeGRlS2lWNi9zYjNx?=
 =?utf-8?B?S0VaamIvV1RjWURFL2RNWmcrWUxkUjRJUklHeUJhclcyM2hyc0Y5NmZLUENm?=
 =?utf-8?B?eWtiQUdhVjBMU2ZDWS9ZMkpyQkpIOGRNMFpPTERyeVUzVXdtZTJHWFc4cmNq?=
 =?utf-8?B?eVFma3NEaldFM0VpYnB4UjZVVHN1ejduVWgxaW9aNU9nQTA3emFBYnYvL3pi?=
 =?utf-8?B?NzlrVy9xQnVtUnM4RE9KRC9FNmdlb3VMYnJHeVhnS3V6RHNWMHdOVU5LeURQ?=
 =?utf-8?B?MksrVkgraDF2RUdYbm1IQk1vNHg5SXJiVnJFTzFZQlZwZ2VCZlBsc3R3dGQr?=
 =?utf-8?B?VVJYZnM4cEZVMitEOVlmZkJTY1lWVXZOWUVRTkNONWY0QlBNaVlpWmlCYzFw?=
 =?utf-8?B?RUsrME95YWJoUjByTFc1aXdrV0lNRkNZTUFqTjFGei9zY3hSUUtkQVBuWTNV?=
 =?utf-8?B?QmJyNkFiTlRrWUhHL1pSbmtMZEpDbzErS2pWSUNtSVpTWUJnWFY1T2FzTUZR?=
 =?utf-8?B?Yk5TUVE3MXR6U1JkY3BKVnNEVXlCWkRGNVRWVXZyVG9vMElMKzNrWmhaRVcr?=
 =?utf-8?B?K3A0amo5cmRkRFFzZ3kwU3JEbjhUTER5QWNlUG1PdWlGY3JxR3cwc0U3VE40?=
 =?utf-8?B?SXozRkp2N28vUmRicDk5aG5CWGlZSXJ3VnQ2cWZJamc2bzdHMnh1U1NoSG5x?=
 =?utf-8?B?QytRSGNhejQrcDFTK1A0R1BVUTJ5REloVksxaHBhMmJvUWFUT2lYTmJILzky?=
 =?utf-8?B?RytuOWs4bFRUR2N1d253NHpyT0dmN2VKWSt0VUl5cUR0R2d6RTd3SzkvTWV4?=
 =?utf-8?B?dThYaVYyS1ZFWXpaMWdnRDhPMlY5YmQ5eUluQkhmTFdCUnhrb3ZyRWZrai8v?=
 =?utf-8?B?dTA4cCtQV1RsVzhUOVhISWlMV0xYOVhEa0w5WFRvakVPKysvbFV0RWVNNTZS?=
 =?utf-8?B?K3lLZUd1bExwVytBZ043U1BrbGlZeWhjUUtVQldRaGx1VG9ZckN5MEZhMVpT?=
 =?utf-8?B?QU1hOTBSMFovVlV0NWM1SDlvakFHcVpNSGdSbGd2bmpTOUoyWjMrUUNha2VM?=
 =?utf-8?B?RUc5TEFqY29tcTIvdFZCd1pYeno0SHQydUhZNzFQbjB0SnQyQkVvQ3hBT3h2?=
 =?utf-8?B?bEQ2NVVaN2RSN3FIYUYyZ2t4VDVvbUVpdnZGcVNuRjEyekkzeDhGYXBBZE0x?=
 =?utf-8?B?KzJvdElUNXc1WjRnMk94QVZqUUM2bjJEc0hrbWpLRjZKd0Z1T1g0d1c4Tkkw?=
 =?utf-8?B?YXA1TGZvQXppdWFjUUJFSHBzTmhXYnZ2VFdDZzRYRUpzbXVzcDJoa2UrTld2?=
 =?utf-8?B?YXQxeTRsS1ZVczh6UkhjdEdCelBEVEt0aVpwajk4NUJqb2d2M3dqY3VmN3hT?=
 =?utf-8?B?b3BGSFg5OTdYa3hpUG04SVlkaGZsVDE0Y096a1dTd1JDRml2WFhMMlgwbVpi?=
 =?utf-8?B?cUY2ZURmUUVQd1Y0QXJoQTVWQVd6ZHM3RUJ2NktsTHV0dU52aFFwalJVa1hX?=
 =?utf-8?B?M1ZXZ3BwV3FhVjJJbS9TR2FwMXg5Sk4xWDE2d0xMQ1kyMGNZUTlKV2I3cXJM?=
 =?utf-8?B?TXNxY2xXemV2Q3YyR1lTTFdRd1RxRFllNDBxRldqbUdSUTZ1elFJSHNrRUgy?=
 =?utf-8?B?VTJEQ3hCSkZiMmlSR1lKc2lLZzBncEp3cUVIRVJ4WUhNK1NXTjltek1WOUpW?=
 =?utf-8?B?OGx4aThmMUg1VG1BbC8yclloL0Evd3JYU0ZqZW5rSkxGS09lTzVqQXBENnlT?=
 =?utf-8?B?QXROeElTV0dROWYxZ1JRN1FRS0FlZFc4T0kzMnJPWnJmMUZ5eUdkSmI3OXg4?=
 =?utf-8?B?MzdibU4xUDVGVHJIMkJKRUVPanNuVk4wb254Q0E5cWNMN0piVWhvekxOZVNm?=
 =?utf-8?B?OVh6ZHhpRXNpTjJaYkhNLzZXMm1VM3FaaWliUGlFWHdrVGVJQ001M0VWSmVn?=
 =?utf-8?B?cmtUeU9YMk56ZzFJc2hkRmtaemw3azR0VDRoNkcwblVwU2VrYldxUzdqNzhU?=
 =?utf-8?B?UHNxVlRwYXVBOS93d2lVbWRMbkRreUxJZmNPbFNQN1lScHdZbHZGMXNHb2U4?=
 =?utf-8?B?NHN3b3JMZ25SR1Z4RGVpN0c1YUczRnk4WjJKTE5aMTFyS3k1SGZjZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b5c58e-3041-45bb-bfb6-08da3410b691
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 12:12:41.7690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UV/7em6AcgfmNXBLLMYAiEdHWZmfh+jcXT/W+iZ8YdEQy4G+L1EGdJ5c1223G/8MsUyz15E6JcV50oZo3JYa5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661
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


On 5/12/2022 4:37 PM, Lazar, Lijo wrote:
>
>
> On 5/12/2022 4:26 PM, Sathishkumar S wrote:
>> create smartshift sysfs attributes from dGPU device even
>> on smartshift 1.0 platform to be consistent. Do not populate
>> the attributes on platforms that have APU only but not dGPU
>> or vice versa.
>>
>> V2: avoid checking for the number of VGA/DISPLAY devices (Lijo)
>>
>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 136 ++++++++++++++++-------------
>>   1 file changed, 74 insertions(+), 62 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c 
>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index d3228216b2da..292e8c241597 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -1734,22 +1734,11 @@ static ssize_t amdgpu_get_gpu_metrics(struct 
>> device *dev,
>>       return size;
>>   }
>>   -/**
>> - * DOC: smartshift_apu_power
>> - *
>> - * The amdgpu driver provides a sysfs API for reporting APU power
>> - * share if it supports smartshift. The value is expressed as
>> - * the proportion of stapm limit where stapm limit is the total APU
>> - * power limit. The result is in percentage. If APU power is 130% of
>> - * STAPM, then APU is using 30% of the dGPU's headroom.
>> - */
>> -
>> -static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, 
>> struct device_attribute *attr,
>> -                           char *buf)
>> +static int amdgpu_read_powershift_percent(struct amdgpu_device *adev,
>> +                        uint32_t *ss_power, bool dgpu_share)
>>   {
>> -    struct drm_device *ddev = dev_get_drvdata(dev);
>> -    struct amdgpu_device *adev = drm_to_adev(ddev);
>> -    uint32_t ss_power, size;
>> +    struct drm_device *ddev = adev_to_drm(adev);
>> +    uint32_t size;
>>       int r = 0;
>>         if (amdgpu_in_reset(adev))
>> @@ -1763,28 +1752,65 @@ static ssize_t 
>> amdgpu_get_smartshift_apu_power(struct device *dev, struct device
>>           return r;
>>       }
>>   -    r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
>> -                   (void *)&ss_power, &size);
>> -    if (r)
>> -        goto out;
>> -
>> -    r = sysfs_emit(buf, "%u%%\n", ss_power);
>> +    if (dgpu_share)
>> +        r = amdgpu_dpm_read_sensor(adev, 
>> AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
>> +                   (void *)ss_power, &size);
>> +    else
>> +        r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
>> +                   (void *)ss_power, &size);
>>   -out:
>>       pm_runtime_mark_last_busy(ddev->dev);
>>       pm_runtime_put_autosuspend(ddev->dev);
>>       return r;
>>   }
>> +/**
>> + * DOC: smartshift_apu_power
>> + *
>> + * The amdgpu driver provides a sysfs API for reporting APU power
>> + * shift in percentage if platform supports smartshift. Value 0 
>> means that
>> + * there is no powershift and values between [1-100] means that the 
>> power
>> + * is shifted to APU, the percentage of boost is with respect to APU 
>> power
>> + * limit on the platform.
>> + */
>> +
>> +static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, 
>> struct device_attribute *attr,
>> +                           char *buf)
>> +{
>> +    struct drm_device *ddev = dev_get_drvdata(dev);
>> +    struct amdgpu_device *adev = drm_to_adev(ddev);
>> +    uint32_t ss_power = 0;
>> +    int r = 0, i;
>> +
>> +    r = amdgpu_read_powershift_percent(adev, &ss_power, false);
>> +    if (r == -EOPNOTSUPP) {
>> +        /* sensor not available on dGPU, try to read from APU */
>> +        adev = NULL;
>> +        mutex_lock(&mgpu_info.mutex);
>> +        for (i = 0; i < mgpu_info.num_gpu; i++) {
>> +            if (mgpu_info.gpu_ins[i].adev->flags & AMD_IS_APU) {
>> +                adev = mgpu_info.gpu_ins[i].adev;
>> +                break;
>> +            }
>> +        }
>> +        mutex_unlock(&mgpu_info.mutex);
>> +        if (adev)
>> +            r = amdgpu_read_powershift_percent(adev, &ss_power, false);
>> +    }
>> +
>> +    if (!r)
>> +        r = sysfs_emit(buf, "%u%%\n", ss_power);
>> +
>
> In v1 patch comment, I meant something like this
>     return amdgpu_show_powershift_percent(adev, false);
>
> And the above logic is kept in amdgpu_show_powershift_percent();
>
> amdgpu_get_smartshift_dgpu_power():
> return amdgpu_show_powershift_percent(adev, true);

okay got it, will do that. But will retain 
amdgpu_read_powershift_percent() as a separate function or rename it to 
amdgpu_device_read_powershift().

I hope you also didn't mean to combine them all into 
amdgpu_show_powershift_percent().

>
> Thanks,
> Lijo
>
>> +    return r;
>> +}
>>     /**
>>    * DOC: smartshift_dgpu_power
>>    *
>> - * The amdgpu driver provides a sysfs API for reporting the dGPU power
>> - * share if the device is in HG and supports smartshift. The value
>> - * is expressed as the proportion of stapm limit where stapm limit
>> - * is the total APU power limit. The value is in percentage. If dGPU
>> - * power is 20% higher than STAPM power(120%), it's using 20% of the
>> - * APU's power headroom.
>> + * The amdgpu driver provides a sysfs API for reporting dGPU power
>> + * shift in percentage if platform supports smartshift. Value 0 
>> means that
>> + * there is no powershift and values between [1-100] means that the 
>> power is
>> + * shifted to dGPU, the percentage of boost is with respect to dGPU 
>> power
>> + * limit on the platform.
>>    */
>>     static ssize_t amdgpu_get_smartshift_dgpu_power(struct device 
>> *dev, struct device_attribute *attr,
>> @@ -1792,31 +1818,28 @@ static ssize_t 
>> amdgpu_get_smartshift_dgpu_power(struct device *dev, struct devic
>>   {
>>       struct drm_device *ddev = dev_get_drvdata(dev);
>>       struct amdgpu_device *adev = drm_to_adev(ddev);
>> -    uint32_t ss_power, size;
>> -    int r = 0;
>> -
>> -    if (amdgpu_in_reset(adev))
>> -        return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> -        return -EPERM;
>> -
>> -    r = pm_runtime_get_sync(ddev->dev);
>> -    if (r < 0) {
>> -        pm_runtime_put_autosuspend(ddev->dev);
>> -        return r;
>> +    uint32_t ss_power = 0;
>> +    int r = 0, i;
>> +
>> +    r = amdgpu_read_powershift_percent(adev, &ss_power, true);
>> +    if (r == -EOPNOTSUPP) {
>> +        /* sensor not available on dGPU, try to read from APU */
>> +        adev = NULL;
>> +        mutex_lock(&mgpu_info.mutex);
>> +        for (i = 0; i < mgpu_info.num_gpu; i++) {
>> +            if (mgpu_info.gpu_ins[i].adev->flags & AMD_IS_APU) {
>> +                adev = mgpu_info.gpu_ins[i].adev;
>> +                break;
>> +            }
>> +        }
>> +        mutex_unlock(&mgpu_info.mutex);
>> +        if (adev)
>> +            r = amdgpu_read_powershift_percent(adev, &ss_power, true);
>>       }
>>   -    r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
>> -                   (void *)&ss_power, &size);
>> -
>> -    if (r)
>> -        goto out;
>> -
>> -    r = sysfs_emit(buf, "%u%%\n", ss_power);
>> +    if (!r)
>> +        r = sysfs_emit(buf, "%u%%\n", ss_power);
>>   -out:
>> -    pm_runtime_mark_last_busy(ddev->dev);
>> -    pm_runtime_put_autosuspend(ddev->dev);
>>       return r;
>>   }
>>   @@ -1884,18 +1907,7 @@ static ssize_t 
>> amdgpu_set_smartshift_bias(struct device *dev,
>>   static int ss_power_attr_update(struct amdgpu_device *adev, struct 
>> amdgpu_device_attr *attr,
>>                   uint32_t mask, enum amdgpu_device_attr_states *states)
>>   {
>> -    uint32_t ss_power, size;
>> -
>> -    if (!amdgpu_acpi_is_power_shift_control_supported())
>> -        *states = ATTR_STATE_UNSUPPORTED;
>> -    else if ((adev->flags & AMD_IS_PX) &&
>> - !amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
>> -        *states = ATTR_STATE_UNSUPPORTED;
>> -    else if (amdgpu_dpm_read_sensor(adev, 
>> AMDGPU_PP_SENSOR_SS_APU_SHARE,
>> -         (void *)&ss_power, &size))
>> -        *states = ATTR_STATE_UNSUPPORTED;
>> -    else if (amdgpu_dpm_read_sensor(adev, 
>> AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
>> -         (void *)&ss_power, &size))
>> +    if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
>>           *states = ATTR_STATE_UNSUPPORTED;
>>         return 0;
>>
