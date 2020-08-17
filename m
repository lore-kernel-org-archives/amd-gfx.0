Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8F1C433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 15:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E43D23B42
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 15:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQic9FLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E43D23B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD76D6E329;
	Mon, 17 Aug 2020 15:27:25 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E867D6E123
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 15:24:44 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5311523444;
 Mon, 17 Aug 2020 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597677884;
 bh=k0AAVlIdFxxPOjKzHe5fG2GOOoYHzTyXq4uUWXtFjUg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nQic9FLu+Px6ZvJPd++eXw64WnKZ79YVAu8pdWW+lwdma1br2687VfShHOn3XS+gC
 4E8kGvJiA1HOG0IAKR8es8hGNU8zJfzhhNA9uw1j5ybpOqtDsGBWrrSVe62A6iEKBK
 bXZevZErxBbFNj4quckIMR2wwR/oT+gf+Dsedepo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5.8 143/464] drm/amdgpu: use the unlocked drm_gem_object_put
Date: Mon, 17 Aug 2020 17:11:36 +0200
Message-Id: <20200817143840.663904894@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 17 Aug 2020 15:27:25 +0000
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
Cc: Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>, Sam Ravnborg <sam@ravnborg.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KClsgVXBzdHJl
YW0gY29tbWl0IDFhODdmNjdhNjZkZTRhZDBjMGQ3OWZkODZiNmM1MjczMTQzMzg3YzMgXQoKVGhl
IGRyaXZlciBkb2VzIG5vdCBob2xkIHN0cnVjdF9tdXRleCwgdGh1cyB1c2luZyB0aGUgbG9ja2Vk
IHZlcnNpb24gb2YKdGhlIGhlbHBlciBpcyBpbmNvcnJlY3QuCgpDYzogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKRml4ZXM6
IGEzOTQxNDcxNmNhMCAoImRybS9hbWRncHU6IGFkZCBpbmRlcGVuZGVudCBETUEtYnVmIGltcG9y
dCB2OSIpClNpZ25lZC1vZmYtYnk6IEVtaWwgVmVsaWtvdiA8ZW1pbC52ZWxpa292QGNvbGxhYm9y
YS5jb20+CkFja2VkLWJ5OiBTYW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+ClJldmlld2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkFja2VkLWJ5
OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4KTGluazogaHR0cHM6Ly9w
YXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoL21zZ2lkLzIwMjAwNTE1MDk1MTE4LjI3NDMx
MjItOC1lbWlsLmwudmVsaWtvdkBnbWFpbC5jb20KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4g
PHNhc2hhbEBrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kbWFfYnVmLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZG1hX2J1Zi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYwpp
bmRleCA0M2Q4ZWQ3ZGJkMDAxLi42NTJjNTdhM2I4NDc4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMKQEAgLTU4Nyw3ICs1ODcsNyBAQCBzdHJ1Y3QgZHJt
X2dlbV9vYmplY3QgKmFtZGdwdV9nZW1fcHJpbWVfaW1wb3J0KHN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYsCiAJYXR0YWNoID0gZG1hX2J1Zl9keW5hbWljX2F0dGFjaChkbWFfYnVmLCBkZXYtPmRldiwK
IAkJCQkJJmFtZGdwdV9kbWFfYnVmX2F0dGFjaF9vcHMsIG9iaik7CiAJaWYgKElTX0VSUihhdHRh
Y2gpKSB7Ci0JCWRybV9nZW1fb2JqZWN0X3B1dChvYmopOworCQlkcm1fZ2VtX29iamVjdF9wdXRf
dW5sb2NrZWQob2JqKTsKIAkJcmV0dXJuIEVSUl9DQVNUKGF0dGFjaCk7CiAJfQogCi0tIAoyLjI1
LjEKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
