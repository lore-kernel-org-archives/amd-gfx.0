Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16273C43463
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 07:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C176420C56
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 07:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C176420C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 768166ECB4;
	Fri, 18 Sep 2020 07:21:36 +0000 (UTC)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA74A6E112
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 03:43:42 +0000 (UTC)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 7257AA7591A4C09F00A5;
 Fri, 18 Sep 2020 11:43:39 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 11:43:32 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/amd/display: remove unused variable in amdgpu_dm.c
Date: Fri, 18 Sep 2020 11:42:14 +0800
Message-ID: <20200918034214.2534751-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 18 Sep 2020 07:21:35 +0000
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
Cc: alexander.deucher@amd.com, yangyingliang@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4IHRoZSBjb21waWxlIHdhcm5pbmc6CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jOjg5MjoyNjogd2FybmluZzogdmFyaWFibGUg4oCY
c3RyZWFt4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCiAg
c3RydWN0IGRjX3N0cmVhbV9zdGF0ZSAqc3RyZWFtOwogICAgICAgICAgICAgICAgICAgICAgICAg
IF5+fn5+fgoKUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBZYW5nIFlpbmdsaWFuZyA8eWFuZ3lpbmdsaWFuZ0BodWF3ZWkuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAzIC0t
LQogMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKaW5kZXggYmIxYmM3ZjVkMTQ5Li43
ZDllOGMzMTE4NzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYwpAQCAtODg5LDcgKzg4OSw2IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9j
aGVja19kZWJ1Z2ZzX2Nvbm5lY3Rvcl9wcm9wZXJ0eV9jaGFuZ2Uoc3RydWN0IGFtZGdwdV9kZXZp
Y2UKIAlzdHJ1Y3QgZHJtX2Nvbm5lY3Rvcl9zdGF0ZSAqY29ubl9zdGF0ZTsKIAlzdHJ1Y3QgZG1f
Y3J0Y19zdGF0ZSAqYWNydGNfc3RhdGU7CiAJc3RydWN0IGRybV9jcnRjX3N0YXRlICpjcnRjX3N0
YXRlOwotCXN0cnVjdCBkY19zdHJlYW1fc3RhdGUgKnN0cmVhbTsKIAlzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGV2ID0gYWRldl90b19kcm0oYWRldik7CiAKIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KGNvbm5l
Y3RvciwgJmRldi0+bW9kZV9jb25maWcuY29ubmVjdG9yX2xpc3QsIGhlYWQpIHsKQEAgLTkwNiw4
ICs5MDUsNiBAQCBzdGF0aWMgdm9pZCBhbWRncHVfY2hlY2tfZGVidWdmc19jb25uZWN0b3JfcHJv
cGVydHlfY2hhbmdlKHN0cnVjdCBhbWRncHVfZGV2aWNlCiAJCWlmICghKGFjcnRjX3N0YXRlICYm
IGFjcnRjX3N0YXRlLT5zdHJlYW0pKQogCQkJY29udGludWU7CiAKLQkJc3RyZWFtID0gYWNydGNf
c3RhdGUtPnN0cmVhbTsKLQogCQlpZiAoYW1kZ3B1X2RtX2Nvbm5lY3Rvci0+ZHNjX3NldHRpbmdz
LmRzY19mb3JjZV9lbmFibGUgfHwKIAkJICAgIGFtZGdwdV9kbV9jb25uZWN0b3ItPmRzY19zZXR0
aW5ncy5kc2NfbnVtX3NsaWNlc192IHx8CiAJCSAgICBhbWRncHVfZG1fY29ubmVjdG9yLT5kc2Nf
c2V0dGluZ3MuZHNjX251bV9zbGljZXNfaCB8fAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
