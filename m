Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AA4C17461
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 13:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD221206B8
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 13:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD221206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6718B6EA43;
	Tue,  5 Nov 2019 13:01:33 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFDE6EA43
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 13:01:32 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id n1so21260532wra.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Nov 2019 05:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GogI97JRHCAWCXx7WZYT9tOoHW5T65/hIjUl4RzggLE=;
 b=R+r8gVg5ptb4rnB876JN0EftHgJ1B05T2n6AYPGW4cvFZg1yAn+9RHt+SgT3aJsH73
 kdSwYPgFJpiFk8vFjadu5VC3jyzqc7E/G9TcyWhtBtG0UdQps4l1c4/Qsf83WsvVUyeD
 X0mbXh6jNYtwH6M5cxL8VxV+M57xMc8rRWQ8dlSgycZ3weUm6jd9olLHGSlKXsUWZBrB
 mpA0PBWCgA0GUqDZlEv0p1QBV9jEMWxQ1kU49CPc48iixjV3Yn1w+yKy5J7fiWdFYDP8
 Ach04Ag4Yhwp2t6eVwb9MZV8G4KoH5uJAbvsaefNzSn3VMxT3HHqAfhZhAt8bPU2TmXG
 8P9A==
X-Gm-Message-State: APjAAAWIS2ryuJa1LESWNlY2Wgl+E8WYQ6Pw7mEwbR3LOT1TRAVFwBYY
 GNtppR+8eiBZz41Vjra8SZsc2D8JSKtuUjFI2IUvSg==
X-Google-Smtp-Source: APXvYqybmAIyAXdHLaji710Umypn3KsEdOvD7dUQupbOMkk/bnaP8vFjGa15xj/fClXbLpiurMcUZrOIvj+A1sdlgCw=
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr16835272wrw.206.1572958890829; 
 Tue, 05 Nov 2019 05:01:30 -0800 (PST)
MIME-Version: 1.0
References: <fa2e4af9689cc1fd566876ff8438a90f@nuetzel-hh.de>
In-Reply-To: <fa2e4af9689cc1fd566876ff8438a90f@nuetzel-hh.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Nov 2019 08:01:19 -0500
Message-ID:
 <CADnq5_MiiwVGd-enbECue41mS72v0qaOmz6R7QsCbf5UMM9J+A@mail.gmail.com>
Subject: Re: [amd-staging-drm-nex] Planned move to 5.4-rc6+ soon?
To: =?UTF-8?Q?Dieter_N=C3=BCtzel?= <Dieter@nuetzel-hh.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GogI97JRHCAWCXx7WZYT9tOoHW5T65/hIjUl4RzggLE=;
 b=a7i2pg8/0jw9zoYPo0LrKGTTMQ+34Ga1/Ibn9K81eYd3SmOiAwFb8vDo6ZJ6XIa78w
 Omf/oRivxjivhMMeIkS/YSfUj2+y5sfOLFQpN24lTuaEriXJv2emws2wU22/pD6c8yAO
 LyNT+xkjxEorrwWp8Lp/XVb6JioPQtnN5bzm7d7q78Vid6hQLGazPIZG8qxb4IrJG2Cd
 +0lohJPmY4+JG7llGNQkbylecAoy9LsgD296DkziHNroKpzvOFklBjcsWzc908ARN/W9
 M5nF73HgpXKeKj4SYKbwBnaTvxfnozlNBVQkJgEDJN4CLrVbA4kQW28qZlhVOoO2PKAu
 wjyQ==
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
Cc: amd-devel <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105130119.UWvrIpgbnKECi2sbLhBATb_3NMudcOfMROrsoerACU4@z>

T24gTW9uLCBOb3YgNCwgMjAxOSBhdCA2OjA0IFBNIERpZXRlciBOw7x0emVsIDxEaWV0ZXJAbnVl
dHplbC1oaC5kZT4gd3JvdGU6Cj4KPiBIZWxsbyBBbGV4LAo+Cj4gbGlrZSBBTUQuLi47LSkKPgo+
IFtXaHldCj4gNS4zLXJjWCAoLXJjMykKPiAtIGhhcyBicm9rZW4gKHJlZ3Jlc3NlZCkgYmxvY2sg
bGF5ZXIgKENEL0RWRCwgZ2FtZXMuLi4pIC0gZml4ZWQgaW4gNS4zCj4gZmluYWwKPiAtIEFDUEkg
KHBvd2VyIG1hbmFnZW1lbnQpIHJlZ3Jlc3Npb24gLSBmaXhlZCBpbiA1LjMgZmluYWwKPiAtIFVT
QiAzLjEvMy4yIHJlZ3Jlc3Npb24gKDUuMDAwIHZzIDEwLjAwMCBNYml0L3MgbW9kZSwgaW4gdXNl
IGhlYXZpbHkKPiBoZXJlKQo+ICAgICBldmVuIHdpdGggQU1EJ3MgcGFydG5lciBBU01lZGlhIChB
U00gMjE0MisgY2hpcHMpIC0gZml4ZWQgaW4gNS40LXJjCj4gKCEhISkKPiAtIE5hdmkgcHJvYmxl
bXMgKGUuZy4gU0RNQSkgc29tZSBwcm9ncmVzcy9taXRpZ2F0aW9uIHdpdGggNS40LXJjCj4KPiBb
SG93XQo+IFN3aXRjaCB0byA1LjQtcmM0IChvciBiZXR0ZXIgLXJjNikgYXMgc29vbiBhcyBwb3Nz
aWJsZQo+CgpJdCdzIGJhc2VkIG9uIERhdmUncyBkcm0tbmV4dCB0cmVlIHNvIGl0IG1vdmVzIGZv
cndhcmQgYXMgdGhhdCB0cmVlCm1vdmVzIGZvcndhcmQuICBGcm9tIHRoZSBkcml2ZXIncyBwZXJz
cGVjdGl2ZSwgaXQgaGFzIGFsbCB0aGUgZHJpdmVyCnBhdGNoZXMgc28gdGhlcmUgaXMgbm90aGlu
ZyBtaXNzaW5nIGZyb20gdGhhdCBicmFuY2ggcmVsYXRpdmUgdG8gNS40LgpJZiB5b3Ugd2FudCBh
biB1cGRhdGVkIGJhc2Uga2VybmVsIHRyZWUgdXNlIG15IGRybS1uZXh0IGJyYW5jaC4KCkFsZXgK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
