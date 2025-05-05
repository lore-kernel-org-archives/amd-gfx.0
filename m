Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBB1C3ABB6
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 21:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3493F10E013;
	Mon,  5 May 2025 21:49:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RbTds2h8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A144510E013
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 21:48:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjh6TfKmthcjrd6H9pwXaveUeLGSN8zesTdxNQE4ZScZD4vmdIBZyROWjm4X4vg7O7sugd2aecKe6Guy00jaNobtqgBJ6xUALFzQzUkajlikqarz3JdIBeO11TVbj2rCTVZ7PAm/8IPmVtnokxr843DBMNpWzacaF6391M2jEcWf0IG6fzL5SRMTbGV5TYDav4d0EHKfLPF/XwYVN6UOb7xEY1V08o7ppsuZdF/TOoBNjYkopKhouFlGJBJz6HT5f8IbioaM+df+uXc1qRdfrCtHFB2CN2S4WOYixw9Y/v/j45bYXbLJSqOa73vrqwk1nxLtg4KfuAC5ZLLjeTB0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaf8RxSWiSzRd2rRowihton3QrC9b0o+Bp2fIs12TD4=;
 b=DtNSN1jW/tMc8G+t0WvUlDGhe32m64FbOvstDYFemVBuzgyRnAXjCYW99JaNphHsEvgNZZVG3FKRJREQe3dHgW3aipt3SDDRQiNWTmbvFwU85F1YETaZr1K0ak/45tGMbREsXXgBjgmaI2XQSGgsT6/p0BG0cQc69wQc6hBR8wwMf+gq8yOcLoBuGxBQJs5h44FNClQ2V0ybuGWpw9fKBQaMTlDOSMzcw7/PzBvqL/fBTZJpIqqN2epx2yV6owsr001NblvPjp+sd6vD2xqYZOvyev199z+oSdMbC5CCvKVsKstoe9rH3TGyVTD6Q05jeMNjQ8TdvZ+aKOOOn4vMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaf8RxSWiSzRd2rRowihton3QrC9b0o+Bp2fIs12TD4=;
 b=RbTds2h874hkY6g0mkimv0bXdlXm5yYWNifycWBzPQSMjD+kiRX/gNEvPpZT5b/S1GeEstEU4AcQcz8LjXz2emZuRwuAmr8/xV+XPpSbW4zJAhowNpXI77wBtCz5uJG0XU+ucUJLIfXpSIhRIIBfv3fncmxgb3c6NUDMLsZ7kNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 21:48:51 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%3]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 21:48:51 +0000
Message-ID: <028bdcd7-8678-4a3b-a715-1a2e54538143@amd.com>
Date: Mon, 5 May 2025 16:48:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix pm notifier handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250505153003.2047138-1-alexander.deucher@amd.com>
 <20250505153003.2047138-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250505153003.2047138-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0198.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::22) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: b62374ec-a26a-4453-0dad-08dd8c1e9fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3dRN0tqOUVodTl3Rnc3Rkh5LzRISWxwc1UwU0FqSWkzZzVuOFVkbHBPM2VF?=
 =?utf-8?B?OTRBYVFObEk4dUIzTUN3eGxMZkxJc25CYTMremNCeDRjdzlaTDJjdTZhUXNw?=
 =?utf-8?B?bkxQU21nQ0hMUy80N3JndVJEUUM5WTIvendDM1RlNjdMcnJubVFqNkhXYURI?=
 =?utf-8?B?R2IwaGoycHZhVHN5dXJ6R2FjNmFTd2JZVjYxdnl5S2FTdGN2MDA0Zm4xS0Yw?=
 =?utf-8?B?WWlnVmhCaEpNWmFNYVl1ekdjUGxPSWhDNUxBbkozSkNkZkk5ZUltK1J1aWpH?=
 =?utf-8?B?WW40ZE55c21RQ3EwWkJQdXJjVFRnc0NUR3EwZm5LdTN2V3JxbU41bDhvK0ZQ?=
 =?utf-8?B?YkwzNS84WEo5ejBwc0w2c1pQbkFCRHhoZnNKRkUrL21ZWHMxR0M1Q202R0xm?=
 =?utf-8?B?ZERHL3dGaWhiWU9tK1ZFNTgrU0k1Ly85WnU4aVlIY3pEUFIwZENCcnFQeHZ2?=
 =?utf-8?B?eWRhM3lqSTJ6R3AvVDU5V2VLYjhaWUlLT09ZU2VyN2paSWtKS0xVcFBsUjFh?=
 =?utf-8?B?NllZeDVoS3dyMnR2VmFNRUhQOUI3UVZESWZWTk9KOHM4Q051dmhyNExVOWU3?=
 =?utf-8?B?bGUvb1RJZ2cxcm1jYlpLMXU5NTVGc1FwKzVLRStmc0pPelEwVHB6UGNKd2VR?=
 =?utf-8?B?OVgvaUtPVHFEck9UNXBCbXhBSFc0UzVxUlgwZ2lUWmVtN0tBV3A0SUFuYi9Z?=
 =?utf-8?B?Sk1XT2wxei9CbXkyeERxSnlrNXU1MEh0OVhlb01STDdJdVpJdXM0U3M4NVF0?=
 =?utf-8?B?bXlXQ01VVGlLOXQrMjVHYW1FSzU3OUVXZzNCdWhDTStTdTgrUlVoMlk1SSsw?=
 =?utf-8?B?em40SXVPd0lCMDBnVDlyVkdOMUJFUVZyTDloVk52TXVKV0JITm9nd2JNNHVG?=
 =?utf-8?B?RFQ1Z282QkZSeWYzb2VBM1VCbHVNUzM3bENKWEFKNitFOHpwQll1enVibEcy?=
 =?utf-8?B?eklKODhTbTE3SEFudStaY21lSXJNOVVBeGtrUVdjZSsyWjZHcG5MY2FLSE1D?=
 =?utf-8?B?dnloTVdiYk8zeVdNSm9uNlg0LzJvbVNBQjJ2OGQ3UUNjZWlmL1R5eEdXL1ZH?=
 =?utf-8?B?SWt4SmFlR0N5NTVxWVUxaDBiUXdsZkV6TFc5djdTZE02aSt3Z2ZEMjZWZjFY?=
 =?utf-8?B?ZnBaMlNsRzNIekYzYXVjYk1MalYrVVZZYkVqSVloTnlQOXRiSmZlSWNoQjE4?=
 =?utf-8?B?VEExaUJYd2xFNFdwVnF1alU2M0k5cjFQRG1PSFE1enR0c0pBRjZla3M0aVRR?=
 =?utf-8?B?VkZQTllzTVRxWFY0OElIQ1l3LzBoRkpPeUVUQk40UkhoRHYrVC9jQ1FJOGU0?=
 =?utf-8?B?Q1JGQW9rTnRmeVdpcFg3QTM1MS8weC85Z1JRV1NuTUx6dFExMHcwb2F6TGtr?=
 =?utf-8?B?c1pUQjlhNFUrMEo0YTJrZ005MGdiTEVYRjhXdXJvS1JHNk9hN3JUNkhjT1BV?=
 =?utf-8?B?QzBKZ3kzSGMvZEkvSk9rR0w1YkdXbnVGY1NWMXhISkNXSmUvWENZanUrcXVL?=
 =?utf-8?B?N2NlKzhYUzliOWwxOWRXTENyM2NsVXYzSk5lK1NPVHRrZGFRU3Q5bUFtLyta?=
 =?utf-8?B?MWlLUHN6cVFVZXF5ZVlMc3dwTllhajBiNUs3YzROaFZwbTBRVldrVjNDY2hO?=
 =?utf-8?B?TkhXU1VDb2V3bTlvME82SWg0dzQ5aHp5ZmlocGdRU24rNWhRQkphWENUNlJU?=
 =?utf-8?B?eitKVTVQWTNrM0N3YVhRZW53OURwNFB1dW45dUtTMndjOXFDcFd0bTNpNmRY?=
 =?utf-8?B?R0w2cERadDVDZ2t5WE85cFpHUWNTZ1pyeTFOMlZVcGJPNDhBZEczT21EcC8v?=
 =?utf-8?Q?2PG0evztxyXFyCG3hOJLoERSEChYYsPAL4P2U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6095.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VytrNFhSaDJNYXh2Yk5nNmdzTTFXWVdYU2NTaUwxR2hBTXhOVkdLeFVQL2Rr?=
 =?utf-8?B?UldWdG13NVpLZmRidnh2SklIWEFLYnNPUlB3ZUhrRVZoV0dKYjJkRVZKUmdn?=
 =?utf-8?B?MUozZmR4bUtqRVpZbVBuTUtvaWlaU3doWnR4MDZRRHpHbHRBMzZsR0FyUjlx?=
 =?utf-8?B?OVpraXlwVExtd1l6R3lSaC9sajFhMXNkN1pndmw0QTNpU2FFaHpGNHVuQ2tV?=
 =?utf-8?B?MDlFSWRaMDdVOUdhb3lLL1lQbllUYXBZdGIzaWJHdmJJYXQyT0ptclQ1N3ZW?=
 =?utf-8?B?bjh1SjgvTWsyK0hIRkhFV3dta1poU1M3MnZ5VDhnUGt1cTNBbzdER1pQemFO?=
 =?utf-8?B?MXhaK1htanp0a0ZOcWNtMlBPTEl0QkhtV1RFcDdPdlplU0ZrQmNWOTlnSWdq?=
 =?utf-8?B?TkZZcTR1OXA5c3NTWnNmRWREQURRZlBxTml1YVh4dzhWTCtmZnRIMWM3dHo2?=
 =?utf-8?B?VDFoL3pKTFBhakhwZUFpcFgwcUxlMjIwR2RYVVBKWUJHNENPVldDcmtCb0xG?=
 =?utf-8?B?UWgvWUY3eHlVL1hZaktmODlqeEo1dmoxcjVnMkRLM1NwWnVKZW91Vno2STI2?=
 =?utf-8?B?NWM1VmoyTHh0dWpFNWhVaFJsVmQ1d0tQNFlYL3laWmhOVit3d1VkR3RrVEE3?=
 =?utf-8?B?MmcyQ2p0b3FmNFBGbk1kOFZXQS94K2VnS1ZKS0toZmt2UzIzanB3bUVhRmZo?=
 =?utf-8?B?OFpiK0pOZjdGT0t5b3lvclBGdzhKMkI0Sk1yMTJPUEE0N0JWYlB4Q3ZjTDY2?=
 =?utf-8?B?YTdFZUc1NnYzZDFWb3FkTzFxNVBIRnB5TkswamRTeHF2cU5oY1VxZnRsT0Fy?=
 =?utf-8?B?dVZVT0ppSEdQalhVT0haczY0T2NsT1VoQ1djaTd0bEZtb2V5MmdyWENQK3Ba?=
 =?utf-8?B?RWx1akJvZkx1SnVaVWtrY3NhS1RPcHR4cXhJNlhLMXdlQzRET2hGZTE1OGI3?=
 =?utf-8?B?VUFERWhnSnU2d3VxZ2p0QXJiRjFtNFV3R21rYUlpczlHb3ptRzZudkc5RWpX?=
 =?utf-8?B?Ri9UdWVVOW44MFJXUnRxRHVKV1BuUlNxcFhobTQ4clViMWVlUGZ4cUZZMGFi?=
 =?utf-8?B?cDROZExuaXNIOVNIcHpTRHl5TmhwajAvTkF2eFc3WGM1NWpZN2xsaVBRRFhO?=
 =?utf-8?B?a0pvcjg2VzdUNGd4T0I2RDV4b0R4MmxQQWkxWXNPbFRKUkxRQ0Q3NzNRdk1k?=
 =?utf-8?B?WUtWY3pPSVJ6clV5UmtnWFNkMFE3ZmFHRFFySW5CZHJvSzNLN2ZaSXhFb1d4?=
 =?utf-8?B?VTlwdENxejNOcmVhQ3dzMVFJZlNTZFRzc0paWlJqaDJGVDRyRWZiY2ZNT1Nj?=
 =?utf-8?B?UVo1aWd6bWtDQThBdVg5TzNFYVhOdFFZQWY4NWh4dVZ6TUVMTGw1ell0Z1oz?=
 =?utf-8?B?N1BVRW1UWk1BaTFLNk9TaFhxMHBSZG1wMVE4OFZzYUpiVDZCa3RwMWdGbnRh?=
 =?utf-8?B?a3pHbDVRMnJhUk44cFpLbGhObitGOHZhOFR2cHFha25MTXhhV2d4Qk5xQkZv?=
 =?utf-8?B?bStTMzEvb0ZsNmM3TnIxaHYrMldxREw2QjJ2c0p0RzlCWWc5N2ErMGZXQXBM?=
 =?utf-8?B?dDN2aGEvdWNRYnh2cEkyZ0FOb1pScEc3bmJMbEVBUTB0TjJYNTJQanhhMmlG?=
 =?utf-8?B?RHk2NmFxRDlCQ1E3bDB1dDQ4WTczQUFQNjlnczR2UzZtY3BvMklrSXFEMWJ1?=
 =?utf-8?B?dnRIOTk4T0RPVWRVT0ZuSndkczFZMitVODN1ODI1cklGSWQ1QTRYN2YrZkw4?=
 =?utf-8?B?UWxsTCtGRjBHLzFvNWxERVdxcldYbjlBZjR6RHZuR3RYWlMrdEF0b012U1pL?=
 =?utf-8?B?cUhRcHJyOWZJcXRhazZSMENtd0NpNkVzY3ZVYTFOV1ZJNlNKWkVCTFo3SE1y?=
 =?utf-8?B?THoxaDlvTUhLOEZWdmNWOWV3cVlXU3VUYlUzS1Z2ZzZWMzJhNHV6Mms1TUxV?=
 =?utf-8?B?Qzl0UDdSYlBFdHF2M2lXK3hWVE1lcW1vNEo5cExFMndOQXZXb2NFcWZOM2g5?=
 =?utf-8?B?MndsSm1NbmlOM3pyNGZmY3JBbUUwblU4cG0zN05HaVM4UnQ3RE1sNnlmemZY?=
 =?utf-8?B?ZEFNeE5ML0F4dVZqb3NZTk1MK0hHT0V5UVBUanRSd2s4WEhvbVpEVjdPOVZJ?=
 =?utf-8?Q?bK0tkxJnQMm1Ht2Niw3Lxg0H0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62374ec-a26a-4453-0dad-08dd8c1e9fa8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 21:48:51.3737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2uvxPe/1rXqrJiJ8pbr0PaqmwNBv0Y+vCGSgoUmasUS5fZ6s4vqPvpjRDEg/oVs+ARAPh5TakFtgwJXq4KyvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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

On 5/5/2025 10:30 AM, Alex Deucher wrote:
> Set the s3/s0ix and s4 flags in the pm notifier so that we can skip
> the resource evictions properly in pm prepare based on whether
> we are suspending or hibernating.  Drop the eviction as processes
> are not frozen at this time, we we can end up getting stuck trying
> to evict VRAM while applications continue to submit work which
> causes the buffers to get pulled back into VRAM.
> 
> v2: Move suspend flags out of pm notifier (Mario)
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
> Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification callback support")
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Until we can get movement on the RFC for the extra eviction step this is 
fine for now.  I hope we can get that soon though.

For both:
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 +++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 10 +---------
>   2 files changed, 6 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 368004b716ba8..5d25db16cb4b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4979,28 +4979,20 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>    * @data: data
>    *
>    * This function is called when the system is about to suspend or hibernate.
> - * It is used to evict resources from the device before the system goes to
> - * sleep while there is still access to swap.
> + * It is used to set the appropriate flags so that eviction can be optimized
> + * in the pm prepare callback.
>    */
>   static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
>   				     void *data)
>   {
>   	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
> -	int r;
>   
>   	switch (mode) {
>   	case PM_HIBERNATION_PREPARE:
>   		adev->in_s4 = true;
> -		fallthrough;
> -	case PM_SUSPEND_PREPARE:
> -		r = amdgpu_device_evict_resources(adev);
> -		/*
> -		 * This is considered non-fatal at this time because
> -		 * amdgpu_device_prepare() will also fatally evict resources.
> -		 * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
> -		 */
> -		if (r)
> -			drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur: %d\n", r);
> +		break;
> +	case PM_POST_HIBERNATION:
> +		adev->in_s4 = false;
>   		break;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 8baeaa5d5b119..e0ca9405719e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2643,13 +2643,8 @@ static int amdgpu_pmops_freeze(struct device *dev)
>   static int amdgpu_pmops_thaw(struct device *dev)
>   {
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
> -	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> -	int r;
> -
> -	r = amdgpu_device_resume(drm_dev, true);
> -	adev->in_s4 = false;
>   
> -	return r;
> +	return amdgpu_device_resume(drm_dev, true);
>   }
>   
>   static int amdgpu_pmops_poweroff(struct device *dev)
> @@ -2662,9 +2657,6 @@ static int amdgpu_pmops_poweroff(struct device *dev)
>   static int amdgpu_pmops_restore(struct device *dev)
>   {
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
> -	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> -
> -	adev->in_s4 = false;
>   
>   	return amdgpu_device_resume(drm_dev, true);
>   }

