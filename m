Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD191C54E41
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 06:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A1FB10E567;
	Wed, 28 Feb 2024 06:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qb/oiSJO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 583C110E567
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 06:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSfXiS9P2ZhnY8wqGalfSrbXoeG8JsOkdCrFHttI+1tbP+bNNe2z+IJSUPbFQgJCEyupzzaPLdPmdCrOKSRXhQzAc1Fng8CCVa8wdfy/yN1WMMl3+02VFoEPNb1UFtLTHft2G69mzOlGZaRG55Ua73nA03H5Id20TAkmc9NL0zPtGHstCtjLWqc+FADQbuXQqnidQFyiUlHHvzLZr/xTaQJsKo4t+Tr4rqCVN45csTY8oIqNRc1Czey+8mRqdrr5FAMprncJrNRTcbEAIalOjyrGASkXCITRzNj6ur/zwgZBMS3r9IRN7fB2PfuiGd3/ZGOg2kzXT8W7i4yI+TC6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2mj35dfcQYvJtM4U1XB+1Id3hcLfSzwkFrhoSManNg=;
 b=i5Vb2m/8tn70xUVMvnT01kA6mghbauEjrQTqQvhfvPeA+NnK10k6gpjINN2R/CJzEwRgC6aLQVG0xuNSKjEjvqtAptJ3U+q+OUnwLErgGtm8yQhqFEu6aCIo9sKRoKIG3pH5lIhlQbHc3UtYbEaRQnVVOFAhqea6Dzlu4RBXA7mXnb0oMHlka7oylH7m1ejUeQHoUFKlgQ9nojbxz3azDGVRXfAkyr5dgXhhY1rczSfxt5gQiHOfIRFHNNP+F8Hk9NW8oPsNo2uQWXYitY1dNiTyWLHDc9Ewhpv1yaXgjsxQlG5oxT9eFnBe2S72A1DDwmTIg375c9GIEgqvwWL43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2mj35dfcQYvJtM4U1XB+1Id3hcLfSzwkFrhoSManNg=;
 b=Qb/oiSJOiUyU7+Q1ud9l+wnrARvyju3wJyYrBos+vcFS4dQ3Nm0TC8Jb4b8peViedLrgdq+TlSrHgHrKJ87tBnIdxFfnlQFnmEl5il2GEsrblPPpLEvzP/u2FnV9BmROchE1grbArPSxDAZCO5G2B+1vXH+pHhx8mMycalXe2pI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 06:46:57 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596%6]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 06:46:57 +0000
Message-ID: <f51c3015-1a4d-4ab4-bd3f-686b0f673052@amd.com>
Date: Wed, 28 Feb 2024 12:16:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: enable pp_od_clk_voltage for gfx 9.4.3
 SRIOV
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.zhang@amd.com, Davis.Ming@amd.com, vignesh.chander@amd.com
References: <20240228063815.4139197-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240228063815.4139197-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BN9PR12MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: d2259c53-d78f-4e78-e3b6-08dc38290ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTPqJSDXl9K+5XTdfLjIskxYPGW2Hmt61TdUsgxCCnhhuBNSDfXEEB/gkWil69a4AHE6bf50+gOLIdGdDnsxGV+rnAsEMAxvrYadt4JdpzTitb3RjxkXIZSTvidEM5DFtXii/X/n9Xp4WJbIIzELIMqRXy4OSbpYNa/HXlxO21WsWcQhuNEpgP7nHLD1saX+3gsL4Hq+ZmIHSBpnyoLuwb3qQnMfLlp3JcBQAcMsBTAACEg1z6f61oTqhQi9U/guLsaB0r5A3jSu3MSzA+PIOh8lrAK5JIluLSs15vNuKfND13K44JyhIX0dGn5r3+HoimBAf+Ro8D001Fl8pDMvU0K7ProoW6FuOZBqqR+ielbthZIwloC2lDUTu5iWOw+7owQkg1DH7xdvfHegtZaRL+VAL/l7TbcJIcKFF4jQ3JmOlS0jefWsDtxnU7FCfsDV2Rl5ik7fFkQyy0koJj765uI+SnnDYBIyXf5A5iR2wLvD2M0przPA6ju4Fz9sWgftxgTDUWcIZcjhbjTk4PH6G8PuX+YWZ+K5Pyg6lZzPaOPQdDIssLbR+8Khxu06h5fPh8WjR/fUIGOQ0sUYM+oZjaFE2tna1yrkXA2TRPrGD3pTPqQz7SFzejnYK65FY+Blc9N3uugM87Qbw0iYb60Zqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djJXMkg4cWIrZ21uQjV4RHhEUGU5YlBrT1VBN0VTUUJvVGlOUlJKOXNnZGZu?=
 =?utf-8?B?ZE9nelBCV2llQ1FnY0ZCbmw3aE9DN3J6UnJoRlhWZGhsQmtzTFQ3ak5wQ0Yz?=
 =?utf-8?B?SEdkU1d5VDFkdjVMdGRYeEZGQjRUMWZrOXp4RGtCNHIvdXdMdDBlcDVERXpx?=
 =?utf-8?B?azRsdXh1S24xaWZ0U2Y5UjV0SG04d1Zhb2luTXZyS2w5bmVZWHFUTjZ3T3Zk?=
 =?utf-8?B?TFVQQ0t0WFgraFFQa2Y5S3FKVVlldTNIRnBVekZXNVp1bTdXU3U4T2xqWXVz?=
 =?utf-8?B?K3RzemtOOXhsWTlLNHFRelFRRkdHWFl3WXdpM1ExTFpTUEU5ZkdHa0kvOERz?=
 =?utf-8?B?R2NZYTB1eXBmOEEvYnplZVJ2UEE3a3c2UVh0Z09pcUZ4R3FGZmlORzhvaVM1?=
 =?utf-8?B?V0tKa3ptZUF0N1NETHhQVm5XMXNSdGFZM0t0VEI4aEJQUzRhK0Uwb1VCMWJL?=
 =?utf-8?B?Rm1RQXlueHlVYzcxYk5zbmZQN1NXSGl1Tmhkc3czNHoxQ0l0djVzTXRkZnQy?=
 =?utf-8?B?cG9ZbmdxaHZmYlRiUmZPTy94L0NVaml3UTR0elJWd1F4SGJ1dU9QWm9aaWZk?=
 =?utf-8?B?WmFsNXNSemNwOVhNbWgyVU4vZVN0Ui9PZE91dEVGZ2Y5VnF3c0NueXREVWxi?=
 =?utf-8?B?U3FRL05heTVwR2o3dTNxeUNrMUYzWGMwZlp3WXEwRVp5RW44TUZUMjlKQnpM?=
 =?utf-8?B?ZFFGbkhaa2d3LzBCOW1Xb1lSc0xCRm9HOW15NVZaMzhiOGErWno1NEttSjQ3?=
 =?utf-8?B?b3d3WHFmMGZwa2Jsb0pvQzVqM1FSUDN2VVhGalNQV2JPOCt4OGNQWC9qVEph?=
 =?utf-8?B?cFloN2hJNVRqUnFaSEpQN3RJYWlTMGNmeW1RM3JhK3RtcVZjRFE0WXRObFVT?=
 =?utf-8?B?S1pQaVhGV21UK2p5cmNTWmQxcFgrR3FXVmFQSEVFL3ZBTFgrMGU3Ujk4RGlj?=
 =?utf-8?B?UmdlTDZzSW9XNldselY3TmljM2dpemdGZk1BK0FuMjVUSWpSakpEQVAzNThE?=
 =?utf-8?B?VFl5WHgvQTgzYnB1UkZoUjJtZThlTno4ZUNXMXduemN6N3BYQjVjY0trZWtr?=
 =?utf-8?B?MWphbXRLNGhQb0h3Rk1Cend1aGlkY1dpY08xVjZmMVg3cmJQemhaMFZCRFZk?=
 =?utf-8?B?a3VDcDFJQWZUalRCTW11YzNIWVBqNG9pdU52WVI0aHdxaTJxcG9HTlUzR3BQ?=
 =?utf-8?B?V0RtbnBKNnBoMnRlY1V3YTdUdkVSSWdIbWQ0ODhoYTRrSTVmdEhpSkVhOXpJ?=
 =?utf-8?B?TzA3Wmo1T1h1THNYNSt5dys2VUdGY3R5RUQ3a2hVNXpZc2tUb2MwSUZ1aFZV?=
 =?utf-8?B?M2RwRjg2VVVZVDZpZGdUeW5HaTJNcGtHOUVSYS91OUVjRjNNNE5oSlpMd3BG?=
 =?utf-8?B?czBCUStMWFlHUk0xSXBnWG5qMUF0Y1BTOU5KRmk2Ri8yYnd5WHpmZnRrSVJp?=
 =?utf-8?B?bXhtZEtZM3Arbm40bDRIRHI2U3pKR0h3N29yRTFmbmRJeEVhRHM0SnZBSC9Q?=
 =?utf-8?B?MFNkb0k1NzJLd2FCZ1JIRnFIWUZKb1ZkTHlpdGxSUVVtNWZVTVdCdWUrYkZ0?=
 =?utf-8?B?Z1RvVDdHNTluMnlwYjJQZElBc2cxQkthSUkwcWQ2eEVsN1pIa1VXZHFISUNv?=
 =?utf-8?B?OFB1NmZCOFVyL1B6TlQrbHpkS1U1ejZWb0hYc3U1Q0NQaEZuK0dnVU80Sm1U?=
 =?utf-8?B?K0dUWGtuVzRFZVJSWFIwd2RHWVRzYnBoTTRQdkhkdS9NeFYvWTNmZ2Z0QnNN?=
 =?utf-8?B?UXdFbGVUc0tpWitJek9wSSs1WkUzcUUweHNFOW1oU04vbi9mYlRRRllEbUJT?=
 =?utf-8?B?UHZrdVBVYVFqOVE1MXp2UngxK05MSTdmRlQ2WjE0cUc2T0lxeVJWUlRka2Qw?=
 =?utf-8?B?UzYvVEtMRk9mNTQvcWF1WFZ6WXlxRi9LUlpaUVFzNWRoTkkyck9lSHpzL2lU?=
 =?utf-8?B?amVxNE1qNmZ2ajNUQXhUK2g1NkFudnVpdWl0UFRXT0lGL3o5RS80cUVKazNM?=
 =?utf-8?B?N0l0WldhV1FqczArelBVblpyZDNEbm56a0czS0MrSUNQREhiSk95U2RkUFNz?=
 =?utf-8?B?TnJHSndPKzlJcjFkOXNFd0tuRDJaUng2RnVnVDRpSkJFaURvSUExSlhrdWdZ?=
 =?utf-8?Q?ZFgVSL5HwD9z8qVe6f2EAocEX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2259c53-d78f-4e78-e3b6-08dc38290ec1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 06:46:57.5787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9R2z2xMihvC4GusqBNnShoaZDWhpOaOuybMUDVYbpiHwA7IaKyMR19esnhzBO8Ob
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5129
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



On 2/28/2024 12:08 PM, Yang Wang wrote:
> v1:
> enabel pp_od_clk_voltage node for gfx 9.4.3 SRIOV and BM.
> 
> v2:
> add onevf check for gfx 9.4.3
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 35 +++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 087d57850304..7e5f00530769 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2034,6 +2034,34 @@ static int ss_bias_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>  	return 0;
>  }
>  
> +static int pp_od_clk_voltage_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
> +					 uint32_t mask, enum amdgpu_device_attr_states *states)
> +{
> +	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +	*states = ATTR_STATE_UNSUPPORTED;
> +
> +	/* Enable pp_od_clk_voltage node for gc 9.4.3 SRIOV/BM support */
> +	if (gc_ver == IP_VERSION(9, 4, 3)) {
> +		if (!amdgpu_dpm_is_overdrive_supported(adev) ||

A reorder may better work for readability -

Move the !amdgpu_dpm_is_overdrive_supported(adev) check first, and then
for 9.4.3/SMU 13.0.6, only do one-VF check.

Thanks,
Lijo
> +		    (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)))
> +			*states = ATTR_STATE_UNSUPPORTED;
> +		else
> +			*states = ATTR_STATE_SUPPORTED;
> +		return 0;
> +	}
> +
> +	if (!(attr->flags & mask)) {
> +		*states = ATTR_STATE_UNSUPPORTED;
> +		return 0;
> +	}
> +
> +	if (amdgpu_dpm_is_overdrive_supported(adev))
> +		*states = ATTR_STATE_SUPPORTED;
> +
> +	return 0;
> +}
> +
>  /* Following items will be read out to indicate current plpd policy:
>   *  - -1: none
>   *  - 0: disallow
> @@ -2118,7 +2146,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>  	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,				ATTR_FLAG_BASIC),
>  	AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,				ATTR_FLAG_BASIC),
>  	AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,			ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> -	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC),
> +	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC,
> +			      .attr_update = pp_od_clk_voltage_attr_update),
>  	AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RO(pcie_bw,					ATTR_FLAG_BASIC),
> @@ -2163,10 +2192,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>  	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>  		if (mp1_ver < IP_VERSION(10, 0, 0))
>  			*states = ATTR_STATE_UNSUPPORTED;
> -	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
> -		*states = ATTR_STATE_UNSUPPORTED;
> -		if (amdgpu_dpm_is_overdrive_supported(adev))
> -			*states = ATTR_STATE_SUPPORTED;
>  	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
>  		if ((adev->flags & AMD_IS_APU &&
>  		     gc_ver != IP_VERSION(9, 4, 3)) ||
