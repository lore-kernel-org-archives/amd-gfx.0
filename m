Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EE2CA9EA0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 08:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 418F120B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 08:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418F120B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5716E4A7;
	Mon, 28 Oct 2019 08:24:08 +0000 (UTC)
Received: from mxct.zte.com.cn (out1.zte.com.cn [202.103.147.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D8FB6EBE7;
 Sat, 26 Oct 2019 02:58:00 +0000 (UTC)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id A8B92A551EFE66DA4380;
 Sat, 26 Oct 2019 10:57:55 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
 by mse-fl2.zte.com.cn with SMTP id x9Q2vfxM094574;
 Sat, 26 Oct 2019 10:57:41 +0800 (GMT-8)
 (envelope-from zhong.shiqi@zte.com.cn)
Received: from mapi (xaxapp01[null]) by mapi (Zmail) with MAPI id mid32;
 Sat, 26 Oct 2019 10:57:40 +0800 (CST)
Date: Sat, 26 Oct 2019 10:57:40 +0800 (CST)
X-Zmail-TransId: 2af95db3b624acb5cd99
X-Mailer: Zmail v1.0
Message-ID: <201910261057408676368@zte.com.cn>
In-Reply-To: <CADnq5_Nv9j5vDX5-Jkhy3TTiej7FcKBBOC8QQk59NQ=SsO-3pg@mail.gmail.com>
References: 1571819543-15676-1-git-send-email-zhong.shiqi@zte.com.cn,
 fa46cad1-8845-78b7-eb6a-45942813020b@amd.com,
 CADnq5_Nv9j5vDX5-Jkhy3TTiej7FcKBBOC8QQk59NQ=SsO-3pg@mail.gmail.com
Mime-Version: 1.0
From: <zhong.shiqi@zte.com.cn>
To: <alexdeucher@gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gZGMuYzp1c2Uga3phbGxvYyB3aXRob3V0IHRlc3Q=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn x9Q2vfxM094574
X-Mailman-Approved-At: Mon, 28 Oct 2019 08:24:06 +0000
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
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, Jun.Lei@amd.com,
 Anthony.Koo@amd.com, David1.Zhou@amd.com, Bhawanpreet.Lakha@amd.com,
 David.Francis@amd.com, Wenjing.Liu@amd.com, amd-gfx@lists.freedesktop.org,
 cheng.shengyu@zte.com.cn, Harry.Wentland@amd.com, wang.yi59@zte.com.cn,
 Sunpeng.Li@amd.com, Aidan.Wood@amd.com, xue.zhihong@zte.com.cn,
 hwentlan@amd.com, Chris.Park@amd.com, Eric.Yang2@amd.com,
 linux-kernel@vger.kernel.org, Nicholas.Kazlauskas@amd.com,
 Dmytro.Laktyushkin@amd.com, daniel@ffwll.ch, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191026025740.gMY7nE2Hv5ODg4MiIV6rkH3R1OHLc5gbfS21WWBl67Q@z>



--=====_001_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PiBBcHBsaWVkLiAgdGhhbmtzIQo+IAo+IEFsZXgKClRoYW5rcyBhIGxvdCEKCnpob25nLnNoaXFp
Cgo+IE9uIFdlZCwgT2N0IDIzLCAyMDE5IGF0IDk6MzUgQU0gSGFycnkgV2VudGxhbmQgPGh3ZW50
bGFuQGFtZC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIDIwMTktMTAtMjMgNDozMiBhLm0uLCB6aG9u
Z3NoaXFpIHdyb3RlOgo+ID4gPiBkYy5jOjU4MzpudWxsIGNoZWNrIGlzIG5lZWRlZCBhZnRlciB1
c2luZyBremFsbG9jIGZ1bmN0aW9uCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IHpob25nc2hp
cWkgPHpob25nLnNoaXFpQHp0ZS5jb20uY24+Cj4gPgo+ID4gUmV2aWV3ZWQtYnk6IEhhcnJ5IFdl
bnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+ID4KPiA+IEhhcnJ5Cj4gPgo+ID4gPiAt
LS0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgfCA0ICsr
KysKPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPiA+ID4KPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCj4gPiA+IGluZGV4IDVkMWFkZWQu
LjRiODgxOWMgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jb3JlL2RjLmMKPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nv
cmUvZGMuYwo+ID4gPiBAQCAtNTgwLDYgKzU4MCwxMCBAQCBzdGF0aWMgYm9vbCBjb25zdHJ1Y3Qo
c3RydWN0IGRjICpkYywKPiA+ID4gICNpZmRlZiBDT05GSUdfRFJNX0FNRF9EQ19EQ04yXzAKPiA+
ID4gICAgICAgLy8gQWxsb2NhdGUgbWVtb3J5IGZvciB0aGUgdm1faGVscGVyCj4gPiA+ICAgICAg
IGRjLT52bV9oZWxwZXIgPSBremFsbG9jKHNpemVvZihzdHJ1Y3Qgdm1faGVscGVyKSwgR0ZQX0tF
Uk5FTCk7Cj4gPiA+ICsgICAgIGlmICghZGMtPnZtX2hlbHBlcikgewo+ID4gPiArICAgICAgICAg
ICAgIGRtX2Vycm9yKCIlczogZmFpbGVkIHRvIGNyZWF0ZSBkYy0+dm1faGVscGVyXG4iLCBfX2Z1
bmNfXyk7Cj4gPiA+ICsgICAgICAgICAgICAgZ290byBmYWlsOwo+ID4gPiArICAgICB9Cj4gPiA+
Cj4gPiA+ICAjZW5kaWYKPiA+ID4gICAgICAgbWVtY3B5KCZkYy0+YmJfb3ZlcnJpZGVzLCAmaW5p
dF9wYXJhbXMtPmJiX292ZXJyaWRlcywgc2l6ZW9mKGRjLT5iYl9vdmVycmlkZXMpKTsKPiA+ID4K
PiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+ID4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+
IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==

--=====_003_next=====--

--=====_001_next=====
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--=====_001_next=====--

