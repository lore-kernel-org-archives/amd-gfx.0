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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB64C61DD8
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA60721D1A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Edt20aWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA60721D1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C146E563;
	Fri, 13 Nov 2020 17:12:42 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70A956E563;
 Fri, 13 Nov 2020 17:12:41 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id b6so10717341wrt.4;
 Fri, 13 Nov 2020 09:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RFeIJyuMJoX5jkxaoyIf1M57XnlhipuyBs/EiEAXNDg=;
 b=Edt20aWM/GTZS0j+p4iJJG+xhPOzKGOiq/M8V1o0dubAmMdID+a6BSbtfMNYY8+x2j
 PtSKRuy+4wihXMxE97tpQoYpcGlWDoiV1VY0yq0aThkpxtEnjZZKUtLsPylK2FP2coHU
 Ygjr4amtmztLBeBOuhETkhPXhjbclQWYHD/p0dlO3pg23CcFWqNs0cm2eBP5GQR3fdRf
 ACIDw/fujzboEeohVVEwUMNUx7Cuyb/tjxPPQ43fwbmLWqe4xrfSRBitLTYNwvTBaRgQ
 t5lLQeBPuBhJKgOIcF3776IwcKkYqeSH2CuM4WhmEWOacrNjcsEbuAfqOuQYx6jH0SZc
 olzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RFeIJyuMJoX5jkxaoyIf1M57XnlhipuyBs/EiEAXNDg=;
 b=ogPQFNSqelEf4eohp6VR/cys4Qj/c2V0KDVJhdH9MSRaOiUSE5w5Saide/mfDeAyHT
 NsPrtvnLQKnbv/BBu6v3+UGGx/E4He+A30soIrmX/pruqn7F7mJiV2TLbE8rpfR62WDG
 UkGugEuNrqeRp5Lh2z5SYUnRvevXCHcgSQpD6kwo8zIxLRW7C2Z1atAn9YsEqRxIa/G4
 tGMAx0NWOx7BlU1S5HTILhQk+om/9lHIPDNiRpsn8ssSAy2XdLKoDS1m68yyCrW+CxtI
 vzAt81uDkHD9x/hplHFUxmlWb7SHtLPaINuz0WaLuzbHugZcrRFTt67ogNSMic3Cboj5
 gGsw==
X-Gm-Message-State: AOAM5337hYMJVSVXrIUoulWwVu4TvD/NE9SQduKyNHzgqdstLHFPwjDQ
 vWc/P7jlQEUi2vpE46minXSaKUb6Tljl9HLL7TQ=
X-Google-Smtp-Source: ABdhPJxmLhtueDSS0HzPw4NvpZjQwREZvykaIIaVnhzTfOWyWePuIu+wL7J6Na0KjWPp16C+fo97YAxlKYRbCuBjAMM=
X-Received: by 2002:a5d:6992:: with SMTP id g18mr4661453wru.362.1605287556673; 
 Fri, 13 Nov 2020 09:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-6-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-6-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Nov 2020 12:12:25 -0500
Message-ID: <CADnq5_MPKD-Pewn9qfnOMgHE=x34zntux=NdhoimORPtkb8zbQ@mail.gmail.com>
Subject: Re: [PATCH 05/40] drm/amd/amdgpu/amdgpu_ring: Fix misnaming of param
 'max_dw'
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

T24gRnJpLCBOb3YgMTMsIDIwMjAgYXQgODo1MCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmM6
MTY4OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdtYXhfZHcnIG5vdCBk
ZXNjcmliZWQgaW4gJ2FtZGdwdV9yaW5nX2luaXQnCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yaW5nLmM6MTY4OiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVy
ICdtYXhfbmR3JyBkZXNjcmlwdGlvbiBpbiAnYW1kZ3B1X3JpbmdfaW5pdCcKPgo+IENjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2
bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxp
ZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzog
U3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KPiBDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IENjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGluYXJvLW1tLXNpZ0BsaXN0
cy5saW5hcm8ub3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJv
Lm9yZz4KCkFwcGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmluZy5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmluZy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3JpbmcuYwo+IGluZGV4IGEyM2IyMDc5Njk2YTEuLjFhNjEyZjUxZWNkOWUgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMKPiBAQCAtMTU0LDcgKzE1NCw3
IEBAIHZvaWQgYW1kZ3B1X3JpbmdfdW5kbyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4gICAq
Cj4gICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKPiAgICogQHJpbmc6IGFtZGdwdV9y
aW5nIHN0cnVjdHVyZSBob2xkaW5nIHJpbmcgaW5mb3JtYXRpb24KPiAtICogQG1heF9uZHc6IG1h
eGltdW0gbnVtYmVyIG9mIGR3IGZvciByaW5nIGFsbG9jCj4gKyAqIEBtYXhfZHc6IG1heGltdW0g
bnVtYmVyIG9mIGR3IGZvciByaW5nIGFsbG9jCj4gICAqIEBpcnFfc3JjOiBpbnRlcnJ1cHQgc291
cmNlIHRvIHVzZSBmb3IgdGhpcyByaW5nCj4gICAqIEBpcnFfdHlwZTogaW50ZXJydXB0IHR5cGUg
dG8gdXNlIGZvciB0aGlzIHJpbmcKPiAgICogQGh3X3ByaW86IHJpbmcgcHJpb3JpdHkgKE5PUk1B
TC9ISUdIKQo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
