Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059B3C2BB55
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 14:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902D02063A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 14:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902D02063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D4096E1B6;
	Thu, 16 Apr 2020 14:18:25 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 207E16E1B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 14:18:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 444862A6042;
 Thu, 16 Apr 2020 16:18:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 9tqGSMXME8q9; Thu, 16 Apr 2020 16:18:22 +0200 (CEST)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch
 [83.76.80.252])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 4EB0D2A6016;
 Thu, 16 Apr 2020 16:18:22 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.93)
 (envelope-from <michel@daenzer.net>)
 id 1jP5LR-0001aV-Jg; Thu, 16 Apr 2020 16:18:21 +0200
Subject: Re: [PATCH] drm/amdgpu: change SH MEM alignment mode for gfx10
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Gao, Likun" <Likun.Gao@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, Pierre-Eric Pelloux-Prayer <pelloux@gmail.com>
References: <1585909202-1350-1-git-send-email-likun.gao@amd.com>
 <58b63f21-69e7-abd0-8d49-6699e88d172a@daenzer.net>
 <MN2PR12MB44886C87CA46D18FBC5F2F58F7D80@MN2PR12MB4488.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <60cf8087-9480-ff01-cb64-b2be099e73fe@daenzer.net>
Date: Thu, 16 Apr 2020 16:18:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB44886C87CA46D18FBC5F2F58F7D80@MN2PR12MB4488.namprd12.prod.outlook.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wNC0xNiAzOjI1IHAubS4sIERldWNoZXIsIEFsZXhhbmRlciB3cm90ZToKPiBbQU1E
IE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4gCj4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNl
c0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZgo+PiBNaWNoZWwgRMOkbnplcgo+
PiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTYsIDIwMjAgNTo1NyBBTQo+PiBUbzogR2FvLCBMaWt1
biA8TGlrdW4uR2FvQGFtZC5jb20+OyBNYXJlayBPbMWhw6FrIDxtYXJhZW9AZ21haWwuY29tPjsK
Pj4gUGllcnJlLUVyaWMgUGVsbG91eC1QcmF5ZXIgPHBlbGxvdXhAZ21haWwuY29tPgo+PiBDYzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBIYXdraW5nCj4+IDxIYXdraW5n
LlpoYW5nQGFtZC5jb20+Cj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGNoYW5n
ZSBTSCBNRU0gYWxpZ25tZW50IG1vZGUgZm9yCj4+IGdmeDEwCj4+Cj4+IE9uIDIwMjAtMDQtMDMg
MTI6MjAgcC5tLiwgTGlrdW4gR2FvIHdyb3RlOgo+Pj4gRnJvbTogTGlrdW4gR2FvIDxMaWt1bi5H
YW9AYW1kLmNvbT4KPj4+Cj4+PiBDaGFuZ2UgU0hfTUVNX0NPTkZJRyBBbGlnbm1lbnQgbW9kZSB0
byBBdXRvbWF0aWMsIGFzOgo+Pj4gMSlPR0wgZm5fYW1kX2NvbXB1dGVfc2hhZGVyIHdpbGwgZmFp
bGVkIHdpdGggdW5hbGlnbmVkIG1vZGUuCj4+PiAyKVRoZSBkZWZhdWx0IGFsaWdubWVudCBtb2Rl
IHdhcyBkZWZpbmVkIHRvIGF1dG9tYXRpYyBvbiBnZngxMAo+Pj4gc3BlY2lmaWNhdGlvbi4KPj4+
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBMaWt1biBHYW8gPExpa3VuLkdhb0BhbWQuY29tPgo+Pj4gLS0t
Cj4+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAyICstCj4+PiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4+PiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4+PiBpbmRleCA1YTY3MzA2Li5k
OGYwYzBkIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Yx
MF8wLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4+
PiBAQCAtMjc5LDcgKzI3OSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc29jMTVfcmVnX2dvbGRl
bgo+Pj4gZ29sZGVuX3NldHRpbmdzX2djXzEwXzFfMl9udjEyW10gPQo+Pj4KPj4+ICAjZGVmaW5l
IERFRkFVTFRfU0hfTUVNX0NPTkZJRyBcCj4+PiAgCSgoU0hfTUVNX0FERFJFU1NfTU9ERV82NCA8
PAo+PiBTSF9NRU1fQ09ORklHX19BRERSRVNTX01PREVfX1NISUZUKSB8IFwKPj4+IC0JIChTSF9N
RU1fQUxJR05NRU5UX01PREVfVU5BTElHTkVEIDw8Cj4+IFNIX01FTV9DT05GSUdfX0FMSUdOTUVO
VF9NT0RFX19TSElGVCkgfCBcCj4+PiArCSAoU0hfTUVNX0FMSUdOTUVOVF9NT0RFX0RXT1JEIDw8
Cj4+PiArU0hfTUVNX0NPTkZJR19fQUxJR05NRU5UX01PREVfX1NISUZUKSB8IFwKPj4+ICAJIChT
SF9NRU1fUkVUUllfTU9ERV9BTEwgPDwKPj4gU0hfTUVNX0NPTkZJR19fUkVUUllfTU9ERV9fU0hJ
RlQpIHwgXAo+Pj4gIAkgKDMgPDwgU0hfTUVNX0NPTkZJR19fSU5JVElBTF9JTlNUX1BSRUZFVENI
X19TSElGVCkpCj4+Pgo+Pj4KPj4KPj4gSSBiaXNlY3RlZCBhIGJ1bmNoIG9mIHBpZ2xpdCByZWdy
ZXNzaW9ucyAobW9zdGx5IGhhbGYtZmxvYXQgcmVsYXRlZCwgZS5nLiBkcmF3LQo+PiB2ZXJ0aWNl
cy1oYWxmLWZsb2F0X2dsZXMyKSB3aXRoIHJhZGVvbnNpIG9uIE5hdmkgMTAgdG8gdGhpcyBjaGFu
Z2UuCj4+Cj4+IERvZXMgcmFkZW9uc2kvTExWTSBuZWVkIGNvcnJlc3BvbmRpbmcgY2hhbmdlcz8K
PiAKPiBUaGlzIGNoYW5nZSB3YXMgcmV2ZXJ0ZWQuICBUaGUgcHJvYmxlbSB3YXMgaW4gdGhlIE9y
Y2EgT3BlbkdMIHNoYWRlciBjb21waWxlci4KCkFoLCBJIHNlZSB0aGUgcmV2ZXJ0IG5vdywgdGhh
bmtzLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAg
ICAgICAgICAgaHR0cHM6Ly9yZWRoYXQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAg
ICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
