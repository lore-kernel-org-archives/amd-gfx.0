Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE926C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A827C20872
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2T4PPlxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A827C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 212896E9B9;
	Mon,  8 Jun 2020 23:18:52 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63DEE6E9B1;
 Mon,  8 Jun 2020 23:18:50 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4375820823;
 Mon,  8 Jun 2020 23:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591658330;
 bh=nDJ5aA8yDvrtA35YXgEoanLshtxLTVoWR9hrb1QTiLY=;
 h=From:To:Cc:Subject:Date:From;
 b=2T4PPlxkwCQQyhVVHugx/bCig6Pc4MNb6wn15szWKgNZYs+9B8auoRetiwDoNuMS1
 JudeGVmYVRlLd/EisB8beElfwHo0dO5p/EDioadLXfNiC0VSKxI+cLrp24UES2fFAi
 PXpyYpBznr1zlCD1MPPz1viYNIxzc/igjGuG1CSw=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 001/175] drm/amdgpu: fix and cleanup
 amdgpu_gem_object_close v4
Date: Mon,  8 Jun 2020 19:15:54 -0400
Message-Id: <20200608231848.3366970-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
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
Cc: Sasha Levin <sashal@kernel.org>, xinhui pan <xinhui.pan@amd.com>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKWyBVcHN0
cmVhbSBjb21taXQgODJjNDE2YjEzY2I3ZDIyYjk2ZWMwODg4YjI5NmE0OGRmZjhhMDllYiBdCgpU
aGUgcHJvYmxlbSBpcyB0aGF0IHdlIGNhbid0IGFkZCB0aGUgY2xlYXIgZmVuY2UgdG8gdGhlIEJP
CndoZW4gdGhlcmUgaXMgYW4gZXhjbHVzaXZlIGZlbmNlIG9uIGl0IHNpbmNlIHdlIGNhbid0Cmd1
YXJhbnRlZSB0aGUgdGhlIGNsZWFyIGZlbmNlIHdpbGwgY29tcGxldGUgYWZ0ZXIgdGhlCmV4Y2x1
c2l2ZSBvbmUuCgpUbyBmaXggdGhpcyByZWZhY3RvciB0aGUgZnVuY3Rpb24gYW5kIGFsc28gYWRk
IHRoZSBleGNsdXNpdmUKZmVuY2UgYXMgc2hhcmVkIHRvIHRoZSByZXN2IG9iamVjdC4KCnYyOiBm
aXggd2FybmluZwp2MzogYWRkIGV4Y2wgZmVuY2UgYXMgc2hhcmVkIGluc3RlYWQKdjQ6IHNxdWFz
aCBpbiBmaXggZm9yIGZlbmNlIGhhbmRsaW5nIGluIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlCgpT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
ClJldmlld2VkLWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+ClNpZ25lZC1vZmYt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KU2lnbmVkLW9mZi1i
eTogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDQzICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKaW5kZXggOGNlYjQ0OTI1OTQ3Li41ZmE1MTU4
ZDE4ZWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0u
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKQEAgLTE2MSwx
NiArMTYxLDE3IEBAIHZvaWQgYW1kZ3B1X2dlbV9vYmplY3RfY2xvc2Uoc3RydWN0IGRybV9nZW1f
b2JqZWN0ICpvYmosCiAKIAlzdHJ1Y3QgYW1kZ3B1X2JvX2xpc3RfZW50cnkgdm1fcGQ7CiAJc3Ry
dWN0IGxpc3RfaGVhZCBsaXN0LCBkdXBsaWNhdGVzOworCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNl
ID0gTlVMTDsKIAlzdHJ1Y3QgdHRtX3ZhbGlkYXRlX2J1ZmZlciB0djsKIAlzdHJ1Y3Qgd3dfYWNx
dWlyZV9jdHggdGlja2V0OwogCXN0cnVjdCBhbWRncHVfYm9fdmEgKmJvX3ZhOwotCWludCByOwor
CWxvbmcgcjsKIAogCUlOSVRfTElTVF9IRUFEKCZsaXN0KTsKIAlJTklUX0xJU1RfSEVBRCgmZHVw
bGljYXRlcyk7CiAKIAl0di5ibyA9ICZiby0+dGJvOwotCXR2Lm51bV9zaGFyZWQgPSAxOworCXR2
Lm51bV9zaGFyZWQgPSAyOwogCWxpc3RfYWRkKCZ0di5oZWFkLCAmbGlzdCk7CiAKIAlhbWRncHVf
dm1fZ2V0X3BkX2JvKHZtLCAmbGlzdCwgJnZtX3BkKTsKQEAgLTE3OCwyOCArMTc5LDM0IEBAIHZv
aWQgYW1kZ3B1X2dlbV9vYmplY3RfY2xvc2Uoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmosCiAJ
ciA9IHR0bV9ldV9yZXNlcnZlX2J1ZmZlcnMoJnRpY2tldCwgJmxpc3QsIGZhbHNlLCAmZHVwbGlj
YXRlcywgZmFsc2UpOwogCWlmIChyKSB7CiAJCWRldl9lcnIoYWRldi0+ZGV2LCAibGVha2luZyBi
byB2YSBiZWNhdXNlICIKLQkJCSJ3ZSBmYWlsIHRvIHJlc2VydmUgYm8gKCVkKVxuIiwgcik7CisJ
CQkid2UgZmFpbCB0byByZXNlcnZlIGJvICglbGQpXG4iLCByKTsKIAkJcmV0dXJuOwogCX0KIAli
b192YSA9IGFtZGdwdV92bV9ib19maW5kKHZtLCBibyk7Ci0JaWYgKGJvX3ZhICYmIC0tYm9fdmEt
PnJlZl9jb3VudCA9PSAwKSB7Ci0JCWFtZGdwdV92bV9ib19ybXYoYWRldiwgYm9fdmEpOwotCi0J
CWlmIChhbWRncHVfdm1fcmVhZHkodm0pKSB7Ci0JCQlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSA9
IE5VTEw7CisJaWYgKCFib192YSB8fCAtLWJvX3ZhLT5yZWZfY291bnQpCisJCWdvdG8gb3V0X3Vu
bG9jazsKIAotCQkJciA9IGFtZGdwdV92bV9jbGVhcl9mcmVlZChhZGV2LCB2bSwgJmZlbmNlKTsK
LQkJCWlmICh1bmxpa2VseShyKSkgewotCQkJCWRldl9lcnIoYWRldi0+ZGV2LCAiZmFpbGVkIHRv
IGNsZWFyIHBhZ2UgIgotCQkJCQkidGFibGVzIG9uIEdFTSBvYmplY3QgY2xvc2UgKCVkKVxuIiwg
cik7Ci0JCQl9CisJYW1kZ3B1X3ZtX2JvX3JtdihhZGV2LCBib192YSk7CisJaWYgKCFhbWRncHVf
dm1fcmVhZHkodm0pKQorCQlnb3RvIG91dF91bmxvY2s7CiAKLQkJCWlmIChmZW5jZSkgewotCQkJ
CWFtZGdwdV9ib19mZW5jZShibywgZmVuY2UsIHRydWUpOwotCQkJCWRtYV9mZW5jZV9wdXQoZmVu
Y2UpOwotCQkJfQotCQl9CisJZmVuY2UgPSBkbWFfcmVzdl9nZXRfZXhjbChiby0+dGJvLmJhc2Uu
cmVzdik7CisJaWYgKGZlbmNlKSB7CisJCWFtZGdwdV9ib19mZW5jZShibywgZmVuY2UsIHRydWUp
OworCQlmZW5jZSA9IE5VTEw7CiAJfQorCisJciA9IGFtZGdwdV92bV9jbGVhcl9mcmVlZChhZGV2
LCB2bSwgJmZlbmNlKTsKKwlpZiAociB8fCAhZmVuY2UpCisJCWdvdG8gb3V0X3VubG9jazsKKwor
CWFtZGdwdV9ib19mZW5jZShibywgZmVuY2UsIHRydWUpOworCWRtYV9mZW5jZV9wdXQoZmVuY2Up
OworCitvdXRfdW5sb2NrOgorCWlmICh1bmxpa2VseShyIDwgMCkpCisJCWRldl9lcnIoYWRldi0+
ZGV2LCAiZmFpbGVkIHRvIGNsZWFyIHBhZ2UgIgorCQkJInRhYmxlcyBvbiBHRU0gb2JqZWN0IGNs
b3NlICglbGQpXG4iLCByKTsKIAl0dG1fZXVfYmFja29mZl9yZXNlcnZhdGlvbigmdGlja2V0LCAm
bGlzdCk7CiB9CiAKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
