Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF04C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 13:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21BF410F1F1;
	Wed,  2 Sep 2026 13:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bf81g5BP";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E27A10F1F1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 13:38:17 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3deso114585a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2026 06:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788356296; cv=none;
 d=google.com; s=arc-20260327;
 b=k0+kV6wPop0lQjy1oma8UYS0nYGKsb67Sa6qaBOma2OR2WqYdRaJGoLCFdNIRMiWg9
 tkErohTXzu8Q6NnbWRjYK3pZ3n5dFp77brT5yySa6g6o6ZgD6yMu/sqth9JZzEDAupbp
 Qf0oL8fi++OBADCMiPH/JkX/FeJ/rL47ATrQks/NhbjOgobFkbv+uiP5PBQtGyi1MdmR
 cL3nFDdwM0Mi49qfRPr9f68QNSQCEJLXL3ratQ/0yXJMOpIUzaiUhlTumno8KrIBPwZK
 QqZhQoGSZPHL3pA7Wsw/UZcycBezwBTNxbJV4zr3BZrGQyUOI4IsVRR0/RqukQ/QIdcj
 OTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XW+AsS3gdk40AtUlH7jDIWln4F56UvBkCdD72K417bs=;
 fh=wNvVFXwSqueu4L5cd0cWn/KRb77oCZ9UjqDdjeZqsI8=;
 b=UKSO1FRULOmWi9gMVdS6OdstP4b3fuKb5SDETkDV5k9fegEmwXGxVgt5edGh8K94Bo
 cBmKFoMXTkyZcCDKL89YRHgpJkkIYHFYNOWBiewmamcyyTEu2r8RykbYXNKp8jKp62uG
 pX6MtI0YsULiki3rJ+eumkTNKM38ULpH7bNFmu2wC4EPulaJi68jS3O4NMouBRnlKYCH
 cG4SgtfLPOrJjXMWsEaHi3Kr1hIQmNC1tfbAHhmpANKWIZmhf1I9lfcigVmJ5tAPKxdP
 k8vH80CGh/7uNPu22rFCHedZQXVtHtEzH3O2XiURZQR2eYIAcBCY7iogmBq/8eYvMCPf
 f4Pw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788356296; x=1788961096; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XW+AsS3gdk40AtUlH7jDIWln4F56UvBkCdD72K417bs=;
 b=bf81g5BPflhIOKlf3fP0SANhKQpv1BHMARxfRBmolPQIQbR58Ram9dWkOIaUD4Pmp9
 6SjwmlX603dkiiW3c2ty908x0Rp+0JvRqR4UDX2HWhgML2p24fnhoAPlue7PcdhV3/mp
 emSExJ6jYDbAv5g4576e/aXiLbuX5VLpT1G6iyPxvN+c3jHhA8TR/Ja0KsiQRhK566oX
 oCP3Nkwzp8AeQSQHJmsBKTCrZgvvi9Emn8FX2IulGx4xixvL7rtv8CXLP3Na8MtWFmNA
 7p1zMLV7UEg8wPqVjBvaNM8EISZmRLO47lVqdoYXQhXLYLmVp8iuIW8tPtMMQhVLABlP
 vq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788356296; x=1788961096;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XW+AsS3gdk40AtUlH7jDIWln4F56UvBkCdD72K417bs=;
 b=bXl8L8bZK642ia32LTTLs9lOu/e0oJPjSNmjPrAxQsF62NrogsxsJcOX3HzDkQPNZ6
 6o7ElZYu//CWSWexmkEZZ8StOLIT/rWM9NuvseeIMgKgQIQQtRgr8n7MQgpZu05NHVPU
 aJ4vKGpdQzZu8hhfgjiuDkAudJlADbTF5cN3C2XwfS4kBmBSh42fhNTKLATHmV7WPzcb
 +2cDOyGCFmARrXvdLXDc0o1+B4wMpYBHc9j5dkai0hpdTYa9OODfx5sOScqedgchzIpJ
 L7fktGYVACx2P1fMvttSWLuFJoxq+UcjQURyIYdlWJ2K+F3x/HRVguQzBQ/lkbD6YDAx
 yYTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZ337YUwgbrZITGvy/nctGrDX4Ezz24evOyvLrotUaQeEUHX9RJeRY25YD+aK2slzI0H9YIHBF@lists.freedesktop.org
X-Gm-Message-State: AFuF++noQxWno2ODc1fZyXf4PBm0sSjAR6mVnd8RKMJlJKayNtn7DZ7C
 XilJPNcNwAYLIiSj/6eR+HScIRvxFcpTnEY/e+SVqTlA9qfSMWacyS9hFenLoEjnqrmDKGolDlT
 Kf+U/nEZOnF3/310+Peq6WTsycueO4wY=
X-Gm-Gg: AYBFou1lvrvlN8J9oQ6Pnk25UdfAWw0QNFy4RxU9ecb9qqBrVEbfXy9aUSlhmX7Rezh
 mDbwxtmkJjlj41qaeUKYx2kyo7mgSH+KvLHBHZL1Vkn9ITC5Xu7FRBzHkHBmDByWxY3HRHRwzFB
 G2BWWRX5V/KnLBz5qOED5Ys1zGH+syerP/4K2ehowW75s4TppM2jdyJG8eEQeI0JoVGDRfMQL/A
 GDCZSpocPQ3P8mXvrOdAddPuL54CVsGHCQPqdskkNa5xfsw+EOX2UpnwWrILZqFVtia7RrrEANM
 lARtg+Qds1mcNjBSZUYS59FzN+xWfIzcZ+pywk5Bu2k6sal9dkfHtVePSuDVZdUuG85lEwY2k/x
 ODF8PVQTzi2EWT6XOAoVaC9rHNIWyfTLci3yHiGm2gg==
X-Received: by 2002:a17:90b:2d0b:b0:398:bad2:c0f with SMTP id
 98e67ed59e1d1-39aee246b0emr4097493a91.5.1788356296356; Wed, 02 Sep 2026
 06:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
 <05e8a019-903c-4249-9c82-11dce0403aea@amd.com>
 <CADnq5_PELtGDm5MkC+hiGLviAEtUufjYVzCTaA2Es-NPJsmAxA@mail.gmail.com>
 <db022549-86b8-43a3-9b8e-b46bcdee2033@amd.com>
 <CADnq5_Na=0pvEjoCC=ONR2iOFc745inQBrFgxMuZ5prwXpV5KA@mail.gmail.com>
In-Reply-To: <CADnq5_Na=0pvEjoCC=ONR2iOFc745inQBrFgxMuZ5prwXpV5KA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Sep 2026 09:38:04 -0400
X-Gm-Features: AcwNN1Wjh73V8ATLOVH9KDPfursw8nFolr0ZR2emR2BrjdMxaA-tcI-hkeSGe9c
Message-ID: <CADnq5_Pdc3WVtN-F9rV1hYps5istv22ji2zBZZGrEq=PJx8V_g@mail.gmail.com>
Subject: Re: [PATCH V2 00/31] Rework GPU TLB invalidation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Wed, Sep 2, 2026 at 9:25=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Wed, Sep 2, 2026 at 9:20=E2=80=AFAM Christian K=C3=B6nig <christian.ko=
enig@amd.com> wrote:
> >
> > On 9/2/26 15:06, Alex Deucher wrote:
> > > On Wed, Sep 2, 2026 at 3:25=E2=80=AFAM Christian K=C3=B6nig <christia=
n.koenig@amd.com> wrote:
> > >>
> > >> On 9/1/26 22:10, Alex Deucher wrote:
> > >>> GMC 9-12 use KIQ or MES for TLB invalidations to avoid using MMIO w=
hich would
> > >>> require disallowing GFXOFF.  KIQ and MES are management queues howe=
ver and if
> > >>> they hang, they cannot be recovered by a queue reset since they are=
 the
> > >>> mechanisms which handle queue resets.  Since using KIQ or MES will =
exit GFXOFF
> > >>> anyway, explicitly disallow it on the MMIO path and use that. Next,=
 switch to
> > >>> using SDMA for TLB invalidations.  SDMA 4.4.x and newer have specia=
l packets
> > >>> specifically for this purpose.
> > >>
> > >> That packet was just introduced to work around SRIOV issues and prov=
ed to cause stability issues as well.
> > >>
> > >
> > > It was introduced because of gfxoff and having to toggle it to use
> > > MMIO.
> >
> > No, that was completely unrelated to GFXOFF. This also applies to HW wh=
ere the SDMA is not even in the GFX domain.
> >
> > The problem was the SRIOV could interrupt the SDMA while it waited for =
the ACK and when the VF was scheduled in again the ACK bit was resetted.
> >
> > So a single packet was introduced which couldn't be interrupted by the =
hypervisor.
> >
> > > WIndows uses SDMA pretty much exclusively for TLB
> > > invalidations.  It's also what the memory hubs team recommends.
> >
> > That is rather interesting.
> > >> Since Arun now found that on basically all Navi generations the SDMA=
 can hang while doing a TLB invalidation I have to clearly NAK this approac=
h.
> > >>
> > >> In the long run we should do the TLB invalidations on newer HW compl=
etely with the MES, the SDMA was always just a workaround we should not pus=
h forward.
> > >>
> > >
> > > Well KIQ and MES also seem to be problematic as well.  See the thread
> > > from Denis about KIQ and his renoir system. There are also various
> > > reports of MES timeouts doing TLB invalidations.
> >
> > The MES is the only instance which knows the process to VMID mapping fo=
r user queues.
> >
> > The hack to read out the PASID->VMID mapping register directly from the=
 IH is not really something we can use in the future.
> >
> > So the plan was to move all of that into MES in the near term. IIRC the=
 MES even added a new packet for that.
>
> Sure, this patch set retains the use of MES for pasid invalidation
> where it's supported (navi4x and newer with new enough firmware). We
> could try and get the new packet added to gfx11 MES as well, but then
> there is still gfx9 and 10 which still use KIQ.
>

Regarding gfx 11 mes, there is only a single scheduler queue, similar
to KIQ on previous generations.  That micro controller handles both
driver commands and queue scheduling. On gfx12, there are now two MES
queues, one for scheduling and one for misc commands to avoid
contention while scheduling.

This series doesn't actually remove any functionality, it just
provides the option of using:
- KIQ
- SDMA
- MES
- MMIO
and cleans up a lot of duplicate code in the gmc modules.  The default
is changed to SDMA or MES depending on what the device supports.  We
can adjust the defaults for each gmc generation as needed.

Alex

> Alex
>
> >
> > Regards,
> > Christian.
> >
> > >
> > > Alex
> > >
> > >> Regards,
> > >> Christian.
> > >>
> > >>> If SDMA hangs while doing the invalidation for
> > >>> some reason, it's easier to reset the SDMA queue than KIQ or MES.  =
Finally,
> > >>> most of the TLB invalidation code between GMC 9 through 12 was iden=
tical, so
> > >>> move it to common GMC helpers and remove the IP specific code.  If =
the SMDA
> > >>> and MMIO pathes prove to be stable, the KIQ pathes can be removed i=
n the future
> > >>> to further simplify things. SDMA 4.x could also be updated to suppo=
rt PASID
> > >>> invalidation via SDMA using either the new packet (SDMA 4.4.x) or v=
ia
> > >>> REG_WRITE/REG_WAIT packets (SDMA 4.0.x).
> > >>>
> > >>> Code is available on this branch as well:
> > >>> https://gitlab.freedesktop.org/agd5f/linux/-/commits/tlb_inv_rework=
?ref_type=3Dheads
> > >>>
> > >>> V2:
> > >>> - Add missing hub callbacks in gmc9 hubs
> > >>>
> > >>> Alex Deucher (31):
> > >>>   drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
> > >>>   drm/amdgpu/gmc10: disallow gfxoff around TLB flushes
> > >>>   drm/amdgpu/gmc11: disallow gfxoff around TLB flushes
> > >>>   drm/amdgpu/gmc12: disallow gfxoff around TLB flushes
> > >>>   drm/amdgpu/gmc9: set vmhub funcs for gfxhub and mmhub
> > >>>   drm/amdgpu: add a gmc flag for using MMIO for TLB flush
> > >>>   drm/amdgpu/gmc9: use MMIO for TLB flushes
> > >>>   drm/amdgpu/gmc10: use MMIO for TLB flushes
> > >>>   drm/amdgpu/gmc11: use MMIO for TLB flushes
> > >>>   drm/amdgpu/gmc12: use MMIO for TLB flushes
> > >>>   drm/amdgpu: add a buffer funcs callback for TLB invalidation
> > >>>   drm/amdgpu/sdma5.0: add tlb invalidation buffer func callback
> > >>>   drm/amdgpu/sdma5.2: add tlb invalidation buffer func callback
> > >>>   drm/amdgpu/sdma6: add tlb invalidation buffer func callback
> > >>>   drm/amdgpu/sdma7: add tlb invalidation buffer func callback
> > >>>   drm/amdgpu: simplify amdgpu_gmc_flush_gpu_tlb()
> > >>>   drm/amdgpu: add tlb invalidation method enum
> > >>>   drm/amdgpu: plumb tlb inv method in amdgpu_gmc_flush_gpu_tlb_gart=
()
> > >>>   drm/amdgpu: uplevel reset check in amdgpu_gmc_flush_gpu_tlb_gart(=
)
> > >>>   drm/amdgpu/gmc: add new callback to lookup vmid to pasid mapping
> > >>>   drm/amdgpu: add a gmc callback for the inv semaphore
> > >>>   drm/amdgpu/gmc: rework pasid flushing
> > >>>   drm/amdgpu/gmc9: use SDMA for gart TLB invalidation
> > >>>   drm/amdgpu/gmc10: use SDMA for gart TLB invalidation
> > >>>   drm/amdgpu/gmc11: use SDMA for gart TLB invalidation
> > >>>   drm/amdgpu/gmc12: use SDMA for gart TLB invalidation
> > >>>   drm/amdgpu/gmc10: use SDMA for pasid TLB invalidation
> > >>>   drm/amdgpu/gmc11: use SDMA for pasid TLB invalidation
> > >>>   drm/amdgpu/gmc12: use MES or SDMA for pasid TLB invalidation
> > >>>   drm/amdgpu/gmc12: drop MES tlb inv in gmc callbacks
> > >>>   drm/amdgpu/gmc: add helpers for various tlb inv functions
> > >>>
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c |   2 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 486 +++++++++++++++++++=
----
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  33 +-
> > >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  18 +
> > >>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |   2 +
> > >>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c |  33 ++
> > >>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  33 ++
> > >>>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 202 +---------
> > >>>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   | 207 +---------
> > >>>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   | 250 ++----------
> > >>>  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c   | 225 +----------
> > >>>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 135 ++-----
> > >>>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   |   4 +
> > >>>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c   |   4 +
> > >>>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  |  33 ++
> > >>>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  |  32 ++
> > >>>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  32 ++
> > >>>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  |  32 ++
> > >>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  49 +++
> > >>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  49 +++
> > >>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  49 +++
> > >>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  48 +++
> > >>>  22 files changed, 943 insertions(+), 1015 deletions(-)
> > >>>
> > >>
> >
