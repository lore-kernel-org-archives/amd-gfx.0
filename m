Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE4C5517A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 08:25:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012792080A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 08:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwHDLKEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012792080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E7189250;
	Tue, 10 Nov 2020 08:25:46 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5111B89895
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 07:22:46 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id r17so7563532wrw.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 23:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=pgYTv/xDlwDGx17SGvB/gmIGQuabjes19DWEJkyXO6Y=;
 b=cwHDLKEkoU3j/6kaUgRxnWyiP409LDccPLWTOyHyBR0pT/tPbRhXPW9aCPehvwdKow
 1hVCnfPhvw0c29TtlfHBUl1QHajuqTtQnbN93IixMRcxlLLJWITG46Qd9L5T51+EBHz1
 WXOsGB9CbqRiZwVruhdW8wNXrIDqnI70w0NUbKmFDFgSdQB71aEV8cSUrz+v0Viwxy0s
 ldGSbxePw57Te9VGYcynnwfZqeNgVMNXkCa3we0adZQpcPkjRseKARXjj/GN9ZRafwXY
 j9/fg7Kr9azoWvLybrRKXCe+y3xhgWtyPAXg5kZ/NSlVgXadm4e1tPR5cW82icqTZYdx
 XjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=pgYTv/xDlwDGx17SGvB/gmIGQuabjes19DWEJkyXO6Y=;
 b=fWhb8WiHR7H6EvTFbCYIDQM0JHGDd7SNwGzwXAPYV0n7XVb0weiXYy5N6pZ/HWwa2E
 Tw6OwmGEmO3NvnkrkSvXlX3cy9FfpaQFFD54BOb90onBUJfV7seWyu5dGFWvV4xKdlxt
 LaUI+H9hQPSbOdI4KRYAheKejR2yMENIRboBrY/3Y0eDoa8xDEZjSRnZMMihi6Tsjclz
 q37kglXNNeQ/rULLuMAXw8BEOTg5yd9YkDEVih/Mzieqa+j1i39vDz6pPPxn0mOEuYHt
 0RTfASRhYl5NSIr6G/sLxZ7rZapNWiL8/qXvMZexSpScJu5zMKA+xSHFrbSxpx4KqD0z
 +3QA==
X-Gm-Message-State: AOAM531rAGDVTEEpgqhQT5wNngw3erQW4b2rNI44dvqXS6K709DsxKK5
 M4CchzRcApho80NqN2Gqn6mJ7nZ2TULbRQKE
X-Google-Smtp-Source: ABdhPJytbodfPNciSJGHPfGDtp2n8M8AqMAnaG/IPVy9kKlEQBc0JnB43SLpHstkACTrQQIVaCMtfQ==
X-Received: by 2002:adf:80cb:: with SMTP id 69mr21704418wrl.325.1604992965012; 
 Mon, 09 Nov 2020 23:22:45 -0800 (PST)
Received: from dell ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id n10sm5685079wrv.77.2020.11.09.23.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 23:22:44 -0800 (PST)
Date: Tue, 10 Nov 2020 07:22:42 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 15/20] drm/radeon/r600d: Move 'rc600_*' prototypes into
 shared header
Message-ID: <20201110072242.GF2063125@dell>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
 <20201109211855.3340030-16-lee.jones@linaro.org>
 <CADnq5_NvitEQWH3Z+5EgOH3zJn=P5YTqwHQo4LLQLi0Hj0Dpww@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_NvitEQWH3Z+5EgOH3zJn=P5YTqwHQo4LLQLi0Hj0Dpww@mail.gmail.com>
X-Mailman-Approved-At: Tue, 10 Nov 2020 08:25:45 +0000
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
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCAwOSBOb3YgMjAyMCwgQWxleCBEZXVjaGVyIHdyb3RlOgoKPiBPbiBNb24sIE5vdiA5
LCAyMDIwIGF0IDQ6MTkgUE0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6
Cj4gPgo+ID4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6
Cj4gPgo+ID4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMF9oZG1pLmM6MTc3OjY6IHdhcm5p
bmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYcjYwMF9oZG1pX3VwZGF0ZV9hY3LigJkg
Wy1XbWlzc2luZy1wcm90b3R5cGVzXQo+ID4gIDE3NyB8IHZvaWQgcjYwMF9oZG1pX3VwZGF0ZV9h
Y3Ioc3RydWN0IGRybV9lbmNvZGVyICplbmNvZGVyLCBsb25nIG9mZnNldCwKPiA+ICB8IF5+fn5+
fn5+fn5+fn5+fn5+fn5+Cj4gPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yNjAwX2hkbWkuYzoy
MTc6Njogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhyNjAwX3NldF9hdmlf
cGFja2V04oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KPiA+ICAyMTcgfCB2b2lkIHI2MDBfc2V0
X2F2aV9wYWNrZXQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsIHUzMiBvZmZzZXQsCj4gPiAg
fCBefn5+fn5+fn5+fn5+fn5+fn5+Cj4gPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yNjAwX2hk
bWkuYzozMTQ6Njogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhyNjAwX2hk
bWlfYXVkaW9fc2V0X2R0b+KAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCj4gPiAgMzE0IHwgdm9p
ZCByNjAwX2hkbWlfYXVkaW9fc2V0X2R0byhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwKPiA+
ICB8IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4gPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
NjAwX2hkbWkuYzozNDA6Njogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhy
NjAwX3NldF92YmlfcGFja2V04oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KPiA+ICAzNDAgfCB2
b2lkIHI2MDBfc2V0X3ZiaV9wYWNrZXQoc3RydWN0IGRybV9lbmNvZGVyICplbmNvZGVyLCB1MzIg
b2Zmc2V0KQo+ID4gIHwgXn5+fn5+fn5+fn5+fn5+fn5+fgo+ID4gIGRyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcjYwMF9oZG1pLmM6MzUxOjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBm
b3Ig4oCYcjYwMF9zZXRfYXVkaW9fcGFja2V04oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KPiA+
ICAzNTEgfCB2b2lkIHI2MDBfc2V0X2F1ZGlvX3BhY2tldChzdHJ1Y3QgZHJtX2VuY29kZXIgKmVu
Y29kZXIsIHUzMiBvZmZzZXQpCj4gPiAgfCBefn5+fn5+fn5+fn5+fn5+fn5+fn4KPiA+ICBkcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDBfaGRtaS5jOjM5Mzo2OiB3YXJuaW5nOiBubyBwcmV2aW91
cyBwcm90b3R5cGUgZm9yIOKAmHI2MDBfc2V0X211dGXigJkgWy1XbWlzc2luZy1wcm90b3R5cGVz
XQo+ID4gIDM5MyB8IHZvaWQgcjYwMF9zZXRfbXV0ZShzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29k
ZXIsIHUzMiBvZmZzZXQsIGJvb2wgbXV0ZSkKPiA+ICB8IF5+fn5+fn5+fn5+fn4KPiA+ICBkcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDBfaGRtaS5jOjQ2OTo2OiB3YXJuaW5nOiBubyBwcmV2aW91
cyBwcm90b3R5cGUgZm9yIOKAmHI2MDBfaGRtaV9lbmFibGXigJkgWy1XbWlzc2luZy1wcm90b3R5
cGVzXQo+ID4gIDQ2OSB8IHZvaWQgcjYwMF9oZG1pX2VuYWJsZShzdHJ1Y3QgZHJtX2VuY29kZXIg
KmVuY29kZXIsIGJvb2wgZW5hYmxlKQo+ID4gIHwgXn5+fn5+fn5+fn5+fn5+fgo+ID4KPiA+IENj
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiBDYzogIkNocmlz
dGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gPiBDYzogRGF2aWQgQWly
bGllIDxhaXJsaWVkQGxpbnV4LmllPgo+ID4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZnds
bC5jaD4KPiA+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4gQ2M6IGRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8
bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3I2MDBkLmggICAgICAgIHwgMTQgKysrKysrKysrKysrKysKPiA+ICBkcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9hdWRpby5jIHwgMTEgKy0tLS0tLS0tLS0KPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDE1IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDBkLmggYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3I2MDBkLmgKPiA+IGluZGV4IDJlMDBhNTI4N2JkMmQuLmRiNGJjYzhiZWU0ZTUgMTAwNjQ0Cj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDBkLmgKPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcjYwMGQuaAo+ID4gQEAgLTI3LDYgKzI3LDIwIEBACj4gPiAgI2lmbmRl
ZiBSNjAwRF9ICj4gPiAgI2RlZmluZSBSNjAwRF9ICj4gPgo+ID4gK3N0cnVjdCByYWRlb25fY3J0
YzsKPiA+ICtzdHJ1Y3QgcmFkZW9uX2hkbWlfYWNyOwo+ID4gKwo+ID4gK3ZvaWQgcjYwMF9zZXRf
YXVkaW9fcGFja2V0KHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlciwgdTMyIG9mZnNldCk7Cj4g
PiArdm9pZCByNjAwX3NldF9tdXRlKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlciwgdTMyIG9m
ZnNldCwgYm9vbCBtdXRlKTsKPiA+ICt2b2lkIHI2MDBfaGRtaV9hdWRpb19zZXRfZHRvKHN0cnVj
dCByYWRlb25fZGV2aWNlICpyZGV2LAo+ID4gKyAgICAgICBzdHJ1Y3QgcmFkZW9uX2NydGMgKmNy
dGMsIHVuc2lnbmVkIGludCBjbG9jayk7Cj4gPiArdm9pZCByNjAwX3NldF9hdmlfcGFja2V0KHN0
cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCB1MzIgb2Zmc2V0LAo+ID4gKyAgICAgICB1bnNpZ25l
ZCBjaGFyICpidWZmZXIsIHNpemVfdCBzaXplKTsKPiA+ICt2b2lkIHI2MDBfaGRtaV91cGRhdGVf
YWNyKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlciwgbG9uZyBvZmZzZXQsCj4gPiArICAgICAg
IGNvbnN0IHN0cnVjdCByYWRlb25faGRtaV9hY3IgKmFjcik7Cj4gPiArdm9pZCByNjAwX3NldF92
YmlfcGFja2V0KHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlciwgdTMyIG9mZnNldCk7Cj4gPiAr
dm9pZCByNjAwX2hkbWlfZW5hYmxlKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlciwgYm9vbCBl
bmFibGUpOwo+ID4gKwo+IAo+IHRoZSAqZC5oIGhlYWRlcnMgYXJlIHN1cHBvc2VkIHRvIGp1c3Qg
YmUgaGFyZHdhcmUgZGVmaW5pdGlvbnMuICBJJ2QKPiBwcmVmZXIgdG8ga2VlcCBkcml2ZXIgc3R1
ZmYgb3V0IG9mIHRoZW0uCgpUaGF0J3MgZmluZSAoSSBkaWQgd29uZGVyIGlmIHRoYXQgd2VyZSB0
aGUgY2FzZSkuCgpJIG5lZWQgYW4gYW5zd2VyIGZyb20geW91IGFuZCBTYW0gd2hldGhlciBJIGNh
biBjcmVhdGUgbmV3IGhlYWRlcnMuCgpGb3IgbWUsIGl0IGlzIHRoZSByaWdodCB0aGluZyB0byBk
by4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KU2VuaW9yIFRlY2huaWNhbCBMZWFkIC0gRGV2
ZWxvcGVyIFNlcnZpY2VzCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBB
cm0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
