Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8D4C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B0C217F4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAAFDAsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B0C217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8EB86E270;
	Mon,  2 Mar 2020 12:55:24 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B796E270
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 12:55:24 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id r17so12440896wrj.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2020 04:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y70ZWJg2MqIcap4IHImwxTsaUh3eQBnQEMR7Yl4Nubg=;
 b=mAAFDAspBkonoGoiuKWjxPj9ndYUct8l9C43k+eM/ev4HAFSkZA7GCHcCFM5DmeLRo
 Z5yilgAAHkWyudSVUtgRlSQJl3aehdPN/A/k/cNFEPbGIg5WchDqlT2PuII+eTDmM+90
 EtKRsl3u35GzuushcGPKSJGPKlG2skeqXfh2IvXmvpmaUIuD8nXaPJ57qstRmNKwYskA
 iqrdBG5o5pTlr1Ob7gqSYhIsSeXyDEEvIrmsKoWiWYm4o0KGny7nsYFDkXGRN/wf8QSR
 hH1VLljmFHrZeoPuLzQ2PQ++3jlxJwm2TG/VdzPzeHMzIbhtJTSkGTwzOGuu9AhwMXzB
 FIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y70ZWJg2MqIcap4IHImwxTsaUh3eQBnQEMR7Yl4Nubg=;
 b=Fpc5OhFYL5ggwLvNtadLIV04zyIOAKOFIjKUEr2VPJNnGBzw4mfAAGrAFUJW5YtJo4
 4MFihhRRb6JSmYZ2Sz4ebWeMQ5KIUIGxim2JdlZJmPy+cElTKWsUCo6rmMRYcAkDrc4+
 UrTUvxeJHQB0YUsm3Xrc9gPQPtuiqQ4qvK8NjE7GIGKz1RVTXZBTxJ9W9HE3ZCGcyNnB
 QHk5j10jcvyiK+s9S7mSvOs4EWEO5YSl61azp+a+N483cDebDrDYWt5PVBGKqMcoofiC
 woZFuJ6h/mbFPq6uHCR7bAahGZhq9CkblO1ev7g/sgUz2O5F/C847HC6URbbWMGZiaOO
 PaYA==
X-Gm-Message-State: APjAAAWrfd7rSoBtBT8RBWM6pxJg1G+hRJLa+3dR9SzQArXniNjepORy
 5phRmsMOuysc5HwjAqFNeXxb+6n++vc=
X-Google-Smtp-Source: APXvYqzT4a2C+IqoJFblPVBN9KDTJHGhiX1VExICeZSKcZPYJ0ZfREg37vCw0HDL5t1kFCwOUhocgA==
X-Received: by 2002:adf:fd4c:: with SMTP id h12mr22985427wrs.101.1583153722463; 
 Mon, 02 Mar 2020 04:55:22 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F21FC009E54A4A7C1B66128.dip0.t-ipconnect.de.
 [2003:c5:8f21:fc00:9e54:a4a7:c1b6:6128])
 by smtp.gmail.com with ESMTPSA id f17sm7492733wrm.3.2020.03.02.04.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:55:21 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/4] drm/scheduler: implement a function to modify sched
 list
Date: Mon,  2 Mar 2020 13:58:34 +0100
Message-Id: <20200302125836.56915-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200302125836.56915-1-nirmoy.das@amd.com>
References: <20200302125836.56915-1-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

aW1wbGVtZW50IGRybV9zY2hlZF9lbnRpdHlfbW9kaWZ5X3NjaGVkKCkgd2hpY2ggY2FuIG1vZGlm
eSBleGlzdGluZwpzY2hlZF9saXN0IHdpdGggYSBkaWZmZXJlbnQgb25lLiBUaGlzIGlzIGdvaW5n
IHRvIGJlIGhlbHBmdWwgd2hlbgp1c2Vyc3BhY2UgY2hhbmdlcyBwcmlvcml0eSBvZiBhIGN0eC9l
bnRpdHkgdGhlbiBkcml2ZXIgY2FuIHN3aXRjaCB0bwpjb3JyZXNwb25kaW5nIGh3IHNoY2VkIGxp
c3QgZm9yIHRoYXQgcHJpb3JpdHkKClNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5k
YXNAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5j
IHwgMTkgKysrKysrKysrKysrKysrKysrKwogaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oICAg
ICAgICAgICAgICB8ICA0ICsrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMgYi9k
cml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCmluZGV4IDYzYmNjZDIwMWI5
Ny4uYjk0MzEyMTU0ZTU2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX2VudGl0eS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5
LmMKQEAgLTgzLDYgKzgzLDI1IEBAIGludCBkcm1fc2NoZWRfZW50aXR5X2luaXQoc3RydWN0IGRy
bV9zY2hlZF9lbnRpdHkgKmVudGl0eSwKIH0KIEVYUE9SVF9TWU1CT0woZHJtX3NjaGVkX2VudGl0
eV9pbml0KTsKCisvKioKKyAqIGRybV9zY2hlZF9lbnRpdHlfbW9kaWZ5X3NjaGVkIC0gTW9kaWZ5
IHNjaGVkIG9mIGFuIGVudGl0eQorICoKKyAqIEBlbnRpdHk6IHNjaGVkdWxlciBlbnRpdHkgdG8g
aW5pdAorICogQHNjaGVkX2xpc3Q6IHRoZSBsaXN0IG9mIG5ldyBkcm0gc2NoZWRzIHdoaWNoIHdp
bGwgcmVwbGFjZQorICoJCWV4aXN0aW5nIGVudGl0eS0+c2NoZWRfbGlzdAorICogQG51bV9zY2hl
ZF9saXN0OiBudW1iZXIgb2YgZHJtIHNjaGVkIGluIHNjaGVkX2xpc3QKKyAqLwordm9pZCBkcm1f
c2NoZWRfZW50aXR5X21vZGlmeV9zY2hlZChzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5
LAorCQkJCSAgc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICoqc2NoZWRfbGlzdCwKKwkJCQkgIHVu
c2lnbmVkIGludCBudW1fc2NoZWRfbGlzdCkKK3sKKwlXQVJOX09OKCFudW1fc2NoZWRfbGlzdCB8
fCAhc2NoZWRfbGlzdCk7CisKKwllbnRpdHktPnNjaGVkX2xpc3QgPSBzY2hlZF9saXN0OworCWVu
dGl0eS0+bnVtX3NjaGVkX2xpc3QgPSBudW1fc2NoZWRfbGlzdDsKK30KK0VYUE9SVF9TWU1CT0wo
ZHJtX3NjaGVkX2VudGl0eV9tb2RpZnlfc2NoZWQpOworCiAvKioKICAqIGRybV9zY2hlZF9lbnRp
dHlfaXNfaWRsZSAtIENoZWNrIGlmIGVudGl0eSBpcyBpZGxlCiAgKgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oIGIvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oCmlu
ZGV4IDU4OWJlODUxZjhhMS4uZjcwYTg0YWFhZjdhIDEwMDY0NAotLS0gYS9pbmNsdWRlL2RybS9n
cHVfc2NoZWR1bGVyLmgKKysrIGIvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oCkBAIC0yOTcs
NiArMjk3LDEwIEBAIHZvaWQgZHJtX3NjaGVkX2Zpbmkoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVy
ICpzY2hlZCk7CiBpbnQgZHJtX3NjaGVkX2pvYl9pbml0KHN0cnVjdCBkcm1fc2NoZWRfam9iICpq
b2IsCiAJCSAgICAgICBzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5LAogCQkgICAgICAg
dm9pZCAqb3duZXIpOwordm9pZCBkcm1fc2NoZWRfZW50aXR5X21vZGlmeV9zY2hlZChzdHJ1Y3Qg
ZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5LAorCQkJCSAgc3RydWN0IGRybV9ncHVfc2NoZWR1bGVy
ICoqc2NoZWRfbGlzdCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25l
ZCBpbnQgbnVtX3NjaGVkX2xpc3QpOworCiB2b2lkIGRybV9zY2hlZF9qb2JfY2xlYW51cChzdHJ1
Y3QgZHJtX3NjaGVkX2pvYiAqam9iKTsKIHZvaWQgZHJtX3NjaGVkX3dha2V1cChzdHJ1Y3QgZHJt
X2dwdV9zY2hlZHVsZXIgKnNjaGVkKTsKIHZvaWQgZHJtX3NjaGVkX3N0b3Aoc3RydWN0IGRybV9n
cHVfc2NoZWR1bGVyICpzY2hlZCwgc3RydWN0IGRybV9zY2hlZF9qb2IgKmJhZCk7Ci0tCjIuMjUu
MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
