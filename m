Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3697C2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 10:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BD86128C
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 10:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BD86128C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 964296E8E7;
	Thu, 17 Jun 2021 10:33:30 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id DEFB26E8E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 10:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 1BB5320201B;
 Thu, 17 Jun 2021 12:33:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id mG2OyT7oVUwY; Thu, 17 Jun 2021 12:33:28 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id CDC7020201A;
 Thu, 17 Jun 2021 12:33:28 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1ltpKx-0001XS-Mv; Thu, 17 Jun 2021 12:33:27 +0200
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
To: amd-gfx@lists.freedesktop.org
References: <20210616104651.3004-1-michel@daenzer.net>
Subject: Re: [PATCH] drm/amdgpu: Call drm_framebuffer_init last for
 framebuffer init
Message-ID: <eb0ff799-0d2c-ce9e-20c5-da80bc11f77e@daenzer.net>
Date: Thu, 17 Jun 2021 12:33:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616104651.3004-1-michel@daenzer.net>
Content-Language: en-CA
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
Cc: Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNi0xNiAxMjo0NiBwLm0uLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPiBGcm9tOiBN
aWNoZWwgRMOkbnplciA8bWRhZW56ZXJAcmVkaGF0LmNvbT4KPiAKPiBPbmNlIGRybV9mcmFtZWJ1
ZmZlcl9pbml0IGhhcyByZXR1cm5lZCAwLCB0aGUgZnJhbWVidWZmZXIgaXMgaG9va2VkIHVwCj4g
dG8gdGhlIHJlZmVyZW5jZSBjb3VudGluZyBtYWNoaW5lcnkgYW5kIGNhbiBubyBsb25nZXIgYmUg
ZGVzdHJveWVkIHdpdGgKPiBhIHNpbXBsZSBrZnJlZS4gVGhlcmVmb3JlLCBpdCBtdXN0IGJlIGNh
bGxlZCBsYXN0Lgo+IAo+IEZpeGVzOiBmMjU4OTA3ZmRkODM1ZSAiZHJtL2FtZGdwdTogVmVyaWZ5
IGJvIHNpemUgY2FuIGZpdCBmcmFtZWJ1ZmZlciBzaXplIG9uIGluaXQuIgoKSW4gY2FzZSB0aGUg
Y29tbWl0IGxvZyB3YXNuJ3QgY2xlYXI6IElmIGRybV9mcmFtZWJ1ZmZlcl9pbml0IHJldHVybnMg
MCBidXQgaXRzIGNhbGxlciB0aGVuIHJldHVybnMgbm9uLTAsIHRoZXJlIHdpbGwgbGlrZWx5IGJl
IG1lbW9yeSBjb3JydXB0aW9uIGZpcmV3b3JrcyBkb3duIHRoZSByb2FkLiBUaGUgZm9sbG93aW5n
IGxlYWQgbWUgdG8gdGhpcyBmaXg6CgpbICAgMTIuODkxMjI4XSBrZXJuZWwgQlVHIGF0IGxpYi9s
aXN0X2RlYnVnLmM6MjUhClsuLi5dClsgICAxMi44OTEyNjNdIFJJUDogMDAxMDpfX2xpc3RfYWRk
X3ZhbGlkKzB4NGIvMHg3MApbLi4uXQpbICAgMTIuODkxMzI0XSBDYWxsIFRyYWNlOgpbICAgMTIu
ODkxMzMwXSAgZHJtX2ZyYW1lYnVmZmVyX2luaXQrMHhiNS8weDEwMCBbZHJtXQpbICAgMTIuODkx
Mzc4XSAgYW1kZ3B1X2Rpc3BsYXlfZ2VtX2ZiX3ZlcmlmeV9hbmRfaW5pdCsweDQ3LzB4MTIwIFth
bWRncHVdClsgICAxMi44OTE1OTJdICA/IGFtZGdwdV9kaXNwbGF5X3VzZXJfZnJhbWVidWZmZXJf
Y3JlYXRlKzB4MTBkLzB4MWYwIFthbWRncHVdClsgICAxMi44OTE3OTRdICBhbWRncHVfZGlzcGxh
eV91c2VyX2ZyYW1lYnVmZmVyX2NyZWF0ZSsweDEyNi8weDFmMCBbYW1kZ3B1XQpbICAgMTIuODkx
OTk1XSAgZHJtX2ludGVybmFsX2ZyYW1lYnVmZmVyX2NyZWF0ZSsweDM3OC8weDNmMCBbZHJtXQpb
ICAgMTIuODkyMDM2XSAgPyBkcm1faW50ZXJuYWxfZnJhbWVidWZmZXJfY3JlYXRlKzB4M2YwLzB4
M2YwIFtkcm1dClsgICAxMi44OTIwNzVdICBkcm1fbW9kZV9hZGRmYjIrMHgzNC8weGQwIFtkcm1d
ClsgICAxMi44OTIxMTVdICA/IGRybV9pbnRlcm5hbF9mcmFtZWJ1ZmZlcl9jcmVhdGUrMHgzZjAv
MHgzZjAgW2RybV0KWyAgIDEyLjg5MjE1M10gIGRybV9pb2N0bF9rZXJuZWwrMHhlMi8weDE1MCBb
ZHJtXQpbICAgMTIuODkyMTkzXSAgZHJtX2lvY3RsKzB4M2RhLzB4NDYwIFtkcm1dClsgICAxMi44
OTIyMzJdICA/IGRybV9pbnRlcm5hbF9mcmFtZWJ1ZmZlcl9jcmVhdGUrMHgzZjAvMHgzZjAgW2Ry
bV0KWyAgIDEyLjg5MjI3NF0gIGFtZGdwdV9kcm1faW9jdGwrMHg0My8weDgwIFthbWRncHVdClsg
ICAxMi44OTI0NzVdICBfX3NlX3N5c19pb2N0bCsweDcyLzB4YzAKWyAgIDEyLjg5MjQ4M10gIGRv
X3N5c2NhbGxfNjQrMHgzMy8weDQwClsgICAxMi44OTI0OTFdICBlbnRyeV9TWVNDQUxMXzY0X2Fm
dGVyX2h3ZnJhbWUrMHg0NC8weGFlCgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cHM6Ly9yZWRoYXQuY29tCkxpYnJlIHNvZnR3
YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVs
b3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
