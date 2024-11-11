Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D58ED2E9E4
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 12:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B919C10E494;
	Mon, 11 Nov 2024 12:30:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mn7rHfAG";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28E8510E494
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 12:30:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7WgT7yyoPCGfUGZTpPmVerEihqBbpPsLO+uKmhZiG56QwzB2gat6L6ptv2UMRRocyAw0oBuPF9NJJWczE5ulyCclWTgkqkcfCtzV4pRnAJTnKDPbLBho/UiDjKhXPZuVfV6dHgLsG4ODjqgvTA4Oq2CVBUfhxjB33t4vpMMuG5M1rMOa9CSSN7VWiM/0Ggdft6YwycJN5oOmoKMXyJt3qzHAG+Yxr06xTpbJTkBFcoX5P8jwWvMMucZX1ioTCLfmjF35N2Vav/apheEZnXjqFeLlMlDQumD/dn2f8cwSGaddjezPhpHk9Chki+9YiafA/pOEfvX3LtznbEUxqyiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PrcfTgIPHG0cFehDlAsIQPN0E8dG+nMsQGp10k8ZbE=;
 b=JhBXy6unj9YgshOqBdsS8wm4BybWhaHBsy+PV+Ps3YiMekYdyRkw0BSiucTXd2REhl7XtVin0UyL5MsmfVsIX1iC+y74vP9iDogk0NONRSHTw9oAnrIFq6leGazYZBtsxWemTv00O583RkWUxLLmy5k4WFohdJDi+/xSi5F9zHR04JvNfpzd1gv1ERSqcdntpPghReyjAPzV8fS28uWemDvv+YIihgQxJOkXMIsICoL5FsMusiQSgEOizbW/6nV/pqBnT1E7cfFAgXqbOF/mv3TUmPjxk52hHkrcywV27tluZzQs0S30O4ibDxmXbWbTCTo3AUSiDGcBwyZT2Lf59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PrcfTgIPHG0cFehDlAsIQPN0E8dG+nMsQGp10k8ZbE=;
 b=mn7rHfAGgUMBWrkgLexBTy61GNw+ujZrtmtiYPHy/NVNVK9oYxygn6U+lPfHnwA855MIyy+PHRMliTZ8OXNVee400LqIdOpp/2NpdkeVEc91ByJoiL7mhJEPPOnBQ/ZocrXfYrZHvLU5zH9XdTJVLgLIvLfb1ljLYAkGbRW6Ylc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.27; Mon, 11 Nov 2024 12:30:32 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 12:30:32 +0000
Content-Type: multipart/alternative;
 boundary="------------Y1Bx66ht0slJFU6UkSNcrB0Q"
Message-ID: <5d4917f9-d3e6-404b-90ce-bc06650889ff@amd.com>
Date: Mon, 11 Nov 2024 07:30:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu: Add missing 'inst' parameter to VCN v4.0
 function interfaces
To: amd-gfx@lists.freedesktop.org
References: <20241111024612.1881727-1-srinivasan.shanmugam@amd.com>
 <20241111024612.1881727-5-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20241111024612.1881727-5-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: YT4PR01CA0393.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::26) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 76857ef8-9a02-47f8-73c0-08dd024ca25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTgwTFJoVW5jeFlxSkpBeTVKcHVjdmhyQzRLYURaNHBDa3lmQnlKQ3M5WHZu?=
 =?utf-8?B?VUF5QlJFdTJYRllZK2FzdTBQU1l5cndLVEl3dFVPTWEvZUQ1NmllSzNnWE45?=
 =?utf-8?B?UWU5UDEvdHRZcnVJZXpwZXg4c0FTMDJhLy9DWDJLVlBibVBYWHJMeEZQWW9L?=
 =?utf-8?B?Z3pSVmVabXNQQ3BNbXkvTjRYejdhL1JlU0w3U0x3TlpWdFgxT0ZmaDQ2cFVq?=
 =?utf-8?B?VFZSSE8yVDIwT2lxU2YwSkJQWXlHV0RpaUxzeHg0a2xZMk5KSG51T3lSUGpN?=
 =?utf-8?B?UTU2OEFxWnp3OUN2R1RVNVNFQVowVTNaOE9mbmRucHlWbjE5aXVqRXZhMnRa?=
 =?utf-8?B?UERDUnpkNnFuWUhDWGpsZ0w2enZkTUdTUWtoRFFFa3N0YVFXSW9tbURpY0du?=
 =?utf-8?B?TVhQWkVpVzNubk5rNmRrb3JhQ25rK3VjRUdjWm9LcmxwMXVuQnRyOTN6dlVt?=
 =?utf-8?B?NVpFTjdTbUtVY2FFM3Fxb2FFV2g4TlA2Q255TTJxQll4YVp2OEp4MVE1Tmgx?=
 =?utf-8?B?TjV2QW1kRDRzMVhpQllDaG9SRG4rSUM0Y0k0L2tXTGdzYkVNRWxBUG9rTWdl?=
 =?utf-8?B?aWdNNVhGbHJ4ZEVFMXdtSE8wT3RTdDNRQW9pT09VMTBMUWJLdEY0TkpaMTZY?=
 =?utf-8?B?cTUvUTVNRnZxMzdxTWI4Z2NKMFdJQmJaY1lveFQ0bTgwblFqVmhUa243S0RP?=
 =?utf-8?B?djFSdlR1YWlKdDBwaEZOeldWWFdXU0VST0lydlF5cElJVnIzT1dnc2I2Wmw0?=
 =?utf-8?B?Z3VnaG5lUllWYU5VOG54OTMwOVJTNjFBdGZhTFdUVjVwcDExVW1mcU5sT09H?=
 =?utf-8?B?VkFBaVMzMTdDVjBmenVhQjZMWlBDQlVEdVpSRnJyZWdmYkhFYjNJdmowYW8w?=
 =?utf-8?B?WW9MT3I0a2o0V291cjRhRmZTWlhEMGFJemZoaC9qTjFFUEpIL1M1N3dhWXUx?=
 =?utf-8?B?d3dnY2RWZHBTNE1zdkpQQUtWWU54aVBZY2d3a0xudVFJOElXQ1dCU0xQMU1U?=
 =?utf-8?B?V2lSQTBSaUE0Q05WdU1BcXJJcVJEc3lVYXFuaW5PY0Z0SHRvK1JvYzdCcERp?=
 =?utf-8?B?ZzVlUHNCT0U1YnBLN1hSd01NV1ZLRjQweG4xaTZPT0pEUWJSMms0dk52NG5B?=
 =?utf-8?B?cmNtQTV2Uk44NXZHaW9LL3RSNk51MjF2dll5bU9oMWptOEZqTDM1bDFaS2Uw?=
 =?utf-8?B?dzRzZVVobHVabkN4eVNERlF1LzRtUkYxbzVZVVA0N1oyVUhQN1VTbmxQZGF6?=
 =?utf-8?B?Yll1K1FGcW00VUozNThXTlZqRWwwemlCT0xEaXdvYTVBUnJ4UTBqSzUzblA1?=
 =?utf-8?B?cWo1VXhyUTRBc0oyV21ETmZwS2d5R1l6a3J3SDZkYjF1QjhSL3BKM01IdTU1?=
 =?utf-8?B?RUpmb3lZSFFpVEpmemJWNEVpK1M3N3d6bU1KeHFwZWtQVzFJVCtnU1NKcXkz?=
 =?utf-8?B?SDdZM2hUYnlwR0dCZzU2a215cjZoaUQ5VWMyci9XRTV0akR2N1JmTHFpM2FO?=
 =?utf-8?B?K3FpNWJrK1EyaTM0VHhubTJYUEpMTjhyT3dnVzV2WWo5VldxcU5sdmFORTQ4?=
 =?utf-8?B?R3paeVVPMDBlYVBxbWpLYnVIOVBLajExamVka3VjWTV3eUNabXprYlFLSHh0?=
 =?utf-8?B?dmJvVTIzOU93S1hBZUxOTjQwVGh3SStlc2lZdHgvZFpoZWN3dEc1TmNOeHU0?=
 =?utf-8?B?aU1PTGtxWklFbDRnbml1dDk3NnpvY0xhQ3doWkNZSllDRGpWUEV0eEN6NWNr?=
 =?utf-8?Q?9fEYEh4OK/tE+KYqwZ+A9AefTagqCHMi8EdEhxN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dklVS2l4NFEvdlg3cDM2dW1kTHdIRWNDT0UvVS9jblFDaWRhc2tCOHdlWDVk?=
 =?utf-8?B?NUYvWldkNXBzMEFFQXQrOHJ2Z2FpWHRRdStpT29xVU9SQjlOSnZPODBkN2Nz?=
 =?utf-8?B?VUoxOWVZSFpNcEZ5cXF6UzFhZGM5MlF2NHBFbDUxYWIrREZHS0VYNkNIRzBu?=
 =?utf-8?B?dlFhMGlZM1VqYi9oOElQVElwYWhhMGVBV3FwMjIyR3k1MmZkcFA4NGQrQS9y?=
 =?utf-8?B?Rjh6OUcrSWlHcHJybmpDczBpakM5NGFIZGRGS0ZBQTBqZU81Qk5RWkt1RzBa?=
 =?utf-8?B?cFloZVNwcVNYc3FUV1FCSjE5a0pKRDF2QnlVVExGbk5VclREUlI1Ny9hTXZR?=
 =?utf-8?B?U2dNQ29YSkhsTDBLRm92TmVaNW5iMWVZWVJzUFRBNGE1cU1Wa1ZqVDVGRUtN?=
 =?utf-8?B?alN4eFIrbHZHbjFIMHRBb2VEYUlpL1J2OFRPejhFVU53aFBHTEx6WFI1QjFG?=
 =?utf-8?B?U1NJWFBySUNhaW9zcnBWWndZNkd4LzZwVzQxQm9WRjFsWXFRWW1YQXBVVGRP?=
 =?utf-8?B?SHd2OXVRd2pQaXFzNm5xd0ZKQmRaclIzRm80eW10S2Z1NlExbWhFeDZETVha?=
 =?utf-8?B?dTIwMkFNYXExOGMyMjVxUGpiQUtzY2krbnZETVNOWVdxeVBJait4NUltaEZo?=
 =?utf-8?B?YUNHc1hzYjhMNDF0T24vcWMyc1JZbi9FYnhMRjJ6cUt2YlFsVENES3dwRjBE?=
 =?utf-8?B?SW5CYWlmczRlSXQxR2Q3Zkp2eURsakpwenRGRkEvRHlYamdmR2x2RXlHT1Vp?=
 =?utf-8?B?MXVxZzJCYWNQcE53d3BialowUHJIOFN2ZklDMnhDUm42OEI2NGQ1U2h2WE9N?=
 =?utf-8?B?WUdNZlpEb2hBenVSazlTVXRGQ3hTZ2wzTXVVUld1VDcxS2YvWGZJMkFMOU0r?=
 =?utf-8?B?QVJqTjduTklKQ1laYWRLOUlMaEhSb1hEcEN4VVN3ejBNTklMM0ZtOU9kalpW?=
 =?utf-8?B?ZmpxaDRCRHFSSnRndVFkTEdVMFM2amxBWFlJYlNRRXJmdnhWMGpTT2ZLcUFJ?=
 =?utf-8?B?TjBlMzJhL29EOXVpTW1XdUhzbmJ1aHhFUnluc05OaEcwQWszM0Q2SU9tYitP?=
 =?utf-8?B?eXk0SVNtcCs4bXpTTlRWZHFrbEdYVlB2WkFnajZjdXBtL3BYZVhSZXhQeWFy?=
 =?utf-8?B?anlhcjBvNnZ4VzZ4YlJMVVRKY2xMcHlJRy9iVjloL0F1L1pvRFpoR2dIRUpR?=
 =?utf-8?B?Uk5uNWc1NjZzcVdKbWJiSFBSblpXbGxvMG51UVFRbjVqR0hiMHYrRmhsNHNF?=
 =?utf-8?B?bzNnNmtpUUVjYSs5cGw3NUsxMXEzL25XbjAzMEtzTTVKNEduVmM1WUFxRzJZ?=
 =?utf-8?B?d3gzamFpR2UwVWtibnh2ZktFOGFzVm1yUmlhL3QrS2RPVXVuQ21nU0VGYmFO?=
 =?utf-8?B?WldZTDJ4NVh6QVZ3UjlRcCtZZjdPSW5Fd0UvU3hGdGcwL3dHTTJtRnhQZVVz?=
 =?utf-8?B?eENNUUZnWUJlN0svaVlKZG1OTjhBNFRHd3dPSXpTTlhIb2lDeVRnU0lqSDJk?=
 =?utf-8?B?dS9ydEhEMWxsZm4xUWxrYWlTRnhCUDU4RWloVVhMY1BYRGdSazgxOG9ZQ1lE?=
 =?utf-8?B?R1F0bWYrYXRRcUh3YzNlQVF6eXUwSVQvRE12cmwrNjlKOFBpSUVRVGM5eXNP?=
 =?utf-8?B?Mk53VkFvdkVwcEI5QkROMis5UW9QNlZ4WjdhVlh2U2Vkdi9OMWxxeFVwV3lJ?=
 =?utf-8?B?TXJWWWFydHpXbE0xUzBsSUFPSjhQaVNWZWNVb2VCKzc4S2pHK25CVEVoK2Zr?=
 =?utf-8?B?VXdsTUw4NGg1L2FmT2xmMmFJVHRyM1k2anhmSFdzc1N0QXRyT3lhbkdhQ2cx?=
 =?utf-8?B?RU9hVmo2d0tLT1R6MlpoR1llN0ZmQWs1Y3ZPNDVyYzZua3ZReVFzSVBpRUE0?=
 =?utf-8?B?ZVhkck9mS1JqWm9OMjYyZ2pkUTN0QldCK054WUVQQjRSUGllYVRzbW5UVG50?=
 =?utf-8?B?amRrbjdGTVhrUGlTZkVoTlFzU3BISkZpVXZPVVFYVHNnd0Fid3FRZUdWb0Uz?=
 =?utf-8?B?SVM1VEhjQWRnbnlTQnNIZ2Q3d0lwblg5dDlSdGpRRHdNd1BrZ2tvazJZcVhm?=
 =?utf-8?B?VjF3dkRBZ1JxTHo0L296c2NMU1VnTFpleVkxZUhTdW9SeTNxN2JzWDBlcEtQ?=
 =?utf-8?Q?lXur6eniCK83Y5qQ5ZAbbobXJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76857ef8-9a02-47f8-73c0-08dd024ca25e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 12:30:32.2634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1gJgWy/NJXNr8lUMCbYV0BRoXSCT9sXZiMeiColMG37TVrQKCwMJwJpe4GQ9ToFAW6mI9lT59U+VTu0hkfHeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472
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

--------------Y1Bx66ht0slJFU6UkSNcrB0Q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-11-10 21:46, Srinivasan Shanmugam wrote:
> This patch adds the missing parameter descriptors to the functions v4_0
> _start, _stop, _set_unified_ring_funcs, and _set_irq_funcs.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:1093: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_start'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:1551: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_stop'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:1939: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_set_unified_ring_funcs'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:2142: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_set_irq_funcs'
>
> Cc: Christian König<christian.koenig@amd.com>
> Cc: Alex Deucher<alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 5c3b718ebdfa..c42d1274bcc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1086,6 +1086,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>    * vcn_v4_0_start - VCN start
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: VCN instance index to be started
>    *
>    * Start VCN block
>    */
> @@ -1544,6 +1545,7 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>    * vcn_v4_0_stop - VCN stop
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: VCN instance index to be stopped
>    *
>    * Stop VCN block
>    */
> @@ -1932,6 +1934,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
>    * vcn_v4_0_set_unified_ring_funcs - set unified ring functions
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: instance of the VCN block for which to set the ring functions
>    *
>    * Set unified ring functions
>    */
> @@ -2135,6 +2138,7 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_ras_irq_funcs = {
>    * vcn_v4_0_set_irq_funcs - set VCN block interrupt irq functions
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: instance of the VCN block for which to set the IRQ functions
>    *
>    * Set VCN block interrupt irq functions
>    */
--------------Y1Bx66ht0slJFU6UkSNcrB0Q
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-11-10 21:46, Srinivasan
      Shanmugam wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241111024612.1881727-5-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">This patch adds the missing parameter descriptors to the functions v4_0
_start, _stop, _set_unified_ring_funcs, and _set_irq_funcs.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:1093: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_start'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:1551: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_stop'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:1939: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_set_unified_ring_funcs'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:2142: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_set_irq_funcs'

Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <div tabindex="0" aria-label="Message body" class="XbIp4 jmmB7 GNqVo allowTextSelection OuGoX" id="UniqueMessageBody_29">
      <div>
        <div>
          <div>
            <p><font size="3" face="Times New Roman"><span style="font-size:12pt;"><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody">Reviewed-by</span>:
                      Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="0" id="LPlnk671546">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></span></font></p>
          </div>
        </div>
      </div>
    </div>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20241111024612.1881727-5-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 5c3b718ebdfa..c42d1274bcc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1086,6 +1086,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
  * vcn_v4_0_start - VCN start
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index to be started
  *
  * Start VCN block
  */
@@ -1544,6 +1545,7 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  * vcn_v4_0_stop - VCN stop
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index to be stopped
  *
  * Stop VCN block
  */
@@ -1932,6 +1934,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
  * vcn_v4_0_set_unified_ring_funcs - set unified ring functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the ring functions
  *
  * Set unified ring functions
  */
@@ -2135,6 +2138,7 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_ras_irq_funcs = {
  * vcn_v4_0_set_irq_funcs - set VCN block interrupt irq functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the IRQ functions
  *
  * Set VCN block interrupt irq functions
  */
</pre>
    </blockquote>
  </body>
</html>

--------------Y1Bx66ht0slJFU6UkSNcrB0Q--
