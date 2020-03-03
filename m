Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2321C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 20:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C5B20CC7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 20:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqLUnBvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C5B20CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 798C66E946;
	Tue,  3 Mar 2020 20:14:09 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4992C6E93A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 17:55:26 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C58D2072D;
 Tue,  3 Mar 2020 17:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583258126;
 bh=4tOmSmVMe3mvmllK6G1Y4slRC9SU/jQaGPx0xsYACAc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YqLUnBvv6HYLLlkhZ78QE9kVYC3uJiUyKvcAgiGzzmeYfZYCALdZtLK5kluerNcga
 ZMjIqGIkZhYsl7xL59bzxi2peo5JePRklkZ4xn3tM1njblFoh40QzfTaVOgItRtMKP
 IuDqkPcJWlO50aDvhFLyYtjozK0DZ7P6OLsT+yS0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5.4 080/152] drm/radeon: Inline drm_get_pci_dev
Date: Tue,  3 Mar 2020 18:42:58 +0100
Message-Id: <20200303174311.613425292@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 03 Mar 2020 20:14:07 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4KCmNvbW1pdCBlYjEy
Yzk1NzczNWI1ODI2MDdlNTg0MmEwNmQxZjRjNjJlMTg1YzFkIHVwc3RyZWFtLgoKSXQncyB0aGUg
bGFzdCB1c2VyLCBhbmQgbW9yZSBpbXBvcnRhbnRseSwgaXQncyB0aGUgbGFzdCBub24tbGVnYWN5
CnVzZXIgb2YgYW55dGhpbmcgaW4gZHJtX3BjaS5jLgoKVGhlIG9ubHkgdHJpY2t5IGJpdCBpcyB0
aGUgYWdwIGluaXRpYWxpemF0aW9uLiBCdXQgYSBjbG9zZSBsb29rIHNob3dzCnRoYXQgcmFkZW9u
IGRvZXMgbm90IHVzZSB0aGUgZHJtX2FncCBtaWRsYXllciAodGhlIG1haW4gdXNlIG9mIHRoYXQg
aXMKZHJtX2J1ZnMgZm9yIGxlZ2FjeSBkcml2ZXJzKSwgYW5kIGluc3RlYWQgY291bGQgdXNlIHRo
ZSBhZ3Agc3Vic3lzdGVtCmRpcmVjdGx5IChsaWtlIG5vdXZlYXUgZG9lcyBhbHJlYWR5KS4gSGVu
Y2Ugd2UgY2FuIGp1c3QgcHVsbCB0aGlzIGluCnRvby4KCkEgZnVydGhlciBzdGVwIHdvdWxkIGJl
IHRvIGVudGlyZWx5IGRyb3AgdGhlIHVzZSBvZiBkcm1fZGV2aWNlLT5hZ3AsCmJ1dCBmZWVscyBs
aWtlIHRvbyBtdWNoIGNodXJuIGp1c3QgZm9yIHRoaXMgcGF0Y2guCgpTaWduZWQtb2ZmLWJ5OiBE
YW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVyQGludGVsLmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogIkRhdmlkIChDaHVuTWluZykgWmhvdSIgPERhdmlkMS5a
aG91QGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpSZXZpZXdlZC1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpSZXZpZXdlZC1ieTog
RW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KU2lnbmVkLW9mZi1ieTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnPgoKLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYu
YyB8ICAgNDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYyB8ICAgIDYgKysrKysKIDIgZmlsZXMgY2hhbmdlZCwg
NDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX2Rydi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Ry
di5jCkBAIC0zNyw2ICszNyw3IEBACiAjaW5jbHVkZSA8bGludXgvdmdhX3N3aXRjaGVyb28uaD4K
ICNpbmNsdWRlIDxsaW51eC9tbXVfbm90aWZpZXIuaD4KIAorI2luY2x1ZGUgPGRybS9kcm1fYWdw
c3VwcG9ydC5oPgogI2luY2x1ZGUgPGRybS9kcm1fY3J0Y19oZWxwZXIuaD4KICNpbmNsdWRlIDxk
cm0vZHJtX2Rydi5oPgogI2luY2x1ZGUgPGRybS9kcm1fZmJfaGVscGVyLmg+CkBAIC0zMjUsNiAr
MzI2LDcgQEAgc3RhdGljIGludCByYWRlb25fcGNpX3Byb2JlKHN0cnVjdCBwY2lfZAogCQkJICAg
IGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICplbnQpCiB7CiAJdW5zaWduZWQgbG9uZyBmbGFn
cyA9IDA7CisJc3RydWN0IGRybV9kZXZpY2UgKmRldjsKIAlpbnQgcmV0OwogCiAJaWYgKCFlbnQp
CkBAIC0zNjUsNyArMzY3LDQ0IEBAIHN0YXRpYyBpbnQgcmFkZW9uX3BjaV9wcm9iZShzdHJ1Y3Qg
cGNpX2QKIAlpZiAocmV0KQogCQlyZXR1cm4gcmV0OwogCi0JcmV0dXJuIGRybV9nZXRfcGNpX2Rl
dihwZGV2LCBlbnQsICZrbXNfZHJpdmVyKTsKKwlkZXYgPSBkcm1fZGV2X2FsbG9jKCZrbXNfZHJp
dmVyLCAmcGRldi0+ZGV2KTsKKwlpZiAoSVNfRVJSKGRldikpCisJCXJldHVybiBQVFJfRVJSKGRl
dik7CisKKwlyZXQgPSBwY2lfZW5hYmxlX2RldmljZShwZGV2KTsKKwlpZiAocmV0KQorCQlnb3Rv
IGVycl9mcmVlOworCisJZGV2LT5wZGV2ID0gcGRldjsKKyNpZmRlZiBfX2FscGhhX18KKwlkZXYt
Pmhvc2UgPSBwZGV2LT5zeXNkYXRhOworI2VuZGlmCisKKwlwY2lfc2V0X2RydmRhdGEocGRldiwg
ZGV2KTsKKworCWlmIChwY2lfZmluZF9jYXBhYmlsaXR5KGRldi0+cGRldiwgUENJX0NBUF9JRF9B
R1ApKQorCQlkZXYtPmFncCA9IGRybV9hZ3BfaW5pdChkZXYpOworCWlmIChkZXYtPmFncCkgewor
CQlkZXYtPmFncC0+YWdwX210cnIgPSBhcmNoX3BoeXNfd2NfYWRkKAorCQkJZGV2LT5hZ3AtPmFn
cF9pbmZvLmFwZXJfYmFzZSwKKwkJCWRldi0+YWdwLT5hZ3BfaW5mby5hcGVyX3NpemUgKgorCQkJ
MTAyNCAqIDEwMjQpOworCX0KKworCXJldCA9IGRybV9kZXZfcmVnaXN0ZXIoZGV2LCBlbnQtPmRy
aXZlcl9kYXRhKTsKKwlpZiAocmV0KQorCQlnb3RvIGVycl9hZ3A7CisKKwlyZXR1cm4gMDsKKwor
ZXJyX2FncDoKKwlpZiAoZGV2LT5hZ3ApCisJCWFyY2hfcGh5c193Y19kZWwoZGV2LT5hZ3AtPmFn
cF9tdHJyKTsKKwlrZnJlZShkZXYtPmFncCk7CisJcGNpX2Rpc2FibGVfZGV2aWNlKHBkZXYpOwor
ZXJyX2ZyZWU6CisJZHJtX2Rldl9wdXQoZGV2KTsKKwlyZXR1cm4gcmV0OwogfQogCiBzdGF0aWMg
dm9pZApAQCAtNTc4LDcgKzYxNyw3IEBAIHJhZGVvbl9nZXRfY3J0Y19zY2Fub3V0X3Bvc2l0aW9u
KHN0cnVjdAogCiBzdGF0aWMgc3RydWN0IGRybV9kcml2ZXIga21zX2RyaXZlciA9IHsKIAkuZHJp
dmVyX2ZlYXR1cmVzID0KLQkgICAgRFJJVkVSX1VTRV9BR1AgfCBEUklWRVJfR0VNIHwgRFJJVkVS
X1JFTkRFUiwKKwkgICAgRFJJVkVSX0dFTSB8IERSSVZFUl9SRU5ERVIsCiAJLmxvYWQgPSByYWRl
b25fZHJpdmVyX2xvYWRfa21zLAogCS5vcGVuID0gcmFkZW9uX2RyaXZlcl9vcGVuX2ttcywKIAku
cG9zdGNsb3NlID0gcmFkZW9uX2RyaXZlcl9wb3N0Y2xvc2Vfa21zLAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9rbXMuYwpAQCAtMzEsNiArMzEsNyBAQAogI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4K
ICNpbmNsdWRlIDxsaW51eC92Z2Ffc3dpdGNoZXJvby5oPgogCisjaW5jbHVkZSA8ZHJtL2RybV9h
Z3BzdXBwb3J0Lmg+CiAjaW5jbHVkZSA8ZHJtL2RybV9mYl9oZWxwZXIuaD4KICNpbmNsdWRlIDxk
cm0vZHJtX2ZpbGUuaD4KICNpbmNsdWRlIDxkcm0vZHJtX2lvY3RsLmg+CkBAIC03Nyw2ICs3OCwx
MSBAQCB2b2lkIHJhZGVvbl9kcml2ZXJfdW5sb2FkX2ttcyhzdHJ1Y3QgZHJtCiAJcmFkZW9uX21v
ZGVzZXRfZmluaShyZGV2KTsKIAlyYWRlb25fZGV2aWNlX2ZpbmkocmRldik7CiAKKwlpZiAoZGV2
LT5hZ3ApCisJCWFyY2hfcGh5c193Y19kZWwoZGV2LT5hZ3AtPmFncF9tdHJyKTsKKwlrZnJlZShk
ZXYtPmFncCk7CisJZGV2LT5hZ3AgPSBOVUxMOworCiBkb25lX2ZyZWU6CiAJa2ZyZWUocmRldik7
CiAJZGV2LT5kZXZfcHJpdmF0ZSA9IE5VTEw7CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
