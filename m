Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1ADD1170E
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 16:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C3F110E678;
	Tue,  2 Dec 2025 16:31:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y7YXcHzm";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010041.outbound.protection.outlook.com
 [52.101.193.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ACA010E678
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 16:31:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b90OsiYJyvER4ketZC9Wxl2u4deH73RfVR5CjZ5nUmS5dRVCqpom6jq2FIr3ins6zoeAuk1UN0xWyQfAQ1/PiItzBcOQRyBIDX+SmsbZwRUPoXskjqECSowQuO415H4xUlJ+J7UMqpqgO2nyFjiR7L5svdsNHuM/fHIjfZi/iRKpopt5Ak/Rp0xMsWyMeFNONc23z0JZV2uEHFAZzGNXpAbewdIPdTGAVZ1uZ4sQLUs5/1ssQ6F5HFhM9YBFAtYdAd2viwwgr30fpkYwWZZ+zH8fen1R8gdhfseO0lIFJ1Li45Ns5SBda500Up0fVhIs4O8zCYtQqGcpGZnfaecgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSRzpfDF2yBRZiJ6Fh+L4MEL6XEPhOsFAZv63AGMRlE=;
 b=yY8vqeF4qS70CNHv2CIqR8rrD3eek/In2DdgZidgj+4lsR5tad2SDf+YaFN/m00j78E+YNApk7uE8NB5l+colsVbt2ZZXP5UrdlX4093ZVQ+Y78B/nbgRmjkzuF0wqvpPT9BCHJ2u0effTfn7w53aJJOrqHeGvGjfhIjeNX+C+41meawdYNOL7gKtvZGt7UhSemAwZlVJve84E/8prjZx0mw2O+jVXT00Ir/WNu3682g6mFHZUx7wONjfzk3O2Y3IlIvf2a+n92XECgB9TDkwUoBU0Ee2Mqm1O59BX1wYD3xfrg5wcTCWr5PNU0rtdjoh/hRmE7Dq37vaDRePx56VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSRzpfDF2yBRZiJ6Fh+L4MEL6XEPhOsFAZv63AGMRlE=;
 b=Y7YXcHzm5MYy0sgMUc4iq6BzEt8BvzCyoqFZCXltmVh/xAvOfXMdq9cQDDFZfJ9nHaW0GZvVcJk98GKGS8jPYi5X81cuxesU/SV6f8mwGLDWkgCY6lWD+GXp+RFkqBG0LxVBLWLWwwHM4Q5qdU6IrpO3rR6BF8UFoa6AGDXW0nE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 16:31:20 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 16:31:20 +0000
Message-ID: <7eba047f-b427-4191-94c0-eda17bbb99ed@amd.com>
Date: Tue, 2 Dec 2025 09:31:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/amd/display: Refactor dml_core_mode_support to
 reduce stack frame
From: Alex Hung <alex.hung@amd.com>
To: Chenyu Chen <chen-yu.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Austin Zheng <austin.zheng@amd.com>
References: <20251202102437.3126523-1-chen-yu.chen@amd.com>
 <20251202102437.3126523-5-chen-yu.chen@amd.com>
 <38b6e3e5-fcee-48c4-bcac-5aee8feb289f@amd.com>
Content-Language: en-US
In-Reply-To: <38b6e3e5-fcee-48c4-bcac-5aee8feb289f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0290.namprd04.prod.outlook.com
 (2603:10b6:303:89::25) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e28c05-0863-4b1e-65fb-08de31c03970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDZRRUFVSFluQW9ObEtZT1pITlJycFlhS2xmY2UrVWNOeDA0cG9ScEsrbGdL?=
 =?utf-8?B?VnlQLzRRRFZZZUJwazBZT2VTWWsvQkNIc2ZjU3BqS2d3R09uVFVCT0NqQkRs?=
 =?utf-8?B?aG9WeFhaSTlDYXFUQm1MWHFjbGtFS1hKU1g1Vm9pay90QU0zY2lJOTNlT0lo?=
 =?utf-8?B?eFVDTEV4UGxiczNFcDJMMTFYRVJxUmxLS3JpaFp5RUtKdHRYc25yMFZEMUUy?=
 =?utf-8?B?VUNHYXdNK3BObllSUG9CYThMQXQ0SXZCQzNvNU1tcVduR3Y1OUVBV0lQd2lV?=
 =?utf-8?B?eVlkcXY2cHJRRjd4RFpJcFpyMG9BMzIva20zNnhzSzQ4ME9ycDlPNytyU2lI?=
 =?utf-8?B?SXBkcmp4RDIwajMzcVF4QjAwNWx6N09qUnc3bnI5dnFvUWczdGo3ZEJZRzRR?=
 =?utf-8?B?S283Z2tCb09Ccld1ZnFsZGZsV0dyV2VZY3BGcm5Pbjdnb1A5QUFNaEoxWlNW?=
 =?utf-8?B?NW5tYUhvRVhqOUlKdis5UnorUzI5K3dFY1d1cHNNb3I1Q3FGMTE3RS9DaGZC?=
 =?utf-8?B?UVdWeUtZKzZvUEMyRE9ldVRlNTFoSnU4d2F1N0FJbHk1b2dWTldoT3RZSzVo?=
 =?utf-8?B?bkRnZFlkVzU2RklIei9SZ0ZtUG9iV3lqVDNDOXdVVkxlRmkyMmFjY0YwWllt?=
 =?utf-8?B?K25wTjhZZ1R3ME5CdDFZb2c0OUc0cUZYMFZpOFJDbWlWM2pZUVlCZjkyVlhE?=
 =?utf-8?B?dzV3UTZZSXRTRnE5Z1IxMlJEZGNFMUVQNFBJWncxUUJQRW5jdGp2UnZQV1Jq?=
 =?utf-8?B?ejJKSkszSHJ3QzVYK21wRnd1cmVnQzJxcmcvYmdZRmtBc3JKZkY1QjNDcnZ6?=
 =?utf-8?B?Vmo2aklrTytEcFhQRlYweGJMcUFlRUFoZWQ3U3pSU2hyR3dUdlFWTTdsQmFm?=
 =?utf-8?B?UzhNV051Z1o3TS9GVGdmMER6UkZYYUFrR01sTHpLSmZTQzloTWpVc21oeldH?=
 =?utf-8?B?WDBXbWEzWjhSd01uUHNBc2pqWGp4Y2NkODlRYVZmUWdZSGR3ZXEwL2g4bVY4?=
 =?utf-8?B?anNvQStJenZ0QUhhRHZHSjU1TGZvcmF3RWNtNTRHMlgzOHNKNjA2UzFJVWpU?=
 =?utf-8?B?djd1cGdkdDMxeDZzb0w1SDA4UDZSWHVBZmRSZGFFU3ZmT0xUd0xkSjhYV25M?=
 =?utf-8?B?aUI4citoQnVwem5DblhMV2kydkdKcGlKZ084U1pVbTZKeFRIZGV4TmpucjhR?=
 =?utf-8?B?RllodGpHNVNHYXRmYnV1RVltV1l1UWVaTSsxdGFKUDVPbWtrcllVcm9BNitl?=
 =?utf-8?B?a1BoM2J4alNSSndVNlQrT1pHUlpFQjBBcXMxdTZ6T2xEQldnaVl5ajdiZllM?=
 =?utf-8?B?R1B5ZW5ZTE0vSWxYeVVzVkFzTFNsZ0FjQ3YzWnVDeUF0TkYrcjZoeGMvbWFj?=
 =?utf-8?B?TzBvYU9lcjF6WWduYzQ1SGVaOUw0cFI5MjVXSXlPQ29pVlBWUEJSdjJialFp?=
 =?utf-8?B?Y0c1MHpqcC85QjArcUtzcVVZY21lNVFJTFJRK2dJekpsZkNGVTBQU0h5RVFM?=
 =?utf-8?B?Y0xiUzZicjhxaG4weFpyV21xQzhNWGIvYVhlODNUVGttaHFUSUg2bDJucis3?=
 =?utf-8?B?cC9pNTZYVlRQQ29BYTNHRzB2Ym9mc21HZHNOeTJVZmFZVTJGU0RYYi9NbWd1?=
 =?utf-8?B?ZitNdW4rNmJNRlErMHUvKzJWbFVvSDR6aldBcVdZanE2ZVM4K2VKdGJhY3lJ?=
 =?utf-8?B?ZlY1S2JrS3RhQ0NyZ29GMWlpSWhReEFpNFoxdkxMR3RmQWlGbWYvMXFkUmlx?=
 =?utf-8?B?ekFlTTRoWFppaEUrYmVoU0RPeElYbXlDU25MU1M2US83bW81NFNWcVdoY0Uw?=
 =?utf-8?B?c1M2SDc1U1p4UW1acUF5bVVNckxXZVNGbFJTKzZtZjZXUUVhTnNoVS84Y2F1?=
 =?utf-8?B?clZqbkFmcGh1VHh1V1hTbUJOK3FkQUhhY0VBTW5DYkUvS2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alJWc0dJYWZ0OFp6N0JLaEkzK3R6Z0hKWlF3N3BTd0VWcm14cytUVEhzMUFC?=
 =?utf-8?B?K0N6bDRQSkZaMmp5ODk0WVhEVjhZWkhzV0RwbUI1eko3OW5MK0l3Y20rcmtu?=
 =?utf-8?B?SDhOY1dzWEpLdDNoTDBPdXlDVEU4bUlMU0pCNjRBVkVhTHhEaFUya2VKcDlS?=
 =?utf-8?B?WEEwYSs0WFBEZll0Mk5wY05vMUJlNkovZzQ5S1hRRmMxaVlvb1lBUWpaeHBD?=
 =?utf-8?B?M2JJeDlQVjUyakZ6UkNScmZnZ2NlRUpZcUE5NHRmdkE3SEJCc0lFTUpaV05y?=
 =?utf-8?B?R3dFNmJVSjg5UDVYSmQxaFpHT0JoZi9kM1ltNlUxUHY2S1pDS0VoK3RkaEZt?=
 =?utf-8?B?SEp5RVE1T1F0ZGlCbmE5anU5TjdRK0NaRWhZQlBqb1ZlblhsY0xaRUROOW82?=
 =?utf-8?B?cXUvbmlZZUgwY3RUbmg0eEozTWRDdWwzZGc3WDFIbFdqTmdnRmxOSDljcFBn?=
 =?utf-8?B?dXc5WXZ1VVN6NHhkMkgwTmN3NFBFQi80di91RW4xV21Wa1dmSk1hK1lpZEFW?=
 =?utf-8?B?YmNFNjNDRXBWN3o5U0ZyK0Z6aWFSWGQ5SmJxenZTYW1ydXRQNWNQM3dSSVp0?=
 =?utf-8?B?OXFGcnkzeVJuNU96TTlMQUpZS282Rnc1M2c3SDBlUXdFUktCSGZJMDd6TWNX?=
 =?utf-8?B?bk5ORjJWdFJ4UHd2MDAwZ29aZDJmcFB0M29sOU4zTE44V3JUUUlwSlBMdGY5?=
 =?utf-8?B?dWYwdVRsMmtPQ2hDYUdpQXNmNzFWRTcranNKM3BSY0lzZVR1aGlONS9wcU5W?=
 =?utf-8?B?QTE2MnVYaDNIVTFzaTFvSkJHQ3daUCtNdWxmTjRReStXdEc2TDRjeTRORjFh?=
 =?utf-8?B?SllrMU9qUVUwUVorZUlxRWpiR0xkZGtPMXYrRDlxaGFmK0cxNFphMFVvdWVj?=
 =?utf-8?B?Vmp6cEtzSkRnUklKbklKTCttNG01bVZnT01qOVNUZ1diM1VsMzEvUFQ3VFpv?=
 =?utf-8?B?cmJsN1NqZUpMTGUrV0preFhRTlhCOTBCZlpjaFFTZXI3ME9wbWsybFA4V1pZ?=
 =?utf-8?B?bENpTGhWdHYvU1BEUzRLZDNybDdVMmtzaEhLZk0zNURScmp2cjI2VGE5Z2g3?=
 =?utf-8?B?K2xxUlRPc0xRQXAzMjk3cWJKK1RrVmxJQWwydWl3bzVNU2RoZ29QRWZ0YXZs?=
 =?utf-8?B?N1dCRXEyOXRzbzVZb2RmUHhKWSsxbHBuYVlWbTVxYkwzSndPMzNqUDZkeHAz?=
 =?utf-8?B?Q1BwNDM1MUtmNVFVeUpyamxtUWpleGRJSG9EM3cvN3YyL3VVZVVOdVNQWTJk?=
 =?utf-8?B?aHBxWE9aWS9VY1N1Q253elhGb3ROeFZjSDltVUl0dWlxVUcrK0RscHVGRDJ4?=
 =?utf-8?B?OXBiTWplZXd2UzV0OVJCcnU5clc4WlIyN0VKZjgrZ3ZXTG5RNzZBK1NJSHd4?=
 =?utf-8?B?ai96cE1tREtRWE1EN2tuTmxRUkhNcnN6M0cwM3VaRjV5UjVmOHVkdUdlcU0r?=
 =?utf-8?B?TGxDRjVLUjJ1VlNUYkJ5ZWJqR2QyUE9wMkUvVUJhdXFBUTdmR1Q1QUY4SGNR?=
 =?utf-8?B?OVpPeWVSU2VBanM0WWsxTElBSmFQSmQ0WEZUSG93eEVOZzhjR29tQ2dlZEpr?=
 =?utf-8?B?SjhpckxKN29OZ01yMmxiY2I2VGU4WEF3OU9oeE1MbXRoVHFiVDZON25VVnhM?=
 =?utf-8?B?cjQwOFo0SGtuVmtEZFB0eGMxR1dHc0Z0Si85dzNqZEptRDRpQ3U3UkMrYWFk?=
 =?utf-8?B?OHRKUElCL0lZMDN0WnFabVJYemZTOVViRWRVWEI2c2E1OXM4UEF4aGZpeVdt?=
 =?utf-8?B?ZVByL054NTRrcUlReXV5Mk1NMmsxNGFjUjZDMzl4ODc1cWE1bXFRS1JtdVZP?=
 =?utf-8?B?bXkwbDJtd2VoRGVuSDFlaUJtdzZZYzdjdHIzcE5renk0Y1AwK0RzK3oxdnZu?=
 =?utf-8?B?dWM1bFRWZ1dZRUxWaXFBWXlsZ3QxYkdRcFZ2VzFBQlhxTmJVZEIvWGt6cEVk?=
 =?utf-8?B?M3RQVW5zVXJsTGFTTjdjS2QyWi91TEdOSlo4eCsyRStSUWlBRUY5WlFvT1ha?=
 =?utf-8?B?d0ZlNGNaRzhLSjRKdzVDaUFJWkpPZE9SaE1DWnRlRGljM3FDUEhhVVNHU2lW?=
 =?utf-8?B?MS90SDk2NTFQbmx5aDRZTWZ2NmFlbXRYeXUxWS9nRTBZaE01SjVuTEJQYXdS?=
 =?utf-8?Q?dGBIhXEkMozplck4YlyMvL6y1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e28c05-0863-4b1e-65fb-08de31c03970
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 16:31:20.2256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYmOfuzCV0E4280J6RhZKogVr/e1lgYUlAJsFlzLVRq1rvo4eGBgk56GEXJ0NCiyqND88bMW8zruHX58D4D9pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
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



On 12/2/25 09:29, Alex Hung wrote:
> 
> 
> On 12/2/25 03:21, Chenyu Chen wrote:
>> From: Alex Hung <alex.hung@amd.com>
>>
>> [WHAT]
>> When compiling Linux kernel with clang, the following warning / error
>> messages pops up:
>>
>> drivers/gpu/drm/amd/amdgpu/../dal-dev/dc/dml2_0/ 
>> display_mode_core.c:6853:12:
>> error: stack frame size (2120) exceeds limit (2056) in
>> 'dml_core_mode_support' [-Werror,-Wframe-larger-than]
>>   6853 | dml_bool_t dml_core_mode_support(struct display_mode_lib_st
>> *mode_lib)
>>
>> [HOW]
>> Refactoring CalculateVMRowAndSwath_params assignments to a new function
>> helps reduce the stack frame size in dml_core_mode_support.
>>
> Hi Chenyu,
> 
> A bug seems to be related. Can you add a buglink? Thanks.
> 
> Buglink: https://gitlab.freedesktop.org/drm/amd/-/issues/4733

Correction, Add "Closes" instead of "Buglink"

> 
>> Reviewed-by: Austin Zheng <austin.zheng@amd.com>
>> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>> Signed-off-by: Alex Hung <alex.hung@amd.com>
>> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
>> ---
>>   .../amd/display/dc/dml2_0/display_mode_core.c | 134 ++++++++++--------
>>   1 file changed, 71 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c 
>> b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
>> index c468f492b876..09303c282495 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
>> @@ -6711,6 +6711,76 @@ static noinline_for_stack void 
>> dml_prefetch_check(struct display_mode_lib_st *mo
>>       } // for j
>>   }
>> +static noinline_for_stack void set_vm_row_and_swath_parameters(struct 
>> display_mode_lib_st *mode_lib)
>> +{
>> +    struct CalculateVMRowAndSwath_params_st 
>> *CalculateVMRowAndSwath_params = &mode_lib- 
>> >scratch.CalculateVMRowAndSwath_params;
>> +    struct dml_core_mode_support_locals_st *s = &mode_lib- 
>> >scratch.dml_core_mode_support_locals;
>> +
>> +    CalculateVMRowAndSwath_params->NumberOfActiveSurfaces = mode_lib- 
>> >ms.num_active_planes;
>> +    CalculateVMRowAndSwath_params->myPipe = s->SurfParameters;
>> +    CalculateVMRowAndSwath_params->SurfaceSizeInMALL = mode_lib- 
>> >ms.SurfaceSizeInMALL;
>> +    CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsLuma = 
>> mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_luma;
>> +    CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsChroma = 
>> mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_chroma;
>> +    CalculateVMRowAndSwath_params->DCCMetaBufferSizeBytes = mode_lib- 
>> >ms.ip.dcc_meta_buffer_size_bytes;
>> +    CalculateVMRowAndSwath_params->UseMALLForStaticScreen = mode_lib- 
>> >ms.cache_display_cfg.plane.UseMALLForStaticScreen;
>> +    CalculateVMRowAndSwath_params->UseMALLForPStateChange = mode_lib- 
>> >ms.cache_display_cfg.plane.UseMALLForPStateChange;
>> +    CalculateVMRowAndSwath_params->MALLAllocatedForDCN = mode_lib- 
>> >ms.soc.mall_allocated_for_dcn_mbytes;
>> +    CalculateVMRowAndSwath_params->SwathWidthY = mode_lib- 
>> >ms.SwathWidthYThisState;
>> +    CalculateVMRowAndSwath_params->SwathWidthC = mode_lib- 
>> >ms.SwathWidthCThisState;
>> +    CalculateVMRowAndSwath_params->GPUVMEnable = mode_lib- 
>> >ms.cache_display_cfg.plane.GPUVMEnable;
>> +    CalculateVMRowAndSwath_params->HostVMEnable = mode_lib- 
>> >ms.cache_display_cfg.plane.HostVMEnable;
>> +    CalculateVMRowAndSwath_params->HostVMMaxNonCachedPageTableLevels 
>> = mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
>> +    CalculateVMRowAndSwath_params->GPUVMMaxPageTableLevels = 
>> mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
>> +    CalculateVMRowAndSwath_params->GPUVMMinPageSizeKBytes = mode_lib- 
>> >ms.cache_display_cfg.plane.GPUVMMinPageSizeKBytes;
>> +    CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib- 
>> >ms.soc.hostvm_min_page_size_kbytes * 1024;
>> +    CalculateVMRowAndSwath_params->PTEBufferModeOverrideEn = 
>> mode_lib->ms.cache_display_cfg.plane.PTEBufferModeOverrideEn;
>> +    CalculateVMRowAndSwath_params->PTEBufferModeOverrideVal = 
>> mode_lib->ms.cache_display_cfg.plane.PTEBufferMode;
>> +    CalculateVMRowAndSwath_params->PTEBufferSizeNotExceeded = 
>> mode_lib->ms.PTEBufferSizeNotExceededPerState;
>> +    CalculateVMRowAndSwath_params->DCCMetaBufferSizeNotExceeded = 
>> mode_lib->ms.DCCMetaBufferSizeNotExceededPerState;
>> +    CalculateVMRowAndSwath_params->dpte_row_width_luma_ub = s- 
>> >dummy_integer_array[0];
>> +    CalculateVMRowAndSwath_params->dpte_row_width_chroma_ub = s- 
>> >dummy_integer_array[1];
>> +    CalculateVMRowAndSwath_params->dpte_row_height_luma = mode_lib- 
>> >ms.dpte_row_height;
>> +    CalculateVMRowAndSwath_params->dpte_row_height_chroma = mode_lib- 
>> >ms.dpte_row_height_chroma;
>> +    CalculateVMRowAndSwath_params->dpte_row_height_linear_luma = s- 
>> >dummy_integer_array[2]; // VBA_DELTA
>> +    CalculateVMRowAndSwath_params->dpte_row_height_linear_chroma = s- 
>> >dummy_integer_array[3]; // VBA_DELTA
>> +    CalculateVMRowAndSwath_params->meta_req_width = s- 
>> >dummy_integer_array[4];
>> +    CalculateVMRowAndSwath_params->meta_req_width_chroma = s- 
>> >dummy_integer_array[5];
>> +    CalculateVMRowAndSwath_params->meta_req_height = s- 
>> >dummy_integer_array[6];
>> +    CalculateVMRowAndSwath_params->meta_req_height_chroma = s- 
>> >dummy_integer_array[7];
>> +    CalculateVMRowAndSwath_params->meta_row_width = s- 
>> >dummy_integer_array[8];
>> +    CalculateVMRowAndSwath_params->meta_row_width_chroma = s- 
>> >dummy_integer_array[9];
>> +    CalculateVMRowAndSwath_params->meta_row_height = mode_lib- 
>> >ms.meta_row_height;
>> +    CalculateVMRowAndSwath_params->meta_row_height_chroma = mode_lib- 
>> >ms.meta_row_height_chroma;
>> +    CalculateVMRowAndSwath_params->vm_group_bytes = s- 
>> >dummy_integer_array[10];
>> +    CalculateVMRowAndSwath_params->dpte_group_bytes = mode_lib- 
>> >ms.dpte_group_bytes;
>> +    CalculateVMRowAndSwath_params->PixelPTEReqWidthY = s- 
>> >dummy_integer_array[11];
>> +    CalculateVMRowAndSwath_params->PixelPTEReqHeightY = s- 
>> >dummy_integer_array[12];
>> +    CalculateVMRowAndSwath_params->PTERequestSizeY = s- 
>> >dummy_integer_array[13];
>> +    CalculateVMRowAndSwath_params->PixelPTEReqWidthC = s- 
>> >dummy_integer_array[14];
>> +    CalculateVMRowAndSwath_params->PixelPTEReqHeightC = s- 
>> >dummy_integer_array[15];
>> +    CalculateVMRowAndSwath_params->PTERequestSizeC = s- 
>> >dummy_integer_array[16];
>> +    CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_l = s- 
>> >dummy_integer_array[17];
>> +    CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_l = s- 
>> >dummy_integer_array[18];
>> +    CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_c = s- 
>> >dummy_integer_array[19];
>> +    CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_c = s- 
>> >dummy_integer_array[20];
>> +    CalculateVMRowAndSwath_params->PrefetchSourceLinesY = mode_lib- 
>> >ms.PrefetchLinesYThisState;
>> +    CalculateVMRowAndSwath_params->PrefetchSourceLinesC = mode_lib- 
>> >ms.PrefetchLinesCThisState;
>> +    CalculateVMRowAndSwath_params->VInitPreFillY = mode_lib- 
>> >ms.PrefillY;
>> +    CalculateVMRowAndSwath_params->VInitPreFillC = mode_lib- 
>> >ms.PrefillC;
>> +    CalculateVMRowAndSwath_params->MaxNumSwathY = mode_lib- 
>> >ms.MaxNumSwY;
>> +    CalculateVMRowAndSwath_params->MaxNumSwathC = mode_lib- 
>> >ms.MaxNumSwC;
>> +    CalculateVMRowAndSwath_params->meta_row_bw = mode_lib- 
>> >ms.meta_row_bandwidth_this_state;
>> +    CalculateVMRowAndSwath_params->dpte_row_bw = mode_lib- 
>> >ms.dpte_row_bandwidth_this_state;
>> +    CalculateVMRowAndSwath_params->PixelPTEBytesPerRow = mode_lib- 
>> >ms.DPTEBytesPerRowThisState;
>> +    CalculateVMRowAndSwath_params->PDEAndMetaPTEBytesFrame = 
>> mode_lib->ms.PDEAndMetaPTEBytesPerFrameThisState;
>> +    CalculateVMRowAndSwath_params->MetaRowByte = mode_lib- 
>> >ms.MetaRowBytesThisState;
>> +    CalculateVMRowAndSwath_params->use_one_row_for_frame = mode_lib- 
>> >ms.use_one_row_for_frame_this_state;
>> +    CalculateVMRowAndSwath_params->use_one_row_for_frame_flip = 
>> mode_lib->ms.use_one_row_for_frame_flip_this_state;
>> +    CalculateVMRowAndSwath_params->UsesMALLForStaticScreen = s- 
>> >dummy_boolean_array[0];
>> +    CalculateVMRowAndSwath_params->PTE_BUFFER_MODE = s- 
>> >dummy_boolean_array[1];
>> +    CalculateVMRowAndSwath_params->BIGK_FRAGMENT_SIZE = s- 
>> >dummy_integer_array[21];
>> +}
>> +
>>   /// @brief The Mode Support function.
>>   dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
>>   {
>> @@ -7683,69 +7753,7 @@ dml_bool_t dml_core_mode_support(struct 
>> display_mode_lib_st *mode_lib)
>>               s->SurfParameters[k].SwathHeightC = mode_lib- 
>> >ms.SwathHeightCThisState[k];
>>           }
>> -        CalculateVMRowAndSwath_params->NumberOfActiveSurfaces = 
>> mode_lib->ms.num_active_planes;
>> -        CalculateVMRowAndSwath_params->myPipe = s->SurfParameters;
>> -        CalculateVMRowAndSwath_params->SurfaceSizeInMALL = mode_lib- 
>> >ms.SurfaceSizeInMALL;
>> -        CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsLuma = 
>> mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_luma;
>> -        CalculateVMRowAndSwath_params->PTEBufferSizeInRequestsChroma 
>> = mode_lib->ms.ip.dpte_buffer_size_in_pte_reqs_chroma;
>> -        CalculateVMRowAndSwath_params->DCCMetaBufferSizeBytes = 
>> mode_lib->ms.ip.dcc_meta_buffer_size_bytes;
>> -        CalculateVMRowAndSwath_params->UseMALLForStaticScreen = 
>> mode_lib->ms.cache_display_cfg.plane.UseMALLForStaticScreen;
>> -        CalculateVMRowAndSwath_params->UseMALLForPStateChange = 
>> mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange;
>> -        CalculateVMRowAndSwath_params->MALLAllocatedForDCN = 
>> mode_lib->ms.soc.mall_allocated_for_dcn_mbytes;
>> -        CalculateVMRowAndSwath_params->SwathWidthY = mode_lib- 
>> >ms.SwathWidthYThisState;
>> -        CalculateVMRowAndSwath_params->SwathWidthC = mode_lib- 
>> >ms.SwathWidthCThisState;
>> -        CalculateVMRowAndSwath_params->GPUVMEnable = mode_lib- 
>> >ms.cache_display_cfg.plane.GPUVMEnable;
>> -        CalculateVMRowAndSwath_params->HostVMEnable = mode_lib- 
>> >ms.cache_display_cfg.plane.HostVMEnable;
>> -        CalculateVMRowAndSwath_params- 
>> >HostVMMaxNonCachedPageTableLevels = mode_lib- 
>> >ms.cache_display_cfg.plane.HostVMMaxPageTableLevels;
>> -        CalculateVMRowAndSwath_params->GPUVMMaxPageTableLevels = 
>> mode_lib->ms.cache_display_cfg.plane.GPUVMMaxPageTableLevels;
>> -        CalculateVMRowAndSwath_params->GPUVMMinPageSizeKBytes = 
>> mode_lib->ms.cache_display_cfg.plane.GPUVMMinPageSizeKBytes;
>> -        CalculateVMRowAndSwath_params->HostVMMinPageSize = mode_lib- 
>> >ms.soc.hostvm_min_page_size_kbytes * 1024;
>> -        CalculateVMRowAndSwath_params->PTEBufferModeOverrideEn = 
>> mode_lib->ms.cache_display_cfg.plane.PTEBufferModeOverrideEn;
>> -        CalculateVMRowAndSwath_params->PTEBufferModeOverrideVal = 
>> mode_lib->ms.cache_display_cfg.plane.PTEBufferMode;
>> -        CalculateVMRowAndSwath_params->PTEBufferSizeNotExceeded = 
>> mode_lib->ms.PTEBufferSizeNotExceededPerState;
>> -        CalculateVMRowAndSwath_params->DCCMetaBufferSizeNotExceeded = 
>> mode_lib->ms.DCCMetaBufferSizeNotExceededPerState;
>> -        CalculateVMRowAndSwath_params->dpte_row_width_luma_ub = s- 
>> >dummy_integer_array[0];
>> -        CalculateVMRowAndSwath_params->dpte_row_width_chroma_ub = s- 
>> >dummy_integer_array[1];
>> -        CalculateVMRowAndSwath_params->dpte_row_height_luma = 
>> mode_lib->ms.dpte_row_height;
>> -        CalculateVMRowAndSwath_params->dpte_row_height_chroma = 
>> mode_lib->ms.dpte_row_height_chroma;
>> -        CalculateVMRowAndSwath_params->dpte_row_height_linear_luma = 
>> s->dummy_integer_array[2]; // VBA_DELTA
>> -        CalculateVMRowAndSwath_params->dpte_row_height_linear_chroma 
>> = s->dummy_integer_array[3]; // VBA_DELTA
>> -        CalculateVMRowAndSwath_params->meta_req_width = s- 
>> >dummy_integer_array[4];
>> -        CalculateVMRowAndSwath_params->meta_req_width_chroma = s- 
>> >dummy_integer_array[5];
>> -        CalculateVMRowAndSwath_params->meta_req_height = s- 
>> >dummy_integer_array[6];
>> -        CalculateVMRowAndSwath_params->meta_req_height_chroma = s- 
>> >dummy_integer_array[7];
>> -        CalculateVMRowAndSwath_params->meta_row_width = s- 
>> >dummy_integer_array[8];
>> -        CalculateVMRowAndSwath_params->meta_row_width_chroma = s- 
>> >dummy_integer_array[9];
>> -        CalculateVMRowAndSwath_params->meta_row_height = mode_lib- 
>> >ms.meta_row_height;
>> -        CalculateVMRowAndSwath_params->meta_row_height_chroma = 
>> mode_lib->ms.meta_row_height_chroma;
>> -        CalculateVMRowAndSwath_params->vm_group_bytes = s- 
>> >dummy_integer_array[10];
>> -        CalculateVMRowAndSwath_params->dpte_group_bytes = mode_lib- 
>> >ms.dpte_group_bytes;
>> -        CalculateVMRowAndSwath_params->PixelPTEReqWidthY = s- 
>> >dummy_integer_array[11];
>> -        CalculateVMRowAndSwath_params->PixelPTEReqHeightY = s- 
>> >dummy_integer_array[12];
>> -        CalculateVMRowAndSwath_params->PTERequestSizeY = s- 
>> >dummy_integer_array[13];
>> -        CalculateVMRowAndSwath_params->PixelPTEReqWidthC = s- 
>> >dummy_integer_array[14];
>> -        CalculateVMRowAndSwath_params->PixelPTEReqHeightC = s- 
>> >dummy_integer_array[15];
>> -        CalculateVMRowAndSwath_params->PTERequestSizeC = s- 
>> >dummy_integer_array[16];
>> -        CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_l = 
>> s->dummy_integer_array[17];
>> -        CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_l 
>> = s->dummy_integer_array[18];
>> -        CalculateVMRowAndSwath_params->dpde0_bytes_per_frame_ub_c = 
>> s->dummy_integer_array[19];
>> -        CalculateVMRowAndSwath_params->meta_pte_bytes_per_frame_ub_c 
>> = s->dummy_integer_array[20];
>> -        CalculateVMRowAndSwath_params->PrefetchSourceLinesY = 
>> mode_lib->ms.PrefetchLinesYThisState;
>> -        CalculateVMRowAndSwath_params->PrefetchSourceLinesC = 
>> mode_lib->ms.PrefetchLinesCThisState;
>> -        CalculateVMRowAndSwath_params->VInitPreFillY = mode_lib- 
>> >ms.PrefillY;
>> -        CalculateVMRowAndSwath_params->VInitPreFillC = mode_lib- 
>> >ms.PrefillC;
>> -        CalculateVMRowAndSwath_params->MaxNumSwathY = mode_lib- 
>> >ms.MaxNumSwY;
>> -        CalculateVMRowAndSwath_params->MaxNumSwathC = mode_lib- 
>> >ms.MaxNumSwC;
>> -        CalculateVMRowAndSwath_params->meta_row_bw = mode_lib- 
>> >ms.meta_row_bandwidth_this_state;
>> -        CalculateVMRowAndSwath_params->dpte_row_bw = mode_lib- 
>> >ms.dpte_row_bandwidth_this_state;
>> -        CalculateVMRowAndSwath_params->PixelPTEBytesPerRow = 
>> mode_lib->ms.DPTEBytesPerRowThisState;
>> -        CalculateVMRowAndSwath_params->PDEAndMetaPTEBytesFrame = 
>> mode_lib->ms.PDEAndMetaPTEBytesPerFrameThisState;
>> -        CalculateVMRowAndSwath_params->MetaRowByte = mode_lib- 
>> >ms.MetaRowBytesThisState;
>> -        CalculateVMRowAndSwath_params->use_one_row_for_frame = 
>> mode_lib->ms.use_one_row_for_frame_this_state;
>> -        CalculateVMRowAndSwath_params->use_one_row_for_frame_flip = 
>> mode_lib->ms.use_one_row_for_frame_flip_this_state;
>> -        CalculateVMRowAndSwath_params->UsesMALLForStaticScreen = s- 
>> >dummy_boolean_array[0];
>> -        CalculateVMRowAndSwath_params->PTE_BUFFER_MODE = s- 
>> >dummy_boolean_array[1];
>> -        CalculateVMRowAndSwath_params->BIGK_FRAGMENT_SIZE = s- 
>> >dummy_integer_array[21];
>> +        set_vm_row_and_swath_parameters(mode_lib);
>>           CalculateVMRowAndSwath(&mode_lib->scratch,
>>               CalculateVMRowAndSwath_params);
> 

