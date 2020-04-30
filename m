Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F58C83003
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 02:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D350620787
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 02:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D350620787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F9CA6E898;
	Thu, 30 Apr 2020 02:23:29 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEA226E445;
 Thu, 30 Apr 2020 02:19:58 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 981A8DF9313ABED9D2D9;
 Thu, 30 Apr 2020 10:19:54 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Apr 2020
 10:19:44 +0800
From: Zheng Bin <zhengbin13@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: remove set but not used variable 'priority'
Date: Thu, 30 Apr 2020 10:26:51 +0800
Message-ID: <20200430022653.46365-2-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20200430022653.46365-1-zhengbin13@huawei.com>
References: <20200430022653.46365-1-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 30 Apr 2020 02:23:26 +0000
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
Cc: zhengbin13@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmM6MTIxMToyNjogd2FybmluZzogdmFyaWFibGUg
4oCYcHJpb3JpdHnigJkgc2V0IGJ1dCBub3QgdXNlZAoKSXQgaXMgbm90IHVzZWQgc2luY2UgY29t
bWl0IDMzYWJjYjFmNWExNyAoImRybS9hbWRncHU6CnNldCBjb21wdXRlIHF1ZXVlIHByaW9yaXR5
IGF0IG1xZF9pbml0IikKClJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lAaHVhd2VpLmNv
bT4KU2lnbmVkLW9mZi1ieTogWmhlbmcgQmluIDx6aGVuZ2JpbjEzQGh1YXdlaS5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgfCAyIC0tCiAxIGZpbGUgY2hh
bmdlZCwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfY3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5j
CmluZGV4IDc2NTNmNjJiMWIyZC4uMTkwNzAyMjZhOTQ1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfY3MuYwpAQCAtMTIwOCw3ICsxMjA4LDYgQEAgc3RhdGljIGludCBhbWRncHVf
Y3Nfc3VibWl0KHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLAogewogCXN0cnVjdCBhbWRncHVf
ZnByaXYgKmZwcml2ID0gcC0+ZmlscC0+ZHJpdmVyX3ByaXY7CiAJc3RydWN0IGRybV9zY2hlZF9l
bnRpdHkgKmVudGl0eSA9IHAtPmVudGl0eTsKLQllbnVtIGRybV9zY2hlZF9wcmlvcml0eSBwcmlv
cml0eTsKIAlzdHJ1Y3QgYW1kZ3B1X2JvX2xpc3RfZW50cnkgKmU7CiAJc3RydWN0IGFtZGdwdV9q
b2IgKmpvYjsKIAl1aW50NjRfdCBzZXE7CkBAIC0xMjU4LDcgKzEyNTcsNiBAQCBzdGF0aWMgaW50
IGFtZGdwdV9jc19zdWJtaXQoc3RydWN0IGFtZGdwdV9jc19wYXJzZXIgKnAsCgogCXRyYWNlX2Ft
ZGdwdV9jc19pb2N0bChqb2IpOwogCWFtZGdwdV92bV9ib190cmFjZV9jcygmZnByaXYtPnZtLCAm
cC0+dGlja2V0KTsKLQlwcmlvcml0eSA9IGpvYi0+YmFzZS5zX3ByaW9yaXR5OwogCWRybV9zY2hl
ZF9lbnRpdHlfcHVzaF9qb2IoJmpvYi0+YmFzZSwgZW50aXR5KTsKCiAJYW1kZ3B1X3ZtX21vdmVf
dG9fbHJ1X3RhaWwocC0+YWRldiwgJmZwcml2LT52bSk7Ci0tCjIuMjYuMC4xMDYuZzlmYWRlZGQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
