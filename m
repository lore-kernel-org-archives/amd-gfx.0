Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B785AC71159
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 04:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FBD710E021;
	Thu, 19 Jun 2025 04:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EIEk6qCG";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BFE510E021
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 04:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQeOQdRTlTOkRtxAzD9mhrNZoujjLZh8FOj1ZqJMU5jOkVffY0dYKKzDtX+Us+/XPnpT6KdW+/cyyIIkX0beMS5n8pfE+7shy2WCbpADrjNdL1Zi7aCAm4yxRjrl3ZueQrwrvs4Ryy1nj6XZAw8D0pRB0oFAGfYkn8ZDA/6B4yZywhIaCisVsXpXIJ51n9KsQQYBfvIJvGnBWT61lLYI4SL/+6RV2qS0L6FQLyvKHeIlyTutookRVVnWj5HtyR/NY8xwvT/4/fh8mcmomkbYFO2luOZK3nIOZApoVe47b/HkYH6T5VaY2F3Ub8zMNlnOiIXV9iqVRtUOB4hqclgF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5hy8Xsk+0P1OAkPvw3wKmz/ZvRsVc43dmXLjDbEo2M=;
 b=rMr8ck1tfyFq5o3UA4mNVDEWU35m8TZ/OkqDr8J42Eco0TGO3lTaf74TfwKGv/lLInJ3i1gTJqTDE+pbRlX2bbBwtaTyqZJa9y9NtgeYsCAmyGHJ2LU6yFUxUK9PcVcR0Nw8y8jKZE8FSdWzOnn01Z/Oq9jd4/ggfID+1SNq9wNOt7yQ/gbOKcvlUAWcWHNF4bIg9ZdVaDIs3dcjNonQOOjdY5eyWQa7OlUt7StJB0aziW+YoSruY5kQlQAcTB8tgLFT4L9rFdPH+ixV/ahyol5rol1u2mSllRDpMp0wJkSSMDbvJ2oHygR26WR6K8Rsdi2x7WhmgT+oJAirutK42w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5hy8Xsk+0P1OAkPvw3wKmz/ZvRsVc43dmXLjDbEo2M=;
 b=EIEk6qCGih2nJrX20wHqFI5Fe6G0HxaZuTk0DYMGUPpQ0Lc//vlW1tj2444WsUpt3ceC9gPVUcBmwSO3dvdYWqu7Yg4ud+QRPnbu8Z7Zrdlv6VPoml7pmqQ6EDqm+h/NHiDPJOr8ckMw0YhvHdlmETPoCwvTGpWjdERayUlmzqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 04:21:02 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Thu, 19 Jun 2025
 04:21:02 +0000
Message-ID: <06800e90-9347-43db-999d-0aa1917dd6b4@amd.com>
Date: Thu, 19 Jun 2025 09:50:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amd/pm: Add support to set min ISP clocks
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 mlimonci@amd.com, xiaojian.du@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, Phil.Jawich@amd.com
References: <20250618221923.3944751-1-pratap.nirujogi@amd.com>
 <20250618221923.3944751-3-pratap.nirujogi@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250618221923.3944751-3-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 1abd7e2b-dc46-471c-aafa-08ddaee8b314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkdXYVdZY0R3UExUOGo2S0E0ZXZGWDFIN29UQkxIOWtEeWptNzRDSFB1OUhW?=
 =?utf-8?B?WVpVbnlUSlA0T3M2LzNjbHhQY3JhV0dUc3JaWTJWNXVTMmNDbGlDeHovYk5X?=
 =?utf-8?B?RlAwZ3ZTSEVEclNrR1AwVWdzc1Q2aytXRW5CYmM3MVdqWmV0NVdiSEt3L2FB?=
 =?utf-8?B?OHFEOFpBL2l1aEhWMGNMVWR2ZUpIWkZrSDlDVWRkMHlwQ3MvUVViaThPdUxn?=
 =?utf-8?B?VjdUQ25RenUxaDlicTh5RGpLVEhSMDFnaDl3RnZIbkQxalMxczNjQ3F0N0RJ?=
 =?utf-8?B?Ky9Hb2MyUEl5NFVXRjJiRHJMZlpUNVFsKzcxMlY1eXhrUUdiSzV0ZDAzeW1S?=
 =?utf-8?B?Q0JjUjN3S1QxL3U1Z2VlMUVmMVRVNi90cGtuS0VFZ3NuRWZlRjlwNlRYUFI2?=
 =?utf-8?B?TGV6eUJjWUJpM2hRaTlrTnJGZEdGMyt3dE1ZelNrc09IU0pyRmFVM1FDSVk0?=
 =?utf-8?B?N25tNWtWOFRxTElLQndkVkcyczN2UE1odzQyUG8xamZjamZPemJjVm5YTVBm?=
 =?utf-8?B?eGVtY1NNSkJWQk5pR0NQL0orbWQ2OVY0aUp6NWF2ZXRSaVp3dWpMZ3BBQS9i?=
 =?utf-8?B?anRWQ2pJY2cxVU01SVZ6WTU1OENhdExRZjBJMitiRCtKaENkUzFWKzdzVnJK?=
 =?utf-8?B?UjVXdDUwd1RwT3VmZ0ZoOWRmblRqY2J6OTdPdk8vQlZkMUNqV3MvSVpEbGdW?=
 =?utf-8?B?bnFLQzR4Z29oYUs5T1J5UW5MdUhuZ1MybmF1SENjZWY3NzVQZ29rMEdIeG14?=
 =?utf-8?B?VVY1NkV6cjRzZm1pUEdHYW9GS0ZhelY3M1ZyTThVTDZtbng3UXpzM3NmWGQz?=
 =?utf-8?B?bDhKSkdrLzVWRFYxWGE3K3RlS2dwUmh2QWdjWnFBZzRUVVdUNkdvYnRwM1RU?=
 =?utf-8?B?STZEY1VNRVlPMzNpTHpOd0dKaHE0TjFoNEpzam5ENWJGNm95eUZNUFBsZzhi?=
 =?utf-8?B?MVA1cWZwVU41c1c2bHh0cEhYUWpWNllCWWhnMDBKVEcrZWJNZkM0ZWgrdHRJ?=
 =?utf-8?B?SVRCdlJxMTNNbFlJZWdCVlZvZTVWRlh1bHpvZW9Qd3hxaW9vMDlQclpPTE5C?=
 =?utf-8?B?MWJoR2RtSXFMRU1pUGRWeUhQUlRuZG5LZTYyZ1o0UFVCSEtnMVJkVjNUSko1?=
 =?utf-8?B?K2x4Mk5SRU1XTTBTRFhteXhrODB6MExzZjRvREd1UVlmTDhNZXdvSmsxdzhF?=
 =?utf-8?B?UENjeXVnaEFVU0p3MkNTZHdWV3UrVjZ5cUFxc0NUdmFWbTVqNUNLZTVxdTI4?=
 =?utf-8?B?MG9zRXBWMURyUkhiQmwwOTBZRnJ2MTl3ZXdZMFlFZEYxNzlrVmdjU2Q4NExD?=
 =?utf-8?B?dTV6YnVaUk5ER013M25JeUdHaytRbkJGUWxKN2ZPUnlWYVh3dEtBZGFsaXhU?=
 =?utf-8?B?QkxreXFNYThGQndTMmp4TTVZbEhSK3hMMExqY0RXUEJ6MVVXM09oTFZ6WVM0?=
 =?utf-8?B?ZGFxRXdVQUo0T3oyNU5qMmh4aitoUFQxOWZBdGdzNzlXdTRSNUl3OElockkw?=
 =?utf-8?B?K3krRGF2L29MbUpPdVp4cVRoT2padlB4RjNMc0REOFFUSVA0Smd4d2JOd3h6?=
 =?utf-8?B?d3E1YTFkWDRHNUMzM1U0U21weVlheE1sYnl1WGcrSjYzMys4dGMvMUtjQThq?=
 =?utf-8?B?b3hMMGJTWWJIMFBlQTV1WlJ3aTBqa1VSOWpvbkYvU2xqWnBBWkxqdlhUTXpx?=
 =?utf-8?B?SmNSZEU2UUlzUFNpRU9wbTF3YVhXcDZHZk1td1VEekdVT0FPL3c2R2gwNWJV?=
 =?utf-8?B?ODZwY1lEMGtkdWxRbjBHaS9YUDBuTFJUWktqOG1lcElMRXRQbVIxVnhWUERI?=
 =?utf-8?B?dTdBQ1VJY2VWNDdIUVdWSk8xQzNGRk1TU29WbVdCRStCMllIVDFqRHlDSTR4?=
 =?utf-8?B?U05vZHQvbERVa3JGbDJ6UU5vcWI2YkkxbzRPNXhJT3NTQ3dObCtYRkZ5Qnpo?=
 =?utf-8?Q?Jw2EY+8s+Zc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWo2SUFCM2VoUVdRdTdUZlo0b0hkN1NKNFU0YkcwT09ZZXN3aFBGSVhLV2lj?=
 =?utf-8?B?alNtYXZBQUpyd2wzZVNkTUFRSkxKSXJPdHFUTkJpR0k5SzhDYTB5MTNvbkE1?=
 =?utf-8?B?LzdtQlNlR3RCMk5PZi9tWmtxQnVqNVlSd3hjZlJ2S0lwNGVocElxL3N0WG02?=
 =?utf-8?B?dm8yNEhtVlpDZzExaGx6M2NWVU9ZTDRRZUNSelNNa3NSWTJKTWJhanJvWlR6?=
 =?utf-8?B?dTlMVjNCTVVvU0xLc3hYL2FvSWN5bkdGLzB1T1VsbzhheHhIUzdJUEoyVENu?=
 =?utf-8?B?bUpiRG11dTdjOGl4TWZ3Vy9oT0Q5MVdIRUhOaWxhaC9zN3RxbXhscEdZbVZu?=
 =?utf-8?B?cEgxVE01U21MWE9QSVFJeFo1a0d3ajJUT2IzeTdYbkhtbEI4YlUyeDJ6YjZo?=
 =?utf-8?B?djB6MGE5NW00UG9aRk93UjN2dlZLdVBOY0hUOEJHcGhpVVV5ZXlmQ0Q0ZHBZ?=
 =?utf-8?B?QVliRExMandsNDZxNFRGVHVKek9EMkpIbjR2aFFKdHpTeklzT3QrVzkzMWE2?=
 =?utf-8?B?QllycE5ZVmdlZUNpaE5wWUxxOUhObndOeVlMYzIvMHduK1BWTW00cnR0OHpD?=
 =?utf-8?B?dUlscHJ4a1RUcVRsbTJ0ZmI1STIzdk1rZCtPZWxzQlViQlExazFPQ21NaTlK?=
 =?utf-8?B?a3QyU3ZYSjhWc1N3bENwMEpqVmZZc2JhQ2pqZUN2Qms3V2NhaC9Nc2d4cG5T?=
 =?utf-8?B?RWtaaDJrdVVCTWRnQ2ZobndGbjQvQWprenhrOVdVNmUwU1NCcUtQT2poczI2?=
 =?utf-8?B?UDcyNEdZR204RjhXemdZbVFrNEg3K3QvUXNMV1duYnY1aWp5Z2F4UUhCbFg3?=
 =?utf-8?B?em5lUE1iR2Y3ZWxHd1VUNUlsZXNSQUg5ZmlrYXpqVGIvNVRGZUN5RWViMjN5?=
 =?utf-8?B?Vk83ZkhILzBudGFISy94VzYxZXF6UFdHeXlsUFVySWpFb2ViM3BOTktzTk9r?=
 =?utf-8?B?QWIrbHBVdWtlazNvQnZVdGRxV1AyZFRQbCtlWlh3MG9aaDVlZlFkVTlKakY4?=
 =?utf-8?B?bm9TUmpFYS9Ndk82ZkQyQVhjbDl6bGk3VTVTMjdkZi91Mzh1Nng2YnpMSTBE?=
 =?utf-8?B?SGQvc1BoUEc5Q0trbG0vaGE3ZkI5cGJiNU8zb1l4c1B3bUpaeDVSNi95enFt?=
 =?utf-8?B?Vm5BQkd6ZzJKVmFxRzArQnBhYTRoNzAvWFlnOUc0S2VMUUZONlUxNVY0dVN0?=
 =?utf-8?B?R0xQUnhJMW1Talc1M0ZqK0hjdmdoUTB1N0xERWVpQ0M5YlFHZFRuZUw3SjlK?=
 =?utf-8?B?MXdCc28xNGI2dVJFYnZNaTBkZ3U1eHlRY0RnK1liSXNvdStaaDJQbXN0YWxl?=
 =?utf-8?B?cmM0NDRqTkx6Q2VmR0x1a2xIaXgwSi9QL1E5ZzBNb0s0TUJqS2FoMGVNZHl5?=
 =?utf-8?B?R2JaeXp0L1BxM1kwSy83MEtnVGN0QlEzcjhWaTV3ejRuRFVBZmJnaDdqNHZo?=
 =?utf-8?B?M2lmdm1FNjVXbCtOaythYWpkbW9ZUitNNm9nTkcwVFlNcjUwSUZpZnFJc2ht?=
 =?utf-8?B?N2pLSlFwdGFqRGhLWTRGZGloNHNKTXhNUnNJc2JrSTJuWG5zQXZTYXRWb2h5?=
 =?utf-8?B?SVNhcnUxVHE2ZlN5SVlhL0dBRkwwQ1Q2VEgyR2MvZG1PcnNBdlZtbzNiKzN1?=
 =?utf-8?B?ZVFRM0N0eFJoTElibzIrSXBMckRBRDBGSFNMM2J3NEF1b2ZoK1pxbzhwVHVh?=
 =?utf-8?B?ZkF1RkFhTHlEcUg5YTRwMmFsdENqMjRYNzgyRm5FVmN5ckNTbEdZN0xSYWt2?=
 =?utf-8?B?RHBoQWhDQzd2VFlRTlRRNWxLY3NQbzZRWXJnSnZoV05zOFZ3dTdpcDJIOWlp?=
 =?utf-8?B?VjZkT2VtakhIV2pDb0E4TlY1dEF6WW5GaVI5MU1RVHJRVm8yeThEdW83cW9l?=
 =?utf-8?B?SVYvWlJxZ3lEbTloK1QvTlZkMXB2MFZrWEtscDJlZFlJMTJZVW9RM0hkZVVN?=
 =?utf-8?B?Tms1N2l4WE9jQWZIcE51Rld0aE9nN0VMOE1Qa09rNTdWN1Eydi91R201VnJy?=
 =?utf-8?B?YTJhVmp4YWVUa3dNdnJJSHFwb2x2bEl3VjNWTVg3S1pWVStwT3dBZnNXUW4z?=
 =?utf-8?B?MjBSeHhBMllCTHc5TDNoUlBiMGZKM3FYUnU0aUEzZCtLTFp5N2lQdFVkWEJ2?=
 =?utf-8?Q?HAbrperLfoWbZjLbc9utbFTac?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abd7e2b-dc46-471c-aafa-08ddaee8b314
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 04:21:02.3298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9/Pm/sxo7xQKh+ho30egZcHo/PDo7KUW99JcBAg+WAB89qngRM8Vjle2sNiOnUP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445
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



On 6/19/2025 3:47 AM, Pratap Nirujogi wrote:
> Add support to set ISP clocks for SMU v14.0.0. ISP driver
> uses amdgpu_dpm_set_soft_freq_range() API to set clocks via
> SMU interface than communicating with PMFW directly.
> 
> amdgpu_dpm_set_soft_freq_range() is updated to take in any
> pp_clock_type than limiting to support only PP_SCLK to allow
> ISP and other driver modules to set the min/max clocks. Any
> clock specific restrictions are expected to be taken care in
> SOC specific SMU implementations instead of generic amdgpu_dpm
> and amdgpu_smu interfaces.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 14 ++---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 ++++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  2 +
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 51 ++++++++++++-------
>  6 files changed, 56 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index f4d914dc731f..e2b1ea7467b0 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -108,6 +108,8 @@ enum pp_clock_type {
>  	PP_VCLK1,
>  	PP_DCLK,
>  	PP_DCLK1,
> +	PP_ISPICLK,
> +	PP_ISPXCLK,
>  	OD_SCLK,
>  	OD_MCLK,
>  	OD_VDDC_CURVE,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 95f1fff442cb..71d986dd7a6e 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -853,22 +853,16 @@ int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
>  				   uint32_t max)
>  {
>  	struct smu_context *smu = adev->powerplay.pp_handle;
> -	int ret = 0;
> -
> -	if (type != PP_SCLK)
> -		return -EINVAL;
>  
>  	if (!is_support_sw_smu(adev))
>  		return -EOPNOTSUPP;
>  
> -	mutex_lock(&adev->pm.mutex);
> -	ret = smu_set_soft_freq_range(smu,
> -				      SMU_SCLK,
> +	guard(mutex)(&adev->pm.mutex);
> +
> +	return smu_set_soft_freq_range(smu,
> +				      type,
>  				      min,
>  				      max);
> -	mutex_unlock(&adev->pm.mutex);
> -
> -	return ret;
>  }
>  
>  int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 97572fe26ddf..756afe78a6e5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -76,6 +76,7 @@ static void smu_power_profile_mode_get(struct smu_context *smu,
>  				       enum PP_SMC_POWER_PROFILE profile_mode);
>  static void smu_power_profile_mode_put(struct smu_context *smu,
>  				       enum PP_SMC_POWER_PROFILE profile_mode);
> +static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type);
>  
>  static int smu_sys_get_pp_feature_mask(void *handle,
>  				       char *buf)
> @@ -134,12 +135,17 @@ int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value)
>  }
>  
>  int smu_set_soft_freq_range(struct smu_context *smu,
> -			    enum smu_clk_type clk_type,
> +			    enum pp_clock_type type,
>  			    uint32_t min,
>  			    uint32_t max)
>  {
> +	enum smu_clk_type clk_type;
>  	int ret = 0;
>  
> +	clk_type = smu_convert_to_smuclk(type);
> +	if (clk_type == SMU_CLK_COUNT)
> +		return -EINVAL;
> +
>  	if (smu->ppt_funcs->set_soft_freq_limited_range)
>  		ret = smu->ppt_funcs->set_soft_freq_limited_range(smu,
>  								  clk_type,
> @@ -2980,6 +2986,12 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
>  		clk_type = SMU_DCLK; break;
>  	case PP_DCLK1:
>  		clk_type = SMU_DCLK1; break;
> +	case PP_ISPICLK:
> +		clk_type = SMU_ISPICLK;
> +		break;
> +	case PP_ISPXCLK:
> +		clk_type = SMU_ISPXCLK;
> +		break;
>  	case OD_SCLK:
>  		clk_type = SMU_OD_SCLK; break;
>  	case OD_MCLK:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 41d4a7f93660..b52e194397e2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1642,7 +1642,7 @@ int smu_write_watermarks_table(struct smu_context *smu);
>  int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
>  			   uint32_t *min, uint32_t *max);
>  
> -int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
> +int smu_set_soft_freq_range(struct smu_context *smu, enum pp_clock_type clk_type,
>  			    uint32_t min, uint32_t max);
>  
>  int smu_set_gfx_power_up_by_imu(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index eefdaa0b5df6..d7a9e41820fa 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -305,6 +305,8 @@ enum smu_clk_type {
>  	SMU_MCLK,
>  	SMU_PCIE,
>  	SMU_LCLK,
> +	SMU_ISPICLK,
> +	SMU_ISPXCLK,
>  	SMU_OD_CCLK,
>  	SMU_OD_SCLK,
>  	SMU_OD_MCLK,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index fe4735d5ebd4..fe00c84b1cc6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -1207,11 +1207,13 @@ static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
>  
>  static int smu_v14_0_0_set_soft_freq_limited_range(struct smu_context *smu,
>  						   enum smu_clk_type clk_type,
> -						   uint32_t min,
> -						   uint32_t max)
> +						   u32 min,
> +						   u32 max,
> +						   bool __always_unused automatic)
>  {
> -	enum smu_message_type msg_set_min, msg_set_max;
> -	int ret = 0;
> +	enum smu_message_type msg_set_min = SMU_MSG_MAX_COUNT;
> +	enum smu_message_type msg_set_max = SMU_MSG_MAX_COUNT;
> +	int ret = -EINVAL;
>  
>  	if (!smu_v14_0_0_clk_dpm_is_enabled(smu, clk_type))
>  		return -EINVAL;
> @@ -1240,16 +1242,23 @@ static int smu_v14_0_0_set_soft_freq_limited_range(struct smu_context *smu,
>  		msg_set_min = SMU_MSG_SetHardMinVcn1;
>  		msg_set_max = SMU_MSG_SetSoftMaxVcn1;
>  		break;
> +	case SMU_ISPICLK:
> +		msg_set_min = SMU_MSG_SetHardMinIspiclkByFreq;
> +		break;
> +	case SMU_ISPXCLK:
> +		msg_set_min = SMU_MSG_SetHardMinIspxclkByFreq;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL);
> -	if (ret)
> -		return ret;
> +	if (min && msg_set_min != SMU_MSG_MAX_COUNT)
> +		ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL);
> +
> +	if (max && msg_set_max != SMU_MSG_MAX_COUNT)
> +		ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max, NULL);
>  
> -	return smu_cmn_send_smc_msg_with_param(smu, msg_set_max,
> -					       max, NULL);
> +	return ret;
>  }
>  
>  static int smu_v14_0_0_force_clk_levels(struct smu_context *smu,
> @@ -1278,7 +1287,7 @@ static int smu_v14_0_0_force_clk_levels(struct smu_context *smu,
>  		if (ret)
>  			break;
>  
> -		ret = smu_v14_0_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
> +		ret = smu_v14_0_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq, false);
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -1426,7 +1435,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
>  		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
>  							      SMU_SCLK,
>  							      sclk_min,
> -							      sclk_max);
> +							      sclk_max,
> +							      false);
>  		if (ret)
>  			return ret;
>  
> @@ -1438,7 +1448,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
>  		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
>  							      SMU_FCLK,
>  							      fclk_min,
> -							      fclk_max);
> +							      fclk_max,
> +							      false);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1447,7 +1458,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
>  		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
>  							      SMU_SOCCLK,
>  							      socclk_min,
> -							      socclk_max);
> +							      socclk_max,
> +							      false);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1456,7 +1468,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
>  		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
>  							      SMU_VCLK,
>  							      vclk_min,
> -							      vclk_max);
> +							      vclk_max,
> +							      false);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1465,7 +1478,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
>  		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
>  							      SMU_VCLK1,
>  							      vclk1_min,
> -							      vclk1_max);
> +							      vclk1_max,
> +							      false);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1474,7 +1488,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
>  		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
>  							      SMU_DCLK,
>  							      dclk_min,
> -							      dclk_max);
> +							      dclk_max,
> +							      false);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1483,7 +1498,8 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
>  		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
>  							      SMU_DCLK1,
>  							      dclk1_min,
> -							      dclk1_max);
> +							      dclk1_max,
> +							      false);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1670,6 +1686,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
>  	.gfx_off_control = smu_v14_0_gfx_off_control,
>  	.mode2_reset = smu_v14_0_0_mode2_reset,
>  	.get_dpm_ultimate_freq = smu_v14_0_common_get_dpm_ultimate_freq,
> +	.set_soft_freq_limited_range = smu_v14_0_0_set_soft_freq_limited_range,
>  	.od_edit_dpm_table = smu_v14_0_od_edit_dpm_table,
>  	.print_clk_levels = smu_v14_0_0_print_clk_levels,
>  	.force_clk_levels = smu_v14_0_0_force_clk_levels,

