Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18438C2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 19:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE246140F
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 19:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE246140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C5E46EAB4;
	Tue, 25 May 2021 19:22:40 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B11286EAB4
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 19:22:38 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id l1so49062382ejb.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iNqqjAzwB4ddR4rU5x8387OwH1bg7YhoE11QQG0XWWk=;
 b=j9Llhxfcw55sbGYj4jPWnuOue6JG8Vaj1z7xgif6PX+n1Vv0gnoTl2Ay/h54SUQQW7
 0m3CjrnN45NpV8dQGtelhXQlVh4Xq8BwrARtUQ3Gr36ChgYS61TKr2P8/88L4j0k00YG
 9axiuj6A49ZdG4hxDynJH1zx0fXuN01kFvJstJ3GdApkVyMArOcxSOwdqjNW6Jl+z8/I
 KBek79aD7t2L1MOpQn/Y/E+ySj+xwsmjANj21pk1x/YcRLzUQ99iBYnJeCdtCYj3OIVW
 XNqr51jUwehTsWPf+W5miUPSEuMSslTbGS+KKKCNLYdYOSccBIifWsFYzLFIPTwOeJMN
 YOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iNqqjAzwB4ddR4rU5x8387OwH1bg7YhoE11QQG0XWWk=;
 b=BrImspd7yMOcHIMm0wgQlDIkDQWX+stKMqBgKJd7hxqWr9WvKQJiHd7KCQFwR7CSeO
 mO8p4khRNCj34i6P3o2TSUOZo0nw7vPI1SO8U8UpnfIW65omeP1Le59q9FyxpZxii0TX
 Kdy/RMhb9I1aqSLXTR+/LZ5W/U2CScksFSx3jk6Op7Q4ueN6ZNUJgq+Ye19eD5V41jZn
 XFn0bUmu70V/9UpPljQ0izk5Oopik0k3rwgbKUhkDiPO8hRkbXRPpixJYXuGdI1ikJIA
 osB1d6JzEcvzrxxtvyjn5Ho53dv8jg/8eDKE5h53GBfR/zhD8bWkZeraaQzGQNQb1tst
 26yw==
X-Gm-Message-State: AOAM532LWRNh6w0DTYWmapnKabOKLvBFYiYz+HQtpqRHeNnvx9Wzpcly
 uuF3PkqemjlT56paslrlMEMWGWOGLH3VV7LMzGE=
X-Google-Smtp-Source: ABdhPJxR/mY0zyyOdy5pTfvvBK9wfhm7HEPLMskAhNQRRa55D8gNKobdxAJBW2DFLSLs6pL1FsPrHEgcRJnW+EOwhpg=
X-Received: by 2002:a17:906:6c89:: with SMTP id
 s9mr711013ejr.551.1621970557255; 
 Tue, 25 May 2021 12:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1pXrnXpBfzZ9c-8MsYpoDCRt86F7yU=uLi52i96u8+SQA@mail.gmail.com>
 <f18ccab2-19ed-c6ce-3778-7364bab6c821@gmail.com>
In-Reply-To: <f18ccab2-19ed-c6ce-3778-7364bab6c821@gmail.com>
From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date: Tue, 25 May 2021 20:22:25 +0100
Message-ID: <CAEzXK1oRYtvKbX8AarYPuRJCNnNuiKo2Rrf6PpD7qtqKEgLPAA@mail.gmail.com>
Subject: Re: Regression: bisected: AMDGPU causes Kernel Bad page state OOPS
 starting with kernels 5.11.x, 5.12.x, 5.13-rc
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Daniel Vetter <daniel@ffwll.ch>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmtzIQoKSSd2ZSBqdXN0IGNyZWF0ZWQ6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9y
Zy9kcm0vYW1kLy0vaXNzdWVzLzE2MDYKClJlZ2FyZHMsCkx1aXMKCk9uIFR1ZSwgTWF5IDI1LCAy
MDIxIGF0IDM6MDIgUE0gQ2hyaXN0aWFuIEvDtm5pZwo8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBn
bWFpbC5jb20+IHdyb3RlOgo+Cj4gSGkgTHVpcywKPgo+IGFkZGluZyBEYW5pZWwgYXMgd2VsbC4K
Pgo+IGZpcnN0IG9mIGFsbCBjYW4geW91IHBsZWFzZSBjcmVhdGUgYSBidWcgcmVwb3J0IGZvciB0
aGlzIGhlcmU6Cj4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1
ZXMgVGhpcyB3YXkgd2UgY2FuIGJldHRlcgo+IHRyYWNrIGlzc3Vlcy4KPgo+IFRoZW4gd2hhdCBz
ZWVtcyB0byBoYXBwZW4gaXMgdGhhdCBzb21lYm9keSBpcyB1c2luZyB0aGUgVFRNIHBhZ2VzIGlu
IGEKPiB3YXkgdGhleSBhcmUgbm90IHN1cHBvc2VkIHRvIGJlIHVzZWQuCj4KPiBXZSBoYXZlIGZv
dW5kIGEgYnVuY2ggb2YgYnVncyBpbiBmb3IgZXhhbXBsZSBLVk0gc2luY2UgYWRkaW5nIHRoYXQK
PiBjb21taXQgYW5kIEkgaGF2ZSB0aGUgc3Ryb25nIHN1c3BpY2lvbiB0aGF0IGlzIGp1c3QgYW5v
dGhlciBvbmUgb2YgdGhvc2UuCj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPgo+IEFtIDI0LjA1
LjIxIHVtIDIxOjI1IHNjaHJpZWIgTHXDrXMgTWVuZGVzOgo+ID4gSGksCj4gPgo+ID4gQU1ER1BV
IHdhcyB3b3JraW5nIGZpbmUgb24gbXkgYXJtaGYgc3lzdGVtcyB3aXRoIDUuMTAueCBhbmQgcHJl
dmlvdXMKPiA+IGtlcm5lbHMgYW5kIGEgUlg1NTAgY2FyZC4gVW5mb3J0dW5hdGVseSBJIGhhdmUg
b25seSBub3cgdGVzdGVkIGtlcm5lbHMKPiA+IDUuMTEueCwgNS4xMi54IGFuZCA1LjEzLXJjIGFu
ZCBhbGwgYXJlIG5vdyBzaG93aW5nIHByb2JsZW1zIGxpa2UgdGhpcwo+ID4gb25lOgo+ID4gTWF5
IDEwIDIwOjIzOjE0IHBpY29sbyBrZXJuZWw6IFsgICAxOC45Njc2MjZdIEJVRzogQmFkIHBhZ2Ug
c3RhdGUgaW4KPiA+IHByb2Nlc3MgZ25vbWUtc2hlbGwgIHBmbjo3OGMwOAo+ID4gTWF5IDEwIDIw
OjIzOjE0IHBpY29sbyBrZXJuZWw6IFsgICAxOC45NzM3NTBdIHBhZ2U6Y2UyZTk3MTcgcmVmY291
bnQ6Mgo+ID4gbWFwY291bnQ6MSBtYXBwaW5nOjE3ZWRjZWQwIGluZGV4OjB4MTA5ZTkgcGZuOjB4
NzhjMDgKPiA+IE1heSAxMCAyMDoyMzoxNCBwaWNvbG8ga2VybmVsOiBbICAgMTguOTczNzYzXSBh
b3BzOjB4YzBlMTJmNTQgaW5vOjMwZAo+ID4KPiA+IEZ1bGwgS2VybmVsIGJvb3QgbG9nIGlzIGhl
cmUKPiA+IGh0dHBzOi8vcGFzdGViaW4uY29tL3BjdVVXWGJqCj4gPgo+ID4gSSd2ZSBiaXNlY3Rl
ZCBhbmQgdHJhY2VkIHRoZSBwcm9ibGVtIHRvIHRoaXMgY29tbWl0Ogo+ID4gZTkzYjJkYTk3OTll
NWNiOTc3NjA5NjlmM2UxZjAyYTViZGFjMjlmZSBpcyB0aGUgZmlyc3QgYmFkIGNvbW1pdAo+ID4g
Y29tbWl0IGU5M2IyZGE5Nzk5ZTVjYjk3NzYwOTY5ZjNlMWYwMmE1YmRhYzI5ZmUKPiA+IEF1dGhv
cjogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+ID4gRGF0ZTog
ICBTYXQgT2N0IDI0IDEzOjExOjI5IDIwMjAgKzAyMDAKPiA+Cj4gPiAgICAgIGRybS9hbWRncHU6
IHN3aXRjaCB0byBuZXcgYWxsb2NhdG9yIHYyCj4gPgo+ID4gICAgICBJdCBzaG91bGQgYmUgYWJs
ZSB0byBoYW5kbGUgYWxsIGNhc2VzIGhlcmUuCj4gPgo+ID4gICAgICB2MjogZml4IGRlYnVnZnMg
YXMgd2VsbAo+ID4KPiA+ICAgICAgU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+ID4gICAgICBSZXZpZXdlZC1ieTogRGF2ZSBBaXJsaWUg
PGFpcmxpZWRAcmVkaGF0LmNvbT4KPiA+ICAgICAgUmV2aWV3ZWQtYnk6IE1hZGhhdiBDaGF1aGFu
IDxtYWRoYXYuY2hhdWhhbkBhbWQuY29tPgo+ID4gICAgICBUZXN0ZWQtYnk6IEh1YW5nIFJ1aSA8
cmF5Lmh1YW5nQGFtZC5jb20+Cj4gPiAgICAgIExpbms6IGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVk
ZXNrdG9wLm9yZy9wYXRjaC8zOTcwODYvP3Nlcmllcz04MzA1MSZyZXY9MQo+ID4KPiA+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgNDUgKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCsp
LCAzMSBkZWxldGlvbnMoLSkKPiA+Cj4gPiBEZXRhaWxlZCBiaXNlY3QgbG9nIGlzIGhlcmU6Cj4g
PiBodHRwczovL2Jpbi5wcml2YWN5dG9vbHMuaW8vP2E4OGFlNjNmYjk1ZmExYzEjRXRyQzRxeEdX
am1neTVDM2RCelhGR3FqeGM3em5US1VMdHo0Y3hvWUZ4VzUKPiA+Cj4gPiBCZXN0IHJlZ2FyZHMs
Cj4gPiBMdcOtcyBNZW5kZXMKPiA+IEFwYXJhcGkgZGV2ZWxvcGVyCj4gPiBQaEQgU3R1ZGVudCAm
IFJlc2VhcmNoZXIKPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+ID4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiA+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
