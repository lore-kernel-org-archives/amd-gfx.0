Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D98C83000
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 21:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA54920731
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 21:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvYUOPal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA54920731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A7D46EB08;
	Wed, 29 Apr 2020 21:20:30 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798DF6EB08;
 Wed, 29 Apr 2020 21:20:29 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id l78so3636306qke.7;
 Wed, 29 Apr 2020 14:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kSY7Uu4S0wmE1juDzK3QkstuV4ehIxp2W1qK4v33mJ8=;
 b=IvYUOPale1yR1AEHhqbeDRbHWFePPvA6XNA5006WarUztDQqS3CJUunCKsK8wHLnuY
 x6t+UixERk6jx7GezxMivpU22/oMtSwD5U3p6Jt0bn/pLgLZpX8skwkP8gfIsE2yI+oy
 Oso8OSiFz3CzTnvC07VRsC171KGX1cT9Mue/GGCqTngZCQkkRqj3AoL+t1FPpZAn8vNM
 3NOjCW8Agib0ebAFsKMa4SC36NqANqmJk7HiwqbfNOU2ptOoDuMb2rQeMQsGOZci4Bv1
 5wTKgsGPiEMQBFLIlSR+MBqqKBPbT3OP3ZkvQbF1GkRxJtZ5T/kREmCOZ3yQnQhfFxOI
 MUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kSY7Uu4S0wmE1juDzK3QkstuV4ehIxp2W1qK4v33mJ8=;
 b=Gpj0BMQI9nAEnP5tHrZvXb1ThL/VEjBedi4PzU7dcjddmWKKni+XlTYJ5+5IVSh/a0
 KIGaewLP1tjjXbDt6CwMlAQFl1XOpiv7Jd3QSXXJgASj8yzh4egIUMVIlAS8IAJ4zKND
 DYB9U2FGDWiuXuUjL5jyzEr9vK77rHcw+8YP6rkyfJz62mS78Qv2yssIza5rRhxNIsaR
 ROe+ROv9QBgRRf+JcctYryR2j0W8uiYwUWcqGpcupE9hXNaJb3aWuUvhfVOY7BM8lfhE
 mmEZEA9Tdgy/I2gKJSQW1ML31xuKQVi9pp7pIEQ2RW4Kvb0BCDHEvs6I+g5eKKTE5AkP
 W62g==
X-Gm-Message-State: AGi0Puaq0y5KVLTHJ7Orpgnw+Uacqd7qMQT3TT2l+u7Huu6L1xa3hut9
 uYiwTYG6M5F2tB+U/HjeESAuwblH
X-Google-Smtp-Source: APiQypIvE/edKRqQPEEydmlhfIDN6BQqJOChjNpvUiwI0quFhA81qYCwAJ+WyX/TMGf3nkajuvof1A==
X-Received: by 2002:a37:a3d8:: with SMTP id m207mr436641qke.371.1588195228228; 
 Wed, 29 Apr 2020 14:20:28 -0700 (PDT)
Received: from localhost.localdomain ([71.219.72.172])
 by smtp.gmail.com with ESMTPSA id g187sm255984qkf.115.2020.04.29.14.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 14:20:27 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] amdgpu drm-fixes-5.7
Date: Wed, 29 Apr 2020 17:20:08 -0400
Message-Id: <20200429212008.4306-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgRGF2ZSwgRGFuaWVsLAoKRml4ZXMgZm9yIDUuNy4KClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBz
aW5jZSBjb21taXQgZTMyYjI0ODRiM2UwMDE3MGI2Y2Y1N2Q5OWExODk3MmUxNzRlMTBlYToKCiAg
TWVyZ2UgdGFnICdkcm0tbWlzYy1maXhlcy0yMDIwLTA0LTIzJyBvZiBnaXQ6Ly9hbm9uZ2l0LmZy
ZWVkZXNrdG9wLm9yZy9kcm0vZHJtLW1pc2MgaW50byBkcm0tZml4ZXMgKDIwMjAtMDQtMjQgMTA6
MTQ6MDQgKzEwMDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoKCiAg
Z2l0Oi8vcGVvcGxlLmZyZWVkZXNrdG9wLm9yZy9+YWdkNWYvbGludXggdGFncy9hbWQtZHJtLWZp
eGVzLTUuNy0yMDIwLTA0LTI5Cgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gYjJhN2Iw
Y2UwNzczYmZhNDQwNmJjMGE3OGU0MTk3OTUzMmExZWRkNzoKCiAgZHJtL2FtZC9kaXNwbGF5OiBV
c2UgY3Vyc29yIGxvY2tpbmcgdG8gcHJldmVudCBmbGlwIGRlbGF5cyAoMjAyMC0wNC0yOCAxNjo0
NToxNCAtMDQwMCkKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KYW1kLWRybS1maXhlcy01LjctMjAyMC0wNC0yOToKCmFtZGdw
dToKLSBGaXggYSBncmVlbiBzY3JlZW4gb24gcmVzdW1lIGlzc3VlCi0gUE0gZml4ZXMgZm9yIFNS
LUlPVgotIFNETUEgZml4IGZvciBuYXZpCi0gUmVub2lyIGRpc3BsYXkgZml4ZXMKLSBDdXJzb3Ig
YW5kIHBhZ2VmbGlwIHN0dXR0ZXJpbmcgZml4ZXMKLSBNaXNjIGFkZGl0aW9uYWwgZGlzcGxheSBm
aXhlcwoKVUFQSToKLSBBZGQgYWRkaXRpb25hbCBEQ0MgdGlsaW5nIGZsYWdzIGZvciBuYXZpMXgK
ICBVc2VkIGJ5OiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvbWVzYS9tZXNhLy0vbWVy
Z2VfcmVxdWVzdHMvNDY5NwoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpBcmljIEN5ciAoMSk6CiAgICAgIGRybS9hbWQvZGlz
cGxheTogVXNlIGN1cnNvciBsb2NraW5nIHRvIHByZXZlbnQgZmxpcCBkZWxheXMKCkF1cmFiaW5k
byBQaWxsYWkgKDEpOgogICAgICBkcm0vYW1kL2Rpc3BsYXk6IERpc3BhbHlQb3J0OiBXcml0ZSBP
VUkgb25seSBpZiBwYW5lbCBzdXBwb3J0cyBpdAoKRG15dHJvIExha3R5dXNoa2luICgyKToKICAg
ICAgZHJtL2FtZC9kaXNwbGF5OiBjaGVjayBpZiBSRUZDTEtfQ05UTCByZWdpc3RlciBpcyBwcmVz
ZW50CiAgICAgIGRybS9hbWQvZGlzcGxheTogZml4IHJuIHNvYyBiYiB1cGRhdGUKCk1hcmVrIE9s
xaHDoWsgKDMpOgogICAgICBkcm0vYW1kZ3B1OiBhZGQgdGlsaW5nIGZsYWdzIGZyb20gTWVzYQog
ICAgICBkcm0vYW1kZ3B1OiBpbnZhbGlkYXRlIEwyIGJlZm9yZSBTRE1BIElCcyAodjIpCiAgICAg
IGRybS9hbWRncHU6IGJ1bXAgdmVyc2lvbiBmb3IgaW52YWxpZGF0ZSBMMiBiZWZvcmUgU0RNQSBJ
QnMKCk5pY2hvbGFzIEthemxhdXNrYXMgKDEpOgogICAgICBkcm0vYW1kL2Rpc3BsYXk6IERlZmVy
IGN1cnNvciB1cGRhdGUgYXJvdW5kIFZVUERBVEUgZm9yIGFsbCBBU0lDCgpSb2RyaWdvIFNpcXVl
aXJhICgxKToKICAgICAgZHJtL2FtZC9kaXNwbGF5OiBGaXggZ3JlZW4gc2NyZWVuIGlzc3VlIGFm
dGVyIHN1c3BlbmQKClN1bmcgTGVlICgxKToKICAgICAgZHJtL2FtZC9kaXNwbGF5OiBVcGRhdGUg
ZG93bnNwcmVhZCBwZXJjZW50IHRvIG1hdGNoIHNwcmVhZHNoZWV0IGZvciBEQ04yLjEKClRpZWNo
ZW5nIFpob3UgKDIpOgogICAgICBSZXZlcnQgImRybS9hbWQvcG93ZXJwbGF5OiBhdm9pZCB1c2lu
ZyBwbV9lbiBiZWZvcmUgaXQgaXMgaW5pdGlhbGl6ZWQiCiAgICAgIGRybS9hbWQvcG93ZXJwbGF5
OiBhdm9pZCB1c2luZyBwbV9lbiBiZWZvcmUgaXQgaXMgaW5pdGlhbGl6ZWQgcmV2aXNlZAoKWGlh
b2RvbmcgWWFuICgxKToKICAgICAgZHJtL2FtZC9kaXNwbGF5OiBibGFuayBkcCBzdHJlYW0gYmVm
b3JlIHJlLXRyYWluIHRoZSBsaW5rCgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rydi5jICAgICAgICAgICAgfCAgMyArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2
aTEwX3NkbWFfcGt0X29wZW4uaCAgfCAxNiArKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc2RtYV92NV8wLmMgICAgICAgICAgICAgfCAxNCArKystCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jICB8IDM4ICsrKysrKysrLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMgICB8IDI3ICsrKysrKysr
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdHJlYW0uYyAgICB8IDQw
ICsrLS0tLS0tLS0tCiAuLi4vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9od19zZXF1ZW5j
ZXIuYyAgICB8ICAxICsKIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHdfc2Vx
dWVuY2VyLmMgIHwgMTAgKysrCiAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h3
X3NlcXVlbmNlci5oICB8ICAxICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24x
MC9kY24xMF9pbml0LmMgIHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
bjEwL2RjbjEwX21wYy5jICAgfCAxNSArKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjbjEwL2RjbjEwX21wYy5oICAgfCAyMCArKysrLS0KIC4uLi9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjbjEwL2RjbjEwX3Jlc291cmNlLmMgIHwgMTQgKysrLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2h3c2VxLmMgfCAgMyArLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2luaXQuYyAgfCAgMSArCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfbXBjLmMgICB8ICAxICsKIGRyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9tcGMuaCAgIHwgIDMgKy0KIC4uLi9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMgIHwgIDQgKysKIGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9pbml0LmMgIHwgIDEgKwog
Li4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYyAgfCA3NyAr
KysrKysrKysrLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5j
L2h3L21wYy5oICAgICAgICB8IDE2ICsrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvaW5jL2h3X3NlcXVlbmNlci5oICB8ICAxICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2FtZF9wb3dlcnBsYXkuYyAgICAgIHwgIDkgKy0tCiBpbmNsdWRlL3VhcGkvZHJtL2FtZGdw
dV9kcm0uaCAgICAgICAgICAgICAgICAgICAgICB8ICA0ICsrCiAyNCBmaWxlcyBjaGFuZ2VkLCAy
MTUgaW5zZXJ0aW9ucygrKSwgMTA1IGRlbGV0aW9ucygtKQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
