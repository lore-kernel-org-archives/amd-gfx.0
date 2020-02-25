Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD08C35DF5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 12:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FDE0206E6
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 12:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jimeH0ab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDE0206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC6A89E1D;
	Tue, 25 Feb 2020 12:45:57 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC646EAC4
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 12:45:56 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a6so3021311wme.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 04:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=uyelMDypmo/kUYApnuusO1FBhC/DAPkh/iMWmndsczU=;
 b=jimeH0ab4QpX1FB2BIhxYQl8jLz7D/XIfGcr1a90WxmxDOUhkQBZ+hgie4ZSs8zhok
 pqFG1vPGBNg2bzSBC8VjF8knUa9f3D+YKnHmYelAfbuB5X/PBSP9dsfEfO/rRkoHFALq
 phCQT2b8N5FD4780pqFtbiGomweq0F2WrbsERMx6eEmJ2P2UAgw2qEAfodsAtsGOUbZh
 rE8aA0jIeHugd4tZ64xKrpQYpC8SBotd6I0GpHp+DZ6XBTCLZw0roiscg67boHkK7ETs
 C+cczxkp5er+GWYhCYuPZ/l214s8N7t30Zb2+DnHF1i2W3rj6a6JXo3CgHqvlj/GGFVV
 uKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=uyelMDypmo/kUYApnuusO1FBhC/DAPkh/iMWmndsczU=;
 b=Vmo1FBZ0ucHHm/32UvUnJO6gjxyCY24T1LKfPLPKRx1j5llNW+Gerw5JGYGRz5x+um
 ZZxtSpuVcrtcuF0HS320HU9ZfFDQ4D2ONucBTt6zN1yNrjtNDe3dmHeUGFo5rCFgwvsx
 tELU1L+adHKXk0DM7wd98mxseKYL9cspcGQubghO7jpYYqA11ijm3JtsZIzEMjcShGbt
 dL0S5UgJWcpnWPgK3afbmChuRtyBWwgU1VINmQH2UzhPPo6Mvt7Hei4G/4yhRHOECqsL
 8xICBTvthEgXtOP9C6WtlqFlw+w8/zi+HgRxnKB3ikE6Sf4FF77fUN2xPqD1ZfzYrowx
 f24w==
X-Gm-Message-State: APjAAAUjzd0wmQeEzZZEsTH10Z5xCXQkPoI2uw+ATZZ/ZRFX1OKkaZr/
 H73SqETJ1X/Ieh8m4b/Rx3GFId12
X-Google-Smtp-Source: APXvYqxamVOHw5sjoSSmzdK+zSvzUi1wwhLitipvU/+mKzCtAmak3Dah6sjNSgqKtAiDfQynMYsLig==
X-Received: by 2002:a7b:c8d2:: with SMTP id f18mr4911141wml.47.1582634755164; 
 Tue, 25 Feb 2020 04:45:55 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j16sm1959749wru.68.2020.02.25.04.45.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:45:54 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: add VM update fences back to the root PD v2
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: Felix Kuehling <felix.kuehling@amd.com>, Xinhui.Pan@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20200219150251.123917-1-christian.koenig@amd.com>
Message-ID: <88197ba6-7497-6733-446a-6ea44486d672@gmail.com>
Date: Tue, 25 Feb 2020 13:45:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200219150251.123917-1-christian.koenig@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTkuMDIuMjAgdW0gMTY6MDIgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFkZCB1cGRh
dGUgZmVuY2VzIHRvIHRoZSByb290IFBEIHdoaWxlIG1hcHBpbmcgQk9zLgo+Cj4gT3RoZXJ3aXNl
IFBEcyBmcmVlZCBkdXJpbmcgdGhlIG1hcHBpbmcgd29uJ3Qgd2FpdCBmb3IKPiB1cGRhdGVzIHRv
IGZpbmlzaCBhbmQgY2FuIGNhdXNlIGNvcnJ1cHRpb25zLgo+Cj4gdjI6IHJlYmFzZWQgb24gZHJt
LW1pc2MtbmV4dAo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgo+IEZpeGVzOiA5MGI2OWNkYzVmMTU5IGRybS9hbWRncHU6IHN0b3Ag
YWRkaW5nIFZNIHVwZGF0ZXMgZmVuY2VzIHRvIHRoZSByZXN2IG9iagoKRmVsaXggYW5kIFhpbmh1
aSBjYW4gSSBnZXQgYW4gcmIgb3IgYXQgbGVhc3QgQWNrZWQtYnkgZm9yIHRoaXMgcGF0Y2g/IEl0
IAppcyBhIG1ham9yIHByb2JsZW0gZm9yIHRlc3Rpbmcgd2hpY2ggbmVlZHMgdG8gZ2V0IGZpeGVk
LgoKVGhhbmtzLApDaHJpc3RpYW4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMgfCAxNCArKysrKysrKysrKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYwo+IGluZGV4IGQxNjIzMWQ2YTc5MC4uZWY3M2ZhOTRmMzU3IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtNTg4LDggKzU4OCw4IEBA
IHZvaWQgYW1kZ3B1X3ZtX2dldF9wZF9ibyhzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKPiAgIHsKPiAg
IAllbnRyeS0+cHJpb3JpdHkgPSAwOwo+ICAgCWVudHJ5LT50di5ibyA9ICZ2bS0+cm9vdC5iYXNl
LmJvLT50Ym87Cj4gLQkvKiBPbmUgZm9yIFRUTSBhbmQgb25lIGZvciB0aGUgQ1Mgam9iICovCj4g
LQllbnRyeS0+dHYubnVtX3NoYXJlZCA9IDI7Cj4gKwkvKiBUd28gZm9yIFZNIHVwZGF0ZXMsIG9u
ZSBmb3IgVFRNIGFuZCBvbmUgZm9yIHRoZSBDUyBqb2IgKi8KPiArCWVudHJ5LT50di5udW1fc2hh
cmVkID0gNDsKPiAgIAllbnRyeS0+dXNlcl9wYWdlcyA9IE5VTEw7Cj4gICAJbGlzdF9hZGQoJmVu
dHJ5LT50di5oZWFkLCB2YWxpZGF0ZWQpOwo+ICAgfQo+IEBAIC0xNTkxLDYgKzE1OTEsMTYgQEAg
c3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCj4gICAJCWdvdG8gZXJyb3JfdW5sb2NrOwo+ICAgCX0KPiAgIAo+ICsJaWYgKGZs
YWdzICYgQU1ER1BVX1BURV9WQUxJRCkgewo+ICsJCXN0cnVjdCBhbWRncHVfYm8gKnJvb3QgPSB2
bS0+cm9vdC5iYXNlLmJvOwo+ICsKPiArCQlpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2bS0+
bGFzdF9kaXJlY3QpKQo+ICsJCQlhbWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGlyZWN0
LCB0cnVlKTsKPiArCj4gKwkJaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxhc3RfZGVs
YXllZCkpCj4gKwkJCWFtZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFzdF9kZWxheWVkLCB0cnVl
KTsKPiArCX0KPiArCj4gICAJciA9IHZtLT51cGRhdGVfZnVuY3MtPnByZXBhcmUoJnBhcmFtcywg
b3duZXIsIGV4Y2x1c2l2ZSk7Cj4gICAJaWYgKHIpCj4gICAJCWdvdG8gZXJyb3JfdW5sb2NrOwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
