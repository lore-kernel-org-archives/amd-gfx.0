Return-Path: <SRS0=sK2M=GF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAB0C433E0
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Jan 2021 18:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810DA20781
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Jan 2021 18:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810DA20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 982748994A;
	Sat,  2 Jan 2021 18:51:08 +0000 (UTC)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E337D8985A;
 Sat,  2 Jan 2021 18:51:06 +0000 (UTC)
Received: by mail-ua1-f52.google.com with SMTP id f29so7764086uab.0;
 Sat, 02 Jan 2021 10:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=teE+wQrrx7cVgqEbQRcBD7sPlQgvAsZl/37kjGyn5Sg=;
 b=fldfID3X9nEy1LYqksdNqOu0uiPfvavczxI01gyKlH136vwuplFW4oeMNsf4FWWc5Q
 MocyqQrY65xWbC93oleWKhggHekEB8Bfik7tyLhWU4pp3mSFlZKa/wp26rQneGqOIQFT
 MX6juEy1IaSdaGXNCQtW0LaRZ9qwy+mDX1lnRJGnuiJjjuZ7DVksjs8ed3OCI9rlanv0
 /cYe11Gt5ICYwExdxwWDvik+OVn6hRbm3vul9AeORNQPKtqxYvslNXBMB/4KWRnhvUkl
 MXsgh9wy1IPm9qpy0Zk/ye87qejoz4gg0CX2VOa7jmZHJ5spFSgwMHkysJMm5aRDRsMs
 WdBg==
X-Gm-Message-State: AOAM531D2YXY5x3UHVdVbsQJ/vO/w6PhHuIE72x54plWe77pNl/Eg1mN
 p6T0q/rjfJv6yPAWGvAt7D9P/ElKq9ROftedF9I=
X-Google-Smtp-Source: ABdhPJyERbt+nwwoGvYgcJnuOc0lp3W/cwLKKeX3tFnYg9asFNbPuYUVn6QwhHkiuLgAApzS2VTVFGlQLGQSEG7s4/k=
X-Received: by 2002:ab0:32cb:: with SMTP id f11mr41557662uao.109.1609613466122; 
 Sat, 02 Jan 2021 10:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20201231205136.11422-1-mario.kleiner.de@gmail.com>
 <CAP+8YyE4H5mL3uj-T4uG0nz75XmgaZ6etXX6YxxdtO4-rL=5qA@mail.gmail.com>
 <CAEsyxyiLrpB872LdAW8-HMVC-rxf7YF8K+B51Ae9nyEvGaG1Sw@mail.gmail.com>
 <CAP+8YyHcUt0Rv_0ov5DCcm+wxeQFCqiW1vC_Pe4TdKzRzmu3fw@mail.gmail.com>
 <CAEsyxyiRNz8GRfM1hAxzVHAFwYzkyiM6OTvvjOAHtQCoCyhRjg@mail.gmail.com>
In-Reply-To: <CAEsyxyiRNz8GRfM1hAxzVHAFwYzkyiM6OTvvjOAHtQCoCyhRjg@mail.gmail.com>
From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Sat, 2 Jan 2021 13:50:55 -0500
Message-ID: <CAKb7UvhTtJ_w65ESmvb216Nf=YyQ7=3_HjXtoGTNP1azqVeo4A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix pageflipping for XOrg in Linux 5.11+
To: Mario Kleiner <mario.kleiner.de@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Jan 2, 2021 at 1:35 PM Mario Kleiner <mario.kleiner.de@gmail.com> wrote:
> I'm less sure about nouveau. It uses modifiers, but has atomic support
> only on nv50+ and that atomic support is off by default -- needs a
> nouveau.nouveau_atomic=1 boot parameter to switch it on. It seems to
> enable modifier support unconditionally regardless if atomic or not,
> see:
> https://elixir.bootlin.com/linux/v5.11-rc1/source/drivers/gpu/drm/nouveau/nouveau_display.c#L703
>
> Atm. nouveau doesn't assign a new format_info though, so wouldn't
> trigger this issue atm.

Note that pre-nv50, no modifiers exist. Also,
drm_drv_uses_atomic_modeset() doesn't care whether the client is an
atomic client or not. It will return true for nv50+ no matter what.
nouveau_atomic=1 affects whether atomic UAPI is exposed. Not sure if
this impacts your discussion.

Cheers,

  -ilia
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
