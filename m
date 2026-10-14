Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2BECC6B2F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 08:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00881121BE;
	Thu, 15 Oct 2026 08:21:50 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E24010EA85
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 16:44:32 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-34c522572bfso548250eec.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 09:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996272; cv=none;
 d=google.com; s=arc-20260327;
 b=pyv67sipKpyE0wFnnB+AT+kfq8mLrz3/deUC5zWcrAanPr9EYSeG+O5Nkv1F2HsopT
 CtWU1dEjr6uQ8f/kKlpq/E24bYAGYel5NIPQkUlPxPNc3lXGWm5jHsGukR1C+8hYYVaU
 qv/XMxQ9ViRY+DMViBy1xNYf83/5yeDOU2AjUEY119V01YqCJkK0kvMFnVNSSM42H4jb
 TOCLkYA0pjSPKyt55wIG6vIyO0QJAyDlkckrLu2In+9hurX8XgXUcfLGCjFs+IF6dM3+
 hTNr9qnfwNhHEAF0KqeHYMtpVVE3+fSkAmi/dBrba/LphLsLKzVao0S5EmGXc6SjdXZt
 iyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
 fh=k3s4DqrA8IgriarmCbEVpkLK1b4CSm9+JZIak6Vznys=;
 b=Y5QkMeQbbS3lKFmfBgd+nNgq79+aD8tZ/hplDKnWySXoQy00xoHi7PPPd/gqg9pipm
 WHpsCuJXdZM9SjUINY1/xyVMdBmzvmQGWxz5IZH/PkGURFGDNrRLH0DeMhsoyEgdKL78
 Gl5sSnQ5ifQAjOHad4/cxhyGXmKxrAvuJokr/GI6vJPTjEaFDNJvvDe+7USaP/uvVhK3
 7vprRGr4ork9oo+b3ZrEty2G8Wq+iXSsM50PUfFNE6cKTRI8/XLES+hg7AeOb3WBn4HI
 7NCqSp7XYh4INPBGFdCdRjqtPlsBs2RemY5IOOYSUoDUhjCcignfI0HZZsdCCuYBx1Sl
 b/BA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791996272; x=1792601072; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
 b=oSJPMTn0eHIyIrptvv3zGySnaRIQReJ33OMq4nLDDuxe4c7bj8c1o9zqOUl2BGZTxw
 nvovpaEiKKpC3Oh4MI7srbTJj7Di2H1yIs9Yqq3TFWYqjBB56HjoCiC9LBwLNFFgvzOF
 IE2izTCBth3bLsGVoZi2I7FUKvdqrpB+BlMU2Pv0h0gzdp+wf1zSgY7Bs3lX3H3XBkX2
 CvkhuHR633s9jmcuByHT5gLinzah5OW4+tv8wYCbKkWxl/RXubvWBdwQYtN8rLWg1b5e
 IF1Dh261V4Wjbd3Fph5DtTpaoywfaWCovpmwwAzfJ532MRtrymb8WuTdBz3l5AnhI9oL
 4U9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996272; x=1792601072;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
 b=AVqtL9Ikc6eITQYxPttIbuGhA4xWnZQMQDxc7LAuFRGmtViH1vHGLatDsLMpHy6AG0
 tZCBwPrQTfMyjQ/KLFujkLp1E0fOSQUjL8XVOexZ7rdPmeZnrTGgEXtzUlWc7L8q1MQ+
 5iqR1rhpjg2r0mf4KP8gRYuG2c4w7sZA6Qa50urPyy0KGqN67K3mJJ4bEBBTgBSQQTio
 et0CSey8GExAiVypR/W48d3rAmwi8ppQfWg2cYgxIEvGEnE04tc+kB/gBGgH6OrIvByM
 rf37oyb3ObiYN7uPmMg+lu723G1g1sAIj8oAeTyVooGoj5YP/OqVldT176l+eNNqDrld
 lyJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBykLFlVQoxvTuFzNmx208KHkLbxthmvvndf1bv0dwyu4m2GwmAaI6hQ2opziVANXGBe/faNXqk9@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIeVLb2pbVpKhxmdFq3KGPGPdmoUXURfaTwzsWVpd5bYkFpfQuv
 4kzIXoVuQzYX6mox9H3Qlv9yavgq+aTxBzYjvP/jHASxwY+4Ai/Ju6r9Ti0lKMx7PcJ2QbQ2Opz
 P27GsgtbNkrd/Q2KNbPPlT3LFjyTDqao=
X-Gm-Gg: AYBFou1PlyjvVwaGRt3S0cn2teMgF3qalwKc7rB1V3Jh4oPgX1EWzaq2i3sehXFeQh7
 B2v4SFkKaVzXDSkpDoWlCtXnAw+iiEnrZqt6aRGpzndE+r9v3ui0fY6GNHuJDdSOOgKkVYbY/S6
 6lt6jPOPhSPVgIQKJrERulBXgKR9vbn+Y/jwOJO0nlyGQUQBKPR60VPt0rUDtMJpTvjd2vq4R82
 FGi9oNaeYct+Bg5ZyyU0sppo+j7bW1ottw4rtNXzjj1TxdMQag7z36RmFI2De8wxWodB6lz47WH
 Rl0co5u1oEjaee+YzOxwu0Oad3QGm0i0rfk2Z0xFMMuIwZt77wzOOpSeddqcgN2zaJiJeBK8+cY
 HD2s6Z7aIxXNqV7sbRFTH9imYN1Eur/x0RnFS0P49dDzqkeQcY6bob5/aTaPgVQ+YIsW0XLws9V
 HJ2d0w9nsikFNHEFM0dsXNoyNWgXayYbU3lhWKaN1/hdTLjUtVZi4=
X-Received: by 2002:a05:7301:5413:b0:358:c9f3:b055 with SMTP id
 5a478bee46e88-358c9f3b260mr28158500eec.1.1791996271702; Wed, 14 Oct 2026
 09:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
 <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
In-Reply-To: <202610140932.5F9CFCE5@keescook>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 18:44:18 +0200
X-Gm-Features: AclHuK_d31yoge0njHjovdIQh7JfJY6W-PLjzMLBq14NjY-schAqigzEJUAQwG8
Message-ID: <CANiq72=4WQ1B1oCSW=69u_Z=FFLE56hYCqDwWr+poQdzSTS31A@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct
 kobj_type::release
To: Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ian Rogers <irogers@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
 Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, 
 Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 driver-core@lists.linux.dev, llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
 linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:21:44 +0000
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

On Wed, Oct 14, 2026 at 6:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

Of course, please feel free to pick it up (with the small tweak I
requested) if you have a user.

And if you don't pick the user, I could still pick the first patch up
through the compiler attributes tree if you and other folks want to
use it after -rc1.

Greg: adding the attribute itself should be safe and would unblock
others that may want to "protect" themselves, without having to wait
for every potential user to get fixed (but of course I agree they
should get fixed -- we should not forget about them, if that is your
concern).

Cheers,
Miguel
