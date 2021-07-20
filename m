Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE75C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 13:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21C761186
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 13:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21C761186
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8583E89DB2;
	Tue, 20 Jul 2021 13:50:57 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE06F89DB5
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 13:50:56 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id c12so8075518wrt.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=sI4lOFqRzupKkYq98Gmd5BUFkdbcZOoG/UvAcZHjLDY=;
 b=QBbwhpFEg138cFF13OlHokR7JOS4muXESJoP0GE8o7KEv35eNms/xuto9Ggx61MJnV
 pv5yMUhlTXtwC0gs7+LZigEVtzx6FeEYFBjFZISkgcMiS1iksMJxxE9AQ75qX/XxMULb
 sMeC2UURwOTw9xD6wYT2FjKji3DINZHhYE1LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=sI4lOFqRzupKkYq98Gmd5BUFkdbcZOoG/UvAcZHjLDY=;
 b=Z//XeJ41wAB1NYtRJruXlH0F1IgZfiOi0mzUbfRG2GDc+tSjVVRip7kCSlYH345fiR
 8jvZ03cySxfwZj6i76o1hnoCWq6MSf3KhlZKydzKV6zaeO7iPwsvqKYRznH+ND2a2wTt
 GDqP47S0FjEq15l06Ypox9/iK63VU5MR6fY2KGvxFUVja9it6ehkwT3m0Enkgq6kDjMc
 jgpgyIp34/039ENtc2EVoUPFtKzCi5K48q6hN75Ba/SY/vtoZSYZTbixOmzmyYXJ5i4r
 UP1QrqtQCeEg+aDoohzyBHk3UyWePJHhcaUjCFox/j6RqNJdm7loVuICFJgwT0sRei01
 Kkhw==
X-Gm-Message-State: AOAM532XpCiKlQ4JycWxuji3DJY2WENu3BZ1aMw0gnubIGOrgCdm82sa
 UlKyEU9FfnweXQNW9eRft32YIdkGCQkdZw==
X-Google-Smtp-Source: ABdhPJxQV3Ee2pwcwbIe/vS8ucyfghhnzHjKP4KrgLfr14bAgT3gr9xSuwjFXjaR+rGwh3KUvvzTOA==
X-Received: by 2002:adf:c803:: with SMTP id d3mr30463317wrh.345.1626789055598; 
 Tue, 20 Jul 2021 06:50:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id f2sm23731613wrq.69.2021.07.20.06.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jul 2021 06:50:54 -0700 (PDT)
Date: Tue, 20 Jul 2021 15:50:52 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/7] vgaarb: remove VGA_DEFAULT_DEVICE
Message-ID: <YPbUvIYmu3WfyM2C@phenom.ffwll.local>
References: <20210716061634.2446357-1-hch@lst.de>
 <20210716061634.2446357-2-hch@lst.de>
 <f171831b-3281-5a5a-04d3-2d69cb77f1a2@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f171831b-3281-5a5a-04d3-2d69cb77f1a2@amd.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
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
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
 Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 16, 2021 at 09:14:02AM +0200, Christian K=F6nig wrote:
> Am 16.07.21 um 08:16 schrieb Christoph Hellwig:
> > The define is entirely unused.
> > =

> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> =

> I'm not an expert for this particular code, but at least of hand everythi=
ng
> you do here makes totally sense.
> =

> Whole series is Acked-by: Christian K=F6nig <christian.koenig@amd.com>

Care to also push this into drm-misc-next since you looked already?
-Daniel

> =

> Regards,
> Christian.
> =

> > ---
> >   include/linux/vgaarb.h | 6 ------
> >   1 file changed, 6 deletions(-)
> > =

> > diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
> > index dc6ddce92066..26ec8a057d2a 100644
> > --- a/include/linux/vgaarb.h
> > +++ b/include/linux/vgaarb.h
> > @@ -42,12 +42,6 @@
> >   #define VGA_RSRC_NORMAL_IO     0x04
> >   #define VGA_RSRC_NORMAL_MEM    0x08
> > -/* Passing that instead of a pci_dev to use the system "default"
> > - * device, that is the one used by vgacon. Archs will probably
> > - * have to provide their own vga_default_device();
> > - */
> > -#define VGA_DEFAULT_DEVICE     (NULL)
> > -
> >   struct pci_dev;
> >   /* For use by clients */
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
