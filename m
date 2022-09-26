Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB6AC07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 06:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 262BB10E523;
	Mon, 26 Sep 2022 06:38:17 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F7610E523
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 06:38:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIlXc/3qF5sccFIs7WbJQ73SUR7CqpngGFI1GnOpKa20HYnL5IP+d0rml5+aESkYcq2BigXXqeZtjDstZwh4ySnWO2KOhEHFTkKzXou5bsNrLJiu4Akunq39cNOKgf0Wus7erNiF1eIIqZbizQCxeA9Q4r9qwBD3A0aFK5rp4XEtg9qtQxy7qPYXsfTnxFZJXWy5TpxGuxVCN83EIUlDDOeCyLdFUHihM/NxKnP4kUqIvJElMCdGYMiKSN2cY9StscPBNAlJhWEvneDbfTKrNKFaCkXCkdNWgMbFk/RQ0F0NRCZ6Od2kevfbqsDwDUFk3X50pJjzwxdHWt8EIYgAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkyEokJ/uDdH46zM9D8XXXztCzu46GZGp4pliEhdDpY=;
 b=D2Y4AMZKRDYWg71xBs4aC0Acclw6L41s2hgxD3rhFon5N62gyG5JLHSPN83nvB9F2XmOecGAIwh4dNzi1jCY7l2f21KGqBV4YGl9ovaLKRfbDhXJBbY+ICIk5ZWDB9nBIWQVYiYV0Xn1x1fXcRF/pUZlXoDexORxxgFdcXVQmGELRLDdxdO7luazzBeEwIGymY+ZK7kvmBSKRq656qYJ9domg8ggUKVUnVthiiUeWP3JxSe5SutWuqyM0/XFDdNA2vZvo3vwBPESsINI1bJyay+5BIlDSe2ndgVbHglu0ZUne914SXIApYVXdQSgEWiOkT0VVXQO9wcjxB25tpuUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkyEokJ/uDdH46zM9D8XXXztCzu46GZGp4pliEhdDpY=;
 b=yGxLviJeEPmfqBTofYxTBc6XkcfXsm8iJjh5u2nG3U17DiCdeL8g0tpPhwsmuGNOSmPCVv1VYte4+fX+9yfIwUv5pcrv/2E30I2yNL6b3aP1FT+WZxrBBg9kzWNpBpV6A0lP/uonZNnGXrgEy8pfG+lXjasOE5Pgh3rHHe/95Bo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6331.namprd12.prod.outlook.com (2603:10b6:208:3e3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 06:38:09 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 06:38:09 +0000
Message-ID: <12eafb4b-3997-5c10-ca36-b93fb4cec5ca@amd.com>
Date: Mon, 26 Sep 2022 08:38:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring (v7)
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220923131630.1260501-1-jiadong.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220923131630.1260501-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ad9b88-99c4-495e-b7d2-08da9f89ad68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLiH8jThu5vHxRRprZ2IgMrKwNPeLXaOTlGTgUotKjHg8SbjN4EpbwT4nvhohpIXDTbYeBbnhWz0DK0a6+3f2/YaTszpd+px39kLTVoZ4Mfbegltmsp+vas5tAVvBoUATbL9tydA+FoxALVHxcAyNF+zR00A9EsTVczg77jd+8FqSLB8xqFw1NJGLBzusc5FZTciy/YYeHgTEf9quj7Nb/Em7bfPotlpZagr6hZpEClwTBDXHabrEyLSOGoOnFmqluKu0gInKKVgHyv96jKYkiluo21qjn6PDSiMxbf4KokesG1ChLlH6T6DKkXOs7P0vJCwjPmTN9HpL24C/lAT2+tWMUUFzuODGa7TWmdYaPHcA+h2Fue2uI5yM9XctkExErHNEUU5GYMH1VM3RmZzAu1YoWJ3apty1M/hXzf1pWLccfFBnFPDHfMpluNWdSBjfaEuFCKBP5oDuXoR9k8uqKv1Npk3Y/xRxSFbi2ahciBcnNMTa5Ge9nsmHXQC+YHw4+W7MU9CcQLe2W8Kt/i4ay9BK8BZEdfQLQFgQCyFErrPNFxCjK5KoXFVukhHWRWu+nH4jUAx999OF14XyHJl6BPzPMdFXLSvLc9BEp8BJuEryuxI9VD069dlg4Vp0LE5GOGKuF+Jh/j/JwEqVHWOP+MBg7rs7PrIYR1EJW+kO55cVFJ0x2U1W0lBwxg7k1P2As7FhjzYTA1blwVShNh7VxXjc8avPiDguTko7Od7Aoqpo0/y9Em8rj+Q/5J4rPFMNQVZCRdpyr4u2dzMV9+jqItyJDg10akVRM/MtXdFbxc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(30864003)(66899012)(86362001)(6512007)(31686004)(5660300002)(6506007)(2616005)(41300700001)(2906002)(478600001)(4326008)(8676002)(66946007)(186003)(6486002)(31696002)(36756003)(66476007)(66556008)(8936002)(54906003)(38100700002)(83380400001)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEZLYndwMCthbGhDM0x5UlgvNzNaMzZaU213NG1PYVlVQmcyejJhVmlnSCtW?=
 =?utf-8?B?emVhMnV5elhPbndWaGVEenFPZWFXcFZBSGY5SXRvZkE3Q1cxNmE1K1Zic3Y3?=
 =?utf-8?B?VnhsQzRnMlFmQnBjdzNhYjhUelNUbWtlVXFnZjhFeWh0RlZOREp5citQU2dm?=
 =?utf-8?B?UCttejYrWW1PNlZTVllOcWVGUURrNkNjNkhVL0N1c010U3VlRy9aaWNpQ1F5?=
 =?utf-8?B?QkNHcWFtZWR4UE5pUzZJakVVWllObTAzaURGV09jNm5QUy91NUcvSjVKVm0y?=
 =?utf-8?B?VENLcVVVTEdKWE9LTUtUMXFBUEo1Z0tNcitrdUk1OE1wc3B5M3hBMUdVSG9m?=
 =?utf-8?B?Q2U5ZkYzN0YxMjZScmd2ZVphaHRlWUVVeFZqS3JlK3lIWVRYdXZZOEFVSUxQ?=
 =?utf-8?B?L21KUWgvNml5WVRyOWFtWXY4N1k1cXlUWnhHNmtWVk5IVVkreVkwOGFtdFIv?=
 =?utf-8?B?YzlRMGp2L3R2Ti9USnB5QmdMekNOdSsyVnJ6Vk1HN3B2YzVMaUpRcVAvWDd1?=
 =?utf-8?B?Z1NacGVMN2x4R3g4STdlZmJYQzUzbUF6TFhQMm5Xd2FyS0dvV1dKNUhJWnJ0?=
 =?utf-8?B?dXhvbXZhMlF0TDBzd1orL29FZExZbG1hbzRiaUJEcHFOK25aOFhGekR3aU1z?=
 =?utf-8?B?SFEzcjRWZzNRSnkrYWlBSkY0dEkvc1lUZE5FMWZER2xZWDNCVTNuZzFJcDR5?=
 =?utf-8?B?T2p6V1pNeVF3QTVjOE9vdFh5VWJkU0ZzdFRydzdJbHNIc0tJcGszRXhWNlYz?=
 =?utf-8?B?NU5oOGhsdGJqWEN5Vi9FSFB3NVlUMExZU0NOQmV2dzF2bXI2KzIxTDR6RGd4?=
 =?utf-8?B?ekhqWFRiYVgwRnhvZFJxZ2FuRDk2WjhIRFAwdjZMSm9aNXUweURVN3VkRjlr?=
 =?utf-8?B?bUo3SkNqRzUyZFBoVmU3cXJrNzVvdE4zTkhscDBicDlDeUs1elVzd0wrTkFI?=
 =?utf-8?B?c2Jmd0RPZEJDV1JQV1dXYWcwbldoYXM2eUlpSEVQRlk2U3dFcWdPdGlHU0FF?=
 =?utf-8?B?QkQ0UFlhL0xWeUZ3VEZDN0VsMzFYSm5NbUVteUhaQ00rN3JUOFhjY1VQTjhV?=
 =?utf-8?B?dW13cGpOaGZMRlhFclhZT0JVUDhWVmFsWHEvZlpKRi9qZlhFNEIxRE9Bd2Nx?=
 =?utf-8?B?K3ZkV2pqdDJsT0s3OUxrNFJBM3AxZ0VOR2RRMDVWd2dhOWQwdjB1dVBZUlY0?=
 =?utf-8?B?cGtPUWg2U1BlL3hIaFZ1TWFubHMzcU52QzhDaDRVV2xLSUtyeU45Yld2VFBq?=
 =?utf-8?B?MlNCM244dXpkVmJyWklXbnhZMWhOS3VnODNqU3R2SHZTMmtpS0ZKZGJ5L2Y0?=
 =?utf-8?B?eHFRU3R1RE8yUXdRaHJBWVJoNG9vZGRtQXZDajcrWGhMaVRmK3ZqeTFnOHMy?=
 =?utf-8?B?ZFRwRG5hWW14ODhobGVuNnBVWk5iQjNqTGlSWk9QS1FLdVU1MUErWi85NDRJ?=
 =?utf-8?B?eFhTZUlIRlM1Q1ZZMEhoT1ltb242UUVzWlh3TEVLZjF1djVPZTM5ZVY1elFH?=
 =?utf-8?B?cy92MmxEcmI1aEtOOEdwSWVFYWs5cmVOOXlHSUFaallnUFBsM0t6a09IS3N1?=
 =?utf-8?B?YzY3MkZtT2F1eVlUZG5zN2dLbHZaUmdJVTE5MkRkQTQvZHVDbUJZcG9KNEJo?=
 =?utf-8?B?dTh1dlNTcTRsVXpqTjJMRGRVVkljcVlRVkQrcVhEVHFLRWloN0lGZVcvcGcy?=
 =?utf-8?B?K3BHeGlvSHNIbjZhMmhDdC9jc3J3OHVPZjhBelVaZzRjRWpLY3RCWDJudURH?=
 =?utf-8?B?THVMMjNsOU1HZExyZDhXMktHZHJBTUxTNys0Tm9tRXNqNllwV0h1MU05aEJr?=
 =?utf-8?B?TGVUTjEwVkNPamk3b0l6MUc2Zlp1VVgwTm5NczFRRjVHMjZmd2RaQW5HbG8z?=
 =?utf-8?B?djNmSDVzbCtRRERpOFBGcHVUQmcrSEw4Wk9keHBMZ1VrWU84UG9tQ1VVUjVV?=
 =?utf-8?B?K2ptM21oQ1pTd3JWZkkwdFo0YStvbzJSSnpKcUJHOVNnRHBOa1RMS1h5MDkx?=
 =?utf-8?B?U2ZZQnNVT045U2d0aHd2eTZiS3RvVHdQNXgwemJ2bmZDUi9wS25ZM1ZrNUNX?=
 =?utf-8?B?NTFOcUtFWHNHU2g3Y2tHa1BKMWlhUEZ1NmNvS0thcWtQRHp0THQ0K0NzNXZo?=
 =?utf-8?B?VHBmSkx5em8wUFh6K0tpVm1kbzRyVzFybUVuMVB2cXFZeENFWlZDdW01MVdS?=
 =?utf-8?Q?Ddx9mVNzZC5yWCjF90llGmhPmJR6afm81cB5hCy/b9p9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ad9b88-99c4-495e-b7d2-08da9f89ad68
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 06:38:09.6253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N15Z6AZbNKWSgvG5Squvdtw8CTHP9glo7/vTyy8L9OsuhfkUqxgIKzQKSBiKqkvj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6331
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Luben Tuikov <Luben.Tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.09.22 um 15:16 schrieb jiadong.zhu@amd.com:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> The software ring is created to support priority context while there is only
> one hardware queue for gfx.
>
> Every software ring has its fence driver and could be used as an ordinary ring
> for the GPU scheduler.
> Multiple software rings are bound to a real ring with the ring muxer. The
> packages committed on the software ring are copied to the real ring.
>
> v2: Use array to store software ring entry.
> v3: Remove unnecessary prints.
> v4: Remove amdgpu_ring_sw_init/fini functions,
> using gtt for sw ring buffer for later dma copy
> optimization.
> v5: Allocate ring entry dynamically in the muxer.
> v6: Update comments for the ring muxer.
> v7: Modify for function naming.
>
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky  <Andrey.Grodzovsky@amd.com>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 183 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  68 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  61 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h  |  38 ++++
>   7 files changed, 359 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 3e0e2eb7e235..85224bc81ce5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -58,7 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>   	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>   	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
> -	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> +	amdgpu_sw_ring.o amdgpu_ring_mux.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 53526ffb2ce1..9996dadb39f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -33,6 +33,7 @@
>   #include "amdgpu_imu.h"
>   #include "soc15.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_ring_mux.h"
>   
>   /* GFX current status */
>   #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
> @@ -346,6 +347,8 @@ struct amdgpu_gfx {
>   	struct amdgpu_gfx_ras		*ras;
>   
>   	bool				is_poweron;
> +
> +	struct amdgpu_ring_mux          muxer;
>   };
>   
>   #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7d89a52091c0..40b1277b4f0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -278,6 +278,10 @@ struct amdgpu_ring {
>   	bool			is_mes_queue;
>   	uint32_t		hw_queue_id;
>   	struct amdgpu_mes_ctx_data *mes_ctx;
> +
> +	bool            is_sw_ring;
> +	unsigned int    entry_index;
> +
>   };
>   
>   #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> new file mode 100644
> index 000000000000..662aadebf111
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -0,0 +1,183 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include <linux/slab.h>
> +#include <drm/drm_print.h>
> +
> +#include "amdgpu_ring_mux.h"
> +#include "amdgpu_ring.h"
> +
> +#define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ / 2)
> +
> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +			 unsigned int entry_size)
> +{
> +	mux->real_ring = ring;
> +	mux->num_ring_entries = 0;
> +	mux->ring_entry = kcalloc(entry_size, sizeof(struct amdgpu_mux_entry), GFP_KERNEL);
> +	if (!mux->ring_entry)
> +		return -ENOMEM;
> +
> +	mux->ring_entry_size = entry_size;
> +	spin_lock_init(&mux->lock);
> +
> +	return 0;
> +}
> +
> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
> +{
> +	kfree(mux->ring_entry);
> +	mux->ring_entry = NULL;
> +	mux->num_ring_entries = 0;
> +	mux->ring_entry_size = 0;
> +}
> +
> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	if (mux->num_ring_entries >= mux->ring_entry_size) {
> +		DRM_ERROR("add sw ring exceeding max entry size\n");
> +		return -ENOENT;
> +	}
> +
> +	e = &mux->ring_entry[mux->num_ring_entries];
> +	ring->entry_index = mux->num_ring_entries;
> +	e->ring = ring;
> +
> +	mux->num_ring_entries += 1;
> +	return 0;
> +}
> +
> +static inline struct amdgpu_mux_entry *amdgpu_ring_mux_sw_entry(struct amdgpu_ring_mux *mux,
> +								struct amdgpu_ring *ring)
> +{
> +	return ring->entry_index < mux->ring_entry_size ?
> +			&mux->ring_entry[ring->entry_index] : NULL;
> +}
> +
> +/* copy packages on sw ring range[begin, end) */
> +static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
> +						  struct amdgpu_ring *ring,
> +						  u64 s_start, u64 s_end)
> +{
> +	u64 start, end;
> +	struct amdgpu_ring *real_ring = mux->real_ring;
> +
> +	start = s_start & ring->buf_mask;
> +	end = s_end & ring->buf_mask;
> +
> +	if (start == end) {
> +		DRM_ERROR("no more data copied from sw ring\n");
> +		return;
> +	}
> +	if (start > end) {
> +		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start],
> +					   (ring->ring_size >> 2) - start);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
> +	} else {
> +		amdgpu_ring_alloc(real_ring, end - start);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
> +	}
> +}
> +
> +void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	e = amdgpu_ring_mux_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry for sw ring\n");
> +		return;
> +	}
> +
> +	spin_lock(&mux->lock);
> +	e->sw_cptr = e->sw_wptr;
> +	e->sw_wptr = wptr;
> +	e->start_ptr_in_hw_ring = mux->real_ring->wptr;
> +
> +	amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
> +	e->end_ptr_in_hw_ring = mux->real_ring->wptr;
> +	amdgpu_ring_commit(mux->real_ring);
> +
> +	spin_unlock(&mux->lock);
> +}
> +
> +u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	e = amdgpu_ring_mux_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry for sw ring\n");
> +		return 0;
> +	}
> +
> +	return e->sw_wptr;
> +}
> +
> +/*
> + * The return value of the readptr is not precise while the other rings could
> + * write data onto the real ring buffer.After overwriting on the real ring, we
> + * can not decide if our packages have been excuted or not read yet. However,
> + * this function is only called by the tools such as umr to collect the latest
> + * packages for the hang analysis. We assume the hang happens near our latest
> + * submit. Thus we could use the following logic to give the clue:
> + * If the readptr is between start and end, then we return the copy pointer
> + * plus the distance from start to readptr. If the readptr is before start, we
> + * return the copy pointer. Lastly, if the readptr is past end, we return the
> + * write pointer.
> + */
> +u64 amdgpu_ring_mux_get_rptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +	u64 readp, offset, start, end;
> +
> +	e = amdgpu_ring_mux_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("no sw entry found!\n");
> +		return 0;
> +	}
> +
> +	readp = amdgpu_ring_get_rptr(mux->real_ring);
> +
> +	start = e->start_ptr_in_hw_ring & mux->real_ring->buf_mask;
> +	end = e->end_ptr_in_hw_ring & mux->real_ring->buf_mask;
> +	if (start > end) {
> +		if (readp <= end)
> +			readp += mux->real_ring->ring_size >> 2;
> +		end += mux->real_ring->ring_size >> 2;
> +	}
> +
> +	if (start <= readp && readp <= end) {
> +		offset = readp - start;
> +		e->sw_rptr = (e->sw_cptr + offset) & ring->buf_mask;
> +	} else if (readp < start) {
> +		e->sw_rptr = e->sw_cptr;
> +	} else {
> +		/* end < readptr */
> +		e->sw_rptr = e->sw_wptr;
> +	}
> +
> +	return e->sw_rptr;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> new file mode 100644
> index 000000000000..8c1691e11b1c
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> @@ -0,0 +1,68 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_RING_MUX__
> +#define __AMDGPU_RING_MUX__
> +
> +#include <linux/timer.h>
> +#include <linux/spinlock.h>
> +#include "amdgpu_ring.h"
> +
> +struct amdgpu_ring;
> +/**
> + * struct amdgpu_mux_entry - the entry recording software rings copying information.
> + * @ring: the pointer to the software ring.
> + * @start_ptr_in_hw_ring: last start location copied to in the hardware ring.
> + * @end_ptr_in_hw_ring: last end location copied to in the hardware ring.
> + * @sw_cptr: the position of the copy pointer in the sw ring.
> + * @sw_rptr: the read pointer in software ring.
> + * @sw_wptr: the write pointer in software ring.
> + */
> +struct amdgpu_mux_entry {
> +	struct                  amdgpu_ring *ring;
> +	u64                     start_ptr_in_hw_ring;
> +	u64                     end_ptr_in_hw_ring;
> +	u64                     sw_cptr;
> +	u64                     sw_rptr;
> +	u64                     sw_wptr;
> +};
> +
> +struct amdgpu_ring_mux {
> +	struct amdgpu_ring      *real_ring;
> +
> +	struct amdgpu_mux_entry *ring_entry;
> +	unsigned int            num_ring_entries;
> +	unsigned int            ring_entry_size;
> +	/*the lock for copy data from different software rings*/
> +	spinlock_t              lock;
> +};
> +
> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +			 unsigned int entry_size);
> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux);
> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr);
> +u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +u64 amdgpu_ring_mux_get_rptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> new file mode 100644
> index 000000000000..5ae12d6641ca
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> @@ -0,0 +1,61 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + */
> +
> +#include "amdgpu_sw_ring.h"
> +#include "amdgpu_ring_mux.h"
> +
> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	return amdgpu_ring_mux_get_rptr(mux, ring);
> +}
> +
> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	return amdgpu_ring_mux_get_wptr(mux, ring);
> +}
> +
> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	amdgpu_ring_mux_set_wptr(mux, ring, ring->wptr);
> +}
> +
> +/* Override insert_nop to prevent emitting nops to the software rings */
> +void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> +{
> +	WARN_ON(!ring->is_sw_ring);
> +}

Putting that into a separate file seems to be overkill.

Please either move this into amdgpu_gfx.c or the ring mux code directly.

Apart from that the patch looks good to me.

Regards,
Christian.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
> new file mode 100644
> index 000000000000..a66524b8b36e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
> @@ -0,0 +1,38 @@
> +/*
> + * Copyright 2012 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "amdgpu_ring.h"
> +#include "amdgpu.h"
> +
> +#ifndef __AMDGPU_SWRING_H__
> +#define __AMDGPU_SWRING_H__
> +
> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);
> +
> +void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
> +
> +#endif

