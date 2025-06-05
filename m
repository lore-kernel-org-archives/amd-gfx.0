Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E70C5B543
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 13:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A9010E8B5;
	Thu,  5 Jun 2025 13:24:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GJN9shWA";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2AEC10E8B5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 13:24:40 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-23519817b57so1226205ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Jun 2025 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749129880; x=1749734680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJBWtQose0osBzm/pBhy+XNNiusshi6shoZFyT5pqas=;
 b=GJN9shWANvh/EDSFQQJCIXmH+CszvRdbRbwsuhHZEdRelyRzDEc+HM17/jfLwLxAVs
 1Luu0ETPFiRR2pPJCuiMBOyC+QdHKias7hd6+LjS2IXbQZNPnrgB/N6vSJu450w4fKWC
 nUxiizEx8JRNMIFQUFUuPZCWc6/wbw1g3Lru/8k8a8hr3VeRDxh6/VqjqhV4B1VykOaR
 VfZrQcXhiXaA8H+5RPJLHG5lP96Uk0F9o9F81Z6I5/YaXN81GZgI55zm8d8DnLniYxW0
 6CnfmObPpcr5cwSP5LjNbLfHo4J2TbXPOPJkF2NYwouWoSPPYuZZHdVZkEd1K5gKofnc
 MNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749129880; x=1749734680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJBWtQose0osBzm/pBhy+XNNiusshi6shoZFyT5pqas=;
 b=pIA0KdHUnRzBoBQN6+iIzQc0SSEiMFZOhmrM1RZX6cLHPrNjKolUP+wrrbsO9XslE+
 /h6K189pz/V7X9IG8thX/seYkbDWPsLkvFWCkXDCZxewKgaT95EnqUpFHL2N3mTmNEoB
 GYyZYhgb23Gal6WbM9FZ04F+b8yGPhy3ZYgQzQ+lOyj7z0x5y/zzOOCrcuEwZHanX+Lc
 BkBf/1GW1ccC2DBjT4N8g0sKcsbqYPdp3bB1O7DFkTiGaROPG1ii8jkz2hAAQCZifeov
 vspZiFhKrX8Bea/x/BqMervj7G7SOrOwjZNx+0SrhD1HAca7Mvjv5NMv8DjCdPm9vIYl
 /SjA==
X-Gm-Message-State: AOJu0Yyn7u3QpCh+KWrXycjZcrB4VRpCq1AhRqrg6w2GHuUjN/4squbk
 zCcRoaqQ/TMhLgL4sT4G3f3xjrfAGZKBY7cN+/YEks2VGGp2z6Nuwm6XTPoXa3DCOMQiRWnwX6x
 R9v7oFB2Ft2HSsSMKhe4xD+gXC6cwY2biKA==
X-Gm-Gg: ASbGncvh/+pN3ZYNId6rh+vZm7mEfdsuTv2NeZQkNofR01IHD5l54twBHJU06ulIKmm
 y8P//CFl8mHn7SpjU4z3G2HO9aLA9D1MdW9RSmAS09tzH9atFTxKPU1SGCTie49yKTIBBbojfDk
 LG3wHaGcFfaMU1iKYpwjeW7laKz6pAcahGMQ==
X-Google-Smtp-Source: AGHT+IEL/D1DCxIrmWz7j1lHtUPZaNJBuuHNOImoldZYQ9dscMQzurBb4MvNJNUwksUkSlf2KpyR5lk5RQmw0XBeop8=
X-Received: by 2002:a17:903:22c5:b0:235:239d:2e3d with SMTP id
 d9443c01a7336-235e11e5b3emr38128595ad.9.1749129880239; Thu, 05 Jun 2025
 06:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-2-Prike.Liang@amd.com>
 <CADnq5_NadVhtnAx32FR_v_wY6uaVS8fFRo4V_8ccdPbbOz9thw@mail.gmail.com>
 <DS7PR12MB600576986FFCBF8951BD84F2FB6FA@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB600576986FFCBF8951BD84F2FB6FA@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Jun 2025 09:24:28 -0400
X-Gm-Features: AX0GCFvjKEgSFn7MpWHTbMUZIa5q-r_ZNH_LPc5mKNAwhUrlYxIBC8EpCp-o0DY
Message-ID: <CADnq5_Pn8C4k6RN5PonQ6oCAr4F7hghMosU7AWcJ3ZgXyi4SAg@mail.gmail.com>
Subject: Re: [PATCH 2/9] drm/amdgpu: bail out for userq unmap error
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
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

On Thu, Jun 5, 2025 at 3:54=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> w=
rote:
>
> [Public]
>
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Saturday, May 31, 2025 5:34 AM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>;
> > Lazar, Lijo <Lijo.Lazar@amd.com>
> > Subject: Re: [PATCH 2/9] drm/amdgpu: bail out for userq unmap error
> >
> > On Fri, May 30, 2025 at 3:55=E2=80=AFAM Prike Liang <Prike.Liang@amd.co=
m> wrote:
> > >
> > > Before destroy the userq buffer object requires validating the userq
> > > unmap status.
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > index f67969312c39..8eea0e1e1b6a 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > @@ -319,6 +319,12 @@ amdgpu_userq_destroy(struct drm_file *filp, int
> > queue_id)
> > >         }
> > >         amdgpu_bo_unref(&queue->db_obj.obj);
> > >         r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
> > > +       if (r !=3D AMDGPU_USERQ_STATE_UNMAPPED) {
> > > +               drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Can't unma=
p the queue
> > for destroying.\n");
> > > +               mutex_unlock(&uq_mgr->userq_mutex);
> > > +               /*TODO: before return may need to a reset*/
> > > +               return r;
> >
> > If we return early here, we'll leak memory.  Presumably if the unmap fa=
iled, the
> > queue is hung, so it shouldn't cause any problems.
>
> [Prike] Yeah, maybe it only requires an aware here and then continue dest=
roying the userq software resources.
> Do we need to reset the queue when unmap fails during userq destroy?

Probably.  Otherwise I suspect the next time the MES tries to use that
queue it will already be hung.

Alex

>
> > Alex
> >
> > > +       }
> > >         amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
> > >         mutex_unlock(&uq_mgr->userq_mutex);
> > >
> > > --
> > > 2.34.1
> > >
