Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAB0C010CF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 12:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8264F217F4
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 12:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8264F217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A0E6EA3B;
	Tue,  5 Nov 2019 12:43:48 +0000 (UTC)
X-Greylist: delayed 399 seconds by postgrey-1.36 at gabe;
 Tue, 05 Nov 2019 10:39:04 UTC
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6086E9BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 10:39:03 +0000 (UTC)
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO
 kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 31dc8ebde46860d1; Tue, 5 Nov 2019 11:32:21 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 4/5] PCI: PM: Avoid exporting __pci_complete_power_transition()
Date: Tue, 05 Nov 2019 11:30:36 +0100
Message-ID: <1731661.ykamz2Tiuf@kreacher>
In-Reply-To: <2771503.n70vfTtcVb@kreacher>
References: <2771503.n70vfTtcVb@kreacher>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 05 Nov 2019 12:43:46 +0000
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
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105103036.5nEwtpew3Ga7pfNf7JmgJPOnlQiYMSZPHHFy8Y5rg0o@z>

RnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPgoKTm90
aWNlIHRoYXQgcmFkZW9uX3NldF9zdXNwZW5kKCksIHdoaWNoIGlzIHRoZSBvbmx5IGNhbGxlciBv
ZgpfX3BjaV9jb21wbGV0ZV9wb3dlcl90cmFuc2l0aW9uKCkgb3V0c2lkZSBvZiBwY2kuYywgcmVh
bGx5IG9ubHkKY2FyZXMgYWJvdXQgdGhlIHBjaV9wbGF0Zm9ybV9wb3dlcl90cmFuc2l0aW9uKCkg
aW52b2tlZCBieSBpdCwKc28gZXhwb3J0IHRoZSBsYXR0ZXIgaW5zdGVhZCBvZiBpdCwgdXBkYXRl
IHRoZSByYWRlb24gZHJpdmVyIHRvCmNhbGwgcGNpX3BsYXRmb3JtX3Bvd2VyX3RyYW5zaXRpb24o
KSBkaXJlY3RseSBhbmQgbWFrZQpfX3BjaV9jb21wbGV0ZV9wb3dlcl90cmFuc2l0aW9uKCkgc3Rh
dGljLgoKQ29kZSByZWFycmFuZ2VtZW50LCBubyBpbnRlbnRpb25hbCBmdW5jdGlvbmFsIGltcGFj
dC4KClNpZ25lZC1vZmYtYnk6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGlu
dGVsLmNvbT4KLS0tCiBkcml2ZXJzL3BjaS9wY2kuYyAgICAgICAgICAgICAgICAgICB8ICAgIDYg
KysrLS0tCiBkcml2ZXJzL3ZpZGVvL2ZiZGV2L2F0eS9yYWRlb25fcG0uYyB8ICAgIDIgKy0KIGlu
Y2x1ZGUvbGludXgvcGNpLmggICAgICAgICAgICAgICAgIHwgICAgMiArLQogMyBmaWxlcyBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtcG0vZHJp
dmVycy9wY2kvcGNpLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtcG0ub3JpZy9kcml2ZXJzL3BjaS9w
Y2kuYworKysgbGludXgtcG0vZHJpdmVycy9wY2kvcGNpLmMKQEAgLTk2Myw3ICs5NjMsNyBAQCB2
b2lkIHBjaV9yZWZyZXNoX3Bvd2VyX3N0YXRlKHN0cnVjdCBwY2lfCiAgKiBAZGV2OiBQQ0kgZGV2
aWNlIHRvIGhhbmRsZS4KICAqIEBzdGF0ZTogU3RhdGUgdG8gcHV0IHRoZSBkZXZpY2UgaW50by4K
ICAqLwotc3RhdGljIGludCBwY2lfcGxhdGZvcm1fcG93ZXJfdHJhbnNpdGlvbihzdHJ1Y3QgcGNp
X2RldiAqZGV2LCBwY2lfcG93ZXJfdCBzdGF0ZSkKK2ludCBwY2lfcGxhdGZvcm1fcG93ZXJfdHJh
bnNpdGlvbihzdHJ1Y3QgcGNpX2RldiAqZGV2LCBwY2lfcG93ZXJfdCBzdGF0ZSkKIHsKIAlpbnQg
ZXJyb3I7CiAKQEAgLTk3OSw2ICs5NzksNyBAQCBzdGF0aWMgaW50IHBjaV9wbGF0Zm9ybV9wb3dl
cl90cmFuc2l0aW9uCiAKIAlyZXR1cm4gZXJyb3I7CiB9CitFWFBPUlRfU1lNQk9MX0dQTChwY2lf
cGxhdGZvcm1fcG93ZXJfdHJhbnNpdGlvbik7CiAKIC8qKgogICogcGNpX3dha2V1cCAtIFdha2Ug
dXAgYSBQQ0kgZGV2aWNlCkBAIC0xMDYxLDcgKzEwNjIsNyBAQCB2b2lkIHBjaV9idXNfc2V0X2N1
cnJlbnRfc3RhdGUoc3RydWN0IHBjCiAgKgogICogVGhpcyBmdW5jdGlvbiBzaG91bGQgbm90IGJl
IGNhbGxlZCBkaXJlY3RseSBieSBkZXZpY2UgZHJpdmVycy4KICAqLwotaW50IF9fcGNpX2NvbXBs
ZXRlX3Bvd2VyX3RyYW5zaXRpb24oc3RydWN0IHBjaV9kZXYgKmRldiwgcGNpX3Bvd2VyX3Qgc3Rh
dGUpCitzdGF0aWMgaW50IF9fcGNpX2NvbXBsZXRlX3Bvd2VyX3RyYW5zaXRpb24oc3RydWN0IHBj
aV9kZXYgKmRldiwgcGNpX3Bvd2VyX3Qgc3RhdGUpCiB7CiAJaW50IHJldDsKIApAQCAtMTA3Myw3
ICsxMDc0LDYgQEAgaW50IF9fcGNpX2NvbXBsZXRlX3Bvd2VyX3RyYW5zaXRpb24oc3RydQogCQlw
Y2lfYnVzX3NldF9jdXJyZW50X3N0YXRlKGRldi0+c3Vib3JkaW5hdGUsIFBDSV9EM2NvbGQpOwog
CXJldHVybiByZXQ7CiB9Ci1FWFBPUlRfU1lNQk9MX0dQTChfX3BjaV9jb21wbGV0ZV9wb3dlcl90
cmFuc2l0aW9uKTsKIAogLyoqCiAgKiBwY2lfc2V0X3Bvd2VyX3N0YXRlIC0gU2V0IHRoZSBwb3dl
ciBzdGF0ZSBvZiBhIFBDSSBkZXZpY2UKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvdmlkZW8vZmJk
ZXYvYXR5L3JhZGVvbl9wbS5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy92
aWRlby9mYmRldi9hdHkvcmFkZW9uX3BtLmMKKysrIGxpbnV4LXBtL2RyaXZlcnMvdmlkZW8vZmJk
ZXYvYXR5L3JhZGVvbl9wbS5jCkBAIC0yNTkzLDcgKzI1OTMsNyBAQCBzdGF0aWMgdm9pZCByYWRl
b25fc2V0X3N1c3BlbmQoc3RydWN0IHJhCiAJCSAqIGNhbGxpbmcgcGNpX3NldF9wb3dlcl9zdGF0
ZSgpCiAJCSAqLwogCQlyYWRlb25mYl93aGFja19wb3dlcl9zdGF0ZShyaW5mbywgUENJX0QyKTsK
LQkJX19wY2lfY29tcGxldGVfcG93ZXJfdHJhbnNpdGlvbihyaW5mby0+cGRldiwgUENJX0QyKTsK
KwkJcGNpX3BsYXRmb3JtX3Bvd2VyX3RyYW5zaXRpb24ocmluZm8tPnBkZXYsIFBDSV9EMik7CiAJ
fSBlbHNlIHsKIAkJcHJpbnRrKEtFUk5fREVCVUcgInJhZGVvbmZiICglcyk6IHN3aXRjaGluZyB0
byBEMCBzdGF0ZS4uLlxuIiwKIAkJICAgICAgIHBjaV9uYW1lKHJpbmZvLT5wZGV2KSk7CkluZGV4
OiBsaW51eC1wbS9pbmNsdWRlL2xpbnV4L3BjaS5oCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9y
aWcvaW5jbHVkZS9saW51eC9wY2kuaAorKysgbGludXgtcG0vaW5jbHVkZS9saW51eC9wY2kuaApA
QCAtMTIzMiw3ICsxMjMyLDcgQEAgc3RydWN0IHBjaV9jYXBfc2F2ZWRfc3RhdGUgKnBjaV9maW5k
X3NhdgogaW50IHBjaV9hZGRfY2FwX3NhdmVfYnVmZmVyKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGNo
YXIgY2FwLCB1bnNpZ25lZCBpbnQgc2l6ZSk7CiBpbnQgcGNpX2FkZF9leHRfY2FwX3NhdmVfYnVm
ZmVyKHN0cnVjdCBwY2lfZGV2ICpkZXYsCiAJCQkJdTE2IGNhcCwgdW5zaWduZWQgaW50IHNpemUp
OwotaW50IF9fcGNpX2NvbXBsZXRlX3Bvd2VyX3RyYW5zaXRpb24oc3RydWN0IHBjaV9kZXYgKmRl
diwgcGNpX3Bvd2VyX3Qgc3RhdGUpOworaW50IHBjaV9wbGF0Zm9ybV9wb3dlcl90cmFuc2l0aW9u
KHN0cnVjdCBwY2lfZGV2ICpkZXYsIHBjaV9wb3dlcl90IHN0YXRlKTsKIGludCBwY2lfc2V0X3Bv
d2VyX3N0YXRlKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHBjaV9wb3dlcl90IHN0YXRlKTsKIHBjaV9w
b3dlcl90IHBjaV9jaG9vc2Vfc3RhdGUoc3RydWN0IHBjaV9kZXYgKmRldiwgcG1fbWVzc2FnZV90
IHN0YXRlKTsKIGJvb2wgcGNpX3BtZV9jYXBhYmxlKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHBjaV9w
b3dlcl90IHN0YXRlKTsKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
