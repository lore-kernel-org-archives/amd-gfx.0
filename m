Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4111CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 14:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E23B910E826;
	Wed,  8 Oct 2025 14:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mQDztWpZ";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ECD310E826
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 14:09:00 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-28d18e933a9so12839105ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Oct 2025 07:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759932540; x=1760537340; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJtbQraNMyDEKeru5LzXpbJVAAvGoRRcci5eBVkTOys=;
 b=mQDztWpZ0yOqi3aJgyAgO/hR6IJajW/6Hl9dGD7nviv4JP3hPRYQAotjv3ZpDwc8CO
 hs7w0w0hwKq62QzvsvyxXfEHmFM/HyEsDKmvSG5ahBdcuTVm24q6hU+rPOhZHZt1soub
 iexvwE+USnv1wrXPwcZtakDIFNhgvRXQIHXvRz7DMAt7FAIbJNEGkN55x7aemiIMCUUk
 /q2rN3GZPV0lxmh75/KkdN4qV3NaJFc8ObInSIPRsmXhpYaFkDP5ljlpvq/axpnwkF6s
 JndFasivCDNSHkc3zYAA/TaHKDLPpSAIBXxlDkelaCKpUj1yx5MAWCtWtj7Kd3+6OC3w
 c1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759932540; x=1760537340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJtbQraNMyDEKeru5LzXpbJVAAvGoRRcci5eBVkTOys=;
 b=tB5k4mX0zmJYMHes5NmWNnN1r556prOauTSoIDzhfku58tkW006i7fteLh8GJKUBJr
 TPvGsNyYHUHU5kQLo/SXWLdfFATm5nQYXewl73zFZyy+S4hnoqAoPTSze+njmr/VbOiv
 FEis0A4MURMjFBY1drCOImSsZsv5kuxTVCVGkLwnEvSEF4lIsJP0V3MZkzgpTLlBUxEV
 5ngdl0NjYyVxpTdHDWYm1ARtKrxWI7N413FsVmCZx04PVztkJqig5EWZPDyM8d5p4POh
 IOTbkAffPaEkJV1jc+I1GiGFkUYuqZdyjGpMwe3o/rLpMDjI4Bjj4t3AqV1D0qQls8X7
 q/AQ==
X-Gm-Message-State: AOJu0YyNlXAOqdUNgWeUlsp/6qGgYC+DedsaO4CMfJY2LT2zoX0t36M0
 mlD4/dTWwA1abHYqWT+T6M6L88m0dop0tyFSyt5OFwwTk4K1JZ2QIrs0dNa9mESeudl519vZ5tE
 FcONo6wvtYGUPkwIhoJsrWR/Ir8HVMIdZLA==
X-Gm-Gg: ASbGncvWsF71oOmWaqLpHWYn7jLJ4riMy5itWt6qItlADZIzjkdfbprDQ5UpFFfq/Ix
 pPjdCO5R/K4KJX5HV9kLnMIPSHJGsUPwuYItWLaTLtd9xXomxxdXxlo85QQMiNDkK4ieU7nVJzh
 whzkffXJZD6suNbAqMxpVuSlNnhabRVtSfXOAV7Jg3YZerMph7iQB8eUeC8AHuSMqWLHLaAFfYZ
 r1rIyd9COh1sNtkUTDayvLRPWlKhENdXamVyTYv4g==
X-Google-Smtp-Source: AGHT+IGRlJHZPFXFRiv0cfkTRdP0kcPh5Eu0fxdI3ZvBcmVgDcsVY9f0RhTLXEYnDRqRt/CZjcahjcr2a52Xe1tSA9k=
X-Received: by 2002:a17:903:24f:b0:26b:1871:1f70 with SMTP id
 d9443c01a7336-2902727f94amr22556655ad.5.1759932539667; Wed, 08 Oct 2025
 07:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250911114155.24786-1-tvrtko.ursulin@igalia.com>
In-Reply-To: <20250911114155.24786-1-tvrtko.ursulin@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Oct 2025 10:08:48 -0400
X-Gm-Features: AS18NWDmg1RUMqh1dlbgp6iNPchx_v7KvgKtebShu2esLDRANcT7NEjHrQFI5iI
Message-ID: <CADnq5_OD2FoiNxj3FqrqQSLCs7h_a-4uRy5ucceEA+Px-5Ea7w@mail.gmail.com>
Subject: Re: [PATCH 00/16] More compact IB emission
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

Applied the series.  Thanks!

Alex

On Thu, Sep 11, 2025 at 7:42=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@igalia.com> wrote:
>
> In short, this series mostly does a lot of replacing of this pattern:
>
>        ib->ptr[ib->length_dw++] =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
>                SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
>        ib->ptr[ib->length_dw++] =3D lower_32_bits(pe);
>        ib->ptr[ib->length_dw++] =3D upper_32_bits(pe);
>        ib->ptr[ib->length_dw++] =3D ndw - 1;
>        for (; ndw > 0; ndw -=3D 2) {
>               ib->ptr[ib->length_dw++] =3D lower_32_bits(value);
>               ib->ptr[ib->length_dw++] =3D upper_32_bits(value);
>                value +=3D incr;
>        }
>
> With this one:
>
>        u32 *ptr =3D &ib->ptr[ib->length_dw];
>
>        *ptr++ =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
>                 SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
>        *ptr++ =3D lower_32_bits(pe);
>        *ptr++ =3D upper_32_bits(pe);
>        *ptr++ =3D ndw - 1;
>        for (; ndw > 0; ndw -=3D 2) {
>                *ptr++ =3D lower_32_bits(value);
>                *ptr++ =3D upper_32_bits(value);
>                 value +=3D incr;
>         }
>
>        ib->length_dw =3D ptr - ib->ptr;
>
> Latter avoids register reloads and length updates on every dword written,=
 and on
> the overall makes the IB emission much more compact:
>
> add/remove: 0/1 grow/shrink: 10/58 up/down: 260/-6598 (-6338)
> Function                                     old     new   delta
> sdma_v7_0_ring_pad_ib                         99     127     +28
> sdma_v6_0_ring_pad_ib                         99     127     +28
> sdma_v5_2_ring_pad_ib                         99     127     +28
> sdma_v5_0_ring_pad_ib                         99     127     +28
> sdma_v4_4_2_ring_pad_ib                       99     127     +28
> sdma_v4_0_ring_pad_ib                         99     127     +28
> sdma_v3_0_ring_pad_ib                         99     127     +28
> sdma_v2_4_ring_pad_ib                         99     127     +28
> cik_sdma_ring_pad_ib                          99     127     +28
> si_dma_ring_pad_ib                            36      44      +8
> amdgpu_ring_generic_pad_ib                    56      52      -4
> si_dma_emit_fill_buffer                      108      71     -37
> si_dma_vm_write_pte                          158     115     -43
> amdgpu_vcn_dec_sw_send_msg                   810     767     -43
> si_dma_vm_copy_pte                           137      87     -50
> si_dma_emit_copy_buffer                      134      84     -50
> sdma_v3_0_vm_write_pte                       163     102     -61
> sdma_v2_4_vm_write_pte                       163     102     -61
> cik_sdma_vm_write_pte                        163     102     -61
> sdma_v7_0_vm_write_pte                       168     105     -63
> sdma_v7_0_emit_fill_buffer                   119      56     -63
> sdma_v6_0_vm_write_pte                       168     105     -63
> sdma_v6_0_emit_fill_buffer                   119      56     -63
> sdma_v5_2_vm_write_pte                       168     105     -63
> sdma_v5_2_emit_fill_buffer                   119      56     -63
> sdma_v5_0_vm_write_pte                       168     105     -63
> sdma_v5_0_emit_fill_buffer                   119      56     -63
> sdma_v4_4_2_vm_write_pte                     168     105     -63
> sdma_v4_4_2_emit_fill_buffer                 119      56     -63
> sdma_v4_0_vm_write_pte                       168     105     -63
> sdma_v4_0_emit_fill_buffer                   119      56     -63
> sdma_v3_0_emit_fill_buffer                   116      53     -63
> sdma_v2_4_emit_fill_buffer                   116      53     -63
> cik_sdma_emit_fill_buffer                    116      53     -63
> sdma_v6_0_emit_copy_buffer                   169      76     -93
> sdma_v5_2_emit_copy_buffer                   169      76     -93
> sdma_v5_0_emit_copy_buffer                   169      76     -93
> sdma_v4_4_2_emit_copy_buffer                 169      76     -93
> sdma_v4_0_emit_copy_buffer                   169      76     -93
> sdma_v3_0_vm_copy_pte                        158      64     -94
> sdma_v3_0_emit_copy_buffer                   155      61     -94
> sdma_v2_4_vm_copy_pte                        158      64     -94
> sdma_v2_4_emit_copy_buffer                   155      61     -94
> cik_sdma_vm_copy_pte                         158      64     -94
> cik_sdma_emit_copy_buffer                    155      61     -94
> sdma_v6_0_vm_copy_pte                        163      68     -95
> sdma_v5_2_vm_copy_pte                        163      68     -95
> sdma_v5_0_vm_copy_pte                        163      68     -95
> sdma_v4_4_2_vm_copy_pte                      163      68     -95
> sdma_v4_0_vm_copy_pte                        163      68     -95
> sdma_v7_0_vm_copy_pte                        183      75    -108
> sdma_v7_0_emit_copy_buffer                   317     202    -115
> si_dma_vm_set_pte_pde                        338     214    -124
> amdgpu_vce_get_destroy_msg                   784     652    -132
> sdma_v7_0_vm_set_pte_pde                     218      72    -146
> sdma_v6_0_vm_set_pte_pde                     218      72    -146
> sdma_v5_2_vm_set_pte_pde                     218      72    -146
> sdma_v5_0_vm_set_pte_pde                     218      72    -146
> sdma_v4_4_2_vm_set_pte_pde                   218      72    -146
> sdma_v4_0_vm_set_pte_pde                     218      72    -146
> sdma_v3_0_vm_set_pte_pde                     215      69    -146
> sdma_v2_4_vm_set_pte_pde                     215      69    -146
> cik_sdma_vm_set_pte_pde                      215      69    -146
> amdgpu_vcn_unified_ring_ib_header            172       -    -172
> gfx_v9_4_2_run_shader.constprop              739     532    -207
> uvd_v6_0_enc_ring_test_ib                   1464    1162    -302
> uvd_v7_0_enc_ring_test_ib                   1464    1138    -326
> amdgpu_vce_ring_test_ib                     1357     936    -421
> amdgpu_vcn_enc_ring_test_ib                 2042    1524    -518
> Total: Before=3D9262623, After=3D9256285, chg -0.07%
>
> * Notice how _pad_ib functions have grown. I think the compiler used the
> opportunity to unroll the loops.
>
> ** Series was only smoke tested on the Steam Deck.
>
> Tvrtko Ursulin (16):
>   drm/amdgpu: Use memset32 for IB padding
>   drm/amdgpu: More compact VCE IB emission
>   drm/amdgpu: More compact VCN IB emission
>   drm/amdgpu: More compact UVD 6 IB emission
>   drm/amdgpu: More compact UVD 7 IB emission
>   drm/amdgpu: More compact SI SDMA emission
>   drm/amdgpu: More compact CIK SDMA IB emission
>   drm/amdgpu: More compact GFX 9.4.2 IB emission
>   drm/amdgpu: More compact SDMA 2.4 IB emission
>   drm/amdgpu: More compact SDMA 3.0 IB emission
>   drm/amdgpu: More compact SDMA 4.0 IB emission
>   drm/amdgpu: More compact SDMA 4.4.2 IB emission
>   drm/amdgpu: More compact SDMA 5.0 IB emission
>   drm/amdgpu: More compact SDMA 5.2 IB emission
>   drm/amdgpu: More compact SDMA 6.0 IB emission
>   drm/amdgpu: More compact SDMA 7.0 IB emission
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  12 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c  |  90 +++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 101 ++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 105 ++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c  |  46 ++++-----
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 108 ++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 108 ++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 109 ++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 108 ++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 106 ++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 110 ++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 110 ++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 119 +++++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/si_dma.c      |  84 +++++++++-------
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  66 +++++++------
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  66 +++++++------
>  16 files changed, 849 insertions(+), 599 deletions(-)
>
> --
> 2.48.0
>
