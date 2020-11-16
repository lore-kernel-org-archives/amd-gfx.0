Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85299C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FDA2225E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rp3u8Jwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FDA2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A795E6EA2F;
	Mon, 16 Nov 2020 19:18:18 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66BE56E02A
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:06 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id r17so19661192wrw.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xb5oU/OD2Y3rEdVts+1SNNg+EwKMwAAR+VS8s4ifyQw=;
 b=Rp3u8JwosxZh0tOeegPBxxchLmVOYDwvYReTo37Z7mS8aEPbmb6WEaUD6M5dTaExSd
 xzcQJ4Sq1/oi3Lxxv8GqyecBWbauJ2CVW/X7CT+hhZiz9m4wmSUKFokcNvpH6fJEkPzB
 QOz8TiyiEQpjN7gUlhkDZH8soePq9CURV8V1prdX9MPZFc777IyoWRW42CCdNhNBO5Y3
 npVM63rsAmWkWqXDUYLzA/Vrq40jzzHFZ9tshka692aiawIxhXa8tYxkiqEvRKizwNkR
 uX6ikzRdIoBV7hQ+3w+iZ+3uF5yMJ2D8HpTAjwF4jqxFOuvg550DFPYirq6Vp15qcLdY
 +Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xb5oU/OD2Y3rEdVts+1SNNg+EwKMwAAR+VS8s4ifyQw=;
 b=jXHEY3ao51rjO2Kmdm97RPjOFe1VKDwPpAbNFENc0GLOUN7BlybAuNtg3wInshMDr1
 mrkby8N7db+7h81pPFbKtTekIWHdvrcpQf0SqumGQ5BSKM6p1ijHHX52s7mR3BZct7SQ
 mbddh0ChT+r3zGrqd9gIyB7B9C77EvaZH4+ooX37bmAXNRO/p0mBzK6ASCQKsp2TDBUS
 NufRLerCiYfRVFRkYCz+AD/dw/FHOCcOkx676iriOHD8hpo5FGGWP45SQH/K767n7GFo
 yLnEEmtj4lnY8pDYB9tVabVVS4WiM89FOwNYkr0O/T0RxvL/AaBm/01cIh1nNLl4XrF8
 iU5Q==
X-Gm-Message-State: AOAM530CaTtHsuum5SNLgUrx+IUQl7UrSJP4MxXoGrANXjdgxdw+ec3W
 JrnFI87NXi5zW2f6gAzworIspw==
X-Google-Smtp-Source: ABdhPJzTxMswOuqD1i5BcnjwTcSwtXU8jI63VS4MryPWVcjhcFg8WGldPf7OlqGXYfb2bWITm00heQ==
X-Received: by 2002:a5d:654b:: with SMTP id z11mr19684774wrv.291.1605548225053; 
 Mon, 16 Nov 2020 09:37:05 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:04 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 01/43] drm/radeon/atombios_encoders: Move
 'radeon_atom_get_tv_timings()'s prototype into shared location
Date: Mon, 16 Nov 2020 17:36:18 +0000
Message-Id: <20201116173700.1830487-2-lee.jones@linaro.org>
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuYzoxNzkxOjY6IHdhcm5pbmc6IG5vIHBy
ZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX2F0b21fZ2V0X3R2X3RpbWluZ3PigJkgWy1X
bWlzc2luZy1wcm90b3R5cGVzXQogMTc5MSB8IGJvb2wgcmFkZW9uX2F0b21fZ2V0X3R2X3RpbWlu
Z3Moc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsIGludCBpbmRleCwKIHwgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4KCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6
IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmll
bEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpv
bmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9hdG9tYmlvc19lbmNv
ZGVycy5jIHwgIDUgKy0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdG9tYmlvcy5j
ICAgfCAgMSArCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdG9tYmlvcy5oICAgfCAz
NyArKysrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25fYXRvbWJpb3MuaAoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vYXRvbWJpb3NfZW5jb2RlcnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vYXRvbWJpb3Nf
ZW5jb2RlcnMuYwppbmRleCBjYzVlZTFiM2FmODRmLi42ODNkZTE5OGUxOGQ5IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2F0b21iaW9zX2VuY29kZXJzLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9hdG9tYmlvc19lbmNvZGVycy5jCkBAIC0zMyw2ICszMyw3IEBACiAj
aW5jbHVkZSA8ZHJtL3JhZGVvbl9kcm0uaD4KIAogI2luY2x1ZGUgImF0b20uaCIKKyNpbmNsdWRl
ICJyYWRlb25fYXRvbWJpb3MuaCIKICNpbmNsdWRlICJyYWRlb24uaCIKICNpbmNsdWRlICJyYWRl
b25fYXNpYy5oIgogI2luY2x1ZGUgInJhZGVvbl9hdWRpby5oIgpAQCAtMjk2LDEwICsyOTcsNiBA
QCBzdGF0aWMgdm9pZCByYWRlb25fYXRvbV9iYWNrbGlnaHRfZXhpdChzdHJ1Y3QgcmFkZW9uX2Vu
Y29kZXIgKmVuY29kZXIpCiAKICNlbmRpZgogCi0vKiBldmlsIGJ1dCBpbmNsdWRpbmcgYXRvbWJp
b3MuaCBpcyBtdWNoIHdvcnNlICovCi1ib29sIHJhZGVvbl9hdG9tX2dldF90dl90aW1pbmdzKHN0
cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBpbnQgaW5kZXgsCi0JCQkJc3RydWN0IGRybV9kaXNw
bGF5X21vZGUgKm1vZGUpOwotCiBzdGF0aWMgYm9vbCByYWRlb25fYXRvbV9tb2RlX2ZpeHVwKHN0
cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlciwKIAkJCQkgICBjb25zdCBzdHJ1Y3QgZHJtX2Rpc3Bs
YXlfbW9kZSAqbW9kZSwKIAkJCQkgICBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqYWRqdXN0ZWRf
bW9kZSkKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2F0b21iaW9z
LmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hdG9tYmlvcy5jCmluZGV4IDVkMjU5
MTcyNTE4OTIuLjcxYmYyZWQxNzI2OTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX2F0b21iaW9zLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25f
YXRvbWJpb3MuYwpAQCAtMzQsNiArMzQsNyBAQAogI2luY2x1ZGUgImF0b20uaCIKICNpbmNsdWRl
ICJhdG9tLWJpdHMuaCIKICNpbmNsdWRlICJyYWRlb25fYXNpYy5oIgorI2luY2x1ZGUgInJhZGVv
bl9hdG9tYmlvcy5oIgogCiBleHRlcm4gdm9pZAogcmFkZW9uX2FkZF9hdG9tX2VuY29kZXIoc3Ry
dWN0IGRybV9kZXZpY2UgKmRldiwgdWludDMyX3QgZW5jb2Rlcl9lbnVtLApkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXRvbWJpb3MuaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX2F0b21iaW9zLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMDAwMDAwMC4uYjdjNzY5MjBmZWI3ZAotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX2F0b21iaW9zLmgKQEAgLTAsMCArMSwzNyBAQAorLyogcmFkZW9u
X2F0b21iaW9zLmggLS0gUHJpdmF0ZSBoZWFkZXIgZm9yIHJhZGVvbiBkcml2ZXIgLSotIGxpbnV4
LWMgLSotCisgKgorICogQ29weXJpZ2h0IDIwMDctOCBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJ
bmMuCisgKiBDb3B5cmlnaHQgMjAwOCBSZWQgSGF0IEluYy4KKyAqCisgKiBQZXJtaXNzaW9uIGlz
IGhlcmVieSBncmFudGVkLCBmcmVlIG9mIGNoYXJnZSwgdG8gYW55IHBlcnNvbiBvYnRhaW5pbmcg
YQorICogY29weSBvZiB0aGlzIHNvZnR3YXJlIGFuZCBhc3NvY2lhdGVkIGRvY3VtZW50YXRpb24g
ZmlsZXMgKHRoZSAiU29mdHdhcmUiKSwKKyAqIHRvIGRlYWwgaW4gdGhlIFNvZnR3YXJlIHdpdGhv
dXQgcmVzdHJpY3Rpb24sIGluY2x1ZGluZyB3aXRob3V0IGxpbWl0YXRpb24KKyAqIHRoZSByaWdo
dHMgdG8gdXNlLCBjb3B5LCBtb2RpZnksIG1lcmdlLCBwdWJsaXNoLCBkaXN0cmlidXRlLCBzdWJs
aWNlbnNlLAorICogYW5kL29yIHNlbGwgY29waWVzIG9mIHRoZSBTb2Z0d2FyZSwgYW5kIHRvIHBl
cm1pdCBwZXJzb25zIHRvIHdob20gdGhlCisgKiBTb2Z0d2FyZSBpcyBmdXJuaXNoZWQgdG8gZG8g
c28sIHN1YmplY3QgdG8gdGhlIGZvbGxvd2luZyBjb25kaXRpb25zOgorICoKKyAqIFRoZSBhYm92
ZSBjb3B5cmlnaHQgbm90aWNlIGFuZCB0aGlzIHBlcm1pc3Npb24gbm90aWNlIHNoYWxsIGJlIGlu
Y2x1ZGVkIGluCisgKiBhbGwgY29waWVzIG9yIHN1YnN0YW50aWFsIHBvcnRpb25zIG9mIHRoZSBT
b2Z0d2FyZS4KKyAqCisgKiBUSEUgU09GVFdBUkUgSVMgUFJPVklERUQgIkFTIElTIiwgV0lUSE9V
VCBXQVJSQU5UWSBPRiBBTlkgS0lORCwgRVhQUkVTUyBPUgorICogSU1QTElFRCwgSU5DTFVESU5H
IEJVVCBOT1QgTElNSVRFRCBUTyBUSEUgV0FSUkFOVElFUyBPRiBNRVJDSEFOVEFCSUxJVFksCisg
KiBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBBTkQgTk9OSU5GUklOR0VNRU5ULiAg
SU4gTk8gRVZFTlQgU0hBTEwKKyAqIFRIRSBDT1BZUklHSFQgSE9MREVSKFMpIE9SIEFVVEhPUihT
KSBCRSBMSUFCTEUgRk9SIEFOWSBDTEFJTSwgREFNQUdFUyBPUgorICogT1RIRVIgTElBQklMSVRZ
LCBXSEVUSEVSIElOIEFOIEFDVElPTiBPRiBDT05UUkFDVCwgVE9SVCBPUiBPVEhFUldJU0UsCisg
KiBBUklTSU5HIEZST00sIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhFIFNPRlRXQVJF
IE9SIFRIRSBVU0UgT1IKKyAqIE9USEVSIERFQUxJTkdTIElOIFRIRSBTT0ZUV0FSRS4KKyAqCisg
KiBBdXRob3JzOiBEYXZlIEFpcmxpZQorICogICAgICAgICAgQWxleCBEZXVjaGVyCisgKi8KKwor
I2lmbmRlZiBfX1JBREVPTl9BVE9NQklPU19IX18KKyNkZWZpbmUgX19SQURFT05fQVRPTUJJT1Nf
SF9fCisKK3N0cnVjdCBkcm1fZGlzcGxheV9tb2RlOworc3RydWN0IHJhZGVvbl9kZXZpY2U7CisK
K2Jvb2wgcmFkZW9uX2F0b21fZ2V0X3R2X3RpbWluZ3Moc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJk
ZXYsIGludCBpbmRleCwKKwkJCQlzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqbW9kZSk7CisKKyNl
bmRpZiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBfX1JBREVPTl9BVE9NQklPU19IX18gKi8K
LS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
