Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39E4C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 07:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C095D2068E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 07:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="ohFavSo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C095D2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8426E2BD;
	Mon, 15 Jun 2020 07:29:00 +0000 (UTC)
X-Greylist: delayed 906 seconds by postgrey-1.36 at gabe;
 Mon, 15 Jun 2020 07:28:58 UTC
Received: from m1382.mail.163.com (m1382.mail.163.com [220.181.13.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 354746E2B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 07:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=MinxN
 B2rtPLm+WPE9jcC+0KeFgL8vITTt2/LRkTCfzw=; b=ohFavSo+n4Ls9Zpscx+Uj
 eG4brTzsa1uegntN7JKZuAXUTZiXwa+tTu8oZhYt61lW2lk1PcfWqHVgR4j8AYOX
 jvhLht7wetKgJATsJb9aQpIJ2XM2VuaveAHKnY1HrMuFDUswcwovndZ2o1aUZ4vu
 oegpJpG2jeqLTjMgtQXMOY=
Received: from raykwok1150$163.com ( [118.242.3.34] ) by
 ajax-webmail-wmsvr82 (Coremail) ; Mon, 15 Jun 2020 15:13:42 +0800 (CST)
X-Originating-IP: [118.242.3.34]
Date: Mon, 15 Jun 2020 15:13:42 +0800 (CST)
From: "Guo Lei" <raykwok1150@163.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix incorrect firmware size calculation
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
X-CM-CTRLDATA: KAQsKWZvb3Rlcl9odG09MjQ5MDo1Ng==
MIME-Version: 1.0
Message-ID: <611402e8.64f3.172b6d3a40c.Coremail.raykwok1150@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: UsGowABXY2amH+dedhdUAA--.61412W
X-CM-SenderInfo: 5ud1y41rnrikqq6rljoofrz/1tbitB9EYFSIhcSzUgABsy
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
Content-Type: multipart/mixed; boundary="===============1925081485=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1925081485==
Content-Type: multipart/alternative; 
	boundary="----=_Part_93883_1020225277.1592205222924"

------=_Part_93883_1020225277.1592205222924
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

RnJvbSAwMTQxNjJmNjliOTA5YTU5YzI0MWU3ZjczYzM2MzBkMWRhMzQ2OTZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQoKRnJvbTogTGVpIEd1byA8cmF5a3dvazExNTBAMTYzLmNvbT4KCkRhdGU6
IE1vbiwgMTUgSnVuIDIwMjAgMTM6NTQ6MjYgKzA4MDAKClN1YmplY3Q6IFtQQVRDSF0gZHJtL2Ft
ZGdwdTogRml4IGluY29ycmVjdCBmaXJtd2FyZSBzaXplIGNhbGN1bGF0aW9uCgoKCgpbV0hZXQoK
VGhlIG1lbWNweSgpIGZ1bmN0aW9uIGNvcGllcyBuIGJ5dGVzIGZyb20gbWVtb3J5IGFyZWEgc3Jj
IHRvIG1lbW9yeSBhcmVhCgpkZXN0LiBTbyBzcGVjaWZ5IHRoZSBmaXJtd2FyZSBzaXplIGluIGJ5
dGVzLgoKCgoKW0hvd10KCkNvcnJlY3QgdGhlIGNhbGN1bGF0aW9uLgoKCgoKU2lnbmVkLW9mZi1i
eTogTGVpIEd1byA8cmF5a3dvazExNTBAMTYzLmNvbT4KClJldmlld2VkLWJ5OiBKdW53ZWkgWmhh
bmcgPHpqdW53ZWloaXRAMTYzLmNvbT4KCi0tLQoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OV8wLmMgfCAyICstCgogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgoKCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKCmluZGV4IDZi
OTQ1ODdkZjQwNy4uYzNlNTliNzY1MjY4IDEwMDY0NAoKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y5XzAuYwoKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y5XzAuYwoKQEAgLTE5NjAsNyArMTk2MCw3IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfbWVjX2lu
aXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCgogZndfZGF0YSA9IChjb25zdCBfX2xlMzIg
KikKCiAoYWRldi0+Z2Z4Lm1lY19mdy0+ZGF0YSArCgogIGxlMzJfdG9fY3B1KG1lY19oZHItPmhl
YWRlci51Y29kZV9hcnJheV9vZmZzZXRfYnl0ZXMpKTsKCi1md19zaXplID0gbGUzMl90b19jcHUo
bWVjX2hkci0+aGVhZGVyLnVjb2RlX3NpemVfYnl0ZXMpIC8gNDsKCitmd19zaXplID0gbGUzMl90
b19jcHUobWVjX2hkci0+aGVhZGVyLnVjb2RlX3NpemVfYnl0ZXMpOwoKIAoKIHIgPSBhbWRncHVf
Ym9fY3JlYXRlX3Jlc2VydmVkKGFkZXYsIG1lY19oZHItPmhlYWRlci51Y29kZV9zaXplX2J5dGVz
LAoKICAgICAgIFBBR0VfU0laRSwgQU1ER1BVX0dFTV9ET01BSU5fR1RULAoKLS0gCgoyLjE3LjEK
Cgo=
------=_Part_93883_1020225277.1592205222924
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxwIHN0eWxlPSJtYXJnaW46MDsiPkZyb20gMDE0MTYyZjY5Yjkw
OWE1OWMyNDFlN2Y3M2MzNjMwZDFkYTM0Njk2YyBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDE8L3A+
PHAgc3R5bGU9Im1hcmdpbjowOyI+RnJvbTogTGVpIEd1byAmbHQ7cmF5a3dvazExNTBAMTYzLmNv
bSZndDs8L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+RGF0ZTogTW9uLCAxNSBKdW4gMjAyMCAxMzo1
NDoyNiArMDgwMDwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij5TdWJqZWN0OiBbUEFUQ0hdIGRybS9h
bWRncHU6IEZpeCBpbmNvcnJlY3QgZmlybXdhcmUgc2l6ZSBjYWxjdWxhdGlvbjwvcD48cCBzdHls
ZT0ibWFyZ2luOjA7Ij48YnI+PC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPltXSFldPC9wPjxwIHN0
eWxlPSJtYXJnaW46MDsiPlRoZSBtZW1jcHkoKSBmdW5jdGlvbiBjb3BpZXMgbiBieXRlcyBmcm9t
IG1lbW9yeSBhcmVhIHNyYyB0byBtZW1vcnkgYXJlYTwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij5k
ZXN0LiBTbyBzcGVjaWZ5IHRoZSBmaXJtd2FyZSBzaXplIGluIGJ5dGVzLjwvcD48cCBzdHlsZT0i
bWFyZ2luOjA7Ij48YnI+PC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPltIb3ddPC9wPjxwIHN0eWxl
PSJtYXJnaW46MDsiPkNvcnJlY3QgdGhlIGNhbGN1bGF0aW9uLjwvcD48cCBzdHlsZT0ibWFyZ2lu
OjA7Ij48YnI+PC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPlNpZ25lZC1vZmYtYnk6IExlaSBHdW8g
Jmx0O3JheWt3b2sxMTUwQDE2My5jb20mZ3Q7PC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPlJldmll
d2VkLWJ5OiBKdW53ZWkgWmhhbmcgJmx0O3pqdW53ZWloaXRAMTYzLmNvbSZndDs8L3A+PHAgc3R5
bGU9Im1hcmdpbjowOyI+LS0tPC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPiZuYnNwO2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCAyICstPC9wPjxwIHN0eWxlPSJtYXJnaW46
MDsiPiZuYnNwOzEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKTwv
cD48cCBzdHlsZT0ibWFyZ2luOjA7Ij48YnI+PC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYzwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij5pbmRl
eCA2Yjk0NTg3ZGY0MDcuLmMzZTU5Yjc2NTI2OCAxMDA2NDQ8L3A+PHAgc3R5bGU9Im1hcmdpbjow
OyI+LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYzwvcD48cCBzdHls
ZT0ibWFyZ2luOjA7Ij4rKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5j
PC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPkBAIC0xOTYwLDcgKzE5NjAsNyBAQCBzdGF0aWMgaW50
IGdmeF92OV8wX21lY19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTwvcD48cCBzdHls
ZT0ibWFyZ2luOjA7Ij4mbmJzcDs8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PmZ3X2RhdGEgPSAoY29uc3QgX19sZTMyICopPC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPiZuYnNw
OzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgkJPC9zcGFuPihhZGV2LSZndDtnZngubWVj
X2Z3LSZndDtkYXRhICs8L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+Jm5ic3A7PHNwYW4gc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+IGxlMzJfdG9fY3B1KG1lY19oZHItJmd0O2hlYWRl
ci51Y29kZV9hcnJheV9vZmZzZXRfYnl0ZXMpKTs8L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+LTxz
cGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Zndfc2l6ZSA9IGxlMzJfdG9fY3B1
KG1lY19oZHItJmd0O2hlYWRlci51Y29kZV9zaXplX2J5dGVzKSAvIDQ7PC9wPjxwIHN0eWxlPSJt
YXJnaW46MDsiPis8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmZ3X3NpemUg
PSBsZTMyX3RvX2NwdShtZWNfaGRyLSZndDtoZWFkZXIudWNvZGVfc2l6ZV9ieXRlcyk7PC9wPjxw
IHN0eWxlPSJtYXJnaW46MDsiPiZuYnNwOzwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDs8
c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnIgPSBhbWRncHVfYm9fY3JlYXRl
X3Jlc2VydmVkKGFkZXYsIG1lY19oZHItJmd0O2hlYWRlci51Y29kZV9zaXplX2J5dGVzLDwvcD48
cCBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDs8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
CQkJPC9zcGFuPiZuYnNwOyAmbmJzcDsgJm5ic3A7IFBBR0VfU0laRSwgQU1ER1BVX0dFTV9ET01B
SU5fR1RULDwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4tLSZuYnNwOzwvcD48cCBzdHlsZT0ibWFy
Z2luOjA7Ij4yLjE3LjE8L3A+PGRpdj48YnI+PC9kaXY+PC9kaXY+PGJyPjxicj48c3BhbiB0aXRs
ZT0ibmV0ZWFzZWZvb3RlciI+PHA+Jm5ic3A7PC9wPjwvc3Bhbj4=
------=_Part_93883_1020225277.1592205222924--


--===============1925081485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1925081485==--

