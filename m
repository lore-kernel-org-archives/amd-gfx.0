Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3873C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 08:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83BFC20818
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 08:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BFC20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95B3C6E853;
	Mon, 11 Nov 2019 08:09:42 +0000 (UTC)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 771DE6E11B;
 Mon, 11 Nov 2019 04:02:13 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id AA57C6AAD5EFC3DB08D5;
 Mon, 11 Nov 2019 12:02:11 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 11 Nov 2019
 12:02:04 +0800
From: zhengbin <zhengbin13@huawei.com>
To: <rex.zhu@amd.com>, <evan.quan@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <David1.Zhou@amd.com>, <airlied@linux.ie>,
 <daniel@ffwll.ch>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: remove set but not used variable
 'threshold', 'state'
Date: Mon, 11 Nov 2019 12:09:28 +0800
Message-ID: <1573445368-132319-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 11 Nov 2019 08:09:41 +0000
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
Cc: zhengbin13@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111040928.Xni1WfVEYiu-uUF1yFPTamrKBhPiqwvwk022oBoBJgM@z>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL2Zpamlfc211bWdyLmM6IEluIGZ1bmN0aW9uIGZp
amlfcG9wdWxhdGVfc2luZ2xlX2dyYXBoaWNfbGV2ZWw6CmRyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L3NtdW1nci9maWppX3NtdW1nci5jOjk0MzoxMTogd2FybmluZzogdmFyaWFibGUgdGhy
ZXNob2xkIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCmRyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9maWppX3NtdW1nci5jOiBJbiBmdW5jdGlv
biBmaWppX3BvcHVsYXRlX21lbW9yeV90aW1pbmdfcGFyYW1ldGVyczoKZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvc211bWdyL2Zpamlfc211bWdyLmM6MTUwNDo4OiB3YXJuaW5nOiB2YXJp
YWJsZSBzdGF0ZSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQoK
VGhleSBhcmUgaW50cm9kdWNlZCBieSBjb21taXQgMmUxMTJiNGFlM2JhICgiZHJtL2FtZC9wcDoK
cmVtb3ZlIGZpamlfc21jL3NtdW1nciBzcGxpdC4iKSwgYnV0IG5ldmVyIHVzZWQsCnNvIHJlbW92
ZSBpdC4KClJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lAaHVhd2VpLmNvbT4KU2lnbmVk
LW9mZi1ieTogemhlbmdiaW4gPHpoZW5nYmluMTNAaHVhd2VpLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvZmlqaV9zbXVtZ3IuYyB8IDcgKystLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvZmlqaV9zbXVtZ3IuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9maWppX3NtdW1nci5jCmluZGV4IGRh
MDI1YjEuLjMyZWJiMzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L3NtdW1nci9maWppX3NtdW1nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L3NtdW1nci9maWppX3NtdW1nci5jCkBAIC05NDAsNyArOTQwLDcgQEAgc3RhdGljIGludCBmaWpp
X3BvcHVsYXRlX3NpbmdsZV9ncmFwaGljX2xldmVsKHN0cnVjdCBwcF9od21nciAqaHdtZ3IsCiB7
CiAJaW50IHJlc3VsdDsKIAkvKiBQUF9DbG9ja3MgbWluQ2xvY2tzOyAqLwotCXVpbnQzMl90IHRo
cmVzaG9sZCwgbXZkZDsKKwl1aW50MzJfdCBtdmRkOwogCXN0cnVjdCBzbXU3X2h3bWdyICpkYXRh
ID0gKHN0cnVjdCBzbXU3X2h3bWdyICopKGh3bWdyLT5iYWNrZW5kKTsKIAlzdHJ1Y3QgcGhtX3Bw
dF92MV9pbmZvcm1hdGlvbiAqdGFibGVfaW5mbyA9CiAJCQkoc3RydWN0IHBobV9wcHRfdjFfaW5m
b3JtYXRpb24gKikoaHdtZ3ItPnBwdGFibGUpOwpAQCAtOTczLDggKzk3Myw2IEBAIHN0YXRpYyBp
bnQgZmlqaV9wb3B1bGF0ZV9zaW5nbGVfZ3JhcGhpY19sZXZlbChzdHJ1Y3QgcHBfaHdtZ3IgKmh3
bWdyLAogCWxldmVsLT5Wb2x0YWdlRG93bkh5c3QgPSAwOwogCWxldmVsLT5Qb3dlclRocm90dGxl
ID0gMDsKCi0JdGhyZXNob2xkID0gY2xvY2sgKiBkYXRhLT5mYXN0X3dhdGVybWFya190aHJlc2hv
bGQgLyAxMDA7Ci0KIAlkYXRhLT5kaXNwbGF5X3RpbWluZy5taW5fY2xvY2tfaW5fc3IgPSBod21n
ci0+ZGlzcGxheV9jb25maWctPm1pbl9jb3JlX3NldF9jbG9ja19pbl9zcjsKCiAJaWYgKHBobV9j
YXBfZW5hYmxlZChod21nci0+cGxhdGZvcm1fZGVzY3JpcHRvci5wbGF0Zm9ybUNhcHMsIFBITV9Q
bGF0Zm9ybUNhcHNfU2Nsa0RlZXBTbGVlcCkpCkBAIC0xNTAxLDcgKzE0OTksNyBAQCBzdGF0aWMg
aW50IGZpamlfcG9wdWxhdGVfbWVtb3J5X3RpbWluZ19wYXJhbWV0ZXJzKHN0cnVjdCBwcF9od21n
ciAqaHdtZ3IsCiAJdWludDMyX3QgZHJhbV90aW1pbmc7CiAJdWludDMyX3QgZHJhbV90aW1pbmcy
OwogCXVpbnQzMl90IGJ1cnN0VGltZTsKLQlVTE9ORyBzdGF0ZSwgdHJyZHMsIHRycmRsOworCVVM
T05HIHRycmRzLCB0cnJkbDsKIAlpbnQgcmVzdWx0OwoKIAlyZXN1bHQgPSBhdG9tY3RybF9zZXRf
ZW5naW5lX2RyYW1fdGltaW5nc19ydjc3MChod21nciwKQEAgLTE1MTMsNyArMTUxMSw2IEBAIHN0
YXRpYyBpbnQgZmlqaV9wb3B1bGF0ZV9tZW1vcnlfdGltaW5nX3BhcmFtZXRlcnMoc3RydWN0IHBw
X2h3bWdyICpod21nciwKIAlkcmFtX3RpbWluZzIgPSBjZ3NfcmVhZF9yZWdpc3Rlcihod21nci0+
ZGV2aWNlLCBtbU1DX0FSQl9EUkFNX1RJTUlORzIpOwogCWJ1cnN0VGltZSA9IGNnc19yZWFkX3Jl
Z2lzdGVyKGh3bWdyLT5kZXZpY2UsIG1tTUNfQVJCX0JVUlNUX1RJTUUpOwoKLQlzdGF0ZSA9IFBI
TV9HRVRfRklFTEQoYnVyc3RUaW1lLCBNQ19BUkJfQlVSU1RfVElNRSwgU1RBVEUwKTsKIAl0cnJk
cyA9IFBITV9HRVRfRklFTEQoYnVyc3RUaW1lLCBNQ19BUkJfQlVSU1RfVElNRSwgVFJSRFMwKTsK
IAl0cnJkbCA9IFBITV9HRVRfRklFTEQoYnVyc3RUaW1lLCBNQ19BUkJfQlVSU1RfVElNRSwgVFJS
REwwKTsKCi0tCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
