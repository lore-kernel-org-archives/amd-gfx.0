Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EF7C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 07:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5DE6101E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 07:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E5DE6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D5C89090;
	Thu, 12 Aug 2021 07:52:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E749689090
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 07:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QykdWeufR2anfy1gZb3KCG32X264Y6aLxj/k/iR1y/aLthdDbzCfgD5uBkm8vI5uRi12XVCZocJkVwPYTjxDbxl6UyxESHEzjJikraV2bTy20XcdhXEVNSPmsUav309soF5D0/UD2tmGwZ6ZVxMeTbZboAuLgV7fQTIz/3rF7pMkxOkKnN5Fzdo78I5YECqT7VUYmO3I+LnUpKiz399GZGg89N8410o6A4mMavL3p2BmZabE7hSuur/gIgRjAR8jYrHGvg542vpDZlO/tEEhGCVW5cUmwp8jyroHrdMZR40glwDrmDmv33hX60wN+AvzZRvsQysk3O0ow46g1gnl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spz7xatgDk0D6UxQ+ABgKeNq3DB0M8n9+83i/Rscw0I=;
 b=Xe6h3A84fsSEmWORdQFF9SSrYDtIZhmHozvsc2TXzOKCdB7eQ+JjakeQUXuRpfcOacpkCs03NWQFEXnL/cHvGlQo9mla78VVisSd6FQe7pbKyxgBHrZVmxyI/cOQlU0kQh8EYfFO3Fj3lNJmViR6/nidP7DGvgWr7xdm3iLHyxjcTqOMhokTpgHACjjsRXdW1ibKiP8B3xdDbGjrLQiLQD2TenVODiRjowzra84Yv8SI7xgPPwsRBJuHLW/vX6TsuVm9fRi9mUEkznp9BKlpLNTEG2pyKJNS0vOghuM1AFCc/qGLlWkXO3+u7EM6+esY+e4mI6Ub5AidK+Sw6cZPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spz7xatgDk0D6UxQ+ABgKeNq3DB0M8n9+83i/Rscw0I=;
 b=J/5JUFSU7j0w+b+bxZKQK5zzfZuMn/NwVp60aTiBIwzyCWX624WV87gDSOFYHw4TWnytECe9h3hxD10KdIpwVMqGw1M6rzweLIr3BA/FmoTqmiqs/QiLujPVwaBTCiFaotlY9OZfZW5gRzXSfcYNsTImVz5RqFH8Aail/iGTx3s=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5322.namprd12.prod.outlook.com (2603:10b6:408:103::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Thu, 12 Aug
 2021 07:52:54 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed%9]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 07:52:54 +0000
Subject: Re: [PATCH V2 2/7] drm/amd/pm: record the RPM and PWM based fan speed
 settings
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "nils.wallmenius@gmail.com" <nils.wallmenius@gmail.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>
References: <20210812040110.1293682-1-evan.quan@amd.com>
 <20210812040110.1293682-2-evan.quan@amd.com>
 <f63b688e-81bd-a6a7-4a27-f1d3140559bc@amd.com>
 <DM6PR12MB26190C2DBBCBDE6AF4835F7FE4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <3285485e-2beb-4147-fa68-e0fc6636e158@amd.com>
Date: Thu, 12 Aug 2021 13:22:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <DM6PR12MB26190C2DBBCBDE6AF4835F7FE4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::34) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 BM1PR01CA0094.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.13 via Frontend Transport; Thu, 12 Aug 2021 07:52:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 778634db-9b2c-41e9-f03a-08d95d6630f7
X-MS-TrafficTypeDiagnostic: BN9PR12MB5322:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5322C16BADBC24DFC67576D597F99@BN9PR12MB5322.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3jo7psdqWnm7oMR6yi7Pp8igPG6BP7ssEQrNOHEcEujRw9HC/1ba3Y7EVWLTiDKTsADHJQPWs6RgSrDl1qL0zKPVwSUuK/Gp6/ZGzgcThOXzXa7IS9YnGchnDfz1KNNOm+W4Z3AmkyxO7ucz+hGPGWxeUpsaOzn/SFZ5WK8WZF/TjyT12uMA35QviJeS6weknINlq3kitP1gpDLQSJkHCajzKAysFhuO39zfAMXNZ/QGWbxJYsm4YfK0RHLru1fnwLmeFwxsPx+viqIUah/DSjb5D251FZpzwPIuHvXAxMT59FIHfu/LsVJ2D9ckdMBQfGjNY7QJCKUW7MiGYusy4hRKbjSLFOHHGcQsUTyjfwIm09uY9ePZH7qW4SUoytuYy2TSjaX482itN4nMkyOLyKBTTaWwFFNs6IKCO7Tex479ma7moNzGzxI7KjBEDoz4PhEtaxgE2qlK52ZWwWxqT5FhrGjso8Aa1aHp1dobb6yrLmG+ezaqMFBtw1hLtMk49Ri4rp+E4gFb0g0HpwCP0WHHNsCXY7Ip6F4QiClWfRrXw1dh92pu3W3DmClTNDFCIW9eFCgOC0VR/643OlxkCUBfv8eS3OtUGq1VnGpiuWP3QKBCOpPfvBXXqkW6nXMHHVD2mgEzafROs4dW7SA3fIrYz70jZOTEZF8w4kTGbaJk163WHmu5O9EUl83sO4NsKMHOr+LER5qdToHgIWAqemfiknmGIQlmYB/BVOU9ig=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(54906003)(508600001)(316002)(36756003)(31686004)(110136005)(956004)(2616005)(186003)(26005)(6486002)(53546011)(6666004)(16576012)(38100700002)(83380400001)(5660300002)(8676002)(86362001)(8936002)(31696002)(2906002)(66476007)(66556008)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzN6Zy9XQTk3OGVPMDUvSzF0Z0RoQVNtMkNjTXdkekFESUt4UWloZDVORTk3?=
 =?utf-8?B?MnA2RytJS1pHdjk2a3dhU3FGMm1teHFBbkhxc1BCWGhyK1JSRzI5UWhLN21X?=
 =?utf-8?B?c05mMWRWZGxQdkpJcWNlQzFSU2Y2Y3dpU29TNmUzOXRxN21ta0E0K0dtT2l6?=
 =?utf-8?B?K1pobHNWR3EzUTNIZytOQThUaTJya1JEd1RVUHdHTU1jWjUwSlBJQWtsaTJu?=
 =?utf-8?B?SjdndVVGRk9lMW01SGQyWVRxTmtobWtiMG81cXBhK3BVWUo5VlBUelJ1azha?=
 =?utf-8?B?TnEyV3hybExzcVBLN1pXT1RJNEtDUmlURU9rVjU2UjdXS1lUbmdpV1dTa2hU?=
 =?utf-8?B?a2JpSUFidkJVR2c0eGw2Z1VUSlpQWlRFTDNLeFhHYy9oeFZZZVZrcGdZTGNR?=
 =?utf-8?B?QjFHaXhaeU4wLy8rK1pRTHY0N0VMRmVaK2lYRGtVMXZwVnBhQTR5WUhQQXlZ?=
 =?utf-8?B?MHVoek5OMzZhbWRnNGdKUHhtZnRLelo0aUxFK2VmRTZCR1JnYmxsOUJsZHJB?=
 =?utf-8?B?U3Y3U05zRU1TcTVYYWViWGhUa3EyQVlrRFhCQVdTTlJHWTZKK1JabnlubTE0?=
 =?utf-8?B?YW9rbDJFNGQrVnBEaVRkUDg3Y0dUZ2NPd1BPVU1BL1d1T016MWo1aDcyT0NC?=
 =?utf-8?B?SnFnZGNwNElRY3hKN1dOZUkzZ09qR0JWUFRpYVdqQUFQUWFnZzFVY3M1R2tF?=
 =?utf-8?B?eENaWmgvL21KK0pydmRPcDlhdGQxc3ZUUHNYNFFHaTlvZXROTVRZOWxhQnVs?=
 =?utf-8?B?WDEzaE1FUXg0dWlpVFQ1bCszQTYvM3JjZitySnE0REw4ZDZPcUlFek01WEF6?=
 =?utf-8?B?TWV4cHpsbHZVcnNSQjhhL1J3WGlUM0tjcEdYbGFGYlR0OTJ2ajlNQ0xZRFMz?=
 =?utf-8?B?dmxOeERWd011M3VXWTF6OTRUb1AzWEpyTFdJU3NXeDkvQmZHbW14ditUejg2?=
 =?utf-8?B?RTJKMmZXQmZUUmdrbG11b1N3dVUyTEVrbnVic20rQlRKZEI4MU1PR0FaRzhK?=
 =?utf-8?B?Wnp4b1E3R3pONVNyamJiVHpWaWJVUG8xVlQyb0UyTGhiTUZMbFZ4REZ0MkNL?=
 =?utf-8?B?cSthcmhiNGVLS04rTFcyVTVmMktGbGU1T0UxY3Q4V1pTMkpTaFg0RUc1T3Js?=
 =?utf-8?B?S3BzWVd0cjRQOFZBR2ZBWmMvSHhqelpoKzVCSXBSVEJJb0VxRTlETWJVRWEr?=
 =?utf-8?B?Nk1IYzhWSmFIRklUbm1JRDY5QlZ4VjlVdU9BNkZoRDl0SE44NEJSb203Rk1D?=
 =?utf-8?B?WUJYT3ZSTGZQWDVyb0FtTHd3b093am5RT3hiTVExUUN1K3FBVGgyTklYL2RH?=
 =?utf-8?B?a1hVQkQzaDRvaCtTYVAvRlRLYVdHSWxMMUxXQ1pDcXVLNjllV05Zd0FZelFR?=
 =?utf-8?B?YVRnOGRvazU4M0xGRGt5dmcxdysxOWZ6b3VWSW5qLzhmRU02VUN3L050Vnpj?=
 =?utf-8?B?RWp2NHpBK1dVME9NanU2aW5vWVJMRzgwckVWYjZPcGRkMkVhVUd4R2RGMDR0?=
 =?utf-8?B?Q2dkUGIvbnNtOVNRQjFjY05HSStYVXRXQ3ZWRU1IV0RyVFpIK3VjNWY4Vng4?=
 =?utf-8?B?N2RSUEtmelNaS0V0eEhxa3FBY09jc2p3NVBOc2hVZXNVeDJ4Q2FkVVU2NkxO?=
 =?utf-8?B?a20wczNhWExIUHFmN3Q1ZXhNUWs0a1MzSzJSWGJWRTNLZmlCTkJHb2dVMHpJ?=
 =?utf-8?B?VkF3M1FKYjFSL3dFZ1IwaFgzekRXRUJMSGxuWTZDRnhmWHlQekxPaG1EOTRI?=
 =?utf-8?Q?7iK1D39DQtQMzFj6RtoM9bbsT5Hj5JeMAGQDy3l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778634db-9b2c-41e9-f03a-08d95d6630f7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 07:52:54.0079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1v/XhOgvAkkuFF65BLvRczQv1zDxpRHOlpfFVyM06RGLzDz7ljzg+lBqvz5VBJR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5322
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



On 8/12/2021 12:21 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, August 12, 2021 2:05 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: nils.wallmenius@gmail.com; Chen, Guchun <Guchun.Chen@amd.com>
>> Subject: Re: [PATCH V2 2/7] drm/amd/pm: record the RPM and PWM based
>> fan speed settings
>>
>>
>>
>> On 8/12/2021 9:31 AM, Evan Quan wrote:
>>> As the relationship "PWM = RPM / smu->fan_max_rpm" between fan
>> speed
>>> PWM and RPM is not true for SMU11 ASICs. So, both the RPM and PWM
>>> settings need to be saved.
>>>
>>> Change-Id: I318c134d442273d518b805339cdf383e151b935d
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> --
>>> v1->v2:
>>>     - coding style and logging prints optimization (Guchun)
>>>     - reuse existing flags (Lijo)
>>> ---
>>>    drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  3 +++
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22
>> ++++++++++++++++------
>>>    2 files changed, 19 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> index 183654f8b564..29934a5af44e 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> @@ -34,6 +34,8 @@
>>>    #define SMU_FW_NAME_LEN			0x24
>>>
>>>    #define SMU_DPM_USER_PROFILE_RESTORE (1 << 0)
>>> +#define SMU_CUSTOM_FAN_SPEED_RPM     (1 << 1)
>>> +#define SMU_CUSTOM_FAN_SPEED_PWM     (1 << 2)
>>>
>>>    // Power Throttlers
>>>    #define SMU_THROTTLER_PPT0_BIT			0
>>> @@ -230,6 +232,7 @@ struct smu_user_dpm_profile {
>>>    	uint32_t fan_mode;
>>>    	uint32_t power_limit;
>>>    	uint32_t fan_speed_percent;
>>> +	uint32_t fan_speed_rpm;
>>>    	uint32_t flags;
>>>    	uint32_t user_od;
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index e33e67310030..131ad0dfefbe 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -413,7 +413,13 @@ static void smu_restore_dpm_user_profile(struct
>> smu_context *smu)
>>>    		if (!ret && smu->user_dpm_profile.fan_speed_percent) {
>>>    			ret = smu_set_fan_speed_percent(smu, smu-
>>> user_dpm_profile.fan_speed_percent);
>>>    			if (ret)
>>> -				dev_err(smu->adev->dev, "Failed to set
>> manual fan speed\n");
>>> +				dev_err(smu->adev->dev, "Failed to set
>> manual fan speed in percent\n");
>>> +		}
>>> +
>>> +		if (!ret && smu->user_dpm_profile.fan_speed_rpm) {
>>> +			ret = smu_set_fan_speed_rpm(smu, smu-
>>> user_dpm_profile.fan_speed_rpm);
>>> +			if (ret)
>>> +				dev_err(smu->adev->dev, "Failed to set
>> manual fan speed in
>>> +rpm\n");
>>>    		}
>>>    	}
>>>
>>> @@ -2179,7 +2185,6 @@ static int smu_set_gfx_cgpg(struct smu_context
>> *smu, bool enabled)
>>>    static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
>>>    {
>>>    	struct smu_context *smu = handle;
>>> -	u32 percent;
>>>    	int ret = 0;
>>>
>>>    	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) @@ -
>> 2190,8
>>> +2195,8 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t
>> speed)
>>>    	if (smu->ppt_funcs->set_fan_speed_rpm) {
>>>    		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
>>>    		if (!ret && smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE) {
>>> -			percent = speed * 100 / smu->fan_max_rpm;
>>> -			smu->user_dpm_profile.fan_speed_percent =
>> percent;
>>> +			smu->user_dpm_profile.flags |=
>> SMU_CUSTOM_FAN_SPEED_RPM;
>>> +			smu->user_dpm_profile.fan_speed_rpm = speed;
>>
>> Sorry, missed this when you posted v1. Either RPM or PWM mode is allowed
>> at a time, is that right? If so, shall we make the pwm to 0 and reset PWM flag
>> when RPM is set and vice versa? This helps during restore where one is not
>> overwritten with the other.
> [Quan, Evan] Sounds reasonable to me. But I suppose we also need to prompt some warnings when user trying to set these two modes at the same time.
> Instead of performing these silently. Right?

Not sure on the warnings part. For ex: user may set the manual mode, 
choose a pwm based fan speed and may later switch to a precise rpm based 
speed. Since it's driven by user, we may not need to warn.

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>
>>>    		}
>>>    	}
>>>
>>> @@ -2552,8 +2557,11 @@ static int smu_set_fan_control_mode(struct
>>> smu_context *smu, int value)
>>>
>>>    	/* reset user dpm fan speed */
>>>    	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
>>> -			!(smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE))
>>> +			!(smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>>    		smu->user_dpm_profile.fan_speed_percent = 0;
>>> +		smu->user_dpm_profile.fan_speed_rpm = 0;
>>> +		smu->user_dpm_profile.flags &=
>> ~(SMU_CUSTOM_FAN_SPEED_RPM | SMU_CUSTOM_FAN_SPEED_PWM);
>>> +	}
>>>
>>>    	return ret;
>>>    }
>>> @@ -2604,8 +2612,10 @@ static int smu_set_fan_speed_percent(void
>> *handle, u32 speed)
>>>    		if (speed > 100)
>>>    			speed = 100;
>>>    		ret = smu->ppt_funcs->set_fan_speed_percent(smu,
>> speed);
>>> -		if (!ret && !(smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE))
>>> +		if (!ret && !(smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>> +			smu->user_dpm_profile.flags |=
>> SMU_CUSTOM_FAN_SPEED_PWM;
>>>    			smu->user_dpm_profile.fan_speed_percent =
>> speed;
>>> +		}
>>>    	}
>>>
>>>    	mutex_unlock(&smu->mutex);
>>>
