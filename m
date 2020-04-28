Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4FBC83000
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 21:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5181B20730
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 21:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HjADFcBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5181B20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0EF6E9BF;
	Tue, 28 Apr 2020 21:39:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A49006E9BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 21:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIjBh956VQCmtt+jlH/nstNPsb/A25NPuvSkGBEgq6Gh3xNHkRtuMhZjrWfeFil6SK068KemykUjBzePP8e05gUC9SK42oomSx/Wdco2VcC6Cqv91IcHeUxr4XKa95edS+Aql5Wd6xuglH8LVOG2c8eAC9fgrKAATrEQZjmYgFdz6p/h7cpDTJZdEEQ3y0JlBrn5qK35AjKmhvgr81+svffFTAhRryyq7cHAjkvYYY3QGmoxXbK9Sp2nOmKIppxAjTi+X99Qt1nEfpG2OVL9pMWTuRGFFJJFFYyuf/vfn1HulUx1vRei970+EVOA3ygX5Lr2ku7xCU2YPyLtq/Zxuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVjNfhUC62q47hxgOuNmEsXyjAKagEWQxI4yJX1ukYU=;
 b=e4wvZ33RCTptysmNTm+GEoniAlXPStEq2pzVhm8FfvrivGm1SKXHZxVdE2Kb2yUvfGIBx3LyM2rdEYnSB+pJo2De1HI3Pwk9hjP5xmkRfJULGBfqU14Yoa9wUclJtGbuv1yelxxcD5mRpMbwHwkoImZw7Ke3npEtKPlbgccAiqHs1UFRufyGCgaVXn/1PGCytSQ8+h4zNokWA88hbP3pQB6qeXYvs9qdMocMZLqUx2940CtuoA4h9W+48nr0Cn5p6k6coAb7vmjVfyRT5luxzN0Fjm9G99Gj8103G0h6RupGzoW5E6fLk8i0KrMhZJ+VQE2tnsurluQDX8aWbuN5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVjNfhUC62q47hxgOuNmEsXyjAKagEWQxI4yJX1ukYU=;
 b=HjADFcBXJ27Y/PuEc6i35ey7VXjXHhJhBdeftqz3oiRG2bBvpLO5f26uYy8DM1vOEOIgovZPuEtVJU87haoOi8lSyMVVjlovlikPzf9tdKJRYIEtLUI9dhprtf5jzFScp9k+ffCPUI1cBbN2P1qOnCu7iGqyKYas9ugti80RVWU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2543.namprd12.prod.outlook.com (2603:10b6:802:2a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 21:39:06 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 21:39:06 +0000
Subject: Re: [PATCH] drm/amd: add Streaming Performance Monitor feature
To: Gang Ba <gaba@amd.com>, amd-gfx@lists.freedesktop.org
References: <1588082294-21523-1-git-send-email-gaba@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b1d98d16-0ce9-ab08-746b-795926e092d3@amd.com>
Date: Tue, 28 Apr 2020 17:39:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <1588082294-21523-1-git-send-email-gaba@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::17) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Tue, 28 Apr 2020 21:39:05 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: af4343d3-cae7-42d0-a309-08d7ebbc9377
X-MS-TrafficTypeDiagnostic: SN1PR12MB2543:|SN1PR12MB2543:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2543C5F686A2B03FC2C382B492AC0@SN1PR12MB2543.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:187;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(956004)(2616005)(6486002)(16576012)(86362001)(8936002)(44832011)(66946007)(316002)(478600001)(186003)(16526019)(66476007)(31696002)(5660300002)(26005)(30864003)(66556008)(36756003)(52116002)(2906002)(31686004)(8676002)(33964004)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KoxQabq+0X1jxUYuMcs2V7mUO56VQ0GjrcwWcuY139EENeP1+G7gS+OthM+1NU+zvzKO8z+GCM5kEinXIp+afJu+ieXi/v4Yglo94nsoEmfe13e4fwljugrs2cIl7grdICzm5owaikID8VLe+wixUleGknR6nTHksgekkL3sxUeqYs3/7Q2JrMvyYj1daRlI0pieuwA6OwO83iwBNKd1//raClhvl+hgNp7/Ijtz8cAn7Ah/7WcRkemciGXEQBl7+crCROxVhfY89QVK98CRzjjupIIJ1CaOi8j9AMD5VndhckjoSXyQpplTiDsjk0VBsKR7qtvWb1a+kyUA9279QomL0TfrAGpO0DkTCQnfSQabWifyuIJmfZLR2RHCGOCCkMPBERN8B+C3ElCMc1nctQHm9MIMRJtGctDIg16HVtsbsVtATSDWF8GMB6zFZzN7
X-MS-Exchange-AntiSpam-MessageData: TGErApuNeRx3VgTgUWkt6keRB+1HOZcRpO/WMJ3AmbtfSSCrIwLqSZAHkMWMjxeYnPodaNgA/UK5z0DlRvGOtnAnn0brBj3mJu+iS7ntuZznGKaP8OQr+dVFkf3KOQdo+CuSHRP7r8J5tlxpGyXjKKpXCxpSw+ULDnnSbrlo3h+7k0HewmnodsRwCjQHOUUanaO3A3SmdPdzcDPx09nTS927scaBhlfCafFG7N8u4VO93ZWhnTTLcW9LlPyGKKvMMmQ1Yxw8ggDE1TmsrW4HXAFK3Bo8xdqGXQCrnoA1Y1cjNWrMIAmrSFeLXM/LvkvQAXB0sBpT6cc5lkQCrMf5ztvAeQWfm/oXm2ZrG7UxzXhFt1f6zKBmbiXW6GBqvZBHddwwPLhw2adia2ZEhQIdoq8rXDXsx4NcI/bCVPzKWOlXMdYoM2pL/ZtDMB/Pp36PAWr1wp31tm20eHmAyxTK0dpNvCIvi//idkXnl/ezGRh7bALqltPxYyrIE282MlCFy+epJSqiNF/mnpvMZUdIqvHcgzTrPuSR6vpsza4+VOl/SlLsL4lMbkLOEFLNEda/nLqs+6dQSRozQVDwGFPuyilPyjuPy2O0LDjDAKju/XrHwT0eu0+gh2nHEJHxbX2nQ4hKSRuEbnZuPhRm62PmJxxQpEmWJ+zwj0VVY50ZJD5RdJ+9v/FHrXP8BgxrZ5uEsBUvJ8zS3MlZH0cPU3TG+77fJ77yf3JY3m0SuRWu1E/zHQOsKiz16OElkmjLnUwiaYzyDv8rjMINPqnYmtDPsA4/BrATN/bj4KzgCuOoevA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4343d3-cae7-42d0-a309-08d7ebbc9377
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 21:39:06.0452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pTn+Kvn46X8UgYRWbtR3TOycCS4sQEveFosmF+V3DhsyhXvgLvNqGMR2fRFGJ1E44WSZU5zjX6WgShdn/h58g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2543
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
Content-Type: multipart/mixed; boundary="===============0329499670=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0329499670==
Content-Type: multipart/alternative;
 boundary="------------36902861664473E3518DA748"
Content-Language: en-US

--------------36902861664473E3518DA748
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Gang,

You've made a lot of progress on this. I'll need a day or two to review
all of this in detail. Some general observations after a quick read-through:

  * You have a function to acquire SPM. But it behaves more like "steal
    SPM". You'll need some coordination with SPM VMID usage in the
    amdgpu_cs API. That means, either acquire SPM has to fail in some
    cases, or it needs to wait for amdgpu_cs to release the SPM VMID.
    The other way around, amdgpu_cs will have to wait for KFD to release
    the SPM VMID or fail if someone tries to use SPM.
  * amdgpu_amdkfd_rlc_spm.c has a bunch of wrapper functions to
    allocated KIQ space and commit around ASIC-specific functions that
    write actual KIQ packets. But some of them don't actually use the
    KIQ. The rptr and wptr get functions just read a register.
  * I'm not sure about the amdgpu_amdkfd_rlc_spm_set_reg function. It
    allocates a lot of space on the KIQ but only writes a single
    register. Was this meant to write many registers at once?
  * Also, you're exposing MMIO or KIQ register access to user mode
    through the KFD_IOCTL_SPM_OP_CONFIG function. We should not allow
    this as it would give user mode access to privileged registers. It
    should also not be necessary because most of the SPM registers are
    unprivileged and accessible through user mode queues.

I see a lot more minor issues and typos. I'll respond with more detailed
comments in a separate email.

Regards,
  Felix

Am 2020-04-28 um 9:58 a.m. schrieb Gang Ba:
> Signed-off-by: Gang Ba <gaba@amd.com>
> Change-Id: If83ee0a14ef834699de6733eeab0f140159bbd6e
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile                |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  10 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c | 165 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |  27 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 175 +++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              | 176 +++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 168 ++++++
>  drivers/gpu/drm/amd/amdkfd/Makefile                |   3 +-
>  drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c   |  10 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  17 +
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |  11 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  20 +
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_spm.c               | 577 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/soc15_int.h             |   1 +
>  include/uapi/linux/kfd_ioctl.h                     |  55 +-
>  16 files changed, 1413 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c
>  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_spm.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 210d57a..1498b18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -177,7 +177,8 @@ amdgpu-y += \
>  	 amdgpu_amdkfd_gfx_v8.o \
>  	 amdgpu_amdkfd_gfx_v9.o \
>  	 amdgpu_amdkfd_arcturus.o \
> -	 amdgpu_amdkfd_gfx_v10.o
> +	 amdgpu_amdkfd_gfx_v10.o \
> +	 amdgpu_amdkfd_rlc_spm.o \
>  
>  ifneq ($(CONFIG_DRM_AMDGPU_CIK),)
>  amdgpu-y += amdgpu_amdkfd_gfx_v7.o
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index d065c50..fdc438a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -246,6 +246,16 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo);
>  int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
>  				struct tile_config *config);
>  
> +void amdgpu_amdkfd_rlc_spm_cntl(struct kgd_dev *kgd, bool cntl);
> +int amdgpu_amdkfd_rlc_spm(struct kgd_dev *kgd, void *args);
> +void amdgpu_amdkfd_rlc_spm_acquire(struct kgd_dev *kgd, u64 gpu_addr, u32 size);
> +int amdgpu_amdkfd_rlc_spm_release(struct kgd_dev *kgd);
> +u32 amdgpu_amdkfd_rlc_spm_get_rdptr(struct kgd_dev *kgd);
> +void amdgpu_amdkfd_rlc_spm_set_rdptr(struct kgd_dev *kgd, u32 rptr);
> +u32 amdgpu_amdkfd_rlc_spm_get_wrptr(struct kgd_dev *kgd);
> +void amdgpu_amdkfd_rlc_spm_set_wrptr(struct kgd_dev *kgd, u32 wptr);
> +int amdgpu_amdkfd_rlc_spm_set_reg(struct kgd_dev *kgd, u64 uReg, u32 value);
> +
>  /* KGD2KFD callbacks */
>  int kgd2kfd_init(void);
>  void kgd2kfd_exit(void);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c
> new file mode 100644
> index 0000000..b492c1e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c
> @@ -0,0 +1,165 @@
> +/*
> + * Copyright 2014-2020 Advanced Micro Devices, Inc.
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
> + */
> +
> +#include <linux/dma-buf.h>
> +#include <linux/list.h>
> +#include <linux/pagemap.h>
> +#include <linux/sched/mm.h>
> +#include <linux/sched/task.h>
> +
> +#include "amdgpu_object.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_amdkfd.h"
> +#include <uapi/linux/kfd_ioctl.h>
> +
> +
> +
> +void amdgpu_amdkfd_rlc_spm_cntl(struct kgd_dev *kgd, bool cntl)
> +{
> +    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> +    	struct amdgpu_spm *spm = &adev->gfx.spm;
> +    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +
> +    	spin_lock(&adev->gfx.kiq.ring_lock);
> +    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
> +    	cntl == true ? adev->gfx.spm.spmf->start(adev):adev->gfx.spm.spmf->stop(adev);
> +    	amdgpu_ring_commit(kiq_ring);
> +    	spin_unlock(&adev->gfx.kiq.ring_lock);
> +}
> +
> +u32 amdgpu_amdkfd_rlc_spm_get_rdptr(struct kgd_dev *kgd)
> +{
> +    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> +    	struct amdgpu_spm *spm = &adev->gfx.spm;
> +    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +    	u32 rptr = 0;
> +
> +    	spin_lock(&adev->gfx.kiq.ring_lock);
> +    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
> +    	rptr = adev->gfx.spm.spmf->get_rdptr(adev);
> +    	amdgpu_ring_commit(kiq_ring);
> +    	spin_unlock(&adev->gfx.kiq.ring_lock);
> +
> +    	return rptr;
> +}
> +
> +void amdgpu_amdkfd_rlc_spm_set_rdptr(struct kgd_dev *kgd, u32 rptr)
> +{
> +    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> +    	struct amdgpu_spm *spm = &adev->gfx.spm;
> +    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +
> +    	spin_lock(&adev->gfx.kiq.ring_lock);
> +    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
> +    	adev->gfx.spm.spmf->set_rdptr(adev, rptr);
> +    	amdgpu_ring_commit(kiq_ring);
> +    	spin_unlock(&adev->gfx.kiq.ring_lock);
> +
> +}
> +
> +u32 amdgpu_amdkfd_rlc_spm_get_wrptr(struct kgd_dev *kgd)
> +{
> +    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> +    	struct amdgpu_spm *spm = &adev->gfx.spm;
> +    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +    	u32 wptr;
> +
> +    	spin_lock(&adev->gfx.kiq.ring_lock);
> +    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
> +    	wptr = adev->gfx.spm.spmf->get_wrptr(adev);
> +    	amdgpu_ring_commit(kiq_ring);
> +    	spin_unlock(&adev->gfx.kiq.ring_lock);
> +    	return wptr;
> +}
> +
> +void amdgpu_amdkfd_rlc_spm_set_wrptr(struct kgd_dev *kgd, u32 wptr)
> +{
> +    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> +    	struct amdgpu_spm *spm = &adev->gfx.spm;
> +    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +
> +    	spin_lock(&adev->gfx.kiq.ring_lock);
> +    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
> +    	adev->gfx.spm.spmf->set_wrptr(adev, wptr);
> +    	amdgpu_ring_commit(kiq_ring);
> +    	spin_unlock(&adev->gfx.kiq.ring_lock);
> +}
> +
> +void amdgpu_amdkfd_rlc_spm_acquire(struct kgd_dev *kgd, u64 gpu_addr, u32 size)
> +{
> +    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> +    	struct amdgpu_spm *spm = &adev->gfx.spm;
> +    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +
> +    	/* init spm vmid with 0xf */
> +    	if (adev->gfx.rlc.funcs->update_spm_vmid)
> +        	adev->gfx.rlc.funcs->update_spm_vmid(adev, 0x0);
> +
> +    	/* set spm ring registers */
> +    	spin_lock(&adev->gfx.kiq.ring_lock);
> +    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
> +    	adev->gfx.spm.spmf->set_spm_porfmon_ring_buf(adev, gpu_addr, size);
> +    	amdgpu_ring_commit(kiq_ring);
> +    	spin_unlock(&adev->gfx.kiq.ring_lock);
> +}
> +
> +
> +int amdgpu_amdkfd_rlc_spm_release(struct kgd_dev *kgd)
> +{
> +    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> +    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +    	struct amdgpu_spm *spm = &adev->gfx.spm;
> +
> +    	/* stop spm stream and interupt */
> +    	spin_lock(&adev->gfx.kiq.ring_lock);
> +    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
> +    	adev->gfx.spm.spmf->stop(adev);
> +    	amdgpu_ring_commit(kiq_ring);
> +    	spin_unlock(&adev->gfx.kiq.ring_lock);
> +
> +    	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
> +
> +    	/* revert spm vmid with 0xf */
> +    	if (adev->gfx.rlc.funcs->update_spm_vmid)
> +             adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
> +
> +    	return 0;
> +}
> +
> +int amdgpu_amdkfd_rlc_spm_set_reg(struct kgd_dev *kgd, u64 uReg, u32 value)
> +{
> +    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> +    	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +    	struct amdgpu_spm *spm = &adev->gfx.spm;
> +
> +    	pr_debug("[%s]\n", __func__);
> +
> +    	/* stop spm stream and interupt */
> +    	spin_lock(&adev->gfx.kiq.ring_lock);
> +    	amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
> +    	adev->gfx.spm.spmf->set_reg(adev, uReg, value);
> +    	amdgpu_ring_commit(kiq_ring);
> +    	spin_unlock(&adev->gfx.kiq.ring_lock);
> +
> +    	return 0;
> +}
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index ee698f0..ba4da52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -105,6 +105,31 @@ struct amdgpu_kiq {
>  	const struct kiq_pm4_funcs *pmf;
>  };
>  
> +struct spm_funcs {
> +	void (*start)(struct amdgpu_device *adev);
> +	void (*stop)(struct amdgpu_device *adev);
> +	void (*set_reg)(struct amdgpu_device *adev, uint64_t reg, uint32_t val);
> +	u32 (*get_rdptr)(struct amdgpu_device *adev);
> +	void (*set_rdptr)(struct amdgpu_device *adev, u32 rptr);
> +	u32 (*get_wrptr)(struct amdgpu_device *adev);
> +	void (*set_wrptr)(struct amdgpu_device *adev, u32 wptr);
> +	void (*set_spm_porfmon_ring_buf)(struct amdgpu_device *adev, u64 gpu_rptr, u32 size);
> +
> +	/* Packet sizes */
> +	int set_spm_config_size;
> +	int get_spm_data_size;
> +};
> +
> +struct amdgpu_spm {
> +	const struct spm_funcs *spmf;
> +	u64              spm_gpu_addr;
> +	u32              spm_gpu_size;
> +	u32              spm_ring_rptr;
> +	u32              spm_ring_rptrsize_to_read;
> +	struct amdgpu_bo *spm_obj;
> +	void             *spm_cpu_addr;
> +};
> +
>  /*
>   * GPU scratch registers structures, functions & helpers
>   */
> @@ -256,6 +281,7 @@ struct amdgpu_gfx {
>  	struct amdgpu_me		me;
>  	struct amdgpu_mec		mec;
>  	struct amdgpu_kiq		kiq;
> +	struct amdgpu_spm		spm;
>  	struct amdgpu_scratch		scratch;
>  	const struct firmware		*me_fw;	/* ME firmware */
>  	uint32_t			me_fw_version;
> @@ -292,6 +318,7 @@ struct amdgpu_gfx {
>  	struct amdgpu_irq_src		priv_reg_irq;
>  	struct amdgpu_irq_src		priv_inst_irq;
>  	struct amdgpu_irq_src		cp_ecc_error_irq;
> +	struct amdgpu_irq_src		spm_irq;
>  	struct amdgpu_irq_src		sq_irq;
>  	struct sq_work			sq_work;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 63ac430..9c507d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4121,6 +4121,13 @@ static int gfx_v10_0_sw_init(void *handle)
>  	if (r)
>  		return r;
>  
> +	/* KIQ SPM */
> +	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
> +			      GFX_10_1__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT,
> +			      &adev->gfx.spm_irq);
> +	if (r)
> +		return r;
> +
>  	/* EOP Event */
>  	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP,
>  			      GFX_10_1__SRCID__CP_EOP_INTERRUPT,
> @@ -6603,6 +6610,7 @@ static int gfx_v10_0_hw_fini(void *handle)
>  
>  	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>  	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
>  #ifndef BRING_UP_DEBUG
>  	if (amdgpu_async_gfx_ring) {
>  		r = gfx_v10_0_kiq_disable_kgq(adev);
> @@ -6768,6 +6776,126 @@ static void gfx_v10_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
>  				    (1 << (oa_size + oa_base)) - (1 << oa_base));
>  }
>  
> +static void gfx_v10_0_spm_start(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +	uint32_t data = 0;
> +	u8 se;
> +
> +	for (se = 0; se < adev->gfx.config.max_shader_engines + 1; ++se)
> +	{
> +		uint32_t mux_addr_reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_GLOBAL_MUXSEL_ADDR);
> +		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
> +			INSTANCE_BROADCAST_WRITES, 1);
> +		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
> +			SA_BROADCAST_WRITES, 1);
> +		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
> +			SE_BROADCAST_WRITES, 1);
> +
> +		if (se < adev->gfx.config.max_shader_engines) // SE else GB
> +		{
> +			data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se);
> +			mux_addr_reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_SE_MUXSEL_ADDR);
> +		}
> +		gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
> +		gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, mux_addr_reg, 0);
> +	}
> +
> +	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, 0);
> +	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1);
> +	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
> +
> +	data = 0;
> +	data |= CP_PERFMON_STATE_DISABLE_AND_RESET <<4 ;
> +	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
> +
> +	data = 0;
> +	data |= STRM_PERFMON_STATE_START_COUNTING <<4 ;
> +	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
> +
> +	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL) ,1);
> +}
> +
> +static void gfx_v10_0_spm_stop(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +	uint32_t data = 0;
> +
> +	data = CP_PERFMON_STATE_STOP_COUNTING;
> +	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
> +
> +	data |= (1<<10);
> +	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
> +
> +	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL), 0);
> +}
> +
> +static u32 gfx_v10_0_spm_get_rdptr(struct amdgpu_device *adev)
> +{
> +	return RREG32_SOC15(GC, 0, mmRLC_SPM_RING_RDPTR);;
> +}
> +
> +static void gfx_v10_0_spm_set_rdptr(struct amdgpu_device *adev,  u32 rptr)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +
> +	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), rptr);
> +}
> +
> +static u32 gfx_v10_0_spm_get_wrptr(struct amdgpu_device *adev)
> +{
> +	return RREG32_SOC15(GC, 0, mmRLC_SPM_RING_WRPTR);
> +}
> +
> +static void gfx_v10_0_spm_set_wrptr(struct amdgpu_device *adev,  u32 wptr)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +
> +	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_WRPTR), wptr);
> +}
> +
> +static void gfx_v10_0_set_spm_porfmon_ring_buf(struct amdgpu_device *adev, u64 gpu_addr, u32 size)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +
> +	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0,
> +			mmRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu_addr));
> +
> +	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false,
> +			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_BASE_HI), upper_32_bits (gpu_addr));
> +
> +	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false,
> +			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_SIZE), size);
> +}
> +
> +static void gfx_v10_0_spm_set_reg(struct amdgpu_device *adev, u64 reg, u32 value)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +	uint32_t grbm_cntl;
> +	grbm_cntl = adev->reg_offset[GC_HWIP][0][1] + reg;
> +
> +	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, grbm_cntl, value);
> +}
> +
> +static const struct spm_funcs gfx_v10_0_spm_funcs = {
> +	.start = gfx_v10_0_spm_start,
> +	.stop = gfx_v10_0_spm_stop,
> +	.get_rdptr= gfx_v10_0_spm_get_rdptr,
> +	.set_rdptr= gfx_v10_0_spm_set_rdptr,
> +	.get_wrptr= gfx_v10_0_spm_get_wrptr,
> +	.set_wrptr= gfx_v10_0_spm_set_wrptr,
> +	.set_spm_porfmon_ring_buf = gfx_v10_0_set_spm_porfmon_ring_buf,
> +	.set_reg = gfx_v10_0_spm_set_reg,
> +	.set_spm_config_size = 3,
> +	.get_spm_data_size = 128,
> +};
> +
> +static void gfx_v10_0_set_spm_funcs(struct amdgpu_device *adev)
> +{
> +	adev->gfx.spm.spmf = &gfx_v10_0_spm_funcs;
> +}
> +
> +
>  static int gfx_v10_0_early_init(void *handle)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -6776,6 +6904,7 @@ static int gfx_v10_0_early_init(void *handle)
>  
>  	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
>  
> +	gfx_v10_0_set_spm_funcs(adev);
>  	gfx_v10_0_set_kiq_pm4_funcs(adev);
>  	gfx_v10_0_set_ring_funcs(adev);
>  	gfx_v10_0_set_irq_funcs(adev);
> @@ -6794,6 +6923,10 @@ static int gfx_v10_0_late_init(void *handle)
>  	if (r)
>  		return r;
>  
> +        r = amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
> +        if (r)
> +		return r;
> +
>  	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
>  	if (r)
>  		return r;
> @@ -6860,6 +6993,7 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
>  		if (def != data)
>  			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
>  
> +
>  		/* MGLS is a global flag to control all MGLS in GFX */
>  		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGLS) {
>  			/* 2 - RLC memory Light sleep */
> @@ -8018,6 +8152,39 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
>  	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>  }
>  
> +static int gfx_v10_0_spm_set_interrupt_state(struct amdgpu_device *adev,
> +					     struct amdgpu_irq_src *src,
> +					     unsigned int type,
> +					     enum amdgpu_interrupt_state state)
> +{
> +	switch (state) {
> +	case AMDGPU_IRQ_STATE_DISABLE:
> +		WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 0);
> +		break;
> +	case AMDGPU_IRQ_STATE_ENABLE:
> +		WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 1);
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int gfx_v10_0_spm_irq(struct amdgpu_device *adev,
> +			     struct amdgpu_irq_src *source,
> +			     struct amdgpu_iv_entry *entry)
> +{
> +	u8 me_id, pipe_id, queue_id;
> +
> +	me_id = (entry->ring_id & 0x0c) >> 2;
> +	pipe_id = (entry->ring_id & 0x03) >> 0;
> +	queue_id = (entry->ring_id & 0x70) >> 4;
> +	pr_debug ("IH: RLC_RPM_INT, me:%d, pipe:%d, queue:%d\n",
> +                                         me_id, pipe_id, queue_id);
> +	return  0; /* This prevents sending it to KFD */
> +}
> +
> +
>  static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>  	.name = "gfx_v10_0",
>  	.early_init = gfx_v10_0_early_init,
> @@ -8189,6 +8356,11 @@ static const struct amdgpu_irq_src_funcs gfx_v10_0_kiq_irq_funcs = {
>  	.process = gfx_v10_0_kiq_irq,
>  };
>  
> +static const struct amdgpu_irq_src_funcs gfx_v10_0_spm_irq_funcs = {
> +    .set = gfx_v10_0_spm_set_interrupt_state,
> +    .process = gfx_v10_0_spm_irq,
> +};
> +
>  static void gfx_v10_0_set_irq_funcs(struct amdgpu_device *adev)
>  {
>  	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
> @@ -8197,6 +8369,9 @@ static void gfx_v10_0_set_irq_funcs(struct amdgpu_device *adev)
>  	adev->gfx.kiq.irq.num_types = AMDGPU_CP_KIQ_IRQ_LAST;
>  	adev->gfx.kiq.irq.funcs = &gfx_v10_0_kiq_irq_funcs;
>  
> +	adev->gfx.spm_irq.num_types = 1;
> +	adev->gfx.spm_irq.funcs = &gfx_v10_0_spm_irq_funcs;
> +
>  	adev->gfx.priv_reg_irq.num_types = 1;
>  	adev->gfx.priv_reg_irq.funcs = &gfx_v10_0_priv_reg_irq_funcs;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 14790f8..1125b91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1955,6 +1955,12 @@ static int gfx_v8_0_sw_init(void *handle)
>  	adev->gfx.mec.num_pipe_per_mec = 4;
>  	adev->gfx.mec.num_queue_per_pipe = 8;
>  
> +	/* KIQ SPM */
> +	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY,	VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR,
> +			      &adev->gfx.spm_irq);
> +	if (r)
> +        return r;
> +
>  	/* EOP Event */
>  	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, VISLANDS30_IV_SRCID_CP_END_OF_PIPE, &adev->gfx.eop_irq);
>  	if (r)
> @@ -4927,6 +4933,7 @@ static int gfx_v8_0_hw_fini(void *handle)
>  	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
>  
>  	amdgpu_irq_put(adev, &adev->gfx.sq_irq, 0);
> +	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
>  
>  	/* disable KCQ to avoid CPC touch memory not valid anymore */
>  	gfx_v8_0_kcq_disable(adev);
> @@ -5291,6 +5298,126 @@ static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs = {
>  	.select_me_pipe_q = &gfx_v8_0_select_me_pipe_q
>  };
>  
> +static void gfx_v8_0_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
> +				       bool wc, uint32_t reg, uint32_t val)
> +{
> +	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
> +	amdgpu_ring_write(ring, WRITE_DATA_ENGINE_SEL(eng_sel) |
> +				WRITE_DATA_DST_SEL(0) |
> +				(wc ? WR_CONFIRM : 0));
> +	amdgpu_ring_write(ring, reg);
> +	amdgpu_ring_write(ring, 0);
> +	amdgpu_ring_write(ring, val);
> +}
> +
> +static void gfx_v8_0_spm_start(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +	uint32_t data = 0;
> +	u8 se;
> +
> +	for (se = 0; se < adev->gfx.config.max_shader_engines + 1; ++se)
> +	{
> +		uint32_t mux_addr_reg = mmRLC_SPM_GLOBAL_MUXSEL_ADDR;
> +
> +		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
> +			INSTANCE_BROADCAST_WRITES, 1);
> +		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
> +			SH_BROADCAST_WRITES, 1);
> +		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
> +			SE_BROADCAST_WRITES, 1);
> +
> +		if (se < adev->gfx.config.max_shader_engines) // SE else GB
> +		{
> +			data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se);
> +
> +			mux_addr_reg = mmRLC_SPM_SE_MUXSEL_ADDR;
> +		}
> +		gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmGRBM_GFX_INDEX, data);
> +		// init addr
> +		gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mux_addr_reg, data);
> +	}
> +
> +	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, 0);
> +	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1);
> +	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmGRBM_GFX_INDEX, data);
> +
> +	data = 0;
> +	data |= CP_PERFMON_STATE_DISABLE_AND_RESET <<4 ;
> +	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL, data);
> +
> +	data = 0;
> +	data |= STRM_PERFMON_STATE_START_COUNTING <<4 ;
> +	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL,	data);
> +
> +	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_INT_CNTL ,1);
> +}
> +
> +static void gfx_v8_0_spm_stop(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +	uint32_t data = 0;
> +
> +	data = CP_PERFMON_STATE_STOP_COUNTING;
> +	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL, data);
> +	data |= (1<<10);
> +	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL, data);
> +
> +	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_INT_CNTL, 0);
> +}
> +
> +
> +static u32 gfx_v8_0_spm_get_rdptr(struct amdgpu_device *adev)
> +{
> +	return RREG32 (mmRLC_SPM_RING_RDPTR);
> +}
> +
> +static void gfx_v8_0_spm_set_rdptr(struct amdgpu_device *adev,  u32 rptr)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +
> +	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_RING_RDPTR, rptr);
> +}
> +
> +static u32 gfx_v8_0_spm_get_wrptr(struct amdgpu_device *adev)
> +{
> +	return  -1;
> +}
> +
> +static void gfx_v8_0_set_spm_porfmon_ring_buf(struct amdgpu_device *adev, u64 gpu_addr, u32 size)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +
> +	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_PERFMON_RING_BASE_LO, lower_32_bits(gpu_addr));
> +
> +	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_PERFMON_RING_BASE_HI, upper_32_bits (gpu_addr));
> +
> +	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_PERFMON_RING_SIZE, size);
> +}
> +
> +static void gfx_v8_0_spm_set_reg(struct amdgpu_device *adev, u64 reg, u32 value)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, reg, value);
> +}
> +
> +static const struct spm_funcs gfx_v8_0_spm_funcs = {
> +	.start = gfx_v8_0_spm_start,
> +	.stop = gfx_v8_0_spm_stop,
> +	.get_rdptr= gfx_v8_0_spm_get_rdptr,
> +	.set_rdptr= gfx_v8_0_spm_set_rdptr,
> +	.get_wrptr= gfx_v8_0_spm_get_wrptr,
> +	.set_spm_porfmon_ring_buf = gfx_v8_0_set_spm_porfmon_ring_buf,
> +	.set_reg = gfx_v8_0_spm_set_reg,
> +	.set_spm_config_size = 3,
> +	.get_spm_data_size = 128,
> +};
> +
> +static void gfx_v8_0_set_spm_funcs(struct amdgpu_device *adev)
> +{
> +	adev->gfx.spm.spmf = &gfx_v8_0_spm_funcs;
> +}
> +
>  static int gfx_v8_0_early_init(void *handle)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -5298,6 +5425,8 @@ static int gfx_v8_0_early_init(void *handle)
>  	adev->gfx.num_gfx_rings = GFX8_NUM_GFX_RINGS;
>  	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
>  	adev->gfx.funcs = &gfx_v8_0_gfx_funcs;
> +
> +	gfx_v8_0_set_spm_funcs(adev);
>  	gfx_v8_0_set_ring_funcs(adev);
>  	gfx_v8_0_set_irq_funcs(adev);
>  	gfx_v8_0_set_gds_init(adev);
> @@ -5338,6 +5467,10 @@ static int gfx_v8_0_late_init(void *handle)
>  		return r;
>  	}
>  
> +	r = amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
> +	if (r)
> +		return r;
> +
>  	return 0;
>  }
>  
> @@ -6845,6 +6978,41 @@ static void gfx_v8_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
>  	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
>  }
>  
> +static int gfx_v8_0_spm_set_interrupt_state(struct amdgpu_device *adev,
> +					     struct amdgpu_irq_src *src,
> +					     unsigned int type,
> +					     enum amdgpu_interrupt_state state)
> +{
> +	switch (state) {
> +	case AMDGPU_IRQ_STATE_DISABLE:
> +		WREG32(mmRLC_SPM_INT_CNTL, 0);
> +		break;
> +	case AMDGPU_IRQ_STATE_ENABLE:
> +		WREG32(mmRLC_SPM_INT_CNTL, 1);
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int gfx_v8_0_spm_irq(struct amdgpu_device *adev,
> +			     struct amdgpu_irq_src *source,
> +			     struct amdgpu_iv_entry *entry)
> +{
> +	u8 me_id, pipe_id, queue_id;
> +	struct amdgpu_ring *ring = &(adev->gfx.kiq.ring);
> +
> +	me_id = (entry->ring_id & 0x0c) >> 2;
> +	pipe_id = (entry->ring_id & 0x03) >> 0;
> +	queue_id = (entry->ring_id & 0x70) >> 4;
> +	pr_debug("IH: RLC_RPM_INT, me:%d, pipe:%d, queue:%d\n",
> +			me_id, pipe_id, queue_id);
> +
> +	amdgpu_fence_process(ring);
> +	return 0;
> +}
> +
>  static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
>  	.name = "gfx_v8_0",
>  	.early_init = gfx_v8_0_early_init,
> @@ -7005,11 +7173,19 @@ static const struct amdgpu_irq_src_funcs gfx_v8_0_sq_irq_funcs = {
>  	.process = gfx_v8_0_sq_irq,
>  };
>  
> +static const struct amdgpu_irq_src_funcs gfx_v8_0_spm_irq_funcs = {
> +	.set = gfx_v8_0_spm_set_interrupt_state,
> +	.process = gfx_v8_0_spm_irq,
> +};
> +
>  static void gfx_v8_0_set_irq_funcs(struct amdgpu_device *adev)
>  {
>  	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
>  	adev->gfx.eop_irq.funcs = &gfx_v8_0_eop_irq_funcs;
>  
> +	adev->gfx.spm_irq.num_types = 1;
> +	adev->gfx.spm_irq.funcs = &gfx_v8_0_spm_irq_funcs;
> +
>  	adev->gfx.priv_reg_irq.num_types = 1;
>  	adev->gfx.priv_reg_irq.funcs = &gfx_v8_0_priv_reg_irq_funcs;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 2767c6d..bfde274 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2249,6 +2249,13 @@ static int gfx_v9_0_sw_init(void *handle)
>  	adev->gfx.mec.num_pipe_per_mec = 4;
>  	adev->gfx.mec.num_queue_per_pipe = 8;
>  
> +	/* KIQ SPM */
> +	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
> +			      GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT,
> +			      &adev->gfx.spm_irq);
> +	if (r)
> +        return r;
> +
>  	/* EOP Event */
>  	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__SRCID__CP_EOP_INTERRUPT, &adev->gfx.eop_irq);
>  	if (r)
> @@ -3907,6 +3914,7 @@ static int gfx_v9_0_hw_fini(void *handle)
>  
>  	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
>  	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> +	amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
>  	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>  
>  	/* DF freeze and kcq disable will fail */
> @@ -4617,6 +4625,121 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>  	return r;
>  }
>  
> +static void gfx_v9_0_spm_start(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +	uint32_t data = 0;
> +	u8 se;
> +
> +	for (se = 0; se < adev->gfx.config.max_shader_engines + 1; ++se)
> +	{
> +		uint32_t mux_addr_reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_GLOBAL_MUXSEL_ADDR);
> +
> +		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
> +			INSTANCE_BROADCAST_WRITES, 1);
> +		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
> +			SH_BROADCAST_WRITES, 1);
> +		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
> +			SE_BROADCAST_WRITES, 1);
> +
> +		if (se < adev->gfx.config.max_shader_engines) // SE else GB
> +		{
> +			data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se);
> +
> +			mux_addr_reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_SE_MUXSEL_ADDR);
> +		}
> +		gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
> +		// init addr
> +		gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, mux_addr_reg, data);
> +	}
> +
> +	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, 0);
> +	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1);
> +	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
> +
> +	data = 0;
> +	data |= CP_PERFMON_STATE_DISABLE_AND_RESET <<4 ;
> +	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
> +
> +	data = 0;
> +	data |= STRM_PERFMON_STATE_START_COUNTING <<4 ;
> +	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
> +
> +	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL) ,1);
> +}
> +
> +
> +static void gfx_v9_0_spm_stop(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +	uint32_t data = 0;
> +
> +
> +	data = CP_PERFMON_STATE_STOP_COUNTING;
> +	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
> +	data |= (1<<10);
> +	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
> +
> +	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL), 0);
> +}
> +
> +static u32 gfx_v9_0_spm_get_rdptr(struct amdgpu_device *adev)
> +{
> +	return RREG32_SOC15(GC, 0, mmRLC_SPM_RING_RDPTR);;
> +}
> +
> +static void gfx_v9_0_spm_set_rdptr(struct amdgpu_device *adev,  u32 rptr)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +
> +	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), rptr);
> +}
> +
> +static u32 gfx_v9_0_spm_get_wrptr(struct amdgpu_device *adev)
> +{
> +	return -1;
> +}
> +
> +static void gfx_v9_0_set_spm_porfmon_ring_buf(struct amdgpu_device *adev, u64 gpu_addr, u32 size)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +
> +	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0,
> +                               mmRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu_addr));
> +
> +	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
> +                               SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_BASE_HI), upper_32_bits (gpu_addr));
> +
> +	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
> +                               SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_SIZE), size);
> +}
> +
> +static void gfx_v9_0_spm_set_reg(struct amdgpu_device *adev, u64 reg, u32 value)
> +{
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +	uint32_t grbm_cntl;
> +	grbm_cntl = adev->reg_offset[GC_HWIP][0][1] + reg;
> +
> +	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, grbm_cntl, value);
> +}
> +
> +static const struct spm_funcs gfx_v9_0_spm_funcs = {
> +	.start = gfx_v9_0_spm_start,
> +	.stop = gfx_v9_0_spm_stop,
> +	.get_rdptr= gfx_v9_0_spm_get_rdptr,
> +	.set_rdptr= gfx_v9_0_spm_set_rdptr,
> +	.get_wrptr= gfx_v9_0_spm_get_wrptr,
> +	.set_spm_porfmon_ring_buf = gfx_v9_0_set_spm_porfmon_ring_buf,
> +	.set_reg = gfx_v9_0_spm_set_reg,
> +	.set_spm_config_size = 3,
> +	.get_spm_data_size = 128,
> +};
> +
> +static void gfx_v9_0_set_spm_funcs(struct amdgpu_device *adev)
> +{
> +	adev->gfx.spm.spmf = &gfx_v9_0_spm_funcs;
> +}
> +
>  static int gfx_v9_0_early_init(void *handle)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -4626,6 +4749,7 @@ static int gfx_v9_0_early_init(void *handle)
>  	else
>  		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
>  	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +	gfx_v9_0_set_spm_funcs(adev);
>  	gfx_v9_0_set_kiq_pm4_funcs(adev);
>  	gfx_v9_0_set_ring_funcs(adev);
>  	gfx_v9_0_set_irq_funcs(adev);
> @@ -4677,6 +4801,10 @@ static int gfx_v9_0_late_init(void *handle)
>  	if (r)
>  		return r;
>  
> +	r = amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
> +	if (r)
> +		return r;
> +
>  	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
>  	if (r)
>  		return r;
> @@ -6657,6 +6785,39 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
>  	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
>  }
>  
> +static int gfx_v9_0_spm_set_interrupt_state(struct amdgpu_device *adev,
> +					     struct amdgpu_irq_src *src,
> +					     unsigned int type,
> +					     enum amdgpu_interrupt_state state)
> +{
> +	switch (state) {
> +	case AMDGPU_IRQ_STATE_DISABLE:
> +		WREG32(mmRLC_SPM_INT_CNTL, 0);
> +		break;
> +	case AMDGPU_IRQ_STATE_ENABLE:
> +		WREG32(mmRLC_SPM_INT_CNTL, 1);
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int gfx_v9_0_spm_irq(struct amdgpu_device *adev,
> +			     struct amdgpu_irq_src *source,
> +			     struct amdgpu_iv_entry *entry)
> +{
> +	u8 me_id, pipe_id, queue_id;
> +
> +	me_id = (entry->ring_id & 0x0c) >> 2;
> +	pipe_id = (entry->ring_id & 0x03) >> 0;
> +	queue_id = (entry->ring_id & 0x70) >> 4;
> +	pr_debug("IH: RLC_RPM_INT, me:%d, pipe:%d, queue:%d\n",
> +			me_id, pipe_id, queue_id);
> +
> +	return 0; /* This also prevents sending it to KFD */
> +}
> +
>  static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
>  	.name = "gfx_v9_0",
>  	.early_init = gfx_v9_0_early_init,
> @@ -6825,12 +6986,19 @@ static const struct amdgpu_irq_src_funcs gfx_v9_0_cp_ecc_error_irq_funcs = {
>  	.process = amdgpu_gfx_cp_ecc_error_irq,
>  };
>  
> +static const struct amdgpu_irq_src_funcs gfx_v9_0_spm_irq_funcs = {
> +	.set = gfx_v9_0_spm_set_interrupt_state,
> +	.process = gfx_v9_0_spm_irq,
> +};
>  
>  static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev)
>  {
>  	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
>  	adev->gfx.eop_irq.funcs = &gfx_v9_0_eop_irq_funcs;
>  
> +	adev->gfx.spm_irq.num_types = 1;
> +	adev->gfx.spm_irq.funcs = &gfx_v9_0_spm_irq_funcs;
> +
>  	adev->gfx.priv_reg_irq.num_types = 1;
>  	adev->gfx.priv_reg_irq.funcs = &gfx_v9_0_priv_reg_irq_funcs;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
> index 6147462..43edba0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Makefile
> +++ b/drivers/gpu/drm/amd/amdkfd/Makefile
> @@ -53,7 +53,8 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
>  		$(AMDKFD_PATH)/kfd_int_process_v9.o \
>  		$(AMDKFD_PATH)/kfd_dbgdev.o \
>  		$(AMDKFD_PATH)/kfd_dbgmgr.o \
> -		$(AMDKFD_PATH)/kfd_crat.o
> +		$(AMDKFD_PATH)/kfd_crat.o	\
> +		$(AMDKFD_PATH)/kfd_spm.o
>  
>  ifneq ($(CONFIG_AMD_IOMMU_V2),)
>  AMDKFD_FILES += $(AMDKFD_PATH)/kfd_iommu.o
> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> index 9f59ba9..cd394cd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> @@ -24,6 +24,7 @@
>  #include "kfd_events.h"
>  #include "cik_int.h"
>  #include "amdgpu_amdkfd.h"
> +#include "ivsrcid/ivsrcid_vislands30.h"
>  
>  static bool cik_event_interrupt_isr(struct kfd_dev *dev,
>  					const uint32_t *ih_ring_entry,
> @@ -37,6 +38,11 @@ static bool cik_event_interrupt_isr(struct kfd_dev *dev,
>  	uint16_t pasid;
>  	bool ret;
>  
> +	vmid = f2g->read_vmid_from_vmfault_reg(dev->kgd);
> +
> +	if ((ihre->source_id == VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR) && (vmid == 0))
> +		 return (kfd_spm_interrupt_isr (dev, ihre->source_id, ihre->source_id));
> +
>  	/* This workaround is due to HW/FW limitation on Hawaii that
>  	 * VMID and PASID are not written into ih_ring_entry
>  	 */
> @@ -49,7 +55,6 @@ static bool cik_event_interrupt_isr(struct kfd_dev *dev,
>  		*patched_flag = true;
>  		*tmp_ihre = *ihre;
>  
> -		vmid = f2g->read_vmid_from_vmfault_reg(dev->kgd);
>  		ret = f2g->get_atc_vmid_pasid_mapping_info(dev->kgd, vmid, &pasid);
>  
>  		tmp_ihre->ring_id &= 0x000000ff;
> @@ -95,6 +100,9 @@ static void cik_event_interrupt_wq(struct kfd_dev *dev,
>  	if (pasid == 0)
>  		return;
>  
> +	if ((ihre->source_id == VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR) && (vmid == 0))
> +		kfd_spm_interrupt_wq(dev, ihre->source_id);
> +
>  	if (ihre->source_id == CIK_INTSRC_CP_END_OF_PIPE)
>  		kfd_signal_event_interrupt(pasid, context_id, 28);
>  	else if (ihre->source_id == CIK_INTSRC_SDMA_TRAP)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index f8fa03a..bfc83beb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1732,6 +1732,20 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>  	return r;
>  }
>  
> +static int kfd_ioctl_rlc_spm(struct file *filep,
> +				   struct kfd_process *p, void *data)
> +{
> +	struct kfd_ioctl_spm_args *args = data;
> +	int err;
> +
> +	err = kfd_rlc_spm(p,
> +			(void __user *)args,
> +			 args->buf_size,
> +			 args->op);
> +
> +	return err;
> +}
> +
>  #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
>  	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
>  			    .cmd_drv = 0, .name = #ioctl}
> @@ -1827,6 +1841,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
>  
>  	AMDKFD_IOCTL_DEF(AMDKFD_IOC_ALLOC_QUEUE_GWS,
>  			kfd_ioctl_alloc_queue_gws, 0),
> +
> +	AMDKFD_IOCTL_DEF(AMDKFD_IOC_RLC_SPM,
> +			kfd_ioctl_rlc_spm, 0),
>  };
>  
>  #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index e05d75e..481f0ae 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -24,6 +24,7 @@
>  #include "kfd_events.h"
>  #include "soc15_int.h"
>  #include "kfd_device_queue_manager.h"
> +#include "ivsrcid/gfx/irqsrcs_gfx_9_0.h"
>  
>  static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>  					const uint32_t *ih_ring_entry,
> @@ -35,12 +36,15 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>  
>  	/* Only handle interrupts from KFD VMIDs */
>  	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
> +	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
> +	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
> +	if ((source_id == GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT) && (vmid == 0))
> +		 return (kfd_spm_interrupt_isr (dev, source_id, client_id));
> +
>  	if (vmid < dev->vm_info.first_vmid_kfd ||
>  	    vmid > dev->vm_info.last_vmid_kfd)
>  		return 0;
>  
> -	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
> -	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
>  	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
>  
>  	/* This is a known issue for gfx9. Under non HWS, pasid is not set
> @@ -95,6 +99,9 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>  	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
>  	context_id = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
>  
> +	if ((source_id == GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT) && (vmid == 0))
> +		kfd_spm_interrupt_wq(dev, source_id);
> +
>  	if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
>  		kfd_signal_event_interrupt(pasid, context_id, 32);
>  	else if (source_id == SOC15_INTSRC_SDMA_TRAP)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 43b888b..707d672 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -309,6 +309,9 @@ struct kfd_dev {
>  
>  	/* Global GWS resource shared b/t processes*/
>  	void *gws;
> +
> +	/*spm process id */
> +	unsigned int spm_pasid;
>  };
>  
>  enum kfd_mempool {
> @@ -740,6 +743,13 @@ struct kfd_process {
>  	struct kobject *kobj;
>  	struct kobject *kobj_queues;
>  	struct attribute attr_pasid;
> +	/* spm data */
> +	struct kfd_spm_cntr *spm_cntr;
> +	bool is_spm_acquired;
> +	/* Work items for tranfer data to user */
> +	struct delayed_work copy_to_user_work;
> +	/* spm-related data */
> +	struct mutex spm_mutex;
>  };
>  
>  #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
> @@ -1045,10 +1055,20 @@ int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process *p);
>  
>  bool kfd_is_locked(void);
>  
> +void kfd_spm_init_process(struct kfd_process *p);
> +int kfd_rlc_spm(struct kfd_process *p,  void __user *data,
> +		       uint32_t buf_size, __u32 op);
> +
>  /* Compute profile */
>  void kfd_inc_compute_active(struct kfd_dev *dev);
>  void kfd_dec_compute_active(struct kfd_dev *dev);
>  
> +/* spm interrupt */
> +bool kfd_spm_interrupt_isr(struct kfd_dev *dev,
> +					uint16_t source_id,	uint32_t client_id);
> +void kfd_spm_interrupt_wq(struct kfd_dev *dev,	uint16_t source_id);
> +
> +
>  /* Cgroup Support */
>  /* Check with device cgroup if @kfd device is accessible */
>  static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index fe0cd49..338868d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -746,6 +746,7 @@ static struct kfd_process *create_process(const struct task_struct *thread)
>  	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
>  	process->last_restore_timestamp = get_jiffies_64();
>  	kfd_event_init_process(process);
> +	kfd_spm_init_process(process);
>  	process->is_32bit_user_mode = in_compat_syscall();
>  
>  	process->pasid = kfd_pasid_alloc();
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_spm.c b/drivers/gpu/drm/amd/amdkfd/kfd_spm.c
> new file mode 100644
> index 0000000..773e2ee
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_spm.c
> @@ -0,0 +1,577 @@
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
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
> + */
> +
> +#include <linux/device.h>
> +#include "kfd_priv.h"
> +#include "amdgpu_amdkfd.h"
> +#include "soc15_int.h"
> +#include "ivsrcid/gfx/irqsrcs_gfx_9_0.h"
> +#include "ivsrcid/ivsrcid_vislands30.h"
> +#include <linux/delay.h>
> +
> +#define SAMPLING_MAX 4
> +
> +struct user_buf {
> +        uint64_t __user *user_addr;
> +        u32 ubufsize;
> +
> +};
> +
> +struct kfd_spm_cntr {
> +        struct kgd_dev *kgd;
> +        u64    spm_gpu_addr;
> +        u32    spm_ring_buf_size;
> +        u32    spm_ring_buf_mark;
> +	    u32	   spm_ring_rptr;
> +        u32    spm_ring_wptr;
> +        u32    spm_ring_size_copied;
> +        void   *spm_obj;
> +        u32    *spm_cpu_addr;
> +        struct user_buf ubuf [SAMPLING_MAX];
> +        u32    buf_count;
> +        bool   is_uesr_buf_filled;
> +        bool   is_nowait;
> +        struct task_struct *thread;
> +        bool   thread_ready;
> +        char   *name;
> +        wait_queue_head_t spm_wq;
> +        int    wanted_cluster;
> +        bool   is_timeout;
> +};
> +
> +static int kfd_spm_data_cocy (struct kfd_spm_cntr * spm_cntr, u32 size_to_copy)
> +{
> +        u32 user_buf_space_left;
> +        int ret = 0;
> +        u32 bufSize;
> +        uint64_t __user * user_address;
> +        uint64_t * ring_buf;
> +        
> +        pr_debug("[%s]\n", __func__);
> +
> +        bufSize = spm_cntr->ubuf[0].ubufsize;
> +        user_address = (uint64_t*)((uint64_t)spm_cntr->ubuf[0].user_addr + spm_cntr->spm_ring_size_copied);
> +        ring_buf =  (uint64_t*)((uint64_t)spm_cntr->spm_cpu_addr + spm_cntr->spm_ring_rptr);
> +
> +        if (user_address == NULL)
> +	        return -EFAULT;
> +
> +        user_buf_space_left = bufSize - spm_cntr->spm_ring_size_copied;
> +
> +        if (size_to_copy <= user_buf_space_left) {
> +		ret = copy_to_user(user_address, ring_buf, size_to_copy);
> +	     	if (ret) {
> +	        	pr_err("copy_to_user failed, ret = %x\n", ret);
> +			return -EFAULT;
> +              	}
> +		spm_cntr->spm_ring_size_copied += size_to_copy;
> +	} else {
> +		size_to_copy = spm_cntr->spm_ring_buf_size - spm_cntr->spm_ring_size_copied;
> +		ret = copy_to_user(user_address, ring_buf, user_buf_space_left);
> +		if (ret)
> +			return -EFAULT;
> +
> +		spm_cntr->spm_ring_size_copied = bufSize;
> +		spm_cntr->is_uesr_buf_filled = true;
> +	}
> +
> +	return ret;
> +}
> +
> +static int kfd_spm_reag_ring_buf_polling (struct kfd_spm_cntr * spm_cntr, long timeout)
> +{
> +	u32 size_to_copy;
> +	int ret = 0;
> +
> +	pr_info("[%s]\n", __func__);
> +
> +	while (spm_cntr->is_uesr_buf_filled != true){
> +		spm_cntr->spm_ring_rptr = amdgpu_amdkfd_rlc_spm_get_rdptr(spm_cntr->kgd) & spm_cntr->spm_ring_buf_mark;
> +#if 1
> +		spm_cntr->spm_ring_wptr = amdgpu_amdkfd_rlc_spm_get_wrptr(spm_cntr->kgd) & spm_cntr->spm_ring_buf_mark;
> +#else
> +		spm_cntr->spm_ring_wptr = spm_cntr->spm_cpu_addr[0] & spm_cntr->spm_ring_buf_mark;
> +#endif
> +
> +		if ((spm_cntr->spm_ring_rptr >= 0) &&  (spm_cntr->spm_ring_rptr  < 0x20))
> +				spm_cntr->spm_ring_rptr = 0x20;
> +
> +		if (spm_cntr->is_uesr_buf_filled == true)
> +			goto exit;
> +
> +		if (spm_cntr->spm_ring_wptr > spm_cntr->spm_ring_rptr) {
> +			size_to_copy = spm_cntr->spm_ring_wptr - spm_cntr->spm_ring_rptr;
> +			ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
> +		} else if (spm_cntr->spm_ring_wptr < spm_cntr->spm_ring_rptr) {
> +			size_to_copy = spm_cntr->spm_ring_buf_size - spm_cntr->spm_ring_rptr;
> +			ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
> +
> +			/* correct counter start point */
> +			spm_cntr->spm_ring_rptr = 0x20;
> +			size_to_copy = spm_cntr->spm_ring_wptr;
> +			ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
> +		}
> +
> +		if (!ret) {
> +			if (spm_cntr->is_uesr_buf_filled == true) {
> +				/* stop */
> +				amdgpu_amdkfd_rlc_spm_cntl(spm_cntr->kgd, 0);
> +				amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr->kgd, 0);
> +#if 0
> +				amdgpu_amdkfd_rlc_spm_set_wrptr(spm_cntr->kgd, 0);
> +#else
> +				spm_cntr->spm_cpu_addr[0]= 0;
> +#endif
> +				return ret;
> +			} else
> +				amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr->kgd, spm_cntr->spm_ring_wptr);
> +
> +			if (spm_cntr->is_timeout == true) {
> +				/* stop */
> +				amdgpu_amdkfd_rlc_spm_cntl(spm_cntr->kgd, 0);
> +				amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr->kgd, 0);
> +#if 0
> +				amdgpu_amdkfd_rlc_spm_set_wrptr(spm_cntr->kgd, 0);
> +#else
> +				spm_cntr->spm_cpu_addr[0]= 0;
> +#endif
> +				break;
> +			}
> +		}
> +	}
> +exit:
> +	return ret;
> +}
> +
> +static int kfd_spm_reag_ring_buf (struct kfd_spm_cntr * spm_cntr)
> +{
> +	u32 size_to_copy;
> +	int ret = 0;
> +
> +	pr_debug("[%s]\n", __func__);
> +
> +	spm_cntr->spm_ring_rptr = amdgpu_amdkfd_rlc_spm_get_rdptr(spm_cntr->kgd) & spm_cntr->spm_ring_buf_mark;
> +#if 1
> +	spm_cntr->spm_ring_wptr = amdgpu_amdkfd_rlc_spm_get_wrptr(spm_cntr->kgd) & spm_cntr->spm_ring_buf_mark;
> +#else
> +	spm_cntr->spm_ring_wptr = spm_cntr->spm_cpu_addr[0] & spm_cntr->spm_ring_buf_mark;
> +#endif
> +	if ((spm_cntr->spm_ring_rptr >= 0) &&  (spm_cntr->spm_ring_rptr  < 0x20)) {
> +		spm_cntr->spm_ring_rptr = 0x20;
> +	}
> +
> +	if (spm_cntr->is_uesr_buf_filled == true)
> +		goto exit;
> +
> +	if (spm_cntr->spm_ring_wptr > spm_cntr->spm_ring_rptr) {
> +		size_to_copy = spm_cntr->spm_ring_wptr - spm_cntr->spm_ring_rptr;
> +		ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
> +
> +	} else if (spm_cntr->spm_ring_wptr < spm_cntr->spm_ring_rptr) {
> +		size_to_copy = spm_cntr->spm_ring_buf_size - spm_cntr->spm_ring_rptr;
> +		ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
> +
> +		spm_cntr->spm_ring_rptr = 0x20;
> +		size_to_copy = spm_cntr->spm_ring_wptr;
> +		ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
> +	}
> +		if (!ret) {
> +			if (spm_cntr->is_uesr_buf_filled == true) {
> +				/* stop */
> +				amdgpu_amdkfd_rlc_spm_cntl(spm_cntr->kgd, 0);
> +				amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr->kgd, 0);
> +#if 0
> +				amdgpu_amdkfd_rlc_spm_set_wrptr(spm_cntr->kgd, 0);
> +#else
> +				spm_cntr->spm_cpu_addr[0]= 0;
> +#endif
> +				return ret;
> +			} else
> +				amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr->kgd, spm_cntr->spm_ring_wptr);
> +		}
> +exit:
> +	return ret;
> +}
> +
> +static int kfd_spm_sched_main(void *param)
> +{
> +	struct kfd_spm_cntr * spm_cntr = (struct kfd_spm_cntr *)param;
> +
> +	while (!kthread_should_stop()) {
> +		wait_event_interruptible(spm_cntr->spm_wq,
> +				spm_cntr->wanted_cluster != false ||
> +				kthread_should_stop());
> +
> +		kfd_spm_reag_ring_buf (spm_cntr);
> +
> +		spm_cntr->wanted_cluster = false;
> +	}
> +	return 0;
> +}
> +
> +static void transfer_data_process_worker(struct work_struct *work)
> +{
> +	struct kfd_process *p;
> +	struct delayed_work *dwork;
> +
> +	pr_debug("[%s]\n", __func__);
> +
> +	dwork = to_delayed_work(work);
> +
> +	/* Process termination destroys this worker thread. So during the
> +	 * lifetime of this thread, kfd_process p will be valid
> +	 */
> +	p = container_of(dwork, struct kfd_process, copy_to_user_work);
> +
> +	p->spm_cntr->is_timeout = true;
> +}
> +
> +
> +/**
> + * kfd_spm_init - init driver ring struct.
> + * Returns 0 on success, error on failure.
> + */
> +int kfd_spm_shed_init(struct kfd_process *p, struct kgd_dev *kgd)
> +{
> +	int ret = 0;
> +	init_waitqueue_head(&p->spm_cntr->spm_wq);
> +	p->spm_cntr->wanted_cluster = false;
> +	p->spm_cntr->kgd = kgd;
> +	INIT_DELAYED_WORK(&p->copy_to_user_work, transfer_data_process_worker);
> +
> +	/* Each scheduler will run on a seperate kernel thread */
> +	p->spm_cntr->thread = kthread_run(kfd_spm_sched_main, p->spm_cntr, p->spm_cntr->name);
> +	if (IS_ERR(p->spm_cntr->thread)) {
> +		ret = PTR_ERR(p->spm_cntr->thread);
> +		p->spm_cntr->thread = NULL;
> +		DRM_ERROR("Failed to create scheduler for %s.\n", p->spm_cntr->name);
> +		return ret;
> +	}
> +
> +	p->spm_cntr->thread_ready = true;
> +	return ret;
> +}
> +
> +/**
> + * amdgpu_ring_fini - tear down the driver ring struct.
> + *
> + * @adev: amdgpu_device pointer
> + * @ring: amdgpu_ring structure holding ring information
> + *
> + * Tear down the driver information for the selected ring (all asics).
> + */
> +void kfd_spm_shed_fini(struct kfd_process *p)
> +{
> +	if (p->spm_cntr->thread)
> +		kthread_stop(p->spm_cntr->thread);
> +
> +	cancel_delayed_work_sync(&p->copy_to_user_work);
> +	p->spm_cntr->thread = NULL;
> +	p->spm_cntr->thread_ready = false;
> +}
> +
> +void kfd_spm_init_process(struct kfd_process *p)
> +{
> +	mutex_init(&p->spm_mutex);
> +	p->spm_cntr = NULL;
> +	p->is_spm_acquired = false;
> +}
> +
> +static struct kfd_spm_cntr *allocate_spm_cntr_data(void)
> +{
> +	struct kfd_spm_cntr *cntr;
> +
> +	cntr = kzalloc(sizeof(*cntr), GFP_KERNEL);
> +	if (!cntr)
> +		return NULL;
> +
> +	return cntr;
> +}
> +
> +int kfd_acquire_spm(struct kfd_process *p, struct kgd_dev *kgd)
> +{
> +	int retval;
> +	int count;
> +
> +	pr_debug("[%s]\n", __func__);
> +
> +	if(p->is_spm_acquired == true)
> +		return EINVAL;
> +
> +	if (!p->spm_cntr) {
> +		p->spm_cntr = allocate_spm_cntr_data();
> +		if (!p->spm_cntr)
> +			return -ENOMEM;
> +		/* git spm ring buffer 128KB */
> +		p->spm_cntr->spm_ring_buf_size = order_base_2(128 * 1024/4);
> +		p->spm_cntr->spm_ring_buf_size = (1 << p->spm_cntr->spm_ring_buf_size) * 4;
> +		p->spm_cntr->spm_ring_buf_mark = p->spm_cntr->spm_ring_buf_size -1;
> +		for (count = 0; count < SAMPLING_MAX; ++count) {
> +			p->spm_cntr->ubuf[count].user_addr = NULL;
> +			p->spm_cntr->ubuf[count].ubufsize = 0;
> +		}
> +		p->spm_cntr->buf_count = 0;
> +		p->spm_cntr->is_uesr_buf_filled = false;
> +		p->spm_cntr->is_nowait = false;
> +		p->spm_cntr->thread_ready = false;
> +	}
> +
> +	retval = amdgpu_amdkfd_alloc_gtt_mem(kgd,
> +			p->spm_cntr->spm_ring_buf_size, &p->spm_cntr->spm_obj,
> +			&p->spm_cntr->spm_gpu_addr, (void *)&p->spm_cntr->spm_cpu_addr,
> +			false);
> +
> +	if (retval)
> +		return EINVAL;
> +
> +	memset(p->spm_cntr->spm_cpu_addr, 0, p->spm_cntr->spm_ring_buf_size);
> +
> +	amdgpu_amdkfd_rlc_spm_acquire(kgd, p->spm_cntr->spm_gpu_addr, p->spm_cntr->spm_ring_buf_size);
> +
> +	if (p->spm_cntr->thread_ready == false) {
> +		p->spm_cntr->name = "spm";
> +		retval = kfd_spm_shed_init(p, kgd);
> +		if (retval) {
> +			DRM_ERROR("Failed to create spm thread %s.\n",	p->spm_cntr->name);
> +			return retval;
> +		}
> +	}
> +	p->is_spm_acquired = true;
> +
> +	return 0;
> +}
> +
> +int kfd_release_spm(struct kfd_process *p, struct kgd_dev *kgd)
> +{
> +
> +	kfd_spm_shed_fini(p);
> +
> +	amdgpu_amdkfd_free_gtt_mem(kgd, p->spm_cntr->spm_obj);
> +
> +	kfree(p->spm_cntr);
> +	p->spm_cntr = NULL;
> +	p->is_spm_acquired = false;
> +
> +	return 0;
> +}
> +
> +int set_dest_buf_polling(struct kfd_spm_cntr *spm, struct kgd_dev *kgd, void __user *data)
> +{
> +	struct kfd_ioctl_spm_args __user *user_spm_data =
> +			(struct kfd_ioctl_spm_args __user *) data;
> +	u32 i;
> +	int ret = 0;
> +	unsigned long timeout;
> +
> +	pr_debug ("[%s]\n", __func__);
> +
> +	timeout = msecs_to_jiffies(user_spm_data->timeout) + 1;
> +
> +	/* if buf = NULL, stop spm */
> +	if (!user_spm_data->destptr) {
> +		amdgpu_amdkfd_rlc_spm_cntl(kgd, 0);
> +
> +		user_spm_data->bytes_copied = spm->spm_ring_size_copied;
> +		spm->spm_ring_size_copied = 0;
> +		user_spm_data->spmtptr = (uint64_t)spm->ubuf[0].user_addr;
> +
> +		for (i = 0; i < spm->buf_count; ++i) {
> +			spm->ubuf [i] = spm->ubuf [i+1];
> +		}
> +		spm->ubuf[spm->buf_count].user_addr = NULL;
> +		spm->ubuf[spm->buf_count].ubufsize = 0;
> +		spm->buf_count --;
> +		if (spm->buf_count < 0)
> +			spm->buf_count = 0;
> +		return ret;
> +	}
> +
> +	if (!spm->buf_count) {
> +		/* First time save user spm buffer, then start spm sampling */
> +		spm->ubuf[0].user_addr = (uint64_t*)user_spm_data->destptr;
> +		spm->ubuf[0].ubufsize = user_spm_data->buf_size;
> +		user_spm_data->bytes_copied = 0;
> +		spm->spm_ring_size_copied = 0;
> +		spm->buf_count ++;
> +		spm->is_uesr_buf_filled = false;
> +		amdgpu_amdkfd_rlc_spm_cntl(kgd, 1);
> +
> +		ret = kfd_spm_reag_ring_buf_polling (spm, timeout);
> +		user_spm_data->bytes_copied = spm->spm_ring_size_copied;
> +		user_spm_data->spmtptr = (uint64_t)spm->ubuf[0].user_addr;
> +		spm->buf_count --;
> +	} else {
> +		spm->spm_ring_size_copied = 0;
> +		spm->is_uesr_buf_filled = false;
> +		amdgpu_amdkfd_rlc_spm_cntl(kgd, 1);
> +		ret = kfd_spm_reag_ring_buf_polling (spm, timeout);
> +
> +		user_spm_data->bytes_copied = spm->spm_ring_size_copied;
> +		user_spm_data->spmtptr = (uint64_t)spm->ubuf[0].user_addr;
> +		spm->buf_count --;
> +
> +		for (i = 0; i < spm->buf_count; ++i)
> +			/* Repeated dest buf */
> +			if (spm->ubuf[i].user_addr == (uint64_t*)user_spm_data->destptr)
> +				break;
> +		if (i == spm->buf_count) {
> +			spm->ubuf[i].user_addr = (uint64_t*)user_spm_data->destptr;
> +			spm->ubuf[i].ubufsize = user_spm_data->buf_size;
> +			spm->buf_count ++;
> +		}
> +
> +		for (i = 0; i < spm->buf_count; ++i)
> +			spm->ubuf[i] = spm->ubuf[i + 1];
> +		spm->ubuf[spm->buf_count].user_addr  = NULL;
> +	}
> +
> +	user_spm_data->bytes_copied = spm->spm_ring_size_copied;
> +	return ret;
> +
> +}
> +
> +int kfd_set_dest_buffer(struct kfd_process *p, struct kgd_dev *kgd, void __user *data)
> +{
> +	struct kfd_ioctl_spm_args __user *user_spm_data =
> +							(struct kfd_ioctl_spm_args __user *) data;
> +	struct kfd_spm_cntr *spm = p->spm_cntr;
> +	unsigned long timeout;
> +
> +	pr_debug("[%s]\n", __func__);
> +
> +	if(p->is_spm_acquired == false)
> +		return -EINVAL;
> +
> +	timeout = msecs_to_jiffies(user_spm_data->timeout) + 1;
> +	spm->is_timeout = false;
> +	schedule_delayed_work(&p->copy_to_user_work, timeout);
> +	return set_dest_buf_polling(spm, kgd, data);
> +}
> +
> +int kfd_config_spm(struct kfd_process *p, struct kgd_dev *kgd,struct kfd_ioctl_spm_args *data)
> +{
> +	struct kfd_ioctl_spm_args __user *user_spm_data =
> +			(struct kfd_ioctl_spm_args __user *) data;
> +	struct kfd_spm_set_reg *spm_reg;
> +
> +	pr_debug("[%s]\n", __func__);
> +
> +	spm_reg = kvmalloc_array(1, sizeof (struct kfd_spm_set_reg), GFP_KERNEL);
> +
> +	if (copy_from_user(spm_reg, (void __user *)user_spm_data->destptr, sizeof (struct kfd_spm_set_reg))) {
> +		pr_err("copy_from_user Fail\n");
> +		goto exit;
> +	}
> +	amdgpu_amdkfd_rlc_spm_set_reg(kgd, spm_reg->reg, spm_reg->value);
> +exit:
> +	kfree(spm_reg);
> +	return 0;
> +}
> +
> +int kfd_rlc_spm(struct kfd_process *p,  void __user *data,
> +		       uint32_t buf_size, __u32 operation)
> +{
> +	struct kfd_ioctl_spm_args *args = data;
> +	struct kfd_dev *dev;
> +	int r;
> +
> +	dev = kfd_device_by_id(args->gpu_id);
> +	if (!dev)
> +		return -EINVAL;
> +
> +
> +	switch (operation) {
> +	case KFD_IOCTL_SPM_OP_ACQUIRE:
> +		dev->spm_pasid = p->pasid;
> +		r = kfd_acquire_spm(p, dev->kgd);
> +		break;
> +
> +	case KFD_IOCTL_SPM_OP_RELEASE:
> +		r = kfd_release_spm(p, dev->kgd);
> +				break;
> +
> +	case KFD_IOCTL_SPM_OP_SET_DEST_BUF:
> +		r = kfd_set_dest_buffer(p, dev->kgd, data);
> +		break;
> +
> +	case KFD_IOCTL_SPM_OP_CONFIG:
> +		r = kfd_config_spm(p, dev->kgd, args);
> +				break;
> +
> +	default:
> +		r = -EINVAL;
> +		break;
> +	}
> +	return r;
> +}
> +
> +void kfd_spm_interrupt(unsigned int pasid)
> +{
> +
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +
> +	if (!p) {
> +		pr_info("kfd_spm_interrupt p = %p \n", p);
> +		return; /* Presumably process exited. */
> +	}
> +
> +	mutex_lock(&p->spm_mutex);
> +
> +	p->spm_cntr->wanted_cluster = true;
> +	wake_up_interruptible(&p->spm_cntr->spm_wq);
> +
> +	mutex_unlock(&p->spm_mutex);
> +
> +	kfd_unref_process(p);
> +}
> +
> +bool kfd_spm_interrupt_isr(struct kfd_dev *dev,
> +					uint16_t source_id,	uint32_t client_id)
> +{
> +	pr_debug("[%s]\n", __func__);
> +
> +	if (source_id != GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT)
> +		return 0;
> +
> +	/* Interrupt types we care about: various signals and faults.
> +	 * They will be forwarded to a work queue (see below).
> +	 */
> +
> +	return source_id == GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT ||
> +		source_id == VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR ||
> +		client_id == AMDGPU_IRQ_CLIENTID_LEGACY ||
> +		client_id == SOC15_IH_CLIENTID_RLC;
> +}
> +
> +void kfd_spm_interrupt_wq(struct kfd_dev *dev,	uint16_t source_id)
> +{
> +	uint16_t pasid;
> +
> +	pr_debug("[%s]\n", __func__);
> +
> +	pasid = dev->spm_pasid;
> +#if 0
> +	if ((source_id == GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT) ||
> +				(source_id == VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR))
> +		kfd_spm_interrupt(pasid);
> +#endif
> +}
> diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> index 0bc0b25..fb4ad60 100644
> --- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> +++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
> @@ -30,6 +30,7 @@
>  #define SOC15_INTSRC_SQ_INTERRUPT_MSG	239
>  #define SOC15_INTSRC_VMC_FAULT		0
>  #define SOC15_INTSRC_SDMA_TRAP		224
> +#define AMDGPU_IRQ_CLIENTID_LEGACY	0
>  
>  
>  #define SOC15_CLIENT_ID_FROM_IH_ENTRY(entry) (le32_to_cpu(entry[0]) & 0xff)
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 4f66764..f7cb7d4 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -442,6 +442,56 @@ struct kfd_ioctl_import_dmabuf_args {
>  	__u32 dmabuf_fd;	/* to KFD */
>  };
>  
> +/**
> + * kfd_ioctl_spm_op - SPM ioctl operations
> + *
> + * @KFD_IOCTL_SPM_OP_ACQUIRE: acquire exclusive access to SPM
> + * @KFD_IOCTL_SPM_OP_RELEASE: release exclusive access to SPM
> + * @KFD_IOCTL_SPM_OP_SET_DEST_BUF: set or unset destination buffer for SPM streaming
> + */
> +enum kfd_ioctl_spm_op {
> +	KFD_IOCTL_SPM_OP_ACQUIRE,
> +	KFD_IOCTL_SPM_OP_RELEASE,
> +	KFD_IOCTL_SPM_OP_SET_DEST_BUF,
> +	KFD_IOCTL_SPM_OP_CONFIG
> +};
> +
> +/* Don't wait for previous buffer to fill up */
> +#define KFD_IOCTL_SPM_FLAG_POLLING 1
> +
> +/**
> + * kfd_ioctl_spm_args - Arguments for SPM ioctl
> + *
> + * @op:     specifies the operation to perform
> + * @destptr:used for the address of the destination buffer in @KFD_IOCTL_SPM_SET_DEST_BUFFER
> + * @buf_size:size  of the destination buffer in @KFD_IOCTL_SPM_SET_DEST_BUFFER
> + * @timeout: timeout to wait buffer get filled
> + * @gpu_id: gpi ID
> + * @bytes_copied: byte copied from streaming performance ring buffer
> + *
> + * If @ptr is NULL, the destination buffer address is unset and copying of counters
> + * is stopped.
> + *
> + * Returns negative error code on failure. On success, @KFD_IOCTL_SPM_OP_ACQUIRE and
> + * @KFD_IOCTL_SPM_OP_RELEASE return 0, @KFD_IOCTL_SPM_OP_SET_DEST_BUF returns the fill
> + * level of the previous buffer.
> + */
> +struct kfd_ioctl_spm_args {
> +	__u64 destptr;
> +	__u64 spmtptr;
> +	__u32 buf_size;
> +	__u32 op;
> +	__u32 timeout;
> +	__u32 gpu_id;	/* to KFD */
> +	/* from KFD: Total amount of bytes copied */
> +	__u64 bytes_copied;
> +};
> +
> +struct kfd_spm_set_reg {
> +	__u64 reg;		/* to KFD */
> +	__u32 value;
> +};
> +
>  /* Register offset inside the remapped mmio page
>   */
>  enum kfd_mmio_remap {
> @@ -546,7 +596,10 @@ enum kfd_mmio_remap {
>  #define AMDKFD_IOC_ALLOC_QUEUE_GWS		\
>  		AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)
>  
> +#define AMDKFD_IOC_RLC_SPM		\
> +		AMDKFD_IOWR(0x1F, struct kfd_ioctl_spm_args)
> +
>  #define AMDKFD_COMMAND_START		0x01
> -#define AMDKFD_COMMAND_END		0x1F
> +#define AMDKFD_COMMAND_END		0x20
>  
>  #endif

--------------36902861664473E3518DA748
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Gang,</p>
    <p>You've made a lot of progress on this. I'll need a day or two to
      review all of this in detail. Some general observations after a
      quick read-through:</p>
    <ul>
      <li>You have a function to acquire SPM. But it behaves more like
        &quot;steal SPM&quot;. You'll need some coordination with SPM VMID usage
        in the amdgpu_cs API. That means, either acquire SPM has to fail
        in some cases, or it needs to wait for amdgpu_cs to release the
        SPM VMID. The other way around, amdgpu_cs will have to wait for
        KFD to release the SPM VMID or fail if someone tries to use SPM.</li>
      <li>amdgpu_amdkfd_rlc_spm.c has a bunch of wrapper functions to
        allocated KIQ space and commit around ASIC-specific functions
        that write actual KIQ packets. But some of them don't actually
        use the KIQ. The rptr and wptr get functions just read a
        register.</li>
      <li>I'm not sure about the amdgpu_amdkfd_rlc_spm_set_reg function.
        It allocates a lot of space on the KIQ but only writes a single
        register. Was this meant to write many registers at once?</li>
      <li>Also, you're exposing MMIO or KIQ register access to user mode
        through the KFD_IOCTL_SPM_OP_CONFIG function. We should not
        allow this as it would give user mode access to privileged
        registers. It should also not be necessary because most of the
        SPM registers are unprivileged and accessible through user mode
        queues.</li>
    </ul>
    <p>I see a lot more minor issues and typos. I'll respond with more
      detailed comments in a separate email.</p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <div class="moz-cite-prefix">Am 2020-04-28 um 9:58 a.m. schrieb Gang
      Ba:<br>
    </div>
    <blockquote type="cite" cite="mid:1588082294-21523-1-git-send-email-gaba@amd.com">
      <pre class="moz-quote-pre" wrap="">Signed-off-by: Gang Ba <a class="moz-txt-link-rfc2396E" href="mailto:gaba@amd.com">&lt;gaba@amd.com&gt;</a>
Change-Id: If83ee0a14ef834699de6733eeab0f140159bbd6e
---
 drivers/gpu/drm/amd/amdgpu/Makefile                |   3 &#43;-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  10 &#43;
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c | 165 &#43;&#43;&#43;&#43;&#43;&#43;
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |  27 &#43;
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 175 &#43;&#43;&#43;&#43;&#43;&#43;&#43;
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              | 176 &#43;&#43;&#43;&#43;&#43;&#43;&#43;
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 168 &#43;&#43;&#43;&#43;&#43;&#43;
 drivers/gpu/drm/amd/amdkfd/Makefile                |   3 &#43;-
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c   |  10 &#43;-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  17 &#43;
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |  11 &#43;-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  20 &#43;
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   1 &#43;
 drivers/gpu/drm/amd/amdkfd/kfd_spm.c               | 577 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;
 drivers/gpu/drm/amd/amdkfd/soc15_int.h             |   1 &#43;
 include/uapi/linux/kfd_ioctl.h                     |  55 &#43;-
 16 files changed, 1413 insertions(&#43;), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_spm.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 210d57a..1498b18 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -177,7 &#43;177,8 @@ amdgpu-y &#43;= \
 	 amdgpu_amdkfd_gfx_v8.o \
 	 amdgpu_amdkfd_gfx_v9.o \
 	 amdgpu_amdkfd_arcturus.o \
-	 amdgpu_amdkfd_gfx_v10.o
&#43;	 amdgpu_amdkfd_gfx_v10.o \
&#43;	 amdgpu_amdkfd_rlc_spm.o \
 
 ifneq ($(CONFIG_DRM_AMDGPU_CIK),)
 amdgpu-y &#43;= amdgpu_amdkfd_gfx_v7.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index d065c50..fdc438a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -246,6 &#43;246,16 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo);
 int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
 				struct tile_config *config);
 
&#43;void amdgpu_amdkfd_rlc_spm_cntl(struct kgd_dev *kgd, bool cntl);
&#43;int amdgpu_amdkfd_rlc_spm(struct kgd_dev *kgd, void *args);
&#43;void amdgpu_amdkfd_rlc_spm_acquire(struct kgd_dev *kgd, u64 gpu_addr, u32 size);
&#43;int amdgpu_amdkfd_rlc_spm_release(struct kgd_dev *kgd);
&#43;u32 amdgpu_amdkfd_rlc_spm_get_rdptr(struct kgd_dev *kgd);
&#43;void amdgpu_amdkfd_rlc_spm_set_rdptr(struct kgd_dev *kgd, u32 rptr);
&#43;u32 amdgpu_amdkfd_rlc_spm_get_wrptr(struct kgd_dev *kgd);
&#43;void amdgpu_amdkfd_rlc_spm_set_wrptr(struct kgd_dev *kgd, u32 wptr);
&#43;int amdgpu_amdkfd_rlc_spm_set_reg(struct kgd_dev *kgd, u64 uReg, u32 value);
&#43;
 /* KGD2KFD callbacks */
 int kgd2kfd_init(void);
 void kgd2kfd_exit(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c
new file mode 100644
index 0000000..b492c1e
--- /dev/null
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c
@@ -0,0 &#43;1,165 @@
&#43;/*
&#43; * Copyright 2014-2020 Advanced Micro Devices, Inc.
&#43; *
&#43; * Permission is hereby granted, free of charge, to any person obtaining a
&#43; * copy of this software and associated documentation files (the &quot;Software&quot;),
&#43; * to deal in the Software without restriction, including without limitation
&#43; * the rights to use, copy, modify, merge, publish, distribute, sublicense,
&#43; * and/or sell copies of the Software, and to permit persons to whom the
&#43; * Software is furnished to do so, subject to the following conditions:
&#43; *
&#43; * The above copyright notice and this permission notice shall be included in
&#43; * all copies or substantial portions of the Software.
&#43; *
&#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
&#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
&#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
&#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
&#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
&#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
&#43; * OTHER DEALINGS IN THE SOFTWARE.
&#43; */
&#43;
&#43;#include &lt;linux/dma-buf.h&gt;
&#43;#include &lt;linux/list.h&gt;
&#43;#include &lt;linux/pagemap.h&gt;
&#43;#include &lt;linux/sched/mm.h&gt;
&#43;#include &lt;linux/sched/task.h&gt;
&#43;
&#43;#include &quot;amdgpu_object.h&quot;
&#43;#include &quot;amdgpu_vm.h&quot;
&#43;#include &quot;amdgpu_amdkfd.h&quot;
&#43;#include &lt;uapi/linux/kfd_ioctl.h&gt;
&#43;
&#43;
&#43;
&#43;void amdgpu_amdkfd_rlc_spm_cntl(struct kgd_dev *kgd, bool cntl)
&#43;{
&#43;    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
&#43;    	struct amdgpu_spm *spm = &amp;adev-&gt;gfx.spm;
&#43;    	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;
&#43;    	spin_lock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;    	amdgpu_ring_alloc(kiq_ring, spm-&gt;spmf-&gt;get_spm_data_size);
&#43;    	cntl == true ? adev-&gt;gfx.spm.spmf-&gt;start(adev):adev-&gt;gfx.spm.spmf-&gt;stop(adev);
&#43;    	amdgpu_ring_commit(kiq_ring);
&#43;    	spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;}
&#43;
&#43;u32 amdgpu_amdkfd_rlc_spm_get_rdptr(struct kgd_dev *kgd)
&#43;{
&#43;    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
&#43;    	struct amdgpu_spm *spm = &amp;adev-&gt;gfx.spm;
&#43;    	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;    	u32 rptr = 0;
&#43;
&#43;    	spin_lock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;    	amdgpu_ring_alloc(kiq_ring, spm-&gt;spmf-&gt;get_spm_data_size);
&#43;    	rptr = adev-&gt;gfx.spm.spmf-&gt;get_rdptr(adev);
&#43;    	amdgpu_ring_commit(kiq_ring);
&#43;    	spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;
&#43;    	return rptr;
&#43;}
&#43;
&#43;void amdgpu_amdkfd_rlc_spm_set_rdptr(struct kgd_dev *kgd, u32 rptr)
&#43;{
&#43;    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
&#43;    	struct amdgpu_spm *spm = &amp;adev-&gt;gfx.spm;
&#43;    	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;
&#43;    	spin_lock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;    	amdgpu_ring_alloc(kiq_ring, spm-&gt;spmf-&gt;get_spm_data_size);
&#43;    	adev-&gt;gfx.spm.spmf-&gt;set_rdptr(adev, rptr);
&#43;    	amdgpu_ring_commit(kiq_ring);
&#43;    	spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;
&#43;}
&#43;
&#43;u32 amdgpu_amdkfd_rlc_spm_get_wrptr(struct kgd_dev *kgd)
&#43;{
&#43;    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
&#43;    	struct amdgpu_spm *spm = &amp;adev-&gt;gfx.spm;
&#43;    	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;    	u32 wptr;
&#43;
&#43;    	spin_lock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;    	amdgpu_ring_alloc(kiq_ring, spm-&gt;spmf-&gt;get_spm_data_size);
&#43;    	wptr = adev-&gt;gfx.spm.spmf-&gt;get_wrptr(adev);
&#43;    	amdgpu_ring_commit(kiq_ring);
&#43;    	spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;    	return wptr;
&#43;}
&#43;
&#43;void amdgpu_amdkfd_rlc_spm_set_wrptr(struct kgd_dev *kgd, u32 wptr)
&#43;{
&#43;    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
&#43;    	struct amdgpu_spm *spm = &amp;adev-&gt;gfx.spm;
&#43;    	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;
&#43;    	spin_lock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;    	amdgpu_ring_alloc(kiq_ring, spm-&gt;spmf-&gt;get_spm_data_size);
&#43;    	adev-&gt;gfx.spm.spmf-&gt;set_wrptr(adev, wptr);
&#43;    	amdgpu_ring_commit(kiq_ring);
&#43;    	spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;}
&#43;
&#43;void amdgpu_amdkfd_rlc_spm_acquire(struct kgd_dev *kgd, u64 gpu_addr, u32 size)
&#43;{
&#43;    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
&#43;    	struct amdgpu_spm *spm = &amp;adev-&gt;gfx.spm;
&#43;    	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;
&#43;    	/* init spm vmid with 0xf */
&#43;    	if (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid)
&#43;        	adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0x0);
&#43;
&#43;    	/* set spm ring registers */
&#43;    	spin_lock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;    	amdgpu_ring_alloc(kiq_ring, spm-&gt;spmf-&gt;get_spm_data_size);
&#43;    	adev-&gt;gfx.spm.spmf-&gt;set_spm_porfmon_ring_buf(adev, gpu_addr, size);
&#43;    	amdgpu_ring_commit(kiq_ring);
&#43;    	spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;}
&#43;
&#43;
&#43;int amdgpu_amdkfd_rlc_spm_release(struct kgd_dev *kgd)
&#43;{
&#43;    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
&#43;    	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;    	struct amdgpu_spm *spm = &amp;adev-&gt;gfx.spm;
&#43;
&#43;    	/* stop spm stream and interupt */
&#43;    	spin_lock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;    	amdgpu_ring_alloc(kiq_ring, spm-&gt;spmf-&gt;get_spm_data_size);
&#43;    	adev-&gt;gfx.spm.spmf-&gt;stop(adev);
&#43;    	amdgpu_ring_commit(kiq_ring);
&#43;    	spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;
&#43;    	amdgpu_irq_put(adev, &amp;adev-&gt;gfx.spm_irq, 0);
&#43;
&#43;    	/* revert spm vmid with 0xf */
&#43;    	if (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid)
&#43;             adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0xf);
&#43;
&#43;    	return 0;
&#43;}
&#43;
&#43;int amdgpu_amdkfd_rlc_spm_set_reg(struct kgd_dev *kgd, u64 uReg, u32 value)
&#43;{
&#43;    	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
&#43;    	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;    	struct amdgpu_spm *spm = &amp;adev-&gt;gfx.spm;
&#43;
&#43;    	pr_debug(&quot;[%s]\n&quot;, __func__);
&#43;
&#43;    	/* stop spm stream and interupt */
&#43;    	spin_lock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;    	amdgpu_ring_alloc(kiq_ring, spm-&gt;spmf-&gt;get_spm_data_size);
&#43;    	adev-&gt;gfx.spm.spmf-&gt;set_reg(adev, uReg, value);
&#43;    	amdgpu_ring_commit(kiq_ring);
&#43;    	spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);
&#43;
&#43;    	return 0;
&#43;}
&#43;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ee698f0..ba4da52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -105,6 &#43;105,31 @@ struct amdgpu_kiq {
 	const struct kiq_pm4_funcs *pmf;
 };
 
&#43;struct spm_funcs {
&#43;	void (*start)(struct amdgpu_device *adev);
&#43;	void (*stop)(struct amdgpu_device *adev);
&#43;	void (*set_reg)(struct amdgpu_device *adev, uint64_t reg, uint32_t val);
&#43;	u32 (*get_rdptr)(struct amdgpu_device *adev);
&#43;	void (*set_rdptr)(struct amdgpu_device *adev, u32 rptr);
&#43;	u32 (*get_wrptr)(struct amdgpu_device *adev);
&#43;	void (*set_wrptr)(struct amdgpu_device *adev, u32 wptr);
&#43;	void (*set_spm_porfmon_ring_buf)(struct amdgpu_device *adev, u64 gpu_rptr, u32 size);
&#43;
&#43;	/* Packet sizes */
&#43;	int set_spm_config_size;
&#43;	int get_spm_data_size;
&#43;};
&#43;
&#43;struct amdgpu_spm {
&#43;	const struct spm_funcs *spmf;
&#43;	u64              spm_gpu_addr;
&#43;	u32              spm_gpu_size;
&#43;	u32              spm_ring_rptr;
&#43;	u32              spm_ring_rptrsize_to_read;
&#43;	struct amdgpu_bo *spm_obj;
&#43;	void             *spm_cpu_addr;
&#43;};
&#43;
 /*
  * GPU scratch registers structures, functions &amp; helpers
  */
@@ -256,6 &#43;281,7 @@ struct amdgpu_gfx {
 	struct amdgpu_me		me;
 	struct amdgpu_mec		mec;
 	struct amdgpu_kiq		kiq;
&#43;	struct amdgpu_spm		spm;
 	struct amdgpu_scratch		scratch;
 	const struct firmware		*me_fw;	/* ME firmware */
 	uint32_t			me_fw_version;
@@ -292,6 &#43;318,7 @@ struct amdgpu_gfx {
 	struct amdgpu_irq_src		priv_reg_irq;
 	struct amdgpu_irq_src		priv_inst_irq;
 	struct amdgpu_irq_src		cp_ecc_error_irq;
&#43;	struct amdgpu_irq_src		spm_irq;
 	struct amdgpu_irq_src		sq_irq;
 	struct sq_work			sq_work;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 63ac430..9c507d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4121,6 &#43;4121,13 @@ static int gfx_v10_0_sw_init(void *handle)
 	if (r)
 		return r;
 
&#43;	/* KIQ SPM */
&#43;	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
&#43;			      GFX_10_1__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT,
&#43;			      &amp;adev-&gt;gfx.spm_irq);
&#43;	if (r)
&#43;		return r;
&#43;
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP,
 			      GFX_10_1__SRCID__CP_EOP_INTERRUPT,
@@ -6603,6 &#43;6610,7 @@ static int gfx_v10_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &amp;adev-&gt;gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &amp;adev-&gt;gfx.priv_inst_irq, 0);
&#43;	amdgpu_irq_put(adev, &amp;adev-&gt;gfx.spm_irq, 0);
 #ifndef BRING_UP_DEBUG
 	if (amdgpu_async_gfx_ring) {
 		r = gfx_v10_0_kiq_disable_kgq(adev);
@@ -6768,6 &#43;6776,126 @@ static void gfx_v10_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
 				    (1 &lt;&lt; (oa_size &#43; oa_base)) - (1 &lt;&lt; oa_base));
 }
 
&#43;static void gfx_v10_0_spm_start(struct amdgpu_device *adev)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;	uint32_t data = 0;
&#43;	u8 se;
&#43;
&#43;	for (se = 0; se &lt; adev-&gt;gfx.config.max_shader_engines &#43; 1; &#43;&#43;se)
&#43;	{
&#43;		uint32_t mux_addr_reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_GLOBAL_MUXSEL_ADDR);
&#43;		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
&#43;			INSTANCE_BROADCAST_WRITES, 1);
&#43;		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
&#43;			SA_BROADCAST_WRITES, 1);
&#43;		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
&#43;			SE_BROADCAST_WRITES, 1);
&#43;
&#43;		if (se &lt; adev-&gt;gfx.config.max_shader_engines) // SE else GB
&#43;		{
&#43;			data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se);
&#43;			mux_addr_reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_SE_MUXSEL_ADDR);
&#43;		}
&#43;		gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
&#43;		gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, mux_addr_reg, 0);
&#43;	}
&#43;
&#43;	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, 0);
&#43;	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1);
&#43;	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
&#43;
&#43;	data = 0;
&#43;	data |= CP_PERFMON_STATE_DISABLE_AND_RESET &lt;&lt;4 ;
&#43;	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
&#43;
&#43;	data = 0;
&#43;	data |= STRM_PERFMON_STATE_START_COUNTING &lt;&lt;4 ;
&#43;	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
&#43;
&#43;	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL) ,1);
&#43;}
&#43;
&#43;static void gfx_v10_0_spm_stop(struct amdgpu_device *adev)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;	uint32_t data = 0;
&#43;
&#43;	data = CP_PERFMON_STATE_STOP_COUNTING;
&#43;	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
&#43;
&#43;	data |= (1&lt;&lt;10);
&#43;	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
&#43;
&#43;	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL), 0);
&#43;}
&#43;
&#43;static u32 gfx_v10_0_spm_get_rdptr(struct amdgpu_device *adev)
&#43;{
&#43;	return RREG32_SOC15(GC, 0, mmRLC_SPM_RING_RDPTR);;
&#43;}
&#43;
&#43;static void gfx_v10_0_spm_set_rdptr(struct amdgpu_device *adev,  u32 rptr)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;
&#43;	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), rptr);
&#43;}
&#43;
&#43;static u32 gfx_v10_0_spm_get_wrptr(struct amdgpu_device *adev)
&#43;{
&#43;	return RREG32_SOC15(GC, 0, mmRLC_SPM_RING_WRPTR);
&#43;}
&#43;
&#43;static void gfx_v10_0_spm_set_wrptr(struct amdgpu_device *adev,  u32 wptr)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;
&#43;	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_WRPTR), wptr);
&#43;}
&#43;
&#43;static void gfx_v10_0_set_spm_porfmon_ring_buf(struct amdgpu_device *adev, u64 gpu_addr, u32 size)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;
&#43;	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0,
&#43;			mmRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu_addr));
&#43;
&#43;	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false,
&#43;			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_BASE_HI), upper_32_bits (gpu_addr));
&#43;
&#43;	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false,
&#43;			SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_SIZE), size);
&#43;}
&#43;
&#43;static void gfx_v10_0_spm_set_reg(struct amdgpu_device *adev, u64 reg, u32 value)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;	uint32_t grbm_cntl;
&#43;	grbm_cntl = adev-&gt;reg_offset[GC_HWIP][0][1] &#43; reg;
&#43;
&#43;	gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, grbm_cntl, value);
&#43;}
&#43;
&#43;static const struct spm_funcs gfx_v10_0_spm_funcs = {
&#43;	.start = gfx_v10_0_spm_start,
&#43;	.stop = gfx_v10_0_spm_stop,
&#43;	.get_rdptr= gfx_v10_0_spm_get_rdptr,
&#43;	.set_rdptr= gfx_v10_0_spm_set_rdptr,
&#43;	.get_wrptr= gfx_v10_0_spm_get_wrptr,
&#43;	.set_wrptr= gfx_v10_0_spm_set_wrptr,
&#43;	.set_spm_porfmon_ring_buf = gfx_v10_0_set_spm_porfmon_ring_buf,
&#43;	.set_reg = gfx_v10_0_spm_set_reg,
&#43;	.set_spm_config_size = 3,
&#43;	.get_spm_data_size = 128,
&#43;};
&#43;
&#43;static void gfx_v10_0_set_spm_funcs(struct amdgpu_device *adev)
&#43;{
&#43;	adev-&gt;gfx.spm.spmf = &amp;gfx_v10_0_spm_funcs;
&#43;}
&#43;
&#43;
 static int gfx_v10_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -6776,6 &#43;6904,7 @@ static int gfx_v10_0_early_init(void *handle)
 
 	adev-&gt;gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
 
&#43;	gfx_v10_0_set_spm_funcs(adev);
 	gfx_v10_0_set_kiq_pm4_funcs(adev);
 	gfx_v10_0_set_ring_funcs(adev);
 	gfx_v10_0_set_irq_funcs(adev);
@@ -6794,6 &#43;6923,10 @@ static int gfx_v10_0_late_init(void *handle)
 	if (r)
 		return r;
 
&#43;        r = amdgpu_irq_get(adev, &amp;adev-&gt;gfx.spm_irq, 0);
&#43;        if (r)
&#43;		return r;
&#43;
 	r = amdgpu_irq_get(adev, &amp;adev-&gt;gfx.priv_inst_irq, 0);
 	if (r)
 		return r;
@@ -6860,6 &#43;6993,7 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
 
&#43;
 		/* MGLS is a global flag to control all MGLS in GFX */
 		if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_MGLS) {
 			/* 2 - RLC memory Light sleep */
@@ -8018,6 &#43;8152,39 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
&#43;static int gfx_v10_0_spm_set_interrupt_state(struct amdgpu_device *adev,
&#43;					     struct amdgpu_irq_src *src,
&#43;					     unsigned int type,
&#43;					     enum amdgpu_interrupt_state state)
&#43;{
&#43;	switch (state) {
&#43;	case AMDGPU_IRQ_STATE_DISABLE:
&#43;		WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 0);
&#43;		break;
&#43;	case AMDGPU_IRQ_STATE_ENABLE:
&#43;		WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 1);
&#43;		break;
&#43;	default:
&#43;		break;
&#43;	}
&#43;	return 0;
&#43;}
&#43;
&#43;static int gfx_v10_0_spm_irq(struct amdgpu_device *adev,
&#43;			     struct amdgpu_irq_src *source,
&#43;			     struct amdgpu_iv_entry *entry)
&#43;{
&#43;	u8 me_id, pipe_id, queue_id;
&#43;
&#43;	me_id = (entry-&gt;ring_id &amp; 0x0c) &gt;&gt; 2;
&#43;	pipe_id = (entry-&gt;ring_id &amp; 0x03) &gt;&gt; 0;
&#43;	queue_id = (entry-&gt;ring_id &amp; 0x70) &gt;&gt; 4;
&#43;	pr_debug (&quot;IH: RLC_RPM_INT, me:%d, pipe:%d, queue:%d\n&quot;,
&#43;                                         me_id, pipe_id, queue_id);
&#43;	return  0; /* This prevents sending it to KFD */
&#43;}
&#43;
&#43;
 static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
 	.name = &quot;gfx_v10_0&quot;,
 	.early_init = gfx_v10_0_early_init,
@@ -8189,6 &#43;8356,11 @@ static const struct amdgpu_irq_src_funcs gfx_v10_0_kiq_irq_funcs = {
 	.process = gfx_v10_0_kiq_irq,
 };
 
&#43;static const struct amdgpu_irq_src_funcs gfx_v10_0_spm_irq_funcs = {
&#43;    .set = gfx_v10_0_spm_set_interrupt_state,
&#43;    .process = gfx_v10_0_spm_irq,
&#43;};
&#43;
 static void gfx_v10_0_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev-&gt;gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
@@ -8197,6 &#43;8369,9 @@ static void gfx_v10_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev-&gt;gfx.kiq.irq.num_types = AMDGPU_CP_KIQ_IRQ_LAST;
 	adev-&gt;gfx.kiq.irq.funcs = &amp;gfx_v10_0_kiq_irq_funcs;
 
&#43;	adev-&gt;gfx.spm_irq.num_types = 1;
&#43;	adev-&gt;gfx.spm_irq.funcs = &amp;gfx_v10_0_spm_irq_funcs;
&#43;
 	adev-&gt;gfx.priv_reg_irq.num_types = 1;
 	adev-&gt;gfx.priv_reg_irq.funcs = &amp;gfx_v10_0_priv_reg_irq_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 14790f8..1125b91 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1955,6 &#43;1955,12 @@ static int gfx_v8_0_sw_init(void *handle)
 	adev-&gt;gfx.mec.num_pipe_per_mec = 4;
 	adev-&gt;gfx.mec.num_queue_per_pipe = 8;
 
&#43;	/* KIQ SPM */
&#43;	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY,	VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR,
&#43;			      &amp;adev-&gt;gfx.spm_irq);
&#43;	if (r)
&#43;        return r;
&#43;
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, VISLANDS30_IV_SRCID_CP_END_OF_PIPE, &amp;adev-&gt;gfx.eop_irq);
 	if (r)
@@ -4927,6 &#43;4933,7 @@ static int gfx_v8_0_hw_fini(void *handle)
 	amdgpu_irq_put(adev, &amp;adev-&gt;gfx.cp_ecc_error_irq, 0);
 
 	amdgpu_irq_put(adev, &amp;adev-&gt;gfx.sq_irq, 0);
&#43;	amdgpu_irq_put(adev, &amp;adev-&gt;gfx.spm_irq, 0);
 
 	/* disable KCQ to avoid CPC touch memory not valid anymore */
 	gfx_v8_0_kcq_disable(adev);
@@ -5291,6 &#43;5298,126 @@ static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs = {
 	.select_me_pipe_q = &amp;gfx_v8_0_select_me_pipe_q
 };
 
&#43;static void gfx_v8_0_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
&#43;				       bool wc, uint32_t reg, uint32_t val)
&#43;{
&#43;	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
&#43;	amdgpu_ring_write(ring, WRITE_DATA_ENGINE_SEL(eng_sel) |
&#43;				WRITE_DATA_DST_SEL(0) |
&#43;				(wc ? WR_CONFIRM : 0));
&#43;	amdgpu_ring_write(ring, reg);
&#43;	amdgpu_ring_write(ring, 0);
&#43;	amdgpu_ring_write(ring, val);
&#43;}
&#43;
&#43;static void gfx_v8_0_spm_start(struct amdgpu_device *adev)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;	uint32_t data = 0;
&#43;	u8 se;
&#43;
&#43;	for (se = 0; se &lt; adev-&gt;gfx.config.max_shader_engines &#43; 1; &#43;&#43;se)
&#43;	{
&#43;		uint32_t mux_addr_reg = mmRLC_SPM_GLOBAL_MUXSEL_ADDR;
&#43;
&#43;		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
&#43;			INSTANCE_BROADCAST_WRITES, 1);
&#43;		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
&#43;			SH_BROADCAST_WRITES, 1);
&#43;		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
&#43;			SE_BROADCAST_WRITES, 1);
&#43;
&#43;		if (se &lt; adev-&gt;gfx.config.max_shader_engines) // SE else GB
&#43;		{
&#43;			data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se);
&#43;
&#43;			mux_addr_reg = mmRLC_SPM_SE_MUXSEL_ADDR;
&#43;		}
&#43;		gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmGRBM_GFX_INDEX, data);
&#43;		// init addr
&#43;		gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mux_addr_reg, data);
&#43;	}
&#43;
&#43;	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, 0);
&#43;	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1);
&#43;	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmGRBM_GFX_INDEX, data);
&#43;
&#43;	data = 0;
&#43;	data |= CP_PERFMON_STATE_DISABLE_AND_RESET &lt;&lt;4 ;
&#43;	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL, data);
&#43;
&#43;	data = 0;
&#43;	data |= STRM_PERFMON_STATE_START_COUNTING &lt;&lt;4 ;
&#43;	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL,	data);
&#43;
&#43;	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_INT_CNTL ,1);
&#43;}
&#43;
&#43;static void gfx_v8_0_spm_stop(struct amdgpu_device *adev)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;	uint32_t data = 0;
&#43;
&#43;	data = CP_PERFMON_STATE_STOP_COUNTING;
&#43;	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL, data);
&#43;	data |= (1&lt;&lt;10);
&#43;	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL, data);
&#43;
&#43;	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_INT_CNTL, 0);
&#43;}
&#43;
&#43;
&#43;static u32 gfx_v8_0_spm_get_rdptr(struct amdgpu_device *adev)
&#43;{
&#43;	return RREG32 (mmRLC_SPM_RING_RDPTR);
&#43;}
&#43;
&#43;static void gfx_v8_0_spm_set_rdptr(struct amdgpu_device *adev,  u32 rptr)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;
&#43;	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_RING_RDPTR, rptr);
&#43;}
&#43;
&#43;static u32 gfx_v8_0_spm_get_wrptr(struct amdgpu_device *adev)
&#43;{
&#43;	return  -1;
&#43;}
&#43;
&#43;static void gfx_v8_0_set_spm_porfmon_ring_buf(struct amdgpu_device *adev, u64 gpu_addr, u32 size)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;
&#43;	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_PERFMON_RING_BASE_LO, lower_32_bits(gpu_addr));
&#43;
&#43;	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_PERFMON_RING_BASE_HI, upper_32_bits (gpu_addr));
&#43;
&#43;	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_PERFMON_RING_SIZE, size);
&#43;}
&#43;
&#43;static void gfx_v8_0_spm_set_reg(struct amdgpu_device *adev, u64 reg, u32 value)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;	gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, reg, value);
&#43;}
&#43;
&#43;static const struct spm_funcs gfx_v8_0_spm_funcs = {
&#43;	.start = gfx_v8_0_spm_start,
&#43;	.stop = gfx_v8_0_spm_stop,
&#43;	.get_rdptr= gfx_v8_0_spm_get_rdptr,
&#43;	.set_rdptr= gfx_v8_0_spm_set_rdptr,
&#43;	.get_wrptr= gfx_v8_0_spm_get_wrptr,
&#43;	.set_spm_porfmon_ring_buf = gfx_v8_0_set_spm_porfmon_ring_buf,
&#43;	.set_reg = gfx_v8_0_spm_set_reg,
&#43;	.set_spm_config_size = 3,
&#43;	.get_spm_data_size = 128,
&#43;};
&#43;
&#43;static void gfx_v8_0_set_spm_funcs(struct amdgpu_device *adev)
&#43;{
&#43;	adev-&gt;gfx.spm.spmf = &amp;gfx_v8_0_spm_funcs;
&#43;}
&#43;
 static int gfx_v8_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -5298,6 &#43;5425,8 @@ static int gfx_v8_0_early_init(void *handle)
 	adev-&gt;gfx.num_gfx_rings = GFX8_NUM_GFX_RINGS;
 	adev-&gt;gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
 	adev-&gt;gfx.funcs = &amp;gfx_v8_0_gfx_funcs;
&#43;
&#43;	gfx_v8_0_set_spm_funcs(adev);
 	gfx_v8_0_set_ring_funcs(adev);
 	gfx_v8_0_set_irq_funcs(adev);
 	gfx_v8_0_set_gds_init(adev);
@@ -5338,6 &#43;5467,10 @@ static int gfx_v8_0_late_init(void *handle)
 		return r;
 	}
 
&#43;	r = amdgpu_irq_get(adev, &amp;adev-&gt;gfx.spm_irq, 0);
&#43;	if (r)
&#43;		return r;
&#43;
 	return 0;
 }
 
@@ -6845,6 &#43;6978,41 @@ static void gfx_v8_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
 }
 
&#43;static int gfx_v8_0_spm_set_interrupt_state(struct amdgpu_device *adev,
&#43;					     struct amdgpu_irq_src *src,
&#43;					     unsigned int type,
&#43;					     enum amdgpu_interrupt_state state)
&#43;{
&#43;	switch (state) {
&#43;	case AMDGPU_IRQ_STATE_DISABLE:
&#43;		WREG32(mmRLC_SPM_INT_CNTL, 0);
&#43;		break;
&#43;	case AMDGPU_IRQ_STATE_ENABLE:
&#43;		WREG32(mmRLC_SPM_INT_CNTL, 1);
&#43;		break;
&#43;	default:
&#43;		break;
&#43;	}
&#43;	return 0;
&#43;}
&#43;
&#43;static int gfx_v8_0_spm_irq(struct amdgpu_device *adev,
&#43;			     struct amdgpu_irq_src *source,
&#43;			     struct amdgpu_iv_entry *entry)
&#43;{
&#43;	u8 me_id, pipe_id, queue_id;
&#43;	struct amdgpu_ring *ring = &amp;(adev-&gt;gfx.kiq.ring);
&#43;
&#43;	me_id = (entry-&gt;ring_id &amp; 0x0c) &gt;&gt; 2;
&#43;	pipe_id = (entry-&gt;ring_id &amp; 0x03) &gt;&gt; 0;
&#43;	queue_id = (entry-&gt;ring_id &amp; 0x70) &gt;&gt; 4;
&#43;	pr_debug(&quot;IH: RLC_RPM_INT, me:%d, pipe:%d, queue:%d\n&quot;,
&#43;			me_id, pipe_id, queue_id);
&#43;
&#43;	amdgpu_fence_process(ring);
&#43;	return 0;
&#43;}
&#43;
 static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
 	.name = &quot;gfx_v8_0&quot;,
 	.early_init = gfx_v8_0_early_init,
@@ -7005,11 &#43;7173,19 @@ static const struct amdgpu_irq_src_funcs gfx_v8_0_sq_irq_funcs = {
 	.process = gfx_v8_0_sq_irq,
 };
 
&#43;static const struct amdgpu_irq_src_funcs gfx_v8_0_spm_irq_funcs = {
&#43;	.set = gfx_v8_0_spm_set_interrupt_state,
&#43;	.process = gfx_v8_0_spm_irq,
&#43;};
&#43;
 static void gfx_v8_0_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev-&gt;gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
 	adev-&gt;gfx.eop_irq.funcs = &amp;gfx_v8_0_eop_irq_funcs;
 
&#43;	adev-&gt;gfx.spm_irq.num_types = 1;
&#43;	adev-&gt;gfx.spm_irq.funcs = &amp;gfx_v8_0_spm_irq_funcs;
&#43;
 	adev-&gt;gfx.priv_reg_irq.num_types = 1;
 	adev-&gt;gfx.priv_reg_irq.funcs = &amp;gfx_v8_0_priv_reg_irq_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2767c6d..bfde274 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2249,6 &#43;2249,13 @@ static int gfx_v9_0_sw_init(void *handle)
 	adev-&gt;gfx.mec.num_pipe_per_mec = 4;
 	adev-&gt;gfx.mec.num_queue_per_pipe = 8;
 
&#43;	/* KIQ SPM */
&#43;	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
&#43;			      GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT,
&#43;			      &amp;adev-&gt;gfx.spm_irq);
&#43;	if (r)
&#43;        return r;
&#43;
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__SRCID__CP_EOP_INTERRUPT, &amp;adev-&gt;gfx.eop_irq);
 	if (r)
@@ -3907,6 &#43;3914,7 @@ static int gfx_v9_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &amp;adev-&gt;gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &amp;adev-&gt;gfx.priv_reg_irq, 0);
&#43;	amdgpu_irq_put(adev, &amp;adev-&gt;gfx.spm_irq, 0);
 	amdgpu_irq_put(adev, &amp;adev-&gt;gfx.priv_inst_irq, 0);
 
 	/* DF freeze and kcq disable will fail */
@@ -4617,6 &#43;4625,121 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	return r;
 }
 
&#43;static void gfx_v9_0_spm_start(struct amdgpu_device *adev)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;	uint32_t data = 0;
&#43;	u8 se;
&#43;
&#43;	for (se = 0; se &lt; adev-&gt;gfx.config.max_shader_engines &#43; 1; &#43;&#43;se)
&#43;	{
&#43;		uint32_t mux_addr_reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_GLOBAL_MUXSEL_ADDR);
&#43;
&#43;		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
&#43;			INSTANCE_BROADCAST_WRITES, 1);
&#43;		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
&#43;			SH_BROADCAST_WRITES, 1);
&#43;		data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
&#43;			SE_BROADCAST_WRITES, 1);
&#43;
&#43;		if (se &lt; adev-&gt;gfx.config.max_shader_engines) // SE else GB
&#43;		{
&#43;			data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se);
&#43;
&#43;			mux_addr_reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_SE_MUXSEL_ADDR);
&#43;		}
&#43;		gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
&#43;		// init addr
&#43;		gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, mux_addr_reg, data);
&#43;	}
&#43;
&#43;	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, 0);
&#43;	data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1);
&#43;	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
&#43;
&#43;	data = 0;
&#43;	data |= CP_PERFMON_STATE_DISABLE_AND_RESET &lt;&lt;4 ;
&#43;	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
&#43;
&#43;	data = 0;
&#43;	data |= STRM_PERFMON_STATE_START_COUNTING &lt;&lt;4 ;
&#43;	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
&#43;
&#43;	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL) ,1);
&#43;}
&#43;
&#43;
&#43;static void gfx_v9_0_spm_stop(struct amdgpu_device *adev)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;	uint32_t data = 0;
&#43;
&#43;
&#43;	data = CP_PERFMON_STATE_STOP_COUNTING;
&#43;	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
&#43;	data |= (1&lt;&lt;10);
&#43;	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
&#43;
&#43;	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL), 0);
&#43;}
&#43;
&#43;static u32 gfx_v9_0_spm_get_rdptr(struct amdgpu_device *adev)
&#43;{
&#43;	return RREG32_SOC15(GC, 0, mmRLC_SPM_RING_RDPTR);;
&#43;}
&#43;
&#43;static void gfx_v9_0_spm_set_rdptr(struct amdgpu_device *adev,  u32 rptr)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;
&#43;	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), rptr);
&#43;}
&#43;
&#43;static u32 gfx_v9_0_spm_get_wrptr(struct amdgpu_device *adev)
&#43;{
&#43;	return -1;
&#43;}
&#43;
&#43;static void gfx_v9_0_set_spm_porfmon_ring_buf(struct amdgpu_device *adev, u64 gpu_addr, u32 size)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;
&#43;	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0,
&#43;                               mmRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu_addr));
&#43;
&#43;	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
&#43;                               SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_BASE_HI), upper_32_bits (gpu_addr));
&#43;
&#43;	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
&#43;                               SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_SIZE), size);
&#43;}
&#43;
&#43;static void gfx_v9_0_spm_set_reg(struct amdgpu_device *adev, u64 reg, u32 value)
&#43;{
&#43;	struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq.ring;
&#43;	uint32_t grbm_cntl;
&#43;	grbm_cntl = adev-&gt;reg_offset[GC_HWIP][0][1] &#43; reg;
&#43;
&#43;	gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, grbm_cntl, value);
&#43;}
&#43;
&#43;static const struct spm_funcs gfx_v9_0_spm_funcs = {
&#43;	.start = gfx_v9_0_spm_start,
&#43;	.stop = gfx_v9_0_spm_stop,
&#43;	.get_rdptr= gfx_v9_0_spm_get_rdptr,
&#43;	.set_rdptr= gfx_v9_0_spm_set_rdptr,
&#43;	.get_wrptr= gfx_v9_0_spm_get_wrptr,
&#43;	.set_spm_porfmon_ring_buf = gfx_v9_0_set_spm_porfmon_ring_buf,
&#43;	.set_reg = gfx_v9_0_spm_set_reg,
&#43;	.set_spm_config_size = 3,
&#43;	.get_spm_data_size = 128,
&#43;};
&#43;
&#43;static void gfx_v9_0_set_spm_funcs(struct amdgpu_device *adev)
&#43;{
&#43;	adev-&gt;gfx.spm.spmf = &amp;gfx_v9_0_spm_funcs;
&#43;}
&#43;
 static int gfx_v9_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -4626,6 &#43;4749,7 @@ static int gfx_v9_0_early_init(void *handle)
 	else
 		adev-&gt;gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
 	adev-&gt;gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
&#43;	gfx_v9_0_set_spm_funcs(adev);
 	gfx_v9_0_set_kiq_pm4_funcs(adev);
 	gfx_v9_0_set_ring_funcs(adev);
 	gfx_v9_0_set_irq_funcs(adev);
@@ -4677,6 &#43;4801,10 @@ static int gfx_v9_0_late_init(void *handle)
 	if (r)
 		return r;
 
&#43;	r = amdgpu_irq_get(adev, &amp;adev-&gt;gfx.spm_irq, 0);
&#43;	if (r)
&#43;		return r;
&#43;
 	r = amdgpu_irq_get(adev, &amp;adev-&gt;gfx.priv_inst_irq, 0);
 	if (r)
 		return r;
@@ -6657,6 &#43;6785,39 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
 }
 
&#43;static int gfx_v9_0_spm_set_interrupt_state(struct amdgpu_device *adev,
&#43;					     struct amdgpu_irq_src *src,
&#43;					     unsigned int type,
&#43;					     enum amdgpu_interrupt_state state)
&#43;{
&#43;	switch (state) {
&#43;	case AMDGPU_IRQ_STATE_DISABLE:
&#43;		WREG32(mmRLC_SPM_INT_CNTL, 0);
&#43;		break;
&#43;	case AMDGPU_IRQ_STATE_ENABLE:
&#43;		WREG32(mmRLC_SPM_INT_CNTL, 1);
&#43;		break;
&#43;	default:
&#43;		break;
&#43;	}
&#43;	return 0;
&#43;}
&#43;
&#43;static int gfx_v9_0_spm_irq(struct amdgpu_device *adev,
&#43;			     struct amdgpu_irq_src *source,
&#43;			     struct amdgpu_iv_entry *entry)
&#43;{
&#43;	u8 me_id, pipe_id, queue_id;
&#43;
&#43;	me_id = (entry-&gt;ring_id &amp; 0x0c) &gt;&gt; 2;
&#43;	pipe_id = (entry-&gt;ring_id &amp; 0x03) &gt;&gt; 0;
&#43;	queue_id = (entry-&gt;ring_id &amp; 0x70) &gt;&gt; 4;
&#43;	pr_debug(&quot;IH: RLC_RPM_INT, me:%d, pipe:%d, queue:%d\n&quot;,
&#43;			me_id, pipe_id, queue_id);
&#43;
&#43;	return 0; /* This also prevents sending it to KFD */
&#43;}
&#43;
 static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.name = &quot;gfx_v9_0&quot;,
 	.early_init = gfx_v9_0_early_init,
@@ -6825,12 &#43;6986,19 @@ static const struct amdgpu_irq_src_funcs gfx_v9_0_cp_ecc_error_irq_funcs = {
 	.process = amdgpu_gfx_cp_ecc_error_irq,
 };
 
&#43;static const struct amdgpu_irq_src_funcs gfx_v9_0_spm_irq_funcs = {
&#43;	.set = gfx_v9_0_spm_set_interrupt_state,
&#43;	.process = gfx_v9_0_spm_irq,
&#43;};
 
 static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev-&gt;gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
 	adev-&gt;gfx.eop_irq.funcs = &amp;gfx_v9_0_eop_irq_funcs;
 
&#43;	adev-&gt;gfx.spm_irq.num_types = 1;
&#43;	adev-&gt;gfx.spm_irq.funcs = &amp;gfx_v9_0_spm_irq_funcs;
&#43;
 	adev-&gt;gfx.priv_reg_irq.num_types = 1;
 	adev-&gt;gfx.priv_reg_irq.funcs = &amp;gfx_v9_0_priv_reg_irq_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index 6147462..43edba0 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -53,7 &#43;53,8 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_int_process_v9.o \
 		$(AMDKFD_PATH)/kfd_dbgdev.o \
 		$(AMDKFD_PATH)/kfd_dbgmgr.o \
-		$(AMDKFD_PATH)/kfd_crat.o
&#43;		$(AMDKFD_PATH)/kfd_crat.o	\
&#43;		$(AMDKFD_PATH)/kfd_spm.o
 
 ifneq ($(CONFIG_AMD_IOMMU_V2),)
 AMDKFD_FILES &#43;= $(AMDKFD_PATH)/kfd_iommu.o
diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
index 9f59ba9..cd394cd 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -24,6 &#43;24,7 @@
 #include &quot;kfd_events.h&quot;
 #include &quot;cik_int.h&quot;
 #include &quot;amdgpu_amdkfd.h&quot;
&#43;#include &quot;ivsrcid/ivsrcid_vislands30.h&quot;
 
 static bool cik_event_interrupt_isr(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry,
@@ -37,6 &#43;38,11 @@ static bool cik_event_interrupt_isr(struct kfd_dev *dev,
 	uint16_t pasid;
 	bool ret;
 
&#43;	vmid = f2g-&gt;read_vmid_from_vmfault_reg(dev-&gt;kgd);
&#43;
&#43;	if ((ihre-&gt;source_id == VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR) &amp;&amp; (vmid == 0))
&#43;		 return (kfd_spm_interrupt_isr (dev, ihre-&gt;source_id, ihre-&gt;source_id));
&#43;
 	/* This workaround is due to HW/FW limitation on Hawaii that
 	 * VMID and PASID are not written into ih_ring_entry
 	 */
@@ -49,7 &#43;55,6 @@ static bool cik_event_interrupt_isr(struct kfd_dev *dev,
 		*patched_flag = true;
 		*tmp_ihre = *ihre;
 
-		vmid = f2g-&gt;read_vmid_from_vmfault_reg(dev-&gt;kgd);
 		ret = f2g-&gt;get_atc_vmid_pasid_mapping_info(dev-&gt;kgd, vmid, &amp;pasid);
 
 		tmp_ihre-&gt;ring_id &amp;= 0x000000ff;
@@ -95,6 &#43;100,9 @@ static void cik_event_interrupt_wq(struct kfd_dev *dev,
 	if (pasid == 0)
 		return;
 
&#43;	if ((ihre-&gt;source_id == VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR) &amp;&amp; (vmid == 0))
&#43;		kfd_spm_interrupt_wq(dev, ihre-&gt;source_id);
&#43;
 	if (ihre-&gt;source_id == CIK_INTSRC_CP_END_OF_PIPE)
 		kfd_signal_event_interrupt(pasid, context_id, 28);
 	else if (ihre-&gt;source_id == CIK_INTSRC_SDMA_TRAP)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f8fa03a..bfc83beb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1732,6 &#43;1732,20 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 	return r;
 }
 
&#43;static int kfd_ioctl_rlc_spm(struct file *filep,
&#43;				   struct kfd_process *p, void *data)
&#43;{
&#43;	struct kfd_ioctl_spm_args *args = data;
&#43;	int err;
&#43;
&#43;	err = kfd_rlc_spm(p,
&#43;			(void __user *)args,
&#43;			 args-&gt;buf_size,
&#43;			 args-&gt;op);
&#43;
&#43;	return err;
&#43;}
&#43;
 #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
 			    .cmd_drv = 0, .name = #ioctl}
@@ -1827,6 &#43;1841,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_ALLOC_QUEUE_GWS,
 			kfd_ioctl_alloc_queue_gws, 0),
&#43;
&#43;	AMDKFD_IOCTL_DEF(AMDKFD_IOC_RLC_SPM,
&#43;			kfd_ioctl_rlc_spm, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index e05d75e..481f0ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -24,6 &#43;24,7 @@
 #include &quot;kfd_events.h&quot;
 #include &quot;soc15_int.h&quot;
 #include &quot;kfd_device_queue_manager.h&quot;
&#43;#include &quot;ivsrcid/gfx/irqsrcs_gfx_9_0.h&quot;
 
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 					const uint32_t *ih_ring_entry,
@@ -35,12 &#43;36,15 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 
 	/* Only handle interrupts from KFD VMIDs */
 	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
&#43;	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
&#43;	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
&#43;	if ((source_id == GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT) &amp;&amp; (vmid == 0))
&#43;		 return (kfd_spm_interrupt_isr (dev, source_id, client_id));
&#43;
 	if (vmid &lt; dev-&gt;vm_info.first_vmid_kfd ||
 	    vmid &gt; dev-&gt;vm_info.last_vmid_kfd)
 		return 0;
 
-	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
-	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
 	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
 
 	/* This is a known issue for gfx9. Under non HWS, pasid is not set
@@ -95,6 &#43;99,9 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
 	context_id = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
 
&#43;	if ((source_id == GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT) &amp;&amp; (vmid == 0))
&#43;		kfd_spm_interrupt_wq(dev, source_id);
&#43;
 	if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
 		kfd_signal_event_interrupt(pasid, context_id, 32);
 	else if (source_id == SOC15_INTSRC_SDMA_TRAP)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 43b888b..707d672 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -309,6 &#43;309,9 @@ struct kfd_dev {
 
 	/* Global GWS resource shared b/t processes*/
 	void *gws;
&#43;
&#43;	/*spm process id */
&#43;	unsigned int spm_pasid;
 };
 
 enum kfd_mempool {
@@ -740,6 &#43;743,13 @@ struct kfd_process {
 	struct kobject *kobj;
 	struct kobject *kobj_queues;
 	struct attribute attr_pasid;
&#43;	/* spm data */
&#43;	struct kfd_spm_cntr *spm_cntr;
&#43;	bool is_spm_acquired;
&#43;	/* Work items for tranfer data to user */
&#43;	struct delayed_work copy_to_user_work;
&#43;	/* spm-related data */
&#43;	struct mutex spm_mutex;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
@@ -1045,10 &#43;1055,20 @@ int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process *p);
 
 bool kfd_is_locked(void);
 
&#43;void kfd_spm_init_process(struct kfd_process *p);
&#43;int kfd_rlc_spm(struct kfd_process *p,  void __user *data,
&#43;		       uint32_t buf_size, __u32 op);
&#43;
 /* Compute profile */
 void kfd_inc_compute_active(struct kfd_dev *dev);
 void kfd_dec_compute_active(struct kfd_dev *dev);
 
&#43;/* spm interrupt */
&#43;bool kfd_spm_interrupt_isr(struct kfd_dev *dev,
&#43;					uint16_t source_id,	uint32_t client_id);
&#43;void kfd_spm_interrupt_wq(struct kfd_dev *dev,	uint16_t source_id);
&#43;
&#43;
 /* Cgroup Support */
 /* Check with device cgroup if @kfd device is accessible */
 static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index fe0cd49..338868d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -746,6 &#43;746,7 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	INIT_DELAYED_WORK(&amp;process-&gt;restore_work, restore_process_worker);
 	process-&gt;last_restore_timestamp = get_jiffies_64();
 	kfd_event_init_process(process);
&#43;	kfd_spm_init_process(process);
 	process-&gt;is_32bit_user_mode = in_compat_syscall();
 
 	process-&gt;pasid = kfd_pasid_alloc();
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_spm.c b/drivers/gpu/drm/amd/amdkfd/kfd_spm.c
new file mode 100644
index 0000000..773e2ee
--- /dev/null
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_spm.c
@@ -0,0 &#43;1,577 @@
&#43;/*
&#43; * Copyright 2020 Advanced Micro Devices, Inc.
&#43; *
&#43; * Permission is hereby granted, free of charge, to any person obtaining a
&#43; * copy of this software and associated documentation files (the &quot;Software&quot;),
&#43; * to deal in the Software without restriction, including without limitation
&#43; * the rights to use, copy, modify, merge, publish, distribute, sublicense,
&#43; * and/or sell copies of the Software, and to permit persons to whom the
&#43; * Software is furnished to do so, subject to the following conditions:
&#43; *
&#43; * The above copyright notice and this permission notice shall be included in
&#43; * all copies or substantial portions of the Software.
&#43; *
&#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
&#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
&#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
&#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
&#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
&#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
&#43; * OTHER DEALINGS IN THE SOFTWARE.
&#43; */
&#43;
&#43;#include &lt;linux/device.h&gt;
&#43;#include &quot;kfd_priv.h&quot;
&#43;#include &quot;amdgpu_amdkfd.h&quot;
&#43;#include &quot;soc15_int.h&quot;
&#43;#include &quot;ivsrcid/gfx/irqsrcs_gfx_9_0.h&quot;
&#43;#include &quot;ivsrcid/ivsrcid_vislands30.h&quot;
&#43;#include &lt;linux/delay.h&gt;
&#43;
&#43;#define SAMPLING_MAX 4
&#43;
&#43;struct user_buf {
&#43;        uint64_t __user *user_addr;
&#43;        u32 ubufsize;
&#43;
&#43;};
&#43;
&#43;struct kfd_spm_cntr {
&#43;        struct kgd_dev *kgd;
&#43;        u64    spm_gpu_addr;
&#43;        u32    spm_ring_buf_size;
&#43;        u32    spm_ring_buf_mark;
&#43;	    u32	   spm_ring_rptr;
&#43;        u32    spm_ring_wptr;
&#43;        u32    spm_ring_size_copied;
&#43;        void   *spm_obj;
&#43;        u32    *spm_cpu_addr;
&#43;        struct user_buf ubuf [SAMPLING_MAX];
&#43;        u32    buf_count;
&#43;        bool   is_uesr_buf_filled;
&#43;        bool   is_nowait;
&#43;        struct task_struct *thread;
&#43;        bool   thread_ready;
&#43;        char   *name;
&#43;        wait_queue_head_t spm_wq;
&#43;        int    wanted_cluster;
&#43;        bool   is_timeout;
&#43;};
&#43;
&#43;static int kfd_spm_data_cocy (struct kfd_spm_cntr * spm_cntr, u32 size_to_copy)
&#43;{
&#43;        u32 user_buf_space_left;
&#43;        int ret = 0;
&#43;        u32 bufSize;
&#43;        uint64_t __user * user_address;
&#43;        uint64_t * ring_buf;
&#43;        
&#43;        pr_debug(&quot;[%s]\n&quot;, __func__);
&#43;
&#43;        bufSize = spm_cntr-&gt;ubuf[0].ubufsize;
&#43;        user_address = (uint64_t*)((uint64_t)spm_cntr-&gt;ubuf[0].user_addr &#43; spm_cntr-&gt;spm_ring_size_copied);
&#43;        ring_buf =  (uint64_t*)((uint64_t)spm_cntr-&gt;spm_cpu_addr &#43; spm_cntr-&gt;spm_ring_rptr);
&#43;
&#43;        if (user_address == NULL)
&#43;	        return -EFAULT;
&#43;
&#43;        user_buf_space_left = bufSize - spm_cntr-&gt;spm_ring_size_copied;
&#43;
&#43;        if (size_to_copy &lt;= user_buf_space_left) {
&#43;		ret = copy_to_user(user_address, ring_buf, size_to_copy);
&#43;	     	if (ret) {
&#43;	        	pr_err(&quot;copy_to_user failed, ret = %x\n&quot;, ret);
&#43;			return -EFAULT;
&#43;              	}
&#43;		spm_cntr-&gt;spm_ring_size_copied &#43;= size_to_copy;
&#43;	} else {
&#43;		size_to_copy = spm_cntr-&gt;spm_ring_buf_size - spm_cntr-&gt;spm_ring_size_copied;
&#43;		ret = copy_to_user(user_address, ring_buf, user_buf_space_left);
&#43;		if (ret)
&#43;			return -EFAULT;
&#43;
&#43;		spm_cntr-&gt;spm_ring_size_copied = bufSize;
&#43;		spm_cntr-&gt;is_uesr_buf_filled = true;
&#43;	}
&#43;
&#43;	return ret;
&#43;}
&#43;
&#43;static int kfd_spm_reag_ring_buf_polling (struct kfd_spm_cntr * spm_cntr, long timeout)
&#43;{
&#43;	u32 size_to_copy;
&#43;	int ret = 0;
&#43;
&#43;	pr_info(&quot;[%s]\n&quot;, __func__);
&#43;
&#43;	while (spm_cntr-&gt;is_uesr_buf_filled != true){
&#43;		spm_cntr-&gt;spm_ring_rptr = amdgpu_amdkfd_rlc_spm_get_rdptr(spm_cntr-&gt;kgd) &amp; spm_cntr-&gt;spm_ring_buf_mark;
&#43;#if 1
&#43;		spm_cntr-&gt;spm_ring_wptr = amdgpu_amdkfd_rlc_spm_get_wrptr(spm_cntr-&gt;kgd) &amp; spm_cntr-&gt;spm_ring_buf_mark;
&#43;#else
&#43;		spm_cntr-&gt;spm_ring_wptr = spm_cntr-&gt;spm_cpu_addr[0] &amp; spm_cntr-&gt;spm_ring_buf_mark;
&#43;#endif
&#43;
&#43;		if ((spm_cntr-&gt;spm_ring_rptr &gt;= 0) &amp;&amp;  (spm_cntr-&gt;spm_ring_rptr  &lt; 0x20))
&#43;				spm_cntr-&gt;spm_ring_rptr = 0x20;
&#43;
&#43;		if (spm_cntr-&gt;is_uesr_buf_filled == true)
&#43;			goto exit;
&#43;
&#43;		if (spm_cntr-&gt;spm_ring_wptr &gt; spm_cntr-&gt;spm_ring_rptr) {
&#43;			size_to_copy = spm_cntr-&gt;spm_ring_wptr - spm_cntr-&gt;spm_ring_rptr;
&#43;			ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
&#43;		} else if (spm_cntr-&gt;spm_ring_wptr &lt; spm_cntr-&gt;spm_ring_rptr) {
&#43;			size_to_copy = spm_cntr-&gt;spm_ring_buf_size - spm_cntr-&gt;spm_ring_rptr;
&#43;			ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
&#43;
&#43;			/* correct counter start point */
&#43;			spm_cntr-&gt;spm_ring_rptr = 0x20;
&#43;			size_to_copy = spm_cntr-&gt;spm_ring_wptr;
&#43;			ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
&#43;		}
&#43;
&#43;		if (!ret) {
&#43;			if (spm_cntr-&gt;is_uesr_buf_filled == true) {
&#43;				/* stop */
&#43;				amdgpu_amdkfd_rlc_spm_cntl(spm_cntr-&gt;kgd, 0);
&#43;				amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr-&gt;kgd, 0);
&#43;#if 0
&#43;				amdgpu_amdkfd_rlc_spm_set_wrptr(spm_cntr-&gt;kgd, 0);
&#43;#else
&#43;				spm_cntr-&gt;spm_cpu_addr[0]= 0;
&#43;#endif
&#43;				return ret;
&#43;			} else
&#43;				amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr-&gt;kgd, spm_cntr-&gt;spm_ring_wptr);
&#43;
&#43;			if (spm_cntr-&gt;is_timeout == true) {
&#43;				/* stop */
&#43;				amdgpu_amdkfd_rlc_spm_cntl(spm_cntr-&gt;kgd, 0);
&#43;				amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr-&gt;kgd, 0);
&#43;#if 0
&#43;				amdgpu_amdkfd_rlc_spm_set_wrptr(spm_cntr-&gt;kgd, 0);
&#43;#else
&#43;				spm_cntr-&gt;spm_cpu_addr[0]= 0;
&#43;#endif
&#43;				break;
&#43;			}
&#43;		}
&#43;	}
&#43;exit:
&#43;	return ret;
&#43;}
&#43;
&#43;static int kfd_spm_reag_ring_buf (struct kfd_spm_cntr * spm_cntr)
&#43;{
&#43;	u32 size_to_copy;
&#43;	int ret = 0;
&#43;
&#43;	pr_debug(&quot;[%s]\n&quot;, __func__);
&#43;
&#43;	spm_cntr-&gt;spm_ring_rptr = amdgpu_amdkfd_rlc_spm_get_rdptr(spm_cntr-&gt;kgd) &amp; spm_cntr-&gt;spm_ring_buf_mark;
&#43;#if 1
&#43;	spm_cntr-&gt;spm_ring_wptr = amdgpu_amdkfd_rlc_spm_get_wrptr(spm_cntr-&gt;kgd) &amp; spm_cntr-&gt;spm_ring_buf_mark;
&#43;#else
&#43;	spm_cntr-&gt;spm_ring_wptr = spm_cntr-&gt;spm_cpu_addr[0] &amp; spm_cntr-&gt;spm_ring_buf_mark;
&#43;#endif
&#43;	if ((spm_cntr-&gt;spm_ring_rptr &gt;= 0) &amp;&amp;  (spm_cntr-&gt;spm_ring_rptr  &lt; 0x20)) {
&#43;		spm_cntr-&gt;spm_ring_rptr = 0x20;
&#43;	}
&#43;
&#43;	if (spm_cntr-&gt;is_uesr_buf_filled == true)
&#43;		goto exit;
&#43;
&#43;	if (spm_cntr-&gt;spm_ring_wptr &gt; spm_cntr-&gt;spm_ring_rptr) {
&#43;		size_to_copy = spm_cntr-&gt;spm_ring_wptr - spm_cntr-&gt;spm_ring_rptr;
&#43;		ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
&#43;
&#43;	} else if (spm_cntr-&gt;spm_ring_wptr &lt; spm_cntr-&gt;spm_ring_rptr) {
&#43;		size_to_copy = spm_cntr-&gt;spm_ring_buf_size - spm_cntr-&gt;spm_ring_rptr;
&#43;		ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
&#43;
&#43;		spm_cntr-&gt;spm_ring_rptr = 0x20;
&#43;		size_to_copy = spm_cntr-&gt;spm_ring_wptr;
&#43;		ret = kfd_spm_data_cocy(spm_cntr, size_to_copy);
&#43;	}
&#43;		if (!ret) {
&#43;			if (spm_cntr-&gt;is_uesr_buf_filled == true) {
&#43;				/* stop */
&#43;				amdgpu_amdkfd_rlc_spm_cntl(spm_cntr-&gt;kgd, 0);
&#43;				amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr-&gt;kgd, 0);
&#43;#if 0
&#43;				amdgpu_amdkfd_rlc_spm_set_wrptr(spm_cntr-&gt;kgd, 0);
&#43;#else
&#43;				spm_cntr-&gt;spm_cpu_addr[0]= 0;
&#43;#endif
&#43;				return ret;
&#43;			} else
&#43;				amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr-&gt;kgd, spm_cntr-&gt;spm_ring_wptr);
&#43;		}
&#43;exit:
&#43;	return ret;
&#43;}
&#43;
&#43;static int kfd_spm_sched_main(void *param)
&#43;{
&#43;	struct kfd_spm_cntr * spm_cntr = (struct kfd_spm_cntr *)param;
&#43;
&#43;	while (!kthread_should_stop()) {
&#43;		wait_event_interruptible(spm_cntr-&gt;spm_wq,
&#43;				spm_cntr-&gt;wanted_cluster != false ||
&#43;				kthread_should_stop());
&#43;
&#43;		kfd_spm_reag_ring_buf (spm_cntr);
&#43;
&#43;		spm_cntr-&gt;wanted_cluster = false;
&#43;	}
&#43;	return 0;
&#43;}
&#43;
&#43;static void transfer_data_process_worker(struct work_struct *work)
&#43;{
&#43;	struct kfd_process *p;
&#43;	struct delayed_work *dwork;
&#43;
&#43;	pr_debug(&quot;[%s]\n&quot;, __func__);
&#43;
&#43;	dwork = to_delayed_work(work);
&#43;
&#43;	/* Process termination destroys this worker thread. So during the
&#43;	 * lifetime of this thread, kfd_process p will be valid
&#43;	 */
&#43;	p = container_of(dwork, struct kfd_process, copy_to_user_work);
&#43;
&#43;	p-&gt;spm_cntr-&gt;is_timeout = true;
&#43;}
&#43;
&#43;
&#43;/**
&#43; * kfd_spm_init - init driver ring struct.
&#43; * Returns 0 on success, error on failure.
&#43; */
&#43;int kfd_spm_shed_init(struct kfd_process *p, struct kgd_dev *kgd)
&#43;{
&#43;	int ret = 0;
&#43;	init_waitqueue_head(&amp;p-&gt;spm_cntr-&gt;spm_wq);
&#43;	p-&gt;spm_cntr-&gt;wanted_cluster = false;
&#43;	p-&gt;spm_cntr-&gt;kgd = kgd;
&#43;	INIT_DELAYED_WORK(&amp;p-&gt;copy_to_user_work, transfer_data_process_worker);
&#43;
&#43;	/* Each scheduler will run on a seperate kernel thread */
&#43;	p-&gt;spm_cntr-&gt;thread = kthread_run(kfd_spm_sched_main, p-&gt;spm_cntr, p-&gt;spm_cntr-&gt;name);
&#43;	if (IS_ERR(p-&gt;spm_cntr-&gt;thread)) {
&#43;		ret = PTR_ERR(p-&gt;spm_cntr-&gt;thread);
&#43;		p-&gt;spm_cntr-&gt;thread = NULL;
&#43;		DRM_ERROR(&quot;Failed to create scheduler for %s.\n&quot;, p-&gt;spm_cntr-&gt;name);
&#43;		return ret;
&#43;	}
&#43;
&#43;	p-&gt;spm_cntr-&gt;thread_ready = true;
&#43;	return ret;
&#43;}
&#43;
&#43;/**
&#43; * amdgpu_ring_fini - tear down the driver ring struct.
&#43; *
&#43; * @adev: amdgpu_device pointer
&#43; * @ring: amdgpu_ring structure holding ring information
&#43; *
&#43; * Tear down the driver information for the selected ring (all asics).
&#43; */
&#43;void kfd_spm_shed_fini(struct kfd_process *p)
&#43;{
&#43;	if (p-&gt;spm_cntr-&gt;thread)
&#43;		kthread_stop(p-&gt;spm_cntr-&gt;thread);
&#43;
&#43;	cancel_delayed_work_sync(&amp;p-&gt;copy_to_user_work);
&#43;	p-&gt;spm_cntr-&gt;thread = NULL;
&#43;	p-&gt;spm_cntr-&gt;thread_ready = false;
&#43;}
&#43;
&#43;void kfd_spm_init_process(struct kfd_process *p)
&#43;{
&#43;	mutex_init(&amp;p-&gt;spm_mutex);
&#43;	p-&gt;spm_cntr = NULL;
&#43;	p-&gt;is_spm_acquired = false;
&#43;}
&#43;
&#43;static struct kfd_spm_cntr *allocate_spm_cntr_data(void)
&#43;{
&#43;	struct kfd_spm_cntr *cntr;
&#43;
&#43;	cntr = kzalloc(sizeof(*cntr), GFP_KERNEL);
&#43;	if (!cntr)
&#43;		return NULL;
&#43;
&#43;	return cntr;
&#43;}
&#43;
&#43;int kfd_acquire_spm(struct kfd_process *p, struct kgd_dev *kgd)
&#43;{
&#43;	int retval;
&#43;	int count;
&#43;
&#43;	pr_debug(&quot;[%s]\n&quot;, __func__);
&#43;
&#43;	if(p-&gt;is_spm_acquired == true)
&#43;		return EINVAL;
&#43;
&#43;	if (!p-&gt;spm_cntr) {
&#43;		p-&gt;spm_cntr = allocate_spm_cntr_data();
&#43;		if (!p-&gt;spm_cntr)
&#43;			return -ENOMEM;
&#43;		/* git spm ring buffer 128KB */
&#43;		p-&gt;spm_cntr-&gt;spm_ring_buf_size = order_base_2(128 * 1024/4);
&#43;		p-&gt;spm_cntr-&gt;spm_ring_buf_size = (1 &lt;&lt; p-&gt;spm_cntr-&gt;spm_ring_buf_size) * 4;
&#43;		p-&gt;spm_cntr-&gt;spm_ring_buf_mark = p-&gt;spm_cntr-&gt;spm_ring_buf_size -1;
&#43;		for (count = 0; count &lt; SAMPLING_MAX; &#43;&#43;count) {
&#43;			p-&gt;spm_cntr-&gt;ubuf[count].user_addr = NULL;
&#43;			p-&gt;spm_cntr-&gt;ubuf[count].ubufsize = 0;
&#43;		}
&#43;		p-&gt;spm_cntr-&gt;buf_count = 0;
&#43;		p-&gt;spm_cntr-&gt;is_uesr_buf_filled = false;
&#43;		p-&gt;spm_cntr-&gt;is_nowait = false;
&#43;		p-&gt;spm_cntr-&gt;thread_ready = false;
&#43;	}
&#43;
&#43;	retval = amdgpu_amdkfd_alloc_gtt_mem(kgd,
&#43;			p-&gt;spm_cntr-&gt;spm_ring_buf_size, &amp;p-&gt;spm_cntr-&gt;spm_obj,
&#43;			&amp;p-&gt;spm_cntr-&gt;spm_gpu_addr, (void *)&amp;p-&gt;spm_cntr-&gt;spm_cpu_addr,
&#43;			false);
&#43;
&#43;	if (retval)
&#43;		return EINVAL;
&#43;
&#43;	memset(p-&gt;spm_cntr-&gt;spm_cpu_addr, 0, p-&gt;spm_cntr-&gt;spm_ring_buf_size);
&#43;
&#43;	amdgpu_amdkfd_rlc_spm_acquire(kgd, p-&gt;spm_cntr-&gt;spm_gpu_addr, p-&gt;spm_cntr-&gt;spm_ring_buf_size);
&#43;
&#43;	if (p-&gt;spm_cntr-&gt;thread_ready == false) {
&#43;		p-&gt;spm_cntr-&gt;name = &quot;spm&quot;;
&#43;		retval = kfd_spm_shed_init(p, kgd);
&#43;		if (retval) {
&#43;			DRM_ERROR(&quot;Failed to create spm thread %s.\n&quot;,	p-&gt;spm_cntr-&gt;name);
&#43;			return retval;
&#43;		}
&#43;	}
&#43;	p-&gt;is_spm_acquired = true;
&#43;
&#43;	return 0;
&#43;}
&#43;
&#43;int kfd_release_spm(struct kfd_process *p, struct kgd_dev *kgd)
&#43;{
&#43;
&#43;	kfd_spm_shed_fini(p);
&#43;
&#43;	amdgpu_amdkfd_free_gtt_mem(kgd, p-&gt;spm_cntr-&gt;spm_obj);
&#43;
&#43;	kfree(p-&gt;spm_cntr);
&#43;	p-&gt;spm_cntr = NULL;
&#43;	p-&gt;is_spm_acquired = false;
&#43;
&#43;	return 0;
&#43;}
&#43;
&#43;int set_dest_buf_polling(struct kfd_spm_cntr *spm, struct kgd_dev *kgd, void __user *data)
&#43;{
&#43;	struct kfd_ioctl_spm_args __user *user_spm_data =
&#43;			(struct kfd_ioctl_spm_args __user *) data;
&#43;	u32 i;
&#43;	int ret = 0;
&#43;	unsigned long timeout;
&#43;
&#43;	pr_debug (&quot;[%s]\n&quot;, __func__);
&#43;
&#43;	timeout = msecs_to_jiffies(user_spm_data-&gt;timeout) &#43; 1;
&#43;
&#43;	/* if buf = NULL, stop spm */
&#43;	if (!user_spm_data-&gt;destptr) {
&#43;		amdgpu_amdkfd_rlc_spm_cntl(kgd, 0);
&#43;
&#43;		user_spm_data-&gt;bytes_copied = spm-&gt;spm_ring_size_copied;
&#43;		spm-&gt;spm_ring_size_copied = 0;
&#43;		user_spm_data-&gt;spmtptr = (uint64_t)spm-&gt;ubuf[0].user_addr;
&#43;
&#43;		for (i = 0; i &lt; spm-&gt;buf_count; &#43;&#43;i) {
&#43;			spm-&gt;ubuf [i] = spm-&gt;ubuf [i&#43;1];
&#43;		}
&#43;		spm-&gt;ubuf[spm-&gt;buf_count].user_addr = NULL;
&#43;		spm-&gt;ubuf[spm-&gt;buf_count].ubufsize = 0;
&#43;		spm-&gt;buf_count --;
&#43;		if (spm-&gt;buf_count &lt; 0)
&#43;			spm-&gt;buf_count = 0;
&#43;		return ret;
&#43;	}
&#43;
&#43;	if (!spm-&gt;buf_count) {
&#43;		/* First time save user spm buffer, then start spm sampling */
&#43;		spm-&gt;ubuf[0].user_addr = (uint64_t*)user_spm_data-&gt;destptr;
&#43;		spm-&gt;ubuf[0].ubufsize = user_spm_data-&gt;buf_size;
&#43;		user_spm_data-&gt;bytes_copied = 0;
&#43;		spm-&gt;spm_ring_size_copied = 0;
&#43;		spm-&gt;buf_count &#43;&#43;;
&#43;		spm-&gt;is_uesr_buf_filled = false;
&#43;		amdgpu_amdkfd_rlc_spm_cntl(kgd, 1);
&#43;
&#43;		ret = kfd_spm_reag_ring_buf_polling (spm, timeout);
&#43;		user_spm_data-&gt;bytes_copied = spm-&gt;spm_ring_size_copied;
&#43;		user_spm_data-&gt;spmtptr = (uint64_t)spm-&gt;ubuf[0].user_addr;
&#43;		spm-&gt;buf_count --;
&#43;	} else {
&#43;		spm-&gt;spm_ring_size_copied = 0;
&#43;		spm-&gt;is_uesr_buf_filled = false;
&#43;		amdgpu_amdkfd_rlc_spm_cntl(kgd, 1);
&#43;		ret = kfd_spm_reag_ring_buf_polling (spm, timeout);
&#43;
&#43;		user_spm_data-&gt;bytes_copied = spm-&gt;spm_ring_size_copied;
&#43;		user_spm_data-&gt;spmtptr = (uint64_t)spm-&gt;ubuf[0].user_addr;
&#43;		spm-&gt;buf_count --;
&#43;
&#43;		for (i = 0; i &lt; spm-&gt;buf_count; &#43;&#43;i)
&#43;			/* Repeated dest buf */
&#43;			if (spm-&gt;ubuf[i].user_addr == (uint64_t*)user_spm_data-&gt;destptr)
&#43;				break;
&#43;		if (i == spm-&gt;buf_count) {
&#43;			spm-&gt;ubuf[i].user_addr = (uint64_t*)user_spm_data-&gt;destptr;
&#43;			spm-&gt;ubuf[i].ubufsize = user_spm_data-&gt;buf_size;
&#43;			spm-&gt;buf_count &#43;&#43;;
&#43;		}
&#43;
&#43;		for (i = 0; i &lt; spm-&gt;buf_count; &#43;&#43;i)
&#43;			spm-&gt;ubuf[i] = spm-&gt;ubuf[i &#43; 1];
&#43;		spm-&gt;ubuf[spm-&gt;buf_count].user_addr  = NULL;
&#43;	}
&#43;
&#43;	user_spm_data-&gt;bytes_copied = spm-&gt;spm_ring_size_copied;
&#43;	return ret;
&#43;
&#43;}
&#43;
&#43;int kfd_set_dest_buffer(struct kfd_process *p, struct kgd_dev *kgd, void __user *data)
&#43;{
&#43;	struct kfd_ioctl_spm_args __user *user_spm_data =
&#43;							(struct kfd_ioctl_spm_args __user *) data;
&#43;	struct kfd_spm_cntr *spm = p-&gt;spm_cntr;
&#43;	unsigned long timeout;
&#43;
&#43;	pr_debug(&quot;[%s]\n&quot;, __func__);
&#43;
&#43;	if(p-&gt;is_spm_acquired == false)
&#43;		return -EINVAL;
&#43;
&#43;	timeout = msecs_to_jiffies(user_spm_data-&gt;timeout) &#43; 1;
&#43;	spm-&gt;is_timeout = false;
&#43;	schedule_delayed_work(&amp;p-&gt;copy_to_user_work, timeout);
&#43;	return set_dest_buf_polling(spm, kgd, data);
&#43;}
&#43;
&#43;int kfd_config_spm(struct kfd_process *p, struct kgd_dev *kgd,struct kfd_ioctl_spm_args *data)
&#43;{
&#43;	struct kfd_ioctl_spm_args __user *user_spm_data =
&#43;			(struct kfd_ioctl_spm_args __user *) data;
&#43;	struct kfd_spm_set_reg *spm_reg;
&#43;
&#43;	pr_debug(&quot;[%s]\n&quot;, __func__);
&#43;
&#43;	spm_reg = kvmalloc_array(1, sizeof (struct kfd_spm_set_reg), GFP_KERNEL);
&#43;
&#43;	if (copy_from_user(spm_reg, (void __user *)user_spm_data-&gt;destptr, sizeof (struct kfd_spm_set_reg))) {
&#43;		pr_err(&quot;copy_from_user Fail\n&quot;);
&#43;		goto exit;
&#43;	}
&#43;	amdgpu_amdkfd_rlc_spm_set_reg(kgd, spm_reg-&gt;reg, spm_reg-&gt;value);
&#43;exit:
&#43;	kfree(spm_reg);
&#43;	return 0;
&#43;}
&#43;
&#43;int kfd_rlc_spm(struct kfd_process *p,  void __user *data,
&#43;		       uint32_t buf_size, __u32 operation)
&#43;{
&#43;	struct kfd_ioctl_spm_args *args = data;
&#43;	struct kfd_dev *dev;
&#43;	int r;
&#43;
&#43;	dev = kfd_device_by_id(args-&gt;gpu_id);
&#43;	if (!dev)
&#43;		return -EINVAL;
&#43;
&#43;
&#43;	switch (operation) {
&#43;	case KFD_IOCTL_SPM_OP_ACQUIRE:
&#43;		dev-&gt;spm_pasid = p-&gt;pasid;
&#43;		r = kfd_acquire_spm(p, dev-&gt;kgd);
&#43;		break;
&#43;
&#43;	case KFD_IOCTL_SPM_OP_RELEASE:
&#43;		r = kfd_release_spm(p, dev-&gt;kgd);
&#43;				break;
&#43;
&#43;	case KFD_IOCTL_SPM_OP_SET_DEST_BUF:
&#43;		r = kfd_set_dest_buffer(p, dev-&gt;kgd, data);
&#43;		break;
&#43;
&#43;	case KFD_IOCTL_SPM_OP_CONFIG:
&#43;		r = kfd_config_spm(p, dev-&gt;kgd, args);
&#43;				break;
&#43;
&#43;	default:
&#43;		r = -EINVAL;
&#43;		break;
&#43;	}
&#43;	return r;
&#43;}
&#43;
&#43;void kfd_spm_interrupt(unsigned int pasid)
&#43;{
&#43;
&#43;	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
&#43;
&#43;	if (!p) {
&#43;		pr_info(&quot;kfd_spm_interrupt p = %p \n&quot;, p);
&#43;		return; /* Presumably process exited. */
&#43;	}
&#43;
&#43;	mutex_lock(&amp;p-&gt;spm_mutex);
&#43;
&#43;	p-&gt;spm_cntr-&gt;wanted_cluster = true;
&#43;	wake_up_interruptible(&amp;p-&gt;spm_cntr-&gt;spm_wq);
&#43;
&#43;	mutex_unlock(&amp;p-&gt;spm_mutex);
&#43;
&#43;	kfd_unref_process(p);
&#43;}
&#43;
&#43;bool kfd_spm_interrupt_isr(struct kfd_dev *dev,
&#43;					uint16_t source_id,	uint32_t client_id)
&#43;{
&#43;	pr_debug(&quot;[%s]\n&quot;, __func__);
&#43;
&#43;	if (source_id != GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT)
&#43;		return 0;
&#43;
&#43;	/* Interrupt types we care about: various signals and faults.
&#43;	 * They will be forwarded to a work queue (see below).
&#43;	 */
&#43;
&#43;	return source_id == GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT ||
&#43;		source_id == VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR ||
&#43;		client_id == AMDGPU_IRQ_CLIENTID_LEGACY ||
&#43;		client_id == SOC15_IH_CLIENTID_RLC;
&#43;}
&#43;
&#43;void kfd_spm_interrupt_wq(struct kfd_dev *dev,	uint16_t source_id)
&#43;{
&#43;	uint16_t pasid;
&#43;
&#43;	pr_debug(&quot;[%s]\n&quot;, __func__);
&#43;
&#43;	pasid = dev-&gt;spm_pasid;
&#43;#if 0
&#43;	if ((source_id == GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT) ||
&#43;				(source_id == VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR))
&#43;		kfd_spm_interrupt(pasid);
&#43;#endif
&#43;}
diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
index 0bc0b25..fb4ad60 100644
--- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
@@ -30,6 &#43;30,7 @@
 #define SOC15_INTSRC_SQ_INTERRUPT_MSG	239
 #define SOC15_INTSRC_VMC_FAULT		0
 #define SOC15_INTSRC_SDMA_TRAP		224
&#43;#define AMDGPU_IRQ_CLIENTID_LEGACY	0
 
 
 #define SOC15_CLIENT_ID_FROM_IH_ENTRY(entry) (le32_to_cpu(entry[0]) &amp; 0xff)
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 4f66764..f7cb7d4 100644
--- a/include/uapi/linux/kfd_ioctl.h
&#43;&#43;&#43; b/include/uapi/linux/kfd_ioctl.h
@@ -442,6 &#43;442,56 @@ struct kfd_ioctl_import_dmabuf_args {
 	__u32 dmabuf_fd;	/* to KFD */
 };
 
&#43;/**
&#43; * kfd_ioctl_spm_op - SPM ioctl operations
&#43; *
&#43; * @KFD_IOCTL_SPM_OP_ACQUIRE: acquire exclusive access to SPM
&#43; * @KFD_IOCTL_SPM_OP_RELEASE: release exclusive access to SPM
&#43; * @KFD_IOCTL_SPM_OP_SET_DEST_BUF: set or unset destination buffer for SPM streaming
&#43; */
&#43;enum kfd_ioctl_spm_op {
&#43;	KFD_IOCTL_SPM_OP_ACQUIRE,
&#43;	KFD_IOCTL_SPM_OP_RELEASE,
&#43;	KFD_IOCTL_SPM_OP_SET_DEST_BUF,
&#43;	KFD_IOCTL_SPM_OP_CONFIG
&#43;};
&#43;
&#43;/* Don't wait for previous buffer to fill up */
&#43;#define KFD_IOCTL_SPM_FLAG_POLLING 1
&#43;
&#43;/**
&#43; * kfd_ioctl_spm_args - Arguments for SPM ioctl
&#43; *
&#43; * @op:     specifies the operation to perform
&#43; * @destptr:used for the address of the destination buffer in @KFD_IOCTL_SPM_SET_DEST_BUFFER
&#43; * @buf_size:size  of the destination buffer in @KFD_IOCTL_SPM_SET_DEST_BUFFER
&#43; * @timeout: timeout to wait buffer get filled
&#43; * @gpu_id: gpi ID
&#43; * @bytes_copied: byte copied from streaming performance ring buffer
&#43; *
&#43; * If @ptr is NULL, the destination buffer address is unset and copying of counters
&#43; * is stopped.
&#43; *
&#43; * Returns negative error code on failure. On success, @KFD_IOCTL_SPM_OP_ACQUIRE and
&#43; * @KFD_IOCTL_SPM_OP_RELEASE return 0, @KFD_IOCTL_SPM_OP_SET_DEST_BUF returns the fill
&#43; * level of the previous buffer.
&#43; */
&#43;struct kfd_ioctl_spm_args {
&#43;	__u64 destptr;
&#43;	__u64 spmtptr;
&#43;	__u32 buf_size;
&#43;	__u32 op;
&#43;	__u32 timeout;
&#43;	__u32 gpu_id;	/* to KFD */
&#43;	/* from KFD: Total amount of bytes copied */
&#43;	__u64 bytes_copied;
&#43;};
&#43;
&#43;struct kfd_spm_set_reg {
&#43;	__u64 reg;		/* to KFD */
&#43;	__u32 value;
&#43;};
&#43;
 /* Register offset inside the remapped mmio page
  */
 enum kfd_mmio_remap {
@@ -546,7 &#43;596,10 @@ enum kfd_mmio_remap {
 #define AMDKFD_IOC_ALLOC_QUEUE_GWS		\
 		AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)
 
&#43;#define AMDKFD_IOC_RLC_SPM		\
&#43;		AMDKFD_IOWR(0x1F, struct kfd_ioctl_spm_args)
&#43;
 #define AMDKFD_COMMAND_START		0x01
-#define AMDKFD_COMMAND_END		0x1F
&#43;#define AMDKFD_COMMAND_END		0x20
 
 #endif
</pre>
    </blockquote>
  </body>
</html>

--------------36902861664473E3518DA748--

--===============0329499670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0329499670==--
