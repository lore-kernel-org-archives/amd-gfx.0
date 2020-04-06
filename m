Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7E8C2BA17
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 18:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225EB206B8
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 18:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfAw2KlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225EB206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6AFC6E489;
	Mon,  6 Apr 2020 18:54:34 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6A76E489
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 18:54:32 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id j17so702843wru.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Apr 2020 11:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=K3OoqieT3lyjlZc8geti4CZ228YmzibzbjcneQ74mrs=;
 b=WfAw2KlCwMKHDs3H2Sz5uEv1xABn61fO04DyqAy9xsOhPaWjGEJm+2mVWI7NllaOdC
 gW4DIAuOmgCSWOJjbuJ2WnKVRO0rjBIELXOAGxn8yOkuVugHV4eUUVLq8EqwGXxDVywA
 xJoKdMoyDBW7y33mchDO54nC2BIV1Uc7qN1Opyh3zxGho8cmG4b59f0J1SuPnoCex//7
 dlMFrAjb2Navou3edTH2xIZ10KymYftv1TaM0lJGjybn8vI6c+NkXXVz19gBieJSyKm/
 MnHl4m6AiPgIKtnDk4HkF8A2Fs+eQNVietQn1e36UZfabHV1QUvlGFfBCZHpPeAnihNc
 SXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=K3OoqieT3lyjlZc8geti4CZ228YmzibzbjcneQ74mrs=;
 b=WipO+gxvgkn3YNJSdVXHAZKE0wPA55wBQRMxR/lmEQZ1Hf0A6seD4nMrHx3znAChVj
 BUK3NX1ij4S0TovWQVLQ0SnY+x2rbG4hU3N3JZzuObog1PEA5fJYpJmBQscIMwseBb4Z
 mARgVwJfOEuwkDZKJIvdPcMyW/yY9caPz6MEIpQeY8EWpEl8T+6/oCl0DRwjocxwpPGa
 iQyoLXEpOVxeCwhaLjyRckplEuDI3WNW/IfiFQOR5viDgJ8k1jAm2gZVGhrdE5m0tse+
 wHgIUsfZAYsHtDtQAmoh7YhpokNKK4TskXcxQ5wdu1of0CI/XvW2tBb2jwLx0eUP8FI9
 PD+g==
X-Gm-Message-State: AGi0PuYu57yEnaOJaxEfmLAgy7yGaLIALt4CwnlFgmY+Xq479h2zOIf2
 vPn3lc0aUoQrCRuvoDSh+5tKLSWVA/Jm8KSq8xQuLg==
X-Google-Smtp-Source: APiQypJejUTbYS1kxsUkQeyKwB4HcDA36ZkjLUna7W34s9cbsMINk6ZBfdHtB0dd/c6DmYDUaLLbkxhKruoz9SVqDj4=
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr655954wrt.362.1586199271537; 
 Mon, 06 Apr 2020 11:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
 <20200405204115.683559-31-Rodrigo.Siqueira@amd.com>
 <e6066d48-7666-50b6-c3c7-0e910b4ba3d4@daenzer.net>
 <20200406184421.ez2tll7llob3s6pb@outlook.office365.com>
 <CADnq5_NBpsW5ZnfiFM3ttmLHPZ7-nZP7AhE098W8Zz=YaOhszQ@mail.gmail.com>
 <20200406185223.abr6gn7onveknnyv@outlook.office365.com>
In-Reply-To: <20200406185223.abr6gn7onveknnyv@outlook.office365.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Apr 2020 14:54:20 -0400
Message-ID: <CADnq5_P9ZLo0U-x7TL7REgacRk7ostRqbxV0WT6wa94Dod6t7w@mail.gmail.com>
Subject: Re: [PATCH 30/36] drm/amd/display: Avoid create MST prop after
 registration
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Cc: "Leo \(Sunpeng\) Li" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Jerry \(Fangzhi\) Zuo" <Jerry.Zuo@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBBcHIgNiwgMjAyMCBhdCAyOjUyIFBNIFJvZHJpZ28gU2lxdWVpcmEKPFJvZHJpZ28u
U2lxdWVpcmFAYW1kLmNvbT4gd3JvdGU6Cj4KPiBPaywgSSdsbCBqdXN0IHB1c2ggdGhlIHBhdGNo
IHRvIG91ciByZXBvc2l0b3J5LgoKU291bmRzIGdvb2QuICBQbGVhc2Ugbm90ZSB0aGUgb3RoZXIg
aXNzdWUgTWljaGVsIG1lbnRpb25lZCBiZWxvdy4gIFdlCm5lZWQgYSBmaXggZm9yIHRoYXQgYXMg
d2VsbCBmb3IgNS43LgoKVGhhbmtzLAoKQWxleAoKPgo+IFRoYW5rcwo+Cj4gT24gMDQvMDYsIEFs
ZXggRGV1Y2hlciB3cm90ZToKPiA+IE9uIE1vbiwgQXByIDYsIDIwMjAgYXQgMjo0NCBQTSBSb2Ry
aWdvIFNpcXVlaXJhCj4gPiA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPiB3cm90ZToKPiA+ID4K
PiA+ID4gSGkgTWljaGVsLAo+ID4gPgo+ID4gPiBJJ20gZ29pbmcgdG8gYXBwbHkgdGhlIHBhdGNo
c2V0IGJ5IHRoZSBlbmQgb2YgdGhlIGRheSBhdCBBTUQgcmVwb3NpdG9yeS4KPiA+ID4gSXMgdGhh
dCBvayBmb3IgeW91PyBPciBkbyB5b3UgbmVlZCB0aGlzIHBhdGNoIG9uIGRybS1taXNjLW5leHQ/
Cj4gPgo+ID4gSSBjYW4gY2hlcnJ5LXBpY2sgdGhlIGNoYW5nZXMgb3ZlciB0byA1LjcgZml4ZXMg
b25jZSB3ZSd2ZSBhZGRyZXNzZWQKPiA+IGFsbCB0aGUgaXNzdWVzLgo+ID4KPiA+IEFsZXgKPiA+
Cj4gPiA+Cj4gPiA+IEJlc3QgUmVnYXJkcwo+ID4gPgo+ID4gPiBPbiAwNC8wNiwgTWljaGVsIETD
pG56ZXIgd3JvdGU6Cj4gPiA+ID4gT24gMjAyMC0wNC0wNSAxMDo0MSBwLm0uLCBSb2RyaWdvIFNp
cXVlaXJhIHdyb3RlOgo+ID4gPiA+ID4gRnJvbTogIkplcnJ5IChGYW5nemhpKSBadW8iIDxKZXJy
eS5adW9AYW1kLmNvbT4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBbV2h5XQo+ID4gPiA+ID4gUHJvcCBh
cmUgY3JlYXRlZCBhdCBib290IHN0YWdlLCBhbmQgbm90IGFsbG93ZWQgdG8gY3JlYXRlIG5ldyBw
cm9wCj4gPiA+ID4gPiBhZnRlciBkZXZpY2UgcmVnaXN0cmF0aW9uLgo+ID4gPiA+ID4KPiA+ID4g
PiA+IFtIb3ddCj4gPiA+ID4gPiBSZXVzZSB0aGUgY29ubmVjdG9yIHByb3BlcnR5IGZyb20gU1NU
IGlmIGV4aXN0Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEplcnJ5IChGYW5n
emhpKSBadW8gPEplcnJ5Llp1b0BhbWQuY29tPgo+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IEhlcnNl
biBXdSA8aGVyc2VueHMud3VAYW1kLmNvbT4KPiA+ID4gPiA+IEFja2VkLWJ5OiBSb2RyaWdvIFNp
cXVlaXJhIDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+Cj4gPiA+ID4gVGhpcyBwYXRjaCBpcyBu
ZWVkZWQgaW4gNS43LCBvciBvbmUgZ2V0cyB0aGUgV0FSTklOR3MgSSByZXBvcnRlZCBpbgo+ID4g
PiA+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRmFyY2hpdmVzJTJGYW1kLWdmeCUy
RjIwMjAtQXByaWwlMkYwNDgwMTcuaHRtbCZhbXA7ZGF0YT0wMiU3QzAxJTdDUm9kcmlnby5TaXF1
ZWlyYSU0MGFtZC5jb20lN0NjMjc3YTUxNDkwZjk0ZWQ5OWEyNTA4ZDdkYTVhZjZmMCU3QzNkZDg5
NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcyMTc5NTY1NDAzNjg5OTEm
YW1wO3NkYXRhPSUyRkd0blRsWHJSU3paTTdNNEtBcFpPMUZGVkNKanVKOGN1cjc0czJaTnowRSUz
RCZhbXA7cmVzZXJ2ZWQ9MAo+ID4gPiA+IHdoZW4gYW4gTVNUIGRpc3BsYXkgaXMgY29ubmVjdGVk
Lgo+ID4gPiA+Cj4gPiA+ID4gTm90ZSB0aGF0IHRoaXMgcGF0Y2ggZG9lc24ndCBmaXggYWxsIG9m
IHRob3NlLCB0aGVyZSdzIGFsc28gb25lCj4gPiA+ID4gdHJpZ2dlcmVkIGJ5IGRtX2RwX2FkZF9t
c3RfY29ubmVjdG9yID0+IGRybV9lbmNvZGVyX2luaXQuCj4gPiA+ID4KPiA+ID4gPiAgZ2l0IGdy
ZXAgbXN0X2VuY29kZXJzIGRyaXZlcnMvZ3B1L2RybS9pOTE1Lwo+ID4gPiA+Cj4gPiA+ID4gc2hv
d3MgaG93IHRoZSBpOTE1IGRyaXZlciBkZWFscyB3aXRoIHRoaXMuCj4gPiA+ID4KPiA+ID4gPiBD
YW4geW91IGd1eXMgdGFrZSBjYXJlIG9mIHRoYXQgZm9yIDUuNyBhcyB3ZWxsPwo+ID4gPiA+Cj4g
PiA+ID4KPiA+ID4gPiAtLQo+ID4gPiA+IEVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgICBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9u
Lm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZyZWRoYXQuY29tJTJGJmFtcDtkYXRhPTAy
JTdDMDElN0NSb2RyaWdvLlNpcXVlaXJhJTQwYW1kLmNvbSU3Q2MyNzdhNTE0OTBmOTRlZDk5YTI1
MDhkN2RhNWFmNmYwJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3
QzYzNzIxNzk1NjU0MDM3Mzk4NiZhbXA7c2RhdGE9Y2tVVDBXRmVMV29wYnFZNlNHJTJCZzY5aSUy
RjNPNmNUa1NUV3FCQXlGSGczaXclM0QmYW1wO3Jlc2VydmVkPTAKPiA+ID4gPiBMaWJyZSBzb2Z0
d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZl
bG9wZXIKPiA+ID4KPiA+ID4gLS0KPiA+ID4gUm9kcmlnbyBTaXF1ZWlyYQo+ID4gPiBodHRwczov
L25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYl
MkZzaXF1ZWlyYS50ZWNoJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NSb2RyaWdvLlNpcXVlaXJhJTQw
YW1kLmNvbSU3Q2MyNzdhNTE0OTBmOTRlZDk5YTI1MDhkN2RhNWFmNmYwJTdDM2RkODk2MWZlNDg4
NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzIxNzk1NjU0MDM3Mzk4NiZhbXA7c2Rh
dGE9JTJCa3d3UjM4UFVlbDRqMjFXR28lMkZ4UE1vWFMlMkJMbkVRNGF4MXlHeEklMkY1eEhjJTNE
JmFtcDtyZXNlcnZlZD0wCj4gPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gPiA+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gPiA+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gPiA+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUy
Rm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q1JvZHJpZ28u
U2lxdWVpcmElNDBhbWQuY29tJTdDYzI3N2E1MTQ5MGY5NGVkOTlhMjUwOGQ3ZGE1YWY2ZjAlN0Mz
ZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MjE3OTU2NTQwMzcz
OTg2JmFtcDtzZGF0YT1WbEV5OVI1dXMxVmV2UW10VUpqZW4lMkZyVm9pMEY4YmpJQWglMkZ3ZmZp
Q1AyayUzRCZhbXA7cmVzZXJ2ZWQ9MAo+Cj4gLS0KPiBSb2RyaWdvIFNpcXVlaXJhCj4gaHR0cHM6
Ly9zaXF1ZWlyYS50ZWNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
