Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323D2CA0FF0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 08:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C993B10E3B0;
	Mon,  1 Sep 2025 08:50:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eho+kxI/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 088C210E3B0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 08:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1vMjF39BWBfQt1Lo6+QE3cUbr4EVCI4ADcFKyltsiqiOhCe+jKyZh+//nbQZRx4EGHN4kFG8kWY+UbCz4nGe4EiDphUjiPamPQKGyApMgijLOonOSAWS0zaT1DSx7ry4iYqwwPXU0sZRhwY8l82yOyeCeAY2Uw4Fzs5A5Y/WOveqUTZu7RWxbJ0iYp1At7EULOcype6BYGoPvfztWv50436kM8nhpVtQn3y0WRY1NPeLi87Akk5tRVDlZjOLBqD2RbSV2t9dxtxrOUjAScoPbFl52yEFNuJDgIffoHyTV0u31FMYSu1qF4B8ALxsOIIihbsdUK6+EhUpCfSpJP+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaqrNcsgiW80xd/xQq/+7BwMoA6ACs15zfdv6hWqH6A=;
 b=oY4ELS2e+Z4jDm5axtqYDPIlTCG9z/VEOjAbhSmr2+oJZf/W60f0k3WBiXtcb7mac1/tMv/8gQ6AYKoaFlVeH8OUlmjjdPg+SpejBGVo/8cbM/QzdGRJUsVWcHI3+l7XKeioLeJ74OSeygoCVGofbL7cgv5HgiXlqMOa5hc99ApPXlTBMwbPfuZfYgxJCdCVICSdeCpxEQnAl0+IK9m98xCKldKmVclg067qBiln82jFi5/WFoVJioHjnengY5a1dk5PeWCYr5eEsrpNOaZMtsMc6AUvv4axNrUNQBqAIXSgduNF/lhaEFJXYwxbZDpS8FUgncg4P8WtnJ94jeK+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaqrNcsgiW80xd/xQq/+7BwMoA6ACs15zfdv6hWqH6A=;
 b=eho+kxI/yys8F0fMuTmQpvX5S1OyNLYVkK2UdSTvMb391K/QMpUMTx+3muy7D7zPAx54v0UK+FEo/r77tMr19IwF/d2GiHpobethpofsYKipkgxyKe4iv5KOImI0QPO4jhmV/sXRplNxBW486T2ccSvq+EBK+s7iNq3lmbe+R9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS2PR12MB9712.namprd12.prod.outlook.com (2603:10b6:8:275::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 08:50:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 08:50:46 +0000
Message-ID: <0c318c3f-2cf6-420e-868d-8ff158f711f4@amd.com>
Date: Mon, 1 Sep 2025 10:50:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] drm/amdgpu: Add mmio_remap bookkeeping to
 amdgpu_device
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
 <20250829135523.4032168-6-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250829135523.4032168-6-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:207:3c::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS2PR12MB9712:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a1657c-7d6a-40f3-4dd7-08dde934a46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmNPd2RrRjEwTzFpa3oyenFrdENxTTA1dkdOUVhRZk9wY0s5ekxTQjNDZGQ0?=
 =?utf-8?B?OEFKNDQ1ZGRvSUt6MWk5Snl0OHBobmFCbUd2M3pDSVJxZVh2ZGg4RXhOQmZv?=
 =?utf-8?B?WVROdFgxdU5DSXVHaEdCaDlkck5iYkEzSTBobnJhMm5iU0VPQXZmVGJIMThy?=
 =?utf-8?B?K1MxWnU5Q2FHUEgreCsxUDJhdUNkd04yc0dENDVyZUNuMysyNzFxdVVaR0VZ?=
 =?utf-8?B?bUlBWnZjL0luMys1Q1AyQmNMZlIrVUhiWE9Qb3FzZ05vQzBuanhReEI0WEFE?=
 =?utf-8?B?aHR1d3FQNytoT3BWb1U5ZlBuQllyVTRhTmtVZTUvVkNMd2orTGN6MWRuamxh?=
 =?utf-8?B?MHpjZTYydFRnVjNMbHlMTTFxSDZJbVovcndTTGdhOWQ5RmNOei9IMkw0eDVM?=
 =?utf-8?B?ZUl0SVRqM2Q1bDkzblhvMUVaeDFXdnYvdGM5blB2YXg5Um1Oc01IdUxiOWR0?=
 =?utf-8?B?aDQ5aDlJVzRSTk13Z09xeEpIMThlRC9jckpnbXlKYjBiTXJNbUw3Szl0MkRu?=
 =?utf-8?B?Tlc4M2tHbndQZkFHRk1ENHNQQzUrUFdscHBsUi9YNWtkQ1pZSVB0bG10bDVC?=
 =?utf-8?B?QXUzVGZlSE1XTTBUTDZoQWVRSjBRM093M1Z0TWthdldUZFJFSWJML0tZcXBr?=
 =?utf-8?B?cGtVMDJuaUtkZGdrREJIRUk5MnR2SzB5TzV5QVZpRnZGODBMamM2T2FMNzBj?=
 =?utf-8?B?MHFTN0VZTHowSWMycldlMmZvLy9xN0F4Zm1iSHhqQVRWSTliWFlmakJzVkVK?=
 =?utf-8?B?bVd5SWJWRFZ1QVAvN0tTMkhyYnMrVFRIcXU1Z3hCMWh0clpqUXE1ZE5TM0hq?=
 =?utf-8?B?RVFiL2EvcUh6YVN1ZWJQWWM0UUF2enQ2WlVPZm9KQVR0VERnUTJncXpncUNE?=
 =?utf-8?B?NXJJMGRnY3UrVjR0bTF5L2VwRzkwSExtMmNzZFAyWDZDb3EwODZZazNVVUdj?=
 =?utf-8?B?Z3JYYjdIT2Yrazk5bVpRKzdxeVZza2Y5WXdNcnBRS1M5YzBGaVo3SnUwRzBo?=
 =?utf-8?B?dk5OMERubFFjZVJKUzBZc1luZkJsK0UyT1dHVHFyYzlzcEtqUnVuMGhleWty?=
 =?utf-8?B?YTBweGR5bFV2WlJBdjRCUmdWclVkQTM0cCtsVlhjZVFYbmFzM3lEU2laQ2xS?=
 =?utf-8?B?ZEpKN3BVV0MydExHVGpXdHlKZnNpbjI0bnNJWC9HbkVOTHVuKzZqYzZrSVdR?=
 =?utf-8?B?VTVUL2VoN2tBVjMyd2d6QXlOS2h1Nmg5L0ZkenRPYkd3cC9sQklsSWgySkV0?=
 =?utf-8?B?RFdzRTFUbC9TbVNBT3g2Rm1ybnpSWVA3emJYRjJ0UG5SRkdVUlFmRWY3cmRu?=
 =?utf-8?B?UTR2WVVPZUhHK2p3YjRYeHM4L1BGL09jalNUREdFK0ptN3VzbWh4djNXQzlI?=
 =?utf-8?B?SklSb2Y0TUpHSXhLTG1vcElzOUpNVkIzWERPU0ZoWjlZTjBHWGVYMFQ1WXZU?=
 =?utf-8?B?L0FDdXVtNElMMG5GWlRIeW5OZUNHWGFtenAvc2lHTlc0TXZ3cVlieWxNeDFo?=
 =?utf-8?B?VW5HemxJNzk3aStKR3ZlZ3NBMnRZbi9CZTQvWmpWS21MR0xnZ0VENkRLUGUw?=
 =?utf-8?B?SUR1VFY2c0ZzOVFZS2hDeGx0SHZYQUE1ZXVEZnRGc1A2WjA4b1kvNjQ1a3pD?=
 =?utf-8?B?L1lFYVlCRU5Ub2oxTk9xZG8wVFZjdHRuUFFseklEUE5WMjV5dVhURWhwdUhv?=
 =?utf-8?B?d2FlK2RVNytyTHlJWEJxNXVKU200aldxQ01jc0F3QnpoSXFjNUtTWXFlUWxl?=
 =?utf-8?B?ZGE3YlRPR1FRTW1oWklMYVkzUFE5Y0JNZFBCM2FlVm5HWmRDWloxVVQrRUVh?=
 =?utf-8?B?RE5OK1hlRjRtcTNMZU0xOVpTK05UbVprNVNuRFUyeXA3M2UvbWh4UXdLZlly?=
 =?utf-8?B?eU5rNEZnc2hmRGdvYytrMnpaTDNMVWZ3VzEvbkpHWXlWN0d4V2FqZUcwZzNV?=
 =?utf-8?Q?/+XDzKhqLgw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnB6S090WG5RWVlwODljd1JaOGZIZ3dJWDREaWpUOHpraVNJai9IdGZtMnE2?=
 =?utf-8?B?L3BsMGlSYW5MZDVHenZrVGZMZmJHQVJTaEVQRENmdHM3NGZ6WTAzRHF4UlNF?=
 =?utf-8?B?N3FSOEIrTTQ4NE5NMjRpUFFkelBNQ21rRDQ1aDFHQ3VGWkk0eGJXcU1XOWdn?=
 =?utf-8?B?YklGS2p2RU40bTJIUy93VnNiYkg1Y000RzZWV1J5R01qUk9XYWRTWm90aC9B?=
 =?utf-8?B?RWcwbC9aQytlYXUydGZjcVN2TmFrRTI3Q2xvYUh4bXRKc3JHZkNHMjdKbWdL?=
 =?utf-8?B?QnVLZThMbE9XR251ZnRRVDdLKzRLNGliU1VlQnVVMjZIa2x4c2dnWldWQk5T?=
 =?utf-8?B?eTRFTElqY1pWSEROWWRwTDQ1SFRnMlYwdGVNWWsycGlDVlY3Q3FDd1g5Z0hi?=
 =?utf-8?B?QmpaWlMrMjVRVGM2RjhZTU4wMnFUSHNpOHIza3RrYTNmRnNHeEJ0dzZ0TjdN?=
 =?utf-8?B?RDhndUowa2JCUUhxa2hRUHNmaXZYRlVUSXNhOXlQMEN3ejRzck9zSE1wWExL?=
 =?utf-8?B?NkNNdDFkNkoxTk54aUhqWkprR2pRTGs2TnlQc0YzMmZpNzBvdXBjYTRnQjh4?=
 =?utf-8?B?KzIwbUoxYjdvWitPd3hmRUFBa3QwNmJPVmlYeFdiQWVJcGhmaGx6TXRJUVVT?=
 =?utf-8?B?OFJjM2hlbkUwd1RhTTI2M1VOOFlYcUsyTkw4VUt1bmluUDZZWkZqdkZvR2gw?=
 =?utf-8?B?bWdzNy9lVW9wTVFNNWZSQzJYMzNiODFCQ3JXUk5Td0JqQWZiZFZKQmJCeDk3?=
 =?utf-8?B?ZHNlVnI3aHZBc0dYT1NHVitPNGZyM3Jkd3A5K01tTTZJT0I1N2VkS0p4SmdV?=
 =?utf-8?B?NmgyVUdETHN6aEZpWWpiTE9zeGpwVDh6YkdUaytjbGFMNXp3d2pzK2o1VzNn?=
 =?utf-8?B?cGltaUtaVDZ6Vk4xOWhxdHI3VXVrWkgrTTFZb1FzMm80KzRzMlVpcTU4dGJu?=
 =?utf-8?B?aksrdmY1ZHRmUVpaeFZsazE1V2hUYmt0UUR6YmNQb0tGeGRuRk1WMUtUSWxX?=
 =?utf-8?B?NFNieWJYVXo4bnkxVU02QW40bExyc2JndldvaTlPNnVSUUFWNHo1d0VDZFFS?=
 =?utf-8?B?MEZwenpPNzhTOGFadnRUYlBIcnVZV2FxRzNsdzFQbGx3Y0FvWU5nV1J3Ymxl?=
 =?utf-8?B?WTZ3N2gwemFLT0pmenBncHZadmx0clhnanZwVDdRbXBSM0R1bmk3Y0FIYmty?=
 =?utf-8?B?aENaRjF3K0FGU1NDdmgyaFErbjJSVTVkT010RGxaY0Vwd2E3WUlNVXdtVDFB?=
 =?utf-8?B?QTFMUWdFTTFmcGc5MGo5OFV4RWpiNXJ1NklOYnlhWUxnclNlZ3dnNzBDazUy?=
 =?utf-8?B?WThVVlBTYXNBZDR4ajRBU1hFMzlnbXpkTDNVS0V4WmZ1K3IzMXEyOFNZTFpt?=
 =?utf-8?B?eXVKSzI0Ukw5alJubEVBbFRzNzV5MXNqMWhjMk94QzBjOGt2bDFrdlgyNjU2?=
 =?utf-8?B?TmJGYitQemZLSTA1d2FtQVNieWl1Vzh0RTZ0NUR6N2l2RmpkWWxQTXFPZ3hi?=
 =?utf-8?B?ZUxJNGFKZTZNSlRsekJ6VnJwN3JZamU5bHhMdkZaa2dQSzJTN1VneDgzQmtB?=
 =?utf-8?B?MWV6WkRJVHd4SlI4eTZpVFlQUDVpSVRpRFFzMkpaVEFVQ2w1bWszbEoxbCtK?=
 =?utf-8?B?aGRFSUh0MHNHUkhrRjgwOVlzS3ErUkxyQmZUZnlOaUhBVW43NS9wZldsWGl2?=
 =?utf-8?B?VjJ5MWVhTTBGa1VhZitEc3VKd0xTSFRsLzdna3lVSmlVWkZRSXZCeVE5ZEEv?=
 =?utf-8?B?UzFST2R6U2MxbGFHUlFPdi9FWElobjBKbXROc3UxN1RRcVUvM3o2UGZBVHRT?=
 =?utf-8?B?bm5kdWxHVHF6WXdUVnRCd0RjVkZnb3hnbXZBeWhidUoyUFdxZzVZQVVhRnQ3?=
 =?utf-8?B?eWRFY3F6NjdxL2lId0FYYVB2L0treU9pRTBDT1J6WWpIcTNZZmdpUCt5bmFR?=
 =?utf-8?B?MXBBeVVLRjd3NEM1ZTlyRVVUS1lCQXE5ZmlnVTZERXBaZzdMcXBpVFh3QVZR?=
 =?utf-8?B?RUxKSi9RcGlOVmRUMGg0THV4TUI5SksxZ25ZOVk3VGtQVWNJZVVIRHNEQVFT?=
 =?utf-8?B?c0NNS3NTbUJCSk9sOFRPZkZRWVBvUzYyV1dldU4xcXpVcnFyOEVoTURaSGZy?=
 =?utf-8?Q?1eLeg+4L0aZoiZqRZcM3FLEha?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a1657c-7d6a-40f3-4dd7-08dde934a46c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:50:46.4865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGVmLt3hkCM4B/jb272lO56X7wtmiTdVfOqD2oLG6+lo7iV2Z836lduEjnPUncts
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9712
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

On 29.08.25 15:55, Srinivasan Shanmugam wrote:
> Add bookkeeping for the remap page to struct amdgpu_device:
> 
> * bo:	kernel-owned singleton BO
> 
> v2:
> - Use existing amdgpu_mmio_remap container; remove per-field members
>   (Alex).
> - Use AMD_GPU_PAGE_SIZE (always 4K) per Christian/Alex.
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ddd472e56f69..24501d3fbefe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -752,6 +752,7 @@ typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device*, uint32_t, uint32_t, u
>  struct amdgpu_mmio_remap {
>  	u32 reg_offset;
>  	resource_size_t bus_addr;
> +	struct amdgpu_bo *bo;

Since this now adds only a single member I think you can squash the patch into the next one.

Not a must have, but I think that makes more sense.

Regards,
Christian.

>  };
>  
>  /* Define the HW IP blocks will be used in driver , add more if necessary */

