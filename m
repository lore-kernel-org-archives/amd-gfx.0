Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B33C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 08:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A352196E
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 08:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A352196E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2574D6EA75;
	Tue, 12 Nov 2019 08:44:50 +0000 (UTC)
Received: from smtprelay.hostedemail.com (smtprelay0182.hostedemail.com
 [216.40.44.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 222366E0D2;
 Tue, 12 Nov 2019 02:39:34 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 7B961181D3026;
 Tue, 12 Nov 2019 02:39:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: end54_35f6dbbf31b05
X-Filterd-Recvd-Size: 2553
Received: from XPS-9350.home (unknown [47.151.135.224])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Tue, 12 Nov 2019 02:39:30 +0000 (UTC)
Message-ID: <01c630e6d4c58b3f6184603e158f53fb9aaeae7d.camel@perches.com>
Subject: Re: [PATCH -next] drm/amd/display: Fix old-style declaration
From: Joe Perches <joe@perches.com>
To: YueHaibing <yuehaibing@huawei.com>, harry.wentland@amd.com, 
 sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 Bhawanpreet.Lakha@amd.com,  Jun.Lei@amd.com, David.Francis@amd.com,
 Dmytro.Laktyushkin@amd.com,  nicholas.kazlauskas@amd.com,
 martin.leung@amd.com, Chris.Park@amd.com
Date: Mon, 11 Nov 2019 18:39:15 -0800
In-Reply-To: <20191111122801.18584-1-yuehaibing@huawei.com>
References: <20191111122801.18584-1-yuehaibing@huawei.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 12 Nov 2019 08:44:49 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112023915.wXFJ_5idaRDvStFIZ3HhKkvgKTS_FFs_OBzZY2sZE2c@z>

T24gTW9uLCAyMDE5LTExLTExIGF0IDIwOjI4ICswODAwLCBZdWVIYWliaW5nIHdyb3RlOgo+IEZp
eCBhIGJ1aWxkIHdhcm5pbmc6Cj4gCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlz
cGxheS9kYy9jb3JlL2RjLmM6NzU6MToKPiAgd2FybmluZzogJ3N0YXRpYycgaXMgbm90IGF0IGJl
Z2lubmluZyBvZiBkZWNsYXJhdGlvbiBbLVdvbGQtc3R5bGUtZGVjbGFyYXRpb25dCltdCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCltdCj4gQEAgLTY5LDcgKzY5LDcg
QEAKPiAgI2RlZmluZSBEQ19MT0dHRVIgXAo+ICAJZGMtPmN0eC0+bG9nZ2VyCj4gIAo+IC1jb25z
dCBzdGF0aWMgY2hhciBEQ19CVUlMRF9JRFtdID0gInByb2R1Y3Rpb24tYnVpbGQiOwo+ICtzdGF0
aWMgY29uc3QgY2hhciBEQ19CVUlMRF9JRFtdID0gInByb2R1Y3Rpb24tYnVpbGQiOwoKRENfQlVJ
TERfSUQgaXMgdXNlZCBleGFjdGx5IG9uY2UuCk1heWJlIGp1c3QgdXNlIGl0IGRpcmVjdGx5IGFu
ZCByZW1vdmUgRENfQlVJTERfSUQgaW5zdGVhZD8KCi0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGMuYyB8IDQgKy0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9jb3JlL2RjLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9k
Yy5jCmluZGV4IDFmZGJhMTMuLjgwM2RjMTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9jb3JlL2RjLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGMuYwpAQCAtNjksOCArNjksNiBAQAogI2RlZmluZSBEQ19MT0dHRVIgXAogCWRj
LT5jdHgtPmxvZ2dlcgogCi1jb25zdCBzdGF0aWMgY2hhciBEQ19CVUlMRF9JRFtdID0gInByb2R1
Y3Rpb24tYnVpbGQiOwotCiAvKioKICAqIERPQzogT3ZlcnZpZXcKICAqCkBAIC04MTUsNyArODEz
LDcgQEAgc3RydWN0IGRjICpkY19jcmVhdGUoY29uc3Qgc3RydWN0IGRjX2luaXRfZGF0YSAqaW5p
dF9wYXJhbXMpCiAJaWYgKGRjLT5yZXNfcG9vbC0+ZG1jdSAhPSBOVUxMKQogCQlkYy0+dmVyc2lv
bnMuZG1jdV92ZXJzaW9uID0gZGMtPnJlc19wb29sLT5kbWN1LT5kbWN1X3ZlcnNpb247CiAKLQlk
Yy0+YnVpbGRfaWQgPSBEQ19CVUlMRF9JRDsKKwlkYy0+YnVpbGRfaWQgPSAicHJvZHVjdGlvbi1i
dWlsZCI7CiAKIAlEQ19MT0dfREMoIkRpc3BsYXkgQ29yZSBpbml0aWFsaXplZFxuIik7CiAKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
