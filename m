Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D594C2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 16:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC03D20715
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 16:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChTECUkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC03D20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 469EA6E4B1;
	Tue, 24 Nov 2020 16:27:41 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8206E4B1;
 Tue, 24 Nov 2020 16:27:40 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id p22so2923794wmg.3;
 Tue, 24 Nov 2020 08:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=a025llBjrOgh57FwURmzXOqxqtmRhk0DL79snbqwcHs=;
 b=ChTECUklJcsQ3TMYgEboImd53xNjfpMqloeOZ4lZhjyxWxAs06Aj+G3MoJwDHoJgJ/
 9POE4CKA1o2hh7EadKWBXCst0rH00OzOJbh8/e2KWY6TUY88bRhbdTt9QLEgpkURXnPP
 n3w7xK+TOCR0KWOfItbjF+H5ethAkG+FaImhMTi0tYKATX6qg8QiAHbMwjuQ6sLM7E1S
 cfJHqul9g+j7o1gyCrulnxsyVoyAwhJHKXDCfDPJkIbX7iAJ8DPmKXKyYzLYodQ7p5Fc
 zYLo87YI/3XYhyuBoZbeXexBfVKQKzoeKrrFC+RFHxuUbEKLlbprvkD3vx5GNi14cUex
 Y2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=a025llBjrOgh57FwURmzXOqxqtmRhk0DL79snbqwcHs=;
 b=VHuAZ4fQnfL/6EUxlOpo3FnhTE8UES2DuVe0uvAV0V+8egnCRCoje/MzB9hkZkPCqB
 C/C6l5Bk5nFufK/S3OTOmr02LKo0DykvkrMe1cJ94yi4t20W3LZob4wJMlqpMmYKYxCG
 iyxoxYPK0+srBcl6sEH/CTD7Ga32f42OsAM/WOXO/DnQSnVPAEhVOQ6orKi3Y2mClgVi
 rlbCm9Nd8rpUWA5XDCnrzjMsbKbFVRmaJBFErPbn1GBOrZcAGd5oBmSasLEMHaKeaT47
 FuiAvcA+weVzm4IiMWO6DuVzV1pYey6nLvXIONfbXip8Fw8jJAyMnxgg5omUeHvJvmRu
 T1JQ==
X-Gm-Message-State: AOAM532nx8GHv135tCJ5ePcV4XmHBR8eESR+sXcLZ1X/I9GVF0WFUGRw
 vgWyMXFFocJGHP+uKGkBJz+HzxTpj/7SZAgMPLw=
X-Google-Smtp-Source: ABdhPJykG7KoA+/cvCSiQx0SduJ3Pe5sSnnrlFsfIvCn+1uFMmBfOyFbLoqUuznnxZTbnzabnczxC0PvbEVbSUtTuA8=
X-Received: by 2002:a1c:f017:: with SMTP id a23mr5301350wmb.56.1606235259096; 
 Tue, 24 Nov 2020 08:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org>
 <20201123111919.233376-40-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-40-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Nov 2020 11:27:28 -0500
Message-ID: <CADnq5_OxLOWfQ3Y=zkn7t9aP4BeeFKyHCRU9Thpv0-6=tgg1Fw@mail.gmail.com>
Subject: Re: [PATCH 39/40] drm/amd/amdgpu/gmc_v9_0: Remove unused table
 'ecc_umc_mcumc_status_addrs'
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
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBOb3YgMjMsIDIwMjAgYXQgNjoyMCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmM6Mzgy
OjIzOiB3YXJuaW5nOiDigJhlY2NfdW1jX21jdW1jX3N0YXR1c19hZGRyc+KAmSBkZWZpbmVkIGJ1
dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQo+Cj4gQ2M6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51
eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFw
cGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nbWNfdjlfMC5jIHwgMzUgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIDEgZmlsZSBj
aGFuZ2VkLCAzNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5
XzAuYwo+IGluZGV4IDBjMzQyMWQ1ODdlODcuLmZiZWU0M2I0YmE2NGQgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiBAQCAtMzc5LDQxICszNzksNiBAQCBzdGF0aWMg
Y29uc3QgdWludDMyX3QgZWNjX3VtY19tY3VtY19jdHJsX21hc2tfYWRkcnNbXSA9IHsKPiAgICAg
ICAgICgweDAwMWQ0M2UwICsgMHgwMDAwMTgwMCksCj4gIH07Cj4KPiAtc3RhdGljIGNvbnN0IHVp
bnQzMl90IGVjY191bWNfbWN1bWNfc3RhdHVzX2FkZHJzW10gPSB7Cj4gLSAgICAgICAoMHgwMDAx
NDNjMiArIDB4MDAwMDAwMDApLAo+IC0gICAgICAgKDB4MDAwMTQzYzIgKyAweDAwMDAwODAwKSwK
PiAtICAgICAgICgweDAwMDE0M2MyICsgMHgwMDAwMTAwMCksCj4gLSAgICAgICAoMHgwMDAxNDNj
MiArIDB4MDAwMDE4MDApLAo+IC0gICAgICAgKDB4MDAwNTQzYzIgKyAweDAwMDAwMDAwKSwKPiAt
ICAgICAgICgweDAwMDU0M2MyICsgMHgwMDAwMDgwMCksCj4gLSAgICAgICAoMHgwMDA1NDNjMiAr
IDB4MDAwMDEwMDApLAo+IC0gICAgICAgKDB4MDAwNTQzYzIgKyAweDAwMDAxODAwKSwKPiAtICAg
ICAgICgweDAwMDk0M2MyICsgMHgwMDAwMDAwMCksCj4gLSAgICAgICAoMHgwMDA5NDNjMiArIDB4
MDAwMDA4MDApLAo+IC0gICAgICAgKDB4MDAwOTQzYzIgKyAweDAwMDAxMDAwKSwKPiAtICAgICAg
ICgweDAwMDk0M2MyICsgMHgwMDAwMTgwMCksCj4gLSAgICAgICAoMHgwMDBkNDNjMiArIDB4MDAw
MDAwMDApLAo+IC0gICAgICAgKDB4MDAwZDQzYzIgKyAweDAwMDAwODAwKSwKPiAtICAgICAgICgw
eDAwMGQ0M2MyICsgMHgwMDAwMTAwMCksCj4gLSAgICAgICAoMHgwMDBkNDNjMiArIDB4MDAwMDE4
MDApLAo+IC0gICAgICAgKDB4MDAxMTQzYzIgKyAweDAwMDAwMDAwKSwKPiAtICAgICAgICgweDAw
MTE0M2MyICsgMHgwMDAwMDgwMCksCj4gLSAgICAgICAoMHgwMDExNDNjMiArIDB4MDAwMDEwMDAp
LAo+IC0gICAgICAgKDB4MDAxMTQzYzIgKyAweDAwMDAxODAwKSwKPiAtICAgICAgICgweDAwMTU0
M2MyICsgMHgwMDAwMDAwMCksCj4gLSAgICAgICAoMHgwMDE1NDNjMiArIDB4MDAwMDA4MDApLAo+
IC0gICAgICAgKDB4MDAxNTQzYzIgKyAweDAwMDAxMDAwKSwKPiAtICAgICAgICgweDAwMTU0M2My
ICsgMHgwMDAwMTgwMCksCj4gLSAgICAgICAoMHgwMDE5NDNjMiArIDB4MDAwMDAwMDApLAo+IC0g
ICAgICAgKDB4MDAxOTQzYzIgKyAweDAwMDAwODAwKSwKPiAtICAgICAgICgweDAwMTk0M2MyICsg
MHgwMDAwMTAwMCksCj4gLSAgICAgICAoMHgwMDE5NDNjMiArIDB4MDAwMDE4MDApLAo+IC0gICAg
ICAgKDB4MDAxZDQzYzIgKyAweDAwMDAwMDAwKSwKPiAtICAgICAgICgweDAwMWQ0M2MyICsgMHgw
MDAwMDgwMCksCj4gLSAgICAgICAoMHgwMDFkNDNjMiArIDB4MDAwMDEwMDApLAo+IC0gICAgICAg
KDB4MDAxZDQzYzIgKyAweDAwMDAxODAwKSwKPiAtfTsKPiAtCj4gIHN0YXRpYyBpbnQgZ21jX3Y5
XzBfZWNjX2ludGVycnVwdF9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgICAg
ICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9pcnFfc3JjICpzcmMsCj4gICAgICAgICAgICAgICAg
IHVuc2lnbmVkIHR5cGUsCj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
