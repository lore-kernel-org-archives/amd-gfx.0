Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1C3FF8873
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 12:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2381910EBF2;
	Tue, 28 Apr 2026 12:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RQEGFp9o";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CFF10E96D
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 21:52:26 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-ba7a1cc0380so1769897066b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 14:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1777326745; x=1777931545;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
 b=RQEGFp9odf24Yt/w+kqr1+LS3ScvAZjzhvsZmvmnlnZs/81FuhxwIBx2VAIzK/WgZx
 UuBBhqtNpPqk1CaUtGOVbblXSS21Z55+neZa1b5RMM8RxMoICRycTZYiLavD+T8r92J/
 O+r9fPnlEKRxQHmKPV3/4nVJ/oYDaqZhN3yjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777326745; x=1777931545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
 b=Qajc8rA+98cJRKt1otIahg6MlDdujLXQ/2/vlwGnJzzJIUBjZW6MOTW+APm8aPEUXe
 jNyuSH5L96xVnowjj0mcnnOI8j0D86OY3Tc9N7zDg6EBS0TprcSW5kzQahV1v/J13P9V
 2dFFAipTzzCjoYUu5WC6TRzgyza0I+XETYGwo2M/tt5GiEoYS/up+9GE73YIG+wjRjGc
 tXBB7jdOQeBrlmW0+0+tsBjFyxCZAMOgs2epl+ODjFuSNdL7dCZT9Z9Rcy6DloEyauQT
 fTybHvYnPOHYLOkEaDe7si/yyfjN/N3HctPJhzERnDRvbNWEP7qFxt3fLR5b5wSOg+Iy
 Uy6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+p478s4UzkkaFaoMdvh5JSNfqob/JMrI4QT7sde8liPzeeSHmeXgNJvELuKlRQgxrS+HK9NXWJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZ9s6EmBrVbzUaV4AFtOEs/Ib84xP/bk/yNTd5ccIr6FfUqVdn
 9Ke3aUXKyjPBX1S4TUM+1CuAQcCwRe68RwL0yVKf9acSe6hbFFsTMID33sHQQfm3WEvuMfdq+FP
 /zHikj49+Fw==
X-Gm-Gg: AeBDiev6X0ooWpk1v/839DFDF6m8vGhhCj9WTkjNPVGF06wxFkZcO1CALdSLa4Ms9r9
 nIwXS/UqvERridsi3eYpu1W6wHWL+dXheq4AEhD3mSHv0Dk3yuQpZreAg3OjURLRkgybb+fj9S8
 +j5an97gCnTECA13l4eDU40VwR7AjV1PZQb/jbMxTD5mC+iqLiA1LUeuSZCpXX1ojOnNMaouoAJ
 eP0azHcPSpElKr4AdzcNNkhpySk6t7AZmFUMIhZc67jF2Lg4+Z5IAyPSE1PFOUgz6TLxP/IdIWX
 mjrfcIASHKEBroDDtWSLl03+cBhMHXc2anpTpPsxU/44cukn7dFbqxabvXLJW3EANdkpECugE2i
 Dydi6/fgwMMY7JiJtthn2JrKqsbUKJgAdJ/gIULM3yonTeAmCv8aHjGOD8wr9sc7FXqjdCt5D58
 ohi0bDdpjrBIoWkWP80sw74Ej6qnPXOHRWUHhrZug4s4HRZFa1qu4ocT7+uF1+Kzq8aE1uEbYqF
 rCiyWNEvqs=
X-Received: by 2002:a17:907:a191:b0:bac:707f:494a with SMTP id
 a640c23a62f3a-bb804440fc2mr19944666b.47.1777326744684; 
 Mon, 27 Apr 2026 14:52:24 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com.
 [209.85.208.54]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bb80c57f559sm9784966b.61.2026.04.27.14.52.22
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 14:52:23 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-677f7c29af6so9392458a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 14:52:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+R3uj5VkIx0qSBCpUWL8R/Au5YMjdn4p3dQKF14HTz1xzyeW0HfE9i2isrdwjz6bLg3RZX0g/4@lists.freedesktop.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org>
 <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org>
 <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, 
 David Laight <david.laight.linux@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, 
 linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
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

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus
