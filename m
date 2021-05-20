Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B413CC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E46861074
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E46861074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD4DC6F4F3;
	Thu, 20 May 2021 19:15:30 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE73D6F4F0;
 Thu, 20 May 2021 19:15:27 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id z3so17410014oib.5;
 Thu, 20 May 2021 12:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6Zg4vmizJSIriLR9LU2790YKiK+logM7QIyA/FHoq5U=;
 b=uKVjxMBMCiPlK1ONgqo7qgd7w5MARG286PrWgvUYmmIWJRX5w9IIYfdT/a6nJUUCCJ
 nQ61aY30RNUXahoz/Ut+6v2/8E2SP7kyMac5joyCEamIXwySlQHhwRvCt9kCR4+lSxJ+
 ezgdsDRdr8aRU6/KXw+4ck5d72i7h5vj1Gttkzdrg4PNOAULjNd3CWHRdkJj3JwQ2SK1
 rBopRBZ2qG9Z1vlyB2/380L59fQKLJNrQ9LqTYsIIm4ZuOofhwK1wfb1NXz8MQxfRULf
 XvWh3ddH4yGRtwaceVe7IpU5bMuxu2YQUA5xoCudl8hZkemEUUejAVKO6rN26EQ1i9YX
 GFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6Zg4vmizJSIriLR9LU2790YKiK+logM7QIyA/FHoq5U=;
 b=Yhc9B4zwgqJ5rMWDo5bE8+ShDb47H7BziletJTUE82HwpvKJ8GZptj+ZL5wvAGa5Di
 rSXQle2qhTRHpn3vHpjeUGEKvzgZj5joqXg6f/syeDntPzADshcG9r+ePfbFcfyUuqq3
 3h1Zky3qUP/kV4M72M96MJqDWNHlSTBRvanxXziBPy2nIIkTT1hN81uZIdhhuajRXAzC
 4N/cybCaiIzQNrW+bqpgUHHdeflTJkppmT5xtoDmLTNDAk5ebH93jObDEqLNhXQmu8kt
 lPRr+amhAw3ietR34Fa3X96qN17aJSJBBAgQb0nHqUuGpEMWzzYJs7z8OZG/X6XbwFfx
 pyXg==
X-Gm-Message-State: AOAM532z7xNBeLP9mRiqO36UBhlNcF9NSgVcrTHTuWlMVByErYohxojM
 FkD6dMWc6aibCZ9SJnL+wqPmiq15x5ubjnKPtlw=
X-Google-Smtp-Source: ABdhPJzFakh2ykhbWYSIfMClrsTCDR/RlVV7AtZW4ucMxT7ws+DcoO2qHEzPA0somMKUOaKocha3T0eLNyGNR+hyxb8=
X-Received: by 2002:a05:6808:206:: with SMTP id l6mr4188439oie.5.1621538127240; 
 Thu, 20 May 2021 12:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-18-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-18-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:15:16 -0400
Message-ID: <CADnq5_MXcOO_a56RzN-qoTrZ2kCH3u1W-vq1hzxnN7eY29VMzA@mail.gmail.com>
Subject: Re: [PATCH 17/38] drm/amd/amdgpu/dce_v6_0: Repair function name of
 'si_get_number_of_dram_channels()'
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
 Luben Tuikov <luben.tuikov@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDMgQU0g
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9s
bG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9kY2VfdjZfMC5jOjQ2ODogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBm
b3IgY2lrX2dldF9udW1iZXJfb2ZfZHJhbV9jaGFubmVscygpLiBQcm90b3R5cGUgd2FzIGZvciBz
aV9nZXRfbnVtYmVyX29mX2RyYW1fY2hhbm5lbHMoKSBpbnN0ZWFkCj4KPiBDYzogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxp
bnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IEx1YmVu
IFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQt
b2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdjZfMC5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9kY2VfdjZfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
ZGNlX3Y2XzAuYwo+IGluZGV4IGRiY2IwOWNmODNlNjMuLmM3ODAzZGMyYjJkNTMgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3Y2XzAuYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92Nl8wLmMKPiBAQCAtNDU2LDcgKzQ1Niw3IEBAIHN0
YXRpYyB2b2lkIGRjZV92Nl8wX3Byb2dyYW1fZm10KHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2Rl
cikKPiAgfQo+Cj4gIC8qKgo+IC0gKiBjaWtfZ2V0X251bWJlcl9vZl9kcmFtX2NoYW5uZWxzIC0g
Z2V0IHRoZSBudW1iZXIgb2YgZHJhbSBjaGFubmVscwo+ICsgKiBzaV9nZXRfbnVtYmVyX29mX2Ry
YW1fY2hhbm5lbHMgLSBnZXQgdGhlIG51bWJlciBvZiBkcmFtIGNoYW5uZWxzCj4gICAqCj4gICAq
IEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKPiAgICoKPiAtLQo+IDIuMzEuMQo+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
