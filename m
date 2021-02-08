Return-Path: <SRS0=WKN7=HK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4904C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 09:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D4A64E85
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 09:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D4A64E85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E2316E842;
	Mon,  8 Feb 2021 09:19:00 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3053D6E841
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Feb 2021 09:18:59 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id s11so17220621edd.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Feb 2021 01:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=QGcy+LVaBTe03RvcLEkLirzoNYsSN55TImtVQNmyuNc=;
 b=kaS/bnUpS3XICL+fvM+ime45O31tilIhRCELq9iFRCUV09KOVpS0RNZ1XPW1qq5EQS
 q5iL63Yhvn+cGnEHGYnZlDl9rWSiqQlDShLJ55ma3WnERHIwWcYBXAdJqSpYKMF1DI4q
 iXTrfHtretIr/vb4sFYF6At99JjD1BJ6svXG1UrvzEm6SJv9bjfQuA3c95U19I9qQq83
 ni7FvUz4P2dcg3raP53YY1Vw6i9f43qzq1KyC1zgYi91r/CZomGb6OYrBbIO/y9z5njX
 Zd0CoFhILwFoaR+I0GTnJO6slPNdMCIH1hmrmYEROXQTY37nAjYNWFSuHo53Kk/2gnwt
 qXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=QGcy+LVaBTe03RvcLEkLirzoNYsSN55TImtVQNmyuNc=;
 b=lbWumgbaz89DjxDhXJ67/9IoxE6rP8XUNFH61enOLX1nU73EgLTV9XJtog+q3Ugsdz
 BGAPZ3LoGqOVwa4oMeSbjYpeSB1vODFAUT7GgCQhhYy1bSDJUyBYY0n1Bf4nLdhh9TIQ
 ZQy3cqGsgGnj2PkTJHYgkTEjVMGz9obq6hHTzKXq7GrInETDzKYypzqrG2+yes2Z7JJ0
 OpqWxBFE3f+FpspE5iANsMSLaOn6YmzL0LNdbMx/7cF+9en8+FZnemRCD0O+FluCR+Cp
 OyDdfab9BmOv/6cBcflp7+YRhgwQ2MJ9Wl5dq2IVt5vrpvMXH8UFdiMkxv+cLnDnltiR
 bmfg==
X-Gm-Message-State: AOAM530kp7t4Jtd2+CaSR6217ZdBEm1UVg2dksXOs2iLopdjFi/9V6Mq
 BdC4Tkpj+2pX1Mt39fR3M+k=
X-Google-Smtp-Source: ABdhPJwFPLKopzUJXReRnLoHJECO1RY11ATlvmhZi/WnrJ/Ft1BopfcxIEn7JphzmKs2nPhNqwEIjg==
X-Received: by 2002:aa7:c895:: with SMTP id p21mr16335569eds.165.1612775937870; 
 Mon, 08 Feb 2021 01:18:57 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u27sm4412750edi.79.2021.02.08.01.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 01:18:57 -0800 (PST)
Subject: Re: [bug] 5.11-rc5 brought page allocation failure issue [ttm][amdgpu]
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <CABXGCsNazWZQGfSnFgQ_K5_H9uBQ=8gBdFORXrU1FEMGMohO2w@mail.gmail.com>
 <4ce29a7e-f58a-aeb4-bef-34a7eada70d0@google.com>
 <e0c2c823-5f-efe8-cd87-6dd6cc33a33@google.com>
 <7a677c89-1974-0676-ba7d-b057ad2cab3f@gmail.com>
 <CABXGCsPnGVAGWETYD-dfrqxhciHA0NKBG2EWueOtFzL5xF9z3g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cf60a50d-d3ca-2ce9-918b-0763a26552d8@gmail.com>
Date: Mon, 8 Feb 2021 10:18:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABXGCsPnGVAGWETYD-dfrqxhciHA0NKBG2EWueOtFzL5xF9z3g@mail.gmail.com>
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
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 David Rientjes <rientjes@google.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDYuMDIuMjEgdW0gMTk6MTcgc2NocmllYiBNaWtoYWlsIEdhdnJpbG92Ogo+IE9uIFN1biwg
MzEgSmFuIDIwMjEgYXQgMjI6MjIsIENocmlzdGlhbiBLw7ZuaWcKPiA8Y2tvZW5pZy5sZWljaHR6
dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Pgo+PiBZZWFoLCBrbm93biBpc3N1ZS4gSSBhbHJl
YWR5IHB1c2hlZCBNaWNoZWwncyBmaXggdG8gZHJtLW1pc2MtZml4ZXMuCj4+IFNob3VsZCBsYW5k
IGluIHRoZSBuZXh0IC1yYyBieSB0aGUgd2Vla2VuZC4KPj4KPj4gUmVnYXJkcywKPj4gQ2hyaXN0
aWFuLgo+IEkgY2hlY2tlZCB0aGlzIHBhdGNoIFsxXSBmb3Igc2V2ZXJhbCBkYXlzLgo+IEFuZCBJ
IGNhbiBjb25maXJtIHRoYXQgdGhlIHJlcG9ydGVkIGlzc3VlIHdhcyBnb25lLgo+Cj4gWzFdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMTAxMjgwOTUzNDYuMjQyMS0xLW1pY2hlbEBk
YWVuemVyLm5ldC8KCkFyZSB0aGUgb3RoZXIgcHJvYmxlbXMgZ29uZSBhcyB3ZWxsPwoKUmVnYXJk
cywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
