Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E18C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 20:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF992222E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 20:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMaZY17Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF992222E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D1456E086;
	Mon, 16 Nov 2020 20:42:36 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10B9E6E086;
 Mon, 16 Nov 2020 20:42:36 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id h2so609084wmm.0;
 Mon, 16 Nov 2020 12:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3z+NbxLCoSUpXc6qIVJmm/Cby6IwqNHb9FTQiHAyLpQ=;
 b=ZMaZY17YDp5J0FtljoLT9MOJyeYK9wI2VldyllFIjWA+feBYKFM87WUnZOQLj3BR3J
 8X8mv5IcJ9elNlTLN6HprUhcSWl1Oyc4K5leOKdfVF/zdngMzEhAAh13tju6GlLFiGMT
 5UT2sGbxEQAWkqdQiDS31uRCWgtt0USGVUc2odIlHHa6AwjBPiNBgWsFlaC30TnjOQRI
 /HwXVRM3DO4GIY6jcQiPh4BTNGdvHKNQoTRGtHbl+Z+6YTNfjyqpbxfxCSSl6ECUExTO
 BmXdK42koWVsdxugF5RKR2qqp5NSPPotc0Od8AcbD5K9lpUFvVU+MfCZAr0PuVpEAq4z
 Ypxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3z+NbxLCoSUpXc6qIVJmm/Cby6IwqNHb9FTQiHAyLpQ=;
 b=rbM9K/WEpq0Pp+wAGqsQ9OcS5KDWjZ1B459/Krukq1ZH8eScMmZrBGwuAi/Hr0JDCX
 q5RUiTdWkYjNd68ThW4j+p5pc93uzNVxvda28PNYhv+eZtbzIBAF6sd6LHA14DCcYQWL
 vXWz8BSGizYLZZf6n7tVN2S7mVCkgK8N/5AU9NMOTM81xn5tn9N2AnqWLUtVs/IbpuJ8
 gspg2FiH6gpChgSRgWsDoHSWqq7eshNN2lkOFzoY9MdXeuGkq/5KwiCjFdUxemUVRtMV
 w38f59faKGmyKXASdXkyNChuuAoDsYOrPHx2XBVdAhP32lTI6WLcVLDhpAhKXs40Lq+i
 rO4A==
X-Gm-Message-State: AOAM533b3WOiA6gT389VzPtYAYq+4Uhuee7VoHIzaukKK3/mFDPzJZy0
 KDn8wKQ2fZJmftpYXy4EsF/dTSL+CV/tWxmT5f4YkDpX
X-Google-Smtp-Source: ABdhPJzMitW7KoFSksU/zt+YNQhzbtPynx2aS+dOwmPuAI1Vbj8yIE/6ayztvfblfVaSIEsfQFY+bJuDWGnscmxiEAk=
X-Received: by 2002:a7b:c015:: with SMTP id c21mr705614wmb.79.1605559354802;
 Mon, 16 Nov 2020 12:42:34 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org>
 <20201116173700.1830487-39-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-39-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Nov 2020 15:42:23 -0500
Message-ID: <CADnq5_NdY-vbn74Qzp8X04y_eozZVFiOXwepSP2+iABRzUOTxA@mail.gmail.com>
Subject: Re: [PATCH 38/43] drm/radeon/cik: Move 'Move 'cik_sdma_*()'s
 prototypes to shared header
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
d2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npa19zZG1hLmM6MzMxOjY6
IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYY2lrX3NkbWFfZW5hYmxl4oCZ
IFstV21pc3NpbmctcHJvdG90eXBlc10KPiAgMzMxIHwgdm9pZCBjaWtfc2RtYV9lbmFibGUoc3Ry
dWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsIGJvb2wgZW5hYmxlKQo+ICB8IF5+fn5+fn5+fn5+fn5+
fgo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npa19zZG1hLmM6NTI4OjU6IHdhcm5pbmc6IG5v
IHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYY2lrX3NkbWFfcmVzdW1l4oCZIFstV21pc3Npbmct
cHJvdG90eXBlc10KPiAgNTI4IHwgaW50IGNpa19zZG1hX3Jlc3VtZShzdHJ1Y3QgcmFkZW9uX2Rl
dmljZSAqcmRldikKPiAgfCBefn5+fn5+fn5+fn5+fn4KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9jaWtfc2RtYS5jOjU1Nzo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKA
mGNpa19zZG1hX2ZpbmnigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+ICA1NTcgfCB2b2lkIGNp
a19zZG1hX2Zpbmkoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4gIHwgXn5+fn5+fn5+fn5+
fgo+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzog
IkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlk
IEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZm
d2xsLmNoPgo+IENjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgo+IENj
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4gQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwo+IENjOiBsaW5h
cm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxl
ZS5qb25lc0BsaW5hcm8ub3JnPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMgfCAzIC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL2Npay5oIHwgMyArKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWsu
YyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMKPiBpbmRleCBjZWYwZjMxMTFjZDNhLi4y
YWY3NjQ2MzkwNmFkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npay5jCj4gQEAgLTEyOSw5ICsxMjksNiBA
QCBNT0RVTEVfRklSTVdBUkUoInJhZGVvbi9tdWxsaW5zX3JsYy5iaW4iKTsKPiAgTU9EVUxFX0ZJ
Uk1XQVJFKCJyYWRlb24vbXVsbGluc19zZG1hLmJpbiIpOwo+Cj4gIHN0YXRpYyB1MzIgY2lrX2dl
dF9jdV9hY3RpdmVfYml0bWFwKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCB1MzIgc2UsIHUz
MiBzaCk7Cj4gLWV4dGVybiBpbnQgY2lrX3NkbWFfcmVzdW1lKHN0cnVjdCByYWRlb25fZGV2aWNl
ICpyZGV2KTsKPiAtZXh0ZXJuIHZvaWQgY2lrX3NkbWFfZW5hYmxlKHN0cnVjdCByYWRlb25fZGV2
aWNlICpyZGV2LCBib29sIGVuYWJsZSk7Cj4gLWV4dGVybiB2b2lkIGNpa19zZG1hX2Zpbmkoc3Ry
dWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+ICBleHRlcm4gdm9pZCB2Y2VfdjJfMF9lbmFibGVf
bWdjZyhzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwgYm9vbCBlbmFibGUpOwo+ICBzdGF0aWMg
dm9pZCBjaWtfcmxjX3N0b3Aoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+ICBzdGF0aWMg
dm9pZCBjaWtfcGNpZV9nZW4zX2VuYWJsZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmggYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL2Npay5oCj4gaW5kZXggNDIwMjA3ZDE5ZGU1Mi4uZDFiZjU0MWRhNTkyMyAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2Npay5oCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9jaWsuaAo+IEBAIC0zNCw0ICszNCw3IEBAIHZvaWQgY2lrX2luaXRfY3Bf
cGdfdGFibGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+ICB1MzIgY2lrX2dldF9jc2Jf
c2l6ZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4gIHZvaWQgY2lrX2dldF9jc2JfYnVm
ZmVyKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCB2b2xhdGlsZSB1MzIgKmJ1ZmZlcik7Cj4K
PiAraW50IGNpa19zZG1hX3Jlc3VtZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4gK3Zv
aWQgY2lrX3NkbWFfZW5hYmxlKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBib29sIGVuYWJs
ZSk7Cj4gK3ZvaWQgY2lrX3NkbWFfZmluaShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4g
ICNlbmRpZiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBfX0NJS19IX18gKi8KPiAtLQo+IDIu
MjUuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRl
dmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
