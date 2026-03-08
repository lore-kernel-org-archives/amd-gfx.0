Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B921DF3C246
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 12:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6136610E4EF;
	Mon,  9 Mar 2026 12:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HmIT16LF";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B147E10E192
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Mar 2026 23:41:06 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-79800183233so149006807b3.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 08 Mar 2026 16:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773013265; cv=none;
 d=google.com; s=arc-20240605;
 b=epz5WxNDW1WYavKSm/YBlp0ZjZQ2n4tYAmWprYjbX05AC5b6wEWYkgJbe1ith9/UQ0
 JOwHWgCD1NDwrogLv//LJaA/0jq9HJgjW6HA+oUh6l9UiU+Rc34vN7856n31qyicfQq7
 rbJHeqroDQJXUWiiZOjvMO5n8Nqv0zTrnE4yQgZHYxHejnwZJEv/rGXXPxr8dSwdvJ2l
 73hqYEIz4/1H7z4QdZucLjmsNL+2QrRjO+4DbNu3UF1Dfp7sXzCwd2eR0tz3Fi+NuvkH
 S0Ea1To6tNs8Wi8zp070HOAGuFcxHy0ALb9E3npBNevCGOyRUQyPpZLOfSkHf/cunEkl
 a/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NQXx8uu4M0KLxzrAzxI+jDa08vrKCalXPwY/Drji+ig=;
 fh=d35FljiJ6NQXgE1y97s0zrmg4Oma7hPQFM/mXvlIwD4=;
 b=T3LHsOZ1o++j1SgjLWOZMTgb9ydKzKGC0THiJipLy8CA+aqscPZAHFTAPeeEFoCcwY
 sRJ9c0Ba/4Ov4lHipj4/An6SFlH4YhkFjn9JKPRgkolk6KIsKYs+Q4VTrNEgC54MEMSp
 tpL6o9xXJvgZP3IKXQrNSeB3le8Vw/HYDii9nmy2UqAYdT9X51LC+1GdAJqNK1VcCjjf
 3lQsI5pNQiE1QvE5kMErANtwS8n8AACKCnZORrcCtaEV1net6BymbUcEvoL2+cU6IELf
 S48th2d9go3rOdvIcyXQFod6JoRRbin7dd3qxonl0CE8JGfQIDSnI9BYyLmUP8N8aBKe
 orbA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773013265; x=1773618065; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQXx8uu4M0KLxzrAzxI+jDa08vrKCalXPwY/Drji+ig=;
 b=HmIT16LFy3Qc/SOnEcRnxP4IrWF+j9Aa+zL/2QLaSO65+fjW3+i/5v1r4bg0PwL20O
 SCRaABU72ttJx+zdeptUMhqX6nKt6yr43x4Bh+aYcjOsz1CL8+NVAN37WrpaP0C8Xlto
 y0kpD7g2k1FWbd/9G/bneubiJ07nJnfRRoWClWLlHc2UHKXUzpQopVat2icoAZ9nnb6d
 1IC0cU1jqViTsmFZq9WdLdWkGRWV71ov+EeppvnoV5XB8RW9/JtFPvG+4Oh4Jm/Tfsqc
 dKG4O7yGVR6H6IQFuyc53HjEVqf7WmWZhim45WgjJY5o1PS2fAzuVZpQ6zOckwBn1EO1
 GUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773013265; x=1773618065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NQXx8uu4M0KLxzrAzxI+jDa08vrKCalXPwY/Drji+ig=;
 b=XUQk1gaOSerTBB3U6RlHl/5ZbLHnid0c1RSCtZyp0EpkosP0pe1SIsj2tGufHoXN0D
 rqxul9ViDPLTpgzDMnwQs1+OgQd2MZS6iI1EasJk4vCZ8kiXkJXH44PFxweeKG6Yw6Mn
 GeyXJqcMHVoLRyAfrmgpjWyEOwzcvpwILNIWTWlGYELlAkaZqZAGl/xjd9h9ZB2WWF7b
 cKyKgY8wplX5LAgyz0Fel94rBTKUni2vL03gR9MKayFOnO5cN2RMbkv8bqTABT8S6nyt
 GCZWP26gRekhjyJuufuEschY08pvbcaChh6YqdiIAkUdhZU53ctsxOUVebX/7ni4U+yK
 lm3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB0DOp496RfSh8fN6mQDEYcOiR5xnxz6w+QLYdT4sNneIjv5162hmM9Tdrkudn0oZgNadfKyh1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjbjKF0F+dLcgUGQAq3lEXuYALNougqIDpUzb/SZU9ESk/NKUh
 cNvHSY8VvWmgbH3Nam0ds06yg89o4boxbzgmWXczPdDKPn5kUI9nA/Fpf8Y0j8RAG74HJsR68Yp
 Uy6UYRkoathBUN2ihk5Bzo3fnomjKxGo=
X-Gm-Gg: ATEYQzyCQaLhPs5GMC2eu9mZvAefKetnY8OqcttIt2UGtPUi4pnzwH5Og/+EA+QEWWn
 5TCpcnIwbgNAirtEr8N5nDwOE0eWqJd0oaBakr0yHOAPRtbsGG+n0wCYSXnkZ/tC67ESmK9rTLk
 8ASXWROJXKIWy44qO+ykBCkl6C9NBug1hEi+zVsASPhFIvfNxQyAInyEH4+ts8ySOxT6Czw/HzD
 6QWVVAEWDo1/ne+P2L86afQ/HGTZIYCYgCddIam84MEFOD5PvTj1VfgKqx5+7nHcaxad+rhy5ct
 mSZD
X-Received: by 2002:a05:690c:c50f:b0:796:4486:b7d0 with SMTP id
 00721157ae682-798dd6a9c02mr86884167b3.4.1773013265400; Sun, 08 Mar 2026
 16:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250125064619.8305-1-jim.cromie@gmail.com>
 <2025022012-viscous-cringing-bf88@gregkh>
In-Reply-To: <2025022012-viscous-cringing-bf88@gregkh>
From: jim.cromie@gmail.com
Date: Sun, 8 Mar 2026 17:40:39 -0600
X-Gm-Features: AaiRm53r_scJ1hz_hrqKtTTL_x76n0lj7hLnJSP7FySmjXt2VLjJSlLhS6vTW4o
Message-ID: <CAJfuBxyqemd2FipDjt0TNo0KOG1XcnX1X9MJYnt80Zy2-6rPXw@mail.gmail.com>
Subject: Re: [PATCH 00/63] Fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, jbaron@akamai.com, ukaszb@chromium.org, 
 intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch, 
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
 ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 09 Mar 2026 12:57:16 +0000
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

On Thu, Feb 20, 2025 at 1:31=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Jan 24, 2025 at 11:45:14PM -0700, Jim Cromie wrote:
> > This series fixes dynamic-debug's support for DRM debug-categories.
> > Classmaps-v1 evaded full review, and got committed in 2 chunks:
> >
> >   b7b4eebdba7b..6ea3bf466ac6  # core dyndbg changes
> >   0406faf25fb1..ee7d633f2dfb  # drm adoption
> >
> > DRM-CI found a regression during init with drm.debug=3D<initval>; the
> > static-keys under the drm-dbgs in drm.ko got enabled, but those in
> > drivers & helpers did not.
> >
> > Root Problem:
> >
> > DECLARE_DYNDBG_CLASSMAP violated a K&R rule "define once, refer
> > afterwards".  Replace it with DYNDBG_CLASSMAP_DEFINE (invoked once in
> > drm-core) and DYNDBG_CLASSMAP_USE (invoked repeatedly, in drivers &
> > helpers).
> >
> > _DEFINE exports the classmap it creates (in drm.ko), other modules
> > _USE the classmap.  The _USE adds a record ref'g the _DEFINEd (&
> > exported) classmap, in a 2nd __dyndbg_class_users section.
> >
> > So now at modprobe, dyndbg scans the new section after the 1st
> > __dyndbg_class_maps section, follows the linkage to the _DEFINEr
> > module, finds the (optional) kernel-param controlling the classmap,
> > examines its drm.debug=3D<initval>, and applies it to the module being
> > initialized.
> >
> > To recapitulate the multi-module problem wo DRM involvement, Add:
> >
> > A. tools/testing/selftests/dynamic_debug/*
> >
> > This alters pr_debugs in the test-modules, counts the results and
> > checks them against expectations.  It uses this formula to test most
> > of the control grammar, including the new class keyword.
> >
> > B. test_dynamic_debug_submod.ko
> >
> > This alters the test-module to build both parent & _submod ko's, with
> > _DEFINE and _USE inside #if/#else blocks.  This recap's DRM's 2 module
> > failure scenario, allowing A to exersize several cases.
> >
> > The #if/#else puts the 2 macro uses together for clarity, and gives
> > the 2 modules identical sets of debugs.
> >
> > Recent DRM-CI tests are here:
> >   https://patchwork.freedesktop.org/series/139147/
> >
> > Previous rev:
> >   https://lore.kernel.org/lkml/20240716185806.1572048-1-jim.cromie@gmai=
l.com/
> >
> > Noteworthy Additions:
> >
> > 1- drop class "protection" special case, per JBaron's preference.
> >    only current use is marked BROKEN so nobody to affect.
> >    now framed as policy-choice:
> >    #define ddebug_client_module_protects_classes() false
> >    subsystems wanting protection can change this.
> >
> > 2- compile-time arg-tests in DYNDBG_CLASSMAP_DEFINE
> >    implement several required constraints, and fail obviously.
> >
> > 3- modprobe time check of conflicting class-id reservations
> >    only affects 2+classmaps users.
> >    compile-time solution not apparent.
> >
> > 4- dyndbg can now cause modprobe to fail.
> >    needed to catch 3.
> >    maybe some loose ends here on failure.
> >
> > 5- refactor & rename ddebug_attach_*module_classes
> >    reduce repetetive boilerplate on 2 types: maps, users.
> >    rework mostly brought forward in patchset to reduce churn
> >    TBD: maybe squash more.
> >
> > Several recent trybot submissions (against drm-tip) have been passing
> > CI.BAT, and failing one or few CI.IGT tests randomly; re-tests do not
> > reliably repeat the failures.
> >
> > its also at github.com:jimc/linux.git
> >   dd-fix-9[st]-ontip  &  dd-fix-9-13
> >
> > Ive been running it on my desktop w/o issues.
> >
> > The drivers/gpu/drm patches are RFC, I think there might be a single
> > place to call DRM_CLASSMAP_USE(drm_dedbug_classes) to replace the
> > sprinkling of _USEs in drivers and helpers.  IIRC, I tried adding a
> > _DEFINE into drm_drv.c, that didn't do it, so I punted for now.
> >
> > I think the dyndbg core additions are ready for review and merging
> > into a (next-next) test/integration tree.
>
> So whose tree should this go through?
>

If you'll have it, I'll send you the non-drm parts now.
Or the whole thing, and you can take the front half.
perhaps its too late for this cycle, but you can send it to linux-next IIUC=
.

This would free Lukas Bartosik to rework his dyndbg-to-tracefs patchset on =
top.
It has the nice feature of private tracefs buffers, allowing to
isolate drm.debug
messages there.  It also enables strong verification in selftests, by ensur=
ing
that no unrelated log-msgs get into the private tracebuf.


Ive been banging on DRM-CI, with some success.
Hopefully enough demonstrated soon to overcome the inertia.
https://gitlab.freedesktop.org/jim.cromie/kernel-drm-next-dd.git

Some tests on i915 timed out and failed, cuz toggling up to 1800
drm-dbg callsites with dyndbg took 800 ms when 150 ms was expected.
I have a fork of IGT adding time-dilation when drm-dbgs with classes
are found in dynamic_debug/control.  An alternate approach batches
256 static-key toggles in 1 IPI (by sorting rather than flushing on
out-of-order addys).
This cuts IPIs to 1/170, but is RFC, and only sorted on x86.



> And I think the last patch in this series isn't correct, it looks like a
> 000 email somehow.
>

IIRC, that was me trying to get a merge-message or something like it.


> thanks,
>
> greg k-h
