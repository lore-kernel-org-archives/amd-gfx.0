Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AFCC2D0C2
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 20:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48229222C4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 20:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ba7BhoTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48229222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1077189E9B;
	Fri,  3 Jan 2020 20:35:22 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA36D89DD3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 20:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578083718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsuLr5ZVjVIlutjxMEKe0gKIqnRBkCxqqMJb3ulXWi0=;
 b=ba7BhoTdezyNxfAUZbFb84J8uwOlvQ5ZOSMIa5RikfQHBHardyoqhZHahOwELENU6/PhD/
 /psQWI10etHLb6sFU32ZwWY+hvvhlPkNqwkNOHyJJjiE/nyyzgS5Q2SDGDo01XXPHuSy/e
 eSeZPk+VjTRL1yJlOidih2I/ewlEU4w=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-ZgjrinvGNOSH0cyf2-EAYA-1; Fri, 03 Jan 2020 15:35:16 -0500
Received: by mail-pf1-f198.google.com with SMTP id d85so30093034pfd.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Jan 2020 12:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=5P6pC9bB+XM8/Xw1EneHQrwc3b3SXf3nT5GAbtbko10=;
 b=bXyGdSlyjFoMqSnNBePvc6/SRZnmf0mEkjlrVRw92pXNSPix5pav2sRi7bHcEzOC7g
 R9vyaoOkJnwLOv7iIBNouE8H4r/9k3nvOu1u0PNC51+q0XjMXeqd83z73dOfa1tzKcwD
 eTXNHF/M9sK/gSBvwaStqWFvHbdV34MmdoYezKDfKkX4c1L9MHv7ntRPPZF0oGI838zO
 s6JQ54Z7JBq5mzXCkDA0EGtLHn+AcyAj6CilLRtJZWvJEtM1Khw6rqPulLzl9mcbd2dJ
 WCjnxzNzzRzt70vyNtT4gyPHgP3420RzQuG3p9grfcLXXDbqWkGJV4MU6ph2zr169Upw
 evpQ==
X-Gm-Message-State: APjAAAVXPdtnAFxAKcLlUUG2vh56qCAxOg6+nsbKiV/GW2O1yRu4aiqz
 AvP2ip/WWA5WIGQWETfIq19RXCjerJZAoQ8KtyWBWpuvyxDhpIcSsGmPiSIjnplBNhK7utNJR1w
 yfYwKHyjlAKmyXfoSVJYh9jGEwQ==
X-Received: by 2002:aa7:96b0:: with SMTP id g16mr92718864pfk.99.1578083715779; 
 Fri, 03 Jan 2020 12:35:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgi68keBLcjfBEz4zN/KMDnPfwz3LFg1QJoD7HQRJG4uxuW/u3P8yGx/4EeO57ZnsZsWnpOw==
X-Received: by 2002:ad4:5421:: with SMTP id g1mr68023134qvt.57.1578083714480; 
 Fri, 03 Jan 2020 12:35:14 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id h28sm16911014qkk.48.2020.01.03.12.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2020 12:35:13 -0800 (PST)
Message-ID: <cfb5d28df84df7d3ce20656ca40be65713d5bdb0.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Avoid NULL pointer dereference
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Date: Fri, 03 Jan 2020 15:35:12 -0500
In-Reply-To: <20191226023151.5448-1-Wayne.Lin@amd.com>
References: <20191226023151.5448-1-Wayne.Lin@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: ZgjrinvGNOSH0cyf2-EAYA-1
X-Mimecast-Spam-Score: 0
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
Cc: jerry.zuo@amd.com, mikita.lipski@amd.com, harry.wentland@amd.com,
 Nicholas.Kazlauskas@amd.com, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QmFjayBmcm9tIHRoZSBob2xpZGF5cyEKClJldmlld2VkLWJ5OiBMeXVkZSBQYXVsIDxseXVkZUBy
ZWRoYXQuY29tPgoKRG8geW91IG5lZWQgbWUgdG8gcHVzaCB0aGlzIHRvIGRybS1taXNjPwoKT24g
VGh1LCAyMDE5LTEyLTI2IGF0IDEwOjMxICswODAwLCBXYXluZSBMaW4gd3JvdGU6Cj4gW1doeV0K
PiBGb3VuZCBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIHVuZGVyIHRoZSBiZWxvdyBz
aXR1YXRpb246Cj4gCj4gCXNyYyDigJQgSERNSV9Nb25pdG9yICAgc3JjIOKAlCBIRE1JX01vbml0
b3IKPiBlLmcuOgkgICAgXCAgICAgICAgICAgID0+Cj4gCSAgICAgTVNUQiDigJQgTVNUQiAgICAg
KHVucGx1ZykgTVNUQiDigJQgTVNUQgo+IAo+IFdoZW4gZGlzcGxheSAxIEhETUkgYW5kIDIgRFAg
ZGFpc3kgY2hhaW4gbW9uaXRvcnMsIHVucGx1Z2dpbmcgdGhlIGRwCj4gY2FibGUgY29ubmVjdGVk
IHRvIHNvdXJjZSBjYXVzZXMga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdAo+IGRy
bV9kcF9tc3RfYXRvbWljX2NoZWNrX2J3X2xpbWl0KCkuIFdoZW4gY2FsY3VsYXRpbmcgcGJuX2xp
bWl0LCBpZgo+IGJyYW5jaCBpcyBudWxsLCBhY2Nlc3NpbmcgIiZicmFuY2gtPnBvcnRzIiBjYXVz
ZXMgdGhlIHByb2JsZW0uCj4gCj4gW0hvd10KPiBKdWRnZSBicmFuY2ggaXMgbnVsbCBvciBub3Qg
YXQgdGhlIGJlZ2lubmluZy4gSWYgaXQgaXMgbnVsbCwgcmV0dXJuIDAuCj4gCj4gU2lnbmVkLW9m
Zi1ieTogV2F5bmUgTGluIDxXYXluZS5MaW5AYW1kLmNvbT4KPiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZwo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jIHwg
MyArKysKPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jCj4gYi9kcml2ZXJzL2dwdS9k
cm0vZHJtX2RwX21zdF90b3BvbG9neS5jCj4gaW5kZXggN2QyZDMxZWFmMDAzLi5hNjQ3M2UzYWI0
NDggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMKPiBAQCAtNDcwNyw2
ICs0NzA3LDkgQEAgaW50IGRybV9kcF9tc3RfYXRvbWljX2NoZWNrX2J3X2xpbWl0KHN0cnVjdAo+
IGRybV9kcF9tc3RfYnJhbmNoICpicmFuY2gsCj4gIAlzdHJ1Y3QgZHJtX2RwX3ZjcGlfYWxsb2Nh
dGlvbiAqdmNwaTsKPiAgCWludCBwYm5fbGltaXQgPSAwLCBwYm5fdXNlZCA9IDA7Cj4gIAo+ICsJ
aWYgKCFicmFuY2gpCj4gKwkJcmV0dXJuIDA7Cj4gKwo+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeShw
b3J0LCAmYnJhbmNoLT5wb3J0cywgbmV4dCkgewo+ICAJCWlmIChwb3J0LT5tc3RiKQo+ICAJCQlp
ZiAoZHJtX2RwX21zdF9hdG9taWNfY2hlY2tfYndfbGltaXQocG9ydC0+bXN0YiwKPiBtc3Rfc3Rh
dGUpKQotLSAKQ2hlZXJzLAoJTHl1ZGUgUGF1bAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
