Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7FDC3DA5D
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 03:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63C1310E1F8;
	Tue, 23 Jul 2024 03:01:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ziecvOM1";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE5710E1F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 03:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJwIx+3o8TJ5DNS8H0LE4XqwaMN9U9IQyauoU5DKrAF1pn0dLSHx510he+rh0rnxqrPZB+5F2Bm10sdpD3tKRTv8AwU+Yl0Rn4pVHdaW6+YzSMZ78TDjc3lskAIE39vp+dZyXDvZ8dIp9KZ7G1iiFVRp64hCKW5USx0oCr3oJNkxriHD0O/ZwJN24++DA4vBn0yARbQgfpKykgm0TIOMcgKNLHyPESLT0ixQ5JpV9gtPE3eZLi/1intIxOJy3uq/8TJqqo1v6AbyGRE5ml0/CZYfRQw6djxtMtqL1r+F5NOctf0mzIw/3p9p5e5FV+M967tDYeqLfj8WfCKyeJ9kRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z63Xo03Bq6O1kFpgng7Y83dyNjbcJzIWKFVH2dRi1oQ=;
 b=gImoyH1XfmrnXT11jE7ajS9/z4PUsYfGL8D3dHWT1Yw1cxS+FmM1FbGVwyjSvstWijiE8+RKuAYxrXW56KaUbxiiJsBvQKqjUYQappyW3pzeB9iSEhjDyCXoNJDC47rKCB/xbTh7uuXBx5AOj2Pt5CPSp4WCGo+0zFT5B/0MrwrcU0ApXS//Kp8BkNZAqRG+ge8O+CX/gpUbJoPwwc4lHNL/wnt+xjxesdzG+hluS/yJ76KOCjC6s0kAQEojDN7ruQFm6fdvbc1rdo0tdgkYNiMx+LrULv2LgSbRbpDfAqzvZWVHEASBhMdwPEaUXL9MJZvmb8VQpqlivJLsA8KQGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z63Xo03Bq6O1kFpgng7Y83dyNjbcJzIWKFVH2dRi1oQ=;
 b=ziecvOM1z/ReoiyUwXYTWhlBABCTa8zpQxafF85gvnF0pQIHJAg9CSjx9Xr+iVjfR9wwrRJD6nfNYRdn9mQjtnneY8kO8nmF1IFoS4qtC5DpQwYQrWDsU6ZUkdMGnSmJ/GAi2N4xk4PtQYYXpUFPM4ci2yN5490qUIns6D1/e3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Tue, 23 Jul
 2024 03:01:48 +0000
Received: from IA1PR12MB8495.namprd12.prod.outlook.com
 ([fe80::97d3:87e9:1c4c:c692]) by IA1PR12MB8495.namprd12.prod.outlook.com
 ([fe80::97d3:87e9:1c4c:c692%4]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 03:01:48 +0000
Message-ID: <4755ee64-e209-4361-9794-8f7c44652f46@amd.com>
Date: Mon, 22 Jul 2024 21:01:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Add NULL check for clk_mgr in
 dcn32_init_hw
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tom Chung <chiahsuan.chung@amd.com>,
 Roman Li <roman.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240721062216.3151119-2-srinivasan.shanmugam@amd.com>
 <20240722111440.3898146-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20240722111440.3898146-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:303:b6::15) To IA1PR12MB8495.namprd12.prod.outlook.com
 (2603:10b6:208:44d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8495:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a7e9ab-8a07-4a90-6a60-08dcaac3cb28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2VCQjJGV3l2VTE1ZStnU0dOYUpyNWR0cXRMeldBWHFDa1RvaENrelJFTmxk?=
 =?utf-8?B?Z1M5UFlDRmpkdTZMeUpZdTVpV3c1NVJkZUxySjgzSGM3eFlvb3hGdld5b2xV?=
 =?utf-8?B?ZFpwY3B3VjNER01ocVBQaEdNcE5oWWVRUkJDRGJOaTdMUVdJQXdtb1ZzKzdl?=
 =?utf-8?B?c2lJWXl0U0lZUWx4SzVONjBabndWRi83TWMvc2xIWlRhSE1HSzYzc1ZHR0s3?=
 =?utf-8?B?a2lnaWkxYW5VY21nNyttRDZUVDFORGNOeFBJOFBzTUFxQS9QejJ6L3J4cHdr?=
 =?utf-8?B?Q2drRkt5YjdISHVUZklrSThwWlpqaDJWRUxyNDliRmV2YWYydWEzTUtSek1w?=
 =?utf-8?B?cFZDRFFXenFHaWc5T1p2MmZVQ0JZUFBEYlNDY0JmMTBXa3JBY3BpaEh5WUll?=
 =?utf-8?B?aUFBeHZoU3NZclE2VDFZZmZHaFpjd3l4dk9YZFRybitCUkxYS0xuZG1TYlE5?=
 =?utf-8?B?S2ZTSnFxUDVmdTY5Qm1LMnplMytEU29FUytFUjFlc3lzdGJpQSsyZzNUQU1w?=
 =?utf-8?B?ZjlWVGk1WXAxVStUbjVMMmpnc2NSNHpsOUNKNlhYTnRHSGJIOXZ0Uk9JRVhW?=
 =?utf-8?B?N3dwbnlRQWxsMkhaQjk1K3M5Y3krWWtYQ0huSVN5aStEOVFxemRNZU5wRFpv?=
 =?utf-8?B?ZWNDb29odG5CaWlEZ2tLYTdPaUhUMFNGRk8wci9RbnFjSDdsQ2Jocm9BL1px?=
 =?utf-8?B?L0kweGo3VWwvcXg4QXVsWHkzNVI4SFIrY01IR3dESi9XTisyVG9VcitEU0l6?=
 =?utf-8?B?M1JQVUFjY21RWHNKYWlnNEFkSUlGeUozZGh4NXJZL09FMCt4QVhDbEJkaEZ6?=
 =?utf-8?B?azZJdlNSUHlZUzN4SmttNlRXckpKbnNJVXBFd3lXNGNiUEdHdXV1MURIY2ZX?=
 =?utf-8?B?WHR4elpwYnNEdklJTUxxZzU3SnU2OWlZckZtT2QzMUd0UkdyRm9aS2s4R1Ux?=
 =?utf-8?B?blhVbWVNT0pNNHp1NWpzM2xRMDByZ3pROHlYTnliaGVSUUhTckt2MDJPWVZM?=
 =?utf-8?B?Zi94cTJ2U2J6VDZTQVlEaEErQ0RoRXdlcVI5UVNzWXFDVmgvZkRMZmNZYWRk?=
 =?utf-8?B?eDE1dU5rQUtuazY5NmdtRms0cDVxaUZQQWRTcVdNS3hIUFBORlk0Yko5M255?=
 =?utf-8?B?VHp2Z3hTY052dENkNStBTzkvdFZTVFJUelBjNE9XNXpUejBpeEpLQ1A4MlR5?=
 =?utf-8?B?aUdIVDI1Mmt4aS9XdUdudkI1SzNISEFITm5LM08rc0tBVFVYRGNWWkxjOHpP?=
 =?utf-8?B?U0JNZUlMNm1rL09qWlFPS2N1UnhPUlBRT1ozZDhlWmpQTVMxQUx3Z3lEYytr?=
 =?utf-8?B?MW9teG1QN3FyU3Uza2VSTmJoS3ZvWmlZR3FvUTlJbEcrM1hoMm1yQVJ6TlZz?=
 =?utf-8?B?YXVsUTN2UENmN3N0c0k1WE1OUDRhWmR5SUJHajRTb3I0bXphTHBDbW5NUGQz?=
 =?utf-8?B?QTBWSk9kdG1lSW5YQ09GUVUrNG4weU9RSGZkdWNZZ0lXVFh1bnQzclhzZzlT?=
 =?utf-8?B?TlI2N210enRjM2I4anhtcElhYmJ2NTRsZTd5bjBwL2J6M0Yyb2QxYTNVTG1q?=
 =?utf-8?B?STczd1RmcENyZDlITHdjaS9QbjBFRENLd25JVUZaQjVyaXIrclVHM1hzbk02?=
 =?utf-8?B?TXRCYlpjdXlwV0lUcEQ1VjU0WTJmOVQrQ3ZVUVFRaUQ3ZDNEMElGWm8zVXBx?=
 =?utf-8?B?Ky8vdHR2WUk1eW9NYXk4VXE0clRvRWFuV2ZlR2N2SDFGbUR0aFlJaHlFcWVk?=
 =?utf-8?B?WnRoNVhpcnlxQkJLNzZtekhNQzcvdGZYQlhmT0pKMU9aWnF5WGllbFQ5NXc5?=
 =?utf-8?B?YVFqaTNOVUNjQmk5OVdWQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8495.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFJhRHNaUk5RNGV3dDZTZDJQT1RrWG1WS3QyZVN0N29IdzlOT1licDdzcGlR?=
 =?utf-8?B?azI1SkxaNTJHMXZ4d1VjeVMzWnI5bno2WHRiaitiKzBoUFZnMy9UNTFGTzZh?=
 =?utf-8?B?Mi9RVzJvS01tcGFjNW9tcnpucTN4L2piMXoySUtMUDNTUlU0WXJGQlN1QU9v?=
 =?utf-8?B?OCtMdUgzQWhsL09YTUkyZkJKc2t4dlV4ZlFWcG5tZkhRRVpoRXh0NHc4bHov?=
 =?utf-8?B?TERPTWtIZ2xxeno3QXF0eXdscVpZSWpsWlE4aUdLdHY3Y2lLa3ZoQk5ROVJ5?=
 =?utf-8?B?ekloSk8rMXlZa1VpaWprVytDTmwvcE43S3NGbGZwNjhEaGF5K25LWHZIeVlN?=
 =?utf-8?B?c3ZXcCtwL3VFTERKTG5aN0pHSXhxZUlqSmg4eThLNncxRXFaL280clhhMXRJ?=
 =?utf-8?B?V2g1WEhDK01vS25XcklrVnhMQ3BSNlBnS3JNSVB2TGFVQm1MU3h1cFY1cnhq?=
 =?utf-8?B?SW4wc2U2bi9OcWdGRzF5V1hNcnBVN1ZqWHl0UkpKaXNwbkNacDBMNGtSamFQ?=
 =?utf-8?B?Z3BRTjFKTitzaENHbkxnTXl5UFZKZDd0UjZVL1NCMFdaR2VOTFd2ZENUQmdm?=
 =?utf-8?B?VlVJelY2RG1pOWdXYXAvM2pMbWRRekNDdXd6UEMrUU94Nm1wWERRS2I5d2pa?=
 =?utf-8?B?c3BTTTQ2ZUlpYWFZejhXSzFpM3RRZzZqc2pCbkl1TmVtampuTjc5UXlqeTJj?=
 =?utf-8?B?NWtPT3hwOVg0czMrcURpV1lES1NGczgrVWh2UEFYc2t0Rnd4S2VZWUxjNUNK?=
 =?utf-8?B?bE93d2FCNVIwcDZEWTcySXd6MVRNY2lVMmk0RDZ6ekdNZkpaOUdzbXZvcVpH?=
 =?utf-8?B?VFIwbURIOHJ4VmpBamJuRzluckt5YXdLYXo0NXdvbkY3ZXQ2emo1SGFvM2dl?=
 =?utf-8?B?WEltWDRQNTNSSVUxbTJYUkx4YTYrY2JzMEJlZzBxSStReU1rV1hvVVNBWlB0?=
 =?utf-8?B?WjdIZnZQdlRYRzJxaVlFNTB0SlZ3dGVWa21JcFMzYzZvSjRXekFqQnpESENo?=
 =?utf-8?B?a2l0UW1XSExFdzZycDJhaFdyQlNPWUlJL0ErMXVMRGtOWE9mbVNDRnlyZktm?=
 =?utf-8?B?alRERXZJQmE2T0tLSUdIbEhYZlB3V0hkY0Q4K2x4OU9WQk5KSEYwUUR0cDI4?=
 =?utf-8?B?QmZDbElVZTlxeXg0ekxQOXZiMzFXazNVTUR2NWhzeXplNjR5OFRLUHJ2WlBN?=
 =?utf-8?B?YnFJQVU2a3JFQTZSMUlReERReVJNcGpYVCt2S2N6bDVvOU5OWGlSSnBxTVR4?=
 =?utf-8?B?S0Z6VUxiejFzWHoySFdGT25DbWpjNXcyM2I2N1J1MkoybjRRQllVVGlscVdG?=
 =?utf-8?B?K28rcWJaWEE5V1RyK2U3UUE0a09Nay9acUFDTGpSLzVsbUdkQkRHZ3p4Q3Q0?=
 =?utf-8?B?KzB2RFdJYlNCck1wTXlaMDVNUUp4Zkt4ODJjamhXR2x3UGVBWENUendUcy80?=
 =?utf-8?B?UGZmeUJodkVaMXJ5SHEvUHk3ZThmdXF6aENKVEloaEFGSGtzM2VzenEvWmVY?=
 =?utf-8?B?L3ZPYVIycTJUT1JyalFuOWNzU3piNWtHYnNmcGlqKzJvZzBRRmorYW4zcGd2?=
 =?utf-8?B?YllzQmd3UDVybms2eW8yUmlsZzZ6RGlhUDluSnc0N0YxTnBXb0l1cWJjNU03?=
 =?utf-8?B?MkZRRlV6L0hodmx4c0NkMzR0Ym1aMEEzLzNGY2ljZmRkcUlBMU9HY3FOOUdG?=
 =?utf-8?B?WFl2R2RCVURJaEFqa0hxSmpBU0lubHozcGU4cTdZRGs2ZmQzdlJ2SGxHbFhx?=
 =?utf-8?B?aGYxK0xMS2JvUGhJaFRDSzFvWG40UzRZNzFRT1NGKzRDUVlkK0VENHFZOWpB?=
 =?utf-8?B?Q3JiQ2JRaWczVzVLUzQvOW5Ddks1NE5OY2xhTUo0dU96UDJ2VVhFOXc4YzlP?=
 =?utf-8?B?cVFYMXF0ZUJiaHVxdEFpRndjVnBJMVRsL1MxcmFML2h5RGRrem9qdkI2UXZP?=
 =?utf-8?B?Z3hSUTE5QUo4anNsQzJnYmR3RkV2VWVNOGRyV1o1Z1lXeTBDdDlrbk9JU2w4?=
 =?utf-8?B?bEQ5c2pIdGhWM1F3eFNXNGh3K0dhNTN4UytCNk10ZVFMQ2t1MGpyZkFyWG94?=
 =?utf-8?B?S0hNWVQrdjMzcGhmbTR2dmg1VjVpS25DS0JYa0R0aUR6RmhaRmtlNGd4M1M3?=
 =?utf-8?Q?By5s9WuMbkQhCTCTtjRQr0xfD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a7e9ab-8a07-4a90-6a60-08dcaac3cb28
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 03:01:48.5340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLiDqBztILxXnHNqBi+zBLV5pAKwFpkbJ0gnDPiGAqbFubveWcnmdY/nYZtfAALmUzg5ki8hhT//yXQXhuntNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2024-07-22 05:14, Srinivasan Shanmugam wrote:
> This commit addresses a potential null pointer dereference issue in the
> `dcn32_init_hw` function. The issue could occur when `dc->clk_mgr` is
> null.
> 
> The fix adds a check to ensure `dc->clk_mgr` is not null before
> accessing its functions. This prevents a potential null pointer
> dereference.
> 
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn32/dcn32_hwseq.c:961 dcn32_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 782)
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
> v2: Along with "dc->clk_mgr" add check for even dc->clk_mgr->funcs" (Tom)
> 
>   drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> index a7cb003f1dfb..fcaabad204a2 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> @@ -779,7 +779,7 @@ void dcn32_init_hw(struct dc *dc)
>   	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
>   	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
>   
> -	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
> +	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks)
>   		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
>   
>   	// Initialize the dccg
> @@ -958,10 +958,11 @@ void dcn32_init_hw(struct dc *dc)
>   	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
>   		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
>   
> -	if (dc->clk_mgr->funcs->notify_wm_ranges)
> +	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_wm_ranges)
>   		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
>   
> -	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
> +	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->set_hard_max_memclk &&
> +	    !dc->clk_mgr->dc_mode_softmax_enabled)
>   		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
>   
>   	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
