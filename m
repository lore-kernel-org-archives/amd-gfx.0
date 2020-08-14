Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC6CC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 02:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFEB2078D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 02:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="COwt4Kqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFEB2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66AA6E2D1;
	Fri, 14 Aug 2020 02:57:51 +0000 (UTC)
X-Greylist: delayed 910 seconds by postgrey-1.36 at gabe;
 Fri, 14 Aug 2020 02:34:59 UTC
Received: from m1370.mail.163.com (m1370.mail.163.com [220.181.13.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE3356E162
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 02:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=kebyJ
 Tq3hxkT3wLxqphoDSaHtgSHb2H4nlL8u0BVEwI=; b=COwt4Kqb7A2TBZ0/kIUoM
 jGdOpvL2hjb6OLiXUj/5ANoFwWsK5gYcEtidhKloUQiM2I4pmyWMHEj5uh14Edmv
 Ut78dlrsTbj1S8jsC/8RyT+7lD7TtAbBzoXjkU4BCzkHEe0Nmcn4GRc0ovlMP+bK
 eKY4iL2t8rmQSL3EUkN8HM=
Received: from erdong2018$163.com ( [118.242.3.34] ) by ajax-webmail-wmsvr70
 (Coremail) ; Fri, 14 Aug 2020 10:19:37 +0800 (CST)
X-Originating-IP: [118.242.3.34]
Date: Fri, 14 Aug 2020 10:19:37 +0800 (CST)
From: =?GBK?B?1cW2/rar?= <erdong2018@163.com>
To: amd-gfx@lists.freedesktop.org
Subject: Fix a memory leak bug for umr tool.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
X-CM-CTRLDATA: DzUzvGZvb3Rlcl9odG09NjI5OjU2
Content-Type: multipart/mixed; 
 boundary="----=_Part_27077_1387277942.1597371577283"
MIME-Version: 1.0
Message-ID: <376916b5.1ca1.173eac3f3c4.Coremail.erdong2018@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: RsGowADX34+59DVfr1FwAA--.32178W
X-CM-SenderInfo: phug00jjsqimi6rwjhhfrp/1tbiUQZ-c1WBQYZWPAACsg
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Fri, 14 Aug 2020 02:57:51 +0000
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

------=_Part_27077_1387277942.1597371577283
Content-Type: multipart/alternative; 
	boundary="----=_Part_27079_5957124.1597371577283"

------=_Part_27079_5957124.1597371577283
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGk6IAogICAgICAgVGhlIGZ1bmN0aW9uIHVtcl9wbTRfZGVjb2RlX3JpbmdfaXNfaGFsdGVkIGNh
bGwgdW1yX3JlYWRfcmluZ19kYXRhCgogICAgdG8gZ2V0IHJpbmdkYXRhLCB1bXJfcmVhZF9yaW5n
X2RhdGEgd2lsbCBhbGxvYyBtZW1vcnkgdG8gc3RvcmUgcmluZwoKICAgIGRhdGEgYW5kIHJldHVy
biB0aGUgbWVtb3J5IHBvaW50ZXIgdG8gdW1yX3BtNF9kZWNvZGVfcmluZ19pc19oYWx0ZWQsIFNv
CgogICAgdGhlIG1lbW9yeSBzaG91bGQgYmUgZnJlZSBpbiB1bXJfcG00X2RlY29kZV9yaW5nX2lz
X2hhbHRlZC4KCgpUaGFua3Mu
------=_Part_27079_5957124.1597371577283
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+SGk6Jm5ic3A7PC9kaXY+
PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDsmbmJzcDsgJm5ic3A7ICZuYnNwOyBUaGUgZnVu
Y3Rpb24gdW1yX3BtNF9kZWNvZGVfcmluZ19pc19oYWx0ZWQgY2FsbCB1bXJfcmVhZF9yaW5nX2Rh
dGE8L2Rpdj48cCBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDsgJm5ic3A7IHRvIGdldCByaW5nZGF0
YSwgdW1yX3JlYWRfcmluZ19kYXRhIHdpbGwgYWxsb2MgbWVtb3J5IHRvIHN0b3JlIHJpbmc8L3A+
PHAgc3R5bGU9Im1hcmdpbjowOyI+Jm5ic3A7ICZuYnNwOyBkYXRhIGFuZCByZXR1cm4gdGhlIG1l
bW9yeSBwb2ludGVyIHRvIHVtcl9wbTRfZGVjb2RlX3JpbmdfaXNfaGFsdGVkLCBTbzwvcD48ZGl2
IHN0eWxlPSJtYXJnaW46MDsiPiZuYnNwOyAmbmJzcDsgdGhlIG1lbW9yeSBzaG91bGQgYmUgZnJl
ZSBpbiB1bXJfcG00X2RlY29kZV9yaW5nX2lzX2hhbHRlZC48L2Rpdj48ZGl2IHN0eWxlPSJtYXJn
aW46MDsiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPlRoYW5rcy48L2Rpdj48L2Rp
dj48YnI+PGJyPjxzcGFuIHRpdGxlPSJuZXRlYXNlZm9vdGVyIj48cD4mbmJzcDs8L3A+PC9zcGFu
Pg==
------=_Part_27079_5957124.1597371577283--

------=_Part_27077_1387277942.1597371577283
Content-Type: application/octet-stream; 
	name=0001-fix-a-memory-leak-bug-in-function-umr_pm4_decode_rin.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-fix-a-memory-leak-bug-in-function-umr_pm4_decode_rin.patch"

RnJvbSAwZDRkZGMwNThjNDMzYzE4ODdlNGM4MTliYzcxM2YxZDg0MmZkN2MxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFcmRvbmcgemhhbmcgPGVyZG9uZzIwMThAMTYzLmNvbT4KRGF0
ZTogRnJpLCAxNCBBdWcgMjAyMCAwOTo0MzoxMSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdICAgICBm
aXggYSBtZW1vcnkgbGVhayBidWcgaW4gZnVuY3Rpb24KIHVtcl9wbTRfZGVjb2RlX3JpbmdfaXNf
aGFsdGVkCgogICAgICAgIFRoZSBmdW5jdGlvbiB1bXJfcG00X2RlY29kZV9yaW5nX2lzX2hhbHRl
ZCBjYWxsIHVtcl9yZWFkX3JpbmdfZGF0YQogICAgdG8gZ2V0IHJpbmdkYXRhLCB1bXJfcmVhZF9y
aW5nX2RhdGEgd2lsbCBhbGxvYyBtZW1vcnkgdG8gc3RvcmUgcmluZwogICAgZGF0YSBhbmQgcmV0
dXJuIHRoZSBtZW1vcnkgcG9pbnRlciB0byB1bXJfcG00X2RlY29kZV9yaW5nX2lzX2hhbHRlZCwg
U28KICAgIHRoZSBtZW1vcnkgc2hvdWxkIGJlIGZyZWUgaW4gdW1yX3BtNF9kZWNvZGVfcmluZ19p
c19oYWx0ZWQuCi0tLQogc3JjL2xpYi91bXJfcmVhZF9wbTRfc3RyZWFtLmMgfCA2ICsrKysrLQog
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL3NyYy9saWIvdW1yX3JlYWRfcG00X3N0cmVhbS5jIGIvc3JjL2xpYi91bXJfcmVhZF9wbTRf
c3RyZWFtLmMKaW5kZXggNWQxNzYwZS4uYjdkY2I5MSAxMDA2NDQKLS0tIGEvc3JjL2xpYi91bXJf
cmVhZF9wbTRfc3RyZWFtLmMKKysrIGIvc3JjL2xpYi91bXJfcmVhZF9wbTRfc3RyZWFtLmMKQEAg
LTMzNywxMCArMzM3LDE0IEBAIGludCB1bXJfcG00X2RlY29kZV9yaW5nX2lzX2hhbHRlZChzdHJ1
Y3QgdW1yX2FzaWMgKmFzaWMsIGNoYXIgKnJpbmduYW1lKQogCQlyaW5nc2l6ZSAvPSA0OwogCQly
aW5nZGF0YVswXSAlPSByaW5nc2l6ZTsKIAkJcmluZ2RhdGFbMV0gJT0gcmluZ3NpemU7Ci0JCWlm
IChyaW5nZGF0YVswXSA9PSByaW5nZGF0YVsxXSkKKwkJaWYgKHJpbmdkYXRhWzBdID09IHJpbmdk
YXRhWzFdKXsKKwkJCWZyZWUocmluZ2RhdGEpOwogCQkJcmV0dXJuIDA7CisJCX0KIAkJdXNsZWVw
KDUpOwogCX0KKwkKKwlmcmVlKHJpbmdkYXRhKTsKIAlyZXR1cm4gMTsKIH0KIAotLSAKMi4xNy4x
Cgo=
------=_Part_27077_1387277942.1597371577283
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

------=_Part_27077_1387277942.1597371577283--

