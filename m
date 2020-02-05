Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC84C35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1388D20730
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr9o9t2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1388D20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF95589D2F;
	Wed,  5 Feb 2020 15:40:14 +0000 (UTC)
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3FE89C27;
 Wed,  5 Feb 2020 15:40:13 +0000 (UTC)
Received: by mail-yw1-xc43.google.com with SMTP id n184so2769031ywc.3;
 Wed, 05 Feb 2020 07:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O1jdP4CEORovm2VR+Fw+/VJ73Y3rqRpk3hpguLeOylg=;
 b=Jr9o9t2zLRb4kSWg6/NfVYteb+w1FcSSbnWBaBHw/UNkrLq4HJre7jBKtPd/a0V/gG
 ro4KSPlduebgx3MobTH42vDFasL8tHJIdOoT8S4x2cwPf6NOzDREh0Y8gnw34rZBdiHk
 r5TggbzkXHDlCjvJRnb5gDj6um6BgdbmULDn80rNbXk1lSLjIp4+HgIA3/hSieMOsS5E
 BbvFt6bleG5EE9sturt3EnZ9D3862PpRnMW+rwj2N8rsb3aFe5pbENi+jEpeoxGCotOe
 Wp5U4EjdRjzJGqPmofrZCFYwlCRDS15MCwf7qUmC+MHeY+YEVBDrgCWPFdOYxvnWgKMK
 Rolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O1jdP4CEORovm2VR+Fw+/VJ73Y3rqRpk3hpguLeOylg=;
 b=KmX4hizkEmoWP+T8bh5kM9HNsWG1XzXa+zhzinK36vDWE668lHGOhfjUywPYYjHH7u
 NxsI0fuVcRPzf1RmpJCV0qOYw0H8pf2QQBSQrPxUM3Gv7Tv3BMQ8x+IOU6SQ2mo9hdgQ
 TPzSek+1A5lk8cukwOv1n22hPBwxuNUlwX6JptPyyoF5KBTbIQYKu8SdPeqs+sPwwKy8
 NKbT26NlhLHenUEXZuPIqwgOLaLwmP+O2R+IUAQUzaKmI6MbFhpfK9fPrDbNdHvqHPgX
 hCTDZXrGcu9s19zFSGpckqscN/r4kBX9tOqrVAkFYvlLicbzPQHfXVf0ZrOFVo1ZyJl4
 q1dA==
X-Gm-Message-State: APjAAAWL3elAGALpL47I5AAnd9tjFzVqIDMdSb8s66vZSoJNa5H9CXcA
 2Mf6pNEsPSfW8QxtF0x1oHh6G3mm
X-Google-Smtp-Source: APXvYqxft52W8PKn6ZjuWWbVlRr96a/W/AtJBgcu6VexT5QhVoHwSVPUn3ytADI/ypXM/Ja0ERkCpw==
X-Received: by 2002:a25:2e12:: with SMTP id u18mr28463905ybu.250.1580917212668; 
 Wed, 05 Feb 2020 07:40:12 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id q185sm61256ywh.61.2020.02.05.07.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 07:40:12 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 04/15] drm/amdgpu/sa: move debugfs init into core amdgpu
 debugfs
Date: Wed,  5 Feb 2020 10:39:49 -0500
Message-Id: <20200205154000.536145-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205154000.536145-1-alexander.deucher@amd.com>
References: <20200205154000.536145-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SW4gb3JkZXIgdG8gcmVtb3ZlIHRoZSBsb2FkIGFuZCB1bmxvYWQgZHJtIGNhbGxiYWNrcywKd2Ug
bmVlZCB0byByZW9yZGVyIHRoZSBpbml0IHNlcXVlbmNlIHRvIG1vdmUgYWxsIHRoZSBkcm0KZGVi
dWdmcyBmaWxlIGhhbmRsaW5nLiAgRG8gdGhpcyBmb3IgU0EgKHN1YiBhbGxvY2F0b3IpLgoKQWNr
ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVk
LW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgfCA0ICsrKysKIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jICAgICAgfCA3ICsrLS0tLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaCAgfCAxICsKIDMgZmlsZXMgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCmluZGV4IGMxZDY2Y2M2ZTZkOC4uODRjNWU5ZjIz
Yzc2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdm
cy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKQEAg
LTEyNDEsNiArMTI0MSwxMCBAQCBpbnQgYW1kZ3B1X2RlYnVnZnNfaW5pdChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKIAkJcmV0dXJuIHI7CiAJfQogCisJaWYgKGFtZGdwdV9kZWJ1Z2ZzX3Nh
X2luaXQoYWRldikpIHsKKwkJZGV2X2VycihhZGV2LT5kZXYsICJmYWlsZWQgdG8gcmVnaXN0ZXIg
ZGVidWdmcyBmaWxlIGZvciBTQVxuIik7CisJfQorCiAJcmV0dXJuIGFtZGdwdV9kZWJ1Z2ZzX2Fk
ZF9maWxlcyhhZGV2LCBhbWRncHVfZGVidWdmc19saXN0LAogCQkJCQlBUlJBWV9TSVpFKGFtZGdw
dV9kZWJ1Z2ZzX2xpc3QpKTsKIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9pYi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMK
aW5kZXggNmUwZjk3YWZiMDMwLi5hYmYyODZmMmJjNWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9pYi5jCkBAIC00OCw3ICs0OCw2IEBACiAgKiBwcm9kdWNlIGNvbW1hbmQgYnVm
ZmVycyB3aGljaCBhcmUgc2VuZCB0byB0aGUga2VybmVsIGFuZAogICogcHV0IGluIElCcyBmb3Ig
ZXhlY3V0aW9uIGJ5IHRoZSByZXF1ZXN0ZWQgcmluZy4KICAqLwotc3RhdGljIGludCBhbWRncHVf
ZGVidWdmc19zYV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKIAogLyoqCiAgKiBh
bWRncHVfaWJfZ2V0IC0gcmVxdWVzdCBhbiBJQiAoSW5kaXJlY3QgQnVmZmVyKQpAQCAtMjk1LDkg
KzI5NCw3IEBAIGludCBhbWRncHVfaWJfcG9vbF9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogCX0KIAogCWFkZXYtPmliX3Bvb2xfcmVhZHkgPSB0cnVlOwotCWlmIChhbWRncHVfZGVi
dWdmc19zYV9pbml0KGFkZXYpKSB7Ci0JCWRldl9lcnIoYWRldi0+ZGV2LCAiZmFpbGVkIHRvIHJl
Z2lzdGVyIGRlYnVnZnMgZmlsZSBmb3IgU0FcbiIpOwotCX0KKwogCXJldHVybiAwOwogfQogCkBA
IC00MjEsNyArNDE4LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkcm1faW5mb19saXN0IGFtZGdw
dV9kZWJ1Z2ZzX3NhX2xpc3RbXSA9IHsKIAogI2VuZGlmCiAKLXN0YXRpYyBpbnQgYW1kZ3B1X2Rl
YnVnZnNfc2FfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKK2ludCBhbWRncHVfZGVi
dWdmc19zYV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogI2lmIGRlZmluZWQo
Q09ORklHX0RFQlVHX0ZTKQogCXJldHVybiBhbWRncHVfZGVidWdmc19hZGRfZmlsZXMoYWRldiwg
YW1kZ3B1X2RlYnVnZnNfc2FfbGlzdCwgMSk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfb2JqZWN0LmgKaW5kZXggMjZhNjU0Y2JkNTMwLi43ZDQxZjdiOWEzNDAgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAorKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmgKQEAgLTMzMCw2ICszMzAsNyBA
QCB2b2lkIGFtZGdwdV9zYV9ib19mcmVlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogdm9p
ZCBhbWRncHVfc2FfYm9fZHVtcF9kZWJ1Z19pbmZvKHN0cnVjdCBhbWRncHVfc2FfbWFuYWdlciAq
c2FfbWFuYWdlciwKIAkJCQkJIHN0cnVjdCBzZXFfZmlsZSAqbSk7CiAjZW5kaWYKK2ludCBhbWRn
cHVfZGVidWdmc19zYV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKIAogYm9vbCBh
bWRncHVfYm9fc3VwcG9ydF91c3djKHU2NCBib19mbGFncyk7CiAKLS0gCjIuMjQuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
