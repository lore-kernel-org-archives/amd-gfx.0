Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B065CF31AD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 09:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E84C10E6DD;
	Wed,  2 Oct 2024 09:32:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U5EUAZhT";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54AE10E6DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 09:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kf4cNQ190eeTenG/0Gi409C5h+fkQq0TUh4tyAjOlbPrUaqmnofzC8KFBvL/aggm31FEB0xSeKfR1Ea0+zTIjkMYaX07cE3CF7wCU+uNxQ9UsT2hzWu/TSCm1jy1ayOcLKldHlfGggCXrbMtXbUSSSNUOXltnyQ2JeE7cDxhUBAzazqlOmrWF7knvebTVbpdNNNxMpEg01uh1Q0RPMvNqSezpeVLqQ0gMivW1c6HxHzOdgsB2yiWJHdB1GV3wfL2eaKw6BYRD45k6kewt4WHfd9ka9S8c+Lol3xtbdS4Tc9XeRgF2cnTbL7FyIZpqWvxKe2zdS4Mw02an4UCT/1KmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHF0WMxPo85sQR5Nx0Ue1xlUglPBmMzzdPQ8VdXwOQA=;
 b=uL/zC7q52TzD/Bl8C8YW7kzfyisuKVm9j9BauGTK2QAXHGiJp1feN18KUTuTUrnsSXYbJHRrne7Ytp46feT+UGAUsweVrp2ffPCOlsWRjqllaJq1Qqk1ydYJ84L6fmlb/aVWnEmemQ/UqibRMQkDBepDUCYJR0X8/PdNglkRaQMS/3KQZYy1A9qWn3cxrXhYCTLM+TqO4Nujf9HJz1oiKUzZ7CcAAVBcm+q1rQhxOf3qc9uiCIGfjExWWHgEnd+YSwTGFFXcGfG8NIBGdGsYRX3sBbpQ4W/CoAAd+fhID2rBMQpASLo6vVtBDeKDXXSPzwBRc5U6FMhFPDdI3nxn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHF0WMxPo85sQR5Nx0Ue1xlUglPBmMzzdPQ8VdXwOQA=;
 b=U5EUAZhTZXqOIWmW3RhdXsggkdFi+pTKdAPoHD0sTyhBLUYTuXUSZMXUiVNVQUdiuqEWX7dZdmmqUxukI1FBcD8OVFql4RlDflcDNak5iU9yMFJq5LHSPVTTILWoOHRm6uoHnb4pD6DkjaCDUhe5lYKVo+2r9Zem3H27ZYkgosc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 09:32:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 09:32:26 +0000
Message-ID: <4e5bfd0f-0ea3-4e15-80ff-593503e62f70@amd.com>
Date: Wed, 2 Oct 2024 11:32:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix html doc generation warning
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241002092618.116982-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241002092618.116982-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0309.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0b35b2-462e-41e9-1017-08dce2c5204b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eG9EOFh0ZEVhL2d4S0FVemYzSHhYVWx0ZDk5SEpEdXdlbWpGUkdsTlIxYWpt?=
 =?utf-8?B?TjZKamxqTkRUdURBMHFxL1EyN2VkT013bEk2S0Q3Yi9QQldKQTF6dENkWElh?=
 =?utf-8?B?dXVZd3o2T0VtR1dHLzcyVGwzakJPWUE2VkxURkQ4NjZFR244cTMwMW1yc3U5?=
 =?utf-8?B?d3pBZGZBVWwzVVhTL1poK3kxSzRDUDdEZkdJMitrVmNRL1RwQ2M2ZFY5aWFJ?=
 =?utf-8?B?QU9nWEtMNngwc0NEL0c1Z2JpWXRRYlJ0SmgyemNwUEIwZ2Y4V05KMFAvWHRs?=
 =?utf-8?B?Ym5xcktSRE1XUktzOWFxSGJVY3E5bzk0NG9LNjhGUUdjYmZVQURXcG5lNUdn?=
 =?utf-8?B?TXJnV0pwUHF5dnNVZHhRWlRRYjRQRFVaZkdoeGZXT1VsY05yc3pUWWRVbitF?=
 =?utf-8?B?TDduVkYvT0d5ZHpCK3RIVHgxSkJJMlpqM2xjMDVVZDBCQUpDbGxGY0FSVjd2?=
 =?utf-8?B?UU5YYXYrSmxWWXpUbVhRSy9CNnEzSjNObzc2L1BtemFHOTFUUVR2ZjJSK3Nm?=
 =?utf-8?B?M0RodG1PNkljZVBrcGlFOSthUzhiOFZGQnViK3p1UjVYZFU0TFp1aTJkQXlH?=
 =?utf-8?B?dEUvblg5TWxyYUZZaVB1LzlYL3ZRczJ6VXpSbHk0UTEzYnN4TjhKRTNxbnBU?=
 =?utf-8?B?alVpUGVIZkhreUlBRDhCSDFuQnFYTjlrTGpERDh2Y2FSOE9ycDVVS2d3MU96?=
 =?utf-8?B?VXExelhXRGVtbFdWY0o3UGlPd0pPR2JKbGU2SGh0MExMdW5aV2ViSFFlWXZn?=
 =?utf-8?B?THFrRGYxYWtZZFFvOVZQZ3hFSVNIMGdSbitoaFhHV1VZbEpCUHRTdmI2MzR3?=
 =?utf-8?B?S2VlVVZvcVNWaWtBR3o4a0prS0hiL29lUHJCeTJGK3Z3U2tKMmk2WlByQW9F?=
 =?utf-8?B?M0dqeWZPL2ptdWxOY0I5K1EzamJtR3M3RkxjclVzNFlwMnJ6ZUZTc2g1REYx?=
 =?utf-8?B?MkZBb2xCWDJpUExSVVhFSlBzS1dTSktkSzVMZlRaOFd0RVdMZ1d5aXIzU2dO?=
 =?utf-8?B?R1ZqOXFoUlRkaFFpei9VQlp0SUdZYWdoU3VYYTAyNy9Ycld5YURHNEtZYXJi?=
 =?utf-8?B?ZkkxUVlETklGaXk3UUNuaGtxL3FOYmZNR24xaXdCdkJBNWxCQTdObmFNajM4?=
 =?utf-8?B?Q3BMODRrRDlFdTNHdWIzemwyM2tyTzc5eHdteUVGZjRXTGxuSEZoSkdHZUVo?=
 =?utf-8?B?cnNkVmtkeWU0V1ZSTk9jRGxmcnlCcHl5bVdEb2EzT21OK1dXcGdxaUdIQkt1?=
 =?utf-8?B?bGhpWnIveWFZUjVzb1pxNGs4ZlZadXgyOE1kTFZvb05peEFLL205bXh4VjM1?=
 =?utf-8?B?VWRhVTViQkJ0MXNoLzVoVkg4M2JnMHZ5Mm9STnR4dkxudXFEMHFkUmFlUWJi?=
 =?utf-8?B?cEF1NzVtM29ZT1lwZ3RPWEtEMWJmbWlySDBPTG9sU2RtTzhCTkUrcnp2clQz?=
 =?utf-8?B?NWd1Y3NEYy94cDB2MFNTZEtlSkg1RmUwN0xJODBTa1AzL3FpMW03RndFdElT?=
 =?utf-8?B?Vk83QUdTR043dHJLMHVJNUhBRHFldjVlakxBYWdyQ01FckdHNU9ETCtoNXBU?=
 =?utf-8?B?TFhpb0ZQVGlRaVZjdUhTb2t2dDhqT0RXbTlSTWR1bVBrTzhUVVQ0ZytObmZI?=
 =?utf-8?B?a2pGenY1bGlUaVNRTTlUQlVRVGZ6K3FpWUd2Zjg5Y3piVjVuMk9aZlA0cU5n?=
 =?utf-8?B?NVdxWnZNek93SWpEVVZtMHpTbHp2dXgrTzFNaG1taDJjY2NIZVlVQlRiVU1i?=
 =?utf-8?B?UW10ekI0c2Yrd0pwMGFEd0l0VVBlU2RRc1NuSjhpS0dOcUNoOEFvTUo1OU9V?=
 =?utf-8?B?NmlhSFB2Mlh6MSs4VTVpZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUprV2ZmVnZrYUlDWng3R3dINithYjh2YWsxN3pHVWpPQ0Rmck9Nb0ZadGdw?=
 =?utf-8?B?TTNBRjgzQzFtYjZGUU5aTGt6VnpxNGVRNWxWZ2JwakdXKytGQzNZWi9jRGwx?=
 =?utf-8?B?RHhLenRjLzJTTTRJeVhJellLWmdDS05GeU01TWxzMzNCQzVoMkVXdlpuZC9P?=
 =?utf-8?B?YnFXRTh5SnA0UWgyOWd2dXllSytLNUxzZ2lPZ2h6eTZvOGt6UTUvc2YrZjFC?=
 =?utf-8?B?MlYxK01RTFU3UXJzem1iQ3FlNzlPdCszcFZJSnlFc3I0Uy9uYjROQmlZYmV6?=
 =?utf-8?B?bWIyRjFtUlRCdWppRUZYVkVkZGI2TXNONTRPbGJuZC84eVR2NUtINGR6QjZY?=
 =?utf-8?B?VWVZWXEzNFgzd2tOa3d3cm1tNkkrNWFSUkFLcFZvT2J2TjMzTWRHUDJ6MVQ5?=
 =?utf-8?B?aWJGNUlNQUJRR0dCRzRHWktLSFNtZnlyc2dYSjZnMTRPTWRGQWRQZ1hEOXNs?=
 =?utf-8?B?OVVIeldLQndRL1NqQmRlbjJwWW80bnRmdDliM0cyWlZyRFJSU2dqTlRrNE9h?=
 =?utf-8?B?dTA3Rlh6MlVUODFLenVHVXVOQ1d0d3dreGJiSE50T21ibUVzNDNheXlFVmtR?=
 =?utf-8?B?RXNZYVFpdzZCR2Q2eVVueEV0KytsMTNIQldWSUh6OUpZcTdUVk8xZzVTTGg4?=
 =?utf-8?B?R1BpdG9NNWJjQWhTYVJkcDgvR2Z5YlZ1QTF1MFF5N3Izc2ZDZVR3OXVZWGw0?=
 =?utf-8?B?UXRldmM0eDZzb1lMUUJnaVVsNmZGcDY5Y2JXdU4yZ09vU3h0MkxVOVBlSnV0?=
 =?utf-8?B?UWR5eEdJN2hpNzFrS0ZXT05FdFFJTFpVcmNlRFRXcWpLc09zMXlUazFONEY1?=
 =?utf-8?B?V0NENHR0cmZHUzJucFRic2lwK2lQRytjRDBmSEl6ZnVYZUx5Wi9EVXRqc3Yz?=
 =?utf-8?B?Q2FQRFUzUWRtd2dxL0FZVTlkWFZqcGdYMDQ3MUlobE52a0R3QW5vemJOTEU0?=
 =?utf-8?B?WnJXZ3ptTkhFclNNcnZuNkFtSlFlclY5Qkk5KzhzeW11NXVYRlVVWmliMDdl?=
 =?utf-8?B?YWV3ZzhMeDNTM3BMT3hwbGhGbmZYTkpGRjNxUWp3SzZaWnAxWHI4YXRIWEdn?=
 =?utf-8?B?a2pnZ3FWTmlmYmZNOUV5VXZNN3JlS0tjUnVkUHNXa0JzMXZMa1FxY1dJTTQ2?=
 =?utf-8?B?QXRMYXpWVDhrakpIQkI0Yks0QW81YXRaa3ZaUmlIS0JIQnF2VlloaWFPK2U3?=
 =?utf-8?B?Wnc4U2JzYWNBcEdGdXFqZnFWVnp1L2pnZ081aG1KNE5qaTVPTzhzQnN6NDVl?=
 =?utf-8?B?NVNmenp3SzVwS2RhZnRSMlMxbXRtUjkwS3pGREN0UUtCZ01OWU45NzFxMGdO?=
 =?utf-8?B?ZTlXQnlDMWsxYzFOR3RCTHFZeGh2ZXArS2k3NHJvTDc1VWQ0Y05IMGEzcFli?=
 =?utf-8?B?OXVaZFBXMWNRRU1PR2M5N2g3TTQrR0FaV2o5bld2LzEwUC9tL3BKWmgxV2Z6?=
 =?utf-8?B?cS8rYVB1V3o4SHEzTmt5QUVWYm5BcHdzNjJBMWlLWXlYamIycGhXRzVTaVlP?=
 =?utf-8?B?U09FSnZaeGhtQ1pTOCtVRUxmaE4rZHpPQzJiUS91SVgzU1dpdGZaV0lycnFs?=
 =?utf-8?B?MU45TnR4NkREdERuYjNqYWJWMnZjMUNrYmswWXlDdGx4OTh1anZxNW1ybjE0?=
 =?utf-8?B?MUFhUHFqTCtEczhyd29JajNvMXU0TEhFZ2RhSmlUUGUxaWcrVnQzKzEyOHlY?=
 =?utf-8?B?YmVzS2FvQkJSOWMvaWdnaCtPeWFtZTBRWEo5ajMzUk1NTC9keDJMZy84R1ht?=
 =?utf-8?B?bFpRZERsdit6elZsMUd1SUVFcG9uSjNFSlg4MEhaMW52SUQwVnQvZ0k4cy9u?=
 =?utf-8?B?NFp5YStTQThNaDZoRGFScnR3SGFxV2VnSjZWRnNhUWhGK1dPSXhZQTVSTEZh?=
 =?utf-8?B?MDlSTmV5aEZjaTh1bW9tbUVaU0VTMThFZlIxSzE0SDdGNndiOTFYT2U0cEJG?=
 =?utf-8?B?N1Z3dEhIWHNKOVRzNkFDR1ROS21ySDdCR1ROVFBQTTdwOGxsczh0QlkvdE04?=
 =?utf-8?B?V3JqSUJlaDVSa2haKzVyb3QwWkk1UFkyTUpocE5aRWNHVGRSZGliYWhDcW9u?=
 =?utf-8?B?bHFNSnhndTBBZFVNQnJaSkhvbngxQXJQOWc5OEluRzFlL2hJSGN3RlhNdHhu?=
 =?utf-8?Q?rDmPsiPlDhOcJnwpVNJHZEWex?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0b35b2-462e-41e9-1017-08dce2c5204b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 09:32:26.0581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfC0H6A5vKQ2KTRsSNR+qZueEJ16LKjPK+7MJDahzpTSJ2gPYqFEU+GA2A/nGqzQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751
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

Am 02.10.24 um 11:26 schrieb Sunil Khatri:
> Fix the html doc warning due to mix up of the
> forward declaration of struct amdgpu_ip_block.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/include/amd_shared.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index d892273fdb10..f98b3a544477 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -28,6 +28,8 @@
>   
>   
>   #define AMD_MAX_USEC_TIMEOUT		1000000  /* 1000 ms */
> +struct amdgpu_ip_block;
> +

Not a most have but probably best to add an empty line between the 
#define and the forward declaration.

Reviewed-by: Christian König <christian.koenig@amd.com> either way.

>   
>   /*
>    * Chip flags
> @@ -375,8 +377,6 @@ enum amd_dpm_forced_level;
>    * making calls to hooks from each IP block. This list is ordered to ensure
>    * that the driver initializes the IP blocks in a safe sequence.
>    */
> -struct amdgpu_ip_block;
> -
>   struct amd_ip_funcs {
>   	char *name;
>   	int (*early_init)(struct amdgpu_ip_block *ip_block);

