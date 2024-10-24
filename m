Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2E8CE8E92
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 16:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EEFD10E39D;
	Thu, 24 Oct 2024 16:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fdGRwmWs";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91DB710E38E
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 16:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729787391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZXCwg6hYJwlV3dQoijUPbMEIAM4RESJSpWVfasu2GA=;
 b=fdGRwmWsqj+lueErmglc1O03FFyhlr7+9pEdARz3JBGWrD4TSCEIh3blrr6F2eMu+UWGQT
 uBNPQmfBsE2nkHNLJJD2W+1nhZsw1pNIaVohT2YFi7dYo7Fr78sTVT7Rx+3SxiYF2Z/kJK
 E2EIcadfe7Ubo1M0WucEfEqaeG3vcDA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-lCs6d4usNDON0V4KT9Qj7A-1; Thu, 24 Oct 2024 12:29:50 -0400
X-MC-Unique: lCs6d4usNDON0V4KT9Qj7A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315c1b5befso8242815e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 09:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729787389; x=1730392189;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JZXCwg6hYJwlV3dQoijUPbMEIAM4RESJSpWVfasu2GA=;
 b=W5SE0vwDQ9TlQPTfMwBHe3qmCEcu8n6gW9lO+IGKQlAJOUDuwjfW7myuQeq1g1kIsk
 Ku05P2wmVH4JcNMRR9wt1HZPY79R3vlqfIkb3d3p92Cn4Ybqp/NB3Z1N6Yo3JH3tLKkv
 sEQcrwj4xgowJDAzC8aSXBUVCY6uVlWesS5f37NU2ys1T+zPtdCLnowTArY1kVihdHHs
 lKd/D3Bk2P9DbxU/8zy65mJSlBUh7czlXOBNZqRrsX9lKnktOibW1GKEz9QN5oI9BPQS
 WtEck3fz2SkLB5fl28uyQ+qrqYJ5/0PbU1L+Yh7uOL42IIKzOYpAzU1/d0/c77n+3B3S
 e4zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwNwG1Ih3rxTxGMbTctXmJtLCVqxP3r3FI6EcoHAzz9s9EXcMF+U40Lxhu4Zcly3dSdrBEd08F@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyd8ONzHS7rf1vTf+iFR2nxl3fZu2LnLTxcApU3ODFkm4yE1gK6
 +COjFUaW9afp4hUA3AfpYc8YpxvdYp+YdQ/lYAF3nUqwnllHxk7veEmQRABRlG9UD6HZvMOH2cx
 uZkV1sHIUjAywu1xZ8/e9VYi+yfHK7U/RZCi/iaWF62WMW/TQtf+jRGbeUWsmldY=
X-Received: by 2002:a05:600c:1e16:b0:431:561b:b32a with SMTP id
 5b1f17b1804b1-4318c6f505cmr23112405e9.19.1729787389132; 
 Thu, 24 Oct 2024 09:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET7dTcaOAuam5O1YOxfn6XKm0SifRdkj3JgT8AA6xwQNV6mNJK26LyEtPp9s4XkYUWZXGjDQ==
X-Received: by 2002:a05:600c:1e16:b0:431:561b:b32a with SMTP id
 5b1f17b1804b1-4318c6f505cmr23112135e9.19.1729787388661; 
 Thu, 24 Oct 2024 09:29:48 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43186c1e911sm50457715e9.45.2024.10.24.09.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 09:29:48 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com, David Airlie <airlied@gmail.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Simon Ser
 <contact@emersion.fr>, Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann
 <tzimmermann@suse.de>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>,
 amd-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/2] drm: remove driver date from struct drm_driver and
 all drivers
In-Reply-To: <20241024162240.2398664-2-jani.nikula@intel.com>
References: <20241024162240.2398664-1-jani.nikula@intel.com>
 <20241024162240.2398664-2-jani.nikula@intel.com>
Date: Thu, 24 Oct 2024 18:29:47 +0200
Message-ID: <875xph1n2c.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Jani Nikula <jani.nikula@intel.com> writes:

Hello Jani,

> We stopped using the driver initialized date in commit 7fb8af6798e8
> ("drm: deprecate driver date") and (eventually) started returning "0"
> for drm_version ioctl instead.
>
> Finish the job, and remove the unused date member from struct
> drm_driver, its initialization from drivers, along with the common
> DRIVER_DATE macros.
>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

