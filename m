Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCE0C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 17:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878BD113A78;
	Mon, 27 Jun 2022 17:31:11 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 780F8113468
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 17:25:58 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id g26so20596144ejb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ag0pKSvzxJdNyXr6GgWk5BPm8wB8ID3zroUAibVbXH0=;
 b=PjF/DozjueZrY0TA9VeUOcWG72GukUr38//UraOZZCH0mVO95JU/hGa1RlCP/tX3/1
 lj79r9hg7pH3iApgg63PABDoVi0TVFl8mzr5VPCQKFtoLJo3DV34MkhQnTX/yORACuge
 3q3zX2dI6V2IoF8/9vyU/oJbabxH4Hrjmo2m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ag0pKSvzxJdNyXr6GgWk5BPm8wB8ID3zroUAibVbXH0=;
 b=x32j5DygM01DHk47FWhtKu5BXfIhDj9fIAWVNz0rIuRxuhWpXSOU6WKp+jkDT8m5Jt
 QEGAbEYpGIK6u4kDSAjqW/2kA0ZJSvWw2L27h/Q53kabbCkwFZXraIRIRWc/w/J8i7qY
 4xMComdRS1f8oGclYNEkhb5svxOY/HFOR73RC2kqJArGNeaj2eKu2hjng8MHtgwNfv72
 13d3I/M7xPBUu1s+yX56+BvIEdTvyI7FvFde/M7OUnALOUur5w7oXDSmk0r+eC6BRmVa
 w0vuWYpYB286jl/jkaTQnDDGL9ZVBikE9QzJ9SHYrplEuNH+oZUsefRAJOg7yeS/Nokh
 Pcrg==
X-Gm-Message-State: AJIora8hQdwL7lLF44iwxk5/oGbrWklpfaGS2FmZyXkGI8+0C725+tLX
 B6mD+JPT+OlBNJfLh0u3ZIp0o8v2TYDRa8kj
X-Google-Smtp-Source: AGRyM1smSZiHvRhqzpwSdi+kGAaUtJufSTYxw9m3GrUryRC+3AJ6El7y7sz8FI+Tk8ENjodU8I6l4g==
X-Received: by 2002:a17:907:1c94:b0:726:307c:8be7 with SMTP id
 nb20-20020a1709071c9400b00726307c8be7mr13950105ejc.443.1656350756582; 
 Mon, 27 Jun 2022 10:25:56 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com.
 [209.85.128.46]) by smtp.gmail.com with ESMTPSA id
 m20-20020a170906721400b006feb479fcb4sm5253794ejk.44.2022.06.27.10.25.55
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jun 2022 10:25:55 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id
 be14-20020a05600c1e8e00b003a04a458c54so2079948wmb.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 10:25:55 -0700 (PDT)
X-Received: by 2002:a05:600c:681:b0:3a0:2da6:d173 with SMTP id
 a1-20020a05600c068100b003a02da6d173mr21158126wmn.68.1656350755360; Mon, 27
 Jun 2022 10:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh42rU5mKU6=PCK5tdkYjh7r31dGNmYdHwqpFnRFvVudA@mail.gmail.com>
 <3920df43-37f5-618d-70ba-de34a886e8ab@redhat.com>
In-Reply-To: <3920df43-37f5-618d-70ba-de34a886e8ab@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Jun 2022 10:25:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com>
Message-ID: <CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com>
Subject: Re: Annoying AMDGPU boot-time warning due to simplefb / amdgpu
 resource clash
To: Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 27 Jun 2022 17:31:08 +0000
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hans de Goede <hdegoede@redhat.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Zack Rusin <zackr@vmware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 27, 2022 at 1:02 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> The flag was dropped because it was causing drivers that requested their
> memory resource with pci_request_region() to fail with -EBUSY (e.g: the
> vmwgfx driver):
>
> https://www.spinics.net/lists/dri-devel/msg329672.html

See, *that* link would have been useful in the commit.

Rather than the useless link it has.

Anyway, removing the busy bit just made things worse.

> > If simplefb is actually still using that frame buffer, it's a problem.
> > If it isn't, then maybe that resource should have been released?
>
> It's supposed to be released once amdgpu asks for conflicting framebuffers
> to be removed calling drm_aperture_remove_conflicting_pci_framebuffers().

That most definitely doesn't happen. This is on a running system:

  [torvalds@ryzen linux]$ cat /proc/iomem | grep BOOTFB
        00000000-00000000 : BOOTFB

so I suspect that the BUSY bit was never the problem - even for
vmwgfx). The problem was that simplefb doesn't remove its resource.

Guys, the *reason* for resource management is to catch people that
trample over each other's resources.

You literally basically disabled the code that checked for it by
removing the BUSY flag, and just continued to have conflicting
resources.

That isn't a "fix", that is literally "we are ignoring and breaking
the whole reason that the resource tree exists, but we'll still use it
for no good reason".

Yeah, yeah, most modern drivers ignore the IO resource tree, because
they end up working on another resource level entirely: they work on
not the IO resources, but on the "driver level" instead, and just
attach to PCI devices.

So these days, few enough drivers even care about the IO resource
tree, and it's mostly used for (a) legacy devices (think ISA) and (b)
the actual bus resource handling (so the PCI code itself uses it to
sort out resource use and avoid conflicts, but PCI drivers themselves
generally then don't care, because the bus has "taken care of it".

So that's why the amdgpu driver itself doesn't care about resource
allocations, and we only get a warning for that memory type case, not
for any deeper resource case.

And apparently the vmwgfx driver still uses that legacy "let's claim
all PCI resources in the resource tree" instead of just claiming the
device itself. Which is why it hit this whole BOOTFB resource thing
even harder.

But the real bug is that BOOTFB seems to claim this resource even
after it is done with it and other drivers want to take over.

Not the BUSY bit.

                     Linus
