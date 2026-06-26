Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A15DC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 18:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C769110F707;
	Fri, 26 Jun 2026 18:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dK/bRhmH";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011000.outbound.protection.outlook.com
 [40.93.194.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF11110F703
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 18:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJRGoHg/0VqqixXWNuDFLjOSKa+8w5hd7KlW+x6k2kHjpoz79NtrPLCuwkBpN2qks9TTaoVsdQ7zanOpNKGojUGNX83/AMcvotXtOdBgXbqG0w2R2PUYuQZ8PfHMGn7u8TxTf3eBqTXDDtMHxnFJaiwUWH5NkePsCd5vFKqKswdg1lrq16GD+ygvHsH5d/6Gbw+q9U2wg8YEAQUP0ACjYloaSEhdpZRHLSXfNpbHwCG7j3jPJcMbONKYzVRkEYpO/mkD8d/8btl3VSC7aaSB8V2QordN/EwQSEwmHp11z+aMMCS9d3jWN2vc20ODgVI792feVo2R6UIw2dineEYjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz8M0OCsoVC6snsipfmQUi0K1C4ozy43+rCcnLjtIK0=;
 b=oy9BTtGqBqOqOakoosSBaSjyGsvtXmS5JExB0bsIuG8PrMxJp7zExcnWfNpXYI/QS+kvBI5mQ1hXsrQIyJEQKT7erot/gDip3sBdH82XwmiPV6mn/545qXiImJlx5t30I4hAwuYsOQmVYZNvI2RsaOwzaVBlpSpZeytqaXFk+E/chsVo+63711wafrvfKbqlY+ntPq9+nI7D5nyDtmvyBwax/iAPYkJjIZObfzDSpeuEPR/E02qdrtlr2sZaMSW8jSRAuQqWtYZPdZB1ydv656j3LVCGxpvp32DqEN6Hc0zsbFIhdnztvQKgtFtXg+VjpxfsqzIRTBJGu5XexGjytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz8M0OCsoVC6snsipfmQUi0K1C4ozy43+rCcnLjtIK0=;
 b=dK/bRhmHrWPnXEVq6ttGhYvZBZodR0TJ964kkqMG4P132M8kequkFLIBCxDMx8INrChA9YyJ/kboSggLmsNM0kuRQMyxQZ5uimf32ia9DPFSYWpXePpA7SDcEbsAjaHGa8z4bIWqJJLaz2Hg/MY0RJ4UDN9pJ5GuAp4ggjdCWRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY3PR12MB9580.namprd12.prod.outlook.com (2603:10b6:930:10a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 26 Jun
 2026 18:54:34 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 18:54:33 +0000
Message-ID: <ace82f3a-d626-489e-a0a5-bf857b90fe9f@amd.com>
Date: Fri, 26 Jun 2026 13:54:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu: add support for GC IP version 11.7.1
Content-Language: en-US
To: Granthali Vinodkumar Dhandar <Granthali.VinodkumarDhandar@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Pratik.Vishwakarma@amd.com
References: <20260626094543.1195245-1-Granthali.VinodkumarDhandar@amd.com>
 <20260626094543.1195245-2-Granthali.VinodkumarDhandar@amd.com>
Cc: Kanala Ramalingeswara Reddy <kanala.ramalingeswarareddy@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260626094543.1195245-2-Granthali.VinodkumarDhandar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:610:52::39) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY3PR12MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: eee68a6f-36c2-49f3-77a2-08ded3b45cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: b0txZpgG+NVaavippcYc7jAL+i/KZ7ZI5RFMBubnBi4rlHsqCEWQN4HL/kIoXxolqquIikCIXYc/Ib4RbqfsULrR2r0VX3ApAk9Kv/2vsU8jW57DcTw/sletRellxF0L02UJ+KkdrH+PhYSFH1GCCR8fbNhd/hcVaX16W2TqLKzOoI3chNu0qgr2nWircZJaoFmB8WEldTPySzJ/mLS2O4PypIgNWfzoGO8p4boyb1NFzITqs1OIVwSK0fOmKfdobCQ3oOwhgK9OaVzToUrCQFePWOgWwp0faFscKcX2jH6G6PPJzWD4bKEuV2NVDg42SQw9QFfcvp8o95oX6oHPvR/zyYYJZgH5rvQxBW5mFpoLAEkpsbB3jPLcBWNkV+AOfEIRX8cZTnF+n+xPhxow0dJb07JOGWgRce799ureAzIXzHGzH8lliN8Jt3sytR16VkO8/TjXfA2cVwftOyIvnYRa+wd6Rksw8UmlRxp7xslF1BFoOPN1hprrcvdDGaiOzUHvAFuEES0oE7uKZlPL/f65MVFqyoWq8Dn/EPOvNPnSikNhl7+nUdtXMbyUELVRsCSFaPSu4bDIohD55Onk1EcCedJzfAYX/1sXuBK6ALyHEttLjOOi/Qg0R3thSBt0jTACBYA5Owi3lQsRIr2eU7CNWcsqgukJfFaEVqJ+lJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnNlYW5YbWk1TTl0ZlFUM3FVNFo5ZmdNMW55N2FaVW4ydW9HeHY4ZklaNkJl?=
 =?utf-8?B?cHNIaEhjMXpYSGJROFM3ZmZpc2RhZEp1MlJnVnpnbjJlTWl1NmxGcCsvTnFH?=
 =?utf-8?B?MlE5VEdVVHdoQ1hhbHBwSTJrNVl1cXZzQkZRcmhqNG44cm9rb0ZZc2s1Z0l3?=
 =?utf-8?B?VS9VSm9hUmtaRmpDTnhiWStoMjJ1RUowRHNyNW1QRVNPVXJuSWVxdDFmQXVB?=
 =?utf-8?B?Szd0ZDFoMUVPYU5CZ1ltdXh2dzhPQW41bG1XYkpUaFAzSXlJRXVRV21OSmgr?=
 =?utf-8?B?eVFiNDhveXNGTW1FVGo1TWt1elN0ZVpBWmJNbUNnM2ZRZGdrb2VWNVducXVh?=
 =?utf-8?B?VVdLY24rcnN5bkhkRWFEK3NmL0Q4QkhIelhodE9xSnlaNS84K052aHZDTDRL?=
 =?utf-8?B?ZGZRY3RIMExXOVlTTkhTZWQ0Z0xyOTg4MitnWXdXSXFja2dvNzY2eXhMTUFq?=
 =?utf-8?B?ekR0Z0Ezb0RKWmpHUlY4M3M2Sm5rY3k1RVZjbHQ2SzJ6ZGdmOXUyaHlXc0JN?=
 =?utf-8?B?L2oxVnVieWdpdVNaTlJPRzZER2R5WEFIWDZ6UHE1bGVoZWtlditJT1BhOFM5?=
 =?utf-8?B?enBLcGNvOThZTktlaDdnVGdQSDROT1o5OUNDOTMycitQVmNxZElPYWFreHJK?=
 =?utf-8?B?dVhtam5TeERkMHRBRFhPTWZ1azFGem9KSUNndmRjZ2ZQNlpCdzNXejcwSXN2?=
 =?utf-8?B?OFNHS3RKSW10ajBoY29OK0VONUdraEVIVXNXNUVERnA0dWlFcjBYdHJIdnpy?=
 =?utf-8?B?OUVGRnM5bTFlZU1TaGorS2ZjUDAxSFlDQ2crSjc5YWN6VlVLRHpKRE52dmky?=
 =?utf-8?B?L0pVOE5tZ3hucWVPVUJGbmdqWUdlR3J4UzEybTNuaXozRDZUZWdxRi83L1VW?=
 =?utf-8?B?aEYzWmZWeU5VVm53cFdYbjVLRnpvRTh0K1MveHBVbHZUL05LOTJtQ2FMd0ts?=
 =?utf-8?B?VVZWOVR5bndkZXhPWEJIUGJXcVJHYXNmb3M3NTBzWk1ON214MUtlM3hhMkdk?=
 =?utf-8?B?UkRZbkNBK1pLK0hMbTdobU91UVI3U0ZmcWV2SE1qY05XNHg3RktSWkNNVFVr?=
 =?utf-8?B?dGYvRVpjNk9zWndRcXAyWEpGQXJIQkRyWlc2ZytoNytzQUpRNXpXK1A2N0h0?=
 =?utf-8?B?TkVqUmJ2ZS81UlZSclFtQWpvQmhLUlpvbFcyUTZKUFZTS0k4TmNaS1Y2TFNB?=
 =?utf-8?B?R0ZqVGlsamk4ZmYzZXJSL3hwYWJKL3dTVUpYS2VncGZKNWREMnZDODI4V0E2?=
 =?utf-8?B?clRNRUpXRDNVNHdEOElBY3Zocm9JMkhXZXZOV0lOYkJsSVZ4aERTSlUwMVJ6?=
 =?utf-8?B?V0x2cWNNN0dwZFJ5aTJBV1EzRzhIa1g4bzdnTnlQWU9XUnY4Tm5UeDhHNlhY?=
 =?utf-8?B?S29ZclFZSTlYcTNZQkRxOXg4eGdTZ2NFYWRQL0xKRnBFdU9QMWZvVUZic25J?=
 =?utf-8?B?N3NMdjg4TkttVVMwMVJPNTVmODRBa1g0cTFlaGlVWUl3aExkVW51UUFoRDkv?=
 =?utf-8?B?d2F5MklBbVFRcDFmZUx0UmtOZmVpS0FtYy95RWpPc0pPNVd1bzY2NDFWSm5C?=
 =?utf-8?B?SWtVelJPK0piOWhVaG9NK3h1SENKZFRGRTdRRm1oaUJ0YWxnTHRGSkNDdzVT?=
 =?utf-8?B?VVlkc0p4c29oSnZMakx2RlFucWxMRTZhU0Q5dCtiblpoSC9PMi91Zmo4ZU5l?=
 =?utf-8?B?a1Jkb2dtVElBWHBVOFNIeEprQWtXZ2IzWUo5K1dqNEwwN0pDbUtoNkdkMHYv?=
 =?utf-8?B?V01HRmdJQXJHMzB2MUJ4Yk9TcXVIclJhSmdLZ0s4UGljVHpNVDBOeTdZcW9H?=
 =?utf-8?B?OS9EMTFJSmdnOUtuM3RodWZHdXZLNVREWUhUdnpTa0N2Rnd1bkcwWlVlV3Js?=
 =?utf-8?B?NEpUY21zSG5HUEpjUDRYUHQ5Uks4Q2VCdGJ4NWN2TVdWcDQxdHgwa2tRODIr?=
 =?utf-8?B?bnFvZjVFNGNMbXg3bDJScVNGN1VvbWNaS3orcnRSUDV5L1l1b2Rnam12SXM5?=
 =?utf-8?B?TGtBSzJBOEZDSEYxcm5SazcxRFoxTkQ2RzZwWE14a2V0dnJEbEtNS2dBNExF?=
 =?utf-8?B?MFJTRnhhNWNmanQwQ1o4TU93cVgvNHJSVTJ1WkZ4SU9MZTF6TTZZa0xHVEh1?=
 =?utf-8?B?ZSs2Y1NBL3NIUHdYK1k4eWEwTnM4KzR4S1VLR2J0cTNhemc1YVFQNUtUeDNL?=
 =?utf-8?B?VzFiWlo4eUJQMFNwSSt3NVJQckFmWVdoTHYza09RS2RWYzVEN2VSNEwwWStx?=
 =?utf-8?B?TTB1b3I1Q2E4MjhLUkhuSy9YT01rREVBR3FMajM1YmFrcm1LY2hjeVc2ZFRM?=
 =?utf-8?Q?s1bzMpwr60iPah9ICb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee68a6f-36c2-49f3-77a2-08ded3b45cbe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 18:54:33.8668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nra5MAN0svXlBthPqtdVnl+MlDf6nci5K26Cjr5rJl5Y7l8XrACPyHYjiv0SRg/DkD5g2t6d80pD3+tlYc/0Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9580
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



On 6/26/26 04:45, Granthali Vinodkumar Dhandar wrote:
> From: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
> 
> Initialize GC IP 11_7_1
> 
> Signed-off-by: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  9 +++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/soc21.c            | 28 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 ++++
>   7 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 249b2d556bb3..d345bea4f390 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2337,6 +2337,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2399,6 +2400,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2726,6 +2728,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2945,6 +2948,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
>   		adev->enable_mes = true;
>   		adev->enable_mes_kiq = true;
> @@ -3354,6 +3358,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		adev->family = AMDGPU_FAMILY_GC_11_5_0;
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -3384,6 +3389,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		adev->flags |= AMD_IS_APU;
>   		break;
>   	default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 46b9a477fb42..61c528c5db5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -978,6 +978,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		/* Don't enable it by default yet.
>   		 */
>   		if (amdgpu_tmz < 1) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 26c02bcb05fa..60e2fb968124 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -137,6 +137,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc.bin");

Don't you need me/mec/pfp for 11.7.1 too?

gfx_v11_0_init_microcode() will call amdgpu_ucode_request() which is 
going to look for:

amdgpu/gc_11_7_1_me.bin and such.

>   
>   static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
>   	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> @@ -1133,6 +1134,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		adev->gfx.config.max_hw_contexts = 8;
>   		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
>   		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
> @@ -1618,6 +1620,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		adev->gfx.me.num_me = 1;
>   		adev->gfx.me.num_pipe_per_me = 1;
>   		adev->gfx.me.num_queue_per_pipe = 2;
> @@ -3097,7 +3100,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
>   		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 3) ||
>   		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 4) ||
>   		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 6) ||
> -		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 0))
> +		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 0) ||
> +		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 7, 1))
>   			bootload_status = RREG32_SOC15(GC, 0,
>   					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
>   		else
> @@ -5773,6 +5777,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
>   	        case IP_VERSION(11, 5, 4):
>   		case IP_VERSION(11, 5, 6):
>   		case IP_VERSION(11, 7, 0):
> +		case IP_VERSION(11, 7, 1):
>   			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
>   			break;
>   		default:
> @@ -5814,6 +5819,7 @@ static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		if (!enable)
>   			amdgpu_gfx_off_ctrl(adev, false);
>   
> @@ -5851,6 +5857,7 @@ static int gfx_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   	        gfx_v11_0_update_gfx_clock_gating(adev,
>   	                        state ==  AMD_CG_STATE_GATE);
>   	        break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 8a0a88551461..c40d9c467204 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -607,6 +607,7 @@ static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		adev->gfxhub.funcs = &gfxhub_v11_5_0_funcs;
>   		break;
>   	default:
> @@ -783,6 +784,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>   		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
>   		/*
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 9b9b13e327d8..1677e88a4e36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -866,6 +866,34 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
>   			AMD_PG_SUPPORT_GFX_PG;
>   		adev->external_rev_id = adev->rev_id + 0xF;
>   		break;
> +	case IP_VERSION(11, 7, 1):
> +		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
> +			AMD_CG_SUPPORT_JPEG_MGCG |
> +			AMD_CG_SUPPORT_GFX_CGCG |
> +			AMD_CG_SUPPORT_GFX_CGLS |
> +			AMD_CG_SUPPORT_GFX_MGCG |
> +			AMD_CG_SUPPORT_GFX_FGCG |
> +			AMD_CG_SUPPORT_REPEATER_FGCG |
> +			AMD_CG_SUPPORT_GFX_PERF_CLK |
> +			AMD_CG_SUPPORT_GFX_3D_CGCG |
> +			AMD_CG_SUPPORT_GFX_3D_CGLS |
> +			AMD_CG_SUPPORT_MC_MGCG |
> +			AMD_CG_SUPPORT_MC_LS |
> +			AMD_CG_SUPPORT_HDP_LS |
> +			AMD_CG_SUPPORT_HDP_DS |
> +			AMD_CG_SUPPORT_HDP_SD |
> +			AMD_CG_SUPPORT_ATHUB_MGCG |
> +			AMD_CG_SUPPORT_ATHUB_LS |
> +			AMD_CG_SUPPORT_IH_CG |
> +			AMD_CG_SUPPORT_BIF_MGCG |
> +			AMD_CG_SUPPORT_BIF_LS;
> +		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG |
> +			AMD_PG_SUPPORT_VCN |
> +			AMD_PG_SUPPORT_JPEG_DPG |

Please double check this.  I don't think 11.7.0 or 11.7.1 wants JDPG (so 
patch 1 would need changes too).

You can look up for reference DEVCNIP-3792.

> +			AMD_PG_SUPPORT_JPEG |
> +			AMD_PG_SUPPORT_GFX_PG;
> +		adev->external_rev_id = adev->rev_id + 0x40;
> +		break;
>   	default:
>   		/* FIXME: not supported yet */
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index a6a7888c7a8d..2a239f45fc24 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1716,6 +1716,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
>   		case IP_VERSION(11, 5, 4):
>   		case IP_VERSION(11, 5, 6):
>   		case IP_VERSION(11, 7, 0):
> +		case IP_VERSION(11, 7, 1):
>   			/* Cacheline size not available in IP discovery for gc11.
>   			 * kfd_fill_gpu_cache_info_from_gfx_config to hard code it
>   			 */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index bc05ae15c1cc..1c3e8b61d4f8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -170,6 +170,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
>   	case IP_VERSION(11, 5, 4):
>   	case IP_VERSION(11, 5, 6):
>   	case IP_VERSION(11, 7, 0):
> +	case IP_VERSION(11, 7, 1):
>   		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -456,6 +457,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   			gfx_target_version = 110700;
>   			f2g = &gfx_v11_kfd2kgd;
>   			break;
> +		case IP_VERSION(11, 7, 1):
> +			gfx_target_version = 110701;
> +			f2g = &gfx_v11_kfd2kgd;
> +			break;
>   		case IP_VERSION(12, 0, 0):
>   			gfx_target_version = 120000;
>   			f2g = &gfx_v12_kfd2kgd;

