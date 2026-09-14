Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF41C88E77
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 14:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68DB910EED3;
	Mon, 14 Sep 2026 14:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RR+IW2no";
	dkim-atps=neutral
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F40A810E8C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 14:11:56 +0000 (UTC)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc4e4979c47so80963a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 07:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789395116; cv=none;
 d=google.com; s=arc-20260327;
 b=rdVJ1loAQtEl4/tIUexj0/TLdZH7axmH3/z9d7gCdWqfTfGI9L/YJTpiv7mJ2VecaH
 ewGJOPd3NiPAZ6JPGBQm+lwm7BOjOah77ukXzWmhL1At3K5N0BIwUOj7Jc6Lhd8Epsuh
 lPJSG59OQ4HC5cKuzNZFD5eNjiezIuWuLY0/k5yVdxEskqBnvWymqpOlY7VnLJVDEkd6
 FWX4yNVjR3CrouENvxRQ/4yvi5m4NMJpPbzUz0UPx+XFsCtwvXAc3/0jWsuJkz/joCDT
 p88jloIyxotppTwYzU/bULDjlbhX4aZsjt8FUj+Pp7Hek2FokHdwLEwZ68mcjHoNuYXJ
 DlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4rj/r25LyFLXL2H83H1Ljh+5fD7NhfkZssLHdM2663E=;
 fh=nO7cB3uWcOULCv9hLT0gsUFKFgzC3QvuzsO3l3yfx+s=;
 b=EUECCpKxk006RpojyXeRbmCt9eheSU24Suz0DZ5NENrHlF7OMtAb1Tvd3QOlWhTA3S
 2QkguUHkvUTOdlt01P4/DhG+P2wLws+l7Rp4fyndBFxZoSQJft5pRWCAsnXQHZGLxBsr
 lBUsc8Qa998+ZXo5ddsYRiKLjcJ/PUIocy+4HJpJraeT5mGLXfOUmrDL+bM9gauZr+Ts
 G68nmLZvv9IcpF7NIhHcrpxiXVWXH+jwCK0fB7ehA7rKkr/VdNIVnCJ8Ie30KapuMNTj
 rcvOhChLx0M9ASEbXlEhgB+coZRBU8Ijse0RfzPN3O8/I+rc5tzEmox+2Ex/g3N8oA1e
 gosA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789395116; x=1789999916; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4rj/r25LyFLXL2H83H1Ljh+5fD7NhfkZssLHdM2663E=;
 b=RR+IW2nofCjAlirBSZkMODluabgsIYiIIuvWSr8xp/Q9bRvFjPIk/x25178fySVlkG
 q5jndsW6+JbCe6B4plgRv9JUQZYpPUxDca3N7BbE5yLEJ6x1CJVbegczgd09UfCEd3yD
 p3FDJnJHkFMTxjKd6KKxD2x7ZCpvk8VtM6t6Cn83ythVXSlARuDV01j1+dj+0EdGB47V
 HfWyUznnwwqZrzzQMTBZ9FhS2Dbp+PC4znBx3PU1OAncomto2BsoVU83vb5p1H6e1Fo8
 qyTnYkhFPic4KgS714BAedaGf2wFu3uZfJcryovO8vtM7Z9X+9cz3JO2tKSFnkU9Zwjf
 Wwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395116; x=1789999916;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4rj/r25LyFLXL2H83H1Ljh+5fD7NhfkZssLHdM2663E=;
 b=BOtLZ2WswbpzjW1eBNqwUS49ReveMAhppWyxLRr41dXFB/qC7dmTWcMhs/vmWOCHbB
 nySh2x/JWRCPAuO5Bdlm6xMrTlhYhUtqgwHQ6j/KpzoR2YBiPKxsuKHh4bXZuVrng9fO
 1SzJle4/eZkOYaQDXH+KAuiGKStNrrldrQEjyzxNtlgMS/4HyzaEP6edm7mNaxUwlb5b
 avSt81Af2nnwtzgUw//omx4FYqVwkqqnuOV8Y9OfjM/Fx3hQaNsz3smK7iE+FnU9l8+s
 HLNhrq3c78kMwG6mM6kWEko5vSPxOfMtdg4pj2W0r91yUdt9jb1ajH7k6ZUPeIVFlG87
 dU4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzul2u7v3ufeBSHi2lPAPDBjQN4ohSug2/mlw3/o8EHghPDtaHuCdRXJSm27GLeDiywlzp4gf3N@lists.freedesktop.org
X-Gm-Message-State: AFuF++mXG3bWiXL6V8riv5NehQUuv3+0ad6zBdT//2fYMlIsShQdt9eP
 qgA03hihC18g6V4zznQcP1JN1wbJe9e/eVkDmxO1umyb9hvKy1BdMOxL12cDwelxCagPsolLpVP
 QPjs974PTSTcXTSKEz/NWBef2tGZt6WU=
X-Gm-Gg: AYBFou39mOXrdpwhm9wDSotvfiuYoPwcfi+WlBQWE99Ejm/CFOEStq2gY098K7prlVO
 0qVKNTehOaS/nA+8Wtkhp31R9DZP6pGI7dWLsCzTyMeCF6V8SKVVpRgNo7FvPuctf97/9mg/F+k
 XoCJ9QyiAQCc3uzB1NNjNs2qgEnt/pAMDA0x+8W3SfvmmhNSqDdYQn4Ik8YqLEjZbspUdHd0xrR
 wQFAKd2SpRlFFYWDrg1B+9aSKP+3HPrnDbH5ea9cZH0zPAryH83KZmjHaC2wkLZuioZxuDgCFmM
 O3mRCZpprQg82GvcNoqZuRSTiQTBMRH9Ojx4s1QEwY99BXfgBTf59PWOuxM5ka8IXqYVbwoS1Dx
 k55Ucstn/ZbW2gMlfvf4zMJiXQVJ47d1EyJ1ZvizJqg==
X-Received: by 2002:a17:90b:390f:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-39dec1aa1cbmr3754762a91.4.1789395116294; Mon, 14 Sep 2026
 07:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <358a518d-1490-40ba-bbe3-7f3696c1d696@amd.com>
 <20260911183825.935140-1-mike@fireburn.co.uk>
 <afb6cf0f-ca0b-4fb9-b7f7-2355ed45386c@amd.com>
In-Reply-To: <afb6cf0f-ca0b-4fb9-b7f7-2355ed45386c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Sep 2026 10:11:44 -0400
X-Gm-Features: AcwNN1VTuk_e5gAg5i1SrKs6UFcqZjBHCJ6WW0AE0n88d1R64cVdkQO01fkBy4Y
Message-ID: <CADnq5_Ngcrfh4m5fHs4R-S8kRHVf-9qT1_wPwBcV6OsXfigDrA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: hold a runtime PM reference for P2P
 dma-buf attachments
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Mike Lothian <mike@fireburn.co.uk>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, kevinyang.wang@amd.com, 
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
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

Applied.  Thanks!

On Mon, Sep 14, 2026 at 6:51=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 9/11/26 20:38, Mike Lothian wrote:
> > amdgpu_dma_buf_map() adds VRAM to the allowed domains for a peer2peer
> > attachment.  GTT is only a fallback placement when VRAM is preferred, s=
o
> > ttm_bo_validate() migrates the buffer from GTT into VRAM.  While the
> > exporting device is runtime suspended its SDMA rings are down and the
> > move fails:
> >
> >   amdgpu: Move buffer fallback to memcpy unavailable
> >
> > An importer on a second GPU reaches this holding no runtime PM
> > reference on the exporter, e.g. a compositor on the APU submitting a
> > frame that references a buffer exported by an idle dGPU:
> >
> >   amdgpu_cs_ioctl -> amdgpu_cs_parser_bos -> amdgpu_cs_bo_validate
> >     -> ttm_bo_validate -> amdgpu_bo_move -> dma_buf_map_attachment
> >       -> amdgpu_dma_buf_map -> ttm_bo_validate -> amdgpu_bo_move
> >
> > Pinning a dma-buf into VRAM has the same requirement, which
> > commit 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference
> > when we attach a buffer" v2") called out as the one case that would
> > need the reference back.
> >
> > Take it in attach and drop it in detach.  pm_runtime_get_if_active()
> > never resumes the device, so it cannot deadlock against the reservation
> > taken during resume, which is why the old pm_runtime_get_sync() had to
> > go.  If the device is not active, clear peer2peer instead: the buffer
> > then stays in GTT, which remains accessible while the GPU is powered
> > down.
> >
> > Fixes: 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference whe=
n we attach a buffer" v2")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> > Assisted-by: Claude:Opus-5 [Claude Code]
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >
> > v3: take the reference in attach and drop it in detach, clearing
> >     peer2peer when the device is not active, as suggested by Christian.
> >     v2 only covered amdgpu_dma_buf_map() and left VRAM pinning exposed.
> > v2: use pm_runtime_get_if_active() instead of testing
> >     adev->mman.buffer_funcs_enabled, which was racy against a
> >     concurrent suspend.  Reported by Sashiko AI review.
> >
> > Reproduced on a HawkPoint APU [1002:1900] driving the display with a
> > Navi 48 [Radeon AI PRO R9700] [1002:7551] on oculink for render
> > offload.  Without the patch kwin_wayland hits the call chain above
> > within a minute of the dGPU autosuspending and the desktop stops
> > repainting until it resumes.
> >
> > Tested with v3: Chromium rendering on the dGPU and composited by kwin
> > 6.7.5 for five minutes, then closed.  The dGPU stayed active while the
> > window was on screen and suspended six seconds after Chromium exited,
> > with no fallback errors or runtime PM usage count underflows.  After
> > an hour of yuzu render offload the dGPU also suspended once yuzu
> > exited.
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 39 ++++++++++++++++++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_dma_buf.c
> > index b33c300e26e2..fae695c3e531 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > @@ -43,6 +43,7 @@
> >  #include <linux/dma-buf.h>
> >  #include <linux/dma-fence-array.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pm_runtime.h>
> >
> >  static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
> >
> > @@ -100,15 +101,50 @@ static int amdgpu_dma_buf_attach(struct dma_buf *=
dmabuf,
> >           pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
> >               attach->peer2peer =3D false;
> >
> > +     /*
> > +      * P2P access needs the exporter awake for the lifetime of the
> > +      * attachment.  pm_runtime_get_if_active() never resumes the devi=
ce,
> > +      * so it cannot deadlock against the reservation taken during res=
ume.
> > +      * A negative return means runtime PM is disabled and the device
> > +      * cannot suspend, in which case the put in detach is a no-op.
> > +      */
> > +     if (attach->peer2peer &&
> > +         !pm_runtime_get_if_active(adev_to_drm(adev)->dev))
> > +             attach->peer2peer =3D false;
> > +
> >       r =3D dma_resv_lock(bo->tbo.base.resv, NULL);
> >       if (r)
> > -             return r;
> > +             goto err_pm_put;
> >
> >       amdgpu_vm_bo_update_shared(bo);
> >
> >       dma_resv_unlock(bo->tbo.base.resv);
> >
> >       return 0;
> > +
> > +err_pm_put:
> > +     if (attach->peer2peer)
> > +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> > +     return r;
> > +}
> > +
> > +/**
> > + * amdgpu_dma_buf_detach - &dma_buf_ops.detach implementation
> > + *
> > + * @dmabuf: DMA-buf where we remove the attachment from
> > + * @attach: the attachment to remove
> > + *
> > + * Drop the runtime PM reference taken in amdgpu_dma_buf_attach().
> > + */
> > +static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
> > +                               struct dma_buf_attachment *attach)
> > +{
> > +     struct drm_gem_object *obj =3D dmabuf->priv;
> > +     struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
> > +     struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> > +
> > +     if (attach->peer2peer)
> > +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> >  }
> >
> >  /**
> > @@ -350,6 +386,7 @@ static void amdgpu_dma_buf_vunmap(struct dma_buf *d=
ma_buf, struct iosys_map *map
> >
> >  const struct dma_buf_ops amdgpu_dmabuf_ops =3D {
> >       .attach =3D amdgpu_dma_buf_attach,
> > +     .detach =3D amdgpu_dma_buf_detach,
> >       .pin =3D amdgpu_dma_buf_pin,
> >       .unpin =3D amdgpu_dma_buf_unpin,
> >       .map_dma_buf =3D amdgpu_dma_buf_map,
>
