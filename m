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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4F0C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7467D613D1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7467D613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAF146EE06;
	Thu, 27 May 2021 03:55:03 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEABD6EC03;
 Thu, 27 May 2021 03:55:02 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 o14-20020a4a384e0000b029020ec48a2358so814326oof.13; 
 Wed, 26 May 2021 20:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DYdOvbKIS1vZWONSAPvNPTiDzbelKy3t1aUeLsgWFhI=;
 b=kPGnlulp5k2F+B+K3fyRfScskNP8ZyHJoSJbo95tgoVtlPWnIWQMm4Pa6u9ilh9CHJ
 HVXsPASkp3wrDb1Yn/26wivV7jrv+xZPANfnvwcd+QZeMPonDhYsQR1afdCAzjhAThoj
 z4W0EbKuxEn1bQdk4qKBxvmv1TuZCpdG+jhfb/Pjb24sMBPCCSOPPlE9AsAX8NbEBY+P
 CI8Ix37uFTrUJ8KNa+JHjcHdSg65XZvQqBPmAM1jscOmSFCKBdA7YUiXfOkSA1nl+K0/
 jH54F+4j+8zWxf19n01IdshtAyjwtPuiSWPxAgzsF9OODng9Xnvit5YxgdUBMaSkVWDT
 +4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DYdOvbKIS1vZWONSAPvNPTiDzbelKy3t1aUeLsgWFhI=;
 b=LoPaEgEe1dWZZvsOxtGWxU11TTDkEneyyCpbZf0Su80MXauuTsmJIjNHJHe1bLvDQk
 QKGTDAypXJPQEzE6CRDVW1o6GF7CDxbcta0psiVmW/t5fCHhIg46wl7d0aFYIKX0ED40
 ftMaf54SDnbiEOsDkx2ukf03vo8lmevbQp6nTIAzxa+sRLm+Ti/M2Kd6mO7JTo8z8El0
 eDBnmZEzGY9rMZJ30McPpkQXeDeUthV2l6KeLbQW+/pw86TvWcsa8B1hbv0HTsNCDUwp
 IGIcs3QmjktuMNLRGKyzw7YfnN4knn1Wox9rnIkXa0bnIujVth4cEAon5yp1LdiCkqgT
 yiTA==
X-Gm-Message-State: AOAM531yM3rElOqENGCpMHg3cWxQ9UOa6LnEDJCcNOd51n9J4Ipl6Yes
 +hXa4cDXs1Q3DzADqz9MAgPGLIPnBtcEoHiCsKwC3059
X-Google-Smtp-Source: ABdhPJw6g2LITGmHYZhVJQjNCbEYY+uteLhXWlUvPhqUVuSZe5IwdkcB5EHEfuy02gyjwWePP3qG5xRWbOHESHpsJdg=
X-Received: by 2002:a4a:d085:: with SMTP id i5mr1199155oor.61.1622087702123;
 Wed, 26 May 2021 20:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-8-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-8-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 May 2021 23:54:51 -0400
Message-ID: <CADnq5_NU4fPUun-W2--KbpKP7yD1oD-tcQ=B82Apg6xiXR6+xQ@mail.gmail.com>
Subject: Re: [PATCH 07/34] drm/amd/pm/powerplay/hwmgr/vega20_hwmgr: Provide
 function name 'vega20_init_smc_table()'
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
ZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTIwX2h3bWdyLmM6NzgxOiB3YXJuaW5nOiBl
eHBlY3RpbmcgcHJvdG90eXBlIGZvciBJbml0aWFsaXplcyB0aGUgU01DIHRhYmxlIGFuZCB1cGxv
YWRzIGl0KCkuIFByb3RvdHlwZSB3YXMgZm9yIHZlZ2EyMF9pbml0X3NtY190YWJsZSgpIGluc3Rl
YWQKPgo+IENjOiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgo+IENjOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGlu
dXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4g
LS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9od21n
ci5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21n
ci92ZWdhMjBfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdy
L3ZlZ2EyMF9od21nci5jCj4gaW5kZXggZDMxNzdhNTM0ZmRmMC4uMDc5MTMwOTU4NmM1OCAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMjBf
aHdtZ3IuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3Zl
Z2EyMF9od21nci5jCj4gQEAgLTc3Miw3ICs3NzIsNyBAQCBzdGF0aWMgaW50IHZlZ2EyMF9zZXR1
cF9kZWZhdWx0X2RwbV90YWJsZXMoc3RydWN0IHBwX2h3bWdyICpod21ncikKPiAgfQo+Cj4gIC8q
Kgo+IC0gKiBJbml0aWFsaXplcyB0aGUgU01DIHRhYmxlIGFuZCB1cGxvYWRzIGl0Cj4gKyAqIHZl
Z2EyMF9pbml0X3NtY190YWJsZSAtIEluaXRpYWxpemVzIHRoZSBTTUMgdGFibGUgYW5kIHVwbG9h
ZHMgaXQKPiAgICoKPiAgICogQGh3bWdyOiAgdGhlIGFkZHJlc3Mgb2YgdGhlIHBvd2VycGxheSBo
YXJkd2FyZSBtYW5hZ2VyLgo+ICAgKiByZXR1cm46ICBhbHdheXMgMAo+IC0tCj4gMi4zMS4xCj4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
