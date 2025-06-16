Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89CAC71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 08:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E0D310E2E2;
	Mon, 16 Jun 2025 08:24:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0idMEoVn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F24A10E2E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 08:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RakUt+ZDbQXAkgC3QOzn2+/0HqA/QNE1dvl3wRDTo/WgNEck/ijv+3i0cU4WBjTXmKn33lI1Ak+O7yoHeU7Ced56jOADT+dez9sAy9qsuNRRPAJyTnSCdbA+jkTScjoCiispDXG6PD5h5wEFGRXuYLpqK6W+RWc3mdOoT8t1zu1e6Z9UKueJmMtqH2Owmbw6Sf0IdUkI3ouhPxoLuTUup0CZxkRhzCIxTnOQNwopE9XEgWWQo/QwqwlhEZ4ZsNsPqzpTleWQX963vPiQsLSzm3GDj2j86boipXXWylZtw6oOBnl4PYoU/aqAAgCexC2DgaUQazuqwoyZ/VMMwYVoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW7RRPvXgx6f4ZjlZwkozdctwnnZhbF0QfNOgRs0Y4c=;
 b=GlnC/7xwCR1bIHwHhB5nbyR8Q/kXq8zLgHwtFzDyU8rgrjMbIhKzqoYiNctlwYRQZLCb4Lm/OlElbckMrIYSL5e2gIGBNd7I3dh2CGRIH4ZiWTR7+kmxP4TdDxxlgxS22eItZ43fVmrjZtyYqJg8YKlO6GRO0df1cyNPjbHJJYTCWnDpdmxVe24mzQ1IHl6bL0dc7/VZaKcxqV/TewyeFyWlm0wG3LKddB7HgsfEjjEXol9u+5jLGKc9fDIdxV2OUuOcRnLvYo1zcVuYUEy4/6IWeSnrsfm5a2eQ2J8hXto4F+96o5AkN8Kx/ipsb84mmipWmw2De5ek6z9IEd4nng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW7RRPvXgx6f4ZjlZwkozdctwnnZhbF0QfNOgRs0Y4c=;
 b=0idMEoVnJKgD5yy+YkIzgrQKE6mddGa9uYhWN5OTYIQRjGyErEsgLLo1BzPsM5LCRM/CyfFcIgDPXCnBls+4ANxvYqlnHaqSEWxyCSRgl4u0uh7FQt+TYCFoPKzM+yeSAwXqUatSISe36dzhtabA0q0dvQ+Ne1LTeHTwUtXlBgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 08:23:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 16 Jun 2025
 08:23:52 +0000
Message-ID: <595000a7-9009-4aa2-b4d6-15df58390d87@amd.com>
Date: Mon, 16 Jun 2025 10:23:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Mask out clear/wipe operation if buffer
 function is unavailable
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
References: <20250616082151.28943-1-lang.yu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250616082151.28943-1-lang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:208:120::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f9ccce-66c6-456b-cc44-08ddacaf2082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzVPTTRIQVhPMmRMM3NqTnpiY2o4TWdGalVVVDZscFZOVUl5eWdGM1B0Q1la?=
 =?utf-8?B?MWJUY1JpN1E2cmJxM1pIaENYMFhET2t5LzNnWjN6aE9rU2hVUTc2QzZCUmJ5?=
 =?utf-8?B?bE5idlAyY21qcmtTTitsZHFtbnJKSnptMFIyMjB5Nll1aU96aGRQR2VReXlB?=
 =?utf-8?B?cDBBVEZJM243Z0QvKy83UXBQekhYWEtnb0xEYVdXbWhHcmRVU2Y5ejBRZDRE?=
 =?utf-8?B?SXBzeGhNZGt4ZkxSSCtyUkNOeGZic0NRSExFNVExVDNoYldleGFlODVnanFy?=
 =?utf-8?B?MVBJV3RGbVdpcGJlKzh2YTdjQ2xsaWRaSlBlKy9INEZFTm9wT3ZSNUowbXV0?=
 =?utf-8?B?bVp3a2VqMCtyaXFmdXgzSG1DR1FCQUVkOUF2VjRPTzJBUGUwZkx4UUxDR2Ri?=
 =?utf-8?B?L1JSRGlKZjh2LzJmS1ZibzV6aGpnSG9Tb2xLVUd6MVRibDhZcVcwVlRGcTlq?=
 =?utf-8?B?R3plRW0reXphU3c0RTB3YUptM1RwWjBhb1JwRjA2MGV5WTFyWG9KS2VKQ3po?=
 =?utf-8?B?Y0NUdlU5L21nTHg5ZWNwaU5DM08xNjM4b3dsQ2NaUi93RkE2K3FSUHJVanRp?=
 =?utf-8?B?VkI4cmJiZXpCcUx2NnJBMzd0bTVIWUJGaUhHVWRsQkFkWlpEQklNbExjL3Yr?=
 =?utf-8?B?aVVSUjVUTTFHRXZpNVBaNEJrQ0twYXFRUHorbW5DSE15eEVlU2hGcWtNTU1T?=
 =?utf-8?B?MG5ENWYyR0dJODc0VGhQSHY0MlpPUlhHZmFQdUJCbjBmNjBWanh2Q0hIQ1pL?=
 =?utf-8?B?M29oQnk4S3AzRUY2N1lISmdWQ1lRbXRVeHIvazVLc2puenBWNFZvemV2Mlk4?=
 =?utf-8?B?L0MvYnN2QUJmRjR6WTJwSmFQclNCVllFdFc1Z2RZRkxtVlBQUmlpTURBM21s?=
 =?utf-8?B?bk10RkUvSjhQREJrMWxtemJYdWY4TzRESUFScEZvS2dRSkJrQVpZaHExaE9l?=
 =?utf-8?B?UGNhNVlCQXBQeE5ReFVuYmF2elZqWjlYZzUrSWdOY3E2clVoK2psc2NDNnI1?=
 =?utf-8?B?S3g2U2tCUkVzdE1HcjZreEswSTRqbVJEYjRJb3VXNzhVdmcwYTVxVU1zVUh6?=
 =?utf-8?B?ZCtUWHV0dEhRNWlCLy91TGlQZXl1enh4OUpRSjBxdDdEdWQ4YWRUZ0tNVzF5?=
 =?utf-8?B?UDJJQUZVS09zaWNBYytrSnFsYWRDUmtwSnRrT0dnOG9BTTl5N0pIOXJRVmp5?=
 =?utf-8?B?SW1GV2tGWGV4N3F3eFZDVG9TQ25NWHZ6a3J5c1p3NEM5YnhadmlEeStxenNk?=
 =?utf-8?B?OEtSOU1mVU82YU9OdjZ2QzZpVkRxUTQxam9BUi9WRHYxNEhlQkVISURvaXYz?=
 =?utf-8?B?RTZXaUlEYWtCUENseGtaY3ZZVDBWT3c1aFU4dkFPWGNrRmFMSjhITHN2UElP?=
 =?utf-8?B?TTF0aE0vd0NENEpucy8rUFl1emYyUTY1WWVaVE1ra2lXS3NleEd1Z21Za09N?=
 =?utf-8?B?NXFnSEdydU9Pdy9JOU5QS3gvZ3NZRVJ4aHdvS1Z2ZEMvRTl6VWFxQk5OMS9q?=
 =?utf-8?B?d0xqUDJjNVVCaXhNcHZveGlMQklrUlUwakZQTU9vMUNrVHhjSlBKTkZrdXdr?=
 =?utf-8?B?VXA1SGF1bzU5L0hRK1RPcnkvQ2o3N1VrNVcwS1RzRG85czlJd3JDSUhRNUdh?=
 =?utf-8?B?MWdIdllGeHRwYmFTUndTU1QxaFU0WGkxSllVaERRYkNuNGhOWGJIWkQ0dDNz?=
 =?utf-8?B?bUU3SHljYXlQd2s4TDVqbnBLbG1DeC9lV1YvdFNXZStlNERPS3Fac3pySTFN?=
 =?utf-8?B?NnRzYVJYOVJ5WUpzTUhOZXNjWVNIemhHekM2YUs0djEveWtkVzY2N1JRTVRi?=
 =?utf-8?B?dWRZanR5TWJOS25IR2xqOGtMUkNJWjhZQ2JmSGtPM0NYeC9OdGUzUDIvTGJT?=
 =?utf-8?B?UDBZVHdhdkpKNDJ0WGE2bkFyQ2VTZEdWQk85RkdmSkpNT1pRV3hIdnpJYXV6?=
 =?utf-8?Q?n1WNz/iwzyA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NS8vdGN5UExUU1A0MU5ONHpFZVFqZUdyVWFoUnZRQThRbzhOV1RKdzU5c054?=
 =?utf-8?B?Y1NDRmNDWnNoeUlXT3lITmRNTXNPdHhYZHViUTA0VjdOam1kRkw4Rm1vZWR6?=
 =?utf-8?B?VWt5YUg0RW9yTjFVRkpYU3BwbDRpaFZkZm8xK01salh5N2Y2OWVSUjluTSt5?=
 =?utf-8?B?anVRRy9vNC9haGlBUTF5ZFZjaWtsMjVjZFNrelRMckZWRW40K0FPU1NGdEZt?=
 =?utf-8?B?Z1VmU1N6TTdabTZpeUU5TWVydnRJTEVYNE5LTEcwbUlRVHo0Ni9IZWYwengy?=
 =?utf-8?B?RHhKTUNrVFRXa3dGU0JneUw0ZFdnUXdCL3NkQmNwUksySmFoVVo5SFlVZGxL?=
 =?utf-8?B?TkZ6akM2Q1F2YVM2dEdUWkZoZ2IyM05lb2IzT3d5ZGdCa2lYeU1uZU5nRlly?=
 =?utf-8?B?VXFaM3lNa3gxL3NOOExwS1NRSzZ4ajFTaUVRd1RrdXlaQXlOM1A5QmRvaCti?=
 =?utf-8?B?d2E4R2NNNFFmN2NmWmxUWnArK3pocHJGbHVsL1pBU0szK0VaeFBvT3ZMNUQx?=
 =?utf-8?B?RElZSE13bUJsQi95ZGNzTVVFODFOSmR3bE16M0JaM3Z6Y2FkaW9vcnpYT0dH?=
 =?utf-8?B?eG5JZmtVYXI0K3lQcHpiSHNEM0RrempuNDdLb1VZakRndHRTMG9rbmhVZy9a?=
 =?utf-8?B?ZjRJY2VTN2VoM0V6TjgzRDR4QmFsQXkvT1E1N2o5VnJ2emZGUVhYSE14clNz?=
 =?utf-8?B?cW80MmtTd2FDMDdOdlhJS1kwVitmaktRYk1FMi9jNUVJa09OT2NPZ2w4Tmtj?=
 =?utf-8?B?dnpJTktlVUg1Um1zSG1MZkNhcS9lNFhRMkhZeDNiamZjZEZtL3ZBaWM0WVFr?=
 =?utf-8?B?MVRVRCtnN1NkTWhQUUU3L21PekpBV25MNS9mMU80ZnlsZ3A2SUxKOWtZL0lI?=
 =?utf-8?B?MjQwUXlyMlRxbUM2V0dTS0JoOG04dnh4cmo1RFRJUzR4VjJvbU1WWkxSNkZC?=
 =?utf-8?B?bFBiZjZvWHY3VXZBb2t1aWhtUGdIWkJ3RWhqZjdLRU5GNEY0Yk5KQ29hempB?=
 =?utf-8?B?RDZRYURGYXczVzFwWEJWTUlNZW1UVnVtWTBDNlJZcU5Ea2ZHcVJTandZYUxa?=
 =?utf-8?B?QmVFQi8rNkhJdWZBRk1wNnhWeFlvMS9lWjlPL0IwT2pOZmhEbzA2VHBjNEJR?=
 =?utf-8?B?TVFJdlNzQndmL3NRdzltajhMZEdDcndJQzAwYjRpdDV3RUVHV0N5Q0xTNG1D?=
 =?utf-8?B?eUdtV2ZLdi93YkdIZWE4R3BYSk1xWWtoaEYzUUs0Z2hCUVcrNU5yRFgrc2do?=
 =?utf-8?B?SVRrb2Qwa25JT3dMeGpKejlxNDRWRUJSR2ZIWlRGdXcyWG1najM2bERXa3pL?=
 =?utf-8?B?Zmw3a3RvVTE4Zm1sRGsyMWJBY21TWVE5OXlRSXVRL040SzFNdUkxclp0dDYx?=
 =?utf-8?B?WWVMNHJIc1BSbC9oejZpN0F0Mmg2U09jR3paYTZwZVR4MEtYelA5dTVTb3dG?=
 =?utf-8?B?OXhNTS83ZFprUzVrSURMbUk5R1lIR1VLb0JmNHg4VXUvaGROU1ZpS09Sd1Ry?=
 =?utf-8?B?eDQzRWNoczB2dmp4cUF3elNJQzBVWEFDVnE2YnJjazVQQUxqSWt1dS9RaFho?=
 =?utf-8?B?bGdiTHFVMGlYSzVoUnZQb3VUR3Q0czFFdWpuUWhsdllrajVmU1JZVTN4eWoy?=
 =?utf-8?B?Mk1VMWEwNzRmWXNUTjVlNHZxWHJpcktEdTNsV2RwSUZyclJuY2dWTXBqQlNy?=
 =?utf-8?B?UGJiZjVPVmVTSkpoeFZ2dFB0TnBlbWxJKzZnN1BhWEgxTWNIU3Z2bFpnTklY?=
 =?utf-8?B?ZW1jb3pqaGUxTHBuWWlFQ21VQkltTUNqN3J4MkdJZkJIY096eENhZHBJS1pp?=
 =?utf-8?B?UHc3a0Y3WHNVMktNYmVBK3hlRG93MW4xdU4rN09tUzR1c0w5bEkzYVMyc2xm?=
 =?utf-8?B?Rm85aCtKR3BYNnY0d3ljdXJLMDdUeG92bXlPQ05hQUdncHp3WHFXSWxIZG5r?=
 =?utf-8?B?dHdHQTVoV2tvSzVQZEdKcjVUTVZIL1k2d3kramIxdFIxQ082T0NTeEt1MndP?=
 =?utf-8?B?YWtBVkVFbjEvdkNTY2xmeExlL0ovaXpTYmhkOEFEMGxDd3JvU2VGZWNyRllI?=
 =?utf-8?B?NDJFR2NFYjVsSEoyY2ZMQ1gvK3dhZWtlZmhPbVpjM01ma3BwemlaUGMva2NW?=
 =?utf-8?Q?rwBU4+w/EOtR29lk62ZO6utxw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f9ccce-66c6-456b-cc44-08ddacaf2082
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 08:23:52.3246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BKx3mhHa55K5tNNIH9drf2OW3gH67/+6K+kgvX1mjAetpEB3AMAmgUDUP+WVz+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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

On 6/16/25 10:21, Lang Yu wrote:
> It makes no sense to use clear/wipe operation if buffer function is
> unavailable. It's useful in bring up phase when SDMA is not ready
> and/or disabled intentionally by amdgpu_ip_block_mask. This avoids
> manually masking out clear/wipe operation repeatedly.

Clear NAK. SDMA can be temporary unavailable during suspend/resume, but that doesn't mean that we can skip that.

Especially ignoring AMDGPU_GEM_CREATE_VRAM_CLEARED will just crash userspace.

Regards,
Christian.

> 
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 3ac52d9b9d30..467c8a1911bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -689,6 +689,10 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>  	if (!amdgpu_bo_support_uswc(bo->flags))
>  		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>  
> +	if (!adev->mman.buffer_funcs_enabled)
> +		bo->flags &= ~(AMDGPU_GEM_CREATE_VRAM_CLEARED |
> +			       AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE);
> +
>  	bo->tbo.bdev = &adev->mman.bdev;
>  	if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA |
>  			  AMDGPU_GEM_DOMAIN_GDS))

