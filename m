Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1688C2D0BF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C3F214AF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 21:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u405EaP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C3F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27F216E99C;
	Tue, 10 Dec 2019 21:34:48 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D3E6E99C;
 Tue, 10 Dec 2019 21:34:46 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D8B91207FF;
 Tue, 10 Dec 2019 21:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576013686;
 bh=b/KjiDjETamHW9Y/8FNozm/dGxjife84uORnLJ/QAO0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=u405EaP1BZTq8noYYF8BaS8zTwV42211rlTiRHlfmyEt2mUf8xd4eWv+y+w/Cf3hd
 CRDqY441KJpIMNd4WLzpBIwtmBliv61QDz9a0V1OxFS7eEm6IVhr6jQKGUCWtyQAl8
 mH9zNFSRfZs0xfcS8KGdVC/C6Q9yPMIzVMhoVc1c=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 119/177] drm/amdgpu: fix potential double drop
 fence reference
Date: Tue, 10 Dec 2019 16:31:23 -0500
Message-Id: <20191210213221.11921-119-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Pan Bian <bianpan2016@163.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogUGFuIEJpYW4gPGJpYW5wYW4yMDE2QDE2My5jb20+CgpbIFVwc3RyZWFtIGNvbW1pdCA5
NDZhYjhkYjY5NTM1MzVhM2E4OGM5NTdkYjgzMjhiZWFjZGZlZDlkIF0KClRoZSBvYmplY3QgZmVu
Y2UgaXMgbm90IHNldCB0byBOVUxMIGFmdGVyIGl0cyByZWZlcmVuY2UgaXMgZHJvcHBlZC4gQXMg
YQpyZXN1bHQsIGl0cyByZWZlcmVuY2UgbWF5IGJlIGRyb3BwZWQgYWdhaW4gaWYgZXJyb3Igb2Nj
dXJzIGFmdGVyIHRoYXQsCndoaWNoIG1heSBsZWFkIHRvIGEgdXNlIGFmdGVyIGZyZWUgYnVnLiBU
byBhdm9pZCB0aGUgaXNzdWUsIGZlbmNlIGlzCmV4cGxpY2l0bHkgc2V0IHRvIE5VTEwgYWZ0ZXIg
ZHJvcHBpbmcgaXRzIHJlZmVyZW5jZS4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IFBhbiBCaWFuIDxiaWFucGFuMjAx
NkAxNjMuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdGVzdC5jIHwgMiArKwogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90ZXN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdGVzdC5jCmluZGV4IDg5MDRlNjJkY2E3YWUuLjQxZDMxNDJlZjNjZjAgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90ZXN0LmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rlc3QuYwpAQCAtMTM4LDYgKzEzOCw3IEBAIHN0
YXRpYyB2b2lkIGFtZGdwdV9kb190ZXN0X21vdmVzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQogCQl9CiAKIAkJZG1hX2ZlbmNlX3B1dChmZW5jZSk7CisJCWZlbmNlID0gTlVMTDsKIAogCQly
ID0gYW1kZ3B1X2JvX2ttYXAodnJhbV9vYmosICZ2cmFtX21hcCk7CiAJCWlmIChyKSB7CkBAIC0x
ODMsNiArMTg0LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RvX3Rlc3RfbW92ZXMoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCiAJCX0KIAogCQlkbWFfZmVuY2VfcHV0KGZlbmNlKTsKKwkJZmVu
Y2UgPSBOVUxMOwogCiAJCXIgPSBhbWRncHVfYm9fa21hcChndHRfb2JqW2ldLCAmZ3R0X21hcCk7
CiAJCWlmIChyKSB7Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
