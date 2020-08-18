Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F813C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 09:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3202D206B5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 09:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brekEtiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3202D206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB8F389BC2;
	Tue, 18 Aug 2020 09:01:02 +0000 (UTC)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0620689BC2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 09:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597741261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LwYlioqpHS/gmxgOcffqAwVxuvHCLYruQxEepn5wr38=;
 b=brekEtiubhn089zUnXdUhyElBn+swpGj+xb4HJIPMUZa9I33U2xhMMriwzAifF7n9Bv/zB
 afT3VylL3J4nVI+7x+qLw4qKiBhjvV2m4xg9/KgdDqmp0rPZ6PZQWdQVDhYYhWBF0y38IL
 I5CKNfXtF5WKK5wQ0r2wXsjat3G0ho4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-mlrecaKvN2iRk-aKQOmtPQ-1; Tue, 18 Aug 2020 05:00:57 -0400
X-MC-Unique: mlrecaKvN2iRk-aKQOmtPQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5813A0BC2;
 Tue, 18 Aug 2020 09:00:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFEDA5D9D2;
 Tue, 18 Aug 2020 09:00:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 078151753B; Tue, 18 Aug 2020 11:00:49 +0200 (CEST)
Date: Tue, 18 Aug 2020 11:00:49 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/2] drm: allow limiting the scatter list size.
Message-ID: <20200818090049.qomgyyw6hif4cmah@sirius.home.kraxel.org>
References: <20200818074828.9509-1-kraxel@redhat.com>
 <20200818074828.9509-2-kraxel@redhat.com>
 <9c355d64-1a61-eb59-be80-d9fc863ddf22@amd.com>
 <20200818082703.7z6fcvoymiqow5kw@sirius.home.kraxel.org>
 <03c03129-db27-c6da-df8f-909141d2a3f7@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <03c03129-db27-c6da-df8f-909141d2a3f7@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: "open list:DRM DRIVER FOR MSM ADRENO GPU"
 <freedreno@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>,
 open list <linux-kernel@vger.kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 David Airlie <airlied@linux.ie>,
 "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS"
 <nouveau@lists.freedesktop.org>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 "moderated list:DRM DRIVERS FOR VIVANTE GPU IP"
 <etnaviv@lists.freedesktop.org>, Sandy Huang <hjc@rock-chips.com>,
 dri-devel@lists.freedesktop.org, Jonathan Hunter <jonathanh@nvidia.com>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 "open list:DRM DRIVERS FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>,
 "moderated list:DRM DRIVERS FOR XEN" <xen-devel@lists.xenproject.org>,
 Sean Paul <sean@poorly.run>, "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  Hi,

> > > I'm missing an explanation why this should be useful (it certainly is).
> > virtio-gpu needs this to work properly with SEV (see patch 2/2 of this
> > series).
> 
> Yeah, that's the problem patch 2/2 never showed up here :)

The list should have everything.

Your inbox probably has 1/2 only because 2/2 doesn't touch amd code and
'git send-email' evaluates sendemail.cccmd (pointing to
get_maintainer.pl) for each patch individually.

I've found this behavior confusing at times before.  Is there some way
to send the whole series to everybody?  Or at least the cover letter?
The git-send-email manpage doesn't give a clue :(

> > Placing it in drm_device instead would indeed work for virtio-gpu, so I
> > guess you are suggesting that instead?
> 
> That is probably the best approach, yes.

Ok, I'll go that route then.

thanks,
  Gerd

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
