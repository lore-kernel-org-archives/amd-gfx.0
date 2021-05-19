Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FEAC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 13:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DAF6100C
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 13:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DAF6100C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E81556EDAB;
	Wed, 19 May 2021 13:57:19 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C66FE6EDAB
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 13:57:18 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 i23-20020a9d68d70000b02902dc19ed4c15so11855250oto.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VDYBOo8faSlem9dUDD/vKuU3YBY+Q4n4BjshxWsEyJE=;
 b=TuessuS+OolF6BJfD2I4TXyl8NCgGVjO7w7xHGed0sSpUPjqaBl4LHNxh9B5gnC3Bq
 tVXkj9Fmkpap4torHXwD0DVY6YJN5N/LSn6K1DfCOvHn8o0cskt/Pb/f6HnSngEfukmd
 V0gEEL3RWLR6LPggDFrImvOBTPOe+QqcUYfYkkNLKxjPPTKKFgClYbc87zHNI9Pnv8Fl
 k2Y4dWyYf9Bw8QqmTNQBK1g9xp801rzXE956KZI9TXP4F3nr6ufHoNBinv9udH6a0lp5
 st344PiFDr28xgMa1u7oLnInCbxVPTBp9cQ3f/30ryI++/KIsD6ugV5SJ/qkG6vMd+Rt
 W+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VDYBOo8faSlem9dUDD/vKuU3YBY+Q4n4BjshxWsEyJE=;
 b=oDvG5N62tb5ZmuJizNG43wzgCRPBoL9bEDDKmwXVNGI3mjbGqY59jJTnaRb6b2yeNX
 VnbFwZRH1usHpx7OvrfP2zRpYXzW4OpOi6Z1CLFjDV4+eHxcSyC4fgylFRgWxzLMctI5
 fQdJd9gG1cJfQWAb4qnzll0l4qc5YoZ7zzRFdxzb7koKVDPMqB8k7OQ4CaFJVVBOHE/8
 xUGfGmKZBV7zU3PcGmRhs3BjqUz2ggEeCpZMrsU18awFgJoI3nZNiCDZ1V1Zar/Gwf2c
 3FdjqzxRbTzROyqH4wZ35p9AtKgN918cIynRpjcD2iFx6gLBqtmnecu/+B3kd2gDDgRP
 L3wQ==
X-Gm-Message-State: AOAM530sfFekn7EGFP0uhBH3UnQFKl88uo2VDuq4WeFiSPMjLa1ytfK0
 1QD1L3uyaRtZCpyZK7IZYyRJbT6RWn0J4HRUbKo=
X-Google-Smtp-Source: ABdhPJwzLxdHNeZSxJkXUmkTC6DBxnrlkR+7i7LcAdgeg6Yy46M9mJ9IUEz1c/K0rsQAGiE4o2iXzI69YwtJQvDyl5g=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr9294838otl.132.1621432638131; 
 Wed, 19 May 2021 06:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <a4ba9456-812b-5280-75fd-6dd66d1f9718@riseup.net>
 <22c25fa6-b3eb-b778-8598-3ce1947a3d0b@daenzer.net>
 <CADnq5_OVjssNi2niLZQs-TOyN5T5EFOnpwmpmbvHRgh_M0B=wg@mail.gmail.com>
 <7a9f2682-559d-57ec-4879-b1e6f743c375@daenzer.net>
In-Reply-To: <7a9f2682-559d-57ec-4879-b1e6f743c375@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 May 2021 09:57:07 -0400
Message-ID: <CADnq5_O+FjF0R0OEMyPZ-hzg7d2Fx87NBUjax8_XLF4b71oKmg@mail.gmail.com>
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

T24gV2VkLCBNYXkgMTksIDIwMjEgYXQgNDo0OCBBTSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRh
ZW56ZXIubmV0PiB3cm90ZToKPgo+IE9uIDIwMjEtMDUtMTkgMTI6MDUgYS5tLiwgQWxleCBEZXVj
aGVyIHdyb3RlOgo+ID4gT24gVHVlLCBNYXkgMTgsIDIwMjEgYXQgMTA6MTEgQU0gTWljaGVsIETD
pG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4gd3JvdGU6Cj4gPj4KPiA+PiBPbiAyMDIxLTA1LTE3
IDExOjMzIGEubS4sIHhncXQgd3JvdGU6Cj4gPj4+IEhlbGxvIQo+ID4+Pgo+ID4+PiBJIHJ1biBh
IEFNRCBsYXB0b3AgIjgxTkMgTGVub3ZvIElkZWFQYWQgUzM0MC0xNUFQSSIgLSBBTUQgUnl6ZW4g
NSAzNTAwVSB3aXRoIFJhZGVvbiBWZWdhIDggR3JhcGhpY3MuCj4gPj4+IFJlY2VudGx5IHNvbWUg
YnJlYWthZ2VzIHN0YXJ0ZWQgaGFwcGVuaW5nIGZvciBtZS4gSW4gYWJvdXQgMWggYWZ0ZXIgYm9v
dC11cCB3aGlsZSB1c2luZyBhIEtERSBkZXNrdG9wIG1hY2hpbmUgR1VJIHdvdWxkIGZyZWV6ZS4g
U29tZXRpbWVzIGl0IHdvdWxkIGJlIHBvc3NpYmxlIHRvIG1vdmUgdGhlIG1vdXNlIGJ1dCB0aGUg
cmVzdCB3aWxsIGJlIGZyb3plbi4gU2NyZWVuIG1heSBzdGFydCBibGlua2luZyBvciBnbyBibGFj
ay4KPiA+Pj4KPiA+Pj4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgaXMgbXkga2VybmVsLCBmaXJtd2Fy
ZSBvciB0aGUgaGFyZHdhcmUuCj4gPj4+IEkgZG9uJ3QgdW5kZXJzdGFuZHMgZG1lc2cgdGhhdCdz
IHdoeSBJJ20gZ3Vlc3NpbmcsIGJ1dCBJIHRoaW5rIGl0IGlzIHRoZSBmaXJtd2FyZSBzaW5jZSB0
aGlzIGJlaGF2aW9yIHN0YXJ0ZWQgYXJvdW5kIDIwMjEtMDUtMTUuCj4gPj4+IEZyb20gbXkgUG9y
dGFnZSBsb2dzIEkgc2VlIHRoYXQgSSB1cGRhdGVkIG15IGZpcm13YXJlIG9uIDIwMjEtMDUtMTQg
YXQgMTg6MTY6MDYuCj4gPj4+IFNvIGJyZWFrYWdlcyBzdGFydGVkIHdpdGggbXkga2VybmVsOiA1
LjEwLjI3IGFuZCBGVzogMjAyMTA1MTEuCj4gPj4+IEFmdGVyIGJyZWFrYWdlIEkganVtcGVkIHRv
IGEgb2xkZXIga2VybmVsIDUuNC45NyBhbmQgY29tcGlsZWQgNS4xMi40LiBJIGRpZG4ndCBub3Rp
Y2UgYSBicmVha2FnZSBvbiA1LjQuOTcgYnV0IHN5c3RlbSByYW4gfjQwIG1pbnV0ZXMuCj4gPj4+
IFNvIEkgYm9vdGVkIHRvIG5ld2x5IGNvbXBpbGVkIDUuMTIuNCB3aGVyZSBJIHdhcyB+MWggYW5k
IGl0IGJyb2tlLgo+ID4+PiBBZnRlciB0aGF0IEkgYm9vdGVkIHRvIDUuNC45NyBhZ2FpbiBhbmQg
ZG93bmdyYWRlZCBteSBGVy4KPiA+Pj4gV2hpbGUgSSdtIHdyaXRpbmcgdGhpcyBJJ20gYm9vdGVk
IHRvIGtlcm5lbDogNS4xMi40IHdpdGggRlc6IDIwMjEwMzE1Lgo+ID4+Pgo+ID4+PiBJIGFsc28g
ZGVzY3JpYmVkIG15IHNpdHVhdGlvbiBvbiB0aGUgR2VudG9vIGJ1Z3ppbGxhOiBodHRwczovL2J1
Z3MuZ2VudG9vLm9yZy83OTA1NjYKPiA+Pj4KPiA+Pj4gImRtZXNnLmxvZyIgYXR0YWNoZWQgaGVy
ZSBpcyBmcm9tIHRoZSB0aW1lIG1hY2hpbmUgcnVuIGZpbmUgKGF0IHRoZSBtb21lbnQpOyAiZXJy
b3JzX3NhdF9tYXlfMTVfMDcyODI1X3BtX2Nlc3RfMjAyMS5sb2ciIGlzIGEgZG1lc2cgbG9nIGZy
b20gdGhlIHRpbWUgc3lzdGVtIGJyb2tlCj4gPj4+Cj4gPj4+IENhbiBJIGdldCBhbnkgaGVscCB3
aXRoIHRoaXM/IFdoYXQgYXJlIHRoZSBuZXh0IHN0ZXBzIEkgc2hvdWxkIHRha2U/IEFueSBvdGhl
ciBmaWxlcyBJIHNob3VsZCBwcm92aWRlPwo+ID4+Cj4gPj4gSSd2ZSBoaXQgc2ltaWxhciBoYW5n
cyB3aXRoIGEgTGVub3ZvIFRoaW5rUGFkIEU1OTUgKFJ5emVuIDcgMzcwMFUgLyBQaWNhc3NvIC8g
UkFWRU4gMHgxMDAyOjB4MTVEOCAweDE3QUE6MHg1MTI0IDB4QzEpLiBJJ20gYWxzbyBzdXNwZWN0
aW5nIHRoZW0gdG8gYmUgZmlyd2FyZSByZWxhdGVkLiBUaGUgaGFuZ3Mgb2NjdXJyZWQgd2l0aCBm
aXJtd2FyZSBmcm9tIHRoZSBBTUQgMjAuNTAgcmVsZWFzZS4gSSdtIGN1cnJlbnRseSBydW5uaW5n
IHdpdGggZmlybXdhcmUgZnJvbSB0aGUgMjAuNDAgcmVsZWFzZSwgbm8gaGFuZyBpbiBhbG1vc3Qg
MiB3ZWVrcyAodGhlIGhhbmdzIGhhcHBlbmVkIHdpdGhpbiAxLTIgZGF5cyBhZnRlciBib290KS4K
PiA+Cj4gPiBDYW4geW91IG5hcnJvdyBkb3duIHdoaWNoIGZpcm13YXJlKHMpIGNhdXNlIHRoZSBw
cm9ibGVtPwo+Cj4gSSdsbCB0cnksIGJ1dCBub3RlIEknbSBub3QgcmVhbGx5IHN1cmUgeWV0IG15
IGhhbmdzIHdlcmUgcmVsYXRlZCB0byBmaXJtd2FyZSAob25seSkuIEFueXdheSwgSSdsbCB0cnkg
bmFycm93aW5nIGl0IGRvd24uCgpUaGFua3MuICBEb2VzIHRoaXMgcGF0Y2ggaGVscD8KaHR0cHM6
Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoLzQzMzcwMS8KCkFsZXgKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
