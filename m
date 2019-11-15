Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB86C43215
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E99A20723
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E99A20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51DAF6E955;
	Fri, 15 Nov 2019 16:50:54 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331D16E673
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:50:53 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id n12so4028235qvt.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qucmBK8296Afdjp1xdtDTe1Y7Yf+ZSue6Gan8Ja2z+8=;
 b=cTlKD0TXjNhed/Z7NpLEdMsAQtiTrfj2M/ANCE36OI6v/e9NVXTUIvxiFftAgfOJJl
 DFxwyzCqi27jBExIS7A8Rrdq6wSbCKzKoZyGSwdgGj1n+dhk6d1SEYeere+w5eRlWySU
 ZRfs+1s45+nJa4jABb7dbkVdJ7JVNMgPrh/MV3cuMZiZGlyfTmKo//IRIl5mkKvzFIWM
 R3a4gpq6sCn2j3RlhA95EgowPimi+g6Kn4ZPuGIiZ/m2rSn3rA3YwqTgSbL/NcTsTPFa
 FwqwOcLyFoX2/aiGltuhDQydwd0I6ehcI5J3BeOThuxZGklBzFji698Sfk7x1bYL/UNb
 ioQA==
X-Gm-Message-State: APjAAAVrUZlKgkq0XNFrViRA3FQ9jEHO3vZV3dOdKn3eNHmbANQqK2+U
 eVVfAZIlN1vmhGoqvinDwr9xJPFe
X-Google-Smtp-Source: APXvYqxOmZQ/YLV125C7CUYMTHM4y44e2H+5q5R9/bMsVcMDYkOC/tK9M/rmISJNXBSaliKOavMqKw==
X-Received: by 2002:ad4:458b:: with SMTP id x11mr7447279qvu.7.1573836652072;
 Fri, 15 Nov 2019 08:50:52 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:50:51 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 05/20] drm/amdgpu: add supports_baco callback for VI asics.
Date: Fri, 15 Nov 2019 11:50:23 -0500
Message-Id: <20191115165038.56646-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qucmBK8296Afdjp1xdtDTe1Y7Yf+ZSue6Gan8Ja2z+8=;
 b=etDYjVfvaiTiq8LoZFp+pbpIrY63as90VwFoWaW2w0BLbvRngxjyOjoTDF/J0jNjq0
 bm0occN8G+tEtnaory1GUBqcZ3G+ohdGur+c+Dq7/2bwdATs6V1YaTwAaiRSmvEY5PrQ
 met8QnRff2gjc9OjS8ulAlKWqqb62pgf9tu6VXfALtArEktRGaTSDoIP1xnr8bzPxka/
 CasAvql4//VG1EGtw0PsZoesYX/uZqWrl6lbGW9w56r2qkNkuxJHX8EWqLkGJp+8Re7h
 296UtSjjpDVv6JIQAXtQvcTsnxM07tZOfRYy5DfROzVPFz1se50crmxxJkCoeOMNV+NA
 p7rA==
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
Message-ID: <20191115165023.q3cqUJ6WImkS-Jt9t6oSCUXkfzXjcINVGKyyO-UdQ_M@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpDaGVjayB0aGUgQkFDTyBjYXBhYmlsaXRpZXMg
ZnJvbSB0aGUgcG93ZXJwbGF5IHRhYmxlLgoKUmV2aWV3ZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5x
dWFuQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jIHwgMjIgKysr
KysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmkuYwppbmRleCA3OGU1Y2RjMGMwNTguLjg3MWMwYjhjNmIwYiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS92aS5jCkBAIC03NDUsNiArNzQ1LDI3IEBAIHN0YXRpYyBpbnQgdmlf
YXNpY19wY2lfY29uZmlnX3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCXJldHVy
biByOwogfQogCitzdGF0aWMgYm9vbCB2aV9hc2ljX3N1cHBvcnRzX2JhY28oc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCit7CisJYm9vbCBiYWNvX3N1cHBvcnQ7CisKKwlzd2l0Y2ggKGFkZXYt
PmFzaWNfdHlwZSkgeworCWNhc2UgQ0hJUF9GSUpJOgorCWNhc2UgQ0hJUF9UT05HQToKKwljYXNl
IENISVBfUE9MQVJJUzEwOgorCWNhc2UgQ0hJUF9QT0xBUklTMTE6CisJY2FzZSBDSElQX1BPTEFS
SVMxMjoKKwljYXNlIENISVBfVE9QQVo6CisJCXNtdTdfYXNpY19nZXRfYmFjb19jYXBhYmlsaXR5
KGFkZXYsICZiYWNvX3N1cHBvcnQpOworCQlicmVhazsKKwlkZWZhdWx0OgorCQliYWNvX3N1cHBv
cnQgPSBmYWxzZTsKKwkJYnJlYWs7CisJfQorCisJcmV0dXJuIGJhY29fc3VwcG9ydDsKK30KKwog
c3RhdGljIGVudW0gYW1kX3Jlc2V0X21ldGhvZAogdmlfYXNpY19yZXNldF9tZXRob2Qoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CkBAIC0xMTE2LDYgKzExMzcsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGFtZGdwdV9hc2ljX2Z1bmNzIHZpX2FzaWNfZnVuY3MgPQogCS5nZXRfcGNpZV91
c2FnZSA9ICZ2aV9nZXRfcGNpZV91c2FnZSwKIAkubmVlZF9yZXNldF9vbl9pbml0ID0gJnZpX25l
ZWRfcmVzZXRfb25faW5pdCwKIAkuZ2V0X3BjaWVfcmVwbGF5X2NvdW50ID0gJnZpX2dldF9wY2ll
X3JlcGxheV9jb3VudCwKKwkuc3VwcG9ydHNfYmFjbyA9ICZ2aV9hc2ljX3N1cHBvcnRzX2JhY28s
CiB9OwogCiAjZGVmaW5lIENaX1JFVl9CUklTVE9MKHJldikJIFwKLS0gCjIuMjMuMAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
