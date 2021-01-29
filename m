Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55702C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 11:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD4E64FA1
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 11:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD4E64FA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C1A46E1F9;
	Fri, 29 Jan 2021 11:27:54 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3DBD6E1F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 11:27:52 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id c6so10188655ede.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 03:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=aMTIx4f+mEm6AvxYVv69Rb18GZ3aCh1LIbLjikGF/aE=;
 b=kp0ixiK9/Alw6zVIud8J/uVdNso+381Rn6VzxUgMB55oBFBzSWu2nUK6o8iHOrcGLY
 /a+s8cfbmIBVnXZX9uQpEaZbMHP/4xcKXgxAvmu99+eCHk3Ahg8EFg98/h+I8Emebh0J
 4DHJl0ZMqud/UuqXk3ip9sw4JFjK30KjPYKt9aaCJR/PzYgUsXmgLc0VYsx942gaD8Q7
 C7MTtOM+GI8HVQJmb98p7NJRuMQNNh/Md9phu384ICeeznrjd9hhHbhMZyXAFdi8908n
 He9zw8ixjNfdLqGBhNHJAc03MxceYkvhHaszYWQPKscBKVkw7ePu4WPlhWX6qjWvXme4
 cgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=aMTIx4f+mEm6AvxYVv69Rb18GZ3aCh1LIbLjikGF/aE=;
 b=G3agH+adIflFQJ58jRYT6TrsaDdu8WZAzXwneDxs4fadLg+IYeqNCvjkPZOc1hBAX+
 bWl9mhDrNNrHv2TZQJU5sVkaitrwtb1RBaFS1faf1y7IOoafBRBUMlNcvKpxkq43oa4Y
 oGhxqiFqZ/Y/wjzCZGWehg1vsIDJBZoYzaWOI3UW1amlzbP/ORgNYMriXAFWNs5uVI91
 q/WhHM8CV7KYZVOp8Drn1yM77R9qQixdtbjx1xXL/S1D9jtn+N82KIZYVVvFJ+FHTJtu
 ZJZ/k7eV9Jx8xwUQeqanSrm9g+/lV3D8PXAWfnXydocrqvoI68a2gUIvtWKEsjy31mOl
 bk2A==
X-Gm-Message-State: AOAM530vPmNZDxMwq2jfqcmoh0HS4aJFb6gsaBF32cJbWLDP1ib3qZUS
 Oz9TDSfIbXNNgTvbzZQWOSpCGfd1qpw=
X-Google-Smtp-Source: ABdhPJy9UyTF2QZPM+PjKBLsfDbCBcrtOyoyzUytHshkkK3OFNnu/qh5aEKxgJ19JOVcVEQHV1OTqQ==
X-Received: by 2002:a50:eb81:: with SMTP id y1mr4427138edr.176.1611919671376; 
 Fri, 29 Jan 2021 03:27:51 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id d18sm903602eds.50.2021.01.29.03.27.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 03:27:50 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Limit the maximum size of contiguous VRAM
 that can be encapsulated by an instance of DRM memory node
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210128174355.7097-1-Ramesh.Errabolu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0ef90cb8-04a2-2ee8-78d6-a0b6dbe54805@gmail.com>
Date: Fri, 29 Jan 2021 12:27:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128174355.7097-1-Ramesh.Errabolu@amd.com>
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

QW0gMjguMDEuMjEgdW0gMTg6NDMgc2NocmllYiBSYW1lc2ggRXJyYWJvbHU6Cj4gW1doeV0KPiBF
bmFibGUgMToxIG1hcHBpbmcgYmV0d2VlbiBWUkFNIG9mIGEgRFJNIG5vZGUgYW5kIGEgc2NhdHRl
cmxpc3Qgbm9kZQo+Cj4gW0hvd10KPiBFbnN1cmUgY29uc3RydWN0aW9uIG9mIERSTSBub2RlIHRv
IG5vdCBleGNlZWQgc3BlY2lmaWVkIGxpbWl0Cj4KPiBTaWduZWQtb2ZmLWJ5OiBSYW1lc2ggRXJy
YWJvbHUgPFJhbWVzaC5FcnJhYm9sdUBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYyB8IDMgKysrCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdnJhbV9tZ3IuYwo+IGluZGV4IDIwNzQ3ZDhiMTEzNS4uMjFkMThlZmNhMjc3IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKPiBAQCAtNDc2
LDYgKzQ3Niw5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1Y3QgdHRtX3Jl
c291cmNlX21hbmFnZXIgKm1hbiwKPiAgIAlmb3IgKGkgPSAwOyBwYWdlc19sZWZ0ID49IHBhZ2Vz
X3Blcl9ub2RlOyArK2kpIHsKPiAgIAkJdW5zaWduZWQgbG9uZyBwYWdlcyA9IHJvdW5kZG93bl9w
b3dfb2ZfdHdvKHBhZ2VzX2xlZnQpOwo+ICAgCj4gKwkJLyogTGltaXQgbWF4aW11bSBzaXplIHRv
IDJHQiBkdWUgdG8gU0cgdGFibGUgbGltaXRhdGlvbnMgKi8KPiArCQlwYWdlcyA9IG1pbihwYWdl
cywgKDJVTCA8PCAoMzAgLSBQQUdFX1NISUZUKSkpOwo+ICsKPiAgIAkJciA9IGRybV9tbV9pbnNl
cnRfbm9kZV9pbl9yYW5nZShtbSwgJm5vZGVzW2ldLCBwYWdlcywKPiAgIAkJCQkJCXBhZ2VzX3Bl
cl9ub2RlLCAwLAo+ICAgCQkJCQkJcGxhY2UtPmZwZm4sIGxwZm4sCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
