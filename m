Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52500C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 17:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C50523B31
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 17:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C50523B31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B1A6E08C;
	Thu, 14 Jan 2021 17:11:20 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82DB46E027;
 Thu, 14 Jan 2021 17:11:18 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id i6so5850436otr.2;
 Thu, 14 Jan 2021 09:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NfiPn9PLaQKtUN6T1QDFoz96DhnMF0UCTa6RtqwvtD8=;
 b=PGJ7IOgGNfDdVkNbift3flxymeO6Z2LGjXmEa0DHJKFbpQHW6fNXVZiOOe6FUhoyw7
 43wJNtuMpFcpqp6v+Rl7t6Z3SePMNN11KRLrpwZcWwwPwdfOfQgOMdoXp9j/uLC9qkCh
 pchZ6z0e0SvQNBGB6oSslbbPc2ZOk6Na1QCe+KCTWI2Px+yLgApMaUtLoc+JceSvwhnW
 ahDI3jEjDQVD7T5his3mMKxwu1Psx66XT3+ZNLzrxT6lzo8eMxumgl5rnDk/e2uRhvGf
 bS66Yt2sCdUKnSjT0gsG00sYQroUE+xzZEIPWwU48nD1cq3k1ORAGt6ohRaYKSTtQozh
 W4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NfiPn9PLaQKtUN6T1QDFoz96DhnMF0UCTa6RtqwvtD8=;
 b=Av/5hcbgADObZ3d8YjgnVE2DE+emV0cQw9U00PxZB1rFtWH5VXM4JnY5BAsrZ4VPuR
 vNx2lxAUmjTIfUdRPQCs21q03nRurMUnZD4Oc4K/oDkBrmPK26+pDJJ7eccvLO6YEMPA
 qKm0NGtVydxTWs8HCW3NRqV2Mn8Xyf17dbxS7pDoj2AQcrz80TkIgq/2dXCp1yEyntLs
 vV6PkDrdMPoCNTiNSEkybzt1igvHbUCHFHDlqlE/5xwf+G9MbuMK/+mNl2tI2HUU54Ab
 7ZMhi7EIpUJFh09F0tN5NzVtx1zrxY22nE3V2NWNeo2OH+w2cwrhWHyEuCCH9uyWpG53
 qvRg==
X-Gm-Message-State: AOAM532ID72sNqoAMRkslJSGjlokgYOSTuWMZHWNHBGbLyGvGfNhIdcz
 u4NZiUxczpH9p+kB2ThDHklimF/lGIas3AHnMRY=
X-Google-Smtp-Source: ABdhPJzoUTQGcSw614Y41hTX+kKqaPEG+iqQ99MRM6XTrh1EXkI6DKDjcxehgC2LC+xMaoLB6U6s71UYy0zTaVLSNF4=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr5278877otl.311.1610644277946; 
 Thu, 14 Jan 2021 09:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org>
 <20210113080752.1003793-11-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-11-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Jan 2021 12:11:06 -0500
Message-ID: <CADnq5_PR-huyKKLFm0Z74SE-CH51cJnDrhWywSJ=3bDicqbRqA@mail.gmail.com>
Subject: Re: [PATCH 10/30] drm/amd/display/dc/core/dc: Staticise local
 function 'apply_ctx_interdependent_lock'
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKYW4gMTMsIDIwMjEgYXQgMzowOCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMv
Y29yZS9kYy5jOjgwNjo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGFw
cGx5X2N0eF9pbnRlcmRlcGVuZGVudF9sb2Nr4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KPgo+
IENjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KPiBDYzogTGVvIExp
IDxzdW5wZW5nLmxpQGFtZC5jb20+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVs
IFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gU2lnbmVkLW9mZi1i
eTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFwcGxpZWQuICBUaGFua3MhCgpB
bGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIHwg
MyArKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCj4gaW5kZXggOGYxY2Fk
YjgyM2M3MS4uMGEwN2U2MDg0ODVmZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvY29yZS9kYy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGMuYwo+IEBAIC04MDMsNyArODAzLDggQEAgc3RhdGljIHZvaWQgZGlzYWJsZV9h
bGxfd3JpdGViYWNrX3BpcGVzX2Zvcl9zdHJlYW0oCj4gICAgICAgICAgICAgICAgIHN0cmVhbS0+
d3JpdGViYWNrX2luZm9baV0ud2JfZW5hYmxlZCA9IGZhbHNlOwo+ICB9Cj4KPiAtdm9pZCBhcHBs
eV9jdHhfaW50ZXJkZXBlbmRlbnRfbG9jayhzdHJ1Y3QgZGMgKmRjLCBzdHJ1Y3QgZGNfc3RhdGUg
KmNvbnRleHQsIHN0cnVjdCBkY19zdHJlYW1fc3RhdGUgKnN0cmVhbSwgYm9vbCBsb2NrKQo+ICtz
dGF0aWMgdm9pZCBhcHBseV9jdHhfaW50ZXJkZXBlbmRlbnRfbG9jayhzdHJ1Y3QgZGMgKmRjLCBz
dHJ1Y3QgZGNfc3RhdGUgKmNvbnRleHQsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IGRjX3N0cmVhbV9zdGF0ZSAqc3RyZWFtLCBib29sIGxvY2spCj4g
IHsKPiAgICAgICAgIGludCBpID0gMDsKPgo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
