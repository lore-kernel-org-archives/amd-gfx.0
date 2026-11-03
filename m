Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC78606C583
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LQRU880C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0704010F4E8;
	Tue,  3 Nov 2026 10:44:33 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB3FA10F4E8
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 10:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYeapZV7mk3jYv60mrYYfJMOOdaLgGQQTH+x7eNwYud8OjPfysULwQt2LE3U5Csf5dpE+YZkWAQmw/O+9my6KjDDMTat8bqiloEdMB+83l4+g8BHy4pmaLOKj4iOchYQQlLPrcO8SHs5Got1ikNV4xlE+blJyv3Wp0X++L6uUPM3NwXFbMT4Si4MJ1TaQoMQGwnNDdFWDZ4u8n2h+2EaGrPAmEjZmDux6cFIaW3BOTX/Av5+c2ho8dsSIZ+F72vCOlp9o+D4ddVMslvtIdvWenMtZuHHmY4ay7qzCfqWwSWzQeTlw0eb1/kMYtAP14jYhJIsPz1sCburhxlAD/LmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0oUkoItGfY6aJEBwh2Pj/RbJp3Mg8U+eDf5OCYXV68=;
 b=KMqMN5NgfI4SNwcKsCTeBJqYFbFlWAbsJTijvCo3B8XkeCnOaJtThuKQJqHHXTDd8yeEoSIAkmos04iKjqVzPL1jlZcUN08vlzxOVkpzaKtqgU2ACnFJBmxKisF/htvTSGDRbtvno+Vi0PKD+u1XKcJlb1FlKvsZjjpMmjkXlA91pnsQ/RhdtuTRMsFJlJ6FGIOBWa2FAMGRcUXi6q2k94G77SB0QKbR9iDFR822kwW+wGN5EnvohOugMQeWAIqOEHozJzH7YHes0+xE57sw1P59SxOgHryT3hJNKdpIUL+8Yz0yPSwEi66uopcoSuzFMi+A2aV+cS1Us2xzGDCLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0oUkoItGfY6aJEBwh2Pj/RbJp3Mg8U+eDf5OCYXV68=;
 b=LQRU880CWIAervyMo9d1UKqZmYGh5j+Dj+qtWIwB6T8hshkmH4PsV8ObzEORk3W1U0RgW+hvejvhqSAi9XKlG0IK4gkUEvSugBtr7/NZSNrvj7YE59c9bQzSAEi4VHqdbXiDYhMl8W0WHLnwl3aDo4/Qy2z1IObFKnfIHvPxDh8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:44:24 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 10:44:23 +0000
Message-ID: <825f3627-cfa4-4da1-8bd5-a53997f72709@amd.com>
Date: Tue, 3 Nov 2026 16:14:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] drm/amd/pm: restore the forced performance level
 after a reset
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Kevin.Wang@amd.com, Christian.Koenig@amd.com,
 Felix.Kuehling@amd.com
Cc: Veerabadhran.Gopalakrishnan@amd.com, Pratik.Vishwakarma@amd.com
References: <cover.1793689935.git.Priya.Hosur@amd.com>
 <f370dc0e7025b9b39cac723b1b60ccbd339d233f.1793689935.git.Priya.Hosur@amd.com>
 <51d3d345-e1f0-48db-af47-de488e428dcf@amd.com>
Content-Language: en-US
In-Reply-To: <51d3d345-e1f0-48db-af47-de488e428dcf@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0238.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|BY5PR12MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d1866c-c50e-4a01-6b0c-08df39976c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|10067099003|56012099006|261102123227099003|22082099003|261009223027099003|261009221227099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|11063799006|4143699003|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: hTSOCvu6RPya5t9+79wNX2dJAZYXOHkdnqnMkkACVvlu3adkkig+6W4NoH2kS6wbpIhEZSLi6ME0GreaZNYpKCQJLBZPu74tCSirprLTKQc7YPDTj7KeeWfhqqScnbhwUg4bRslkljvWcUP6uYbEh7KaeQafUhbCCHOV5sNgaZrw6iHJFhym7g569oz5bmu4EttrGXYLpJGTIjMk4/AF5nGb1M1tcCuFlFJIoqrbgdGH3+4pCsfiTXRy5W3AK3Cvh5fW3hEn3wRqct1oKFdM4ZScSoqB+FoHdbDR69m+sDI+EFRS+FSpfmayoYKCKIhTFbrK6mdE5AR4r8pAe1oyEdW+obBDViF5JG6ByZZhRIyVt90N5NlRrNYxoIdsS2ySnIQ5Z+BhlKtrDqIgZ+tpBIJ67Uifd/mYtWs0iKJSN0yW+EBGWY6iAYOzcrxc2rMJuXWcH+h0Ga42NjR5H4Kt4Txm8/syefPIA2TjoH3h58yApyrsPnzCME9+2Ox2aNJftyL5wGsR253D7O8jSYNq7x/r0cMfbuxYyexE657/lGGt5SSsxLi/1pVuMxLjKsoZAWaXAH6n/DmzBmeCdReFwX2X0rMugHLO5VSfjZF2eXev5Z3VwbcqkYTTR71djqt/A1/trKX7J7BeHiDBM66eFk8StFBHiLASErHvrU6pX1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(10067099003)(56012099006)(261102123227099003)(22082099003)(261009223027099003)(261009221227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(11063799006)(4143699003)(261028144727099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnV6QU9oWXAvV2R5U1FOUC9lSVk5QzdqL29rblVxWlJ3NlZoVUNXQUZFRWhi?=
 =?utf-8?B?SGRpc1Y1d2xOcjNwcHJJY1BMaDNub0xKS0lMUjVBK2VCeVJRdmlNNEw2ZjJ3?=
 =?utf-8?B?NzR3NWI3N1hERUdWZmFrczhmNVFZL2hJY1lkb29HQXlPblRvK0VFcXg0bit0?=
 =?utf-8?B?RExnUjVsNUtPVEtYYjByMTRUc1NDRndMVkxCTmFzWm9EU2F6NTBPNGFOZFdi?=
 =?utf-8?B?b2N0UTEwbG1ZTjFvZzhkK2ZpSldHbDN1NFZWNTBKZ0ZVS0REQmlCY1hyN1lj?=
 =?utf-8?B?UTJ1UlluNVFsQ3I1QkcwRkVVZThQQmZ6anJ1QjBIdW1TMmY0eWV0RnlxVkl1?=
 =?utf-8?B?MXY2dEVzb3hSN1ZWN0VMMXJVcTZ2NkdWSkMwRDl2cnFsUmRIN2NuMHN2dFIy?=
 =?utf-8?B?SzZyNVY4L3RxM0xpVURyWlVQem1uUVFVdENlejFEQ3FqTGpyMVZMaEpZN2FN?=
 =?utf-8?B?Z0hGcVFtV1FDa0FjMzNvYTVvTUg2N0VKemJRYjZZMWk3UnlkamUvd2JYRlVw?=
 =?utf-8?B?cmhKRjVmYVlveERsR2t2enhCNFFnNjk1alFGbzNLYVRSa09zSHNELzlGY1JK?=
 =?utf-8?B?U1ZCVlI1SkZueXF4UHMvbG44bEJTOHRnejl2VHoreDZJbjVkRDE1ckZmWUFX?=
 =?utf-8?B?bC9VakZ3YS9iWEI0eXg5b21TUkcyL2tsL3NBZjVyaFZTcjBxa3duVWJXTWRk?=
 =?utf-8?B?SFdBVlI1bENjeTJmM25MTFZydER2amFGV1pFUjFlMmtRSmlOVjg4L3owVm9k?=
 =?utf-8?B?dXc3TGlFMU9SUW0ySi96VlpuNzhYOWRvVVg4WXlkQUZrNG0yaDJoLzFhMUtF?=
 =?utf-8?B?U0lkdTZONHI3L1NNWDdtWHd1bFBQQ1ArYkhrSU9hcmZOcVVzekVxSm5YcmVG?=
 =?utf-8?B?L0E0QXowbWVTM1J1Z3FBaTc5aWhSRTNzc3dPeXNFb1NCTlIvL2ZESHcvNE41?=
 =?utf-8?B?Y1ZlcGRLbktwSjlWWU1HMTlmRU1GbFlqcEc1NXJ1ZjJIbURkN0VKMWxJcVVp?=
 =?utf-8?B?clJiOEIyUEFvNHVYZHE4bEFqQ091bC9zS0lvcHlZb0tpdFZ6U2lOMFVKdUxT?=
 =?utf-8?B?T29PVlR2ZHVDUlpiSDU5RTh0c1lrK1huNlJjeUc4TVdtYTZzZGRVQmFsUlBn?=
 =?utf-8?B?TjE5NmoxNEV5R2VHSHlkWjcxdEdXbFl4cnpLbUVydGZiNnZpWVNVaCtSN3Fp?=
 =?utf-8?B?WXFNZXozcTYwYnVrZTVJdTFSeERxbHB0L0wzaDdJcHlrZFE0R1Y1aVJscTk3?=
 =?utf-8?B?NzNFaVhzak4vVXMrdFlQbC90NkFacDlzeWprRy92WXlmSWo5WkExNTRFSjhO?=
 =?utf-8?B?bkNjY2ZBS0xJaDBSYmFoZmdGMnhVdTRTbE1ubzJtZVlkSHVrd2RjY3habEdB?=
 =?utf-8?B?RHczL1kyOXNUWHZyUjRqWnBNbC9ZRXZGeVMrVXJvWHlMQndTWmNPMHdtd0pt?=
 =?utf-8?B?dnFpZ25PaXExT01qVVJpZllOQ1VRZ2IydEVGNTJnVk05aDk5OERJM3NuUk9J?=
 =?utf-8?B?R2d1bXp6aXVpY1NuUjNRKytjdWppQ0lSRkUvM3JZcjU2U0pRc2dyQmpTK01C?=
 =?utf-8?B?ZVRhSTk1TUdPOHpWckJrZDgwbFFZaFkxbm5CVGVoUDZnTndpZ1N1RVV1T1hh?=
 =?utf-8?B?Q1hrZzFQMEZma1gwL2o4bnpFSFBmL1VScHFUUE8zTFB3WWpRNlAzUEltYkdK?=
 =?utf-8?B?Mm5PdzhBR3VzQnc2UUQycExXUmdoRkRoMzVMem5JM1RIb1o5Qk9XL0JjZmtQ?=
 =?utf-8?B?UmRpckZBVW41bmxDeEMxL29rU0tyUnd1b25NSEhLczFGMWhoMEp1QmlJTjJR?=
 =?utf-8?B?clNhVFJpTURTOXBFcm42RW9DazMySUc0MmpLSklTOXZuazB0L1hsRHBvZ1d1?=
 =?utf-8?B?QzBmNlVNUVpCZkxwcVZXYmJ0M1p5NEk0UWFDSFpDa29iUGprTjUvcnlwR01V?=
 =?utf-8?B?WlhQaStOMnErL3I2ekxiQnEvdEg0dXNLbXVRQ2FoTTVtTHdCT1kyTU5JNmVV?=
 =?utf-8?B?cWZOb3VzOStSZHNjZVQ3RFkrSkVVQ2FDU3duUFQyOTRwQzVZQ1NKUklhSE9a?=
 =?utf-8?B?L3hIY1RFenFiLzN5L2s4WjlyclNnbEJabFlNWWZsSVhBN1cwdmYydUpmRDNY?=
 =?utf-8?B?T3RMMnhCUXpFSklKNVk2WlErNXpzU1dZWHhJQm5Sa09DK09jUkpFUVRvZjRw?=
 =?utf-8?B?YXRnYUpNS1lvakdBSDI2RHRyd2RibEw5ZTd2VXFGSDN0OW9VUnZpYmsxTlF4?=
 =?utf-8?B?elpvYWFoQ0JWcHkyNzZPSE1xQUp2cEhNcjViZzBsa2RrOUh6OC9tUmZ6RU9N?=
 =?utf-8?Q?j11KDqtIiosSvpWLWB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d1866c-c50e-4a01-6b0c-08df39976c65
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:44:23.3744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvnzYdj68wXCctHnjq/sndGarqA66maq8JX/wklNm2VhV2ZkzK1+XNcKjwfiezgq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 03-Nov-26 4:11 PM, Lazar, Lijo wrote:
> 
> 
> On 03-Nov-26 3:58 PM, Priya Hosur wrote:
>> smu_late_init() re-applies the DPM level with
>>
>>    smu_handle_task(smu, smu->smu_dpm.dpm_level, 
>> AMD_PP_TASK_COMPLETE_INIT);
>>
>> but smu_adjust_power_state_dynamic() only programs the hardware when
>>
>>    if (force_performance_level || smu_dpm_ctx->dpm_level != level)
>>
>> AMD_PP_TASK_COMPLETE_INIT passes force_performance_level = false and
>> smu_dpm_ctx is &smu->smu_dpm, so the level is compared against itself and
>> smu_asic_set_performance_level() is never called.
>>
>> PMFW is reinitialised by a reset and comes back on its default curve, 
>> while
>> smu_dpm.dpm_level still holds the level the user forced. The device then
>> runs at the default level while sysfs keeps reporting the forced one. 
>> On an
>> SMU 14.0.1 APU gfxclk drops from 2.8GHz to 600MHz while sysfs still 
>> reports
>> high. Writing the same level again does not help either, as
>> amdgpu_dpm_force_performance_level() returns early when the requested 
>> level
>> matches the cached one.
>>
>> amdgpu_dpm_reapply_umd_profile() restores the PROFILE_* levels after
>> recovery, but returns early for any other level, so high, low and manual
>> are left on the PMFW default.
>>
>> Force the level to be programmed for AMD_PP_TASK_COMPLETE_INIT during 
>> reset
>> recovery. The cached level is left untouched, so if programming fails the
>> level the user asked for is still retained and the failure is logged.
>>
>> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/ 
>> drm/amd/pm/swsmu/amdgpu_smu.c
>> index a901f8535598..654ff6824fdd 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -2553,7 +2553,12 @@ static int smu_handle_task(struct smu_context 
>> *smu,
>>           ret = smu_adjust_power_state_dynamic(smu, level, false, false);
>>           break;
>>       case AMD_PP_TASK_COMPLETE_INIT:
>> -        ret = smu_adjust_power_state_dynamic(smu, level, true, false);
>> +        /*
>> +         * PMFW is reinitialised by a reset, so program the retained
>> +         * level again even though it matches the cached one.
>> +         */
>> +        ret = smu_adjust_power_state_dynamic(smu, level, true,
>> +                             amdgpu_reset_in_recovery(smu->adev));
>>           break;
> 
> There is already a reapply profile to handle this.
> 
> Does it work if you replace the current smu_reapply_power_state_dynamic 
> by calling smu_adjust_power_state_dynamic(smu, level, true, true)?
> 

To be clear - replace the logic in the current 
smu_reapply_power_state_dynamic.

Thanks,
Lijo
> Thanks,
> Lijo
> 
>>       case AMD_PP_TASK_READJUST_POWER_STATE:
>>           ret = smu_adjust_power_state_dynamic(smu, level, true, false);
> 

