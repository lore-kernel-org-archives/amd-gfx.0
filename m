Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE3DCA9EC7
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 13:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6B620874
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 13:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6B620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14116EA13;
	Wed, 30 Oct 2019 13:54:50 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B426EA13
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 13:54:49 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id x5so2281231wmi.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 06:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=Y4UDF0MSXrwiC6Kh4AJl6PUh64Dou5oEPkjU3mkpREw=;
 b=cfMi+oNHToKcUdiM5J75uoUdb/6g47ipXmpF73tl7W4JrNtUFVENa8rwU42wQeuq02
 45p593IwohJEftZ5BJON8Ld1xkAYxPGzZ4D+UNgNsca3OPNGMvVKhNEzo/WaZrKb0LKz
 Im8cVl6LRAOf0tnebzP7YRrAsaxxpeKYqIO1rRUr7iQAIKGKJGmOTuNYVQhqvL6u01Zu
 xwZS972xBRz5m8g5LnTIjt1/7462trrxUKBFyxjnx4+5U2BZ05QXelyiZmXaag24XA1/
 oi3fzc4X1EZqQ9JyrRYtRwhLNDmJV8BZKuRmZdpAgtYj4VJcNvsvj/qYLl6s3Jx4mD4y
 zs1Q==
X-Gm-Message-State: APjAAAUKApr7SAzhzve3mAi05mpUxFsVGjDsnH3DZWiRn/HJ7Kbc5XaS
 Ghm8inG9xXw5m7Wk+HmnUHLZq2MY
X-Google-Smtp-Source: APXvYqzZVoIVd96nwvf3M2Yjsw8gDoD7ozqZDS0pPdZeIQrWjKLwtmMKZgXZxZ19ArT5HdhqI5hJXg==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr9008982wmj.91.1572443688211;
 Wed, 30 Oct 2019 06:54:48 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 200sm118591wme.32.2019.10.30.06.54.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Oct 2019 06:54:47 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/gmc10: properly set BANK_SELECT and
 FRAGMENT_SIZE
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191029211544.1534432-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9a0b856b-6dae-0ece-326b-76b3bc6e2c6f@gmail.com>
Date: Wed, 30 Oct 2019 14:54:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029211544.1534432-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Y4UDF0MSXrwiC6Kh4AJl6PUh64Dou5oEPkjU3mkpREw=;
 b=SPv1nnYfbkeztQ1ckbYtFk4EzF03W9z9y1KWvtF8suS3bW+R8V2pnM68m8k3Z7kVA+
 IUJsV1malIHdGBNT05VMTEvS1WydNztXrTHZaBkBeaL5qxL90HBnjRoIFqzafxAEdzCV
 o/4fU8BxpE0Wnl4r6dRU1zpi8zCCn3jcjTZweABN8aVb1uE6xu/W/MIl88gsun22MhQy
 BGJQaMTKwNdsyeFygeafI+7/noJ+EMNcscmhXojxiY69jOja8itoWm7f249GYU5BOV2w
 QCwzLrDNe4mRZPgzp9olbRxs3qDGS/h+TDwIKZlV8Ueh4O6x6WfZg0hGnQjE/MDCnELz
 Gkug==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030135446.9H8F04KXJGj24TK5c9BPwtwifUwRymuzaQs_qChgNfQ@z>

QW0gMjkuMTAuMTkgdW0gMjI6MTUgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gVGhlc2Ugd2VyZSBu
b3QgYWxpZ25lZCBmb3Igb3B0aW1hbCBwZXJmb3JtYW5jZSBmb3IgR1BVVk0uCj4KPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpHb29kIGNh
dGNoLiBCdXQgSSBoYXZlbid0IHJlYWQgdGhlIEdNQzEwIGRvY3VtZW50YXRpb24geWV0IG9mIGV2
ZXJ5dGhpbmcgCmlzIHN0aWxsIHRoZSBzYW1lIGFzIG9uIEdNQzkuCgpTbyBvbmx5IEFja2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpSZWdhcmRzLApD
aHJpc3RpYW4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3Yy
XzAuYyB8IDkgKysrKysrKysrCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92
Ml8wLmMgIHwgOSArKysrKysrKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygr
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92Ml8w
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjJfMC5jCj4gaW5kZXggYjYw
MWM2NzQwZWY1Li5iNGYzMmQ4NTNjYTEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4aHViX3YyXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeGh1Yl92Ml8wLmMKPiBAQCAtMTU1LDYgKzE1NSwxNSBAQCBzdGF0aWMgdm9pZCBnZnhodWJf
djJfMF9pbml0X2NhY2hlX3JlZ3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJV1JF
RzMyX1NPQzE1KEdDLCAwLCBtbUdDVk1fTDJfQ05UTDIsIHRtcCk7Cj4gICAKPiAgIAl0bXAgPSBt
bUdDVk1fTDJfQ05UTDNfREVGQVVMVDsKPiArCWlmIChhZGV2LT5nbWMudHJhbnNsYXRlX2Z1cnRo
ZXIpIHsKPiArCQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgR0NWTV9MMl9DTlRMMywgQkFOS19T
RUxFQ1QsIDEyKTsKPiArCQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgR0NWTV9MMl9DTlRMMywK
PiArCQkJCSAgICBMMl9DQUNIRV9CSUdLX0ZSQUdNRU5UX1NJWkUsIDkpOwo+ICsJfSBlbHNlIHsK
PiArCQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgR0NWTV9MMl9DTlRMMywgQkFOS19TRUxFQ1Qs
IDkpOwo+ICsJCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBHQ1ZNX0wyX0NOVEwzLAo+ICsJCQkJ
ICAgIEwyX0NBQ0hFX0JJR0tfRlJBR01FTlRfU0laRSwgNik7Cj4gKwl9Cj4gICAJV1JFRzMyX1NP
QzE1KEdDLCAwLCBtbUdDVk1fTDJfQ05UTDMsIHRtcCk7Cj4gICAKPiAgIAl0bXAgPSBtbUdDVk1f
TDJfQ05UTDRfREVGQVVMVDsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvbW1odWJfdjJfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjJfMC5j
Cj4gaW5kZXggMmVlYTcwMmRlOGVlLi45NDU1MzM2MzQ3MTEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjJfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvbW1odWJfdjJfMC5jCj4gQEAgLTE0Miw2ICsxNDIsMTUgQEAgc3RhdGljIHZv
aWQgbW1odWJfdjJfMF9pbml0X2NhY2hlX3JlZ3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
Cj4gICAJV1JFRzMyX1NPQzE1KE1NSFVCLCAwLCBtbU1NVk1fTDJfQ05UTDIsIHRtcCk7Cj4gICAK
PiAgIAl0bXAgPSBtbU1NVk1fTDJfQ05UTDNfREVGQVVMVDsKPiArCWlmIChhZGV2LT5nbWMudHJh
bnNsYXRlX2Z1cnRoZXIpIHsKPiArCQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgTU1WTV9MMl9D
TlRMMywgQkFOS19TRUxFQ1QsIDEyKTsKPiArCQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgTU1W
TV9MMl9DTlRMMywKPiArCQkJCSAgICBMMl9DQUNIRV9CSUdLX0ZSQUdNRU5UX1NJWkUsIDkpOwo+
ICsJfSBlbHNlIHsKPiArCQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgTU1WTV9MMl9DTlRMMywg
QkFOS19TRUxFQ1QsIDkpOwo+ICsJCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBNTVZNX0wyX0NO
VEwzLAo+ICsJCQkJICAgIEwyX0NBQ0hFX0JJR0tfRlJBR01FTlRfU0laRSwgNik7Cj4gKwl9Cj4g
ICAJV1JFRzMyX1NPQzE1KE1NSFVCLCAwLCBtbU1NVk1fTDJfQ05UTDMsIHRtcCk7Cj4gICAKPiAg
IAl0bXAgPSBtbU1NVk1fTDJfQ05UTDRfREVGQVVMVDsKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
