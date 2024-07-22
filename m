Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15604C3DA70
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 06:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A47A210E370;
	Mon, 22 Jul 2024 06:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bEwSdGP2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C03F10E370
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 06:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+tTCHgHkod1FssJ81CWHIKzIVKSJjBcM53VL0//a5yW7VocuEaEZKQX8FPXqG87m81dTAvhajI/D4V/WeVd/bKopKrfo8ArauNb3xMkYL4pUELPNQudk7VkWyy5SwY9ieegYZztjaKHI9ZVRNJiUT3AShI3bQGHBvEy7/yM0vbdtGwySJe6whFFVi9KrShAsUEX8TNfEsLhOFG9cWHQZv5BAA76iVi/kCyns9RbuuXt7te6y3NcOopnRi4f8nbRctkNJOlUoXEEi5wGvCxIht2RdFu5xsAoy0iQCcnBQGB/83pVpk2bnPVz/nRyOT0f1QKJzBKGips1vD9AGo0mpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRJV/k+exInpogcMvVnctu+TIAYrBRXtICa329px+V8=;
 b=nuv/5HGJyZl2zOO2FeVHTmZKMKL9DwmRG0cQWDo4enrVGBD7NoYbVDNvfbNT8OZRsOvY5GQidd2JkJQJQaEI7uDt0kYlzxjK5Cv5lNQJAjw2URpLz3ieBVqgwdGxS92ZpAvAVAnRo3UqUfYI8xC3TVZdZtH7qPGjSiibfpN/q6tiD2u4UCbqUpAOp9Wttgs4JOnPgvKH+EQVGPn/8Vh4QtNR1yVWEprlKTFYFS8ARQbUmgs++1/pzOzc7GOIfZki2KXxENoORCVvfk2uXFd+PMgPEbm4PUrnppe84U1Q2vvWvRBaX01wgi8lxxJRJ2DLWHAgVpBDVZ1knq9QCZiTCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRJV/k+exInpogcMvVnctu+TIAYrBRXtICa329px+V8=;
 b=bEwSdGP2lFeYYPN3Bel8usM7HelxmDxtBETbS3i5rF2VEw90MfeIUuyzQzw6RkU1nsENLWxtuT607vl1Yv/3pDuWPjZOX0jugNfiHT/WFmMFuZB2Aw3iAdfpjpJN/hZ9vEmx9FxQZSCPtWPczlBAA75lgPlzUk6B4dU1HnToqZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 06:33:42 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 06:33:42 +0000
Message-ID: <e3cb840f-0225-4f33-b63f-c51ef4e8892d@amd.com>
Date: Mon, 22 Jul 2024 14:33:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/display: Add null check for head_pipe in
 dcn201_acquire_free_pipe_for_layer
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240722014646.3558293-1-srinivasan.shanmugam@amd.com>
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240722014646.3558293-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: debadc63-ed6f-464b-d2d5-08dcaa183ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnUyMUUwbUhibmJMT3kxZ29MU2IrcTFBWklUUXRHNTZBQ1U4UmJFaDFZSzJQ?=
 =?utf-8?B?WGIrVVora2cxTkthUk10aGg1SnlzSmtvTmZQQ2ZmbnJlS2tHSHhwL1Z4M3h5?=
 =?utf-8?B?QWVsNTcvRHpwclU4N21hdzJsNkFQTlVBalkxSWkydXJ5dWh6a3lYMC9ycW0x?=
 =?utf-8?B?ekt3V0pmRVBMSnFWV2NuZ3Q1THpPT0p4WGR1NEdkYTk1WEFjdFJEcGdlbVEv?=
 =?utf-8?B?YzhYUU8yUmpiSzFyVERONXArOC95bXRwN0F5YlpjdWpCSVFYeGtMUDRUMGgv?=
 =?utf-8?B?SzJNd0duQ3FJUTlRM2JKUEphaDFicTFYcGlXVDhKUVVsd0JaMDVVd29KWWF4?=
 =?utf-8?B?UGcxOW1sSE02eTMwQm4wWDdFbVVCc0Y3NXErb1RzUU5qRE55d01QS25WdE5i?=
 =?utf-8?B?WGJXZ1k0czVhK3BlMWs2VnZ6Tk5sUlpBaDRBdGxTcWQ1WndRcVdZcEd5Vzc2?=
 =?utf-8?B?RW42TCtpZ241NVhuY2I2aTY0S21paW9OVS9jYmo2SSt6a3dSbFUrOGRpR1JQ?=
 =?utf-8?B?bkZNbjhteGtnSFVhcGZiZXkzV1ZETzIzNTFoUFEvdXVTNzk2L3h1TklLNkZj?=
 =?utf-8?B?TGlLTXdqVDNqTGt1U1M1U1FBWjhZYzRQYjlrWUZSa2laOFdxNmNTNmM0b0U3?=
 =?utf-8?B?Q1RQWk4zZDRGNDFiZWZmb1QzSXJrTkFuSkJvakpXTlk1Z0FRMDFIMDFqZXkv?=
 =?utf-8?B?aDk0SUJTY3A0TDhHYmJYemhzbC9NYVgwN2tNdTYyaFRYMVovSGoxd244aW5z?=
 =?utf-8?B?U2wyTHhzOWdURXIvUjNId1d5eDZLUnBpYVZ6bGZydSsvV3IremM5MTNyOEh6?=
 =?utf-8?B?T3c0Y1BncEhFRXNwTFE2czF2TlQ0SHZZZHVhY2FwZHpZaTZCdW42WWdtckxs?=
 =?utf-8?B?MXo4Sk9aSWg2cndBWEpPb1NpTklFS3ZYV2lSVUJMcFVXSDUwa2h3QnRnWi9J?=
 =?utf-8?B?eXZremlDZHI3WDY5ZVE2bnhBMjBGMlFva01TUThTLzZSTENRSU15amkzL1lC?=
 =?utf-8?B?U0xPVEVWK3p4ZWxlS3FjNThxQ3BWc3ptZjZBbUhSaWV4OVdBR2U3b05WZmZ1?=
 =?utf-8?B?NklOdnRhcmg3RWJYY2lQTnB1eWxFb3JnYkpyZHF0ZmJlb0JYTVV0NlRZTzJY?=
 =?utf-8?B?MlJ3OHNOYUU1akR2WTh0ZzB6dER3c1pzTmRTQlE0OFBORjdPN1FyU3lXdzhM?=
 =?utf-8?B?NkZyUEY3RTZHdEVXMEovdHd3T1p1RmI4WUpKYndPQ1lIc0JYZk9nVENwWFpV?=
 =?utf-8?B?WEk0dkF5b2gzYkVhVGJFblFHVlNBOXNyRnI0aG95NW9ETnFPRm0wL2l1K204?=
 =?utf-8?B?MytGQkZZTEY3SzJ6UUZWSUJCTFltOFcybWs1NktkYXAyTVo3d3hwcFpOS0p1?=
 =?utf-8?B?RHpHSCtsWTNaaWMva3hMbHFLYlZ0Z3BScVhqWmlBR3I2MmN1Y0RXVDIzam02?=
 =?utf-8?B?NjZDYVgwOUl1eGRsOG5YNXhaN014NHNCYTVMWWZoVG9EbWNabW1xQ1FRRGJR?=
 =?utf-8?B?MHVNVkd4RFd1MU05NGVHWlhSNHloNEJwVHNKN1MwTnhYbjFHSXAwUUpLcU1k?=
 =?utf-8?B?NHBwcjhweWUrSVdBYzd0Yi9mRDBrSENhc2wrU1VpWVkvV3hicWVLdTdnR3Bm?=
 =?utf-8?B?cEVCYXVxUDZUcDcvUFlpVWhPdnVYeENiYzBja2VmZkE5bFQ1NzRVdkZLSmJP?=
 =?utf-8?B?eWZSejZuQXZSdFNrcStFS041RXAvMzJPbmFJa2tKNjRJS21rK0NGdW15SThF?=
 =?utf-8?B?MHZvWmtBeGtzMEhSTlQyOVVMNExaK09pQ0VUTm9odG1XckZlaDV0VHJ0b0tp?=
 =?utf-8?B?bFMxRFdMRHg4a1dpcHRaQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGR2S1Zqakt6SWhUS0dHaHpNdkJ6elJITDhJUlZpeXR4TnJuemh3ZTNzcVdL?=
 =?utf-8?B?N0o3N0t4Q1NTNEl4c0d1Z3BXRzlTMHIya3BaYXRFc2hnUVk1NWNIYnVoSlYr?=
 =?utf-8?B?THgxNk9RcVoxazJmU2FwSUxFbVA3Rm9kL0RrVm5GZmNIYmlkNmF2OXZKWG1u?=
 =?utf-8?B?WXN3a1VZUC8yMzRUUm4wZE0vWVRZYThoWGhhNndlRXBSeTY4TmlJNHVtcHdN?=
 =?utf-8?B?dDVleEVyK2RHMnZtYXJGTTFrRE9HT3hqRUE1Q1g2M3g0TXlTRm05Q2tZN2ZL?=
 =?utf-8?B?OFNHS3k4VU94bzA0MUtZcEZTdXd6b09raVlBTFkvNmFKL1pKOXhoQzBmNmVp?=
 =?utf-8?B?TzZ4TVA2UXl1a2ZoemtHblkyQjhvQ01jb2xRaDVEYXUyNk5hYzdaancxdGhy?=
 =?utf-8?B?KzJEb3pzWWpMSngxVk8yT2dHd292Y2U2V0NyQzFLUDlRNzFoWnlqVS9Rc3Qz?=
 =?utf-8?B?aVkwRGt1dUl4MVZyRVJwclpQaGJ5MFp6Y1IvZW1BWHQvZ2pqMUxDM0hKQnpJ?=
 =?utf-8?B?bnVDWnVBQlNQVytidnFQT2lSNWM2ZFpyQ1Jrc2hycVpPYmJRR3FtTVlPdlU1?=
 =?utf-8?B?d2lDYWRvejJQT0s5c3BPUXVDTm5EempSWGdET0pYWnVMSzZjR1BHaVNSb3cv?=
 =?utf-8?B?Qlk1ZnBiekcyNDRXSzVuRlo3cVhhbnYzMFBUeUZ5THEyTUVIbUw5dTYweWln?=
 =?utf-8?B?MW11ckdNSVNWZTZVZHBoeU5zUENWUlFrRFd3eEZHeTJxOEZrSGd2Um5hbHFG?=
 =?utf-8?B?QVdhTmxwZjMwTXh3VEw4bzhubjQzV1d5dE1vQndUQ0ZLaklJUU5zRXVTRG1R?=
 =?utf-8?B?aWw5WVpyMHhMVXdzNGpFQWgzVlF2bWRUU2E2L1Myd2V1ZXZtblhHMlA2eFNC?=
 =?utf-8?B?eHpLVUtmMDFxeEJJUTdpaGlmQTlnbmI3Wms5QlhSOWxVSnJFRDMvSGh6Y1Yv?=
 =?utf-8?B?TG1OZmtOLytjcm1xZW9aQTRiUit0QUtac01Pb3h2bXYxU29MdjNMc2Q0MWdU?=
 =?utf-8?B?ZVlqRWo1TndtRVZkK05TcFhFUThrSDdoUkQ0aGdjb3FDSk8yS0VCNWxUVndG?=
 =?utf-8?B?dnNXNEZYTXdIdTloWVRKaEVYOHdCZHdNMkJ6SFFINmlqa201L202QmZNSUZZ?=
 =?utf-8?B?clVLS1orYUxlM0lDTW9xRkoxY2gwWWhiQ2h4cDVpYk9TYlh6bThZTmpFenpo?=
 =?utf-8?B?UzVaZ2NkeDFlT1FFcWJNczIzVkZzc2lIZ1dSV2orRHA1cGdDUjlNNE5ndFg2?=
 =?utf-8?B?WkpzYW1PUHAxV1R6Y01UNU5qWU5oeEVyaEw4WjZxYThJMlhxSTlrcUNRR2NE?=
 =?utf-8?B?a2hZakY1MWMyQUViWUNNQjdXbjYzY1JrNURlMHkwTXZXamtxSDNJMjh5YjFh?=
 =?utf-8?B?bE56TDV1SVdBTndrYkl4L3VZbkZ2bUNjbHJiQkZmNmFGcjBscDR2MElVQnow?=
 =?utf-8?B?M0Z0UEdQR2lmYzV0dUEvR01JZEtLT25BdFNxZkdDKzBuMWZiU3d3UjMveE82?=
 =?utf-8?B?S1RKZTBLUnU4NkZ2MTkyd0I5b3p1VVg1VU9zdGVCUXpIU3ZSYStYcWo0N1lw?=
 =?utf-8?B?S3VhQ2hoLzQzNlo4eFB1bVpEZ0l6Zjd4Vjk0YjRCUmcwWUxSZXNRd0FDNnhl?=
 =?utf-8?B?c0NTQ0ROOWhHT3h1MmkrOVYwYi9VSXZMUDE3Z2psUXV4MkhjZGtIZGNjZnBR?=
 =?utf-8?B?KzZRQXl4RElwa1h1WGdyYUt6bVRjczNpSDhYcHdMMi9ZZTBPL0JTYkFTZ3BK?=
 =?utf-8?B?OEowcVIyc3JteVhaenNXb0pMNWt1UFFrMy8vamwvVWhpWjZSQmc4WkJUTlhF?=
 =?utf-8?B?WGlreEVFVG1uUU1MbWlwY3BPcS93emFRT0lieWRWTkg1cTNSak05ZUhNMGhQ?=
 =?utf-8?B?RFlJNlJpYjROb0tnSE1RdVdkRTE3MkZYMm01OEhXUzJVQ0NsZjdpcFhLQ0lm?=
 =?utf-8?B?UUtuSHZMSzNPUmJ5ekN0MGFYeE95THVVSDJaN2tqZThCYlhkWjlQY0l1RUtk?=
 =?utf-8?B?RGg3VGFGMUY3dDVFU2haREZkbjBzOG9kdjBVUW0xVXBwMzBTR3Fva1c0a0Y3?=
 =?utf-8?B?VmtSdis4Tzdibkh0ME5MajE2OWxSR2c5UFh5MVo3TVVUOHNFTXpPOHhCRWRW?=
 =?utf-8?Q?+tvnmV40Y9iz3SLJ7UtQclZpj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debadc63-ed6f-464b-d2d5-08dcaa183ad2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 06:33:42.5198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pznkYABQrhldpvKDOwLoVkIsswUZBLq/0SF9Z7NqXJaR7ohqRJlPi0liT6U4J/tcMluJv6GRYYRMoMOK4O+okQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934
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

On 7/22/2024 9:46 AM, Srinivasan Shanmugam wrote:
> This commit addresses a potential null pointer dereference issue in the
> `dcn201_acquire_free_pipe_for_layer` function. The issue could occur
> when `head_pipe` is null.
>
> The fix adds a check to ensure `head_pipe` is not null before asserting
> it. If `head_pipe` is null, the function returns NULL to prevent a
> potential null pointer dereference.
>
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn201/dcn201_resource.c:1016 dcn201_acquire_free_pipe_for_layer() error: we previously assumed 'head_pipe' could be null (see line 1010)
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
>   .../gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c  | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> index 131d98025bd4..fc54483b9104 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
> @@ -1007,8 +1007,10 @@ static struct pipe_ctx *dcn201_acquire_free_pipe_for_layer(
>   	struct pipe_ctx *head_pipe = resource_get_otg_master_for_stream(res_ctx, opp_head_pipe->stream);
>   	struct pipe_ctx *idle_pipe = resource_find_free_secondary_pipe_legacy(res_ctx, pool, head_pipe);
>   
> -	if (!head_pipe)
> +	if (!head_pipe) {
>   		ASSERT(0);
> +		return NULL;
> +	}
>   
>   	if (!idle_pipe)
>   		return NULL;
