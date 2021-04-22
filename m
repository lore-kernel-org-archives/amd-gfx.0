Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DA5C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 11:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F8B61424
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 11:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F8B61424
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D106EA73;
	Thu, 22 Apr 2021 11:31:06 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D0F06EA73
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 11:31:05 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id r20so18487149ejo.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 04:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OnBSu0u6vbHKKnaZfsRAOCOiMcx8MWaWywVepR6r+Oc=;
 b=pf7kQppBUX0QMhoi86Mm24+jHMzAJl+GhOc1VnmlyfHSWxkWr0Zh3KOndzvPNM0SVO
 cA23FvkemsvuI9G4Yp9EGBWmPW8/UL5WlV0LEF1DFwCPKPPHiSBxe+GeVszm+dJwt4T8
 2IqmtbwrmgpArQNgHNjQcQlGf8fkO8yWp2Iv+gZDZPB5FaIOC1YIHUpxPR1BekRqUIAF
 0oeXDGpQJgkHvQWPpPW9WZ38OIILRM52/jyCM8e9WpvoS55U6J7l+tpgefLtguWAyj+s
 v0Dp8Vp+LQqSQbmMYl1JDURhGRrHUdmOldRMbR5ZJnCWEMTUnsSnlwaOuYiTpUxWxAON
 gNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OnBSu0u6vbHKKnaZfsRAOCOiMcx8MWaWywVepR6r+Oc=;
 b=S2/NQ1/mCZNsR6vhvJKWfjGdz4Jel4oBwIEUbiAN0hPmFDDY1xyv1g4OIygBMQddeQ
 tl1pK/wfcQjWA6h7h3DLapKcOKPRwvqrynxInmP38/MYkdkPCmkKVFKjuWtUWnMn4Tnh
 ZB051GVjy5sXldVzIopNvMasuPp/lCa+SJwzCZgUSuylnnRteKy23pzuBpSPyAOqk+/U
 ozC6H6W9X5dTTLmt/CwUvDdCOPoye6HBBWzHOd2HCEqAM5H1anIEijasktWvZbEb3vhA
 r5L5euBtUgkBaOxPJX7sHbZkjC1B58JOjF11neKDSLxShFUVNjhs7wCgiUPJyRc0k3B/
 uwMQ==
X-Gm-Message-State: AOAM533r9wy8JxsFXc4nsjRfcX9Jfj994yI/0GE1ErQnZXcM2TQBmWjM
 p/3Pv+97WW/iq/M8J6UUL7KSixZxbJw=
X-Google-Smtp-Source: ABdhPJyhWA6gd7yEBe+P/xzd5BpkNbaoxLANz0gvfgfEdqclO7KJT5rGmoYcq+285V8+LeKfNM1sxA==
X-Received: by 2002:a17:906:2746:: with SMTP id
 a6mr2863708ejd.265.1619091063822; 
 Thu, 22 Apr 2021 04:31:03 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:6035:34f9:3e8d:a180])
 by smtp.gmail.com with ESMTPSA id g22sm1685978ejz.46.2021.04.22.04.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 04:31:03 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	James.Zhu@amd.com
Subject: [PATCH] drm/amdgpu: fix concurrent VM flushes on Vega/Navi
Date: Thu, 22 Apr 2021 13:31:02 +0200
Message-Id: <20210422113102.3254-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

U3RhcnRpbmcgd2l0aCBWZWdhIHRoZSBoYXJkd2FyZSBzdXBwb3J0cyBjb25jdXJyZW50IGZsdXNo
ZXMKb2YgVk1JRCB3aGljaCBjYW4gYmUgdXNlZCB0byBpbXBsZW1lbnQgcGVyIHByb2Nlc3MgVk1J
RAphbGxvY2F0aW9uLgoKQnV0IGNvbmN1cnJlbnQgZmx1c2hlcyBhcmUgbXV0dWFsIGV4Y2x1c2l2
ZSB3aXRoIGJhY2sgdG8KYmFjayBWTUlEIGFsbG9jYXRpb25zLCBmaXggdGhpcyB0byBhdm9pZCBh
IFZNSUQgdXNlZCBpbgp0d28gd2F5cyBhdCB0aGUgc2FtZSB0aW1lLgoKU2lnbmVkLW9mZi1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYyB8IDE3ICsrKysrKysrKystLS0tLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyAgfCAgNiArKysrKysKIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oICB8ICAxICsKIDMgZmlsZXMgY2hhbmdl
ZCwgMTcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfaWRzLmMKaW5kZXggOTRiMDY5NjMwZGIzLi4wN2NmZjZmYzBjZGEgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmMKQEAgLTIxMiw2ICsyMTIsMTAgQEAg
c3RhdGljIGludCBhbWRncHVfdm1pZF9ncmFiX2lkbGUoc3RydWN0IGFtZGdwdV92bSAqdm0sCiAJ
aWYgKCFmZW5jZXMpCiAJCXJldHVybiAtRU5PTUVNOwogCisJLyogRG9uJ3QgdXNlIHBlciBlbmdp
bmUgYW5kIHBlciBwcm9jZXNzIFZNSUQgYXQgdGhlIHNhbWUgdGltZSAqLworCWlmIChhZGV2LT52
bV9tYW5hZ2VyLmNvbmN1cnJlbnRfZmx1c2gpCisJCXJpbmcgPSBOVUxMOworCiAJLyogQ2hlY2sg
aWYgd2UgaGF2ZSBhbiBpZGxlIFZNSUQgKi8KIAlpID0gMDsKIAlsaXN0X2Zvcl9lYWNoX2VudHJ5
KCgqaWRsZSksICZpZF9tZ3ItPmlkc19scnUsIGxpc3QpIHsKQEAgLTI4MSw3ICsyODUsNyBAQCBz
dGF0aWMgaW50IGFtZGdwdV92bWlkX2dyYWJfcmVzZXJ2ZWQoc3RydWN0IGFtZGdwdV92bSAqdm0s
CiAJaWYgKHVwZGF0ZXMgJiYgKCppZCktPmZsdXNoZWRfdXBkYXRlcyAmJgogCSAgICB1cGRhdGVz
LT5jb250ZXh0ID09ICgqaWQpLT5mbHVzaGVkX3VwZGF0ZXMtPmNvbnRleHQgJiYKIAkgICAgIWRt
YV9mZW5jZV9pc19sYXRlcih1cGRhdGVzLCAoKmlkKS0+Zmx1c2hlZF91cGRhdGVzKSkKLQkgICAg
dXBkYXRlcyA9IE5VTEw7CisJCXVwZGF0ZXMgPSBOVUxMOwogCiAJaWYgKCgqaWQpLT5vd25lciAh
PSB2bS0+aW1tZWRpYXRlLmZlbmNlX2NvbnRleHQgfHwKIAkgICAgam9iLT52bV9wZF9hZGRyICE9
ICgqaWQpLT5wZF9ncHVfYWRkciB8fApAQCAtMjkwLDYgKzI5NCwxMCBAQCBzdGF0aWMgaW50IGFt
ZGdwdV92bWlkX2dyYWJfcmVzZXJ2ZWQoc3RydWN0IGFtZGdwdV92bSAqdm0sCiAJICAgICAhZG1h
X2ZlbmNlX2lzX3NpZ25hbGVkKCgqaWQpLT5sYXN0X2ZsdXNoKSkpIHsKIAkJc3RydWN0IGRtYV9m
ZW5jZSAqdG1wOwogCisJCS8qIERvbid0IHVzZSBwZXIgZW5naW5lIGFuZCBwZXIgcHJvY2VzcyBW
TUlEIGF0IHRoZSBzYW1lIHRpbWUgKi8KKwkJaWYgKGFkZXYtPnZtX21hbmFnZXIuY29uY3VycmVu
dF9mbHVzaCkKKwkJCXJpbmcgPSBOVUxMOworCiAJCS8qIHRvIHByZXZlbnQgb25lIGNvbnRleHQg
c3RhcnZlZCBieSBhbm90aGVyIGNvbnRleHQgKi8KIAkJKCppZCktPnBkX2dwdV9hZGRyID0gMDsK
IAkJdG1wID0gYW1kZ3B1X3N5bmNfcGVla19mZW5jZSgmKCppZCktPmFjdGl2ZSwgcmluZyk7CkBA
IC0zNjUsMTIgKzM3Myw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtaWRfZ3JhYl91c2VkKHN0cnVj
dCBhbWRncHVfdm0gKnZtLAogCQlpZiAodXBkYXRlcyAmJiAoIWZsdXNoZWQgfHwgZG1hX2ZlbmNl
X2lzX2xhdGVyKHVwZGF0ZXMsIGZsdXNoZWQpKSkKIAkJCW5lZWRzX2ZsdXNoID0gdHJ1ZTsKIAot
CQkvKiBDb25jdXJyZW50IGZsdXNoZXMgYXJlIG9ubHkgcG9zc2libGUgc3RhcnRpbmcgd2l0aCBW
ZWdhMTAgYW5kCi0JCSAqIGFyZSBicm9rZW4gb24gTmF2aTEwIGFuZCBOYXZpMTQuCi0JCSAqLwot
CQlpZiAobmVlZHNfZmx1c2ggJiYgKGFkZXYtPmFzaWNfdHlwZSA8IENISVBfVkVHQTEwIHx8Ci0J
CQkJICAgIGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX05BVkkxMCB8fAotCQkJCSAgICBhZGV2LT5h
c2ljX3R5cGUgPT0gQ0hJUF9OQVZJMTQpKQorCQlpZiAobmVlZHNfZmx1c2ggJiYgIWFkZXYtPnZt
X21hbmFnZXIuY29uY3VycmVudF9mbHVzaCkKIAkJCWNvbnRpbnVlOwogCiAJCS8qIEdvb2QsIHdl
IGNhbiB1c2UgdGhpcyBWTUlELiBSZW1lbWJlciB0aGlzIHN1Ym1pc3Npb24gYXMKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKaW5kZXggZjk1YmNkYTg0NjNmLi5hZGM0NDgxYjA1
ZmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCkBAIC0zMTQ5LDYgKzMx
NDksMTIgQEAgdm9pZCBhbWRncHVfdm1fbWFuYWdlcl9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQogewogCXVuc2lnbmVkIGk7CiAKKwkvKiBDb25jdXJyZW50IGZsdXNoZXMgYXJlIG9u
bHkgcG9zc2libGUgc3RhcnRpbmcgd2l0aCBWZWdhMTAgYW5kCisJICogYXJlIGJyb2tlbiBvbiBO
YXZpMTAgYW5kIE5hdmkxNC4KKwkgKi8KKwlhZGV2LT52bV9tYW5hZ2VyLmNvbmN1cnJlbnRfZmx1
c2ggPSAhKGFkZXYtPmFzaWNfdHlwZSA8IENISVBfVkVHQTEwIHx8CisJCQkJCSAgICAgIGFkZXYt
PmFzaWNfdHlwZSA9PSBDSElQX05BVkkxMCB8fAorCQkJCQkgICAgICBhZGV2LT5hc2ljX3R5cGUg
PT0gQ0hJUF9OQVZJMTQpOwogCWFtZGdwdV92bWlkX21ncl9pbml0KGFkZXYpOwogCiAJYWRldi0+
dm1fbWFuYWdlci5mZW5jZV9jb250ZXh0ID0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmgKaW5kZXggODQ4ZTE3NWU5OWZmLi4xNjM3NjNmOGI0MTggMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5oCkBAIC0zMzEsNiArMzMxLDcgQEAgc3RydWN0IGFtZGdwdV92
bV9tYW5hZ2VyIHsKIAkvKiBIYW5kbGluZyBvZiBWTUlEcyAqLwogCXN0cnVjdCBhbWRncHVfdm1p
ZF9tZ3IJCQlpZF9tZ3JbQU1ER1BVX01BWF9WTUhVQlNdOwogCXVuc2lnbmVkIGludAkJCQlmaXJz
dF9rZmRfdm1pZDsKKwlib29sCQkJCQljb25jdXJyZW50X2ZsdXNoOwogCiAJLyogSGFuZGxpbmcg
b2YgVk0gZmVuY2VzICovCiAJdTY0CQkJCQlmZW5jZV9jb250ZXh0OwotLSAKMi4yNS4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
