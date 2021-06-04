Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAA3C4743C
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 17:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2B66140F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 17:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2B66140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D2A6F629;
	Fri,  4 Jun 2021 17:19:30 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C82C56F629;
 Fri,  4 Jun 2021 17:19:28 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 q20-20020a4a6c140000b029024915d1bd7cso745551ooc.12; 
 Fri, 04 Jun 2021 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LOI6wvAzaGYd8kqemXzTNGyTEREL1+gKJT9TY9+po4w=;
 b=PMcm+m0QV24OruZ57oXcb0P09vCXAE854+eIezs8Cw/sfSmzAtpUDumAIIYi+cUcI+
 IEWQtAH9uMev8my+b3douUqO5tOzJVqEXv/uQHkXsuCDoqNT7NbDayA7+JkWhNydGnYw
 uMFh5/Ivcz2xP9/w+8Q40almV/q9QgS8hl628EfbQ3z8YVD5iLbodf9zhUEKpJgSHXz2
 8DoFf/hMk9QvMJoHC5l5GT2G8iYcDjejZ7ovMsFl0GHQUWgABYC1zXy8fKWUS4qs6p7p
 x5ilIm9KjCG6US2OZR/9auwGnom2efnTN3kmV482IcSJmVf8+hxI6kOBEymNjj993xjw
 wu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LOI6wvAzaGYd8kqemXzTNGyTEREL1+gKJT9TY9+po4w=;
 b=JTozIZrPq8/8fj4YIXe12r0VtYXPhhbMeh4P5QvC0ARtVvd6oczFnun5n0i+arCxd9
 E4uCblK/GpQXQyfiDcJUSenpgEDFiBsTOz93Hk/5zVIV5yJdG7alz7+zZPLqtIdHsgyn
 eEYuAOSxNqe821HkXxYEoejWBqB1MRyZ0ok9Ke7X5h+6RM2dyrFim0wQZ4WxczCOmT0j
 hWtYUH+Zo6stsx4uWB/Po2u/oTHAE5Lh4hmRl8uJ0vJ9BEA2GggJovnM3JIb/NNlIfJI
 UQDMJpgwIGfkTNgT00lZXk3ppaM6146JpQJYyatIfa7XgrHJqNcm2u2MDcsvz7BzV4to
 w1Vw==
X-Gm-Message-State: AOAM533MD5LqugajD4TP1mp6ukhCF2gI66nOW6orHr1PY6HtqR0TiliR
 DozrT2SpJF60Sg/9AvC/uCaQ8lqSz3bjgE/y5z8=
X-Google-Smtp-Source: ABdhPJybHagCp5avGzAYCedTNRzoZD7xTPDNemYCX6J7vz75/ba1WW5jrhOpgCd+WTXOur81Mdd2tG+fUa4gkeWfjHs=
X-Received: by 2002:a4a:8c09:: with SMTP id u9mr4402516ooj.72.1622827168120;
 Fri, 04 Jun 2021 10:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <87o8cnfr3s.wl-chenli@uniontech.com>
 <87im2ufhyz.wl-chenli@uniontech.com>
 <0689a006-a0a2-698a-12d8-cb11156e469a@gmail.com>
 <877djacbfx.wl-chenli@uniontech.com>
 <c4941cb6-8c40-aad1-e61a-2786ba1ab225@gmail.com>
 <871r9ic9a7.wl-chenli@uniontech.com>
In-Reply-To: <871r9ic9a7.wl-chenli@uniontech.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Jun 2021 13:19:17 -0400
Message-ID: <CADnq5_ODqHuBxXQJfmxvG1sJpf6pQfhGvNnEXWbC+Lav4cexgw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] radeon: fix coding issues reported from sparse
To: Chen Li <chenli@uniontech.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIEZyaSwgSnVuIDQsIDIwMjEgYXQgNzo1MyBBTSBD
aGVuIExpIDxjaGVubGlAdW5pb250ZWNoLmNvbT4gd3JvdGU6Cj4KPgo+IEFsc28gZml4IHNvbWUg
Y29kaW5nIGlzc3VlcyByZXBvcnRlZCBmcm9tIHNwYXJzZS4KPgo+IFNpZ25lZC1vZmYtYnk6IENo
ZW4gTGkgPGNoZW5saUB1bmlvbnRlY2guY29tPgo+IEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vcmFkZW9uX3V2ZC5jIHwgMjQgKysrKysrKysrKysrKy0tLS0tLS0tLS0tCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl91dmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX3V2ZC5jCj4gaW5kZXggZGZhOWZkYmU5OGRhLi44NWExZjJjMzE3NDkgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdXZkLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl91dmQuYwo+IEBAIC0xNTIsOSArMTUyLDExIEBA
IGludCByYWRlb25fdXZkX2luaXQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4KPiAgICAg
ICAgICAgICAgICAgICAgICAgICByZGV2LT51dmQuZndfaGVhZGVyX3ByZXNlbnQgPSB0cnVlOwo+
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgZmFtaWx5X2lkID0gbGUzMl90b19jcHUoaGRyLT51
Y29kZV92ZXJzaW9uKSAmIDB4ZmY7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgdmVyc2lvbl9t
YWpvciA9IChsZTMyX3RvX2NwdShoZHItPnVjb2RlX3ZlcnNpb24pID4+IDI0KSAmIDB4ZmY7Cj4g
LSAgICAgICAgICAgICAgICAgICAgICAgdmVyc2lvbl9taW5vciA9IChsZTMyX3RvX2NwdShoZHIt
PnVjb2RlX3ZlcnNpb24pID4+IDgpICYgMHhmZjsKPiArICAgICAgICAgICAgICAgICAgICAgICBm
YW1pbHlfaWQgPSAoX19mb3JjZSB1MzIpKGhkci0+dWNvZGVfdmVyc2lvbikgJiAweGZmOwo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHZlcnNpb25fbWFqb3IgPSAobGUzMl90b19jcHUoKF9fZm9y
Y2UgX19sZTMyKShoZHItPnVjb2RlX3ZlcnNpb24pKQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID4+IDI0KSAmIDB4ZmY7Cj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgdmVyc2lvbl9taW5vciA9IChsZTMyX3RvX2NwdSgoX19mb3JjZSBf
X2xlMzIpKGhkci0+dWNvZGVfdmVyc2lvbikpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPj4gOCkgJiAweGZmOwo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIERSTV9JTkZPKCJGb3VuZCBVVkQgZmlybXdhcmUgVmVyc2lvbjogJXUuJXUg
RmFtaWx5IElEOiAldVxuIiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2ZXJz
aW9uX21ham9yLCB2ZXJzaW9uX21pbm9yLCBmYW1pbHlfaWQpOwo+Cj4gQEAgLTc5MSwxNyArNzkz
LDE3IEBAIGludCByYWRlb25fdXZkX2dldF9jcmVhdGVfbXNnKHN0cnVjdCByYWRlb25fZGV2aWNl
ICpyZGV2LCBpbnQgcmluZywKPiAgICAgICAgICAgICAgICAgcmV0dXJuIHI7Cj4KPiAgICAgICAg
IC8qIHN0aXRjaCB0b2dldGhlciBhbiBVVkQgY3JlYXRlIG1zZyAqLwo+IC0gICAgICAgd3JpdGVs
KGNwdV90b19sZTMyKDB4MDAwMDBkZTQpLCAmbXNnWzBdKTsKPiArICAgICAgIHdyaXRlbCgoX19m
b3JjZSB1MzIpY3B1X3RvX2xlMzIoMHgwMDAwMGRlNCksICZtc2dbMF0pOwo+ICAgICAgICAgd3Jp
dGVsKDB4MCwgKHZvaWQgX19pb21lbSAqKSZtc2dbMV0pOwo+IC0gICAgICAgd3JpdGVsKGNwdV90
b19sZTMyKGhhbmRsZSksICZtc2dbMl0pOwo+ICsgICAgICAgd3JpdGVsKChfX2ZvcmNlIHUzMilj
cHVfdG9fbGUzMihoYW5kbGUpLCAmbXNnWzJdKTsKPiAgICAgICAgIHdyaXRlbCgweDAsICZtc2db
M10pOwo+ICAgICAgICAgd3JpdGVsKDB4MCwgJm1zZ1s0XSk7Cj4gICAgICAgICB3cml0ZWwoMHgw
LCAmbXNnWzVdKTsKPiAgICAgICAgIHdyaXRlbCgweDAsICZtc2dbNl0pOwo+IC0gICAgICAgd3Jp
dGVsKGNwdV90b19sZTMyKDB4MDAwMDA3ODApLCAmbXNnWzddKTsKPiAtICAgICAgIHdyaXRlbChj
cHVfdG9fbGUzMigweDAwMDAwNDQwKSwgJm1zZ1s4XSk7Cj4gKyAgICAgICB3cml0ZWwoKF9fZm9y
Y2UgdTMyKWNwdV90b19sZTMyKDB4MDAwMDA3ODApLCAmbXNnWzddKTsKPiArICAgICAgIHdyaXRl
bCgoX19mb3JjZSB1MzIpY3B1X3RvX2xlMzIoMHgwMDAwMDQ0MCksICZtc2dbOF0pOwo+ICAgICAg
ICAgd3JpdGVsKDB4MCwgJm1zZ1s5XSk7Cj4gLSAgICAgICB3cml0ZWwoY3B1X3RvX2xlMzIoMHgw
MWIzNzAwMCksICZtc2dbMTBdKTsKPiArICAgICAgIHdyaXRlbCgoX19mb3JjZSB1MzIpY3B1X3Rv
X2xlMzIoMHgwMWIzNzAwMCksICZtc2dbMTBdKTsKPiAgICAgICAgIGZvciAoaSA9IDExOyBpIDwg
MTAyNDsgKytpKQo+ICAgICAgICAgICAgICAgICB3cml0ZWwoMHgwLCAmbXNnW2ldKTsKPgo+IEBA
IC04MjcsOSArODI5LDkgQEAgaW50IHJhZGVvbl91dmRfZ2V0X2Rlc3Ryb3lfbXNnKHN0cnVjdCBy
YWRlb25fZGV2aWNlICpyZGV2LCBpbnQgcmluZywKPiAgICAgICAgICAgICAgICAgcmV0dXJuIHI7
Cj4KPiAgICAgICAgIC8qIHN0aXRjaCB0b2dldGhlciBhbiBVVkQgZGVzdHJveSBtc2cgKi8KPiAt
ICAgICAgIHdyaXRlbChjcHVfdG9fbGUzMigweDAwMDAwZGU0KSwgJm1zZ1swXSk7Cj4gLSAgICAg
ICB3cml0ZWwoY3B1X3RvX2xlMzIoMHgwMDAwMDAwMiksICZtc2dbMV0pOwo+IC0gICAgICAgd3Jp
dGVsKGNwdV90b19sZTMyKGhhbmRsZSksICZtc2dbMl0pOwo+ICsgICAgICAgd3JpdGVsKChfX2Zv
cmNlIHUzMiljcHVfdG9fbGUzMigweDAwMDAwZGU0KSwgJm1zZ1swXSk7Cj4gKyAgICAgICB3cml0
ZWwoKF9fZm9yY2UgdTMyKWNwdV90b19sZTMyKDB4MDAwMDAwMDIpLCAmbXNnWzFdKTsKPiArICAg
ICAgIHdyaXRlbCgoX19mb3JjZSB1MzIpY3B1X3RvX2xlMzIoaGFuZGxlKSwgJm1zZ1syXSk7Cj4g
ICAgICAgICB3cml0ZWwoMHgwLCAmbXNnWzNdKTsKPiAgICAgICAgIGZvciAoaSA9IDQ7IGkgPCAx
MDI0OyArK2kpCj4gICAgICAgICAgICAgICAgIHdyaXRlbCgweDAsICZtc2dbaV0pOwo+IC0tCj4g
Mi4zMS4xCj4KPgo+Cj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
