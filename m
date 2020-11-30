Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F18C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CCC20725
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhlCbBDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CCC20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0037B8930A;
	Mon, 30 Nov 2020 23:20:21 +0000 (UTC)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F3818930A;
 Mon, 30 Nov 2020 23:20:21 +0000 (UTC)
Received: by mail-oi1-x244.google.com with SMTP id x16so349870oic.3;
 Mon, 30 Nov 2020 15:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CDfNpqMXGhqvJenF6xYXnI7EWSyYaGSCmDynR3Cbu1A=;
 b=LhlCbBDhK3DAxmiqeCyyY5IVJIGP0Bgg3vzynN9O8fQwGcJiU4Om38fo3Ki4cBkJ4P
 0B+wfPdrsMY/wIvbCvTw5qeBiToL9IWKJUjb4RHY5vj6kTB1r7sizNxkUQMU13YqNjkd
 rq8OLY6ijTWXEqohFEAA6eaGmDW94FG0adiw5Efue1dmnQrNX0uRNqPvns5t6wkhEx2d
 oyHOOnCsfS25XVrPa5aMPrS5PajomWF+6Nxbgagk7p44MCIcwtiILcRqAu8PKnlT3vS+
 OqKtNl3CDa4emDev0dUxaG2zq6o8kYIi6H7OSFB/7HZWQKitTfs28wFQw/VYmxIsvArk
 4xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CDfNpqMXGhqvJenF6xYXnI7EWSyYaGSCmDynR3Cbu1A=;
 b=C4TZYxDntFSK3luerSUlTO3wd+KWHOpIikENlisrcK2d8RJ4nb5P4BgAB+Ykte7Fcc
 ddzBVqik+iMGCM1hOZTGDl+VCSA8K0jLqWAIcdhH0gQSPxhZJSIYLrQWmXjUDaCcvSfi
 1QoabdhEwgi6a8mLFKk+FMociPZCzbbjeSDSBFs0AXEE03roJm4atSCTUfObuuvN6Prb
 GVdIEoCiZ8gDusyy4rSIBdWEQO3B4o8XcWmPS0tqralpodDwmIIwpfbx9KVhYs1ZZNru
 zUxIl0cD4t4dkbJ0ySQ73+DGDauo3k9FoD8ZV5FnfI9xwcOhyJQcQCbEfYAQ4UJh8IDk
 AZLA==
X-Gm-Message-State: AOAM5335aWtCozgjf/Zkzyp8kj2V75vhzGruVbia9yzUtQSPQ5d/hugw
 NNJqDoMnNtm6peqEl/dnolfAKvfA5A0UIGsY+O8=
X-Google-Smtp-Source: ABdhPJwSo/dWUELdsWgMGbX4aJtaagoeCjTtBZXc+5tM3qYJTvO1sBgLcRM+L7bhdL+h7GGkoH8X7bCQI9WCANH4i5k=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr106519oih.123.1606778420693; 
 Mon, 30 Nov 2020 15:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org>
 <20201126134240.3214176-9-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-9-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 18:20:09 -0500
Message-ID: <CADnq5_MCqEad1qme4Z4-Cw-ScCweQr3_r8Ph3LCz65mpr+9=bg@mail.gmail.com>
Subject: Re: [PATCH 08/40] drm/amd/pm/powerplay/hwmgr/hardwaremanager: Remove
 unused 'phm_set_*()' functions
To: Lee Jones <lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBOb3YgMjYsIDIwMjAgYXQgODo0MyBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3BtL3Bvd2VycGxh
eS9od21nci9oYXJkd2FyZW1hbmFnZXIuYzo1MTg6NTogd2FybmluZzogbm8gcHJldmlvdXMgcHJv
dG90eXBlIGZvciDigJhwaG1fc2V0X21pbl9kZWVwX3NsZWVwX2RjZWZjbGvigJkgWy1XbWlzc2lu
Zy1wcm90b3R5cGVzXQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9wb3dlcnBs
YXkvaHdtZ3IvaGFyZHdhcmVtYW5hZ2VyLmM6NTI4OjU6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHBy
b3RvdHlwZSBmb3Ig4oCYcGhtX3NldF9oYXJkX21pbl9kY2VmY2xrX2J5X2ZyZXHigJkgWy1XbWlz
c2luZy1wcm90b3R5cGVzXQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9wb3dl
cnBsYXkvaHdtZ3IvaGFyZHdhcmVtYW5hZ2VyLmM6NTM4OjU6IHdhcm5pbmc6IG5vIHByZXZpb3Vz
IHByb3RvdHlwZSBmb3Ig4oCYcGhtX3NldF9oYXJkX21pbl9mY2xrX2J5X2ZyZXHigJkgWy1XbWlz
c2luZy1wcm90b3R5cGVzXQo+Cj4gQ2M6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Cj4g
Q2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlz
dGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxp
ZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
Pgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNA
bGluYXJvLm9yZz4KCkFwcGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICAuLi4vYW1kL3Bt
L3Bvd2VycGxheS9od21nci9oYXJkd2FyZW1hbmFnZXIuYyAgfCAzMSAtLS0tLS0tLS0tLS0tLS0t
LS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9oYXJkd2FyZW1hbmFnZXIuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL2hhcmR3YXJlbWFuYWdlci5j
Cj4gaW5kZXggMWY5YjlmYWNkZjFmNC4uNDVkZGUzZTc0YjU3OCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9oYXJkd2FyZW1hbmFnZXIuYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL2hhcmR3YXJlbWFuYWdl
ci5jCj4gQEAgLTUxNCwzNCArNTE0LDMgQEAgaW50IHBobV9zZXRfYWN0aXZlX2Rpc3BsYXlfY291
bnQoc3RydWN0IHBwX2h3bWdyICpod21nciwgdWludDMyX3QgY291bnQpCj4KPiAgICAgICAgIHJl
dHVybiBod21nci0+aHdtZ3JfZnVuYy0+c2V0X2FjdGl2ZV9kaXNwbGF5X2NvdW50KGh3bWdyLCBj
b3VudCk7Cj4gIH0KPiAtCj4gLWludCBwaG1fc2V0X21pbl9kZWVwX3NsZWVwX2RjZWZjbGsoc3Ry
dWN0IHBwX2h3bWdyICpod21nciwgdWludDMyX3QgY2xvY2spCj4gLXsKPiAtICAgICAgIFBITV9G
VU5DX0NIRUNLKGh3bWdyKTsKPiAtCj4gLSAgICAgICBpZiAoIWh3bWdyLT5od21ncl9mdW5jLT5z
ZXRfbWluX2RlZXBfc2xlZXBfZGNlZmNsaykKPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7Cj4gLQo+IC0gICAgICAgcmV0dXJuIGh3bWdyLT5od21ncl9mdW5jLT5zZXRfbWluX2RlZXBf
c2xlZXBfZGNlZmNsayhod21nciwgY2xvY2spOwo+IC19Cj4gLQo+IC1pbnQgcGhtX3NldF9oYXJk
X21pbl9kY2VmY2xrX2J5X2ZyZXEoc3RydWN0IHBwX2h3bWdyICpod21nciwgdWludDMyX3QgY2xv
Y2spCj4gLXsKPiAtICAgICAgIFBITV9GVU5DX0NIRUNLKGh3bWdyKTsKPiAtCj4gLSAgICAgICBp
ZiAoIWh3bWdyLT5od21ncl9mdW5jLT5zZXRfaGFyZF9taW5fZGNlZmNsa19ieV9mcmVxKQo+IC0g
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiAtCj4gLSAgICAgICByZXR1cm4gaHdtZ3It
Pmh3bWdyX2Z1bmMtPnNldF9oYXJkX21pbl9kY2VmY2xrX2J5X2ZyZXEoaHdtZ3IsIGNsb2NrKTsK
PiAtfQo+IC0KPiAtaW50IHBobV9zZXRfaGFyZF9taW5fZmNsa19ieV9mcmVxKHN0cnVjdCBwcF9o
d21nciAqaHdtZ3IsIHVpbnQzMl90IGNsb2NrKQo+IC17Cj4gLSAgICAgICBQSE1fRlVOQ19DSEVD
Syhod21ncik7Cj4gLQo+IC0gICAgICAgaWYgKCFod21nci0+aHdtZ3JfZnVuYy0+c2V0X2hhcmRf
bWluX2ZjbGtfYnlfZnJlcSkKPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gLQo+
IC0gICAgICAgcmV0dXJuIGh3bWdyLT5od21ncl9mdW5jLT5zZXRfaGFyZF9taW5fZmNsa19ieV9m
cmVxKGh3bWdyLCBjbG9jayk7Cj4gLX0KPiAtCj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcg
bGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
