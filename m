Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907CFC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26840611AE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26840611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801456E1B3;
	Fri, 14 May 2021 04:29:36 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD1D16E1B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:29:35 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 r26-20020a056830121ab02902a5ff1c9b81so25507941otp.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 21:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Z4tVapddlC6Dmt+7S/RfMAaLVz5DbAqJuAG5R6vexs4=;
 b=RlL9Lx9LxfIvA2SOOQmGPLS4rWReVqD2srrVaU7B8tYCWBO90RqjieNkXxLUGBvEuT
 nuHqg/Uga0wEwoEq5boQkQ7JJA1XL0lCS2nzUKT2Yc66oblCnSqjnQiOWxPQ1S5Kb09r
 NsGNGdsvJxJPAcThufSE9V5pf3r4o0IOdj4Cgyrvz+9E9qT7IFaoQyQGKWrQr8cSDl8O
 U1FaxMliO2LN+FwpAqaP38l2UhWdK6D6EI60fah4ylVbhF5LuArgr4hWa++HYO/wWkyt
 xK+7a25ZgA3iCgU4g7Scpst8Tlf0t7+rRDJ0X64dEH4+doQT8emEJJOXRhT7FeEHAvyL
 QmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Z4tVapddlC6Dmt+7S/RfMAaLVz5DbAqJuAG5R6vexs4=;
 b=mrG3ukB8qSIawoYwsApshqpFrJYDX0jOdxgTHaw+L69OFwAjzysNbR1SpfkX90n3rH
 IHHOgKWLSgVK+OfE/7gBIYbFDrdCweHGd75fP5Q1JkrX+zOi4aT9NlIWQJCNg0lkN5SF
 d6++9qYsPEMil/VFwTIu/yVfEvvdNQw7iSCuN7NBw+nw/TNtRRn3Aj+rFI/Q1jWhed0R
 0+B6/W5rzxq36zpPwHHz6POjht9fo1RFa8837Yz9Wj+qOD8R7a5ZDiO55VZ/4p1PYHmN
 VhOzKj/V7N6p4Z5lECP4lf+auqXqIEy4Dtp2NW3gfLonP2lvt0a9WGKSthWV5Ac4/M8y
 v/Jw==
X-Gm-Message-State: AOAM530uzOw4EUsf9Sf3fpfYYIb26X3fPCzYVPP64Nwiy+5iaAuvV8Zx
 2r1AXfHxwwVlubU9cZ3FxoqFi1QZEGu0bPVhzgI=
X-Google-Smtp-Source: ABdhPJwuNYZR4cIjvFqKFWg39i+o0T4K+hdjJMv+0Q7qpB3P5RELHtJaIEvOORoGV/EMQ6hY6r6GWDbt06rPFpaVCZ8=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr22558606otl.132.1620966575036; 
 Thu, 13 May 2021 21:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210512033451.19253-1-Jiawei.Gu@amd.com>
 <CH0PR12MB51569D72B2C29929B5BBB127F8509@CH0PR12MB5156.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB51569D72B2C29929B5BBB127F8509@CH0PR12MB5156.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 May 2021 00:29:24 -0400
Message-ID: <CADnq5_Mhpec7KVQ4VsNuOcvOAHoCtaLvPjcAv7EPO8vM0cnYBA@mail.gmail.com>
Subject: Re: [PATCH] add vbios info query
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 13, 2021 at 11:03 PM Gu, JiaWei (Will) <JiaWei.Gu@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Tom,
>
> Can you help review & merge this patch to bring vbios IOCTL usage in UMR back?
> The patch is also attached.

We need to wait until the kernel driver patch lands in upstream
drm-next (https://cgit.freedesktop.org/drm/drm/).  I haven't sent it
upstream yet because the ioctl is still in flux.  We still need to
sort out the pci id handling in the ioctl.

Alex


>
> Thanks in advance,
> Jiawei
>
> -----Original Message-----
> From: Jiawei Gu <Jiawei.Gu@amd.com>
> Sent: Wednesday, May 12, 2021 11:35 AM
> To: StDenis, Tom <Tom.StDenis@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> Subject: [PATCH] add vbios info query
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>  src/app/CMakeLists.txt             |  1 +
>  src/app/main.c                     |  8 +++++
>  src/app/vbios.c                    | 58 ++++++++++++++++++++++++++++++
>  src/lib/lowlevel/linux/query_drm.c | 11 ++++++
>  src/umr.h                          | 15 ++++++++
>  src/umrapp.h                       |  1 +
>  6 files changed, 94 insertions(+)
>  create mode 100644 src/app/vbios.c
>
> diff --git a/src/app/CMakeLists.txt b/src/app/CMakeLists.txt index ca7d46b..462e4fc 100644
> --- a/src/app/CMakeLists.txt
> +++ b/src/app/CMakeLists.txt
> @@ -35,6 +35,7 @@ add_library(umrapp STATIC
>    pp_table.c
>    navi10_ppt.c
>    read_metrics.c
> +  vbios.c
>    ${GUI_SOURCE}
>  )
>
> diff --git a/src/app/main.c b/src/app/main.c index 47ddb38..b484cf3 100644
> --- a/src/app/main.c
> +++ b/src/app/main.c
> @@ -825,6 +825,11 @@ int main(int argc, char **argv)
>                                 asic = get_asic();
>                         ih_self_test(asic);
>  #endif
> +               } else if (!strcmp(argv[i], "--vbios_info") || !strcmp(argv[i], "-vi")) {
> +                       if (!asic)
> +                               asic = get_asic();
> +                       if (umr_print_vbios_info(asic) != 0)
> +                               fprintf(stderr, "[ERROR]: Cannot print vbios info.\n");
>                 } else if (!strcmp(argv[i], "--help") || !strcmp(argv[i], "-h")) {
>                         printf("User Mode Register debugger v%s for AMDGPU devices (build: %s [%s]), Copyright (c) 2021, AMD Inc.\n"
>  "\n*** Device Selection ***\n"
> @@ -951,6 +956,9 @@ printf(
>         "\n\t\tPrint the GPU metrics table for the device."
>  "\n\t--power, -p \n\t\tRead the conetent of clocks, temperature, gpu loading at runtime"
>         "\n\t\toptions 'use_colour' to colourize output \n");
> +printf(
> +"\n*** Video BIOS Information ***\n"
> +"\n\t--vbios_info, -vi \n\t\tPrint Video BIOS information\n");
>
>  #if UMR_GUI
>  printf(
> diff --git a/src/app/vbios.c b/src/app/vbios.c new file mode 100644 index 0000000..98e0f87
> --- /dev/null
> +++ b/src/app/vbios.c
> @@ -0,0 +1,58 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: Tom St Denis <tom.stdenis@amd.com>
> + *
> + */
> +#include "umrapp.h"
> +
> +#define AMDGPU_INFO_VBIOS                      0x1B
> +#define AMDGPU_INFO_VBIOS_INFO                 0x3
> +int umr_print_vbios_info(struct umr_asic *asic) {
> +       char fname[64];
> +       int r;
> +       struct umr_vbios_info vbios_info;
> +
> +       if (asic->fd.drm < 0) {
> +               snprintf(fname, sizeof(fname)-1, "/dev/dri/card%d", asic->instance);
> +               asic->fd.drm = open(fname, O_RDWR);
> +       }
> +
> +       r = umr_query_drm_vbios(asic, AMDGPU_INFO_VBIOS, AMDGPU_INFO_VBIOS_INFO,
> +                       &vbios_info, sizeof(vbios_info));
> +       if (r)
> +               return r;
> +
> +       printf("vbios name          : %s\n", vbios_info.name);
> +       printf("vbios dbdf          : 0x%x\n", vbios_info.dbdf);
> +       printf("vbios pn            : %s\n", vbios_info.vbios_pn);
> +       printf("vbios version       : %d\n", vbios_info.version);
> +       printf("vbios date          : %s\n", vbios_info.date);
> +       printf("vbios serial        : %lld\n", vbios_info.serial);
> +       printf("vbios dev_id        : 0x%x\n", vbios_info.dev_id);
> +       printf("vbios rev_id        : 0x%x\n", vbios_info.rev_id);
> +       printf("vbios sub_dev_id    : 0x%x\n", vbios_info.sub_dev_id);
> +       printf("vbios sub_ved_id    : 0x%x\n", vbios_info.sub_ved_id);
> +
> +       close(asic->fd.drm);
> +       return 0;
> +}
> \ No newline at end of file
> diff --git a/src/lib/lowlevel/linux/query_drm.c b/src/lib/lowlevel/linux/query_drm.c
> index d0c82d4..f4ab709 100644
> --- a/src/lib/lowlevel/linux/query_drm.c
> +++ b/src/lib/lowlevel/linux/query_drm.c
> @@ -49,7 +49,18 @@ int umr_query_drm(struct umr_asic *asic, int field, void *ret, int size)
>         inf.return_size = size;
>         inf.query = field;
>         return ioctl(asic->fd.drm, DRM_IOC(DRM_IOC_WRITE, DRM_IOCTL_BASE, DRM_COMMAND_BASE + DRM_AMDGPU_INFO, sizeof(inf)), &inf);
> +}
>
> +int umr_query_drm_vbios(struct umr_asic *asic, int field, int type,
> +void *ret, int size) {
> +       struct drm_amdgpu_info inf;
> +
> +       memset(&inf, 0, sizeof inf);
> +       inf.return_pointer = (uintptr_t)ret;
> +       inf.return_size = size;
> +       inf.query = field;
> +       inf.vbios_info.type = type;
> +       return ioctl(asic->fd.drm, DRM_IOC(DRM_IOC_WRITE, DRM_IOCTL_BASE,
> +DRM_COMMAND_BASE + DRM_AMDGPU_INFO, sizeof(inf)), &inf);
>  }
>
>  #else
> diff --git a/src/umr.h b/src/umr.h
> index 4e730e5..41266e2 100644
> --- a/src/umr.h
> +++ b/src/umr.h
> @@ -973,6 +973,7 @@ void umr_free_asic(struct umr_asic *asic);  void umr_free_maps(struct umr_asic *asic);  void umr_close_asic(struct umr_asic *asic); // call this to close a fully open asic  int umr_query_drm(struct umr_asic *asic, int field, void *ret, int size);
> +int umr_query_drm_vbios(struct umr_asic *asic, int field, int type,
> +void *ret, int size);
>  void umr_enumerate_devices(void);
>  int umr_update(struct umr_asic *asic, char *script);  int umr_update_string(struct umr_asic *asic, char *sdata); @@ -1349,6 +1350,20 @@ struct umr_soc15_database {
>         struct umr_soc15_database *next;
>  };
>
> +// vbios
> +struct umr_vbios_info {
> +       uint8_t name[64];
> +       uint32_t dbdf;
> +       uint8_t vbios_pn[64];
> +       uint32_t version;
> +       uint8_t date[32];
> +       uint64_t serial;
> +       uint32_t dev_id;
> +       uint32_t rev_id;
> +       uint32_t sub_dev_id;
> +       uint32_t sub_ved_id;
> +};
> +
>  FILE *umr_database_open(char *path, char *filename);  struct umr_soc15_database *umr_database_read_soc15(char *path, char *filename);  void umr_database_free_soc15(struct umr_soc15_database *soc15); diff --git a/src/umrapp.h b/src/umrapp.h index 14457fe..1336e07 100644
> --- a/src/umrapp.h
> +++ b/src/umrapp.h
> @@ -57,5 +57,6 @@ void umr_clock_scan(struct umr_asic *asic, const char* clock_name);  void umr_clock_manual(struct umr_asic *asic, const char* clock_name, void* value);  int umr_print_pp_table(struct umr_asic *asic, const char* param);  int umr_print_gpu_metrics(struct umr_asic *asic);
> +int umr_print_vbios_info(struct umr_asic *asic);
>
>  void run_server_loop(const char *url, struct umr_asic * asic);
> --
> 2.17.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
