Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7FCC2BA12
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 15:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F132072E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 15:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="arhfmja5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F132072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 008A86EAB7;
	Thu,  2 Apr 2020 15:05:55 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C56B6EAB0
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 14:50:47 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id r7so3479164ljg.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Apr 2020 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0qdeGekIQvzSZQ/bchGHqOPc0D8b8p/R5z9ULmhHISQ=;
 b=arhfmja5XpBIHDuFu7oNorGl4wxrU0DpZmvk3vHpL0QOXMDs1U44LN6ygn3MBJ/eR3
 3wLXRbPkBU+NCWdir2hE0fYj+xCGAf31wkRp7hNMxDnwTg3711UfFAbMQIBv8rl0gnzS
 6zF+2Rbql09DPKB+8obYRkfmSPme12s2Kds2gbdUQxcs6t0y0mRwoEjxEm0rTT/uX5kR
 NNRtmJkZuVEVGSLeq191W5Hbi2hNkc/+mLCYkevKLXtKekdZt6pKC3QFksb7rD6s4dE6
 v2wHRLKK3slv+B7Va2Jr0nwgP5poY2NSI6ZEJmImTZ9gAcKu3XNK9O+8dChhnTt63LcN
 UFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0qdeGekIQvzSZQ/bchGHqOPc0D8b8p/R5z9ULmhHISQ=;
 b=ON+3ZXQQqeQP7cm4AYo24DjDqLCr4QUkQTwTuvDvqhjqMokm6x4+H5zISDN8au0/cC
 xqcteXH5+VN0x1aTt4cGlw3lGFTiMJdP2EntU8oZK1/Y/yZrAiPka2U+lMYxFYgS9Mnl
 XkewcOiEauPoYYvgOMaA4HU8w6x39Eb9kTCVlAXDdTsGCXbDqLNHVrvqk6RGpkbGPf6+
 rRjtMP2Q9FkvBGkSZvEZ0FSQ5CwLMjRxQt9KynICQlJ4cv7Bbw6bBvSJ+x3ZtjzJK4Zg
 KjxUHJcfTuoCfvJDxY5qnlRvsOmXrfVQug3GNqVjF9yYufGDTiv5bkm7AyqNZUzgxqyt
 HQlw==
X-Gm-Message-State: AGi0Pua2HU7WHDyLmpYhsNIXspLyztVpFanA5cUTb4To0ggDzEysPK0c
 Gf1CVL7nPsRxfXM+v0yTuW3Lb5o6t+F7TuGx0grHxg==
X-Google-Smtp-Source: APiQypK+T2KMF7eZlc/bzKtEy+1N95v/ZTucX9SRvM+kNdBq97blBB+uE/UoYTni754wd6YAZlQUSWnSxRjy3C1jCUk=
X-Received: by 2002:a2e:5048:: with SMTP id v8mr2060638ljd.99.1585839045709;
 Thu, 02 Apr 2020 07:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <CAG48ez1nHt2BRApHPp2S6rd4kr3P2kFsgHvStUsW7rqHSJprgg@mail.gmail.com>
 <87k12yns9z.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87k12yns9z.fsf@nanos.tec.linutronix.de>
From: Jann Horn <jannh@google.com>
Date: Thu, 2 Apr 2020 16:50:19 +0200
Message-ID: <CAG48ez1esuROQU1J1L4Zrt91vRX4GYwzrfAs+K5mr-_TLq3saQ@mail.gmail.com>
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
To: Thomas Gleixner <tglx@linutronix.de>
X-Mailman-Approved-At: Thu, 02 Apr 2020 15:05:53 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Leo Li <sunpeng.li@amd.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBBcHIgMiwgMjAyMCBhdCAxMTozNiBBTSBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGlu
dXRyb25peC5kZT4gd3JvdGU6Cj4gSmFubiBIb3JuIDxqYW5uaEBnb29nbGUuY29tPiB3cml0ZXM6
Cj4gPiBPbiBUaHUsIEFwciAyLCAyMDIwIGF0IDk6MzQgQU0gQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPiA+PiBBbSAwMi4wNC4yMCB1bSAwNDozNCBz
Y2hyaWViIEphbm4gSG9ybjoKPiA+PiA+IFt4ODYgZm9sa3MgaW4gQ0Mgc28gdGhhdCB0aGV5IGNh
biBjaGltZSBpbiBvbiB0aGUgcHJlY2lzZSBydWxlcyBmb3IKPiA+PiA+IHRoaXMgc3R1ZmZdCj4K
PiBUaGV5IGFyZSBwcmV0dHkgc2ltcGxlLgo+Cj4gQW55IGNvZGUgdXNpbmcgRlBVIG5lZWRzIHRv
IGJlIGNvbXBsZXRlbHkgaXNvbGF0ZWQgZnJvbSByZWd1bGFyIGNvZGUKPiBlaXRoZXIgYnkgdXNp
bmcgaW5saW5lIGFzbSBvciBieSBtb3ZpbmcgaXQgdG8gYSBkaWZmZXJlbnQgY29tcGlsYXRpb24K
PiB1bml0LiBUaGUgaW52b2NhdGlvbnMgbmVlZCBmcHVfYmVnaW4vZW5kKCkgb2YgY291cnNlLgpb
Li4uXQo+IFdlIHJlYWxseSBuZWVkIG9ianRvb2wgc3VwcG9ydCB0byB2YWxpZGF0ZSB0aGF0Lgo+
Cj4gUGV0ZXIsIG5vdyB0aGF0IHdlIGtub3cgaG93IHRvIGRvIGl0IChub2luc3RyLCBjbGFjL3N0
YWMpIHdlIGNhbiBlbWl0Cj4gYW5ub3RhdGlvbnMgKHNlZSBwYXRjaCBiZWxvdykgYW5kIHZhbGlk
YXRlIHRoYXQgYW55IEZQVSBpbnN0cnVjdGlvbiBpcwo+IGluc2lkZSBhIHNhZmUgcmVnaW9uLiBI
bW0/CgpPbmUgYW5ub3lpbmcgYXNwZWN0IGlzIHRoYXQgZm9yIHRoZSAibW92ZSBpdCB0byBhIGRp
ZmZlcmVudApjb21waWxhdGlvbiB1bml0IiBtZXRob2QsIG9ianRvb2wgbmVlZHMgdG8ga25vdyBh
dCBjb21waWxlIHRpbWUKKGJlZm9yZSBsaW5raW5nKSB3aGljaCBmdW5jdGlvbnMgYXJlIGluIEZQ
VS1lbmFibGVkIG9iamVjdCBmaWxlcywKcmlnaHQ/IFNvIHdlJ2QgbmVlZCB0byBoYXZlIHNvbWUg
c29ydCBvZiBmdW5jdGlvbiBhbm5vdGF0aW9uIHRoYXQgZ2V0cwpwbHVtYmVkIGZyb20gdGhlIGZ1
bmN0aW9uIGRlY2xhcmF0aW9uIGluIGEgaGVhZGVyIGZpbGUgdGhyb3VnaCB0aGUKY29tcGlsZXIg
aW50byB0aGUgRUxGIGZpbGUsIGFuZCB0aGVuIGxldCBvYmp0b29sIHZlcmlmeSB0aGF0IGNhbGxz
IHRvCkZQVS1lbmFibGVkIG1ldGhvZHMgb2NjdXIgb25seSB3aGVuIHRoZSBGUFUgaXMgYXZhaWxh
YmxlPyAoSWRlYWxseQpzb21ldGhpbmcgdGhhdCBjb3ZlcnMgaW5kaXJlY3QgY2FsbHMuLi4gYnV0
IHRoaXMgd291bGQgcHJvYmFibHkgZ2V0CnJlYWxseSBjb21wbGljYXRlZCB1bmxlc3Mgd2UgY2Fu
IGdldCB0aGUgY29tcGlsZXIgdG8gaW5jbHVkZSB0aGF0CmFubm90YXRpb24gaW4gaXRzIHR5cGUg
Y2hlY2tpbmcuKQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
