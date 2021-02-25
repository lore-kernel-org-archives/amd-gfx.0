Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C569FC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 18:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CD764E6C
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 18:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CD764E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 157716E048;
	Thu, 25 Feb 2021 18:32:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770081.outbound.protection.outlook.com [40.107.77.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 720DC6E048
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 18:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ue8eXBBXmzo1sipMBY9BjxkEvvbsKPMKUZPXN2VTqBv4E7FFJuZLZ6/C+pxrvJqjNwwonWs8xv1yjVp6POm+nbq/4D+tJ7xPTH7wQrEbdlrMIp1uC5ANgelVPOdW+HF72ZTr8I27vDVaa1PnHrl8Mtm/0qXo3KYAIRcaz3OvywlrUBqAsk5RblPylc6zx68s70T37ykibeqqWjSDf4cHGiUjKp1zVBeP8HuwDCCAzBLJqQBseFsgK/EVN6/lsdRu71jDhBwW2yYb5tJTiJGq4FRrO5QHtQdq6n5RIYWFwqxDMo3bd/Q/hwbhsIQIsmLBotJjv9wORdFS3K9Z2jBHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/GZbYJXBc36LajkFv33C+Mjxg/n9CmRyskvCcXu3Ms=;
 b=cZEKOq4tUcNyFiJiyQOiGO63/yN/qqdnk4eak/L+gVyhjHH13nVsqK/yLzfvtwaBTOoqkJWZkzyo2yYTs4Qu125ASb2JnmAnou5ofj8Z6H6ZuDWS3Ra6Mf/BDcxXo9y2xky+wg2stYu6bxe6VeCrTbzepyXW51xeaS4y95sfHgnRWiT9zehl6z+NhwLIXdBPYw4Zk8rujwE+tkcP+Cnc800gKMTF+0WMilrCUzk/DBSguO0YEnCkRn08a+oDzol/NmRrw3ey3tL0beg/bMF/E9iU4XN2VbVZfh/FMRLWbzhIUPkFMdp7VAB0sFnbzrQDR7eH/BnZ5THHCBU95ki0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/GZbYJXBc36LajkFv33C+Mjxg/n9CmRyskvCcXu3Ms=;
 b=fv60ZDQKzo1J5MqGUHFQX3S5RTI3mab4/NQmEuOdPEnd5mAh5N1UTwnRONV+VcKyEx7m7HkArUrKcBwNgmp4xPUZQWGbXKBqVvPMR8YplpI9mSybflwWRj7u0G+IOw95pd/eTBTBA1LjC4XQTLu+/wf8ty/dZFh2jaTfqY5k58s=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4612.namprd12.prod.outlook.com (2603:10b6:208:8f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 18:32:41 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 18:32:41 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 147/159] drm/amdgpu: restore aldebaran save ttmp and trap
 config on init (v2)
Thread-Topic: [PATCH 147/159] drm/amdgpu: restore aldebaran save ttmp and trap
 config on init (v2)
Thread-Index: AQHXCvtVXHbbLH7qSU6iK2tMV55TE6poNQkAgAD9kMo=
Date: Thu, 25 Feb 2021 18:32:40 +0000
Message-ID: <MN2PR12MB44887E992CA47D875CEF9390F79E9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
 <20210224221859.3068810-140-alexander.deucher@amd.com>,
 <0b302303-9964-5c82-3722-33c5d66cde1b@amd.com>
In-Reply-To: <0b302303-9964-5c82-3722-33c5d66cde1b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-25T18:32:39.322Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa960413-2e45-4ff0-abd2-08d8d9bbbc11
x-ms-traffictypediagnostic: BL0PR12MB4612:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4612503EC9AA068EA1E44B9EF79E9@BL0PR12MB4612.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:363;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ZvVxoUMfnK0eJdJ5zkeTW9vjKDiDURyTZ8/K45KD9j0Fi3J8DHKbpP4TxCd8HsaiMLipKrdEIXxLt1zttRKLYwQC60xQQ3gT9H+Vv3+JGclp9gD7Pb4q/QsGqrQanDfgIvMxZ0gN6muyvLO9u0++jbYDxhytU1W1xWXVlvZUemF7ujeQfonS7alJw9ZOut4J219BO0305JTc3pn3c5foD66fDEbhfiYBmqlBe6hKp6uR78CicQ/+z40WM3oPGYykuOnHuz4Ysi1QtuPIkwIoGqlJLcbri+uRmZYP1HWpapcUGtTV2KGt97NkwoUBDNkUP6ItxGdykEOnXiQ6I3W849Fs/hSjPB9cFBxvm7Chu1wPY7eKQKdaSeyfgo3u1HYe3FMOaqaXRDv3WzfwpBQwKbbu2V0ZtzNtsM3lRSOekt/57udRfgiT6+76CHQnHe6lTSF2cuB1RsfWrxgInVm3ryeSyJJ4Uew+XjK+GtNJ0ykYpCENgAYFZ3Jk8CAwlgBUtxpFJtDOpsp3pPsVwTEuw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(316002)(55016002)(110136005)(5660300002)(8676002)(4326008)(83380400001)(66446008)(19627405001)(7696005)(478600001)(9686003)(71200400001)(76116006)(6506007)(52536014)(2906002)(26005)(86362001)(8936002)(33656002)(66556008)(53546011)(186003)(66476007)(64756008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+qzn5W2d1zSUl3Uex1JIkVbViby2x+BAv8ywrhHtJwsQabtdvkFUMCief0hc?=
 =?us-ascii?Q?HZZip0GejS9UtKC+p/hwvf82LrVkIiy/RmowiQXe+JhcrtUmgs1yCmIzqXr9?=
 =?us-ascii?Q?52sYXQB38pddeoBMA1jKYChEgQWDT9/fCNruGEaZaTokBhP4kuGNbv8Iu0G/?=
 =?us-ascii?Q?rCoAzUPbzWuZ2/+T0foSyw+kilbc0k2Xsvw1cmymI6bxmMidSeKvt4R/omBM?=
 =?us-ascii?Q?ZcER46J231+hpH3tqACHTV9reYiHM6pMDr7QnzYexHJwugJCeq7RblmYH7H7?=
 =?us-ascii?Q?LY1pXocFJ4pJgjfH7sEtQFps6BLXBVWJXgPlNWOsKC0gCMoxtpRnevs+qAy1?=
 =?us-ascii?Q?NISWMVyGuNvk3Mp4Pc4dulpKTrawG7lb2K3A2e8SaGjfSOMKi31MfTBb7BEX?=
 =?us-ascii?Q?AInGQOfn2i/8ff6QHeJ3wRKXv36PXsIMUsZ0tEBumvzxz+RsZGSe9DjQz3MC?=
 =?us-ascii?Q?mSeTFHllhAu8RYR7yApzqoK3jL4N47Un+XxfxjlhAFwi10MU3sQeXRfZCsQn?=
 =?us-ascii?Q?YAydrpjJoTj4+h7dCqEjcHhvpUXf/G4XQP6KzutMJGHUxe1x7yrD31veV4my?=
 =?us-ascii?Q?EKN4w5xPyOYJZXigCJPt3YH9ggX8YoyPtWuOJXxYRqop7KsCVUUcW2+2SfND?=
 =?us-ascii?Q?pq7gyEu4SxFJZP0qGguN7rOJpeTPVDMo+evuEjihfhRTH0tlVCdR3Fxh7M8s?=
 =?us-ascii?Q?f5+BVNPUKfwRbmaYi6IRrogrePKSa+SfcuI/5dyaucel18X9wth5A8WcSffQ?=
 =?us-ascii?Q?tNmWMVuJ5Ts0MJPybUlSIugDeEaawRe8BCxORunKCmPaBTGRd1FaAdgsfBBQ?=
 =?us-ascii?Q?KA3DWOliJ4HES3HLnamA2DTCdqMXZLShCv7FEUX1gODJoVTIvNKlQJL/1kF/?=
 =?us-ascii?Q?9dmd4/GbEOkw7uW5jEIOrzXlU5Hshy/Nx8jzFRHMY1crhh6wfwvVcyoEBcXI?=
 =?us-ascii?Q?PD1GqVIIVtK2Q+9vToMO/EcSCPNANBS1w1zUditEs2jzgK8Y7mI6hOs9DqH3?=
 =?us-ascii?Q?wu/77t9910tvKGDwGq0WKLwNCOGavN4KN4yfHvLpvq4jUQXrPR+D++9rHAFs?=
 =?us-ascii?Q?6xZzQNpslnbOM6nkSywr8KhuTSYUUaSA6ItmX+il45bLY99UMVLjjxgM/imV?=
 =?us-ascii?Q?jmqT45CbiyUBU7sC5m1NdnPh5Tmgm82QMJhcIHl9z4HGis+H3hfYi7uY0VAL?=
 =?us-ascii?Q?QgUHM1W1A6trBamjZ6gq6MYjgQYCu1b9dl7Yih5MRMLF4AzyXJJ2W/Cw8zxO?=
 =?us-ascii?Q?q2w97jkT3ga9AgC47cBBMoqRlI1k3lXJIV3U/Z6+4rJryKi0R/RbXCWnEBuU?=
 =?us-ascii?Q?Tsvd9zvsiFa1SOv019IbiDNt?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa960413-2e45-4ff0-abd2-08d8d9bbbc11
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 18:32:40.8867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npJItxQj7kRmPrKjwzz8bL3K8t2lzezm3PnPCk7310+vvUIpyYMqD01B2jX65vOE+Rqy28HVhtC6R1uAzXf02A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4612
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
Cc: "Kim, Jonathan" <Jonathan.Kim@amd.com>
Content-Type: multipart/mixed; boundary="===============0590851270=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0590851270==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44887E992CA47D875CEF9390F79E9MN2PR12MB4488namp_"

--_000_MN2PR12MB44887E992CA47D875CEF9390F79E9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

I dropped the KFD debugger hunks and just added the gfx 9.4.2 changes since=
 these were required for a bunch of later patches that build on that file t=
hat are not dependent on debugger.  I can rework the commit message if you'=
d like.

Alex

________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, February 24, 2021 10:22 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Cc: Kim, Jonathan <Jonathan.Kim@amd.com>
Subject: Re: [PATCH 147/159] drm/amdgpu: restore aldebaran save ttmp and tr=
ap config on init (v2)

This patch is for the debugger functionality that's not on
amd-staging-drm-next yet. You can probably drop this patch for now.

Regards,
   Felix

On 2021-02-24 5:18 p.m., Alex Deucher wrote:
> From: Jonathan Kim <Jonathan.Kim@amd.com>
>
> Initialization of TRAP_DATA0/1 is still required for the debugger to dete=
ct
> new waves on Aldebaran.  Also, per-vmid global trap enablement may be
> required outside of debugger scope so move to init phase.
>
> v2: just add the gfx 9.4.2 changes (Alex)
>
> Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile     |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 50 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h | 30 +++++++++++++++
>   4 files changed, 82 insertions(+)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index c5ec926bc6d5..741b68874e53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -123,6 +123,7 @@ amdgpu-y +=3D \
>        gfx_v8_0.o \
>        gfx_v9_0.o \
>        gfx_v9_4.o \
> +     gfx_v9_4_2.o \
>        gfx_v10_0.o
>
>   # add async DMA block
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 5bac5659e707..78bb4e28c27c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -49,6 +49,7 @@
>
>   #include "gfx_v9_4.h"
>   #include "gfx_v9_0.h"
> +#include "gfx_v9_4_2.h"
>
>   #include "asic_reg/pwr/pwr_10_0_offset.h"
>   #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_2.c
> new file mode 100644
> index 000000000000..0c2ccbe327ab
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> @@ -0,0 +1,50 @@
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include "amdgpu.h"
> +#include "soc15.h"
> +
> +#include "gc/gc_9_4_2_offset.h"
> +#include "gc/gc_9_4_2_sh_mask.h"
> +
> +void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
> +                             uint32_t first_vmid,
> +                             uint32_t last_vmid)
> +{
> +     uint32_t data;
> +     int i;
> +
> +     mutex_lock(&adev->srbm_mutex);
> +
> +     for (i =3D first_vmid; i < last_vmid; i++) {
> +             data =3D 0;
> +             soc15_grbm_select(adev, 0, 0, 0, i);
> +             data =3D REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_E=
N, 1);
> +             data =3D REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_E=
N, 0);
> +             data =3D REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_R=
EPLACE,
> +                                     0);
> +             WREG32(SOC15_REG_OFFSET(GC, 0, regSPI_GDBG_PER_VMID_CNTL), =
data);
> +     }
> +
> +     soc15_grbm_select(adev, 0, 0, 0, 0);
> +     mutex_unlock(&adev->srbm_mutex);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_2.h
> new file mode 100644
> index 000000000000..5b175c10de23
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __GFX_V9_4_2_H__
> +#define __GFX_V9_4_2_H__
> +
> +void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
> +                             uint32_t first_vmid, uint32_t last_vmid);
> +
> +#endif /* __GFX_V9_4_2_H__ */

--_000_MN2PR12MB44887E992CA47D875CEF9390F79E9MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I dropped the KFD debugger hunks and just added the gfx 9.4.2 changes since=
 these were required for a bunch of later patches that build on that file t=
hat are not dependent on debugger.&nbsp; I can rework the commit message if=
 you'd like.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 24, 2021 10:22 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 147/159] drm/amdgpu: restore aldebaran save ttmp=
 and trap config on init (v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch is for the debugger functionality that'=
s not on
<br>
amd-staging-drm-next yet. You can probably drop this patch for now.<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
On 2021-02-24 5:18 p.m., Alex Deucher wrote:<br>
&gt; From: Jonathan Kim &lt;Jonathan.Kim@amd.com&gt;<br>
&gt;<br>
&gt; Initialization of TRAP_DATA0/1 is still required for the debugger to d=
etect<br>
&gt; new waves on Aldebaran.&nbsp; Also, per-vmid global trap enablement ma=
y be<br>
&gt; required outside of debugger scope so move to init phase.<br>
&gt;<br>
&gt; v2: just add the gfx 9.4.2 changes (Alex)<br>
&gt;<br>
&gt; Signed-off-by: Jonathan Kim &lt;Jonathan.Kim@amd.com&gt;<br>
&gt; Reviewed-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp; |&nbsp; =
1 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 50 +++++++++++++=
++++++++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h | 30 +++++++++++++=
++<br>
&gt;&nbsp;&nbsp; 4 files changed, 82 insertions(+)<br>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c=
<br>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h=
<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd=
/amdgpu/Makefile<br>
&gt; index c5ec926bc6d5..741b68874e53 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/Makefile<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
&gt; @@ -123,6 +123,7 @@ amdgpu-y +=3D \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0.o \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0.o \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_4.o \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_4_2.o \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0.o<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; # add async DMA block<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v9_0.c<br>
&gt; index 5bac5659e707..78bb4e28c27c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; @@ -49,6 +49,7 @@<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #include &quot;gfx_v9_4.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;gfx_v9_0.h&quot;<br>
&gt; +#include &quot;gfx_v9_4_2.h&quot;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #include &quot;asic_reg/pwr/pwr_10_0_offset.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;asic_reg/pwr/pwr_10_0_sh_mask.h&quot;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm=
/amd/amdgpu/gfx_v9_4_2.c<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..0c2ccbe327ab<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c<br>
&gt; @@ -0,0 +1,50 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2020 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + */<br>
&gt; +#include &quot;amdgpu.h&quot;<br>
&gt; +#include &quot;soc15.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;gc/gc_9_4_2_offset.h&quot;<br>
&gt; +#include &quot;gc/gc_9_4_2_sh_mask.h&quot;<br>
&gt; +<br>
&gt; +void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t first_vmid,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t last_vmid)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;srbm_mutex);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D first_vmid; i &lt; last_vmid; i++=
) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; soc15_grbm_select(adev, 0, 0, 0, i);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data =3D REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data =3D REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data =3D REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(SOC15_REG_OFFSET(GC, 0, regSPI_GDBG_PER_VMID_CNTL), data);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; soc15_grbm_select(adev, 0, 0, 0, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;srbm_mutex);<br>
&gt; +}<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm=
/amd/amdgpu/gfx_v9_4_2.h<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..5b175c10de23<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h<br>
&gt; @@ -0,0 +1,30 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2020 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef __GFX_V9_4_2_H__<br>
&gt; +#define __GFX_V9_4_2_H__<br>
&gt; +<br>
&gt; +void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t first_vmid, uint32_t last_vmid);<br>
&gt; +<br>
&gt; +#endif /* __GFX_V9_4_2_H__ */<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44887E992CA47D875CEF9390F79E9MN2PR12MB4488namp_--

--===============0590851270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0590851270==--
