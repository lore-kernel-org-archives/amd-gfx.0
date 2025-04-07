Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27452C36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 12:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB69C10E110;
	Mon,  7 Apr 2025 12:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dr1kKAHb";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 955CA10E110
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 12:56:49 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2ff67f44fcaso861766a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 05:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744030609; x=1744635409; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3fWyf7J/U3omOXCZFHfLpOYb/EaDM05ySNlpC03QJ4o=;
 b=dr1kKAHb8gqNVN1zdksd0Ex6gBV9R29X2P1synjH0ZApZYeIiYSLohvmcgRxKhecBx
 PKZC8x4Jq/dGMk/oSO+0olmH2pWc4VWceCmgAwl19etfB6Lo1ISOdM7LGCtDZ7JiAzJX
 J4MITjoM5nSO7W6e2EDDJZ4A5LxYvUDWD5g95yPc/fOX11I0QEYBOEwgc4J2vhz0SXDY
 9oBgx8b252W5VbiL4VQvpPE+0ri3SpJluae9pWN1uugE7PWSOaZVN2vpX3RDvC6Wke4N
 SO8tvZz3553ppb3kckYotLje+2VxBwJ0FZd6XtHlSSecMgYUlP+WgR9Qv/OhFhe20K0m
 Bpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744030609; x=1744635409;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3fWyf7J/U3omOXCZFHfLpOYb/EaDM05ySNlpC03QJ4o=;
 b=BsKq0D1jouwSqgNVUqgfXBr27BsN+DZznbGX3gmJ9oRoxNgGwawumVEY5/GsluRlOq
 TREQ9C0H+LvRaEDXheYtYI9ECgAFOdppTCynLN9jkyfRXNSmOYoZRsAJtkIDff6PS+N+
 +LO6GglBd/0CkLghtI4s5DSd/rFYhi3VE38xRl1Sge9D8315Z3EW43URvXC0b7EP5fZP
 Z3sJ9kBi1ePymQLWduPI4DSH0S+vyXSEC89dxldFRxcCbg+G9A1R6JQgXRzakQ4yPafr
 PWc53i4t/bVmLg6TvkzRgWl0rhFZ5XQZfNE1u9DeDCGCwRQrGzeMC1v02hOF/9iJHzx5
 ZBhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8/s/dEYIR5j5ZZSe93gIRGRDQeOPBK7pjV0MuNz3bS+OfOYmn5D0IThf624ulLj6fOcFyb7Mh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyumCy96Y7lJVXBdUS1fadytzpU+j7jUSQsLXzIpUFPvQmpRKOI
 62yvNayMr0VuD24LlihTjtT35WzSiLtd4Vdf4lO4/1Hjd+v7DTJDb8OABQ7VTKhuXbwV9WJOM+u
 B6CVGA1EeM5bz7m7ENMq1A9mgAeGbchAS
X-Gm-Gg: ASbGncuODHKdKvQKgzA2HN1CmMjyS1MOOd5OJUMTWswq8OLNBJGVIrRnygNVw7Rclw2
 Q2B5hdqEqLzOEThLNkiDYcU25NVcvREPAcawajTj6oDGzikxe+lByXeHGJUGkqfkJaXdwsbYEX/
 5FW6PgYgzde5N3ZSYVHsI4GP/JCA==
X-Google-Smtp-Source: AGHT+IHtBXCgA6g+tAc67qY8hCEHtzxEFPmGuOaBD/3lItAjzmOiNN10d8Hd9vwa8QgmcExBdDKBqUCW5cbWqTzufeU=
X-Received: by 2002:a17:90b:4ac7:b0:2ff:4be6:c5e2 with SMTP id
 98e67ed59e1d1-306a49aafa0mr5451942a91.7.1744030609038; Mon, 07 Apr 2025
 05:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250320165634.1245798-1-alexander.deucher@amd.com>
 <CADnq5_O1TWAx9neJmNtAQ+kmn+85NHsfzoMr5P_fbz=ZRNpoHw@mail.gmail.com>
 <04635121-c8ca-42ba-a56b-20357702c929@amd.com>
In-Reply-To: <04635121-c8ca-42ba-a56b-20357702c929@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 08:56:37 -0400
X-Gm-Features: ATxdqUH47VdEbmxrOSc_loGCI1WqDbbaYjtBBy6w78_FjVCac2CeO9GmOF2Pw4I
Message-ID: <CADnq5_OZCnYtfMPKN1CH4nDLEJsfpQvnSxLPJE=EjH9C=N_vJA@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx9: dump full CP packet header FIFOs
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Apr 7, 2025 at 6:14=E2=80=AFAM Khatri, Sunil <sukhatri@amd.com> wro=
te:
>
>
> On 3/25/2025 1:18 AM, Alex Deucher wrote:
>
> ping on this series?
>
> Alex
>
> On Thu, Mar 20, 2025 at 12:57=E2=80=AFPM Alex Deucher <alexander.deucher@=
amd.com> wrote:
>
> In dev core dump, dump the full header fifo for
> each queue. Each FIFO has 8 entries.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 62 +++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index f4dfa1418b740..64342160ff7d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -225,17 +225,36 @@ static const struct amdgpu_hwip_reg_entry gc_reg_li=
st_9[] =3D {
>         SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
>         SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
>         SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
> -       /* cp header registers */
> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME2_HEADER_DUMP),
> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>         /* SE status registers */
>         SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
>         SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE1),
>         SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE2),
> -       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3),
> +       /* packet headers */
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>
> Reading this register in a loop will give value of each queue or we are r=
eading same register again and again ?

The register is an accessor for the header FIFO in the queue hardware.
The FIFO is 8 entries deep so if you read the register 8 times, you
can dump the full FIFO.

> for (i =3D 0; i < reg_count; i++)
>                 adev->gfx.ip_dump_core[i] =3D RREG32(SOC15_REG_ENTRY_OFFS=
ET(gc_reg_list_9[i])); With above loop arent we reading same offset again f=
or
>
> mmCP_CE_HEADER_DUMP,mmCP_PFP_HEADER_DUMP and mmCP_ME_HEADER_DUMP 8 times.=
 How are we making sure we are reading from different queues ?

The me/pipes/queues are indexed via soc15_grbm_select().

Alex

>
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP)
>  };
>
>  static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] =3D {
> @@ -277,6 +296,14 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_=
list_9[] =3D {
>         SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
>         SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
>         SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GFX_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP)
>  };
>
>  enum ta_ras_gfx_subblock {
> @@ -7340,9 +7367,14 @@ static void gfx_v9_ip_print(struct amdgpu_ip_block=
 *ip_block, struct drm_printer
>                         for (k =3D 0; k < adev->gfx.mec.num_queue_per_pip=
e; k++) {
>                                 drm_printf(p, "\nmec %d, pipe %d, queue %=
d\n", i, j, k);
>                                 for (reg =3D 0; reg < reg_count; reg++) {
> -                                       drm_printf(p, "%-50s \t 0x%08x\n"=
,
> -                                                  gc_cp_reg_list_9[reg].=
reg_name,
> -                                                  adev->gfx.ip_dump_comp=
ute_queues[index + reg]);
> +                                       if (i && gc_cp_reg_list_9[reg].re=
g_offset =3D=3D mmCP_MEC_ME1_HEADER_DUMP)
> +                                               drm_printf(p, "%-50s \t 0=
x%08x\n",
> +                                                          "mmCP_MEC_ME2_=
HEADER_DUMP",
> +                                                          adev->gfx.ip_d=
ump_compute_queues[index + reg]);
> +                                       else
> +                                               drm_printf(p, "%-50s \t 0=
x%08x\n",
> +                                                          gc_cp_reg_list=
_9[reg].reg_name,
> +                                                          adev->gfx.ip_d=
ump_compute_queues[index + reg]);
>                                 }
>                                 index +=3D reg_count;
>                         }
> @@ -7379,9 +7411,13 @@ static void gfx_v9_ip_dump(struct amdgpu_ip_block =
*ip_block)
>                                 soc15_grbm_select(adev, 1 + i, j, k, 0, 0=
);
>
>                                 for (reg =3D 0; reg < reg_count; reg++) {
> -                                       adev->gfx.ip_dump_compute_queues[=
index + reg] =3D
> -                                               RREG32(SOC15_REG_ENTRY_OF=
FSET(
> -                                                       gc_cp_reg_list_9[=
reg]));
> +                                       if (i && gc_cp_reg_list_9[reg].re=
g_offset =3D=3D mmCP_MEC_ME1_HEADER_DUMP)
> +                                               adev->gfx.ip_dump_compute=
_queues[index + reg] =3D
> +                                                       RREG32(SOC15_REG_=
OFFSET(GC, 0, mmCP_MEC_ME2_HEADER_DUMP));
> +                                       else
> +                                               adev->gfx.ip_dump_compute=
_queues[index + reg] =3D
> +                                                       RREG32(SOC15_REG_=
ENTRY_OFFSET(
> +                                                                      gc=
_cp_reg_list_9[reg]));
>
> When value of (i !=3D 0), arent we reading same register i.e mmCP_MEC_ME1=
_HEADER_DUMP 8 times, how are we making sure when we read it again its read=
ing for another queue ?
>
> Regards
> Sunil Khatri
>
>                                 }
>                                 index +=3D reg_count;
>                         }
> --
> 2.49.0
>
