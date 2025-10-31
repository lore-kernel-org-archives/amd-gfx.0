Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2F9CCF9FE
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 14:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A6F10EB42;
	Fri, 31 Oct 2025 14:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBm4cMxi";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B87DA10EB42
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 14:21:48 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-295291fdde4so1148525ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761920508; x=1762525308; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bnytqkSiPlXwd1x3jYQpf6v2FxR81W5zqPc35mruiPs=;
 b=UBm4cMxiCLs7swluxc4VC3tPREG5y0ZV7lhMB8OB4ZrqVkznTtcnnwzldMZLMxcO5u
 c7+JovBDoKitvIiMMRJGW0TffZuyewcg/ty41CkmEV00gXMtFwyRfvxqAVRCgMCt8mPE
 E/XFTQjE7mjvS91rp2dksiGDSHHZ7Tsnt/urHnZ+Gk0ju9iTv+8PtTPTjw6oPX3Li1du
 yqmCrVpafJulEsrFy3tfBl98KLgl2Zmkoji0rbyDV7fJ+0XFfobm4MWAmszG4YwjBe6j
 xaOta5yEk+zmtPOf8RjCqWC2hIAGAyhvX+4UfoNJ9FOnyhrn8gswO52W5cAPvqjIqiHr
 AtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761920508; x=1762525308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bnytqkSiPlXwd1x3jYQpf6v2FxR81W5zqPc35mruiPs=;
 b=KJjlWXJZQZbKpjF2m0kLwHosnzHUJ6aEn3tL848TYVmqnoZAcCiurMseab0WEv9vEG
 FRoicinyfxWJPODLu7hEtYVgtu7EyImX8HFWErOgYoQ9AT9GHu3mUVqaQLKhp8jASUil
 b1Vr5abKEXTj8sFPQMrhhrrj+cwFPTi9XSdb1+HN9feZ+9K5H5YoSpa/uqkXLjVxOKH9
 ebD2pgWgRRgK0d+a4ACgcOgLKquvm2oZ7eW3FUyt91KwjjJzWz9simR9aBHj5M2HaxhN
 sBA6vXMl4DQWK5qGY5tV4R6E5n/83dPfRam3Jfw6FttBu8IbyIV7ib1lscd1GVYKX+V5
 VWhA==
X-Gm-Message-State: AOJu0Yw5YC5yZ7kWg9wUfhR5MRt2FTDv+fmm2Zz2OYM0u18dzXXwHAcE
 AhXLElEi3HXRtuPWGpj4EM+aQOtGmy3t4WKRaHMGsUrQnosSsv/BCdwcPnvWrRK+lYCDBLjP3Tc
 c6qtHlrmI7Qr6XUkimbNRDpLPYuFiofgU1A==
X-Gm-Gg: ASbGncvT4Ozh2mXCJxfho6Glqs6nQQ36fopY6VYFAnQ5RYQzMWObfsDxt5vlr72Q8Ud
 ztF8uVMmp0UamNnkcyYeIWMDGk1TB3Bsx+lgaBK/yVdt6R1jA1iUo1KyDcCMalWE6hXMVNhiXGu
 rOxlmdtttrhSlS2ur1KCl0LgV6Q1XffXXZBD4CGTHskzZWB82bLQEStNSnbvwPsEHnptCMZgSHT
 H2ZHh9YyCRO3GPCbdlk6hGKq632P1v3rUcykskChxn7DBx3jD8UajdiOdnThnfohiZIyVU=
X-Google-Smtp-Source: AGHT+IHQayFBXIMSMd67/JXzqQlwQ9V5oFHnAgvUUoM+kEHUIRMDOrqqMpxoRAzLKEBWuB0T0Rnh0pol6dGq2Uj793o=
X-Received: by 2002:a17:902:ea0b:b0:275:c066:33dd with SMTP id
 d9443c01a7336-2951a4de313mr27965385ad.10.1761920507861; Fri, 31 Oct 2025
 07:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250911114155.24786-1-tvrtko.ursulin@igalia.com>
 <CADnq5_OD2FoiNxj3FqrqQSLCs7h_a-4uRy5ucceEA+Px-5Ea7w@mail.gmail.com>
 <b9edaad2-06bf-4b6e-95a3-9b5ba0e37b86@igalia.com>
 <CADnq5_PPiCaAqv5juRjRSEpS4K6HQ6Wz0He8-2UqafANqD5qdg@mail.gmail.com>
 <91bfc3fa-a742-4e86-a534-0c6c1c936894@igalia.com>
 <CADnq5_MFmzZ9T6eDo79hVFhmzhUTey4dEV95dA8rqvmyby5w3g@mail.gmail.com>
 <9b87aaad-f766-4d96-93d8-c5261816e429@igalia.com>
In-Reply-To: <9b87aaad-f766-4d96-93d8-c5261816e429@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 31 Oct 2025 10:21:35 -0400
X-Gm-Features: AWmQ_blH5Ikxb904LGQFsT6IJq2fkcy1vY0Jg-jQAYjSj-N6LLIp25wi-z4W2ZU
Message-ID: <CADnq5_OZJjuywGQWMqg+ZEe_TXwYBaWcAROEGrGenV9cPjB3bQ@mail.gmail.com>
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

On Fri, Oct 31, 2025 at 4:44=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@igalia.com> wrote:
>
>
> On 24/10/2025 18:03, Alex Deucher wrote:
> > On Fri, Oct 24, 2025 at 12:36=E2=80=AFPM Tvrtko Ursulin
> > <tvrtko.ursulin@igalia.com> wrote:
> >>
> >>
> >> On 24/10/2025 17:11, Alex Deucher wrote:
> >>> On Wed, Oct 8, 2025 at 10:28=E2=80=AFAM Tvrtko Ursulin
> >>> <tvrtko.ursulin@igalia.com> wrote:
> >>>>
> >>>>
> >>>> On 08/10/2025 15:08, Alex Deucher wrote:
> >>>>> Applied the series.  Thanks!
> >>>>
> >>>> Thank you and fingers crossed I did not fat finger anything that you=
r CI
> >>>> wouldn't find!
> >>>
> >>> Sorry for the late reply.  This series broke the VCN IB tests on at
> >>> least navi4x.  The issue is a GPUVM page fault caused by VCN when
> >>> running the IB tests.
> >>> I don't see any obvious problems with the patches, but I haven't had =
a
> >>> chance to dig too much further.
> >>
> >> Oh I see the problem.. sorry about that.
> >>
> >> I missed the fact that after amdgpu_vcn_unified_ring_ib_header() I nee=
d
> >> to update the pointer.
> >>
> >> Good news is that only VCN has this pattern.
> >>
> >> Okay to send a fix next week? Would you need a fixup or a replacement
> >> patch in case you want to revert it in the meantime?
> >
> > Fixup is fine.  I'll squash it into the original VCN patch and give it
> > a test next week.
>
> How did it go? I noticed amd-staging-drm-next currently has the original
> buggy version.

Those were reverted.

>
> Given other patches from the series are also missing perhaps you are
> testing it in stages?

I was running it through CI again and noticed that polaris seems to
regress with these changes, so likely related to the VCE or UVD v6
changes.

Alex

>
> Regards,
>
> Tvrtko
>
> >>>> I wish something similar could be done for amdgpu_ring_write too, bu=
t
> >>>> that one is waiting on Christian to, AFAIR, become idle enough to
> >>>> untangle some ptr masking issues.
> >>>>
> >>>> Regards,
> >>>>
> >>>> Tvrtko
> >>>>
> >>>>> On Thu, Sep 11, 2025 at 7:42=E2=80=AFAM Tvrtko Ursulin
> >>>>> <tvrtko.ursulin@igalia.com> wrote:
> >>>>>>
> >>>>>> In short, this series mostly does a lot of replacing of this patte=
rn:
> >>>>>>
> >>>>>>           ib->ptr[ib->length_dw++] =3D SDMA_PKT_HEADER_OP(SDMA_OP_=
WRITE) |
> >>>>>>                   SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> >>>>>>           ib->ptr[ib->length_dw++] =3D lower_32_bits(pe);
> >>>>>>           ib->ptr[ib->length_dw++] =3D upper_32_bits(pe);
> >>>>>>           ib->ptr[ib->length_dw++] =3D ndw - 1;
> >>>>>>           for (; ndw > 0; ndw -=3D 2) {
> >>>>>>                  ib->ptr[ib->length_dw++] =3D lower_32_bits(value)=
;
> >>>>>>                  ib->ptr[ib->length_dw++] =3D upper_32_bits(value)=
;
> >>>>>>                   value +=3D incr;
> >>>>>>           }
> >>>>>>
> >>>>>> With this one:
> >>>>>>
> >>>>>>           u32 *ptr =3D &ib->ptr[ib->length_dw];
> >>>>>>
> >>>>>>           *ptr++ =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> >>>>>>                    SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR)=
;
> >>>>>>           *ptr++ =3D lower_32_bits(pe);
> >>>>>>           *ptr++ =3D upper_32_bits(pe);
> >>>>>>           *ptr++ =3D ndw - 1;
> >>>>>>           for (; ndw > 0; ndw -=3D 2) {
> >>>>>>                   *ptr++ =3D lower_32_bits(value);
> >>>>>>                   *ptr++ =3D upper_32_bits(value);
> >>>>>>                    value +=3D incr;
> >>>>>>            }
> >>>>>>
> >>>>>>           ib->length_dw =3D ptr - ib->ptr;
> >>>>>>
> >>>>>> Latter avoids register reloads and length updates on every dword w=
ritten, and on
> >>>>>> the overall makes the IB emission much more compact:
> >>>>>>
> >>>>>> add/remove: 0/1 grow/shrink: 10/58 up/down: 260/-6598 (-6338)
> >>>>>> Function                                     old     new   delta
> >>>>>> sdma_v7_0_ring_pad_ib                         99     127     +28
> >>>>>> sdma_v6_0_ring_pad_ib                         99     127     +28
> >>>>>> sdma_v5_2_ring_pad_ib                         99     127     +28
> >>>>>> sdma_v5_0_ring_pad_ib                         99     127     +28
> >>>>>> sdma_v4_4_2_ring_pad_ib                       99     127     +28
> >>>>>> sdma_v4_0_ring_pad_ib                         99     127     +28
> >>>>>> sdma_v3_0_ring_pad_ib                         99     127     +28
> >>>>>> sdma_v2_4_ring_pad_ib                         99     127     +28
> >>>>>> cik_sdma_ring_pad_ib                          99     127     +28
> >>>>>> si_dma_ring_pad_ib                            36      44      +8
> >>>>>> amdgpu_ring_generic_pad_ib                    56      52      -4
> >>>>>> si_dma_emit_fill_buffer                      108      71     -37
> >>>>>> si_dma_vm_write_pte                          158     115     -43
> >>>>>> amdgpu_vcn_dec_sw_send_msg                   810     767     -43
> >>>>>> si_dma_vm_copy_pte                           137      87     -50
> >>>>>> si_dma_emit_copy_buffer                      134      84     -50
> >>>>>> sdma_v3_0_vm_write_pte                       163     102     -61
> >>>>>> sdma_v2_4_vm_write_pte                       163     102     -61
> >>>>>> cik_sdma_vm_write_pte                        163     102     -61
> >>>>>> sdma_v7_0_vm_write_pte                       168     105     -63
> >>>>>> sdma_v7_0_emit_fill_buffer                   119      56     -63
> >>>>>> sdma_v6_0_vm_write_pte                       168     105     -63
> >>>>>> sdma_v6_0_emit_fill_buffer                   119      56     -63
> >>>>>> sdma_v5_2_vm_write_pte                       168     105     -63
> >>>>>> sdma_v5_2_emit_fill_buffer                   119      56     -63
> >>>>>> sdma_v5_0_vm_write_pte                       168     105     -63
> >>>>>> sdma_v5_0_emit_fill_buffer                   119      56     -63
> >>>>>> sdma_v4_4_2_vm_write_pte                     168     105     -63
> >>>>>> sdma_v4_4_2_emit_fill_buffer                 119      56     -63
> >>>>>> sdma_v4_0_vm_write_pte                       168     105     -63
> >>>>>> sdma_v4_0_emit_fill_buffer                   119      56     -63
> >>>>>> sdma_v3_0_emit_fill_buffer                   116      53     -63
> >>>>>> sdma_v2_4_emit_fill_buffer                   116      53     -63
> >>>>>> cik_sdma_emit_fill_buffer                    116      53     -63
> >>>>>> sdma_v6_0_emit_copy_buffer                   169      76     -93
> >>>>>> sdma_v5_2_emit_copy_buffer                   169      76     -93
> >>>>>> sdma_v5_0_emit_copy_buffer                   169      76     -93
> >>>>>> sdma_v4_4_2_emit_copy_buffer                 169      76     -93
> >>>>>> sdma_v4_0_emit_copy_buffer                   169      76     -93
> >>>>>> sdma_v3_0_vm_copy_pte                        158      64     -94
> >>>>>> sdma_v3_0_emit_copy_buffer                   155      61     -94
> >>>>>> sdma_v2_4_vm_copy_pte                        158      64     -94
> >>>>>> sdma_v2_4_emit_copy_buffer                   155      61     -94
> >>>>>> cik_sdma_vm_copy_pte                         158      64     -94
> >>>>>> cik_sdma_emit_copy_buffer                    155      61     -94
> >>>>>> sdma_v6_0_vm_copy_pte                        163      68     -95
> >>>>>> sdma_v5_2_vm_copy_pte                        163      68     -95
> >>>>>> sdma_v5_0_vm_copy_pte                        163      68     -95
> >>>>>> sdma_v4_4_2_vm_copy_pte                      163      68     -95
> >>>>>> sdma_v4_0_vm_copy_pte                        163      68     -95
> >>>>>> sdma_v7_0_vm_copy_pte                        183      75    -108
> >>>>>> sdma_v7_0_emit_copy_buffer                   317     202    -115
> >>>>>> si_dma_vm_set_pte_pde                        338     214    -124
> >>>>>> amdgpu_vce_get_destroy_msg                   784     652    -132
> >>>>>> sdma_v7_0_vm_set_pte_pde                     218      72    -146
> >>>>>> sdma_v6_0_vm_set_pte_pde                     218      72    -146
> >>>>>> sdma_v5_2_vm_set_pte_pde                     218      72    -146
> >>>>>> sdma_v5_0_vm_set_pte_pde                     218      72    -146
> >>>>>> sdma_v4_4_2_vm_set_pte_pde                   218      72    -146
> >>>>>> sdma_v4_0_vm_set_pte_pde                     218      72    -146
> >>>>>> sdma_v3_0_vm_set_pte_pde                     215      69    -146
> >>>>>> sdma_v2_4_vm_set_pte_pde                     215      69    -146
> >>>>>> cik_sdma_vm_set_pte_pde                      215      69    -146
> >>>>>> amdgpu_vcn_unified_ring_ib_header            172       -    -172
> >>>>>> gfx_v9_4_2_run_shader.constprop              739     532    -207
> >>>>>> uvd_v6_0_enc_ring_test_ib                   1464    1162    -302
> >>>>>> uvd_v7_0_enc_ring_test_ib                   1464    1138    -326
> >>>>>> amdgpu_vce_ring_test_ib                     1357     936    -421
> >>>>>> amdgpu_vcn_enc_ring_test_ib                 2042    1524    -518
> >>>>>> Total: Before=3D9262623, After=3D9256285, chg -0.07%
> >>>>>>
> >>>>>> * Notice how _pad_ib functions have grown. I think the compiler us=
ed the
> >>>>>> opportunity to unroll the loops.
> >>>>>>
> >>>>>> ** Series was only smoke tested on the Steam Deck.
> >>>>>>
> >>>>>> Tvrtko Ursulin (16):
> >>>>>>      drm/amdgpu: Use memset32 for IB padding
> >>>>>>      drm/amdgpu: More compact VCE IB emission
> >>>>>>      drm/amdgpu: More compact VCN IB emission
> >>>>>>      drm/amdgpu: More compact UVD 6 IB emission
> >>>>>>      drm/amdgpu: More compact UVD 7 IB emission
> >>>>>>      drm/amdgpu: More compact SI SDMA emission
> >>>>>>      drm/amdgpu: More compact CIK SDMA IB emission
> >>>>>>      drm/amdgpu: More compact GFX 9.4.2 IB emission
> >>>>>>      drm/amdgpu: More compact SDMA 2.4 IB emission
> >>>>>>      drm/amdgpu: More compact SDMA 3.0 IB emission
> >>>>>>      drm/amdgpu: More compact SDMA 4.0 IB emission
> >>>>>>      drm/amdgpu: More compact SDMA 4.4.2 IB emission
> >>>>>>      drm/amdgpu: More compact SDMA 5.0 IB emission
> >>>>>>      drm/amdgpu: More compact SDMA 5.2 IB emission
> >>>>>>      drm/amdgpu: More compact SDMA 6.0 IB emission
> >>>>>>      drm/amdgpu: More compact SDMA 7.0 IB emission
> >>>>>>
> >>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  12 ++-
> >>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c  |  90 +++++++++------=
--
> >>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 101 ++++++++++-----=
----
> >>>>>>     drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 105 ++++++++++++---=
-----
> >>>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c  |  46 ++++-----
> >>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 108 ++++++++++++---=
-----
> >>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 108 ++++++++++++---=
-----
> >>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 109 ++++++++++++---=
------
> >>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 108 ++++++++++++---=
-----
> >>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 106 ++++++++++++---=
-----
> >>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 110 ++++++++++++---=
------
> >>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 110 ++++++++++++---=
------
> >>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 119 +++++++++++++--=
--------
> >>>>>>     drivers/gpu/drm/amd/amdgpu/si_dma.c      |  84 +++++++++------=
-
> >>>>>>     drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  66 +++++++------
> >>>>>>     drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  66 +++++++------
> >>>>>>     16 files changed, 849 insertions(+), 599 deletions(-)
> >>>>>>
> >>>>>> --
> >>>>>> 2.48.0
> >>>>>>
> >>>>
> >>
>
