Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA97C55ABD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EEEA221EB
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGrEB0vN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEEA221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC4F6E5A0;
	Fri, 13 Nov 2020 17:59:19 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C28F06E5A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 17:59:18 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id o15so10881824wru.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 09:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vY0IDHH/IaICxRBULNemIweyYdihMjwcWJzjUu32+R8=;
 b=XGrEB0vNgzhZZHpdThZ2OTlAzMc9m2jNEuizRwKCU+4VN1/fKPiCDuI6/sDWJPzls1
 zltHytwfFsiLGafSUYeRR+RzohuTLBHRT8JF9E4MxRlwkQsieX7KRD4DFhZI1LyDvOs+
 A0Rg1NPVjtAOCRa3V57XttYLJtRUHUtJxf3rYc92uOVJzJDwZrbJtxC/oWaskhm8es0I
 yv/SgHnWcK7alXczOE4P4A601XhN6yHaa3cd4aaimT7l7mFCYsQNxywqK27outXs4RDb
 6sO+MyJIZgqqzjXJ8dq4cxu4TB48zANo0QKfZS2Qg0h8Vc8oFHdWjnqbRqJcSskEDulr
 UGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vY0IDHH/IaICxRBULNemIweyYdihMjwcWJzjUu32+R8=;
 b=QvxZiapTsy2XOo1uNu8WblGiXmqm0B4vs4QnVlPMcKKDqtivSgeCF2iVunnrzND2Ak
 8AaUqkeM0qEa7dxAjOnlVMiIEDJ17X1gARJDQO18Gg2o8gq9Tt3hS1cs+jfVNWjqE4On
 TWzb0ix3vSX/t5jkKU+ngS6NyJBaGg/Kldu5RliUrtQHbpbV0FNp32i+dIA6H583QOI2
 XeP7+TOiv+Sh7Ml59QayNJ1Ke+wZl0nyjr5Wd968sfcsR0Mh9T6MWWBJyxS8JuidKObL
 jnHTAO0gKI9t9DiTGWwHBGQqVjl1W8TvO1beBT7lOBxyhnG1zHl2Jf4il6qRposdRyT7
 g2oQ==
X-Gm-Message-State: AOAM533VJt1MBr/HaN/mggHSCaEjXp5JLCeCbSY6JEMUNLjfR7owmOwo
 CMiNehfUYNpqbAUdm++y4iAeVZLedhSCM5arCll4qcHF
X-Google-Smtp-Source: ABdhPJx7K8d/W369wCB+9xiYqjyb/uo12Z6zz+IzDa1mAWm3UM7JsCGNjTcuWKTKRKkwqkL976tJniSpqOdCaDmEEnM=
X-Received: by 2002:adf:8028:: with SMTP id 37mr4827286wrk.111.1605290355332; 
 Fri, 13 Nov 2020 09:59:15 -0800 (PST)
MIME-Version: 1.0
References: <20201111024840.496679-1-bas@basnieuwenhuizen.nl>
 <CADnq5_OEU=YunrRHE=56B7s=vSLERc92B33ZWOXivap=vjfjFg@mail.gmail.com>
 <CAP+8YyHB637WZaCyFeUmH7kCjBHrJHapYg2Kui83dkKM906oXA@mail.gmail.com>
In-Reply-To: <CAP+8YyHB637WZaCyFeUmH7kCjBHrJHapYg2Kui83dkKM906oXA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Nov 2020 12:59:04 -0500
Message-ID: <CADnq5_MRWa2Z4c_4n2s8n0N37qVTb1xeBESV+PYN-zVDQYHv6g@mail.gmail.com>
Subject: Re: [PATCH 0/3] amdgpu getfb2+modifier improvements
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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

On Fri, Nov 13, 2020 at 12:56 PM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> On Fri, Nov 13, 2020 at 6:53 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Tue, Nov 10, 2020 at 9:48 PM Bas Nieuwenhuizen
> > <bas@basnieuwenhuizen.nl> wrote:
> > >
> > > This has some more improvements for the addfb2 code in amdgpu.
> > >
> > > These patches make ffmpeg work with DCC compressed and YUV surfaces
> > > with kmsgrab, both in the modifier and non-modifier case.
> >
> > Looks good to me.  Series is:
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> Thanks! Do you need me to apply the r-b tags or can you apply as is?

I will apply them.  Just wanted to see if anyone else had any comments
before I land them.

Thanks,

Alex

> >
> > >
> > > Bas Nieuwenhuizen (3):
> > >   drm/amd/display: Store gem objects for planes 1-3
> > >   drm/amd/display: Set new format info for converted metadata.
> > >   drm/amd/display: Extract 3rd plane from metadata
> > >
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 211 +++++++++++++++++-
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |   2 +
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  88 +-------
> > >  3 files changed, 207 insertions(+), 94 deletions(-)
> > >
> > > --
> > > 2.29.2
> > >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
