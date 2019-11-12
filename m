Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E195C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 08:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7942196E
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 08:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7942196E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9FB6EA7A;
	Tue, 12 Nov 2019 08:44:52 +0000 (UTC)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FEEE6E314;
 Tue, 12 Nov 2019 07:51:48 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 1DA92BC29FDA6D619B61;
 Tue, 12 Nov 2019 15:51:43 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0;
 Tue, 12 Nov 2019 15:51:38 +0800
Subject: Re: [PATCH -next] drm/amd/display: Fix old-style declaration
To: Joe Perches <joe@perches.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <David1.Zhou@amd.com>, <airlied@linux.ie>,
 <daniel@ffwll.ch>, <Bhawanpreet.Lakha@amd.com>, <Jun.Lei@amd.com>,
 <David.Francis@amd.com>, <Dmytro.Laktyushkin@amd.com>,
 <nicholas.kazlauskas@amd.com>, <martin.leung@amd.com>, <Chris.Park@amd.com>
References: <20191111122801.18584-1-yuehaibing@huawei.com>
 <01c630e6d4c58b3f6184603e158f53fb9aaeae7d.camel@perches.com>
From: Yuehaibing <yuehaibing@huawei.com>
Message-ID: <3361b760-fe4f-87e8-b0a4-ebda390aa492@huawei.com>
Date: Tue, 12 Nov 2019 15:51:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <01c630e6d4c58b3f6184603e158f53fb9aaeae7d.camel@perches.com>
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
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
Message-ID: <20191112075133.xLLIVF2aq-0qJdRGSKMKp8ZcdXO85C0OYLmU8ZZMFio@z>

T24gMjAxOS8xMS8xMiAxMDozOSwgSm9lIFBlcmNoZXMgd3JvdGU6Cj4gT24gTW9uLCAyMDE5LTEx
LTExIGF0IDIwOjI4ICswODAwLCBZdWVIYWliaW5nIHdyb3RlOgo+PiBGaXggYSBidWlsZCB3YXJu
aW5nOgo+Pgo+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NvcmUv
ZGMuYzo3NToxOgo+PiAgd2FybmluZzogJ3N0YXRpYycgaXMgbm90IGF0IGJlZ2lubmluZyBvZiBk
ZWNsYXJhdGlvbiBbLVdvbGQtc3R5bGUtZGVjbGFyYXRpb25dCj4gW10KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCj4gW10KPj4gQEAgLTY5LDcgKzY5LDcgQEAKPj4g
ICNkZWZpbmUgRENfTE9HR0VSIFwKPj4gIAlkYy0+Y3R4LT5sb2dnZXIKPj4gIAo+PiAtY29uc3Qg
c3RhdGljIGNoYXIgRENfQlVJTERfSURbXSA9ICJwcm9kdWN0aW9uLWJ1aWxkIjsKPj4gK3N0YXRp
YyBjb25zdCBjaGFyIERDX0JVSUxEX0lEW10gPSAicHJvZHVjdGlvbi1idWlsZCI7Cj4gCj4gRENf
QlVJTERfSUQgaXMgdXNlZCBleGFjdGx5IG9uY2UuCj4gTWF5YmUganVzdCB1c2UgaXQgZGlyZWN0
bHkgYW5kIHJlbW92ZSBEQ19CVUlMRF9JRCBpbnN0ZWFkPwoKY29tbWl0IGJlNjFkZjU3NDI1NmFl
OGMwZGJkNDVhYzE0OGNhNzI2MGEwNDgzYzAKQXV0aG9yOiBKdW4gTGVpIDxKdW4uTGVpQGFtZC5j
b20+CkRhdGU6ICAgVGh1IFNlcCAxMyAwOTozMjoyNiAyMDE4IC0wNDAwCgogICAgZHJtL2FtZC9k
aXNwbGF5OiBBZGQgREMgYnVpbGRfaWQgdG8gZGV0ZXJtaW5lIGJ1aWxkIHR5cGUKCiAgICBbd2h5
XQogICAgU29tZXRpbWVzIHRoZXJlIGFyZSBpbmRpY2F0aW9ucyB0aGF0IHRoZSBpbmNvcnJlY3Qg
ZHJpdmVyIGlzIGJlaW5nCiAgICBsb2FkZWQgaW4gYXV0b21hdGVkIHRlc3RzLiBUaGlzIGNoYW5n
ZSBhZGRzIHRoZSBhYmlsaXR5IGZvciBidWlsZHMgdG8KICAgIGJlIHRhZ2dlZCB3aXRoIGEgc3Ry
aW5nLCBhbmQgcGlja2VkIHVwIGJ5IHRoZSB0ZXN0IGluZnJhc3RydWN0dXJlLgoKICAgIFtob3dd
CiAgICBkYy5jIHdpbGwgYWxsb2NhdGUgY29uc3QgZm9yIGJ1aWxkIGlkLCB3aGljaCBpcyBpbml0
LWVkIHdpdGggZGVmYXVsdAogICAgdmFsdWUsIGluZGljYXRpbmcgcHJvZHVjdGlvbiBidWlsZC4g
Rm9yIHRlc3QgYnVpbGRzLCBidWlsZCBzZXJ2ZXIgd2lsbAogICAgZmluZC9yZXBsYWNlIHRoaXMg
dmFsdWUuIFRoZSB0ZXN0IG1hY2hpbmUgd2lsbCB0aGVuIHZlcmlmeSB0aGlzIHZhbHVlLgoKSXQg
c2VlbXMgRENfQlVJTERfSUQgaXMgdXNlZCBieSB0aGUgYnVpbGQgc2VydmVyLCBzbyBtYXliZSB3
ZSBzaG91bGQga2VlcCBpdC4KCj4gCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjLmMgfCA0ICstLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAzIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvY29yZS9kYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGMuYwo+IGluZGV4IDFmZGJhMTMuLjgwM2RjMTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9jb3JlL2RjLmMKPiBAQCAtNjksOCArNjksNiBAQAo+ICAjZGVmaW5lIERDX0xP
R0dFUiBcCj4gIAlkYy0+Y3R4LT5sb2dnZXIKPiAgCj4gLWNvbnN0IHN0YXRpYyBjaGFyIERDX0JV
SUxEX0lEW10gPSAicHJvZHVjdGlvbi1idWlsZCI7Cj4gLQo+ICAvKioKPiAgICogRE9DOiBPdmVy
dmlldwo+ICAgKgo+IEBAIC04MTUsNyArODEzLDcgQEAgc3RydWN0IGRjICpkY19jcmVhdGUoY29u
c3Qgc3RydWN0IGRjX2luaXRfZGF0YSAqaW5pdF9wYXJhbXMpCj4gIAlpZiAoZGMtPnJlc19wb29s
LT5kbWN1ICE9IE5VTEwpCj4gIAkJZGMtPnZlcnNpb25zLmRtY3VfdmVyc2lvbiA9IGRjLT5yZXNf
cG9vbC0+ZG1jdS0+ZG1jdV92ZXJzaW9uOwo+ICAKPiAtCWRjLT5idWlsZF9pZCA9IERDX0JVSUxE
X0lEOwo+ICsJZGMtPmJ1aWxkX2lkID0gInByb2R1Y3Rpb24tYnVpbGQiOwo+ICAKPiAgCURDX0xP
R19EQygiRGlzcGxheSBDb3JlIGluaXRpYWxpemVkXG4iKTsKPiAgCj4gCj4gCj4gCj4gLgo+IAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
