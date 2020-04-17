Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0E0C38A2B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 13:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2AF2064A
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 13:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2AF2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BE836E283;
	Fri, 17 Apr 2020 13:16:49 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E16A56E31A;
 Fri, 17 Apr 2020 10:13:42 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6C24975D03EC80580986;
 Fri, 17 Apr 2020 18:13:41 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 18:13:31 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
Subject: [PATCH -next] drm/amd/dc: remove unused variable
 'video_optimized_pixel_rates'
Date: Fri, 17 Apr 2020 18:12:47 +0800
Message-ID: <20200417101247.45616-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 17 Apr 2020 13:16:48 +0000
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
Cc: YueHaibing <yuehaibing@huawei.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX2Nsb2NrX3Nv
dXJjZS5jOjEwMTc6NTA6CiB3YXJuaW5nOiDigJh2aWRlb19vcHRpbWl6ZWRfcGl4ZWxfcmF0ZXPi
gJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcGl4ZWxfcmF0ZV9yYW5nZV90YWJsZV9lbnRyeSB2aWRlb19vcHRpbWl6
ZWRfcGl4ZWxfcmF0ZXNbXSA9IHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KCmNvbW1pdCBkOGNkNTg3
ZDJiZmQgKCJkcm0vYW1kL2Rpc3BsYXk6IHJlbW92aW5nIE1PRFVMTyBjaGFuZ2UgZm9yIGRjbjIi
KQpsZWZ0IGJlaGluZCB0aGlzIHVudXNlZCB2YWlyYWJsZSwgcmVtb3ZlIGl0LgoKU2lnbmVkLW9m
Zi1ieTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPgotLS0KIC4uLi9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNlL2RjZV9jbG9ja19zb3VyY2UuYyB8IDMzIC0tLS0tLS0tLS0tLS0tLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCAzMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9jbG9ja19zb3VyY2UuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2Nsb2NrX3NvdXJjZS5jCmluZGV4IDJlOTky
ZmJjMGQ3MS4uZDJhZDA1MDRiMGRlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGNlL2RjZV9jbG9ja19zb3VyY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNlL2RjZV9jbG9ja19zb3VyY2UuYwpAQCAtMTAxNCwzOSArMTAxNCw2IEBA
IHN0cnVjdCBwaXhlbF9yYXRlX3JhbmdlX3RhYmxlX2VudHJ5IHsKIAl1bnNpZ25lZCBzaG9ydCBk
aXZfZmFjdG9yOwogfTsKIAotc3RhdGljIGNvbnN0IHN0cnVjdCBwaXhlbF9yYXRlX3JhbmdlX3Rh
YmxlX2VudHJ5IHZpZGVvX29wdGltaXplZF9waXhlbF9yYXRlc1tdID0gewotCS8vIC8xLjAwMSBy
YXRlcwotCXsyNTE3MCwgMjUxODAsIDI1MjAwLCAxMDAwLCAxMDAxfSwJLy8yNS4yTUh6ICAgLT4g
ICAyNS4xNwotCXs1OTM0MCwgNTkzNTAsIDU5NDAwLCAxMDAwLCAxMDAxfSwJLy81OS40TWh6ICAg
LT4gICA1OS4zNDAKLQl7NzQxNzAsIDc0MTgwLCA3NDI1MCwgMTAwMCwgMTAwMX0sCS8vNzQuMjVN
aHogIC0+ICAgNzQuMTc1OAotCXsxMjU4NzAsIDEyNTg4MCwgMTI2MDAwLCAxMDAwLCAxMDAxfSwJ
Ly8xMjZNaHogICAgLT4gIDEyNS44NwotCXsxNDgzNTAsIDE0ODM2MCwgMTQ4NTAwLCAxMDAwLCAx
MDAxfSwJLy8xNDguNU1oeiAgLT4gIDE0OC4zNTE2Ci0JezE2NzgzMCwgMTY3ODQwLCAxNjgwMDAs
IDEwMDAsIDEwMDF9LAkvLzE2OE1oeiAgICAtPiAgMTY3LjgzCi0JezIyMjUyMCwgMjIyNTMwLCAy
MjI3NTAsIDEwMDAsIDEwMDF9LAkvLzIyMi43NU1oeiAtPiAgMjIyLjUyNwotCXsyNTcxNDAsIDI1
NzE1MCwgMjU3NDAwLCAxMDAwLCAxMDAxfSwJLy8yNTcuNE1oeiAgLT4gIDI1Ny4xNDI5Ci0JezI5
NjcwMCwgMjk2NzEwLCAyOTcwMDAsIDEwMDAsIDEwMDF9LAkvLzI5N01oeiAgICAtPiAgMjk2Ljcw
MzMKLQl7MzQyODUwLCAzNDI4NjAsIDM0MzIwMCwgMTAwMCwgMTAwMX0sCS8vMzQzLjJNaHogIC0+
ICAzNDIuODU3Ci0JezM5NTYwMCwgMzk1NjEwLCAzOTYwMDAsIDEwMDAsIDEwMDF9LAkvLzM5Nk1o
eiAgICAtPiAgMzk1LjYKLQl7NDA5MDkwLCA0MDkxMDAsIDQwOTUwMCwgMTAwMCwgMTAwMX0sCS8v
NDA5LjVNaHogIC0+ICA0MDkuMDkxCi0JezQ0NTA1MCwgNDQ1MDYwLCA0NDU1MDAsIDEwMDAsIDEw
MDF9LAkvLzQ0NS41TWh6ICAtPiAgNDQ1LjA1NQotCXs0Njc1MzAsIDQ2NzU0MCwgNDY4MDAwLCAx
MDAwLCAxMDAxfSwJLy80NjhNaHogICAgLT4gIDQ2Ny41MzI1Ci0JezUxOTIzMCwgNTE5MjQwLCA1
MTk3NTAsIDEwMDAsIDEwMDF9LAkvLzUxOS43NU1oeiAtPiAgNTE5LjIzMQotCXs1MjU5NzAsIDUy
NTk4MCwgNTI2NTAwLCAxMDAwLCAxMDAxfSwJLy81MjYuNU1oeiAgLT4gIDUyNS45NzQKLQl7NTQ1
NDUwLCA1NDU0NjAsIDU0NjAwMCwgMTAwMCwgMTAwMX0sCS8vNTQ2TWh6ICAgIC0+ICA1NDUuNDU1
Ci0JezU5MzQwMCwgNTkzNDEwLCA1OTQwMDAsIDEwMDAsIDEwMDF9LAkvLzU5NE1oeiAgICAtPiAg
NTkzLjQwNjYKLQl7NjIzMzcwLCA2MjMzODAsIDYyNDAwMCwgMTAwMCwgMTAwMX0sCS8vNjI0TWh6
ICAgIC0+ICA2MjMuMzc3Ci0JezY5MjMwMCwgNjkyMzEwLCA2OTMwMDAsIDEwMDAsIDEwMDF9LAkv
LzY5M01oeiAgICAtPiAgNjkyLjMwOAotCXs3MDEyOTAsIDcwMTMwMCwgNzAyMDAwLCAxMDAwLCAx
MDAxfSwJLy83MDJNaHogICAgLT4gIDcwMS4yOTg3Ci0Jezc5MTIwMCwgNzkxMjEwLCA3OTIwMDAs
IDEwMDAsIDEwMDF9LAkvLzc5Mk1oeiAgICAtPiAgNzkxLjIwOQotCXs4OTAxMDAsIDg5MDExMCwg
ODkxMDAwLCAxMDAwLCAxMDAxfSwJLy84OTFNaHogICAgLT4gIDg5MC4xMDk5Ci0JezExODY4MTAs
IDExODY4MjAsIDExODgwMDAsIDEwMDAsIDEwMDF9LC8vMTE4OE1oeiAgIC0+IDExODYuODEzMQot
Ci0JLy8gKjEuMDAxIHJhdGVzCi0JezI3MDIwLCAyNzAzMCwgMjcwMDAsIDEwMDEsIDEwMDB9LCAv
LzI3TWh6Ci0JezU0MDUwLCA1NDA2MCwgNTQwMDAsIDEwMDEsIDEwMDB9LCAvLzU0TWh6Ci0JezEw
ODEwMCwgMTA4MTEwLCAxMDgwMDAsIDEwMDEsIDEwMDB9LC8vMTA4TWh6Ci19OwotCiBzdGF0aWMg
Ym9vbCBkY24yMF9wcm9ncmFtX3BpeF9jbGsoCiAJCXN0cnVjdCBjbG9ja19zb3VyY2UgKmNsb2Nr
X3NvdXJjZSwKIAkJc3RydWN0IHBpeGVsX2Nsa19wYXJhbXMgKnBpeF9jbGtfcGFyYW1zLAotLSAK
Mi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
