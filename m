Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518A0C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CDB6134F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CDB6134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62EC86F473;
	Fri, 14 May 2021 21:16:38 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567E86E4AD;
 Fri, 14 May 2021 21:16:37 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id b25so800871oic.0;
 Fri, 14 May 2021 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lN4vxBb7HsrPSthr80bYcbW3xAFTNXZpcixwXqHVjEQ=;
 b=fqQhqaGmX8IZEF+lPDonIGW7PsGpbN3vWiO/z8ZH8X4Oq7VLVfkIIWYpwFlXGLuE2U
 9NerDawBSs7z6VCbqh3IEBxZQEzPkyNlj7uo/Msj4C4wXSDgb3t+JDj573PBM7aKU+ZL
 srPjq0wRCRfQ+qMtPhu3+sZCd6aazv5l7/WmB4rrPiS0hvTPjZC1gJrIcmLtedbnem8n
 Knc7gn+6kRaQxZFz86c2ISEvk2eVm9orH8jIm0LQ/GDpgm6PBxwrutzOWpvocH+4x73v
 Gj4voH1GwHaB9TNMuD3FkP7v8Kpz/5n0NB9pa77ZUqgH+DHrf2X14CZhBrF0X/hAOd4v
 uV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lN4vxBb7HsrPSthr80bYcbW3xAFTNXZpcixwXqHVjEQ=;
 b=DRQ8Mc/ewuLLGsBE2T/I4J9hdpI4v3T+J3g2wan6NdM1vuaazbcs0xixgIKiiYZh1d
 p2PHC9Fimd0XXJPN8BKeiYgJ/L/sStotOqAMjjOIWHwEm7IWprl2Im8VBw/x34O8rXFo
 5afkufOa/YvOjdHjScn6u6VW9K241FYWKaoC0oqvk8vSBn10V9zI6pwnaYl/x1fI7aHs
 2SA9z4AMTgTMbWuEHVfg58ywkJ430p/iVfPOL8MBnCX1K7Z5Ql+6+BYHhwBop9th3rEo
 YN5VNYqwiDA8JmCbxX/revO1DrdVtP0DGeWkh1w8Yu1jp5DirXCP8VFM9y6W2X9F5QIo
 0YVA==
X-Gm-Message-State: AOAM533GRS3lwsMaCAB6fruR1veOWTJNAasZmpIlLBeOpcSOpSlj3w+Y
 mpq2v3kAIfjDuWQ53CvYTJ0x4KQFWexf/52vMspKb8Jw
X-Google-Smtp-Source: ABdhPJxjk9UmFZHxPYf2hfRYYCQLHaSQdkhdv2C0EsFNcsBZ3KhSg5ek6jTnTbPwv44r0/5VUY2jEFuM55BTOdA6JWU=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr35559127oii.123.1621026996584; 
 Fri, 14 May 2021 14:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210514064039.1300558-1-chenhuacai@loongson.cn>
 <b555643f-8369-2eb5-fbea-89e6e9f01435@amd.com>
In-Reply-To: <b555643f-8369-2eb5-fbea-89e6e9f01435@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 May 2021 17:16:25 -0400
Message-ID: <CADnq5_NEKYc7QGNbXONhgzVDrXO-cHc+qPd+n2cPxY3nCC6ecA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix GPU TLB update error when PAGE_SIZE >
 AMDGPU_PAGE_SIZE
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
Cc: David Airlie <airlied@linux.ie>, Yi Li <liyi@loongson.cn>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCgpPbiBGcmksIE1heSAxNCwgMjAyMSBhdCAzOjE4IEFN
IENocmlzdGlhbiBLw7ZuaWcKPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBB
bSAxNC4wNS4yMSB1bSAwODo0MCBzY2hyaWViIEh1YWNhaSBDaGVuOgo+ID4gRnJvbTogWWkgTGkg
PGxpeWlAbG9vbmdzb24uY24+Cj4gPgo+ID4gV2hlbiBQQUdFX1NJWkUgaXMgbGFyZ2VyIHRoYW4g
QU1ER1BVX1BBR0VfU0laRSwgdGhlIG51bWJlciBvZiBHUFUgVExCCj4gPiBlbnRyaWVzIHdoaWNo
IG5lZWQgdG8gdXBkYXRlIGluIGFtZGdwdV9tYXBfYnVmZmVyKCkgc2hvdWxkIGJlIG11bHRpcGxp
ZWQKPiA+IGJ5IEFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0UgKFBBR0VfU0laRSAvIEFNREdQ
VV9QQUdFX1NJWkUpLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFlpIExpIDxsaXlpQGxvb25nc29u
LmNuPgo+ID4gU2lnbmVkLW9mZi1ieTogSHVhY2FpIENoZW4gPGNoZW5odWFjYWlAbG9vbmdzb24u
Y24+Cj4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgo+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3R0bS5jIHwgMiArLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4g
PiBpbmRleCAzYmVmMDQzMmNhYzIuLmEzNzZhOTkzZTQ3NCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gPiBAQCAtMjI1LDcgKzIyNSw3IEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X3R0bV9tYXBfYnVmZmVyKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8s
Cj4gPiAgICAgICAqYWRkciArPSBtbV9jdXItPnN0YXJ0ICYgflBBR0VfTUFTSzsKPiA+Cj4gPiAg
ICAgICBudW1fZHcgPSBBTElHTihhZGV2LT5tbWFuLmJ1ZmZlcl9mdW5jcy0+Y29weV9udW1fZHcs
IDgpOwo+ID4gLSAgICAgbnVtX2J5dGVzID0gbnVtX3BhZ2VzICogODsKPiA+ICsgICAgIG51bV9i
eXRlcyA9IG51bV9wYWdlcyAqIDggKiBBTURHUFVfR1BVX1BBR0VTX0lOX0NQVV9QQUdFOwo+ID4K
PiA+ICAgICAgIHIgPSBhbWRncHVfam9iX2FsbG9jX3dpdGhfaWIoYWRldiwgbnVtX2R3ICogNCAr
IG51bV9ieXRlcywKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1ER1BV
X0lCX1BPT0xfREVMQVlFRCwgJmpvYik7Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
