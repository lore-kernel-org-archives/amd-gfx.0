Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FD3C3600C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 19:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C633C10E4D1;
	Mon, 24 Mar 2025 19:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AjUa+gcq";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCE2510E4D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 19:48:48 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3032a9c7cfeso846915a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742845728; x=1743450528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+yltvB0LjPSIwNTJ8KCk8h4Ua+EN8wzDRdr07URdWk=;
 b=AjUa+gcq6XyPXkOQQn3B4N3myJtWQt8nZIS7Dooo7UK4C9KRCla290dt3ANWcxmmzL
 5hCNGzMbf343CaCpdMco6mag4RuKNMnyL8NxFEO73wpUwIct5DfmZC7n0yJgxpUglucb
 vtTRlg4w/G9rvhg+zU8c/4R9fI5vD5Jo79ufrlNUe3PpzI1TPZafQqpOXoqdQqGXYMtj
 XH2sm8E0RbbNrOXKtHCuLAtv3nf/61I48H65iESYsltKZZeXZL3daD/2Q62iutZRUYJr
 uy+sZB+u6tNBErP71i909c3ehbE7GdUO4JVh/d02FiTO9l7gauxCGoacPsfqyiRXL6UM
 cipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742845728; x=1743450528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+yltvB0LjPSIwNTJ8KCk8h4Ua+EN8wzDRdr07URdWk=;
 b=HDRRpPQCIuKj5d6Cisctw9Z7BazwfmZujprosn494cD2WpglFVRF0iWX4fR4W5XzSv
 fj1NKUgCH0tSTPq/b8qjWfJ7mbJRqtse+3V2J4IOmcG+Sk1j5MeH7DbozJjhX1yvb2zz
 PwfVQHHdhfw6dQscH8Tk+IWIldHen4e99qoaXwNbVae8PWhLI19FXpNRmt/+bLFrOCB4
 y57ftdiG+cBn3YwD+2jATp5GOjmi8PI91b0/gAo7NVj0KcrSFRZdevm83+fiJuzYWI1l
 Nd+hyexVWOmIdBdh94QJnNB2SXinRYM+N4KHEMViusciLOHBwbaL9MbWVO7L1K73mxMb
 6kXw==
X-Gm-Message-State: AOJu0Ywnv+Wsuq5/02p04HGdQZcQA1JT71QKWNqDXhMLTHKsaQrJXY5Y
 X5IdqO+pMhIf5smMBgFFGp8j3sD2G6jrKOnJkZbTEA14DkHLIXw0c8MbGdM/mHSARoPsjjm+dtx
 MZ7nYgIdmpZ70xdkwV7UANN5f7oAT8Q==
X-Gm-Gg: ASbGncsPHpbiU0GenooFTGrWVzrR1hpG+3aaV86eesHWliwZ6t3oV6CKP0rkXYgriyh
 RGWB5mOn28Ska6NgnGclEAK39E6uwrn2niUrc6tDX14bTXax3hE8il4QRlQYXglrZvko1rGafnA
 a7BCdBjGyLy6nEZdKQdRveAwV8Hg==
X-Google-Smtp-Source: AGHT+IFcz5RqV9119T2w9Qb7eZVH5EE1YTEZCmCqgDzsNyqx7HopA8ip7nR3k4B8OB74ynApd/5ftWyuw7tgx2embjw=
X-Received: by 2002:a17:90b:1b49:b0:301:ba2b:3bc6 with SMTP id
 98e67ed59e1d1-3036b4d6c5bmr96962a91.7.1742845728053; Mon, 24 Mar 2025
 12:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250320165634.1245798-1-alexander.deucher@amd.com>
In-Reply-To: <20250320165634.1245798-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 15:48:35 -0400
X-Gm-Features: AQ5f1Jpn-1qcK5ggim7xQD6-hpG3Hwmk2swzaywjGYsqYenksnwzzMtSa5dtEC4
Message-ID: <CADnq5_O1TWAx9neJmNtAQ+kmn+85NHsfzoMr5P_fbz=ZRNpoHw@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx9: dump full CP packet header FIFOs
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

ping on this series?

Alex

On Thu, Mar 20, 2025 at 12:57=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
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
>                                 }
>                                 index +=3D reg_count;
>                         }
> --
> 2.49.0
>
