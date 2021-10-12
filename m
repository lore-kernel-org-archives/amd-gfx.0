Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9570C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 19:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C0C60698
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 19:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 82C0C60698
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E97C89350;
	Tue, 12 Oct 2021 19:57:39 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B66CE89350
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 19:57:37 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 p6-20020a9d7446000000b0054e6bb223f3so791289otk.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 12:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FaUwCZw/x8O1sptG5ZkAI6qhDpYyX9R3wwDyeoYpEi8=;
 b=HJhubSdroNiPu4/DeJaQy+sVhiNGlE3Ga25k1BVOztMNZ5gnAYam/pNmyM7odAiCvd
 kW43YMFA/p2SYXaX1FQ+KJCRk3uzR3dO3j9VnbQoBempa8rv6eT7qDhPk6SJd0/ynMSv
 pCE9uzFsTGTlwUtrJc5CLOsfZmSywsidkQG0gAEuRlYdCoD0tKa+2puKUX5i24bkHbm/
 zeQDpXRg7zJZ/5BaS3apZlm2CI1yBh+fWdRoj+zn9yiPEFQQTVau7/XVyJX7vRxMox01
 RgErz+/oPy2zDl4BQJfHCcZX+lGp6kAU/5Sv3Ek80m5sJbDl+nNuUETzdUx7O7gBYxNY
 /X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FaUwCZw/x8O1sptG5ZkAI6qhDpYyX9R3wwDyeoYpEi8=;
 b=DEZRKh9cPLSALR+DugWPlTXm9r6OQLnjsl6CKuZC7wi9yNwPYK8Qbw/zjfb7V4H9cW
 P1cHIVgbkmMy0p4nqDqwbBqmqNJXPhUjr5hOVjUeddeu7760+rXNDeL5534nBNXUkKvk
 0jj8vvwKq0FXDxcNN+PBwycNDm+/ELtG1j52BdY6KOZbsfIleh16rYUOxjHbqv+sBYae
 v19lGHb+SZGVLtcZ4zJfIdyRabovHk0ygOvAd23s8GDjBr7Lmojt6mt5rJ9r7uibnIgj
 Rl3/FaO36NMR4GF8nJt2gsG5ffp/zT1p1d73SyEwsvaeaoyfEUbuLPhuyu5m5SlyMzSr
 +cPA==
X-Gm-Message-State: AOAM5312q5/tLHxTX8pLcTlrP2s7YRz1eUsBhdYJhj4vAyU1n+VOiwhN
 /wRYdR0P0zQ+H0S5odU7ZR9nFmVmxahJLxhn+KI=
X-Google-Smtp-Source: ABdhPJx62aFBK9zXRypYhFaVnTCAN2O2iccqmzCj9eq+y0IDbE7azPTXn/RlSYmKGaNJeky2PyX+zyqbbCLQFiB2gvA=
X-Received: by 2002:a9d:718e:: with SMTP id o14mr1985820otj.299.1634068657055; 
 Tue, 12 Oct 2021 12:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211011151609.452132-1-contact@emersion.fr>
 <44154452-aa21-3f08-ffe8-e68fb8036271@amd.com>
In-Reply-To: <44154452-aa21-3f08-ffe8-e68fb8036271@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Oct 2021 15:57:25 -0400
Message-ID: <CADnq5_M-13Sf1g4cw0Qt=qps72GEweZM-SrhQ9obLRsVr8_zfQ@mail.gmail.com>
Subject: Re: [PATCH v5] amd/display: only require overlay plane to cover whole
 CRTC on ChromeOS
To: Harry Wentland <harry.wentland@amd.com>
Cc: Simon Ser <contact@emersion.fr>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Sean Paul <seanpaul@chromium.org>
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

On Tue, Oct 12, 2021 at 10:39 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-10-11 11:16, Simon Ser wrote:
> > Commit ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when
> > using overlay") changed the atomic validation code to forbid the
> > overlay plane from being used if it doesn't cover the whole CRTC. The
> > motivation is that ChromeOS uses the atomic API for everything except
> > the cursor plane (which uses the legacy API). Thus amdgpu must always
> > be prepared to enable/disable/move the cursor plane at any time without
> > failing (or else ChromeOS will trip over).
> >
> > As discussed in [1], there's no reason why the ChromeOS limitation
> > should prevent other fully atomic users from taking advantage of the
> > overlay plane. Let's limit the check to ChromeOS.
> >
> > v4: fix ChromeOS detection (Harry)
> >
> > v5: fix conflict with linux-next
> >
> > [1]: https://lore.kernel.org/amd-gfx/JIQ_93_cHcshiIDsrMU1huBzx9P9LVQxucx8hQArpQu7Wk5DrCl_vTXj_Q20m_L-8C8A5dSpNcSJ8ehfcCrsQpfB5QG_Spn14EYkH9chtg0=@emersion.fr/>>
> > Signed-off-by: Simon Ser <contact@emersion.fr>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > Cc: Sean Paul <seanpaul@chromium.org>
> > Fixes: ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when using overlay")
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

@Harry Wentland, @Simon Ser Do you have a preference on whether we
apply this patch or revert ddab8bd788f5?  I'm fine with either.

Alex

>
> Harry
>
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index f35561b5a465..2eeda1fec506 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -10594,6 +10594,31 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
> >  }
> >  #endif
> >
> > +static bool is_chromeos(void)
> > +{
> > +     struct mm_struct *mm = current->mm;
> > +     struct file *exe_file;
> > +     bool ret;
> > +
> > +     /* ChromeOS renames its thread to DrmThread. Also check the executable
> > +      * name. */
> > +     if (strcmp(current->comm, "DrmThread") != 0 || !mm)
> > +             return false;
> > +
> > +     rcu_read_lock();
> > +     exe_file = rcu_dereference(mm->exe_file);
> > +     if (exe_file && !get_file_rcu(exe_file))
> > +             exe_file = NULL;
> > +     rcu_read_unlock();
> > +
> > +     if (!exe_file)
> > +             return false;
> > +     ret = strcmp(exe_file->f_path.dentry->d_name.name, "chrome") == 0;
> > +     fput(exe_file);
> > +
> > +     return ret;
> > +}
> > +
> >  static int validate_overlay(struct drm_atomic_state *state)
> >  {
> >       int i;
> > @@ -10601,6 +10626,10 @@ static int validate_overlay(struct drm_atomic_state *state)
> >       struct drm_plane_state *new_plane_state;
> >       struct drm_plane_state *primary_state, *overlay_state = NULL;
> >
> > +     /* This is a workaround for ChromeOS only */
> > +     if (!is_chromeos())
> > +             return 0;
> > +
> >       /* Check if primary plane is contained inside overlay */
> >       for_each_new_plane_in_state_reverse(state, plane, new_plane_state, i) {
> >               if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
> >
>
