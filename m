Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C65C34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 13:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13EA208C4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 13:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/dWnbFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13EA208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BD3A6EA09;
	Tue, 18 Feb 2020 13:50:53 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31DF46EA09
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 13:50:52 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id w15so24033625wru.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 05:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tSRRC1bXjTyJxpOwsYIzSK14duvm2/XuO2LdrowF+/s=;
 b=h/dWnbFmqkEoasBG6wWQPPjGxUc2lV4EkOgoPVlOg1ZyLvuJbBWOu12O2PDUO0BlUo
 mCwpxG+uQcy/lCCTQIvhIKHMbOpcXZHC3gpJZMMdZ1Qrz7FkOCdz+aBy87fcmg2+DTzb
 8SRSHOxIoo6i7J/eq77ebD/q8WVmO6yZAY+QJg8ywh81EfgH18iyUk6oSdeyB74eREL7
 WLTU542tgJcFU5u/WV5cDcXMLHyTrIG3tYbq2p5oHvVp/uhdJaB+AgMWGqlnKaUXy6Qa
 bFXia+pW8hqva7guZdvGYI0h7X+iu6/Oa5qB28c8ld4+TPFMwww3+1fCbsvNwZ3Xk30V
 fsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tSRRC1bXjTyJxpOwsYIzSK14duvm2/XuO2LdrowF+/s=;
 b=fZc4DTdRcVRW66FUwKRL5UoPU49mPlsGgYoBRjHd9Jn6vaQ8dyOnaeUfol6RLdsjTN
 lIQW4uwb3Jw7rfcsrbT3bCe5JacCEHF8P8L5PvcPucM0HbYsR0T09+DYC4wOlZwqwLEz
 wgT2VIZxeG9GyY/UZorQ8l/MzHy8ihgqNP0Q/Pi9aPUbAzHafPWTbv0LRsYw2/JEzv72
 P8pROvxltSywIDUpo0xTLs4qfzfSk4UmmC7+Eiz0sW0xzrpF99JZch271/GFHAvJLFd2
 7DbP//cel+pObmKFGJLauVcar2aLGRMCxBnqncP9agWeOfh5vCfGVhu5JEo6MxaudvVl
 H1FA==
X-Gm-Message-State: APjAAAXXWN+UIsx8l8hwbTiR5sZacAiCdwtZ8Ru/jqo0vQ6SBN3yRi68
 1Me53QSQH6P1qdGFaLXqjuA3VWvRoLZR7OUmDgk=
X-Google-Smtp-Source: APXvYqy+czzc2iT8h/pQDzRqJSUjpIAy4Q8jFNQYn6edMIP2/Hjb+cp1A237Mm88ke2nSa38twE5Z2xxuHNF7E0f+J0=
X-Received: by 2002:adf:82c7:: with SMTP id 65mr2229270wrc.374.1582033850726; 
 Tue, 18 Feb 2020 05:50:50 -0800 (PST)
MIME-Version: 1.0
References: <CAGzVRjzs8rgaLkWcaxdAn-DUf3Kk70TW=NPM+Hk9SLt7Tcjsfg@mail.gmail.com>
In-Reply-To: <CAGzVRjzs8rgaLkWcaxdAn-DUf3Kk70TW=NPM+Hk9SLt7Tcjsfg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Feb 2020 08:50:39 -0500
Message-ID: <CADnq5_MutDzY0fdhX3anCQXFAOLkAbcMS3timfFEDFBqVc-jxA@mail.gmail.com>
Subject: Re: writing custom driver for VGA emulation ?
To: =?UTF-8?Q?Yusuf_Alt=C4=B1parmak?= <yusufalti1997@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBGZWIgMTgsIDIwMjAgYXQgMjo1NiBBTSBZdXN1ZiBBbHTEsXBhcm1hawo8eXVzdWZh
bHRpMTk5N0BnbWFpbC5jb20+IHdyb3RlOgo+Cj4gSGVsbG8gQU1EIHRlYW07Cj4KPiBJIGhhdmUg
RSA5MTcxIEdQVSBhbmQgd2FudCB0byB1c2UgaXQgb24gYSBlbWJlZGRlZCBzeXN0ZW0gd2hpY2gg
aGFzIGxpbWl0ZWQgTU1JTyBzcGFjZSBvbiBQQ0llIGJ1cyAoTUFYIDUxMiBNQikuCj4KPiBJIHJl
Y2VpdmVkIGZlZWRiYWNrcyB0aGF0IEkgY2FuIG9ubHkgdXNlIFZHQSBlbXVsYXRpb24gd2l0aCB0
aGlzIG1lbW9yeSBzcGFjZS4gSSB3YXMgdW5hYmxlIHRvIGdldCAnYW1kZ3B1JyBkcml2ZXIgd29y
a2luZyB3aXRoIFhvcmcgZHVlIHRvIEkgaGFkIG1hbnkgZXJyb3JzKGZpcm13YXJlcyBhcmUgbm90
IGxvYWRpbmcpIGluIGVhY2ggc3RlcCBhbmQgdGlyZWQgb2Ygc29sdmluZyB0aGVtIG9uZSBieSBv
bmUuCj4KPiBJIHdhbnQgdG8gd3JpdGUgYSBzaW1wbGUgY3VzdG9tIGRyaXZlciBmb3IgdGhpcyBH
UFUgd2l0aCBrZXJuZWwgdmVyc2lvbiA0LjE5Lgo+IElzIGl0IHBvc3NpYmxlIHRvIHByaW50IHNv
bWUgY29sb3JzIG9uIHNjcmVlbiB3aXRoIGEgY3VzdG9tIGRyaXZlciBvdmVyIFBDSWUgY29tbXVu
aWNhdGlvbiA/IG9yIHdyaXRpbmcgc29tZSB3b3JkcyBvbiBzY3JlZW4gYXMgVkdBID8KPgo+IElm
IGFuc3dlciBpcyB5ZXMsIHRoZW4gd2hpY2ggY29kZSBwaWVjZXMgKG9uIGFtZGdwdSBkcml2ZXIg
Zm9sZGVyKSBvciByZWZlcmVuY2UgZG9jdW1lbnRhdGlvbiBzaG91bGQgSSB1c2U/IEkgaGF2ZSBS
ZWdpc3RlciBSZWZlcmVuY2UgR3VpZGUucGRmLgo+Cj4gSSB3aWxsIGJlIGFwcHJlY2lhdGVkIGZv
ciB5b3VyIGd1aWRhbmNlLgoKVGhhdCBpcyBub3QgZ29pbmcgdG8gZG8gd2hhdCB5b3Ugd2FudCBv
biB5b3VyIHBsYXRmb3JtLiAgVGhlIFZHQQplbXVsYXRpb24gcmVxdWlyZXMgdGhhdCB5b3Ugc2V0
IHVwIHRoZSBjYXJkIGZpcnN0IHRvIGVuYWJsZSBpdCwgd2hpY2gKaW4gdHVybiByZXF1aXJlcyBN
TUlPIGFjY2VzcyBhbmQgdGh1cyB5b3UgYXJlIGJhY2sgdG8gc3F1YXJlIG9uZS4KCkFsZXgKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
