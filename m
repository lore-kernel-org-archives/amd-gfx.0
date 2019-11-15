Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AE3C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0504120723
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0504120723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B36036E9B7;
	Fri, 15 Nov 2019 16:51:11 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 048476E996
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:51:04 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id e2so8627832qkn.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V7ZdfhhqdvYJzhCUEQRl60vWylsE5pgMI3gw5YsZa2o=;
 b=AQfdb2PjS0Bxe/76im0foqVK6birwMYXdwiOU2DwddrGCxPGX1PhY/34mKOx6C5I7q
 YPdPTq7G1im6rfppOD1raRAdA7DpxjKVMegZanj7tIhOdwvJ8LWqePxhp+ZSWGHwZQuZ
 hGMLAhrH2SMFUUZQq9E0UwO+ju8V9nMhslHhITQTtVql2P/JRriHp1WUK7FTLpPK2j/R
 gki411rAvdbckBBdGKc9Cca8ZXK8NoihB1l/MyKaPWU8iOvPBbvAg29Lk01Q36jkgQ+P
 gGlhnQqBWh013E3YAnnQ/oetJ96hSAqRmyLoxtX2TTfaa2SgxRBZaGxcWq+nIQHxvhYO
 A/Ag==
X-Gm-Message-State: APjAAAV1Bl+eS20hGT1eYaL8I3ZkuOGRmuZWEjVeACh/EjX1lmzMHtIe
 9R3b1iuteRJ6rlG+5s6mDf3eiYsY
X-Google-Smtp-Source: APXvYqzcIhdVc4bJywDxYq7AVOgx9WVhow/n3VbrTO6LuUdTpb4ti05PVMegwqt4WObHkVwB0Ce9iw==
X-Received: by 2002:ae9:e649:: with SMTP id x9mr5286432qkl.220.1573836662861; 
 Fri, 15 Nov 2019 08:51:02 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:51:02 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 16/20] drm/amdgpu/runpm: enable runpm on baco capable VI+
 asics (v2)
Date: Fri, 15 Nov 2019 11:50:34 -0500
Message-Id: <20191115165038.56646-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V7ZdfhhqdvYJzhCUEQRl60vWylsE5pgMI3gw5YsZa2o=;
 b=s31EjNVKITptRLLAnfHSu6VI0DABHc+xMC74IW3G268jvgR1XGBshIJY5HKb3ibxMt
 nwte8o8PoXk5Z+0MXyyAUh6AuTrCth2peOzPXmLPeKULj4niZYJdc3Khmv6J7jZ6eW/A
 sQcaVwRbP6Der9ST0BsH1TTkj12KZBi/2FwMeVCHyUTi7NeJTue4px0yLxN3BnvwP3Mm
 UpptW9Ar3Dk69xs+lxpam9tjqdryoBs+tNE0ofENXslypZDC5kuRZZp7Be49sFFjpcgR
 NIgPubxf//GLXtQq9b/D0RVs0YhwIdCIv+gNVs+yLcVy1J//9SfvUvSGeNW84/F03LM/
 dmVg==
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
Message-ID: <20191115165034.gIHmUZdNPtE_lnQ1khQ0MgAo2f2QkiizJ1t7zDyLsRE@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpXb3JrcyByZWxpYWJseSBvbiBWSSwgdmVnYS4K
CnYyOiBkb24ndCBlbmFibGUgb24gbmF2aSB5ZXQuCgpSZXZpZXdlZC1ieTogRXZhbiBRdWFuIDxl
dmFuLnF1YW5AYW1kLmNvbT4gKHYxKQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ttcy5jIHwgOSArKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2ttcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCmlu
ZGV4IDE2OWRiOTQxZjkzMy4uMGMxMjJmZjJhN2QwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2ttcy5jCkBAIC0xNzAsMTAgKzE3MCwxNSBAQCBpbnQgYW1kZ3B1X2RyaXZlcl9s
b2FkX2ttcyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB1bnNpZ25lZCBsb25nIGZsYWdzKQogCX0K
IAogCWlmIChhbWRncHVfZGV2aWNlX3N1cHBvcnRzX2JvY28oZGV2KSAmJgotCSAgICAoYW1kZ3B1
X3J1bnRpbWVfcG0gIT0gMCkpIC8qIGVuYWJsZSBydW5wbSBieSBkZWZhdWx0ICovCisJICAgIChh
bWRncHVfcnVudGltZV9wbSAhPSAwKSkgLyogZW5hYmxlIHJ1bnBtIGJ5IGRlZmF1bHQgZm9yIGJv
Y28gKi8KIAkJYWRldi0+cnVucG0gPSB0cnVlOwogCWVsc2UgaWYgKGFtZGdwdV9kZXZpY2Vfc3Vw
cG9ydHNfYmFjbyhkZXYpICYmCi0JCSAoYW1kZ3B1X3J1bnRpbWVfcG0gPiAwKSkgLyogZW5hYmxl
IHJ1bnBtIGlmIHJ1bnBtPTEgKi8KKwkJIChhbWRncHVfcnVudGltZV9wbSAhPSAwKSAmJgorCQkg
KGFkZXYtPmFzaWNfdHlwZSA+PSBDSElQX1RPUEFaKSAmJgorCQkgKGFkZXYtPmFzaWNfdHlwZSA8
PSBDSElQX1ZFR0EyMCkpIC8qIGVuYWJsZSBydW5wbSBieSBkZWZhdWx0IG9uIFZJLCB2ZWdhICov
CisJCWFkZXYtPnJ1bnBtID0gdHJ1ZTsKKwllbHNlIGlmIChhbWRncHVfZGV2aWNlX3N1cHBvcnRz
X2JhY28oZGV2KSAmJgorCQkgKGFtZGdwdV9ydW50aW1lX3BtID4gMCkpICAvKiBlbmFibGUgcnVu
cG0gaWYgcnVucG09MSBvbiBDSSwgTlYgKi8KIAkJYWRldi0+cnVucG0gPSB0cnVlOwogCiAJLyog
Q2FsbCBBQ1BJIG1ldGhvZHM6IHJlcXVpcmUgbW9kZXNldCBpbml0Ci0tIAoyLjIzLjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
