Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5288C636CA
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 17:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C19A61029
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 17:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C19A61029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C58F6EB81;
	Wed, 21 Jul 2021 17:56:01 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FA926EB70
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 17:55:59 +0000 (UTC)
Received: by mail-qt1-x82e.google.com with SMTP id k3so2462023qtq.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poorly.run; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j8lKVNX9q4Fo4fg0uvmmZGsmdf0+oqb3sZHxk/xw0uk=;
 b=Ff+jBl+uPoZFMSuLK+1AOCIUmwgotdH+8p83S+ozpaHMGmKL7LZQtjhyeAK13iIDoW
 P1JS+ndquq/AdsAQIopdOTmPgCqgfbL80sdb2H3GxZ2I70ZaxBvctBJ2VVAkNUBNxIbe
 aRNwNODXMoT42e8N7KnhxgqXJWXNmzFybwwGskRbQHEk0AuHmqB8D4iJgwaIFTout55w
 ZoPk21LzceQab73g8zs3D0+JgxCMLOJEENn+ImVz9XZdigfpJyqqN7x8usozlvU/2PMs
 OtCk/mB5k7RqcZBnszhBtACmYehtWTTUeKuhqE5Ac+D1JGXMc/Bffnaf7LZ2KVVA8kJw
 2t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j8lKVNX9q4Fo4fg0uvmmZGsmdf0+oqb3sZHxk/xw0uk=;
 b=KOo9KGML6NDoErIUew1sDLOOIrWSVdGjtir+OWxzevOAmpS1yzy2r7w4XMuvm89ZEW
 yw5ypVStJZgSuMjLssqIzRKkD5hEdabp7gkbUq/MS7hiAtPNcTE78Db5kqQ58GAJGVqn
 yTIPKV7ZLAMAXaWgf6CGUiLyYTfeunui/6c4oxmcHwJI5/TmnSoKe+vFKe2FcGZFZCki
 K2KYfb0Hb0lbFesF3xCNOx+Tq4D0twEyLszVAaqKzXwTrF4D92GqA78Oo853pn9DcAt8
 uNw8l0davE0iZA5IcR5TUxi8v7fRkVB5wkMZ9G4dcQsd/m0ZLvPwU0dsGTVf/2uBqsg1
 NyWg==
X-Gm-Message-State: AOAM531GPkYs1rFzmzKTfeO3ByAj3R3+zGdnhGQZ8/LbJ9gc4ego1ixU
 wYLKm6e2aHmhCCLgfbrB9NveHXFLZ6dVjg==
X-Google-Smtp-Source: ABdhPJzWWeUCNVLICcb1swh5GDA1HtVcMPEi7ynJIbXYHmkRp/9V9gt066XUcWRC6Gj1eXwZMIST/g==
X-Received: by 2002:ac8:5a12:: with SMTP id n18mr20684605qta.3.1626890158383; 
 Wed, 21 Jul 2021 10:55:58 -0700 (PDT)
Received: from localhost ([167.100.64.199])
 by smtp.gmail.com with ESMTPSA id d16sm9183548qtj.69.2021.07.21.10.55.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 21 Jul 2021 10:55:58 -0700 (PDT)
From: Sean Paul <sean@poorly.run>
To: dri-devel@lists.freedesktop.org, ppaalanen@gmail.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@linux.ie,
 daniel.vetter@ffwll.ch
Subject: [RESEND PATCH v6 06/14] drm/amd: Gate i2c transaction logs on
 drm_debug_syslog
Date: Wed, 21 Jul 2021 13:55:13 -0400
Message-Id: <20210721175526.22020-7-sean@poorly.run>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210721175526.22020-1-sean@poorly.run>
References: <20210721175526.22020-1-sean@poorly.run>
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
 Sean Paul <seanpaul@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogU2VhbiBQYXVsIDxzZWFucGF1bEBjaHJvbWl1bS5vcmc+CgpTaW5jZSB0aGUgbG9ncyBw
cm90ZWN0ZWQgYnkgdGhlc2UgY2hlY2tzIHNwZWNpZmljYWxseSB0YXJnZXQgc3lzbG9nLAp1c2Ug
dGhlIG5ldyBkcm1fZGVidWdfc3lzbG9nX2VuYWJsZWQoKSBjYWxsIHRvIGF2b2lkIHRyaWdnZXJp
bmcKdGhlc2UgcHJpbnRzIHdoZW4gb25seSB0cmFjZSBpcyBlbmFibGVkLgoKQWNrZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTog
U2VhbiBQYXVsIDxzZWFucGF1bEBjaHJvbWl1bS5vcmc+Ckxpbms6IGh0dHBzOi8vcGF0Y2h3b3Jr
LmZyZWVkZXNrdG9wLm9yZy9wYXRjaC9tc2dpZC8yMDIwMDYwODIxMDUwNS40ODUxOS03LXNlYW5A
cG9vcmx5LnJ1biAjdjUKCkNoYW5nZXMgaW4gdjU6Ci1BZGRlZCB0byB0aGUgc2V0CkNoYW5nZXMg
aW4gdjY6Ci1Ob25lCi0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc211X3YxMV8wX2ky
Yy5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NtdV92MTFfMF9p
MmMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NtdV92MTFfMF9pMmMuYwppbmRleCA1
YzdkNzY5YWVlM2YuLmQ5Y2VhYjMzMjA2MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc211X3YxMV8wX2kyYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NtdV92MTFfMF9pMmMuYwpAQCAtMjMzLDcgKzIzMyw3IEBAIHN0YXRpYyB1aW50MzJfdCBzbXVf
djExXzBfaTJjX3RyYW5zbWl0KHN0cnVjdCBpMmNfYWRhcHRlciAqY29udHJvbCwKIAlEUk1fREVC
VUdfRFJJVkVSKCJJMkNfVHJhbnNtaXQoKSwgYWRkcmVzcyA9ICV4LCBieXRlcyA9ICVkICwgZGF0
YTogIiwKIAkJICh1aW50MTZfdClhZGRyZXNzLCBudW1ieXRlcyk7CiAKLQlpZiAoZHJtX2RlYnVn
X2VuYWJsZWQoRFJNX1VUX0RSSVZFUikpIHsKKwlpZiAoZHJtX2RlYnVnX3N5c2xvZ19lbmFibGVk
KERSTV9VVF9EUklWRVIpKSB7CiAJCXByaW50X2hleF9kdW1wKEtFUk5fSU5GTywgImRhdGE6ICIs
IERVTVBfUFJFRklYX05PTkUsCiAJCQkgICAgICAgMTYsIDEsIGRhdGEsIG51bWJ5dGVzLCBmYWxz
ZSk7CiAJfQpAQCAtMzg5LDcgKzM4OSw3IEBAIHN0YXRpYyB1aW50MzJfdCBzbXVfdjExXzBfaTJj
X3JlY2VpdmUoc3RydWN0IGkyY19hZGFwdGVyICpjb250cm9sLAogCURSTV9ERUJVR19EUklWRVIo
IkkyQ19SZWNlaXZlKCksIGFkZHJlc3MgPSAleCwgYnl0ZXMgPSAlZCwgZGF0YSA6IiwKIAkJICAo
dWludDE2X3QpYWRkcmVzcywgYnl0ZXNfcmVjZWl2ZWQpOwogCi0JaWYgKGRybV9kZWJ1Z19lbmFi
bGVkKERSTV9VVF9EUklWRVIpKSB7CisJaWYgKGRybV9kZWJ1Z19zeXNsb2dfZW5hYmxlZChEUk1f
VVRfRFJJVkVSKSkgewogCQlwcmludF9oZXhfZHVtcChLRVJOX0lORk8sICJkYXRhOiAiLCBEVU1Q
X1BSRUZJWF9OT05FLAogCQkJICAgICAgIDE2LCAxLCBkYXRhLCBieXRlc19yZWNlaXZlZCwgZmFs
c2UpOwogCX0KLS0gClNlYW4gUGF1bCwgU29mdHdhcmUgRW5naW5lZXIsIEdvb2dsZSAvIENocm9t
aXVtIE9TCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
