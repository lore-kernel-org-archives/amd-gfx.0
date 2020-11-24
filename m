Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678CAC63798
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 14:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1BEA206F9
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 14:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TMn8yQVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BEA206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7F36E296;
	Tue, 24 Nov 2020 14:44:48 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3396E296
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 14:44:47 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id m6so22562452wrg.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 06:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=ccAqOnBT61BH7TQSKWjf0ryD/AnQCwVg4p2m7YS/Org=;
 b=TMn8yQVG/ifR+n5GmEm++6pj6JcDuN2KHcZKznVXWo6/eetWrNMoRab3Z24++YMU3A
 Zl+0UGf3ILcbpyaA2Q4+UbxLubDTrtCQqUmLsDNgwoGO2n0UDHzou5+ut10Lj9HU5wCO
 mvJp54w9/eA2gGp4OAvmT9/FR3J8lDu6nTUO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ccAqOnBT61BH7TQSKWjf0ryD/AnQCwVg4p2m7YS/Org=;
 b=azfO2zmRM4vbZ+Rgr+A4gwzTXWR2RfeDYYN1C2tfTqHB6GfwouRj0TPSuLcj8qXoOg
 37bjtIO/dsrsGW+evODfCe5uEqIxlajeSgu4t2CWi3Fp7tOTX7pIbfvVGg0kHPOyqieq
 XdBQ96f070+V5CvFJhqUJ4qBAcqhqeztl/K3pOlAGOBWvDl9julvUC7w9A7U5HpKWX5T
 UNCf4gTrFnb1mPQU07513b6pN7PXtHI1WGkgoqfq7b6JYZz50jXbFQNR7ySV3rFCWljH
 P7I+QMZdtLJqp4A7sNMH7fgKgN+iORGtaCZm8V6Z1OaBIUfWjnaOgqAsWS5TzUXDBj3d
 /f3g==
X-Gm-Message-State: AOAM533NV1Z3ZWElimQLPxxXbkkAbk0oZP6yBQjPDZe/sIPNGzVb5ths
 Hnyo1Z+Apn7ESKQl+rG85rKMbw==
X-Google-Smtp-Source: ABdhPJwS/7z0ByJO7gxsW/q/yiy0y5ztFkHsZBrRFFxvjOyxLoef6nkQeu2B0paNRkY+adQw+0hgHA==
X-Received: by 2002:a5d:4004:: with SMTP id n4mr5562537wrp.230.1606229086335; 
 Tue, 24 Nov 2020 06:44:46 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id u7sm5851409wmb.20.2020.11.24.06.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 06:44:45 -0800 (PST)
Date: Tue, 24 Nov 2020 15:44:43 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: christian.koenig@amd.com
Subject: Re: [PATCH v3 02/12] drm: Unamp the entire device address space on
 device unplug
Message-ID: <20201124144443.GQ401619@phenom.ffwll.local>
References: <1605936082-3099-1-git-send-email-andrey.grodzovsky@amd.com>
 <1605936082-3099-3-git-send-email-andrey.grodzovsky@amd.com>
 <54329aa5-ef57-3209-13b7-abd02683f9fc@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54329aa5-ef57-3209-13b7-abd02683f9fc@gmail.com>
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

On Sat, Nov 21, 2020 at 03:16:15PM +0100, Christian K=F6nig wrote:
> Am 21.11.20 um 06:21 schrieb Andrey Grodzovsky:
> > Invalidate all BOs CPU mappings once device is removed.
> > =

> > v3: Move the code from TTM into drm_dev_unplug
> > =

> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> =

> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>

Was wondering for a moment whether this should be in drm_dev_unregister
instead, but then it's only one part of the coin really. So

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> =

> > ---
> >   drivers/gpu/drm/drm_drv.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > =

> > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > index 13068fd..d550fd5 100644
> > --- a/drivers/gpu/drm/drm_drv.c
> > +++ b/drivers/gpu/drm/drm_drv.c
> > @@ -479,6 +479,9 @@ void drm_dev_unplug(struct drm_device *dev)
> >   	synchronize_srcu(&drm_unplug_srcu);
> >   	drm_dev_unregister(dev);
> > +
> > +	/* Clear all CPU mappings pointing to this device */
> > +	unmap_mapping_range(dev->anon_inode->i_mapping, 0, 0, 1);
> >   }
> >   EXPORT_SYMBOL(drm_dev_unplug);
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
