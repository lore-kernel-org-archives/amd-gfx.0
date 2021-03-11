Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE0EC433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 13:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C414D64E77
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 13:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C414D64E77
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A706EC62;
	Thu, 11 Mar 2021 13:10:21 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21BCE6EC62
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 13:10:20 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 r10-20020a05600c35cab029010c946c95easo12748893wmq.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 05:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=+hhpCW4NXZ2+Io3IMxIPYt+lYnp9sm+v1Ci9SUk4a3o=;
 b=JNpInhzYi/QnLCeOhXJx5y7ODz0WDyvNCzDUaEHpOk3MmBIeniVihqSRcfAx5GJ7px
 Jr+zQJ+o5Qlg1Vhf6G4z1e+jH7desHi3Dbn82MxKmS1Nq+qSx+mmW4AVXBigDJ/G0YuZ
 pGbslCB6D3BwYRFru3GF5x9gCIm9fC2/1MXxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=+hhpCW4NXZ2+Io3IMxIPYt+lYnp9sm+v1Ci9SUk4a3o=;
 b=BOayCtw2DSb/SyH7b+ngvsvmC7UZ5x/NBMzYHE9RbwhjLWisDkZD2RHQkmnjAiKz+z
 CuCCHgziqClFHgP1JNiPCfW2AHVusKUIKaLTbvFwqvR5H2dvFmLqqKtSSV6jEp9erLRm
 WdsQ12wPTAWKCloabjYEZD/tcVakT5VIaxCJUlwNadDxBSz+WRKwmtgaNo7K78uHTIBK
 ZrDuKyN/q1U+dVulAH3um1ON9elwnMBMlXDOgohGbU4lnNP+9wF2HoSgB7Ci+hj9H7AH
 1hhMYgWyWwIu81iyC0RimXkoM+T/VOFSstgw7hMLkROpM+yBjBQ+bjAapx9xNAi0zVNa
 IqZQ==
X-Gm-Message-State: AOAM532/+5MS3yxF8PUsP+LaeU+AJ01bhhIXvcRvjDpt76iOflEi5bU1
 KVumQXRYi1cbHvm+nhGVhzcrEQ==
X-Google-Smtp-Source: ABdhPJy51Lb+MAwQ+byf24AEh2DP5jP8rj5VHu5rcUu4pEdw0ULIAaT7cZjaXYbs9Ol1mcprLfnklA==
X-Received: by 2002:a1c:7e45:: with SMTP id z66mr8189532wmc.126.1615468218741; 
 Thu, 11 Mar 2021 05:10:18 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id g5sm3782504wrq.30.2021.03.11.05.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Mar 2021 05:10:18 -0800 (PST)
Date: Thu, 11 Mar 2021 14:10:16 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/radeon: fix copy of uninitialized variable back to
 userspace
Message-ID: <YEoWuBOCf8nr5tZn@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, 
 Colin King <colin.king@canonical.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@linux.ie>,
 Marek =?utf-8?B?T2zFocOhaw==?= <marek.olsak@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210303002759.28752-1-colin.king@canonical.com>
 <490409f2-9fcb-d402-a6ae-b45c80bae3d2@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <490409f2-9fcb-d402-a6ae-b45c80bae3d2@amd.com>
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
Cc: David Airlie <airlied@linux.ie>,
 Marek =?utf-8?B?T2zFocOhaw==?= <marek.olsak@amd.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Colin King <colin.king@canonical.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 03, 2021 at 08:42:31AM +0100, Christian K=F6nig wrote:
> Am 03.03.21 um 01:27 schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> > =

> > Currently the ioctl command RADEON_INFO_SI_BACKEND_ENABLED_MASK can
> > copy back uninitialised data in value_tmp that pointer *value points
> > to. This can occur when rdev->family is less than CHIP_BONAIRE and
> > less than CHIP_TAHITI.  Fix this by adding in a missing -EINVAL
> > so that no invalid value is copied back to userspace.
> > =

> > Addresses-Coverity: ("Uninitialized scalar variable)
> > Cc: stable@vger.kernel.org # 3.13+
> > Fixes: 439a1cfffe2c ("drm/radeon: expose render backend mask to the use=
rspace")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> =

> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
> =

> Let's hope that this doesn't break UAPI.

If it does I think the only difference would be errno userspace sees
(aside from the stack garbage, which we could also emulate). Switching to
return 0; is easy. So no worries this would be a problem :-)
-Daniel

> =

> Christian.
> =

> > ---
> >   drivers/gpu/drm/radeon/radeon_kms.c | 1 +
> >   1 file changed, 1 insertion(+)
> > =

> > diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/rade=
on/radeon_kms.c
> > index 2479d6ab7a36..58876bb4ef2a 100644
> > --- a/drivers/gpu/drm/radeon/radeon_kms.c
> > +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> > @@ -518,6 +518,7 @@ int radeon_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
> >   			*value =3D rdev->config.si.backend_enable_mask;
> >   		} else {
> >   			DRM_DEBUG_KMS("BACKEND_ENABLED_MASK is si+ only!\n");
> > +			return -EINVAL;
> >   		}
> >   		break;
> >   	case RADEON_INFO_MAX_SCLK:
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
