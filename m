Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC87C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 14:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD1E23331
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 14:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiJ/epb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD1E23331
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2112E6E454;
	Wed,  5 Aug 2020 14:37:36 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A44896E454
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 14:37:34 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id g8so6039804wmk.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Aug 2020 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5Y2awb+BmjY/ljAAKVw68Kxe6A199556EOrDPiOKTN8=;
 b=SiJ/epb1ia7uhv5+I5x52WjNb9pjkNs2SWIrhMEMalacoACpYSL6q4Cab5yjcKPVwK
 ey60Z9NCc/gjcEY/GqL+ogUP+XEYdq9p7rS3m1pURM+gEbIAWgLyLcvZBpmR5bBBCmuB
 UVcKJmWaqtlzADxpqHOVkNWnDHEDILaDaVN/lSrt8T2JybaspwnGZHThDHMTFNMGtKoR
 Mc5FtSRp/dKIhWMpZkYvME0enIDLRQsEsvpPCGxONRiBQoKuwuJIrT1WkP+sEV++Xcgm
 muf1Ay3sGEBzm7mlZNgbEI4zlbuRLNDWI6AIOaUJyoWYVL0wrD7b7N5wP8SDAAbdwwp2
 fxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5Y2awb+BmjY/ljAAKVw68Kxe6A199556EOrDPiOKTN8=;
 b=YoqiWZkfBMsFKe4LjBpchP7edhDD8mT9EbFm3dp8oGu0yMWSkvKR1tfeU71K4irK5i
 QfK8OUD0bLn3tulrloVl0rAgQ3wyiZ66isMfNuTvJVEeri1y+7hUBIGHvgKQuhrjEoAb
 oV4p++ifdtiljY0loPOi/SNpwi4e9VhRLOcuJvIKGoHEITiIVEC7JvCX2tc1WHeefar3
 V8/mxrrY9Vvfkm0FIyq4SA6s7DeyhJK8QUQH9m7+tJXb94/ZZDifsDbQyNszFVtGq/jr
 3bWQdnL9diA5MiZls56TvfzKrX15C8u+q5RPUSYhT6oGK01W+Ysi90ofmydnLl/6kHdB
 e28g==
X-Gm-Message-State: AOAM5302p/0MVdgZd3dZ1A39JUknBk9yes3p7j+voCkcohdegE78lpy6
 2cxw4jUmk/M3Y55YvGCRrgZvGw7pLFTu2Dj9ID0V4A==
X-Google-Smtp-Source: ABdhPJz6R1xfT6qKggxFsLmCXQfeew9MXMvZXta8g7Xh71/QsLTYcAaTAx3Mb0JSGca9s1+qeJj0AWc1OL/3ySiPhFI=
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr3675602wmj.79.1596638253261; 
 Wed, 05 Aug 2020 07:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAP+8YyHwMPPTiPAEs0CV+K+NSWtQmKQ-1hL0CmoGvUjA=P_1+Q@mail.gmail.com>
 <6964a9dc-00dc-6e72-f3ad-b4c80c49ec68@daenzer.net>
 <CADnq5_OzAfTyufz0qzOQYqMbkYYGx6FaFLi-nvRvvzLcYrFQcQ@mail.gmail.com>
 <DM6PR12MB3097E61D23857E0342398E6EE84B0@DM6PR12MB3097.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3097E61D23857E0342398E6EE84B0@DM6PR12MB3097.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Aug 2020 10:37:22 -0400
Message-ID: <CADnq5_OU3O8j5WNc-mTB4XsvHwe2gdcMrPidk-aOfqB3EJsyfw@mail.gmail.com>
Subject: Re: Enabling AMDGPU by default for SI & CIK
To: "Bridgman, John" <John.Bridgman@amd.com>
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
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBBdWcgNCwgMjAyMCBhdCAxMDo0OCBQTSBCcmlkZ21hbiwgSm9obiA8Sm9obi5Ccmlk
Z21hbkBhbWQuY29tPiB3cm90ZToKPgo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRlcm5h
bCBEaXN0cmlidXRpb24gT25seV0KPgo+Cj4gQXQgdGhlIHJpc2sgb2YgYXNraW5nIGEgZHVtYiBx
dWVzdGlvbiwgZG9lcyBhbWRncHUgZGVmYXVsdCB0byB1c2luZyBEQyBvbiBTSSBhbmQgQ0kgPwo+
CgpEQyBpcyBkaXNhYmxlZCBieSBkZWZhdWx0IG9uIFNJIGFuZCBDSSBkdWUgdG8gdGhlIGxhY2sg
b2YgYW5hbG9nCmVuY29kZXIgc3VwcG9ydC4KCj4gSSdtIGFza2luZyBiZWNhdXNlIGEgbG90IG9m
IHBlb3BsZSBzZWVtIHRvIGJlIHVzaW5nIGFtZGdwdSBzdWNjZXNzZnVsbHkgd2l0aCBhbmFsb2cg
b3V0cHV0cyB0b2RheSBvbiBTSS9DSS4uLiBzdWdnZXN0cyB0aGF0IHRoZXkgYXJlIG5vdCB1c2lu
ZyBEQyA/CgpZZXMuCgo+Cj4gSWYgc28gdGhlbiB3b3VsZCBlbmFibGluZyBIRE1JL0RQIGF1ZGlv
IHN1cHBvcnQgd2l0aG91dCBEQyBiZSBzdWZmaWNpZW50IHRvIGZsaXAgdGhlIHN3aXRjaCBhc3N1
bWluZyB3ZSBmZWx0IHRoYXQgb3RoZXIgcmlza3Mgd2VyZSBtYW5hZ2VhYmxlID8KClBvc3NpYmx5
LiAgVkNFIHN1cHBvcnQgZm9yIFNJIGlzIGFsc28gbWlzc2luZyBpbiBhbWRncHUuCgpJIHRoaW5r
IHRoZSBiaWdnZXN0IGNoYWxsZW5nZSB3aWxsIGJlIG1ha2luZyBzdXJlIHRoaW5ncyBsaWtlIHN1
c3BlbmQKYW5kIHJlc3VtZSB3b3JrLgoKQWxleAoKPgo+IFRoYW5rcywKPiBKb2huCj4KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IG9uIGJlaGFsZiBvZiBBbGV4IERldWNoZXIgPGFs
ZXhkZXVjaGVyQGdtYWlsLmNvbT4KPiBTZW50OiBBdWd1c3QgNCwgMjAyMCAxOjM1IFBNCj4gVG86
IE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+Cj4gQ2M6IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20+OyBhbWQtZ2Z4IG1haWxpbmcgbGlzdCA8YW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc+OyBCYXMgTmlldXdlbmh1aXplbiA8YmFzQGJhc25pZXV3ZW5odWl6
ZW4ubmw+Cj4gU3ViamVjdDogUmU6IEVuYWJsaW5nIEFNREdQVSBieSBkZWZhdWx0IGZvciBTSSAm
IENJSwo+Cj4gT24gVHVlLCBBdWcgNCwgMjAyMCBhdCA0OjM4IEFNIE1pY2hlbCBEw6RuemVyIDxt
aWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOgo+ID4KPiA+IE9uIDIwMjAtMDgtMDMgMTo0NSBhLm0u
LCBCYXMgTmlldXdlbmh1aXplbiB3cm90ZToKPiA+ID4gSGkgYWxsLAo+ID4gPgo+ID4gPiBOb3cg
dGhhdCB3ZSBoYXZlIHJlY2VudGx5IG1hZGUgc29tZSBwcm9ncmVzcyBvbiBnZXR0aW5nIGZlYXR1
cmUgcGFyaXR5Cj4gPiA+IHdpdGggdGhlIFJhZGVvbiBkcml2ZXIgZm9yIFNJLCBJJ20gd29uZGVy
aW5nIHdoYXQgaXQgd291bGQgdGFrZSB0bwo+ID4gPiBtYWtlIEFNREdQVSB0aGUgZGVmYXVsdCBk
cml2ZXIgZm9yIHRoZXNlIGdlbmVyYXRpb25zLgo+ID4gPgo+ID4gPiBBcyBmYXIgYXMgSSB1bmRl
cnN0YW5kIEFNREdQVSBoYXMgaGFkIHRoZXNlIGZlYXR1cmVzIGZvciBDSUsgZm9yIGEKPiA+ID4g
d2hpbGUgYWxyZWFkeSBidXQgaXQgaXMgc3RpbGwgbm90IHRoZSBkZWZhdWx0IGRyaXZlci4gV2hh
dCB3b3VsZCBpdAo+ID4gPiB0YWtlIHRvIG1ha2UgaXQgdGhlIGRlZmF1bHQ/IFdoYXQgaXMgbWlz
c2luZyBhbmQvb3IgYnJva2VuPwo+ID4KPiA+IFRoZSBtYWluIGJsb2NrZXJzIEknbSBhd2FyZSBv
ZiBmb3IgQ0lLIGFyZToKPiA+Cj4gPiAxKSBMYWNrIG9mIGFuYWxvZ3VlIGNvbm5lY3RvciBzdXBw
b3J0IHdpdGggREMKPiA+IDIpIExhY2sgb2YgSERNSS9EUCBhdWRpbyBzdXBwb3J0IHdpdGhvdXQg
REMKPiA+Cj4gPgo+ID4gMSkgbWF5IGFwcGx5IHRvIFNJIGFzIHdlbGwuCj4KPiBBbHNvLCBJSVJD
LCB0aGVyZSBhcmUgc3VzcGVuZCBhbmQgcmVzdW1lIHByb2JsZW1zIHdpdGggc29tZSBDSUsgcGFy
dHMKPiB1c2luZyBhbWRncHUuCj4KPiBBbGV4Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5v
dXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFp
bG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDam9obi5icmlkZ21h
biU0MGFtZC5jb20lN0MyNmRmODFmOWE2ZGY0ZTJmOWZiYjA4ZDgzODljZGE3OSU3QzNkZDg5NjFm
ZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzczMjE1OTM2MjAzNzg0ODEmYW1w
O3NkYXRhPUVwJTJCWVJSVDFkQWNFOHpTRElhWmlYdVZNYjlnQlZVbkxuYnRQMSUyQmU3UGtjJTNE
JmFtcDtyZXNlcnZlZD0wCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
