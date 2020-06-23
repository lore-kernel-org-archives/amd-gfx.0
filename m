Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A9BC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 10:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1664D2072E
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 10:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OB5LbnFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1664D2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C91196E991;
	Tue, 23 Jun 2020 10:22:08 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E0286E990
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 10:22:07 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id o8so709700wmh.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 03:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=8MJZaey/8nrc4SU4YxN+QY48qHrK1/CFR5/NqTMnCYg=;
 b=OB5LbnFjkLYYY2KQ2G3kAOp4JdSQqqpWvY5hrGmd5zFrsIC+g70q/qtmG2jdV3Gk0X
 iq2FYvjHOCAQ9vzGiMFup9kla0scvl17kEOVch3OoKngXwviMu73SQN9wKmpczSRpUzS
 RSJMBCOwwpk9Pwff7Qt/lRFxDpqkRuoc4i9qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=8MJZaey/8nrc4SU4YxN+QY48qHrK1/CFR5/NqTMnCYg=;
 b=CjCK7jQLaN2eN1W5wnJd5MkJjNphRZE+t8F+ngarQNVdU/YWFGa91rU7JkZVwCR8wq
 HeSFEk6G00aQ73O3o7MzkV+ONptCw8YTTbXC9NMVerl/8OX+sNasjpNpxiuSACVqpgIb
 dIfpv1yexSgnsIG7niWIZGR+mf3wbRrls2uPL3lKQU2pt6YuyByxoK0JeFIccAqLRJhP
 WHcRgV0FS7nz6H2oJ2fKw3K2kTwx9Y44f4koNkYtbUM/60AszMkaWMjEI/sisWzUL/lV
 r0m4eSahm1WJFmf0dddbwYeVZVguSBF3VYfyXRFIDWGoFdzp2r6mWxQxWX6bOqYnkIlg
 gBDg==
X-Gm-Message-State: AOAM530YUMvAQP2W7gU3GTGZS4bXYLrsvae+HIAlfZ/4Nhj0wLSVUL25
 KzDOmP6IJBXwhzMdLUudq0X2Ww==
X-Google-Smtp-Source: ABdhPJxk9v+aoyp+zhnKGMnfGcRixiH424XENful5ZKVIwbQMwNrm0VRh1rj0fZK/X2kXMwogKChkw==
X-Received: by 2002:a05:600c:2182:: with SMTP id
 e2mr7836518wme.186.1592907726202; 
 Tue, 23 Jun 2020 03:22:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id e5sm22098413wrw.19.2020.06.23.03.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 03:22:05 -0700 (PDT)
Date: Tue, 23 Jun 2020 12:22:03 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v2 6/8] drm/amdgpu: Unmap entire device address space on
 device remove.
Message-ID: <20200623102203.GK20149@phenom.ffwll.local>
References: <1592719388-13819-1-git-send-email-andrey.grodzovsky@amd.com>
 <1592719388-13819-7-git-send-email-andrey.grodzovsky@amd.com>
 <ec7dc51a-231f-f9e7-6082-5aad02965c67@gmail.com>
 <CADnq5_Oz_858bq-PRc=DsL62=TiqFaONw4qARK8NVbUVzMfuCw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_Oz_858bq-PRc=DsL62=TiqFaONw4qARK8NVbUVzMfuCw@mail.gmail.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Pekka Paalanen <ppaalanen@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 22, 2020 at 03:48:29PM -0400, Alex Deucher wrote:
> On Mon, Jun 22, 2020 at 3:38 PM Christian K=F6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Am 21.06.20 um 08:03 schrieb Andrey Grodzovsky:
> > > Use the new TTM interface to invalidate all exsisting BO CPU mappings
> > > form all user proccesses.
> > >
> > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> >
> > Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
> >
> > I think those two patches could already land in amd-staging-drm-next
> > since they are a good idea independent of how else we fix the other iss=
ues.
> =

> Please make sure they land in drm-misc as well.

Not sure that's much use, since without any of the fault side changes you
just blow up on the first refault. Seems somewhat silly to charge ahead on
this with the other bits still very much under discussion.

Plus I suggested a possible bikeshed here :-)
-Daniel

> =

> Alex
> =

> >
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_drv.c
> > > index 43592dc..6932d75 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > @@ -1135,6 +1135,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
> > >       struct drm_device *dev =3D pci_get_drvdata(pdev);
> > >
> > >       drm_dev_unplug(dev);
> > > +     ttm_bo_unmap_virtual_address_space(&adev->mman.bdev);
> > >       amdgpu_driver_unload_kms(dev);
> > >
> > >       pci_disable_device(pdev);
> >

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
