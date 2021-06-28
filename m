Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76395C49EA3
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 16:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DDC61C65
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 16:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DDC61C65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2751C6E4B6;
	Mon, 28 Jun 2021 16:39:06 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02CE6E0A5;
 Mon, 28 Jun 2021 16:39:04 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 d21-20020a9d72d50000b02904604cda7e66so17640708otk.7; 
 Mon, 28 Jun 2021 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dzETNv4uyDhuYHJGELa+ExcxyxQjGe2pv/stbKqgYMw=;
 b=rBenLrIuJvtaIysQfKhnjr14lj+L8avGymkeyl2Kyk5vGXN2R2ZoQZPHPQ7ExWAk3Y
 yL+pi2ALV/47YsUPRCkvmBi3C0gFZJdvv2BMtGxj/7UGql6F4EcIv+nKxIseax3bagZf
 T74nScYy0afGUWmzWwZSV7ag4jRiYsg0VdYVMAwEhd3YrS+v/RQsVkFSb7or7n5vd6PW
 bFpt+Nq+mZvF/9cSpnkyXoFsxY3ygqAIRXG7Pxmg86DG1XGwOPZA28HHtlrpKmJKz6o5
 +w7oUK0hqy4Wtx72SJnMmruTs8zEKNl3uM80qaAlO7NE2fciTXdroF+fhEXtU7pNukXJ
 0hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dzETNv4uyDhuYHJGELa+ExcxyxQjGe2pv/stbKqgYMw=;
 b=jIXW0benls8AUo0l2r88fQCfxdr6sw7oTmlGd6KU5AULv9coaciB/C8vHNE6JUHz1u
 iXpf1gCeezEHbYRUVXKGtJZXF7gSiyAojJ44yQanOX8g48e7I/rfUcsVmaNr4fI63dr1
 +Y7K/10dIIElNju+uuNz4L1N/CxMYg/koT1OBfJALYxKb7w6uJk2HWLcFkjQtyRiwIEd
 ktpcYi2wqdXTSR9Sql+H6MBBWYzzvn3qQSXKksokAgu6E/s9TruSsYxlKZfo5QNuvV6A
 UwTyk4yGnZxh44gpL40mG4zokwj8KHlS0D9RpIKjRmAamDprQkg1xRw0eGFLgh/6OB7B
 cvgA==
X-Gm-Message-State: AOAM533X/EVUFHMfyE/Qmj07vP3ZLdbSnvBCfa01OEZUFWUUWtZIc8le
 p/1sqaIW5hGMujFo1Lm4bxPlZd976cS0Fts7/rM=
X-Google-Smtp-Source: ABdhPJzYRZG+BMW6R3nKjH+PGAeE2fWVuPRA4R5Z/llGtbaSglDGzXmuYL/A81nL+/pjaKCm3iK3ZnT4JtzU94FalS8=
X-Received: by 2002:a05:6830:4119:: with SMTP id
 w25mr432485ott.132.1624898343968; 
 Mon, 28 Jun 2021 09:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210623103039.9881-1-msuchanek@suse.de>
 <6ae69103-b01f-4f16-7cd2-845ea991ae95@amd.com>
In-Reply-To: <6ae69103-b01f-4f16-7cd2-845ea991ae95@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jun 2021 12:38:53 -0400
Message-ID: <CADnq5_OcurGjMshexjUO58+7n0vxvvyn7wozPnVM-ArGCEovzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dc: Really fix DCN3.1 Makefile for PPC64
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Leo Li <sunpeng.li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Michal Suchanek <msuchanek@suse.de>, Will Deacon <will@kernel.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Fri, Jun 25, 2021 at 4:14 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-06-23 6:30 a.m., Michal Suchanek wrote:
> > Also copy over the part that makes old gcc handling cross-platform.
> >
> > Fixes: df7a1658f257 ("drm/amdgpu/dc: fix DCN3.1 Makefile for PPC64")
> > Fixes: 926d6972efb6 ("drm/amd/display: Add DCN3.1 blocks to the DC Makefile")
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> > The fact that the old gcc handling triggers on gcc 10 and 11 is another
> > story I don't want to delve into.
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn31/Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
> > index 5dcdc5a858fe..4bab97acb155 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
> > @@ -28,6 +28,7 @@ endif
> >  CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o += -mhard-float
> >  endif
> >
> > +ifdef CONFIG_X86
> >  ifdef IS_OLD_GCC
> >  # Stack alignment mismatch, proceed with caution.
> >  # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> > @@ -36,6 +37,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o += -mpreferred-stack-boundary=4
> >  else
> >  CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o += -msse2
> >  endif
> > +endif
> >
> >  AMD_DAL_DCN31 = $(addprefix $(AMDDALPATH)/dc/dcn31/,$(DCN31))
> >
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
