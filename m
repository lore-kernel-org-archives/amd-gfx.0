Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194FBC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 09:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0852964FD8
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 09:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0852964FD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5119D6EB3E;
	Thu, 11 Mar 2021 09:05:28 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 92CB36EB3E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 09:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 8FB872A6042;
 Thu, 11 Mar 2021 10:05:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 5FlGjk0S3hO0; Thu, 11 Mar 2021 10:05:26 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 0EBB02A6016;
 Thu, 11 Mar 2021 10:05:25 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1lKHG0-000t7x-W3; Thu, 11 Mar 2021 10:05:25 +0100
To: Simon Ser <contact@emersion.fr>
References: <20210310145019.2877-1-contact@emersion.fr>
 <a4fe57bf-33f2-43f5-0170-2135c6a919df@daenzer.net>
 <mg9Sasg2hDaWhKchS7MJOG1GxFgyK7EjamocMRigAuCcwDNJhI5DGVLItXCxyKqNkEl8E2kgsnijtkSMI_YMTe8_Rjmn0Sh8PB32YNTfH1c=@emersion.fr>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH v2 0/5] amd/display: improve atomic cursor checks
Message-ID: <07f53c21-920d-7494-8195-c678216610a4@daenzer.net>
Date: Thu, 11 Mar 2021 10:05:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <mg9Sasg2hDaWhKchS7MJOG1GxFgyK7EjamocMRigAuCcwDNJhI5DGVLItXCxyKqNkEl8E2kgsnijtkSMI_YMTe8_Rjmn0Sh8PB32YNTfH1c=@emersion.fr>
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

T24gMjAyMS0wMy0xMSA5OjU3IGEubS4sIFNpbW9uIFNlciB3cm90ZToKPiBPbiBXZWRuZXNkYXks
IE1hcmNoIDEwdGgsIDIwMjEgYXQgNjoyMCBQTSwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVu
emVyLm5ldD4gd3JvdGU6Cj4+IE9uIDIwMjEtMDMtMTAgMzo1MCBwLm0uLCBTaW1vbiBTZXIgd3Jv
dGU6Cj4+Cj4+PiBDaGFuZ2VzIGluIHYyOiBkcm9wICJhbWQvZGlzcGxheTogZmFpbCBvbiBjdXJz
b3IgcGxhbmUgd2l0aG91dCBhbgo+Pj4gdW5kZXJseWluZyBwbGFuZSIuIFRoaXMgcmV0YWlucyB0
aGUgY3VycmVudCBiZWhhdmlvciBpbnN0ZWFkLgo+Pgo+PiBQYXRjaGVzIDIgJiAzIChhbmQgcG9z
c2libHkgND8gbm90IHN1cmUpIHdvdWxkIHN0aWxsIGNhdXNlIHRoZSBzYW1lCj4+IGlzc3VlIGlu
IHRoZSBzY2VuYXJpbyBkaXNjdXNzZWQgaW4gZm9sbG93LXVwcyB0byB0aGUgZHJvcHBlZCBwYXRj
aAo+PiAoZGlzYWJsaW5nIGFuIEFSR0Igb3ZlcmxheSBwbGFuZSB3aXRoIGEgWVVWIHByaW1hcnkg
cGxhbmUgYW5kIHRoZQo+PiBjdXJzb3IgcGxhbmUgZW5hYmxlZCksIHdvdWxkbid0IHRoZXk/Cj4g
Cj4gWWVzLCBidXQgdGhhdCBzaG91bGRuJ3QgYmUgdG9vIG11Y2ggb2YgYW4gaXNzdWUgaW4gcHJh
Y3RpY2UsIHNpbmNlCj4gdXNlci1zcGFjZSB1c2luZyBZVVYgYW5kIG92ZXJsYXlzIGFsc28gdXNl
cyBhdG9taWMuIERyb3BwaW5nIHRoZSBwYXRjaAo+IGF2b2lkcyB0aGUgaXNzdWUgdG8gYmUgdHJp
Z2dlcmVkIHdpdGggbGVnYWN5IHVzZXItc3BhY2UuCgpUaGUgbGFzdCBzY2VuYXJpbyBkaXNjdXNz
ZWQgaXMgYWJvdXQgYXRvbWljIEtNUyB1c2VyIHNwYWNlIHRyeWluZyB0byBkaXNhYmxlIHRoZSBv
dmVybGF5IHBsYW5lLiBEYW5pZWwgc2VlbXMgdG8gYWdyZWUgdGhhdCBub3QgYmVpbmcgYWJsZSB0
byBkaXNhYmxlIGFuIG92ZXJsYXkgcGxhbmUgaXMgdG9vIHN1cnByaXNpbmcuCgoKLS0gCkVhcnRo
bGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwczov
L3JlZGhhdC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAg
ICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
