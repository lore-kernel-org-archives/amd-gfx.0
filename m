Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40442C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3D564EE7
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3D564EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED186E4F4;
	Wed, 17 Mar 2021 08:41:18 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch
 [185.70.40.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 691DE6E4F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 08:41:17 +0000 (UTC)
Date: Wed, 17 Mar 2021 08:40:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1615970474;
 bh=9bHNp99Lp4FqNCGuJofi3obB0CkwKErswWtyBqa653w=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=qQYm7IdoO21RE2YlNn8hhZuPiJcNRVafPJMqtGv61JGNpTvBIdyiDwUAmjRnwxfh6
 /YVJ3KGbKUwGFwuVhBMVnzOJlNIF+42+4/pdYN2tRBaT0/VLIOQTk2zid7NmNZui03
 TqI2FkqQ4IkKitcGxxQj07PZNZk15sT0uYrR9nTRXwPblhVFEqfYN+Ffer0H+aqvPX
 WT1FTaR5Z6GXAxFcFDrpdOpGK5oGBZB+jFgBHxJvlWFTCnF9fymHeCWwQSoIhGn69Q
 VGHxFe+s7ix/g1LbQE8IZOI8xK5esI5Uewax7od9uv0Tfv1Yy7WBmndKzZl1ko9f0G
 1snUMkbzWpmGA==
To: =?utf-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2 0/5] amd/display: improve atomic cursor checks
Message-ID: <K80FjRnrr2NB3i6dTSGfpL8lzD06wBMyfFTD8itKY32ZnhV-zvL8EdJ4z6LcIl1Ru2W015WBBTFd1SiH2vMoG5mb8D2bcFAnZdFE_bqFnaQ=@emersion.fr>
In-Reply-To: <8440a340-6aaa-20f9-b239-bc3c96d818a2@daenzer.net>
References: <20210310145019.2877-1-contact@emersion.fr>
 <a4fe57bf-33f2-43f5-0170-2135c6a919df@daenzer.net>
 <mg9Sasg2hDaWhKchS7MJOG1GxFgyK7EjamocMRigAuCcwDNJhI5DGVLItXCxyKqNkEl8E2kgsnijtkSMI_YMTe8_Rjmn0Sh8PB32YNTfH1c=@emersion.fr>
 <07f53c21-920d-7494-8195-c678216610a4@daenzer.net>
 <OlOrZse4H1w18QcjDxxswj-tCs1GMJuhZ0S0hYTrcTkXEO-OjALqKgi1vc8hb46TvH9-J3Ri39_qsRHoevbiHgv88dQx8fcWUPKIRrH19KQ=@emersion.fr>
 <49db6786-6edc-efb8-45db-80895b55ea90@daenzer.net>
 <gA1HyRXp2aQRPxQEUNKYq1HN64EEpVtJeSsDS0pZEjKlO_gkZWhVKlu7OkjDEFCY9rI52MOV7z0sKUgZ9bomhbHqXr886R9XyH45DX3d8yQ=@emersion.fr>
 <8440a340-6aaa-20f9-b239-bc3c96d818a2@daenzer.net>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkbmVzZGF5LCBNYXJjaCAxN3RoLCAyMDIxIGF0IDk6MzIgQU0sIE1pY2hlbCBEw6RuemVy
IDxtaWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOgoKPiBPbiAyMDIxLTAzLTE3IDk6MjEgYS5tLiwg
U2ltb24gU2VyIHdyb3RlOgo+ID4gT24gVGh1cnNkYXksIE1hcmNoIDExdGgsIDIwMjEgYXQgMzox
MyBQTSwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4gd3JvdGU6Cj4gPgo+ID4+
PiBJJ20gbm90IGEgZmFuIG9mIGFkZGluZyBrZXJuZWwgaGFja3MgbGlrZSBzZXR0aW5nIHVwIGEg
dHJhbnNwYXJlbnQgRkIsIHdoZW4KPiA+Pj4gdXNlci1zcGFjZSBjYW4ganVzdCBhdm9pZCB0aGUg
ZmFpbHVyZSB3aXRoIGF0b21pYyB0ZXN0LW9ubHkgY29tbWl0cyAoYW5kIGUuZy4KPiA+Pj4gdXNl
IHRoZSBvdmVybGF5IHRvIGRpc3BsYXkgdGhlIGN1cnNvciBpbWFnZSBpbnN0ZWFkIG9mIHRoZSBj
dXJzb3IgcGxhbmUpLgo+ID4+Cj4gPj4gSSdtIG5vdCBhIGZhbiBvZiByZXF1aXJpbmcgZWFjaCBh
dG9taWMgY2xpZW50IHRvIGhhbmRsZSB0aGlzIGNvbXBsZXhpdHkuCj4gPgo+ID4gVGhhdCdzIGp1
c3QgaG93IGF0b21pYyB3b3JrcyB0aG91Z2guIFVzZXItc3BhY2UgaXMgZXhwZWN0ZWQgdG8gaW5j
cmVtZW50YWxseQo+ID4gYnVpbGQgdGhlIGF0b21pYyByZXF1ZXN0LCBiYWlsaW5nIG91dCBpZiBz
b21ldGhpbmcgZG9lc24ndCB3b3JrIGFsb25nIHRoZSB3YXkuCj4KPiBCZWluZyB1bmFibGUgdG8g
ZGlzYWJsZSBhIHBsYW5lIHdoaWNoIGlzIGN1cnJlbnRseSBlbmFibGVkIGlzIHF1aXRlIGRpZmZl
cmVudAo+IGZyb20gYmVpbmcgdW5hYmxlIHRvIGVuYWJsZSBhIHBsYW5lIHdoaWNoIGlzIGN1cnJl
bnRseSBkaXNhYmxlZC4gSG93IGlzIHVzZXIKPiBzcGFjZSBzdXBwb3NlZCB0byByZWFjdCB0byB0
aGF0LCBvdGhlciB0aGFuIG1heWJlIGRpc2FibGluZyBldmVyeXRoaW5nIGFuZAo+IHN0YXJ0aW5n
IGZyb20gc2NyYXRjaD8KCldoYXQgSSBtZWFuIGJ5ICJzaW5ndWxhciBhdG9taWMgY29tbWl0IiBp
cyBhbiBhdG9taWMgY29tbWl0IHRoYXQgdHJpZXMgdG8KY2hhbmdlIGEgc2luZ2xlIHRoaW5nLCBh
bmQgZXhwZWN0cyB0aGF0IHRvIGp1c3Qgd29yay4gV2hldGhlciBpdCdzIGFib3V0CmRpc2FibGlu
ZyBhIHBsYW5lIG9yIG5vdCBkb2Vzbid0IG1hdHRlciBtdWNoIGZyb20gbXkgcG9pbnQgb2Ygdmll
dy4gRm9yCmluc3RhbmNlLCBtYXliZSBzY2FsaW5nIGlzIGVuYWJsZWQgYW5kIHVzZXItc3BhY2Ug
d2FudHMgdG8gZGlzYWJsZSBzY2FsaW5nLCBidXQKdGhlIGRyaXZlciBjYW4ndD8gVGhpcyB3b3Vs
ZCBiZSBzdXJwcmlzaW5nIHRvIHVzZXItc3BhY2UgYmVjYXVzZSAidXNlci1zcGFjZSBpcwpqdXN0
IHRyeWluZyB0byBkaXNhYmxlICRmZWF0dXJlIiwganVzdCBsaWtlIHRoZSB0aGUgY2FzZSB3ZSdy
ZSB0YWxraW5nIGFib3V0LgoKPiA+IERvaW5nIGl0IHRoZSBvbGQgd2F5IChpZS4gaXNzdWluZyBz
aW5ndWxhciBhdG9taWMgY29tbWl0cywgaWUuIHVzaW5nIHRoZSBhdG9taWMKPiA+IEFQSSBqdXN0
IGxpa2UgdGhlIGxlZ2FjeSBBUEkgaXMgdXNlZCkgd29uJ3Qgd29yayBpbiBtYW55IHNpdHVhdGlv
bnMgYW55d2F5cy4KPgo+IFRoaXMgaXNuJ3QgYWJvdXQgdGhhdCwgbm90IHN1cmUgd2h5IHlvdSBr
ZWVwIGJyaW5naW5nIGl0IHVwLgoKV2VsbCwgYSBjbGllbnQgdGhhdCBpbmNyZW1lbnRhbGx5IGJ1
aWxkcyB0aGUgZnVsbCBhdG9taWMgY29tbWl0IChsaWtlIFdlc3RvbgphbmQgbGlibGlmdG9mZikg
d29uJ3QgaGF2ZSB0aGlzIGlzc3VlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
