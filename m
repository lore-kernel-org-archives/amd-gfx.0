Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44B5CCA47E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 18:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4323010F4B5;
	Tue,  7 Jun 2022 18:34:54 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED84F10F4C5
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 18:34:52 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-f2cbceefb8so24217922fac.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jun 2022 11:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oLk2aoZoNj3baguYkJX2eB88y+y99Fl0Ohxllid02VM=;
 b=DL886+he6THCQ9Jk7G4dSkAYFEkg0nommwWEP0u33+dIhDpAobZRb5LRZ+1qCTqjWT
 W4O+jwz3Nd9mAil7HWh5KSAQuqFqq3UTSBxXVcTbGKnG6i9x0EEhaVAVQlRHmCdcKJ5A
 hX8oz5pFJ18/OiNauxrQmsta7Vo5bwCHpt0J+gunElye7IV0PAdmhnnSi2X5L7wXFwTM
 nc6TUaYCnSuRK2qQ0d9p6pZpzAq83eVwg193XksLj8+V9Nf8TwTJqBRvUQV74YrFCn1I
 0pUVWXmylpS8RkGpld8bsmSsTKqW0fYIoN/Bhb+97nWX1EkFUtjEtP18hMHmztyCO8vg
 ul8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oLk2aoZoNj3baguYkJX2eB88y+y99Fl0Ohxllid02VM=;
 b=sMzIDBNCBVVU4+iIBuLjuD66KObikVl1n+ZyhkdO5nYT5M1p+xNK+SesIUgFSQdtkW
 Oc3Oupe8eq0Q2T34yd86rHBJp1R/dIKEYZK/SRQtIuxH2DBs/Nf6hlsFNpY3TprkXbCt
 QP/BeFOtVYKJEy3Kl11WYUQpcXW9aO0Z2h12fhlql4GQE2EzkMMcUfeTOOBpEHRvLSLq
 dASq3wyUflk3k5HDv+77EAYkcNWEtS13SdjO3a3uAr75a4z02bDuBpaaCYgn+dlEOrYf
 NkvEi3Dc/jXxf2rtJLgkKdDLdKlfSMyuNIHy79WcJsNs16D3tgo6v4puAMrjgq7QVUue
 Tl2g==
X-Gm-Message-State: AOAM533wpAtsSS3zMv1TacKXIaMG9Fwd0DMkYTLDERdjElaGzTRISmkg
 Barn0mHt4CT1OrjaNLq15Y1szvpTrnNGg7i15Io=
X-Google-Smtp-Source: ABdhPJytqmzjCpmPUXerCbjhRApdxqxErY6Nk5aCrU0DJe7zZg+mO0t42x713AC8buSBrDMZ5FjQo0zi5VJJXgyxYcY=
X-Received: by 2002:a05:6870:3105:b0:f2:9615:ff8e with SMTP id
 v5-20020a056870310500b000f29615ff8emr141331oaa.200.1654626892144; Tue, 07 Jun
 2022 11:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220606210432.116508-1-Joseph.Greathouse@amd.com>
In-Reply-To: <20220606210432.116508-1-Joseph.Greathouse@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jun 2022 14:34:41 -0400
Message-ID: <CADnq5_Oc_GABYqKgRj=eZ7g8EaNp3mOqeGbJseHdGjbKcFWoaA@mail.gmail.com>
Subject: Re: [PATCH] umr: print MODE register as part of wave state
To: Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Tom St Denis <Tom.StDenis@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 6, 2022 at 5:04 PM Joseph Greathouse
<Joseph.Greathouse@amd.com> wrote:
>
> The MODE register contains detailed per-wave information, but UMR
> skipped printing it. This patch adds the ability to print each wave's
> MODE register as part of the wave scan operation, and prints the MODE
> register's sub-fields as part of the deeper print option.
>
> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  src/app/print_waves.c | 41 ++++++++++++++++++++++++++++++++++------
>  src/lib/scan_waves.c  | 44 +++++++++++++++++++++++++++++++++++++++++++
>  src/umr.h             | 19 +++++++++++++++++++
>  3 files changed, 98 insertions(+), 6 deletions(-)
>
> diff --git a/src/app/print_waves.c b/src/app/print_waves.c
> index 07dae2d..daedc24 100644
> --- a/src/app/print_waves.c
> +++ b/src/app/print_waves.c
> @@ -91,7 +91,7 @@ static void umr_print_waves_si_ai(struct umr_asic *asic)
>                 if (!asic->options.bitfields && first) {
>                         static const char* titles[] = {
>                                 "WAVE_STATUS", "PC_HI", "PC_LO", "INST_DW0", "INST_DW1", "EXEC_HI", "EXEC_LO", "HW_ID", "GPRALLOC",
> -                               "LDSALLOC", "TRAPSTS", "IBSTS", "TBA_HI", "TBA_LO", "TMA_HI", "TMA_LO", "IB_DBG0", "M0", NULL
> +                               "LDSALLOC", "TRAPSTS", "IBSTS", "TBA_HI", "TBA_LO", "TMA_HI", "TMA_LO", "IB_DBG0", "M0", "MODE", NULL
>                         };
>                         first = 0;
>                         printf("SE SH CU SIMD WAVE# ");
> @@ -106,13 +106,13 @@ static void umr_print_waves_si_ai(struct umr_asic *asic)
>  "   %08lx %08lx %08lx " // wave_status pc/hi/lo
>  "%08lx %08lx %08lx %08lx " // inst0/1 exec hi/lo
>  "%08lx %08lx %08lx %08lx %08lx " // HW_ID GPR/LDSALLOC TRAP/IB STS
> -"%08lx %08lx %08lx %08lx %08lx %08lx " // TBA_HI TBA_LO TMA_HI TMA_LO IB_DBG0 M0\n");
> +"%08lx %08lx %08lx %08lx %08lx %08lx %08lx " // TBA_HI TBA_LO TMA_HI TMA_LO IB_DBG0 M0 MODE\n");
>  "\n",
>  (unsigned)wd->se, (unsigned)wd->sh, (unsigned)wd->cu, (unsigned)wd->ws.hw_id.simd_id, (unsigned)wd->ws.hw_id.wave_id,
>  (unsigned long)wd->ws.wave_status.value, (unsigned long)wd->ws.pc_hi, (unsigned long)wd->ws.pc_lo,
>  (unsigned long)wd->ws.wave_inst_dw0, (unsigned long)wd->ws.wave_inst_dw1, (unsigned long)wd->ws.exec_hi, (unsigned long)wd->ws.exec_lo,
>  (unsigned long)wd->ws.hw_id.value, (unsigned long)wd->ws.gpr_alloc.value, (unsigned long)wd->ws.lds_alloc.value, (unsigned long)wd->ws.trapsts.value, (unsigned long)wd->ws.ib_sts.value,
> -(unsigned long)wd->ws.tba_hi, (unsigned long)wd->ws.tba_lo, (unsigned long)wd->ws.tma_hi, (unsigned long)wd->ws.tma_lo, (unsigned long)wd->ws.ib_dbg0, (unsigned long)wd->ws.m0
> +(unsigned long)wd->ws.tba_hi, (unsigned long)wd->ws.tba_lo, (unsigned long)wd->ws.tma_hi, (unsigned long)wd->ws.tma_lo, (unsigned long)wd->ws.ib_dbg0, (unsigned long)wd->ws.m0, (unsigned long)wd->ws.mode.value
>  );
>                         if (wd->ws.wave_status.halt || wd->ws.wave_status.fatal_halt) {
>                                 for (x = 0; x < ((wd->ws.gpr_alloc.sgpr_size + 1) << shift); x += 4)
> @@ -318,6 +318,24 @@ static void umr_print_waves_si_ai(struct umr_asic *asic)
>                         PP(trapsts, excp_cycle);
>                         PP(trapsts, dp_rate);
>
> +                       Hv("MODE", wd->ws.mode.value);
> +                       PP(mode, fp_round);
> +                       PP(mode, fp_denorm);
> +                       PP(mode, dx10_clamp);
> +                       PP(mode, ieee);
> +                       PP(mode, lod_clamped);
> +                       PP(mode, debug_en);
> +                       PP(mode, excp_en);
> +                       if (asic->family > FAMILY_VI)
> +                               PP(mode, fp16_ovfl);
> +                       PP(mode, pops_packer0);
> +                       PP(mode, pops_packer1);
> +                       if (asic->family > FAMILY_VI)
> +                               PP(mode, disable_perf);
> +                       PP(mode, gpr_idx_en);
> +                       PP(mode, vskip);
> +                       PP(mode, csp);
> +
>                         printf("\n"); col = 0;
>                 }
>                 wd = wd->next;
> @@ -393,7 +411,7 @@ static void umr_print_waves_nv(struct umr_asic *asic)
>         while (wd) {
>                 if (!asic->options.bitfields && first) {
>                         static const char* titles[] = {
> -                               "WAVE_STATUS", "PC_HI", "PC_LO", "INST_DW0", "EXEC_HI", "EXEC_LO", "HW_ID1", "HW_ID2", "GPRALLOC", "LDSALLOC", "TRAPSTS", "IBSTS1", "IBSTS2", "IB_DBG1", "M0", NULL
> +                               "WAVE_STATUS", "PC_HI", "PC_LO", "INST_DW0", "EXEC_HI", "EXEC_LO", "HW_ID1", "HW_ID2", "GPRALLOC", "LDSALLOC", "TRAPSTS", "IBSTS1", "IBSTS2", "IB_DBG1", "M0", "MODE", NULL
>                         };
>                         first = 0;
>                         printf("SE SA WGP SIMD WAVE# ");
> @@ -408,13 +426,13 @@ static void umr_print_waves_nv(struct umr_asic *asic)
>  "   %08lx %08lx %08lx " // wave_status pc/hi/lo
>  "%08lx %08lx %08lx " // inst0 exec hi/lo
>  "%08lx %08lx %08lx %08lx %08lx %08lx %08lx " // HW_ID1 HW_ID2 GPR/LDSALLOC TRAP/IB STS
> -"%08lx %08lx " // IB_DBG1 M0\n");
> +"%08lx %08lx %08lx " // IB_DBG1 M0 MODE\n");
>  "\n",
>  (unsigned)wd->se, (unsigned)wd->sh, (unsigned)wd->cu, (unsigned)wd->ws.hw_id1.simd_id, (unsigned)wd->ws.hw_id1.wave_id, // TODO: wgp printed out won't match geometry for now w.r.t. to SPI
>  (unsigned long)wd->ws.wave_status.value, (unsigned long)wd->ws.pc_hi, (unsigned long)wd->ws.pc_lo,
>  (unsigned long)wd->ws.wave_inst_dw0, (unsigned long)wd->ws.exec_hi, (unsigned long)wd->ws.exec_lo,
>  (unsigned long)wd->ws.hw_id1.value, (unsigned long)wd->ws.hw_id2.value, (unsigned long)wd->ws.gpr_alloc.value, (unsigned long)wd->ws.lds_alloc.value, (unsigned long)wd->ws.trapsts.value,
> -(unsigned long)wd->ws.ib_sts.value, (unsigned long)wd->ws.ib_sts2.value, (unsigned long)wd->ws.ib_dbg1, (unsigned long)wd->ws.m0);
> +(unsigned long)wd->ws.ib_sts.value, (unsigned long)wd->ws.ib_sts2.value, (unsigned long)wd->ws.ib_dbg1, (unsigned long)wd->ws.m0, (unsigned long)wd->ws.mode.value);
>                         if (wd->ws.wave_status.halt || wd->ws.wave_status.fatal_halt) {
>                                 for (x = 0; x < 112; x += 4)
>                                         printf(">SGPRS[%u..%u] = { %08lx, %08lx, %08lx, %08lx }\n",
> @@ -627,6 +645,17 @@ static void umr_print_waves_nv(struct umr_asic *asic)
>                         PP(trapsts, excp_group_mask);
>                         PP(trapsts, utc_error);
>
> +                       Hv("MODE", wd->ws.mode.value);
> +                       PP(mode, fp_round);
> +                       PP(mode, fp_denorm);
> +                       PP(mode, dx10_clamp);
> +                       PP(mode, ieee);
> +                       PP(mode, lod_clamped);
> +                       PP(mode, debug_en);
> +                       PP(mode, excp_en);
> +                       PP(mode, fp16_ovfl);
> +                       PP(mode, disable_perf);
> +
>                         printf("\n"); col = 0;
>                 }
>                 wd = wd->next;
> diff --git a/src/lib/scan_waves.c b/src/lib/scan_waves.c
> index dae858e..71e595f 100644
> --- a/src/lib/scan_waves.c
> +++ b/src/lib/scan_waves.c
> @@ -139,6 +139,7 @@ int umr_read_wave_status_via_mmio_gfx8_9(struct umr_asic *asic, uint32_t simd, u
>         }
>         dst[(*no_fields)++] = wave_read_ind(asic, simd, wave, umr_find_reg_data(asic, "ixSQ_WAVE_IB_DBG0")->addr);
>         dst[(*no_fields)++] = wave_read_ind(asic, simd, wave, umr_find_reg_data(asic, "ixSQ_WAVE_M0")->addr);
> +       dst[(*no_fields)++] = wave_read_ind(asic, simd, wave, umr_find_reg_data(asic, "ixSQ_WAVE_MODE")->addr);
>
>         return 0;
>  }
> @@ -163,6 +164,7 @@ int umr_read_wave_status_via_mmio_gfx10(struct umr_asic *asic, uint32_t wave, ui
>         dst[(*no_fields)++] = wave_read_ind_nv(asic, wave, umr_find_reg_data(asic, "ixSQ_WAVE_IB_STS2")->addr);
>         dst[(*no_fields)++] = wave_read_ind_nv(asic, wave, umr_find_reg_data(asic, "ixSQ_WAVE_IB_DBG1")->addr);
>         dst[(*no_fields)++] = wave_read_ind_nv(asic, wave, umr_find_reg_data(asic, "ixSQ_WAVE_M0")->addr);
> +       dst[(*no_fields)++] = wave_read_ind_nv(asic, wave, umr_find_reg_data(asic, "ixSQ_WAVE_MODE")->addr);
>
>         return 0;
>  }
> @@ -258,6 +260,19 @@ static int umr_parse_wave_data_gfx_8(struct umr_asic *asic, struct umr_wave_stat
>         ws->tma_hi = buf[x++];
>         ws->ib_dbg0 = buf[x++];
>         ws->m0 = buf[x++];
> +
> +       ws->mode.value = value = buf[x++];
> +               reg = umr_find_reg_data(asic, "ixSQ_WAVE_MODE");
> +               ws->mode.fp_round = umr_bitslice_reg(asic, reg, "FP_ROUND", value);
> +               ws->mode.fp_denorm = umr_bitslice_reg(asic, reg, "FP_DENORM", value);
> +               ws->mode.dx10_clamp = umr_bitslice_reg(asic, reg, "DX10_CLAMP", value);
> +               ws->mode.ieee = umr_bitslice_reg(asic, reg, "IEEE", value);
> +               ws->mode.lod_clamped = umr_bitslice_reg(asic, reg, "LOD_CLAMPED", value);
> +               ws->mode.debug_en = umr_bitslice_reg(asic, reg, "DEBUG_EN", value);
> +               ws->mode.excp_en = umr_bitslice_reg(asic, reg, "EXCP_EN", value);
> +               ws->mode.gpr_idx_en = umr_bitslice_reg(asic, reg, "GPR_IDX_EN", value);
> +               ws->mode.vskip = umr_bitslice_reg(asic, reg, "VSKIP", value);
> +               ws->mode.csp = umr_bitslice_reg(asic, reg, "CSP", value);
>         return 0;
>  }
>
> @@ -348,6 +363,23 @@ static int umr_parse_wave_data_gfx_9(struct umr_asic *asic, struct umr_wave_stat
>
>         ws->ib_dbg0 = buf[x++];
>         ws->m0 = buf[x++];
> +
> +       ws->mode.value = value = buf[x++];
> +               reg = umr_find_reg_data(asic, "ixSQ_WAVE_MODE");
> +               ws->mode.fp_round = umr_bitslice_reg(asic, reg, "FP_ROUND", value);
> +               ws->mode.fp_denorm = umr_bitslice_reg(asic, reg, "FP_DENORM", value);
> +               ws->mode.dx10_clamp = umr_bitslice_reg(asic, reg, "DX10_CLAMP", value);
> +               ws->mode.ieee = umr_bitslice_reg(asic, reg, "IEEE", value);
> +               ws->mode.lod_clamped = umr_bitslice_reg(asic, reg, "LOD_CLAMPED", value);
> +               ws->mode.debug_en = umr_bitslice_reg(asic, reg, "DEBUG_EN", value);
> +               ws->mode.excp_en = umr_bitslice_reg(asic, reg, "EXCP_EN", value);
> +               ws->mode.fp16_ovfl = umr_bitslice_reg(asic, reg, "FP16_OVFL", value);
> +               ws->mode.pops_packer0 = umr_bitslice_reg(asic, reg, "POPS_PACKER0", value);
> +               ws->mode.pops_packer1 = umr_bitslice_reg(asic, reg, "POPS_PACKER1", value);
> +               ws->mode.disable_perf = umr_bitslice_reg(asic, reg, "DISABLE_PERF", value);
> +               ws->mode.gpr_idx_en = umr_bitslice_reg(asic, reg, "GPR_IDX_EN", value);
> +               ws->mode.vskip = umr_bitslice_reg(asic, reg, "VSKIP", value);
> +               ws->mode.csp = umr_bitslice_reg(asic, reg, "CSP", value);
>         return 0;
>  }
>
> @@ -468,6 +500,18 @@ static int umr_parse_wave_data_gfx_10(struct umr_asic *asic, struct umr_wave_sta
>
>         ws->ib_dbg1 = buf[x++];
>         ws->m0 = buf[x++];
> +
> +       ws->mode.value = value = buf[x++];
> +               reg = umr_find_reg_data(asic, "ixSQ_WAVE_MODE");
> +               ws->mode.fp_round = umr_bitslice_reg(asic, reg, "FP_ROUND", value);
> +               ws->mode.fp_denorm = umr_bitslice_reg(asic, reg, "FP_DENORM", value);
> +               ws->mode.dx10_clamp = umr_bitslice_reg(asic, reg, "DX10_CLAMP", value);
> +               ws->mode.ieee = umr_bitslice_reg(asic, reg, "IEEE", value);
> +               ws->mode.lod_clamped = umr_bitslice_reg(asic, reg, "LOD_CLAMPED", value);
> +               ws->mode.debug_en = umr_bitslice_reg(asic, reg, "DEBUG_EN", value);
> +               ws->mode.excp_en = umr_bitslice_reg(asic, reg, "EXCP_EN", value);
> +               ws->mode.fp16_ovfl = umr_bitslice_reg(asic, reg, "FP16_OVFL", value);
> +               ws->mode.disable_perf = umr_bitslice_reg(asic, reg, "DISABLE_PERF", value);
>         return 0;
>  }
>
> diff --git a/src/umr.h b/src/umr.h
> index ca62560..f541dd3 100644
> --- a/src/umr.h
> +++ b/src/umr.h
> @@ -713,6 +713,25 @@ struct umr_wave_status {
>                         excp_group_mask,
>                         utc_error;
>         } trapsts;
> +
> +       struct {
> +               uint32_t
> +                       value,
> +                       fp_round,
> +                       fp_denorm,
> +                       dx10_clamp,
> +                       ieee,
> +                       lod_clamped,
> +                       debug_en,
> +                       excp_en,
> +                       fp16_ovfl,
> +                       pops_packer0,
> +                       pops_packer1,
> +                       disable_perf,
> +                       gpr_idx_en,
> +                       vskip,
> +                       csp;
> +       } mode;
>  };
>
>  struct umr_wave_data {
> --
> 2.25.1
>
