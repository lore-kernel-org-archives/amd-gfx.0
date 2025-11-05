Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109D1CCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 13:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADE0910E746;
	Wed,  5 Nov 2025 13:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0EJj9YL7";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2B910E746
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 13:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MK+hHrq0NPTNz9nqFyqLWxmSGUu8GDikMOt0z19pFLgrHwM2AZB2ULjD44w0bjTsW1azlg+Ow0WCGYSOF1YnF8o/TWx7oLSi+j/iZz1QT2rZDDoEZV52/havku7QBOAFvZqhIXGcH+9qtx07qYmoOE3iuQPhCi1xHZwt7mKXS24PRR0zUBKu1+S8eMsLHXW5NGI1TOTLyFUSEUAWV1Dw9tJbTFVtlBOWPUvS7h0GBG2z0j/84lerfuwq/JLjkKVEyDIu40eTj274zniAkAahVDYHDqKB2ENdd9CxUfS2p6pS8SvkRPXVzyAAXObR6ce3ViZcg91fJ8S3eLvHdAZzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0slEhJAoqN4B1kGPIjg6r1MDQZvBzDneqhrAaq5AWY=;
 b=ja4rP7B1jqYyNNyT+ebvQF3h2xKS8KkYZJbzQNKxqCboEhLJhQLzGVuPFYIggAqki6xbYEHCkLJE/Idhozg4otWl2g0MudNXAxHtMtNFCdD1JCnFjZdKI3nFLWRv3qU9JhL3nIVQY42Xl3qeQVfn/oYN0eXieFXWHjKBf8Ip8bnr3MqNl1woplTIp443jyKHh03x1RMy9AhAAtZ2Nd1Tx4cPG+MTKloe1T2hitxkwhUN2tcmUhKs+ta+lOBAeP2sWHUbINqbzhjh3OGuALfyK37H2RzTWgmG518GKee2F7AxofvxB0J682Hkba2WK94sTddQvZRv8cdajDJYUYv/ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0slEhJAoqN4B1kGPIjg6r1MDQZvBzDneqhrAaq5AWY=;
 b=0EJj9YL7Hlr0nmmdomCDdOi3IhAr81rbWplqzsF5+RBHZNoFq7dhlXy2Fen9sqmDfu6M/Hj1TTOzv/4phtRmbey7ycRiKjjiH7lLsMJF4dTOkf9T3LLuivgwc+52CtPRU1AnhwPoXxIb6eKxyfauYO5a9X+5rlVxBzTVljD+3Rc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB999083.namprd12.prod.outlook.com (2603:10b6:806:49e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 13:40:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 13:40:46 +0000
Message-ID: <4532e586-e542-4e6c-bfcf-d81bb3b0ab4b@amd.com>
Date: Wed, 5 Nov 2025 14:40:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: attach tlb fence to the PTs update
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20251105121403.4154169-1-Prike.Liang@amd.com>
 <83602bd7-cf0b-4b74-8b64-48d16105de42@amd.com>
 <DS7PR12MB6005EF181DDD22DB86CE49C5FBC5A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005EF181DDD22DB86CE49C5FBC5A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:408:142::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB999083:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc1d96e-6fd1-46c7-c691-08de1c70ec76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWo5VHh4WGRRVnpZcDZWQ1h4blRrYStMc3VHYmlEOE10cFZJSFlvSnFRMHZh?=
 =?utf-8?B?bG9XSkxLY1R3RmQ1WkUyaUUzSkpKR2podk5xUTlPdTJIYk5Ga3pjcE9udVU1?=
 =?utf-8?B?VW1UbEhDbGFKZEdWdEJlZnFQOTlpS1hxQTNPNEN0Ykh1eUN4dEFmWG40TWNk?=
 =?utf-8?B?ZmxjU0hLaUZkN3luaThBa01TVFhWbkJSVmM3RVVOZTU2ZEpxZ3hSNUdSNlNh?=
 =?utf-8?B?V2EzNFFtSzZvTlB1akw3Wkk0K0pJaW5NY2IvVW5TK3lmblhGVDVLTlRINjJl?=
 =?utf-8?B?bXhINVZ3d3drMkYzYmdtZ1ZIQ2wwUzFadXhFblVHMnlKN05TV0pZRHk1RDYv?=
 =?utf-8?B?VWUzSEhhMFAzTUhFZjhPVVJIdFhSWFJuQjFNUWd6aFBUeG5CT1RXWXVvanpj?=
 =?utf-8?B?ZkRDYU9nRHJvTUhaQjJYRldTWXNpY2J6ZVpCbC9IRXdlT3l2bmlqQ0NtdUFN?=
 =?utf-8?B?UE5hVFRYUG91WVNBUzdjTHg0Zm0xQjVNV3JKTkcxeHV6aHdTTkU2ejdJY1BI?=
 =?utf-8?B?eWkxQWJoL3B2S01YK1MxZTE0a05BN2djQjBEcW11c3BZQUZGQ0lBeUxYTmdQ?=
 =?utf-8?B?UTErWmZ1RTVjQU1sOXFpWU9hRDRqbTltc2Y0aC9LcEUwYnI2RXllS0Q4a29D?=
 =?utf-8?B?QXB5MVMzcG9FV2U5dG8wRzRaU21nSlVlZ3hnM05EM0lkK1FzS3E5UG9KejFl?=
 =?utf-8?B?eWdyeUR0a2ozNTRGNDRZRHUrMkJnSW5lampkZHA0VkxoUHlNcnF6MDFIdHBj?=
 =?utf-8?B?Z0NFQXhzUlpyaWtRS0h3KzNoai90djE4MFA3Sy9kR3c5c1RwM3d2Z3BIQVRS?=
 =?utf-8?B?d09IOG5qV1lzUTF1TDQrM2w5dFlUR01qS3VJaWdWbXNUZkM0bnMwdVlJSEVX?=
 =?utf-8?B?VEcxRnIyRHE2Q2hhdm85TlN0UWR5N1VPTWpnTFhPZDRVY2h5aVVrNUxLZjQ4?=
 =?utf-8?B?TkNTZnZ3cERJZXNMQzAyRXpFbFJqVis5eTVaUXBGMFVuYStLYmdJcy9KYzh6?=
 =?utf-8?B?V0pERC9vTXRjS3hKcHhtbnNFWWp5Um9nNVhaT2F1akRnMVRialI5eWJyRC9J?=
 =?utf-8?B?TVZpTWNnbEFUSEJCTkV1WUVYZXFhZjFDTld6ejZFSEs0TWc1Nml6aGJyUmNq?=
 =?utf-8?B?bnJ4UVkwR21DbUlZa0ZucmhVQWxKWWhtQWZoSjc0aW5xTFkveFBTWGxOY2pN?=
 =?utf-8?B?VmUvNFVJWHg3NGJlUTRkNEhqOWRBVGtJcEs4Vkh5UkRxeHBheDdCVGkwZFRU?=
 =?utf-8?B?T0JKWnJwNFNSbTZGZWZIMzNEdUtyRjVSVUgxYmhRcnErd1FKU0g4dlVvK3BI?=
 =?utf-8?B?QUJ1RWZVTmI4WG53U1BoRnZXNEIra0pvZUhBSnBTR0l2Z3RuRFo0QkpiTXZK?=
 =?utf-8?B?WTZMa0grbmt6ZldaRGJRWTk1Ujh1a29sWHBKM004dC9GOSszWHVrNHFmWnJQ?=
 =?utf-8?B?eXRWMVlSN3lvUmgvVmFSejFNWCthWHpxWnByWnNCOFlHdHQwdkZETGJvR1V2?=
 =?utf-8?B?b0hsWWdJa1YzR1gzbGlPMlZ2ZGxlK1RwbWp1dmgyTkNFVHB3VDJQak1oR0JS?=
 =?utf-8?B?MkNtOWpEYlNzQUlTcmZocjVYd2ZOMWF5Z1FjS2xwMmM5RlBYUGJ6eVFKemRQ?=
 =?utf-8?B?OXNrVTRmbjJHaTJMV3ZocjVRUEYxSlhobE1XcU1kS1ZkdGoyMWNwTWh4MXla?=
 =?utf-8?B?TGFsZG9CbTg5ZlM5MExTYkgvOWtJNWIxbExqZHNhM3EvTVQzdTFjNmRpb2M1?=
 =?utf-8?B?aDFYNS9vMm5ZVzVqNFZhcnB2eFk5Zlk1SVlka3F5U0w4aEc3c1J0dklCSDBn?=
 =?utf-8?B?MGx3TmExV0FpTmFTeStWUGpjc3RDbVBnNGZIK2xtc1EwYVpFTzRJdTFVSVhO?=
 =?utf-8?B?NTVja1J3ZTgwOUw5SDRSV3NaYUljTi9ldkZkK1ZMZ05ZSS9seGt1eXQvc2FY?=
 =?utf-8?Q?R984Ek1Ech0uoQoy3McdR1rH5ijFzbQw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVBjYUIzaFVqMHlvSmtOMk1ZQVA2eHcrMlZSN3Vub3dsRFlMMXRVaWZQYXhx?=
 =?utf-8?B?YWx2aE1PcjdEcUR3OHQzeWtwaTdTVmFZUmtJZGFYelFlbEhNbnhFKzhrSEJB?=
 =?utf-8?B?SmVSZnVMZlZlU1VOSyswY2MrMExBMFk5NURYalUrdGVjZlBJUzNEODJRSVVU?=
 =?utf-8?B?cTJnbnVtSTNZbG5SYjNkcVc5VWtrL0pBTmFmZURzZTVPait5VW9DaFpoZCsw?=
 =?utf-8?B?cEtSNG9SdDR4R2duZDIzRXN4ei9LTjVXQWZRR0YvK0ZiWGloMFZBcVNOS21S?=
 =?utf-8?B?cENqclloVG9FWTNnUmRHek5rREc2RG52cVFCeCtIdGJoMXhlNUkyNG1ZclJZ?=
 =?utf-8?B?TUJsajMzcThtOWlnKzV2LzZqQmJLckgrVG81L2hyQ3V2eWRXWlRSV1lEMENX?=
 =?utf-8?B?cFZmc2dUYldaTEduVE1BaXhMTXFGbFM2T2Y0cXBtZ0s0ZEZQcjdzNC9abTU5?=
 =?utf-8?B?WFlTbTJ6eE94U2NsMFZGQUpNQkRuaEpOYVhwRXl4YW9uMmxxd2ZGOFJGbjBH?=
 =?utf-8?B?L3h5dFA4SXhkZ1lLRm9SNXVFSWNQZ3ZkZEE2dmR6VVhXbUdQUmxpMU02bXBE?=
 =?utf-8?B?cW0xZUQ5ZmhPOElPbXpOeHM1ZXF6T0RHQVFxR2pkdGs1M1I4bEU5VWlmMytp?=
 =?utf-8?B?YzFDeXZ5RU8yNkwwU0xQbVIranBlK1dwbjVrdE4xU1VHUnB0QVBzdlpoR1VB?=
 =?utf-8?B?YjEwcXpwS2pINVB1NEsrNkliYkxxQmtOSzcyKzUrdWVaQ1MrR2dhODBsTXNN?=
 =?utf-8?B?aUF4TE5EaU5Qc2RQSGZHZnhSYzBuVzNadWRINmtSckd4b0orMW52RHk4ay9l?=
 =?utf-8?B?RVFBZ09rUFo4c1doK1h0dnVYMXhTNTd6a0FPS2swWUZHYnp2RTZCbDQvOGlF?=
 =?utf-8?B?MGYwQU5PbENnNHZOeFE2Mm9DcjN3c0NVeVdzUkdTdFczWWwzZEpDNXJ2QjFV?=
 =?utf-8?B?SlZWSGlIL29NcG5tZVNDd29TV3FybmpwRDdVT1VhTzBGbStnZlJPM0cwUEV4?=
 =?utf-8?B?WEZQRU9CUjhxcG00eG42TkY4dUpmdjlITW10Y05kbTJPSXJtWjJWdEZKNEFr?=
 =?utf-8?B?UWxhdmJjS3dPQXgvcHFFOW1jNXNETmtkd21ubDJsa2JldGZORW81cUNTRXhS?=
 =?utf-8?B?V0VVdGVzOUhFOGc4d3BEeWR4UWFhSVI1RjRGNTh5Q2VzUEFReVpaZ0FZRkF0?=
 =?utf-8?B?R0M2T0VSS0U5VjBwUzgyNFlpM090RXNRMDJZV1dmNHR6Q2hORWhpYmRjWHZ2?=
 =?utf-8?B?aVEvcDRzOW1vUHBFNUQ5ZzdoSUl3RXArdDRsMS9GdTB1TjdHMG44clJNN0x4?=
 =?utf-8?B?dEh6L2ZpR2pzUXJmdnh3SldkSzJXTXZZV25BVzhkTTZjbm1Yd0V1UkFnL012?=
 =?utf-8?B?aktZczBRZjlNelR5akxEcDNJQ3QzZmZGeERzZXpuVjQyVFY0NlJUMG1tRXlD?=
 =?utf-8?B?eFhieFJPVnpRNm95cWtEUWFKaVpTYlptNFFEZUNxMk9LODEwQjVwa1Z1MFlW?=
 =?utf-8?B?L09OOFV0U1IvcEhWa2xPV21lSUFmM1VNTDRyQ1FxaXYyZlRvSXByOVpSdGRt?=
 =?utf-8?B?MGpNUFZib2JsalZUZDFhU1Vtd3JWVGJubTNEMEViOXlMT2kzYUNRVjZUbGdq?=
 =?utf-8?B?MDE4UFJNRCsyUHlyUjM2R3R2N2VFS3RGdS9ibkdVNUVBSG40Tlo5VXk3Z0M2?=
 =?utf-8?B?TVBXaDJudTZkQWcwOG52dm1QanVRQys0QStXdmt3cHhHVTlZVE1YRjN3ZldM?=
 =?utf-8?B?LzRlUnd2YjVSTFBoVk13ZEx5UXNJNHI1cEFwckoxQTFMZTBJQ3hvdEYxYkht?=
 =?utf-8?B?d25vOTFiWkY4T1lGSzh6TVRyWW43dWh2dkZobFpVNit6aEhPNjJoNmVFZHZO?=
 =?utf-8?B?Q1k2TktoYk1tSFVlWGFkTm13T1lZWGFTSXhyYXh3UzN2TUlobjlLcmpXSEk1?=
 =?utf-8?B?MEg2SWZkdEZhbkx1V2pjZ0lUUXg1ZzBzSGFKckp0M01PdEJCemcxa3VDL1Za?=
 =?utf-8?B?U2h3WnUrWE1rb1FFSG9OZXlocUdzZEJQTCs0aTBMNXFhSmFkdGxqV3huVWFH?=
 =?utf-8?B?OXFwclkyandwbFVzZkNybnBpV1Ywc2EzNkpQcWYvSW02KzEzdXVmM2VhQStu?=
 =?utf-8?Q?5ew6ECw2dK8kpEsUvQqQjve+d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc1d96e-6fd1-46c7-c691-08de1c70ec76
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 13:40:46.3804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4lzJOQnkGMwImnju2cbt8OSoXMkkJiWj77uv++JTU/Fg979bUuHbR9fa7J0qBui
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999083
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

On 11/5/25 14:38, Liang, Prike wrote:
> [Public]
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, November 5, 2025 8:50 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: attach tlb fence to the PTs update
>>
>>
>>
>> On 11/5/25 13:14, Prike Liang wrote:
>>> Ensure the userq TLB flush is emitted only after the VM update
>>> finishes and the PT BOs have been annotated with bookkeeping fences.
>>>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> Could be that people start to complain that this results in extra overhead, but that
>> shouldn't be much of an issue.
> If without sorting the userq or KFD compute context, maybe overhead on legacy kernel queue case?

Yes, starting a worker all the time is not that much overhead but checking all the VMIDs for the PASID is.

We could make it depend on the HW generation if that really becomes a problem.

Regards,
Christian.

> 
>> Regards,
>> Christian.
>>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index db66b4232de0..79d687dee877 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1062,7 +1062,7 @@ amdgpu_vm_tlb_flush(struct
>> amdgpu_vm_update_params *params,
>>>     }
>>>
>>>     /* Prepare a TLB flush fence to be attached to PTs */
>>> -   if (!params->unlocked && vm->is_compute_context) {
>>> +   if (!params->unlocked) {
>>>             amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>>>
>>>             /* Makes sure no PD/PT is freed before the flush */
> 

