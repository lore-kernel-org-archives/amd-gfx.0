Return-Path: <SRS0=Gsig=FH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443EAC64E7A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 05:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E9E2085B
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 05:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E9E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C8BE6EB69;
	Thu,  3 Dec 2020 05:01:53 +0000 (UTC)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF5796EB68;
 Thu,  3 Dec 2020 05:01:51 +0000 (UTC)
Received: by mail-oi1-x242.google.com with SMTP id l200so926901oig.9;
 Wed, 02 Dec 2020 21:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xhPmXGe2TmQ1T8FUkBkZbWfsA9sbZw6W4geuHUSY+s0=;
 b=KWftkvGCjHdjjdSp83LlC5tIRRLWTWaNcqW5A5lhWAV2R0qrU5IOkq/a7O0kvfejlA
 rr7ZJGNNSzBbet6dMF9iNpmDbJEBTEVWKYWIXBQ4L8y+ex7Wg4USV+e43JNhvPivy1zl
 7hvAh3Uom+yPQPOPucVPPkMPBoemkGF17FytW+m2avdbGUCV3pGAXaPT6+IauOZ9OnsL
 zsqxYdo58VObj5gnhBctQTpdJyz7TWWMKyM+RDNFbDMwHTWantQkT9EPcH8nVD/xnT+B
 3gpbuuHCiRglD0DPa848kjp2G0YnRrHwxTBJ5a1zyV/0Jhp1XABiXB98YQwb8kl685rk
 39bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xhPmXGe2TmQ1T8FUkBkZbWfsA9sbZw6W4geuHUSY+s0=;
 b=sM5ROaw/4lBToay3ooez3UbCgMVKIm2yQ81BaOHzzysDcUnSHYLDy+Bh3tS0hc+99d
 y7BKYWYfnS1EXf+IRRP4WWyCH0oUlApKE1A460RGyO5n4jRmNvG52FsLQaz6GzR91M/O
 UKH/Bkx89wqxbpP2bCoMeY5wW8xMxxbCQsaB7NsoZfiSfxqucaEfpZcFa0HaT9j59MnT
 r6N2cjY8LJdcMeNu3syDDNIpmcC0953VABYaMruStKmLkjjWpvY7ZikvZcp23e816XQm
 6puaRwlgiUVvaxByRUAZWdpXDO35gHVaoFAY1QOplmdOh2q9letoCKbkMUtW9GYpg1jT
 DmHA==
X-Gm-Message-State: AOAM530n60pov+iIoZbxR527kIPASZbUZuMUCCjPhTV+mBwUKKy7haeV
 yHp67mo0L0icDxjf3rr34NyhOkc4KLwoOLDNeZQ=
X-Google-Smtp-Source: ABdhPJwdcKf0tkF3epFtOf2LnYfdbX0fkojq661TQO2vTSqo7wKalSEV2Rw1RKszQGPMi/nFn9EhXQr/KunOeaQQLog=
X-Received: by 2002:a54:4608:: with SMTP id p8mr783202oip.5.1606971711182;
 Wed, 02 Dec 2020 21:01:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606897462.git.mchehab+huawei@kernel.org>
 <65bae21ebb9de534483b282fb091d4526cff0be8.1606897462.git.mchehab+huawei@kernel.org>
 <21d4e623-4250-454f-67ff-658da99cf26d@amd.com>
In-Reply-To: <21d4e623-4250-454f-67ff-658da99cf26d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Dec 2020 00:01:39 -0500
Message-ID: <CADnq5_Opbff_Nn=pq7dCd3TWY9Tqrh24GdBj-=pB1R3eYS7q+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm: amdgpu: fix a kernel-doc markup
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
Cc: xinhui pan <xinhui.pan@amd.com>, Mihir Bhogilal Patel <Mihir.Patel@amd.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Dave Airlie <airlied@redhat.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBEZWMgMiwgMjAyMCBhdCAzOjQ1IEFNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAwMi4xMi4yMCB1bSAwOToyNyBzY2hyaWVi
IE1hdXJvIENhcnZhbGhvIENoZWhhYjoKPiA+IFRoZSBmdW5jdGlvbiBuYW1lIGF0IGtlcm5lbC1k
b2MgbWFya3VwIGRvZXNuJ3QgbWF0Y2ggdGhlIG5hbWUKPiA+IG9mIHRoZSBmdW5jdGlvbjoKPiA+
Cj4gPiAgICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmM6MTUz
NDogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgYW1kZ3B1X2RlYnVnZnNfcHJpbnRf
Ym9faW5mbygpLiBQcm90b3R5cGUgd2FzIGZvciBhbWRncHVfYm9fcHJpbnRfaW5mbygpIGluc3Rl
YWQKPiA+Cj4gPiBGaXggaXQuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogTWF1cm8gQ2FydmFsaG8g
Q2hlaGFiIDxtY2hlaGFiK2h1YXdlaUBrZXJuZWwub3JnPgo+Cj4gUmV2aWV3ZWQtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPgoKQXBwbGllZC4gIFRoYW5r
cyEKCkFsZXgKCj4gPiAtLS0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5jIHwgMiArLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29i
amVjdC5jCj4gPiBpbmRleCBjNmM5NzIzZDNkOGEuLmZkN2E5M2MzMjIzNSAxMDA2NDQKPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gPiBAQCAtMTUxOCw3
ICsxNTE4LDcgQEAgdWludDMyX3QgYW1kZ3B1X2JvX2dldF9wcmVmZXJyZWRfcGluX2RvbWFpbihz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiA+ICAgICAgIH0gd2hpbGUgKDApCj4gPgo+ID4g
ICAvKioKPiA+IC0gKiBhbWRncHVfZGVidWdmc19wcmludF9ib19pbmZvIC0gcHJpbnQgQk8gaW5m
byBpbiBkZWJ1Z2ZzIGZpbGUKPiA+ICsgKiBhbWRncHVfYm9fcHJpbnRfaW5mbyAtIHByaW50IEJP
IGluZm8gaW4gZGVidWdmcyBmaWxlCj4gPiAgICAqCj4gPiAgICAqIEBpZDogSW5kZXggb3IgSWQg
b2YgdGhlIEJPCj4gPiAgICAqIEBibzogUmVxdWVzdGVkIEJPIGZvciBwcmludGluZyBpbmZvCj4K
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
