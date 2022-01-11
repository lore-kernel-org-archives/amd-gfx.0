Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FCEC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 03:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C1331126F5;
	Tue, 11 Jan 2022 03:32:30 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EB0F1126F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 03:32:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpJI2HVIDLvhCbO9A2dceP5m1RFPz+/kUuPI6F9vbl1F56vofBhq8n83OJJS5iaRD0E6S+rbi1gJznjI2Gfn/GV9VLrhSoyp9CN5oM2Dn2MJeqUqH7BNDawYhCashL/HVjQLnqGI0zU97HVUfVGIV39S2h1iDInIrOwbi1F2+BzkEle/bwS2gBTrxrwzDBZcLvUtop+dJ8uAdLDhVp+0ryX4nDSt8XD4ZXKjbsEehTChIfs0K3EMuKxSbevOhLUzKZ2l0kNMX0BmaT/plH0d1XoyoXmK/eeVn83+d9WlcizxNbaK7XINIifM++h1kTUeCVij7+LtKFDyUoU5h7JEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9V6mfr4SBhb+gQojdILnDb8H3K/NIObrEFdEfJHi4q0=;
 b=Vo13z3mHfZd7SEVDdIj7p46GccrI27O/iPRulocFR6jwJSynRDL/cGK+vnY7fZ4lKQSpqSU0SvE//drIMUrQnnYhuVBhZY9edym6F4Nl03/QTLE59IcvQfhkV617VAD/pReGpWKWAv6J7sS7Q1zpBw1vNfHAaOJ+ybHk1qR24g0YsvSDSst/Aqe4RuJjDLunSMHfqelz75TmFUHa4s4iJliL3I2bxrPibjBacJqg47qRqpLeB7F7e1f7hTLgMqPdQPtWoEQghUfOVhmj82tKrIjqabW2EYmQ9s/4seusLgTHvqC85gjRuvkMCl2f6HjAKJULMFeVJlTHfIPHQ+e2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V6mfr4SBhb+gQojdILnDb8H3K/NIObrEFdEfJHi4q0=;
 b=kqNuvmr+AAlKdLvbxReSNja3c1OZ3JU6RkE1904sIwPGmizw+7kpX1JYZLv4aEavPo6jQP4zMBrsoliUIIvhtgmtQ/3oZrfeGMdxk+gqqzh6HdVyzB05+Grl+4v05L/ovqgONQVgR6WKLtgIrdz+ojC0lLLdFHBueeSxna5tFsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB2695.namprd12.prod.outlook.com (2603:10b6:a03:71::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 03:32:27 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 03:32:27 +0000
Message-ID: <81d49805-62f9-c99b-5a4a-084cc37e7529@amd.com>
Date: Tue, 11 Jan 2022 09:02:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: correct the checks for fan attributes support
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220110060042.3159997-1-evan.quan@amd.com>
 <1a71e156-5e04-6d49-53c2-c8ec83e2ce47@amd.com>
 <DM6PR12MB2619C547B8EF3BAA36534AA5E4509@DM6PR12MB2619.namprd12.prod.outlook.com>
 <bd2c0fd8-5cc9-fd6b-b091-538f943db640@amd.com>
 <DM6PR12MB2619A6C0FEE5C915B410E01EE4519@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619A6C0FEE5C915B410E01EE4519@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5382a63-86e4-4f4e-d96b-08d9d4b2fd18
X-MS-TrafficTypeDiagnostic: BYAPR12MB2695:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2695FCAD6A3582A7DAC4B01097519@BYAPR12MB2695.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGz8ojmBCxk22BhgP8pZ+D3dvPS6Gkt5wNnqbqg9pGQ8FMCVPqaI2vLPQOZdWSVDLKFqmd/yAuJDmMDNAuV1WCszQ/gK+LzrscX5vzLpnO75CGeD7/sjiaXJZD4H+qAWEthrJKRQMlMYg4gBLX/CUu6CQFqqkRVmLQb3MfASbAJJfeuO/zqbMK91klEdknNG467CaVJhxXyoZ9UiNTxPquSda29Ybf3e4R0R9Hz9B9hVwwDNjHRenLA5F5DGkvdnqFrV4OUhJeojJ3rcSaAs1WgSj5VHnRj2jHSbIICEm0tQ/xxIcTdpf/xfkQMUPI7tNIbYQ+1s+Q9yXUxUwZT1OJwE/X+1Nvl+khjuw2WsMV4rMfPAtvDh4mQF/XbC5wGGQnZFK6q4ms46MUfHfK2gTiuND3maxSU8scL7FQ+kuF+Xh6Nn7UBQnKaEruLvpumZ+UamYrnPvO716hoNgerNHb4VfOh9d6ZO1elu9Eoc8+dzvfSoPrtog+F59rzndMGsrOI4HxyUsFJTFrIcBq4bFczVQgghTAocI9Ghcp1J1dkRVD8wTQyCQJMIm6nRfC2W1CbdvCWU2Ut+Ep4Cnkq5CwssSJ8zYyVuvzUOA2yTXgVf6QuYyJcdmtt+R89LyZRpW4ovfV/DY9iKhN37erK0YUFmgtoYXcxfl35zhjbFJnd7n7GHH7YFXZHfx+vu31MDdyfIGRQti5mejLas/Ts7/uW/3UQQSJBjT4jXfteropB5wFmRvv0cJHL8Dr553EXX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(83380400001)(38100700002)(6486002)(6512007)(2906002)(5660300002)(110136005)(66476007)(66556008)(508600001)(36756003)(66946007)(2616005)(8936002)(8676002)(186003)(6506007)(53546011)(26005)(31696002)(6666004)(316002)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SElSako3cTJMcXdjNEliUjluM25Gd2Vnem5YRGIyaW01TmNGUXNxc05hL1lS?=
 =?utf-8?B?UXJMTDh3RGhqVTVZbjBFWjV6L0l3T2krZjZRa1huMkpWK0lEOXU4djV0azgy?=
 =?utf-8?B?UHdCZ2p4Z3JEWkhUdHVseS94dzNiRmIzREdPTkp0d2RldkF6SEN1MGFCTUZZ?=
 =?utf-8?B?K3dtYzhEUXl1Ym4xcDhoZCtxODNyNmt5UWJtNTVFY3FWL044Yi9PRFd5Rkxq?=
 =?utf-8?B?UmV2cmVQYUUyWVAwcXA4cWZXWXdoMVFtQjd4YTlQdzhBNDFWVE9pQktTSnFQ?=
 =?utf-8?B?TEhvWFArS3p0MVdEK3NoZXdjL1VUVERkOTJVZGcwWThwK2x5NCs3bnBscG5m?=
 =?utf-8?B?MWVpV0dHeEN3Ry93c1FzMjBFWmVESXVZUGpON2xJZjc1WldOL2FTN3BBZU9X?=
 =?utf-8?B?T1hrcTJ5b1F3NURvOVh5SkhqejZxWlIvbHhPa3ZMRkV3RlV5WWZrQ1VMT205?=
 =?utf-8?B?YkR5U0hQMUZzMS9pY2Z5RG9jRGdURXAyOUFwK3ZDTnJnUWsyZ245VmJqQ0xk?=
 =?utf-8?B?aW9qa0tHWUEvTXpHdW92SEU5SW1JR0FROVB6d2dhRDZNNFRiK0lLa2FnQ1R0?=
 =?utf-8?B?MTV4b1NyU3lBdlRMNjZTMTZaalhVMitiVnNZcXhhTFg3blIvY25NUlN5Vzl6?=
 =?utf-8?B?LyttWmFQY3ludUlFT3BETGxrcGpqVElUc3NnczZiUlpwNVBlalpoekJhU1Jw?=
 =?utf-8?B?QjBMVUdCRW5yWGFtL3hkam1VYjY2WFdzc0JRMUFZYWRSUnptOG9KbU5Ed3hJ?=
 =?utf-8?B?N2ZRbG8rZEdhNjQzaWRROTd0b0JVNEhyYUZBVzVTM0ZnZWhydk5aZ3RseWpX?=
 =?utf-8?B?U0p6VjM4aFFLVGd0amZGelg2MTc0dTJZS3I0Mk5hVms3Lys0aHNwakx4dDND?=
 =?utf-8?B?MUc0RXRZeVd1VDNMNUVVRFVLZU5yOUt3Ym0zM2xKeFhqREhjV0FMaU83U0lo?=
 =?utf-8?B?TEZRaHpwOSs3b3pQd2V6Y1dMZWJKWFVnQ2pKR0dnWjNHbXhyM1F6b0JUWHlY?=
 =?utf-8?B?VVpHTlptMXVhVlQ0UnM4bHl6YnVkaDBYb0tsTFRpVVRobGtkaVhUZStuaEFy?=
 =?utf-8?B?UWtHTVJ5NFY2OGtvWHJPSytXeERXcngwYm8wZG9SZHZWM2JkdnMvWXk0OEdU?=
 =?utf-8?B?bndtdW1SY1FVWVIrdUlJdXpSalQrajkwV21GZEk3V05YL2lFVlFIYTJpNnRS?=
 =?utf-8?B?L3YrS0FpcXJWZHhRd2NXeXozc1Q4WFJqTndNc283aFlIK0JVanVpZ2dWNkNS?=
 =?utf-8?B?Q2hIMlpHbXNMdnN1YlRGTEsySGpUTkdQVEJOMWxlWE5uNHU0RGVYUm51ZHJT?=
 =?utf-8?B?QTNlamI3ZDhTVnNuSVRXOHJSNzRYYy9DM09IUDU2dVJxRTcvV2J5Zjk0OWlY?=
 =?utf-8?B?TVUweEluZmliV1BuRUFnYUR3SUZkaUdtUmswZE8wcThjM2tjZ0Z6N2VOalNQ?=
 =?utf-8?B?cURpZ0JkbnE3bUtCbEpxMDArV052eVBtNzFzTDYwNUowTGg2Ni9KNmJqdUUy?=
 =?utf-8?B?SS94cWx3alVUWjcwSHRFbnRLVmdZemFVaE9sNFNFNzdBNjY3MDRzVXhsbUN2?=
 =?utf-8?B?UEptL0J3L3pOeWJJMXRYV21kSFlFZ0IxWldQdjRJcmVhbE0zQ1FhK2txTTZ2?=
 =?utf-8?B?ejBTdjFWWFdCWVU1RDNYbzl6T3lrZGl4YjVjeVJiU205MW45RWxZbmxnTlp4?=
 =?utf-8?B?NjBHUXQzNm1EV3RXaUE5Q1M1MHNpUDFyZ1F0bTRUZDNzSm5wQWNWSHozYm5C?=
 =?utf-8?B?TGcwTEZYM2RTSFZVUlIvM1lYeDhQRG5CT0J4dm1nZ1JHbkpmV1lEVzNPSkhJ?=
 =?utf-8?B?TFEwcmNGcjZsQitZUUZrMlJPVzNPT2tPbktCVXVER0xCRTVGS0xiOEJhalI1?=
 =?utf-8?B?VTNOSDFRZ0g0YVR2OHZvUFhCYVlKYTVYOGp0aUZmTE9BSGJuRnNtdTBsMGhV?=
 =?utf-8?B?MHhNTlpndzdlRUMzR3NueTZoYkp5V056L2tRSHFaTkdlb21UVy9XaHY5VGNv?=
 =?utf-8?B?Slg5QjJadTlhMkJPSTJqNWZSazVBVkpzdHZuVE9JQmhtNWl3c3lUdXpvN0Iw?=
 =?utf-8?B?TWhGQVN6cFhiYmU2MjhVVmp4TENRbGo2cGdDdUgrbHlVdVVoMWZVMkI0cWNE?=
 =?utf-8?Q?2PLw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5382a63-86e4-4f4e-d96b-08d9d4b2fd18
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:32:27.0166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLt5iULae9olz2wC0aSAfK9GrPrEkyo6GA4W7FSNKSws/aIgpO23YMFSv6GAAZqb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2695
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



On 1/11/2022 8:02 AM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, January 10, 2022 4:31 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: correct the checks for fan attributes
>> support
>>
>>
>>
>> On 1/10/2022 1:25 PM, Quan, Evan wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Monday, January 10, 2022 3:36 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH] drm/amd/pm: correct the checks for fan
>>>> attributes support
>>>>
>>>>
>>>>
>>>> On 1/10/2022 11:30 AM, Evan Quan wrote:
>>>>> Before we relied on the return values from the corresponding interfaces.
>>>>> That is with low efficiency. And the wrong intermediate variable
>>>>> used makes the fan mode stuck at manual mode which then causes
>>>>> overheating
>>>> in
>>>>> 3D graphics tests.
>>>>>
>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>> Change-Id: Ia93ccf3b929c12e6d10b50c8f3596783ac63f0e3
>>>>> ---
>>>>>     drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 23
>>>> +++++++++++++++++++++++
>>>>>     drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 20 ++++++++++----------
>>>>>     drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 12 ++++++++++++
>>>>>     3 files changed, 45 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> index 68d2e80a673b..e732418a9558 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>>>> @@ -1547,3 +1547,26 @@ int
>> amdgpu_dpm_get_dpm_clock_table(struct
>>>> amdgpu_device *adev,
>>>>>
>>>>>     	return ret;
>>>>>     }
>>>>> +
>>>>> +int amdgpu_dpm_is_fan_operation_supported(struct amdgpu_device
>>>> *adev,
>>>>> +					  enum fan_operation_id id)
>>>>> +{
>>>>> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>>> +
>>>>> +	switch (id) {
>>>>> +	case FAN_CONTROL_MODE_RETRIEVING:
>>>>> +		return pp_funcs->get_fan_control_mode ? 1 : 0;
>>>>> +	case FAN_CONTROL_MODE_SETTING:
>>>>> +		return pp_funcs->set_fan_control_mode ? 1 : 0;
>>>>> +	case FAN_SPEED_PWM_RETRIEVING:
>>>>> +		return pp_funcs->get_fan_speed_pwm ? 1 : 0;
>>>>> +	case FAN_SPEED_PWM_SETTING:
>>>>> +		return pp_funcs->set_fan_speed_pwm ? 1 : 0;
>>>>> +	case FAN_SPEED_RPM_RETRIEVING:
>>>>> +		return pp_funcs->get_fan_speed_rpm ? 1 : 0;
>>>>> +	case FAN_SPEED_RPM_SETTING:
>>>>> +		return pp_funcs->set_fan_speed_rpm ? 1 : 0;
>>>>> +	default:
>>>>> +		return 0;
>>>>> +	}
>>>>> +}
>>>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>> index d3eab245e0fe..57721750c51a 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>> @@ -3263,15 +3263,15 @@ static umode_t
>>>> hwmon_attributes_visible(struct kobject *kobj,
>>>>>     		return 0;
>>>>>
>>>>>     	/* mask fan attributes if we have no bindings for this asic to
>>>>> expose
>>>> */
>>>>> -	if (((amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL)
>>>> &&
>>>>> +	if ((!amdgpu_dpm_is_fan_operation_supported(adev,
>>>> FAN_SPEED_PWM_RETRIEVING) &&
>>>>
>>>> As per the current logic, it's really checking the hardware registers.
>>> [Quan, Evan] I probably should mention the "current" version you see now
>> is actually a regression introduced by the commit below:
>>> 801771de0331 drm/amd/pm: do not expose power implementation details
>> to
>>> amdgpu_pm.c
>>>
>>> The very early version(which works good) is something like below:
>>> -       if (!is_support_sw_smu(adev)) {
>>> -               /* mask fan attributes if we have no bindings for this asic to expose
>> */
>>> -               if ((!adev->powerplay.pp_funcs->get_fan_speed_pwm &&
>>> -                    attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't
>> query fan */
>>> -                   (!adev->powerplay.pp_funcs->get_fan_control_mode &&
>>> -                    attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't
>> query state */
>>> -                       effective_mode &= ~S_IRUGO;
>>>
>>> So, the changes here are really just back to old working version. It aims to
>> provide a quick fix for the failures reported by CQE.
>>
>> I see. Could you model on it based on below one? This is preferrable rather
>> than introducing new API.
>>
>> drm/amdgpu/pm: Don't show pp_power_profile_mode for unsupported
>> devices.
> [Quan, Evan] In fact, those piece of code from the mentioned change was updated as below
>          } else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
>                  if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
>                          *states = ATTR_STATE_UNSUPPORTED;
>          }
> As the access for adev->powerplay.pp_funcs from amdgpu_pm.c was forbidden after the pm cleanups.
> So, we have to rely on some (new)API in amdgpu_dpm.c to do those checks.
> 

To be clear, the model is to use a dummy call to check if the API is 
implemented -
	
	amdgpu_dpm_get_fan_speed_rpm(adev, NULL) == -EOPNOTSUPP
	amdgpu_dpm_set_fan_speed_rpm(adev, -1) == -EOPNOTSUPP

That is better instead of adding another API and flags for each set/get API.

Thanks,
Lijo

> A more proper way to cleanup all those attributes support checks stuff is to have a flag like "adev->pm.sysfs_attribtues_flags".
> It labels all those sysfs attributes supported on each ASIC. However, considering the ASICs involved and the difference between them, that may be not an easy job.
> 
> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>>> For ex: we could have some SKUs that have PMFW based fan control and
>>>> for some other SKUs, AIBs could be having a different cooling
>>>> solution which doesn't make use of PMFW.
>>>>
>>>>
>>>>>     	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't
>>>>> query
>>>> fan */
>>>>> -	    ((amdgpu_dpm_get_fan_control_mode(adev, &speed) == -
>>>> EOPNOTSUPP) &&
>>>>> +	    (!amdgpu_dpm_is_fan_operation_supported(adev,
>>>> FAN_CONTROL_MODE_RETRIEVING) &&
>>>>>     	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /*
>>>>> can't
>>>> query state */
>>>>>     		effective_mode &= ~S_IRUGO;
>>>>>
>>>>> -	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL)
>>>> &&
>>>>> +	if ((!amdgpu_dpm_is_fan_operation_supported(adev,
>>>> FAN_SPEED_PWM_SETTING) &&
>>>>>     	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't
>>>> manage fan */
>>>>> -	      ((amdgpu_dpm_set_fan_control_mode(adev, speed) == -
>>>> EOPNOTSUPP) &&
>>>>> +	    (!amdgpu_dpm_is_fan_operation_supported(adev,
>>>> FAN_CONTROL_MODE_SETTING) &&
>>>>>     	      attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /*
>>>>> can't
>>>> manage state */
>>>>>     		effective_mode &= ~S_IWUSR;
>>>>>
>>>>> @@ -3291,16 +3291,16 @@ static umode_t
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
>>>>> +	if ((!amdgpu_dpm_is_fan_operation_supported(adev,
>>>> FAN_SPEED_PWM_SETTING) &&
>>>>> +	     !amdgpu_dpm_is_fan_operation_supported(adev,
>>>> FAN_SPEED_PWM_RETRIEVING) &&
>>>>> +	     !amdgpu_dpm_is_fan_operation_supported(adev,
>>>> FAN_SPEED_RPM_SETTING) &&
>>>>> +	     !amdgpu_dpm_is_fan_operation_supported(adev,
>>>> FAN_SPEED_RPM_RETRIEVING)) &&
>>>>
>>>> If this is the case, I think we should set pm.no_fan since nothing is
>>>> possible.
>>> [Quan, Evan] Yep, I agree a more optimized version should be something
>> like that.
>>> Let's take this a quick solution and do further optimizations later.
>>>
>>> BR
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>     	    (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
>>>>>     	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr))
>>>>>     		return 0;
>>>>>
>>>>> -	if ((amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL)
>>>> &&
>>>>> -	     (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL)
>>>> &&
>>>>> +	if ((!amdgpu_dpm_is_fan_operation_supported(adev,
>>>> FAN_SPEED_RPM_SETTING) &&
>>>>> +	     !amdgpu_dpm_is_fan_operation_supported(adev,
>>>> FAN_SPEED_RPM_RETRIEVING)) &&
>>>>>     	     (attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
>>>>>     	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr))
>>>>>     		return 0;
>>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>> index ba857ca75392..9e18151a3c46 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>> @@ -330,6 +330,16 @@ struct amdgpu_pm {
>>>>>     	bool			pp_force_state_enabled;
>>>>>     };
>>>>>
>>>>> +enum fan_operation_id
>>>>> +{
>>>>> +	FAN_CONTROL_MODE_RETRIEVING = 0,
>>>>> +	FAN_CONTROL_MODE_SETTING    = 1,
>>>>> +	FAN_SPEED_PWM_RETRIEVING    = 2,
>>>>> +	FAN_SPEED_PWM_SETTING       = 3,
>>>>> +	FAN_SPEED_RPM_RETRIEVING    = 4,
>>>>> +	FAN_SPEED_RPM_SETTING       = 5,
>>>>> +};
>>>>> +
>>>>>     u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
>>>>>     int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum
>>>> amd_pp_sensors sensor,
>>>>>     			   void *data, uint32_t *size); @@ -510,4 +520,6 @@
>> enum
>>>>> pp_smu_status
>>>> amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
>>>>>     						  unsigned int *num_states);
>>>>>     int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
>>>>>     				   struct dpm_clocks *clock_table);
>>>>> +int amdgpu_dpm_is_fan_operation_supported(struct amdgpu_device
>>>> *adev,
>>>>> +					  enum fan_operation_id id);
>>>>>     #endif
>>>>>
