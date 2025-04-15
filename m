Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945BDC369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 17:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A11B10E027;
	Tue, 15 Apr 2025 17:58:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mk3Fp4wj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9104D10E027
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 17:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QozUUCG3yZuvhxTKzx5JQUI/CjR21hAxDFmTevx0kwEouRfulas6h9JAf2nw0d876wFQp4oqfMA69j1blP2MMqe4Cv+tvEXS79kMqorzEs/WbGUzui0LTWjui2y/PJpEEFk4z58nQVcq3S0sLgw4n5Hdevi9KvRgpwfUChlFAttbizMFTYTYQfXWzkuEMreNOF0AAN2BZjt16DiJ5n2byWvqb78iFRitGLfoyLAhX1UF+5jGQ98h+fMHrYkeZlSp+sNIEsp/sVjiExKHp1aqqSqWrBzvIwXv/cfjsHeErfb/+ovqR6WRAtj5+l6Xk2CS1wKFrDH8B/OjLphd/I/KNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/x+nN34z238ibO42FoiDC2K5TUb5bPTKp9LAJ5X1hc=;
 b=KZZAxSaWJeMptjo6m1Z8JGqbgTi10LzUPnw/AQ8AFgG+4MEc2Ca26Tp5blEp9p/s4k0zKUB2AaT/OR8B4p9hWgD+5XpghRwO4Xuejrl7n8In+izV02IVHj86O0lQInqfu2sBEv0UpHt9yxrfb1WQfZTYk2AOinOPie3JSHnlufHaJ/EcsF0/6kBJfsfKqk7auHa93iRqFGAgtuT5wePlIsA97DZEZNss28lGifXP4ZHwv8KEK2ehjgxwWo2+CGIjV/8Qm3ujR+508lUls+J+y+8SpKODTfoZZwlKdUCGPYUH28tvEZz2Y9u/a2ui/y8oeOc4iZXd71pw5fPxmc2Ujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/x+nN34z238ibO42FoiDC2K5TUb5bPTKp9LAJ5X1hc=;
 b=Mk3Fp4wjq1uVaAjRE4GkNo7K4i/NypPHhjxvTphahO1DHfRXtHcSCNUt6hJetcPa/c8Go9xOBAg5wv0hgOcaWnoBttG5Mc7vIfO1rWSksnwg1NLtHyMgVtQu+ADUCLfeklfZ4NpgvJIiVgKZvW3JFsD+ZjODFvKm7F9ETrSwLKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 17:58:09 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%3]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 17:58:08 +0000
Message-ID: <da5eaab2-a780-434d-9908-3bd8fe576d0e@amd.com>
Date: Tue, 15 Apr 2025 23:28:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: rework driver parameter
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250414182229.3043275-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250414182229.3043275-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::10) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f0f6d8-fc22-47a9-0433-08dd7c47147e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uk1pS3JZcXlwL3BRbEg1UHBZSURteUFZeE5MR1VZd2hkSHVJTXF4VCs3YmJS?=
 =?utf-8?B?QkhJOUFEMVBSWVp1M1YxakVDbmp2cUNJaHNRc2FLcDNhLzZ3VFI5cVU4Y2lS?=
 =?utf-8?B?V0pKdWFGSUlZaVAwczhUN3FPLzBKTWt1ZzluMGdtN21rZUJrL1RlcDEvK0Z6?=
 =?utf-8?B?N1NmYUcwOGNzdW94TWpydGxYcmJWSnN4WUFDVlJEY0Q0c0RWRngvem1TNmxZ?=
 =?utf-8?B?d3JqTDFJSElWYzN4R2VqblE4MkxRNTdoRTA5OFdOQWFoUEFJdmtQWVY1OE8y?=
 =?utf-8?B?QW90VjdjT3hRRUpWcCsrUDhTelVOWDRzUmx4K1V1em92RVNjZzgxSEZwbmx0?=
 =?utf-8?B?K092K2Jwc0RmdFc2Y3F6TGpxbG01cE42STJualZpbkE5QkFEcTBYVGc3Nmxj?=
 =?utf-8?B?d1Q2dnRRSVh1c2JoOE9DQWw0cTRRTjRUbGF5ZjB6Q3FCR3lGTEFzZ0JsLy9j?=
 =?utf-8?B?REtyamlYODNkWHA1TEFHRG9SaXhPbzk5b3E3SldnSDFCZHI0QTF5TVE3S3Bi?=
 =?utf-8?B?U1V4Qm80U1ErNFJidU9wcFord1hTcDFBY1VVb2dFZldhMTVUUjBUblFFUTBR?=
 =?utf-8?B?UllBT0VQRHdvTnhOS0lvdlBuZ3paMk9LeVNxV21hbjJJWDZCN0pack1CbFFG?=
 =?utf-8?B?OHozZGhrRE5JU0VzRXZ2a1Jua0g4ckhxVVZrRlcvOHhDSXdnWWFaWmQvNjQ5?=
 =?utf-8?B?cWdwYWQ0czl4MzZjR2EyVnpzcEQwVWxsbStwbDZDUXVUQk0xS25zYklveU1E?=
 =?utf-8?B?ZjN3bWVzNHRFZzZ6Z3B1TG5FbUs2MnJxNkJrU0IwMytOUUxadnkwb2VMcnRU?=
 =?utf-8?B?UnFKU0M2NHA5NE1mMXcxOHduWkhjVklRODIxZVJESDJJTWxndTNyTndMcmF6?=
 =?utf-8?B?YjgxQmpNdkxwQ08za3FFN2VGZm9NUjdhcFVWTnN4VERWTU0zV1IxblNHSmVW?=
 =?utf-8?B?SnBzZnMrbjR3bFQvbUUwYjk1WDR1OE00UGdXcHRBVmh5UDI3NUcvUmNHMnM2?=
 =?utf-8?B?aFdZcDIvOTlzdVYzL3FoeFJDRERYRGtXdi8zSkFkaElzZ1kxTms2YkNWL3NE?=
 =?utf-8?B?bms4eng5UFdDUjh5Z1YrcEhoYytjcmE1S3VnQmNpR2lJb1lsVzJxeDZ0ZTJK?=
 =?utf-8?B?NGxLS3J5YkQ5NW5IaWZHYXFXTUw0QTdzWlBIVFFvOUhSc3pKVEdYdkMwZ1Vp?=
 =?utf-8?B?cnkyb2I4TEdTa1phbGFnL3pSYTF2TWJnTGptSVhRelkvYjM4M2RtSWhSRmda?=
 =?utf-8?B?bjQ1S0F3R1U3SXgxYUlvUGt3c2Foczl1ZGcwazFhbDJXblFCZ3BWV1A1VkJm?=
 =?utf-8?B?ZzRwNjB6RVJZTFpObXJNTlp4b2NqQmlabjE5SGhmNFlaNjFQSk1TMDRHVTJh?=
 =?utf-8?B?SytLd0dRRmk4NmxQL2lHZkRFTWM0SEVtbGV0NkRjNUZrTXY0WFh6d0QydXl5?=
 =?utf-8?B?eTZ6Qk1XeHVlNy9aUHVnOVpWNVFVSVpnSnJJTk0xcWd6V2ZlUWxyTzRvK3Zp?=
 =?utf-8?B?QlNYUkNhaXQvS21VekhXNEVldzJUK0x6ZzdSY20zU1gzNHV1YXhYcWdvVkY4?=
 =?utf-8?B?SVhqZXdMTTVPaXI5cGN3ZHdkTzYyUHdqQXd5d3FoRVNzUlNnTmtzWTN0QVpB?=
 =?utf-8?B?TUZUSEtxS3ZTNzRhd0swS0dvakk5RWZZNDNRYnhUa3NxNWVFUkhtcHJpVzVj?=
 =?utf-8?B?V3VLanpMMXJJbUV4WmNCS3JIR0RIQ3FZb2plckxLN2N0QkhmR2VzV01FL1Bj?=
 =?utf-8?B?UlpRdDBZYVEwNGJDbllDTzZsYS9DRmVHMXprTWg5T0E5N2xycGN0TWxLZHVW?=
 =?utf-8?B?anJsNmxScHdsTXFMUGxHMU45MFY3QUNGOVRrVW4vTmpydjRWc1BlcmZEVU5D?=
 =?utf-8?B?RTJMdElHc2RFbmRvLy9Wa3E3aFd5VnhTangvRW5zbS9RUldRWTJVY2sxS2VL?=
 =?utf-8?Q?nNLuimeg7JQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWUxM1JBdVJyT1kyTHpzRHFidElOSTdLaTlsdGNXUXRuVTh3ZEw2M3IwWEV4?=
 =?utf-8?B?SUFUZnhndDhVaTFCL2JWbUtrTlBiV2JFdmd3eWUwVEhzK0llbVBHUTlnMVBE?=
 =?utf-8?B?MkRJVFBaN3UzYnE4bU1tVTNHSzVQKzhJNDBIbit1RG1xL3lUeFJ4RlQ4Um5p?=
 =?utf-8?B?N3k5SkI4NDVzVUZMMllCRFJqeE43dEhTT29LL1R2VlRWaXNpKzFRekN0STl6?=
 =?utf-8?B?ZVVmVmhnQlRsYUtVcWlWODBYYjZGeHBNb05DWE9obFNjKzNvWjNJVEZTalpj?=
 =?utf-8?B?WUpkUDRwSXhpdWRLelZYS0xCaStzMGN0T2tBalRuc1FJNUtWcTc5Ym9maE9U?=
 =?utf-8?B?RVhqWlFNVnQrVU50ZVVuUFdmeGhHVFhnbmVESXpDbUdVYVNGSVZzZWtOdU94?=
 =?utf-8?B?QVBYZVZ6bWk1b3hYZ2gyeVo2eTFNZWNaQ3B5WmFtMWNkUEtrT09LbDFET1Za?=
 =?utf-8?B?Q2xueXhZdnRBeDhXaGtDVXJtQnhaeGZRNm1uUjh1eWlVcXFUeitqZzlOUWRM?=
 =?utf-8?B?dDU2U1lteC9TTGh3VHVxUmp5bnVTUUNoYmJEcUZOcFQ2ZjZzS3VicC9YVVpI?=
 =?utf-8?B?Q3RWU0xHUkhXUHBrTEkrZ1YrL3lGWWRhZS9Xb2hVSXlmcHBuc2RNc01rUkUx?=
 =?utf-8?B?UjNldUJnWFpJZlJ6ZWRRRGsvVFlsdno3ZXBUYjc4Wk9Sd0RpZVg5SVhqM0ND?=
 =?utf-8?B?aGJJZHo3a2F1VnF3ZGxpQ1BCYkpTbGJuWldqSTd1WjNWcVJveHA2dlRNN0tH?=
 =?utf-8?B?aTRpODlpVnlBVDdJNnRGQ043RkZWWThXMnNuV1NZb3FEUHJpMUxDVWhQSEtM?=
 =?utf-8?B?YytXZFJySTFtN1l1MHhtK1pwM0YvWXcvU3hhYmhad01EVlJ2ZC9pRldZaTZO?=
 =?utf-8?B?U1hjalFJRjFCeHdjVkdoSE9VQzZFWGg3UDRWa3ovSWl5ZGlzSm8zNXZwTW11?=
 =?utf-8?B?NnRxOGpuaXJ1ZWd0MXVCTzNreDduNW02NXVhQ2UwNGdpNWVhQm1JTXRoWENE?=
 =?utf-8?B?aTh0SVFVeGpmVlV6cW4yU2xvbzY1QUtPT1JGR1IzVHZMOGNxZVZJVVlDYXA2?=
 =?utf-8?B?TXhWUXl2QmdIY3dKT2pjT1hPVHJabWljd2tmZVN1Tm5yUmIvbFd6Qlk1MzNR?=
 =?utf-8?B?N200MVZHbnhvWWZna0xQRVV0a1JTZlVOc01wSEJVRWtKcHBCWXFLOG9JM244?=
 =?utf-8?B?a1RYazk5dGkybk05OTdERC9VWDd2aUV4ZkN6TEZXZWtqMW40QU5mYUpDckw1?=
 =?utf-8?B?OUdQMVQ3ZGZ0VGdJSkxkSzlnY3J3ekxlRTlucERDbmdqU2JtbHhtdnFJdEYv?=
 =?utf-8?B?S1V0NHFkUHB3Rm5pWG9zSnlEMndGdlgvQnozMHBtc01rZGY4aXZXYWExdTJm?=
 =?utf-8?B?WHd6UytLYWVZaE1kZlVYWEZob1dHUVFqNEFoRjhueWExcFRSM056NDNFS3pE?=
 =?utf-8?B?YmRacGFDSXJ1SlhKTjByaVVRM000OFRmQWVhczRiWVorTHIyRkhsTGE3bGtn?=
 =?utf-8?B?UXJTUmtBR2Y2bWIzRVNFdGlDYlJKM04yQWp4N0dqTncyZk9keDBUVzlpRGVB?=
 =?utf-8?B?S20rRTRSNnA3dmxBUVRCZ2NnSlVWbXp3SUREY08zUHUwQi9ibFFQY3pVOUpT?=
 =?utf-8?B?N1NUb2V5RGVUMUlyVUh0cE9PdnNMQi9YWU5kcGNIdTc4bmt3K2dpaFptRzZH?=
 =?utf-8?B?SnhpRUUrejRscDdvU3A1ckVLT3JhMWhjQXFIaVRmOEV6WWt2SkU1RTJ0ZU1J?=
 =?utf-8?B?UHh1SmFsUCsvOG1FMXp0d1FaWERET1NRdWFNeXlybkRpb2x2cE0xMGNLM29m?=
 =?utf-8?B?eTFSTzNONENiRlp5Wlh4S0Rwb0o2RWdZWHRJNWM1T2VpMHRNSmJrVEhQZVQ0?=
 =?utf-8?B?OEV2ZXluZTFYdjlydkpRWFNndXBMczd6dmFnSW04SXJtWW14Ry9zLy9KV011?=
 =?utf-8?B?VjBXcjFKNnYxNm1mbnpkdVVQdGgvWHhmYmlFWmlPLzRNZ281dVcrUE8vSE43?=
 =?utf-8?B?YTR0YmY2YmJOeTVWVllDM0lDVUMzanpmcHU2cFZLK3pXY3NzNkhjTXV5aXFV?=
 =?utf-8?B?eDk5aG1DbjQzWHpCTS9rUHpnUno5ekNmVmx1N2JTeisra3JjV014K2JyZDg3?=
 =?utf-8?Q?B1ezW8opkJ0JiD8UUmzbDTqZX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f0f6d8-fc22-47a9-0433-08dd7c47147e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 17:58:08.8283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zocq6IBFN0mek2cD7xWeEKMGZ78SONHR9iohVW3U3mEYc4qqkSvqB3o7l0v0eKf9wWrNr86zFWo0PZo9AHsF7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772
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

Functionally code looks good to me for the intended purposes
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/14/2025 11:52 PM, Alex Deucher wrote:
> Replace disable_kq parameter with user_queue parameter.
> The parameter has the following logic:
>   -1 = auto (ASIC specific default)
>    0 = user queues disabled
>    1 = user queues enabled and kernel queues enabled (if supported)
>    2 = user queues enabled and kernel queues disabled
>
> The default behavior (-1) is currently the same as 0 for current
> ASICs.  To enable user queues (in addition to kernel queues) set
> user_queue=1. To enable user queues and disable kernel queues
> (to make all resources available to user queues), set user_queue=2.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 15 +++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 20 +++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 18 ++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 18 ++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 18 ++++++++++++++++--
>   8 files changed, 77 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index fd5df6394279a..41875bd735a5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -271,7 +271,7 @@ extern int amdgpu_agp;
>   extern int amdgpu_rebar;
>   
>   extern int amdgpu_wbrf;
> -extern int amdgpu_disable_kq;
> +extern int amdgpu_user_queue;
>   
>   #define AMDGPU_VM_MAX_NUM_CTX			4096
>   #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index a117cd95b9dcd..e24b0c730baf5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -242,7 +242,7 @@ int amdgpu_wbrf = -1;
>   int amdgpu_damage_clips = -1; /* auto */
>   int amdgpu_umsch_mm_fwlog;
>   int amdgpu_rebar = -1; /* auto */
> -int amdgpu_disable_kq = -1;
> +int amdgpu_user_queue = -1;
>   
>   DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
>   			"DRM_UT_CORE",
> @@ -1114,12 +1114,15 @@ MODULE_PARM_DESC(rebar, "Resizable BAR (-1 = auto (default), 0 = disable, 1 = en
>   module_param_named(rebar, amdgpu_rebar, int, 0444);
>   
>   /**
> - * DOC: disable_kq (int)
> - * Disable kernel queues on systems that support user queues.
> - * (0 = kernel queues enabled, 1 = kernel queues disabled, -1 = auto (default setting))
> + * DOC: user_queue (int)
> + * Enable user queues on systems that support user queues.
> + * -1 = auto (ASIC specific default)
> + *  0 = user queues disabled
> + *  1 = user queues enabled and kernel queues enabled (if supported)
> + *  2 = user queues enabled and kernel queues disabled
>    */
> -MODULE_PARM_DESC(disable_kq, "Disable kernel queues (-1 = auto (default), 0 = enable KQ, 1 = disable KQ)");
> -module_param_named(disable_kq, amdgpu_disable_kq, int, 0444);
> +MODULE_PARM_DESC(user_queue, "Enable user queues (-1 = auto (default), 0 = disable, 1 = enable, 2 = enable UQs and disable KQs)");
> +module_param_named(user_queue, amdgpu_user_queue, int, 0444);
>   
>   /* These devices are not supported by amdgpu.
>    * They are supported by the mach64, r128, radeon drivers
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 70b64bb1847c9..ed54095e6ad69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -487,6 +487,7 @@ struct amdgpu_gfx {
>   	struct mutex                    workload_profile_mutex;
>   
>   	bool				disable_kq;
> +	bool				disable_uq;
>   };
>   
>   struct amdgpu_gfx_ras_reg_entry {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 0b1fbcf0b4d0e..e768605253074 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -132,6 +132,7 @@ struct amdgpu_sdma {
>   	uint32_t 		supported_reset;
>   	struct list_head	reset_callback_list;
>   	bool			no_user_submission;
> +	bool			disable_uq;
>   };
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 40d3c05326c02..496e83cb89177 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1632,7 +1632,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 0, 3):
>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   		/* add firmware version checks here */
> -		if (0) {
> +		if (0 && !adev->gfx.disable_uq) {
>   			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>   			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>   		}
> @@ -1646,7 +1646,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 5, 3):
>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   		/* add firmware version checks here */
> -		if (0) {
> +		if (0 && !adev->gfx.disable_uq) {
>   			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>   			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>   		}
> @@ -5215,8 +5215,22 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	if (amdgpu_disable_kq == 1)
> +	switch (amdgpu_user_queue) {
> +	case -1:
> +	case 0:
> +	default:
> +		adev->gfx.disable_kq = false;
> +		adev->gfx.disable_uq = true;
> +		break;
> +	case 1:
> +		adev->gfx.disable_kq = false;
> +		adev->gfx.disable_uq = false;
> +		break;
> +	case 2:
>   		adev->gfx.disable_kq = true;
> +		adev->gfx.disable_uq = false;
> +		break;
> +	}
>   
>   	adev->gfx.funcs = &gfx_v11_0_gfx_funcs;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index ff56368df66ea..9cfe50016dab7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1418,7 +1418,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(12, 0, 1):
>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   		/* add firmware version checks here */
> -		if (0) {
> +		if (0 && !adev->gfx.disable_uq) {
>   			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>   			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>   		}
> @@ -3823,8 +3823,22 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	if (amdgpu_disable_kq == 1)
> +	switch (amdgpu_user_queue) {
> +	case -1:
> +	case 0:
> +	default:
> +		adev->gfx.disable_kq = false;
> +		adev->gfx.disable_uq = true;
> +		break;
> +	case 1:
> +		adev->gfx.disable_kq = false;
> +		adev->gfx.disable_uq = false;
> +		break;
> +	case 2:
>   		adev->gfx.disable_kq = true;
> +		adev->gfx.disable_uq = false;
> +		break;
> +	}
>   
>   	adev->gfx.funcs = &gfx_v12_0_gfx_funcs;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index c3d53974e7f53..6bb36187a53dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1269,8 +1269,22 @@ static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
> -	if (amdgpu_disable_kq == 1)
> +	switch (amdgpu_user_queue) {
> +	case -1:
> +	case 0:
> +	default:
> +		adev->sdma.no_user_submission = false;
> +		adev->sdma.disable_uq = true;
> +		break;
> +	case 1:
> +		adev->sdma.no_user_submission = false;
> +		adev->sdma.disable_uq = false;
> +		break;
> +	case 2:
>   		adev->sdma.no_user_submission = true;
> +		adev->sdma.disable_uq = false;
> +		break;
> +	}
>   
>   	r = amdgpu_sdma_init_microcode(adev, 0, true);
>   	if (r)
> @@ -1351,7 +1365,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   	/* add firmware version checks here */
> -	if (0)
> +	if (0 && !adev->sdma.disable_uq)
>   		adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
>   #endif
>   	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index e1a6b15338506..943c6446a0a73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1254,8 +1254,22 @@ static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
> -	if (amdgpu_disable_kq == 1)
> +	switch (amdgpu_user_queue) {
> +	case -1:
> +	case 0:
> +	default:
> +		adev->sdma.no_user_submission = false;
> +		adev->sdma.disable_uq = true;
> +		break;
> +	case 1:
> +		adev->sdma.no_user_submission = false;
> +		adev->sdma.disable_uq = false;
> +		break;
> +	case 2:
>   		adev->sdma.no_user_submission = true;
> +		adev->sdma.disable_uq = false;
> +		break;
> +	}
>   
>   	r = amdgpu_sdma_init_microcode(adev, 0, true);
>   	if (r) {
> @@ -1326,7 +1340,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   	/* add firmware version checks here */
> -	if (0)
> +	if (0 && !adev->sdma.disable_uq)
>   		adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
>   #endif
>   
