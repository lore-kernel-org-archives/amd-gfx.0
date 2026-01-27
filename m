Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA99D2F006
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 10:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DB5C10E647;
	Wed, 28 Jan 2026 10:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="VMPzDF1g";
	dkim-atps=neutral
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17CF10E59A
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 16:27:56 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-4ffbea7fdf1so56776791cf.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 08:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769531276; x=1770136076; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Kat2TyZxDqTgTm8MMhUVYtoZ/z4BzE2I09fTuJqEpw=;
 b=VMPzDF1g+18vTQxJfApUh5g94pfqZwrxdEaAD/et1Sk32QC0o6935Uxyf0IDoWeE6f
 0hRtxEqKESJU5zrYQB1Njgws/VlCm/gVIOejIWlaaUyomF++38UingHbxde0ktRbqA2N
 F+sOCl1gZMBMLEi5J7vnyG6LpxEuPYhanJZks4a7ekOHnwEP1dDfFaWJwE3UEKDU5/Kg
 /FirG1r0q15Hh2iLkdR0QlAm9fXckuPdXkeKZX4Evzq73l514DN73NT1SdFtrwvwJJLp
 4+bs83Es5/tRQCzFxNxlvqxrCDno2J4Pdbs9bKANyvd3hM159/FlmkwmeSHTcmFDiu/X
 2CRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531276; x=1770136076;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Kat2TyZxDqTgTm8MMhUVYtoZ/z4BzE2I09fTuJqEpw=;
 b=YY7Kti9rhRIO6lW1QFlXheqFO45uuJjbJN7tVlBkKHQsrVI1MhKfHL+c/Oh8wcTk6N
 A1211TgNkOMhKqLIDhEvW52+Wh295rSy+3NyWFVJGHBuDMgvBbz7aQMEyoyGw0TZcFDR
 29vAAbVUBGS2OCqp510w57vXmqaKbcQVgNoJsViyWLCfVpQ/GN1Wl/g3l9MWoJm0tM9t
 9AaNwqfIJnDhjvkufeS5LW2bDvA6FFUVHdYgN/DPfxfGZr+0WtJEY5i9tGBP9Xw6gax2
 LWl0a7pMUMU366XmRpI1C8ui5B47dujTe5A28K3LKWE7abm3TzHwyS8jEUT7fICPPsoQ
 9vfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGJPEqn1EU7XTw7GJmscT/EM0eNR6CfDlyxUFa9QKF7WCKAojn2K7E5+cTqXt5z+L5rIYE3NsT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLn3pQsLcrCHtAJKQL3enLQqXDPOCAlZ7sJFIlZbPMfK6D6vBw
 gIDGRwO/0r3DxK5BTy8htHeVb1nPUqxhp7lm615w7bKM91Qczhz9GDYKM05byA3JF40=
X-Gm-Gg: AZuq6aJrHzx1XLQPEck7+DCcxW+nVJr5x3SMFfCHMIHxi3neSNvK31kuHMffv9T/rFK
 qAlVubE/wx1l67bVIgvVR+U8g9G8ssutey8gmRveqjcCiSYfGl8GbL7spL/xHPnXqNL0WYxpmyH
 hy3+Ea+jsJgDPn99qWutW7cz6zchvXGCF++dvBvGImI6rVgJ5vWtFS3+XG0DG4s8Usyt9gq6Bpd
 3G4jyqtm4vDXo2dX08ivgfu8NAizFa5AK5ckZdY8+Kl1XAimasEid/JmYz5Ap2+kSo8k/SSFKci
 Gk/kK840Vs0XLulx0En5lMoAdTmKEVMe5NlqIcQyrC5Z/KYOJrbkkpJrrfpR+T/LKIQJcHmNBCe
 vMCA3vgvgkARel3wF2TsZ7XdtbBCF+ywnLliMQGK0R+yoFeuoGWU856og+9oAuNyryH1/Qgioe2
 Wn6riC/DsuUgUayPNz+H65choYYOIwkAwCeHrZYpLwdJoT2qMXZ3CPKlS2GeDqyJc1D9Jb+0Xr4
 xgxKg==
X-Received: by 2002:a05:622a:612:b0:4f1:ba00:4cc6 with SMTP id
 d75a77b69052e-5032fc167d4mr25702421cf.79.1769531275530; 
 Tue, 27 Jan 2026 08:27:55 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502fb8e74ebsm102277581cf.0.2026.01.27.08.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:27:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vklv0-000000095Ys-1TUe;
 Tue, 27 Jan 2026 12:27:54 -0400
Date: Tue, 27 Jan 2026 12:27:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v5 4/8] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260127162754.GH1641016@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <aXfUZcSEr9N18o6w@google.com> <20260127085835.GQ13967@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127085835.GQ13967@unreal>
X-Mailman-Approved-At: Wed, 28 Jan 2026 10:55:00 +0000
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

On Tue, Jan 27, 2026 at 10:58:35AM +0200, Leon Romanovsky wrote:
> > > @@ -333,7 +359,37 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
> > >  			dma_resv_lock(priv->dmabuf->resv, NULL);
> > >  			priv->revoked = revoked;
> > >  			dma_buf_invalidate_mappings(priv->dmabuf);
> > > +			dma_resv_wait_timeout(priv->dmabuf->resv,
> > > +					      DMA_RESV_USAGE_BOOKKEEP, false,
> > > +					      MAX_SCHEDULE_TIMEOUT);
> > >  			dma_resv_unlock(priv->dmabuf->resv);
> > > +			if (revoked) {
> > > +				kref_put(&priv->kref, vfio_pci_dma_buf_done);
> > > +				/* Let's wait till all DMA unmap are completed. */
> > > +				wait = wait_for_completion_timeout(
> > > +					&priv->comp, secs_to_jiffies(1));
> > 
> > Is the 1-second constant sufficient for all hardware, or should the 
> > invalidate_mappings() contract require the callback to block until 
> > speculative reads are strictly fenced? I'm wondering about a case where
> > a device's firmware has a high response latency, perhaps due to internal
> > management tasks like error recovery or thermal and it exceeds the 1s 
> > timeout. 
> > 
> > If the device is in the middle of a large DMA burst and the firmware is
> > slow to flush the internal pipelines to a fully "quiesced"
> > read-and-discard state, reclaiming the memory at exactly 1.001 seconds
> > risks triggering platform-level faults..
> > 
> > Since the wen explicitly permit these speculative reads until unmap is
> > complete, relying on a hardcoded timeout in the exporter seems to 
> > introduce a hardware-dependent race condition that could compromise
> > system stability via IOMMU errors or AER faults. 
> > 
> > Should the importer instead be required to guarantee that all 
> > speculative access has ceased before the invalidation call returns?
> 
> It is guaranteed by the dma_resv_wait_timeout() call above. That call ensures
> that the hardware has completed all pending operations. The 1‑second delay is
> meant to catch cases where an in-kernel DMA unmap call is missing, which should
> not trigger any DMA activity at that point.

Christian may know actual examples, but my general feeling is he was
worrying about drivers that have pushed the DMABUF to visibility on
the GPU and the move notify & fences only shoot down some access. So
it has to wait until the DMABUF is finally unmapped.

Pranjal's example should be covered by the driver adding a fence and
then the unbounded fence wait will complete it.

I think the open question here is if drivers that can't rely on their
fences should return dma_buf_attach_revocable() = false ? It depends
on how long they will leave the buffers mapped, and if it is "bounded
time".

The converse is we want to detect bugs where drivers have wrongly set
dma_buf_attach_revocable() = true and this turns into an infinite
sleep, so the logging is necessary, IMHO.

At worst the code should sleep 1s, print, then keep sleeping..

Jason
