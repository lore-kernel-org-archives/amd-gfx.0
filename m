Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7140BCA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 16:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ECFF205C9
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 16:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECFF205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 103E16E4CA;
	Thu, 24 Oct 2019 16:56:13 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D7916E4CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 16:56:12 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id q13so21923914wrs.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 09:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nD4LAA0sSuHN3qM2+6/4j/LE/dwZb9sDwEbucmua2cE=;
 b=IE1+DCyqcZeYbMRJVxZLMCKs0ZaO3AgIE69+CDGJY1fSoaazNRhs/Xbrc4BMG7JQi0
 LPsJlpnP5lFvrEczeoSZcj6y5F2iEljJV2edQoRgt2DBlLg0DOLomAaGxVj7Ib1izs3d
 n/YzEsH4MAJhGNawuFETPBkaRPWG9vIrE6OQdyU3TcZ75Rmy6ehCNp3XmDyDNNLzt72i
 eQPazUMjbNXIr8ASFYXCak+4oGigNXQ1mX3fCR0m6DY4GsHd2I3Ck/rhT1tH4GVnATWe
 v/+SI9DI/C5ugyr7itfudmjHuaR5DfQYGAS+b1tqcR84cPWOY2t8slf/6HN47lt6z9Ar
 cEVg==
X-Gm-Message-State: APjAAAX4ziPPPVNn50i1iFjJu2eAUE3lgbIq2cMa8E5vMXpOgTdQQ84s
 MDAySDilyQ03o2eOzvYorUz9vZ4gR1DlkGeFg8iIBMJ5kQo=
X-Google-Smtp-Source: APXvYqzzxwXAjFKSvq+TeF7FttK8TTCNx8klSWbIq7Z0HckfzFMKmXkJTDQ6QQKoEeRmYvmwh+FayArxDDB/MvNgHVc=
X-Received: by 2002:adf:ed02:: with SMTP id a2mr4674686wro.11.1571936170647;
 Thu, 24 Oct 2019 09:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHL+j0_2ir=8hHDoyqizweOUSV6XfqC-UCD15WuJ9vvptNLr0g@mail.gmail.com>
 <CADnq5_N0r8O2vQapGaary0L-OfdTdz-ezcMJK90+Gy2sPujYcw@mail.gmail.com>
 <CAHL+j08qsu1pSOZPLB9-XWw9ZmT2OamaWPBJV4T3Vzx_C8cD7g@mail.gmail.com>
 <67658520-b3f4-d2f9-7247-dd434ab5c30b@amd.com>
 <CAHL+j0-Nm+6VFXi_w4iciNdG40zubpqvh1RXs3MFfXJK2mFr0Q@mail.gmail.com>
 <CAHL+j0_=r1XBOzwiQmbZTVoRsZ5=Du3pAPd_n7pia81FegdHhw@mail.gmail.com>
 <57826a9e-5842-4ddd-a456-67d1d1b9a9ce@amd.com>
 <CAHL+j0-NJ8F4RpMJ5m9_9gk_t+zhwFwVmG6MMy4TBYa4XjnWEA@mail.gmail.com>
 <CADnq5_MTYe5z0gbtY0eCnUax2D=HZYBQF7YWPS86pikDXGVWOA@mail.gmail.com>
 <CAHL+j0_Dn9VZ7CN-yaaFP4kk39gWTKu4fLZ6SN4Dj17e2z+4RQ@mail.gmail.com>
 <CAHL+j08BgqmOoQHnsfE3xtZFsz14cOZ=Xui3o7mENJd3Fq0z0g@mail.gmail.com>
 <CAHL+j0-E83G4+xYDcJ2xB2abF9DXA78CXfP9LrVVktTmvsBYvg@mail.gmail.com>
 <CAHL+j0-D=AX7==2RRTXDaKEQwid8x817XO-upaDmCemMpvEF6Q@mail.gmail.com>
In-Reply-To: <CAHL+j0-D=AX7==2RRTXDaKEQwid8x817XO-upaDmCemMpvEF6Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Oct 2019 12:55:59 -0400
Message-ID:
 <CADnq5_OL2ra6k8HHnAc=2Zp=bkKA6pLmGDacS3V+6RYHPgwtjg@mail.gmail.com>
Subject: Re: Spontaneous reboots when using RX 560
To: Sylvain Munaut <246tnt@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=nD4LAA0sSuHN3qM2+6/4j/LE/dwZb9sDwEbucmua2cE=;
 b=eSx72TodJCiWazuTtVXm4gn5eEuUU8pIHd2Zm4B/R8e/5kLcJogZJsP1EBbuVzqqxh
 jZh+Gd3u3NBB5yMPibYfcbPHV2eqojzFU2GMdfcusOHDzbiaB9t4gVhuDkezlS6+nG87
 93dZP0rMB2oPMavdT9n9/9Bau1pWJu3leEdTguXwfZpWsI851yOCAuO2zWpWei3GlEPB
 jNwzUdJLTChiBJXZHdaMqsHi+lAkSwgk1bElAFrB1c2SqNFuNKaGSiz+7QGQ9BKtyacR
 Trk89XJFazwftgkczpZzLI/xjrKzRThuw5BDe71sQ7sfzJekM/OLl3rLXSpGCGXGIVhS
 p+fA==
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024165559.__emXEvA42DgvFg0HmNnPOJ6E0M9wpvwHW5VLIAtgsA@z>

T24gVHVlLCBPY3QgMjIsIDIwMTkgYXQgNzowMSBBTSBTeWx2YWluIE11bmF1dCA8MjQ2dG50QGdt
YWlsLmNvbT4gd3JvdGU6Cj4KPiBIaSBBbGwsCj4KPiBNb3JlIHRlc3Rpbmcgb3ZlciB0aGUgbGFz
dCBmZXcgZGF5cyBzaG93ZWQgdGhhdCBvbmx5IGVpdGhlciB0aGUgbG93ZXN0Cj4gcG93ZXIgbW9k
ZSwgb3Igc2xpZ2h0bHkgYWJvdmUgY2FuIHdvcmsuIE9oLCBJIGFsc28gdGVzdGVkIDUuNC1yYzMg
anVzdAo+IGluIGNhc2UgYnV0IHNhbWUgcmVzdWx0cy4KPiBJdCBkb2Vzbid0IHNlZW0gdG8gYmUg
dGhlIGFmZmVjdGVkIGJ5IFBDSWUgbGFuZSBzcGVlZCwgTWVtb3J5IHNlZW1zCj4gc3RhYmxlIGF0
IDYyNU0gYW5kIGFsbW9zdCBhdCAxNTAwTSAob25seSB0aGUgc3VzdGFpbmVkIGhlYXZ5IHdvcmts
b2FkCj4gZXZlbnR1YWxseSBicmluZyBpdCBkb3duKSwgYnV0IHRoZSBTb0Mgc3BlZWQgc2VlbXMg
cHJldHR5IHRvdWNoeS4KPgo+IFNvIHRoYXQgd291bGQgc2VlbSB0byBjb25maXJtIHNvbWV0aGlu
ZyBpcyB3cm9uZyBlaXRoZXIgaW4gdGhlIHBvd2VyCj4gcGxheSB0YWJsZSBpdHNlbGYsIG9yIGl0
cyBpbnRlcnByZXRhdGlvbiBieSB0aGUgbGludXggZHJpdmVyLgo+IEkgdHJpZWQgYnJ1dGUtbG9h
ZGluZyBzb21lIG90aGVyIFJYNTcwIHBwdGFibGUgaW50byBpdCwgYnV0IHRoYXQKPiBkaWRuJ3Qg
cmVhbGx5IGRvIG11Y2guIEFmdGVyIHdyaXRpbmcgaXQgdG8gcHBfdGFibGUsIHRoZSBjYXJkIHdh
cwo+IHN0dWNrIGF0IGl0cyBsb3dlciBjbG9jayBtb2RlLiBXb3JraW5nIGZpbmUsIGJ1dCBzYW1l
IGFzIGlmIEkgaGFkCj4gZm9yY2VkIGl0IHRvIGxvdyBwb3dlci4KPgo+IElzIHRoZXJlIGFueXdh
eSB0byBleHRyYWN0IHRoZSBwb3dlciBwbGF5IHRhYmxlIGZyb20gd2luZG93cyBzaW5jZQo+IGl0
J3MgcnVubmluZyBmaW5lIHRoZXJlID8KPiBJJ20ga2luZCBvZiBydW5uaW5nIG91dCBvZiBpZGVh
IG9mIHdoYXQgdG8gdHJ5IG5leHQuCgpDYW4geW91IHNlbmQgbWUgYSBjb3B5IG9mIHRoZSB2Ymlv
cyBmcm9tIHRoYXQgYm9hcmQ/CgooYXMgcm9vdCkKKHVzZSBsc3BjaSB0byBnZXQgdGhlIGJ1cyBp
ZCkKY2QgL3N5cy9idXMvcGNpL2RldmljZXMvPHBjaSBidXMgaWQ+CmVjaG8gMSA+IHJvbQpjYXQg
cm9tID4gL3RtcC92Ymlvcy5yb20KZWNobyAwID4gcm9tCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
