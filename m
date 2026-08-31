Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243F2C624A5
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 15:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE2810E4C4;
	Mon, 31 Aug 2026 15:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eFoTpNXY";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9563110E4C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 15:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5pdqidNm7svGEGTI6WLHOUZ4hkz9fvcpGCmXPCmTbgsYmjdzNRBe5Z11YM/D69yTqLNW71CpB4JpH9A21ORm0GRPRCsSN8fe5rfgtalpP1c9wlbwdnNzBECl7NbirVT4ZBLUBLI4JU9srF8tq0zea92VH7z1Gf1gi/rNadKrViQU8/8rhvvSPJuMrsoFhIMbQE4LpYp6jw3YOfeFzku/CUunIvo9vJRPIEkiYpa+J7gnRmwkeSLyGIbQQAK4HGohDRaNwy3YaEuStQPflzRsicOxVkixTyoqzHp3KYY3u5G6R8Ufn4WDEbj6ib/ojxEKXCaTG7m0oUqdDR3v1TzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBW2HlwCCLqthzLCdzV8c+fwaLHap1OsnkAZRnZqpxs=;
 b=uk9asg7CsVP0WhD64/TuGmDi2V0qsjU0J21VemI4mwfh9aNX8ovg6DX04LYBJU0D6weOrPPbwLWKPLdMzB9VeyjST0x1X9GRpPzqkZf58Ni3eoXs3RZFZfRu7H/J33nfWMalGxzP1gF2xKfZxCIUSAWoroeRMGiyiOCiY5brKbzJQf/3iapog6cnCI1uynF0tz9kTJypaEV7i8PCIPPHT/9khnB6lsndf3XISMKwg+y2dyivUhO7lX4GorF5RC4fN79p8o93wB7rTl1RTaCjIS0WAJnwRnJQwsSiU2jdI2OtT4kY3Wf/6AXGAnJgsfktJw+KNslN9lxOKcOusEpEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBW2HlwCCLqthzLCdzV8c+fwaLHap1OsnkAZRnZqpxs=;
 b=eFoTpNXYZq7BT8wic48y2CnKfWN/IF4tZjRQQOCYkp5ViJc6jD67pkUkTUIU3AAvd0NON8bbVjNQ/N0oIr7msHWD7ztkkxsRiVsj3UaCKHbqdgF2ODeiLzZ3tfjQdYGyg1Tiu/QMEkdw39HHknAc1cIVaNyQ38xvBsh23Z/F6aw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 15:22:30 +0000
Received: from IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de]) by IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 15:22:29 +0000
Message-ID: <031bfbe7-a141-4d59-8fe6-5fa82e1d5a97@amd.com>
Date: Mon, 31 Aug 2026 11:22:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: fix byte/dword unit mismatch in coredump
 IB dump
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Prosyak Vitaly <Vitaly.Prosyak@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260827163746.1085495-1-sunil.khatri@amd.com>
 <05f31596-69b2-498e-99b2-32c086698660@amd.com>
 <9b43b1a0-0184-4a05-be45-98d4a83eb302@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <9b43b1a0-0184-4a05-be45-98d4a83eb302@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0332.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::18) To IA1PR12MB8190.namprd12.prod.outlook.com
 (2603:10b6:208:3f2::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8190:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b30bf68-4c92-488c-a017-08df0773aba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|6133799003|3023799007|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aAznRkDHwD7QPxm73BQoRnMgd9kgZ8gO/o98alEK1PObs5jVrGDnk1ll+Zv1hrw2TiPw/qG5gxKqsN2RrzQX0OtcDaYFDRmnb4i7vOSEIiB7waHnJF0Aa+Od7a6qBkZ6howy4MAYmq16JPevGko1hRiUb31npR3nRv9cY98ly9o3uWfEIQrOVhyBa4yuIVYli5YUOOxpk65qItvx5HgEbZ4CAYr0lX1Q/WV3Z95SJ/hQl0BwCA7BABFvcs4XpoTYOLYzybb+oLl9wob07w0NvLuly2bn68FNoG5sug5X7/TKUdWayoNlm+udJ1YOMRojFWE4XUl/4/el8DP4RiMNz3xKUz3wlISeJptR8eVbi68wnLbAUNDIJVETsJF+KRzl56/B7P4LiOq4yidJQ/YT30lMvGc5+qsvdxqYhtj7vEwbx77T2P1e2GBjEyBvGuyIwjaA+t5lAbwfi1ZyiSE6Z6WLEbUrBaqL7YGvuTao31rFDWTKN4G5AOIQtRX+2j++xOnr59E5pbSrDp07k2dhfRF9YR9+JutvKNfUO0TM5kSawNclPqVGWCNChoUH0CCR+kMh+i+n6u0KK4BmSStNiuypY7WFT8f+0PfZF1dfgalSbvMDGAYm/Q+5Pj3iRl/1XKqmz83vtB5t9VoQPx+prkiar4QmdR8cIYYVq7YOTY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8190.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(3023799007)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWVMQ3pQaDBNaldJTTdYbGZraGNrbkhTeW9PbVdBblh5bmhOT3FXSUVERFlj?=
 =?utf-8?B?ZWJkaHJtb293b2FMTFRmNjdOUElaY0t1NEFXRWJVa3dzV21HcUs5Rk5UZUhs?=
 =?utf-8?B?Z2FsK0FKT0dsVGZQYy9BMHV4amNkdWd6c0oxUTZ1SnNRazU4UWNoaENGRHhR?=
 =?utf-8?B?eEpjQmdIeVoyNGxLNXp6ZzAweVpKUlBheXAwYTdhK3hLMlIzTFVEa2hDaHZq?=
 =?utf-8?B?VGNrNk9YbXRWM1dIRlNKOHFWbm1tSEFVVk01ZlMvZ1BhZzFNUlJaYWlRL3l5?=
 =?utf-8?B?d3BOcjdxWHc2YWExTHpYR2sxKy9leGx3N3BVKzVKdE55RnBoN1N0bTcvOWJl?=
 =?utf-8?B?UkxyUTJjajJZakNVZ3piT1J2NjFsNWdzd3NsUGJCZk42WGd4K1R3S1lqQ3dR?=
 =?utf-8?B?R25JbHI5SU1KVUNPeDk4QU1LR3Z0TXQ3VnRUTkNqWW01OVZDNUJZdkM0SjVZ?=
 =?utf-8?B?S01oNWx6NTNyVnlMY3Z5N0gyZEorZ3o0SVlKZ3FjMXNmc0JmRk1CdENicUc1?=
 =?utf-8?B?TDFoUnBMNXROUE0wOHIyakdhaG1UdUlPdjJKdCs3TEc5K29iY1pMQ1VmdHFD?=
 =?utf-8?B?VlRRWFdyTW5Ja0h0dVRDUU92ZE4vVE1KV3NFaGh3LytFZDBXVTJLUUpGeUJH?=
 =?utf-8?B?QkoxMlprUTZCVit3cFFKQ1FkazFnNmVNYjk5RTN5aldQdUhSVUZmc0RsY2Vs?=
 =?utf-8?B?Sm54c0FDdmVoemlNMXErSzVETFJESFZmc3J6dFUvbG12YzBZR3VDb2NPS0o2?=
 =?utf-8?B?aG5DSFRDM1hpeFo4UWd6aWtqYkl6WEpJK2NpWWlPVnI0TXUvZ0o5b0dFWWww?=
 =?utf-8?B?MDR6ZTl4czY4ZjNITVh3ZURDOG4vdHNvM0plYmF5U0JKaUYxY1I3dUlMRmN5?=
 =?utf-8?B?by8vSFRFVVlNVTVRV3hlOEk5T2hySFZIQXJiWnZkQ1RlTDh0a0ZtV20rS3lM?=
 =?utf-8?B?RGgxcUFkMUtTQUtRbHdPdGpHcXVJdmtNV3VyNzIvZnBnOWFOcVUzaW5yOTN0?=
 =?utf-8?B?UjMyVnFVNTI5eG4raEpISllpQnp4Ly80aHRINkVJNmdrVERibUQwNVJBYjRp?=
 =?utf-8?B?dVpEL3RUZlJsaXBPeHB6ZUFRdHpGMzRxRzIzV0pkaGlZQ3d1emh6RTlNTUtJ?=
 =?utf-8?B?SlFWWE9SV3RzenVHUDRsRVRzbzRiTGFVM2E5VTFod09WTVBXT3NxVE5ZV0NG?=
 =?utf-8?B?U3hYdVlNSTQzcnByN2lTSjJYdDdydDA5Q1RDVmdUOVZYOW45VVo4alMrRmx5?=
 =?utf-8?B?MFdWME03Y3hha2p6Z3FlYWlmQVkvcVBkdDlwN0N3NEpDZFhDRzkvM2Y2Z2gy?=
 =?utf-8?B?NHBDeGFUcWpRc1ZQb2xvSGlDWmlxUldLU3ZRanZrSzZ2YlBiZ2N5ZEJzeFpW?=
 =?utf-8?B?b3kwaWRhaUh6ekVyOWxZNGRsRm9Kbk5qM24xdDlldGtmMXNGVkRvTldLOHpI?=
 =?utf-8?B?OFBjMXowRDZFWlRyQ0FzaWN1UlNrNGJxU3RwbDJDRC84bVR4Ly9VNmJ3dlRE?=
 =?utf-8?B?cjNreXFaY3NkVmFVRWJDdTJEanpsWnBkeDVLMjRjMHpQYzVUNDlPbkVRRjln?=
 =?utf-8?B?R2NuMmpUT1VuUGgrUGs4RHE1eWl0Q3FKRkEwNU0ydG1GYmlYRFRaTVJLcWg1?=
 =?utf-8?B?U0xCTnJHVFJtNFVPU21UYmZUZG85S1NxcFIyMm8xc0dQbXVjWldsbFNlM0xX?=
 =?utf-8?B?Q3lqVzEvc01VOUFNajQ3NG1Ycy9jK3lvYzdoa1IwcmFDVUs2bzZQS1gyZ3Q4?=
 =?utf-8?B?dWVVUnhqcjZXaXhiVzhNZzNLbE5KemUyOHEzUTd4L1oxZXkvdDdNWVdoVXBk?=
 =?utf-8?B?N2pETDIvRy92eFJnWnpCUkxPMEdWM0JEQldwK09EQVR4Q2xZUjQ5OFNMRFZL?=
 =?utf-8?B?QS9SYklidWhKVDBtTkdTOEs2QytEWndMdXhheTE5SXFTb3pQTnRiVUxHWG1o?=
 =?utf-8?B?OW9aZmI1YURxVGFCWEZjcGxJeldIZVgwYmJHRWF3bEVJSjBrMUFPQUdkRXhM?=
 =?utf-8?B?bmw3K1JKVkk5RENTSXZvYy8wUmNIQWk4YjlJUlJRUVN0S3c5QTIzUEgzQkNq?=
 =?utf-8?B?WXF5QURYZGExWGhtL2NqQnNWWUlUbXkrTkVhY3dOWXhRVHByUExMU2h2ZlJt?=
 =?utf-8?B?Ni9KUEVwZnl3VEZCamZaRHJ4bGU1WjVBZE9TUVYyL1RPRC9pZlZ3SDJGelQ3?=
 =?utf-8?B?SnJqK0prQys1ODl2L0RjcmhkODYxVnlNV0cxYklxekpIYUFvQ2FXWURKa3FJ?=
 =?utf-8?B?ZHhnU1ZwZEhpdCswemJWU0c1Y21aVE0xNFE3UkVSVFJ6SHRlT2RiR2pKMVJt?=
 =?utf-8?B?U2dxVUpUOFZqYVQ5MzRnaU92eDhrUGIzaTN0WmJtaGVsWmJ3Ky83UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b30bf68-4c92-488c-a017-08df0773aba4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8190.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:22:29.5198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0qNoGzO+nZAkE1ZdmaiRTPGxE7wsotPTRs5at9lRzu1zJtn/5gZ88VrIWon6E9k33IjZRKDZxZnt49F40whrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441
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

LGTM, Reviewed-by  Vitaly Prosyak <vitaly.prosyak@amd.com>

On 2026-08-31 11:09, Khatri, Sunil wrote:
> Ping for review please.
>
> On 28-08-2026 01:55 pm, Khatri, Sunil wrote:
>> + pierre-eric
>>
>> On 27-08-2026 10:07 pm, Sunil Khatri wrote:
>>> In amdgpu_devcoredump_print_ibs(), the NO_CPU_ACCESS VRAM path passed
>>> cursor.start/4 and cursor.size/4 to amdgpu_device_mm_access(), but that
>>> function's pos/size parameters are byte offsets/lengths (confirmed by
>>> amdgpu_ttm_vram_mm_access() and leading to wrong size calculation.
>>>
>>> Similarly with that change the off index needs to be calculated
>>> based on dword since that is a u32 type.
>>>
>>> Fixes: 7b15fc2d1f1a ("drm/amdgpu: dump job ibs in the devcoredump")
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>> index 76771ad30c41..2d3fb87af00a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>> @@ -297,10 +297,10 @@ amdgpu_devcoredump_print_ibs(struct drm_printer 
>>> *p,
>>>               amdgpu_res_first(abo->tbo.resource, offset,
>>>                        coredump->ibs[i].ib_size_dw * 4, &cursor);
>>>               while (cursor.remaining) {
>>> -                amdgpu_device_mm_access(adev, cursor.start / 4,
>>> -                            &ib_content[off], cursor.size / 4,
>>> +                amdgpu_device_mm_access(adev, cursor.start,
>>> +                            &ib_content[off], cursor.size,
>>>                               false);
>>> -                off += cursor.size;
>>> +                off += cursor.size / 4;
>>>                   amdgpu_res_next(&cursor, cursor.size);
>>>               }
>>>               emit_content = true;
