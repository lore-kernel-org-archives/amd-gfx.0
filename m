Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0FEEB64D9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jun 2023 05:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C3D610E275;
	Tue, 27 Jun 2023 05:07:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2AE110E275
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jun 2023 05:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=js4N0EfvJXAFGoO9SluNIsYF1e4qoUK8MtRfJTBEf8TiWfiZZ2r+NF2gjr3SRMOfWNt28chZAMLx1Ns9vqTP6OdRZZ6/F/A/hefBO46htrr5WMs2i2vdQk8wpvDzM4j5oikJJGv+0dq0V4cPYgkbGr9UICy6ygE0FSGE6XbQncr9LshyMuJH/y/ZMhk2IWH/bLQFIEQQ37GqYCLmyqyLY6AcP3qVGvKlOZVh5/xp4GfFVESuLVHZbD7cbYg8Ku9GQn0VU4R7RLlfsrx9ob3Iu7ygRHikmr3EhLhHezxCcRS6Pw9ytmdgfPQbYfODfvdtFl9HaMR1KPXzuQeBKunPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTd8x1iY1IOnauZ4+Ox/Sb4pyxlflJmByCZ3Y5C3Dj8=;
 b=FF+JMx0IMsR5vQrqD5zIvrLEVNzCQ1XYca0aM8caDR/PFExZDmm2IFrBShHwI2h+OE4UF3NLGXIk45vY8n1PmqavXqQu75ojjt6bS3N+hsG87siBR/UGUy+/wqAbMaEZ1WcIRA4OFQumoma0GqvkYWg3iy7Xfx5iMAfoZShBrtrwpOL15ufuLR3fsL0uLyOEPEnuC54o+GsKynsl4rUIZWwlpPQRCk96O5qOIil7CDFala8CqfyFaOjghT2y0XbncwsuklnfYZViW2ydLu6KsW620teNiyWe2ZALirSit4okBeTRdC/mqqoE2zWDHohDU8TkPGOwdumN/QZqb3ujig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTd8x1iY1IOnauZ4+Ox/Sb4pyxlflJmByCZ3Y5C3Dj8=;
 b=xTUgHZR+9ZdLgbbvvt8dJG5/1sypGmoX8wAjC30rXaFgncr+x8j7knAX7i4Bc2HCTFW5v2owcmShKy+aWmZ5CBihEGaB9rWIdASDSwBTKQ7NR+Irn5W+voy+ne1DEyo7bDKRT1BEjDB8GzDioEpPUy4PFNHwuCvVIFBrfpwPv20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 05:06:57 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 05:06:56 +0000
Message-ID: <a1b2abd0-3813-3925-a90e-2179415af09b@amd.com>
Date: Tue, 27 Jun 2023 10:36:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] drm/amd/pm: avoid unintentional shutdown due to
 temperature momentary fluctuation
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230626074713.27397-1-evan.quan@amd.com>
 <20230626074713.27397-2-evan.quan@amd.com>
 <f96f519d-cf85-d0ae-761c-060561782207@amd.com>
 <DM6PR12MB26190902EBC959ED8A4D3804E427A@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB26190902EBC959ED8A4D3804E427A@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::21) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a096f4-6d9e-499e-ebb5-08db76cc546c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqZ9O/QVxd/Uj7SwavI4giucTn7CgTjr3XJ7kKDRWdusyLNY7fniziNPCJjPpIeaRo+qyLXL99PdlfKL58mPY3T0THarfEnekoyRy4WYhUb0p/YlA+MQV89Stz6sRv6JKuo/VQAaSBTfxvxouL/M9b+IUaMaflpcnbIQzdzN16hXnyVXLjl4PF9LQaBdaRdv4NDXZyaR6gK/N+NszcXgsaogUkS+SuLO4qACe6rdK9fJNx6Jc2m1tMQRwXlmcptIYtHDdukO5onvoJY06PTMEvRCydz9lGZRTqHkyTkXCZlz53u0Oxm0ikH7HfU87+AnoufOM507VWjosvZpUU1ktbvHJM7HQoSPJO5g8m8NF5qErayZBL0FNb9SbbLUNad+fvZL1i6vLvI5SBwnxHWIM5TSK+wvQ+ibjfT9xXz56C4jGJU6+H5u6KDwZuVctgQQwFDd2RrvHwODkzDi1n3NbHWf58SfKntKtC7n/+g117TTyKZpg3S3RgYz86QQa1kw+OUSY63SBEvu5gc8h+QuxNwkaf7KvjKtEFMLNppAmqxrMZTkcn/mE2knBPL8R1L9C/rSCYKHi3x0KELPuuOjVjmBrewqo6/VNhCgdBisJ4F8nEz455dIXEczPMdwMveu6Egu2YSZ15sENhCN9PiQGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(2906002)(186003)(30864003)(6486002)(2616005)(38100700002)(6666004)(83380400001)(6506007)(6512007)(53546011)(26005)(110136005)(31696002)(41300700001)(86362001)(316002)(478600001)(36756003)(66556008)(4326008)(66946007)(66476007)(31686004)(5660300002)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmlPWmRETStzc3pveXNlTmZwVUg4UCtCSEFmNmlMNHZkUmFBU3RLZ2NXOEFT?=
 =?utf-8?B?NVYxSFE2N3NvYmg2RHpWTFp5WjVCZGVFQnNscElxQ1F6QTltbjFUMnBPclpB?=
 =?utf-8?B?RVZHeHkyQXdjeHhKQnFCM1B0Vm9KUTF5NWNSY3daTDlzQ2Njakgvb0xQNlFY?=
 =?utf-8?B?V2VwLzlyM2VYK09NMDFZUUtJdEdKc21TT25ROFEveXhhV0w2MUptcXZodlB1?=
 =?utf-8?B?aTBHKzU3OTBRbXJMY1JPRXZ6RmtWQnFWbnFnb1hDUmJLR2d6QUJZL1lRZ1dr?=
 =?utf-8?B?YkpJdlZ0WVYvMzVvL3VlTlNUaElKbklXMGNKeFZLL0dPZVlGU2VTR3FQck1r?=
 =?utf-8?B?eEhQanoxU1BlamNiUTE3UEQ2ME9YaFpSY0F0SElGSGp1RVRaZE1IUkVTZlY1?=
 =?utf-8?B?aFJqQW8wSTEwNEJYREFLL2hCRUVZT1BkaklQSE9BNmozeTBwUlZEaUxBMXBn?=
 =?utf-8?B?YTNQSzlPOHcvSU5Hbmk1S3Y0S1JLbFo1SjV4QUdiN2QyNkN4RmtpaCszV0cz?=
 =?utf-8?B?Y09xMGo5a2tUTCtSYkxmYTk3dHYzUXNTTFI1U084RWcrMUFySmgveE1oc1Rs?=
 =?utf-8?B?bkVQWWR5L0lyUXJuN3lSRE5hZU9LUHFyZkpFV3F2QXFxMUNxWE4zdTd0OE9H?=
 =?utf-8?B?NmNqSjVqTnRyRDI2VHVtUVRnQXNTbzIyZXVyekpERW9lYkRHNE5XRExlWHRP?=
 =?utf-8?B?ZGJnbWRIaVUrVEdyT3JBR0NJMENHck5nNEo0MWdQVTFQQWZQREtjVFlubHBz?=
 =?utf-8?B?SkpBbjZTcnJlZmRaSFUxTkd0dnF4N3ZieUFETFpQTXF6K0tBNFVvZVlyTElP?=
 =?utf-8?B?Y2NtdmlPOXVzMHplMkFHUGdwbWdiek5GZko1enFTVVJ5WElWVkdtQjZIV3d4?=
 =?utf-8?B?V05VRDBvb0UzN1FwODc4YzEwUnp2ektNVkJEbWJ2ZzM4VHBqYlZNL2k1MTV4?=
 =?utf-8?B?cmlvU1pKbDBMMkg4UXZrVkFCZHRYQVQ4MUZhTzE1bERhRlp0RFRUMnRkWGZY?=
 =?utf-8?B?MjM2MXNHREZkTnpVc1ZJVzk5Yk15aHlvTEdsaWwrTnFvQ1MxeTZ5VjRyamV4?=
 =?utf-8?B?WDNWbnU2UFYvU0hEeVJOaEVYNVBYZ3BJazh1WXM1VzVVRzhaMDdkaXUxa1U4?=
 =?utf-8?B?VHBlNTdUMG43Mkc4ZUlwSG1mUHhVdnhmeUtUMmNjV0pyNHhid3c2Y0tqZ0Rz?=
 =?utf-8?B?Tmp0RWRMbjFwSnI5T3J3QVY1QlRlYUhrdkVFZTE3L3UvSkE3ZS91Q3d3WnYx?=
 =?utf-8?B?cVZ2Zk9SSVg0NUFEMEh3aC9kL1ErRjhlY0JmUVl2RncvS2RUM2Y5T2o2bGcw?=
 =?utf-8?B?WEU4dmVRN0crRVA2SUNsR1ROY3AxYlVMVHQ0cElEalFxVlpjZlJnSkxTNDBj?=
 =?utf-8?B?dEs4WmVaQ1Zqajk4SGRZRzdNRVBjVDRDcGgycUVZQlVYbmMzK3JvVTVlTHdR?=
 =?utf-8?B?UnJpdUdMMVdwUk1OOHlFMmNMQzFJV1J6YkdxcVEzaGcyQ0xENE9EeEpkMU1r?=
 =?utf-8?B?dEE4VGVSSVZuNXVFYmNUM3BadWcyRStKcWRoN2JDZ3E2MU1CQ3JtU2JNY0FH?=
 =?utf-8?B?ZHVUSkc5cGU5cXNLb29nYVBxamQrTVJLK01HSjJheXBIb2JBQ0FqQ0xaUy90?=
 =?utf-8?B?dmZDMUJ2emZQTFBrM09EVThzNUs0eCsxKytjZmpEU3Bvd3pEbFFtV2ZUVUhD?=
 =?utf-8?B?S2RTd0R2VTVKL2xZK3BJdE1DRmcrbFlESXd1MjMvV2dIQzFaU0hUTjBlTndl?=
 =?utf-8?B?UDVzK0pwRm4xSTlnaDAvTnlMTVMwVTRvb0pQcEhHcHNlU0wvRGxzM0JqRk90?=
 =?utf-8?B?bUJBZDFYM0pPdmlFTHhVVVMvdnQzdXhrdWFGVUxndnhMWm5iRm9Lc01OMzN6?=
 =?utf-8?B?SlNPVFdUTzVBSHgxNHNEc0d1VkRkdWtJWG1tSk1VM0NTWlBVdktLdUlaeXJO?=
 =?utf-8?B?aFlTb3JjUGVKTE9oQ0hGRjBWekt4VzhHN0J3VDlnSXdwVWloR2JKQTBnR3E4?=
 =?utf-8?B?RisySmRPTjYxY3FEZFI5VUgwcGF0azBZZWp3dVRHVWRvN2p6d0ZsY3dRMnd2?=
 =?utf-8?B?UXVxelQ2ck5Wa2xYckFLZW9DUlo3cm5kNWFaR3luSEV1RFIxY1I3Qnpaeksz?=
 =?utf-8?Q?EJH6UoAcS/+EUVMG9wcmIaGn6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a096f4-6d9e-499e-ebb5-08db76cc546c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 05:06:56.8644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pof2fY9xRCrLDRtoA6W4GvOk22EyVR9ddixrEfhL0u61cuoKPKU0ZopgpkXXvnPY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
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



On 6/27/2023 9:02 AM, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, June 26, 2023 7:54 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amd/pm: avoid unintentional shutdown due to
>> temperature momentary fluctuation
>>
>>
>>
>> On 6/26/2023 1:17 PM, Evan Quan wrote:
>>> An intentional delay is added on soft ctf triggered. Then there will
>>> be a double check for the GPU temperature before taking further
>>> action. This can avoid unintended shutdown due to temperature
>>> momentary fluctuation.
>>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 ++
>>>    .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 48
>> +++++++++++++++++++
>>>    .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   | 27 ++++-------
>>>    drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  2 +
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 34
>> +++++++++++++
>>>    drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +
>>>    .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  9 +---
>>>    .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 +---
>>>    8 files changed, 102 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index e459381dc759..5ef1f31e703c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -287,6 +287,9 @@ extern int amdgpu_user_partt_mode;
>>>    #define AMDGPU_SMARTSHIFT_MAX_BIAS (100)
>>>    #define AMDGPU_SMARTSHIFT_MIN_BIAS (-100)
>>>
>>> +/* Extra time delay(in ms) to eliminate the influence of temperature
>> momentary fluctuation */
>>> +#define AMDGPU_SWCTF_EXTRA_DELAY           50
>>
>> I think a delay of 10-15ms is good enough to filter out any spike.
> 50ms is required by our CE team for supporting the customer. It is also aligned with Windows side.
> Considering we cannot guard that(10-15ms is good), I think it's better to stick to the 50ms recommended setting.
> How do you think?
> 

IMO, a temperature reading consistenly remaining high for 10-15 ms 
shouldn't be considered a spike since thermal controller (given its 
clock) would have taken multiple readings by that time for the same sensor.

I'm fine if you want to align with Windows side.

Thanks,
Lijo

> Evan
>>
>> With that change, the series is
>>        Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>>
>> Thanks,
>> Lijo
>>
>>> +
>>>    struct amdgpu_xcp_mgr;
>>>    struct amdgpu_device;
>>>    struct amdgpu_irq_src;
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> index 11b7b4cffaae..ff360c699171 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> @@ -26,6 +26,7 @@
>>>    #include <linux/gfp.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/firmware.h>
>>> +#include <linux/reboot.h>
>>>    #include "amd_shared.h"
>>>    #include "amd_powerplay.h"
>>>    #include "power_state.h"
>>> @@ -91,6 +92,45 @@ static int pp_early_init(void *handle)
>>>      return 0;
>>>    }
>>>
>>> +static void pp_swctf_delayed_work_handler(struct work_struct *work) {
>>> +   struct pp_hwmgr *hwmgr =
>>> +           container_of(work, struct pp_hwmgr,
>> swctf_delayed_work.work);
>>> +   struct amdgpu_device *adev = hwmgr->adev;
>>> +   struct amdgpu_dpm_thermal *range =
>>> +                           &adev->pm.dpm.thermal;
>>> +   uint32_t gpu_temperature, size;
>>> +   int ret;
>>> +
>>> +   /*
>>> +    * If the hotspot/edge temperature is confirmed as below SW CTF
>> setting point
>>> +    * after the delay enforced, nothing will be done.
>>> +    * Otherwise, a graceful shutdown will be performed to prevent
>> further damage.
>>> +    */
>>> +   if (range->sw_ctf_threshold &&
>>> +       hwmgr->hwmgr_func->read_sensor) {
>>> +           ret = hwmgr->hwmgr_func->read_sensor(hwmgr,
>>> +
>> AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
>>> +                                                &gpu_temperature,
>>> +                                                &size);
>>> +           /*
>>> +            * For some legacy ASICs, hotspot temperature retrieving
>> might be not
>>> +            * supported. Check the edge temperature instead then.
>>> +            */
>>> +           if (ret == -EOPNOTSUPP)
>>> +                   ret = hwmgr->hwmgr_func->read_sensor(hwmgr,
>>> +
>> AMDGPU_PP_SENSOR_EDGE_TEMP,
>>> +
>> &gpu_temperature,
>>> +                                                        &size);
>>> +           if (!ret && gpu_temperature / 1000 < range-
>>> sw_ctf_threshold)
>>> +                   return;
>>> +   }
>>> +
>>> +   dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW
>> CTF) detected!\n");
>>> +   dev_emerg(adev->dev, "ERROR: System is going to shutdown due to
>> GPU SW CTF!\n");
>>> +   orderly_poweroff(true);
>>> +}
>>> +
>>>    static int pp_sw_init(void *handle)
>>>    {
>>>      struct amdgpu_device *adev = handle; @@ -101,6 +141,10 @@ static
>>> int pp_sw_init(void *handle)
>>>
>>>      pr_debug("powerplay sw init %s\n", ret ? "failed" :
>>> "successfully");
>>>
>>> +   if (!ret)
>>> +           INIT_DELAYED_WORK(&hwmgr->swctf_delayed_work,
>>> +                             pp_swctf_delayed_work_handler);
>>> +
>>>      return ret;
>>>    }
>>>
>>> @@ -135,6 +179,8 @@ static int pp_hw_fini(void *handle)
>>>      struct amdgpu_device *adev = handle;
>>>      struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
>>>
>>> +   cancel_delayed_work_sync(&hwmgr->swctf_delayed_work);
>>> +
>>>      hwmgr_hw_fini(hwmgr);
>>>
>>>      return 0;
>>> @@ -221,6 +267,8 @@ static int pp_suspend(void *handle)
>>>      struct amdgpu_device *adev = handle;
>>>      struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
>>>
>>> +   cancel_delayed_work_sync(&hwmgr->swctf_delayed_work);
>>> +
>>>      return hwmgr_suspend(hwmgr);
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
>>> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
>>> index bfe80ac0ad8c..d0b1ab6c4523 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
>>> @@ -603,21 +603,17 @@ int phm_irq_process(struct amdgpu_device
>> *adev,
>>>                         struct amdgpu_irq_src *source,
>>>                         struct amdgpu_iv_entry *entry)
>>>    {
>>> +   struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
>>>      uint32_t client_id = entry->client_id;
>>>      uint32_t src_id = entry->src_id;
>>>
>>>      if (client_id == AMDGPU_IRQ_CLIENTID_LEGACY) {
>>>              if (src_id ==
>> VISLANDS30_IV_SRCID_CG_TSS_THERMAL_LOW_TO_HIGH) {
>>> -                   dev_emerg(adev->dev, "ERROR: GPU over
>> temperature range(SW CTF) detected!\n");
>>> -                   /*
>>> -                    * SW CTF just occurred.
>>> -                    * Try to do a graceful shutdown to prevent further
>> damage.
>>> -                    */
>>> -                   dev_emerg(adev->dev, "ERROR: System is going to
>> shutdown due to GPU SW CTF!\n");
>>> -                   orderly_poweroff(true);
>>> -           } else if (src_id ==
>> VISLANDS30_IV_SRCID_CG_TSS_THERMAL_HIGH_TO_LOW)
>>> +                   schedule_delayed_work(&hwmgr-
>>> swctf_delayed_work,
>>> +
>> msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
>>> +           } else if (src_id ==
>>> +VISLANDS30_IV_SRCID_CG_TSS_THERMAL_HIGH_TO_LOW) {
>>>                      dev_emerg(adev->dev, "ERROR: GPU under
>> temperature range detected!\n");
>>> -           else if (src_id == VISLANDS30_IV_SRCID_GPIO_19) {
>>> +           } else if (src_id == VISLANDS30_IV_SRCID_GPIO_19) {
>>>                      dev_emerg(adev->dev, "ERROR: GPU HW Critical
>> Temperature Fault(aka CTF) detected!\n");
>>>                      /*
>>>                       * HW CTF just occurred. Shutdown to prevent further
>> damage.
>>> @@ -626,15 +622,10 @@ int phm_irq_process(struct amdgpu_device
>> *adev,
>>>                      orderly_poweroff(true);
>>>              }
>>>      } else if (client_id == SOC15_IH_CLIENTID_THM) {
>>> -           if (src_id == 0) {
>>> -                   dev_emerg(adev->dev, "ERROR: GPU over
>> temperature range(SW CTF) detected!\n");
>>> -                   /*
>>> -                    * SW CTF just occurred.
>>> -                    * Try to do a graceful shutdown to prevent further
>> damage.
>>> -                    */
>>> -                   dev_emerg(adev->dev, "ERROR: System is going to
>> shutdown due to GPU SW CTF!\n");
>>> -                   orderly_poweroff(true);
>>> -           } else
>>> +           if (src_id == 0)
>>> +                   schedule_delayed_work(&hwmgr-
>>> swctf_delayed_work,
>>> +
>> msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
>>> +           else
>>>                      dev_emerg(adev->dev, "ERROR: GPU under
>> temperature range detected!\n");
>>>      } else if (client_id == SOC15_IH_CLIENTID_ROM_SMUIO) {
>>>              dev_emerg(adev->dev, "ERROR: GPU HW Critical Temperature
>> Fault(aka
>>> CTF) detected!\n"); diff --git
>>> a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>> b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>> index f1580a26a850..612d66aeaab9 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
>>> @@ -811,6 +811,8 @@ struct pp_hwmgr {
>>>      bool gfxoff_state_changed_by_workload;
>>>      uint32_t pstate_sclk_peak;
>>>      uint32_t pstate_mclk_peak;
>>> +
>>> +   struct delayed_work swctf_delayed_work;
>>>    };
>>>
>>>    int hwmgr_early_init(struct pp_hwmgr *hwmgr); diff --git
>>> a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index 2aecb8faf407..4062b9b46986 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -24,6 +24,7 @@
>>>
>>>    #include <linux/firmware.h>
>>>    #include <linux/pci.h>
>>> +#include <linux/reboot.h>
>>>
>>>    #include "amdgpu.h"
>>>    #include "amdgpu_smu.h"
>>> @@ -1078,6 +1079,34 @@ static void smu_interrupt_work_fn(struct
>> work_struct *work)
>>>              smu->ppt_funcs->interrupt_work(smu);
>>>    }
>>>
>>> +static void smu_swctf_delayed_work_handler(struct work_struct *work)
>>> +{
>>> +   struct smu_context *smu =
>>> +           container_of(work, struct smu_context,
>> swctf_delayed_work.work);
>>> +   struct smu_temperature_range *range =
>>> +                           &smu->thermal_range;
>>> +   struct amdgpu_device *adev = smu->adev;
>>> +   uint32_t hotspot_tmp, size;
>>> +
>>> +   /*
>>> +    * If the hotspot temperature is confirmed as below SW CTF setting
>> point
>>> +    * after the delay enforced, nothing will be done.
>>> +    * Otherwise, a graceful shutdown will be performed to prevent
>> further damage.
>>> +    */
>>> +   if (range->software_shutdown_temp &&
>>> +       smu->ppt_funcs->read_sensor &&
>>> +       !smu->ppt_funcs->read_sensor(smu,
>>> +
>> AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
>>> +                                    &hotspot_tmp,
>>> +                                    &size) &&
>>> +       hotspot_tmp / 1000 < range->software_shutdown_temp)
>>> +           return;
>>> +
>>> +   dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW
>> CTF) detected!\n");
>>> +   dev_emerg(adev->dev, "ERROR: System is going to shutdown due to
>> GPU SW CTF!\n");
>>> +   orderly_poweroff(true);
>>> +}
>>> +
>>>    static int smu_sw_init(void *handle)
>>>    {
>>>      struct amdgpu_device *adev = (struct amdgpu_device *)handle; @@
>>> -1120,6 +1149,9 @@ static int smu_sw_init(void *handle)
>>>      smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
>>>      smu->smu_dpm.requested_dpm_level =
>> AMD_DPM_FORCED_LEVEL_AUTO;
>>>
>>> +   INIT_DELAYED_WORK(&smu->swctf_delayed_work,
>>> +                     smu_swctf_delayed_work_handler);
>>> +
>>>      ret = smu_smc_table_sw_init(smu);
>>>      if (ret) {
>>>              dev_err(adev->dev, "Failed to sw init smc table!\n"); @@ -
>> 1600,6
>>> +1632,8 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
>>>              return ret;
>>>      }
>>>
>>> +   cancel_delayed_work_sync(&smu->swctf_delayed_work);
>>> +
>>>      ret = smu_disable_dpms(smu);
>>>      if (ret) {
>>>              dev_err(adev->dev, "Fail to disable dpm features!\n"); diff --git
>>> a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> index 4ce394903c07..18101ec0ae6e 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> @@ -573,6 +573,8 @@ struct smu_context
>>>      u32 debug_param_reg;
>>>      u32 debug_msg_reg;
>>>      u32 debug_resp_reg;
>>> +
>>> +   struct delayed_work             swctf_delayed_work;
>>>    };
>>>
>>>    struct i2c_adapter;
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> index e1ef88ee1ed3..aa4a5498a12f 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> @@ -1412,13 +1412,8 @@ static int smu_v11_0_irq_process(struct
>> amdgpu_device *adev,
>>>      if (client_id == SOC15_IH_CLIENTID_THM) {
>>>              switch (src_id) {
>>>              case THM_11_0__SRCID__THM_DIG_THERM_L2H:
>>> -                   dev_emerg(adev->dev, "ERROR: GPU over
>> temperature range(SW CTF) detected!\n");
>>> -                   /*
>>> -                    * SW CTF just occurred.
>>> -                    * Try to do a graceful shutdown to prevent further
>> damage.
>>> -                    */
>>> -                   dev_emerg(adev->dev, "ERROR: System is going to
>> shutdown due to GPU SW CTF!\n");
>>> -                   orderly_poweroff(true);
>>> +                   schedule_delayed_work(&smu->swctf_delayed_work,
>>> +
>> msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
>>>              break;
>>>              case THM_11_0__SRCID__THM_DIG_THERM_H2L:
>>>                      dev_emerg(adev->dev, "ERROR: GPU under
>> temperature range
>>> detected\n"); diff --git
>>> a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> index 9e8414037638..4071bfa38727 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> @@ -1353,13 +1353,8 @@ static int smu_v13_0_irq_process(struct
>> amdgpu_device *adev,
>>>      if (client_id == SOC15_IH_CLIENTID_THM) {
>>>              switch (src_id) {
>>>              case THM_11_0__SRCID__THM_DIG_THERM_L2H:
>>> -                   dev_emerg(adev->dev, "ERROR: GPU over
>> temperature range(SW CTF) detected!\n");
>>> -                   /*
>>> -                    * SW CTF just occurred.
>>> -                    * Try to do a graceful shutdown to prevent further
>> damage.
>>> -                    */
>>> -                   dev_emerg(adev->dev, "ERROR: System is going to
>> shutdown due to GPU SW CTF!\n");
>>> -                   orderly_poweroff(true);
>>> +                   schedule_delayed_work(&smu->swctf_delayed_work,
>>> +
>> msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
>>>                      break;
>>>              case THM_11_0__SRCID__THM_DIG_THERM_H2L:
>>>                      dev_emerg(adev->dev, "ERROR: GPU under
>> temperature range
>>> detected\n");
