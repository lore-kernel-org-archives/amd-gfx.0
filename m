Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3D8C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 16:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DF860F39
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 16:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A9DF860F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D62F6E055;
	Thu, 26 Aug 2021 16:45:52 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C41936E055
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 16:45:51 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 v33-20020a0568300921b0290517cd06302dso4298563ott.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b9gQyMpS5rL3JM4ucdzKevRxNxIou99wcWGs7Y3jiO0=;
 b=tJG53elyEYEiiimvcahS/Wb8pBf7vatn/HViFoXVNdve/XF5tfNATwM0M85csXktUt
 i1N1Jvu+mb1t2HzfG8awIRkM7sTCfXdjPESGjRkrrV+oIkcvJ/1/jLQHnl0PNE+aaknG
 70MEksUl9TqXVJ2rApl23KYpr/0fRxZ/n97e4hUdzPq4AeHnmKe5DjMx5mlDU8LRUDpL
 njrPJIpGzS8sRy+/WR40NECG/Wmt0/VAd5ChgXBojW7PQjS9tJT83hZfi8mxJYzT7zJD
 fJgwoP+zJNjiRAmTZ41jAEQNg7GYtRsPg68kf7wLIRBsGRejGbpmDWvDTBy+d/x1qf8u
 YuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b9gQyMpS5rL3JM4ucdzKevRxNxIou99wcWGs7Y3jiO0=;
 b=gExvz9sTHE4tcw3l8D+MDntPAp/Yn7l5rG+Ubtqfr2AAcW8rDgoALzDGgymscY8fXt
 9nRfU0l4Fe+rN0uE7vZfdfGBLz1iuR2lcek9jR6bzDxGrtd11i1885stq+mVVW/weTx3
 Eu6eQqN28RlshG3+q5VrkwEFLPlpGjQEY2U5zrj3hAkRkYaSG6zEcVP3MzYUfaPyMK9q
 xJI0f2DSm0OJjxUlmcG22oeVhlhDMd186SjWY+kVFENwJZTOwg1ZTeejKc4sXkCtNcpm
 6YLD2qftC6Xjz5YIjlCFHx93xegkbqEvhwos7E3QpBG6OshzCPxiK+M7rqEeDsEZggN/
 Edug==
X-Gm-Message-State: AOAM532y4M1cxWJxYWCYGS9JXzCIt8veoPLACviThfZ/igVWk6r2PyI+
 0N0cy9hNLer5byZFqlPRmHO6kqyFgXa5PgLHK1Uk4iX6
X-Google-Smtp-Source: ABdhPJzJEmpMKnKvnYlsdT7rK7gNWBHTrq7kXmjGBZoe6U5Y3RRuZ10ub7HJHOw7JTq1zR3rH7Fg5SaZkffEEOiN5Ts=
X-Received: by 2002:a05:6830:4:: with SMTP id c4mr4059989otp.23.1629996351078; 
 Thu, 26 Aug 2021 09:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <36cacbd4-8240-9713-6cea-68209757ed0b@gmx.de>
In-Reply-To: <36cacbd4-8240-9713-6cea-68209757ed0b@gmx.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Aug 2021 12:45:40 -0400
Message-ID: <CADnq5_PrkEQCpKKWY8QhOqWZ_jxK3vabSjxwRW-+MFnm3Rgs2w@mail.gmail.com>
Subject: Re: Set video resolution and refresh rate at boot?
To: Paul <pb.g@gmx.de>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Thu, Aug 26, 2021 at 12:35 PM Paul <pb.g@gmx.de> wrote:
>
> Hi there
>
> Out of curiosity I would like to ask if it is possible to set a kernel command line parameter for my Radeon 6900XT
> that sets a specific resolution and refresh rate of a specific connected monitor.
>
> Ideally this parameter is set to the monitors used desktop (X11, Wayland) resolution/refreshrate.
>
> I did this for years with my Intel IGP's. I appended:
>
> video=HDMI-A-1:1920x1080@50
>
> to the kernel command line. This worked beautifully and the result was my monitor was preconfigured to a specific resolution and refresh
> rate from the first lines of the kernel to the desktop (X11) and it did not had to switch to anything else in between.
>
> Another nice side effect is when in X11 one switches to the console, or vice versa, via STRG+Fx, pretty much everyone has this annoying delay because
> the monitor has to switch between refresh rates again. With that preconfigured settings at boot this gave a very satisfying feeling, especially if one frequently
> switches between console and X11 (or wayland maybe).
>
> Is this kind of parameter implemented in the kernel/amdgpu driver?

It works the same for all drivers.  Just make sure the connector name
is correct.

Alex
