Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A561CA9EC1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F43217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F43217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDDC46EAAD;
	Mon, 28 Oct 2019 21:43:55 +0000 (UTC)
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55E876EAC3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:43:54 +0000 (UTC)
Received: by mail-yw1-xc41.google.com with SMTP id v5so159204ywd.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CWZrm86EYWE5tSdL+2GWYcKokLwlyLKtZplRBnKgV38=;
 b=DnT0tQhHhD2dI1A7+ElILJrFhyC0sorInXWSgYH4VkgaBGpP6jaaWHKhcr59LteNI4
 KhXZRtnJHclx66jzbmtE+C54NuYwdv7XbqpgSFkroo0XSm1OmY2+jYx2Oo7BjfUKt2Gx
 qsfI4/EggE6LTChiVwbs88JaYXMmJqkYjA6mJVRI8VoKP4ykTXaaRHZ6btrlaZQ+0gzp
 BqrMEJp6CPJvbFENjhHU07Ddr8UWnqlm+KDyASNssOyP/gCiVNdEcn5o9dVXuasQyEZY
 YaD3hPU7EZFxrP2ERqXpkI3hFLvyymY7HxqJ6sPz7aB8vD1/jDB4X+0fhY++i+Gdw/ht
 AUTQ==
X-Gm-Message-State: APjAAAWHbhlfwxjYbVBWjjz5FQuIg0/iwqT71KdQnGDkd8J+BrUNPCNm
 3pb8rURlef8dls3HVnOmevuWO2UOKnM=
X-Google-Smtp-Source: APXvYqyzgQb5T9V0F/VHF4Uy4pbYjowbEgK6tF1/eOpR3dtb5MyG3bAkHpUCBhkEnONE4E9jyv5FDQ==
X-Received: by 2002:a81:c214:: with SMTP id z20mr14391744ywc.170.1572299033192; 
 Mon, 28 Oct 2019 14:43:53 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:43:52 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 17/21] drm/amdgpu/runpm: enable runpm on baco capable VI+ asics
Date: Mon, 28 Oct 2019 17:42:12 -0400
Message-Id: <20191028214216.1508370-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CWZrm86EYWE5tSdL+2GWYcKokLwlyLKtZplRBnKgV38=;
 b=QwRFUTxuoTS6fLYPUcpL0+YIe3TDrEK0pLO3t07rzEq/PkbaYmu9SfdOtS+0f5rV9m
 N3MWenmX1sLm8rnoGGBgm2T9WTpTGiY4ZPymoXMt9dsNors7YWQE8Z+J8wUK/znW1qtY
 y2+019ISnq+P1RitC1U6Nvp/VUCMDWkUSfI87Yo/qBeQRMhLeaQM7k1tf2Ycy68VbQdo
 y4eGHOKP9+GPuQimHfOampbWYqfXt/GyVUaMmgUzyesoZZXs5jHbymt6LUrKmBtLeJoc
 YL6CXpuMfVME/cJQmjZ93+yclQCNKxuZMkXBc+EhRiViuQzwApjRfxnim2Oe9dleVU3k
 +yaQ==
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
Message-ID: <20191028214212.7ZKhqIhoC-KDPOG7YK3YGrgIcrI6SRWsSqODfyuNznQ@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpTZWVtcyB0byB3b3JrIHJlbGlhYmx5IG9uIFZJ
Ky4KClJldmlld2VkLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgOCArKysrKystLQogMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfa21zLmMKaW5kZXggY2RiOWIxY2FhOTYyLi5lZTNlOTE5NGRkNDMgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKQEAgLTE3MCwxMCArMTcwLDE0
IEBAIGludCBhbWRncHVfZHJpdmVyX2xvYWRfa21zKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHVu
c2lnbmVkIGxvbmcgZmxhZ3MpCiAJfQogCiAJaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYm9j
byhkZXYpICYmCi0JICAgIChhbWRncHVfcnVudGltZV9wbSAhPSAwKSkgLyogZW5hYmxlIHJ1bnBt
IGJ5IGRlZmF1bHQgKi8KKwkgICAgKGFtZGdwdV9ydW50aW1lX3BtICE9IDApKSAvKiBlbmFibGUg
cnVucG0gYnkgZGVmYXVsdCBmb3IgYm9jbyAqLwogCQlhZGV2LT5ydW5wbSA9IHRydWU7CiAJZWxz
ZSBpZiAoYW1kZ3B1X2RldmljZV9zdXBwb3J0c19iYWNvKGRldikgJiYKLQkJIChhbWRncHVfcnVu
dGltZV9wbSA+IDApKSAvKiBlbmFibGUgcnVucG0gaWYgcnVucG09MSAqLworCQkgKGFtZGdwdV9y
dW50aW1lX3BtICE9IDApICYmCisJCSAoYWRldi0+YXNpY190eXBlID49IENISVBfVE9QQVopKSAv
KiBlbmFibGUgcnVucG0gYnkgZGVmYXVsdCBvbiBWSSsgKi8KKwkJYWRldi0+cnVucG0gPSB0cnVl
OworCWVsc2UgaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYmFjbyhkZXYpICYmCisJCSAoYW1k
Z3B1X3J1bnRpbWVfcG0gPiAwKSkgIC8qIGVuYWJsZSBydW5wbSBpZiBydW5wbT0xIG9uIENJICov
CiAJCWFkZXYtPnJ1bnBtID0gdHJ1ZTsKIAogCS8qIENhbGwgQUNQSSBtZXRob2RzOiByZXF1aXJl
IG1vZGVzZXQgaW5pdAotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
