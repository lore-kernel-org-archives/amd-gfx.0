Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45707C3601E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 13:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC8B610E45B;
	Mon,  7 Apr 2025 13:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b09VZJk4";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE24810E45B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 13:45:48 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-af8cb6258bcso237698a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 06:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744033548; x=1744638348; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73l+K7kg9sq1CZjWsw1UTv5iAr4gfua7f/DgFuraif0=;
 b=b09VZJk45lPFiP/wuVgmLHJqWwCIM7MC1JRaPJlklxhi1HEI3KABU1OAwHoXWLmjaI
 o0W0XGg+8hBUMjCTyFzMqUxBiwvGBOxxKIxTBJEK+IxyKuFcxshixOhV5tWk/F8eMbY5
 oH90104WYumqAfE7hm9TWiMSjULV8V63WAoFrplp9GOrGrhax7xyQrwD/yeDqh7O2GF4
 3VoezZj3z2FVaj2Sh+Sqq2zutNJ+HgEXQvPI/zslBa28sNQrLFosPY6wiEpMFKi6LJEy
 i5gk3+TEJkT4KduArGmgR6yVeWdMPdZD5AoM30qYbXygTI2DRiwgUO2opKWg7eFKW98M
 jVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744033548; x=1744638348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=73l+K7kg9sq1CZjWsw1UTv5iAr4gfua7f/DgFuraif0=;
 b=RxalJpYsxCBkJhU5L0t4ZrMkfumSwbGduy0PyapqL1o0I6PvXVgwEjZNVg1PAEpdsI
 x+/cQUr+nWCSRIxUm/VsJRHEYyuW62AbYNd9zmVzUvkD1ex6xBkyO/fffOQVZam5Dmwn
 5g/19iX0/OPDvEPabev7Z2E0mfLDRv8zOVEJYFaOGuSZe9kl+HyFUZ//obWeENUWnsJs
 Jm6kooKlWCpaIx8yyi2hHDu9wVxV2kVezU2/IoZEeDjBwQJOdEZx0iHQY+QOQeYQItng
 kRtGOwqAyVGmYNfE0tC3Im8vsb4PZ0Q5ApVNryyhbN7VngFRKVzQ5BrgFw+6zepgTCAh
 wOaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXseoFX8c3iWroEZH+1OTXxewDMPtIvmrbmg5ClBiBO6QbWgHNwZFhMfsVPK+fLae9pd/AWUAj2@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4v2MOpez1a6cGrtF077oKRw3pSdV5g4h9VEoKpYpaRx2sZ+Sj
 NrHuCuu0qvG45RPR+LOwbKysKjsjAEm4OkKKcae44SlA79oHMhCVdwoJTYRAXNSOFt2wwjoFhkt
 wWQm30IDzS5qrwkosCEJ/yhiASJ1a/ReJ
X-Gm-Gg: ASbGnculbXYdR4ICSrkTU79J/wrLckFps5GJmz59VuY6fqQf0buKqX5pxPM388opubY
 EDyf94ZlDDI7qpyds4kMM4tf7GHgiU3bOOwxCcuuOx2iJfoT3i1af7hKh9fE2ucr1j6nWrchaIv
 q8DjFcKkp7SN3exmk06bKBteAy+w==
X-Google-Smtp-Source: AGHT+IH3aXRPKMosJDKmphhBR78n4tKK4Oc0ZYxI/bHk5gB5c57vMEC8WE9+I4TNt5IbTWSAnG8v7y9D0f+fMbgrWFU=
X-Received: by 2002:a17:90b:3a88:b0:301:ba2b:3bc6 with SMTP id
 98e67ed59e1d1-306a496b929mr6111841a91.7.1744033548237; Mon, 07 Apr 2025
 06:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250320165634.1245798-1-alexander.deucher@amd.com>
 <CADnq5_O1TWAx9neJmNtAQ+kmn+85NHsfzoMr5P_fbz=ZRNpoHw@mail.gmail.com>
 <04635121-c8ca-42ba-a56b-20357702c929@amd.com>
 <CADnq5_OZCnYtfMPKN1CH4nDLEJsfpQvnSxLPJE=EjH9C=N_vJA@mail.gmail.com>
 <119debd2-b6a0-4d7a-87ce-7b80486d95ee@amd.com>
In-Reply-To: <119debd2-b6a0-4d7a-87ce-7b80486d95ee@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 09:45:36 -0400
X-Gm-Features: ATxdqUFYOximyWsURs2Wt1Kj7gN21M2I0EOjNdKS4_QFftKVaN6WaTbZb456G_E
Message-ID: <CADnq5_MuPL07pTRatWXsmLaWJUVqJZ8ptKyv85oQTapDS68d7w@mail.gmail.com>
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

On Mon, Apr 7, 2025 at 9:27=E2=80=AFAM Khatri, Sunil <sukhatri@amd.com> wro=
te:
>
>
> On 4/7/2025 6:26 PM, Alex Deucher wrote:
>
> On Mon, Apr 7, 2025 at 6:14=E2=80=AFAM Khatri, Sunil <sukhatri@amd.com> w=
rote:
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
>
> The register is an accessor for the header FIFO in the queue hardware.
> The FIFO is 8 entries deep so if you read the register 8 times, you
> can dump the full FIFO.
>
> Thanks for this information. I was kind of thinking the same but dint kno=
w it works directly and need not to change the way we read like setting grb=
m etc.
>
> for (i =3D 0; i < reg_count; i++)
>                 adev->gfx.ip_dump_core[i] =3D RREG32(SOC15_REG_ENTRY_OFFS=
ET(gc_reg_list_9[i])); With above loop arent we reading same offset again f=
or
>
> mmCP_CE_HEADER_DUMP,mmCP_PFP_HEADER_DUMP and mmCP_ME_HEADER_DUMP 8 times.=
 How are we making sure we are reading from different queues ?
>
> The me/pipes/queues are indexed via soc15_grbm_select().
>
> Alex
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
> I am assuming here also same explanation applies that when we read the sa=
me register again we are getting the next value in the queue but why use th=
is value of offset mmCP_MEC_ME1_HEADER_DUMP but read the register mmCP_MEC_=
ME2_HEADER_DUMP ??
>
>
> For i=3D0, we are dumping mmCP_MEC_ME2_HEADER_DUMP but for value of i >0 =
we are dumping mmCP_MEC_ME1_HEADER_DUMP ? Is that because mmCP_MEC_ME1_HEAD=
ER_DUMP belongs to MEC1 i.e for mec0 and for i > 0 i.e MEC2 we need to read=
 mmCP_MEC_ME2_HEADER_DUMP ?
>

Yes.  There are different registers for each ME.  ME0 uses
mmCP_[CE|PFP|ME]_HEADER_DUMP, ME1 uses mmCP_MEC_ME1_HEADER_DUMP and
ME2 uses mmCP_MEC_ME2_HEADER_DUMP.

Alex

>                                 }
>                                 index +=3D reg_count;
>                         }
> --
> 2.49.0
>
