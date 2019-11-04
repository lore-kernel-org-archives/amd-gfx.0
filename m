Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A260C010A2
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 12:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2EE217F4
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 12:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2EE217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A43986EA37;
	Tue,  5 Nov 2019 12:43:47 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8556E85E
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2019 20:25:02 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id i19so9839204qki.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Nov 2019 12:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wfX7MWPK2mXvXsnlqpoXJ9gVTBzlydNtygslKz1zYXc=;
 b=Vb/3xl+IM+8q7RA+tRnzh6/Y5dFEa4bV4tD5uCs1pMcXsk8hkkfe4aGgUVYRiIcLgL
 nexi5akKxqcwIxkAElIVIbRPpzSJNmNLqtzGn9L7j0vcc0QFo+pP+JtXTRuKEpfpg6WG
 JUCDs059eOYSjuIMuEjk2mohUnKpBETxKJ9QUvmwbuHhb4ONjOCnm6hWt+B0yPUo0qY+
 7ySuhJcNGwyuC3GAaiYu03XK1r/zGopnu72WYxR1xCMSEUZ1s96hi1RkXm+7atB8CnKf
 24qJ7Gvh792uwGdUUBoFNSv1qw098NkTAAIbt7J8fYoxEVl0z6UhFVfjSyQ+OKWPXTwO
 jO/Q==
X-Gm-Message-State: APjAAAVeX64YF7QlGA+Yy8AfR6kuy36QBmtSyV2KuVwTkSiHPyIr7omB
 S1SI8VgZTQyrLdg+htYgGjqDXQ==
X-Google-Smtp-Source: APXvYqxgNGF3cXksanX/E/C8HqgGn5+TVBnu52RjRVopu16Kv6kjyL+U9vqqnb2baD1bHGbzMrjKsA==
X-Received: by 2002:a37:94e:: with SMTP id 75mr15364499qkj.49.1572899101609;
 Mon, 04 Nov 2019 12:25:01 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.180])
 by smtp.gmail.com with ESMTPSA id d2sm9640372qkg.77.2019.11.04.12.25.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 Nov 2019 12:25:01 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1iRiuK-00055e-9y; Mon, 04 Nov 2019 16:25:00 -0400
Date: Mon, 4 Nov 2019 16:25:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Subject: Re: [PATCH hmm 05/15] RDMA/odp: Use mmu_range_notifier_insert()
Message-ID: <20191104202500.GA19383@ziepe.ca>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-6-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191015181242.8343-6-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Tue, 05 Nov 2019 12:43:46 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wfX7MWPK2mXvXsnlqpoXJ9gVTBzlydNtygslKz1zYXc=;
 b=a8hSItnOZbtn6sMoihfhZuCetsEimfTI974lkvFhLKCg3HejeAO31tVnnKuLf8OBzG
 4cchusxnrVjItFjaeoTqIrOvpcpNtbGL4HmtHSBYgaxArSbGCtmfHGie9wUvHBWBFCtR
 XDyhVJbgXG8KzNN7ekl9KMw5ZH7nR9fuIHVYFo3h/exFmvg9P24/oLAxyHrpy4Es/45s
 IqMUO7VIWM6EhQ7FH+tMQqucsVqJZJSx1KHeKTBcdhQbCjPwSIYCdzJN/likNaHlaSTx
 mvtuSLMteIPqZ8UG6y1xP8DW5n0eiCDpBRZvheCN9DH/7l9lUG76EBGzGGsVNnXnrdNf
 AnxA==
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-rdma@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191104202500.DwzDm6Dlcq7IbqbC6NXY9YD_nrhsegexm3UZrsniHGQ@z>

T24gVHVlLCBPY3QgMTUsIDIwMTkgYXQgMDM6MTI6MzJQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+IEBAIC0yNTAsMjYgKzg1LDE1IEBAIHN0YXRpYyBpbmxpbmUgaW50IGliX2luaXRf
dW1lbV9vZHAoc3RydWN0IGliX3VtZW1fb2RwICp1bWVtX29kcCkKPiAgCQkJcmV0ID0gLUVOT01F
TTsKPiAgCQkJZ290byBvdXRfcGFnZV9saXN0Owo+ICAJCX0KPiAtCX0KPiAgCj4gLQltbiA9IG1t
dV9ub3RpZmllcl9nZXQoJmliX3VtZW1fbm90aWZpZXJzLCB1bWVtX29kcC0+dW1lbS5vd25pbmdf
bW0pOwo+IC0JaWYgKElTX0VSUihtbikpIHsKPiAtCQlyZXQgPSBQVFJfRVJSKG1uKTsKPiAtCQln
b3RvIG91dF9kbWFfbGlzdDsKPiAtCX0KPiAtCXVtZW1fb2RwLT5wZXJfbW0gPSBwZXJfbW0gPQo+
IC0JCWNvbnRhaW5lcl9vZihtbiwgc3RydWN0IGliX3Vjb250ZXh0X3Blcl9tbSwgbW4pOwo+IC0K
PiAtCW11dGV4X2luaXQoJnVtZW1fb2RwLT51bWVtX211dGV4KTsKPiAtCWluaXRfY29tcGxldGlv
bigmdW1lbV9vZHAtPm5vdGlmaWVyX2NvbXBsZXRpb24pOwo+ICsJCXJldCA9IG1tdV9yYW5nZV9u
b3RpZmllcl9pbnNlcnQoJnVtZW1fb2RwLT5ub3RpZmllciwgc3RhcnQsCj4gKwkJCQkJCWVuZCAt
IHN0YXJ0LCBjdXJyZW50LT5tbSk7Cj4gKwkJaWYgKHJldCkKPiArCQkJZ290byBvdXRfZG1hX2xp
c3Q7CgpJdCB0dXJucyBvdXQgJ2N1cnJlbnQnIGNhbid0IGJlIHVzZWQgaGVyZSBhcyB0aGlzIGNh
biBiZSBjYWxsZWQgZnJvbSB0aGUKcGFnZSBmYXVsdCB3b3JrIHF1ZXVlIGFuZCBzaG91bGQgYmUg
J3VtZW1fb2RwLT51bWVtLm93bmluZ19tbScKClRoZSBzYW1lIHByb2JsZW0gYXBwbGllcyB0byB0
aGUgdGdpZCBhIGZldyBsaW5lcyBiZWxvdwoKSXQgYWxzbyBzZWVtcyB0aGVyZSBpcyBhIHByZS1l
eGlzdGluZyBwcm9ibGVtIGhlcmUgYXMgdGhpcyBjb2RlCmRvZXNuJ3QgZ3VhcmVudGVlIHRvIGhh
dmUgYSBtbWdldCgpIG9uIHRoZSBtbSBmb3IgdGhlIG5vbi1jdXJyZW50IGNhc2UKd2hlbiBpdCBj
YWxsZWQgbW11X25vdGlmaWVyX2dldCgpIG9yIG5vdwptbXVfcmFuZ2Vfbm90aWZpZXJfaW5zZXJ0
KCkuIAoKSSdsbCBmaXggdGhpcyBpbiBhIGRlZGljYXRlZCBwYXRjaC4KClRoaXMgaW5jcmVtZW50
YWwgc29ydHMgaXQgb3V0LCBJJ2xsIHNxdWFzaCBpdCBpbnRvIHRoaXMgcGF0Y2g6CgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvdW1lbV9vZHAuYyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL3VtZW1fb2RwLmMKaW5kZXggNjEzMmI4MTI3ZTg0MzUuLjA3NjhiYjYwY2UxNjYy
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS91bWVtX29kcC5jCisrKyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9jb3JlL3VtZW1fb2RwLmMKQEAgLTg3LDEyICs4NywxMCBAQCBzdGF0
aWMgaW5saW5lIGludCBpYl9pbml0X3VtZW1fb2RwKHN0cnVjdCBpYl91bWVtX29kcCAqdW1lbV9v
ZHApCiAJCX0KIAogCQlyZXQgPSBtbXVfcmFuZ2Vfbm90aWZpZXJfaW5zZXJ0KCZ1bWVtX29kcC0+
bm90aWZpZXIsIHN0YXJ0LAotCQkJCQkJZW5kIC0gc3RhcnQsIGN1cnJlbnQtPm1tKTsKKwkJCQkJ
CWVuZCAtIHN0YXJ0LAorCQkJCQkJdW1lbV9vZHAtPnVtZW0ub3duaW5nX21tKTsKIAkJaWYgKHJl
dCkKIAkJCWdvdG8gb3V0X2RtYV9saXN0OwotCi0JCXVtZW1fb2RwLT50Z2lkID0KLQkJCWdldF90
YXNrX3BpZChjdXJyZW50LT5ncm91cF9sZWFkZXIsIFBJRFRZUEVfUElEKTsKIAl9CiAKIAlyZXR1
cm4gMDsKQEAgLTE0MCw4ICsxMzgsMTAgQEAgaWJfdW1lbV9vZHBfYWxsb2NfaW1wbGljaXQoc3Ry
dWN0IGliX3VkYXRhICp1ZGF0YSwgaW50IGFjY2VzcykKIAl1bWVtX29kcC0+aXNfaW1wbGljaXRf
b2RwID0gMTsKIAl1bWVtX29kcC0+cGFnZV9zaGlmdCA9IFBBR0VfU0hJRlQ7CiAKKwl1bWVtX29k
cC0+dGdpZCA9IGdldF90YXNrX3BpZChjdXJyZW50LT5ncm91cF9sZWFkZXIsIFBJRFRZUEVfUElE
KTsKIAlyZXQgPSBpYl9pbml0X3VtZW1fb2RwKHVtZW1fb2RwKTsKIAlpZiAocmV0KSB7CisJCXB1
dF9waWQodW1lbV9vZHAtPnRnaWQpOwogCQlrZnJlZSh1bWVtX29kcCk7CiAJCXJldHVybiBFUlJf
UFRSKHJldCk7CiAJfQpAQCAtMTg1LDggKzE4NSwxMCBAQCBpYl91bWVtX29kcF9hbGxvY19jaGls
ZChzdHJ1Y3QgaWJfdW1lbV9vZHAgKnJvb3QsIHVuc2lnbmVkIGxvbmcgYWRkciwKIAlvZHBfZGF0
YS0+cGFnZV9zaGlmdCA9IFBBR0VfU0hJRlQ7CiAJb2RwX2RhdGEtPm5vdGlmaWVyLm9wcyA9IG9w
czsKIAorCW9kcF9kYXRhLT50Z2lkID0gZ2V0X3BpZChyb290LT50Z2lkKTsKIAlyZXQgPSBpYl9p
bml0X3VtZW1fb2RwKG9kcF9kYXRhKTsKIAlpZiAocmV0KSB7CisJCXB1dF9waWQob2RwX2RhdGEt
PnRnaWQpOwogCQlrZnJlZShvZHBfZGF0YSk7CiAJCXJldHVybiBFUlJfUFRSKHJldCk7CiAJfQpA
QCAtMjU0LDExICsyNTYsMTQgQEAgc3RydWN0IGliX3VtZW1fb2RwICppYl91bWVtX29kcF9nZXQo
c3RydWN0IGliX3VkYXRhICp1ZGF0YSwgdW5zaWduZWQgbG9uZyBhZGRyLAogCQl1cF9yZWFkKCZt
bS0+bW1hcF9zZW0pOwogCX0KIAorCXVtZW1fb2RwLT50Z2lkID0gZ2V0X3Rhc2tfcGlkKGN1cnJl
bnQtPmdyb3VwX2xlYWRlciwgUElEVFlQRV9QSUQpOwogCXJldCA9IGliX2luaXRfdW1lbV9vZHAo
dW1lbV9vZHApOwogCWlmIChyZXQpCi0JCWdvdG8gZXJyX2ZyZWU7CisJCWdvdG8gZXJyX3B1dF9w
aWQ7CiAJcmV0dXJuIHVtZW1fb2RwOwogCitlcnJfcHV0X3BpZDoKKwlwdXRfcGlkKHVtZW1fb2Rw
LT50Z2lkKTsKIGVycl9mcmVlOgogCWtmcmVlKHVtZW1fb2RwKTsKIAlyZXR1cm4gRVJSX1BUUihy
ZXQpOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
