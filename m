Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93129C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 12:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E10113DA3;
	Mon, 27 Jun 2022 12:51:38 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70DF810E160
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jun 2022 18:54:45 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id d2so3005392ejy.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jun 2022 11:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=lFVUiMK8367I4tCKgM57m0mtqed/o+uPQT3BEO7ky08=;
 b=R492Zjh+q38rM4qIEoyPnAa3NRueOnjdDl4MNW+ScG+ZEs6CgqgoPU4KtgGmupFrUM
 ggaEkvz2f1LnqTxIdj28hN7PhBVAecATC4m4vO6U5foweG7xx6fIC/6EpDMeHGAlqmm4
 FikOwuJ0ZonoK2aTejYiS9gWXr4OFNZmvScf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=lFVUiMK8367I4tCKgM57m0mtqed/o+uPQT3BEO7ky08=;
 b=cUrGFQTzUaTWWqXAXM8BgedgEDsD4RM8T/PDi7PojmT00HQ7wKwUZAGfq40lA30ukJ
 5W5r4crAugyl7ekt3zrIwRW7TEBHsviyGYpTkNOZcMudB6037AA0g2KcCO0fiQA27d9b
 Sd+4aW+uJJl5i3/OYm/p/ZCHkjQ2zA+nfaZQPVmljR2H2sP1Q+i3hFWZnifHFtCC8nAk
 7lUaUtTS63yzuMMaNDTszenDuzZHIFr6L0n6ErKOQz0GdxYbm5j0dh/USOogM1SDa5rm
 g/b9UmW/aL/3qo2dAQjwGanC+Htu2X+uSV2mzMNWOPD0kV230IK9jZd9molBefjNnzy2
 jAqg==
X-Gm-Message-State: AJIora9nDhpbRmDi30kX2EWhKQVGBkgS594QaPoOAtq5JzcXOFk8tJnx
 7z+nxU3WixYMOY9baP3HiBnI/rY/X9w/3AaZ
X-Google-Smtp-Source: AGRyM1sNHJshI7FSgQqv0cW/MaZk9XrLBafKvnxbYimDXXD/jqSkWOmbNNzq7pPT8O1DWiOkNZtPOQ==
X-Received: by 2002:a17:907:1c19:b0:711:e5f9:2ec7 with SMTP id
 nc25-20020a1709071c1900b00711e5f92ec7mr9206942ejc.518.1656269683747; 
 Sun, 26 Jun 2022 11:54:43 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com.
 [209.85.128.41]) by smtp.gmail.com with ESMTPSA id
 s19-20020a1709062ed300b00722dcee9ea0sm4023320eji.125.2022.06.26.11.54.42
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jun 2022 11:54:42 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id f190so3861018wma.5
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jun 2022 11:54:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec9:b0:39c:69c7:715d with SMTP id
 g9-20020a05600c4ec900b0039c69c7715dmr15902172wmq.154.1656269682131; Sun, 26
 Jun 2022 11:54:42 -0700 (PDT)
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 Jun 2022 11:54:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh42rU5mKU6=PCK5tdkYjh7r31dGNmYdHwqpFnRFvVudA@mail.gmail.com>
Message-ID: <CAHk-=wh42rU5mKU6=PCK5tdkYjh7r31dGNmYdHwqpFnRFvVudA@mail.gmail.com>
Subject: Annoying AMDGPU boot-time warning due to simplefb / amdgpu resource
 clash
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Zack Rusin <zackr@vmware.com>, 
 Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 27 Jun 2022 12:51:35 +0000
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
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So this has been going on for a while, and it's quite annoying.

At bootup, my main desktop (Threadripper 3970X with radeon graphics)
now complains about

  resource sanity check: requesting [mem 0xd0000000-0xdfffffff], which
spans more than BOOTFB [mem 0xd0000000-0xd02fffff]

and then gives me a nasty callchain that is basically the amdgpu probe
sequence ending in amdgpu_bo_init() doing the
arch_io_reserve_memtype_wc() which is then what complains.

That "BOOTFB" resource is from sysfb_simplefb.c, and I think what
started triggering this is commit c96898342c38 ("drivers/firmware:
Don't mark as busy the simple-framebuffer IO resource").

Because it turns out that that removed the IORESOURCE_BUSY, which in
turn is what makes the resource conflict code complain about it now,
because

                /*
                 * if a resource is "BUSY", it's not a hardware resource
                 * but a driver mapping of such a resource; we don't want
                 * to warn for those; some drivers legitimately map only
                 * partial hardware resources. (example: vesafb)
                 */

so the issue is that now the resource code - correctly - says "hey,
you have *two* conflicting driver mappings".

And that commit claims it did it because "which can lead to drivers
requesting the same memory resource to fail", but - once again - the
link in the commit that might actually tell more is just one of those
useless patch submission links again.

So who knows why that commit was actually done, but it's causing annoyance.

If simplefb is actually still using that frame buffer, it's a problem.
If it isn't, then maybe that resource should have been released?

I really think that commit c96898342c38 is buggy. It talks about "let
drivers to request it as busy instead", but then it registers a
resource that isn't actually a proper real resource. It's just a
random incomplete chunk of the actual real thing, so it will still
interfere with resource allocation, and in fact now interferes even
with that "set memtype" because of this valid warning.

             Linus
