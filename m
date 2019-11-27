Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B181AC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 10:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E26220656
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 10:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E26220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44DEB6E4DE;
	Wed, 27 Nov 2019 10:08:17 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9136E6E4FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 10:08:16 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id z19so6741161wmk.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 02:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=qVrfl6EX1TMkqY8HNIkM7Myz1vVSdRuJ26yqGwUjbBQ=;
 b=V5wg1/jtzjStRIIZE09gJEF3J0gMyNNIc2VpV24S7keXLrdSRJJApt2T6XR4MgxKNa
 n2kvjqRq1g0KTPOf6K5LRprzJqwZeMFTbA8gAXJHzgquKYJ8852MXTnXhl3bxuf7TWBL
 2sBR5ltinfRZCtPyTjlICLgB+EZrl026c9VcGP+8tf0v2UDScAQN+6q96cWxUmq2Bnz4
 EAfFC2PaCA79XMHzDn6j2uiXfITnRa4ZuYH+MlRa7lcP+ZKGNOGXazmAZHSUgnTn61Ig
 FQNw3uSlh+ar0QuNwXoZgNmC8oymtqJGytjaGStTHYA7cAqukVXa3MHI0yq9kHgdFQcn
 X0bQ==
X-Gm-Message-State: APjAAAW0A9MxXdD0rbBPcfxTqXvdhNoMssaYQlVIkl8Labv3Kd4QmSx0
 ICYGpfMQVsqgB6QcbVPiJCw=
X-Google-Smtp-Source: APXvYqxw7oTkf88ntWmB3ne8i5IS+3hcxNlfaj9orP30C6bYHlmoOMX4gVRnhsW8+4s17HNKQSDh4w==
X-Received: by 2002:a05:600c:2283:: with SMTP id
 3mr3423685wmf.100.1574849295300; 
 Wed, 27 Nov 2019 02:08:15 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a6sm7984535wmb.1.2019.11.27.02.08.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Nov 2019 02:08:14 -0800 (PST)
Subject: Re: [PATCH 10/10 v2] drm/amdgpu: reduce redundant uvd context lost
 warning message
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <1574848953-11109-1-git-send-email-le.ma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <87e3c897-b226-1bf8-e169-197a149cbc32@gmail.com>
Date: Wed, 27 Nov 2019 11:08:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574848953-11109-1-git-send-email-le.ma@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=qVrfl6EX1TMkqY8HNIkM7Myz1vVSdRuJ26yqGwUjbBQ=;
 b=IcpT+xUVwxA1HEoeLah9OKnaUYs0TIkQDFqTUMjPtJm3LMJtLMFHcWObXPXT3U66mZ
 NusrWlO2bVONRIb6scDKY0Vp1eT/Bu4dIwpJAJWorgMS+ECh4gfKTy0vXN5cvSddpTKn
 BdMPOkWuH7ZT3j0kMlgDJLjA9ELSj9Qi/zljLknBTAxMWTdVZbLN/qubJsk9+6lvgjwa
 e4RCIfD+yqgIc35TZ3aDCnauVQOZcDwmpsQVTKI7a7ipLVystwGxp19a9LuFEtIQXAub
 6gbK9/lsQnF7+qy7oxyv7Fz5un1DElmZJ8WMjG0uYYVj6tU6yUsgmY8TY2Vhamo3E74X
 Gggg==
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
Reply-To: christian.koenig@amd.com
Cc: alexander.deucher@amd.com, tao.zhou1@amd.com, dennis.li@amd.com,
 guchun.chen@amd.com, hawking.zhang@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127100813.ZkM-4IuKfu43lIFWaD3DUaT9nfvf8ShIk1c8FdulqzM@z>

QW0gMjcuMTEuMTkgdW0gMTE6MDIgc2NocmllYiBMZSBNYToKPiBNb3ZlIHRoZSBwcmludCBvdXQg
b2YgdXZkIGluc3RhbmNlIGxvb3AgaW4gYW1kZ3B1X3V2ZF9zdXNwZW5kCj4KPiB2MjogZHJvcCB1
bm5lY2Vzc2FyeSBicmFja2V0cwo+Cj4gQ2hhbmdlLUlkOiBJZmFkOTk3ZGViZDg0NzYzZTFiNTVk
NjY4ZTE0NGI3Mjk1OThmMTE1ZQo+IFNpZ25lZC1vZmYtYnk6IExlIE1hIDxsZS5tYUBhbWQuY29t
Pgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jIHwgMTAg
KysrKysrLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMKPiBpbmRleCBl
MzI0YmZlLi42OTI0OGVjYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXZkLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXZkLmMKPiBAQCAtMzc2LDEzICszNzYsMTUgQEAgaW50IGFtZGdwdV91dmRfc3VzcGVuZChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAkJCXJldHVybiAtRU5PTUVNOwo+ICAgCj4gICAJ
CS8qIHJlLXdyaXRlIDAgc2luY2UgZXJyX2V2ZW50X2F0aHViIHdpbGwgY29ycnVwdCBWQ1BVIGJ1
ZmZlciAqLwo+IC0JCWlmIChhbWRncHVfcmFzX2ludHJfdHJpZ2dlcmVkKCkpIHsKPiAtCQkJRFJN
X1dBUk4oIlVWRCBWQ1BVIHN0YXRlIG1heSBsb3N0IGR1ZSB0byBSQVMgRVJSRVZFTlRfQVRIVUJf
SU5URVJSVVBUXG4iKTsKPiArCQlpZiAoYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpKQoKQ2Fu
IHRoZSBzdGF0ZSBjaGFuZ2Ugd2hpbGUgZG9pbmcgdGhlIGxvb3A/IElmIHllcyB0aGFuIEkgd291
bGQgcmF0aGVyIApncmFiIHRoYXQgb25jZSBhbmQgdXNlIGl0IG11bHRpcGxlIHRpbWVzLgoKQ2hy
aXN0aWFuLgoKPiAgIAkJCW1lbXNldChhZGV2LT51dmQuaW5zdFtqXS5zYXZlZF9ibywgMCwgc2l6
ZSk7Cj4gLQkJfSBlbHNlIHsKPiArCQllbHNlCj4gICAJCQltZW1jcHlfZnJvbWlvKGFkZXYtPnV2
ZC5pbnN0W2pdLnNhdmVkX2JvLCBwdHIsIHNpemUpOwo+IC0JCX0KPiAgIAl9Cj4gKwo+ICsJaWYg
KGFtZGdwdV9yYXNfaW50cl90cmlnZ2VyZWQoKSkKPiArCQlEUk1fV0FSTigiVVZEIFZDUFUgc3Rh
dGUgbWF5IGxvc3QgZHVlIHRvIFJBUyBFUlJFVkVOVF9BVEhVQl9JTlRFUlJVUFRcbiIpOwo+ICsK
PiAgIAlyZXR1cm4gMDsKPiAgIH0KPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
