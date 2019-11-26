Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7729C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 16:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C15207DD
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 16:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C15207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF356E316;
	Tue, 26 Nov 2019 16:20:12 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 989C96E316
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 16:20:10 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z3so23161167wru.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 08:20:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d6gImANnL33c7hbBYAxB5G3O32nw2QjY5pFiIk1/lXo=;
 b=S+r/XVFm0ywgoISVwqrvhEKJ+hc/l1ziJr1qDFH320uapl2mQ1qX6KdHBpAPKxILan
 rKl3RuGcLDDstMloMZ5vhB/iSjspqOwOpR5wDtfx59fXUWe3z4gqybNH35uhlYvqHzbl
 jHtu/jFN16uZjMskGF/4om9GQe+qr+nFMhN+reJSUywwx9GBYpl/AcAjWWuqbYzdUWC8
 GbxKbxow2OHp7Kvf2hpyHQGnI2ojv7Ioqfq17raChJdANTHGA0tG4DVgRUBi7l/Dkx5T
 U4n9Ufi0l8SyPoonaUfXO5oGHqncPYSLesSuXFA3P5uJdCZORjfHwYijYJvskq5tz+y0
 J/FA==
X-Gm-Message-State: APjAAAV7zzckwpx5eUCmBhLvhZANgYjPlukCePZDFqVPAXKmPFp5QsI2
 MUBOYIN4wTyBcwt4WGqfsuz79KZefJwF/ZoBX1PbXQ==
X-Google-Smtp-Source: APXvYqxLWJFNrR2i4vpczTUBUcLuuaEJnd06U1HNa2I6tT7VHf/pUv6FfYc1TsdJ7ikF0L6gPLxTFOfy9s6hsSfPz6I=
X-Received: by 2002:adf:f54c:: with SMTP id j12mr19992367wrp.40.1574785209086; 
 Tue, 26 Nov 2019 08:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20191122214353.582899-1-alexander.deucher@amd.com>
 <s5hblt30y3j.wl-tiwai@suse.de>
 <CADnq5_P7UA62+OfY+5q7re7na2V2Bc9_7XvZ3d5T9ovjMJVuLQ@mail.gmail.com>
 <s5hv9r6y9h6.wl-tiwai@suse.de>
 <CADnq5_NOfEHUC6nujDK_eCHuRYd2eA5XMj8vjnw77s_hoc_Pww@mail.gmail.com>
 <s5hh82qy6i4.wl-tiwai@suse.de>
In-Reply-To: <s5hh82qy6i4.wl-tiwai@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Nov 2019 11:19:57 -0500
Message-ID:
 <CADnq5_N3EhOk_TFMjW-gYxUp2WA_JnJnkQY_pu99P81nrDLidA@mail.gmail.com>
Subject: Re: [PATCH 0/4] add runtime pm support for AMD display audio
To: Takashi Iwai <tiwai@suse.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=d6gImANnL33c7hbBYAxB5G3O32nw2QjY5pFiIk1/lXo=;
 b=CJoXRd8KMueLuNzzRrr9FOwaxvji/T8hDo8Z1bG0ig4SSyjdCFVgNSnxTBa83D+XCT
 vZhYMt80Kue+iEfc7W13yiQf9PgAdmlMZwuZA+e28AvDBOcMO7p/gw2ky09jJ04QgdF+
 ka+DW99+zwt/0kpdBG+UcEqw50tdZB/dc7Zix3mrlbPtFyijgxHP61hHa1+PliF5GOWh
 HJhyRAiTky4pj52UeBBKUjUWBwGuTpa4dan0cxV6la1L2TwpBClXJFGUsLazbSXtvoFF
 btNaUWd5W2iHDSPgGEAmMfJ0WdcnGhDQG8YjPGIiEIpYDkSoGyPmYmmVESpL/Pwrsz4X
 CAhQ==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>, alsa-devel@alsa-project.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126161957.NX4KyxLzd7RuoOkOpsnexQgychN3DUUuokWDYhzx09c@z>

T24gVHVlLCBOb3YgMjYsIDIwMTkgYXQgMTA6NTggQU0gVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNl
LmRlPiB3cm90ZToKPgo+IE9uIFR1ZSwgMjYgTm92IDIwMTkgMTY6MzE6MzcgKzAxMDAsCj4gQWxl
eCBEZXVjaGVyIHdyb3RlOgo+ID4KPiA+IE9uIFR1ZSwgTm92IDI2LCAyMDE5IGF0IDk6NTMgQU0g
VGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gTW9uLCAy
NSBOb3YgMjAxOSAxNTo0MDo0MyArMDEwMCwKPiA+ID4gQWxleCBEZXVjaGVyIHdyb3RlOgo+ID4g
PiA+Cj4gPiA+ID4gT24gU2F0LCBOb3YgMjMsIDIwMTkgYXQgMzo1NyBBTSBUYWthc2hpIEl3YWkg
PHRpd2FpQHN1c2UuZGU+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IE9uIEZyaSwgMjIgTm92
IDIwMTkgMjI6NDM6NDkgKzAxMDAsCj4gPiA+ID4gPiBBbGV4IERldWNoZXIgd3JvdGU6Cj4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+IFRoZXNlIHBhdGNoZXMgd2VyZSBvcmlnaW5hbGx5IHBhcnQgb2Yg
YSBsYXJnZXIgc2V0IG9mIHBhdGNoZXMKPiA+ID4gPiA+ID4gdG8gZW5hYmxlZCBydW50aW1lIHBt
IHN1cHBvcnQgb24gdGhlIEdQVSBzaWRlWzFdLiAgSG93ZXZlciwgdGhlCj4gPiA+ID4gPiA+IHBh
dGNoZXMgYXJlIHVzZWZ1bCBvbiB0aGVpciBvd24gdGhlcmUgYXJlIHJlYWxseSBubyBkZXBlbmRl
bmNpZXMsCj4gPiA+ID4gPiA+IG90aGVyIHRoYW4gdGhlIGZhY3QgdGhhdCB5b3UgbmVlZCBib3Ro
IGZvciBydW50aW1lIHBtIHRvIGtpY2sgaW4KPiA+ID4gPiA+ID4gb24gdGhlIEdQVSBzaWRlLiAg
VGhlIEdQVSBzaWRlIHdpbGwgYmUgbGFuZGluZyBmb3IgNS42OyBJJ2QgbGlrZQo+ID4gPiA+ID4g
PiB0byBsYW5kIHRoZSBhdWRpbyBzaWRlIGFzIHdlbGwuCj4gPiA+ID4gPgo+ID4gPiA+ID4gRG8g
eW91IG1lYW4gdGhhdCB0aGVzZSBjYW4gZ28gaW50byA1LjUtcmMxLCBvciB0aGV5IG5lZWQgd2Fp
dGluZyB1bnRpbAo+ID4gPiA+ID4gNS41LXJjMSByZWxlYXNlPyAgSSBndWVzcyB0aGVzZSB3b24n
dCBicmVhayB0aGluZ3MgZXZlbiB3aXRob3V0IHRoZQo+ID4gPiA+ID4gcnVudGltZSBQTSBzdXBw
b3J0IGluIEdQVSBzaWRlLCBhcyB0aGUgRUxEIG5vdGlmaWNhdGlvbiBpcyBkb25lIHZpYQo+ID4g
PiA+ID4gYXVkaW8gY29tcG9uZW50LCBzbyBJJ20gZmluZSB0byBhcHBseSB0aGVtIGF0IGFueSB0
aW1lLgo+ID4gPiA+Cj4gPiA+ID4gVXAgdG8geW91LiAgSSdtIG9rIHRvIHdhaXQgZm9yIHRoZSBu
ZXh0IG1lcmdlIHdpbmRvdyBpZiB5b3UnZCBwcmVmZXIuCj4gPiA+Cj4gPiA+IE9LLCBJJ20gZ29p
bmcgdG8gYXBwbHkgdGhlbSBmb3IgNS41LXJjMSBpbmNsdXNpb24uCj4gPiA+Cj4gPiA+IEJUVywg
c2hvdWxkIEkgYXBwbHkgdGhlc2UgcGF0Y2hlcyB3aXRoIHlvdXIgZ21haWwgYWRkcmVzcyBhcyBh
dXRob3IKPiA+ID4gKHdoaWxlIHNpZ24tb2ZmIGlzIEFNRCBhZGRyZXNzKT8gIE9yIHNob3VsZCBJ
IGFsaWduIGJvdGggdG8geW91ciBBTUQKPiA+ID4gYWRkcmVzcz8KPiA+ID4KPiA+ID4gSXQncyBu
b3RoaW5nIHdyb25nIHRvIGhhdmUgZGlmZmVyZW50IGFkZHJlc3NlcyBpbiB0aGUgY29tbWl0LCBi
dXQgaWYKPiA+ID4gdW5pbnRlbmRlZCwgaXQncyBiZXR0ZXIgdG8gYWxpZ24gYm90aC4KPiA+Cj4g
PiBJIGd1ZXNzIG15IEFNRCBhZGRyZXNzLiAgSSB1c3VhbGx5IHVzZSBteSBnbWFpbCBhZGRyZXNz
IGZvciBzZW5kaW5nCj4gPiBwYXRjaGVzIG91dCBvZiBsYXppbmVzcy4KPgo+IE9LLCBub3cgbWVy
Z2VkIGFsbCBmb3VyIHBhdGNoZXMuCgpUaGFua3MhCgpBbGV4Cgo+Cj4gdGhhbmtzLAo+Cj4gVGFr
YXNoaQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
