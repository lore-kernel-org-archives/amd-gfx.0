Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAEBC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 19:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A7410ECA1;
	Thu, 16 Dec 2021 19:23:38 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BDB10EC46
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 19:22:09 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id k37so17734lfv.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 11:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iJmd78S3YbBSlGQn83I0jq9ljqrL5KMi3cs+QYv4G5Q=;
 b=IMgJ0vGuO/mp788yQJshC9wZYW0T/EEGkCkJvNmjGYmgBuCAXQi9R2rtPnVUXGpiuW
 dATrFQX97/XiSGJEL5ODlEI125Pc8PGXuuEZFtY+4+LgL446FVYJYbytxskslz7R4my4
 6T+6uiuzXFLvbqemsAX65zgj5iPDLNM0Gr5O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iJmd78S3YbBSlGQn83I0jq9ljqrL5KMi3cs+QYv4G5Q=;
 b=hRW0PECreAtzjnrJ//Ej/8gnBZWudAUjpSoIIHskbRB4Z8+WfYPA+mvo8vxUFS9r5C
 EezZeBCLDkGC4nqyFJJWJoom0hQVQ+TUOjHqZY9D6Fg77tM9nZiDrQu7laPNqBMcdNq8
 M2Ddbbrr9x2AUAilghzyqFDoDKraXpaLmhIDNUEyrZ4U0TbJid/9wnqxj9JNXWdln2VN
 qKakl4QWCDkzbJeheAaNDp5LSE7GZk206tRLc2Z7IQBLsLIxJFf4yyA2iJp1ZMKV41LZ
 vYcIjhj6zIeUQRsRtf2/4yUriO+yHJEdN8wYKCNMNxn9BLPEdYeJUwfprKKYicNc3J7o
 vDaA==
X-Gm-Message-State: AOAM533yi5IwPTfe3VJkvspjmsKId/72xZWmnz8GX9I42nJDdpZu2b9j
 KE+B2wIbAOmtgQa2r6yCH647m1mZPzQAFw9kRl+QkA==
X-Google-Smtp-Source: ABdhPJyCyOzuaF/9HovqrvOyPV/d+bMWRgT/6AyULF6y3aDZ9NbPhU2nDhZoejovfVAoP9h+Uv3p9CWC1x60r/Mch2U=
X-Received: by 2002:a05:6512:23a7:: with SMTP id
 c39mr16423447lfv.655.1639682527942; 
 Thu, 16 Dec 2021 11:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20211216094503.10597-1-lukas.bulwahn@gmail.com>
 <CAC1cPGyg_wNqusQX+OzPNtTc8GSpQKwxfFSKzLfENYoXihQYww@mail.gmail.com>
In-Reply-To: <CAC1cPGyg_wNqusQX+OzPNtTc8GSpQKwxfFSKzLfENYoXihQYww@mail.gmail.com>
From: Kate Stewart <kstewart@linuxfoundation.org>
Date: Thu, 16 Dec 2021 13:21:56 -0600
Message-ID: <CAG_66ZSDtWOHEfjyHf9VvG2U9H3_O32mEo_0nmjDhqoxAaijPw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: make SPDX License expression more sound
To: Richard Fontana <rfontana@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 16 Dec 2021 19:23:37 +0000
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
Cc: Jonathan Kim <jonathan.kim@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-spdx@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 16, 2021 at 11:14 AM Richard Fontana <rfontana@redhat.com> wrote:
>
> On Thu, Dec 16, 2021 at 4:45 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Commit b5f57384805a ("drm/amdkfd: Add sysfs bitfields and enums to uAPI")
> > adds include/uapi/linux/kfd_sysfs.h with the "GPL-2.0 OR MIT WITH
> > Linux-syscall-note" SPDX-License expression.
> >
> > The command ./scripts/spdxcheck.py warns:
> >
> >   include/uapi/linux/kfd_sysfs.h: 1:48 Exception not valid for license MIT: Linux-syscall-note
> >
> > For a uapi header, the file under GPLv2 License must be combined with the
> > Linux-syscall-note, but combining the MIT License with the
> > Linux-syscall-note makes no sense, as the note provides an exception for
> > GPL-licensed code, not for permissively licensed code.
> >
> > So, reorganize the SPDX expression to only combine the note with the GPL
> > License condition. This makes spdxcheck happy again.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > I am not a lawyer and I do not intend to modify the actual licensing of
> > this header file. So, I really would like to have an Ack from some AMD
> > developer here.
> >
> > Maybe also a lawyer on the linux-spdx list can check my reasoning on the
> > licensing with the exception note?
>
> I believe "MIT WITH Linux-syscall-note" is a syntactically correct
> SPDX expression but is otherwise sort of non-meaningful.
> "(GPL-2.0 WITH Linux-syscall-note) OR MIT" is presumably what is
> intended here. But yes would be good to get confirmation from someone
> associated with AMD.

Thanks Lukas,  I agree that this is indeed clearer.
+1

Reviewed-by: kstewart@linuxfoundation.org
