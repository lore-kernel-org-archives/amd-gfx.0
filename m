Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5049FC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 21:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE20206DC
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 21:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE20206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77A566E34D;
	Mon,  2 Dec 2019 21:31:49 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5773E6E34A;
 Mon,  2 Dec 2019 21:31:47 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id s14so1164394wmh.4;
 Mon, 02 Dec 2019 13:31:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zycfz/fltNjwNJCKwHtS1/dslZ9HHioet7o+SNO2dSk=;
 b=L74QLHgo1jaOjFpwAxLJgAK0oXJJncjrH6knYqRdPY6kuW1cft7WAb6QKjT8q/4Nyh
 yQtgvxYDstAXDukr485UoNLrkveP3ABBmF0HPa0JckdC2eEzxQF+he2JlFByyeE5S6EC
 78Nt9Tbfk3fjAR1gNFBwn21SX6JlRkV1oJokUbVBa/ClAiCG9e57MPBEnlfHYz96L49G
 grFZd3aHQ1aYeukYWmNfSYypIbRfOwhCbjtSxLjLnYl2i/svMY0TUr0cwxzmfDyim1CL
 w/fZz7NMbY6R1VONtG+urlhBe+z9FrlIJCN2SdvsX/P4VLOlURvXEozpOn13Nw20BVB5
 DtmA==
X-Gm-Message-State: APjAAAUOxds1RajKrVZKfMmNwQkNSBmVb8EfYvHD6o3HYSQEBtIM7Aqu
 44EWH5jrwPF6ZdSa3uaJrYg/gAsI9RAECsEmEOQ=
X-Google-Smtp-Source: APXvYqwjfm+6FL2lka6ugfRgKUTTq3dtH1mRYJOP9BXtpe5mE1wcfzuA2vdWsPPg8sLYuz1GXYFaksgzGLSIpwqEZNs=
X-Received: by 2002:a7b:c1d3:: with SMTP id a19mr32263175wmj.127.1575322305937; 
 Mon, 02 Dec 2019 13:31:45 -0800 (PST)
MIME-Version: 1.0
References: <1574908300-126787-1-git-send-email-zhengbin13@huawei.com>
 <d007a0ff-6298-93d0-7af2-289582927332@amd.com>
In-Reply-To: <d007a0ff-6298-93d0-7af2-289582927332@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Dec 2019 16:31:33 -0500
Message-ID: <CADnq5_ONj+4m=FyOZ9eCSp4RHy-DamJb9=ufA_iS+7yde2W7zQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/amd/display: Remove unneeded semicolon
To: Harry Wentland <hwentlan@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=zycfz/fltNjwNJCKwHtS1/dslZ9HHioet7o+SNO2dSk=;
 b=prsjiL7iIPCKp60AXWNKQzycLOAhhfCWDcu+IGjziQHpebUnBWjefZIRfYlvgZfZSA
 QhTyTRVdx+USklQeSWl25iSiQX7umOUDkZ8yBDJtwG5Od2R2NbZqrLuE5POlvKlVLn/S
 Mh3ze3OTB0pOgqu/KQPZHCINN0irrIbJYfYW6fR+g6HIURhYf7s+S2Ndo0R5kpD25jGH
 ST+zxjUEq2dFF1NEzMbE80yV2AVJSnU9zW9rlbYiLRnIaGkDYAui/MFodj1q3hFbyZdo
 Q9WNRM5Pu662+Sq9uXz/7CgjzKg5p5wMhQeyX9EPgG70x48bLkhJh+8ozTzsKSmMcgKb
 jB8Q==
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, zhengbin <zhengbin13@huawei.com>,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZCB0aGUgc2VyaWVzLiAgVGhhbmtzIQoKQWxleAoKT24gVGh1LCBOb3YgMjgsIDIwMTkg
YXQgOTo0NiBBTSBIYXJyeSBXZW50bGFuZCA8aHdlbnRsYW5AYW1kLmNvbT4gd3JvdGU6Cj4KPiBT
ZXJpZXMgaXMKPiBSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFt
ZC5jb20+Cj4KPiBIYXJyeQo+Cj4gT24gMjAxOS0xMS0yNyA5OjMxIHAubS4sIHpoZW5nYmluIHdy
b3RlOgo+ID4gemhlbmdiaW4gKDQpOgo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IFJlbW92ZSB1bm5l
ZWRlZCBzZW1pY29sb24gaW4gYmlvc19wYXJzZXIuYwo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IFJl
bW92ZSB1bm5lZWRlZCBzZW1pY29sb24gaW4gYmlvc19wYXJzZXIyLmMKPiA+ICAgZHJtL2FtZC9k
aXNwbGF5OiBSZW1vdmUgdW5uZWVkZWQgc2VtaWNvbG9uIGluIGhkY3AuYwo+ID4gICBkcm0vYW1k
L2Rpc3BsYXk6IFJlbW92ZSB1bm5lZWRlZCBzZW1pY29sb24gaW4gZGlzcGxheV9ycV9kbGdfY2Fs
Y18yMS5jCj4gPgo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3Nf
cGFyc2VyLmMgICAgICAgICAgICAgICAgIHwgMiArLQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyMi5jICAgICAgICAgICAgICAgIHwgMiArLQo+ID4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMjEvZGlzcGxheV9ycV9kbGdf
Y2FsY18yMS5jIHwgNCArKy0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVs
ZXMvaGRjcC9oZGNwLmMgICAgICAgICAgICAgICAgICAgfCAyICstCj4gPiAgNCBmaWxlcyBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gPgo+ID4gLS0KPiA+IDIuNy40
Cj4gPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
