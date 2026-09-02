Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E203C624D3
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 13:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CACD410E4FB;
	Wed,  2 Sep 2026 13:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vtzpy7tD";
	dkim-atps=neutral
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com
 [209.85.221.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E0C10E4FB
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 13:25:59 +0000 (UTC)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-5bf8ccc3e60so78544e0c.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2026 06:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788355558; cv=none;
 d=google.com; s=arc-20260327;
 b=SpOhdAszO9KgDcvWt17AtigXXbqImXwkd+/7v0A5DLw4VHbqOHGdOo/OLkOtLIgMJ/
 RuY4SBETknjQfCVntMiuwK5zwDpvzfvQpVw6R+1mtLFyfulT7Qd2tJolt0qoEP0rKQ6K
 yAoJgz1NgOzZllaHll9PhuSLcMnOQxlUXgIx8e6l5i/KLUxXxtOUuIawVmXKE3eX3WrQ
 RkgsrSimII5XFctt+g3k3qcve0hpGdXGYig0wKJvvNbPNeEwvb5zAqyUIl/XsWqgR2Z6
 YYJnYVvNrlSuXlb7SxVNfrxu3LyjgaQ++17cLUgMVMNLFEn2ro41B/lRtVxYQ3sVk39T
 iXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N9adXj1VDsSnxllyjotby4omDmPt1fOTG6RyLqOME8A=;
 fh=of6GD1hd49Wz6uVAEx5f0mbdeBIdCN0EHBS5+tpYL0w=;
 b=OI+NQF2FiJ1zTGl9fOqORIboJN9aFpe6/mrvpwYDENHztrXPJUDwWHrmE8zS+f1oj7
 89uBOGJQmDD3AOKXVYA/kh/LJ/Z6Kj1rpLi1NyDO8qxZkT401mQ0lN0108aeHF+r+ac3
 24iHJAbPSLa9f1aV+39YD21NiIS/8iG+w+ql+sPFbu2Mi8tp2Bv0zsElj0F8qwKpA2Vo
 0PpR/k7efHDWFRRoOLxx2Vq8ugeDtVgzzf/rZ8EmX3Kf7gkFdDEePHttvK01rA88aLTJ
 LY3zugXP5pJBg0XKtfNu63Yc0QAwbC+A44DBo6zbrBLingCiGGHJIvwPRB1a99fYltF0
 pNNA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788355558; x=1788960358; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N9adXj1VDsSnxllyjotby4omDmPt1fOTG6RyLqOME8A=;
 b=Vtzpy7tDvha8sA6CqPPpkX6exgs+1rzH/2OHTupBB1ZFkthe34LK2a4llVztJ1R3c1
 XmUBGmn2vJVf4b7KRpeyuMBZv9PctV3395iKayTilpjwAT4OGg297NzOqw9lOPEsPKTY
 KWy2EbrUNbunFsyI6uf0pkhlVTs+mIDIejJCR4lbKSnAaArbYb8Ay82l/xezYsR+o4BW
 N52Dx8twxpNnjWQXFIX+4p9JE5JE0LWZRHpsfTNLLAbCh6qs/UtdW3Zhb3k+IhihkSpG
 c8p06LLHeZB6ZssdL+C++qM1sSWzlNbXjXOAmRQ4/DueF4wpiF/KTBnJsqaEDskJAelJ
 7n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788355558; x=1788960358;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N9adXj1VDsSnxllyjotby4omDmPt1fOTG6RyLqOME8A=;
 b=URJI7QU5BhRVoOzAvyoaSElypGNfbadyjjhww9Z7W3ZpPkIetBNpKHIvANcbSj882W
 ub7ffhyR2+PDG78On9nvYugU0AmBngjGAodD90XVJmA0Tzf6Ro+yMSt4ePXNkTjFkLIL
 SNSkeYPLBuVKW+D4WgpNL7MfEPNz4c90rKXwp81wOotP9dPY1UPhXmvTzlHI6aB3DBKt
 05K9FUpSRwdSIDcux5MiIE3C/gwO9YkBYWXVKJ8B6+wUniS46ViFZt1KDVhMZ/Vfc4+z
 Ks1QD8Rb1ljMcmPgP9ua1nnq2sZ/7QpeHnaDWDqaMeGDpcfB1PenBrPClzyxL/yHZ2bA
 chcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6ji6m7gSEs5p11pWolXwsDWd+sc6USlHUCiTSmkInGu1GZn0mFaJNLTd5zCTXFag1a6NhF2P6@lists.freedesktop.org
X-Gm-Message-State: AFuF++nPts3eDM3qGY3jt0l7OaSsZTMNRr2Cv803i8qVPtbwhB23KWCk
 t4yBK3jXPFFEbcjZNkLYkcuuH1+w2FTHiN60QHk7bpko9Nzx9ADJ7CWMC2VzLZNsFZPq5NJUXv2
 dd5jgbZAuATy+wfWJs4Ejq68TbTLrJ6g=
X-Gm-Gg: AYBFou3o4Ear4zLChe7a+YZMEiaDnah09Vv61NzRUNk7zez1zSrzCmEzve1LtX9FkGR
 BUAgbZ6CKUuwCcA2Vbh1Sb23l7dxONjGi9AnuXQyxamyQH/MFxCg3g2Iz/xZ2hEh7ni4g9ddIA/
 7TD9Xn1+KbkfeZxXGBCD06L+7NQ6JoYKy0W0jRGsjPnirXpquMbd1DBRoojhtNuqeWAOL2YlUzb
 MNezjnpEV4VkbA3JWvsdxBVL9b/ANq9V14u97PMSpVhtsnXdxvZ18aSy/DJjIJetxMSR9DSF4HI
 3IwK7taDeAvjqEFcOKpRLi2gxL58N9muV0oxKM1AbllfWdN7W7EsG/0isoHNnfF6B9e3Eg7OlK0
 T/atWL51+X4qSnIwTG/fTQcg3Zp7zOso=
X-Received: by 2002:a05:6122:e006:10b0:5c1:24b6:a1e0 with SMTP id
 71dfb90a1353d-5c7d2832ab9mr488201e0c.3.1788355557709; Wed, 02 Sep 2026
 06:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
 <05e8a019-903c-4249-9c82-11dce0403aea@amd.com>
 <CADnq5_PELtGDm5MkC+hiGLviAEtUufjYVzCTaA2Es-NPJsmAxA@mail.gmail.com>
 <db022549-86b8-43a3-9b8e-b46bcdee2033@amd.com>
In-Reply-To: <db022549-86b8-43a3-9b8e-b46bcdee2033@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Sep 2026 09:25:45 -0400
X-Gm-Features: AcwNN1WKyP30_7vOoietyuxdi5pSbOuTu5JM3gQ1Q_u20vxbwG4fQpF06qWA-tg
Message-ID: <CADnq5_Na=0pvEjoCC=ONR2iOFc745inQBrFgxMuZ5prwXpV5KA@mail.gmail.com>
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

On Wed, Sep 2, 2026 at 9:20=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 9/2/26 15:06, Alex Deucher wrote:
> > On Wed, Sep 2, 2026 at 3:25=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
> >>
> >> On 9/1/26 22:10, Alex Deucher wrote:
> >>> GMC 9-12 use KIQ or MES for TLB invalidations to avoid using MMIO whi=
ch would
> >>> require disallowing GFXOFF.  KIQ and MES are management queues howeve=
r and if
> >>> they hang, they cannot be recovered by a queue reset since they are t=
he
> >>> mechanisms which handle queue resets.  Since using KIQ or MES will ex=
it GFXOFF
> >>> anyway, explicitly disallow it on the MMIO path and use that. Next, s=
witch to
> >>> using SDMA for TLB invalidations.  SDMA 4.4.x and newer have special =
packets
> >>> specifically for this purpose.
> >>
> >> That packet was just introduced to work around SRIOV issues and proved=
 to cause stability issues as well.
> >>
> >
> > It was introduced because of gfxoff and having to toggle it to use
> > MMIO.
>
> No, that was completely unrelated to GFXOFF. This also applies to HW wher=
e the SDMA is not even in the GFX domain.
>
> The problem was the SRIOV could interrupt the SDMA while it waited for th=
e ACK and when the VF was scheduled in again the ACK bit was resetted.
>
> So a single packet was introduced which couldn't be interrupted by the hy=
pervisor.
>
> > WIndows uses SDMA pretty much exclusively for TLB
> > invalidations.  It's also what the memory hubs team recommends.
>
> That is rather interesting.
> >> Since Arun now found that on basically all Navi generations the SDMA c=
an hang while doing a TLB invalidation I have to clearly NAK this approach.
> >>
> >> In the long run we should do the TLB invalidations on newer HW complet=
ely with the MES, the SDMA was always just a workaround we should not push =
forward.
> >>
> >
> > Well KIQ and MES also seem to be problematic as well.  See the thread
> > from Denis about KIQ and his renoir system. There are also various
> > reports of MES timeouts doing TLB invalidations.
>
> The MES is the only instance which knows the process to VMID mapping for =
user queues.
>
> The hack to read out the PASID->VMID mapping register directly from the I=
H is not really something we can use in the future.
>
> So the plan was to move all of that into MES in the near term. IIRC the M=
ES even added a new packet for that.

Sure, this patch set retains the use of MES for pasid invalidation
where it's supported (navi4x and newer with new enough firmware). We
could try and get the new packet added to gfx11 MES as well, but then
there is still gfx9 and 10 which still use KIQ.

Alex

>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >> Regards,
> >> Christian.
> >>
> >>> If SDMA hangs while doing the invalidation for
> >>> some reason, it's easier to reset the SDMA queue than KIQ or MES.  Fi=
nally,
> >>> most of the TLB invalidation code between GMC 9 through 12 was identi=
cal, so
> >>> move it to common GMC helpers and remove the IP specific code.  If th=
e SMDA
> >>> and MMIO pathes prove to be stable, the KIQ pathes can be removed in =
the future
> >>> to further simplify things. SDMA 4.x could also be updated to support=
 PASID
> >>> invalidation via SDMA using either the new packet (SDMA 4.4.x) or via
> >>> REG_WRITE/REG_WAIT packets (SDMA 4.0.x).
> >>>
> >>> Code is available on this branch as well:
> >>> https://gitlab.freedesktop.org/agd5f/linux/-/commits/tlb_inv_rework?r=
ef_type=3Dheads
> >>>
> >>> V2:
> >>> - Add missing hub callbacks in gmc9 hubs
> >>>
> >>> Alex Deucher (31):
> >>>   drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
> >>>   drm/amdgpu/gmc10: disallow gfxoff around TLB flushes
> >>>   drm/amdgpu/gmc11: disallow gfxoff around TLB flushes
> >>>   drm/amdgpu/gmc12: disallow gfxoff around TLB flushes
> >>>   drm/amdgpu/gmc9: set vmhub funcs for gfxhub and mmhub
> >>>   drm/amdgpu: add a gmc flag for using MMIO for TLB flush
> >>>   drm/amdgpu/gmc9: use MMIO for TLB flushes
> >>>   drm/amdgpu/gmc10: use MMIO for TLB flushes
> >>>   drm/amdgpu/gmc11: use MMIO for TLB flushes
> >>>   drm/amdgpu/gmc12: use MMIO for TLB flushes
> >>>   drm/amdgpu: add a buffer funcs callback for TLB invalidation
> >>>   drm/amdgpu/sdma5.0: add tlb invalidation buffer func callback
> >>>   drm/amdgpu/sdma5.2: add tlb invalidation buffer func callback
> >>>   drm/amdgpu/sdma6: add tlb invalidation buffer func callback
> >>>   drm/amdgpu/sdma7: add tlb invalidation buffer func callback
> >>>   drm/amdgpu: simplify amdgpu_gmc_flush_gpu_tlb()
> >>>   drm/amdgpu: add tlb invalidation method enum
> >>>   drm/amdgpu: plumb tlb inv method in amdgpu_gmc_flush_gpu_tlb_gart()
> >>>   drm/amdgpu: uplevel reset check in amdgpu_gmc_flush_gpu_tlb_gart()
> >>>   drm/amdgpu/gmc: add new callback to lookup vmid to pasid mapping
> >>>   drm/amdgpu: add a gmc callback for the inv semaphore
> >>>   drm/amdgpu/gmc: rework pasid flushing
> >>>   drm/amdgpu/gmc9: use SDMA for gart TLB invalidation
> >>>   drm/amdgpu/gmc10: use SDMA for gart TLB invalidation
> >>>   drm/amdgpu/gmc11: use SDMA for gart TLB invalidation
> >>>   drm/amdgpu/gmc12: use SDMA for gart TLB invalidation
> >>>   drm/amdgpu/gmc10: use SDMA for pasid TLB invalidation
> >>>   drm/amdgpu/gmc11: use SDMA for pasid TLB invalidation
> >>>   drm/amdgpu/gmc12: use MES or SDMA for pasid TLB invalidation
> >>>   drm/amdgpu/gmc12: drop MES tlb inv in gmc callbacks
> >>>   drm/amdgpu/gmc: add helpers for various tlb inv functions
> >>>
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c |   2 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 486 +++++++++++++++++++--=
--
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  33 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  18 +
> >>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |   2 +
> >>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c |  33 ++
> >>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  33 ++
> >>>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 202 +---------
> >>>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   | 207 +---------
> >>>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   | 250 ++----------
> >>>  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c   | 225 +----------
> >>>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 135 ++-----
> >>>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   |   4 +
> >>>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c   |   4 +
> >>>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  |  33 ++
> >>>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  |  32 ++
> >>>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  32 ++
> >>>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  |  32 ++
> >>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  49 +++
> >>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  49 +++
> >>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  49 +++
> >>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  48 +++
> >>>  22 files changed, 943 insertions(+), 1015 deletions(-)
> >>>
> >>
>
