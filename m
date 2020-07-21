Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC915C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 19:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACC32068F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 19:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K2nZxYuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACC32068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FCA56E06E;
	Tue, 21 Jul 2020 19:06:05 +0000 (UTC)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F3666E454
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 19:00:38 +0000 (UTC)
Received: by mail-pf1-x441.google.com with SMTP id 1so11172626pfn.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=z7r+tykWJeqyUt+0w32i8HpBG73ZF426jmYt8FWFXXg=;
 b=K2nZxYuSsZMrLPLzyUJFpDo78L0fWs1qa1pyFS0dED7D85EPDvugXZNiC6I4kYNyaj
 QVuNzYcQ9C1wAQ9KfL95/gpg1xghQUSwychQJx9ETTXmZ5CtgqSOEgLlvXQgzzQft6d5
 NXH7njx4hhVgj3kjD8v4NwD7xU/MdKbe/sm7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=z7r+tykWJeqyUt+0w32i8HpBG73ZF426jmYt8FWFXXg=;
 b=bPoytbA/9URuu1SwVeyLlJmhI66wCIP5mWd22YD8hglu2l/pkQJXzXHoV6WpngFRQ5
 XL7JnbLLeUUPJMcfQHPgwA9YzA+tCSe6wCU6IMNuM+Gnaql+9A8eHaq7jLt6njt0wSlG
 XdIexjZIeU8OY/V9g9b1C9W2OPA2NlAleduJXe2XjnGCIkEy1dAT4e+f6ObVH+WTjZ89
 pBs128U82GN79vQuZohlZ8xZ+Wudqckazg2aEP34odk5cZc4rvpuH1TUeWIg3BoM+6mi
 EVTX1q6R2TMM5Cm/JMwR96izhMsd1PPtwcuMt860LYQjnd8w99HMLYK3Kem9bic1R2+U
 WJ4A==
X-Gm-Message-State: AOAM532HESVdg4pBsLI2YQl80XNoyfU/EPUGaAysFTuLCeYloYTRiinq
 IZoEE+3lhL61AbYXGoQqL+RnWA==
X-Google-Smtp-Source: ABdhPJzFRVwhgZiNvdtFdhMOJEbWQvREg/oK2BKjqDkHDbM1u9rD/uol5R217ObAI8/HuNJS1XXZqA==
X-Received: by 2002:a63:df03:: with SMTP id u3mr22870077pgg.84.1595358037787; 
 Tue, 21 Jul 2020 12:00:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id z9sm18970158pgh.94.2020.07.21.12.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 12:00:36 -0700 (PDT)
Date: Tue, 21 Jul 2020 12:00:36 -0700
From: Kees Cook <keescook@chromium.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [Regression] hangs caused by commit 3202fa62fb (slub: relocate
 freelist pointer to middle of object)
Message-ID: <202007211156.D8BEDEA247@keescook>
References: <15cbac6d-1f96-2ba9-cb54-08af6682f56d@molgen.mpg.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <15cbac6d-1f96-2ba9-cb54-08af6682f56d@molgen.mpg.de>
X-Mailman-Approved-At: Tue, 21 Jul 2020 19:06:03 +0000
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
Cc: Anthony Ruhier <anthony.ruhier@gmail.com>, Duncan <1i5t5.duncan@cox.net>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Andrew Morton <akpm@linux-foundation.org>, Vinicius <mphantomx@yahoo.com.br>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKdWwgMjEsIDIwMjAgYXQgMDQ6NTU6MTJQTSArMDIwMCwgUGF1bCBNZW56ZWwgd3Jv
dGU6Cj4gTm8gaWRlYSwgaWYgeW91IGFyZSBhd2FyZSBvZiBpdCB5ZXQsIGJ1dCB0aHJlZSBwZW9w
bGUgdmVyaWZpZWQgdGhhdCBjb21taXQKPiAzMjAyZmE2MmZiIChzbHViOiByZWxvY2F0ZSBmcmVl
bGlzdCBwb2ludGVyIHRvIG1pZGRsZSBvZiBvYmplY3QpIGNhdXNlcyBhCj4gcmVncmVzc2lvbiBv
biBBTUQgaGFyZHdhcmUgWzFdLgoKSGksIHRoYW5rcyBmb3IgZW1haWxpbmc7IEkgZG9uJ3QgZ2V0
IGJ1Z3ppbGxhIG5vdGlmaWNhdGlvbnMsIHNvIEkgaGFkbid0CnNlZW4gdGhpcyB5ZXQuCgo+IEl0
4oCZZCBiZSBncmVhdCwgaWYgeW91IHRvb2sgYSBsb29rLCBhbmQgYWR2aXNlZCBpZiB0aGlzIGNv
bW1pdCAoYW5kCj4gZm9sbG93LXVwcykgc2hvdWxkIGJlIHJldmVydGVkLCB1bnRpbCB0aGUgaXNz
dWUgaXMgYW5hbHl6ZWQuCgpUaGVyZSBoYXZlIGJlZW4gYSBudW1iZXIgb2YgZml4ZXMgdG8gdGhh
dCBjb21taXQgKHdoaWNoIEkgc2VlIGFyZQptZW50aW9uZWQgaW4gYSBxdWljayBza2ltIG9mIHRo
ZSBidWcpLCBidXQgdGhleSd2ZSBtb3N0bHkgYmVlbiBhcm91bmQKYWRkaXRpb25hbCBzbGFiIGRl
YnVnZ2luZyBmZWF0dXJlcy4gSWYgaXQncyBjYXVzaW5nIGEgcHJvYmxlbSBvdXRzaWRlCm9mIHRo
YXQsIG15IGluc3RpbmN0IHdvdWxkIGJlIHRoZXJlIG1pZ2h0IGJlIGEgdXNlLWFmdGVyLWZyZWUg
aGFwcGVuaW5nLApidXQgSSdsbCBnbyByZWFkIHRoZSBidWcgbW9yZSBjbG9zZWx5IG5vdywgYW5k
IGNvbW1lbnQgdGhlcmUgKG9yIGhlcmUsCmlmIG5lZWRlZCkuCgpUaGFua3MhCgotLSAKS2VlcyBD
b29rCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
