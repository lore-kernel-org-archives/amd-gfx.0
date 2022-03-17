Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4655C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 15:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E17A10E415;
	Thu, 17 Mar 2022 15:17:02 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73CFD10E16C
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 15:00:30 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id r10so7770179wrp.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=mpFvwfJ8r7mWj+dQzeS1Ko5nqxYOE3cL38S10CPksII=;
 b=XJCgx6LcQEMvn4y144eWzm616B31j3LhXv3YVPLDtncBdhFDMGHb6IdRciS01qoO8w
 EzRFbR36x4RiHc1iN1gaU6mzYBxAMmzGk9fBCccQRNyIj4esIOnFiHY5ZtZoELO9h4Bp
 rlc61XZKAIdVRBuj9/l8UpjyvziqhICCMc+je8XH2pAtl5tyd+/U6j2XPM0H8kQ2kWx0
 /upgNjAT/SCxhngehW+VAQB8skH550WyrN83Xsb6WirejteaiSrl4f1F41IdrjpT1eS8
 DxBahdWDdMMrkqKlnmAOkcQOD9cJA3skIrIDIje8Fvm/JGW0QSg1iya2liLpVCVLCZiQ
 oy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mpFvwfJ8r7mWj+dQzeS1Ko5nqxYOE3cL38S10CPksII=;
 b=sbyaDcI1vpZPFdrv4t0Obuq9igEl1aEN9MShptKm7Gxpdd+kCAGOukueE+YnKJ8WLG
 IMU97rXogNWkimAQL/bCL+ClMv9CAGzwUAoQ0EapneiAfmeCXxPi+z4yqh4kccQyEzqg
 Bl+R28id0WTLpFpRUUhtNaJ1C4SoLurYDNPKmOfWajReqAfLrUvwgUUR8ZImd4ksJQa/
 5+3jp8S8pWVU+5QiirvuATFbSCzK5E8nF4gRK/PZ/0Wov7MFhtnPmMTMDcKnJdZA2FNd
 L0e4uFnjBApATJmzcWJNxyKScnYohu3XOPfiHoT0bA4ciHObnlDARjZbNvbG8ul6lY4P
 cKcw==
X-Gm-Message-State: AOAM5300u1bJmu+IH6ixSY2W5USNTeYHWX/uFXU8e9bc8M3Z9ONsyQeB
 h/EsR/D7e3QKlxm1T6qKAY+hwQ==
X-Google-Smtp-Source: ABdhPJyTIEEopTwTo5wDmIQ/veXAigP05FDsUwMF53Y2w3XzFFiSf+9RPuGMNoeXf4um9LC9CA71Lw==
X-Received: by 2002:a5d:6785:0:b0:203:723c:6b08 with SMTP id
 v5-20020a5d6785000000b00203723c6b08mr4181698wru.643.1647529228708; 
 Thu, 17 Mar 2022 08:00:28 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 7-20020a05600c228700b00389865c646dsm5888347wmf.14.2022.03.17.08.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Mar 2022 08:00:27 -0700 (PDT)
Date: Thu, 17 Mar 2022 15:00:25 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH 1/1] drm/amdkfd: Protect the Client whilst it is being
 operated on
Message-ID: <YjNNCXc8harOvwqe@google.com>
References: <20220317131610.554347-1-lee.jones@linaro.org>
 <8702f8a5-62a1-c07e-c7b7-e9378be069b6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8702f8a5-62a1-c07e-c7b7-e9378be069b6@amd.com>
X-Mailman-Approved-At: Thu, 17 Mar 2022 15:17:01 +0000
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Good afternoon Felix,

Thanks for your review.

> Am 2022-03-17 um 09:16 schrieb Lee Jones:
> > Presently the Client can be freed whilst still in use.
> > 
> > Use the already provided lock to prevent this.
> > 
> > Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> > index e4beebb1c80a2..3b9ac1e87231f 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> > @@ -145,8 +145,11 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
> >   	spin_unlock(&dev->smi_lock);
> >   	synchronize_rcu();
> > +
> > +	spin_lock(&client->lock);
> >   	kfifo_free(&client->fifo);
> >   	kfree(client);
> > +	spin_unlock(&client->lock);
> 
> The spin_unlock is after the spinlock data structure has been freed.

Good point.

If we go forward with this approach the unlock should perhaps be moved
to just before the kfree().

> There
> should be no concurrent users here, since we are freeing the data structure.
> If there still are concurrent users at this point, they will crash anyway.
> So the locking is unnecessary.

The users may well crash, as does the kernel unfortunately.

> >   	return 0;
> >   }
> > @@ -247,11 +250,13 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
> >   		return ret;
> >   	}
> > +	spin_lock(&client->lock);
> 
> The client was just allocated, and it wasn't added to the client list or
> given to user mode yet. So there can be no concurrent users at this point.
> The locking is unnecessary.
> 
> There could be potential issues if someone uses the file descriptor by dumb
> luck before this function returns. So maybe we need to move the
> anon_inode_getfd to the end of the function (just before list_add_rcu) so
> that we only create the file descriptor after the client structure is fully
> initialized.

Bingo.  Well done. :)

I can move the function as suggested if that is the best route forward?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
