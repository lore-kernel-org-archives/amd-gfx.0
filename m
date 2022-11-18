Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E32C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 16:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FCB110E76D;
	Fri, 18 Nov 2022 16:02:59 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA68F10E703
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 15:36:38 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id f27so14000387eje.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 07:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MRdablpQbNdvOGn2U15kgE+GafAkwXepvrB7+WqIm+Y=;
 b=NBYLgOh9lp7dDdUHqoX7/3omUtlo4JF7as1LnQ7hGTFpDFgPJdweWioYLkXTafHwcX
 CPJEz6hX4bVePGLg8YWCcMFIVS7DqCfU0UvWe0yy7wyNwTKIes5ArWbuTAMujDINh6Ae
 Nr4m5zl4jaM5sAQtFwM6BmKRWeCyO6yDVwCwwWc5Tl4ZnSbPleSbMj+LOke0OL0SANgI
 h9pctIhNrxaP420V1Ffza1lXZmqD2xM2yrmZbMpWcaaiRmwg0xosLaJcKlgyRM4Uhn/i
 xJr8+Am5+2w/ABBKMUVy5mlesdMGCczuut13IhrUZOzj6F4opdfLj2y4pzOgLpGR5wVW
 hkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MRdablpQbNdvOGn2U15kgE+GafAkwXepvrB7+WqIm+Y=;
 b=x9dptXobziRDy0zOiE0nXXCa+1sZMQGPMAzj9KNMkn4j/JunvBdsL6J+RWb19jd8SY
 lZEDwICHtAvHoAReB/OMI2UCzmcznrtR2npZwn3KNE3yjBXYRGT7FNv5S4L7yqHNeTDB
 c6BHPylvyFHXnWYu6HIO+fjRw6mVxbugEtPAWPbHDX21WwaBVWoohQLj3dLyQKLY7j4j
 gvs/IfrvLpe025ZCXu8C7+aY2SRY4ehsd/COswi20SqGeSwbzH64krpDaWH0jC586sNT
 tAH2gmTP3LpjHBuMqxrk5QdCCVJDT/h1D1jwDFMb971zOqOEZX1HsRQO8lkcfeDcK0fj
 lqxw==
X-Gm-Message-State: ANoB5pk5dNCtbgaMc4QZRF/uMmJ//Q1m8557WLaiwohf7hJClm2Xtfve
 l96MtRXVzie4Lx31C01DwAU=
X-Google-Smtp-Source: AA0mqf4TSUzlVVZ+mhOMoNMgaw6gdGgpM/d/sdXhI0jqpVXXl5NPsBrVEAZ3g1XLs5PXMbQ2vByZ5A==
X-Received: by 2002:a17:906:3c4d:b0:78d:f2d8:4623 with SMTP id
 i13-20020a1709063c4d00b0078df2d84623mr6666461ejg.274.1668785797170; 
 Fri, 18 Nov 2022 07:36:37 -0800 (PST)
Received: from [192.168.0.126] (catv-89-134-213-173.catv.fixed.vodafone.hu.
 [89.134.213.173]) by smtp.gmail.com with ESMTPSA id
 25-20020a170906301900b007806c1474e1sm1812094ejz.127.2022.11.18.07.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Nov 2022 07:36:36 -0800 (PST)
Message-ID: <3144fa81950d36c0e30d984ecc775664a86f754f.camel@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: handle gang submit before VMID
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 amd-gfx@lists.freedesktop.org
Date: Fri, 18 Nov 2022 16:36:35 +0100
In-Reply-To: <20221118153023.312582-1-christian.koenig@amd.com>
References: <20221118153023.312582-1-christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 18 Nov 2022 16:02:54 +0000
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
Cc: Alexander.Deucher@amd.com,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Q2FuIHlvdSBndXlzIHBsZWFzZSBwdXNoIHRoaXMgaW50byB0aGUgbmV4dCA2LjEgUkM/IFRoaXMg
c29sdmVzIGEKc2lnbmlmaWNhbnQgaXNzdWUgd2l0aCBnYW5nIHN1Ym1pdC4KCk9uIEZyaSwgMjAy
Mi0xMS0xOCBhdCAxNjozMCArMDEwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBPdGhlcndp
c2UgaXQgY2FuIGhhcHBlbiB0aGF0IG5vdCBhbGwgZ2FuZyBtZW1iZXJzIGNhbiBnZXQgYSBWTUlE
Cj4gYXNzaWduZWQgYW5kIHdlIGRlYWRsb2NrLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBUZXN0ZWQtYnk6IFRpbXVyIEty
aXN0w7NmIDx0aW11ci5rcmlzdG9mQGdtYWlsLmNvbT4KPiBBY2tlZC1ieTogVGltdXIgS3Jpc3TD
s2YgPHRpbXVyLmtyaXN0b2ZAZ21haWwuY29tPgo+IEZpeGVzOiA2OGNlOGIyNDIyNDIgKCJkcm0v
YW1kZ3B1OiBhZGQgZ2FuZyBzdWJtaXQgYmFja2VuZCB2MiIpCj4gLS0tCj4gwqBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMgfCA2ICsrKy0tLQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jCj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfam9iLmMKPiBpbmRleCBjZDk2OGU3ODEwNzcuLmFiYjk5Y2ZmOGI0
YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMKPiBAQCAtMjU0
LDYgKzI1NCw5IEBAIHN0YXRpYyBzdHJ1Y3QgZG1hX2ZlbmNlCj4gKmFtZGdwdV9qb2JfZGVwZW5k
ZW5jeShzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqc2NoZWRfam9iLAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoERSTV9FUlJPUigiRXJyb3IgYWRkaW5nIGZl
bmNlICglZClcbiIsIHIpOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiArwqDCoMKgwqDCoMKg
wqBpZiAoIWZlbmNlICYmIGpvYi0+Z2FuZ19zdWJtaXQpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGZlbmNlID0gYW1kZ3B1X2RldmljZV9zd2l0Y2hfZ2FuZyhyaW5nLT5hZGV2LCBq
b2ItCj4gPmdhbmdfc3VibWl0KTsKPiArCj4gwqDCoMKgwqDCoMKgwqDCoHdoaWxlIChmZW5jZSA9
PSBOVUxMICYmIHZtICYmICFqb2ItPnZtaWQpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHIgPSBhbWRncHVfdm1pZF9ncmFiKHZtLCByaW5nLCAmam9iLT5zeW5jLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAmam9iLT5iYXNlLnNfZmVuY2UtPmZpbmlzaGVkLAo+IEBAIC0yNjQsOSArMjY3
LDYgQEAgc3RhdGljIHN0cnVjdCBkbWFfZmVuY2UKPiAqYW1kZ3B1X2pvYl9kZXBlbmRlbmN5KHN0
cnVjdCBkcm1fc2NoZWRfam9iICpzY2hlZF9qb2IsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBmZW5jZSA9IGFtZGdwdV9zeW5jX2dldF9mZW5jZSgmam9iLT5zeW5jKTsKPiDCoMKg
wqDCoMKgwqDCoMKgfQo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgaWYgKCFmZW5jZSAmJiBqb2ItPmdh
bmdfc3VibWl0KQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmZW5jZSA9IGFtZGdw
dV9kZXZpY2Vfc3dpdGNoX2dhbmcocmluZy0+YWRldiwgam9iLQo+ID5nYW5nX3N1Ym1pdCk7Cj4g
LQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZmVuY2U7Cj4gwqB9Cj4gwqAKCg==

