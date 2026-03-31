Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF201061B2E
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 11:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027C210ECBF;
	Tue, 31 Mar 2026 11:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z8a11RbU";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013056.outbound.protection.outlook.com
 [40.107.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 028F310ECBF
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 11:27:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkhDzubeLGA+gU2JL7Ag17ZpsJoj0MtuACWPy4jsRR7AJLYWa+L3EP/mOEcHr94bKuYLB38kALiQVrSGE2i68ui3OW4yVtaFIgJIneqNanW+FTWrzekyrUGGsRtfswVNVi6uGeDIOwUh5etZXFugP2jTtZb80v4OVnbsNhxxlLc8zanh+67LKR1+hcsppfrM0xDd5YW88Aq8I7RRRvGrOZQRX9pknHDNftsxvvEcZyJXdIG67QFBq08Z3QShxN+Nws/DV1bzuwQMXP+/DNWMRSX9jdxRSGN2TnHBxIwlOIKIPeE8hAdHylcGri5Y0W9727z+Lhsy0/aFBQGMCbHEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqA5lC8k5bilXpPL966zhqakBofU13ujBi1eskP14nw=;
 b=Q/C1myajMjD/Nk2x0z1b6ECTLh+1rQrPDquumIW6WO/NWdTGB8OAEauaeuX/A+YdqClH3xrk4IzyAbqEDw3xMwXSVJt+itOwU+CKPSno+a8W71lDH3JD2jimCXZmr2TBT+YaBWMFDnQsrKzE+ZS7yEJbv7nfTzOz9HkuQxkkiNeRH7FVgCMgwfLeahEhMRo821WMSiwAzG5wSsmCYDRhV6Zw1HWjGr4XDJXDDFZySWN8qHnFz4PFrSZ4Djlrb3JFRN0qrKsRhaaVCKDe8MegPZmiXNthFcXXfr5X27hzI/XzLfEH1NxPOanGDy4hU/1QGpqb8T9rJbB7Gla4Rk0QJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqA5lC8k5bilXpPL966zhqakBofU13ujBi1eskP14nw=;
 b=z8a11RbUvW2kpOIWBNFmlpHb8fajikmkanXkfsJwEfY7Ed+VLuC65z82r8MkIG4rnfu3QO20/OHCnyVf0hc/2XMoFDxivMm/XVysmNU9VC7RAFGhmp3+bcXz0Zskd8TIcO18oF9PNui5RviwB3R6hEPS/345c/1Nsf1Mkf0b6cY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.16; Tue, 31 Mar 2026 11:27:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 11:27:23 +0000
Message-ID: <a8e63894-7e6a-4f65-826c-6d59761d8a86@amd.com>
Date: Tue, 31 Mar 2026 13:27:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add CONFIG_GCOV_PROFILE_AMDGPU Kconfig option
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20260326213751.5741-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260326213751.5741-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:208:d4::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 5435cbba-5dd4-489e-3e72-08de8f187a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: IUJBJp0DNb4gADzrBYxyUTt2BQctH5iKW1SV94M8soDPWVwt7kmdrQYRTxE/bg4I8LH0BOA6t0boUcedlflhDqtEgiZYWILwTZTFKJd7D0xlalPA6/Llp5PW/j12f84Lryjv/AuBNyaT5GLW6prPTjMhZNthUkuW5Ce1n1dMAjN/x90Y9IMwpYnsR/eK2AJg/DSGFVq6Pazs9SASwQFHw03vRsyjcQ14qwgAZLNPzVhiZ94Zk8EX3yGLb/l0J9cIVxgiZ62+F+SDfNG9czYBEkz74N2rg1ZyauCwg2WFB4PBHAfNvuYJhcvCzz9Ju+PhV1rENy8l+uEGMjzb2gSWrAdJK85EJTry75M9b9tEIhys2bLhi/Gbc/nJ8BoOTbH3XB/YhmnPJusi/VD2FbSy7CA2tRUyxiFhtzSCOOfY/6yItr8jRxDezSyHQ+nw9yz25mpLuC03QP0T14AcgJxEY2d8JFEZHyXRlKtszVZ9lck1NUwr5yQBHCGPAoLRZgMqaQeF6xc7JXdx5q9ca2Od529Z6xMuA55yvCeoIj9dngmiaaP/4qo/t/mTFv/aNxf1DL2miYZdj/P5J0l3whQ2WYZirP96p5axb+6Vlk71TYxeVATUZEjuTbx637x5cS6fu2cYVqFG+cZkoKNgI2gWs2A/nYZNT//ZfYEqRr5eyvv5pHKH8nFcCmN8m042saPjvWiHLJ2wHp4kPjbpI0zqYYvo49yv1Qb6pCLMCS/+AG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW5MRzQwSEdCZkpYa1JsMXBwdTFFVkNiVTZSTkZEbkNGMDBtbVVZUTgyN1hj?=
 =?utf-8?B?Qnk3Yzh2RGZ1dG9zQ1BUVE9WV2VGTXpMVTNqUXRaNWNybmNXM3RFbFZGODls?=
 =?utf-8?B?ays1d25rK3ROQXA0MVN5ems2bGhvMldkQnIvWFZLUURON2Q1YzVzd0k5WVR1?=
 =?utf-8?B?Snk0WGJ0c1pxWFN2a0o3UGw5WFM2Sk52d3JNNG80VkpVcmpPMFJmcUpaYVk0?=
 =?utf-8?B?RGZZTld6TzNjcFNxRThJMVBmdmhCcGU4RTQyM2NpNmhldTZ6MEx0Ty9tazdZ?=
 =?utf-8?B?MnpIT0NTa1BSbHc3TE1pUWQzQm1EVFdvWXViNDhxWmpTU3p4TFZadFJPZFV5?=
 =?utf-8?B?SExWUnVzWVErcmM1NGVqTzJIUzVKVjZ2cWdZUTZlc1pBb3NibDUzY0FGcWhL?=
 =?utf-8?B?L2VJTDNFd3grakFNUkZud3NoanVYTTY2Z3NvZC9tZDlvdlQwdW5UenVwUXM1?=
 =?utf-8?B?azh0T1I1RDJJbVJlaCtRYTN6YmRrc0Qwd2NEVDdzTFRGWXpraXJ6OVJQZ2Fh?=
 =?utf-8?B?VWRsZm5tdVRHS2dmK0QvMWF1NkozWUpqYWtUeXJseXNzYlZSNEVwcm9WUFVi?=
 =?utf-8?B?NjJpQXR6bVVGNEwvSzU1QUJBWWNpTm15di9BV1VkQVRvR2cwUStHdWY2YVFV?=
 =?utf-8?B?TkdoOXJuYnZ4M3R1cVZJdUZlemlMWk53ai9XVjdBdXF4R0NkNm9vZXd2bk5Z?=
 =?utf-8?B?R0Zmd0doVTdOMmlvLzRBbmd4OGhudXZiV1BHZ0JUcnowM2VKeEtzV3hoZjJt?=
 =?utf-8?B?V3VadGFFc0dlWE5DaXFqZDdoYkpTMmdOQitWc1dMbXNERkRzS1dpeU51TFVQ?=
 =?utf-8?B?UHhSUGVvc3VqVWs0REsyczFlSHpoYkpqbmErNGw5NkRML1FLWlBkd1BZT3RO?=
 =?utf-8?B?clROblFYRHd6NkVzOFR4NHUzWlIxZmR6U0ZQZzM3YUFQYmFwMWZsK2FMVlFX?=
 =?utf-8?B?M21PYlU1RDA4UXhpRUJxZ3lsbnRONllOME1RSDBpaERYS2crM3RJTkpVZWs5?=
 =?utf-8?B?UUc0cFJ1TVdkKzZxMWNhRGlhaVVPN0dEVDdVdkViTWZTYlFtbjJHOFZjSlps?=
 =?utf-8?B?VFVpTXpFRjVCbVhlVVpRbnl0a0tIc2FrdlFLcU8zTTNXSHhXeDZQNC9iaGFW?=
 =?utf-8?B?dHFyK2MrelZhZDZEUTdsZVhtM1FiUGFHL3N0SWsxSlVYcCt5MGNBNFgzWm1G?=
 =?utf-8?B?MUhVblI5MHZvaWM4RFI2YU1yRzBjdW1NUEk3VjdzeEw0SUZWVjJDcVFrSWpv?=
 =?utf-8?B?NVlqdGY0V0dMZDAvaTFaZFpvL0FTd1llNnBoaElZNnE0ZWZpb0xmZHppdXpQ?=
 =?utf-8?B?ZENYWUQ5MUN0QUUxUkZlOVFOSE5YVDJzb0FQYU4yYmVESXlOSm9LcUpBZ1F0?=
 =?utf-8?B?ZkRFK1BpTmpFZSs3Rll4dkhydUJ2MGJtcEQ3dTVleGJ6WUlMNnBlQ3ZqR3Z5?=
 =?utf-8?B?YzdqY3JPQ0llS3ZaQXo5T25aMzlaVHFYRFdJbmpTMkdiejFDcHdnc0ZteERw?=
 =?utf-8?B?ZHRySytnZHpVQjEvR3JPMHVrMHZDN2V4TGJNWjg5Nzg3b3ZWTWZiTDJScGhD?=
 =?utf-8?B?Nk81eVJEcE43VU9CNUw5K2IzUENVbGFOcHpjc2tXUUFYbms4RStYSjk1cGVy?=
 =?utf-8?B?UjR2eVJRenNCTFZpY0FDcHNVNDNydi9MNWpzSkVqc3JORC9IN0lnNVI4SmNt?=
 =?utf-8?B?b05XU0lnSmUxRE1JRG9hQ3VybHZiWE02Nmd1VFRnM0ZvTXNyL2U5YlZINzcz?=
 =?utf-8?B?SjBYSlN4WUVpWmkxY2pBemlkM1JSeFJWT25TTjN2M050LzZLZ0hHeGV1a1Ex?=
 =?utf-8?B?ZmdCa1BjMGViR01McGJYVEg2MVpYV0wrWHVZcXJDS3ZTWnJacms0R2wvWTYz?=
 =?utf-8?B?clZYM3E2R0lTOEViZHc5SDlmc1pSYUt5QlkyZmVIalRod3VvZ2p2bExyOU5W?=
 =?utf-8?B?RHFwMk9PNEZ4alpsSEVQbUV5YlFWNTZwOFZQNGtBL2J5aFVRaFI0ZXdhcjNr?=
 =?utf-8?B?L3VHeE83Smo1Y0Yza1I2M3pYL2RncHhDVTl0cEE2VXkydCtWTjh4cTFvNGtr?=
 =?utf-8?B?bWRWYnpJaElyeFBudGRycU5SZlpnclFURTBCMWRiNjBXSFBmNlB2aGFkTHhG?=
 =?utf-8?B?T0tTejJzU3NyUGV0R0pmRUVZQ09iMFZVTkxrUHpKZ3ltbldCbHVMUkVYcjlQ?=
 =?utf-8?B?TFFBTzFYb0Y5aXY4TWNSVnRyV2NaUHNucmF4ZGEvd1BFeFBBUVllVDFxSzZZ?=
 =?utf-8?B?YitkT1lrbnlwTlZLMkFQby9FZG15aUxSOUVtNlFUR2JmTTFMYlVmWDRnNEd0?=
 =?utf-8?Q?S1tWBre/KloKlKEuNM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5435cbba-5dd4-489e-3e72-08de8f187a68
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:27:23.0651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEhKcVLAB2lSeZggBGb0JPkhzl+mCCXaQdicLUwwVVBNs9ODn9sZs+mogwoXvmn/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
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

On 3/26/26 22:37, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> Add a Kconfig option to enable GCOV code coverage profiling for the
> amdgpu driver, following the established upstream pattern used by
> CONFIG_GCOV_PROFILE_FTRACE (kernel/trace), CONFIG_GCOV_PROFILE_RDS
> (net/rds), and CONFIG_GCOV_PROFILE_URING (io_uring).
> 
> This allows CI systems to enable amdgpu code coverage entirely via
> .config (e.g., scripts/config --enable GCOV_PROFILE_AMDGPU) without
> manually editing the amdgpu Makefile. The option depends on both
> DRM_AMDGPU and GCOV_KERNEL, defaults to n, and is therefore never
> enabled in production or distro builds.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/Kconfig  | 17 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/Makefile |  4 ++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
> index 7f515be5185d..7fb0b93bc1ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -103,6 +103,23 @@ config DRM_AMDGPU_WERROR
>  	  Add -Werror to the build flags for amdgpu.ko.
>  	  Only enable this if you are warning code for amdgpu.ko.
>  
> +
> +config GCOV_PROFILE_AMDGPU
> +	bool "Enable GCOV profiling on amdgpu"
> +	depends on DRM_AMDGPU
> +	depends on GCOV_KERNEL
> +	default n
> +	help
> +	  Enable GCOV profiling on the amdgpu driver for checking which
> +	  functions/lines are executed during testing. This adds compiler
> +	  instrumentation flags to all amdgpu source files, producing
> +	  .gcda/.gcno coverage data accessible via debugfs.
> +
> +	  This increases the amdgpu module size by ~50% and adds ~2-5%
> +	  runtime overhead on GPU submission paths.
> +
> +	  If unsure, say N.
> +
>  source "drivers/gpu/drm/amd/acp/Kconfig"
>  source "drivers/gpu/drm/amd/display/Kconfig"
>  source "drivers/gpu/drm/amd/amdkfd/Kconfig"
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 6a7e9bfec59e..db66c6372199 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -27,6 +27,10 @@ FULL_AMD_PATH=$(src)/..
>  DISPLAY_FOLDER_NAME=display
>  FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
>  
> +ifdef CONFIG_GCOV_PROFILE_AMDGPU
> +GCOV_PROFILE := y
> +endif
> +
>  ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
>  	-I$(FULL_AMD_PATH)/include \
>  	-I$(FULL_AMD_PATH)/amdgpu \

