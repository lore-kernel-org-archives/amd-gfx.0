Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C8FC1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F912076A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po5MnDKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F912076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6FE56E879;
	Wed, 25 Mar 2020 15:20:23 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D2F6E879
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 15:20:22 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id c81so2895558wmd.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SWqbPGWK93FlJzuUBlN43kKP46R8Axekrd2GqBO2O58=;
 b=Po5MnDKdRq1kV5FfQ2+NogsK/AiDLVqTymuDKDY7bTVvDisbZzBAXC8hkJiqfNoAmX
 EYXmODAt7Px4nGzESMEFwKXnhb5hlggLjryWS5rw+ZJcbNVr634rl9a9yj/QJadbbpRQ
 n4ntx8xkXux9b8thb420gxIMwCwzM/7yomDA3Up+0ieXmRvcoupqgYl89iDB5oZg5x3C
 34AvoAXLADJZjKilfiNLUFd4cFMK8vqstvtKxEaTcFT+oj+8EqvRoaHCXGBTtc1OQlQ6
 kLtUJcij+q4faVLaBYdJntP6xBTbKrytnkpm4ZIPEEXJ/P+IXXBBTo6FtSKmjA1k+JuX
 CV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SWqbPGWK93FlJzuUBlN43kKP46R8Axekrd2GqBO2O58=;
 b=gqZL0VPAAkADOg4Q0U/xxX2WThJRp9DpwsRhQPxkGsM0FZsDx0j+cYMLFT89ijaumX
 MCVjaWp0RUcsuOuAymcUEINg5wbTtS/nv1DlfBoaszPv5ZJSiQV1IsQI/qNcbkCZ/pJ5
 jvC7gCSqwfgaFvtZDv9ixN0a4H7RS7vxklthd7bniw+v8xPGly1plOJlwFikwhhI4RUX
 gF5tN/tqBycA8+OMqSHkwD1vE/BG2oeE5dUfP0AqQP6rj4x2hBjRSSHxy06VUeAWnl1L
 SnOBkHjJFYE7uVLjzNjyPg1XB1Z42StYucyC3TdufOQsiUbrqrBhpfwJpWYmo0LzAZDe
 OWxg==
X-Gm-Message-State: ANhLgQ0PjmByTWLUyYLXfPHqchaHqEARPfos4EAoVFdaMfx4apbHQA4j
 9fNvw2VwSFUqhCaIjI6JuFKa1n2h
X-Google-Smtp-Source: ADFU+vtk2U66vgbBBkx0HIBT5WXhObjaAzXplvDP6W3rFcHNw3npoTx27iMP4CI6F4to25QYWmGCzA==
X-Received: by 2002:a7b:c0d7:: with SMTP id s23mr3972031wmh.104.1585149620886; 
 Wed, 25 Mar 2020 08:20:20 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F2F7F00F7F461FB9D1716C0.dip0.t-ipconnect.de.
 [2003:c5:8f2f:7f00:f7f4:61fb:9d17:16c0])
 by smtp.gmail.com with ESMTPSA id r3sm35150794wrm.35.2020.03.25.08.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 08:20:19 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: add missing if clause guard
Date: Wed, 25 Mar 2020 16:24:25 +0100
Message-Id: <20200325152425.43179-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com,
 Monk.Liu@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXM6IDYzNWYzNzkwYWM5NjQgKGRybS9hbWRncHU6IGRvbid0IHRyeSB0byByZXNlcnZlIHRy
YWluaW5nIGJvIGZvciBzcmlvdikKCmNvbXBpbGF0aW9uIHdhcm5pbmc6CmRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYzogSW4gZnVuY3Rpb24g4oCYYW1kZ3B1X3R0bV9pbml0
4oCZOgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmM6MTg2MjoyOiB3YXJu
aW5nOiB0aGlzIOKAmGlm4oCZIGNsYXVzZSBkb2VzIG5vdCBndWFyZC4uLiBbLVdtaXNsZWFkaW5n
LWluZGVudGF0aW9uXQogMTg2MiB8ICBpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkKClNpZ25l
ZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90dG0uYwppbmRleCA1NGNmYTNhMTIxMzUuLmUxOTI1NTdkYjQyMSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwpAQCAtMTg1OSwxMCArMTg1OSwxMSBAQCBpbnQg
YW1kZ3B1X3R0bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCSAqVGhlIHJlc2Vy
dmVkIHZyYW0gZm9yIG1lbW9yeSB0cmFpbmluZyBtdXN0IGJlIHBpbm5lZCB0byB0aGUgc3BlY2lm
aWVkCiAJICpwbGFjZSBvbiB0aGUgVlJBTSwgc28gcmVzZXJ2ZSBpdCBlYXJseS4KIAkgKi8KLQlp
ZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkKKwlpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkg
ewogCQlyID0gYW1kZ3B1X3R0bV90cmFpbmluZ19yZXNlcnZlX3ZyYW1faW5pdChhZGV2KTsKIAkJ
aWYgKHIpCiAJCQlyZXR1cm4gcjsKKwl9CiAKIAkvKiBhbGxvY2F0ZSBtZW1vcnkgYXMgcmVxdWly
ZWQgZm9yIFZHQQogCSAqIFRoaXMgaXMgdXNlZCBmb3IgVkdBIGVtdWxhdGlvbiBhbmQgcHJlLU9T
IHNjYW5vdXQgYnVmZmVycyB0bwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
