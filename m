Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1245C2BA17
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 18:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5F020678
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 18:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuLuqZrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5F020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 453096E479;
	Mon,  6 Apr 2020 18:00:54 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8CEE6E478;
 Mon,  6 Apr 2020 18:00:52 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id c7so648169edl.2;
 Mon, 06 Apr 2020 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MuT6OFSpOq6D2Htl1FsDrWBioWDz7LCLM+O4dnJpIbI=;
 b=ZuLuqZrzQfEtr+L+5Dp2hTbGeTwEKhfDg9qzhFcpCTKyPKsbYBu6o/gNVszErlf+vF
 RO6NGKIhho414A1HiFnHy2kMKfocca+i9uMM8KAwYDC5uvPI7Hl8zW3fItt+/nuoYEjy
 kVudDL/Vx5Fu4PGz706j4bLBZyT3eoy0VJc8amlGQP+wj2G59sQyd4ynLIBYTDUEKCbN
 y1fyaa91yuuvGrXMsrqYaPp5F8QLCrdSeaqBU9ZGDaMVdlW0cUXZp8WE5vv19wUnshWa
 Fm4aUPSTGUBlXF8f23GN2e9Rm3PsYMVy3+rEhiN9CGSSlF0rFogHevm7dmjn9i9cJGNh
 E7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MuT6OFSpOq6D2Htl1FsDrWBioWDz7LCLM+O4dnJpIbI=;
 b=b4MWl5bLzNM0SeFplWpnve6qOkmCbUqEFcL1J65PCqqSFbTInsJN+vCerRScp22ctF
 PjE/9rPRPlsmbMk5gOYv9ljupKM6ylL8UBIqdCtswERG3LDRdIll4rXO/dX8eE0d2n18
 zav8sOMOZuM4e7iO1M5bHL1TLdKm/Iao/IY6BdgUavN/exSlUsU3/VD8FWdtaYlWsGA8
 KScQBgRAyEV1KKSCOawXI5zWuIbjbEmAtmtRDmzoDpzZjX/AziQzUh/HvDuwDfpcnJym
 YHEHqJX6/QeOtfvYYc/Cpew74zAis0CqXZszV6W7oLvnwFWfantXf7URxbNKG9rWG/th
 XyGA==
X-Gm-Message-State: AGi0Pua/1fbPwaNaT9I3Ni66Lh47j+hyAY5fVv7P7ICLdJqVdyl8OTTL
 Q4xEWXw/LpUzzRA/8sDW1xruVzCwjTIqV+rrDuQ=
X-Google-Smtp-Source: APiQypLA4gZ25BNo5kxJOdgKbFrlwdUQoSGxVGVReSv57GgSO+DLINL8SOpkW+vnTj+VkvhitG1nRfAIzc+ZsnJlilk=
X-Received: by 2002:a17:906:1001:: with SMTP id 1mr637755ejm.267.1586196051208; 
 Mon, 06 Apr 2020 11:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <b398161ff7d0268454413058dc6c194cf93f5990.camel@collabora.com>
 <ece8ebe3-40ec-2457-02da-4fef19cbe8f6@intel.com>
 <6d2ec570f957b4504fb70e0b1f0632712a99dc0c.camel@collabora.com>
 <CAPj87rO7BuKQj2Kei3T7RdkFq5=TiuShBvtrPU2sn0iqMfXSTg@mail.gmail.com>
 <59f4ea1f13a9a9d37f7801b93061b4ae7dd595e2.camel@gmail.com>
 <d0ef47e45c83b342494e6781b808b4831a008836.camel@ndufresne.ca>
 <d9dca12759fd6a549dc4cd71b5f210a4dced01cd.camel@gmail.com>
 <CAOFGe96WqRTagf=Lhp6j9aMnB6hxwog7t93t=4r6QE_4f+HpeQ@mail.gmail.com>
 <5551426acf99f73d3ce8234c14c176c1c7a1fe44.camel@ndufresne.ca>
 <CAAxE2A5zSy7Rh6xyPW8NCqj3q0_8F7yw8tAXx=_z8+mJ-u2uWw@mail.gmail.com>
 <3cddf1aa-5072-af7c-c51e-c16039176f6c@daenzer.net>
 <CAF6AEGuNTtHfNm_nRhPFX5wPRmKkjnFEKqTdTSBDjpLkaiN8Fw@mail.gmail.com>
 <f4d856925111b77012cabb255d6a880ae5637b41.camel@redhat.com>
 <CAF6AEGtnxmCCakT65zJ7BY=11E_+DgttamBggD10SahtsXuxEQ@mail.gmail.com>
 <0d2d9669-3240-ff60-328d-77933499442a@daenzer.net>
In-Reply-To: <0d2d9669-3240-ff60-328d-77933499442a@daenzer.net>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 6 Apr 2020 11:00:51 -0700
Message-ID: <CAF6AEGvY7hQvohGY0OXBG1DWzRChYdNC9PpOgzuWabh927Jogg@mail.gmail.com>
Subject: Re: gitlab.fd.o financial situation and impact on services
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
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>, dri-devel <dri-devel@lists.freedesktop.org>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>, Adam Jackson <ajax@redhat.com>,
 Discussion of the development of and with GStreamer
 <gstreamer-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBBcHIgNiwgMjAyMCBhdCAxMDowNCBBTSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRh
ZW56ZXIubmV0PiB3cm90ZToKPgo+IE9uIDIwMjAtMDQtMDYgNjozNCBwLm0uLCBSb2IgQ2xhcmsg
d3JvdGU6Cj4gPgo+ID4gVGhlIGlkZWFsIHRoaW5nIHdvdWxkIGJlIHRvIGJlIGFibGUgdG8gY2xp
Y2sgYW55IGpvYnMgdGhhdCB3ZSB3YW50IHRvCj4gPiBydW4sIHNheSAiYXJtNjRfYTYzMF9nbGVz
MzEiLCBhbmQgZm9yIGdpdGxhYiB0byByZWFsaXplIHRoYXQgaXQgbmVlZHMKPiA+IHRvIGF1dG9t
YXRpY2FsbHkgdHJpZ2dlciBkZXBlbmRlbmNpZXMgb2YgdGhhdCBqb2IgKG1lc29uLWFybTY0LCBh
bmQKPiA+IGFybV9idWlsZCthcm1fdGVzdCkuICBCdXQgbm90IHN1cmUgaWYgdGhhdCBpcyBhIHRo
aW5nIGdpdGxhYiBjYW4gZG8uCj4KPiBOb3QgdGhhdCBJIGtub3cgb2YuIFRoZSBkZXBlbmRlbmN5
IGhhbmRsaW5nIGlzIHN0aWxsIHByZXR0eSBydWRpbWVudGFyeQo+IGluIGdlbmVyYWwuCj4KPgo+
ID4gVHJpZ2dlcmluZyBqdXN0IHRoZSBmaXJzdCBjb250YWluZXIgam9icyBhbmQgaGF2aW5nIGV2
ZXJ5dGhpbmcgZnJvbQo+ID4gdGhlcmUgcnVuIGF1dG9tYXRpY2FsbHkgd291bGQgYmUgb2sgaWYg
dGhlIGN1cnJlbnQgcnVsZXMgdG8gZmlsdGVyIG91dAo+ID4gdW5uZWVkZWQgam9icyBzdGlsbCBh
cHBseSwgaWUuIGEgcGFuZnJvc3QgY2hhbmdlIGlzbid0IHRyaWdnZXJpbmcKPiA+IGZyZWVkcmVu
byBDSSBqb2JzIGFuZCB2aXNhIHZlcnNhLiAgQnV0IHRiaCBJIGRvbid0IHVuZGVyc3RhbmQgZW5v
dWdoCj4gPiBvZiB3aGF0IHRoYXQgTVIgaXMgZG9pbmcgdG8gdW5kZXJzdGFuZCBpZiB0aGF0IGlz
IHdoYXQgaXQgZG9lcy4gIChJdAo+ID4gd2FzIHN1Z2dlc3RlZCBvbiBJUkMgdGhhdCB0aGlzIGlz
IHByb2JhYmx5IHdoYXQgaXQgZG9lcy4pCj4KPiBJdCBpcy4gRmlsdGVyZWQgam9icyBkb24ndCBl
eGlzdCBhdCBhbGwgaW4gdGhlIHBpcGVsaW5lLCBzbyB0aGV5IGNhbid0Cj4gYmUgdHJpZ2dlcmVk
IGJ5IGFueSBtZWFucy4gOikKPgoKYWhoLCBvaywgSSBkaWRuJ3QgcmVhbGl6ZSB0aGF0Li4gdGh4
IGZvciB0aGUgZXhwbGFpbmF0aW9uCgpCUiwKLVIKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
