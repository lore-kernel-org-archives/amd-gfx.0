Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF87C4363D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD050208A9
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFJCmZIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD050208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A996ECE9;
	Fri, 25 Sep 2020 14:22:15 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F30F66ECE9
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:22:13 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id k15so3770182wrn.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=l6DJl1KW0e0+NIrg1jCpv8SEAPL2frpblWe+tdix9e0=;
 b=QFJCmZIps4fKMohaTQWfVANS+NRJsPd5gQXEjhHiRtM8WLvIiCebPBXOEa/SCpVjGY
 F5O7dBYIDm6d6ywMIveUrTP/fSrgF3KeQ+Nu4QLEOxntiNyR/wlk5AwpBYCqd6bJExGv
 Epp00jHdI4bgBHQh04qnM1yM22BGKQu21eClbNy4Bwgj/71Y0C5iO7fSEUywUazFvOvy
 buZa4jh80qipi56+hUa2muD7D2JlBLszLQvuxpwt4gNIbpz/5BEli2l4wVLzUa2OIQdV
 71JfMZ9jfGWijESBF8uVHeXBWtHKbzN2W55/lvhBagnG/UXiaacZGP5j/QlMzk/J6Hn2
 wIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=l6DJl1KW0e0+NIrg1jCpv8SEAPL2frpblWe+tdix9e0=;
 b=L9jsaR84mV7wPsFgbxI+jZYUYCSq2NwJEjIlcd+FowCgLYFuT0Y1H9lBW3nZTqxYml
 8+n0WO717DRQ3nYzt1MvQJdBkmBRTNVQppmu+nULcFYayECIdAXlTplZ4fFmhGWZMxN0
 kb94ELz8/wuNjQD+/8VjDqeN2An0OUXKbqttxLmK3S0GNlpT3Pqb9GYvNBiDU+erE+Dx
 BmkU2lInr9qdLhRjqVAKEoeT9cn442yiyAQDFe+SvfbT56mLEF5I5avFJPZtaqL9JFQK
 R+8tGsrM1e9equE/m6R37qUigzh4+uNno6EUfMdBtOvpqgkbU1xFxLqXeg+spHtLAzRJ
 W5Mw==
X-Gm-Message-State: AOAM533AFv+93+Ry6IchgjLJ/I7JeH570I4sY6jrVDcx8peAWDz24kbE
 1l6vZQaH0qFqjDbpMwTjAMzk7Nd6T9/RPetbDjE=
X-Google-Smtp-Source: ABdhPJzV+ACJMb7jZBFbSTkWC81bwchReHzzvWc58a8TVHCndCnyBXWn3ATrqZAEa8D1HfEmazohaVXYt3/a+o5Y4NY=
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr4755628wrr.111.1601043732548; 
 Fri, 25 Sep 2020 07:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200925135456.sudcskvjvfqsfnc4@outlook.office365.com>
In-Reply-To: <20200925135456.sudcskvjvfqsfnc4@outlook.office365.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Sep 2020 10:22:01 -0400
Message-ID: <CADnq5_P6s1abDn2un1dbxcBR_3xcAZeT9GdEfrDS0gjtoHNR3g@mail.gmail.com>
Subject: Re: amd-staging-drm-next has a compilation issue
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, amd-gfx <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

aHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoLzM5MjE5Mi8KCkFsZXgKCk9u
IEZyaSwgU2VwIDI1LCAyMDIwIGF0IDk6NTUgQU0gUm9kcmlnbyBTaXF1ZWlyYQo8Um9kcmlnby5T
aXF1ZWlyYUBhbWQuY29tPiB3cm90ZToKPgo+IEhpLAo+Cj4gV2hlbiBJIHRyaWVkIHRvIGJ1aWxk
IHRoZSBsYXRlc3QgY29kZSBmcm9tIGFtZC1zdGFnaW5nLWRybS1uZXh0LCBJIGdvdAo+IHRoZSBm
b2xsb3dpbmcgYnVpbGQgZmFpbHVyZToKPgo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92aXJ0LmM6IEluIGZ1bmN0aW9uIOKAmGFtZGdwdV92aXJ0X2luaXRfZGF0YV9leGNoYW5n
ZeKAmToKPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jOjU4NjoxMDog
ZXJyb3I6IOKAmHN0cnVjdCBhbWRncHVfZGV2aWNl4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCY
ZndfdnJhbV91c2FnZeKAmQo+ICAgNTg2IHwgIGlmIChhZGV2LT5md192cmFtX3VzYWdlLnZhICE9
IE5VTEwpIHsKPiAgICAgICB8ICAgICAgICAgIF5+Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZpcnQuYzo1OTE6OTogZXJyb3I6IOKAmHN0cnVjdCBhbWRncHVfZGV2aWNl4oCZ
IGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYZndfdnJhbV91c2FnZeKAmQo+ICAgNTkxIHwgICAgKGFk
ZXYtPmZ3X3ZyYW1fdXNhZ2UudmEgKyAoQU1EX1NSSU9WX01TR19QRjJWRl9PRkZTRVRfS0IgPDwg
MTApKTsKPiAgICAgICB8ICAgICAgICAgXn4KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmlydC5jOjU5NDo5OiBlcnJvcjog4oCYc3RydWN0IGFtZGdwdV9kZXZpY2XigJkgaGFz
IG5vIG1lbWJlciBuYW1lZCDigJhmd192cmFtX3VzYWdl4oCZCj4gICA1OTQgfCAgICAoYWRldi0+
ZndfdnJhbV91c2FnZS52YSArIChBTURfU1JJT1ZfTVNHX1ZGMlBGX09GRlNFVF9LQiA8PCAxMCkp
Owo+ICAgICAgIHwgICAgICAgICBefgo+IG1ha2VbNF06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5i
dWlsZDoyODM6IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0Lm9dIEVycm9y
IDEKPgo+IFRoZSBsYXRlc3QgY29tbWl0IHRoYXQgSSB0cmllZDoKPgo+IGRybS9hbWQvcG06IGZp
eCBzY3JlZW4gZmxpY2tlciBzZWVuIG9uIE5hdmkxNCB3aXRoIDIqNEsgbW9uaXRvcnMKPgo+IERv
ZXMgYW55b25lIGhhcyBzZWVuIHRoaXMgaXNzdWU/Cj4KPiBCZXN0IFJlZ2FyZHMKPgo+IC0tCj4g
Um9kcmlnbyBTaXF1ZWlyYQo+IGh0dHBzOi8vc2lxdWVpcmEudGVjaAo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QK
PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
