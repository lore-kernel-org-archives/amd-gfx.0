Return-Path: <SRS0=u08i=64=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4552C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 14:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A47E20671
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2020 14:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="DaPy2p6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A47E20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D2D6EB58;
	Thu, 14 May 2020 14:15:03 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C1666E34D
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2020 14:15:03 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id j5so4357590wrq.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2020 07:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ciZrHvFbJ27aDLpOY4lC0r22i/PxbYLL9mMcUxziujg=;
 b=DaPy2p6f6M/1RrmpPUn/FT917YXpjS4oTh1cBnsLF/e8F2u8Of05tZLwSNizFZtAiJ
 0G05lnhCr5unMbchdaPbjsI4x8cPUqkM915vvrItWVLbAerfb4yYsE5tEmWLQZJ7Phrw
 89xYBlqf+2tHIOjJAHTKk7UVuRKHa1Ju9dTPX5WYmadwAIf8DFZF8e/LM+34/TD7sbpf
 nXykT/4Z6sws2c7UEiGlx4QQgmDs61Qht09OLn/xzkmEe6bZ+9y2Ezqh4coXia24Jlm0
 8VkazAyV/RF8GAF/YtSe4wozND/EXfXYNT5M0mrFTIWefWXpuEY1CraZONgSdVC27vOY
 nPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ciZrHvFbJ27aDLpOY4lC0r22i/PxbYLL9mMcUxziujg=;
 b=lRZXF3fvVHjrLNDbyFGKb0tpxW19KTf8zUkWeh1heHj7ViSmrmJXkIbPRFHg804TRF
 k8Ws8+pfKXBlrhCwiZnYwVUoZRorHPH5VOSLl8bBuoiKhASgUr+04dP6nsESAUgQLZxB
 BkG6/Jkng6U6gWmMZWI1ABPjNLo5bHcpoKv/2zIzZFOjJ4hIUaCMMZN+uBUl/ENrzrJH
 cdS7mUjII1vtGgAN3ULhSzbk7ZJp3PDx+VF9SglPXZ0tdemz+2bF6iXdJqBRNglDrQGj
 mfZkDo2tQCCmW+8LkQDEWOBEyTtQcoPeFSwVAP0c5A0fblfZSoHwCjMRJWR+6oBEWPmp
 w/xw==
X-Gm-Message-State: AOAM531kQgg9PaixAUIXikXdVbawk7ZnTyACRCWOD20Zp/j7zE7a7MuE
 Cflqub8lLMgtFBfgPxNFG9T8HbnO6E4YRGtuSkhrMA==
X-Google-Smtp-Source: ABdhPJy7T0e95z6kUohvTFRitvd2uwEtFinZQ127SCRbZNUsANHzvptwlUKz6X0J1I85yB7Roce7W1VAPTBxbpddf3Q=
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr5669393wrw.256.1589465701461; 
 Thu, 14 May 2020 07:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200430212951.3902-1-alexander.deucher@amd.com>
 <CAPj87rM6nvr-pspfz9PaPiV9kkSM+=rh_YMaPXqaBZv37Yc-Yw@mail.gmail.com>
 <CADnq5_O-jgxFf4RArnf_fxeW5MxyDX3aMn=jViAZyx1-PAtHzw@mail.gmail.com>
In-Reply-To: <CADnq5_O-jgxFf4RArnf_fxeW5MxyDX3aMn=jViAZyx1-PAtHzw@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 14 May 2020 15:13:22 +0100
Message-ID: <CAPj87rPwd0TpnBy1g3BDBbQb3e0RjEn2Sy+yP01ALNGts+NhLA@mail.gmail.com>
Subject: Re: [pull] amdgpu, amdkfd drm-next-5.8
To: Alex Deucher <alexdeucher@gmail.com>
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

Hi,

On Thu, 14 May 2020 at 14:36, Alex Deucher <alexdeucher@gmail.com> wrote:
> On Thu, May 14, 2020 at 5:42 AM Daniel Stone <daniel@fooishbar.org> wrote:
> > Did this ever go through uAPI review? It's been pushed to the kernel
> > before Mesa review was complete. Even then, Mesa only uses it when
> > behind a magic environment variable, rather than through the EGL
> > extensions which have been specifically designed for protected content
> > (EGL_EXT_protected_content, protected_surface, etc). The winsys
> > usecase was based on a Wayland system which seems like it will only
> > work when composition bypass is available - not using any of the
> > Wayland protected-content extensions, and it's completely unclear what
> > will happen if composition bypass can't actually be achieved.
> >
> > I don't think this should be landing before all those open questions
> > have been answered. We're trying to come up with a good and coherent
> > story for handling protected content, and I'd rather not see AMD
> > landing its own uAPI which might completely contradict that.
>
> Well, the patches have been public for months and we have a UAPI and
> mesa userspace which works for our use cases and the mesa side has
> been merged and the recent comments on the MR didn't seem like show
> stoppers.

As a generic compositor author, it's pretty important for me to
understand what happens when trying to access protected content. Does
the import simply fail? Does it sample rubbish? Does my context
killed? etc.

> I don't disagree with your point, but I feel like agreeing
> on a what we want to do for EGL protected content could drag out for
> months or years.

I don't really see what the problem is, but it would've been nice if
it was at least attempted, rather than just parachuted in ... I know
I'm going to end up getting bug reports about it for Wayland/Weston,
and then all of a sudden it's become my problem that this was just
dropped in as a vendor-specific feature in a vendor-specific island.

Cheers,
Daniel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
