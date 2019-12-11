Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01464C2D0C6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 14:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B54208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 14:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu1vajVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B54208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 844976EB68;
	Wed, 11 Dec 2019 14:48:00 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F046EB68
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 14:47:59 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id y17so24348208wrh.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 06:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=h1cmVhDv8G9w5q+894ympaHIDtuTfy65tz1rQtxh8XM=;
 b=mu1vajVXpHrmzc58Q6Exth55m9LQYSc/Y0I2rnnou2CD7RKI/ydtEf/Qyw9MjKJTIK
 iwrKg5sbpi+db8eX4YPvcvN3mx+4QRggV4f7wkyklwMQJkdwJHFYtX7g8x3Axe2Dixcf
 uYKkWlNIYcx4RlxUcfD/SjGMPli88RS2iJ8luhq2lFvpP6tWY2kz6d4yRgR4aZ06oZKA
 ok3/6fJJxK7PqeeftUlVa2z7GzgNW2rI4JcfqM+QaiMqfLlAeVDlNcQkKeRK5WmtBBpy
 RsR+bBB4oFWrsoFJj6zecnxZbuaL1bmqJtETlKWJ8df0C7TYf+JjjzfXi8z7k0yr1dZ5
 6Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=h1cmVhDv8G9w5q+894ympaHIDtuTfy65tz1rQtxh8XM=;
 b=XJLvhqtZaK7VNvV3RAU2S6y7ZsGXQQsXDTSeAbjEwzLtLUWkEMbMdOTAUs2nuqsgvw
 7hkFkuJ+NxkcK0I2Zz9ppL6p/2rXe2SoQRZ2MGkQ3ilHcu05i3J+juRL8xrSUK3bj1zs
 f7PDIOkDrgUFxApK3/QxL3g4FR6BUgAvzRJhJ6XjOMyUa+x1Y26LxKzTbSAYk/M1x4pm
 Ve6j49zuz5Hjqr84zf/QMznHlb08lEJgeu3wVM8dicX6SaKdi9Z/GjaWgPVYeCSUl9kN
 kLXYQzxE3DBV2IzeqRiGGyPrPOHKXBDT1f8cjlwJYVvtiXxGsBHXjyESNoY/FyCjOLLR
 OtUQ==
X-Gm-Message-State: APjAAAXI8st/8Uzu34EQVIvnRAR3UB16AIQxnobaq/WcQxjX9IZdONKo
 8JZe61B2n870G4Vg5doifM8Su50FAVBulcisX18=
X-Google-Smtp-Source: APXvYqyNj+K+ZgCqO3nLZWbAVbgZDzU1dnWit1tgncgLY5bjCB9VGEZVCXyKkTsqJSsBwoXr0VEexU7Ir12p9dAm5k4=
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr157326wrs.11.1576075678208;
 Wed, 11 Dec 2019 06:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20191210220804.1376829-1-alexander.deucher@amd.com>
 <7c81d222-16d4-ad6f-a8f4-d90855930fc1@amd.com>
 <efcaaa66-c926-af7c-d1f1-4082b989e255@gmail.com>
In-Reply-To: <efcaaa66-c926-af7c-d1f1-4082b989e255@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Dec 2019 09:47:45 -0500
Message-ID: <CADnq5_OgZP0kqmeTWP-CrweQGxmyQT9YGF8kvgLpFPv_CBmMig@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: wait for all rings to drain before runtime
 suspending
To: Christian Koenig <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, zhoucm1 <david1.zhou@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBEZWMgMTEsIDIwMTkgYXQgODowNyBBTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAxMS4xMi4xOSB1bSAwMzoy
NiBzY2hyaWViIHpob3VjbTE6Cj4gPgo+ID4gT24gMjAxOS8xMi8xMSDkuIrljYg2OjA4LCBBbGV4
IERldWNoZXIgd3JvdGU6Cj4gPj4gQWRkIGEgc2FmZXR5IGNoZWNrIHRvIHJ1bnRpbWUgc3VzcGVu
ZCB0byBtYWtlIHN1cmUgYWxsIG91dHN0YW5kaW5nCj4gPj4gZmVuY2VzIGhhdmUgc2lnbmFsZWQg
YmVmb3JlIHdlIHN1c3BlbmQuICBEb2Vzbid0IGZpeCBhbnkga25vd24gaXNzdWUuCj4gPj4KPiA+
PiBXZSBhbHJlYWR5IGRvIHRoaXMgdmlhIHRoZSBmZW5jZSBkcml2ZXIgc3VzcGVuZCBmdW5jdGlv
biwgYnV0IHdlCj4gPj4ganVzdCBmb3JjZSBjb21wbGV0aW9uIHJhdGhlciB0aGFuIGJhaWxpbmcu
ICBUaGlzIGJhaWxzIG9uIHJ1bnRpbWUKPiA+PiBzdXNwZW5kIHNvIHdlIGNhbiB0cnkgYWdhaW4g
bGF0ZXIgb25jZSB0aGUgZmVuY2VzIGFyZSBzaWduYWxlZCB0bwo+ID4+IGF2b2lkIG1pc3Npbmcg
YW55IG91dHN0YW5kaW5nIHdvcmsuCj4gPgo+ID4gVGhlIGlkZWEgc291bmRzIE9LIHRvIG1lLCBi
dXQgaWYgeW91IHdhbnQgdG8gZHJhaW4gdGhlIHJpbmdzLCB5b3UKPiA+IHNob3VsZCBtYWtlIHN1
cmUgbm8gbW9yZSBzdWJtaXNzaW9uLCByaWdodD8KPiA+Cj4gPiBTbyB5b3Ugc2hvdWxkIHBhcmsg
YWxsIHNjaGVkdWxlcnMgYmVmb3JlIHdhaXRpbmcgZm9yIGFsbCBvdXRzdGFuZGluZwo+ID4gZmVu
Y2VzIGNvbXBsZXRlZC4KPgo+IEF0IHRoYXQgcG9pbnQgdXNlcnNwYWNlIHNob3VsZCBhbHJlYWR5
IGJlIHB1dCB0byBob2xkLCBzbyBubyBuZXcKPiBzdWJtaXNzaW9ucy4gQnV0IGl0IHByb2JhYmx5
IHdvbid0IGh1cnQgc3RvcHBpbmcgdGhlIHNjaGVkdWxlciBhbnl3YXkuCj4KCkFueSBpb2N0bCBj
YWxscyB3aWxsIHdha2UgdGhlIGh3IGFnYWluIG9yIGluY3JlYXNlIHRoZSB1c2FnZSBjb3VudC4K
Cj4gQnV0IGFub3RoZXIgaXNzdWUgSSBzZWUgaXMgd2hhdCBoYXBwZW5zIGlmIHdlIGxvY2tlZCB1
cCB0aGUgaGFyZHdhcmU/Cj4KClJlZ3VsYXIgR1BVIHJlc2V0IHdvdWxkIGtpY2sgaW4gZXZlbnR1
YWxseS4KCkFsZXgKCj4gQ2hyaXN0aWFuLgo+Cj4gPgo+ID4gLURhdmlkCj4gPgo+ID4+Cj4gPj4g
U2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+
ID4+IC0tLQo+ID4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwg
MTIgKysrKysrKysrKystCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kcnYuYwo+ID4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rydi5jCj4gPj4gaW5kZXggMmYzNjcxNDZjNzJjLi44MTMyMmIwYThhY2YgMTAwNjQ0Cj4g
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4gPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4gPj4gQEAgLTEyMTQs
MTMgKzEyMTQsMjMgQEAgc3RhdGljIGludAo+ID4+IGFtZGdwdV9wbW9wc19ydW50aW1lX3N1c3Bl
bmQoc3RydWN0IGRldmljZSAqZGV2KQo+ID4+ICAgICAgIHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0g
dG9fcGNpX2RldihkZXYpOwo+ID4+ICAgICAgIHN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2ID0g
cGNpX2dldF9kcnZkYXRhKHBkZXYpOwo+ID4+ICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2ID0gZHJtX2Rldi0+ZGV2X3ByaXZhdGU7Cj4gPj4gLSAgICBpbnQgcmV0Owo+ID4+ICsgICAg
aW50IHJldCwgaTsKPiA+PiAgICAgICAgIGlmICghYWRldi0+cnVucG0pIHsKPiA+PiAgICAgICAg
ICAgcG1fcnVudGltZV9mb3JiaWQoZGV2KTsKPiA+PiAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsK
PiA+PiAgICAgICB9Cj4gPj4gICArICAgIC8qIHdhaXQgZm9yIGFsbCByaW5ncyB0byBkcmFpbiBi
ZWZvcmUgc3VzcGVuZGluZyAqLwo+ID4+ICsgICAgZm9yIChpID0gMDsgaSA8IEFNREdQVV9NQVhf
UklOR1M7IGkrKykgewo+ID4+ICsgICAgICAgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9IGFk
ZXYtPnJpbmdzW2ldOwo+ID4+ICsgICAgICAgIGlmIChyaW5nICYmIHJpbmctPnNjaGVkLnJlYWR5
KSB7Cj4gPj4gKyAgICAgICAgICAgIHJldCA9IGFtZGdwdV9mZW5jZV93YWl0X2VtcHR5KHJpbmcp
Owo+ID4+ICsgICAgICAgICAgICBpZiAocmV0KQo+ID4+ICsgICAgICAgICAgICAgICAgcmV0dXJu
IC1FQlVTWTsKPiA+PiArICAgICAgICB9Cj4gPj4gKyAgICB9Cj4gPj4gKwo+ID4+ICAgICAgIGlm
IChhbWRncHVfZGV2aWNlX3N1cHBvcnRzX2JvY28oZHJtX2RldikpCj4gPj4gICAgICAgICAgIGRy
bV9kZXYtPnN3aXRjaF9wb3dlcl9zdGF0ZSA9IERSTV9TV0lUQ0hfUE9XRVJfQ0hBTkdJTkc7Cj4g
Pj4gICAgICAgZHJtX2ttc19oZWxwZXJfcG9sbF9kaXNhYmxlKGRybV9kZXYpOwo+ID4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+IGFtZC1nZnggbWFp
bGluZyBsaXN0Cj4gPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4gaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cj4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
