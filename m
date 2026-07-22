Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B723C4452D
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 08:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2453010ECCE;
	Wed, 22 Jul 2026 08:11:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0kKRd8No";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A10D10ECCE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 08:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED5TGWiejCe9ymCqQ5VZLsDhaCkFLXh/H615XI9G7SeYQD4wy/clGGcFI6W+Uma+6muhP0GbhWCMECgLXtaiABh5jEO3Go5YFN1QppojUCxuJXicbjdeYtx/dxPR6B3W1LwvwNl7jIM2MWxuad0LpO41m4KS7KyBCEmNZQBLRjRZPbz5266p5t+3pXSMVFkbWNCmzA0BXmBcFkq6GtmzkRMPHl3E251suZiR6xU057v3+tI9p860NAgEY1GhRcTj/Gu1h+NKnLVorgq2ZWu4x6P11go31wBmAi2BB16LsLisoBK77kWTawk9zZ9mtivOGMDXpfJhvgn+3QtIiPJ6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3G8Haj5y9MUJCG4kXYCPwmZ9il5+i66O+bzTglZ368=;
 b=P7VsQnBn+lnUS6lh5+yMOUstWsbP42OePP5pweT0wB+cOzdbvGuzyJpd/0N3yeoPjwZqkRJReHZjNNyX09XfI7oGt6CIZKCrWtVQGWihCvv/zTEUc+8n9r6ERL2bsebAKXEBhQeCn3TbCxxcwWPIXDOM2gnWkUzvWoV9iEBRQUJpx3LZpdN34t0wTMUO8ofbOYvio2ehC0CnA5DoIySR2Ac0LaKapIYumo6WS52vFO+Px8rHhZjAHyMYXl9v+Gs9FgqUcUOE87f3nwjmg78agDa61uLG3/Rcs/sLL3IfCcIJ4tGLXlmhcQbzX9sTaFUMWIbr7r+ZsPhhdYFYBELsog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3G8Haj5y9MUJCG4kXYCPwmZ9il5+i66O+bzTglZ368=;
 b=0kKRd8NozLtbm9ZWdC1C3YekYP5/d5wAB6PT0YsQDqWGlxsqFwFeK1OrRgY/DyRVVd1gVhFx1WODoLdUaMlNXfG2Jx2g+bczBq4oZx5TcMi+gxIT4MXdIy7Ia7vkbgUDeGPyEuLg2mEdy/9Fhi8OIn3xTtTEw4bewIvhULZB7ok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 08:11:50 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:11:50 +0000
Message-ID: <a5dbf15f-b897-476d-afee-8a10c031075e@amd.com>
Date: Wed, 22 Jul 2026 13:41:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Fix warning about helper function use
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>, kernel test robot <lkp@intel.com>
References: <20260722065549.425085-1-lijo.lazar@amd.com>
 <BN9PR12MB5211A0F3EA479CF09F27A70C82C12@BN9PR12MB5211.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BN9PR12MB5211A0F3EA479CF09F27A70C82C12@BN9PR12MB5211.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0063.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: b57c1de5-e2e7-43f5-d1d3-08dee7c8e1b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ptSHHF3bJqzFeC7nXeZvAfNvj/Wk+Q2KCi+YjsfXJiNmlSyxqB1lmfhHWxiCaPAp1LjH0IrvQOroN7h1XNEsBRIacrWr7MVGIMQS52Bqx0XWhB61H3qd4lHjbgGiSTCus3Okrc15PbmSw6tQNDpklBoy/TwPcZSpJorT3XadRSlu3vvY2Fop2HPYcpbcj4aHB5HqCvafgykFTHXRp5NC6b6cszXwOgDa0LJbWcKQ8xRtmPkLkPTHWMR/a93mIDl36cw98Nx40NoTp7Pwdo49M367M9yUUqYKovrM/0vCgEIbVe6O+3WOtNy3WIO+T3EraM3nknsEHz3KPN+AJC/r6qsofKMIfgWtM2rvESa1xOX9WMxEg8t8go6maGpwTZmIFJIkFY0X5CYorEWZn1CJJABB/jDwUdv78G3cK7BL4RaCxC6/nr5ndb8kjxazlnlJQsIxMpypKKcSr14KMRHluB5brc4rWz+sSO8121DMej8NhO5ZmOrpGDZYTMu80KMAZES3jFqh+BZ4TdP3EB72J01a7UhL5yTsXuviD62xgNcilKEQvTZl+4bUMb7K4J5nqmjUGTgmsPZmsSM449u/PN9cNRBIVWA2zR2G72vvs0TPLeYl++ukG9xXEMfH28SB7b8PknnOkn/wYCEM/vzRbbxbWoeXknPt+NSsEmDIJyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFQ1aDFpdXFaUE0zbnBGNUpPMlJFRG01T0Y1eGFxamQ4aDY4UlR2eDR0eTlI?=
 =?utf-8?B?RjRxMlNEeHVneitPa0dnSzZlNjVmeDd3ai9WYjc3bDRJSjNiRDFkdUJKRUpa?=
 =?utf-8?B?MHV6aTdxeTJ5TU5LM3hwamRCdFlKWXBsK1JQaHNLdmRPSmlyalJYQmVzVloy?=
 =?utf-8?B?YjU3MS9QQlZXM1JicElqaHZPSUZYbURhRitCOTgvam9MNHMzK3dsdXNiL01k?=
 =?utf-8?B?NGE4QUMvRnV2QXRSYnFJOU1EVVBqQldyc1d1d0hEVFRhcHhObUZQWEkzUmlL?=
 =?utf-8?B?VnR3QXMyR1Y1Rk0zajVyWVdRUGhoV1ZNZEk4WFBFUTJlSWJ3cGNFZzEyMjhM?=
 =?utf-8?B?OGRUVkg4SmVsWUVHeU95bGUvTGFDY1krY04zbHRYbEQ3V21mOWhLcU14RkQ3?=
 =?utf-8?B?ajIrVUEyYWV1Yk80QzdFckk5M0xMM2RkZEVGWCtRVThrcFNKQWpyeXhrSk9l?=
 =?utf-8?B?UmZwZG5mSVBDTHk3bmUvZnNEc3hWZm9qMWpaSmpJTEQzaVJ3QlVFUkpMalB0?=
 =?utf-8?B?VDNVdjZSMmxobmdMZFU2RHVhaUxJZW5Heldwb2NQT25WenRDSkhmV2VLU21K?=
 =?utf-8?B?dzNCNzE1R05CYVhuemdXVjh4QmhqUk1kc1JoWVJRMUlhK0VwYUU0TlNHLzdX?=
 =?utf-8?B?QkkxTFNiRmU1MWRaOEY3NlhXTThOUWZHVGdiTUVobmF4MEVEc0t0dTJDL2xO?=
 =?utf-8?B?bnRnREU5K3lrdHBNNngwZGlDbzdEWjBJRzVuV2FQdGluK1BVR0hSTDBXMy9P?=
 =?utf-8?B?Y3AxYVpyY1VkMzZpcnpOelYyM25XVHF0NVl3b09mekF5c0lHWXhpUWNueFlI?=
 =?utf-8?B?eDBlVktLazltMFRTM25IelRJVHh2SERVQk1STlE1cWNXMlhJckNXaUd0dHJT?=
 =?utf-8?B?Nkg3RVVVRTBaeVBySlFoQnFFanl3ZjN3WUhJVUQ0a01COFV5RWZaVGtMbEJy?=
 =?utf-8?B?K1BzZDNEZHFlSDRkWWpSWG5UaVRPZTZ5MHhybXgvYjJIQURhVy9IRTk2TzUz?=
 =?utf-8?B?R05yWStSMmcvNGVhUm5tSFAzNnA4Q013T2RIajNOSW9GbVdTLzZRSjh5anJt?=
 =?utf-8?B?Z0Q2UnltMmtabkc0TlVOUlJNQnorcmdwOTYvWUZNR09wbUQycFlOZE5ZL2s1?=
 =?utf-8?B?ZVBENjN2SmhCM2dCWTlUOTIrTUR4S3dTby9OSlZGUlo4YWx2T0s4UHovc2RB?=
 =?utf-8?B?cndQV3NRbE9ldDRRU1VSSzZ4WHI5ZU9GcFJBSFl6eGxrekJhWDBvem1Ec25M?=
 =?utf-8?B?bjY4SDd5UWVZTHkva2NXZnJPUFBCUnp0N2NobHg5ZWIzbk9BWGg3YWJNR2ky?=
 =?utf-8?B?UW85clNxaENyOHNiaTJkZWRSa1FkTTE2ejV2THUwdm4wc2phZE9FRjJoRjlt?=
 =?utf-8?B?T29QTy96MXlkWk03Rzl5YjIyS0F0R0J5emNTNy9sQWdIK05aNC9Mbm1ubERy?=
 =?utf-8?B?RXlQQlNkZDE3aUJSZnVid21rWXc5UFBGd3dLQk53WEJmZmRNQzBuNS9SVDYw?=
 =?utf-8?B?V1RWVlRSWkROUHpOcExYNGN5VHdDVmE3K25vNlBHb3ZJcHMyeUVlYWhHd0oz?=
 =?utf-8?B?WE9HYTRjQ2lNSnQxZHJTNDVveFE3T2d2emg5eWUraEQ5T2w2V0RLV1AwYWdu?=
 =?utf-8?B?QkREUndta3ZKUVBDMDlxd3JEbTVmaXk3RFRKUHlJaUdLZ2U4cFJmOFdsejN1?=
 =?utf-8?B?V1BlUFZLaGpZSnJFZVd1RnFoSHNpY0ZOMDAwTmF6a2VobGZzUTNCcW9SMU11?=
 =?utf-8?B?OXVRSGhraU9FSUFHM2N1dGx5L05vbXJ2RnFzYTg2TEhpd0lUSlNUSVBmRUls?=
 =?utf-8?B?T1lneWkzQmM3VUdVM0hJTzFnWis5SlYxYzBFMlRUWmlvUklGRDJjL2hmZ0VL?=
 =?utf-8?B?NER2U1BrcTJRUElZdVhHWXdlY1IwaWY3akRaK3FzeDk3MmdXQkx1U0E1SHBT?=
 =?utf-8?B?Mnd6cXNJYk04dENHd0xsdXN4TE12QjlCNjBjM2RDeERjVWtsWjJsMFRYeWow?=
 =?utf-8?B?WGNSQlIweklJSnFNZG1NSHVGWHRZdXduWkdWcjJQUmdpRnFpK2UvK1Fxb1c0?=
 =?utf-8?B?eXk2Qll4aXFGMDNRdU1paVg5OTFCWXp5NU14ODhSRzErT0Z2N0JHUWd0VTNi?=
 =?utf-8?B?czFhWGs4UGdyNElTY21VbWZ1Wm8yS1NZSzJYb2FUelZRVEtnRGJ2bWxSZDJD?=
 =?utf-8?B?Z0J6UHBUMUhaNlowSzdjRjMycnRVT0p4M2xqTVNRNUc1WHEwb2YzQ0xKSDQ2?=
 =?utf-8?B?NTZJaGtlc1NLUGVyd21tUm1hZGhwUnNwQThUTE9pSkJielRNSzZUaXUxSmV2?=
 =?utf-8?Q?RD6sW/ghDP2wIdDYoA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57c1de5-e2e7-43f5-d1d3-08dee7c8e1b0
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:11:50.2418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AAGnLwsrMUBqigzXZIlHze2R3k6UY0hB/oNYM9PqaVK3NHmM9XD6S7VBXEuDjy6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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



On 22-Jul-26 12:57 PM, Wang, Yang(Kevin) wrote:
> AMD General
> 
>> Fixes: 7b88453a476c ("drm/amd/pm: Change get_enabled_mask signature")
> I suggest removing this line and refine the patch title.
> 
> The tag "Fixes" is used to indicate that a patch should be cherry-picked to the stable kernel branch as a bugfix.
> In this case, this is only a suggestion rather than a bug. No related issue was introduced in the original patch.
> 
> Ref:
> static inline const char *str_enabled_disabled(bool v)
> {
>          return v ? "enabled" : "disabled";
> }
> 
> With that fixed, this patch is
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
> 

Yeah, the tags are copied from kernel test robot's mail. It's only a 
cocci script warning fix.

Thanks,
Lijo

> Best Regards,
> Kevin
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, July 22, 2026 14:56
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang,
>> Yang(Kevin) <KevinYang.Wang@amd.com>; kernel test robot <lkp@intel.com>
>> Subject: [PATCH] drm/amd/pm: Fix warning about helper function use
>>
>> Use str_enabled_disabled to fix below warning
>> drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c:920:3-56: opportunity for
>> str_enabled_disabled(smu_feature_bits_is_set ( & feature_mask , feature_index ))
>>
>> Fixes: 7b88453a476c ("drm/amd/pm: Change get_enabled_mask signature")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202607210737.OeGpY3kI-lkp@intel.com/
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> index 2bd3ea17e789..764f943df5a8 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> @@ -965,9 +965,8 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context
>> *smu,
>>                        buf, size, "%02d. %-20s (%2d) : %s\n", count++,
>>                        smu_get_feature_name(smu, sort_feature[feature_index]),
>>                        feature_index,
>> -                     smu_feature_bits_is_set(&feature_mask, feature_index) ?
>> -                             "enabled" :
>> -                             "disabled");
>> +                     str_enabled_disabled(smu_feature_bits_is_set(
>> +                             &feature_mask, feature_index)));
>>        }
>>
>>        return size;
>> --
>> 2.49.0
> 

