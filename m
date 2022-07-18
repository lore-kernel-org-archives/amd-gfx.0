Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1882EC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 23:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1E5B1131F8;
	Mon, 18 Jul 2022 23:52:13 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE76F1131F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 23:52:12 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id h22so9985023qta.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 16:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pe5b/6eC5VODqzAUqLI58n4QjDC/aAW54DRJEazG65A=;
 b=ocXwkZiMb0Ur+i0gJXarYn9o4kxQjGtulFdoGang2nF9yms5ShP+RcFixFtP0mv3GD
 56y8xLQzF7FXc22gbk1kQPiD2+wyyrywkNIPb3KoVSOzE+x/mjYqUQf+81inwdNYb3CC
 AF8ammBcfhYWhHz//MsKxzaABWQIVVXNuntau03dhoocuP56EjuHWlAr55pJrXupKtNg
 bUnOvJM+ygUpPQTGo1ppzQ+V5sTPhUWhHHcrP8L/KJK1c4f0gIRIoVRsLswwo/2/67PT
 vYYVNyNsh3gjd72PbKxfVqXOvGDier5ItD0g3BqS4VbyEcp68J9fvOgQ8MI5gBwZBSdM
 yBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pe5b/6eC5VODqzAUqLI58n4QjDC/aAW54DRJEazG65A=;
 b=fFcWtSOIRM6Ql05xSzosmZxdVH4HGWbJw1X7ya5g//kZv1vf13Pq0xBn6i6GYQTuDd
 yrP7bMFpt6CCR3OVsrVFAU6LfCZRtTMRWgKmvy9IOjHnVdBUOsdt+8GZSlJEKOiHxW6E
 8kdLNi3Cg7xdRl2OawFLvSJxxJ62f27HgUNkz55fnMtY5EQ2lAv6PplCxqlkLdwYFQ9K
 BcCR0Fly9JqZQQbFAlD4O9H2izq5htfxh0KSc2ePsyiAIsqlwj+HyOqIsM2Ji+ta3BHl
 qNkKpoejaRrU+MeNtWjG5q5l5Qt5TjdSXjJdKn2XtbhUe5WAEhdr01MKy6ni4qFiI+Be
 UCAQ==
X-Gm-Message-State: AJIora+/3VH1eH4PUA5XA6b+O432p0QuD6HlcYcYNC9ctGLLfi8gsw0M
 Sk0vTgEHBvOAdfjWUxDqyVgWxZEIVr9WNOtPW1t6TQ5WR/rYeHfFCTw=
X-Google-Smtp-Source: AGRyM1tU0/sLKAjHDSjcErgXAQOd4NirQ8QdAZyeGQBOZXTDNEgSdhR6C89muEpv3oyNXuiSE1SUIFEQLlyrpdZUKQY=
X-Received: by 2002:a05:622a:1911:b0:31e:eef1:9d5a with SMTP id
 w17-20020a05622a191100b0031eeef19d5amr5676831qtc.233.1658188331648; Mon, 18
 Jul 2022 16:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsP920dX-gFOHjk0Xo-yTaQfoFwP7YT2VsG1=b9X6kYhHg@mail.gmail.com>
 <CABXGCsOywmEoKC1Gt4JMSAH5C=E9Rvjj+X+X8FY7QeBV-13YWQ@mail.gmail.com>
 <8876a42f-aef0-8322-b95d-704ac6476333@gmail.com>
 <CABXGCsNrnYZO6NfF624j0xrBkdF9vjZhcyF8iZrEr4eGcjpSCA@mail.gmail.com>
 <CABXGCsMSRg251use+9ZzgXZ_2xreNUh96GQsfDPdkh=xU6QGgA@mail.gmail.com>
In-Reply-To: <CABXGCsMSRg251use+9ZzgXZ_2xreNUh96GQsfDPdkh=xU6QGgA@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 19 Jul 2022 04:52:00 +0500
Message-ID: <CABXGCsP0V5SRhsyJvvS9PCK9JUo4XSbf1KSUESUwqE6EmBygjw@mail.gmail.com>
Subject: Re: [Bug][5.19-rc0] Between commits fdaf9a5840ac and babf0bb978e3 GPU
 stopped entering in graphic mode.
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: tzimmermann@suse.de,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 5:38 PM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
> # first bad commit: [9cbbd694a58bdf24def2462276514c90cab7cf80] Merge
> drm/drm-next into drm-misc-next
>

Don't know who to thank but the issue disappeared in 5.19 rc7.

-- 
Best Regards,
Mike Gavrilov.
