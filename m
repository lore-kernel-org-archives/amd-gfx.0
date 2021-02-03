Return-Path: <SRS0=2ogv=HC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_48_96,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B82DC433DB
	for <amd-gfx@archiver.kernel.org>; Sun, 31 Jan 2021 17:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F26C64E1F
	for <amd-gfx@archiver.kernel.org>; Sun, 31 Jan 2021 17:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F26C64E1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD346E09E;
	Sun, 31 Jan 2021 17:22:48 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED016E09E
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 Jan 2021 17:22:47 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id dj23so16193470edb.13
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 Jan 2021 09:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=RbOAw9iCiWf3vmIBB9AiaSewZnK8UfYjYbdl5JtZIlU=;
 b=I5Wcmj0UAC6wdR3DY92+88WJi1/9uiSMxxSlG9RelNfX805mewkB7cDRME4hvjQrnh
 krIRCOREWZpvch2cizO57Y600GiafsWMxdpdx+W/eVbGsjD86yydzaD9HwYjMUalw1dz
 6RDPmgCrhq9ddPjiOvdm5klP9Tj/siWGoLhb6hjWVMhKAW8GyMYmZ13xRDIzYcHhv2q6
 lcpZ2tdUQUc0wSHJuGLDOgCHyYCyzfD77emu6ZAyqZmd9k7i7kZlIHnfFqhLF40ykSXV
 OK5pPvM2tSOfiR4rBex91N5Io80/ocombyF02+gw4jIgWYoOUegmwZ1+7u1z5Xpl6Fpv
 08GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=RbOAw9iCiWf3vmIBB9AiaSewZnK8UfYjYbdl5JtZIlU=;
 b=Hbt4Jx5sjJw2cagqRYD+RbL/MRohlz9AH6RUmwdu9XDkXn20opDqFmzVHDzL8alTHG
 wicBDNNaIFnmmvMVg2t+iI+dSS/I1LCXEO1QhKEd92w5IfNdhv9/bwvvjw5ozalg1Rup
 tUrlXz2RnuMLSnCE7Jc2bDVQKFByKfVTObg3AJL985MlplgeVF4SWMtP79W+892nw1p7
 FrYN8FifFaEUV5gCo3j2U3nSo0nBGf69BKSWInqkAxv2pTildfjHnY+lF6O+U8Q1ZlE0
 oE5YF98LwqZZZjb+kA79fFGcYK2RwEKwUzknJNiBjYCjBDUvTFDFK4XCjKhlWUHj3u9P
 B8pQ==
X-Gm-Message-State: AOAM530jbwBw/TZJnbBuc1xcmjvO9hpcM/q/kjtQNownBvEW4zDCkqrB
 yd8Nby7j4CNaRPi1q3QsuVd6UcgZkpE=
X-Google-Smtp-Source: ABdhPJyxGbRH/z5GOJ5Doybkfw1rnXoP6pLt1cG2awWcU3nF6e6ZKQ6evlW3bcBukvSlhs8Zvpgn/A==
X-Received: by 2002:aa7:d0d4:: with SMTP id u20mr14407950edo.203.1612113765833; 
 Sun, 31 Jan 2021 09:22:45 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j4sm7493834edt.18.2021.01.31.09.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Jan 2021 09:22:45 -0800 (PST)
Subject: Re: [bug] 5.11-rc5 brought page allocation failure issue [ttm][amdgpu]
To: David Rientjes <rientjes@google.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <CABXGCsNazWZQGfSnFgQ_K5_H9uBQ=8gBdFORXrU1FEMGMohO2w@mail.gmail.com>
 <4ce29a7e-f58a-aeb4-bef-34a7eada70d0@google.com>
 <e0c2c823-5f-efe8-cd87-6dd6cc33a33@google.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7a677c89-1974-0676-ba7d-b057ad2cab3f@gmail.com>
Date: Wed, 3 Feb 2021 14:22:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e0c2c823-5f-efe8-cd87-6dd6cc33a33@google.com>
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
Reply-To: christian.koenig@amd.com
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMzEuMDEuMjEgdW0gMDI6MDMgc2NocmllYiBEYXZpZCBSaWVudGplczoKPiBPbiBTYXQsIDMw
IEphbiAyMDIxLCBEYXZpZCBSaWVudGplcyB3cm90ZToKPgo+PiBPbiBTdW4sIDMxIEphbiAyMDIx
LCBNaWtoYWlsIEdhdnJpbG92IHdyb3RlOgo+Pgo+Pj4gVGhlIDUuMTEtcmM1IChnaXQgNzZjMDU3
Yzg0ZDI4KSBicm91Z2h0IGEgbmV3IGlzc3VlLgo+Pj4gTm93IHRoZSBrZXJuZWwgbG9nIGlzIGZs
b29kZWQgd2l0aCB0aGUgbWVzc2FnZSAicGFnZSBhbGxvY2F0aW9uIGZhaWx1cmUiLgo+Pj4KPj4+
IFRyYWNlOgo+Pj4gbXNlZGdlOmNzMDogcGFnZSBhbGxvY2F0aW9uIGZhaWx1cmU6IG9yZGVyOjEw
LAo+PiBPcmRlci0xMCwgd293IQo+Pgo+PiB0dG1fcG9vbF9hbGxvYygpIHdpbGwgc3RhcnQgYXQg
b3JkZXItMTAgYW5kIGJhY2sgb2ZmIHRyeWluZyBzbWFsbGVyIG9yZGVycwo+PiBpZiBuZWNlc3Nh
cnkuICBUaGlzIGlzIGEgcmVncmVzc2lvbiBpbnRyb2R1Y2VkIGluCj4+Cj4+IGNvbW1pdCBiZjll
ZWUyNDlhYzIwMzI1MjE2NzdkZDc0ZTMxZWRlNTQyOWFmYmMwCj4+IEF1dGhvcjogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+PiBEYXRlOiAgIFdlZCBKYW4gMTMg
MTQ6MDI6MDQgMjAyMSArMDEwMAo+Pgo+PiAgICAgIGRybS90dG06IHN0b3AgdXNpbmcgR0ZQX1RS
QU5TSFVHRV9MSUdIVAo+Pgo+PiBOYW1lbHksIGl0IHJlbW92ZWQgdGhlIF9fR0ZQX05PV0FSTiB0
aGF0IHdlIG90aGVyd2lzZSByZXF1aXJlLiAgSSdsbCBzZW5kCj4+IGEgcGF0Y2ggaW4gcmVwbHku
Cj4+Cj4gTG9va3MgbGlrZSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0PiBhbHJl
YWR5IHNlbnQgYSBwYXRjaCB0aGF0Cj4gc2hvdWxkIGZpeCB0aGlzOgo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvMjAyMTAxMjgwOTUzNDYuMjQyMS0xLW1pY2hlbEBkYWVuemVyLm5ldC8K
ClllYWgsIGtub3duIGlzc3VlLiBJIGFscmVhZHkgcHVzaGVkIE1pY2hlbCdzIGZpeCB0byBkcm0t
bWlzYy1maXhlcy4gClNob3VsZCBsYW5kIGluIHRoZSBuZXh0IC1yYyBieSB0aGUgd2Vla2VuZC4K
ClJlZ2FyZHMsCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
