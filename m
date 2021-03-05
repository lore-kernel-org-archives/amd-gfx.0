Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE12AC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 11:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9EE564DD1
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 11:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EE564DD1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5712F6E02F;
	Fri,  5 Mar 2021 11:39:24 +0000 (UTC)
X-Greylist: delayed 5540 seconds by postgrey-1.36 at gabe;
 Fri, 05 Mar 2021 11:39:23 UTC
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CAD16E02F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 11:39:23 +0000 (UTC)
Received: from tux.applied-asynchrony.com (p5b07e8e5.dip0.t-ipconnect.de
 [91.7.232.229])
 by mail.itouring.de (Postfix) with ESMTPSA id D874F11DD5E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 12:39:21 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
 by tux.applied-asynchrony.com (Postfix) with ESMTP id A7CE1F01617
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 12:39:21 +0100 (CET)
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: [PATCH RESEND] drm/amd/display: Fix nested FPU context in
 dcn21_validate_bandwidth()
To: amd-gfx@lists.freedesktop.org
Organization: Applied Asynchrony, Inc.
Message-ID: <baf76b2f-1985-6b66-c672-559742d815bf@applied-asynchrony.com>
Date: Fri, 5 Mar 2021 12:39:21 +0100
MIME-Version: 1.0
Content-Language: en-US
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
IGluIGxpbmUgd2l0aApkY24yMCBhbmQgbWFrZXMgdGhlIHdhcm5pbmcgZGlzYXBwZWFyLgoKRml4
ZXM6IDQxNDAxYWM2Nzc5MSAoImRybS9hbWQvZGlzcGxheTogQWRkIEZQVSB3cmFwcGVycyB0byBk
Y24yMV92YWxpZGF0ZV9iYW5kd2lkdGgoKSIpClNpZ25lZC1vZmYtYnk6IEhvbGdlciBIb2Zmc3TD
pHR0ZSA8aG9sZ2VyQGFwcGxpZWQtYXN5bmNocm9ueS5jb20+Ci0tLQogIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9yZXNvdXJjZS5jIHwgNCAtLS0tCiAgMSBmaWxl
IGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYwppbmRleCAwNzJmOGM4ODA5MjQuLjY4
YmU3M2ZlMmUyMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
bjIxL2RjbjIxX3Jlc291cmNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjbjIxL2RjbjIxX3Jlc291cmNlLmMKQEAgLTEwNjIsOCArMTA2Miw2IEBAIHN0YXRpYyB2b2lk
IHBhdGNoX2JvdW5kaW5nX2JveChzdHJ1Y3QgZGMgKmRjLCBzdHJ1Y3QgX3Zjc19kcGlfc29jX2Jv
dW5kaW5nX2JveF9zCiAgewogIAlpbnQgaTsKICAKLQlEQ19GUF9TVEFSVCgpOwotCiAgCWlmIChk
Yy0+YmJfb3ZlcnJpZGVzLnNyX2V4aXRfdGltZV9ucykgewogIAkJZm9yIChpID0gMDsgaSA8IFdN
X1NFVF9DT1VOVDsgaSsrKSB7CiAgCQkJICBkYy0+Y2xrX21nci0+YndfcGFyYW1zLT53bV90YWJs
ZS5lbnRyaWVzW2ldLnNyX2V4aXRfdGltZV91cyA9CkBAIC0xMDg4LDggKzEwODYsNiBAQCBzdGF0
aWMgdm9pZCBwYXRjaF9ib3VuZGluZ19ib3goc3RydWN0IGRjICpkYywgc3RydWN0IF92Y3NfZHBp
X3NvY19ib3VuZGluZ19ib3hfcwogIAkJCQlkYy0+YmJfb3ZlcnJpZGVzLmRyYW1fY2xvY2tfY2hh
bmdlX2xhdGVuY3lfbnMgLyAxMDAwLjA7CiAgCQl9CiAgCX0KLQotCURDX0ZQX0VORCgpOwogIH0K
ICAKICB2b2lkIGRjbjIxX2NhbGN1bGF0ZV93bSgKLS0gCjIuMzAuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
