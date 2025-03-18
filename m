Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A954AC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 09:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4057C10E0D0;
	Tue, 18 Mar 2025 09:09:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RKjsP6/j";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC4AB10E0D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 09:09:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EB6KuIlFKzLWpGSDxpEH/GA2C95B+nJy7ZzJKcOSu73kBE4YvCBcFr8eWo1DBi7xD5uf4ysafzEBpwK57dVXjom2VNOQHFhk1xJ9O/HpzukJGnUR1I4l/Lo5QweEmKGGrZIH+gBpVmz4tmDeoELcV7ivouJJFz1jXoXAfecFJS5cCCQwSibXvVj9PbPdV4R/+bsLpWZHjrOFtfTb1PSs8wclj8ZmzX9PqfN19l2AbSXEUgb+8Knve81eghQ7ItKVr9O8ZNEZO9P/N70JZsz5mZK+gJjEOXq4N9F1tPXHX2My+T5aLP8+Z1Dv58ZbDvjMb3pUkCnZfjM3pgM1hjPpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XN/S1v5qdFQmAj58D7iJSQ7cbIXivKOFcNoWFHZzPJ4=;
 b=Rz8C9TRK/DiTdI22+jFkCzfkgtm39vPN7m8UUWg4HqQrSLLsnh1M5tmvYgFG6Zl/A2nkm1j7JIw36Q/Lkvjr/sYPSudF7jCKNyuzayY6iki+viW7n3tQSFMfgQwlFTuVJsqRYLYQxv5TFiJNumTz7fSOZ9aq4l1uylj5I24giggKL46DePNEMdqdnNYRHt2qkWwB/IjTK7oyoPltIWuM7uoLmDFByYQUr8EjqKMFyhkOviTbJ2l+XUjdc3QX4MGjY25qB33TRhmAdOPg4t2IdnRwsn1jwM2NKgPKU+GEAao5nHMsC2BW+lO91wE2HJy3FMtwKxR2VFiNQt6pdJhmVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XN/S1v5qdFQmAj58D7iJSQ7cbIXivKOFcNoWFHZzPJ4=;
 b=RKjsP6/jRysZW/NTIWi9/xIJkm4ExcBFSi7JZveme2Fq28XcxTPsXzN6fI1ipfuAb1IfkRBerOhc6SFkwz79Uj7WB00glw/qCoMWccwEmgu4i8GM0Gtugy66GuNfI+xcAG8W6x44ngIsIOkdiTvD0Z49J7Q5wci0xTEa++3l11k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Tue, 18 Mar 2025 09:09:54 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:09:54 +0000
Message-ID: <85dec41c-9db0-442d-968a-461682fe608a@amd.com>
Date: Tue, 18 Mar 2025 14:39:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush
 implementation for SDMA
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 jiadong.zhu@amd.com
References: <20250305032520.1745117-1-jesse.zhang@amd.com>
 <20250305032520.1745117-3-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250305032520.1745117-3-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0199.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d923acd-28b6-4594-d824-08dd65fca59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTRmM2Q2QmJ6SzFNdW5kWG5TQlRhbVdSbmxIdnVzdmxTcTd5aEg5SzhsU3Ew?=
 =?utf-8?B?cVk3NUNrd0xLNXNvbHkyREJ6TFh1dHI5OThFUlBkZm9URmZQQUpZZGhyY3dC?=
 =?utf-8?B?K2pQSjk3Mlh1dmMzSjJsbW9kZW1Gc2xDVUV5LzRReTl1b0RTQXppRWFzUW5V?=
 =?utf-8?B?eDRmNGNRdkovNWZrZWkyVTZmMW1Gb0xFS2xlbVpUK3puN3grSTM0TURBNE9i?=
 =?utf-8?B?ZmduVVFiQmIveURXTHZVVjRiZERuQjZkN0F3aTRyOXo4eEJHaGpnU2hySjlD?=
 =?utf-8?B?Rk0zR3BLSWc5aGZOajlhRzhFcTJNNWNzdGllVXhEeXlCVGt4d1JoL3ZMRFE3?=
 =?utf-8?B?T3lVVGdOQUx3a1ArZ3N4M2pIWndiUnozQ1RlYTRlNEYraERjZVRrLy9haDNI?=
 =?utf-8?B?TnlPQnVQR1htSVVXVzF4QjZoUzBIdldFelRJQ01tMHRWS3o3dDl5dGpNSkly?=
 =?utf-8?B?dFF6T2pVanFVN2hneEpCbjU4YWZzNC9BM1lsKzZBaTFvaXBEOUQzNHluT0R1?=
 =?utf-8?B?MWJDWHZ0VjhsWHRzb1dzZGpBVnBuRTlNcHBQUmVhVE1sSWhBcmdpV2p5STky?=
 =?utf-8?B?Qml3bUFQNlN5UW9OeTdvREpWbzAya3VnTEpUbm9YeFUxOW9rU1lWYzNjd3li?=
 =?utf-8?B?TmduRmNuVjFYbGNFTTlmbHZqZXRKaHBzNko5dkt0bFlsVnQraHlUZG5sYjFq?=
 =?utf-8?B?TkJuekcxZzhTYU9qMlpwd0lvb0hqTWtPZmkxa3lSZmxPU01SWStJdGEvaXJK?=
 =?utf-8?B?b2RTWmR5YlZLcFJuQy9FTE9md2NRTzJLZmhQUXIrVzg0dTZBZUZGa04wdHc5?=
 =?utf-8?B?bVRuWmZHaWVONzJSNFVza1JjV0F5Z0ZWclNaamlCcnFGOVVzV1QrTURKdDJT?=
 =?utf-8?B?NGlMS3BjbmJQMHdOL09FcExkVWJEd2VaQVIvNzJJbGs5SzE4RVBDNTZ4L2Z3?=
 =?utf-8?B?aHdyNzhwaTJWM1dzbGwzeEROYXdGREFaa1llMFE1dXlXNmhnZDVXck5yelRx?=
 =?utf-8?B?dlZETG5ac24zTnZRRW42N08xYVNnL2F4UHpwSHVNRmJtQTF5MDRjS3NuT29S?=
 =?utf-8?B?cEFYN28xZlFZM3huOXZsdFpTN1ZXSlZhVXlva3RCSFpDUjFsSTE2ZzBDLy8r?=
 =?utf-8?B?YTlNcUl1NjBGVjJSS0tLaGx3dzhkRUdzQ2l5bk0rM2wvR09ZODlDYWxqbWFu?=
 =?utf-8?B?alRDbkdFR1BtN1Rlc2NVcGVPZCt1OSt5eXpsM1ZjQkJWVWVoWDJib09YSURV?=
 =?utf-8?B?czdEVkFKR280QzVLSjB1V0UxK3Uza0x5ZVE0dEh5NFBDbEVOdW41QjIyQThR?=
 =?utf-8?B?bkVIWUF0OFZwQkZianh3TERrQi90MFhTb2xmd3FhSXZTVUpuUjUxNSt6NFJp?=
 =?utf-8?B?d2ZCMVZaTnd3YmdGbDNMYjBiNlFGVWlwcEVUK2lUSHFiM2RCbXpqVzFyNk11?=
 =?utf-8?B?eGVDaDZFOUk1UXBLVk8xU1VCeUVaazFXMUlZWkMvUHNLbWNpWWVIdFVlMkpG?=
 =?utf-8?B?QjlFekxaNjkrd01BQ0g5cHUyMzJLandzVTZhZmVQMHhsVXJ3YmpjTVVBNUlh?=
 =?utf-8?B?Y2tYd1VNL1pMQW5sRFlva0hCODgrVFRFUlhaVmRmRHFKZFBKdEh1czJ0ZnZv?=
 =?utf-8?B?Vi9IWnNjSGNkWTZDVytWTEE4RVdCRThLQUM0S1hjRjdBclM1T0JSalFGSHgw?=
 =?utf-8?B?RU9icjJqVXZnem5kNVRQWFI1MTJ2eVJwWHVEOUE5T0ZvZFN2dUFIZGdXcHU0?=
 =?utf-8?B?SlFUUjRLVmp6amlDa0hTRDJpdUhRcDk1UDMzbGVhNWRmclE3U1pqMG5rR1NJ?=
 =?utf-8?B?VCtUbS9NUnFEUFE5U0hHa0lRRUNldmJOZ1hHR1dVVzlYVUNoZXlmd0oxK3NJ?=
 =?utf-8?Q?jh/rI9gbgZdTR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGpSOHVOUmJSYlh1Z3FYZ2MzNmV0ckxwaDgzbGJtTGh0UUVqYmE5WlFnOHNV?=
 =?utf-8?B?ajU5Y2dQVDZCQlBYSS81MCthS05Ca2dsV2hSMGhMcUF2bGZHSWloMU9IRlly?=
 =?utf-8?B?WGI2R09EYUJJcHJMY3FLeWdSZUp0eUgvTWFwZk15MWE5TVZJVEdGTm1vV1ph?=
 =?utf-8?B?d3NDbVpveEpSNWpFYWNrR1lBZFN2S3VCbk9qWFlBalRjcjc1SHBCdXc2Rmd6?=
 =?utf-8?B?VzJDSkZaeTh6aUFXOUlLNVRLb2R3K3ZMbm9Wbk04VmJ0NjdhanVrSXJwRFZJ?=
 =?utf-8?B?bFZ3S2ZYeWNKaHhKbTlWYUM1L0gzRTQ5QkNxZGNmb25yL1QzTy9JK3RrekxN?=
 =?utf-8?B?cFNRSkU1L3UrMzVxeTZMLzM0dmtvMzV4bCtUeXpuM1U3UVk5RkZXMTd0WmUv?=
 =?utf-8?B?ZHQzZzdXdm93VzFNaTZCVUc2cW1MYlIzSGp2Qm1kYTRVdHRkNk1CZXZoTy96?=
 =?utf-8?B?OUM3bXZDNEtCc0tjdEhLamFSZm03ditYUVNFa1BQcVUzYWVwU0I3ajBVcU43?=
 =?utf-8?B?cFpxTWZ3bFp1aktnQ1JUNHA2NEdzV0RSSVZLQ3dQcjMvaWhTNUc5WStrN2p5?=
 =?utf-8?B?cjR2NmZlNEZUZ0xONGtPTTJkMXNJcG5uWnZYV0FEZVRRWGxFc1lTUzdPY2Mx?=
 =?utf-8?B?ZjN6cjlhYlJqM0NUVExXSXczdVNOTnhEOGl1OE1kSHhtMGdad3g5NGVubnMv?=
 =?utf-8?B?SE5FR1l6aTEvbWlHQThyRzJkbHFxbG5PNHU4UlpkSlNhZHozdkpldHNCOXhR?=
 =?utf-8?B?bGdNUk43TjlMRm5qb2xZZ01XVjhpci9QYVdSMGxkcFdWRjllUHFOTFhCZUhC?=
 =?utf-8?B?RHcvaFF2aG43YUE1TER4L04vc2p4dkNSVHc5T2lhdzM0Q0pZMFlzMGJuckg2?=
 =?utf-8?B?bG03ODhHRzliZlRUSHZURTRaR0lDdzAxcHg5Wk1yYlM2MUwrWWVvY3N4Lzlx?=
 =?utf-8?B?Nzh6cjRQbCs5dkhva0dwdVgraXA3RDAzcWJIaWJRS1U4bnpDaUkwYmxwbkx2?=
 =?utf-8?B?b3ppYVdJN1BnQkJvTFVVczNxUlVUalBkY0NZRlM0Rk5nRWl0aUUxZWN1elhw?=
 =?utf-8?B?alRkaEsrQWl1R2Qrc3J1eHoraXBab08xb3dtajFMOFQwdEZySmVwNUZxclBl?=
 =?utf-8?B?TG5mdnZKdEJwK3E5K2RTRS9XOVczeGxjNjh5WXdIcWo3OW5LY0VQZ0o5TEFH?=
 =?utf-8?B?WmRlSWhZNWhxY1hFejRQSXh3QUVvd3JUUVc3RHlWTVREOUFrd1NQb1VaMW9V?=
 =?utf-8?B?cmZya3RTZHZsMGpMa3hQZHI1RWJKRTVLT2w1aFFxZlVWemZSSFpDVXdwNkZw?=
 =?utf-8?B?Z1c1SjNwS3hyN3dCd3BRdEZuSUpGamJnMmxyYytHWWROSlJmSTQySVZVemF0?=
 =?utf-8?B?LzhmMDlKM21GbHNUU3ppNEdhdmtOU1JqM3J4b0lMMWptbkxPLzVzU29mQ3hs?=
 =?utf-8?B?Wk8zM0ZFMkZqcy9qMC9WL2lJUkZxbDhTZjZLQVJJU1A0SzgzUk5sTnlMd2J6?=
 =?utf-8?B?RWdQZDNsSDRXR0o5MHNna3dCb2hqQUEzVzJtMVhENTVSY3M1SHV3SHcvQWxm?=
 =?utf-8?B?NDhhN1VlZ3RSMWRKSU1WWDNvckJ5S1o5bCswRXlnYmJrZWxpLzlkRDlHdER3?=
 =?utf-8?B?MlU0cjR2WnI4d2E5bmF4WEdXc0hnTHcrOGNoSGZOcHQwU2FYbFZyOXZzdWFI?=
 =?utf-8?B?b2hSWm9ZS01IN3h2bkNvbFV1YW01ZTJXd20wZmcxV0NrUkxiY2RhYzIrUjJH?=
 =?utf-8?B?ODQrYjVJUkNmdmxwNWpmNUFqWU05b2kzRTlBLzgvMTUzR2FNQlUveU8yQkMv?=
 =?utf-8?B?ZEVnYkFxU21nWSsyVFlPaUU4Q1dCdzQrOFZsdGFmN2VsWkdkNnZYK2MwZmVS?=
 =?utf-8?B?U3VOdFh6MkZiVnJ2U1luYmQ0SkdiQVRPNVpLaFpWR0czdmtBU21yS1M3S3Qz?=
 =?utf-8?B?ZlR2UW5lUElDVEJvUkdkSzVlTnoxRW5YVGxBdktmVEFBTU9hRDh4cEM1ZHVQ?=
 =?utf-8?B?OVJXNkFpVkFLMXVlaDFvaUl5L1o0am5rR1VaK2E2WUVGVFhaNVZhZE5Lc2I0?=
 =?utf-8?B?Z2FoSVpmSS9jOG9QNkd3ZmF0aUpQdDJyNVRTeVVTdWZsMWNZNUVDTUNnV29i?=
 =?utf-8?Q?uBGE3lEsh6XO3a/5xpBU6G0Lt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d923acd-28b6-4594-d824-08dd65fca59d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:09:54.5172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9P4NJJcMq3EV1gG12D3lfAlaLmsvnCJ2kbrfCbLRmy2oj81oO6PrSG/DnfJeq2C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
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



On 3/5/2025 8:55 AM, Jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> This commit updates the VM flush implementation for the SDMA engine.
> 
> - Added a new function `sdma_v4_4_2_get_invalidate_req` to construct the VM_INVALIDATE_ENG0_REQ
>   register value for the specified VMID and flush type. This function ensures that all relevant
>   page table cache levels (L1 PTEs, L2 PTEs, and L2 PDEs) are invalidated.
> 
> - Modified the `sdma_v4_4_2_ring_emit_vm_flush` function to use the new `sdma_v4_4_2_get_invalidate_req`
>   function. The updated function emits the necessary register writes and waits to perform a VM flush
>   for the specified VMID. It updates the PTB address registers and issues a VM invalidation request
>   using the specified VM invalidation engine.
> 
> - Included the necessary header file `gc/gc_9_0_sh_mask.h` to provide access to the required register
>   definitions.
> 
> v2: vm flush by the vm inalidation packet (Lijo)
> v3: code stle and define thh macro for the vm invalidation packet (Christian)
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 77 +++++++++++++++----
>  .../gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h | 55 +++++++++++++
>  2 files changed, 118 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index fd34dc138081..554e14b56c31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -31,6 +31,7 @@
>  #include "amdgpu_ucode.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_reset.h"
> +#include "gc/gc_9_0_sh_mask.h"
>  
>  #include "sdma/sdma_4_4_2_offset.h"
>  #include "sdma/sdma_4_4_2_sh_mask.h"
> @@ -1292,21 +1293,71 @@ static void sdma_v4_4_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
>  			       seq, 0xffffffff, 4);
>  }
>  
> -
> -/**
> - * sdma_v4_4_2_ring_emit_vm_flush - vm flush using sDMA
> +/*
> + * sdma_v4_4_2_get_invalidate_req - Construct the VM_INVALIDATE_ENG0_REQ register value
> + * @vmid: The VMID to invalidate
> + * @flush_type: The type of flush (0 = legacy, 1 = lightweight, 2 = heavyweight)
>   *
> - * @ring: amdgpu_ring pointer
> - * @vmid: vmid number to use
> - * @pd_addr: address
> + * This function constructs the VM_INVALIDATE_ENG0_REQ register value for the specified VMID
> + * and flush type. It ensures that all relevant page table cache levels (L1 PTEs, L2 PTEs, and
> + * L2 PDEs) are invalidated.
> + */
> +static uint32_t sdma_v4_4_2_get_invalidate_req(unsigned int vmid,
> +					uint32_t flush_type)
> +{
> +	u32 req = 0;
> +
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
> +			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
> +			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
> +
> +	return req;
> +}
> +
> +/*
> + * sdma_v4_4_2_ring_emit_vm_flush - Emit VM flush commands for SDMA
> + * @ring: The SDMA ring
> + * @vmid: The VMID to flush
> + * @pd_addr: The page directory address
>   *
> - * Update the page table base and flush the VM TLB
> - * using sDMA.
> + * This function emits the necessary register writes and waits to perform a VM flush for the
> + * specified VMID. It updates the PTB address registers and issues a VM invalidation request
> + * using the specified VM invalidation engine.
>   */
>  static void sdma_v4_4_2_ring_emit_vm_flush(struct amdgpu_ring *ring,
> -					 unsigned vmid, uint64_t pd_addr)
> +					    unsigned int vmid, uint64_t pd_addr)
>  {
> -	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
> +	struct amdgpu_device *adev = ring->adev;
> +	uint32_t req = sdma_v4_4_2_get_invalidate_req(vmid, 0);
> +	unsigned int eng = ring->vm_inv_eng;
> +	struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
> +
> +	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
> +                              (hub->ctx_addr_distance * vmid),
> +                              lower_32_bits(pd_addr));
> +
> +        amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
> +                              (hub->ctx_addr_distance * vmid),
> +                              upper_32_bits(pd_addr));
> +	/*
> +	 * Construct and emit the VM invalidation packet
> +	 */
> +	amdgpu_ring_write(ring,
> +		SDMA_PKT_VM_INVALIDATE_HEADER_OP(SDMA_OP_VM_INVALIDATE) |
> +		SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATE) |
> +		SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID(0x1f) |
> +		SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID(0x1f |
> +		SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID(eng)));
> +	amdgpu_ring_write(ring, VM_INVALIDATE_REQ_INVALIDATEREQ(req));
> +	amdgpu_ring_write(ring, 0);
> +	amdgpu_ring_write(ring, VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK(BIT(vmid)));
>  }
>  
>  static void sdma_v4_4_2_ring_emit_wreg(struct amdgpu_ring *ring,
> @@ -2115,8 +2166,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>  		3 + /* hdp invalidate */
>  		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
>  		/* sdma_v4_4_2_ring_emit_vm_flush */
> -		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
> -		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
> +		4 + 2 * 3 +
>  		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
>  	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
>  	.emit_ib = sdma_v4_4_2_ring_emit_ib,
> @@ -2148,8 +2198,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
>  		3 + /* hdp invalidate */
>  		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
>  		/* sdma_v4_4_2_ring_emit_vm_flush */
> -		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
> -		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
> +		4 + 2 * 3 +
>  		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
>  	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
>  	.emit_ib = sdma_v4_4_2_ring_emit_ib,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h b/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
> index 8de4ccce5e38..d3a72ffac04b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
> @@ -64,6 +64,9 @@
>  #define HEADER_BARRIER  5
>  #define SDMA_OP_AQL_COPY  0
>  #define SDMA_OP_AQL_BARRIER_OR  0
> +/* vm invalidation is only available for GC9.4.3/GC9.4.4/GC9.5.0 */
> +#define SDMA_OP_VM_INVALIDATE 8
> +#define SDMA_SUBOP_VM_INVALIDATE 4
>  
>  /*define for op field*/
>  #define SDMA_PKT_HEADER_op_offset 0
> @@ -3331,5 +3334,57 @@
>  #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_shift  0
>  #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_COMPLETION_SIGNAL_63_32(x) (((x) & SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_mask) << SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_shift)
>  
> +/*
> +** Definitions for SDMA_VM_INVALIDATION packet
> +*/
> +
> +/* Define for HEADER word (DW0) */
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_OP_OFFSET 0
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_OP_MASK 0x000000FF
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_OP_SHIFT 0
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_OP(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_OP_MASK) << SDMA_PKT_VM_INVALIDATE_HEADER_OP_SHIFT)
> +
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_OFFSET 8

This and below don't seem to follow the format definitions similar to
other packets. Suggest to keep the packet definition format consistent.

Thanks,
Lijo

> +#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_MASK 0x000000FF
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_SHIFT 8
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_MASK) << SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_SHIFT)
> +
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_OFFSET 16
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_MASK 0x0000001F
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_SHIFT 16
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_MASK) << SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_SHIFT)
> +
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_OFFSET 21
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_MASK 0x0000003E
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_SHIFT 21
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_MASK) << SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_SHIFT)
> +
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_OFFSET 26
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_MASK 0x0000007C
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_SHIFT 26
> +#define SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_MASK) << SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_SHIFT)
> +
> +/* Define for INVALIDATEREQ word (DW1) */
> +#define VM_INVALIDATE_REQ_INVALIDATEREQ_OFFSET 0
> +#define VM_INVALIDATE_REQ_INVALIDATEREQ_MASK 0xFFFFFFFF
> +#define VM_INVALIDATE_REQ_INVALIDATEREQ_SHIFT 0
> +#define VM_INVALIDATE_REQ_INVALIDATEREQ(x) (((x) & VM_INVALIDATE_REQ_INVALIDATEREQ_MASK) << VM_INVALIDATE_REQ_INVALIDATEREQ_SHIFT)
> +
> +/* Define for ADDRESSRANGELO word (DW2) */
> +#define VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_OFFSET 0
> +#define VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_MASK 0xFFFFFFFF
> +#define VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_SHIFT 0
> +#define VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO(x) (((x) & VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_MASK) << VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_SHIFT)
> +
> +/* Define for ADDRESSRANGEHI and INVALIDATEACK word (DW3) */
> +#define VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_OFFSET 0
> +#define VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_MASK 0x0000FFFF
> +#define VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_SHIFT 0
> +#define VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK(x) (((x) & VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_MASK) << VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_SHIFT)
> +
> +#define VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_OFFSET 16
> +#define VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_MASK 0x0000001F
> +#define VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_SHIFT 16
> +#define VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI(x) (((x) & VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_MASK) << VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_SHIFT)
>  
>  #endif /* __SDMA_PKT_OPEN_H_ */

