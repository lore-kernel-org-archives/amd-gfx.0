Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2639C56202
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 23:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6687E207FB
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 23:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgj/gQYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6687E207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB28B89D63;
	Tue, 10 Nov 2020 23:58:09 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DF9A89C6B;
 Tue, 10 Nov 2020 23:58:08 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id c9so165882wml.5;
 Tue, 10 Nov 2020 15:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sVHw44prgkhLl+wZoJDl9y1Sv84cjPWTxQBG3axW3YI=;
 b=Fgj/gQYKkyen7e5H6J7aIP6pfShNXewwImkCyWp5IXS9p6js8HtD5W/sdec1EctQ00
 5WN5HYbtFQqBafMliHQcbEaJ5G66ajncFFRYTrverGRb9lI763sgcJatSONy2h0alv/o
 DYAZ6dqOdCUYl7iyaxpVFHrV2EVAm6hc4QAplBckBzTV5ZFHYO7maZeikWJCNlB9Y/EY
 6BgucQPZOdHYc7N29acSZMaYUbOR6qMNBNTv7ZJskbiB8AmOmQUDcvORYf4PKv2b4Kmm
 PTDx56GqMRaiwmZnPs5P7/bNw7fKYjDdNq+D1QAXUTIAJkKU+Dhyn5BxtsamN+cgl1jH
 QeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sVHw44prgkhLl+wZoJDl9y1Sv84cjPWTxQBG3axW3YI=;
 b=O/DXzE0+ghGGJSsWqKHnoSFaaGRFET2F30W+wtX7g67mRQcMB/0jYGY4vd/LfhLpKk
 tPUhnWCJhQhjM7DkKSauSYVkyZeNGaNyRpYHPnWvOTJEb6DDtIBCuuCo4npe/SAxE5oM
 GNCSpZvOEvoBiWstH9weX6r+hmx9ljHAR6bI8VXK6mrUi1ihdZ56L1RaigNl0TY5v9zj
 rRT6Q7d1dNB+OEBsr2YF2rirc0C5os6MYEmmE3N3NMvoVhQhfXpSE8KGW8bB7Ln5sJFD
 6kySjYlEFJOfOcSfY3x2UB9PEOrDWW52XaAvxV4uPKrAfB0tM/JWLDR+gHHIgg0C/oRg
 CAnw==
X-Gm-Message-State: AOAM530s+Rj6OOSN+JYfRncZYKibqJT4ogxVVs+BDt2iLkhsgllYIxQK
 06FtAE7eaj7y2X+DTS/Hyp0lmO+G1ey97DDYMs8=
X-Google-Smtp-Source: ABdhPJwGVm8zxKOpbuvLzIOHTQhYo2DrNr+mXrvd1xPnYkBEHOZz9oYFfEfo+lAFTQEnLFs0aW5uGXu88lIbYUyf+QQ=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr639254wmi.70.1605052686774;
 Tue, 10 Nov 2020 15:58:06 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org>
 <20201110193112.988999-15-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-15-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2020 18:57:55 -0500
Message-ID: <CADnq5_M28RPCQR27JXOiugvPPfHh2CnCedVFmBfkMb3kZ8RzzA@mail.gmail.com>
Subject: Re: [PATCH 14/30] drm/radeon/evergreen_dma: Fix doc-rot of function
 parameter 'resv'
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
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBOb3YgMTAsIDIwMjAgYXQgMjozMSBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdyZWVuX2RtYS5jOjEx
Mjogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAncmVzdicgbm90IGRlc2Ny
aWJlZCBpbiAnZXZlcmdyZWVuX2NvcHlfZG1hJwo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2V2
ZXJncmVlbl9kbWEuYzoxMTI6IHdhcm5pbmc6IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ2Zl
bmNlJyBkZXNjcmlwdGlvbiBpbiAnZXZlcmdyZWVuX2NvcHlfZG1hJwo+Cj4gQ2M6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWci
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBs
aW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBTdW1p
dCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6
IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwo+IENjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxp
bmFyby5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3Jn
PgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9yYWRl
b24vZXZlcmdyZWVuX2RtYS5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L2V2ZXJncmVlbl9kbWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vZXZlcmdyZWVuX2RtYS5j
Cj4gaW5kZXggYTQ2ZWU2YzIwOTlkZC4uNzY3ODU3ZDRhOGM1YyAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL2V2ZXJncmVlbl9kbWEuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vZXZlcmdyZWVuX2RtYS5jCj4gQEAgLTk4LDcgKzk4LDcgQEAgdm9pZCBldmVyZ3Jl
ZW5fZG1hX3JpbmdfaWJfZXhlY3V0ZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwKPiAgICog
QHNyY19vZmZzZXQ6IHNyYyBHUFUgYWRkcmVzcwo+ICAgKiBAZHN0X29mZnNldDogZHN0IEdQVSBh
ZGRyZXNzCj4gICAqIEBudW1fZ3B1X3BhZ2VzOiBudW1iZXIgb2YgR1BVIHBhZ2VzIHRvIHhmZXIK
PiAtICogQGZlbmNlOiByYWRlb24gZmVuY2Ugb2JqZWN0Cj4gKyAqIEByZXN2OiByZXNlcnZhdGlv
biBvYmplY3Qgd2l0aCBlbWJlZGRlZCBmZW5jZQo+ICAgKgo+ICAgKiBDb3B5IEdQVSBwYWdpbmcg
dXNpbmcgdGhlIERNQSBlbmdpbmUgKGV2ZXJncmVlbi1jYXltYW4pLgo+ICAgKiBVc2VkIGJ5IHRo
ZSByYWRlb24gdHRtIGltcGxlbWVudGF0aW9uIHRvIG1vdmUgcGFnZXMgaWYKPiAtLQo+IDIuMjUu
MQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBk
cmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
