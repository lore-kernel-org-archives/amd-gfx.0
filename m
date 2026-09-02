Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A373C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 13:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D32610F1C5;
	Wed,  2 Sep 2026 13:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tHI5yxmz";
	dkim-atps=neutral
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D056B10F1C5
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 13:06:40 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-4b37ef7bd32so30107b6e.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2026 06:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788354400; cv=none;
 d=google.com; s=arc-20260327;
 b=Yx9SEpAuwORhoGykK8lVGA1J7/9UY+YrtTOWWG1PXsV8skd7q8oRdGh4lXmIW6t7Q8
 9/gQRJs76ZZrjbb4u27wjv3ducnP7EqenfR40aITLgQcnZOoX6z9flKR6I8firINbdFQ
 UAVOd/x+BZv8Noj2PaeqBEJ0WjZK5oKMTYSRjxp5Tv09yZZhf2FghyJMXUamlZ9Abf38
 3UzLlblF3BrbCh+9GZrOBDyxYBrXdGyn4Rw96WxAhSleB8AOCr/9QiG6SZG+mWXYpX8T
 jk+fhBZ+0gOzQ90F4rlbiFxDGke0HtocDuPcFoB2ZTJM/M69E62ic4LxDMOxK6EoQ6hf
 B1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qNojhvbc5zS123DnM7aH8SA3VBXmC4Q3hlItYdnrSrU=;
 fh=TE7zXeBGwJ8D3Y92KbKVlxsxUQNnSozYcKCFPPD63qg=;
 b=TUeWFBh8+5x1vLfHCH2emuyKrGCqZcjrZmvf9G6dSm7SRjeenAafSEI6gT96iJTEWp
 CsIdD5ZYCw/EFEI4bt0ofW2Kky/15hVFv9pwGhva07OmfglQ8xUQH0Jy+WEX0mPuj+hd
 hG6A0Xp9GZSTyv23tklMiT8CBh3qTffN+VfDrIQLRA7fH/oTuUyM5a5yheBhCuElsXB9
 GL6ls7BGGlojeFVMw3FyoxR/G7x3Hu7L+MK7b6s1c/JDJrcN/GPnOv08BtD/yNlex1N5
 6XJWghuRtVgc//P5tudufa1wJqsLrNCsRpO/OJZ1LU8evelan3cJzWv/zsogjCcHbHEJ
 uFmw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788354400; x=1788959200; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qNojhvbc5zS123DnM7aH8SA3VBXmC4Q3hlItYdnrSrU=;
 b=tHI5yxmzzApQVaFAVYyom7yJ/FxHb8B/5PKiP4kY5T9XXAHHqz38++ucDwXO7atOqO
 IBGn9tW+nx0t8QiOAs7E5ryEKhTuL5xg6lOGbmK5k/xnrb3n2N7jOrZlaguTqIx7P2yj
 w3qaIl3mo1mutQ+DijmB5ua3TU9gZwfnSrLHONFtWCGEu3LdeunaVgr1/eZ2xCtKOK7J
 wKzWziHq3JBmSt0OKg6x1D0PcdBiAoZ4Y/yaKpyoR+XO6T4UnW+vCWw8SuetNlBNv727
 L/uWs+PhLIPN4fiFMsO6qZdUYCES8BnNdrsoUPHseX7Q+zRDuxXNw0EdwKzwtUpM2nA3
 4MCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788354400; x=1788959200;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qNojhvbc5zS123DnM7aH8SA3VBXmC4Q3hlItYdnrSrU=;
 b=A3CGqu8j6bLEJCXnd0yuP7R1p20wUxHml0CoqXGkoVN1msaMZ8hV2N1KrLjxKrU6Cm
 Ejf7xP8J3tjQo77SYEMl344fndfbGBjTpIjiB2Cs65Wuwymgmj/AZxdDKJFzUrXu/njs
 cxThUQpehWjA1rdEVnzToC2Ybgr1G7HroDX7f3bLq73nzVrMjW96XyWTSPI5OmTLWY3J
 omH2GU9lKHrFPms62PGtQdEq7Vyj4aT9zibdWcSjg79EfZWe9km0qhqkhKWogvj25Vhh
 o1XAtsV4SXfWTyCmLhCtnop3RbAJYFMhW9ooQGFT0/L6Cg4tjlrKfQ6JQ4MEyHzSwyt6
 4eTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpC7ub+rxIXteqSlgiHGzySyxMBGv/uxqrlALzsI3jkUPZ/gqV4B7TgmNVh6QHT7gJT5Sw/A4aY@lists.freedesktop.org
X-Gm-Message-State: AFuF++lVLd+2gQnN265Tvhucgqp/YkjTtUL8zkxj+gAwsXSv7bNfVj8O
 9xLLwwDYtqf2BV43uhiplKaqAdQNI0RqJVNo5le0vu0ngZA73d5we6H4xZ5+vsWDmzVuMhwniuh
 zwfY12AxgX0qZ23lvtcbza0xkQslvEB0=
X-Gm-Gg: AR+sD13rooiJfyZ2PdWcEzwoY5DjeW1ovWMns8RPKlCBbAdqlqr//W2BK6CO/mDqU+A
 8mvxPsEY8wDW9mmYZkpM8nicMjlicdQtErnvXVdDo+dKIeSR/FwlOj0KziUtKR4wuulyhTeWn18
 BhOrky83BKXVTwG1tFUVOFiwo1U0LyhEhUCet/TOZfNYqM1/nVNUDPrAvy7I/bMp1SnO/5wgeHp
 4yTLExbyHiopFhS9GAIcenLZD2eavtg5IhvZ1URXwp7UzzTQb7WROxjt7XdhlgXcyRrZghjfSN4
 Jdidp9mHnmFki5nOuViEy3tqFoZ8b2rsCWQGtTuVrDJaQWYUeMsjcM054GtGIYxxh5JhgAeHnr9
 ctiN4HG0zO9xivU+Dim9FbRsMs5Tcr/o=
X-Received: by 2002:a05:6808:23ca:b0:4b5:83f8:781b with SMTP id
 5614622812f47-4b6c0521e7emr2240049b6e.6.1788354399609; Wed, 02 Sep 2026
 06:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
 <05e8a019-903c-4249-9c82-11dce0403aea@amd.com>
In-Reply-To: <05e8a019-903c-4249-9c82-11dce0403aea@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Sep 2026 09:06:27 -0400
X-Gm-Features: AcwNN1VHMCG_cxPOyExslS2XQx_5iwrQ0iUaDKVaLAO-rs4EG3bZnJO1NorvuMU
Message-ID: <CADnq5_PELtGDm5MkC+hiGLviAEtUufjYVzCTaA2Es-NPJsmAxA@mail.gmail.com>
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

On Wed, Sep 2, 2026 at 3:25=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 9/1/26 22:10, Alex Deucher wrote:
> > GMC 9-12 use KIQ or MES for TLB invalidations to avoid using MMIO which=
 would
> > require disallowing GFXOFF.  KIQ and MES are management queues however =
and if
> > they hang, they cannot be recovered by a queue reset since they are the
> > mechanisms which handle queue resets.  Since using KIQ or MES will exit=
 GFXOFF
> > anyway, explicitly disallow it on the MMIO path and use that. Next, swi=
tch to
> > using SDMA for TLB invalidations.  SDMA 4.4.x and newer have special pa=
ckets
> > specifically for this purpose.
>
> That packet was just introduced to work around SRIOV issues and proved to=
 cause stability issues as well.
>

It was introduced because of gfxoff and having to toggle it to use
MMIO.  WIndows uses SDMA pretty much exclusively for TLB
invalidations.  It's also what the memory hubs team recommends.

> Since Arun now found that on basically all Navi generations the SDMA can =
hang while doing a TLB invalidation I have to clearly NAK this approach.
>
> In the long run we should do the TLB invalidations on newer HW completely=
 with the MES, the SDMA was always just a workaround we should not push for=
ward.
>

Well KIQ and MES also seem to be problematic as well.  See the thread
from Denis about KIQ and his renoir system. There are also various
reports of MES timeouts doing TLB invalidations.

Alex

> Regards,
> Christian.
>
> > If SDMA hangs while doing the invalidation for
> > some reason, it's easier to reset the SDMA queue than KIQ or MES.  Fina=
lly,
> > most of the TLB invalidation code between GMC 9 through 12 was identica=
l, so
> > move it to common GMC helpers and remove the IP specific code.  If the =
SMDA
> > and MMIO pathes prove to be stable, the KIQ pathes can be removed in th=
e future
> > to further simplify things. SDMA 4.x could also be updated to support P=
ASID
> > invalidation via SDMA using either the new packet (SDMA 4.4.x) or via
> > REG_WRITE/REG_WAIT packets (SDMA 4.0.x).
> >
> > Code is available on this branch as well:
> > https://gitlab.freedesktop.org/agd5f/linux/-/commits/tlb_inv_rework?ref=
_type=3Dheads
> >
> > V2:
> > - Add missing hub callbacks in gmc9 hubs
> >
> > Alex Deucher (31):
> >   drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
> >   drm/amdgpu/gmc10: disallow gfxoff around TLB flushes
> >   drm/amdgpu/gmc11: disallow gfxoff around TLB flushes
> >   drm/amdgpu/gmc12: disallow gfxoff around TLB flushes
> >   drm/amdgpu/gmc9: set vmhub funcs for gfxhub and mmhub
> >   drm/amdgpu: add a gmc flag for using MMIO for TLB flush
> >   drm/amdgpu/gmc9: use MMIO for TLB flushes
> >   drm/amdgpu/gmc10: use MMIO for TLB flushes
> >   drm/amdgpu/gmc11: use MMIO for TLB flushes
> >   drm/amdgpu/gmc12: use MMIO for TLB flushes
> >   drm/amdgpu: add a buffer funcs callback for TLB invalidation
> >   drm/amdgpu/sdma5.0: add tlb invalidation buffer func callback
> >   drm/amdgpu/sdma5.2: add tlb invalidation buffer func callback
> >   drm/amdgpu/sdma6: add tlb invalidation buffer func callback
> >   drm/amdgpu/sdma7: add tlb invalidation buffer func callback
> >   drm/amdgpu: simplify amdgpu_gmc_flush_gpu_tlb()
> >   drm/amdgpu: add tlb invalidation method enum
> >   drm/amdgpu: plumb tlb inv method in amdgpu_gmc_flush_gpu_tlb_gart()
> >   drm/amdgpu: uplevel reset check in amdgpu_gmc_flush_gpu_tlb_gart()
> >   drm/amdgpu/gmc: add new callback to lookup vmid to pasid mapping
> >   drm/amdgpu: add a gmc callback for the inv semaphore
> >   drm/amdgpu/gmc: rework pasid flushing
> >   drm/amdgpu/gmc9: use SDMA for gart TLB invalidation
> >   drm/amdgpu/gmc10: use SDMA for gart TLB invalidation
> >   drm/amdgpu/gmc11: use SDMA for gart TLB invalidation
> >   drm/amdgpu/gmc12: use SDMA for gart TLB invalidation
> >   drm/amdgpu/gmc10: use SDMA for pasid TLB invalidation
> >   drm/amdgpu/gmc11: use SDMA for pasid TLB invalidation
> >   drm/amdgpu/gmc12: use MES or SDMA for pasid TLB invalidation
> >   drm/amdgpu/gmc12: drop MES tlb inv in gmc callbacks
> >   drm/amdgpu/gmc: add helpers for various tlb inv functions
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c |   2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 486 +++++++++++++++++++----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  33 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  18 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |   2 +
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c |  33 ++
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  33 ++
> >  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 202 +---------
> >  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   | 207 +---------
> >  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   | 250 ++----------
> >  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c   | 225 +----------
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 135 ++-----
> >  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   |   4 +
> >  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c   |   4 +
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  |  33 ++
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  |  32 ++
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  32 ++
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  |  32 ++
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  49 +++
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  49 +++
> >  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  49 +++
> >  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  48 +++
> >  22 files changed, 943 insertions(+), 1015 deletions(-)
> >
>
