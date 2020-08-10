Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEEBC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 13:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF482075F
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 13:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZJTdwcMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF482075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47D6C6E41D;
	Mon, 10 Aug 2020 13:06:26 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 921E16E41D
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 13:06:24 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id f18so13459088wmc.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=GPx3S/8jhM90DHfD4TRK0ne1wHxOQ88UPQC+FKKE7b4=;
 b=ZJTdwcMw05cWS5PqS2LysIVEc5cxxTh/xM1RqHbECyfWRIXZvCen0clWxvPs6VsL8q
 Cq6EQCAbihLLjPKPJyDKllfTFcwVKAcaBSZfEd8ufk46Z2BFSR46ol4PLs7U8qV3LRsD
 Jlxb5d3xrm9mAiALhf8zqBuK3j/akqDOrDtQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=GPx3S/8jhM90DHfD4TRK0ne1wHxOQ88UPQC+FKKE7b4=;
 b=Z1YOYqC+t72Y1DgzkM3tPHszqTX3hG10ePmcOTG1+1yKbMsjGsH/i+7OIvjF/ASGNE
 ffF+90ERrciqbiJx0pEiMky2x1dV4/8DzHWkizPbjJot2JFmFXTJFIzfV/lT+/bQ1Z5f
 DwoqpqUumc32sggY/wq7Vwz5o3ini2u9qzvbeomqGTO8nKS/Vd1mcae1NJsHOJ4poL9B
 qiBTKhXlDgMe8uXtwk3iNS1qJNr7mDdxnmg46yR1MFya1Ccjgb/O1pcTnNUV3VeEq+yS
 mBJ0KzyRvrcPFp6JjlWjgbWkipVxMLfAMXtNFrCYnN6t0tX4bxrG0le+NIr8rs0D1nJG
 XU/g==
X-Gm-Message-State: AOAM533IcFEsk5V9XuLtSsQ7uODdTNBGEzHj0Ui6BJxXG27byiuom2k7
 YgtD4jpsGi+VElpqqym0A5GbDQ==
X-Google-Smtp-Source: ABdhPJyEBEPA21RLrPg4igFyKps9/jMj+ZOxleXUovW4dpHkDIerMq8VNi+ipVYxHqvklkBZYu8Xbw==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr27324020wml.189.1597064783265; 
 Mon, 10 Aug 2020 06:06:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id p6sm22227267wmg.0.2020.08.10.06.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 06:06:22 -0700 (PDT)
Date: Mon, 10 Aug 2020 15:06:20 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: christian.koenig@amd.com
Subject: Re: [PATCH] dma-buf.rst: repair length of title underline
Message-ID: <20200810130620.GS2352366@phenom.ffwll.local>
Mail-Followup-To: christian.koenig@amd.com,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 dri-devel@lists.freedesktop.org,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
References: <20200809061739.16803-1-lukas.bulwahn@gmail.com>
 <7d434810-79bd-89a3-18f8-c5c2a2524822@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7d434810-79bd-89a3-18f8-c5c2a2524822@gmail.com>
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
Cc: linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 dri-devel@lists.freedesktop.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 10, 2020 at 01:25:40PM +0200, Christian K=F6nig wrote:
> Am 09.08.20 um 08:17 schrieb Lukas Bulwahn:
> > With commit 72b6ede73623 ("dma-buf.rst: Document why indefinite fences =
are
> > a bad idea"), document generation warns:
> > =

> >    Documentation/driver-api/dma-buf.rst:182: \
> >    WARNING: Title underline too short.
> > =

> > Repair length of title underline to remove warning.
> > =

> > Fixes: 72b6ede73623 ("dma-buf.rst: Document why indefinite fences are a=
 bad idea")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> =

> Acked-by: Christian K=F6nig <christian.koenig@amd.com>
> =

> Should I pick it up into drm-misc-next?

Yes please. For the future if you need to check if someone has commit
rights and can push themselves:

https://people.freedesktop.org/~seanpaul/whomisc.html

Yeah with gitlab this would all be a bit more reasonable, but we get by
meanwhile :-)

Cheers, Daniel
> =

> > ---
> > Daniel, please pick this minor non-urgent fix to your new documentation.
> > =

> >   Documentation/driver-api/dma-buf.rst | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > =

> > diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/drive=
r-api/dma-buf.rst
> > index 100bfd227265..13ea0cc0a3fa 100644
> > --- a/Documentation/driver-api/dma-buf.rst
> > +++ b/Documentation/driver-api/dma-buf.rst
> > @@ -179,7 +179,7 @@ DMA Fence uABI/Sync File
> >      :internal:
> >   Indefinite DMA Fences
> > -~~~~~~~~~~~~~~~~~~~~
> > +~~~~~~~~~~~~~~~~~~~~~
> >   At various times &dma_fence with an indefinite time until dma_fence_w=
ait()
> >   finishes have been proposed. Examples include:
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
