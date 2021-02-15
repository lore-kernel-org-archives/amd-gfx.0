Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE2BC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 19:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7572660C3D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 19:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7572660C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30ACE6E922;
	Mon, 15 Feb 2021 19:05:19 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EA846E922
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 19:05:17 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id v193so8774375oie.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 11:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YvskLULXRnJH9K9YKmkpIvNOjcupBa4aOPxdMz3GuLs=;
 b=qrrv/Fflf6ICY/Prc69bLwNj8jFDacXny11lJtOU74TVcys5De/lxaNSNmEgvpoPYX
 9/FOhvqIa3TfkJZBwJ5lnuhjU8mzxx5ecXyXEelLcPolwcTvQC5GY8rto2CgZc41or94
 cXXAzoEuQ2xO25Kuc29MJr/mWXWBiXgG/lHWIN9Ed+z1Q2ejQ3RwgVeeUCK6AiQW42FZ
 XTUNVOJBbgIEM4eJCJ/jy4GCWF+fgbrweKMA0iJEu4hA9tj3Uc4LBWJkyGbTpv2tsByZ
 OR6e1wdwR+CFSgVbxZObklWRZY7Ik38+qhVpRfnhtwDTsCDi5hzcstymPDn6xVsd+j8C
 +FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YvskLULXRnJH9K9YKmkpIvNOjcupBa4aOPxdMz3GuLs=;
 b=OzKfRYz+jRb36f2SMV9KBuUKuKsK2ykd6hfCzVaI/7+J7d1A/FIsTKqY+ZEL4Gq+ME
 wN+j3kJZK5QL2v88FiGN1Op2N3qZ+SFMABJdSvGyEMZAPn2A8UagSEgy8vQAH8i59xIb
 DNUyR7+yCkX0MclhGa9n1pQtHmLmZx1c9yLsEjzuO9Yh83vr+FQmlWJpdlGykL4aXJoe
 xoB8IQnGIwd8NBwlw7dRGvLcOC3pthyKHcVeW7avbQYK7u96O3rQDn4CdCZgejnwTNpo
 otdq4Rx2M+MEOzz5X8DbeLkABf611bVtA6hIVoDx7yQ/8Bc0jS70WZ6Mu+a2dUZ9SJfF
 EDkg==
X-Gm-Message-State: AOAM530+Vylw3DqrDBdcKU/UrITh3jWoBMfSzof5Drofp7qpdocJ3T6k
 ymSAXvkm4Por85KWysah7S7XsiaPkfwgDxszt5I=
X-Google-Smtp-Source: ABdhPJwFVYN7rjLh0GkZyE/3NnyzAGDj8psc1KnJzZ6iK6Tr6UXMn+ZXUDXAbonUg9e4OBGVziW9SdBo3ga6t+qTWqs=
X-Received: by 2002:aca:fc0c:: with SMTP id a12mr225914oii.5.1613415916936;
 Mon, 15 Feb 2021 11:05:16 -0800 (PST)
MIME-Version: 1.0
References: <20210211182843.10541-1-jan.kokemueller@gmail.com>
In-Reply-To: <20210211182843.10541-1-jan.kokemueller@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Feb 2021 14:05:06 -0500
Message-ID: <CADnq5_ND_vOZUrB=7DoAcNog7OPvF82eMM12dRu=f6sZEhekTA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add FPU wrappers to
 dcn21_validate_bandwidth()
To: =?UTF-8?Q?Jan_Kokem=C3=BCller?= <jan.kokemueller@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBGZWIgMTEsIDIwMjEgYXQgMzozNCBQTSBKYW4gS29rZW3DvGxsZXIKPGphbi5rb2tl
bXVlbGxlckBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gZGNuMjFfdmFsaWRhdGVfYmFuZHdpZHRoKCkg
Y2FsbHMgZnVuY3Rpb25zIHRoYXQgdXNlIGZsb2F0aW5nIHBvaW50IG1hdGguCj4gT24gbXkgbWFj
aGluZSB0aGlzIHNvbWV0aW1lcyByZXN1bHRzIGluIHNpbWQgZXhjZXB0aW9ucyB3aGVuIHRoZXJl
IGFyZQo+IG90aGVyIEZQVSB1c2VycyBzdWNoIGFzIEtWTSB2aXJ0dWFsIG1hY2hpbmVzIHJ1bm5p
bmcuIFRoZSBzY3JlZW4gZnJlZXplcwo+IGNvbXBsZXRlbHkgaW4gdGhpcyBjYXNlLgo+Cj4gV3Jh
cHBpbmcgdGhlIGZ1bmN0aW9uIHdpdGggRENfRlBfU1RBUlQoKS9EQ19GUF9FTkQoKSBzZWVtcyB0
byBzb2x2ZSB0aGUKPiBwcm9ibGVtLiBUaGlzIG1pcnJvcnMgdGhlIGFwcHJvYWNoIHVzZWQgZm9y
IGRjbjIwX3ZhbGlkYXRlX2JhbmR3aWR0aC4KPgo+IFRlc3RlZCBvbiBhIEFNRCBSeXplbiA3IFBS
TyA0NzUwVSAoUmVub2lyKS4KPgo+IEJ1ZzogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3No
b3dfYnVnLmNnaT9pZD0yMDY5ODcKPiBTaWduZWQtb2ZmLWJ5OiBKYW4gS29rZW3DvGxsZXIgPGph
bi5rb2tlbXVlbGxlckBnbWFpbC5jb20+CgpBcHBsaWVkLiAgVGhhbmtzIQoKQWxleAoKCj4gLS0t
Cj4gIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYyB8ICAyICst
Cj4gIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYyB8IDIwICsr
KysrKysrKysrKysrKysrLS0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMKPiBpbmRleCA1ZWQxOGNhYzU3ZTguLmY5ZGFiZTIy
NWRiNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAv
ZGNuMjBfcmVzb3VyY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y24yMC9kY24yMF9yZXNvdXJjZS5jCj4gQEAgLTMyNDUsNyArMzI0NSw3IEBAIHN0YXRpYyBub2lu
bGluZSBib29sIGRjbjIwX3ZhbGlkYXRlX2JhbmR3aWR0aF9mcChzdHJ1Y3QgZGMgKmRjLAo+ICBi
b29sIGRjbjIwX3ZhbGlkYXRlX2JhbmR3aWR0aChzdHJ1Y3QgZGMgKmRjLCBzdHJ1Y3QgZGNfc3Rh
dGUgKmNvbnRleHQsCj4gICAgICAgICAgICAgICAgIGJvb2wgZmFzdF92YWxpZGF0ZSkKPiAgewo+
IC0gICAgICAgYm9vbCB2b2x0YWdlX3N1cHBvcnRlZCA9IGZhbHNlOwo+ICsgICAgICAgYm9vbCB2
b2x0YWdlX3N1cHBvcnRlZDsKPiAgICAgICAgIERDX0ZQX1NUQVJUKCk7Cj4gICAgICAgICB2b2x0
YWdlX3N1cHBvcnRlZCA9IGRjbjIwX3ZhbGlkYXRlX2JhbmR3aWR0aF9mcChkYywgY29udGV4dCwg
ZmFzdF92YWxpZGF0ZSk7Cj4gICAgICAgICBEQ19GUF9FTkQoKTsKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYwo+IGluZGV4
IDY3NDM3NjQyODkxNi4uMDcyZjhjODgwOTI0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9yZXNvdXJjZS5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMKPiBAQCAtMTMyOSw4
ICsxMzI5LDggQEAgc3RhdGljIGJvb2wgZGNuMjFfZmFzdF92YWxpZGF0ZV9idygKPiAgICAgICAg
IHJldHVybiBvdXQ7Cj4gIH0KPgo+IC1ib29sIGRjbjIxX3ZhbGlkYXRlX2JhbmR3aWR0aChzdHJ1
Y3QgZGMgKmRjLCBzdHJ1Y3QgZGNfc3RhdGUgKmNvbnRleHQsCj4gLSAgICAgICAgICAgICAgIGJv
b2wgZmFzdF92YWxpZGF0ZSkKPiArc3RhdGljIG5vaW5saW5lIGJvb2wgZGNuMjFfdmFsaWRhdGVf
YmFuZHdpZHRoX2ZwKHN0cnVjdCBkYyAqZGMsCj4gKyAgICAgICAgICAgICAgIHN0cnVjdCBkY19z
dGF0ZSAqY29udGV4dCwgYm9vbCBmYXN0X3ZhbGlkYXRlKQo+ICB7Cj4gICAgICAgICBib29sIG91
dCA9IGZhbHNlOwo+Cj4gQEAgLTEzODMsNiArMTM4MywyMiBAQCBib29sIGRjbjIxX3ZhbGlkYXRl
X2JhbmR3aWR0aChzdHJ1Y3QgZGMgKmRjLCBzdHJ1Y3QgZGNfc3RhdGUgKmNvbnRleHQsCj4KPiAg
ICAgICAgIHJldHVybiBvdXQ7Cj4gIH0KPiArCj4gKy8qCj4gKyAqIFNvbWUgb2YgdGhlIGZ1bmN0
aW9ucyBmdXJ0aGVyIGJlbG93IHVzZSB0aGUgRlBVLCBzbyB3ZSBuZWVkIHRvIHdyYXAgdGhpcwo+
ICsgKiB3aXRoIERDX0ZQX1NUQVJUKCkvRENfRlBfRU5EKCkuIFVzZSB0aGUgc2FtZSBhcHByb2Fj
aCBhcyBmb3IKPiArICogZGNuMjBfdmFsaWRhdGVfYmFuZHdpZHRoIGluIGRjbjIwX3Jlc291cmNl
LmMuCj4gKyAqLwo+ICtib29sIGRjbjIxX3ZhbGlkYXRlX2JhbmR3aWR0aChzdHJ1Y3QgZGMgKmRj
LCBzdHJ1Y3QgZGNfc3RhdGUgKmNvbnRleHQsCj4gKyAgICAgICAgICAgICAgIGJvb2wgZmFzdF92
YWxpZGF0ZSkKPiArewo+ICsgICAgICAgYm9vbCB2b2x0YWdlX3N1cHBvcnRlZDsKPiArICAgICAg
IERDX0ZQX1NUQVJUKCk7Cj4gKyAgICAgICB2b2x0YWdlX3N1cHBvcnRlZCA9IGRjbjIxX3ZhbGlk
YXRlX2JhbmR3aWR0aF9mcChkYywgY29udGV4dCwgZmFzdF92YWxpZGF0ZSk7Cj4gKyAgICAgICBE
Q19GUF9FTkQoKTsKPiArICAgICAgIHJldHVybiB2b2x0YWdlX3N1cHBvcnRlZDsKPiArfQo+ICsK
PiAgc3RhdGljIHZvaWQgZGNuMjFfZGVzdHJveV9yZXNvdXJjZV9wb29sKHN0cnVjdCByZXNvdXJj
ZV9wb29sICoqcG9vbCkKPiAgewo+ICAgICAgICAgc3RydWN0IGRjbjIxX3Jlc291cmNlX3Bvb2wg
KmRjbjIxX3Bvb2wgPSBUT19EQ04yMV9SRVNfUE9PTCgqcG9vbCk7Cj4gLS0KPiAyLjMwLjEKPgo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
