Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F4EC47409
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FCDB246B7
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIiaB14i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCDB246B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D1AD6E836;
	Fri, 14 Feb 2020 16:13:10 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F476FA93;
 Fri, 14 Feb 2020 16:13:07 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4056824696;
 Fri, 14 Feb 2020 16:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581696787;
 bh=iAqYGLyVkYUetROcmctoKKpzGBAgC5kjLQhn2Fx+Tlo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EIiaB14iCWs7YjCrRnh9oGBjuuZB/EOeYf5ysKTaKXWpr1jVZAw58eTk5FizJrNDV
 WTfrAdg6HSX+XrQggU+Hr+N18/S/EEp34x1s1lDn7MdI7k30Yc/Mi46Dcv67cLIvIh
 FVyXhtZONPPwjy73H5bPKyRkFp32R3bJm+LOdnMQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 062/252] drm/amd/powerplay: remove set but not
 used variable 'us_mvdd'
Date: Fri, 14 Feb 2020 11:08:37 -0500
Message-Id: <20200214161147.15842-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Alex Deucher <alexander.deucher@amd.com>, yu kuai <yukuai3@huawei.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogeXUga3VhaSA8eXVrdWFpM0BodWF3ZWkuY29tPgoKWyBVcHN0cmVhbSBjb21taXQgNDcy
YjM2YTJhYjY3ODgwZTg5ZDZiMGNkMGUyNDM4MzBlOGNiNzVlMSBdCgpGaXhlcyBnY2MgJy1XdW51
c2VkLWJ1dC1zZXQtdmFyaWFibGUnIHdhcm5pbmc6Cgpkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9zbXVtZ3IvdmVnYW1fc211bWdyLmM6IEluCmZ1bmN0aW9uIOKAmHZlZ2FtX3BvcHVsYXRl
X3NtY19hY3BpX2xldmVs4oCZOgpkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3Iv
dmVnYW1fc211bWdyLmM6MTExNzoxMToKd2FybmluZzogdmFyaWFibGUgJ3VzX212ZGQnIHNldCBi
dXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCgpJdCBpcyBuZXZlciB1c2Vk
LCBzbyBjYW4gYmUgcmVtb3ZlZC4KCkZpeGVzOiBhYzc4MjJiMDAyNmYgKCJkcm0vYW1kL3Bvd2Vy
cGxheTogYWRkIHNtdW1nciBzdXBwb3J0IGZvciBWRUdBTSAodjIpIikKU2lnbmVkLW9mZi1ieTog
eXUga3VhaSA8eXVrdWFpM0BodWF3ZWkuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxz
YXNoYWxAa2VybmVsLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVt
Z3IvdmVnYW1fc211bWdyLmMgfCAxMiAtLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9z
bXVtZ3IvdmVnYW1fc211bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVt
Z3IvdmVnYW1fc211bWdyLmMKaW5kZXggNTkxMTNmZGQxYzFjMS4uNGNkZTg3YTNmMjM4OCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3ZlZ2FtX3NtdW1n
ci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci92ZWdhbV9zbXVt
Z3IuYwpAQCAtMTExNCw3ICsxMTE0LDYgQEAgc3RhdGljIGludCB2ZWdhbV9wb3B1bGF0ZV9zbWNf
YWNwaV9sZXZlbChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAogCQkJKHN0cnVjdCBwaG1fcHB0X3Yx
X2luZm9ybWF0aW9uICopKGh3bWdyLT5wcHRhYmxlKTsKIAlTTUlPX1BhdHRlcm4gdm9sX2xldmVs
OwogCXVpbnQzMl90IG12ZGQ7Ci0JdWludDE2X3QgdXNfbXZkZDsKIAogCXRhYmxlLT5BQ1BJTGV2
ZWwuRmxhZ3MgJj0gflBQU01DX1NXU1RBVEVfRkxBR19EQzsKIApAQCAtMTE2OCwxNyArMTE2Nyw2
IEBAIHN0YXRpYyBpbnQgdmVnYW1fcG9wdWxhdGVfc21jX2FjcGlfbGV2ZWwoc3RydWN0IHBwX2h3
bWdyICpod21nciwKIAkJCSJpbiBDbG9jayBEZXBlbmRlbmN5IFRhYmxlIiwKIAkJCSk7CiAKLQl1
c19tdmRkID0gMDsKLQlpZiAoKFNNVTdfVk9MVEFHRV9DT05UUk9MX05PTkUgPT0gZGF0YS0+bXZk
ZF9jb250cm9sKSB8fAotCQkJKGRhdGEtPm1jbGtfZHBtX2tleV9kaXNhYmxlZCkpCi0JCXVzX212
ZGQgPSBkYXRhLT52Ymlvc19ib290X3N0YXRlLm12ZGRfYm9vdHVwX3ZhbHVlOwotCWVsc2Ugewot
CQlpZiAoIXZlZ2FtX3BvcHVsYXRlX212ZGRfdmFsdWUoaHdtZ3IsCi0JCQkJZGF0YS0+ZHBtX3Rh
YmxlLm1jbGtfdGFibGUuZHBtX2xldmVsc1swXS52YWx1ZSwKLQkJCQkmdm9sX2xldmVsKSkKLQkJ
CXVzX212ZGQgPSB2b2xfbGV2ZWwuVm9sdGFnZTsKLQl9Ci0KIAlpZiAoIXZlZ2FtX3BvcHVsYXRl
X212ZGRfdmFsdWUoaHdtZ3IsIDAsICZ2b2xfbGV2ZWwpKQogCQl0YWJsZS0+TWVtb3J5QUNQSUxl
dmVsLk1pbk12ZGQgPSBQUF9IT1NUX1RPX1NNQ19VTCh2b2xfbGV2ZWwuVm9sdGFnZSk7CiAJZWxz
ZQotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
