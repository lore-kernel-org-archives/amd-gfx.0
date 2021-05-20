Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D2BC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDBF611AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDBF611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB14E6F514;
	Thu, 20 May 2021 19:27:04 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B8F96F515;
 Thu, 20 May 2021 19:27:03 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 36-20020a9d0ba70000b02902e0a0a8fe36so15845675oth.8; 
 Thu, 20 May 2021 12:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=R+7fnEf5+D7P9bpLMhivSuEMA6+dJMHLKzG/8S3WGrk=;
 b=nEhTq9xZXBPLnP+28MBTDWiVpvaDNpWS2ZczCd0MemXJVUJDan/EB/QsRfKAVgHtqk
 9nedqwj7u2ThftbxV3kJpB9OW8gj97IZqSFADRpdpIzl9HLYGeXI4dxnSvPPv2mSjEIw
 0Skpj/hMdFgEXs/rps5GO5c17N/bDNgorozvQVsNP6BT52pdghhkTLuFRiU1fNlvultR
 m6UPNyKCBP5ybL7fSglsonYILWwqbEcxt4bC2xslsC3YUeaNHWtoRwJCZSZBpyHTVqtb
 ILeKIYMHcxzh3G2SsDba2+szf1x8008VtB6zbIi7eIndnVQmP6qEUWbe0JAKbJpChE1R
 KGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=R+7fnEf5+D7P9bpLMhivSuEMA6+dJMHLKzG/8S3WGrk=;
 b=iGsW8jNcYqIyU99ogV5q624KQC2Ia//CKeUoomA7s971GFxarFNu4E7ESSt4qQN+bx
 vsfUFYnyvx+Tm228YOkKS5h6pSBgMUHDv8ySThIQ+eL5Lgikl41d8qmx+bCR6T0Pd1/3
 9thfmL5V5vtwZMRpjksmjqDrx2TK5Hhu5Itsj/W9VhQJ1fstsOdsTHl0aa/ziLyGWLuU
 Xn0ZILP5o+ulf5eRttiEGYNQrhaesv5lz4MKKZOW03bLXY/zsM/BQZ0AT/SgGvIsbMMM
 ymlrvG6CB5pNe/W1MpNZGOkvxiLa91B1/8PfIA9VaW7LUA9xbhCq1xtQD4gFQztyObBI
 Bo7w==
X-Gm-Message-State: AOAM533sRQbxIrIFCbiOdtNhZWGk9cUbdZwxGZR37a+peIVT4k0mGTlf
 lSEUa2StGWwLvCdrPm7b5lhOL9Mv/jD3yGxcCkw=
X-Google-Smtp-Source: ABdhPJwoiZrUETM2yFPXjegPd7djCrTKyeTo6WbivlDrp6LYzG0wufjvHh04Km1QUNibBmSLKIy7aZ+maj5RPBkeb/I=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr5162050otl.132.1621538822372; 
 Thu, 20 May 2021 12:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-39-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-39-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:26:51 -0400
Message-ID: <CADnq5_NLnfGYuoz8+1z=q1Y90Re_XCkDHREoMZW2so0gk-hwwA@mail.gmail.com>
Subject: Re: [PATCH 38/38] drm/amd/amdgpu/smuio_v13_0: Realign
 'smuio_v13_0_is_host_gpu_xgmi_supported()' header
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDMgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zbXVpb192MTNfMC5jOjk5OiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBlIGZvciBz
bXVpb192MTNfMF9zdXBwb3J0c19ob3N0X2dwdV94Z21pKCkuIFByb3RvdHlwZSB3YXMgZm9yIHNt
dWlvX3YxM18wX2lzX2hvc3RfZ3B1X3hnbWlfc3VwcG9ydGVkKCkgaW5zdGVhZAo+Cj4gQ2M6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBL
w7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWly
bGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENj
OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Cj4gQ2M6IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zbXVpb192MTNfMC5jIHwgMiArLQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zbXVpb192MTNfMC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc211aW9fdjEzXzAuYwo+IGluZGV4IDNjNDdjOTQ4NDZkNmQuLjM5Yjdj
MjA2NzcwZjYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc211aW9f
djEzXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NtdWlvX3YxM18wLmMK
PiBAQCAtMTA2LDcgKzEwNiw3IEBAIHN0YXRpYyB1MzIgc211aW9fdjEzXzBfZ2V0X3NvY2tldF9p
ZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgfQo+Cj4gIC8qKgo+IC0gKiBzbXVpb192
MTNfMF9zdXBwb3J0c19ob3N0X2dwdV94Z21pIC0gZGV0ZWN0IHhnbWkgaW50ZXJmYWNlIGJldHdl
ZW4gY3B1IGFuZCBncHUvcy4KPiArICogc211aW9fdjEzXzBfaXNfaG9zdF9ncHVfeGdtaV9zdXBw
b3J0ZWQgLSBkZXRlY3QgeGdtaSBpbnRlcmZhY2UgYmV0d2VlbiBjcHUgYW5kIGdwdS9zLgo+ICAg
Kgo+ICAgKiBAYWRldjogYW1kZ3B1IGRldmljZSBwb2ludGVyCj4gICAqCj4gLS0KPiAyLjMxLjEK
PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
