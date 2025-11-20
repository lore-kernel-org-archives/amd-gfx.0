Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53D1CF9C74
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 08:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F30B010E7FB;
	Fri, 21 Nov 2025 08:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JrUOINTS";
	dkim-atps=neutral
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com
 [209.85.166.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D21310E761
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 14:52:48 +0000 (UTC)
Received: by mail-il1-f182.google.com with SMTP id
 e9e14a558f8ab-435a16798feso7420195ab.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 06:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763650367; x=1764255167;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mIp1emodWmrQX+c6TjoXmEBGWcecINECr9nK+dGHBUw=;
 b=JrUOINTSppNhoQhfX8k5syViccp3259yTxwk6ESjnwwTGWo+zCVh5Q5uru8gOo05MP
 E4wTlNeBb4F+6CK4uXm+lkS2b6vVrKRGPppQnSUoiuEMFlwEb7m05J5gjIsTDPNPunCC
 oY8Sm+3eeeq3FzZj8eRbLg4uWmMfhEHZNRXchbVKZ5q5lpDnjgK/Gi4Lbi8aGBEOGLI/
 YiHyXmk88PBRjKMzLH2syDRrgiZ3xoA1vV14frmqjnnNq6Ci2jzF7sYUQ3RWJqEp+/1C
 g8fzqYXu4vWqBOAqmoXSXxm23JeWxTlaNhVUaA5FyL8mSH2zIVciMf2GBUgEB3czdAUA
 FLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763650367; x=1764255167;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mIp1emodWmrQX+c6TjoXmEBGWcecINECr9nK+dGHBUw=;
 b=Vg+i5N4FWHIZNiCAwVrxgZZkXIG3iLzwq6Ilqt36RMn24RFwidGXCVB0j8IyE5CLLc
 DmVvesH+TWGHVhpBsZ8MVSOYqKSdHPLayQDLWcXrT3hCav1IfQ/QBmje7dmXIuNLSXv9
 dpoKQbc+LxrB29Cs0HA8Nbyd8Fq9YtmueCJvpXy1eH2Tv2hw4xpNgkFUNqPBqCFIcYF+
 +NAKe/LME3ESl9qePAMG39OwiAQeDosCcBnRDpy7LaNYgP+vt7ztf+FZrSIaA5S0HsoX
 +Mehajku4/Gj9mukW+SE/jKchNx1YkFjM7u6Qhc2CPnQSN2gMogHzVFZtIivJdHvNByN
 Vq+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKYifvLv+Dgiz0Szwce+QpTu+oYLW0SCzoxWQhLLJBtyNDHQvYrUV5HLJB3Wm0XfzPmoPZ9r2h@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcBU6i3Wr0s06EZPwK52LjOO7zkT9Z7iB/3hL5Lf/Qe80qVcor
 fq6oTku+7xlaT9mjUfx8BrwOJbfqArVwA5CJ8TSmxe5h83yxymNMquunT4uvieDQVpg=
X-Gm-Gg: ASbGncudcHDnbXtUdLRlZyNFmuUZqJXKyP6oERfk7/An9MDRlc2RAqbt6V3DjL25zfO
 b+EZjXoU2uNW0KK6ZFqAWSNcAH47jtuqPGf20x7LTBYEF9rMz+RuXhfoJJu8zHOk0ClOCwUwlXn
 Z4osMKlC5ARTtn7+k8XtuNOZ6UNANKvunO9wa34MhU7qQEwumwY8eqArpFXbNWivrBLq+WdQwGY
 TsxwcodjGPbqE6gKenil/4OEynABTHPIVba0yt0CR0oXelOXCmNFQgsgin2bobwnXvcpI1CDM3Y
 /Xg1ykmpScrJRxrsnWw45MqjIKX+6GsNZBbqV7RymyISpUcbcGhDuFWaBUUMQSnLI9pShBWoxiQ
 0p+m7cKmjktgg7VzfB9yCtHfDXzzm1QsmexMw2XtaufpmWVNHro1YMI1JYbBaCjJiyd0bAvEPqA
 wHkw==
X-Google-Smtp-Source: AGHT+IEmRlVKCe07qbgo1t2w3uFpBKsqx62crTftDC+8sZ0oUBIrcGL53VTRakva//fmnWvcfQrQww==
X-Received: by 2002:a05:6e02:1c01:b0:433:1d5a:5157 with SMTP id
 e9e14a558f8ab-435aa88e822mr21434775ab.6.1763650367018; 
 Thu, 20 Nov 2025 06:52:47 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5b954b207d7sm1008611173.33.2025.11.20.06.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 06:52:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, david.laight.linux@gmail.com
Cc: Alan Stern <stern@rowland.harvard.edu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Andrew Lunn <andrew@lunn.ch>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 "David S. Miller" <davem@davemloft.net>, Dennis Zhou <dennis@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Jiri Slaby <jirislaby@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 John Allen <john.allen@amd.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Juergen Gross <jgross@suse.com>, Kees Cook <kees@kernel.org>, 
 KP Singh <kpsingh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Mika Westerberg <westeri@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Miklos Szeredi <miklos@szeredi.hu>, Namhyung Kim <namhyung@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, nic_swsd@realtek.com, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Olivia Mackall <olivia@selenic.com>, Paolo Abeni <pabeni@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Huewe <peterhuewe@gmx.de>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Sean Christopherson <seanjc@google.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
 Theodore Ts'o <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>, 
 Tom Lendacky <thomas.lendacky@amd.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, x86@kernel.org, 
 Yury Norov <yury.norov@gmail.com>, amd-gfx@lists.freedesktop.org, 
 bpf@vger.kernel.org, cgroups@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org, 
 kvm@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-cxl@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-mm@kvack.org, 
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
 usb-storage@lists.one-eyed-alien.net, David Hildenbrand <david@kernel.org>
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Subject: Re: (subset) [PATCH 00/44] Change a lot of min_t() that might mask
 high bits
Message-Id: <176365036384.566630.2992984118137417732.b4-ty@kernel.dk>
Date: Thu, 20 Nov 2025 07:52:43 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Fri, 21 Nov 2025 08:57:04 +0000
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


On Wed, 19 Nov 2025 22:40:56 +0000, david.laight.linux@gmail.com wrote:
> It in not uncommon for code to use min_t(uint, a, b) when one of a or b
> is 64bit and can have a value that is larger than 2^32;
> This is particularly prevelant with:
> 	uint_var = min_t(uint, uint_var, uint64_expression);
> 
> Casts to u8 and u16 are very likely to discard significant bits.
> 
> [...]

Applied, thanks!

[12/44] block: use min() instead of min_t()
        commit: 9420e720ad192c53c8d2803c5a2313b2d586adbd

Best regards,
-- 
Jens Axboe



