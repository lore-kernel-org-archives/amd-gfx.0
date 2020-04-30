Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8ABC83002
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 07:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8E020757
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 07:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8E020757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCED6EB7B;
	Thu, 30 Apr 2020 07:33:14 +0000 (UTC)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41FA76EA7C;
 Thu, 30 Apr 2020 03:33:44 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7AFE2C6733A4A1EB609E;
 Thu, 30 Apr 2020 11:33:38 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Apr 2020
 11:33:29 +0800
From: Zheng Bin <zhengbin13@huawei.com>
To: <alexander.deucher@amd.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amd/display: remove set but not used variable
 'speakers' in dcn10_stream_encoder.c
Date: Thu, 30 Apr 2020 11:40:34 +0800
Message-ID: <20200430034034.106824-5-zhengbin13@huawei.com>
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
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX3N0cmVhbV9lbmNvZGVyLmM6MTI3Nzox
MTogd2FybmluZzogdmFyaWFibGUg4oCYc3BlYWtlcnPigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1
bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KCkl0IGlzIGludHJvZHVjZWQgYnkgY29tbWl0IDBjNDE4
OTFjODFjMCAoImRybS9hbWQvZGlzcGxheToKUmVmYWN0b3Igc3RyZWFtIGVuY29kZXIgZm9yIEhX
IHJldmlldyIpLCBidXQgbmV2ZXIgdXNlZCwgc28gcmVtb3ZlIGl0LgoKUmVwb3J0ZWQtYnk6IEh1
bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPgpTaWduZWQtb2ZmLWJ5OiBaaGVuZyBCaW4gPHpo
ZW5nYmluMTNAaHVhd2VpLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNuMTAvZGNuMTBfc3RyZWFtX2VuY29kZXIuYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y24xMC9kY24xMF9zdHJlYW1fZW5jb2Rlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjbjEwL2RjbjEwX3N0cmVhbV9lbmNvZGVyLmMKaW5kZXggN2ViYTkzMzNjMzI4Li4wN2Iy
ZjkzOTk2NzEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24x
MC9kY24xMF9zdHJlYW1fZW5jb2Rlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY24xMC9kY24xMF9zdHJlYW1fZW5jb2Rlci5jCkBAIC0xMjc0LDcgKzEyNzQsNiBAQCBz
dGF0aWMgdm9pZCBlbmMxX3NlX2F1ZGlvX3NldHVwKAogewogCXN0cnVjdCBkY24xMF9zdHJlYW1f
ZW5jb2RlciAqZW5jMSA9IERDTjEwU1RSRU5DX0ZST01fU1RSRU5DKGVuYyk7CgotCXVpbnQzMl90
IHNwZWFrZXJzID0gMDsKIAl1aW50MzJfdCBjaGFubmVscyA9IDA7CgogCUFTU0VSVChhdWRpb19p
bmZvKTsKQEAgLTEyODIsNyArMTI4MSw2IEBAIHN0YXRpYyB2b2lkIGVuYzFfc2VfYXVkaW9fc2V0
dXAoCiAJCS8qIFRoaXMgc2hvdWxkIG5vdCBoYXBwZW4uaXQgZG9lcyBzbyB3ZSBkb24ndCBnZXQg
QlNPRCovCiAJCXJldHVybjsKCi0Jc3BlYWtlcnMgPSBhdWRpb19pbmZvLT5mbGFncy5pbmZvLkFM
TFNQRUFLRVJTOwogCWNoYW5uZWxzID0gc3BlYWtlcnNfdG9fY2hhbm5lbHMoYXVkaW9faW5mby0+
ZmxhZ3Muc3BlYWtlcl9mbGFncykuYWxsOwoKIAkvKiBzZXR1cCB0aGUgYXVkaW8gc3RyZWFtIHNv
dXJjZSBzZWxlY3QgKGF1ZGlvIC0+IGRpZyBtYXBwaW5nKSAqLwotLQoyLjI2LjAuMTA2Lmc5ZmFk
ZWRkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
