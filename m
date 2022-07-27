Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EB5C19F2B
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 16:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 129A98E4E8;
	Wed, 27 Jul 2022 16:32:15 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB5B11B437
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 16:32:14 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id f15so13673623edc.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HrB6m3+rCXZxA0JNnfgCDCh74FRewiPqZoGjL6jYCGM=;
 b=nYLkh2WuoWyZyQ1Q3jcqNrX0y1ys3Tj492iysObN84aGN8CdH3BUuI8z+VvzZzmb5z
 fh0HEkEkVLvFRbgOtSZmP2UnIoungfL6DT1gV4BSLOPkt7+E2bfEY9XCzqXb9E2vP1QL
 WEvGHDE+jB6oRNXIl6h35iIGYdM9Msz6z3nDUu2+NoKYOYDO38qVicuT3bNjfMYjeHby
 e85m5L6c0cP9QfRtZIV9jzp4qQoK07VF+2MknYdn8stQEqL3NegOELCNkfY2CuF0i3XS
 kEalad/Qcj/LUbkvgA3ChEQdBt3v3GkAXTI4oxf0nGsOVCzAcJLY/JcNHP5/ilMvXsxb
 MZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HrB6m3+rCXZxA0JNnfgCDCh74FRewiPqZoGjL6jYCGM=;
 b=Rn61V5wEMaOAfM5rDrcNkiEascPOZ5URWBKW/6CIsCsCz7DuPOOnXRhgViJsrPwZEH
 ITjdxzdn5TRJuUd/l9UaGjkZTWELnpZIZZWbvw4I7iC+Y4ZPnD1LhWT0nJpOq2PbTJ7f
 ImSqxnW9L9EmJteL+9iNVXM5VUYvbey55dznOJDz25r6jos5ruRtMsuq67Qk298FWqQF
 4Jd5aYB7ViSXyxuTW09aaO/erNIXanWatCNJ3iF70SR6YSuXmeQJeE4ScJOVCLqJGG+9
 qfhpqUR3zqPHDKV0riUjHA71a/t6t9LateoflsuT4a5NaFcpjiCYCFIcpRZDfAlx4efa
 q8YQ==
X-Gm-Message-State: AJIora+MGvbwlKCwcKCaEJrlGOQ5OvyK2+nCTcxXi1xIzX8KXuvFTJT7
 wdeQazLnpFAy+Kxe0G9AzvUkP3Nd8rvPq/sl59sfTpZv
X-Google-Smtp-Source: AGRyM1tf7B4s+X5FMr8WT4gd2EQ0ZlbBZcXzQlKDvmNq9wLsrkluGm0r6G2mtaOGO4dUQCLilKllMi0yH1Jn+wlmFUE=
X-Received: by 2002:a05:6402:514a:b0:43b:cb16:9fdf with SMTP id
 n10-20020a056402514a00b0043bcb169fdfmr23887090edd.115.1658939532716; Wed, 27
 Jul 2022 09:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220722175617.2060949-1-Rodrigo.Siqueira@amd.com>
 <CADnq5_MVQUK4cqD8mcOQTupfVR2c6siRyr87pb=BzRgvUG3sQw@mail.gmail.com>
 <20220725073646.068c9cb4@oak.ozlabs.ibm.com>
 <f35f5743-bf62-cc82-3623-b1b09b940cca@amd.com>
In-Reply-To: <f35f5743-bf62-cc82-3623-b1b09b940cca@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Jul 2022 12:32:01 -0400
Message-ID: <CADnq5_OaZuFuczXN0s1vuTRdZ0DZF8a69BV2QYL6Lkp7FR77+A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Reduce stack size in the mode support
 function
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Stephen Rothwell <sfr@rothwell.id.au>, amd-gfx@lists.freedesktop.org,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 27, 2022 at 12:27 PM Rodrigo Siqueira Jordao
<Rodrigo.Siqueira@amd.com> wrote:
>
>
>
> On 2022-07-24 17:41, Stephen Rothwell wrote:
> > Hi all,
> >
> > On Fri, 22 Jul 2022 14:12:44 -0400 Alex Deucher <alexdeucher@gmail.com> wrote:
> >>
> >> On Fri, Jul 22, 2022 at 1:56 PM Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> wrote:
> >>>
> >>> When we use the allmodconfig option we see the following error:
> >>>
> >>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> >>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3799:1: error: the frame size of 2464 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> >>>    3799 | } // ModeSupportAndSystemConfigurationFull
> >>>
> >>> This commit fixes this issue by moving part of the mode support
> >>> operation from ModeSupportAndSystemConfigurationFull to a dedicated
> >>> function.
> >>>
> >>> Cc: Harry Wentland <harry.wentland@amd.com>
> >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> >>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> >>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> >>
> >> Thanks for sorting this out!
> >> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >
> > Also, after applying the above patch, the following commits are no
> > longer needed:
> >
> > 987949933127 drm/amd/display: reduce stack for dml32_CalculatePrefetchSchedule
> > 8f08cd32b767 drm/amd/display: reduce stack for dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport
> > 5d526d124fe3 drm/amd/display: reduce stack for dml32_CalculateVMRowAndSwath
> > f6ceebcc7825 drm/amd/display: reduce stack for dml32_CalculateSwathAndDETConfiguration
> >
> > and could be reverted (or removed).
>
> Ohhh... that's nice!
>
> Alex, if you don't mind, I would prefer to revert the above patches to
> keep things simpler. If it is ok for you, I can prepare the revert patches.

Sure.  Please go ahead.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> Thanks
> Siqueira
