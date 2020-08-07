Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55F2C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 09:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DB32072D
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 09:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DB32072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C226E98B;
	Fri,  7 Aug 2020 09:10:44 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8DB396E98B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 09:10:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 860042A6042;
 Fri,  7 Aug 2020 11:10:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id AH7A0-iIxqgf; Fri,  7 Aug 2020 11:10:41 +0200 (CEST)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id E00892A6016;
 Fri,  7 Aug 2020 11:10:41 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1k3yOf-0009MT-C4; Fri, 07 Aug 2020 11:10:41 +0200
Subject: Re: [PATCH] drm/amdgpu: make sure userptr ttm is allocated
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20200806125601.1394-1-christian.koenig@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <dcee935f-95a5-d4ad-d09f-be6a0e614df6@daenzer.net>
Date: Fri, 7 Aug 2020 11:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806125601.1394-1-christian.koenig@amd.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wOC0wNiAyOjU2IHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gV2UgbmVl
ZCB0byBhbGxvY2F0ZSB0aGF0IG1hbnVhbGx5IG5vdy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gRml4ZXM6IDJkZGVmMTc2
NzhiYyAoSEVBRCkgZHJtL3R0bTogbWFrZSBUVCBjcmVhdGlvbiBwdXJlbHkgb3B0aW9uYWwgdjMK
PiAtLS0KPiAgLi4uL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgICAg
fCAgMiArLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgICAgICAg
ICB8ICAyICstCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyAgICAg
ICAgIHwgMTcgKysrKysrKysrKystLS0tLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3R0bS5oICAgICAgICAgfCAgNCArKy0tCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTUgaW5z
ZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+IGluZGV4IDkwMTVjN2I3NmQ2MC4uNTVk
MmU4NzBmZGRhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYwo+IEBAIC01NjQsNyArNTY0LDcgQEAgc3RhdGljIGludCBpbml0X3Vz
ZXJfcGFnZXMoc3RydWN0IGtnZF9tZW0gKm1lbSwgdWludDY0X3QgdXNlcl9hZGRyKQo+ICAKPiAg
CW11dGV4X2xvY2soJnByb2Nlc3NfaW5mby0+bG9jayk7Cj4gIAo+IC0JcmV0ID0gYW1kZ3B1X3R0
bV90dF9zZXRfdXNlcnB0cihiby0+dGJvLnR0bSwgdXNlcl9hZGRyLCAwKTsKPiArCXJldCA9IGFt
ZGdwdV90dG1fdHRfc2V0X3VzZXJwdHIoJmJvLT50Ym8sIHVzZXJfYWRkciwgMCk7Cj4gIAlpZiAo
cmV0KSB7Cj4gIAkJcHJfZXJyKCIlczogRmFpbGVkIHRvIHNldCB1c2VycHRyOiAlZFxuIiwgX19m
dW5jX18sIHJldCk7Cj4gIAkJZ290byBvdXQ7CgpJIHN1c3BlY3QgbW9yZSBuZWVkcyB0byBiZSBk
b25lIGZvciBLRkQsIGUuZy4KYW1kZ3B1X2FtZGtmZF9ncHV2bV9hbGxvY19tZW1vcnlfb2ZfZ3B1
IGNhbiBkZXJlZmVyZW5jZQpiby0+dGJvLnR0bSBiZWZvcmUgY2FsbGluZyBpbml0X3VzZXJfcGFn
ZXMsIGFuZCB0aGVyZSBhcmUgbW9yZSB1c2FnZXMgb2YKYm8tPnRiby50dG0gdGhhdCBuZWVkIHRv
IGJlIGF1ZGl0ZWQuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAg
IHwgICAgICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVz
aWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
