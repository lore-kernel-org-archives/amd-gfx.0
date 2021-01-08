Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE457C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B2E23AC0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B2E23AC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2A1B6E8DF;
	Fri,  8 Jan 2021 20:32:42 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366E06E8E3;
 Fri,  8 Jan 2021 20:32:41 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id a109so10954590otc.1;
 Fri, 08 Jan 2021 12:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eZGAGOsJpJjZqUYW6PU7CazkH5H81ceN1e8mI8rt4VI=;
 b=nJuITnuSVPeavYDgKi8TG/nJy7vDXXaFfmuBKDCljpXG9nITBPuM/QDt41RUp5hbDj
 r0UjdfoFdS1G9ioSGGvntgxzjqZ7AoXy/lfg3ZHbbvBpYmkQQtFwtQ9rcNTSoVuF8/bQ
 ZgI7K8sMePIz/aZVvQmh2kRSdEFPeV841ynQAPCpn8TBLR3RjV/EHUMBzbf6EcALgqv2
 EkJsSGAaVuNjXy68nuR2LpJXSP3/734KNPikw9/kCq4rfXSssNuJnYn5P4DQHxNwjiK3
 LNBMsFkSFfhcgjcH1+JN4WmBw18OPdLdIn7UgPMYqPV8isOg7xlrl3ygHJ0s1rQEjVaq
 obdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eZGAGOsJpJjZqUYW6PU7CazkH5H81ceN1e8mI8rt4VI=;
 b=WbNSRRYuAkeeyO0jKzCIhICHk/jci3xPJNScSaKlkHuOT7N6ToCQowXIkUDxsnmO7k
 z8yK87YwzMBBDEmIPi9nMwgWS0nq3iih3X4ksySRzFSl+6gS/6eGYQBy7wcmN0Hv+2un
 T9cMTngvKV6vl94e4CyYgMuRNAmVHfG4asakrHbBNFvitw+JUaRGFAIeBwp3bWA3BDzj
 FryFTVxL3BWuhGyEr1GmPWsYacZ3ZQ88s2JQWR2sPnqhqoKWP4PsiGYiu3pcdrx4gpIp
 TlsNX+Yyeba9k1A0GTg6eEuJFifyLt2wxViI6KaxQxS82DUc1lHiZJ4ouBswXtGD9dUd
 K+yw==
X-Gm-Message-State: AOAM531nQczjyvthLcYJWJd4bR6W4t4cYXKT2Jvk9X1iGvhr5nrKq3pD
 H/PjRHI7EpvD3e5IiCer93lTAwVVwd1DNYGo+lI=
X-Google-Smtp-Source: ABdhPJw2e7tM9dZ6PxxIsvuWPlW8hepaa14kG2Jo6Pc6Z5dpIY7WWRyBJBt4soUNikh3ixfk8iiXE13WaWRMpkuBpKo=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id
 d27mr3979159ote.132.1610137960612; 
 Fri, 08 Jan 2021 12:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org>
 <20210108201457.3078600-7-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-7-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Jan 2021 15:32:29 -0500
Message-ID: <CADnq5_Psm9Z+DkX87+QVuytFMj1iL1DX-i5o3=NJDbbJhipxEg@mail.gmail.com>
Subject: Re: [PATCH 06/40] drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0:
 Provide description of 'call_back_func'
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
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKYW4gOCwgMjAyMSBhdCAzOjE1IFBNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+IHdyb3RlOgo+Cj4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdh
cm5pbmcocyk6Cj4KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5
L2h3bWdyL3Byb2Nlc3NfcHB0YWJsZXNfdjFfMC5jOjEzNzE6IHdhcm5pbmc6IEZ1bmN0aW9uIHBh
cmFtZXRlciBvciBtZW1iZXIgJ2NhbGxfYmFja19mdW5jJyBub3QgZGVzY3JpYmVkIGluICdnZXRf
cG93ZXJwbGF5X3RhYmxlX2VudHJ5X3YxXzAnCj4KPiBDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5A
YW1kLmNvbT4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+
IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzog
RGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWxAZmZ3bGwuY2g+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMg
PGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCj4gLS0tCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3Byb2Nlc3NfcHB0YWJsZXNf
djFfMC5jIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3Byb2Nlc3NfcHB0
YWJsZXNfdjFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvcHJv
Y2Vzc19wcHRhYmxlc192MV8wLmMKPiBpbmRleCA3NDFlMDNhZDUzMTFmLi5mMmE1NWMxNDEzZjU5
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3By
b2Nlc3NfcHB0YWJsZXNfdjFfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dl
cnBsYXkvaHdtZ3IvcHJvY2Vzc19wcHRhYmxlc192MV8wLmMKPiBAQCAtMTM2Miw2ICsxMzYyLDcg
QEAgc3RhdGljIGludCBwcHRfZ2V0X3ZjZV9zdGF0ZV90YWJsZV9lbnRyeV92MV8wKHN0cnVjdCBw
cF9od21nciAqaHdtZ3IsIHVpbnQzMl90IGkKPiAgICogQGh3bWdyOiBQb2ludGVyIHRvIHRoZSBo
YXJkd2FyZSBtYW5hZ2VyLgo+ICAgKiBAZW50cnlfaW5kZXg6IFRoZSBpbmRleCBvZiB0aGUgZW50
cnkgdG8gYmUgZXh0cmFjdGVkIGZyb20gdGhlIHRhYmxlLgo+ICAgKiBAcG93ZXJfc3RhdGU6IFRo
ZSBhZGRyZXNzIG9mIHRoZSBQb3dlclN0YXRlIGluc3RhbmNlIGJlaW5nIGNyZWF0ZWQuCj4gKyAq
IEBjYWxsX2JhY2tfZnVuYzogVGhlIGZ1bmN0aW9uIHRvIGNhbGwgaW50byB0byBmaWxsIHBvd2Vy
IHN0YXRlCj4gICAqIFJldHVybjogLTEgaWYgdGhlIGVudHJ5IGNhbm5vdCBiZSByZXRyaWV2ZWQu
Cj4gICAqLwo+ICBpbnQgZ2V0X3Bvd2VycGxheV90YWJsZV9lbnRyeV92MV8wKHN0cnVjdCBwcF9o
d21nciAqaHdtZ3IsCj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
