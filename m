Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8FDC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 08:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3356D20738
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 08:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3356D20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D1F6E984;
	Tue, 23 Jun 2020 08:22:40 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6CD866E984
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 08:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 61E342A6042;
 Tue, 23 Jun 2020 10:22:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 4SoHU7iQL0WY; Tue, 23 Jun 2020 10:22:36 +0200 (CEST)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 9A7192A6016;
 Tue, 23 Jun 2020 10:22:36 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1jneCR-000gnh-Sr; Tue, 23 Jun 2020 10:22:35 +0200
Subject: Re: Renoir kernel warnings and crashes with external monitors (DP mst)
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <5142c866-fecd-b344-f650-70930fc4542c@gmx.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <c3bf60a1-852d-de42-b8bc-e439677dd61f@daenzer.net>
Date: Tue, 23 Jun 2020 10:22:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5142c866-fecd-b344-f650-70930fc4542c@gmx.com>
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

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQpIYXNoOiBTSEExCgpPbiAyMDIwLTA2
LTIzIDI6MjMgYS5tLiwgUXUgV2VucnVvIHdyb3RlOgo+IEhpIGd1eXMsCj4KPiBGaXJzdGx5IHRo
YW5rcyBmb3IgdGhlIGF3ZXNvbWUgcmVub2lyIENQVXMuCj4KPiBIb3dldmVyIGl0IGxvb2tzIGxp
a2UgdGhlcmUgYXJlIHN0aWxsIHNvbWUgYnVncyBpbiB0aGUgTGludXgKPiBzdXBwb3J0LCBlc3Bl
Y2lhbGx5IHdpdGggZXh0ZXJuYWwgbW9uaXRvcnMuCj4KPiBNeSBzZXR1cDogLSBMYXB0b3A6IExl
bm92byBJZGVhUGFkIFM1NDAgMTNBUkUgKE9yLCBYaWFveGluIFBybyAxMwo+IGluIENoaW5lc2Ug
bWFya2V0KSA0ODAwVSBDUFUsIHdpdGggNS43LjQgQXJjaCBrZXJuZWwuIChBbHNvIHRyaWVkCj4g
NS44LXJjIGtlcm5lbHMsIGV2ZW4gbW9yZSBjcmFzaGVzKSBUaGUgZURQIGRpc3BsYXkgaXMgMjU2
MHgxNjAwCj4gbmF0aXZlbHksIGJ1dCB0byBjb29wZXJhdGUgd2l0aCBleHRlcm5hbCBtb25pdG9y
cywgaXQncyBzZXQgdG8KPiAxOTIweDEyMDAuIEFuZCB1bmRlciBteSBkYWlseSB1c2FnZSwgdGhl
IGxpZCBpcyBjbG9zZWQsIHRodXMgdGhlCj4gZURQIGRpc3BsYXkgc2hvdWxkbid0IGJlIGludm9s
dmVkLgo+Cj4gLSBUd28gZXh0ZXJuYWwgbW9uaXRvcnMgY29ubmVjdGVkIHVzaW5nIFVTQi1jIGRv
Y2sgVGhlIGRvY2sgaXMgSFAKPiB1c2ItYyBkb2NrIEc0LCB3aGljaCB1c2VzIERQIGFsdCBtb2Rl
IE1TVCBmb3IgZXh0ZXJuYWwgZGlzcGxheXMuIFNvCj4gbm90IERpc3BsYXlMaW5rIGdhcmJhZ2Us
IGFuZCBhbGwgbW9uaXRvcnMgYXJlIGhhbmRsZWQgYnkgVmVnYQo+IGludGVybmFsIEdQVS4KPgo+
IEJvdGggZXh0ZXJuYWwgZGlzcGxheXMgYXJlIDEwODBQIDYwaHosIHNvIGRlZmluaXRlbHkgaW5z
aWRlIHRoZQo+IHNwZWMgZm9yIERQIDEuMi4KPgo+IC0gWDExIGVudmlyb25tZW50IHhmODYtdmlk
ZW8tYW1kZ3B1LCBhbG9uZyB3aXRoIG1lc2Egc3RhY2suCj4KPiBXaXRoIHN1Y2ggc2V0dXAsIHRo
ZSBrZXJuZWwgYm9vdHMgd2l0aCB3YXJuaW5nIGFscmVhZHkgcmVsYXRlZCB0bwo+IERQIE1TVDog
aHR0cHM6Ly9wYXN0ZS5vcGVuc3VzZS5vcmcvNTQyOTM5NjcKClNlZSBodHRwczovL2dpdGxhYi5m
cmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8xMTA4IC4KCgotIC0tIApFYXJ0aGxpbmcg
TWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cHM6Ly9yZWRo
YXQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAg
ICBNZXNhIGFuZCBYIGRldmVsb3BlcgotLS0tLUJFR0lOIFBHUCBTSUdOQVRVUkUtLS0tLQoKaUYw
RUFSRUNBQjBXSVFTd242ODF2cEZGSVpnSlVSUmFnYStPYXR1eUFBVUNYdkc3eFFBS0NSQmFnYStP
YXR1eQpBQjEvQUo5VDVYMS9qR0NFSEgrckcrbzYyVmxsWDhZeXlRQ2VOUzVEdzFhaDJRb3dQdENa
UGhQK3FQdVgvVjQ9Cj1LWnBhCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
