Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC99C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D2B20672
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D2B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 256476E942;
	Fri, 15 Nov 2019 16:13:15 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 850C66E942
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:13:14 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id b18so10121746wrj.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:13:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r+AiJM0A3c8WqutI65Zvk51abvcclTloP0Yma96dLMo=;
 b=PmlA8Efv0iQGIx7LMxA5s0NbFIqQFfrVGTjKXPS/eKPX7ueZRHiIDhHamfvWMjuEk+
 qM8GCERNikkBheH/h6EFyh1jqEWaCCJEhCUsyeRN8IuosNVywNDjUfNyHisYZ2cT29bU
 ESr+3Ys/LUWtJajPsqNVmEHQIJ8iWDV/2uODXrD9GaFuuO5i9m/NSQmCujiQhLhiFPxy
 +LiWUfv6ldsg2IqQr9aRtRGYq94Bn7g8jlKcqzprFySLbV+ZtpHWc3dxlyOQPkibK9O6
 tN31T76nDPP7vlQQRuGWXj+bClOTXZHe05mo6O1T3a8n/pTNCJ8TDDn5TZ99DHbeZ5KR
 g8Nw==
X-Gm-Message-State: APjAAAWddjmoprXF6YuHUayuqAkQc+0Erd0CbTCtp4ra4kx74fRBT4lX
 B9TX5SXoXAVEg9oR6AWBlOvg1PDskWTBLUtQ7IlovRwx
X-Google-Smtp-Source: APXvYqyxB7i70vinR8oFdgXwKc5wmBwCO46MdCJgBZR8mn0WTikd6BHFI2m+jZQ4O18yAQH6M4KuDLMDGH0Zcn4jDQY=
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr16734372wrr.50.1573834392861; 
 Fri, 15 Nov 2019 08:13:12 -0800 (PST)
MIME-Version: 1.0
References: <20191111222102.876704-1-alexander.deucher@amd.com>
In-Reply-To: <20191111222102.876704-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Nov 2019 11:13:01 -0500
Message-ID:
 <CADnq5_PRwkMfe3iN_6wD_HMZ1qFSb-vru0gYhYyK+6cjNNHQsg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/soc15: move struct definition around to align
 with other soc15 asics
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=r+AiJM0A3c8WqutI65Zvk51abvcclTloP0Yma96dLMo=;
 b=swOGVih3OZbNQtztBR6N+qoqG1oX/KBhZJjILjexObyaQeJa3q8ML8vHYg+PoSaiK+
 vurmlVwTFa7ufrPySEd2yzRXL3HEPOi4eAl3Ovoe7blEhRFCkUnDMkXee73FVFlPuCbO
 q3gc/LZbWNpx2YzL7FmSaI8ZMeyCs9NCtcfqQvIkvWucJtEPRlkWeK8uBheZ50cFIgsd
 UqLgx8EHz8drQaa/nTHnthRez1avvpK0qjZiEaz1wb3uCxM9R8qZGWQxgfGmchEPfNJz
 G5QHJXVbDlBtfgH2qCoWx+LhyHLJV3BOKXo8PM2eqRG01ENVx7nBB7bvk+Ma4iQrUz1u
 qiCA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115161301.zN4ES1VjjZL5JRb-NMLgeHAPHbJPLwLQEfw7BbMcuz0@z>

UGluZz8KCk9uIE1vbiwgTm92IDExLCAyMDE5IGF0IDU6MjEgUE0gQWxleCBEZXVjaGVyIDxhbGV4
ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gTW92ZSByZXNldF9tZXRob2QgbmV4dCB0byBy
ZXNldCBjYWxsYmFjayB0byBtYXRjaCB0aGUgc3RydWN0IGxheW91dCBhbmQKPiB0aGUgb3RoZXIg
ZGVmaW5pdGlvbiBpbiB0aGlzIGZpbGUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NvYzE1LmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCj4gaW5kZXggOGUx
NjQwYmMwN2FmLi4zMDVhZDNlZWM5ODcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc29jMTUuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1
LmMKPiBAQCAtMTAwNyw2ICsxMDA3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfYXNp
Y19mdW5jcyB2ZWdhMjBfYXNpY19mdW5jcyA9Cj4gICAgICAgICAucmVhZF9iaW9zX2Zyb21fcm9t
ID0gJnNvYzE1X3JlYWRfYmlvc19mcm9tX3JvbSwKPiAgICAgICAgIC5yZWFkX3JlZ2lzdGVyID0g
JnNvYzE1X3JlYWRfcmVnaXN0ZXIsCj4gICAgICAgICAucmVzZXQgPSAmc29jMTVfYXNpY19yZXNl
dCwKPiArICAgICAgIC5yZXNldF9tZXRob2QgPSAmc29jMTVfYXNpY19yZXNldF9tZXRob2QsCj4g
ICAgICAgICAuc2V0X3ZnYV9zdGF0ZSA9ICZzb2MxNV92Z2Ffc2V0X3N0YXRlLAo+ICAgICAgICAg
LmdldF94Y2xrID0gJnNvYzE1X2dldF94Y2xrLAo+ICAgICAgICAgLnNldF91dmRfY2xvY2tzID0g
JnNvYzE1X3NldF91dmRfY2xvY2tzLAo+IEBAIC0xMDE5LDcgKzEwMjAsNiBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGFtZGdwdV9hc2ljX2Z1bmNzIHZlZ2EyMF9hc2ljX2Z1bmNzID0KPiAgICAgICAg
IC5nZXRfcGNpZV91c2FnZSA9ICZ2ZWdhMjBfZ2V0X3BjaWVfdXNhZ2UsCj4gICAgICAgICAubmVl
ZF9yZXNldF9vbl9pbml0ID0gJnNvYzE1X25lZWRfcmVzZXRfb25faW5pdCwKPiAgICAgICAgIC5n
ZXRfcGNpZV9yZXBsYXlfY291bnQgPSAmc29jMTVfZ2V0X3BjaWVfcmVwbGF5X2NvdW50LAo+IC0g
ICAgICAgLnJlc2V0X21ldGhvZCA9ICZzb2MxNV9hc2ljX3Jlc2V0X21ldGhvZAo+ICB9Owo+Cj4g
IHN0YXRpYyBpbnQgc29jMTVfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQo+IC0tCj4g
Mi4yMy4wCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
