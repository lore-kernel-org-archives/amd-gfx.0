Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22600CD13DE
	for <amd-gfx@archiver.kernel.org>; Sat, 31 Aug 2024 17:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788EF10E116;
	Sat, 31 Aug 2024 17:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L31SO8If";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1B1A10E116
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 Aug 2024 17:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH9q1mchW7T0yCBeqRbMgr9OWQluNgHrgmmwPa38CWJXZljL9VCa/D9gbtL0Ke6GnXrfbloU0j2welLBMTKJSQP+eBtE68yUx75lQ3caxTya8M4OMDKVW4pbUkg8avA2ARSr1zu/h4+m7iiot3G49dSNuQce4YM61qO9b5nbCpOCGsaYptBa08XhzOLmExKUr/K/AvAbZUxwZozzv69BMIR4d89I/4/BNPx5VGmQ5HzPuVhWCNkaSQCi9rBh24fw6zwMc2FwN7PKh6udlSFu+uqhT2jGZ/dj5pCWxI8b5TaAGs7f4EOz8XCyjSj1ppV/Xi67rFXp1+bh0aY9uWgo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVj0qysHfMqPlJp60nCDCrYnR+t0d+EWeQ2ZX+EUvgQ=;
 b=ZsW2q51bqPXb5deuMcNuL72E6tCiMz04gMmx+8agLIz6DfqFxaWrVI31nbuDKI8nl66ERu0OtYmtXwuUr4SzZ8C+RHY2Baffg/IO9xmFOQ2aAQlhmE6jKe8GyLUAIF93L/gtBMrbayhDzWfcsVvtJnGZp5hyw+nIPYiRsU7Hfru5XNqRLXdRvUv1AzLhVpK4wWC7anYKwy631xX6znVi8UNccdvLuPs8wqgI0gM0rkiBW6NVKp0NgWPtgtXTun6kOlFKo/LBlXXmwTGN2/IwzX9PdSLVnPdEOkHymfKm4a4zG7Sg5rpF5uDQxn03W34dO03/pRXkU05rtIe3IvLK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVj0qysHfMqPlJp60nCDCrYnR+t0d+EWeQ2ZX+EUvgQ=;
 b=L31SO8IfodHziuAwwtugELB5VWHGaZrvtN5+6vLCZ7yhiT5J/IqQvP78aG1fkihEIeD/Pc6k0ysjIy6mO2aNHQ/9QTipLWFlC30JV8B0B7gXGwOGZAQJFd2OmaSa26GV1f+Ckzl7QA1JT5oG/G5LxZZAFbdDs1Pn2wWOzobHhbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Sat, 31 Aug
 2024 17:08:11 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7918.019; Sat, 31 Aug 2024
 17:08:10 +0000
Message-ID: <9331ec82-bd13-486d-8ef1-86d826076919@amd.com>
Date: Sun, 1 Sep 2024 01:08:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Add missing kdoc entry for
 'bs_coeffs_updated' in dpp401_dscl_program_isharp
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240829131745.1828528-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240829131745.1828528-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0142.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::11) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d74338e-1ea4-4fba-558d-08dcc9df7d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFVlNktuZDluZjhzYy9KaHl2eUEzVThvdUNoQU5zcUZxYUsxUTlhQzVPZHlU?=
 =?utf-8?B?ZnlFRnltdjZhNEMrcGk5Qk9YVlNoOFc1TUp2TDJuaGQ4UWNmMWZybC9Od3pT?=
 =?utf-8?B?ODRNQW9wQnp2V0RubFpEbjhFL2UxRXFOeGxJekI2TDNlb08yM2IyTnBQNTZH?=
 =?utf-8?B?QWlCNkRHSngvcndaMkM3NUtSSmtUdmUvbTZaQytMTEZuc041NUFVMG5pcmpD?=
 =?utf-8?B?M3d4QmhXYTVycmRRNmxIWnJlZXRIeSs4clNqTzZnOStBa29hT2xBTnNhVlpW?=
 =?utf-8?B?NU93NW1rSGg2cnJjQ0k1U2dlK0pGVGxxMXljbzVGZGZmZEtxMkl4aDlGMm1H?=
 =?utf-8?B?QUs2SVg1RE85V3NoK3RJNFdQeTk1MFlOVzVTanFSeUlaQUdBYmx6ams5VE9p?=
 =?utf-8?B?aXpZeFJyMzRhY0gzSGtaSWZ5dkpkajQ2WkFSOTFDOWtheFBNUDlrVUlLZjEy?=
 =?utf-8?B?VzlCL2V3RkhGR2xwWi8vZmt2aFNxcERBQnNzYUwyc2Vrd3N5U09qTWNXbXM3?=
 =?utf-8?B?RmNJbkY1c1M5czRMdEJhcnVTUnBKUmxzTFhhaXp1N3BKb01XSng5T3FubFJK?=
 =?utf-8?B?eElXbzFEcTBQaXBTU2UzQ2dqRkNTMzdVVmNSejl0R3F5Y2crNTlJRDUrVHdx?=
 =?utf-8?B?LytGRkVJSGNGN0ZXY08yVGhzdmptZWM4ZnRkVWgrOTY1aENWWU0xTVBKdWli?=
 =?utf-8?B?WXo3RnBIbkhWV3h0WU1oL3VPdlI1UEJZM0hsK0t6LzZmNUh2WGNGbFRPcEJH?=
 =?utf-8?B?Mms0RllFSUNSNzNSM3ZpR2VKNm8rbElWbmNrWG9TSUsvZFkwamgwZTBHbXVx?=
 =?utf-8?B?dDJ4MmdhRU9QN2IwVERtTWhqdVU1RFBuRm54Tk0xS0txUGdoWEZ6U2JrcEhZ?=
 =?utf-8?B?N1c0bm41YS9IeWQ3cEQzeVpkMHJYOEd6UkErcE1Dc1NGcWtaUHJqeG9WR2Uy?=
 =?utf-8?B?OUtoc1Nld0VYdDBtRERuaWI2Z2IxNmgralZPU0tnMTQvSEN2Q2lCRHBaUEtx?=
 =?utf-8?B?ZUF1M0grMVVTZnlwYTh5NndXclFSbk9BZFB3WEt5NVpVOGZpbkFxUTVPVnN3?=
 =?utf-8?B?ci9FUUlWZkFSTUR6dit0WUIwaGU4RzM5aHI2c0FpT3VLMWZ0aXNoZWo5ait3?=
 =?utf-8?B?Y1JUNGlSRkpnSWNOeklha2puNzUzc0QyM0NVamxJUFVhN1JjMm05WTVGdUND?=
 =?utf-8?B?YXJaRVlzSDJ6MXUralVlNHZZZ1B4aU5PeVNzYU9ycy9EUEpQa0tGRkJteUxm?=
 =?utf-8?B?SWp3ZWNIM1VXVlFiYlc5REdIWHpYakF5aE1VVU1aSXNkR2tVZGJaYmNlLzBO?=
 =?utf-8?B?ZnRlSXZVc3VjTHhTclVjb1pOSjZtN1IxNG5KdHlTcndOazZlSk9sSldQRDJq?=
 =?utf-8?B?RzZSc2FpYWFRT2xvRDZ4Lzlqc1ZuNHFRVlRBRjRUblY2NFM5Q3ZzbW80aWpu?=
 =?utf-8?B?TnNFMzZ6SVdFd3hzcVFRVEV2UnpZeHRCcXdGV2xvaFFiTFkwWWNKLzNlNDBP?=
 =?utf-8?B?VlloaGdJaDVhMHJLUVFFYVFCdTRjNkxkbE03Q3VhSFBtOUhzaEM3M28vRytn?=
 =?utf-8?B?OTRuWFRTZ1Exc2xpd3NCWGsvOTZjajg2T01uQWtwbWgrRzhPRCtLdEtYSGFa?=
 =?utf-8?B?ZDJGTHhjRlpnODRYR1loNUdhRk5hdG04VVZYNndnWTFidUR5akZHVFBCUnZP?=
 =?utf-8?B?UEJMdXNoNnYweUk3R2Z5dURLTEQ0MlJ0RGt3VTg5MUtqL3czMjAzblR6UEJC?=
 =?utf-8?B?UWNieXNhaVB6WUUzK0hhUElEYWdkQnJZQmE3cEpTcnlRRzdwMnU1RWhNQmEr?=
 =?utf-8?B?Tk5PcGVuelo1aWF6d0NHUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEZHdklqVGhrSzluai9lSWhwYjh6d1pMbGY5alNNY2tpS3E3MHQ4TFp3eEtl?=
 =?utf-8?B?eklJWm8rZHlWTXN2OHpLM0d6aEdNV2lQd0R5c3EyODh1WXdyaFdQV2UwYjU1?=
 =?utf-8?B?b0N1Y3VwQ2J3bXBVOWFyQURnOElXVU9BcDBqSUgzTTI2QUl6c0pQbWFTNyth?=
 =?utf-8?B?NUxSdldzT0lSMFg1b3VOTmlYOXFDTEI1enpVTE9Cb3ZPTHdlbTh6ZDRqM01E?=
 =?utf-8?B?Q1V6Ty9DcHJEeURVWHE5YTNhcXAvVkt0WkhmeVlyZGpUcVc1UHpsV0hHTURM?=
 =?utf-8?B?cGZaZ3FtVmt0NThsVlJUejB6am5Mb2tKQzkxbGU0Y0NoMDdoV2YwQzFTUzdJ?=
 =?utf-8?B?eGppS2wyMlVlRGtCekJTejZMdVdGK1hwb21JM1dNcTBQY1k0UnNYVkJYL2Rm?=
 =?utf-8?B?WG9iSlpPRjFtNnF3M1k2WVplN1p6bG0zRWdkUzlEOVhLNVNwNFN5TnBwTytR?=
 =?utf-8?B?YkhDeSt0b0VXa0pwSXFYa3lJZGhxQk0vazNoKzVJeUlvRDZvT2RsNk1icUx3?=
 =?utf-8?B?dmFpUGNKcmNpRE9icFlkdlRTK0FhUCtudlpJbHAxQ1k2RW1Xb0hzeGZnSU5s?=
 =?utf-8?B?OG1YR3ZEUnArSXlMMHdlYlB5ZTBkVTBPbDVaTFZnRjZjTHFWREZpcC9YSk9Y?=
 =?utf-8?B?Y001SW0vVUpCbC9oTEQveUhHVkZhZUEwMk53a01OTG5LOEtUbldIM0dLaEZ1?=
 =?utf-8?B?aUJrZWg1RW1TOG51OTdYbi9HeTc3dUhadk1PK0FtVnVmbnk3ai92NlBaeWY0?=
 =?utf-8?B?R2puNWxKa2k5NDJuWFJXRGt6cWhyOWxVN2p0cTYxTnRoZ0tUVlJMWmJiTnBq?=
 =?utf-8?B?ZHhJT1lZWno0eDBzNCtkZ2E3OC9nMmtrYTROSGZpeDFxTFdURXdaZ1I3UEFp?=
 =?utf-8?B?TzVvSXpZYWtLT1VFUUMwNm1KdDZSRXc4SkFhUUVvVit2S0tYVThibmVKdmZF?=
 =?utf-8?B?UkEvVGdnU1FWQVhrbW5Od3ZWb3o2N25FM3J5cGdIejFZeEhVbXQwcStTTnN1?=
 =?utf-8?B?RnQ5MWR5VkZUMEZXbE9XSWJVMTIvMHhvZS9IU2hvOEZRbk1sVHJvMkI4S2xP?=
 =?utf-8?B?aUgrOFl0U1BvQ3JoY3c5OGhWTmdPMS9VSUNUQ3MyZlQvbXlVNS9XdkdJSEdB?=
 =?utf-8?B?aFM4WTdmdlJ4Q3M1eStZeTlLemdLdUJ6dEFUSUNjR0MwVTdiUDZsUUhTZDdS?=
 =?utf-8?B?Rnc1UjdRMVRQSmQzZnBLajI4UER2QXNCdU9FQVJGdStjc05TWU5qQnNIK0Jh?=
 =?utf-8?B?Y080cnA2cnF1MnRyTnRtaXg3bTBYWnp5UVRZRUh6SXhjNFEzaDhiZG9kZ2cz?=
 =?utf-8?B?UWZ4OURya21IYW9CSkVxdWREUkZKbnc5ODliQkxGb2w0V3Q2RWQ5dTBxbEtv?=
 =?utf-8?B?TDM0RTZSUlQzRXRjZjdwamoyb3dpWEJjcjNEMWJMYnBCL1ZOSWdTZkdwUElm?=
 =?utf-8?B?S1U0b3lLd0o4dzZnYzN4Tnd3bGFpSEh3NzB5Ry9uV3dGQy94MVhTOVRrOEVY?=
 =?utf-8?B?ZU5ZZXBNb2ZWOEI5cW9FaVBBTlVKdmJGY2JxbGFHVEJNK29MUXRYMEx1SEpI?=
 =?utf-8?B?Y2dHbW03R293RzFpSi9LWnlJWlprRnBCczRxbzZZSUllY2F1bTFGT0VwZGND?=
 =?utf-8?B?MFVneWZVdGlUTm9la0dmZW5PV1pGMUp1QmRiSWp6Z2hSZ3VrNm5qUGJySldR?=
 =?utf-8?B?MDhzeEUzNE8vaEdndEp6YWpBL3Rmd0svVzIxNDNJUkRlM0NzeFZSd204SThm?=
 =?utf-8?B?d1N3dW51aW12d0crMElqWXFLazZBYnQ4WHFUYTE1clNGakJJQXhldS8rSXFU?=
 =?utf-8?B?NkxkeFpYUFJWY3E5anhIRUtuQmJreThQUDdGTTFwUkNUM3c3VFNVc3pzRHEz?=
 =?utf-8?B?Skx0UGVYY21aNHEvRS8wQStpNDBKZXZYZk9Jb2dJVno0Rkk5bEVMZjVyNmNa?=
 =?utf-8?B?LzBTbmtXWWRDZGpwa3BYbnRTVVZLT214dENMMkxLcjJwTWlrdEtrZTZBcWky?=
 =?utf-8?B?T3RnZS9lMjJ1T0Znd2pHeTFjWThqd0U4bWxWcEpxbm9aVFBBb3ZEcko1elNW?=
 =?utf-8?B?eExCdTJucS9lQ2huWmV2a1B4RC9IWUt5UldIQ25raitFOTFtUzBPdTZmRHZH?=
 =?utf-8?Q?GSNk07RJSyVkMjEzWoy9WAO+f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d74338e-1ea4-4fba-558d-08dcc9df7d8f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 17:08:10.3550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWFgjh0giFHRQh1hj8DhEePmU3fpGJMkosnxLioT/ilY+YqkCoUSUTxpBKB8o2jb2LgJncROVZSytMf+qsUZKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712
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

On 8/29/2024 9:17 PM, Srinivasan Shanmugam wrote:
> This commit addresses a missing kdoc for the 'bs_coeffs_updated'
> parameter in the 'dpp401_dscl_program_isharp' function. The
> 'bs_coeffs_updated' is a flag indicating whether the Blur and Scale
> Coefficients have been updated.
>
> The 'dpp401_dscl_program_isharp' function is responsible for programming
> the isharp, which includes setting the isharp filter, noise gain, and
> blur and scale coefficients. If the 'bs_coeffs_updated' flag is set to
> true, the function updates the blur and scale coefficients.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dpp/dcn401/dcn401_dpp_dscl.c:961: warning: Function parameter or struct member 'bs_coeffs_updated' not described in 'dpp401_dscl_program_isharp'
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Tom Chung <chiahsuan.chung@amd.com>
> ---
> v2:
> Updated to "Blur and Scale Coefficients update flag" (Tom)
>
>   drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
> index 703d7b51c6c2..4d8de1b8aa62 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
> @@ -951,6 +951,7 @@ static void dpp401_dscl_set_isharp_filter(
>    *
>    * @dpp_base: High level DPP struct
>    * @scl_data: scalaer_data info
> + * @bs_coeffs_updated: Blur and Scale Coefficients update flag
>    *
>    * This is the primary function to program isharp
>    *
