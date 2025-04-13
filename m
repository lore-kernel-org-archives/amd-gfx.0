Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013CFC3601E
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Apr 2025 13:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6A110E041;
	Sun, 13 Apr 2025 13:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="biBmc6Xz";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A28410E041
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Apr 2025 13:12:08 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2ff5544af03so1127989a91.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Apr 2025 06:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744549928; x=1745154728; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcY4P3P0o2GNXzkcRhaipxIdGOtV0h3c2Wfmqy6Dmpw=;
 b=biBmc6Xzu51wZ7GrWjXojmrTrRN6j1eBDJnl0aMOHaVdFeLdS1+TTVSilljvFNvxdj
 IZJn9mvnDuAq6EwkAAylfQizctz5csF82YjFxk2HQ2DiNLFZmTGKFxRjR4m10muLjpO2
 Iv/BWRYZfVO1+ARlvrKIFbqggA4Marvq2Oc8hdnW+SFIU3SIuPLs+eKEnMTps575mymJ
 mUNFe7NROJeX2GmFplg+rCEr2d+6SshrNnnFKMhha1B41BAsNrfCYiobt2ofBBStiT2U
 LQWU7wzIeVkpQNciojfAa+vUHE86eRE5xIkmljn1zRn4Hb5Kav3rEIPc/l2HjtiXumGi
 goQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744549928; x=1745154728;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QcY4P3P0o2GNXzkcRhaipxIdGOtV0h3c2Wfmqy6Dmpw=;
 b=U7dDyBb04jnPmIRfhju7zVdrIoYDFpX2cuTkMZMaB0gNcxPjjVG4a8sOtLSB/E/cMg
 ve2pSRV4KUJDVusrlBLdetAPl5LPwKifW6W59RHhaRcexpkB2+c5xw4sEaRiBBuAcPOi
 t++ncO2sqJcO6bKySzFnvM5K4+YxHyTvp/wLixmRbmXE0o7PIRT+19Xg7TaQh6+51wX3
 HhumKnCn595Yaq+nql14md6pvHDOfqthTxtZW2FvlEbhqkKbhdihPP6FVxdGXjEUG/Vt
 ZVMOiMETLv+yllt4WtVcIq45wadGa9QunWHTQ0WYXBZMvfzHv4897etVmFBooVZY0IEb
 dlXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaQ49hYUUqerDw0BmsFyjfdAvkI6FguS7XJo6Au58NxB1Ey7l5OWkWkz4imo6OHU9nW7LT+wDJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzI0FwuwMalXWHGfQXLxJxQFHV8zVs3aGwZyK2L1nqb79VrmKj5
 cY6sRcy34AW+k+lezzZRH6j0yH6G7fxAG3Xim6jXIQK9ID5EqP/CfE2JspHqN2PhwYJ1XG4egQT
 uwbG5omMsLyF0PQiajuG8diQyEig=
X-Gm-Gg: ASbGnctZzmmFgR8dqnCcPOLoVNUfmvwf5ADbcU7n3zk1UbEUxc3adP/95qL7U+CdXGi
 6wuYMCPKdFnql9tFyCiIyNm3FM0hzTjVLNONFaA4n2BGrDJ4u5D3eV6iAnx3S5B+6bMaqm80bDg
 P16l2rdpqZzKSIA1ZVX0c79LkezkjOrSYT
X-Google-Smtp-Source: AGHT+IGQsEE4rJBdrA8rb0R69s+KlnUHNYthwkidGWGDZgKt9y7p+AsvYkPINrl+gdE7igXP74MNSQlEzPtYlpzk42g=
X-Received: by 2002:a17:90b:1e51:b0:2ff:7970:d2bd with SMTP id
 98e67ed59e1d1-30823681347mr5303545a91.5.1744549927950; Sun, 13 Apr 2025
 06:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250406230703.2128148-1-siqueira@igalia.com>
 <CADnq5_PXoWLMdG4a+pHkPn2PipgoNvb92-o8MVqEYxr+PVznKQ@mail.gmail.com>
 <ly3qevhqrqpnze5ffr5pwcybxsvy2u5oh743pdom4cl2fzndq5@mp42hlwy7hat>
 <CADnq5_NnXesMiqGf6P=YB8etqcsa1x7M=KtDH_XfR1dmVqiHZQ@mail.gmail.com>
 <k7ukvkqvpodu4pdxth6wlupdkvuxvwkogwh2del7ufsyuivvhu@khxucl2prbgp>
 <fq2r7oij76iwepoggzvldubmseprrfkbwkfgrhy3i5chmvrate@ytw3ijcf2znl>
In-Reply-To: <fq2r7oij76iwepoggzvldubmseprrfkbwkfgrhy3i5chmvrate@ytw3ijcf2znl>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 13 Apr 2025 09:11:56 -0400
X-Gm-Features: ATxdqUFVMniVN0f5l2_M3sEywaJHJbH8kh9icMwtoKgZo37JFuFJzvUwHnlAqhU
Message-ID: <CADnq5_NAGvaJ1-7+_NZQszLspHcCudRSKKHkezJBEQg0GmEq9Q@mail.gmail.com>
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

On Sat, Apr 12, 2025 at 4:29=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 04/08, Rodrigo Siqueira wrote:
> > On 04/07, Alex Deucher wrote:
> > > On Mon, Apr 7, 2025 at 4:15=E2=80=AFPM Rodrigo Siqueira <siqueira@iga=
lia.com> wrote:
> > > >
> > > > On 04/07, Alex Deucher wrote:
> > > > > On Sun, Apr 6, 2025 at 7:07=E2=80=AFPM Rodrigo Siqueira <siqueira=
@igalia.com> wrote:
> > > > > >
> > > > > > This patchset was inspired and made on top of the below series:
> > > > > >
> > > > > > https://lore.kernel.org/amd-gfx/20250319162225.3775315-1-alexan=
der.deucher@amd.com/
> > > > > >
> > > > > > In the above series, there is a bug fix in many functions named
> > > > > > gfx_vX_0_get_csb_buffer (where X ranges from 6 to 11). After cl=
osely
> > > > > > looking at those functions, it became clear that most of the co=
de could
> > > > > > be shared from gfx6 to gfx11. Aside from the code duplication r=
emoval,
> > > > > > this also improves maintainability since a bug fix in a shared =
function
> > > > > > can be propagated to all ASICs.
> > > > > >
> > > > > > The first patch of this series created one dedicated file for
> > > > > > encapsulating common GC registers (gc_common_offset.h); this se=
ries only
> > > > > > adds registers associated with the CSB. In the future, this fil=
e can
> > > > > > keep growing as we identify common registers to be shared in th=
e
> > > > > > gc_common_offset.h.
> > > > > >
> > > > > > The second patch introduces the generic gfx_get_csb_buffer func=
tion,
> > > > > > which has the same implementation found in gfx_v10_0_get_csb_bu=
ffer and
> > > > > > gfx_v11_0_get_csb_buffer (these two functions have the same cod=
e). After
> > > > > > that, every patch is dedicated to absorbing one of the csb_buff=
er
> > > > > > functions from gfx from 9 to 6; notice that some adaptations we=
re
> > > > > > required.
> > > > >
> > > > > I don't really like the register header changes and moving all of=
 the
> > > > > IP version specific logic into the common code.  These register
> > > > > headers are used in other places as well and moving some register=
s
> > > > > into a common header can get confusing and may lead to bugs later=
 if
> > > > > other chips change the offset of these registers.
> > > >
> > > > In that case, what do you think if I just abstract the first part o=
f the
> > > > function for a V2? The first part is the same for all gfx from 6 to=
 11.
> > > > Something like this:
> > > >
> > > > int gfx_get_pre_setup_csb_buffer(struct amdgpu_device *adev, volati=
le u32 *buffer)
> > > > {
> > > >        u32 count =3D 0, i;
> > > >        const struct cs_section_def *sect =3D NULL;
> > > >        const struct cs_extent_def *ext =3D NULL;
> > > >        int ctx_reg_offset;
> > > >
> > > >        if (adev->gfx.rlc.cs_data =3D=3D NULL)
> > > >                return 1;
> > > >        if (buffer =3D=3D NULL)
> > > >                return 1;
> > > >
> > > >        buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNT=
L, 0));
> > > >        buffer[count++] =3D cpu_to_le32(PACKET3_PREAMBLE_BEGIN_CLEAR=
_STATE);
> > > >
> > > >        buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_CONTEXT_CONT=
ROL, 1));
> > > >        buffer[count++] =3D cpu_to_le32(0x80000000);
> > > >        buffer[count++] =3D cpu_to_le32(0x80000000);
> > > >
> > > >        for (sect =3D adev->gfx.rlc.cs_data; sect->section !=3D NULL=
; ++sect) {
> > > >                for (ext =3D sect->section; ext->extent !=3D NULL; +=
+ext) {
> > > >                        if (sect->id =3D=3D SECT_CONTEXT) {
> > > >                                buffer[count++] =3D
> > > >                                        cpu_to_le32(PACKET3(PACKET3_=
SET_CONTEXT_REG, ext->reg_count));
> > > >                                buffer[count++] =3D cpu_to_le32(ext-=
>reg_index -
> > > >                                                PACKET3_SET_CONTEXT_=
REG_START);
> > > >                                for (i =3D 0; i < ext->reg_count; i+=
+)
> > > >                                        buffer[count++] =3D cpu_to_l=
e32(ext->extent[i]);
> > > >                        }
> > > >                }
> > > >        }
> > > >
> > > >        return 0;
> > > > }
> > >
> > > Sure helpers are fine.  maybe a preamble_start helper
> > >         buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL=
, 0));
> > >         buffer[count++] =3D cpu_to_le32(PACKET3_PREAMBLE_BEGIN_CLEAR_=
STATE);
> > >
> > >         buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_CONTEXT_CONTR=
OL, 1));
> > >         buffer[count++] =3D cpu_to_le32(0x80000000);
> > >         buffer[count++] =3D cpu_to_le32(0x80000000);
> > > and a preamble_end helper:
> > >         buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL=
, 0));
> > >         buffer[count++] =3D cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_ST=
ATE);
> > >
> > >         buffer[count++] =3D cpu_to_le32(PACKET3(PACKET3_CLEAR_STATE, =
0));
> > >         buffer[count++] =3D cpu_to_le32(0);
> > > and a cs_data parser helper:
> > >         for (sect =3D adev->gfx.rlc.cs_data; sect->section !=3D NULL;=
 ++sect) {
> > >             for (ext =3D sect->section; ext->extent !=3D NULL; ++ext)=
 {
> > >                         if (sect->id =3D=3D SECT_CONTEXT) {
> > >                 buffer[count++] =3D
> > >
> > > cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, ext->reg_count));
> > >                                 buffer[count++] =3D cpu_to_le32(ext->=
reg_index -
> > >                                                 PACKET3_SET_CONTEXT_R=
EG_START);
> > >                                 for (i =3D 0; i < ext->reg_count; i++=
)
> > >                                         buffer[count++] =3D
> > > cpu_to_le32(ext->extent[i]);
> > >                         }
> > >                 }
> > >     }
> >
> > Nice. I'll prepare a V2.
> >
> > >
> > > Also, while you are at it, you could clean up gfx_v9_0_cp_gfx_start()=
,
> > > etc. to use the cs buffer and cs size directly rather than re-parsing
> > > everything again.
>
> I was looking into the gfx_vX_0_cp_gfx_start() functions, but I was
> slightly confused about how to approach this part. I can see from
> gfx_vX_0_cp_gfx_start() that a preamble start, parser, and preamble end
> are common parts, but I felt I could not re-use some of the helpers
> created in the V2 of this series because gfx_vX_0_cp_gfx_start() writes
> directly in the ring buffer and it has some special checks. Should I
> create a dedicated helper for those parts?  Or did I misunderstand what
> you suggested?

We already have the contents of the csb buffer stored in
adev->gfx.rlc.cs_ptr when we call get_csb_buffer().  So in the
gfx_vX_0_cp_gfx_start() functions we can just walk that buffer to
submit the csb to the firmware rather than parsing everything again.
E.g.,

u32 *csb_buffer =3D adev->gfx.rlc.cs_ptr;
u32 csb_size =3D get_csb_size();

amdgpu_ring_alloc(ring, csb_size + 4 + 3);

for (i =3D 0; i < csb_size; i++)
    amdgpu_ring_write(ring, csb_buffer[i]);

amdgpu_ring_write(ring, ...);
...
amdgpu_ring_commit(ring);

Alex

>
> >
> > Sure, I'll make it as a separate patchset.
> >
> > Thanks
> >
> > >
> > > Alex
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Alex
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > Rodrigo Siqueira (6):
> > > > > >   drm/amd/amdgpu: Create a headears to keep some common GC regi=
sters
> > > > > >   drm/amdgpu/gfx: Introduce generic gfx_get_csb_buffer
> > > > > >   drm/amdgpu/gfx: Integrate gfx_v9_0_get_csb_buffer into
> > > > > >     gfx_get_csb_buffer
> > > > > >   drm/amdgpu/gfx: Absorb gfx_v8_0_get_csb_buffer into gfx_get_c=
sb_buffer
> > > > > >   drm/amdgpu/gfx: Assimilate gfx_v7_0_get_csb_buffer into
> > > > > >     gfx_get_csb_buffer
> > > > > >   drm/amdgpu/gfx: Merge gfx_v6_0_get_csb_buffer into gfx_get_cs=
b_buffer
> > > > > >
> > > > > >  Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   3 +
> > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 101 ++++++++++=
++++++++
> > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   1 +
> > > > > >  drivers/gpu/drm/amd/amdgpu/cik.c              |   2 +
> > > > > >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  51 +--------
> > > > > >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  53 +--------
> > > > > >  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |  46 +-------
> > > > > >  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  70 +---------=
--
> > > > > >  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  51 +--------
> > > > > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  43 +-------
> > > > > >  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |   1 +
> > > > > >  drivers/gpu/drm/amd/amdgpu/si.c               |   2 +
> > > > > >  drivers/gpu/drm/amd/amdgpu/vi.c               |   2 +
> > > > > >  .../include/asic_reg/gc/gc_10_1_0_offset.h    |   3 -
> > > > > >  .../include/asic_reg/gc/gc_10_3_0_offset.h    |   3 -
> > > > > >  .../include/asic_reg/gc/gc_11_0_0_offset.h    |   2 -
> > > > > >  .../include/asic_reg/gc/gc_11_0_3_offset.h    |   2 -
> > > > > >  .../include/asic_reg/gc/gc_11_5_0_offset.h    |   2 -
> > > > > >  .../include/asic_reg/gc/gc_12_0_0_offset.h    |   2 -
> > > > > >  .../amd/include/asic_reg/gc/gc_9_0_offset.h   |   3 -
> > > > > >  .../amd/include/asic_reg/gc/gc_9_1_offset.h   |   3 -
> > > > > >  .../amd/include/asic_reg/gc/gc_9_2_1_offset.h |   3 -
> > > > > >  .../amd/include/asic_reg/gc/gc_9_4_2_offset.h |   2 -
> > > > > >  .../amd/include/asic_reg/gc/gc_9_4_3_offset.h |   2 -
> > > > > >  .../include/asic_reg/gc/gc_common_offset.h    |  11 ++
> > > > > >  .../drm/amd/include/asic_reg/gca/gfx_6_0_d.h  |   1 -
> > > > > >  .../drm/amd/include/asic_reg/gca/gfx_7_0_d.h  |   1 -
> > > > > >  .../drm/amd/include/asic_reg/gca/gfx_7_2_d.h  |   1 -
> > > > > >  .../drm/amd/include/asic_reg/gca/gfx_8_0_d.h  |   1 -
> > > > > >  .../drm/amd/include/asic_reg/gca/gfx_8_1_d.h  |   1 -
> > > > > >  30 files changed, 141 insertions(+), 328 deletions(-)
> > > > > >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_=
common_offset.h
> > > > > >
> > > > > > --
> > > > > > 2.49.0
> > > > > >
> > > >
> > > > --
> > > > Rodrigo Siqueira
> >
> > --
> > Rodrigo Siqueira
>
> --
> Rodrigo Siqueira
