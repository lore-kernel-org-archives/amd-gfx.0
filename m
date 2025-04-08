Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443BEC3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 13:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E40C810E233;
	Tue,  8 Apr 2025 13:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="QBl/HB9j";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE3E310E69B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 13:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YUACwuvR+RtUrWdAf10NryMF0Op6tY++1nrDRCNFgms=; b=QBl/HB9j/PL0WnhEp0KH/jvn4P
 n5CC6xAbzp5Q/Zs2sNbOuOMX5gf5KWcJDmkFSXXjTIwkxWQY8pqheMHXbOfdJ45djUGR2OEOi/spQ
 dj2qfrdVYeyMFTK/EpA4R5mvN0O/dbSKl519Ogs6zt1ENy+R3unzFkzBY/5Hv9ybN4wkkGNgFtbQ4
 ruWtpwirKllhL4PqufcNZall2S9n0H+QpyZ2OEAiI5rEcuKeAXf4z2ZsBAsTzQrMBZI3gRicByd9h
 KoqecsyyE0CMdmGZkcvfm6waDVdDYnRV/9qRK3khZfcLeggpWnqrCNwawit/pluFBN8mUuTXPwZJD
 v7OWWA1w==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u28cJ-00DJne-HP; Tue, 08 Apr 2025 15:03:51 +0200
Date: Tue, 8 Apr 2025 07:03:45 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH 0/6] Introduce a generic function to get the CSB buffer
Message-ID: <k7ukvkqvpodu4pdxth6wlupdkvuxvwkogwh2del7ufsyuivvhu@khxucl2prbgp>
References: <20250406230703.2128148-1-siqueira@igalia.com>
 <CADnq5_PXoWLMdG4a+pHkPn2PipgoNvb92-o8MVqEYxr+PVznKQ@mail.gmail.com>
 <ly3qevhqrqpnze5ffr5pwcybxsvy2u5oh743pdom4cl2fzndq5@mp42hlwy7hat>
 <CADnq5_NnXesMiqGf6P=YB8etqcsa1x7M=KtDH_XfR1dmVqiHZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_NnXesMiqGf6P=YB8etqcsa1x7M=KtDH_XfR1dmVqiHZQ@mail.gmail.com>
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

On 04/07, Alex Deucher wrote:
> On Mon, Apr 7, 2025 at 4:15 PM Rodrigo Siqueira <siqueira@igalia.com> wrote:
> >
> > On 04/07, Alex Deucher wrote:
> > > On Sun, Apr 6, 2025 at 7:07 PM Rodrigo Siqueira <siqueira@igalia.com> wrote:
> > > >
> > > > This patchset was inspired and made on top of the below series:
> > > >
> > > > https://lore.kernel.org/amd-gfx/20250319162225.3775315-1-alexander.deucher@amd.com/
> > > >
> > > > In the above series, there is a bug fix in many functions named
> > > > gfx_vX_0_get_csb_buffer (where X ranges from 6 to 11). After closely
> > > > looking at those functions, it became clear that most of the code could
> > > > be shared from gfx6 to gfx11. Aside from the code duplication removal,
> > > > this also improves maintainability since a bug fix in a shared function
> > > > can be propagated to all ASICs.
> > > >
> > > > The first patch of this series created one dedicated file for
> > > > encapsulating common GC registers (gc_common_offset.h); this series only
> > > > adds registers associated with the CSB. In the future, this file can
> > > > keep growing as we identify common registers to be shared in the
> > > > gc_common_offset.h.
> > > >
> > > > The second patch introduces the generic gfx_get_csb_buffer function,
> > > > which has the same implementation found in gfx_v10_0_get_csb_buffer and
> > > > gfx_v11_0_get_csb_buffer (these two functions have the same code). After
> > > > that, every patch is dedicated to absorbing one of the csb_buffer
> > > > functions from gfx from 9 to 6; notice that some adaptations were
> > > > required.
> > >
> > > I don't really like the register header changes and moving all of the
> > > IP version specific logic into the common code.  These register
> > > headers are used in other places as well and moving some registers
> > > into a common header can get confusing and may lead to bugs later if
> > > other chips change the offset of these registers.
> >
> > In that case, what do you think if I just abstract the first part of the
> > function for a V2? The first part is the same for all gfx from 6 to 11.
> > Something like this:
> >
> > int gfx_get_pre_setup_csb_buffer(struct amdgpu_device *adev, volatile u32 *buffer)
> > {
> >        u32 count = 0, i;
> >        const struct cs_section_def *sect = NULL;
> >        const struct cs_extent_def *ext = NULL;
> >        int ctx_reg_offset;
> >
> >        if (adev->gfx.rlc.cs_data == NULL)
> >                return 1;
> >        if (buffer == NULL)
> >                return 1;
> >
> >        buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
> >        buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_BEGIN_CLEAR_STATE);
> >
> >        buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CONTEXT_CONTROL, 1));
> >        buffer[count++] = cpu_to_le32(0x80000000);
> >        buffer[count++] = cpu_to_le32(0x80000000);
> >
> >        for (sect = adev->gfx.rlc.cs_data; sect->section != NULL; ++sect) {
> >                for (ext = sect->section; ext->extent != NULL; ++ext) {
> >                        if (sect->id == SECT_CONTEXT) {
> >                                buffer[count++] =
> >                                        cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, ext->reg_count));
> >                                buffer[count++] = cpu_to_le32(ext->reg_index -
> >                                                PACKET3_SET_CONTEXT_REG_START);
> >                                for (i = 0; i < ext->reg_count; i++)
> >                                        buffer[count++] = cpu_to_le32(ext->extent[i]);
> >                        }
> >                }
> >        }
> >
> >        return 0;
> > }
> 
> Sure helpers are fine.  maybe a preamble_start helper
>         buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
>         buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_BEGIN_CLEAR_STATE);
> 
>         buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CONTEXT_CONTROL, 1));
>         buffer[count++] = cpu_to_le32(0x80000000);
>         buffer[count++] = cpu_to_le32(0x80000000);
> and a preamble_end helper:
>         buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
>         buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_STATE);
> 
>         buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CLEAR_STATE, 0));
>         buffer[count++] = cpu_to_le32(0);
> and a cs_data parser helper:
>         for (sect = adev->gfx.rlc.cs_data; sect->section != NULL; ++sect) {
>             for (ext = sect->section; ext->extent != NULL; ++ext) {
>                         if (sect->id == SECT_CONTEXT) {
>                 buffer[count++] =
> 
> cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, ext->reg_count));
>                                 buffer[count++] = cpu_to_le32(ext->reg_index -
>                                                 PACKET3_SET_CONTEXT_REG_START);
>                                 for (i = 0; i < ext->reg_count; i++)
>                                         buffer[count++] =
> cpu_to_le32(ext->extent[i]);
>                         }
>                 }
>     }

Nice. I'll prepare a V2.

> 
> Also, while you are at it, you could clean up gfx_v9_0_cp_gfx_start(),
> etc. to use the cs buffer and cs size directly rather than re-parsing
> everything again.

Sure, I'll make it as a separate patchset.

Thanks

> 
> Alex
> 
> >
> > Thanks
> >
> > >
> > > Alex
> > >
> > > >
> > > > Thanks
> > > >
> > > > Rodrigo Siqueira (6):
> > > >   drm/amd/amdgpu: Create a headears to keep some common GC registers
> > > >   drm/amdgpu/gfx: Introduce generic gfx_get_csb_buffer
> > > >   drm/amdgpu/gfx: Integrate gfx_v9_0_get_csb_buffer into
> > > >     gfx_get_csb_buffer
> > > >   drm/amdgpu/gfx: Absorb gfx_v8_0_get_csb_buffer into gfx_get_csb_buffer
> > > >   drm/amdgpu/gfx: Assimilate gfx_v7_0_get_csb_buffer into
> > > >     gfx_get_csb_buffer
> > > >   drm/amdgpu/gfx: Merge gfx_v6_0_get_csb_buffer into gfx_get_csb_buffer
> > > >
> > > >  Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   3 +
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 101 ++++++++++++++++++
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   1 +
> > > >  drivers/gpu/drm/amd/amdgpu/cik.c              |   2 +
> > > >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  51 +--------
> > > >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  53 +--------
> > > >  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |  46 +-------
> > > >  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  70 +-----------
> > > >  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  51 +--------
> > > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  43 +-------
> > > >  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |   1 +
> > > >  drivers/gpu/drm/amd/amdgpu/si.c               |   2 +
> > > >  drivers/gpu/drm/amd/amdgpu/vi.c               |   2 +
> > > >  .../include/asic_reg/gc/gc_10_1_0_offset.h    |   3 -
> > > >  .../include/asic_reg/gc/gc_10_3_0_offset.h    |   3 -
> > > >  .../include/asic_reg/gc/gc_11_0_0_offset.h    |   2 -
> > > >  .../include/asic_reg/gc/gc_11_0_3_offset.h    |   2 -
> > > >  .../include/asic_reg/gc/gc_11_5_0_offset.h    |   2 -
> > > >  .../include/asic_reg/gc/gc_12_0_0_offset.h    |   2 -
> > > >  .../amd/include/asic_reg/gc/gc_9_0_offset.h   |   3 -
> > > >  .../amd/include/asic_reg/gc/gc_9_1_offset.h   |   3 -
> > > >  .../amd/include/asic_reg/gc/gc_9_2_1_offset.h |   3 -
> > > >  .../amd/include/asic_reg/gc/gc_9_4_2_offset.h |   2 -
> > > >  .../amd/include/asic_reg/gc/gc_9_4_3_offset.h |   2 -
> > > >  .../include/asic_reg/gc/gc_common_offset.h    |  11 ++
> > > >  .../drm/amd/include/asic_reg/gca/gfx_6_0_d.h  |   1 -
> > > >  .../drm/amd/include/asic_reg/gca/gfx_7_0_d.h  |   1 -
> > > >  .../drm/amd/include/asic_reg/gca/gfx_7_2_d.h  |   1 -
> > > >  .../drm/amd/include/asic_reg/gca/gfx_8_0_d.h  |   1 -
> > > >  .../drm/amd/include/asic_reg/gca/gfx_8_1_d.h  |   1 -
> > > >  30 files changed, 141 insertions(+), 328 deletions(-)
> > > >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_common_offset.h
> > > >
> > > > --
> > > > 2.49.0
> > > >
> >
> > --
> > Rodrigo Siqueira

-- 
Rodrigo Siqueira
