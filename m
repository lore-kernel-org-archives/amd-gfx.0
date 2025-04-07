Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC63C36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 20:37:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B762510E132;
	Mon,  7 Apr 2025 20:37:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iUnRBsa8";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B6910E132
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 20:37:11 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-af9a6958a08so320193a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 13:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744058230; x=1744663030; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1N6m/xOb6cG3iyBsGAVldTl1vMrCfcutO/20bATloS8=;
 b=iUnRBsa8d0oam3mqp4aND6pUDpOCthDp/W5IgczWKR+swpNSHtgDjNV0GPjonNNrgW
 gWP6o6M6Ciw7oXbB0H3QuJgDXWY6kK6xM3wsvmrzc94PvRJaOb5vr0tCToVVuaf+RJVq
 pq/yrBqvFYRujJE0FA68tblm/uwYlLglL6BQt9ODRUchmrzNXPfZCSzdl636QU3cXpUz
 Trmnq5F6y48zwPCkXBGBvq8vVMjebmkP/9mthwRYcxq5zmIRNcUdTpyXqCYC4CZ9lCiy
 8zhl4rBurBEUr9nAjYkgVb4gR4kCqFR/um0/wimR0yShG6Gscdk3Us1Zizp9ZQ8RKsF2
 XMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744058231; x=1744663031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1N6m/xOb6cG3iyBsGAVldTl1vMrCfcutO/20bATloS8=;
 b=nUgDiQElsOC53b+F9nJ3MLoVic1p+RBb00mAJKsju+1DhHh06TB55us6r+VXC/HlIg
 ewaAiOqRXnqRzEyrPY5fRMdfOVcXwzOr5siGTEOU0QwdAbGwErZ+0Azh15gC4uXLAtbe
 ie3YV4BbWPzM+TT0MuAJ4gd4m8G/IBF8C61Pe8yQjrdeBVtWG7sCkIaPgs5ouCukabLK
 GlRAu20xn0UOwngPDzAAIMGnoDkwg6fFmyoks/vco5BFP1pQBq54fhWWyLCVM6WrhFbn
 iQRzu9Ma1ES1TpR+bHj7ccLoIgtG6wq2EdZNcteFd1V0umNH4eTYGH50j807e48GqEHX
 unkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWLHgeZOVfvaXg3vtNNGM0X6w0HVhWE0co/S1XkMSBcXlX6QoY1twwCCf747g5agSFeXt5Sxi6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOZpE2ncaDzdVdhgaQ8Nzf28TzXplNszkaU6ugeWP7wYUCJ+3Q
 YQMPVrlpJozdu3ZwWgoyRafGUvSaDG6MOpdUVL3OYeXViUkt8FCE8sFrYfKJtjCubImutt/HgC1
 sv7KhVWRNHHPyH5yPY14cdMLmN9xkE67D
X-Gm-Gg: ASbGnctXRnJgAIHPD4gfNJvShH6thPGWuMNdtrQazjWs6UheCuqhFAG0yVBe9SrYJ0t
 gWcYIzvxdtPDKxPBdzAUQt4aOPo5P32xATs2EiG71vMoX33ng7rLM9YDh67qWGXYlXOpAoOz2cx
 JH7H8TH2YPLt7FOxCUvgKdC5AQKg==
X-Google-Smtp-Source: AGHT+IGcDWhSTYQY10e3ucDP1FiHNqe5ntFRuYhB/SxJ1t6r9eMIK9JX3rWfMlP/BP2TUU0nC878lhZbdAvllP7xMTk=
X-Received: by 2002:a17:903:17ce:b0:224:1039:2daa with SMTP id
 d9443c01a7336-22a8a1ba6d1mr70941085ad.13.1744058230511; Mon, 07 Apr 2025
 13:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250406230703.2128148-1-siqueira@igalia.com>
 <CADnq5_PXoWLMdG4a+pHkPn2PipgoNvb92-o8MVqEYxr+PVznKQ@mail.gmail.com>
 <ly3qevhqrqpnze5ffr5pwcybxsvy2u5oh743pdom4cl2fzndq5@mp42hlwy7hat>
In-Reply-To: <ly3qevhqrqpnze5ffr5pwcybxsvy2u5oh743pdom4cl2fzndq5@mp42hlwy7hat>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 16:36:58 -0400
X-Gm-Features: ATxdqUF6wo6LMxaRLj-dw-DwJWYLplnfuIiaMHCg6kBGpDjaYXj3NYzOoxx530c
Message-ID: <CADnq5_NnXesMiqGf6P=YB8etqcsa1x7M=KtDH_XfR1dmVqiHZQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Introduce a generic function to get the CSB buffer
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
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

On Mon, Apr 7, 2025 at 4:15=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.co=
m> wrote:
>
> On 04/07, Alex Deucher wrote:
> > On Sun, Apr 6, 2025 at 7:07=E2=80=AFPM Rodrigo Siqueira <siqueira@igali=
a.com> wrote:
> > >
> > > This patchset was inspired and made on top of the below series:
> > >
> > > https://lore.kernel.org/amd-gfx/20250319162225.3775315-1-alexander.de=
ucher@amd.com/
> > >
> > > In the above series, there is a bug fix in many functions named
> > > gfx_vX_0_get_csb_buffer (where X ranges from 6 to 11). After closely
> > > looking at those functions, it became clear that most of the code cou=
ld
> > > be shared from gfx6 to gfx11. Aside from the code duplication removal=
,
> > > this also improves maintainability since a bug fix in a shared functi=
on
> > > can be propagated to all ASICs.
> > >
> > > The first patch of this series created one dedicated file for
> > > encapsulating common GC registers (gc_common_offset.h); this series o=
nly
> > > adds registers associated with the CSB. In the future, this file can
> > > keep growing as we identify common registers to be shared in the
> > > gc_common_offset.h.
> > >
> > > The second patch introduces the generic gfx_get_csb_buffer function,
> > > which has the same implementation found in gfx_v10_0_get_csb_buffer a=
nd
> > > gfx_v11_0_get_csb_buffer (these two functions have the same code). Af=
ter
> > > that, every patch is dedicated to absorbing one of the csb_buffer
> > > functions from gfx from 9 to 6; notice that some adaptations were
> > > required.
> >
> > I don't really like the register header changes and moving all of the
> > IP version specific logic into the common code.  These register
> > headers are used in other places as well and moving some registers
> > into a common header can get confusing and may lead to bugs later if
> > other chips change the offset of these registers.
>
> In that case, what do you think if I just abstract the first part of the
> function for a V2? The first part is the same for all gfx from 6 to 11.
> Something like this:
>
> int gfx_get_pre_setup_csb_buffer(struct amdgpu_device *adev, volatile u32=
 *buffer)
> {
>        u32 count =3D 0, i;
>        const struct cs_section_def *sect =3D NULL;
>        const struct cs_extent_def *ext =3D NULL;
>        int ctx_reg_offset;
>
>        if (adev->gfx.rlc.cs_data =3D=3D NULL)
>                return 1;
>        if (buffer =3D=3D NULL)
>                return 1;
>
>        buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0))=
;
>        buffer[count++] =3D cpu_to_le32(PACKET3_PREAMBLE_BEGIN_CLEAR_STATE=
);
>
>        buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_CONTEXT_CONTROL, 1=
));
>        buffer[count++] =3D cpu_to_le32(0x80000000);
>        buffer[count++] =3D cpu_to_le32(0x80000000);
>
>        for (sect =3D adev->gfx.rlc.cs_data; sect->section !=3D NULL; ++se=
ct) {
>                for (ext =3D sect->section; ext->extent !=3D NULL; ++ext) =
{
>                        if (sect->id =3D=3D SECT_CONTEXT) {
>                                buffer[count++] =3D
>                                        cpu_to_le32(PACKET3(PACKET3_SET_CO=
NTEXT_REG, ext->reg_count));
>                                buffer[count++] =3D cpu_to_le32(ext->reg_i=
ndex -
>                                                PACKET3_SET_CONTEXT_REG_ST=
ART);
>                                for (i =3D 0; i < ext->reg_count; i++)
>                                        buffer[count++] =3D cpu_to_le32(ex=
t->extent[i]);
>                        }
>                }
>        }
>
>        return 0;
> }

Sure helpers are fine.  maybe a preamble_start helper
        buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
        buffer[count++] =3D cpu_to_le32(PACKET3_PREAMBLE_BEGIN_CLEAR_STATE)=
;

        buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_CONTEXT_CONTROL, 1)=
);
        buffer[count++] =3D cpu_to_le32(0x80000000);
        buffer[count++] =3D cpu_to_le32(0x80000000);
and a preamble_end helper:
        buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
        buffer[count++] =3D cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_STATE);

        buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_CLEAR_STATE, 0));
        buffer[count++] =3D cpu_to_le32(0);
and a cs_data parser helper:
        for (sect =3D adev->gfx.rlc.cs_data; sect->section !=3D NULL; ++sec=
t) {
            for (ext =3D sect->section; ext->extent !=3D NULL; ++ext) {
                        if (sect->id =3D=3D SECT_CONTEXT) {
                buffer[count++] =3D

cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, ext->reg_count));
                                buffer[count++] =3D cpu_to_le32(ext->reg_in=
dex -
                                                PACKET3_SET_CONTEXT_REG_STA=
RT);
                                for (i =3D 0; i < ext->reg_count; i++)
                                        buffer[count++] =3D
cpu_to_le32(ext->extent[i]);
                        }
                }
    }

Also, while you are at it, you could clean up gfx_v9_0_cp_gfx_start(),
etc. to use the cs buffer and cs size directly rather than re-parsing
everything again.

Alex

>
> Thanks
>
> >
> > Alex
> >
> > >
> > > Thanks
> > >
> > > Rodrigo Siqueira (6):
> > >   drm/amd/amdgpu: Create a headears to keep some common GC registers
> > >   drm/amdgpu/gfx: Introduce generic gfx_get_csb_buffer
> > >   drm/amdgpu/gfx: Integrate gfx_v9_0_get_csb_buffer into
> > >     gfx_get_csb_buffer
> > >   drm/amdgpu/gfx: Absorb gfx_v8_0_get_csb_buffer into gfx_get_csb_buf=
fer
> > >   drm/amdgpu/gfx: Assimilate gfx_v7_0_get_csb_buffer into
> > >     gfx_get_csb_buffer
> > >   drm/amdgpu/gfx: Merge gfx_v6_0_get_csb_buffer into gfx_get_csb_buff=
er
> > >
> > >  Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   3 +
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 101 ++++++++++++++++=
++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   1 +
> > >  drivers/gpu/drm/amd/amdgpu/cik.c              |   2 +
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  51 +--------
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  53 +--------
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |  46 +-------
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  70 +-----------
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  51 +--------
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  43 +-------
> > >  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |   1 +
> > >  drivers/gpu/drm/amd/amdgpu/si.c               |   2 +
> > >  drivers/gpu/drm/amd/amdgpu/vi.c               |   2 +
> > >  .../include/asic_reg/gc/gc_10_1_0_offset.h    |   3 -
> > >  .../include/asic_reg/gc/gc_10_3_0_offset.h    |   3 -
> > >  .../include/asic_reg/gc/gc_11_0_0_offset.h    |   2 -
> > >  .../include/asic_reg/gc/gc_11_0_3_offset.h    |   2 -
> > >  .../include/asic_reg/gc/gc_11_5_0_offset.h    |   2 -
> > >  .../include/asic_reg/gc/gc_12_0_0_offset.h    |   2 -
> > >  .../amd/include/asic_reg/gc/gc_9_0_offset.h   |   3 -
> > >  .../amd/include/asic_reg/gc/gc_9_1_offset.h   |   3 -
> > >  .../amd/include/asic_reg/gc/gc_9_2_1_offset.h |   3 -
> > >  .../amd/include/asic_reg/gc/gc_9_4_2_offset.h |   2 -
> > >  .../amd/include/asic_reg/gc/gc_9_4_3_offset.h |   2 -
> > >  .../include/asic_reg/gc/gc_common_offset.h    |  11 ++
> > >  .../drm/amd/include/asic_reg/gca/gfx_6_0_d.h  |   1 -
> > >  .../drm/amd/include/asic_reg/gca/gfx_7_0_d.h  |   1 -
> > >  .../drm/amd/include/asic_reg/gca/gfx_7_2_d.h  |   1 -
> > >  .../drm/amd/include/asic_reg/gca/gfx_8_0_d.h  |   1 -
> > >  .../drm/amd/include/asic_reg/gca/gfx_8_1_d.h  |   1 -
> > >  30 files changed, 141 insertions(+), 328 deletions(-)
> > >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_common=
_offset.h
> > >
> > > --
> > > 2.49.0
> > >
>
> --
> Rodrigo Siqueira
