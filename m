Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2226C43461
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 15:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36B420829
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 15:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQbMAa4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36B420829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329E689F49;
	Mon, 14 Sep 2020 15:13:46 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ACA889F49
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 15:13:45 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id x14so19132062wrl.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lD0Gus7auK8hpaxG2KGkMjnWUOlFYmaHfbt5zLxh9ws=;
 b=SQbMAa4rF1dysPQhyHRvigHYBgivKthNKHOgvY2lua1K6ixlKWzxHiaDHxmKh699dW
 pTytwDmVLBEXS15ki7lFPlswrmb6mnbVr79VjcfK12E3vSPjggBM5IKeugNxdiSKz7dd
 FN1sGXZSqjWehJ7NKY5BWyws1BWNWwbrzWUwdDbURBH3OP3iznt1OL3uwjjQBAdXigRx
 VzyZUh5mDrbMvNyu8xeuNNe48AiW+3c+ykpsdDLtPZltWvdG8gpLnUMjb/2eqBEMTYk0
 +MLcJiWpECBPFWWq3B/ek4rmUoVuNPLNOQbKSSejbEdEgj75ywARKcUhFEUu0Adpo4uU
 TpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lD0Gus7auK8hpaxG2KGkMjnWUOlFYmaHfbt5zLxh9ws=;
 b=QoQGz8sCCK46UzSoI1GKTTTkjcyEjxWtoJl23IlwB5azJxvY47mC8b236vJ73TRmFx
 nMQScmJqhoJ4cw54pgUT7jLeBBRNVVdJCkRcYYOhStdud4+EIGCP1r9Owawd5vEiN5Nd
 ljhZlds4AeNiNabbGT4h5cbNg2J8697uoD3SGNxMn0Yi1qI5VN3x5xdeYU/V43ovSMiH
 c2kO+EJFbVUv0vMh4QNveLkuPWbdovGdcaYpBlgaX8xpjmr5v39TdMRiXIn5q89Q8lun
 OcbFDre5LjooVEPlZaxoKE5spC5eWjs2x31MH2V+eoaNTJtagkrGlD8mqJzUicLTzG6f
 rROA==
X-Gm-Message-State: AOAM532L4F3TSuJfHkdr03NckCOi2KwpS3Ivj7Ie8hFBcd+ZMGTyWyYN
 AAFnQxZGz73Y59S6KHxn5pExT4/nz79ZkQS5bfMW2Ba5
X-Google-Smtp-Source: ABdhPJxymRNauIFE8JV31P9NezLlT3fvZRxc7a5dUAD4sXQw+168szv7NieTFZ3kjBB2ukaGaJPSf7jr3iIv08hG1wM=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr17033089wru.374.1600096424333; 
 Mon, 14 Sep 2020 08:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200909111655.1102-1-christian.koenig@amd.com>
 <f4505fa5-99a1-0010-7832-2d0e8e2c4410@gmail.com>
In-Reply-To: <f4505fa5-99a1-0010-7832-2d0e8e2c4410@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Sep 2020 11:13:33 -0400
Message-ID: <CADnq5_OCZ8_U_grgPZiijeYAD9=do+ewAFqeXg9HCdy-KNEC0Q@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: revert "Prefer lower feedback dividers"
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCk9u
IEZyaSwgU2VwIDExLCAyMDIwIGF0IDM6MzUgQU0gQ2hyaXN0aWFuIEvDtm5pZwo8Y2tvZW5pZy5s
ZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gUGluZywgd2UgbmVlZCB0byByZXZl
cnQgdGhpcyBBU0FQLgo+Cj4gQ2hyaXN0aWFuLgo+Cj4gQW0gMDkuMDkuMjAgdW0gMTM6MTYgc2No
cmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+ID4gVHVybnMgb3V0IHRoaXMgYnJlYWtzIGEgbG90IG9m
IGRpZmZlcmVudCBoYXJkd2FyZS4KPiA+Cj4gPiBUaGlzIHJldmVydHMgY29tbWl0IDUyMmZmM2E4
YjZkNzNhMzEwODRiNGIwODdiNDU4ZjdmYTBhYzFlMTQuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+ID4gLS0tCj4gPiAg
IGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rpc3BsYXkuYyB8IDIgKy0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rpc3BsYXkuYyBiL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2Rpc3BsYXkuYwo+ID4gaW5kZXggN2I2OWQ2ZGZlNDRhLi5l
MGFlOTExZWY0MjcgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9kaXNwbGF5LmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rpc3Bs
YXkuYwo+ID4gQEAgLTkzMyw3ICs5MzMsNyBAQCBzdGF0aWMgdm9pZCBhdml2b19nZXRfZmJfcmVm
X2Rpdih1bnNpZ25lZCBub20sIHVuc2lnbmVkIGRlbiwgdW5zaWduZWQgcG9zdF9kaXYsCj4gPgo+
ID4gICAgICAgLyogZ2V0IG1hdGNoaW5nIHJlZmVyZW5jZSBhbmQgZmVlZGJhY2sgZGl2aWRlciAq
Lwo+ID4gICAgICAgKnJlZl9kaXYgPSBtaW4obWF4KGRlbi9wb3N0X2RpdiwgMXUpLCByZWZfZGl2
X21heCk7Cj4gPiAtICAgICAqZmJfZGl2ID0gbWF4KG5vbSAqICpyZWZfZGl2ICogcG9zdF9kaXYg
LyBkZW4sIDF1KTsKPiA+ICsgICAgICpmYl9kaXYgPSBESVZfUk9VTkRfQ0xPU0VTVChub20gKiAq
cmVmX2RpdiAqIHBvc3RfZGl2LCBkZW4pOwo+ID4KPiA+ICAgICAgIC8qIGxpbWl0IGZiIGRpdmlk
ZXIgdG8gaXRzIG1heGltdW0gKi8KPiA+ICAgICAgIGlmICgqZmJfZGl2ID4gZmJfZGl2X21heCkg
ewo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
