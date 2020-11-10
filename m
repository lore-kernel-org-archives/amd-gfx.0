Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8890EC388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 00:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13723205CA
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 00:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQwkHYPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13723205CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47D9889565;
	Wed, 11 Nov 2020 00:09:42 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFF1889381
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 21:20:42 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id s13so4595436wmh.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 13:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=QIBJshKpv92POnG5rECWEfa1XG4D+wo2F1uj30221ws=;
 b=MQwkHYPkvDN417BZe5U6Pp09S/rmgt2LyTmKr39o80Gl8IVjOLC4+fbs2EX+mD1vVg
 BfHLXDrzZEkogEJFztCSPvzrIbNWeB4FB+Ko3qWk1l0zenpiTkaROItaxYWL1pj45M8z
 DAkcacHe5YPHy5055oswQsRNe4EJYM2eHtebBlQL6sad7DgMpJPFB9dNWoDmNfw3etWN
 FczHcnOOiPZoNL4PEwRNMWd1EZ/5NS7p7wXoPsdiHvcvpkUJVx2sOjHVcKesQp2q/G91
 +kU35alQnVbwVPHbnPLHCdKLoXK28BsRmxj5s5roTukIWMO3+T2ToE8Y68jYUuhUr43Y
 HyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=QIBJshKpv92POnG5rECWEfa1XG4D+wo2F1uj30221ws=;
 b=reerD4ywqRSzlIAa8P+ytaFIlhq00xKxLVG70KUOmu/Hvxm3gtufBeVXHg+P2/74cx
 MZqY+siP4YcnPs6A/UdqTtsUaSqt1Spvhzujk27UPqd6g8eq29NbPkYpQf/iI2S/z8Dj
 aZfGL6KgIS+ld6lRHhp+ptXljkJMEIcl/YXg3NU4GEkf9hWHNbZ2YXeCKMZH+jmd3WJM
 GLGFJdIeGh3ku1V5kt6nsinUwJcYPZi92jmZESZs1tIorVZjjpYgP7ZKPzAwDH2MpAId
 fb46EJQ2XBNjKBFRJcUXV4MkHLhOWH3YoFE9IieyFfUC20BoLlEa+ir8m2DqAaa3SsCn
 JS/w==
X-Gm-Message-State: AOAM532SZZSpxhazTQn8MUe/YSZtj3+Zkk3xW4ovRjM8mw+hL0PrarCg
 gtjoamF44BmEZoF9o3UFQRybSg==
X-Google-Smtp-Source: ABdhPJwCTUWwrks9Lt6bjM5yd8fytosAD9T3MWUv1CZE5JGhqzDgmOEGA7pKRClkRBXcOndIAPqC5Q==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr34234wma.171.1605043241519;
 Tue, 10 Nov 2020 13:20:41 -0800 (PST)
Received: from dell ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id v8sm78027wmg.28.2020.11.10.13.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 13:20:40 -0800 (PST)
Date: Tue, 10 Nov 2020 21:20:39 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 15/19] gpu: drm: radeon: radeon_drv: Remove unused
 variable 'ret'
Message-ID: <20201110212039.GL2063125@dell>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-16-lee.jones@linaro.org>
 <CADnq5_PZRM0wmrcJAGfdyFqnR68gbVQK76TrHSbJJRK1t8cT8g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_PZRM0wmrcJAGfdyFqnR68gbVQK76TrHSbJJRK1t8cT8g@mail.gmail.com>
X-Mailman-Approved-At: Wed, 11 Nov 2020 00:09:41 +0000
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
 Alex Deucher <alexander.deucher@amd.com>, Gareth Hughes <gareth@valinux.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCAxMCBOb3YgMjAyMCwgQWxleCBEZXVjaGVyIHdyb3RlOgoKPiBPbiBUaHUsIE5vdiA1
LCAyMDIwIGF0IDk6NTIgQU0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6
Cj4gPgo+ID4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6
Cj4gPgo+ID4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jOiBJbiBmdW5jdGlv
biDigJhyYWRlb25fcG1vcHNfcnVudGltZV9zdXNwZW5k4oCZOgo+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX2Rydi5jOjQ1NTo2OiB3YXJuaW5nOiB2YXJpYWJsZSDigJhyZXTigJkg
c2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KPiA+Cj4gPiBDYzog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+ID4gQ2M6ICJDaHJpc3Rp
YW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+ID4gQ2M6IERhdmlkIEFpcmxp
ZSA8YWlybGllZEBsaW51eC5pZT4KPiA+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwu
Y2g+Cj4gPiBDYzogR2FyZXRoIEh1Z2hlcyA8Z2FyZXRoQHZhbGludXguY29tPgo+ID4gQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+ID4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJv
Lm9yZz4KPiAKPiBBcHBsaWVkLiAgVGhhbmtzIQoKVGhhbmtzIEFsZXguCgpJJ2xsIHJlYmFzZSBp
biBhIGZldyBkYXlzIGFuZCBmaXgvcmVzZW5kIHdoYXRldmVyIGlzIG91dHN0YW5kaW5nLgoKLS0g
CkxlZSBKb25lcyBb5p2O55C85pavXQpTZW5pb3IgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIg
U2VydmljZXMKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0Nz
CkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
