Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5460AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 05:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA91310EA48;
	Fri, 18 Feb 2022 05:29:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6EFD10EA52
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 05:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLWCiIeG9Y8b3GtTqgJHDv9SeJtx+OYl+YrUbtbzw2F4BZOTIElTU3j6BknK3jpqxLkGQUAfPS9id2sUxZKe2e3nfMQbOzYs2I4rTDomx1VnEPvxSTgqPeJbDRd0NjEwo7eYUunhkDVfdZ9aWBgrnMyXBK0idE1paT1qK4OPmffA1BR+/M7NfRt0ZTZMuQgnPG2CCvgxLm3dMo5teFtwxy81tfEwvTKdB+WuFQ24MEFvfASPZFKKBqexLNSsbYusql6elH6lLvleB3ncn/Wq/gwuNF/4WmlIVojHKEWKubIjb6gk3tP61yKxp+w0UUrdzck3Nr0uo394w41FvMKILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rw8FeujaHBNhbp0mo4RHHhEIRlMN9oYsl8STu48Nbwk=;
 b=BuZzIDutod2hq5zDadrSoOhhGcPmXQbkos1ZsHSQTySn8xz2Y2VGJsPrPRrgWjgISsD1wgELH0SLlxVriTAkXmuf6L79Dmydt+J44uwt/gdM534VRmZ83/S9oFyxIejdfsDxC4kYsVSIaWAliRgK8lQ6/alduAgEnJyKZWa4v9OrfOpLUYkrzdzi2NqRrA4jFj5bfyeiSSRFyYp63YXAgBkH71O3p4ljBvuThWxklA2mEoYsJRmsZOXHkh2xwX2wbYdrcE91dMEKz9jMiCDPkwtJA2Ay4RSVr7BvVThT7UCF+yrk8RIp9VWP63S6CmLoIAMw3YsHp4j0VaQgtO7VRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rw8FeujaHBNhbp0mo4RHHhEIRlMN9oYsl8STu48Nbwk=;
 b=lEacr8nmIcGe/DJALxG7aPizjVwsiJCWeTMM8Y9rmjstnC1GFAfk9YStE+8p0LiyPTOEbO3lCxdH+Z2of2nRA6stQmZzLVXxmaiEHNkedVLQLuq3Ltv4S8YexTcbiMxp1f/ETrE3tbWhiXi/28yXHJ/As5xItQJDjZQF2tO2UJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM5PR12MB1228.namprd12.prod.outlook.com (2603:10b6:3:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 05:29:37 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.4995.015; Fri, 18 Feb 2022
 05:29:37 +0000
Content-Type: multipart/mixed; boundary="------------h8VtTfqlHK9tf1380ICIOSpw"
Message-ID: <24c66104-c0d9-4556-fa8f-61cd45d8a2eb@amd.com>
Date: Fri, 18 Feb 2022 10:59:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: validate SMU feature enable message for
 getting feature enabled mask
Content-Language: en-US
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1645156501-18317-1-git-send-email-Prike.Liang@amd.com>
 <5db9229e-52c3-fc4a-f8b5-29a25366208e@amd.com>
 <BYAPR12MB32384F7915C0784BEAAD3223FB379@BYAPR12MB3238.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BYAPR12MB32384F7915C0784BEAAD3223FB379@BYAPR12MB3238.namprd12.prod.outlook.com>
X-ClientProxiedBy: PN3PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ae61e33-6261-4dba-f42a-08d9f29fa6eb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1228:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB122858E5B35B345A164AC1AC97379@DM5PR12MB1228.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8eziniy3Vv+GJuM3Jrlm9Ras8ZCgygLN3vCdafGFwQ8qs24XYiQcZSIAMJsABxOWKDYHGTauXIfXOdnv5DtrY68pd9WvKdgKIFfYhkLijCsQwBWyOMt3qc6Zb0fTjJl/mySz0SwmOsl2o6h4Ul/xqpOwV1ICEP9YNmNdE8/g/on8goyF+VOw7shKxx/wjpQOAGxwaO9+n1otYoAnp8uZH9/SA2oWPMhpw6g4EHF2bONz4/ZLFydYu/lNkJYqcs6NDwOhiHicEcA7OGZF4hb86G/qo2qFiVbjgyA11Npu+984ljkEBuJ5QSBwXBQuGDJQ8BEzYAcjYP7DJSGF+ASv+xpRzvITSRurxC0ZgewvqKSZBGSl+BMSyBVXGxeXrw7Ivg0OWHclvU2onO55fRs5kXYLYKBD0h7uA3QBVFQw4Tz8VidrQM0jsi+e9NLgEIXweCf6zyGeRIkdYbpGBsQ7l9DMXkjWJhDhHLe77WQEYTJt7hjr+IzLrJLr3ZF9MGvmYBcFfcanPjFfW8/VFuqRm4X4HffJ3xpW0XSb+JEqE86fuxQaZbXKlASRKHubUOCyicUQGJekLc/+DCVXuKB/8B5X4lF4jpRJLLSPPmZelvIcJEPuIO1mM8YxCKHlLn9btDYgStMXroaStxRC/t8sdHoAgOocF+io365LQGfcyqjssORNwfl2uiXunJ3UMt1VcyDlpg1QL5FbgMrFk344j/Co8f5o0EzIpwpRPMETLxp/sxQUGbCbmNtbqTC22+Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33964004)(26005)(53546011)(6506007)(5660300002)(186003)(8936002)(2906002)(235185007)(6666004)(83380400001)(6512007)(21490400003)(15650500001)(38100700002)(31686004)(86362001)(8676002)(66476007)(66946007)(4326008)(66556008)(508600001)(54906003)(110136005)(6486002)(316002)(31696002)(2616005)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXRlNXFWeEhBaWt2RCtvcXc4VHdGY2tweUR6emtaRFlQRk1oemVqV2t0OVhn?=
 =?utf-8?B?MXE2MHZIMjVLQ056S2FkZTFualNsbWUxVWRWOWlnN1VQVUdNRVZTSkFUWGls?=
 =?utf-8?B?YjZKcmROVDY2QzRGV3ZoOVlPTjhwNEU4eEhZNGh0eTQ1bjQ2Y3h5Wm9QMkVG?=
 =?utf-8?B?dTF1d1h3SXplamRRNkoxTzZYWG1pd3lwbGtOeHhnaGZ5N1ExTzdIRDN6V1F6?=
 =?utf-8?B?MGtQNW5kSTVrRmhOOXk5NmJVWXJVNUYwODhyejI0OFBTR3FKL05kRU9vUTh4?=
 =?utf-8?B?WFJ5eHBJbjI1NWgwdXU5ZzZaQkxSWkpDalE5YWU4a1Qyb2N1VEQ4bkpvSWxp?=
 =?utf-8?B?bVdIcjlXb3g1ZlNTY3VDS0I5QkVSaDJIMlNvQ1lXTmRYb3ZIVUN2RGN1OS9E?=
 =?utf-8?B?OWs1T09OdThrYm9aanNmRG5IbTE5UHBlMk5wN0pWWmZodkJzM3ZIeW5KQWh3?=
 =?utf-8?B?cEZYZjlka0s0VkxhempFRjg0Tk9KQ2trYlRIT09sRm9HSkdVZG40VmRVMmts?=
 =?utf-8?B?R1VQWFNtbXdxWFF0R0laK3dQTmJCWjByM0ZZWkdndmc3cmFSL2hmWlg2V2pL?=
 =?utf-8?B?VHZaVDJPOU5DM1ZFRnBjZ25MUjZVSWJHaDl1Zk9RZm14OGxaV3I2V0hqWDJv?=
 =?utf-8?B?S0JmeEl5Nk1vQzMzcERPem5qNUlZREkwZ2Q4dHVOS3JlejYvQVdYOWpVRzNB?=
 =?utf-8?B?NzE0UCt3VmVXL2ZrNmppdDVBQzFRK3o4YUdESDZwQWgrdkpCQms2bExWRFY0?=
 =?utf-8?B?TEdXaHFYUWlmemVxYzZJT1JNVk5hUURZbDA3ZkI3UWNOUDRMQmpESjMxZzFk?=
 =?utf-8?B?eWxET2dvTnlxdzltNG5lRVhqQWtmVXVoM3JhNWJCekQ0TkMwZUI2Q3pVR2Vx?=
 =?utf-8?B?VU5RTVAzZDNvWmFXa0pTNHpwWXovcEhRZnJORGplMjU0Z21nalhlZDh1M0pN?=
 =?utf-8?B?VzFPeHlKQkdWdjEvQlludjBwbXNPa2VnUTkxV0ROWk1ZYWQxZzhjVVpRZTND?=
 =?utf-8?B?VWc3ZUVTUUFKbWE3ejFYaFljdGFZSmQ0N3huYTdYUGpwb3JYOVU2eXZIbzJj?=
 =?utf-8?B?alRIOWpnTWFmYlBPckhZMTNDVWQ1dkIwYzN3Y1IwdEY4MnlTd09nTU1ZdEo3?=
 =?utf-8?B?Ly9xdmpENWorTFZhV1k4MjZaWGt0SzZiQ0FSNWM1ZEVvUStPc2c0dmpDK3NO?=
 =?utf-8?B?TXdJdm1oYVhXaVgzenc3WjBrdlhDRitudlc5UVJacjZVNmF5NFgwY3pTbWIv?=
 =?utf-8?B?K2U5czBtM01jRGZ1RVVINzJVcHJKWGJYQW5iNlF3Rm1tR1kycTVJRXdxcG1x?=
 =?utf-8?B?N1dIWktKcGlSSnkwcW1iRXB0bmhJV1ZvNHFRWGg4ZDNjajBuVUFMNUFoZ3Vr?=
 =?utf-8?B?Z1BKbUkrMUVZM2Q0YWpLSHczcmpXTXBtRXZOU3EwZUF0UE5yeDdwd1VibzM5?=
 =?utf-8?B?K2J6YzI1V3NXWjBRU1pXZG9OZ09MTExzenZRZ0syQWpmUmRqREluMnk1SUNI?=
 =?utf-8?B?LzY1QisraGI3eTR5a0FXbGMyMVVXYmhyRjZneXlxNTVaUmUwSzBVMlRrOGE3?=
 =?utf-8?B?d2JEOWZxNEh6cUdrMlFHYXpGMXZQaHFYMXZ5b1VRdFVzOFdObGxrMnNsS1R1?=
 =?utf-8?B?MWNaeHB4WFF5ZysxRDlrY01jVUsyQVNxWmIzMGFNaDZIdERKMVExNTIxd2Ru?=
 =?utf-8?B?UldUYWdrOVJvNVY1eWFZRGpYbzdWUEtVWFhybCt4R0FzdjVPOHdjaWx4L2lY?=
 =?utf-8?B?VFIzb25yYUJUTEpGSjhjVUpNYkxKYitwdmZtOTdLZ3NGOFFpVDZjZCswQzhN?=
 =?utf-8?B?R2Ntc2N0NXRuUXpGY1NRRmNpWkZiSzVaZEphOTZUWHhxbmpmNlU4VTlRVE1P?=
 =?utf-8?B?d1J4dVlyelhYbmlVU0VOWGRNeTVIdVRtTERoRXZZWEZvWW11UzZPQ2JOOVF4?=
 =?utf-8?B?b3J3eW41ajlJcURTWlluaWFBdUEwVUJqM3U1YXduZmMrcGVabXdtdmlVSWEz?=
 =?utf-8?B?OTUreERqd3dzUWxyelJOWjB4RnF2dUcwSTQyOGplVnRlWFR0aTg2TG1HVDk2?=
 =?utf-8?B?dzR0dk1qYm1PVDZpL2xHSldUUVA0UlJXVXExN3ZXOXV0c053OVorMklZcHhi?=
 =?utf-8?Q?vq48=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae61e33-6261-4dba-f42a-08d9f29fa6eb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 05:29:36.9151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMxjCHIMUG6yCTEla9JNMSdRSF5WXerNTOCErel9J79j6HvKowTNHwYUFskKYqav
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1228
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------h8VtTfqlHK9tf1380ICIOSpw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/18/2022 9:57 AM, Liang, Prike wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, February 18, 2022 12:05 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
>> <Evan.Quan@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: validate SMU feature enable message for
>> getting feature enabled mask
>>
>>
>>
>> On 2/18/2022 9:25 AM, Prike Liang wrote:
>>> There's always miss the SMU feature enabled checked in the NPI phase,
>>> so let validate the SMU feature enable message directly rather than
>>> add more and more MP1 version check.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 28 ++++++-------------------
>> -
>>>    1 file changed, 6 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> index f24111d28290..da1ac70ed455 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> @@ -552,10 +552,9 @@ bool smu_cmn_clk_dpm_is_enabled(struct
>> smu_context *smu,
>>>    int smu_cmn_get_enabled_mask(struct smu_context *smu,
>>>                           uint64_t *feature_mask)
>>>    {
>>> -   struct amdgpu_device *adev = smu->adev;
>>>      uint32_t *feature_mask_high;
>>>      uint32_t *feature_mask_low;
>>> -   int ret = 0;
>>> +   int ret = 0, index = 0;
>>>
>>>      if (!feature_mask)
>>>              return -EINVAL;
>>> @@ -563,12 +562,10 @@ int smu_cmn_get_enabled_mask(struct
>> smu_context *smu,
>>>      feature_mask_low = &((uint32_t *)feature_mask)[0];
>>>      feature_mask_high = &((uint32_t *)feature_mask)[1];
>>>
>>> -   switch (adev->ip_versions[MP1_HWIP][0]) {
>>> -   /* For Vangogh and Yellow Carp */
>>> -   case IP_VERSION(11, 5, 0):
>>> -   case IP_VERSION(13, 0, 1):
>>> -   case IP_VERSION(13, 0, 3):
>>> -   case IP_VERSION(13, 0, 8):
>>> +   index = smu_cmn_to_asic_specific_index(smu,
>>> +                                           CMN2ASIC_MAPPING_MSG,
>>> +
>>        SMU_MSG_GetEnabledSmuFeatures);
>>> +   if (index > 0) {
>>>              ret = smu_cmn_send_smc_msg_with_param(smu,
>>>
>> SMU_MSG_GetEnabledSmuFeatures,
>>>                                                    0,
>>> @@ -580,19 +577,7 @@ int smu_cmn_get_enabled_mask(struct
>> smu_context *smu,
>>>
>> SMU_MSG_GetEnabledSmuFeatures,
>>>                                                    1,
>>>                                                    feature_mask_high);
>>> -           break;
>>> -   /*
>>> -    * For Cyan Skillfish and Renoir, there is no interface provided by
>> PMFW
>>> -    * to retrieve the enabled features. So, we assume all features are
>> enabled.
>>> -    * TODO: add other APU ASICs which suffer from the same issue here
>>> -    */
>>> -   case IP_VERSION(11, 0, 8):
>>> -   case IP_VERSION(12, 0, 0):
>>> -   case IP_VERSION(12, 0, 1):
>>> -           memset(feature_mask, 0xff, sizeof(*feature_mask));
>>> -           break;
>>
>> This is broken now as these ASICs don't support any message. It is best to
>> take out smu_cmn_get_enabled_mask altogether and move to smu_v*.c or
>> *_ppt.c as this is a callback function.
>>
>> Thanks,
>> Lijo
>>
> Before this solution I also consider put the  smu_cmn_get_enabled_mask implementation in each *_ppt directly, but seems need some effort for implementing on each *_ppt. How about we also check the SMU_MSG_GetEnabledSmuFeaturesHigh mapping index? As to the ASCI not support neither  SMU_MSG_GetEnabledSmuFeatures nor  SMU_MSG_GetEnabledSmuFeaturesHigh will hard code the feature mask in this case.
> 

Something like attached refactoring and then for the rest you could 
apply your patch.

Thanks,
Lijo

>>> -   /* other dGPU ASICs */
>>> -   default:
>>> +   } else {
>>>              ret = smu_cmn_send_smc_msg(smu,
>>>
>> SMU_MSG_GetEnabledSmuFeaturesHigh,
>>>                                         feature_mask_high);
>>> @@ -602,7 +587,6 @@ int smu_cmn_get_enabled_mask(struct
>> smu_context *smu,
>>>              ret = smu_cmn_send_smc_msg(smu,
>>>
>> SMU_MSG_GetEnabledSmuFeaturesLow,
>>>                                         feature_mask_low);
>>> -           break;
>>>      }
>>>
>>>      return ret;
>>>
--------------h8VtTfqlHK9tf1380ICIOSpw
Content-Type: text/plain; charset=UTF-8; name="smu_feature.diff"
Content-Disposition: attachment; filename="smu_feature.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvY3lhbl9za2ls
bGZpc2hfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL2N5YW5fc2tp
bGxmaXNoX3BwdC5jCmluZGV4IGIzYTBmM2ZiM2U2NS4uZjFhNGE3MjBkNDI2IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL2N5YW5fc2tpbGxmaXNoX3BwdC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvY3lhbl9za2lsbGZpc2hf
cHB0LmMKQEAgLTU1Miw2ICs1NTIsMTYgQEAgc3RhdGljIGludCBjeWFuX3NraWxsZmlzaF9nZXRf
ZHBtX3VsdGltYXRlX2ZyZXEoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCiAJcmV0dXJuIDA7CiB9
CiAKK3N0YXRpYyBpbnQgY3lhbl9za2lsbGZpc2hfZ2V0X2VuYWJsZWRfbWFzayhzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSwKKwkJCQkJICAgdWludDY0X3QgKmZlYXR1cmVfbWFzaykKK3sKKwlpZiAo
IWZlYXR1cmVfbWFzaykKKwkJcmV0dXJuIC1FSU5WQUw7CisJbWVtc2V0KGZlYXR1cmVfbWFzaywg
MHhmZiwgc2l6ZW9mKCpmZWF0dXJlX21hc2spKTsKKworCXJldHVybiAwOworfQorCiBzdGF0aWMg
Y29uc3Qgc3RydWN0IHBwdGFibGVfZnVuY3MgY3lhbl9za2lsbGZpc2hfcHB0X2Z1bmNzID0gewog
CiAJLmNoZWNrX2Z3X3N0YXR1cyA9IHNtdV92MTFfMF9jaGVja19md19zdGF0dXMsCkBAIC01NjIs
NyArNTcyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwcHRhYmxlX2Z1bmNzIGN5YW5fc2tpbGxm
aXNoX3BwdF9mdW5jcyA9IHsKIAkuZmluaV9zbWNfdGFibGVzID0gc211X3YxMV8wX2Zpbmlfc21j
X3RhYmxlcywKIAkucmVhZF9zZW5zb3IgPSBjeWFuX3NraWxsZmlzaF9yZWFkX3NlbnNvciwKIAku
cHJpbnRfY2xrX2xldmVscyA9IGN5YW5fc2tpbGxmaXNoX3ByaW50X2Nsa19sZXZlbHMsCi0JLmdl
dF9lbmFibGVkX21hc2sgPSBzbXVfY21uX2dldF9lbmFibGVkX21hc2ssCisJLmdldF9lbmFibGVk
X21hc2sgPSBjeWFuX3NraWxsZmlzaF9nZXRfZW5hYmxlZF9tYXNrLAogCS5pc19kcG1fcnVubmlu
ZyA9IGN5YW5fc2tpbGxmaXNoX2lzX2RwbV9ydW5uaW5nLAogCS5nZXRfZ3B1X21ldHJpY3MgPSBj
eWFuX3NraWxsZmlzaF9nZXRfZ3B1X21ldHJpY3MsCiAJLm9kX2VkaXRfZHBtX3RhYmxlID0gY3lh
bl9za2lsbGZpc2hfb2RfZWRpdF9kcG1fdGFibGUsCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdTEyL3Jlbm9pcl9wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vc3dzbXUvc211MTIvcmVub2lyX3BwdC5jCmluZGV4IGU5OWU3YjJiZjI1Yi4uZmQ2YzQ0ZWNl
MTY4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEyL3Jlbm9p
cl9wcHQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEyL3Jlbm9pcl9w
cHQuYwpAQCAtMTM2Niw2ICsxMzY2LDE2IEBAIHN0YXRpYyBpbnQgcmVub2lyX2dmeF9zdGF0ZV9j
aGFuZ2Vfc2V0KHN0cnVjdCBzbXVfY29udGV4dCAqc211LCB1aW50MzJfdCBzdGF0ZSkKIAlyZXR1
cm4gMDsKIH0KIAorc3RhdGljIGludCByZW5vaXJfZ2V0X2VuYWJsZWRfbWFzayhzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSwKKwkJCQkgICB1aW50NjRfdCAqZmVhdHVyZV9tYXNrKQoreworCWlmICgh
ZmVhdHVyZV9tYXNrKQorCQlyZXR1cm4gLUVJTlZBTDsKKwltZW1zZXQoZmVhdHVyZV9tYXNrLCAw
eGZmLCBzaXplb2YoKmZlYXR1cmVfbWFzaykpOworCisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgcHB0YWJsZV9mdW5jcyByZW5vaXJfcHB0X2Z1bmNzID0gewogCS5zZXRfcG93
ZXJfc3RhdGUgPSBOVUxMLAogCS5wcmludF9jbGtfbGV2ZWxzID0gcmVub2lyX3ByaW50X2Nsa19s
ZXZlbHMsCkBAIC0xMzkwLDcgKzE0MDAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBwdGFibGVf
ZnVuY3MgcmVub2lyX3BwdF9mdW5jcyA9IHsKIAkuaW5pdF9zbWNfdGFibGVzID0gcmVub2lyX2lu
aXRfc21jX3RhYmxlcywKIAkuZmluaV9zbWNfdGFibGVzID0gc211X3YxMl8wX2Zpbmlfc21jX3Rh
YmxlcywKIAkuc2V0X2RlZmF1bHRfZHBtX3RhYmxlID0gc211X3YxMl8wX3NldF9kZWZhdWx0X2Rw
bV90YWJsZXMsCi0JLmdldF9lbmFibGVkX21hc2sgPSBzbXVfY21uX2dldF9lbmFibGVkX21hc2ss
CisJLmdldF9lbmFibGVkX21hc2sgPSByZW5vaXJfZ2V0X2VuYWJsZWRfbWFzaywKIAkuZmVhdHVy
ZV9pc19lbmFibGVkID0gc211X2Ntbl9mZWF0dXJlX2lzX2VuYWJsZWQsCiAJLmRpc2FibGVfYWxs
X2ZlYXR1cmVzX3dpdGhfZXhjZXB0aW9uID0gc211X2Ntbl9kaXNhYmxlX2FsbF9mZWF0dXJlc193
aXRoX2V4Y2VwdGlvbiwKIAkuZ2V0X2RwbV91bHRpbWF0ZV9mcmVxID0gcmVub2lyX2dldF9kcG1f
dWx0aW1hdGVfZnJlcSwKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211X2Ntbi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMKaW5kZXgg
NGMxMmFiY2Q5OTVkLi5hYTBjYTU3OWFkNmQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vc3dzbXUvc211X2Ntbi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211X2Ntbi5jCkBAIC01OSw2ICs1OSwxMiBAQCBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IF9f
c211X21lc3NhZ2VfbmFtZXNbXSA9IHsKIAlTTVVfTUVTU0FHRV9UWVBFUwogfTsKIAorI2RlZmlu
ZSBzbXVfY21uX2NhbGxfYXNpY19mdW5jKGludGYsIHNtdSwgYXJncy4uLikgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKKwkoKHNtdSktPnBwdF9mdW5jcyA/ICgoc211KS0+cHB0X2Z1bmNz
LT5pbnRmID8gICAgICAgICAgICAgICAgICAgICAgICAgIFwKKwkJCQkgICAgIChzbXUpLT5wcHRf
ZnVuY3MtPmludGYoc211LCAjI2FyZ3MpIDogICAgIFwKKwkJCQkgICAgIC1FTk9UU1VQUCkgOiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKwkJCSAgICAtRUlOVkFMKQorCiBzdGF0aWMg
Y29uc3QgY2hhciAqc211X2dldF9tZXNzYWdlX25hbWUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUs
CiAJCQkJCWVudW0gc211X21lc3NhZ2VfdHlwZSB0eXBlKQogewpAQCAtNDkzLDYgKzQ5OSwxMiBA
QCBpbnQgc211X2Ntbl9mZWF0dXJlX2lzX3N1cHBvcnRlZChzdHJ1Y3Qgc211X2NvbnRleHQgKnNt
dSwKIAlyZXR1cm4gdGVzdF9iaXQoZmVhdHVyZV9pZCwgZmVhdHVyZS0+c3VwcG9ydGVkKTsKIH0K
IAoraW50IF9fc211X2dldF9lbmFibGVkX2ZlYXR1cmVzKHN0cnVjdCBzbXVfY29udGV4dCAqc211
LAorCQkJICAgICAgIHVpbnQ2NF90ICplbmFibGVkX2ZlYXR1cmVzKQoreworCXJldHVybiBzbXVf
Y21uX2NhbGxfYXNpY19mdW5jKGdldF9lbmFibGVkX21hc2ssIHNtdSwgZW5hYmxlZF9mZWF0dXJl
cyk7Cit9CisKIGludCBzbXVfY21uX2ZlYXR1cmVfaXNfZW5hYmxlZChzdHJ1Y3Qgc211X2NvbnRl
eHQgKnNtdSwKIAkJCSAgICAgICBlbnVtIHNtdV9mZWF0dXJlX21hc2sgbWFzaykKIHsKQEAgLTUw
MCw3ICs1MTIsNyBAQCBpbnQgc211X2Ntbl9mZWF0dXJlX2lzX2VuYWJsZWQoc3RydWN0IHNtdV9j
b250ZXh0ICpzbXUsCiAJdWludDY0X3QgZW5hYmxlZF9mZWF0dXJlczsKIAlpbnQgZmVhdHVyZV9p
ZDsKIAotCWlmIChzbXVfY21uX2dldF9lbmFibGVkX21hc2soc211LCAmZW5hYmxlZF9mZWF0dXJl
cykpIHsKKwlpZiAoX19zbXVfZ2V0X2VuYWJsZWRfZmVhdHVyZXMoc211LCAmZW5hYmxlZF9mZWF0
dXJlcykpIHsKIAkJZGV2X2VycihhZGV2LT5kZXYsICJGYWlsZWQgdG8gcmV0cmlldmUgZW5hYmxl
ZCBwcGZlYXR1cmVzIVxuIik7CiAJCXJldHVybiAwOwogCX0KQEAgLTY5NSw4ICs3MDcsNyBAQCBz
aXplX3Qgc211X2Ntbl9nZXRfcHBfZmVhdHVyZV9tYXNrKHN0cnVjdCBzbXVfY29udGV4dCAqc211
LAogCWludCByZXQgPSAwLCBpOwogCWludCBmZWF0dXJlX2lkOwogCi0JcmV0ID0gc211X2Ntbl9n
ZXRfZW5hYmxlZF9tYXNrKHNtdSwKLQkJCQkgICAgICAgJmZlYXR1cmVfbWFzayk7CisJcmV0ID0g
X19zbXVfZ2V0X2VuYWJsZWRfZmVhdHVyZXMoc211LCAmZmVhdHVyZV9tYXNrKTsKIAlpZiAocmV0
KQogCQlyZXR1cm4gMDsKIApAQCAtNzQ4LDggKzc1OSw3IEBAIGludCBzbXVfY21uX3NldF9wcF9m
ZWF0dXJlX21hc2soc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCiAJdWludDY0X3QgZmVhdHVyZV8y
X2VuYWJsZWQgPSAwOwogCXVpbnQ2NF90IGZlYXR1cmVfMl9kaXNhYmxlZCA9IDA7CiAKLQlyZXQg
PSBzbXVfY21uX2dldF9lbmFibGVkX21hc2soc211LAotCQkJCSAgICAgICAmZmVhdHVyZV9tYXNr
KTsKKwlyZXQgPSBfX3NtdV9nZXRfZW5hYmxlZF9mZWF0dXJlcyhzbXUsICZmZWF0dXJlX21hc2sp
OwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAK

--------------h8VtTfqlHK9tf1380ICIOSpw--
