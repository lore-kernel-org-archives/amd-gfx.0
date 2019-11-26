Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402ADC432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 15:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF9E20727
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 15:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF9E20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B18FA6E422;
	Tue, 26 Nov 2019 15:31:53 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E22CA6E422
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 15:31:51 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id n188so3840001wme.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 07:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c24+1DNjPcWIC0MiLXdDtbzMNdrrUZ0eht/NyiN4IxU=;
 b=Cgnr1wkTCtZLwa530nXugBX59vmz3Mamv4oFykBqc2yw3Pv3KEtig491LahHmBpTDF
 bFJuDQdaf3aeN2gm5LjHkOjsLnZV779M3yKkDnRtqRZJRdY4s3ELtLVx49w3uUWn8qIH
 tgL2AwMq73SdgwTzqikPSrHOFOS8d3ugzGkuzCRR/M/W95E6NeL7kifYhFUYmtcYSVoB
 8f84i3EDSjKL9aYwAfGDoOaJungyYi5fl0YbPl+4/b87I4NL83h/0v8PdNy0YShJwQtk
 MvpIc5IVryRUiqhEbkEpextMFu8cpVQv3OLSe+WxGsQGuj5YF1yg4zl3FiMbDhijpNVE
 nYVw==
X-Gm-Message-State: APjAAAUUG23AWdrTiVCHrmLu3ivXFoey0f1ja3X9f2s5jjvWZ/Z/lu3s
 t5MNWfbOz4T+Te8gdnSn6hhyi6O/XsvNWnB4Tcc=
X-Google-Smtp-Source: APXvYqzkXe+X0XUib6quFDO7rfiSaylagTK2BZOFZ7wF1C0ldC2ZhkCvBezA5ES/JVVM8SE7g+dWHXld+Y2y3IT6Vvs=
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr4909104wml.102.1574782310500; 
 Tue, 26 Nov 2019 07:31:50 -0800 (PST)
MIME-Version: 1.0
References: <20191122214353.582899-1-alexander.deucher@amd.com>
 <s5hblt30y3j.wl-tiwai@suse.de>
 <CADnq5_P7UA62+OfY+5q7re7na2V2Bc9_7XvZ3d5T9ovjMJVuLQ@mail.gmail.com>
 <s5hv9r6y9h6.wl-tiwai@suse.de>
In-Reply-To: <s5hv9r6y9h6.wl-tiwai@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Nov 2019 10:31:37 -0500
Message-ID:
 <CADnq5_NOfEHUC6nujDK_eCHuRYd2eA5XMj8vjnw77s_hoc_Pww@mail.gmail.com>
Subject: Re: [PATCH 0/4] add runtime pm support for AMD display audio
To: Takashi Iwai <tiwai@suse.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=c24+1DNjPcWIC0MiLXdDtbzMNdrrUZ0eht/NyiN4IxU=;
 b=QdUmBXx7qSfz+1BimuODpj9N411xZEoMjNRlGlSx5smgvWpbaCukCoS+UN3xmGQmXo
 aQp97/YNfrPHaj/1z9jBrYAv6IvnVPl4oDaawKpSXBhDdf7M9883EDS9TPKu5yQj0a6C
 L1z7ecXbGxnmTr3TS9tOg3XESTbhF6O2AmM8PyBPzN16qMDb8jo4VO0LEKLhmfePSFZT
 NnmHTqHNYgk70vYwDOBVPyKaqnd5UwOk6S4sJ3Z74FsLd3BkY/HlIVqHscJyRi7Tf5J5
 X6e1JnFq8EpPpEflnnI6HC3+yEHc+OVSf+v1y0IWTydj4BccSNBCt+3W+qO9Q2W+Gz6j
 +Idw==
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
Message-ID: <20191126153137.dN4icIJqqecoe8l0xNe5cZ2xedjUgAjoLGfZdgtyN48@z>

T24gVHVlLCBOb3YgMjYsIDIwMTkgYXQgOTo1MyBBTSBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2Uu
ZGU+IHdyb3RlOgo+Cj4gT24gTW9uLCAyNSBOb3YgMjAxOSAxNTo0MDo0MyArMDEwMCwKPiBBbGV4
IERldWNoZXIgd3JvdGU6Cj4gPgo+ID4gT24gU2F0LCBOb3YgMjMsIDIwMTkgYXQgMzo1NyBBTSBU
YWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBGcmksIDIy
IE5vdiAyMDE5IDIyOjQzOjQ5ICswMTAwLAo+ID4gPiBBbGV4IERldWNoZXIgd3JvdGU6Cj4gPiA+
ID4KPiA+ID4gPiBUaGVzZSBwYXRjaGVzIHdlcmUgb3JpZ2luYWxseSBwYXJ0IG9mIGEgbGFyZ2Vy
IHNldCBvZiBwYXRjaGVzCj4gPiA+ID4gdG8gZW5hYmxlZCBydW50aW1lIHBtIHN1cHBvcnQgb24g
dGhlIEdQVSBzaWRlWzFdLiAgSG93ZXZlciwgdGhlCj4gPiA+ID4gcGF0Y2hlcyBhcmUgdXNlZnVs
IG9uIHRoZWlyIG93biB0aGVyZSBhcmUgcmVhbGx5IG5vIGRlcGVuZGVuY2llcywKPiA+ID4gPiBv
dGhlciB0aGFuIHRoZSBmYWN0IHRoYXQgeW91IG5lZWQgYm90aCBmb3IgcnVudGltZSBwbSB0byBr
aWNrIGluCj4gPiA+ID4gb24gdGhlIEdQVSBzaWRlLiAgVGhlIEdQVSBzaWRlIHdpbGwgYmUgbGFu
ZGluZyBmb3IgNS42OyBJJ2QgbGlrZQo+ID4gPiA+IHRvIGxhbmQgdGhlIGF1ZGlvIHNpZGUgYXMg
d2VsbC4KPiA+ID4KPiA+ID4gRG8geW91IG1lYW4gdGhhdCB0aGVzZSBjYW4gZ28gaW50byA1LjUt
cmMxLCBvciB0aGV5IG5lZWQgd2FpdGluZyB1bnRpbAo+ID4gPiA1LjUtcmMxIHJlbGVhc2U/ICBJ
IGd1ZXNzIHRoZXNlIHdvbid0IGJyZWFrIHRoaW5ncyBldmVuIHdpdGhvdXQgdGhlCj4gPiA+IHJ1
bnRpbWUgUE0gc3VwcG9ydCBpbiBHUFUgc2lkZSwgYXMgdGhlIEVMRCBub3RpZmljYXRpb24gaXMg
ZG9uZSB2aWEKPiA+ID4gYXVkaW8gY29tcG9uZW50LCBzbyBJJ20gZmluZSB0byBhcHBseSB0aGVt
IGF0IGFueSB0aW1lLgo+ID4KPiA+IFVwIHRvIHlvdS4gIEknbSBvayB0byB3YWl0IGZvciB0aGUg
bmV4dCBtZXJnZSB3aW5kb3cgaWYgeW91J2QgcHJlZmVyLgo+Cj4gT0ssIEknbSBnb2luZyB0byBh
cHBseSB0aGVtIGZvciA1LjUtcmMxIGluY2x1c2lvbi4KPgo+IEJUVywgc2hvdWxkIEkgYXBwbHkg
dGhlc2UgcGF0Y2hlcyB3aXRoIHlvdXIgZ21haWwgYWRkcmVzcyBhcyBhdXRob3IKPiAod2hpbGUg
c2lnbi1vZmYgaXMgQU1EIGFkZHJlc3MpPyAgT3Igc2hvdWxkIEkgYWxpZ24gYm90aCB0byB5b3Vy
IEFNRAo+IGFkZHJlc3M/Cj4KPiBJdCdzIG5vdGhpbmcgd3JvbmcgdG8gaGF2ZSBkaWZmZXJlbnQg
YWRkcmVzc2VzIGluIHRoZSBjb21taXQsIGJ1dCBpZgo+IHVuaW50ZW5kZWQsIGl0J3MgYmV0dGVy
IHRvIGFsaWduIGJvdGguCgpJIGd1ZXNzIG15IEFNRCBhZGRyZXNzLiAgSSB1c3VhbGx5IHVzZSBt
eSBnbWFpbCBhZGRyZXNzIGZvciBzZW5kaW5nCnBhdGNoZXMgb3V0IG9mIGxhemluZXNzLgoKQWxl
eApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
