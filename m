Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF7ECA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5224F217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5224F217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 165F26EAB2;
	Mon, 28 Oct 2019 21:43:53 +0000 (UTC)
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6C96EAAD
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:43:51 +0000 (UTC)
Received: by mail-yw1-xc41.google.com with SMTP id i123so4350781ywe.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sLZv/CpuD8SdrFw1dTNsk2ZH8m7VrrvAw9kvrx3mH4g=;
 b=HGe37tt3dKL/Wo4sInJfFBhdVqZcyMdU+Cg/E2E+la0c3WiMb/GQVXxeMI72Oq5b5h
 zkEXmo3SdiJ+5MP380lCamfG5epL8T3W0EUrmicgQqxhb+kWjl1gd7NXbFtgm9d/6nIj
 bu/ZHfttPZCRkd1YfU5BiJhu33zBo0BbfunGPRJuxyghsx0YQ3DJP37M8g6kzQzXVx2d
 crqUcM/hKCofxtMKb+suiwZpJPaIpSTTggphTr5R2ZA3gudcmCax2tsM6IvtmeqUiVas
 xxH6yPmSA6VnV92Y9xEe9noZTjIpKx9/nycWi6efe4PINOT2qZ0aps6/OEKr1LSOwg85
 vpoQ==
X-Gm-Message-State: APjAAAVb86ffxrcUzlPOxhW1D5XMBhHkUFGMIVs+E0GPLQy76F9IRi6U
 /zyWEHW9Bl1ss/pGx51pvVwIDjcVmgs=
X-Google-Smtp-Source: APXvYqzRIyqfLPGXVdM7ZBXjdu0HqWhPy+sLZ/zEaEtvpjA/z6ITj1KQI9opSALskUvXCy/zI20gZQ==
X-Received: by 2002:a0d:ca0e:: with SMTP id m14mr14477793ywd.292.1572299030774; 
 Mon, 28 Oct 2019 14:43:50 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:43:50 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 16/21] drm/amdgpu: enable runtime pm on BACO capable boards if
 runpm=1
Date: Mon, 28 Oct 2019 17:42:11 -0400
Message-Id: <20191028214216.1508370-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sLZv/CpuD8SdrFw1dTNsk2ZH8m7VrrvAw9kvrx3mH4g=;
 b=kBLTSpiQtXzshubpKqmIpczcHXjdKsrYZ2D8DjPJ9xI6U69JPebobKSOb1PkJLxYjD
 vhCfFRsUlnDff45at+9jQEYs180/UBlg9FTV4NN1rE/F5SGiO94PYrcZg6E7yNLWp5b7
 LZGkNXKJ/g3HUmhHk5h1sjt9XtmNUZBdUwfB4H6lfU3OY1xG15z/SkGBInsjR4PH1WCY
 3xP+vOJ3LGt6b7kjhjAt+x5pZJykygE8/qjEtTjHBnJRZ0khbBhJx2b74oYAedTbr0fd
 ao4y4MU0quqYnVAnk7N3jjy5twXAIrv32Q75lAxH+CjQua8Nn+nkXvPcg7qicTBxO5HX
 zZcQ==
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
Message-ID: <20191028214211.3L9MyY9TuBtMyWOjEEInIw4JbtPieTqbxls1nOZC3OU@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpFdmVyeXRoaW5nIGlzIGluIHBsYWNlIG5vdy4g
IE5vdCBlbmFibGVkIGJ5IGRlZmF1bHQgeWV0LiAgWW91CnN0aWxsIGhhdmUgdG8gc3BlY2lmeSBy
dW5wbT0xLgoKUmV2aWV3ZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgfCAxMSArKysrKysrLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKaW5kZXggMDZkYWUxZGU3MWQwLi5jZGI5YjFj
YWE5NjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKQEAgLTE1Nywx
MCArMTU3LDYgQEAgaW50IGFtZGdwdV9kcml2ZXJfbG9hZF9rbXMoc3RydWN0IGRybV9kZXZpY2Ug
KmRldiwgdW5zaWduZWQgbG9uZyBmbGFncykKIAkgICAgIXBjaV9pc190aHVuZGVyYm9sdF9hdHRh
Y2hlZChkZXYtPnBkZXYpKQogCQlmbGFncyB8PSBBTURfSVNfUFg7CiAKLQlpZiAoKGFtZGdwdV9y
dW50aW1lX3BtICE9IDApICYmCi0JICAgIChmbGFncyAmIEFNRF9JU19QWCkpCi0JCWFkZXYtPnJ1
bnBtID0gdHJ1ZTsKLQogCS8qIGFtZGdwdV9kZXZpY2VfaW5pdCBzaG91bGQgcmVwb3J0IG9ubHkg
ZmF0YWwgZXJyb3IKIAkgKiBsaWtlIG1lbW9yeSBhbGxvY2F0aW9uIGZhaWx1cmUgb3IgaW9tYXBw
aW5nIGZhaWx1cmUsCiAJICogb3IgbWVtb3J5IG1hbmFnZXIgaW5pdGlhbGl6YXRpb24gZmFpbHVy
ZSwgaXQgbXVzdApAQCAtMTczLDYgKzE2OSwxMyBAQCBpbnQgYW1kZ3B1X2RyaXZlcl9sb2FkX2tt
cyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB1bnNpZ25lZCBsb25nIGZsYWdzKQogCQlnb3RvIG91
dDsKIAl9CiAKKwlpZiAoYW1kZ3B1X2RldmljZV9zdXBwb3J0c19ib2NvKGRldikgJiYKKwkgICAg
KGFtZGdwdV9ydW50aW1lX3BtICE9IDApKSAvKiBlbmFibGUgcnVucG0gYnkgZGVmYXVsdCAqLwor
CQlhZGV2LT5ydW5wbSA9IHRydWU7CisJZWxzZSBpZiAoYW1kZ3B1X2RldmljZV9zdXBwb3J0c19i
YWNvKGRldikgJiYKKwkJIChhbWRncHVfcnVudGltZV9wbSA+IDApKSAvKiBlbmFibGUgcnVucG0g
aWYgcnVucG09MSAqLworCQlhZGV2LT5ydW5wbSA9IHRydWU7CisKIAkvKiBDYWxsIEFDUEkgbWV0
aG9kczogcmVxdWlyZSBtb2Rlc2V0IGluaXQKIAkgKiBidXQgZmFpbHVyZSBpcyBub3QgZmF0YWwK
IAkgKi8KLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
