Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03550C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 13:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4C9229C4
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 13:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4C9229C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5FFB6E10E;
	Tue,  5 Jan 2021 13:44:12 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACFF26E108;
 Tue,  5 Jan 2021 13:44:11 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id g25so1509074wmh.1;
 Tue, 05 Jan 2021 05:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hp+FXY/j+HS1RZY1QPCjRJHJ011MN+/S057cH09kSZs=;
 b=Bxrd3/zrHtZFlcg9No5k3H03zGO6iHX15NG1AZTMYc7Ng9vEIpuGlqq44W73lwetV6
 fMA7uOIIsPAPsg1f1CxdrWL164L3qJlgJG1h7vaSLiapwq414qWh5D3JH4poemMxla6E
 4B2kkt/gejIKWcR+j6lfgmcoM0VmfDkaLTRgcLxQDFSG7Zd3ubJTBjyMj57mT5AOyIyw
 CBWhTDiFlD83wSML+AgFYErqJxS5dvHUjzesuzGM25DKt99PKAAZB46Vyq1THUNSlh8g
 7CexgOJ0G5RWhTvh3VEgC0474S/KnMYExwLNwOGfVdyVw4ZIj1IePFHf9kxhMbYcMTNc
 Rpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hp+FXY/j+HS1RZY1QPCjRJHJ011MN+/S057cH09kSZs=;
 b=Hd8Jndk9JEAev4CocoXfwTxgd6lLh6BhywSTNDHabUA9mVjsZbsLL7kKtEwyMeIjdJ
 9E97TPYW0gzHwLd0286vojbUs1kooOnW5YITW8oIYUJpUcMJTzXdC4JCE6Eneoi3Vnju
 EceN2dSMaWKIlLAu3WA1mTv+LViTogUH7Wib+YTgJm/Rktio0E7NfmrGw8ouSnSHXZ9t
 DbF8+VB8JbOisnd0QH209RgnG6g7GkZZjzUcT7/t8y1ahrbv6Bhg99BKLS/3MMYMKwLE
 Ir2bkRfkhIu8ry4BYlDov1kjsK7wvGIsAC5KlOGntqS040wDKR4G5D5tIujuPQNabXZD
 EQoA==
X-Gm-Message-State: AOAM531lZcBVN1WJdskBh9gufhL8DfThbbXSjxuG2sRQaE5z2jCVFgiG
 d0ZPrnSyTx53FBUXVL4wFnA=
X-Google-Smtp-Source: ABdhPJz7Dxb6nnjRrvu9rS/LYHVJIiS73Lk13z8bDFfT28Aif2E3DZKCZs3vAjf70aQm1RjwchIn9A==
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr3563620wma.18.1609854250423; 
 Tue, 05 Jan 2021 05:44:10 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:3137:60b9:8d8f:7f55])
 by smtp.gmail.com with ESMTPSA id l20sm102191243wrh.82.2021.01.05.05.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 05:44:10 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: bhelgaas@google.com
Subject: [PATCH 2/4] pci: add BAR bytes->size helper & expose size->bytes
 helper v2
Date: Tue,  5 Jan 2021 14:44:02 +0100
Message-Id: <20210105134404.1545-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105134404.1545-1-christian.koenig@amd.com>
References: <20210105134404.1545-1-christian.koenig@amd.com>
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
Cc: devspam@moreofthesa.me.uk, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogRGFycmVuIFNhbHQgPGRldnNwYW1AbW9yZW9mdGhlc2EubWUudWs+CgpUaGlzIGlzIHRv
IGFzc2lzdCBkcml2ZXIgbW9kdWxlcyB3aGljaCBkbyBCQVIgcmVzaXppbmcuCgp2MiAoY2hrKTog
VXNlIGlsb2cyIGFuZCBtYWtlIHRoZSBuZXcgZnVudGlvbiBleHRyYSBkZWZlbnNpdmUuCgkgIEFs
c28gdXNlIHRoZSBuZXcgZnVuY3Rpb24gb24gdGhlIHR3byBleGlzdGluZyBvY2Fzc2lvbnMuCgpT
aWduZWQtb2ZmLWJ5OiBEYXJyZW4gU2FsdCA8ZGV2c3BhbUBtb3Jlb2Z0aGVzYS5tZS51az4KU2ln
bmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8ICAzICstLQog
ZHJpdmVycy9wY2kvcGNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KIGRyaXZl
cnMvcGNpL3BjaS5oICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0IC0tLS0KIGluY2x1ZGUv
bGludXgvcGNpLmggICAgICAgICAgICAgICAgICAgICAgICB8IDEyICsrKysrKysrKysrKwogNCBm
aWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCBkY2UwZTY2YjIzNjQuLjcw
YWNkNjczZTNmMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YwpAQCAtMTA4OSw4ICsxMDg5LDcgQEAgdm9pZCBhbWRncHVfZGV2aWNlX3diX2ZyZWUoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMiB3YikKICAqLwogaW50IGFtZGdwdV9kZXZpY2VfcmVz
aXplX2ZiX2JhcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKLQl1NjQgc3BhY2VfbmVl
ZGVkID0gcm91bmR1cF9wb3dfb2ZfdHdvKGFkZXYtPmdtYy5yZWFsX3ZyYW1fc2l6ZSk7Ci0JdTMy
IHJiYXJfc2l6ZSA9IG9yZGVyX2Jhc2VfMigoKHNwYWNlX25lZWRlZCA+PiAyMCkgfCAxKSkgLSAx
OworCXUzMiByYmFyX3NpemUgPSBwY2lfcmViYXJfYnl0ZXNfdG9fc2l6ZShhZGV2LT5nbWMucmVh
bF92cmFtX3NpemUpOwogCXN0cnVjdCBwY2lfYnVzICpyb290OwogCXN0cnVjdCByZXNvdXJjZSAq
cmVzOwogCXVuc2lnbmVkIGk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2kuYyBiL2RyaXZl
cnMvcGNpL3BjaS5jCmluZGV4IGVmODBlZDQ1MTQxNS4uMTYyMTYxODZiNTFjIDEwMDY0NAotLS0g
YS9kcml2ZXJzL3BjaS9wY2kuYworKysgYi9kcml2ZXJzL3BjaS9wY2kuYwpAQCAtMTY0OCw3ICsx
NjQ4LDcgQEAgc3RhdGljIHZvaWQgcGNpX3Jlc3RvcmVfcmViYXJfc3RhdGUoc3RydWN0IHBjaV9k
ZXYgKnBkZXYpCiAJCXBjaV9yZWFkX2NvbmZpZ19kd29yZChwZGV2LCBwb3MgKyBQQ0lfUkVCQVJf
Q1RSTCwgJmN0cmwpOwogCQliYXJfaWR4ID0gY3RybCAmIFBDSV9SRUJBUl9DVFJMX0JBUl9JRFg7
CiAJCXJlcyA9IHBkZXYtPnJlc291cmNlICsgYmFyX2lkeDsKLQkJc2l6ZSA9IGlsb2cyKHJlc291
cmNlX3NpemUocmVzKSkgLSAyMDsKKwkJc2l6ZSA9IHBjaV9yZWJhcl9ieXRlc190b19zaXplKHJl
c291cmNlX3NpemUocmVzKSk7CiAJCWN0cmwgJj0gflBDSV9SRUJBUl9DVFJMX0JBUl9TSVpFOwog
CQljdHJsIHw9IHNpemUgPDwgUENJX1JFQkFSX0NUUkxfQkFSX1NISUZUOwogCQlwY2lfd3JpdGVf
Y29uZmlnX2R3b3JkKHBkZXYsIHBvcyArIFBDSV9SRUJBUl9DVFJMLCBjdHJsKTsKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGNpL3BjaS5oIGIvZHJpdmVycy9wY2kvcGNpLmgKaW5kZXggNjQwYWU3ZDc0
ZmMzLi4wZmEzMWZmM2Q0ZTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL3BjaS5oCisrKyBiL2Ry
aXZlcnMvcGNpL3BjaS5oCkBAIC02MTAsMTAgKzYxMCw2IEBAIGludCBhY3BpX2dldF9yY19yZXNv
dXJjZXMoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpoaWQsIHUxNiBzZWdtZW50LAog
CiBpbnQgcGNpX3JlYmFyX2dldF9jdXJyZW50X3NpemUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGlu
dCBiYXIpOwogaW50IHBjaV9yZWJhcl9zZXRfc2l6ZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgaW50
IGJhciwgaW50IHNpemUpOwotc3RhdGljIGlubGluZSB1NjQgcGNpX3JlYmFyX3NpemVfdG9fYnl0
ZXMoaW50IHNpemUpCi17Ci0JcmV0dXJuIDFVTEwgPDwgKHNpemUgKyAyMCk7Ci19CiAKIHN0cnVj
dCBkZXZpY2Vfbm9kZTsKIApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wY2kuaCBiL2luY2x1
ZGUvbGludXgvcGNpLmgKaW5kZXggOTk5OTA0MGNmYWQ5Li42NzM2MDZmODcxYjcgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvbGludXgvcGNpLmgKKysrIGIvaW5jbHVkZS9saW51eC9wY2kuaApAQCAtMTIy
Niw2ICsxMjI2LDE4IEBAIHZvaWQgcGNpX3VwZGF0ZV9yZXNvdXJjZShzdHJ1Y3QgcGNpX2RldiAq
ZGV2LCBpbnQgcmVzbm8pOwogaW50IF9fbXVzdF9jaGVjayBwY2lfYXNzaWduX3Jlc291cmNlKHN0
cnVjdCBwY2lfZGV2ICpkZXYsIGludCBpKTsKIGludCBfX211c3RfY2hlY2sgcGNpX3JlYXNzaWdu
X3Jlc291cmNlKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGludCBpLCByZXNvdXJjZV9zaXplX3QgYWRk
X3NpemUsIHJlc291cmNlX3NpemVfdCBhbGlnbik7CiB2b2lkIHBjaV9yZWxlYXNlX3Jlc291cmNl
KHN0cnVjdCBwY2lfZGV2ICpkZXYsIGludCByZXNubyk7CisKK3N0YXRpYyBfX2Fsd2F5c19pbmxp
bmUgaW50IHBjaV9yZWJhcl9ieXRlc190b19zaXplKHU2NCBieXRlcykKK3sKKwlieXRlcyA9IHJv
dW5kdXBfcG93X29mX3R3byhieXRlcyk7CisJcmV0dXJuIG1heChpbG9nMihieXRlcyksIDIwKSAt
IDIwOworfQorCitzdGF0aWMgX19hbHdheXNfaW5saW5lIHU2NCBwY2lfcmViYXJfc2l6ZV90b19i
eXRlcyhpbnQgc2l6ZSkKK3sKKwlyZXR1cm4gMVVMTCA8PCAoc2l6ZSArIDIwKTsKK30KKwogdTMy
IHBjaV9yZWJhcl9nZXRfcG9zc2libGVfc2l6ZXMoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGludCBi
YXIpOwogaW50IF9fbXVzdF9jaGVjayBwY2lfcmVzaXplX3Jlc291cmNlKHN0cnVjdCBwY2lfZGV2
ICpkZXYsIGludCBpLCBpbnQgc2l6ZSk7CiBpbnQgcGNpX3NlbGVjdF9iYXJzKHN0cnVjdCBwY2lf
ZGV2ICpkZXYsIHVuc2lnbmVkIGxvbmcgZmxhZ3MpOwotLSAKMi4yNS4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
