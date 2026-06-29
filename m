Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AA7C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 20:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F9910EA37;
	Mon, 29 Jun 2026 20:28:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rnDRRvvK";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC1D10EA37
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 20:28:15 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-30cb5001e5bso200674eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 13:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782764895; cv=none;
 d=google.com; s=arc-20260327;
 b=W/2I6FSG4k5unp8Ouo4IZLKj00/eLoW5Eu9xMHo4pcJYkbHD6mpO5rEQisxweA7HVy
 cLYlIcUpiSR1qqpCwryaO4WqqnA+QQiah/AF/0w/YRXSiQzQXaDnjdcyXRLWxcPOAvLJ
 BEEHMKAibBCXAgFTph8eCNBSBERxsOJkRk6yLjakQRu3bvR6D7IdwLDY7Sb17anP4QPY
 NshEWcJMheXLTGjUf/fSJwJqDXgJc1Y8MMBY+5T4LGUtHZ7aZop2d/joWdlbO2m2qdA5
 RDKVmBaaqycp2pw4gZ57FFQGDFpxvDiFnO4LVYTMR0RX/S/c9pSYlLvu95u6KG+EJ35u
 h8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Fz0f8ZcQMl/5gObXJMDLf2VRIg+GlOa/ylvgHBWZIGs=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=atly4h9YIBK5v4/vWMK0gV/xJHbkm5AIa/G5o/nng33voUU19TJ1MIFUoo3/KgYqsb
 C1ryqc8eMOtARGjCnHljyikw3394dQ9qO/mQBzPD0nLqeDOeigbHc1kjJ+Qsmh1qqaxh
 JskcILPRpHpUO8Q+z8l/n4POS/ZvRHwpdaT0nXDb0jCgOy75wcjoNqhbBj5uh3UFU5Bf
 MHS7eGgEo30OGqcKCfdgwKbgvO/xE0mXLeM0oXc1lZskBcilcxfq1XBvGuqPvP4s5RvI
 3IciBpt57m47Z82UxHUoHGgVgGp6XFjA3CmWjb3Vsfiu/1T3JPEnI/afo60AS2uYeoYg
 R5EA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782764895; x=1783369695; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Fz0f8ZcQMl/5gObXJMDLf2VRIg+GlOa/ylvgHBWZIGs=;
 b=rnDRRvvK860ADFOfoHP5Rl/xky67tBBH9umt3ztaoH0NnHxYpeVfF50dJh69RI/xJl
 4skVOYEo1hLpkSUhbpGYW52jCEiwutZ/GmVgmuB3hQgY61YdIC1miECKhIQaXOC+EJD2
 42SbT1olTC6OGgUofphWBbj9QQqu3TzM/X2bK3ImZh+zky0co+36Y76g7v8t78mo2nRu
 kssIeW0bx/vgtOtWhsf0uL6aDUMji78nvvlr4NYwXyxVoeztj7QJPv7oWniIYkFITVaQ
 orafbNiZTRDEcc/Z5vk1qEHX9NHgzGS7SEhfhRnihtUQeTYqBamNKKCsgr85KrP8DpsJ
 H/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782764895; x=1783369695;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fz0f8ZcQMl/5gObXJMDLf2VRIg+GlOa/ylvgHBWZIGs=;
 b=WGX7FtJl/RubByy22tG4YyGGi07DoE97B4f8asfFNNgvb0Y5aTdpGach/O6Lmx4ZR/
 tjF0qDUEW3iO3ZZnZCO2No+OghdhioMQucl9ibYm/u6dQfEHJ1naoJGVoLD7O7TZ4H0d
 6ng9oBumN5zaSL/3Yl/zSsRJQ6kMyFJM7cMgKetiHs1ltb2h2ntxjFs5tUbJcugXDT3Z
 inz0Tbl7rYU2/+NH2n6rKYe88B3aYX9PM42IOhPh48MvCFH5b2RxIgPqBEX3/WEPNHxb
 7j1HT/nCCgqmTj63fNkKHg1GNKQjmmLF273L8icpMhW1w5MBSUzsJ/6TvFVdBXwCHc1p
 v0zg==
X-Gm-Message-State: AOJu0YzNWfw0x2SuORCULHnE15Kc/JePI2KdHKMFWZIfa0F3HM3D8hCp
 4RvewQrlqwGxxnV37JNDXTQ5YCf7gGX+VDwfjMhJVq7nAzLBkihq3EtKPw3lESAtymbxCHb+PFK
 VGDQOVW8VAr54Td3EUPxLlTAaZcohl3JUz0jE
X-Gm-Gg: AfdE7cl9VCj4t7l7fMNh9fOrVd7n81ju7uqupJ0DCnJwloFDTkQdPlVCcIYqmChUu5N
 dHzuJv8migGH9u+RAfeDqT1eQEpob1eDnli2X79ImPp1ome/Ern6TqMui11Riqbl4icvW0SsZPB
 32LjkgQR6HT+rFZzWqXdMFxNYAY+soS9LDoftRFFbJ2aQ/za+ogefbgq4l4Wdqw6P57gNpNJ25q
 1syH9JdlrL/yVeyy75bsaOA0MJI3uB9g4oAkndKs52A0Ze3VS8+dtyyImP08afIx1EThSPGCByA
 bGlnmt+Tnre3WP+SHoGmA1JamRO5V8JbruWAdWprNGUKCTQ/WhrIhxDks3U=
X-Received: by 2002:a05:7022:312:b0:138:2790:149b with SMTP id
 a92af1059eb24-13b2a1bfcd0mr258229c88.7.1782764894752; Mon, 29 Jun 2026
 13:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260618204550.753250-1-alexander.deucher@amd.com>
In-Reply-To: <20260618204550.753250-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Jun 2026 16:28:02 -0400
X-Gm-Features: AVVi8CcIFwXhdo1TD2vdTMq7ZAk_vBPc_HYTmkmjdupd598HTyrwHhuQSOe-orM
Message-ID: <CADnq5_Pn732-q2h0jcXcRErbjO=dtwsOfVgZE_qCT3-xCW24BA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gx12.1: Add ip dump support
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

Ping?

On Thu, Jun 18, 2026 at 5:04=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Add support for dumping IP register state.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 275 +++++++++++++++++++++++++
>  1 file changed, 275 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index 5bdf2512f1540..ec4346a6c2af2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -69,6 +69,127 @@ MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc_1.bin");
>          (SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0 << SH_MEM_CONFIG__ALI=
GNMENT_MODE__SHIFT) | \
>          (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
>
> +
> +static const struct amdgpu_hwip_reg_entry gc_reg_list_12_1[] =3D {
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS3),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT1),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT3),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STALLED_STAT1),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STALLED_STAT1),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_BUSY_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HPD_STATUS0),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS_2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regSQC_CACHES),
> +       SOC15_REG_ENTRY_STR(GC, 0, regSQG_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regWD_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_LO3=
2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_HI3=
2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_CNTL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_INSTR_PNTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR0),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR1),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_RS64_INSTR_PNTR),
> +       /* cp header registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       /* SE status registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
> +};
> +
> +static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_12_1[] =3D {
> +       /* compute registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_VMID),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PERSISTENT_STATE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PIPE_PRIORITY),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUEUE_PRIORITY),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUANTUM),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_REQUEST),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_EVENTS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_OFFSET),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_SIZE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_WG_STATE_OFFSET),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_SIZE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_GDS_RESOURCE_STATE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_ERROR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR_MEM),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_WG_STATE_OFFSET),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS),
> +       /* cp header registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +};
> +
>  static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev, i=
nt xcc_id);
>  static void gfx_v12_1_set_ring_funcs(struct amdgpu_device *adev);
>  static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev);
> @@ -1148,6 +1269,153 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable=
(struct amdgpu_device *adev)
>         return 0;
>  }
>
> +static void gfx_v12_1_alloc_ip_dump(struct amdgpu_device *adev)
> +{
> +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_12_1);
> +       uint32_t *ptr, inst, num_xcc;
> +
> +       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> +
> +       ptr =3D kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL=
);
> +       if (!ptr) {
> +               DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
> +               adev->gfx.ip_dump_core =3D NULL;
> +       } else {
> +               adev->gfx.ip_dump_core =3D ptr;
> +       }
> +
> +       /* Allocate memory for compute queue registers for all the instan=
ces */
> +       reg_count =3D ARRAY_SIZE(gc_cp_reg_list_12_1);
> +       inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
> +               adev->gfx.mec.num_queue_per_pipe;
> +
> +       ptr =3D kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), GFP=
_KERNEL);
> +       if (!ptr) {
> +               DRM_ERROR("Failed to allocate memory for Compute Queues I=
P Dump\n");
> +               adev->gfx.ip_dump_compute_queues =3D NULL;
> +       } else {
> +               adev->gfx.ip_dump_compute_queues =3D ptr;
> +       }
> +}
> +
> +static void gfx_v12_1_ip_print(struct amdgpu_ip_block *ip_block,
> +                              struct drm_printer *p)
> +{
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       uint32_t i, j, k;
> +       uint32_t xcc_id, xcc_offset, inst_offset;
> +       uint32_t num_xcc, reg, num_inst;
> +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_12_1);
> +
> +       if (!adev->gfx.ip_dump_core)
> +               return;
> +
> +       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> +       drm_printf(p, "Number of Instances:%d\n", num_xcc);
> +       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> +               xcc_offset =3D xcc_id * reg_count;
> +               drm_printf(p, "\nInstance id:%d\n", xcc_id);
> +               for (i =3D 0; i < reg_count; i++)
> +                       drm_printf(p, "%-50s \t 0x%08x\n",
> +                                  gc_reg_list_12_1[i].reg_name,
> +                                  adev->gfx.ip_dump_core[xcc_offset + i]=
);
> +       }
> +
> +       /* print compute queue registers for all instances */
> +       if (!adev->gfx.ip_dump_compute_queues)
> +               return;
> +
> +       reg_count =3D ARRAY_SIZE(gc_cp_reg_list_12_1);
> +       drm_printf(p, "\nnum_xcc: %d num_mec: %d num_pipe: %d num_queue: =
%d\n",
> +                  num_xcc,
> +                  adev->gfx.mec.num_mec,
> +                  adev->gfx.mec.num_pipe_per_mec,
> +                  adev->gfx.mec.num_queue_per_pipe);
> +
> +       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> +               xcc_offset =3D xcc_id * reg_count * num_inst;
> +               inst_offset =3D 0;
> +               for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
> +                       for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec;=
 j++) {
> +                               for (k =3D 0; k < adev->gfx.mec.num_queue=
_per_pipe; k++) {
> +                                       drm_printf(p,
> +                                                  "\nxcc:%d mec:%d, pipe=
:%d, queue:%d\n",
> +                                                   xcc_id, i, j, k);
> +                                       for (reg =3D 0; reg < reg_count; =
reg++) {
> +                                               drm_printf(p,
> +                                                          "%-50s \t 0x%0=
8x\n",
> +                                                          gc_cp_reg_list=
_12_1[reg].reg_name,
> +                                                          adev->gfx.ip_d=
ump_compute_queues
> +                                                          [xcc_offset + =
inst_offset +
> +                                                           reg]);
> +                                       }
> +                                       inst_offset +=3D reg_count;
> +                               }
> +                       }
> +               }
> +       }
> +}
> +
> +static void gfx_v12_1_ip_dump(struct amdgpu_ip_block *ip_block)
> +{
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       uint32_t i, j, k;
> +       uint32_t num_xcc, reg, num_inst;
> +       uint32_t xcc_id, xcc_offset, inst_offset;
> +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_12_1);
> +
> +       if (!adev->gfx.ip_dump_core)
> +               return;
> +
> +       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> +
> +       amdgpu_gfx_off_ctrl(adev, false);
> +       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> +               xcc_offset =3D xcc_id * reg_count;
> +               for (i =3D 0; i < reg_count; i++)
> +                       adev->gfx.ip_dump_core[xcc_offset + i] =3D
> +                               RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_reg=
_list_12_1[i],
> +                                                                  GET_IN=
ST(GC, xcc_id)));
> +       }
> +       amdgpu_gfx_off_ctrl(adev, true);
> +
> +       /* dump compute queue registers for all instances */
> +       if (!adev->gfx.ip_dump_compute_queues)
> +               return;
> +
> +       num_inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_m=
ec *
> +               adev->gfx.mec.num_queue_per_pipe;
> +       reg_count =3D ARRAY_SIZE(gc_cp_reg_list_12_1);
> +       amdgpu_gfx_off_ctrl(adev, false);
> +       mutex_lock(&adev->srbm_mutex);
> +       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> +               xcc_offset =3D xcc_id * reg_count * num_inst;
> +               inst_offset =3D 0;
> +               for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
> +                       for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec;=
 j++) {
> +                               for (k =3D 0; k < adev->gfx.mec.num_queue=
_per_pipe; k++) {
> +                                       /* ME0 is for GFX so start from 1=
 for CP */
> +                                       soc_v1_0_grbm_select(adev, 1 + i,=
 j, k, 0,
> +                                                            GET_INST(GC,=
 xcc_id));
> +
> +                                       for (reg =3D 0; reg < reg_count; =
reg++) {
> +                                               adev->gfx.ip_dump_compute=
_queues
> +                                                       [xcc_offset +
> +                                                        inst_offset + re=
g] =3D
> +                                                       RREG32(SOC15_REG_=
ENTRY_OFFSET_INST(
> +                                                                      gc=
_cp_reg_list_12_1[reg],
> +                                                                      GE=
T_INST(GC, xcc_id)));
> +                                       }
> +                                       inst_offset +=3D reg_count;
> +                               }
> +                       }
> +               }
> +       }
> +       soc_v1_0_grbm_select(adev, 0, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
> +       amdgpu_gfx_off_ctrl(adev, true);
> +}
> +
>  static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>         uint16_t major_ver, minor_ver;
> @@ -1282,6 +1550,8 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         if (r)
>                 return r;
>
> +       gfx_v12_1_alloc_ip_dump(adev);
> +
>         r =3D amdgpu_gfx_sysfs_init(adev);
>         if (r)
>                 return r;
> @@ -1325,6 +1595,9 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>         gfx_v12_1_free_microcode(adev);
>         amdgpu_gfx_sysfs_fini(adev);
>
> +       kfree(adev->gfx.ip_dump_core);
> +       kfree(adev->gfx.ip_dump_compute_queues);
> +
>         return 0;
>  }
>
> @@ -3905,6 +4178,8 @@ static const struct amd_ip_funcs gfx_v12_1_ip_funcs=
 =3D {
>         .set_clockgating_state =3D gfx_v12_1_set_clockgating_state,
>         .set_powergating_state =3D gfx_v12_1_set_powergating_state,
>         .get_clockgating_state =3D gfx_v12_1_get_clockgating_state,
> +       .dump_ip_state =3D gfx_v12_1_ip_dump,
> +       .print_ip_state =3D gfx_v12_1_ip_print,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute =3D {
> --
> 2.54.0
>
