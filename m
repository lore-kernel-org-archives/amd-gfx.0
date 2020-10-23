Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969A6C4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 03:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13EA52177B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 03:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="TQduE1Ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EA52177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6836E44C;
	Fri, 23 Oct 2020 03:18:10 +0000 (UTC)
X-Greylist: delayed 904 seconds by postgrey-1.36 at gabe;
 Fri, 23 Oct 2020 03:18:08 UTC
Received: from m1382.mail.163.com (m1382.mail.163.com [220.181.13.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 573086E44C
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 03:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=1Pvh8
 mFEVS6VudGKHndMZUy5PJRYE5XRK7tYbGhcD9E=; b=TQduE1EwztyFYFOz59p+s
 9yQ0ioXycyZEs1rldPwQO+8Yh/mby/0pGBF/5dDp0Gxdn7r7zZNN6Al7u0pB8mxv
 /VzRAsWenCSjVb+vIZ6rh2X6FXI1vKpjAv3miRo/lvbOkut3d/46yYXtrEplTxci
 G3yDxjrea5d1eWhZSRdTHc=
Received: from raykwok1150$163.com ( [202.111.33.178] ) by
 ajax-webmail-wmsvr82 (Coremail) ; Fri, 23 Oct 2020 11:02:57 +0800 (CST)
X-Originating-IP: [202.111.33.178]
Date: Fri, 23 Oct 2020 11:02:57 +0800 (CST)
From: "Lei Guo" <raykwok1150@163.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Fix bug to get average GPU power
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
X-CM-CTRLDATA: pLzoJmZvb3Rlcl9odG09MjA0Nzo1Ng==
MIME-Version: 1.0
Message-ID: <f843846.2b92.1755368c82e.Coremail.raykwok1150@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: UsGowADn79fhR5Jf4iaxAA--.1674W
X-CM-SenderInfo: 5ud1y41rnrikqq6rljoofrz/xtbCChLGYF2MYcaBkAACsb
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
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
Content-Type: multipart/mixed; boundary="===============0591400100=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0591400100==
Content-Type: multipart/alternative; 
	boundary="----=_Part_40678_1750817325.1603422177326"

------=_Part_40678_1750817325.1603422177326
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

RnJvbSAwMjc3MzE4ZmMxNzk5ZDE3ODc4ZDlmNDA3MjU0NzczZmMyYmI5NjRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQoKRnJvbTogR3VvIExlaSA8cmF5a3dvazExNTBAMTYzLmNvbT4KCkRhdGU6
IEZyaSwgMTYgT2N0IDIwMjAgMTc6MDM6NDQgKzA4MDAKClN1YmplY3Q6IFtQQVRDSF0gRml4IGJ1
ZyB0byBnZXQgYXZlcmFnZSBHUFUgcG93ZXIKCgoKClN5bmNocm9uaXplIGVtdSBhbWRfcHBfc2Vu
c29ycyB3aXRoIGtnZF9wcF9pbnRlcmZhY2UuaAoKCgoKU2lnbmVkLW9mZi1ieTogR3VvIExlaSA8
cmF5a3dvazExNTBAMTYzLmNvbT4KCkNoYW5nZS1JZDogSTUzMWZhMDA2ZWNkZDFkNDJlNTg5YmJm
ZTc5YTdkNjY5OWFlNWIyYjYKCi0tLQoKIHNyYy91bXIuaCB8IDMgKysrCgogMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQoKCgoKZGlmZiAtLWdpdCBhL3NyYy91bXIuaCBiL3NyYy91bXIu
aAoKaW5kZXggYzkyOGZhZC4uOGM0NWYxMiAxMDA2NDQKCi0tLSBhL3NyYy91bXIuaAoKKysrIGIv
c3JjL3Vtci5oCgpAQCAtNzksNiArNzksOSBAQCBlbnVtIGFtZF9wcF9zZW5zb3JzIHsKCiBBTURH
UFVfUFBfU0VOU09SX01FTV9MT0FELAoKIEFNREdQVV9QUF9TRU5TT1JfR0ZYX01DTEssCgogQU1E
R1BVX1BQX1NFTlNPUl9HUFVfVEVNUCwKCitBTURHUFVfUFBfU0VOU09SX0VER0VfVEVNUCA9IEFN
REdQVV9QUF9TRU5TT1JfR1BVX1RFTVAsCgorQU1ER1BVX1BQX1NFTlNPUl9IT1RTUE9UX1RFTVAs
CgorQU1ER1BVX1BQX1NFTlNPUl9NRU1fVEVNUCwKCiBBTURHUFVfUFBfU0VOU09SX1ZDRV9QT1dF
UiwKCiBBTURHUFVfUFBfU0VOU09SX1VWRF9QT1dFUiwKCiBBTURHUFVfUFBfU0VOU09SX0dQVV9Q
T1dFUiwKCi0tIAoKMi4xNy4xCgoK
------=_Part_40678_1750817325.1603422177326
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxwIHN0eWxlPSJtYXJnaW46MDsiPkZyb20gMDI3NzMxOGZjMTc5
OWQxNzg3OGQ5ZjQwNzI1NDc3M2ZjMmJiOTY0YyBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDE8L3A+
PHAgc3R5bGU9Im1hcmdpbjowOyI+RnJvbTogR3VvIExlaSAmbHQ7cmF5a3dvazExNTBAMTYzLmNv
bSZndDs8L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+RGF0ZTogRnJpLCAxNiBPY3QgMjAyMCAxNzow
Mzo0NCArMDgwMDwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij5TdWJqZWN0OiBbUEFUQ0hdIEZpeCBi
dWcgdG8gZ2V0IGF2ZXJhZ2UgR1BVIHBvd2VyPC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPjxicj48
L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+U3luY2hyb25pemUgZW11IGFtZF9wcF9zZW5zb3JzIHdp
dGgga2dkX3BwX2ludGVyZmFjZS5oPC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPjxicj48L3A+PHAg
c3R5bGU9Im1hcmdpbjowOyI+U2lnbmVkLW9mZi1ieTogR3VvIExlaSAmbHQ7cmF5a3dvazExNTBA
MTYzLmNvbSZndDs8L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+Q2hhbmdlLUlkOiBJNTMxZmEwMDZl
Y2RkMWQ0MmU1ODliYmZlNzlhN2Q2Njk5YWU1YjJiNjwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4t
LS08L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+Jm5ic3A7c3JjL3Vtci5oIHwgMyArKys8L3A+PHAg
c3R5bGU9Im1hcmdpbjowOyI+Jm5ic3A7MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKTwv
cD48cCBzdHlsZT0ibWFyZ2luOjA7Ij48YnI+PC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPmRpZmYg
LS1naXQgYS9zcmMvdW1yLmggYi9zcmMvdW1yLmg8L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+aW5k
ZXggYzkyOGZhZC4uOGM0NWYxMiAxMDA2NDQ8L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+LS0tIGEv
c3JjL3Vtci5oPC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPisrKyBiL3NyYy91bXIuaDwvcD48cCBz
dHlsZT0ibWFyZ2luOjA7Ij5AQCAtNzksNiArNzksOSBAQCBlbnVtIGFtZF9wcF9zZW5zb3JzIHs8
L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5BTURHUFVfUFBfU0VOU09SX01FTV9MT0FELDwvcD48cCBzdHlsZT0ibWFyZ2lu
OjA7Ij4mbmJzcDs8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPkFNREdQVV9Q
UF9TRU5TT1JfR0ZYX01DTEssPC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPiZuYnNwOzxzcGFuIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+QU1ER1BVX1BQX1NFTlNPUl9HUFVfVEVNUCw8
L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+KzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+QU1ER1BVX1BQX1NFTlNPUl9FREdFX1RFTVAgPSBBTURHUFVfUFBfU0VOU09SX0dQVV9U
RU1QLDwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4rPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5BTURHUFVfUFBfU0VOU09SX0hPVFNQT1RfVEVNUCw8L3A+PHAgc3R5bGU9Im1h
cmdpbjowOyI+KzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+QU1ER1BVX1BQ
X1NFTlNPUl9NRU1fVEVNUCw8L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+Jm5ic3A7PHNwYW4gc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5BTURHUFVfUFBfU0VOU09SX1ZDRV9QT1dFUiw8
L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5BTURHUFVfUFBfU0VOU09SX1VWRF9QT1dFUiw8L3A+PHAgc3R5bGU9Im1hcmdp
bjowOyI+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5BTURHUFVf
UFBfU0VOU09SX0dQVV9QT1dFUiw8L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+LS0mbmJzcDs8L3A+
PHAgc3R5bGU9Im1hcmdpbjowOyI+Mi4xNy4xPC9wPjxkaXY+PGJyPjwvZGl2PjwvZGl2Pjxicj48
YnI+PHNwYW4gdGl0bGU9Im5ldGVhc2Vmb290ZXIiPjxwPiZuYnNwOzwvcD48L3NwYW4+
------=_Part_40678_1750817325.1603422177326--


--===============0591400100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0591400100==--

