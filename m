Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF67C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 13:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B4024654
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 13:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baE/w8SC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B4024654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1B76EBF0;
	Wed, 19 Feb 2020 13:50:50 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C989C6EBF3;
 Wed, 19 Feb 2020 13:50:47 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id k11so598166wrd.9;
 Wed, 19 Feb 2020 05:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mPvoLkggG7ZMHTLm9jQ6uQeOIROIduldbyLICT5Lh6A=;
 b=baE/w8SC2QPplRwge3PJiRxKCyLRR7lUcs0Dbyn8k1i480HY2u/84vDiM+pFDRdtzS
 vetvZ2g6ziMplcgvypsqUFuPyV6rhzXavIJKu/uMCAuLDSZznFwtGdgJjnXiHYFOp01u
 W0x/5DOw+SfpStTLLr80f8RaHUShTAyNl4xjrNwZ5MJ474sRm+yIFAqWX14FyHkN/uZx
 /UlKABMyy8DISoGmtg/UXw2X5gArgP32F3+6Mym6ef8CY3OJtAPfri9EY19SB04G3e4F
 esFbPtsAxNgAaSI3h0t9WYphri+IMH5hw8t7ogD0KYH78CZ1QjKUmsrszhAVgY7BR9qN
 Dn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mPvoLkggG7ZMHTLm9jQ6uQeOIROIduldbyLICT5Lh6A=;
 b=fBCu4nGRQAU589CzWMKBoEzuA97QpWW1EzgiJimTB2hSf8eZPxQJ+vEtDYzE1sivrV
 wPcPSXVzHSUkIrYMxloyQOmL/qrijxSlvN2fuxhBp6U+7qDSvAq6LaeNuMEBH23JMn0P
 ZmgoFqVSvUXk0jmObOgbyrOlucXu+98QDEvr3pk4PqDnU2TRqOE+nchYZ1lhnN5XM0ox
 /RL/PG+15vRZYnIu+2uXmEum0pSbv+85/rnj3+SxsjYB17BOZaDbQq51Lj2YGqTX3IJj
 /pUXtjbwgWN6FRE0640mfTbK1kE5KUi0BF76q0QV+RYVD+qDNcpGMZaP3FhzG7uRWHhj
 v88g==
X-Gm-Message-State: APjAAAWAqG2pyZSGAZg3cydIGSH2Qg9AA8slOZIqgBJl1vqxrQgQGtYT
 PTaC3TdQPHwnebMElllBYkpwLEDHsoT4WQ==
X-Google-Smtp-Source: APXvYqwrAGhSzOJyIe5pF0vfyO5QC8QqNP0MmkdZ7YBHqHzPtq7IK/QZ0T4UzbpNeH5MxAnQ20/AFA==
X-Received: by 2002:adf:82ce:: with SMTP id 72mr36053180wrc.14.1582120246087; 
 Wed, 19 Feb 2020 05:50:46 -0800 (PST)
Received: from brihaspati.fritz.box (p5DE53754.dip0.t-ipconnect.de.
 [93.229.55.84])
 by smtp.gmail.com with ESMTPSA id y1sm3061881wrq.16.2020.02.19.05.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 05:50:45 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 3/8] drm/vmwgfx: don't use ttm bo->offset
Date: Wed, 19 Feb 2020 14:53:17 +0100
Message-Id: <20200219135322.56463-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219135322.56463-1-nirmoy.das@amd.com>
References: <20200219135322.56463-1-nirmoy.das@amd.com>
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
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, airlied@linux.ie,
 kenny.ho@amd.com, brian.welty@intel.com, maarten.lankhorst@linux.intel.com,
 amd-gfx@lists.freedesktop.org, nirmoy.das@amd.com,
 linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, sean@poorly.run, christian.koenig@amd.com,
 kraxel@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Q2FsY3VsYXRlIEdQVSBvZmZzZXQgd2l0aGluIHZtd2dmeCBkcml2ZXIgaXRzZWxmIHdpdGhvdXQg
ZGVwZW5kaW5nIG9uCmJvLT5vZmZzZXQKClNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1v
eS5kYXNAYW1kLmNvbT4KQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9iby5jICAgICAg
ICAgfCA0ICsrLS0KIGRyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2V4ZWNidWYuYyAgICB8
IDIgKy0KIGRyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2ZpZm8uYyAgICAgICB8IDIgKy0K
IGRyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X3R0bV9idWZmZXIuYyB8IDIgLS0KIDQgZmls
ZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2JvLmMgYi9kcml2ZXJzL2dwdS9kcm0vdm13
Z2Z4L3Ztd2dmeF9iby5jCmluZGV4IDhiNzFiZjZiNThlZi4uMWU1OWMwMTlhZmZhIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9iby5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS92bXdnZngvdm13Z2Z4X2JvLmMKQEAgLTI1OCw3ICsyNTgsNyBAQCBpbnQgdm13X2JvX3Bp
bl9pbl9zdGFydF9vZl92cmFtKHN0cnVjdCB2bXdfcHJpdmF0ZSAqZGV2X3ByaXYsCiAJCXJldCA9
IHR0bV9ib192YWxpZGF0ZShibywgJnBsYWNlbWVudCwgJmN0eCk7CiAKIAkvKiBGb3Igc29tZSBy
ZWFzb24gd2UgZGlkbid0IGVuZCB1cCBhdCB0aGUgc3RhcnQgb2YgdnJhbSAqLwotCVdBUk5fT04o
cmV0ID09IDAgJiYgYm8tPm9mZnNldCAhPSAwKTsKKwlXQVJOX09OKHJldCA9PSAwICYmIGJvLT5t
ZW0uc3RhcnQgIT0gMCk7CiAJaWYgKCFyZXQpCiAJCXZtd19ib19waW5fcmVzZXJ2ZWQoYnVmLCB0
cnVlKTsKIApAQCAtMzE3LDcgKzMxNyw3IEBAIHZvaWQgdm13X2JvX2dldF9ndWVzdF9wdHIoY29u
c3Qgc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibywKIHsKIAlpZiAoYm8tPm1lbS5tZW1fdHlw
ZSA9PSBUVE1fUExfVlJBTSkgewogCQlwdHItPmdtcklkID0gU1ZHQV9HTVJfRlJBTUVCVUZGRVI7
Ci0JCXB0ci0+b2Zmc2V0ID0gYm8tPm9mZnNldDsKKwkJcHRyLT5vZmZzZXQgPSBiby0+bWVtLnN0
YXJ0IDw8IFBBR0VfU0hJRlQ7CiAJfSBlbHNlIHsKIAkJcHRyLT5nbXJJZCA9IGJvLT5tZW0uc3Rh
cnQ7CiAJCXB0ci0+b2Zmc2V0ID0gMDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS92bXdn
Zngvdm13Z2Z4X2V4ZWNidWYuYyBiL2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2V4ZWNi
dWYuYwppbmRleCA3MzQ4OWE0NWRlY2IuLjcyYzJjZjQwNTNkZiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfZXhlY2J1Zi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS92
bXdnZngvdm13Z2Z4X2V4ZWNidWYuYwpAQCAtMzMxMyw3ICszMzEzLDcgQEAgc3RhdGljIHZvaWQg
dm13X2FwcGx5X3JlbG9jYXRpb25zKHN0cnVjdCB2bXdfc3dfY29udGV4dCAqc3dfY29udGV4dCkK
IAkJYm8gPSAmcmVsb2MtPnZiby0+YmFzZTsKIAkJc3dpdGNoIChiby0+bWVtLm1lbV90eXBlKSB7
CiAJCWNhc2UgVFRNX1BMX1ZSQU06Ci0JCQlyZWxvYy0+bG9jYXRpb24tPm9mZnNldCArPSBiby0+
b2Zmc2V0OworCQkJcmVsb2MtPmxvY2F0aW9uLT5vZmZzZXQgKz0gYm8tPm1lbS5zdGFydCA8PCBQ
QUdFX1NISUZUOwogCQkJcmVsb2MtPmxvY2F0aW9uLT5nbXJJZCA9IFNWR0FfR01SX0ZSQU1FQlVG
RkVSOwogCQkJYnJlYWs7CiAJCWNhc2UgVk1XX1BMX0dNUjoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS92bXdnZngvdm13Z2Z4X2ZpZm8uYyBiL2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13
Z2Z4X2ZpZm8uYwppbmRleCBlNTI1MmVmMzgxMmYuLjFjZGM0NDViMjRjMyAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfZmlmby5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS92bXdnZngvdm13Z2Z4X2ZpZm8uYwpAQCAtNjEyLDcgKzYxMiw3IEBAIHN0YXRpYyBpbnQgdm13
X2ZpZm9fZW1pdF9kdW1teV9sZWdhY3lfcXVlcnkoc3RydWN0IHZtd19wcml2YXRlICpkZXZfcHJp
diwKIAogCWlmIChiby0+bWVtLm1lbV90eXBlID09IFRUTV9QTF9WUkFNKSB7CiAJCWNtZC0+Ym9k
eS5ndWVzdFJlc3VsdC5nbXJJZCA9IFNWR0FfR01SX0ZSQU1FQlVGRkVSOwotCQljbWQtPmJvZHku
Z3Vlc3RSZXN1bHQub2Zmc2V0ID0gYm8tPm9mZnNldDsKKwkJY21kLT5ib2R5Lmd1ZXN0UmVzdWx0
Lm9mZnNldCA9IGJvLT5tZW0uc3RhcnQgPDwgUEFHRV9TSElGVDsKIAl9IGVsc2UgewogCQljbWQt
PmJvZHkuZ3Vlc3RSZXN1bHQuZ21ySWQgPSBiby0+bWVtLnN0YXJ0OwogCQljbWQtPmJvZHkuZ3Vl
c3RSZXN1bHQub2Zmc2V0ID0gMDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS92bXdnZngv
dm13Z2Z4X3R0bV9idWZmZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X3R0bV9i
dWZmZXIuYwppbmRleCAzZjNiMmM3YTIwOGEuLmU3MTM0YWViZWI4MSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfdHRtX2J1ZmZlci5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS92bXdnZngvdm13Z2Z4X3R0bV9idWZmZXIuYwpAQCAtNzUwLDcgKzc1MCw2IEBAIHN0YXRp
YyBpbnQgdm13X2luaXRfbWVtX3R5cGUoc3RydWN0IHR0bV9ib19kZXZpY2UgKmJkZXYsIHVpbnQz
Ml90IHR5cGUsCiAJY2FzZSBUVE1fUExfVlJBTToKIAkJLyogIk9uLWNhcmQiIHZpZGVvIHJhbSAq
LwogCQltYW4tPmZ1bmMgPSAmdHRtX2JvX21hbmFnZXJfZnVuYzsKLQkJbWFuLT5ncHVfb2Zmc2V0
ID0gMDsKIAkJbWFuLT5mbGFncyA9IFRUTV9NRU1UWVBFX0ZMQUdfRklYRUQgfCBUVE1fTUVNVFlQ
RV9GTEFHX01BUFBBQkxFOwogCQltYW4tPmF2YWlsYWJsZV9jYWNoaW5nID0gVFRNX1BMX0ZMQUdf
Q0FDSEVEOwogCQltYW4tPmRlZmF1bHRfY2FjaGluZyA9IFRUTV9QTF9GTEFHX0NBQ0hFRDsKQEAg
LTc2Myw3ICs3NjIsNiBAQCBzdGF0aWMgaW50IHZtd19pbml0X21lbV90eXBlKHN0cnVjdCB0dG1f
Ym9fZGV2aWNlICpiZGV2LCB1aW50MzJfdCB0eXBlLAogCQkgKiAgc2xvdHMgYXMgd2VsbCBhcyB0
aGUgYm8gc2l6ZS4KIAkJICovCiAJCW1hbi0+ZnVuYyA9ICZ2bXdfZ21yaWRfbWFuYWdlcl9mdW5j
OwotCQltYW4tPmdwdV9vZmZzZXQgPSAwOwogCQltYW4tPmZsYWdzID0gVFRNX01FTVRZUEVfRkxB
R19DTUEgfCBUVE1fTUVNVFlQRV9GTEFHX01BUFBBQkxFOwogCQltYW4tPmF2YWlsYWJsZV9jYWNo
aW5nID0gVFRNX1BMX0ZMQUdfQ0FDSEVEOwogCQltYW4tPmRlZmF1bHRfY2FjaGluZyA9IFRUTV9Q
TF9GTEFHX0NBQ0hFRDsKLS0gCjIuMjUuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
