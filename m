Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A1BC433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 15:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A2660240
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 15:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A2660240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34D86E14B;
	Wed,  3 Mar 2021 15:00:27 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A336E14B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 15:00:27 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id f3so26219660oiw.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Mar 2021 07:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nPxkYENrmp3S595cftf1oVhnAEsbD/2w7/hxN/Ls784=;
 b=R03Q7ZipsA+KhwnDq3f6KIDMtpVz5gAWuwcEhJbyZipZoPFo5hzTVcC60CmJZ+8fGC
 dE0VuxvNFc5ylW5qk6yvu86YJqwUL8Zg8Xb0e5GjHPlnJC91eRN1DiSViO3jbS933fxs
 VbjxC3padvYEAltdAa7an7Hc8MYt1yYacBmQMMQ7+K7RAdfA/dC/0wIeH22N5lii1Hu5
 5v1at2Gdk3yLDqj5hgFfLh2ONtLwcEUFVm7ssDMixqXwxvgl2A2CKGytdz57tI3EppNh
 JxjrOlH5rzUSWsybCKYK5ARFmHN/dqGz5NBIe5sdILC/ac/KHsdT8JoIKt1Lg0ptaZTX
 co5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nPxkYENrmp3S595cftf1oVhnAEsbD/2w7/hxN/Ls784=;
 b=Bo8SGRC8vQxFelODithM5g6X91aCkiNcTS7KwAj7+pYWJMFRfY/dNziNwrVE9wM8je
 RE05h9xQKq6bES6nRW0/QGZwWYO6UzR0lLpAf6H9fZd67+YvupDHy7aXKFxBewAqNxaS
 oV9YEh9wNH7rRixCmbcOfmLNNuNHfbA0W/FbNYE9ybGI7rBgpC/yuC+LLlF+stvF7mIP
 guk0j1bad+oUJ4oxZQ8TwvtPe89VpG6IHD0dHHVb22ggGIOu4Rb2W/JlWzw/m06JfLU9
 mGg/AhqCn1Uk0FAv0jqTOTm9xqKQI3EFpgva0rjmrfsyhcUWmMgZMd/JKWJ006Sb/i7z
 dDyA==
X-Gm-Message-State: AOAM530NMi8UJBqFuIe3mXWy86QvA1si6xu+Cr5chWGdmBLXAGL1NydY
 VUfHeQO6q8olLYd8lCxw53O8orSSMmvE19T+jjk=
X-Google-Smtp-Source: ABdhPJz4LowNeteUt02+YNRhHrdbEkCUgz3mIQybKa+gEMQJtyS2y8fpC44p4pqmZabWcN86uE+N2Ccl0vMu+lx6IAA=
X-Received: by 2002:aca:f485:: with SMTP id s127mr7590071oih.120.1614783626528; 
 Wed, 03 Mar 2021 07:00:26 -0800 (PST)
MIME-Version: 1.0
References: <87v9a8lwvl.wl-chenli@uniontech.com>
 <9314f840-57db-2e2e-c186-c4a3566fdb5b@amd.com>
In-Reply-To: <9314f840-57db-2e2e-c186-c4a3566fdb5b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Mar 2021 10:00:15 -0500
Message-ID: <CADnq5_O4oJPWOq9x9miH=oCibS-ygqTKatPe5ttSiNh=Kqmpnw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Use kvmalloc_array for radeon and amdgpu CS chunks
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Chen Li <chenli@uniontech.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFdlZCwgTWFyIDMsIDIwMjEgYXQgNjozMCBBTSBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IHdyb3RlOgo+Cj4gUmV2
aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9y
IHRoZSBlbnRpcmUKPiBzZXJpZXMuCj4KPiBBbSAwMy4wMy4yMSB1bSAwNDo0OSBzY2hyaWViIENo
ZW4gTGk6Cj4gPiBXaGVuIHRlc3Rpbmcga2VybmVsIHdpdGggdHJpbml0eSwgdGhlIGtlcm5lbCB0
dXJuZWQgdG8gdGFpbnRlZCBpbiB0aGF0IHJhZGVvbiBDUyByZXF1aXJlIGxhcmdlIG1lbW9yeSBh
bmQgb3JkZXIgaXMgb3ZlciBNQVhfT1JERVIuCj4gPgo+ID4ga3ZtYWxsb2Mva3ZtYWxsb2NfYXJy
YXkgc2hvdWxkIGJlIHVzZWQgaGVyZSBpbiB0aGF0IGl0IHdpbGwgZmFsbGJhY2sgdG8gdm1hbGxv
YyBpZiBuZWNlc3NhcnkuCj4gPgo+ID4gQ2hlbiBMaSAoMyk6Cj4gPiAgICBkcm0vcmFkZW9uOiBV
c2Uga3ZtYWxsb2MgZm9yIENTIGNodW5rcwo+ID4gICAgZHJtL2FtZGdwdTogVXNlIGt2bWFsbG9j
IGZvciBDUyBjaHVua3MKPiA+ICAgIGRybS9hbWRncHU6IGNvcnJlY3QgRFJNX0VSUk9SIGZvciBr
dm1hbGxvY19hcnJheQo+ID4KPiA+IENoYW5nZWxvZzoKPiA+ICAgIHYxLT52MjoKPiA+ICAgICAg
KiBhbHNvIHVzZSBrdm1hbGxvYyBpbiBhbWRncHUKPiA+ICAgICAgKiBmaXggYSBEUk1fRVJST1Ig
bWVzc2FnZSBmb3Iga3ZtYWxsb2NfYXJyYXkuCj4gPiAgICB2Mi0+djM6Cj4gPiAgICAgICogYWRk
IG1pc3Npbmcga3ZmcmVlIGZvciBhbWRncHUgQ1MKPiA+Cj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9jcy5jIHwgMTQgKysrKysrKy0tLS0tLS0KPiA+ICAgZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yYWRlb25fY3MuYyAgICAgfCAgOCArKysrLS0tLQo+ID4gICAyIGZpbGVz
IGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+ID4KPiA+IC0tCj4g
PiAyLjMwLjAKPiA+Cj4gPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
