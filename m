Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52D3C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 19:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3AE20715
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 19:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3AE20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E5A96EA20;
	Wed, 20 Nov 2019 19:25:18 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82D646EA20
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 19:25:16 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id x26so634726wmk.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 11:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G+Mpb8VumMlmlwZujF3xj4Kct8YiUbM0EMsI8rstL0g=;
 b=gYtDxyde+SQ4IKVhvD/3cZcauKAuCBOcywpMLpq/Ihr+m7SIV4GEq7qTMoWwQMuC8P
 Z2bQcyOmKX7S5GCDadbwnFp+n8yJ775rIrJoQLj4omzcr6zyEMi2JZJnCphivPQPV+Ij
 PR5apc0heDX9JsjSgwSHZ3/UyBYfXoeqDI1DQwU2hU0D/cwluQ5RKcxI/3ozXSaEsvsq
 Ofokxj3NawAj2MCa2+gPDu/kkYcnR+ozt/vfO5X8h4x1uDrjmRODscy1j/I8sQ3aqFpR
 OeokCCpTXVkmiXsJV5OqaWZf1zeHNWkYA0Dyf5jOkHlgATvvF6y3meQyffdO8UP1CYbN
 SQnA==
X-Gm-Message-State: APjAAAUt4qA5AJ5VhUAjt0HBVnpseiVix1uwr0R3F7tTMJJYjXBoZVdd
 YtoKldfey1PId93pNZB4ujpM0t+QhcXqmCpM7sE=
X-Google-Smtp-Source: APXvYqzENL/58SnSoS7xfcYxYqc3S3b7/vchs2ffOZlh9MmPcbZt6bs2hEiDxxPD0yh7apKNn7pi6qRTWPVQih2OmAk=
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr5300120wml.102.1574277915045; 
 Wed, 20 Nov 2019 11:25:15 -0800 (PST)
MIME-Version: 1.0
References: <1571194113-22696-1-git-send-email-curry.gong@amd.com>
 <CAHbf0-Hv5e_ZtdziJe9F0Zmgnsw9p_kXZ6HujSWZQOdFBvzSNg@mail.gmail.com>
In-Reply-To: <CAHbf0-Hv5e_ZtdziJe9F0Zmgnsw9p_kXZ6HujSWZQOdFBvzSNg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Nov 2019 14:25:03 -0500
Message-ID:
 <CADnq5_MNtd2ApcQqAnpUwi3TBf88aj08EVkKrH+uUL1ie5hXEw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/psp: declare PSP TA firmware
To: Mike Lothian <mike@fireburn.co.uk>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=G+Mpb8VumMlmlwZujF3xj4Kct8YiUbM0EMsI8rstL0g=;
 b=lCybH4LY3voSob5tvbXYx821xomEzUlF7/vhkUgrP5wrYcTu7KtN6C1gyZ9GGVz9nC
 H3CfMsa30Y442X/LV0Zva+KHbaJAX32IPz192nr/EYJeLgxnnoUne/G5+s1/lio6Vdpy
 0ZbjjeBHSTbZBY4ewFsvS/lCg4Vcqu9Pgr8eSIYdu76BHKEfofAd7zmKmHaqsmeQVzmJ
 wT/5+6kVrlqRH8O8j8e3t5AfYsrXEyUdySjoFhqZOuR/InrF027PRRfcyodiznhXwUdP
 oW1oz17YpsK/AqbmBcu1nl1MgEIDWF3KbBJaivqgmpNM0nsuMi1eR+R6NvmZR/hmIZaE
 vT0A==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120192503.8Gw4tY8edqX8QgKHW5LEjDnSWbkvGMP55E22R92QheY@z>

SXQncyBvcHRpb25hbCBhbmQgb25seSB1c2VkIGZvciBIRENQIGF0IHRoZSBtb21lbnQuICBJJ2xs
IHB1dCBpdCB1cCBhbnl3YXkuCgpBbGV4CgpPbiBXZWQsIE5vdiAyMCwgMjAxOSBhdCA3OjM2IEFN
IE1pa2UgTG90aGlhbiA8bWlrZUBmaXJlYnVybi5jby51az4gd3JvdGU6Cj4KPiBIaQo+Cj4gQW55
IGlkZWEgd2hlcmUgSSBjYW4gZmluZCB0aG9zZSBibG9icz8KPgo+IENoZWVycwo+Cj4gTWlrZQo+
Cj4gT24gV2VkLCAxNiBPY3QgMjAxOSBhdCAwMzo0OCwgY2hlbiBnb25nIDxjdXJyeS5nb25nQGFt
ZC5jb20+IHdyb3RlOgo+ID4KPiA+IEFkZCBQU1AgVEEgZmlybXdhcmUgZGVjbGFyYXRpb24gZm9y
IHJhdmVuIHJhdmVuMiBwaWNhc3NvCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogY2hlbiBnb25nIDxj
dXJyeS5nb25nQGFtZC5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9wc3BfdjEwXzAuYyB8IDMgKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjEw
XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTBfMC5jCj4gPiBpbmRleCBi
OTY0ODRhLi5iMzQ1ZTY5IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvcHNwX3YxMF8wLmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92
MTBfMC5jCj4gPiBAQCAtNDAsNiArNDAsOSBAQAo+ID4gIE1PRFVMRV9GSVJNV0FSRSgiYW1kZ3B1
L3JhdmVuX2FzZC5iaW4iKTsKPiA+ICBNT0RVTEVfRklSTVdBUkUoImFtZGdwdS9waWNhc3NvX2Fz
ZC5iaW4iKTsKPiA+ICBNT0RVTEVfRklSTVdBUkUoImFtZGdwdS9yYXZlbjJfYXNkLmJpbiIpOwo+
ID4gK01PRFVMRV9GSVJNV0FSRSgiYW1kZ3B1L3BpY2Fzc29fdGEuYmluIik7Cj4gPiArTU9EVUxF
X0ZJUk1XQVJFKCJhbWRncHUvcmF2ZW4yX3RhLmJpbiIpOwo+ID4gK01PRFVMRV9GSVJNV0FSRSgi
YW1kZ3B1L3JhdmVuX3RhLmJpbiIpOwo+ID4KPiA+ICBzdGF0aWMgaW50IHBzcF92MTBfMF9pbml0
X21pY3JvY29kZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKPiA+ICB7Cj4gPiAtLQo+ID4gMi43
LjQKPiA+Cj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+ID4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiA+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
