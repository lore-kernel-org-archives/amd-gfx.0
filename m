Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA399C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 21:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4576861408
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 21:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4576861408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 994966E19A;
	Wed, 28 Apr 2021 21:14:25 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB6E6E19A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 21:14:23 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id l17so33109465oil.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8s+OoS3pPrSV+BTok0t2vOKbv0WTxl901jYRE8Zyt6E=;
 b=efEZNHPXf7cBQsIa+o/EQd0AFryah9qSHAv9gFphlLPJB1ITO81mwJocwFTflRwC9W
 15XLsJXCHp4rLyxSn2nznS8Gxihy7+1sDeFS960doxaBgeX5ZyWal3XzLyvzCAB57Vwc
 YMymhmc/PTPihhhZwD1p3L2Uj0Bu/6E0SW96c3UT3ItkDW5DQHSsDaP5CcIdwepOIVua
 kmbFl4rE/CL6udzuxfDWs8MFJYKj/To1e1d6eK3aM3G+bY8MzJ+ScBxBnfEXS9uA9GZX
 ttYbQLeoRqIxHxIHOOt7OfpFHkvpTBRJA1rBT+3G/6voH18x3QDTJ+mYrHy50gG2iqw8
 CBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8s+OoS3pPrSV+BTok0t2vOKbv0WTxl901jYRE8Zyt6E=;
 b=Srl0Zfjj0cuoYsQFsyY3AsnJ3ar9B0bz0PsAl9KzAZwqsfOkcF3e3d9kRRxERHGrCR
 nnCDS3rTsGLvxbGmOXzwa7xSUnmd4MLYwE2X6dmbVhbKgiUCYz8AUo4BMKm5QzQmy71V
 2G5Fh1wAchDMGi8WPPPOsbibd1bYOC9C6znh/pEeufIHR7wDTYoG5oxWp8s9Ketouu4R
 +OxSYQy7m1LM+iwWwqkNY6FYttQgc1loiehasPQqx1RVid8QFCLLfauGuQO3K+g2Fr+p
 W6XNWcu2vsF/OYkS8VCa3FKnWFdUpb/UZQX9mZv/HXopYVBJbvLuJ3gr4Q+Pf0wKwE4S
 fo8g==
X-Gm-Message-State: AOAM533b971fBe1QqoU0jrGsa9+fF0Mv0WmpRZ5pAILvEUca1eej9xWf
 AQowAii3tQmFXyGrINOs/C9FAMvekX6P6MN2RxQ=
X-Google-Smtp-Source: ABdhPJxgG9q9vuO7r/L7Qw76CraxxMz7sU0Fs0LjGyyDP7pkfh4XU+l5+6TUWQ74NfuodTdXkHeBD3toLs69tckye7k=
X-Received: by 2002:a05:6808:68a:: with SMTP id
 k10mr21619570oig.120.1619644462973; 
 Wed, 28 Apr 2021 14:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210421091635.77483-1-contact@emersion.fr>
 <93008f80-edeb-de1c-35ca-15bbe872f8dc@gmail.com>
In-Reply-To: <93008f80-edeb-de1c-35ca-15bbe872f8dc@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Apr 2021 17:14:12 -0400
Message-ID: <CADnq5_NJaauFHM_ACSVJYA6MUaFuaWv_VSKA8OAk5V9TN4g1_w@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: fix GEM obj leak in
 amdgpu_display_user_framebuffer_create
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Simon Ser <contact@emersion.fr>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFdlZCwgQXByIDIxLCAyMDIxIGF0IDY6MjkgQU0g
Q2hyaXN0aWFuIEvDtm5pZwo8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3Rl
Ogo+Cj4gQW0gMjEuMDQuMjEgdW0gMTE6MTYgc2NocmllYiBTaW1vbiBTZXI6Cj4gPiBUaGlzIGVy
cm9yIGNvZGUtcGF0aCBpcyBtaXNzaW5nIGEgZHJtX2dlbV9vYmplY3RfcHV0IGNhbGwuIE90aGVy
Cj4gPiBlcnJvciBjb2RlLXBhdGhzIGFyZSBmaW5lLgo+Cj4gR29vZCBjYXRjaC4gRm9yIHNvbWUg
ZXh0cmEgcG9pbnRzIHlvdSBjb3VsZCBjaGFuZ2UgdGhlIGVycm9yIGhhbmRsaW5nCj4gaW50byB1
c2luZyBnb3RvIGVycm9yIGluc3RlYWQgb2YgaGFuZCB3aXJpbmcgaXQuCj4KPiBFaXRoZXIgd2F5
IHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Cj4KPiBUaGFua3MsCj4gQ2hyaXN0aWFuLgo+Cj4gPgo+ID4gU2lnbmVkLW9mZi1i
eTogU2ltb24gU2VyIDxjb250YWN0QGVtZXJzaW9uLmZyPgo+ID4gRml4ZXM6IDE3NjkxNTJhYzY0
YiAoImRybS9hbWRncHU6IEZhaWwgZmIgY3JlYXRpb24gZnJvbSBpbXBvcnRlZCBkbWEtYnVmcy4g
KHYyKSIpCj4gPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+
ID4gQ2M6IEhhcnJ5IFdlbnRsYW5kIDxod2VudGxhbkBhbWQuY29tPgo+ID4gQ2M6IE5pY2hvbGFz
IEthemxhdXNrYXMgPG5pY2hvbGFzLmthemxhdXNrYXNAYW1kLmNvbT4KPiA+IENjOiBCYXMgTmll
dXdlbmh1aXplbiA8YmFzQGJhc25pZXV3ZW5odWl6ZW4ubmw+Cj4gPiAtLS0KPiA+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyB8IDEgKwo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kaXNwbGF5LmMKPiA+IGluZGV4IDQ4Y2IzM2U1YjM4Mi4uMTk1MzIyM2VjZGJh
IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3Bs
YXkuYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXku
Ywo+ID4gQEAgLTk0NCw2ICs5NDQsNyBAQCBhbWRncHVfZGlzcGxheV91c2VyX2ZyYW1lYnVmZmVy
X2NyZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LAo+ID4gICAgICAgZG9tYWlucyA9IGFtZGdw
dV9kaXNwbGF5X3N1cHBvcnRlZF9kb21haW5zKGRybV90b19hZGV2KGRldiksIGJvLT5mbGFncyk7
Cj4gPiAgICAgICBpZiAob2JqLT5pbXBvcnRfYXR0YWNoICYmICEoZG9tYWlucyAmIEFNREdQVV9H
RU1fRE9NQUlOX0dUVCkpIHsKPiA+ICAgICAgICAgICAgICAgZHJtX2RiZ19rbXMoZGV2LCAiQ2Fu
bm90IGNyZWF0ZSBmcmFtZWJ1ZmZlciBmcm9tIGltcG9ydGVkIGRtYV9idWZcbiIpOwo+ID4gKyAg
ICAgICAgICAgICBkcm1fZ2VtX29iamVjdF9wdXQob2JqKTsKPiA+ICAgICAgICAgICAgICAgcmV0
dXJuIEVSUl9QVFIoLUVJTlZBTCk7Cj4gPiAgICAgICB9Cj4gPgo+Cj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
