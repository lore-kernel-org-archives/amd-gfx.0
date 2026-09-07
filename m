Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641D6C79F89
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 07:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD0F310E463;
	Mon,  7 Sep 2026 07:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FzLopt8r";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012015.outbound.protection.outlook.com
 [40.107.200.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D49D910E463
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 07:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+f2FnGkfZ2tLHZZW0Y+LbzJc6jwhS4U4QuL6doxL/3j9IFyJYpTEHfU+Jz6mExG1Qc04ninFhZE6Grt7MDFJ8W/k5NhLW+o6XJeXoRMRa+AVoHd0QSYDvkpYNG3TjadRYWVmz2Kxpe6pske35rewa/MLxmzJDEPhOBmfmOqABa5P8FJxsRs3xXO6QL4SOeWzQhTT6n90qqWM3mGy3jwPPxS0ksVybqgR14cQlBCS1aU4wbO2IVXKUhCaskTEyVhDBbt0BDqAGMgm7ThPvqFl3s9qzaWcYOQkJmpDmH2OS1+nOr0wRORkbUqS1AlG0TnEdxfZbJqkwGFFWRRWJIing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b69xHSq47tJkLy/kdjCVqKq7bCw+nv1pagv3N4sCpwI=;
 b=nfRbqSw9/pH2SGBq5FXpMKOtemfeslOSgXWX4ju9hMbkwj5vaRL3nvoI60TW4c+fvu+4aG3aduSm/WjcnJ9y1mOFbgO8YDzAm08X9bRaxf/yQSO0U2WOmQTM50QRpbQDzfjvw+IrvX1i/Q/+0BEpG/ogP1NwGjtf4NbCNuwHS2oba7j93/Onwx5EQSE6TEf61ODvZXndBisvlF56BydsE7SmIYbX+FKTGGndqG6v+hnb3auWrJhltfJLN/0yrsS7oFor4hvXBz20wToNE8Jp7m2OVMTsoOe/nApKutmZtC/eUgEsZzIRwKYpOg0KsTyVZgU+jBTQIaxhz3ZEfVaUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b69xHSq47tJkLy/kdjCVqKq7bCw+nv1pagv3N4sCpwI=;
 b=FzLopt8rw9AVJ9zWVLhTXVJBVkiFsqlKqnIUrlGti5bDgSvptWUEoJbsSl4fXSeXOlqvPlMWrJAjIAZkMFwok4otE3tKj5FAe7LuU3scQQYO/xXu4m3Gaq6vGbAVeKOqlgYIpjYJlFKv1yto+aljUVxoWLeXCc50GX3B2pXOj5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.15; Mon, 7 Sep 2026 07:43:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 7 Sep 2026
 07:43:59 +0000
Message-ID: <77bd73f2-3e33-4c78-adaa-634b381ea5b8@amd.com>
Date: Mon, 7 Sep 2026 09:43:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu: Delete SI/CIK/VI IH soft_reset() code
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
References: <20260904183409.571117-1-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260904183409.571117-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0286.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 875bf16a-5257-44cf-c91f-08df0cb3c772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Pys5WKuTukNmDNwHczR43SX+kaTjnRSysJ5UJAOwA8V13NSHrI+co0iyDCwzyynPse4jpMQulqaoMyKNXTV9FgXDWg5r77UoFIVlfdClAlD3WdxDrw9O1EBGOg2DfToRD59hufAOn/TJCfF5VLSky45n1aLJvVBryc6nVeb0YFqnVyb9jUROxWMmIYSJSluHHpKyyYzS2lU1j0Kz9xE/yGem62NBzFCiSpVk6abHK4DHr5BnPxK2Q8BQ/5d0pl3vR3UPkWSu60mXK+4Vg6WiMa0FWg0vGF1zdUdjvNSq3pC3All16alQa3CQet/TGMXuWgGXthG1CidPPCLeUsqgcTCXU9PWipBVNPmGv5YCK46NzqKhh0oUqcTUg6RPVmMD3e9zt+TD4Nf9QkhmvhqlzgQzgN/mfRh843JgFXcFWWXMyXIFrjP2UrH3pxNLfgdW28JTsckMa6uVRypiwTxMjPrzHAAxDoJKoN2zy73QgcIwxYP2xO6NddjYKyaHBKH6jKqNwwQ+49EtKCXs8PuDDXGKMPnosO/qibaXqqpBj5O3MG0t5v7iMEucSq/1cXkGMbw8nlA0+LW6qxxYUjv3FZGrrjHsGD1RdMvV0J7DR+W1Ak1QkyAceiv1Lzv3VIDIL/eHBx6Pe0uy19K4quofVQ0b5V1jiEE+TEZGZJhnNk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGd4SURzUzgvWFJzMWRmSzROYW5LcktWTGxFdDh3N29Hdk4reEo2MVkzNWlz?=
 =?utf-8?B?am1MRUNtamxURXpOaHoyQ0l4Q0NzZy9RQXdLTURRdzZhSmU0U1RsU2hIV1Zm?=
 =?utf-8?B?YXZvUkdxSXI5L3JUR0N0RHNUaGpYYXFSU1RtampCbE1xaml1cmpyWjRJelp6?=
 =?utf-8?B?aWhZY0VnYUZSNnFWRHZEVzNIN0JHSjI1bk9SelRvRmJ5amQ0N2hlM2RZNEwx?=
 =?utf-8?B?eDdXeGxMSGJwUE5WWEx5L3RYV3lIdm9iRXkvVlNhellHemxwWnhFWVp3WTZH?=
 =?utf-8?B?UHJBU25HQU9lOVE2VEQ5NUQwZm5jckxsVy9yR2xxckZwWk1Mc3ZFeDB3SDMz?=
 =?utf-8?B?a0NNcm5aRVNDSjI1SG5xNEUwWUlaeEFGR0x3N2xWMnBudndLRkcrMlRmbU5N?=
 =?utf-8?B?RGpWVnA0UDZiME9GRzhRL1NVdXNnYVdrZEtBendFN1RqNVhhNjlBOVB0NDA2?=
 =?utf-8?B?ODBNd2x1R0NaWWdOTkRLaFRFN1ljM1lpV01aOStDMTF4RU9LUkhxWDFEclhD?=
 =?utf-8?B?dks3UGtzR2FXL1UvdUZZdXAya2ViZXR0VTBDWkVXSitKNDdNRkkzWGFqUXVF?=
 =?utf-8?B?ejhuRVczR3dqOTR0QUJZYlRDbzh4WmNVd0FHT1RQbXFkSUljekRVSnZzRWdG?=
 =?utf-8?B?K2hYdlBIOEhnSllhUnc0cWgxUmQ0UXRiSWJBQmpYek5NMlV4cnZyLytoUy8r?=
 =?utf-8?B?NnRzMWkxNWZpaUVTeGhKRVAyY2R6bzRIMjExTUU0UHBDalpVdTU5SSt2RCs2?=
 =?utf-8?B?Q0poZHcxUWNTd0pFV2JOY2svTFlHNit6c2JvME1ZNnhaMThzR2tMYStpdU1I?=
 =?utf-8?B?SjNjMjl1ZjNrWHZYWGRjd05qclR0WHRLZWI4NEFnbDhhUVI4KzNVZ3VqUSt1?=
 =?utf-8?B?ZTkrY3VDQlErREpXT2dDbkQ1L3Z3eThFNW9Hb1lPUWJraS9MemlycldxWWx6?=
 =?utf-8?B?RFNaOUR4SHN1MUthSzk5R1o4bGdDVGZTa29RQW1kNm1IZkJDTHpCZXl1ajlC?=
 =?utf-8?B?ckkySTZoM0JscmI2TFI1YXhKUzB4cWJzbzVTQ1RVNXZWR2ZZMTBTVWEyTG15?=
 =?utf-8?B?a3ptY1M3aGd1dlE0bzVlbWRVTVcxNnpqTDFmSzFZWnFxbG5obzQ5ZmxHVDFN?=
 =?utf-8?B?b1lPYXYrOVhYYkFSSVRiZUdrSlJFR2JaNzhUa1BRbFdaeStUSGF5YmxvN2dm?=
 =?utf-8?B?K1duNlhOOVp1TlZudVpzZGhLUno4TVNIeE1mOERid3AzdEVhL3M5Z2ZJTFdt?=
 =?utf-8?B?VUE5TVRUa2ZXdzRrR1ppMmdZVkFwVFYyZGxHQ1AzU0hXc09UZHpqOERYZk9L?=
 =?utf-8?B?Qm1GbjNoS0JHQ04vQlVnQVJEYkMzWDZFeEZqOHhWUy9MZHdUWDJkSHo5WStY?=
 =?utf-8?B?L0lTL2h2ZlREMEk5eHZqaUo3dEVheHo1UzVUQjNidzNrWWNKRFJGNWlOcEFD?=
 =?utf-8?B?NnpHRjdvWG5vZGN2MmxUY1hpRXZCNHMxMVR2eS9sVUhBdTNjVS9LbWtlMXFv?=
 =?utf-8?B?cHFKc2EvZHJGVXpCbUFscjQwRVU0WmZGYVQ1OUNGVkJjcVJuQW1qUUl4WDlx?=
 =?utf-8?B?Q2JxaklQR3Jub2tIdWpxSzkya2NHN0tuZ29wblVhcXJ2NHBDenBscitkSzJT?=
 =?utf-8?B?Vmp0ME9uTTROYkRGcG9XR3NTMGUxQXFMZ1FMQTc0V3JZTVZ4QnNFaGlSeGZ4?=
 =?utf-8?B?MWJ1VWpJb1NQMTQySTR5WGZVaTJpclZOV2FhaENBZUNKa1Y0SjI4c2dFd28x?=
 =?utf-8?B?YWNWcTl4amlLZklDcDV1WnZyRmpUZW90aTZTTmRaQ1RCajZmd3lMZXQyMy9R?=
 =?utf-8?B?OXNOOEhNNzg5ZFlKUzhTRExGRjBkVk9VQXhVSVFlT3hkTTU5WGcrb2xlbDdj?=
 =?utf-8?B?bEZWWVhkYWNFeXRVU3l0T256YUd4Q3crNjhRbWRkdGRRY0JaM3l3OTJUN2JK?=
 =?utf-8?B?Q2RiREw5a3JDL0NXU2NaRncrMWtZbHdpWXdrM3N4c2MxbE12dXlFOEdNRVR5?=
 =?utf-8?B?cEhKNGtWSXJmZXJpd0laNUVISUF1T2dhQVlZcnk0S0lLV05LRkdMWlhuSmFo?=
 =?utf-8?B?aE1JRTJPd0kyS2xsRmhZeGZlUTM3SlY3WmIrNlhBZWNvY0phWUNQRHA3c0JW?=
 =?utf-8?B?b0xNd0RJQ3dRR2FxS3FSU2dLWXBwNTE0TnY5TWJTVHNvZTh2MjdPRWRmaTJS?=
 =?utf-8?B?eFhjZzUxUWRNRW0ydVZISTlaS0R0QzNocXd6aUxrUFR6TFdHR2x1WXlxWHRN?=
 =?utf-8?B?dW93eWNjZlBYcTdpWnVjVjh6RUxFSTNrUzZaaWxrZkFDOXV5eFhZRHpaKzFX?=
 =?utf-8?Q?93c6GriK1b2abVjhrm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875bf16a-5257-44cf-c91f-08df0cb3c772
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 07:43:59.6165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3PpuCfcfjVaw3ymdg5FX4eYrDT/16vSITMo8A6QT3peAuv58z4agij9IILZzFoZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
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

On 9/4/26 20:34, Timur Kristóf wrote:
> The code for SI/CIK/VI IH (interrupt handler) IP blocks
> has a soft_reset() function for each block.
> These functions are not called from anywhere and are
> dead code. It's unclear what the original intention
> was or why the IH block would ever need to be reset.
> 
> All SI/CIK/VI GPUs have been working well for
> 10+ years without ever resetting the IH block
> so it's time to just delete the dead code.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Acked-by: Christian König <christian.koenig@amd.com> for the entire series.

@Alex do you pick them up or should I?

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 31 ------------------------
>  drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 31 ------------------------
>  drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 31 ------------------------
>  drivers/gpu/drm/amd/amdgpu/si_ih.c      | 30 -----------------------
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 32 -------------------------
>  5 files changed, 155 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> index 314d8f1d64cc..73ec61bc69de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> @@ -373,36 +373,6 @@ static int cik_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  	return -ETIMEDOUT;
>  }
>  
> -static int cik_ih_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -
> -	u32 srbm_soft_reset = 0;
> -	u32 tmp = RREG32(mmSRBM_STATUS);
> -
> -	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
> -		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_IH_MASK;
> -
> -	if (srbm_soft_reset) {
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -		tmp |= srbm_soft_reset;
> -		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		udelay(50);
> -
> -		tmp &= ~srbm_soft_reset;
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		/* Wait a little for things to settle down */
> -		udelay(50);
> -	}
> -
> -	return 0;
> -}
> -
>  static int cik_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  					  enum amd_clockgating_state state)
>  {
> @@ -425,7 +395,6 @@ static const struct amd_ip_funcs cik_ih_ip_funcs = {
>  	.suspend = cik_ih_suspend,
>  	.resume = cik_ih_resume,
>  	.wait_for_idle = cik_ih_wait_for_idle,
> -	.soft_reset = cik_ih_soft_reset,
>  	.set_clockgating_state = cik_ih_set_clockgating_state,
>  	.set_powergating_state = cik_ih_set_powergating_state,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> index 8d02602f8433..82bff26abd5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> @@ -367,36 +367,6 @@ static int cz_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  	return -ETIMEDOUT;
>  }
>  
> -static int cz_ih_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	u32 srbm_soft_reset = 0;
> -	struct amdgpu_device *adev = ip_block->adev;
> -	u32 tmp = RREG32(mmSRBM_STATUS);
> -
> -	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
> -		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET,
> -						SOFT_RESET_IH, 1);
> -
> -	if (srbm_soft_reset) {
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -		tmp |= srbm_soft_reset;
> -		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		udelay(50);
> -
> -		tmp &= ~srbm_soft_reset;
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		/* Wait a little for things to settle down */
> -		udelay(50);
> -	}
> -
> -	return 0;
> -}
> -
>  static int cz_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  					  enum amd_clockgating_state state)
>  {
> @@ -421,7 +391,6 @@ static const struct amd_ip_funcs cz_ih_ip_funcs = {
>  	.suspend = cz_ih_suspend,
>  	.resume = cz_ih_resume,
>  	.wait_for_idle = cz_ih_wait_for_idle,
> -	.soft_reset = cz_ih_soft_reset,
>  	.set_clockgating_state = cz_ih_set_clockgating_state,
>  	.set_powergating_state = cz_ih_set_powergating_state,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> index 49002c80dc71..29faaa726644 100644
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> @@ -361,36 +361,6 @@ static int iceland_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  	return -ETIMEDOUT;
>  }
>  
> -static int iceland_ih_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	u32 srbm_soft_reset = 0;
> -	struct amdgpu_device *adev = ip_block->adev;
> -	u32 tmp = RREG32(mmSRBM_STATUS);
> -
> -	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
> -		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET,
> -						SOFT_RESET_IH, 1);
> -
> -	if (srbm_soft_reset) {
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -		tmp |= srbm_soft_reset;
> -		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		udelay(50);
> -
> -		tmp &= ~srbm_soft_reset;
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		/* Wait a little for things to settle down */
> -		udelay(50);
> -	}
> -
> -	return 0;
> -}
> -
>  static int iceland_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  					  enum amd_clockgating_state state)
>  {
> @@ -413,7 +383,6 @@ static const struct amd_ip_funcs iceland_ih_ip_funcs = {
>  	.suspend = iceland_ih_suspend,
>  	.resume = iceland_ih_resume,
>  	.wait_for_idle = iceland_ih_wait_for_idle,
> -	.soft_reset = iceland_ih_soft_reset,
>  	.set_clockgating_state = iceland_ih_set_clockgating_state,
>  	.set_powergating_state = iceland_ih_set_powergating_state,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> index 52118765dccf..2c5ac398b582 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> @@ -247,35 +247,6 @@ static int si_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  	return -ETIMEDOUT;
>  }
>  
> -static int si_ih_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -
> -	u32 srbm_soft_reset = 0;
> -	u32 tmp = RREG32(mmSRBM_STATUS);
> -
> -	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
> -		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_IH_MASK;
> -
> -	if (srbm_soft_reset) {
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -		tmp |= srbm_soft_reset;
> -		dev_info(adev->dev, "mmSRBM_SOFT_RESET=0x%08X\n", tmp);
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		udelay(50);
> -
> -		tmp &= ~srbm_soft_reset;
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		udelay(50);
> -	}
> -
> -	return 0;
> -}
> -
>  static int si_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  					  enum amd_clockgating_state state)
>  {
> @@ -298,7 +269,6 @@ static const struct amd_ip_funcs si_ih_ip_funcs = {
>  	.suspend = si_ih_suspend,
>  	.resume = si_ih_resume,
>  	.wait_for_idle = si_ih_wait_for_idle,
> -	.soft_reset = si_ih_soft_reset,
>  	.set_clockgating_state = si_ih_set_clockgating_state,
>  	.set_powergating_state = si_ih_set_powergating_state,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> index d84c08698dff..194487a71fd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> @@ -379,37 +379,6 @@ static int tonga_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  	return -ETIMEDOUT;
>  }
>  
> -static int tonga_ih_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -	u32 srbm_soft_reset;
> -
> -	if (!adev->irq.srbm_soft_reset)
> -		return 0;
> -	srbm_soft_reset = adev->irq.srbm_soft_reset;
> -
> -	if (srbm_soft_reset) {
> -		u32 tmp;
> -
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -		tmp |= srbm_soft_reset;
> -		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		udelay(50);
> -
> -		tmp &= ~srbm_soft_reset;
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		/* Wait a little for things to settle down */
> -		udelay(50);
> -	}
> -
> -	return 0;
> -}
> -
>  static int tonga_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  					  enum amd_clockgating_state state)
>  {
> @@ -432,7 +401,6 @@ static const struct amd_ip_funcs tonga_ih_ip_funcs = {
>  	.suspend = tonga_ih_suspend,
>  	.resume = tonga_ih_resume,
>  	.wait_for_idle = tonga_ih_wait_for_idle,
> -	.soft_reset = tonga_ih_soft_reset,
>  	.set_clockgating_state = tonga_ih_set_clockgating_state,
>  	.set_powergating_state = tonga_ih_set_powergating_state,
>  };

