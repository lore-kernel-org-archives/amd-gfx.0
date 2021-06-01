Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A83AC47092
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 13:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8F9613BD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 13:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8F9613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC0066EA62;
	Tue,  1 Jun 2021 13:12:03 +0000 (UTC)
X-Greylist: delayed 1111 seconds by postgrey-1.36 at gabe;
 Tue, 01 Jun 2021 08:23:20 UTC
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BF8988065
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 08:23:20 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvPhh5ZYkzWqPw;
 Tue,  1 Jun 2021 16:00:04 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:04:45 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 16:04:44 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <aurabindo.pillai@amd.com>, <qingqing.zhuo@amd.com>,
 <bas@basnieuwenhuizen.nl>, <nikola.cornij@amd.com>, <Wayne.Lin@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] =?UTF-8?q?drm/amd/display:=20fix=20warning:=20?=
 =?UTF-8?q?=E2=80=98update=5Fdsc=5Fcaps=E2=80=99=20and=20=E2=80=98apply=5F?=
 =?UTF-8?q?dsc=5Fpolicy=5Ffor=5Fstream=E2=80=99=20defined=20but=20not=20us?=
 =?UTF-8?q?ed?=
Date: Tue, 1 Jun 2021 16:14:00 +0800
Message-ID: <20210601081400.123089-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 01 Jun 2021 13:12:02 +0000
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
Cc: yuehaibing@huawei.com, libaokun1@huawei.com, weiyongjun1@huawei.com,
 yukuai3@huawei.com, yangjihong1@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgZ2NjICctV3VudXNlZC1mdW5jdGlvbicgd2FybmluZzoKCuKAmHVwZGF0ZV9kc2NfY2Fw
c+KAmSBhbmQg4oCYYXBwbHlfZHNjX3BvbGljeV9mb3Jfc3RyZWFt4oCZIGFyZSBvbmx5IHVzZWQK
aWYgJ0NPTkZJR19EUk1fQU1EX0RDX0RDTicgaXMgZGVmaW5lZCwKCmhvd2V2ZXIsIGl0J3MgZGVm
aW5lZCBldmVuIGlmICdDT05GSUdfRFJNX0FNRF9EQ19EQ04nIGlzIG5vdCBkZWZpbmVkLgpUaHVz
IGdjYyB3aWxsIHJlcG9ydCBmb2xsb3dpbmcgd2FybmluZwppZiAnQ09ORklHX0RSTV9BTURfRENf
RENOJyBpcyBub3QgZGVmaW5lZDoKCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jOjU1NzI6MTM6IHdhcm5pbmc6CuKAmGFwcGx5X2RzY19w
b2xpY3lfZm9yX3N0cmVhbeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVuY3Rp
b25dCgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG0uYzo1NTU2OjEzOiB3YXJuaW5nOgrigJh1cGRhdGVfZHNjX2NhcHPigJkgZGVmaW5lZCBi
dXQgbm90IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQoKVGh1cyBtb3ZlIHRoZSBkZWZpbml0aW9u
IG9mIOKAmHVwZGF0ZV9kc2NfY2Fwc+KAmSBhbmQK4oCYYXBwbHlfZHNjX3BvbGljeV9mb3Jfc3Ry
ZWFt4oCZIGluc2lkZSBkZWZpbmUgbWFjcm8gdG8gZml4IGl0LgoKU2lnbmVkLW9mZi1ieTogQmFv
a3VuIExpIDxsaWJhb2t1bjFAaHVhd2VpLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgNiArKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKaW5kZXggZjBhZGZkYTMyMjEzLi5lMGFm
Mzk0MTAzYWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYwpAQCAtNTU1Myw2ICs1NTUzLDcgQEAgc3RhdGljIHZvaWQgZG1fZW5hYmxl
X3Blcl9mcmFtZV9jcnRjX21hc3Rlcl9zeW5jKHN0cnVjdCBkY19zdGF0ZSAqY29udGV4dCkKIAl9
CiB9CiAKKyNpZiBkZWZpbmVkKENPTkZJR19EUk1fQU1EX0RDX0RDTikKIHN0YXRpYyB2b2lkIHVw
ZGF0ZV9kc2NfY2FwcyhzdHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAqYWNvbm5lY3RvciwKIAkJ
CQkJCQlzdHJ1Y3QgZGNfc2luayAqc2luaywgc3RydWN0IGRjX3N0cmVhbV9zdGF0ZSAqc3RyZWFt
LAogCQkJCQkJCXN0cnVjdCBkc2NfZGVjX2RwY2RfY2FwcyAqZHNjX2NhcHMpCkBAIC01NTYwLDEy
ICs1NTYxLDEwIEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9kc2NfY2FwcyhzdHJ1Y3QgYW1kZ3B1X2Rt
X2Nvbm5lY3RvciAqYWNvbm5lY3RvciwKIAlzdHJlYW0tPnRpbWluZy5mbGFncy5EU0MgPSAwOwog
CiAJaWYgKGFjb25uZWN0b3ItPmRjX2xpbmsgJiYgc2luay0+c2lua19zaWduYWwgPT0gU0lHTkFM
X1RZUEVfRElTUExBWV9QT1JUKSB7Ci0jaWYgZGVmaW5lZChDT05GSUdfRFJNX0FNRF9EQ19EQ04p
CiAJCWRjX2RzY19wYXJzZV9kc2NfZHBjZChhY29ubmVjdG9yLT5kY19saW5rLT5jdHgtPmRjLAog
CQkJCSAgICAgIGFjb25uZWN0b3ItPmRjX2xpbmstPmRwY2RfY2Fwcy5kc2NfY2Fwcy5kc2NfYmFz
aWNfY2Fwcy5yYXcsCiAJCQkJICAgICAgYWNvbm5lY3Rvci0+ZGNfbGluay0+ZHBjZF9jYXBzLmRz
Y19jYXBzLmRzY19icmFuY2hfZGVjb2Rlcl9jYXBzLnJhdywKIAkJCQkgICAgICBkc2NfY2Fwcyk7
Ci0jZW5kaWYKIAl9CiB9CiAKQEAgLTU1NzgsNyArNTU3Nyw2IEBAIHN0YXRpYyB2b2lkIGFwcGx5
X2RzY19wb2xpY3lfZm9yX3N0cmVhbShzdHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAqYWNvbm5l
Y3RvciwKIAogCWxpbmtfYmFuZHdpZHRoX2ticHMgPSBkY19saW5rX2JhbmR3aWR0aF9rYnBzKGFj
b25uZWN0b3ItPmRjX2xpbmssCiAJCQkJCQkJZGNfbGlua19nZXRfbGlua19jYXAoYWNvbm5lY3Rv
ci0+ZGNfbGluaykpOwotI2lmIGRlZmluZWQoQ09ORklHX0RSTV9BTURfRENfRENOKQogCS8qIFNl
dCBEU0MgcG9saWN5IGFjY29yZGluZyB0byBkc2NfY2xvY2tfZW4gKi8KIAlkY19kc2NfcG9saWN5
X3NldF9lbmFibGVfZHNjX3doZW5fbm90X25lZWRlZCgKIAkJYWNvbm5lY3Rvci0+ZHNjX3NldHRp
bmdzLmRzY19mb3JjZV9lbmFibGUgPT0gRFNDX0NMS19GT1JDRV9FTkFCTEUpOwpAQCAtNTYwOSw4
ICs1NjA3LDggQEAgc3RhdGljIHZvaWQgYXBwbHlfZHNjX3BvbGljeV9mb3Jfc3RyZWFtKHN0cnVj
dCBhbWRncHVfZG1fY29ubmVjdG9yICphY29ubmVjdG9yLAogCiAJaWYgKHN0cmVhbS0+dGltaW5n
LmZsYWdzLkRTQyAmJiBhY29ubmVjdG9yLT5kc2Nfc2V0dGluZ3MuZHNjX2JpdHNfcGVyX3BpeGVs
KQogCQlzdHJlYW0tPnRpbWluZy5kc2NfY2ZnLmJpdHNfcGVyX3BpeGVsID0gYWNvbm5lY3Rvci0+
ZHNjX3NldHRpbmdzLmRzY19iaXRzX3Blcl9waXhlbDsKLSNlbmRpZgogfQorI2VuZGlmCiAKIHN0
YXRpYyBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqCiBnZXRfaGlnaGVzdF9yZWZyZXNoX3JhdGVf
bW9kZShzdHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAqYWNvbm5lY3RvciwKLS0gCjIuMzEuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
