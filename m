Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E7FC2D0E4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 17:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4682065D
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 17:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4682065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0233B89A60;
	Mon, 23 Nov 2020 17:12:48 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8857E89A60
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 17:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 7506A2A6016;
 Mon, 23 Nov 2020 18:12:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id MmgFU9aZ2Lup; Mon, 23 Nov 2020 18:12:45 +0100 (CET)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 3F6E72A6045;
 Mon, 23 Nov 2020 18:12:45 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1khFOO-000ZXK-Ez; Mon, 23 Nov 2020 18:12:44 +0100
Subject: Re: [PATCH] drm/amdgpu/dce_virtual: Enable DPM for vf
To: shaoyunl <shaoyun.liu@amd.com>
References: <20201123164048.19583-1-shaoyun.liu@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <8a49a167-f5d0-d120-afa6-f7c16fa564fd@daenzer.net>
Date: Mon, 23 Nov 2020 18:12:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123164048.19583-1-shaoyun.liu@amd.com>
Content-Language: en-CA
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0xMS0yMyA1OjQwIHAubS4sIHNoYW95dW5sIHdyb3RlOgo+ICAgICAgVGhpcyBmdW5j
dGlvbiBhY3R1YWxseSBjb250cm9sIHRoZSB2Ymxhbmsgb24vb2ZmLiBJdCBzaG91bGRuJ3QgYmUg
YnlwYXNzZWQgZm9yIFZGLiBPdGhlcndpc2UgYWxsIHRoZSB2YmxhbmsgYmFzZWQgZmVhdHVyZSBv
biBWRiB3aWxsIG5vdCB3b3JrLgo+IAo+IFNpZ25lZC1vZmYtYnk6IHNoYW95dW5sIDxzaGFveXVu
LmxpdUBhbWQuY29tPgo+IENoYW5nZS1JZDogSTc3YzZmNTdiYjBhZjM5MGI2MWYwMDQ5YzEyYmY0
MjViMTBkNzBkOTEKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92aXJ0
dWFsLmMgfCAzIC0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92aXJ0dWFsLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdmlydHVhbC5jCj4gaW5kZXggYjRkNGI3NjUzOGQy
Li5mZmNjNjRlYzY0NzMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
ZGNlX3ZpcnR1YWwuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92aXJ0
dWFsLmMKPiBAQCAtMTM5LDkgKzEzOSw2IEBAIHN0YXRpYyB2b2lkIGRjZV92aXJ0dWFsX2NydGNf
ZHBtcyhzdHJ1Y3QgZHJtX2NydGMgKmNydGMsIGludCBtb2RlKQo+ICAgCXN0cnVjdCBhbWRncHVf
Y3J0YyAqYW1kZ3B1X2NydGMgPSB0b19hbWRncHVfY3J0YyhjcnRjKTsKPiAgIAl1bnNpZ25lZCB0
eXBlOwo+ICAgCj4gLQlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQo+IC0JCXJldHVybjsKPiAt
Cj4gICAJc3dpdGNoIChtb2RlKSB7Cj4gICAJY2FzZSBEUk1fTU9ERV9EUE1TX09OOgo+ICAgCQlh
bWRncHVfY3J0Yy0+ZW5hYmxlZCA9IHRydWU7Cj4gCgpTdWJqZWN0IHNheXMgRFBNLCBidXQgbG9v
a3MgbGlrZSB0aGlzIGlzIGFib3V0IERQTVM/CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnpl
ciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUg
c29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFgg
ZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
