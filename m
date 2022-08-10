Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DD2C00140
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 15:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6995E18A86F;
	Wed, 10 Aug 2022 15:40:03 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A728010EED3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 15:39:51 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-116c7286aaaso2327510fac.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 08:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=T5iFlRkzTf2S5T8gHCvMBh8iS91tkoQ3hnuZ6TY90IE=;
 b=m0melDDAlcIhGcnqRRYlP1NhqVmfC6M1vM8IAlivyyu3+Mc545409YjzdCOnbMTyHN
 18uCb4J3uZByB+Iqah8aadCWvLwdBmFwqZDQr1SyjQbk6LQn3ky8eiUhltikOKAmDtc8
 P3ho/W8jvbOkokslFiwNb6aHpJ43uFtFSAisBhWn4XtDmUe6v8wJlfHv1/uxxDlgpK2g
 W6BAO8SfB2+FAX2YIQGvYV4dbQZWUlB11Nt2wWH2WAdAkHC7QMXTbQ3RJADpvbCiSXER
 06X5bHXwHZaa7xm/ecAelSvuxYgA8SMVJAz2jOTzfEaCsBolTHm60CcZYVkiAk+HtK5f
 irMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=T5iFlRkzTf2S5T8gHCvMBh8iS91tkoQ3hnuZ6TY90IE=;
 b=dpIRL9S3IIhKckO5lHOaCWj85Qz43kVhwJpzgJ/wmuVPl9Z2TYqCInMBRoCs/+lpec
 JKqpSnShAdHv7o7KWX7cHrcC/ydB/ovdEYxIbYnkvZdpyxEz5yUhdszXfqXjYx2DCjfW
 ke0sn7/EAy2+aLX1OkIc1ts+3Wqod8Qpzd5pDjhKr2uIMnY7oEbjsi6/os+3iFZGeN9U
 oVynv9NFCF5H3LY3WJqZNSZVbwtS6UVav+MBXCwh9VTD7H/ZjCNlIr/jqtTkzO0cTRgD
 +2f7vHWpwHLi/JU71AJSYU+ge9ED+N8CrvU4Xutba8Ne/XFBsF698hLvz72ZeRNyRejo
 CvBg==
X-Gm-Message-State: ACgBeo2FtWaFsqw1CVTjTBvCUc1TJ6RqPiGczYy0twxnUeweuogHbkXo
 OMJA5mBrjLZ2Q9nG7cMLQRHkjJ9YKHJ9wDjdCLE=
X-Google-Smtp-Source: AA6agR7VCR8hXQkJPuNqsdtP9KLSdlVfNHBjLy7zdWODwrYixDgG9UbxA2Ow9IL2ghUFwhTt0I9ANHkhUudYSDOXKmE=
X-Received: by 2002:a05:6870:3398:b0:113:7f43:d0e9 with SMTP id
 w24-20020a056870339800b001137f43d0e9mr1662777oae.33.1660145990881; Wed, 10
 Aug 2022 08:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220719185659.2068735-1-alexander.deucher@amd.com>
 <CADnq5_MkB8xKHZxVsiXfWPA-QuVrrNCNXF=ScrYAPjNbAH36LA@mail.gmail.com>
 <YvPQ6MBF6V5FUEHF@kroah.com>
In-Reply-To: <YvPQ6MBF6V5FUEHF@kroah.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Aug 2022 11:39:39 -0400
Message-ID: <CADnq5_OtXNALuQwsp-yShKxsyZTnfhheSuf9UqfRkbtm9GddiA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix check in fbdev init
To: Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 hgoffin@amazon.com, stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 10, 2022 at 11:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 10, 2022 at 11:28:18AM -0400, Alex Deucher wrote:
> > On Tue, Jul 19, 2022 at 2:57 PM Alex Deucher <alexander.deucher@amd.com> wrote:
> > >
> > > The new vkms virtual display code is atomic so there is
> > > no need to call drm_helper_disable_unused_functions()
> > > when it is enabled.  Doing so can result in a segfault.
> > > When the driver switched from the old virtual display code
> > > to the new atomic virtual display code, it was missed that
> > > we enable virtual display unconditionally under SR-IOV
> > > so the checks here missed that case.  Add the missing
> > > check for SR-IOV.
> > >
> > > There is no equivalent of this patch for Linus' tree
> > > because the relevant code no longer exists.  This patch
> > > is only relevant to kernels 5.15 and 5.16.
> > >
> > > Fixes: 84ec374bd580 ("drm/amdgpu: create amdgpu_vkms (v4)")
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: stable@vger.kernel.org # 5.15.x
> > > Cc: hgoffin@amazon.com
> >
> > Hi Greg,
> >
> > Is there any chance this can get applied?  It fixes a regression on
> > 5.15 and 5.16.
>
> Ah, missed this as it was not obvious that this was a not-upstream
> commit at all, sorry.
>
> I'll dig it out of lore.kernel.org and queue it up for the next round of
> releases, but note, this is our "busy time" with many patches marked for
> stable.
>
> Oh and 5.16 is long end-of-life, nothing anyone can do there, and no one
> should be using that kernel version anymore, so no issues there.

Thanks Greg.  Much appreciated.

Alex

>
> thanks,
>
> greg k-h
