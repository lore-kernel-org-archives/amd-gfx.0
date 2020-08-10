Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F855C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 12:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2161206E9
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 12:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2161206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A9606E40D;
	Mon, 10 Aug 2020 12:49:04 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id BC6516E40D;
 Mon, 10 Aug 2020 12:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id CCC282A6042;
 Mon, 10 Aug 2020 14:49:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id EcysNtrY1TyO; Mon, 10 Aug 2020 14:49:01 +0200 (CEST)
Received: from thor (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 27D9D2A6016;
 Mon, 10 Aug 2020 14:49:01 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1k57Ea-000Ve5-JI; Mon, 10 Aug 2020 14:49:00 +0200
Subject: Re: [PATCH 6/8] drm/amd/display: Set DC options from modifiers.
To: Daniel Vetter <daniel@ffwll.ch>, harry.wentland@amd.com,
 daniel@fooishbar.org, maraeo@gmail.com
References: <20200804213119.25091-1-bas@basnieuwenhuizen.nl>
 <20200804213119.25091-7-bas@basnieuwenhuizen.nl>
 <20200805073210.GU6419@phenom.ffwll.local>
 <20200810122820.GJ2352366@phenom.ffwll.local>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <49e200cd-3df6-8a11-34f4-d1342a79f75e@daenzer.net>
Date: Mon, 10 Aug 2020 14:49:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810122820.GJ2352366@phenom.ffwll.local>
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wOC0xMCAyOjI4IHAubS4sIERhbmllbCBWZXR0ZXIgd3JvdGU6Cj4KPiBPayBqdXN0
IGxlYXJuZWQgdGhhdCBhbWRncHUgaGF0IHNldC9nZXRfdGlsaW5nLCBzbyBJJ20gdXBncmFkaW5n
IG15IGlkZWEKPiBoZXJlIHRvIGEgdmVyeSBzdHJvbmcgcmVjb21tZW5kYXRpb24sIGkuZS4gcGxl
YXNlIGRvIHRoaXMgZXhjZXB0IGlmCj4gdGhlcmUncyBhbmQgYW1kIGRkeCB3aGljaCBzb21laG93
IHdhbnRzIHRvIGNoYW5nZSB0aWxpbmcgbW9kZSB3aGlsZSBhIGZiCj4gZXhpc3RzLCBhbmQgZXhw
ZWN0cyB0aGlzIHRvIHByb3BhZ2F0ZS4KPiAKPiBJbiBpOTE1IHdlIGV2ZW4gZGlzYWxsb3cgdGhl
IHNldF90aWxpbmcgaW9jdGwgd2l0aCBhbiBlcnJvciBpZiBhbiBmYgo+IGV4aXN0cywganVzdCB0
byBtYWtlIHN1cmUgdXNlcnNwYWNlIGJlaGF2ZXMuIEV2ZW4gaWYgdXNlcnNwYWNlIHVzZXMKPiBz
ZXRfdGlsaW5nLCB0aGlzIHdheSB3ZSBjYW4gYXQgbGVhc3QgZW5mb3JjZSB0aGUgc2FtZSBzZW1h
bnRpY3Mgb2YgImNsaWVudAo+IGNhbid0IHB1bGwgY29tcG9zaXRvciBvdmVyIHRoZSB0YWJsZSB3
aXRoIGEgc2V0X3RpbGluZyBhdCB0aGUgd3JvbmcgdGltZSIKPiBvZiBtb2RpZmllcnMuCgpGV0lX
LCB4Zjg2LXZpZGVvLWFtZGdwdSBkb2Vzbid0IGhhdmUgYW55IGNvZGUgdG8gc2V0IHRoZSB0aWxp
bmcKbWV0YWRhdGEsIG9ubHkgTWVzYSBhbmQgcHJlc3VtYWJseSBBTUQncyBWdWxrYW4vT3BlbkdM
IFVNRHMgZG8uCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFz
dCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
