Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1BEC3F2D2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 17:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C6B02467B
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 17:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN0nIDBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6B02467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 281EF6F483;
	Fri, 28 Feb 2020 17:00:44 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AA376F488;
 Fri, 28 Feb 2020 17:00:43 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id c26so4121920eds.8;
 Fri, 28 Feb 2020 09:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=t9YiIycZVF0Hu5aCAfarmS/T54kw0IBJHApMv3cYyyo=;
 b=jN0nIDBfY2ec/EKrTiSc5Aq9wsDCRonITliImv6ykJo+pekRswPAxsdv8ZpdqALnNT
 vzqeEJXtDoG39hKaeRXk3G+WmXkYLAaJuYyMTdWab6MVOnaCiZ9PUamQplXkrXNGiI4F
 xEtWliCIsxI+uPoQDTQ1oU/N/gRUdYZe0s3XTWdrIVq1soP992B7EUqF3eyDyltesBQq
 JSP6t9LEX2x2NNJy4R8KIf9NQmWw6vK9I2Tco0JSOKjPYI2ZWNbu8bHpcLzVrqE6TVVH
 4u2FCr4rWb5WYc6sazE4+2qihNrxywdBJRh34awoZ2V3NB9sMS1SfuOBQV5aTu061/DP
 yO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=t9YiIycZVF0Hu5aCAfarmS/T54kw0IBJHApMv3cYyyo=;
 b=LpEn0AqmfaKoVWlPN297as1l2q4YViOixluH4gjtVOQ+6VhOxA1s3WkeNYW2puagJu
 Q8W2YabBx6Z1PDbKktMvN7R1/ar7ngrp54wm3VAPY64BPcwLpce9zY+CzjFOKNNgSZ69
 WL9esjE/2Q38HoZt7tpzrVigoECkY3cUyyJ3n2EgI+LRnv3gaKt5q5BRKtxAqerSkAVk
 SxJz2aYMqRJG5fUx4URt1anWDiq8UydJd+U7o0BSSHXredfG8bd5sxgFwFnQCih7aAPw
 ePjiI0hC8iGzIQL6j3jxbSnzUn9vjWZ6yWrU0EzJdaG31yrPxdHhwuy9yYTQJ+MtKYWQ
 KQSg==
X-Gm-Message-State: APjAAAVNo2HnWr65kEAUk4GDwdCd0WX7IGNEKcj60JW/KBc1bhma1SWP
 1hXybAhzQ+sd2hEMMQIX2acKXu7NddXXH5ylcl4=
X-Google-Smtp-Source: APXvYqxbjCqrpCI1OkxCpw8KyES2BvRzo2pZAN2KOEt7Qtynvj4pBA/I1ZuC8e6htAAuU45HTRB4V6ehhZByiCnplzM=
X-Received: by 2002:a17:906:b751:: with SMTP id
 fx17mr3511604ejb.207.1582909241537; 
 Fri, 28 Feb 2020 09:00:41 -0800 (PST)
MIME-Version: 1.0
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAPM=9txcGPvFdSzMtYZXyqLKnWyacSMuHdoXdV63M53fLFVFpw@mail.gmail.com>
 <b398161ff7d0268454413058dc6c194cf93f5990.camel@collabora.com>
 <a7727f84-ba85-f19d-9823-c7ba04fd1bb8@daenzer.net>
In-Reply-To: <a7727f84-ba85-f19d-9823-c7ba04fd1bb8@daenzer.net>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 28 Feb 2020 09:00:29 -0800
Message-ID: <CAF6AEGspENM8iRxnfzOSvWp2Y-CfAcxV+=Do4t0Ojp5Qo3O3YA@mail.gmail.com>
Subject: Re: [Intel-gfx] [Mesa-dev] gitlab.fd.o financial situation and impact
 on services
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Cc: Erik Faye-Lund <erik.faye-lund@collabora.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>,
 Discussion of the development of and with GStreamer
 <gstreamer-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBGZWIgMjgsIDIwMjAgYXQgMzo0MyBBTSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRh
ZW56ZXIubmV0PiB3cm90ZToKPgo+IE9uIDIwMjAtMDItMjggMTA6MjggYS5tLiwgRXJpayBGYXll
LUx1bmQgd3JvdGU6Cj4gPgo+ID4gV2UgY291bGQgYWxzbyBkbyBzdHVmZiBsaWtlIHJlZHVjaW5n
IHRoZSBhbW91bnQgb2YgdGVzdHMgd2UgcnVuIG9uIGVhY2gKPiA+IGNvbW1pdCwgYW5kIHB1bnQg
c29tZSB0ZXN0aW5nIHRvIGEgcGVyLXdlZWtlbmQgdGVzdC1ydW4gb3Igc29tZXRpbmcKPiA+IGxp
a2UgdGhhdC4gV2UgZG9uJ3QgKm5lZWQqIHRvIGtub3cgYWJvdXQgZXZlcnkgcHJvYmxlbSB1cCBm
cm9udCwganVzdAo+ID4gdGhlIHN0dWZmIHRoYXQncyBhYm91dCB0byBiZSByZWxlYXNlZCwgcmVh
bGx5LiBUaGUgb3RoZXIgc3R1ZmYgaXMganVzdAo+ID4gbmljZSB0byBoYXZlLiBJZiBpdCdzIHRv
byBleHBlbnNpdmUsIEkgd291bGQgc2F5IGRyb3AgaXQuCj4KPiBJIGRvbid0IGFncmVlIHRoYXQg
cHJlLW1lcmdlIHRlc3RpbmcgaXMganVzdCBuaWNlIHRvIGhhdmUuIEEgcHJvYmxlbQo+IHdoaWNo
IGlzIG9ubHkgY2F1Z2h0IGFmdGVyIGl0IGxhbmRzIGluIG1haW5saW5lIGhhcyBhIG11Y2ggYmln
Z2VyIGltcGFjdAo+IHRoYW4gb25lIHdoaWNoIGlzIGFscmVhZHkgY2F1Z2h0IGVhcmxpZXIuCj4K
Cm9uZSB0aG91Z2h0Li4gc2luY2Ugd2l0aCBtZXNhK21hcmdlYm90IHdlIGVmZmVjdGl2ZWx5IGdl
dCBhdCBsZWFzdAp0d28oaXNoKSBDSSBydW5zIHBlciBNUiwgaWUuIG9uZSB3aGVuIGl0IGlzIGlu
aXRpYWxseSBwdXNoZWQsIGFuZCBvbmUKd2hlbiBtYXJnZWJvdCByZWJhc2VzIGFuZCB0cmllcyB0
byBtZXJnZSwgY291bGQgd2UgbGV2ZXJhZ2UgdGhpcyB0bwpoYXZlIHRyaW1tZWQgZG93biBwcmUt
bWFyZ2Vib3QgQ0kgd2hpY2ggdHJpZXMgdG8ganVzdCB0YXJnZXQgYWZmZWN0ZWQKZHJpdmVycywg
d2l0aCBtYXJnZWJvdCBkb2luZyBhIGZ1bGwgQ0kgcnVuICh3aGVuIGl0IGlzIHBvdGVudGlhbGx5
CmJhdGNoaW5nIHRvZ2V0aGVyIG11bHRpcGxlIE1Scyk/CgpTZWVtcyBsaWtlIGEgd2F5IHRvIHJl
ZHVjZSBvdXIgQ0kgcnVucyB3aXRoIGEgZ29vZCBzYWZldHkgbmV0IHRvCnByZXZlbnQgdGhpbmdz
IGZyb20gc2xpcHBpbmcgdGhyb3VnaCB0aGUgY3JhY2tzLgoKKE5vdCBzdXJlIGhvdyBtdWNoIHRo
YXQgd291bGQgaGVscCByZWR1Y2UgYmFuZHdpZHRoIGNvc3RzLCBidXQgSSBndWVzcwppdCBzaG91
bGQgaGVscCBhIGJpdC4pCgpCUiwKLVIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
