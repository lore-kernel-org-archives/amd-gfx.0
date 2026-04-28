Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F54FF886D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 12:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA85310EC00;
	Tue, 28 Apr 2026 12:54:22 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C98FA10E31D
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 09:25:27 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-678adefbd26so6409471a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 02:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777368326; x=1777973126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
 b=jSvgn0nWvz2Lv75G+2GqIUBeKJ0AlB/hva0sNdulC3n4haWeB99tnsYJYS1d+tndXX
 GlpC2q2H9J6lDxSsEtv3HUFIAoAdrm9Vz5IYdpDd2Fj6uw1kbwJ18/Zp+mlqNdHhk+d3
 LGVoSlaJBKenNw0uOBALAVyy15Ue8W9aPOnWJ8im8jNs/nt4KkGB6DiYdOi3DQxsx+sA
 I7XoGcXrOWuhLDALTAC2u+3NUtV32qVZRTtK4FYgNxeGS8iA5PHf4MEAXoQ+RUtq6vzJ
 DnqJ2BlICLlTyo2EoNNhunGUTRd13zTy/ZVKxrnwSdVippQ4ce3hC9G/1UKJx1cmyj0S
 jaDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/apairKplAGnXtOSzjBPsT/DEvtbXgrc4de547zAQyL3iKjLQkI+CzqtJrcA66XQ6B03ePmnW2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtAUNKzPdaV9kPrpgdqVHliK2H91lDKGUmqSci9J4WzBC9gY98
 4X4cw3HNURMqNMIwUcpWzbSaBiXAmyUEtqpPfjCFUtALUBg8zJez+HM8P+09E4s6pCg=
X-Gm-Gg: AeBDievqX6pnpbw8ZKeUmNB+tdpDkDuF1VYtB5hwAsqA0K/cC3vrevSgcxANLYeIN87
 ExMSP7DU/fBG1V4fiBYQaHlN2AZ0lIhtLjvFKLCUTCW6+WrM0SSt76MJ6hgXg+j8KjC+ySjkHr9
 cv/r4IWx/ZHzPdwKVawE24Na+SnBQSkf1Y5QsfW3aHMdd/4agA2kEToEaUFIwulTXRgeBY7Avhx
 rUXsi01uWhGog3jsmvkDEnAAjctyEVNw/jrvJ5Rx690IsDDdO4XJWugx4H2Wp44b0p7NyixPIgz
 clHkbFswlP5Tf3357w0gawOJkRMOJmgQ7nUW45X0Ao1mbbdziBsJS/1iQT+4PcvarKhyvKMN1Xe
 jvuTzruQrPh0T1u4Hh+/02pU0rdaQHbZvW4/O2La1cRw+Z5wXVk2kmzqEnWoNMMIEzeCtj/tXg9
 YMgxr23CHMFUn41vd/10xRSr570AKhCqkzmQShtU5iklE7CE9kzLjq/Z9uNl1Gog0ENT01WX0=
X-Received: by 2002:a17:907:a286:b0:ba3:bf80:69e0 with SMTP id
 a640c23a62f3a-bb804c32e53mr152988966b.42.1777368326074; 
 Tue, 28 Apr 2026 02:25:26 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bb80c57f559sm73055566b.61.2026.04.28.02.25.24
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 02:25:24 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-678adefbd26so6409410a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 02:25:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+8aB2M0sGilEqJ3nN9HVw6oI4j1zWh4V5a5ZhWqS2V8u2ALBn418onWSI4tCWfh5Jq/mfCvBJe@lists.freedesktop.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org>
 <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce
 copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Laight <david.laight.linux@gmail.com>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
 dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 28 Apr 2026 12:54:20 +0000
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

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
