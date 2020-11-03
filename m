Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72219C388F9
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 17:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0713020773
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 17:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBAsTaY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0713020773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A7BC6E8DE;
	Tue,  3 Nov 2020 17:42:17 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA5256E8DE
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 17:42:16 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id f6so15604250ybr.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 09:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=b5wBnV+qts7AF7O7h6hxZq3TnLVv9AZfBN1iUmcE1cA=;
 b=SBAsTaY7iUHH9he3Rrd+rzY8L56GpnwzWt6HonQyAfD52USZxUWEEauyIq+a4+Ke5Q
 rJTC4cq08yIWS2x6Hzi+njWupk7zaOTUpSmJhs9KDPgeBAdKbxYCMoC3C3iFxArSjbxe
 IXOC/R0BUPV7+kpSC9Hzqk08IPlFTRjtiri0r5OX1p900ppdjfLUMv1rdExRA5R/W000
 el3oVKqgMHXlnX3uZqQaRuCMGCHPsk053PpG/4zYnNkeQUXIUDVe3V5KSIG76JNV75Yl
 HREGd+HYLqMAPUIqSI34CamaknZJhgQ8IBEKXQyMRphiCHJg7t6hmR8FuVLvjE24oCqM
 LKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=b5wBnV+qts7AF7O7h6hxZq3TnLVv9AZfBN1iUmcE1cA=;
 b=WsBDFPr8PEIJx6VCnmGyzJUMywG9mbClgGd+W52R5KRfyWUqWSxyZNTtwuvkAQEIa2
 Mtdl8nZqNscXcaWc8PF5MWG61J8m1NvNe2iLSBTO/SH1w318qxA50lhuLNd0sRYorFI2
 NUuHO60ktNtJAsF6IOSpP/TpKSpjrAjLPGJfYGdmjQhZHOIV7prjA+YfOZVRfPf8njd7
 Rgjy3646GaDDIXtJiaID0KClLNZfAotdaMxwy+S7zYtkqOTthoXaq/rJdYpuCfW5kVFG
 qPTD2lsbA4ZVo7CPbll4/wyIxOk0SJRGtmNkbqcYzneWxpz6oBNTdli6LclQrDIxYRWz
 k7xA==
X-Gm-Message-State: AOAM530enYB+gWno9uLwJmJ3olKv7mAKtfyCi0Qdq7LkRfY+4slbo1Fu
 bCFzawGUBhoiWB8b2m273N6q6rHveHfBB1nABK053tDq
X-Google-Smtp-Source: ABdhPJxMCJiIS9/avsMGBzEBfEryV89fZNB2T/9JkdlCmz9fEZCR/hm+bpmw/PC4/vH/klf8nvpwg8TgahKBLBwS/Q8=
X-Received: by 2002:a05:6902:4ed:: with SMTP id
 w13mr28119958ybs.157.1604425335955; 
 Tue, 03 Nov 2020 09:42:15 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A7dVst6RpB-cD_SOkkC89jVH1vp6WMv=_KkOEWJKqY_aA@mail.gmail.com>
 <CAAxE2A7FX+8m=9wSyHW8Vwn8ubPdWpSy8TVe3-f2M2uWADU3HQ@mail.gmail.com>
In-Reply-To: <CAAxE2A7FX+8m=9wSyHW8Vwn8ubPdWpSy8TVe3-f2M2uWADU3HQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2020 12:42:04 -0500
Message-ID: <CADnq5_NWE4R2_DDsRMKc2bOJFV_6BVh6--jR_Dpxf1z035KQOA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: set LDS_CONFIG=0x20 on Navy Flounder to fix a
 GPU hang
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCk9uIFR1
ZSwgTm92IDMsIDIwMjAgYXQgMTI6MTggUE0gTWFyZWsgT2zFocOhayA8bWFyYWVvQGdtYWlsLmNv
bT4gd3JvdGU6Cj4KPiBVcGRhdGVkIHBhdGNoLgo+Cj4gVGhhbmtzLAo+IE1hcmVrCj4KPiBPbiBU
dWUsIE5vdiAzLCAyMDIwIGF0IDExOjEwIEFNIE1hcmVrIE9sxaHDoWsgPG1hcmFlb0BnbWFpbC5j
b20+IHdyb3RlOgo+Pgo+PiBQbGVhc2UgcmV2aWV3Lgo+Pgo+PiBUaGFua3MsCj4+IE1hcmVrCj4K
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
