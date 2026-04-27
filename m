Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A67FF886D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 12:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E5210EBF5;
	Tue, 28 Apr 2026 12:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="MDstamMX";
	dkim-atps=neutral
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A50EC10E8A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 18:07:31 +0000 (UTC)
Received: by mail-wr1-f74.google.com with SMTP id
 ffacd0b85a97d-43d1fec59c9so6958386f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777313250; x=1777918050;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=HxkgeF4LNZGOlYkWj+Rbzgew6yzkspsu2lszfChr6II=;
 b=MDstamMXoYtgZM+AIHetO15cwSAKNTGBy0XR0YK+RWA3oNdUV92KDBznEzW3pQA9D6
 51p1VOzgujlP6NFjHtZ5oZYxuhzPxqAJNH7MC2LuoQ/r7Nw7L15dVO95jh1lEZFbgKEr
 9LklWwrt5dJn8RwFmpkhqxEfDu001+QvWLN4irp20qgosEvJPUbqEr9EzPGr2vdixe/X
 TwBEWTwyYfD5iZXup+8lql4BqpxI1kQJerObeFDpkSykU7Q7XH6lu2MXo2C8lpzJciu8
 ccXB1uYOQsjOIutmU3rfJHtuHeudZMeTIrNldTXTZ2nWQ26QoqMZmzJbxWFwUy29L+W+
 W8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777313250; x=1777918050;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HxkgeF4LNZGOlYkWj+Rbzgew6yzkspsu2lszfChr6II=;
 b=OEipXQxhTPltg+PTBlRMVH/NzGksECoyCRTLNXst81HBlYPeKUCRwcIF0+DAbc6rni
 xx9HAKpJUTvx3iF/AW/EAewufrxv0ahdZOc2ieIToIAuvOenRmNy4RxFdXkAZn723QEZ
 wfdZ+aaTItJ2ArIys5OnpCtRbFsTtMEKuHHUx0IjxDvP6TXrbmRG/ba9LKX64InBRMSB
 /O+7PfTOe9hpr/WRrxDm5VltWL80lSd1qNEqpzgIgZUCpMCKMej2h6AMgWlIyH2zV9Yd
 Lrgle3OX4Gy46ngUfnGcQQLZmE8W2QYTwwaMeH40JUSk2AMp4m0jrzeFZkVVkK8peBjk
 FOVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PGgvg+Jz6ZTHfjxp9GzRC0cp9fn/3lciqqr3uyWgwtmeOIMBeWiFM/ekysZmsmh7eACZgImie@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLoSRqdcIMfwsf8h0XB53fmS0KwkPkgv1XOnhlBx1el1eXJRiD
 VNJFt6MuKddhyvloj2Ik8JKfC68WLf9NroSLUKqFzwqFb8Utvzr1D+2CKHHrm9yNotdZteohS7s
 H0xQYVCvAIgCS+0YEXA==
X-Received: from wrmd3.prod.google.com ([2002:adf:e883:0:b0:43d:7940:a11b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:41c7:b0:43d:799c:b2cb with SMTP id
 ffacd0b85a97d-44636a393e7mr256856f8f.24.1777313249648; 
 Mon, 27 Apr 2026 11:07:29 -0700 (PDT)
Date: Mon, 27 Apr 2026 18:07:28 +0000
In-Reply-To: <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
Mime-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org>
 <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
Message-ID: <ae-l4FGDPLwBuDXM@google.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to
 copy_{to/from}_user_partial() when relevant
From: Alice Ryhl <aliceryhl@google.com>
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
Content-Type: text/plain; charset="utf-8"
X-Mailman-Approved-At: Tue, 28 Apr 2026 12:54:19 +0000
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

On Mon, Apr 27, 2026 at 07:13:46PM +0200, Christophe Leroy (CS GROUP) wrote:
> diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
> index 01de4fbbcc84..710e07cd60ae 100644
> --- a/rust/helpers/uaccess.c
> +++ b/rust/helpers/uaccess.c
> @@ -5,13 +5,13 @@
>  __rust_helper unsigned long
>  rust_helper_copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
> -	return copy_from_user(to, from, n);
> +	return copy_from_user_partial(to, from, n);
>  }
>  
>  __rust_helper unsigned long
>  rust_helper_copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> -	return copy_to_user(to, from, n);
> +	return copy_to_user_partial(to, from, n);
>  }

No Rust code uses the return value for anything other than comparing it
with zero, so you can keep these as copy_[from|to]_user() without
issues.

Thanks, Alice
