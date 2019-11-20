Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5189BC432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 15:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3056C21845
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 15:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3056C21845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F12B66EA82;
	Wed, 20 Nov 2019 15:09:25 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 449D46E4A2;
 Wed, 20 Nov 2019 12:54:23 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 86B80AD63EA186BBCB32;
 Wed, 20 Nov 2019 20:54:19 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 20 Nov 2019
 20:54:12 +0800
From: yu kuai <yukuai3@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <Jammy.Zhou@amd.com>, <tianci.yin@amd.com>, <sam@ravnborg.org>,
 <luben.tuikov@amd.com>
Subject: [PATCH] drm/amd/display: make various variable in fixed31_32.h
 'global' instead of 'static'
Date: Wed, 20 Nov 2019 21:15:33 +0800
Message-ID: <20191120131533.12720-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191120131533.12720-1-yukuai3@huawei.com>
References: <20191120131533.12720-1-yukuai3@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 20 Nov 2019 15:09:21 +0000
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
Cc: yi.zhang@huawei.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, zhengbin13@huawei.com,
 amd-gfx@lists.freedesktop.org, yukuai3@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120131533.XWetqncJ-0ig0cMkaCIJjwDtS3X8dweZ-wlDLRVM_M8@z>

Zml4ZWQzMV8zMi5oIGRlY2xhcmUgdmFyaW91cyB2YXJpYWJsZXMgJ3N0YXRpYyBjb25zdCcsIGl0
J3MgdmVyeSB1Z2x5IGFuZAp3YXN0ZSBvZiBtZW1vcnkuCgpBbGwgZmlsZXMgdGhhdCBpbmNsdWRp
bmcgdGhlIGhlYWRlciBmaWxlIHdpbGwgaGF2ZSBhIGNvcHkgb2YgdGhvc2UKdmFyaWFibGVzIG9m
IHRoZWlyIG93bi4gQW5kIHRoYXQncyB0aGUgcmVhc29uIHdoeSB0aGVyZSB3aWxsIGJlIG51bWVy
b3VzCmdjYyAnLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZScgd2FybmluZ3MgcmVsYXRlZCB0byB0
aGUgdmFyaWFibGVzLgoKRml4IGl0IGJ5IGluaXRpYWxpemluZyB0aGUgdmFyaWFibGVzIGluIGEg
bmV3IGZpbGUgImZpeGVkMzFfMzIuYyIsIGFuZApkZWNsYXJlIHRoZW0gJ2V4dGVybicgaW4gImZp
eGVkMzFfMzIuaCIuCgpGaXhlczogZWIwZTUxNTQ2NGU0ICgiZHJtL2FtZC9kaXNwbGF5OiBnZXQg
cmlkIG9mIDMyLjMyIHVuc2lnbmVkIGZpeGVkIHBvaW50IikKU2lnbmVkLW9mZi1ieTogeXUga3Vh
aSA8eXVrdWFpM0BodWF3ZWkuY29tPgotLS0KCkJUVywgdGhpcyBpcyB0aGUgYmVzdCBJIGNhbiB0
aGluayBvZiwgdGhlcmUgbWF5IGJlIGJldHRlciBzdWxvdGlvbi4KCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL01ha2VmaWxlICB8ICAyICstCiAuLi4vZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vZml4ZWQzMV8zMi5jICB8IDE3ICsrKysrKysrKysrKysrKysrCiAu
Li4vZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL2ZpeGVkMzFfMzIuaCAgICB8IDE2ICsrKysr
KysrLS0tLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlv
bnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2ZpeGVkMzFfMzIuYwoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vTWFrZWZpbGUgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL01ha2VmaWxlCmluZGV4IDlhM2I3YmY4YWIwYi4uOGNlMjkxYTAyNzliIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL01ha2VmaWxlCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vTWFrZWZpbGUKQEAgLTI1LDcg
KzI1LDcgQEAKIAogCiAKLUFNREdQVURNID0gYW1kZ3B1X2RtLm8gYW1kZ3B1X2RtX2lycS5vIGFt
ZGdwdV9kbV9tc3RfdHlwZXMubyBhbWRncHVfZG1fY29sb3IubworQU1ER1BVRE0gPSBhbWRncHVf
ZG0ubyBhbWRncHVfZG1faXJxLm8gYW1kZ3B1X2RtX21zdF90eXBlcy5vIGFtZGdwdV9kbV9jb2xv
ci5vIGZpeGVkMzFfMzIubwogCiBpZm5lcSAoJChDT05GSUdfRFJNX0FNRF9EQyksKQogQU1ER1BV
RE0gKz0gYW1kZ3B1X2RtX3NlcnZpY2VzLm8gYW1kZ3B1X2RtX2hlbHBlcnMubyBhbWRncHVfZG1f
cHBfc211Lm8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vZml4ZWQzMV8zMi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9m
aXhlZDMxXzMyLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi4xZjUx
NTg3ZTM0MmIKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2ZpeGVkMzFfMzIuYwpAQCAtMCwwICsxLDE3IEBACisvKgorICogQXV0aG9yOiB5
dSBrdWFpIDx5dWt1YWkzQGh1YXdlaS5jb20+CisgKi8KKworc3RydWN0IGZpeGVkMzFfMzIgewor
CWxvbmcgbG9uZyB2YWx1ZTsKK307CisKK2NvbnN0IHN0cnVjdCBmaXhlZDMxXzMyIGRjX2ZpeHB0
X3plcm8gPSB7IDAgfTsKK2NvbnN0IHN0cnVjdCBmaXhlZDMxXzMyIGRjX2ZpeHB0X2Vwc2lsb24g
PSB7IDFMTCB9OworY29uc3Qgc3RydWN0IGZpeGVkMzFfMzIgZGNfZml4cHRfaGFsZiA9IHsgMHg4
MDAwMDAwMExMIH07Citjb25zdCBzdHJ1Y3QgZml4ZWQzMV8zMiBkY19maXhwdF9vbmUgPSB7IDB4
MTAwMDAwMDAwTEwgfTsKKworY29uc3Qgc3RydWN0IGZpeGVkMzFfMzIgZGNfZml4cHRfdHdvX3Bp
ID0geyAyNjk4NjA3NTQwOUxMIH07Citjb25zdCBzdHJ1Y3QgZml4ZWQzMV8zMiBkY19maXhwdF9s
bjIgPSB7IDI5NzcwNDQ0NzFMTCB9OworY29uc3Qgc3RydWN0IGZpeGVkMzFfMzIgZGNfZml4cHRf
bG4yX2Rpdl8yID0geyAxNDg4NTIyMjM2TEwgfTsKKwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZml4ZWQzMV8zMi5oIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2luY2x1ZGUvZml4ZWQzMV8zMi5oCmluZGV4IDI5MTIxNTM2MmUzZi4uZDhkYmU5
NmY5YjE5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9m
aXhlZDMxXzMyLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZml4
ZWQzMV8zMi5oCkBAIC02NCwxNCArNjQsMTQgQEAgc3RydWN0IGZpeGVkMzFfMzIgewogICogVXNl
ZnVsIGNvbnN0YW50cwogICovCiAKLXN0YXRpYyBjb25zdCBzdHJ1Y3QgZml4ZWQzMV8zMiBkY19m
aXhwdF96ZXJvID0geyAwIH07Ci1zdGF0aWMgY29uc3Qgc3RydWN0IGZpeGVkMzFfMzIgZGNfZml4
cHRfZXBzaWxvbiA9IHsgMUxMIH07Ci1zdGF0aWMgY29uc3Qgc3RydWN0IGZpeGVkMzFfMzIgZGNf
Zml4cHRfaGFsZiA9IHsgMHg4MDAwMDAwMExMIH07Ci1zdGF0aWMgY29uc3Qgc3RydWN0IGZpeGVk
MzFfMzIgZGNfZml4cHRfb25lID0geyAweDEwMDAwMDAwMExMIH07Ci0KLXN0YXRpYyBjb25zdCBz
dHJ1Y3QgZml4ZWQzMV8zMiBkY19maXhwdF90d29fcGkgPSB7IDI2OTg2MDc1NDA5TEwgfTsKLXN0
YXRpYyBjb25zdCBzdHJ1Y3QgZml4ZWQzMV8zMiBkY19maXhwdF9sbjIgPSB7IDI5NzcwNDQ0NzFM
TCB9Owotc3RhdGljIGNvbnN0IHN0cnVjdCBmaXhlZDMxXzMyIGRjX2ZpeHB0X2xuMl9kaXZfMiA9
IHsgMTQ4ODUyMjIzNkxMIH07CitleHRlcm4gY29uc3Qgc3RydWN0IGZpeGVkMzFfMzIgZGNfZml4
cHRfemVybzsKK2V4dGVybiBjb25zdCBzdHJ1Y3QgZml4ZWQzMV8zMiBkY19maXhwdF9lcHNpbG9u
OworZXh0ZXJuIGNvbnN0IHN0cnVjdCBmaXhlZDMxXzMyIGRjX2ZpeHB0X2hhbGY7CitleHRlcm4g
Y29uc3Qgc3RydWN0IGZpeGVkMzFfMzIgZGNfZml4cHRfb25lOworCitleHRlcm4gY29uc3Qgc3Ry
dWN0IGZpeGVkMzFfMzIgZGNfZml4cHRfdHdvX3BpOworZXh0ZXJuIGNvbnN0IHN0cnVjdCBmaXhl
ZDMxXzMyIGRjX2ZpeHB0X2xuMjsKK2V4dGVybiBjb25zdCBzdHJ1Y3QgZml4ZWQzMV8zMiBkY19m
aXhwdF9sbjJfZGl2XzI7CiAKIC8qCiAgKiBAYnJpZWYKLS0gCjIuMTcuMgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
