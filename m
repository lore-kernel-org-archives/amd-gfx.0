Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4713AC8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 07:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE3210E9B3;
	Fri, 11 Jul 2025 07:17:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xk84iucH";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA3D410E9B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 07:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRG9jQ4K9x2GtmBln3uo5bPNSrweDM0V4VIN9Nm7RgloDe8NS1HZYbJfJ0gD4qmNJlZg4xGULLMVUqb0ZK4FaAJhBdhoeL+lQYyO36XOvt+ebg8W99EmqKjolbLMvsigFDKGuc51iRwMj/Kx5h+BM+u+fzwun3Xgbrq8KN8NZdUIfBWIChLP/4f5go/zU8pTTfupnnVXCJc8rCYqVgOt9SpnPNZ4ptq+wArwJOzhnP8ft7ZtSWyP6GgpeqH+zeB7iTQZl5Fkx1UQOgr86OX7TlHoi1LiDJd0fvgLP7vmMnc54afSP0gey5iVxD/1Q0SvFQf+zM+M8gL9NGVP5ajx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n9GSVA3Yt/kjzyB6Zx1r1IS5/cExpUm15FNW4jPfCY=;
 b=P+VlU9ocrUVmvUogBHoFT3qfnApmrlifyvU3oz5fGI9G+lgZpwf7HDCwB0+XMPLxEQKg52U2ck3DqEOwe3QkMZZOyaTSlRCJF9ojm63Vfc/V/FeYEmd7JIdRSnjnmliZLeZr6+WA26Amh+gXrctovi4oKef1JajnoKCvSq4tB5O1Lh8h1hDdpxvjZe4uXtJa+siKdeGL/GhmNC3TlFfUj4ULbvmJHYpWQxcX/6+ng6aR4KAFc9P9mnq9MWKuMVLgVqNlIgZ065eCTc1nTmcHfD+onF9Vd08vMtfofFMTq4fRCsKQeKm7047JdseFWZ9/Bg7eCKth/ZhiqbbHA9uRiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n9GSVA3Yt/kjzyB6Zx1r1IS5/cExpUm15FNW4jPfCY=;
 b=Xk84iucHUMYi3Y7X7GIEzP7clJHSdupK2431ctmSMc/IL06/9p++TJMiOUGwNm3kkQFlPFIh5ZhISiw5wwIHeECJBDorpxshVXXuzw5zQRX844IULl2lC8pd8TyI1fK8ZGuzWZ3S1TaUxDsaIn1moOYMwH4XYsUoSDs8Av9tlWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 07:17:08 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8880.023; Fri, 11 Jul 2025
 07:17:08 +0000
Message-ID: <46073fea-6d57-4ad1-a835-6541c4360a78@amd.com>
Date: Fri, 11 Jul 2025 12:47:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: refine eeprom data check
To: ganglxie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tao.zhou1@amd.com
References: <20250711024059.25658-1-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250711024059.25658-1-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0028.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b7eeed3-942c-40a1-11ec-08ddc04af224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0g0MHMxOTJLU0FjOFV0Y0YwSjFvYmUyNmsrQVF4R3pyYnRybk95akU4Wk4y?=
 =?utf-8?B?czZ0TThyajdQcjJMaWM4VGFBd3M4dDR4dXFVT3FESysrNUNKZ1VydFZuZnZq?=
 =?utf-8?B?ZGRKN0ltY05BUGFkbFNQOElTTWg2bmU1eEU3dzgzYzc1VjhqOXZoU2dzVjdx?=
 =?utf-8?B?WlZXSUJsd3Mzd1ZoTnNsbDZjcC9tR0M0UXBYRTYxek16VmUraW5LbWhGVURB?=
 =?utf-8?B?TThacUF3MG02WDJodGVtWWRTUlJJOWh4dUFiNWQ4eXMvVk9HcGJoVlhDL3Zy?=
 =?utf-8?B?dlZYaXJwZXBjUGdVUHZlbGl4VU41MloxWStmbEFyK1BMUlk2Q29uT0Vsb0Zh?=
 =?utf-8?B?ZlRBbzZYQTAxTkRnZzdDVW5KY2Q2TFNRSzA5dWM4WGFVbldET3lRZ21nMEtD?=
 =?utf-8?B?MElOY0tNc3I0czJUdzFrcGt5VEEySzBzQ0wwTXFwc1E3d3pYQ3FJRmRDRXdP?=
 =?utf-8?B?WkIvZEFzT2pSdkZKeXVGUk1OT2had2NqeW1RR1d5bzl6Zm5lL1REVkQ1RWJE?=
 =?utf-8?B?R2RxdWowS2o0T3FmRFo0SGV2azcrUGcxZFd0UXJZSUdtSVRhWlJsU3NWUHVj?=
 =?utf-8?B?N3p4N1l2K1FzWjB0cTkrS2ZLZnJKa0lxd3FaeWpGc2U4cEFndWZTZW13Unl1?=
 =?utf-8?B?RkVyNVdYUUtjdEI5TXpRbmpRc0pDVm56bGpYR0ZhRVltY05aZjVNNml4QnBG?=
 =?utf-8?B?cEc0dnliOTRQWFNVSVg2NVNpS3l3VWNrUlhSYnVGM2RzQ1hIUGtkcWdmdlVS?=
 =?utf-8?B?YTVnMWhBaXVZM0lNeWw1V1lyOStsOTlURDkwMFNVemRlZ2FmcTVML0RZdS9F?=
 =?utf-8?B?cEhaVVpjcnlmbXRHTWM2L1p2WWh6QmViL1BGOFdlNUpKWWdQejRWSERDS2Z2?=
 =?utf-8?B?RHZYVEJHL2tiQjdkZDlsMjM3WjR3aHI2VTBKd08wcE8vZWJ6NVRIUk4vRGNK?=
 =?utf-8?B?Wlo5aFpMTUtrZXYxcDB2M0xJVjIzTS9GZHdIN1RxWlhVS2c4WDdzT09FNzJp?=
 =?utf-8?B?RVRPTHBCYzlCOW9IZkR0Syt1T2tQZUVnQXA2QWNjajd6QmVia0VnR2JabjZZ?=
 =?utf-8?B?bXJqaXpzWm1kYWpTeFZRam9JekVMUWI1QS9FeUc1TzNtSDlCNzBISERPUU9s?=
 =?utf-8?B?bnpIYzE5bmlVZnBpUTJnNTNtV3A3RFI3YjJmT0Q4ZDlzMmVLazZXYm1EOWhy?=
 =?utf-8?B?QzZ3OHRpanVady9kZmthMVcvMndmVWlNTm9zS094MVhaZlZYVkpVSEIwc0dW?=
 =?utf-8?B?Z2lmb1BoZVNTUTN1akxkTUdNTTNlSS85czJjWEc4YjNxR0pYMThFUkVLcEFX?=
 =?utf-8?B?LzA3K0d2Tmc3NXlPSWF4RGFWc01UUytDZDNadWNZWEw2aWVNZ1l3eVNaT210?=
 =?utf-8?B?VEErK0M4QXpwYTFNUUdUOXJiVXJ2M1dWaWFIMUVwR25iTzBaSFB2OThVemVT?=
 =?utf-8?B?RTQ2VnA0TTlIdE03bUVNSFhDZ21GY1B3bXBVQ2QyUTFYNVg5alM3cmdaYlRX?=
 =?utf-8?B?WTUxcmZzT1o0WUJOK1VFVEF3TVJHL1Zlc24rQkxobU9ham9NVU10UDdjZTZO?=
 =?utf-8?B?MGhVQlNpeFFpN2dnLzdwQ3l5UUtROVJMbHFsbjR5TXhTQW9wcUhyTmMydy90?=
 =?utf-8?B?RkY5L0M3MERVS2dMbXl0eW5CeDBNRU9MeEpRNVUxS2J0ZlY1NEFndFdmZ0Iz?=
 =?utf-8?B?ZWVlZmQ2NWVyZ0VvSFVJV0srVk52Q1BIYWNLWTl5bkFKNC96WDl3NVYweVVH?=
 =?utf-8?B?elY5ekVuR0M5dTNreFNkMWViYVgzU1htM0NkajBrczlYdWN3Vk1OTkc4OXd5?=
 =?utf-8?B?ZXpUQXNodEE1YndsYk1uZnRqdGkvbU5TSC9IYy9DUkV2SG5uVURmcmZaU2xF?=
 =?utf-8?B?bFBodGxPS1dXYzFYNnNYRTJwRkZrRDA2aWNSN3NZNXRHR0Z0cDVZN3lmeVcr?=
 =?utf-8?Q?V+TcMpL0y9k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGRmeXB4MHk5bktVRDJqYjcyOU5TcGtDaEVZQTZScmIwaGlRQ1d5R2NXSjE3?=
 =?utf-8?B?dUx2OXJQWFRrNGV5NGNCcmVkNCtMbTdSL1pSaFI0U0UwVGdrWWpiWWZvRlF6?=
 =?utf-8?B?elN0RmVBcU5EQVVoR0R0Z3RsYmxQSm84c1JFM0lSZ2JXcVpPTzZORkg4WWk0?=
 =?utf-8?B?RlVPLzRMTjd6RTdFSzkrS3FPallmcmxPOHIvZHVpY3lqa0NtMEdWM0xhNVpH?=
 =?utf-8?B?L1NRdnkvKzlkOFllcVEzendoL21sM3huN1hlRFB6US9mSVdlTFNOL0lFaHhv?=
 =?utf-8?B?SDBqRlI0WWF4YmJvN1pqbUtGMHg0Yjd0MzdrQXRNWSt3NlBNdjNHSVFPc0hZ?=
 =?utf-8?B?RVBrN04vdkNpakFTekQvdHVmSkV6TjI0S1ZUUUI5VFY3UUZ6Y2s1OEM2RnRl?=
 =?utf-8?B?WjNRanhBYllJQkIvNVYrc29GOXhhbzgybEJUa3kyTVZEdUM4MnNYUUZGV0Fl?=
 =?utf-8?B?ZDlyKzEvd05MWHRyUXFwbHIyR0VRSnNhWUZ3dXUxS2F0SWYvZHYyWWtzSTFP?=
 =?utf-8?B?TmRWZXh2aXpONjRKSXptS3BVQ0Y3bytzckhveU16enFtenEwb2pmSTRqVUhu?=
 =?utf-8?B?K2U1a216RkF1QlhSZjkwSlZhdmdCQ3dSM3dSZkRHRE9lU3dyRkErMHJOOGxS?=
 =?utf-8?B?dkdYTVY1d2tZaU8zZXlvMllnUlFXK1JRdTRubjB6WWM0ZlV6ODF5M3BjZnVz?=
 =?utf-8?B?bzRSNnJwakswY3Y3OWpjRG12L1p1a0xRYzRSWXZUbVJTejJrcGlZSkpZTFJ3?=
 =?utf-8?B?TkNCVDdMeFh1OGYwZHNtelN2U2lCN3dNUHl5akkwZlA1dnZxUDlVNi9ZTldu?=
 =?utf-8?B?ODJhNDg3Vnp2dW8rcVRSQUFNOG11QVd2TFJ3MkRQekxkaHg2cUkxSDZWSlVO?=
 =?utf-8?B?WUtmL3NGM0graE02a3NtZ29rMUpGZkRoY1gxVXJpL3plQTI3aklvR09kR1Fv?=
 =?utf-8?B?YU5MVkU5QWtnTzZ3Uk9PTjJucExyQjUwV1lySnBpbzZKRytmWFM4WDUxb1FE?=
 =?utf-8?B?TUxLQVdBUDBpTU51LzdXT0U5L3FMbXhpbmM5WmRNYTdYakJkS3NxVzhGSkxC?=
 =?utf-8?B?c3A1WlFTdUZHSWl5Mm1rMFRtWHpaUEoyUVEzTXAvcUpSL0NDVjhLSGxYQnhh?=
 =?utf-8?B?N3p0TEdyT2l1QUIwV3VDblBkelljMHYvWGU0MGthalhkYXFYWGJtdGs4SGM0?=
 =?utf-8?B?Rit2M2lvVFJCMTJJR2thZ3hFTFpYSkVCdGkrRlpWbGNFMitscndKY1VQKzFW?=
 =?utf-8?B?RldCUEtDeXhmUFYwN0hvVysxWkVOVXdsVWRRMVpnaTJSK2t6ZjRjOHhGU25Z?=
 =?utf-8?B?RnlWT24zeWg0Tlo1VkhUTytjT3o0U2ZJNmdGb09pZjZ4WFNodU5HbzBvVElO?=
 =?utf-8?B?TEg3SC95SmN1emRtOXYvVmFRTWJYbnNmMVZ4RVFxcDY1eWZRcXZEL2dqWjVH?=
 =?utf-8?B?TTAxamNxYk51dzFKN1htSHdvTkwxendNL2FlYlVRempja1IrQ2M5ZUhJaFNp?=
 =?utf-8?B?R1RMUnQ3ejQ1RUJyVk9VLzh5MHJ3MFJ5d2RRUlh0MFRDMUxFY2RpTWY2Ykd6?=
 =?utf-8?B?V1FaeWM4eDBtK3Uwdklidktzc2xtdEZFY1U3Qjdkb1dwRTFQNUIwLzJDMmNQ?=
 =?utf-8?B?Ky9ra2o2NXhiZEJDVXNNeFlJZ1E3bnZ1U3ZudCtBc0tlejJYNG5Cb3FVZ3VS?=
 =?utf-8?B?RkYzcEp4MnZ5cXJFT3ZVaXo4K3JDa1l1cGNyQjlrZlpFQWpWdzBUc0JsR0E1?=
 =?utf-8?B?dzlDZjFLMmZkNmZzUTQ1Y3JaajdjbEw5Mm9EZGJVNUFMaTVxTEFvWC9JVnFE?=
 =?utf-8?B?cVRjaHpVRThIU2lTT1d3MTFFOThEcWVJNkpEcDU3MVZDRUFkdSswblR5Y0NC?=
 =?utf-8?B?UkxrQnc1dVlmL3VrdEVlNElxZnEyT0dhK0pwK3JKMmJ3dHVWN29OdjRjUThl?=
 =?utf-8?B?Zk9UdEh3a2F4K1ova1hLK0hJWUJ0NUQ0cWJWNHdRd2VVS0dtK2hGelBHa3py?=
 =?utf-8?B?L29sS0NhaXRMOU9VM2xCK2Zya0pmUHNJbXBRWXZpTFowMHk2RzRuK0VDekZK?=
 =?utf-8?B?OVB0RXRPYnEwdW9xZlhYZkYwUkxYd2hOOFRLSzk0Y053cWN3aVhaRDZlR1ZJ?=
 =?utf-8?Q?0KkOhHvevSaokpiVlPWVQJiwO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7eeed3-942c-40a1-11ec-08ddc04af224
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:17:08.4080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCiu1iZ9utU5VNnk7WkalUVpIj9hSykIslxWfbde6ewimSAwRJ3c8xrH0J9qlKe2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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



On 7/11/2025 8:10 AM, ganglxie wrote:
> add eeprom data checksum check before driver unload. reset eeprom
> and save correct data to eeprom when check failed
> 
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 +++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 571b70da4562..1009b60f6ae4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2560,6 +2560,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  
> +	amdgpu_ras_eeprom_check_and_recover(adev);
>  	amdgpu_xcp_dev_unplug(adev);
>  	amdgpu_gmc_prepare_nps_mode_change(adev);
>  	drm_dev_unplug(dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 2af14c369bb9..2458c67526c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1522,3 +1522,28 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
>  
>  	return res < 0 ? res : 0;
>  }
> +
> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);

Doesn't this require a NULL check?

Thanks,
Lijo

> +	struct amdgpu_ras_eeprom_control *control = &ras->eeprom_control;
> +	int res = 0;
> +
> +	if (!control->is_eeprom_valid)
> +		return;
> +	res = __verify_ras_table_checksum(control);
> +	if (res) {
> +		dev_warn(adev->dev,
> +			"RAS table incorrect checksum or error:%d, try to recover\n",
> +			res);
> +		if (!amdgpu_ras_eeprom_reset_table(control))
> +			if (!amdgpu_ras_save_bad_pages(adev, NULL))
> +				if (!__verify_ras_table_checksum(control)) {
> +					dev_info(adev->dev, "RAS table recovery succeed\n");
> +					return;
> +				}
> +		dev_err(adev->dev, "RAS table recovery failed\n");
> +		control->is_eeprom_valid = false;
> +	}
> +	return;
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 35c69ac3dbeb..ebfca4cb5688 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -161,6 +161,8 @@ void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control);
>  
>  int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
>  
> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
> +
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
>  

