Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F92CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 13:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D938214B2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 13:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D938214B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4E0C6E86C;
	Mon, 28 Oct 2019 13:37:50 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F125B6E86C;
 Mon, 28 Oct 2019 13:36:43 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 329F9FADBF5561FE308D;
 Mon, 28 Oct 2019 21:36:38 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 28 Oct 2019
 21:36:30 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <rex.zhu@amd.com>, <evan.quan@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <David1.Zhou@amd.com>, <airlied@linux.ie>,
 <daniel@ffwll.ch>
Subject: [PATCH 3/3] drm/amd/powerplay: Make two functions static
Date: Mon, 28 Oct 2019 21:36:21 +0800
Message-ID: <20191028133621.21400-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 28 Oct 2019 13:37:50 +0000
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
Cc: YueHaibing <yuehaibing@huawei.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028133621.5N-AcQ406gBFfUzRwf3U1O3kL__BZbFpVG_SSLsmHDw@z>

Rml4IHNwYXJzZSB3YXJuaW5nczoKCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3Bvd2Vy
cGxheS9hcmN0dXJ1c19wcHQuYzoyMDUwOjU6CiB3YXJuaW5nOiBzeW1ib2wgJ2FyY3R1cnVzX2ky
Y19lZXByb21fY29udHJvbF9pbml0JyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQgYmUgc3Rh
dGljPwpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wb3dlcnBsYXkvYXJjdHVydXNfcHB0
LmM6MjA2ODo2Ogogd2FybmluZzogc3ltYm9sICdhcmN0dXJ1c19pMmNfZWVwcm9tX2NvbnRyb2xf
ZmluaScgd2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8KClJlcG9ydGVkLWJ5
OiBIdWxrIFJvYm90IDxodWxrY2lAaHVhd2VpLmNvbT4KU2lnbmVkLW9mZi1ieTogWXVlSGFpYmlu
ZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2FyY3R1cnVzX3BwdC5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2FyY3R1cnVzX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJj
dHVydXNfcHB0LmMKaW5kZXggZDQ4YTQ5ZC4uMzA5OWFjMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKQEAgLTIwNDcsNyArMjA0Nyw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgaTJjX2FsZ29yaXRobSBhcmN0dXJ1c19pMmNfZWVwcm9tX2kyY19hbGdv
ID0gewogCS5mdW5jdGlvbmFsaXR5ID0gYXJjdHVydXNfaTJjX2VlcHJvbV9pMmNfZnVuYywKIH07
CiAKLWludCBhcmN0dXJ1c19pMmNfZWVwcm9tX2NvbnRyb2xfaW5pdChzdHJ1Y3QgaTJjX2FkYXB0
ZXIgKmNvbnRyb2wpCitzdGF0aWMgaW50IGFyY3R1cnVzX2kyY19lZXByb21fY29udHJvbF9pbml0
KHN0cnVjdCBpMmNfYWRhcHRlciAqY29udHJvbCkKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IHRvX2FtZGdwdV9kZXZpY2UoY29udHJvbCk7CiAJaW50IHJlczsKQEAgLTIwNjUsNyAr
MjA2NSw3IEBAIGludCBhcmN0dXJ1c19pMmNfZWVwcm9tX2NvbnRyb2xfaW5pdChzdHJ1Y3QgaTJj
X2FkYXB0ZXIgKmNvbnRyb2wpCiAJcmV0dXJuIHJlczsKIH0KIAotdm9pZCBhcmN0dXJ1c19pMmNf
ZWVwcm9tX2NvbnRyb2xfZmluaShzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmNvbnRyb2wpCitzdGF0aWMg
dm9pZCBhcmN0dXJ1c19pMmNfZWVwcm9tX2NvbnRyb2xfZmluaShzdHJ1Y3QgaTJjX2FkYXB0ZXIg
KmNvbnRyb2wpCiB7CiAJaTJjX2RlbF9hZGFwdGVyKGNvbnRyb2wpOwogfQotLSAKMi43LjQKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
