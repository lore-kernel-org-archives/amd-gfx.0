Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A649DC47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB5E61153
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB5E61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E4806E8C7;
	Mon,  7 Jun 2021 13:42:53 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2966A6E8C7;
 Mon,  7 Jun 2021 13:42:52 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id z3so18062670oib.5;
 Mon, 07 Jun 2021 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PBl1oQb0REvQQKwpKMpTQoTdXm5nunxZT4Ar8PjX/i4=;
 b=APbMb91gD1zIPIZTawQsDQLPOx+rb2op11WQRTpSn+xBFsVowr7scb7WdSPA9hWZUJ
 AC3VYMUhRCmedN6If9GhtwC5ZFepZqexOxHytKONlL57LU+YqPMVe9JDo76vt/rCiSlp
 CISlolqHTQk5Cp5lXyaOOYYWvKUziDDRZjPuNqB1kBGJAS2RsIgBk2peV+42ra2UrUtQ
 ald8PqhSl2dM3avyYWumR/QZAxFySDdVsO4oymrNMw2G3RPfo+17GEO2vynXMaY1Dbs9
 eBdxr8vFkVqYhcjNXLIaf1HuVgHtOz6qmoNKVQ0fmcBIbKGQeEXA9py239srn67H+ntB
 7yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PBl1oQb0REvQQKwpKMpTQoTdXm5nunxZT4Ar8PjX/i4=;
 b=cQfJTaMskXG09AcOaM2wERWFBpDKQ9zTCnnwKwsxglyWJxsh6SRH2lCT3Dn/80bKrq
 tJ0KsQ47qHgEugJ2pvNaLFR/r6mO+6LI7qMbE+WPBgv19eq4xl+IvZkR/953qLeeFZgN
 kF3KqdT6KQzbygU0SzMFOF9YyjAZgLimDvbW1CHuV+GG00OaKbRkoE4ut8LG6KPOxeqU
 HPW3Qx1asMCZ9o8rjMji2XDNMD0V66X5LQI8a5PljPs2/clXUZHucrbDrW8Wn1Ty95EO
 x7JiJbaaTJ4bf8VrZoBs6E5ah5YRDdq8fWUhG+zYmMhGEPZFS90IHtlJGAOCbifFP8XN
 5Mcw==
X-Gm-Message-State: AOAM533RtY9P/f3qMpUybxf0kl7D56DLXa9AIlShbVfkUcWnE2Ebktg2
 v3kn5rC7M4OfuFU5tghI3BFpatIWS3U2RbrNCdc=
X-Google-Smtp-Source: ABdhPJyJai1JHNwwk+/qjkmNo3l3kzPLjZMtG9Ot8j4cMwfxFgwzzQTR0Mg4g027PYF+cdH5DFhuKuTjlhKOBZkQvTE=
X-Received: by 2002:a05:6808:c3:: with SMTP id t3mr2097628oic.5.1623073370050; 
 Mon, 07 Jun 2021 06:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <1623068820-2479-1-git-send-email-yangtiezhu@loongson.cn>
 <0d1b517f-797f-e87d-4edd-8474b16993ed@amd.com>
In-Reply-To: <0d1b517f-797f-e87d-4edd-8474b16993ed@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Jun 2021 09:42:39 -0400
Message-ID: <CADnq5_PvZRu0h60dn-=4v0aXBOaNy=s0KjmeuSndDzU3C8qFog@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Always call radeon_suspend_kms() in
 radeon_pci_shutdown()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
 Jianmin Lv <lvjianmin@loongson.cn>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBKdW4gNywgMjAyMSBhdCA4OjMwIEFNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAwNy4wNi4yMSB1bSAxNDoyNyBzY2hyaWVi
IFRpZXpodSBZYW5nOgo+ID4gcmFkZW9uX3N1c3BlbmRfa21zKCkgcHV0cyB0aGUgaHcgaW4gdGhl
IHN1c3BlbmQgc3RhdGUgKGFsbCBhc2ljcyksCj4gPiBpdCBzaG91bGQgYWx3YXlzIGNhbGwgcmFk
ZW9uX3N1c3BlbmRfa21zKCkgaW4gcmFkZW9uX3BjaV9zaHV0ZG93bigpLAo+ID4gdGhpcyBpcyBh
IG5vcm1hbCBjbGVhbnVwIHByb2Nlc3MgdG8gYXZvaWQgbW9yZSBvcGVyYXRpb25zIG9uIHJhZGVv
biwKPiA+IGp1c3QgcmVtb3ZlICNpZmRlZiBDT05GSUdfUFBDNjQgYW5kIHRoZSByZWxhdGVkIGNv
bW1lbnRzLgo+Cj4gV2VsbCBOQUsuCj4KPiBBbGV4IGtub3dzIG1vcmUgYWJvdXQgdGhlIGRldGFp
bHMgYnV0IHN1c3BlbmRpbmcgc2hvdWxkIG5vdCBiZSBwYXJ0IG9mCj4gdGhlIHBjaSBzaG90ZG93
biBwcm9jZXNzIGF0IGFsbC4KPgo+IFdlIGp1c3QgYWRkIHRoYXQgaGVyZSB0byBlbmZvcmNlIGEg
R1BVIHJlc2V0IG9uIFBQQzY0IGJvYXJkcyBmb3Igc29tZQo+IHJlYXNvbi4KCkV2ZXJ5dGhpbmcg
aW4gdGhlIGNvbW1lbnQgc3RpbGwgYXBwbGllcy4KCkFsZXgKCj4KPiBSZWdhcmRzLAo+IENocmlz
dGlhbi4KPgo+ID4KPiA+IENvLWRldmVsb3BlZC1ieTogSmlhbm1pbiBMdiA8bHZqaWFubWluQGxv
b25nc29uLmNuPgo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbm1pbiBMdiA8bHZqaWFubWluQGxvb25n
c29uLmNuPgo+ID4gU2lnbmVkLW9mZi1ieTogVGllemh1IFlhbmcgPHlhbmd0aWV6aHVAbG9vbmdz
b24uY24+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMg
fCA5IC0tLS0tLS0tLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgOSBkZWxldGlvbnMoLSkKPiA+Cj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMgYi9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYwo+ID4gaW5kZXggZWZlYjExNS4uMGIxZjQz
ZCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYwo+ID4gQEAgLTM4Niwx
NiArMzg2LDcgQEAgcmFkZW9uX3BjaV9zaHV0ZG93bihzdHJ1Y3QgcGNpX2RldiAqcGRldikKPiA+
ICAgICAgIGlmIChyYWRlb25fZGV2aWNlX2lzX3ZpcnR1YWwoKSkKPiA+ICAgICAgICAgICAgICAg
cmFkZW9uX3BjaV9yZW1vdmUocGRldik7Cj4gPgo+ID4gLSNpZmRlZiBDT05GSUdfUFBDNjQKPiA+
IC0gICAgIC8qCj4gPiAtICAgICAgKiBTb21lIGFkYXB0ZXJzIG5lZWQgdG8gYmUgc3VzcGVuZGVk
IGJlZm9yZSBhCj4gPiAtICAgICAgKiBzaHV0ZG93biBvY2N1cnMgaW4gb3JkZXIgdG8gcHJldmVu
dCBhbiBlcnJvcgo+ID4gLSAgICAgICogZHVyaW5nIGtleGVjLgo+ID4gLSAgICAgICogTWFrZSB0
aGlzIHBvd2VyIHNwZWNpZmljIGJlY2F1YXNlIGl0IGJyZWFrcwo+ID4gLSAgICAgICogc29tZSBu
b24tcG93ZXIgYm9hcmRzLgo+ID4gLSAgICAgICovCj4gPiAgICAgICByYWRlb25fc3VzcGVuZF9r
bXMocGNpX2dldF9kcnZkYXRhKHBkZXYpLCB0cnVlLCB0cnVlLCBmYWxzZSk7Cj4gPiAtI2VuZGlm
Cj4gPiAgIH0KPiA+Cj4gPiAgIHN0YXRpYyBpbnQgcmFkZW9uX3Btb3BzX3N1c3BlbmQoc3RydWN0
IGRldmljZSAqZGV2KQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
