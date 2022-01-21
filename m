Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A972C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 09:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79E010E9AD;
	Fri, 21 Jan 2022 09:37:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB54D10E9AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 09:36:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5SLHVEyRKUUJmIeQlVLAe8VxHbXMJIcbKJjtgqlatcYszuE02PM40FdH/vQBNUPq4v5svwK56lqkpEQMmfQLSJ61/v4XLRGg8lygwgKq5pRiKDGVv7N32GK6lDjax1WqTUnFB0Q0nqiFUT0u0MwJ0fOQQ4325n5XUjgWha1uBexmOpN1UK8xALoKfBftA+HzvZZyiaCn508Bv20l6bDOryYhDAyn+SOG7x4lzFUcltukCyf/pZ4m05+GmY4xsPu51tzzxzmyyPvpPCACvZqd0vDpf1cUl1hB3Sf2S46LzaikTGrkPKqBTjTLXUd2nM1VWfuuSbzpEeoM0Fgt6MKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjUgROeHEYeIpv0fxwcYLZGetYkOtbacSV8RaA/KVhg=;
 b=ZbhCZWfexEIq/7qKaUrNIq9Wb4l3dB+cfEKM5nuvhEVINXxP8dHWU8UwhX324ynd9w8pODt5AshFWoE+eW6yqN/5yjeDj+Hl9StOzGbO9ELVO/YX9XKTIQQHuowH0dcFX7HuLecLGwMM+dl36q8YNVOxjmZrWlRY5dGHRwYujhv74aPbjaHsgkAW8txhOTWfp+tpt1FwcbTeorYG2OnctDVg2rOFD7cQhnlk/mnt4R0+zv728dTd5bPVCklB+miOpyeD8jXJWt9R3YAiBwaR9+rVk3EgH5hYhgwlL0xhIffCBwyDASoLh0420YvJpf/qytIFFtew6fhbPWHHewe/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjUgROeHEYeIpv0fxwcYLZGetYkOtbacSV8RaA/KVhg=;
 b=t05PwRLhw5nSMpwvHLl8MYch+WFEEdbS6wslFSR0QooRnFQVu4Ft+gTn3bTOWVQZaMmbE8LXhz+72FGqBkTfg0uryeXrrVdMJjxkKQxR5wIErPDbFohXsV2b67idxqEyy/wUK5rsvOEmDcaFdiNHtJ/YDZX8libtyFZjwqVhcr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN6PR12MB1380.namprd12.prod.outlook.com (2603:10b6:404:1f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 09:36:56 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%6]) with mapi id 15.20.4888.014; Fri, 21 Jan 2022
 09:36:56 +0000
Message-ID: <3fd44721-724c-be87-8e38-9b0da1a46f17@amd.com>
Date: Fri, 21 Jan 2022 15:06:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/7] drm/amd/pm: drop the redundant 'supported' member of
 smu_feature structure
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220121074443.639392-1-evan.quan@amd.com>
 <20220121074443.639392-3-evan.quan@amd.com>
 <76e60a91-c398-3bf7-0e4d-f3c346a3bcf0@amd.com>
 <DM6PR12MB2619F672AD15F38B7AD65696E45B9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619F672AD15F38B7AD65696E45B9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4acb694-90dc-4787-9f16-08d9dcc19003
X-MS-TrafficTypeDiagnostic: BN6PR12MB1380:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1380ED56BC17D0040BED0426975B9@BN6PR12MB1380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DA+ePk5n7qyiu5eX+FI16/jvJLqz+i60J6vlABfNABII+SnZZgbKI2MVWshfvFgTdrxM8D/B5rU9kw57AZLUz5M2ABe1OVL2MIsjkfbHLGV3ZAPGPaDo812iRcbpVZoPb2wbf4ebutqQzbOvNWfjeCt25WCm11UmpUbcBvjQNtXwrIGMuUN5PgfauWQeswkfvBrAs0Xx1orGjIqp6ctO4Y/pfh3nDc7wT1WdvlTQsSX/6oWaMImVU6ICI0EdFD2t46VA4vdp6sCOl9r8XllmTUC/iIYF+QJN2OYwQMBiua/Xon0pGcs9l/8t/4Q3dc+X8TSW0OFm7CpOZQAhkXHgE5Iq5V9RLcHyko4CdU8cPfHsUXGI0PeDJFsm8jr/2rYu287ikSFLtVXyMuh+YJj1rrTE9MTA6SaBRE47m0GbjDVtJBgLkRAfDOPGo0F91tBBBVtksTAVXwkgpCQqpL0+FQZgeZA5aMm39s6HYCxLvtsbolJFWxnTfILmdYgmg9yPEch7mK/xL9NCahNFisXrA34uzrxTJPHIuEep/SM1oFA3NjPNzPqz3FSNqBpVQHX9jhE9Ty+0VwMCTOrrwZfOwt3UjeY/utpybpIVtwzDqPHxuOue1XRLhGV8522fktMhrX4cwgRVoGLNrTscQlC2AmCxKRKTVY+IW/UPZw+1pUIA7fgdD7sagJBPrtY6Dkxxlgrgldkj8blmVdtyORXAyb6iTAzHp7+Gb21Rz6zJ89z3JjBlVudSiCtnTItK99X9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(6506007)(2906002)(8936002)(2616005)(6512007)(53546011)(8676002)(26005)(6486002)(186003)(110136005)(316002)(54906003)(30864003)(36756003)(31686004)(4326008)(86362001)(66556008)(66476007)(66946007)(508600001)(31696002)(38100700002)(5660300002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVVUZWlsYUlNeUgwRGRidEl2K3laa1ZiWXY3a0s0bklJMmdkN0FscnUzSWln?=
 =?utf-8?B?Q3BXTUZQTFlGTUQxZzl4UW8weTBwK2NlRWNlVFA2WXhlYnp0bG82WkVZM1hQ?=
 =?utf-8?B?RXJXNDZJVU5vSldvUGdOVW1jT2NyMFpaQzdPSHJ4N1pRQTVyVzRldXhGb2Vh?=
 =?utf-8?B?cXB0WXkrN3VucXhxdDVJbzQydW5SRm1Rb2N5aGp0ZDdWMFdiZTVIR2RRVjJS?=
 =?utf-8?B?Tk1lRGN4OUFZWFNBWWV0ZHhoTVNEOG9qSElZNlNwM2tOeFhuYm12U2toMDBW?=
 =?utf-8?B?R0J0U2wxM3NPSDJEeUR0TkZ2MkhvVDQrbHlZb1BXWW95amIxOHNxMWVXY0oy?=
 =?utf-8?B?cHRoZWZETkxPOWt1enJnaENQNVFDdURCcXBka01Xa25nRDE2UDYrM09jcG5y?=
 =?utf-8?B?UnpiRGRCMTFaYzRwQnAvSmhyek1UK3NKTjcvS3FDYnpuaXIzY0trYlAzMHBW?=
 =?utf-8?B?R3ROWlAvL3dNOEl4VHZncE5UVXdXQ0RUcmIyc3RZeWNLVGNGSktoUktvWWtV?=
 =?utf-8?B?K3M3cXpjeXo4ZGtCQnRidU1MNXQxQmE4eCtENWFJdW9QUklOK1gyaFczWUZx?=
 =?utf-8?B?L3hHQ2dmVmhOWjlKeUw3bGZRNldjM1V2U21jdGMxTE9GcG5mcSswWm5DZDJu?=
 =?utf-8?B?N3Fmd1RENE5kVThzZDRnVHd2NVFLWjBlMWV3VXdueVlNSnNIcktwMmQyWXVq?=
 =?utf-8?B?KyttWUtGNUNOMFFyZ0J0dEczMEFLSkhPL0hGbHd0K2NJRExYQUZBNDgrTFJN?=
 =?utf-8?B?SHN0SEh3QWgxSmYvSlAwd2Q0bElXWDlEZkdZc1dBY0kvbVIzWjNmaHJ0QzZh?=
 =?utf-8?B?RnRCOGRKeW1UVXV5dWtBU085Y1pyOE1oM2Zwc1RPM05ScDNCZWlucHgvcW9K?=
 =?utf-8?B?NEo0QTU5elpVSElHL0R2eFc2dDFTOWs0azlwRUtvU1NNdnVrL0xhTEprN0VY?=
 =?utf-8?B?aXBxS3laTlBxeU1hemh0bEhJTFhwMHFLZ0tGTGovZFR2cEFBeUxWRmdXQkcr?=
 =?utf-8?B?dVNOOHVNUHZ4ZnJ0a2gyRWpRRmZVb0FNQXE2WlNjRDRKNS9PU0g0alpidmcy?=
 =?utf-8?B?ZU5jeEZseDR4M3AycWNoUlpJaHZtZFUvdDE1WGtNLzVCZUxDckhrdkZSbUIx?=
 =?utf-8?B?aUFOS0RoNVgyU2JWTHlObHcyZ05uaVljZCs3ZDROSEpoWStVcUpoY1hKTVky?=
 =?utf-8?B?UmkrcUdpU2UzampZeUV0eXEyc0F3NCtoOUgrZWlSNlRpTnpFT0xDajI1akhq?=
 =?utf-8?B?MWtLOGJITUY3eHVacVZyelRwblhBNmRJZnlNZHlmWFY4RVo3SkJlcVhpNG16?=
 =?utf-8?B?alQxNEJoTEtJZ1JCR25hbFNqSmNsa0pLYU40ZHFyYjVicnRhby8vNmpHVjR0?=
 =?utf-8?B?b1BwZndZRlFQTWFDYThpZC9MUUpaMWg0R3d5cmJtT2wyMkJzYjk1LzNlRHR3?=
 =?utf-8?B?NitkNm5YVkorNndnVjF6U0xDcXNLd29lMmZVVHpQZjdHbE9jK0Z2MnJoTnRF?=
 =?utf-8?B?cGtla05wdlJqNnlmRUY2a1cyZHd2dWlaUjVYZm91MTgxd3MvM1dpbWgrdVV5?=
 =?utf-8?B?bmZlQys3RVhZcGJaTGVGNjQ5MUtTQnpKZzBQSUZRcjZsS2Z3ck1ZaC9CREJp?=
 =?utf-8?B?dDM0bldoUHdhSkE3NGFFN0JwUHAzS2V1K3pKRC9BLy9WckVjVzZySHA3dXd3?=
 =?utf-8?B?dUhJaFlqOEllbEZjQlpCUFpvR242K2I4T3pjRjZ3V010WWt2NWROTW9kdWNU?=
 =?utf-8?B?RjRlN0d2RjNzcVd3WENtVndDdUlRR0w3cHRUV2pGTHEvMnJxcGpNa0VhTnpJ?=
 =?utf-8?B?Z0JxLzZZSUtXU2hZVmh6WHpNbUNjckxSQTBFY01BTFpvT2Q5NjM5aU9IQmVk?=
 =?utf-8?B?aVVYbENwdkt2a1MzaFc2YUxlcGF0R2tKKzdrNEYybi83VE1PK2tueUVjRTkv?=
 =?utf-8?B?cS8zUDdSVGdXNUNPVThsZlI0bGF6bHJnNmpwZFR3M25kckJPaGMzQnpUNHhv?=
 =?utf-8?B?OGZSV1Z3UlVGdEV6R09oMFJvT3BXbmx3UU53TXVSelhoMU9WNVNKODFkZG1i?=
 =?utf-8?B?Z1p3aldFTks4QlhDRDhFN3J0Q3ZvdHcvV3dxNnNBOGRhd1VycUxUZTlIN2Zl?=
 =?utf-8?Q?lbbM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4acb694-90dc-4787-9f16-08d9dcc19003
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 09:36:55.7746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBmyP2hiSMmEXRkzWgx0Ck5Gj2+b2NCdsGXzWRiBOBTkWZaVanIcoM+XUpzfBNtO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1380
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/21/2022 2:56 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, January 21, 2022 4:52 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
>> <Guchun.Chen@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>> Subject: Re: [PATCH 3/7] drm/amd/pm: drop the redundant 'supported'
>> member of smu_feature structure
>>
>>
>>
>> On 1/21/2022 1:14 PM, Evan Quan wrote:
>>> As it has exactly the same value as the 'enabled' member and also do
>>> the same thing.
>>>
>>
>> I believe the original intention is different. We need to cache the features
>> which are really supported by PMFW on that device on init. When a request
>> comes through sysfs node for enable/disable of a feature, we should check
>> against this and disallow those which are not supported.
> [Quan, Evan] Uh, I doubt it was designed with such intention. As if it was, there should be checks in ->get_allowed_feature_mask(e.g. navi10_get_allowed_feature_mask) whether driver tries to enable/disable different features from PMFW.
> " When a request comes through sysfs node for enable/disable of a feature" If the sysfs node mentioned is "pp_features", I might be able to provide some insights why there is no such checks added when I made them. Considering there may be some dependency between those dpm features(e.g. gfx ulv depends on gfx dpm), we actually cannot guard user whether their settings will succeed. E.g. If PMFW supports both GFX ULV and DPM but user wants ULV only, the checks against pmfw supported features seem fine. But actually that cannot work due to the dependency between them. So, instead of applying some checks which actually cannot guard anything, we just let user take the risks.
> 

Below is one example

 > -	if (!smu_cmn_feature_is_supported(smu,
SMU_FEATURE_FAN_CONTROL_BIT))
 > +	if (!smu_cmn_feature_is_enabled(smu,
SMU_FEATURE_FAN_CONTROL_BIT))

Let's say user switched to manual mode, that time we disable fan control 
and move to manual mode. Next time when user requests auto mode, we 
check if fan control is originally supported on that platform and switch 
to auto.

Either way, we should cache the features which are originally supported 
on the platform (through a combination of PPTable features and allowed 
feature masks on ASICs which are applicable) and disallow anything 
outside of that.

Thanks,
Lijo

> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: I07c9a5ac5290cd0d88a40ce1768d393156419b5a
>>> ---
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 -
>>>    drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
>>>    .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  8 ++++----
>>>    .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 10 +++++-----
>>>    .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 19 ++++++++-------
>> ----
>>>    .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  5 +----
>>>    .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  5 +----
>>>    .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  3 ---
>>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 17 -----------------
>>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ---
>>>    10 files changed, 19 insertions(+), 53 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index 5ace30434e60..d3237b89f2c5 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -949,7 +949,6 @@ static int smu_sw_init(void *handle)
>>>
>>>    	smu->pool_size = adev->pm.smu_prv_buffer_size;
>>>    	smu->smu_feature.feature_num = SMU_FEATURE_MAX;
>>> -	bitmap_zero(smu->smu_feature.supported, SMU_FEATURE_MAX);
>>>    	bitmap_zero(smu->smu_feature.enabled, SMU_FEATURE_MAX);
>>>    	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> index 18f24db7d202..3c0360772822 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> @@ -388,7 +388,6 @@ struct smu_power_context {
>>>    struct smu_feature
>>>    {
>>>    	uint32_t feature_num;
>>> -	DECLARE_BITMAP(supported, SMU_FEATURE_MAX);
>>>    	DECLARE_BITMAP(allowed, SMU_FEATURE_MAX);
>>>    	DECLARE_BITMAP(enabled, SMU_FEATURE_MAX);
>>>    };
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> index 84834c24a7e9..9fb290f9aaeb 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>> @@ -1625,8 +1625,8 @@ static int navi10_display_config_changed(struct
>> smu_context *smu)
>>>    	int ret = 0;
>>>
>>>    	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
>>> -	    smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_DPM_DCEFCLK_BIT) &&
>>> -	    smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_DPM_SOCCLK_BIT)) {
>>> +	    smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_DPM_DCEFCLK_BIT) &&
>>> +	    smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_DPM_SOCCLK_BIT)) {
>>>    		ret = smu_cmn_send_smc_msg_with_param(smu,
>> SMU_MSG_NumOfDisplays,
>>>    						  smu->display_config-
>>> num_display,
>>>    						  NULL);
>>> @@ -1864,13 +1864,13 @@ static int
>> navi10_notify_smc_display_config(struct smu_context *smu)
>>>    	min_clocks.dcef_clock_in_sr = smu->display_config-
>>> min_dcef_deep_sleep_set_clk;
>>>    	min_clocks.memory_clock = smu->display_config-
>>> min_mem_set_clock;
>>>
>>> -	if (smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_DPM_DCEFCLK_BIT)) {
>>> +	if (smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_DPM_DCEFCLK_BIT)) {
>>>    		clock_req.clock_type = amd_pp_dcef_clock;
>>>    		clock_req.clock_freq_in_khz = min_clocks.dcef_clock * 10;
>>>
>>>    		ret = smu_v11_0_display_clock_voltage_request(smu,
>> &clock_req);
>>>    		if (!ret) {
>>> -			if (smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_DS_DCEFCLK_BIT)) {
>>> +			if (smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_DS_DCEFCLK_BIT)) {
>>>    				ret =
>> smu_cmn_send_smc_msg_with_param(smu,
>>>
>> SMU_MSG_SetMinDeepSleepDcefclk,
>>>
>> min_clocks.dcef_clock_in_sr/100, diff --git
>>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> index 651fe748e423..d568d6137a00 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> @@ -1281,8 +1281,8 @@ static int
>> sienna_cichlid_display_config_changed(struct smu_context *smu)
>>>    	int ret = 0;
>>>
>>>    	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
>>> -	    smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_DPM_DCEFCLK_BIT) &&
>>> -	    smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_DPM_SOCCLK_BIT)) {
>>> +	    smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_DPM_DCEFCLK_BIT) &&
>>> +	    smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_DPM_SOCCLK_BIT)) {
>>>    #if 0
>>>    		ret = smu_cmn_send_smc_msg_with_param(smu,
>> SMU_MSG_NumOfDisplays,
>>>    						  smu->display_config-
>>> num_display, @@ -1521,13 +1521,13 @@
>>> static int sienna_cichlid_notify_smc_display_config(struct smu_context
>> *smu)
>>>    	min_clocks.dcef_clock_in_sr = smu->display_config-
>>> min_dcef_deep_sleep_set_clk;
>>>    	min_clocks.memory_clock = smu->display_config-
>>> min_mem_set_clock;
>>>
>>> -	if (smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_DPM_DCEFCLK_BIT)) {
>>> +	if (smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_DPM_DCEFCLK_BIT)) {
>>>    		clock_req.clock_type = amd_pp_dcef_clock;
>>>    		clock_req.clock_freq_in_khz = min_clocks.dcef_clock * 10;
>>>
>>>    		ret = smu_v11_0_display_clock_voltage_request(smu,
>> &clock_req);
>>>    		if (!ret) {
>>> -			if (smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_DS_DCEFCLK_BIT)) {
>>> +			if (smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_DS_DCEFCLK_BIT)) {
>>>    				ret =
>> smu_cmn_send_smc_msg_with_param(smu,
>>>
>> SMU_MSG_SetMinDeepSleepDcefclk,
>>>
>> min_clocks.dcef_clock_in_sr/100, @@ -3752,7 +3752,7 @@
>>> static int sienna_cichlid_gpo_control(struct smu_context *smu,
>>>    	int ret = 0;
>>>
>>>
>>> -	if (smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_DPM_GFX_GPO_BIT)) {
>>> +	if (smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_DPM_GFX_GPO_BIT)) {
>>>    		ret = smu_cmn_get_smc_version(smu, NULL,
>> &smu_version);
>>>    		if (ret)
>>>    			return ret;
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> index b58a4c2823c2..b69c2ecc8e25 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> @@ -808,7 +808,6 @@ int smu_v11_0_system_features_control(struct
>> smu_context *smu,
>>>    		return ret;
>>>
>>>    	bitmap_zero(feature->enabled, feature->feature_num);
>>> -	bitmap_zero(feature->supported, feature->feature_num);
>>>
>>>    	if (en) {
>>>    		ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
>> @@ -817,8
>>> +816,6 @@ int smu_v11_0_system_features_control(struct smu_context
>>> *smu,
>>>
>>>    		bitmap_copy(feature->enabled, (unsigned long
>> *)&feature_mask,
>>>    			    feature->feature_num);
>>> -		bitmap_copy(feature->supported, (unsigned long
>> *)&feature_mask,
>>> -			    feature->feature_num);
>>>    	}
>>>
>>>    	return ret;
>>> @@ -1186,7 +1183,7 @@ smu_v11_0_auto_fan_control(struct
>> smu_context *smu, bool auto_fan_control)
>>>    {
>>>    	int ret = 0;
>>>
>>> -	if (!smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_FAN_CONTROL_BIT))
>>> +	if (!smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_FAN_CONTROL_BIT))
>>>    		return 0;
>>>
>>>    	ret = smu_cmn_feature_set_enabled(smu,
>> SMU_FEATURE_FAN_CONTROL_BIT,
>>> auto_fan_control); @@ -1607,7 +1604,7 @@ bool
>> smu_v11_0_baco_is_support(struct smu_context *smu)
>>>    		return false;
>>>
>>>    	/* Arcturus does not support this bit mask */
>>> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT)
>> &&
>>> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)
>> &&
>>>    	   !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
>>>    		return false;
>>>
>>> @@ -2150,7 +2147,7 @@ int smu_v11_0_gfx_ulv_control(struct
>> smu_context *smu,
>>>    {
>>>    	int ret = 0;
>>>
>>> -	if (smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_GFX_ULV_BIT))
>>> +	if (smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_GFX_ULV_BIT))
>>>    		ret = smu_cmn_feature_set_enabled(smu,
>> SMU_FEATURE_GFX_ULV_BIT,
>>> enablement);
>>>
>>>    	return ret;
>>> @@ -2162,7 +2159,7 @@ int smu_v11_0_deep_sleep_control(struct
>> smu_context *smu,
>>>    	struct amdgpu_device *adev = smu->adev;
>>>    	int ret = 0;
>>>
>>> -	if (smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_DS_GFXCLK_BIT)) {
>>> +	if (smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_DS_GFXCLK_BIT)) {
>>>    		ret = smu_cmn_feature_set_enabled(smu,
>> SMU_FEATURE_DS_GFXCLK_BIT, enablement);
>>>    		if (ret) {
>>>    			dev_err(adev->dev, "Failed to %s GFXCLK DS!\n",
>> enablement ?
>>> "enable" : "disable"); @@ -2170,7 +2167,7 @@ int
>> smu_v11_0_deep_sleep_control(struct smu_context *smu,
>>>    		}
>>>    	}
>>>
>>> -	if (smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_DS_UCLK_BIT)) {
>>> +	if (smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_DS_UCLK_BIT)) {
>>>    		ret = smu_cmn_feature_set_enabled(smu,
>> SMU_FEATURE_DS_UCLK_BIT, enablement);
>>>    		if (ret) {
>>>    			dev_err(adev->dev, "Failed to %s UCLK DS!\n",
>> enablement ?
>>> "enable" : "disable"); @@ -2178,7 +2175,7 @@ int
>> smu_v11_0_deep_sleep_control(struct smu_context *smu,
>>>    		}
>>>    	}
>>>
>>> -	if (smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_DS_FCLK_BIT)) {
>>> +	if (smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_DS_FCLK_BIT)) {
>>>    		ret = smu_cmn_feature_set_enabled(smu,
>> SMU_FEATURE_DS_FCLK_BIT, enablement);
>>>    		if (ret) {
>>>    			dev_err(adev->dev, "Failed to %s FCLK DS!\n",
>> enablement ?
>>> "enable" : "disable"); @@ -2186,7 +2183,7 @@ int
>> smu_v11_0_deep_sleep_control(struct smu_context *smu,
>>>    		}
>>>    	}
>>>
>>> -	if (smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_DS_SOCCLK_BIT)) {
>>> +	if (smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_DS_SOCCLK_BIT)) {
>>>    		ret = smu_cmn_feature_set_enabled(smu,
>> SMU_FEATURE_DS_SOCCLK_BIT, enablement);
>>>    		if (ret) {
>>>    			dev_err(adev->dev, "Failed to %s SOCCLK DS!\n",
>> enablement ?
>>> "enable" : "disable"); @@ -2194,7 +2191,7 @@ int
>> smu_v11_0_deep_sleep_control(struct smu_context *smu,
>>>    		}
>>>    	}
>>>
>>> -	if (smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_DS_LCLK_BIT)) {
>>> +	if (smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_DS_LCLK_BIT)) {
>>>    		ret = smu_cmn_feature_set_enabled(smu,
>> SMU_FEATURE_DS_LCLK_BIT, enablement);
>>>    		if (ret) {
>>>    			dev_err(adev->dev, "Failed to %s LCLK DS!\n",
>> enablement ?
>>> "enable" : "disable"); diff --git
>>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> index b4a3c9b8b54e..e72831aa4859 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> @@ -1960,7 +1960,6 @@ static int
>> vangogh_system_features_control(struct smu_context *smu, bool en)
>>>    						      RLC_STATUS_OFF, NULL);
>>>
>>>    	bitmap_zero(feature->enabled, feature->feature_num);
>>> -	bitmap_zero(feature->supported, feature->feature_num);
>>>
>>>    	if (!en)
>>>    		return ret;
>>> @@ -1971,8 +1970,6 @@ static int
>>> vangogh_system_features_control(struct smu_context *smu, bool en)
>>>
>>>    	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
>>>    		    feature->feature_num);
>>> -	bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
>>> -		    feature->feature_num);
>>>
>>>    	return 0;
>>>    }
>>> @@ -1989,7 +1986,7 @@ static int vangogh_post_smu_init(struct
>> smu_context *smu)
>>>    		adev->gfx.config.max_sh_per_se *
>>> adev->gfx.config.max_shader_engines;
>>>
>>>    	/* allow message will be sent after enable message on Vangogh*/
>>> -	if (smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_DPM_GFXCLK_BIT) &&
>>> +	if (smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_DPM_GFXCLK_BIT) &&
>>>    			(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
>>>    		ret = smu_cmn_send_smc_msg(smu,
>> SMU_MSG_EnableGfxOff, NULL);
>>>    		if (ret) {
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> index 1754a3720179..c5d354175675 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> @@ -774,7 +774,6 @@ int smu_v13_0_system_features_control(struct
>> smu_context *smu,
>>>    		return ret;
>>>
>>>    	bitmap_zero(feature->enabled, feature->feature_num);
>>> -	bitmap_zero(feature->supported, feature->feature_num);
>>>
>>>    	if (en) {
>>>    		ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
>> @@ -783,8
>>> +782,6 @@ int smu_v13_0_system_features_control(struct smu_context
>>> *smu,
>>>
>>>    		bitmap_copy(feature->enabled, (unsigned long
>> *)&feature_mask,
>>>    			    feature->feature_num);
>>> -		bitmap_copy(feature->supported, (unsigned long
>> *)&feature_mask,
>>> -			    feature->feature_num);
>>>    	}
>>>
>>>    	return ret;
>>> @@ -1071,7 +1068,7 @@ smu_v13_0_auto_fan_control(struct
>> smu_context *smu, bool auto_fan_control)
>>>    {
>>>    	int ret = 0;
>>>
>>> -	if (!smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_FAN_CONTROL_BIT))
>>> +	if (!smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_FAN_CONTROL_BIT))
>>>    		return 0;
>>>
>>>    	ret = smu_cmn_feature_set_enabled(smu,
>> SMU_FEATURE_FAN_CONTROL_BIT,
>>> auto_fan_control); diff --git
>>> a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>> index f425827e2361..e9172622c0c4 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>> @@ -204,7 +204,6 @@ static int
>> yellow_carp_system_features_control(struct smu_context *smu, bool en)
>>>    		ret = smu_cmn_send_smc_msg(smu,
>> SMU_MSG_PrepareMp1ForUnload,
>>> NULL);
>>>
>>>    	bitmap_zero(feature->enabled, feature->feature_num);
>>> -	bitmap_zero(feature->supported, feature->feature_num);
>>>
>>>    	if (!en)
>>>    		return ret;
>>> @@ -215,8 +214,6 @@ static int
>>> yellow_carp_system_features_control(struct smu_context *smu, bool en)
>>>
>>>    	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
>>>    		    feature->feature_num);
>>> -	bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
>>> -		    feature->feature_num);
>>>
>>>    	return 0;
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> index 50164ebed1cd..49bcabe9d708 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> @@ -476,23 +476,6 @@ int smu_cmn_to_asic_specific_index(struct
>> smu_context *smu,
>>>    	}
>>>    }
>>>
>>> -int smu_cmn_feature_is_supported(struct smu_context *smu,
>>> -				 enum smu_feature_mask mask)
>>> -{
>>> -	struct smu_feature *feature = &smu->smu_feature;
>>> -	int feature_id;
>>> -
>>> -	feature_id = smu_cmn_to_asic_specific_index(smu,
>>> -
>> CMN2ASIC_MAPPING_FEATURE,
>>> -						    mask);
>>> -	if (feature_id < 0)
>>> -		return 0;
>>> -
>>> -	WARN_ON(feature_id > feature->feature_num);
>>> -
>>> -	return test_bit(feature_id, feature->supported);
>>> -}
>>> -
>>>    int smu_cmn_feature_is_enabled(struct smu_context *smu,
>>>    			       enum smu_feature_mask mask)
>>>    {
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> index 4e34c18c6063..19919182260a 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> @@ -48,9 +48,6 @@ int smu_cmn_to_asic_specific_index(struct
>> smu_context *smu,
>>>    				   enum smu_cmn2asic_mapping_type type,
>>>    				   uint32_t index);
>>>
>>> -int smu_cmn_feature_is_supported(struct smu_context *smu,
>>> -				 enum smu_feature_mask mask);
>>> -
>>>    int smu_cmn_feature_is_enabled(struct smu_context *smu,
>>>    			       enum smu_feature_mask mask);
>>>
>>>
