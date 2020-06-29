Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA41CC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 09:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FB32342C
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 09:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlDekn6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FB32342C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CDE289EBD;
	Mon, 29 Jun 2020 09:43:51 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0CF689EBD
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 09:43:50 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id g20so12031729edm.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 02:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=MmyuwKVmhz4vWGX8LRM/TutfdCMmDYfHqx1Hdi1DpIU=;
 b=nlDekn6iWaMxdUg46o4/sa00t2NbLWXdfzk5JXIYlvXRUt3KG2Fxz5c/xHAKdGXsWz
 +R/SYHhZW4xXoPQcMonpoPIM+u5lqCEV2jukuKt4xy+WZLNwPmK+nDQtphlsg76hl701
 wGE1yts9McNeQZHrdHfRZN3SzvIqHEvGD01ZB47IPlxIyEsRzxsJl+KbT8TNKLkJhvDV
 p+On8/9OhSGFRy9Lh4Y74qgq62tiFAkpOHWuJfs1gISsw5VAE8gHKQB1/9aYRi+aEsOU
 4r9pgcz24Hs+ZK4XLoR24gEtQ1GOWufD7+RSoqZVduxm5MHzlVq/HZ20NydAJyERO6e0
 Xn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=MmyuwKVmhz4vWGX8LRM/TutfdCMmDYfHqx1Hdi1DpIU=;
 b=TumtcaHkBGT2P1m/73ZEgd1fbF93Z+o5G8bzN/uO0bBmNNwOKqX9/dq86CKIjcgrmg
 euLTanievHUN9+fexfCD8OZdE5TRq4e8uSqOvkc3Khk/FE7zQ/jn9jIiBmR7JeEw1XYF
 4/a47LMcPe66O57OuCqo2Y1NCkEmJtU+Lo9NDzOLAecO+JjJGIy4V6g3UxtpxkklxdNn
 R5hnGJAv7xQWG4bBh+JM0GyuuX7tGaZEmJK9hvXi9og3wBewjAXKSIl0tkSiNYBtl/R2
 l2mCjJI0PRUSXvmdB1of/085JC+6Wjg77IZazq0cSOPMYGjdMz0OfSzp3jaq+ax3MBea
 T0yA==
X-Gm-Message-State: AOAM532CTb4fR170OGvCfNzxcynZwtwkIe/8DCqbIH5SIWkhVSmIBoBV
 dJ8j8wzYetaMiLutks9SFkrhfcTi
X-Google-Smtp-Source: ABdhPJxhno2/ClAxIn+VGiNIt9jAlmwrMVyTNsmCjBX0lNgIQufq+dtLPWpH9EJ+KTPyEqQe8BAD1w==
X-Received: by 2002:aa7:c496:: with SMTP id m22mr3372047edq.336.1593423829057; 
 Mon, 29 Jun 2020 02:43:49 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id cw14sm6781752edb.88.2020.06.29.02.43.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jun 2020 02:43:48 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: make IB test synchronize with init for
 SRIOV(v2)
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1593423339-2773-1-git-send-email-Monk.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4c827264-1dd7-b977-0bea-d0ab8db82898@gmail.com>
Date: Mon, 29 Jun 2020 11:43:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1593423339-2773-1-git-send-email-Monk.Liu@amd.com>
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

QW0gMjkuMDYuMjAgdW0gMTE6MzUgc2NocmllYiBNb25rIExpdToKPiBpc3N1ZToKPiBvcmlnaW5h
bGx5IHdlIGtpY2tvZmYgSUIgdGVzdCBhc3luY2hyb25vdXNseSB3aXRoIGRyaXZlcidzCj4gaW5p
dCwgdGh1cwo+IHRoZSBJQiB0ZXN0IG1heSBzdGlsbCBydW5uaW5nIHdoZW4gdGhlIGRyaXZlciBs
b2FkaW5nCj4gZG9uZSAobW9kcHJvYmUgYW1kZ3B1IGRvbmUpLgo+IGlmIHdlIHNodXRkb3duIFZN
IGltbWVkaWF0ZWx5IGFmdGVyIGFtZGdwdSBkcml2ZXIKPiBsb2FkZWQgdGhlbiBHUFUgbWF5Cj4g
aGFuZyBiZWNhdXNlIHRoZSBJQiB0ZXN0IGlzIHN0aWxsIHJ1bm5pbmcKPgo+IGZpeDoKPiBmbHVz
aCB0aGUgZGVsYXllZF9pbml0IHJvdXRpbmUgYXQgdGhlIGJvdHRvbSBvZiBkZXZpY2VfaW5pdAo+
IHRvIGF2b2lkIGRyaXZlciBsb2FkaW5nIGRvbmUgcHJpb3IgdG8gdGhlIElCIHRlc3QgY29tcGxl
dGVzCj4KPiBTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KCk1heWJl
IGRvIHRoaXMgZXZlbiBhZnRlciBzeXNmcyBhbmQgUE1VIGluaXQsIGJ1dCBlaXRoZXIgd2F5IEFj
a2VkLWJ5OiAKQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAt
LS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDMgKysr
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gaW5kZXggNDU3ZjVkMi4uN2E0ZTk2NSAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBAQCAtMzI5
NSw2ICszMjk1LDkgQEAgaW50IGFtZGdwdV9kZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKPiAgIAlxdWV1ZV9kZWxheWVkX3dvcmsoc3lzdGVtX3dxLCAmYWRldi0+ZGVsYXll
ZF9pbml0X3dvcmssCj4gICAJCQkgICBtc2Vjc190b19qaWZmaWVzKEFNREdQVV9SRVNVTUVfTVMp
KTsKPiAgIAo+ICsJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkKPiArCQlmbHVzaF9kZWxheWVk
X3dvcmsoJmFkZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsKPiArCj4gICAJciA9IHN5c2ZzX2NyZWF0
ZV9maWxlcygmYWRldi0+ZGV2LT5rb2JqLCBhbWRncHVfZGV2X2F0dHJpYnV0ZXMpOwo+ICAgCWlm
IChyKSB7Cj4gICAJCWRldl9lcnIoYWRldi0+ZGV2LCAiQ291bGQgbm90IGNyZWF0ZSBhbWRncHUg
ZGV2aWNlIGF0dHJcbiIpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
