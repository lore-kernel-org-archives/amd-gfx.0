Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48BEC352A3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 15:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8984720661
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 15:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1f4xIP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8984720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4825F6EC89;
	Mon, 10 Feb 2020 15:09:23 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815786EC7F;
 Mon, 10 Feb 2020 15:09:18 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id q9so686241wmj.5;
 Mon, 10 Feb 2020 07:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=AXhl8HDHNECGL5xTRUnDnzmGnXaWYgm+0fggmgjjh9E=;
 b=c1f4xIP8RV6XkDUX+LQhza4Vrk19DCwqTcbgMbYIxUaHKIMKoMLxLdJt9mlD6/amAD
 RIPkHe4eNgTkmSDC6gKyhIhSOoeiOw5AeolhPB7Kcwzwuys9SeSwh5r+Fxvb7mp9S9TV
 NgFFT+jwCtPH8v772ZgL86ofHqHTWAVmRqrAftz9l9r3fofY4k+C8vZ/DL487jT1daAF
 YUh/e3xyvL7DzqgBvHokfkrL2Si2PDHsZ8ze1oFKCHiEZ45DYJWVFvFQUZKTBDKdM6YO
 3zuWnwcwNJeftJS7St+8svVuivsZrnDn162ygP4LBSKB6USWDYdprOc/8sUxPy88j4iU
 phoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AXhl8HDHNECGL5xTRUnDnzmGnXaWYgm+0fggmgjjh9E=;
 b=gpm6daWhLTHNTpov4cKnML8WkBZFK4eH9w/er2FgU3cDFr54TzRe1oXdx03+8Tzwkn
 bP9VtVJyv89TU016Bx0vVbxrLNr+Q+6mAxwUKZ6NTHgXhSy4UX8zPUtU6PQ2bWKeFLDV
 ymPpafoqk1NesbhfHwPUIpjsZPx+R1OrnizJKCaueeacYzL5NNRv3XYP3wL+f6KPkX//
 RT3dbDRcp5NlKe3PPCEKs+D5P1HxSF1YCK+lZEpUYwuLa9CufuFqp66s7LIBwQDeF4TE
 y2SyZAQT0f9sZSan/9Wa1UtXbufeW9sXhtp2lXc+Uq5mZF3igXz9LLKqHJmE//Fve0vU
 eoJw==
X-Gm-Message-State: APjAAAVg2CNMWv2nz8zgdNbffhKDzlMXUw05Sdyc3MIVbzynBl4ZUnEi
 8lkHbs3agiQTVbPG2eSK6Fw=
X-Google-Smtp-Source: APXvYqysQDFNO/JPZ4WEQIZFD/tUJpDop3AFwNdbz90Z6zlWjvHSbIjpfpiQiQrSO2yagBIymMfdXA==
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr15695278wmm.152.1581347357251; 
 Mon, 10 Feb 2020 07:09:17 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:7d3b:a71c:475c:1e99])
 by smtp.gmail.com with ESMTPSA id q10sm1021996wme.16.2020.02.10.07.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 07:09:16 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 5/6] drm/ttm: replace dma_resv object on deleted BOs v2
Date: Mon, 10 Feb 2020 16:09:06 +0100
Message-Id: <20200210150907.20616-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210150907.20616-1-christian.koenig@amd.com>
References: <20200210150907.20616-1-christian.koenig@amd.com>
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

V2hlbiBub24taW1wb3J0ZWQgQk9zIGFyZSByZXN1cnJlY3RlZCBmb3IgZGVsYXllZCBkZWxldGUg
d2UgcmVwbGFjZQp0aGUgZG1hX3Jlc3Ygb2JqZWN0IHRvIGFsbG93IGZvciBlYXN5IHJlY2xhaW1p
bmcgb2YgdGhlIHJlc291cmNlcy4KCnYyOiBtb3ZlIHRoYXQgdG8gdHRtX2JvX2luZGl2aWR1YWxp
emVfcmVzdgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgfCAxMCArKysrKysr
KystCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyBiL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX2JvLmMKaW5kZXggZDA2MjQ2ODVmNWQyLi40ZDE2MTAzOGRlOTggMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90
dG1fYm8uYwpAQCAtMzkzLDYgKzM5MywxNCBAQCBzdGF0aWMgaW50IHR0bV9ib19pbmRpdmlkdWFs
aXplX3Jlc3Yoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibykKIAogCXIgPSBkbWFfcmVzdl9j
b3B5X2ZlbmNlcygmYm8tPmJhc2UuX3Jlc3YsIGJvLT5iYXNlLnJlc3YpOwogCWRtYV9yZXN2X3Vu
bG9jaygmYm8tPmJhc2UuX3Jlc3YpOworCWlmIChyKQorCQlyZXR1cm4gcjsKKworCWlmIChiby0+
dHlwZSAhPSB0dG1fYm9fdHlwZV9zZykgeworCQlzcGluX2xvY2soJnR0bV9ib19nbG9iLmxydV9s
b2NrKTsKKwkJYm8tPmJhc2UucmVzdiA9ICZiby0+YmFzZS5fcmVzdjsKKwkJc3Bpbl91bmxvY2so
JnR0bV9ib19nbG9iLmxydV9sb2NrKTsKKwl9CiAKIAlyZXR1cm4gcjsKIH0KQEAgLTcyMCw3ICs3
MjgsNyBAQCBzdGF0aWMgYm9vbCB0dG1fYm9fZXZpY3Rfc3dhcG91dF9hbGxvd2FibGUoc3RydWN0
IHR0bV9idWZmZXJfb2JqZWN0ICpibywKIAogCWlmIChiby0+YmFzZS5yZXN2ID09IGN0eC0+cmVz
dikgewogCQlkbWFfcmVzdl9hc3NlcnRfaGVsZChiby0+YmFzZS5yZXN2KTsKLQkJaWYgKGN0eC0+
ZmxhZ3MgJiBUVE1fT1BUX0ZMQUdfQUxMT1dfUkVTX0VWSUNUIHx8IGJvLT5kZWxldGVkKQorCQlp
ZiAoY3R4LT5mbGFncyAmIFRUTV9PUFRfRkxBR19BTExPV19SRVNfRVZJQ1QpCiAJCQlyZXQgPSB0
cnVlOwogCQkqbG9ja2VkID0gZmFsc2U7CiAJCWlmIChidXN5KQotLSAKMi4xNy4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
