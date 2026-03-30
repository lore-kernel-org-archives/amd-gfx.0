Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A3BFB3CE4
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 09:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08E6C10E4E7;
	Mon, 30 Mar 2026 09:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e1nGB+Hq";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D71E10E4E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 09:08:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nN7n+wEEUqR6+uBFl1pAfKvix4P9R+CaQc4W3vYthjmy1WmuMKktwdxtpbc5Ww0+2HVkn3PrEgLcV36faV3DFRi1LG0g9gIEDAYjHbdyA3RCLx2UmtvUbpsWBL/EDIJWCvIHI5LBYzUzGbq8n62zeNpyw7JhikwbGYRGKbNPw+MFO204GUbWLk+12JqXvl51xAUWQt7JjxoqlkY4Gx3QI9SCh6EsTntdQtLjD2Fp0cJfYY+qE5xDZ60VVN/YX1PlwVrCGKblrxBYLxN6NC+rlhgItaGDPgU1GYoLUxRUmsW6a/jhH9l7qfIhKotAnpSjJtKSL+38HOaKKFjjjdv3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7cS+sY6qPK461pSZAiM20qiWTNlccHv6E0g3FpfW2I=;
 b=dHsP5uDcCTbcAJb32ewBlq33jqT57DpTyBrx+FDTThlEpxjaaGFuE/eHj7XIGx9zrjeoI6Dui/C8IUjuf6i2agYRFz+Ybt5R1y6WxJWooi9xU2XqPZvUWuHbKhpp8DOIVXbG6UnAdCZGH6SDz2g9Iomrz4p84cy0dbdRK14T90O9ES1R8jLRh8oLZ5dCTQKqFesZumVpHcy7LZnO/3CLXQPACKk+W+lK9WqQ4RhIPg82aLr0yVdRJ2RZIQHfKf3hyJ42ybHYa5C59P8vgeXvmbdoL/6ZgoF6gMwVS0ieh/YnKzNP/DkOMt5oByp05fwVEpTAZT42w3FxTIK4ENjI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7cS+sY6qPK461pSZAiM20qiWTNlccHv6E0g3FpfW2I=;
 b=e1nGB+HqDvqzmleN/K7SSDoqYpZ2QBa1VIR+q7CbIvoQr66+bZFFXHgEefO6yuENkAx7GLC6WeqxGGyuPNmfpEiI3uRPaGXbNxqw7TeXbfb1eZGEGtF0Oe+oof1eWAkzPmtVMh8b0LxGUMhvBVHpacrK7hkiFIxOnAbcDiPV/ug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 09:08:18 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 09:08:18 +0000
Message-ID: <3233c098-481d-4805-8f50-4ad415f82ffb@amd.com>
Date: Mon, 30 Mar 2026 14:38:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Refactor reserved region allocation
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
 Feifei.Xu@amd.com
References: <20260326075412.1378411-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20260326075412.1378411-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0208.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b705367-1743-4146-3190-08de8e3be20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: MLMG024tWB+Yn4pLVd0DdiVqw6RN6XcCA+2I2owvhwC7v9VBFh0fgvdHs8OpF+FpV8SgFRNJO/x5vw7HiYCspX+DylXcOPEMyETr74OR2AF5273RmwKG9w91iFTxz6JL3w32ON7xj+KrHkB0rbdsZsBO3L/460WDk02lGZsnfW/gblp6rssqwE/7ZEh0N6Sy6mlpkI8FFn2oc7eQYCwL3kd8g4IVrsofA1HN89usGowVsXLaXnMff5DtuLrIHHvGQBpz8kkGz6oeba3IlndrX9i3vEJMfoZACNw4R6jU3WyUDrDdm0i5cfe5xUj6nTXYqh0tEXzJZhgNFP4EPwvPSLnvPFAzKXvoy8Kq+gbORI9IUIvvlclWV6HFZO1YSDLAUqP0CzW7Ec8sRKxwmttxCoPplrzwuGnxz0SmiZAsdNU8Gm3ilTRrZDm0LfNlvSbWsWePXghBVpR+IGaYRmdbBYohgQezPQb+Yz7r6/rYlAgAmFqVRLzqqNHc0tMjldUGoGiKI9ivdM7l7VELIQKGscUfYPqGaY9OTXBzwcxofMYIOioleuvKyW+Pd5sfIl/TtxznRpolYbAhF9x5Hkzr3ZrZ2K6iothwZ/GsazwXnvhqrw8cu6ZyNLrstrC8dvujeYDRJj802JC+revuS8SYFUJKEHP4o7X1g3WQIWGAm/fx481mXw73JzAY5bGITMw5txar7QoDYiprvTh7MslGwMS+1ODGGkjPr4IJgE9AuG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1Rrc2YwUWhUYTArVU1hSkJKRjJmUWNrOGZ3U0VUeGhLTlRpbHZXa2F0RWs5?=
 =?utf-8?B?a1prQVpoQ2VVMlZXMU03WGV1aEpibUJvZzNYVUVSS25tR3ExdmR3bSs4MkRH?=
 =?utf-8?B?QU9kUllSUFBlUkZvWjk3Qm1BNWQzOE1zU1QrQ0dPNUx4UklGTjcrK1pzeDBz?=
 =?utf-8?B?czRRajl4akszaHNpSytnMmhSR2FJZnMweFJHcGhvRWErUCtPM280OUsvZ1dv?=
 =?utf-8?B?T0xBRHpDajkxVnIyOHdtbkZzQW1DOFdhSUtqUmVLeThVYUxXakMxWVM1c3Ji?=
 =?utf-8?B?VUw4R2ZFU0I2N1NGQjBvZGMxYjVDTk05QkVjSGVCTjVRMXdYT2VOUW5Jcy9K?=
 =?utf-8?B?dEF3cVZCZ05OVER6VmkzRkt0bG9uS0gzVWlVK3R3VmZudjBYMEt3SVNlVisz?=
 =?utf-8?B?RGJBZitvS3AyZFYzTDk1VnBmU2JLRDlBYmVoc2RYczdPTFpBK2dEd1g4OHVG?=
 =?utf-8?B?TnFRcTc3SWxUcGxoTTZyMVplKzIzZ1lnaERzNzlhTnN3WmRwSk9udmxTaUFU?=
 =?utf-8?B?Qm9JakxMeHRRVGJBR09NaDdIUG5TSWY1UzY0NDBUVTVyK0VZQ3lQeno5OXN4?=
 =?utf-8?B?QnNEdkJ1YXJmdXkzV0JNSjM0bGN2eGlsd0d2eGZPZ0lRelRmUnNsUUo0NkNa?=
 =?utf-8?B?eUwvZ2xhV0NWT3FvRE92QzdpY2svbjlWQk5DLzJlWjc1ZjFMNlhuQm4yanNQ?=
 =?utf-8?B?NXV5MnRDTldTbXBKN05idi9RVVpiTmM4UGE3WStaUVpjQUt4Vm4yeitocUxS?=
 =?utf-8?B?ZWM5ZjlBM21rWHNKNWIycFVIbXNaQlpEaC8xUjIyL1R0MVJTdXU4UDlFbWdp?=
 =?utf-8?B?dEkreEMzOUtyVW1PWVZyZ0NuL0dvbDJxaTNldTBUaFpUZlB2QTdFa2p1cjhw?=
 =?utf-8?B?dHFSeUMxSnpVRlBVcHFFVXE1dm9tQVVFcEVYdS9COGluTHBvWjVndFlvVXFa?=
 =?utf-8?B?dUdDVUVuMFZkdkd4OTQ1b0ZXMS80dGdITkJUQW55S3VvaEVQVUZWMlNPNE5H?=
 =?utf-8?B?TVNOS0lBVEhkeUpsSjBFRmJlVFA2OWhMUkppVmZra3pURGlaSU1LaERrOUpS?=
 =?utf-8?B?RE8weXBCNm5qQ1ZEd08xRmJLVlNTY2ppYjRnVlZJd01HbzNxWXUzTm50enBR?=
 =?utf-8?B?bkFPWCtkejJmSk00OXJCYkdkR2ZsZkpLZEcyYWJZWjlqUlMxVC9jbGMyV1E3?=
 =?utf-8?B?azRZVmtMakNCS0pkaE8wWVZpbmZhNFhRYTRwc0hQS3puNUdobmF0NTNuMHA5?=
 =?utf-8?B?dTkvVzM2WER2T1p4N2xxZWhxSUJoUVVRVmJaTXdOYisyRGpSMmRNZ1hJZy9y?=
 =?utf-8?B?c3g3YnR4bFljYXFkRUdHZmw1Yk9ZRmNYcmh4ZVZlRFV6SnhTblczZUNZKzZ4?=
 =?utf-8?B?cnhoMG1oa1hzR0pOVXJqUVVoS0ZLVFBEZ0JHdVV0ZHQrTkE4UWFLbnV0cHlM?=
 =?utf-8?B?QWt2S1VZUyt0WTlxM1lSVSs2Ry9mQ1NDV1dIR1Y5ZjlkN3BlMUp4S3B2Njg1?=
 =?utf-8?B?ak9SWWRqazltNXNyaTkxZEViKzQzMnRNUGdYektvUURTSitsR0JxcmxydEdJ?=
 =?utf-8?B?RGRjdWZNNjdEbXZPcjBvbHEwM3ZUa1lScDQ2bGlPbDNEdDJ0R0tTa2ZBNzVT?=
 =?utf-8?B?VHJWRU5DRWlGYWREanQ2ZCtBa05WQWhWdUtXcnhQZS94SnZlZ0RKaVhyOGZJ?=
 =?utf-8?B?R0xLSHBiek5YNTVMTVZ5b1psUnh6MUpONnRHNklzRXZHM1B2MkFERWpvRFEr?=
 =?utf-8?B?WndjaHhjeStnelpOMFpzUlI2WDVuNnFoRWpRcXVUcklZQVpkc2JhODFLdGNG?=
 =?utf-8?B?L1B6MGd3aHR3K0hxR1BSM0VDNUZqTllHMWp3SWZQaU5VL3VKcXNBb0JPWmtq?=
 =?utf-8?B?K1daRTlqVlVOalhpcmNRcDlRRGpCVTNsRkQyZE56Rm80QmhCcjZaKzBqVDBP?=
 =?utf-8?B?WU5kNld4SG1qVm1xeFFNbTR3WEpTQ3ovNTNuazhxZzNKenRmWEgveVk4OUU0?=
 =?utf-8?B?TEtVVU9pek9TOVhTMUlNZUd0VjNOcFlRTmxZSHZ4VUNrUWd5Q0RFeWJjdTJU?=
 =?utf-8?B?cEhlbDRCQm52Mm9uQTZ1VDJlR3VDKzZ0YiswQmxPY05qZHpYTmxqd3FhaVlW?=
 =?utf-8?B?aHJLMVhlTXRFQzMrQlZGbTdvbWMwR2QyM29zRDlUVnJBTjlWOWl3ZktrSmls?=
 =?utf-8?B?bDVSZWJHZmQ1K2NSdldvdi9NQWVmVGVHUmFFQjY1ZWZRNi9BTzh2d0M2Q3VF?=
 =?utf-8?B?dExuekU1eGdRTFdSSStVVDRkVWN0aEdHTzdieTNqK2JDUWJ0Y3VITVZZRm5p?=
 =?utf-8?B?N3BiaXpzeWY2ZnBpejJMbi9rV1RpSWgyVXc0SHF2UW5CcHV5b1VxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b705367-1743-4146-3190-08de8e3be20e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 09:08:18.4103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVp6t/fcq2u/cjfSRb3S2GAzKVZ+AAJnYfe9ZNSwD1T4E0Qn1pqDvHJ2ZJx5swMq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909
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

<ping>

On 26-Mar-26 1:15 PM, Lijo Lazar wrote:
> Currently, multiple variables are maintained in memory manager for various reserved regions in VRAM.
> Such regions should not be allocated to other purposes. Instead of different variables, the series
> assigns unique ids to reserved regions and maintains an array of them inside memory manager.
> 
> Part-1: The first 9 patches of the series assigns unique ids and maintains them as an array of
> reserved regions inside memory manager.
> 
> Part-2: The last 5 patches of the series prefills reserve region data upfront in a consolidated
> function and then reserves them together in a simple loop. It doesn't fill info for all regions; the
> data for some regions could be still be filled in a scattered manner like from atom firmware tables
> or host driver tables. Also, there could be some regions like extended firmware regions which gets
> filled later during runtime and allocated later. They don't get allocated in the init stage as their
> size will be 0.
> 
> v1:
> 	Part-1
> v2:
> 	Part-1 + Part-2
> 	Rename functions/variable (Alex)
> 
> Lijo Lazar (14):
>    drm/amdgpu: Add reserved region ids
>    drm/amdgpu: Add stolen vga reserve-region
>    drm/amdgpu: Add extended stolen vga reserve-region
>    drm/amdgpu: Add stolen_reserved reserve-region
>    drm/amdgpu: Add fw_reserved reserve-region
>    drm/amdgpu: Add firmware extended reserve-region
>    drm/amdgpu: Add fw vram usage reserve-region
>    drm/amdgpu: Add host driver reserved-region
>    drm/amdgpu: Add memory training reserve-region
>    drm/amdgpu: Group filling reserve region details
>    drm/amdgpu: Add function to fill fw reserve region
>    drm/amdgpu: Add function to fill training region
>    drm/amdgpu: Move validation of reserve region info
>    drm/amdgpu: Consolidate reserve region allocations
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |   6 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |  18 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  23 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  13 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 362 ++++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  53 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  50 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   2 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   2 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   2 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |   2 -
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   4 +-
>   .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c |  16 +-
>   19 files changed, 256 insertions(+), 308 deletions(-)
> 

