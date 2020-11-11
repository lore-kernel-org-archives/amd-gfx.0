Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9506EC5517A
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B70F20659
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 18:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ASHzCi9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B70F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1F36E0E7;
	Wed, 11 Nov 2020 18:45:24 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A17196E0C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 18:36:07 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id 23so3492515wrc.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 10:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k31TtB+plPHQj7iD5gVHpYef9lXJ4rGnOi0xYl4wuaA=;
 b=ASHzCi9BO6TBGcwRlccGp9W06y8j0wVJwMq49gkz7BHMXS3KXpXkm539aLEiIiT5eV
 3J60SRWROZJ0FT+DPZIgUGeuLIlBzbJ3JgOp3RVGEh3UCM0qSMagRKSiVQlwBRX4N89t
 vB0Ree3UHKnBben9i1q5CR6vQJvd5aYZC1Vbwd6mmNVPgH8nDExSxRuJVBh14GdCW7Yq
 0GuSXBlbu27+niVCWH4gNpovPCq/hwYLR9m9chbHVsUkz/4Wbwssr2FrsBf08bVFdWsM
 NDCSx0uK9ZHg22H6DCkX1XPyX5gUn8DwZt3ayQdLgTk51um7Nb4u1XDE8gltx6Udm44E
 0e2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k31TtB+plPHQj7iD5gVHpYef9lXJ4rGnOi0xYl4wuaA=;
 b=Z587NBym/nqDml3jP73+1hlnMDXcDOWQqp2QqlggMqhyYF6nWNWde+9LWOQ7+O16DD
 3VNE/AJbL36S0hMfJz3EkEIkWwNPwOrukP4mUMPGyG5O9EsQ0aiLg3MPIbZ0WukQlbms
 i00YtvqbOr6A5gX/jFg3nmuuA92AWTKah8zZomkuipfu6P6+h748QWbrt0Osu4btZLtA
 yXYVsszPfYxsFaMCa1XC/S5RQh7cfDVnOtNkzrdWqeJnoBJfxI3mqjdVjdWsYSV/+MVd
 6eamFUSEVSJTL52BaEzLbtpZmv8Tr+Gbi7wIOM2zw4mkLrlP7gh6NHWxoQG8rbpHUbWi
 II5g==
X-Gm-Message-State: AOAM531Q445n4Cl/QWhQOW4XQY6Ia2gU8mfUbEthpnMWqgJAiXY4vHqt
 ePI5I9vEgQTUbYFb5I/w2q3+4g==
X-Google-Smtp-Source: ABdhPJx4N4V4sx7dAlzbxicFql018cJoVgNWMEO73mIRphND5KBdblN4KdUoquQN5qPSW4ezp+XgIg==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr26422272wrw.123.1605119766309; 
 Wed, 11 Nov 2020 10:36:06 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 10:36:05 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 12/19] drm/radeon/evergreen: Move 'si_get_csb_*()'s prototypes
 to shared header
Date: Wed, 11 Nov 2020 18:35:38 +0000
Message-Id: <20201111183545.1756994-13-lee.jones@linaro.org>
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
cy9ncHUvZHJtL3JhZGVvbi9zaS5jOjU2Nzg6NTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90
eXBlIGZvciDigJhzaV9nZXRfY3NiX3NpemXigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogNTY3
OCB8IHUzMiBzaV9nZXRfY3NiX3NpemUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCiB8IF5+
fn5+fn5+fn5+fn5+fgogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaS5jOjU3MTA6Njogd2Fybmlu
Zzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhzaV9nZXRfY3NiX2J1ZmZlcuKAmSBbLVdt
aXNzaW5nLXByb3RvdHlwZXNdCiA1NzEwIHwgdm9pZCBzaV9nZXRfY3NiX2J1ZmZlcihzdHJ1Y3Qg
cmFkZW9uX2RldmljZSAqcmRldiwgdm9sYXRpbGUgdTMyICpidWZmZXIpCiB8IF5+fn5+fn5+fn5+
fn5+fn5+CgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzog
IkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBB
aXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwu
Y2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdyZWVuLmMgfCAzICstLQog
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaS5oICAgICAgICB8IDIgKysKIDIgZmlsZXMgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vZXZlcmdyZWVuLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2V2ZXJn
cmVlbi5jCmluZGV4IDI4ODMwZjRlZjk1ZTMuLmQ4ZWU4MGFkNGVhNDQgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdyZWVuLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9ldmVyZ3JlZW4uYwpAQCAtNDEsNiArNDEsNyBAQAogI2luY2x1ZGUgInJhZGVvbl9hc2lj
LmgiCiAjaW5jbHVkZSAicmFkZW9uX2F1ZGlvLmgiCiAjaW5jbHVkZSAicmFkZW9uX3Vjb2RlLmgi
CisjaW5jbHVkZSAic2kuaCIKIAogI2RlZmluZSBEQ19IUER4X0NPTlRST0woeCkgICAgICAgIChE
Q19IUEQxX0NPTlRST0wgICAgICsgKHggKiAweGMpKQogI2RlZmluZSBEQ19IUER4X0lOVF9DT05U
Uk9MKHgpICAgIChEQ19IUEQxX0lOVF9DT05UUk9MICsgKHggKiAweGMpKQpAQCAtMjE4LDggKzIx
OSw2IEBAIHZvaWQgZXZlcmdyZWVuX3BjaWVfZ2VuMl9lbmFibGUoc3RydWN0IHJhZGVvbl9kZXZp
Y2UgKnJkZXYpOwogdm9pZCBldmVyZ3JlZW5fcHJvZ3JhbV9hc3BtKHN0cnVjdCByYWRlb25fZGV2
aWNlICpyZGV2KTsKIHZvaWQgY2lrX2luaXRfY3BfcGdfdGFibGUoc3RydWN0IHJhZGVvbl9kZXZp
Y2UgKnJkZXYpOwogCi1leHRlcm4gdTMyIHNpX2dldF9jc2Jfc2l6ZShzdHJ1Y3QgcmFkZW9uX2Rl
dmljZSAqcmRldik7Ci1leHRlcm4gdm9pZCBzaV9nZXRfY3NiX2J1ZmZlcihzdHJ1Y3QgcmFkZW9u
X2RldmljZSAqcmRldiwgdm9sYXRpbGUgdTMyICpidWZmZXIpOwogZXh0ZXJuIHUzMiBjaWtfZ2V0
X2NzYl9zaXplKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKIGV4dGVybiB2b2lkIGNpa19n
ZXRfY3NiX2J1ZmZlcihzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwgdm9sYXRpbGUgdTMyICpi
dWZmZXIpOwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpLmggYi9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3NpLmgKaW5kZXggZjQ4M2E2NGQxNzA1MC4uMzEwYzU4Mzc2Zjky
NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaS5oCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vc2kuaApAQCAtMzIsNSArMzIsNyBAQCB1MzIgc2lfZ3B1X2NoZWNrX3Nv
ZnRfcmVzZXQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwogdm9pZCBzaV92cmFtX2d0dF9s
b2NhdGlvbihzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwgc3RydWN0IHJhZGVvbl9tYyAqbWMp
Owogdm9pZCBzaV9ybGNfcmVzZXQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwogdm9pZCBz
aV9pbml0X3V2ZF9pbnRlcm5hbF9jZyhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cit1MzIg
c2lfZ2V0X2NzYl9zaXplKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKK3ZvaWQgc2lfZ2V0
X2NzYl9idWZmZXIoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsIHZvbGF0aWxlIHUzMiAqYnVm
ZmVyKTsKIAogI2VuZGlmICAgICAgICAgICAgICAgICAgICAgICAgIC8qIF9fU0lfSF9fICovCi0t
IAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
