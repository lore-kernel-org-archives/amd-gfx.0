Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1352C56201
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7362320665
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iM7SQKT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7362320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3443389C82;
	Tue, 10 Nov 2020 19:35:46 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE11889BFE
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:32 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id b6so2666228wrt.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ya0KOHBj5YEQtB7YNRLKjFwwnQlrRlrUyTmR5vFE0Ms=;
 b=iM7SQKT+43Kp8b2PREMcIXXq6cm29sGsG50wr3Rsh3aEH7Av9D+TiUBErtQWNcLtXu
 KWhzdxVXzoDCE642pA6rkWKWOcuUB830UwNmIg5rI7bKtD0mRnFHwRZ7AYtu+ctpym6k
 Tv4e4S2Y9b82lfK4juqKqwKn6ajT1oJ7QO9ZuT+GEKDlGc7d7bNzT68wq/W+PlmFdEbR
 2b6Yc1zmKfBSPLgkTMmSM5aamjvOh0AJ0bHPv6XqHaIY0V8EgpCpLUb5UZUY4Bft1GhC
 ydBGXYmD6ryT8HLVarK9aWMLDjremqLMcAuMrtFWZ4saFKoTrAKLg3FgYe17JBQ/UHAr
 3Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ya0KOHBj5YEQtB7YNRLKjFwwnQlrRlrUyTmR5vFE0Ms=;
 b=VkPiCl/ErkNg13oqyRwiLGmpHufFOfdEsuv8K9uVr2/ZwgbtcA0QZeYpusaElxjOyD
 OhwqwZmLPqWuIHs+AwguIkstZz3j8V7uNdJtqJzyuiYknxULTPjnn1rkXJ6K/W0KY6ke
 ev+69G4Som6xfRuaoR0KPvymamyi6sANQecO8fAejYHyeHlbmvorZvVPYF4MQJanomYX
 bHGHzIlGwaZ1OzUGifXQ8DAPAYmRHfNxJl127cl0PiWJx7aAXreLLGBPFN69PbT/XDzj
 wxNpSqqdwmK7lB2p5riCUnWssFYeQF5oIfArTojhiZXYmr+0pcqp9dxgbDyd+MzTDEsp
 ojCQ==
X-Gm-Message-State: AOAM532EooWpTbqnp+8wqhYxTGUhHn0ea/EPmascjx3X+tFmEu5pw4oq
 5g5AtpG/XZhPNTZwPMcxrI+vJ16dOzb2HLbM
X-Google-Smtp-Source: ABdhPJzP382XBH1NlAJ6O36K2rNNiQPeQjUJa8rCP8i63Tc/A5HrIVfu8F0b1lnD1ViMjslg5lYE7w==
X-Received: by 2002:adf:f644:: with SMTP id x4mr26076211wrp.5.1605036691550;
 Tue, 10 Nov 2020 11:31:31 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:30 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 12/30] drm/radeon/radeon_dp_mst: Remove unused variable 'ret'
 from radeon_mst_encoder_dpms()
Date: Tue, 10 Nov 2020 19:30:54 +0000
Message-Id: <20201110193112.988999-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2020 19:35:44 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHBfbXN0LmM6IEluIGZ1bmN0aW9uIOKAmHJhZGVvbl9t
c3RfZW5jb2Rlcl9kcG1z4oCZOgogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHBfbXN0
LmM6MzY2OjY6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmHJldOKAmSBzZXQgYnV0IG5vdCB1c2VkIFst
V3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZl
dHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Q2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9kcF9tc3QuYyB8IDE2ICsrKysrKysrLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25fZHBfbXN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9k
cF9tc3QuYwppbmRleCAwMDgzMDg3ODA0NDNjLi4yYzMyMTg2YzRhY2Q5IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcF9tc3QuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9kcF9tc3QuYwpAQCAtMzYzLDcgKzM2Myw3IEBAIHJhZGVvbl9tc3Rf
ZW5jb2Rlcl9kcG1zKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlciwgaW50IG1vZGUpCiAJc3Ry
dWN0IHJhZGVvbl9jb25uZWN0b3IgKnJhZGVvbl9jb25uZWN0b3I7CiAJc3RydWN0IGRybV9jcnRj
ICpjcnRjOwogCXN0cnVjdCByYWRlb25fY3J0YyAqcmFkZW9uX2NydGM7Ci0JaW50IHJldCwgc2xv
dHM7CisJaW50IHNsb3RzOwogCXM2NCBmaXhlZF9wYm4sIGZpeGVkX3Bibl9wZXJfc2xvdCwgYXZn
X3RpbWVfc2xvdHNfcGVyX210cDsKIAlpZiAoIUFTSUNfSVNfRENFNShyZGV2KSkgewogCQlEUk1f
RVJST1IoImdvdCBtc3QgZHBtcyBvbiBub24tRENFNVxuIik7CkBAIC00MTgsMTAgKzQxOCwxMCBA
QCByYWRlb25fbXN0X2VuY29kZXJfZHBtcyhzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIsIGlu
dCBtb2RlKQogCiAJCXNsb3RzID0gZHJtX2RwX2ZpbmRfdmNwaV9zbG90cygmcmFkZW9uX2Nvbm5l
Y3Rvci0+bXN0X3BvcnQtPm1zdF9tZ3IsCiAJCQkJCSAgICAgICBtc3RfZW5jLT5wYm4pOwotCQly
ZXQgPSBkcm1fZHBfbXN0X2FsbG9jYXRlX3ZjcGkoJnJhZGVvbl9jb25uZWN0b3ItPm1zdF9wb3J0
LT5tc3RfbWdyLAotCQkJCQkgICAgICAgcmFkZW9uX2Nvbm5lY3Rvci0+cG9ydCwKLQkJCQkJICAg
ICAgIG1zdF9lbmMtPnBibiwgc2xvdHMpOwotCQlyZXQgPSBkcm1fZHBfdXBkYXRlX3BheWxvYWRf
cGFydDEoJnJhZGVvbl9jb25uZWN0b3ItPm1zdF9wb3J0LT5tc3RfbWdyKTsKKwkJZHJtX2RwX21z
dF9hbGxvY2F0ZV92Y3BpKCZyYWRlb25fY29ubmVjdG9yLT5tc3RfcG9ydC0+bXN0X21nciwKKwkJ
CQkJIHJhZGVvbl9jb25uZWN0b3ItPnBvcnQsCisJCQkJCSBtc3RfZW5jLT5wYm4sIHNsb3RzKTsK
KwkJZHJtX2RwX3VwZGF0ZV9wYXlsb2FkX3BhcnQxKCZyYWRlb25fY29ubmVjdG9yLT5tc3RfcG9y
dC0+bXN0X21ncik7CiAKIAkJcmFkZW9uX2RwX21zdF9zZXRfYmVfY250bChwcmltYXJ5LCBtc3Rf
ZW5jLAogCQkJCQkgIHJhZGVvbl9jb25uZWN0b3ItPm1zdF9wb3J0LT5ocGQuaHBkLCB0cnVlKTsK
QEAgLTQzNiw5ICs0MzYsOSBAQCByYWRlb25fbXN0X2VuY29kZXJfZHBtcyhzdHJ1Y3QgZHJtX2Vu
Y29kZXIgKmVuY29kZXIsIGludCBtb2RlKQogCiAJCWF0b21iaW9zX2RpZ19lbmNvZGVyX3NldHVw
MigmcHJpbWFyeS0+YmFzZSwgQVRPTV9FTkNPREVSX0NNRF9EUF9WSURFT19PTiwgMCwKIAkJCQkJ
ICAgIG1zdF9lbmMtPmZlKTsKLQkJcmV0ID0gZHJtX2RwX2NoZWNrX2FjdF9zdGF0dXMoJnJhZGVv
bl9jb25uZWN0b3ItPm1zdF9wb3J0LT5tc3RfbWdyKTsKKwkJZHJtX2RwX2NoZWNrX2FjdF9zdGF0
dXMoJnJhZGVvbl9jb25uZWN0b3ItPm1zdF9wb3J0LT5tc3RfbWdyKTsKIAotCQlyZXQgPSBkcm1f
ZHBfdXBkYXRlX3BheWxvYWRfcGFydDIoJnJhZGVvbl9jb25uZWN0b3ItPm1zdF9wb3J0LT5tc3Rf
bWdyKTsKKwkJZHJtX2RwX3VwZGF0ZV9wYXlsb2FkX3BhcnQyKCZyYWRlb25fY29ubmVjdG9yLT5t
c3RfcG9ydC0+bXN0X21ncik7CiAKIAkJYnJlYWs7CiAJY2FzZSBEUk1fTU9ERV9EUE1TX1NUQU5E
Qlk6CkBAIC00NTAsNyArNDUwLDcgQEAgcmFkZW9uX21zdF9lbmNvZGVyX2RwbXMoc3RydWN0IGRy
bV9lbmNvZGVyICplbmNvZGVyLCBpbnQgbW9kZSkKIAkJCXJldHVybjsKIAogCQlkcm1fZHBfbXN0
X3Jlc2V0X3ZjcGlfc2xvdHMoJnJhZGVvbl9jb25uZWN0b3ItPm1zdF9wb3J0LT5tc3RfbWdyLCBt
c3RfZW5jLT5wb3J0KTsKLQkJcmV0ID0gZHJtX2RwX3VwZGF0ZV9wYXlsb2FkX3BhcnQxKCZyYWRl
b25fY29ubmVjdG9yLT5tc3RfcG9ydC0+bXN0X21ncik7CisJCWRybV9kcF91cGRhdGVfcGF5bG9h
ZF9wYXJ0MSgmcmFkZW9uX2Nvbm5lY3Rvci0+bXN0X3BvcnQtPm1zdF9tZ3IpOwogCiAJCWRybV9k
cF9jaGVja19hY3Rfc3RhdHVzKCZyYWRlb25fY29ubmVjdG9yLT5tc3RfcG9ydC0+bXN0X21ncik7
CiAJCS8qIGFuZCB0aGlzIGNhbiBhbHNvIGZhaWwgKi8KLS0gCjIuMjUuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
