Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF995C433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC1A2074B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgNs1pOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC1A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C8386E965;
	Thu, 30 Jul 2020 20:04:39 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FBFA6E962
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 20:04:33 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id dd12so8091622qvb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 13:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Zb1eACQKwsz/krn16vmArI72eODmeqnWCuFsJCCF3Qo=;
 b=HgNs1pOIAuQ0byVAK3W53tAlKnHq2+Xx4WDhslzOfDqHctRqYauCzYnPn0c2Fkd33j
 tNDvDlQn7TXs0JscvmBy28bdR6rwI9wYSCp+Zjg4UbPh8h1C4i0cIcBRoLfM/e3QmExA
 NtQNl1sgSj591r7jzyFILPovKgpzZz6i3J5pQKQZDbU9b5m+VQkioCrr8LmmWJrMhHBB
 OebrFGbhXtp0Ri48KOztCLrPvB2rHTkpO+0keHQ20wFKmzYf2wERfvc0qDRaejBVkaX9
 AoqW81sIE79ozigsdclSI/KBHH8OrqCTAdMarwrHH7OtvWmP9T7cS7/DaiTPBKSc1DxL
 4ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Zb1eACQKwsz/krn16vmArI72eODmeqnWCuFsJCCF3Qo=;
 b=FI+EaUeuPXRPz3rvLX93yf5F5+YYVtKqyHtt/oaRIig5e54korWYIm/YbsPljjqbas
 L1p4fxbYi7vaxYooXhqj7nNdyurSgGD3VyGRod1L4Z6x4/YBhGcxwP8q0oulhI4Rn1i8
 m3TtbGXKv19aixm6/Af6fgR5Dwe5RhwjQ9pDivSHc6V1gI2mNy4zEaVtPUroEwIEEpn9
 Oy/NH8O9Ms/vIIEW0mj6s7tXSzX2flZToZJKIWITBzvVuU4Eztt2WqoO2t2VypN2GCww
 r+oiojlaPWihU3eDdIM0qQbT9uBIarBmptBCPHbVRcWyYh6T3aCNn2Vk7B2SzWzzf6ab
 cNsg==
X-Gm-Message-State: AOAM532kegQR4F+ododXLIG9p+uDqoTZOQj5PKPot+RXzL0yROczEJNF
 LHUJ1nMnOuOiQhYHkWidqljeKJiu
X-Google-Smtp-Source: ABdhPJw4IslZPcinoDuUo/OgACvInYpRG583eesoWFoS9IgI7Hr53QKG/Jl+NDd90AxHMovNgqH8tw==
X-Received: by 2002:ad4:446d:: with SMTP id s13mr789213qvt.183.1596139472253; 
 Thu, 30 Jul 2020 13:04:32 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id d8sm5652757qtr.12.2020.07.30.13.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 13:04:31 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/17] drm/amdgpu/gmc7: switch to using
 amdgpu_gmc_get_vbios_allocations
Date: Thu, 30 Jul 2020 16:04:06 -0400
Message-Id: <20200730200414.40485-10-alexander.deucher@amd.com>
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
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192N18wLmMgfCA5ICsrKystLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y3XzAuYwppbmRleCA4YjhlY2JiOTlkODQuLjgwYzE0NmRmMzM4YSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y3XzAuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5jCkBAIC05NzcsOSArOTc3LDcgQEAgc3RhdGlj
IHVuc2lnbmVkIGdtY192N18wX2dldF92Ymlvc19mYl9zaXplKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQogCQkJUkVHX0dFVF9GSUVMRCh2aWV3cG9ydCwgVklFV1BPUlRfU0laRSwgVklFV1BP
UlRfV0lEVEgpICoKIAkJCTQpOwogCX0KLQkvKiByZXR1cm4gMCBpZiB0aGUgcHJlLU9TIGJ1ZmZl
ciB1c2VzIHVwIG1vc3Qgb2YgdnJhbSAqLwotCWlmICgoYWRldi0+Z21jLnJlYWxfdnJhbV9zaXpl
IC0gc2l6ZSkgPCAoOCAqIDEwMjQgKiAxMDI0KSkKLQkJcmV0dXJuIDA7CisKIAlyZXR1cm4gc2l6
ZTsKIH0KIApAQCAtMTAzNSw3ICsxMDMzLDcgQEAgc3RhdGljIGludCBnbWNfdjdfMF9zd19pbml0
KHZvaWQgKmhhbmRsZSkKIAlpZiAocikKIAkJcmV0dXJuIHI7CiAKLQlhZGV2LT5nbWMuc3RvbGVu
X3ZnYV9zaXplID0gZ21jX3Y3XzBfZ2V0X3ZiaW9zX2ZiX3NpemUoYWRldik7CisJYW1kZ3B1X2dt
Y19nZXRfdmJpb3NfYWxsb2NhdGlvbnMoYWRldik7CiAKIAkvKiBNZW1vcnkgbWFuYWdlciAqLwog
CXIgPSBhbWRncHVfYm9faW5pdChhZGV2KTsKQEAgLTEzNzIsNyArMTM3MCw4IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgYW1kZ3B1X2dtY19mdW5jcyBnbWNfdjdfMF9nbWNfZnVuY3MgPSB7CiAJLmVt
aXRfcGFzaWRfbWFwcGluZyA9IGdtY192N18wX2VtaXRfcGFzaWRfbWFwcGluZywKIAkuc2V0X3By
dCA9IGdtY192N18wX3NldF9wcnQsCiAJLmdldF92bV9wZGUgPSBnbWNfdjdfMF9nZXRfdm1fcGRl
LAotCS5nZXRfdm1fcHRlID0gZ21jX3Y3XzBfZ2V0X3ZtX3B0ZQorCS5nZXRfdm1fcHRlID0gZ21j
X3Y3XzBfZ2V0X3ZtX3B0ZSwKKwkuZ2V0X3ZiaW9zX2ZiX3NpemUgPSBnbWNfdjdfMF9nZXRfdmJp
b3NfZmJfc2l6ZSwKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2lycV9zcmNfZnVu
Y3MgZ21jX3Y3XzBfaXJxX2Z1bmNzID0gewotLSAKMi4yNS40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
