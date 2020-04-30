Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A70C83002
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 07:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6001D20757
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 07:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6001D20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C1BD6EB82;
	Thu, 30 Apr 2020 07:33:16 +0000 (UTC)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F7D6EA80;
 Thu, 30 Apr 2020 03:33:44 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 8012BAE089AE068FE176;
 Thu, 30 Apr 2020 11:33:38 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Apr 2020
 11:33:28 +0800
From: Zheng Bin <zhengbin13@huawei.com>
To: <alexander.deucher@amd.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amd/display: remove set but not used variable
 'speakers' in dce_stream_encoder.c
Date: Thu, 30 Apr 2020 11:40:33 +0800
Message-ID: <20200430034034.106824-4-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20200430034034.106824-1-zhengbin13@huawei.com>
References: <20200430034034.106824-1-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 30 Apr 2020 07:33:10 +0000
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
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2Vfc3RyZWFtX2VuY29kZXIuYzoxMzM5OjExOiB3
YXJuaW5nOiB2YXJpYWJsZSDigJhzcGVha2Vyc+KAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNl
ZC1idXQtc2V0LXZhcmlhYmxlXQoKSXQgaXMgaW50cm9kdWNlZCBieSBjb21taXQgNDU2MjIzNmIz
YmMwICgiZHJtL2FtZC9kYzoKQWRkIGRjIGRpc3BsYXkgZHJpdmVyICh2MikiKSwgYnV0IG5ldmVy
IHVzZWQsIHNvIHJlbW92ZSBpdC4KClJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lAaHVh
d2VpLmNvbT4KU2lnbmVkLW9mZi1ieTogWmhlbmcgQmluIDx6aGVuZ2JpbjEzQGh1YXdlaS5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2Vfc3RyZWFtX2VuY29k
ZXIuYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX3N0cmVhbV9lbmNvZGVyLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9zdHJlYW1fZW5jb2Rlci5j
CmluZGV4IDQ1MTU3NDk3MWI5Ni4uNGNkYWFmNGQ4ODFjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9zdHJlYW1fZW5jb2Rlci5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX3N0cmVhbV9lbmNvZGVyLmMKQEAgLTEz
MzYsNyArMTMzNiw2IEBAIHN0YXRpYyB2b2lkIGRjZTExMF9zZV9hdWRpb19zZXR1cCgKIHsKIAlz
dHJ1Y3QgZGNlMTEwX3N0cmVhbV9lbmNvZGVyICplbmMxMTAgPSBEQ0UxMTBTVFJFTkNfRlJPTV9T
VFJFTkMoZW5jKTsKCi0JdWludDMyX3Qgc3BlYWtlcnMgPSAwOwogCXVpbnQzMl90IGNoYW5uZWxz
ID0gMDsKCiAJQVNTRVJUKGF1ZGlvX2luZm8pOwpAQCAtMTM0NCw3ICsxMzQzLDYgQEAgc3RhdGlj
IHZvaWQgZGNlMTEwX3NlX2F1ZGlvX3NldHVwKAogCQkvKiBUaGlzIHNob3VsZCBub3QgaGFwcGVu
Lml0IGRvZXMgc28gd2UgZG9uJ3QgZ2V0IEJTT0QqLwogCQlyZXR1cm47CgotCXNwZWFrZXJzID0g
YXVkaW9faW5mby0+ZmxhZ3MuaW5mby5BTExTUEVBS0VSUzsKIAljaGFubmVscyA9IHNwZWFrZXJz
X3RvX2NoYW5uZWxzKGF1ZGlvX2luZm8tPmZsYWdzLnNwZWFrZXJfZmxhZ3MpLmFsbDsKCiAJLyog
c2V0dXAgdGhlIGF1ZGlvIHN0cmVhbSBzb3VyY2Ugc2VsZWN0IChhdWRpbyAtPiBkaWcgbWFwcGlu
ZykgKi8KLS0KMi4yNi4wLjEwNi5nOWZhZGVkZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
