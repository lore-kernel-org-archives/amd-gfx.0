Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BBAC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 14:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4137F20679
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 14:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4137F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B7A89F08;
	Mon, 25 Nov 2019 14:40:59 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50DFF89F08
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 14:40:57 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id w9so18427948wrr.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 06:40:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fIPk6+sc6+DHaXBogqRqn5lIi0109Uk3TFBxqfJH0iI=;
 b=XrbTyF3jo1p28PAfyfxhmxB8PfEscg0YpqTr7MEnvwFzAqcWZxCOh2OuKIlqlYVtnu
 bCGpVD4YLP+dQ8S+Lvkcrqhtyv+9MUKM1LbSV/ytYkDvOfVpMk3zna9LeJ7kwsAgBmJa
 ImPpAwOlFSdawnKSZn7yJhEBdP1NqE5Kyfj8SWs3GS9a+vokmPC3KTXUcI/g9QHRTyg9
 /xJcTPy6IiR9nGOoHnoCLbNACsnMjKp/juqbT/HgNfwpbS7CVUK5l310XEta4lm4mhpe
 VS35uFkcIXpIfwZDmAHrU7PZEL98dM7i/gydolK10nMYrYeSljZNnVcJ4/3xaDIrbhlj
 bePw==
X-Gm-Message-State: APjAAAWNen9p2WTQv+/+ja6bgYSDLLVVwoxEFf2otaUk7o2D1qHmvzrB
 cSjC7qR3UHWyeYhlK0vANJXIfgMdgh0veayc9o+eMA==
X-Google-Smtp-Source: APXvYqwGTdPbsGs/MR2bADoZlyf2YajLiSZYf8hUrzJSKcf6PFW24wuihfHf5iLMnIZE+B5CIYtFP7AFviwNI9glG40=
X-Received: by 2002:adf:f010:: with SMTP id j16mr32903334wro.206.1574692855891; 
 Mon, 25 Nov 2019 06:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20191122214353.582899-1-alexander.deucher@amd.com>
 <s5hblt30y3j.wl-tiwai@suse.de>
In-Reply-To: <s5hblt30y3j.wl-tiwai@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Nov 2019 09:40:43 -0500
Message-ID:
 <CADnq5_P7UA62+OfY+5q7re7na2V2Bc9_7XvZ3d5T9ovjMJVuLQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] add runtime pm support for AMD display audio
To: Takashi Iwai <tiwai@suse.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=fIPk6+sc6+DHaXBogqRqn5lIi0109Uk3TFBxqfJH0iI=;
 b=t0FmP3OY6M1DHFGW40MnDmM/TrjIZKLsGw1mrDirYswh1+pgfH2YTE3mzo6LU2Anu4
 +yiIn8BfH9mwG8MRS9Ddg6S6NMidzYCBqNrQ5pOWpjDM9cVR5GLUqzu9xZP2xthjcTkn
 DZbhKwjuXCz67/XxsGWJz2rZuD/VLOCn2jo30s8ox+riWHPHeuZTnmhU97KeOEM1p3nh
 +OPduMt9ubfVOKt7omXG4BiEFnrmFlnuxKw5P3E6vVn0h9i/NiCZ76gGwHu+NcR2zNkq
 k1XbofAgnUg3YSqhrDNnZQkgqaULc4KuI5pSAmxcG+R2rxhrWbGucsW9xdKYi/NdBGi3
 KEBw==
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
Message-ID: <20191125144043.MpesV2T5IzfY8kAdJj6pZQNC7s0U3P17vhkfshE37Hs@z>

T24gU2F0LCBOb3YgMjMsIDIwMTkgYXQgMzo1NyBBTSBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2Uu
ZGU+IHdyb3RlOgo+Cj4gT24gRnJpLCAyMiBOb3YgMjAxOSAyMjo0Mzo0OSArMDEwMCwKPiBBbGV4
IERldWNoZXIgd3JvdGU6Cj4gPgo+ID4gVGhlc2UgcGF0Y2hlcyB3ZXJlIG9yaWdpbmFsbHkgcGFy
dCBvZiBhIGxhcmdlciBzZXQgb2YgcGF0Y2hlcwo+ID4gdG8gZW5hYmxlZCBydW50aW1lIHBtIHN1
cHBvcnQgb24gdGhlIEdQVSBzaWRlWzFdLiAgSG93ZXZlciwgdGhlCj4gPiBwYXRjaGVzIGFyZSB1
c2VmdWwgb24gdGhlaXIgb3duIHRoZXJlIGFyZSByZWFsbHkgbm8gZGVwZW5kZW5jaWVzLAo+ID4g
b3RoZXIgdGhhbiB0aGUgZmFjdCB0aGF0IHlvdSBuZWVkIGJvdGggZm9yIHJ1bnRpbWUgcG0gdG8g
a2ljayBpbgo+ID4gb24gdGhlIEdQVSBzaWRlLiAgVGhlIEdQVSBzaWRlIHdpbGwgYmUgbGFuZGlu
ZyBmb3IgNS42OyBJJ2QgbGlrZQo+ID4gdG8gbGFuZCB0aGUgYXVkaW8gc2lkZSBhcyB3ZWxsLgo+
Cj4gRG8geW91IG1lYW4gdGhhdCB0aGVzZSBjYW4gZ28gaW50byA1LjUtcmMxLCBvciB0aGV5IG5l
ZWQgd2FpdGluZyB1bnRpbAo+IDUuNS1yYzEgcmVsZWFzZT8gIEkgZ3Vlc3MgdGhlc2Ugd29uJ3Qg
YnJlYWsgdGhpbmdzIGV2ZW4gd2l0aG91dCB0aGUKPiBydW50aW1lIFBNIHN1cHBvcnQgaW4gR1BV
IHNpZGUsIGFzIHRoZSBFTEQgbm90aWZpY2F0aW9uIGlzIGRvbmUgdmlhCj4gYXVkaW8gY29tcG9u
ZW50LCBzbyBJJ20gZmluZSB0byBhcHBseSB0aGVtIGF0IGFueSB0aW1lLgoKVXAgdG8geW91LiAg
SSdtIG9rIHRvIHdhaXQgZm9yIHRoZSBuZXh0IG1lcmdlIHdpbmRvdyBpZiB5b3UnZCBwcmVmZXIu
CgpBbGV4Cgo+Cj4KPiB0aGFua3MsCj4KPiBUYWthc2hpCj4KPgo+ID4KPiA+IFRoYW5rcywKPiA+
Cj4gPiBBbGV4Cj4gPgo+ID4gWzFdOiBodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcv
c2VyaWVzLzY3ODg1Lwo+ID4KPiA+IEFsZXggRGV1Y2hlciAoNCk6Cj4gPiAgIEFMU0E6IGhkYS9o
ZG1pIC0gZml4IHZnYXN3aXRjaGVyb28gZGV0ZWN0aW9uIGZvciBBTUQKPiA+ICAgQUxTQTogaGRh
L2hkbWkgLSBBZGQgbmV3IHBjaSBpZHMgZm9yIEFNRCBHUFUgZGlzcGxheSBhdWRpbwo+ID4gICBB
TFNBOiBoZGEvaGRtaSAtIGVuYWJsZSBydW50aW1lIHBtIGZvciBuZXdlciBBTUQgZGlzcGxheSBh
dWRpbwo+ID4gICBBTFNBOiBoZGEvaGRtaSAtIGVuYWJsZSBhdXRvbWF0aWMgcnVudGltZSBwbSBm
b3IgQU1EIEhETUkgY29kZWNzIGJ5Cj4gPiAgICAgZGVmYXVsdAo+ID4KPiA+ICBzb3VuZC9wY2kv
aGRhL2hkYV9pbnRlbC5jICB8IDgwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tCj4gPiAgc291bmQvcGNpL2hkYS9wYXRjaF9oZG1pLmMgfCAgMSArCj4gPiAgMiBmaWxlcyBj
aGFuZ2VkLCA3NiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+ID4KPiA+IC0tCj4gPiAy
LjIzLjAKPiA+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
