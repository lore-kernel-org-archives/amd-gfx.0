Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.9 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB76C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 13:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A53D207CD
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 13:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="BFvwQCmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A53D207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 188B96E2B2;
	Thu, 27 Aug 2020 13:27:20 +0000 (UTC)
Received: from m13120.mail.163.com (unknown [220.181.13.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D4796EB21
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 08:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=lHHBE
 xMPgVKMEPPQcrrUfKz/uKP5ia2rqaZX66RjnsA=; b=BFvwQCmMxrrbQ1rw0h0il
 W/IBSNh7sg1ovxOoaXmjJ30VH7uoAeEhdb6SZDP9ggT0cRbVUvgbviZzHxmDaVQZ
 4L1S0YAguLEH37y19PBGfde2+jUZNV5akb0Jasq1XHGJQYBUtQVHVk9DlytlW7VQ
 fqFxYCZnWt1tJbL9Cnhf+0=
Received: from erdong2018$163.com ( [118.242.3.34] ) by
 ajax-webmail-wmsvr120 (Coremail) ; Thu, 27 Aug 2020 16:11:52 +0800 (CST)
X-Originating-IP: [118.242.3.34]
Date: Thu, 27 Aug 2020 16:11:52 +0800 (CST)
From: =?GBK?B?1cW2/rar?= <erdong2018@163.com>
To: amd-gfx@lists.freedesktop.org
Subject: 0001-Fix-a-array-bound-overflow-bug-in-function-umr_clock
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
X-CM-CTRLDATA: H/pF2GZvb3Rlcl9odG09MTExOjU2
Content-Type: multipart/mixed; 
 boundary="----=_Part_61674_690762357.1598515912566"
MIME-Version: 1.0
Message-ID: <5eb9e79.42da.1742ef91f76.Coremail.erdong2018@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: eMGowACHz8rIakdfcwJgAA--.47407W
X-CM-SenderInfo: phug00jjsqimi6rwjhhfrp/xtbBiB2Nc1aD8RTxQAABsr
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Thu, 27 Aug 2020 13:27:19 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

------=_Part_61674_690762357.1598515912566
Content-Type: multipart/alternative; 
	boundary="----=_Part_61676_635865421.1598515912566"

------=_Part_61676_635865421.1598515912566
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

Cg==
------=_Part_61676_635865421.1598515912566
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxwIHN0eWxlPSJtYXJnaW46MDsiPjxicj48L3A+PC9kaXY+PGJy
Pjxicj48c3BhbiB0aXRsZT0ibmV0ZWFzZWZvb3RlciI+PHA+Jm5ic3A7PC9wPjwvc3Bhbj4=
------=_Part_61676_635865421.1598515912566--

------=_Part_61674_690762357.1598515912566
Content-Type: application/octet-stream; 
	name=0001-Fix-a-array-bound-overflow-bug-in-function-umr_clock.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Fix-a-array-bound-overflow-bug-in-function-umr_clock.patch"

RnJvbSBiYTA1YmMwZjdmYTVmOGRiYzg5OTgzODRiYjcxM2EyYTY5YmU1OGI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFcmRvbmcgemhhbmcgPGVyZG9uZzIwMThAMTYzLmNvbT4KRGF0
ZTogVGh1LCAyNyBBdWcgMjAyMCAxNTo0MDoxMyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdICAgICBG
aXggYSBhcnJheSBib3VuZCBvdmVyZmxvdyBidWcgaW4gZnVuY3Rpb24KIHVtcl9jbG9ja19tYW51
YWwKCiAgICBJZiBpIGlucHV0IGEgd3JvbmcgY2xvY2sgbmFtZSBvciBhIG5hbWUgbm90IGV4aXN0
IGluIGFzaWNfY2xvY2tzIHdoZW4gdXNlIHVtciBzZXQgY2xvY2ssCnRoZSBmdW5jdGlvbiB1bXJf
Y2xvY2tfbWFudWFsIHRyeSB0byBhY2Nlc3MgYXJyYXkgYXNpY19jbG9ja3MuY2xvY2tbaV0gd2l0
aCBpbmRleCBVTVJfQ0xPQ0tfTUFYLApmaW5hbCB0aGUgdW1yIGVuY291bnRlciBhIGVnbWVudGF0
aW9uIGZhdWx0LgotLS0KIHNyYy9hcHAvY2xvY2suYyB8IDYgKysrKystCiAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2FwcC9j
bG9jay5jIGIvc3JjL2FwcC9jbG9jay5jCmluZGV4IDEwMWRhNmYuLjg4MTg5MTggMTAwNjQ0Ci0t
LSBhL3NyYy9hcHAvY2xvY2suYworKysgYi9zcmMvYXBwL2Nsb2NrLmMKQEAgLTExNyw3ICsxMTcs
MTEgQEAgdm9pZCB1bXJfY2xvY2tfbWFudWFsKHN0cnVjdCB1bXJfYXNpYyAqYXNpYywgY29uc3Qg
Y2hhciogY2xvY2tfbmFtZSwgdm9pZCogdmFsdWUKIAkJCQlicmVhazsKIAkJCX0KIAkJfQotCQlw
cmludF9jbG9jayhhc2ljX2Nsb2Nrcy5jbG9ja3NbaV0sIGFzaWMpOworCisJCWlmKGkgPCBVTVJf
Q0xPQ0tfTUFYKQorCQkJcHJpbnRfY2xvY2soYXNpY19jbG9ja3MuY2xvY2tzW2ldLCBhc2ljKTsK
KwkJZWxzZQorCQkJcHJpbnRmKCJbRVJST1JdOiBNYXliZSB3cm9uZyBjbG9jayBuYW1lIVxuIik7
CiAJfSBlbHNlIHsKIAkJcHJpbnRmKCJbRVJST1JdOiBJbnZhbGlkIGlucHV0IVxuIik7CiAJfQot
LSAKMi4xNy4xCgo=
------=_Part_61674_690762357.1598515912566
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

------=_Part_61674_690762357.1598515912566--

