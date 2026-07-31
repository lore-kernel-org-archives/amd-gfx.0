Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C19FC55167
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 07:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E1A810F1AA;
	Fri, 31 Jul 2026 07:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EYks++L9";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61CA410F1AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 07:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wND0CLXxwy9RBHkrPvojqlPQHrT6By9hJW5nlevcniIoSwkPPjwMkxY+cyadT4HVUuxunXEUNU4XB3GPHViZSqFE+2dLdObTBg2kKNGBLsVdlQf2pDD9TyHvFvGxj1S47UsG4zYCxoG2SGXyrK3eRE1sW29XBK690W76OufweqLaleAtnMni8oU09c7YJcD/BegIrWFg6avIo8KdhKU8Xd4NJSkJPC503749WhHkV50LZC7JY3EVFGcmqoaeHxONFctJmdf2oUTeQpgA+5yb0pg5t3CoR3Hd6hYnsEaVqAaMCgC6kinZZcsxopPaH9MrKRP4OTGowfoKx9b5r+LAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzZQ4dEfxumrVkCERCKQwMLBlnVCKD/d6IuLdaIYmJ0=;
 b=W6Ye6Ym3P+23vKZeWBUDLUaw632AoPReCihZ4jJTOTx7CD4WPhu1/Bd/1eqxK3qgtrtW0T2QT1NVN0HN4texddKeE/V41X29jBgfOMth9z+oMohmSq987ghfEx67mbrY24M9KJ9AK3ZZGRmVeK7yAXqO07bUuY+lOzNf9zHDDoOmHXcV+rqrL1Cotz3f+ozAqerJfFVpSSKsNYqjf9H0xnBHJpBFG/nnUYV/vhgpmJUV62A/9pUyZ/NPLsw/tCs9yIqw+Xb1gLUUzDQd+Fyw+CJX8tpEpd87uklaNZDfdk7keCESm+dnCzUes1g8GT8Lk8oW/R96ix6SG4umMQndtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzZQ4dEfxumrVkCERCKQwMLBlnVCKD/d6IuLdaIYmJ0=;
 b=EYks++L97ZHaLtMlaePziaXxnIRbeHu51Q2BTyW/XE83gdR1nX+RBeqIa2mgeSiv7fG3Qanf0DdlZM5yuedDGdo0ydi1HEzYFKUsY2TUSBt3vQmTI+rWo2DXubiUHXcT/md9vbJYSv8v7GVuarH0MCycET4N6eFJ7qKc0FiRa0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:45:17 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:45:17 +0000
Message-ID: <64d8e874-9b20-4ef7-8b61-9b1fa08a1278@amd.com>
Date: Fri, 31 Jul 2026 13:15:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amd/pm: refactor user PPT policy save and restore
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>
References: <cover.1785467079.git.kevinyang.wang@amd.com>
 <2a1bf8c187a6b6a67169fda0e6551a062af56c77.1785467079.git.kevinyang.wang@amd.com>
 <c4cd5c4c-00e5-41cb-b049-8e668270bbcf@amd.com>
 <BN9PR12MB5211E9C9924BF1CCD56ACF5A82C82@BN9PR12MB5211.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BN9PR12MB5211E9C9924BF1CCD56ACF5A82C82@BN9PR12MB5211.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b649de4-ca35-4b08-5870-08deeed7a9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|5023799004|4143699003|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: C7RczYz44srmkseSc9vFsYQg2WyUD2UKTZGWTeOdJgvAa8m27cnD+/TY3+cs/eebgBISkNJBR2OI+As1kVxrq8eyIaS5TdxS1c3K7VuWsd7C31IoUrGMfq5MiJ7TWwYmOg8wgzmTM/7opWBDZn5u1dpm1XsWtU9pLCl9R93RBA8TTJ2TgIGlMCrmarhK/qyWmbjNQBLl62FZwHMS/oAzDJndURJo2gcdHoRp5TEVRLt8DWCukvWGodiXV3lAe+pMlYNCTPNmIe5EsqMw1wlwroicncT+y+Os6tfeQsVfUFHd6aIc1JpM5pwiXCgmBd7VEnb6D53ySMGvenRJiMB3AzCGm0ksmqtY5qImX3VZLhKkw7DkPBQqE3uUxiddcxXFVAXGdwKylSrpaWPQck7bFTNouv3d/GFLb+6Ll6t1W32da691dwnHW0mYLszh6aJL1cgFWKBEtHLdJcBQ5mMQG9gI+TrFQC7amXGZI3pJ1kkeR4JO3LMrIoFhDbQ8rGFfBdenxwwOyq11Y4mMWX/EkdOtFWpca1S+ROfL0TVJEP9iNcWXEiWiqtoQgFKerXEHWOXoIWah+s9dbe2fTA/ZON5XzXHVhfvMrANnXcmSwf/O/XRpWZQawmyaqCchuksAlDp02lUpVHgQyvrYbLoPQ95sm5lWEmrqW82M5/m+LCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(5023799004)(4143699003)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU93N3F1ZzhVRUpGZHo5ZGFBYklUMU16cjl2SWNxVStPa0piUTk4bUdzRTk2?=
 =?utf-8?B?SnkrTFZidHh6YVY2TFlucUlMUUVCLzhSdmZna0UrYTJUcW1FbENnTjdTRlNQ?=
 =?utf-8?B?LzkwNUpCTGV0dFBBZWNYekFOcGtNcVkwb1ZiZnYvb1duN0VkUlM3dzVJQWIy?=
 =?utf-8?B?RmY0NXRqbTBRUlViNkRTQkZJcTRPaC8wMEk2STZRS0xRNEM0M3BSRU91eVdq?=
 =?utf-8?B?bVhGNXJGNWlkWEllQU5ITmYzeld6b0ZjUTExUkxBRnE0S1c4NGFpWTIzUCsx?=
 =?utf-8?B?bU9sMnJXNUdUR1JRd1E2TlBFNXJxelYwaE1LQ2NVWGlzMmJKaC9NTHVvMG9a?=
 =?utf-8?B?bG1IeXVtRndwbXBzQUpOOGV1bE54OURqNzFoRlJVd20vMXp3TjAyTXV6SDNR?=
 =?utf-8?B?ejVpSFczbXZmTUlsa0hLRGtsUk51ckNxZDhuVXNiTjBTZDdIR3pqWUUyS2VU?=
 =?utf-8?B?bms2YXU3T0xqRndxQTFYQWdkcEI1RkFmSm5Odkc2L0k0Mk1CU0NFeEV2M1Ez?=
 =?utf-8?B?MFJZUVQ1STY0c0gxZHdSWHYxQ2ZKTkVQaUgxcWlsSGV1T3c0K1Vmbm9Xd1My?=
 =?utf-8?B?SW5VemdRa1A2TXcwTVExTWlhMkJNd0txS1Uvd1Q5bzVNQTREYWlTeW9VL0Yw?=
 =?utf-8?B?ZEdkcFl6TnUwdm5TdnppU3FOUkR4WkFDWlpicGNjY1VHTDlaN0svYXVVRGdt?=
 =?utf-8?B?N1F3c0kzY0VvTWY0REJIM3htbWpnVGtyT0t2Q3lkQnYraXp5N2czbEpjaHFC?=
 =?utf-8?B?elRUbzJlam45TGV6VzlybFlLQkF5QXRpdG10N0lhb0ZvMjRuQzJYMmJVaVBi?=
 =?utf-8?B?d1gwVUxYalRzangybEVKODBsUllCUUJDdmtrOG5lTXM2cFdvbkJjVTA1S041?=
 =?utf-8?B?Mi9iUVlOVUU1WnJnN0tzV2hlYUIzcEE4aUZERmlsSk1HL0k2RFFRSDFGTmNO?=
 =?utf-8?B?WmtxS3RKVnZ6OFoxRjArWlVscEtoUnphTjNSbE9uUmV6UW92elQ2cU12TGZM?=
 =?utf-8?B?a1F5OTFHWHlRWkVITUdJejlDMkxHeGI5Rk15bXRlVENaYnBqdnY3WkdqOHk0?=
 =?utf-8?B?YkpvWFlhdUVMb0U3RlEzUXdUQjFUbXIyT25NSExsMXpqLzRBNVoxZXY0eEl6?=
 =?utf-8?B?a2dNR3pEbUo2cTN6a2tJSXZBbGNLb3VPeTg1WDhrNjVzTTNnMnExMnVxdWl3?=
 =?utf-8?B?d2V3ZEtDYlIxRlR6Wm1ITFJaR2NqdWZua2s4cnRaaEVoSm9XY2dKQndzSTVs?=
 =?utf-8?B?TFFFc24yUnJmdit4alpSSkZGMW5VTXR2RDJ6QUY0a2t5T3ZpYWVycENlbHAx?=
 =?utf-8?B?WHgzaS9uSVdQamxkNlJWZFdWYWR5R3lIVFpYT0pWTS9XRGlVVHdFNVVlOXpn?=
 =?utf-8?B?Q0MwNnVvSUVhK2dFM3pGQzhFZ1hEMWJFNUhrTy9IemtnKytHVFB3a1FkanJK?=
 =?utf-8?B?M2ZIWGJ5YWFBREpCUDl1dlZCcnNmWWFERWc1TU05VEhwaWc2OENxV3FHOU1C?=
 =?utf-8?B?YzZCaXVsTWZ3djUybW1xT1h6a0JseTdMMTRhR3NISXpFWk55blZZdVd3Z3dj?=
 =?utf-8?B?N0s1UlhjY2xYS1VyQWMvLzFsZ2NXNTNxQ2M5ZUsxZmo4eHAxQUtVeE5oaDBh?=
 =?utf-8?B?MzQrWmNPU2d0R3ozbmVTRFRRcUZFM2N4QWQ2ZXArVXgvNlpZK2tRTnNUZHdi?=
 =?utf-8?B?TC9leGMrNzNqUXNVak9NODdrN0dwUlN1T2g0UVNQbTdLdk5TZFdvYk1mRXRV?=
 =?utf-8?B?SlJOMlhtYlVJTDAzdTFVbElnSXpRMTRlOHRVbkVkMjJqR2dLTExvdjFGMm9L?=
 =?utf-8?B?QmVxNCtKN1dhOWl3THdwZGtteENtbjVyRVZnOHczN1RvRnlKZnJpSmgwYkw3?=
 =?utf-8?B?bkptZnlndlZOTDQ3MU5FQVBoOENMelpPSm1JYVpnV05CWTRSbGMrT3lrdnUr?=
 =?utf-8?B?bHRWbUxlTy8wZHlXY1hnVy9nTSthKzloQk9IcFgvQm83OEFTRFFNcjVRQnVz?=
 =?utf-8?B?TFNTM0ZGNEFtTW94QWtZaWQxcnlhaXYzYzBOaXpmYXBVenoxQjdjUjkzOTFn?=
 =?utf-8?B?MFJCcis3MjVvdktWVzNOQi8xT05FWWVMOGo5U3pQbnUyQ1VRZjE1bFlOeGN4?=
 =?utf-8?B?R29jN2RZcWpxamsyajNZWnc0OFg1S2F4UGorZFRSZlREL0VBeU15Q21zVis0?=
 =?utf-8?B?L0x5WkdFdXhXVWJ2NjdEcGwwSzJWbTNSWjlnbGZDRTg5Tk9XdUJ2TVV0bm5t?=
 =?utf-8?B?YUxKZVdVNzlwNzNyYjZnY2dMN3ZLOUpnTFZzWTJhV1BLeTM1MnR6bS9BU0VI?=
 =?utf-8?B?ZHlQeFZUNU5qeGdXcWc5TUxPa1RxKzY0cFZzZElYVjB1bTJxcWJzUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b649de4-ca35-4b08-5870-08deeed7a9bb
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:45:16.9951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaN8RbZP7JV4q74Ropw9Ym8O2aXSuX3/tF4cVijfKp/Dwf8BsyFvAKmAKGisdszQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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



On 31-Jul-26 12:21 PM, Wang, Yang(Kevin) wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, July 31, 2026 12:57 PM
>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
>> Subject: Re: [PATCH 3/4] drm/amd/pm: refactor user PPT policy save and
>> restore
>>
>>
>>
>> On 31-Jul-26 8:40 AM, Yang Wang wrote:
>>> The existing user policy representation has three ambiguities:
>>>
>>> - A numeric value cannot distinguish explicit zero from an unset policy.
>>> - One value per controller cannot preserve independent AC and DC
>> requests.
>>> - Suspend-only restore misses runtime resume, GPU reset, and table reload.
>>>
>>> Refactor policy storage and restore as follows:
>>>
>>> - Store values and validity masks by power source and PPT controller.
>>> - Save writes against the active source.
>>> - Restore the active source after default SMU setup.
>>> - Reapply the target policy after live AC/DC transitions.
>>> - Use the target source default when no explicit request exists.
>>>
>>> The late-init path now covers system resume, runtime resume, GPU
>>> reset, and custom PPTable reload. Common code owns persistent policy;
>>> PMFW continues to own effective current limits.
>>>
>>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  2 +-
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 89 +++++++++++++-
>> -----
>>>    drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +-
>>>    3 files changed, 68 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> index c3688b3b12cc..ce526db4d24a 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> @@ -508,7 +508,7 @@ void amdgpu_pm_acpi_event_handler(struct
>> amdgpu_device *adev)
>>>                      amdgpu_dpm_notify_ac_dc(adev);
>>>
>>>              if (is_support_sw_smu(adev))
>>> -                   smu_set_ac_dc(adev->powerplay.pp_handle);
>>> +                   smu_set_ac_dc(adev->powerplay.pp_handle, true);
>>>
>>>              mutex_unlock(&adev->pm.mutex);
>>>      }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index 99d42446cfc8..43d5dd7dce7e 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -488,12 +488,52 @@ static void
>> smu_set_user_clk_dependencies(struct smu_context *smu, enum smu_clk_
>>>              return;
>>>    }
>>>
>>> +static void smu_restore_ppt_limits(struct smu_context *smu,
>>> +                              bool restore_defaults)
>>> +{
>>> +   enum smu_power_src_type power_source;
>>> +   struct smu_ppt_limit_range *range;
>>> +   uint32_t restore_mask;
>>> +   uint32_t limit;
>>> +   int i, ret;
>>> +
>>> +   power_source = smu->adev->pm.ac_power ?
>>> +           SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
>>> +   restore_mask = smu-
>>> user_dpm_profile.ppt_limit_user_mask[power_source] &
>>> +           smu->ppt_limits.supported_mask;
>>> +   if (!restore_mask && !restore_defaults)
>>> +           return;
>>> +
>>> +   smu->user_dpm_profile.flags |=
>> SMU_DPM_USER_PROFILE_RESTORE;
>>> +
>>> +   for (i = SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++) {
>>> +           if (!(smu->ppt_limits.supported_mask & BIT(i)))
>>> +                   continue;
>>> +
>>> +           if (restore_mask & BIT(i)) {
>>> +                   limit = smu-
>>> user_dpm_profile.ppt_limits[power_source][i];
>>> +           } else if (restore_defaults) {
>>> +                   range = &smu->ppt_limits.range[power_source][i];
>>> +                   limit = range->default_value;
>>
>> This should be restore the current limit before a suspend/reset and not the
>> default limit. The current limit could be set through out of band also, user
>> profile values won't reflect that.
> 
> Please check the call sites.
> 
> The quoted default path is an opt-in fallback for AC/DC policy restore, and it is not used for suspend or GPU reset.
> Suspend and reset invoke smu_restore_ppt_limits(smu, false), which replays only limits recorded in user_dpm_profile.
> 

Yes, I'm specifically talking about late_init path. It gets called after 
a suspend or reset. It's about a case where user dpm limit is not present.

> The profile intentionally does not represent out-of-band state,
> and the amdgpu driver has no ownership or synchronization contract for PMFW limits changed outside the driver.
> Supporting that use case requires separate policy and should be addressed in a separate change.
> 

This only requires restoring the current limit after a suspend or reset 
when called from smu late init if a user specified limit is not found. 
It doesn't need to revert to default limit.

Thanks,
Lijo

> Best Regards,
> Kevin
>> Thanks,
>> Lijo
>>
>>> +           } else {
>>> +                   continue;
>>> +           }
>>> +
>>> +           ret = smu_set_ppt_limit(smu, i, limit);
>>> +           if (ret)
>>> +                   dev_err(smu->adev->dev,
>>> +                           "Failed to restore PPT%d limit: %d\n", i, ret);
>>> +   }
>>> +
>>> +   smu->user_dpm_profile.flags &=
>> ~SMU_DPM_USER_PROFILE_RESTORE; }
>>> +
>>>    /**
>>>     * smu_restore_dpm_user_profile - reinstate user dpm profile
>>>     *
>>>     * @smu:  smu_context pointer
>>>     *
>>> - * Restore saved user power limits, clock frequencies and fan settings.
>>> + * Restore saved user clock frequencies and fan settings.
>>>     */
>>>    static void smu_restore_dpm_user_profile(struct smu_context *smu)
>>>    {
>>> @@ -509,17 +549,6 @@ static void smu_restore_dpm_user_profile(struct
>> smu_context *smu)
>>>      /* Enable restore flag */
>>>      smu->user_dpm_profile.flags |=
>> SMU_DPM_USER_PROFILE_RESTORE;
>>>
>>> -   /* set the user dpm power limits */
>>> -   for (int i = SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++) {
>>> -           if (!smu->user_dpm_profile.ppt_limits[i])
>>> -                   continue;
>>> -           ret = smu_set_ppt_limit(smu, i,
>>> -                                       smu-
>>> user_dpm_profile.ppt_limits[i]);
>>> -           if (ret)
>>> -                   dev_err(smu->adev->dev,
>>> -                           "Failed to set %d PPT limit value\n", i);
>>> -   }
>>> -
>>>      /* set the user dpm clock configurations */
>>>      if (smu_dpm_ctx->dpm_level ==
>> AMD_DPM_FORCED_LEVEL_MANUAL) {
>>>              enum smu_clk_type clk_type;
>>> @@ -932,7 +961,7 @@ static int smu_late_init(struct amdgpu_ip_block
>> *ip_block)
>>>       * is unnecessary.
>>>       */
>>>      adev->pm.ac_power = power_supply_is_system_supplied() > 0;
>>> -   smu_set_ac_dc(smu);
>>> +   smu_set_ac_dc(smu, false);
>>>
>>>      if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 1))
>> ||
>>>          (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 3)))
>>> @@ -967,6 +996,8 @@ static int smu_late_init(struct amdgpu_ip_block
>> *ip_block)
>>>              return ret;
>>>      }
>>>
>>> +   if (adev->in_suspend)
>>> +           smu_restore_ppt_limits(smu, false);
>>>      smu_restore_dpm_user_profile(smu);
>>>
>>>      return 0;
>>> @@ -2746,7 +2777,7 @@ static int
>> smu_set_watermarks_for_clock_ranges(void *handle,
>>>      return smu_set_watermarks_table(smu, clock_ranges);
>>>    }
>>>
>>> -int smu_set_ac_dc(struct smu_context *smu)
>>> +int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
>>>    {
>>>      int ret = 0;
>>>
>>> @@ -2754,17 +2785,22 @@ int smu_set_ac_dc(struct smu_context *smu)
>>>              return -EOPNOTSUPP;
>>>
>>>      /* controlled by firmware */
>>> -   if (smu->dc_controlled_by_gpio)
>>> -           return 0;
>>> +   if (!smu->dc_controlled_by_gpio) {
>>> +           ret = smu_set_power_source(smu,
>>> +                                      smu->adev->pm.ac_power ?
>>> +                                      SMU_POWER_SOURCE_AC :
>>> +                                      SMU_POWER_SOURCE_DC);
>>> +           if (ret) {
>>> +                   dev_err(smu->adev->dev, "Failed to switch to %s
>> mode!\n",
>>> +                           smu->adev->pm.ac_power ? "AC" : "DC");
>>> +                   return ret;
>>> +           }
>>> +   }
>>>
>>> -   ret = smu_set_power_source(smu,
>>> -                              smu->adev->pm.ac_power ?
>> SMU_POWER_SOURCE_AC :
>>> -                              SMU_POWER_SOURCE_DC);
>>> -   if (ret)
>>> -           dev_err(smu->adev->dev, "Failed to switch to %s mode!\n",
>>> -                  smu->adev->pm.ac_power ? "AC" : "DC");
>>> +   if (restore_ppt_policy)
>>> +           smu_restore_ppt_limits(smu, true);
>>>
>>> -   return ret;
>>> +   return 0;
>>>    }
>>>
>>>    const struct amd_ip_funcs smu_ip_funcs = { @@ -3020,8 +3056,11 @@
>>> static int smu_set_ppt_limit(void *handle, uint32_t limit_type, uint32_t
>> limit)
>>>      ret = smu->ppt_funcs->set_ppt_limit(smu, limit_type, limit);
>>>      if (ret)
>>>              return ret;
>>> -   if (!(smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE))
>>> -           smu->user_dpm_profile.ppt_limits[limit_type] = limit;
>>> +   if (!(smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>> +           smu-
>>> user_dpm_profile.ppt_limits[power_source][limit_type] = limit;
>>> +           smu->user_dpm_profile.ppt_limit_user_mask[power_source]
>> |=
>>> +                   BIT(limit_type);
>>> +   }
>>>
>>>      return 0;
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> index 3d32ee723b8e..698197a285e3 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> @@ -251,7 +251,8 @@ enum smu_memory_pool_size {
>>>
>>>    struct smu_user_dpm_profile {
>>>      uint32_t fan_mode;
>>> -   uint32_t ppt_limits[SMU_LIMIT_TYPE_COUNT];
>>> +   uint32_t
>> ppt_limits[SMU_POWER_SOURCE_COUNT][SMU_LIMIT_TYPE_COUNT];
>>> +   uint32_t ppt_limit_user_mask[SMU_POWER_SOURCE_COUNT];
>>>      uint32_t fan_speed_pwm;
>>>      uint32_t fan_speed_rpm;
>>>      uint32_t flags;
>>> @@ -1953,7 +1954,7 @@ int smu_set_soft_freq_range(struct smu_context
>>> *smu, enum pp_clock_type clk_type
>>>
>>>    int smu_set_gfx_power_up_by_imu(struct smu_context *smu);
>>>
>>> -int smu_set_ac_dc(struct smu_context *smu);
>>> +int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy);
>>>
>>>    int smu_set_xgmi_plpd_mode(struct smu_context *smu,
>>>                         enum pp_xgmi_plpd_mode mode);
> 

