Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FBBC55ABD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29BBD208D5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="ByJxv0VY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BBD208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6D486E514;
	Fri, 13 Nov 2020 17:56:56 +0000 (UTC)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 846FD6E514
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 17:56:56 +0000 (UTC)
Received: by mail-io1-xd41.google.com with SMTP id p7so10643030ioo.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 09:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZXEQ6DpzVdmMyFi19+nX5koK6YFdYxSjHlu2VjPiHP8=;
 b=ByJxv0VYWZiUUMgkyOWrKjhOG73dCA+yR24WPP99L/Dbuf7chn2VwF52cCDdyqcgKW
 U7fo6obubjDG4PW/nXOIDOC3zjWaNE8WgcLchDkow2x6urMNJbm+KU5r7wAvqGhHE6gu
 eKpZ4X8r0DJ8Z5REGvqd4eXJj6D7flyf2b+uuih0C7cfbf6sTLrasD3PflbZxk+/SuJo
 Qxz+NVqMv80u/C4Hh44i5yfnVlVNcsWA3cRtW4nph6RihxPhRc/xlWQ422z1puO3IgIy
 d/0K2noR+bFMbxRqt8Scd1UgCU/SBUujJjVm8Jilz6cWaRfJc5xnyml9rrimXby+SLNV
 6STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZXEQ6DpzVdmMyFi19+nX5koK6YFdYxSjHlu2VjPiHP8=;
 b=qPGpLF4IkgXIMZrJMTmamCe7oOieyeM+JGCDuElZTbC1NTqGnEK+tjYbD0HiqyjEhg
 8f5aBzz03Gib0UPseA+fulYZwpFp4oukqroVdlZ/Qia85WZp28VwLkGPwVUrdjLbQw+e
 LsqKVgyr1b498X3WnaiZenRYqRI6U6UmVeGT0nxv/ToWmC6oS6fjm5JuaxrcsCmrZs67
 hz0SjtrVg8YkrQRwz0f0VzkrkCMz3k8VeVGl5peGJv/HnxWGQ+TuVLhZd385jhpNi7ub
 QsEm/6Y50Tg3Da3B71gByQXUDbphyl8Wlge68byiBg5pPNwI30mWaSGFhApKPxdBGy4Q
 iGng==
X-Gm-Message-State: AOAM530zLASKCy1O8Fe5o4a3kmFvm+iV5c4XfN2uhDouU3Tli2zrkR4t
 P/bKvz3An0BwrFrC8gj8SC75AjL/TBLhtNL9GfzLEvczOSWQEg==
X-Google-Smtp-Source: ABdhPJwPuVzq9uWDlW/k03GTE0KosSyljro5tOFi2ZWh8FcwBeA0BnvMGryG5aRTYljHTZMBl5HdkI79fW8TIbnvVGw=
X-Received: by 2002:a05:6602:5de:: with SMTP id
 w30mr738992iox.64.1605290215837; 
 Fri, 13 Nov 2020 09:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20201111024840.496679-1-bas@basnieuwenhuizen.nl>
 <CADnq5_OEU=YunrRHE=56B7s=vSLERc92B33ZWOXivap=vjfjFg@mail.gmail.com>
In-Reply-To: <CADnq5_OEU=YunrRHE=56B7s=vSLERc92B33ZWOXivap=vjfjFg@mail.gmail.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Fri, 13 Nov 2020 18:56:52 +0100
Message-ID: <CAP+8YyHB637WZaCyFeUmH7kCjBHrJHapYg2Kui83dkKM906oXA@mail.gmail.com>
Subject: Re: [PATCH 0/3] amdgpu getfb2+modifier improvements
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
Cc: "Wentland, Harry" <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 13, 2020 at 6:53 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, Nov 10, 2020 at 9:48 PM Bas Nieuwenhuizen
> <bas@basnieuwenhuizen.nl> wrote:
> >
> > This has some more improvements for the addfb2 code in amdgpu.
> >
> > These patches make ffmpeg work with DCC compressed and YUV surfaces
> > with kmsgrab, both in the modifier and non-modifier case.
>
> Looks good to me.  Series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Thanks! Do you need me to apply the r-b tags or can you apply as is?
>
> >
> > Bas Nieuwenhuizen (3):
> >   drm/amd/display: Store gem objects for planes 1-3
> >   drm/amd/display: Set new format info for converted metadata.
> >   drm/amd/display: Extract 3rd plane from metadata
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 211 +++++++++++++++++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |   2 +
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  88 +-------
> >  3 files changed, 207 insertions(+), 94 deletions(-)
> >
> > --
> > 2.29.2
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
