Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC264C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E8C613C9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E8C613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD9E6EE02;
	Thu, 27 May 2021 03:53:17 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716706EE04;
 Thu, 27 May 2021 03:53:16 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 i23-20020a9d68d70000b02902dc19ed4c15so3201673oto.0; 
 Wed, 26 May 2021 20:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xELwdLuZkH4z5J/GT5DZ6nlHBvDe0H+SPpVnI7wy13g=;
 b=TmggnDhozgQCmX0OhYLFCVOpDbjgeA577yM64a6ut7ns1ezHMJRSgO2pnVjdqj5PJD
 O4V95qVJhmr1vXs1A6LxqWlul6BnPt8LUolysdlJHXbYh0lOOrSeqg0P83GT/QIqZNsB
 T6DlymW8whP61Q0eRhn0gQD9BVRst8fjvJB2fTQ5nMgPcepnJj2bWKXGd5wDkK8LysU7
 XcJylSo1O+w4dYl4AJepSZutperkCMRe45jd/KAUraSplb9Kdf5droC299RyZP7Lfg5E
 LuOQ4FCmx13/Ni6iqeX/4bTIm1W0OoKC35L6kXThacH6YH1f2XPd/luWBAqf1hCiI2bF
 NMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xELwdLuZkH4z5J/GT5DZ6nlHBvDe0H+SPpVnI7wy13g=;
 b=mxUwCC1tnEhcda0x+fmt3Z+6VeoSdjHbwHpdQXAS0S9XtuzrPiq0YjpZX+eSu65GyY
 S14OULcKJWryBX+EmnpJ1N8qqyWWubfmYnXZi2ijoaaLdp0Q50k3dMAfnHTcRH2mTvDh
 c+sulZiOzXaWO8fkmJE7zglpgxkWuvy1QXr2/PjoRjVvHlueJE8gp3fNNhtkYMQu5GSb
 Ty32KbtTijHqef/L8rGJ21EYMkGUY0/66FR16dIrzye7G8vt1r4cD/s8asNJs0YwM+p2
 ZoRL657rVCaWjAfkSdowot2LzWAXTZFTZ1BA4QUJRm3jOsqSlDddCRf+BpFnh/X9Cfpt
 zKNA==
X-Gm-Message-State: AOAM533SaoLpLRjTNU7dtItwebPSDvYGwxudCxyMxk5ngOQ3a9RPoW4R
 kMDdQSMqzURrmhzqXYjdyBXC8qqaB+/Za4cLfCY=
X-Google-Smtp-Source: ABdhPJxAXoDdMyn+j4WUJtKIkYpUXXWDoYsi/wMRZ/HPLvpHKA9KsPceqak3zQssVp8/mTHgjvBFuBMORPohagk6UMs=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr1204608oti.23.1622087595845; 
 Wed, 26 May 2021 20:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-6-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-6-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 May 2021 23:53:04 -0400
Message-ID: <CADnq5_NQSwdhGQOMDAfHj9dWi-e-EYeH8AsTr+XhRwU6DZDgLA@mail.gmail.com>
Subject: Re: [PATCH 05/34] drm/amd/pm/powerplay/hwmgr/vega12_hwmgr: Provide
 'vega12_init_smc_table()' function name
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

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDcgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEyX2h3bWdyLmM6ODEyOiB3YXJuaW5nOiBl
eHBlY3RpbmcgcHJvdG90eXBlIGZvciBJbml0aWFsaXplcyB0aGUgU01DIHRhYmxlIGFuZCB1cGxv
YWRzIGl0KCkuIFByb3RvdHlwZSB3YXMgZm9yIHZlZ2ExMl9pbml0X3NtY190YWJsZSgpIGluc3Rl
YWQKPgo+IENjOiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgo+IENjOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGlu
dXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4g
LS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9od21n
ci5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21n
ci92ZWdhMTJfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdy
L3ZlZ2ExMl9od21nci5jCj4gaW5kZXggMWEwOTdlNjA4ODA4ZS4uMjllMGQxZDQwMzVhZCAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTJf
aHdtZ3IuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3Zl
Z2ExMl9od21nci5jCj4gQEAgLTgwMyw3ICs4MDMsNyBAQCBzdGF0aWMgaW50IHZlZ2ExMl9zYXZl
X2RlZmF1bHRfcG93ZXJfcHJvZmlsZShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQo+ICAjZW5kaWYK
Pgo+ICAvKioKPiAtICogSW5pdGlhbGl6ZXMgdGhlIFNNQyB0YWJsZSBhbmQgdXBsb2FkcyBpdAo+
ICsgKiB2ZWdhMTJfaW5pdF9zbWNfdGFibGUgLSBJbml0aWFsaXplcyB0aGUgU01DIHRhYmxlIGFu
ZCB1cGxvYWRzIGl0Cj4gICAqCj4gICAqIEBod21ncjogIHRoZSBhZGRyZXNzIG9mIHRoZSBwb3dl
cnBsYXkgaGFyZHdhcmUgbWFuYWdlci4KPiAgICogcmV0dXJuOiAgYWx3YXlzIDAKPiAtLQo+IDIu
MzEuMQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
