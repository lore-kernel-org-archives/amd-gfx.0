Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B745C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 15:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF4E23888
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 15:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF4E23888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5587B6E833;
	Fri,  8 Jan 2021 15:53:49 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A0296E834
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 15:53:49 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id d8so10049221otq.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 07:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7yGxCekSojHDYOKSkLKVDxqNk+xNiwlQRKwqadkl6Qg=;
 b=XYzfqLoPisd6/WCjRspggY1uo3hMVRGzQNIxiHjrqI/Y3r4WA3rNma5JQNjZumXAo+
 DlJUz9OescNJ8AeAM2cWG7lo4w8ZGxbqHa1GtXxcBLdq0BDHpUwkrl7BrpPH7N4cxmxv
 oiT0nhw3IUl4kuDDZBNBYMChMJ2ZV0fH1DKaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7yGxCekSojHDYOKSkLKVDxqNk+xNiwlQRKwqadkl6Qg=;
 b=gutQ9j475i9cndGGsM1VAmtYB7fxEhFE171TCtekQMfQ3qh4W/b5B5YF3D5V/R3iN9
 osFlXxMWjw2AyQIUZHatmpBtB1KPKl7R8XxdgMkSybtBw2TP5HwyfZ3D7pehUes61wtT
 QglteJRtgtdECcPBbdBghgMVn0ELE+U8sUKT5LY1gn6MCvNLezai+FnRBCLiuIuTlu/Y
 +TK3PItBW5AxUH40KwzNfoK53vX5TdenMf7Yab428xF/TgYhtDbtGzWKsqfcr5gDFnuN
 KlLSEfJ9y0vqObRxSk6P5XYT4Q60pUxAop3kv9eMMqAy5YhfCLoWEe4ZgKf/+FkTbblq
 xdYA==
X-Gm-Message-State: AOAM530EH48OQDw8h8qf1ixJV2Qg7N4o/Rh7p2qq0zUZhxtiqx6CmY0I
 /DHZnTQ+UeK6eOK8hMAXWkiZ93jcTeiNdMPxeLNeGA==
X-Google-Smtp-Source: ABdhPJxaK0cDu0umLpp81gyT1/VEQ5bureaC+soHqdkcGlb84sTagjj3r9vdtwiy0mJE8KIZ+hXQNiWQrUGV/5GnQ9Y=
X-Received: by 2002:a9d:23ca:: with SMTP id t68mr3051813otb.281.1610121228319; 
 Fri, 08 Jan 2021 07:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20210105182309.1362-1-christian.koenig@amd.com>
 <X/dN/YFtnVAIllds@phenom.ffwll.local>
 <ffa9d7f2-fe68-fb6a-8422-82b8949dbe1e@gmail.com>
 <X/hs1Rvm57zGPU8y@phenom.ffwll.local>
 <d066b08c-756c-bbef-0f30-d8c68ef92dbf@amd.com>
In-Reply-To: <d066b08c-756c-bbef-0f30-d8c68ef92dbf@amd.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 8 Jan 2021 16:53:37 +0100
Message-ID: <CAKMK7uGcRM8E0hYZeJCUuON7+uZnyEVtwU0HrNwhoWcw9V2uNA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/radeon: stop re-init the TTM page pool
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@alien8.de>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKYW4gOCwgMjAyMSBhdCAzOjM2IFBNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAwOC4wMS4yMSB1bSAxNTozMSBzY2hyaWVi
IERhbmllbCBWZXR0ZXI6Cj4gPiBPbiBUaHUsIEphbiAwNywgMjAyMSBhdCAwOTowODoyOVBNICsw
MTAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+ID4+IEFtIDA3LjAxLjIxIHVtIDE5OjA3IHNj
aHJpZWIgRGFuaWVsIFZldHRlcjoKPiA+Pj4gT24gVHVlLCBKYW4gMDUsIDIwMjEgYXQgMDc6MjM6
MDhQTSArMDEwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiA+Pj4+IERyaXZlcnMgYXJlIG5v
dCBzdXBwb3NlZCB0byBpbml0IHRoZSBwYWdlIHBvb2wgZGlyZWN0bHkgYW55IG1vcmUuCj4gPj4+
Pgo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgo+ID4+PiBQbGVhc2UgaW5jbHVkZSByZXBvcnRlZC1ieSBjcmVkaXRzIGFuZCBs
aW5rIHRvIHRoZSBidWcgcmVwb3J0cyBvbgo+ID4+PiBsb3JlLmtlcm5lbC5vcmcgd2hlbiBtZXJn
aW5nIHRoaXMuIEFsc28gSSBndWVzcyB0aGlzIHNob3VsZCBoYXZlIGEgRml4ZXM6Cj4gPj4+IGxp
bmU/Cj4gPj4gSSdtIG5vdCBhd2FyZSBvZiBhIGJ1ZyByZXBvcnQsIGJ1dCB0aGUgcmVwb3J0ZWQt
YnkvRml4ZXMgbGluZXMgYXJlIGluZGVlZAo+ID4+IG1pc3NpbmcuCj4gPiBUaGlzIG9uZSBoZXJl
Ogo+ID4KPiA+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRmxvcmUua2VybmVsLm9yZyUyRmRyaS1kZXZlbCUyRjIwMjAxMjMx
MTA0MDIwLkdBNDUwNCU0MHpuLnRuaWMlMkYmYW1wO2RhdGE9MDQlN0MwMSU3Q2NocmlzdGlhbi5r
b2VuaWclNDBhbWQuY29tJTdDM2FlZGUyMDMzNDhiNGYzMmVhMzEwOGQ4YjNlMjI0ZWMlN0MzZGQ4
OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NDU3MTMxMTc5MjU4NDg4
JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1
TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPWJIVnc0
bGoxZjhnNG9oVlRldUtOa2IwTEFiTHdZNk40S1dvcnRyM1Z0QW8lM0QmYW1wO3Jlc2VydmVkPTAK
PiA+Cj4gPiBPciBkaWQgSSBnZXQgY29uZnVzZWQsIGFuZCB0aGUgYWJvdmUgaXMgeWV0IGFub3Ro
ZXIgYnVnPwo+Cj4gWWVhaCwgYnV0IHRoYXQgd2FzIGp1c3QgcmVwb3J0ZWQgYnkgbWFpbC4gVGhl
IGJ1ZyB0cmFja2VyIEkndmUgc2F3IHdhcwo+IG9wZW5lZCBhZnRlciB0aGUgcGF0Y2ggd2FzIGFs
cmVhZHkgcHVzaGVkLgoKU3RpbGwgZ29vZCB0byBnaXZlIHJlcG9ydGVkLWJ5IGNyZWRpdHMgZm9y
IG1haWxpbmcgbGlzdCByZXBvcnRzIGFuZApsaW5rIHRvIGxvcmUua2VybmVsLm9yZyBmb3IgdGhl
IHJlcG9ydCwgdGhhdCdzIG5vdCBqdXN0IHVzZWZ1bCBmb3IKYnVnemlsbGEgcmVwb3J0cy4KCj4g
Pj4gQlRXOiBBbnkgaWRlYSB3aHkgZGltIGFkZC1saW5rIGRvZXNuJ3Qgd29yaz8KPiA+IEhtIHdl
IG9jY2FzaW9uYWxseSBoYXZlIGZ1biB3aXRoIGVtYWlsIHBhcnNpbmcgKGl0J3MgaGFyZCkgYW5k
IGVzcGVjaWFsbHkKPiA+IHB5dGhvbiBjaGFuZ2VzIGluIGhvdyBlbmNvZGluZ3MgYXJlIGhhbmRs
ZWQgZGlmZmVyZW50bHkgYmV0d2VlbiBweXRob24yCj4gPiBhbmQgcHl0aG9uMy4gSWYgeW91IGhh
dmUgYSBzcGVjaWZpYyBleGFtcGxlIEkgY2FuIHRyeSBhbmQgdGFrZSBhIGxvb2sgd2h5Cj4gPiBp
dCBkb2Vzbid0IHdvcmsuCj4KPiBJdCBqdXN0IGxvb2tzIHVwIGFuZCBkb2Vzbid0IHNlZW0gdG8g
ZG8gYW55dGhpbmcuIEknbSBub3QgZmFtaWxpYXIgd2l0aAo+IHB5dGhvbiBzbyBJIGNhbiBqdXN0
IGRlc2NyaWJlIHRoZSBzeW1wdG9tcy4KCkkgbWVhbnQgdGVsbCBtZSB3aGljaCBtYWlsIChwYXRj
aHdvcmsgb3IgbG9yZSkgYW5kIEknbGwgdHJ5IHRvCnJlcHJvZHVjZSBhbmQgc2VlIHdoYXQncyBt
YXliZSB1cC4KLURhbmllbAoKPgo+IENocmlzdGlhbi4KPgo+ID4gLURhbmllbAo+ID4KPiA+Pj4g
QW5kIG1heWJlIHNvbWUgd29yZHMgb24gaG93L3doeSBzdHVmZiBibG93cyB1cC4KPiA+PiBKdXN0
IGEgdHlwby4gSSd2ZSBmb3Jnb3QgdG8gcmVtb3ZlIHR3byBsaW5lcyBpbiByYWRlb24gd2hpbGUg
cmViYXNpbmcgYW5kCj4gPj4gc3RpbGwgaGFkIHRoZSBzeW1ib2xzIGV4cG9ydGVkIHNvIG5ldmVy
IG5vdGljZWQgdGhpcy4KPiA+Pgo+ID4+IENocmlzdGlhbi4KPiA+Pgo+ID4+PiAtRGFuaWVsCj4g
Pj4+Cj4gPj4+PiAtLS0KPiA+Pj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0
bS5jIHwgMyAtLS0KPiA+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQo+ID4+
Pj4KPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0u
YyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jCj4gPj4+PiBpbmRleCBkNDMy
OGZmNTc3NTcuLjM1YjcxNWY4MmVkOCAxMDA2NDQKPiA+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX3R0bS5jCj4gPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl90dG0uYwo+ID4+Pj4gQEAgLTcyOSw5ICs3MjksNiBAQCBpbnQgcmFkZW9uX3R0bV9p
bml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQo+ID4+Pj4gICAgICAgICAgICB9Cj4gPj4+
PiAgICAgICAgICAgIHJkZXYtPm1tYW4uaW5pdGlhbGl6ZWQgPSB0cnVlOwo+ID4+Pj4gLSAgdHRt
X3Bvb2xfaW5pdCgmcmRldi0+bW1hbi5iZGV2LnBvb2wsIHJkZXYtPmRldiwgcmRldi0+bmVlZF9z
d2lvdGxiLAo+ID4+Pj4gLSAgICAgICAgICAgICAgICBkbWFfYWRkcmVzc2luZ19saW1pdGVkKCZy
ZGV2LT5wZGV2LT5kZXYpKTsKPiA+Pj4+IC0KPiA+Pj4+ICAgICAgICAgICAgciA9IHJhZGVvbl90
dG1faW5pdF92cmFtKHJkZXYpOwo+ID4+Pj4gICAgICAgICAgICBpZiAocikgewo+ID4+Pj4gICAg
ICAgICAgICAgICAgICAgIERSTV9FUlJPUigiRmFpbGVkIGluaXRpYWxpemluZyBWUkFNIGhlYXAu
XG4iKTsKPiA+Pj4+IC0tCj4gPj4+PiAyLjI1LjEKPiA+Pj4+Cj4gPj4+PiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4+Pj4gZHJpLWRldmVsIG1haWxp
bmcgbGlzdAo+ID4+Pj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4+Pj4gaHR0
cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNB
JTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGZHJpLWRl
dmVsJmFtcDtkYXRhPTA0JTdDMDElN0NjaHJpc3RpYW4ua29lbmlnJTQwYW1kLmNvbSU3QzNhZWRl
MjAzMzQ4YjRmMzJlYTMxMDhkOGIzZTIyNGVjJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0
ZTE4M2QlN0MwJTdDMCU3QzYzNzQ1NzEzMTE3OTI1ODQ4OCU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENK
WFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1wSHp1QXNKY1hmNUhsQWZKN3dZWWMlMkJzaXpa
aFNMQkdXWEJoQ3lWTlJDZm8lM0QmYW1wO3Jlc2VydmVkPTAKPgoKCi0tIApEYW5pZWwgVmV0dGVy
ClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5j
aApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
