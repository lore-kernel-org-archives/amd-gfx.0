Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F303DC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 17:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BA820768
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 17:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S55ocRTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BA820768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504226EBA4;
	Fri, 14 Aug 2020 17:42:47 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4E9C6EBA7
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 17:42:46 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id l2so9040507wrc.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=94vrMoxX1xZTzhoHD2hRkQAnExkk1pDiDWEU8LeSlqc=;
 b=S55ocRTGqHMOlLdr7Dn4UR7fOUEtgNcCS8EmlCJvJzUZXusIOm3GTWNJp2Gdhpsi+T
 wEUc90FgUd1+I5bUQVa9Rato8mk2Pr003b9smZzS45d3oHDd7lSWv02C2T+suz8fKWgT
 KUBcFr52/vH5+DUNkqT0+ctGaQfrjX8SaLGnOv06Mt1K4fE509pPbq56CZ6MteM3EqsS
 ZrfTGsfzS95FW61T2QOd3YXYVSFFWBD1sZO6canonokWojt0RR5kQgnxd6RCpyhHkv6a
 M6M3As92VhrmA9Pgzm2zOuQ9oKVbVtRRRPetg59S9XKP+M4Wcv3WOanTRCSvyFIm8UcR
 Lilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=94vrMoxX1xZTzhoHD2hRkQAnExkk1pDiDWEU8LeSlqc=;
 b=Tr+BmSswywPBB6n00z+Ilwrs3HPIz/FUgp+pjbGWsP5d7Fi/pmIPEfuPBcyp5LiQPq
 WQHIUZdRKJrFMffMJQaqDYP0sF95EPQTyRHZ/9uPPgL61v5eX9fP/BRQNjHLPvWtzgpc
 NqoYKFOhxx3ydJedPjPFk/pXeuv82RF1IqgDVuIWsMsm4aqJKd/ydAgdjBAKGuDQmz9B
 xWAefdQG6IscOd24X7Dx4LYPv5cgwVhbLHBHZqKDZlQbu2voCWzw6SMUVjzYm0jOm+Xi
 kWTV+gSaAZBzXAhb3zQcVPMeZWSOEJlDk/aH4tjHxHnSVWGZRF0zrYYGurwRKTUcpYp7
 PsbA==
X-Gm-Message-State: AOAM5311/UdARNe3WRm16F/PeGp6oVk056+uJdxKcMdkBbT9KF2CrzBv
 1WWk1+FZTpcQ2oKMKdpW7SvbMUx2zJClK1Rzh8M=
X-Google-Smtp-Source: ABdhPJzv9Q/iyTJmAz4mCh2VyyCvPgql1MepgvYnfmM8zbKeQTDwFiypWy1jB/R43keHDvYTDPrVDmb644Kaxl7RlV0=
X-Received: by 2002:adf:a351:: with SMTP id d17mr3593585wrb.111.1597426965532; 
 Fri, 14 Aug 2020 10:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <2f7ae285-b51e-409f-9110-534bb68ec0ad@email.android.com>
In-Reply-To: <2f7ae285-b51e-409f-9110-534bb68ec0ad@email.android.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Aug 2020 13:42:34 -0400
Message-ID: <CADnq5_Ps50aFY5bV7j+EjiPBJK-gnbmMOpr9ZprtGkSi=1D3SQ@mail.gmail.com>
Subject: Re: TTM/nouveau conflict in drm-misc-next
To: "Koenig, Christian" <Christian.Koenig@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBBdWcgMTQsIDIwMjAgYXQgMTI6MjEgUE0gS29lbmlnLCBDaHJpc3RpYW4KPENocmlz
dGlhbi5Lb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gQW0gMTQuMDguMjAyMCAxNzo1MyBz
Y2hyaWViIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPjoKPgo+IE9uIEZyaSwg
QXVnIDE0LCAyMDIwIGF0IDExOjIyIEFNIENocmlzdGlhbiBLw7ZuaWcKPiA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPiB3cm90ZToKPiA+Cj4gPiBIZXkgVGhvbWFzICYgQWxleCwKPiA+Cj4gPiB3
ZWxsIHRoZSBUVE0gYW5kIE5vdXZlYXUgY2hhbmdlcyBsb29rIGdvb2QgdG8gbWUsIGJ1dCB0aGlz
IGNvbXBsZXRlbHkKPiA+IGJyb2tlIGFtZGdwdS4KPiA+Cj4gPiBBbGV4IGFueSBpZGVhIHdoYXQg
aXMgZ29pbmcgb24gaGVyZT8KPgo+IFdoYXQncyBicm9rZW4gaW4gYW1kZ3B1PyAgVGhlcmUgc2hv
dWxkbid0IGJlIGFueSB0dG0gY2hhbmdlcyBpbiBhbWRncHUKPiBmb3IgZHJtLW5leHQuICBUaG9z
ZSBhbGwgZ28gdGhyb3VnaCBkcm0tbWlzYy4KPgo+Cj4gSXQncyBub3QgYSBUVE0gY2hhbmdlLgo+
Cj4gVGhlIGJhY2ttZXJnZSBvZiBkcm0tbmV4dCBpbnRvIGRybS1taXNjLW5leHQgYnJva2UgYW1k
Z3B1IHNvIHRoYXQgZXZlbiBnbHhnZWFycyBkb2Vzbid0IHdvcmsgYW55bW9yZS4KPgo+IEJ1dCBl
YWNoIGluZGl2aWR1YWwgbWVyZ2UgaGVhZCBzdGlsbCB3b3JrcyBmaW5lIGFzIGZhciBhcyBJIGNh
biBzYXkuCj4KPiBBbnkgaWRlYSBob3cgdG8gdHJhY2sgdGhhdCBkb3duPwoKV2VpcmQuICBBbnl0
aGluZyBpbiB0aGUgbG9ncz8KCkFsZXgKCgo+Cj4gQ2hyaXN0aWFuLgo+Cj4KPiBBbGV4Cj4KPiA+
Cj4gPiBSZWdhcmRzLAo+ID4gQ2hyaXN0aWFuLgo+ID4KPiA+IEFtIDEyLjA4LjIwIHVtIDIxOjEw
IHNjaHJpZWIgVGhvbWFzIFppbW1lcm1hbm46Cj4gPiA+IEhpIENocmlzdGlhbiBhbmQgQmVuLAo+
ID4gPgo+ID4gPiBJIGJhY2ttZXJnZWQgZHJtLW5leHQgaW50byBkcm0tbWlzYy1uZXh0IGFuZCBo
YWQgYSBjb25mbGljdCBiZXR3ZWVuIHR0bQo+ID4gPiBhbmQgbm91dmVhdS4gc3RydWN0IHR0bV9t
ZW1fcmVzIGdvdCByZW5hbWVkIHRvIHN0cnVjdCB0dG1fcmVzb3VyY2UuIEkKPiA+ID4gdXBkYXRl
ZCBub3V2ZWF1IHRvIHRoZSBuZXcgbmFtZSwgdGVzdC1idWlsdCwgYW5kIHB1c2hlZCB0aGUgcmVz
dWx0IHRvCj4gPiA+IGRybS1taXNjLW5leHQuIElmIGVpdGhlciBvZiB5b3UgaGFzIGEgbWludXRl
LCB5b3UgbWF5IHdhbnQgdG8gZG91YmxlCj4gPiA+IGNoZWNrIHRoZSBtZXJnZS4KPiA+ID4KPiA+
ID4gQmVzdCByZWdhcmRzCj4gPiA+IFRob21hcwo+ID4gPgo+ID4KPiA+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dAo+ID4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IGh0dHBzOi8vbmFtMTEuc2Fm
ZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZy
ZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIl
N0MwMSU3Q2NocmlzdGlhbi5rb2VuaWclNDBhbWQuY29tJTdDYTFhZWZjMWVlMjJhNGU3MzNkZjkw
OGQ4NDA2YTM5NWMlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdD
NjM3MzMwMTcyMjc1MDg4NjQ5JmFtcDtzZGF0YT1YMlpKVUVUd29xODg0WHRnNjZzRHVkalhCJTJG
M3MlMkJnUmdsbmgzM2dwVTRIYyUzRCZhbXA7cmVzZXJ2ZWQ9MAo+Cj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
