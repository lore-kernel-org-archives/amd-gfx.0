Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DEFC433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 13:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074B3207DF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 13:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3HmqhIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074B3207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6FF6E138;
	Fri, 28 Aug 2020 13:38:39 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BEFA6E138
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 13:38:39 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id c15so1328578wrs.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=B4zHAsTWeUcoaP2Fg7n4EVIwqRh+DesLhIdHVKIarrQ=;
 b=u3HmqhIajubDumwJLBAl7L0JQ53b1oF8HN894pGpxhL2mRKi7dzkgeVM0iqo1xzWl8
 u/PkPCXpa6RsCwKqXjvG1O5TWfrNJ7dt3Tv1QqzlJXSEkUFDcKzn+L5U7MQiTiQzSx7x
 zG3dc3omgJU4z/r1vwPHaGayxqm3gPRc0oS3h491LRochgtaUJPkBURie8xSQYoVcKil
 zuuRSo6UzIMhvu++/VUVzxN5G0c9fyzGNOpqVOcs9cTlrkIiMJ2VZogMkgyvOobt8cT3
 EZMfbxYOVBp6bTKeKCbaP9DpnFUiQ5OvANztEXG1D6Lgn++OrShKCt4rQrJU1g8vuNCx
 KyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=B4zHAsTWeUcoaP2Fg7n4EVIwqRh+DesLhIdHVKIarrQ=;
 b=kpl8kgWAa790Cwg8BopJeRG3R+EaJ9RMp+dQAtUtuJDSnoTHuUKMPnM5nx1kH8v3MH
 qLkAPVCIdSR3fUPkYMYEJ7fKDEP9bUq6kZgn0lR2BFfOkb/8XOBjjAQXsbBq9i8ujd2Y
 E7JuWLRZ242c7ibCLvRC72j4a+kCHAfbCNt9ZcoGICeN5+qhMpn3deiDnU9NrTOWJOOs
 95FZgKCXnxuX9tTbeBc6ocLuqYicTEdTjh5nWNBTNNKXpVdB3NemIZ1Hq2MfOVlqyB2Q
 44tfHE+MGlCzDzhLhbGUky38Tqy1XL2IhkjT8p3Dzwc5i0C7W2fklZL02cSxtagN5wlG
 jtTQ==
X-Gm-Message-State: AOAM5327v54mSwJtPIAm9DRH0Sq6xdJqAInmHchC5+F9FKv791iN4gEn
 9+Hs2OLWhimiJL5jlNGSgH6kReO1dhZpLq4W6DSMkuD9
X-Google-Smtp-Source: ABdhPJwyWSimjw7C+2bFP2LOybmZCV2JfPKicZMagAUJXZUbl4UPUGsR6FyD5E0yD9dtENdaRJBbso1Tp13En3wGZGY=
X-Received: by 2002:adf:fecc:: with SMTP id q12mr1643451wrs.374.1598621917797; 
 Fri, 28 Aug 2020 06:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200824161527.2001591-1-alexander.deucher@amd.com>
 <20200824161527.2001591-3-alexander.deucher@amd.com>
 <62c44d4c-ece3-5e61-7d20-2d8da9734a1a@gmail.com>
In-Reply-To: <62c44d4c-ece3-5e61-7d20-2d8da9734a1a@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Aug 2020 09:38:26 -0400
Message-ID: <CADnq5_NSEURcJgMpd3EH7UFEqLW9ib6yrvOELFm0BXxoj4kcaw@mail.gmail.com>
Subject: Re: [PATCH 3/8] drm/amdgpu: add pre_asic_init callback for SI
To: Christian Koenig <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBBdWcgMjgsIDIwMjAgYXQgNDowNiBBTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAyNC4wOC4yMCB1bSAxODox
NSBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiA+IE5vdGhpbmcgdG8gZG8gZm9yIHRoaXMgZmFtaWx5
Lgo+Cj4gVWZmLCBuby4gQ2FuJ3Qgd2UganVzdCBtYWtlIHRoZSBjYWxsYmFjayBvcHRpb25hbD8K
PgoKSSBndWVzcyB3ZSBjb3VsZCwgYnV0IGFsbCBvZiB0aGUgb3RoZXIgYXNpYyBjYWxsYmFja3Mg
YXJlIGFzc3VtZWQgdG8gYmUgcHJlc2VudC4KCkFsZXgKCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+ID4gLS0tCj4gPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpLmMgfCA1ICsrKysrCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc2kuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpLmMKPiA+IGlu
ZGV4IGVhYTJmMDcxYjEzOS4uNDU1ZDVlMzY2YzY5IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc2kuYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc2kuYwo+ID4gQEAgLTE4NzEsNiArMTg3MSwxMCBAQCBzdGF0aWMgaW50IHNpX3NldF92Y2Vf
Y2xvY2tzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1MzIgZXZjbGssIHUzMiBlY2NsaykK
PiA+ICAgICAgIHJldHVybiAwOwo+ID4gICB9Cj4gPgo+ID4gK3N0YXRpYyB2b2lkIHNpX3ByZV9h
c2ljX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gPiArewo+ID4gK30KPiA+ICsK
PiA+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfYXNpY19mdW5jcyBzaV9hc2ljX2Z1bmNz
ID0KPiA+ICAgewo+ID4gICAgICAgLnJlYWRfZGlzYWJsZWRfYmlvcyA9ICZzaV9yZWFkX2Rpc2Fi
bGVkX2Jpb3MsCj4gPiBAQCAtMTg5Miw2ICsxODk2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBh
bWRncHVfYXNpY19mdW5jcyBzaV9hc2ljX2Z1bmNzID0KPiA+ICAgICAgIC5uZWVkX3Jlc2V0X29u
X2luaXQgPSAmc2lfbmVlZF9yZXNldF9vbl9pbml0LAo+ID4gICAgICAgLmdldF9wY2llX3JlcGxh
eV9jb3VudCA9ICZzaV9nZXRfcGNpZV9yZXBsYXlfY291bnQsCj4gPiAgICAgICAuc3VwcG9ydHNf
YmFjbyA9ICZzaV9hc2ljX3N1cHBvcnRzX2JhY28sCj4gPiArICAgICAucHJlX2FzaWNfaW5pdCA9
ICZzaV9wcmVfYXNpY19pbml0LAo+ID4gICB9Owo+ID4KPiA+ICAgc3RhdGljIHVpbnQzMl90IHNp
X2dldF9yZXZfaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
