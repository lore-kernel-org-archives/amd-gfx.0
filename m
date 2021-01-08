Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B61C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0DE023A80
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DE023A80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D4F89449;
	Fri,  8 Jan 2021 21:21:24 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B94789320;
 Fri,  8 Jan 2021 21:21:22 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id j21so2709972oou.11;
 Fri, 08 Jan 2021 13:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6Lpk5Nv67FloCKNgJyqOZp3CuSqmycAftdWsVy2MVY8=;
 b=JofLM2g4qOdL/1LisOZ/7pwproBEDUQX5RuX2+p4EQhwSKhTJtOioUVfePZuYnPTgk
 o7sq//QH/ZIC0PX/1pr6HHs/SIcrLl6O1nHY7nvIvM3VAd33tV63zl80Na3qJRK39a4/
 VD2EGGmwT9XJs75Ie80eP1qTJKMYjLn9HfAwA6t4s8PjyfhAr4hnn7XaSwtmQ9cZD0H/
 kHx1WlSTxMoZ72m4obBWQrRzr5z3qhRnyrsix30dhvwuBA6NxqCC0r1NQExCuN73Z86N
 7e9CXiMWBKbGvjLlfH1c4hGscdPazEYgL8fJ09t16SeJYVilMW+vYYk9ZRGNZxTfNHib
 q81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6Lpk5Nv67FloCKNgJyqOZp3CuSqmycAftdWsVy2MVY8=;
 b=WXXmZyue1C50OEQa4Mq2X9qd/eJ/GQw2Nqc1MS+AWpYDyjNbiCQRaivBrH1MxeyfSY
 q/hLzBe4bynL1AUKiNlx1R51QQbW9Sd2RSImiXyNpff+1WUCUhh8ite/AyvZRbbq6AnP
 /aJvJ1M0wXe2hU7a1yu8vGt0vox32QcaCKWgfEd/gC0rHmkDmbTgJPfgb128yjmd+XFZ
 Ehao7lQy/j2WDXWvy8SMNJxIi3+zzaZ9Rx+yvvaIVOvlPC4Vi8HBcVA1QActE2fsKpUV
 7pFsxztNzqUO+Zs/aZEstKCNwwz6AJ0UNeU8LeMbFdSKWwbAe4xbZEc75abe84nC1AoX
 xUiw==
X-Gm-Message-State: AOAM5307x1uPdniP5iY4g/uiMKPHKY9awSo+rTgYCgC6cXKzlhkqFcDH
 OVBFlxdUJqW2H/eptXNFWz8miwtgZEsucu/zFEE=
X-Google-Smtp-Source: ABdhPJwQt80yhixZjvEfkgfZaFjtYpFY+vEbRMPf8v5ZRXKhLXU1iA9vOFs8uzULqYySxidd4F9IjxYSKZF5StHfp9M=
X-Received: by 2002:a4a:a2c5:: with SMTP id r5mr5583822ool.72.1610140881856;
 Fri, 08 Jan 2021 13:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org>
 <20210108201457.3078600-33-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-33-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Jan 2021 16:21:10 -0500
Message-ID: <CADnq5_O-f1rMA61GmaoYQmDFH9wS-QPs3=gBT2vm8ujhdf=F+g@mail.gmail.com>
Subject: Re: [PATCH 32/40] drm/amd/display/dc/dce/dce_aux: Remove unused
 function 'get_engine_type'
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKYW4gOCwgMjAyMSBhdCAzOjE2IFBNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+IHdyb3RlOgo+Cj4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdh
cm5pbmcocyk6Cj4KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9k
Y2UvZGNlX2F1eC5jOjM5MToyNTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDi
gJhnZXRfZW5naW5lX3R5cGXigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+Cj4gQ2M6IEhhcnJ5
IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+IENjOiBMZW8gTGkgPHN1bnBlbmcu
bGlAYW1kLmNvbT4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
Pgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBD
YzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxk
YW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6
IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCj4gLS0t
Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5jIHwgNiAtLS0t
LS0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXV4LmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXguYwo+IGluZGV4IGNkYTVmZDA0NjRiYzUuLjMy
MDQyOTJhNWFlYWUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjZS9kY2VfYXV4LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNl
L2RjZV9hdXguYwo+IEBAIC0zODgsMTIgKzM4OCw2IEBAIHN0YXRpYyBlbnVtIGF1eF9jaGFubmVs
X29wZXJhdGlvbl9yZXN1bHQgZ2V0X2NoYW5uZWxfc3RhdHVzKAo+ICAgICAgICAgfQo+ICB9Cj4K
PiAtZW51bSBpMmNhdXhfZW5naW5lX3R5cGUgZ2V0X2VuZ2luZV90eXBlKAo+IC0gICAgICAgICAg
ICAgICBjb25zdCBzdHJ1Y3QgZGNlX2F1eCAqZW5naW5lKQo+IC17Cj4gLSAgICAgICByZXR1cm4g
STJDQVVYX0VOR0lORV9UWVBFX0FVWDsKPiAtfQo+IC0KPiAgc3RhdGljIGJvb2wgYWNxdWlyZSgK
PiAgICAgICAgIHN0cnVjdCBkY2VfYXV4ICplbmdpbmUsCj4gICAgICAgICBzdHJ1Y3QgZGRjICpk
ZGMpCj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
