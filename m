Return-Path: <SRS0=jMTE=63=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6FFCA90AF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 13:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8892625214
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 13:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8892625214
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 218086E056;
	Wed, 13 May 2020 13:15:02 +0000 (UTC)
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE236E9A5;
 Wed, 13 May 2020 11:55:29 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id e2so13926449eje.13;
 Wed, 13 May 2020 04:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dwSZ/cYngXQKvlWb23OdV+haQ9k3VXAPp4SIUIXgqs4=;
 b=Yzt9tfQVrHVU8vHLbysGEiBP86H2+TFsxNCxUcnlmaAEBug2z43dp5YxMyPiZRPN5o
 jYmrE8TEvs9i8eaNJgmB2Cjbk1IwfrfuGMiUpOgaCiWtBpsI32ybD9conp9LKd4c8WPw
 kFCkCVx+IBtQyEKmsLDpmLH4z3031+ZOQGDzAN7HZtv7p6cjumqRhMHCEu3jWWB/WCZr
 ZyFkoNntF0KUfLhcis7qOYwVWP9x7hdhcsuTUQtG7kPeAe0PbKqhqWqNqqWS30TvrBm2
 C6tJNefDnNJyWhc3W9BXOvM3O3j7QJuCcUzLBG//qgxYDU8D+Tk8Y/I7++QlXxZollfX
 Degg==
X-Gm-Message-State: AOAM533JAyHRbv39lgpjt4dAzFkxPduex7EhAy/GxyRbbJkcYchDF2TU
 FjF+SWOJlvg43GIzyM0CN7FMbhuhHEy9PJcZeD8=
X-Google-Smtp-Source: ABdhPJyAC9MguPRNIE2BUEDngfEtSDBisoQg6ROhdksLfyStEEGl+xyUoRGQpBhEbNs34bQoBmVc5TiVBpoX7QOKifw=
X-Received: by 2002:a17:906:4d0d:: with SMTP id
 r13mr9935228eju.282.1589370927429; 
 Wed, 13 May 2020 04:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200513110313.12979-1-christian.koenig@amd.com>
 <20200513110313.12979-2-christian.koenig@amd.com>
In-Reply-To: <20200513110313.12979-2-christian.koenig@amd.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 13 May 2020 13:55:15 +0200
Message-ID: <CA+7wUszB45OzgyTUM-04QZKAVbRU6aMnPmLzupPAU5Ej_XnwGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/radeon: disable AGP by default
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
X-Mailman-Approved-At: Wed, 13 May 2020 13:15:00 +0000
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
Cc: nouveau@lists.freedesktop.org,
 PowerPC List Debian <debian-powerpc@lists.debian.org>,
 amd-gfx@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBNYXkgMTMsIDIwMjAgYXQgMToyMSBQTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbHdheXMgdXNlIHRoZSBQQ0kg
R0FSVCBpbnN0ZWFkLgoKUmV2aWV3ZWQtYnk6IE1hdGhpZXUgTWFsYXRlcnJlIDxtYWxhdEBkZWJp
YW4ub3JnPgoKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5j
IHwgNSAtLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX2Rydi5jCj4gaW5kZXggYmJiMDg4M2U4Y2U2Li5hNzFmMTMxMTZkNmIg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYwo+IEBAIC0xNzEsMTIgKzE3MSw3
IEBAIGludCByYWRlb25fbm9fd2I7Cj4gIGludCByYWRlb25fbW9kZXNldCA9IC0xOwo+ICBpbnQg
cmFkZW9uX2R5bmNsa3MgPSAtMTsKPiAgaW50IHJhZGVvbl9yNHh4X2F0b20gPSAwOwo+IC0jaWZk
ZWYgX19wb3dlcnBjX18KPiAtLyogRGVmYXVsdCB0byBQQ0kgb24gUG93ZXJQQyAoZmRvICM5NTAx
NykgKi8KPiAgaW50IHJhZGVvbl9hZ3Btb2RlID0gLTE7Cj4gLSNlbHNlCj4gLWludCByYWRlb25f
YWdwbW9kZSA9IDA7Cj4gLSNlbmRpZgo+ICBpbnQgcmFkZW9uX3ZyYW1fbGltaXQgPSAwOwo+ICBp
bnQgcmFkZW9uX2dhcnRfc2l6ZSA9IC0xOyAvKiBhdXRvICovCj4gIGludCByYWRlb25fYmVuY2ht
YXJraW5nID0gMDsKPiAtLQo+IDIuMTcuMQo+CgoKLS0gCk1hdGhpZXUKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
