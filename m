Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2078C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 10:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4368510EDA2;
	Tue, 11 Jan 2022 10:53:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD09910EDA2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 10:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLiL02ELQDr76nQv6TT8MitcY+oXEU01GLq7pJbj8KRUPvFM2upamCDPO9GTGuCaqdqFJotnPdX3rQ715HS1uczqpnnNj4LKEtQBYDgzUtYKHwkSZta96Zld6zIPXjAgRQZMyZ4vRbKbsBbkDlg1Rdgua84uQNwjaC7pdiTIROhULS0hM1zQm9aEIslk3Or3lPWFy9xrdPWKQInvOAlfUonT4tpqn/cBt1fX9tOl7Ilgi5LaDd2Z8qPpwAZcVkhR0fAi0KW2CcjtBl6xy/4HriCvlZEZAETo4MFAd5gE7Cfcsy48/QhJuvNpKX28Ze6N8GHv4JUOAAIMWAdgsxyYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fwf9wE8lRTmtxjBVr97iWOe0EGJfAgqLiOiJTAsKmSs=;
 b=SW08kYRyGg3XyYabE/Fb4oeRTGA//3uhxIqLfSBza5gho601/t9hffOR4ruaXtjfIPMrfXYJJxhLjORCtI9CFEXwwLHSeuUMTc36uOAQAqe0OABgrLONNt1v8UiZIzPhRzMgSQBU5NXbF6zEqnkl/BkrAXyvSnw3J9osfydhdmbgXBJe2CRHN9JXE6ymg86VPhvgHtc/Ybqo5pRg38xNGKk5IL0sdSqjLUQEdkclFV9EbS+Ux2LnYAA7wytwPbolb3LgTO54SmejPFTsNytJwZX3hD4pvXYYPQQxG0aFZzEU8B5TDnf6GIdsFYsQg51h4rq5jluqMv0Gxi2S6llx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fwf9wE8lRTmtxjBVr97iWOe0EGJfAgqLiOiJTAsKmSs=;
 b=A/+hgsoi2yGRLe1WJcxTihmdoMWrKKp+rJssXjf9PL5FUDZ6FSQvKs0h4o9jxwvOMX+s+4REevWXg2+4oiJoA/oyKcRziiJ3KDpnEpjZDT7Es/kALWpG/o3Wf+/3vJrHEtW2jL0HthEJASip6aQWdQNN/jyzzYZWFrnR7pume3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB3493.namprd12.prod.outlook.com (2603:10b6:a03:dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 10:53:04 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 10:53:03 +0000
Message-ID: <499e235b-462f-4659-1da9-6378194e6a16@amd.com>
Date: Tue, 11 Jan 2022 16:22:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: correct the checks for fan attributes support
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220111074729.40906-1-evan.quan@amd.com>
 <529cd021-7342-8efb-b1bc-266bbf0fee88@amd.com>
 <DM6PR12MB2619BAB036BE8B2825D89C8AE4519@DM6PR12MB2619.namprd12.prod.outlook.com>
 <4ccb0507-cb69-cc15-7610-801837df8589@amd.com>
 <DM6PR12MB26190CF245005F4B8F9FB9AFE4519@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB26190CF245005F4B8F9FB9AFE4519@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::21) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2763b732-0a13-404f-6f0d-08d9d4f08a70
X-MS-TrafficTypeDiagnostic: BYAPR12MB3493:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB34937AB6950148F421A43E1897519@BYAPR12MB3493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYo0YEpv/K6kQzr5CvmtR/JFEdVB7ajg+EW1DxhuWdCQkA5j3fOe7DIlc0bJt45kkFXUrY5CP0SOXNP41nNlo2Vc9whyZJ1H1u+8zflzw/mZ3KAZw6KKrc9yEHPFEhivVGTHugcIgn3x7YWAIotdGLIfaENpnur5OwI5ylNHNYomTB/rPgHoabnJf279JgZgUiozJrZzgLMdPomYXV2hK23ZkdqKuD0oMOnIyXzeRsxzWPNGF/vDk0oodWRvSuZA4/Tji2XZHHGCajaqC8/NYpTAx8aqxnoSHVSiR+ApaylGMUKI9BR4rokPvo5eM1hm06retmdrvm5D/plykNli65AJGdq10VxYsF1sfNip8aqQCxq5/uVDoZjvK9EFbAa8henazvDxUk3TG+7ICf1PTpTX5+CHd2Bv5z9qj65/7ZvRxoJy5aDszBDMzFJEgkRag+fdB3BoTvUmBFSg9y6xax9YR3xvIYAa7FYiP+qw4bXtXNZaeJNGT3SdccRXL7YQGaVtaA7/UI7GNd5XiTXE+WnFEKSUF0W9up0TPUhxUoYjVBCHsQ0h6kY+kHZc/vTyDgMzxHeHNVresft8WA96A/vVmcTWjAfhEDqFMFP06pyCcVnwaRvBF0c03+i9zILC/6wbtqh79R7Wp6DExgdqaj6B2LAh3y8gQDxMr2X6CQfpdmBMewRiW4K/FZF3nWcDlFMk1AxFoBDavLilrU/FBRpBYio7f2GiaQzhDeduUXmtlicZ4/JUm+qp8yBz7eZu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(8936002)(8676002)(316002)(2616005)(36756003)(86362001)(110136005)(53546011)(6512007)(6506007)(4326008)(26005)(54906003)(186003)(31696002)(6666004)(83380400001)(6486002)(30864003)(5660300002)(66556008)(66476007)(66946007)(2906002)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNQZlFUb2EzampXR0VUOWxpMlJ2SDgyQkJQNkw3Vks4SzZseWlZVjFjMGFL?=
 =?utf-8?B?ZE1CeEhSZCtjY2UzS2g3bzdsWGJjM1lkWnVKVkJTV2srK2IvdzB2WnE3dlcr?=
 =?utf-8?B?UXdJaDJYZGxyZzdCQVVJNVZpSFUvMGlIV3QydlB0ZUdJbjcyMEc1UFp6bkRH?=
 =?utf-8?B?a2NMdXExMEMvVDFqQjJ4WDR4UUVCcjI3a21idWNyajlsZ1pZd2I4LzZ0ZGNP?=
 =?utf-8?B?SVIyV2tnRmxrNXZRQzlDYUVPb1hSSUhuaWx3VjhhbURNS1k5d0t2RWVCVzRB?=
 =?utf-8?B?d215N1YwUVY1MElqeEFFUUphRXVaaFNRa3ZnRHJNbVVhR0lkdm9QMWUvTzgv?=
 =?utf-8?B?TUxsSlBQWWQxaVRCU2J0ZUlRYnpvOXEzMkRJVU5VVmZjNTJPWjFNTno5Q1dm?=
 =?utf-8?B?d3Nna3ZXdEpjR2ExR1ZCcWNMb1lnQWhaV2dhaWpMN2ttakhMUElabEtxVWtl?=
 =?utf-8?B?S2xqbzBvZmdzZXVLN1pWK0Jvd09kbENBWnBxcVdmdWFwaHFQTW9KN3hwUkNw?=
 =?utf-8?B?MWFYYy9TVk9TZlNTZG5hZU1IcW5hdVAyNlppenV3TDVna0tmRGFoTWxtQ1Ny?=
 =?utf-8?B?OExFVDF6akowSGx6bTliUmVWU0h2MUIwYnpnSzEyYlp6dk5YQ1pnRXllbzM3?=
 =?utf-8?B?aDdCbFhRT1AxRXN3V24zVmVOa2Z5Q2Q0L3IzMFkzNFErNDFtQ0ZNNEVRYXVi?=
 =?utf-8?B?bWdMekZMaUwvQnRNNFIybmhZOVN6MGJkdGpXaUlsN3ptM1hxK21tbmVUZGZ0?=
 =?utf-8?B?T1kvS2lOVnUwZmNEOGJGczJNWENITHM5WjU2MW1xQXpKUHA2cjUyZm9HMHlO?=
 =?utf-8?B?NkVmZVRLZEZicjhxS1hpUmZ3bVdoQ1JQaXpwZWV6a1JtZjU3VUJkYTJ0UGlU?=
 =?utf-8?B?SkVaM0N4N0xmcDV1bm9FckNqdCs4UENadVlldGp2ZFA1TVhrc2FiZGVIRXVM?=
 =?utf-8?B?bHZUMkgvbGErYmJuRmpUZUxRVFRyNVZ4clpZUHpuRlVHZXhESjNtemhWajlj?=
 =?utf-8?B?QTI2Zk8yZmJWNFdBK2FibjM4YU9sZ2pzaDVYdFpCVlUwVFpUREpuSWNOWlpo?=
 =?utf-8?B?T3hCRXNYS21DaitJcmNiclRVWW1aS2c0cmtrRU01Zk9jWXNyZWtJSFJtZVNh?=
 =?utf-8?B?NXdJSm9iOTVyNWxWTjU0SzY3cDM4VzdsQ0xCcThPZFFHMWpyZHFLMnNsNzBB?=
 =?utf-8?B?L3BOYjdoMFZRcUVSNldqZkloQ2RMc1pMS0UyUFMzV0hPdmFBOE5qdm1nbmg3?=
 =?utf-8?B?QytFL2VPem1EbnpxZzlRMVBYZU12UmhGNkdpQkRqOVFUUzlwWXVrdmNjOGdv?=
 =?utf-8?B?L1BhT2dadytxcmtCOTExYXdKaDlOOHVFb3BNYVBPSjY0Tzd5T2tXNlVxV0VC?=
 =?utf-8?B?YndKWXlMM2VXc2ZVNldPUVIzSi9CRXRRWkIwSnZIYmFkOVZaeUhlS1ZtR3NT?=
 =?utf-8?B?cTlOY3ZITkFxdDZXTlJOYXlCMlNxVGl4UTNjc21LL2VQanNXa2hFVzhESEpt?=
 =?utf-8?B?bTI5Zk5veFh3RzBmRlVDKzZva01SNVB3U05Ua2M0MVIzV2JmVTdJOC9KUWpa?=
 =?utf-8?B?L0dIUUdmVmdyMVhjZXVWZTNnMzZ3ZmozWS8zcmRaOG8wOWlOTDliS2NQcjhq?=
 =?utf-8?B?M0RmelQwUFZHKzFqRjZXaUJtNmh3UXQvL09zSGlSZ05pWTZrbFowbHhidFhQ?=
 =?utf-8?B?SnhuVDRwR2hZelFrZWp5clJzNU5OR3B3cmovRFFqRGZhOVZRbzN2VFphOXJX?=
 =?utf-8?B?aG9WaXQwTDFhNmFQWFNHSGRkMlNQTXVqa0hBQTZLQ0FwZFdvRWsvNHZDQ3lK?=
 =?utf-8?B?SnBjTXI3elQ2MVNGUnF2dmtvcHJodTFMK1NJeHR5cVJXcWUzVWF2dWhTaENQ?=
 =?utf-8?B?VGRqZ3NENVpYU3ZqaW83cTUyRERXWXFwRGhYVWlBUzNtSnRuR3o0WHpnQUJN?=
 =?utf-8?B?U3J0Mlp2WVN0MExUK0MxN0VMSndQdUJMdmxVTVN3TTZQNno0eHFjcG14Tllq?=
 =?utf-8?B?TE9JQ1hzQjcyZ2VmTHVWZlVLMjliYUhYZW5mYjZsQjZ0NkdOYVF3cUNvdlZ6?=
 =?utf-8?B?L0VRUTU1UkgxYWZLTjdiQ3V0YmRXTExiRHVoRklMQVdpNFVpQ1VEeTNSZVhH?=
 =?utf-8?Q?WzKQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2763b732-0a13-404f-6f0d-08d9d4f08a70
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 10:53:03.4811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X12ibbi89Hep06t41Q+67g0bRdcng9PwWyHgJb8urPMFZ7dFzVS49gh4MyvUqwJ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3493
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/11/2022 4:12 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, January 11, 2022 6:15 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
>> <Guchun.Chen@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: correct the checks for fan attributes
>> support
>>
>>
>>
>> On 1/11/2022 3:36 PM, Quan, Evan wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Tuesday, January 11, 2022 4:14 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
>>>> <Guchun.Chen@amd.com>
>>>> Subject: Re: [PATCH] drm/amd/pm: correct the checks for fan
>>>> attributes support
>>>>
>>>>
>>>>
>>>> On 1/11/2022 1:17 PM, Evan Quan wrote:
>>>>> On functionality unsupported, -EOPNOTSUPP will be returned. And we
>>>>> rely on that to determine the fan attributes support.
>>>>>
>>>>> Fixes: 801771de0331 ("drm/amd/pm: do not expose power
>>>> implementation
>>>>> details to
>>>>> amdgpu_pm.c")
>>>>>
>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>> Change-Id: I95e7e0beebd678a446221a72234cd356e14f0fcd
>>>>> ---
>>>>>     .../gpu/drm/amd/include/kgd_pp_interface.h    |   4 +-
>>>>>     drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  31 ++++-
>>>>>     drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  21 ++--
>>>>>     drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  10 +-
>>>>>     .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  59 ++++-----
>>>>>     drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 115
>> +++++++++----
>>>> -----
>>>>>     6 files changed, 132 insertions(+), 108 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>>>> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>>>> index a8eec91c0995..387120099493 100644
>>>>> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>>>> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>>>> @@ -315,8 +315,8 @@ struct amd_pm_funcs {
>>>>>     				void  *rps,
>>>>>     				bool  *equal);
>>>>>     /* export for sysfs */
>>>>> -	void (*set_fan_control_mode)(void *handle, u32 mode);
>>>>> -	u32 (*get_fan_control_mode)(void *handle);
>>>>> +	int (*set_fan_control_mode)(void *handle, u32 mode);
>>>>> +	int (*get_fan_control_mode)(void *handle, u32 *fan_mode);
>>>>>     	int (*set_fan_speed_pwm)(void *handle, u32 speed);
>>>>>     	int (*get_fan_speed_pwm)(void *handle, u32 *speed);
>>>>>     	int (*force_clock_level)(void *handle, enum pp_clock_type type,
>>>>> uint32_t mask); diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> index 68d2e80a673b..fe69785df403 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> @@ -1030,15 +1030,20 @@ int
>>>> amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
>>>>>     				    uint32_t *fan_mode)
>>>>>     {
>>>>>     	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>>> +	int ret = 0;
>>>>>
>>>>>     	if (!pp_funcs->get_fan_control_mode)
>>>>>     		return -EOPNOTSUPP;
>>>>>
>>>>> +	if (!fan_mode)
>>>>> +		return -EINVAL;
>>>>> +
>>>>
>>>> pp_funcs most likely will be there for smu/powerplay subsystem. I
>>>> think the checks should be at one layer down -
>>>> smu_get_fan_control_mode() and
>>>> pp_dpm_get_fan_control_mode()
>>>>
>>>> First one will check if ppt func is implemented and second one will
>>>> check if hwmgr func is implemented for the specific ASIC.
>>> [Quan, Evan] Yes, I agree. And if you go through the changes below, you
>> will see the checks (for the layers down) there.
>>> This patch checks not only those amdgpu_dpm_xxxx APIs, but also those
>> downstream interfaces(smu_xxxx and pp_dpm_xxxx).
>>>
>>
>> Say you call amdgpu_dpm_get_fan_control_mode(adev, NULL) from
>> amdgpu_pm
>>
>> pp_funcs->get_fan_control_mode => this will point to
>> smu_get_fan_control_mode for all swsmu ASICs. So  "if (!pp_funcs-
>>> get_fan_control_mode)" will be false.
>>
>> The next statement is NULL check and it will return -EINVAL.
>>
>> What we want to know is ppt_func is implemented or not for the particualr
>> swsmu ASIC. Isn't that the case or am I reading it differently?
>>
> [Quan, Evan] OK, I get your point now. Hmm, that will be a little tricky.
> I suppose the EINVAL check needs to be dispatched in every instance(pp_dpm_xxxxx, smu_xxxx, si_dpm_xxxx) then. Any better idea?
> 

Yeah, that is what I meant by "checks should be at one layer down".

Thanks,
Lijo

> BR
> Evan
>> Thanks,
>> Lijo
>>
>>> BR
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>     	mutex_lock(&adev->pm.mutex);
>>>>> -	*fan_mode = pp_funcs->get_fan_control_mode(adev-
>>>>> powerplay.pp_handle);
>>>>> +	ret = pp_funcs->get_fan_control_mode(adev-
>>>>> powerplay.pp_handle,
>>>>> +					     fan_mode);
>>>>>     	mutex_unlock(&adev->pm.mutex);
>>>>>
>>>>> -	return 0;
>>>>> +	return ret;
>>>>>     }
>>>>>
>>>>>     int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
>>>> @@
>>>>> -1048,6 +1053,9 @@ int amdgpu_dpm_set_fan_speed_pwm(struct
>>>> amdgpu_device *adev,
>>>>>     	int ret = 0;
>>>>>
>>>>>     	if (!pp_funcs->set_fan_speed_pwm)
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>> +	if (speed == U32_MAX)
>>>>>     		return -EINVAL;
>>>>>
>>>>>     	mutex_lock(&adev->pm.mutex);
>>>>> @@ -1065,6 +1073,9 @@ int amdgpu_dpm_get_fan_speed_pwm(struct
>>>> amdgpu_device *adev,
>>>>>     	int ret = 0;
>>>>>
>>>>>     	if (!pp_funcs->get_fan_speed_pwm)
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>> +	if (!speed)
>>>>>     		return -EINVAL;
>>>>>
>>>>>     	mutex_lock(&adev->pm.mutex);
>>>>> @@ -1082,6 +1093,9 @@ int amdgpu_dpm_get_fan_speed_rpm(struct
>>>> amdgpu_device *adev,
>>>>>     	int ret = 0;
>>>>>
>>>>>     	if (!pp_funcs->get_fan_speed_rpm)
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>> +	if (!speed)
>>>>>     		return -EINVAL;
>>>>>
>>>>>     	mutex_lock(&adev->pm.mutex);
>>>>> @@ -1099,6 +1113,9 @@ int amdgpu_dpm_set_fan_speed_rpm(struct
>>>> amdgpu_device *adev,
>>>>>     	int ret = 0;
>>>>>
>>>>>     	if (!pp_funcs->set_fan_speed_rpm)
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>> +	if (speed == U32_MAX)
>>>>>     		return -EINVAL;
>>>>>
>>>>>     	mutex_lock(&adev->pm.mutex);
>>>>> @@ -1113,16 +1130,20 @@ int
>>>> amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
>>>>>     				    uint32_t mode)
>>>>>     {
>>>>>     	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>>> +	int ret = 0;
>>>>>
>>>>>     	if (!pp_funcs->set_fan_control_mode)
>>>>>     		return -EOPNOTSUPP;
>>>>>
>>>>> +	if (mode == U32_MAX)
>>>>> +		return -EINVAL;
>>>>> +
>>>>>     	mutex_lock(&adev->pm.mutex);
>>>>> -	pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
>>>>> -				       mode);
>>>>> +	ret = pp_funcs->set_fan_control_mode(adev-
>>>>> powerplay.pp_handle,
>>>>> +					     mode);
>>>>>     	mutex_unlock(&adev->pm.mutex);
>>>>>
>>>>> -	return 0;
>>>>> +	return ret;
>>>>>     }
>>>>>
>>>>>     int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev, diff
>>>>> --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>> index d3eab245e0fe..940cbe751163 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>> @@ -3197,7 +3197,6 @@ static umode_t
>> hwmon_attributes_visible(struct
>>>> kobject *kobj,
>>>>>     	struct device *dev = kobj_to_dev(kobj);
>>>>>     	struct amdgpu_device *adev = dev_get_drvdata(dev);
>>>>>     	umode_t effective_mode = attr->mode;
>>>>> -	uint32_t speed = 0;
>>>>>
>>>>>     	/* under multi-vf mode, the hwmon attributes are all not
>>>>> supported
>>>> */
>>>>>     	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>>>> @@
>>>>> -3263,15 +3262,15 @@ static umode_t hwmon_attributes_visible(struct
>>>> kobject *kobj,
>>>>>     		return 0;
>>>>>
>>>>>     	/* mask fan attributes if we have no bindings for this asic to
>>>>> expose
>>>> */
>>>>> -	if (((amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL)
>>>> &&
>>>>> +	if (((amdgpu_dpm_get_fan_speed_pwm(adev, NULL) == -
>>>> EOPNOTSUPP) &&
>>>>>     	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't
>>>>> query
>>>> fan */
>>>>> -	    ((amdgpu_dpm_get_fan_control_mode(adev, &speed) == -
>>>> EOPNOTSUPP) &&
>>>>> +	    ((amdgpu_dpm_get_fan_control_mode(adev, NULL) == -
>>>> EOPNOTSUPP) &&
>>>>>     	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /*
>>>>> can't
>>>> query state */
>>>>>     		effective_mode &= ~S_IRUGO;
>>>>>
>>>>> -	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL)
>>>> &&
>>>>> +	if (((amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) == -
>>>> EOPNOTSUPP) &&
>>>>>     	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't
>>>> manage fan */
>>>>> -	      ((amdgpu_dpm_set_fan_control_mode(adev, speed) == -
>>>> EOPNOTSUPP) &&
>>>>> +	      ((amdgpu_dpm_set_fan_control_mode(adev, U32_MAX) ==
>>>>> +-EOPNOTSUPP) &&
>>>>>     	      attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /*
>>>>> can't
>>>> manage state */
>>>>>     		effective_mode &= ~S_IWUSR;
>>>>>
>>>>> @@ -3291,16 +3290,16 @@ static umode_t
>>>> hwmon_attributes_visible(struct kobject *kobj,
>>>>>     		return 0;
>>>>>
>>>>>     	/* hide max/min values if we can't both query and manage the fan */
>>>>> -	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL)
>>>> &&
>>>>> -	      (amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL)
>>>> &&
>>>>> -	      (amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL)
>>>> &&
>>>>> -	      (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL))
>>>> &&
>>>>> +	if (((amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) == -
>>>> EOPNOTSUPP) &&
>>>>> +	      (amdgpu_dpm_get_fan_speed_pwm(adev, NULL) == -
>>>> EOPNOTSUPP) &&
>>>>> +	      (amdgpu_dpm_set_fan_speed_rpm(adev, U32_MAX) == -
>>>> EOPNOTSUPP) &&
>>>>> +	      (amdgpu_dpm_get_fan_speed_rpm(adev, NULL) == -
>>>> EOPNOTSUPP)) &&
>>>>>     	    (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
>>>>>     	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr))
>>>>>     		return 0;
>>>>>
>>>>> -	if ((amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL)
>>>> &&
>>>>> -	     (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL)
>>>> &&
>>>>> +	if ((amdgpu_dpm_set_fan_speed_rpm(adev, U32_MAX) == -
>>>> EOPNOTSUPP) &&
>>>>> +	     (amdgpu_dpm_get_fan_speed_rpm(adev, NULL) == -
>>>> EOPNOTSUPP) &&
>>>>>     	     (attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
>>>>>     	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr))
>>>>>     		return 0;
>>>>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>>>> index 92b987fb31d4..7677d3a21f8c 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>>>> @@ -6669,7 +6669,7 @@ static int si_dpm_set_fan_speed_pwm(void
>>>> *handle,
>>>>>     	return 0;
>>>>>     }
>>>>>
>>>>> -static void si_dpm_set_fan_control_mode(void *handle, u32 mode)
>>>>> +static int si_dpm_set_fan_control_mode(void *handle, u32 mode)
>>>>>     {
>>>>>     	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>
>>>>> @@ -6685,9 +6685,11 @@ static void
>> si_dpm_set_fan_control_mode(void
>>>> *handle, u32 mode)
>>>>>     		else
>>>>>     			si_fan_ctrl_set_default_mode(adev);
>>>>>     	}
>>>>> +
>>>>> +	return 0;
>>>>>     }
>>>>>
>>>>> -static u32 si_dpm_get_fan_control_mode(void *handle)
>>>>> +static int si_dpm_get_fan_control_mode(void *handle, u32
>> *fan_mode)
>>>>>     {
>>>>>     	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>     	struct si_power_info *si_pi = si_get_pi(adev); @@ -6697,7
>>>>> +6699,9 @@ static u32 si_dpm_get_fan_control_mode(void *handle)
>>>>>     		return 0;
>>>>>
>>>>>     	tmp = RREG32(CG_FDO_CTRL2) & FDO_PWM_MODE_MASK;
>>>>> -	return (tmp >> FDO_PWM_MODE_SHIFT);
>>>>> +	*fan_mode = (tmp >> FDO_PWM_MODE_SHIFT);
>>>>> +
>>>>> +	return 0;
>>>>>     }
>>>>>
>>>>>     #if 0
>>>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>>>> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>>>> index 89341729744d..57bc9405d6a9 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>>>> @@ -488,38 +488,37 @@ static enum amd_pm_state_type
>>>> pp_dpm_get_current_power_state(void *handle)
>>>>>     	return pm_type;
>>>>>     }
>>>>>
>>>>> -static void pp_dpm_set_fan_control_mode(void *handle, uint32_t
>>>>> mode)
>>>>> +static int pp_dpm_set_fan_control_mode(void *handle, uint32_t
>> mode)
>>>>>     {
>>>>>     	struct pp_hwmgr *hwmgr = handle;
>>>>>
>>>>>     	if (!hwmgr || !hwmgr->pm_en)
>>>>> -		return;
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>> +	if (hwmgr->hwmgr_func->set_fan_control_mode == NULL)
>>>>> +		return -EOPNOTSUPP;
>>>>>
>>>>> -	if (hwmgr->hwmgr_func->set_fan_control_mode == NULL) {
>>>>> -		pr_info_ratelimited("%s was not implemented.\n",
>>>> __func__);
>>>>> -		return;
>>>>> -	}
>>>>>     	mutex_lock(&hwmgr->smu_lock);
>>>>>     	hwmgr->hwmgr_func->set_fan_control_mode(hwmgr, mode);
>>>>>     	mutex_unlock(&hwmgr->smu_lock);
>>>>> +
>>>>> +	return 0;
>>>>>     }
>>>>>
>>>>> -static uint32_t pp_dpm_get_fan_control_mode(void *handle)
>>>>> +static int pp_dpm_get_fan_control_mode(void *handle, uint32_t
>>>>> +*fan_mode)
>>>>>     {
>>>>>     	struct pp_hwmgr *hwmgr = handle;
>>>>> -	uint32_t mode = 0;
>>>>>
>>>>>     	if (!hwmgr || !hwmgr->pm_en)
>>>>> -		return 0;
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>> +	if (hwmgr->hwmgr_func->get_fan_control_mode == NULL)
>>>>> +		return -EOPNOTSUPP;
>>>>>
>>>>> -	if (hwmgr->hwmgr_func->get_fan_control_mode == NULL) {
>>>>> -		pr_info_ratelimited("%s was not implemented.\n",
>>>> __func__);
>>>>> -		return 0;
>>>>> -	}
>>>>>     	mutex_lock(&hwmgr->smu_lock);
>>>>> -	mode = hwmgr->hwmgr_func->get_fan_control_mode(hwmgr);
>>>>> +	*fan_mode = hwmgr->hwmgr_func-
>>>>> get_fan_control_mode(hwmgr);
>>>>>     	mutex_unlock(&hwmgr->smu_lock);
>>>>> -	return mode;
>>>>> +	return 0;
>>>>>     }
>>>>>
>>>>>     static int pp_dpm_set_fan_speed_pwm(void *handle, uint32_t speed)
>>>> @@
>>>>> -528,12 +527,11 @@ static int pp_dpm_set_fan_speed_pwm(void
>> *handle,
>>>> uint32_t speed)
>>>>>     	int ret = 0;
>>>>>
>>>>>     	if (!hwmgr || !hwmgr->pm_en)
>>>>> -		return -EINVAL;
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>> +	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL)
>>>>> +		return -EOPNOTSUPP;
>>>>>
>>>>> -	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL) {
>>>>> -		pr_info_ratelimited("%s was not implemented.\n",
>>>> __func__);
>>>>> -		return 0;
>>>>> -	}
>>>>>     	mutex_lock(&hwmgr->smu_lock);
>>>>>     	ret = hwmgr->hwmgr_func->set_fan_speed_pwm(hwmgr, speed);
>>>>>     	mutex_unlock(&hwmgr->smu_lock);
>>>>> @@ -546,12 +544,10 @@ static int pp_dpm_get_fan_speed_pwm(void
>>>> *handle, uint32_t *speed)
>>>>>     	int ret = 0;
>>>>>
>>>>>     	if (!hwmgr || !hwmgr->pm_en)
>>>>> -		return -EINVAL;
>>>>> +		return -EOPNOTSUPP;
>>>>>
>>>>> -	if (hwmgr->hwmgr_func->get_fan_speed_pwm == NULL) {
>>>>> -		pr_info_ratelimited("%s was not implemented.\n",
>>>> __func__);
>>>>> -		return 0;
>>>>> -	}
>>>>> +	if (hwmgr->hwmgr_func->get_fan_speed_pwm == NULL)
>>>>> +		return -EOPNOTSUPP;
>>>>>
>>>>>     	mutex_lock(&hwmgr->smu_lock);
>>>>>     	ret = hwmgr->hwmgr_func->get_fan_speed_pwm(hwmgr, speed);
>>>> @@
>>>>> -565,10 +561,10 @@ static int pp_dpm_get_fan_speed_rpm(void
>> *handle,
>>>> uint32_t *rpm)
>>>>>     	int ret = 0;
>>>>>
>>>>>     	if (!hwmgr || !hwmgr->pm_en)
>>>>> -		return -EINVAL;
>>>>> +		return -EOPNOTSUPP;
>>>>>
>>>>>     	if (hwmgr->hwmgr_func->get_fan_speed_rpm == NULL)
>>>>> -		return -EINVAL;
>>>>> +		return -EOPNOTSUPP;
>>>>>
>>>>>     	mutex_lock(&hwmgr->smu_lock);
>>>>>     	ret = hwmgr->hwmgr_func->get_fan_speed_rpm(hwmgr, rpm);
>>>> @@ -582,12
>>>>> +578,11 @@ static int pp_dpm_set_fan_speed_rpm(void *handle,
>>>> uint32_t rpm)
>>>>>     	int ret = 0;
>>>>>
>>>>>     	if (!hwmgr || !hwmgr->pm_en)
>>>>> -		return -EINVAL;
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>> +	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL)
>>>>> +		return -EOPNOTSUPP;
>>>>>
>>>>> -	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL) {
>>>>> -		pr_info_ratelimited("%s was not implemented.\n",
>>>> __func__);
>>>>> -		return 0;
>>>>> -	}
>>>>>     	mutex_lock(&hwmgr->smu_lock);
>>>>>     	ret = hwmgr->hwmgr_func->set_fan_speed_rpm(hwmgr, rpm);
>>>>>     	mutex_unlock(&hwmgr->smu_lock);
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> index c374c3067496..474f1f04cc96 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> @@ -59,7 +59,7 @@ static int smu_handle_task(struct smu_context
>> *smu,
>>>>>     			   bool lock_needed);
>>>>>     static int smu_reset(struct smu_context *smu);
>>>>>     static int smu_set_fan_speed_pwm(void *handle, u32 speed);
>>>>> -static int smu_set_fan_control_mode(struct smu_context *smu, int
>>>>> value);
>>>>> +static int smu_set_fan_control_mode(void *handle, u32 value);
>>>>>     static int smu_set_power_limit(void *handle, uint32_t limit);
>>>>>     static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
>>>>>     static int smu_set_gfx_cgpg(struct smu_context *smu, bool
>>>>> enabled); @@ -407,7 +407,7 @@ static void
>>>>> smu_restore_dpm_user_profile(struct
>>>> smu_context *smu)
>>>>>     	if (smu->user_dpm_profile.fan_mode ==
>>>> AMD_FAN_CTRL_MANUAL ||
>>>>>     	    smu->user_dpm_profile.fan_mode == AMD_FAN_CTRL_NONE) {
>>>>>     		ret = smu_set_fan_control_mode(smu, smu-
>>>>> user_dpm_profile.fan_mode);
>>>>> -		if (ret) {
>>>>> +		if (ret != -EOPNOTSUPP) {
>>>>>     			smu->user_dpm_profile.fan_speed_pwm = 0;
>>>>>     			smu->user_dpm_profile.fan_speed_rpm = 0;
>>>>>     			smu->user_dpm_profile.fan_mode =
>>>> AMD_FAN_CTRL_AUTO; @@ -416,13
>>>>> +416,13 @@ static void smu_restore_dpm_user_profile(struct
>>>> smu_context
>>>>> *smu)
>>>>>
>>>>>     		if (smu->user_dpm_profile.fan_speed_pwm) {
>>>>>     			ret = smu_set_fan_speed_pwm(smu, smu-
>>>>> user_dpm_profile.fan_speed_pwm);
>>>>> -			if (ret)
>>>>> +			if (ret != -EOPNOTSUPP)
>>>>>     				dev_err(smu->adev->dev, "Failed to set
>>>> manual fan speed in pwm\n");
>>>>>     		}
>>>>>
>>>>>     		if (smu->user_dpm_profile.fan_speed_rpm) {
>>>>>     			ret = smu_set_fan_speed_rpm(smu, smu-
>>>>> user_dpm_profile.fan_speed_rpm);
>>>>> -			if (ret)
>>>>> +			if (ret != -EOPNOTSUPP)
>>>>>     				dev_err(smu->adev->dev, "Failed to set
>>>> manual fan speed in rpm\n");
>>>>>     		}
>>>>>     	}
>>>>> @@ -2218,18 +2218,19 @@ static int smu_set_fan_speed_rpm(void
>>>> *handle, uint32_t speed)
>>>>>     	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>>>>     		return -EOPNOTSUPP;
>>>>>
>>>>> +	if (!smu->ppt_funcs->set_fan_speed_rpm)
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>>     	mutex_lock(&smu->mutex);
>>>>>
>>>>> -	if (smu->ppt_funcs->set_fan_speed_rpm) {
>>>>> -		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
>>>>> -		if (!ret && !(smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>>>> -			smu->user_dpm_profile.flags |=
>>>> SMU_CUSTOM_FAN_SPEED_RPM;
>>>>> -			smu->user_dpm_profile.fan_speed_rpm = speed;
>>>>> +	ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
>>>>> +	if (!ret && !(smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>>>> +		smu->user_dpm_profile.flags |=
>>>> SMU_CUSTOM_FAN_SPEED_RPM;
>>>>> +		smu->user_dpm_profile.fan_speed_rpm = speed;
>>>>>
>>>>> -			/* Override custom PWM setting as they cannot co-
>>>> exist */
>>>>> -			smu->user_dpm_profile.flags &=
>>>> ~SMU_CUSTOM_FAN_SPEED_PWM;
>>>>> -			smu->user_dpm_profile.fan_speed_pwm = 0;
>>>>> -		}
>>>>> +		/* Override custom PWM setting as they cannot co-exist */
>>>>> +		smu->user_dpm_profile.flags &=
>>>> ~SMU_CUSTOM_FAN_SPEED_PWM;
>>>>> +		smu->user_dpm_profile.fan_speed_pwm = 0;
>>>>>     	}
>>>>>
>>>>>     	mutex_unlock(&smu->mutex);
>>>>> @@ -2562,60 +2563,59 @@ static int
>> smu_set_power_profile_mode(void
>>>> *handle,
>>>>>     }
>>>>>
>>>>>
>>>>> -static u32 smu_get_fan_control_mode(void *handle)
>>>>> +static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
>>>>>     {
>>>>>     	struct smu_context *smu = handle;
>>>>> -	u32 ret = 0;
>>>>>
>>>>>     	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>>>> -		return AMD_FAN_CTRL_NONE;
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>> +	if (!smu->ppt_funcs->get_fan_control_mode)
>>>>> +		return -EOPNOTSUPP;
>>>>>
>>>>>     	mutex_lock(&smu->mutex);
>>>>>
>>>>> -	if (smu->ppt_funcs->get_fan_control_mode)
>>>>> -		ret = smu->ppt_funcs->get_fan_control_mode(smu);
>>>>> +	*fan_mode = smu->ppt_funcs->get_fan_control_mode(smu);
>>>>>
>>>>>     	mutex_unlock(&smu->mutex);
>>>>>
>>>>> -	return ret;
>>>>> +	return 0;
>>>>>     }
>>>>>
>>>>> -static int smu_set_fan_control_mode(struct smu_context *smu, int
>>>>> value)
>>>>> +static int smu_set_fan_control_mode(void *handle, u32 value)
>>>>>     {
>>>>> +	struct smu_context *smu = handle;
>>>>>     	int ret = 0;
>>>>>
>>>>>     	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>>>> -		return  -EOPNOTSUPP;
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>> +	if (!smu->ppt_funcs->set_fan_control_mode)
>>>>> +		return -EOPNOTSUPP;
>>>>>
>>>>>     	mutex_lock(&smu->mutex);
>>>>>
>>>>> -	if (smu->ppt_funcs->set_fan_control_mode) {
>>>>> -		ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
>>>>> -		if (!ret && !(smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE))
>>>>> -			smu->user_dpm_profile.fan_mode = value;
>>>>> -	}
>>>>> +	ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
>>>>> +	if (ret)
>>>>> +		goto out;
>>>>>
>>>>> -	mutex_unlock(&smu->mutex);
>>>>> +	if (!(smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>>>> +		smu->user_dpm_profile.fan_mode = value;
>>>>>
>>>>> -	/* reset user dpm fan speed */
>>>>> -	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
>>>>> -			!(smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>>>> -		smu->user_dpm_profile.fan_speed_pwm = 0;
>>>>> -		smu->user_dpm_profile.fan_speed_rpm = 0;
>>>>> -		smu->user_dpm_profile.flags &=
>>>> ~(SMU_CUSTOM_FAN_SPEED_RPM |
>> SMU_CUSTOM_FAN_SPEED_PWM);
>>>>> +		/* reset user dpm fan speed */
>>>>> +		if (value != AMD_FAN_CTRL_MANUAL) {
>>>>> +			smu->user_dpm_profile.fan_speed_pwm = 0;
>>>>> +			smu->user_dpm_profile.fan_speed_rpm = 0;
>>>>> +			smu->user_dpm_profile.flags &=
>>>> ~(SMU_CUSTOM_FAN_SPEED_RPM |
>> SMU_CUSTOM_FAN_SPEED_PWM);
>>>>> +		}
>>>>>     	}
>>>>>
>>>>> -	return ret;
>>>>> -}
>>>>> -
>>>>> -static void smu_pp_set_fan_control_mode(void *handle, u32 value) -{
>>>>> -	struct smu_context *smu = handle;
>>>>> +out:
>>>>> +	mutex_unlock(&smu->mutex);
>>>>>
>>>>> -	smu_set_fan_control_mode(smu, value);
>>>>> +	return ret;
>>>>>     }
>>>>>
>>>>> -
>>>>>     static int smu_get_fan_speed_pwm(void *handle, u32 *speed)
>>>>>     {
>>>>>     	struct smu_context *smu = handle; @@ -2624,10 +2624,12 @@ static
>>>>> int smu_get_fan_speed_pwm(void
>>>> *handle, u32 *speed)
>>>>>     	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>>>>     		return -EOPNOTSUPP;
>>>>>
>>>>> +	if (!smu->ppt_funcs->get_fan_speed_pwm)
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>>     	mutex_lock(&smu->mutex);
>>>>>
>>>>> -	if (smu->ppt_funcs->get_fan_speed_pwm)
>>>>> -		ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
>>>>> +	ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
>>>>>
>>>>>     	mutex_unlock(&smu->mutex);
>>>>>
>>>>> @@ -2642,18 +2644,19 @@ static int smu_set_fan_speed_pwm(void
>>>> *handle, u32 speed)
>>>>>     	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>>>>     		return -EOPNOTSUPP;
>>>>>
>>>>> +	if (!smu->ppt_funcs->set_fan_speed_pwm)
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>>     	mutex_lock(&smu->mutex);
>>>>>
>>>>> -	if (smu->ppt_funcs->set_fan_speed_pwm) {
>>>>> -		ret = smu->ppt_funcs->set_fan_speed_pwm(smu, speed);
>>>>> -		if (!ret && !(smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>>>> -			smu->user_dpm_profile.flags |=
>>>> SMU_CUSTOM_FAN_SPEED_PWM;
>>>>> -			smu->user_dpm_profile.fan_speed_pwm = speed;
>>>>> +	ret = smu->ppt_funcs->set_fan_speed_pwm(smu, speed);
>>>>> +	if (!ret && !(smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>>>> +		smu->user_dpm_profile.flags |=
>>>> SMU_CUSTOM_FAN_SPEED_PWM;
>>>>> +		smu->user_dpm_profile.fan_speed_pwm = speed;
>>>>>
>>>>> -			/* Override custom RPM setting as they cannot co-
>>>> exist */
>>>>> -			smu->user_dpm_profile.flags &=
>>>> ~SMU_CUSTOM_FAN_SPEED_RPM;
>>>>> -			smu->user_dpm_profile.fan_speed_rpm = 0;
>>>>> -		}
>>>>> +		/* Override custom RPM setting as they cannot co-exist */
>>>>> +		smu->user_dpm_profile.flags &=
>>>> ~SMU_CUSTOM_FAN_SPEED_RPM;
>>>>> +		smu->user_dpm_profile.fan_speed_rpm = 0;
>>>>>     	}
>>>>>
>>>>>     	mutex_unlock(&smu->mutex);
>>>>> @@ -2669,10 +2672,12 @@ static int smu_get_fan_speed_rpm(void
>>>> *handle, uint32_t *speed)
>>>>>     	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>>>>     		return -EOPNOTSUPP;
>>>>>
>>>>> +	if (!smu->ppt_funcs->get_fan_speed_rpm)
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>>     	mutex_lock(&smu->mutex);
>>>>>
>>>>> -	if (smu->ppt_funcs->get_fan_speed_rpm)
>>>>> -		ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
>>>>> +	ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
>>>>>
>>>>>     	mutex_unlock(&smu->mutex);
>>>>>
>>>>> @@ -3101,7 +3106,7 @@ static int smu_get_prv_buffer_details(void
>>>>> *handle, void **addr, size_t *size)
>>>>>
>>>>>     static const struct amd_pm_funcs swsmu_pm_funcs = {
>>>>>     	/* export for sysfs */
>>>>> -	.set_fan_control_mode    = smu_pp_set_fan_control_mode,
>>>>> +	.set_fan_control_mode    = smu_set_fan_control_mode,
>>>>>     	.get_fan_control_mode    = smu_get_fan_control_mode,
>>>>>     	.set_fan_speed_pwm   = smu_set_fan_speed_pwm,
>>>>>     	.get_fan_speed_pwm   = smu_get_fan_speed_pwm,
>>>>>
