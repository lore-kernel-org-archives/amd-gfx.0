Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBA6C43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 15:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82A2B10E9E9;
	Mon,  6 Jul 2026 15:01:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JkegR5SN";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41C4C10E9EA
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 15:01:37 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-384c94c9423so118577a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2026 08:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783350097; cv=none;
 d=google.com; s=arc-20260327;
 b=m1dTPNr3MUmgQLN2g+d1aJ0E+jpPSA5e/O7HTmgiLp8xidgenW4PzO/IJbRYXrwO6q
 keONDocQN8lV9x/+QqN9Wa/JBo7fiyE1cSKogNk/QvaGv0muZZA8umD5foKf5PdSzMkG
 Q2am1GMVs/hnUPom+72872GWHQHmNWCZV9oL1EURdgruCikW5a6DKghKXpIZRFN0uSHw
 99848vp0uf1sAizRCGyLW+/zD2e8zKdnkacXPGP7gDu8ZVFEg5ZKrId8WMdYhG8g4ULm
 DI7PbCVQ+ygeG11KuPnnI+xq/U+udIBdUodAxPC2lSouFPmV8hgewr2vu8IO/saWU6IJ
 UDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UNfvuUX3LSslg9Q2eTB6L7u06ckvBXbBfDygtMb2xUU=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=KV9oz6varwRqG9y7AjGVb+/om1xDABjx1KU+7gqDNNJ1P2VWtNPObckpkvfQdbPMjO
 LLM61t3faX0Nd17EbtCr7w1SIxGNvrpeZ4xmO0Ss0fTwfY4EDdG29uEjYn3BAnEJ60Wb
 7wpkK9ioiwAH0Lu8GE6Hu7YJPnwpSo36NOvgcdl0dsp8pVQHHRf32dgAy/xZ9Xg7XC9J
 nns6m5jg49+7U8f68bHCx2CFsLuLWlnaxt4t9zLqUrISjlDs8Hve5nyDLPX03ifooKJJ
 u3lgiq+zYj3mMGSeMxyVJKWHkw6YRb9iPV7074hhZVQnhJn1GlEtbS+d1gbuQY+TcGn2
 qb1g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783350097; x=1783954897; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UNfvuUX3LSslg9Q2eTB6L7u06ckvBXbBfDygtMb2xUU=;
 b=JkegR5SNbX4vFd3EAZoPbCEGYxv8bncY+wRGQzQUFbvFXcDsuhQiu7LaFeaBkeHCjn
 hwUS8Hcf+K7bw6nVnZRVoxXRl3pBSwxk6gWTetabuxjqao5oPtrebaglVtda1kVDeQuF
 HAk/6ZkTxiUQKOZvMakQs2mM15bxhikCaZ8UMK27FHeaGByN8wE6GZAWqBMdHg+1DU1q
 u7KIibpGJy4+MGfdNQkmMiNumjH/0RTA60fBvKK8s5VHXraYhwU9CX8PHbnEAimLMgCr
 4jQI8S0ZtglLxMbCN3NnrT37ZVbnVGprMfIdMdO/pM4cHd1bBJyoZsAOlGodzpGW4psk
 r9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783350097; x=1783954897;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UNfvuUX3LSslg9Q2eTB6L7u06ckvBXbBfDygtMb2xUU=;
 b=QNNwCsvoGny+ncjciEt/SvVArDPEB7E9nXyE/xH8i2T0cKnvqP/uqD2VfhBrjeRGZH
 DzYOPU4D+6NmNttgOhhebu+Lb+LCCXIt1KmKcZ8eEqebdasJst2XLfR4zygmbO+IkrOH
 ccadwLiyiSaPrbtQoqTBgBKfBYI7+DF7W11pglHwZMKlsg52QlQBm7ShazOljagxO07a
 vqBCHc0/EV8veOS7OLVe2i9aVfwFB+/ZgySWYSzenzqDnTRwcrXjS0R+OCKDxLYeglsa
 RZlmJCwQQ9Ny43WbLfGPOPtE0oq40FpWZKnWnEyJlSOqEKA0EPdQEJUqdvKgFlVjuRRo
 gqvA==
X-Gm-Message-State: AOJu0Yy8pkLb9yXZElmPaGH0MBy9i3X9Altbs2elo0X2Si2WJUbUVyp3
 8iUs+4OQugUuvuZzmV5jme2UGx61jnyKhej0P/aoIaL6+TM40LMzVrC9e+NriluDBsAPmbFR0X+
 7rNL2R5uH97RMgJMfYXss0gNOlsMFCNhYWQ==
X-Gm-Gg: AfdE7cl1VZplbsWY8Xwu13jKWTAGvGhtGLQ3OMrB/L4SMJlhlFNbdIVV4YnnFW7+ImK
 eNyiD3qDM4gqoBq/wG9UNPgaFXE4K9IskWnvKe2nSG4FfhVybzme8LqPRybq9BHXEJtszUtJCXg
 St7zpEknzt+6AaH7vdpqzHpUKMfpiSzzyY4WcsdCJuHS7Wg/sHlHRkLbi3RT1nJmXJhdXyQl10j
 7O+pnMd7Xs3pP0GH7ajm617D9t4HGjDb+Db9U8u4RsiB12UvKCCq2G/N9wbuGWcWgN4bvRPeERg
 Swuk//iFxSLx5cenNJAQafp5x/85JiiLg8yUVKH2RIjhGsXYdZ/77ol1pis=
X-Received: by 2002:a17:90b:28ce:b0:37d:f70f:fbf8 with SMTP id
 98e67ed59e1d1-3825c40ebe7mr6508463a91.0.1783350095463; Mon, 06 Jul 2026
 08:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260618204550.753250-1-alexander.deucher@amd.com>
 <CADnq5_Pn732-q2h0jcXcRErbjO=dtwsOfVgZE_qCT3-xCW24BA@mail.gmail.com>
In-Reply-To: <CADnq5_Pn732-q2h0jcXcRErbjO=dtwsOfVgZE_qCT3-xCW24BA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jul 2026 11:01:22 -0400
X-Gm-Features: AVVi8CfwMpAmNCVE6twlRSqM3UJDVLdbUJ8Ny5U7QIhSTqk9SU9JhSvjWJfmKyk
Message-ID: <CADnq5_NWbd3DCNU_LA9WDdZKJOLT+bSRBiaUwmrHVo5GVNGfyg@mail.gmail.com>
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

On Mon, Jun 29, 2026 at 4:28=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Ping?
>
> On Thu, Jun 18, 2026 at 5:04=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > Add support for dumping IP register state.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 275 +++++++++++++++++++++++++
> >  1 file changed, 275 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v12_1.c
> > index 5bdf2512f1540..ec4346a6c2af2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > @@ -69,6 +69,127 @@ MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc_1.bin");
> >          (SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0 << SH_MEM_CONFIG__A=
LIGNMENT_MODE__SHIFT) | \
> >          (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
> >
> > +
> > +static const struct amdgpu_hwip_reg_entry gc_reg_list_12_1[] =3D {
> > +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS3),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT1),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT2),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT3),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STALLED_STAT1),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STALLED_STAT1),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_BUSY_STAT),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT2),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT2),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HPD_STATUS0),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS_2),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regSQC_CACHES),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regSQG_STATUS),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regWD_UTCL1_STATUS),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_L=
O32),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_H=
I32),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_CNTL),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_INSTR_PNTR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR0),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR1),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_RS64_INSTR_PNTR),
> > +       /* cp header registers */
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> > +       /* SE status registers */
> > +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
> > +};
> > +
> > +static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_12_1[] =3D {
> > +       /* compute registers */
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_VMID),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PERSISTENT_STATE),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PIPE_PRIORITY),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUEUE_PRIORITY),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUANTUM),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE_HI),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_RPTR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_CONTROL),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR_HI),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_RPTR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_CONTROL),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_REQUEST),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR_HI),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_CONTROL),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_RPTR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_EVENTS),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_LO),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_HI),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_CONTROL),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_OFFSET),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_SIZE),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_WG_STATE_OFFSET),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_SIZE),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_GDS_RESOURCE_STATE),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_ERROR),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR_MEM),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_LO),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_HI),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_OFFSET)=
,
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_DW_CNT)=
,
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_WG_STATE_OFFSET),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS),
> > +       /* cp header registers */
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> > +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> > +};
> > +
> >  static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev,=
 int xcc_id);
> >  static void gfx_v12_1_set_ring_funcs(struct amdgpu_device *adev);
> >  static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev);
> > @@ -1148,6 +1269,153 @@ static int gfx_v12_1_rlc_backdoor_autoload_enab=
le(struct amdgpu_device *adev)
> >         return 0;
> >  }
> >
> > +static void gfx_v12_1_alloc_ip_dump(struct amdgpu_device *adev)
> > +{
> > +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_12_1);
> > +       uint32_t *ptr, inst, num_xcc;
> > +
> > +       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> > +
> > +       ptr =3D kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERN=
EL);
> > +       if (!ptr) {
> > +               DRM_ERROR("Failed to allocate memory for GFX IP Dump\n"=
);
> > +               adev->gfx.ip_dump_core =3D NULL;
> > +       } else {
> > +               adev->gfx.ip_dump_core =3D ptr;
> > +       }
> > +
> > +       /* Allocate memory for compute queue registers for all the inst=
ances */
> > +       reg_count =3D ARRAY_SIZE(gc_cp_reg_list_12_1);
> > +       inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec=
 *
> > +               adev->gfx.mec.num_queue_per_pipe;
> > +
> > +       ptr =3D kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), G=
FP_KERNEL);
> > +       if (!ptr) {
> > +               DRM_ERROR("Failed to allocate memory for Compute Queues=
 IP Dump\n");
> > +               adev->gfx.ip_dump_compute_queues =3D NULL;
> > +       } else {
> > +               adev->gfx.ip_dump_compute_queues =3D ptr;
> > +       }
> > +}
> > +
> > +static void gfx_v12_1_ip_print(struct amdgpu_ip_block *ip_block,
> > +                              struct drm_printer *p)
> > +{
> > +       struct amdgpu_device *adev =3D ip_block->adev;
> > +       uint32_t i, j, k;
> > +       uint32_t xcc_id, xcc_offset, inst_offset;
> > +       uint32_t num_xcc, reg, num_inst;
> > +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_12_1);
> > +
> > +       if (!adev->gfx.ip_dump_core)
> > +               return;
> > +
> > +       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> > +       drm_printf(p, "Number of Instances:%d\n", num_xcc);
> > +       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> > +               xcc_offset =3D xcc_id * reg_count;
> > +               drm_printf(p, "\nInstance id:%d\n", xcc_id);
> > +               for (i =3D 0; i < reg_count; i++)
> > +                       drm_printf(p, "%-50s \t 0x%08x\n",
> > +                                  gc_reg_list_12_1[i].reg_name,
> > +                                  adev->gfx.ip_dump_core[xcc_offset + =
i]);
> > +       }
> > +
> > +       /* print compute queue registers for all instances */
> > +       if (!adev->gfx.ip_dump_compute_queues)
> > +               return;
> > +
> > +       reg_count =3D ARRAY_SIZE(gc_cp_reg_list_12_1);
> > +       drm_printf(p, "\nnum_xcc: %d num_mec: %d num_pipe: %d num_queue=
: %d\n",
> > +                  num_xcc,
> > +                  adev->gfx.mec.num_mec,
> > +                  adev->gfx.mec.num_pipe_per_mec,
> > +                  adev->gfx.mec.num_queue_per_pipe);
> > +
> > +       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> > +               xcc_offset =3D xcc_id * reg_count * num_inst;
> > +               inst_offset =3D 0;
> > +               for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
> > +                       for (j =3D 0; j < adev->gfx.mec.num_pipe_per_me=
c; j++) {
> > +                               for (k =3D 0; k < adev->gfx.mec.num_que=
ue_per_pipe; k++) {
> > +                                       drm_printf(p,
> > +                                                  "\nxcc:%d mec:%d, pi=
pe:%d, queue:%d\n",
> > +                                                   xcc_id, i, j, k);
> > +                                       for (reg =3D 0; reg < reg_count=
; reg++) {
> > +                                               drm_printf(p,
> > +                                                          "%-50s \t 0x=
%08x\n",
> > +                                                          gc_cp_reg_li=
st_12_1[reg].reg_name,
> > +                                                          adev->gfx.ip=
_dump_compute_queues
> > +                                                          [xcc_offset =
+ inst_offset +
> > +                                                           reg]);
> > +                                       }
> > +                                       inst_offset +=3D reg_count;
> > +                               }
> > +                       }
> > +               }
> > +       }
> > +}
> > +
> > +static void gfx_v12_1_ip_dump(struct amdgpu_ip_block *ip_block)
> > +{
> > +       struct amdgpu_device *adev =3D ip_block->adev;
> > +       uint32_t i, j, k;
> > +       uint32_t num_xcc, reg, num_inst;
> > +       uint32_t xcc_id, xcc_offset, inst_offset;
> > +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_12_1);
> > +
> > +       if (!adev->gfx.ip_dump_core)
> > +               return;
> > +
> > +       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> > +
> > +       amdgpu_gfx_off_ctrl(adev, false);
> > +       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> > +               xcc_offset =3D xcc_id * reg_count;
> > +               for (i =3D 0; i < reg_count; i++)
> > +                       adev->gfx.ip_dump_core[xcc_offset + i] =3D
> > +                               RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_r=
eg_list_12_1[i],
> > +                                                                  GET_=
INST(GC, xcc_id)));
> > +       }
> > +       amdgpu_gfx_off_ctrl(adev, true);
> > +
> > +       /* dump compute queue registers for all instances */
> > +       if (!adev->gfx.ip_dump_compute_queues)
> > +               return;
> > +
> > +       num_inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per=
_mec *
> > +               adev->gfx.mec.num_queue_per_pipe;
> > +       reg_count =3D ARRAY_SIZE(gc_cp_reg_list_12_1);
> > +       amdgpu_gfx_off_ctrl(adev, false);
> > +       mutex_lock(&adev->srbm_mutex);
> > +       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> > +               xcc_offset =3D xcc_id * reg_count * num_inst;
> > +               inst_offset =3D 0;
> > +               for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
> > +                       for (j =3D 0; j < adev->gfx.mec.num_pipe_per_me=
c; j++) {
> > +                               for (k =3D 0; k < adev->gfx.mec.num_que=
ue_per_pipe; k++) {
> > +                                       /* ME0 is for GFX so start from=
 1 for CP */
> > +                                       soc_v1_0_grbm_select(adev, 1 + =
i, j, k, 0,
> > +                                                            GET_INST(G=
C, xcc_id));
> > +
> > +                                       for (reg =3D 0; reg < reg_count=
; reg++) {
> > +                                               adev->gfx.ip_dump_compu=
te_queues
> > +                                                       [xcc_offset +
> > +                                                        inst_offset + =
reg] =3D
> > +                                                       RREG32(SOC15_RE=
G_ENTRY_OFFSET_INST(
> > +                                                                      =
gc_cp_reg_list_12_1[reg],
> > +                                                                      =
GET_INST(GC, xcc_id)));
> > +                                       }
> > +                                       inst_offset +=3D reg_count;
> > +                               }
> > +                       }
> > +               }
> > +       }
> > +       soc_v1_0_grbm_select(adev, 0, 0, 0, 0, 0);
> > +       mutex_unlock(&adev->srbm_mutex);
> > +       amdgpu_gfx_off_ctrl(adev, true);
> > +}
> > +
> >  static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
> >  {
> >         uint16_t major_ver, minor_ver;
> > @@ -1282,6 +1550,8 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
> >         if (r)
> >                 return r;
> >
> > +       gfx_v12_1_alloc_ip_dump(adev);
> > +
> >         r =3D amdgpu_gfx_sysfs_init(adev);
> >         if (r)
> >                 return r;
> > @@ -1325,6 +1595,9 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_blo=
ck *ip_block)
> >         gfx_v12_1_free_microcode(adev);
> >         amdgpu_gfx_sysfs_fini(adev);
> >
> > +       kfree(adev->gfx.ip_dump_core);
> > +       kfree(adev->gfx.ip_dump_compute_queues);
> > +
> >         return 0;
> >  }
> >
> > @@ -3905,6 +4178,8 @@ static const struct amd_ip_funcs gfx_v12_1_ip_fun=
cs =3D {
> >         .set_clockgating_state =3D gfx_v12_1_set_clockgating_state,
> >         .set_powergating_state =3D gfx_v12_1_set_powergating_state,
> >         .get_clockgating_state =3D gfx_v12_1_get_clockgating_state,
> > +       .dump_ip_state =3D gfx_v12_1_ip_dump,
> > +       .print_ip_state =3D gfx_v12_1_ip_print,
> >  };
> >
> >  static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute =3D=
 {
> > --
> > 2.54.0
> >
