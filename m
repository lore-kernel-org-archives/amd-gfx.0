Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BBAC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 10:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE10C10EFDB;
	Thu, 27 Jan 2022 10:06:30 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC6210EFD8
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 10:06:28 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id s18so3726373wrv.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 02:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=iCPc9S/xqKutjtG576RySPC5c4MhlsxdAcWvoCriPRI=;
 b=UXS0cNb0r6A21/Yr+t8ULc7eUWYnKfSr2Xz7F/W4kBv4PxDY2V8IiKS9AVKzoL/A4c
 2QXelZZmI0IvcYButMcGhtQiIwQeVSto8F0tLQS/0i6E39oVBJb4ONuB1wxShRLVAjEd
 qBQfBDs5FDzwXhh+3CWdQE+EinE2wHefcKrMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=iCPc9S/xqKutjtG576RySPC5c4MhlsxdAcWvoCriPRI=;
 b=xQEbdIcaN/RvfENlKoQdFip8oJoJzgTIKWXTRGckyhUIMY7L2yiYKwNhJHEIQj/18q
 t8zC/A+wigcRmmQqIPYsUziIVBS5ENaYaE2EV+R0TLo/Nn2NrmvR4dwYZgA7/OQ5jI+c
 n5YlwQMFelObmGaoCd2cygNnGmzluIcPCb/SYT8b3KD3CcfGkJUrAPB8a9nFvkahTnLV
 iNU2MXOG6KBf3288QlujVWbCUk81h3dKPL6wUVE0CR3eVTe/7nV9JALCxdQNuAKR3dXn
 8oLfCuVvYCDy1ituS2acRQvNTFY7dYxiFWBrqIxk0JqnLAfUh+QsO+ld4UA61EmVK5on
 hLGw==
X-Gm-Message-State: AOAM5327B2ur2VisuBZmINpBXfvCLPPuBlSJQVg+7KYZbb1JOB2iygPt
 ibLa9xgSDbB3xrhK5Jws2sa/Pw==
X-Google-Smtp-Source: ABdhPJxbmhEnlOI80raqLeqmBjMueB3L0ut5WVsnvXgW4cJU2nUFg7KyFIWNlDJldrhPELeM37AAEQ==
X-Received: by 2002:adf:fe01:: with SMTP id n1mr2448712wrr.141.1643277987361; 
 Thu, 27 Jan 2022 02:06:27 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id d6sm1681780wrs.85.2022.01.27.02.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jan 2022 02:06:26 -0800 (PST)
Date: Thu, 27 Jan 2022 11:06:24 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drivers: Fix typo in comment
Message-ID: <YfJuoHfKnwm6LmuY@phenom.ffwll.local>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
 tangmeng <tangmeng@uniontech.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@linux.ie, jsarha@ti.com,
 tomi.valkeinen@ti.com, linux@dominikbrodowski.net,
 Peter.Chen@nxp.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20220127065156.22372-1-tangmeng@uniontech.com>
 <YfJCBZuc9mOZkIVJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfJCBZuc9mOZkIVJ@kroah.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
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
Cc: Peter.Chen@nxp.com, amd-gfx@lists.freedesktop.org, airlied@linux.ie,
 tangmeng <tangmeng@uniontech.com>, dri-devel@lists.freedesktop.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, jsarha@ti.com,
 tomi.valkeinen@ti.com, linux@dominikbrodowski.net, daniel@ffwll.ch,
 alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 27, 2022 at 07:56:05AM +0100, Greg KH wrote:
> On Thu, Jan 27, 2022 at 02:51:56PM +0800, tangmeng wrote:
> > Replace disbale with disable and replace unavaibale with unavailable.
> > 
> > Signed-off-by: tangmeng <tangmeng@uniontech.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 2 +-
> >  drivers/gpu/drm/tilcdc/tilcdc_crtc.c  | 2 +-
> >  drivers/pcmcia/rsrc_nonstatic.c       | 2 +-
> >  drivers/usb/chipidea/udc.c            | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> This needs to be broken up per-subsystem, thanks.

For drm please also split it per-driver, so one patch per file you change
here.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
