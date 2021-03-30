Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A4AC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 16:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE4461953
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 16:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE4461953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9BBD6E935;
	Tue, 30 Mar 2021 16:19:19 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A0F6E935
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 16:19:18 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id hq27so25682848ejc.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=lj8F0IIAbxgjgrswQLsBJTo/Fa8GdlzbmG46D+cZPnE=;
 b=mZQPYdXu4t8ASM0JtSiSzM/ciT6G5HrC8mqT2D6kcme96pS4zbL4hFjWvMZaZ8dc8P
 V9Yke6I2tBduM/ew4H3wPAHtn6B4OV/+oLOE15nK9kZetAjlNCNEvbg2VTouupnruNgk
 kZRdpiCunl0kkqGrqEpvk/3PwbLYeY1BplGZF1nUTQND0GarS1ScPg/npwBAmOVMyJpB
 rGBgH9w3TSZQoH4u3sQwR2daXBvW1fyXNUrHrHZgx99a7V66m647BPaJ1ThsGOLQM7eR
 xGGj2pUbDJPbfgqaNY/Sm1YE2aQlIBVNhbSBIilFeCHBLR3OWXYf0Gi3JlnohgwDoTva
 QPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=lj8F0IIAbxgjgrswQLsBJTo/Fa8GdlzbmG46D+cZPnE=;
 b=ozE0vqwN+fuDiBDbnmCarhK9SjOG8kx/fmUk/cb+xYefiOlgk4kufuuQdLEf3F0D3J
 2dpiDeVDw/NQs/s5e3v2dHZEyF9B9PWTLleUgiN9GO2AZ0r46FuVIjYwvaFwAnPA6Deb
 b6kJjT6Wj89w0ZBcjKP0FIaMF+JYhriD+jDVs1GF1YL5aSOSlLCHO0iDW2cYy+oBeKGs
 NJhXvBaI1RbU0ldeW/yLJ+LCoQuxT75dP2+3X8XAgGvDJktt+UPD8rZoRUqTCUpcs/Hs
 64KpqxHY/R63UgPKPxsFWHBAgxwgkBPJIK03efIvOBSVeMEmjxWOiongUYxaHajkWGf6
 PRGQ==
X-Gm-Message-State: AOAM530I57GkclvQKdk2zQoR0ThkB8VoHoBPDb6virZcRRjtK9oM0V5S
 OVgpyA1xEe2BG+Oxm15FLGk=
X-Google-Smtp-Source: ABdhPJzVyL2payi5fUl+9MbwqV9HiwRW5JHV++LhzvbrkIOPUbTq69NoYtuWxCfLn0IhsN+sWjGonw==
X-Received: by 2002:a17:906:14d4:: with SMTP id
 y20mr34133241ejc.190.1617121157653; 
 Tue, 30 Mar 2021 09:19:17 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8ca4:a46e:6aa7:208c?
 ([2a02:908:1252:fb60:8ca4:a46e:6aa7:208c])
 by smtp.gmail.com with ESMTPSA id m14sm11617985edr.13.2021.03.30.09.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Mar 2021 09:19:17 -0700 (PDT)
Subject: Re: [PATCH 1/4] drm/amdgpu: Macros for vram physical addr calculation
To: "Zeng, Oak" <Oak.Zeng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1616690318-3555-1-git-send-email-Oak.Zeng@amd.com>
 <A3D5D927-4E86-463E-BEC8-D6FFD746FA20@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1cb6b82e-69d2-b399-6b1b-74624dc5361b@gmail.com>
Date: Tue, 30 Mar 2021 18:19:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <A3D5D927-4E86-463E-BEC8-D6FFD746FA20@amd.com>
Content-Language: en-US
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2VsbCBJIHNlbmQgYSByZXZpZXc/CgpDaHJpc3RpYW4uCgpBbSAzMC4wMy4yMSB1bSAxNzowNCBz
Y2hyaWViIFplbmcsIE9hazoKPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlz
dHJpYnV0aW9uIE9ubHldCj4KPiBQaW5nLCBjYW4gc29tZW9uZSBoZWxwIHJldmlldyB0aGlzIHNl
cmllcz8KPgo+IFJlZ2FyZHMsCj4gT2FrCj4KPgo+Cj4g77u/T24gMjAyMS0wMy0yNSwgMTI6Mzgg
UE0sICJaZW5nLCBPYWsiIDxPYWsuWmVuZ0BhbWQuY29tPiB3cm90ZToKPgo+ICAgICAgQWRkIG9u
ZSBtYWNybyB0byBjYWxjdWxhdGUgQk8ncyBHUFUgcGh5c2ljYWwgYWRkcmVzcy4KPiAgICAgIEFu
ZCBhbm90aGVyIG9uZSB0byBjYWxjdWxhdGUgQk8ncyBDUFUgcGh5c2ljYWwgYWRkcmVzcy4KPgo+
ICAgICAgU2lnbmVkLW9mZi1ieTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+Cj4gICAgICBT
dWdnZXN0ZWQtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4KPiAgICAgIC0tLQo+
ICAgICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaCB8IDMgKysrCj4g
ICAgICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Cj4gICAgICBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCj4gICAgICBpbmRleCAyZWU4ZDFiLi43Y2Q5ZDM0
IDEwMDY0NAo+ICAgICAgLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dt
Yy5oCj4gICAgICArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgK
PiAgICAgIEBAIC0yODMsNiArMjgzLDkgQEAgc3RydWN0IGFtZGdwdV9nbWMgewo+ICAgICAgICNk
ZWZpbmUgYW1kZ3B1X2dtY19nZXRfdm1fcGRlKGFkZXYsIGxldmVsLCBkc3QsIGZsYWdzKSAoYWRl
diktPmdtYy5nbWNfZnVuY3MtPmdldF92bV9wZGUoKGFkZXYpLCAobGV2ZWwpLCAoZHN0KSwgKGZs
YWdzKSkKPiAgICAgICAjZGVmaW5lIGFtZGdwdV9nbWNfZ2V0X3ZtX3B0ZShhZGV2LCBtYXBwaW5n
LCBmbGFncykgKGFkZXYpLT5nbWMuZ21jX2Z1bmNzLT5nZXRfdm1fcHRlKChhZGV2KSwgKG1hcHBp
bmcpLCAoZmxhZ3MpKQo+ICAgICAgICNkZWZpbmUgYW1kZ3B1X2dtY19nZXRfdmJpb3NfZmJfc2l6
ZShhZGV2KSAoYWRldiktPmdtYy5nbWNfZnVuY3MtPmdldF92Ymlvc19mYl9zaXplKChhZGV2KSkK
PiAgICAgICsjZGVmaW5lIGFtZGdwdV9nbWNfZ3B1X3ZhMnBhKGFkZXYsIHZhKSAodmEgLSAoYWRl
diktPmdtYy52cmFtX3N0YXJ0ICsgKGFkZXYpLT52bV9tYW5hZ2VyLnZyYW1fYmFzZV9vZmZzZXQp
Cj4gICAgICArI2RlZmluZSBhbWRncHVfZ21jX2dwdV9wYShhZGV2LCBibykgYW1kZ3B1X2dtY19n
cHVfdmEycGEoYWRldiwgYW1kZ3B1X2JvX2dwdV9vZmZzZXQoYm8pKQo+ICAgICAgKyNkZWZpbmUg
YW1kZ3B1X2dtY19jcHVfcGEoYWRldiwgYm8pIChhbWRncHVfYm9fZ3B1X29mZnNldChibykgLSAo
YWRldiktPmdtYy52cmFtX3N0YXJ0ICsgKGFkZXYpLT5nbWMuYXBlcl9iYXNlKQo+Cj4gICAgICAg
LyoqCj4gICAgICAgICogYW1kZ3B1X2dtY192cmFtX2Z1bGxfdmlzaWJsZSAtIENoZWNrIGlmIGZ1
bGwgVlJBTSBpcyB2aXNpYmxlIHRocm91Z2ggdGhlIEJBUgo+ICAgICAgLS0KPiAgICAgIDIuNy40
Cj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
