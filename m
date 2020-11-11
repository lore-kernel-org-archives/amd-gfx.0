Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126C4C55ABD
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 00:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797A220867
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 00:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDg1LEsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797A220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D948389D3E;
	Wed, 11 Nov 2020 00:04:04 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B5AC89D3E;
 Wed, 11 Nov 2020 00:04:03 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id d142so200789wmd.4;
 Tue, 10 Nov 2020 16:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rNl9gNKZYZT246LX4GtxHccG2jhMqzr9fQn7LRfzp9A=;
 b=mDg1LEsF9L8Q+Y64fd0woALGzY7ke9f5XWKGDEnDBwz1f06dkzSRE6rasYzWdM3aE9
 wq1kP5Mhril+nExoYVnhi/nw2z9fm44tFKWxAS1QjdtagopkAoCVpgdrnmbw+CmsnXKb
 JTSUS8ApJzzHPu5AWUyLGmABzCZneopM0dw8L1Q6955DXsY96O0xUALvMhLxjum/a5ha
 opaHNCZe6LEXhBmxZ6VkbzNiq2ilOvb5sNksuXZKRX5XrewdtV/DnjHJFXrZhbmk3czT
 3tBN9iJ7pHasz0Fq6/ba4GHH2MOO9psOX5e1k86VTT1ehTNs+vIiXyvE3EfPeeKr7Kt4
 BSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rNl9gNKZYZT246LX4GtxHccG2jhMqzr9fQn7LRfzp9A=;
 b=VFKAz5a2K2Z/7H8IpfsEPI3C04yYWlMEwUWst/KJSeC8enm/FaB82jFhxVzK5UYLQV
 LQ14xTvHAb8f0ECVFWilMJ13SxcpSeV4DAuTvkdKnPmPjL0PA7YgZlWf4JrX30sgmMEM
 BaCS80Ussd+s9gt1K1+89t3cgMzAVj/XvsdbkQpabGgzV2+wDmFBdmjEkh0R0mgo/kUU
 vYzqbsGJPXZYk5d/KAXgbPSKtVOYWHVh5OmP/0B3S/VN8U+spaQLr9rbRTETBKug6LVZ
 oAnxD1Ii02ibtTC36UjCQsRQXdtqCB7t7tsrA3875StdTo4K946S+r7u8P2dIePti0s4
 8/Tw==
X-Gm-Message-State: AOAM530LOklFLTuWY/uYvLns9EYr16rgAQShpILfUc6VMCwjVOvLpUbn
 tYsRYgiSoay86hXbw5pPG0o2OTMlO32PCnDRMZQ=
X-Google-Smtp-Source: ABdhPJwpOTI1nN6UuRTxjd5/p73Uf6kM8+6ur8drWXqYDzSpM0mDXMEuqSEq2Eq2R9eZGkvRphtJ4uxHkTHNZ/PG/qM=
X-Received: by 2002:a1c:6302:: with SMTP id x2mr689378wmb.56.1605053041916;
 Tue, 10 Nov 2020 16:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org>
 <20201110193112.988999-28-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-28-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2020 19:03:50 -0500
Message-ID: <CADnq5_OrKhZnZKhBcQaDWwSyJhtv6pQJEd9Byx0ZEG_GW-uEWA@mail.gmail.com>
Subject: Re: [PATCH 27/30] drm/radeon/ni: Remove set but unused variable
 'mc_shared_chmap'
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

T24gVHVlLCBOb3YgMTAsIDIwMjAgYXQgMjozMiBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vbmkuYzogSW4gZnVuY3Rpb24g
4oCYY2F5bWFuX2dwdV9pbml04oCZOgo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pLmM6ODgw
OjY6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmG1jX3NoYXJlZF9jaG1hcOKAmSBzZXQgYnV0IG5vdCB1
c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQo+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4K
PiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
U2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFwcGxpZWQu
ICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pLmMgfCA0
ICsrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL25pLmMgYi9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL25pLmMKPiBpbmRleCAxMmRkMDgyMDY5NjQ5Li4xYzkwMzBhNDYzMWI4IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vbmkuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vbmkuYwo+IEBAIC04NzcsNyArODc3LDcgQEAgaW50IHRuX2dldF90ZW1w
KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQo+ICBzdGF0aWMgdm9pZCBjYXltYW5fZ3B1X2lu
aXQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4gIHsKPiAgICAgICAgIHUzMiBnYl9hZGRy
X2NvbmZpZyA9IDA7Cj4gLSAgICAgICB1MzIgbWNfc2hhcmVkX2NobWFwLCBtY19hcmJfcmFtY2Zn
Owo+ICsgICAgICAgdTMyIG1jX2FyYl9yYW1jZmc7Cj4gICAgICAgICB1MzIgY2d0c190Y2NfZGlz
YWJsZTsKPiAgICAgICAgIHUzMiBzeF9kZWJ1Z18xOwo+ICAgICAgICAgdTMyIHNteF9kY19jdGww
Owo+IEBAIC0xMDAyLDcgKzEwMDIsNyBAQCBzdGF0aWMgdm9pZCBjYXltYW5fZ3B1X2luaXQoc3Ry
dWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4KPiAgICAgICAgIGV2ZXJncmVlbl9maXhfcGNpX21h
eF9yZWFkX3JlcV9zaXplKHJkZXYpOwo+Cj4gLSAgICAgICBtY19zaGFyZWRfY2htYXAgPSBSUkVH
MzIoTUNfU0hBUkVEX0NITUFQKTsKPiArICAgICAgIFJSRUczMihNQ19TSEFSRURfQ0hNQVApOwo+
ICAgICAgICAgbWNfYXJiX3JhbWNmZyA9IFJSRUczMihNQ19BUkJfUkFNQ0ZHKTsKPgo+ICAgICAg
ICAgdG1wID0gKG1jX2FyYl9yYW1jZmcgJiBOT09GQ09MU19NQVNLKSA+PiBOT09GQ09MU19TSElG
VDsKPiAtLQo+IDIuMjUuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
