Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF14C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 18:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6392067D
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 18:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6392067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 487C36F544;
	Fri, 22 Nov 2019 18:09:40 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D848B6F544
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 18:09:38 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id i12so9699122wro.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 10:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DpPhVhS4wyzfDvthkfVkZm9aEgiGRaSErZlynARRd9c=;
 b=mq/tCj2WfL3w9YYLIrvPYxwT2vyMp4L7vwhxSsNNsb4XSHP3392+DiXNcnwsdQmn1+
 EjWcSOow8ZN5/rplTqY3lUu+jj+6j7r7TA/Z3IhGBz0t65laAkiSXAygaNzX0Abtmh0m
 +Fs3Q/Q4lk+2AzJNfrfbXnDTyHZv1dJztMbrJFNShvtZvkmF5WU4yUsL+xwg6FyMId/R
 9MKsAfSZBnIfAT7WcXef2XXszZNoz6Ct81o/bSuDSCpwnQye0ijqIRgc+mjASfmXwAP+
 JDHeD/jPTOESIALJ0eVq91mxeqtJwTe924Z9yc9BNrqhiJkm0cB8mwOkgKX9aTjIKF4T
 ml5A==
X-Gm-Message-State: APjAAAUXT9jsoSBcb+d8dmthEEOIoCmfh8Kw+2hgZuktQt3tQ4DBpfkt
 Y870JTysZBOQ+gY5EXGgIa+m/O1gejywOYw5+11gkQ==
X-Google-Smtp-Source: APXvYqyFe4ptllDohdvNl/ylFFwM+Xyt8flDFd42JWR1nlEvYuAIPACEWAzWWi9glLSMAjntw63W7FK968yuQY+3IME=
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr34180wrn.50.1574446177242;
 Fri, 22 Nov 2019 10:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20191119205639.244832-1-alexander.deucher@amd.com>
In-Reply-To: <20191119205639.244832-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Nov 2019 13:09:24 -0500
Message-ID:
 <CADnq5_O70hUYjTmv_bkcKKwU4_boOAu5UHz9AcgZir89vX55yw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: add default clocks if not able to fetch
 them
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=DpPhVhS4wyzfDvthkfVkZm9aEgiGRaSErZlynARRd9c=;
 b=rGzsSHcGaJpehxG/79MKhpMTcHJ+zU0zTn2pnlpLOYPxWqDr9CSjsXSa6rRgcwhtc2
 o7tujyCtGy9pIxwnn6IxBWdvHFbGhanyI8JCcuaJmo5PM+SPzO54oeSIeBUy5BkyQUmJ
 fxjU+1+Ihz1YNWRJHzvz5GNPQit1QuFSbTZba2moP98fqSASde+OZIDd0PzmyDzbOehc
 8LHdJraFwH9lh4XY36Cm3RItvoZt1CfqZSB+gjWspTyyYSDNU+g+W4S4dPQdgdmxRbMq
 0p77RaMn3YS49PLh2Tk4KxTnXMHr5mfun8zQWzvSVu9ZKF3oN1WiwtuOH88WI5nYNd3b
 QQFg==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191122180924.UUjnS1VJFvPt12RjDxVFeY8zRmHPhXgjJJWII6rCMP0@z>

UGluZz8KCk9uIFR1ZSwgTm92IDE5LCAyMDE5IGF0IDM6NTYgUE0gQWxleCBEZXVjaGVyIDxhbGV4
ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gZG1fcHBfZ2V0X2Nsb2NrX2xldmVsc19ieV90
eXBlIG5lZWRzIHRvIGFkZCB0aGUgZGVmYXVsdCBjbG9ja3MKPiB0byB0aGUgcG93ZXJwbGF5IGNh
c2UgYXMgd2VsbC4gIFRoaXMgd2FzIGFjY2lkZW50bHkgZHJvcHBlZC4KPgo+IEZpeGVzOiBiM2Vh
ODhmZWYzMjFkZSAoImRybS9hbWQvcG93ZXJwbGF5OiBhZGQgZ2V0X2Nsb2NrX2J5X3R5cGUgaW50
ZXJmYWNlIGZvciBkaXNwbGF5IikKPiBCdWc6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9y
Zy9kcm0vYW1kL2lzc3Vlcy85MDYKPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jIHwgMyArKy0KPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcHBfc211LmMKPiBpbmRl
eCAyMjk3ODhiZWU1NDQuLmEyZTFhNzNmNjZiOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wcF9zbXUuYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jCj4gQEAg
LTM0Miw3ICszNDIsOCBAQCBib29sIGRtX3BwX2dldF9jbG9ja19sZXZlbHNfYnlfdHlwZSgKPiAg
ICAgICAgIGlmIChhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3MgJiYgYWRldi0+cG93ZXJwbGF5LnBw
X2Z1bmNzLT5nZXRfY2xvY2tfYnlfdHlwZSkgewo+ICAgICAgICAgICAgICAgICBpZiAoYWRldi0+
cG93ZXJwbGF5LnBwX2Z1bmNzLT5nZXRfY2xvY2tfYnlfdHlwZShwcF9oYW5kbGUsCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgZGNfdG9fcHBfY2xvY2tfdHlwZShjbGtfdHlwZSksICZwcF9jbGtz
KSkgewo+IC0gICAgICAgICAgICAgICAvKiBFcnJvciBpbiBwcGxpYi4gUHJvdmlkZSBkZWZhdWx0
IHZhbHVlcy4gKi8KPiArICAgICAgICAgICAgICAgICAgICAgICAvKiBFcnJvciBpbiBwcGxpYi4g
UHJvdmlkZSBkZWZhdWx0IHZhbHVlcy4gKi8KPiArICAgICAgICAgICAgICAgICAgICAgICBnZXRf
ZGVmYXVsdF9jbG9ja19sZXZlbHMoY2xrX3R5cGUsIGRjX2Nsa3MpOwo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiB0cnVlOwo+ICAgICAgICAgICAgICAgICB9Cj4gICAgICAgICB9IGVs
c2UgaWYgKGFkZXYtPnNtdS5wcHRfZnVuY3MgJiYgYWRldi0+c211LnBwdF9mdW5jcy0+Z2V0X2Ns
b2NrX2J5X3R5cGUpIHsKPiAtLQo+IDIuMjMuMAo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
