Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E57C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 07:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A93B40E2;
	Fri,  5 Aug 2022 07:24:06 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DECBA2B8F4
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Aug 2022 21:59:20 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id w19so1693232ejc.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Aug 2022 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=IcNrO1+0hMqd184OyaCGXcplDsRzgmMXiA2NSTUXMiA=;
 b=DgUfEmbFi+7iccqebXv/ZmxHK9r9RdQFXNZ8Dr8nUqVqSFRu1k1i4dkyHQybTDWbVO
 sp+j5Hqj+Tzo+GWbTEgXuKCuNQljNQ9hMiFfoJp1J9Mgms1GKmSOP/+HzKIHuHs4qy4O
 3hYvbGIWtatQX31kWhmvlVBT2gIyBbOi9AxB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=IcNrO1+0hMqd184OyaCGXcplDsRzgmMXiA2NSTUXMiA=;
 b=Rt8pxaG4i/iZ5k4H/+qRArYv0bkYR+nNpQt+47gyBvjgP6/mqbyCzD8/IUbq2EFndx
 ypzOOUHmypwigFNjFHBmmceAJU/BQQSstyi0dgYWSt2uGSICz/HRyqjCrk101iv89pzQ
 G/a1MVZYN2IUTx5lcwDwF+lKxFEi0IuwzbjSro2W+kBHqEglh9dMlCvu4mBQ0TFzhlQ0
 LeO90thVLsr2bwtFiho5R6PO48RtWQAX5Eezd+SwifMn+gRcn5EHOlQsCtpsZV6YUGlM
 uXuAgmRu6JC4ByS2b08NdRHPeS5Nw5oKwKvbdwbZrco5vAqyJlgCkw2mHeVbEjhdrrfb
 u8QA==
X-Gm-Message-State: ACgBeo0NQ/6AQHH2xFpliq+MP03LMWH8+D7TVRvtBmYVLQ9nidk70N33
 NgRvkd4AoD8bq3wGQMGaL0XO1SU85ZLgnoZW
X-Google-Smtp-Source: AA6agR7Ea5yZCD2MnYhuj0ME3E7n7ustfgZ+QX47mCat4HvEg2+tykGnZoUze9tzmpz7MFED1GJVSg==
X-Received: by 2002:a17:907:2d12:b0:72b:67fb:89a5 with SMTP id
 gs18-20020a1709072d1200b0072b67fb89a5mr2883968ejc.507.1659650358884; 
 Thu, 04 Aug 2022 14:59:18 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com.
 [209.85.221.48]) by smtp.gmail.com with ESMTPSA id
 23-20020a170906329700b007305c007e43sm772159ejw.135.2022.08.04.14.59.17
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Aug 2022 14:59:18 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id p10so1228528wru.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Aug 2022 14:59:17 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr2534090wru.193.1659650357549; Thu, 04
 Aug 2022 14:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <YuwRyQYPCb1FD+mr@debian>
 <CAHk-=whptVSSZL=wSUQJdRBeVfS+Xy_K4anQ7eQOky7XUrXhUQ@mail.gmail.com>
 <CAK8P3a2bEaExue0OtNeLa2CVzBx-1dE9w2HZ2PAV5N8Ct9G=JQ@mail.gmail.com>
 <YuwvfsztWaHvquwC@dev-arch.thelio-3990X>
In-Reply-To: <YuwvfsztWaHvquwC@dev-arch.thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Aug 2022 14:59:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpa_FJjvzWdWdSzecTbVtndbQqg35=_o+ohM3X1_xKTA@mail.gmail.com>
Message-ID: <CAHk-=whpa_FJjvzWdWdSzecTbVtndbQqg35=_o+ohM3X1_xKTA@mail.gmail.com>
Subject: Re: mainline build failure for x86_64 allmodconfig with clang
To: Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 05 Aug 2022 07:24:03 +0000
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
Cc: Arnd Bergmann <arnd@kernel.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@linux.ie>, clang-built-linux <llvm@lists.linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 "Sudip Mukherjee \(Codethink\)" <sudipm.mukherjee@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 4, 2022 at 1:43 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> I do note that commit 1b54a0121dba ("drm/amd/display: Reduce stack size
> in the mode support function") did have a workaround for GCC. It appears
> clang will still inline mode_support_configuration(). If I mark it as
> 'noinline', the warning disappears in that file.

That sounds like probably the best option for now. Gcc does not inline
that function (at least for allmodconfig builds in my testing), so if
that makes clang match what gcc does, it seems a reasonable thing to
do.

            Linus
