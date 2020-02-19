Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE96C34050
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B524B24671
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qd2DY73M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B524B24671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A2376EC2F;
	Wed, 19 Feb 2020 15:41:54 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBAB96EC2F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 15:41:52 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id b17so1175052wmb.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 07:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=z0panC7YJDVuOtPc3Ekn4Fa52OpPKN91Y3arXWkKjJc=;
 b=qd2DY73Mb0U962EjMZQ7UBfStKTyT4O2f4f5o/vTF40iGt++15tFKQEir+NES0e6XL
 qs8MmHL9PnQvyDd17/6Jd3j7byQ+mfoekHXFGU4BM7+4KNv8A0WM7zVfQ4EN6cOGHHVt
 Agjr/qVXQofcJ+PGGOW5YFLlGqhs0IyWk0aP/ytsRYN0bs4V0QZd7R4zCA7shGWzWp8v
 52XHwLu/yqCRtv4qe8+cUslkeK/B85SDR6A97wnoEHxYpA6b7odxqionA9S4NNkQYdfH
 3t6+RSNwphli28dKrL0p3cufeoW/1Acaoy3Td7o4D7YHBG9yysMbYjDATZdjB6ku+9dn
 4E+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=z0panC7YJDVuOtPc3Ekn4Fa52OpPKN91Y3arXWkKjJc=;
 b=SbVGQOCyObI2iSKAQMtiJ7VJV/xZiBJgQ3UmMPqO7EYTw5sGlQfWWMlqC1o4dMRE2D
 ETSKtTwKTqImV7yUIU7w128CfOYUAl/sikRjtD+uqYplvVIiVrLrhwntAy+AFveOoMyF
 ggg2Q2kLKB8dCHVlFOH3+mX+uiTzZYaOc31gGojKQpMQsB9e3CQvTVVsgtrBqkUxo4BI
 tY+uGJbEMpSYY13vj4w1kV8htKiE23PRG/OPBxldzamFKNcSqwP4vU2m9z3v0QNMMsWA
 HxxFXgxRGQ5WGqZSWFw11OA7yKobm/UP93iApyB3RqV8TudapY07vZnrHsEuh3P+Ltkc
 BWnw==
X-Gm-Message-State: APjAAAXAudebRP9VDypS16sf6zVM+z8OdxiRvBEUpcr3GJaZMGZBPS+x
 8d/3gAScZQSTISXQ66cJYuFwHJpp
X-Google-Smtp-Source: APXvYqziQC6lvQSFSCZMgVi9XALjsDYmA0mFCFtdkN2o+HLiRIEp7k2Ow9mCWOYOVmPmwly2sYqwfQ==
X-Received: by 2002:a1c:1d09:: with SMTP id d9mr11166904wmd.91.1582126911039; 
 Wed, 19 Feb 2020 07:41:51 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t9sm174859wrv.63.2020.02.19.07.41.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Feb 2020 07:41:50 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: add VM update fences back to the root PD v2
To: Tom St Denis <tom.stdenis@amd.com>, luben.tuikov@amd.com,
 Marek.Olsak@amd.com, Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org
References: <20200219150251.123917-1-christian.koenig@amd.com>
 <9af8bcf0-bfe6-d622-ec12-9bddba8e2d76@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <59eabaf0-a5b2-c43f-f4bb-491d9c6e655f@gmail.com>
Date: Wed, 19 Feb 2020 16:41:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9af8bcf0-bfe6-d622-ec12-9bddba8e2d76@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2VsbCB3aGF0IGJyYW5jaCBhcmUgeW91IHRyeWluZyB0byBtZXJnZSB0aGF0IGludG8/CgpUaGUg
Y29uZmxpY3QgcmVzb2x1dGlvbiBzaG91bGQgYmUgc2ltcGxlLCBqdXN0IGtlZXAgdGhlIAp2bS0+
dXBkYXRlX2Z1bmNzLT5wcmVwYXJlKC4uLikgbGluZSBhcyBpdCBpcyBpbiB5b3VyIGJyYW5jaC4K
CldoZW4geW91IGdldCB0aG9zZSBlcnJvcnMgdGhlbiBzb21ldGhpbmcgd2VudCB3cm9uZyBpbiB5
b3VyIHJlYmFzZS4KCkNocmlzdGlhbi4KCkFtIDE5LjAyLjIwIHVtIDE2OjE0IHNjaHJpZWIgVG9t
IFN0IERlbmlzOgo+IERvZXNuJ3QgYnVpbGQgZXZlbiB3aXRoIGNvbmZsaWN0IHJlc29sdmVkOgo+
Cj4gW3Jvb3RAcmF2ZW4gbGludXhdIyBtYWtlCj4gwqAgQ0FMTMKgwqDCoCBzY3JpcHRzL2NoZWNr
c3lzY2FsbHMuc2gKPiDCoCBDQUxMwqDCoMKgIHNjcmlwdHMvYXRvbWljL2NoZWNrLWF0b21pY3Mu
c2gKPiDCoCBERVNDRU5EwqAgb2JqdG9vbAo+IMKgIENIS8KgwqDCoMKgIGluY2x1ZGUvZ2VuZXJh
dGVkL2NvbXBpbGUuaAo+IMKgIENDIFtNXcKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5vCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmM6IEluIGZ1
bmN0aW9uIAo+IOKAmGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZ+KAmToKPiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYzoxNjEyOjQxOiBlcnJvcjog4oCYb3duZXLigJkg
Cj4gdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCj4gwqAxNjEyIHzCoCBy
ID0gdm0tPnVwZGF0ZV9mdW5jcy0+cHJlcGFyZSgmcGFyYW1zLCBvd25lciwgZXhjbHVzaXZlKTsK
PiDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+fgo+IGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jOjE2MTI6NDE6IG5vdGU6IGVhY2ggdW5kZWNsYXJl
ZCAKPiBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBp
dCBhcHBlYXJzIGluCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmM6MTYx
Mjo0ODogZXJyb3I6IOKAmGV4Y2x1c2l2ZeKAmSAKPiB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4g
dGhpcyBmdW5jdGlvbikKPiDCoDE2MTIgfMKgIHIgPSB2bS0+dXBkYXRlX2Z1bmNzLT5wcmVwYXJl
KCZwYXJhbXMsIG93bmVyLCBleGNsdXNpdmUpOwo+IMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn5+Cj4gbWFrZVs0XTogKioqIFtzY3JpcHRz
L01ha2VmaWxlLmJ1aWxkOjI2NjogCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLm9dIEVycm9yIDEKPiBtYWtlWzNdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NTA5
OiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdV0gCj4gRXJyb3IgMgo+IG1ha2VbMl06ICoqKiBb
c2NyaXB0cy9NYWtlZmlsZS5idWlsZDo1MDk6IGRyaXZlcnMvZ3B1L2RybV0gRXJyb3IgMgo+IG1h
a2VbMV06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo1MDk6IGRyaXZlcnMvZ3B1XSBFcnJv
ciAyCj4gbWFrZTogKioqIFtNYWtlZmlsZToxNjQ5OiBkcml2ZXJzXSBFcnJvciAyCj4KPiBTaG91
bGQgSSBqdXN0IG1vdmUgdG8gZHJtLW1pc2MtbmV4dD8KPgo+IHRvbQo+Cj4gT24gMjAyMC0wMi0x
OSAxMDowMiBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBZGQgdXBkYXRlIGZlbmNl
cyB0byB0aGUgcm9vdCBQRCB3aGlsZSBtYXBwaW5nIEJPcy4KPj4KPj4gT3RoZXJ3aXNlIFBEcyBm
cmVlZCBkdXJpbmcgdGhlIG1hcHBpbmcgd29uJ3Qgd2FpdCBmb3IKPj4gdXBkYXRlcyB0byBmaW5p
c2ggYW5kIGNhbiBjYXVzZSBjb3JydXB0aW9ucy4KPj4KPj4gdjI6IHJlYmFzZWQgb24gZHJtLW1p
c2MtbmV4dAo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cj4+IEZpeGVzOiA5MGI2OWNkYzVmMTU5IGRybS9hbWRncHU6IHN0b3Ag
YWRkaW5nIFZNIHVwZGF0ZXMgZmVuY2VzIHRvIHRoZSAKPj4gcmVzdiBvYmoKPj4gLS0tCj4+IMKg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMTQgKysrKysrKysrKysr
LS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
YyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiBpbmRleCBk
MTYyMzFkNmE3OTAuLmVmNzNmYTk0ZjM1NyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMKPj4gQEAgLTU4OCw4ICs1ODgsOCBAQCB2b2lkIGFtZGdwdV92bV9nZXRf
cGRfYm8oc3RydWN0IGFtZGdwdV92bSAqdm0sCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBlbnRyeS0+
cHJpb3JpdHkgPSAwOwo+PiDCoMKgwqDCoMKgIGVudHJ5LT50di5ibyA9ICZ2bS0+cm9vdC5iYXNl
LmJvLT50Ym87Cj4+IC3CoMKgwqAgLyogT25lIGZvciBUVE0gYW5kIG9uZSBmb3IgdGhlIENTIGpv
YiAqLwo+PiAtwqDCoMKgIGVudHJ5LT50di5udW1fc2hhcmVkID0gMjsKPj4gK8KgwqDCoCAvKiBU
d28gZm9yIFZNIHVwZGF0ZXMsIG9uZSBmb3IgVFRNIGFuZCBvbmUgZm9yIHRoZSBDUyBqb2IgKi8K
Pj4gK8KgwqDCoCBlbnRyeS0+dHYubnVtX3NoYXJlZCA9IDQ7Cj4+IMKgwqDCoMKgwqAgZW50cnkt
PnVzZXJfcGFnZXMgPSBOVUxMOwo+PiDCoMKgwqDCoMKgIGxpc3RfYWRkKCZlbnRyeS0+dHYuaGVh
ZCwgdmFsaWRhdGVkKTsKPj4gwqAgfQo+PiBAQCAtMTU5MSw2ICsxNTkxLDE2IEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCAKPj4gYW1kZ3B1X2RldmljZSAq
YWRldiwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyb3JfdW5sb2NrOwo+PiDCoMKgwqDC
oMKgIH0KPj4gwqAgK8KgwqDCoCBpZiAoZmxhZ3MgJiBBTURHUFVfUFRFX1ZBTElEKSB7Cj4+ICvC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvICpyb290ID0gdm0tPnJvb3QuYmFzZS5ibzsK
Pj4gKwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxh
c3RfZGlyZWN0KSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2JvX2ZlbmNlKHJv
b3QsIHZtLT5sYXN0X2RpcmVjdCwgdHJ1ZSk7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmICgh
ZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKHZtLT5sYXN0X2RlbGF5ZWQpKQo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBhbWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGVsYXllZCwgdHJ1ZSk7
Cj4+ICvCoMKgwqAgfQo+PiArCj4+IMKgwqDCoMKgwqAgciA9IHZtLT51cGRhdGVfZnVuY3MtPnBy
ZXBhcmUoJnBhcmFtcywgb3duZXIsIGV4Y2x1c2l2ZSk7Cj4+IMKgwqDCoMKgwqAgaWYgKHIpCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycm9yX3VubG9jazsKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
