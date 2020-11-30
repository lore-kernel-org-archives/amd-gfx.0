Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD2DC64E7B
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA0E2073C
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV/B6n8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA0E2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEC1F6E8FC;
	Mon, 30 Nov 2020 22:18:49 +0000 (UTC)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819AC6E8FB;
 Mon, 30 Nov 2020 22:18:48 +0000 (UTC)
Received: by mail-ot1-x344.google.com with SMTP id e105so895550ote.5;
 Mon, 30 Nov 2020 14:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fa2/8Ci4xxzQgPpzblIpuZWOOQWDWwEoKG3A0meA3jA=;
 b=PV/B6n8yvOYcyf7wJKlL+Eb8wXVZq3DHArWxHUlRCN3HMm1d/q09v5FMBWbibWzrqq
 8ZDjWTpP9bzG2Mwv44PZ76GCOYi7P7/4m2lqhdibxMcV99qu+x/JbAaiLdgTINrkyWki
 5+7cT9WvHXjVdVW5j1XvHUoLRyB58uKi+F1gMX1i8y2lb6ntUYkzpE1vO+wpIgMFammt
 BBWfLTbp1l0MwMMctfCSfahUSiCAYOOoFs8tFd7Alnny/6mjOLiPxOMo/eP0AGRgjoK9
 h8+H4jM8+BP0ADW7NQwaWV2U6esy19bkdVNMbtigTLSpy9PymNUwtKivP5fLMdBMunrx
 Exyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fa2/8Ci4xxzQgPpzblIpuZWOOQWDWwEoKG3A0meA3jA=;
 b=fTr17cF14srk/3DNNxMEn9AL4bJofKXaXHc5fjyBNc/E4ufDKE+pJeCfx+m/P3Qm44
 XdlFb1O2T7iWxABXD4cTlMNn0k1uaOiGqo9ko02PuiFMBCumu89VN0sguMpPKwDlCWqi
 USR2l6dfCmDQIuOu7qL1VTAmznByS9SL7vY+z9yVI8B8xO96rZSXt0co38rSI5u+teLE
 VHJSD/Zwt5jExlCZLmmNSa8a9XHExvqEvCrP6RgzMmhzAyHT79GrjqeM1uQintA6OhoT
 7a4WmPnqakxmCgyeKGDHQBx68Zsgw2cJUK2RUGgr06Lx1eods3OXGphO+5N0QczDwfLl
 2KZA==
X-Gm-Message-State: AOAM533zRCywgUWy0fXaP2zfE7Ks4YZamWlB1o3PGVr7+qarbYG2fd9i
 zBVhQaMElgzXBXhKT9V0RXmXY9GChOylvvfrjgHy4cQo
X-Google-Smtp-Source: ABdhPJyYustfZfZl7BLQkBh0ByhfaBrekSB0Y+9Ti6o+YIXL+LHrA4K+GmLqB4BN7E9+McG+pO2SI0wVg6XdMdk/SRo=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18736439otg.311.1606774727965; 
 Mon, 30 Nov 2020 14:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org>
 <20201124193824.1118741-16-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-16-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 17:18:36 -0500
Message-ID: <CADnq5_OfkE7H9dsurRiFb8Y3XkCHwcK0zBMCYnNTz0KK_ihr0Q@mail.gmail.com>
Subject: Re: [PATCH 15/40] drm/amd/amdgpu/gfx_v8_0: Functions must follow
 directly after their headers
To: Lee Jones <lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMjo0NCBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmM6MzY5
ODogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAnYWRldicgZGVzY3JpcHRpb24g
aW4gJ0RFRkFVTFRfU0hfTUVNX0JBU0VTJwo+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzog
RGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBTdW1pdCBTZW13YWwgPHN1bWl0
LnNlbXdhbEBsaW5hcm8ub3JnPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGxpbnV4LW1lZGlhQHZn
ZXIua2VybmVsLm9yZwo+IENjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKPiBTaWdu
ZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKQXBwbGllZC4gIFRo
YW5rcyEKCkFsZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8w
LmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCj4gaW5kZXggNWU2ZDE1ZjQ0
NTYwYS4uOWE5MDU1MzFmODM3NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjhfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4
XzAuYwo+IEBAIC0zNjg3LDYgKzM2ODcsNyBAQCBzdGF0aWMgdm9pZCBnZnhfdjhfMF9zZXR1cF9y
YihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgICAgICAgIG11dGV4X3VubG9jaygmYWRl
di0+Z3JibV9pZHhfbXV0ZXgpOwo+ICB9Cj4KPiArI2RlZmluZSBERUZBVUxUX1NIX01FTV9CQVNF
UyAgICgweDYwMDApCj4gIC8qKgo+ICAgKiBnZnhfdjhfMF9pbml0X2NvbXB1dGVfdm1pZCAtIGdh
cnQgZW5hYmxlCj4gICAqCj4gQEAgLTM2OTUsNyArMzY5Niw2IEBAIHN0YXRpYyB2b2lkIGdmeF92
OF8wX3NldHVwX3JiKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgKiBJbml0aWFsaXpl
IGNvbXB1dGUgdm1pZCBzaF9tZW0gcmVnaXN0ZXJzCj4gICAqCj4gICAqLwo+IC0jZGVmaW5lIERF
RkFVTFRfU0hfTUVNX0JBU0VTICAgKDB4NjAwMCkKPiAgc3RhdGljIHZvaWQgZ2Z4X3Y4XzBfaW5p
dF9jb21wdXRlX3ZtaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gIHsKPiAgICAgICAg
IGludCBpOwo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
