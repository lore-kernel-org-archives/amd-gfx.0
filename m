Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6C0C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 08:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B3B64FAF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 08:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B3B64FAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E4F6EB37;
	Thu, 11 Mar 2021 08:57:28 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch
 [185.70.40.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA5B66EB37
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 08:57:27 +0000 (UTC)
Date: Thu, 11 Mar 2021 08:57:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1615453045;
 bh=WE5FEVylAM2pXKEe0ERE8L65zFMPsRu/a1LEsnaUhj8=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=rbyPJqG8FYeY5jIgKrPwltf9lpYufJNk1hsPrvSMup1OgKmkUlWACEFa4079NNh54
 y2ijalP2gssLzMvW2XHiLX4eRXOHU92cWJDLV2yrnMb+br9qRoo2cq4T4CL7qFkoHp
 Oh7V8kCzM/iHOrF1Q8kCb/DieZ1AzW3/UuKZ+DdpfeWR9va4r43abOvlT/tl3T006J
 lJtM+/i7a190rxJ9UxMnDJzGsuaVz2/0DK66k6vKd9H/SNHCdxb6DNkAGbj2sZGbir
 18LjjYBIZNfPqs6PqiagQSwWhcMWvJWork7N486rbInMF05xT/qsAtV6nwrnWffgDB
 FDDpQ/BTRaBqQ==
To: =?utf-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2 0/5] amd/display: improve atomic cursor checks
Message-ID: <mg9Sasg2hDaWhKchS7MJOG1GxFgyK7EjamocMRigAuCcwDNJhI5DGVLItXCxyKqNkEl8E2kgsnijtkSMI_YMTe8_Rjmn0Sh8PB32YNTfH1c=@emersion.fr>
In-Reply-To: <a4fe57bf-33f2-43f5-0170-2135c6a919df@daenzer.net>
References: <20210310145019.2877-1-contact@emersion.fr>
 <a4fe57bf-33f2-43f5-0170-2135c6a919df@daenzer.net>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkbmVzZGF5LCBNYXJjaCAxMHRoLCAyMDIxIGF0IDY6MjAgUE0sIE1pY2hlbCBEw6RuemVy
IDxtaWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOgoKPiBPbiAyMDIxLTAzLTEwIDM6NTAgcC5tLiwg
U2ltb24gU2VyIHdyb3RlOgo+Cj4gPiBDaGFuZ2VzIGluIHYyOiBkcm9wICJhbWQvZGlzcGxheTog
ZmFpbCBvbiBjdXJzb3IgcGxhbmUgd2l0aG91dCBhbgo+ID4gdW5kZXJseWluZyBwbGFuZSIuIFRo
aXMgcmV0YWlucyB0aGUgY3VycmVudCBiZWhhdmlvciBpbnN0ZWFkLgo+Cj4gUGF0Y2hlcyAyICYg
MyAoYW5kIHBvc3NpYmx5IDQ/IG5vdCBzdXJlKSB3b3VsZCBzdGlsbCBjYXVzZSB0aGUgc2FtZQo+
IGlzc3VlIGluIHRoZSBzY2VuYXJpbyBkaXNjdXNzZWQgaW4gZm9sbG93LXVwcyB0byB0aGUgZHJv
cHBlZCBwYXRjaAo+IChkaXNhYmxpbmcgYW4gQVJHQiBvdmVybGF5IHBsYW5lIHdpdGggYSBZVVYg
cHJpbWFyeSBwbGFuZSBhbmQgdGhlCj4gY3Vyc29yIHBsYW5lIGVuYWJsZWQpLCB3b3VsZG4ndCB0
aGV5PwoKWWVzLCBidXQgdGhhdCBzaG91bGRuJ3QgYmUgdG9vIG11Y2ggb2YgYW4gaXNzdWUgaW4g
cHJhY3RpY2UsIHNpbmNlCnVzZXItc3BhY2UgdXNpbmcgWVVWIGFuZCBvdmVybGF5cyBhbHNvIHVz
ZXMgYXRvbWljLiBEcm9wcGluZyB0aGUgcGF0Y2gKYXZvaWRzIHRoZSBpc3N1ZSB0byBiZSB0cmln
Z2VyZWQgd2l0aCBsZWdhY3kgdXNlci1zcGFjZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
