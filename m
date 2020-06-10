Return-Path: <SRS0=jeuu=7X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901D4C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 15:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E952063A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 15:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cICfxJb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E952063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00ED16E5D2;
	Wed, 10 Jun 2020 15:30:26 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 711156E5D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 15:30:24 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id c3so2741526wru.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Hw2kheZufVwjTrtJRURaqPYofZ76/f4yA/gv7Z3Uzyk=;
 b=cICfxJb4Yk2X5CvHhFMVP/m9lOzpxNzoy2WJXZ0CS6FWryJrN5O6DpFrBDPob4wuoO
 nM2r7LAcJqWdDqjJW5sr+pr1lvdwMDIEEySP7UrnHdNAtPFDHHum/PRjsNiw/16/ZcRP
 cgJcjWCuf73vwLr3a5s2qtpEvCTDi3Nn6GO8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Hw2kheZufVwjTrtJRURaqPYofZ76/f4yA/gv7Z3Uzyk=;
 b=TEBnHAOEmlasKg4bZP3ygGDteef6eON6wnnnF6/Z0gu857dLDvU3kOBT5qPgx+5QIZ
 sy4c0FFlEvEbFCSalVZ6kZYGP5BGl5/6guhZg0liQrOGwEN0UQQEaelMH7vegdpVT81/
 7LU+LJy1HiI9k8L75nVH80YI/hfB6EsDdxZ2ryqlLnKogkFfSRO/uRZSB2JOUGq9ZiG0
 9+8CeGoUMC+QnSnM3H8pezzd1o60G3NxE/Bs9S1y48B485fX6qhGLpZEP58s6VNCKbKW
 IG2OZLK8ba32Gfs3g+EYJXqAEGNS9flZuCdc9+oL5LMhk2ptFT+R63Yzcy2I04YC2ebg
 wzXA==
X-Gm-Message-State: AOAM530DfvR/eQ+pe2Vx+7pC6quW0pZKhvgzXpeXATy5pg57i0pvSw99
 rX+xDSqIHD+jhhsu3Vz+xh3zaA==
X-Google-Smtp-Source: ABdhPJwwhuu1FWQ2TDptPM+d77tETyz2oG6clJW+lrN3hb3gSVMsFWXOBzL+Z/fSEjd/DB/U4OfVuA==
X-Received: by 2002:adf:b60b:: with SMTP id f11mr4319270wre.7.1591803022996;
 Wed, 10 Jun 2020 08:30:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id o20sm254918wra.29.2020.06.10.08.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 08:30:22 -0700 (PDT)
Date: Wed, 10 Jun 2020 17:30:20 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/6] drm/ttm: Add unampping of the entire device address
 space
Message-ID: <20200610153020.GZ20149@phenom.ffwll.local>
References: <f36c1fa1-bbee-477a-9cb2-ed2726f27eef@email.android.com>
 <eb9e5896-1f16-2102-350a-1e64d9af7ea8@shipmail.org>
 <b415e3d1-eed9-9b11-b8c1-c85c7b57eb93@amd.com>
 <ce6f6109-67df-e3d0-d56e-3f5c27df40a0@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ce6f6109-67df-e3d0-d56e-3f5c27df40a0@amd.com>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= <thomas_os@shipmail.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "michel@daenzer.net" <michel@daenzer.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 10, 2020 at 04:05:04PM +0200, Christian K=F6nig wrote:
> Am 10.06.20 um 15:54 schrieb Andrey Grodzovsky:
> > =

> > =

> > On 6/10/20 6:15 AM, Thomas Hellstr=F6m (Intel) wrote:
> > > =

> > > =

> > > On 6/9/20 7:21 PM, Koenig, Christian wrote:
> > > > =

> > > > =

> > > > Am 09.06.2020 18:37 schrieb "Grodzovsky, Andrey"
> > > > <Andrey.Grodzovsky@amd.com>:
> > > > =

> > > > =

> > > >     On 6/5/20 2:40 PM, Christian K=F6nig wrote:
> > > >     > Am 05.06.20 um 16:29 schrieb Andrey Grodzovsky:
> > > >     >>
> > > >     >> On 5/11/20 2:45 AM, Christian K=F6nig wrote:
> > > >     >>> Am 09.05.20 um 20:51 schrieb Andrey Grodzovsky:
> > > >     >>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.co=
m>
> > > >     >>>> ---
> > > >     >>>> drivers/gpu/drm/ttm/ttm_bo.c=A0=A0=A0 | 22 +++++++++++++++=
++++++-
> > > >     >>>> include/drm/ttm/ttm_bo_driver.h |=A0 2 ++
> > > >     >>>> =A0 2 files changed, 23 insertions(+), 1 deletion(-)
> > > >     >>>>
> > > >     >>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> > > >     >>>> b/drivers/gpu/drm/ttm/ttm_bo.c
> > > >     >>>> index c5b516f..eae61cc 100644
> > > >     >>>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > > >     >>>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > > >     >>>> @@ -1750,9 +1750,29 @@ void ttm_bo_unmap_virtual(struct
> > > >     >>>> ttm_buffer_object *bo)
> > > >     >>>> ttm_bo_unmap_virtual_locked(bo);
> > > >     >>>> ttm_mem_io_unlock(man);
> > > >     >>>> =A0 }
> > > >     >>>> +EXPORT_SYMBOL(ttm_bo_unmap_virtual);
> > > >     >>>> =A0 +void ttm_bo_unmap_virtual_address_space(struct
> > > >     ttm_bo_device *bdev)
> > > >     >>>> +{
> > > >     >>>> +=A0=A0=A0 struct ttm_mem_type_manager *man;
> > > >     >>>> +=A0=A0=A0 int i;
> > > >     >>>> -EXPORT_SYMBOL(ttm_bo_unmap_virtual);
> > > >     >>>
> > > >     >>>> +=A0=A0=A0 for (i =3D 0; i < TTM_NUM_MEM_TYPES; i++) {
> > > >     >>>> +=A0=A0=A0=A0=A0=A0=A0 man =3D &bdev->man[i];
> > > >     >>>> +=A0=A0=A0=A0=A0=A0=A0 if (man->has_type && man->use_type)
> > > >     >>>> + ttm_mem_io_lock(man, false);
> > > >     >>>> +=A0=A0=A0 }
> > > >     >>>
> > > >     >>> You should drop that it will just result in a deadlock
> > > >     warning for
> > > >     >>> Nouveau and has no effect at all.
> > > >     >>>
> > > >     >>> Apart from that looks good to me,
> > > >     >>> Christian.
> > > >     >>
> > > >     >>
> > > >     >> As I am considering to re-include this in V2 of the
> > > >     patchsets, can
> > > >     >> you clarify please why this will have no effect at all ?
> > > >     >
> > > >     > The locks are exclusive for Nouveau to allocate/free the io
> > > >     address
> > > >     > space.
> > > >     >
> > > >     > Since we don't do this here we don't need the locks.
> > > >     >
> > > >     > Christian.
> > > > =

> > > > =

> > > >     So basically calling unmap_mapping_range doesn't require any ex=
tra
> > > >     locking around it and whatever locks are taken within the funct=
ion
> > > >     should be enough ?
> > > > =

> > > > =

> > > > =

> > > > I think so, yes.
> > > > =

> > > > Christian.
> > > =

> > > Yes, that's true. However, without the bo reservation, nothing stops
> > > a PTE from being immediately re-faulted back again. Even while
> > > unmap_mapping_range() is running.
> > > =

> > =

> > Can you explain more on this - specifically, which function to reserve
> > the BO, why BO reservation would prevent re-fault of the PTE ?
> > =

> =

> Thomas is talking about ttm_bo_reserver()/ttm_bo_unreserve(), but we don't
> need this because we unmap everything because the whole device is gone and
> not just manipulate a single BO.
> =

> > =

> > > So the device removed flag needs to be advertized before this
> > > function is run,
> > > =

> > =

> > I indeed intend to call this=A0 right after calling drm_dev_unplug from
> > amdgpu_pci_remove while adding drm_dev_enter/exit in ttm_bo_vm_fault (or
> > in amdgpu specific wrapper since I don't see how can I access struct
> > drm_device from ttm_bo_vm_fault) and this in my understanding should
> > stop a PTE from being re-faulted back as you pointed out - so again I
> > don't see how=A0 bo reservation would prevent it so it looks like I am
> > missing something...
> > =

> > =

> > > (perhaps with a memory barrier pair).
> > > =

> > =

> > drm_dev_unplug and drm_dev_enter/exit are RCU synchronized and so I
> > don't think require any extra memory barriers for visibility of the
> > removed flag being set
> > =

> =

> As far as I can see that should be perfectly sufficient.

Only if you have a drm_dev_enter/exit pair in your fault handler.
Otherwise you're still open to the races Thomas described. But aside from
that the drm_dev_unplug stuff has all the barriers and stuff to make sure
nothing escapes.

Failure to drm_dev_enter could then also trigger the special case where we
put a dummy page in place.
-Daniel

> =

> Christian.
> =

> > =

> > Andrey
> > =

> > =

> > > That should probably be added to the function documentation.
> > > =

> > > (Other than that, please add a commit message if respinning).
> > > =

> > > /Thomas
> > > =

> > > =

> > > =

> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
