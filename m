Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069EBC432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 09:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D251A20708
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 09:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D251A20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A72B6F4F3;
	Fri, 22 Nov 2019 09:01:09 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7966F4D4;
 Fri, 22 Nov 2019 03:35:41 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 3CF438082EE43D7D736E;
 Fri, 22 Nov 2019 11:35:38 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 22 Nov 2019
 11:35:30 +0800
From: zhengbin <zhengbin13@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <rex.zhu@amd.com>, <evan.quan@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Use ARRAY_SIZE for sos_old_versions
Date: Fri, 22 Nov 2019 11:42:52 +0800
Message-ID: <1574394172-18216-3-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574394172-18216-1-git-send-email-zhengbin13@huawei.com>
References: <1574394172-18216-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 22 Nov 2019 09:01:08 +0000
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
Message-ID: <20191122034252.A5PDhNlQ4dOrWmyKXlPOxrANnl5FQGO69WYR5G0YbnI@z>

Rml4ZXMgY29jY2ljaGVjayB3YXJuaW5nOgoKZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNw
X3YzXzEuYzoxODI6NDAtNDE6IFdBUk5JTkc6IFVzZSBBUlJBWV9TSVpFCgpSZXBvcnRlZC1ieTog
SHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+ClNpZ25lZC1vZmYtYnk6IHpoZW5nYmluIDx6
aGVuZ2JpbjEzQGh1YXdlaS5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNw
X3YzXzEuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92M18xLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjNfMS5jCmluZGV4IGI0ZDY0MjcuLjcz
NWM0M2MgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92M18xLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YzXzEuYwpAQCAtMTc5LDcgKzE3
OSw3IEBAIHN0YXRpYyBib29sIHBzcF92M18xX21hdGNoX3ZlcnNpb24oc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZlcikKIAkgKiBEb3VibGUgY2hlY2sgaWYgdGhlIGxhdGVz
dCBmb3VyIGxlZ2FjeSB2ZXJzaW9ucy4KIAkgKiBJZiB5ZXMsIGl0IGlzIHN0aWxsIHRoZSByaWdo
dCB2ZXJzaW9uLgogCSAqLwotCWZvciAoaSA9IDA7IGkgPCBzaXplb2Yoc29zX29sZF92ZXJzaW9u
cykgLyBzaXplb2YodWludDMyX3QpOyBpKyspIHsKKwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0la
RShzb3Nfb2xkX3ZlcnNpb25zKTsgaSsrKSB7CiAJCWlmIChzb3Nfb2xkX3ZlcnNpb25zW2ldID09
IGFkZXYtPnBzcC5zb3NfZndfdmVyc2lvbikKIAkJCXJldHVybiB0cnVlOwogCX0KLS0KMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
