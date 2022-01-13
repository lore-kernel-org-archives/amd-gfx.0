Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745C9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 13:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B566B1124FB;
	Thu, 13 Jan 2022 13:44:31 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F1A1124FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 13:44:30 +0000 (UTC)
Received: by mail-yb1-xb2e.google.com with SMTP id d7so15047217ybo.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 05:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t4iOUVFv53bNQSQ/gO0aroSu848/nmRUJMS9RO8UVKs=;
 b=L3t/7x5E6+oOdmCJJKKVoRGWTgQRkrBeAvTi/BR6XX6Q5XLRVBspgMP0moqqe1UGKu
 ddfQ5RrHcPahfVgeYOmn5AHJlMWc+TOAeWBWMgyMUnrivvh+PMMHgT209bAyuKNQKk3P
 k5e1boYAvB/kJ+LnMsQsDhZiHUXhb1sNYO6pAdHkXjVzD2b9imk89CO5pjBTJ1gRqmjn
 1rGkYILN48K3Xm/0nFyBivNcRKr+prkJFgLFQudXjewMCIb583bksfZpHF2EAupjIetP
 8tVVIFo+S6Vc8JE8qXdS6cSLm37UHqx/W5t6Ee+cWLutbIkIgEgGhIgQ0VWxA2nXMH26
 UgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t4iOUVFv53bNQSQ/gO0aroSu848/nmRUJMS9RO8UVKs=;
 b=O8BVcPw/0oTtmjr3AzurY7Rd8NJ7WRW0+UvaIO1rbRjaKIEYim46bXPF+iW2mammqw
 sCFiSxdKv/7p0rOa6g2Z3VV4rffIJ5zewR14VwHw0tn+NggYvqe1HRmMqqJauILS2bsP
 Jw4KT8/KwGuVNU+c1MxhENwU0MnEtrtKWR2z3Puvs4dEbwCy1dlmP/DfY59O+ALHAx+u
 4Q9eDHOo0DovZISEg4dxJBirzYwAIEqSLJWQTg+lCa8PXEZ4pc8K0qeXtBGGeb2AIYdl
 SVgGsCKCHKydqySa6CkfFLzX7FulYIPeDT0kJ1ysj6XLhT+P85BZFSLobUeQ99N1QAjS
 iUpg==
X-Gm-Message-State: AOAM531FNEQmYCJ1LXJTno6Ui2azW07IEBQK7g0G2Jg0Krul7hN6nzUu
 neFuUhsmo8Ajfy/UQDbuNARx4hUzkwbIz2K2t9yddQ==
X-Google-Smtp-Source: ABdhPJwo6URqBePslK+oKLzNiKNduFsi241hMu0BUXNptg5RSut3Cj4rzAH5lLArTqXi4SXz//NaTZwj4mHiagIizJ4=
X-Received: by 2002:a25:7b44:: with SMTP id w65mr5871202ybc.59.1642081469812; 
 Thu, 13 Jan 2022 05:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20220113094419.12433-1-etom@igel.co.jp>
In-Reply-To: <20220113094419.12433-1-etom@igel.co.jp>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 13 Jan 2022 13:44:18 +0000
Message-ID: <CAPj87rPk3_8LdnwWJ3BhtJnRuR+_WHg2hfdgK2R4SMacPGCrUQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Add support modifiers for drivers whose planes
 only support linear layout
To: Tomohito Esaki <etom@igel.co.jp>
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
Cc: David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Lee Jones <lee.jones@linaro.org>, Rob Clark <robdclark@chromium.org>,
 Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org,
 Ben Skeggs <bskeggs@redhat.com>, Petr Mladek <pmladek@suse.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Abhinav Kumar <abhinavk@codeaurora.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Takanari Hayama <taki@igel.co.jp>, Sean Paul <seanpaul@chromium.org>,
 Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mark Yacoub <markyacoub@chromium.org>, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>, Simon Ser <contact@emersion.fr>,
 Alex Deucher <alexander.deucher@amd.com>,
 Damian Hobson-Garcia <dhobsong@igel.co.jp>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Esaki-san,

On Thu, 13 Jan 2022 at 09:44, Tomohito Esaki <etom@igel.co.jp> wrote:
> Some drivers whose planes only support linear layout fb do not support format
> modifiers.
> These drivers should support modifiers, however the DRM core should handle this
> rather than open-coding in every driver.
>
> In this patch series, these drivers expose format modifiers based on the
> following suggestion[1].

Thanks for the series, it looks like the right thing to do.

Can you please change the patch ordering though? At the moment there
will be a bisection break at patch #1, because the legacy drivers will
suddenly start gaining modifier support, before it is removed in patch
#2.

I think a better order would be:
  1: add fb_modifiers_not_supported flag to core and drivers
  2: add default modifiers (and set allow_fb_modifiers) if
fb_modifiers_not_supported flag is not set
  3: remove allow_fb_modifiers flag

Cheers,
Daniel
