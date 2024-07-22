Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE7BC3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 06:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B3C110E33B;
	Mon, 22 Jul 2024 06:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S5Mv88cg";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72FA810E33B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 06:14:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCjqEn3GRZZTsJUxTSj6nX/xs+Lc/D5c/x9j6RhDt6vFL9SDWyL4fWr3j0aRWhGZ9N5gIH/ckIKv/ekPwHZ0DRRPBhW3pgI6BhQBiBI7626Mrg2KOKecuK3TaW43N8YCLvgKy33X9m2JOP4knrJjfUNCTBFMgelJ/gK7eEjcPLtWByhm0mYxotOlkHdTzcJ1YcZOL2kFBqzgeExzNX6pAGi0rkqf7vjYDmgouG9UMb+JDYnLof0wf/yZBBN/LJ2pfezNUOP4xnT/AUNPhcKGqCC7wuaI+ZkWoZC0ZjRBkdiKjD6hzcE/W2Xim4kAjDN+w7fGYH3rhcXyOMIUlDj/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VujEQsXcZSvqjJ+ziTwDkrSxZIAP1+8i3k/xgxDLnuU=;
 b=VlCdl/Pj0sj9sjpE8M2vXL9TRiQgnItF37m5EtdQJ0tNVIHTYG7HAs7iOGO/Uph0lrtzFiMqS2/d6odWjYZZoMoe7vVjRiSqVktpnpW+gMYZOnCbH0vUy8bBp9eVU93fvCiTcaC5Lg77o70B/ZQr0MidudoNlzU16egPCZWGbAMBgDYTKLWknLQMpVvvp85s8CqQjXYnF3oSevcwZfL4pJNiB7Uybf3VeW+vFVXG/RKIjCANqqCQ/9VV8z+3ThWIbkTmjPn74m8WlohbE/aPOb0UUfhOZj7YJIFoBpAU8K9C4cwZm/g1VDtPuyMFdAFU4QKOBQQPGkp/5FIyE4zUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VujEQsXcZSvqjJ+ziTwDkrSxZIAP1+8i3k/xgxDLnuU=;
 b=S5Mv88cgVe+2V0RKfCoD2E7cYzDKcj/QNqKff0oLcjQxiZN6qCtxYkQGV0zd4NUGFnKVFJ2lxUvEZIfKPVB0VCBRAuobCp33xBrbgvcqgcsOQvDhRStzp6wviB3W/iNA28lYdKqg6f2nWqN+M8VCPWjfcp9kxBGaWFa89dVD0ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 06:14:33 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 06:14:32 +0000
Message-ID: <4b1ecd40-e2f1-47fb-886d-0170a8dade2c@amd.com>
Date: Mon, 22 Jul 2024 14:14:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix index out of bounds in degamma
 hardware format translation
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
 <20240721062216.3151119-7-srinivasan.shanmugam@amd.com>
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240721062216.3151119-7-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed7700f-571c-4d30-1c23-08dcaa158d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YW13NEVCNkxoWlNOZnBkRjR5VWZTUXFBNDVoTFhGbVliL0o3OVlVdGNMU1hN?=
 =?utf-8?B?ajZabStyK1ZVMTBmUVIxdjg0a0FmRjVGaDA2aUhGcDl2algxR2tYaWdqdXJ4?=
 =?utf-8?B?UXROZm0rVGFQMHp3ZC9sYXBLZmIzYXZSWVVpQW44d1ZFYzJZd3FhTDJFL1Nl?=
 =?utf-8?B?ZnowZlRkQ1RoN1J0cFRqbzFIdzQ4VkUwZS85OEkyUG14NDU0QitzNmdqSC9S?=
 =?utf-8?B?bnZGcUFmU1V1N3pERzE4S3pyWHFrYjVqMzM4eGU4R0owaTNsOXhRYzlOaG5P?=
 =?utf-8?B?c2JMNE94ZEJJcHAydTRtTmZ2U3IxSFlwR0RNVGZsKy80NzAzMHdLTDdTUzhV?=
 =?utf-8?B?RVEwRHhFMTk4YTdoUm1STTFBSVBGempGVzdvRDRFUHc0bmNiQzhzdkJGZnls?=
 =?utf-8?B?cGhmV0xQSEtvcjFHK0ZKdi9TdXpGQ1dIdlFiVW5zNUpoVEJXVU9RWkZkUFJq?=
 =?utf-8?B?UkNiZnNlN2FZdUlHWUpsR2JNZHFOcm5wVC9KTitEd1FVM2Q3allrTU9NSGV4?=
 =?utf-8?B?Qm91MmpQbGg2czgwV3NXWkVxdHFybHU0OXhoNzBsT0xZbEhLU0lrTXl5dlFJ?=
 =?utf-8?B?REQ1R1ZTd0Y2N3BxbHhCUDdOZis1Mm5LMitPRkVrNURvK2NSazk1S1RrOWta?=
 =?utf-8?B?SWV0WEhSeVNMaERaa1FWc1k4d0dyNDdjaFJ0VXQxS3M1RlhjMzFHekEwMGMx?=
 =?utf-8?B?QVhpYWYrYzk0TDNmZVNHQ1VhTU4wKzZKVnNqNnRyazdiVlpmQXYvUk4xMnNW?=
 =?utf-8?B?N1dJMzdXd3d2YW5weFNyZ0xhcXdsQTJvU00wb1E2b2t6QmY5eXIzU3p0dzFT?=
 =?utf-8?B?N2dDS2xTWjdDSTNHb3JhOThML3kyTDFOMG9GOXRQWlZ1cWFnMjFuZndyWGcy?=
 =?utf-8?B?UDVkSWV4VVRhWGVPVitDbW5oT0RRN0xkY3lhZm1Uak8xWUNibVNJUzAwcE4r?=
 =?utf-8?B?TGsrUk5wZS8wRGZpVHBNd2NrbkhpQTgrMGpERUVhUGVhMlpidUpyMG5WNU1t?=
 =?utf-8?B?TGd0Y0szajZYZkhncEJVVHIyKys4aFVBZUhsYnZZRjNWa1JOV2hnL3JuQXVt?=
 =?utf-8?B?R1V4dFp0d2xOeGY0N2piR3Bsc1hUZXZ5Q2xtZGhZZGVtbFdWY0UxbXlQRmtn?=
 =?utf-8?B?VXdWY0pTUkRqaDE4UTN6Z0R2QURRREx6YmFFR0xEejFnYzFIZTJMNTZXbGli?=
 =?utf-8?B?ZE50YnQzcTk5ZUwvN1luei80L2Q3Q3piQ3VpZERyblp1TmlTMEVZSDgrVkVH?=
 =?utf-8?B?ODJnZnhKQncybC8zUklCY0R3L3lNU0IwOG93ZUcyUk9rdU5rVkFLRWluZ210?=
 =?utf-8?B?K2ZGMU1LdHRnQ1RDNUZoejUxTUdDVjhFeVZoYzZVTWpjS2pwYkdUZFdYNzdJ?=
 =?utf-8?B?TDVUNlVwVDZlMEgwTUVEMmErRC83eGF3RXQ1aHg2SklXMFEzVmZVT0dzY2Zl?=
 =?utf-8?B?WFdkZTE4NjhsaVpiV1VLb0RIZXkwZ2g0T0QxeGR0S25QNDJlZUYrZmtGTk0v?=
 =?utf-8?B?U0RNWUpzdEIwNmNYSUJ0OTNvT0VLY3AxaXBocXBiRVhycEFxSG4vaC93UXRX?=
 =?utf-8?B?U25EazdxMXQ4dEV4dWp2YWpJL0lreUlxbW5lN1MrSTVQV3pzalpST1lQRHRq?=
 =?utf-8?B?eTNKc0pOYll6UllrbUF2VmNqLzRUREJoNHp4dFV2YlNFc3h0djRwdkE5S29W?=
 =?utf-8?B?ZTZXd2lYblpzQXhOR1N0clYrd1FObmhYM3MwMGFCQTUyay9STTVFSzMzLzd1?=
 =?utf-8?B?MnNPNHdESFJ1RjdJTlhQM1lIQUhnRGgrcTB2WldyYnR2YU4xL3ZoYlNIRGlS?=
 =?utf-8?B?L2FTOEpHaWFtd1dldDMydz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHpBNVprbS9CaXRoSGxKS1dkOERUMDFzMHJVY28wZDNVZEZPaHFuTkJCUExI?=
 =?utf-8?B?WkVuQ0crZzRud0dYc3RLVDZCbmtTSHlyNEo4cVp4ZzMvcTRQdzFGZE9iRTVM?=
 =?utf-8?B?SjhEc09vQ1I2d3lCZDZDWGNBMTlyTmM3Qnd3ZGQ3em4vS0JlOGovS2Zjc1Nr?=
 =?utf-8?B?Sk5HNnlFSSs0VW9qMlkvR3FIZXloZTduMHpBTzJHVTFyTVhZV01KdzdZQ2xS?=
 =?utf-8?B?YVhOWjdvUTJRODBDc3Yvc3NXa0VINVFWZEJqaWhaZjQwbEJPaEcxYUI2TkJQ?=
 =?utf-8?B?bGhHeHA2c3FpVWhqcDQwL0RFd3lHZ0FMK1hLY0VoUG8wYStrQXkzVmxMdFhV?=
 =?utf-8?B?dFlvTld1d1M5cG9qUDduVEc5ZUFqVFkzK0hnVndXczFXYWo1OTB6dzhQK3Iy?=
 =?utf-8?B?N3pYWTZsalR5bjFXRTM0QkpvejlZc3p4SlNFTE03dHByaytXOVFhcU5qRjBj?=
 =?utf-8?B?Y0o2ZWZoNmxBVEE3eDlHcVlYbktSempKekhtNUkwUXZoMXBEUElrbCtscU1h?=
 =?utf-8?B?ZTB6YjBKZ29udm5PUGJsM29RNXpXcjdPZXJIYnkrQWxwMFVKWFRoNk8rUzZz?=
 =?utf-8?B?OWpUWC9HVVZqRlQ4bUtJVzhhNEwvdjJMRzRGcTV5Qkd1ZWV6TmJYK2NnbGE1?=
 =?utf-8?B?RGxvNlB0UHQya3U4dHVtNElPZXp5T1ZlcExmOVhnZXNIK3p0Y2EvRzZ5ODRG?=
 =?utf-8?B?czRjbVBtdnBMK1RpUUVxaUU1WGtrSktEYStmMm9QMlNqeTZLWVYwd3dKdzNR?=
 =?utf-8?B?VVJFa05vUGtuUGJYcDVtblhUMkpWVGRheUxNNzBXcFBiazU4cmJNejZjYncz?=
 =?utf-8?B?MzNBV2VnMmpQeHVjZDBIUlloY3QxUXRVdFVQYzhiTVhwdFVFWFVsKzh2SUl2?=
 =?utf-8?B?V3YwOFV1ZUtpWGdLN2hUSXI2TnRuNWEwdnArTTJ6MkZmRjQ1UTl1VGl4L050?=
 =?utf-8?B?K0pFd2Q5ckNoUVlIZ0RjczlET2d2cjlhdnduQnR6bE1jeXFOOXhVZUZ1Y3JQ?=
 =?utf-8?B?aHBGQnVTT1JjanlZMy9ieXh5N1JiSTBVMmMxZmxBUmVPNzkxNmhoS3YybTFh?=
 =?utf-8?B?dHlQd2xKNnRzWi9xOXBObnZXUVpYdndydXFuYXpqVUg3QnorcFR6VEFOZUdn?=
 =?utf-8?B?R3A3bVE2dzRJM3dVRW0yMWtGMmIvSGlSdStRVkhmcnZZWGlKSnlVMG91ZEQ1?=
 =?utf-8?B?YjZxNWRSRlVqSDRKOC8wRUh2NmtYR1gyZmp2Ky80b3A5bDJwU0FMTldvai9j?=
 =?utf-8?B?ZW9XTWM4eHovR0dWcnhDUFYvcXdhNnB5dEVTYkg5cDdPSG52SjlQamhUNFZm?=
 =?utf-8?B?czlJeGVGSnN0cThEZnV0QnNtbHVCRmg4cHR6bVVUUFk4UXZ6dU4xMDc2cndz?=
 =?utf-8?B?SXp1MVNadGoyaVUvWE5NREU4NVBWK0V4RmlTajcwczQzYWVVUUFtUkpxZ3hP?=
 =?utf-8?B?RXNDdWE1TzFFVVhwbzNwcEtOVlN1WlFhTHpzbDh4bCtlbjErZTl0azV3blFS?=
 =?utf-8?B?eVExMTdrTlpFQm9FR0dPYU52UkZyOEZ1ZU1RMzZSOHRjY29YWWYxY2FyazJE?=
 =?utf-8?B?ZFAzQnVZLzB4RHFqamZoSGNvdjdqM2JYMnJVWnhvMmRFRGl0VEJMa01MRCtt?=
 =?utf-8?B?cVZlelgrSEcyVzkwemNjanhRZHltbENkYlRZTFE0ZjZVZXY2Vm9qbU9YOWJD?=
 =?utf-8?B?c2RqZFB4QmE2U3AxNlFGOE9TZkZPZ2R4NW94VEs0MjhGTkJEMW9ZbVFxYzNM?=
 =?utf-8?B?S0REWVBFS2RLTS8wNWlSZTlvS3ZZSEhHODBwVmpSd2FGazVWM25RNmxvVmhL?=
 =?utf-8?B?WDJkNStEOHYrdmJ2WENWbWV2WDhIV3ZXaVlVSU4ycDRmbXY2V2tkT1puMEhV?=
 =?utf-8?B?RmpyN1cwQkpnemc1RUJwOC9EUFRpcHBNQ3Z0ZUdRbGJLU2s0NnNFUjJhQlZB?=
 =?utf-8?B?d01YbnEvMnEvMi8zb1hMK1ZaOXptaXo0dUhHMmpqZmtwTElodEFLdHRLNTkv?=
 =?utf-8?B?UWhBT2tMcldQT1dKMFVhb0RPVnJscnFNR1lPenY0cTF5QjZaWTZnb1Vpckcx?=
 =?utf-8?B?WDV3NjVERmdMdEZPNVVkTFZ5M0VQcnF5MStsR3had1IyeVZFOGlISUd6T2Z5?=
 =?utf-8?Q?s9qiCy6VfAv4OV60m43WO4u3X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed7700f-571c-4d30-1c23-08dcaa158d8a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 06:14:32.8310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7q5YSjA7nkAek8X6+ZTVALVKrHx6h36byfQNVg107NELq7/I6+HG6/d+UylDnJ8sgFzeS5ppSzpgLUilrgdRwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 7/21/2024 2:22 PM, Srinivasan Shanmugam wrote:
> Fixes index out of bounds issue in
> `cm_helper_translate_curve_to_degamma_hw_format` function. The issue
> could occur when the index 'i' exceeds the number of transfer function
> points (TRANSFER_FUNC_POINTS).
>
> The fix adds a check to ensure 'i' is within bounds before accessing the
> transfer function points. If 'i' is out of bounds the function returns
> false to indicate an error.
>
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_cm_common.c:594 cm_helper_translate_curve_to_degamma_hw_format() error: buffer overflow 'output_tf->tf_pts.red' 1025 <= s32max
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_cm_common.c:595 cm_helper_translate_curve_to_degamma_hw_format() error: buffer overflow 'output_tf->tf_pts.green' 1025 <= s32max
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_cm_common.c:596 cm_helper_translate_curve_to_degamma_hw_format() error: buffer overflow 'output_tf->tf_pts.blue' 1025 <= s32max
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
> index 0b49362f71b0..eaed5d1c398a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
> @@ -591,6 +591,8 @@ bool cm_helper_translate_curve_to_degamma_hw_format(
>   				i += increment) {
>   			if (j == hw_points - 1)
>   				break;
> +			if (i >= TRANSFER_FUNC_POINTS)
> +				return false;
>   			rgb_resulted[j].red = output_tf->tf_pts.red[i];
>   			rgb_resulted[j].green = output_tf->tf_pts.green[i];
>   			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
