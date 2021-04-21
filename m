Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B1FC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 21:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA75613ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 21:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA75613ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F366E9F8;
	Wed, 21 Apr 2021 21:43:08 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F3E6E9F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 21:43:07 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 v19-20020a0568300913b029028423b78c2dso31639860ott.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 14:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GNds24Ijg5eNudf1Eg6KbwgYVV7LY0yZ94P0FtpFLRU=;
 b=fxxbT9kpPsQYEhkKXy3imwJEdkbE2g85gFKFvsmOAwpoxPUrtKaP4HQEMxH+RCeMIk
 sYUjykRZ1k8n3/Kh9Yp2aH86p4OxiplR9/tmc2bY/HdsRK9/qf7ZJf1VdkFl8hmh+PdJ
 Y8LV27c9NgIvD0G7LKOiHR8xUWoCTKjN574uDuWi36Dsm6exjDDgSJjux5Uefc7HW4IJ
 kqKVj29Tf91rrlJkLxrathB/hvzkNn9+FpqJIneL0g/6BjZO3+RMJsvxuZTmXX7xTTMm
 5Lig2QM5EA7lN8RI3BJxMDJubemUI2HviZ9NFcSoDLlGduEMAsgwjcQMa+qAII1TAOpU
 /NmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GNds24Ijg5eNudf1Eg6KbwgYVV7LY0yZ94P0FtpFLRU=;
 b=IBkYU/jCMvIWg3Dp12vEQnEky+6TgL6taOSnRwSnseBN0K84J3qE2gXett9tegi7nK
 /0k+0ImnZG+cRWpff5LnFII86hJzoR0u4YpcWQLhxsOPZFL1CaMyOpsQ5lH0oKyVxoV7
 JNmFKJ72y0GEpY8st02CyLNAe1hdp26NSgKpJUrsif2JQdLdvUNN3k5AAgN/bQ8kjToA
 q/+hzM7IVap4x8tf118E3Vtlp5U08eU5GQBC8g4Kd9WRYkVwagkcMjxlDJX8yK6u+5rR
 chEzuEAjj9M6YnKO1r1hg7YX3Th2xXXoY7j0iUJMQp8rXg4RjJd+0fIB8VCL7koWtt+l
 io5g==
X-Gm-Message-State: AOAM532YGEUGebJ0EJ+H/lZFk2zvfyfInnd2T8Ks9qV/KvF/vjsk+Jex
 VtJGrzwKKbsy4F7V+ARkGlYqu4nZSKhTx8COY0o=
X-Google-Smtp-Source: ABdhPJzSQC/aft46nkekP3y5p1GaG44x7TBg8nhAl/a2NWFgkpiPd3yrOGdf4aa9h+hVRFcHAfA/tW+p9BPCffFDoyA=
X-Received: by 2002:a9d:75c4:: with SMTP id c4mr176559otl.311.1619041386916;
 Wed, 21 Apr 2021 14:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAAqfY0shOhS_eRytBoHX9Sp-Hxh77TUYeKqYMtwbwxyrpm4tYw@mail.gmail.com>
In-Reply-To: <CAAqfY0shOhS_eRytBoHX9Sp-Hxh77TUYeKqYMtwbwxyrpm4tYw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Apr 2021 17:42:56 -0400
Message-ID: <CADnq5_PJuysiwUrYSVoCCuztYh_RSFN98-GXKKBc_aNwLFwQAA@mail.gmail.com>
Subject: Re: RTX 6800 XT 4K120 problems
To: Julian Picht <julian.picht+amdgfx@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 21, 2021 at 5:35 PM Julian Picht
<julian.picht+amdgfx@gmail.com> wrote:
>
> Hi all,
>
> I recently purchased a 4K120Hz display and am currently trying to get it fully working. It's connected via HDMI 2.1, because it does not have a DisplayPort input.
>
> I'm on 5.12-rc8, and it seems that the modes are not detected correctly, the driver defaults to YCbCr modes (with chroma sub-sampling) which makes everything look weird, blocky and broken.
>
> I've patched in a debug fs flag to force RGB-mode which works fine up to 4k60, anything higher and the display detects the signal as YCbCr anyways (false color mode looks interesting, but not very useful).
>
> I've tested the GPU+display combination on W10 - works fine up to 4K120 HDR (RGB 10Bit).
>
> I'm happy to help implementing / fixing this.
>
> My current suspects are: pixel clock limitations, and edid parser. Can anyone tell me if I'm on the right track? Would me trying to do this interfere with anything else that somebody is working on?
>

HDMI 2.1 is not supported in open source drivers due to the fact that
HDMI Forum does not make the 2.1 spec publicly available.  There is
not much we can do until that changes.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
