Return-Path: <SRS0=HGq7=Z5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68099C43603
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Dec 2019 00:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D0F217BA
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Dec 2019 00:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D0F217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097C46FAC5;
	Sat,  7 Dec 2019 00:53:23 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD006FAC5
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Dec 2019 00:53:22 +0000 (UTC)
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-Oux05A3XN_OIzNEKpuvzxA-1; Fri, 06 Dec 2019 19:53:20 -0500
Received: by mail-qv1-f72.google.com with SMTP id c22so1009314qvc.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Dec 2019 16:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=KvHW1O+Ud5XpFwu0Bypdel0zf/z/YB/B2hAdzc5k20Q=;
 b=pbUkJwlxQQWne/zZ8WAHGRMaUVrhZhNC3t3ITQa7CTDdpvPhZAQplc5qG3r9atp+NB
 AZw/hRm8YwP5ZagsqGef4q6v/FaVaYTSKz369UBGNN801hMUNY/8dAYTIHA/etTP4Kae
 6Um/tE+KjQ3eecF504OEWAKIAFUYIyaPUQ7pIaJWdU89BouQ4M0gmAjTUlkj2vkAyrV9
 tYyICP9u6QahFU1i8KyNP4ZUOLarlGXZnklvQ3W6BAjpQDZHp5mPxr2ElL2p2I9ENlEk
 CF7W/4UIzUH9KcCWCu24xVJSWhAODPx60wJiDBt2hi1XfywU4Nz06lG755RaXJKEpN+K
 YEUw==
X-Gm-Message-State: APjAAAVPXTTDSmRK4GEZQuw1PZmz63k0CerxzAi9XV+jsNsrqzuU0vY1
 faLWTrp+uGFzz58JxGY8felwzjsxbyO8bllDZZu9KVoBHVhWGViOjUzWxqrbDvfpTB8VC+x9nWP
 ofW93OIusTSEbL6qObm+wWVNeCg==
X-Received: by 2002:a05:620a:1270:: with SMTP id
 b16mr16454867qkl.109.1575680000069; 
 Fri, 06 Dec 2019 16:53:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqwdh20W+FoMYWkupdI4hLwinMd2yJg+mAEd8gyDgHVdWZrfIs5BJnIfVCAFc2eWbl6+b+aa7A==
X-Received: by 2002:a05:620a:1270:: with SMTP id
 b16mr16454855qkl.109.1575679999861; 
 Fri, 06 Dec 2019 16:53:19 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id x57sm7164691qtk.58.2019.12.06.16.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2019 16:53:18 -0800 (PST)
Message-ID: <e66797033e52cb9495e6df7802e2928eead70bf3.camel@redhat.com>
Subject: Re: [PATCH v8 17/17] drm/amd/display: Trigger modesets on MST DSC
 connectors
From: Lyude Paul <lyude@redhat.com>
To: mikita.lipski@amd.com, amd-gfx@lists.freedesktop.org
Date: Fri, 06 Dec 2019 19:53:17 -0500
In-Reply-To: <20191203143530.27262-18-mikita.lipski@amd.com>
References: <20191203143530.27262-1-mikita.lipski@amd.com>
 <20191203143530.27262-18-mikita.lipski@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: Oux05A3XN_OIzNEKpuvzxA-1
X-Mimecast-Spam-Score: 0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1575680001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KvHW1O+Ud5XpFwu0Bypdel0zf/z/YB/B2hAdzc5k20Q=;
 b=LuALJ75N0PEPirnOyaFEo+WZy8L56s/IVntbjgwtToLlK/6epRFBHXZzBbG8XteS4UDx4a
 S9ZFqsc4tgpLGSHbO5WewmJTV4WvGD8RDKbXjSPAM8dOmSYRuwNEw0JjpC0j3sfKqzgtjG
 wNnXVzZaIBu+eam2DIXw3FvAdNYXBNw=
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
Cc: Leo Li <sunpeng.li@amd.com>, David Francis <David.Francis@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEx5dWRlIFBhdWwgPGx5dWRlQHJlZGhhdC5jb20+CgpPbiBUdWUsIDIwMTkt
MTItMDMgYXQgMDk6MzUgLTA1MDAsIG1pa2l0YS5saXBza2lAYW1kLmNvbSB3cm90ZToKPiBGcm9t
OiBNaWtpdGEgTGlwc2tpIDxtaWtpdGEubGlwc2tpQGFtZC5jb20+Cj4gCj4gV2hlbmV2ZXIgYSBj
b25uZWN0b3Igb24gYW4gTVNUIG5ldHdvcmsgaXMgYXR0YWNoZWQsIGRldGFjaGVkLCBvcgo+IHVu
ZGVyZ29lcyBhIG1vZGVzZXQsIHRoZSBEU0MgY29uZmlncyBmb3IgZWFjaCBzdHJlYW0gb24gdGhh
dAo+IHRvcG9sb2d5IHdpbGwgYmUgcmVjYWxjdWxhdGVkLiBUaGlzIGNhbiBjaGFuZ2UgdGhlaXIg
cmVxdWlyZWQKPiBiYW5kd2lkdGgsIHJlcXVpcmluZyBhIGZ1bGwgcmVwcm9ncmFtbWluZywgYXMg
dGhvdWdoIGEgbW9kZXNldAo+IHdhcyBwZXJmb3JtZWQsIGV2ZW4gaWYgdGhhdCBzdHJlYW0gZGlk
IG5vdCBjaGFuZ2UgdGltaW5nLgo+IAo+IFRoZXJlZm9yZSwgd2hlbmV2ZXIgYSBjcnRjIGhhcyBk
cm1fYXRvbWljX2NydGNfbmVlZHNfbW9kZXNldCwKPiBmb3IgZWFjaCBjcnRjIHRoYXQgc2hhcmVz
IGEgTVNUIHRvcG9sb2d5IHdpdGggdGhhdCBzdHJlYW0gYW5kCj4gc3VwcG9ydHMgRFNDLCBhZGQg
dGhhdCBjcnRjIChhbmQgYWxsIGFmZmVjdGVkIGNvbm5lY3RvcnMgYW5kCj4gcGxhbmVzKSB0byB0
aGUgYXRvbWljIHN0YXRlIGFuZCBzZXQgbW9kZV9jaGFuZ2VkIG9uIGl0cyBzdGF0ZQo+IAo+IHYy
OiBEbyB0aGlzIGNoZWNrIG9ubHkgb24gTmF2aSBhbmQgYmVmb3JlIGFkZGluZyBjb25uZWN0b3Jz
Cj4gYW5kIHBsYW5lcyBvbiBtb2Rlc2V0dGluZyBjcnRjcwo+IAo+IENjOiBMZW8gTGkgPHN1bnBl
bmcubGlAYW1kLmNvbT4KPiBDYzogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1
c2thc0BhbWQuY29tPgo+IENjOiBMeXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29tPgo+IFNpZ25l
ZC1vZmYtYnk6IERhdmlkIEZyYW5jaXMgPERhdmlkLkZyYW5jaXNAYW1kLmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBNaWtpdGEgTGlwc2tpIDxtaWtpdGEubGlwc2tpQGFtZC5jb20+Cj4gLS0tCj4gIC4u
Li9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDMzICsrKysrKysr
KysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykKPiAKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0u
Ywo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+
IGluZGV4IDJhYzNhMmYwYjQ1Mi4uOTA5NjY1NDI3MTEwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gQEAgLTc5MzAsNiAr
NzkzMCwyOSBAQCBkbV9kZXRlcm1pbmVfdXBkYXRlX3R5cGVfZm9yX2NvbW1pdChzdHJ1Y3QKPiBh
bWRncHVfZGlzcGxheV9tYW5hZ2VyICpkbSwKPiAgCXJldHVybiByZXQ7Cj4gIH0KPiAgCj4gK3N0
YXRpYyBpbnQgYWRkX2FmZmVjdGVkX21zdF9kc2NfY3J0Y3Moc3RydWN0IGRybV9hdG9taWNfc3Rh
dGUgKnN0YXRlLAo+IHN0cnVjdCBkcm1fY3J0YyAqY3J0YykKPiArewo+ICsJc3RydWN0IGRybV9j
b25uZWN0b3IgKmNvbm5lY3RvcjsKPiArCXN0cnVjdCBkcm1fY29ubmVjdG9yX3N0YXRlICpjb25u
X3N0YXRlOwo+ICsJc3RydWN0IGFtZGdwdV9kbV9jb25uZWN0b3IgKmFjb25uZWN0b3IgPSBOVUxM
Owo+ICsJaW50IGk7Cj4gKwlmb3JfZWFjaF9uZXdfY29ubmVjdG9yX2luX3N0YXRlKHN0YXRlLCBj
b25uZWN0b3IsIGNvbm5fc3RhdGUsIGkpIHsKPiArCQlpZiAoY29ubl9zdGF0ZS0+Y3J0YyAhPSBj
cnRjKQo+ICsJCQljb250aW51ZTsKPiArCj4gKwkJYWNvbm5lY3RvciA9IHRvX2FtZGdwdV9kbV9j
b25uZWN0b3IoY29ubmVjdG9yKTsKPiArCQlpZiAoIWFjb25uZWN0b3ItPnBvcnQpCj4gKwkJCWFj
b25uZWN0b3IgPSBOVUxMOwo+ICsJCWVsc2UKPiArCQkJYnJlYWs7Cj4gKwl9Cj4gKwo+ICsJaWYg
KCFhY29ubmVjdG9yKQo+ICsJCXJldHVybiAwOwo+ICsKPiArCXJldHVybiBkcm1fZHBfbXN0X2Fk
ZF9hZmZlY3RlZF9kc2NfY3J0Y3Moc3RhdGUsICZhY29ubmVjdG9yLT5tc3RfbWdyKTsKPiArfQo+
ICsKPiAgLyoqCj4gICAqIGFtZGdwdV9kbV9hdG9taWNfY2hlY2soKSAtIEF0b21pYyBjaGVjayBp
bXBsZW1lbnRhdGlvbiBmb3IgQU1EZ3B1IERNLgo+ICAgKiBAZGV2OiBUaGUgRFJNIGRldmljZQo+
IEBAIC03OTgyLDYgKzgwMDUsMTYgQEAgc3RhdGljIGludCBhbWRncHVfZG1fYXRvbWljX2NoZWNr
KHN0cnVjdCBkcm1fZGV2aWNlCj4gKmRldiwKPiAgCWlmIChyZXQpCj4gIAkJZ290byBmYWlsOwo+
ICAKPiArCWlmIChhZGV2LT5hc2ljX3R5cGUgPj0gQ0hJUF9OQVZJMTApIHsKPiArCQlmb3JfZWFj
aF9vbGRuZXdfY3J0Y19pbl9zdGF0ZShzdGF0ZSwgY3J0Yywgb2xkX2NydGNfc3RhdGUsCj4gbmV3
X2NydGNfc3RhdGUsIGkpIHsKPiArCQkJaWYgKGRybV9hdG9taWNfY3J0Y19uZWVkc19tb2Rlc2V0
KG5ld19jcnRjX3N0YXRlKSkgewo+ICsJCQkJcmV0ID0gYWRkX2FmZmVjdGVkX21zdF9kc2NfY3J0
Y3Moc3RhdGUsIGNydGMpOwo+ICsJCQkJaWYgKHJldCkKPiArCQkJCQlnb3RvIGZhaWw7Cj4gKwkJ
CX0KPiArCQl9Cj4gKwl9Cj4gKwo+ICAJZm9yX2VhY2hfb2xkbmV3X2NydGNfaW5fc3RhdGUoc3Rh
dGUsIGNydGMsIG9sZF9jcnRjX3N0YXRlLAo+IG5ld19jcnRjX3N0YXRlLCBpKSB7Cj4gIAkJaWYg
KCFkcm1fYXRvbWljX2NydGNfbmVlZHNfbW9kZXNldChuZXdfY3J0Y19zdGF0ZSkgJiYKPiAgCQkg
ICAgIW5ld19jcnRjX3N0YXRlLT5jb2xvcl9tZ210X2NoYW5nZWQgJiYKLS0gCkNoZWVycywKCUx5
dWRlIFBhdWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
