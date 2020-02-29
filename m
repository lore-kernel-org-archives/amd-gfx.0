Return-Path: <SRS0=TA90=4R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3748C3F2CD
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Feb 2020 21:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E16222C3
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Feb 2020 21:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jlekstrand-net.20150623.gappssmtp.com header.i=@jlekstrand-net.20150623.gappssmtp.com header.b="ad9wtX6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E16222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jlekstrand.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2006F6E3D3;
	Sat, 29 Feb 2020 21:54:27 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B296E3CE
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Feb 2020 21:54:26 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id m13so8157215edb.6
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Feb 2020 13:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jlekstrand-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AMNxI2RKOwUcPazieul3Yy+ClQQ96T1AC7oQYhKq8LU=;
 b=ad9wtX6s4Rst8oGEGje9rkIp2jhQeFlUFKgdq2WuNz39LUJHV+sffJPpITR0VuqW7d
 T2OjLFRCiS9BshJzSSpYWywM1hW9zTUuI5BPJSJN3dl2TfZ677ZDusdpQhfTR2X5p66H
 6w3gpG4CGJr+gxVN5o0tdI+tsELJ4yKxjTDeMj6CxAx1sH7RFm4q2rmwqPO8xwxUdLjI
 IiUPVkmkfW/Kx26gczi/1Bbqm4w6aqzeJZtfvJk9VWdzr4XrW7Nj8ye8BeoueqT5+KeM
 a4Kz7ouANKNIqJQHPjZbqVfTmEr0GW231jT+D9aQAmb7kGIxeSNfwKCrTlFhHrT2pYh5
 MfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AMNxI2RKOwUcPazieul3Yy+ClQQ96T1AC7oQYhKq8LU=;
 b=DjRFWM33WHZ8UNgP7RV0z24PlyDeQtNCtr//RbwUF+23UG6S21e9ZXVPclF9H2Z/Ba
 a96jwm/t4Y4syZbupY8pEZ4iZL33vDEQMlys09tyffoZmn57NoZw5ZeCRWmK1i6xJE6a
 GceClOrt/WIP5wBsrLlKzgB7Wy7S7ny/VORSQFi72btSMDjVQv8QhlQWb9G21eqIAmrV
 JVwejDNFPd4zrOUNeatYAu0xNorNomROOU4XGUwUwvlCP6jbLugwRUCs2tztynOHFvt4
 zFkvY7EjciL7f+3VbydQvGAM53gRXMSFHAOGLc7NFlDnDNQkfc90F3cNMiO2Y+amAGc1
 TUjw==
X-Gm-Message-State: APjAAAWSvHmfeI8ADAlwixQ1yPVcFJygE90VnZ6o+eatDespuU0hXkLo
 uUSsqp1Td7i1XPrAIQfN0doYE7HlxdiZyeQM8t58XA==
X-Google-Smtp-Source: APXvYqwopTVexk7jLz+WFfE8EvkPjw8nA8+eVm2GLLuN9YHJ6uBTPTX058jhQBVEsmj7fIlIxY+jW/0v62K6lAEinZk=
X-Received: by 2002:a17:906:489:: with SMTP id f9mr9151025eja.27.1583013264636; 
 Sat, 29 Feb 2020 13:54:24 -0800 (PST)
MIME-Version: 1.0
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAPM=9txcGPvFdSzMtYZXyqLKnWyacSMuHdoXdV63M53fLFVFpw@mail.gmail.com>
 <b398161ff7d0268454413058dc6c194cf93f5990.camel@collabora.com>
 <ece8ebe3-40ec-2457-02da-4fef19cbe8f6@intel.com>
 <6d2ec570f957b4504fb70e0b1f0632712a99dc0c.camel@collabora.com>
 <CAPj87rO7BuKQj2Kei3T7RdkFq5=TiuShBvtrPU2sn0iqMfXSTg@mail.gmail.com>
 <59f4ea1f13a9a9d37f7801b93061b4ae7dd595e2.camel@gmail.com>
 <d0ef47e45c83b342494e6781b808b4831a008836.camel@ndufresne.ca>
 <d9dca12759fd6a549dc4cd71b5f210a4dced01cd.camel@gmail.com>
In-Reply-To: <d9dca12759fd6a549dc4cd71b5f210a4dced01cd.camel@gmail.com>
From: Jason Ekstrand <jason@jlekstrand.net>
Date: Sat, 29 Feb 2020 15:54:13 -0600
Message-ID: <CAOFGe96WqRTagf=Lhp6j9aMnB6hxwog7t93t=4r6QE_4f+HpeQ@mail.gmail.com>
Subject: Re: [Mesa-dev] [Intel-gfx] gitlab.fd.o financial situation and impact
 on services
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
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
Cc: Erik Faye-Lund <erik.faye-lund@collabora.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nicolas Dufresne <nicolas@ndufresne.ca>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>,
 Discussion of the development of and with GStreamer
 <gstreamer-devel@lists.freedesktop.org>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>,
 Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
 Daniel Stone <daniel@fooishbar.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gU2F0LCBGZWIgMjksIDIwMjAgYXQgMzo0NyBQTSBUaW11ciBLcmlzdMOzZiA8dGltdXIua3Jp
c3RvZkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gT24gU2F0LCAyMDIwLTAyLTI5IGF0IDE0OjQ2IC0w
NTAwLCBOaWNvbGFzIER1ZnJlc25lIHdyb3RlOgo+ID4gPgo+ID4gPiAxLiBJIHRoaW5rIHdlIHNo
b3VsZCBjb21wbGV0ZWx5IGRpc2FibGUgcnVubmluZyB0aGUgQ0kgb24gTVJzIHdoaWNoCj4gPiA+
IGFyZQo+ID4gPiBtYXJrZWQgV0lQLiBTcGVha2luZyBmcm9tIHBlcnNvbmFsIGV4cGVyaWVuY2Us
IEkgdXN1YWxseSBtYWtlIGEgbG90Cj4gPiA+IG9mCj4gPiA+IGNoYW5nZXMgdG8gbXkgTVJzIGJl
Zm9yZSB0aGV5IGFyZSBtZXJnZWQsIHNvIGl0IGlzIGEgd2FzdGUgb2YgQ0kKPiA+ID4gcmVzb3Vy
Y2VzLgo+ID4KPiA+IEluIHRoZSBtZWFuIHRpbWUsIHlvdSBjYW4gaGVscCBieSB0YWtpbmcgdGhl
IGhhYml0IHRvIHVzZToKPiA+Cj4gPiAgIGdpdCBwdXNoIC1vIGNpLnNraXAKPgo+IFRoYW5rcyBm
b3IgdGhlIGFkdmljZSwgSSB3YXNuJ3QgYXdhcmUgc3VjaCBhbiBvcHRpb24gZXhpc3RzLiBEb2Vz
IHRoaXMKPiBhbHNvIHdvcmsgb24gdGhlIG1lc2EgZ2l0bGFiIG9yIGlzIHRoaXMgYSBHU3RyZWFt
ZXIgb25seSB0aGluZz8KCk1lc2EgaXMgYWxyZWFkeSBzZXQgdXAgc28gdGhhdCBpdCBvbmx5IHJ1
bnMgb24gTVJzIGFuZCBicmFuY2hlcyBuYW1lZApjaS0qIChvciBtYXliZSBpdCdzIGNpLyo7IEkg
Y2FuJ3QgcmVtZW1iZXIpLgoKPiBIb3cgaGFyZCB3b3VsZCBpdCBiZSB0byBtYWtlIHRoaXMgdGhl
IGRlZmF1bHQ/CgpJIHN0cm9uZ2x5IHN1Z2dlc3QgbG9va2luZyBhdCBob3cgTWVzYSBkb2VzIGl0
IGFuZCBkb2luZyB0aGF0IGluCkdTdHJlYW1lciBpZiB5b3UgY2FuLiAgSXQgc2VlbXMgdG8gd29y
ayBwcmV0dHkgd2VsbCBpbiBNZXNhLgoKLS1KYXNvbgoKCj4gPiBUaGF0J3MgYSBtdWNoIG1vcmUg
ZGlmZmljdWx0IGdvYWwgdGhlbiBpdCBsb29rcyBsaWtlLiBMZXQgZWFjaAo+ID4gcHJvamVjdHMK
PiA+IG1hbmFnZSB0aGVpciBDSSBncmFwaCBhbmQgY29udGVudCwgYXMgZWFjaCBjYXNlIGlzIHVu
aXF1ZS4gUnVubmluZwo+ID4gbW9yZQo+ID4gdGVzdHMsIG9yIGJ1aWxkaW5nIG1vcmUgY29kZSBp
c24ndCB0aGUgbWFpbiBpc3N1ZSBhcyB0aGUgQ1BVIHRpbWUgaXMKPiA+IG1vc3RseSBzcG9uc29y
ZWQuIFRoZSBkYXRhIHRyYW5zZmVycyBiZXR3ZWVuIHRoZSBjbG91ZCBvZiBnaXRsYWIgYW5kCj4g
PiB0aGUgcnVubmVycyAod2hpY2ggYXJlIGV4dGVybmFsKSwgYWxvbmcgdG8gc2VuZGluZyBPUyBp
bWFnZSB0byBMYXZhCj4gPiBsYWJzIGlzIHdoYXQgaXMgbGlrZWx5IHRoZSBtb3N0IGV4cGVuc2l2
ZS4KPiA+Cj4gPiBBcyBpdCB3YXMgYWxyZWFkeSBtZW50aW9uIGluIHRoZSB0aHJlYWQsIHdoYXQg
d2UgYXJlIG1pc3Npbmcgbm93LCBhbmQKPiA+IGJlaW5nIHdvcmtlZCBvbiwgaXMgcGVyIGdyb3Vw
L3Byb2plY3Qgc3RhdGlzdGljcyB0aGF0IGdpdmUgdXMgdGhlCj4gPiBob3RzcG90IHNvIHdlIGNh
biBiZXR0ZXIgdGFyZ2V0IHRoZSBvcHRpbWl6YXRpb24gd29yay4KPgo+IFllcywgd291bGQgYmUg
bmljZSB0byBrbm93IHdoYXQgdGhlIGhvdHNwb3QgaXMsIGluZGVlZC4KPgo+IEFzIGZhciBhcyBJ
IHVuZGVyc3RhbmQsIHRoZSBwcm9ibGVtIGlzIG5vdCBDSSBpdHNlbGYsIGJ1dCB0aGUgYmFuZHdp
ZHRoCj4gbmVlZGVkIGJ5IHRoZSBidWlsZCBhcnRpZmFjdHMsIHJpZ2h0PyBXb3VsZCBpdCBiZSBw
b3NzaWJsZSB0byBub3QgaG9zdAo+IHRoZSBidWlsZCBhcnRpZmFjdHMgb24gdGhlIGdpdGxhYiwg
YnV0IHJhdGhlciBvbmx5IHRoZSBwbGFjZSB3aGVyZSB0aGUKPiBidWlsZCBhY3R1YWxseSBoYXBw
ZW5lZD8gT3IgYXQgbGVhc3QsIG9ubHkgdHJhbnNmZXIgdGhlIGJ1aWxkIGFydGlmYWN0cwo+IG9u
LWRlbWFuZD8KPgo+IEknbSBub3QgZXhhY3RseSBmYW1pbGlhciB3aXRoIGhvdyB0aGUgc3lzdGVt
IHdvcmtzLCBzbyBzb3JyeSBpZiB0aGlzIGlzCj4gYSBzaWxseSBxdWVzdGlvbi4KPgo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbWVzYS1kZXYgbWFp
bGluZyBsaXN0Cj4gbWVzYS1kZXZAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9tZXNhLWRldgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
