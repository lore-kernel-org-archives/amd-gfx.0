Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06416C4742C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 23:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C342207E8
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 23:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfO13MKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C342207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C93B689D52;
	Tue, 10 Nov 2020 23:52:29 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1399289D52;
 Tue, 10 Nov 2020 23:52:29 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id c16so176503wmd.2;
 Tue, 10 Nov 2020 15:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+5DnaoUF0p5jGghI91j7sY8mMsHYnXiRGnd6iIqVaCI=;
 b=BfO13MKXIQHCpL8tnKxxIwv+Q7ALe4KlLDC4/v3XD6yZgEgSrXris1Gqyd49dvnjvo
 xjGn5jmV6yyHGM+hhqcXzRVIrThhv6lCsUhHXALI4MnUGZ7fWKCPM3qZ5qhDbmn0ixyn
 Xj2gFmceiwJ0/sGZj0+5Vf/4KHoaboA5JZD6A5utOM9v7/JjFEVANMJjo723uO9R3rCl
 0843C2ZN8Py0VIkGHA4c/qMbKqV7hEyVvk6O4hdqARDw4rxxDms9iPCNTSGEXBJEhT7Z
 qolN5bUbvEyQjcTSso9WO5wwV5Gl0REaZoYJ1ltAx9P+dyLOWD2ClWjwrfU3AryYhGcY
 jMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+5DnaoUF0p5jGghI91j7sY8mMsHYnXiRGnd6iIqVaCI=;
 b=Ox3i2GkgkDpEFFnT334tGCCaPluhkPJOYvSVFFUYcWb7NfitzU2fnLdxm6kvsfLdGz
 u8pThDGJh868Fzabo0eDGqeSj+fKCmNeNaRxZQxFxCXpJ3OtQAiU6qAistgvJTkHC2iL
 JFIyip2Mti5A1xayfyn93CNhRr0cONCib1DOO2fVaWPooSOGFezss0l01dtiPvp3/J+M
 dRv1N1+gM5e8Ku99VM9EksCD0dBxtQCkwO4MP1WZGWvSgsAisFfwZpb/t8E5uy72A0Nu
 JbbEme5vbtV1Oi9jXt5a1lNo9kLWyS0Hk669zveIHXeIpjjBTIRtZwEirpp0DUWon8+Y
 k/TQ==
X-Gm-Message-State: AOAM532g3Lj3wbzivMeCwpFA0HWM1nJi2SXQZjkJfUHl+lmkR7jbWdnN
 CdRlgFK7sRv4P/VR5H8qWnYzE2/drnpVPz/Doys=
X-Google-Smtp-Source: ABdhPJyH7zLqqCWsjHjLSvt2XDyB2UJe1W2H+wypyxoMhN3QyfBm6hwmu+EpFhdllNTCpSZYDJFDNrYghMhR/8RTXzk=
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr587600wmd.73.1605052347807; 
 Tue, 10 Nov 2020 15:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org>
 <20201110193112.988999-14-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-14-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2020 18:52:13 -0500
Message-ID: <CADnq5_MJQgyf_Xu+Qi-=6a9-V1x7YiVY0R+jWM7x_GvXxAdVhw@mail.gmail.com>
Subject: Re: [PATCH 13/30] drm/radeon/radeon_mn: Supply description for
 'cur_seq' even if it is unused
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

T24gVHVlLCBOb3YgMTAsIDIwMjAgYXQgMjozMSBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX21uLmM6NTE6IHdh
cm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2N1cl9zZXEnIG5vdCBkZXNjcmli
ZWQgaW4gJ3JhZGVvbl9tbl9pbnZhbGlkYXRlJwo+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBD
YzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gU2ln
bmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFwcGxpZWQgd2l0
aCBtaW5vciBmaXh1cC4gIFRoYW5rcyEKCkFsZXgKCgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9tbi5jIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX21uLmMgYi9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9tbi5jCj4gaW5kZXggOTdiOWI2ZGQ2ZGQzYi4u
M2M0YzQyMTNhN2I1NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9tbi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fbW4uYwo+IEBAIC00
MSw2ICs0MSw3IEBACj4gICAqCj4gICAqIEBtbjogb3VyIG5vdGlmaWVyCj4gICAqIEByYW5nZTog
dGhlIFZNQSB1bmRlciBpbnZhbGlkYXRpb24KPiArICogQGN1cl9zZXE6IHVudXNlZAo+ICAgKgo+
ICAgKiBXZSBibG9jayBmb3IgYWxsIEJPcyBiZXR3ZWVuIHN0YXJ0IGFuZCBlbmQgdG8gYmUgaWRs
ZSBhbmQKPiAgICogdW5tYXAgdGhlbSBieSBtb3ZlIHRoZW0gaW50byBzeXN0ZW0gZG9tYWluIGFn
YWluLgo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
