Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86801C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 03:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 364E710E631;
	Thu,  8 Aug 2024 03:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ovZ9NCxH";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CEFA10E631
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 03:46:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BR4hufKWNfn1mub+bnm7FawAt/t9hYKSCNe3NiSKuetUfKb9YUZWIFowj2uqJgOK+YrYlNgjDK/ttgQ2MqEyVPJUBoLzGTz5asbQfO5GEFF+AndQ9/Yx65L1Z06yDAe00P5b8GYPvTMEn0MbSQdrEfg09mL62tpIzCOSwZJfcUUki+XakyQfVHoVwNqhNAPsBB/Iz2UYob9nWqGXrZGXJTFGlQaXRHPFYyfvd1Y7a/+8oeKqxjr69/EZ2OEs298tEI/KgumnFs3AFtpnn+JvJkU6ppSSXw18kVko/EvAadJP2TZZzNaAf50WWRDpvAjrk6lfcNff4tUMG7Ji2+nkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlzOu4LhauTLuIuCUF3/OK7AOdMuiHGnMAP4lscVazw=;
 b=uSiGn4m7SV3rwg5QiM5I2XkbrejcCaUaBED6W7SOWFeSC0brcsMJ/LVm4rMCwKkiHoTGMfECIIF40L9x7P7Fz/GuNH4KE+1vZdega/7yYlKuMlDTy/G54TCuDpDKL1rarTVh+dJNxkbnKH/niCoYyBM/oHlto9xLqcnvvSagm7o8M+7X8/yWZivDFtkY8Rp6j+SVlCCzYu/on1KUn+XFtmLxwTiOecVoOdPX932RjpISf+Gjzfs3dJaGiAT44jzJ4ezGiR3ZMzGYBG8H22FvSLjqoLtxRB60c9LXfPATKnPIRGcCfPxsU0e5a78RPHl3og46sizywRftxLnw9d8TKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlzOu4LhauTLuIuCUF3/OK7AOdMuiHGnMAP4lscVazw=;
 b=ovZ9NCxH9kfmD0XHKzij3ygVyWn12wxqxp8cWGq0Ggui9MJl0PzjAUYiGgQ6lZDlvSTrl6sDm7yE1/CinJK/UFQb8J7liGN4EGSKs7MHlOjWQ4KyzKG6ToUnA/E6dsaO9yGEQfUhi4KtPhPs+jJSpmDhoy8Xypj5N3Ga6mJ6Xrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.30; Thu, 8 Aug
 2024 03:46:25 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7828.024; Thu, 8 Aug 2024
 03:46:25 +0000
Message-ID: <663cd1b2-8e7c-47da-869e-e8ddf9d50ec9@amd.com>
Date: Thu, 8 Aug 2024 09:16:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix partition query when setting up
 recommended sdma engines
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20240807203440.1875832-1-Jonathan.Kim@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240807203440.1875832-1-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0051.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::28) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e461f02-2b29-4879-1ec8-08dcb75cacff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnVtOUlqc2xHRGhCZzdmbUZlb0crc29pQkErRmFOMlFFN3NQTFc1aDFvdXgr?=
 =?utf-8?B?Tk96V2VrWjRKbjNvYk5oOFpjc0NNRDJHS0N3UnEzVHB0RnFwNHkrN3ZLT2xZ?=
 =?utf-8?B?b2x6YUczZXBySjJDRmZLbGcwczEvWkJMSk5kSXRiVkJwL2dHRGROL3l2aEdX?=
 =?utf-8?B?ZU9WMWN4MDJyTU8xc2tWdFpPMWg3ZDYxYkZTVHNlQ0phZzRHSTRUa0QxcXNC?=
 =?utf-8?B?WTduRlprYitxcEhuUnN0M3hVclNkOTlKcjNRYXBXQ0VtK0F4cThPdkN0OHlY?=
 =?utf-8?B?L1p5SGs4eTZpNFhlMkdhNVNNcnJ6TnMyZmROTlNCYWE3K3cxN1BKbHlHYzhB?=
 =?utf-8?B?NlRRSE1vSE1zQVdDYTdNNDBrVUtzUzdUVGpQQ2xJYitWRzZoSnhHU2NVOEUz?=
 =?utf-8?B?MnJWdlJSUzJ5SWFDSmluMjZlT2U3V3ZsTXlVU205RWljQ01ndXFzVy9aWFVM?=
 =?utf-8?B?ZlFNWDhkMXhnUnZZSTdEaE5YNURBcEpxY3RVWTZhc05PdE5EOHpTZ2FQUWgv?=
 =?utf-8?B?RXhsMXh3a2IyTHRvM0VxSHRnR0gydjZEZHNoaXI3bWZWMXd1WGdpU2M3Q3hy?=
 =?utf-8?B?YzlnckJTSVdQY05ESzFvOTVWVTFPVXZLNGNwV0JseUpGZHYxMXVkYTh4KzlG?=
 =?utf-8?B?eGEvNmkveG45c0l1NU1pVnEwTVFPWGNwdWZFSGJCNmo3Tnd3RThDMGRnQkFT?=
 =?utf-8?B?TVRHMHRaQytsZzFzdHYzMm5GR0xUY29Rc0l6M1BTYitSWjFMdFpvbFNkdUJU?=
 =?utf-8?B?Q29HaG9HcEJRdEpjRGJHQVFZT0V1cU1GN3Exb21iNHJPOGtsbjZjMnl5NHdy?=
 =?utf-8?B?Q0FrTkpNQnlLY1lXZ0xPT1pMS3Mwbm5KN01vdnFTeTFLZGZ1VTJvNlRaRVQ0?=
 =?utf-8?B?YzRoWDlkbm96OUo2b1MxUTZGdHJQaE9PK3hiZjNYeklqNVIvZVdJUUhRNXUr?=
 =?utf-8?B?dXJtYzdZYjJTR2xQUG9ueEt5N0JqZngxclpkOHVsZEtWVmYvc3MzemJhbmVi?=
 =?utf-8?B?Z1p6dGhvMjhNVUJXTTNZZDNoeFUwaXUrK29wN2lIaC9hVzcyQkM1M3MydER6?=
 =?utf-8?B?bXJoS3ZMbDdyS01IYUw0cnhIcnk1cTRYYWpuSE9qN1ZnTzd2clZIY3dLSG5t?=
 =?utf-8?B?YVExdFlLbjE5MUN4TGVxblpYdXltK2VpSFdBSzM1R0lMRkp2RWZaQUpCaWpW?=
 =?utf-8?B?eXpTRGFmTmlPSTFqQ1RDRG9WcE02SFE1VE1aNkNYNUdMTXRHZlgveldnUnZt?=
 =?utf-8?B?WUQ2UEhoeElaa1ZEemFKMnFGMjZZOStFR2NlRXRXUGtMT0lVTXZScmEyd0Vu?=
 =?utf-8?B?OE1hU1RldU5SWUVSS0lpOVpEdWhLNVdzODlQdlE4TnRCdzk4TUJJV215MTVO?=
 =?utf-8?B?Z0lCVnhlVWdDK1o5c1NPb3dwSnN2R3lWeXhrNjAybGUySUFXbHRiclp4aHNU?=
 =?utf-8?B?aGl0VmVWOUFZaWlWK3AwV2pHb1BRNlpuZmc3SEdvNUMrdjkzM09jUkhhbkdi?=
 =?utf-8?B?WXh2YU96UlM2S1Q2dWFidi9NUS9uRTlIVlMwaGwyaWJPQzI3Rnk4MW15a2hX?=
 =?utf-8?B?MDhGQTNFd0tXdEQ0QlNzRU9xakpheXorcUF2Z1lPaFNjK0hud2hsWWxNRFRN?=
 =?utf-8?B?cTg2S1JFd3RncUM2NWJiekNqQVNNTmtuQzZzQ2tVNzk5cFZmUkJpSHBkdkhR?=
 =?utf-8?B?cGg4VVkvaEkrckhZTlJqWFphbUdETHQzMTdNcVA0Uk5YR2hRVWtDRTh4U1Ew?=
 =?utf-8?B?ZmViTVBET3Q1aEVoQ3oyVk0ydzNRRnpHTy9jTWptRXNEc3VnVXFTZ3ZSamlu?=
 =?utf-8?B?OVhwVHBleTAzSnR2QnUrZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ti8yWGxnZkpDa3pMa0VqaS9RWTRpYU1HV2Q1REJLV2QzYU1FNUlpWmVCNWRw?=
 =?utf-8?B?aXpjaTk3VGViaTRRZnJNWTdHZjVmblpFYlRrMUQ2OFdhekpSUlFPcm9VT08y?=
 =?utf-8?B?V1lJWHc2UEpreXprQ0hmMUxqTlFBM0d1S0sxMFVQYmd1RXJSNE9iOFFzWnIx?=
 =?utf-8?B?WEZuSHNENnAzenVvZm03Z1NnYTQzUzdvcXloVGVLQU96NlROUGVua0xaOVkz?=
 =?utf-8?B?NE9EZUlkc1I1ZVVtdTBuamhtZTYveDhEUytYdnp6eFROTUdjV25yL3FrY2VL?=
 =?utf-8?B?OHJHM1FSWmNWbTlmY2tXMzVTY2VQTDBkZ3V1elFoSFNIcVBBbXNQalBrbnlz?=
 =?utf-8?B?eWNyOXJQM3puNzhEYS9CY1FuN1Q0Rkhnd0NFeGsvZUFrbCt1QkhnQlRWTjZC?=
 =?utf-8?B?WE9vNm5FUmNCaVo0Y3d6U0ZmUlRUSkNvTlF3ZzdxRTl6bjdRQmZPa0x6MGUx?=
 =?utf-8?B?NkJLeGo2Vm5QTjB3ZzdIcEVHZ2FRRXZZRmYzL2JIdVc2SlN6ZkIvZ0JPL0JY?=
 =?utf-8?B?SldpY2hzOCttRXF4R0NVMndZUzBnWUZMSVA4MkpOWVdSc1FKSHRVRHYyeEt3?=
 =?utf-8?B?WnlXR1FFYytCQm9iQkRmU25RMVdNWHV2M2c4WmlCbVA5bzN6SkRzckhDTUEy?=
 =?utf-8?B?WlBhaHMvNXlaTko3YVd6MUMyUkhJOGxqRUxEM2pqMmttMG54QzhSMXJQbFJl?=
 =?utf-8?B?cVlyd0xuL2dxUU4rR0JMS3QrRUY3K2t4OUdJcHZDN2wvNUdSWEVOWnNkaFk5?=
 =?utf-8?B?NGJidGxGbzQ4bkJYeVc2dFhhc3pDY1dmS0Z1TzlYL1Y4K2Y5WVBPUFBqRjhw?=
 =?utf-8?B?Z2V2WTQ5NFJBWVVaTkxhT0Y5bUNycUZUVTNsRTRSTno0ZFlDdmJUWm50T0Ru?=
 =?utf-8?B?WUNLMjVOZytONUI1U3pybWZubk9MVjhFZUMwb3JtVlBpZmtOVG5nbzBQZnEw?=
 =?utf-8?B?NnVPT3MwcVg0T2dtSjVidXArOEhGL3BSUzFwc1gveXNYNzd1ZndUbmRFYUpt?=
 =?utf-8?B?Uy95Y0owWEJKOXhvRzZZUkFScENQcWxBNjdWc2ErM3h1SUlmalI1eHUwVzVL?=
 =?utf-8?B?K0Z1RFppSHNUTDdVM1NEa2FzaktEa3RIcjJnSDAvem1YME9HTnFtMHNreFBh?=
 =?utf-8?B?anNCZ3FPOC9tV2ZLVVg1cHFCTER5YWZkVUNmMzRRQXUyRU94Rm1INHRCZXk4?=
 =?utf-8?B?ZVRncEEzVW96UU1IY2JzK2lLT1MyUzd6VUg4eGZYNk5ldmgrK0VMV0w1dnV2?=
 =?utf-8?B?SUEvZWsrU0ZuQUIxTUphTXVCaEhJeTlqVklySmVpOWtrNGhTdlI2anlqRTRx?=
 =?utf-8?B?NGxVUEVicUlBOHpBOW96bENZUmxMTFdWclFIbVR3THlscHl6SlFnWWp6RDRu?=
 =?utf-8?B?Z3UzemFNVEtPOGVYd2o4blArK0lZVUZrSlc4T2w5d1pNdDhwNGtHNmNoODBp?=
 =?utf-8?B?OTI2QlBuTFcxSVVqS2cxQVVjUEViWGNFVVIzdGhHbFpHN1QyeEVMT3BoLy9V?=
 =?utf-8?B?Vkw1VXp6dnV1LytMa0NnQzJ3aGJUZlhNN1pRUUdyTGZmM3h0L3JvYVV5aDBE?=
 =?utf-8?B?WUtVUmdJTVpWOEZ4aDF0NURLdnlQYkVnWFhZRllXanoyZEhWTDV4VmlUZkJY?=
 =?utf-8?B?Tk81UjFzL09CRGVtbm1hZ3ZPeVVxWWFUUHR5TjN5TGcyUld6RXZ1c1RmYWVJ?=
 =?utf-8?B?Wm1KSEVhbklsL0szaUJVeXRQbDdoWmhCNUUrZkozODNDckhwWW0zVVlWVW5v?=
 =?utf-8?B?RzZpTm9vbDhON0RxNHdlRTgxbnZnQnd0ZGtxaDR0UTYxam5VM1NBdWdtU0Jx?=
 =?utf-8?B?ZjVzVjF5M0JoeTBoWlc0OTI5RndENlVpSFhYeUMvdGRTMmlESGluV09PTVBw?=
 =?utf-8?B?RWQzZnQ5V01NOHFtT2lRUmtZZ2ZnVFE1dWM3NUJWeEduc2FzcVpETDBudW9Y?=
 =?utf-8?B?VmhBV3hBdm4zOVFDRmZ1c093TWJMMWRCaVhNU3g1cS9sSVNZaU9FRWoxMUtI?=
 =?utf-8?B?MVlBVmdUbERLeTVHUzJhVEdmeWsyckwxU0ZaNEt5cEdTNFcrdGt6MlAvYmMx?=
 =?utf-8?B?cmhVakc3aXhUSUZCZGkvUkpHT2crcTFmaVljRFh3VElna085dkZWMHR3c2VC?=
 =?utf-8?Q?1C6NjCwrtUVefsGZnCgxlzBUk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e461f02-2b29-4879-1ec8-08dcb75cacff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 03:46:25.0419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfa5hWJyu6DVx3r2ax9Mx5Q0IclKJ2pMRUz2G87jOmhTano0hNEtCjZVB/oWY9w+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987
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



On 8/8/2024 2:04 AM, Jonathan Kim wrote:
> When users dynamically set the partition mode through sysfs writes,
> this can lead to a double lock situation where the KFD is trying to take
> the partition lock when updating the recommended SDMA engines.
> Have the KFD do a lockless query instead to avoid this.
> This should work since the KFD always initializes synchronously after
> the KGD partition mode is set regardless of user or system setup.
> 
> Fixes: a0f548d7871e ("drm/amdkfd: allow users to target recommended SDMA engines")
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 40771f8752cb..8fee89b8dd67 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1287,7 +1287,7 @@ static void kfd_set_recommended_sdma_engines(struct kfd_topology_device *to_dev,
>  	int num_xgmi_nodes = adev->gmc.xgmi.num_physical_nodes;
>  	bool support_rec_eng = !amdgpu_sriov_vf(adev) && to_dev->gpu &&
>  		adev->aid_mask && num_xgmi_nodes &&
> -		(amdgpu_xcp_query_partition_mode(adev->xcp_mgr, AMDGPU_XCP_FL_NONE) ==
> +		(amdgpu_xcp_query_partition_mode(adev->xcp_mgr, AMDGPU_XCP_FL_LOCKED) ==
>  		      AMDGPU_SPX_PARTITION_MODE) &&

Replacing with (gpu->kfd->num_nodes == 1) may be better.

Thanks,
Lijo

>  		(!(adev->flags & AMD_IS_APU) && num_xgmi_nodes == 8);
>  
