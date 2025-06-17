Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635F8C71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 12:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25EB10E60D;
	Tue, 17 Jun 2025 12:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ssXQHKla";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBAB10E60D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 12:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdcE7ydQnygYMdxBKmVp5ftuX2u9ZHBD06foczYAyURe1ezp1JTTxNNxaaBV2P66nj7dqXSJtfe5Dje3KfGrOIA/a0T3/DUmTd9ipwhZQ3kNdKL10JPeF9Q+2xcecUMuOtvsA2FbfeYcB61oQtnc5KRhmlJGdsx73HwEovRoaMvXbSgo46tTQ6T3pk0SZkr56b9x4QGQOYEULgtmHFYMQBuNuLvnkZdr1Q0tIXktAe5mACtGbDOUCLmCD9fwrfz3uhOFizhR4ND36Weiz92WREpWrAx3at26DmWhCgq7m6Tb75OGcgCSWG48X23+S/XcvrqVUw17+HNbWm+2nxAI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAHRJMhLcqyEvZDFpv+LE1tCXBlSwflcJ0LEQdbWBT4=;
 b=M76vaRR18/RJ01iKi68iVVdqu/FjcG+jHJLM7/+ABMqc41rypX5E9+lXDGnFpT4BrV+jqTtJAH67WxG3Ghh+9gnP51J5VQ766NOZByBhKSlbbFZjP35khOQ1rbLpEGzl80aCuWrWnANOkoiIh74+He1i7/md3C63+WIvikuXSNdEtdk/wFUf1nkGDQuTPiXSB6XreW3bBULaxRcBTp+O5SwhQwq/754/kLG6bnRS3DsKqXW7WHYxFPPIIRls3FSjuxg+QU1+nSjLw8er0M36oie6QHqqMk4gCv/XgUKu+p/zEC/lFTddKTQNBaQ+V2wcyJdxDmjNbqokeufK+NuSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAHRJMhLcqyEvZDFpv+LE1tCXBlSwflcJ0LEQdbWBT4=;
 b=ssXQHKlahPWDATqjJiUO/GCV7/OyGv4SHou9fsPergaSQcyjvHN0Gy24TWgoZXXXZ7dtHgYvmVS68qhSazdtJaTenHJnS/ILfccd7uC/pUFjkdm3CM7BMFZfWYsm0nt38kt8eUXyQ30WTYWcYue3q1A2X+2pyhEHuVCdnDKFZv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 12:29:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 17 Jun 2025
 12:29:02 +0000
Message-ID: <48e4ab80-65d1-4972-8d5f-2feb10e30284@amd.com>
Date: Tue, 17 Jun 2025 14:28:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/36] drm/amdgpu: move guilty handling into ring resets
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-12-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250617030815.5785-12-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:208:32f::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b3c758-00f5-42f9-166a-08ddad9a8ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmFyNGpCQWtBTGtESEhJdUE2bUh3NVJ2NVNTWHhuWS9CbEZWdnpCcVNQeWRh?=
 =?utf-8?B?elhWUHlTL2RIVmw2M2YzaU91YkNGbjJLSlVCT3ptZ2VaMHJqdU51ZXoyZFZn?=
 =?utf-8?B?K2txbzVrckZkcGhMWGNudGRrZUhSUW5SWC9USXZJdEc1ZGszSHdTQnJGc3B3?=
 =?utf-8?B?K0dLcUI1UVNCb0E2SzNQbWE2Ymt2Y25wcFNnTm1JQStmUmdDYVc0OC9mU2ht?=
 =?utf-8?B?alZiSGFKaWRxeVRHSW5uUDI3WTRzNVJvSkVZbDVOOGJzNDdKd21kaXhuTUxR?=
 =?utf-8?B?cHZuVnV3b0I0RUtNSmJ6ZGg2NG5rak5ram82QVoxRmdsamx4RmtUUHdNcTVR?=
 =?utf-8?B?WHhOa0pES09DTWI1Q0dCVWhXZkd3WFlwVG1oWC9JSFV5NGxvSGxtZXdmYlR2?=
 =?utf-8?B?MjdMRi9WaC9udERsbGRFNUwyc3NmUVRRRFcyc01CcFhpRmdvSzRoUHBOeUxV?=
 =?utf-8?B?TDFMd3hlUk4wZGNQYStLNFlGUU0xZHQvWGd0OXlCYXRMSURvRG1kWGFHcVJG?=
 =?utf-8?B?QUtVRlFicjZ0MXlFQXRuUS9ZWjU3Vk81Tkk0aWk2TDJUOVFJa0N3UGcwRHJj?=
 =?utf-8?B?eXkyTGxzQ2ZiZWY2c2J5b2QrbnFDeUxqZUh5M2JIVUZlZERVS3NXbkQwMU9Z?=
 =?utf-8?B?R3RackloTGFUK3hCbEF3c2pwVTdFZkhWdGs4b0RpS1VpQ25KWllydlVMTCtz?=
 =?utf-8?B?anBvWjRDR25aWldmakJudk9Cc1VTK3lLWUw3cFRrc0d4Vm5tSVlkUUhleWho?=
 =?utf-8?B?R3pCanRNNmY2blBDQkk5V2R2MnBWRDJqdkgvUnd6ZnZ3OXRBbWQwdFhQckc3?=
 =?utf-8?B?MUtXMmhYM0hjN2Y5T1J3c1kzOHR4SkFHVWR4K1ZwWWhnZ0VWbUlYZWFNRnlF?=
 =?utf-8?B?MjdXMVpROWVyTy9waThQKzZvbWM5alZ3MCtMVEJ6MUs0ZWc5UTlGWFJYb2o3?=
 =?utf-8?B?bXFKbmdmWDNUTEJ6ZHp0TmxQZFRkWmFIRW1xL3pPMHM3Sk1lS2tpVXBRdXpP?=
 =?utf-8?B?NjBRN3NuVGZhUkt4aFFaaFBwYUhUd3V4N29FU3lYWEtjMWtLR211TUJTMlhR?=
 =?utf-8?B?Z3E0Zm1vWHlOaWxvWlg2TWxNUGFwMDFHVzJwZ1BqMWc3NkNqQjFrUEtkRVRx?=
 =?utf-8?B?RWdXTDVrbk84cU4xZm12c2NJbUtoeU9IOGVlWFV0Rks4UzdFQTY3N0c2cENy?=
 =?utf-8?B?b2Y4WUVSZmpNTFRKRlZqeUlIUnpDTVBHZHR1cm1vME5OOHYrL0ViNHorVXlM?=
 =?utf-8?B?NHZQYXZYUTBNNnV3RGVrUHZsT1NUZVhtcnBTdC9GZWVVWTU5ZXZsT2E2ZkhB?=
 =?utf-8?B?TytCTmltOHgweVpCS2ZqdC96YU9HbUcrM1o3MmlDbk1jK1NYZ0Q5ZW1waFpu?=
 =?utf-8?B?U2RvTUw2WG5iaTlhWW1BV2JtM1Ryb0xIZGpWTldVVllYaXFlVnNCNmxPZTdE?=
 =?utf-8?B?RlhZemltcytySXZ3SFRILzd2VDZxOXlzR2xqTURpaTBSVVNtTTJ1amNsSkdj?=
 =?utf-8?B?WU1jS29qVWJmdWNCTHAxK3NJMUcxMFFFY0VzNmhMWjdCT3NGd25rVDU5RTBs?=
 =?utf-8?B?UzJwVGg4QWQ2RlNrZUNXYWNPR1FSQXA1TXRhbTJwR3pzWUMxZTdQSVlMdGxw?=
 =?utf-8?B?SFFYbUNlWFlSWGVyNDdET0lzR1FJWmFHbkxDN2I0SG9RYWYxbWlZRnRSd2xU?=
 =?utf-8?B?SXBRSkNZZVI0UDdDdUVwaHhRYm5GTXRaeW9SWU9Ib0NMK1dadUJyamwwMWFh?=
 =?utf-8?B?ZVhsMFo1cEdXRmtCRU9LVUdyVmNVWDlpR0lsTGJ1ak9ISEZpQW5OSjNIZUI3?=
 =?utf-8?B?OXZJaXFUYkRBYnJBdlFTU1ZCcWRxM2NxZE5hZzJDelRvb2hOWVFlL1lxZ1pI?=
 =?utf-8?B?ZHlESE56TUNzcVBKMGd1SFFKdEg4b1JVanhaVW5jamhUMUhtdFB2MkYxVDZ3?=
 =?utf-8?Q?uZf/j3j7syY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmJoMlowVkFkTmRWT21DUGFxTjJkNlArajN4T0RVVG1xRFp6cnFaWURDSkRT?=
 =?utf-8?B?WWFqMVJrL0NhbWVTZjAvbS9EUDFrcm9tNGZkL2t3VXFyQis2TEdLRzZleC9s?=
 =?utf-8?B?SlAxMTVLUjZVYmtxK2lrYlBYNzdVa3JIS2lFOUlQbU54RjlKclFMRDMxdXlx?=
 =?utf-8?B?ZGRyckVjYTRoSGdibzFqTkFCcDlSeGV6bTlVa3F1VXZsYzV1UnNwZ2F4V0pQ?=
 =?utf-8?B?QWwyQVVsZmF1THlQVUcxY0kvMVVxOFUyYWg5UXZUTE43QkpXNGFuNVl3dmUw?=
 =?utf-8?B?aGpnL2xKb0xTWUJla0o2V1JzYURvV2wwVWowdkhjdzQ2UlVBaTI0R1h2dFgz?=
 =?utf-8?B?dWI3SUpUdWlnZ3NUaGkxc29rNnl5N3lOS2ppQjQwbGpzdkJVcHBOUzlhZWxu?=
 =?utf-8?B?R244NWNEb0tRaTVQYWNXMjFmRlN6NUF1Z3hwNTFGSHdJc1ZtMHB4bVNKNHV5?=
 =?utf-8?B?eHhMSnZQVmxhd2dZZnBJSHo4RmtBanlDSER1L2tLdmR0bUdUaFRHUjcxNFhD?=
 =?utf-8?B?MmVwdHpwOUpoMGE5aTFha09mUDBHWHc1dWZ0QWVuWlhvdFJkOWp6RVRwek15?=
 =?utf-8?B?M3NMUG1KMlpJSklzLzl4NzVvOWgxQmtZMVJORCtkRGFrZEJFRTh0UmVHTGVu?=
 =?utf-8?B?T3Q4TkpPQnA4aTVXQnc4YXMyME94ajFyVXBsRGFFOFlWdm1JQnhZSjl6ZjhT?=
 =?utf-8?B?NEZNSlBXcXhqM3Npc1g4T3JIajRhbkd0NVpFODFKRXRHRGlHTzZPOFFjN0hp?=
 =?utf-8?B?NmZOWjdsV04rbzk0a1Izay9DYWVpQ0R5SzJjY0FjVzA5Q2hmWWlUY3hyQkxM?=
 =?utf-8?B?dVo3ZSs3dklVWGlQcTZ6VzBkWTJZT0FpVTJ5d3JhK2t3UU16UkpYRmhVUHE1?=
 =?utf-8?B?bGMvVjUwRWJ3bDFiR3FZNi9NVjlDOWdTSDg1WTFoMWJ3blkwaW9XMGpaY2F4?=
 =?utf-8?B?SHBrV253MXFUTzN1NEVDbTBZRjI2ekx3TE0yNTFRUEludmF6YlpwNEx5eXo5?=
 =?utf-8?B?dE9OZE9LZUNCM2RReU5QL2dhYXJVamRrWG1Rc2R3SzZsaXNKNU1zNlNFSXY0?=
 =?utf-8?B?RW5aN0F2cktJVVc0Z0IyYlpvanRSRDIraW95ZGVDWk5FWUlhWmg3aUJJREVs?=
 =?utf-8?B?ZzgyaGZEQmJabFJZYk9HRGNsYVlGdkxxWEhvVHlMZTZQTUxrOUpzZk9vMHk2?=
 =?utf-8?B?UFZwNDJyYVpwM1RSN2xzc1BPWkJ6VUVWc21QOU55VU5mVDU4Y0J5MDlLbmhV?=
 =?utf-8?B?cGdMNkwwMVQxR2xPSnowT3laZmlqeEFVbGQ3VTBxdU5LdTBLTXNYSnVFYmdj?=
 =?utf-8?B?MmkwMUFjdFJxd3lpQkgvSTdEakp5UE5FRzl6dGQzRWFTYWloc2Mwa3ptUDRv?=
 =?utf-8?B?bXh1cnpYaG9mS0F3eHZsSUt3QkNVR2dBL2xMRitPdGJpNVVMSVdjWnFheXM5?=
 =?utf-8?B?STNzb3Y2ZURWa2FhVkxXRXdZbWloWGU2RTFyTG1VUUZZenErRHVjcllUQ08v?=
 =?utf-8?B?NnhpOHorNVVGMHB4V1R5ck95UDZJSE5ESlJPQ253RWZqUXRadWVzSHJxRWRw?=
 =?utf-8?B?K3NmMXM5V1FGMzl1aFMxV2h1azRnbGljYjFSM2QwSnVHUGVwQ1BkamJEdzJw?=
 =?utf-8?B?T2ZkL2dyRGpUaURZOUdCU3dDeHRwSFpqbE9QeVhqekVXTkJNTVlwUlpMR0hx?=
 =?utf-8?B?cnFhUEpLemlrazRRYU1ySmt0R3J5YWJaOUgrTmc5OWxKOG5lbDZ6aW0raEZK?=
 =?utf-8?B?WEFZUjhvQjJSMXVVWXR6QnVRUy9hTEt0TDd6RjlMU2hiU1pXZnhjeUpXbzJH?=
 =?utf-8?B?aVRQRFZJaHNOWGpkMjlVTHkyMzVHK3dhb0Vza3cvWHZ6eVNPWjZNVEgxZHJC?=
 =?utf-8?B?WjQ5MFlNeVhaTm91L0JmSk5WQnFqampGVmhQMG5CMDV3YlRGMVhSVEIvRzVD?=
 =?utf-8?B?eHVKQzlFOTFGRUtudEFMemN0ODJZdWY5Q3E3K2xCOVlSYzlLTi9VUGoycFg5?=
 =?utf-8?B?aW1VU3VKSTJTL0w5ZTFaS3M2SmZDdXJOU2hDZ2xuMEdhTXNheEJEdGs5UzFB?=
 =?utf-8?B?NVR4blBncDFjKzRvSzk5ZVBxbmpqcE1pUER2MndPdjh0cVVnMDFqNis5MEs5?=
 =?utf-8?Q?lQRiGH/W2+GIkvT0E///j3Ao7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b3c758-00f5-42f9-166a-08ddad9a8ae0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 12:29:02.4815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLo9JXXoLJbPIVYEMZBR9VtaCCFcUOoDMZeh5asaOdeeKURc4k1LF+Lu8+OxG1MP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
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

On 6/17/25 05:07, Alex Deucher wrote:
> Move guilty logic into the ring reset callbacks.  This
> allows each ring reset callback to better handle fence
> errors and force completions in line with the reset
> behavior for each IP.  It also allows us to remove
> the ring guilty callback since that logic now lives
> in the reset callback.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 23 ++----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 -
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 30 +-----------------------
>  3 files changed, 3 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 177f04491a11b..3b7d3844a74bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -91,7 +91,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	struct amdgpu_job *job = to_amdgpu_job(s_job);
>  	struct amdgpu_task_info *ti;
>  	struct amdgpu_device *adev = ring->adev;
> -	bool set_error = false;
>  	int idx, r;
>  
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> @@ -134,8 +133,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
>  		dev_err(adev->dev, "Ring reset disabled by debug mask\n");
>  	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
> -		bool is_guilty;
> -
>  		dev_err(adev->dev, "Starting %s ring reset\n",
>  			s_job->sched->name);
>  
> @@ -145,24 +142,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  		 */
>  		drm_sched_wqueue_stop(&ring->sched);
>  
> -		/* for engine resets, we need to reset the engine,
> -		 * but individual queues may be unaffected.
> -		 * check here to make sure the accounting is correct.
> -		 */
> -		if (ring->funcs->is_guilty)
> -			is_guilty = ring->funcs->is_guilty(ring);
> -		else
> -			is_guilty = true;
> -
> -		if (is_guilty) {
> -			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> -			set_error = true;
> -		}
> -
>  		r = amdgpu_ring_reset(ring, job->vmid, NULL);
>  		if (!r) {
> -			if (is_guilty)
> -				atomic_inc(&ring->adev->gpu_reset_counter);
> +			atomic_inc(&ring->adev->gpu_reset_counter);
>  			drm_sched_wqueue_start(&ring->sched);
>  			dev_err(adev->dev, "Ring %s reset succeeded\n",
>  				ring->sched.name);
> @@ -173,8 +155,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
>  	}
>  
> -	if (!set_error)
> -		dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> +	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>  
>  	if (amdgpu_device_should_recover_gpu(ring->adev)) {
>  		struct amdgpu_reset_context reset_context;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index fc36b86c6dcf8..6aaa9d0c1f25c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -271,7 +271,6 @@ struct amdgpu_ring_funcs {
>  	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid,
>  		     struct amdgpu_fence *guilty_fence);
>  	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
> -	bool (*is_guilty)(struct amdgpu_ring *ring);
>  };
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index d3cb4dbae790b..61274579b3452 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1655,30 +1655,10 @@ static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t i
>  	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
>  }
>  
> -static bool sdma_v4_4_2_ring_is_guilty(struct amdgpu_ring *ring)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -	uint32_t instance_id = ring->me;
> -
> -	return sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
> -}
> -
> -static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -	uint32_t instance_id = ring->me;
> -
> -	if (!adev->sdma.has_page_queue)
> -		return false;
> -
> -	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
> -}
> -
>  static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
>  				   unsigned int vmid,
>  				   struct amdgpu_fence *guilty_fence)
>  {
> -	bool is_guilty = ring->funcs->is_guilty(ring);
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 id = ring->me;
>  	int r;
> @@ -1689,13 +1669,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
>  	amdgpu_amdkfd_suspend(adev, true);
>  	r = amdgpu_sdma_reset_engine(adev, id);
>  	amdgpu_amdkfd_resume(adev, true);
> -	if (r)
> -		return r;
> -
> -	if (is_guilty)
> -		amdgpu_fence_driver_force_completion(ring);
> -
> -	return 0;
> +	return r;
>  }
>  
>  static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
> @@ -2180,7 +2154,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>  	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>  	.reset = sdma_v4_4_2_reset_queue,
> -	.is_guilty = sdma_v4_4_2_ring_is_guilty,
>  };
>  
>  static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
> @@ -2213,7 +2186,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
>  	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>  	.reset = sdma_v4_4_2_reset_queue,
> -	.is_guilty = sdma_v4_4_2_page_ring_is_guilty,
>  };
>  
>  static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)

