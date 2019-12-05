Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51D5C2D0BF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 13:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9521822525
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 13:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9521822525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C3386E11F;
	Thu,  5 Dec 2019 13:39:44 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3B26E11F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 13:39:43 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id c14so3631740wrn.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Dec 2019 05:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m3iXSEbayX2FPRa2r3EUTG5hURJbcJrujrV19F6uM1w=;
 b=SnSvywk3uJx7t/LFFOWl6jYuUUyImsrQ67KYrXDmBmPj89uGXz/OFfzwI9AkyI0mwj
 Q9wnG7cYo1W6sX4VRCxdtY1ouIbGxffgB7ex40CQ/Jk77EFitIOtrCH2SfBBAh7kPS/F
 pTF3+JXAMD/4NRE7DR6aBNadMUfuPoFWNWmL20q4axHKvW8ZvJ3gTjVkjE2u9z7OXxqR
 MPBVZw29tK4adsOIJ+smVTTWzy/t08RDCPfy37WywjOMx2BB1cGsaLPGK2tiNJgD5lvM
 hiRYJFn0dJZgCOqJLi6uWn3SEzpYd9bNUmpBOVNgMbbkhW83SkOdeJmE6G89Hgq/Ge8K
 xNtw==
X-Gm-Message-State: APjAAAXXuH9ltU/O/87vyBN5erAUla9tpoH3UReusxbVlG1Xuv09JgOZ
 2vNMyAt8f/HQOxzGzD0c8UunQ5Zs
X-Google-Smtp-Source: APXvYqzwv/wjP+2kM/kDcaS1FVwmoFDnvt+94Splm9Lc+V+8UPQkt9+wkXhz/nUaabPdAyjkOce6Lw==
X-Received: by 2002:adf:f789:: with SMTP id q9mr10445791wrp.103.1575553182108; 
 Thu, 05 Dec 2019 05:39:42 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:cd79:9e7:bab3:4698])
 by smtp.gmail.com with ESMTPSA id z189sm11219565wmc.2.2019.12.05.05.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 05:39:41 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, philip.yang@amd.com, Alex.Sierra@amd.com,
 felix.kuehling@amd.com
Subject: [PATCH 1/5] drm/amdgpu: move VM eviction decision into amdgpu_vm.c
Date: Thu,  5 Dec 2019 14:39:36 +0100
Message-Id: <20191205133940.3865-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m3iXSEbayX2FPRa2r3EUTG5hURJbcJrujrV19F6uM1w=;
 b=ZSK97tboknHH56FAMJGIBeNUqdg7a+MP47l34sTmCGXZY+g5cz6pHuNyVDwFtuiJuT
 Yj48fkMbejOI9tinkGRqGwW3sEHfjMp9aSzLCEwE9Mm7REma1pECLo1JeBounp9tl1av
 EUaE/89dfmxIw8sKbb9VINrS89kPlIPyA7bpHlDvUTTUcsBi7hgI8YQEbhv6fig5N2Xs
 kONLKcZ2QExu7FYy7lNGr1d+EyinAFsKQhY+12eQs+xcT5TfjCLmHCuv1RofPoXQxAqi
 c0mQkzKUH3nmy50AdD1t+khOuQ01xawR+nfcsTQCp7B5TiTTz2oSs/AJjJP7QiKFJ9oK
 /s8g==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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

V2hlbiBhIHBhZ2UgdGFibGVzIG5lZWRzIHRvIGJlIGV2aWN0ZWQgdGhlIFZNIGNvZGUgc2hvdWxk
CmRlY2lkZSBpZiB0aGF0IGlzIHBvc3NpYmxlIG9yIG5vdC4KClNpZ25lZC1vZmYtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZlbGl4
IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8ICA1ICstLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYyAgfCAyMiArKysrKysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCAgfCAgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDI0
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3R0bS5jCmluZGV4IDE5ZmZlMDBkOTA3Mi4uODFmNjc2NGYxYmE2IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCkBAIC0xNDg5LDExICsxNDg5LDggQEAgc3Rh
dGljIGJvb2wgYW1kZ3B1X3R0bV9ib19ldmljdGlvbl92YWx1YWJsZShzdHJ1Y3QgdHRtX2J1ZmZl
cl9vYmplY3QgKmJvLAogCXN0cnVjdCBkbWFfZmVuY2UgKmY7CiAJaW50IGk7CiAKLQkvKiBEb24n
dCBldmljdCBWTSBwYWdlIHRhYmxlcyB3aGlsZSB0aGV5IGFyZSBidXN5LCBvdGhlcndpc2Ugd2Ug
Y2FuJ3QKLQkgKiBjbGVhbmx5IGhhbmRsZSBwYWdlIGZhdWx0cy4KLQkgKi8KIAlpZiAoYm8tPnR5
cGUgPT0gdHRtX2JvX3R5cGVfa2VybmVsICYmCi0JICAgICFkbWFfcmVzdl90ZXN0X3NpZ25hbGVk
X3JjdShiby0+YmFzZS5yZXN2LCB0cnVlKSkKKwkgICAgIWFtZGdwdV92bV9ldmljdGFibGUodHRt
X3RvX2FtZGdwdV9ibyhibykpKQogCQlyZXR1cm4gZmFsc2U7CiAKIAkvKiBJZiBibyBpcyBhIEtG
RCBCTywgY2hlY2sgaWYgdGhlIGJvIGJlbG9uZ3MgdG8gdGhlIGN1cnJlbnQgcHJvY2Vzcy4KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKaW5kZXggYTk0YzRmYWE1YWYxLi5hMjJi
ZDU3MTI5ZDEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCkBAIC0yNTAz
LDYgKzI1MDMsMjggQEAgdm9pZCBhbWRncHVfdm1fYm9fcm12KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LAogCWtmcmVlKGJvX3ZhKTsKIH0KIAorLyoqCisgKiBhbWRncHVfdm1fZXZpY3RhYmxl
IC0gY2hlY2sgaWYgd2UgY2FuIGV2aWN0IGEgVk0KKyAqCisgKiBAYm86IEEgcGFnZSB0YWJsZSBv
ZiB0aGUgVk0uCisgKgorICogQ2hlY2sgaWYgaXQgaXMgcG9zc2libGUgdG8gZXZpY3QgYSBWTS4K
KyAqLworYm9vbCBhbWRncHVfdm1fZXZpY3RhYmxlKHN0cnVjdCBhbWRncHVfYm8gKmJvKQorewor
CXN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZSAqYm9fYmFzZSA9IGJvLT52bV9ibzsKKworCS8qIFBh
Z2UgdGFibGVzIG9mIGEgZGVzdHJveWVkIFZNIGNhbiBnbyBhd2F5IGltbWVkaWF0ZWx5ICovCisJ
aWYgKCFib19iYXNlIHx8ICFib19iYXNlLT52bSkKKwkJcmV0dXJuIHRydWU7CisKKwkvKiBEb24n
dCBldmljdCBWTSBwYWdlIHRhYmxlcyB3aGlsZSB0aGV5IGFyZSBidXN5ICovCisJaWYgKCFkbWFf
cmVzdl90ZXN0X3NpZ25hbGVkX3JjdShiby0+dGJvLmJhc2UucmVzdiwgdHJ1ZSkpCisJCXJldHVy
biBmYWxzZTsKKworCXJldHVybiB0cnVlOworfQorCiAvKioKICAqIGFtZGdwdV92bV9ib19pbnZh
bGlkYXRlIC0gbWFyayB0aGUgYm8gYXMgaW52YWxpZAogICoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmgKaW5kZXggNzZmY2Y4NTMwMzVjLi5kYjU2MTc2NTQ1M2IgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCkBAIC0zODEsNiArMzgxLDcgQEAgaW50IGFt
ZGdwdV92bV9oYW5kbGVfbW92ZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiBpbnQgYW1k
Z3B1X3ZtX2JvX3VwZGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCXN0cnVjdCBh
bWRncHVfYm9fdmEgKmJvX3ZhLAogCQkJYm9vbCBjbGVhcik7Citib29sIGFtZGdwdV92bV9ldmlj
dGFibGUoc3RydWN0IGFtZGdwdV9ibyAqYm8pOwogdm9pZCBhbWRncHVfdm1fYm9faW52YWxpZGF0
ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCSAgICAgc3RydWN0IGFtZGdwdV9ibyAq
Ym8sIGJvb2wgZXZpY3RlZCk7CiB1aW50NjRfdCBhbWRncHVfdm1fbWFwX2dhcnQoY29uc3QgZG1h
X2FkZHJfdCAqcGFnZXNfYWRkciwgdWludDY0X3QgYWRkcik7Ci0tIAoyLjE3LjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
