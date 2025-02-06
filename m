Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E8BC02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 14:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0898210E2FD;
	Thu,  6 Feb 2025 14:50:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MYLJpwre";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9330F10E03C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 14:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TW5iPl8Her5bLJD0op1Ckkov2jKGoVeK4Fg5phPX+2rb3gDfmEw8K+0GaiNHB+JUDAZ0HSr3Nkjqw7VXzIcWZdl6sr3e+1ht4aM9C/TKbZCF1uTsVosUK78nbk8OXIrculqMfsjSWwGqNyCdmyp+pD/BRQqx5U9QWA6uaRbCY4jsNdVD95Fn9ZTHCz591AY4A7vto+JHV08QLxFc0ULEAryFm8T2/4bv7E+UjnjZp3uAPJV5f4gBYzwLx5/IsyMoCpnwYtXL1yLqEeMUhU3em+n+8VTMLbDqm3FI3jcao9T6BrWvFhhrdCUXZvHhn2/LjGRLl2rgjnHePcqvrRlo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rA8vIQ9jKxStofj10Lyr6/Cn2qBcKh3n8MSKQWB5Lv8=;
 b=Sl37s1wOiclW9IjC+KC0BusuKPyYqMimhBP4t4+WARPiAzV6PkiT6w9tsVgP1Psxv6dFxAXSNvdDIcNN9A7dd5htWfxpAIw439QkELgxEcXX5zqPCa/g6eekhyt8d6CllAw51J3lzdtLkgeH24Jx70Afl5qKx7BV7pEc82asf6+A7BqCBSMIzTPJZ5QauyPRmBORXQHeK8x6Q6z2gt1YhGP6LdWyEl/NKCRtdVHYFNoyLrroBVMz+Is0IjmGSvY/BksO88iT+XlkaZVh5J6/3wfa3mxekLYuq3LKmsx4R2+x8OVsOUuAn5V9jefjWVAHbeLad9iBDOBcYVaXv7WyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA8vIQ9jKxStofj10Lyr6/Cn2qBcKh3n8MSKQWB5Lv8=;
 b=MYLJpwre6uWMHdAkNy5ZnLm9HtrXKYbUliPdHjeXNgJ4WlgKwnh4DdwTq7S+CDQY35hxwrReSP9HvngB22YuTfsm5szb2NjTbwo6ZbFWakqm+tCSp0yl3yCQYp7B2UXzGu7VNNI4PhgMCiPJxlZcwL1aSRMO4yvalDHk7p9dV7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 14:48:44 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 14:48:44 +0000
Content-Type: multipart/alternative;
 boundary="------------Shgq2OvJC35jnI9XrBitq28z"
Message-ID: <6b4566b3-0a41-472f-98a5-035b1f866649@amd.com>
Date: Thu, 6 Feb 2025 09:48:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 43/44] drm/amdgpu/vcn: optimize firmware storage
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-44-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-44-alexander.deucher@amd.com>
X-ClientProxiedBy: YQZPR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::18) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b1c4ec-8d78-4877-34b0-08dd46bd5b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGwrdEszVDhrdVdOZ25xLy92YXZhMlJPNG9QVzhrQlhqdHQyQXdyOFM1VXM3?=
 =?utf-8?B?QUxWRml2YXNOWTlpZG45dnV1Q2NTU3VDSk1GOVFlbGQrZ2JSNWV0Vy9iRXFs?=
 =?utf-8?B?N201TC9PUk80TmE1WW1Pang4NEhsM0NEQ1AzK0JiT3pmYm16a0lwdkVoZ3NP?=
 =?utf-8?B?b2x2eEwzYW96OTh5SllySnVxR0JWRmRrSkJrbXdIZmh4UXVGeDNYYW1EbklL?=
 =?utf-8?B?Q3pUTm8wUEFld0o2Q1JXbWVsMzRXS0NpYXM3VERiTjk0RlpJWVlhOXRpbW9C?=
 =?utf-8?B?UzBXSStjZGJnU0dVdkt6RTJFK3ZWZS94cEJETDdybkgrdkNNSzUxZlYzREtR?=
 =?utf-8?B?RTNiNlVJTk9xclhzb2s2MEdYOTJybk80UXBDOWtLYmFsbFJleFJ6eU1kUkhj?=
 =?utf-8?B?aWFRQll1NjlVKzlURFlLRTRJbzZDOUgzdkRSOFcyOTBEQ21Db0JJNXVQbkRq?=
 =?utf-8?B?Yzd2UVd2WTdxN2Q2VWlKV3dqb1VmamJXOWllSUd6QVBYdEFlbzB3KzNUbXAr?=
 =?utf-8?B?dDBiUnZ6NjRxUWJQc2xVRTJzb09aWDhUTjJnSUI0QVBEbHhYNHZoVkJuNncy?=
 =?utf-8?B?Q1ZMeC9RUEc4bDRDczZDS2NwWlZvT0FBenkyRHZQcWtUQ1dtQUpYb1kwdmEx?=
 =?utf-8?B?ajhJKzlqVElrNnZUaVQzWDFOTXJTWlluOVpycjFTZWk5NHc3YkkrbkcwcmtC?=
 =?utf-8?B?L3NXaVB4UldVMSt2V0cxenIwTURMU2RFWjk5YmxuQ0QybVFxZmVoUUtLVTN1?=
 =?utf-8?B?M2drSW1IdFZ0REZzYjZUR1dNR2N5Ky9zZVBHb2xRYndsYlc3L3QzMGo2VE1j?=
 =?utf-8?B?cmdVdi9PTlUrZDIwRGkzZjJObmc0dk9PVGRHeS9pZWFtaWFiSGFpSitvTlZN?=
 =?utf-8?B?anJRd0oxT041SDc2clRFZGd5dzVlZmpJMTliUHduMlVlZDZZT04xdmxJNnZL?=
 =?utf-8?B?SjFEdElvMUVnOE5UemRaUEZOM2FraHhoZGxRVWhZMmwxNHZLVEhzZWV6U1Fn?=
 =?utf-8?B?cDFMb1NKVWk5eldKajJmZnJFbXJVVmFYUnVxb2hVcEEzK2ZrUU1FYXB4aklp?=
 =?utf-8?B?TVFCakpOOEJsN0NVK2FjelJQN3hnMHBkN0FWRzJqbWV2cGdVQjQwZVl0NUNS?=
 =?utf-8?B?bnpsbmk1eC9jOUVtZEFDeG9OMGhWM3ZjTkR3VmtBZVllM1lNbXpzb0ZvVlUv?=
 =?utf-8?B?a3dlZXhXbzlUOUNUNVVWNnl0Rk5paFEwaFNIdVphSzZCZUsveVBsbVMzYTJ4?=
 =?utf-8?B?WnlCOGhOZE5NR2htWjF0UTN3elpqRGM1WDJrcjhQVnM2dnRuOERpR0JkSUE1?=
 =?utf-8?B?VnFUc2hVZld6YTdrN0Yzb2s1cXlEdlFUbU1pcmpnQmF2Q2xmWkMwN2EwVzNW?=
 =?utf-8?B?WlZ3OTBObVIwdmtLamR1c0o1eUQ2Z2V1ZnNBUVhYZzI5SXJudEhVNzN6aXZU?=
 =?utf-8?B?SUp0cWxVZEJTWUhmT1RrZzZkdFJYNTN2Um15VXcrYzlJY1dITFhkU291WHRO?=
 =?utf-8?B?Y3lTS2U1ajExRWtDaTBaS21yOGNKM2g5UVdNR1pkSTNPN2YvVUNYcm1aYmxw?=
 =?utf-8?B?NGMyZFg4QjUwZmlqUjkxUVIrbHUrS3hTYnRZZGpmTHFkcDdVNksxaTBjRWhB?=
 =?utf-8?B?RzFGbXBaamlCSHB4UmdBV0JRaVJDeUoycmtKQTc2QjVGbHNUV0R3Q0ZUdUZM?=
 =?utf-8?B?cDNWcVNvdG1DVnVLc0dCaW5uTWlWZ2F6cVBsWFV4Z0pyZXdkZEhLVDhYU0Yy?=
 =?utf-8?B?Ykc4cFNzcWxGaEFKS0FrVkNLYm8zT2dKRGN5ZkhTNjRxSWl6WXQvY3R4UllW?=
 =?utf-8?B?QUlqWGdLNXJ0bG5oNThhSGNXT3hUbWt4TTh3NitHR0xxNEFXRzhKNG9DUXhO?=
 =?utf-8?Q?/VeKbKYyGUGSh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eSs1dlNZYms2MkJDMFk0T01hcG9wcU5sOTNwNHBCZzh2Y0tLTlU0TSt5a25J?=
 =?utf-8?B?Z2J5bVlkUVhWdlAvVHAvMFJ5cVNNNE1qQXVlMWVLaTAwYlVoa29uNjVQb2E0?=
 =?utf-8?B?aW5Dc0ovaGxpQWZsUE5FS2JjbnJlOEtTZzF5UFBiczFacGlOVFREa245UFk4?=
 =?utf-8?B?ZyszRTlENnBBYkFTWlMyaFB1d25pVTFaWDV3ajZ1WDFSbGlCZlhSTFJOVGJr?=
 =?utf-8?B?eU9VNU9wdGl0SzZ6Z2V0Y3ZFVWYwblVYOWpYMWwxNXVOazhiMGI2T1hHbGxC?=
 =?utf-8?B?SnRuSG5qVkY4TE1rNERjKzF5WEtBTnBkK1hyQnNoVEI4ZDZycWFRck9wMiti?=
 =?utf-8?B?cFluTXA2R09WaUtiQWRqclByMXhwcGRYQUxXTm95SnN5UG9uV1ZQdlgweVRJ?=
 =?utf-8?B?UUFiRkJ6VGtndGp6cE1rdVE1MGdRc21heE1RMkxJZWFRVUlIWnNEbkNteE9K?=
 =?utf-8?B?cFJaNXpUSE5aRUhmSDlDZXRjT1h0eFJpaFo0NVRsOG4wcjBwaHN1Z2RpNEt3?=
 =?utf-8?B?QzhsMGt3b1AzWURJNEpFV1lobXREOFAwV2FsSDZyUEdodlVHeTJZa1lqcyt3?=
 =?utf-8?B?OVhaekpHRHQwMEhaM3F1TUNDRW5nV2kxbFh1a0d5cGJWMkpvYVlvMWVGNTNH?=
 =?utf-8?B?a0lRWDUzSGJpSmRnMlFvWHAzbllVbWd3RDJjZ0JhSzJIMWtJVFhaZXNUdmtm?=
 =?utf-8?B?UkpzTkRHT2JtV2o2U2hYbnc3Z1F5K3QvU3Q0T0RnbWNjL1p3clpBalNxSUxn?=
 =?utf-8?B?dFVlL0ZTOWkyNnNsSE83bXNMQm5ucWs2cVZEdGNhekZ5V0NZeDY3N0VqSjhO?=
 =?utf-8?B?UlBTNUh3OVBFVm8wbVhRMHRsQU84cXdkcUd4eXlnRmxWbDV2ZzVXT0l6NHhM?=
 =?utf-8?B?M1pUWjJGTlo4Y0hLNEE0NnVqbTBBUHBZb1pJL1pONTFuY2p6RjZyVkE4Tzlk?=
 =?utf-8?B?UXRKQW1nZE5GeFA5ZmZaMENYalZSeU1pQy9sYTFVSjQ0MEtHY1RPVFdxWXR0?=
 =?utf-8?B?ZzNjM25pdFMvQkE1aTN0RXhTOTBOc1FUMUdGek85eVZNYTIvY2dSN1V2cFBz?=
 =?utf-8?B?eXNGUGd4OFdObHZnQW9xUEFCdFo3MG40b3k4bTJLMU4xWHVGUFNUOFRONi82?=
 =?utf-8?B?NHQ4cm45TUUzeTkyTHZiVTh0djZJajFQWFdYTWVMR2htRVRVbElCOFJCQUFt?=
 =?utf-8?B?WTlMVWJ4d1hYRnZHUW5ubTZkR3V4STJLTXJUQWY1U2VCckJoUEpMOUFMOXYz?=
 =?utf-8?B?N0hSSHlKYWNiUGVYUHNBbE1MakNwcEZYRVg0RnpoWFYrWGU3eVhTV1dCTHlm?=
 =?utf-8?B?aHlnSks4QW9QbmVWYWc0L20xdVFWbEdzMzRwYXU5RVJBNnpGOU56dDl1bmtq?=
 =?utf-8?B?VDZ0akRBRFhHVklsK0ZrMDRETGVCNldITmtHUzE3aWhKa2xDOGxVUVR0MVkw?=
 =?utf-8?B?TE5LU1dMdFVCYmd0Ni9wS2pNV0RtTU1iVVZEajNMUC95ODQ0dHh6ak4xWUhu?=
 =?utf-8?B?YVZFVVdBMWRSZkgxMkhpZzlKcUc4VDhhS1phOG9uSUpXeU84WG16SkRuZm1y?=
 =?utf-8?B?b2R0QXUzK1lwTlN6UlJoT2hUQm91MEE3OER4a2VtOW9LVFJlK1c3cmYzZjNs?=
 =?utf-8?B?RFRLVTNTalRCaVpwVEtQcFpkUnpLR0NXNGU3SllDVFFVdmxhNmgrZUduV0Vw?=
 =?utf-8?B?bzkwU2lMVGUzcjByNnBscU9QWERTSDgwWGhmOU1pbFFRNUpKMXN6RkVKMjNm?=
 =?utf-8?B?UzczZ2tQRGFsdFJqSXp3aWJpZXlTUFRxU0x2MzFwbzMwUElIMVZpWWtBMEpV?=
 =?utf-8?B?MnRoRlUyOU51L1YyOE9LUkFzUDNzTXM1dFZ3aE5GaHB5aFRnVkg3L1BtQit0?=
 =?utf-8?B?L2VYL3JKNlFCM0pmNWNlQ0RiUEpUUWtLVkxIVE5uS0JVaEMxakt3M1MrblNm?=
 =?utf-8?B?VHdYeExjY3FVc0pZQ1M2NFpMZExzRStoTi9CWGtKekRuNE93VkJTT2oxcFZ0?=
 =?utf-8?B?VkxUVjlURkxZT085cmNJVFRRUTA2MmswVTRiZUFPdGtnVXppQy9Fd054VmNJ?=
 =?utf-8?B?dmZlZEcwZS9reFRvVWlWeDg4MUJ3Y1hNZXhBM2FsMWZabC9BV0p2Mzd3ZGhm?=
 =?utf-8?Q?fBgMng16w7oHrcoOqymKz7t7v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b1c4ec-8d78-4877-34b0-08dd46bd5b00
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 14:48:44.8029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNpZTfD3iD3cdjGxra1ZALdPYGjpaCXmCAtB4JCi7M/LdB5XgNtUK3U0j4lMD5fmuJe72DcMikJkmL/FO4TXJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306
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

--------------Shgq2OvJC35jnI9XrBitq28z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> If each instance uses the same fw image, only store one
> copy in the driver.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Acked-by: Boyuan Zhang <Boyuan.Zhang@amd.com> <mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 30 +++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  3 +++
>   3 files changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index e4ef0fb970b29..edbcb11c382a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -102,18 +102,25 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev, int i)
>   	adev->vcn.inst[i].inst = i;
>   	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
>   
> -	if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
> +	if (i != 0 && adev->vcn.per_inst_fw) {
>   		r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
>   					 AMDGPU_UCODE_REQUIRED,
>   					 "amdgpu/%s_%d.bin", ucode_prefix, i);
> -	else
> -		r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
> -					 AMDGPU_UCODE_REQUIRED,
> -					 "amdgpu/%s.bin", ucode_prefix);
> -	if (r) {
> -		amdgpu_ucode_release(&adev->vcn.inst[i].fw);
> -		return r;
> +		if (r)
> +			amdgpu_ucode_release(&adev->vcn.inst[i].fw);
> +	} else {
> +		if (!adev->vcn.inst[0].fw) {
> +			r = amdgpu_ucode_request(adev, &adev->vcn.inst[0].fw,
> +						 AMDGPU_UCODE_REQUIRED,
> +						 "amdgpu/%s.bin", ucode_prefix);
> +			if (r)
> +				amdgpu_ucode_release(&adev->vcn.inst[0].fw);
> +		} else {
> +			r = 0;
> +		}
> +		adev->vcn.inst[i].fw = adev->vcn.inst[0].fw;
>   	}
> +
>   	return r;
>   }
>   
> @@ -270,7 +277,12 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
>   	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>   		amdgpu_ring_fini(&adev->vcn.inst[i].ring_enc[j]);
>   
> -	amdgpu_ucode_release(&adev->vcn.inst[i].fw);
> +	if (adev->vcn.per_inst_fw) {
> +		amdgpu_ucode_release(&adev->vcn.inst[i].fw);
> +	} else {
> +		amdgpu_ucode_release(&adev->vcn.inst[0].fw);
> +		adev->vcn.inst[i].fw = NULL;
> +	}
>   	mutex_destroy(&adev->vcn.inst[i].vcn_pg_lock);
>   	mutex_destroy(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index a023f46ec904a..26c9c2d90f455 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -339,7 +339,6 @@ struct amdgpu_vcn_ras {
>   };
>   
>   struct amdgpu_vcn {
> -	unsigned		fw_version;
>   	uint8_t	num_vcn_inst;
>   	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
>   
> @@ -356,6 +355,9 @@ struct amdgpu_vcn {
>   
>   	uint32_t		supported_reset;
>   	uint32_t		caps;
> +
> +	bool			per_inst_fw;
> +	unsigned		fw_version;
>   };
>   
>   struct amdgpu_fw_shared_rb_ptrs_struct {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 0d6a97c4bf8f6..347a2c40c32d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -114,6 +114,9 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int i, r;
>   
> +	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(4, 0, 6))
> +		adev->vcn.per_inst_fw = true;
> +
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
>   		/* re-use enc ring as unified ring */
>   		adev->vcn.inst[i].num_enc_rings = 1;
--------------Shgq2OvJC35jnI9XrBitq28z
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-44-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">If each instance uses the same fw image, only store one
copy in the driver.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark5quw442ch" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Acked-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-44-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 30 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  3 +++
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index e4ef0fb970b29..edbcb11c382a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -102,18 +102,25 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev, int i)
 	adev-&gt;vcn.inst[i].inst = i;
 	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
-	if (i == 1 &amp;&amp; amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
+	if (i != 0 &amp;&amp; adev-&gt;vcn.per_inst_fw) {
 		r = amdgpu_ucode_request(adev, &amp;adev-&gt;vcn.inst[i].fw,
 					 AMDGPU_UCODE_REQUIRED,
 					 &quot;amdgpu/%s_%d.bin&quot;, ucode_prefix, i);
-	else
-		r = amdgpu_ucode_request(adev, &amp;adev-&gt;vcn.inst[i].fw,
-					 AMDGPU_UCODE_REQUIRED,
-					 &quot;amdgpu/%s.bin&quot;, ucode_prefix);
-	if (r) {
-		amdgpu_ucode_release(&amp;adev-&gt;vcn.inst[i].fw);
-		return r;
+		if (r)
+			amdgpu_ucode_release(&amp;adev-&gt;vcn.inst[i].fw);
+	} else {
+		if (!adev-&gt;vcn.inst[0].fw) {
+			r = amdgpu_ucode_request(adev, &amp;adev-&gt;vcn.inst[0].fw,
+						 AMDGPU_UCODE_REQUIRED,
+						 &quot;amdgpu/%s.bin&quot;, ucode_prefix);
+			if (r)
+				amdgpu_ucode_release(&amp;adev-&gt;vcn.inst[0].fw);
+		} else {
+			r = 0;
+		}
+		adev-&gt;vcn.inst[i].fw = adev-&gt;vcn.inst[0].fw;
 	}
+
 	return r;
 }
 
@@ -270,7 +277,12 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
 	for (j = 0; j &lt; adev-&gt;vcn.inst[i].num_enc_rings; ++j)
 		amdgpu_ring_fini(&amp;adev-&gt;vcn.inst[i].ring_enc[j]);
 
-	amdgpu_ucode_release(&amp;adev-&gt;vcn.inst[i].fw);
+	if (adev-&gt;vcn.per_inst_fw) {
+		amdgpu_ucode_release(&amp;adev-&gt;vcn.inst[i].fw);
+	} else {
+		amdgpu_ucode_release(&amp;adev-&gt;vcn.inst[0].fw);
+		adev-&gt;vcn.inst[i].fw = NULL;
+	}
 	mutex_destroy(&amp;adev-&gt;vcn.inst[i].vcn_pg_lock);
 	mutex_destroy(&amp;adev-&gt;vcn.inst[i].vcn1_jpeg1_workaround);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index a023f46ec904a..26c9c2d90f455 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -339,7 +339,6 @@ struct amdgpu_vcn_ras {
 };
 
 struct amdgpu_vcn {
-	unsigned		fw_version;
 	uint8_t	num_vcn_inst;
 	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
 
@@ -356,6 +355,9 @@ struct amdgpu_vcn {
 
 	uint32_t		supported_reset;
 	uint32_t		caps;
+
+	bool			per_inst_fw;
+	unsigned		fw_version;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 0d6a97c4bf8f6..347a2c40c32d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -114,6 +114,9 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int i, r;
 
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(4, 0, 6))
+		adev-&gt;vcn.per_inst_fw = true;
+
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
 		/* re-use enc ring as unified ring */
 		adev-&gt;vcn.inst[i].num_enc_rings = 1;
</pre>
    </blockquote>
  </body>
</html>

--------------Shgq2OvJC35jnI9XrBitq28z--
