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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EB7C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5F8207D3
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4UHeYWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5F8207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1396E0FC;
	Mon, 16 Nov 2020 19:52:05 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 722536E0FC;
 Mon, 16 Nov 2020 19:52:05 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id d142so456240wmd.4;
 Mon, 16 Nov 2020 11:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wq29JeznquOyMiGvYv3bv2rp5DdAOeORT9zJBFrcDzc=;
 b=h4UHeYWxxgV39h+GY6It7+5vDavyNtIH/Tf3nWBMfQJoX9kjZv4ZMfLujxIFDE9sFl
 RLwBGhj7rWayHSZHqH23Twl51t6FTHqSCWCEyDbdQiQ79Lm7tVAGqhilZSdIHPH4mFUF
 FMB9B7KFZsEa+g4Xo452UaNSovPYrJor+KwQgSsKwVnjqfCZ8tSgPxhtZfGhE4hESllc
 +uDoThQ7W2+vIvxGblYChCjxw35MTVt3u0uH/GTfdvmvMglh1WKu2CsjpShtTjf9L1lc
 d02zeJtLBnisokfSfkP8FratED2MnRTlk5h+47lRGp18houuio/QXgTX0LtEYCVM2+/5
 JmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wq29JeznquOyMiGvYv3bv2rp5DdAOeORT9zJBFrcDzc=;
 b=RZlDKlNfllWbWHLuFpB4Uq0SHjhzWkd4MoP4dR937Rrzoqoi3s4Xty3VibtJ/uatdA
 pR7oeAjxGxyNvByvcR5p/8jhVmiSUcnrZd0DZpW1TknyBwVW4zLRhILst5X/kebsO2xG
 htTejXm44s9ypeW5qxpcYRUyrtQNSCK4CtJBkD5obGcrooSNsdDRuieJgVXU8FpXwQlg
 b5OjR9Cq8Cm35aZSmJfpXgag4ENE3bKjylB12msu5yoc/fZ7eQOXnKNoa3Yy+bhd+bgp
 M2l5PlT8i010wjD/ljnBJrK/UBDwa+70pA2rq2+azNXGNvHZrxxRreV4yNDDuh82sN0B
 zAXw==
X-Gm-Message-State: AOAM532o8kOtNJrEQZh+/lJEut/fm50fQeZsMQsgzx4Mg7DnIr/B3+dH
 +FBuONzh61rg/fgfb+gYVCtSH6+L21KSrioFsd8=
X-Google-Smtp-Source: ABdhPJw3tjYa83/wDbt2LS1fpb/1ZTFVzVcFetg5Q3cXdirmWmVFjH+Iw4aXSbXGrXQS8TVlZstodoUlIS4q3iDeZ7s=
X-Received: by 2002:a7b:c015:: with SMTP id c21mr526817wmb.79.1605556324212;
 Mon, 16 Nov 2020 11:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org>
 <20201116173700.1830487-14-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-14-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Nov 2020 14:51:53 -0500
Message-ID: <CADnq5_OMb3ZEUzUUJy1_joxQGCcuALGLW+E-EXPAPFhUP9h95A@mail.gmail.com>
Subject: Re: [PATCH 13/43] drm/radeon/radeon_drv: Move 'radeon_mmap()'s
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Gareth Hughes <gareth@valinux.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTI6MzcgUE0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGlu
YXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQg
d2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYzo5MzE6
NTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhyYWRlb25fbW1hcOKAmSBb
LVdtaXNzaW5nLXByb3RvdHlwZXNdCj4gIDkzMSB8IGludCByYWRlb25fbW1hcChzdHJ1Y3QgZmls
ZSAqZmlscCwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpCj4gIHwgXn5+fn5+fn5+fn4KPgo+
IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJp
c3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJs
aWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5j
aD4KPiBDYzogR2FyZXRoIEh1Z2hlcyA8Z2FyZXRoQHZhbGludXguY29tPgo+IENjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFw
cGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9kcnYuYyB8IDIgKy0KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmgg
fCAxICsKPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jCj4gaW5kZXggNTM2YjI0NmI5YTZhYS4u
MmI5ZGVhZWFkOTliMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9kcnYuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jCj4gQEAg
LTUxLDYgKzUxLDcgQEAKPiAgI2luY2x1ZGUgPGRybS9yYWRlb25fZHJtLmg+Cj4KPiAgI2luY2x1
ZGUgInJhZGVvbl9kcnYuaCIKPiArI2luY2x1ZGUgInJhZGVvbl90dG0uaCIKPiAgI2luY2x1ZGUg
InJhZGVvbi5oIgo+ICAjaW5jbHVkZSAicmFkZW9uX2RldmljZS5oIgo+Cj4gQEAgLTEyNSw3ICsx
MjYsNiBAQCBleHRlcm4gaW50IHJhZGVvbl9nZXRfY3J0Y19zY2Fub3V0cG9zKHN0cnVjdCBkcm1f
ZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBjcnRjLAo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAga3RpbWVfdCAqc3RpbWUsIGt0aW1lX3QgKmV0aW1lLAo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IGRybV9kaXNwbGF5X21v
ZGUgKm1vZGUpOwo+ICBleHRlcm4gYm9vbCByYWRlb25faXNfcHgoc3RydWN0IGRybV9kZXZpY2Ug
KmRldik7Cj4gLWludCByYWRlb25fbW1hcChzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0IHZtX2Fy
ZWFfc3RydWN0ICp2bWEpOwo+ICBpbnQgcmFkZW9uX21vZGVfZHVtYl9tbWFwKHN0cnVjdCBkcm1f
ZmlsZSAqZmlscCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkcm1fZGV2aWNl
ICpkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBoYW5kbGUsIHVpbnQ2
NF90ICpvZmZzZXRfcCk7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX3R0bS5oIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmgKPiBpbmRleCA5
MWVhNzE0MWJjODEyLi40ZDdiOTBlZTI3NzQwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX3R0bS5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b25fdHRtLmgKPiBAQCAtMzIsNSArMzIsNiBAQCBzdHJ1Y3QgcmFkZW9uX2RldmljZTsKPgo+ICBp
bnQgcmFkZW9uX3R0bV9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKPiAgdm9pZCBy
YWRlb25fdHRtX2Zpbmkoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+ICtpbnQgcmFkZW9u
X21tYXAoc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKTsKPgo+
ICAjZW5kaWYgICAgICAgICAgICAgICAgICAgICAgICAgLyogX19SQURFT05fVFRNX0hfXyAqLwo+
IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
