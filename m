Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87938C56201
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13112206FB
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uWL7G87a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13112206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C506E0D2;
	Wed, 11 Nov 2020 18:45:16 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5976E0AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 18:35:55 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id j7so3526505wrp.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 10:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eP0WyWZg5ruAlRDHyNqDbB7ackT3+aNOib1WfADr30A=;
 b=uWL7G87ad8BBVCkHBLVEpHZDR8zZqKdyrnOOfcEpLPyUY3xT+ts4pkohRGIbD+xnu8
 /Iz+STdZtJMMEoeMJaIhC356yaZnl6WUZGi47iCmWDzKV0Mu+VkcfBm4HTxKQ+RO0KA/
 HdkdQwGyTAqbmjccN90fWErcuo6zeYrO+h6Da6EK+C9xPXHLyLa6YAqONl16i3IQEvcU
 +3siVCh0rpVbt1upZqzW+MliM3OXB0129YlDV3PAHMl9JKSAwWTt9rrH9aI+w81zgyCA
 ulk7nZN40BMCJdrrUgJPMrIoFuerGLtgVecgPs39c3C4GsMjHzKzET9sK6WY6ikVhKpN
 dn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eP0WyWZg5ruAlRDHyNqDbB7ackT3+aNOib1WfADr30A=;
 b=t1AiB0HhS4MNexyjkUXLEHkSkTLHwk2+DkVeI63OlBGlfnAhE0pJuFTFpr49JEOo5S
 Pt7C2hotM3FgT8mClRLfY6HcIvH2XNRNVhy48cZgsTBLbvH6wypjKB61Fi5EJ7O1teVi
 zlzVUGVGn+KHHzZqAw4WtyaLwHVJLQPXjfU8shQT7CytyMNu8rFuH1cnbRqyJecIkNii
 Ez8q5zoko+abMaEQRl1yJo2vj8gw7xwGmuwOskw2GbcIvsBIGNCi2rLPDcPWADTSSjHV
 S1dtq5ZIIwuTXKoWVVwbQClb11dN20m8XisIVI9jSikLEv4roTck7/VeYN4aW5pjuvIE
 9CLw==
X-Gm-Message-State: AOAM530bllYtuDklr64aYyw+o5MNj4mJP8yxR+Uahq63LdXyRjSBVfCg
 OmoLobf1fnnoMNWP3AfU2gPE+w==
X-Google-Smtp-Source: ABdhPJySQOMuzRn2OADac5SQlejJdpHY1681Ddh/ovuTq00XPGI73rfjk/KhDTqbXGIORvDN1CVW2Q==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr16771878wro.197.1605119753978; 
 Wed, 11 Nov 2020 10:35:53 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 10:35:53 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 04/19] drm/radeon/radeon_atombios: Move
 'radeon_add_atom_encoder()'s prototype to shared header
Date: Wed, 11 Nov 2020 18:35:30 +0000
Message-Id: <20201111183545.1756994-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201111183545.1756994-1-lee.jones@linaro.org>
References: <20201111183545.1756994-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 11 Nov 2020 18:45:15 +0000
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
