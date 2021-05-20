Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323ABC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCFC611AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCFC611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1783A6F473;
	Thu, 20 May 2021 12:49:18 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9578A88C4C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:15 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id i17so17365154wrq.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RiZqS9+1VsUhQi4zCxRm7Qw/CQ+SCMejCROZ7vBDCII=;
 b=LeaXNvmDhLUKi4BpNVSHVz+CuQI0q/bnPzQUee6sPiX5zlHptWrRN5TnlO/9eMmO3d
 RGyObjyUw2hvL4jVWFP4RlE1K8EJBpiwCVh/smcZB4ORsXMIqkXNyj8uczuQitGuKpUB
 O3p1wIPaBo1bMpEqD4d4dUsMjy5nfPwOQK/cxGLjSwb0Wz8xA8F9z7vlGzuZ+Gva+5TY
 TnXjJCpxlD+w5dkect5TfTUzDdZPuSx7aS7Ao4r801uP97zZSNfdf3DjpugBhJ9+GSHT
 W5kWvP2N271CNZ3lHnoSg7bM25HzaEzuWdI/q5c+IPdKq6MHCj0ivH65XU2V5JsV2PG0
 SfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RiZqS9+1VsUhQi4zCxRm7Qw/CQ+SCMejCROZ7vBDCII=;
 b=WW7AhkWGoG5rzQaHFEqxIs3/ElNghEMX1IWL78gM12CANvHVIIa4hfU0Cz44mZGmO5
 uQz8UJgHbtUalpFA1MfvuPK6FCAl7Z4BnLjc3VISsWE2qawiJIeO2CMORzarCnxj3kzP
 jsQDaNPEbCOoYTn1kmL+XBwSa9s7DmzqLGp+x0BK6zekjMIrFaDUAAhjr1lIZfmwzmV9
 o1w9QbvRP1mEaA8kb2hpQ9H9qkRzjLUdTuREocWQuLWbcnK8Y/M6g0ktYc0Pmd7UlIS3
 jjhjz2LrUOWpI1stKKjmWRU3Ix8XRxIHYHI4j44d0C7fffzFt9622a1KBfr7n6/Cvbvx
 S1RA==
X-Gm-Message-State: AOAM5332QqhXQiFInQ7Bk15BCfXALwhL1QIlG1mb4BtneBlqn1YjMZZj
 HR9SVxm6MDL361z8YC7NFHDCNA==
X-Google-Smtp-Source: ABdhPJwNbytM3HbZfJrhsQBc/jh4ZR3fXPG/OAOnPVHn358PMshvhBLhygc8EHr8vcYofNRgWWb9Ww==
X-Received: by 2002:a05:6000:1286:: with SMTP id
 f6mr3803164wrx.226.1621512193588; 
 Thu, 20 May 2021 05:03:13 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:13 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 21/38] drm/amd/include/aldebaran_ip_offset: Mark top-level
 IP_BASE as __maybe_unused
Date: Thu, 20 May 2021 13:02:31 +0100
Message-Id: <20210520120248.3464013-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 20 May 2021 12:49:10 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5jbHVkZS9hbGRlYmFyYW5faXBfb2Zmc2V0Lmg6MjU5
OjI5OiB3YXJuaW5nOiDigJhYR01JMl9CQVNF4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3Vu
dXNlZC1jb25zdC12YXJpYWJsZT1dCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNs
dWRlL2FsZGViYXJhbl9pcF9vZmZzZXQuaDoyNTI6Mjk6IHdhcm5pbmc6IOKAmFhHTUkxX0JBU0Xi
gJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYWxkZWJhcmFuX2lwX29mZnNldC5oOjI0
NToyOTogd2FybmluZzog4oCYWEdNSTBfQkFTReKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1
bnVzZWQtY29uc3QtdmFyaWFibGU9XQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5j
bHVkZS9hbGRlYmFyYW5faXBfb2Zmc2V0Lmg6MjM4OjI5OiB3YXJuaW5nOiDigJhXQUZMMV9CQVNF
4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9pbmNsdWRlL2FsZGViYXJhbl9pcF9vZmZzZXQuaDoy
MzE6Mjk6IHdhcm5pbmc6IOKAmFdBRkwwX0JBU0XigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1X
dW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2lu
Y2x1ZGUvYWxkZWJhcmFuX2lwX29mZnNldC5oOjE2MToyOTogd2FybmluZzog4oCYUENJRTBfQkFT
ReKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5jbHVkZS9hbGRlYmFyYW5faXBfb2Zmc2V0Lmg6
MTE5OjI5OiB3YXJuaW5nOiDigJhMMklNVTBfQkFTReKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBb
LVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4v
aW5jbHVkZS9hbGRlYmFyYW5faXBfb2Zmc2V0Lmg6MTEyOjI5OiB3YXJuaW5nOiDigJhMMUlNVVBD
SUUwX0JBU0XigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxl
PV0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYWxkZWJhcmFuX2lwX29m
ZnNldC5oOjEwNToyOTogd2FybmluZzog4oCYTDFJTVVJT0FHUjBfQkFTReKAmSBkZWZpbmVkIGJ1
dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vaW5jbHVkZS9hbGRlYmFyYW5faXBfb2Zmc2V0Lmg6OTg6Mjk6IHdhcm5pbmc6
IOKAmElPSEMwX0JBU0XigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZh
cmlhYmxlPV0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYWxkZWJhcmFu
X2lwX29mZnNldC5oOjkxOjI5OiB3YXJuaW5nOiDigJhJT0FQSUMwX0JBU0XigJkgZGVmaW5lZCBi
dXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYWxkZWJhcmFuX2lwX29mZnNldC5oOjg0OjI5OiB3YXJuaW5n
OiDigJhJT0FHUjBfQkFTReKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3Qt
dmFyaWFibGU9XQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5jbHVkZS9hbGRlYmFy
YW5faXBfb2Zmc2V0Lmg6NjM6Mjk6IHdhcm5pbmc6IOKAmEZVU0VfQkFTReKAmSBkZWZpbmVkIGJ1
dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vaW5jbHVkZS9hbGRlYmFyYW5faXBfb2Zmc2V0Lmg6NDk6Mjk6IHdhcm5pbmc6
IOKAmERCR1VfSU8wX0JBU0XigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0
LXZhcmlhYmxlPV0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2luY2x1ZGUvYWxkZWJh
cmFuX2lwX29mZnNldC5oOjQyOjI5OiB3YXJuaW5nOiDigJhDTEtfQkFTReKAmSBkZWZpbmVkIGJ1
dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQoKQ2M6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpD
YzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogSGF3a2luZyBaaGFuZyA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6
IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVz
IDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUv
YWxkZWJhcmFuX2lwX29mZnNldC5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNs
dWRlL2FsZGViYXJhbl9pcF9vZmZzZXQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9h
bGRlYmFyYW5faXBfb2Zmc2V0LmgKaW5kZXggNjQ0ZmZlYzJiMGNlOC4uY2RkNDI2YjQxYzIwZSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FsZGViYXJhbl9pcF9vZmZz
ZXQuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYWxkZWJhcmFuX2lwX29mZnNl
dC5oCkBAIC0zMCw3ICszMCw3IEBAIHN0cnVjdCBJUF9CQVNFX0lOU1RBTkNFIHsKIAogc3RydWN0
IElQX0JBU0UgewogICAgIHN0cnVjdCBJUF9CQVNFX0lOU1RBTkNFIGluc3RhbmNlW01BWF9JTlNU
QU5DRV07Ci19OworfSBfX21heWJlX3VudXNlZDsKIAogc3RhdGljIGNvbnN0IHN0cnVjdCBJUF9C
QVNFIEFUSFVCX0JBU0UgPSB7IHsgeyB7IDB4MDAwMDBDMjAsIDB4MDI0MDhDMDAsIDAsIDAsIDAs
IDAgfSB9LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHsgeyAwLCAw
LCAwLCAwLCAwLCAwIH0gfSwKLS0gCjIuMzEuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
