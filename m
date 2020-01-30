Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB0DC33C9E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 12:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DB2206D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 12:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw66KPT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DB2206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB71E6F99E;
	Thu, 30 Jan 2020 12:49:50 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0222D6F99D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 12:49:47 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id a9so4073328wmj.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 04:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ck+wk2DGqFDLpD1UA9m/OLSJBGyob9/zrCNWYhvX+Gs=;
 b=Rw66KPT40VI0N8tiaLx/1Rz563GjusX/Nsn5DOgqnTvE/Tz8YsCAM1czulHg4wl/SF
 sJM6oPJsRenXBO4OvvrF5p9i1T6aCHFklV5oWAJkwymoDYJQ+TRJqUDd00o9RO563LAU
 8+cGMsmQfI4OsfFnXJ/24bAMG/0KPpvgZQyspRvxk2BPGmbnSsMMq6b0///+fbW0Gqk5
 chSkvfQpkn2xCeGxj2d64aBs2YC18NjDt1mShPdGbjPjcxS0m1nM1ZydfRMcJpy9NUjJ
 w+G4Fvd/NLa8Z6TA13fIDDVbg1SLxdy6DzRGJGnpjqecMDp6cQH21VeewIA+yooG1qYi
 LDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ck+wk2DGqFDLpD1UA9m/OLSJBGyob9/zrCNWYhvX+Gs=;
 b=jY82HWR1qXXkuIfogU7FELlSf0y+JsExX11+TFC8Jyq3pCgUtLNH0A/19QXwkXwQo1
 MODvPaBv4V8F6TOwjI/j3YYO3zc85LZy8zbXrogfZDP7M53PpwdQOWiiogCVXyKAFlcp
 k/DKMi7So6IApl3QKJkQZfXji0+i4kDpnx5jmZZNIYIzyytn4Bzf4noJu0xhXJystjoH
 sIDSBU9b0lIrEA20CkRXdf8ZWDEgEYwyM3UIWGnKawjHOtPn6lIDz30A6iFD/v6lHwOZ
 xWsQdYLWB3+8w9VrEiHmpDYrCocQLt6w2XP8nStsGrDjuoyYty91SNVA3f5C+Mt/QZE4
 A0mQ==
X-Gm-Message-State: APjAAAUWdaS58m01+2ddAXFf4Ffe6UK21kDW9HAltIDf9d5gaL4oakQr
 A2h33JoUBhceTCx228/46N6q1TNA
X-Google-Smtp-Source: APXvYqxdWXbN732zRkD20ay1VtOAmdtIhgAifZBlaLmKW1S6AZtdUbTYyXlJW3+uw29l3CH8OJ3dyw==
X-Received: by 2002:a05:600c:2290:: with SMTP id
 16mr5590599wmf.93.1580388586219; 
 Thu, 30 Jan 2020 04:49:46 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:dc0f:106a:b4b9:c241])
 by smtp.gmail.com with ESMTPSA id i2sm6496912wmb.28.2020.01.30.04.49.45
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 04:49:45 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: simplify and fix amdgpu_sync_resv
Date: Thu, 30 Jan 2020 13:49:39 +0100
Message-Id: <20200130124940.30380-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130124940.30380-1-christian.koenig@amd.com>
References: <20200130124940.30380-1-christian.koenig@amd.com>
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

Tm8gbWF0dGVyIHdoYXQgd2UgYWx3YXlzIG5lZWQgdG8gc3luYyB0byBtb3Zlcy4KClNpZ25lZC1v
ZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KVGVzdGVk
LWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYyB8IDE1ICsrKysrKysrKysrLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMKaW5kZXggYzEyNGY2NGU3YWFlLi45ZjQyMDMyNjc2
ZGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYwpAQCAtMjMyLDEw
ICsyMzIsMTkgQEAgaW50IGFtZGdwdV9zeW5jX3Jlc3Yoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIHN0cnVjdCBhbWRncHVfc3luYyAqc3luYywKIAogCQlmID0gcmN1X2RlcmVmZXJlbmNlX3By
b3RlY3RlZChmbGlzdC0+c2hhcmVkW2ldLAogCQkJCQkgICAgICBkbWFfcmVzdl9oZWxkKHJlc3Yp
KTsKKworCQlmZW5jZV9vd25lciA9IGFtZGdwdV9zeW5jX2dldF9vd25lcihmKTsKKworCQkvKiBB
bHdheXMgc3luYyB0byBtb3Zlcywgbm8gbWF0dGVyIHdoYXQgKi8KKwkJaWYgKGZlbmNlX293bmVy
ID09IEFNREdQVV9GRU5DRV9PV05FUl9VTkRFRklORUQpIHsKKwkJCXIgPSBhbWRncHVfc3luY19m
ZW5jZShzeW5jLCBmLCBmYWxzZSk7CisJCQlpZiAocikKKwkJCQlicmVhazsKKwkJfQorCiAJCS8q
IFdlIG9ubHkgd2FudCB0byB0cmlnZ2VyIEtGRCBldmljdGlvbiBmZW5jZXMgb24KIAkJICogZXZp
Y3Qgb3IgbW92ZSBqb2JzLiBTa2lwIEtGRCBmZW5jZXMgb3RoZXJ3aXNlLgogCQkgKi8KLQkJZmVu
Y2Vfb3duZXIgPSBhbWRncHVfc3luY19nZXRfb3duZXIoZik7CiAJCWlmIChmZW5jZV9vd25lciA9
PSBBTURHUFVfRkVOQ0VfT1dORVJfS0ZEICYmCiAJCSAgICBvd25lciAhPSBBTURHUFVfRkVOQ0Vf
T1dORVJfVU5ERUZJTkVEKQogCQkJY29udGludWU7CkBAIC0yNjUsOSArMjc0LDcgQEAgaW50IGFt
ZGdwdV9zeW5jX3Jlc3Yoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVf
c3luYyAqc3luYywKIAkJCWJyZWFrOwogCiAJCWNhc2UgQU1ER1BVX1NZTkNfRVhQTElDSVQ6Ci0J
CQlpZiAob3duZXIgIT0gQU1ER1BVX0ZFTkNFX09XTkVSX1VOREVGSU5FRCkKLQkJCQljb250aW51
ZTsKLQkJCWJyZWFrOworCQkJY29udGludWU7CiAJCX0KIAogCQlyID0gYW1kZ3B1X3N5bmNfZmVu
Y2Uoc3luYywgZiwgZmFsc2UpOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
