Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C377CC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 21:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CFE23127
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 21:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CFE23127
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A9589453;
	Tue, 12 Jan 2021 21:58:33 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F4D893ED;
 Tue, 12 Jan 2021 21:58:31 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id s2so4014876oij.2;
 Tue, 12 Jan 2021 13:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=w18T70m4lkwRPMiPMR134n9wU13dWJxLSQUBF6LNCsc=;
 b=BL/njEzcAiq3Zpu7sZCqsrz1x6pqD4L5U0ECVx0gvXYbE4/ZXX0pVI+4nM2xgArpoP
 fMsITr+IqJmsxccdfl0HNa2N7kfFCrGrIX4RYBFD4d429siBlUyooygos4f3i1mNtcSS
 8q7aCwotCsWDcHAHzXJ6dK6CYPkOIGlQ3o0bJDEGW/EQdVFKJK1KH8qcCrGAfXVpqAtQ
 oSVtv9dGhPD+OsYMOpURTQsW9gzPAMEGDB+Ef0hxRKknvY97vHBdcQTnQxvHA2bga34C
 iUtTKsn9WGW5dSiU/6WH5h/cX1UrK1gh4VH1Q2dMaxfFPsg/GAGjOdOdpNhfIGirCZfy
 ft6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=w18T70m4lkwRPMiPMR134n9wU13dWJxLSQUBF6LNCsc=;
 b=RzXIx/U55f7FAqck8MXRGHuqrAeTRNzuTi8wduD52MQ9dHuDThUplyouS8VAs4WkAN
 u9YdGWiePy6cDMe177Wnt4qqRf5ck2Fm+h1Ho3ciVaEEU7IgHyxK+NKyryL9H1qTxQii
 /ZTCJXPTuHl9kdvL1YjxpXtV0lnzWDqGX9HWx8xSk/Sy2JQX8Z34krrhzq5IY0wGz88a
 xUxO1viO3/JilvSvPbkO5rYffVMJc96NfQES2V/3izKhkJxnS7Wn97fKwDDxwLJBWU+G
 rtURtVOE/dNcwUquVefI7pc0lnWqSiLhshC9dMz835kdys0nn+spUi1J1Jr5wFYdY2rT
 jn9w==
X-Gm-Message-State: AOAM530G/yTr0gbP8NNGAgMI2yFSzuOIdHJ6BIKS2i4hDTHvpzoYxY2/
 EgNFKoNFq5W0wAerxzzh6qzwgsokzFVgyAXRokc=
X-Google-Smtp-Source: ABdhPJy9NwdyHTgzkc+OqNv3L/bhSJUX6/1k4y+l+Z2+MrFcnGrHnmxsOdqo6PwYGS1pQzNpAaTCjNoKFdnYhS/LTtw=
X-Received: by 2002:aca:6202:: with SMTP id w2mr727504oib.5.1610488711091;
 Tue, 12 Jan 2021 13:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org>
 <20210111191926.3688443-3-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-3-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Jan 2021 16:58:20 -0500
Message-ID: <CADnq5_P-dj79Rx+8O7c6oVAtsUPjV-mn2FxXqsdx-uV76U4wwA@mail.gmail.com>
Subject: Re: [PATCH 02/40] drm/amd/display/dc/dce/dce_link_encoder: Remove
 unused variable 'value0'
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
Cc: Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBKYW4gMTEsIDIwMjEgYXQgMjoxOSBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMv
ZGNlL2RjZV9saW5rX2VuY29kZXIuYzogSW4gZnVuY3Rpb24g4oCYZGNlMTEwX2xpbmtfZW5jb2Rl
cl91cGRhdGVfbXN0X3N0cmVhbV9hbGxvY2F0aW9uX3RhYmxl4oCZOgo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9kY2VfbGlua19lbmNvZGVyLmM6MTUwNjox
MTogd2FybmluZzogdmFyaWFibGUg4oCYdmFsdWUw4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51
c2VkLWJ1dC1zZXQtdmFyaWFibGVdCj4KPiBDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRs
YW5kQGFtZC5jb20+Cj4gQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgo+IENjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2
bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxp
ZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzog
TWF1cm8gUm9zc2kgPGlzc29yLm9ydWFtQGdtYWlsLmNvbT4KPiBDYzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNp
Z25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpBcHBsaWVkLiAg
VGhhbmtzIQoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
ZS9kY2VfbGlua19lbmNvZGVyLmMgfCAzICstLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjZS9kY2VfbGlua19lbmNvZGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNlL2RjZV9saW5rX2VuY29kZXIuYwo+IGluZGV4IDBlZjJmNGQ5ZDhiZjMu
LjFlNzdmZmVlNzFiMzAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjZS9kY2VfbGlua19lbmNvZGVyLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGNlL2RjZV9saW5rX2VuY29kZXIuYwo+IEBAIC0xNTAzLDcgKzE1MDMsNiBAQCB2
b2lkIGRjZTExMF9saW5rX2VuY29kZXJfdXBkYXRlX21zdF9zdHJlYW1fYWxsb2NhdGlvbl90YWJs
ZSgKPiAgICAgICAgIGNvbnN0IHN0cnVjdCBsaW5rX21zdF9zdHJlYW1fYWxsb2NhdGlvbl90YWJs
ZSAqdGFibGUpCj4gIHsKPiAgICAgICAgIHN0cnVjdCBkY2UxMTBfbGlua19lbmNvZGVyICplbmMx
MTAgPSBUT19EQ0UxMTBfTElOS19FTkMoZW5jKTsKPiAtICAgICAgIHVpbnQzMl90IHZhbHVlMCA9
IDA7Cj4gICAgICAgICB1aW50MzJfdCB2YWx1ZTEgPSAwOwo+ICAgICAgICAgdWludDMyX3QgdmFs
dWUyID0gMDsKPiAgICAgICAgIHVpbnQzMl90IHNsb3RzID0gMDsKPiBAQCAtMTYwNCw3ICsxNjAz
LDcgQEAgdm9pZCBkY2UxMTBfbGlua19lbmNvZGVyX3VwZGF0ZV9tc3Rfc3RyZWFtX2FsbG9jYXRp
b25fdGFibGUoCj4gICAgICAgICBkbyB7Cj4gICAgICAgICAgICAgICAgIHVkZWxheSgxMCk7Cj4K
PiAtICAgICAgICAgICAgICAgdmFsdWUwID0gUkVHX1JFQUQoRFBfTVNFX1NBVF9VUERBVEUpOwo+
ICsgICAgICAgICAgICAgICBSRUdfUkVBRChEUF9NU0VfU0FUX1VQREFURSk7Cj4KPiAgICAgICAg
ICAgICAgICAgUkVHX0dFVChEUF9NU0VfU0FUX1VQREFURSwKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIERQX01TRV9TQVRfVVBEQVRFLCAmdmFsdWUxKTsKPiAtLQo+IDIuMjUuMQo+
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBkcmkt
ZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
