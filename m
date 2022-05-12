Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D246C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 08:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C5C10FD83;
	Thu, 12 May 2022 08:58:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F3F410FD83
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 08:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5xFPrQAz3mKmiSg0Dx0AjAJ/7ukQnzKeIh9VliHknwkCFIB/DjrtQYBIe2nxdgN3VxyDm8HvbWwE830D+XTLKCHjbH2H1FGMyGY8vZZDr3FcRTg6kAcU87dMdlVMKBNCbWihZ8zzruSdAkg5LP0b4jKwZDmSvYWKO8osA2l3CTS0Eih+ZRXRTjkI9thRVNZEeHDiXu7af5n6Zn51CF4ssS+RPRB2YKVSDMj78Y6WG3Nd83WqKjwSzDJiIQqYPf/YltxljY1s0m2yOtBIVqxisYz+1r0KCA4bARFgfaDL8sg5fGHhZBDcBQBcoqlcdAZvgRqpVpytc3yZTKx/Makkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nJnsIGMpamZncFr9rIT7MpszHM3o/k7rt1QyZqWuYI=;
 b=VZhWReSUHeBugHr2z50ymepyxRWzZ1nNNzA9Jaob4JstVyrd5/r5OrtWAHrgfyzFv1ARRaRzKqTI1n3KyOispEF9REQNdMwvAiGda2+08vg5hRgtCAB3DbOwrfrhUBhnFaInDYFYCTUp2IdNo7RalTojdcu9obNH2/RzQ/s+KTnA1RnqTkcCNfmMK52o+mNfa2hPGrN5Lh02tT8ML8ldIropxLCYCo7IC0KRKGt8NMeqX6uCrg/rNBQmQQqyka43Vf+a4QHZtwiQK8Ks14b1X8zB9JpfIb6HmiGr3FRq4EY7c3rE78k5VeATtwNnf+lO0/kUHV7Q6n6lD8GUYiUSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nJnsIGMpamZncFr9rIT7MpszHM3o/k7rt1QyZqWuYI=;
 b=hKLueik+F7kIyh/5N9qA5rSA9346678PFGai7UWBkFRDA/9qrcU8YaMQLVk+hGlVEaaJmuXMV9DUHMbffWB3xaXxSKd5PlqsnqkfXeDAdg3s3U0lb/kJemnnD4XMdrQKAZqKyNvIoT1DKKbt3fSwCDzfSgfu1tAJY+UyvbcG8C0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by DM5PR12MB1851.namprd12.prod.outlook.com (2603:10b6:3:109::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 08:58:52 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::b1ff:aa06:4620:8ed]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::b1ff:aa06:4620:8ed%9]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 08:58:52 +0000
Message-ID: <d5c0fd82-3c2f-235c-ebdc-832bbfe2a5a1@amd.com>
Date: Thu, 12 May 2022 14:28:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amd/pm: consistent approach for smartshift
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220511122517.2546133-1-sathishkumar.sundararaju@amd.com>
 <1ba333ef-cb03-10a5-abf3-ef02b7ed2d47@amd.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <1ba333ef-cb03-10a5-abf3-ef02b7ed2d47@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::21) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 336fd79e-5218-4b60-a0bb-08da33f5a322
X-MS-TrafficTypeDiagnostic: DM5PR12MB1851:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB185192D8801CC2CD4E5CF09A9DCB9@DM5PR12MB1851.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1CMaQgyhjyO0ULMRUi6ytYBoHSLQfdgW3ILNXVM698rSi38owltJql3QHFNSa6RhxsEiagFNaSth4uxrfhdjr11RPQB0IdYrvlkvL9lqfquiTCtAneXsc52wlbPX3qILXDCtV+l2SaTypTUTaQkZ1/q/XyDxVUOkVeJFmH7YKsqwCRFXT1jfLV0gcKuizGXs91zhjWWUB2eptkdfLzqN5v8xKDM7i6v8oOyzuW9XX+2OA9GlC9GFalLCruFJheumbCkruvsr02BkrQbHi9g7fSON9YDA7pPXQumNb/VCzG8IIFO/K263TGufmSdhwYF2hraKc2VGSKnnQ1ajAXI2vk3x7U8TCziQaIZUfFt/FrXaK4YVErwmEi1pgJTb+WHcmpd7L6cIIaa00ohN44Q6TA0ffA0kUVIfuf6dyJPOQHK967+aTciD2bLZ8hhmf30T+oUj3KSUyIjq3ClO5Ko2kJHutq9/8R3yvn9LSShEHtDGP48bARcs1U+oSMAQ4VB53sD9XKZUuIkA7ZZA/GkOPyGrwOOfEaM56gpRbFzrWiXxfM/33/ocmOlhfsYSlxBgxUr+y9w1KK8w+49pBwBA6KYqejTD8XeupFiKdX8ZFQxMflZnprTe/oJttYDauvOWNeMeUQ7dp/hniBLQwQhCCBmAPX4VCPe0MtLlGnLXMuqdk5fEvHu/YyP+TMKVp0Trrbo7A6jy/m4ToFwYDcT++HTd8fbYE1EJOZqQpALAmBLsQm/HpVLUsQTv8lUqqAd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(2616005)(8936002)(6512007)(26005)(4326008)(66476007)(66556008)(66946007)(8676002)(5660300002)(36756003)(2906002)(316002)(31686004)(6506007)(6666004)(86362001)(38100700002)(6486002)(31696002)(508600001)(53546011)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXoxUUM3WHpwWVdkcmkya2pQVTRDaWU5NGc1dVNycStTbG5Vd2lrUHY2enFS?=
 =?utf-8?B?MUdsTU14Q1RMaVBaM2RISWhiQkdpand2MGNLd3JrNWFYd2JNYlh3TVV2L1RC?=
 =?utf-8?B?SGhsSk55RmJ2L0NNczZMYjNiejdaMUJVdnMyY3JCU2pFSVhLMkRLUnBGazNR?=
 =?utf-8?B?aDY1b0locjE3TzF6c1hpNEthZkRNUDJBa2V5SDB4WTB0bjFFOEdtM3owOW44?=
 =?utf-8?B?MXRQT1B6RVB0NkFxNlVaQlQ3d21DWkV6M2dTKzh2TXNxTEVRQUp3aHZsWm80?=
 =?utf-8?B?TUlXdGZ4eUJ2QWlqUURyR3lxUW96YXlpSHlGMnFnemFBRU53YTF1NDJyVjIw?=
 =?utf-8?B?dHExeW8zcnZWQ1FLSW5DcUZzQ01BV21kYVFaTUFsSWhISzlTR05uUzdmbUNq?=
 =?utf-8?B?QjJsYzV0TGFzM2NTaU9DVzdBUENqNzZKbjVUMzJoQlUvMDFTSTNXZ2dlcWxG?=
 =?utf-8?B?RkFMSDNFTU9MK3RoajlxbG9WV3RzTC9lWTZBMTBZZ1VsN0tjTGZRU3paNW50?=
 =?utf-8?B?UzRWbVR1bmpBejRHQjFsN2krQzBCZkY1MGdsSFdTVmZZa29wUXpVYnpmWUhK?=
 =?utf-8?B?Y25nWDN3OVpBSnVYa1ltK0Jha0Z5MkF1T2lkWWZuSWRyRjZrL2xsbU5BOWpo?=
 =?utf-8?B?aVlURGliVmpmMGxxNXQwUWQ4YnVoam5namI0c25xVzd4ZGFDVUxZcjJRcGdK?=
 =?utf-8?B?NnN3emJEL3hPSmVaL2E1MWcvMGI3UmpjS1RkQU5INHlLc1RDNXREK0o2bFEr?=
 =?utf-8?B?UGREUXpRR2JaYmhyWnliclVjOFZoV1liNU9peW5RY241emZMYTJJUkNlREFs?=
 =?utf-8?B?MXFVSU1oYURleXE2bzBzVzhGVTU1V0x5VkFOQVJQS0VIK3NMMVlwcUNLd0RR?=
 =?utf-8?B?QjZBeUd5LzF3dWJXaEJjT0NDSmUvSDMxSzV0Z1JqakRWenJuYldjMFdkeDE0?=
 =?utf-8?B?WnJvRmptUVVldEt4Wm1nMUZ2cGp2cE9RTnpSVVR1NWpoRnVJYmJQNVNTMVlN?=
 =?utf-8?B?VzF6SEFOTmdYVHhSUFMwaTVaTE1iWmJuU09uMzBvMFJOdnd1WTEzYy80UTZI?=
 =?utf-8?B?cm12Ky8vUXBuMDJUQWNEOEhzTzlhSUFYMTRwMVU5Znhld0t4WG1kRXN0NEdZ?=
 =?utf-8?B?dHRMaG9XTm5sbUdsYWgwQ3lHaUFOTGM2SmJaWHNsVEVaVEtyZHJnL2ZLYTN3?=
 =?utf-8?B?ekwvM1JXVEJwUEdCMm5qekF0K3czVCtkZTVNejJ3VU9NWVFDYWpOTzZEcmk3?=
 =?utf-8?B?UHMrUm5iNXJLc3NJMFgyaTZxT3ZZalhlTkRsMXIyM2Z6N2ljQjhuWlhHbklz?=
 =?utf-8?B?ckpINWZRL3BVdTN0Z3lLMW5TNEdVMHlBRzhzcFYveHd4aWY5T3M2WEw1L2hR?=
 =?utf-8?B?ODBBWlpRWVhxb0kyZk1UUmg3dDdhdVhTdGdJWUpEbFZUSGxFemg2OGJ3MlNs?=
 =?utf-8?B?RTUybTI0QklsZldYdlhmRVhyQ3AxK2ZCTG1BcUVXV2pvRDlDMmtoZzNWSTlS?=
 =?utf-8?B?RFovL1NwejlTWndTZi82NmNqYkpaUHlud3kvZm1tRk5sd2FKOWdCbGhTSnFK?=
 =?utf-8?B?dURxTTZIMi9CS3dLS2dhL09CWG1nOEpQY2tCcjZqR05QS1NObTNGTURmQzBh?=
 =?utf-8?B?NmlsWTBnOCtURU9wU05pSWVhVC92Z0VrendYNjFqbm5scVVIbDN1MkkxSVYr?=
 =?utf-8?B?Q3FtdVI1cnp3RC9nN3U5WHpzSVlhcVNPVUR0NTlsaTdZWll6SEVWdUppK0VL?=
 =?utf-8?B?bUJveFlnMjA4V0RFSVA3YUZkUHEwbktyUlJ1UmRjK0pyVnF2UVUvYjc3MDNS?=
 =?utf-8?B?NW8wMFdIa0xQbUhWOGhkY0ZSTFRWZ2tTRW5scm4vYWp3ZGtFTjdnWThQMEk4?=
 =?utf-8?B?cGZRaU9pY0VGbDNlbHRzNU0zNDRDQ1BuTGNGMXlMZG9CRGMyM05WT3Z6bnJt?=
 =?utf-8?B?Z2lrdEZLNnF4cGszRVhEVmVIbytwN0tqUFYxWnJzditBTUFneWUvc096dDdT?=
 =?utf-8?B?d0lNQVBmeGkyTmd5ZVpkdi9jWmlZSDNqQjJrRVRUeEFyRW02QjlhMUFsMGtq?=
 =?utf-8?B?Rkx2UUpGMXg1cHZjTUcwS2wydWUzK1FZZUxaTjkraFI4NHcwQUlRSmo4MnV6?=
 =?utf-8?B?UFdJWXpoTVdZaXc2TWcwK2xla0RReTNKeDJmVVhsSkI5YkFHYzNPa1F4TzJj?=
 =?utf-8?B?YzJPWU1LQzhXWlR4OEJMNmxhTnVsY0E0LzhWWmtDTmUya3J5bkJ4OUNaUVBm?=
 =?utf-8?B?VlNoSGYwc25XQ20wN1FCK3UzdFgvY0hGUjg2eVo3Sy9ONXB5d3NXWDR3Vk9E?=
 =?utf-8?B?b3R5SnVSdTBnbUFmZVFJcnBxOXlmUlZETXZjaEZ1RW5rWmdsYlZqZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336fd79e-5218-4b60-a0bb-08da33f5a322
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 08:58:52.6117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2Qdyma3o0dHwL/mQL3Irt4Ufu46RqrCy65s545jO+eCFDnw0hkFVzkRhOISXMvQpv2HqpzZnY3OeUKMJRknXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1851
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


On 5/12/2022 1:50 PM, Lazar, Lijo wrote:
>
>
> On 5/11/2022 5:55 PM, Sathishkumar S wrote:
>> create smartshift sysfs attributes from dGPU device even
>> on smartshift 1.0 platform to be consistent. Do not populate
>> the attributes on platforms that have APU only but not dGPU
>> or vice versa.
>>
>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 146 +++++++++++++++++------------
>>   1 file changed, 86 insertions(+), 60 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c 
>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index d3228216b2da..c2406baeef93 100644
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
>> @@ -1763,28 +1752,64 @@ static ssize_t 
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
>> +    if (!r)
>> +        r = sysfs_emit(buf, "%u%%\n", ss_power);
>> +    else if (r == -EOPNOTSUPP) {
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
>> +        if (adev && !amdgpu_read_powershift_percent(adev, &ss_power, 
>> false))
>> +            r = sysfs_emit(buf, "%u%%\n", ss_power);
>> +    }
>> +
>
> Instead of repeating, the above logic also may be kept common and used 
> in APU and dGPU power with true/false flags.
okay will do that.
>
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
>> @@ -1792,31 +1817,27 @@ static ssize_t 
>> amdgpu_get_smartshift_dgpu_power(struct device *dev, struct devic
>>   {
>>       struct drm_device *ddev = dev_get_drvdata(dev);
>>       struct amdgpu_device *adev = drm_to_adev(ddev);
>> -    uint32_t ss_power, size;
>> -    int r = 0;
>> +    uint32_t ss_power = 0;
>> +    int r = 0, i;
>>   -    if (amdgpu_in_reset(adev))
>> -        return -EPERM;
>> -    if (adev->in_suspend && !adev->in_runpm)
>> -        return -EPERM;
>> -
>> -    r = pm_runtime_get_sync(ddev->dev);
>> -    if (r < 0) {
>> -        pm_runtime_put_autosuspend(ddev->dev);
>> -        return r;
>> +    r = amdgpu_read_powershift_percent(adev, &ss_power, true);
>> +    if (!r)
>> +        r = sysfs_emit(buf, "%u%%\n", ss_power);
>> +    else if (r == -EOPNOTSUPP) {
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
>> +        if (adev && !amdgpu_read_powershift_percent(adev, &ss_power, 
>> true))
>> +            r = sysfs_emit(buf, "%u%%\n", ss_power);
>>       }
>>   -    r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
>> -                   (void *)&ss_power, &size);
>> -
>> -    if (r)
>> -        goto out;
>> -
>> -    r = sysfs_emit(buf, "%u%%\n", ss_power);
>> -
>> -out:
>> -    pm_runtime_mark_last_busy(ddev->dev);
>> -    pm_runtime_put_autosuspend(ddev->dev);
>>       return r;
>>   }
>>   @@ -1884,18 +1905,23 @@ static ssize_t 
>> amdgpu_set_smartshift_bias(struct device *dev,
>>   static int ss_power_attr_update(struct amdgpu_device *adev, struct 
>> amdgpu_device_attr *attr,
>>                   uint32_t mask, enum amdgpu_device_attr_states *states)
>>   {
>> -    uint32_t ss_power, size;
>> +    struct pci_dev *pdev = NULL;
>> +    unsigned short devices = 0;
>>   -    if (!amdgpu_acpi_is_power_shift_control_supported())
>> -        *states = ATTR_STATE_UNSUPPORTED;
>> -    else if ((adev->flags & AMD_IS_PX) &&
>> - !amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
>> -        *states = ATTR_STATE_UNSUPPORTED;
>> -    else if (amdgpu_dpm_read_sensor(adev, 
>> AMDGPU_PP_SENSOR_SS_APU_SHARE,
>> -         (void *)&ss_power, &size))
>> +    if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
>>           *states = ATTR_STATE_UNSUPPORTED;
>
> No need to continue if ACPI indicates unsupported.
okay, yes.
>
>> -    else if (amdgpu_dpm_read_sensor(adev, 
>> AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
>> -         (void *)&ss_power, &size))
>> +
>> +    while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) 
>> != NULL) {
>> +        if (pdev->vendor == 0x1002)
>> +            devices++;
>> +    }
>> +    pdev = NULL;
>> +    while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, 
>> pdev)) != NULL) {
>> +        if (pdev->vendor == 0x1002)
>> +            devices++;
>> +    }
>> +
>
> Do we need this enumeration check now? Now the node needs to appear 
> only in dGPU. Isn't ACPI function expected to indicate platform 
> support? Or, could you try that on non-smartshift platforms?

Right, this can be removed, carried this check along from a previous 
version which did not always create the node on dGPU, now not required, 
ACPI function wasn't available on couple of other platforms I checked.

>
>
> Thanks,
> Lijo
>
>> +    if (devices < 2)
>>           *states = ATTR_STATE_UNSUPPORTED;
>>         return 0;
>>
