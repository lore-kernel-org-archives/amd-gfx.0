Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C49C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 11:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2FD64F4F
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 11:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2FD64F4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4180B6EB5A;
	Fri,  5 Mar 2021 11:42:30 +0000 (UTC)
X-Greylist: delayed 349 seconds by postgrey-1.36 at gabe;
 Fri, 05 Mar 2021 10:12:50 UTC
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D0EA6EB3E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 10:12:50 +0000 (UTC)
Received: from tux.applied-asynchrony.com (p5b07e8e5.dip0.t-ipconnect.de
 [91.7.232.229])
 by mail.itouring.de (Postfix) with ESMTPSA id 9DA4B11DD5E;
 Fri,  5 Mar 2021 11:06:59 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
 by tux.applied-asynchrony.com (Postfix) with ESMTP id 6279BF01617;
 Fri,  5 Mar 2021 11:06:59 +0100 (CET)
To: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Jan_Kokem=c3=bcller?=
 <jan.kokemueller@gmail.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: [PATCH] drm/amd/display: Fix nested FPU context in,
 dcn21_validate_bandwidth()
Organization: Applied Asynchrony, Inc.
Message-ID: <f0a8af79-7601-fda6-1597-3f69fda8d655@applied-asynchrony.com>
Date: Fri, 5 Mar 2021 11:06:59 +0100
MIME-Version: 1.0
Content-Language: en-US
X-Mailman-Approved-At: Fri, 05 Mar 2021 11:42:29 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkNvbW1pdCA0MTQwMWFjNjc3OTEgYWRkZWQgRlBVIHdyYXBwZXJzIHRvIGRjbjIxX3ZhbGlkYXRl
X2JhbmR3aWR0aCgpLAp3aGljaCB3YXMgY29ycmVjdC4gVW5mb3J0dW5hdGVseSBhIG5lc3RlZCBm
dW5jdGlvbiBhbHJlZHkgY29udGFpbmVkCkRDX0ZQX1NUQVJUKCkvRENfRlBfRU5EKCkgY2FsbHMs
IHdoaWNoIHJlc3VsdHMgaW4gbmVzdGVkIEZQVSBjb250ZXh0CmVudGVyL2V4aXQgYW5kIGNvbXBs
YWludHMgYnkga2VybmVsX2ZwdV9iZWdpbl9tYXNrKCkuClRoaXMgY2FuIGJlIG9ic2VydmVkIGUu
Zy4gd2l0aCA1LjEwLjIwLCB3aGljaCBiYWNrcG9ydGVkIDQxNDAxYWM2Nzc5MQphbmQgbm93IGVt
aXRzIHRoZSBmb2xsb3dpbmcgd2FybmluZyBvbiBib290OgoKV0FSTklORzogQ1BVOiA2IFBJRDog
ODU4IGF0IGFyY2gveDg2L2tlcm5lbC9mcHUvY29yZS5jOjEyOSBrZXJuZWxfZnB1X2JlZ2luX21h
c2srMHhhNS8weGMwCkNhbGwgVHJhY2U6CiAgZGNuMjFfY2FsY3VsYXRlX3dtKzB4NDcvMHhhOTAg
W2FtZGdwdV0KICBkY24yMV92YWxpZGF0ZV9iYW5kd2lkdGhfZnArMHgxNWQvMHgyYjAgW2FtZGdw
dV0KICBkY24yMV92YWxpZGF0ZV9iYW5kd2lkdGgrMHgyOS8weDQwIFthbWRncHVdCiAgZGNfdmFs
aWRhdGVfZ2xvYmFsX3N0YXRlKzB4M2M3LzB4NGMwIFthbWRncHVdCgpUaGUgd2FybmluZyBpcyBl
bWl0dGVkIGR1ZSB0byB0aGUgYWRkaXRpb25hbCBEQ19GUF9TVEFSVC9FTkQgY2FsbHMgaW4KcGF0
Y2hfYm91bmRpbmdfYm94KCksIHdoaWNoIGlzIGlubGluZWQgaW50byBkY24yMV9jYWxjdWxhdGVf
d20oKSwKaXRzIG9ubHkgY2FsbGVyLiBSZW1vdmluZyB0aGUgY2FsbHMgYnJpbmdzIHRoZSBjb2Rl
IGluIGxpbmUgd2l0aApkY24yMCBhbmQgbWFrZXMgdGhlIHdhcm5pbmcgZGlzYXBwZWFyLgoKU2ln
bmVkLW9mZi1ieTogSG9sZ2VyIEhvZmZzdMOkdHRlIDxob2xnZXJAYXBwbGllZC1hc3luY2hyb255
LmNvbT4KLS0tCiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jl
c291cmNlLmMgfCA0IC0tLS0KICAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3Vy
Y2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9yZXNvdXJj
ZS5jCmluZGV4IDA3MmY4Yzg4MDkyNC4uNjhiZTczZmUyZTIzIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYwpAQCAtMTA2
Miw4ICsxMDYyLDYgQEAgc3RhdGljIHZvaWQgcGF0Y2hfYm91bmRpbmdfYm94KHN0cnVjdCBkYyAq
ZGMsIHN0cnVjdCBfdmNzX2RwaV9zb2NfYm91bmRpbmdfYm94X3MKICB7CiAgCWludCBpOwogIAot
CURDX0ZQX1NUQVJUKCk7Ci0KICAJaWYgKGRjLT5iYl9vdmVycmlkZXMuc3JfZXhpdF90aW1lX25z
KSB7CiAgCQlmb3IgKGkgPSAwOyBpIDwgV01fU0VUX0NPVU5UOyBpKyspIHsKICAJCQkgIGRjLT5j
bGtfbWdyLT5id19wYXJhbXMtPndtX3RhYmxlLmVudHJpZXNbaV0uc3JfZXhpdF90aW1lX3VzID0K
QEAgLTEwODgsOCArMTA4Niw2IEBAIHN0YXRpYyB2b2lkIHBhdGNoX2JvdW5kaW5nX2JveChzdHJ1
Y3QgZGMgKmRjLCBzdHJ1Y3QgX3Zjc19kcGlfc29jX2JvdW5kaW5nX2JveF9zCiAgCQkJCWRjLT5i
Yl9vdmVycmlkZXMuZHJhbV9jbG9ja19jaGFuZ2VfbGF0ZW5jeV9ucyAvIDEwMDAuMDsKICAJCX0K
ICAJfQotCi0JRENfRlBfRU5EKCk7CiAgfQogIAogIHZvaWQgZGNuMjFfY2FsY3VsYXRlX3dtKAot
LSAKMi4zMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
