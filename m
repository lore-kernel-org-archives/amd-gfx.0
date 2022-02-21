Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD502C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 21:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25FFC10E3DD;
	Mon, 21 Feb 2022 21:35:40 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4B210E3DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 21:35:39 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 j7-20020a4ad6c7000000b0031c690e4123so5762968oot.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 13:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CzBbAHv1lZ0CR3rx0PIGuLpTE9OSfh/jyEk0u3AIkz4=;
 b=frYy79E833+ojmNvhKaVjiviTv5cpzfU2LUFTDLd/3oTW0BYkYDFkNPRuAaefSE9MA
 7QV+AdvoAnWHstpz43M6INzexIGEd4MXFoglZRJwdpbHw0vqiA9VpLzdN8/Hx6v23QSh
 4itu/kHrHqT8hoelNXhtP6ZCrWqAvfEDXy7GyN+VKJ13RsJMZO6U6LHqg/oOyt1qz7xj
 9/tRyZS/Ix8qYysbbLdBRQXwSiykSJplkRucAYB0e2G9lywgVdkf4B4mf11KT0/m8VkV
 KJpuaMMsDsMR/n7Yzs8MrA94QpNxXfPMP9u22W+9Y5NC9YDjGnnSwMWGcmo49/l/lSfT
 Eoug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CzBbAHv1lZ0CR3rx0PIGuLpTE9OSfh/jyEk0u3AIkz4=;
 b=8PEl1DgWhakjEgeVAjvdyTI5EE1TxrcE3uuYNk93TOx6sus0hEAFJyqGXtAXCvTN8a
 3Q6RlkQyXtmOz5hdhz8s+GVsRtF2AGOn6cyIaL2j5Fqw2O9dSZ63plRsEsdtIH4ZCq4F
 xs7Bf0Q7XFTWKPKTDymyvqAL4qxu3f3j7GVAI1BH9dELb1bLsNKblVIzVE2JhU0svqik
 YoJdyKbi20BcJCeKfCwWKGOjRBFBRTqCxHmCutepMr0n3ebbVix+F9mi9hESOYBqxTGk
 VRKacgK4szmKTMVh02zadGLy8YeCyE7VCOtQmJMLpByH13bFdB12jExQDp8uWe0hI0Ny
 k70A==
X-Gm-Message-State: AOAM5310qJwe4tpvjQwbUYaopFlex2UxA/zYdAKqiUWsFH/b8sUgvSmQ
 +Zx1aAX3co0Rxi5ouGf6OrNo+YmTzNoIV7QGIFo=
X-Google-Smtp-Source: ABdhPJxNwBr9lNn/Xf75QCcmd52VSN3mwfcJtpFF/ARo26PECO+FS2Bx4EbHY7lmaD3EnjAOiXJ+SLbg9SzfJ6RbgFI=
X-Received: by 2002:a05:6870:912c:b0:d3:44be:7256 with SMTP id
 o44-20020a056870912c00b000d344be7256mr380536oae.73.1645479338379; Mon, 21 Feb
 2022 13:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20220218222603.25470-1-alexander.deucher@amd.com>
 <20220218222603.25470-7-alexander.deucher@amd.com>
 <4009de28-8add-97b9-0dd3-8d44704af322@mailbox.org>
In-Reply-To: <4009de28-8add-97b9-0dd3-8d44704af322@mailbox.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Feb 2022 16:35:27 -0500
Message-ID: <CADnq5_P2ffjt7L27vUo+iwRUJNu2+Wmo9ORNwv42XYdgHwhPkA@mail.gmail.com>
Subject: Re: [PATCH 7/7] drm/amdgpu: drop testing module parameter
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 21, 2022 at 12:44 PM Michel D=C3=A4nzer
<michel.daenzer@mailbox.org> wrote:
>
> On 2022-02-18 23:26, Alex Deucher wrote:
> > This was always duplicate functionality with the benchmark tests.
>
> Not really. The purpose of amdgpu_do_test_moves is testing that copies be=
tween GTT & VRAM work across the whole GTT aperture (when I originally wrot=
e radeon_do_test_moves, they didn't on the PowerBook I was using at the tim=
e).
>

Fair enough.  I'll drop it for now.  Might be useful to convert to
debugfs at some point as well.

Alex

>
> --
> Earthling Michel D=C3=A4nzer            |                  https://redhat=
.com
> Libre software enthusiast          |         Mesa and Xwayland developer
