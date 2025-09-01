Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EBACA0FFD
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 09:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4353810E3DE;
	Mon,  1 Sep 2025 09:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UAnUh1t/";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2AB910E3DE
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 09:15:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=td84QrFViT8VxKD/l8+vBpjI+evdo5QdRK919eBmPVPKUxqlyZpzibQ9eZBCIJWsRX5QnRVCE/HdpAyxlIMn7vBfGTml54RJ3j5UeG63DLjeVx8QfldfjCE9Ds2QmO5pzgVaTn7eLFAuZzLa8M3f0432+AtrMW+eyBq6yp+hsjtriv1gKZGzrxjZhwsG8XHanpUdJwvZo7zfBefvZz/Sxa+jB3VlsRnCD+OfBl9QuZ8XJ+7tMHih0Ac0X/saLJhipB6hA30ote7qOVN2JTaBa+8AJomS8F+CpPJTUThpWGL5AFJ2hMR6J/GsXpvohnFpCGURMw3zjhAbUmDAw7ppew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqZSaoijuTD1OP0lZjb/zOAB6EQzgEjYmsBUKNa/WLc=;
 b=h4ac6+D7iaSqwzsBCl36p6oWVeLKXd0vBaFX9qc0CoCL1MBZCDAhl2dgvITjzwNqOcTDRpTQYCNXovWxTAWhnim0C91sNjaQcokLCdLlM9zAgsR093redvx14Eqer1/LRKwNTrtGdibydQ0Vn9cHN9j/IQNtcfi/qJT9qvyDNq4uIFQ1FsgclJ9eAuxSfMxnP8boYBlxznNJ3Gc+deh4CI7OdoH6JZSrhv2sUB80LBrN9Cxduiivu1KX4a/uioC6qP0EOrNQRPqjysRZ5XkZplhRZkMnvcsPIE1V4KlKspMe1oTi1eWh2vLxuZNcsUvyWLleOw1TCUq5yjfRXEcIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqZSaoijuTD1OP0lZjb/zOAB6EQzgEjYmsBUKNa/WLc=;
 b=UAnUh1t/GiDheqpe7SXdGq4Te0E7C3EpY3wFNytajSjJIBftJpmEg/aq3WTWun3iCujB0S6KmeO7N+Bty2ppuyX8cPnSE83z6s8FtRToTKZy6r6csMzM8Yy3Rkhx0yOExdpu04thOeZnmgEUdAaY0UrrxNvpUgzIt4Hiw83RmF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 09:15:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 09:15:24 +0000
Message-ID: <617d8438-2116-457c-bc4b-8cbe15628f7d@amd.com>
Date: Mon, 1 Sep 2025 11:15:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP
 Heap
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
 <20250829135523.4032168-8-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250829135523.4032168-8-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0028.prod.exchangelabs.com (2603:10b6:208:10c::41)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f68e195-5116-4214-b09d-08dde938154b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1RuUWtWSGdyMEIrZ0FRTU02WmhhUHgzQmxPcDVWZGlWZ1VSOGh1ZktQU21W?=
 =?utf-8?B?UENUVFpIWkVtWk41eDU1M2gxQ2VqS3R6Q1NFRnZ3cWJEWGg3dTV6d1ZxOUhO?=
 =?utf-8?B?WGFIZ0NBN0hyb1IrQzNvRjcxUVEzR09oYnFXa3ZyczJKNkd5WG9QcGx3NWFv?=
 =?utf-8?B?RXRSN0dQNHl4cWx3TTlUV2ViSitMNVhXdUgwK1pKdVQrUWdzRmYwTWhhOVQr?=
 =?utf-8?B?aTk1cmJwN2ZzUUtOdkxpbFdvVjhHdFp3RkNqRlpPUFhiYU5kWjZTRmdKSVFr?=
 =?utf-8?B?aEpzMkJuUDg2K2g5UDhaRHZ2bkRqODEveTZ0THFnRm93SXFsLzJ6ZmpaQkZ5?=
 =?utf-8?B?R3NHWGpYZnZqRkJTUUZBZU9lMTdOQlAvY1dHV1JqTFdNeSs0RVdwcTExK1cz?=
 =?utf-8?B?RWlULzdyemNVQjYyNEZLU0FSZ2ZvMTBmMmlRUTA1cnFJYkR5M1dYMUxxWUFk?=
 =?utf-8?B?WlR1TzhWbUcwSjdYWDNkNFlTKzNsK2g1RGFjeG9aajZleGFUelpZQWRKZktC?=
 =?utf-8?B?WEE4eHk1QlVZWDdNMER2U2dzTmI4ZWRFOGEyQkRlTHVrdGRTRjhVZ25JR2VB?=
 =?utf-8?B?WkJQVmhzMXZmemFPNlAvMGtNYU9ia0l0NG5QaWxvcWRjcTdQK05abENYRkc5?=
 =?utf-8?B?S0x0UVpEL2RuTWkxT3MyNDRGcHU5bUNqYnVMOGxtQWlGblZlZlpvL2dUTjgw?=
 =?utf-8?B?TzByWUxwRHFsWW44UUR6WVdRazlodWtMVGtvMVFBMWtmeFEzRm5VUWxwY0d2?=
 =?utf-8?B?TUx4c21ZcnRnelAvMlR1N3UvL0J2KzBzRzY1Ti9zQ2VyMFlRTEp6NWVnNHRU?=
 =?utf-8?B?MmR2Z0QxVEhuYWdTbjQ1aU5QQXVLT0hKSkJ3QkZKUHdDTll1cStPbFlkeHJG?=
 =?utf-8?B?SmtwRlBxb1JRdktnVUlrSUFxamJxcDdyOVlzamNRR1lJQThVY1hPUUthdUxm?=
 =?utf-8?B?QjJLYmRmYjNSNjFacCtuSnVvdmVEaThjVUJjWEVrZlNNb0VlRnNGWXNNeEYz?=
 =?utf-8?B?UlY1VGczbkJDSXpISnNPMm9vN1NZZkRFakpqYU1nL0hNL2NSd1RIRTJ4UXBt?=
 =?utf-8?B?V0VpR3JCd2ZpaDdCOVRNVzFXU2hndktrcGloaVpRaGtOb3hGR0s2eDczMXlj?=
 =?utf-8?B?N3p2alYrVjFSdE9CUE13T08vZ0RnYVpSaVZVUGI1dnhIOHhwc3U5T28zKzZv?=
 =?utf-8?B?cmpEQ2VsYXdFNmVhUUhSYTduNUtpZzZFOERua2hzaVh0dU0zOG44ZXcxSVVL?=
 =?utf-8?B?ZkZxYks4eHNobE40VU5Nb0hWQUxQS3FDRytLU1R2ZnFsSnJSWlBWa0RpRU9V?=
 =?utf-8?B?VU4rMjdRamlVWndZVHdRczgxdVFFL1dFZzQxVzhaYXBBVEMySDRkUHJhSHIr?=
 =?utf-8?B?cEI3MFpvcEI2NFJvMmdDVHRaRE5QNXluWHNYNlRkL0dTbXUrdnlsaFYvdEJO?=
 =?utf-8?B?Vzh5RnIzYTg0U1VDRkVCbkVuSktXVkRoc2gvRlJBNWpSM2xpY1A5OUN2NEVV?=
 =?utf-8?B?YlQ2WHgrQXFVcWpuUEwzV0xNUk9ROHZmRWZCdWlrYmtWZWhmL3ZST09Odi9R?=
 =?utf-8?B?bjR0TW9QbGJRY044UVVsM0IzWG9KUW1HT3h1ZlhyOGlnUlo1bjNEOVpmekRs?=
 =?utf-8?B?RmJ4N2lKVmJpNW04WGdzUE15Qy83Sm1tQ1pWeTc2TCtoc0wyKzBoc2NZdVda?=
 =?utf-8?B?VDg0VExlaUgyWUQ5ZnpwbzlyK28rbjJTVmRpWUhCdVlUd1d5Z2hhNW9XSGNM?=
 =?utf-8?B?ck5nRFJEd2V2YXRWK1h6WUwzbHQ3dGFKS3NLeTVLVmhOWWEwUWFqS21aMFVq?=
 =?utf-8?B?Q0FaUUZwMXZCYzREUGVUVXZUNHcrZHA3bG9kNEE1K1JzQU1RcSszaGh2Q0Ir?=
 =?utf-8?B?WCsrZ2NOeW1BYkFiZnZlcnovYS9mYmtxblRoTUVwcHIrVy9NbTY4aGhHVXRS?=
 =?utf-8?Q?rG1R7w2O3GA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzFNR2Z3c2d1ajFWTHFJVkhnOHd0QWZOYUN6UXAwc3dJQlIreW5Cd1FKNWRy?=
 =?utf-8?B?WXp1S3RuZVBkN25waHdZT3RaNHV5OHRtZVVVTm5UMkZzejVOQmVkREFKdHBD?=
 =?utf-8?B?M09vSHZyc2pjZmQ4WllqbXB1dXh1WnZRa2psRGJuaGZzR2xpMDJmbWxUUWpC?=
 =?utf-8?B?ekJUdVlkbDk3aUlZcm9PNHNBb2dPQnZyWGllZnpSNy9reTU1dmZzMk1oL1F3?=
 =?utf-8?B?UkZUeCtzK2p3bVI2MmdvcktnaGFtdEhBZHJFS3RvQlFFNUJvZ1BlaGQvSWt5?=
 =?utf-8?B?Ylc3c0ViaHhNZTRYWk5SNWVobGJwdUZSUGN0S2Z0RlF1T3pCS0JiV1NObVdM?=
 =?utf-8?B?UDFka2RsbUVoTzlFckhjdlpUSkxUKzJUcmlxOUQweDEzWnhYVVhBZjFCME1z?=
 =?utf-8?B?YnVhV3ltMTJqbGRmeGdpbXpzQzVYbFQzVkFnRm11aHRBOXdpUWtZN3Q4Nnhq?=
 =?utf-8?B?VEsxSGJpalB2WUlWelpZNzk2YjllSHFDZjBGbXhEdGNwU3lGZm03aUFwK2ZO?=
 =?utf-8?B?T0dxRnpxMkRrZXMrRFNTcU1LM1FUZFdMNkl4eWtIdmU0SlhtY0Nxc3RHNzFG?=
 =?utf-8?B?cXB5KzNoaE1mTlNpV1ZMSlMwTkw1NGpBejc5QVAwbXNEd2lRcHFXS2lwdGhZ?=
 =?utf-8?B?QXh2VXZManMvOWNIS29JWVNzVlFLZzdheURTOEY2bnI0SmxKcHM3SGh4M2tC?=
 =?utf-8?B?WjFVUEhWYVRtbkVnZFZNbkRqdG8yZjBtQnQ5UVZjSkN6TDg0dGw5aTBLMGJT?=
 =?utf-8?B?MVVhR3oraUxEdjd3RjJWN1VZRHJhNXJtNkJXeCtWT1NPMnF6YklNVnVNdnpB?=
 =?utf-8?B?a0tNcW1veTd5bnF1ZVhDUVNVQWZvUmpCRTczcjhwYTQxbmo0eWhxbVhsNzBp?=
 =?utf-8?B?Q1lDU2dIRGRQY1pGNmZOWG1CUVhPcTRRU1poS05nS2hOV0xNbFR3OEsyV2dE?=
 =?utf-8?B?MVlxUU5aUlZOYmRKN0ZMcERTWW9oL1dZaUZoN3FmenM1SnhJbHRyeTJLbEFw?=
 =?utf-8?B?ZmpIN1pQUk9NK0EvWWtyUXVmakFGQW0rdUo3REJYSmdQN2ErcVAxT3duTEFy?=
 =?utf-8?B?Rzg4UnN0dXNXb1prYVRha3MxdDZZY0ViUkplRUhCNUp5NDdFaDI1bmp3OXNR?=
 =?utf-8?B?SzdTcVJBSEtWaEJLUE1WUys2NzFTQWxqdWpOZFQ2UVNSdVF3UC90RlhhRjhS?=
 =?utf-8?B?aGxhZHQwdWM3WWZwazJTczNCVWpvRDFDTndGMlJwdkVyQmYwMVZCT2NDVWtJ?=
 =?utf-8?B?Ly96OVVKcTlZWEN4NWZxeFZoWkFWbTRMdGVBeElCVXdkY0ZZWWJ4NjVQOERP?=
 =?utf-8?B?RW9JWkdKak1tQjRlSlUycWlBYUhNb3Z2T1N2MnM3KzJhWWVtd2pmWXUrOFpG?=
 =?utf-8?B?SXFSd09FZzQySDVuK0diUUd3ZGZPSE12elBhcFB2RGV3VEx6SG9XeVQ1a2ww?=
 =?utf-8?B?dmcyRjFmVWVWb1NIUG9jbHp3WWZmODgweE1vb09VZ0VJMy9QZWYwQTg1d3dl?=
 =?utf-8?B?WGZRNUF1bGFyN1JtNXFBcXBSd3dFWlVCaGtyMmZ3YVVOOVh2MXFxYmVxVFVV?=
 =?utf-8?B?YUZtZzJkMS9OSzA2NHpwMXVYTStmRE5FUExndlhvZWxzUUxvRFRtN2lmUW1M?=
 =?utf-8?B?U3dVT0I2S01xRk5zeUh1eFpyMU1jNnFreEM3VEliRXFZNkdUS2I4cXA3dEIz?=
 =?utf-8?B?cDRrVkVHSzN0RVY5MEYwMWZ1bFpJajNpdDZXZXlmb2JIL1VkNTNsTnNpamJv?=
 =?utf-8?B?MjkwaVpsODNaSU9lQUQ2eFI3czVFQVg1a2JpODNRZUo4YXp1V1VxS3JhSXB4?=
 =?utf-8?B?SE11a2RHSVZackZlNm9ZUXlJVzBEclVHMmd4TWM4cTJSQWVGSmZtUm1zNndT?=
 =?utf-8?B?RnIvYzNIMkV3cjF2TEtudmtqb0NvclNZZmdpRWVRSmROMzFMRUVNK2pQMnhJ?=
 =?utf-8?B?VUVIYzVsUXoxK1NPb2xieXZUeHNHVXZIUUtOb01qZVVKT29HamYvdEtnaWND?=
 =?utf-8?B?ZVBQYVVRb25iYXdaTTF4ZU1oNHI2c1ZvUmU2SjVlR3NpQWp6RS9nUEhTU0pW?=
 =?utf-8?B?VDYxai9USmhOUmtqTEUweUFUWFRacjdpa0dDWmh6YWs2NGdqazZNakpzME9z?=
 =?utf-8?Q?QTKh05PBsM2uY/zGJZS3lB1U5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f68e195-5116-4214-b09d-08dde938154b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:15:24.3453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgPp2BR9uHBP2aUMcNKnwbOv6J0STvNXqpDXPBPyKU4VQkqG9jMASbB56Tf4+Yqk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
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
> Add a one-page TTM range manager for AMDGPU_PL_MMIO_REMAP via
> amdgpu_ttm_init_on_chip(). This only registers the placement with TTM;
> no BO is allocated in this patch.
> 
> The singleton 4K remap BO is created and freed in the following patch.
> 
> This split follows to separate heap bring-up from BO allocation.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 5f378f5c9350..7305d40a62e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2020,6 +2020,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  		return r;
>  	}
>  
> +	/* Initialize MMIO-remap pool (single page 4K) */
> +	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_MMIO_REMAP, 1);
> +	if (r) {
> +		dev_err(adev->dev, "Failed initializing MMIO-remap heap.\n");
> +		return r;
> +	}
> +
>  	/* Initialize preemptible memory pool */
>  	r = amdgpu_preempt_mgr_init(adev);
>  	if (r) {
> @@ -2082,6 +2089,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>  	}
>  	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>  					&adev->mman.sdma_access_ptr);
> +
>  	amdgpu_ttm_fw_reserve_vram_fini(adev);
>  	amdgpu_ttm_drv_reserve_vram_fini(adev);
>  
> @@ -2103,6 +2111,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>  	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
>  	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
>  	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
> +	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_MMIO_REMAP);
>  	ttm_device_fini(&adev->mman.bdev);
>  	adev->mman.initialized = false;
>  	dev_info(adev->dev, "amdgpu: ttm finalized\n");

