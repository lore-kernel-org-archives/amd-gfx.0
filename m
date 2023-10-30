Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05177C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 06:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93B0B10E20D;
	Mon, 30 Oct 2023 06:49:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBAF210E20D
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 06:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNH0BHs9UTwjJe4CZhDiIzWJpXlgsXio3PJii/Mr3eo9/PB6l28eaNiYocp+zKd8OR9vGC6Nxba4C1OhWFIfmF4lka5qf2JlFgt4J72+IZrF5Nfiyf6NP+fi7ar6rXEOBMxYVVOD7j/7OoSsC7ySsXnOeeYuDbty4mYu0wvjPBp3AY013vu/gQwv2rOxitrPt8jMEIMHpLJBDUR8EqfTUOBTNsk6pnBbS4a6Hjak8n2z4DTzlPYuwJpZ9ohADoo+CRMb5BeNknL92Ru7bjWmE6Y5mhwIMd0E+xulWUHv8anxqlQt9oGR6TW2Pzzlqzct+2dfi9TbEC92sOLhOQmP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0/hzCQLvGPaCZhjwLCdoL77ShRxqcJ5mfjfOD2CZ3o=;
 b=S6JIJMtgrFgiLEoj8r51shTMxXgx964jsAYMAjLwy9Vo9Q8I1FoVjVhHKAqktyu2rWGRYFEOOje7foGkOcFlGpK7JuXM+91YVqdoCEUT6M6M940PqUNdsEafuy25aP2adarsPporGFTVUBz3x6wckmmjyzph0qNEmnmq2s18G6XscptkJh+PURw0EnW1Y5D0XX7lo33gOzmDN/+C/PRezGFYaVim+bMVbsa9wp11QrjmWnCm2aXVPrqAbqeWO9IeEKOXMxM746LHcYZRug6smX0LTFJa8iAPsFl5L0gBIRk6eRuy+MbJJEodslfhU6s5iXBeSiUB5+HqlV4UJf2cSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0/hzCQLvGPaCZhjwLCdoL77ShRxqcJ5mfjfOD2CZ3o=;
 b=2iMJuHyKxZ9DxO7jtldtMb657CYsy2AIF6AONfKUcIOmzilHnwFLFybvW6QHHSBOTpj8Ns1Ahiz0aGwxVXu3dovdye1VWmKDouubIrOr+aCHPAkuZMMbuO0wvcAEKLSJOUoBXnF3g4HCOudyHpvxxf8NivCpJ/qscAwRPTqPE10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Mon, 30 Oct
 2023 06:49:42 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402%7]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 06:49:41 +0000
Message-ID: <eaa02377-9bee-bf37-d394-556727649665@amd.com>
Date: Mon, 30 Oct 2023 14:49:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH Resend] drm/amd/pm: only check sriov vf flag once when
 creating hwmon sysfs
Content-Language: en-US
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20231026025033.1469231-1-Jun.Ma2@amd.com>
 <c82e4cb7-627c-a356-5659-0eb63a3e1a2b@amd.com>
 <PH7PR12MB599761E6CD88B0D38BD9927382A1A@PH7PR12MB5997.namprd12.prod.outlook.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <PH7PR12MB599761E6CD88B0D38BD9927382A1A@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee71f39-8ce2-4d0a-9316-08dbd91464c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjIeVssW3H9z2ncohoV4iIAwzHarLWmLg/Fl+0GQx2hLyMJT/ltL/BtoRZdlHDfKVAehxcmwWktR7A9t7UmyHhTYj5YeBu+MaNd1RTzigEbBtEkZYp3xTL0Jm+zHyypVeiWhQBlRhSAnGpFfPjhI/wIUxtMjnUSh0+TGjxhz+De6uJBGxioQh89aWF8yNXUAU7K210iFtKJ1Lz0VbRgrRB4b2jaFNw8MXoUr1n0FnY4o3M9LqvszEpA43k/Y761V0tJVuNGOQ4R0ffiy2lZz1I1329joAzRbB/DnU577utcG6MxhGAoawAbrPCf7EmjcLCpMOlROS4D8Wggv6P3lrzXoI65va68A3TZrQDdIthKBpXy/WPMgSWwT/dCHCfBLQHLSivxmci4ClZQIr8t1c0uuVewD37ghi+ZrYAKIClVZMy0etzcrTa1vmOZQgzXtrLttPtDnA8trj+bnzWUjjvYLxYL3D/ROeVuCU2mw4zHy9DlJyoSZIFJ1oVv7PVSeaMhtiykwtUJpvbTgY+f8Wp2YiBkE5KgPhXsM9K9tQgrljh8HziHLcunuI0UaXCiLKqUwdl03SUD7m/6ynhcXabi5pkIXDRiO/fPD4lCZ4FQYHtxemRv7C1IeqyrQ/VBr5OKaYsKnxnQ2QEZKAQo0tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(31696002)(36756003)(38100700002)(6506007)(8936002)(4326008)(8676002)(6486002)(66946007)(66556008)(53546011)(66476007)(2616005)(110136005)(6512007)(316002)(6636002)(26005)(5660300002)(41300700001)(6666004)(31686004)(478600001)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHpFalVQY1dGZmY5QUpVSEp0TnV2WGNOcUlIRUkzN1dBbnp1dk9ESlZXbjZl?=
 =?utf-8?B?amlONkZBTnV0dWJZdTY2NlpXT3lHNE1Cckw3OFBJb09QUm5tRm9sSjFsZVY4?=
 =?utf-8?B?ellmUUhraU5uL3NDYm9xRGV3Y2RQVXNObForMjhsdnhRR3E3T3RXU2NOdXgx?=
 =?utf-8?B?T0J1RGJRODh2N3NMVUIrTmRVWkxqV21tUWlQZFRONU5kck5vZWliVEJoN282?=
 =?utf-8?B?WUxxZXNqeWZiQ05TS3NUVlVNQkVYQzQ2WkFOY1NBODFWRmpsa2JKOUxHM0Ev?=
 =?utf-8?B?M2FQQzRRYThGVm1nK0ZVdVVqZC96RE54YWYxbmhaWWRXWWxTWDBoV3QrNUht?=
 =?utf-8?B?eVB2U21mRGM2TjkvWVFOZk0wRWFSSWhvSzREZmF4Smx0SHdScDdramxoYWJo?=
 =?utf-8?B?clhBeXp1VzNxM3MyWDdPdGtESW1SU3Jwcjl4dFBOVWo3bDdRcU5KaExvK1Rq?=
 =?utf-8?B?dkZjYjZHTGN1ZEVIcGxxODN0QmN1QjBHRlRHSXFQL0NXMG8wL1VjMm1tVitj?=
 =?utf-8?B?SkdCNUJpeHhEQytYUVgvUThGQ2RTSE81eUw1MGZGeUxERXZCRnphenl6RUtx?=
 =?utf-8?B?bnlTOHdXQk9saTArQzRXRUo5U1kxK1FCOFZWWDl0eGZRTEJzK3RMYkl6d3NS?=
 =?utf-8?B?bEJOdFVhOEQ2aXNCMWQreGxzMGhVUktyQ01LenZlSytIekRoYzVKakVzVmJ5?=
 =?utf-8?B?NXIvRlRaQktyY3N1Y0NsOHA5bm9mVi8rc3cyeFRXaWlDaS9RcG5ZYXorWFBY?=
 =?utf-8?B?NzY5SWpYb3RvUHRMbVAyNSt5KzZYNkRKU2ZlUXhzWFNLNFB0TzhMN2RLMzln?=
 =?utf-8?B?cnRMYW1xQ2xmM2JFYTF2emEzTUNhTU5CUW9UdlpWU2NibEZjUVhpUkxSSFR1?=
 =?utf-8?B?QzU2WXBNM1RoSnVhcEE2Y053UVAvT29TL1YzSW45WWlHQnJGQUpudzRSck0r?=
 =?utf-8?B?Z2NlVVhnUzl0cjhDaDVDR2NWZkRrR1FVOWkxSFhSbnI4YTdYbkFQZCtHQjUy?=
 =?utf-8?B?ZHhVU3YwQlcrQ0Z1RngyYmNWVFpqSlZqOVpoZkl0ZUNJY3dqdlV6LzUrZ1pD?=
 =?utf-8?B?a2E5d2w4OUZodnQwRytabTlPeTJpQ0NGZEV4SHQ0S0xjZXo5Zm84WXNlb2dF?=
 =?utf-8?B?cW8yeVA0K1d2MEFaV0VKWHlFSC9TR1BIV1ZBSGI1dms0a2RUQzgwWHpjbzRX?=
 =?utf-8?B?UTlzZi9rNWxjOEtsb1Zpb0JHeXMzSXVsZW9MQ2dKRitDb0RtdkJ0dWhwVEZC?=
 =?utf-8?B?SWdZUy9FVUU2OFNPUnIyQmlaWU1HcXk4L0w4N2M5WDZmYzIvc1NPeFdtMUNZ?=
 =?utf-8?B?WWhzODRPeThXODV5VEoyaTJEVkw2TnFVeFZhZnRIc1E4TXNjekhNRmZqYUow?=
 =?utf-8?B?dnFIamF1ZHpQVktiYlJUQkM5cUVENVJHeHQzTHUyZjY3TS9adndtVlRpRkxm?=
 =?utf-8?B?YkF2L2tncFZOMnVEOHplVXYrZnNuKzRrQW05M1liQjA4WURGaTRLUmV5ZjBY?=
 =?utf-8?B?dlR3RmRScVg3SDdtNERTTFJVWFkyb0xQS3BrQU9ZZERYMnJ4elFhOEY1azVP?=
 =?utf-8?B?d1hiT0lHc0REemZ3OGRqT3JUcFNnZFRQSnRVWkNtSGJHZzFtWDVQMXRoK0Rk?=
 =?utf-8?B?VjJ2M29MV2ZwL0s2RSthdHJLRWNjUUV5aGxVOWVCaUtiM0RsQUFyclJLL25n?=
 =?utf-8?B?bHo2dE14ZWxsbWpXbTRnblRwcnZpOGlvUzIwMnJuekk1UmdQcm96ZGhTNExq?=
 =?utf-8?B?T2lDUHBqaHZDSFJCMHZSTHRDVzB2WU9qbDlNaldpMU5oSHRBOXNZcXl2YU1w?=
 =?utf-8?B?dXo1TUhpUWdwdm5EM3NTT050M2ZQOThDOTd2bFhCbjZIZTBTV3p5NGJDNkNG?=
 =?utf-8?B?eEp3eC94YkkxcXBRYzl0RmRlM1RwS3RHT2pqcDk0Q01QME9Wa3ZnMzRUcnN2?=
 =?utf-8?B?bldKUWpYSUNmbDgzdnRHVUpJR0d3SGR4ekxYTW4wekZxOUhiSkFyMloxZW5I?=
 =?utf-8?B?WDVtTUV0WktRTFkvV0NudUs4dDN5cm5SNUM4VkFJbllRUXJtZFNGUTVNZHpN?=
 =?utf-8?B?SWhtc24zMS96bnZqY2lxNVBPV1d0alBSVEhBeHBsVWJsWFc4SlZlLzdGWUxm?=
 =?utf-8?Q?3lJmCeMu5+QlcZOT9EEfgBSv1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee71f39-8ce2-4d0a-9316-08dbd91464c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 06:49:41.8083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKu1vkM8GA13Pj/7Qax9mxJDoCHPObTKD4x6Kh9aUkmmuH0vTFEVY5slKRy4dtIE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261
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

Hi Kevin,

On 10/30/2023 2:23 PM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - General]
> 
> The driver already has similar code in hwmon_attributes_visible(),
> So, what issue you have now ?
> 
>         /* under multi-vf mode, the hwmon attributes are all not supported */
>         if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>

This function is called for each attribute now, so the vf flags will also be checked
multiple times. 
So move this code to amdgpu_pm_sysfs_init so that the vf flags will only be checked once.

Regards,
Ma Jun

                 return 0;
> 
> Best Regards,
> Kevin
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ma, Jun
> Sent: Monday, October 30, 2023 2:10 PM
> To: Ma, Jun <Jun.Ma2@amd.com>; amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH Resend] drm/amd/pm: only check sriov vf flag once when creating hwmon sysfs
> 
> ping...
> 
> On 10/26/2023 10:50 AM, Ma Jun wrote:
>> The current code checks sriov vf flag multiple times when creating
>> hwmon sysfs. So fix it.
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 ++++++++++++++-------------
>>  1 file changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index 358bb5e485f2..ee46d04549e6 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -3288,10 +3288,6 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>>       uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
>>       uint32_t tmp;
>>
>> -     /* under multi-vf mode, the hwmon attributes are all not supported */
>> -     if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>> -             return 0;
>> -
>>       /* under pp one vf mode manage of hwmon attributes is not supported */
>>       if (amdgpu_sriov_is_pp_one_vf(adev))
>>               effective_mode &= ~S_IWUSR;
>> @@ -4162,6 +4158,7 @@ static int amdgpu_od_set_init(struct
>> amdgpu_device *adev)
>>
>>  int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)  {
>> +     enum amdgpu_sriov_vf_mode mode;
>>       uint32_t mask = 0;
>>       int ret;
>>
>> @@ -4173,17 +4170,21 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>>       if (adev->pm.dpm_enabled == 0)
>>               return 0;
>>
>> -     adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
>> -                                                                DRIVER_NAME, adev,
>> -                                                                hwmon_groups);
>> -     if (IS_ERR(adev->pm.int_hwmon_dev)) {
>> -             ret = PTR_ERR(adev->pm.int_hwmon_dev);
>> -             dev_err(adev->dev,
>> -                     "Unable to register hwmon device: %d\n", ret);
>> -             return ret;
>> +     mode = amdgpu_virt_get_sriov_vf_mode(adev);
>> +
>> +     /* under multi-vf mode, the hwmon attributes are all not supported */
>> +     if (mode != SRIOV_VF_MODE_MULTI_VF) {
>> +             adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
>> +                                                                                                             DRIVER_NAME, adev,
>> +                                                                                                             hwmon_groups);
>> +             if (IS_ERR(adev->pm.int_hwmon_dev)) {
>> +                     ret = PTR_ERR(adev->pm.int_hwmon_dev);
>> +                     dev_err(adev->dev, "Unable to register hwmon device: %d\n", ret);
>> +                     return ret;
>> +             }
>>       }
>>
>> -     switch (amdgpu_virt_get_sriov_vf_mode(adev)) {
>> +     switch (mode) {
>>       case SRIOV_VF_MODE_ONE_VF:
>>               mask = ATTR_FLAG_ONEVF;
>>               break;
