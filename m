Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB12EC2BA2B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 15:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFFDF2072C
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 15:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgn2+OLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFFDF2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9A5789E32;
	Mon, 13 Apr 2020 15:17:40 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF2789A56;
 Mon, 13 Apr 2020 15:17:39 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id e26so9647926wmk.5;
 Mon, 13 Apr 2020 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6/tAY7sG8rHBuZ3JGryCCYr3n1OexDLH2uk6dgjjXOE=;
 b=fgn2+OLLH1broPdcc/n91zxjUbINV+YKFu4617b9ChwUBY6ku2GPh+UQi2KCrydpZB
 uRIvV/qTyrtYa4cQ1idlbrH6Ip/SgQn/5Y25JeGcMcFhD1k1oiCapG75nbieQLXwAUUr
 36RAl2O6RlM7irJ5YAyVp/c7cE/Om8fPq6/CpLkO9hWs4fKKJGfNyOoDc7eeCqHYVmhM
 R664MVppEBLiwZ38BGlII8hlYSRFZhcrqifVX4of3ZzyovydCJbhejctPy8lgwtkC6gE
 197raXN3Ci+GKsXKp+qGBwiDY4f0ymNPhfnp9JGw87hsWJRfi6jG44I6/Q2r9JM6pl96
 HRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6/tAY7sG8rHBuZ3JGryCCYr3n1OexDLH2uk6dgjjXOE=;
 b=rex7T+PLpn6PVNgU3yVV1Z5QQ6nXS4FEzqtUyGAY36EG7twjechkv/5shTO0tZAlVg
 guLtgngTXUXhH3GLseWzmS2inNnDnSmjJQyps9YQE4qQy5pouv/NkEiE5C63YrCuecXT
 wLH+qzNqQz6Lb0cXXjqpTq35kTLbGhjv+a9dzvrGEYfODhsayDMcSsNvrxIvOn6Fr/Gk
 mMmkuMi8HlOfhdQapsXcaAyEJIHP7t+MZ+jYt1WwYP5pHjXqbrmy4Lsd7NHcqA4uUpB1
 GhLmxFUpRVctXBAVktXUA2XY83AfmM28TeAl0xmEkfFoU6csJ35RN8aohaAu7NDIm0K1
 kCjQ==
X-Gm-Message-State: AGi0PubmUJ9se6vXQLi5ciD4J0qAAIoUjr1FvPLT93hjdRwiIgTbGM9Q
 cI2ZI73llA7UXgZXpIRpIFbeRlbcwl4KtmyXfoI=
X-Google-Smtp-Source: APiQypJNiuhBu6h6TpUjqMxFco+WMWQExJxvPAtxUopumix9qPR3H5TS8oFTUN/GexIoDeqyEf4Iuan45+cHdKuBg7Y=
X-Received: by 2002:a1c:6344:: with SMTP id x65mr19446547wmb.56.1586791058036; 
 Mon, 13 Apr 2020 08:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200413143300.23244-1-yanaijie@huawei.com>
In-Reply-To: <20200413143300.23244-1-yanaijie@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Apr 2020 11:17:26 -0400
Message-ID: <CADnq5_NY20m3Y4C3J6jhuzHC-pXj0pSYLgOCVKxrAOA0n=txQw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: remove defined but not used variables in
 ci_dpm.c
To: Jason Yan <yanaijie@huawei.com>
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Hulk Robot <hulkci@huawei.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIHRoYW5rcyEKCkFsZXgKCk9uIE1vbiwgQXByIDEzLCAyMDIwIGF0IDEwOjA2IEFN
IEphc29uIFlhbiA8eWFuYWlqaWVAaHVhd2VpLmNvbT4gd3JvdGU6Cj4KPiBGaXggdGhlIGZvbGxv
d2luZyBnY2Mgd2FybmluZzoKPgo+IGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lfZHBtLmM6ODI6
MzY6IHdhcm5pbmc6IOKAmGRlZmF1bHRzX3NhdHVybl9wcm/igJkKPiBkZWZpbmVkIGJ1dCBub3Qg
dXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGNp
X3B0X2RlZmF1bHRzIGRlZmF1bHRzX3NhdHVybl9wcm8gPQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn4KPiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL2NpX2RwbS5jOjY4OjM2OiB3YXJuaW5nOiDigJhkZWZhdWx0c19ib25haXJlX3Byb+KAmQo+
IGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCj4gIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgY2lfcHRfZGVmYXVsdHMgZGVmYXVsdHNfYm9uYWlyZV9wcm8gPQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4K
PiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+Cj4gU2lnbmVkLW9m
Zi1ieTogSmFzb24gWWFuIDx5YW5haWppZUBodWF3ZWkuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL2NpX2RwbS5jIHwgMTQgLS0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDE0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vY2lfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2NpX2RwbS5jCj4gaW5kZXggYTky
NTdiZWQzNDg0Li4xMzRhYTJiMDFmOTAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9jaV9kcG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lfZHBtLmMKPiBA
QCAtNjUsMTMgKzY1LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjaV9wdF9kZWZhdWx0cyBkZWZh
dWx0c19ib25haXJlX3h0ID0KPiAgICAgICAgIHsgMHgxN0MsIDB4MTcyLCAweDE4MCwgMHgxQkMs
IDB4MUIzLCAweDFCRCwgMHgyMDYsIDB4MjAwLCAweDIwMywgMHgyNUQsIDB4MjVBLCAweDI1NSwg
MHgyQzMsIDB4MkM1LCAweDJCNCB9Cj4gIH07Cj4KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBjaV9w
dF9kZWZhdWx0cyBkZWZhdWx0c19ib25haXJlX3BybyA9Cj4gLXsKPiAtICAgICAgIDEsIDB4Riwg
MHhGRCwgMHgxOSwgNSwgNDUsIDAsIDB4NjUwNjIsCj4gLSAgICAgICB7IDB4OEMsICAweDIzRiwg
MHgyNDQsIDB4QTYsICAweDgzLCAgMHg4NSwgIDB4ODYsICAweDg2LCAgMHg4MywgIDB4REIsICAw
eERCLCAgMHhEQSwgIDB4NjcsICAweDYwLCAgMHg1RiAgfSwKPiAtICAgICAgIHsgMHgxODcsIDB4
MTkzLCAweDE5MywgMHgxQzcsIDB4MUQxLCAweDFEMSwgMHgyMTAsIDB4MjE5LCAweDIxOSwgMHgy
NjYsIDB4MjZDLCAweDI2QywgMHgyQzksIDB4MkNCLCAweDJDQiB9Cj4gLX07Cj4gLQo+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IGNpX3B0X2RlZmF1bHRzIGRlZmF1bHRzX3NhdHVybl94dCA9Cj4gIHsK
PiAgICAgICAgIDEsIDB4RiwgMHhGRCwgMHgxOSwgNSwgNTUsIDAsIDB4NzAwMDAsCj4gQEAgLTc5
LDEzICs3Miw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2lfcHRfZGVmYXVsdHMgZGVmYXVsdHNf
c2F0dXJuX3h0ID0KPiAgICAgICAgIHsgMHgxODcsIDB4MTg3LCAweDE4NywgMHgxQzcsIDB4MUM3
LCAweDFDNywgMHgyMTAsIDB4MjEwLCAweDIxMCwgMHgyNjYsIDB4MjY2LCAweDI2NiwgMHgyQzks
IDB4MkM5LCAweDJDOSB9Cj4gIH07Cj4KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBjaV9wdF9kZWZh
dWx0cyBkZWZhdWx0c19zYXR1cm5fcHJvID0KPiAtewo+IC0gICAgICAgMSwgMHhGLCAweEZELCAw
eDE5LCA1LCA1NSwgMCwgMHgzMDAwMCwKPiAtICAgICAgIHsgMHg5NiwgIDB4MjFELCAweDIzQiwg
MHhBMSwgIDB4ODUsICAweDg3LCAgMHg4MywgIDB4ODQsICAweDgxLCAgMHhFNiwgIDB4RTYsICAw
eEU2LCAgMHg3MSwgIDB4NkEsICAweDZBICB9LAo+IC0gICAgICAgeyAweDE5MywgMHgxOUUsIDB4
MTlFLCAweDFEMiwgMHgxREMsIDB4MURDLCAweDIxQSwgMHgyMjMsIDB4MjIzLCAweDI2RSwgMHgy
N0UsIDB4Mjc0LCAweDJDRiwgMHgyRDIsIDB4MkQyIH0KPiAtfTsKPiAtCj4gIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgY2lfcHRfY29uZmlnX3JlZyBkaWR0X2NvbmZpZ19jaVtdID0KPiAgewo+ICAgICAg
ICAgeyAweDEwLCAweDAwMDAwMGZmLCAwLCAweDAsIENJU0xBTkRTX0NPTkZJR1JFR19ESURUX0lO
RCB9LAo+IC0tCj4gMi4yMS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
