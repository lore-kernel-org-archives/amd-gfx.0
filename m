Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4424C63697
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 15:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CB722275
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 15:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+NeEp6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CB722275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E6A6E528;
	Fri, 13 Nov 2020 15:28:41 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F83C6E526;
 Fri, 13 Nov 2020 15:28:39 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id u12so3110008wrt.0;
 Fri, 13 Nov 2020 07:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lWsBIbzny/xwNajMn0klMvDCPThd3TvZoHWCU+gRxuY=;
 b=o+NeEp6/FY6XqI2xnYxSbY4r+O3vSN63IkmmkQh86acoExcNenXzBp6Ae0eeG13zyW
 r6Gi4XAdxZjLcXiE0zvKLBfZtwAd1/jhYxSgSXmxYiA0jkrAIDwvXMu8iWragqYR9EGu
 16IHNqwijiH7Rbthf3FcESTArUe5ltGxKoYR+LITMpPPUqoBbZsiBXcBy3Qwm5ksBz1B
 HvzUCm4uQ1e8p0vakEvewrpU0eeXWcCnQJQSXN14q7Uv9bqR3PeII9jk4W5MMRwxwU/K
 73Lq48Zg2nQ4NBL+3Ta+fQBOQy8O7i17YlheT1lWYWbljRuVl3XTCHDfOJEQ79dgYxx1
 +Tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lWsBIbzny/xwNajMn0klMvDCPThd3TvZoHWCU+gRxuY=;
 b=qkxuFgj2uvQ9+SXdhUs+5jp2OsoiQmLXMVVaAreKlymrFoFhIYOUH5rN8iEqDhACm+
 ee52lX/9gA+5wJAe7QUS8kNqbOQpKC0r0RijfoP8TtUuHSVFJDetjVqQbvrSxREIoiU5
 RT5OsLBizWxv0GTXedg66AkruqIPdGV2u7REfW1SwGlt3NvfZNzqgOqi/lCQcpm8bDPO
 gsFo/IPFuKuoU3F5vLeSFk6htMz9uqm0pOR9UT3+P3rABk61xs9Zi4cupk+TGpnuXj0b
 KrUep+fZ5LEzmoNK0DYgO/BYdvX8Qc86juczHP11P8LU6YRf6EaJHglWBQnn1vZdoaa5
 os/g==
X-Gm-Message-State: AOAM530qvGhZPMGHFJ+Tz2CU2tQB88hRE5Ssdu98C4gyae3HD8fxKJO3
 6L8cvbQybdqrhDkzbVEE00b8GMQGa28DCRe6WJk=
X-Google-Smtp-Source: ABdhPJwCHliBgCXs9vpIVjVSNXsT6sjATmH6wx2AhG+BNxMNJTRfn4Mon8gdGepLe7JgYnl+nXZt7hDoB8JEhLbpsLA=
X-Received: by 2002:a5d:6992:: with SMTP id g18mr4108548wru.362.1605281312734; 
 Fri, 13 Nov 2020 07:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-4-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-4-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Nov 2020 10:28:21 -0500
Message-ID: <CADnq5_M0ZugpOOr7gez3sySomqMgb09JWn8XxX1otiYcR=0YNA@mail.gmail.com>
Subject: Re: [PATCH 03/40] drm/amd/display/dc/core/dc_link_ddc: Move
 DP_DVI_CONVERTER_ID_{4, 5} to where they're used
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

T24gRnJpLCBOb3YgMTMsIDIwMjAgYXQgODo1MCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IFRoaXMgcGF0Y2ggZml4ZXMgPjIwMCB3YXJuaW5ncy4KPgo+IEZp
eGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3YXJuaW5nKHMpOgo+Cj4gIGZyb20g
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2Rt
LmM6MzE6Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvaW5jbHVkZS9k
ZGNfc2VydmljZV90eXBlcy5oOjEyNjoyMjogd2FybmluZzog4oCYRFBfRFZJX0NPTlZFUlRFUl9J
RF814oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCj4g
IDEyNiB8IHN0YXRpYyBjb25zdCB1aW50OF90IERQX0RWSV9DT05WRVJURVJfSURfNVtdID0gIjMz
OTNOMiI7Cj4gIHwgXn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvaW5jbHVkZS9kZGNfc2VydmljZV90eXBlcy5oOjEyNToyMjogd2Fy
bmluZzog4oCYRFBfRFZJX0NPTlZFUlRFUl9JRF804oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFst
V3VudXNlZC1jb25zdC12YXJpYWJsZT1dCj4gIDEyNSB8IHN0YXRpYyBjb25zdCB1aW50OF90IERQ
X0RWSV9DT05WRVJURVJfSURfNFtdID0gIm0yRFZJYSI7Cj4gIHwgXn5+fn5+fn5+fn5+fn5+fn5+
fn5+Cj4KPiBDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4gQ2M6
IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6
IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNpZ25l
ZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpBcHBsaWVkLiAgVGhh
bmtzIQoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGNfbGlua19kZGMuYyAgICAgICB8IDQgKysrKwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvaW5jbHVkZS9kZGNfc2VydmljZV90eXBlcy5oIHwgNCAtLS0tCj4gIDIgZmlsZXMgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZGRjLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RkYy5jCj4gaW5kZXggNTRiZWRhNGQ0
ZTg1ZC4uYzU5MzZlMDY0MzYwNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvY29yZS9kY19saW5rX2RkYy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGNfbGlua19kZGMuYwo+IEBAIC0zNyw2ICszNywxMCBAQAo+ICAjaW5j
bHVkZSAiZGNfbGlua19kZGMuaCIKPiAgI2luY2x1ZGUgImRjZS9kY2VfYXV4LmgiCj4KPiArLypE
UCB0byBEdWFsIGxpbmsgRFZJIGNvbnZlcnRlciovCj4gK3N0YXRpYyBjb25zdCB1aW50OF90IERQ
X0RWSV9DT05WRVJURVJfSURfNFtdID0gIm0yRFZJYSI7Cj4gK3N0YXRpYyBjb25zdCB1aW50OF90
IERQX0RWSV9DT05WRVJURVJfSURfNVtdID0gIjMzOTNOMiI7Cj4gKwo+ICAjZGVmaW5lIEFVWF9Q
T1dFUl9VUF9XQV9ERUxBWSA1MDAKPiAgI2RlZmluZSBJMkNfT1ZFUl9BVVhfREVGRVJfV0FfREVM
QVkgNzAKPiAgI2RlZmluZSBJMkNfT1ZFUl9BVVhfREVGRVJfV0FfREVMQVlfMU1TIDEKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZGRjX3NlcnZpY2Vf
dHlwZXMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL2RkY19zZXJ2aWNl
X3R5cGVzLmgKPiBpbmRleCBiNDUzY2U1YTliZmRiLi40ZGU1OWI2NmJiMWEzIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL2RkY19zZXJ2aWNlX3R5cGVz
LmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9kZGNfc2Vydmlj
ZV90eXBlcy5oCj4gQEAgLTExNyw4ICsxMTcsNCBAQCBzdHJ1Y3QgYXZfc3luY19kYXRhIHsKPiAg
ICAgICAgIHVpbnQ4X3QgYXVkX2RlbF9pbnMzOy8qIERQQ0QgMDAwMkRoICovCj4gIH07Cj4KPiAt
LypEUCB0byBEdWFsIGxpbmsgRFZJIGNvbnZlcnRlciovCj4gLXN0YXRpYyBjb25zdCB1aW50OF90
IERQX0RWSV9DT05WRVJURVJfSURfNFtdID0gIm0yRFZJYSI7Cj4gLXN0YXRpYyBjb25zdCB1aW50
OF90IERQX0RWSV9DT05WRVJURVJfSURfNVtdID0gIjMzOTNOMiI7Cj4gLQo+ICAjZW5kaWYgLyog
X19EQUxfRERDX1NFUlZJQ0VfVFlQRVNfSF9fICovCj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxp
bmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
