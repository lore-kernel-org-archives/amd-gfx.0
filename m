Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1572C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D92460F39
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D92460F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0725D6E8A7;
	Wed, 27 Oct 2021 14:27:01 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 273286E8A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 14:27:00 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id n7so5015703ljp.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 07:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jp0+d9Qlf5CGiFOkpJikxnWm4De1uspj4ah/Bj6iaaQ=;
 b=RQ8n/OMwleuLTz9/J6YG7lz/RvMZQPGXBx2mBr9bPIZeSr134gnLyzQwzubLN3K6QT
 tArkGqkTY8jQP5ebVnOqcUh2ZhC/JF1pT9z1kbkS/GvtJrxK81JYZX7rLlMr/r57yM7K
 sVXPDGrts/246Wt32n/JV+3qQdBSmivFhwoaA0hmAMueJEYaxj4OH4UapC+53MqksAfa
 rmzvOboQB63WGn5XbG4l0gwHIMqLaLx3jAokLiSu1RTSPv580MFYAuHMG/d14KR9gnEq
 PiSCMGYRf+eW4dxi+ze4o9YZw1Mp55YbLpgSmJrfTcYD/JHuE0eoqXaCHwjHe75zfafp
 KUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jp0+d9Qlf5CGiFOkpJikxnWm4De1uspj4ah/Bj6iaaQ=;
 b=zOa8r4vylWfqqaBRzFZTrhiW7kzDco1ywR0UhTjD6mj5kv+SiTmzoAWLAy/3Tl/ZIb
 UebuTuPz8jcmk1T7xsgrGhhivEBHAkKRRnycTC1TvCy8cd5SBfUEWGciPlxlYB+rw7g2
 vWcY0YK2HEhvKXX1/fiPoeOZ1+qY0tYU2jDwGcLl50dCO3ib/i/StHiLWuXCCQJzUdLI
 VCjj2W2xND6OgoPEqlxUAS61+5lhex0Q+l0irPbpyyT5aMVLWiowvS0gsjnBvlzkzH9C
 4kPUWW2BjEEWBJbvKTDCRJR0/FsaT/Dbq1aaG63W8sZQR2zyMtfftR18ZUSfk9DQG6OD
 qmnw==
X-Gm-Message-State: AOAM530LfRpo/yb8CRu2GYhitHKROIF+/caURbJ8LtQNVuRtVZuwjgJq
 bWUyXiUHs7Om3EjkluPlNjq84ZHa+fRpvE+kunE=
X-Google-Smtp-Source: ABdhPJxRXpvZbbZDpzNv1mOeZxzIjf+8ePbzA4dngQZFdOL2iA4U0xbtnFNA7N3A2UUrCHAjGwlfDFBhfQ0A+VBXKEI=
X-Received: by 2002:a2e:918b:: with SMTP id f11mr10160688ljg.32.1635344818356; 
 Wed, 27 Oct 2021 07:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211027130312.28383-1-patrik.r.jakobsson@gmail.com>
 <c0744024-bd4c-3849-d218-053377c28b44@amd.com>
In-Reply-To: <c0744024-bd4c-3849-d218-053377c28b44@amd.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Wed, 27 Oct 2021 16:26:46 +0200
Message-ID: <CAMeQTsai8OCjnRQeAMZTKo4DFvGqUPF1__PFxzOzi24iXRMOTg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix even more out of bound writes from debugfs
To: Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org, tdwilliamsiv@gmail.com, 
 Alex Deucher <alexdeucher@gmail.com>, Patrik Jakobsson <pjakobsson@suse.de>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 27, 2021 at 3:47 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2021-10-27 09:03, Patrik Jakobsson wrote:
> > CVE-2021-42327 was fixed by:
> >
> > commit f23750b5b3d98653b31d4469592935ef6364ad67
> > Author: Thelford Williams <tdwilliamsiv@gmail.com>
> > Date:   Wed Oct 13 16:04:13 2021 -0400
> >
> >     drm/amdgpu: fix out of bounds write
> >
> > but amdgpu_dm_debugfs.c contains more of the same issue so fix the
> > remaining ones.
> >
> > Fixes: 918698d5c2b5 ("drm/amd/display: Return the number of bytes parsed than allocated")
> > Signed-off-by: Patrik Jakobsson <pjakobsson@suse.de>
> > ---
> >  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c    | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > index 1a68a674913c..33bdf15febc6 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > @@ -491,7 +491,7 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
> >       if (!wr_buf)
> >               return -ENOSPC;
> >
> > -     if (parse_write_buffer_into_params(wr_buf, size,
> > +     if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> >                                          (long *)param, buf,
> >                                          max_param_num,
> >                                          &param_nums)) {
> > @@ -643,7 +643,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
> >       if (!wr_buf)
> >               return -ENOSPC;
> >
> > -     if (parse_write_buffer_into_params(wr_buf, size,
> > +     if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> >                                          (long *)param, buf,
> >                                          max_param_num,
> >                                          &param_nums)) {
> > @@ -918,7 +918,7 @@ static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
> >               return -ENOSPC;
> >       }
> >
> > -     if (parse_write_buffer_into_params(wr_buf, size,
> > +     if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> >                                          &param, buf,
> >                                          max_param_num,
> >                                          &param_nums)) {
> > @@ -1215,7 +1215,7 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
> >               return -ENOSPC;
> >       }
> >
> > -     if (parse_write_buffer_into_params(wr_buf, size,
> > +     if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> >                                               (long *)param, buf,
> >                                               max_param_num,
> >                                               &param_nums)) {
> > @@ -1400,7 +1400,7 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
> >               return -ENOSPC;
> >       }
> >
> > -     if (parse_write_buffer_into_params(wr_buf, size,
> > +     if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> >                                           (long *)param, buf,
> >                                           max_param_num,
> >                                           &param_nums)) {
> > @@ -1585,7 +1585,7 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
> >               return -ENOSPC;
> >       }
> >
> > -     if (parse_write_buffer_into_params(wr_buf, size,
> > +     if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> >                                           (long *)param, buf,
> >                                           max_param_num,
> >                                           &param_nums)) {
> > @@ -1770,7 +1770,7 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
> >               return -ENOSPC;
> >       }
> >
> > -     if (parse_write_buffer_into_params(wr_buf, size,
> > +     if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> >                                           (long *)param, buf,
> >                                           max_param_num,
> >                                           &param_nums)) {
> > @@ -1948,7 +1948,7 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
> >               return -ENOSPC;
> >       }
> >
> > -     if (parse_write_buffer_into_params(wr_buf, size,
> > +     if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> >                                           (long *)param, buf,
> >                                           max_param_num,
> >                                           &param_nums)) {
> >
>
>
> Thanks. This looks good but you seem to be missing another
> instance of this in dp_max_bpc_write.

Oops, will fix in v2

>
> We'll also want to Linus's suggestion in [1] but I can post
> another patch for that.
>
> https://lkml.org/lkml/2021/10/26/993
>
> Harry
>
