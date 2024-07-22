Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F466C3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 06:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E01C10E124;
	Mon, 22 Jul 2024 06:15:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1N5kBmGf";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B5910E124
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 06:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uThOtK0HrQlVm4jX44VtgRD7ZWZ7t8r942wtizJXg9PiCmYHjL2On/ORZazAwSPIjljWM9lqxZUIA9UaxVzXuM6G60Cdn0BU0WQhXV32if+DjkdfNCN4wCTMxtGD6kwa1+VVyr3sdjgq7Vnqcuj66L0fojUAkJ8UIxfXieNFEgIpVL8CA86EhQ5e9P26NwydlPapPxkf6V1ILVN9nSwKOn1tzJbJlyYmkJJubBOybwgww724+Lih1HDj8ZjRFBM4BzHObEMnRKicCRxWadBR230/wqrfPkuG8QbDpybD3GfK921v5iS85DROlYzcbGgyj0thF0kb1YRPoAmavVC5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYb6yDHxWMIPnqAEkUbM+TzWlAlPOIY4VXNPCrXuUq4=;
 b=RRZ4XV0kuKEu4Shn50a/fdJ9NsZoia0JMuiRd28+xaiRoxR/SDviDwEDJ8yzOfGMBZfvlcXo8ZhxNXRxaLeW0Z4CajctXzsIx0Z5MN6QXqqptmsyWLe3IYV4BE783S/Igus6wOq7V9RmJaEjyjx5LP/yamf0m06yzPN70T0wxwXI7obK4E0jY2ggheDFiBnYRMh+2e3BDg9am6d6SyeEHzrYW+VZpbTgv0ID2H8jhqZHnnwCgVqPn/OUuMCXAxLDz8qvU2q17nmPJ2YbYGMPWgSuT1UOUwsXlIu3laVj958QPCnUd57QGO+21QU/0+NjWTH/ScYisBm39ycI7xx/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYb6yDHxWMIPnqAEkUbM+TzWlAlPOIY4VXNPCrXuUq4=;
 b=1N5kBmGf7Mls4vF03JzfgQOTKhMR/dr9XT5MZJX/Gn8Kte39xPUYC1KaVjeoAdi5OwIWUbEaWKkhmuNk/kHURMvcaCkQ9vMMmgdWLb8UEugaVrX8s8v5r4pViXFc81DKoSelbgyCISb3yTzNIZoGgHQx/cv9jb9Ezd8yCMShjbI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 06:15:40 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 06:15:39 +0000
Message-ID: <edb53890-0727-4f7d-bcf8-c5b744ab2672@amd.com>
Date: Mon, 22 Jul 2024 14:15:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix index out of bounds in DCN30 degamma
 hardware format translation
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
 <20240721062216.3151119-6-srinivasan.shanmugam@amd.com>
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240721062216.3151119-6-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d92010-3920-495a-819a-08dcaa15b586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1JtVlZaY2JxTVVPQ3FJckg0TE1xNEtVMFh5REhJTG9lT2JtRjNRWk1tZnJi?=
 =?utf-8?B?akZrVjJwVk95QTk0SXNKZ1lGQkovL1BFclZqM3J5elllRnBFOFJ0cnBNM1la?=
 =?utf-8?B?TnZCb20ybUErMVloZnBiRTRNYll0QXJPbWdHVFY5RG9pano0dlpWV0VTY3Iv?=
 =?utf-8?B?dU5aYzM5b3NvZ1Mzc1V0Z216Wm4zOHYzS1JGZjJNaitjNlYzaTc2cHpZa2xm?=
 =?utf-8?B?SXRRemxkc3NCNEtSd3I0Y08xYTZPeE9sRElpUHVTV0lmQXFraDRzZStRTjJD?=
 =?utf-8?B?alBTU1FxeEhBRVNCUkRpSVpZUHQ3UHUzSUZRVHVXeTd4RmpUUFlWTnBGcUU0?=
 =?utf-8?B?MU9GZldINExId2NUL0UzeEZYc2VNODJqLzVkU2xFbERZcEhxVWt1bitYcllr?=
 =?utf-8?B?ZU51SWFYR29SMENvMFM3b2pDSFRhb2xBcVF4SHk5eEhBRUV0RWtkMy9qVGZT?=
 =?utf-8?B?YTRLNVI3b0k5MnNCY3FqQ0E1dUJCTzJ5ZG9VVnVPYmtncS9CdkxxQnU0djB0?=
 =?utf-8?B?a3kweTduam1QODI1S1JPZkVidWRXUEZPL0kzTnVhaFEzM0ZiT2ZTellCTFIr?=
 =?utf-8?B?bHhqbk4vMjFBaHcwT0crOHdrUTRQdmpoc1NCTTNtb0pTcWxnb0ZFb2FGdkpR?=
 =?utf-8?B?dTZLeTBnQkRDbE5peXlZY2RYbG1UcnVMWHZpbGFOTWRNS0dSTGNqVEEydzJy?=
 =?utf-8?B?L2hHZnUyZFJ4dW1nMnVQdkdwbUZOWW9PMXdpMFFGVHdEeTdvRytiQnVsSUpm?=
 =?utf-8?B?cUhnMjc5RURST091MXBaT1Y3UDNpcHFmbkRsZDcrTUFFNmVtTEU4VThzM2Na?=
 =?utf-8?B?TlFUOCtOQ0NiQktVZnJyc1U2QUdKNEJLYVNlRFQwT00xaDJrNUIwbUYwYkVx?=
 =?utf-8?B?RTZUZkVxaUZvTEFwWVNFK3V3NFA1dVJRb1dqYjh3emlGa1JIRFpRRzR2UUJj?=
 =?utf-8?B?YTZVRnJqTXdYbEg2ZklkRFhPV09KWUpmZ0hoZjk1NUQxY21ldEJ2WlN0MkJP?=
 =?utf-8?B?UzdTMm9sOE1GZVYreW1BSWZoZnlCa0ROMERZTHFsay91aWtsdUgxUmZYVndG?=
 =?utf-8?B?bm9sUU5mMlNWTjA3Q2hzcnh0aXdNQVRMOTY3SVMrakJZR0NyTExKNjBDWmJ4?=
 =?utf-8?B?aGtNdFFQK3NvREk0QnhEN0JvT01XekdxMVlqY0ZicHpTWitHSmxwaklFbXdP?=
 =?utf-8?B?L2ZTLzluc0ZFY0lnNjcyMnkxMXVXQjRMWlhpbHFWcEVBamRCOEZHZGJMQnBY?=
 =?utf-8?B?NXQxc1lSRkMvQ0lJTXZKYUY1aUVFdXEvSHpSdFFwbGZPS3VlRmpsVEx6NW1i?=
 =?utf-8?B?emx5MFo0dnVtN2IzS3l1M09FeTc3aGdjaFNWamJjMitrT2dRRDNncmovRnB2?=
 =?utf-8?B?bVFpUnBlVHIrN1hZaEc3M2lWUUF3NmV0REFGdzdqYUV5QklvTjM5ODl5OC95?=
 =?utf-8?B?VjZUM3NVUTRYODNFMTNKSTBYT0pZLzlrdlQwdmdCOVpySWg1U3Z2SHYrSUNa?=
 =?utf-8?B?dU5tdUlNTU53b3NQNG96bFJqY2lqNGFsc1pzaVZjcUFCbFR3eXFQWU9XcFN5?=
 =?utf-8?B?R1pVcSsrYytZVlMzTUptS2x6dXlNWGFMOTV5ZXVVWTNCZ3hncnN1YmlaeEpn?=
 =?utf-8?B?eFczUDI0STE2ZHlRcW9NVWI1ZmlMTjc5SDlISEIwM2I2LzVhUTB5VGtTY3Nw?=
 =?utf-8?B?d3luTzZuczlyQlk1TTJkNmJxQUk3VldKaDZ2dzI0LzB6eWxrZDV4NW1Jb2hN?=
 =?utf-8?B?UEt3bzIrNk9xTHRpNnZqd3JvbzNONUtvRlp6Y29DRlovOStVczlYS3YrVi9F?=
 =?utf-8?B?SHRuU1NCU2xkNlc2R3pjQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDBpQTAydTRGb3NxN1JzbERXVkdZTC9CWU5QRUZ1Nm5idEo2Z0xEdmRKbWZk?=
 =?utf-8?B?M2gwMVZWYlBBcHVIQ0IvU000azlwOENaNmtuZGQ0bmxsdzFxM1RsQlJrTG5C?=
 =?utf-8?B?NDNqR25SQ3ZSU3dsbUgvbWo2eE95UVVBSVZESXRlb3BPcFZjbUhVRGxYTnRS?=
 =?utf-8?B?SElxWFVpTWcwM1ZUYnZJUTI1YnBPWThxNDh5UjRGdzdqalROVWkzNHJ3Z3N4?=
 =?utf-8?B?bnhkOFcwWFFDOWJROXhIWHFabVFOeFRrWVVJSWRUakhHK2EvR0VDdHBrdzZq?=
 =?utf-8?B?cXNHMTRJT0VTNDBEWHI3ZWE1dnVGYy9IWkhUdk16cGYreWk0ZTMxbTBLckp4?=
 =?utf-8?B?bS9wb1BLdTZDSkZSaGVROGs2aXBaUU42ckdnVXlTSlJSaDJNME9SbkRlV1Qz?=
 =?utf-8?B?UTBjbUpWeUtuTHpzZVcvRkpUUU5jdTdNb0hKNHowNFlsWFZIQ2tqVlg0L01S?=
 =?utf-8?B?aHdGYkxuY0hYNDh6aW96MVN5UWFDbDlTdU5QNDBENnB1N01OcE92eFdRSHQx?=
 =?utf-8?B?SnY0YXJRUlZsbURvTmFmZzQzV2l0ZFp6WnJ1ZGtXKzBLbkRTcHZJOE1RZld3?=
 =?utf-8?B?MnRoVURiVDJkS2JTeDh6a0puVHR2aXVsWVN2NlA1MVpaTkhQZUJKK3A2UmQz?=
 =?utf-8?B?dmRKb1YxajBCYnFyaDZLT2hXMkgyc3NZaGEvWTVZM0hOWTdqQjdnTTQwME9z?=
 =?utf-8?B?azJNTi9xVE82Ymx5Zi9ka1Q4MXJ0RzFZRkpRck1uK2txU2V1cWErMENuMVJ3?=
 =?utf-8?B?MTRoVHBUb3hpTG9xdFFlWEF0T045bC9Cd2FTWEpqWm1qN3NLblk0LzcxSVNL?=
 =?utf-8?B?MzFMcHhwUnZ6elFLNGtpRmtjVFFGSXdUU1dzVGhuRi8rZk9NU0pQZWY5MFM3?=
 =?utf-8?B?b20yT29oQnVkcldjdG5LMzlMcUdIQ25samEwWnYxTXdJa2FkODJxS1dyaW96?=
 =?utf-8?B?RS9BdXprVk9LM3VlQlplRzQyRkszSTBTUFI5aEZsaEUyb1VVMGtwemxDb2tV?=
 =?utf-8?B?ZkFyYkZyN2d6R2I3azMxdWJpZk9RWlhrQ21xa2Z2b0RxOFByUi9pUXdhYWJO?=
 =?utf-8?B?M1NOVHhvdFF5WmxqWUF5cGUrMGVZN2JDWDdHSUQzNko0cWxtSVpwenNIai9q?=
 =?utf-8?B?eWhodGNzanJ2QUlsZXFJa1VaVU9IQUwrQ1RhTVpuNVJXQWhrU2pDZWJSTlVs?=
 =?utf-8?B?YktYcXFaeE10Um1UbGVZbTJwckRXUzJ4anpvSmhKbHJwdFY0TzAreVRTLzgy?=
 =?utf-8?B?aXNMbG9CQVlNZWYrSHBDUnIyQTRvREhYSUtRNmZhVUIrMWF6S1YrYnZnd3RQ?=
 =?utf-8?B?K2NCNlJ4Nys3OGlFUFpkN3R3TnNvRnZDWm01TEFEWFZIYlJQbFY4Ly9tQXhz?=
 =?utf-8?B?Yy9iQzk1SGNwT1B1elVVUEk1VmlPQTRDYmhGY0NQaG92NEg5K1lhZ3hSRWZ3?=
 =?utf-8?B?OVdYS1lRTlljM1JwWXY1bFNOT0pRYnR2cVZtWFhJbUhSSWJ2ZUgzUjM1QzdF?=
 =?utf-8?B?QnRWSUYxUHRZVTd6NHlRNzM2UDRTRm9hc2hTbVlQTmdHSVFOdDRHbzdQQXBU?=
 =?utf-8?B?VlJzMVpZamtZaFZOZE5JbU1hZUlDWGJrNm5tZTZpWWhnMWlBWDc4SnJiRWJ5?=
 =?utf-8?B?ck1ZR2JDZkxwVHgvdE5qQ1RKSzZzZUNXQnp0ZWlXSUpyZDIwQlNqZjdkV0p6?=
 =?utf-8?B?R1pKVkl2YTMycTl4Q1E1SWwwQVZOSXNlZVg3eU5UeWtrRkUrTUZ2ek5seTZ3?=
 =?utf-8?B?Y2t5WXpmMmltMzhRVHhEQ2M0SllRRllnVThac3dCUFVmQkorMkJKclNac2Ev?=
 =?utf-8?B?dFl2bklKbnVoQkZhUEJ3UVJVamY0cEtIWi81TlErVjJONkhkYlpqRVB6S255?=
 =?utf-8?B?VzBYa1Z3N21wZGtoTmRPK3dxVjFUQ29VNUlPOXUvS3RGVWxENlVvNEo0eEdR?=
 =?utf-8?B?aXFTbUtTZVRJRDdoby8xb0FvTmk4N2NlQ1FsbTZJYjhTQU1WRXBxemtIaGdO?=
 =?utf-8?B?a3ZLenB5c2d6cGRobWx1eTVYeXhMRFh4RkZWci9iTjJ2Ymg3QUlrbHFFSVF3?=
 =?utf-8?B?OVk5VkpWNjkrMkFCaVdCM3Z3eDNSWWptTU53REE3NW1RYWhDNEY0UnlsUGF5?=
 =?utf-8?Q?/u7UUVp8WqVwUp7Qn7P4Cx18v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d92010-3920-495a-819a-08dcaa15b586
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 06:15:39.8931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSbb9FqM4MY7UTNe5XWxIIxsu67bwvP9zMmsyRdVK4OnD0LZOzdKPKtL6BJ9IlT9EzkI+MdyTQS8JqF9630XsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
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

On 7/21/2024 2:22 PM, Srinivasan Shanmugam wrote:
> This commit addresses a potential index out of bounds issue in the
> `cm3_helper_translate_curve_to_degamma_hw_format` function in the DCN30
> color  management module. The issue could occur when the index 'i'
> exceeds the  number of transfer function points (TRANSFER_FUNC_POINTS).
>
> The fix adds a check to ensure 'i' is within bounds before accessing the
> transfer function points. If 'i' is out of bounds, the function returns
> false to indicate an error.
>
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_cm_common.c:338 cm3_helper_translate_curve_to_degamma_hw_format() error: buffer overflow 'output_tf->tf_pts.red' 1025 <= s32max
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_cm_common.c:339 cm3_helper_translate_curve_to_degamma_hw_format() error: buffer overflow 'output_tf->tf_pts.green' 1025 <= s32max
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_cm_common.c:340 cm3_helper_translate_curve_to_degamma_hw_format() error: buffer overflow 'output_tf->tf_pts.blue' 1025 <= s32max
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
>   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
> index ef7d75f6ab93..f31f0e3abfc0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
> @@ -337,6 +337,8 @@ bool cm3_helper_translate_curve_to_degamma_hw_format(
>   				i += increment) {
>   			if (j == hw_points - 1)
>   				break;
> +			if (i >= TRANSFER_FUNC_POINTS)
> +				return false;
>   			rgb_resulted[j].red = output_tf->tf_pts.red[i];
>   			rgb_resulted[j].green = output_tf->tf_pts.green[i];
>   			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
