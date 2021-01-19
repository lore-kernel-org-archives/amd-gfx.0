Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE92C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 13:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30C12250E
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 13:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30C12250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F896E323;
	Tue, 19 Jan 2021 13:46:02 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA6CD6E873
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 13:46:00 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id l12so14554711wry.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=JyrINdWu385vCeLNTabbGV6DTSpc3kLdF4JH3sN63oc=;
 b=fIDcW/89r2EnvEjaRbb0MPQ7B0zDK1kV1+F7Lp74RnG/wu7BQW34m2WcMj2SvnqG3e
 63NszY5bwd1sazRgkKkY4cpEk0VWA5LVH/DH88iFq6lYjZBTROF15mOfotX5h499R3pc
 60r/KehAb/IUQYrQ6XKsouBrErNPW7UzrSd9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=JyrINdWu385vCeLNTabbGV6DTSpc3kLdF4JH3sN63oc=;
 b=FTKCtM7WzTOjXDXUGQ6tDlXvqIyUs4onvmkFxC3gIL5C93O3b8mXmYobBQw47spBqQ
 jegkzl5QKECiCEUR3ixhHbCvwrgYoom3AMnUoAAdRM+kozEwk9RJIoRBJycRWeJS62J9
 9bz7W8pJJWlG9pQPE6weZ1vj0T8iCHzKz86QIOYKa8Nx8ddIR7na1X7ELf3coCaqiuzM
 yfwodG8KptaZHxI5ud/R2/4qeJvE/MtGXvVql/W9Mqac/ek0X0Gm04L4vIkXVaZBfk44
 pTM0FdJcac3oRaAD4es43Pn3x7/YeQWdnozQU2ajHRcowdE+SQGyth2RZUV0RFDWY+uL
 2aHw==
X-Gm-Message-State: AOAM532iBXQLu6W3YH5qMgOT669tsy/4492NYE71U7goiOqopQyPd7ES
 HGL5LnfiaiBW5QfZHWDUW/JPBg==
X-Google-Smtp-Source: ABdhPJzzQ6kG6XYkl42YDriQ3C5MN62rwX/hYvy4+LoY9Xao/rwhivQtkejgDNdK8StuokVTSIClqQ==
X-Received: by 2002:adf:fd42:: with SMTP id h2mr4478091wrs.142.1611063959418; 
 Tue, 19 Jan 2021 05:45:59 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id o13sm41773150wrh.88.2021.01.19.05.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jan 2021 05:45:58 -0800 (PST)
Date: Tue, 19 Jan 2021 14:45:56 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: christian.koenig@amd.com
Subject: Re: [PATCH v4 07/14] drm/amdgpu: Register IOMMU topology notifier
 per device.
Message-ID: <YAbilAl8g0d9s7vz@phenom.ffwll.local>
References: <1611003683-3534-1-git-send-email-andrey.grodzovsky@amd.com>
 <1611003683-3534-8-git-send-email-andrey.grodzovsky@amd.com>
 <2978ebf8-858d-6e8e-5657-1d0d615d56e0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2978ebf8-858d-6e8e-5657-1d0d615d56e0@gmail.com>
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
Cc: robh@kernel.org, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org, eric@anholt.net,
 ppaalanen@gmail.com, amd-gfx@lists.freedesktop.org, gregkh@linuxfoundation.org,
 Alexander.Deucher@amd.com, yuq825@gmail.com, Harry.Wentland@amd.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 19, 2021 at 09:48:03AM +0100, Christian K=F6nig wrote:
> Am 18.01.21 um 22:01 schrieb Andrey Grodzovsky:
> > Handle all DMA IOMMU gropup related dependencies before the
> > group is removed.
> > =

> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  5 ++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 46 +++++++++++++++++++++=
+++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h   |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 ++
> >   6 files changed, 65 insertions(+), 1 deletion(-)
> > =

> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index 478a7d8..2953420 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -51,6 +51,7 @@
> >   #include <linux/dma-fence.h>
> >   #include <linux/pci.h>
> >   #include <linux/aer.h>
> > +#include <linux/notifier.h>
> >   #include <drm/ttm/ttm_bo_api.h>
> >   #include <drm/ttm/ttm_bo_driver.h>
> > @@ -1041,6 +1042,10 @@ struct amdgpu_device {
> >   	bool                            in_pci_err_recovery;
> >   	struct pci_saved_state          *pci_state;
> > +
> > +	struct notifier_block		nb;
> > +	struct blocking_notifier_head	notifier;
> > +	struct list_head		device_bo_list;
> >   };
> >   static inline struct amdgpu_device *drm_to_adev(struct drm_device *dd=
ev)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 45e23e3..e99f4f1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -70,6 +70,8 @@
> >   #include <drm/task_barrier.h>
> >   #include <linux/pm_runtime.h>
> > +#include <linux/iommu.h>
> > +
> >   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
> >   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
> >   MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
> > @@ -3200,6 +3202,39 @@ static const struct attribute *amdgpu_dev_attrib=
utes[] =3D {
> >   };
> > +static int amdgpu_iommu_group_notifier(struct notifier_block *nb,
> > +				     unsigned long action, void *data)
> > +{
> > +	struct amdgpu_device *adev =3D container_of(nb, struct amdgpu_device,=
 nb);
> > +	struct amdgpu_bo *bo =3D NULL;
> > +
> > +	/*
> > +	 * Following is a set of IOMMU group dependencies taken care of before
> > +	 * device's IOMMU group is removed
> > +	 */
> > +	if (action =3D=3D IOMMU_GROUP_NOTIFY_DEL_DEVICE) {
> > +
> > +		spin_lock(&ttm_bo_glob.lru_lock);
> > +		list_for_each_entry(bo, &adev->device_bo_list, bo) {
> > +			if (bo->tbo.ttm)
> > +				ttm_tt_unpopulate(bo->tbo.bdev, bo->tbo.ttm);
> > +		}
> > +		spin_unlock(&ttm_bo_glob.lru_lock);
> =

> That approach won't work. ttm_tt_unpopulate() might sleep on an IOMMU loc=
k.
> =

> You need to use a mutex here or even better make sure you can access the
> device_bo_list without a lock in this moment.

I'd also be worried about the notifier mutex getting really badly in the
way.

Plus I'm worried why we even need this, it sounds a bit like papering over
the iommu subsystem. Assuming we clean up all our iommu mappings in our
device hotunplug/unload code, why do we still need to have an additional
iommu notifier on top, with all kinds of additional headaches? The iommu
shouldn't clean up before the devices in its group have cleaned up.

I think we need more info here on what the exact problem is first.
-Daniel

> =

> Christian.
> =

> > +
> > +		if (adev->irq.ih.use_bus_addr)
> > +			amdgpu_ih_ring_fini(adev, &adev->irq.ih);
> > +		if (adev->irq.ih1.use_bus_addr)
> > +			amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> > +		if (adev->irq.ih2.use_bus_addr)
> > +			amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
> > +
> > +		amdgpu_gart_dummy_page_fini(adev);
> > +	}
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> > +
> >   /**
> >    * amdgpu_device_init - initialize the driver
> >    *
> > @@ -3304,6 +3339,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
> >   	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
> > +	INIT_LIST_HEAD(&adev->device_bo_list);
> > +
> >   	adev->gfx.gfx_off_req_count =3D 1;
> >   	adev->pm.ac_power =3D power_supply_is_system_supplied() > 0;
> > @@ -3575,6 +3612,15 @@ int amdgpu_device_init(struct amdgpu_device *ade=
v,
> >   	if (amdgpu_device_cache_pci_state(adev->pdev))
> >   		pci_restore_state(pdev);
> > +	BLOCKING_INIT_NOTIFIER_HEAD(&adev->notifier);
> > +	adev->nb.notifier_call =3D amdgpu_iommu_group_notifier;
> > +
> > +	if (adev->dev->iommu_group) {
> > +		r =3D iommu_group_register_notifier(adev->dev->iommu_group, &adev->n=
b);
> > +		if (r)
> > +			goto failed;
> > +	}
> > +
> >   	return 0;
> >   failed:
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gart.c
> > index 0db9330..486ad6d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> > @@ -92,7 +92,7 @@ static int amdgpu_gart_dummy_page_init(struct amdgpu_=
device *adev)
> >    *
> >    * Frees the dummy page used by the driver (all asics).
> >    */
> > -static void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
> > +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
> >   {
> >   	if (!adev->dummy_page_addr)
> >   		return;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gart.h
> > index afa2e28..5678d9c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> > @@ -61,6 +61,7 @@ int amdgpu_gart_table_vram_pin(struct amdgpu_device *=
adev);
> >   void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev);
> >   int amdgpu_gart_init(struct amdgpu_device *adev);
> >   void amdgpu_gart_fini(struct amdgpu_device *adev);
> > +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev);
> >   int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
> >   		       int pages);
> >   int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> > index 6cc9919..4a1de69 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -94,6 +94,10 @@ static void amdgpu_bo_destroy(struct ttm_buffer_obje=
ct *tbo)
> >   	}
> >   	amdgpu_bo_unref(&bo->parent);
> > +	spin_lock(&ttm_bo_glob.lru_lock);
> > +	list_del(&bo->bo);
> > +	spin_unlock(&ttm_bo_glob.lru_lock);
> > +
> >   	kfree(bo->metadata);
> >   	kfree(bo);
> >   }
> > @@ -613,6 +617,12 @@ static int amdgpu_bo_do_create(struct amdgpu_devic=
e *adev,
> >   	if (bp->type =3D=3D ttm_bo_type_device)
> >   		bo->flags &=3D ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> > +	INIT_LIST_HEAD(&bo->bo);
> > +
> > +	spin_lock(&ttm_bo_glob.lru_lock);
> > +	list_add_tail(&bo->bo, &adev->device_bo_list);
> > +	spin_unlock(&ttm_bo_glob.lru_lock);
> > +
> >   	return 0;
> >   fail_unreserve:
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.h
> > index 9ac3756..5ae8555 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > @@ -110,6 +110,8 @@ struct amdgpu_bo {
> >   	struct list_head		shadow_list;
> >   	struct kgd_mem                  *kfd_bo;
> > +
> > +	struct list_head		bo;
> >   };
> >   static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_ob=
ject *tbo)
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
