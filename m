Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50687FF8867
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 13:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68C810F036;
	Wed, 29 Apr 2026 13:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j4mI7QNK";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E00FB10F036
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 13:57:30 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2d96243c8a1so566621eec.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 06:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777471050; cv=none;
 d=google.com; s=arc-20240605;
 b=cmi+QSNaNSNVjs1TX8dk5/wpAA46Fmgw+0ty/k1+jmR5FClP/B5ucX9pOAznIo1tKm
 xPkZ1jDK6FLsLYPs759wYIYfgGFwLgrX4S96iQQdPIQ5DU7Var9AY1eO+AoN/0nO4I6p
 DO8iZb5S7oZuXFTjQbEu4Y5lBRn1KjPpa0zlRFLhNqE4GRysa83wFbMi+qq6x2My6R8y
 oa7L/rodjrB2J7T4CQtF1I/GkAfTO5YGNSJjV/j1ubSNrqNSPqN5O5eC6nq/LvAFKWA/
 1NTYWr9GGPkxRnHyYJ7vrnOm/BxRXgwD8rKLm/Gc1+H14wKPo9qhpw2s/a5z4q2UCUsb
 K5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VxQf02kQA2HgfY1KAwWB8C7WomuU6ae/y8bez4V1mxI=;
 fh=8btewodYnkIn4hckEkjuh3yZKjDw1fEjZzHyH4dTJ4I=;
 b=TYuEZIyps0dmzaR3dxUl2wIxvW+aRhDpC0BDfkmEFs3Lbawk9xY/90r/mJlxlc4JMn
 qu/fYFfvTxh/5pJRI677A6mR6/JfFNdQtoItJn40qbzQ+FgMnkuLfpWAhFcmYEPVwivw
 cWHmdYOhLx6ZWDdZPuZu8AiYxgo1AwUJJZmRmwbOfe2MpQDRWFAw39jblo6tw/hf226O
 g+loZapcI1y+Jcl9lAPqlRTmysOKWm4ti0ylAnSYrUto8VJRu1Wd8PBLw2AHmdfG837L
 b76XXgxKd8LUqSDJ/9qClKj1EnXZmPcfdh6CMupDvwo6rEGyqlsFzkvic1/1W7z6l7d6
 ecxg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777471050; x=1778075850; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VxQf02kQA2HgfY1KAwWB8C7WomuU6ae/y8bez4V1mxI=;
 b=j4mI7QNKatFXOd2dH5/bSrwMxirM7SYC2/SXKVAohdNXLTltxhAAcCls+itjXJrGRn
 LhkrqIE9LoxuR4chptZ1S7m4OJi4IQ92uRzDONBdGIaSHxbPOQcPPQW5ROSDcVQi0580
 1Nvj0ogF3L6zWdSlWR4REeYgpESoVHpyi8XMWpxY/DvPyBJI6RnS96/bMdS4MTksiaLL
 9bkZZkzdvtYeRmIsZi9CiJieL5qGq3iQ9YuoOMHXS5FdDznI7xWF7HeVQXbeeooKI7Lo
 5J4aSLd53SLc1Z4wWXvAKrRZHsIPi1MOGJ/tVtZFachUdD0QXpcaLLxhtClYA5jOuLY5
 qsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471050; x=1778075850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VxQf02kQA2HgfY1KAwWB8C7WomuU6ae/y8bez4V1mxI=;
 b=B2F94GISx4cl/oFUZ3Bc0vmouuFiepJ3CuWnBrm03fDRyBG7ASRVGvqf3n5Sic5kuD
 Hy2uMwXVgEQkswNf7vlXu4haefM5BkWvhiIEwJp93CeX5kLRl3UeayTKcUTNG/qtmyno
 PMo4yqG1Xsru6TQbWhSQZREa0QlywL5OP5ap2b3qEboIIXqb9dbSypejjUwuRVN5NGDp
 G2pc1wfyWpGo92s8Ioj1b+y8m3o3ePcmQ6EQ3g1ChduFCQQjG4vitcUa0l8FyhD1+Na2
 AUW23a2f0UTDi1zKW608UIRVuFVQOWkjYqvSPjQLigf/NUDm4DRtcBFidf/qC/+4zo2n
 DdNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Nqk9i4oqNiEYZ6PtrZZvpwVCFLQldGPoGbwqdLm+iB5pgQ5d2vKq9xOMo3jrTj2XDNkxw3dMo@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/JqTykn1th54c2pnzYRFH7XBroSMODLahE/39qjaO5LM5u0s7
 jTc1gDmszjnn3+Fy5N7OdJKElwu2HtVYCBTkAkQGBbvYfs4sW9j7RKhru7ywWnbpq1lPtUMT06u
 BNoSjZnHZrqWZabxqxOrw5PshLZdDgxk=
X-Gm-Gg: AeBDievh5Q9+NeYAh0ywHZSwa00zGmZHDwHEi1h3rK8zWUll76tpTujHbz1wWwgRV+J
 jSMTM1FUMIhlfB0WnvTb1jYV9IofjiIzcQUGZLZC3NXsc144UUFELtPkiB4V83Xu0TXF63eq/0A
 5ZncVhissBFStWEv4KgF9XVuEorY8eqAmC4X81CRdrWgh7WnqCjTKlYNjm3iVvKx5vfAj2DzIN4
 jHhoQwZs0Sa/ikKgXLaVLU7p7apwN637MgZO2mfKUPOChJe2Bxy4iUyTaqe/6cVOyoHwAH9SyLL
 5z1X0UEJA91kK8Dk+o3gPpb5du1qQVuBoZH/WS26zUitsuNt1o8jP6AHX7lNVT0W+/3I7eywyIx
 ZQ6FTmoGetPJD8H8=
X-Received: by 2002:a05:7022:b8e:b0:12c:900b:9dee with SMTP id
 a92af1059eb24-12ddd4e179fmr1708383c88.1.1777471050131; Wed, 29 Apr 2026
 06:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260428163512.9504-1-jbmoore61@gmail.com>
 <af9d66d4-e0c3-4ca2-ae6f-db125c19486c@amd.com>
In-Reply-To: <af9d66d4-e0c3-4ca2-ae6f-db125c19486c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Apr 2026 09:57:18 -0400
X-Gm-Features: AVHnY4K7_KKeGIWj5jkjlv4v1FguZJSJle6aGo2V0bC7-ZNe1bGwGHOzvve6ztQ
Message-ID: <CADnq5_PHZYTXPeHLZT4zQk9Utgwg_GCz_=+17RkZhhKSHUA9eA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu/gfx9: drop unnecessary 64-bit fence flag
 check in KIQ
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "John B. Moore" <jbmoore61@gmail.com>,
 Alexander Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

Applied.  Please double check your mail client.  It seems to have
mangled the patch, so I had to manually fix it up.

Thanks!

Alex

On Wed, Apr 29, 2026 at 4:22=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/28/26 18:35, John B. Moore wrote:
> > Remove the BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT) assertion from
> > gfx_v9_0_ring_emit_fence_kiq().  The KIQ hardware supports 64-bit
> > fence writes; the 32-bit writeback address constraint is an
> > upper-layer convention, not a hardware limitation.  The check serves
> > no purpose and should not be present.
> >
> > Found by code inspection while investigating related BUG_ON
> > assertions in the GFX and compute ring emission paths.
> >
> > Signed-off-by: John B. Moore <jbmoore61@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_0.c
> > index 47e81c33d..fb2a0f1af 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -5679,9 +5679,6 @@ static void gfx_v9_0_ring_emit_fence_kiq(struct a=
mdgpu_ring *ring, u64 addr,
> >       struct amdgpu_device *adev =3D ring->adev;
> >
> > -     /* we only allocate 32bit for each seq wb address */
> > -     BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> > -
> >       /* write fence seq to the "addr" */
> >       amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
> >       amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
>
