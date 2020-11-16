Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC91C4742C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 20:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666CA2223D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 20:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBV29QQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666CA2223D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 548F46E11E;
	Mon, 16 Nov 2020 20:45:42 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E37F6E11A;
 Mon, 16 Nov 2020 20:45:40 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a3so570035wmb.5;
 Mon, 16 Nov 2020 12:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tUf+hLuTWmV9Lrrq70vQEtFjHd9qJhhsAirpAP6Z+pg=;
 b=qBV29QQ+OIuxZvy39eKHPqsKYg5pkmeun2KSEpsIoeUoU5HX8DjR82pybfizZ+4uGl
 g4hiYGyVwKpm3OyjGrlL+wulbyaWBuVC8jlgSXEP/iaC+j6FWRZzvLxKq82+wBJOc5il
 E/RA15N1qOOwdP0GW91QYJH+MfxT1C4Mjp1e6jkg9IBn+XCn9LvGl92rlq9nElXpBtuO
 6YCb3VRlNb7Q0SmzjIkvzAD+Nc55V4uCF+8pSs+H+6hsTA2neXO4oBfB98MCw/jaiZ7F
 yzkyAnHFCbopFV5n0dd7bM51mPU503IrLPJ04lGcRJ3woUjvM0OE+o8KBnJCitv8cUjW
 PnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tUf+hLuTWmV9Lrrq70vQEtFjHd9qJhhsAirpAP6Z+pg=;
 b=kln4eZ3OLX7kEuIhE8DoNuuMg7oGYI+Xa2/h7Ml+XGCpKHYdacG12RouQqqTiOJydN
 SphrMxylgqy5mabPGGYoX6A6zW1IFo0bwKOAeYrkdVAknT7QibZFsQhMNP1z02HFsw25
 LV0+mYVnBQIk06OZnkCTy3w5/BrgYt1MuOBdfYKLHpXsk8OLhtDKfEP11ch6kXfsSp7O
 6aU5hQjQKb032A+SnF257L8OuOHM/LFXGGpGAOrFJmzxT7xZgnVMy+4ap4otFxuYhJxZ
 mvikFBIS2nTCRWkyQrdFV5zfFCDQdCMcSkyJSgdt3NS9iW0/UdQ32d/nue/DBNJ5R0pW
 WCqQ==
X-Gm-Message-State: AOAM5312dUfaVb72zrDjPa78I8KAPDL+fHGffl0ZWfr3STXpeyfEQmD8
 A4McjAgujdxn1dE8Apy0UktOp6JOdfkYCj24beQ=
X-Google-Smtp-Source: ABdhPJwbvslghUU5OAz63L5KkVFc6VvkczPD/RPO9qq6rbYNvw0Kw0jZmg9wNV4J3AJz7tSNYHWdzYk9p6QfYTuCnE0=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr730703wmi.70.1605559539244;
 Mon, 16 Nov 2020 12:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org>
 <20201116173700.1830487-41-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-41-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Nov 2020 15:45:28 -0500
Message-ID: <CADnq5_MfZBnSPegGHvPvYJDVjaxabP94M_KNtX98gFT5ok_=vA@mail.gmail.com>
Subject: Re: [PATCH 40/43] drm/radeon/cik: Move 'vce_v2_0_enable_mgcg()'s
 prototype to shared header
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTI6MzggUE0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGlu
YXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQg
d2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3ZjZV92Ml8wLmM6MTExOjY6
IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYdmNlX3YyXzBfZW5hYmxlX21n
Y2figJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+ICAxMTEgfCB2b2lkIHZjZV92Ml8wX2VuYWJs
ZV9tZ2NnKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBib29sIGVuYWJsZSkKPiAgfCBefn5+
fn5+fn5+fn5+fn5+fn5+fgo+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZl
dHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBs
aW5hcm8ub3JnPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVs
Lm9yZwo+IENjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKPiBTaWduZWQtb2ZmLWJ5
OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFs
ZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMgICAgICB8IDIgKy0KPiAg
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi92Y2UuaCAgICAgIHwgMSArCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vdmNlX3YyXzAuYyB8IDEgKwo+ICAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vY2lrLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npay5jCj4gaW5kZXggMmFmNzY0NjM5
MDZhZC4uOGI3YTRmN2I3NTc2NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L2Npay5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWsuYwo+IEBAIC00MSw2ICs0
MSw3IEBACj4gICNpbmNsdWRlICJyYWRlb25fYXVkaW8uaCIKPiAgI2luY2x1ZGUgInJhZGVvbl91
Y29kZS5oIgo+ICAjaW5jbHVkZSAic2kuaCIKPiArI2luY2x1ZGUgInZjZS5oIgo+Cj4gICNkZWZp
bmUgU0hfTUVNX0NPTkZJR19HRlhfREVGQVVMVCBcCj4gICAgICAgICBBTElHTk1FTlRfTU9ERShT
SF9NRU1fQUxJR05NRU5UX01PREVfVU5BTElHTkVEKQo+IEBAIC0xMjksNyArMTMwLDYgQEAgTU9E
VUxFX0ZJUk1XQVJFKCJyYWRlb24vbXVsbGluc19ybGMuYmluIik7Cj4gIE1PRFVMRV9GSVJNV0FS
RSgicmFkZW9uL211bGxpbnNfc2RtYS5iaW4iKTsKPgo+ICBzdGF0aWMgdTMyIGNpa19nZXRfY3Vf
YWN0aXZlX2JpdG1hcChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwgdTMyIHNlLCB1MzIgc2gp
Owo+IC1leHRlcm4gdm9pZCB2Y2VfdjJfMF9lbmFibGVfbWdjZyhzdHJ1Y3QgcmFkZW9uX2Rldmlj
ZSAqcmRldiwgYm9vbCBlbmFibGUpOwo+ICBzdGF0aWMgdm9pZCBjaWtfcmxjX3N0b3Aoc3RydWN0
IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+ICBzdGF0aWMgdm9pZCBjaWtfcGNpZV9nZW4zX2VuYWJs
ZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4gIHN0YXRpYyB2b2lkIGNpa19wcm9ncmFt
X2FzcG0oc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3ZjZS5oIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi92Y2UuaAo+IGlu
ZGV4IDFlYjRmNTcxNTIwMmUuLmNjYzljMDBmMGQwMmMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi92Y2UuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vdmNlLmgK
PiBAQCAtMzAsNSArMzAsNiBAQAo+ICBzdHJ1Y3QgcmFkZW9uX2RldmljZTsKPgo+ICB2b2lkIHZj
ZV92MV8wX2VuYWJsZV9tZ2NnKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBib29sIGVuYWJs
ZSk7Cj4gK3ZvaWQgdmNlX3YyXzBfZW5hYmxlX21nY2coc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJk
ZXYsIGJvb2wgZW5hYmxlKTsKPgo+ICAjZW5kaWYgICAgICAgICAgICAgICAgICAgICAgICAgLyog
X19WQ0VfSF9fICovCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vdmNlX3Yy
XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vdmNlX3YyXzAuYwo+IGluZGV4IGQ2ZmRlMzY1
OWU2NWYuLjE2M2M5YmZjMDNkYTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi92Y2VfdjJfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi92Y2VfdjJfMC5jCj4g
QEAgLTMwLDYgKzMwLDcgQEAKPiAgI2luY2x1ZGUgInJhZGVvbi5oIgo+ICAjaW5jbHVkZSAicmFk
ZW9uX2FzaWMuaCIKPiAgI2luY2x1ZGUgImNpa2QuaCIKPiArI2luY2x1ZGUgInZjZS5oIgo+Cj4g
ICNkZWZpbmUgVkNFX1YyXzBfRldfU0laRSAgICAgICAoMjU2ICogMTAyNCkKPiAgI2RlZmluZSBW
Q0VfVjJfMF9TVEFDS19TSVpFICAgICg2NCAqIDEwMjQpCj4gLS0KPiAyLjI1LjEKPgo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1h
aWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
