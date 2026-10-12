Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C27CA9ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 09:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3EAA10E3DD;
	Mon, 12 Oct 2026 09:51:40 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010004.outbound.protection.outlook.com
 [52.101.193.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8310F10E6B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 09:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQ9i6st2ImWbLl1zmpq1U2masPHpATxBvZH9iWlN0eXKSefeotlLxTczMHV9ij0A1YX4LjPfVON+fr5KHJrxq1xcKFFuqS+Kq05l1ZD+/b0YcvywwiVvpw0AaYqnKypo3v6jZB3bBIn2ya1axQJnQIlUHqq3t+cZ0kWKRCpXjFAl8q4hFtItqL5DmVBAq3U8s9xPkkmoibhNxsuoDcwcqFsJavA+32LwVuBvTI0QTJdVh95F9BYLm+pI+tfo2KZ+rxV97J7A7BkE9DiZQInTfhItIXvjbzAgu936HnC6Enrn/xXsR00FpFUnsOY2smoP8uH+RY79gc5gT3N8yXbn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlebfYvqLbLeBp1F+Q1W15zUtBID+CbGSDwIHB1bopo=;
 b=Yew3NlX3gC6JDzCsJxpdMAks7ZCTj9E0bYmiK81RPbPHS+uHMkSFkPNDoDpmoEhRc3CLKdg4znviZCqkv7+Y0U9Jne4ZlYtbycwbAnr+GyptcjRCw2InkaWR+W+snFieTPmM+RtbDY0p8AdnWXkZ+LsIES5sPWoEoLhgtAzePV8Tm3zF9tfNKR7z0Czgcm7qUr17bS+eQfT+VAZ/zfrcGuFSQNqL6t2euo3jz89txhoyUjNuUXnsGcNT3HYtf8ro6iFOqL50EVu9/+70o+nar5a8NJLd09G2FIVJi7oVmhpXPVKGiDE0jvpHPm08jmU96N5tYJbySKuYXdS8Xrtv2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlebfYvqLbLeBp1F+Q1W15zUtBID+CbGSDwIHB1bopo=;
 b=yLPXJTBqhYf4yP80LT6t39pgUzRACVu063LSmTC/j46gXjKhJL25zH+QUjVEt0F83hZqaWw5A9ps4WPFYWBK6tOOccVZrRDw1wLnxIQIlCU5kU/RGxjVeS6wUnhyk68203aen7bOGgHZg9Bzx3P5/wD8g2Lp3aom9eqoG+8Czbg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.20; Mon, 12 Oct 2026 09:51:32 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0472.015; Mon, 12 Oct 2026
 09:51:31 +0000
Message-ID: <95765dc6-7dad-4a14-a567-bec49156f6c8@amd.com>
Date: Mon, 12 Oct 2026 15:21:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: mark the current DPM clock level active
To: "Wang, Kevin" <Kevin.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>
References: <20261012012748.3150968-1-kevin.wang@amd.com>
 <142bb98f-2b90-44ac-9e69-8700b4130e5c@amd.com>
 <PHXPR12MB9992550B67868CF6578256894A939F2@PHXPR12MB999255.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PHXPR12MB9992550B67868CF6578256894A939F2@PHXPR12MB999255.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 5125ee0f-058d-438b-ac43-08df284664df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Lw/5vrmgHLkIJYuE8dGXEGVVbtBVdBu3E1zZAnIaKm10Msp/iNKnqB0LBvAa9ZGtRdppqxlKM/UhS0ECFQ+6rsYqb+WvmVXOzz3QlYOxd3uf5+5CsjQqBrY6Egr9W8O7LW3Y1odqKrZm7newMY9AEZO+2+uvS2IXthb7uYYzASjCUwFmaYdygqHmspkwQjKAbSbhaPLt1osGiD9hZ5beCaTXCLWFuuEADdWWnZNyA+ol8I/bB5yQfdsrdurHXCxaAGHLpFH+IK1oCnublYPLoS0yG2BF1bc+OuTlz4RtrG15fsrI8bpQrRmoZ0Y1LCALzj9i6yDfZ96cfjh5Ilq63f8+Oc8km6epVCxPQ8RY+RIozweOLEMRZfILOP7nevWNEfjTH20PpYfSEMKgln+2la1IZLVbuGbcuDLzB/SC/AUNlVc4ABxW0rKNrfgcPvBwLUUXbsgN7eb1sXLWVtby8tLhEVdYIbD8clsEW0tLuOtkzXl1iJbUTN+L1z7NU6rOVFHt/z+YlQeoxNc/dsOjyQLpoNlTVjzTN3xigUXiuFXlE/EsIEzoRZDtlGZ+LaUa5yk/m1/5ndmIXAf7WZ9H/6DJ4TiGiZzFg+rSTdKGbU6gl1kejKBHBawSthND3mWwGcWkq1QhoZ22UuUseDVOGZgb2vreNHgbfdTQ8W+Wjh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1k2bFN4OWlJU3V6eEZaQWtNb2R2RVdTaHZHWncyWkEvYndwWWtnR1ZYUVlZ?=
 =?utf-8?B?RytBLzdSS0JmZklSVy9Zb3FKd2h1M3pmRThma2poZHhWKzVweHNyc0gxVDQw?=
 =?utf-8?B?MzF3b0p6cHd5ZUhXWWxPK24yME1FRmplcXFlMEd4a2k1dm16eHp4NGFCVitU?=
 =?utf-8?B?UXpZRlNnWFh3bm9uTUlTb0VJUWlEY2pZMGp3V0ppSVB4Y2E0MWFnM1hDL1N1?=
 =?utf-8?B?QTZHNWV0V0EyU0hNeC9QQSttTGMwLzM1LzArM254RVlQbURIQ3FiN3JTZnJQ?=
 =?utf-8?B?ZXpkbDRRc2JQb0gzemdHOU1WZ3c3QldmMmNWd0t0VkpENVRCZzYxMUVrVGdM?=
 =?utf-8?B?NlRzMmNHRTdzRXYyMDF2Wm5UZCsrSFZ5cTU5Q1JzNHVZZkFNS3VubnVxWjUr?=
 =?utf-8?B?aU45OWt6YXozODBYMW5Zb0VXQUp5S0pmaTA3MmdkNy84KzNXS3BIQ3lvWTl6?=
 =?utf-8?B?SU8xM3B0Y0c1UnVMSDF4eWxEUzlXZHcvSTBjSjNXdTVOVkJGY3FkcUcvUlNM?=
 =?utf-8?B?VEhNdXo5SFFJYXQ0QUsvQzFZTnpRRFFUWUU5ZDEvd0Y1eGR3VWo0dzVFdlB1?=
 =?utf-8?B?Rzk1WXh3OUtMMTQwNUZkc3R5L2p2L2dMemRqajZRdE0xeGJmeTdsYkN1cEVK?=
 =?utf-8?B?endKRURlL0xZdlVnRi9mQW9sR1hwV0pzTEEvOE9WaFQvb2ppaUtBcVp5OE5T?=
 =?utf-8?B?Q2FsOFBWSzZmR09WeFY2YlljK1FHMHRoa2xFSHp3RVJvTGFTa1lZTXFXWlVr?=
 =?utf-8?B?TlQ3eTVhakpsV1A4ckJVM3ZQYU5ERGdKaUVhU09jUWd2M2t1NWovTEx4UFN2?=
 =?utf-8?B?dGZuNG5vNHl3L1U0M3dqV0hId1B1enFha0xvdmJXOTBFa1doUWgwR0xtcisr?=
 =?utf-8?B?cHpYU2Z2eWVrekZEUk9yaS9XMlZBUDBpQjZNRVRIM054dTFaOGhwdjNGdDIw?=
 =?utf-8?B?ZnV6NmFmVUh0RzNtaGZQMy9sMVBkZTd1VlBMK01XV2UvcUhMenk5UFU5b1RN?=
 =?utf-8?B?eDg3RzhPRCtocDZERUtMWEFuWDFWbDFSYm9Hc25pdk9pV3lRc2IzcHB4K2JD?=
 =?utf-8?B?UnFmeWp2S2VkWlJTTHlWQkk3SWtoSmRBelpkV2RDYzB1eEw1bjc5NWwxVlE4?=
 =?utf-8?B?Q00vdHNWTHZLSHlUd1FsQ3htemk0VFRraWVObDR2d1FQK01nRGVubzYydFlG?=
 =?utf-8?B?V3RYak9tQTFsS0hrMGJZZEZxZ2VhNDhDcU1XRkE5T1c3ZjNEK2FHWE9oTEYy?=
 =?utf-8?B?Ym42WVVjQ1IraDMzYUVuTTI2ZCtyVDBhTnVCMmpYQlRzWHZvTUJ3WWUzMStI?=
 =?utf-8?B?b1BUNWtyRUpRcXl5QVRPazhPREFHYkJCckRiTU9UTTIwdkFjanE1NzZSYldw?=
 =?utf-8?B?OEpaK3hrYm1OUnFDTkpMbGRoK2Jnc0k0Z0Z2YWRhcUxWZkhTWXlmamVVQnFL?=
 =?utf-8?B?YTFuUWM3NnJzc1o5ZitPZXBsNHlSeWNvcXYvWFRxWTMwclpaaHVubWM5Vk1C?=
 =?utf-8?B?bTM3R2p6eWg1ZXNiTkFSNmJidGxBa0I2TENhcHIzeEMrbDBjRjUvKzlvbEZq?=
 =?utf-8?B?SmVWYUJtYzcxd0xwdzJvNDUyTVBwUkEwS0xkSWpLTVpiT0VpeTBFNEEvREpZ?=
 =?utf-8?B?ZWpKM2hOUzM3NmYwc0tMRzJDTTZJUFhsWFBrRTBIVHZQR0Z6OXR5NmVlemM2?=
 =?utf-8?B?RVNPR3NXaHVFczdqbjZ1anFqa3Y4TXRvRzZqb2tEL05XUDhJQmE5N0syeDhO?=
 =?utf-8?B?NVFQeVhiYklhcEg4cytGc2pJcFFibXZpb3d6c3FiaWlQRU1hNXl6Zk1pRG13?=
 =?utf-8?B?ZmVmZXg3NzgvczVVY2xzU1U2ZklFWWk3TlNEUW1rK1VSL29uK2xPdHJCUUNJ?=
 =?utf-8?B?VVBqVzdlbEozdnRxczkrSVBjMjlhZGhqaHp0N1ZFdUpObWJ2QmlWZ2xwVXMr?=
 =?utf-8?B?TXlTU3RTL3BxTjd5UGp4NVN3UisrWllVTVlzYU5iK3dsdTAwV3JFREZEMTUy?=
 =?utf-8?B?dUl0cjV6REFiT2pXTXFNZ1dObWdFOC93ZDJYSEdOOEUwYjdUYlB2cE45eHEv?=
 =?utf-8?B?N1QrRjFOVUg4Ym5QQlJsS3VobU5XRHZFeFd4cnhEODdhZG52ZUxxd1NSMVJ0?=
 =?utf-8?B?T0ZDcGpHRWIzYlVvU0xNK3YzYlVWSXFKUXVmcDhKd2lCUHRrTHlvaWpMb2hC?=
 =?utf-8?B?bkZiVHNpMnpvMHh0WlhQOW9UQUEwVHFlN08xR1JrZUtIOGNDdmdaL0NobFNM?=
 =?utf-8?B?ZUZsd2VVTXpEcVF4UUxVY0dMbzdpd1pDenFIUWQ3b2FicStPbVh3OE1Pb1Vq?=
 =?utf-8?Q?stTitqfoHs+0WF7m7q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5125ee0f-058d-438b-ac43-08df284664df
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:51:31.8294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtHn/OJNgOdXowFF6snIk1Suzb16vy66lb6CNa1w88ya+aoe/PQ+GUAXm7i+YnaZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
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



On 12-Oct-26 12:45 PM, Wang, Kevin wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, October 12, 2026 12:12
>> To: Wang, Kevin <Kevin.Wang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: mark the current DPM clock level active
>>
>>
>>
>> On 12-Oct-26 6:57 AM, Kevin Wang wrote:
>>> PMFW can report clocks outside or between advertised DPM levels.
>>>
>>> Report a clock below DPM0 as a special active S level.
>>> Mark the nearest level active for a discrete DPM table.
>>> Clamp a clock above the table range to the maximum DPM level.
>>> Keep reporting the actual clock for a fine-grained DPM table.
>>>
>>> Signed-off-by: Kevin Wang <kevin.wang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 35 ++++++++++++++++++++------
>>>    1 file changed, 27 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> index 361657c19ea3..8cf616517ddd 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> @@ -1391,11 +1391,12 @@ int smu_cmn_print_dpm_clk_levels(struct
>> smu_context *smu,
>>>                               uint32_t cur_clk, char *buf, int *offset)
>>>    {
>>>      uint32_t min_clk, max_clk, level_index, count;
>>> +   uint32_t nearest_level = 0, nearest_diff = U32_MAX;
>>>      uint32_t freq_values[3];
>>> +   uint32_t clk_diff, level_clk;
>>>      int size, lvl, i;
>>>      bool is_fine_grained;
>>>      bool is_deep_sleep;
>>> -   bool freq_match;
>>>
>>>      if (!dpm_table || !buf)
>>>              return -EINVAL;
>>> @@ -1407,23 +1408,41 @@ int smu_cmn_print_dpm_clk_levels(struct
>> smu_context *smu,
>>>      min_clk = SMU_DPM_TABLE_MIN(dpm_table);
>>>      max_clk = SMU_DPM_TABLE_MAX(dpm_table);
>>>
>>> -   /* Deep sleep - current clock < min_clock/2, TBD: cur_clk = 0 as GFXOFF */
>>> -   is_deep_sleep = cur_clk < min_clk / 2;
>>> +   /* A clock below DPM0 is reported as a special deep-sleep level. */
>>> +   is_deep_sleep = cur_clk < min_clk;
>>>      if (is_deep_sleep) {
>>>              size += sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
>>>              level_index = 1;
>>>      }
>>>
>>> +   /*
>>> +    * Discrete tables mark the level nearest to the current clock.  Clamp
>>> +    * clocks above the advertised range to the last level.  Fine-grained
>>> +    * tables keep reporting the actual current clock between min and max.
>>> +    */
>>>      if (!is_fine_grained || count == 1) {
>>> +           if (!is_deep_sleep) {
>>> +                   if (cur_clk >= max_clk) {
>>> +                           nearest_level = count - 1;
>>> +                   } else {
>>> +                           for (i = 0; i < count; i++) {
>>> +                                   level_clk = dpm_table->dpm_levels[i].value;
>>> +                                   clk_diff = cur_clk > level_clk ?
>>> +                                              cur_clk - level_clk : level_clk -
>> cur_clk;
>>> +                                   if (clk_diff < nearest_diff) {
>>> +                                           nearest_diff = clk_diff;
>>> +                                           nearest_level = i;
>>> +                                   }
>>> +                           }
>>> +                   }
>>> +           }
>>> +
>>>              for (i = 0; i < count; i++) {
>>> -                   freq_match = !is_deep_sleep &&
>>> -                                smu_cmn_freqs_match(
>>> -                                        cur_clk,
>>> -                                        dpm_table->dpm_levels[i].value);
>>
>> By this change, if this function is no longer used, it can be removed as well.
> 
> this function is still used in fine-grained case.
> 

Thanks for the clarification. I think we should consider keeping this 
logic as a separate smu_cmn function to be used from other places also 
like - smu_v14_0_0_find_clk_level

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Best Regards,
> Kevin
>>
>> Thanks,
>> Lijo
>>
>>>                      size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
>>>                                            level_index + i,
>>>                                            dpm_table->dpm_levels[i].value,
>>> -                                         freq_match ? "*" : "");
>>> +                                         (!is_deep_sleep &&
>>> +                                          i == nearest_level) ? "*" : "");
>>>              }
>>>      } else {
>>>              count = 2;
> 

