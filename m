Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF64FD9E3C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 05:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F28B10EA37;
	Fri, 27 Feb 2026 05:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M4126bSB";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A4B10EA37
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 05:40:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZM1b/qHiq0kE6kRWGjEirBcw3Zg6IemgtrdhWKrZL/ZSlsxE2kCVdy0aQbs7P8EQF52sIyX+qrYo5rZNbDOGcwILMgBesqJoHECRMh78RmxjqYHshU/WIRWZvl420g/bXff/Se+0mNom12CZZfvagXNnZmTOGx+hx8eyfyVEy24sBtk4jpoDlMq+TLKhSS8dn9A2S91HCfi6vqYDJ5vzxOi2nG6UoYYWZ92L7jj8NqndxGIf0gS+pCBMpj6A3CpFZskJ3TGgTVndK2FQnQpmQPlb/tCs9Xe0ZztNLVZR0FzbHUjg+7Qn9lK+Sv94KhwA3+mGnU5r+L3lkpyz1rIioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6v4V0zMDa3YE4hATDndzPVlHcjocvtS55ssIxkGDxBk=;
 b=zLvlle716S4EH/l33TN5iS+TobysvdjBzwTKlHasfH4os35G058ddHSous2ZRHYV9CaLnVvHSbFkeMxGB0HJqBVxKfJVjsI7wtAYUxe4oULzppW9XCyYusoDC8oINUe3uJYpZiicmRzPP5S86Wb7gtHtJXBBWO0L1cs43jZTeWNMud//QDW6n9/O+YF0PJq2F8ZhE2tQmKMoCoOLxLKEjBSRKeTQs9eW1HvTqALUvvTXewn3+WFKGTFK6sZmd3YSxkXvQWRbPtxv8LCIzJCPJ7spLLhlwReuodQd1HsSux/FtSUW6jokQEGCT1rHPly/o+6fFabXklfIr4tBXNxi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6v4V0zMDa3YE4hATDndzPVlHcjocvtS55ssIxkGDxBk=;
 b=M4126bSBLzx6wyyC1uZeXqgAdo5WOYQlbrHgILulvhWijKiF88UlAT+4B1301c0k4AjJYJ+eLvkK9ZItVmyUpBrkD9apTihQ6iwmcDWPLKC4LI4NfHrmXEDaXVg90KNzxqkt0snb0p7wicIjq5oN1Uoz+2soztxrEMu0FUvTJEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 05:40:19 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 05:40:19 +0000
Message-ID: <5accd44a-5795-43cc-acf1-a8467038b7a2@amd.com>
Date: Fri, 27 Feb 2026 11:10:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>
References: <20260225093406.498727-1-kevinyang.wang@amd.com>
 <96885b73-a1fc-4b3f-a35e-0177a415a331@amd.com>
 <CADnq5_O4u+v9f5XNFipKHPa1qC6tEr0k4ppZXX0tUqrAjY8PXQ@mail.gmail.com>
 <DM6PR12MB2972FEFE85BC8F6C684E25068273A@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2972FEFE85BC8F6C684E25068273A@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5e5c51-873d-479c-6fab-08de75c2b11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: r8pRxzr7UhNxwuzebmeiD7/Uu7fMozuCpwjFaITLkJYDTecntj6/AjJakJ8lxI8h8Rng3kG5O0/RvOttwNdaiaKLfa44LxnvkqYov8SD7Rl4u7uvRT2bW2nLOxsv06hXD7t3IT/w6hZtrTKeoQNa3M2Tfm/dBY4jTBvibKV72mrDt1nPTXBI4gVv3fTtdN/bqsKe5eV+lHkVUuJKBll3oaNSKqe2ggbAxJPc3FGQNm5mdmk2Tq9aQhvXbmh4sTdHoNxzWnoE2SB/eWe/4oon2F8l21e5zUDB5VpfbYRKiNptH36lK+GWzqfVnv+5gfbBG8mA+bhumjI/z7+viBZ37NXxrV6LtZn/78KYGpd6AFISm1TeXVq1+fENZSBGW5bV/EpvM5XxyNEzJUp0ImpvrVDaDL5NAaiSk+Pvz6B12wLTSTsIDHBjyo0xifZPf/M6ZE86FmnG9M1G9TORYmq9BSmIJy7KHtzNI1/ydX+ZmGIg4cmrXzJXzOfkDN0ztuUlBPwmePO6GY6HsAUX9AuBMrDsZSbC2/Pvih4sucq7iz4iNlefv1i/lsVhG0ajYHDTAFDCZB9uKMEz87YlrQO80kkAMv7+EOqaBv5v/6Xz8X3SR5KENhtpj6b0yJLDFsgPX4TUJqT75SSBbzN5uK7aj6ThJtyMgOtBhYcmV0/w9nsB5rBvFLLBgH9iNLdp8TwX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW12V3dmYnRyWk5STHlFek1TcW96OTJsVWRrZGNUV2duSkIxNEViOUZ0aURi?=
 =?utf-8?B?VldIL0pLdTlSMTFLOEJaYkxjRTFNYmhlTTNTYkt0N3hIZk10MVlycWUrN1Ja?=
 =?utf-8?B?ek5xenl4SzVlTW1LNTBUaFlsSHNFNTZ3U2xKbmRxN2Rna21QM1Arc3NNeTZn?=
 =?utf-8?B?SVFYLzcyRGhxaW5IUXAycjEvaGpTWHNRcFVMcUUxc25xNis5OG9LU0piS0ZM?=
 =?utf-8?B?bFFKazhUUVZraFZEWEJsMjhnekNTOFJNUkRGM2FNYUEvWnhsdDR6NEtQaTcw?=
 =?utf-8?B?eitUa1V4NTRQTDdsNU9rVzlLQVh6ZWU0anRmUG5YS1ZBRlpqRlgvYWhDSGpy?=
 =?utf-8?B?M1JHZjRkcEtUS0wxRUoyOEx6MDhWM1p2aVBlSTRhRmd2MVM0aWVjanJ3dGtI?=
 =?utf-8?B?WndmL205bC8xTTZFNmRHbFU4cERWdWRhOE8wSi9VZzFnRlJPenJwSFNMZWZy?=
 =?utf-8?B?cis0T2hySDlyK2R5cHlGZVVnMWdvbjVRbExFanRBMmQ1ejEwdVExby95NjdW?=
 =?utf-8?B?ZEtvNEUrekhHQ0dMM0tEc1BZdnBBQVJkZDhHVlY0ZUI1OGhhRFJaQ2lMbytE?=
 =?utf-8?B?R3VtVnd0amJkR0tXcEJSQlJybi9UcFRoUk9yb2Qwc1ZZR3ZrY0E4c2VVWVpy?=
 =?utf-8?B?TEpWeThOSGQrK0N6K1ZSV0kybDVDYWc4WkMzU1FrdWJ1UWRWdDFiM2pnZmhy?=
 =?utf-8?B?RUp0bk5xTmd6eGlxNXV4TzdzdE1BN09DUHpUMHVZakVhRGRJRDI5UTBlS3Fw?=
 =?utf-8?B?c2t5eXZXZG10ZDUzSDRvZUJGZXhhL1lZY2RLZXU5ektEbVJoZjJrNW9ReGp2?=
 =?utf-8?B?TkFhSTZVZ2xnSFJqWko4MTVNTHVPMmJTRUdyY2tsMnRlZWdiYUFiU2Vack1j?=
 =?utf-8?B?SUl2akR6L0V6WVNJaWJnYXZVOGZ2aTg0VkpMSnd5cWNKMkJGdzBjeDFCb1d3?=
 =?utf-8?B?dW9jMUNic3pkWWMyUTArL1FCQXRpdmZJcklpQWNMbFo3S1ByajhnWUhkZEJ0?=
 =?utf-8?B?MzZablUwRE9pK01mZndraG1LdjJKTmRKUW9kckZsQXZiNGVwSWtPeUpaQVQr?=
 =?utf-8?B?YTAzcjgxVG0rUzdmekJ6R29aWEQ0VFJyYnJ4SWorQUp3WXJCaThyTG5sTERX?=
 =?utf-8?B?bW5VaHFwK3FaTnEvUFFmN2haeG9hUDRld1N0SWMyTmNIN1V3L3pVOEszOHJy?=
 =?utf-8?B?UittbmZuRFQ3Nml5ZURKcXZPOGxLaHUzS2w3OHVHM2wwR2RGMC8zemMvWW5L?=
 =?utf-8?B?c3hkRzUwZG1iRHNrdCtvSWJQejVwQklWaHpJa2RJZ0c4Sm9BR01QRFRXUGNG?=
 =?utf-8?B?REI0ZVJvcEV3M2Zra3preXJVTUswWTF0VWxMWlBqVUYzYkVhS2xzTkFDR0Ez?=
 =?utf-8?B?ek9iMmxsU0FrUzlTQ0hJSVdVQi9panZQT0JIVEN0VUpxOTUwd3VyWTMwNHpr?=
 =?utf-8?B?cXNESFZxdHd4MCtRL0lYS0s0Tkx0ZXhEOUdlWVBRSFFHbVFlc3crUGNETFZF?=
 =?utf-8?B?RGpLN2p5SDdMeXgyUjFpYU8reW9NZDBIZWxjeTl2ZzN2bjl4NUsxSy92UGNJ?=
 =?utf-8?B?OWhLaVBuZUMxaGRTSFdHY29ZSTZsMWNLdnRrSmZrSi9Uc0V5QmNUWjNDZnNT?=
 =?utf-8?B?aHRHc2JFL1g3d2JnM0dMZlVlWlJJZEd1azlHcW16RVlDNi9BejhmTUVNdDdE?=
 =?utf-8?B?KzNnMURtS1M3eEk5ZzMwZjdMdlloZjU2czJLS3Yydy94d1JjYmQ3K3VMYkh5?=
 =?utf-8?B?NkFqam9kSnNMQnlIVjh4ckg0Ymp2aFhPRHhyZXpKOVJRc0QzNW9jaG9UWnU1?=
 =?utf-8?B?MzhLenBrK3VJWnc1d3Y0UGZRSlRiY3lLQ05KQktGUlgxeGtlUllreUVGYVBo?=
 =?utf-8?B?SkNscjRHb2ExYVZUZHlvSVVReHo5WlJlMDZRSWIwUjM5TjFIcm1kclR0akJN?=
 =?utf-8?B?S2FiT0MxTWNVYnFmMnhMQUxYbHNjWk5ZVkhFWHkzVG9zeDRCZFFBNXlFVm1I?=
 =?utf-8?B?bTlwMGhYYW5GQklFckhGU3NkRFBZN2JaOTl1eTZCTHhEcUwxeWdHamJiYTZF?=
 =?utf-8?B?ZDNHNWdjWG9LbXFEc3E0RHViMGZWVS8vNTA1U1RWWmVqU1lJVCsxOFdLcDNV?=
 =?utf-8?B?c2ZTaW1BanZ6Z1AzRnFheDgxeWFlRWlaR2xKNm9iRWs4RUZPNWc5ek5XNVdv?=
 =?utf-8?B?ZDFacVpFK3M3NzBHSHM2T2p0U1oyWGQ0N1hsTTl4VE5LYzJZWFFnVmVQNEQy?=
 =?utf-8?B?NUpoU0dUbkg1aWVueTlQUGxkMWVCM0VsQkJ1SFBsem1aTXE1dzhtcTFhSDNm?=
 =?utf-8?B?V0JZVzlzVzhuR0hvOUx1OVVBVHhmeFJONFEvblJHL1B3T2JNQkhZZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5e5c51-873d-479c-6fab-08de75c2b11a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 05:40:19.2097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBQXtPY6emhnF/DC6I6Q59MsAdndehKWEacSg/2s4Zh0up7FQKs2scLxbJ7/3Dpr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
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


On 27-Feb-26 10:14 AM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Ping...
> 

Please restrict this workaround to the affected SOC. Otherwise, if there 
are bogus values, we will fix it at the right place.

Thanks,
Lijo

> Best Regards,
> Kevin
> 
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, February 25, 2026 10:24 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
> 
> On Wed, Feb 25, 2026 at 7:14 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 25-Feb-26 3:04 PM, Yang Wang wrote:
>>> Limit GPU/MEM/VCN load sensor values to 0-100 range via clamp_t to
>>> ensure validity.
>>>
>>
>> Is this a workaround? If it's not within range, it indicates some
>> underlying issue.
> 
> Likely for:
> https://gitlab.freedesktop.org/drm/amd/-/issues/4905
> 
> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 +++++++++++++++++++++++----
>>>    1 file changed, 23 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> index 938361ecae05..86ef1ffbf1dd 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> @@ -1414,20 +1414,39 @@ static ssize_t
>>> amdgpu_set_pp_power_profile_mode(struct device *dev,
>>>
>>>    static int amdgpu_pm_get_sensor_generic(struct amdgpu_device *adev,
>>>                                        enum amd_pp_sensors sensor,
>>> -                                     void *query)
>>> +                                     uint32_t *val)
>>>    {
>>> -     int r, size = sizeof(uint32_t);
>>> +     uint32_t tmp = UINT_MAX, size = sizeof(tmp);
>>> +     int r;
>>> +
>>> +     if (!val)
>>> +             return -EINVAL;
>>>
>>>        r = amdgpu_pm_get_access_if_active(adev);
>>>        if (r)
>>>                return r;
>>>
>>>        /* get the sensor value */
>>> -     r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
>>> +     r = amdgpu_dpm_read_sensor(adev, sensor, (void *)&tmp, &size);
>>>
>>>        amdgpu_pm_put_access(adev);
>>>
>>> -     return r;
>>> +     if (r)
>>> +             return r;
>>> +
>>> +     switch (sensor) {
>>> +     case AMDGPU_PP_SENSOR_GPU_LOAD:
>>> +     case AMDGPU_PP_SENSOR_MEM_LOAD:
>>> +     case AMDGPU_PP_SENSOR_VCN_LOAD:
>>> +             tmp = clamp_t(uint32_t, tmp, 0, 100);
>>> +             break;
>>> +     default:
>>> +             break;
>>> +     }
>>> +
>>> +     *val = tmp;
>>> +
>>> +     return 0;
>>>    }
>>>
>>>    /**
>>

