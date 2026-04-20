Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD8AF588C2
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 12:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BDD610E57B;
	Mon, 20 Apr 2026 12:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vHsKvcns";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F6A10E57B
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 12:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chuitlKE8P1BVOMj3ZsIva0SUwt9ath5HwLcIJ/Ct7vyOP7HdJ2kwX/5udDwLWOFVBqO70e1dT9mHrebfoj7cVGJD+brImSkw67TxT0aUfxI9YTFmWCTldx2oQ1kV1no19kszRFiSGVvtffuoMwuQyIgiOyFX1MfSomBR2Npj2VGWPLX0CnuzOZy0o6Y8NIC6eIVWx3xxSbLY2ZpRm3TAsv3bYp8lQyIiiqZhdu60rFxsHT+J7t8eA9ZdlYKzQrOQ+3pNWTJLph6E1vArG10i0B/6KLFo73KbMq4+zFjOcB+Lql7PODrVOqb1wQ2mttwNC1GDeFMft0cKrIrgZ+iWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnRVvZhgJf/MyZvDVkmCyYowfMcp+nmwsRsNFgZ7e4s=;
 b=w+DrI33MYc2UXK4x4a/cPNVm7dFnMS8Hu0EpB0bmnvowu20AqIiPGWORt7HNittHe3N5qkxbPsyfiBVvOkCVv86d4L7zXgA/RLHfXtavsdiPyrj4S8It1akjdEVULg4xHaw0FRnFRZ69TNsoOe1mhpO798OuHRynzK8eFrr4W22IICjj7BzTAx+QLVhvvwnbkdEk6SnU+bfmBmNm9RijnafH1+tbLY+4qzqq6FDzE7FrLMkxh2ugLhWXZ16Cm2n4nsnLjJdEhuMBnFsINACdZnWI/IR4KDQXNDlnW7NBs01GxmJWrXrHta+CFF0BqWWiHZ1lSYJ27cPL4vgaUsolTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnRVvZhgJf/MyZvDVkmCyYowfMcp+nmwsRsNFgZ7e4s=;
 b=vHsKvcnsTvsDguXe1XjNCM+H3U357QAEKCzfHlOMtW0hQft4mr6K0ntX1Kx65RROCDupKU2zBiGwGpAqR4UEGuzyoX6k/9jwk4UmKaZ9xsdk3CPvHUl4zu1HpqJsEys7bXEkh9XO222oLwd4e3H4FjLx+7VwI/rLVWQ1+TNtyvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by LV9PR12MB9781.namprd12.prod.outlook.com (2603:10b6:408:2f6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 12:24:10 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 12:24:10 +0000
Message-ID: <31edabfa-8f59-4a1c-b301-0cdbb27eb22b@amd.com>
Date: Mon, 20 Apr 2026 14:23:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] drm/amdgpu/vce1: Remove superfluous address check
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20260420121044.155030-1-timur.kristof@gmail.com>
 <20260420121044.155030-5-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260420121044.155030-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|LV9PR12MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: d76c6ddf-e3bb-4b7b-030b-08de9ed7b9db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: ddpL6qV8Trw+trXNtHRTg47J74S/Fv7dM5ddUyRUEF5E7EBqNWRjnDvgnM9zvsRwYBG6nN3svjqjDJwfZDNpedVeyBbHi2a9xaxUUbZtMGdHyqCrFO4otomB9XtFk0Jt9kSPHRJSJD9vCZTArVL1PF5Op5J/uj5EE2xkm7znfVGEYAdmIDvLd+WCWz3hdi2OudDVxK0qWmZASw078Y3ZVG+IFocl6mOIgO98KZEKJb15I0D+KTDP8cP/ZdvTE9XhO2ODbI227Uo+AikNIlH5XFgwIaPlg/bUrk868xPt6ZtX92alKuTEbPlZ+7BUUZ41EYXVtE7GogrCCvU0woJy718iBTQo3r/+6L9vkfRz5cAnBPWWxSqgltmdCSsSYt+toPEEc2RVeoFwnT4sKjF4TKkjqyahz2Vscs7upZT3wOOJbaHmrnzrbW0Tx0B3MnZsxPxLMPS/JiB8lt7IXyKMlQya0SBkXsRFjWiPF2JbmFIlTfgpPYBMMvJ3CRFeYHKewu8DRgXljUgtVM0tlB/ejudXWY8UtKNSqempXQfA4/p1ZwXLi42ufMUSkloTwxpCVEZSoVlmQngnakBD0J0huZ+VSTGJ2EqCStWffRFs3yOZX/GZ5vcmN/K6rhMG1adUXVDJcyQbSE4yUptqVPTZw/PcM9w4lDJVuZOqz5zv/YhCqbGCycj2AN2GNQ9CSbjPD5c67CqmBfSwY6Zgnt69SQNCKeAdTEWsBkdpuJZNtys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2hPb2QrSDUza1htMGdkUStOV01tbzl2bEV2UUh6OGl5bkU0Q1FEQUJveXln?=
 =?utf-8?B?NUNvT05sSjVHMlZpemJkRGc3K0NaMWVTUjZhQnJ4dlF2Y3NXbjltWnQrdnNV?=
 =?utf-8?B?bktRYUZVQ0kxNXlOaVQwaEg3L3BROXpjTXZXNGlPQnk3ZlNPYXIvWTBFMUVx?=
 =?utf-8?B?ckJSRHIxQ0puRS81U294SEo1K0l0SitiU1RTdnppVkpHeDlGcFUrOEU4THJC?=
 =?utf-8?B?RlpiZXk1MnpFcDJKSnAzNk9oVjFWT2R1MFM1V21ZNkJKNFBCWTBKK2lXeHdu?=
 =?utf-8?B?cERXelFycjduK3ZGU0JPU3NOK3MzWWEzRDQ5UUJwKzZnZGUzcnozdzRTZmlm?=
 =?utf-8?B?eEtDZVZObndYZFBYTXNNOWNBV3NncmhHN1NscVZVcHUxVHJhMEZPN092cU1K?=
 =?utf-8?B?UWlVUUtzR2hKeURHQXhZRzVNblFUODgwT1RHWmQ4TkZHSG81cE1waWI0a1VC?=
 =?utf-8?B?eU9wd0x5Q1hIeTh2M3pZOENSSlVOQ0NITnM3L2lmY1V5dnFuL0RzblBWM3BE?=
 =?utf-8?B?YThFV0tCUG9sODlJV2VIZ3BtazkyTjEvYnovQTNrdXFwYjdtamd3NjRJejRz?=
 =?utf-8?B?RVl6cUZzV2ttcEZ0czRWVTZ5eFdiVzFWVWFJb2I4TVJ5OTRMMWowditGUFlr?=
 =?utf-8?B?N0FqcUowb0hQSFRVVWdYWHFwVXBiMmUvUCsvZ3hZOUtVcTRZMjN6ZVJ5SHZZ?=
 =?utf-8?B?Q2RKdC9pcUtqRHlzUlI5M2NiaG8xV2tOeEZxOFdsNlBBVDl4eU1CS2V4aVph?=
 =?utf-8?B?Y1BqN0lCYVRrbS9CUFhwZWdYb0xlblhTSFRKOW00UDJ6aklNSklFaG5TQnZZ?=
 =?utf-8?B?dldJc3J2MUhESkJPSklLUTRwSXFYVkNWQ1dpcC9CR2dIVXZtT1lkYWFTMUZO?=
 =?utf-8?B?bkRHYWFBV2M1cmJIcHVEcVlNclVBZDVFYXNVVlhyUmdOakwwaXJpUG94NCtk?=
 =?utf-8?B?UVhKV2JyY29iOFdnU1lqeTNOSmNNWm5uQ3laR0VPVW5GRjJuS3Z1WmxyakVR?=
 =?utf-8?B?ZmJHdkE3WDBLaXRtU2ZXS3BsMFJ3SEw1a29EendWVnRBcll2MVpKQ013N1JI?=
 =?utf-8?B?S0JGUVRwQkZudTNTeXMzQmY1WGU0N1VDQlhJM21ZcmRIdE1RK21PRzF2SEpp?=
 =?utf-8?B?cEtodDVXcnpDUkdaK3ZrZ1ord0FLQ3A0Um9HenFiVFRuUi9Xa1NlL1ZoMGRz?=
 =?utf-8?B?M1ZFaEZSVWFva3lFUEh4aXRHU3VoUTBxWFVwWWIycmdUaytvS1hQZENRV2VD?=
 =?utf-8?B?bUg4ZDR2cFA0ZngrVXlqQVFYVmFINEs3RkdLTWtaakY3QmFsZ1VJdWtER3Zy?=
 =?utf-8?B?eVpOMHZxNm4relNrY3lpVHRoNnpMUitNTkxiWk9ad3VwU1EwRTV5Tk9TYTBO?=
 =?utf-8?B?Q1hZb2k4Z1dqY2wzaDBXOStUcEo2MUxKTVNEYWo4dzQ2YU5VR215QXVoa2gr?=
 =?utf-8?B?a3FuL0ZOTUZLenB2L2psS0F6MjNZaVREQ3BYYjJBNFZYTnlTWHFIT3NzTTlY?=
 =?utf-8?B?cU5lYmswUmZBbFQ1LzQ3ZEpxQmRJczBMYnNJK2VvZGs2SVJienJkdVVoWHk2?=
 =?utf-8?B?dTlwdHhRNU0ydk1EOTh4a3MwdUtWVEcxTHZsTGpnV0JKNmJRNXJHdm1nT0p3?=
 =?utf-8?B?ZzVxcDJFbkFOcVlURnRJOFF5VER5VU51TWw0d2pwWXZrQWVQbnc5WDlpQjU5?=
 =?utf-8?B?bDU3L2U5QWR5RUlyVzJsaExzVG5VWFVQZk40N1NuSU5RU0VZcGhuQlArQlhm?=
 =?utf-8?B?OUlmZys0VFJNZWlRcDIyOWNxUXcxR3cxSE5WdlBaSnFDampsbTdvaVkzVFFn?=
 =?utf-8?B?YmFkTWxsRXQwWlpyZXJ3c25YOFE1QnRmNGdhNzJ2b20rWldSbGtTTDVic2xt?=
 =?utf-8?B?T3k3NVJxL3hOcFdUWXEvM3Exa1RueXdFa2N3eHkyVW8yVVNCOFliL3h4blFT?=
 =?utf-8?B?NHF3ckxMbk9naDNjeUZzL2JjVExKbjk3NDBLU2NmQnhCbE5RRi9YekNhU0dw?=
 =?utf-8?B?NXZLelRoekxmbmF2TnI1bWlpSjlHYldOQTJVM0dEam1VZUUwYUdVeWtNcVRO?=
 =?utf-8?B?Mi9BempTL1BHMityVUd3SkMraUlkZVRQV01YMTNUVnE0ZkFweXZEdHVnR0Jh?=
 =?utf-8?B?RDY5NEREdnhXZjFHMjN2Nnd3Nlh2ZllFdlBBQm1uTkRWdzZsOHJ5dzlWQzJL?=
 =?utf-8?B?a21ER2NpTGM4bUdWYmtFa21aeVVCa3hPSXRYcnZaSnIrV0M0VUNPeHBuTVBt?=
 =?utf-8?B?VXlZUWI3QVlQMnNQZytBTGlBT2JnSFE2am5LeEVTOWZML0FreXZiWFpkYUxy?=
 =?utf-8?Q?U+pcgSA+fCNA5lWKCJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76c6ddf-e3bb-4b7b-030b-08de9ed7b9db
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:24:10.8248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DbRLZ6HwVwYATnKJPEImZ4TYRS308NpUbnzYc4AQvVZ38FY42zUYk/78QXnBQsz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9781
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

On 4/20/26 14:10, Timur Kristóf wrote:
> The same thing is already checked a few lines above.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index ce993b57b0e9f..35caef5a8102e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -553,8 +553,6 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
>  	amdgpu_gart_map_vram_range(adev, pa, adev->vce.gart_node.start,
>  				   num_pages, flags, adev->gart.ptr);
>  	adev->vce.gpu_addr = adev->gmc.gart_start + vce_gart_start_offs;
> -	if (adev->vce.gpu_addr > max_vcpu_bo_addr)
> -		return -EINVAL;
>  
>  	return 0;
>  }

