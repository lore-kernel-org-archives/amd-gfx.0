Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE9FF588E2
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 14:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1856E10E689;
	Mon, 20 Apr 2026 14:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f7PstexD";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010002.outbound.protection.outlook.com
 [40.93.198.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C045C10E689
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 14:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwl23ArMzju9LkLcDpkUiuRk1b3tQF5XW9UhxE5JGTAbP02Is9aB0fyc+d/hN6369ktEBl1IZJbz3RoOVVe9k1DETotfGOQoPCYFp/R26bnEDPxsyoWbRLHHnXNrD2hqIW5eTUoswrNsKjPErQEUx5Vmmk43p9ORtMHQJUqLFoPAVp0SO52vy/MGRmeytHHV57bTJFevaegUtHSKlnrDPFMD1/I1qO5eYYmL+rQPdWT5GyZlD+Gmwlw1RWh3U37K4YgRRwAbjWSbRu2cSN3qBMvYgladwCRI7zq7q7htYAhJPMZcUnXaReLHz25dI91AkauOAP1gUDxLmdXb61a44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaVGj+cMTplujVPq7EriaIpPa3h/0LUfv6L178YMqn4=;
 b=d7yB7Uh8SAeF09w/v5hAShlH04RoRj3nPSbomUwM+sgVrghc01gjfjFYnZL4c3Nn5UzNuS4YHTAV2fE6XDGUf7vpSFvYG5ZnLQ7TrRz9ZOodGxztf4BhH7mZZvQGHX/HAYEgAREjpIngcJcpBlp3RXndr+rBqkGkyBhbUbY4IPI1F1Qvx4R0uq54FGjJRZJ2B1qIILvGPtsHRrlwpbVPE29d77hkJxEB59VFbQUErxH2SPWTRE4hfopSvQAuVfjOPE+r9ZAwbbrub1b13U3a2BKseNvk7FcLhN4/UTtTi3tDkoFfbdf6+8DbmT+xobbQHrsG1YufdbjLJi1F94GkmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaVGj+cMTplujVPq7EriaIpPa3h/0LUfv6L178YMqn4=;
 b=f7PstexD5tibHtYBM1IhzRATmrrbGbs8airl2xnfgrjA1ruY9fUd2juZA23HZvNpMtGnd99G8KzS0yit/sfDEO4v+BGsPjtPrX7vheMmDNB/W3oFJlKZI1hGa2hUB8Xqa2VDXdrwOIZwUMa9ZOJ/1yq4OcUA8xY4m5pglQXihyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Mon, 20 Apr
 2026 14:45:15 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%4]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 14:45:14 +0000
Message-ID: <886d6fb8-4065-4acf-a4cd-03c63b92b545@amd.com>
Date: Mon, 20 Apr 2026 10:45:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu/include : update mes api header v11/v12
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260416165056.15459-1-shaoyun.liu@amd.com>
 <CADnq5_OThuww_7RA0xyQNkaiGBzzt1q2tRsCBtH_CKn48aD7DA@mail.gmail.com>
 <CH0PR12MB53723E8B2FC6B3015351C646F4232@CH0PR12MB5372.namprd12.prod.outlook.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <CH0PR12MB53723E8B2FC6B3015351C646F4232@CH0PR12MB5372.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:610:4e::29) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 6766d565-dd6c-4044-9fa9-08de9eeb6e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: C9vyz/3K5cXPWAZLcmUzsCEKNF83q+KIc/jvJTtVw9WEJPGobYSovIQHAK7Agb/XSDa83RArNQ99shRaTtp0sx7HFc3B6zGlBW+Rthtkjlf9Od1FSUeXy0Vab25pADhJEsJaLXR+KDvL+iriMGLywnOVOXWahafkOF54Hxip7pwVmSIRD5q8/jcvwN3S6qfSDrDOhLcnCrNVxtlbpKDKqzhZFE7n1wUJdvDaNNfjgMmLoTeTH6ldqaqdWygGyUjNrqEiGZncOuGCP2qHNNFb1/FKMP9WO2+ZpMYlj5H3ZJsCf54WGylwbv2lIYzigYgC5wg4OVXtj+0Ks60EAac03SThsW3fx2wPwQ6eOFSUtiIsna5PVSBZgAaTBp1fKEM5F6Y1TLGkhfU281q5yY2Ho9xT5IM0wFeAvFetAfRNAPJ7KvCL0V+tOuWb8LcHUvjG8hTXjydZlwhdixR7/0ze+3hBcO4dEvCGoodQiffbd4YDUneNS34WT5cz4v1Ds4NxwiIiy8B+h/lgqCqukqqp1tK2gTIzx0NeIg+xlfK1Xo6rrc8QW3v57wJSw14voh6FXno1XfrLPvLZsHS/aIxPKDDvl94xpyM5/KxmHL45alH5e4/L7zwQ01tpVzwRyHu38WwkhJGSc+lt0WPLg9Qxu/qh8bRIeZPdSDiKKngcjiBc9D+CoV0oyCfsXMLw+8PgcGejVljiU8S0lyohwnypm0oVqlege3tgl12JVXcKF88=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3JLdEVLWnBqV0lXOUxBTU9zZU1IblFySUNrQVZraCtyai9QUWppK1gwSVNQ?=
 =?utf-8?B?Q3BoaUdnYkRrYkhCbExIemRrZzZycThFWTdRY2xQTkJ4Slc0VHhYQ1laaVA2?=
 =?utf-8?B?ekpDOFZmbzJZRlNFT1k2UjBiVVJoQ2dKUloxS2xiM1NuRXhsdVhGaFU2ck9t?=
 =?utf-8?B?em9DeTBJUXdyNlo0MnpndVNpM09zYmxiZTZNUlFXWFcvMndnQUhDckIzb3Zm?=
 =?utf-8?B?VzhobWdaWnlHVlBaOWdQa2E0WklpTVpNcnJ5RWI1OHc5REhJY3J5U0xILzE2?=
 =?utf-8?B?MS8vR25CVkl5Q1VpTXpoUEpZN0NaYzhkK3ROa3hpeDN3UTBnTEJvZlUvQy9Z?=
 =?utf-8?B?VW1vRFZMWlZtM0hRdVlZeWFXamM4RWF5OHdaaDlGSDZudVh6cVc0ODQ5WCsw?=
 =?utf-8?B?Qkl5MXpCV3hKVm9ESVlyd0paYlM3VXliZ3NoaTZicmViR2lyYVFtcm01YjNF?=
 =?utf-8?B?aDVvaFFvdC9lUy9SanhqNkZiUW9PR1lkWjcyZnZqR2hxM0J2dm54eHVLUzR0?=
 =?utf-8?B?aWw5U2s0WVNMTzMrUlVIa1dtc2tXQkpDUjVYUnc4ekdDUnllRXFZMStmOE8x?=
 =?utf-8?B?MmtlOUlQbHQwU3VoQ1BsS0RSeFo0SnIyNFRFbCtjZDdZcVhwVmg3enNOcDBZ?=
 =?utf-8?B?ZGtVQjVZVDhrQ1dMQ2tibjdTdDFHTXR1MVZSTWtHUFh6OFlDYjBIQmZGQ2Fp?=
 =?utf-8?B?VWthWkJPNUhoMGVxMnczczNpL1REQmtkRzZuazF3YzRzczVVT2g1dngydWcv?=
 =?utf-8?B?bk50NE5zRzZXV3EyTTJSZUJwOUZ0VVFtbTFRK1RRMzhGaWRySDJmZEhSYjkw?=
 =?utf-8?B?T1diMWYzd2dqcnJhemVzSTFDVVlpQ3pUZWJEM0k1Vm52WWlPc0VFa1BSSGdV?=
 =?utf-8?B?OWJhYnR5VWIyZ29tNDRIZ0xCYlJVbW9hK0t1L05qWDBYMTVIaEUzaUVBQTlw?=
 =?utf-8?B?bkhkTVBFNDc1bUFpUnBWR0Z3WnJwdlNLTTVSOXFJdE5XTlFqVUZXVkE0cUcy?=
 =?utf-8?B?ak9hRnM4U2hsYXFRZ1lKa0ZtMjdCNy9aMDZVdTJiUUN5UFhjL2M3MUlsVnAv?=
 =?utf-8?B?alJpOXc4Z04wTjRYWkFUaThhTDVWWURoZzhaTmdTN29nUE5UM1QvU3V3TkVT?=
 =?utf-8?B?TmtSOElReDg0VU5yWFpsdktzdFA3NzRoaXptVW5KeHJIVFlQZGQ2ZUlmRENz?=
 =?utf-8?B?akFTbDRBak03YmtyajJWOWtxdmhtV3NXdi9SOW04VU90TVhQRHpkcEFMWGhk?=
 =?utf-8?B?Nm0rUk5vNnlybmVqZlNwa1VDdVBpSU5XUUlDM09McHFKY2ZvSHVKVXI0QXFI?=
 =?utf-8?B?eWpwQUhQNlUwUWtzeGQrbk9oSU40QW45MVZJYzVTQVNackdkc1dqVTQ2dTFT?=
 =?utf-8?B?cG4rVkJJdmxqUm5FTVRiWFdNMDlpSGo3YlFVQUovTGVORnduc2RzV0ZWSkUv?=
 =?utf-8?B?QzYvNkx4MHJpdkFDSGVhVG92U0M5bEpZbWY0Z2Q4SFVRcnZCT0NVYnd5QmpB?=
 =?utf-8?B?YXc0SUNqRDZ6bDVLMWZDcWh3bGloUWNTRmx6QmcvTm03Qi9HSHRJelpTTHUr?=
 =?utf-8?B?ZXVUUlFacmhNV2JqKy94RGlCNEIyeHVINUJ6WlhNbUJlMUlaWTEwQnRBbEM0?=
 =?utf-8?B?UjUyUS91UkZHUjhsYkt3VGkyaVNLYjhNa1JDWlNmQ05wekFGT2VXQjJuTitr?=
 =?utf-8?B?T0pOWDAwY3YyUkRuc0ZEOXd1QndhdkVzNmVKcG5hRFZNUnZVMTcwa2dvbDh4?=
 =?utf-8?B?L25sVm1JeERPWWs2Y1BFUHV5amdEbmpETThsZ053SjErYzFVZTVRd1BxSlRX?=
 =?utf-8?B?VTNjaENvNy85TS8xRlBPUDBxRC9uRTdKek1KT3lQOHA0cjVHK2YvTFdnVWtT?=
 =?utf-8?B?LzdtQ3JSb0lSVTVKd2xDcXlka2JNdjdtTTVqNm9IRXluQ2NMOVdyNE14VElh?=
 =?utf-8?B?UXByZXQ4M3hHUHRvRkNjYW5qQ2VGL2NGT0RLRDF2L2J3M2RMOHRwVmhLa3Fo?=
 =?utf-8?B?Njl3NDRUaWxlcnI4c2JJcVdnRkFpdlJNSVZodjNUU3NoRGhhbmcrN3d0UVhH?=
 =?utf-8?B?SDdpZ0FvU0Z5NXdaQkpPT3dvejZUUHRqbi9KVTRxVC9hTWxXN1NjT0o4RURR?=
 =?utf-8?B?Z1VDNzZjVzJxeFhnRWVKMy96K3MyUjRLT0FxSHp6RkhkNTdUNHJ0MHYwblZZ?=
 =?utf-8?B?VmlsMUQ5aDdZb2lhMXdNSUR6MUEyS0xRenpqeDNiK3BMZTQ4ajBtMDFUSzJW?=
 =?utf-8?B?RFpvTy9QcEJDRTdwOXAwemk5L21IaU5LV00xdUYrV2VtNWpZQTloSjlneXQy?=
 =?utf-8?Q?8cTn62DmSVibePkapu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6766d565-dd6c-4044-9fa9-08de9eeb6e82
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 14:45:14.5405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSPbAZaVb6k9rRRbc7gVrT5RqmPX76KBVG3FVeO56rVe7Ngm9qx+9jcIbWCpTMxX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906
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



On 4/16/26 13:30, Liu, Shaoyun wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Ok, thanks , will add those info once the mes change get merged.
> 
> Regards
> Shaoyun.liu
> 
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, April 16, 2026 1:27 PM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/amdgpu/include : update mes api header v11/v12
> 
> On Thu, Apr 16, 2026 at 12:59 PM Shaoyun Liu <shaoyun.liu@amd.com> wrote:
>>
>> Update the parameter in SET_HW_RESOURCES API 1. Align with the setting
>> of enable_lr_compute_wa 2. Add enable_compute_pipe_reset to enable
>> pipe reset when compute queue reset failes
>>
>> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
> 
> Would be good to note which MES firmware versions support this.  With that noted,
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
>> ---
>>   drivers/gpu/drm/amd/include/mes_v11_api_def.h | 5 +++--
>> drivers/gpu/drm/amd/include/mes_v12_api_def.h | 5 +++--
>>   2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>> b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>> index f9629d42ada2..6644fabeb0b7 100644
>> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>> @@ -238,8 +238,9 @@ union MESAPI_SET_HW_RESOURCES {
>>                                  uint32_t enable_mes_sch_stb_log : 1;
>>                                  uint32_t limit_single_process : 1;
>>                                  uint32_t is_strix_tmz_wa_enabled  :1;
>> -                               uint32_t enable_lr_compute_wa : 1;
>> -                               uint32_t reserved : 12;
>> +                               uint32_t enable_lr_compute_wa : 2;
>> +                               uint32_t enable_compute_pipe_reset : 1;
>> +                               uint32_t reserved : 10;
>>                          };
>>                          uint32_t        uint32_t_all;
>>                  };
>> diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
>> b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
>> index e541a43714a1..08466d59695c 100644
>> --- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
>> +++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
>> @@ -294,8 +294,9 @@ union MESAPI_SET_HW_RESOURCES {
>>                                  uint32_t limit_single_process : 1;
>>                                  uint32_t unmapped_doorbell_handling: 2;
>>                                  uint32_t enable_mes_fence_int: 1;
>> -                               uint32_t enable_lr_compute_wa : 1;
>> -                               uint32_t reserved : 9;
>> +                               uint32_t enable_lr_compute_wa : 2;
>> +                               uint32_t enable_compute_pipe_reset : 1;
>> +                               uint32_t reserved : 8;
reserved should be 7 after the enable_lr_compute_wa increased 1 bit and 
enable_compute_pipe_reset added 1 bit. reserved=8 exceeds 32 bits.

Amber
>>                          };
>>                          uint32_t uint32_all;
>>                  };
>> --
>> 2.34.1
>>

-- 
Regards,
Amber

