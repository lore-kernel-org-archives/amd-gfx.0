Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8732EC44501
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jul 2026 15:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE70D10E4B3;
	Sun, 12 Jul 2026 15:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oflebbe.de header.i=@oflebbe.de header.b="V3il9MwM";
	dkim=permerror (0-bit key) header.d=oflebbe.de header.i=@oflebbe.de header.b="IDb4RAJW";
	dkim-atps=neutral
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4752310E1FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 21:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783718460; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=QAuHKCtqBhzeP7YwEDC69+VWJzL03RT1/ciKwGjT7gM678V4aeOflq0qnZZ5Nz2eAI
 XUPzlB2zHZAdlI8LSxjHOSPlfkRQgtONqEpoe0qWNWkiA1fw+Q2uGVQxIgutvB9rX/s9
 rsNTINtXPRz7d9lw0hK7kw/SZ5M2epRdLYAPZCFU9FhzHLp0S3RSQPYB5bnAL8dveLU4
 57goM6LFnt2TRwE7XGzMgNubCYsNr/024aifxsam2OMMhp+HYWsv2/UAjB1KQnpzBd7S
 rqsK+nEVlEk2wU/prNs+FBxyZTzuEbOV8oK+/bH5rERk5SW/rj03WEK+C8vXzWyUXmMc
 Vy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783718460;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=R0ypggQT40+65zFCKxytZS+WJ8+IvjWTAbIyi+IgYII=;
 b=B7Zc5UH8mk+j1yESknCdruk7yj/pViEOSU14wyEgKI1qTff68ubJEjtLEhhGqPCrSy
 fvYM9CNLlkx3fmjBk9AOjhzDA7BYL6sMVorUnkAlF5rMpGSKXH6kxf0LB+fXVn0eF6qv
 OIq9tdvQeVS+0lbUGVmimTP4TqPfZDboz/Vqj46quv82xwLeQzR8MDRaxJEw6700ukls
 bl8UNphOqtCwKpomq08hgpjC5xNYjO7TYQ/DEJ6aswd06V6I0vCQaXtbNQaKx+znqo8K
 4TgY7qHNpa0jakgQL1edIwcjjcgkeNTMc1wGk/uPsdPmn+FkMidOXBqIzIS8hMZG3qkJ
 MOLw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783718460;
 s=strato-dkim-0002; d=oflebbe.de;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=R0ypggQT40+65zFCKxytZS+WJ8+IvjWTAbIyi+IgYII=;
 b=V3il9MwMgTVeLzed6FXuC5zCuwdP8a/0aPtEt6T+L36lPpIwwxmxVwYpjV13r6CSiB
 eIVKm+v3FId0Czx7kuQQjSl8bBFQDeODyc4LjLn5nZ67abmgqb0BydCdGF9inC4FUzT/
 BZmpgVSKiyUFTAU4HhClfoQNiTv2I4OTF3pHgYPkrxqo5VpG4l1kaduMiM7tTpLzD9ez
 ayRMfHhAapQXE5wgjtz4swtPxDVl1zdDpZQoO1YAbQ/pBpFfbrLA4Dc29jaHj0fdwcLr
 uuhsBMthgAme23KlA998PIVTaYMXpP2zVCL46/kwjGMO+nlbSAhytQUXBXyAesc7dOn/
 sgGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783718460;
 s=strato-dkim-0003; d=oflebbe.de;
 h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=R0ypggQT40+65zFCKxytZS+WJ8+IvjWTAbIyi+IgYII=;
 b=IDb4RAJWnUYZJAOljgAcFIED/pisaQveTddZTcKNhNaZYEeJiKFON9nnu/KkbKRnJj
 +1mIt4OJ7NzhPdcB/NDQ==
X-RZG-AUTH: ":I2okekakfv3mKNs8YSFayssNXg+upC3+tYLZLO1stc+1hkqAuvcOy60kdExcbzifdXzIeGdgJhnaLtDU61AQehJ+3kk="
Received: from [IPV6:2003:df:7718:c300:2d64:6d3a:ca77:6150]
 by smtp.strato.de (RZmta 55.5.6 AUTH) with ESMTPSA id g49e0326ALKxqR3
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 10 Jul 2026 23:20:59 +0200 (CEST)
Content-Type: multipart/mixed; boundary="------------4zQrgMUDDuD6DLmJbGkkMrct"
Message-ID: <61500d45-0a67-4d36-b43e-f5ad1811c7fa@oflebbe.de>
Date: Fri, 10 Jul 2026 23:20:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: list_del corruption in amdgpu (Was: Bug#1139599:
 linux-base-7.0.10+deb14-amd64: amdgpu (ttm?) two Oops, locking the computer)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Samuel Ainsworth <skainsworth@gmail.com>
Cc: 1139599@bugs.debian.org, amd-gfx@lists.freedesktop.org
References: <178107486943.12919.15197186152368989316.reportbug@frame>
 <ajEQr3IXQ8byLFvC@monoceros> <8c28ee7c-9828-45be-b338-b6215bc184c6@amd.com>
Content-Language: de-DE, en-US
From: Olaf Flebbe <of@oflebbe.de>
In-Reply-To: <8c28ee7c-9828-45be-b338-b6215bc184c6@amd.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 12 Jul 2026 15:22:44 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------4zQrgMUDDuD6DLmJbGkkMrct
Content-Type: multipart/alternative;
 boundary="------------FzzDTnbyrX8lhAqbGYTN3K2l"

--------------FzzDTnbyrX8lhAqbGYTN3K2l
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SSBhc2tlZCBMTE0gdG8gYW5hbHlzZSB0aGUgaXNzdWUuDQoNCl9fXyBMTE0gb3V0cHV0IF9f
Xw0KDQpUaGUgaXNzdWUgaXMgYSBkb3VibGUtdGVhcmRvd24gcmFjZSBpbiBUVE06DQoNCi0g
SW4gdHRtX2JvLmMsIHRoZSBCTyBkZXN0cm95IHBhdGggcmVhY2hlcyANCmB0dG1fYm9fY2xl
YW51cF9tZW10eXBlX3VzZSgpYCDihpIgYHR0bV9yZXNvdXJjZV9mcmVlKClgIOKGkiANCmB0
dG1fcmVzb3VyY2VfZmluaSgpYC4NCi0gSW4gYW1kZ3B1X3R0bS5jLCB0aGUgbW92ZSBwYXRo
IGFsc28gZnJlZXMvcmVwbGFjZXMgdGhlIEJP4oCZcyBjdXJyZW50IA0KcmVzb3VyY2Ugdmlh
IGB0dG1fcmVzb3VyY2VfZnJlZSgpYCBhbmQgdGhlbiBgdHRtX2JvX2Fzc2lnbl9tZW0oKWAu
DQotIElmIGEgQk8gaXMgYmVpbmcgbW92ZWQgYW5kIHJlbGVhc2VkIGNvbmN1cnJlbnRseSwg
dGhlIHNhbWUgYHN0cnVjdCANCnR0bV9yZXNvdXJjZWAgY2FuIGJlIHRvcm4gZG93biB0d2lj
ZS4gVGhlIHNlY29uZCB0ZWFyZG93biB0aGVuIGhpdHMgDQpgbGlzdF9kZWxfaW5pdCgmcmVz
LT5scnUubGluaylgIG9uIGFuIGFscmVhZHktZGV0YWNoZWQgTFJVIGVudHJ5LCB3aGljaCAN
Cm1hdGNoZXMgdGhlIGBsaXN0X2RlbCBjb3JydXB0aW9uYCB3YXJuaW5nIHlvdSBzYXcgYW5k
IHRoZW4gY2FzY2FkZXMgaW50byANCnRoZSBzcGlubG9jay9vb3BzLg0KDQpfX19fX18NCkF0
IGxlYXN0IGl0IG1hdGNoZXMgdGhlIE9vcHMgSSBmb3VuZC4gSSBhc2tlZCBMTE0gdG8gY3Jl
YXRlIGEgd29ya2Fyb3VuZCANCihhdHRhY2hlZCkgLiBJIGFwcGxpZWQgaXQgdG8gdmFuaWxs
YSA3LjAuMTQgYW5kIGRpZCBub3QgZXhwZXJpZW5jZSBhbnkgDQpjcmFzaGVzIG5vdyBmb3Ig
YSBmZXcgZGF5cy4NCg0KTm90IHN1cmUgaWYgdGhlIGFwcHJvYWNoIHdpdGggdGhlIGFkZGl0
aW9uYWwgZ3VhcmQgaXMgdGhlICJyaWdodCB3YXkiIHRvIA0KZml4LA0KDQpCZXN0DQogwqAg
wqAgT2xhZg0KDQoNCg0KQW0gMTYuMDYuMjYgdW0gMTE6MTggc2NocmllYiBDaHJpc3RpYW4g
S8O2bmlnOg0KPiBPbiA2LzE2LzI2IDExOjEyLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToN
Cj4+IENvbnRyb2w6IGZvcndhcmRlZCAtMWh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FtZC1n
ZngvYWpFUXIzSVhROGJ5TEZ2Q0Btb25vY2Vyb3MNCj4+DQo+PiBIZWxsbywNCj4+DQo+PiBh
IERlYmlhbiB1c2VyIHJlcG9ydGVkIGFuIGlzc3VlIHdoaWxlIHVzaW5nIHRoZSBhbWRncHUg
dXNlci4gVGhlIGZ1bGwNCj4+IGRldGFpbHMgYXJlIGF2YWlsYWJsZSBhdGh0dHBzOi8vYnVn
cy5kZWJpYW4ub3JnLzExMzk1OTkuIFRoZSByZWx2YW50IChJDQo+PiBob3BlKSBwYXJ0cyBh
cmUgYWxzbyBpbiB0aGlzIG1haWwsIGJ1dCB5b3UgY2FuIGZpbmQgbW9yZSBsb2dzIHRoZXJl
IGlmDQo+PiB5b3Ugd2FudCB0byB0YWtlIGEgbG9vay4NCj4+DQo+PiBPbiBXZWQsIEp1biAx
MCwgMjAyNiBhdCAwOTowMTowOUFNICswMjAwLCBPbGFmIEZsZWJiZSB3cm90ZToNCj4+PiAg
ICAgKiBXaGF0IGxlZCB1cCB0byB0aGUgc2l0dWF0aW9uPw0KPj4+ICAgICAgICAgICAgIEhl
YXZ5IHVzZSBvZiBMTS1TdHVkaW8gd2l0aCBsb2NhbCBHUFUgYWNjZWxsZXJhdGVkIG1vZGVs
cy4NCj4+PiAgICAgICAgICAgICBIVzogQU1EIFJ5emVu4oSiIDcgNzg0MFUgdy8gUmFkZW9u
4oSiIDc4ME0gR3JhcGhpY3Mgw5cgMTYgKEZyYW1ld29yayAxMyBMYXB0b3ApDQo+Pj4NCj4+
PiAgICAgKiBXaGF0IGV4YWN0bHkgZGlkIHlvdSBkbyAob3Igbm90IGRvKSB0aGF0IHdhcyBl
ZmZlY3RpdmUgKG9yDQo+Pj4gICAgICAgaW5lZmZlY3RpdmUpPw0KPj4+DQo+Pj4gICAgIE5v
cm1hbCB1c2UgKHVzZSBnbm9tZS1jYWxjIGZvciBpbnN0YW5jZSkgd2hpbGUgTE0tU3R1ZGlv
IHdhcyBhY3RpdmUuDQo+Pj4NCj4+PiAgICAgKiBXaGF0IHdhcyB0aGUgb3V0Y29tZSBvZiB0
aGlzIGFjdGlvbj8NCj4+PiAgICAgICAgICBNb3ZlZCB0aGUgbW91c2U6IENvbXB1dGVyIHRv
dGFsbHkgbG9ja2VkLCBoYXQgdG8gcG93ZXIgb2ZmLg0KPj4+DQo+Pj4gICAgICogV2hhdCBv
dXRjb21lIGRpZCB5b3UgZXhwZWN0IGluc3RlYWQ/DQo+Pj4gICAgICAgICAgTW91c2UgbW92
ZW1lbnQgOikNCj4+Pg0KPj4+ICAgICBIYXBwZW5kIHR3byB0aW1lcyB3aXRoIEtlcm5lbCBy
ZXBvcnRzIGJvdGggbWVudGlvbmluZyAidHRtIHNvbWV0aGluZyIgYW5kICJhbWRncHVfYm9f
bW92ZSINCj4+IEBPbGFmOiBJZiB5b3Ugc3RpbGwgaGF2ZSBib3RoIGlzc3VlcyBpbiB5b3Vy
IGxvZ3MsIHByb3ZpZGluZyBib3RoIG1pZ2h0DQo+PiBoZWxwIHRvIGlkZW50aWZ5IHRoZSBp
c3N1ZS4gQWxzbyBpdCB3b3VsZCBiZSBncmVhdCB0byBrbm93LCBob3cgcmVsaWFibHkNCj4+
IHlvdSBjYW4gcmVwcm9kdWNlIHRoZSBpc3N1ZSwgaW4gY2FzZSB3ZSBoYXZlIHRvIHJlc29y
dCB0byBiaXNlY3Rpbmcgb3INCj4+IHRlc3RpbmcgYSBmaXguIElzIHRoaXMgYSByZWdyZXNz
aW9uLCBpLmUuIGRpZCB0aGUgc2FtZSB3b3JrZmxvdyB3b3JrDQo+PiBmaW5lIGJlZm9yZSwg
d2l0aCBhbiBvbGRlciBrZXJuZWwgdmVyc2lvbj8gSWYgc28sIHdoaWNoIG9uZT8NCj4+DQo+
Pj4gSnVuIDA5IDIzOjAwOjA4IGZyYW1lIGtlcm5lbDogIHNsYWIga21hbGxvYy05NiBzdGFy
dCBmZmZmOGNhNjYwZmVhNDIwIHBvaW50ZXIgb2Zmc2V0IDY0IHNpemUgOTYNCj4+PiBKdW4g
MDkgMjM6MDA6MDggZnJhbWUga2VybmVsOiBsaXN0X2RlbCBjb3JydXB0aW9uLiBuZXh0LT5w
cmV2IHNob3VsZCBiZSBmZmZmOGNhNjYxZTllZDYwLCBidXQgd2FzIGZmZmY4Y2E2MjNlYjkx
ODAuIChuZXh0PWZmZmY4Y2E2NjBmZWE0NjApDQo+Pj4gSnVuIDA5IDIzOjAwOjA4IGZyYW1l
IGtlcm5lbDogLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+Pj4gSnVu
IDA5IDIzOjAwOjA4IGZyYW1lIGtlcm5lbDoga2VybmVsIEJVRyBhdCBsaWIvbGlzdF9kZWJ1
Zy5jOjY1IQ0KPj4+IEp1biAwOSAyMzowMDowOCBmcmFtZSBrZXJuZWw6IE9vcHM6IGludmFs
aWQgb3Bjb2RlOiAwMDAwIFsjMV0gU01QIE5PUFRJDQo+Pj4gSnVuIDA5IDIzOjAwOjA4IGZy
YW1lIGtlcm5lbDogQ1BVOiAyIFVJRDogMTAwMCBQSUQ6IDM0Mjk0IENvbW06IHB0eXhpcyBO
b3QgdGFpbnRlZCA3LjAuMTArZGViMTQtYW1kNjQgIzEgUFJFRU1QVChsYXp5KSAgRGViaWFu
IDcuMC4xMC0xDQo+Pj4gSnVuIDA5IDIzOjAwOjA4IGZyYW1lIGtlcm5lbDogSGFyZHdhcmUg
bmFtZTogRnJhbWV3b3JrIExhcHRvcCAxMyAoQU1EIFJ5emVuIDcwNDBTZXJpZXMpL0ZSQU5N
RENQMDcsIEJJT1MgMDMuMTkgMDUvMjEvMjAyNg0KPj4+IEp1biAwOSAyMzowMDowOCBmcmFt
ZSBrZXJuZWw6IFJJUDogMDAxMDpfX2xpc3RfZGVsX2VudHJ5X3ZhbGlkX29yX3JlcG9ydCsw
eDEwYS8weDEyMA0KPj4+IEp1biAwOSAyMzowMDowOCBmcmFtZSBrZXJuZWw6IENvZGU6IDg5
IGQ3IDQ4IDg5IDE0IDI0IGU4IDU1IDM2IGJlIGZmIDQ4IDhiIDE0IDI0IDQ4IDhiIDc0IDI0
IDA4IDQ4IGM3IGM3IDQ4IDlmIGJlIDlmIDQ4IDhiIDQyIDA4IDQ4IDg5IGQxIDQ4IDg5IGMy
IGU4IGY2IDM1IDc3IGZmIDwwZj4gMGIgNjYgMmUgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAg
NjYgMmUgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDANCj4+PiBKdW4gMDkgMjM6MDA6MDggZnJh
bWUga2VybmVsOiBSU1A6IDAwMTg6ZmZmZmQ0MzRjNjdhMzZjMCBFRkxBR1M6IDAwMDEwMjQ2
DQo+Pj4gSnVuIDA5IDIzOjAwOjA4IGZyYW1lIGtlcm5lbDogUkFYOiAwMDAwMDAwMDAwMDAw
MDZkIFJCWDogZmZmZjhjYTY2MWU5ZWQyMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMjcNCj4+PiBK
dW4gMDkgMjM6MDA6MDggZnJhbWUga2VybmVsOiBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJ
OiAwMDAwMDAwMDAwMDAwMDAxIFJESTogZmZmZjhjYWQ1ZTY5ZDJjMA0KPj4+IEp1biAwOSAy
MzowMDowOCBmcmFtZSBrZXJuZWw6IFJCUDogZmZmZjhjYTYwZWQ4ZjY4OCBSMDg6IDAwMDAw
MDAwMDAwMDAwMDAgUjA5OiBmZmZmZDQzNGM2N2EzNTY4DQo+Pj4gSnVuIDA5IDIzOjAwOjA4
IGZyYW1lIGtlcm5lbDogUjEwOiBmZmZmZmZmZmEwNGYyNWIwIFIxMTogMDAwMDAwMDBmZmZm
ZWZmZiBSMTI6IGZmZmY4Y2E2MGVkOGVlMzgNCj4+PiBKdW4gMDkgMjM6MDA6MDggZnJhbWUg
a2VybmVsOiBSMTM6IGZmZmY4Y2E2NjFlOWVkNjAgUjE0OiBmZmZmOGNhNjBlZDgwMDAwIFIx
NTogMDAwMDAwMDAwMDAwMDAwMQ0KPj4+IEp1biAwOSAyMzowMDowOCBmcmFtZSBrZXJuZWw6
IEZTOiAgMDAwMDdmYzI4NTRhNDU4MCgwMDAwKSBHUzpmZmZmOGNhZGJkNWZjMDAwKDAwMDAp
IGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4+PiBKdW4gMDkgMjM6MDA6MDggZnJhbWUga2Vy
bmVsOiBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMz
DQo+Pj4gSnVuIDA5IDIzOjAwOjA4IGZyYW1lIGtlcm5lbDogQ1IyOiAwMDAwN2ZlODU1ZDlm
ZmYwIENSMzogMDAwMDAwMDE5NDE2NzAwMCBDUjQ6IDAwMDAwMDAwMDBmNTBlZjANCj4+PiBK
dW4gMDkgMjM6MDA6MDggZnJhbWUga2VybmVsOiBQS1JVOiA1NTU1NTU1NA0KPj4+IEp1biAw
OSAyMzowMDowOCBmcmFtZSBrZXJuZWw6IENhbGwgVHJhY2U6DQo+Pj4gSnVuIDA5IDIzOjAw
OjA4IGZyYW1lIGtlcm5lbDogIDxUQVNLPg0KPj4+IEp1biAwOSAyMzowMDowOCBmcmFtZSBr
ZXJuZWw6ICB0dG1fcmVzb3VyY2VfZmluaSsweDM0LzB4NzAgW3R0bV0NCj4+PiBKdW4gMDkg
MjM6MDA6MDggZnJhbWUga2VybmVsOiAgdHRtX3N5c19tYW5fZnJlZSsweDEyLzB4MjAgW3R0
bV0NCj4+PiBKdW4gMDkgMjM6MDA6MDggZnJhbWUga2VybmVsOiAgdHRtX3Jlc291cmNlX2Zy
ZWUrMHg5YS8weGYwIFt0dG1dDQo+Pj4gSnVuIDA5IDIzOjAwOjA4IGZyYW1lIGtlcm5lbDog
IGFtZGdwdV9ib19tb3ZlKzB4YmEvMHg4MTAgW2FtZGdwdV0NCj4+PiBKdW4gMDkgMjM6MDA6
MDggZnJhbWUga2VybmVsOiAgPyBzcnNvX2FsaWFzX3JldHVybl90aHVuaysweDUvMHhmYmVm
NQ0KPj4+IEp1biAwOSAyMzowMDowOCBmcmFtZSBrZXJuZWw6ICA/IHVubWFwX21hcHBpbmdf
cmFuZ2UrMHg4MC8weDEzMA0KPj4+IEp1biAwOSAyMzowMDowOCBmcmFtZSBrZXJuZWw6ICB0
dG1fYm9faGFuZGxlX21vdmVfbWVtKzB4ZDAvMHgxYTAgW3R0bV0NCj4+PiBKdW4gMDkgMjM6
MDA6MDggZnJhbWUga2VybmVsOiAgdHRtX2JvX3ZhbGlkYXRlKzB4ZDgvMHgxODAgW3R0bV0N
Cj4+PiBKdW4gMDkgMjM6MDA6MDggZnJhbWUga2VybmVsOiAgPyBfX3BmeF9hbWRncHVfY3Nf
Ym9fdmFsaWRhdGUrMHgxMC8weDEwIFthbWRncHVdDQo+Pj4gSnVuIDA5IDIzOjAwOjA4IGZy
YW1lIGtlcm5lbDogIGFtZGdwdV9jc19ib192YWxpZGF0ZSsweDlhLzB4MWEwIFthbWRncHVd
DQo+Pj4gSnVuIDA5IDIzOjAwOjA4IGZyYW1lIGtlcm5lbDogID8gX19wZnhfYW1kZ3B1X2Nz
X2JvX3ZhbGlkYXRlKzB4MTAvMHgxMCBbYW1kZ3B1XQ0KPj4+IEp1biAwOSAyMzowMDowOCBm
cmFtZSBrZXJuZWw6ICBhbWRncHVfdm1fdmFsaWRhdGUrMHgzMWIvMHg0YzAgW2FtZGdwdV0N
Cj4+PiBKdW4gMDkgMjM6MDA6MDggZnJhbWUga2VybmVsOiAgPyBfX3BmeF9hbWRncHVfY3Nf
Ym9fdmFsaWRhdGUrMHgxMC8weDEwIFthbWRncHVdDQo+Pj4gSnVuIDA5IDIzOjAwOjA4IGZy
YW1lIGtlcm5lbDogIGFtZGdwdV9jc19wYXJzZXJfYm9zLmlzcmEuMCsweDVmOC8weDk2MCBb
YW1kZ3B1XQ0KPj4+IEp1biAwOSAyMzowMDowOCBmcmFtZSBrZXJuZWw6ICBhbWRncHVfY3Nf
aW9jdGwrMHgxMGEwLzB4MjE0MCBbYW1kZ3B1XQ0KPj4+IEp1biAwOSAyMzowMDowOCBmcmFt
ZSBrZXJuZWw6ICA/IF9fcGZ4X2FtZGdwdV9jc19pb2N0bCsweDEwLzB4MTAgW2FtZGdwdV0N
Cj4+PiBKdW4gMDkgMjM6MDA6MDggZnJhbWUga2VybmVsOiAgZHJtX2lvY3RsX2tlcm5lbCsw
eGFlLzB4MTAwIFtkcm1dDQo+Pj4gSnVuIDA5IDIzOjAwOjA4IGZyYW1lIGtlcm5lbDogIGRy
bV9pb2N0bCsweDJhOC8weDU1MCBbZHJtXQ0KPj4+IEp1biAwOSAyMzowMDowOCBmcmFtZSBr
ZXJuZWw6ICA/IF9fcGZ4X2FtZGdwdV9jc19pb2N0bCsweDEwLzB4MTAgW2FtZGdwdV0NCj4+
PiBKdW4gMDkgMjM6MDA6MDggZnJhbWUga2VybmVsOiAgYW1kZ3B1X2RybV9pb2N0bCsweDRh
LzB4ODAgW2FtZGdwdV0NCj4+PiBKdW4gMDkgMjM6MDA6MDggZnJhbWUga2VybmVsOiAgX194
NjRfc3lzX2lvY3RsKzB4OTcvMHhlMA0KPj4+IEp1biAwOSAyMzowMDowOCBmcmFtZSBrZXJu
ZWw6ICBkb19zeXNjYWxsXzY0KzB4Y2QvMHgxNWYwDQo+Pj4gSnVuIDA5IDIzOjAwOjA4IGZy
YW1lIGtlcm5lbDogID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUNCj4+
PiBKdW4gMDkgMjM6MDA6MDggZnJhbWUga2VybmVsOiAgPyBjb3VudF9tZW1jZ19ldmVudHMr
MHhlYi8weDIyMA0KPj4+IEp1biAwOSAyMzowMDowOCBmcmFtZSBrZXJuZWw6ICA/IHNyc29f
YWxpYXNfcmV0dXJuX3RodW5rKzB4NS8weGZiZWY1DQo+Pj4gSnVuIDA5IDIzOjAwOjA4IGZy
YW1lIGtlcm5lbDogID8gaGFuZGxlX21tX2ZhdWx0KzB4MWQ2LzB4MmQwDQo+Pj4gSnVuIDA5
IDIzOjAwOjA4IGZyYW1lIGtlcm5lbDogID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsrMHg1
LzB4ZmJlZjUNCj4+PiBKdW4gMDkgMjM6MDA6MDggZnJhbWUga2VybmVsOiAgPyBkb191c2Vy
X2FkZHJfZmF1bHQrMHgyYjQvMHg3YjANCj4+PiBKdW4gMDkgMjM6MDA6MDggZnJhbWUga2Vy
bmVsOiAgPyBzcnNvX2FsaWFzX3JldHVybl90aHVuaysweDUvMHhmYmVmNQ0KPj4+IEp1biAw
OSAyMzowMDowOCBmcmFtZSBrZXJuZWw6ICA/IGlycWVudHJ5X2V4aXQrMHg3OC8weDY4MA0K
Pj4+IEp1biAwOSAyMzowMDowOCBmcmFtZSBrZXJuZWw6ICA/IHNyc29fYWxpYXNfcmV0dXJu
X3RodW5rKzB4NS8weGZiZWY1DQo+Pj4gSnVuIDA5IDIzOjAwOjA4IGZyYW1lIGtlcm5lbDog
ID8gZXhjX3BhZ2VfZmF1bHQrMHg4Mi8weDFkMA0KPj4+IEp1biAwOSAyMzowMDowOCBmcmFt
ZSBrZXJuZWw6ICA/IHNyc29fYWxpYXNfcmV0dXJuX3RodW5rKzB4NS8weGZiZWY1DQo+Pj4g
SnVuIDA5IDIzOjAwOjA4IGZyYW1lIGtlcm5lbDogIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJf
aHdmcmFtZSsweDc2LzB4N2UNCj4+PiBKdW4gMDkgMjM6MDA6MDggZnJhbWUga2VybmVsOiBS
SVA6IDAwMzM6MHg3ZmMyOGFiYjNkM2INCj4+PiBKdW4gMDkgMjM6MDA6MDggZnJhbWUga2Vy
bmVsOiBDb2RlOiAwMCA0OCA4OSA0NCAyNCAxOCAzMSBjMCA0OCA4ZCA0NCAyNCA2MCBjNyAw
NCAyNCAxMCAwMCAwMCAwMCA0OCA4OSA0NCAyNCAwOCA0OCA4ZCA0NCAyNCAyMCA0OCA4OSA0
NCAyNCAxMCBiOCAxMCAwMCAwMCAwMCAwZiAwNSA8ODk+IGMyIDNkIDAwIGYwIGZmIGZmIDc3
IDFjIDQ4IDhiIDQ0IDI0IDE4IDY0IDQ4IDJiIDA0IDI1IDI4IDAwIDAwDQo+Pj4gSnVuIDA5
IDIzOjAwOjA4IGZyYW1lIGtlcm5lbDogUlNQOiAwMDJiOjAwMDA3ZmZkZTVjYTg0YTAgRUZM
QUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDAxMA0KPj4+IEp1biAwOSAy
MzowMDowOCBmcmFtZSBrZXJuZWw6IFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA3
ZmZkZTVjYTg2YjggUkNYOiAwMDAwN2ZjMjhhYmIzZDNiDQo+Pj4gSnVuIDA5IDIzOjAwOjA4
IGZyYW1lIGtlcm5lbDogUkRYOiAwMDAwN2ZmZGU1Y2E4NTQwIFJTSTogMDAwMDAwMDBjMDE4
NjQ0NCBSREk6IDAwMDAwMDAwMDAwMDAwMTMNCj4+PiBKdW4gMDkgMjM6MDA6MDggZnJhbWUg
a2VybmVsOiBSQlA6IDAwMDA3ZmZkZTVjYTg1ODAgUjA4OiAwMDAwNTYzOGRmNjFhODYwIFIw
OTogMDAwMDdmZmRlNWNhODUwMA0KPj4+IEp1biAwOSAyMzowMDowOCBmcmFtZSBrZXJuZWw6
IFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAw
NTYzOGRmNjFhODAwDQo+Pj4gSnVuIDA5IDIzOjAwOjA4IGZyYW1lIGtlcm5lbDogUjEzOiAw
MDAwMDAwMDAwMDAwMDEzIFIxNDogMDAwMDA4NjU1OWMzZThmYiBSMTU6IDAwMDA1NjM4ZGY4
MzI2MjANCj4+PiBKdW4gMDkgMjM6MDA6MDggZnJhbWUga2VybmVsOiAgPC9UQVNLPg0KPj4+
IEp1biAwOSAyMzowMDowOCBmcmFtZSBrZXJuZWw6IE1vZHVsZXMgbGlua2VkIGluOiBvdmVy
bGF5IHNkX21vZCBzY3NpX21vZCBzY3NpX2NvbW1vbiByZmNvbW0gc25kX3NlcV9kdW1teSBz
bmRfaHJ0aW1lciBzbmRfc2VxIHh0X0NIRUNLU1VNIHh0X01BU1FVRVJBREUgeHRfY29ubnRy
YWNrIGlwdF9SRUpFQ1QgbmZfcmVqZWN0X2lwdjQgeHRfdGNwdWRwIG5mdF9jb21wYXQgeF90
YWJsZXMgbmZ0X2NoYWluX25hdCBuZl9uYXQgbmZfY29ubnRyYWNrIG5mX2RlZnJhZ19pcHY2
IG5mX2RlZnJhZ19pcHY0IG5mX3RhYmxlcyBicmlkZ2Ugc3RwIGxsYyBjY20gdWhpZCBjbWFj
IGFsZ2lmX2hhc2ggYWxnaWZfc2tjaXBoZXIgYWZfYWxnIHFydHIgYm5lcCBubHNfYXNjaWkg
bmxzX2NwNDM3IHZmYXQgZmF0IGFtZF9hdGwgaW50ZWxfcmFwbF9tc3IgaW50ZWxfcmFwbF9j
b21tb24gZWRhY19tY2VfYW1kIHNuZF9zb2ZfYW1kX3JlbWJyYW5kdCBrdm1fYW1kIHNuZF9z
b2ZfYW1kX2FjcCBzbmRfc29mX3BjaSBzbmRfc29mX3h0ZW5zYV9kc3Agc25kX3NvZiBrdm0g
c25kX3NvZl91dGlscyBzbmRfcGNpX3BzIHNuZF9zb2NfYWNwaV9hbWRfbWF0Y2ggdXZjdmlk
ZW8gaGlkX3NlbnNvcl9hbHMgc25kX3NvY19hY3BpX2FtZF9zZGNhX3F1aXJrcyBoaWRfc2Vu
c29yX3RyaWdnZXIgc25kX2FtZF9zZHdfYWNwaSB2aWRlb2J1ZjJfdm1hbGxvYyBzb3VuZHdp
cmVfYW1kIGlycWJ5cGFzcyBoaWRfc2Vuc29yX2lpb19jb21tb24gaXdsbXZtIHNvdW5kd2ly
ZV9nZW5lcmljX2FsbG9jYXRpb24gdXZjIGtmaWZvX2J1ZiBidHVzYiByYXBsIHNvdW5kd2ly
ZV9idXMgaW5kdXN0cmlhbGlvIHZpZGVvYnVmMl9tZW1vcHMgYnRtdGsgdmlkZW9idWYyX3Y0
bDIgbGVkc19jcm9zX2VjIHNuZF9zb2Nfc2RjYSBzbmRfaGRhX2NvZGVjX2FsYzI2OSBidHJ0
bCB3bWlfYm1vZiBjcm9zX2VjX2h3bW9uIGxlZF9jbGFzc19tdWx0aWNvbG9yIHNuZF9oZGFf
Y29kZWNfcmVhbHRla19saWIgdmlkZW9kZXYgc25kX2hkYV9jb2RlY19hdGloZG1pIGJ0YmNt
IG1hYzgwMjExIHNuZF9zb2NfY29yZQ0KPj4+IEp1biAwOSAyMzowMDowOCBmcmFtZSBrZXJu
ZWw6ICBzbmRfaGRhX2NvZGVjX2hkbWkgYnRpbnRlbCBzbmRfaGRhX3Njb2RlY19jb21wb25l
bnQgcGNzcGtyIHZpZGVvYnVmMl9jb21tb24gc25kX2NvbXByZXNzIHNuZF9oZGFfY29kZWNf
Z2VuZXJpYyBibHVldG9vdGggbGliYXJjNCBzbmRfcGNtX2RtYWVuZ2luZSBzbmRfdXNiX2F1
ZGlvIGsxMHRlbXAgc25kX3JwbF9wY2lfYWNwNnggc3BkNTExOCBzbmRfaGRhX2ludGVsIHNu
ZF91c2JtaWRpX2xpYiBlY2RoX2dlbmVyaWMgc25kX2FjcF9wY2kgc25kX2hkYV9jb2RlYyBz
bmRfYW1kX2FjcGlfbWFjaCBzbmRfaGRhX2NvcmUgc25kX3Jhd21pZGkgc25kX2ludGVsX2Rz
cGNmZyBzbmRfYWNwX2xlZ2FjeV9jb21tb24gc25kX3NlcV9kZXZpY2Ugc25kX2ludGVsX3Nk
d19hY3BpIHNuZF9wY2lfYWNwNnggbWMgc25kX2h3ZGVwIGl3bHdpZmkgYW1keGRuYSBzbmRf
cGNtIHNuZF9wY2lfYWNwNXggc25kX3RpbWVyIGFtZF9wbWYgc25kX3JuX3BjaV9hY3AzeCBk
cm1fc2htZW1faGVscGVyIHNuZF9hY3BfY29uZmlnIGNmZzgwMjExIGFtZHRlZSBzbmQgc25k
X3NvY19hY3BpIHNuZF9wY2lfYWNwM3ggc291bmRjb3JlIHJma2lsbCBjY3AgYWMgYW1kX3Nm
aCBqb3lkZXYgdGVlIHBsYXRmb3JtX3Byb2ZpbGUgYW1kX3BtYyBldmRldiBiaW5mbXRfbWlz
YyBscCBwYXJwb3J0X3BjIHBwZGV2IHBhcnBvcnQgbXNyIGkyY19kZXYgY29uZmlnZnMgZWZp
X3BzdG9yZSBuZm5ldGxpbmsgZWZpdmFyZnMgYXV0b2ZzNCBleHQ0IG1iY2FjaGUgamJkMiBj
cmMzMmNfY3J5cHRvYXBpIHI4MTUzX2VjbSBjZGNfZXRoZXIgdXNibmV0IHI4MTUyIG1paSBk
bV9jcnlwdCBkbV9tb2QgYW1kZ3B1IHVzYmhpZCBhbWR4Y3AgZHJtX3BhbmVsX2JhY2tsaWdo
dF9xdWlya3MgZ3B1X3NjaGVkIGRybV9idWRkeSBkcm1fdHRtX2hlbHBlciB0dG0gZHJtX2V4
ZWMgaTJjX2FsZ29fYml0IGRybV9zdWJhbGxvY19oZWxwZXIgdWNzaV9hY3BpIGRybV9kaXNw
bGF5X2hlbHBlciB0eXBlY191Y3NpIGhpZF9tdWx0aXRvdWNoIHR5cGVjDQo+Pj4gSnVuIDA5
IDIzOjAwOjA4IGZyYW1lIGtlcm5lbDogIGhpZF9zZW5zb3JfaHViIGNlYyBoaWRfZ2VuZXJp
YyByb2xlcyByY19jb3JlIGkyY19oaWRfYWNwaSBkcm1fY2xpZW50X2xpYiBpMmNfaGlkIGNy
b3NfZWNfZGVidWdmcyBoaWQgY3Jvc19lY19jaGFyZGV2IGNyb3NfY2hhcmdlX2NvbnRyb2wg
Y3Jvc19lY19zeXNmcyBkcm1fa21zX2hlbHBlciBjcm9zX2tiZF9sZWRfYmFja2xpZ2h0IG52
bWUgeGhjaV9wY2kgZ2hhc2hfY2xtdWxuaV9pbnRlbCBjcm9zX2VjX2RldiB4aGNpX2hjZCBu
dm1lX2NvcmUgYWVzbmlfaW50ZWwgc2VyaW9fcmF3IGRybSBzcDUxMDBfdGNvIG52bWVfa2V5
cmluZyBiYXR0ZXJ5IHdhdGNoZG9nIHRodW5kZXJib2x0IHVzYmNvcmUgbnZtZV9hdXRoIGNy
b3NfZWNfbHBjcyB2aWRlbyBjcmMxNiBoa2RmIGNyb3NfZWMgaTJjX3BpaXg0IGNyb3NfZWNf
cHJvdG8gd21pIGJ1dHRvbiBpMmNfc21idXMgdXNiX2NvbW1vbg0KPj4+IEp1biAwOSAyMzow
MDowOCBmcmFtZSBrZXJuZWw6IC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0t
LQ0KPj4gSSBkaWRuJ3QgZmluZCBhIHNpbWlsYXIgcmVwb3J0IG9uIGxvcmUua2VybmVsLm9y
Zy4gRG9lcyB0aGlzIHJpbmcgYSBiZWxsDQo+PiBmb3IgeW91IGFueWhvdz8NCj4gVGhhdCBs
b29rcyBmYW1pbGlhciwgeWVzLg0KPg0KPiBKdXN0IGxhc3QgbmlnaHQgU2FtdWVsIEFpbnN3
b3J0aCByZXBvcnRlZCBzb21lIGJ1ZyBpbiBUVE0gd2hpY2ggY291bGQgdHJpZ2dlciBzdWNo
IGlzc3Vlcy4gUHV0dGluZyBoaW0gb24gQ0MuDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlh
bi4NCj4NCj4+IFRoZXJlIGFyZSBhIGZldyBhbWRncHUgY2hhbmdlcyBpbiA3LjAuMTEgKHNp
bmNlIDcuMC4xMCB3aGljaCBpcyB0aGUNCj4+IGtlcm5lbCB0aGF0IHNob3dlZCB0aGUgaXNz
dWUpLCBidXQgdGhleSBkb24ndCBsb29rICh0byBtZSB0aGF0IGlzKSBhcyBpZg0KPj4gdGhl
eSB3b3VsZCByZXNvbHZlIHRoZSBwcm9ibGVtLg0KPj4NCj4+IEJlc3QgcmVnYXJkcw0KPj4g
VXdlDQo=
--------------FzzDTnbyrX8lhAqbGYTN3K2l
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p>I asked LLM to analyse the issue.=C2=A0<br>
      <br>
      ___ LLM output ___</p>
    <p>The issue is a double-teardown race in TTM:<br>
      <br>
      - In ttm_bo.c, the BO destroy path reaches
      `ttm_bo_cleanup_memtype_use()` =E2=86=92 `ttm_resource_free()` =E2=86=
=92
      `ttm_resource_fini()`.<br>
      - In amdgpu_ttm.c, the move path also frees/replaces the BO=E2=80=99=
s
      current resource via `ttm_resource_free()` and then
      `ttm_bo_assign_mem()`.<br>
      - If a BO is being moved and released concurrently, the same
      `struct ttm_resource` can be torn down twice. The second teardown
      then hits `list_del_init(&amp;res-&gt;lru.link)` on an
      already-detached LRU entry, which matches the `list_del
      corruption` warning you saw and then cascades into the
      spinlock/oops.</p>
    <p>______<br>
      At least it matches the Oops I found. I asked LLM to create a
      workaround (attached) <font size=3D"4">. I applied it to vanilla
        7.0.14 and did not experience any crashes now for a few days.<br>=

        <br>
        Not sure if the approach with the additional guard is the "right
        way" to fix,<br>
        <br>
        Best<br>
        =C2=A0 =C2=A0 Olaf<br>
        <br>
        <br>
      </font></p>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">Am 16.06.26 um 11:18 schrieb Christian=

      K=C3=B6nig:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:8c28ee7c-9828-45be-b338-b6215bc184c6@amd.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">On 6/16/26 11:12, Uwe Kleine=
-K=C3=B6nig wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">Control: forwarded -1 <a c=
lass=3D"moz-txt-link-freetext" href=3D"https://lore.kernel.org/amd-gfx/aj=
EQr3IXQ8byLFvC@monoceros">https://lore.kernel.org/amd-gfx/ajEQr3IXQ8byLFv=
C@monoceros</a>

Hello,

a Debian user reported an issue while using the amdgpu user. The full
details are available at <a class=3D"moz-txt-link-freetext" href=3D"https=
://bugs.debian.org/1139599">https://bugs.debian.org/1139599</a>. The relv=
ant (I
hope) parts are also in this mail, but you can find more logs there if
you want to take a look.

On Wed, Jun 10, 2026 at 09:01:09AM +0200, Olaf Flebbe wrote:
</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"" class=3D"moz-quote-pre">   * What led up to the =
situation?
           Heavy use of LM-Studio with local GPU accellerated models.
           HW: AMD Ryzen=E2=84=A2 7 7840U w/ Radeon=E2=84=A2 780M Graphic=
s =C3=97 16 (Framework 13 Laptop)

   * What exactly did you do (or not do) that was effective (or
     ineffective)?

   Normal use (use gnome-calc for instance) while LM-Studio was active.

   * What was the outcome of this action?
        Moved the mouse: Computer totally locked, hat to power off.

   * What outcome did you expect instead?
        Mouse movement :)

   Happend two times with Kernel reports both mentioning "ttm something" =
and "amdgpu_bo_move"
</pre>
        </blockquote>
        <pre wrap=3D"" class=3D"moz-quote-pre">
@Olaf: If you still have both issues in your logs, providing both might
help to identify the issue. Also it would be great to know, how reliably
you can reproduce the issue, in case we have to resort to bisecting or
testing a fix. Is this a regression, i.e. did the same workflow work
fine before, with an older kernel version? If so, which one?

</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"" class=3D"moz-quote-pre">Jun 09 23:00:08 frame ke=
rnel:  slab kmalloc-96 start ffff8ca660fea420 pointer offset 64 size 96
Jun 09 23:00:08 frame kernel: list_del corruption. next-&gt;prev should b=
e ffff8ca661e9ed60, but was ffff8ca623eb9180. (next=3Dffff8ca660fea460)
Jun 09 23:00:08 frame kernel: ------------[ cut here ]------------
Jun 09 23:00:08 frame kernel: kernel BUG at lib/list_debug.c:65!
Jun 09 23:00:08 frame kernel: Oops: invalid opcode: 0000 [#1] SMP NOPTI
Jun 09 23:00:08 frame kernel: CPU: 2 UID: 1000 PID: 34294 Comm: ptyxis No=
t tainted 7.0.10+deb14-amd64 #1 PREEMPT(lazy)  Debian 7.0.10-1=20
Jun 09 23:00:08 frame kernel: Hardware name: Framework Laptop 13 (AMD Ryz=
en 7040Series)/FRANMDCP07, BIOS 03.19 05/21/2026
Jun 09 23:00:08 frame kernel: RIP: 0010:__list_del_entry_valid_or_report+=
0x10a/0x120
Jun 09 23:00:08 frame kernel: Code: 89 d7 48 89 14 24 e8 55 36 be ff 48 8=
b 14 24 48 8b 74 24 08 48 c7 c7 48 9f be 9f 48 8b 42 08 48 89 d1 48 89 c2=
 e8 f6 35 77 ff &lt;0f&gt; 0b 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 8=
4 00 00 00 00 00
Jun 09 23:00:08 frame kernel: RSP: 0018:ffffd434c67a36c0 EFLAGS: 00010246=

Jun 09 23:00:08 frame kernel: RAX: 000000000000006d RBX: ffff8ca661e9ed20=
 RCX: 0000000000000027
Jun 09 23:00:08 frame kernel: RDX: 0000000000000000 RSI: 0000000000000001=
 RDI: ffff8cad5e69d2c0
Jun 09 23:00:08 frame kernel: RBP: ffff8ca60ed8f688 R08: 0000000000000000=
 R09: ffffd434c67a3568
Jun 09 23:00:08 frame kernel: R10: ffffffffa04f25b0 R11: 00000000ffffefff=
 R12: ffff8ca60ed8ee38
Jun 09 23:00:08 frame kernel: R13: ffff8ca661e9ed60 R14: ffff8ca60ed80000=
 R15: 0000000000000001
Jun 09 23:00:08 frame kernel: FS:  00007fc2854a4580(0000) GS:ffff8cadbd5f=
c000(0000) knlGS:0000000000000000
Jun 09 23:00:08 frame kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
Jun 09 23:00:08 frame kernel: CR2: 00007fe855d9fff0 CR3: 0000000194167000=
 CR4: 0000000000f50ef0
Jun 09 23:00:08 frame kernel: PKRU: 55555554
Jun 09 23:00:08 frame kernel: Call Trace:
Jun 09 23:00:08 frame kernel:  &lt;TASK&gt;
Jun 09 23:00:08 frame kernel:  ttm_resource_fini+0x34/0x70 [ttm]
Jun 09 23:00:08 frame kernel:  ttm_sys_man_free+0x12/0x20 [ttm]
Jun 09 23:00:08 frame kernel:  ttm_resource_free+0x9a/0xf0 [ttm]
Jun 09 23:00:08 frame kernel:  amdgpu_bo_move+0xba/0x810 [amdgpu]
Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jun 09 23:00:08 frame kernel:  ? unmap_mapping_range+0x80/0x130
Jun 09 23:00:08 frame kernel:  ttm_bo_handle_move_mem+0xd0/0x1a0 [ttm]
Jun 09 23:00:08 frame kernel:  ttm_bo_validate+0xd8/0x180 [ttm]
Jun 09 23:00:08 frame kernel:  ? __pfx_amdgpu_cs_bo_validate+0x10/0x10 [a=
mdgpu]
Jun 09 23:00:08 frame kernel:  amdgpu_cs_bo_validate+0x9a/0x1a0 [amdgpu]
Jun 09 23:00:08 frame kernel:  ? __pfx_amdgpu_cs_bo_validate+0x10/0x10 [a=
mdgpu]
Jun 09 23:00:08 frame kernel:  amdgpu_vm_validate+0x31b/0x4c0 [amdgpu]
Jun 09 23:00:08 frame kernel:  ? __pfx_amdgpu_cs_bo_validate+0x10/0x10 [a=
mdgpu]
Jun 09 23:00:08 frame kernel:  amdgpu_cs_parser_bos.isra.0+0x5f8/0x960 [a=
mdgpu]
Jun 09 23:00:08 frame kernel:  amdgpu_cs_ioctl+0x10a0/0x2140 [amdgpu]
Jun 09 23:00:08 frame kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]=

Jun 09 23:00:08 frame kernel:  drm_ioctl_kernel+0xae/0x100 [drm]
Jun 09 23:00:08 frame kernel:  drm_ioctl+0x2a8/0x550 [drm]
Jun 09 23:00:08 frame kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]=

Jun 09 23:00:08 frame kernel:  amdgpu_drm_ioctl+0x4a/0x80 [amdgpu]
Jun 09 23:00:08 frame kernel:  __x64_sys_ioctl+0x97/0xe0
Jun 09 23:00:08 frame kernel:  do_syscall_64+0xcd/0x15f0
Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jun 09 23:00:08 frame kernel:  ? count_memcg_events+0xeb/0x220
Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jun 09 23:00:08 frame kernel:  ? handle_mm_fault+0x1d6/0x2d0
Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jun 09 23:00:08 frame kernel:  ? do_user_addr_fault+0x2b4/0x7b0
Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jun 09 23:00:08 frame kernel:  ? irqentry_exit+0x78/0x680
Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jun 09 23:00:08 frame kernel:  ? exc_page_fault+0x82/0x1d0
Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jun 09 23:00:08 frame kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jun 09 23:00:08 frame kernel: RIP: 0033:0x7fc28abb3d3b
Jun 09 23:00:08 frame kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 6=
0 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10=
 00 00 00 0f 05 &lt;89&gt; c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2=
b 04 25 28 00 00
Jun 09 23:00:08 frame kernel: RSP: 002b:00007ffde5ca84a0 EFLAGS: 00000246=
 ORIG_RAX: 0000000000000010
Jun 09 23:00:08 frame kernel: RAX: ffffffffffffffda RBX: 00007ffde5ca86b8=
 RCX: 00007fc28abb3d3b
Jun 09 23:00:08 frame kernel: RDX: 00007ffde5ca8540 RSI: 00000000c0186444=
 RDI: 0000000000000013
Jun 09 23:00:08 frame kernel: RBP: 00007ffde5ca8580 R08: 00005638df61a860=
 R09: 00007ffde5ca8500
Jun 09 23:00:08 frame kernel: R10: 0000000000000000 R11: 0000000000000246=
 R12: 00005638df61a800
Jun 09 23:00:08 frame kernel: R13: 0000000000000013 R14: 0000086559c3e8fb=
 R15: 00005638df832620
Jun 09 23:00:08 frame kernel:  &lt;/TASK&gt;
Jun 09 23:00:08 frame kernel: Modules linked in: overlay sd_mod scsi_mod =
scsi_common rfcomm snd_seq_dummy snd_hrtimer snd_seq xt_CHECKSUM xt_MASQU=
ERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat x_table=
s nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tabl=
es bridge stp llc ccm uhid cmac algif_hash algif_skcipher af_alg qrtr bne=
p nls_ascii nls_cp437 vfat fat amd_atl intel_rapl_msr intel_rapl_common e=
dac_mce_amd snd_sof_amd_rembrandt kvm_amd snd_sof_amd_acp snd_sof_pci snd=
_sof_xtensa_dsp snd_sof kvm snd_sof_utils snd_pci_ps snd_soc_acpi_amd_mat=
ch uvcvideo hid_sensor_als snd_soc_acpi_amd_sdca_quirks hid_sensor_trigge=
r snd_amd_sdw_acpi videobuf2_vmalloc soundwire_amd irqbypass hid_sensor_i=
io_common iwlmvm soundwire_generic_allocation uvc kfifo_buf btusb rapl so=
undwire_bus industrialio videobuf2_memops btmtk videobuf2_v4l2 leds_cros_=
ec snd_soc_sdca snd_hda_codec_alc269 btrtl wmi_bmof cros_ec_hwmon led_cla=
ss_multicolor snd_hda_codec_realtek_lib videodev snd_hda_codec_atihdmi bt=
bcm mac80211 snd_soc_core
Jun 09 23:00:08 frame kernel:  snd_hda_codec_hdmi btintel snd_hda_scodec_=
component pcspkr videobuf2_common snd_compress snd_hda_codec_generic blue=
tooth libarc4 snd_pcm_dmaengine snd_usb_audio k10temp snd_rpl_pci_acp6x s=
pd5118 snd_hda_intel snd_usbmidi_lib ecdh_generic snd_acp_pci snd_hda_cod=
ec snd_amd_acpi_mach snd_hda_core snd_rawmidi snd_intel_dspcfg snd_acp_le=
gacy_common snd_seq_device snd_intel_sdw_acpi snd_pci_acp6x mc snd_hwdep =
iwlwifi amdxdna snd_pcm snd_pci_acp5x snd_timer amd_pmf snd_rn_pci_acp3x =
drm_shmem_helper snd_acp_config cfg80211 amdtee snd snd_soc_acpi snd_pci_=
acp3x soundcore rfkill ccp ac amd_sfh joydev tee platform_profile amd_pmc=
 evdev binfmt_misc lp parport_pc ppdev parport msr i2c_dev configfs efi_p=
store nfnetlink efivarfs autofs4 ext4 mbcache jbd2 crc32c_cryptoapi r8153=
_ecm cdc_ether usbnet r8152 mii dm_crypt dm_mod amdgpu usbhid amdxcp drm_=
panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec i2=
c_algo_bit drm_suballoc_helper ucsi_acpi drm_display_helper typec_ucsi hi=
d_multitouch typec
Jun 09 23:00:08 frame kernel:  hid_sensor_hub cec hid_generic roles rc_co=
re i2c_hid_acpi drm_client_lib i2c_hid cros_ec_debugfs hid cros_ec_charde=
v cros_charge_control cros_ec_sysfs drm_kms_helper cros_kbd_led_backlight=
 nvme xhci_pci ghash_clmulni_intel cros_ec_dev xhci_hcd nvme_core aesni_i=
ntel serio_raw drm sp5100_tco nvme_keyring battery watchdog thunderbolt u=
sbcore nvme_auth cros_ec_lpcs video crc16 hkdf cros_ec i2c_piix4 cros_ec_=
proto wmi button i2c_smbus usb_common
Jun 09 23:00:08 frame kernel: ---[ end trace 0000000000000000 ]---
</pre>
        </blockquote>
        <pre wrap=3D"" class=3D"moz-quote-pre">
I didn't find a similar report on lore.kernel.org. Does this ring a bell
for you anyhow?
</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">
That looks familiar, yes.

Just last night Samuel Ainsworth reported some bug in TTM which could tri=
gger such issues. Putting him on CC.

Regards,
Christian.

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">
There are a few amdgpu changes in 7.0.11 (since 7.0.10 which is the
kernel that showed the issue), but they don't look (to me that is) as if
they would resolve the problem.

Best regards
Uwe
</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------FzzDTnbyrX8lhAqbGYTN3K2l--

--------------4zQrgMUDDuD6DLmJbGkkMrct
Content-Type: text/x-patch; charset=UTF-8; name="ttm.patch"
Content-Disposition: attachment; filename="ttm.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3Jlc291cmNlLmMgYi9kcml2
ZXJzL2dwdS9kcm0vdHRtL3R0bV9yZXNvdXJjZS5jCmluZGV4IGJmZDljNjhmY2Q5Yy4uYjA2
NWIxYWJhNDM1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9yZXNvdXJj
ZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3Jlc291cmNlLmMKQEAgLTM1Miw2
ICszNTIsNyBAQCB2b2lkIHR0bV9yZXNvdXJjZV9pbml0KHN0cnVjdCB0dG1fYnVmZmVyX29i
amVjdCAqYm8sCiAJcmVzLT5idXMuaXNfaW9tZW0gPSBmYWxzZTsKIAlyZXMtPmJ1cy5jYWNo
aW5nID0gdHRtX2NhY2hlZDsKIAlyZXMtPmJvID0gYm87CisJcmVzLT5mbGFncyA9IDA7CiAK
IAltYW4gPSB0dG1fbWFuYWdlcl90eXBlKGJvLT5iZGV2LCBwbGFjZS0+bWVtX3R5cGUpOwog
CXNwaW5fbG9jaygmYm8tPmJkZXYtPmxydV9sb2NrKTsKQEAgLTM4MCw4ICszODEsMTEgQEAg
dm9pZCB0dG1fcmVzb3VyY2VfZmluaShzdHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFnZXIgKm1h
biwKIAlzdHJ1Y3QgdHRtX2RldmljZSAqYmRldiA9IG1hbi0+YmRldjsKIAogCXNwaW5fbG9j
aygmYmRldi0+bHJ1X2xvY2spOworCWlmIChsaXN0X2VtcHR5KCZyZXMtPmxydS5saW5rKSkK
KwkJCWdvdG8gb3V0OwogCWxpc3RfZGVsX2luaXQoJnJlcy0+bHJ1LmxpbmspOwogCW1hbi0+
dXNhZ2UgLT0gcmVzLT5zaXplOworb3V0OgogCXNwaW5fdW5sb2NrKCZiZGV2LT5scnVfbG9j
ayk7CiB9CiBFWFBPUlRfU1lNQk9MKHR0bV9yZXNvdXJjZV9maW5pKTsKQEAgLTQyNSwxNyAr
NDI5LDI0IEBAIHZvaWQgdHRtX3Jlc291cmNlX2ZyZWUoc3RydWN0IHR0bV9idWZmZXJfb2Jq
ZWN0ICpibywgc3RydWN0IHR0bV9yZXNvdXJjZSAqKnJlcykKIHsKIAlzdHJ1Y3QgdHRtX3Jl
c291cmNlX21hbmFnZXIgKm1hbjsKIAlzdHJ1Y3QgZG1lbV9jZ3JvdXBfcG9vbF9zdGF0ZSAq
cG9vbDsKKwlzdHJ1Y3QgdHRtX3Jlc291cmNlICpyZXNvdXJjZTsKIAogCWlmICghKnJlcykK
IAkJcmV0dXJuOwogCisJcmVzb3VyY2UgPSAqcmVzOworCWlmICh0ZXN0X2FuZF9zZXRfYml0
KFRUTV9SRVNPVVJDRV9GTEFHX0ZSRUVELCAmcmVzb3VyY2UtPmZsYWdzKSkKKwkJcmV0dXJu
OworCisJKnJlcyA9IE5VTEw7CisKIAlzcGluX2xvY2soJmJvLT5iZGV2LT5scnVfbG9jayk7
Ci0JdHRtX3Jlc291cmNlX2RlbF9idWxrX21vdmUoKnJlcywgYm8pOworCXR0bV9yZXNvdXJj
ZV9kZWxfYnVsa19tb3ZlKHJlc291cmNlLCBibyk7CiAJc3Bpbl91bmxvY2soJmJvLT5iZGV2
LT5scnVfbG9jayk7CiAKLQlwb29sID0gKCpyZXMpLT5jc3M7Ci0JbWFuID0gdHRtX21hbmFn
ZXJfdHlwZShiby0+YmRldiwgKCpyZXMpLT5tZW1fdHlwZSk7Ci0JbWFuLT5mdW5jLT5mcmVl
KG1hbiwgKnJlcyk7CisJcG9vbCA9IHJlc291cmNlLT5jc3M7CisJbWFuID0gdHRtX21hbmFn
ZXJfdHlwZShiby0+YmRldiwgcmVzb3VyY2UtPm1lbV90eXBlKTsKKwltYW4tPmZ1bmMtPmZy
ZWUobWFuLCByZXNvdXJjZSk7CiAJKnJlcyA9IE5VTEw7CiAJaWYgKG1hbi0+Y2cpCiAJCWRt
ZW1fY2dyb3VwX3VuY2hhcmdlKHBvb2wsIGJvLT5iYXNlLnNpemUpOwpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9kcm0vdHRtL3R0bV9yZXNvdXJjZS5oIGIvaW5jbHVkZS9kcm0vdHRtL3R0bV9y
ZXNvdXJjZS5oCmluZGV4IGE1ZDM4NjU4M2ZiNi4uMWE1OGMwYzAwMGM1IDEwMDY0NAotLS0g
YS9pbmNsdWRlL2RybS90dG0vdHRtX3Jlc291cmNlLmgKKysrIGIvaW5jbHVkZS9kcm0vdHRt
L3R0bV9yZXNvdXJjZS5oCkBAIC0zMCw2ICszMCw3IEBACiAjaW5jbHVkZSA8bGludXgvbXV0
ZXguaD4KICNpbmNsdWRlIDxsaW51eC9pb3N5cy1tYXAuaD4KICNpbmNsdWRlIDxsaW51eC9k
bWEtZmVuY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9iaXRvcHMuaD4KIAogI2luY2x1ZGUgPGRy
bS90dG0vdHRtX2NhY2hpbmcuaD4KICNpbmNsdWRlIDxkcm0vdHRtL3R0bV9rbWFwX2l0ZXIu
aD4KQEAgLTM3LDYgKzM4LDggQEAKICNkZWZpbmUgVFRNX01BWF9CT19QUklPUklUWQk0VQog
I2RlZmluZSBUVE1fTlVNX01FTV9UWVBFUyA5CiAKKyNkZWZpbmUgVFRNX1JFU09VUkNFX0ZM
QUdfRlJFRUQJQklUKDApCisKIHN0cnVjdCBkZW50cnk7CiBzdHJ1Y3QgZG1lbV9jZ3JvdXBf
ZGV2aWNlOwogc3RydWN0IGRybV9wcmludGVyOwpAQCAtMjcwLDYgKzI3Myw4IEBAIHN0cnVj
dCB0dG1fcmVzb3VyY2UgewogCiAJc3RydWN0IGRtZW1fY2dyb3VwX3Bvb2xfc3RhdGUgKmNz
czsKIAorCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisKIAkvKioKIAkgKiBAbHJ1OiBMZWFzdCBy
ZWNlbnRseSB1c2VkIGxpc3QsIHNlZSAmdHRtX3Jlc291cmNlX21hbmFnZXIubHJ1CiAJICov
Cg==

--------------4zQrgMUDDuD6DLmJbGkkMrct--
