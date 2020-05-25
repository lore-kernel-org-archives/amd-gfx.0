Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472A4C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 01:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BD52075F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 01:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPQ/Zdv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BD52075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D22E389C53;
	Mon, 25 May 2020 01:30:00 +0000 (UTC)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E00389C53
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 01:29:59 +0000 (UTC)
Received: by mail-oi1-x244.google.com with SMTP id s198so14857859oie.6
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 May 2020 18:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wVlf0mG+Xnn8UVGbofs2RjRmKwBQWexzS+b27HUebsk=;
 b=EPQ/Zdv3ivS0id7t7oEgct0o9zapBgo4m2rnV/IkEMHjAs8tJuet+ZfUj87fXsYIP8
 XTV+xasEuz436cZCSjbK6f53GaiiEO+t7lMLnUsoDHBKJQgNWMKewmlQRPg6PE59kicl
 9zAaYDHwn9Uxg+uE/lLGNl/+u2GAnRXzPBVH5Vx+T7np7yvzD6PqrfUHKs68UdHG5hxI
 oYzWbIUSkXZatyNUf0d+LW5w3dcfjy2NrEb4ftfQjN7sKWiNSNPw7/eHUQwtBcLXS1U7
 6PBPcjx7riv/uKEvXWq2WOmqxozyhsBzQOwlN2eRiWEX4AphAU+FxiwU95hbettTHwFi
 vorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wVlf0mG+Xnn8UVGbofs2RjRmKwBQWexzS+b27HUebsk=;
 b=gAu8kx6poEBqKNICRuxTTJnR7eB08pftj4AhLe2OhrHURPxOfKkx4AlZLNGhXASy2G
 W4ReR9unI++beZETlRPXB3gemzCnz9bKC+Fx9GMg6P2peqbhXNeX4U2vXuKo95ytVY/h
 FtI0yNd5MaecfhJl8ciiCLIWkz76lUReU2K2lpHa8d/zAV6Ai6XwH1LsJs8ElUB/ipLN
 VHbTJtXvxPcYbCBSJ5HqyhOW7kG490h+6IhCHWyAG+tvcx9HoqZf8FVha0f0P21IXNcj
 5YRbAR9jIcfpms29j6BjMn9Y189NpDMJEj1Q4If5eua3Z68ep0RQA4IsY7gqU+4IOff8
 CkYQ==
X-Gm-Message-State: AOAM532PxtBFOpKPOQFeZW9cGMA/dMxA6qPqG/pbDGhPHg7Lr8h+5A7w
 WUbwcuQn+IoMLE01du/+iW6BT4/p7BGrcYKtcDw=
X-Google-Smtp-Source: ABdhPJzXnpDtivL2D417IBVd7QzaU/X+2o+d1oVW59R1Q7Kr4q2MRmI2NBYJGLgXvR3moCn814BLHEev2nDexFNuYXw=
X-Received: by 2002:a54:418f:: with SMTP id 15mr10000766oiy.109.1590370198434; 
 Sun, 24 May 2020 18:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAEOHGOm=g_VGa5939Qi_HEXAfuUKuy3tXURx9TKg+n==dUDqPQ@mail.gmail.com>
 <CAEOHGOkbu5jy_1_bUD4H0U89YEc_9zOxsSdyZqmtqZNsdOyDkg@mail.gmail.com>
 <CAEOHGOkRYXZWN-20VagBEFFywRT=26xphP3JQeQD4AJuxxzg+Q@mail.gmail.com>
 <CADnq5_Nc+eoCKsQrHA-u0d7trv=MM=5iKv5G1R3TMCyot40OjA@mail.gmail.com>
 <CAEOHGOk-YO_B3gS7WayrBEAO4oxrUAGtR0o9ZzW8ehOypuc1YA@mail.gmail.com>
 <CADnq5_M2R93S6aQn8XtrC_JdHhB=ajC17D780koNvdnDFbWCpA@mail.gmail.com>
 <CAEOHGO=Tgook7i5R5Ucxn3Pg4ovZe+Fak5rntZ2P+UuwDJ+-Vg@mail.gmail.com>
 <CADnq5_Mef-FCri1_wriYgvmnkTNQpxaUfba9_hLSB-yVQHU9cQ@mail.gmail.com>
 <CAEOHGOm+ooti4JX6OD2zd7rOxbAVn1yQ22TwgS0hmiy8Ssf-Kg@mail.gmail.com>
 <CADnq5_O-u_dX84-=y8itZzsrxGLtboBaT5jPY4izzqSjwVtiqg@mail.gmail.com>
 <CAEOHGOmoyyiOSmTPP21mhavJ-qzgPSnWiLb9VFz4z9aSwao3Aw@mail.gmail.com>
 <CADnq5_P9pBvnHjeTDdcocQi1HnK4d6h-a+gsjpgfZ_zEjpDH3g@mail.gmail.com>
 <CAEOHGOmSDy2LRzexvUwqc8R4D5XWHmOO_r+9uh7To6BaH6ik6g@mail.gmail.com>
 <CAEOHGOkFBatRPaskkYv_c84sf-opOFTAi=j=NPj-qOePtdXYXg@mail.gmail.com>
 <dc6af43c-07bb-e334-79f7-80b4cb5135a8@daenzer.net>
 <CAEOHGOnPZgMbD_Rr75x6wnCS2TbeNWvZdTWpv0o57Tbo=2eYzQ@mail.gmail.com>
In-Reply-To: <CAEOHGOnPZgMbD_Rr75x6wnCS2TbeNWvZdTWpv0o57Tbo=2eYzQ@mail.gmail.com>
From: Javad Karabi <karabijavad@gmail.com>
Date: Sun, 24 May 2020 20:29:47 -0500
Message-ID: <CAEOHGOmGYwWriaH1vMhUXOw4vfgZ1m1K8B33ERdYo5pQQ9VBFw@mail.gmail.com>
Subject: Re: slow rx 5600 xt fps
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

d293LCBpIHRvdGFsbHkganVzdCByZWFsaXplZCB0aGF0IHRoaXMgaXMgd2hhdCB5b3UgbWVhbnQg
YnkgdGFsa2luZwphYm91dCBwcmltYXJ5IGdwdSwgZWFybHkgb24gaW4gdGhpcyBlbWFpbCBjaGFp
bi4KaXZlIGNvbWUgZnVsbCBjaXJjbGUhIHlvdSB3ZXJlIHRvdGFsbHkgcmlnaHQgYW5kIGV2ZW4g
a25ldyBleGFjdGx5CndoYXQgdGhlIGVhc2llc3QgY2hhbmdlIHdhcyBsb2wuCm15IGJhZCEKCk9u
IFN1biwgTWF5IDI0LCAyMDIwIGF0IDg6MDMgUE0gSmF2YWQgS2FyYWJpIDxrYXJhYmlqYXZhZEBn
bWFpbC5jb20+IHdyb3RlOgo+Cj4gTWljaGVsLCBhaCBteSBiYWQhIHRoYW5rIHlvdS4gc29ycnks
IHRob3VnaHQgaXQgd2FzIG11dHRlcgo+Cj4gYWxzbywgb25lIG90aGVyIHRoaW5nLiBzbyBpIGhh
dmUgYmVlbiBtZXNzaW5nIGFyb3VuZCB3aXRoIGFsbCB0eXBlcyBvZgo+IHhvcmcgY29uZmlndXJh
dGlvbiBibGFoIGJsYWggYmxhaCwgYnV0IGkganVzdCBoYWQgYW4gZXBpcGhhbnksIGFuZCBpdAo+
IHdvcmtzIQo+Cj4gc28sIGFsbCBpIGV2ZXIgbmVlZGVkIHRvIGRvIHdhcyBhZGQgT3B0aW9uICJQ
cmltYXJ5R3B1IiAidHJ1ZSIgdG8KPiAvdXNyL3NoYXJlL1gxMS94b3JnLmNvbmYuZC8xMC1hbWRn
cHUuY29uZgo+IHdpdGggdGhhdCBfb25lXyBjaGFuZ2UsIGkgZG9udCBuZWVkIGFueSBvdGhlciB4
b3JnIGNvbmZpZ3MsIGFuZCB3aGVuIGkKPiBib290IHdpdGhvdXQgdGhlIGFtZGdwdSwgaXQgc2hv
dWxkIHdvcmsganVzdCBmaW5lLCBhbmQgd2hlbiB0aGUgYW1kZ3B1Cj4gaXMgcHJlc2VudCBpdCB3
aWxsIGF1dG9tYXRpY2FsbHkgYmVjb21lIHRoZSBwcmltYXJ5IGR1ZSB0byB0aGUKPiBvdXRwdXRj
bGFzcyBtYXRjaGluZyBpdCEKPgo+IHRoYXQgUHJpbWFyeUdwdSBiZWluZyBhZGRlZCB3YXMgZXhh
Y3RseSB0aGUgdGhpbmcuIGltIHNvIGdsYWQgaXQgd29ya3Mgbm93Cj4KPiBTbywgdGhlc2UgYXJl
IG15IHRob3VnaHRzOgo+IHRoZXJlcyBubyB0ZWxsaW5nIHdoYXQgb3RoZXIgZ3JhcGhpY3MgY2Fy
ZHMgbWlnaHQgYmUgaW5zdGFsbGVkLCBzbwo+IHhvcmcgZGVmYXVsdHMgdG8gdXNpbmcgd2hhdGV2
ZXIgbGludXggd2FzIGJvb3RlZCB3aXRoIGFzIHRoZSBwcmltYXJ5LAo+IGluIG15IGNhc2UgdGhl
IGludGVsIGdyYXBoaWNzIGkgZ3Vlc3MuCj4KPiBub3csIG9uIGEgcmVndWxhciBkZXNrdG9wLCB0
aGF0cyB0b3RhbGx5IGZpbmUgYmVjYXVzZSB0aGUgZ3JhcGhpY3MKPiBjYXJkIGhhcyBkaXJlY3Qg
YWNjZXNzIHRvIHJhbSBtdWNoIGVhc2llciwgYW5kIHdpdGggZmFuY3kgdGhpbmdzIGxpa2UKPiBk
bWEgYW5kIHdoYXRub3QsIGl0cyBubyBwcm9ibGVtIGF0IGFsbCBmb3IgYSBncmFwaGljcyBjYXJk
IHRvIGFjdCBhcyBhCj4gcmVuZGVyIG9mZmxvYWQgc2luY2UgdGhlIGNhcmQgIGNhbiBzaW1wbHkg
ZG1hIHRoZSByZXN1bHRzIGludG8gbWFpbgo+IG1lbW9yeSBvciBzb21ldGhpbmcKPgo+IGJ1dCB3
aGVuIHlvdSBnb3QgdGhlIGdyYXBoaWNzIGNhcmQgaW4gYW4gZUdQVSwgYWNyb3NzIGEgdGh1bmRl
cmJvbHQKPiBjb25uZWN0aW9uLCBpdCBlc3NlbnRpYWxseSBiZWNhdXNlIE5VTUEsIHNpbmNlIHRo
YXQgbWVtb3J5IGFjY2VzcyBoYXMKPiB3YXkgbW9yZSBsYXRlbmN5Cj4KPiBzbyB0aGUgZmFjdCB0
aGF0IHRoZSBkZWJpYW4gcGFja2FnZSBpc250IHNheWluZyAiUHJpbWFyeUdwdSIgInRydWUiIGkK
PiBndWVzcyBtYWtlcyBzZW5zZSwgYmVjdWFzZSB3aG8ga25vd3Mgd2hhdCB5b3Ugd2FudCB0aGUg
cHJpbWFyeSB0byBiZS4KPgo+IGJ1dCB5ZWEsIGp1c3QgdGhvdWdodCB5YWxsIG1pZ2h0IGJlIGlu
dGVyZXN0ZWQgdG8ga25vdyB0aGF0IHRoZQo+IHNvbHV0aW9uIGZvciBydW5uaW5nIGFuIGVncHUg
aW4gbGludXggaXMgc2ltcGx5IHRvIGFkZCAiUHJpbWFyeUdwdSIgdG8KPiB0aGUgb3V0cHV0IGNs
YXNzIHRoYXQgbWF0Y2hlcyB5b3VyIGdwdS4KPiBhbmQgd2hlbiB5b3UgYm9vdCB3aXRob3V0IHRo
ZSBncHUsIHRoZSBvdXRwdXRjbGFzcyB3b250IG1hdGNoLCBzbyBpdAo+IHdpbGwgZGVmYXVsdCB0
byBub3JtYWwgYmVoYXZpb3IKPgo+IGFsc28sIGxldHMgc2F5IHlvdSBoYXZlIE4gbnVtYmVyIG9m
IGdwdXMsIGVhY2ggb2Ygd2hpY2ggbWF5IG9yIG1heSBub3QKPiBiZSBwcmVzZW50LiBmcm9tIHdo
YXQgaSB1bmRlcnN0YW5kLCB5b3UgY2FuIHN0aWxsIGVuZm9yY2UgYSBsZXZlbCBvZgo+IHByZWNl
ZGVuY2UgYWJvdXQgcGlja2luZyB3aGljaCBvbmUgdG8gYmUgcHJpbWFyeSBsaWtlIHRoaXM6Cj4K
PiAiSWYgbXVsdGlwbGUgb3V0cHV0IGRldmljZXMgbWF0Y2ggYW4gT3V0cHV0Q2xhc3Mgc2VjdGlv
biB3aXRoIHRoZQo+IFByaW1hcnlHUFUgb3B0aW9uIHNldCwgdGhlIGZpcnN0IG9uZSBlbnVtZXJh
dGVkIGJlY29tZXMgdGhlIHByaW1hcnkKPiBHUFUuIgo+Cj4gc28gb25lIGNhbiBzaW1wbHkgZGVm
aW5lIGEgZmlsZSBpbiB3aGljaCB5b3UgZGVmaW5lIE4gbnVtYmVyIG9mCj4gb3V0cHV0Y2xhc3Nl
cywgaW4gb3JkZXIgZnJvbSBoaWdoZXN0IHRvIGxvd2VzdCBwcmVjZWRlbmNlIGZvciBiZWluZwo+
IHRoZSBwcmltYXJ5IGdwdSwgdGhlbiBzaW1wbHkgcHV0IE9wdGlvbiAiUHJpbWFyeUdwdSIgInRy
dWUiCj4KPiBpIHJlYWxpemUgdGhpcyBpc250IGFuIHhvcmcgbGlzdCwgYW5kIGRvZXNudCBoYXZl
IG11Y2ggdG8gZG8gd2l0aAo+IGFtZGdwdSwgYnV0IHdvdWxkIGxvdmUgdG8gaGVhciB5YWxscyB0
aG91Z2h0cy4gdGhlcmVzIGFsb3Qgb2YKPiBkaXNjdXNzaW9uIG9ubGluZSBpbiBmb3J1bXMgYW5k
IHdoYXRub3QsIGFuZCBwZW9wbGUgY29taW5nIHVwIHdpdGggYWxsCj4ga2luZHMgb2YgImF1dG9t
YXRpYyB4b3JnIGNvbmZpZ3VyYXRpb24gc3RhcnR1cCBzY3JpcHRzIiBhbmQgc3R1ZmYgdG8KPiBt
YW5hZ2UgZWdwdXMsIGJ1dCBpZiBteSBoeXBvdGhlc2lzIGlzIGNvcnJlY3QsIHRoaXMgaXMgdGhl
IGNsZWFuZXN0LAo+IHNpbXBsZXN0IGFuZCBtb3N0IGVsZWdhbnQgc29sdXRpb24KPgo+Cj4gT24g
U2F0LCBNYXkgMjMsIDIwMjAgYXQgNToxNyBBTSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56
ZXIubmV0PiB3cm90ZToKPiA+Cj4gPiBPbiAyMDIwLTA1LTIzIDEyOjQ4IGEubS4sIEphdmFkIEth
cmFiaSB3cm90ZToKPiA+ID4KPiA+ID4gYWxzbywgdGhlIHdob2xlIHRoaW5nIGFib3V0ICJtb25p
dG9yIHVwZGF0aW5nIG9uY2UgZXZlcnkgMyBzZWNvbmRzIgo+ID4gPiB3aGVuIGkgY2xvc2UgdGhl
IGxpZCBpcyBiZWNhdXNlIG11dHRlciB3aWxsIGdvIGRvd24gdG8gMWZwcyB3aGVuIGl0Cj4gPiA+
IGRldGVjdHMgdGhhdCB0aGUgbGlkIGlzIGNsb3NlZC4KPiA+Cj4gPiBYb3JnJ3MgUHJlc2VudCBl
eHRlbnNpb24gY29kZSBlbmRzIHVwIGRvaW5nIHRoYXQgKGJlY2F1c2UgaXQgaGFzIG5vCj4gPiBz
dXBwb3J0IGZvciBzZWNvbmRhcnkgR1BVcyksIG5vdCBtdXR0ZXIuCj4gPgo+ID4KPiA+IC0tCj4g
PiBFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
aHR0cHM6Ly9yZWRoYXQuY29tCj4gPiBMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
