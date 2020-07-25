Return-Path: <SRS0=m7X+=BE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC708C433E1
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jul 2020 08:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D771206D7
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jul 2020 08:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yfqr1Xn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D771206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 542716E027;
	Sat, 25 Jul 2020 08:44:26 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73A36E027
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jul 2020 08:44:24 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id a21so12225058ejj.10
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jul 2020 01:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=0eCpXv6tlNwLNhcVnFmKjptKWSpAoc1WprIax3wqYt8=;
 b=Yfqr1Xn2CpzkXvW05kqAPg1Wb2BmyojgU7C2S/xPA5DNKfeU6qT2I/sIyd7PpFFt1r
 rh7yNWHL1h8qL2li5zAQccddcwKjYyjEuZSHXlq/txVDqhUfxeokKkMQ8jeNNh6b7NDx
 fjSn/dl3wmxBWef2KzXFoVUkNwdbWW7CI/f3PVAxTS6eAjHFApKftKyuZWi0gXAYAswx
 mGJGJ2KT52nRwvs2yYzSCyeDJq9P5WYOmQP+QSzTr6etupk/BI50ouKbYWlpgTh+aMCJ
 CjJ1SclTV9LHEoDR25yoJT2yu5jIamIIXx2VRHKtTFBJNUC8YKN2pD/D0lgxR/o3ewH1
 aC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=0eCpXv6tlNwLNhcVnFmKjptKWSpAoc1WprIax3wqYt8=;
 b=SKOeetcMelJNNdkhTf0UHSthykrGgK1eTtacoN7k3EwbnO56FkmEIgGQT/Vcbrib9Y
 R0+eROx91j0MX43XdKfkZ3Xx4FXjAVJZ74l+TA4+Ni8cEgAwahLGOV0yiF7rLa806NwE
 z6NJMuZ1x3flJ7LUVOU/ezfa5/Yc4+VgplGKhXlXq9rrzg38XARv2+TkcJ4CzaXYF8tU
 BilFUt+NncsrrOZsYE5oBJA2/Z4rvpqLZcUYUAvyqSFuc/RXtYq0vySlILIBY9JZYEIL
 L5Y+zpmGJXoOLOGCNYO6oZHRG362Llbs2DUWGH+mzaOvO8lscf2bebWvPi06acJRPHk6
 kVfA==
X-Gm-Message-State: AOAM531kXJ8OADKx6THw5e+h2HxzdIiojbrBgq++dC4BzPijHVJL1vgB
 yvHBfvhb+eow2NRi+Tlao+TMyKbJ
X-Google-Smtp-Source: ABdhPJxinqP5dwikN8TBnCxJAAC2Z2DTLNdUzENaL5EBSYp+fl33xszs7Azq5+ZHIN6Wv0lOGnanPw==
X-Received: by 2002:a17:906:c259:: with SMTP id
 bl25mr12537887ejb.303.1595666662998; 
 Sat, 25 Jul 2020 01:44:22 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id v19sm2426156edy.50.2020.07.25.01.44.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 25 Jul 2020 01:44:22 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] drm/amdgpu: Change type of module param
 `ppfeaturemask` to hexint
To: Linus Torvalds <torvalds@linux-foundation.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20200703142939.28663-1-pmenzel@molgen.mpg.de>
 <20200703142939.28663-3-pmenzel@molgen.mpg.de>
 <50e7239f-9fab-8484-7aec-085acc5ec658@amd.com>
 <7e5b2284-0549-185c-4afd-f7d193e2faf9@molgen.mpg.de>
 <54ad054c-2cf4-765e-4ecc-44e2b98422f0@amd.com>
 <CAHk-=whxP-2tFBX9ctP242TsgJhtp7yhNrkG6Tj+Ng=FiT1FbQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <14c71f74-654d-5d03-4865-249751cf65a2@gmail.com>
Date: Sat, 25 Jul 2020 10:44:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whxP-2tFBX9ctP242TsgJhtp7yhNrkG6Tj+Ng=FiT1FbQ@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjQuMDcuMjAgdW0gMjI6Mjkgc2NocmllYiBMaW51cyBUb3J2YWxkczoKPiBPbiBGcmksIEp1
bCAyNCwgMjAyMCBhdCAxMjo1NCBBTSBDaHJpc3RpYW4gS8O2bmlnCj4gPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4gd3JvdGU6Cj4+IEJ1dCBzaW5jZSB5b3UgYWxyZWFkeSBhZGRyZXNzZWQgTGlu
dXMgY29tbWVudHMgYW5kIGl0IGxvb2tzIHJhdGhlciBjbGVhbgo+PiBJIHRoaW5rIEkgY2FuIGp1
c3QgcHVzaCBpdCB0byBkcm0tbWlzYy1uZXh0IG9uIE1vbmRheSBpZiBub2JvZHkgb2JqZWN0cwo+
PiBvdmVyIHRoZSB3ZWVrZW5kLgo+IFllYWgsIG5vIG9iamVjdGlvbnMgZnJvbSBtZS4KPgo+IEFk
ZCBhIG5vdGUgdG8gaXQgdG8gdGhlIHB1bGwgcmVxdWVzdCwgc28gdGhhdCB3aGVuIG15IGJpcmQt
YnJhaW4gc2Vlcwo+IHRoZSBwdWxsIGR1cmluZyB0aGUgbmV4dCBtZXJnZSB3aW5kb3cgYW5kIEkn
dmUgZm9yZ290dGVuIHRoaXMgdGhyZWFkLAo+IEkgZG9uJ3QgZ28gIndoeSBpcyB0aGUgZHJtIHRy
ZWUgbW9kaWZ5aW5nIGNvZGUgZmlsZXMiPwoKV2VsbCBEYXZlIGlzIHNlbmRpbmcgdGhvc2UgcmVx
dWVzdHMgdG8geW91IHVzdWFsbHkuCgpJIHdpbGwganVzdCBhZGQgYW4gQWNrZWQtYnk6IExpbnVz
IFRvcnZhbGRzIAo8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHRvIHRoZSBwYXRjaCBi
ZWZvcmUgcHVzaGluZyA6KQoKVGhhbmtzLApDaHJpc3RpYW4uCgo+Cj4gICAgICAgICAgICAgICBM
aW51cwo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
