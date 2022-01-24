Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E08EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 16:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECDFA10E320;
	Mon, 24 Jan 2022 16:50:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAEE810E320
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 16:50:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABHynv3EzTj+bLtckAr8VRnlTqtBRabDPn0MqwO9GGEm7iveQZx1GhFKexT/+wwbLDBd0+t4LtZO5X/KOA3ZDcqfKLKkAJxK5H+iTuOalWJGcZN5yTE+2HpLJu1eXw36uOPktt0MysaFm56yGdl6uZ+BZN/TAmmJgHnwKk0g/mDcZyjM3XJ3ktVnO501wol3ibRHlheFhNMuzQHDpOMnEzp2aFiIsNZjpzUAZ8l6Km3vzghEFbrxEqvAjZM3xKJ17c1p+ymsLqb5eXQIt4UWbhiugLHBkV5iM0T17tmmV4YRxAEAt34NPrnCyKNz2v+Qxf1OCiNOAHnHpcnQ7UynlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dz2dSmrMfznaXw08aEskjlOlITIJ3K37Bll7yiKZc88=;
 b=SiThz2NLgmTtrYK/qgpwnDkQSbW5Lo+kQNh2HZuNvi8Lyxn5lKkMDfzi2qaFYMiT9x0jEzIb4zYzGKgXn3Hds5d/9QDtwt/fRFEUThYW/jqAP15STjAsVPWzaRT+C/CENGVf9p+izxltA5d1nasphF/cwU9PQuXcovVq1Y0XQB8ewbyodbr45hHwPhjVpDMYAPAFCdpggjcH/ldNka65clUPa9KY2Ii/juBPXN11FURf9z+CRoGUVScm5u/uypYL7Bn2OYcLpaIVlFg25HIHVa/OgSI6vIPv1ujN/dIuW5UrCmlhaUVfpoh/g0ye1q0c2uxvwd96WTAcM9UH+fshNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dz2dSmrMfznaXw08aEskjlOlITIJ3K37Bll7yiKZc88=;
 b=n8uDk1Zr+PUCWz08ch+wOgfvMa8GoNr40gj57m0gBbQUaH/+d9pUcgcsmiL9JWqfyzNYDEKga0jB26YXvsHGAgKm8/CmnMRyWWIrJukDZzJwNBJ4SczJZyF/RlX3tagq372Zj5E+f61gKexRbbepOLF0tWf8xhWiz2maD6ttIEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 16:50:03 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 16:50:02 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu: add work function for GPU reset
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <b951f172-45f4-c88d-6655-8eec715c038c@amd.com>
 <5d71f21b-39fb-90f6-226b-fd5dd46ce010@amd.com>
 <88476e37-5069-867b-1192-022e8aa02162@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <47fd2dd5-6e3e-69d8-f01b-a2255f8159cc@amd.com>
Date: Mon, 24 Jan 2022 17:49:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <88476e37-5069-867b-1192-022e8aa02162@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6P192CA0043.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad2e9f1d-bea1-4342-1dbf-08d9df5990f8
X-MS-TrafficTypeDiagnostic: CH0PR12MB5372:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5372D1C497271E62620DCEDD835E9@CH0PR12MB5372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v07KEe/mphospMQGq1KBlntykngmO3wNfNkbGOWl5uB3BsK+vmAae1dNc9yWIDGxWPRDdQE06UayRQtSE3Xf1q/aUAj7WcSX3YGi0DJyCJJT3U3kOZfdz0adsyCWBJQOep8/IQvLp8J1Lkz7rWQqCN9dTE7mwrm+75+upzDdvU4IyVUJlM5zcUDyHzlfbEopq5HrjYrYHVwsb15aUGY2QJJdfMW4OZ62+fLlCc2LVGGapJAs1bqhyePXBaWx05pOY723uIT/Qh7nOpbzO+bvu0cLmuBdDRO/UsGUh2OWlNbAXwax/znWy8k68KPpT0BjKchTkA/hFl9DYjC74+9UQEZsoZsbkXUkgnVO5/2bZR+T9snrONv6iVaYS8bkoo9dXf82nixtmxiPxh0u8sA4GgoTd+Cw6snLbfICPL7KLcFww2o4MAmu47rCWDU7tY/KjJpIYy0nUBnAEn+FnIdN5SWcL2+td794tUTX9BoBFeapZX1P4BuMf9hIahOiD8gzrTpQPwjl/qCysG7tkSsk7bB5/jhtJwa+/UBTooMK3mvDQ5YgFbzJ38qf3pWHfZuIkqnMUUVz2Mu7nnAZWI80aQbmqY8NA/vDKo1Zwp3MX/qnjpzJJrQs3q+IWzQOap1cbpnC9nZ+3qkZRsvHPWeJDgOZ9fRiZMDNSW4JIwlKqpuDan3IIYH1wpFaIY1o1lcLrcR50huFiB9Then72IY/g8TdT6rkFPl5TMxEUvTqmDRvzkyLKEbhkpfquL9foAST
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(38100700002)(110136005)(6506007)(31686004)(5660300002)(186003)(31696002)(66556008)(66476007)(6512007)(2616005)(2906002)(4326008)(8936002)(6486002)(36756003)(508600001)(54906003)(6666004)(86362001)(53546011)(8676002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3NaZS96c3N1ZlM1aEV5T3N5SVNEa1hEaWQ2bVZKSkNLemlJVWFZbEh0MHMx?=
 =?utf-8?B?Zit1OXZpKzVyc2VRSnNxbXM2YTFCT2ZkdjFJMERjVlNmL0pLMW82d095ZnNS?=
 =?utf-8?B?N1krL1FVdURCYzVjanVEUVBaemhvNEdhTnpCYmI5RzRjVFBJbmcxaURYdEIz?=
 =?utf-8?B?cWNOTEI4Sld1a3VDS2JLM1lIaGJud1Fzck5TUnlKNFpWOS9ZQkYrQ0JWaVhH?=
 =?utf-8?B?LzcrcUxjU05wd2tGdzVObkRYVXBYSVJhTldPYmNIQnJpdkowLzR1U1VvZlpm?=
 =?utf-8?B?OVlGTkpTamVxMElVZ01xNGx1aGh3UGZ5bUdGelBDcU5WdU1sMlpTejFEa24y?=
 =?utf-8?B?eXExTzU2ZzdWODAxOE5MamppN25XeWZXRlB5dUZjWEhCUEM4TW44dDFUOTdQ?=
 =?utf-8?B?T1lzUXFpZ01GWElPRk9pYTRCbEwyQU11TkhYSHJyNEkrZnk0ZXlMMlJFMXJY?=
 =?utf-8?B?cDFLdlpFWThaU2FkaWxPdThFMzhkYkhIR29KOVk0VFk1bjI2SUt2Y05TM3cr?=
 =?utf-8?B?Yy9aNEtZK3lUSkxqaXpHQms1UEU4MWIwRE5Pb01KaG5YV2NOZzJqSXB0dVpK?=
 =?utf-8?B?WDVic21yeUszVTB2VElVSSt3TjVYekc3STRsbnBCZU4rM1orWjZsTllIUzdW?=
 =?utf-8?B?M0d1ZHo5ZUw3VXI2L3V2THJBL0hKUERsc3A4OE5SQkRpMDRxY3E4Qm1uRTJS?=
 =?utf-8?B?YVhFU25PaEJnU0wyZUd3cWREcHpWZU9LWmcxVEFPU0ppTFVpSnVyU2xUTllM?=
 =?utf-8?B?NlVqZElpM1U2OExzNFlxOWRYekNKdm92NGNHWktiT0xkNW9MU3Fpd0IwbTlY?=
 =?utf-8?B?SmE3cTVEUTNQaDFTV0tmTjdVU1VhazJic1R3cU83NnZ2S1FJczJpcjA5S0Fq?=
 =?utf-8?B?YmlLcEhScWI2UElLNXVnbnVVZVVHblNXUWtrTTFrb3NaQ2pYdStqNWxpMU9w?=
 =?utf-8?B?K1BjVnpIc0JUaGRRTi95VjJZTEtWeGtyWERDdWQzR2tYV1dmTS9aVU8wSXg4?=
 =?utf-8?B?TDg2Q3hOZE1jdTYydkFNcFl1VFBGWkRlZUJoSWtIbTYwY2xOclBsRVdiZWc1?=
 =?utf-8?B?aG9aZGRtMlRxejJJMGxCZzM4VmZaOVNNL0ZScDA3dlZzODNaa2N5aDBiM0kz?=
 =?utf-8?B?TWRreXZCcDVFZDY4Q3lSWGQyUkRCajV3eFA3VEdHMThsMlpwZW1qQVROOG04?=
 =?utf-8?B?amdKdXZDdEtVZHUxdUVueGxsSVBGaGl2d1V3UjRGOXRBd3lDWk9weFBlWUEv?=
 =?utf-8?B?SHRTQTJOQU05Y2gyYStJVHp5NHFoWTdsYWdST0VtODhqWEpNVTlyeFVXeTVV?=
 =?utf-8?B?djJaR3BmU09YeEczT2xPRHJJUFgrelI2T0Ivc3Nxa0UxZGVjWm5sQXZscVdF?=
 =?utf-8?B?MzVwbU4zK1JaUTQrN05GUzViRk43QnYwdmlZZHpnek9LU0tYb2JueVpKZy92?=
 =?utf-8?B?ZnlUelkzdjVXTTdOOUFSVEl3UnhZRjZBMVF5OFhGaWk5SXhTMVAvWFNudzNv?=
 =?utf-8?B?ZlJtdHpsTlNOUzJLMTBJdXcvY1o3VGRqajdSNzBud2xNTlhtY2lod3NvSzNP?=
 =?utf-8?B?SzZYSTBXUkowY0N0aFIyQWJ6cUFCUUxZYnhWeWp4UU0wdzh0aXRGMXpnQlR3?=
 =?utf-8?B?ZEF1K2M0VlBWSGZCZG5MZ0s0ek92Vkd4VXMvUTRCNnE2L1pMN29telJWR3Ay?=
 =?utf-8?B?Q3I5ZkdtdUtLUkhIZm5pQmtsOTRJSVhBNHJXYmFnVHp6QzdQa1REUE1kUDc0?=
 =?utf-8?B?Ukgyclg3R0tDNlZEOWlKY0pOdlVkRkhMN3RNS1BkbGJTa1pOVnJCckNuUkRv?=
 =?utf-8?B?MnBqUWxlTWxWWWw3SkxTQjl2d3hNazFxSnA2R0JVU04yK2tLalFYWjQzenBB?=
 =?utf-8?B?Y2l0Y2RQU2p4ZTRENEJucmQ2VUZ5QU1uVzlJemJDbWtlOG9Ec2pUeWxLT1Fl?=
 =?utf-8?B?VFErbE1sVmZxbkFvY3BxTnRXcG1UUmltRGxIUm9MMU8rWVNVWGpGTkczclkr?=
 =?utf-8?B?dS9oV3RXYzhJK0lCaTJ2WlpEVmNTajUzU1loM3NSd25IcjhwQnYzdTVMbE1h?=
 =?utf-8?B?ck5NdU1hd0ZJS21ka1BuOUdsYmI4STc5RjloYlkwMkFMR3kxQnNaVFpYcTZK?=
 =?utf-8?B?NGdDQlhFTmVGTHpqTnRoODl3QVVaNkJlMnQyNEduTkNlNGVydkYxS3ozVVh6?=
 =?utf-8?Q?JeL0steAzd8DZzQcAI5+ago=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2e9f1d-bea1-4342-1dbf-08d9df5990f8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 16:50:02.7680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dg2nnvEYYVU1UlzsPzTdlpqWSE8WNC4m1MewkmB1f+WCPkhlbz34otV8t7PTrYnZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5372
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
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 24.01.22 um 17:46 schrieb Sharma, Shashank:
>
>
> On 1/24/2022 8:17 AM, Christian König wrote:
>> Am 21.01.22 um 21:37 schrieb Sharma, Shashank:
>>> From c598dd586dd15fc5ae0a883a2e6f4094ec024085 Mon Sep 17 00:00:00 2001
>>> From: Shashank Sharma <shashank.sharma@amd.com>
>>> Date: Fri, 21 Jan 2022 17:33:10 +0100
>>> Subject: [PATCH 2/4] drm/amdgpu: add work function for GPU reset
>>>
>>> This patch adds a new work function, which will get scheduled
>>> in event of a GPU reset, and will send a uevent to indicate the same.
>>> The userspace can do some post-processing work like collecting data
>>> from a trace event.
>>>
>>> Cc: Alexander Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++++++++
>>>  2 files changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 269437b01328..79192f43bb71 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1057,6 +1057,8 @@ struct amdgpu_device {
>>>      struct work_struct        xgmi_reset_work;
>>>      struct list_head        reset_list;
>>>
>>> +    struct work_struct        gpu_reset_work;
>>
>> This needs a different name. "gpu_reset_work" would indicate that it 
>> does the GPU reset, but this really only signals the reset to userspace.
>>
> Agree, let me come back with something like gpu_reset_housekeeping or 
> something less weird that that :)

How about send_gpu_reset_signal ?

Christian.

>
>> Christian.
>>
>>> +
>>>      long                gfx_timeout;
>>>      long                sdma_timeout;
>>>      long                video_timeout;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index af9bdf16eefd..e29e58240869 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -72,6 +72,7 @@
>>>  #include <linux/pm_runtime.h>
>>>
>>>  #include <drm/drm_drv.h>
>>> +#include <drm/drm_sysfs.h>
>>>
>>>  MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>>  MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>>> @@ -3274,6 +3275,18 @@ bool amdgpu_device_has_dc_support(struct 
>>> amdgpu_device *adev)
>>>      return amdgpu_device_asic_has_dc_support(adev->asic_type);
>>>  }
>>>
>>> +static void amdgpu_device_gpu_reset_func(struct work_struct *__work)
>>> +{
>>> +    struct amdgpu_device *adev =
>>> +        container_of(__work, struct amdgpu_device, gpu_reset_work);
>>> +
>>> +    /*
>>> +     * Inform userspace that a GPU reset happened, and it should 
>>> collect
>>> +     * data from the trace event.
>>> +     */
>>> +    drm_sysfs_gpu_reset_event(&adev->ddev);
>>> +}
>>> +
>>>  static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>>>  {
>>>      struct amdgpu_device *adev =
>>> @@ -3506,6 +3519,7 @@ int amdgpu_device_init(struct amdgpu_device 
>>> *adev,
>>>                amdgpu_device_delay_enable_gfx_off);
>>>
>>>      INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
>>> +    INIT_WORK(&adev->gpu_reset_work, amdgpu_device_gpu_reset_func);
>>>
>>>      adev->gfx.gfx_off_req_count = 1;
>>>      adev->pm.ac_power = power_supply_is_system_supplied() > 0;
>>

