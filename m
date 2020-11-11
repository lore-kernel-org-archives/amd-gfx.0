Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E08C55ABD
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 00:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8C620809
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 00:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO2M7uTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8C620809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 006C389D4A;
	Wed, 11 Nov 2020 00:05:18 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F85089D66;
 Wed, 11 Nov 2020 00:05:16 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id d142so206494wmd.4;
 Tue, 10 Nov 2020 16:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4aRvj5frq2x2Ig3VTHGXWjNecxTnIxom7+px4DcCz0c=;
 b=FO2M7uTurZnh4C3vREryU20s0FpeQM2WbJtlUXhCEVef4AooWpyc8Azm/Ynt1SU023
 HcLuFI3eaj5Svi/jKo1njI77J+5aWkA9uKZsDM7Xkd/ATHbG921QkZrptNLhjN8UhL2J
 3LQtp4U1eDD3+ibbK+DVX3Zp7YQ/+dHRO1kXPUWSvcr/qlsMHcB0c952jpTsxqZhB/K0
 AOEWFGK9sakRTGNv4FzUBu5xIB7uC3zyY82UmKZmcfRvLSsjg7rliVWLPoQ0YJ3CwOLQ
 0bmsxlvfYPIP4r9FNLVkxrttl91vaeBUelEIrNcHBqKelZ8o9hjs5KIt2XYG7OJQeWqJ
 s12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4aRvj5frq2x2Ig3VTHGXWjNecxTnIxom7+px4DcCz0c=;
 b=ig0ROk0DPlC7hYUXq4pj1LAGR1Ytxc5KMqyNbcjhkjfSdpeAZnlbLOjIXZxVPRVPO7
 UkxT/noDrGOzAuOK8SimTv7/qWg7+03/qjIRZrSliPxXrPEyoiGZ8T37g7/mwaxlMtoz
 pp/3YIWTXkDrZdHoIhk8oeLlv7WdG93g3nx/0hDuB4FeTIZayguoRKDdRWWp+RUf8mT6
 ybsjOP9B9tQ+U9s4aKfDn2VD3p4aeMCHFk+kjiAagUoTstBez/ZHwN60Qbkt+vY1I2bR
 rkFdFDBRJyaXlY8Zw2yylaWVRzEhfnyIImuYeJV3l5C9E2+9rKLfAMeoUazx/wM3pi/n
 U6jw==
X-Gm-Message-State: AOAM530Sx0uUATeY7QoeS+10CLvLH5FHumkrvhK9cicfFzkfzOp8Gwx8
 tfeOZ5LjMpYMmLfQaqXwCEQTdzwyPoaKImSjSz8=
X-Google-Smtp-Source: ABdhPJyM77nEspqaxvn9OWN0UGEKlPqHVnIO+WXkoMEHq47+GSyGrP9fYmwOW3uqOWzKMJY3a9TwutaLObHNCt5r9YI=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr629819wmb.39.1605053114850;
 Tue, 10 Nov 2020 16:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org>
 <20201110193112.988999-26-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-26-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2020 19:05:03 -0500
Message-ID: <CADnq5_M4rN9gOZaC_FEVBd_XtpMxKNzG7X3dzCd49gRUirFH-Q@mail.gmail.com>
Subject: Re: [PATCH 25/30] drm/radeon/sumo_dpm: Move 'sumo_get_pi()'s
 prototype into shared header
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBOb3YgMTAsIDIwMjAgYXQgMjozMiBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vc3Vtb19kcG0uYzo4MToyNTog
d2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhzdW1vX2dldF9waeKAmSBbLVdt
aXNzaW5nLXByb3RvdHlwZXNdCj4gIDgxIHwgc3RydWN0IHN1bW9fcG93ZXJfaW5mbyAqc3Vtb19n
ZXRfcGkoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4gIHwgXn5+fn5+fn5+fn4KPgo+IENj
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3Rp
YW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUg
PGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4K
PiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxp
bmFyby5vcmc+CgpBcHBsaWVkLiAgVGhhbmtzIQoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9zdW1vX2RwbS5oIHwgMSArCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vc3Vt
b19zbWMuYyB8IDIgLS0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3N1bW9fZHBt
LmggYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3N1bW9fZHBtLmgKPiBpbmRleCBmMTY1MTEzNWE0
N2FiLi5kYjI5ZDM3YWUyNzAzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
c3Vtb19kcG0uaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc3Vtb19kcG0uaAo+IEBA
IC0yMDcsNiArMjA3LDcgQEAgdTMyIHN1bW9fZ2V0X3NsZWVwX2RpdmlkZXJfZnJvbV9pZCh1MzIg
aWQpOwo+ICB1MzIgc3Vtb19nZXRfc2xlZXBfZGl2aWRlcl9pZF9mcm9tX2Nsb2NrKHN0cnVjdCBy
YWRlb25fZGV2aWNlICpyZGV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdTMyIHNjbGssCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1MzIgbWluX3NjbGtfaW5fc3IpOwo+ICtzdHJ1Y3Qgc3Vtb19wb3dlcl9pbmZvICpzdW1vX2dl
dF9waShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4KPiAgLyogc3Vtb19zbWMuYyAqLwo+
ICB2b2lkIHN1bW9faW5pdGlhbGl6ZV9tM19hcmIoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYp
Owo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3N1bW9fc21jLmMgYi9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3N1bW9fc21jLmMKPiBpbmRleCBkNzgxNDA3MDU3MzY2Li43OGQ4
NzE2MDY3MzE4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc3Vtb19zbWMu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc3Vtb19zbWMuYwo+IEBAIC0zMCw4ICsz
MCw2IEBACj4gICNkZWZpbmUgU1VNT19TTVVfU0VSVklDRV9ST1VUSU5FX0FMVFZERE5CX05PVElG
WSAgMjcKPiAgI2RlZmluZSBTVU1PX1NNVV9TRVJWSUNFX1JPVVRJTkVfR0ZYX1NSVl9JRF8yMCAg
MjAKPgo+IC1zdHJ1Y3Qgc3Vtb19wb3dlcl9pbmZvICpzdW1vX2dldF9waShzdHJ1Y3QgcmFkZW9u
X2RldmljZSAqcmRldik7Cj4gLQo+ICBzdGF0aWMgdm9pZCBzdW1vX3NlbmRfbXNnX3RvX3NtdShz
dHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwgdTMyIGlkKQo+ICB7Cj4gICAgICAgICB1MzIgZ2Z4
X2ludF9yZXE7Cj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
