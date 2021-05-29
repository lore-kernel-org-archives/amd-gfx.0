Return-Path: <SRS0=Uo0t=KY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B67BC47091
	for <amd-gfx@archiver.kernel.org>; Sat, 29 May 2021 10:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647096103E
	for <amd-gfx@archiver.kernel.org>; Sat, 29 May 2021 10:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647096103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D43A6EE96;
	Sat, 29 May 2021 10:20:33 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 687FB6E10E
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 May 2021 09:38:15 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FsbTk17yKzWp8R;
 Sat, 29 May 2021 17:14:18 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 17:18:55 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 29
 May 2021 17:18:55 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>
Subject: [PATCH] drm/amd/display: fix gcc set but not used warning of variable
 'old_plane_state'
Date: Sat, 29 May 2021 17:28:16 +0800
Message-ID: <20210529092816.3133745-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Sat, 29 May 2021 10:20:31 +0000
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
Cc: yukuai3@huawei.com, yi.zhang@huawei.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ZGVmaW5lIGEgbmV3IG1hY3JvIGZvcl9lYWNoX25ld19wbGFuZV9pbl9zdGF0ZV9yZXZlcnNlIHRv
IHJlcGxhY2UKZm9yX2VhY2hfb2xkbmV3X3BsYW5lX2luX3N0YXRlX3JldmVyc2UsIHNvIHRoYXQg
dGhlIHVudXNlZCB2YXJpYWJsZQonb2xkX3BsYW5lX3N0YXRlJyBjYW4gYmUgcmVtb3ZlZC4KCkZp
eCBnY2Mgd2FybmluZzoKZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmM6MTAwNjY6MjY6IHdhcm5pbmc6CiB2YXJpYWJsZSDigJhvbGRfcGxh
bmVfc3RhdGXigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0K
ClNpZ25lZC1vZmYtYnk6IFl1IEt1YWkgPHl1a3VhaTNAaHVhd2VpLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgIDQgKystLQogaW5j
bHVkZS9kcm0vZHJtX2F0b21pYy5oICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEyICsrKysr
KysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1k
Z3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9k
bS5jCmluZGV4IGY3YTVlNWI0OGVhNi4uOWY0YjMzNGJjMDcxIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTEwMDYzLDExICsx
MDA2MywxMSBAQCBzdGF0aWMgaW50IHZhbGlkYXRlX292ZXJsYXkoc3RydWN0IGRybV9hdG9taWNf
c3RhdGUgKnN0YXRlKQogewogCWludCBpOwogCXN0cnVjdCBkcm1fcGxhbmUgKnBsYW5lOwotCXN0
cnVjdCBkcm1fcGxhbmVfc3RhdGUgKm9sZF9wbGFuZV9zdGF0ZSwgKm5ld19wbGFuZV9zdGF0ZTsK
KwlzdHJ1Y3QgZHJtX3BsYW5lX3N0YXRlICpuZXdfcGxhbmVfc3RhdGU7CiAJc3RydWN0IGRybV9w
bGFuZV9zdGF0ZSAqcHJpbWFyeV9zdGF0ZSwgKmN1cnNvcl9zdGF0ZSwgKm92ZXJsYXlfc3RhdGUg
PSBOVUxMOwogCiAJLyogQ2hlY2sgaWYgcHJpbWFyeSBwbGFuZSBpcyBjb250YWluZWQgaW5zaWRl
IG92ZXJsYXkgKi8KLQlmb3JfZWFjaF9vbGRuZXdfcGxhbmVfaW5fc3RhdGVfcmV2ZXJzZShzdGF0
ZSwgcGxhbmUsIG9sZF9wbGFuZV9zdGF0ZSwgbmV3X3BsYW5lX3N0YXRlLCBpKSB7CisJZm9yX2Vh
Y2hfbmV3X3BsYW5lX2luX3N0YXRlX3JldmVyc2Uoc3RhdGUsIHBsYW5lLCBuZXdfcGxhbmVfc3Rh
dGUsIGkpIHsKIAkJaWYgKHBsYW5lLT50eXBlID09IERSTV9QTEFORV9UWVBFX09WRVJMQVkpIHsK
IAkJCWlmIChkcm1fYXRvbWljX3BsYW5lX2Rpc2FibGluZyhwbGFuZS0+c3RhdGUsIG5ld19wbGFu
ZV9zdGF0ZSkpCiAJCQkJcmV0dXJuIDA7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1fYXRv
bWljLmggYi9pbmNsdWRlL2RybS9kcm1fYXRvbWljLmgKaW5kZXggYWM1YTI4ZWZmMmM4Li44ZjEz
NTBlNTk5ZWIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvZHJtL2RybV9hdG9taWMuaAorKysgYi9pbmNs
dWRlL2RybS9kcm1fYXRvbWljLmgKQEAgLTg5NSw2ICs4OTUsMTggQEAgdm9pZCBkcm1fc3RhdGVf
ZHVtcChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBzdHJ1Y3QgZHJtX3ByaW50ZXIgKnApOwogCQkJ
ICAgICAgKG9sZF9wbGFuZV9zdGF0ZSkgPSAoX19zdGF0ZSktPnBsYW5lc1tfX2ldLm9sZF9zdGF0
ZSxcCiAJCQkgICAgICAobmV3X3BsYW5lX3N0YXRlKSA9IChfX3N0YXRlKS0+cGxhbmVzW19faV0u
bmV3X3N0YXRlLCAxKSkKIAorLyoqCisgKiBmb3JfZWFjaF9uZXdfcGxhbmVfaW5fc3RhdGVfcmV2
ZXJzZSAtIG90aGVyIHRoYW4gb25seSB0cmFja2luZyBuZXcgc3RhdGUsCisgKiBpdCdzIHRoZSBz
YW1lIGFzIGZvcl9lYWNoX29sZG5ld19wbGFuZV9pbl9zdGF0ZV9yZXZlcnNlCisgKi8KKyNkZWZp
bmUgZm9yX2VhY2hfbmV3X3BsYW5lX2luX3N0YXRlX3JldmVyc2UoX19zdGF0ZSwgcGxhbmUsIG5l
d19wbGFuZV9zdGF0ZSwgX19pKSBcCisJZm9yICgoX19pKSA9ICgoX19zdGF0ZSktPmRldi0+bW9k
ZV9jb25maWcubnVtX3RvdGFsX3BsYW5lIC0gMSk7CVwKKwkgICAgIChfX2kpID49IDA7CQkJCQkJ
XAorCSAgICAgKF9faSktLSkJCQkJCQkJXAorCQlmb3JfZWFjaF9pZiAoKF9fc3RhdGUpLT5wbGFu
ZXNbX19pXS5wdHIgJiYJCVwKKwkJCSAgICAgKChwbGFuZSkgPSAoX19zdGF0ZSktPnBsYW5lc1tf
X2ldLnB0ciwJXAorCQkJICAgICAgKG5ld19wbGFuZV9zdGF0ZSkgPSAoX19zdGF0ZSktPnBsYW5l
c1tfX2ldLm5ld19zdGF0ZSwgMSkpCisKIC8qKgogICogZm9yX2VhY2hfb2xkX3BsYW5lX2luX3N0
YXRlIC0gaXRlcmF0ZSBvdmVyIGFsbCBwbGFuZXMgaW4gYW4gYXRvbWljIHVwZGF0ZQogICogQF9f
c3RhdGU6ICZzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSBwb2ludGVyCi0tIAoyLjI1LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
