Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09016C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 13:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B692B64DEE
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 13:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B692B64DEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 239496E24E;
	Wed, 10 Feb 2021 13:14:16 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C6D6E24E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 13:14:15 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id 7so2523478wrz.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 05:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=yd/N+I5kkzyOJpCnRN7vd7lwOUGF6B7BATQPc1K2fYQ=;
 b=Ku2flnqwc5D6z3d9GmRgcHXuXbDphKiJCNyjgnzoxVdwxDs/52BrDyb7OcLZWnkYAz
 UR5IZLaVzdRpurLn7fxlbf1b3mo/RM5L29GsZ6tgTpsyMRaO55uRbNi615w5EEGuzuiH
 EftzrNQu9uZtxv0u8BEWObc6EWl1rD8xoM1xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=yd/N+I5kkzyOJpCnRN7vd7lwOUGF6B7BATQPc1K2fYQ=;
 b=g4dyKnMqgw0S6LNOYMAaOSnECV+K6wHbSjPCXS53y3lng0GPDP8lKMkW2xAjCYkSLq
 E9VgsimNxntY+jub+PuF183zL/BYUWNHtZrAnCcGJMdwPTs5n46k+HkNJevh/LiyoNND
 eexh88Ksn3FRIiQF06W2RMkWgEHq2xMKcf94VUJ6gwt/wxWcGQLzUbmy+3TPGL3pMsxB
 7E0phSyTArxu5jQIuDEsJJbEuUXFJZBV8ijMsb18paANrDqh0leM5B5ILRlXcFd+vN/3
 6dpEw2+8hTooxruG1TlP3N9/IPyjdWC1qCz88DBB8Y6Fg+6hut2pxiZaAAwvo9uKmbRJ
 H3pQ==
X-Gm-Message-State: AOAM530YnfkKuS+lHx2kSocQFVxnLl/Wol3LwgLRhIoHl+cse3CTg813
 YAbjRDb0fCV3QLYZ+lpjkgYpXA==
X-Google-Smtp-Source: ABdhPJzaMMmb4JfbfYiORqaQNccdJmyShOrVZsJEkutd675pXDThmmVuBjfO9+5KkU1bjFmrTMFG0A==
X-Received: by 2002:a05:6000:1374:: with SMTP id
 q20mr3489704wrz.44.1612962853806; 
 Wed, 10 Feb 2021 05:14:13 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id r1sm2894759wrl.95.2021.02.10.05.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Feb 2021 05:14:13 -0800 (PST)
Date: Wed, 10 Feb 2021 14:14:11 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 0/3] drm/ttm: constify static vm_operations_structs
Message-ID: <YCPcIwxso67M3VqR@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, 
 Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 David Airlie <airlied@linux.ie>,
 Alex Deucher <alexander.deucher@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org
References: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
 <e819cb08-98b6-c87d-4d95-338e06f88a48@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e819cb08-98b6-c87d-4d95-338e06f88a48@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Likun Gao <Likun.Gao@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 10, 2021 at 08:45:56AM +0100, Christian K=F6nig wrote:
> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com> for the series.

Smash it into -misc?
-Daniel

> =

> Am 10.02.21 um 00:48 schrieb Rikard Falkeborn:
> > Constify a few static vm_operations_struct that are never modified. The=
ir
> > only usage is to assign their address to the vm_ops field in the
> > vm_area_struct, which is a pointer to const vm_operations_struct. Make =
them
> > const to allow the compiler to put them in read-only memory.
> > =

> > With this series applied, all static struct vm_operations_struct in the
> > kernel tree are const.
> > =

> > Rikard Falkeborn (3):
> >    drm/amdgpu/ttm: constify static vm_operations_struct
> >    drm/radeon/ttm: constify static vm_operations_struct
> >    drm/nouveau/ttm: constify static vm_operations_struct
> > =

> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
> >   drivers/gpu/drm/nouveau/nouveau_ttm.c   | 2 +-
> >   drivers/gpu/drm/radeon/radeon_ttm.c     | 2 +-
> >   3 files changed, 3 insertions(+), 3 deletions(-)
> > =

> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
