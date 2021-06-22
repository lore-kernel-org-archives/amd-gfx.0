Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21499C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 09:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD3561042
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 09:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD3561042
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A5B56E44D;
	Tue, 22 Jun 2021 09:19:13 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 58A596E44D
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 09:19:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 6156B20201D;
 Tue, 22 Jun 2021 11:19:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id rf-OjfifDvma; Tue, 22 Jun 2021 11:19:11 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 0E66120201C;
 Tue, 22 Jun 2021 11:19:11 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1lvcYn-000ce8-Sk; Tue, 22 Jun 2021 11:19:09 +0200
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
References: <20210621070040.494336-1-evan.quan@amd.com>
 <c4550aab-23b3-fcf9-5fc1-7c129743adb3@amd.com>
 <DM6PR12MB2619DA78289C9BC237FF772AE4099@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CH0PR12MB5348A92078FAAEB0F132A78D97099@CH0PR12MB5348.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH V3 1/7] drm/amdgpu: correct tcp harvest setting
Message-ID: <7486e471-4ff9-bfe1-947a-d726b2eadc2d@daenzer.net>
Date: Tue, 22 Jun 2021 11:19:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CH0PR12MB5348A92078FAAEB0F132A78D97099@CH0PR12MB5348.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNi0yMiA4OjA4IGEubS4sIExhemFyLCBMaWpvIHdyb3RlOgo+IFtQdWJsaWNdCj4g
Cj4gQUZBSUssIHRoYXQgZXhwcmVzc2lvbiBpcyBsZWdhbCAoc29tZSBjb2RlIGFuYWx5emVyIG1h
eSB3YXJuIG9uIHZhbHVlIG9mIDQqbWF4X3dncF9wZXJfc2gpOyBzaW1pbGFyIGtpbmQgaXMgdXNl
ZCBpbiByb3RhdGUgc2hpZnQgb3BlcmF0aW9ucy4KClRoZSBkZWZhdWx0IHR5cGUgZm9yIGNvbnN0
YW50cyBpbiBDIGlzIGludCwgc28gMHhmZmZmZmZmZiBpcyBhIDMyLWJpdCBzaWduZWQgaW50ZWdl
ci4KClRoZSBDOTkgc3BlY2lmaWNhdGlvbiBsaXN0cyB0aGlzIHVuZGVyIEouMiBVbmRlZmluZWQg
YmVoYXZpb3I6CgrigJQgQW4gZXhwcmVzc2lvbiBoYXZpbmcgc2lnbmVkIHByb21vdGVkIHR5cGUg
aXMgbGVmdC1zaGlmdGVkIGFuZCBlaXRoZXIgdGhlIHZhbHVlIG9mIHRoZQogZXhwcmVzc2lvbiBp
cyBuZWdhdGl2ZSBvciB0aGUgcmVzdWx0IG9mIHNoaWZ0aW5nIHdvdWxkIGJlIG5vdCBiZSByZXBy
ZXNlbnRhYmxlIGluIHRoZQogcHJvbW90ZWQgdHlwZSAoNi41LjcpLgoKU28gaXQgd291bGQgYmUg
c2FmZXIgdG8gbWFrZSBpdCB1bnNpZ25lZDogMHhmZmZmZmZmZnUgKG9yIGp1c3QgfjB1KS4KCgo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogUXVhbiwgRXZhbiA8RXZhbi5RdWFu
QGFtZC5jb20+IAo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjIsIDIwMjEgNzo1NiBBTQo+IFRvOiBM
YXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
Pgo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjMgMS83XSBkcm0vYW1kZ3B1OiBjb3JyZWN0IHRjcCBo
YXJ2ZXN0IHNldHRpbmcKPiAKPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQo+IAo+IFRoYW5rcyBM
aWpvLgo+IEhvd2V2ZXIsIEknbSBub3QgcXVpdGUgc3VyZSB3aGV0aGVyICIgMHhmZmZmZmZmZiA8
PCAoNCAqIG1heF93Z3BfcGVyX3NoKTsiIGlzIGEgdmFsaWQgZXhwcmVzc2lvbiBzaW5jZSBpdCBr
aW5kIG9mIHRyaWdnZXJzIHNvbWUgb3ZlcmZsb3cuCj4gQ2FuIHRoYXQgd29yayBmb3Igbm9uLXg4
NiBwbGF0Zm9ybSBvciBldmVuIHdvcmsgcmVsaWFibHkgZm9yIHg4NiBwbGF0Zm9ybT8KCgoKLS0g
CkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBo
dHRwczovL3JlZGhhdC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8
ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
