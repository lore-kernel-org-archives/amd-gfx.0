Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C92AD65C58
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 15:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E1E10E5C4;
	Wed, 17 Dec 2025 15:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UPxqY1rB";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D77310E5C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 15:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksSJU1DC+ziVgtvXVYt7SiMqW6B1oy6gq+Xj8nLJDas3Np5CjDnaqI/V5oQO2XkVUIfmvsG/3m1l+MrCzEc60nuV5nzEsZbRttNPUtw9qPpxGjJwGSzqBq5hL8/NrkhUyONp/NU1TYkAbmvwCQto9Bwc31nVnldSiIGGPYoiLcO/0VMR1AjG3n3e5izeC2CIepSeSA5cWp7i3yH0TvpTAeRuNlAl+5wAau4plZ+Qyg8J7pa+YfdWd8/sBHBliDvJcBVFf3ZOM2m6b7RKf6kerXOVc9uEcC7CH31WON2HH8AX9VXcmi0YLPA5w8O9zb/z7UTAQun/MvACYjbYw2WuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01sWEsAeGxejvtWaPLcEJrDhq1Ump+lPaqM+7DhXY6c=;
 b=XCGeQxBtK1mGH7yFgC8A6kRWioBN1VUu9qhlZu7Ga6LiXgFh98+7socsKTk8LI6DSr7LWdRtM2lgGVKz2jMNe9vymZD8awA1vS2Dr/5+gZvF8oXlrqzPwGq2pyEH3a6AVIoqPFt/+rUuggu85VW0iVfsgjyDjsXCfF+mfwiBXX/3ajxz0tQeYPqntnAjyh8JBhY9O7qrh0Pyh/Vz5lL/vDy5Ur2zCjxvtb2ASB3rPDudbb7DmseeVRtSbYiWzzo+pWMqN6EiINh+9huBGudGTDuxn3UUcWzRhc0CCcOGldmomAxjf1dFPZBqFoPWbejBQdimpfug6WBQFh1ELWwtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01sWEsAeGxejvtWaPLcEJrDhq1Ump+lPaqM+7DhXY6c=;
 b=UPxqY1rBMniiJbNBSOk+ct14VZqgkvWSLzr7ghlzQm5x+Oc2Ymf/1TIIS7RRJghzA9fJMMffesK2SAy3P0PV8savEKCR1w35tw06RePj8ziRQXezPbnJEHrDJ9vOEaxVdlMR9xCoX3v78akspx/cFdDRpxkXCdQTw2cUeSv0bOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:06:55 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:06:55 +0000
Message-ID: <84a6dc2d-45bb-4f9f-a84d-47b8727485de@amd.com>
Date: Wed, 17 Dec 2025 10:06:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] drm/amdkfd: Map VRAM MQD on GART
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
 <20251215165630.1172383-7-Philip.Yang@amd.com>
 <c3415b20-da51-4aac-acf7-841fe9621b3d@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <c3415b20-da51-4aac-acf7-841fe9621b3d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::25) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4f0aeb-0318-44a7-4935-08de3d7dea9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c28xVzNvUzcwWmtiMER6blBwckNuVVpoSFBCeGJlbzN1T2R4SzZRWC9vK3h1?=
 =?utf-8?B?ZkVsME0yL1l4YmNkalF0ajZNOEN2TlZOT1JFci9Gcjc0bWduUnlHV2dHdkNI?=
 =?utf-8?B?VkEraU1nUkZjbWdKTUhxeU1JejFRUkl6MHBVd2NIaEtvRDFnUE9TVjRlVTNX?=
 =?utf-8?B?dlBmYzBvR3Q4RTFLOEVyREIwOElCQjRBRkJseWNFb2NROVptSWtGRjJIUDho?=
 =?utf-8?B?S0hYTmREQzA4QzFqVmNJTWxpSm9ZQy9keExxTU9WT1VmNkEzR2tnRmd0bEMx?=
 =?utf-8?B?dnBqZzFDVjExdkZmWHM1NHh6Y1piQVQ4UFFOMndzRkhIbEJhVzg5ZG16M2Nu?=
 =?utf-8?B?S3grTFcrMlVFRzJxWUg3QXV3elhTVXB6TmNKR24xZGxjUWVOaCs0NUJEOUpm?=
 =?utf-8?B?V3ZuMkY1WEY4QmNSQXpIdS94YUlFZVZmYWNMemlKamprLzBINlpIakgwV2Mz?=
 =?utf-8?B?RFBmSW5ER2RydVZyaXZmb283WlJrNlFObGJKWEJSSWVacnBzRy9pdGxZRkFo?=
 =?utf-8?B?a3hUTWQyZVVWaEVXWjFzd1BYQktBaWJWdDVNc3lBZnRCUWFKZ0pnUnBybk1X?=
 =?utf-8?B?SVZjbnVPK0lRdmFJMWRrQXhNZ0lQalFSdk10czBwb0pLcWd4K1lBMDM1U3Er?=
 =?utf-8?B?UHdwb0FuRU1yOGFzUEVkNUNaYk5PcEo5T2hRRmp5dUdpUGozVlQ2SnlXNEFy?=
 =?utf-8?B?ZW9RbjhmRjB6THNwdjFSak5oOVN0VG9UZzMzeUJ2eHV0WXpvVDZKZ281aTVQ?=
 =?utf-8?B?WXlLQkZ5cHh1OE9NM292d3BFeWpMQTl2bWZnbHBiM2xZTktleEg1YWxpUzdS?=
 =?utf-8?B?VCtuaDA0TVRveVdXbjE5b2RDakxzOUNCdStGVVpqN3drUGlRc1dKOFNUTm4z?=
 =?utf-8?B?TUhoajdWZURiVm53ZmtyMGVucTIrTXMvNmFEbWlZQkVjYy9CTGlWQjRLUnN3?=
 =?utf-8?B?V0dYNGpCSzliNVFRLzNkdVJjVXlWRlh2bW5vejRhaldHbkhTaWFPYmlOOVFi?=
 =?utf-8?B?QlFuYzhuZVBob0l1ZGs1S1l0aFpxdVNFSzI2MU85aVRkcm8xNS9LSVlNbDRD?=
 =?utf-8?B?QmI0aFhxMUhDSEpGbUQyaXNPdUFYZ3UrRFN0Ui9KYWNzS3F1bFFaTUlzY1gv?=
 =?utf-8?B?aFc1cXh0eUlyT2dxekJsajRsaEhBNDlrcHZ5ZWVXL1FiZTR4dmV1dUFSWHNa?=
 =?utf-8?B?L29sMlVtbVFTN2JIVG10RzBKQTd4UkczQVpNNkwxT3lQWndEOXpRcGdkTGdu?=
 =?utf-8?B?Y05LMHF4TkIxaUlJdEZ1L0hDbFhGUVlReEovM0RPcSswTVIwRmk4QXk1Z0dO?=
 =?utf-8?B?Z3ByUjhTeHdPZDI5cThKdlNBNTlQcDZ2SndVUzJuUWM5ZmZna01aNWYzQW1x?=
 =?utf-8?B?RDJmVWp0aXpRZm1CeDdwdHJtUHBuRlJsaTlBby9aL0RkTzdPcndWVC9QYm1s?=
 =?utf-8?B?WDZpWk11ZzNwYU9UOVFPcGFEZWxFZmVEMHRIdjFIV05VT3UrMk1tYktXZVNu?=
 =?utf-8?B?TXRCZjlwOS9ramgzUGhBUDYzeWxaYXlLblgrakRESEdLMzdGazNXT2hDNG5w?=
 =?utf-8?B?V0ZZWjRyRzJra3hmTXBlOXhVT2ZPQ1E3ejY5THFLMFdLTnNRZ2JudVFmMC9X?=
 =?utf-8?B?SWxHTFQzZmNkQXArMHY3QlFodm45bWtaZHBBUnpySmc1dTVCR3VickkvbzNR?=
 =?utf-8?B?UDFLZlUvQmJoaXpxQkN2VzkvVjhSc2t1Zi96NCs3N3FPZ29jYk1PWHJWNnU1?=
 =?utf-8?B?WkhFMFF2cWVtcEV2L0dQaFNmWHRBYUh1b2hlWGlXMGp6N3hNL3BVZVZwbXdV?=
 =?utf-8?B?dmRrUTd1eXFCZ2tlOVYzZ243NHdtRVZZTFAvQWdUbnJrbXNXZXZ1Umt6dUoz?=
 =?utf-8?B?dHVIS2liS21tcUxUVlM2ZHBiOXN4czVoN3YrekQ2VUVNTStNRlpFT1pmVFdN?=
 =?utf-8?Q?p1J5iHLTuMjlPZRaw5hcIh8ibdhAUNAS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VURBcGVjMU4xUnlMd2RoS2FpUkQxd1VTMFlZQUtnM24vbVJvTVZUM3Z1MldG?=
 =?utf-8?B?UDA0cXZwdGJubnBnRTk3RFlHQVo2TmVOSnFLVFEzcnFCY05KN3VXMXQ3QXFU?=
 =?utf-8?B?RTdCcjRJSVQ3ZDdpaitBUWJyQnIvenYxWUkrWDZ3M05HRFJSR3FoRDJpTGZY?=
 =?utf-8?B?bEN0NWJGSUJ2cld2T2s1eWVwZENNTWpyZVpIRFFaVkFROFNSQWRNV0hCbDdo?=
 =?utf-8?B?RUx2Z3lVWklBUFF4UG0wcG1odmlmdjNja1ZmK1hPN0ZzUG9nT2wvV0VWTU5R?=
 =?utf-8?B?Z2N0cVM3RDd0azZyazBxcXJ5S3ZrMnYxRFFkL0RBRHFESmpvN2tYd3FTeVQx?=
 =?utf-8?B?cHIydXpaZjV0b0E5U0hpSGNDQWZralRmbEVPSVROS0Z1ZTN1M3c5a1VoM05i?=
 =?utf-8?B?eGRLaWlpN0tVKzk5MXJseDltN25sZWZZMmNmdnhmaHZZbE9nUDJFK2t2N0Uv?=
 =?utf-8?B?aEJvMnB5c1R6MGhWbkV6aHF2dWE3UEFtbzhxQURsS1BEZVlZVTJIWW9JVDJl?=
 =?utf-8?B?dDVpam9mMXVKUTVhbEQwbXp6YUw3MlZ5c3NNZXgrVlppajRnUEhTdFdHbG1U?=
 =?utf-8?B?a0dGY1h2Nlo3VnlVTUZSeXBhL3d6UStLRExwUVhRK3NYY2E4SEJyVWgyZllN?=
 =?utf-8?B?cHVHUTI1eTJGaG1jbkI2c2gzV2lZTW5hT2lqazVKQnZzd294cDFTdFNwVURC?=
 =?utf-8?B?SkJXRjg5eXlGU2RWOE8rbTZOUzU0dUdTckUyUmM2NHZSWHk4eTZ1TmhneG1p?=
 =?utf-8?B?SDNudXdPQlViQ2pNdzR5UkIvSWJuendlQnJZMVZNRFlIczZKRzl2U1Y2NGY0?=
 =?utf-8?B?eFNvcEFJY1JUckNFbWJFWHhuRTNUWEFsU0hBVWdwNCtRanF5YnpVM04yUGdB?=
 =?utf-8?B?N2paVmtxQkdOc2E2M3JLMFJDVXIxSlYvSmhVaDhucU1lQ3VaOFhaR2VtTmRa?=
 =?utf-8?B?NG9DNHVPMCtrcFh5bTR1bEZGOHJZUWRBUUhQVUhibit4Zng0YUUyWUNQK20z?=
 =?utf-8?B?MTRGSVZIbFNKMnFYMXlOMlZTdkFCMTU0ME1mVFZkRW0yUnJjdUpxN2lPd1BO?=
 =?utf-8?B?TEpiV3pJbS9VSXkwZnBwTTFYUWx2UVg4UThVbE5KTVJHN1NMaGFLeFFSQ05n?=
 =?utf-8?B?VmgwTmZTUnNkWjAvOVlKVTg0aGJIdjZjQnEyb250anZaL1ludldEZzdBdFIr?=
 =?utf-8?B?UnJwMXIvUGhla0x6eXZHY1V2T2l0Skg3L0ZHcWlmQS9IWkV2eU0wQm9qUldK?=
 =?utf-8?B?TC9iZVBBNFhybi8vd0VqaVZqUlNmajYwUWhqRHAzRkRPWHVLOTd3SG4xcGJt?=
 =?utf-8?B?VHJmK0w5UWZpcFFtN2lPMmJOL3QwWktQOCs5RWVRWDBrcktBTEtwZEZMUkdG?=
 =?utf-8?B?TjJOOU01VGw3ejcreGV4ckJqSU4vdURnS1pmSjIyb2hHb2dtRGdOMW8rRjFn?=
 =?utf-8?B?Z2x5WnRzL3hYZDNuR3RuNTdnc0kxNWcyZjFKaDJ3a2FMTlEzU3FlVURYQiti?=
 =?utf-8?B?SCt4cENYeTNWZUEvdm5LVHFocHpuV1VRYm05TnlVaVlHY0x0NzFtRFdKZXFP?=
 =?utf-8?B?UHVaM2tId2lJOGFBWW1mVjM2RmJkSUpIZWtiV2UwWjZIcGtLc0NDU3lxVXFj?=
 =?utf-8?B?cm9OUGJxeFgwaW1xWnN6MnM2cFkxeEdrUll4aFlobzJXSlNQTlQzRzJLd05Q?=
 =?utf-8?B?Ky9WSUtXRk9QUHNvTHkwZlpmd0w5K1hNZGZkMWdNUXJycS8yNCt3aEZlUHVa?=
 =?utf-8?B?RisyNUpzSjJFN2VmeGNXWUdiUnI1bDFGZnlFOEhEZEhMdUNFR0Y1MXQ3VzF5?=
 =?utf-8?B?NXNqQUh4MWJrOE5oTitoRkJxWlRvR2dXYXBRMWM3dnh5TTZBanVOUC80SmhK?=
 =?utf-8?B?SjFrV1hTRXN3eU1FNWlCaWlkM0VtdjdwSEFuT1Z5OVBlZHVPWmpWeXZPaXpZ?=
 =?utf-8?B?bkltZmZkQ2FXVWM1VmRQMnUySFBxcktmbmNUakRLLzZQVGhXSTVNeXVDRUcr?=
 =?utf-8?B?VFFiWEUvS1haNHA0UzVVZVYwQTVLWWVvV2R3WEY4Ry9GY2pac05NbElKajRO?=
 =?utf-8?B?Vmc3aVVuZGR3em9oc1FUWkFCNXdDOGlJaCtsVVNzdkV5WVY5dmNYOGV1QzNS?=
 =?utf-8?Q?GAd8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4f0aeb-0318-44a7-4935-08de3d7dea9e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:06:55.1478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNweP71TGWh78ZU3tWoS0XVzSt6SbKK0P6rSLdvH4DDWTBfafh3cdhErkO0VNORs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095
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



On 2025-12-16 17:35, Chen, Xiaogang wrote:
>
>
> On 12/15/2025 10:56 AM, Philip Yang wrote:
>> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
>> to GART as mtype RW caching, to reduce queue switch latency
>>
>> Add GART mm_node to kfd mem obj to free the GART entries after
>> MQD mem obj is freed.
>>
>> Use resource cursor to handle VRAM resource which maybe on multiple
>> blocks and use cursor_gart to handle GART entries.
>>
>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 94 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  4 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 ++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>>   5 files changed, 109 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 4f8bc7f35cdc..d7bf96a7b6b2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -880,6 +880,67 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>>   	}
>>   }
>>   
>> +/*
>> + * Same function and MQD description from amdgpu_ttm_gart_bind_gfx9_mqd,
>> + * except this is for MQD on VRAM BO and use dynamic alloc GART entries.
>> + */
>> +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
>> +				struct ttm_buffer_object *tbo,
>> +				struct drm_mm_node *mm_node,
>> +				uint64_t flags)
>> +{
>> +	uint64_t total_pages;
>> +	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
>> +	uint64_t page_idx, pages_per_xcc;
>> +	struct amdgpu_res_cursor cursor_gart;
>> +	struct amdgpu_res_cursor cursor;
>> +	uint64_t ctrl_flags = flags;
>> +	int i;
>> +
>> +	total_pages = tbo->base.size >> PAGE_SHIFT;
>> +
>> +	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
>> +
>> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
>> +		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
>> +
>> +	pages_per_xcc = total_pages;
>> +	do_div(pages_per_xcc, num_xcc);
>> +
>> +	amdgpu_res_first(NULL, mm_node->start, total_pages, &cursor_gart);
> no need use cursor_gar. mm_node->start + n indicates where to update 
> gart page table.
yes, that is the last version, change to use resource cursor for both 
gart entries and VRAM pages
>> +	amdgpu_res_first(tbo->resource, 0, tbo->resource->size, &cursor);
>> +
>> +	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
>> +		u64 start_page;
>> +		u64 npages, n;
>> +		u64 pa;
>> +
>> +		start_page = cursor_gart.start;
>> +		pa = cursor.start + adev->vm_manager.vram_base_offset;
>> +		n = 1;
>> +		amdgpu_gart_map_vram_range(adev, pa, start_page, n,
>> +					   flags, NULL);
>> +
>> +		npages = pages_per_xcc - 1;
>> +		while (npages) {
>> +			amdgpu_res_next(&cursor_gart, n);
>> +			amdgpu_res_next(&cursor, n * PAGE_SIZE);
>> +
>> +			start_page = cursor_gart.start;
>> +			pa = cursor.start + adev->vm_manager.vram_base_offset;
>> +			n = min3(cursor.size / PAGE_SIZE, cursor_gart.size, npages);
>> +
>> +			amdgpu_gart_map_vram_range(adev, pa, start_page, n,
>> +						   ctrl_flags, NULL);
>> +
>> +			npages -= n;
>> +		}
>> +
>> +		amdgpu_res_next(&cursor_gart, n);
>> +		amdgpu_res_next(&cursor, n * PAGE_SIZE);
>> +	}
>> +}
>> +
>>   static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>   				 struct ttm_buffer_object *tbo,
>>   				 uint64_t flags)
>> @@ -1017,6 +1078,39 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
>> + *
>> + * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
>> + */
>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>> +				  struct drm_mm_node *mm_node,
>> +				  u64 *gpu_addr)
>> +{
>> +	struct ttm_buffer_object *bo = &abo->tbo;
>> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>> +	uint64_t flags;
>> +	int r;
>> +
>> +	/* Only for valid VRAM bo resource */
>> +	if (amdgpu_mem_type_to_domain(bo->resource->mem_type) !=
>> +	    AMDGPU_GEM_DOMAIN_VRAM)
>> +		return 0;
>> +
>> +	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr, mm_node,
>> +					 amdgpu_bo_ngpu_pages(abo), 0);
>> +	if (r)
>> +		return r;
>> +
>> +	/* compute PTE flags for this buffer object */
>> +	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
>> +	amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
>> +	amdgpu_gart_invalidate_tlb(adev);
>> +
>> +	*gpu_addr = mm_node->start << PAGE_SHIFT;
>> +	return 0;
>> +}
>> +
>>   /*
>>    * amdgpu_ttm_recover_gart - Rebind GTT pages
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 25640bed7dc9..9f07856433fd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -140,7 +140,6 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>>   
>>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>>   void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>> -
>>   int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>>   				 struct drm_mm_node *node,
>>   				 u64 num_pages,
>> @@ -191,6 +190,9 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>>   		       u64 k_job_id);
>>   
>>   int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>> +				  struct drm_mm_node *mm_node,
>> +				  u64 *gpu_addr);
>>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> index f78b249e1a41..edb72f4ef82d 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> @@ -225,6 +225,8 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
>>   	      struct kfd_mem_obj *mqd_mem_obj)
>>   {
>>   	if (mqd_mem_obj->mem) {
>> +		amdgpu_gtt_mgr_free_entries(&mm->dev->adev->mman.gtt_mgr,
>> +					    &mqd_mem_obj->mm_node);
>>   		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
>>   		kfree(mqd_mem_obj);
>>   	} else {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> index 14123e1a9716..5828220056bd 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> @@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>>   			kfree(mqd_mem_obj);
>>   			return NULL;
>>   		}
>> +
>> +		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
>> +						       &mqd_mem_obj->mm_node,
>> +						       &(mqd_mem_obj->gpu_addr));
>
> Here you create new drm_mm_node for gart page table entries. Before 
> that amdgpu_amdkfd_alloc_kernel_mem also creates gart page table 
> entries and drm_mm_node. Is there duplication or how do you handle the 
> entries/drm_mm_node from amdgpu_amdkfd_alloc_kernel_mem?
>
amdgpu_ttm_alloc_gart allocate GART entries for GTT domain only.

Regards,
Philip
>
> Regards
>
> Xiaogang
>
>> +		if (retval) {
>> +			amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
>> +			kfree(mqd_mem_obj);
>> +			return NULL;
>> +		}
>>   	} else {
>>   		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>>   				&mqd_mem_obj);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 06cd675c9e74..55738b30c2ec 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -253,6 +253,7 @@ struct kfd_mem_obj {
>>   	uint64_t gpu_addr;
>>   	uint32_t *cpu_ptr;
>>   	void *mem;
>> +	struct drm_mm_node mm_node;
>>   };
>>   
>>   struct kfd_vmid_info {

