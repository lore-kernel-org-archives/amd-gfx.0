Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40F5C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 14:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5768764DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 14:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5768764DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 060D96E554;
	Tue,  2 Feb 2021 14:22:03 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D9B6E554
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 14:22:02 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id c127so2454340wmf.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Feb 2021 06:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=lQhN7hbH+8BGF8jUKVNjatS6EZScKt9upO29fXBnSEU=;
 b=R5zwuOnd+S/gV9F15G9iUjKE6hF5VpsFIaoOK3/thtzP767B9s4k8tW69HYbhi77Bv
 GFp+ZY7393w5bH9zkcxHVgGh5FQ2xqpkAk8ROKU2NB3Xu1o8x7ZOe/nhcCv0mJnWNxXj
 zysULOGHsa34FvOFNLa7FfQicKsJH7p/lseH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=lQhN7hbH+8BGF8jUKVNjatS6EZScKt9upO29fXBnSEU=;
 b=L8u6kn5CfHPwiSQaDtWDVW4L7Amh/dLYC0kbzYswCyVyW9RTBEa/lO2XmQYssEdEv5
 sIxTPRu5TN6YffAkTOdKsVAeTUcIrNbtuH5kvdBEaDPbpmNVwVp9In0oZZdy+n7ZOvYp
 iLGsL5Qv9Js0Q/K7oOwaizc+ZwvycCA1VylC3xXOhpvZJStfa2E7ck5+THCJ69V1aq+O
 1zBWprrPLZ3bHE2d7E7z1Uimgi2zAr8or9Gz+tCZV2CpAqRXUPGn9c2sU5RZq1vW3W1B
 3nnI0tCj62iGV3ulIwVaguYIpRJxKSy/dPZ+hOWRLveHgoh7H++zXs2SeNXItkNHyUjb
 wkMg==
X-Gm-Message-State: AOAM5324KoF+0bHvF0seJBmmfm5P1e4OXyEj15vNWW+0h0o6DA0POonu
 vzHvD3qvYrhASSX74TFXm1WR5g==
X-Google-Smtp-Source: ABdhPJwumluomqMUgq1SQbY8cY8mcwN57FBF+KLA/uLzRRxCjRUAWj9zqld8wquLvygJSDgontXBXw==
X-Received: by 2002:a05:600c:2204:: with SMTP id
 z4mr3839236wml.138.1612275720955; 
 Tue, 02 Feb 2021 06:22:00 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id j7sm8124915wrp.72.2021.02.02.06.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 06:21:59 -0800 (PST)
Date: Tue, 2 Feb 2021 15:21:58 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH v4 01/14] drm/ttm: Remap all page faults to per process
 dummy page.
Message-ID: <YBlgBh/icLuvjGQL@phenom.ffwll.local>
References: <1611003683-3534-1-git-send-email-andrey.grodzovsky@amd.com>
 <1611003683-3534-2-git-send-email-andrey.grodzovsky@amd.com>
 <YAblHNmVZVlTI6ny@phenom.ffwll.local>
 <e6597fdd-5800-d6c4-95e8-7e736948e110@amd.com>
 <8da0eabf-1c9e-d9a0-0987-c15c1ddfdf54@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8da0eabf-1c9e-d9a0-0987-c15c1ddfdf54@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: robh@kernel.org, gregkh@linuxfoundation.org,
 ckoenig.leichtzumerken@gmail.com, dri-devel@lists.freedesktop.org,
 eric@anholt.net, ppaalanen@gmail.com, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, daniel.vetter@ffwll.ch,
 Alexander.Deucher@amd.com, yuq825@gmail.com, Harry.Wentland@amd.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 27, 2021 at 09:29:41AM -0500, Andrey Grodzovsky wrote:
> Hey Daniel, just a ping.

Was on vacations last week.

> Andrey
> =

> On 1/25/21 10:28 AM, Andrey Grodzovsky wrote:
> > =

> > On 1/19/21 8:56 AM, Daniel Vetter wrote:
> > > On Mon, Jan 18, 2021 at 04:01:10PM -0500, Andrey Grodzovsky wrote:
> > > > On device removal reroute all CPU mappings to dummy page.
> > > > =

> > > > v3:
> > > > Remove loop to find DRM file and instead access it
> > > > by vma->vm_file->private_data. Move dummy page installation
> > > > into a separate function.
> > > > =

> > > > v4:
> > > > Map the entire BOs VA space into on demand allocated dummy page
> > > > on the first fault for that BO.
> > > > =

> > > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> > > > ---
> > > > =A0 drivers/gpu/drm/ttm/ttm_bo_vm.c | 82
> > > > ++++++++++++++++++++++++++++++++++++++++-
> > > > =A0 include/drm/ttm/ttm_bo_api.h=A0=A0=A0 |=A0 2 +
> > > > =A0 2 files changed, 83 insertions(+), 1 deletion(-)
> > > > =

> > > > diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/=
ttm_bo_vm.c
> > > > index 6dc96cf..ed89da3 100644
> > > > --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> > > > +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> > > > @@ -34,6 +34,8 @@
> > > > =A0 #include <drm/ttm/ttm_bo_driver.h>
> > > > =A0 #include <drm/ttm/ttm_placement.h>
> > > > =A0 #include <drm/drm_vma_manager.h>
> > > > +#include <drm/drm_drv.h>
> > > > +#include <drm/drm_managed.h>
> > > > =A0 #include <linux/mm.h>
> > > > =A0 #include <linux/pfn_t.h>
> > > > =A0 #include <linux/rbtree.h>
> > > > @@ -380,25 +382,103 @@ vm_fault_t
> > > > ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
> > > > =A0 }
> > > > =A0 EXPORT_SYMBOL(ttm_bo_vm_fault_reserved);
> > > > =A0 +static void ttm_bo_release_dummy_page(struct drm_device *dev, =
void *res)
> > > > +{
> > > > +=A0=A0=A0 struct page *dummy_page =3D (struct page *)res;
> > > > +
> > > > +=A0=A0=A0 __free_page(dummy_page);
> > > > +}
> > > > +
> > > > +vm_fault_t ttm_bo_vm_dummy_page(struct vm_fault *vmf, pgprot_t pro=
t)
> > > > +{
> > > > +=A0=A0=A0 struct vm_area_struct *vma =3D vmf->vma;
> > > > +=A0=A0=A0 struct ttm_buffer_object *bo =3D vma->vm_private_data;
> > > > +=A0=A0=A0 struct ttm_bo_device *bdev =3D bo->bdev;
> > > > +=A0=A0=A0 struct drm_device *ddev =3D bo->base.dev;
> > > > +=A0=A0=A0 vm_fault_t ret =3D VM_FAULT_NOPAGE;
> > > > +=A0=A0=A0 unsigned long address =3D vma->vm_start;
> > > > +=A0=A0=A0 unsigned long num_prefault =3D (vma->vm_end - vma->vm_st=
art) >> PAGE_SHIFT;
> > > > +=A0=A0=A0 unsigned long pfn;
> > > > +=A0=A0=A0 struct page *page;
> > > > +=A0=A0=A0 int i;
> > > > +
> > > > +=A0=A0=A0 /*
> > > > +=A0=A0=A0=A0 * Wait for buffer data in transit, due to a pipelined
> > > > +=A0=A0=A0=A0 * move.
> > > > +=A0=A0=A0=A0 */
> > > > +=A0=A0=A0 ret =3D ttm_bo_vm_fault_idle(bo, vmf);
> > > > +=A0=A0=A0 if (unlikely(ret !=3D 0))
> > > > +=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > +
> > > > +=A0=A0=A0 /* Allocate new dummy page to map all the VA range in th=
is VMA to it*/
> > > > +=A0=A0=A0 page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> > > > +=A0=A0=A0 if (!page)
> > > > +=A0=A0=A0=A0=A0=A0=A0 return VM_FAULT_OOM;
> > > > +
> > > > +=A0=A0=A0 pfn =3D page_to_pfn(page);
> > > > +
> > > > +=A0=A0=A0 /*
> > > > +=A0=A0=A0=A0 * Prefault the entire VMA range right away to avoid f=
urther faults
> > > > +=A0=A0=A0=A0 */
> > > > +=A0=A0=A0 for (i =3D 0; i < num_prefault; ++i) {
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (unlikely(address >=3D vma->vm_end))
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (vma->vm_flags & VM_MIXEDMAP)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D vmf_insert_mixed_prot(vm=
a, address,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 __pfn_to_pfn_t(pfn, PFN_DEV),
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 prot);
> > > > +=A0=A0=A0=A0=A0=A0=A0 else
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D vmf_insert_pfn_prot(vma,=
 address, pfn, prot);
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0 /* Never error on prefaulted PTEs */
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (unlikely((ret & VM_FAULT_ERROR))) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i =3D=3D 0)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return VM_FAULT_NOPA=
GE;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0 address +=3D PAGE_SIZE;
> > > > +=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0 /* Set the page to be freed using drmm release action */
> > > > +=A0=A0=A0 if (drmm_add_action_or_reset(ddev, ttm_bo_release_dummy_=
page, page))
> > > > +=A0=A0=A0=A0=A0=A0=A0 return VM_FAULT_OOM;
> > > > +
> > > > +=A0=A0=A0 return ret;
> > > > +}
> > > > +EXPORT_SYMBOL(ttm_bo_vm_dummy_page);
> > > I think we can lift this entire thing (once the ttm_bo_vm_fault_idle =
is
> > > gone) to the drm level, since nothing ttm specific in here. Probably =
stuff
> > > it into drm_gem.c (but really it's not even gem specific, it's fully
> > > generic "replace this vma with dummy pages pls" function.
> > =

> > =

> > Once I started with this I noticed that drmm_add_action_or_reset depends
> > on struct drm_device *ddev =3D bo->base.dev=A0 and bo is the private da=
ta
> > we embed at the TTM level when setting up the mapping and so this forces
> > to move drmm_add_action_or_reset out of this function to every client w=
ho uses
> > this function, and then you separate the logic of page allocation from
> > it's release.
> > So I suggest we keep it as is.

Uh disappointing. Thing is, ttm essentially means drm devices with gem, exc=
ept for
vmwgfx, which is a drm_device without gem. And I think one of the
remaining ttm refactors in this area is to move ttm_device over into
drm_device someone, and then we'd have bo->base.dev always set to
something that drmm_add_action_or_reset can use.

I guess hand-rolling for now and jotting this down as a TODO item is fine
too, but would be good to get this addressed since that's another reason
here to do this. Maybe sync with Christian how to best do this.
-Daniel

> > =

> > Andrey
> > =

> > =

> > > =

> > > Aside from this nit I think the overall approach you have here is sta=
rting
> > > to look good. Lots of work&polish, but imo we're getting there and can
> > > start landing stuff soon.
> > > -Daniel
> > > =

> > > > +
> > > > =A0 vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
> > > > =A0 {
> > > > =A0=A0=A0=A0=A0 struct vm_area_struct *vma =3D vmf->vma;
> > > > =A0=A0=A0=A0=A0 pgprot_t prot;
> > > > =A0=A0=A0=A0=A0 struct ttm_buffer_object *bo =3D vma->vm_private_da=
ta;
> > > > +=A0=A0=A0 struct drm_device *ddev =3D bo->base.dev;
> > > > =A0=A0=A0=A0=A0 vm_fault_t ret;
> > > > +=A0=A0=A0 int idx;
> > > > =A0 =A0=A0=A0=A0=A0 ret =3D ttm_bo_vm_reserve(bo, vmf);
> > > > =A0=A0=A0=A0=A0 if (ret)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > =A0 =A0=A0=A0=A0=A0 prot =3D vma->vm_page_prot;
> > > > -=A0=A0=A0 ret =3D ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NU=
M_PREFAULT, 1);
> > > > +=A0=A0=A0 if (drm_dev_enter(ddev, &idx)) {
> > > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D ttm_bo_vm_fault_reserved(vmf, prot, =
TTM_BO_VM_NUM_PREFAULT, 1);
> > > > +=A0=A0=A0=A0=A0=A0=A0 drm_dev_exit(idx);
> > > > +=A0=A0=A0 } else {
> > > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D ttm_bo_vm_dummy_page(vmf, prot);
> > > > +=A0=A0=A0 }
> > > > =A0=A0=A0=A0=A0 if (ret =3D=3D VM_FAULT_RETRY && !(vmf->flags & FAU=
LT_FLAG_RETRY_NOWAIT))
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > > =A0 =A0=A0=A0=A0=A0 dma_resv_unlock(bo->base.resv);
> > > > =A0 =A0=A0=A0=A0=A0 return ret;
> > > > +
> > > > +=A0=A0=A0 return ret;
> > > > =A0 }
> > > > =A0 EXPORT_SYMBOL(ttm_bo_vm_fault);
> > > > =A0 diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm=
_bo_api.h
> > > > index e17be32..12fb240 100644
> > > > --- a/include/drm/ttm/ttm_bo_api.h
> > > > +++ b/include/drm/ttm/ttm_bo_api.h
> > > > @@ -643,4 +643,6 @@ void ttm_bo_vm_close(struct vm_area_struct *vma=
);
> > > > =A0 int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned long =
addr,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 void *buf, int len, int =
write);
> > > > =A0 +vm_fault_t ttm_bo_vm_dummy_page(struct vm_fault *vmf, pgprot_t=
 prot);
> > > > +
> > > > =A0 #endif
> > > > -- =

> > > > 2.7.4
> > > > =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
