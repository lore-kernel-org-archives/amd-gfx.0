Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A438AC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF5B208A7
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+df3N1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF5B208A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D18E6E9C0;
	Mon,  8 Jun 2020 23:21:51 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10C66E9BF;
 Mon,  8 Jun 2020 23:21:49 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B385D208B3;
 Mon,  8 Jun 2020 23:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591658509;
 bh=qvMEqAuOf5Z/TluxxmrPx3SKltHINKkkkiAXGoLWkaA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l+df3N1+SndCxyYknxS80q3yv5EZHZFNKNaK05WjtnwbJbHYegkhe1CPF7QEUbRJ8
 uXkBYz2r6oPS/uO2wg1lNc8qcDfoj+pR3IUiOUIZYYBuRN/I2v8rV98x4RZMjaGfx+
 8oNKJsSJzDpNO42GWCOpYfYnZ4ySueTYpY2KN1Us=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 139/175] drm/amdgpu: Sync with VM root BO when
 switching VM to CPU update mode
Date: Mon,  8 Jun 2020 19:18:12 -0400
Message-Id: <20200608231848.3366970-139-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Jay Cornwall <Jay.Cornwall@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpbIFVwc3RyZWFt
IGNvbW1pdCA5MGNhNzhkZWIwMDRhYmU3NWI1MDI0OTY4YTE5OWFjYjk2YmI3MGY5IF0KClRoaXMg
Zml4ZXMgYW4gaW50ZXJtaXR0ZW50IGJ1ZyB3aGVyZSBhIHJvb3QgUEQgY2xlYXIgb3BlcmF0aW9u
IHN0aWxsIGluCnByb2dyZXNzIGNvdWxkIG92ZXJ3cml0ZSBhIFBERSB1cGRhdGUgZG9uZSBieSB0
aGUgQ1BVLCByZXN1bHRpbmcgaW4gYQpWTSBmYXVsdC4KCkZpeGVzOiAxMDhiNGQ5MjhjMDMgKCJk
cm0vYW1kL2FtZGdwdTogVXBkYXRlIFZNIGZ1bmN0aW9uIHBvaW50ZXIiKQpSZXBvcnRlZC1ieTog
SmF5IENvcm53YWxsIDxKYXkuQ29ybndhbGxAYW1kLmNvbT4KVGVzdGVkLWJ5OiBKYXkgQ29ybndh
bGwgPEpheS5Db3Jud2FsbEBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8
RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFs
QGtlcm5lbC5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMg
fCAxMSArKysrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4IGM3NTE0
Zjc0MzQwOS4uNjMzNWJkNGFlMzc0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYwpAQCAtMjg2NywxMCArMjg2NywxNyBAQCBpbnQgYW1kZ3B1X3ZtX21ha2VfY29tcHV0ZShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sIHVucwogCVdB
Uk5fT05DRSgodm0tPnVzZV9jcHVfZm9yX3VwZGF0ZSAmJiAhYW1kZ3B1X2dtY192cmFtX2Z1bGxf
dmlzaWJsZSgmYWRldi0+Z21jKSksCiAJCSAgIkNQVSB1cGRhdGUgb2YgVk0gcmVjb21tZW5kZWQg
b25seSBmb3IgbGFyZ2UgQkFSIHN5c3RlbVxuIik7CiAKLQlpZiAodm0tPnVzZV9jcHVfZm9yX3Vw
ZGF0ZSkKKwlpZiAodm0tPnVzZV9jcHVfZm9yX3VwZGF0ZSkgeworCQkvKiBTeW5jIHdpdGggbGFz
dCBTRE1BIHVwZGF0ZS9jbGVhciBiZWZvcmUgc3dpdGNoaW5nIHRvIENQVSAqLworCQlyID0gYW1k
Z3B1X2JvX3N5bmNfd2FpdCh2bS0+cm9vdC5iYXNlLmJvLAorCQkJCQlBTURHUFVfRkVOQ0VfT1dO
RVJfVU5ERUZJTkVELCB0cnVlKTsKKwkJaWYgKHIpCisJCQlnb3RvIGZyZWVfaWRyOworCiAJCXZt
LT51cGRhdGVfZnVuY3MgPSAmYW1kZ3B1X3ZtX2NwdV9mdW5jczsKLQllbHNlCisJfSBlbHNlIHsK
IAkJdm0tPnVwZGF0ZV9mdW5jcyA9ICZhbWRncHVfdm1fc2RtYV9mdW5jczsKKwl9CiAJZG1hX2Zl
bmNlX3B1dCh2bS0+bGFzdF91cGRhdGUpOwogCXZtLT5sYXN0X3VwZGF0ZSA9IE5VTEw7CiAKLS0g
CjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
