Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1A5C4742C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 23:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79879207BB
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 23:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm1sEfqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79879207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D063789309;
	Tue, 10 Nov 2020 23:39:29 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36EA89309;
 Tue, 10 Nov 2020 23:39:28 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id s13so113873wmh.4;
 Tue, 10 Nov 2020 15:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Oa+daeAHvU7lx4HkTlbwWSIAvlJdskhvUZxjOQcUKOc=;
 b=hm1sEfqdhE16MOfMABfPzeqG08HhBj+NySg9eIIoL9Y+sR/Aga2X5eNZmScIkbWHIc
 EDirkv28y3IqIsEgbUuEoSxIVkRHqIMLvIIvMbCmlfHRi3mTQaN+ftbO4V++3ai9zita
 Xe8qau8NnV4dtoR4VCbZ5L0qUHgcOgm7chWkseoCW/OX/9TfWUs2zvL76CRs1fk3eyCS
 RvCOZw9uDmcJOONRchZHvM61cY0PXBxo9NwOn53itB3dWESXzvA3IKj9E0N8i+D710+Q
 l8OKcH9Q4W/EspcokrkGNgCx/j3C9vnxs54vI0ansEw85DOEd6qEnpqIaC+iWF8Uq7Lf
 tNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Oa+daeAHvU7lx4HkTlbwWSIAvlJdskhvUZxjOQcUKOc=;
 b=sHvV7xeYx7or8BBEyDagkZhXKWWjZIlhtRkOB7vXGPvNuAaZE87HrUQZzlhlvKj0eq
 JSKYjLu2kfMuyNBESpp37GJM8dChGv63ar8SK47fCqw06rIpEATZfDOS6ZiXBvQrzR0n
 ZtaWsCFGERVLBRmmA720sYln2cliIvotich3mJpGkZyBojvbhkbKatm5lDYE5wGDBefQ
 9e4ZqTDEFnrBcTBtstRm8d7G9642ECs6j05o/NfNXLI9cakfzpKOfjgAZo2m+YMYW/wo
 o21AiwGIjrtRdf14mqZI99xpf3eFRkYRg8Wd0YAubG1RNOWwZDumXAildcw6FS4vncpI
 4MwA==
X-Gm-Message-State: AOAM530FaMRk3H+o/QXEiTj6TWaLMcQILu9Ods7HCKnHqiiV/n+vQ3Ev
 teowDBLM7RAI/qDHI6v3q9sdcI4ffcUX7y5Nh4s=
X-Google-Smtp-Source: ABdhPJwzEw/Wodrp6vyXGUSvvtFFmUb/vCnQbEIr+yuMmEMcA383NLbMqjtrMf4QsfVrr1215aWyaM1imHBur/TbzJ8=
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr544247wmd.73.1605051567472; 
 Tue, 10 Nov 2020 15:39:27 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org>
 <20201110193112.988999-13-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-13-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2020 18:39:16 -0500
Message-ID: <CADnq5_N=SoFU=pAB-Wye8x1LkLm4ZYcKvag7Sh9NvK2LRc5eKA@mail.gmail.com>
Subject: Re: [PATCH 12/30] drm/radeon/radeon_dp_mst: Remove unused variable
 'ret' from radeon_mst_encoder_dpms()
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

T24gVHVlLCBOb3YgMTAsIDIwMjAgYXQgMjozMSBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2RwX21zdC5jOiBJ
biBmdW5jdGlvbiDigJhyYWRlb25fbXN0X2VuY29kZXJfZHBtc+KAmToKPiAgZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fZHBfbXN0LmM6MzY2OjY6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmHJl
dOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQo+Cj4gQ2M6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlh
biBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8
YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+
IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGlu
YXJvLm9yZz4KCkFwcGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9kcF9tc3QuYyB8IDE2ICsrKysrKysrLS0tLS0tLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcF9tc3QuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX2RwX21zdC5jCj4gaW5kZXggMDA4MzA4NzgwNDQzYy4uMmMzMjE4NmM0
YWNkOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcF9tc3Qu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2RwX21zdC5jCj4gQEAgLTM2
Myw3ICszNjMsNyBAQCByYWRlb25fbXN0X2VuY29kZXJfZHBtcyhzdHJ1Y3QgZHJtX2VuY29kZXIg
KmVuY29kZXIsIGludCBtb2RlKQo+ICAgICAgICAgc3RydWN0IHJhZGVvbl9jb25uZWN0b3IgKnJh
ZGVvbl9jb25uZWN0b3I7Cj4gICAgICAgICBzdHJ1Y3QgZHJtX2NydGMgKmNydGM7Cj4gICAgICAg
ICBzdHJ1Y3QgcmFkZW9uX2NydGMgKnJhZGVvbl9jcnRjOwo+IC0gICAgICAgaW50IHJldCwgc2xv
dHM7Cj4gKyAgICAgICBpbnQgc2xvdHM7Cj4gICAgICAgICBzNjQgZml4ZWRfcGJuLCBmaXhlZF9w
Ym5fcGVyX3Nsb3QsIGF2Z190aW1lX3Nsb3RzX3Blcl9tdHA7Cj4gICAgICAgICBpZiAoIUFTSUNf
SVNfRENFNShyZGV2KSkgewo+ICAgICAgICAgICAgICAgICBEUk1fRVJST1IoImdvdCBtc3QgZHBt
cyBvbiBub24tRENFNVxuIik7Cj4gQEAgLTQxOCwxMCArNDE4LDEwIEBAIHJhZGVvbl9tc3RfZW5j
b2Rlcl9kcG1zKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlciwgaW50IG1vZGUpCj4KPiAgICAg
ICAgICAgICAgICAgc2xvdHMgPSBkcm1fZHBfZmluZF92Y3BpX3Nsb3RzKCZyYWRlb25fY29ubmVj
dG9yLT5tc3RfcG9ydC0+bXN0X21nciwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG1zdF9lbmMtPnBibik7Cj4gLSAgICAgICAgICAgICAgIHJldCA9IGRy
bV9kcF9tc3RfYWxsb2NhdGVfdmNwaSgmcmFkZW9uX2Nvbm5lY3Rvci0+bXN0X3BvcnQtPm1zdF9t
Z3IsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByYWRl
b25fY29ubmVjdG9yLT5wb3J0LAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbXN0X2VuYy0+cGJuLCBzbG90cyk7Cj4gLSAgICAgICAgICAgICAgIHJldCA9
IGRybV9kcF91cGRhdGVfcGF5bG9hZF9wYXJ0MSgmcmFkZW9uX2Nvbm5lY3Rvci0+bXN0X3BvcnQt
Pm1zdF9tZ3IpOwo+ICsgICAgICAgICAgICAgICBkcm1fZHBfbXN0X2FsbG9jYXRlX3ZjcGkoJnJh
ZGVvbl9jb25uZWN0b3ItPm1zdF9wb3J0LT5tc3RfbWdyLAo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmFkZW9uX2Nvbm5lY3Rvci0+cG9ydCwKPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zdF9lbmMtPnBibiwgc2xvdHMpOwo+ICsg
ICAgICAgICAgICAgICBkcm1fZHBfdXBkYXRlX3BheWxvYWRfcGFydDEoJnJhZGVvbl9jb25uZWN0
b3ItPm1zdF9wb3J0LT5tc3RfbWdyKTsKPgo+ICAgICAgICAgICAgICAgICByYWRlb25fZHBfbXN0
X3NldF9iZV9jbnRsKHByaW1hcnksIG1zdF9lbmMsCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmFkZW9uX2Nvbm5lY3Rvci0+bXN0X3BvcnQtPmhwZC5ocGQsIHRy
dWUpOwo+IEBAIC00MzYsOSArNDM2LDkgQEAgcmFkZW9uX21zdF9lbmNvZGVyX2RwbXMoc3RydWN0
IGRybV9lbmNvZGVyICplbmNvZGVyLCBpbnQgbW9kZSkKPgo+ICAgICAgICAgICAgICAgICBhdG9t
Ymlvc19kaWdfZW5jb2Rlcl9zZXR1cDIoJnByaW1hcnktPmJhc2UsIEFUT01fRU5DT0RFUl9DTURf
RFBfVklERU9fT04sIDAsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBtc3RfZW5jLT5mZSk7Cj4gLSAgICAgICAgICAgICAgIHJldCA9IGRybV9kcF9jaGVja19h
Y3Rfc3RhdHVzKCZyYWRlb25fY29ubmVjdG9yLT5tc3RfcG9ydC0+bXN0X21ncik7Cj4gKyAgICAg
ICAgICAgICAgIGRybV9kcF9jaGVja19hY3Rfc3RhdHVzKCZyYWRlb25fY29ubmVjdG9yLT5tc3Rf
cG9ydC0+bXN0X21ncik7Cj4KPiAtICAgICAgICAgICAgICAgcmV0ID0gZHJtX2RwX3VwZGF0ZV9w
YXlsb2FkX3BhcnQyKCZyYWRlb25fY29ubmVjdG9yLT5tc3RfcG9ydC0+bXN0X21ncik7Cj4gKyAg
ICAgICAgICAgICAgIGRybV9kcF91cGRhdGVfcGF5bG9hZF9wYXJ0MigmcmFkZW9uX2Nvbm5lY3Rv
ci0+bXN0X3BvcnQtPm1zdF9tZ3IpOwo+Cj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+ICAgICAg
ICAgY2FzZSBEUk1fTU9ERV9EUE1TX1NUQU5EQlk6Cj4gQEAgLTQ1MCw3ICs0NTAsNyBAQCByYWRl
b25fbXN0X2VuY29kZXJfZHBtcyhzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIsIGludCBtb2Rl
KQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybjsKPgo+ICAgICAgICAgICAgICAgICBk
cm1fZHBfbXN0X3Jlc2V0X3ZjcGlfc2xvdHMoJnJhZGVvbl9jb25uZWN0b3ItPm1zdF9wb3J0LT5t
c3RfbWdyLCBtc3RfZW5jLT5wb3J0KTsKPiAtICAgICAgICAgICAgICAgcmV0ID0gZHJtX2RwX3Vw
ZGF0ZV9wYXlsb2FkX3BhcnQxKCZyYWRlb25fY29ubmVjdG9yLT5tc3RfcG9ydC0+bXN0X21ncik7
Cj4gKyAgICAgICAgICAgICAgIGRybV9kcF91cGRhdGVfcGF5bG9hZF9wYXJ0MSgmcmFkZW9uX2Nv
bm5lY3Rvci0+bXN0X3BvcnQtPm1zdF9tZ3IpOwo+Cj4gICAgICAgICAgICAgICAgIGRybV9kcF9j
aGVja19hY3Rfc3RhdHVzKCZyYWRlb25fY29ubmVjdG9yLT5tc3RfcG9ydC0+bXN0X21ncik7Cj4g
ICAgICAgICAgICAgICAgIC8qIGFuZCB0aGlzIGNhbiBhbHNvIGZhaWwgKi8KPiAtLQo+IDIuMjUu
MQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBk
cmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
