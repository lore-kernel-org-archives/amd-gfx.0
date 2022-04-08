Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF301C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 11:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FBD010EF3A;
	Fri,  8 Apr 2022 11:28:29 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A7410EF3A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 11:28:27 +0000 (UTC)
Received: by mail-yb1-xb34.google.com with SMTP id x21so14532185ybd.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Apr 2022 04:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ixi8kZe3SkhTQxe+wXeMeIxrtbGzlOxLmNLbF+cZC8M=;
 b=JC/JLxvdznj2flCGhE/ltsXvXoWICpPPcZVAc4nW/hIHqnRvzJNB0Djd9odaS3YkfV
 s7aspmSbK8nu1lhQj0rQcmzyNOBf11KgGcACQNMYUITCRoOPSaTHtBKBtYiSppKmbIHg
 79M4wAqawm6e81OjbTeIDHjoSSDr5I1WSqTQlKJOS20EBWB7SF2O5DSc6brgdosF2zkB
 VbrGxDeYyx7ZWsOy1ZBfoJCiqP8pOC4IEHZhP1jEO9lc6jF5xxO0NeNu7+29zOtTl2Sx
 RJcldomKk4zPxcBPtRPr9CH+LPdC6JbNgeblwnmgGh/LUavVVJLGHVJfFLN8kqTzMdaK
 sGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ixi8kZe3SkhTQxe+wXeMeIxrtbGzlOxLmNLbF+cZC8M=;
 b=yxV80yQP+bU030CDBuBnbVlMasaFYAWOcmluJRZg37RyTP+S2GFwQUs5L0qCMh1l9y
 GoTLgKID55DcyCPF77Jp3BzKqgY2jBGOOxFxtCpfY13YO56kJ2Z4qJMRBSmo7/g5y/3j
 VggUkSR8BJEzBwZJdDp3CR5RpvkV9Ge1T9HjK1mE9TRj5gvUg3TE9cu5fjMeeHinc+++
 DSVeJfxqVqmD9REXVT3vJYY5NySvs+HdEtxL3pZ/zBE3ahBEko4pL249dm720mAay9E4
 V5TUU7VmKLikxGG7rL1RsCFe9V8rXWSshsmH52P6KBJ5dXNzcZTqoFBkXc7//Ke2/Gpr
 I8TA==
X-Gm-Message-State: AOAM531JOuIO0IB/RdZEZRRMReysbabZjQqDKQ2cC6r7cea8uuan1+M/
 KXUoyESxo/b89aXzxB+DhAk7UmL52SFVto+7/XSlBg==
X-Google-Smtp-Source: ABdhPJzwFRM17qVNXqispIOAMRuWTccQv1dCmb99J12Wu/5Bz2f0suYtIbNIiAk2urkS/Qj+dWH8wJUS9YWSs5bZwKU=
X-Received: by 2002:a25:1409:0:b0:63e:4e0c:9158 with SMTP id
 9-20020a251409000000b0063e4e0c9158mr6468964ybu.555.1649417306934; Fri, 08 Apr
 2022 04:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220408092803.3188-1-h0tc0d3@gmail.com>
 <4o2YD5id7zhK5g__CUK3Yf-6Dj459XQ0qsydW6wKHdco3YYtl78BqGUfXvQ9UO0AZoAsMPfhFB0jw1BFldiFDcbZXmGgsobuAoTMWmoDqmE=@emersion.fr>
In-Reply-To: <4o2YD5id7zhK5g__CUK3Yf-6Dj459XQ0qsydW6wKHdco3YYtl78BqGUfXvQ9UO0AZoAsMPfhFB0jw1BFldiFDcbZXmGgsobuAoTMWmoDqmE=@emersion.fr>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Fri, 8 Apr 2022 13:28:25 +0200
Message-ID: <CAP+8YyED70CSqVRaB7JgrAtK-yvBx5EsvrrdR7EpvOG2AVhskQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix NULL pointer dereference
To: Simon Ser <contact@emersion.fr>
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
Cc: Grigory Vasilyev <h0tc0d3@gmail.com>, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Melissa Wen <mwen@igalia.com>, David Airlie <airlied@linux.ie>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Sean Paul <seanpaul@chromium.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 8, 2022 at 12:01 PM Simon Ser <contact@emersion.fr> wrote:
>
> Is amdgpu_display_get_fb_info ever called with NULL tiling_flags/tmz_surface?
> If not, there's no point in adding NULL checks.

It isn't called with NULL anywhere, the NULL checks that already exist
seem redundant.
