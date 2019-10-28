Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ACCCA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28934217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28934217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E32FF6EAA7;
	Mon, 28 Oct 2019 21:43:35 +0000 (UTC)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18CA96EAA7
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:43:35 +0000 (UTC)
Received: by mail-yb1-xb41.google.com with SMTP id z125so4644929ybc.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RrOpg/Upy9l67yTKZlPLf0p83NFZJk8nm/f92EYp9Ss=;
 b=rGf8/ZQWwuCSw5dk+MsaEoK6qrnc4hzepweY/H7A9B72JlhXgZTo0uXR8VV+73EXMY
 LIo5z/Uc3MsE5q4sW3WcmYORLVzy6qKjhCxMPIhSkq2+386tNpMR+Z0y/cAK3IolCS5m
 2rxHcqemL2FyHfw/e1G87ZccASN4xcdELfUexYGDYdkwCK5XVCwYHdQrxJ6ooMWgWZUR
 OCJxTI2B96Qtz8iwEdwe0Eu3/JY9EUDIVsqx0rTEM+giooceIItW8FWseZ6JIdv7cR7k
 9THwQvHAVDMFVGsVnSUPRoj8Kx1BDUhH9SK0T6fbDFTDOKAgdByqqz42EJ31dgQ3eEf3
 WXsA==
X-Gm-Message-State: APjAAAWO7xK9C1O06JL3m4XD2rGQ+YE6hnz8X6RZrWIPXNRNCHRxwCOX
 UtMst9Pa1s/60leXZOH13tUJJyU2z3E=
X-Google-Smtp-Source: APXvYqypD/H/qdgc7JW/7fDTtq2eWsXhh69R32hZlUBYHMACihCcDDiYgBBkijY8s3dvyQ4BFp8wvA==
X-Received: by 2002:a25:fc26:: with SMTP id v38mr16445664ybd.322.1572299013807; 
 Mon, 28 Oct 2019 14:43:33 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:43:33 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 12/21] drm/amdgpu: add helpers for baco entry and exit
Date: Mon, 28 Oct 2019 17:42:07 -0400
Message-Id: <20191028214216.1508370-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RrOpg/Upy9l67yTKZlPLf0p83NFZJk8nm/f92EYp9Ss=;
 b=fpp+S4OKMPA9N2Tqnd+NuGVQcGP3NcETOK1yCDVvArVgmS3mZn3QLUnAcK6sHIRpH6
 xxb9nI4TyuZdeQaOdmXAXZG2o+6JtgIYh+7kMoNEgkDB7Z4n+c2/10AL1IhOQQSX0nEG
 u5b1PVJQMdRUvW37A8m1yBHQdR+l3GfL91pWoPPv34Jovl5Q3YLR5l++bU5rgJ4NnWLD
 6PwE90tHBR7/aYlmf9nGssTynU0IACgZukS32x0mLRDY3WPouUCGlqbDouiCVDK9Ux+l
 ldzouYeoUkF5qHg1uPemQE9NeF7VeyvNUDhIZB64bgWTR4QQFgZWEPTyRPXnrc7mnzWh
 OQ9g==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028214207.8Z2Z4ZIneMAx-osklEqQ-L4iQStpH41bLFzUGEyL-Ss@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpXaWxsIGJlIHVzZWQgZm9yIHJ1bnRpbWUgcG0u
ICBFbnRyeSB3aWxsIGVudGVyIHRoZSBCQUNPCnN0YXRlIChjaGlwIG9mZikuICBFeGl0IHdpbGwg
ZXhpdCB0aGUgQkFDTyBzdGF0ZSAoY2hpcCBvbikuCgpSZXZpZXdlZC1ieTogRXZhbiBRdWFuIDxl
dmFuLnF1YW5AYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5o
ICAgICAgICB8ICAyICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YyB8IDYxICsrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgNjMgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5o
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKaW5kZXggZDA0YTk0ZWQyM2U1
Li5mMmI5NzE0ZTdlMGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCkBAIC0xMTQy
LDYgKzExNDIsOCBAQCBib29sIGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYm9jbyhzdHJ1Y3QgZHJt
X2RldmljZSAqZGV2KTsKIGJvb2wgYW1kZ3B1X2RldmljZV9zdXBwb3J0c19iYWNvKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYpOwogYm9vbCBhbWRncHVfZGV2aWNlX2lzX3BlZXJfYWNjZXNzaWJsZShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCQkgICAgICBzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqcGVlcl9hZGV2KTsKK2ludCBhbWRncHVfZGV2aWNlX2JhY29fZW50ZXIoc3RydWN0IGRybV9k
ZXZpY2UgKmRldik7CitpbnQgYW1kZ3B1X2RldmljZV9iYWNvX2V4aXQoc3RydWN0IGRybV9kZXZp
Y2UgKmRldik7CiAKIC8qIGF0cHggaGFuZGxlciAqLwogI2lmIGRlZmluZWQoQ09ORklHX1ZHQV9T
V0lUQ0hFUk9PKQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCmlu
ZGV4IDJhNWY0YzdjMGEyNC4uMjQxNmE1MTAzMTU0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC00MjU2LDMgKzQyNTYsNjQgQEAgc3RhdGljIHZvaWQg
YW1kZ3B1X2RldmljZV9nZXRfcGNpZV9pbmZvKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQog
CX0KIH0KIAoraW50IGFtZGdwdV9kZXZpY2VfYmFjb19lbnRlcihzdHJ1Y3QgZHJtX2RldmljZSAq
ZGV2KQoreworCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gZGV2LT5kZXZfcHJpdmF0ZTsK
KworCWlmICghYW1kZ3B1X2RldmljZV9zdXBwb3J0c19iYWNvKGFkZXYtPmRkZXYpKQorCQlyZXR1
cm4gLUVOT1RTVVBQOworCisJaWYgKGlzX3N1cHBvcnRfc3dfc211KGFkZXYpKSB7CisJCXN0cnVj
dCBzbXVfY29udGV4dCAqc211ID0gJmFkZXYtPnNtdTsKKwkJaW50IHJldDsKKworCQlyZXQgPSBz
bXVfYmFjb19lbnRlcihzbXUpOworCQlpZiAocmV0KQorCQkJcmV0dXJuIHJldDsKKworCQlyZXR1
cm4gMDsKKwl9IGVsc2UgeworCQl2b2lkICpwcF9oYW5kbGUgPSBhZGV2LT5wb3dlcnBsYXkucHBf
aGFuZGxlOworCQljb25zdCBzdHJ1Y3QgYW1kX3BtX2Z1bmNzICpwcF9mdW5jcyA9IGFkZXYtPnBv
d2VycGxheS5wcF9mdW5jczsKKworCQlpZiAoIXBwX2Z1bmNzIHx8IXBwX2Z1bmNzLT5nZXRfYXNp
Y19iYWNvX3N0YXRlIHx8IXBwX2Z1bmNzLT5zZXRfYXNpY19iYWNvX3N0YXRlKQorCQkJcmV0dXJu
IC1FTk9FTlQ7CisKKwkJLyogZW50ZXIgQkFDTyBzdGF0ZSAqLworCQlpZiAocHBfZnVuY3MtPnNl
dF9hc2ljX2JhY29fc3RhdGUocHBfaGFuZGxlLCAxKSkKKwkJCXJldHVybiAtRUlPOworCisJCXJl
dHVybiAwOworCX0KK30KKworaW50IGFtZGdwdV9kZXZpY2VfYmFjb19leGl0KHN0cnVjdCBkcm1f
ZGV2aWNlICpkZXYpCit7CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBkZXYtPmRldl9w
cml2YXRlOworCisJaWYgKCFhbWRncHVfZGV2aWNlX3N1cHBvcnRzX2JhY28oYWRldi0+ZGRldikp
CisJCXJldHVybiAtRU5PVFNVUFA7CisKKwlpZiAoaXNfc3VwcG9ydF9zd19zbXUoYWRldikpIHsK
KwkJc3RydWN0IHNtdV9jb250ZXh0ICpzbXUgPSAmYWRldi0+c211OworCQlpbnQgcmV0OworCisJ
CXJldCA9IHNtdV9iYWNvX2V4aXQoc211KTsKKwkJaWYgKHJldCkKKwkJCXJldHVybiByZXQ7CisK
KwkJcmV0dXJuIDA7CisJfSBlbHNlIHsKKwkJdm9pZCAqcHBfaGFuZGxlID0gYWRldi0+cG93ZXJw
bGF5LnBwX2hhbmRsZTsKKwkJY29uc3Qgc3RydWN0IGFtZF9wbV9mdW5jcyAqcHBfZnVuY3MgPSBh
ZGV2LT5wb3dlcnBsYXkucHBfZnVuY3M7CisKKwkJaWYgKCFwcF9mdW5jcyB8fCFwcF9mdW5jcy0+
Z2V0X2FzaWNfYmFjb19zdGF0ZSB8fCFwcF9mdW5jcy0+c2V0X2FzaWNfYmFjb19zdGF0ZSkKKwkJ
CXJldHVybiAtRU5PRU5UOworCisJCS8qIGV4aXQgQkFDTyBzdGF0ZSAqLworCQlpZiAocHBfZnVu
Y3MtPnNldF9hc2ljX2JhY29fc3RhdGUocHBfaGFuZGxlLCAwKSkKKwkJCXJldHVybiAtRUlPOwor
CisJCXJldHVybiAwOworCX0KK30KLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
