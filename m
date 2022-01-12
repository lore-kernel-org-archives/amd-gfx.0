Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AF1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 07:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0F510F15A;
	Wed, 12 Jan 2022 07:04:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B8CB10F15A
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 07:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljP/nhQD5HXzOFAPyrJVNXHfaLI6vOPVZNJGHttR4g4kxg+bbgPiuDL3j40jzDGjnilOeeU4Ve8XO3xgOmnM0qH97LZHSAKUGyCaFd+9EnUdDgyTGVYITGPNzWTOnCukOVQ7wFEVs1lUBdO/X41drh6p/MPGrB7/ViywLEiT0w0MCaJ8XOKwhv3GX7jFxgfUuSmtIlIRxXVNaignapb9cZwsdMojxm1L5VpQIreaK21eSKLLnJ87fJJkGaSycJFMHpufrJYuk8968HJX2r1TWJGS14e6gEafs5PgT8g04utNqIzYrCn6c+c/ATIaYKPKqCEQb9PyslqeIhcGo+iikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQC6o6W35jRYi5g42Z4YVsJoMFx+E7mPrbHyONzW00g=;
 b=BjJKcEhvQhBpGlx+ydGYW6+lDuzT9cn6CtikgawCPQYIfoHd1Tbfrn0oP86L0JxZxQYL6CIuYzfIHwhTrovJElK9ayJ5O2fr3h2YejqzqXJiir1Um0tJVBIG77yinS6M9QC8k1Zn5tasSbl/q+Xm30VSsOBMy/bEdw+x9Tdf4q58hkMwPwFLNHxnog2rACjcnvuzMjO+kE5/fweIYi+Xvon+hcfZqmw2/uqIOguErLewcOsAL23obgroVp94ga99AEiMlDaUImIi20CIzwNbwL+Znes4DDMb3ltMucIPt4BwynRERv4sG6uR64BD5cXsvFhO/RkzZGKjjjNIc/IHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQC6o6W35jRYi5g42Z4YVsJoMFx+E7mPrbHyONzW00g=;
 b=NBiJdECDM1vOpxVGOWgcijqT8G2d4rjgaFPUmVXNU4zEYLmvUXtgHjFL8RdpKSzgwIqz1YJqCTp6TO8bew+wdDMEFLYDMCOwpk7P2qzrLty/2X8bix4pmt57QMr0BVlT5C71Ir9UnaPndnuIvK4IzVAgPGWim+1A7/a51UUIE5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 07:04:02 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%5]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 07:04:02 +0000
Message-ID: <15a19c92-299b-16d1-41de-c00c46220e33@amd.com>
Date: Wed, 12 Jan 2022 12:33:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/7] drm/amd/pm: drop unneeded smu->metrics_lock
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220106055732.3073780-1-evan.quan@amd.com>
 <20220106055732.3073780-4-evan.quan@amd.com>
 <4c820046-fc95-e7ef-c857-eebea6542990@amd.com>
 <DM6PR12MB2619F53DE7747026D05E3A49E44C9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <7dbaa69b-2465-c1ab-9676-4dec289d6356@amd.com>
 <DM6PR12MB2619470CEF4FBD3439694FA2E44D9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <997293a5-a5e0-1216-6155-3eff7618b5e8@amd.com>
 <DM6PR12MB2619C8FB7EDBFA5A906F0BE4E4519@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619C8FB7EDBFA5A906F0BE4E4519@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc5013e5-a56a-4688-eca6-08d9d599b6d2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4196:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB419642A80F71F4883E4CF72997529@BY5PR12MB4196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgIudJfrsPObabGRib+jz60D2I1kHxVykLEoHpHcZjQbJoGK4Jf9faTY5LSWZ46UF/OWfO4vMjvVMz5fgggj02sWYs3rwdu0xle+jcbJjLYpRyqBkjN0m0Cj1I5XXxgLZVBQHNmssgb/Bz+iq+wF8ukzvpm67JAj+9lhXfuF7QE2m/4b6mvYU5wI3BvcdWhcVjlwHIar08gt3+1N9IuJYsTEsN2kox6AtuhXqSHpJalNgAAb7W5HBXOHp1UQVZTVUm3kVfQffe4s6Te5wEuSR6JI9CLbak73LtUIUPjcXNVhG7AiMpvxXkGrwfgaTy5Cp0mCWtyhQybaX1Dm+oICx/7UuCGaG4dd6Jrv+dgz7/lvym+bZCRsu/ZV/JO57Y7mczbtrzf8i9mskY/qNlTuMKCLcbiWJzO5mvkFdMFu6cIEglkq0Uj8VN1sgdqf49u2wZ76rmMyhCZ5LIUq0DXivcpgEmZXFX0hfHvMFQuOJbedyvPybRT60A60jkLIRW6Ey1oBCeUzwAfqFfrbM01VUt/KQAp0ZfSCYCobA6Gkql6bALtu/DOb080JQNjw7kzAAjE4pdcLZNyoQL+9n0LjcFkFOIHbadr2lIMHPZgC/NS4UotV0sGfIfHii/Q2lj5zvrq4xTEpYvhfypBlA+8pSkU2vJSE/K5Bf2pFC3CMS1XNAFoT/pagfxlFBfi/T1e8BBEo2nnlh+jBbnr2IzgK3bJBUMyT5r8vNj5wgWr6T+KTHTib0SOTMy01osOoXzDs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(5660300002)(86362001)(31696002)(2906002)(6486002)(110136005)(316002)(19627235002)(66946007)(508600001)(66556008)(66476007)(8676002)(53546011)(30864003)(2616005)(6506007)(36756003)(31686004)(38100700002)(6666004)(8936002)(6512007)(4326008)(83380400001)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dys1eW1CSnkwWUVaeWRWK1BaYnY2eTllY2xQaXU0MHpkVFU3MTZMWkZDUEdD?=
 =?utf-8?B?S3prL3BIcERNVGRsbW92c1gyME9LRHJsK1UwSHFmNWFJbkRnM1B4cEhYMGhE?=
 =?utf-8?B?aVBuZkc0OVZYSDkxbG9OR0JwMUhKNGk0VjUwQWlZYzc2VU9ZOU5tQ09Fa0Rm?=
 =?utf-8?B?Tkh3cWZLcit2MnRDTmxLZzdxMUEwVkloRmt1d0IzTGRHVkNhdFNtVy9CZ2Qw?=
 =?utf-8?B?V3dvakZCS0pWTnI1WkdhajQ3eEx3a1U0U3hzV0V2QWwrbTBKem4ydEpwRHds?=
 =?utf-8?B?UlhWWE5WaUJyTmVEVVVPa3AycnpRdGtBR0ZnNmtSUFBkRUpEQnFBdTVzSFp2?=
 =?utf-8?B?RFVpQXdiZ0dIOEEvVk5vV1FyTmMyeWpnWDVvdjBlNzZZQTRseDRoV3BnZGNF?=
 =?utf-8?B?T1hMWnNhL0hDNlZjdWFES2FOSjNlVVBLWkJLQmMzZzlrRHhZMmQ2TVk2ZXFG?=
 =?utf-8?B?OXNJbGI5STEybVJBOUZEZXQxVWFzdjVEMzR2SXhMSnV4Z3NFZUhSdGlaa1M5?=
 =?utf-8?B?ZHdobE1HVUh6bUpOcDkzYnhQcVR0aXRFcEw4aFRadWo5ZEtXck1WU3htZlZP?=
 =?utf-8?B?MUNWcWNmQWNOcFI3V1ZPK1d2WXB5eWhIaXVUM0k2MWJsd05hSFc5Mjdtd0Jo?=
 =?utf-8?B?TVZ6RVR4VVZoZnZ0QmNlNFYyVk5mQVdFeFF3cGlyZlBLOFZOS0JQVC9nd29H?=
 =?utf-8?B?c09SRXVkaXcvR1c0VytjMkc1RmtMT1RMamNEci9PeE4wYmVjUGN3NEVQQlJW?=
 =?utf-8?B?ZEJlQXZJeTc2NlJUUnJvTzhZcEdFMXRIWjQ1RXRFaXc4MTluTWRmczAxRGhi?=
 =?utf-8?B?bCtxQlJ5N1YrR05sSjBBdVVPZWhjNFRWek9EWncyVi9LVVIxdU1Uam1HajZZ?=
 =?utf-8?B?ZjNnbnoxb2hVWnNIZE9sWjRDUitxTDR5NmZ6bENyTEFEdDhvNklQZGpDaG93?=
 =?utf-8?B?OXp6aUF2V1p2MzBpL3NWVjJZK09oUXhESXgrR1YzWDFpcXREczBVUUhIV0ZF?=
 =?utf-8?B?NGhJTEhBODRTc1RXcHpLV3E3eTNxQWJUeGtRTVpWdGJZUHZnS2dxZEcxL2Rr?=
 =?utf-8?B?Q3VNbitrWGNBTDlCRHlLZnJUSENJLy9zbTBtTi9pRkVXSEo0VXErTjU0VTFK?=
 =?utf-8?B?QUtweG52Zmhia281V1JXNjY5YzF3TitFWHhUa2hvN2t1RFBZYWF5TWxRWnFx?=
 =?utf-8?B?VWVlREs3aDFHVHQyZzFnTk9BZzEzVk1DZmxHRDhaSDg5MXhLdDg0UmpoY3gw?=
 =?utf-8?B?NWVySUM2Qzg5WEtJMjhVanVpWWhPWDV3ZloyUTNac0x4V0JoQTNxNUk2TmxU?=
 =?utf-8?B?d0FxRGNkcG53WndkU2VOcHZ4Z1RMem1GV3FJUFViaTQrOTNGcmJvL0VUcWNl?=
 =?utf-8?B?T1pHNkFIbG1OVjB0K1R6MEJrTmVvazZsdzRXZkxQY3lEODlWb0JWYi9uZk5H?=
 =?utf-8?B?WUx1dVlLTXkwcXkra3hKUUpmRjlpcHVLVUNtQnMyOEJWazBTZDFFcUszNXVQ?=
 =?utf-8?B?T0JBZWIxOTVXdEZpc1FNd3llL2pYQjhpUjZ6NXh6VFJVOEZZaThwWU1lUmxE?=
 =?utf-8?B?UXlBVUEweW5Ea2lFaHRzeWZlanlYNnVrWDBPWitRekJDU0l6RGM1S1VFYS9k?=
 =?utf-8?B?bUJpVytzTXFKNk5mSjVRS0dncGlBMXJQNFlsYWpPcDZqMXovRHI5Z2RrbDNm?=
 =?utf-8?B?M05mcmh1ZTFYeUFvVVZPL2ZaQzZWUmR1OVFFT202Zzh0Mm9QZGZEZ0FOSTJ0?=
 =?utf-8?B?OUtvbmZGZ1V2SXJPY0c0dTJ2SVQxSytYTm53Z0JGYVdSSUNaRVBKYnIxSVVH?=
 =?utf-8?B?WlFxbW9VdXY1Y3E4ejhZb2p0UHVWT00vWkdmR3FBMytlYTl4S3hOdGUvR0VI?=
 =?utf-8?B?ckpOV1FFTjYzTkEwUGdSZ1E4RmhidU5MVjRwR3dPaGhsdkZwL2xObEF5SzFq?=
 =?utf-8?B?S200SlNzTVlVNXNqNzkzN29STzBrNnZnK096bnZMc2lPQUE0RTdHWHFQeitk?=
 =?utf-8?B?S0hxemtsRVBKR3NpTmxwdHhUSStzZmJDVit1d1p4d2ZsVHRaSUhGRWVMK085?=
 =?utf-8?B?MVpLUnpFS3V6OTdMdWpiSHVZS1QyUEdMeEhmVHhGbTZJM3dHR3g2eTRDMkFZ?=
 =?utf-8?Q?MNIc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5013e5-a56a-4688-eca6-08d9d599b6d2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 07:04:02.7218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9ih5f9S13LwPRAwMu0OZV9MP7kyVvxV4Dd/c45XGCu2igJCvLEFvXfoVnHt3xqi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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



On 1/11/2022 6:51 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, January 10, 2022 3:03 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 3/7] drm/amd/pm: drop unneeded smu->metrics_lock
>>
>>
>>
>> On 1/7/2022 7:49 AM, Quan, Evan wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Thursday, January 6, 2022 4:29 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH 3/7] drm/amd/pm: drop unneeded smu-
>>> metrics_lock
>>>>
>>>>
>>>>
>>>> On 1/6/2022 12:32 PM, Quan, Evan wrote:
>>>>> [AMD Official Use Only]
>>>>>
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>> Sent: Thursday, January 6, 2022 2:17 PM
>>>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-
>> gfx@lists.freedesktop.org
>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>>> Subject: Re: [PATCH 3/7] drm/amd/pm: drop unneeded smu-
>>>>> metrics_lock
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 1/6/2022 11:27 AM, Evan Quan wrote:
>>>>>>> As all those related APIs are already well protected by
>>>>>>> adev->pm.mutex and smu->message_lock.
>>>>>>>
>>>>>>
>>>>>> This one may be widely used. Instead of relying on pm.mutex it's
>>>>>> better to keep metrics lock so that multiple clients can read data
>>>>>> without waiting on other APIs that use pm.mutex.
>>>>> [Quan, Evan] If I understand it correctly, what you wanted to
>>>>> express is to
>>>> use fine-grained lock instead of cross-grained one to avoid chasing
>>>> for the same lock.
>>>>> Yes, that was what we did before and that's why we have so many
>>>>> types of
>>>> locks. Below are my considerations for this:
>>>>> 1. We actually do not have such issue that many APIs/clients chasing
>>>>> for the
>>>> same lock. Thus fine-grained locks cannot bring much benefits.
>>>>> Take the metrics_lock here for example.  The data protected by
>>>> metrics_lock are for those pm sysfs interfaces. Those sysfs interface
>>>> are not so frequently called. And almost all the time, they are called one
>> after one.
>>>> So, it's rarely they will chase for the same lock.
>>>>>
>>>>
>>>> It's not just sysfs, there are other interfaces like sensors, hwmons etc.
>>>> Basically, metrics table provides data like GFX activity or throttler
>>>> status that may be continuously monitored by app layer. So other APIs
>>>> could suffer. My thought is to just keep metrics under a separate
>>>> lock and not tie with pm.mutex.
>>> [Quan, Evan] I doubt about the guess that "other APIs could suffer if
>> metrics data is continuously polled by app layer".
>>> Since according to my previous test(watch -n 0.1 "cat
>> /sys/kernel/debug/dri/0/amdgpu_pm_info") which polled the metrics data
>> every 0.1 second, the smu busy percent was almost not affected.
>>
>> May be try close to real cases like running some videos/changing resolution
>> and run radeon profile or some monitoring app in the background?
> [Quan, Evan] There is actually not many interactions between the UMD and driver during the video palying and game running.
> My local verifications proved that. Although that seems surprising. It's kind of expected.
> As pmfw is self-governed and it can perform clocks arbitration without driver's involvement.
> 
> Most of the loadings come from the monitoring command(watch -n 1 "cat/sys/kernel/debug/dri/0/amdgpu_pm_info") in the background during
> my verifications. In fact, different from the way taken by amdgpu_pm_info sysfs implementation, UMD uses a much more clever way which can reduce
> the loadings even further: via the gpu_metrics interface, UMD can get the all metrics data instead of each at one time.

Ok, then let's go ahead and remove this lock. If at all there is an 
issue, we can revisit.

Thanks,
Lijo

>>
>>> So, even the metric data is polled every second by app layer, that should
>> not enforce much loading on the CPUs and SMU cores.
>>>
>>> Also, keeping a separate lock for metrics data does not help much with the
>> issue mentioned here(even if there is such).
>>> As they(app layer and other APIs) will still chase for another
>> lock(message_lock which is kept) for interaction with SMU.
>>>
>>
>> Yes, only the subsequent steps related to reading table data from VRAM.
>> Other APIs don't need to wait for this. Only thinking about profiling cases,
>> may be I'm overthinking.
> [Quan, Evan] As far as I can remember, the metrics_lock was introduced to resolve some racing issue. It did not aim at performance improvement.
> So, it should be quite safe to drop it.
> 
> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> BR
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> 2. Cross-grained lock can simplify our implementations. It's hard to
>>>>> believe,
>>>> there is 10+(actually 13 as I counted) different types of locks used
>>>> in our existing power code.
>>>>> By the cross-grained lock, we can simplify the code and protect us
>>>>> from
>>>> some unintentional dead-locks(I actually run into that several times
>>>> and it's really tricky).
>>>>>
>>>>> BR
>>>>> Evan
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>>>> Change-Id: Ic75326ba7b4b67be8762d5407d02f6c514e1ad35
>>>>>>> ---
>>>>>>>      drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   1 -
>>>>>>>      drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   1 -
>>>>>>>      .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  14 +--
>>>>>>>      .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  10 +-
>>>>>>>      .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 112 +++++----
>> ----
>>>> ----
>>>>>> -
>>>>>>>      .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  27 ++---
>>>>>>>      .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  28 ++---
>>>>>>>      .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  14 +--
>>>>>>>      .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  23 ++--
>>>>>>>      .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  10 +-
>>>>>>>      drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  21 +---
>>>>>>>      drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   4 -
>>>>>>>      12 files changed, 70 insertions(+), 195 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>>>> index ecbc768dfe2f..f0136bf36533 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>>>> @@ -956,7 +956,6 @@ static int smu_sw_init(void *handle)
>>>>>>>      	bitmap_zero(smu->smu_feature.allowed,
>> SMU_FEATURE_MAX);
>>>>>>>
>>>>>>>      	mutex_init(&smu->sensor_lock);
>>>>>>> -	mutex_init(&smu->metrics_lock);
>>>>>>>      	mutex_init(&smu->message_lock);
>>>>>>>
>>>>>>>      	INIT_WORK(&smu->throttling_logging_work,
>>>>>>> smu_throttling_logging_work_fn); diff --git
>>>>>>> a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>>>> index c3efe4fea5e0..63ed807c96f5 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>>>> @@ -487,7 +487,6 @@ struct smu_context
>>>>>>>      	const struct cmn2asic_mapping	*pwr_src_map;
>>>>>>>      	const struct cmn2asic_mapping	*workload_map;
>>>>>>>      	struct mutex			sensor_lock;
>>>>>>> -	struct mutex			metrics_lock;
>>>>>>>      	struct mutex			message_lock;
>>>>>>>      	uint64_t pool_size;
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>>>>>> index addb0472d040..3f7c1f23475b 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>>>>>> @@ -602,15 +602,11 @@ static int
>>>>>>> arcturus_get_smu_metrics_data(struct
>>>>>> smu_context *smu,
>>>>>>>      	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>>>>>> metrics_table;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       NULL,
>>>>>>> -					       false);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>>>> +					NULL,
>>>>>>> +					false);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	switch (member) {
>>>>>>>      	case METRICS_CURR_GFXCLK:
>>>>>>> @@ -693,8 +689,6 @@ static int
>>>>>>> arcturus_get_smu_metrics_data(struct
>>>>>> smu_context *smu,
>>>>>>>      		break;
>>>>>>>      	}
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	return ret;
>>>>>>>      }
>>>>>>>
>>>>>>> diff --git
>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
>>>>>>> index 2238ee19c222..7ae6b1bd648a 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
>>>>>>> @@ -150,13 +150,9 @@ cyan_skillfish_get_smu_metrics_data(struct
>>>>>> smu_context *smu,
>>>>>>>      	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>>>>>> metrics_table;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu, NULL, false);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	switch (member) {
>>>>>>>      	case METRICS_CURR_GFXCLK:
>>>>>>> @@ -200,8 +196,6 @@ cyan_skillfish_get_smu_metrics_data(struct
>>>>>> smu_context *smu,
>>>>>>>      		break;
>>>>>>>      	}
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	return ret;
>>>>>>>      }
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>>>> index fe17b3c1ece7..fdb059e7c6ba 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>>>> @@ -546,15 +546,11 @@ static int
>>>>>> navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>>>>>      		(SmuMetrics_legacy_t *)smu_table->metrics_table;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       NULL,
>>>>>>> -					       false);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>>>> +					NULL,
>>>>>>> +					false);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	switch (member) {
>>>>>>>      	case METRICS_CURR_GFXCLK:
>>>>>>> @@ -624,8 +620,6 @@ static int
>>>>>> navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>>>>>      		break;
>>>>>>>      	}
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	return ret;
>>>>>>>      }
>>>>>>>
>>>>>>> @@ -638,15 +632,11 @@ static int
>>>>>>> navi10_get_smu_metrics_data(struct
>>>>>> smu_context *smu,
>>>>>>>      		(SmuMetrics_t *)smu_table->metrics_table;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       NULL,
>>>>>>> -					       false);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>>>> +					NULL,
>>>>>>> +					false);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	switch (member) {
>>>>>>>      	case METRICS_CURR_GFXCLK:
>>>>>>> @@ -719,8 +709,6 @@ static int navi10_get_smu_metrics_data(struct
>>>>>> smu_context *smu,
>>>>>>>      		break;
>>>>>>>      	}
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	return ret;
>>>>>>>      }
>>>>>>>
>>>>>>> @@ -733,15 +721,11 @@ static int
>>>>>> navi12_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>>>>>      		(SmuMetrics_NV12_legacy_t *)smu_table-
>>> metrics_table;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       NULL,
>>>>>>> -					       false);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>>>> +					NULL,
>>>>>>> +					false);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	switch (member) {
>>>>>>>      	case METRICS_CURR_GFXCLK:
>>>>>>> @@ -811,8 +795,6 @@ static int
>>>>>> navi12_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>>>>>      		break;
>>>>>>>      	}
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	return ret;
>>>>>>>      }
>>>>>>>
>>>>>>> @@ -825,15 +807,11 @@ static int
>>>>>>> navi12_get_smu_metrics_data(struct
>>>>>> smu_context *smu,
>>>>>>>      		(SmuMetrics_NV12_t *)smu_table->metrics_table;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       NULL,
>>>>>>> -					       false);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>>>> +					NULL,
>>>>>>> +					false);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	switch (member) {
>>>>>>>      	case METRICS_CURR_GFXCLK:
>>>>>>> @@ -906,8 +884,6 @@ static int navi12_get_smu_metrics_data(struct
>>>>>> smu_context *smu,
>>>>>>>      		break;
>>>>>>>      	}
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	return ret;
>>>>>>>      }
>>>>>>>
>>>>>>> @@ -2708,20 +2684,14 @@ static ssize_t
>>>>>> navi10_get_legacy_gpu_metrics(struct smu_context *smu,
>>>>>>>      	SmuMetrics_legacy_t metrics;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       NULL,
>>>>>>> -					       true);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>>>> +					NULL,
>>>>>>> +					true);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	memcpy(&metrics, smu_table->metrics_table,
>>>>>>> sizeof(SmuMetrics_legacy_t));
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>>>>>
>>>>>>>      	gpu_metrics->temperature_edge =
>> metrics.TemperatureEdge; @@
>>>>>>> -2899,20 +2869,14 @@ static ssize_t navi10_get_gpu_metrics(struct
>>>>>> smu_context *smu,
>>>>>>>      	SmuMetrics_t metrics;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       NULL,
>>>>>>> -					       true);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>>>> +					NULL,
>>>>>>> +					true);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	memcpy(&metrics, smu_table->metrics_table,
>>>>>> sizeof(SmuMetrics_t));
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>>>>>
>>>>>>>      	gpu_metrics->temperature_edge =
>> metrics.TemperatureEdge; @@
>>>>>>> -2977,20 +2941,14 @@ static ssize_t
>>>>>>> navi12_get_legacy_gpu_metrics(struct
>>>>>> smu_context *smu,
>>>>>>>      	SmuMetrics_NV12_legacy_t metrics;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       NULL,
>>>>>>> -					       true);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>>>> +					NULL,
>>>>>>> +					true);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	memcpy(&metrics, smu_table->metrics_table,
>>>>>>> sizeof(SmuMetrics_NV12_legacy_t));
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>>>>>
>>>>>>>      	gpu_metrics->temperature_edge =
>> metrics.TemperatureEdge; @@
>>>>>>> -3058,20 +3016,14 @@ static ssize_t navi12_get_gpu_metrics(struct
>>>>>> smu_context *smu,
>>>>>>>      	SmuMetrics_NV12_t metrics;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       NULL,
>>>>>>> -					       true);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>>>> +					NULL,
>>>>>>> +					true);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	memcpy(&metrics, smu_table->metrics_table,
>>>>>>> sizeof(SmuMetrics_NV12_t));
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>>>>>
>>>>>>>      	gpu_metrics->temperature_edge =
>> metrics.TemperatureEdge; diff
>>>>>>> --
>>>>>> git
>>>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>>>> index 93caaf45a2db..2241250c2d2a 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>>>> @@ -525,15 +525,11 @@ static int
>>>>>> sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>>>>>>>      	uint16_t average_gfx_activity;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       NULL,
>>>>>>> -					       false);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>>>> +					NULL,
>>>>>>> +					false);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	switch (member) {
>>>>>>>      	case METRICS_CURR_GFXCLK:
>>>>>>> @@ -633,8 +629,6 @@ static int
>>>>>> sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>>>>>>>      		break;
>>>>>>>      	}
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	return ret;
>>>>>>>
>>>>>>>      }
>>>>>>> @@ -3564,14 +3558,11 @@ static ssize_t
>>>>>> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>>>>>>>      	uint16_t average_gfx_activity;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       &metrics_external,
>>>>>>> -					       true);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>>>> +					&metrics_external,
>>>>>>> +					true);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>>>>>
>>>>>>> @@ -3661,8 +3652,6 @@ static ssize_t
>>>>>> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>>>>>>>
>>>>>> 	smu_v11_0_get_current_pcie_link_speed(smu);
>>>>>>>      	}
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	gpu_metrics->system_clock_counter =
>> ktime_get_boottime_ns();
>>>>>>>
>>>>>>>      	*table = (void *)gpu_metrics; diff --git
>>>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>>>> index 5cb07ed227fb..c736adca6fbb 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>>>> @@ -273,15 +273,11 @@ static int
>>>>>> vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>>>>>      	SmuMetrics_legacy_t *metrics = (SmuMetrics_legacy_t
>>>>>> *)smu_table->metrics_table;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       NULL,
>>>>>>> -					       false);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>>>> +					NULL,
>>>>>>> +					false);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	switch (member) {
>>>>>>>      	case METRICS_CURR_GFXCLK:
>>>>>>> @@ -335,8 +331,6 @@ static int
>>>>>> vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
>>>>>>>      		break;
>>>>>>>      	}
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	return ret;
>>>>>>>      }
>>>>>>>
>>>>>>> @@ -348,15 +342,11 @@ static int
>>>> vangogh_get_smu_metrics_data(struct
>>>>>> smu_context *smu,
>>>>>>>      	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>>>>>> metrics_table;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       NULL,
>>>>>>> -					       false);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>>>> +					NULL,
>>>>>>> +					false);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	switch (member) {
>>>>>>>      	case METRICS_CURR_GFXCLK:
>>>>>>> @@ -410,8 +400,6 @@ static int
>> vangogh_get_smu_metrics_data(struct
>>>>>> smu_context *smu,
>>>>>>>      		break;
>>>>>>>      	}
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	return ret;
>>>>>>>      }
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>>>>>> index 25c4b135f830..d75508085578 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>>>>>> @@ -1128,15 +1128,11 @@ static int
>>>>>>> renoir_get_smu_metrics_data(struct
>>>>>> smu_context *smu,
>>>>>>>      	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>>>>>> metrics_table;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       NULL,
>>>>>>> -					       false);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>>>> +					NULL,
>>>>>>> +					false);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	switch (member) {
>>>>>>>      	case METRICS_AVERAGE_GFXCLK:
>>>>>>> @@ -1201,8 +1197,6 @@ static int
>>>>>>> renoir_get_smu_metrics_data(struct
>>>>>> smu_context *smu,
>>>>>>>      		break;
>>>>>>>      	}
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	return ret;
>>>>>>>      }
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>>>> index f065d95b117a..014fb88daa04 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>>>> @@ -571,15 +571,11 @@ static int
>>>>>> aldebaran_get_smu_metrics_data(struct smu_context *smu,
>>>>>>>      	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>>>>>> metrics_table;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       NULL,
>>>>>>> -					       false);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu,
>>>>>>> +					NULL,
>>>>>>> +					false);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	switch (member) {
>>>>>>>      	case METRICS_CURR_GFXCLK:
>>>>>>> @@ -653,8 +649,6 @@ static int
>>>> aldebaran_get_smu_metrics_data(struct
>>>>>> smu_context *smu,
>>>>>>>      		break;
>>>>>>>      	}
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	return ret;
>>>>>>>      }
>>>>>>>
>>>>>>> @@ -1592,17 +1586,14 @@ static void
>> aldebaran_get_unique_id(struct
>>>>>> smu_context *smu)
>>>>>>>      	uint32_t upper32 = 0, lower32 = 0;
>>>>>>>      	int ret;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu, NULL, false);
>>>>>>>      	if (ret)
>>>>>>> -		goto out_unlock;
>>>>>>> +		goto out;
>>>>>>>
>>>>>>>      	upper32 = metrics->PublicSerialNumUpper32;
>>>>>>>      	lower32 = metrics->PublicSerialNumLower32;
>>>>>>>
>>>>>>> -out_unlock:
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> +out:
>>>>>>>      	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
>>>>>>>      	if (adev->serial[0] == '\0')
>>>>>>>      		sprintf(adev->serial, "%016llx", adev->unique_id);
>> diff
>>>>>>> --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>>>> index caf1775d48ef..451d30dcc639 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>>>> @@ -310,13 +310,9 @@ static int
>>>>>> yellow_carp_get_smu_metrics_data(struct smu_context *smu,
>>>>>>>      	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table-
>>>>>>> metrics_table;
>>>>>>>      	int ret = 0;
>>>>>>>
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
>>>>>>> -	if (ret) {
>>>>>>> -		mutex_unlock(&smu->metrics_lock);
>>>>>>> +	ret = smu_cmn_get_metrics_table(smu, NULL, false);
>>>>>>> +	if (ret)
>>>>>>>      		return ret;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	switch (member) {
>>>>>>>      	case METRICS_AVERAGE_GFXCLK:
>>>>>>> @@ -387,8 +383,6 @@ static int
>>>>>>> yellow_carp_get_smu_metrics_data(struct
>>>>>> smu_context *smu,
>>>>>>>      		break;
>>>>>>>      	}
>>>>>>>
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>>      	return ret;
>>>>>>>      }
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>> index 735e1a1e365d..d78e4f689a2a 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>> @@ -964,9 +964,9 @@ int smu_cmn_write_pptable(struct
>> smu_context
>>>>>> *smu)
>>>>>>>      				    true);
>>>>>>>      }
>>>>>>>
>>>>>>> -int smu_cmn_get_metrics_table_locked(struct smu_context *smu,
>>>>>>> -				     void *metrics_table,
>>>>>>> -				     bool bypass_cache)
>>>>>>> +int smu_cmn_get_metrics_table(struct smu_context *smu,
>>>>>>> +			      void *metrics_table,
>>>>>>> +			      bool bypass_cache)
>>>>>>>      {
>>>>>>>      	struct smu_table_context *smu_table= &smu->smu_table;
>>>>>>>      	uint32_t table_size =
>>>>>>> @@ -994,21 +994,6 @@ int
>> smu_cmn_get_metrics_table_locked(struct
>>>>>> smu_context *smu,
>>>>>>>      	return 0;
>>>>>>>      }
>>>>>>>
>>>>>>> -int smu_cmn_get_metrics_table(struct smu_context *smu,
>>>>>>> -			      void *metrics_table,
>>>>>>> -			      bool bypass_cache)
>>>>>>> -{
>>>>>>> -	int ret = 0;
>>>>>>> -
>>>>>>> -	mutex_lock(&smu->metrics_lock);
>>>>>>> -	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>>>> -					       metrics_table,
>>>>>>> -					       bypass_cache);
>>>>>>> -	mutex_unlock(&smu->metrics_lock);
>>>>>>> -
>>>>>>> -	return ret;
>>>>>>> -}
>>>>>>> -
>>>>>>>      void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev,
>>>>>>> uint8_t
>>>>>> crev)
>>>>>>>      {
>>>>>>>      	struct metrics_table_header *header = (struct
>>>>>>> metrics_table_header *)table; diff --git
>>>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>>>> index 67a25da79256..f0b4fb2a0960 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>>>> @@ -101,10 +101,6 @@ int smu_cmn_write_watermarks_table(struct
>>>>>>> smu_context *smu);
>>>>>>>
>>>>>>>      int smu_cmn_write_pptable(struct smu_context *smu);
>>>>>>>
>>>>>>> -int smu_cmn_get_metrics_table_locked(struct smu_context *smu,
>>>>>>> -				     void *metrics_table,
>>>>>>> -				     bool bypass_cache);
>>>>>>> -
>>>>>>>      int smu_cmn_get_metrics_table(struct smu_context *smu,
>>>>>>>      			      void *metrics_table,
>>>>>>>      			      bool bypass_cache);
>>>>>>>
