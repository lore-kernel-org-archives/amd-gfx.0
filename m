Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC96C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 10:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D011E613BE
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 10:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D011E613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7732E6E082;
	Tue, 27 Apr 2021 10:54:18 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B39D6E06E
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 10:54:14 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id t4so5574279ejo.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=y/oJZ4UyXZlSudjMpCqettBUsx9fFSrJm8e9mE2HJ6E=;
 b=Whzm5m4wctz9m465WkERHHa+uc9U7mBi5TTptXbMJza80wjqjH6ohX9JMO6LhkBgPJ
 l8bqDxMcWjNV4wVGf10pv7tiFCaYBU9uezBxBtAuoA3TDKT9vav7bO9zMSALrTlH7TT6
 1FTcYdAvWuuz5vNx2Kc5OtD5AuQqfQio5zVGIVXiieuZncTyaDuXWhk1f3vnzyMdIdnt
 usMQ8oldK40223Hi8Qgbp+940w99Sh2xiGveqbUk5KMfbFiAqch5mvBmEoCOtIF04AUp
 RdmLmIGxz6ZGjJOLVR4sCNCpz2OEzHVlmx37EmYLz49LCE1+VdEW4kUwwidoxkxctrQ3
 Qrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y/oJZ4UyXZlSudjMpCqettBUsx9fFSrJm8e9mE2HJ6E=;
 b=XmnPCx1rdowHHlQ6xo7AOPMjixOXuPo7Pm0K8lhIlxFm/xGFTiRg7/111uLI8xnd49
 c0DRxCC/u5QaO/VrTe81kuQySWHVfJwDVB76vb03q2qOyrsObIHPkalPCcmcQkja98tj
 HbdObpwyO0uCV0FPUWgSV9fGLR6bdWJ1wKShMvj6lrjrumb84DpbpkPRE5vz7XkFSVYb
 b6XbZx2hh5s4v4Hfdqn74I1YHNZkIRdnMruXR+B0ZKoOAOwSjy54OsIecJ1nAD8C2KYa
 kfNonJjIkPdZb70shy1JbyeC0karh8DxlEL+/NFb8++z0pNEWuEda+ysPVMEVTtlD9uh
 de5w==
X-Gm-Message-State: AOAM530MLnpEGGVW/INULI+TqRFzxIXDs6WNSq6xaHsVp5fUofFmhyIq
 RI/L1+rhDOY+HvkYQo4SU+1FJugbCqQ=
X-Google-Smtp-Source: ABdhPJwLWFUkD5kX/vK4ljn+Be5kseUDFpdJz/DsM7OK7i/+mOSY9qsY3pSmRgx3OgU0wApg6klzSQ==
X-Received: by 2002:a17:906:b2cd:: with SMTP id
 cf13mr23259590ejb.419.1619520852743; 
 Tue, 27 Apr 2021 03:54:12 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:cc40:13c1:6c51:27cd])
 by smtp.gmail.com with ESMTPSA id o8sm12995411ejm.18.2021.04.27.03.54.12
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 03:54:12 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: set the contiguous flag if possible
Date: Tue, 27 Apr 2021 12:54:08 +0200
Message-Id: <20210427105410.2700-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210427105410.2700-1-christian.koenig@amd.com>
References: <20210427105410.2700-1-christian.koenig@amd.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBhdm9pZHMgcmVhbGxvY2F0aW5nIHNjYW5vdXQgQk9zIG9uIGZpcnN0IHBpbiBpbiBhIGxv
dCBvZiBjYXNlcy4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJh
bV9tZ3IuYyB8IDUgKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZyYW1fbWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3Iu
YwppbmRleCBlMmNiZTE5NDA0YzAuLjg3YzQwYzRjZGQ1MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKQEAgLTQ0NiwxMCArNDQ2LDExIEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFnZXIgKm1h
biwKIAl9CiAJc3Bpbl91bmxvY2soJm1nci0+bG9jayk7CiAKLQlhdG9taWM2NF9hZGQodmlzX3Vz
YWdlLCAmbWdyLT52aXNfdXNhZ2UpOworCWlmIChpID09IDEpCisJCW1lbS0+cGxhY2VtZW50IHw9
IFRUTV9QTF9GTEFHX0NPTlRJR1VPVVM7CiAKKwlhdG9taWM2NF9hZGQodmlzX3VzYWdlLCAmbWdy
LT52aXNfdXNhZ2UpOwogCW1lbS0+bW1fbm9kZSA9IG5vZGVzOwotCiAJcmV0dXJuIDA7CiAKIGVy
cm9yOgotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
