Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3108C8300B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5652225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wN846j+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5652225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A7996EA28;
	Mon, 16 Nov 2020 19:18:44 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B2EB6E061
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:42 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id 23so364169wmg.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eP0WyWZg5ruAlRDHyNqDbB7ackT3+aNOib1WfADr30A=;
 b=wN846j+j1t9h9fPa28Onu7GZYXmQoYRLOxLBMdsgxmd2qjwO/2SHbYJ4aaZPTOwNwI
 Ie150qvycEdxzYdE6ALo/tJp0eHb8s/iM39uIWYiZQDcB4VODCCA6qx2PL3x1IxOyEzm
 pL94h3zfHi2M8NAko8DKtXEINUpu2UL/DlQGS7Zk5gfFe80wLQ5orA+eTl3yaAh0r6VC
 KFIJU5Qe6Hc25f0CT+oHuz4AYsncg/BtVJ0gYQz16eTW0QE8347rmKKa7A+A6aAKLWLK
 g+FRI4hv2PhqAzly5Q9dVAuFaGxdjBHlsW1nFIlcbHXoOuBALWhGlG+j2fgjcbRPY70Y
 evIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eP0WyWZg5ruAlRDHyNqDbB7ackT3+aNOib1WfADr30A=;
 b=CBTD2eQ+fIhulDuA7N1xA4AqEHHeQxTyg9QI1Uk7uVDBxn5zP8mvzLWPE2cVZZU/ZR
 Xo7mqolJMpcaeI3/fELzJ3Xsrq5zy/TRwsKq4xYYVhD/5DAsTDrAFvgEtIsRBrwjmz1g
 VTD6CsFPX8AYAI+zslWacI8N1DXXp3hLaE5EGVEINkGvE8ReCCMy5Njv5L4V5cj6izU+
 DYBWPTN8rFnfuT7ufYr7HOL6IK05Kq/+A6Bw0VnopvDYS8QHjTFuflXCePqTsKzgv/N0
 B/9q2DgjCa6walKRk3Oi4ftw0yNGhd7Yt2p/S4QhOW7lwEfsUL3TiqmcA1d2a6OwsLrW
 ZX6A==
X-Gm-Message-State: AOAM532fMuk8hp+ZuTFpDJYCkcKuQbvElOhVS8V/YSjB1gIwzcqtcrlU
 +1+bl4PciirTtH+67awva4VaqQ==
X-Google-Smtp-Source: ABdhPJxnW5vVWKO5IKiS8AJDMKtmOdtkHQWn7yrRtegS0lejzK4gfrcvcn+KCja9gLQX70R+jn+t2w==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr24711wmb.54.1605548260732;
 Mon, 16 Nov 2020 09:37:40 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:40 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 26/43] drm/radeon/radeon_atombios: Move
 'radeon_add_atom_encoder()'s prototype to shared header
Date: Mon, 16 Nov 2020 17:36:43 +0000
Message-Id: <20201116173700.1830487-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:13 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9hdG9tYmlvc19lbmNvZGVycy5jOjI3MjE6MTogd2FybmluZzogbm8g
cHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhyYWRlb25fYWRkX2F0b21fZW5jb2RlcuKAmSBbLVdt
aXNzaW5nLXByb3RvdHlwZXNdCiAyNzIxIHwgcmFkZW9uX2FkZF9hdG9tX2VuY29kZXIoc3RydWN0
IGRybV9kZXZpY2UgKmRldiwKIHwgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KCkNjOiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51
eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNp
Z25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuYyB8IDQgLS0tLQogZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuaCB8IDQgKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX2F0b21iaW9zLmMKaW5kZXggY2M4MDY1MWIyNTc3My4uYmU5NmQ5YjY0ZTQzYiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdG9tYmlvcy5jCkBAIC0zNywxMCArMzcsNiBAQAog
I2luY2x1ZGUgInJhZGVvbl9hdG9tYmlvcy5oIgogI2luY2x1ZGUgInJhZGVvbl9sZWdhY3lfZW5j
b2RlcnMuaCIKIAotZXh0ZXJuIHZvaWQKLXJhZGVvbl9hZGRfYXRvbV9lbmNvZGVyKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYsIHVpbnQzMl90IGVuY29kZXJfZW51bSwKLQkJCXVpbnQzMl90IHN1cHBv
cnRlZF9kZXZpY2UsIHUxNiBjYXBzKTsKLQogdW5pb24gYXRvbV9zdXBwb3J0ZWRfZGV2aWNlcyB7
CiAJc3RydWN0IF9BVE9NX1NVUFBPUlRFRF9ERVZJQ0VTX0lORk8gaW5mbzsKIAlzdHJ1Y3QgX0FU
T01fU1VQUE9SVEVEX0RFVklDRVNfSU5GT18yIGluZm9fMjsKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2F0b21iaW9zLmggYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9hdG9tYmlvcy5oCmluZGV4IGI3Yzc2OTIwZmViN2QuLmE4OTVhNzAwMmMzZDMgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F0b21iaW9zLmgKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuaApAQCAtMjgsMTAgKzI4LDE0
IEBACiAjaWZuZGVmIF9fUkFERU9OX0FUT01CSU9TX0hfXwogI2RlZmluZSBfX1JBREVPTl9BVE9N
QklPU19IX18KIAorc3RydWN0IGRybV9kZXZpY2U7CiBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZTsK
IHN0cnVjdCByYWRlb25fZGV2aWNlOwogCiBib29sIHJhZGVvbl9hdG9tX2dldF90dl90aW1pbmdz
KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBpbnQgaW5kZXgsCiAJCQkJc3RydWN0IGRybV9k
aXNwbGF5X21vZGUgKm1vZGUpOwordm9pZCByYWRlb25fYWRkX2F0b21fZW5jb2RlcihzdHJ1Y3Qg
ZHJtX2RldmljZSAqZGV2LCB1aW50MzJfdCBlbmNvZGVyX2VudW0sCisJCQkgICAgIHVpbnQzMl90
IHN1cHBvcnRlZF9kZXZpY2UsIHUxNiBjYXBzKTsKKwogCiAjZW5kaWYgICAgICAgICAgICAgICAg
ICAgICAgICAgLyogX19SQURFT05fQVRPTUJJT1NfSF9fICovCi0tIAoyLjI1LjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
