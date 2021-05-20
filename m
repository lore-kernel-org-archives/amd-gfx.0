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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C70C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5FE608FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5FE608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB1F6F501;
	Thu, 20 May 2021 19:20:22 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ADBD6F501;
 Thu, 20 May 2021 19:20:19 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id z3so17423149oib.5;
 Thu, 20 May 2021 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PfgwTVkMgiwTa2ZUJi4Rqpy4DzXkVzihsc1UndFlxZA=;
 b=NKXl/O4Ah4nhqRZkqVf7JWT06B7xn241Wl6InCIzbJbLIuLi4vfTnaDrtlDTjxDQVi
 n30NCGYnAoGxnSG/VWuWTQ+YK7PcX9F9m5Xpy8FvszrYZNU3ITT17+QkEfw/+eCQ+Pkt
 mLk4rneTHZwhebapO0piSnDF2/cEBjYQY/NbDQitSmHZSiZ11NWAPqW8C3iOPpcFafJN
 qCP9cMoArj2JNtrRctLNjX6fyLtrTmYEkwu0AHzbJOi4N+RnXc2su55cSnse9MAWxLBJ
 z0h7NrAKCgvhrjjYExJ3ftsS1HKoD+9OnT8mPmjAez+Vncw+mZOevxqJhe1TsUGEAEbS
 mq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PfgwTVkMgiwTa2ZUJi4Rqpy4DzXkVzihsc1UndFlxZA=;
 b=OXg0BI1/007PQW2R32UChj4yZnWguun+NMudKFz3udskPsce/hMNMjWg+ejEQ4CmPI
 uHXbPyIP9MQiIUJqToLEG98PIkP3ILTPLqPyX50yXCVYcAWQQJBkxrAVIxKs5O4LjMN9
 RtyO3wTWBgqIODXVrh97M9U/pnl7jVNkzTSUp6ho4B/sbBoad0srTrRt6LeXLqbh8GYx
 vmz5pT82Nmkrv7wlOnev46/ojiBOPiNa+pnGnkWVuhsZjqNU+NSRPy1H1oYiOGXsfotn
 0f3KweDqe5whA8rcjlx6mNF4OUYV4Gcrc6eH+gaXcJpoWDoXRHbvBWRoiFDuPytIFLSP
 WsUg==
X-Gm-Message-State: AOAM530ee/Q1j8MKKCnGQQDMrW88MExKfy/B3L6lg+8rWSiJ6c5IGpW9
 jnm3YyUYVWLn2ukSzRtEb69hn/YkqSyOWhTsh7c=
X-Google-Smtp-Source: ABdhPJwvc46ikCv5xL8krtN+XasKLQNxgGwSb0z9zUHEbeOTG8SunshtMqXtCUQ8+ULgPYLiJCxGyKV39ZYg0zNwFbc=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr4203881oie.120.1621538418645; 
 Thu, 20 May 2021 12:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-27-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-27-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:20:07 -0400
Message-ID: <CADnq5_PaefTWkWnOPTJMTgL-zocXtB9wGnK30PiZG2iNAA=oOw@mail.gmail.com>
Subject: Re: [PATCH 26/38] drm/amd/amdgpu/gmc_v10_0: Fix potential copy/paste
 issue
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
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDMgQU0g
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9s
bG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nbWNfdjEwXzAuYzo5NTU6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUg
Zm9yIGdtY192OF8wX2dhcnRfZmluaSgpLiBQcm90b3R5cGUgd2FzIGZvciBnbWNfdjEwXzBfZ2Fy
dF9maW5pKCkgaW5zdGVhZAo+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZl
dHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBs
aW5hcm8ub3JnPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVs
Lm9yZwo+IENjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKPiBTaWduZWQtb2ZmLWJ5
OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNf
djEwXzAuYwo+IGluZGV4IGYwMmRjOTA0ZTRjZmUuLjEwNWVkMWJmNGE4OGMgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwo+IEBAIC05NDcsNyArOTQ3LDcgQEAgc3Rh
dGljIGludCBnbWNfdjEwXzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpCj4gIH0KPgo+ICAvKioKPiAt
ICogZ21jX3Y4XzBfZ2FydF9maW5pIC0gdm0gZmluaSBjYWxsYmFjawo+ICsgKiBnbWNfdjEwXzBf
Z2FydF9maW5pIC0gdm0gZmluaSBjYWxsYmFjawo+ICAgKgo+ICAgKiBAYWRldjogYW1kZ3B1X2Rl
dmljZSBwb2ludGVyCj4gICAqCj4gLS0KPiAyLjMxLjEKPgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
