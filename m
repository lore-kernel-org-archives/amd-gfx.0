Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327E0C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 18:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC8C206F0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 18:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC8C206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B93416EDF8;
	Wed, 13 Nov 2019 18:40:56 +0000 (UTC)
Received: from smtprelay.hostedemail.com (smtprelay0250.hostedemail.com
 [216.40.44.250])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DBC8920F;
 Wed, 13 Nov 2019 16:56:10 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id 30073100E7B40;
 Wed, 13 Nov 2019 16:56:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cloth41_18055f6faa706
X-Filterd-Recvd-Size: 2543
Received: from XPS-9350.home (unknown [47.151.135.224])
 (Authenticated sender: joe@perches.com)
 by omf10.hostedemail.com (Postfix) with ESMTPA;
 Wed, 13 Nov 2019 16:56:04 +0000 (UTC)
Message-ID: <ac4566662a04e0c25039df7ed30789d0792885cd.camel@perches.com>
Subject: Re: [PATCH 1/7] drm/amdgpu: remove set but not used variable
 'mc_shared_chmap' from 'gfx_v6_0.c' and 'gfx_v7_0.c'
From: Joe Perches <joe@perches.com>
To: yu kuai <yukuai3@huawei.com>, alexander.deucher@amd.com, 
 Felix.Kuehling@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, 
 airlied@linux.ie, daniel@ffwll.ch, Rex.Zhu@amd.com, evan.quan@amd.com
Date: Wed, 13 Nov 2019 08:55:47 -0800
In-Reply-To: <1573649074-72589-2-git-send-email-yukuai3@huawei.com>
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
 <1573649074-72589-2-git-send-email-yukuai3@huawei.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 13 Nov 2019 18:40:54 +0000
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
Cc: zhengbin13@huawei.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 yi.zhang@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113165547.XpC5KZMW1s2TFxByqNG0DL7WaOZx0HWDiT5Ws5ACl8k@z>

T24gV2VkLCAyMDE5LTExLTEzIGF0IDIwOjQ0ICswODAwLCB5dSBrdWFpIHdyb3RlOgo+IEZpeGVz
IGdjYyAnLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZScgd2FybmluZzoKPiAKPiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjZfMC5jOiBJbiBmdW5jdGlvbgo+IOKAmGdmeF92Nl8wX2Nv
bnN0YW50c19pbml04oCZOgo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92Nl8wLmM6
MTU3OTo2OiB3YXJuaW5nOiB2YXJpYWJsZQo+IOKAmG1jX3NoYXJlZF9jaG1hcOKAmSBzZXQgYnV0
IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQpbXQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjZfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y2XzAuYwpbXQo+IEBAIC0xNjc4LDcgKzE2NzgsNiBAQCBzdGF0aWMgdm9p
ZCBnZnhfdjZfMF9jb25zdGFudHNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAg
Cj4gIAlXUkVHMzIobW1CSUZfRkJfRU4sIEJJRl9GQl9FTl9fRkJfUkVBRF9FTl9NQVNLIHwgQklG
X0ZCX0VOX19GQl9XUklURV9FTl9NQVNLKTsKPiAgCj4gLQltY19zaGFyZWRfY2htYXAgPSBSUkVH
MzIobW1NQ19TSEFSRURfQ0hNQVApOwoKSSBkbyBub3Qga25vdyB0aGUgaGFyZHdhcmUgYnV0IGZy
ZXF1ZW50bHkgaGFyZHdhcmUgbGlrZQp0aGlzIGhhcyByZWFkIG9yZGVyaW5nIHJlcXVpcmVtZW50
cyBhbmQgdmFyaW91cyByZWdpc3RlcnMKY2FuIG5vdCBiZSByZWFkIGluIGEgcmFuZG9tIG9yZGVy
LgoKRG9lcyByZW1vdmluZyB0aGlzIHJlYWQgaGF2ZSBubyBlZmZlY3Qgb24gdGhlIGhhcmR3YXJl
PwoKPiAgCWFkZXYtPmdmeC5jb25maWcubWNfYXJiX3JhbWNmZyA9IFJSRUczMihtbU1DX0FSQl9S
QU1DRkcpOwo+ICAJbWNfYXJiX3JhbWNmZyA9IGFkZXYtPmdmeC5jb25maWcubWNfYXJiX3JhbWNm
ZzsKPiAgCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18w
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jCltdCj4gQEAgLTQzMzYs
NyArNDMzNiw2IEBAIHN0YXRpYyB2b2lkIGdmeF92N18wX2dwdV9lYXJseV9pbml0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQo+ICAJCWJyZWFrOwo+ICAJfQo+ICAKPiAtCW1jX3NoYXJlZF9j
aG1hcCA9IFJSRUczMihtbU1DX1NIQVJFRF9DSE1BUCk7Cj4gIAlhZGV2LT5nZnguY29uZmlnLm1j
X2FyYl9yYW1jZmcgPSBSUkVHMzIobW1NQ19BUkJfUkFNQ0ZHKTsKPiAgCW1jX2FyYl9yYW1jZmcg
PSBhZGV2LT5nZnguY29uZmlnLm1jX2FyYl9yYW1jZmc7CgpTYW1lIHF1ZXN0aW9uLgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
