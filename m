Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E08DC433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 15:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135582071A
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 15:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Tr5Is/tF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135582071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9527E89C48;
	Mon, 25 May 2020 15:31:11 +0000 (UTC)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C815089B51
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 15:31:10 +0000 (UTC)
Received: by mail-ot1-x342.google.com with SMTP id c3so14018199otr.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bAUJzoc7IqUjSn+yo0peq2R8rxLuXszL8v1+SHoHNg4=;
 b=Tr5Is/tFfhBcNvoJFDbRu5Ln8A76+CnG+YDW2gJrWDvyNGkCXJ7tLlLksMoNneiC/G
 JQcpPGhoKYZL1sU8qtPMsxurg5u2WpN3lkX8GcIcMGy67IE5X9Z/KXbl7mWg/wzgEVa5
 0YNI55NOQ1RqN/Ren3NRDgb8W+ScMuN+eyqoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bAUJzoc7IqUjSn+yo0peq2R8rxLuXszL8v1+SHoHNg4=;
 b=giqxEI1jPHUfd1/KmbpKS4uQ7pK7jP2AZLrlyvL159JLzeT0GSJpYj0fymeAt9qprR
 9AlhSRydajt7k20qB+9o0XTcI+E+JvOMPIZj8HpeLjCGGsDuimrlSnWMCfSYKdthrm3v
 DAu1ecp9l81JfQUydvmL1yVroSOJNRTzP3/gpcwwhDWcFx6f7elgq/MmKjCT1FXOXOwa
 V8KexaEseIfZ8MkAFFwpu2LNd3MyFwFXaVbae745k1sfDIGML3wlaAZ+7bwTUyDMZKpJ
 JbzHG6myhfkf7Lx6F58azpN2LzabXRU+boKbvLxry8yE9IHV1ZyGPqXiCkFu4+QfmSQe
 oVQQ==
X-Gm-Message-State: AOAM533eOjQmxQ31d24SkpmND/2aq9g/t4tUByC4zy8/XUOETTIdw9QV
 7OFvw2FeGV32h4icMBFPzWetHb+2Yid9BqE+Psugag==
X-Google-Smtp-Source: ABdhPJzkcrR3yAMwEAELXE9cys4iQedV/n7q7FwrzlUwqN0x19DN2aghlSLeBpaRXuxxoHbrXZYQHIFlGr+0T8f9mVM=
X-Received: by 2002:a9d:768a:: with SMTP id j10mr5068453otl.188.1590420670094; 
 Mon, 25 May 2020 08:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-9-daniel.vetter@ffwll.ch>
In-Reply-To: <20200512085944.222637-9-daniel.vetter@ffwll.ch>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 25 May 2020 17:30:59 +0200
Message-ID: <CAKMK7uHXjFcVZuV-gF-mGYZVG8CbosoxWKN5MKV+rBXwEr3JZw@mail.gmail.com>
Subject: Re: [RFC 08/17] drm/scheduler: use dma-fence annotations in main
 thread
To: DRI Development <dri-devel@lists.freedesktop.org>,
 Lucas Stach <l.stach@pengutronix.de>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, Qiang Yu <yuq825@gmail.com>, 
 Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, 
 Steven Price <Steven.Price@arm.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 "Anholt, Eric" <eric@anholt.net>
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
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBNYXkgMTIsIDIwMjAgYXQgMTE6MDAgQU0gRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZl
dHRlckBmZndsbC5jaD4gd3JvdGU6Cj4KPiBJZiB0aGUgc2NoZWR1bGVyIHJ0IHRocmVhZCBnZXRz
IHN0dWNrIG9uIGEgbXV0ZXggdGhhdCB3ZSdyZSBob2xkaW5nCj4gd2hpbGUgd2FpdGluZyBmb3Ig
Z3B1IHdvcmtsb2FkcyB0byBjb21wbGV0ZSwgd2UgaGF2ZSBhIHByb2JsZW0uCj4KPiBBZGQgZG1h
LWZlbmNlIGFubm90YXRpb25zIHNvIHRoYXQgbG9ja2RlcCBjYW4gY2hlY2sgdGhpcyBmb3IgdXMu
Cj4KPiBJJ3ZlIHRyaWVkIHRvIHF1aXRlIGNhcmVmdWxseSByZXZpZXcgdGhpcywgYW5kIEkgdGhp
bmsgaXQncyBhdCB0aGUKPiByaWdodCBzcG90LiBCdXQgb2J2aW9zbHkgbm8gZXhwZXJ0IG9uIGRy
bSBzY2hlZHVsZXIuCj4KPiBDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxp
bmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZwo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBpbnRlbC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IENocmlzIFdpbHNvbiA8Y2hyaXNAY2hyaXMtd2ls
c29uLmNvLnVrPgo+IENjOiBNYWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGlu
dXguaW50ZWwuY29tPgo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBpbnRl
bC5jb20+CgpBZGRpbmcgYSBidW5jaCBtb3JlIHBlb3BsZSBmcm9tIGRyaXZlcnMgdXNpbmcgdGhl
IGRybS9zY2hlZHVsZXIgKHNvCnRoYXQncyBtYWludGFpbmVycyBmb3IgZXRuYXZpdiwgbGltYSwg
cGFuZnJvc3QsIGFuZCB2M2Qgb24gdG9wIG9mCmFtZGdwdSBmb2xrcyBhcmxyZWFkeSBvbiBjYyku
IEFueSB0YWtlcyBvciB0ZXN0aW5nIG9uIHRoaXMgYW5kIHdlbGwKdGhlIGVudGlyZSBzZXJpZXMg
dmVyeSBtdWNoIGFwcHJlY2lhdGVkLCB0aGVyZSdzIGFsc28gYW5vdGhlciBwYXRjaCB0bwphbm90
YXRlIHRoZSB0ZHIgd29yayBpbiB0aGlzIHNlcmllcy4gUGx1cyBvZmMgdGhlIHByZXAgd29yay4K
ClRoYW5rcywgRGFuaWVsCgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVk
X21haW4uYyB8IDYgKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4gaW5kZXggMmYzMTkxMDJhZTlm
Li4wNmE3MzZlNTA2YWQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9z
Y2hlZF9tYWluLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4u
Ywo+IEBAIC03NjMsOSArNzYzLDEyIEBAIHN0YXRpYyBpbnQgZHJtX3NjaGVkX21haW4odm9pZCAq
cGFyYW0pCj4gICAgICAgICBzdHJ1Y3Qgc2NoZWRfcGFyYW0gc3BhcmFtID0gey5zY2hlZF9wcmlv
cml0eSA9IDF9Owo+ICAgICAgICAgc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCA9IChz
dHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKilwYXJhbTsKPiAgICAgICAgIGludCByOwo+ICsgICAg
ICAgYm9vbCBmZW5jZV9jb29raWU7Cj4KPiAgICAgICAgIHNjaGVkX3NldHNjaGVkdWxlcihjdXJy
ZW50LCBTQ0hFRF9GSUZPLCAmc3BhcmFtKTsKPgo+ICsgICAgICAgZmVuY2VfY29va2llID0gZG1h
X2ZlbmNlX2JlZ2luX3NpZ25hbGxpbmcoKTsKPiArCj4gICAgICAgICB3aGlsZSAoIWt0aHJlYWRf
c2hvdWxkX3N0b3AoKSkgewo+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0
eSAqZW50aXR5ID0gTlVMTDsKPiAgICAgICAgICAgICAgICAgc3RydWN0IGRybV9zY2hlZF9mZW5j
ZSAqc19mZW5jZTsKPiBAQCAtODIzLDYgKzgyNiw5IEBAIHN0YXRpYyBpbnQgZHJtX3NjaGVkX21h
aW4odm9pZCAqcGFyYW0pCj4KPiAgICAgICAgICAgICAgICAgd2FrZV91cCgmc2NoZWQtPmpvYl9z
Y2hlZHVsZWQpOwo+ICAgICAgICAgfQo+ICsKPiArICAgICAgIGRtYV9mZW5jZV9lbmRfc2lnbmFs
bGluZyhmZW5jZV9jb29raWUpOwo+ICsKPiAgICAgICAgIHJldHVybiAwOwo+ICB9Cj4KPiAtLQo+
IDIuMjYuMgo+CgoKLS0gCkRhbmllbCBWZXR0ZXIKU29mdHdhcmUgRW5naW5lZXIsIEludGVsIENv
cnBvcmF0aW9uCis0MSAoMCkgNzkgMzY1IDU3IDQ4IC0gaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
