Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFBFCF3185
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Oct 2024 21:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D1A010E329;
	Tue,  1 Oct 2024 21:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DTBQo881";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE5110E329
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Oct 2024 21:16:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgfZfeQ4loLWRFFVKFyR3RyjZN0MkvYDHdfA9mnX1bcXHr5Ii1aUL8Q5SZC9sRU1Ti6scHOQ1iIrYN6b3Yi9oSOth5pFtUc31nH3H969x6q0wXI4TB1t1lmOjhZU44qWW2kj3qF/oUVbS99mzThaS5P2nndHOVfj6+3rlG1oad2Wc+OMem2EFCvFe8XnL3msvkr5zZPw3qQ8LD0cKyhvlkPY/dEcX28k/8pcTpnReb4PS4fhqqw8LDiAm8NU7GL8p0wCeQpH2ueLIKjqO8G198meuJGEJ5QjM6nl0NPoBH10ZdBSOX9ADcLUsp8nKmj3vpRnDcYNAok/NMVcvngHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2i+veWgA8lbLvXo8cFM/Hokt4umkvzP3MRVP4B6N5M=;
 b=C0JV7n8APiUN/v78qvxITMU/6317L40Kwfb8Ae2vjJGcSXkrxAIzjpCfAcrZXOHrg8tFy+jnzEIZfhyFXWkQUbiw54kFaLUqkUhyHZvZukxYT4REvdTcVZUgqF3xMt5myK2MDF8Etp1k+W6wl41rlXiaZTFhp+mWSU1nkp0iJHH3BY+s8noJCnCuc0rzuQjKjT3CTdWPX4Dz4KcIYUSFFQ84NSDG/NeuM935HMXxbHd8o0Qqpe2LAUz/6sc2Bx01XiKtk09usrM91Lu04Pps3mh8bcrEx4ALOnh0nhxqtk6AIrGHBFqPeWviNeMzvvVhs0ggP5MzsAuC7dJPpCgzbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2i+veWgA8lbLvXo8cFM/Hokt4umkvzP3MRVP4B6N5M=;
 b=DTBQo881Qfi+xbYl2+Zl+eDjcCMEd+rk1yzrWQHROBMi/CzPvuYFzU+E+mM1OmnytcCxIl8LcfR0jRj6YPmDK8gZw8HkDDbb5dNDLcUFvPm1afFgCtHU6tilh3IMYym3K600G5cr6O1uYYdk3f9XOMUbwYEUOKfCyCyxFaS0BDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 21:16:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 21:16:04 +0000
Message-ID: <25eed927-fe69-4005-8c0d-c5f3052e662e@amd.com>
Date: Tue, 1 Oct 2024 16:16:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] 58a261bfc967: choppy GPU performance
To: John Rowley <lkml@johnrowley.me>, Leo Li <sunpeng.li@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 regressions@lists.linux.dev
References: <9b80e957-f20a-4bd7-a40b-2b5f1decf5a4@johnrowley.me>
 <925cd47c-8f1e-4b74-aeff-6d13ae5f0753@johnrowley.me>
 <95c575a3-100c-4808-b451-b92f14598188@amd.com>
 <836c2c82-4dfe-40f4-8d50-5e7bff04c38c@johnrowley.me>
 <7ed81635-3872-463c-94e5-e4972da9d014@amd.com>
 <bcc97e4e-ffe0-47a7-bd29-c993e5404a33@amd.com>
 <9c562132-64a0-41f5-80ad-8492d1039692@amd.com>
 <3c0dfd3a-9549-4afa-94b6-80041f498436@johnrowley.me>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3c0dfd3a-9549-4afa-94b6-80041f498436@johnrowley.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0161.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ecf990-8b78-4ca2-f5ac-08dce25e4203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2xVVEN1SURzSEZkUVo5eHE4OFhhQzlQTzJWZUhLNFhaWUdLeDVDenFvYmNY?=
 =?utf-8?B?VDdEOTVoYlJwdXExaFpta0xGTnZkMHpvRkdpM3VnVXlNWFl3ME53dTJURnZw?=
 =?utf-8?B?SUFzYUxQeTV0cnliSWpOZ3RsNDBZcWQ5OUZuN1JsTXcxQzF3MWJGcklicUVZ?=
 =?utf-8?B?YUE2dkVnSVJBN0tEakwxdnQ5SmR4WmNLRTlhSXlyWExxMStLRVZ1TjRBRFFX?=
 =?utf-8?B?VWhQTXVRM3RmSVdBV3d5YWtTeUxhUXYvUSswNEdWbDNwck9SSzR1WEJLaWNv?=
 =?utf-8?B?aDhiV1JycnNnd1V5TVNRM2tVeDc1ako2OEpLU0NZWTlkZXFEUWRZREtoUXpu?=
 =?utf-8?B?Q0F2aU1zUFE3Y0dFMGhTSmdBZ0hHU0FQWVhyaWNRQXdvQ05Vcmd4dy9namho?=
 =?utf-8?B?K2JmUUErRFArWTh3UTMyWXFEZHA3TUU2ZUF5bHpoZjg4N0tEdjBXQ24yTnls?=
 =?utf-8?B?ekZVWm1BamFLYW1pb1QvYVM2QTBTVGVUK2Q4amhDTVhUYTFzY2ExNzBuVFc3?=
 =?utf-8?B?UUthWFJQcmVPUWlaNHVtU0hBVXV6eU1UT0QzeUZKWUhJR3N5S1ZDa3pqZ1Yx?=
 =?utf-8?B?eENpZUQ3dVFTQmtOYzVMK3E4bzYxMlBJQlRxUG41aURyNThyUW9vUUNxcGhp?=
 =?utf-8?B?aThmSXhXekNNbEphWDYwNHRrb2JnRFE4NzdoWEdXTkdzVGRmR2M3SEFGRS9M?=
 =?utf-8?B?bTAvZnlJdHVGZERuRnYyQ01oMmdXLzBjNTZYZmhIYmFZeUVHUGhTeldQZjBI?=
 =?utf-8?B?SGNsZlFOMGxZOGdhUlplUzJucWlOT21sWFkwN3pUSDJiZURjNWpSNGVTWUty?=
 =?utf-8?B?WlhsVVQ5b2h4N05iSEJwK0s3WkRvTStTcjlBVUx1L1IvOXViR1JxbFJ0OVNW?=
 =?utf-8?B?eWhMc3hGS1pMbWd3c2pOVUVzOWM0WmJoSUlhRDV6UXY3V3VxamdwV1NDSlBY?=
 =?utf-8?B?cGpubk93SEJ4SWpSNXlTNnY0ZW9BbUExRFhxd3lFRkh1K3ZzU285aWdvUXBD?=
 =?utf-8?B?MVh2aWdjOHo2bTAyRUVudWVQc1kxVzRlTVY5c0hWenprRTdTZVZRK1kvMlRv?=
 =?utf-8?B?QWhYWXBYZTlIQVhzYndmOXhDQ2xWZkQzakowcHBJdE14UHQrbWNlbWF5RlJ6?=
 =?utf-8?B?TEJWbWJzZkpvRFZONTNKZW5Vcy9vdWt1eCsxbDFWeTBpeDV1MVFZeDV5aVdN?=
 =?utf-8?B?VFkxOGtGNXNRN2hVRGdnMzdXOTFuRjYzSjFSNGhwUnlSS04zZjdZbXdUUGlL?=
 =?utf-8?B?NXdmcFBob2djdlBoNy9sd1F4Zi9qbUl6eUNZWHp0ZzhEVUwrNVlyWTI3M3RR?=
 =?utf-8?B?Y0d2UWJxYXgxdFhhSWkxdzFhSWdlUndkMHJwdDNaV2ZOOXUrbDZaREpWd3Ix?=
 =?utf-8?B?dWxwZy9kT3UrdEpMOVJaS2huSmFDbW9qKzBOU1lwWCs2ZjUvQUt2ZWFqNU5V?=
 =?utf-8?B?dkNwUlJYSHM1b2xjZ2V2UmJqeEhERmc2R1BzRFNRdk1tT3R6YXMyUHIrUEQx?=
 =?utf-8?B?MnRhVzJGSmVEWDhEWG0zQ08xdGdnZ0loYjlvTVJ1NWZPdWI1QmRZVXM3Z29r?=
 =?utf-8?B?a3VsTFdNV1JabWpCSHBWd0VNc2UyaHJqYnJMaVRUcmxlOUIzOTV4VHVycXlG?=
 =?utf-8?B?cHNFV0p3KzB1UDJ1alBZV2NNNkFvVWg5ZFJvdEhKWmJETGVvMEY0L2xBeURM?=
 =?utf-8?B?a09nVnhRSElZS05aUEgwdklQYjJIZEJnU2UzZWQ2eWVCT1kyQ0tUTEFESGxn?=
 =?utf-8?Q?67D8qYA10LgTWwOz3I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1p4OWNLYVk1TTFmbzliR0tXRDdWRzJGakRBa3crNDFjU2d3RVZNajVERExZ?=
 =?utf-8?B?WlRyd3RSUlIzKzdVTHB3RTBTVk92cEU3Wk9sQkt2alY1Mm9ycTZwQmFpMlZx?=
 =?utf-8?B?ZSsyWm03RXpnVnJnaVY0cCthSFBkclEwQm5ZbW5WL1JweWVwQ0I5Um1TVGVH?=
 =?utf-8?B?VENqMmpIeVh1empodXdDN2dVMGU3bndyNTZjMDJwcjlIVU5mTEVEWjdsQzBE?=
 =?utf-8?B?cTlQRHdLUDZJSlhBbjJ1Q3E2MUVTcHJSdHlSMmV3OUlmKzFVaVdCbm1ieE9j?=
 =?utf-8?B?MGJNellRWUZ5OGlONmdUT3hSU1lVeTV1U1RZY3l4bmZFZGVSZ3hjVnZES010?=
 =?utf-8?B?Y25QVDlXbDJHNThQcStpTDMxWG5qQnFJUGtkTWdhOUsxQng3ejZhSzAxeS9C?=
 =?utf-8?B?N0VlUVlHSDZDbHFBRVh1bDl0REVGVDBPQTZTempvWFhWT1RLSUZCUTVoZzFh?=
 =?utf-8?B?Y1BuWDJ4RE9aOVd0bStmOFhaSVVWbzdESFhleDNkUTdTQW5FUmtBN1VTWldz?=
 =?utf-8?B?bjh0aW9mNkROSFhtTFR4QnB6aHc4Z2RPaTRXNWozWGdmcFY0d3YrSitSZ09G?=
 =?utf-8?B?c1FaNGlCK3lVdFg2eWdGeHVNeUlvVExma2RCVDREOTBqWStUQWU2NW9mY2Rq?=
 =?utf-8?B?citNdGQwWFlGUFc3QWNORVR1T3g5RHdBVmdGZzN3TEhKN0ZLTFcrekpSNGc1?=
 =?utf-8?B?cEgvWVpYcGZJcE1VdkZZK0hSZkQvU2J5d21lZG5pUHo0Y2dEN1dlZDZOaWtC?=
 =?utf-8?B?R01ZK0s1b1dyYlVhTEVlWU1rNktacXJKd2VNN1dWY080R1oyVmQ5dENXaVBG?=
 =?utf-8?B?SGkwOTQ5QUJibm50MEFFcTkzWGlheVNJaGNxYmFjMUNvYnNtUkJlVkoxOVky?=
 =?utf-8?B?T1Q1bStqeDBaNDg4S3ZCUngyN1JNS0NZcjNiR0dJMWNxY1Y3MngzWWxVWGpP?=
 =?utf-8?B?cSsrNlVYdURtNlZEUE9kNGorZkpVVUEyUXFlREF2M3ltZDMwQ3NrN0ZKdDAy?=
 =?utf-8?B?Rnd1a21xckpIazNvTExHRkZ0WkZBWjZKT1p4NGNkSnc5Y3Y1cC9IbDhwSFhw?=
 =?utf-8?B?YS9rSFFzZk80QzhERG01NW14SE52NWtLTGVNTGszRlU2Q0RUSXg3aFRSSUYw?=
 =?utf-8?B?T2pTdVpGckl5UTJlK2lIRHlrLzlDZFJpY0dzNHVXamFIYTlrQzl4dVJTZUxl?=
 =?utf-8?B?YmdIRXRYRjFxWDhJMFV4QzZIaXA0MkJoVmtZSXU3YTUrc2tGV1ZnRFBQbUtU?=
 =?utf-8?B?SEVkM3I4b3VISUZaRk5tWHNnazliQURJOEFtb29IY3RJZ0NRMHBXN2U4QkM5?=
 =?utf-8?B?SHBIZmt4SHZPMUhseDBxNU9UN1NjVXBvOGhSOW8rWk15MHJuelAwY0FSellk?=
 =?utf-8?B?T2hldG9kbWRFaEUxanl3ZVkyS0RIUTkzQlpqbi95VW1ZSFk2Ynl0Qit0MFdK?=
 =?utf-8?B?VUlab2hCeTUwZkZkb0orV2NRT2E0NUNuaE11VUFWZUJRRTJaRzlDQmZuNytn?=
 =?utf-8?B?MDVaSjBGVG9UeFlJSDlGMnBkaTBkQjgxVlJFNHFyWHArczFqa3BwTlR5QktC?=
 =?utf-8?B?R3NMdmRvVkRia0srK2pUOUZjWXl3L0NVejhMY1FwQ2Y1MWQ5TzR5dTA3YUJv?=
 =?utf-8?B?elZ2Z3ZOVFRTZDVTaFp0TW9ReS9CNGhEaG1nYy9BRU5tQzZtMHVkTlRUL2k4?=
 =?utf-8?B?OHVTNmhOK3pseHFuVXM2Q25XV3FLSFVHbi9taWpGbGRBMXFJOVdxR1gyOE93?=
 =?utf-8?B?T0xCT0l5RE1lMVlmZjZCRkRiS0NBSnVNalRhSC9XRmk5dnYwMTBZcFNIc1dy?=
 =?utf-8?B?RnJDSWtMNUxBTS9oRXBKc08wZlRJZFNSOHpSMWh6L0o0R2t4UGpxTTg1QitN?=
 =?utf-8?B?NDE1Y3JSYTk3NU04Sm5ldGFPTzRWd3hGQmNQaHJETVQrRFJtbURGd2FKYlFi?=
 =?utf-8?B?VEVrU1VEVlJ5cUJQQzZSWjRmOXpKdkFFbEV1c2doeU9nUHBqeEZIeXZaR0Yr?=
 =?utf-8?B?L045U3R6Y2t4aVphWTNMRDRFdThHWEUrTnBxWkl2eUZzSE1jdVc1NnFaWEZL?=
 =?utf-8?B?dlg3ZGNhQ3U2VklCb2JRUmNQbktjR3JBUStSV3Q2Qk9yRk15NVVtYlZWZ3Rr?=
 =?utf-8?Q?u3xkpEVD4dqTpfgH/vWS4laEb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ecf990-8b78-4ca2-f5ac-08dce25e4203
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 21:16:04.3529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEyK4Xo/RgbL9Qzq6AjX+s5lAimqWYjrcLYY0wwsIgBGKK+4CMw95QHvRWNXlfKTjz0skd4Fzq8bJVNUu0i9Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414
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

On 10/1/2024 16:14, John Rowley wrote:
> Disabling PSR as per Leo's reply seems to have done the trick!
> 
> Stock 6.12-rc1 (without revert): BROKEN
> 
>      /sys/kernel/debug/dri/0000:c1:00.0/eDP-1/psr_state:
>      6
> 
>      /sys/kernel/debug/dri/0000:c1:00.0/eDP-1/psr_capability:
>      Sink support: yes [0x03]
>      Driver support: yes
> 
> With amdgpu.dcdebugmask=0x800: BROKEN
> 
> With amdgpu.dcdebugmask=0x10: FIXED! Performance is as it was on 6.11.
> 
>      /sys/kernel/debug/dri/0000:c1:00.0/eDP-1/psr_state:
>      0
> 
>      /sys/kernel/debug/dri/0000:c1:00.0/eDP-1/psr_capability:
>      Sink support: yes [0x03]
>      Driver support: no [0xffffffff]
> 
> I have the older Framework 13 panel (BOE 0x0BCA, 2256x1504 @ 59.999 Hz) so I assume PSR isn't supported according to Mario, yet psr_{state,capability} above seem to indicate otherwise?
> 

PSR and Replay are two different things.  But from your above analysis 
it does confirm it's a PSR issue.

There's a patch that Hamza attached to 
https://gitlab.freedesktop.org/drm/amd/-/issues/3658.

Can you try that?

Thanks,
