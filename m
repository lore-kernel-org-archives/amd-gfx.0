Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB20FCD8CA8
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 11:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 520B410E0E9;
	Tue,  9 Jun 2026 11:12:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GYmNxRJ+";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D226A10E0E9
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 11:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XP82lWKM4puaSSB1zFxfMCSeEIfXn+9oAozz8EYEAU/1TjGUqHg3s+EZduY0gj7MKb4QcRyHtTmkwjCOJMC7CJd0JBWRrkiS2QaFU8isKnC28UlcctypoX2gghoTyIGPuNSlY2srNsgFYLkpzqvPf5qER17oXlOoEq+ivhQjpLnHq04orMEPhwN85cxwhVz3JYHeYKd16nKpgNrkMEgFz3sqi2+19qOw3yBAxmdiMXdbkqEmetewQ0gFMPSk5OdZuiJNqMpxciSIN6wN2iK/dfVBTQUuas1j7z336YJisGL9aba3s6IVu+SfInHxEaHbuSjzGX6rLHZCfR7Vm7gUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEgMrygNa5SCyge4WkU+tY2aT8+n2dUWBqqBNChwa64=;
 b=HwAtKvrYFoxhYapmC8dXg+JkI/nFZpIfSJpM0wr2IdJ7ultmRXfyh+02ChOsW7q6CSBVMBIvEk8u7+siLxmVLr/VnbFVi3VvhRc5qs9z3on4sJkUpXPNgWQGi3Gi3z1QnMl5tnZoeiSy+QOGbX5wq35FPMrNElAv04GSnGC64jfa+pEiiFqSuBgSJ/dxan785l+dMK2xJHW+V6Brd8v9f+Camuh2Ek1clZROtm/w9iiGUExPXbQ39RXoexk3vvn+cvXNXx35OL8iJ/gPqYXagYoZjp4tEujAV1y9voWWOY9wreUMgUi4Rv3pkW3euROsKK1jWNpJpt5kLHThzF+gxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEgMrygNa5SCyge4WkU+tY2aT8+n2dUWBqqBNChwa64=;
 b=GYmNxRJ+F/p4MeUitP4e9liAqi/Sz930qjas8zM3dV3TNTwMZ3HbmPBtyx0el9RSLgjZjDEcA9pGZZUw4Zo2A5H8ygfee/BKL7fKkDPFCzwWZC8u2f0ytokiQzO2yk1GCcc9G7AyzUlmlVuqi67D6V4G4GodFTrXYCws/0kbPCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 11:12:14 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 11:12:14 +0000
Message-ID: <e3c720a6-497d-43aa-bf7a-0835fc0d799a@amd.com>
Date: Tue, 9 Jun 2026 16:42:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: refactor DPM clock level reporting
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Liu, Shuzhou (Bill)" <Shuzhou.Liu@amd.com>, Maisam.Arif@amd.com
References: <20260609065123.215816-1-kevinyang.wang@amd.com>
 <6cb5a3be-8cf1-4ce5-8ce9-a6fb363b12fa@amd.com>
 <DM6PR12MB29726384D65C1D1B41A04415821D2@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB29726384D65C1D1B41A04415821D2@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW4PR12MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: ccffef23-661e-4797-94ca-08dec617f572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: oO2DVazCg+H3iDqv/YftFDziF1K4eVPQDjiv7ZMly/sCUqsdznv1wy4ITTINpaB4LaSpunKO1XBI7jnKuiWZMNKnV0vmD/sMcS8AAsVlZONTeGDdyVdNPA2O+JjkBauEKV0TUq4ZUgWbNUR2hBZ1HJm4lEobPTi3qS/IBlsHhGS1O9l2+I2vYwW4SnUG8PiFQCZjw/VLAULaknZLGu8Qr91l2cbWQaKeb8CBSDsi+r8aoKTxPS9SW+AOE9V4e0dA4txVD7/u2qqe+DhzRX9sJNgj0u8LWUmcJWCDpnjEMfer8RdrzIfldjEbJ8oui7iCHniKll9KFbpaD72VkANOgvsmWjMBtA1ddRa4yrlyCcpDz+M9koq+KA8uKo/cGz5Y1GiB37D0dSUlyO8WHbz4iKbMzVdiP/jlrAU7ZiVxeneo80G1TTFNqF4Chl5gdWm1/yB7szCvR+m2In3UNB41zFDmNipQk78KR0r7Ot4n5NpkToYmFKiQIsPTyFYW1wlFyV54IBzVaRM1r84NZa3KmwZT6sDgnynfHBsbi1CCtL4sg6SxXodBh/41bvwYAlylCoSyp5PBFSu7HvUOC4KEeyf4d8hLiJhbLjBVeYHNxzzlAgo+U7KOVf5p9kYlZFrHarp0tWCSDCqCcLTDKmQ3DAELZLOX5SjOrcSU5hh0ISghJXk6WXdXXOvW1/1ujJsL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0w3RFdlOExHdlNibnErQ0xON1BiamZPbE94MjhkUmxlWFhIZFNha00xa0kr?=
 =?utf-8?B?eFhuSGowcndjUjZVeTZRR3BpS0QvSW9adTMxaG1ITklWRHJqc1J0WTZDY0tL?=
 =?utf-8?B?WEFkRXFYcmY3WVRyZW1HQ0FLMVo4L3ZRTDdsQnhmaWtEOExncXR4dG92KzZX?=
 =?utf-8?B?NllDSTVvLzllTUllaUVxZllxNDRUODZTSUxnNVFMMVUxT0w0K1QwZldFdjJl?=
 =?utf-8?B?bGFKbFhBMXM4UDcxY0VTZDk1Uk1Lc25QTW05Sm5iOTB4VDVubHdQbkdWZUtF?=
 =?utf-8?B?MWtKL1B2RU1JWU9tM2Y4VFpybEF1L1NkWk8wZGk4VVA2ZWp6c3JCTk1aRkFZ?=
 =?utf-8?B?aGVVaUg2YVNXNkgyWjZ3ay91M1hvbllETDZqZGxKRzRwRmhDc1NZRjlGNnM3?=
 =?utf-8?B?c2M3N3IvWGlyMkltYWg4TzZjT3JESEk4UWxYQnVoeTlQNE1yVGN5VjhnNk5C?=
 =?utf-8?B?VUlZNHhNcGJSYWRGZDhFSmpxY3V2bStQODEwRVZWU3IyQ3ZETUtsRjVPOGdp?=
 =?utf-8?B?WXp0QzRqZVMxWitDRzBIdjJLeHNmNFR0L1hkamtPSFV5bkg3QitSbFNCZUk1?=
 =?utf-8?B?NVpGUFBYc0U3bC9IYXdDYVJyTFQwNEdWdXl6VGFod3VDZi9EOGMxY2V0dWNK?=
 =?utf-8?B?eWFYT3EwZGVGbkMycEtIV3VJMFRWZWFvb3Z6TFZvV1FBZ2g1U0x4YUlPZGZK?=
 =?utf-8?B?VWtyYkJVV3dpWFliNUVqV2x1VXVoRzFURTRpdDVWd2tuK1FpLzBnUEV0K0sw?=
 =?utf-8?B?UFJoTzdoallXdHZWQk56K2ZJcmxwRXlKR3RpVFdZUHB0eVk5RjFZSHl6Q1BM?=
 =?utf-8?B?eXgxK2xMcTFMSjJGeGZ6YXl2RlQrbGJzUVlpd3ExczFwWTR2QVpjYVk2dzk1?=
 =?utf-8?B?YlBsQ0d0clp6MDdSRVhYdzcxSE5jY25USDFJY0ZrQ09iVWxDdXBjeStsbnMz?=
 =?utf-8?B?Q0JtTEZ1NithdjNDNGlDYXBCNWlsb0JvQzVIbnBWcTRmbDJmaWJzOVNFNFFu?=
 =?utf-8?B?azN6eHdXdktUZk1DaEJSeUhjZ0VyalljY1Z3eDY1d2U4SSsyOHVhSVIxd2ZG?=
 =?utf-8?B?OWMxNmt4TEltV0VMSm9DbEhsTkZ5ZGVoeVNmZWVlZkRveEFML2s2TGYxSVVM?=
 =?utf-8?B?MFBFVTk4cDNNSy9EMzdMS2UxUnhDTS9LTmhsNTBXeWxJaU9GaE85TjdjTGh1?=
 =?utf-8?B?OFlsVjhJeVliVnJOenNSa0VFWDFxSE81cVBubVRvZGJOQjZpbVU2anVHUG5Y?=
 =?utf-8?B?UHlNOElOTmNEWG9pZGZXZjVuQ2V1bVErZm5zU083dkFFMlVFcS91czFUZmVl?=
 =?utf-8?B?enpGbDhDcmVjN3FFM2EwQTRzTzFJM25mM2pWMTV6QWRpdC9HQXI4a0QzRXlj?=
 =?utf-8?B?cWVkTUxZb3lNdUhvOFp2a1Y5OTFlTmxzTld5NU1CVXk0MHNMdTQ3VG4zcHNs?=
 =?utf-8?B?Umd5KzNScGpVRGNDalIzWUxNR2JrWjVNMHA4OFBtdDlBWHpLbGZDdld1b0VJ?=
 =?utf-8?B?VnF1b0x1MTV5c2grQ0FjalBFc0VBSG9PbFRRUHA4UHZ3UEJjdFpRTnlXOWM1?=
 =?utf-8?B?eVFhQTVjZGFlc3F0MDdScVFhb2lLOXp0Z2QwQUNZcnhIckdDOWRHN280NHYz?=
 =?utf-8?B?ZzdEVFNJNUJVQXpyd3pqSDMzMnFXWkVLMW1sQ3lnOHpwSnhVWUxUYjlueFhZ?=
 =?utf-8?B?VTE3SXVwZ0JlWGxVcVdXeDhHUkcxdW4vMHdUSGl6SkhBTS8yTzF4YUwrSXRU?=
 =?utf-8?B?anpyaUZkUGpDVVBEeThhWXJYL1ZKcC9wYXBVV0txTGo1RjA4ZmZUT0U2ay9L?=
 =?utf-8?B?L0l4Ylh4TjV0d2ltMitpZlYvZ0JiTXhXM2dzSFY1TWhsQ0VPVE05Rlp0OGpY?=
 =?utf-8?B?YktIN1hDMlh2U3RMdXNwZXNtVldQL1VkWDlIWGc4d3Jqdlo3Ymk2UEVXSFNZ?=
 =?utf-8?B?MExiM2cxWENYZTc5SHp3KzF3eUpsQUFNMkIweUg0d1kyQitkN2FMdmpJbnY0?=
 =?utf-8?B?anAvNGd1Ulp6ZmNMOXB0cUIzcU5WNlFER2NMOHM1emdJQWQ2bmtjdW9ESEZs?=
 =?utf-8?B?ckt3V2tCOURyNWZNSGJ5Um00dzgwUmNKOUt0R2Nvdkw5aUpTNVRLWDJ2Ry9l?=
 =?utf-8?B?TjJ4Mzg0Mm9HbzltYnUzM3lOYVoxWDNyRk9uT2ljSHplVCtJa1FtZWpZdlBh?=
 =?utf-8?B?WXdiNTBvV2NPQlpwcGlmWlZ5RVJESGtoM3JJbUZrK08remdlRWQ2SmM1SUJs?=
 =?utf-8?B?Q2M4clhDSWdiU2d3N3B5MkpBcXR4UGo3MXJqVkpJOGszcnlnME5YL1QyYlcx?=
 =?utf-8?B?Tm9VM0hpa3YxKzd6bHdtU0xRNmlUL0tGeEpRZjV6L0dpOU9TM2p2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccffef23-661e-4797-94ca-08dec617f572
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:12:14.2085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqLpS6SMr0wuJLv1+ZO32hNi/Da1YUEnupZqC9Vl+fDUVaLmKHaZDncNYNeN/CUb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849
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



On 09-Jun-26 3:49 PM, Wang, Yang(Kevin) wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, June 9, 2026 4:11 PM
>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: refactor DPM clock level reporting
>>
>>
>>
>> On 09-Jun-26 12:21 PM, Yang Wang wrote:
>>> Refactor smu_cmn_print_dpm_clk_levels() to build clock entries before
>>> emitting sysfs output.
>>>
>>> For discrete DPM tables, mark the level closest to the reported
>>> current clock. This avoids losing the active '*' marker when the
>>> SMU-reported clock does not fall within the previous fixed tolerance.
>>>
>>> Keep fine-grained output explicit by reporting the current clock on an
>>> 'F' line, and keep deep sleep represented by the 'S' line without
>>> marking a discrete level.
>>>
>>> Active marker placement:
>>>
>>> | Mode         | '*' marker location       | Reason                    |
>>> | ------------ | ------------------------- | ------------------------- |
>>> | discrete     | closest/current DPM level | entries are real levels   |
>>> | fine-grained | 'F:' current clock line   | min/max are range bounds  |
>>> | deep sleep   | 'S:' line                 | outside normal DPM range  |
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5295
>>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 148 +++++++++++++++++--
>> ------
>>>    1 file changed, 101 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> index d365f06ac1ac..872c0328f290 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> @@ -1376,77 +1376,131 @@ void smu_cmn_reset_custom_level(struct
>> smu_context *smu)
>>>      pstate_table->uclk_pstate.custom.max = 0;
>>>    }
>>>
>>> -static inline bool smu_cmn_freqs_match(uint32_t freq1, uint32_t
>>> freq2)
>>> +struct smu_clk_print_entry {
>>> +   uint32_t freq;
>>> +   bool selected;
>>> +};
>>> +
>>> +static inline uint32_t smu_cmn_freq_distance(uint32_t freq1, uint32_t
>>> +freq2) {
>>> +   return freq1 > freq2 ? freq1 - freq2 : freq2 - freq1; }
>>> +
>>> +static inline uint32_t smu_cmn_get_dpm_level_count(struct
>>> +smu_dpm_table *dpm_table) {
>>> +   return min_t(uint32_t, dpm_table->count,
>> SMU_MAX_DPM_LEVELS); }
>>> +
>>> +static uint32_t smu_cmn_get_closest_clk_level(struct smu_dpm_table
>>> +*dpm_table, uint32_t cur_clk) {
>>> +   uint32_t min_distance, distance;
>>> +   uint32_t closest_level = 0;
>>> +   uint32_t count;
>>> +   uint32_t i;
>>> +
>>> +   count = smu_cmn_get_dpm_level_count(dpm_table);
>>> +   if (!count)
>>> +           return SMU_MAX_DPM_LEVELS;
>>> +
>>> +   min_distance = smu_cmn_freq_distance(cur_clk, dpm_table-
>>> dpm_levels[0].value);
>>> +   for (i = 1; i < count; i++) {
>>> +           distance = smu_cmn_freq_distance(cur_clk, dpm_table-
>>> dpm_levels[i].value);
>>> +           if (distance < min_distance) {
>>> +                   min_distance = distance;
>>> +                   closest_level = i;
>>> +           }
>>> +   }
>>> +
>>> +   return closest_level;
>>> +}
>>> +
>>> +static inline int smu_cmn_emit_clk_line(char *buf, int size,
>>> +                                   int level_index, uint32_t freq, bool
>> selected) {
>>> +   return sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
>>> +                        level_index, freq, selected ? "*" : ""); }
>>> +
>>> +static void smu_cmn_build_fine_grained_levels(uint32_t min_clk, uint32_t
>> max_clk,
>>> +                                         struct smu_clk_print_entry
>> *entries,
>>> +                                         uint32_t *entry_count)
>>> +{
>>> +   *entry_count = 2;
>>> +   entries[0].freq = min_clk;
>>> +   entries[0].selected = false;
>>> +   entries[1].freq = max_clk;
>>> +   entries[1].selected = false;
>>> +}
>>> +
>>> +static void smu_cmn_build_discrete_levels(struct smu_dpm_table
>> *dpm_table,
>>> +                                     uint32_t selected_level,
>>> +                                     struct smu_clk_print_entry *entries,
>>> +                                     uint32_t *entry_count)
>>> +{
>>> +   uint32_t i;
>>> +
>>> +   *entry_count = smu_cmn_get_dpm_level_count(dpm_table);
>>> +
>>> +   for (i = 0; i < *entry_count; i++) {
>>> +           entries[i].freq = dpm_table->dpm_levels[i].value;
>>> +           entries[i].selected = (i == selected_level);
>>> +   }
>>> +}
>>> +
>>> +static int smu_cmn_emit_clk_prefix(char *buf, int size,
>>> +                              bool is_fine_grained, bool is_deep_sleep,
>>> +                              uint32_t cur_clk)
>>>    {
>>> -   /* Frequencies within 25 MHz are considered equal */
>>> -   return (abs((int)freq1 - (int)freq2) <= 25);
>>> +   if (is_deep_sleep)
>>> +           size += sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
>>> +   else if (is_fine_grained)
>>> +           size += sysfs_emit_at(buf, size, "F: %uMhz *\n", cur_clk);
>>
>> What about keeping the else part as C: <cur_clk> in all cases - instead of just
>> fine grained? * indicates the closest level matched and cur_clk will give the
>> exact frequency.
>>
>> Thanks,
>> Lijo
> 
> This is a good idea. However, for now I'd like to retain the existing logic to stay compatible with current parsing tools and prevent potential regressions.
> Also, note that "F" and "S" are optional labels, which are only shown for unmatched DPM LEVEL entries.
> 

+Bill/Maisam

What about the case when current clock matches min/max in fine grained 
scenario? In the new logic, F is the label for current clock always for 
fine grained clocks which is a deviation from the old logic. Is that to 
always show 3 levels in fine grained?

Thanks,
Lijo

> Best Regards,
> Kevin
>>
>>> +
>>> +   return size;
>>>    }
>>>
>>>    int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
>>>                               struct smu_dpm_table *dpm_table,
>>>                               uint32_t cur_clk, char *buf, int *offset)
>>>    {
>>> -   uint32_t min_clk, max_clk, level_index, count;
>>> -   uint32_t freq_values[3];
>>> -   int size, lvl, i;
>>> +   struct smu_clk_print_entry entries[SMU_MAX_DPM_LEVELS];
>>> +   uint32_t min_clk, max_clk, count, entry_count = 0;
>>> +   uint32_t selected_level = SMU_MAX_DPM_LEVELS;
>>> +   int size, i;
>>>      bool is_fine_grained;
>>>      bool is_deep_sleep;
>>> -   bool freq_match;
>>>
>>>      if (!dpm_table || !buf)
>>>              return -EINVAL;
>>>
>>> -   level_index = 0;
>>>      size = *offset;
>>> -   count = dpm_table->count;
>>>      is_fine_grained = dpm_table->flags &
>> SMU_DPM_TABLE_FINE_GRAINED;
>>> -   min_clk = SMU_DPM_TABLE_MIN(dpm_table);
>>> -   max_clk = SMU_DPM_TABLE_MAX(dpm_table);
>>> +   count = smu_cmn_get_dpm_level_count(dpm_table);
>>> +   min_clk = count ? dpm_table->dpm_levels[0].value : 0;
>>> +   max_clk = count ? dpm_table->dpm_levels[count - 1].value : 0;
>>>
>>>      /* Deep sleep - current clock < min_clock/2, TBD: cur_clk = 0 as
>> GFXOFF */
>>>      is_deep_sleep = cur_clk < min_clk / 2;
>>> -   if (is_deep_sleep) {
>>> -           size += sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
>>> -           level_index = 1;
>>> -   }
>>>
>>>      if (!is_fine_grained || count == 1) {
>>> -           for (i = 0; i < count; i++) {
>>> -                   freq_match = !is_deep_sleep &&
>>> -                                smu_cmn_freqs_match(
>>> -                                        cur_clk,
>>> -                                        dpm_table->dpm_levels[i].value);
>>> -                   size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
>>> -                                         level_index + i,
>>> -                                         dpm_table->dpm_levels[i].value,
>>> -                                         freq_match ? "*" : "");
>>> +           if (!is_deep_sleep) {
>>> +                   selected_level =
>>> +                           smu_cmn_get_closest_clk_level(dpm_table,
>> cur_clk);
>>>              }
>>> +           smu_cmn_build_discrete_levels(dpm_table, selected_level,
>>> +                                                 entries, &entry_count);
>>>      } else {
>>> -           count = 2;
>>> -           freq_values[0] = min_clk;
>>> -           freq_values[1] = max_clk;
>>> +           smu_cmn_build_fine_grained_levels(min_clk, max_clk,
>>> +                                             entries, &entry_count);
>>> +   }
>>>
>>> -           if (!is_deep_sleep) {
>>> -                   if (smu_cmn_freqs_match(cur_clk, min_clk)) {
>>> -                           lvl = 0;
>>> -                   } else if (smu_cmn_freqs_match(cur_clk, max_clk)) {
>>> -                           lvl = 1;
>>> -                   } else {
>>> -                           /* NOTE: use index '1' to show current clock
>> value */
>>> -                           lvl = 1;
>>> -                           count = 3;
>>> -                           freq_values[1] = cur_clk;
>>> -                           freq_values[2] = max_clk;
>>> -                   }
>>> -           }
>>> +   size = smu_cmn_emit_clk_prefix(buf, size, is_fine_grained,
>>> +                                  is_deep_sleep, cur_clk);
>>>
>>> -           for (i = 0; i < count; i++) {
>>> -                   size += sysfs_emit_at(
>>> -                           buf, size, "%d: %uMhz %s\n", level_index + i,
>>> -                           freq_values[i],
>>> -                           (!is_deep_sleep && i == lvl) ? "*" : "");
>>> -           }
>>> -   }
>>> +   for (i = 0; i < entry_count; i++)
>>> +           size += smu_cmn_emit_clk_line(buf, size, i,
>>> +                                        entries[i].freq,
>>> +                                        entries[i].selected);
>>>
>>>      *offset = size;
>>>
> 

