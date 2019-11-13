Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C46C17447
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFB3222CA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFB3222CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259E46ED3A;
	Wed, 13 Nov 2019 14:12:16 +0000 (UTC)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE546E0CB;
 Wed, 13 Nov 2019 12:37:29 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id F35A815BF4D2D106298A;
 Wed, 13 Nov 2019 20:37:20 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 13 Nov 2019
 20:37:10 +0800
From: yu kuai <yukuai3@huawei.com>
To: <alexander.deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <christian.koenig@amd.com>, <David1.Zhou@amd.com>, <airlied@linux.ie>,
 <daniel@ffwll.ch>, <Rex.Zhu@amd.com>, <evan.quan@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: remove set but not used variable
 'amdgpu_connector'
Date: Wed, 13 Nov 2019 20:44:29 +0800
Message-ID: <1573649074-72589-3-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 13 Nov 2019 14:12:08 +0000
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
 amd-gfx@lists.freedesktop.org, zhengbin13@huawei.com,
 dri-devel@lists.freedesktop.org, yukuai3@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113124429.zIzXEWaBtuHWyJU-hp1fOTsnCQzlmRJWdSr5a16lTXQ@z>

Rml4ZXMgZ2NjICctV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlJyB3YXJuaW5nOgoKZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYzogSW4gZnVuY3Rpb24K4oCYYW1kZ3B1
X2Rpc3BsYXlfY3J0Y19zY2FsaW5nX21vZGVfZml4dXDigJk6CmRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmM6NjkzOjI3OiB3YXJuaW5nOiB2YXJpYWJsZQrigJhhbWRn
cHVfY29ubmVjdG9y4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFi
bGVdCgpGaXhlczogZDM4Y2VhZjk5ZWQwICgiZHJtL2FtZGdwdTogYWRkIGNvcmUgZHJpdmVyICh2
NCkiKQpTaWduZWQtb2ZmLWJ5OiB5dSBrdWFpIDx5dWt1YWkzQGh1YXdlaS5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyB8IDIgLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGlzcGxheS5jCmluZGV4IGQyZGQ1OWEuLjZhMjcwMjcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwpAQCAtNjkwLDcgKzY5MCw2IEBAIGJvb2wgYW1k
Z3B1X2Rpc3BsYXlfY3J0Y19zY2FsaW5nX21vZGVfZml4dXAoc3RydWN0IGRybV9jcnRjICpjcnRj
LAogCXN0cnVjdCBhbWRncHVfY3J0YyAqYW1kZ3B1X2NydGMgPSB0b19hbWRncHVfY3J0YyhjcnRj
KTsKIAlzdHJ1Y3QgYW1kZ3B1X2VuY29kZXIgKmFtZGdwdV9lbmNvZGVyOwogCXN0cnVjdCBkcm1f
Y29ubmVjdG9yICpjb25uZWN0b3I7Ci0Jc3RydWN0IGFtZGdwdV9jb25uZWN0b3IgKmFtZGdwdV9j
b25uZWN0b3I7CiAJdTMyIHNyY192ID0gMSwgZHN0X3YgPSAxOwogCXUzMiBzcmNfaCA9IDEsIGRz
dF9oID0gMTsKIApAQCAtNzAyLDcgKzcwMSw2IEBAIGJvb2wgYW1kZ3B1X2Rpc3BsYXlfY3J0Y19z
Y2FsaW5nX21vZGVfZml4dXAoc3RydWN0IGRybV9jcnRjICpjcnRjLAogCQkJY29udGludWU7CiAJ
CWFtZGdwdV9lbmNvZGVyID0gdG9fYW1kZ3B1X2VuY29kZXIoZW5jb2Rlcik7CiAJCWNvbm5lY3Rv
ciA9IGFtZGdwdV9nZXRfY29ubmVjdG9yX2Zvcl9lbmNvZGVyKGVuY29kZXIpOwotCQlhbWRncHVf
Y29ubmVjdG9yID0gdG9fYW1kZ3B1X2Nvbm5lY3Rvcihjb25uZWN0b3IpOwogCiAJCS8qIHNldCBz
Y2FsaW5nICovCiAJCWlmIChhbWRncHVfZW5jb2Rlci0+cm14X3R5cGUgPT0gUk1YX09GRikKLS0g
CjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
