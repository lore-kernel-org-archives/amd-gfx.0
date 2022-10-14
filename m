Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13039C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Oct 2022 07:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBA2610ECB2;
	Mon, 17 Oct 2022 07:11:18 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AA4510E03A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 18:15:25 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id n83so5872453oif.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 11:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KM3d9mUdbDj0z6oafXxyZzutznAV5jWXZ9fQzWHF6Bs=;
 b=TsKo2S7GdpxCnrWyTu2QEbbgciSN5woqwIPML3g0E6pmL75LsB288Sf+10bV5E1FMd
 +Cw39hD+tRwMpp7CEfBS80jSkGVcSwaae/dPmihuAxxWq7V7xBbSQfW1nes3ZLh+Mnsr
 72Y30bhKclxNEcE+iZB8casHWCU81PWTfK/qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KM3d9mUdbDj0z6oafXxyZzutznAV5jWXZ9fQzWHF6Bs=;
 b=s0qJDiOvBY5LOkPYLxNbuLFnkKTIIqUPKcs8K6D92UyL7+9tSXotryzELvvtihUCGV
 GmDkSnt5MPWCZ26fccrhGeYun+jqcYTqjilsTzQvfC/xS9LkwpeR2t/8QZjANer0e5Xo
 egfALrvemlu3duWXeEy/DIjnyhs9hcuZI78L3kpYJMETWZmx1iNhHrxdlnZomBilG6T2
 HPO5iZnvjjatNPPsmJpuQxoCdsqWzCYgShBJUTzQgOc10DX4rgQhzcAztbDgtKdzoTtW
 9NZGgzNSza0EGgRxIsZzuFubXegQGfS94HWnUlVIBUuCgejSzMNSIBEmRUYn3TZiwVDy
 2DLA==
X-Gm-Message-State: ACrzQf0J9iVUAWi5XJ6PIkbkFRX3AEbt1d1bbeyv0j96db893kTzRltc
 lCQ9W5yM9+9HAPSVvvrHkc6BD6CrjzF6lw==
X-Google-Smtp-Source: AMsMyM4N7JgmFNIQnLsZa7Uk4fR8nxxgvNSUILjKhX5FGUlq8zNZ1jT3mZr4eREB4Ss4ziRORHqxjg==
X-Received: by 2002:a05:6808:1209:b0:353:f187:6c35 with SMTP id
 a9-20020a056808120900b00353f1876c35mr8077745oil.113.1665771324176; 
 Fri, 14 Oct 2022 11:15:24 -0700 (PDT)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com.
 [209.85.160.47]) by smtp.gmail.com with ESMTPSA id
 cm9-20020a056870b60900b00132741e966asm1623479oab.51.2022.10.14.11.15.22
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Oct 2022 11:15:23 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-12c8312131fso6797377fac.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 11:15:22 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr3564382oad.126.1665771322642; Fri, 14
 Oct 2022 11:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221014152102.1755050-1-nathan@kernel.org>
In-Reply-To: <20221014152102.1755050-1-nathan@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Oct 2022 11:15:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8LT6iN7ZFE_6Yfydne9gWYJaJzD1ntSuGhMv8SkKCcw@mail.gmail.com>
Message-ID: <CAHk-=wg8LT6iN7ZFE_6Yfydne9gWYJaJzD1ntSuGhMv8SkKCcw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix build breakage with CONFIG_DEBUG_FS=n
To: Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 17 Oct 2022 07:11:15 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Yunxiang Li <Yunxiang.Li@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 14, 2022 at 8:22 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> After commit 8799c0be89eb ("drm/amd/display: Fix vblank refcount in vrr
> transition"), a build with CONFIG_DEBUG_FS=n is broken due to a
> misplaced brace, along the lines of:

Thanks, applied.

              Linus
