Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1EFC07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 12:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8971461405
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 12:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8971461405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31CA26E219;
	Fri,  4 Jun 2021 12:33:48 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 240AC6E219
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 12:33:47 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id z3so9582983oib.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Jun 2021 05:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rpxiP/3wkGrhn25ASakh2RPkFlm9hik+lXhdiORWhCg=;
 b=fAUHwyURATIIdr1SmKYv0255JApNHgFDfo/kRhlNHdpgqe0n4xI+oeGP5AettvFB5L
 zoP7y0w7l2U/AkfoMc1ZDk8i+HHK+ZxPQN/yeRTuoA5ecQC7OZF2G54SLJDVEtiJlvdw
 4BMtqVUSEIcef1xZUNRtdg2cgtgO+swNKhPMDStYEdhwsQIJO5qo3b2nFZuEulpCK3Yu
 iAZkifGxh54r0Ft/YoB8c6QAIS+jc6Jm9PiJap/vMP4vTr3mQ2TdqRTM2wzS3KxmUjg8
 JXrpGqA1o8ZarQ7t5bZDVovSXP2fWHqkzszBthSv+NANZq6iTk7LwgH3BSN03ylz91MQ
 zqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rpxiP/3wkGrhn25ASakh2RPkFlm9hik+lXhdiORWhCg=;
 b=n+cntdVK84kQdliHNF2Ehoj9Rin54xMf+H+ox9ZbmWyJrhZ2d6/gplpSnFdOaSi9LH
 witS5dnWqYzUdIijFsSDSajNnhccJD5aJQJ0M73zGfzPDjh8icxx8XYoFc0hCL9K7QAE
 M//sRIfu7p2rUm8YvvVPpWCZsWnkUrVZD1JYJIPlKqqaLmcLCVoX/nsynmBHqXYWjsCC
 3+jwjvWstR1FcxUPUTSQ0vMzxuoSQl8bGbjDq0a0W6ca9NP9JoWqFp/TBcwQCqak3kKb
 uy0I+Cu6/FiF98TF1S14pQWyrQA2rvUkjZgtK0itwIfP89sUmnKh2DPOx6Oh8mR9T9XM
 yvMQ==
X-Gm-Message-State: AOAM53301QFnB58xRqo8V/YGBsLzfdiEtB61A/rwbn8hHeOLTIH5fqLh
 oI4HDTR1cnY1SK3SdjkN7sjz+jASsU7eXLkk3d8=
X-Google-Smtp-Source: ABdhPJw6/B31l8LPSWpKsGzYqIvF0KwMvx7bKil/YLcP1sYhzK4qOUnBFHe71FNwdP6E56p1I5MNEh+kydjngOD8fUA=
X-Received: by 2002:a05:6808:1592:: with SMTP id
 t18mr2722538oiw.123.1622810026394; 
 Fri, 04 Jun 2021 05:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <a4ba9456-812b-5280-75fd-6dd66d1f9718@riseup.net>
 <22c25fa6-b3eb-b778-8598-3ce1947a3d0b@daenzer.net>
 <CADnq5_OVjssNi2niLZQs-TOyN5T5EFOnpwmpmbvHRgh_M0B=wg@mail.gmail.com>
 <7a9f2682-559d-57ec-4879-b1e6f743c375@daenzer.net>
 <CADnq5_O+FjF0R0OEMyPZ-hzg7d2Fx87NBUjax8_XLF4b71oKmg@mail.gmail.com>
 <7ecaff42-68e4-7566-0da1-fa3475fcacb3@daenzer.net>
In-Reply-To: <7ecaff42-68e4-7566-0da1-fa3475fcacb3@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Jun 2021 08:33:33 -0400
Message-ID: <CADnq5_MEFyQA6s7+4FKKq3qT_6i2ue=n5+CswPpB3H5Kt3ybuw@mail.gmail.com>
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
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
Cc: xgqt <xgqt@riseup.net>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKdW4gNCwgMjAyMSBhdCAzOjQ3IEFNIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFl
bnplci5uZXQ+IHdyb3RlOgo+Cj4gT24gMjAyMS0wNS0xOSAzOjU3IHAubS4sIEFsZXggRGV1Y2hl
ciB3cm90ZToKPiA+IE9uIFdlZCwgTWF5IDE5LCAyMDIxIGF0IDQ6NDggQU0gTWljaGVsIETDpG56
ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4gd3JvdGU6Cj4gPj4KPiA+PiBPbiAyMDIxLTA1LTE5IDEy
OjA1IGEubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPiA+Pj4gT24gVHVlLCBNYXkgMTgsIDIwMjEg
YXQgMTA6MTEgQU0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4gd3JvdGU6Cj4g
Pj4+Pgo+ID4+Pj4gT24gMjAyMS0wNS0xNyAxMTozMyBhLm0uLCB4Z3F0IHdyb3RlOgo+ID4+Pj4+
IEhlbGxvIQo+ID4+Pj4+Cj4gPj4+Pj4gSSBydW4gYSBBTUQgbGFwdG9wICI4MU5DIExlbm92byBJ
ZGVhUGFkIFMzNDAtMTVBUEkiIC0gQU1EIFJ5emVuIDUgMzUwMFUgd2l0aCBSYWRlb24gVmVnYSA4
IEdyYXBoaWNzLgo+ID4+Pj4+IFJlY2VudGx5IHNvbWUgYnJlYWthZ2VzIHN0YXJ0ZWQgaGFwcGVu
aW5nIGZvciBtZS4gSW4gYWJvdXQgMWggYWZ0ZXIgYm9vdC11cCB3aGlsZSB1c2luZyBhIEtERSBk
ZXNrdG9wIG1hY2hpbmUgR1VJIHdvdWxkIGZyZWV6ZS4gU29tZXRpbWVzIGl0IHdvdWxkIGJlIHBv
c3NpYmxlIHRvIG1vdmUgdGhlIG1vdXNlIGJ1dCB0aGUgcmVzdCB3aWxsIGJlIGZyb3plbi4gU2Ny
ZWVuIG1heSBzdGFydCBibGlua2luZyBvciBnbyBibGFjay4KPiA+Pj4+Pgo+ID4+Pj4+IEknbSBu
b3Qgc3VyZSBpZiB0aGlzIGlzIG15IGtlcm5lbCwgZmlybXdhcmUgb3IgdGhlIGhhcmR3YXJlLgo+
ID4+Pj4+IEkgZG9uJ3QgdW5kZXJzdGFuZHMgZG1lc2cgdGhhdCdzIHdoeSBJJ20gZ3Vlc3Npbmcs
IGJ1dCBJIHRoaW5rIGl0IGlzIHRoZSBmaXJtd2FyZSBzaW5jZSB0aGlzIGJlaGF2aW9yIHN0YXJ0
ZWQgYXJvdW5kIDIwMjEtMDUtMTUuCj4gPj4+Pj4gRnJvbSBteSBQb3J0YWdlIGxvZ3MgSSBzZWUg
dGhhdCBJIHVwZGF0ZWQgbXkgZmlybXdhcmUgb24gMjAyMS0wNS0xNCBhdCAxODoxNjowNi4KPiA+
Pj4+PiBTbyBicmVha2FnZXMgc3RhcnRlZCB3aXRoIG15IGtlcm5lbDogNS4xMC4yNyBhbmQgRlc6
IDIwMjEwNTExLgo+ID4+Pj4+IEFmdGVyIGJyZWFrYWdlIEkganVtcGVkIHRvIGEgb2xkZXIga2Vy
bmVsIDUuNC45NyBhbmQgY29tcGlsZWQgNS4xMi40LiBJIGRpZG4ndCBub3RpY2UgYSBicmVha2Fn
ZSBvbiA1LjQuOTcgYnV0IHN5c3RlbSByYW4gfjQwIG1pbnV0ZXMuCj4gPj4+Pj4gU28gSSBib290
ZWQgdG8gbmV3bHkgY29tcGlsZWQgNS4xMi40IHdoZXJlIEkgd2FzIH4xaCBhbmQgaXQgYnJva2Uu
Cj4gPj4+Pj4gQWZ0ZXIgdGhhdCBJIGJvb3RlZCB0byA1LjQuOTcgYWdhaW4gYW5kIGRvd25ncmFk
ZWQgbXkgRlcuCj4gPj4+Pj4gV2hpbGUgSSdtIHdyaXRpbmcgdGhpcyBJJ20gYm9vdGVkIHRvIGtl
cm5lbDogNS4xMi40IHdpdGggRlc6IDIwMjEwMzE1Lgo+ID4+Pj4+Cj4gPj4+Pj4gSSBhbHNvIGRl
c2NyaWJlZCBteSBzaXR1YXRpb24gb24gdGhlIEdlbnRvbyBidWd6aWxsYTogaHR0cHM6Ly9idWdz
LmdlbnRvby5vcmcvNzkwNTY2Cj4gPj4+Pj4KPiA+Pj4+PiAiZG1lc2cubG9nIiBhdHRhY2hlZCBo
ZXJlIGlzIGZyb20gdGhlIHRpbWUgbWFjaGluZSBydW4gZmluZSAoYXQgdGhlIG1vbWVudCk7ICJl
cnJvcnNfc2F0X21heV8xNV8wNzI4MjVfcG1fY2VzdF8yMDIxLmxvZyIgaXMgYSBkbWVzZyBsb2cg
ZnJvbSB0aGUgdGltZSBzeXN0ZW0gYnJva2UKPiA+Pj4+Pgo+ID4+Pj4+IENhbiBJIGdldCBhbnkg
aGVscCB3aXRoIHRoaXM/IFdoYXQgYXJlIHRoZSBuZXh0IHN0ZXBzIEkgc2hvdWxkIHRha2U/IEFu
eSBvdGhlciBmaWxlcyBJIHNob3VsZCBwcm92aWRlPwo+ID4+Pj4KPiA+Pj4+IEkndmUgaGl0IHNp
bWlsYXIgaGFuZ3Mgd2l0aCBhIExlbm92byBUaGlua1BhZCBFNTk1IChSeXplbiA3IDM3MDBVIC8g
UGljYXNzbyAvIFJBVkVOIDB4MTAwMjoweDE1RDggMHgxN0FBOjB4NTEyNCAweEMxKS4gSSdtIGFs
c28gc3VzcGVjdGluZyB0aGVtIHRvIGJlIGZpcndhcmUgcmVsYXRlZC4gVGhlIGhhbmdzIG9jY3Vy
cmVkIHdpdGggZmlybXdhcmUgZnJvbSB0aGUgQU1EIDIwLjUwIHJlbGVhc2UuIEknbSBjdXJyZW50
bHkgcnVubmluZyB3aXRoIGZpcm13YXJlIGZyb20gdGhlIDIwLjQwIHJlbGVhc2UsIG5vIGhhbmcg
aW4gYWxtb3N0IDIgd2Vla3MgKHRoZSBoYW5ncyBoYXBwZW5lZCB3aXRoaW4gMS0yIGRheXMgYWZ0
ZXIgYm9vdCkuCj4gPj4+Cj4gPj4+IENhbiB5b3UgbmFycm93IGRvd24gd2hpY2ggZmlybXdhcmUo
cykgY2F1c2UgdGhlIHByb2JsZW0/Cj4gPj4KPiA+PiBJJ2xsIHRyeSwgYnV0IG5vdGUgSSdtIG5v
dCByZWFsbHkgc3VyZSB5ZXQgbXkgaGFuZ3Mgd2VyZSByZWxhdGVkIHRvIGZpcm13YXJlIChvbmx5
KS4gQW55d2F5LCBJJ2xsIHRyeSBuYXJyb3dpbmcgaXQgZG93bi4KPiA+Cj4gPiBUaGFua3MuICBE
b2VzIHRoaXMgcGF0Y2ggaGVscD8KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9y
Zy9wYXRjaC80MzM3MDEvCj4KPiBVbmZvcnR1bmF0ZWx5IG5vdC4gQWZ0ZXIgbm8gaGFuZ3MgZm9y
IHR3byB3ZWVrcyB3aXRoIG9sZGVyIGZpcm13YXJlLCBJIGp1c3QgZ290IGEgaGFuZyBhZ2FpbiB3
aXRoaW4gYSBkYXkgd2l0aCBuZXdlciBmaXJtd2FyZSBhbmQgYSBrZXJuZWwgd2l0aCB0aGlzIGZp
eC4KPgo+Cj4gSSdsbCB0cnkgYW5kIG5hcnJvdyBkb3duIHdoaWNoIGZpcm13YXJlIHRyaWdnZXJz
IGl0IG5vdy4gRG9lcyBQaWNhc3NvIHVzZSB0aGUgcGljYXNzb18qLmJpbiBvbmVzIG9ubHksIG9y
IG90aGVycyBhcyB3ZWxsPwoKVGhlIHBpY2Fzc28gb25lcyBhbmQgcmF2ZW5fZG1jdS5iaW4uCgpU
aGFua3MsCgpBbGV4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
