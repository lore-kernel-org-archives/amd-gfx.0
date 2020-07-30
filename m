Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E280C433E8
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1300207F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AptljyaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1300207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B14936E969;
	Thu, 30 Jul 2020 20:04:40 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA30B6E967
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 20:04:39 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id b2so2546088qvp.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 13:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kSStyutehnqUQ2sIZs9Twn8pg84JuS0jQapEhv+WM+w=;
 b=AptljyaQ4nexCNGtzYmWxBSNsPoi9w3w6omZpOnXnJsOeQ0sYf9pQAFESdw3olj6dD
 cuxJSEuJ4WX0L9/5r8tiSvt507S5dilQYEUBoO9uhgtfmh6ScN4obMpFs/H1tXf/S7vs
 hx+fQjtngIzrs9Te3pbRYSRlmrtpvPaPgTiEpmLivIEiopvPeTsOQw0C0yf6Q07G1osG
 I2EJJmBBXSzeMcDwekzHatWkBg0P5zZe2ywWwm2N6pO3SXqbxc9VnbWgN1ZmwM9+NfaL
 Vvlo11PNRbj/WPmFvbs5v/+HoO/7OHpMgUK+BC2mQsBpHAR0F42Su6G4LE5vZw6SHH5B
 4xSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kSStyutehnqUQ2sIZs9Twn8pg84JuS0jQapEhv+WM+w=;
 b=pPW/l7RCVB0H8r95EhxF0GJnpoVkxjyYdb8LMiqRpondncV/VN+EvUM2+0pjduZjjq
 BU63HcmKXuju7PD6WZtWwTykrGVozDnWZNSRzh1+Rs30b0LCWz5M8v2ULua7sYwB+4fV
 +LiKTd349FAZ9YQVbrxA3aIvg3udymr8jQmu0QVnaydDfCjMRO+Ea0dNBKwm46oxAJvy
 YHsUHr6Q77p1LxyKzeUBVCSix5CkSiWPtd6cQFVKa7rb2vdnCxamShhloB8NwkWIQE+S
 rZK5FsdQhUj6TU8aZMli3s6mhOJa/6Iljtjh0QHg5prqOYGnwHyziJgoRJXKcrDEf9Li
 gvuw==
X-Gm-Message-State: AOAM530NK+2r53+AAeofFmWWY4TTO6xW+6yXJtJq4NSk5qkavtf9rCyq
 5B9wBv7z/6AP6rk+SXmU/nmKIdeJ
X-Google-Smtp-Source: ABdhPJwKkHt6dJ5nsoTBT+QYw8T0IjKJJyOFffMECiY+xpkJpJHF9hbYwK/6mk0dv1gS/amEajzc0Q==
X-Received: by 2002:ad4:4d83:: with SMTP id cv3mr816802qvb.236.1596139475832; 
 Thu, 30 Jul 2020 13:04:35 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id d8sm5652757qtr.12.2020.07.30.13.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 13:04:34 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/17] drm/amdgpu/gmc10: switch to using
 amdgpu_gmc_get_vbios_allocations
Date: Thu, 30 Jul 2020 16:04:09 -0400
Message-Id: <20200730200414.40485-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200730200414.40485-1-alexander.deucher@amd.com>
References: <20200730200414.40485-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIG5ldyBoZWxwZXIgY2VudHJhbGl6ZXMgdGhlIGxvZ2ljIGluIG9uZSBwbGFjZS4KClJldmll
d2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClJldmll
d2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KU2lnbmVkLW9m
Zi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIHwgNTcgKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAzMiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCmluZGV4IDMzN2Q3MDUwMzk3
MC4uZmNkZTMwMmQzZWIwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjEwXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwpA
QCAtNTUzLDYgKzU1MywyOCBAQCBzdGF0aWMgdm9pZCBnbWNfdjEwXzBfZ2V0X3ZtX3B0ZShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAl9CiB9CiAKK3N0YXRpYyB1bnNpZ25lZCBnbWNfdjEw
XzBfZ2V0X3ZiaW9zX2ZiX3NpemUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCit7CisJdTMy
IGQxdmdhX2NvbnRyb2wgPSBSUkVHMzJfU09DMTUoRENFLCAwLCBtbUQxVkdBX0NPTlRST0wpOwor
CXVuc2lnbmVkIHNpemU7CisKKwlpZiAoUkVHX0dFVF9GSUVMRChkMXZnYV9jb250cm9sLCBEMVZH
QV9DT05UUk9MLCBEMVZHQV9NT0RFX0VOQUJMRSkpIHsKKwkJc2l6ZSA9IEFNREdQVV9WQklPU19W
R0FfQUxMT0NBVElPTjsKKwl9IGVsc2UgeworCQl1MzIgdmlld3BvcnQ7CisJCXUzMiBwaXRjaDsK
KworCQl2aWV3cG9ydCA9IFJSRUczMl9TT0MxNShEQ0UsIDAsIG1tSFVCUDBfRENTVVJGX1BSSV9W
SUVXUE9SVF9ESU1FTlNJT04pOworCQlwaXRjaCA9IFJSRUczMl9TT0MxNShEQ0UsIDAsIG1tSFVC
UFJFUTBfRENTVVJGX1NVUkZBQ0VfUElUQ0gpOworCQlzaXplID0gKFJFR19HRVRfRklFTEQodmll
d3BvcnQsCisJCQkJCUhVQlAwX0RDU1VSRl9QUklfVklFV1BPUlRfRElNRU5TSU9OLCBQUklfVklF
V1BPUlRfSEVJR0hUKSAqCisJCQkJUkVHX0dFVF9GSUVMRChwaXRjaCwgSFVCUFJFUTBfRENTVVJG
X1NVUkZBQ0VfUElUQ0gsIFBJVENIKSAqCisJCQkJNCk7CisJfQorCisJcmV0dXJuIHNpemU7Cit9
CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2dtY19mdW5jcyBnbWNfdjEwXzBfZ21jX2Z1
bmNzID0gewogCS5mbHVzaF9ncHVfdGxiID0gZ21jX3YxMF8wX2ZsdXNoX2dwdV90bGIsCiAJLmZs
dXNoX2dwdV90bGJfcGFzaWQgPSBnbWNfdjEwXzBfZmx1c2hfZ3B1X3RsYl9wYXNpZCwKQEAgLTU2
MCw3ICs1ODIsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9nbWNfZnVuY3MgZ21jX3Yx
MF8wX2dtY19mdW5jcyA9IHsKIAkuZW1pdF9wYXNpZF9tYXBwaW5nID0gZ21jX3YxMF8wX2VtaXRf
cGFzaWRfbWFwcGluZywKIAkubWFwX210eXBlID0gZ21jX3YxMF8wX21hcF9tdHlwZSwKIAkuZ2V0
X3ZtX3BkZSA9IGdtY192MTBfMF9nZXRfdm1fcGRlLAotCS5nZXRfdm1fcHRlID0gZ21jX3YxMF8w
X2dldF92bV9wdGUKKwkuZ2V0X3ZtX3B0ZSA9IGdtY192MTBfMF9nZXRfdm1fcHRlLAorCS5nZXRf
dmJpb3NfZmJfc2l6ZSA9IGdtY192MTBfMF9nZXRfdmJpb3NfZmJfc2l6ZSwKIH07CiAKIHN0YXRp
YyB2b2lkIGdtY192MTBfMF9zZXRfZ21jX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQpAQCAtNzAxLDM2ICs3MjQsNiBAQCBzdGF0aWMgaW50IGdtY192MTBfMF9nYXJ0X2luaXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJcmV0dXJuIGFtZGdwdV9nYXJ0X3RhYmxlX3ZyYW1f
YWxsb2MoYWRldik7CiB9CiAKLXN0YXRpYyB1bnNpZ25lZCBnbWNfdjEwXzBfZ2V0X3ZiaW9zX2Zi
X3NpemUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCi17Ci0JdTMyIGQxdmdhX2NvbnRyb2wg
PSBSUkVHMzJfU09DMTUoRENFLCAwLCBtbUQxVkdBX0NPTlRST0wpOwotCXVuc2lnbmVkIHNpemU7
Ci0KLQlpZiAoUkVHX0dFVF9GSUVMRChkMXZnYV9jb250cm9sLCBEMVZHQV9DT05UUk9MLCBEMVZH
QV9NT0RFX0VOQUJMRSkpIHsKLQkJc2l6ZSA9IEFNREdQVV9WQklPU19WR0FfQUxMT0NBVElPTjsK
LQl9IGVsc2UgewotCQl1MzIgdmlld3BvcnQ7Ci0JCXUzMiBwaXRjaDsKLQotCQl2aWV3cG9ydCA9
IFJSRUczMl9TT0MxNShEQ0UsIDAsIG1tSFVCUDBfRENTVVJGX1BSSV9WSUVXUE9SVF9ESU1FTlNJ
T04pOwotCQlwaXRjaCA9IFJSRUczMl9TT0MxNShEQ0UsIDAsIG1tSFVCUFJFUTBfRENTVVJGX1NV
UkZBQ0VfUElUQ0gpOwotCQlzaXplID0gKFJFR19HRVRfRklFTEQodmlld3BvcnQsCi0JCQkJCUhV
QlAwX0RDU1VSRl9QUklfVklFV1BPUlRfRElNRU5TSU9OLCBQUklfVklFV1BPUlRfSEVJR0hUKSAq
Ci0JCQkJUkVHX0dFVF9GSUVMRChwaXRjaCwgSFVCUFJFUTBfRENTVVJGX1NVUkZBQ0VfUElUQ0gs
IFBJVENIKSAqCi0JCQkJNCk7Ci0JfQotCS8qIHJldHVybiAwIGlmIHRoZSBwcmUtT1MgYnVmZmVy
IHVzZXMgdXAgbW9zdCBvZiB2cmFtICovCi0JaWYgKChhZGV2LT5nbWMucmVhbF92cmFtX3NpemUg
LSBzaXplKSA8ICg4ICogMTAyNCAqIDEwMjQpKSB7Ci0JCURSTV9FUlJPUigiV2FybmluZzogcHJl
LU9TIGJ1ZmZlciB1c2VzIG1vc3Qgb2YgdnJhbSwgXAotCQkJCWJlIGF3YXJlIG9mIGdhcnQgdGFi
bGUgb3ZlcndyaXRlXG4iKTsKLQkJcmV0dXJuIDA7Ci0JfQotCi0JcmV0dXJuIHNpemU7Ci19Ci0K
LQotCiBzdGF0aWMgaW50IGdtY192MTBfMF9zd19pbml0KHZvaWQgKmhhbmRsZSkKIHsKIAlpbnQg
ciwgdnJhbV93aWR0aCA9IDAsIHZyYW1fdHlwZSA9IDAsIHZyYW1fdmVuZG9yID0gMDsKQEAgLTgx
Miw3ICs4MDUsNyBAQCBzdGF0aWMgaW50IGdtY192MTBfMF9zd19pbml0KHZvaWQgKmhhbmRsZSkK
IAlpZiAocikKIAkJcmV0dXJuIHI7CiAKLQlhZGV2LT5nbWMuc3RvbGVuX3ZnYV9zaXplID0gZ21j
X3YxMF8wX2dldF92Ymlvc19mYl9zaXplKGFkZXYpOworCWFtZGdwdV9nbWNfZ2V0X3ZiaW9zX2Fs
bG9jYXRpb25zKGFkZXYpOwogCiAJLyogTWVtb3J5IG1hbmFnZXIgKi8KIAlyID0gYW1kZ3B1X2Jv
X2luaXQoYWRldik7Ci0tIAoyLjI1LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
