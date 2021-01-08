Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FB4C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF78F2388B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF78F2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED016E8D8;
	Fri,  8 Jan 2021 21:00:17 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F4A6E8CA;
 Fri,  8 Jan 2021 21:00:15 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id q205so12801152oig.13;
 Fri, 08 Jan 2021 13:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2sttTWDiva5/i7UCS9hC+32Kuzu7D1WRMiPwU7HE0c4=;
 b=Can0g5gmZJYiVqWNEeUWWrIMTsjFG9TGCDpbqsIEWLn8xXbWQ2eFIBC5hvgZcdRvhq
 zUuUaigs4CCn4h1yv16tWfnMM2vJGcAHbx3reXhJwYPs1ZD5wsNIQFYJ3N4jIqiEEpL3
 RBGt+icyAzHQTlHCJ+JCOIYZ+z5kn3cI1t+SvltfEqGu4c9dujD11OrFnRGMrQ910XlX
 uCqRTQ3kD06I3tfA2afxZliI53BZtra/QWooLZC4c+k0OQkciQaVhQ3UJVKU45cA9oDv
 eWspbsLzzyB0mQI2NVl83RiNBt4LQMdNgU2BhBb16K2/i2QAQqi/eV30x+LDI9gHpNH+
 IMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2sttTWDiva5/i7UCS9hC+32Kuzu7D1WRMiPwU7HE0c4=;
 b=tiuW5VBdOVHongsAMK2E507EjoRla9DZn9Oyps2czMeBASATfv7Bw+SJCEPfNWxv80
 Wt1lRQhlrLmi093YJihAJo/Bf6xoSPiN7xvRPySRzzcR1VE6Oj++6tmQ9X2lADZ+2EOD
 KIPXs9iU+9XmanKH9dUZi7MVNZ2xCnddohfoLlGgXupGbC6tKcoejFwVkOo5+GNBE33F
 uV/rzvRTfAWs9Kl+K2A8iSmKlHJ1wcTuz7u9RHJIlguHInZy6LE4Oq32pM690KwVI+Db
 b5JD76VLM3QM9jcI+sMCSAccCMVl5GCocRlXedRct2CofbB3K0aPczxYDuEX9d0x/sGD
 Mhfw==
X-Gm-Message-State: AOAM533CcTbJ6nqHYP76ayNhyHZZ8a13wM3BCEFIdWsyzoy9p9/luz6t
 Z+gCVDNd9aEYdcTR5xi2AZC/9CTGdaCSZft8Hso=
X-Google-Smtp-Source: ABdhPJy95TMI5PbQnWyiCX1g20344zR2xlZQs88ADigDiP7zSolhLeEKefV91mcU2GurOeen5KXySWTEQTPAAEQuk/g=
X-Received: by 2002:aca:6202:: with SMTP id w2mr3337455oib.5.1610139615329;
 Fri, 08 Jan 2021 13:00:15 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org>
 <20210108201457.3078600-20-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-20-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Jan 2021 16:00:04 -0500
Message-ID: <CADnq5_NVvzzUKMdFwMoEN97AxgkEY=PCHtiKZACiCQHary2KUg@mail.gmail.com>
Subject: Re: [PATCH 19/40] drm/amd/display/dc/bios/command_table: Remove
 unused variable
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
Cc: Leo Li <sunpeng.li@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, Qinglang Miao <miaoqinglang@huawei.com>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKYW4gOCwgMjAyMSBhdCAzOjE1IFBNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+IHdyb3RlOgo+Cj4gTm9uZSBvZiB0aGUgc3Vycm91bmRpbmcgY29kZSB3YXMgcmVtb3Zl
ZCBqdXN0IGluIGNhc2UgZXZlbiBhIHNtYWxsCj4gZnJhY3Rpb24gb2YgaXQgd2FzIGZ1bmN0aW9u
YWwuCj4KPiBGaXhlcyB0aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToK
Pgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2Jpb3MvY29tbWFu
ZF90YWJsZS5jOiBJbiBmdW5jdGlvbiDigJhhZGp1c3RfZGlzcGxheV9wbGxfdjLigJk6Cj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvYmlvcy9jb21tYW5kX3RhYmxl
LmM6MTQ1OTozNTogd2FybmluZzogdmFyaWFibGUg4oCYcGFyYW1z4oCZIHNldCBidXQgbm90IHVz
ZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCj4KPiBDYzogSGFycnkgV2VudGxhbmQgPGhh
cnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4gQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgo+
IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJp
c3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJs
aWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5j
aD4KPiBDYzogUWluZ2xhbmcgTWlhbyA8bWlhb3FpbmdsYW5nQGh1YXdlaS5jb20+Cj4gQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3Jn
Pgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9jb21tYW5kX3Rh
YmxlLmMgfCAxMiArKystLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvYmlvcy9jb21tYW5kX3RhYmxlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvYmlvcy9jb21tYW5kX3RhYmxlLmMKPiBpbmRleCAwNzA0NTllM2U0MDcwLi5kZDg5M2Ex
MTc2OTc5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9z
L2NvbW1hbmRfdGFibGUuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9i
aW9zL2NvbW1hbmRfdGFibGUuYwo+IEBAIC0xNDU2LDIwICsxNDU2LDE0IEBAIHN0YXRpYyBlbnVt
IGJwX3Jlc3VsdCBhZGp1c3RfZGlzcGxheV9wbGxfdjIoCj4gICAgICAgICBzdHJ1Y3QgYnBfYWRq
dXN0X3BpeGVsX2Nsb2NrX3BhcmFtZXRlcnMgKmJwX3BhcmFtcykKPiAgewoKQEhhcnJ5IFdlbnRs
YW5kLCB0aGlzIGZ1bmN0aW9uIGxvb2tzIGxpa2UgaXQncyBtaXNzaW5nIHRoZSBjYWxsIHRvCkVY
RUNfQklPU19DTURfVEFCTEUoKS4gIEkganVzdCBzZW50IGEgcGF0Y2ggdG8gZml4IHRoYXQgdXAs
IGFsdGhvdWdoCkknbSBub3Qgc3VyZSBpZiB0aGlzIGZ1bmN0aW9uIGV2ZXJ5IGdldHMgdXNlZCBv
biBhbnkgYXNpY3Mgc3VwcG9ydGVkCmJ5IGFtZGdwdSwgc28gbWF5YmUgd2UgY2FuIGp1c3QgZHJv
cCBpdC4KCkFsZXgKCgo+ICAgICAgICAgZW51bSBicF9yZXN1bHQgcmVzdWx0ID0gQlBfUkVTVUxU
X0ZBSUxVUkU7Cj4gLSAgICAgICBBREpVU1RfRElTUExBWV9QTExfUFNfQUxMT0NBVElPTiBwYXJh
bXMgPSB7IDAgfTsKPgo+ICAgICAgICAgLyogV2UgbmVlZCB0byBjb252ZXJ0IGZyb20gS0h6IHVu
aXRzIGludG8gMTBLSHogdW5pdHMgYW5kIHRoZW4gY29udmVydAo+ICAgICAgICAgICogb3V0cHV0
IHBpeGVsIGNsb2NrIGJhY2sgMTBLSHotLT5LSHogKi8KPiAgICAgICAgIHVpbnQzMl90IHBpeGVs
X2Nsb2NrXzEwS0h6X2luID0gYnBfcGFyYW1zLT5waXhlbF9jbG9jayAvIDEwOwo+Cj4gLSAgICAg
ICBwYXJhbXMudXNQaXhlbENsb2NrID0gY3B1X3RvX2xlMTYoKHVpbnQxNl90KShwaXhlbF9jbG9j
a18xMEtIel9pbikpOwo+IC0gICAgICAgcGFyYW1zLnVjVHJhbnNtaXR0ZXJJRCA9Cj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgYnAtPmNtZF9oZWxwZXItPmVuY29kZXJfaWRfdG9fYXRvbSgKPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGFsX2dyYXBoaWNzX29iamVj
dF9pZF9nZXRfZW5jb2Rlcl9pZCgKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJwX3BhcmFtcy0+ZW5jb2Rlcl9vYmplY3RfaWQpKTsKPiAt
ICAgICAgIHBhcmFtcy51Y0VuY29kZU1vZGUgPQo+IC0gICAgICAgICAgICAgICAgICAgICAgICh1
aW50OF90KWJwLT5jbWRfaGVscGVyLT5lbmNvZGVyX21vZGVfYnBfdG9fYXRvbSgKPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnBfcGFyYW1zLT5zaWduYWxfdHlwZSwg
ZmFsc2UpOwo+ICsgICAgICAgYnAtPmNtZF9oZWxwZXItPmVuY29kZXJfaWRfdG9fYXRvbSgKPiAr
ICAgICAgICAgICAgICAgZGFsX2dyYXBoaWNzX29iamVjdF9pZF9nZXRfZW5jb2Rlcl9pZChicF9w
YXJhbXMtPmVuY29kZXJfb2JqZWN0X2lkKSk7Cj4gKyAgICAgICBicC0+Y21kX2hlbHBlci0+ZW5j
b2Rlcl9tb2RlX2JwX3RvX2F0b20oYnBfcGFyYW1zLT5zaWduYWxfdHlwZSwgZmFsc2UpOwo+ICAg
ICAgICAgcmV0dXJuIHJlc3VsdDsKPiAgfQo+Cj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcg
bGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
