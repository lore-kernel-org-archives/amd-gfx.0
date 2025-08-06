Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B40C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 15:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55DE010E7A2;
	Wed,  6 Aug 2025 15:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4BQdEP8m";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2862F10E7A2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 15:27:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylFssnW/GG9DmsCPPRgOu+t/qYpthyH1vHPQDRIrb5eu8t01rGpgYPcES7kmLPrRMFMlN6COMQWtgTTh1X5edjMM0a87RgbqKqR0zmepAMdtQypSOczX48FnEN62py3C5aN4G52EelWYMvZauS6SjZEfr1S1jH5Jm/D7jhVv8XfpZtOTx90nMLjrhgky+ZDITrH88WxMKgHvA1Tl4d64TSr8kAdQcRs3g50UaAZwP/m+WRBkU8wyu5JlK4tpCu6QFX8LPe1vbq4UEodQ5Cx/i0vcH9BOAR5HEz86bi8y0LVz1k062Jrja3IhrTt2TEe2Z0CG6yMjoyjK0rBbdzbgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OdYdyVqkmdmOS3/66ODkkTAU7fYvUAQVnO0uHJ0eSM=;
 b=Q2M4HRqhh4s9wOiQmrb424zLIs04Bexy3Ryn0nOoFjO5mHbe7J7PhTUsnlQYGNSPgNjqbZl5SxnABMdedeXvK3U9IddGwF7zu7WK9h5v4y2a4pLtJtHbopzpfelzhwmMza7v0SnpdlpdavPL1CKusukzMusTRz6k/ivXNamEu07ro491bvsqQDkwr96XJZMkf5Gq5P3vVMU21Hn46fB/wKc4ELBTc6OO9Nv/QnVeiLyyt+9IIOes6oEWrzOTpqsNLtOscp9xMbbHCmhXRjuteGgIC0drzt0DcQfr/wUBro/85/uv8195J4j2Fqi4/xuf7nnwp62jMn8nnLEelQiMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OdYdyVqkmdmOS3/66ODkkTAU7fYvUAQVnO0uHJ0eSM=;
 b=4BQdEP8mk+0u20XseeYSCi1fSbAEwcdhBly8zipmU8+m9BG+gnX045Kh/iQNHYxelPQYimU9QmidKA1tz/zxKK1V37+ClT/t5eRKNnq9w9jtkNtEjpUQGPsVuBhGs/593iB+7c3HUmq8+GwTL2ufckwa/TmUaIU751C+fjKwx7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 15:27:15 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Wed, 6 Aug 2025
 15:27:15 +0000
Message-ID: <fa072923-3833-45ef-bd96-d7cbdcf73d6b@amd.com>
Date: Wed, 6 Aug 2025 20:57:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/discovery: fix fw based ip discovery
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250730155900.22657-1-alexander.deucher@amd.com>
 <eca66cd1-aaa3-4ec2-aecc-bbed7f44f7ae@amd.com>
 <BL1PR12MB5144A4306581939E370B9DE5F72DA@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB5144A4306581939E370B9DE5F72DA@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::15) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d0dbdf-8aee-481a-bb53-08ddd4fdb8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wmt1a2d6MCsrTzZweXhZQTVkSEdXWEU2THNsM1d5S0wzNDVmVXRXazliUTR0?=
 =?utf-8?B?ZTdZa2lRSHhkZ1NDSHdxNE5VbENzM3NKa2IyWEVyTlc0dzBUaFZma3g2dlJK?=
 =?utf-8?B?dXZLZnMwRUpYS3NtSDV2UDdtdU1UZkFFd2pROFVWamkyZk5sRDNtdjR6THY4?=
 =?utf-8?B?QjBJYnlReXVQeTlqT1QxZEkrUVAveDhIazZ5emIvZktwMEl6Vy8yc01ySUwx?=
 =?utf-8?B?YkR1VXYwaU1XcHArNndZV3JwVDNES3cvTUUydm5zK3ZRMExIQzNEYVF6VDFv?=
 =?utf-8?B?UmxGeVo3c2NqR0dtRzc3RDN2Q1NmbzlYOEdCSWt5SmVIblJWN2dETkF3cVh0?=
 =?utf-8?B?eHZMeDFHOFlUS09OM3lISnl0eXI0Q2Q0QWpaVVh1cTByclNpVXVMbkNtZEJh?=
 =?utf-8?B?NUpLeHRyaExsTGhzalpjeFpuNFFvUzdjUjZwc28rNHAxT2RjSlFIWjduanEx?=
 =?utf-8?B?NmNpS29NWVVJc0JXQ0pueFJKY1RwRVhwWUNYSUUwTGRkeDJwNXcvL3N1MGJo?=
 =?utf-8?B?bk9zU2lsSXZ6R1NRK3JwN1oyTXVPVVdBZGdnaVh6eUJqdjkvendaa05QSWF0?=
 =?utf-8?B?blc5QnBXaHZIWmRENk1OZmhqY2xTWUxvWUE0d1A2cGJJcFhtNGY2R1VjSTlW?=
 =?utf-8?B?eUJTWkg1aGNiK09CZ2FhMHd2ZWRtUExnNEJCWTBOK2VlczNwWVNqYUFsdXRN?=
 =?utf-8?B?TmNXZkhWV09kQlJrWExvWVdoUG9uQkRpUU9Qd2ptL0VQczlwSXBlWURBcm1K?=
 =?utf-8?B?elN4QU1wV1NwRHJRYjJNZmdFcmRnTWErOTVNeHh0Ny90WDBsNklZNTY3Y3hY?=
 =?utf-8?B?bFFhZVFZZ3VxUHBiUkppalhQZkxXNytuazBkWDJ6YXhicCsyOUhOWHM1c0do?=
 =?utf-8?B?bjM1R2lZMGd0YVE4eEtkbXRjdlZSVWZOcG1sRjJ2ZDNnSjBkQzVPc1VpWFh1?=
 =?utf-8?B?OHZYMENNbWM1ZW8wZGc1NFZteWlVZ1k2NmFaT3FONU4wZU50SW5NSE81cVUr?=
 =?utf-8?B?VDM2ZFc2aDEvRktSeHFEeDBITlAzZUpUdGdBaHVGR0JHbGVOY3hPN052UU15?=
 =?utf-8?B?V2RrS3BWUGFSNkVhNDJDeStEWjVESDFudDA3UEFZTm1iVGdWUmtHeERNdTlj?=
 =?utf-8?B?bFhXaHVUeFJUMDhsZzRIaXZ5YmtqaFg4ZVZlcGVGVzl6SGRuSm1CT1R1WlNT?=
 =?utf-8?B?dHVseThMdXNjOE93THFXaTVqZi84TnQ1dWUzb3B5S2dDcnpFVDJQdU4vMnpj?=
 =?utf-8?B?MFBYKzFWUmhLVy9jbUlwd1JGaUF4b3FRazZCcnNNUjgwaFM4cjNSMTVaUE5Q?=
 =?utf-8?B?UVU5Vms2TUtMUVBJQVBJYmtjRFNWNWRDS0V0d2k1U2NTNm0zVWFOOFVVbkxX?=
 =?utf-8?B?bnJzTTFBVmcra1FZOVVoWERCcnNPM2tCTkUwL0RYZ0JQMFBCdXBIcVQ2QWc1?=
 =?utf-8?B?M1BVcERyWXJzWkl1b2N4cjZDdnhLUVBlQ1hxZzVtNlZ2elgwQzBuakhKWnpl?=
 =?utf-8?B?R0paTnNpOUJ3S3MvdENZQnRqYmlxcisxZVBSdmwxZXBIZFA2eG1aL3BPNHFY?=
 =?utf-8?B?TXJqZW43RjRrSkREYmZPSitzcmNnUHRGdXdhVGVhcUV2bi9ObHBrRTZJdEZY?=
 =?utf-8?B?M2Jna1lkck1yUmlwVi80QXRuUFg4cXZ6cmhRVjNxSVhnM2hiNEZJM2k3TC9R?=
 =?utf-8?B?M2tvNkY5aDJYMzIvQm5wSU02cnA5c3hFNGpaZWJSSEMwTXVOcEVqaHNMUUtN?=
 =?utf-8?B?NU5GaWxxeHZ3ajRlejlNOUo2WlY2eXl0b1BLU2lJMGJJNzRBVUcrMFpUc1Fq?=
 =?utf-8?Q?0qu91IhLVrlHgcmN6QAmxcsZx2afsoJU/k9mQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUdXZ1djcG8veW9iQXJZSURhSVFVRWYzVTRXTlRSVE1lY0kybGM2cjl2QTdU?=
 =?utf-8?B?a2hqejhCUTliQkh5K1BSM2w4cDl5OC8xTERjRDcvWTM4QlhsQWduaVY3UTdG?=
 =?utf-8?B?c2lsbnY1citZRlQ0U3lEMzNkSHorV3dxcVlwQndOd3VncVJkME5hYUlLSlMw?=
 =?utf-8?B?YVYzK1BBVHhhWWE2SlhMWFpJeU8zaTVkY051aE01VmNSVkllOXAzZVBPQjR5?=
 =?utf-8?B?Zjl6NzBOeUtMeFEvSks0M1ZZdGVLZkk0ajhxVG5Na21kaWZiT3lQbzZMbER3?=
 =?utf-8?B?RXpCU25yZHJZQWJBN2dxZ3hjWkRxdkR0T2d5cGMzVGxBaUZ0cWRJN0VTQm8x?=
 =?utf-8?B?NCtRY2ZYUVRkMk15YTZsUlQ1U1VlZzdQWDc3ZmdGRXg2eDM2bTlyTDlSNWZ2?=
 =?utf-8?B?c25Ub3BoYWovVGJEQ1dEV3JUc21DNlIrbk5kc2ZJT2VvWmpLR0NuY1o3Zllv?=
 =?utf-8?B?MzY1dXVwYitrbUtDeWViU1RkMU5WOU1CNThRRjgrS3Z3TmtYUVN3WlFScmtl?=
 =?utf-8?B?Rit1cHNJRzg5UmgweWwzdlkwTkpFdU1hTExiUFkxaUNoVmtOTW55TmxGenhJ?=
 =?utf-8?B?K3hKUUp1V2U4Nk5adjlHYWdjWTNaZDBYbUs4SjAwQ1BuM2Y3cmFubTg1S2pw?=
 =?utf-8?B?R21BMnlyQVJPZ1QreEM3Zk84NTdVQzgwNDlkNkZST1llU1drZHQyTi9yUHBK?=
 =?utf-8?B?R041YUNwYzBXcVlTcUpUdUFsd29sVStHVVBpMEYvTldYdWJ6V05idkRhRU5a?=
 =?utf-8?B?V1d4S0ozY045bDE0eDZ6eHBYbGZNNytCUGYxRVR3Z0pPRENyeDRMQytxVVBP?=
 =?utf-8?B?SS9DdUw3QmtoVXBJVlZMREovdkVCMU5EZTZyOGRYSXJpS0dwdlUxQk14cTF2?=
 =?utf-8?B?ejhEWG9tYVRmSHJ4aVgrbDFyVHhsbEppbjZkUE1aOFB1dHIyQU4yYlFtejdp?=
 =?utf-8?B?NUpMYkVUUWRvaVMwSkxiWHNMczdlVVBnaVdPZ0RsQW9UbnAyTEM4WHZvNC9F?=
 =?utf-8?B?SVcvRE8vcEFwOElZK2ZPRzhsNUlZUHhaRHkvL2FDSWtWZVFobGNHei85QnJP?=
 =?utf-8?B?SjBqd3IwZXVNamswaWEzZ3cwSE5lVDZrcWtKak9ybEdZVEpvN0VDYUFjYjJo?=
 =?utf-8?B?U0hBb2RMMlZCc0VJeWlxblhZRTFFcm1ZenRhNjI0cHNxWU9sRm9Xd2pFbXRi?=
 =?utf-8?B?MkdPUU9RNzBpSExFVWJTRW16K2FYcmJJTHZwaXdRYVZDRnlUdVh2QytveElJ?=
 =?utf-8?B?K3pPUGxmZVNBR1AwZXpDSlBBcEVzOThkNC9mWGhPY0RuWVZUeThUVk0zeHBh?=
 =?utf-8?B?M3kzTUJRejBxdmR3bEJ4NmZiQkRoaGEwOFBSSEdtN2VRTFpzQ0VWMGJMbk9o?=
 =?utf-8?B?RUlmbDhhQTh1Sm5oQkNhcC8wbXk3Uyt1RnZIT3NPbFEvcktPTEVXaVk1M1JV?=
 =?utf-8?B?WVo3U0Z6dWVUaDdRVy9vNXJETm85TkdOL21ndGZNM0ZaYTZ2NW5YRlRBeUdW?=
 =?utf-8?B?cXR5eXpuSjBwZytvTzlCQThvWnJKdWZMMXFGendyOUJQMXhHQVU0NndkNmZI?=
 =?utf-8?B?Z1U0dkgrSkNsVlZnREJVVFhLWnBlaVJuZXpraHlOM0FDUW12eFhwcUZCYTVv?=
 =?utf-8?B?WVAreFdoMHZlQmxadjduRHFuMm9mVnY1TkV3eXRQMzMwNHdhcGxZdVg5dVpz?=
 =?utf-8?B?RHJqeDArZHpCZFZJa1VDRVo1Z3pzdXFKNE1TSFN1MTJsOVpiRWRvWUF3TFRu?=
 =?utf-8?B?bUZIRTQrMDFjN0dEUnZvZHBGYkhqQ2kreGhoUm11NmdGOWlsMy9Cd3dPcWdE?=
 =?utf-8?B?NCtwSjVnWDJBaDJOUmljUTNYYUsyZHpXdWV0d1V5cXVUSTdOdnU4WXlYMEhw?=
 =?utf-8?B?OXQyby8vcW1nNk1mZGFSdDFNUmtnaTdqS3RGYVhjQ0JtbkZwS0IwMlhOaGx3?=
 =?utf-8?B?Z1JjNGZ5OEU4VUsvWEhKUUVON2ozRDc3UW9iTzJxWGpjbm1sanRpbkpvcTNh?=
 =?utf-8?B?dDZMaCtNRENNcnN0dnB1enEzOFJyS2pVSzkycyt2YWllOWhpODlDZmRSS1Y5?=
 =?utf-8?B?a1Z0dG1QS2txRmxDY0JQU2VXbk11M245SEZkTUN5bGtTczU5R0VtZElhbk1S?=
 =?utf-8?Q?dmdBhkV19cWox4vCL5V+DX9C6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d0dbdf-8aee-481a-bb53-08ddd4fdb8f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 15:27:15.4826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rb42PStPedRAuXyA4hf7HfSfDQv8u/YWYIki5CBdUr1WnJgwxQZZp37DCtMfDlOA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322
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



On 8/6/2025 8:50 PM, Deucher, Alexander wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, August 6, 2025 11:17 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: stable@vger.kernel.org
>> Subject: Re: [PATCH] drm/amdgpu/discovery: fix fw based ip discovery
>>
>>
>>
>> On 7/30/2025 9:29 PM, Alex Deucher wrote:
>>> We only need the fw based discovery table for sysfs.  No need to parse
>>> it.  Additionally parsing some of the board specific tables may result
>>> in incorrect data on some boards.
>>> just load the binary and don't parse it on those boards.
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4441
>>> Fixes: 80a0e8282933 ("drm/amdgpu/discovery: optionally use fw based ip
>>> discovery")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> One generic question - if discovery content is completely ignored by driver, how
>> external tool using sysfs could consume the data? Wouldn't there be a mismatch in
>> the config?
> 
> The IP register offsets are what tools use sysfs for.  It's possible some of the other data is invalid (e.g., the harvest tables) because they are not coming from IFWI in this case.
> 

Thanks for the info. Probably, keeping the same comment in the commit
description or code helps - discovery binary file is loaded to provide
sysfs interface to get valid IP register offsets and data from other
tables are not reliable.

Thanks,
Lijo

> Alex
> 
> 
>>
>> Thanks,
>> Lijo
>>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 72
>>> ++++++++++---------
>>>  2 files changed, 41 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index efe98ffb679a4..b2538cff222ce 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -2570,9 +2570,6 @@ static int
>>> amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>>>
>>>     adev->firmware.gpu_info_fw = NULL;
>>>
>>> -   if (adev->mman.discovery_bin)
>>> -           return 0;
>>> -
>>>     switch (adev->asic_type) {
>>>     default:
>>>             return 0;
>>> @@ -2594,6 +2591,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct
>> amdgpu_device *adev)
>>>             chip_name = "arcturus";
>>>             break;
>>>     case CHIP_NAVI12:
>>> +           if (adev->mman.discovery_bin)
>>> +                   return 0;
>>>             chip_name = "navi12";
>>>             break;
>>>     }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> index 81b3443c8d7f4..27bd7659961e8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> @@ -2555,40 +2555,11 @@ int amdgpu_discovery_set_ip_blocks(struct
>>> amdgpu_device *adev)
>>>
>>>     switch (adev->asic_type) {
>>>     case CHIP_VEGA10:
>>> -   case CHIP_VEGA12:
>>> -   case CHIP_RAVEN:
>>> -   case CHIP_VEGA20:
>>> -   case CHIP_ARCTURUS:
>>> -   case CHIP_ALDEBARAN:
>>> -           /* this is not fatal.  We have a fallback below
>>> -            * if the new firmwares are not present. some of
>>> -            * this will be overridden below to keep things
>>> -            * consistent with the current behavior.
>>> +           /* This is not fatal.  We only need the discovery
>>> +            * binary for sysfs.  We don't need it for a
>>> +            * functional system.
>>>              */
>>> -           r = amdgpu_discovery_reg_base_init(adev);
>>> -           if (!r) {
>>> -                   amdgpu_discovery_harvest_ip(adev);
>>> -                   amdgpu_discovery_get_gfx_info(adev);
>>> -                   amdgpu_discovery_get_mall_info(adev);
>>> -                   amdgpu_discovery_get_vcn_info(adev);
>>> -           }
>>> -           break;
>>> -   default:
>>> -           r = amdgpu_discovery_reg_base_init(adev);
>>> -           if (r) {
>>> -                   drm_err(&adev->ddev, "discovery failed: %d\n", r);
>>> -                   return r;
>>> -           }
>>> -
>>> -           amdgpu_discovery_harvest_ip(adev);
>>> -           amdgpu_discovery_get_gfx_info(adev);
>>> -           amdgpu_discovery_get_mall_info(adev);
>>> -           amdgpu_discovery_get_vcn_info(adev);
>>> -           break;
>>> -   }
>>> -
>>> -   switch (adev->asic_type) {
>>> -   case CHIP_VEGA10:
>>> +           amdgpu_discovery_init(adev);
>>>             vega10_reg_base_init(adev);
>>>             adev->sdma.num_instances = 2;
>>>             adev->gmc.num_umc = 4;
>>> @@ -2611,6 +2582,11 @@ int amdgpu_discovery_set_ip_blocks(struct
>> amdgpu_device *adev)
>>>             adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 0, 0);
>>>             break;
>>>     case CHIP_VEGA12:
>>> +           /* This is not fatal.  We only need the discovery
>>> +            * binary for sysfs.  We don't need it for a
>>> +            * functional system.
>>> +            */
>>> +           amdgpu_discovery_init(adev);
>>>             vega10_reg_base_init(adev);
>>>             adev->sdma.num_instances = 2;
>>>             adev->gmc.num_umc = 4;
>>> @@ -2633,6 +2609,11 @@ int amdgpu_discovery_set_ip_blocks(struct
>> amdgpu_device *adev)
>>>             adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 0, 1);
>>>             break;
>>>     case CHIP_RAVEN:
>>> +           /* This is not fatal.  We only need the discovery
>>> +            * binary for sysfs.  We don't need it for a
>>> +            * functional system.
>>> +            */
>>> +           amdgpu_discovery_init(adev);
>>>             vega10_reg_base_init(adev);
>>>             adev->sdma.num_instances = 1;
>>>             adev->vcn.num_vcn_inst = 1;
>>> @@ -2674,6 +2655,11 @@ int amdgpu_discovery_set_ip_blocks(struct
>> amdgpu_device *adev)
>>>             }
>>>             break;
>>>     case CHIP_VEGA20:
>>> +           /* This is not fatal.  We only need the discovery
>>> +            * binary for sysfs.  We don't need it for a
>>> +            * functional system.
>>> +            */
>>> +           amdgpu_discovery_init(adev);
>>>             vega20_reg_base_init(adev);
>>>             adev->sdma.num_instances = 2;
>>>             adev->gmc.num_umc = 8;
>>> @@ -2697,6 +2683,11 @@ int amdgpu_discovery_set_ip_blocks(struct
>> amdgpu_device *adev)
>>>             adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 1, 0);
>>>             break;
>>>     case CHIP_ARCTURUS:
>>> +           /* This is not fatal.  We only need the discovery
>>> +            * binary for sysfs.  We don't need it for a
>>> +            * functional system.
>>> +            */
>>> +           amdgpu_discovery_init(adev);
>>>             arct_reg_base_init(adev);
>>>             adev->sdma.num_instances = 8;
>>>             adev->vcn.num_vcn_inst = 2;
>>> @@ -2725,6 +2716,11 @@ int amdgpu_discovery_set_ip_blocks(struct
>> amdgpu_device *adev)
>>>             adev->ip_versions[UVD_HWIP][1] = IP_VERSION(2, 5, 0);
>>>             break;
>>>     case CHIP_ALDEBARAN:
>>> +           /* This is not fatal.  We only need the discovery
>>> +            * binary for sysfs.  We don't need it for a
>>> +            * functional system.
>>> +            */
>>> +           amdgpu_discovery_init(adev);
>>>             aldebaran_reg_base_init(adev);
>>>             adev->sdma.num_instances = 5;
>>>             adev->vcn.num_vcn_inst = 2;
>>> @@ -2751,6 +2747,16 @@ int amdgpu_discovery_set_ip_blocks(struct
>> amdgpu_device *adev)
>>>             adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 1, 0);
>>>             break;
>>>     default:
>>> +           r = amdgpu_discovery_reg_base_init(adev);
>>> +           if (r) {
>>> +                   drm_err(&adev->ddev, "discovery failed: %d\n", r);
>>> +                   return r;
>>> +           }
>>> +
>>> +           amdgpu_discovery_harvest_ip(adev);
>>> +           amdgpu_discovery_get_gfx_info(adev);
>>> +           amdgpu_discovery_get_mall_info(adev);
>>> +           amdgpu_discovery_get_vcn_info(adev);
>>>             break;
>>>     }
>>>
> 

