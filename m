Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BA3CA9EAF
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 08:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8744320717
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 08:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8744320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D90FF6E8F1;
	Wed, 30 Oct 2019 08:17:42 +0000 (UTC)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E0886E79D;
 Wed, 30 Oct 2019 06:04:37 +0000 (UTC)
Received: by mail-ot1-x343.google.com with SMTP id 53so1117049otv.4;
 Tue, 29 Oct 2019 23:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MYUu1o7Gjm7ckCy0ST4zrokOEsSb5X/Ix76ieyroiBg=;
 b=cqlUz0truvNpcSQqPEyNxHCczbKgJzx9jhzPcrIwvhbxJ8msJtbC7XHiISwzanX1Xm
 t1e5E8BnTv0dieayIE7TBE4ikD39VKrsY0XImwvbt76jh4gQLErwi7wHrUmAZNIkLDbi
 gPJvChLgEU1f3001OIryMZno87HC49SuVSqC+4a1Se4aBBo2mWSL9ouccfpZokFvCQkr
 KD8V4Q66vHsj3aUsyBmBg1tzakTayXteOWgxOhCVakBgEKjzXznNuxGsor4Hf95DFYNs
 9Vtjw4apTuuOOr1BVwM5z27Skal6cUMFk+F+VHBbVByVHhSahHVrcc2W9OXeYCAUDu9h
 3DUA==
X-Gm-Message-State: APjAAAUV3dY8fX22QfNPQuNUSbFuTFDQ4Vy/08Nsxqrv2jXiJwgNcg/L
 iOAYomXZ4XomewFQMIsXgoc=
X-Google-Smtp-Source: APXvYqyX+UhlPFCyIwKYvVsfzhxhIg1E26Bf7G5FWzbhdidLyzy1q7F7RKCzz37gAMTjxjqPDuxLHQ==
X-Received: by 2002:a9d:82e:: with SMTP id 43mr21630303oty.23.1572415475989;
 Tue, 29 Oct 2019 23:04:35 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
 by smtp.gmail.com with ESMTPSA id 34sm472147otf.55.2019.10.29.23.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 23:04:35 -0700 (PDT)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Subject: [PATCH -next] drm/amd/display: Add a conversion function for
 transmitter and phy_id enums
Date: Tue, 29 Oct 2019 23:04:11 -0700
Message-Id: <20191030060411.21168-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
X-Mailman-Approved-At: Wed, 30 Oct 2019 08:17:39 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MYUu1o7Gjm7ckCy0ST4zrokOEsSb5X/Ix76ieyroiBg=;
 b=u2vGvNxWEd7pbOofdxcD51Nta46qikqUEbSqvdYbQx3dwLyGVjuT0dz+sBt/HjyWu9
 X1OxswKBfFc5XJH8PQoFI/jPHSmjluPw/jKTIaJzAbEfKbRSrVPbeKuTq+Y6DrZBPR6g
 ORGQDV7y6CcJTFa3mGxFkZAwAOV2nsTsgbEA9R+PIU3Y+X6mcmLw+dle0TUSFUxNP4No
 9PYFYTwsNMdvqzCZMoXme3Q+kGHQOAZf5pY1Zzca+voLifsEGvMWX+7Io/z/lkP34yC0
 +AWvq5Cq2/I55/foTxl6rUzsg4KDS28bBChsrzLzVLEKGq6rouciX31QhBRMaOcUe42u
 mt6Q==
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
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Roman Li <Roman.Li@amd.com>, clang-built-linux@googlegroups.com,
 amd-gfx@lists.freedesktop.org, Nathan Chancellor <natechancellor@gmail.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030060411.pCZ_Xqevm-GQTSto-LMoVJw1-HEQVTirRAK3a9q036g@z>

Q2xhbmcgd2FybnM6CgouLi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2Rj
L2NvcmUvZGNfbGluay5jOjI1MjA6NDI6CmVycm9yOiBpbXBsaWNpdCBjb252ZXJzaW9uIGZyb20g
ZW51bWVyYXRpb24gdHlwZSAnZW51bSB0cmFuc21pdHRlcicgdG8KZGlmZmVyZW50IGVudW1lcmF0
aW9uIHR5cGUgJ2VudW0gcGh5c2ljYWxfcGh5X2lkJwpbLVdlcnJvciwtV2VudW0tY29udmVyc2lv
bl0KICAgICAgICBwc3JfY29udGV4dC0+c211UGh5SWQgPSBsaW5rLT5saW5rX2VuYy0+dHJhbnNt
aXR0ZXI7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH4gfn5+fn5+fn5+fn5+fn5+fl5+
fn5+fn5+fn5+CjEgZXJyb3IgZ2VuZXJhdGVkLgoKQXMgdGhlIGNvbW1lbnQgYWJvdmUgdGhpcyBh
c3NpZ25tZW50IHN0YXRlcywgdGhpcyBpcyBpbnRlbnRpb25hbC4gVG8KbWF0Y2ggcHJldmlvdXMg
d2FybmluZ3Mgb2YgdGhpcyBuYXR1cmUsIGFkZCBhIGNvbnZlcnNpb24gZnVuY3Rpb24gdGhhdApl
eHBsaWNpdGx5IGNvbnZlcnRzIGJldHdlZW4gdGhlIGVudW1zIGFuZCB3YXJucyB3aGVuIHRoZXJl
IGlzIGEKbWlzbWF0Y2guCgpTZWUgY29tbWl0IDgyOGNmYTI5MDkzZiAoImRybS9hbWRncHU6IEZp
eCBhbWRncHUgcmFzIHRvIHRhIGVudW1zCmNvbnZlcnNpb24iKSBhbmQgY29tbWl0IGQ5ZWM1Y2Zk
NWEyZSAoImRybS9hbWQvZGlzcGxheTogVXNlIHN3aXRjaCB0YWJsZQpmb3IgZGNfdG9fc211X2Ns
b2NrX3R5cGUiKSBmb3IgcHJldmlvdXMgZXhhbXBsZXMgb2YgdGhpcy4KCkZpeGVzOiBlMGQwOGE0
MGE2M2IgKCJkcm0vYW1kL2Rpc3BsYXk6IEFkZCBkZWJ1Z2ZzIGVudHJ5IGZvciByZWFkaW5nIHBz
ciBzdGF0ZSIpCkxpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9DbGFuZ0J1aWx0TGludXgvbGludXgv
aXNzdWVzLzc1OApTaWduZWQtb2ZmLWJ5OiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0ZWNoYW5jZWxs
b3JAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2Rj
X2xpbmsuYyB8IDM4ICsrKysrKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGNfbGluay5jCmluZGV4IDdiMTgwODdiZTU4NS4uMzhkZmU0NjBlMTNiIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jCkBAIC0yNDQ3
LDYgKzI0NDcsNDEgQEAgYm9vbCBkY19saW5rX2dldF9wc3Jfc3RhdGUoY29uc3Qgc3RydWN0IGRj
X2xpbmsgKmxpbmssIHVpbnQzMl90ICpwc3Jfc3RhdGUpCiAJcmV0dXJuIHRydWU7CiB9CiAKK3N0
YXRpYyBpbmxpbmUgZW51bSBwaHlzaWNhbF9waHlfaWQKK3RyYW5zbWl0dGVyX3RvX3BoeV9pZChl
bnVtIHRyYW5zbWl0dGVyIHRyYW5zbWl0dGVyX3ZhbHVlKQoreworCXN3aXRjaCAodHJhbnNtaXR0
ZXJfdmFsdWUpIHsKKwljYXNlIFRSQU5TTUlUVEVSX1VOSVBIWV9BOgorCQlyZXR1cm4gUEhZTERf
MDsKKwljYXNlIFRSQU5TTUlUVEVSX1VOSVBIWV9COgorCQlyZXR1cm4gUEhZTERfMTsKKwljYXNl
IFRSQU5TTUlUVEVSX1VOSVBIWV9DOgorCQlyZXR1cm4gUEhZTERfMjsKKwljYXNlIFRSQU5TTUlU
VEVSX1VOSVBIWV9EOgorCQlyZXR1cm4gUEhZTERfMzsKKwljYXNlIFRSQU5TTUlUVEVSX1VOSVBI
WV9FOgorCQlyZXR1cm4gUEhZTERfNDsKKwljYXNlIFRSQU5TTUlUVEVSX1VOSVBIWV9GOgorCQly
ZXR1cm4gUEhZTERfNTsKKwljYXNlIFRSQU5TTUlUVEVSX05VVE1FR19DUlQ6CisJCXJldHVybiBQ
SFlMRF82OworCWNhc2UgVFJBTlNNSVRURVJfVFJBVklTX0NSVDoKKwkJcmV0dXJuIFBIWUxEXzc7
CisJY2FzZSBUUkFOU01JVFRFUl9UUkFWSVNfTENEOgorCQlyZXR1cm4gUEhZTERfODsKKwljYXNl
IFRSQU5TTUlUVEVSX1VOSVBIWV9HOgorCQlyZXR1cm4gUEhZTERfOTsKKwljYXNlIFRSQU5TTUlU
VEVSX0NPVU5UOgorCQlyZXR1cm4gUEhZTERfQ09VTlQ7CisJY2FzZSBUUkFOU01JVFRFUl9VTktO
T1dOOgorCQlyZXR1cm4gUEhZTERfVU5LTk9XTjsKKwlkZWZhdWx0OgorCQlXQVJOX09OQ0UoMSwg
IlVua25vd24gdHJhbnNtaXR0ZXIgdmFsdWUgJWRcbiIsCisJCQkgIHRyYW5zbWl0dGVyX3ZhbHVl
KTsKKwkJcmV0dXJuIFBIWUxEXzA7CisJfQorfQorCiBib29sIGRjX2xpbmtfc2V0dXBfcHNyKHN0
cnVjdCBkY19saW5rICpsaW5rLAogCQljb25zdCBzdHJ1Y3QgZGNfc3RyZWFtX3N0YXRlICpzdHJl
YW0sIHN0cnVjdCBwc3JfY29uZmlnICpwc3JfY29uZmlnLAogCQlzdHJ1Y3QgcHNyX2NvbnRleHQg
KnBzcl9jb250ZXh0KQpAQCAtMjUxNyw3ICsyNTUyLDggQEAgYm9vbCBkY19saW5rX3NldHVwX3Bz
cihzdHJ1Y3QgZGNfbGluayAqbGluaywKIAkvKiBIYXJkY29kZWQgZm9yIG5vdy4gIENhbiBiZSBQ
Y2llIG9yIFVuaXBoeSAob3IgVW5rbm93bikqLwogCXBzcl9jb250ZXh0LT5waHlUeXBlID0gUEhZ
X1RZUEVfVU5JUEhZOwogCS8qUGh5SWQgaXMgYXNzb2NpYXRlZCB3aXRoIHRoZSB0cmFuc21pdHRl
ciBpZCovCi0JcHNyX2NvbnRleHQtPnNtdVBoeUlkID0gbGluay0+bGlua19lbmMtPnRyYW5zbWl0
dGVyOworCXBzcl9jb250ZXh0LT5zbXVQaHlJZCA9CisJCXRyYW5zbWl0dGVyX3RvX3BoeV9pZChs
aW5rLT5saW5rX2VuYy0+dHJhbnNtaXR0ZXIpOwogCiAJcHNyX2NvbnRleHQtPmNydGNUaW1pbmdW
ZXJ0aWNhbFRvdGFsID0gc3RyZWFtLT50aW1pbmcudl90b3RhbDsKIAlwc3JfY29udGV4dC0+dnN5
bmNSYXRlSHogPSBkaXY2NF91NjQoZGl2NjRfdTY0KChzdHJlYW0tPgotLSAKMi4yNC4wLnJjMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
