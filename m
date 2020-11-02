Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C1EC00A89
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 18:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD4022245
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 18:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pd/neIsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD4022245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730506E25B;
	Mon,  2 Nov 2020 18:29:31 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED8876E25B
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 18:29:29 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id b8so15794914wrn.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2020 10:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AD4qaLqrUfvthEtXssNKTx7whd+tB1pmqzCqC8AsUqo=;
 b=Pd/neIsiCnprLVLZVdhRZM40KgAlUsZ0JoVuWUwJ1As+VeTLJmT0iI4xKFo8gKUhEX
 BSkPcjPACfxAA60PnC8Hh9E6DlIc4zdgGdOywCwNQoNOmGMWcB9A7YEQClJzckg4Pe0a
 v1e+TQUiaagbGjGVCswm68pvH9AmnshKcCuTrDFZhMQf5ZNdw3uwgbJbGSM9KXkWbVDd
 yLy/x9Q6VxfkS0X+1Cqq5Jw7nd9CvAyP1nxgxZ4gk7S5ApIKKG7Z1gtSeBXZlVXrUA12
 RXPMoiMrZbMhNzU1QiJnNuvr4NRtCP6QJfAGZmWwWOillBD2lnJ8eVnX64PrpIbD4qdQ
 TnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AD4qaLqrUfvthEtXssNKTx7whd+tB1pmqzCqC8AsUqo=;
 b=C/Ph4H+KoAGJ6qnMnyhEykIaHgI4SRFDn4M/ymz+y4XN5qJf8E7Aw/4tROkCErfyeI
 Mru+644D4vjR64f3Sun8FDCG+aP8KEjlUDvVricAbI2Sece2OJt7c0kkWKaYAO3DoLRu
 78w78B0RyOioJLr9RUrSUIzr4V87/Iqt/5NLC4lxF6mgzUHpJexyop9aFyrn5I2+38q/
 mSesgtecOPn6PK5KeAE8c7rsK/hjBopemRPFrzv5ip1zCPwoMb5Htv/f/4Eu1cf5RRZX
 AIFaL/VLLbNqw/dDPFqRv0e7S0OjdiIbCWPC5cn/jh5iDD/Lt+T8AAvutjww5UjdRBN0
 ZZBg==
X-Gm-Message-State: AOAM531EKK97Pon8nqL7nLC3szUV7odMSdo38DpqFyeztf4+5eVmrqN+
 fbmMTLz+rXx8JrJoUtFL5g6/ufPvvT0MxboSisnqRngN
X-Google-Smtp-Source: ABdhPJy/MEQ8zHUU1nO94fUiY7xqLTIuBb0YkqwqnxVOHPojuglElwpr2MEpJ3W73nU6EhVsJLWGm5/ytK5HExD/ySg=
X-Received: by 2002:adf:f246:: with SMTP id b6mr21531727wrp.111.1604341768596; 
 Mon, 02 Nov 2020 10:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20201102162351.1493-1-christian.koenig@amd.com>
In-Reply-To: <20201102162351.1493-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2020 13:29:17 -0500
Message-ID: <CADnq5_N9osYzTSgK5a3776oT4BVdM6ogiEU0tYrCEVDGA7FR9Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix off by one in amdgpu_vm_handle_fault
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: "Kuehling, Felix" <felix.kuehling@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBOb3YgMiwgMjAyMCBhdCAxMToyMyBBTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBUaGUgdmFsdWUgaXMgaW5jbHVz
aXZlLCBub3QgZXhjbHVzaXZlLgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+
IGluZGV4IGRjMGJjNTUwZTQyYi4uZmRiZTdkNGU4YjhiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtMzM1MSw3ICszMzUxLDcgQEAgYm9vbCBhbWRncHVf
dm1faGFuZGxlX2ZhdWx0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBpbnQg
cGFzaWQsCj4gICAgICAgICB9Cj4KCk1pZ2h0IHdhbnQgdG8gYWRkIGEgY29tbWVudCBoZXJlIGFi
b3V0IHRoZSB2YWx1ZSBiZWluZyBpbmNsdXNpdmUuClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpBbGV4Cgo+ICAgICAgICAgciA9IGFtZGdwdV92
bV9ib191cGRhdGVfbWFwcGluZyhhZGV2LCBhZGV2LCB2bSwgdHJ1ZSwgZmFsc2UsIE5VTEwsIGFk
ZHIsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZHIgKyAxLCBm
bGFncywgdmFsdWUsIE5VTEwsIE5VTEwsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGFkZHIsIGZsYWdzLCB2YWx1ZSwgTlVMTCwgTlVMTCwKPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCk7Cj4gICAgICAgICBpZiAocikKPiAgICAg
ICAgICAgICAgICAgZ290byBlcnJvcl91bmxvY2s7Cj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5n
IGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
