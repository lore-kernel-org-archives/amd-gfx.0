Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49D9C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 09:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B7164EE3
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 09:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B7164EE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F10CF89F01;
	Wed,  3 Mar 2021 09:10:07 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1131B89F01
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 09:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id AE5CD2A6045;
 Wed,  3 Mar 2021 10:10:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id wtObfDFQbNcx; Wed,  3 Mar 2021 10:10:04 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 668342A6042;
 Wed,  3 Mar 2021 10:10:04 +0100 (CET)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1lHNWA-001epF-G6; Wed, 03 Mar 2021 10:10:03 +0100
To: Hans de Goede <hdegoede@redhat.com>, Alex Deucher
 <alexdeucher@gmail.com>, Harry Wentland <hwentlan@amd.com>,
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
References: <248f32a0-f26b-0fcc-5321-148002373ef4@redhat.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: lots of bugreports about a kernel-backtrace starting with
 amdgpu_dm_backlight_update_status
Message-ID: <d04653fc-b451-a60d-3729-7fdc086d1a83@daenzer.net>
Date: Wed, 3 Mar 2021 10:10:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <248f32a0-f26b-0fcc-5321-148002373ef4@redhat.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMi0xNyAzOjU2IHAubS4sIEhhbnMgZGUgR29lZGUgd3JvdGU6Cj4gSGkgQWxsLAo+
IAo+IEZlZG9yYSBoYXMgYSAob3B0LWluKSBzeXN0ZW0gdG8gYXV0b21hdGljYWxseSBjb2xsZWN0
IGJhY2t0cmFjZXMgZnJvbQo+IHNvZnR3YXJlIGNyYXNoaW5nIG9uIHVzZXJzIHN5c3RlbXMuCj4g
Cj4gVGhpcyBpbmNsdWRlcyBjb2xsZWN0aW5nIGtlcm5lbCBiYWNrdHJhY2VzIChpbmNsdWRpbmcg
b25jZSB0cmlnZ2VyZWQgYnkKPiBXQVJOIG1hY3Jvcykgd2hpbGUgbG9va2luZyBhIHRoZSB0b3Ag
MTAgb2YgdGhlIG1vc3QgcmVwb3J0ZWQgYmFja3RyYWNlCj4gZHVyaW5nIHRoZSBsYXN0IDIgd2Vl
a3MgcmVwb3J0IGZyb20gQUJSVDoKPiBodHRwczovL3JldHJhY2UuZmVkb3JhcHJvamVjdC5vcmcv
ZmFmL3Byb2JsZW1zLwo+IAo+IEkgbm90aWNlZCB0aGUgZm9sbG93aW5nIGJhY2t0cmFjZToKPiBo
dHRwczovL3JldHJhY2UuZmVkb3JhcHJvamVjdC5vcmcvZmFmL3Byb2JsZW1zLzEzOTA0Lwo+IAo+
IHdoaWNoIGhhcyBiZWVuIHJlcG9ydGVkIDE2MDAwMCB0aW1lcyBieSBGZWRvcmEgdXNlcnMgd2hv
IGhhdmUgb3B0ZWQtaW4KPiBkdXJpbmcgdGhlIGxhc3QgMTQgZGF5cy4KCkdpdmVuIHRoZXNlIG51
bWJlcnMsIHRoZSBsYWNrIG9mIHJlc3BvbnNlIGlzIHB1enpsaW5nLiBBZGRpbmcgc29tZSBEQyBm
b2xrcywgaW4gY2FzZSB0aGV5IG1pc3NlZCBpdCBiZWZvcmUuCgoKPiBUaGUgQUJSVCBzeW1ib2wg
cmVzb2x1dGlvbiBwb2ludHMgdG8gYW1kZ3B1X2RtX2JhY2tsaWdodF91cGRhdGVfc3RhdHVzOgo+
IAo+IDEgCQo+IGFtZGdwdV9kbV9iYWNrbGlnaHRfdXBkYXRlX3N0YXR1cwo+IAlhbWRncHUgCQkw
eGI0Cj4gMiAJCj4gYW1kZ3B1X2RtX2JhY2tsaWdodF91cGRhdGVfc3RhdHVzCj4gCWFtZGdwdSAJ
CTB4YjQKPiAzIAkKPiBhbWRncHVfZG1fYmFja2xpZ2h0X3VwZGF0ZV9zdGF0dXMKPiAJYW1kZ3B1
IAkJMHhiNAo+IDQgCQo+IGFtZGdwdV9kbV9iYWNrbGlnaHRfdXBkYXRlX3N0YXR1cwo+IAlhbWRn
cHUgCQkweGI0Cj4gNSAJCj4gPyBhbWRncHVfZG1fYmFja2xpZ2h0X3VwZGF0ZV9zdGF0dXMKPiAJ
YW1kZ3B1IAkJMHhiNAo+IDYgCQo+IGFtZGdwdV9kbV9iYWNrbGlnaHRfdXBkYXRlX3N0YXR1cwo+
IAlhbWRncHUgCQkweGI0Cj4gNyAJCj4gYW1kZ3B1X2RtX2JhY2tsaWdodF91cGRhdGVfc3RhdHVz
Cj4gCWFtZGdwdSAJCTB4YjQKPiA4IAkKPiBkcm1fc2NoZWRfam9iX3RpbWVkb3V0Cj4gCWdwdV9z
Y2hlZCAJZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgCTI4OQo+IAo+IAo+
IEJ1dCB0aGUgYmFja3RyYWNlIGZyb20gZG1lc2cgcG9pbnRzIHRvIHNvbWV0aGluZyBlbHNlOgo+
IAo+IFJJUDogMDAxMDpkY24xMF9nZXRfZGlnX2Zyb250ZW5kKzB4NzYvMHhiMCBbYW1kZ3B1XQo+
IENvZGU6IDM5IDQ0IDg5IGMwIDQ4IDgzIGM0IDA4IGMzIDQxIGI4IDA1IDAwIDAwIDAwIDgzIGY4
IDIwIDc0IGVkIDQxIGI4IDA2IDAwIDAwIDAwIDgzIGY4IDQwIDc0IGUyIDQxIGI4IDA0IDAwIDAw
IDAwIDgzIGY4IDEwIDc0IGQ3IDwwZj4gMGIgNDEgYjggZmYgZmYgZmYgZmYgNDggODMgYzQgMDgg
NDQgODkgYzAgYzMgNDUgMzEgYzAgODMgZjggMDEKPiBSU1A6IDAwMTg6ZmZmZmEzNzZjMmRmZmNh
OCBFRkxBR1M6IDAwMjEwMjk3Cj4gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogZmZmZjhlY2Y2
Yjc2MDAwMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDgKPiBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJ
OiAwMDAwMDAwMDAwMDA1OTZmIFJESTogZmZmZjhlY2Y2ZGIyMDAwMAo+IFJCUDogZmZmZjhlY2Y2
YTE4NzAwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiBmZmZmOGVjZjZmODhmYzAwCj4gUjEw
OiAwMDAwMDAwMDAwMDAwMDAxIFIxMTogMDAwMDAwMDAwMDAwMDAwNiBSMTI6IGZmZmY4ZWNmNzI3
ZWMyMDAKPiBSMTM6IDAwMDAwMDAwMDAwMDAwMDYgUjE0OiBmZmZmOGVjZjZmOTgyODAwIFIxNTog
ZmZmZjhlY2Y2ZTc0OTIwMAo+IEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOGVj
ZjdlOWMwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKPiBDUzogIDAwMTAgRFM6IDAw
MDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCj4gQ1IyOiAwMDAwN2ZiNWZiNGE4MDAw
IENSMzogMDAwMDAwMDM1NjQ0NjAwMCBDUjQ6IDAwMDAwMDAwMDAzNTA2ZTAKPiBDYWxsIFRyYWNl
Ogo+ICAgZGNuMTBfaW5pdF9odysweDZlZC8weDkzMCBbYW1kZ3B1XQo+ICAgZGNfc2V0X3Bvd2Vy
X3N0YXRlKzB4ZjUvMHgxNDAgW2FtZGdwdV0KPiAgIGRtX3Jlc3VtZSsweDMyOC8weDUwMCBbYW1k
Z3B1XQo+ICAgYW1kZ3B1X2RldmljZV9pcF9yZXN1bWVfcGhhc2UyKzB4NTIvMHhiMCBbYW1kZ3B1
XQo+ICAgPyBhbWRncHVfZGV2aWNlX2Z3X2xvYWRpbmcrMHg5Zi8weDExMCBbYW1kZ3B1XQo+ICAg
YW1kZ3B1X2RldmljZV9ncHVfcmVjb3Zlci5jb2xkKzB4OGMxLzB4ZjYyIFthbWRncHVdCj4gICBh
bWRncHVfam9iX3RpbWVkb3V0KzB4MTFjLzB4MTQwIFthbWRncHVdCj4gICBkcm1fc2NoZWRfam9i
X3RpbWVkb3V0KzB4NzIvMHhmMCBbZ3B1X3NjaGVkXQo+ICAgcHJvY2Vzc19vbmVfd29yaysweDFi
NC8weDM3MAo+IAo+IAo+IFRoZXJlIGFsc28gaXMgdGhpcyBidWd6aWxsYSBhYm91dCB0aGlzOgo+
IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTkyOTc0Ngo+IGZy
b20gdG9kYXkKClRoaXMgb25lIHNlZW1zIHRvIGhhdmUgcmVzdHJpY3RlZCBhY2Nlc3MuCgoKPiBB
bmQgYSB3aG9sZSBidW5jaCBvZiBvdGhlcnM6Cj4gaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29t
L2J1Z2xpc3QuY2dpP3F1aWNrc2VhcmNoPWFtZGdwdV9kbV9iYWNrbGlnaHRfdXBkYXRlX3N0YXR1
cwoKaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMTMzNyBs
b29rcyByZWxhdGVkIGFzIHdlbGwuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwczovL3JlZGhhdC5jb20KTGlicmUgc29mdHdh
cmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxv
cGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
