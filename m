Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341DDC0218F
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 10:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9ECF10E79B;
	Wed, 29 Jan 2025 10:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pANpj40n";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4499910E79B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 10:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIx1iOabLEFZ99AtwKvyRdyq3Y70DH6zuc88iTWPs9tdGBGP8xTLUWwIRmX464/JCAS5g5ERhXLCVGXoJYGLI5efnFC6kVTepwEJ2hhvP+Be2Nxd0KTgZ+fRQHzO6gH4axTgRojLJhrrs0HM3GR/9s9vPNBLlzJ+lyS6ns/drArwGuuAzudQ/TBP8UkfgC0h4Kv3shdeYFs3mXCNA7QcSCJ3fxDCOiuZjBe4eCfgi5RWMZmgwUWdltvdaJ9dnrJaPWtXfrY8vnMjzF8jU9sBkSAjQXPjDWXArbh19NXr+t91V5x7WCYRG6dd0HErIAGxZa4L9SZhn7Cy3FcB2DW6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umYJMJz0jS5VV10aQWY9tNRpdpNcNX2gXczij81af8c=;
 b=AAix3zEaj59fi7q+ayixHeVuh+PgIDJUruM6KkkJNp23JIAkUsjgCMSG5+kYKrudePvHOAHbd5WWhGjMysGVQZMCrany6JnjqTnOGcOMW37z+k7bC2W/mwryiXqceiW07LuyRN4436fkeWgtHEwqUF+UKKjdtS2IXF0Oec1ig3wFgelXib1CdlYkuyTU5JPuor9G3vwcPE7aA9LqaQIy5K5EKEg4ZtIfr0E+5xoAQyz0wEsYVI9iXLpE7H64MAwGpYcQP+8RlOSfRaN3XQCrKe0+LoKRM5fTuUTmiyoX4UpoXQEBBo+/888zhReZyV9/w8F7guf0GBJIBorBp7vM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umYJMJz0jS5VV10aQWY9tNRpdpNcNX2gXczij81af8c=;
 b=pANpj40nvJFye/X3DeGTLnNa96mBJwduM0fGDaCHYj3slHqkEkbx6S0pSVpJ48FTFLAAnsf3WSMflcCMVdxOssuwKJ7EsfUqRboL4ykAsgIIgVnpxYBFzeN1kGel28rYdslmGfRbdIT58em8uSBvAAFLnACz/aMihrx4rkAcJz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB6671.namprd12.prod.outlook.com (2603:10b6:806:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 10:46:00 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8377.027; Wed, 29 Jan 2025
 10:46:00 +0000
Message-ID: <7ec53510-84cc-4f97-a7c8-8e10d388a0f1@amd.com>
Date: Wed, 29 Jan 2025 16:15:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] drm/amdgpu: Add helper funcs for jpeg devcoredump
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>
References: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
 <20250129084643.507727-3-sathishkumar.sundararaju@amd.com>
 <7ec91b45-2c09-4d90-9d8d-b8e1582c3f29@amd.com>
 <760a02eb-867e-413f-bf50-090a58d8926c@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <760a02eb-867e-413f-bf50-090a58d8926c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0251.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: 86dc29ee-c446-40ae-d4a1-08dd40521e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTN6VW1QNEVyRGQ5UDVyVzRKNkYzV3hJRTE3V01va0NIdmNBb0doUmFTa0tK?=
 =?utf-8?B?bUZiN1ljZ20zVUt0M2s5OWsxNzA2SGE3M3RERGErT1RaN1phQUZPTFEzZUp2?=
 =?utf-8?B?MWhwS256aXFsVlRoOEhWV2RmVFY2dE4vRURWeUc5dVNFVFVmQW02VkxDbFUr?=
 =?utf-8?B?cW5zTTB4QU02MXVDdEdLNXRwclhZMnRLNmtZc1dnTzd6SlpaUlFpVk53Z3Rs?=
 =?utf-8?B?NkJ3RmRzOUpKb0NCdEk4V1pMYkVROEV1NkFLQkVsdXBOaFJJWGFTQ1ZhbHV6?=
 =?utf-8?B?RmJobG9JUVZZM0d1eGh6elh3U242ZGlIcUVvdEt0b1V3S3k3VEV1U1M0MGh1?=
 =?utf-8?B?VXZLejFBRmpzeVNxdHpMZUZiRU9TRmZad3UyR1RIYW9scGM2aVJoL3J2OTUv?=
 =?utf-8?B?MUl0VXZkSlBVL296NnFqWUkvYjhNZy83ZStXWjFpaWNrMzY5QnExamZqQVFi?=
 =?utf-8?B?bnJMckxzSVl5dmE5WnpaVlB0NS9TTW8yZWdmbUtaU0JYSkM0WWNWYlpZTHZr?=
 =?utf-8?B?L3IxcHI2RFIyOHlPbXFURXBiYW56Q2V3MlYwaDg0czZOOG0zSldOK0R1ck81?=
 =?utf-8?B?Vk5LREd0NTFEcFFBc2VJVFE4Tm9Ga0FlRDZROGhsSFI3bktaMGlITEYvVDhI?=
 =?utf-8?B?M1NwWHlYeGpscDE1SytVRjJDaGFPdEJGMWhTN21XeVFETHI1QXZuWVNVZ0hV?=
 =?utf-8?B?RzdGNktCRXNsa0JjTTl0Zzd3Y3NkUU9rcTc1Yms4S0c4WkUrOEdKNzBwQTRS?=
 =?utf-8?B?eE9SUDRLL2lYMUp6TVJMTDZKZmhIMTFsbnRuR25Bdm5XeVNsWG5wWXk5YmxN?=
 =?utf-8?B?UTlDSFRSTFkrTFBCWnp6MFAwUi94NU9CamhKNkFMRWFyTzZXNWV1NHFOL2tM?=
 =?utf-8?B?Z0NCWFRDeUVXV0ZZRFM0QmkveU5raWtmUUo3N2NPSXJQK292NWMyOFZwR21P?=
 =?utf-8?B?d1RhWWg1dmE4Q3Q2VmIxRkhzYkNhUWsra05tNnFDMEFoNExMZDV2SGRmMEg4?=
 =?utf-8?B?dmEyZEsxNkVnUWZUZTJ3R0FTYzhUZVpwVU10eWlRZGdLRGVTMEI2Tm9UQUc4?=
 =?utf-8?B?WStYd1lzakZjUlpZU0Q0NXRIVGdrY1d4bXpCOXEwZ3FIaCtod1FSaTV2a3l6?=
 =?utf-8?B?VnI1N3hWYThJTVg2TVM5K012eGNUSkhwS3kweGRKb0haNkVTSW5OK1VZL2o4?=
 =?utf-8?B?OFN6d1Q3V2Jub2JrMEpneEtDejRWMHZRRXNnRk16VVNKYUxRcGRGVnFnck5Z?=
 =?utf-8?B?U0E5UGRCZC8wRmlDYXBZT2VueHp3YXM2STJLTzhGSVh0SERiMWhHZGVYZlN2?=
 =?utf-8?B?VXBicGkyL1J1Nmh0ZnBSTHp5UVowZ3h1aVozbkVUMFZyWUR6QkJHbG9UOVQw?=
 =?utf-8?B?elFWdTYxMVJUOG1Jem1lY0RYRWhLQ3hvNkdjNm8yd3VvdGQ1d0pXYU90OUxG?=
 =?utf-8?B?QWFPem82cTJ3eEZDQ2paUkg0TENvMGZ0MzljRHlIRzlOS05XdFFlMkl2TStM?=
 =?utf-8?B?M21nL2VjMk1jY3pQeXJkUEtyMFhGUFRONFZKNlZ1OFRpeWJZZzc2UXZuMFhS?=
 =?utf-8?B?MjhtQ1FUcHRxZTM1NjdOVkFybjNKQjFxU1ZJRTIyM3ZOcGNCelpEWDlKcG5N?=
 =?utf-8?B?RzNXS1R4N0kxbWpEU0NZVEZHZkZPVXJGRFZ4eGsxTXA0N2hkN2xsVnFjeGJZ?=
 =?utf-8?B?cm5TQUI0NkQ0T3R4bTRYYTluVzVLS1QzdHhMSUVQemkyTHh1VVA1V3BJa3BQ?=
 =?utf-8?B?TGlvYisySzVNbm50bEtHb0RvV0tkSGlHUzFCYS93di9YQ3BueENtWjlmd1NV?=
 =?utf-8?B?QmxENXRURmN4aTVpYStINXpQTkZhakRRQVpwV3VteEUrR2p4R3IvSEFUMTVl?=
 =?utf-8?Q?A/lxXdCWu3u3Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGZNSFNiVFBod1ZBazZzdFVOL0JsSzFBdUxvS2U2cFIzczJhUkVIZmU0MXI5?=
 =?utf-8?B?dENCKzhNcmZpK0l4ZDNwRHhxOTNIZW8wa09SSjdSNktFa0tQNTE0N3VDaVQ2?=
 =?utf-8?B?cm16bThZQTBnemM4cjhLRTE1N2kzSTY4THBJKytlQThwSm5EdllreGcvZlRH?=
 =?utf-8?B?ZVFVRWh0QW9WbzcyZkduM0xHZ1dIellSUXBLVVdpakVHYzgvM1JOeUt1YUEx?=
 =?utf-8?B?UHc2bFJEbE1BZTJ2N0I3QlkrTml0OEdkUGRUemRIMlZNdlBnQ3ZKcDZTaFRT?=
 =?utf-8?B?RkFwSWVvUWtYZ0MrNitvMElvcXB6RTZJT1JjM3FyQ1NJS3gvdjNXaU9FVDFN?=
 =?utf-8?B?ZGh2eVNRRUtNY2lJZDlUUXgwSjdhQU41TXRpb3FuelJtak5xWHZHSWFIVGNu?=
 =?utf-8?B?Tm40NGVxUUFENGFuaGlvMjJkYTN4YWJFdTY3ZWRFemUyMnp4Q3V1NXI1QzI4?=
 =?utf-8?B?OHUzQjE3SVN2TngvakNtdUdJR3FNTW0yTVVSNEFlUi84NVAwU25WSkxUdmtw?=
 =?utf-8?B?S3E2Uk8zTk01d1RwdkJPdndud0ZZaER4SDNNNmQ1OGN6aEdBLzFnbFgyT3Fh?=
 =?utf-8?B?QzV4dVBXRnFNbE4zbDNGeisxUUY5NDI1aXFmOU9hZHFrTEkvZldERk9mOUx1?=
 =?utf-8?B?VkovWE84dFhURk56Vi8xYjFseElWYnpBSGVycFpvcmJpUnFla21uNjF3MlhY?=
 =?utf-8?B?MXBRU1ZnRXJsc2tmTGVObUYyeTkwQjI1VTR6TXozRnNHeEhuUVNhd0xDZUNO?=
 =?utf-8?B?MktPRTdnNkNRblFXTjRMTklOMkJIOHVDNTdTTGRaN0F1WGtSc0RacE40alNp?=
 =?utf-8?B?Rnd3MW02NDNiajRYUzJZVVpnaU42Ky94M0E1SmxUeDhxNS83OVBLNlZ1Yk1q?=
 =?utf-8?B?TjJMbXh1R2FnNDJJNmxjN2Y1U2tKclY5aEdUdklDckh4amNROENDQ2ExcnBQ?=
 =?utf-8?B?SG5MVElaTnFVM0dPWmY3Z0ZvM0JaSFRqaE5EUEc2ME04RHlHKzJKZytMV1Nj?=
 =?utf-8?B?OGV4U1dUUFNPVHltM0l2Qjc0U2JkVWlZNjJDS1JQbTZPeEdYanlmZDlITWRa?=
 =?utf-8?B?d3ZKWTRGL0Izd3VyYVNzSnRZVnhwWkR3RFcyY2wzMkVWSDgrUUdFNEFMOWU2?=
 =?utf-8?B?Snh1T00yaE1VUDR3eXVvVHVNc2djUWpyT3F6U1U4N1ZTZllsa3BUbS9iNndW?=
 =?utf-8?B?dDNGMHpvVk9jV3gzSGVlOTJRV3ZDeVRFTkg0azkvRktuTlY1MDdvNlNXcG4v?=
 =?utf-8?B?WjhwakxmR0NzSEJkV0tsU0dSYTcwUGNWWVRPMjUvK052NFg5NHl0WThYbm9a?=
 =?utf-8?B?WFhmbWZoS0duMWtmanZHMmhzU3JNVHc0OEV5Sk0zNDBQWHBVcUFPZ1hYRnV2?=
 =?utf-8?B?Q0Z3dVRSbE8wOXN6Vld4VWZXeG1LVVVYZFh3M1VWc3ZLRkNDajRlcVRNbzJi?=
 =?utf-8?B?TllpaXJMY0Z0MWk1QllSU1B5MVVMRUs2UkVHL0s1TVFZZU9uNlJ1K2JOQ0xo?=
 =?utf-8?B?YzAxbUtURXdFNjlBZGRVZU1EcktHZjhuSDdQTzBYRE1JcDg5d3JnQ3VPUTZH?=
 =?utf-8?B?VnZ2TGM3UFh0QXQ5NjNyczdrdWhpZFIwL1lZRUw1NTcrUEJUa0x3Y1dXVTEz?=
 =?utf-8?B?TG9RaG51OFlaNEtmb3hDbm5uajZkbnFPYVQyZDA3ZmZQd01MQVByMUQ5cWti?=
 =?utf-8?B?Z0VaenZhU3JwclNxVjZuUTB5VU9iakdNVEo1UnE0SGxjTGJ5TlVMaFA1RjJp?=
 =?utf-8?B?YmhyR2VpUjJ2disrYWRhR1dJR1c1OUVsMURkWnRiL1JIWlJGbXlLLzFoRUxI?=
 =?utf-8?B?Z2dLUkpUcFlzTTRqM2ZRZG9JYXlCdTRCT05iaklubFNRZnNmUzBidlB6R01q?=
 =?utf-8?B?M1p1cUxDeVpkNnRFNFJCUGY5YXozSml3RngxMkhsN0x5Y25pSk5MckVuVWp2?=
 =?utf-8?B?RVJZQjcwNFo4UGJSVmc0OE5ocmNSanFEY3VGcTJtaDF1MEF2MU9SMWRJSEtp?=
 =?utf-8?B?eVhBLzM3VGlOZlI2aXFoY2FiZlR5QUtZWkFvYzNJN1JKZnY4VTZBWmJISVIy?=
 =?utf-8?B?QkVlS01ZNCtnU1MyMmJVaEVtRExhTlI4UU12bUpnUi9MTUhTYml6cU5VOGdY?=
 =?utf-8?Q?8PVZkMN0BGzVu+fpsZacy8yR6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86dc29ee-c446-40ae-d4a1-08dd40521e94
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 10:46:00.4563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4TJKj/W3z2ln02PZofawkmCorSt7w5NCneucRq6MFw+zzvNXm/qpCsfXj+oAlPN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6671
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



On 1/29/2025 3:51 PM, Sundararaju, Sathishkumar wrote:
> 
> 
> 
> On 1/29/2025 3:20 PM, Lazar, Lijo wrote:
>>
>> On 1/29/2025 2:16 PM, Sathishkumar S wrote:
>>> Add devcoredump helper functions that can be reused for all jpeg
>>> versions.
>>>
>>> V2: (Lijo)
>>>   - add amdgpu_jpeg_reg_dump_init() and amdgpu_jpeg_reg_dump_fini()
>>>   - use reg_list and reg_count from init() to dump and print registers
>>>   - memory allocation and freeing is moved to the init() and fini()
>>>
>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 80 ++++++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h | 10 +++
>>>   2 files changed, 90 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/
>>> drm/amd/amdgpu/amdgpu_jpeg.c
>>> index b6d2eb049f54..0f9d81e27973 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>> @@ -452,3 +452,83 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct
>>> amdgpu_device *adev)
>>>               device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
>>>       }
>>>   }
>>> +
>>> +int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
>>> +                   const struct amdgpu_hwip_reg_entry *reg, u32 count)
>>> +{
>>> +    adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * count,
>>> +                     sizeof(uint32_t), GFP_KERNEL);
>>> +    if (!adev->jpeg.ip_dump) {
>>> +        DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
>>> +        return -ENOMEM;
>>> +    }
>>> +    adev->jpeg.reg_list = reg;
>>> +    adev->jpeg.reg_count = count;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev)
>>> +{
>>> +    kfree(adev->jpeg.ip_dump);
>>> +    adev->jpeg.reg_list = NULL;
>>> +    adev->jpeg.reg_count = 0;
>>> +}
>>> +
>>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block)
>>> +{
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>> +    u32 inst_off, inst_id, is_powered;
>>> +    int i, j;
>>> +
>>> +    if (!adev->jpeg.ip_dump)
>>> +        return;
>>> +
>>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>>> +        if (adev->jpeg.harvest_config & (1 << i))
>>> +            continue;
>>> +
>>> +        inst_id = GET_INST(JPEG, i);
>>> +        inst_off = i * adev->jpeg.reg_count;
>>> +        /* check power status from UVD_JPEG_POWER_STATUS */
>>> +        adev->jpeg.ip_dump[inst_off] =
>>> +            RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev->jpeg.reg_list[0],
>>> +                               inst_id));
>>> +        is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>>> +
>>> +        if (is_powered)
>>> +            for (j = 1; j < adev->jpeg.reg_count; j++)
>>> +                adev->jpeg.ip_dump[inst_off + j] =
>>> +                    RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev-
>>> >jpeg.reg_list[j],
>>> +                                       inst_id));
>>> +    }
>>> +}
>>> +
>>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block,
>>> struct drm_printer *p)
>>> +{
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>> +    u32 inst_off, is_powered;
>>> +    int i, j;
>>> +
>>> +    if (!adev->jpeg.ip_dump)
>>> +        return;
>>> +
>>> +    drm_printf(p, "num_instances:%d\n", adev->jpeg.num_jpeg_inst);
>>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
>>> +        if (adev->jpeg.harvest_config & (1 << i)) {
>>> +            drm_printf(p, "\nHarvested Instance:JPEG%d Skipping
>>> dump\n", i);
>>> +            continue;
>>> +        }
>>> +
>>> +        inst_off = i * adev->jpeg.reg_count;
>>> +        is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
>>> +
>>> +        if (is_powered) {
>>> +            drm_printf(p, "Active Instance:JPEG%d\n", i);
>>> +            for (j = 0; j < adev->jpeg.reg_count; j++)
>>> +                drm_printf(p, "%-50s \t 0x%08x\n", adev-
>>> >jpeg.reg_list[j].reg_name,
>>> +                       adev->jpeg.ip_dump[inst_off + j]);
>>> +        } else
>>> +            drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
>>> +    }
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/
>>> drm/amd/amdgpu/amdgpu_jpeg.h
>>> index eb2096dcf1a6..02886ec4466e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
>>> @@ -92,6 +92,8 @@
>>>           *adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;    \
>>>       } while (0)
>>>   +struct amdgpu_hwip_reg_entry;
>>> +
>>>   enum amdgpu_jpeg_caps {
>>>       AMDGPU_JPEG_RRMT_ENABLED,
>>>   };
>>> @@ -137,6 +139,9 @@ struct amdgpu_jpeg {
>>>       bool    indirect_sram;
>>>       uint32_t supported_reset;
>>>       uint32_t caps;
>>> +    u32 *ip_dump;
>>> +    u32 reg_count;
>>> +    const struct amdgpu_hwip_reg_entry *reg_list;
>>>   };
>>>   
>> Thanks, this is almost there. Personally, would still prefer something
>> like below and have an instance of this kept inside jpeg_inst (though I
>> see your point that jpeg_inst doesn't have an instance id and this will
>> also mean duplicating list pointer/num reg info in all instances).
> The multiple copies is one reason I am trying to avoid this approach,
> and we can still print only
> the affected instance registers in devcoredump in the future if support
> for it comes up.
>>
>> amdgpu_jpeg_reg_dump {
>>     u32 *ip_dump;
>>     u32 reg_count;
>>     const struct amdgpu_hwip_reg_entry *reg_list;
>> };
>>
>> Ignoring that -
> Thank you, would prefer to have single reference of the reg_list/
> reg_count and use inst_id.
>>
>> With the current way,
>>
>> amdgpu_jpeg_reg_dump_fini() may be called from within sw_fini(). Just
>> wanted to keep a wrapper fini() func to make sure all is cleaned up.
>> That would avoid calling this from every IP version.
> Can we have it the current way instead ? as few ip_versions do not
> support devcoredump yet and calling
> reg_dump_fini() for every ip version irrespective of the  support is
> redundant, if we add that in sw_fini().

Just add a check for reg_list being non-null and that should take care.
Then this doesn't need to be taken care when more IP versions are added.
Also kfree on NULL is harmless.

Thanks,
Lijo

>>
>> Apart from those, leaving it to Leo or someone else from JPEG to take a
>> look.
> Okay, thank you.
> 
> Regards,
> Sathish
>>
>> Regards,
>> LIjo
>>
>>>   int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
>>> @@ -161,5 +166,10 @@ int amdgpu_jpeg_psp_update_sram(struct
>>> amdgpu_device *adev, int inst_idx,
>>>   void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
>>>   int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
>>>   void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>>> +int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
>>> +                   const struct amdgpu_hwip_reg_entry *reg, u32 count);
>>> +void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev);
>>> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block);
>>> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block,
>>> struct drm_printer *p);
>>>     #endif /*__AMDGPU_JPEG_H__*/
> 

