Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6677C2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 14:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D652083B
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 14:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D652083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE28089F19;
	Mon, 28 Sep 2020 14:52:58 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7CC89DA5;
 Mon, 28 Sep 2020 14:07:01 +0000 (UTC)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 644D99080E9949794B51;
 Mon, 28 Sep 2020 22:06:54 +0800 (CST)
Received: from [10.174.179.92] (10.174.179.92) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 22:06:43 +0800
Subject: Re: [PATCH] drm/amd/display: add debugfs entry for trigger_hotplug
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>, <airlied@linux.ie>,
 <daniel@ffwll.ch>, <mikita.lipski@amd.com>, <eryk.brol@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
References: <20200912022214.3767954-1-yanaijie@huawei.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <8097f391-c62e-5b4d-a1d4-d2661714066e@huawei.com>
Date: Mon, 28 Sep 2020 22:06:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200912022214.3767954-1-yanaijie@huawei.com>
X-Originating-IP: [10.174.179.92]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 28 Sep 2020 14:52:57 +0000
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
Cc: Hulk Robot <hulkci@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

cGluZy4uLgoK5ZyoIDIwMjAvOS8xMiAxMDoyMiwgSmFzb24gWWFuIOWGmemBkzoKPiBUaGUgJ3Ry
aWdnZXJfaG90cGx1ZycgZW50cnkgaW4gZGVidWdmcyBpcyBkZWZpbmVkIGJ1dCBub3Qgd2lyZWQg
dXAuIFRoaXMKPiBjYXVzZXMgYSBnY2Mgd2FybmluZyBidWlsZCB3aXRoIFc9MS4KPiAKPiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fZGVi
dWdmcy5jOjIwNDU6Mzc6Cj4gd2FybmluZzog4oCYZHBfdHJpZ2dlcl9ob3RwbHVnX2RlYnVnZnNf
Zm9wc+KAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZAo+IFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1d
Cj4gICAyMDQ1IHwgc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMKPiAgICAgICAg
ZHBfdHJpZ2dlcl9ob3RwbHVnX2RlYnVnZnNfZm9wcyA9IHsKPiAgICAgICAgfAo+IF5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPiAKPiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVs
a2NpQGh1YXdlaS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogSmFzb24gWWFuIDx5YW5haWppZUBodWF3
ZWkuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG1fZGVidWdmcy5jIHwgMSArCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG1fZGVidWdmcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG1fZGVidWdmcy5jCj4gaW5kZXggOTRmY2IwODYxNTRjLi45NzJjNzgwYjYy
OTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG1fZGVidWdmcy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG1fZGVidWdmcy5jCj4gQEAgLTIxMTUsNiArMjExNSw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgewo+ICAgCQl7ImRzY19waWNfaGVpZ2h0IiwgJmRwX2RzY19waWNfaGVp
Z2h0X2RlYnVnZnNfZm9wc30sCj4gICAJCXsiZHNjX2NodW5rX3NpemUiLCAmZHBfZHNjX2NodW5r
X3NpemVfZGVidWdmc19mb3BzfSwKPiAgIAkJeyJkc2Nfc2xpY2VfYnBnIiwgJmRwX2RzY19zbGlj
ZV9icGdfb2Zmc2V0X2RlYnVnZnNfZm9wc30sCj4gKwkJeyJ0cmlnZ2VyX2hvdHBsdWciLCAmZHBf
dHJpZ2dlcl9ob3RwbHVnX2RlYnVnZnNfZm9wc30sCj4gICAJCXsiZHBfZHNjX2ZlY19zdXBwb3J0
IiwgJmRwX2RzY19mZWNfc3VwcG9ydF9mb3BzfQo+ICAgfTsKPiAgIAo+IApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
