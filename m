Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E8FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 08:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA3F601FB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 08:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA3F601FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 214C489FD1;
	Mon,  1 Mar 2021 08:25:38 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F19526E4B5
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Feb 2021 15:23:40 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id o1so4435878qta.13
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Feb 2021 07:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=4zar18JFu6mXsoaCQIpQPwkkjCHBonnljxxsJkb+s2w=;
 b=lxGZxFgfoN0Xz9IZ8NXIWGZFamkXtY1WHKs+jPHOZTbtswZkGrGEvLVQ+qEH7sE9ox
 OllF216KzeEH30fvvHci1RKye7Zf38Tq1wNTP1+FB2mMYyEAtR+P6QXbgk8+xNx7rCA6
 Nqd/Y7j5AM4m3h9pO3G2xFyuqJIzKzpvXqRKhDzWKUQpfZegjajnjXUiSbMSCsxrQK8g
 UsJM2Bgr1CjzET7PjUSx4YPWMRbSMGbs2TKGWvIhXto1CaYe02swkcZidI35f0ECtMew
 5YnHkvBNxhPB+wfZVGig2yh6eZ8QdFUol4n+jkmTeKzMD//L6guweYbre85N84nHt7Hx
 uE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=4zar18JFu6mXsoaCQIpQPwkkjCHBonnljxxsJkb+s2w=;
 b=DGlONF6nwVV1Z+iv0/VswzOxOV6ING0TGsSjMzp1Pq1vJsg74QSMEKG5aZ3gIiIqjZ
 fvZAnrIu32BMKaDt9AYsc6uee+39Ie8j5clzX09Q4dka2p6M4TLu/bk4w+id4lVP23BG
 jmSWBcNi6zMC9uiOvynOks//NuV9p0ppZ/xtqegHLQ8cUvQzAAOTTkmQhpX5U8B3cNTr
 CGOv0rpBaL0u57usl1ceJ3wXqZMBlihhpzXKg+heP4f1NS21EQQ1VoNOMgiaLKELSLMM
 BA+5KyOjIw0GtqJS1RNR77xnXd7HK2g45O4MT6UigAYjxoHgjHoHXFIfKM8iuYSdocB9
 UhlQ==
X-Gm-Message-State: AOAM5324HYRlPXgjFlbMkswhDqJBS1sIO97/Tm7B88YkWO2e8ErbFvCG
 v0pY5/bigSdcuYUi98RYzfGt6C1JhUo=
X-Google-Smtp-Source: ABdhPJx3OmWmMSM498PtyDQDhEW5Zyob7mwGgwCVvDfOqdnremc3Yb4PuiLUwWuzT46rMttnu7KyXw==
X-Received: by 2002:ac8:7511:: with SMTP id u17mr5133181qtq.32.1614439419835; 
 Sat, 27 Feb 2021 07:23:39 -0800 (PST)
Received: from [192.168.2.122] (pool-108-18-37-54.washdc.fios.verizon.net.
 [108.18.37.54])
 by smtp.gmail.com with ESMTPSA id 17sm2740164qky.7.2021.02.27.07.23.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Feb 2021 07:23:39 -0800 (PST)
Subject: Re: [bug] tab crash on media playback
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy <nirmodas@amd.com>, amd-gfx@lists.freedesktop.org
References: <e281729c-d632-1cc2-a1c7-79b4d1cbdc66@gmail.com>
 <f4b795f8-9f79-a946-49dc-0aea27766bf6@amd.com>
 <b091a944-a002-9f6b-c347-1314a0f64385@gmail.com>
 <59967fb7-cf91-d6c9-f431-9b6a60a85c05@amd.com>
 <e6206b9a-8616-f4f0-1cf1-6f01c772f0ef@gmail.com>
 <6fc78b8f-a95c-e1ad-55cd-6a7ba7235088@amd.com>
From: Cory Bolar <cory.bolar@gmail.com>
Message-ID: <818d5250-fc91-d3c1-762e-85589aad3137@gmail.com>
Date: Sat, 27 Feb 2021 10:23:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <6fc78b8f-a95c-e1ad-55cd-6a7ba7235088@amd.com>
Content-Language: en-US
X-Mailman-Approved-At: Mon, 01 Mar 2021 08:25:37 +0000
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMi8yNy8yMSA4OjQyIEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4gVGhpcyBqdXN0
IG1lYW5zIHRoYXQgdGhlIGZhdWx0IG5lZWRzIHRvIGJlIHJldHJpZWQgYW5kIGlzbid0IGFueXRo
aW5nIAo+IHNwZWNpYWwuCj4KPiBJIGhhdmUgbm8gaWRlYSB3aHkgdGhpcyBzaG91bGQgY2F1c2Ug
YW55IHByb2JsZW1zLgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KClRoYW5rcyBhbGwuwqAg
SSBtYXkgdHJ5IHJlcG9ydGluZyB0aGlzIHRvIHRoZSBjaHJvbWUgZm9sa3MgdG8gc2VlIGlmIHRo
ZXkgCmhhdmUKYW55IGlkZWFzLsKgIEkgYW0gbm90IHRvbyBrZWVuIG9uIGhhdmluZyB0byBjb21w
aWxlIGNocm9taXVtIHdpdGggZGVidWcgCnN5bWJvbHMKb3IgdG8gdGVzdCBwYXRjaGVzIGJ1dCB0
aGF0IHdvdWxkIHByb2JhYmx5IGhlbHAuCgpJJ2xsIHJlcG9ydCBiYWNrIGhlcmUgaW4gdGhlIGZ1
dHVyZSBpZiBhbnl0aGluZyBpbnRlcmVzdGluZyBhbmQga2VybmVsIApyZWxhdGVkCmlzIGZvdW5k
LgoKVGhhbmtzLAoKQ29yeQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
