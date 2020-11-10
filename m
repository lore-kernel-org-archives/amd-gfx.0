Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93CCC388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4639820665
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s94k4AAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4639820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0FA689C9B;
	Tue, 10 Nov 2020 19:35:52 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB91489C33
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:52 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id o15so6165929wru.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ty8003+O/JEDF7pP5AXz413pW2AvyhRU/ye41tnDsWk=;
 b=s94k4AARJMH88KYy14FAytQBhgRQtu3mTNFlcsB9Kqq5TY/VRHY5hI6N3PgVumpWdO
 im8vg1vZ+ZGC4yz6nlyQVcIYavBOHzzaQ65IxiTxlo/sCRUAeiG0edibCz2eH2Sw5kcl
 +bTTJZsFaKgNRG8vnbHC3bbw1UkR9F5edeItMAxcHDr+m1Ztq6tSrnR38WlZWCfzw3j5
 NUnTWNVeu2Y3zuFuQthNbDIC9JSOTFNtR2T/9D3K5HYaluTauVShQqzHnTC5+zf/pinF
 U3rUsgYEZRkTe4oHAdvU4xBCIHJTQITkiYwAbNvLwNkPoFU+2A5y8hDQDVcOCTBVEcWf
 fHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ty8003+O/JEDF7pP5AXz413pW2AvyhRU/ye41tnDsWk=;
 b=XGsre/IHOLYmTzqpAe/PIWBKXjYJqvjMH32mu5U5OUgYfy9g8KCLHW5/nmEoIBCP0C
 0A7pAA3bwW/MZb47PRcKNwYKdEzzYwRSiyJ8/f9Hu3uDM716c4CMenTkKCA0hvQxQ9z3
 wO8HV/JQUwXc/IA7BjIuHQis8+ZNQFzLMxzjwzCsIwVEUgdEX8XlL85gj4DznHvZrKa/
 wkcfdH86Sbvs671OE6nLv7s+VptORPWw7WXLD2QuCyTrlFBMo1MA1QLZeTFKvTl/m5YQ
 FQ8cFFPYRrYVae6ZsWotQak9YHe5wT+bAxeZ/Va2krg26uY+2+7OCbMfIMhdWRIUOAIZ
 AaEg==
X-Gm-Message-State: AOAM533lC5TNbwEATa+oUND+X87PvIwi4/NdT8qaAF8ry3XpBs4qk3kX
 Ro7gy3kPR/60+DDdH5IhIXc6Uw==
X-Google-Smtp-Source: ABdhPJwXZzmApbHRmw9IH4dWPxdKtvDjoHbg5PwPKccSXvb0iKSosbsELwUyTm0FQ32kXfNagjWGxw==
X-Received: by 2002:a5d:62c3:: with SMTP id o3mr13434790wrv.300.1605036711258; 
 Tue, 10 Nov 2020 11:31:51 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:50 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 28/30] drm/radeon/evergreen: Move 'cayman_*()'s prototypes to
 shared header
Date: Tue, 10 Nov 2020 19:31:10 +0000
Message-Id: <20201110193112.988999-29-lee.jones@linaro.org>
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
cy9ncHUvZHJtL3JhZGVvbi9uaS5jOjEzNzg6Njogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90
eXBlIGZvciDigJhjYXltYW5fY3BfaW50X2NudGxfc2V0dXDigJkgWy1XbWlzc2luZy1wcm90b3R5
cGVzXQogMTM3OCB8IHZvaWQgY2F5bWFuX2NwX2ludF9jbnRsX3NldHVwKHN0cnVjdCByYWRlb25f
ZGV2aWNlICpyZGV2LAogfCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KIGRyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vbmkuYzoxNzMyOjU6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig
4oCYY2F5bWFuX2dwdV9jaGVja19zb2Z0X3Jlc2V04oCZIFstV21pc3NpbmctcHJvdG90eXBlc10K
IDE3MzIgfCB1MzIgY2F5bWFuX2dwdV9jaGVja19zb2Z0X3Jlc2V0KHN0cnVjdCByYWRlb25fZGV2
aWNlICpyZGV2KQogfCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KCkNjOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5p
ZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25l
ZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9ldmVyZ3JlZW4uYyB8ICA1ICstLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL25pLmMgICAgICAgIHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9uaS5oICAgICAg
ICB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAz
OCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvZ3B1L2RybS9yYWRlb24vbmkuaAoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vZXZlcmdyZWVuLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVlbi5jCmluZGV4
IGVmYjE5YzQ0NWU0OGYuLjI4ODMwZjRlZjk1ZTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vZXZlcmdyZWVuLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9ldmVyZ3Jl
ZW4uYwpAQCAtMzEsNiArMzEsNyBAQAogCiAjaW5jbHVkZSAiYXRvbS5oIgogI2luY2x1ZGUgImF2
aXZvZC5oIgorI2luY2x1ZGUgIm5pLmgiCiAjaW5jbHVkZSAicnY3NzAuaCIKICNpbmNsdWRlICJl
dmVyZ3JlZW4uaCIKICNpbmNsdWRlICJldmVyZ3JlZW5fYmxpdF9zaGFkZXJzLmgiCkBAIC0yMTUs
MTAgKzIxNiw2IEBAIHN0YXRpYyB2b2lkIGV2ZXJncmVlbl9ncHVfaW5pdChzdHJ1Y3QgcmFkZW9u
X2RldmljZSAqcmRldik7CiB2b2lkIGV2ZXJncmVlbl9maW5pKHN0cnVjdCByYWRlb25fZGV2aWNl
ICpyZGV2KTsKIHZvaWQgZXZlcmdyZWVuX3BjaWVfZ2VuMl9lbmFibGUoc3RydWN0IHJhZGVvbl9k
ZXZpY2UgKnJkZXYpOwogdm9pZCBldmVyZ3JlZW5fcHJvZ3JhbV9hc3BtKHN0cnVjdCByYWRlb25f
ZGV2aWNlICpyZGV2KTsKLWV4dGVybiB2b2lkIGNheW1hbl9jcF9pbnRfY250bF9zZXR1cChzdHJ1
Y3QgcmFkZW9uX2RldmljZSAqcmRldiwKLQkJCQkgICAgIGludCByaW5nLCB1MzIgY3BfaW50X2Nu
dGwpOwotZXh0ZXJuIHZvaWQgY2F5bWFuX3ZtX2RlY29kZV9mYXVsdChzdHJ1Y3QgcmFkZW9uX2Rl
dmljZSAqcmRldiwKLQkJCQkgICB1MzIgc3RhdHVzLCB1MzIgYWRkcik7CiB2b2lkIGNpa19pbml0
X2NwX3BnX3RhYmxlKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKIAogZXh0ZXJuIHUzMiBz
aV9nZXRfY3NiX3NpemUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9uaS5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9uaS5j
CmluZGV4IDFjOTAzMGE0NjMxYjguLmFiN2JkMzA4MDIxNzYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vbmkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pLmMKQEAg
LTMzLDYgKzMzLDcgQEAKICNpbmNsdWRlICJjYXltYW5fYmxpdF9zaGFkZXJzLmgiCiAjaW5jbHVk
ZSAiY2xlYXJzdGF0ZV9jYXltYW4uaCIKICNpbmNsdWRlICJldmVyZ3JlZW4uaCIKKyNpbmNsdWRl
ICJuaS5oIgogI2luY2x1ZGUgIm5pX3JlZy5oIgogI2luY2x1ZGUgIm5pZC5oIgogI2luY2x1ZGUg
InJhZGVvbi5oIgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9uaS5oIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9uaS5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAw
MDAwMDAwMDAuLmJiMDNhYzcwMmIxY2MKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL25pLmgKQEAgLTAsMCArMSwzNiBAQAorLyogbmkuaCAtLSBQcml2YXRlIGhlYWRl
ciBmb3IgcmFkZW9uIGRyaXZlciAtKi0gbGludXgtYyAtKi0KKyAqCisgKiBDb3B5cmlnaHQgMTk5
OSBQcmVjaXNpb24gSW5zaWdodCwgSW5jLiwgQ2VkYXIgUGFyaywgVGV4YXMuCisgKiBDb3B5cmln
aHQgMjAwMCBWQSBMaW51eCBTeXN0ZW1zLCBJbmMuLCBGcmVtb250LCBDYWxpZm9ybmlhLgorICog
QWxsIHJpZ2h0cyByZXNlcnZlZC4KKyAqCisgKiBQZXJtaXNzaW9uIGlzIGhlcmVieSBncmFudGVk
LCBmcmVlIG9mIGNoYXJnZSwgdG8gYW55IHBlcnNvbiBvYnRhaW5pbmcgYQorICogY29weSBvZiB0
aGlzIHNvZnR3YXJlIGFuZCBhc3NvY2lhdGVkIGRvY3VtZW50YXRpb24gZmlsZXMgKHRoZSAiU29m
dHdhcmUiKSwKKyAqIHRvIGRlYWwgaW4gdGhlIFNvZnR3YXJlIHdpdGhvdXQgcmVzdHJpY3Rpb24s
IGluY2x1ZGluZyB3aXRob3V0IGxpbWl0YXRpb24KKyAqIHRoZSByaWdodHMgdG8gdXNlLCBjb3B5
LCBtb2RpZnksIG1lcmdlLCBwdWJsaXNoLCBkaXN0cmlidXRlLCBzdWJsaWNlbnNlLAorICogYW5k
L29yIHNlbGwgY29waWVzIG9mIHRoZSBTb2Z0d2FyZSwgYW5kIHRvIHBlcm1pdCBwZXJzb25zIHRv
IHdob20gdGhlCisgKiBTb2Z0d2FyZSBpcyBmdXJuaXNoZWQgdG8gZG8gc28sIHN1YmplY3QgdG8g
dGhlIGZvbGxvd2luZyBjb25kaXRpb25zOgorICoKKyAqIFRoZSBhYm92ZSBjb3B5cmlnaHQgbm90
aWNlIGFuZCB0aGlzIHBlcm1pc3Npb24gbm90aWNlIChpbmNsdWRpbmcgdGhlIG5leHQKKyAqIHBh
cmFncmFwaCkgc2hhbGwgYmUgaW5jbHVkZWQgaW4gYWxsIGNvcGllcyBvciBzdWJzdGFudGlhbCBw
b3J0aW9ucyBvZiB0aGUKKyAqIFNvZnR3YXJlLgorICoKKyAqIFRIRSBTT0ZUV0FSRSBJUyBQUk9W
SURFRCAiQVMgSVMiLCBXSVRIT1VUIFdBUlJBTlRZIE9GIEFOWSBLSU5ELCBFWFBSRVNTIE9SCisg
KiBJTVBMSUVELCBJTkNMVURJTkcgQlVUIE5PVCBMSU1JVEVEIFRPIFRIRSBXQVJSQU5USUVTIE9G
IE1FUkNIQU5UQUJJTElUWSwKKyAqIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFIEFO
RCBOT05JTkZSSU5HRU1FTlQuICBJTiBOTyBFVkVOVCBTSEFMTAorICogUFJFQ0lTSU9OIElOU0lH
SFQgQU5EL09SIElUUyBTVVBQTElFUlMgQkUgTElBQkxFIEZPUiBBTlkgQ0xBSU0sIERBTUFHRVMg
T1IKKyAqIE9USEVSIExJQUJJTElUWSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09OVFJBQ1Qs
IFRPUlQgT1IgT1RIRVJXSVNFLAorICogQVJJU0lORyBGUk9NLCBPVVQgT0YgT1IgSU4gQ09OTkVD
VElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBUSEUgVVNFIE9SIE9USEVSCisgKiBERUFMSU5HUyBJ
TiBUSEUgU09GVFdBUkUuCisgKgorICovCisKKyNpZm5kZWYgX19OSV9IX18KKyNkZWZpbmUgX19O
SV9IX18KKwordm9pZCBjYXltYW5fY3BfaW50X2NudGxfc2V0dXAoc3RydWN0IHJhZGVvbl9kZXZp
Y2UgKnJkZXYsCisJCQkgICAgICBpbnQgcmluZywgdTMyIGNwX2ludF9jbnRsKTsKK3ZvaWQgY2F5
bWFuX3ZtX2RlY29kZV9mYXVsdChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwKKwkJCSAgICB1
MzIgc3RhdHVzLCB1MzIgYWRkcik7CisKKyNlbmRpZgkJCQkvKiBfX05JX0hfXyAqLwotLSAKMi4y
NS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
