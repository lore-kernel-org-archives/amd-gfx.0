Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6500FFF885E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 13:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE1B510E036;
	Mon, 27 Apr 2026 13:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JbT4oCEQ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3DB410E036
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 13:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOUQRsNFzusjVNHYNJO0Adb7WnjjwOCC2OfNNcD2AuWf0Us5rpKc2W8S1U/NHScSNbNQg984jsz0POAhKUe4smyH46WoryJCan05lV6MqHpmJ/oXjEUvAtEIxaGtqd7+AOofgyjP+teea24aivA13XK1jT+f+2gRSOALsNLRTLzUFJd0b9CzNe/6JUSep+5cS7HRLfAyqJIZKB0K5WrDWJyJFJsMmkRnEeJjF15ghFFC2/OY2+LMWI+UtFFPftOsuAzDIZBz/vrdjSwdP/uRe3RtDTcA3tck6/0ZQjWwaofFcmJPEXIsqYT72o5FivVK/jW1IIoTkOGNdPmnXIvf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQSqg3RJOOQo2JXuY5r5JX7s6CfmvFp0y4rX21r36d8=;
 b=Rn3C4wXchS+zjn7L1x5FURjaP4r13TalPUzvWA5E26Ig4SFCGLrXKxVTsMv97HehT8iPJZ60iyK6QVwBoba0rmRKEnQa6r3tonjyiAV9i8v9cfP0ljDLh8uIr065EwRArLPR42NwDGL+hm1KWxjDux69ZrJ5jkPczHC0TfRuD6gMucySPvzU+pp6+tttckLKtc0KGFOC8XZYqIANTgMuk2LTbXptrxQ3zGQ0J5PNOvsRzrIC98xJx0PTkOuGRp0qIicfFO8Mx7F/CIgOpgSPqUbsAJHt8ErCV3scLiJIZUWDKeBfpYSFwtrKW4doJZQLHajV65ZMgMXu7DM3kX2XDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQSqg3RJOOQo2JXuY5r5JX7s6CfmvFp0y4rX21r36d8=;
 b=JbT4oCEQrOvSF4KleOlp+Ze9n3CE63dLRTqaudsvzGDTQ0SzqxK71DcdyAxl+Wf9n608Hn/LvmJLwmV9VtKvhlBmeDNzYqho5lURRD4NWN6ODf4rlj9Qy5MaIVJUoRfq/XDz0Qrn+Xqyfj18/wj2tYJUhiGAC83WaSgRzdSyT+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 13:57:58 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 13:57:57 +0000
Message-ID: <eac359b6-13f8-4114-96db-84f6b2429968@amd.com>
Date: Mon, 27 Apr 2026 19:27:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260427073042.3547935-1-lijo.lazar@amd.com>
 <DM6PR12MB2972472A5F44139A4439029C82362@DM6PR12MB2972.namprd12.prod.outlook.com>
 <b462125b-0cf8-4fff-996c-26a58e48e438@amd.com>
 <DM6PR12MB2972F9AD29542173B6B9A9B882362@DM6PR12MB2972.namprd12.prod.outlook.com>
 <fe6ed465-47bb-41fa-9d3d-5e6c79b83bd7@amd.com>
 <DS7PR12MB60717B0AC6C53245966A41868E362@DS7PR12MB6071.namprd12.prod.outlook.com>
 <DM6PR12MB29722EEFE265BC9704E3558882362@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB29722EEFE265BC9704E3558882362@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 25bb4fd4-a2fb-48e9-6740-08dea464fbf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: EyAuytPbaXhtgYQOaRLY6IVaTaqdEHZi1LlCiac7K3B6/3QjP1XzP45/Oc1GojUPAM1/+L7XkbpbKIyDYM7gnDIZeGIRppdsj4stPwsn7kDHVBGR4mffFiFaqgluQ2v+ZtEkgBFVlV7OP1/kaab1lzDJXGMgu8Ba9wyXG6hf1ldOIyU+r8KVXVp+/vIGcCpWR+ZTR241pQiE8J79RyBsj9cui8U4Tk17jmTAIA6AiVgZ8/xXVqsvzw9Muy+ZULLpnMDY27vrixuI0G0gg02S3RtOQ65pKefuxUFlnUhS4meKLbf1Fvwr3XO9Jo3PCnNa3NpcGQaMXDdvF8LlKQXJ3nbCIaW1r579J2zvnohhUJ+HFMot6xo+jBVAogvDOr1AZ6nniAo/q6TkrCCxqFlb/8VKvDVvI6aMXwVBFwSUNmuY9gIcL6o1QOJo+0XByWT6BuyF+EK9kkZVNqkp8vd+wf09IncRDMzmvIDC0JhWczu1Bew7bddd5cEJeUwVS5BkBkFaYUh9LEuNr27Toz+QX7ryC16fxjHDF45+m3PWsGAoZnW1gThb35uCEs1+2YYWQJteM3fXZKvF6uHiJ1nEHi6khGysmLVQnn3eBBfT69k+ygRwmodG8F0ffd/ExP23mDaBIqsmtZr2ekNe1GA8TOkbPS25Jsc8+OLf5GcySaCo4zn35Jo2b/K23I5Jonfpq9BR8HIjZHVoIWXUG+KLiL4eJrNoTZWtnhPJ0Q5U2KQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3RKeCtyMFE5NWtWdGU0L2F4ZmZQMk9QNlVWRHFISGRsVm1TN0hKU2pSRGlk?=
 =?utf-8?B?elA2L09STTZHajVZQ2NVcFp5WDRXK3BSeDRLSk02K2xPQ016eWNlc2tjMVV1?=
 =?utf-8?B?QnBmRVNORE5wdndaTHlmYnR1WmJsYjEvNmdWM3FCRUpjRURCYjYwb09aUXcz?=
 =?utf-8?B?THBjdWZwNVYxMWNaNjlrOHlib1NqaXJNbElYYWhVREcwVk9jYkdUZGdsekVw?=
 =?utf-8?B?dWpiU3U4WGRraTBncXBXUmlWWmtwTmp6YTNhMndYT3JNWkVZM1lheE9pUFBQ?=
 =?utf-8?B?dHhJWXBWWjJ0VWNPa2hDRGs2amhJR2sxNTJ5RU51VzB6ZXRibXVvVG5Oa21W?=
 =?utf-8?B?SVpJeStsWllIU1dqbytRS3F0ZFZzS0laSVRyTE9VY3JWU09md3kzTVZlaDY4?=
 =?utf-8?B?eFh4bjB3WVJjYjJQdjlOUEtraW9UOERmbldWK1BoOHBhWnlGR05yUEpFdUtv?=
 =?utf-8?B?ZUZCaUptRmxNdXV5ZFZQb1FyaWMrQkMrWUo2WEdvVUplOEhLLy9nMlRtbkZO?=
 =?utf-8?B?aWlYTFcyRWVkZDRXREVueVlRbnhNS3B2MWRnbEMxanR6QUpLMXMrUXRycjh6?=
 =?utf-8?B?OVZtMGJJNXVpRjgyOGVpYU5mb3JlSVFKVDJ5M3huRjFMRzhmMm5nbXcvR0ht?=
 =?utf-8?B?K1B5TGJTOWlwK3ovNFJIVzN4M0xEQmM3aUJqcjJ0Vk9Vbmo5b3NyTkxFOVpE?=
 =?utf-8?B?aFpLNXI4czJvRDdFL0pWT09xVDk2OWNVcjBMRmxlb3pPN08rZFNVNXY5eXB3?=
 =?utf-8?B?U1BOcC85TUxHZXh3T0pxcTlNd3ZEK2EvUlVCZ2tUOE9tUzlyUmFGMGxsdlkr?=
 =?utf-8?B?aW9yQXRIN0ZBWm4wWm04ZkVlR2tLY1EwNkZZT1JBMHF3eUN1VkFsOTRlT283?=
 =?utf-8?B?VWNpS1k2MFc1ek1URFJpRWdtUEswM1M3eFJBSGZqUUNCd1lGdXgrVGM3TXJq?=
 =?utf-8?B?OTdTRGVqNEdHZE1EU2xUNkdhdXNYSWxGRFFRQmV5MXcvaEtPdnhxMXRVSUpS?=
 =?utf-8?B?Yk1iNzBjd0pIUC9CbGN3bXhlbzc5Y01ITk91NGxTVmxUZHdLdXU5c3pZUmFF?=
 =?utf-8?B?UjEvU2tyVUJ2OTY2ZitKYmhDdWxscER4dE9aOUNSa0hrT3JqbE50UmdTbWFL?=
 =?utf-8?B?VmhMaU5OWk9scE1SV2NvTGpYa3JhZW1LMGNmSUxISzY4ZGl4b1V0eHh3dXl3?=
 =?utf-8?B?Yk5GTmo4aFRPeTdoSldId2hKbEM4ZFVuS21PTFltd2hrN2Frc1ViU1dpSDhG?=
 =?utf-8?B?cGpIcU9Kcy9Ka3d5NHZPOXEybjI3QzhsS3FNYXpDK21VUGh1a2szNFZ1YXR1?=
 =?utf-8?B?QlkwQ2l2Ykk1dDRhNnhEOFRLaEZFcWtuTXRHdkhSUm1aak9ESXRTQWozbGZ6?=
 =?utf-8?B?a2xRTnlsclFaN2F2Q0V6YTVDYm1UUjFYbHQ5UHh5QU9YZ2hnOXJpdUpQWmM3?=
 =?utf-8?B?aGs0dTlkZVYyWU5vRlNuZWRGdUYwOUJBS21tQWgvOHYvM1BDa3g4Y2xZV3Z3?=
 =?utf-8?B?SDB5TEtham9UalBLN05Pei9GMXplNkt4NThUTHRLTGlGV2tQdStqdmFZMFVj?=
 =?utf-8?B?OHB6cXVsdEMxSThxSkxzamp0VnI1cm9CZ2Jld2swZ1EwUllab3l0Yk5YQnFp?=
 =?utf-8?B?bmdRcC9BaDAyc2JYaWxwSEhDa0gyUGNHSXVqd3RrWUp6MzlURlpOUUExbWZp?=
 =?utf-8?B?c0VGSGRNYWYrbEsvR2xtWEZOb3JPSEVMSjRrSzZDV2Rzd00raWUxemhZWkdm?=
 =?utf-8?B?M2ZGODVSajhLWmxBQ3RQclJFOVREVm9PemF1L2w0ZDJsbllSZUhkNFBETFRz?=
 =?utf-8?B?LzhvM1Qra1dDSDVodzd5M2IxbkFCWHV1Wkl0S094MWp3N3p4Wks2MGhDNVRa?=
 =?utf-8?B?Qy9XTFo0ZndraFJwdi9EWVg3dW5ZQnl2OGhNa1AvVmlxNE02TTFRUUpodGMx?=
 =?utf-8?B?MXVDbFpsZ2hkNVJ0YnVhbWplQy9FL2ZJeHhZSW9LcGZRbjhxUVNsN0pSdGtP?=
 =?utf-8?B?U2dzZmI1RUZYazdTYWl1b1RBTDl2RW5QZ1FiWVRkeWI0UWxYNElqTTUrZjAx?=
 =?utf-8?B?Q0RWMWhUaUFMV25vb3lqcy9STlgzV1dxK1VYWFR3d0VYc3p2QmhHWDNnRzRY?=
 =?utf-8?B?STlZbDQ4eEJCNDNCcEwzeFRDTWxQWXlHVVNmdHA1TTExanp2cCtFYURmQ0VF?=
 =?utf-8?B?amtMck9DdXpYUjAwMmNPNmFuQVhjN2R6Z1FzcGc1cEEzempOZ1JXbHhRRWM2?=
 =?utf-8?B?TEhpS2crcW5YdWF6Rkl3MlBwYzlmNFJCd0ZoemNLcXlLRmtDZm9nSEh0OVhn?=
 =?utf-8?B?WEdiOU9rSStTYXd3SVpmNElDZmNkRllDTjZ0UDZnL3JLMjdSY0lpUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bb4fd4-a2fb-48e9-6740-08dea464fbf6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 13:57:56.8631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Au58XuqPAmCmVkvhfrO2o/3XJCwPwJpTL6P7X+Tn9vsnMuOsvrKfkwutJq74OlQM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761
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



On 27-Apr-26 5:53 PM, Wang, Yang(Kevin) wrote:
> AMD General
> 
> Sorry, I need to revoke my Reviewed-by.
> I object to adding this custom workaround for SMU v13.0.6 in the SMU common layer.
> The concern is that this stems from an incorrect this patch, then adding an additional workaround to compensate for that incorrect change is not appropriate.
> 

This is not a custom workaround, but rather an issue with common 
implementation. Flags is a property of the clock table. In older SMU13 
SOCs, fine grained status query also required DPM to be enabled for that 
clock; hence there is a dependency on DPM enablement.

In newer SOCs, there is no such concept, rather the property is set in 
the clock table for the clock type. Thus DPM enablement is not a 
mandatory requirement for the clock table property.

The current common logic assumes that table for fine grained clock type 
always will have 2 levels enabled regardless of DPM enablement. That is 
not the case when DPM is not enabled for that particular clock.

Thanks,
Lijo


> Best Regards,
> Kevin
> 
> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Monday, April 27, 2026 20:00
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
> 
> AMD General
> 
> With follow up patch already sent to update smu_cmn_print_dpm_clk_levels logic, there is no more update needed here
> 
> Reviewed-by: Asad Kamal <asad.kamal@amd.com>
> 
> Thanks & Regards
> Asad
> 
> 
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, April 27, 2026 2:45 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
> 
> 
> 
> On 27-Apr-26 1:39 PM, Wang, Yang(Kevin) wrote:
>> AMD General
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, April 27, 2026 15:56
>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
>> amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
>>
>>
>>
>> On 27-Apr-26 1:16 PM, Wang, Yang(Kevin) wrote:
>>> AMD General
>>>
>>> +       dpm_table->flags = SMU_DPM_TABLE_FINE_GRAINED;
>>>
>>> You need to move this line of code under smu_feature_is_enabled() to prevent subsequent smu_cmn_print_dpm_clk_levels() errors.
>>
>> I think it's better to fix the smu_cmn_print_dpm_clk_levels() logic for that - to keep a separate path for dpm_table->count == 1.
>>
>> [kevin]:
>> No, this should be an independent issue, and you need to maintain consistent code logic with other SMU functions.
>> e.g: all locations where the smu_v13_0_set_single_dpm_table() function is invoked.
>>
> 
> The issue is because smu_cmn_print_dpm_clk_levels is hardcoding number of levels to 2 for fine grained regardless of dpm enablement status. I think the fix should be there rather than at other places. If the count is only 1, it shouldn't keep the hardcoded value as 2.
> 
> Thanks,
> Lijo
> 
>> Best Regards,
>> Kevin
>>
>> Thanks,
>> Lijo
>>
>>>
>>> With that fixed, the patch is
>>>
>>> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
>>>
>>> Best Regards,
>>> Kevin
>>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Lijo Lazar
>>> Sent: Monday, April 27, 2026 15:31
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
>>> Subject: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
>>>
>>> Gfx clock is fine grained on SMU v13.0.6/12 SOCs. Add the flag to report clock frequencies correctly.
>>>
>>> Fixes: 7380228401c4 ("drm/amd/pm: Use generic dpm table for SMUv13
>>> SOCs")
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 +
>>>     1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>>> index 40f0d8a685bf..8d04f6e73fd7 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>>> @@ -1133,6 +1133,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
>>>            /* gfxclk dpm table setup */
>>>            dpm_table = &dpm_context->dpm_tables.gfx_table;
>>>            dpm_table->clk_type = SMU_GFXCLK;
>>> +       dpm_table->flags = SMU_DPM_TABLE_FINE_GRAINED;
>>>            if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
>>>                    /* In the case of gfxclk, only fine-grained dpm is honored.
>>>                     * Get min/max values from FW.
>>> --
>>> 2.49.0
>>>
>>
> 
> 

