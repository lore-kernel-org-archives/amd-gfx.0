Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75503C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 18:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF23710EF43;
	Wed, 15 Jul 2026 18:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="truSElh+";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013022.outbound.protection.outlook.com
 [40.93.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D7FE10EF43
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 18:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFQBXS8N2wnGO1T+Z3rwFV1BqisbLKnnmJQ57qIkubWDwovDiEId6FHyIrnVBYZUvBAXY5cV2Zyx/8+xrzhDWMhxXdH5rdZf8EiiF6YsmTE/vzPBn3Lsn/s/FEq+tFbF0Gei2vViKIYShJ/uTC4gf80UKJQ5w011u9nf356vuDOHJWJpDFWDK8GKQVmX8hpXp2qU26yjJEuztpKw/ItZntmY6vV21gPHagNHV6sjsjYz6lEFrcRe/Kve8OW6wyjHoPmTVD8AudgRMi65zcLcAqsnHTpu1KoEdnrlm8b6ODXlbwRv51aH3q1wm0LDbOBKBOD4jM/x6J9SU0KgpAVgfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VevA9Lcdnx0d5v7iFUBtdr+6i6w+FQDI474BBA/gNXY=;
 b=G4x0hEFkgbrTO/yj6LBRAHV+MrBiTgrpP4MmLjoAwukn53dK3t/BtNN+Wk3SvPpny9EVEMJRlQjleWvDwFM6gKbzDsUvsFq0HK/Xj0Z9LMGVOd43DPcKcODm5Q1yPxOtdAKXWM7VHWJVn2V+LPkXsW9gL7JP+0GMggqNNxRIL/zPuQiEVO4a/1v6jkaemrmxL1+/ddyC4SPla63Nj+XnXpbmXl3FnxfvOQ5B2ZiN/yLdWt1DqQiaCyI+widkcsXktwMH2BrASf8FjsUw0xQA1fB+L/6d8s/TRuRl4qXEld/rkBIjD2sUt0MmGDdE7r80Ix7zKaLmhfNOdq0u/vdyUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VevA9Lcdnx0d5v7iFUBtdr+6i6w+FQDI474BBA/gNXY=;
 b=truSElh+JgPUi8lJRhz9u8NunUpWf/AzxWg7LjtpmquFK/JJBUyOXPG3tjO7Q5SEAabexrnZ3xjkDDfPXsdUEBf5Mp889M+JccUDDqoVpohuhy1NQJwSKn3ahfkhCR4cwZdbFgBatxPHxXa/6r2y51RhV+erEJTGnxMdWtVcv6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 18:10:43 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0181.019; Wed, 15 Jul 2026
 18:10:42 +0000
Message-ID: <d7de2367-7b71-420c-88aa-807578ce5ddf@amd.com>
Date: Wed, 15 Jul 2026 14:10:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/display: Check HDMI FRL support before
 creating polling workqueue
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>
References: <20260711113009.26512-1-timur.kristof@gmail.com>
 <20260711113009.26512-2-timur.kristof@gmail.com>
 <CHXPR12MB999220BD34392F514B0B5C948AE5F82@CHXPR12MB999220.namprd12.prod.outlook.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CHXPR12MB999220BD34392F514B0B5C948AE5F82@CHXPR12MB999220.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::26) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2c3c24-f045-49a7-b37e-08dee29c6224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|921020|5023799004|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PUkh/NlKpNgg/iqPMCx/a2dLvn4b8mUy1SMBiFlDd7G/RdG8FQYgJfZj6tDwYCOuv4RT0j7noeD82soVP7Y5AEWtPK+G9D1O98ZbimUakoYJkm/8+Yiyg6K45KFwheXxCUya/nWjtDt8AUUEuoXMPYuZaxAP61/RJCXkqLgNIkqT/kU+h9AocA9OAkbJ08UloWB/ZIAP7CExD2cB5FKa+b+7pC5QL6VEgyJitsicHqMAqLEUfTLXnIS0+SiNResORSiktEsckvi8B9kwVda+F1NYf9mV/f6y7oZ10B16iPo7nL+Wn4tO7kuj9h0w7cXEJOEKnOpmARaq4hdUmod3cOQ8i5lbBEaCRo/27KJXJJvFfPl4kqjSX+WaurmwzD/D1RUNGZSzpPVjzTsFyOi5UyQ1ZT1wLUhIJIGZjZ3qjhzOuL1mVOWoIaZIdip4tLGJVAVMl6t8xXdl4s/KfanYAKikC00Ux1MzPWUQpcHqljWO0952et49lWupDnns9TgMJVrayqrigBpUoK35Yu/8QjvjlJbQgLlEa/DQo6lj5rNU0TAd/CypWkNCVInTZJ5qDXhv3UoMQktFpWU2OiNYxhTntpN7cMi2q7o+UN8Oc7MewqaQXQQFzw6X53Ah7AgdGDftLZE0nuAe872PfIfguCLBxP7fCL/DzrlYTNy93fbxG5c/Ao+rkYkFrmkvCM8EW44xz53iS0/Qf0PKi0wfFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(921020)(5023799004)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEFFMTFBSnN1bGl1c3FXZWhGb2V3cFBEUDhrQ1ptbzJxbnEya1oyb3dDdDRD?=
 =?utf-8?B?QlVadW4wZlVLU0RySTNUVmwxUTltU0xBZCtWWDZlVzZ6cGk3YVZJelRhMVpr?=
 =?utf-8?B?Y1J5M3hDUko2dVRsSG5yZ2U4RUZ6QlRhYkVERWFWdFpLdkpnRDMxNnQ2Tmhs?=
 =?utf-8?B?Rzd5MnNSMUVXK2tZNGY0RitjdlZJckdNN3pQN25oZU9DT0xscVdEK204aXdX?=
 =?utf-8?B?MUdnOEJ1K3dTRWl2dnBOalA5VjBvMDZId0JrVzNtMGU5ZWtFd2xqOExvVGtT?=
 =?utf-8?B?aGxha2VLMDJsOC9yRnI3T0JYbEVSTU1qaW0ySktvZFVYTUNsOFNDUUVDOU5m?=
 =?utf-8?B?cXd4M21XaVprWXhTUDVxUk92VlNuR3Q5S1VOQTJIS2NkU1YydEZId3R1dng3?=
 =?utf-8?B?TjRybGUxTThZL0xMcmR4RFpnYmR4akRMbHdXNnpCWHllMm1hcHdQMSs5QXE3?=
 =?utf-8?B?d1ZDdy93S3hvQjNMeTlER3VRb0FRRTNsWDh5WVl0NmIrWjd6UkkrYXhud1dy?=
 =?utf-8?B?d0JFL2JGMm1STWxmNGV4NDhzTzBWMUFSNVhmZE1oMFowZUhJMElCTE1mL3lN?=
 =?utf-8?B?SytOM1Y3OTZKQ3Q2S3MxMGRsMldUVGNoVm5SV0JIRzA2TThTZHN0WHhZcnEv?=
 =?utf-8?B?TWwyNnR4WWpGaE16MXBPRXVzK3krRGpSY0U0Z3dPclBPVktFVlhpdzc4Zkg2?=
 =?utf-8?B?K3k5ZEppaXNKMERic0lvd2plWXE5c1NhZUFnRkx3eGlZTFpOM0hpd0ozK0o4?=
 =?utf-8?B?dFYxTmVNbmpRcDlaRUR3ZnZmcUl3bEFzSlJIZVZEdEdnRnlEMFlOZy9jWGd1?=
 =?utf-8?B?T0VzNHBReEw3YzJGUFpaOHkrQ24zMzBucTd0bWRPeTdGNFFNK2ZlVmxTMGJn?=
 =?utf-8?B?RjR3WWVjQzVtZDRjSzJFYkVId3h4ckpucEJPTXNEaTBydUlrME41NEZpNERZ?=
 =?utf-8?B?bDAybGViWEhTc1NRZDExZjI3SmQwM3BzVzlYeFFTMDFuTkp3RjUxNUhSNllV?=
 =?utf-8?B?UHVCNDZSZGJkMjFQaGJrWGtKOXVzamhQOGtTR3dvemR1a1NnVHNRTGUvZHFK?=
 =?utf-8?B?STY2VWFsckQ3Q21KUHRCQVk1R1FPcWd3dDJNbmZHUHhKanZjQmpDZkFUeFFu?=
 =?utf-8?B?MjJwaTFSMVlEOVZERGhyTzJwOHF5akhRRVFIVlY1TjBSdTdCdnUrU29OeG1H?=
 =?utf-8?B?aURzTjdvUTNadUExZnUxOXRxYStnaUNJTktvZ0JYWlhPdFdGQlpuRnJ6dHZD?=
 =?utf-8?B?QjVjMlA1bXhaKzlJQ2VOaVVRdCtld0NxclRlYURYM2NDQTZPN1FJRjlvbG1K?=
 =?utf-8?B?V2hWdi9rZ0lyVWtMazNiODQzQXBjOVJnOVhqb1BsS1JTSVR0bzF1U3h4czY1?=
 =?utf-8?B?TTRucFEybGlaaDd6K1A3UkFhYVMxNkhOTXZMWTgreG5uaXMwam8rSGpBQzh4?=
 =?utf-8?B?ZDNNWDhZeWhqTEpVdWRReTBSYzQ0NXFOMVowRzNmWFZLYzlCNWp4UzlqSUhN?=
 =?utf-8?B?TlY5Mm1RYSs1M0luSjlKbDBlNHpoM2VNeUI4aURDdWRzdVB3aXg2OTE1dTNI?=
 =?utf-8?B?YmRqNVdiZ1dHSm1jSXhtWk1rK2FlUFVHalg4TW9KMWtVb3NjaUxPTk9ncnJH?=
 =?utf-8?B?OXRmUzRUQXNEKzVGMWxsL0ZYY1dNem9Xai9hMW13ZnRKcE0yeGdYK3FxOXNp?=
 =?utf-8?B?U3lENHNLMkRSMDFCeTRpSXRsNUNkWGlBM3loSW9FdmtnNWRrc05LMXNxdm5u?=
 =?utf-8?B?MEtqMllDUC8wOGd0MlltSUtWSkFodlFUN1BPeXdoVXRVc3ViQXBBY05hc1da?=
 =?utf-8?B?RC8wL0p4bDdyUDZTNWRHRENuYnh6Zk5aTzRiMUUrMGNyUExvQjVMZjN6ckZk?=
 =?utf-8?B?L1JiU0RnUG1qQlQ1UXkyc1RGbkF0eGFGVWZ3Nk41Z2Y2L3lFdi8xVEFVb2Yy?=
 =?utf-8?B?ZFBuT2FDb1lPaFJHeFBNUWt0dHAraG1YVTNyWXliQkVWUjBZMjQrUjIvYTVK?=
 =?utf-8?B?eHFxYndGd3VSbFVCVGxCc0pmclUzSUpQSDFGOFJvZ29yUGc0bXhSaWJQTDdO?=
 =?utf-8?B?cFMvajJQZ2lPZ3FvTU5pWElIaXd0UVdPVGNpdDZtTkp5M0FmdDlQeWNjOXcx?=
 =?utf-8?B?REdiaWtHNldneGJyM0tDWnFvdzNuMUYvdDI3clQxWTNqY0hyOW00TEZjdEFT?=
 =?utf-8?B?eTZwN3hUKzFsTU5yMjZzRW9UanJIY1lueVR0SjJPS2JCQm1ZL0JXcW9EblJ5?=
 =?utf-8?B?dmJnbUJkZy9mZkRHbHFwbnVkaEtrcjNFUWxLb3FCUE1SOVRMRUZCVWJFWWdl?=
 =?utf-8?B?dTFPZk5qYnZkamxkNSswUytNUC8yNUd3ei9RMHVpZ05HSWtwbkJEdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2c3c24-f045-49a7-b37e-08dee29c6224
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:10:42.4813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7goQoQ80b/46rNkjcX4ZjYs3bLus5sSURm+HTvjs1RVn5CegQX8JYWJDWoiVfUla2n9UsSGOBVkgekbsgHYBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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



On 2026-07-15 11:46, Zuo, Jerry wrote:
> AMD General
> 
> It may not be necessary to identify whether it is FRL when creating the queue. FRL is not determined until link detection. Whether make the queue active or not is dynamically determined by whether an active FRL stream presents.
> 

This checks whether the HW has any FRL capable encoders and only
creates the workqueue if it does. The workqueue is still created
regardless whether or not an FRL-capable device is plugged in.

Harry

>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Timur
>> Kristóf
>> Sent: Saturday, July 11, 2026 07:30
>> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Tvrtko Ursulin <tursulin@ursulin.net>;
>> Natalie Vock <natalie.vock@gmx.de>; Melissa Wen <mwen@igalia.com>;
>> Limonciello, Mario <Mario.Limonciello@amd.com>; Hung, Alex
>> <Alex.Hung@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>> Subject: [PATCH 2/2] drm/amd/display: Check HDMI FRL support before
>> creating polling workqueue
>>
>> The workqueue is not necessary when FRL is not supported or when it's
>> disabled. Add a helper to tell when the current board has any HDMI FRL
>> capable connectors and call that before creating the workqueue.
>>
>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>> ---
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
>>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 26 +++++++++++++++++++
>>  drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
>>  3 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 6299f0e384f1..87d7b60ceb3f 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -827,7 +827,7 @@ static int amdgpu_dm_init(struct amdgpu_device
>> *adev)
>>
>>               dc_init_callbacks(adev->dm.dc, &init_params);
>>       }
>> -     if (adev->dm.dc->caps.max_links > 0) {
>> +     if (dc_is_hdmi_frl_supported(adev->dm.dc)) {
>>               adev->dm.hdmi_frl_status_polling_wq =
>>
>>       create_singlethread_workqueue("hdmi_frl_status_polling_wq");
>>               if (!adev->dm.hdmi_frl_status_polling_wq)
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c
>> b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> index 1b6627a92d24..1a7073abb8ba 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> @@ -6592,6 +6592,32 @@ void
>> dc_mclk_switch_using_fw_based_vblank_stretch_shut_down(struct dc *dc)
>>               dc->current_state-
>>> bw_ctx.bw.dcn.clk.fw_based_mclk_switching_shut_down = true;  }
>>
>> +/**
>> + * dc_is_hdmi_frl_supported() - Check HDMI FRL support
>> + *
>> + * @dc: [in] dc structure
>> + *
>> + * Return:
>> + * True if the current board has any HDMI FRL capable connectors,
>> + * False otherwise.
>> + */
>> +bool dc_is_hdmi_frl_supported(struct dc *dc) {
>> +     int i;
>> +
>> +     if (!dc->config.enable_frl)
>> +             return false;
>> +
>> +     for (i = 0; i < dc->link_count; ++i) {
>> +             if (dc->links[i] &&
>> +                 dc->links[i]->link_enc &&
>> +                 dc->links[i]->link_enc-
>>> features.flags.bits.IS_HDMI_FRL_CAPABLE)
>> +                     return true;
>> +     }
>> +
>> +     return false;
>> +}
>> +
>>  /**
>>   * dc_is_dmub_outbox_supported - Check if DMUB firmware support outbox
>> notification
>>   *
>> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h
>> b/drivers/gpu/drm/amd/display/dc/dc.h
>> index 13c1f7cd9d7d..d27c7437ee7a 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
>> @@ -3056,6 +3056,8 @@ bool dc_set_ips_disable(struct dc *dc, unsigned int
>> disable_ips);  void dc_z10_restore(const struct dc *dc);  void
>> dc_z10_save_init(struct dc *dc);
>>
>> +bool dc_is_hdmi_frl_supported(struct dc *dc);
>> +
>>  bool dc_is_dmub_outbox_supported(struct dc *dc);  bool
>> dc_enable_dmub_notifications(struct dc *dc);
>>
>> --
>> 2.55.0
> 

