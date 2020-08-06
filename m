Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3107BC433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 12:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DE223117
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 12:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKZC20zK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DE223117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B00E6E8AD;
	Thu,  6 Aug 2020 12:56:05 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1181B6E8AD
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 12:56:05 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id p14so8754582wmg.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Aug 2020 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vMpAvCEN5GQDTcYzAsSNvWeDZNYvtxMFs6E/m3qK5LQ=;
 b=UKZC20zKGa/ylesz44+koNmPGLfoVs/6X3YAhx0UR/YiBhhA3NTqH5Nv60CMbde7Fj
 x5wpxgmE2d8ImatvAcx/Zgw+MPZ/TfGlmOKi5+b5rM/bCCBHTde3hKaucREKVUH2dCBh
 MWUomKHItj8flmt4z+2I96OwcQIQ2DOyxGfmAd8hZ0XP0Ny4MQu7nta+g2RxQbs1AAu9
 eAM3qYrtOewZh/Jfr425GcWncxiu8jEX1CHOAwwThYJ0sWvCfzLkb3h1oaZBIfJDrolw
 VfQtRcADdvBIdHJ6+Gis470qUSGT8fldMzZiKWlbvAjupMP8VZKkAXgd5kiPRKfhwFhO
 0+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vMpAvCEN5GQDTcYzAsSNvWeDZNYvtxMFs6E/m3qK5LQ=;
 b=f/sxcRxSG6J47JZlq2KZb3S3wYRvU04nGIvtTaFfiMbZjC+LukiVQDv3WnlQ73AnHR
 XG/dkx3IZBaXls+qUeXQFLYMsgLDMRlzszdkIa5Fic3HBwLkFXMlHJ3v9dWiqhjLAqP5
 w+wMgXFXDHUVZXspqD5k9Kb9/jqI3/hWCP6MbML7hrhz4ImPWPkjIhxT8fyRTYCWS9az
 Nm3Ow//QhzJX5Z8GgTdmps+HpU/4srZnpHOkH7shHSkl3aYuJlUdaxZg4xo1myyK/Oec
 zCzcJtpMBesOF2WDjXFIJV/YjKco/X54D5ZzKlyurdhQB35aqQlArLI8ow12139ERX+C
 6mOQ==
X-Gm-Message-State: AOAM53152Sv60fItqyFe0G8iDaPJdPkF4rIj5Z3KWxjjsNvnzjH1DILD
 RPjbqNi3zB65tIFEoy9vDiA=
X-Google-Smtp-Source: ABdhPJykBzaSMLf39aho7jeG27qbJflBEhRtv+dYrP465NQ2SZ3EFe24Hje0z63Aba4M2QVDU1P/4w==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr8090739wmb.25.1596718563562; 
 Thu, 06 Aug 2020 05:56:03 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:27c4:33f6:883b:6c24])
 by smtp.gmail.com with ESMTPSA id m126sm6530013wmf.3.2020.08.06.05.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 05:56:02 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: michel@daenzer.net,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: make sure userptr ttm is allocated
Date: Thu,  6 Aug 2020 14:56:01 +0200
Message-Id: <20200806125601.1394-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
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

V2UgbmVlZCB0byBhbGxvY2F0ZSB0aGF0IG1hbnVhbGx5IG5vdy4KClNpZ25lZC1vZmYtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KRml4ZXM6IDJkZGVmMTc2
NzhiYyAoSEVBRCkgZHJtL3R0bTogbWFrZSBUVCBjcmVhdGlvbiBwdXJlbHkgb3B0aW9uYWwgdjMK
LS0tCiAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyAgICB8ICAy
ICstCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgICAgICAgICB8ICAy
ICstCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgICAgICAgICB8IDE3
ICsrKysrKysrKysrLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRt
LmggICAgICAgICB8ICA0ICsrLS0KIDQgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwg
MTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZF9ncHV2bS5jCmluZGV4IDkwMTVjN2I3NmQ2MC4uNTVkMmU4NzBmZGRhIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCkBAIC01
NjQsNyArNTY0LDcgQEAgc3RhdGljIGludCBpbml0X3VzZXJfcGFnZXMoc3RydWN0IGtnZF9tZW0g
Km1lbSwgdWludDY0X3QgdXNlcl9hZGRyKQogCiAJbXV0ZXhfbG9jaygmcHJvY2Vzc19pbmZvLT5s
b2NrKTsKIAotCXJldCA9IGFtZGdwdV90dG1fdHRfc2V0X3VzZXJwdHIoYm8tPnRiby50dG0sIHVz
ZXJfYWRkciwgMCk7CisJcmV0ID0gYW1kZ3B1X3R0bV90dF9zZXRfdXNlcnB0cigmYm8tPnRibywg
dXNlcl9hZGRyLCAwKTsKIAlpZiAocmV0KSB7CiAJCXByX2VycigiJXM6IEZhaWxlZCB0byBzZXQg
dXNlcnB0cjogJWRcbiIsIF9fZnVuY19fLCByZXQpOwogCQlnb3RvIG91dDsKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwppbmRleCBkZTk3ODRiMGMxOWIuLmIyZGMzMjBlNzMw
NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwpAQCAtMzMyLDcgKzMz
Miw3IEBAIGludCBhbWRncHVfZ2VtX3VzZXJwdHJfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRl
diwgdm9pZCAqZGF0YSwKIAlibyA9IGdlbV90b19hbWRncHVfYm8oZ29iaik7CiAJYm8tPnByZWZl
cnJlZF9kb21haW5zID0gQU1ER1BVX0dFTV9ET01BSU5fR1RUOwogCWJvLT5hbGxvd2VkX2RvbWFp
bnMgPSBBTURHUFVfR0VNX0RPTUFJTl9HVFQ7Ci0JciA9IGFtZGdwdV90dG1fdHRfc2V0X3VzZXJw
dHIoYm8tPnRiby50dG0sIGFyZ3MtPmFkZHIsIGFyZ3MtPmZsYWdzKTsKKwlyID0gYW1kZ3B1X3R0
bV90dF9zZXRfdXNlcnB0cigmYm8tPnRibywgYXJncy0+YWRkciwgYXJncy0+ZmxhZ3MpOwogCWlm
IChyKQogCQlnb3RvIHJlbGVhc2Vfb2JqZWN0OwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMKaW5kZXggMjg1NTc4MzlmMTMyLi42N2QyZWVmMmY5ZWIgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKQEAgLTE0MDcsMjEgKzE0MDcsMjYgQEAgc3Rh
dGljIHZvaWQgYW1kZ3B1X3R0bV90dF91bnBvcHVsYXRlKHN0cnVjdCB0dG1fdHQgKnR0bSkKICAq
IGFtZGdwdV90dG1fdHRfc2V0X3VzZXJwdHIgLSBJbml0aWFsaXplIHVzZXJwdHIgR1RUIHR0bV90
dCBmb3IgdGhlIGN1cnJlbnQKICAqIHRhc2sKICAqCi0gKiBAdHRtOiBUaGUgdHRtX3R0IG9iamVj
dCB0byBiaW5kIHRoaXMgdXNlcnB0ciBvYmplY3QgdG8KKyAqIEBibzogVGhlIHR0bV9idWZmZXJf
b2JqZWN0IHRvIGJpbmQgdGhpcyB1c2VycHRyIHRvCiAgKiBAYWRkcjogIFRoZSBhZGRyZXNzIGlu
IHRoZSBjdXJyZW50IHRhc2tzIFZNIHNwYWNlIHRvIHVzZQogICogQGZsYWdzOiBSZXF1aXJlbWVu
dHMgb2YgdXNlcnB0ciBvYmplY3QuCiAgKgogICogQ2FsbGVkIGJ5IGFtZGdwdV9nZW1fdXNlcnB0
cl9pb2N0bCgpIHRvIGJpbmQgdXNlcnB0ciBwYWdlcwogICogdG8gY3VycmVudCB0YXNrCiAgKi8K
LWludCBhbWRncHVfdHRtX3R0X3NldF91c2VycHRyKHN0cnVjdCB0dG1fdHQgKnR0bSwgdWludDY0
X3QgYWRkciwKLQkJCSAgICAgIHVpbnQzMl90IGZsYWdzKQoraW50IGFtZGdwdV90dG1fdHRfc2V0
X3VzZXJwdHIoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibywKKwkJCSAgICAgIHVpbnQ2NF90
IGFkZHIsIHVpbnQzMl90IGZsYWdzKQogewotCXN0cnVjdCBhbWRncHVfdHRtX3R0ICpndHQgPSAo
dm9pZCAqKXR0bTsKKwlzdHJ1Y3QgYW1kZ3B1X3R0bV90dCAqZ3R0OwogCi0JaWYgKGd0dCA9PSBO
VUxMKQotCQlyZXR1cm4gLUVJTlZBTDsKKwlpZiAoIWJvLT50dG0pIHsKKwkJLyogVE9ETzogV2Ug
d2FudCBhIHNlcGFyYXRlIFRUTSBvYmplY3QgdHlwZSBmb3IgdXNlcnB0cnMgKi8KKwkJYm8tPnR0
bSA9IGFtZGdwdV90dG1fdHRfY3JlYXRlKGJvLCAwKTsKKwkJaWYgKGJvLT50dG0gPT0gTlVMTCkK
KwkJCXJldHVybiAtRU5PTUVNOworCX0KIAorCWd0dCA9ICh2b2lkKiliby0+dHRtOwogCWd0dC0+
dXNlcnB0ciA9IGFkZHI7CiAJZ3R0LT51c2VyZmxhZ3MgPSBmbGFnczsKIApkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5oCmluZGV4IDM2YjAyNGZkMDc3ZS4uNDMzMTU2YzJlOGZi
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmgKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5oCkBAIC0xMzIsOCArMTMy
LDggQEAgc3RhdGljIGlubGluZSBib29sIGFtZGdwdV90dG1fdHRfZ2V0X3VzZXJfcGFnZXNfZG9u
ZShzdHJ1Y3QgdHRtX3R0ICp0dG0pCiAjZW5kaWYKIAogdm9pZCBhbWRncHVfdHRtX3R0X3NldF91
c2VyX3BhZ2VzKHN0cnVjdCB0dG1fdHQgKnR0bSwgc3RydWN0IHBhZ2UgKipwYWdlcyk7Ci1pbnQg
YW1kZ3B1X3R0bV90dF9zZXRfdXNlcnB0cihzdHJ1Y3QgdHRtX3R0ICp0dG0sIHVpbnQ2NF90IGFk
ZHIsCi0JCQkJICAgICB1aW50MzJfdCBmbGFncyk7CitpbnQgYW1kZ3B1X3R0bV90dF9zZXRfdXNl
cnB0cihzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAorCQkJICAgICAgdWludDY0X3QgYWRk
ciwgdWludDMyX3QgZmxhZ3MpOwogYm9vbCBhbWRncHVfdHRtX3R0X2hhc191c2VycHRyKHN0cnVj
dCB0dG1fdHQgKnR0bSk7CiBzdHJ1Y3QgbW1fc3RydWN0ICphbWRncHVfdHRtX3R0X2dldF91c2Vy
bW0oc3RydWN0IHR0bV90dCAqdHRtKTsKIGJvb2wgYW1kZ3B1X3R0bV90dF9hZmZlY3RfdXNlcnB0
cihzdHJ1Y3QgdHRtX3R0ICp0dG0sIHVuc2lnbmVkIGxvbmcgc3RhcnQsCi0tIAoyLjE3LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
