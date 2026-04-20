Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7709F557ED
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 09:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5603E10E11C;
	Mon, 20 Apr 2026 09:05:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nt9zOfAu";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 643A410E11C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 09:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEWN8jO7BXaVylNFgoJiERRfX1ZaVdNaYSE1quiNFbLP7z9QMmf1NuRBE2BYLtpuKSGitiAHIHUwyc/R+RGKo2engPFlAAFOV2Ws2WQz7+KHxlKGpiMIRrKR5jn2pKD0rkDXm3RYxc4AY2QzLpFrtAievJpgbrGex59iaffTArnK6wZK1BgGnN9CK1Z7Pd7WMP8ZMv5fhc4tM/EjVIFQpr+k4OOqG6lRNXMDGszPj351V5kdUiFvNF77/zpXaYlcyVCRpxZK0HMUmcAHd2kDsXVl6XLdJDaAwUotjU/wA62NAXf/nYi2p7I2T/3JgG9Pa0jh4uOMO5RmwUaj3oc0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqu2NvC1a8kmbmUGuKdy/jZbqHji1O6YjT1tAjvXaEs=;
 b=ouSFlrRNbVAVuzI/VfxjgOxGTRvgXY4wsMfgPsEBlOpEuXXb/pfxK2/rj1vBhyergpzcgsaf+7hhyo4KU30PznZiZdBJ2qMG2z+84j9eymeC1SoUCLqc+fcE6Fyv/9KNLqCsInQ0/Q396WgejWRmMJ8fd6zdOT6JzbmwM2vUZyARXvs+XUYe+bCgXOrOAMGtCxnCuY0OZsoRR4vM6Tkd8BBSpgbau9no9GUjpwsQ7m0bITMCqqmBMBwNL62u0sSBLImezNznZ49bicInFfwVEQApW7If1DZzJc+1SxCKNl5kaJfmrqkiH9p5hBkYRRMHCSEotQ5e3Mo7FpvuEceyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqu2NvC1a8kmbmUGuKdy/jZbqHji1O6YjT1tAjvXaEs=;
 b=Nt9zOfAuiMsniAYGQeI0LNCCbJwIzysS9TM1IcPstCgILzuaRjv/MOQaduZVC7zJS8jy6BxHL7r6dGkXJEHKmJwpwnEaqnImOcHhqcfQQofEWm5ZdVAWJH3w0YTLZ6jy6slVtxvBT5Pr3xGcGUGOJVBag5o+adeA3klr33nXWVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 09:05:00 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 09:05:00 +0000
Message-ID: <8f0fbad4-fc60-40a7-a8ab-3962e6b8ecd4@amd.com>
Date: Mon, 20 Apr 2026 11:04:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: unify gmc v10 and v11 get_vm_pde and
 get_vm_pte into common helpers
To: Andre Hirata <andrejhirata@usp.br>, alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, gabriel.dimant@usp.br,
 guilhermesangabriel@usp.br
References: <20260418201545.20673-1-andrejhirata@usp.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260418201545.20673-1-andrejhirata@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: c094b912-5e1d-4490-c34a-08de9ebbe692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: MvtvHAXin8XZlu/gy66t/GpXwACS1kvqDtanDym3alFfSP8CBBn3GrdsbasQa9otRPojVA6xzcb45kIzzcpJ9Ym80iY3nLGlEU5HNV8IPxWU1BwZWC5t1s9+ftpaR8DXUjtjzXRubSM/b0f2UGpbgHQRjlHYoAYQZNatMuli/HrKGWsn+sud//i1aIXQG6nU2TLBHHBM+JFvq4KdyiOZJCJ58EtD/W0Gh/rTMSrtX9ieRX7PHvqfP13igbxl0fDohysNsYDPBpBRxptcjcI272ocji4V73FtfEDtOAAueOGYYmEYqTy4jF+pEwCRIWHFG2wBtZhh4hy9mAshUBRCTxyyqcm3IDr+Ysycv5uiPHOEofZm2+NTJ243emaiwn2tNKyXDh0thWhRYF3WIcHN527eUl8lmHNHWmhWOhPKHFAAmprswHDCJAxElICBEWcSs/9ltmfW/pP5yrAiqsOEZLljSVpNKw0qoMKHbJ2qdxxeec2Mhf5PIixssCC+vJloLGbJjn0xQkqKXSRsCoOUNlcAz2zaRJWOmKc4qLmfpGS/HL38uZZeR4rbhQMckChXm7fCD2p6C52KBRpGvzjFJn+o+5G0RENB5ohNqBCGbUo/ihtzh/I4XE4gVJjsFKaYTeZ7yD+z9TefFX0+FJmbRX+bP7xu05TT8CjoyrjYt9dT6xU5BdBdf92WXE+jLgyxtNd7MYAq7rVPEnubuW1ZbbvwT00G7wM7Mo4mc9TAWR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnhlOWhOTzNvcU9jWFFBMlZQMmlsVlg4MENqVFFHOERNTVY2TkxVZW5WKzVI?=
 =?utf-8?B?WExJK2FmQVJDbmw4V3dNbmZ3TnVDbXgxaXVXeHFVTHdreFhCVmFaQ3Zyb2Fy?=
 =?utf-8?B?V3F6RjNkQ0JObWgreFkwdE9IUTFxZHRKbU9JRDRGV3ZCRjAvVUtpeEc5OEJE?=
 =?utf-8?B?dG9PaUZGWG5UemN0aE5FTDF0cTZldnZQeHA3ZVpHRWcrTGRtS2djUXdPVVho?=
 =?utf-8?B?YkhrakE3eER2RTRvQlVaaS9nQ1VyemZMcG93bUs4VEJxYlJzdFR2SlJXZ3BG?=
 =?utf-8?B?M1hlUjhXdjVhT2c1b1dXM1l5NG9rcGhVYW1ZaE9QZGRqT1VEWHVPWTkvNG1Q?=
 =?utf-8?B?NVo1UnF2UkdIK29EQzNJa2ZRdEFodFY2bFhENkJHY2lSUE1BOUZtcDh5eUZ1?=
 =?utf-8?B?dlRtcWZXZ2hVbWFZaHNXSFlmcVV2N0ZnT0VkcGFQelhRcG52TmttRmNySnd2?=
 =?utf-8?B?M1NqT3hPVWZKK1VwOHNqSGNzTmFOQkdXNTNuUmIvQkx6NDJNcjdORkdydGtE?=
 =?utf-8?B?R3M5ekJQQTVlTkZmc0p4aVp2ZlQ5a2VxZkVyZG0yUkhnbmNpd2VJRnR0cS8z?=
 =?utf-8?B?elFRY09VamIvaFg4NkZQaUozaEI4MlBLSktMNUhNM0JuRUNjRUp4WnllMFh6?=
 =?utf-8?B?ZFF6ZGlwdHdVVzh6WFU2ZUdwZThDcTBFbzBRWHo1N2JYMVZRWGMrcVR5VFF1?=
 =?utf-8?B?SGUxZXB6R21vNzhFMTdHWUIyT2hMc251NUZTaklXcWc4M0JGM0hjYXg3czNr?=
 =?utf-8?B?ZFlHMERieGEwVDJ3M3BzcU1ENDkwcW5qdlNPdHEyVHdCTDAxb2dBNlU1TGhI?=
 =?utf-8?B?NXVWNldhUkVVWis5YU5oemg3QmtBSHlNdnU2dkkvYm5Icm52a2s2NGNNV1Iw?=
 =?utf-8?B?d0NDSE16S0tWZS9LOTBBMFluaFNtOHJ3NVZxWjFpLzFRa2tZOU1SdHptNzJ3?=
 =?utf-8?B?dkRybDlMNGx5WGpOeUFjeDljbDdkVytNd3UvZlFvSjc1L21icjRkdHhGVU1h?=
 =?utf-8?B?cmZLY0QrZEdFZU9md3FZZmRKUDkwbmZLM3JvYW43ZkcyUWRtZDdPMVprMEhN?=
 =?utf-8?B?dkpTSjNWei9NbEV4UEllaXZpcDM3L1BOYlNzT05oSTJRMjV1TURPdUtpZXhw?=
 =?utf-8?B?U0NtNTZlZnFmL1kzdFBLNGVnaEFIN2l1TjZNdVdEZ2ZwTTFNaUVMclB5bmFh?=
 =?utf-8?B?SkpvdTZGdmYxNERLY2VBNWxSakhqcXZLSnR6U09PdHdKTlQwd0ozSzJrVjVx?=
 =?utf-8?B?OHRneUlIZFA1QUZiOTlwaU1QZnU5WDdTNmdKK0ZINXlQcWljZkQzYmc0MUl5?=
 =?utf-8?B?S1RlTmJFTkJabGhHZ0lhVmxsV0NDTWJ4QUpyNTFRanZJazJsY3N0NVFwa0tu?=
 =?utf-8?B?b2Q0SFJsaVB4bmwwd0w4aFQzL2ZHc1dmNUtNN3Z0REtXM0kvMll3WTVVdThZ?=
 =?utf-8?B?dzdUZzgwRWpUWDBQR2VQelRkbTlSNWJ3RThCd2NURkxCNXZSN1dUaFNFM0x6?=
 =?utf-8?B?QmNJeVB6WVBPbzk2bzl0UXBWL0JTek10aWU4QjBOam5lZjBpNG93Ym1iSURD?=
 =?utf-8?B?elBLdFl0Q1hRNXhiNHpQR2pMZDViQTd6dUljUmIxMHgySmMrUVBhNzdjRW80?=
 =?utf-8?B?QXRTeDB4TTY3b2xBWFRGSEtNeEg5RjhjYXFQV2NUZC9kV1RMeXZWNGF6QnpP?=
 =?utf-8?B?T1NNb1JSbS9LV0hXd044UGkxQ0lveWc2ZFg1ZFl3b0RBWmJNZE1RYm0yd2Rz?=
 =?utf-8?B?T2tLTlRzSXV1MjhnTkxOQXcweUIxQ25oamREaDhmazE1LzYzYmRiemxyNWkw?=
 =?utf-8?B?R2dWZ0UxNkZ6OC82aWRRejNqdlNpNVhyNXAxYUhpTm9BdUVObmI3UTZ0Wlox?=
 =?utf-8?B?WDlZL2JVdmdQQzV6QnJTMmo1MUFhUlVIOHpCUjBKSXlicytlRTZPeWx3QzMy?=
 =?utf-8?B?N21oVU9VSjVtRjY1Y01zQ1hZL0c0TDhlMzdRTVNlMHRsNWhucG9KZDVlaXhF?=
 =?utf-8?B?QkxtQ05DMkpQczBPRi83NTBQbDdFdWVUVTdOb3ZMRVVBcllZbjdDUHRNa0Nx?=
 =?utf-8?B?NEIza2hucGpsR1g3c2puMnU0U0pQVkJkMWhrQkZienM3dlJGVXVmaVBXSEt4?=
 =?utf-8?B?WGUzYTYyR1VENjBwWnEwMDZ2WVZuTlBQOVpTK0lSbWJNbUxrQXgyVDQ3OGVh?=
 =?utf-8?B?Mm1xdW9iOE5GQk81U3ZzcnZQRmUxVW93L3dXOGhzNGU5MTMyMGIzMUFRQVVN?=
 =?utf-8?B?ZG1sZ0ZId21FeXhMd2ZkUTVTUTNFbFA1TE14czZ4aUpiMjRCaGc0K3lJdE5k?=
 =?utf-8?Q?Y8TAvtTqjJh1jhZW8L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c094b912-5e1d-4490-c34a-08de9ebbe692
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 09:04:59.9820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REnf2ub52tN7scewndiIBNT1cqE9LVuWRJreq/csbgWALD/hoCKWSDXJqgGzrjzw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199
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

On 4/18/26 22:15, Andre Hirata wrote:
> gmc_v10_0_get_vm_pde, gmc_v10_0_get_vm_pte and their v11 counterparts
> are identical. Move the shared implementation to amdgpu_gmc.c as
> amdgpu_gmc_get_vm_pde and amdgpu_gmc_get_vm_pte, and update both
> gmc_v10_0 and gmc_v11_0 to use the common helpers to eliminate
> code duplication.

Well again this is *not* something we want to do. Those functions are intentionally separated.

Regards,
Christian.

> 
> No functional changes intended. BUG_ON preserved from original
> gmc_v10_0 and gmc_v11_0 implementations.
> 
> Signed-off-by: Andre Hirata <andrejhirata@usp.br>
> Co-developed-by: Gabriel Dimant <gabriel.dimant@usp.br>
> Signed-off-by: Gabriel Dimant <gabriel.dimant@usp.br>
> Co-developed-by: Guilherme Gabriel <guilhermesangabriel@usp.br>
> Signed-off-by: Guilherme Gabriel <guilhermesangabriel@usp.br>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  76 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   7 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 119 +++++-------------------
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 119 +++++-------------------
>  4 files changed, 131 insertions(+), 190 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 290b9f904..bd7b0a269 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -36,6 +36,7 @@
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_atomfirmware.h"
> 
> +#include "navi10_enum.h"
>  #include <drm/drm_drv.h>
>  #include <drm/ttm/ttm_tt.h>
> 
> @@ -1782,3 +1783,78 @@ int amdgpu_gmc_get_vram_info(struct amdgpu_device *adev,
>         }
>         return 0;
>  }
> +
> +/*
> + * Common get_vm_pde implementation for gmc v10 and v11.
> + */
> +void amdgpu_gmc_get_nv_vm_pde(struct amdgpu_device *adev, int level,
> +                           uint64_t *addr, uint64_t *flags)
> +{
> +       if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
> +               *addr = amdgpu_gmc_vram_mc2pa(adev, *addr);
> +       BUG_ON(*addr & 0xFFFF00000000003FULL);
> +
> +       if (!adev->gmc.translate_further)
> +               return;
> +
> +       if (level == AMDGPU_VM_PDB1) {
> +               /* Set the block fragment size */
> +               if (!(*flags & AMDGPU_PDE_PTE))
> +                       *flags |= AMDGPU_PDE_BFS(0x9);
> +       } else if (level == AMDGPU_VM_PDB0) {
> +               if (*flags & AMDGPU_PDE_PTE)
> +                       *flags &= ~AMDGPU_PDE_PTE;
> +               else
> +                       *flags |= AMDGPU_PTE_TF;
> +       }
> +}
> +
> +/*
> + * Common get_vm_pte implementation for gmc v10 and v11.
> + */
> +void amdgpu_gmc_get_nv_vm_pte(struct amdgpu_device *adev,
> +                           struct amdgpu_vm *vm,
> +                           struct amdgpu_bo *bo,
> +                           uint32_t vm_flags,
> +                           uint64_t *flags)
> +{
> +       if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
> +               *flags |= AMDGPU_PTE_EXECUTABLE;
> +       else
> +               *flags &= ~AMDGPU_PTE_EXECUTABLE;
> +
> +       switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
> +       case AMDGPU_VM_MTYPE_DEFAULT:
> +       case AMDGPU_VM_MTYPE_NC:
> +       default:
> +               *flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_NC);
> +               break;
> +       case AMDGPU_VM_MTYPE_WC:
> +               *flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_WC);
> +               break;
> +       case AMDGPU_VM_MTYPE_CC:
> +               *flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_CC);
> +               break;
> +       case AMDGPU_VM_MTYPE_UC:
> +               *flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
> +               break;
> +       }
> +
> +       if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
> +               *flags |= AMDGPU_PTE_NOALLOC;
> +       else
> +               *flags &= ~AMDGPU_PTE_NOALLOC;
> +
> +       if (vm_flags & AMDGPU_VM_PAGE_PRT) {
> +               *flags |= AMDGPU_PTE_PRT;
> +               *flags |= AMDGPU_PTE_SNOOPED;
> +               *flags |= AMDGPU_PTE_LOG;
> +               *flags |= AMDGPU_PTE_SYSTEM;
> +               *flags &= ~AMDGPU_PTE_VALID;
> +       }
> +
> +       if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +                              AMDGPU_GEM_CREATE_EXT_COHERENT |
> +                              AMDGPU_GEM_CREATE_UNCACHED))
> +               *flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 6ab4c1e29..a852ed8ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -484,4 +484,11 @@ void amdgpu_gmc_init_sw_mem_ranges(struct amdgpu_device *adev,
>                                    struct amdgpu_mem_partition_info *mem_ranges);
>  int amdgpu_gmc_get_vram_info(struct amdgpu_device *adev,
>                 int *vram_width, int *vram_type, int *vram_vendor);
> +void amdgpu_gmc_get_nv_vm_pde(struct amdgpu_device *adev, int level,
> +                           uint64_t *addr, uint64_t *flags);
> +void amdgpu_gmc_get_nv_vm_pte(struct amdgpu_device *adev,
> +                           struct amdgpu_vm *vm,
> +                           struct amdgpu_bo *bo,
> +                           uint32_t vm_flags,
> +                           uint64_t *flags);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index e1ace7d44..129c7fc4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -418,6 +418,28 @@ static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
>         amdgpu_ring_emit_wreg(ring, reg, pasid);
>  }
> 
> +static unsigned int gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
> +{
> +       u32 d1vga_control = RREG32_SOC15(DCE, 0, mmD1VGA_CONTROL);
> +       unsigned int size;
> +
> +       if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
> +               size = AMDGPU_VBIOS_VGA_ALLOCATION;
> +       } else {
> +               u32 viewport;
> +               u32 pitch;
> +
> +               viewport = RREG32_SOC15(DCE, 0, mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
> +               pitch = RREG32_SOC15(DCE, 0, mmHUBPREQ0_DCSURF_SURFACE_PITCH);
> +               size = (REG_GET_FIELD(viewport,
> +                                       HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
> +                               REG_GET_FIELD(pitch, HUBPREQ0_DCSURF_SURFACE_PITCH, PITCH) *
> +                               4);
> +       }
> +
> +       return size;
> +}
> +
>  /*
>   * PTE format on NAVI 10:
>   * 63:59 reserved
> @@ -450,106 +472,13 @@ static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
>   * 1 system
>   * 0 valid
>   */
> -
> -static void gmc_v10_0_get_vm_pde(struct amdgpu_device *adev, int level,
> -                                uint64_t *addr, uint64_t *flags)
> -{
> -       if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
> -               *addr = amdgpu_gmc_vram_mc2pa(adev, *addr);
> -       BUG_ON(*addr & 0xFFFF00000000003FULL);
> -
> -       if (!adev->gmc.translate_further)
> -               return;
> -
> -       if (level == AMDGPU_VM_PDB1) {
> -               /* Set the block fragment size */
> -               if (!(*flags & AMDGPU_PDE_PTE))
> -                       *flags |= AMDGPU_PDE_BFS(0x9);
> -
> -       } else if (level == AMDGPU_VM_PDB0) {
> -               if (*flags & AMDGPU_PDE_PTE)
> -                       *flags &= ~AMDGPU_PDE_PTE;
> -               else
> -                       *flags |= AMDGPU_PTE_TF;
> -       }
> -}
> -
> -static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
> -                                struct amdgpu_vm *vm,
> -                                struct amdgpu_bo *bo,
> -                                uint32_t vm_flags,
> -                                uint64_t *flags)
> -{
> -       if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
> -               *flags |= AMDGPU_PTE_EXECUTABLE;
> -       else
> -               *flags &= ~AMDGPU_PTE_EXECUTABLE;
> -
> -       switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
> -       case AMDGPU_VM_MTYPE_DEFAULT:
> -       case AMDGPU_VM_MTYPE_NC:
> -       default:
> -               *flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_NC);
> -               break;
> -       case AMDGPU_VM_MTYPE_WC:
> -               *flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_WC);
> -               break;
> -       case AMDGPU_VM_MTYPE_CC:
> -               *flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_CC);
> -               break;
> -       case AMDGPU_VM_MTYPE_UC:
> -               *flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
> -               break;
> -       }
> -
> -       if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
> -               *flags |= AMDGPU_PTE_NOALLOC;
> -       else
> -               *flags &= ~AMDGPU_PTE_NOALLOC;
> -
> -       if (vm_flags & AMDGPU_VM_PAGE_PRT) {
> -               *flags |= AMDGPU_PTE_PRT;
> -               *flags |= AMDGPU_PTE_SNOOPED;
> -               *flags |= AMDGPU_PTE_LOG;
> -               *flags |= AMDGPU_PTE_SYSTEM;
> -               *flags &= ~AMDGPU_PTE_VALID;
> -       }
> -
> -       if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> -                              AMDGPU_GEM_CREATE_EXT_COHERENT |
> -                              AMDGPU_GEM_CREATE_UNCACHED))
> -               *flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
> -}
> -
> -static unsigned int gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
> -{
> -       u32 d1vga_control = RREG32_SOC15(DCE, 0, mmD1VGA_CONTROL);
> -       unsigned int size;
> -
> -       if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
> -               size = AMDGPU_VBIOS_VGA_ALLOCATION;
> -       } else {
> -               u32 viewport;
> -               u32 pitch;
> -
> -               viewport = RREG32_SOC15(DCE, 0, mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
> -               pitch = RREG32_SOC15(DCE, 0, mmHUBPREQ0_DCSURF_SURFACE_PITCH);
> -               size = (REG_GET_FIELD(viewport,
> -                                       HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
> -                               REG_GET_FIELD(pitch, HUBPREQ0_DCSURF_SURFACE_PITCH, PITCH) *
> -                               4);
> -       }
> -
> -       return size;
> -}
> -
>  static const struct amdgpu_gmc_funcs gmc_v10_0_gmc_funcs = {
>         .flush_gpu_tlb = gmc_v10_0_flush_gpu_tlb,
>         .flush_gpu_tlb_pasid = gmc_v10_0_flush_gpu_tlb_pasid,
>         .emit_flush_gpu_tlb = gmc_v10_0_emit_flush_gpu_tlb,
>         .emit_pasid_mapping = gmc_v10_0_emit_pasid_mapping,
> -       .get_vm_pde = gmc_v10_0_get_vm_pde,
> -       .get_vm_pte = gmc_v10_0_get_vm_pte,
> +       .get_vm_pde = amdgpu_gmc_get_nv_vm_pde,
> +       .get_vm_pte = amdgpu_gmc_get_nv_vm_pte,
>         .get_vbios_fb_size = gmc_v10_0_get_vbios_fb_size,
>  };
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 94d6631ce..f1ac292b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -410,6 +410,28 @@ static void gmc_v11_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
>         amdgpu_ring_emit_wreg(ring, reg, pasid);
>  }
> 
> +static unsigned int gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
> +{
> +       u32 d1vga_control = RREG32_SOC15(DCE, 0, regD1VGA_CONTROL);
> +       unsigned int size;
> +
> +       if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
> +               size = AMDGPU_VBIOS_VGA_ALLOCATION;
> +       } else {
> +               u32 viewport;
> +               u32 pitch;
> +
> +               viewport = RREG32_SOC15(DCE, 0, regHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
> +               pitch = RREG32_SOC15(DCE, 0, regHUBPREQ0_DCSURF_SURFACE_PITCH);
> +               size = (REG_GET_FIELD(viewport,
> +                                       HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
> +                               REG_GET_FIELD(pitch, HUBPREQ0_DCSURF_SURFACE_PITCH, PITCH) *
> +                               4);
> +       }
> +
> +       return size;
> +}
> +
>  /*
>   * PTE format:
>   * 63:59 reserved
> @@ -441,106 +463,13 @@ static void gmc_v11_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
>   * 1 system
>   * 0 valid
>   */
> -
> -static void gmc_v11_0_get_vm_pde(struct amdgpu_device *adev, int level,
> -                                uint64_t *addr, uint64_t *flags)
> -{
> -       if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
> -               *addr = amdgpu_gmc_vram_mc2pa(adev, *addr);
> -       BUG_ON(*addr & 0xFFFF00000000003FULL);
> -
> -       if (!adev->gmc.translate_further)
> -               return;
> -
> -       if (level == AMDGPU_VM_PDB1) {
> -               /* Set the block fragment size */
> -               if (!(*flags & AMDGPU_PDE_PTE))
> -                       *flags |= AMDGPU_PDE_BFS(0x9);
> -
> -       } else if (level == AMDGPU_VM_PDB0) {
> -               if (*flags & AMDGPU_PDE_PTE)
> -                       *flags &= ~AMDGPU_PDE_PTE;
> -               else
> -                       *flags |= AMDGPU_PTE_TF;
> -       }
> -}
> -
> -static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
> -                                struct amdgpu_vm *vm,
> -                                struct amdgpu_bo *bo,
> -                                uint32_t vm_flags,
> -                                uint64_t *flags)
> -{
> -       if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
> -               *flags |= AMDGPU_PTE_EXECUTABLE;
> -       else
> -               *flags &= ~AMDGPU_PTE_EXECUTABLE;
> -
> -       switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
> -       case AMDGPU_VM_MTYPE_DEFAULT:
> -       case AMDGPU_VM_MTYPE_NC:
> -       default:
> -               *flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_NC);
> -               break;
> -       case AMDGPU_VM_MTYPE_WC:
> -               *flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_WC);
> -               break;
> -       case AMDGPU_VM_MTYPE_CC:
> -               *flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_CC);
> -               break;
> -       case AMDGPU_VM_MTYPE_UC:
> -               *flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
> -               break;
> -       }
> -
> -       if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
> -               *flags |= AMDGPU_PTE_NOALLOC;
> -       else
> -               *flags &= ~AMDGPU_PTE_NOALLOC;
> -
> -       if (vm_flags & AMDGPU_VM_PAGE_PRT) {
> -               *flags |= AMDGPU_PTE_PRT;
> -               *flags |= AMDGPU_PTE_SNOOPED;
> -               *flags |= AMDGPU_PTE_LOG;
> -               *flags |= AMDGPU_PTE_SYSTEM;
> -               *flags &= ~AMDGPU_PTE_VALID;
> -       }
> -
> -       if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> -                              AMDGPU_GEM_CREATE_EXT_COHERENT |
> -                              AMDGPU_GEM_CREATE_UNCACHED))
> -               *flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
> -}
> -
> -static unsigned int gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
> -{
> -       u32 d1vga_control = RREG32_SOC15(DCE, 0, regD1VGA_CONTROL);
> -       unsigned int size;
> -
> -       if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
> -               size = AMDGPU_VBIOS_VGA_ALLOCATION;
> -       } else {
> -               u32 viewport;
> -               u32 pitch;
> -
> -               viewport = RREG32_SOC15(DCE, 0, regHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
> -               pitch = RREG32_SOC15(DCE, 0, regHUBPREQ0_DCSURF_SURFACE_PITCH);
> -               size = (REG_GET_FIELD(viewport,
> -                                       HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
> -                               REG_GET_FIELD(pitch, HUBPREQ0_DCSURF_SURFACE_PITCH, PITCH) *
> -                               4);
> -       }
> -
> -       return size;
> -}
> -
>  static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {
>         .flush_gpu_tlb = gmc_v11_0_flush_gpu_tlb,
>         .flush_gpu_tlb_pasid = gmc_v11_0_flush_gpu_tlb_pasid,
>         .emit_flush_gpu_tlb = gmc_v11_0_emit_flush_gpu_tlb,
>         .emit_pasid_mapping = gmc_v11_0_emit_pasid_mapping,
> -       .get_vm_pde = gmc_v11_0_get_vm_pde,
> -       .get_vm_pte = gmc_v11_0_get_vm_pte,
> +       .get_vm_pde = amdgpu_gmc_get_nv_vm_pde,
> +       .get_vm_pte = amdgpu_gmc_get_nv_vm_pte,
>         .get_vbios_fb_size = gmc_v11_0_get_vbios_fb_size,
>  };
> 
> --
> 2.43.0
> 

