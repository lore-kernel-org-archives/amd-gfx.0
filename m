Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07761C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 12:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA7C60233
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 12:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA7C60233
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ict.ac.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 227076EC83;
	Wed,  2 Jun 2021 12:44:55 +0000 (UTC)
X-Greylist: delayed 314 seconds by postgrey-1.36 at gabe;
 Wed, 02 Jun 2021 12:44:53 UTC
Received: from cstnet.cn (smtp17.cstnet.cn [159.226.251.17])
 by gabe.freedesktop.org (Postfix) with ESMTP id 676606EC83
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 12:44:53 +0000 (UTC)
Received: by ajax-webmail-APP-09 (Coremail) ; Wed, 2 Jun 2021 20:39:36 +0800
 (GMT+08:00)
X-Originating-IP: [47.241.6.155]
Date: Wed, 2 Jun 2021 20:39:36 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Chen Lei" <chenlei18s@ict.ac.cn>
To: amd-gfx@lists.freedesktop.org
Subject: [BUG] Data race when use PACKET3_DMA_DATA?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn cnic.cn
MIME-Version: 1.0
Message-ID: <30855000.34f9.179ccbc8079.Coremail.chenlei18s@ict.ac.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: swCowAAXk7wIfLdgPEkDAA--.27321W
X-CM-SenderInfo: hfkh0zthlrm2g6lf3hldfou0/1tbiCQcABV02aOr8dQAAsr
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
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
Content-Type: multipart/mixed; boundary="===============2027518716=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2027518716==
Content-Type: multipart/alternative; 
	boundary="----=_Part_46331_1020788071.1622637576312"

------=_Part_46331_1020788071.1622637576312
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGksIEkgbm90aWNlZCB0aGF0IHRoZXJlIGFyZSB0d28gd2F5cyB0byBkbyBETUEgZm9yIGFtZCBn
cHU6IHRoZSBTRE1BIGNvcHkgcGFja2V0IGFuZCB0aGUgUE00IGRtYSBwYWNrZXQuCgpJIGhhZCB0
ZXN0ZWQgdGhlIFBNNCBkbWEgcGFja2V0OiAgUEFDS0VUM19ETUFfREFUQS4gSW4gbW9zdCBvZiB0
aW1lLCBpdCB3b3Jrcy4gCgpCdXQgd2hlbiBJIGxhdW5jaCBhbiBPcGVuQ0wga2VybmVsIGZvbGxv
d2VkIGJ5IGEgaG9zdC10by1ncHUgRE1BIHBhY2tldCwgaXQgc2VlbXMgdGhhdCB0aGUgT3BlbkNM
IGtlcm5lbCByZWFkIHRoZSBuZXcgdmFsdWUgd3JpdHRlbiBieSB0aGUgZm9sbG93aW5nIERNQSBw
YWNrZXQuIAoKQm90aCB0aGUgT3BlbkNMIGtlcm5lbCBhbmQgdGhlIFBNNCBkbWEgcGFja2V0IGFy
ZSBzdWJtaXR0ZWQgdXNpbmcgdGhlIGFtZGdwdV9jc19pb2N0bCwgYW5kIHRoZXkgYXJlIHN1Ym1p
dHRlZCB0byB0aGUgc2FtZSByaW5nLgoKSSB3YXMgbm90IGZhbWlseSB3aXRoIHRoZSBoYXJkd2Fy
ZSBkZXRhaWxzLiBBY2NvcmRpbmcgdG8gbXkgdW5kZXJzdGFuZGluZywgYmVjYXVzZSB0aGUgcmlu
ZyBpcyBGSUZPLCB0aGVyZSBpcyBubyBuZWVkIGZvciBhbnkgZXhwbGljaXQgc3luY2hyb25pemF0
aW9uIGJldHdlZW4gdGhlIE9wZW5DTCBrZXJuZWwgbGF1bmNoIHBhY2tldCBhbmQgdGhlIGRtYSBw
YWNrZXQuIFNvIHRoZSByZXN1bHQgbG9va2VkIHdlaXJkLiBBbmQgd2hlbiBJIGFkZCB0aGUgc3lu
Y2hyb25pemF0aW9uKGkuZS4gYW1kZ3B1X2NzX3dhaXRfaW9jdGwpIGJlZm9yZSB0aGUgZG1hIHBh
Y2tldCwgZXZlcnl0aGluZyBpcyBPSy4KCldhcyBpdCBhIGhhcmR3YXJlIGJ1ZyBvciBkaWQgSSBt
aXNzIHNvbWV0aGluZz8KCiA=
------=_Part_46331_1020788071.1622637576312
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PHAgc3R5bGU9ImZvbnQtZmFtaWx5OkFyaWFsOyI+CglIaSwgSSBub3RpY2VkIHRoYXQgdGhlcmUg
YXJlIHR3byB3YXlzIHRvIGRvIERNQSBmb3IgYW1kIGdwdTogdGhlIFNETUEmbmJzcDtjb3B5IHBh
Y2tldCBhbmQgdGhlIFBNNCBkbWEgcGFja2V0Lgo8L3A+CjxwIHN0eWxlPSJmb250LWZhbWlseTpB
cmlhbDsiPgoJSSBoYWQgdGVzdGVkIHRoZSBQTTQgZG1hIHBhY2tldDombmJzcDsmbmJzcDs8c3Bh
biBzdHlsZT0iZm9udC1mYW1pbHk6QXJpYWw7Ij5QQUNLRVQzX0RNQV9EQVRBLiBJbiBtb3N0IG9m
IHRpbWUsIGl0IHdvcmtzLiZuYnNwOzwvc3Bhbj4KPC9wPgo8cCBzdHlsZT0iZm9udC1mYW1pbHk6
QXJpYWw7Ij4KCUJ1dCB3aGVuIEkgbGF1bmNoIGFuIE9wZW5DTCBrZXJuZWwgZm9sbG93ZWQgYnkg
YSBob3N0LXRvLWdwdSBETUEmbmJzcDtwYWNrZXQsIGl0IHNlZW1zIHRoYXQgdGhlIE9wZW5DTCBr
ZXJuZWwgcmVhZCB0aGUgbmV3IHZhbHVlIHdyaXR0ZW4gYnkgdGhlIGZvbGxvd2luZyBETUEgcGFj
a2V0LiZuYnNwOwo8L3A+CjxwIHN0eWxlPSJmb250LWZhbWlseTpBcmlhbDsiPgoJQm90aCB0aGUg
T3BlbkNMIGtlcm5lbCBhbmQgdGhlIFBNNCBkbWEgcGFja2V0IGFyZSBzdWJtaXR0ZWQgdXNpbmcg
dGhlIGFtZGdwdV9jc19pb2N0bCwgYW5kIHRoZXkgYXJlIHN1Ym1pdHRlZCB0byB0aGUgc2FtZSBy
aW5nLgo8L3A+CjxwIHN0eWxlPSJmb250LWZhbWlseTpBcmlhbDsiPgoJSSB3YXMgbm90IGZhbWls
eSB3aXRoIHRoZSBoYXJkd2FyZSBkZXRhaWxzLiBBY2NvcmRpbmcgdG8gbXkgdW5kZXJzdGFuZGlu
ZywgYmVjYXVzZSB0aGUgcmluZyBpcyBGSUZPLCB0aGVyZSBpcyBubyZuYnNwO25lZWQgZm9yIGFu
eSBleHBsaWNpdCBzeW5jaHJvbml6YXRpb24gYmV0d2VlbiB0aGUgT3BlbkNMIGtlcm5lbCBsYXVu
Y2ggcGFja2V0IGFuZCB0aGUgZG1hIHBhY2tldC4gU28gdGhlIHJlc3VsdCBsb29rZWQgd2VpcmQu
IEFuZCB3aGVuIEkgYWRkIHRoZSZuYnNwO3N5bmNocm9uaXphdGlvbihpLmUuJm5ic3A7YW1kZ3B1
X2NzX3dhaXRfaW9jdGwpJm5ic3A7YmVmb3JlJm5ic3A7dGhlIGRtYSBwYWNrZXQsIGV2ZXJ5dGhp
bmcgaXMgT0suCjwvcD4KPHAgc3R5bGU9ImZvbnQtZmFtaWx5OkFyaWFsOyI+CglXYXMgaXQgYSBo
YXJkd2FyZSBidWcgb3IgZGlkIEkgbWlzcyBzb21ldGhpbmc/CjwvcD4KPHAgc3R5bGU9ImZvbnQt
ZmFtaWx5OkFyaWFsOyI+CgkmbmJzcDsKPC9wPg==
------=_Part_46331_1020788071.1622637576312--


--===============2027518716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2027518716==--

