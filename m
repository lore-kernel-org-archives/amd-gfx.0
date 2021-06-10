Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60F3C47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 13:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5FB613E7
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 13:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5FB613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C15F6ED18;
	Thu, 10 Jun 2021 13:30:33 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFAD96EC83;
 Thu, 10 Jun 2021 08:41:07 +0000 (UTC)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0y4C24mtzWtkL;
 Thu, 10 Jun 2021 16:36:11 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 10 Jun 2021 16:41:04 +0800
Subject: Re: [PATCH -next] drm/amdgpu: Use DIV_ROUND_UP_ULL instead of
 DIV_ROUND_UP
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <Xinhui.Pan@amd.com>, <airlied@linux.ie>,
 <daniel@ffwll.ch>, <airlied@redhat.com>, <bskeggs@redhat.com>,
 <matthew.auld@intel.com>, <Ramesh.Errabolu@amd.com>,
 <mchehab+huawei@kernel.org>, <Dennis.Li@amd.com>,
 <funfunctor@folklore1984.net>
References: <20210610082005.86876-1-heying24@huawei.com>
 <5ffe00de-a7b6-3ac4-f61a-5f28b653e7b1@amd.com>
From: He Ying <heying24@huawei.com>
Message-ID: <ef947327-6114-6c22-6107-bdb9c72f3dfe@huawei.com>
Date: Thu, 10 Jun 2021 16:41:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5ffe00de-a7b6-3ac4-f61a-5f28b653e7b1@amd.com>
X-Originating-IP: [10.67.110.136]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 10 Jun 2021 13:30:32 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGVsbG8sCgoK5ZyoIDIwMjEvNi8xMCAxNjoyMCwgQ2hyaXN0aWFuIEvDtm5pZyDlhpnpgZM6Cj4K
Pgo+IEFtIDEwLjA2LjIxIHVtIDEwOjIwIHNjaHJpZWIgSGUgWWluZzoKPj4gV2hlbiBjb21waWxp
bmcgdGhlIGtlcm5lbCBmb3IgTUlQUyB3aXRoIENPTkZJR19EUk1fQU1ER1BVID0geSwgZXJyb3Jz
IAo+PiBhcmUKPj4gZW5jb3VudGVyZWQgYXMgZm9sbG93czoKPj4KPj4gZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLm86IEluIGZ1bmN0aW9uIAo+PiBgYW1kZ3B1X3Zy
YW1fbWdyX25ldyc6Cj4+IGFtZGdwdV92cmFtX21nci5jOigudGV4dCsweDc0MCk6IHVuZGVmaW5l
ZCByZWZlcmVuY2UgdG8gYF9fdWRpdmRpMycKPj4KPj4gTWFraW5nIGEgNjQgYml0IGRpdmlzaW9u
IGJ5IGEvYiAoYSBpcyB1aW50NjRfdCkgaXMgbm90IHN1cHBvcnRlZCBieSAKPj4gZGVmYXVsdAo+
PiBpbiBsaW51eCBrZXJuZWwgc3BhY2UuIEluc3RlYWQsIHVzaW5nIGRvX2RpdiBpcyBPSyBmb3Ig
dGhpcyAKPj4gc2l0dWF0aW9uLiBGb3IKPj4gdGhpcyBwcm9ibGVtLCB1c2luZyBESVZfUk9VTkRf
VVBfVUxMIGluc3RlYWQgb2YgRElWX1JPVU5EX1VQIGlzIGJldHRlci4KPgo+IEFscmVhZHkgZml4
ZWQgYnkgdGhpcyBwYXRjaCBpbiBkcm0tbmV4dDoKPgo+IGNvbW1pdCA2OTFjZjhjZDdhNTMxZGJm
Y2MyOWQwOWEyM2M1MDlhODZmZDliMjRmCj4gQXV0aG9yOiBEYXZlIEFpcmxpZSA8YWlybGllZEBy
ZWRoYXQuY29tPgo+IERhdGU6wqDCoCBUaHUgSnVuIDEwIDEyOjU5OjAwIDIwMjEgKzEwMDAKPgo+
IMKgwqDCoCBkcm0vYW1kZ3B1OiB1c2UgY29ycmVjdCByb3VuZGluZyBtYWNybyBmb3IgNjQtYml0
Cj4KPiDCoMKgwqAgVGhpcyBmaXhlcyAzMi1iaXQgYXJtIGJ1aWxkIGR1ZSB0byBsYWNrIG9mIDY0
LWJpdCBkaXZpZGVzLgoKT0suIFNpZ2guCgpCZWZvcmUgc2VuZGluZyBteSBwYXRjaCwgSSBzZWFy
Y2hlZCBwYXRjaGVzIGluIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvCgpidXQgSSBkaWRu
J3QgZmluZCB0aGlzIHBhdGNoLiBIb3cgY2FuIEkgZmluZCB3aGV0aGVyIG15IHBhdGNoIGlzIGR1
cGxpY2F0ZWQKCmJlZm9yZSBzZW5kaW5nIGl0PyBBbnkgc3VnZ2VzdGlvbnM/CgoKVGhhbmtzLgoK
Pgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IEZpeGVzOiA2YTdmNzZlNzBmYWMgKCJk
cm0vYW1kZ3B1OiBhZGQgVlJBTSBtYW5hZ2VyIHYyIikKPj4gUmVwb3J0ZWQtYnk6IEh1bGsgUm9i
b3QgPGh1bGtjaUBodWF3ZWkuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBIZSBZaW5nIDxoZXlpbmcy
NEBodWF3ZWkuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZyYW1fbWdyLmMgfCAyICstCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZyYW1fbWdyLmMKPj4gaW5kZXggOWE2ZGYwMjQ3N2NlLi40MzZlYzI0NmE3ZGEgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5j
Cj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jCj4+
IEBAIC00MDcsNyArNDA3LDcgQEAgc3RhdGljIGludCBhbWRncHVfdnJhbV9tZ3JfbmV3KHN0cnVj
dCAKPj4gdHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbiwKPj4gwqAgI2VuZGlmCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBwYWdlc19wZXJfbm9kZSA9IG1heF90KHVpbnQzMl90LCBwYWdlc19wZXJfbm9k
ZSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRi
by0+cGFnZV9hbGlnbm1lbnQpOwo+PiAtwqDCoMKgwqDCoMKgwqAgbnVtX25vZGVzID0gRElWX1JP
VU5EX1VQKFBGTl9VUChtZW1fYnl0ZXMpLCBwYWdlc19wZXJfbm9kZSk7Cj4+ICvCoMKgwqDCoMKg
wqDCoCBudW1fbm9kZXMgPSBESVZfUk9VTkRfVVBfVUxMKFBGTl9VUChtZW1fYnl0ZXMpLCAKPj4g
cGFnZXNfcGVyX25vZGUpOwo+PiDCoMKgwqDCoMKgIH0KPj4gwqAgwqDCoMKgwqDCoCBub2RlID0g
a3ZtYWxsb2Moc3RydWN0X3NpemUobm9kZSwgbW1fbm9kZXMsIG51bV9ub2RlcyksCj4KPiAuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
