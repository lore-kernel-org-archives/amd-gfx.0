Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93227C54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 07:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF39610FAEB;
	Thu, 22 May 2025 07:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AHd92EwA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5417010FAEB
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 07:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r75ESbk8C/Zpe9TI0swPurWdiuE0qURk2jibob0bVxUsFS8dRv3kAlfBX3rGr6olembt/UpgHJf/WG1vGShgm611ICiWwwEigollpATcq1wktFXiiftEYdT50MWu3zo9KPzB6cpimJO9ubWbE85ARgYxxhe1yz8PZHImlF4dErEtfEkVR1N50gnBPkBivgxTSfmcxsTWk2KlX2DMIZhgpX5Ewp+TfOvVxBbR4LCT33F3eFnF6cSkNEMchTE+GwLjHQSyEFQlJo/SUavPDWi1t9UsGstJiAPtOipiwAC+WX+vWx1+KSc/Xmb7HhCeJSSjYDX40UNHUgL941BOZkKF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UWomBHQlqKMvgUbGzd5TQwOev1rigVp1KcShOj0gxU=;
 b=gjzATA2NvmLMA+sIOhOOh8tLcVdipsjNGjkmQe/qlUngH34E3HW/de6j/xv+Cp0yz8vgYPGvRHXlNkFk2OOGlSLPt9R/yZK9+CLWxlWD48U7W6D99F4gQAr4yD5LuiQu+S8o2NIHiugPffv/BfmPXvX3BpY5TK3R1p/BrHXs/Wm55Zzz+Qw5h8MO4Gq1tU0a6rdPU/5MNq6GsZ3BzasfeoFU3quldH5ELfr/rlZZA3vz6diNwGXLX3FG5txeZAyV8XBRvIjounzFs6o6+51Ny3zM3EJqKJrX8kaw1GyzxlRsKG06N5kclebCtx042i4aLtrK/3yXa7JpPseV9YX+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UWomBHQlqKMvgUbGzd5TQwOev1rigVp1KcShOj0gxU=;
 b=AHd92EwAlhslLS00DChwGwExH0/Z1agA2Q6hUcDm74xqR/TH9e/ggEPrtrZeMx/RQiMBeMt83X+TftLIpjS2RM93Km/SzkvYTNFNk8UrncF8cIfslB+zcubZjXeonpldYjQdTmESdypeY8Y0gpNpgx5yXG0FkkFanxgG3aANPXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS4PR12MB9609.namprd12.prod.outlook.com (2603:10b6:8:278::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Thu, 22 May 2025 07:45:02 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 07:45:02 +0000
Message-ID: <063b34ba-6370-4942-acbc-9aeee41e8dc3@amd.com>
Date: Thu, 22 May 2025 13:14:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] drm/amdgpu: update GPU addresses for SMU and PSP
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Christian.Koenig@amd.com,
 Alexander.Deucher@amd.com, Owen.Zhang2@amd.com, Qing.Ma@amd.com,
 Emily.Deng@amd.com, Jiang Liu <gerry@linux.alibaba.com>
References: <20250522034350.433219-1-guoqing.zhang@amd.com>
 <20250522034350.433219-3-guoqing.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250522034350.433219-3-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF00000180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::50) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS4PR12MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db1cba9-02ee-4160-c83f-08dd99048f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUo3SFVLQ0poUTYrTlNLMlhxRGNYODBOQitBSG45WHpmb2RCOWVPakRKT29a?=
 =?utf-8?B?aG1GdGkwNGdwUFI1V0FWWU1IandlK2gzRXN5OHArMnpBSHVLbDErYmxLVXYr?=
 =?utf-8?B?eDExRTFPQWFQQkZ1MXVzRmZxcG1uKzM0Q0hoY2NoYk1XNkt0cDg3ZnBGZHFQ?=
 =?utf-8?B?MHNldUdCQ3BuTFdidXVDWmdneWxaMWdUUWR3dG5razFkcmpLMkhHTks3VmZK?=
 =?utf-8?B?VDgxSzFKQXJYbmJZTmZQdFB5RXdzUkxqaVc0dXBqSXBpUCtBcllrTS9IRUlI?=
 =?utf-8?B?Z3FCNUJrZmRWN2ZIYmNwOGludk9HbVdFZGJPVWc2RThtaEZJUXo0Wkp0cGVE?=
 =?utf-8?B?dEM5S0FDT0tKZ0hYMVZyMyttNnozaGd5WWtJZmZPOW1EL1p3T3JiS0JuZ0FK?=
 =?utf-8?B?S3JBRmNqQWttL1EwMUNDc1BLZVdnRnl3UUhmNGR3WHFoVHovbktpZDFmRERo?=
 =?utf-8?B?c01lRksxeGgzblRoSGp1RENzcWlpN1g5TytqK3Y1S1E5dExwdVM0NEdaMHln?=
 =?utf-8?B?aTBBdTdiODI3MzUyOU5ncGcvWDlwd0VvazRaWGc5Z25OWjQ1MXZKSVRVbFlM?=
 =?utf-8?B?UVcwRnpUK0tsbWoyWE83NkhIdk95a09QZEdVd0E5QnRDWmR3QnNzaEFmblda?=
 =?utf-8?B?THFWYXJmOVJpbzNhaGorR1Nsem5RZm1xeEtzZkJucXdLZElhbFlqQmN5L1VW?=
 =?utf-8?B?My96RDkzTzRnVUxwV1dzRE9pNHkrYVB5bU1ydUFUWmxmMjMwWG9mdDMwWUsv?=
 =?utf-8?B?cTY3a3dXbUJ0UG5HUk9jQlV5UDlPbVkwSjN3YWxZVnUrTWkvVFBtSFVaN0JO?=
 =?utf-8?B?czdDeWdUeFF1NXR5Qld5clBPa1l0aldJa2xESnk3bGh6cHFaQ3MyTDhVbjd3?=
 =?utf-8?B?Mm91cjdyRGVoelFPRnJMS1VnN3BHU2hSVWdWRDUzS3hiZ0dlQVZLcXNmZDk5?=
 =?utf-8?B?Qm9WMGw3d1ZHaXFQUE01L3hhN29TQ1Q2YmFLalB6UG92djlhK1hsSmRGU2lh?=
 =?utf-8?B?bFZZUlh5Y1lpRkk4S1IweHh5OXBvM1luSTQrcDFpUDg0WjNpNi9yMWtEa21Z?=
 =?utf-8?B?cnVYOTUxS1U3RGIyR0NCQ05HTmc0RkRpRkE5TkswUk54SlhYdExsNS9rOWsz?=
 =?utf-8?B?aWNmaXB6d2xBTkZRdEZVYWtOTVFmN2VSRnFoMTdra3hxZ2N2MWRYb1FWQXRj?=
 =?utf-8?B?OVFQU1B2cHpUWjA5NE51M2lQTVZHNldXRC9LZnUrbTVyVStYNGpDNktlUVlK?=
 =?utf-8?B?SS9aTi9VMnp1dDRMWlhCdWQ5ZmVUUGI4NGdtcC96TXJvM0xwbUI4Q0hyRlhJ?=
 =?utf-8?B?emNnc1M1dXhnSmc4TFN2bG5RR3dlanpBa1F1RFZZd05ZRFJMc1NVK201KzZR?=
 =?utf-8?B?NVFLMUNLZzV0QmQrV0ZNZkxGZmdlbzRUVlRnRWQzTm5BNXc0RzdhTnVQTmw1?=
 =?utf-8?B?UlZ1am1UQ3Qrb3R1QmVFa2VvYzRNQVM0QnhuQ0xRUDd6Q0dzZUNLN1d2b1lI?=
 =?utf-8?B?VkFabEhTUUVuQnB4bDE2VUdObGtnOGczRVRHNFdtbVByZy9iVGxWazlRdlli?=
 =?utf-8?B?K2JQSzg3VTZ0dElLcFQ5UFFVODQrcmVUZk1vSzdwbnk5OEJCc21Ma1pZVzgy?=
 =?utf-8?B?d3ZIbitvUjZGUXNtbVVxOGp0T3Y3KzNFbjlhT28rckphTzhleVpWV0ZhQlVL?=
 =?utf-8?B?cU5aU0wyaDFXMXJnS3VuZy9NTU94bXhZRmRhVlF6Y1JjRDZuQnFQMlVJTFBu?=
 =?utf-8?B?dzBJSy92dFVkbzJ5WkdlcmU4R0Fjbk43aG1aclp3NEpneEtVamRCakRZdlNU?=
 =?utf-8?B?eXV2d0hpbVE2NEJ3bXRvNnBoYUtEdnFQelE1WHlYaExoZnYvSnNJYWVLRlhy?=
 =?utf-8?B?WVE3MUtWNStDVlRsT2w5TzRrWUpzYmZKY09LNVpmREVnenc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXdUc24yaU55N2p6cmJMVWN6d1RCcmZIR1FGM2JTRDNxeDR3cnpZOGMzZUtz?=
 =?utf-8?B?TmZ6YmxCOXlQa2E3NkpHOUJGUG8rQWMySUhKbEtack82YTYyc2NzSG1UTkNF?=
 =?utf-8?B?QUV4Ykp0ZVFaMndybDA2RTA2L1YwdXNvTzN6OW9DL1RvR3d2bmY4ZCs5RS9P?=
 =?utf-8?B?T2syajE0VTJmeDdWdEphRVNleGhZQVcwZ2Yrdis1Q1ZRNjBnbFIvZWgxQk1q?=
 =?utf-8?B?TFVZWHk0WEM2Tk5uZktJa0pjRjFrM1FzajQ2ZXJSZ01kaFJQejB5WEJ2SENz?=
 =?utf-8?B?cDlNdkJaSHVlMGp2SjlLTkN5Q1pZdlBzWjZSRldxeU5GVkZmcXJFMTlZTkMv?=
 =?utf-8?B?aWVnREk4OG55b3doSy9ZRkZGQVFkVXg3VHRsdDJkQXZpdGlCQi9Iem5YVDc1?=
 =?utf-8?B?R0t2Mm9oWEJaWm5XRDZFL0w5N3NFWVJQajVBYkNPSURIL29sUmg5RkxrQ0cr?=
 =?utf-8?B?cVRMakdVVjVRSXRyUTJHMlhYZXlaeDkxa3FrUitCMWdJRFhndHo3dks0bWE5?=
 =?utf-8?B?VWl2NTlTMW96MWowUC9DTkxtc3BvaUV4bjlSc1E3YUgya0xCMzhhVEpXRHJV?=
 =?utf-8?B?dFVPOVdqekJWNFpHSTJ6QThYWEt4cE1jQlczUnRmR3JwZVhIb3gvczM5Mk1N?=
 =?utf-8?B?UXplZktNbHd0NTl1MlUyN3hCb2Z6bzljcG05YWdCQ0hkamcrTlJkbnR6cXRp?=
 =?utf-8?B?dDAremwzUUhaNFplUzZ3eXhySXhGcnBaMERKTGlTRzYxN2E4TjdaSHZOQm91?=
 =?utf-8?B?V2NobFhPUTlzcy81dWRZUEpuaUcxaC9jODRkQlVQQ1dpZXUxYzNsNWpISm5j?=
 =?utf-8?B?RGpHWTEyTGtDN0NCUW84TXZmZTIwTU81Mkw5TllCSEFKb1ZOdytXakdPMExG?=
 =?utf-8?B?dkR6elpUYjZMTS9DTU5keERxWW5oZHJPRHlKNVA4MktISmVHYjlpNEgyVy9a?=
 =?utf-8?B?SlJFOVpDK0NIRDRGM0Uxb0VEazQ5TEFzeTlhQzA1aTlNRkwySEIyVkNFZWFR?=
 =?utf-8?B?Z2NjTWZtSWJqK1dOc0RvQVExN0FYL3JkYklNcG9uVy9yUmpBUTV3MHU2U2lI?=
 =?utf-8?B?SnFaNHUrR2ZZYUIyS3Z0eE9lZmw4Q1dpQndZYmNWTVBRR1dVYkRRRWhQZEdq?=
 =?utf-8?B?bk5LM3U3MXNhelRFK2dKOVcwU0xDOC9PTERScDNndU9WQWpnSFhHMElYVGgw?=
 =?utf-8?B?OWY0VGRwR2RZd3FjM21yRkFhSGJwQ2NmK0ptWkNnNEJrTXdCMC81MEx6K3lu?=
 =?utf-8?B?Nk9ZZFV5eVRwZzdwY1dGam9lZUE2WDQyT0xMdTZoZ1cwYmdEMkFHTVg4cWMz?=
 =?utf-8?B?NDdyRWhDbjZOQ3VaZm96UlZObGFzbVA5dWR4aDhvYmllVmtNRWlFdVZmbWs4?=
 =?utf-8?B?ZnpGWDNQQXRXSHpLSXBUNlduZkIyRzNic3pWNkoyTitlRmI3QUtEWmhFek5H?=
 =?utf-8?B?RExCemNWWmVSV25vK0N1WDV5M0F2bHIvZmVZSnUzVmUyZTFNTm0xZnhBMGI3?=
 =?utf-8?B?WXp5cVJCOFJkRGtwckNwSTg1V21tcjFKRG1oMkkwNHhRd1Y5TmZ1RVVQS2Rn?=
 =?utf-8?B?T1UwazRRcjZLeTV4MnQ5K1FTZEFUVHM5dGJ0eW5OSnNYZWFVejFVTERxZTUx?=
 =?utf-8?B?RUprOUdiVUZwVlprc3g4eE5Lakx4SGJBNTJKZFVnYm8vanNzeSs3SXlkMVJ5?=
 =?utf-8?B?UlpIZHhhRnp5OXhSR1FNTm03RUR5NmwvVVpYcWdYUkJQcTYxLzQrcTJCSUFp?=
 =?utf-8?B?WDJTeEdnNXgyT1lUcmNkZ2RuVmk0ZHBSS3FJZmVrdVJZZEM3dXlWakYvdXV2?=
 =?utf-8?B?MUJwNWFjeUtlWjArWUFKdWNGTEI0dFlMU1ZFKzVjN1FIMk5lNU9aaUxsc0tG?=
 =?utf-8?B?VlFwOVJ3RE9OZklySmhCU24waU9BZC9yYytsSTJITHY0SVRYaXBRY1N4Rk43?=
 =?utf-8?B?SVRNWTFGWjBaNHpnWnpya2VoNUtwZC9jS2ttbmhXeWVCd2Y5NEVUQ1g5Q1dU?=
 =?utf-8?B?bGJ0MlMrLzE5RncrL1F4YUNUWTdZTk5Ga3kxYStmUGJyeExhSnhTQ3g4ekgy?=
 =?utf-8?B?Rm9iSzdEdDZYNDBDT3N2bzVMcFl6azVHY0MwcDd5SkNpS0EyNENId0FpR3Er?=
 =?utf-8?Q?eJNOhuFXfwXObC8kFmK+IQ086?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db1cba9-02ee-4160-c83f-08dd99048f13
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 07:45:01.9781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5cZXVgWbagF71ubIaw2xrnlZEH0fYIroTXMDINsyjnSM7uBfELdLPu3D8FE4G98
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9609
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



On 5/22/2025 9:13 AM, Samuel Zhang wrote:
> add amdgpu_bo_fb_aper_addr() and update the cached GPU addresses to use
> the FB aperture address for SMU and PSP.
> 
> 2 reasons for this change:
> 1. when pdb0 is enabled, gpu addr from amdgpu_bo_create_kernel() is GART
> aperture address, it is not compatible with SMU and PSP, it need to be
> updated to use FB aperture address.
> 2. Since FB aperture address will change after switching to new GPU
> index after hibernation, it need to be updated on resume.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 23 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 +++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 18 +++++++++++++++++
>  5 files changed, 65 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4e794d546b61..3dde57cd5b81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1513,6 +1513,26 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>  	return amdgpu_bo_gpu_offset_no_check(bo);
>  }
>  
> +/**
> + * amdgpu_bo_fb_aper_addr - return FB aperture GPU offset of the VRAM bo
> + * @bo:	amdgpu VRAM buffer object for which we query the offset
> + *
> + * Returns:
> + * current FB aperture GPU offset of the object.
> + */
> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	uint64_t offset, fb_base;
> +
> +	WARN_ON_ONCE(bo->tbo.resource->mem_type != TTM_PL_VRAM);
> +
> +	fb_base = adev->mmhub.funcs->get_fb_location(adev);
> +	fb_base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +	offset = (bo->tbo.resource->start << PAGE_SHIFT) + fb_base;
> +	return amdgpu_gmc_sign_extend(offset);
> +}
> +
>  /**
>   * amdgpu_bo_gpu_offset_no_check - return GPU offset of bo
>   * @bo:	amdgpu object for which we query the offset
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index dcce362bfad3..c8a63e38f5d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -320,6 +320,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
>  			     bool intr);
>  int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>  u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo);
>  u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>  uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
>  uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index e1e658a97b36..3fc4b8e6fc59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -871,6 +871,8 @@ static int psp_tmr_init(struct psp_context *psp)
>  					      &psp->tmr_bo, &psp->tmr_mc_addr,
>  					      pptr);
>  	}
> +	if (amdgpu_virt_xgmi_migrate_enabled(psp->adev) && psp->tmr_bo)
> +		psp->tmr_mc_addr = amdgpu_bo_fb_aper_addr(psp->tmr_bo);
>  
>  	return ret;
>  }
> @@ -1270,6 +1272,11 @@ int psp_ta_load(struct psp_context *psp, struct ta_context *context)
>  	psp_copy_fw(psp, context->bin_desc.start_addr,
>  		    context->bin_desc.size_bytes);
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(psp->adev) &&
> +		context->mem_context.shared_bo)
> +		context->mem_context.shared_mc_addr =
> +			amdgpu_bo_fb_aper_addr(context->mem_context.shared_bo);
> +
>  	psp_prep_ta_load_cmd_buf(cmd, psp->fw_pri_mc_addr, context);
>  
>  	ret = psp_cmd_submit_buf(psp, NULL, cmd,
> @@ -2336,11 +2343,27 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev)
>  	return false;
>  }
>  
> +static void psp_update_gpu_addresses(struct amdgpu_device *adev)
> +{
> +	struct psp_context *psp = &adev->psp;
> +
> +	if (psp->cmd_buf_bo && psp->cmd_buf_mem) {
> +		psp->fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(psp->fw_pri_bo);
> +		psp->fence_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->fence_buf_bo);
> +		psp->cmd_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_buf_bo);
> +	}
> +	if (adev->firmware.rbuf && psp->km_ring.ring_mem)
> +		psp->km_ring.ring_mem_mc_addr = amdgpu_bo_fb_aper_addr(adev->firmware.rbuf);
> +}
> +
>  static int psp_hw_start(struct psp_context *psp)
>  {
>  	struct amdgpu_device *adev = psp->adev;
>  	int ret;
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev))
> +		psp_update_gpu_addresses(adev);
> +
>  	if (!amdgpu_sriov_vf(adev)) {
>  		if ((is_psp_fw_valid(psp->kdb)) &&
>  		    (psp->funcs->bootloader_load_kdb != NULL)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 3d9e9fdc10b4..bf9013f8d12e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1152,6 +1152,9 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
>  		adev->firmware.max_ucodes = AMDGPU_UCODE_ID_MAXIMUM;
>  	}
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev) && adev->firmware.fw_buf)
> +		adev->firmware.fw_buf_mc = amdgpu_bo_fb_aper_addr(adev->firmware.fw_buf);
> +
>  	for (i = 0; i < adev->firmware.max_ucodes; i++) {
>  		ucode = &adev->firmware.ucode[i];
>  		if (ucode->fw) {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 315b0856bf02..f9f49f37dfcd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1000,6 +1000,21 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
>  	return 0;
>  }
>  
> +static void smu_update_gpu_addresses(struct smu_context *smu)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct smu_table *pm_status_table = smu_table->tables + SMU_TABLE_PMSTATUSLOG;
> +	struct smu_table *driver_table = &(smu_table->driver_table);
> +	struct smu_table *dummy_read_1_table = &smu_table->dummy_read_1_table;
> +
> +	if (pm_status_table->bo)
> +		pm_status_table->mc_address = amdgpu_bo_fb_aper_addr(pm_status_table->bo);
> +	if (driver_table->bo)
> +		driver_table->mc_address = amdgpu_bo_fb_aper_addr(driver_table->bo);
> +	if (dummy_read_1_table->bo)
> +		dummy_read_1_table->mc_address = amdgpu_bo_fb_aper_addr(dummy_read_1_table->bo);
> +}
> +
>  /**
>   * smu_alloc_memory_pool - allocate memory pool in the system memory
>   *
> @@ -1789,6 +1804,9 @@ static int smu_start_smc_engine(struct smu_context *smu)
>  	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0;
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev))
> +		smu_update_gpu_addresses(smu);
> +
>  	smu->smc_fw_state = SMU_FW_INIT;
>  
>  	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {

