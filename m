Return-Path: <SRS0=xdDd=JC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E29C433ED
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Apr 2021 16:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54471613A0
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Apr 2021 16:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54471613A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qq.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5DDF89CA0;
	Mon,  5 Apr 2021 16:18:53 +0000 (UTC)
X-Greylist: delayed 429 seconds by postgrey-1.36 at gabe;
 Mon, 05 Apr 2021 16:09:10 UTC
Received: from qq.com (smtpbg413.qq.com [113.96.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0564D89ED3
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Apr 2021 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1617638503; bh=nQuEu7EzvaKkU4dK1vpGKWBH/+lQvqT8RagFHkFryvM=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=nZHaZlI5D86chXDKDFMbj0KxHg2nxzKAWoDunv1KSH7KSF4i3zBkDmeCr0GExsj7Y
 e727IgoPAkx/l6+ps+lJDRc5fkIzL2lvLzk7XlWIUw+ppfw73iPPGxu2GObelFCCsV
 3TC/WZsQZ6Fun6d9bNRQVaQI4Z+AzG3euzrFDWn4=
X-QQ-FEAT: XlyovC/qA/eUC9TJEJFNZHkhoZpbDpwQf10PkYThZ7sdoQN07xh9SraihacEu
 se50KeltZxKQL0NqYJlYdG0XvDXVPC6Y5bco499iwKKwXKsjRU8tbQI4n657lATpKhHlKaH
 /KfbyOnXCrxbE4Ws/h//qOJq2yF9reSgkvjh7C+a7+SyIK1pxAZfS1S+BBMTPhhe826OJu9
 tjMpwactOPwQF4s7vqtirX7aFj3vHKOyMoFqepQQ88ocAY9d3NsSXrwWtxOGlKqZrQeF7FU
 nLJn20k98F60ae
X-QQ-SSF: 000000000000001000000000000000Z
X-QQ-XMAILINFO: NGKE9ndak/QuSZoitMiZbvd4qX2F0ZgA7D6CtKMTlHGOGmQguwAuScPWBpLWMX
 kgSTl1WOm86jzmbbt+MiBsSSxYVjnUcF6eAtY9A9jKhi/9eihf1fR85sKwrxf6guuQ+dhH7i8Tp+Q
 kCZtennQDUycGQkV7oAgc0Gy8LAiq/KmPWxO5grOY/FQ7wI7JUOUGGCkhuo9I2//E0q1Ln+aqsOZm
 iic/YjlG3eBtbibI1psM6NEx1aADvWUqskDuK0odzDRWsZ/qbHGR9bBEVggm9ooWxpxEsVyjATjZM
 x7dkFrEAj6fIKKksPHRY53SIZNE4F8FNlmkYZExisShtE7Lq4kxWM1xeZA3MznOLw9nnu+w//u09F
 2SvTwb+LWN0M2xyUVAVF9mQmx69kMIUYMoEUTeuzA2BgJ5D/IlccH5V3qCNShVnxcn7/mO4Qk0vQj
 HqYgXTcGONhp5XbE6Lc7Oh2D3Y9HlfTqoklXQ7jwoOnMzprTwwJRK+FE33WzLhYWorIMT1CITzezS
 Rm35rKbPNuGlHWNnIsaogUifgUD1LAfk3reTGavlbl+YAbj3EPma8VFa5VfiU0kEIbdTe2kCrDkRL
 7cGgK7MPgWkegld57Vhl7JUFDXQzekGen63/gTavtuG9Ta8qktfeZqJ4xCKjeBhPLX+lO7TlmboIw
 dGLBRQ1hxalquGSqXvZ+zkSfhz7XKiACTAMp2SjqKpg/GqyOrkrAm4hXxgHGgQsseeZrtxy5OA3el
 EqSCisloN2Q3Yz55hlgXhNi7l
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 114.84.240.151
X-QQ-STYLE: 
X-QQ-mid: webmail826t1617638502t6917251
From: "=?ISO-8859-1?B?MjU4NDU0OTQ2?=" <258454946@qq.com>
To: "=?ISO-8859-1?B?YW1kLWdmeA==?=" <amd-gfx@lists.freedesktop.org>
Subject: a quetion about buffer migration for user mapped bo.
Mime-Version: 1.0
Date: Tue, 6 Apr 2021 00:01:42 +0800
X-Priority: 3
Message-ID: <tencent_826EEA87BF2072281A8B94B2955DDCA14E05@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Tue, 06 Apr 2021 00:01:43 +0800 (CST)
Feedback-ID: webmail:qq.com:bgforeign:bgforeign11
X-QQ-Bgrelay: 1
X-Mailman-Approved-At: Mon, 05 Apr 2021 16:18:52 +0000
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
Content-Type: multipart/mixed; boundary="===============0655195698=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.

--===============0655195698==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_606B3466_11625A20_4392872D"
Content-Transfer-Encoding: 8Bit

This is a multi-part message in MIME format.

------=_NextPart_606B3466_11625A20_4392872D
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGkgR3V5cywNCg0KDQpJIGFtIGEgbmV3YmVlIG9mIGdmeCBkZXZlbG9wbWVudC4gUmVjZW50
bHksIEkgYW0gcmVzZWFyY2hpbmcgYW1kZ3B1IG9wZW4gc291cmNlIGRyaXZlciwgYW5kIGVu
Y291bnRlciBhIHByb2JsZW0sIGJ1dCBkbyBub3QgZmluZCB0aGUgYW5zd2VyLg0KDQoNCldl
IGtub3cgdGhlIHVzZXIgbWF5YmUgbWFwIGEgZ2VtIGJhY2tpbmcgYnVmZmVyIGZvciByZWFk
aW5nL3dyaXRpbmcgYW5kIGhvbGQgdGhlIG1hcHBpbmcgZm9yIGEgbG9uZyB0ZXJtLiB3aGls
ZSwga2VybmVsIGRyaXZlciB3aWxsIGFsc28gbW92ZXMgdGhlIHVzZXIgbWFwcGVkIGJvIHRv
IG90aGVyIG1lbW9yeSByZWdpb24uIHZyYW0gLSZndDtndHQsIGd0dC0mZ3Q7dnJhbSwgZXZl
biBpdCBtYXkgYmUgc3dhcGVkIG91dCB1bmRlciBPT00gY2FzZS4NCg0KDQpTbywgbXkgcXVl
c3Rpb24gaXMgaG93IGRyaXZlciBwcmV2ZW50cyBrZXJuZWwgdHRtIGZyb20gbW92aW5nIHRo
ZSB1c2VyIG1hcHBlZCBibyB3aGlsZSB1c2VyIGlzIGFjY2Vzc2luZyBpdD8NCg0KDQpUaGFu
a3MgZm9yIHlvdXIgYXR0ZW50aW9uIQ0KDQoNCkxpemhpLg==

------=_NextPart_606B3466_11625A20_4392872D
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNo
YXJzZXQ9R0IxODAzMCI+PGRpdj5IaSBHdXlzLDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
SSBhbSBhIG5ld2JlZSBvZiBnZnggZGV2ZWxvcG1lbnQuIFJlY2VudGx5LCBJIGFtIHJlc2Vh
cmNoaW5nIGFtZGdwdSBvcGVuIHNvdXJjZSBkcml2ZXIsIGFuZCBlbmNvdW50ZXIgYSBwcm9i
bGVtLCBidXQgZG8gbm90IGZpbmQgdGhlIGFuc3dlci48L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PldlIGtub3cgdGhlIHVzZXIgbWF5YmUgbWFwIGEgZ2VtIGJhY2tpbmcgYnVmZmVyIGZv
ciByZWFkaW5nL3dyaXRpbmcgYW5kIGhvbGQgdGhlIG1hcHBpbmcgZm9yIGEgbG9uZyB0ZXJt
LiB3aGlsZSwga2VybmVsIGRyaXZlciB3aWxsIGFsc28gbW92ZXMgdGhlIHVzZXIgbWFwcGVk
IGJvIHRvIG90aGVyIG1lbW9yeSByZWdpb24uIHZyYW0gLSZndDtndHQsIGd0dC0mZ3Q7dnJh
bSwgZXZlbiBpdCBtYXkgYmUgc3dhcGVkIG91dCB1bmRlciBPT00gY2FzZS48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PlNvLCBteSBxdWVzdGlvbiBpcyBob3cgZHJpdmVyIHByZXZlbnRz
IGtlcm5lbCB0dG0gZnJvbSBtb3ZpbmcgdGhlIHVzZXIgbWFwcGVkIGJvIHdoaWxlIHVzZXIg
aXMgYWNjZXNzaW5nIGl0PzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzIGZvciB5
b3VyIGF0dGVudGlvbiE8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkxpemhpLjwvZGl2Pg==

------=_NextPart_606B3466_11625A20_4392872D--




--===============0655195698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0655195698==--



