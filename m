Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3556EEB64DD
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jun 2023 08:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B710F10E09E;
	Sat, 24 Jun 2023 08:34:03 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24F4510E013
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 23:44:23 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f95bf5c493so1546836e87.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 16:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1687563859; x=1690155859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gVT3Ae52uNnNMAjvZ6ok3W1cvzQFVUDD1dzfpAkc+Ro=;
 b=NrP6fMkluNDMLVHiZLGr7OreyMjSY3mRQW4xsjeFPJGYbtczljHjwKw3PG46QEPtYA
 5ZtC/CFIydKZnmO602tf1qEWOMg+RCt/19XXhMZBk6rSejzwkRtM7If5lTo5/D360CGS
 LSjPxU6ODch4AZ6Jb13UihWpep9DpBx7abFj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687563859; x=1690155859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gVT3Ae52uNnNMAjvZ6ok3W1cvzQFVUDD1dzfpAkc+Ro=;
 b=FKMhFODSj/SiA5Hz2T/AGf46VkswJS/WsBjy18ak1quiMacUnmD5nahREjroptIqER
 O8JKgG3KqPDkZD8IGrfMDFP95bA8UmFMFieZgz1uLTceWGaSpgaXhMxUNR2z/WjyfOSY
 mrJLAlB+y72r7EehW137ZT7BR8MvgJ2M+c/SYuQrsDkZfTaDtMNjfgu2m1S1Rq+bFPih
 n+ydx3OkCVuirKZwHHElCm0AQIKTPPyQSdSjJRB722soWSgnbgLwAl8zTnUDLOhtq+MY
 aI4vl02i+HmcpiExIZ3KJiE1pN6VAmOfX2jHfbpuE3uy1tru9XZMMtYcaClomqozHotA
 WyOg==
X-Gm-Message-State: AC+VfDzYmxyfmgxFcsA4ADw0tlU+9BCcuNZN9ZgbAwdu3z6SHOenPp5n
 MTGhw2+yf4jysDDzYZt5T74PulslnKTkw1QNIyRlBg==
X-Google-Smtp-Source: ACHHUZ7dRi2TmYJ5JTtHqwYA/655a6cIUvz58lDTKp8PPk2hbGHC8A+SVWLYdodWJWZinEhbSysVoA==
X-Received: by 2002:a19:e612:0:b0:4f8:6627:7983 with SMTP id
 d18-20020a19e612000000b004f866277983mr10483372lfh.5.1687563858580; 
 Fri, 23 Jun 2023 16:44:18 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com.
 [209.85.208.182]) by smtp.gmail.com with ESMTPSA id
 z22-20020a19f716000000b004f4ce9c9338sm60087lfe.283.2023.06.23.16.44.17
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 16:44:17 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-2b479d53d48so20642581fa.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 16:44:17 -0700 (PDT)
X-Received: by 2002:a2e:6e16:0:b0:2b5:950a:711c with SMTP id
 j22-20020a2e6e16000000b002b5950a711cmr3568282ljc.10.1687563857166; Fri, 23
 Jun 2023 16:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230623211808.7667-1-alexander.deucher@amd.com>
In-Reply-To: <20230623211808.7667-1-alexander.deucher@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Jun 2023 16:44:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOCgiwzVPOwORHPML9eBphnbtM2DhRcv+v=-tnRrgbYg@mail.gmail.com>
Message-ID: <CAHk-=wiOCgiwzVPOwORHPML9eBphnbtM2DhRcv+v=-tnRrgbYg@mail.gmail.com>
Subject: Re: [pull] amdgpu drm-fixes-6.4
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Jun 2023 08:34:02 +0000
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
Cc: daniel.vetter@ffwll.ch, airlied@gmail.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 23 Jun 2023 at 14:18, Alex Deucher <alexander.deucher@amd.com> wrote:
>
> are available in the Git repository at:
>
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-6.4-2023-06-23

That's not a valid signed tag.

Yes, it's a tag.  But it doesn't actually have any cryptographic
signing, and I'm not willing to pull random content from git sites
that I can't verify. In fact, these days I ask even kernel.org pull
requests to be proper signed tags, although I haven't really gotten to
the point where I *require* it.

So please sign your tags - use "git tag -s" (or "-u keyname" if you
have some specific key you want to use, rather than one described by
your regular git config file).

                  Linus
