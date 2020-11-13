Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DF9C388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AF92078D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLz0dUSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AF92078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E9B26E7D9;
	Fri, 13 Nov 2020 17:31:40 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DAFF6E7D2;
 Fri, 13 Nov 2020 17:31:38 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id j7so10792317wrp.3;
 Fri, 13 Nov 2020 09:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+G+14q8YUvn+nruogBy+Fa8GXZYTPJ311fBa+8TxG4c=;
 b=dLz0dUSglk70LgwaLtsTdNr0UcSubDx/QFF+F42FELFOFWVwito1w+srckTdXvWa1b
 9PuhrbzweAyjV3nkp5pbYt4eHhqrMfqmclGzTIOPbgMSXVen2j+HxfYG5aGea0yzeape
 JSPtRbLOvcxUeSD7IJkzNtyFclrel5ZVqITBanoazCE63IxocyjsKjSuRTrUoW/SYpjp
 BcMk5QbexXsgAImApDe+fw54aB7THChiHIR/IQQbDPMy3/+24lAmlgZhPB10z2Nb2fIj
 kXl4aq3UVQukLch3zLRz4U9Wog2BJ+xVVI3cQFJ0el9I1SMuCAe8aDKsF/HNHqBkCRBK
 JaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+G+14q8YUvn+nruogBy+Fa8GXZYTPJ311fBa+8TxG4c=;
 b=tdC2JfHn9fYC7xyTIy0zsacimbPRBC7ITMYBblKTL9AcdDYqRxix6s2E3ygmiQg9K+
 wWwhkenIgbfd0Fq/IxGTW8HmdQ+J58BIDUWqSMRlvx83m81XDgPnwJA80t2UduICGTO/
 VLGUc9iEWR2Q7+pRomwxYuNKCerSivNylWx+2pfkvV05Dgg+3h1WM3lVv8qjkLj8hpgU
 DQqpQc9PzipURO05xxK8rHUS0uMrsyCRKsx8y6X0FoTZ+sPYGQFd8M+xFPJ4I0gDaIgb
 Sd/yluB7mcm7gLBstmZooPOx7kcC9tQ/EVkJiRjhsXc1fkfn/hSvVd0ISFISK7oZEAiK
 ERcQ==
X-Gm-Message-State: AOAM530a1kydeOttSvYSTlHn0egH/tIkEJR+10IIwYnNOItxYqm24XV3
 hQlSaeHxGnhEViZa7eQSMpGWc1YfBV+wCZlJDDY=
X-Google-Smtp-Source: ABdhPJxieS2jBm9uX3ulJWqz1FwN7GdeITsiOeyV4/OGv+n//yk+djKhaADCQOXe7MnngwXK1i4XVzQp5ThOct8A5V0=
X-Received: by 2002:adf:8028:: with SMTP id 37mr4704368wrk.111.1605288692175; 
 Fri, 13 Nov 2020 09:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-31-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-31-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Nov 2020 12:31:20 -0500
Message-ID: <CADnq5_MbwDAwXXzVC-FOcLwzDNXzS4SzYiEUYbBw2Kh8u+6oEw@mail.gmail.com>
Subject: Re: [PATCH 30/40] drm/amd/amdgpu/amdgpu_vm_cpu: Fix
 'amdgpu_vm_cpu_prepare()'s doc-rot
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
Cc: David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBOb3YgMTMsIDIwMjAgYXQgODo1MCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9jcHUu
Yzo1MDogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAncmVzdicgbm90IGRl
c2NyaWJlZCBpbiAnYW1kZ3B1X3ZtX2NwdV9wcmVwYXJlJwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm1fY3B1LmM6NTA6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBv
ciBtZW1iZXIgJ3N5bmNfbW9kZScgbm90IGRlc2NyaWJlZCBpbiAnYW1kZ3B1X3ZtX2NwdV9wcmVw
YXJlJwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fY3B1LmM6NTA6IHdh
cm5pbmc6IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ293bmVyJyBkZXNjcmlwdGlvbiBpbiAn
YW1kZ3B1X3ZtX2NwdV9wcmVwYXJlJwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm1fY3B1LmM6NTA6IHdhcm5pbmc6IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ2V4Y2x1
c2l2ZScgZGVzY3JpcHRpb24gaW4gJ2FtZGdwdV92bV9jcHVfcHJlcGFyZScKPgo+IENjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2
bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxp
ZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzog
U3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KPiBDYzogRmVsaXggS3VlaGxp
bmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogbGludXgt
bWVkaWFAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9y
Zwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpBcHBs
aWVkLiAgVGhhbmtzIQoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtX2NwdS5jIHwgNCArKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtX2NwdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtX2NwdS5jCj4gaW5kZXggMDc4NmU3NTU1NTU0Yi4uYWM0NWQ5YzdhNGU5NCAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fY3B1LmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fY3B1LmMKPiBAQCAtMzgsOCArMzgs
OCBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9jcHVfbWFwX3RhYmxlKHN0cnVjdCBhbWRncHVfYm8g
KnRhYmxlKQo+ICAgKiBhbWRncHVfdm1fY3B1X3ByZXBhcmUgLSBwcmVwYXJlIHBhZ2UgdGFibGUg
dXBkYXRlIHdpdGggdGhlIENQVQo+ICAgKgo+ICAgKiBAcDogc2VlIGFtZGdwdV92bV91cGRhdGVf
cGFyYW1zIGRlZmluaXRpb24KPiAtICogQG93bmVyOiBvd25lciB3ZSBuZWVkIHRvIHN5bmMgdG8K
PiAtICogQGV4Y2x1c2l2ZTogZXhjbHVzaXZlIG1vdmUgZmVuY2Ugd2UgbmVlZCB0byBzeW5jIHRv
Cj4gKyAqIEByZXN2OiByZXNlcnZhdGlvbiBvYmplY3Qgd2l0aCBlbWJlZGRlZCBmZW5jZQo+ICsg
KiBAc3luY19tb2RlOiBzeW5jaHJvbml6YXRpb24gbW9kZQo+ICAgKgo+ICAgKiBSZXR1cm5zOgo+
ICAgKiBOZWdhdGl2IGVycm5vLCAwIGZvciBzdWNjZXNzLgo+IC0tCj4gMi4yNS4xCj4KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
