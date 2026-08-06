Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21014C55ABF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 08:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B20E10F117;
	Thu,  6 Aug 2026 08:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FT1SxNIj";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A17E10F114
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 08:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLlZVxVZzHmDg+4oYcWa3xBkC0guzyLBjPkJnYWVSLb9KxkT8StZLeh9AVCRvKHE/Nz9g7vL0BTcHmLEO2Okt+WCm6/g6/O9yfXccdJVkUcSLmgIETjT5MKMY3Wvx44FyiakCC21hGOvgRMvuCBd6Z6EAdkbqitJlYO9YmsRtD1VkefH3oqk64qtny4foGby0Nuc/ZvYHNXlFA+3iHL3sQUjY9tI7xn/Ixa2yGomzduwLTlnYVbC0x23S9Oi8Em9HYY9sujedb75FibUqXjfQbuTOH29AH/EZAztJZ77dsyGJ3Yg4dAlSu27ak5ZTT43nOiPm1gcA/Z2ytNWGKSbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avnO08pCMo6rxWCHtzqwSp1Tck0dI+NRAljkF2/di5w=;
 b=Apaxc30u28Xyyf0bg2QfwLI5mGurr9pMrPp9TXaIb8bt+muxK4xJaLExm6j2K3n+5ekMcO1fomZt+19Qdy5hn3KRsmSNC6NFkU8M42DjNspaUiXJ1SquZVK37ou29zyZhwt6qcQO+G6W9v3iVzVTO/fz5ashoM3RZ6XIMecJJUPCp7lA62u2b5AaXf5TITOMrhYXwh4XusjNrhSaAdPtmzmTlakYO1zkDfT6fcA+XI2tdgiyyERel+i/UzMxx9F5EijHjvOmMQebbJ67r9VoULQlR+/qqeCBDUhx679u8ufmxi5pSOGe0tfKPrmdWotffcatEh0wPtqNdy6Yz5BEdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avnO08pCMo6rxWCHtzqwSp1Tck0dI+NRAljkF2/di5w=;
 b=FT1SxNIj9Ga6yu0TMBFKxDm0YaGdWmAGdqvaDb8T0SeaegB8/lcYkxBYTlkhaPHYKFYnHsjmY0Q9Z04qd8rv8ikhkA4i4jmdTX/Thvsl6Cg13jGA/01Oohy5Rx20FfhZ3PyZGkFE0e3TAG6gibY21aeFmBjfgBfg7zWzlSJlis4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS4PR12MB9745.namprd12.prod.outlook.com (2603:10b6:8:2a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 08:04:37 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 08:04:37 +0000
Message-ID: <422ba92c-8873-4b8e-b4ac-e1c1feae0fdb@amd.com>
Date: Thu, 6 Aug 2026 13:34:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Track current PPT limit for restore
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>
References: <20260806061413.3720389-1-lijo.lazar@amd.com>
 <BN9PR12MB52110CD725737790A39A3E8682D22@BN9PR12MB5211.namprd12.prod.outlook.com>
 <024580be-2d0c-4ceb-8155-c276c63e0d4c@amd.com>
 <BN9PR12MB5211B0562AA983BC39E5A66282D22@BN9PR12MB5211.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BN9PR12MB5211B0562AA983BC39E5A66282D22@BN9PR12MB5211.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 776db395-01ed-467a-17cc-08def3915c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1Mj8nhlIYmzcClmOdDKbYlDuPi0dztnLwFYYRNLg5nV6KsGHr2yGaae7h99d4IrpipNHhXbhRPVNrw/QsbAAozdyGRHqjxtDLVIMEj4wFi1DZvqQx8RvSnovs9ZYVADq52oekyMSvZjZr+oUCro/sFO/tBnhDdw0e5ZGW1/UVVaNRTSQ5vaPusQl+Tsh107y66Su4RtA9M9jXPBd12G2iCxA4W5/T6TKAWWFSPNVCObNwrkZwkqZYzhYe4P/wpaYTDSC61a6atu8o2Sn+oKjl07MsnVeSbcicg/Tzj9WsnFa8ass4sfAhTPv946XKLwEZN3kvl4Tj8IHVWrkiD4V4U0QrGcYh2qv/hrXI9koccj/zZgWEgZ326QGP6tEL8ck6QCzpglNEDldJqtb07NaUMlZSOEHUv57lGBMOqDO/+PneEwUe+gfMoNMaQRJTrwF03OdcmPx/21G53Nizb2ihFcFB8asbH7PdPYB8+XZkK/9d0HZICPPIIpcQWkKpXYiiaWiE74bCpMz6yfI6ALugQsTY8iFZoSOsHcLfK7TG8K3FmE+uRe0bq2Xhtutqyd7t5vQ0j7Pfw2wIDGWoTUmnOvkoKnaLnMES1QvSojGVFcXRmsYIO7FIR2oS+dCtGyKXCMGarZl2Xz5u1mJHvITlP9WDfpuTBf3/rSIUeHGbqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckVoNExCby9Oc1lVUjcxRS9LMnZPSWhiQXZqSlNXcWYwRU5yTFl6V1hRa1N0?=
 =?utf-8?B?aTJ0MlNQd1luYlZESU9QSXJsMThTY0ZLRWVKaDV2SnBzU0xkMDQ0eVJwQ0E5?=
 =?utf-8?B?TVY4N0Y0MEpiNy9TbS9xY1Awb1liRWtDY3M0U3B4UzhhRkhzbHYzUk1lNjB2?=
 =?utf-8?B?cjRKYmJ4ekRzZENLa2k1eldIeVVodU55TDY1OXdVNXEvM1k1RWdHM3NrSFhQ?=
 =?utf-8?B?cTJXV2xEQndld0IzNWRFUTIraktnVURaT2JZamlBSEpteEE2NGJreXZwWmtD?=
 =?utf-8?B?ZWNQMWhCdVk4WTV5cmJhWEYrU1VoQXNjQ1JaVEJrT0g1cEdKRmluMEV5bG83?=
 =?utf-8?B?RTZCTzZ3cFBoalVqOVdSd1QzLzFSMXRIUE1rNVV5QVNEeDhQeHU5Qm0vR0xK?=
 =?utf-8?B?ZWxYc0RhanptUStDWHNRRmtZbHdOdGtUUDBZNFVIUEhJRE5Nc0NLZU9MVnYv?=
 =?utf-8?B?VGl6cFBlbFR1RXo4R0VNOW50Mzl5SG5xNE1sZzJWUklad1R1U0Y1Q2xyQUVE?=
 =?utf-8?B?dHQySjNCS0dQVUp3SmhjaW8xNEU0L1BhR0Rub2VxL2phdng2cisvUkliVGRh?=
 =?utf-8?B?V01JOS81SU1UbGdSdmtuaDZrRXhVNXBLYUNuRUxEL3dkZm5DNngzVnlLcmQw?=
 =?utf-8?B?ZFdyWFFRNnVMTjcrbURydDJieXBNNEFsYk9RVG84N2xuZTlQa3R4MDVidm8y?=
 =?utf-8?B?ekVTclZNakhTbzRDL1A1M3MrSEhnTzcvQnhyVGVabXUwcVpzYkVtd2FOMDhL?=
 =?utf-8?B?MEJlY1RWUnZMWGNpL0lBVHJLNDdreXBicWgzZ09TZWY4TGZZTVdybk0rNmt1?=
 =?utf-8?B?OEdUUEZtQVlnUzdycEprRjlhaW4zb0JCTlBQREFJZnN1dW9pdHpqdysxbTVC?=
 =?utf-8?B?WE5xZ2xlWjVwbTRROFpnTW5CT2dycEZkZk9wV1NJalF4UG5zK2trUUJ4TEdT?=
 =?utf-8?B?SzdHem1YMUxMOVNUR0dGazc4VGZhRGFLbkZ4eTJYK3JEWjJHdDBIcHk0N3Ir?=
 =?utf-8?B?V0VuNEZuYTBERzJwZDVaRFlhWXVyVERuOGhMK3hBQTIxditiVU5YdExNd1Ir?=
 =?utf-8?B?VTd2SHZxbjBIdDF2MVNwMkVNSVFzL2h1Zmw2Z0JocWptdEZsUTRtdzdBZ0c0?=
 =?utf-8?B?ZlJXSmhzU25VQ1ZNZGx0ZFJvL3piQ1lHSHcxbVkvMjd0NzhBZjFBeEhVejlj?=
 =?utf-8?B?czlJWVFNc3hSNWdDblJnNHgrVSs5Wnp4emxmYkNNSTRvMGcwMmFmM3JJanRr?=
 =?utf-8?B?RSs1TUN6WU1kdUI3ZzFWdmNWVEZDNmhFYmxsdjNuQUxweWlwS1E4YU96Q3hn?=
 =?utf-8?B?a3RwYi9VMVBOZzJZcDAvZ2hJVUNtbnlKcFBuOTlZU3Q0WGpBeGUzWEpSa0NJ?=
 =?utf-8?B?SlFmd3RvdUFkM1ZiRFFSUG45VllOK2Y2RU1ZeVdmeFJGTzRQZWNwNG5nVDc2?=
 =?utf-8?B?OHJ4QysrRjZ1dzRpejdLdHNFeHpJcys0eEFhS2hNbFd4UVdSVWpwNGUxYUsr?=
 =?utf-8?B?SUdPeWV2M25wSFE0c2ZQZVFBSDQ0V3pLdGtWWlo1V2Q4QzRkc3dkZjMxRHF0?=
 =?utf-8?B?VzZyQXZxcUo2QXlLTkRIRmRBcXFMcmRqUlh6TGs4UnNWdC9wWmx0VEprNk1C?=
 =?utf-8?B?NnFjK28yMFVkVFloQmJZUkZ4ZVUzcWRuUlE1a2pjVEgzVlhjbmxQWlhJQkE1?=
 =?utf-8?B?cGhJcGFhRlFBRFM1ZmF5M0pMdFhZRHNWcEk5ZllYU2VURE1DSmJZSUszSmZz?=
 =?utf-8?B?NXo4V1pvRXpjaEVGb0ZGa2krU0E4TVByY3oyTFo5WlprMmdhVjA3TkJQb0dH?=
 =?utf-8?B?RzZJbzB3djE0R3UzRVhqME1xeXAySUZCVndpVnlNdW40QmxSWnA4b1RQR3Rz?=
 =?utf-8?B?Lzk4enA2dmt6Z042Q29SL0ZheThaRUVHMEV3L3dPRDNvbnVneVhMRmxqa0I0?=
 =?utf-8?B?NWhuaGk0NldoZEN6cUdDbUtpNGhkSS9MLy9ZcVBjOHpjL0l1MlBxWm5SRjVr?=
 =?utf-8?B?TXJNVlpzTVRXNlM2dU9qUjFWdk5BMmMrSDRFS2dnRkhvMFNTZ2dSSDZBTldH?=
 =?utf-8?B?eEJwc0s1YVlIL0IvV1NLWVBYMzRBanYzSkVEYmpFbFRXaE1ORXEwS0piTEtx?=
 =?utf-8?B?WnZwUlU1ZEZRdGswd1dVU2tpVXdYSGJJS1BtNzVpc0pwRHkvdDQ3NUJhZlJQ?=
 =?utf-8?B?VGVrSkFkOFVhVVI5amJsQ0YvSUtaOVZNMjhXTVFHMGV6K2lvTldMYjZLQVhS?=
 =?utf-8?B?bzJyR1NKRnc0bjkxQjJYYTdxajBEUXdML1RsRFpWOXRod3hNdk9qaG52S0hz?=
 =?utf-8?Q?h9upRbsZGTkdA+XHKx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776db395-01ed-467a-17cc-08def3915c0f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 08:04:37.7561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfzvLH/V7Ibrg3dcuwnunCbHX243JOfs5ee+ssunvgottnEMOEPRfHo0sy+b12rD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745
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



On 06-Aug-26 1:26 PM, Wang, Yang(Kevin) wrote:
> AMD General
> 
>> Driver triggers resets which could relaod the whole FW. In such cases driver
>> remains responsible for restoring the last known power limit. The current
>> method doesn't do that.
> 
> No, the original code already contains this restore logic, include suspend/resume + gpu recovery, and save/restore logic has been verified on Navi21 and Navi48 ASICs.
> 
> And the if no user edit power limit from user side, the driver will skip restore power limit, in this case, the driver will use default value after firmware reloading.
> 
> btw, your change will break gpu od + power limit logic in navi3x/navi4x.

This patch doesn't break that. Whatever user has set as the last limit 
will be the current limit in Navi3x/Navi4x case. That will be restored. 
If user hasn't edited limit, current limit will be equivalent to default 
limit and then it's not set again.

> 
> So What issue you have facing now ?
> 

Driver remains responsible for restoring the state triggered by inband 
actions like suspend/resume or reset as OOB doesn't monitor everything. 
In such cases, driver being the inband owner needs to restore the proper 
state after the event.

Thanks,
Lijo
> Best Regards,
> Kevin
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, August 6, 2026 3:48 PM
>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: Track current PPT limit for restore
>>
>>
>>
>> On 06-Aug-26 1:03 PM, Wang, Yang(Kevin) wrote:
>>> AMD General
>>>
>>> I do not agree with adding a read-to-cache path for the current PPT limit.
>>>
>>> The current limit is PMFW runtime state. A read of that state must remain an
>> observation; it must not implicitly create or update driver-owned persistent
>> policy.
>>> This separation is intentional: the driver keeps immutable capabilities from
>> the PPTable and restores only limits that it successfully programmed itself.
>>>
>>> Caching a value returned by GetPptLimit would turn a potentially transient
>> or out-of-band PMFW state into a value that the driver replays after suspend
>> or reset.
>>>
>>> There is no ownership, notification, or synchronization mechanism that
>> makes such a cache authoritative, so it can only become stale.
>>> and the existing user_dpm_profile policy *CACHE ALREADY* handles the
>> supported driver-owned update path.
>>>
>>
>> The existing path also doesn't have any synchronization with out-of-band, so
>> the same argument holds. i.e., it overwrites whatever set by external source.
>>> If no bug fix or feature improve, please drop this patch.
>>
>> Driver triggers resets which could relaod the whole FW. In such cases driver
>> remains responsible for restoring the last known power limit. The current
>> method doesn't do that.
>>
>> I will add a bug fix tag as the previous patch doesn't restore the current limit
>> properly.
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Best Regards,
>>> Kevin
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Thursday, August 6, 2026 2:14 PM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>;
>> Wang,
>>>> Yang(Kevin) <KevinYang.Wang@amd.com>
>>>> Subject: [PATCH] drm/amd/pm: Track current PPT limit for restore
>>>>
>>>> Cache the applied PPT limit in the ppt limit range and refresh it on
>>>> every get and set. Initialize with the default value on fresh load; a
>>>> value equal to default is treated as unset.
>>>>
>>>> On suspend or reset recovery, restore the cached current limit when
>>>> it differs from the default, falling back to the default otherwise.
>>>> This replaces the user- mask based restore, covering limits changed
>>>> outside the user profile path as well.
>>>>
>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 39
>> +++++++++++++----
>>>> --
>>>>    drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
>>>>    2 files changed, 29 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> index f45cd4e31415..7edd919a7832 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> @@ -495,16 +495,11 @@ static void smu_restore_ppt_limits(struct
>>>> smu_context *smu,  {
>>>>         enum smu_power_src_type power_source;
>>>>         struct smu_ppt_limit_range *range;
>>>> -     uint32_t restore_mask;
>>>>         uint32_t limit;
>>>>         int i, ret;
>>>>
>>>>         power_source = smu->adev->pm.ac_power ?
>>>>                 SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
>>>> -     restore_mask = smu-
>>>>> user_dpm_profile.ppt_limit_user_mask[power_source] &
>>>> -             smu->ppt_limits.supported_mask;
>>>> -     if (!restore_mask && !restore_defaults)
>>>> -             return;
>>>>
>>>>         smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
>>>>
>>>> @@ -512,14 +507,14 @@ static void smu_restore_ppt_limits(struct
>>>> smu_context *smu,
>>>>                 if (!(smu->ppt_limits.supported_mask & BIT(i)))
>>>>                         continue;
>>>>
>>>> -             if (restore_mask & BIT(i)) {
>>>> -                     limit = smu-
>>>>> user_dpm_profile.ppt_limits[power_source][i];
>>>> -             } else if (restore_defaults) {
>>>> -                     range = &smu->ppt_limits.range[power_source][i];
>>>> +             range = &smu->ppt_limits.range[power_source][i];
>>>> +             if (range->current_value &&
>>>> +                 range->current_value != range->default_value)
>>>> +                     limit = range->current_value;
>>>> +             else if (restore_defaults)
>>>>                         limit = range->default_value;
>>>> -             } else {
>>>> +             else
>>>>                         continue;
>>>> -             }
>>>>
>>>>                 ret = smu_set_ppt_limit(smu, i, limit);
>>>>                 if (ret)
>>>> @@ -875,6 +870,21 @@ static int smu_early_init(struct amdgpu_ip_block
>>>> *ip_block)
>>>>         return smu_init_microcode(smu);
>>>>    }
>>>>
>>>> +static void smu_init_ppt_limits_current(struct smu_context *smu) {
>>>> +     struct smu_ppt_limit_range *range;
>>>> +     int i, j;
>>>> +
>>>> +     for (i = SMU_POWER_SOURCE_AC; i < SMU_POWER_SOURCE_COUNT;
>>>> i++) {
>>>> +             for (j = SMU_PPT_LIMIT_PPT0; j < SMU_LIMIT_TYPE_COUNT;
>>>> j++) {
>>>> +                     if (!(smu->ppt_limits.supported_mask & BIT(j)))
>>>> +                             continue;
>>>> +                     range = &smu->ppt_limits.range[i][j];
>>>> +                     range->current_value = range->default_value;
>>>> +             }
>>>> +     }
>>>> +}
>>>> +
>>>>    static int smu_set_default_dpm_table(struct smu_context *smu)  {
>>>>         struct amdgpu_device *adev = smu->adev; @@ -1911,6 +1921,9 @@
>>>> static int smu_smc_hw_setup(struct smu_context *smu)
>>>>         if (ret)
>>>>                 dev_err(adev->dev, "Error during wbrf init call\n");
>>>>
>>>> +     if (!adev->in_suspend && !amdgpu_reset_in_recovery(adev))
>>>> +             smu_init_ppt_limits_current(smu);
>>>> +
>>>>         return ret;
>>>>    }
>>>>
>>>> @@ -2999,6 +3012,9 @@ int smu_get_ppt_limit(void *handle,
>>>>         switch (limit_level) {
>>>>         case SMU_PPT_LIMIT_CURRENT:
>>>>                 ret = smu_get_asic_ppt_limit(smu, limit_type, limit);
>>>> +             if (!ret)
>>>> +                     smu-
>>>>> ppt_limits.range[power_source][limit_type].current_value =
>>>> +                             *limit;
>>>>                 break;
>>>>         case SMU_PPT_LIMIT_DEFAULT:
>>>>                 *limit = smu-
>>>>> ppt_limits.range[power_source][limit_type].default_value;
>>>> @@ -3061,6 +3077,7 @@ static int smu_set_ppt_limit(void *handle,
>>>> uint32_t limit_type, uint32_t limit)
>>>>         ret = smu->ppt_funcs->set_ppt_limit(smu, limit_type, limit);
>>>>         if (ret)
>>>>                 return ret;
>>>> +     range->current_value = limit;
>>>>         if (!(smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>>>                 smu-
>>>>> user_dpm_profile.ppt_limits[power_source][limit_type] = limit;
>>>>
>>>> smu->user_dpm_profile.ppt_limit_user_mask[power_source]
>>>> |= diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>> index 92658eb3886d..5222b48eba25 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>> @@ -229,6 +229,7 @@ enum smu_ppt_limit_level {
>>>>
>>>>    struct smu_ppt_limit_range {
>>>>         uint32_t default_value;
>>>> +     uint32_t current_value;
>>>>         uint32_t min;
>>>>         uint32_t max;
>>>>         uint32_t od_min;
>>>> --
>>>> 2.49.0
>>>
> 

