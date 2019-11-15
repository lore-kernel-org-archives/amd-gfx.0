Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260D3C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0607A20723
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0607A20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6BC16E988;
	Fri, 15 Nov 2019 16:51:05 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 256FC6E958
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:50:59 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id 30so11436372qtz.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:50:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EQdQrTTJ5P/B6GAAEN4PWeFdJlxrHUCbcOO/qZCkvxM=;
 b=mQJ2fS+8ldtTaD447d1g8TFZD2MjCoZW3b+kjJ5XKZ9YlUID6WyVsv6ohRznFyeD2f
 rUcXwELpaAa9hMncRGQJNS0B1DXH7gjwruUhhRWIRuf+Sy+ZX66FJVV0gI48ZzgDRNWV
 krPBeMd3RzxQuYHIWA2/ZIV4g69/rWH2p6WvcZFpWFw5fQBkPAqklcMx7uBy6F4jSrKg
 FUvjb0P/5kcIYPzSKgFJWkqCJysx3f7TNPz4bY6GUpgat/lT+rD1eU4h7F2v7gMFsXEI
 Gy5dmJ5Y52Ii/bdkHm4Jn3ef6Iq/R++lDQlgJla+RMQ+kZbbwio74MqCAnBcy2RdXpNO
 3zQw==
X-Gm-Message-State: APjAAAWV/Po30u//c62Ej4zmA5Mf+cobliVGWxfSF2GHuhki3XxuOY9X
 itklcLhKm8xo91W0jePk1yIyUXix
X-Google-Smtp-Source: APXvYqxBQVufszcXfXS99TznWZ5iAkouT0JVCO9WW+4ZpSkVGo50+4Eu2/MPHKQnMR9qcLQQR+qmqA==
X-Received: by 2002:ac8:4157:: with SMTP id e23mr14740321qtm.158.1573836658053; 
 Fri, 15 Nov 2019 08:50:58 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:50:57 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 11/20] drm/amdgpu: add helpers for baco entry and exit
Date: Fri, 15 Nov 2019 11:50:29 -0500
Message-Id: <20191115165038.56646-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EQdQrTTJ5P/B6GAAEN4PWeFdJlxrHUCbcOO/qZCkvxM=;
 b=NJcXJKk43iH8RFmomOiA9I8sguZGg4QRMxlvsW3Q2Y3Tt3QWbwGYp8JD7Qv9sxSglY
 A8VtjtXC8vBaiJB/rZsEyMiN8XuCpFAWHLkdAZ7UZEq0sxK6H/0WagnLQ5ejgB298UhC
 0Y84k2YcokIbbrmcw6Gl4trVX7oP0xnX8m1NvfmLBCIu2YJoZC7fH2GQC5EDUB3CfBfR
 K6wEaYRT3uDHRBxbUHMB0KQocUW4+oa9AQy5y/38x+nVf0TvKDI+e31Oq1mkkvLdXsuY
 nDYOg3G5lU1+kyrIMv5JUzpGhSheqhS3wPZW/DnBVY0ty9fDB2mh1vAdd7cLQIm8coKF
 xPLw==
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
Message-ID: <20191115165029.tKsdjgqhgH27pccAin2vlT9oQhjwP0D5R45u2Jh4M30@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpXaWxsIGJlIHVzZWQgZm9yIHJ1bnRpbWUgcG0u
ICBFbnRyeSB3aWxsIGVudGVyIHRoZSBCQUNPCnN0YXRlIChjaGlwIG9mZikuICBFeGl0IHdpbGwg
ZXhpdCB0aGUgQkFDTyBzdGF0ZSAoY2hpcCBvbikuCgpSZXZpZXdlZC1ieTogRXZhbiBRdWFuIDxl
dmFuLnF1YW5AYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5o
ICAgICAgICB8ICAyICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YyB8IDYxICsrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgNjMgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5o
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKaW5kZXggMTg2MTM1ZWE2MDMz
Li42NGJjNTc3MWIzNGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCkBAIC0xMTQ1
LDYgKzExNDUsOCBAQCBib29sIGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYm9jbyhzdHJ1Y3QgZHJt
X2RldmljZSAqZGV2KTsKIGJvb2wgYW1kZ3B1X2RldmljZV9zdXBwb3J0c19iYWNvKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYpOwogYm9vbCBhbWRncHVfZGV2aWNlX2lzX3BlZXJfYWNjZXNzaWJsZShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCQkgICAgICBzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqcGVlcl9hZGV2KTsKK2ludCBhbWRncHVfZGV2aWNlX2JhY29fZW50ZXIoc3RydWN0IGRybV9k
ZXZpY2UgKmRldik7CitpbnQgYW1kZ3B1X2RldmljZV9iYWNvX2V4aXQoc3RydWN0IGRybV9kZXZp
Y2UgKmRldik7CiAKIC8qIGF0cHggaGFuZGxlciAqLwogI2lmIGRlZmluZWQoQ09ORklHX1ZHQV9T
V0lUQ0hFUk9PKQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCmlu
ZGV4IDQ1YzE5Njg0NTQ5Ny4uNzE5NWVmODNkZGJhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC00Mjk5LDMgKzQyOTksNjQgQEAgc3RhdGljIHZvaWQg
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
