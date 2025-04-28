Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC5EC36005
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 09:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 200A310E1F0;
	Mon, 28 Apr 2025 09:20:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OgNCTg/M";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19BB110E1F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 09:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRSOylGyaI6i6MlgTjNq/R+PFgp0a5nP/QMTB54mKEZeDkdejcO+RoCb0bP10Wz8hkjPUNRkos6m5UW/K5dEzP2CkmJvHhZJ5M2X8x3AXFKNabbIFnEA3dQp6E3eyrzI0CTLHxvRTAA75TD/pkMsjl5bNVd3Xosiaa450kwtNaMkfFyJcF2wwWQdHIzKlaETK0TCasUXHJ+OqYoq2QLtHvntAVi3WloZ5+vO4plfKXvF4EAD/0iqdD4x2reeZIzgGAf78anhlS4NnLlgq9t0fVJliHGNmI7xgTLBqWMQSOuLLjz5BL/bvvRwye0x6dKAlmlqWU6i80//0AQzClXvDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAv33QILR733SX0EAE46cHAgkoZfjnFo4aibaCwxw3I=;
 b=wd6ErplzfqyiLIlMY7mQioy2OlyDXaHPuU3MvpfAGrF9eZ92xBPMt5NvkSn0RmaNsrlY0eeS1QQnalaNMeAgKX21YLwHOIKSqSejQLr9CXfFV+cfwQg3LHVjIfFAsronKd5fdZG0a5jR7Nrb4RuaUxmeGjL7hrLYyOJMxqAVNKzHmKgg/udlhz+B5vHgbksjEZNav46AGatMxjZOCwdb7xRgPXoYUhKL81kDJwNTxn9Bazf5+6uQSsRkw+icuCXsGLOqdmFh+YuzR3nRa2juZGkDb2up/iydSJdS2keuMHXMcJrXoa3+/fQ7lKcZFUB+ezcldhtNi8hYjUXWpyH/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAv33QILR733SX0EAE46cHAgkoZfjnFo4aibaCwxw3I=;
 b=OgNCTg/MxAT4Vo8NKwC6O9VARnMp3PJxWzwEfTtKIshbXrNYVuC7TuL6kuj2PgUQ1dE1nLN+vwddVl+tKQzPRu7UMITUtTUpCScHmVIeEeV9GJ6hjbbcmvasNkX9Qc5ea0D6DNP8ODvhToLHuBbbo0770FJ8AFjaiC8vYBbtFDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 09:20:40 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 09:20:40 +0000
Message-ID: <0cb29a28-6507-41cc-9dc0-fa9258b171ce@amd.com>
Date: Mon, 28 Apr 2025 14:50:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] drm/amdgpu/userq: add force completion helpers
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250425183855.165199-1-alexander.deucher@amd.com>
 <20250425183855.165199-6-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250425183855.165199-6-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0185.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b198ed-540e-471b-d066-08dd8635f1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlpPRm5IbGNRZUxCQ3hWeHlnQzN1VlZqR3h3MHVyV2I3Y3lGYThiUUpFRWls?=
 =?utf-8?B?cDNnSnp6WjcySnQwRDVTTFFOYTZEU3hTYkEzbWxKQXZpVkhQNVBsZWJsOXVj?=
 =?utf-8?B?NnRFakRjcXlvaXdMTEUvU2pNTE5XNW1TSWJDdUNpWXVva01EM3dNdC9XSklL?=
 =?utf-8?B?L29TSlNBT2FHd2ltZWw4NSt2clRwTXp4RFQyOUJoR0ZpVEQyanhaYmVibVJ2?=
 =?utf-8?B?V21YcER6SEFJWXNSOFBmNld6N3U1dFdUUUE5a2VWeWRIZ0lwcTVLdE5XV3dP?=
 =?utf-8?B?dllaQ2NIdGxDMEdwbkd3aG9HTVF3WGs4elpNK1I4elJTOWUrVnZ4c0lMMk1Q?=
 =?utf-8?B?Nk55SjhEQkVBb0MxU2NmbjgrYk1qU2ZPUXc3TFRRcDhQMVFrQWlHeDZkTnNN?=
 =?utf-8?B?ZlpjRkFSbUJDVWZBQUkybEZVS3J1aEdyU1ZGOVk1YTRiRWd5TkpqWFpaREpI?=
 =?utf-8?B?UzJtV2hVVFNoZEY1SGNXelFFc3kzc0oyNkFjS2ZkLzV0WG5NUzhHMWRLY0hX?=
 =?utf-8?B?b0FKcTdhSlhaU25RYVFyanA3VUE1SWpiSXM4Ni9yeHJ5bDA3UEp5a1JTRlRn?=
 =?utf-8?B?bmF6a0lreCthTFhmdVVRMlpxbVJwczkrRGJyK0RvelJlM1hXbE55elBNYngz?=
 =?utf-8?B?a2l3LzVUNnB5aGRxdDVTa2I3QUFwcGthMWRPeXJUNWVXbnVZbEkvT1N2UXR0?=
 =?utf-8?B?bVM4SDIrNHRyOHk5WURsRjcrRm9HZHYwRFRzQWV1Tmc5MkViSXNlWU9BYkU1?=
 =?utf-8?B?WUFyKzFlcC9rK1RBeWQ0RHdCZFZOcXI2SU5YM00vVXJyb2g4WUNnNm9JeFZo?=
 =?utf-8?B?YkZQUU9rTWpyQ3hnWGxBRWpSY0pyWW9sZVRwVzhxZ3l0WVduekZYRGo1OHli?=
 =?utf-8?B?em1tUVpMcjdsVGsvUGdRZUxyZWF2L1lBVzRac3lRTFd3N1lPMG45bituZm9l?=
 =?utf-8?B?YmRndm4zb0lDc0FldmpxY1A5WDdwNFQ2aVRBd2o5RlJkL0ljbTNvNWQ0REZs?=
 =?utf-8?B?MnlKbnhHK2pyc1hJbHhlNkVMSmNEam5vdXh3U1ZVS2FtQW95Z1hLYnRST3dT?=
 =?utf-8?B?dHQyM0RHZ05yOWluT3FrSjd6Smp0N3BTMHRPQ09hcE5EV1A5QVNBMWFOS3lz?=
 =?utf-8?B?Q2FCbTlIZUZyWGtxNWlKbU15VFBXQk1ib0hodldEbHpZVFJiYWZEOFRuNEJG?=
 =?utf-8?B?QzlqTUV5cTI1YnQrMUZVb1F5SUFjQTZyMG1obUxFVTA4YVg1YmJpZXlUblZH?=
 =?utf-8?B?Rk5idm9LVGhwRHdwWXc3UXZUc3BCVVJtaXN2UWFIWmFrN3RxTndZM0xZK2Ur?=
 =?utf-8?B?bmlsbmpyTnBaV2RGYUo4c050VTRrYXF3cDluWWdkVlJzVWNLQnA2N1V5SjJV?=
 =?utf-8?B?c0FkbnZiYlo4VEEwd01LM01lUGJPYzFncG5heS9nUnZnRDcwcmFtUE8weHUy?=
 =?utf-8?B?Z2x1UVNsOEpKc3BRSzdYVWtlMGVtc255WVdTSXhxS0krMi9Md01zUG50Snk0?=
 =?utf-8?B?WmRxRWZGeFdFbStReXlFUzA2azZBdzZhYTBabmRMQklzNEZsN2Jhd2w2TS9s?=
 =?utf-8?B?djZROWdaR3A2aUVrZ241REtMTGU3VVhzVXJLbkd2cld6aktCUEdObkFsVWNK?=
 =?utf-8?B?eVl3QnZ5aERGemdHdXNZRXkvVzhuY1JKd2UxZmI0OWZKdFJsYmswTFhmeFhh?=
 =?utf-8?B?UHc3end1d2g2VWhaRjNlT0c2R0tkTWRaMHdlYm5RUzg0Uk9tK1BBa3FtY1Fn?=
 =?utf-8?B?eTRqS2pWKzNIYWlFSHU1cUpMLzZvWGdCdGZMblY2QzJ4RlgyMVdXRU5waFpY?=
 =?utf-8?B?cHFGdkY4MDY1UVU4eEpxWWZ0dUU5dHVDMmZWTmZ3YWhBRjJPUW9VSVpsVHpS?=
 =?utf-8?B?N0JlS1ZUSU8yaVdBQW1YRlhHdDFqRDI4N1ZvRFN0bUhlMkY5TXU1L2U3djg2?=
 =?utf-8?Q?vO9BvrGZ5dc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWN3Z2VXVlEwdDZiL1RMSElkb1pNQkh2ZGY2L1pySmFQeG9tRDlHTUx2RHpZ?=
 =?utf-8?B?OTFBOFJVK2FsOE9nWmp0a2hTY3drTi9iYW5jOFRUaW1aV3VicVRvTmdTZldx?=
 =?utf-8?B?MForR0hxVEZpMFF1RHk5amV2VnpReFRpZmFtU0IrUDZpNDdMWWwybjNJbmJr?=
 =?utf-8?B?Q1JuTGdVSzZpTXBBUmp1R1JFNURjTEFndStpSjVYbGdNcTI0Nnh4dnIzeWhq?=
 =?utf-8?B?YkZqZEF4NTZzMXJBZmZXYmptT1IxVTlKOWt2M2xUNy93dkw4Y0ZSeGtKUFdr?=
 =?utf-8?B?ellqRGViWHk1SWlzQStpN09RRUJ6YUp0Y3RWbXhMdzRsWEJ6S2krUDdWSTZP?=
 =?utf-8?B?dUg5a0ozbVVBb216d0tBbnFGWXBoc2dMTlcwYUpVSmRZbEQ1Rk5HRnZTYlRR?=
 =?utf-8?B?YnBwUG9lQmppbERwdjV1Y3BYZW9uUStma3hJbEZSWWw5YWwycDZJNTA3NURr?=
 =?utf-8?B?R0Y0RWRXNHllaXBmK2VadHRqQno4cEpsSlhhKzV0K3pPYzhiQ1REdFpXbURk?=
 =?utf-8?B?Q2s3ajhVZ2t6RGVOQjlMVjQ3UnMvNkxBRVYzYkJyS3NmN1orNno2RWNNU1hq?=
 =?utf-8?B?YTJEckZ0U2pYN2dSTEpUWWp3L1BHS1ZxY0xCcG05aFlHZ2tWenZLcDhkZngv?=
 =?utf-8?B?VU53dEltTW91Q0RLaFAvTnNMRU9nVVg5TmFnYS9aOXpIcG43ZGZmdjNJRWlm?=
 =?utf-8?B?VXp6aVB1eFdYYUI3L05DY0M2aEpuSFMxL1RsK2U0Umc3QkhkM201N2NZdUhF?=
 =?utf-8?B?RGh6QitUZzRpMVprcDNsNTJNTUNNeDdHY0dCNHZHaFhjY2I1MTBwdkJHTWNj?=
 =?utf-8?B?bVMxeDdPVGltd3c0RG9yYjFaUEZZMTVIRXZpRjRpZnpyWW5mZHo4L2VYSnls?=
 =?utf-8?B?aVlGdEhaQ3RuT0oyeE1aYjQyRUdDMHhZNG9XUGFNNzhsQlplSzN4VzlwVDZi?=
 =?utf-8?B?TE52Z1Y5ZUZZMG9pSlFEZEprbmMyM1FNcEJ1dytTQ3dZRzRGRStMNjl4Q3kx?=
 =?utf-8?B?OEl2d2VYbmdySUhYT0JwZzhGSllTNjhrclpReEt3bW5tOXBGSUhkSWhvM2M1?=
 =?utf-8?B?OGQwdzFUYUg3ci93MXp6ZEF5N2FsSjdxWTZiYWZic3RGQ0grcDRyZThGZm93?=
 =?utf-8?B?eDVrb3lkdnQ1U0dLdVhORnlZWWd3ajd2a0xSY3lBanhDbzYxWWxBallXSGky?=
 =?utf-8?B?cFl1ODdYc3FIejJZT2prNFdFSGFpQ2JBc1NaWTc3K2FvN2ZuL0lVTzFWWUk4?=
 =?utf-8?B?bGphSGlyL3RYSURaeDE1cG9hdmRxaTlJUTFnejR3WWdRK01ST29QVVRwV0JO?=
 =?utf-8?B?Z0RaL2FLamN6bTJneXVXVWRsZnVEY0VudFRIRjYwbUR0eEpRWU9WNFJXV3Vk?=
 =?utf-8?B?Vnd4TFE1bmdST0hqcG05V0JVeHRqT2txcnNpZWs3dG9OK3Z6eG1ZTHVlNVF1?=
 =?utf-8?B?cG9aMldWSTYxVzZVbUxlYStQOThlREthUUxhV2Q5RXB6YlpHZHA5ZzVWcnJF?=
 =?utf-8?B?Znd6eDRoUk03cDlMS0lOUXNXTnptdFMrdGR2Q3pWaG9kNldjdEpETjhzRy85?=
 =?utf-8?B?V3FVazNranlXZzIzaHBwalpBWGwvZktvcHF3aDVRaWgyZjROUWllbXpMQlcw?=
 =?utf-8?B?aXhNQW5aZWFtemVNdE5IQzNZWGpJRExCQUd5MHhpY2xiRkk3TWdCQndvUTl6?=
 =?utf-8?B?VVhlMTJmYTlUT1BXQVA4dlBPRnQ4bXF5VFJpbitzdXBTZ1Q1Sk5mSlJxalpN?=
 =?utf-8?B?c1lMOTFlM1psMlNqUklyT2ZmMTNLa2lvVU5kM2JYU2psSjNnSWVGY0V6U1lD?=
 =?utf-8?B?WXYxb0F3R3FtYTdmYUZjUGJEU1o0MmhMVEY0UUQ3czdOMzBJTFViT2VnYXM3?=
 =?utf-8?B?Nk9uZDh2VWcxaWVCRzJmYWdUeXNrbWpsc0ZOUHhDbG1KbXViUkNJdC9jUS9C?=
 =?utf-8?B?R01qT1RhZWZzUGZBTHFOWXpyQ1JQaDhLWEgzbkFmK2ZUM0YrWlg0dytBMTF3?=
 =?utf-8?B?MHZTNi9YemNPWkoyZENNSkFZV05Rc0hCQWZQeTVjekxRb3FiQmZ6SVdaemJa?=
 =?utf-8?B?K2pHeHNJZXByV2Q4L0hxeE5GeXJIN1k4UEZTckRTbStxaWhQdVk2alV5eC9r?=
 =?utf-8?Q?RCNNSfap+HEAF2fVckZHEAjWj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b198ed-540e-471b-d066-08dd8635f1b8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 09:20:40.6835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mB7PqDz22LPcCGc5DUxHEFT2WRPRwl+p6btsWLjBQHvsTc6t2+Y7mTmmuV/ew0SKbqK3JtfPxRoIYDFhhrlGng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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


On 4/26/2025 12:08 AM, Alex Deucher wrote:
> Add support for forcing completion of userq fences.
> This is needed for userq resets and asic resets so that we
> can set the error on the fence and force completion.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 42 +++++++++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
>   2 files changed, 43 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3288c2ff692e7..3494ac9e9e9db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -67,6 +67,14 @@ static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
>   	return le64_to_cpu(*fence_drv->cpu_addr);
>   }
>   
> +static void
> +amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
> +			 u64 seq)
> +{
> +	if (fence_drv->cpu_addr)
> +		*fence_drv->cpu_addr = cpu_to_le64(seq);
> +}
> +
>   int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   				    struct amdgpu_usermode_queue *userq)
>   {
> @@ -408,6 +416,40 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
>   	dma_fence_put(fence);
>   }
>   
> +static void
> +amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
> +				    int error)
> +{
> +	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
> +	unsigned long flags;
> +	struct dma_fence *f;
> +
> +	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> +
> +	f = rcu_dereference_protected(&fence->base,
> +				      lockdep_is_held(&fence_drv->fence_list_lock));
> +	if (f && !dma_fence_is_signaled_locked(f))
> +		dma_fence_set_error(f, error);
> +	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
> +}
> +
> +void
> +amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
> +{
> +	struct dma_fence *f = userq->last_fence;
> +
> +	if (f) {
> +		struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
> +		struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;

Do we want to declare there structures to beginning of the function ??

Regards
Sunil Khatri

> +		u64 wptr = fence->base.seqno;
> +
> +		amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
> +		amdgpu_userq_fence_write(fence_drv, wptr);
> +		amdgpu_userq_fence_driver_process(fence_drv);
> +
> +	}
> +}
> +
>   int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   			      struct drm_file *filp)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index 97a125ab8a786..d76add2afc774 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -67,6 +67,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   				    struct amdgpu_usermode_queue *userq);
>   void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
> +void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
>   void amdgpu_userq_fence_driver_destroy(struct kref *ref);
>   int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   			      struct drm_file *filp);
