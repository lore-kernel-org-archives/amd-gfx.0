Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A3BCA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 18:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48BCA20862
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 18:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BCA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C126E9B6;
	Mon, 28 Oct 2019 18:10:25 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7990E6E9B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 18:10:23 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id w9so10159531wmm.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 11:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vrfnUD97dhu5Tmt2+okj0Inaw330n9kMgA3Vgk2F0uA=;
 b=mIByjSiO//MfeQpzLT+uZSYgCKLWx/76YlS8a0cMD9ZR7k3VZdZppMC8s0kGGYwkF/
 rwvnHEC9LS3VvOlOjMqgOJstRkRqdo9AUmcTIHOIHuTuBDWRVdt86Aw8ix+eB99xFyPB
 vWGOrtwCBNw6+npvlS0rq5UC3+va8K/Y1Q4ybxYtbJ6PqsbY8Ev+r9yZAl9DDQh9xf2/
 dEgbf7kgkYHqepQBRcpml8IafMf9hNP8ukM4uohjZRFOBa8n2/oCByncDZg1N0jDQplS
 Iel46LSy0QvXIsliR5ISYVWsr+NgY3M0k8zYVF/zCLkpF+lyK8DCL4MUQesDNMQkP9lF
 VEzw==
X-Gm-Message-State: APjAAAWrMhV2LjGwPSJWKYZjEl3kJgi5O6D/45PU5ofQPmWo3O7mIrTg
 LcRJn/3b9k3LylO4hFOkqRc1VYsR1BGoR8bAg7lxel+X
X-Google-Smtp-Source: APXvYqzqft+NAmfo1CcoMGgLHyzLMhtHNUynUnFp/qNd7ksLqJkPkGDejDbFGOpTx9by80/URmFLvXWBPH52t25oIvE=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr524001wmb.127.1572286221992; 
 Mon, 28 Oct 2019 11:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <bad3aed9-65f7-7166-3404-5d1d5687eaf0@monssa.com.ar>
In-Reply-To: <bad3aed9-65f7-7166-3404-5d1d5687eaf0@monssa.com.ar>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2019 14:10:10 -0400
Message-ID:
 <CADnq5_MZK69L89aJR7vXsy6zWtXxG5_+=mB5tJTNzfcZYt4R7Q@mail.gmail.com>
Subject: Re: Can't get VGA video on Carrizo R7 gpu, only HDMI
To: MONSSA <debian@monssa.com.ar>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=vrfnUD97dhu5Tmt2+okj0Inaw330n9kMgA3Vgk2F0uA=;
 b=QuRBNrJEIDTgEALCAYyu5Z6IPtWxpxzs+dB0e7T5KuSgaIcgfFrhjQGEDiFxHyZBn0
 1xkT2Q/UlEZ6llQAbft8PCFUNPmCQASB8n4mrp4+cNlZ72AQQIL9MVGYWKaoQSe1hz/A
 oha07dVRRRx7TusY9/3mNUltZuvGHE96Dya5qel3r3iZl37nTvvWp3XIVsw5mN58MpoV
 bwC2lgc74sW5ZEdy/CR95SvVVTtvKcke3DkMRrCE+HYx7tsT+9jkrZG1Ns6tQpirawRL
 ZCoj7XBk4EByk9/h1VZ5BdXVa83trKU00XxdTjqdWYX0kBtxyQb1dvs/FHUISwNGaWEz
 Do3Q==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Message-ID: <20191028181010.2pssvf4Y4uqH4Ce8q5uGx71NZ7QGVyUai5T0oCylzKY@z>

T24gTW9uLCBPY3QgMjgsIDIwMTkgYXQgMToyMSBQTSBNT05TU0EgPGRlYmlhbkBtb25zc2EuY29t
LmFyPiB3cm90ZToKPgo+IEhlbGxvLiBUaGlzIGlzIG15IGZpcnN0IHRpbWUgdHJ5aW5nIHRvIHJl
cG9ydCBhIGJ1ZywgSSBob3BlIEknbSBpbiB0aGUKPiByaWdodCBwbGFjZS4KPgo+IEkgaGF2ZSBh
IFBDIHdpdGggTVNJIEE2OEhNLUUzMyBWMiBtb3RoZXJib2FyZCwgYW5kIEFNRCBBOC03NjgwIENQ
VSB3aXRoCj4gUmFkZW9uIFI3Lgo+Cj4gSSdtIHJ1bm5pbmcgRGViaWFuIDkgU3RyZXRjaCwgS2Vy
bmVsfjQuMTkuMC0wLmJwby42LWFtZDY0LCB1c2luZyBhbWRncHUKPiBkcml2ZXIsIGFuZCBJIGdl
dCB2aWRlbyBvbmx5IG9uIHRoZSBIRE1JIG91dHB1dC4KPgo+IHhyYW5kciBvbmx5IGxpc3RzIHRo
ZSBIRE1JIG91dHB1dCBhcyBjb25uZWN0ZWQsIGFuZCBhIERWSSBvdXRwdXQKPiBkaXNjb25uZWN0
ZWQuIFRoZSBtb3RoZXJib2FyZCBkb2Vzbid0IGhhdmUgRFZJIGNvbm5lY3Rvciwgb25seSBWR0Eg
YW5kIEhETUkuCj4KPiBJIHRyaWVkIGZvcmNpbmcgdmlkZW8gb3V0cHV0IG9uIHRoZSBEVkkgaW50
ZXJmYWNlLCBidXQgSSBkaWRuJ3QgZ2V0IGFueQo+IHZpZGVvIG9uIFZHQSBwb3J0LCBldmVuIHRo
b3VnaCB0aGUgZGVza3RvcCB3YXMgYXJyYW5nZWQgdG8gc3ByZWFkIGFjcm9zcwo+IGJvdGggc2Ny
ZWVucy4KPgo+IEkgdHJpZWQgc2V2ZXJhbCBvcHRpb25zIGZvciB0aGUga2VybmVsIG1vZHVsZSwg
c3VjaCBhcyAiZXhwX2h3X3N1cHBvcnQiCj4gYW5kICJjaWtfc3VwcG9ydCIgZGlkbid0IGZ1bGx5
IGtub3dpbmcgd2hhdCB0aGV5IGRpZCwgdG8gbm8gYXZhaWwuCj4KPiBPZiBjb3Vyc2UgSSBoYXZl
IHR3byBtb25pdG9ycyBwbHVnZ2VkIGluIHRvIGJvdGggY29ubmVjdG9ycywgYW5kIEkgcnVsZWQK
PiBvdXQgaGFyZHdhcmUgcHJvYmxlbXMgKHN1Y2ggYXMgYnVybmVkIGNvbm5lY3RvcikgYmVjYXVz
ZSBJIGNoYW5nZWQgdGhlCj4gSEREIGFuZCBpbnN0YWxsZWQgd2luZG93cywgd2l0aCB0aGUgb2Zm
aWNpYWwgQU1EIHdpbmRvd3MgZHJpdmVycyBJIGdldAo+IHZpZGVvIHdvcmtpbmcgZmluZSBvbiBi
b3RoIG1vbml0b3JzLCBzbyBtb25pdG9ycywgY2FibGVzIGFuZCBwb3J0cyBhcmUKPiB3b3JraW5n
LgoKSSB3b3VsZCBzdWdnZXN0IG9wZW5pbmcgYSBidWcgKGh0dHBzOi8vYnVncy5mcmVlZGVza3Rv
cC5vcmcpIGFuZAphdHRhY2hpbmcgeW91ciBkbWVzZyBvdXRwdXQgYW5kIFhvcmcgbG9nIChpZiB1
c2luZyBYKS4gIFBsZWFzZSBhbHNvCmF0dGFjaCBhIGNvcHkgb2YgeW91ciB2YmlvcyAoc3VkbyBj
YXQKL3N5cy9rZXJuZWwvZGVidWcvZHJpLzAvYW1kZ3B1X3ZiaW9zID4gL3RtcC92Ymlvcy5yb20p
LiAgVkdBIGlzCnVzdWFsbHkgaW1wbGVtZW50ZWQgdmlhIGEgRFAgYnJpZGdlIGNoaXAgc2luY2Ug
dGhhdCBjaGlwIGRvZXMgbm90CnN1cHBvcnQgYW5hbG9nIG91dHB1dHMgZGlyZWN0bHkuCgpBbGV4
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
