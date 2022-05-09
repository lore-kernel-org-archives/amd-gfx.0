Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F863C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 14:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD14D10F07A;
	Mon,  9 May 2022 14:50:49 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC3A10F0DF
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 14:49:07 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 bd25-20020a05600c1f1900b0039485220e16so117871wmb.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 May 2022 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=gHnu2ZpFdEZeGgsV6LJ9J3EQsFicj2yfJJz6IRs36rs=;
 b=pkQRNedKDexjZJy42ca9CtWRqZXInBcSREOe0KFnptHiO8/ZCGlHWLuHNQ+V8hThMX
 LwMsqcFmZFjKC/3VRY0oEZbrjzyxkZdkEVXreHkdbk0Y5bJRKzZXFTyyPhIPovvPQ+Wp
 mfFuBWZaEPlm9OiWJ+uqtqyxJbbdtPgCOHOubxP+B5N4z/gVz2SwGsgI7e3o3aWgoqJJ
 OORb/QjwcNC5ozYOQBJLAUCj9d15FJJywFXD9oHCtIAYxYlctvSuHCb6iEK+GbMRNUIz
 0BcL0eTQ8DLWG+jf8RAHTYzm9fGOBYD+8v6B5Xwd20T6rGCPosDVAkFO4cMJeTVMQ6Ky
 Ww9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=gHnu2ZpFdEZeGgsV6LJ9J3EQsFicj2yfJJz6IRs36rs=;
 b=5ny0JUW21L8+1d5tBRWKb+WvP80iX2+2wYvO5HQzM/NQ5+PSjPJEiCrN2/CV/2auWc
 5PAz5Y8p665c/3MvcprLaz3tNzZsM3MVNnMAWTCh8bsjd7zoQcYJ8rZK+r6idACvi2fF
 x5RvAS1qT6Ax94T7ia4crTg1UsoYievURJz5Zf869uTYrN2AAITbTN32pZTUN7bKAppe
 ixALbLNUhYbPmDAQsxOKkb+tx+hV60mkhNAtKDnnVSny6oUPZzVZ8Dh2Tg2Q4yodkiwh
 IyNnyKploCHl9Fm8pETIY3LbUY1MG9Mp3qx4f3k6aNpue/tnHURV9skvE1iwMI6NiQI2
 U6JQ==
X-Gm-Message-State: AOAM531s3UzZv2lqk0HTeudSqOHXInY0HycvYUKdYarWL1R4zn2pFfBM
 t16j/WXgz5T82t9vgFUN7aYCjQ==
X-Google-Smtp-Source: ABdhPJyjK6WAR/VZSkjZz9iYJrdF14G2v8OVGBT53jxFu2JrVWFt4FQUhcXmeHENem73T6w1xU41Pg==
X-Received: by 2002:a1c:3b54:0:b0:394:3910:3cb9 with SMTP id
 i81-20020a1c3b54000000b0039439103cb9mr22649799wma.50.1652107745868; 
 Mon, 09 May 2022 07:49:05 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 n13-20020a056000170d00b0020c5253d911sm11724160wrc.93.2022.05.09.07.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 May 2022 07:49:05 -0700 (PDT)
Date: Mon, 9 May 2022 15:49:03 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 5.10 1/1] drm/amdgpu: Ensure the AMDGPU file descriptor
 is legitimate
Message-ID: <Ynkp3+eBhhilI8vK@google.com>
References: <20220412152057.1170235-1-lee.jones@linaro.org>
 <Ylf5zmP88Lw0md47@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ylf5zmP88Lw0md47@kroah.com>
X-Mailman-Approved-At: Mon, 09 May 2022 14:50:48 +0000
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
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Felix Kuehling <Felix.Kuehling@amd.com>, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 14 Apr 2022, Greg KH wrote:

> On Tue, Apr 12, 2022 at 04:20:57PM +0100, Lee Jones wrote:
> > [ Upstream commit b40a6ab2cf9213923bf8e821ce7fa7f6a0a26990 ]
> > 
> > This is a partial cherry-pick of the above upstream commit.
> > 
> > It ensures the file descriptor passed in by userspace is a valid one.
> > 
> > Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> Now queued up, thanks.

Could you also back-port this into v5.4 please?

FYI, in the v5.10.y tree, it's now called:

  f0c31f192f38c drm/amdkfd: Use drm_priv to pass VM from KFD to amdgpu

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
