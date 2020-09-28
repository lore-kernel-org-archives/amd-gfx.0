Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F865C2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E61F52080A
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y4nPifPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61F52080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 603AB89F27;
	Mon, 28 Sep 2020 20:49:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0578789F27
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 20:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dENtpJcHRuPHSRc2oOGlbxQ2CMcSlnSeCssiJGLeuU1q62/e0qdcEPJnDaVvbGtLSHLnaDxhTs2TGSV+Mzp0+0NnsH0e1ywFpp+fqjqO2KXmxnQUqmnic2e/PdC4tXgVStYmTsNdKotttVzmEyjctkdS55l+6oSRPJFbFK9V8OCuO6qGuEse80jUYwy3dtn09GBD+L6FbDAKr66cXQ9nS/RidWkXc1lVwEo2KTLz24v9/tJW0q5dt7NcS+CpK5aJ7xcYxJ+YWS4eEV9vWAuYiNauGdtrtIEKMcMcsVT+goD3aRTvgqALZHfgGcq9nECn5xoUCeo7ehVyLgVRSWTwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EEGkfOgR/rFqMWhptWF00e0ubsOBsrw3TrBLBJBGc0=;
 b=htaO1HzlbsdS4X/Ut/e7Ow2hy3rM+9tkn+ncs7CXuqmPnzrO5Obdmd5IpYjrKjrwzYdmosLqBJDg3pbwmgaTqerGaZkfIQ4Votj19FSDhCOFgm0cxwjJIeUKiYcqc0nnAN0QcJd9/0o2Y7eIFN92VtR6XSP5EdEhM69b3ohLEycnkXh3+AqKShsCDD1+o9syO38nXMnk9CKLKlpQZ3EPYgPm8Vj9JchO7U+xjHc44Uqh/siB1wGNMZJbPeE41a1r6mtngy0jJm4+/BCYRk8qSbuGP+LFvGUwc3QgrR6pqULQpQ7bxfFzSj93AyBYL6BD27rggvL5/lNUtBrIqotQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EEGkfOgR/rFqMWhptWF00e0ubsOBsrw3TrBLBJBGc0=;
 b=Y4nPifPV0Em0OfbB7Pj6yT1aX5zpNJuG+petATOgX9pCsDTYa6fSyquUD1w5p4BPsCNiOUCijEGMTh0gOeTtxfSom24PViikNWYCP8cFxRjhEqx+dp/8L78FsGhkjT4BBhBdX4xmJjDRAeD3rajIaqstN4v0NHCYKuQ3FqEvO/s=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Mon, 28 Sep
 2020 20:48:58 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 20:48:57 +0000
Subject: Re: [PATCH 05/45] drm/amdgpu: add vangogh_reg_base_init function for
 van gogh
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
 <20200925201029.1738724-5-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <56f74006-5a7a-c4a6-26e1-1a51cc0be1e9@amd.com>
Date: Mon, 28 Sep 2020 16:48:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200925201029.1738724-5-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::17) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0078.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.23 via Frontend Transport; Mon, 28 Sep 2020 20:48:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bbd5cff9-213d-4c8c-f674-08d863efebaf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3081:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3081FCD4C170EA67E33E6E5799350@DM6PR12MB3081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R63MgyRch5QqPBFJ1b6Efs9Ot9st27ygV9ZJMk7jlMOM/lC7/S7fLqEUZ8kf0xMG3kQBr40wfGCOSqA1efWajkl6m6/KVUdwquB/0r2f3XPWlIfgDKAysOEDj7K84GtXYNPI7fIal2uUcKS+Syie3I9IH8X/fF3LSFfHjNXDR55NgOkraB85WNmWDgV6GHlF8xywYI1DcpBrBImULkxQCKv71NMM6ApJjUUI80fBeDmmg3UHKR6wzPWLi8A8UQsTZtw1RPDRMVPNYyRUngUoA/lA8ZrKp9tIhXaUlE+GwmscusDQRHm287eTXs77Q+pVitXSb9wFA0Yd0tVTpYnoVZtzDBlLS7kIJe1OSKuEHOC9aoBAJh+jxgnBTf0elGSqv4+6B4VoffHY6vAI1c0x6Epd6GIIbxa+zpsSNKrsFb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(52116002)(53546011)(2906002)(6506007)(16526019)(956004)(2616005)(186003)(66556008)(8936002)(26005)(31686004)(86362001)(83380400001)(30864003)(54906003)(44832011)(66946007)(36756003)(8676002)(316002)(4326008)(5660300002)(6486002)(66476007)(6512007)(31696002)(478600001)(43740500002)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: rEQL829MmOGf9/bXpmAqFCtFPdZHyMnR8zLPiU7+FePSebhnGKeVruyC4laA9pd+dibR3cVT+wOaF8mBdAl+5C5ILPGZbsG299jLHL/2Mzs++Oe7J6iCW9k1ITDVqsxg1/RYVuumYx5nPE49v5rOyPAIX3Gi6YeTH9au8VT814TExNEJeWVYgZKMKDmkDpDB67SEnRDlIBzZNkvZUBMylflsJfJ4FJe99skIqmOTGp9OGXKP5yVJYONaBd6ZMNt88GCq9NYKgMfZLIqAxNLD0QIf1B86Q4G4JlI6pRGDMZHJhjy1zEYU2sNubV5zArQqSoCuaUrxdhse9sX/n7KAiRexW2JKzP/Sz5J52F2pTM5VZhju4Crpf8WggHWY5gIPSoOoKFqQmDwhgBCKDsu2iadoJx5G9kZ0XhL41jQWYpOh/6KlO3C+fnFGilHzMHz5b96w1Zd4X8kfgR9p+NnX/bQRUEMlpu780xnd1PfaUaZAWfA3HhgAlaSJjVBSJyQxLWeXgrW4lKfihrPBZAtUCBw7zpuYssXy+v9fiZPQxtaaOGNGuvwV+YG7Lygnk+uRVjWJswQr9vbV1cUX2qJTl3r0zoPPXSKku+S7r27XpsunFd948bNFZfVxqzykyeGrqHpX2XjyQRgGrYUv9cOSVg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd5cff9-213d-4c8c-f674-08d863efebaf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 20:48:57.8574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OQD9N0SAHh3I4l5tus3QewTMmH5ENlY8PaQG7UUED8F5ZADv996eRXbHBK7r/Pl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-25 4:09 p.m., Alex Deucher wrote:
> From: Huang Rui <ray.huang@amd.com>
> 
> This patch adds vangogh_reg_base_init function to init the register base for
> van gogh.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |    2 +-
>  drivers/gpu/drm/amd/amdgpu/nv.h               |    1 +
>  drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c |   51 +
>  .../gpu/drm/amd/include/vangogh_ip_offset.h   | 1516 +++++++++++++++++
>  4 files changed, 1569 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c
>  create mode 100644 drivers/gpu/drm/amd/include/vangogh_ip_offset.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 39976c7b100c..7866e4666a43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -69,7 +69,7 @@ amdgpu-$(CONFIG_DRM_AMDGPU_SI)+= si.o gmc_v6_0.o gfx_v6_0.o si_ih.o si_dma.o dce
>  amdgpu-y += \
>  	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
>  	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o \
> -	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o
> +	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o vangogh_reg_init.o
>  
>  # add DF block
>  amdgpu-y += \
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
> index aeef50a6a54b..8a3bf476b18f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.h
> @@ -34,4 +34,5 @@ int navi10_reg_base_init(struct amdgpu_device *adev);
>  int navi14_reg_base_init(struct amdgpu_device *adev);
>  int navi12_reg_base_init(struct amdgpu_device *adev);
>  int sienna_cichlid_reg_base_init(struct amdgpu_device *adev);
> +int vangogh_reg_base_init(struct amdgpu_device *adev);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c b/drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c
> new file mode 100644
> index 000000000000..4c6c3b415e7b
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c
> @@ -0,0 +1,51 @@
> +/*
> + * Copyright 2019 Advanced Micro Devices, Inc.
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
> +#include "amdgpu.h"
> +#include "nv.h"
> +
> +#include "soc15_common.h"
> +#include "soc15_hw_ip.h"
> +#include "vangogh_ip_offset.h"
> +
> +int vangogh_reg_base_init(struct amdgpu_device *adev)
> +{
> +	/* HW has more IP blocks,  only initialized the blocke needed by driver */
> +	uint32_t i;
> +	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
> +		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
> +		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
> +		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
> +		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
> +		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIO_BASE.instance[i]));
> +		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
> +		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
> +		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(VCN_BASE.instance[i]));
> +		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
> +		adev->reg_offset[DCE_HWIP][i] = (uint32_t *)(&(DCN_BASE.instance[i]));
> +		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
> +		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
> +		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
> +		adev->reg_offset[THM_HWIP][i] = (uint32_t *)(&(THM_BASE.instance[i]));

I'd align the equality sign for presentation.

> +	}
> +	return 0;
> +}

This function should be "void", else the compiler will throw a warning
when you compile nv.c.

> diff --git a/drivers/gpu/drm/amd/include/vangogh_ip_offset.h b/drivers/gpu/drm/amd/include/vangogh_ip_offset.h
> new file mode 100644
> index 000000000000..2875574b060e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/vangogh_ip_offset.h
> @@ -0,0 +1,1516 @@
> +/*
> + * Copyright 2019 Advanced Micro Devices, Inc.
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
> +#ifndef __VANGOGH_IP_OFFSET_H__
> +#define __VANGOGH_IP_OFFSET_H__
> +
> +#define MAX_INSTANCE                                        8
> +#define MAX_SEGMENT                                         6

No. No "max". Use "num" instead, as:

#define NUM_INSTANCE   8
#define NUM_SEGMENT    6

To mean, the _number_ of instances and the _number_ of
segments. (Their count is a number.)

A "maximum" (similarly "minimum") value is an _attainable_ value,
i.e. something you can get, use, etc. But array indices are 0 to arraysize-1,
and thus max instance can never be attained.

It is the count, the number of instances (segments, wlg),
not the maximum instance. The maximum instance is 7,
the minimum instance is 0. Similarly for segments.

> +
> +
> +struct IP_BASE_INSTANCE
> +{
> +    unsigned int segment[MAX_SEGMENT];
> +};

So, here if you used NUM_SEGMENT, it is very clear
what is intended: an array of number of segments,
i.e. their count, whose array index would be 0 to 
NUM_SEGMENTS-1.

Similarly for "instance" below.

Regards,
Luben

> +
> +struct IP_BASE
> +{
> +    struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
> +};
> +
> +
> +static const struct IP_BASE ACP_BASE = { { { { 0x02403800, 0x00480000, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE ATHUB_BASE = { { { { 0x00000C00, 0x00013300, 0x02408C00, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0, 0 } },
> +                                        { { 0x00016E00, 0x02401C00, 0, 0, 0, 0 } },
> +                                        { { 0x00017000, 0x02402000, 0, 0, 0, 0 } },
> +                                        { { 0x00017200, 0x02402400, 0, 0, 0, 0 } },
> +                                        { { 0x0001B000, 0x0242D800, 0, 0, 0, 0 } },
> +                                        { { 0x0001B200, 0x0242DC00, 0, 0, 0, 0 } },
> +                                        { { 0x0001B400, 0x0242E000, 0, 0, 0, 0 } },
> +                                        { { 0x00017E00, 0x0240BC00, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE DF_BASE = { { { { 0x00007000, 0x0240B800, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE DPCS_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE FCH_BASE = { { { { 0x0240C000, 0x00B40000, 0x11000000, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE FUSE_BASE = { { { { 0x00017400, 0x02401400, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE GC_BASE = { { { { 0x00001260, 0x0000A000, 0x02402C00, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE HDP_BASE = { { { { 0x00000F20, 0x0240A400, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE ISP_BASE = { { { { 0x00018000, 0x0240B000, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE MMHUB_BASE = { { { { 0x00013200, 0x0001A000, 0x02408800, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE MP0_BASE = { { { { 0x00016000, 0x0243FC00, 0x00DC0000, 0x00E00000, 0x00E40000, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE MP1_BASE = { { { { 0x00016000, 0x0243FC00, 0x00DC0000, 0x00E00000, 0x00E40000, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE MP2_BASE = { { { { 0x00016400, 0x02400800, 0x00F40000, 0x00F80000, 0x00FC0000, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE OSSSYS_BASE = { { { { 0x000010A0, 0x0240A000, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE PCIE0_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE SMUIO_BASE = { { { { 0x00016800, 0x00016A00, 0x02401000, 0x00440000, 0, 0 } },
> +                                        { { 0x0001BC00, 0x0242D400, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE THM_BASE = { { { { 0x00016600, 0x02400C00, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE UMC_BASE = { { { { 0x00014000, 0x02425800, 0, 0, 0, 0 } },
> +                                        { { 0x00054000, 0x02425C00, 0, 0, 0, 0 } },
> +                                        { { 0x00094000, 0x02426000, 0, 0, 0, 0 } },
> +                                        { { 0x000D4000, 0x02426400, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE USB_BASE = { { { { 0x0242A800, 0x05B00000, 0, 0, 0, 0 } },
> +                                        { { 0x0242AC00, 0x05B80000, 0, 0, 0, 0 } },
> +                                        { { 0x0242B000, 0x05C00000, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +static const struct IP_BASE VCN_BASE = { { { { 0x00007800, 0x00007E00, 0x02403000, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } },
> +                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +
> +
> +#define ACP_BASE__INST0_SEG0                       0x02403800
> +#define ACP_BASE__INST0_SEG1                       0x00480000
> +#define ACP_BASE__INST0_SEG2                       0
> +#define ACP_BASE__INST0_SEG3                       0
> +#define ACP_BASE__INST0_SEG4                       0
> +#define ACP_BASE__INST0_SEG5                       0
> +
> +#define ACP_BASE__INST1_SEG0                       0
> +#define ACP_BASE__INST1_SEG1                       0
> +#define ACP_BASE__INST1_SEG2                       0
> +#define ACP_BASE__INST1_SEG3                       0
> +#define ACP_BASE__INST1_SEG4                       0
> +#define ACP_BASE__INST1_SEG5                       0
> +
> +#define ACP_BASE__INST2_SEG0                       0
> +#define ACP_BASE__INST2_SEG1                       0
> +#define ACP_BASE__INST2_SEG2                       0
> +#define ACP_BASE__INST2_SEG3                       0
> +#define ACP_BASE__INST2_SEG4                       0
> +#define ACP_BASE__INST2_SEG5                       0
> +
> +#define ACP_BASE__INST3_SEG0                       0
> +#define ACP_BASE__INST3_SEG1                       0
> +#define ACP_BASE__INST3_SEG2                       0
> +#define ACP_BASE__INST3_SEG3                       0
> +#define ACP_BASE__INST3_SEG4                       0
> +#define ACP_BASE__INST3_SEG5                       0
> +
> +#define ACP_BASE__INST4_SEG0                       0
> +#define ACP_BASE__INST4_SEG1                       0
> +#define ACP_BASE__INST4_SEG2                       0
> +#define ACP_BASE__INST4_SEG3                       0
> +#define ACP_BASE__INST4_SEG4                       0
> +#define ACP_BASE__INST4_SEG5                       0
> +
> +#define ACP_BASE__INST5_SEG0                       0
> +#define ACP_BASE__INST5_SEG1                       0
> +#define ACP_BASE__INST5_SEG2                       0
> +#define ACP_BASE__INST5_SEG3                       0
> +#define ACP_BASE__INST5_SEG4                       0
> +#define ACP_BASE__INST5_SEG5                       0
> +
> +#define ACP_BASE__INST6_SEG0                       0
> +#define ACP_BASE__INST6_SEG1                       0
> +#define ACP_BASE__INST6_SEG2                       0
> +#define ACP_BASE__INST6_SEG3                       0
> +#define ACP_BASE__INST6_SEG4                       0
> +#define ACP_BASE__INST6_SEG5                       0
> +
> +#define ACP_BASE__INST7_SEG0                       0
> +#define ACP_BASE__INST7_SEG1                       0
> +#define ACP_BASE__INST7_SEG2                       0
> +#define ACP_BASE__INST7_SEG3                       0
> +#define ACP_BASE__INST7_SEG4                       0
> +#define ACP_BASE__INST7_SEG5                       0
> +
> +#define ATHUB_BASE__INST0_SEG0                     0x00000C00
> +#define ATHUB_BASE__INST0_SEG1                     0x00013300
> +#define ATHUB_BASE__INST0_SEG2                     0x02408C00
> +#define ATHUB_BASE__INST0_SEG3                     0
> +#define ATHUB_BASE__INST0_SEG4                     0
> +#define ATHUB_BASE__INST0_SEG5                     0
> +
> +#define ATHUB_BASE__INST1_SEG0                     0
> +#define ATHUB_BASE__INST1_SEG1                     0
> +#define ATHUB_BASE__INST1_SEG2                     0
> +#define ATHUB_BASE__INST1_SEG3                     0
> +#define ATHUB_BASE__INST1_SEG4                     0
> +#define ATHUB_BASE__INST1_SEG5                     0
> +
> +#define ATHUB_BASE__INST2_SEG0                     0
> +#define ATHUB_BASE__INST2_SEG1                     0
> +#define ATHUB_BASE__INST2_SEG2                     0
> +#define ATHUB_BASE__INST2_SEG3                     0
> +#define ATHUB_BASE__INST2_SEG4                     0
> +#define ATHUB_BASE__INST2_SEG5                     0
> +
> +#define ATHUB_BASE__INST3_SEG0                     0
> +#define ATHUB_BASE__INST3_SEG1                     0
> +#define ATHUB_BASE__INST3_SEG2                     0
> +#define ATHUB_BASE__INST3_SEG3                     0
> +#define ATHUB_BASE__INST3_SEG4                     0
> +#define ATHUB_BASE__INST3_SEG5                     0
> +
> +#define ATHUB_BASE__INST4_SEG0                     0
> +#define ATHUB_BASE__INST4_SEG1                     0
> +#define ATHUB_BASE__INST4_SEG2                     0
> +#define ATHUB_BASE__INST4_SEG3                     0
> +#define ATHUB_BASE__INST4_SEG4                     0
> +#define ATHUB_BASE__INST4_SEG5                     0
> +
> +#define ATHUB_BASE__INST5_SEG0                     0
> +#define ATHUB_BASE__INST5_SEG1                     0
> +#define ATHUB_BASE__INST5_SEG2                     0
> +#define ATHUB_BASE__INST5_SEG3                     0
> +#define ATHUB_BASE__INST5_SEG4                     0
> +#define ATHUB_BASE__INST5_SEG5                     0
> +
> +#define ATHUB_BASE__INST6_SEG0                     0
> +#define ATHUB_BASE__INST6_SEG1                     0
> +#define ATHUB_BASE__INST6_SEG2                     0
> +#define ATHUB_BASE__INST6_SEG3                     0
> +#define ATHUB_BASE__INST6_SEG4                     0
> +#define ATHUB_BASE__INST6_SEG5                     0
> +
> +#define ATHUB_BASE__INST7_SEG0                     0
> +#define ATHUB_BASE__INST7_SEG1                     0
> +#define ATHUB_BASE__INST7_SEG2                     0
> +#define ATHUB_BASE__INST7_SEG3                     0
> +#define ATHUB_BASE__INST7_SEG4                     0
> +#define ATHUB_BASE__INST7_SEG5                     0
> +
> +#define CLK_BASE__INST0_SEG0                       0x00016C00
> +#define CLK_BASE__INST0_SEG1                       0x02401800
> +#define CLK_BASE__INST0_SEG2                       0
> +#define CLK_BASE__INST0_SEG3                       0
> +#define CLK_BASE__INST0_SEG4                       0
> +#define CLK_BASE__INST0_SEG5                       0
> +
> +#define CLK_BASE__INST1_SEG0                       0x00016E00
> +#define CLK_BASE__INST1_SEG1                       0x02401C00
> +#define CLK_BASE__INST1_SEG2                       0
> +#define CLK_BASE__INST1_SEG3                       0
> +#define CLK_BASE__INST1_SEG4                       0
> +#define CLK_BASE__INST1_SEG5                       0
> +
> +#define CLK_BASE__INST2_SEG0                       0x00017000
> +#define CLK_BASE__INST2_SEG1                       0x02402000
> +#define CLK_BASE__INST2_SEG2                       0
> +#define CLK_BASE__INST2_SEG3                       0
> +#define CLK_BASE__INST2_SEG4                       0
> +#define CLK_BASE__INST2_SEG5                       0
> +
> +#define CLK_BASE__INST3_SEG0                       0x00017200
> +#define CLK_BASE__INST3_SEG1                       0x02402400
> +#define CLK_BASE__INST3_SEG2                       0
> +#define CLK_BASE__INST3_SEG3                       0
> +#define CLK_BASE__INST3_SEG4                       0
> +#define CLK_BASE__INST3_SEG5                       0
> +
> +#define CLK_BASE__INST4_SEG0                       0x0001B000
> +#define CLK_BASE__INST4_SEG1                       0x0242D800
> +#define CLK_BASE__INST4_SEG2                       0
> +#define CLK_BASE__INST4_SEG3                       0
> +#define CLK_BASE__INST4_SEG4                       0
> +#define CLK_BASE__INST4_SEG5                       0
> +
> +#define CLK_BASE__INST5_SEG0                       0x0001B200
> +#define CLK_BASE__INST5_SEG1                       0x0242DC00
> +#define CLK_BASE__INST5_SEG2                       0
> +#define CLK_BASE__INST5_SEG3                       0
> +#define CLK_BASE__INST5_SEG4                       0
> +#define CLK_BASE__INST5_SEG5                       0
> +
> +#define CLK_BASE__INST6_SEG0                       0x0001B400
> +#define CLK_BASE__INST6_SEG1                       0x0242E000
> +#define CLK_BASE__INST6_SEG2                       0
> +#define CLK_BASE__INST6_SEG3                       0
> +#define CLK_BASE__INST6_SEG4                       0
> +#define CLK_BASE__INST6_SEG5                       0
> +
> +#define CLK_BASE__INST7_SEG0                       0x00017E00
> +#define CLK_BASE__INST7_SEG1                       0x0240BC00
> +#define CLK_BASE__INST7_SEG2                       0
> +#define CLK_BASE__INST7_SEG3                       0
> +#define CLK_BASE__INST7_SEG4                       0
> +#define CLK_BASE__INST7_SEG5                       0
> +
> +#define DF_BASE__INST0_SEG0                        0x00007000
> +#define DF_BASE__INST0_SEG1                        0x0240B800
> +#define DF_BASE__INST0_SEG2                        0
> +#define DF_BASE__INST0_SEG3                        0
> +#define DF_BASE__INST0_SEG4                        0
> +#define DF_BASE__INST0_SEG5                        0
> +
> +#define DF_BASE__INST1_SEG0                        0
> +#define DF_BASE__INST1_SEG1                        0
> +#define DF_BASE__INST1_SEG2                        0
> +#define DF_BASE__INST1_SEG3                        0
> +#define DF_BASE__INST1_SEG4                        0
> +#define DF_BASE__INST1_SEG5                        0
> +
> +#define DF_BASE__INST2_SEG0                        0
> +#define DF_BASE__INST2_SEG1                        0
> +#define DF_BASE__INST2_SEG2                        0
> +#define DF_BASE__INST2_SEG3                        0
> +#define DF_BASE__INST2_SEG4                        0
> +#define DF_BASE__INST2_SEG5                        0
> +
> +#define DF_BASE__INST3_SEG0                        0
> +#define DF_BASE__INST3_SEG1                        0
> +#define DF_BASE__INST3_SEG2                        0
> +#define DF_BASE__INST3_SEG3                        0
> +#define DF_BASE__INST3_SEG4                        0
> +#define DF_BASE__INST3_SEG5                        0
> +
> +#define DF_BASE__INST4_SEG0                        0
> +#define DF_BASE__INST4_SEG1                        0
> +#define DF_BASE__INST4_SEG2                        0
> +#define DF_BASE__INST4_SEG3                        0
> +#define DF_BASE__INST4_SEG4                        0
> +#define DF_BASE__INST4_SEG5                        0
> +
> +#define DF_BASE__INST5_SEG0                        0
> +#define DF_BASE__INST5_SEG1                        0
> +#define DF_BASE__INST5_SEG2                        0
> +#define DF_BASE__INST5_SEG3                        0
> +#define DF_BASE__INST5_SEG4                        0
> +#define DF_BASE__INST5_SEG5                        0
> +
> +#define DF_BASE__INST6_SEG0                        0
> +#define DF_BASE__INST6_SEG1                        0
> +#define DF_BASE__INST6_SEG2                        0
> +#define DF_BASE__INST6_SEG3                        0
> +#define DF_BASE__INST6_SEG4                        0
> +#define DF_BASE__INST6_SEG5                        0
> +
> +#define DF_BASE__INST7_SEG0                        0
> +#define DF_BASE__INST7_SEG1                        0
> +#define DF_BASE__INST7_SEG2                        0
> +#define DF_BASE__INST7_SEG3                        0
> +#define DF_BASE__INST7_SEG4                        0
> +#define DF_BASE__INST7_SEG5                        0
> +
> +#define DCN_BASE__INST0_SEG0                       0x00000012
> +#define DCN_BASE__INST0_SEG1                       0x000000C0
> +#define DCN_BASE__INST0_SEG2                       0x000034C0
> +#define DCN_BASE__INST0_SEG3                       0x00009000
> +#define DCN_BASE__INST0_SEG4                       0x02403C00
> +#define DCN_BASE__INST0_SEG5                       0
> +
> +#define DCN_BASE__INST1_SEG0                       0
> +#define DCN_BASE__INST1_SEG1                       0
> +#define DCN_BASE__INST1_SEG2                       0
> +#define DCN_BASE__INST1_SEG3                       0
> +#define DCN_BASE__INST1_SEG4                       0
> +#define DCN_BASE__INST1_SEG5                       0
> +
> +#define DCN_BASE__INST2_SEG0                       0
> +#define DCN_BASE__INST2_SEG1                       0
> +#define DCN_BASE__INST2_SEG2                       0
> +#define DCN_BASE__INST2_SEG3                       0
> +#define DCN_BASE__INST2_SEG4                       0
> +#define DCN_BASE__INST2_SEG5                       0
> +
> +#define DCN_BASE__INST3_SEG0                       0
> +#define DCN_BASE__INST3_SEG1                       0
> +#define DCN_BASE__INST3_SEG2                       0
> +#define DCN_BASE__INST3_SEG3                       0
> +#define DCN_BASE__INST3_SEG4                       0
> +#define DCN_BASE__INST3_SEG5                       0
> +
> +#define DCN_BASE__INST4_SEG0                       0
> +#define DCN_BASE__INST4_SEG1                       0
> +#define DCN_BASE__INST4_SEG2                       0
> +#define DCN_BASE__INST4_SEG3                       0
> +#define DCN_BASE__INST4_SEG4                       0
> +#define DCN_BASE__INST4_SEG5                       0
> +
> +#define DCN_BASE__INST5_SEG0                       0
> +#define DCN_BASE__INST5_SEG1                       0
> +#define DCN_BASE__INST5_SEG2                       0
> +#define DCN_BASE__INST5_SEG3                       0
> +#define DCN_BASE__INST5_SEG4                       0
> +#define DCN_BASE__INST5_SEG5                       0
> +
> +#define DCN_BASE__INST6_SEG0                       0
> +#define DCN_BASE__INST6_SEG1                       0
> +#define DCN_BASE__INST6_SEG2                       0
> +#define DCN_BASE__INST6_SEG3                       0
> +#define DCN_BASE__INST6_SEG4                       0
> +#define DCN_BASE__INST6_SEG5                       0
> +
> +#define DCN_BASE__INST7_SEG0                       0
> +#define DCN_BASE__INST7_SEG1                       0
> +#define DCN_BASE__INST7_SEG2                       0
> +#define DCN_BASE__INST7_SEG3                       0
> +#define DCN_BASE__INST7_SEG4                       0
> +#define DCN_BASE__INST7_SEG5                       0
> +
> +#define DPCS_BASE__INST0_SEG0                      0x00000012
> +#define DPCS_BASE__INST0_SEG1                      0x000000C0
> +#define DPCS_BASE__INST0_SEG2                      0x000034C0
> +#define DPCS_BASE__INST0_SEG3                      0x00009000
> +#define DPCS_BASE__INST0_SEG4                      0x02403C00
> +#define DPCS_BASE__INST0_SEG5                      0
> +
> +#define DPCS_BASE__INST1_SEG0                      0
> +#define DPCS_BASE__INST1_SEG1                      0
> +#define DPCS_BASE__INST1_SEG2                      0
> +#define DPCS_BASE__INST1_SEG3                      0
> +#define DPCS_BASE__INST1_SEG4                      0
> +#define DPCS_BASE__INST1_SEG5                      0
> +
> +#define DPCS_BASE__INST2_SEG0                      0
> +#define DPCS_BASE__INST2_SEG1                      0
> +#define DPCS_BASE__INST2_SEG2                      0
> +#define DPCS_BASE__INST2_SEG3                      0
> +#define DPCS_BASE__INST2_SEG4                      0
> +#define DPCS_BASE__INST2_SEG5                      0
> +
> +#define DPCS_BASE__INST3_SEG0                      0
> +#define DPCS_BASE__INST3_SEG1                      0
> +#define DPCS_BASE__INST3_SEG2                      0
> +#define DPCS_BASE__INST3_SEG3                      0
> +#define DPCS_BASE__INST3_SEG4                      0
> +#define DPCS_BASE__INST3_SEG5                      0
> +
> +#define DPCS_BASE__INST4_SEG0                      0
> +#define DPCS_BASE__INST4_SEG1                      0
> +#define DPCS_BASE__INST4_SEG2                      0
> +#define DPCS_BASE__INST4_SEG3                      0
> +#define DPCS_BASE__INST4_SEG4                      0
> +#define DPCS_BASE__INST4_SEG5                      0
> +
> +#define DPCS_BASE__INST5_SEG0                      0
> +#define DPCS_BASE__INST5_SEG1                      0
> +#define DPCS_BASE__INST5_SEG2                      0
> +#define DPCS_BASE__INST5_SEG3                      0
> +#define DPCS_BASE__INST5_SEG4                      0
> +#define DPCS_BASE__INST5_SEG5                      0
> +
> +#define DPCS_BASE__INST6_SEG0                      0
> +#define DPCS_BASE__INST6_SEG1                      0
> +#define DPCS_BASE__INST6_SEG2                      0
> +#define DPCS_BASE__INST6_SEG3                      0
> +#define DPCS_BASE__INST6_SEG4                      0
> +#define DPCS_BASE__INST6_SEG5                      0
> +
> +#define DPCS_BASE__INST7_SEG0                      0
> +#define DPCS_BASE__INST7_SEG1                      0
> +#define DPCS_BASE__INST7_SEG2                      0
> +#define DPCS_BASE__INST7_SEG3                      0
> +#define DPCS_BASE__INST7_SEG4                      0
> +#define DPCS_BASE__INST7_SEG5                      0
> +
> +#define FCH_BASE__INST0_SEG0                       0x0240C000
> +#define FCH_BASE__INST0_SEG1                       0x00B40000
> +#define FCH_BASE__INST0_SEG2                       0x11000000
> +#define FCH_BASE__INST0_SEG3                       0
> +#define FCH_BASE__INST0_SEG4                       0
> +#define FCH_BASE__INST0_SEG5                       0
> +
> +#define FCH_BASE__INST1_SEG0                       0
> +#define FCH_BASE__INST1_SEG1                       0
> +#define FCH_BASE__INST1_SEG2                       0
> +#define FCH_BASE__INST1_SEG3                       0
> +#define FCH_BASE__INST1_SEG4                       0
> +#define FCH_BASE__INST1_SEG5                       0
> +
> +#define FCH_BASE__INST2_SEG0                       0
> +#define FCH_BASE__INST2_SEG1                       0
> +#define FCH_BASE__INST2_SEG2                       0
> +#define FCH_BASE__INST2_SEG3                       0
> +#define FCH_BASE__INST2_SEG4                       0
> +#define FCH_BASE__INST2_SEG5                       0
> +
> +#define FCH_BASE__INST3_SEG0                       0
> +#define FCH_BASE__INST3_SEG1                       0
> +#define FCH_BASE__INST3_SEG2                       0
> +#define FCH_BASE__INST3_SEG3                       0
> +#define FCH_BASE__INST3_SEG4                       0
> +#define FCH_BASE__INST3_SEG5                       0
> +
> +#define FCH_BASE__INST4_SEG0                       0
> +#define FCH_BASE__INST4_SEG1                       0
> +#define FCH_BASE__INST4_SEG2                       0
> +#define FCH_BASE__INST4_SEG3                       0
> +#define FCH_BASE__INST4_SEG4                       0
> +#define FCH_BASE__INST4_SEG5                       0
> +
> +#define FCH_BASE__INST5_SEG0                       0
> +#define FCH_BASE__INST5_SEG1                       0
> +#define FCH_BASE__INST5_SEG2                       0
> +#define FCH_BASE__INST5_SEG3                       0
> +#define FCH_BASE__INST5_SEG4                       0
> +#define FCH_BASE__INST5_SEG5                       0
> +
> +#define FCH_BASE__INST6_SEG0                       0
> +#define FCH_BASE__INST6_SEG1                       0
> +#define FCH_BASE__INST6_SEG2                       0
> +#define FCH_BASE__INST6_SEG3                       0
> +#define FCH_BASE__INST6_SEG4                       0
> +#define FCH_BASE__INST6_SEG5                       0
> +
> +#define FCH_BASE__INST7_SEG0                       0
> +#define FCH_BASE__INST7_SEG1                       0
> +#define FCH_BASE__INST7_SEG2                       0
> +#define FCH_BASE__INST7_SEG3                       0
> +#define FCH_BASE__INST7_SEG4                       0
> +#define FCH_BASE__INST7_SEG5                       0
> +
> +#define FUSE_BASE__INST0_SEG0                      0x00017400
> +#define FUSE_BASE__INST0_SEG1                      0x02401400
> +#define FUSE_BASE__INST0_SEG2                      0
> +#define FUSE_BASE__INST0_SEG3                      0
> +#define FUSE_BASE__INST0_SEG4                      0
> +#define FUSE_BASE__INST0_SEG5                      0
> +
> +#define FUSE_BASE__INST1_SEG0                      0
> +#define FUSE_BASE__INST1_SEG1                      0
> +#define FUSE_BASE__INST1_SEG2                      0
> +#define FUSE_BASE__INST1_SEG3                      0
> +#define FUSE_BASE__INST1_SEG4                      0
> +#define FUSE_BASE__INST1_SEG5                      0
> +
> +#define FUSE_BASE__INST2_SEG0                      0
> +#define FUSE_BASE__INST2_SEG1                      0
> +#define FUSE_BASE__INST2_SEG2                      0
> +#define FUSE_BASE__INST2_SEG3                      0
> +#define FUSE_BASE__INST2_SEG4                      0
> +#define FUSE_BASE__INST2_SEG5                      0
> +
> +#define FUSE_BASE__INST3_SEG0                      0
> +#define FUSE_BASE__INST3_SEG1                      0
> +#define FUSE_BASE__INST3_SEG2                      0
> +#define FUSE_BASE__INST3_SEG3                      0
> +#define FUSE_BASE__INST3_SEG4                      0
> +#define FUSE_BASE__INST3_SEG5                      0
> +
> +#define FUSE_BASE__INST4_SEG0                      0
> +#define FUSE_BASE__INST4_SEG1                      0
> +#define FUSE_BASE__INST4_SEG2                      0
> +#define FUSE_BASE__INST4_SEG3                      0
> +#define FUSE_BASE__INST4_SEG4                      0
> +#define FUSE_BASE__INST4_SEG5                      0
> +
> +#define FUSE_BASE__INST5_SEG0                      0
> +#define FUSE_BASE__INST5_SEG1                      0
> +#define FUSE_BASE__INST5_SEG2                      0
> +#define FUSE_BASE__INST5_SEG3                      0
> +#define FUSE_BASE__INST5_SEG4                      0
> +#define FUSE_BASE__INST5_SEG5                      0
> +
> +#define FUSE_BASE__INST6_SEG0                      0
> +#define FUSE_BASE__INST6_SEG1                      0
> +#define FUSE_BASE__INST6_SEG2                      0
> +#define FUSE_BASE__INST6_SEG3                      0
> +#define FUSE_BASE__INST6_SEG4                      0
> +#define FUSE_BASE__INST6_SEG5                      0
> +
> +#define FUSE_BASE__INST7_SEG0                      0
> +#define FUSE_BASE__INST7_SEG1                      0
> +#define FUSE_BASE__INST7_SEG2                      0
> +#define FUSE_BASE__INST7_SEG3                      0
> +#define FUSE_BASE__INST7_SEG4                      0
> +#define FUSE_BASE__INST7_SEG5                      0
> +
> +#define GC_BASE__INST0_SEG0                        0x00001260
> +#define GC_BASE__INST0_SEG1                        0x0000A000
> +#define GC_BASE__INST0_SEG2                        0x02402C00
> +#define GC_BASE__INST0_SEG3                        0
> +#define GC_BASE__INST0_SEG4                        0
> +#define GC_BASE__INST0_SEG5                        0
> +
> +#define GC_BASE__INST1_SEG0                        0
> +#define GC_BASE__INST1_SEG1                        0
> +#define GC_BASE__INST1_SEG2                        0
> +#define GC_BASE__INST1_SEG3                        0
> +#define GC_BASE__INST1_SEG4                        0
> +#define GC_BASE__INST1_SEG5                        0
> +
> +#define GC_BASE__INST2_SEG0                        0
> +#define GC_BASE__INST2_SEG1                        0
> +#define GC_BASE__INST2_SEG2                        0
> +#define GC_BASE__INST2_SEG3                        0
> +#define GC_BASE__INST2_SEG4                        0
> +#define GC_BASE__INST2_SEG5                        0
> +
> +#define GC_BASE__INST3_SEG0                        0
> +#define GC_BASE__INST3_SEG1                        0
> +#define GC_BASE__INST3_SEG2                        0
> +#define GC_BASE__INST3_SEG3                        0
> +#define GC_BASE__INST3_SEG4                        0
> +#define GC_BASE__INST3_SEG5                        0
> +
> +#define GC_BASE__INST4_SEG0                        0
> +#define GC_BASE__INST4_SEG1                        0
> +#define GC_BASE__INST4_SEG2                        0
> +#define GC_BASE__INST4_SEG3                        0
> +#define GC_BASE__INST4_SEG4                        0
> +#define GC_BASE__INST4_SEG5                        0
> +
> +#define GC_BASE__INST5_SEG0                        0
> +#define GC_BASE__INST5_SEG1                        0
> +#define GC_BASE__INST5_SEG2                        0
> +#define GC_BASE__INST5_SEG3                        0
> +#define GC_BASE__INST5_SEG4                        0
> +#define GC_BASE__INST5_SEG5                        0
> +
> +#define GC_BASE__INST6_SEG0                        0
> +#define GC_BASE__INST6_SEG1                        0
> +#define GC_BASE__INST6_SEG2                        0
> +#define GC_BASE__INST6_SEG3                        0
> +#define GC_BASE__INST6_SEG4                        0
> +#define GC_BASE__INST6_SEG5                        0
> +
> +#define GC_BASE__INST7_SEG0                        0
> +#define GC_BASE__INST7_SEG1                        0
> +#define GC_BASE__INST7_SEG2                        0
> +#define GC_BASE__INST7_SEG3                        0
> +#define GC_BASE__INST7_SEG4                        0
> +#define GC_BASE__INST7_SEG5                        0
> +
> +#define HDP_BASE__INST0_SEG0                       0x00000F20
> +#define HDP_BASE__INST0_SEG1                       0x0240A400
> +#define HDP_BASE__INST0_SEG2                       0
> +#define HDP_BASE__INST0_SEG3                       0
> +#define HDP_BASE__INST0_SEG4                       0
> +#define HDP_BASE__INST0_SEG5                       0
> +
> +#define HDP_BASE__INST1_SEG0                       0
> +#define HDP_BASE__INST1_SEG1                       0
> +#define HDP_BASE__INST1_SEG2                       0
> +#define HDP_BASE__INST1_SEG3                       0
> +#define HDP_BASE__INST1_SEG4                       0
> +#define HDP_BASE__INST1_SEG5                       0
> +
> +#define HDP_BASE__INST2_SEG0                       0
> +#define HDP_BASE__INST2_SEG1                       0
> +#define HDP_BASE__INST2_SEG2                       0
> +#define HDP_BASE__INST2_SEG3                       0
> +#define HDP_BASE__INST2_SEG4                       0
> +#define HDP_BASE__INST2_SEG5                       0
> +
> +#define HDP_BASE__INST3_SEG0                       0
> +#define HDP_BASE__INST3_SEG1                       0
> +#define HDP_BASE__INST3_SEG2                       0
> +#define HDP_BASE__INST3_SEG3                       0
> +#define HDP_BASE__INST3_SEG4                       0
> +#define HDP_BASE__INST3_SEG5                       0
> +
> +#define HDP_BASE__INST4_SEG0                       0
> +#define HDP_BASE__INST4_SEG1                       0
> +#define HDP_BASE__INST4_SEG2                       0
> +#define HDP_BASE__INST4_SEG3                       0
> +#define HDP_BASE__INST4_SEG4                       0
> +#define HDP_BASE__INST4_SEG5                       0
> +
> +#define HDP_BASE__INST5_SEG0                       0
> +#define HDP_BASE__INST5_SEG1                       0
> +#define HDP_BASE__INST5_SEG2                       0
> +#define HDP_BASE__INST5_SEG3                       0
> +#define HDP_BASE__INST5_SEG4                       0
> +#define HDP_BASE__INST5_SEG5                       0
> +
> +#define HDP_BASE__INST6_SEG0                       0
> +#define HDP_BASE__INST6_SEG1                       0
> +#define HDP_BASE__INST6_SEG2                       0
> +#define HDP_BASE__INST6_SEG3                       0
> +#define HDP_BASE__INST6_SEG4                       0
> +#define HDP_BASE__INST6_SEG5                       0
> +
> +#define HDP_BASE__INST7_SEG0                       0
> +#define HDP_BASE__INST7_SEG1                       0
> +#define HDP_BASE__INST7_SEG2                       0
> +#define HDP_BASE__INST7_SEG3                       0
> +#define HDP_BASE__INST7_SEG4                       0
> +#define HDP_BASE__INST7_SEG5                       0
> +
> +#define ISP_BASE__INST0_SEG0                       0x00018000
> +#define ISP_BASE__INST0_SEG1                       0x0240B000
> +#define ISP_BASE__INST0_SEG2                       0
> +#define ISP_BASE__INST0_SEG3                       0
> +#define ISP_BASE__INST0_SEG4                       0
> +#define ISP_BASE__INST0_SEG5                       0
> +
> +#define ISP_BASE__INST1_SEG0                       0
> +#define ISP_BASE__INST1_SEG1                       0
> +#define ISP_BASE__INST1_SEG2                       0
> +#define ISP_BASE__INST1_SEG3                       0
> +#define ISP_BASE__INST1_SEG4                       0
> +#define ISP_BASE__INST1_SEG5                       0
> +
> +#define ISP_BASE__INST2_SEG0                       0
> +#define ISP_BASE__INST2_SEG1                       0
> +#define ISP_BASE__INST2_SEG2                       0
> +#define ISP_BASE__INST2_SEG3                       0
> +#define ISP_BASE__INST2_SEG4                       0
> +#define ISP_BASE__INST2_SEG5                       0
> +
> +#define ISP_BASE__INST3_SEG0                       0
> +#define ISP_BASE__INST3_SEG1                       0
> +#define ISP_BASE__INST3_SEG2                       0
> +#define ISP_BASE__INST3_SEG3                       0
> +#define ISP_BASE__INST3_SEG4                       0
> +#define ISP_BASE__INST3_SEG5                       0
> +
> +#define ISP_BASE__INST4_SEG0                       0
> +#define ISP_BASE__INST4_SEG1                       0
> +#define ISP_BASE__INST4_SEG2                       0
> +#define ISP_BASE__INST4_SEG3                       0
> +#define ISP_BASE__INST4_SEG4                       0
> +#define ISP_BASE__INST4_SEG5                       0
> +
> +#define ISP_BASE__INST5_SEG0                       0
> +#define ISP_BASE__INST5_SEG1                       0
> +#define ISP_BASE__INST5_SEG2                       0
> +#define ISP_BASE__INST5_SEG3                       0
> +#define ISP_BASE__INST5_SEG4                       0
> +#define ISP_BASE__INST5_SEG5                       0
> +
> +#define ISP_BASE__INST6_SEG0                       0
> +#define ISP_BASE__INST6_SEG1                       0
> +#define ISP_BASE__INST6_SEG2                       0
> +#define ISP_BASE__INST6_SEG3                       0
> +#define ISP_BASE__INST6_SEG4                       0
> +#define ISP_BASE__INST6_SEG5                       0
> +
> +#define ISP_BASE__INST7_SEG0                       0
> +#define ISP_BASE__INST7_SEG1                       0
> +#define ISP_BASE__INST7_SEG2                       0
> +#define ISP_BASE__INST7_SEG3                       0
> +#define ISP_BASE__INST7_SEG4                       0
> +#define ISP_BASE__INST7_SEG5                       0
> +
> +#define MMHUB_BASE__INST0_SEG0                     0x00013200
> +#define MMHUB_BASE__INST0_SEG1                     0x0001A000
> +#define MMHUB_BASE__INST0_SEG2                     0x02408800
> +#define MMHUB_BASE__INST0_SEG3                     0
> +#define MMHUB_BASE__INST0_SEG4                     0
> +#define MMHUB_BASE__INST0_SEG5                     0
> +
> +#define MMHUB_BASE__INST1_SEG0                     0
> +#define MMHUB_BASE__INST1_SEG1                     0
> +#define MMHUB_BASE__INST1_SEG2                     0
> +#define MMHUB_BASE__INST1_SEG3                     0
> +#define MMHUB_BASE__INST1_SEG4                     0
> +#define MMHUB_BASE__INST1_SEG5                     0
> +
> +#define MMHUB_BASE__INST2_SEG0                     0
> +#define MMHUB_BASE__INST2_SEG1                     0
> +#define MMHUB_BASE__INST2_SEG2                     0
> +#define MMHUB_BASE__INST2_SEG3                     0
> +#define MMHUB_BASE__INST2_SEG4                     0
> +#define MMHUB_BASE__INST2_SEG5                     0
> +
> +#define MMHUB_BASE__INST3_SEG0                     0
> +#define MMHUB_BASE__INST3_SEG1                     0
> +#define MMHUB_BASE__INST3_SEG2                     0
> +#define MMHUB_BASE__INST3_SEG3                     0
> +#define MMHUB_BASE__INST3_SEG4                     0
> +#define MMHUB_BASE__INST3_SEG5                     0
> +
> +#define MMHUB_BASE__INST4_SEG0                     0
> +#define MMHUB_BASE__INST4_SEG1                     0
> +#define MMHUB_BASE__INST4_SEG2                     0
> +#define MMHUB_BASE__INST4_SEG3                     0
> +#define MMHUB_BASE__INST4_SEG4                     0
> +#define MMHUB_BASE__INST4_SEG5                     0
> +
> +#define MMHUB_BASE__INST5_SEG0                     0
> +#define MMHUB_BASE__INST5_SEG1                     0
> +#define MMHUB_BASE__INST5_SEG2                     0
> +#define MMHUB_BASE__INST5_SEG3                     0
> +#define MMHUB_BASE__INST5_SEG4                     0
> +#define MMHUB_BASE__INST5_SEG5                     0
> +
> +#define MMHUB_BASE__INST6_SEG0                     0
> +#define MMHUB_BASE__INST6_SEG1                     0
> +#define MMHUB_BASE__INST6_SEG2                     0
> +#define MMHUB_BASE__INST6_SEG3                     0
> +#define MMHUB_BASE__INST6_SEG4                     0
> +#define MMHUB_BASE__INST6_SEG5                     0
> +
> +#define MMHUB_BASE__INST7_SEG0                     0
> +#define MMHUB_BASE__INST7_SEG1                     0
> +#define MMHUB_BASE__INST7_SEG2                     0
> +#define MMHUB_BASE__INST7_SEG3                     0
> +#define MMHUB_BASE__INST7_SEG4                     0
> +#define MMHUB_BASE__INST7_SEG5                     0
> +
> +#define MP0_BASE__INST0_SEG0                       0x00016000
> +#define MP0_BASE__INST0_SEG1                       0x0243FC00
> +#define MP0_BASE__INST0_SEG2                       0x00DC0000
> +#define MP0_BASE__INST0_SEG3                       0x00E00000
> +#define MP0_BASE__INST0_SEG4                       0x00E40000
> +#define MP0_BASE__INST0_SEG5                       0
> +
> +#define MP0_BASE__INST1_SEG0                       0
> +#define MP0_BASE__INST1_SEG1                       0
> +#define MP0_BASE__INST1_SEG2                       0
> +#define MP0_BASE__INST1_SEG3                       0
> +#define MP0_BASE__INST1_SEG4                       0
> +#define MP0_BASE__INST1_SEG5                       0
> +
> +#define MP0_BASE__INST2_SEG0                       0
> +#define MP0_BASE__INST2_SEG1                       0
> +#define MP0_BASE__INST2_SEG2                       0
> +#define MP0_BASE__INST2_SEG3                       0
> +#define MP0_BASE__INST2_SEG4                       0
> +#define MP0_BASE__INST2_SEG5                       0
> +
> +#define MP0_BASE__INST3_SEG0                       0
> +#define MP0_BASE__INST3_SEG1                       0
> +#define MP0_BASE__INST3_SEG2                       0
> +#define MP0_BASE__INST3_SEG3                       0
> +#define MP0_BASE__INST3_SEG4                       0
> +#define MP0_BASE__INST3_SEG5                       0
> +
> +#define MP0_BASE__INST4_SEG0                       0
> +#define MP0_BASE__INST4_SEG1                       0
> +#define MP0_BASE__INST4_SEG2                       0
> +#define MP0_BASE__INST4_SEG3                       0
> +#define MP0_BASE__INST4_SEG4                       0
> +#define MP0_BASE__INST4_SEG5                       0
> +
> +#define MP0_BASE__INST5_SEG0                       0
> +#define MP0_BASE__INST5_SEG1                       0
> +#define MP0_BASE__INST5_SEG2                       0
> +#define MP0_BASE__INST5_SEG3                       0
> +#define MP0_BASE__INST5_SEG4                       0
> +#define MP0_BASE__INST5_SEG5                       0
> +
> +#define MP0_BASE__INST6_SEG0                       0
> +#define MP0_BASE__INST6_SEG1                       0
> +#define MP0_BASE__INST6_SEG2                       0
> +#define MP0_BASE__INST6_SEG3                       0
> +#define MP0_BASE__INST6_SEG4                       0
> +#define MP0_BASE__INST6_SEG5                       0
> +
> +#define MP0_BASE__INST7_SEG0                       0
> +#define MP0_BASE__INST7_SEG1                       0
> +#define MP0_BASE__INST7_SEG2                       0
> +#define MP0_BASE__INST7_SEG3                       0
> +#define MP0_BASE__INST7_SEG4                       0
> +#define MP0_BASE__INST7_SEG5                       0
> +
> +#define MP1_BASE__INST0_SEG0                       0x00016000
> +#define MP1_BASE__INST0_SEG1                       0x0243FC00
> +#define MP1_BASE__INST0_SEG2                       0x00DC0000
> +#define MP1_BASE__INST0_SEG3                       0x00E00000
> +#define MP1_BASE__INST0_SEG4                       0x00E40000
> +#define MP1_BASE__INST0_SEG5                       0
> +
> +#define MP1_BASE__INST1_SEG0                       0
> +#define MP1_BASE__INST1_SEG1                       0
> +#define MP1_BASE__INST1_SEG2                       0
> +#define MP1_BASE__INST1_SEG3                       0
> +#define MP1_BASE__INST1_SEG4                       0
> +#define MP1_BASE__INST1_SEG5                       0
> +
> +#define MP1_BASE__INST2_SEG0                       0
> +#define MP1_BASE__INST2_SEG1                       0
> +#define MP1_BASE__INST2_SEG2                       0
> +#define MP1_BASE__INST2_SEG3                       0
> +#define MP1_BASE__INST2_SEG4                       0
> +#define MP1_BASE__INST2_SEG5                       0
> +
> +#define MP1_BASE__INST3_SEG0                       0
> +#define MP1_BASE__INST3_SEG1                       0
> +#define MP1_BASE__INST3_SEG2                       0
> +#define MP1_BASE__INST3_SEG3                       0
> +#define MP1_BASE__INST3_SEG4                       0
> +#define MP1_BASE__INST3_SEG5                       0
> +
> +#define MP1_BASE__INST4_SEG0                       0
> +#define MP1_BASE__INST4_SEG1                       0
> +#define MP1_BASE__INST4_SEG2                       0
> +#define MP1_BASE__INST4_SEG3                       0
> +#define MP1_BASE__INST4_SEG4                       0
> +#define MP1_BASE__INST4_SEG5                       0
> +
> +#define MP1_BASE__INST5_SEG0                       0
> +#define MP1_BASE__INST5_SEG1                       0
> +#define MP1_BASE__INST5_SEG2                       0
> +#define MP1_BASE__INST5_SEG3                       0
> +#define MP1_BASE__INST5_SEG4                       0
> +#define MP1_BASE__INST5_SEG5                       0
> +
> +#define MP1_BASE__INST6_SEG0                       0
> +#define MP1_BASE__INST6_SEG1                       0
> +#define MP1_BASE__INST6_SEG2                       0
> +#define MP1_BASE__INST6_SEG3                       0
> +#define MP1_BASE__INST6_SEG4                       0
> +#define MP1_BASE__INST6_SEG5                       0
> +
> +#define MP1_BASE__INST7_SEG0                       0
> +#define MP1_BASE__INST7_SEG1                       0
> +#define MP1_BASE__INST7_SEG2                       0
> +#define MP1_BASE__INST7_SEG3                       0
> +#define MP1_BASE__INST7_SEG4                       0
> +#define MP1_BASE__INST7_SEG5                       0
> +
> +#define MP2_BASE__INST0_SEG0                       0x00016400
> +#define MP2_BASE__INST0_SEG1                       0x02400800
> +#define MP2_BASE__INST0_SEG2                       0x00F40000
> +#define MP2_BASE__INST0_SEG3                       0x00F80000
> +#define MP2_BASE__INST0_SEG4                       0x00FC0000
> +#define MP2_BASE__INST0_SEG5                       0
> +
> +#define MP2_BASE__INST1_SEG0                       0
> +#define MP2_BASE__INST1_SEG1                       0
> +#define MP2_BASE__INST1_SEG2                       0
> +#define MP2_BASE__INST1_SEG3                       0
> +#define MP2_BASE__INST1_SEG4                       0
> +#define MP2_BASE__INST1_SEG5                       0
> +
> +#define MP2_BASE__INST2_SEG0                       0
> +#define MP2_BASE__INST2_SEG1                       0
> +#define MP2_BASE__INST2_SEG2                       0
> +#define MP2_BASE__INST2_SEG3                       0
> +#define MP2_BASE__INST2_SEG4                       0
> +#define MP2_BASE__INST2_SEG5                       0
> +
> +#define MP2_BASE__INST3_SEG0                       0
> +#define MP2_BASE__INST3_SEG1                       0
> +#define MP2_BASE__INST3_SEG2                       0
> +#define MP2_BASE__INST3_SEG3                       0
> +#define MP2_BASE__INST3_SEG4                       0
> +#define MP2_BASE__INST3_SEG5                       0
> +
> +#define MP2_BASE__INST4_SEG0                       0
> +#define MP2_BASE__INST4_SEG1                       0
> +#define MP2_BASE__INST4_SEG2                       0
> +#define MP2_BASE__INST4_SEG3                       0
> +#define MP2_BASE__INST4_SEG4                       0
> +#define MP2_BASE__INST4_SEG5                       0
> +
> +#define MP2_BASE__INST5_SEG0                       0
> +#define MP2_BASE__INST5_SEG1                       0
> +#define MP2_BASE__INST5_SEG2                       0
> +#define MP2_BASE__INST5_SEG3                       0
> +#define MP2_BASE__INST5_SEG4                       0
> +#define MP2_BASE__INST5_SEG5                       0
> +
> +#define MP2_BASE__INST6_SEG0                       0
> +#define MP2_BASE__INST6_SEG1                       0
> +#define MP2_BASE__INST6_SEG2                       0
> +#define MP2_BASE__INST6_SEG3                       0
> +#define MP2_BASE__INST6_SEG4                       0
> +#define MP2_BASE__INST6_SEG5                       0
> +
> +#define MP2_BASE__INST7_SEG0                       0
> +#define MP2_BASE__INST7_SEG1                       0
> +#define MP2_BASE__INST7_SEG2                       0
> +#define MP2_BASE__INST7_SEG3                       0
> +#define MP2_BASE__INST7_SEG4                       0
> +#define MP2_BASE__INST7_SEG5                       0
> +
> +#define NBIO_BASE__INST0_SEG0                      0x00000000
> +#define NBIO_BASE__INST0_SEG1                      0x00000014
> +#define NBIO_BASE__INST0_SEG2                      0x00000D20
> +#define NBIO_BASE__INST0_SEG3                      0x00010400
> +#define NBIO_BASE__INST0_SEG4                      0x0241B000
> +#define NBIO_BASE__INST0_SEG5                      0x04040000
> +
> +#define NBIO_BASE__INST1_SEG0                      0
> +#define NBIO_BASE__INST1_SEG1                      0
> +#define NBIO_BASE__INST1_SEG2                      0
> +#define NBIO_BASE__INST1_SEG3                      0
> +#define NBIO_BASE__INST1_SEG4                      0
> +#define NBIO_BASE__INST1_SEG5                      0
> +
> +#define NBIO_BASE__INST2_SEG0                      0
> +#define NBIO_BASE__INST2_SEG1                      0
> +#define NBIO_BASE__INST2_SEG2                      0
> +#define NBIO_BASE__INST2_SEG3                      0
> +#define NBIO_BASE__INST2_SEG4                      0
> +#define NBIO_BASE__INST2_SEG5                      0
> +
> +#define NBIO_BASE__INST3_SEG0                      0
> +#define NBIO_BASE__INST3_SEG1                      0
> +#define NBIO_BASE__INST3_SEG2                      0
> +#define NBIO_BASE__INST3_SEG3                      0
> +#define NBIO_BASE__INST3_SEG4                      0
> +#define NBIO_BASE__INST3_SEG5                      0
> +
> +#define NBIO_BASE__INST4_SEG0                      0
> +#define NBIO_BASE__INST4_SEG1                      0
> +#define NBIO_BASE__INST4_SEG2                      0
> +#define NBIO_BASE__INST4_SEG3                      0
> +#define NBIO_BASE__INST4_SEG4                      0
> +#define NBIO_BASE__INST4_SEG5                      0
> +
> +#define NBIO_BASE__INST5_SEG0                      0
> +#define NBIO_BASE__INST5_SEG1                      0
> +#define NBIO_BASE__INST5_SEG2                      0
> +#define NBIO_BASE__INST5_SEG3                      0
> +#define NBIO_BASE__INST5_SEG4                      0
> +#define NBIO_BASE__INST5_SEG5                      0
> +
> +#define NBIO_BASE__INST6_SEG0                      0
> +#define NBIO_BASE__INST6_SEG1                      0
> +#define NBIO_BASE__INST6_SEG2                      0
> +#define NBIO_BASE__INST6_SEG3                      0
> +#define NBIO_BASE__INST6_SEG4                      0
> +#define NBIO_BASE__INST6_SEG5                      0
> +
> +#define NBIO_BASE__INST7_SEG0                      0
> +#define NBIO_BASE__INST7_SEG1                      0
> +#define NBIO_BASE__INST7_SEG2                      0
> +#define NBIO_BASE__INST7_SEG3                      0
> +#define NBIO_BASE__INST7_SEG4                      0
> +#define NBIO_BASE__INST7_SEG5                      0
> +
> +#define OSSSYS_BASE__INST0_SEG0                    0x000010A0
> +#define OSSSYS_BASE__INST0_SEG1                    0x0240A000
> +#define OSSSYS_BASE__INST0_SEG2                    0
> +#define OSSSYS_BASE__INST0_SEG3                    0
> +#define OSSSYS_BASE__INST0_SEG4                    0
> +#define OSSSYS_BASE__INST0_SEG5                    0
> +
> +#define OSSSYS_BASE__INST1_SEG0                    0
> +#define OSSSYS_BASE__INST1_SEG1                    0
> +#define OSSSYS_BASE__INST1_SEG2                    0
> +#define OSSSYS_BASE__INST1_SEG3                    0
> +#define OSSSYS_BASE__INST1_SEG4                    0
> +#define OSSSYS_BASE__INST1_SEG5                    0
> +
> +#define OSSSYS_BASE__INST2_SEG0                    0
> +#define OSSSYS_BASE__INST2_SEG1                    0
> +#define OSSSYS_BASE__INST2_SEG2                    0
> +#define OSSSYS_BASE__INST2_SEG3                    0
> +#define OSSSYS_BASE__INST2_SEG4                    0
> +#define OSSSYS_BASE__INST2_SEG5                    0
> +
> +#define OSSSYS_BASE__INST3_SEG0                    0
> +#define OSSSYS_BASE__INST3_SEG1                    0
> +#define OSSSYS_BASE__INST3_SEG2                    0
> +#define OSSSYS_BASE__INST3_SEG3                    0
> +#define OSSSYS_BASE__INST3_SEG4                    0
> +#define OSSSYS_BASE__INST3_SEG5                    0
> +
> +#define OSSSYS_BASE__INST4_SEG0                    0
> +#define OSSSYS_BASE__INST4_SEG1                    0
> +#define OSSSYS_BASE__INST4_SEG2                    0
> +#define OSSSYS_BASE__INST4_SEG3                    0
> +#define OSSSYS_BASE__INST4_SEG4                    0
> +#define OSSSYS_BASE__INST4_SEG5                    0
> +
> +#define OSSSYS_BASE__INST5_SEG0                    0
> +#define OSSSYS_BASE__INST5_SEG1                    0
> +#define OSSSYS_BASE__INST5_SEG2                    0
> +#define OSSSYS_BASE__INST5_SEG3                    0
> +#define OSSSYS_BASE__INST5_SEG4                    0
> +#define OSSSYS_BASE__INST5_SEG5                    0
> +
> +#define OSSSYS_BASE__INST6_SEG0                    0
> +#define OSSSYS_BASE__INST6_SEG1                    0
> +#define OSSSYS_BASE__INST6_SEG2                    0
> +#define OSSSYS_BASE__INST6_SEG3                    0
> +#define OSSSYS_BASE__INST6_SEG4                    0
> +#define OSSSYS_BASE__INST6_SEG5                    0
> +
> +#define OSSSYS_BASE__INST7_SEG0                    0
> +#define OSSSYS_BASE__INST7_SEG1                    0
> +#define OSSSYS_BASE__INST7_SEG2                    0
> +#define OSSSYS_BASE__INST7_SEG3                    0
> +#define OSSSYS_BASE__INST7_SEG4                    0
> +#define OSSSYS_BASE__INST7_SEG5                    0
> +
> +#define PCIE0_BASE__INST0_SEG0                     0x00000000
> +#define PCIE0_BASE__INST0_SEG1                     0x00000014
> +#define PCIE0_BASE__INST0_SEG2                     0x00000D20
> +#define PCIE0_BASE__INST0_SEG3                     0x00010400
> +#define PCIE0_BASE__INST0_SEG4                     0x0241B000
> +#define PCIE0_BASE__INST0_SEG5                     0x04040000
> +
> +#define PCIE0_BASE__INST1_SEG0                     0
> +#define PCIE0_BASE__INST1_SEG1                     0
> +#define PCIE0_BASE__INST1_SEG2                     0
> +#define PCIE0_BASE__INST1_SEG3                     0
> +#define PCIE0_BASE__INST1_SEG4                     0
> +#define PCIE0_BASE__INST1_SEG5                     0
> +
> +#define PCIE0_BASE__INST2_SEG0                     0
> +#define PCIE0_BASE__INST2_SEG1                     0
> +#define PCIE0_BASE__INST2_SEG2                     0
> +#define PCIE0_BASE__INST2_SEG3                     0
> +#define PCIE0_BASE__INST2_SEG4                     0
> +#define PCIE0_BASE__INST2_SEG5                     0
> +
> +#define PCIE0_BASE__INST3_SEG0                     0
> +#define PCIE0_BASE__INST3_SEG1                     0
> +#define PCIE0_BASE__INST3_SEG2                     0
> +#define PCIE0_BASE__INST3_SEG3                     0
> +#define PCIE0_BASE__INST3_SEG4                     0
> +#define PCIE0_BASE__INST3_SEG5                     0
> +
> +#define PCIE0_BASE__INST4_SEG0                     0
> +#define PCIE0_BASE__INST4_SEG1                     0
> +#define PCIE0_BASE__INST4_SEG2                     0
> +#define PCIE0_BASE__INST4_SEG3                     0
> +#define PCIE0_BASE__INST4_SEG4                     0
> +#define PCIE0_BASE__INST4_SEG5                     0
> +
> +#define PCIE0_BASE__INST5_SEG0                     0
> +#define PCIE0_BASE__INST5_SEG1                     0
> +#define PCIE0_BASE__INST5_SEG2                     0
> +#define PCIE0_BASE__INST5_SEG3                     0
> +#define PCIE0_BASE__INST5_SEG4                     0
> +#define PCIE0_BASE__INST5_SEG5                     0
> +
> +#define PCIE0_BASE__INST6_SEG0                     0
> +#define PCIE0_BASE__INST6_SEG1                     0
> +#define PCIE0_BASE__INST6_SEG2                     0
> +#define PCIE0_BASE__INST6_SEG3                     0
> +#define PCIE0_BASE__INST6_SEG4                     0
> +#define PCIE0_BASE__INST6_SEG5                     0
> +
> +#define PCIE0_BASE__INST7_SEG0                     0
> +#define PCIE0_BASE__INST7_SEG1                     0
> +#define PCIE0_BASE__INST7_SEG2                     0
> +#define PCIE0_BASE__INST7_SEG3                     0
> +#define PCIE0_BASE__INST7_SEG4                     0
> +#define PCIE0_BASE__INST7_SEG5                     0
> +
> +#define SMUIO_BASE__INST0_SEG0                      0x00016800
> +#define SMUIO_BASE__INST0_SEG1                      0x00016A00
> +#define SMUIO_BASE__INST0_SEG2                      0x02401000
> +#define SMUIO_BASE__INST0_SEG3                      0x00440000
> +#define SMUIO_BASE__INST0_SEG4                      0
> +#define SMUIO_BASE__INST0_SEG5                      0
> +
> +#define SMUIO_BASE__INST1_SEG0                      0x0001BC00
> +#define SMUIO_BASE__INST1_SEG1                      0x0242D400
> +#define SMUIO_BASE__INST1_SEG2                      0
> +#define SMUIO_BASE__INST1_SEG3                      0
> +#define SMUIO_BASE__INST1_SEG4                      0
> +#define SMUIO_BASE__INST1_SEG5                      0
> +
> +#define SMUIO_BASE__INST2_SEG0                      0
> +#define SMUIO_BASE__INST2_SEG1                      0
> +#define SMUIO_BASE__INST2_SEG2                      0
> +#define SMUIO_BASE__INST2_SEG3                      0
> +#define SMUIO_BASE__INST2_SEG4                      0
> +#define SMUIO_BASE__INST2_SEG5                      0
> +
> +#define SMUIO_BASE__INST3_SEG0                      0
> +#define SMUIO_BASE__INST3_SEG1                      0
> +#define SMUIO_BASE__INST3_SEG2                      0
> +#define SMUIO_BASE__INST3_SEG3                      0
> +#define SMUIO_BASE__INST3_SEG4                      0
> +#define SMUIO_BASE__INST3_SEG5                      0
> +
> +#define SMUIO_BASE__INST4_SEG0                      0
> +#define SMUIO_BASE__INST4_SEG1                      0
> +#define SMUIO_BASE__INST4_SEG2                      0
> +#define SMUIO_BASE__INST4_SEG3                      0
> +#define SMUIO_BASE__INST4_SEG4                      0
> +#define SMUIO_BASE__INST4_SEG5                      0
> +
> +#define SMUIO_BASE__INST5_SEG0                      0
> +#define SMUIO_BASE__INST5_SEG1                      0
> +#define SMUIO_BASE__INST5_SEG2                      0
> +#define SMUIO_BASE__INST5_SEG3                      0
> +#define SMUIO_BASE__INST5_SEG4                      0
> +#define SMUIO_BASE__INST5_SEG5                      0
> +
> +#define SMUIO_BASE__INST6_SEG0                      0
> +#define SMUIO_BASE__INST6_SEG1                      0
> +#define SMUIO_BASE__INST6_SEG2                      0
> +#define SMUIO_BASE__INST6_SEG3                      0
> +#define SMUIO_BASE__INST6_SEG4                      0
> +#define SMUIO_BASE__INST6_SEG5                      0
> +
> +#define SMUIO_BASE__INST7_SEG0                      0
> +#define SMUIO_BASE__INST7_SEG1                      0
> +#define SMUIO_BASE__INST7_SEG2                      0
> +#define SMUIO_BASE__INST7_SEG3                      0
> +#define SMUIO_BASE__INST7_SEG4                      0
> +#define SMUIO_BASE__INST7_SEG5                      0
> +
> +#define THM_BASE__INST0_SEG0                       0x00016600
> +#define THM_BASE__INST0_SEG1                       0x02400C00
> +#define THM_BASE__INST0_SEG2                       0
> +#define THM_BASE__INST0_SEG3                       0
> +#define THM_BASE__INST0_SEG4                       0
> +#define THM_BASE__INST0_SEG5                       0
> +
> +#define THM_BASE__INST1_SEG0                       0
> +#define THM_BASE__INST1_SEG1                       0
> +#define THM_BASE__INST1_SEG2                       0
> +#define THM_BASE__INST1_SEG3                       0
> +#define THM_BASE__INST1_SEG4                       0
> +#define THM_BASE__INST1_SEG5                       0
> +
> +#define THM_BASE__INST2_SEG0                       0
> +#define THM_BASE__INST2_SEG1                       0
> +#define THM_BASE__INST2_SEG2                       0
> +#define THM_BASE__INST2_SEG3                       0
> +#define THM_BASE__INST2_SEG4                       0
> +#define THM_BASE__INST2_SEG5                       0
> +
> +#define THM_BASE__INST3_SEG0                       0
> +#define THM_BASE__INST3_SEG1                       0
> +#define THM_BASE__INST3_SEG2                       0
> +#define THM_BASE__INST3_SEG3                       0
> +#define THM_BASE__INST3_SEG4                       0
> +#define THM_BASE__INST3_SEG5                       0
> +
> +#define THM_BASE__INST4_SEG0                       0
> +#define THM_BASE__INST4_SEG1                       0
> +#define THM_BASE__INST4_SEG2                       0
> +#define THM_BASE__INST4_SEG3                       0
> +#define THM_BASE__INST4_SEG4                       0
> +#define THM_BASE__INST4_SEG5                       0
> +
> +#define THM_BASE__INST5_SEG0                       0
> +#define THM_BASE__INST5_SEG1                       0
> +#define THM_BASE__INST5_SEG2                       0
> +#define THM_BASE__INST5_SEG3                       0
> +#define THM_BASE__INST5_SEG4                       0
> +#define THM_BASE__INST5_SEG5                       0
> +
> +#define THM_BASE__INST6_SEG0                       0
> +#define THM_BASE__INST6_SEG1                       0
> +#define THM_BASE__INST6_SEG2                       0
> +#define THM_BASE__INST6_SEG3                       0
> +#define THM_BASE__INST6_SEG4                       0
> +#define THM_BASE__INST6_SEG5                       0
> +
> +#define THM_BASE__INST7_SEG0                       0
> +#define THM_BASE__INST7_SEG1                       0
> +#define THM_BASE__INST7_SEG2                       0
> +#define THM_BASE__INST7_SEG3                       0
> +#define THM_BASE__INST7_SEG4                       0
> +#define THM_BASE__INST7_SEG5                       0
> +
> +#define UMC_BASE__INST0_SEG0                       0x00014000
> +#define UMC_BASE__INST0_SEG1                       0x02425800
> +#define UMC_BASE__INST0_SEG2                       0
> +#define UMC_BASE__INST0_SEG3                       0
> +#define UMC_BASE__INST0_SEG4                       0
> +#define UMC_BASE__INST0_SEG5                       0
> +
> +#define UMC_BASE__INST1_SEG0                       0x00054000
> +#define UMC_BASE__INST1_SEG1                       0x02425C00
> +#define UMC_BASE__INST1_SEG2                       0
> +#define UMC_BASE__INST1_SEG3                       0
> +#define UMC_BASE__INST1_SEG4                       0
> +#define UMC_BASE__INST1_SEG5                       0
> +
> +#define UMC_BASE__INST2_SEG0                       0x00094000
> +#define UMC_BASE__INST2_SEG1                       0x02426000
> +#define UMC_BASE__INST2_SEG2                       0
> +#define UMC_BASE__INST2_SEG3                       0
> +#define UMC_BASE__INST2_SEG4                       0
> +#define UMC_BASE__INST2_SEG5                       0
> +
> +#define UMC_BASE__INST3_SEG0                       0x000D4000
> +#define UMC_BASE__INST3_SEG1                       0x02426400
> +#define UMC_BASE__INST3_SEG2                       0
> +#define UMC_BASE__INST3_SEG3                       0
> +#define UMC_BASE__INST3_SEG4                       0
> +#define UMC_BASE__INST3_SEG5                       0
> +
> +#define UMC_BASE__INST4_SEG0                       0
> +#define UMC_BASE__INST4_SEG1                       0
> +#define UMC_BASE__INST4_SEG2                       0
> +#define UMC_BASE__INST4_SEG3                       0
> +#define UMC_BASE__INST4_SEG4                       0
> +#define UMC_BASE__INST4_SEG5                       0
> +
> +#define UMC_BASE__INST5_SEG0                       0
> +#define UMC_BASE__INST5_SEG1                       0
> +#define UMC_BASE__INST5_SEG2                       0
> +#define UMC_BASE__INST5_SEG3                       0
> +#define UMC_BASE__INST5_SEG4                       0
> +#define UMC_BASE__INST5_SEG5                       0
> +
> +#define UMC_BASE__INST6_SEG0                       0
> +#define UMC_BASE__INST6_SEG1                       0
> +#define UMC_BASE__INST6_SEG2                       0
> +#define UMC_BASE__INST6_SEG3                       0
> +#define UMC_BASE__INST6_SEG4                       0
> +#define UMC_BASE__INST6_SEG5                       0
> +
> +#define UMC_BASE__INST7_SEG0                       0
> +#define UMC_BASE__INST7_SEG1                       0
> +#define UMC_BASE__INST7_SEG2                       0
> +#define UMC_BASE__INST7_SEG3                       0
> +#define UMC_BASE__INST7_SEG4                       0
> +#define UMC_BASE__INST7_SEG5                       0
> +
> +#define USB_BASE__INST0_SEG0                       0x0242A800
> +#define USB_BASE__INST0_SEG1                       0x05B00000
> +#define USB_BASE__INST0_SEG2                       0
> +#define USB_BASE__INST0_SEG3                       0
> +#define USB_BASE__INST0_SEG4                       0
> +#define USB_BASE__INST0_SEG5                       0
> +
> +#define USB_BASE__INST1_SEG0                       0x0242AC00
> +#define USB_BASE__INST1_SEG1                       0x05B80000
> +#define USB_BASE__INST1_SEG2                       0
> +#define USB_BASE__INST1_SEG3                       0
> +#define USB_BASE__INST1_SEG4                       0
> +#define USB_BASE__INST1_SEG5                       0
> +
> +#define USB_BASE__INST2_SEG0                       0x0242B000
> +#define USB_BASE__INST2_SEG1                       0x05C00000
> +#define USB_BASE__INST2_SEG2                       0
> +#define USB_BASE__INST2_SEG3                       0
> +#define USB_BASE__INST2_SEG4                       0
> +#define USB_BASE__INST2_SEG5                       0
> +
> +#define USB_BASE__INST3_SEG0                       0
> +#define USB_BASE__INST3_SEG1                       0
> +#define USB_BASE__INST3_SEG2                       0
> +#define USB_BASE__INST3_SEG3                       0
> +#define USB_BASE__INST3_SEG4                       0
> +#define USB_BASE__INST3_SEG5                       0
> +
> +#define USB_BASE__INST4_SEG0                       0
> +#define USB_BASE__INST4_SEG1                       0
> +#define USB_BASE__INST4_SEG2                       0
> +#define USB_BASE__INST4_SEG3                       0
> +#define USB_BASE__INST4_SEG4                       0
> +#define USB_BASE__INST4_SEG5                       0
> +
> +#define USB_BASE__INST5_SEG0                       0
> +#define USB_BASE__INST5_SEG1                       0
> +#define USB_BASE__INST5_SEG2                       0
> +#define USB_BASE__INST5_SEG3                       0
> +#define USB_BASE__INST5_SEG4                       0
> +#define USB_BASE__INST5_SEG5                       0
> +
> +#define USB_BASE__INST6_SEG0                       0
> +#define USB_BASE__INST6_SEG1                       0
> +#define USB_BASE__INST6_SEG2                       0
> +#define USB_BASE__INST6_SEG3                       0
> +#define USB_BASE__INST6_SEG4                       0
> +#define USB_BASE__INST6_SEG5                       0
> +
> +#define USB_BASE__INST7_SEG0                       0
> +#define USB_BASE__INST7_SEG1                       0
> +#define USB_BASE__INST7_SEG2                       0
> +#define USB_BASE__INST7_SEG3                       0
> +#define USB_BASE__INST7_SEG4                       0
> +#define USB_BASE__INST7_SEG5                       0
> +
> +#define VCN_BASE__INST0_SEG0                      0x00007800
> +#define VCN_BASE__INST0_SEG1                      0x00007E00
> +#define VCN_BASE__INST0_SEG2                      0x02403000
> +#define VCN_BASE__INST0_SEG3                      0
> +#define VCN_BASE__INST0_SEG4                      0
> +#define VCN_BASE__INST0_SEG5                      0
> +
> +#define VCN_BASE__INST1_SEG0                      0
> +#define VCN_BASE__INST1_SEG1                      0
> +#define VCN_BASE__INST1_SEG2                      0
> +#define VCN_BASE__INST1_SEG3                      0
> +#define VCN_BASE__INST1_SEG4                      0
> +#define VCN_BASE__INST1_SEG5                      0
> +
> +#define VCN_BASE__INST2_SEG0                      0
> +#define VCN_BASE__INST2_SEG1                      0
> +#define VCN_BASE__INST2_SEG2                      0
> +#define VCN_BASE__INST2_SEG3                      0
> +#define VCN_BASE__INST2_SEG4                      0
> +#define VCN_BASE__INST2_SEG5                      0
> +
> +#define VCN_BASE__INST3_SEG0                      0
> +#define VCN_BASE__INST3_SEG1                      0
> +#define VCN_BASE__INST3_SEG2                      0
> +#define VCN_BASE__INST3_SEG3                      0
> +#define VCN_BASE__INST3_SEG4                      0
> +#define VCN_BASE__INST3_SEG5                      0
> +
> +#define VCN_BASE__INST4_SEG0                      0
> +#define VCN_BASE__INST4_SEG1                      0
> +#define VCN_BASE__INST4_SEG2                      0
> +#define VCN_BASE__INST4_SEG3                      0
> +#define VCN_BASE__INST4_SEG4                      0
> +#define VCN_BASE__INST4_SEG5                      0
> +
> +#define VCN_BASE__INST5_SEG0                      0
> +#define VCN_BASE__INST5_SEG1                      0
> +#define VCN_BASE__INST5_SEG2                      0
> +#define VCN_BASE__INST5_SEG3                      0
> +#define VCN_BASE__INST5_SEG4                      0
> +#define VCN_BASE__INST5_SEG5                      0
> +
> +#define VCN_BASE__INST6_SEG0                      0
> +#define VCN_BASE__INST6_SEG1                      0
> +#define VCN_BASE__INST6_SEG2                      0
> +#define VCN_BASE__INST6_SEG3                      0
> +#define VCN_BASE__INST6_SEG4                      0
> +#define VCN_BASE__INST6_SEG5                      0
> +
> +#define VCN_BASE__INST7_SEG0                      0
> +#define VCN_BASE__INST7_SEG1                      0
> +#define VCN_BASE__INST7_SEG2                      0
> +#define VCN_BASE__INST7_SEG3                      0
> +#define VCN_BASE__INST7_SEG4                      0
> +#define VCN_BASE__INST7_SEG5                      0
> +
> +#endif
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
