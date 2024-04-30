Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC322C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 17:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C51510F367;
	Tue, 30 Apr 2024 17:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o8rFDWmf";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D8FF112D48
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 17:10:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJm46lxOYifkIrhQWItWyNrwoV4jmW+rKb76FdjsnEOt5y3Npid2SLIFOSD0cHPUDtYmKXknDs3YxZAlM+LBmXTruWbJbvpmzOxOypoRmz6k5R2fEtYaNRvZCCDK1LUFprlxAP6vXr1mgejD1ytTorZh+tCsoROIS4CjAWkppmdPl1vkT5prYQMOh/S+NgEIY8RmuHFqCGOF33bLQJNeP2c+Atottx6Ed5+NVOml/la9ORuzFu07YtufeoWIJrNAibdWcEj4F1Edx6VwOd4F405CVMKnrVCkgotqqKKYh4GCCvh3ogHMTkGsy4p1781UB9EoZ7w1r9K6gERFwmdbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTQUuKjlmEn2hQIRcNYRa+Xtw933begISJLUQI/79H4=;
 b=hS7jFLcrxjpIUEMn5KO8bcA22G19+DIaTnKE+0MwrhBvFkWxcC3p1BVMmmw7yVMaqSQ3j2+uiFMQ6rcxFkMuv25TN3cGvmTBm+2OfAlmB0VL9u6TwqgUM3Zu/mCrLFZHiezt9vNBGliU90j/6lTVOAv+Qo5lyCIlEfd9wWIp88lJAtrZnNUnFhgbpHq+aLosUlnSBCv4I41py7UhB5+av0ioh96mxZSZNxVo0WbcPZtEocGh8mKOcgy4UT3PuscKtYSBUI5br5bnfWzQJ2IlAtcWR18WO0tHAeyQOIFd1diup+ynhx3R0iufH6+Z6etJ2el+x5KxFcPACupKw6M/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTQUuKjlmEn2hQIRcNYRa+Xtw933begISJLUQI/79H4=;
 b=o8rFDWmf4iLMrmNVopi8NZq1kGOqExy3liFm3YDl4YyehyLq56w14L69FdDhz9CUxEXXvlHEoNOTQ13xuEAupDhtKkejaNv+JgkXUS4QC1RK+aHkGu1enwrXqUul2U20xVv/AUqgE/8DsICZ9rliIY36ysW+/xCV17j/3QE+pIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 17:10:54 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 17:10:54 +0000
Message-ID: <a0019669-be09-4385-b612-08c5cc470674@amd.com>
Date: Tue, 30 Apr 2024 13:10:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Remove redundant NULL check in
 dce110_set_input_transfer_func
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Wenjing Liu <wenjing.liu@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Roman Li <roman.li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240424012946.2122315-1-srinivasan.shanmugam@amd.com>
 <20240424012946.2122315-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20240424012946.2122315-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::30) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: a155a0b0-060d-42d0-bd26-08dc69387e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekFBK0p1cHo3K2FvcVMrYnV3RFYyazhibjZpRmNSczFNbnVPcTYrRkFOdy83?=
 =?utf-8?B?Rlh1b1lCMGdGUmhDd0pQQU5KazhiUW5VbE1zRElZMHBjUU01aWRtenBmdmhy?=
 =?utf-8?B?NFBaOWJuR0pKU2NzR1hteHU3SkJ3N1pURy9zMUpUdDhhRmVBbDNhRURMNWEy?=
 =?utf-8?B?RU5ubGxFVGs2bkVsOGtzOHFaTnNWNzhTTUZJbnpSWmdGRDRvdWVTZFo0UW0y?=
 =?utf-8?B?WThMVFRoVlhsRzY3NFlxa3hKMzhGT3dOR2JPenJ3YzdwQmZab2VxaHdFaHJ5?=
 =?utf-8?B?cFZrL0NFaUpLVkRaR0g4QzdlM0p1V1duNlBvaGU1b3l4TTBSZ2RtTDR0UVp3?=
 =?utf-8?B?dUpJZytxK1p1WEtBT1A5cDNmalJ2M0FmU1NaaHUvQnhMcVIxTHdSWmF2L05S?=
 =?utf-8?B?by9ST0dnMlJUQTRXanZIU2NVSDlJZ2Vaa2xrTE9HYlNIbUtSK0EyN2lDcXZl?=
 =?utf-8?B?cGVIZE55eklBbGUzbnR0T1JqSEpxdW9nVThGUnBFNE5yZGpBeWtHTDRQUnA2?=
 =?utf-8?B?dWVvczFXMHllc3VCSHJudElvakExdE9pYUxlZ21DWTdMZHRHNjBvS2VxNTVj?=
 =?utf-8?B?SHAvRmpJK0J5ZHp3MmZIRkk2UXJaQ0pYS3dXV1dySlFGZkNLUXNMajdlaEVp?=
 =?utf-8?B?VitwUGcrbmxBd2U4UE5nTU81WndIa01jSlFJMGtxdzdCdDJsRThrbHVZNEFh?=
 =?utf-8?B?RkZ3eUl1YVJONjVXRzdsUGUrTUlXOEdXcGZMaVVnSjQrWkxkTkZCUENpK3RG?=
 =?utf-8?B?RERlVk1xZVczYkRpdWN4RGhzRHZCa0d1dkZQRXJsK1Z6NGNpQW4wOVJOQkdX?=
 =?utf-8?B?RDJTeE1OMnlwbWJNSFNEOXJTWEx2QU5xYWRrSHFxSDU1cHVVWFVMODhqNmxS?=
 =?utf-8?B?L0pyWE5vZ2ljRGdMWXVCaGFmZnZXZmQwRVFZSWgyVzk2dGJxM0h5b1YweU1p?=
 =?utf-8?B?WnlHL0NyVTV5UGtVbkVLMjhtelZVbGptM1hHOE1LMVduSnlUTXc5MmVYeUor?=
 =?utf-8?B?SHRLT05VVE1HZDdWWHR6VlVkVUdVMDl6VlVuSGZtOHAxT1dqNFhwZXRVQm80?=
 =?utf-8?B?V0IyTWNqcURtd2d1R29DR3NzMjB6ZU84Y1kyM0RkNnlKQWRRNm5JalZWODFN?=
 =?utf-8?B?ejFVT3R6SVRWZlFlR283cTZ6U3JEVlBlZlFkRjVGc0tGN04xYThiZXZwbmlU?=
 =?utf-8?B?UTczMXYxMm9Vcy9iM2QybnE3dC92cHhuODR3UEVOd1VLWEg3OTZrNE00TUp0?=
 =?utf-8?B?eXVpbHVKeE5zRDNtK1U3YmFrY1RINVdoSkVRR1Q0ZExOR3R2Zy9UZi9lZVZy?=
 =?utf-8?B?R1JNREs2ZU9QbDBIcXFwVEhZWUpmQnlQYTZRblF1aFRxMVJnbUxCL0Y3TGhK?=
 =?utf-8?B?c25uc3psUmE2M1RZNUpmUHdLeUVBZ0Z5S0M2SHNJeWxDNWhCVDhTUzArS0xu?=
 =?utf-8?B?RU5YMlhHWitWZzhPVjlpMDgzTml1OUZXdmVjTmxzWTlUZ1ZweVhteXNrMXdU?=
 =?utf-8?B?bmdGSlg3dDUxQVc3bkhsMldMa29aM3NoeW9ZTjZlclJQaU02WFFtMXFubURi?=
 =?utf-8?B?R3NTWEhTWlBENTdSTmNNSVRsdzhSRmIxZEJ1SjVnakpWUis2d1lhWlJDOGpM?=
 =?utf-8?B?NUVkOURwSGJyRFJESkVTcGh3TkYvbm1vTkNiRmVoNHNQSU5lUDQzSFdjaVZh?=
 =?utf-8?B?aUxSVDVlVlFOVGkrbGI2YWdGb0pIdXNNSFVtQWx5Q1ZBQVFZdDZ4V213PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmUzZUlVcGtpaTJmdThQcEZIVmpsUmtzS1dTWUp1REhmMHlRRUxvYXBVN2ha?=
 =?utf-8?B?Q3ZtOE5jUmJKa0plcTgrQzdKTUN2L05TQi94ZnJCYVpSZFRCZHBUUUJtdGRF?=
 =?utf-8?B?cmpzcEU2VUNZZTNQRXZndVVnSnFxMkFLTjgrcVErQWVEaERacUhuU3U4Yzhh?=
 =?utf-8?B?R2d0OEVnVkxLVVRzYlpRRitWY0ZsUjJFU3pRdk1zeENvRmdwRlNVV3NxQUF5?=
 =?utf-8?B?allHbVo4OGtNVzRoRnJLZmkxK3RtcUV0L1lqWlhXaVBaZ09sallMbm9tTjNG?=
 =?utf-8?B?TS9WcldXSGZrUTBvUjYwM05CcjdzUlV1MGQ4Yy9RcFNOT3gzZnprVkR3bGx6?=
 =?utf-8?B?VnBKSWhqYnorK0o5ZVkwdWgzZ2xaYWxTWTk1cGZ6THJQc1BobFV6SHpVeUpq?=
 =?utf-8?B?aEx0dk1SUGtMem9NTi8vUW5ZYk1ySHhkYXhvTlcrcGJ0blBZZmJTcUhNbGRl?=
 =?utf-8?B?Y0hWWTBrUUFUeWZ5RmVRdXBWenNURUU3NkJzUnFua2FGZU1WdnVvRXNUWlFE?=
 =?utf-8?B?c2hBcjYxUmw1RHBxcnM2VE9VckZHOU5CVjgrNmZvN0ptQTl1aGM0ZWp6eW5Z?=
 =?utf-8?B?VXlvSjkxR1prYjRaa1NGYXBDdWUyN2xmQU5LY3YydWg0eFRGc1VCdWFMY3o4?=
 =?utf-8?B?bHNENGE5VnJ6UG9sUFpkd1pqZDRhbVgydWtpZWhPRm1CNEFOQysrSUpQd2tM?=
 =?utf-8?B?NnNSdkl6QW9iVnE3QlNTUzBZQ0NrcHA4d3NqcXM0R245Qm9qbmhCYlkxRCsz?=
 =?utf-8?B?bDBMN0VpeUhDYXV1bWxWTnlUWlRpOERnRnZ5ZkRFUzRrKzhRVlBmTzFQSE9R?=
 =?utf-8?B?TmdGeTY1cUZ0RStMOHkxdVJaM2FvZjNPbWJ1QkQyR3lWOGV3S1U4MDNCdHhZ?=
 =?utf-8?B?WU1XOXAvUG1nMyttSVZVVHR3TXJwL2RqNVBheTdEU000dTVhaytKTUQvNWx6?=
 =?utf-8?B?NFdHbXZtYXMweDlwZFI2UzhIQnE0SldFRUp5QnkxRXlqVm9ncmFuZmdUNnB4?=
 =?utf-8?B?bUE2MUh2RVJ0VENUWWRvYVBCWkxRdi8wRGhBdGY4RVpncURMR1VBVDV4aWhl?=
 =?utf-8?B?QVJ1VmFDKzBmUHMwYXNFc0tnb1VBMUZMT1dlYk9XTlNQb3NLdTlsb21FM1FF?=
 =?utf-8?B?NHhoVG1MakZGTjVUaEwxWGtOcld2d1BkZ011Q1lxc1JxWmRiMGI3OVpxZ2VL?=
 =?utf-8?B?ZkpNdThucXppK2k2dURjeEZlQkxMRFhNNUZUeXhsN1dTTWRoU0k3OVNmcVda?=
 =?utf-8?B?U21WTThzaGJiNU1CYUJpYzRQVnRPcE0rV2xxTWtHSDlFallUL21qZmJ3eFhU?=
 =?utf-8?B?T0x3aEZRQkpxV0s1cGhEUEVDWFFoRkkveDlJN1ZsN1lnYUNSNHY1SzkvenNi?=
 =?utf-8?B?MWk5ek8ya3ZhTDhuMmwyVTBWZ1Exejd6aGd5d0pFNjQ3ZjBNaXZuSXgvVUxW?=
 =?utf-8?B?c3JUaWttbXlWbGJHRHRNeFNrc1hwYmR5K1hDUy9WQU4va05wWGJCWFREQ0ZZ?=
 =?utf-8?B?NGEyYWdWblI1OGdBQk9hblVjV3pRd1Z2Zndic3ZLUnBTZGFQZWNEMVlraE5K?=
 =?utf-8?B?TmxKNHRnU0I4MWJ3V1hBTkNUcHF5aW9KK1NwUGZqamtkM1hKYTY4ZGFydFZz?=
 =?utf-8?B?bFVIUkJzUjFPVnV4aUdCV1lOdGdodDdGalVlc2MrTjNmd1g5MXUycFlDU0I1?=
 =?utf-8?B?TE1mM1V4dCtCYnlTYlJDSjhaeHkyaHlMVHU5YXhUT2x2ZS83VGZjakJyZnYy?=
 =?utf-8?B?cGlQeXI0a1lPV251VXpuYkFzd2hDUC9LQWZCR2Exb2c4TEY5ZmtMMlJNMXJB?=
 =?utf-8?B?YUsvb05MSmt6SDBINXhHWUE4OXdoakxvQVlYbGpQNU5kVlIwVG83OVZQVGVM?=
 =?utf-8?B?b0c4Y1FFV29hbFlEc2xaZTdGV3VKWFlrVnpjclM5ZzB0OUxzZU91YzYralhM?=
 =?utf-8?B?Z2NFcm04K1hJcXl3bHB0bUNGYTdURm5RTG4vMTRoY2EvZ3lCMVlNU2Ywenky?=
 =?utf-8?B?ZGRIQzBoMDM3VkJiWVdiRjVEdmhndC9ZM3NlVWdLVjNGbnNNWlBDRmJFOG9G?=
 =?utf-8?B?UmJqS2p2VC9OMjE3SFgwYTEveFhlQklZczJXcVBGOEpTQ3dhci8wWlM0NGVN?=
 =?utf-8?Q?AfQbP8TeurbjwXvyCTkDwegW8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a155a0b0-060d-42d0-bd26-08dc69387e9b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 17:10:54.4596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QO1FATot4LmbZiy6Gy2TtOc+wbhG2LfCc+w/TZhemyXRGObGo4fdszku1kKXlehhrK/sCqshKPBzf07/BbEbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
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

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 4/23/24 9:29 PM, Srinivasan Shanmugam wrote:
> This commit removes a redundant NULL check in the
> `dce110_set_input_transfer_func` function in the `dce110_hwseq.c` file.
> The variable `tf` is assigned the address of
> `plane_state->in_transfer_func` unconditionally, so it can never be
> `NULL`. Therefore, the check `if (tf == NULL)` is unnecessary and has
> been removed.
> 
> Fixes the below smatch warning:
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dce110/dce110_hwseq.c:301 dce110_set_input_transfer_func() warn: address of 'plane_state->in_transfer_func' is non-NULL
> 
> Fixes: 285a7054bf81 ("drm/amd/display: Remove plane and stream pointers from dc scratch")
> Cc: Wenjing Liu <wenjing.liu@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Alvin Lee <alvin.lee2@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index 5920d1825a4c..8e50a5432d33 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -298,10 +298,7 @@ dce110_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
>   			dce_use_lut(plane_state->format))
>   		ipp->funcs->ipp_program_input_lut(ipp, &plane_state->gamma_correction);
>   
> -	if (tf == NULL) {
> -		/* Default case if no input transfer function specified */
> -		ipp->funcs->ipp_set_degamma(ipp, IPP_DEGAMMA_MODE_HW_sRGB);
> -	} else if (tf->type == TF_TYPE_PREDEFINED) {
> +	if (tf->type == TF_TYPE_PREDEFINED) {
>   		switch (tf->tf) {
>   		case TRANSFER_FUNCTION_SRGB:
>   			ipp->funcs->ipp_set_degamma(ipp, IPP_DEGAMMA_MODE_HW_sRGB);

-- 
--

Thanks & Regards,
Aurabindo Pillai
