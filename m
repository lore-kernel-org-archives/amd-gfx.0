Return-Path: <SRS0=u08i=64=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6526C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 13:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1EC20727
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 13:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0Ngcbzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1EC20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 670686EB45;
	Thu, 14 May 2020 13:36:24 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4661D6EB4A;
 Thu, 14 May 2020 13:36:23 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id f13so2015243wmc.5;
 Thu, 14 May 2020 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WleO5OQQ2cS64pu//3/WDEpJDP0OZyFZHtQOIo82VZU=;
 b=W0NgcbzdazeTnbuhFXMKX5Bojco1SFNqNnPqizZstWUIN/gDNJPxD9ZoGdl/GtJ9Da
 A5b23Hg+2Xe4wEZaZFhVolhv5W+6rd3Mk9K42MpYmb0obcrlWuW/4Eop0I0Jou1Q6x/4
 qKqGDT/aK6IESYNbVQc5oFQ9mG0pTF7/AoiLP3u7n0L3TW8EtYkybTQQ+4Kuzm7q8glV
 FRDxoJ7nkgcvqdwjs1Zm+9mOid4MsEJNJJ9dllATzA+IY7SjqTMfQiuj1ZWelQY9/6B5
 iOE9Y0tP5tPnn7yRk/V4FWvJU+kAdFL+CHdCt5ZkByMauvNFvARvkac1VWtTDluVbpQ7
 c1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WleO5OQQ2cS64pu//3/WDEpJDP0OZyFZHtQOIo82VZU=;
 b=tSgS0KhMjZE8YgzcZagq6KUf12WBLBOUrVHvI0O1oya/ChNOtvtz5JtHBgKPcSDOk1
 x8ohIAPR8k3RueGzL1OYSX+lSqOxeWuJbfsw4/HLCsVwhlgMgcQFTMTmpwr35yZGhqYl
 ZG4exr0LGglkzigr3fQVxHUGGpvhQBX5nGNpPV3usmNoUt0Zu7hbOTHpBLpkkb0MSN6y
 elEvtPzfKpnQEpCr/50WMx2LtJGNLrzLP0By7agDOYVg9zJNi+6PdkjThFYoMeEUnjEX
 FsTOsGFK8rOB6hlEej84PArkZPEZuV1b2pj4VGDt0agLGtu10D99/67dj8KlFKQ05/MN
 EXrQ==
X-Gm-Message-State: AGi0PuZ+aSi68mGBl70X1EdgfMRp9+Iz4iIQk7rhUhdk5190K1cuvkPn
 ZyqHO0lEcrrL6CifBDWnsB0vrkelcrDnDwukIjo=
X-Google-Smtp-Source: APiQypJ4ZCU2dOR9dURG1KJeLy+DhYpK/pw5TQ1DxW/dXarZxFLDnIOQNpJF6PcybSqaqy5+dPvVtGckhoN6NeQggSM=
X-Received: by 2002:a1c:1d41:: with SMTP id d62mr28637962wmd.79.1589463381886; 
 Thu, 14 May 2020 06:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200430212951.3902-1-alexander.deucher@amd.com>
 <CAPj87rM6nvr-pspfz9PaPiV9kkSM+=rh_YMaPXqaBZv37Yc-Yw@mail.gmail.com>
In-Reply-To: <CAPj87rM6nvr-pspfz9PaPiV9kkSM+=rh_YMaPXqaBZv37Yc-Yw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 May 2020 09:36:10 -0400
Message-ID: <CADnq5_O-jgxFf4RArnf_fxeW5MxyDX3aMn=jViAZyx1-PAtHzw@mail.gmail.com>
Subject: Re: [pull] amdgpu, amdkfd drm-next-5.8
To: Daniel Stone <daniel@fooishbar.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 14, 2020 at 5:42 AM Daniel Stone <daniel@fooishbar.org> wrote:
>
> Hi Alex,
>
> On Thu, 30 Apr 2020 at 22:30, Alex Deucher <alexdeucher@gmail.com> wrote:
> > UAPI:
> > - Add amdgpu UAPI for encrypted GPU memory
> >   Used by: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/4401
>
> Did this ever go through uAPI review? It's been pushed to the kernel
> before Mesa review was complete. Even then, Mesa only uses it when
> behind a magic environment variable, rather than through the EGL
> extensions which have been specifically designed for protected content
> (EGL_EXT_protected_content, protected_surface, etc). The winsys
> usecase was based on a Wayland system which seems like it will only
> work when composition bypass is available - not using any of the
> Wayland protected-content extensions, and it's completely unclear what
> will happen if composition bypass can't actually be achieved.
>
> I don't think this should be landing before all those open questions
> have been answered. We're trying to come up with a good and coherent
> story for handling protected content, and I'd rather not see AMD
> landing its own uAPI which might completely contradict that.

Well, the patches have been public for months and we have a UAPI and
mesa userspace which works for our use cases and the mesa side has
been merged and the recent comments on the MR didn't seem like show
stoppers.  I don't disagree with your point, but I feel like agreeing
on a what we want to do for EGL protected content could drag out for
months or years.  Our UAPI is pretty straight forward and pretty much
matches how our hw works and what we already do for other GPUVM
mapping attributes like read/write/execute.  I don't see the current
UAPI being a blocker for any future protected content work, but of
course we can't be sure until it actually happens.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
