Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B340CC02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 22:07:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6252410E49E;
	Mon, 20 Jan 2025 22:07:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5PmQUsXW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF8910E49E
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 22:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PD/fqmLmGrFNreK8ybZA42jvc7cUuh3dTAcjtMxK1Q2DUnIk17ushHQjd4ztIppZoht0I/XZh5dzXt6/QT6NCdpIipyLdFmxuEthm6A4v93wpZNHcyjmpIrq/ImFzcwsJhmRgMBM46UfUqPqC79cpy/gDcrjEgrxtM4zbFid73y+0OGcP0of1Ij1Vu7iDvH9SAQ1/spzVnL/R/OPQl9Io9z4zdsRKhrbZsFoKQv0kXpxfKmFdpgbfC2F1Ys+IBxgF4BKyEuBZM95kuqiIQN1pH7ntsnzq+30lh80NKGtYhGPNJXioO8adu7K51brgYnFeddLu8GKs6ThVdDehTCaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fw+OlvOOwFtpDTDnQjCBOppkhxYc2SFIThD2bzyKi+c=;
 b=t7UAKNPhaGEHOcayaFSzzX44TrI+YyddHdZvvxL7RNEzhM5LsD/je6Um1wyNP/lyXI4KXPCwrw4Mw2rwePR2+1GPKEGzU8D3drhFY7UQH8HFFmQxRtvtGZNzD9CzoCsswbAIWcixVw59aIOF+TKWxVo/tt5u1HKYCoBMgFiXjxe7O+dzXqcd+9GRTonGC8tpbC5MfwO/Nu9X/dypLsEms83PQE6dAYIQn3wPfEBCzfch3y+9TuZyDVJjKttxHFXKdOiS0CqGjNFND1w5OeRojYu+srbDoHUISinNgeAxgJ7UK4GS0zC0+zPt5X9EGNpOv5v4jU7grm5ezYFJcWoOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fw+OlvOOwFtpDTDnQjCBOppkhxYc2SFIThD2bzyKi+c=;
 b=5PmQUsXW5UpiWsdX5x/yXRUk4u9uMQU+m28xCJCzjdTzhPx1v0wmPTiR5RvY4ijrXISkTu5P3grPQCQdfpAoJAQeafKp9sL+kCgUzLs6nzehrH+Ti67S6vPv6MYO63SDTTXRDJbXgXa0/DeYF/b2f8TIhaowxr3VnsxAcEJxWnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Mon, 20 Jan
 2025 22:07:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 22:07:00 +0000
Message-ID: <2ca6e5c3-4570-4c47-9f3a-108e2a4a0bb5@amd.com>
Date: Mon, 20 Jan 2025 16:06:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] amdgpu/soc15: enable asic reset for dGPU in case of
 suspend abort
To: Jiang Liu <gerry@linux.alibaba.com>
References: <cover.1736739303.git.gerry@linux.alibaba.com>
 <2462b4b12eb9d025e82525178d568cbaa4c223ff.1736739303.git.gerry@linux.alibaba.com>
Content-Language: en-US
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, Prike.Liang@amd.com, asad.kamal@amd.com,
 sonjiang@amd.com, shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2462b4b12eb9d025e82525178d568cbaa4c223ff.1736739303.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:806:27::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ee1fc8-5f09-4abf-978c-08dd399ec349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0NnbE05ZStZcm1CYko3NlpMajd1UmJIbWRCcmFpdkd4K2pJSmVpQzhVUU5O?=
 =?utf-8?B?NHcxSGdFNlhtUng0dGQyczg4VDV5Y3Y1RlErbUlDTnJnRzRBeml1UVJiOStI?=
 =?utf-8?B?aDIva1lWcU43Y252UmtLaGFEQzdGQXJWenpEK25kMzJtVTFCWDlkb1NZQU9G?=
 =?utf-8?B?ZVJoMzBJNFB6NzBPRC90S0dFeUxpNDF4TUlPVzlJc0RRSm5id3hvVDJkWDFZ?=
 =?utf-8?B?eTJwa0hXYU9xanJ2SGNENzR1OG42bWZ3QlU2WlRkRiszU2lOVDA0UUZPNnh2?=
 =?utf-8?B?Smc0Si8va3l4Z0o0RkdpOHh4S05EZ216aU03NG83c1lZY1dpS2wranh0SGda?=
 =?utf-8?B?OG9ROER6WXAzaHhGTDJhUXhCbThVYmtHNzU3aXRwcjNFVkpPSEJId1I5OE9M?=
 =?utf-8?B?NlBMcEdGTlV5T3NGOWx2VFdXWXFxeDFFNHRXVTNTQzlOVEZYd0dJZkxFZFFD?=
 =?utf-8?B?T0NLMXB5cmdNVk5mU1c4Wmd1ekVKUUg1YmdPenVVUFVJbktxTkZWdExsa2tU?=
 =?utf-8?B?bExMZ3pkeUZzdHRMWTJzZjl3c1JGU0NPQVJqRjJFcEx5ZDZESC91TFZ0dmlW?=
 =?utf-8?B?aUJ0R1hORHY3QjFLamtlM2w3ZkZ6ZHp2VjJnS1NQQ2JFdUh5R3pFNE1iL2RK?=
 =?utf-8?B?b2lDaStqVUVhbW1EWlZRSzdMSmVtbjUvWjBSa1krZVpHYlJ5aHowaHNWV1Q1?=
 =?utf-8?B?UFpGKzhuYmRLN2o1bVA3TC9jTS9mSFBDM3h0bGt6eEtyK09XU09KK3lJZ3cz?=
 =?utf-8?B?bnVnNDVrT2ZTcWdlNEhuV1NKYUFTcDRReXlXZDhLLzEwaFYrT1JORllNMUJp?=
 =?utf-8?B?YVIvSS9nWi94elZZaWVuNzdEeFR2ZnNXR1lBK2hzbWNlMzRKLzluSjlHR0h0?=
 =?utf-8?B?V1p6Vy9zeGN1UDBkblZ4YmpEV3FjSFpXaTNKNHJFSFhENms2S0ZXWk1jT094?=
 =?utf-8?B?eTdzTW5FVGcrR1FldXZGcWVYdmR0cUtkK1hacTZWU0xzaGJ1UDBxV2hWS3RI?=
 =?utf-8?B?Rm9xR2tuZ0g5eTBZclZxTWxGOHVta0pIUEV6OHlwKzdCTVJoWmh3dGJPbmVt?=
 =?utf-8?B?TW01a2FCR1NhM1lsdU4vUmFHZVEycFkrcThJWlAxaExmZ0UyL2Z4UDVpNkJS?=
 =?utf-8?B?a0lmY1RRQ2FNYVdTR3JHdXN5UE1teTMvdVIrQmVBT0NvRzZJcDhkeTVCWEo3?=
 =?utf-8?B?dndBbHFiU24rd2NGN2hvNDdGOHJtWk1YZjdhR2hydmNKQWVReXJ4eTZDY3F3?=
 =?utf-8?B?aTR2ZXBqZUZYc2J4WXVZNFE3aFFFM2drUkdBL0laRDk3U2U1R3Fick0xNzZj?=
 =?utf-8?B?SjdqU1FQWUJaRDRzREg2dlgzYWQ5NTg4TkJQdFFvR0d4SVlsL3RleTR1Ulor?=
 =?utf-8?B?ZzRYSm1yNnJPRjZoS0l3Z1JENnV3Z0V2MlZHY2xMVEk2MDRwVEpyV010WGhp?=
 =?utf-8?B?SFE1TjFEQ2I1akY3Z1lIRWJBSW1hKzZYdWFXbTk5cWJNR2ptWjNTN0V3Rndm?=
 =?utf-8?B?MHpEb1RCelVVZzlSSE1kaUNxMTNmZ21LK2VyVTh0RUJyUzBDZERUVzVJWFNP?=
 =?utf-8?B?a0YxK3F5aWRENUJjVTd0YjhVUXhPY2l2WXA2UW9TUmpmbXpOZk14ZHBVQkdK?=
 =?utf-8?B?OStsbldROWxRTWt1bGFuK3JKZ285R0dkYjgzU05hVVdYYXNrWWp5YVhVOUdv?=
 =?utf-8?B?cGZWWUNaYUswSVFjNGUranRTNloxUEhSOUxMR0ZmVG1CaVhHME14cXhHdXJi?=
 =?utf-8?B?QnpqRjNmNGhKQ0FYNmVjT0hsYWQwVE1DMXQrWEJSZldtRjIyM25DdzgvUUpy?=
 =?utf-8?B?SVg5aFcrRHpEdnp2UndJaU0rR2x5M1IyaVk1blloZ1FDSkxrTEVnSWxzOEsw?=
 =?utf-8?Q?DON3lj+6By/Wj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHlMWkVpOWN2RFFUQmFvTkVGNzhPYTNVSUprUzRPSEM3TnlZNUN1UEMvMDJl?=
 =?utf-8?B?d0E0bmIwZzQwOHJxM3RqazFqUEZ1eVduU1liV3NNMWJKSXphREpsTkQvMkoy?=
 =?utf-8?B?RTFPTDNnMzJ4SE9TMUI5OVh5U05YL29DMjBWdExkODlDQm5KTmNsV3FTV3hp?=
 =?utf-8?B?SmtQbjBqWU1zWUw0VjhqT1VEVzlzQWVPKzFSNDUwV1JCeitMcEhsRGkvZnRt?=
 =?utf-8?B?dGcvWUJLUTVWVktZTzdZdWdhdVhKMWpnVWF6VWdxQ01pRGFBT082MW91dWtn?=
 =?utf-8?B?NlN3dE40UHJ2K3N1eFJqNThXd0FsY2JyQWluRkxpN2l5UzV1L0pId3BXdDhp?=
 =?utf-8?B?a1J3eXNLazJsNFpySzZwSWc3b0hTdXVKQTc3bkhXVGhUZGZCcnpaVk9TUU1o?=
 =?utf-8?B?dEIvN2ZuWmhXUFFNZGhvN0V4eTExT2VVUS9rUTg3Z3NrUjZ2MWt0M2NqMFVi?=
 =?utf-8?B?NGpGSW13NDNhcmNIZTRDdW1Gd05BOHNYbDZnOUxhUGRJSnVsZnRReGlyTEI4?=
 =?utf-8?B?R1RsVmFJV1NjVG11Uk9FVGVhTUE0NjF6elZ5b0Z4UUxERnNjUjZBOEt4Mndo?=
 =?utf-8?B?bFJmUDFsdlFsVy9HZWtybENibFBSaHNGK0puZy84bVpJcDk2NWM1SFZYcW50?=
 =?utf-8?B?bFBRLy9RMkx5OTFLNy9jVjlXOWxnSFBROTJMRmQ3MGRiSVFzWjBhWjNFY1Qv?=
 =?utf-8?B?T3hHYy9iMzE4UTBIRjlSQUFRZ2ZReFgxK2lJaHU1U2VGM0YyN25FTWh5RG95?=
 =?utf-8?B?d2xJL2pCMVA2S0JPVDVXWDNDdUE5V0ZNUkhicFlYT0d2R3BvaVpMUnpsR0FD?=
 =?utf-8?B?ZGxYTG42a1JnUzlER1BramtwLy9CU3FadlJsaFkvZGE5TGJOZGxRdENpWmFw?=
 =?utf-8?B?Zyt3TDF3QUxGd2ZNelB0WWVYM0E5QlhSVXRyRW10cGVtZUIxeWMyb1duc1J4?=
 =?utf-8?B?UGVGc0xkTHhQeHViWVl2OENla2ZwemZTUmNDR1o4VGlQeWMra2l5RzFJRUdH?=
 =?utf-8?B?Yi95MUV6MUJWOWJqQmJVMWgyeFI4USswcUdydURQdUJsZkxVN2FOQUxMazZF?=
 =?utf-8?B?NjlVTnBkanpHNGpTbmI5d0NudVZyTWtXUnBNVjhSUFV6YlNPNXIyOFY4Zkt6?=
 =?utf-8?B?Z3kzcG8rNkFLVGJuZEFIMTV6bXdiaFQ1N09EVDJqRjZhU3NSYjJLak8yQVRi?=
 =?utf-8?B?UWdrM0YrT1JlTWRYclZrVUg3Ujd2NE4yVjJlN2RPZ0ZZSUxVaDRxOVc0Y0pX?=
 =?utf-8?B?K0pxU1F2a0hpellUeWJudlVZekV0TFNKVmNMRmdjVGNYYTB6QVhrUng2ZTRD?=
 =?utf-8?B?cHd4UHJZd2sxejJtMkhFSTVWNlE1WENQQnNQeFdDNmhmZzVJWlVBbVNZc0Uw?=
 =?utf-8?B?d0JxYW9ZRVR1ZjBDTUNoSElKVi9sSDRzZ0RUdGFheTFDcjMvL05RMFZZUzJm?=
 =?utf-8?B?bWo4dSsyTXZQa09KWEtXVHBzTUtNb0ZZbzhmMmFoRStlNGJTajhzMWRiTFY0?=
 =?utf-8?B?SWVxZlJpbzN4TUdtelZvelpiNkpLUHRrR0lMOENsZGYrUWd4SzdJNHJUeDgr?=
 =?utf-8?B?ZHp1YzN0ZzA1WHFjWmJ4dlY4WFBuWEhGcEIrcjNkc3VqUmc4ZDVuOExnVjQ3?=
 =?utf-8?B?SVd3SUMxZHc2SXJsVkozanlMcVlBU3B0TUVRdmhnZWthSWJ6OGZ0dHRubW5L?=
 =?utf-8?B?TmlZZkdhMW5sb1F2Y1V5dWdOemZCamtTekRXNFlrT3Y5L2dHNEtBYzdPYVFz?=
 =?utf-8?B?d0NqY3U1TTlvYW5XNk04dmVYTXNFUnNseXNGVHpGVThMTGduTyt2S3VZZ0p5?=
 =?utf-8?B?N3F4eVRkL2NKK3UyVHl1ZC9PUWNFTGRlekZ1U1JvUndMOGovcXN3YitWcE56?=
 =?utf-8?B?SG1VVnhsRlhFU1lIbWRCOWhnMDVjalg1SHFMSHlXVDJybGhNOEVEZzRKOWpT?=
 =?utf-8?B?cFhpbERGZEtFOFE1Q1BKSllvWlFlNS9ZdlBYczAvMGYreW53enFiNCt5UTdK?=
 =?utf-8?B?QWxzMEhIOURYNk10aFAzTXl1SFI4dWhRRm5xZVRUaVBZZDY3L3cwTyszMFFy?=
 =?utf-8?B?cVZLMXYzRTlVY0x0Qk9RKzA5VnpXNkplOVo0UWpWTWEyYmN6WmNQdzVwanpN?=
 =?utf-8?Q?LqOS+kKY0St+VfwBrW92/bNFx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ee1fc8-5f09-4abf-978c-08dd399ec349
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 22:07:00.2113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1F6GlYn5eyoMizTtd+PxqBCUSBGEkRCbqevHk8PDyWMasOH4SG9ItBt+FiKY9jlvv89twMhuy1ViNrp1dyC+rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797
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

On 1/12/2025 21:40, Jiang Liu wrote:
> When GPU suspend is aborted, do the same for dGPU as APU to reset
> soc15 asic. Otherwise it may cause following errors:
> [  547.229463] amdgpu 0001:81:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_0.2.1.0 test failed (-110)
> 
> [  555.126827] amdgpu 0000:0a:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_0.2.1.0 test failed (-110)
> [  555.126901] [drm:amdgpu_gfx_enable_kcq [amdgpu]] *ERROR* KCQ enable failed
> [  555.126957] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <gfx_v9_4_3> failed -110
> [  555.126959] amdgpu 0000:0a:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).
> [  555.126965] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -110
> [  555.126966] PM: Device 0000:0a:00.0 failed to resume async: error -110
> 
> This fix has been tested on Mi308X.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll get this committed to amd-staging-drm-next, thanks.

> ---
>   drivers/gpu/drm/amd/amdgpu/soc15.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index a59b4c36cad7..0e1daefd1a8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -605,12 +605,10 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>   static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
>   {
>   	/* Will reset for the following suspend abort cases.
> -	 * 1) Only reset on APU side, dGPU hasn't checked yet.
> -	 * 2) S3 suspend aborted in the normal S3 suspend or
> -	 *    performing pm core test.
> +	 * 1) S3 suspend aborted in the normal S3 suspend
> +	 * 2) S3 suspend aborted in performing pm core test.
>   	 */
> -	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> -			!pm_resume_via_firmware())
> +	if (adev->in_s3 && !pm_resume_via_firmware())
>   		return true;
>   	else
>   		return false;

