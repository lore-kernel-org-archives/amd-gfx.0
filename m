Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.9 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7E6C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 07:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB37320776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 07:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="QZm0nPXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB37320776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 774A0888AE;
	Fri, 28 Aug 2020 07:37:50 +0000 (UTC)
Received: from m13120.mail.163.com (m13120.mail.163.com [220.181.13.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A80AE6E05F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 01:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=jvKvq
 EuVEemomvJuUYkFtMmfoO9QgXqsGpVFt255psY=; b=QZm0nPXLYNG/XufgdFw0e
 4Hq87pdb3ok6igZzJxZFJQWH9yvCaLlHRycOhZmox2J8oiZlXT2DXCZIKwPpnnOA
 V5PQinxgKmEFxtP8wFd2wjbMEb/H6XO/BB7JOcEpAa3qTgQ6eb5oVn1OhkTy5nOn
 RIVP4wLUx+e4FYsiP+qM8w=
Received: from erdong2018$163.com ( [118.242.3.34] ) by
 ajax-webmail-wmsvr120 (Coremail) ; Fri, 28 Aug 2020 09:43:18 +0800 (CST)
X-Originating-IP: [118.242.3.34]
Date: Fri, 28 Aug 2020 09:43:18 +0800 (CST)
From: =?GBK?B?1cW2/rar?= <erdong2018@163.com>
To: "Tom St Denis" <tstdenis82@gmail.com>
Subject: Re:Re: 0001-Fix-a-array-bound-overflow-bug-in-function-umr_clock
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
In-Reply-To: <CAAzXoRJ+S6qaE_UaN0gNtkHPQcp+toMcUA1-8fLhU37rDdHyRQ@mail.gmail.com>
References: <5eb9e79.42da.1742ef91f76.Coremail.erdong2018@163.com>
 <CAAzXoRJ+S6qaE_UaN0gNtkHPQcp+toMcUA1-8fLhU37rDdHyRQ@mail.gmail.com>
X-CM-CTRLDATA: bnscO2Zvb3Rlcl9odG09MTYyOTo1Ng==
Content-Type: multipart/mixed; 
 boundary="----=_Part_15902_98584569.1598578998330"
MIME-Version: 1.0
Message-ID: <3ffa3550.11d0.17432bbbc3a.Coremail.erdong2018@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: eMGowAAXX8o2YUhfW1FgAA--.55760W
X-CM-SenderInfo: phug00jjsqimi6rwjhhfrp/1tbiRAeNc1SIgn9c3wACsd
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Fri, 28 Aug 2020 07:37:49 +0000
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

------=_Part_15902_98584569.1598578998330
Content-Type: multipart/alternative; 
	boundary="----=_Part_15904_1053011878.1598578998330"

------=_Part_15904_1053011878.1598578998330
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

WWVzLCB5b3UgYXJlIHJpZ2h0LiBOZXcgcGF0Y2ggaXMgaW4gYXR0YWNobWVudC4KCgp0aGFua3Mu
CgoKCgoKCgoKCgoKCgoKCgrU2iAyMDIwLTA4LTI4IDAxOjE0OjAyo6wiVG9tIFN0IERlbmlzIiA8
dHN0ZGVuaXM4MkBnbWFpbC5jb20+INC0tcCjugoKaXNuJ3QgYSBiZXR0ZXIgZml4IHRvIHNpbXBs
eSBkZWxldGUgdGhlIGxpbmU/ICBUaGUgcHJpbnQgc2VlbXMgcmVkdW5kYW50IHRvIG1lLgoKClRv
bQoKCk9uIFRodSwgQXVnIDI3LCAyMDIwIGF0IDk6MjcgQU0g1cW2/rarIDxlcmRvbmcyMDE4QDE2
My5jb20+IHdyb3RlOgoKCgoKCgoKCgogCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
------=_Part_15904_1053011878.1598578998330
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPlllcywgeW91IGFyZSBy
aWdodC4gTmV3IHBhdGNoIGlzIGluIGF0dGFjaG1lbnQuPC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2lu
OiAwOyI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjogMDsiPnRoYW5rcy48L2Rpdj48cCBz
dHlsZT0ibWFyZ2luOiAwOyI+PGJyPjwvcD48cCBzdHlsZT0ibWFyZ2luOiAwOyI+PGJyPjwvcD48
cCBzdHlsZT0ibWFyZ2luOiAwOyI+PGJyPjwvcD48cCBzdHlsZT0ibWFyZ2luOiAwOyI+PGJyPjwv
cD48ZGl2IHN0eWxlPSJwb3NpdGlvbjpyZWxhdGl2ZTt6b29tOjEiPjwvZGl2PjxkaXYgaWQ9ImRp
dk5ldGVhc2VNYWlsQ2FyZCI+PC9kaXY+PHAgc3R5bGU9Im1hcmdpbjogMDsiPjxicj48L3A+PHA+
1NogMjAyMC0wOC0yOCAwMToxNDowMqOsIlRvbSBTdCBEZW5pcyIgJmx0O3RzdGRlbmlzODJAZ21h
aWwuY29tJmd0OyDQtLXAo7o8L3A+PGJsb2NrcXVvdGUgaWQ9ImlzUmVwbHlDb250ZW50IiBzdHls
ZT0iUEFERElORy1MRUZUOiAxZXg7IE1BUkdJTjogMHB4IDBweCAwcHggMC44ZXg7IEJPUkRFUi1M
RUZUOiAjY2NjIDFweCBzb2xpZCI+PGRpdiBkaXI9Imx0ciI+aXNuJ3QgYSBiZXR0ZXIgZml4IHRv
IHNpbXBseSBkZWxldGUgdGhlIGxpbmU/Jm5ic3A7IFRoZSBwcmludCBzZWVtcyByZWR1bmRhbnQg
dG8gbWUuPGRpdj48YnI+PC9kaXY+PGRpdj5Ub208L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0i
Z21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBUaHUsIEF1
ZyAyNywgMjAyMCBhdCA5OjI3IEFNINXFtv62qyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmVyZG9uZzIw
MThAMTYzLmNvbSI+ZXJkb25nMjAxOEAxNjMuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2Pjxi
bG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAw
LjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6
MWV4Ij48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDoxLjc7Y29sb3I6cmdiKDAsMCwwKTtmb250LXNp
emU6MTRweDtmb250LWZhbWlseTpBcmlhbCI+PHAgc3R5bGU9Im1hcmdpbjowcHgiPjxicj48L3A+
PC9kaXY+PGJyPjxicj48c3BhbiB0aXRsZT0ibmV0ZWFzZWZvb3RlciI+PHA+Jm5ic3A7PC9wPjwv
c3Bhbj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4K
YW1kLWdmeCBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPC9hPjxicj4KPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng8L2E+PGJy
Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PGJyPjxzcGFuIHRp
dGxlPSJuZXRlYXNlZm9vdGVyIj48cD4mbmJzcDs8L3A+PC9zcGFuPg==
------=_Part_15904_1053011878.1598578998330--

------=_Part_15902_98584569.1598578998330
Content-Type: application/octet-stream; 
	name=0001-Delete-redundant-print-info-to-reslove-a-array-bound.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Delete-redundant-print-info-to-reslove-a-array-bound.patch"

RnJvbSBlNjVhYzAwN2U0YWY1MWEwYmZmNWE5ZDQ0ZjRjZWY3NGIzMTVkMjg4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFcmRvbmcgemhhbmcgPGVyZG9uZzIwMThAMTYzLmNvbT4KRGF0
ZTogRnJpLCAyOCBBdWcgMjAyMCAwOTozMzoxMiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdICAgICBE
ZWxldGUgcmVkdW5kYW50IHByaW50IGluZm8gdG8gcmVzbG92ZSBhIGFycmF5IGJvdW5kCiBvdmVy
ZmxvdyBpc3N1ZSBpbiB1bXJfY2xvY2tfbWFudWFsLgoKICAgIElmIGkgaW5wdXQgYSB3cm9uZyBj
bG9jayBuYW1lIG9yIGEgbmFtZSBub3QgZXhpc3QgaW4gYXNpY19jbG9ja3Mgd2hlbiB1c2UgdW1y
IHNldCBjbG9jaywKdGhlIGZ1bmN0aW9uIHVtcl9jbG9ja19tYW51YWwgdHJ5IHRvIGFjY2VzcyBh
cnJheSBhc2ljX2Nsb2Nrcy5jbG9ja1tpXSB3aXRoIGluZGV4IFVNUl9DTE9DS19NQVgsCmZpbmFs
IHRoZSB1bXIgZW5jb3VudGVyIGEgZWdtZW50YXRpb24gZmF1bHQuCi0tLQogc3JjL2FwcC9jbG9j
ay5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2FwcC9jbG9jay5jIGIvc3JjL2FwcC9jbG9jay5jCmluZGV4
IDEwMWRhNmYuLjcwYjNlMGIgMTAwNjQ0Ci0tLSBhL3NyYy9hcHAvY2xvY2suYworKysgYi9zcmMv
YXBwL2Nsb2NrLmMKQEAgLTExNyw3ICsxMTcsOSBAQCB2b2lkIHVtcl9jbG9ja19tYW51YWwoc3Ry
dWN0IHVtcl9hc2ljICphc2ljLCBjb25zdCBjaGFyKiBjbG9ja19uYW1lLCB2b2lkKiB2YWx1ZQog
CQkJCWJyZWFrOwogCQkJfQogCQl9Ci0JCXByaW50X2Nsb2NrKGFzaWNfY2xvY2tzLmNsb2Nrc1tp
XSwgYXNpYyk7CisKKwkJaWYoaSA9PSBVTVJfQ0xPQ0tfTUFYKQorCQkJcHJpbnRmKCJbRVJST1Jd
OiBNYXliZSB3cm9uZyBjbG9jayBuYW1lIG9yIG5vdCBzdXBwb3J0IHNvIGZhciFcbiIpOwogCX0g
ZWxzZSB7CiAJCXByaW50ZigiW0VSUk9SXTogSW52YWxpZCBpbnB1dCFcbiIpOwogCX0KLS0gCjIu
MTcuMQoK
------=_Part_15902_98584569.1598578998330
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

------=_Part_15902_98584569.1598578998330--

