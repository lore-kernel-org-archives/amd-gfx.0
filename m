Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A15C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 18:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 702EE10E2B3;
	Wed, 13 Dec 2023 18:28:32 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 133A010E7CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 18:28:31 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5906eac104bso4260168eaf.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 10:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702492110; x=1703096910; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2suwt8vSdQ/DeMNrSZbO0otw3V4vmPXaSVKVeklDiw=;
 b=IYRmim5S3/WyZ7uttnGseQmzHBTzTKQM+SPCgzaKMiekxq2Sce1secicVmhtL8HmQz
 myY8GrvmdEOyijBO8QCRpSjatnmJMEjBiDoA11rtmXtO5ocOehwJLbJcLftdz2CeU0a9
 9QJXpN21Zdx1iO5hc+u5bA9h0u5Wu869hS/hR6HRp54OEzFxEhMh8ElkrFM4u60uyH3V
 p3bfhI4Gx4hGW9ufqyfLm/OVFJoWn4WK10AD0jGC99Pwlo96ojn1jvhkw8MnAE3M0deW
 W72rdHONxcqM5ks+bJbYTbZaiBXvp6b6bLdQu891GoD07g7V5yV1UIn1kOByl0ykgN+I
 SP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702492110; x=1703096910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z2suwt8vSdQ/DeMNrSZbO0otw3V4vmPXaSVKVeklDiw=;
 b=C/AqlDJjwLIqbGu9Sg2o0Ove//RKEgwSGpCPevpTruv5IUiMiAKhNLKplEH2/F5q2p
 eZeWW2q02BNvFVFCH1m1FMlm7lvJKY/HpBZpwBCVijXBzFRg8WMn25OiCESxKq5a3ES5
 t3QzMiKsoRlaap/jpXb/A4jhD1tUrMjJt6TroHfDJfJzxbI3UVmZpit+jL6SmYFiURX7
 RpKfkdV2gQgIdzyYbEE6biCoxtpAJGD+Q2J7MxMkMZCRDx8op3ZDTM+dHnyQo4Ras1rp
 u/msJz12n4V3ozHZPaqOhpb9bvqZIqAXFN+1UILyGj/UfNcQ6LvAX61OU2pGrnjQ2rJH
 h5zQ==
X-Gm-Message-State: AOJu0YxIiUE3GhaxOoVAmL7Qpmz5miwCjT9SRMkqDbjsM5mG1jXek4Zx
 xYmu38K4ARN1iWwC4pYA4EWSd1TBdeM8rD5kJzg=
X-Google-Smtp-Source: AGHT+IEE8NGbqkyFPIlrmSp4009XZ22BdueAT9TWg3vReqvOQyrtrSyGp1oHJ2Dq1q9nFO7I20ZYRQZL43VNElqArto=
X-Received: by 2002:a05:6870:a68a:b0:203:294a:50da with SMTP id
 i10-20020a056870a68a00b00203294a50damr1305331oam.75.1702492110198; Wed, 13
 Dec 2023 10:28:30 -0800 (PST)
MIME-Version: 1.0
References: <90172f4c-7cf7-b4ac-d630-42198bb80d62@gmail.com>
 <b236ff60-085b-460a-b1eb-ddcea1c79094@amd.com>
In-Reply-To: <b236ff60-085b-460a-b1eb-ddcea1c79094@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Dec 2023 13:28:18 -0500
Message-ID: <CADnq5_OxNQGebrUT=F_ir9GGLGCHummgZpqsc-ma63t-H=mqGQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: Prevent multiple debug error lines on
 suspend
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
 Woody Suwalski <terraluna977@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied manually.  Please double check how you are sending the
patches.  git complained about a malformed patch.  I'd suggest using
git-send-email.

Thanks,

Alex

On Wed, Dec 13, 2023 at 1:45=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 13.12.23 um 00:31 schrieb Woody Suwalski:
> > Fix to avoid multiple debug error lines printed on every suspend by
> > Radeon driver's debugfs.
> >
> > radeon_debugfs_init() calls debugfs_create_file() for every ring.
> >
> > This results in printing multiple error lines to the screen and dmesg
> > similar to this:
> >
> > [   92.378726] debugfs: File 'radeon_ring_gfx' in directory
> > '0000:00:01.0' already present!
> > [   92.378732] debugfs: File 'radeon_ring_cp1' in directory
> > '0000:00:01.0' already present!
> > [   92.378734] debugfs: File 'radeon_ring_cp2' in directory
> > '0000:00:01.0' already present!
> > [   92.378737] debugfs: File 'radeon_ring_dma1' in directory
> > '0000:00:01.0' already present!
> > [   92.378739] debugfs: File 'radeon_ring_dma2' in directory
> > '0000:00:01.0' already present!
> > [   92.380775] debugfs: File 'radeon_ring_uvd' in directory
> > '0000:00:01.0' already present!
> > [   92.406620] debugfs: File 'radeon_ring_vce1' in directory
> > '0000:00:01.0' already present!
> > [   92.406624] debugfs: File 'radeon_ring_vce2' in directory
> > '0000:00:01.0' already present!
> >
> >
> > Patch v1: The fix was to run lookup() for the file before trying to
> > (re)create that debug file.
> > Patch v2: Call the radeon_debugfs_init() only once when radeon ring is
> > initialized (as suggested  by Christian K. - thanks)
> >
> > Signed-off-by: Woody Suwalski <terraluna977@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Thanks for the help,
> Christian.
>
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_ring.c
> > b/drivers/gpu/drm/radeon/radeon_ring.c
> > index e6534fa9f1fb..38048593bb4a 100644
> > --- a/drivers/gpu/drm/radeon/radeon_ring.c
> > +++ b/drivers/gpu/drm/radeon/radeon_ring.c
> > @@ -413,6 +413,7 @@ int radeon_ring_init(struct radeon_device *rdev,
> > struct radeon_ring *ring, unsig
> >              dev_err(rdev->dev, "(%d) ring map failed\n", r);
> >              return r;
> >          }
> > +        radeon_debugfs_ring_init(rdev, ring);
> >      }
> >      ring->ptr_mask =3D (ring->ring_size / 4) - 1;
> >      ring->ring_free_dw =3D ring->ring_size / 4;
> > @@ -421,7 +422,6 @@ int radeon_ring_init(struct radeon_device *rdev,
> > struct radeon_ring *ring, unsig
> >          ring->next_rptr_gpu_addr =3D rdev->wb.gpu_addr + index;
> >          ring->next_rptr_cpu_addr =3D &rdev->wb.wb[index/4];
> >      }
> > -    radeon_debugfs_ring_init(rdev, ring);
> >      radeon_ring_lockup_update(rdev, ring);
> >      return 0;
> >  }
> >
>
