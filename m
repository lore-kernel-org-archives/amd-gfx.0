Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A91C43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 21:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01CF310E27C;
	Mon,  6 Jul 2026 21:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1zY3ApHG";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B949810E27C
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 21:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IS08el+6BqZQ+sDhHEKKvUQwiswzPjLLQ3XAgeLnh+T+Rh18qZtBk0LbSuC6Y9oNxGM1Pi+vzqDfJsCArmofqpKJXknSnsjtU2YTENJy8tFIRODD2YF4f8aCsTfTH4Q0EqdHzCaCgquIhbGHnPwxxaonAev+MaGtaL7CdWvyPzmc84J2GsQgZ3rnOYN+Tv2qK6lkwhzXAUV6bAkCeNlUSFzneA2xwNCv0xoxoL/1jKs8+wYaO5AEqzaG6hr1uJr6lkeir8+tNG/sKebbjDdCV5LeG3opmoe2WwggssR/J+UJrb7Ob7XTbuIDSnJ+7AtGdlmfYneTxxrmwOhjscJ3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFzVrhrk+O2TnIhWUGttpAXaeFyFqNR75W/sC7Lz80U=;
 b=M7UV35tGCfBDvYC7eQrncA5WU8DgGtw5Yd5nEwiZpJkDTPbRaY8D5OTePZUGgXnKdlyqowjonVRP0/rcqDFi2bkQu0OV/BgKobBx2aZtUtuNuwQuoDUCBIXlTHRUbCF3ynLNyF2+3axu3FC4jbdu+AVUtXwOp/O8tQ075EhZLTyesoh7I7dcHHLcXwewk/3tGmnFAvIt9SbqbV8oD8E8i8OtlagCsdsaOM+tHKp4KT9Jt2N+Qnm5HLTN5BxlvS0g0IvdbN6dz10W1Vzkder/Z1GPADRwiSoUYlSgpF3I1iCVfpHjuUrhwsTHe63cD4XpZt3xg3vkEIJuRVjEG8RQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFzVrhrk+O2TnIhWUGttpAXaeFyFqNR75W/sC7Lz80U=;
 b=1zY3ApHGolvQRMqkc4pnCOHCv4aggJZPcH4K5V1alyiIa0VZ02kEBnNA3XC7DnPU+b6/D/WfI1tfnDAPqz3z6aefKMvFLQ4t8VI8zBQUW61/wbCLKVGfRj6oeeRlIzbERenGclfnanS3gldsTeJkNOtlrP46UKEvvE6PDl2IurE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 21:27:55 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 21:27:55 +0000
Content-Type: multipart/alternative;
 boundary="------------3vApjNYra8ol0v4pscS0O1B6"
Message-ID: <51657a60-6f2b-484e-a0a6-f0bdd6e2eee7@amd.com>
Date: Mon, 6 Jul 2026 17:27:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH
 6.0
From: Mukul Joshi <mukul.joshi@amd.com>
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, "Shetaia, Amir" <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "He, Siwei" <Siwei.He@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-12-timur.kristof@gmail.com>
 <BL3PR12MB6425244AF10CABCDF2A131D3EEF42@BL3PR12MB6425.namprd12.prod.outlook.com>
 <3281153.KVeVyVuyWN@timur-max>
 <BL3PR12MB6425480A86F7104104D58B0DEEF12@BL3PR12MB6425.namprd12.prod.outlook.com>
Content-Language: en-CA
In-Reply-To: <BL3PR12MB6425480A86F7104104D58B0DEEF12@BL3PR12MB6425.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR01CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::19) To BL3PR12MB6425.namprd12.prod.outlook.com
 (2603:10b6:208:3b4::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6425:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e63b2ce-70c4-40c2-3ea6-08dedba57140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|921020|8096899003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qrwN0qxIhobMx3h7KKOfg3YJ2zSTBNbdZyX46EN4qoZ0g5RoZP6GNyhUEETpKDR7cChwvrnPj4Qai5gelBWXQpxWFgy66AxBshmhR2dwRRcLNLYmc6PJ8x3fFtzQ51hYjfhYWn/5tnV3kZVUSGg6i7qqZOhjiegXg+NX91fbxX9iJrIGIfD9qmyct7K0ChqRB23OYoT8K3hESza77WA10lD6EcOYrnz3dSqycnX+9PEbRckAJdz7yIe8VgkiYGFxzqFXJRKlJo836qG53x41ZAvkwOoDuTNGf8bpkF7N2Fbyi5gYyTX4Mss+n+iac5eRRK0r42mx/LsBs6fzFLKm02ryYpY+xxhbcXwC3x2JY2tEKZ5InIN2a9Al4MsMts+rMi/GvChH72PNUZ1G6qQH2L7z7Wz1Jli82M9QxpmALmDPxtfq9ko5DE5fcxyB3n1u47pd70i62BEQs/EcyoSnVN2A4+jpsGWPo43V6pKuSd1UjE2g1BcJM1dThBJoVd/yKkzJk5lBY01Oz7yu8bXwbiWUoeVlvTYO8TwRFN61Jv0cUbjlHIe0XSwqWKA399wsAQkg3kmOoeEL9fl1MI+3DFnwOYrtu4xPTekyPudeB86pLVoYgHMMNZf8rnFFs//0jWMoYOMgUhc6u7CND3XO/NLBWFcbxISmXx0sdq0sqr9PIZh9s0fGkL43zMyBJ/Nk5v9TDjmbcVSDjNDTJ0TXeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(921020)(8096899003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0hGVTlCVlh4M1BEOURGd1dKUVB3TTV3NWJSclBpRUMwVmNtY0RyK0FveFFv?=
 =?utf-8?B?b1RzWDl1SXo3Mzh0cG81dmI0M3dXbHVCbXhJWVZUN0VpOVZuVVlTWk5TSGtk?=
 =?utf-8?B?cGMrOEdpWEZWN0NHWkNmeU5TbVRLRnd3em8rV3owUnRpWnpEcHpZSlNNT3h1?=
 =?utf-8?B?L2xqQ1VCZHpQS1ZJaUtsUnZrTHhqcXZEZ3lYLzFQT3lRQjAzYWFBNXJoVnNo?=
 =?utf-8?B?V1NCNHR3QTFGZ2NxT2c2RVJWcmFzZkRCY0tRZ3JhaHRiNkV5elhCV1A4SDNV?=
 =?utf-8?B?bWtVRE1DRFhqUk55dXdzYkR3N2YxNGw0UmtBUlp4N3VhaFlkTXovZHNYQnM0?=
 =?utf-8?B?QktnREJkWUxobmRTaFV6a3pCQUVzZUphQzJQUjJFOGZzSWswNURkZEt6UktN?=
 =?utf-8?B?ME9ra0RYTTRpMjhzUkZxTW94ZE9FMWo5UEZ2c2pDRXlDclBhRGtKN29PZXdX?=
 =?utf-8?B?OHFYd2pFT2pva2hJcWhCU2NvRWYvYkxLR2Rnd1U5eW1HLzUvWnFlaTNtNGg0?=
 =?utf-8?B?WFoydFBoMXVnZzZ4R3EvSllVNmhWMzVWRXBMN20rT3llNEVaeTdmVkhHbVVK?=
 =?utf-8?B?OHVSS0VjZnNCcDVyR3h1Y25veHkzSjVkVVNwM3lSM3BORm01WWJ1UDRPYVlP?=
 =?utf-8?B?d2FPK2VVbTJXRGdkNlBDZTlrcTc5TUN2QTBhb1k0aWJ2QzZLQ3pXU3pIZHl2?=
 =?utf-8?B?aHVxWTNuREdhM1R6RHdpREFwOTZIU1ByZk5HUTZkVGdNcHpGLzdKalhZWHF5?=
 =?utf-8?B?bjFFYmM3RkpSWXJFZUF3M1F2S0ZCa2xzazVjZUhvSFc1WlJ0eW9DNXpaL2k1?=
 =?utf-8?B?Zkd1SHdIUThrVFY2Q28yRG9OZ2M1Q2lnZmJ0bUVST25hdzM0V0lYOVpJSy9J?=
 =?utf-8?B?d21KRWFTdTNLQjJLTGVQUEpUQXAzNTBSWnJSeWc4dW1BZldRRDFVcE0ybWdS?=
 =?utf-8?B?bXEyeVp0bjN6UDl3VU9WUVZNWnVCR3dZVnhjOWhHdGpLcHVJblBEd0JLMEo0?=
 =?utf-8?B?T0o0eHo3d3dPWDVqVXhMeE1hcjcvMmZZQm1XOFhqbTVMZ0E0VzYxZFV1ejh3?=
 =?utf-8?B?YTIrcVIzeW5qSVV5TjBYcEY5TGlUd0cwMEVtRjJMQzlHSTBWdklkMkhzcHNJ?=
 =?utf-8?B?TUNDelZaRXVXdlJMT0JGRklCTGNaa2VOblJuOVVIalJYb2NBcmYyWHc1T2Jp?=
 =?utf-8?B?VlFPWFNnMjJuL1dvem1DUk5Zc2Rua0ovVWZ1RnRXcFdHM3JPK2dYZzQxMGNH?=
 =?utf-8?B?U3ZSQTVVUmNla0ZJZFlHbGhBcitwUlVONUQ5Sll0c3I4RFVNSjdsdnhFZzNF?=
 =?utf-8?B?VWVuUmNxMCtwRlp3QmRVWngxRExUckdIWEdqV3NHcXBUS3l3eWxxWU51cU8x?=
 =?utf-8?B?OTZJZFdnUXJJN3NmU0RtMWtleTFob0NQNkFwWXRENzZkQXE0V1J3eGwwcDQ2?=
 =?utf-8?B?NnI3M2R5cFlzcGRtUkIwanFQOG9rUW1Zall5WGZNWTBBaU5HQVBvUmNobWls?=
 =?utf-8?B?TWthNUtpWWFZZitEdVhSZkltdEE0RWNiMjkwTlppalMyamhCUERsb0h1U3h6?=
 =?utf-8?B?KzZjTkh5dWtJQUdVbGl1Y1lhWWZ6TGtHSzc5YzJmWXpLT0hScnZHRksxZW1s?=
 =?utf-8?B?b0xaMVNIT2owMlhZQjVFd0NjdXpheFJrT1JZaC9rQm9LYXhuYkhOVEVZNFJq?=
 =?utf-8?B?akROTFBtemNXNUFOYVlvaDNvQVdXOVVzWExobzUzRm01dlFGc1hTbkZqZ0xM?=
 =?utf-8?B?eXZhd0RnV1Q5N1BrVnB1N1ZRTENsdWhra0NYUlRnTDdqbE03bGhBUUdVNHZM?=
 =?utf-8?B?WWN6a2xvZUpzZmpjbFFUMXlXWmcvajdGMkZTRXF1NkZKcWUzaWRocm9LOGF2?=
 =?utf-8?B?MWQzVHJmUlBqSTlvNU5sRlNiY0UvR0owSnZsanY1c1ZhamUzRUE3czVtSkk0?=
 =?utf-8?B?dWtWL0lvb3BPYm9vdmxKdEVhYURPdTJvenA3aXMzMzVXWk5uaFpwRkF2N3VL?=
 =?utf-8?B?TWM4SzV5eGo0b29lUkN0VlFLTmt0SE44OXdWNUJLUXJsNytMaXRNOEsxRE56?=
 =?utf-8?B?SlV0cnVueHpkRnRFVzdiaW93MFNFMEZtdVNEU1EvUXFmWjY1ZDI3b05pSUhi?=
 =?utf-8?B?TUJsdytSVmduYzh0TXlwTlNSdndLTUg5R3NUUjkwdWc0RUV5ZVFKRG9KeDJR?=
 =?utf-8?B?VGFIdklsenhQalowUzVQNjUwWDNBTUovOVVvR0VETWdqNmNEaHZ5aEx1Zndy?=
 =?utf-8?B?ekN2bjEyUWhEZVFDM2FLVWJIMmpzTFhxWkd5TVk5ZEo3ZDM2a0VFdEdyR0Fz?=
 =?utf-8?B?ei85THJQaGtIMlhZakdnbWkzaDRmaHZ6UGpFalhNZUpFQUhmVmZ2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e63b2ce-70c4-40c2-3ea6-08dedba57140
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 21:27:55.2201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8+ngvNtyU+yBEPFBDojk+OqC/EuOPMooHm1RxqFJio5fxtoHHLQa78VT2pMwGxnTSQ3/wiL+JwKmxd92ODGbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012
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

--------------3vApjNYra8ol0v4pscS0O1B6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Timur,

For Navi3x, please make the similar change as I suggested for Navi4x to 
enable the doorbell path along with your
existing changes and use doorbell to clear the CAM entries.

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c 
b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index f89e5f40e1a5..a66e3073aed8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -199,7 +199,7 @@ static void nbio_v4_3_ih_doorbell_range(struct 
amdgpu_device *adev,
                 ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
S2A_DOORBELL_ENTRY_1_CTRL,
S2A_DOORBELL_PORT1_RANGE_SIZE,
-                                                 2);
+                                                 8);
                 ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,

Please let us know how it goes.

Thanks and regards,

Mukul


On 7/6/2026 2:04 PM, Joshi, Mukul wrote:
> AMD General
>
>> -----Original Message-----
>> From: Timur Kristóf<timur.kristof@gmail.com>
>> Sent: Friday, July 3, 2026 2:47 PM
>> To:amd-gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Natalie Vock<natalie.vock@gmx.de>; Shetaia,
>> Amir<Amir.Shetaia@amd.com>; Marek Olšák<maraeo@gmail.com>;
>> Limonciello, Mario<Mario.Limonciello@amd.com>; Tvrtko Ursulin
>> <tursulin@ursulin.net>; Kuehling, Felix<Felix.Kuehling@amd.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>; He, Siwei<Siwei.He@amd.com>; Yang, Philip
>> <Philip.Yang@amd.com>; Joshi, Mukul<Mukul.Joshi@amd.com>
>> Subject: Re: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry
>> CAM on IH 6.0
>>
>> On 2026. július 3., péntek 19:46:03 közép-európai nyári idő Joshi, Mukul
>> wrote:
>>> AMD General
>>>
>>>
>>>> -----Original Message-----
>>>> From: Timur Kristóf<timur.kristof@gmail.com>
>>>> Sent: Wednesday, July 1, 2026 12:17 PM
>>>> To:amd-gfx@lists.freedesktop.org; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Koenig, Christian
>>>> <Christian.Koenig@amd.com>; Natalie Vock<natalie.vock@gmx.de>;
>>>> Shetaia, Amir<Amir.Shetaia@amd.com>; Marek Olšák
>>>> <maraeo@gmail.com>; Limonciello, Mario<Mario.Limonciello@amd.com>;
>>>> Tvrtko Ursulin<tursulin@ursulin.net>; Kuehling, Felix
>>>> <Felix.Kuehling@amd.com>; Lazar, Lijo
>>> <Lijo.Lazar@amd.com>; He, Siwei<Siwei.He@amd.com>; Yang, Philip
>>>> <Philip.Yang@amd.com>; Joshi, Mukul<Mukul.Joshi@amd.com>
>>>> Cc: Timur Kristóf<timur.kristof@gmail.com>
>>>> Subject: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM
>>>> on IH
>>>> 6.0
>>>>
>>>>
>>>>
>>>> The doorbell is not working on Navi 31.
>>>> Use the IH_RETRY_CAM_ACK register.
>> Hi Mukul,
>>
>>> I think the doorbell path is not enabled for IH CAM so that’s probably
>>> the reason its not working.
>>> I think we need an update to the NBIO
>>> ih_doorbell_range() function to enable the doorbell path.
> Hi Timur,
>
>> Can you please be more specific and elaborate on what we need to do on the
>> NBIO
>> ih_doorbell_range() function?
> Through NBIO, we route the doorbell to the correct HW block.
> That is currently not enabled/done for the IH CAM doorbell.
> So, you basically need to enable it inside ih_doorbell_range() function.
>
>> Also, can you say which NBIO version is used
>> for for Navi 3 and Navi 4 GPUs?
>>
> Navi3 --> NBIO v4.3 (nbio_v4_3.c)
> Navi4 --> NBIO v6.3.1 (nbif_v6_3_1.c)
>
> I am working on the change that you need to enable the doorbell path for Navi4x first.
> Once that is working, I can send you a test patch for enabling it on Navi3x.
>
> Regards,
> Mukul
>
>
>>> Having said that, we intend to use doorbells on all ASICs to ack IH
>>> CAMs that support retry faults.
>> I'm OK with that, if the doorbell really works on these GPUs.
>>
>> Thanks & best regards,
>> Timur
>>
>>>
>>>>
>>>> Signed-off-by: Timur Kristóf<timur.kristof@gmail.com>
>>>> ---
>>>>
>>>>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 8 +++++++-
>>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>>
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>> index 65e5d21753f9..a97c85b0cb99 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>> @@ -307,6 +307,11 @@ static int ih_v6_0_enable_ring(struct
>>>> amdgpu_device *adev,
>>>>
>>>>        return 0;
>>>>
>>>>   }
>>>>
>>>>
>>>>
>>>> +static void ih_v6_0_retry_cam_ack(struct amdgpu_device *adev, u32
>>>> +cam_index) {
>>>> +     WREG32_SOC15(OSSSYS, 0, regIH_RETRY_CAM_ACK, cam_index); }
>>>> +
>>>>
>>>>   /**
>>>>
>>>>    * ih_v6_0_irq_init - init and enable the interrupt ring
>>>>    *
>>>>
>>>> @@ -807,7 +812,8 @@ static const struct amdgpu_ih_funcs
>>>> ih_v6_0_funcs = {
>>>>
>>>>        .get_wptr = ih_v6_0_get_wptr,
>>>>        .decode_iv = amdgpu_ih_decode_iv_helper,
>>>>        .decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>>>>
>>>> -     .set_rptr = ih_v6_0_set_rptr
>>>> +     .set_rptr = ih_v6_0_set_rptr,
>>>> +     .retry_cam_ack = ih_v6_0_retry_cam_ack,
>>>>
>>>>   };
>>>>
>>>>
>>>>
>>>>   static void ih_v6_0_set_interrupt_funcs(struct amdgpu_device *adev)
>>>>
>>>> --
>>>> 2.54.0
>>>
>>
>>
--------------3vApjNYra8ol0v4pscS0O1B6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font face="monospace">Hi Timur,</font></p>
    <font face="monospace">For Navi3x, please make the similar change as
      I suggested for Navi4x to enable the doorbell path along with your</font><br>
    <font face="monospace">existing changes and use doorbell to clear
      the CAM entries.</font>
    <p><font face="monospace">diff --git
        a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
        b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c<br>
        index f89e5f40e1a5..a66e3073aed8 100644<br>
        --- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c<br>
        +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c<br>
        @@ -199,7 +199,7 @@ static void
        nbio_v4_3_ih_doorbell_range(struct amdgpu_device *adev,<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ih_doorbell_range =
        REG_SET_FIELD(ih_doorbell_range,<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        S2A_DOORBELL_ENTRY_1_CTRL,<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        S2A_DOORBELL_PORT1_RANGE_SIZE,<br>
        -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;2);<br>
        +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;8);<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ih_doorbell_range =
        REG_SET_FIELD(ih_doorbell_range,<br>
        <br>
      </font></p>
    <p><font face="monospace">Please let us know how it goes.</font></p>
    <p><font face="monospace">Thanks and regards,</font></p>
    <p><font face="monospace">Mukul</font></p>
    <p><font face="monospace"><br>
      </font></p>
    <div class="moz-cite-prefix">On 7/6/2026 2:04 PM, Joshi, Mukul
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL3PR12MB6425480A86F7104104D58B0DEEF12@BL3PR12MB6425.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">AMD General

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: Timur Kristóf <a class="moz-txt-link-rfc2396E" href="mailto:timur.kristof@gmail.com">&lt;timur.kristof@gmail.com&gt;</a>
Sent: Friday, July 3, 2026 2:47 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander
<a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
<a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Natalie Vock <a class="moz-txt-link-rfc2396E" href="mailto:natalie.vock@gmx.de">&lt;natalie.vock@gmx.de&gt;</a>; Shetaia,
Amir <a class="moz-txt-link-rfc2396E" href="mailto:Amir.Shetaia@amd.com">&lt;Amir.Shetaia@amd.com&gt;</a>; Marek Olšák <a class="moz-txt-link-rfc2396E" href="mailto:maraeo@gmail.com">&lt;maraeo@gmail.com&gt;</a>;
Limonciello, Mario <a class="moz-txt-link-rfc2396E" href="mailto:Mario.Limonciello@amd.com">&lt;Mario.Limonciello@amd.com&gt;</a>; Tvrtko Ursulin
<a class="moz-txt-link-rfc2396E" href="mailto:tursulin@ursulin.net">&lt;tursulin@ursulin.net&gt;</a>; Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Lazar, Lijo
<a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com">&lt;Lijo.Lazar@amd.com&gt;</a>; He, Siwei <a class="moz-txt-link-rfc2396E" href="mailto:Siwei.He@amd.com">&lt;Siwei.He@amd.com&gt;</a>; Yang, Philip
<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Joshi, Mukul <a class="moz-txt-link-rfc2396E" href="mailto:Mukul.Joshi@amd.com">&lt;Mukul.Joshi@amd.com&gt;</a>
Subject: Re: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry
CAM on IH 6.0

On 2026. július 3., péntek 19:46:03 közép-európai nyári idő Joshi, Mukul
wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">AMD General


</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: Timur Kristóf <a class="moz-txt-link-rfc2396E" href="mailto:timur.kristof@gmail.com">&lt;timur.kristof@gmail.com&gt;</a>
Sent: Wednesday, July 1, 2026 12:17 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander
<a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
<a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Natalie Vock <a class="moz-txt-link-rfc2396E" href="mailto:natalie.vock@gmx.de">&lt;natalie.vock@gmx.de&gt;</a>;
Shetaia, Amir <a class="moz-txt-link-rfc2396E" href="mailto:Amir.Shetaia@amd.com">&lt;Amir.Shetaia@amd.com&gt;</a>; Marek Olšák
<a class="moz-txt-link-rfc2396E" href="mailto:maraeo@gmail.com">&lt;maraeo@gmail.com&gt;</a>; Limonciello, Mario <a class="moz-txt-link-rfc2396E" href="mailto:Mario.Limonciello@amd.com">&lt;Mario.Limonciello@amd.com&gt;</a>;
Tvrtko Ursulin <a class="moz-txt-link-rfc2396E" href="mailto:tursulin@ursulin.net">&lt;tursulin@ursulin.net&gt;</a>; Kuehling, Felix
<a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Lazar, Lijo
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre"><a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com">&lt;Lijo.Lazar@amd.com&gt;</a>; He, Siwei <a class="moz-txt-link-rfc2396E" href="mailto:Siwei.He@amd.com">&lt;Siwei.He@amd.com&gt;</a>; Yang, Philip
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre"><a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Joshi, Mukul <a class="moz-txt-link-rfc2396E" href="mailto:Mukul.Joshi@amd.com">&lt;Mukul.Joshi@amd.com&gt;</a>
Cc: Timur Kristóf <a class="moz-txt-link-rfc2396E" href="mailto:timur.kristof@gmail.com">&lt;timur.kristof@gmail.com&gt;</a>
Subject: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM
on IH
6.0



The doorbell is not working on Navi 31.
Use the IH_RETRY_CAM_ACK register.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Hi Mukul,

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">I think the doorbell path is not enabled for IH CAM so that’s probably
the reason its not working.
I think we need an update to the NBIO
ih_doorbell_range() function to enable the doorbell path.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">Hi Timur,

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Can you please be more specific and elaborate on what we need to do on the
NBIO
ih_doorbell_range() function?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Through NBIO, we route the doorbell to the correct HW block.
That is currently not enabled/done for the IH CAM doorbell.
So, you basically need to enable it inside ih_doorbell_range() function.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Also, can you say which NBIO version is used
for for Navi 3 and Navi 4 GPUs?

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">Navi3 --&gt; NBIO v4.3 (nbio_v4_3.c)
Navi4 --&gt; NBIO v6.3.1 (nbif_v6_3_1.c)

I am working on the change that you need to enable the doorbell path for Navi4x first.
Once that is working, I can send you a test patch for enabling it on Navi3x.

Regards,
Mukul


</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Having said that, we intend to use doorbells on all ASICs to ack IH
CAMs that support retry faults.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
I'm OK with that, if the doorbell really works on these GPUs.

Thanks &amp; best regards,
Timur

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">

Signed-off-by: Timur Kristóf <a class="moz-txt-link-rfc2396E" href="mailto:timur.kristof@gmail.com">&lt;timur.kristof@gmail.com&gt;</a>
---

 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 65e5d21753f9..a97c85b0cb99 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -307,6 +307,11 @@ static int ih_v6_0_enable_ring(struct
amdgpu_device *adev,

      return 0;

 }



+static void ih_v6_0_retry_cam_ack(struct amdgpu_device *adev, u32
+cam_index) {
+     WREG32_SOC15(OSSSYS, 0, regIH_RETRY_CAM_ACK, cam_index); }
+

 /**

  * ih_v6_0_irq_init - init and enable the interrupt ring
  *

@@ -807,7 +812,8 @@ static const struct amdgpu_ih_funcs
ih_v6_0_funcs = {

      .get_wptr = ih_v6_0_get_wptr,
      .decode_iv = amdgpu_ih_decode_iv_helper,
      .decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,

-     .set_rptr = ih_v6_0_set_rptr
+     .set_rptr = ih_v6_0_set_rptr,
+     .retry_cam_ack = ih_v6_0_retry_cam_ack,

 };



 static void ih_v6_0_set_interrupt_funcs(struct amdgpu_device *adev)

--
2.54.0
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">

</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">


</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------3vApjNYra8ol0v4pscS0O1B6--
