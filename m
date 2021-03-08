Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5CBC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 18:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D046526C
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 18:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D046526C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891646E418;
	Mon,  8 Mar 2021 18:46:02 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257A66E418
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 18:46:02 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id z22so2433033oop.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Mar 2021 10:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/X0agx0ndxNm3eZMm/qmSb0hVvGKfodjh08BHaEj0Jg=;
 b=FVB03KMrbEfM/RuaYwL7LzFkLaVuj8M6TyHdhDZ+IiJBPFH4jt3gCYqlsz84SoH1rM
 BCO8jMz3ACmdETrIatuGo4LrudmbxU5KY4xPtj/DEh+riaf9YkGyXrSOSZYQEaug4PVH
 lZYnRj4TpICYvNEWJ9dDVEqw82FmYloE2ju84/1HEmbjbKJv/pxj7VTWlCqUS6ADZuHc
 v8UuFlkB7t+AmfpB+FL8C+HXJBO5kroETa74YZI02IS2cCLt93gTTC6aSoSZZU6L1/K7
 eR5PjPWSe5hHc6rHd/G1iwS7gdAsS6IC23aXPwCDaQJffY45hukxbY70/wDC+pCmEAMB
 t84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/X0agx0ndxNm3eZMm/qmSb0hVvGKfodjh08BHaEj0Jg=;
 b=uHmcY4ZYifUAG3WYL9MS2rwtdcQwUe2fthJFRdccDqY7UPjzRTaGh/vmOQs9BtCl90
 THl+K3nPbzSH8aVxW2cK7xitbePKzKDwhXYMVo3JKSR14YfHMcyhHC82BZ9xRjmvvZtH
 qRXk1jXwd63MDjKoSUhaERxnjN0QONaONwylfLXWZalXzypBkWak+m/fXVyabY+mxhER
 DMyvs6S45GxiNmSlwzA683EoOOTTfNrLfu93cVgfS5wqPX59SS4+xnCe4kVDIBgdCuDQ
 l4GW4nZ2mvrBDlvpnk9PCO1lo2rpt8qss/4kXo2dFmQUm43h6GsWedbly7D4PGBBK6To
 BEYQ==
X-Gm-Message-State: AOAM5335l5p6cUPxJMmgIaUdU6ZG5F5jZaMjWZm8E9mXIy2T+zlEUHiz
 FxyYBpt1MxuMJoVC+j7Sa+nNORG41hXQA6FzXW4=
X-Google-Smtp-Source: ABdhPJyw0fU3PCpTuhFp2+9cVzMnkBaTHhbdJteDgJ8aX1wXsQattTksBhaehYWJoGXfuH+D6GQomMnQwLXHAYbDxfw=
X-Received: by 2002:a4a:9801:: with SMTP id y1mr19392747ooi.90.1615229161488; 
 Mon, 08 Mar 2021 10:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20210308183643.36710-1-christian.koenig@amd.com>
 <20210308183643.36710-3-christian.koenig@amd.com>
In-Reply-To: <20210308183643.36710-3-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Mar 2021 13:45:50 -0500
Message-ID: <CADnq5_Mvpo2R2rohLAmv2D2uTgyjJHf58dO7=q5M0=JMScZ8nA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/radeon: keep __user during cast
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VyaWVzIGlzOgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgoKT24gTW9uLCBNYXIgOCwgMjAyMSBhdCAxOjM2IFBNIENocmlzdGlhbiBLw7ZuaWcK
PGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPgo+IFNpbGVuY2Ugc3Rh
dGljIGNoZWNrZXIgd2FybmluZy4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yYWRlb25fdHRtLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMKPiBpbmRleCA1
ZWE2NDdmNDU0ZDMuLjgwODk0MWUzMWQzNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl90dG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9u
X3R0bS5jCj4gQEAgLTkyMSw3ICs5MjEsNyBAQCBzdGF0aWMgc3NpemVfdCByYWRlb25fdHRtX3Zy
YW1fcmVhZChzdHJ1Y3QgZmlsZSAqZiwgY2hhciBfX3VzZXIgKmJ1ZiwKPiAgICAgICAgICAgICAg
ICAgdmFsdWUgPSBSUkVHMzIoUkFERU9OX01NX0RBVEEpOwo+ICAgICAgICAgICAgICAgICBzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZyZGV2LT5tbWlvX2lkeF9sb2NrLCBmbGFncyk7Cj4KPiAtICAg
ICAgICAgICAgICAgciA9IHB1dF91c2VyKHZhbHVlLCAodWludDMyX3QgKilidWYpOwo+ICsgICAg
ICAgICAgICAgICByID0gcHV0X3VzZXIodmFsdWUsICh1aW50MzJfdCBfX3VzZXIgKilidWYpOwo+
ICAgICAgICAgICAgICAgICBpZiAocikKPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
cjsKPgo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
