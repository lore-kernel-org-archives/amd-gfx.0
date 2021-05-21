Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B43C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 07:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BACF611BD
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 07:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BACF611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D257A6F5C3;
	Fri, 21 May 2021 07:17:40 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 574E76F5BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 07:10:16 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id i17so19923926wrq.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 00:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=pXr3oFzANmcGgyCrUaaQgcSjUAbiwbF7giTakGIiEpQ=;
 b=uMzGQMRfihuosCJL97x9+ScHvFGXK5Es7iO3ThAwSGj+dccNs7f16EBz1+5itartBe
 N4jgLnyrfsDsTJGONdqYNWtNG7I9iLYo/qpotCMlX7b4fsp+TxY+DOe8W5pYWzLnixEE
 X9iuT4a8vOwbTKs2fp0QSnWD2M7+Z9OZHkgBOjPB4cZrS6Zt1jeWbGLQUIWaHGaT8fR+
 dJSRb7Sb1gvjPgqzGhuOAdi2mGGcjBGPfS6VZNGsRmtUX3sQXt16WM7shCU5Ib5diGNW
 DhYEb6f2R6qxgOX4HFblfhga1IkaaR0NYGPvLQ7m3/WysqvBum6fmmFPcbyYnF8BYSuq
 BxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=pXr3oFzANmcGgyCrUaaQgcSjUAbiwbF7giTakGIiEpQ=;
 b=aVaNTUktNpUCKD6yh1JweOdTazkA45whE7ZyvQ8AhvhNr+3CyC6mPblbbJvLw2Wfb5
 4v4uZ1epe3G1ZapFo3FcGhaqVEh6pU93eeszjFIp30oOsdiBapXNmjuJ5KjqTB/BfLl/
 0iheaUxda97c9HKGfoygsIv5lE5beg0sdbO7XFJTyAb1kemCn5OPJpIIjHLYQtSE5m5y
 U6hnn4bVxgznHRUdbK2/yN+qoGy+JSyemdHO6bAgoeezw2J4Af7Yb0ehXQBgL2Hyle9e
 bQnpw4rAmXaGNCoN0T9faFSUrvHNxBIgLS/mKW+EVi1pML/3tdtOV0t+nKYzYXmcKYuh
 z4ug==
X-Gm-Message-State: AOAM531vbEq7oOEuFlFIGXKPx1FgvlmdVVZEZXnZzmOxBd3gZkY6yz2+
 ggQUNMm4vUO+DO0sO44m0NvaNg==
X-Google-Smtp-Source: ABdhPJwE0viepO5e4IIyz1lTctOknX7d+QtwA8ta4C51lrclzTdniX/yTH1dNb4HCvL+/+JfzBTJZQ==
X-Received: by 2002:adf:f5c5:: with SMTP id k5mr704324wrp.81.1621581014981;
 Fri, 21 May 2021 00:10:14 -0700 (PDT)
Received: from dell ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id a11sm949666wrx.38.2021.05.21.00.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 May 2021 00:10:14 -0700 (PDT)
Date: Fri, 21 May 2021 08:10:12 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 38/38] drm/amd/amdgpu/smuio_v13_0: Realign
 'smuio_v13_0_is_host_gpu_xgmi_supported()' header
Message-ID: <20210521071012.GT2549456@dell>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-39-lee.jones@linaro.org>
 <CADnq5_NLnfGYuoz8+1z=q1Y90Re_XCkDHREoMZW2so0gk-hwwA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_NLnfGYuoz8+1z=q1Y90Re_XCkDHREoMZW2so0gk-hwwA@mail.gmail.com>
X-Mailman-Approved-At: Fri, 21 May 2021 07:17:39 +0000
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
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCAyMCBNYXkgMjAyMSwgQWxleCBEZXVjaGVyIHdyb3RlOgoKPiBBcHBsaWVkLiAgVGhh
bmtzIQoKVGhhbmtzIGFnYWluIEFsZXguCgo+IE9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDMg
QU0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4gPgo+ID4gRml4ZXMg
dGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6Cj4gPgo+ID4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NtdWlvX3YxM18wLmM6OTk6IHdhcm5pbmc6IGV4cGVjdGlu
ZyBwcm90b3R5cGUgZm9yIHNtdWlvX3YxM18wX3N1cHBvcnRzX2hvc3RfZ3B1X3hnbWkoKS4gUHJv
dG90eXBlIHdhcyBmb3Igc211aW9fdjEzXzBfaXNfaG9zdF9ncHVfeGdtaV9zdXBwb3J0ZWQoKSBp
bnN0ZWFkCj4gPgo+ID4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KPiA+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
PiA+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gPiBDYzogRGFuaWVsIFZl
dHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+ID4gQ2M6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhh
bmdAYW1kLmNvbT4KPiA+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4gQ2M6
IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IFNpZ25lZC1vZmYtYnk6IExlZSBK
b25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zbXVpb192MTNfMC5jIHwgMiArLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zbXVpb192MTNfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc211aW9fdjEzXzAuYwo+ID4gaW5kZXggM2M0N2M5NDg0NmQ2ZC4uMzliN2MyMDY3NzBmNiAx
MDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NtdWlvX3YxM18wLmMK
PiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NtdWlvX3YxM18wLmMKPiA+IEBA
IC0xMDYsNyArMTA2LDcgQEAgc3RhdGljIHUzMiBzbXVpb192MTNfMF9nZXRfc29ja2V0X2lkKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ID4gIH0KPiA+Cj4gPiAgLyoqCj4gPiAtICogc211
aW9fdjEzXzBfc3VwcG9ydHNfaG9zdF9ncHVfeGdtaSAtIGRldGVjdCB4Z21pIGludGVyZmFjZSBi
ZXR3ZWVuIGNwdSBhbmQgZ3B1L3MuCj4gPiArICogc211aW9fdjEzXzBfaXNfaG9zdF9ncHVfeGdt
aV9zdXBwb3J0ZWQgLSBkZXRlY3QgeGdtaSBpbnRlcmZhY2UgYmV0d2VlbiBjcHUgYW5kIGdwdS9z
Lgo+ID4gICAqCj4gPiAgICogQGFkZXY6IGFtZGdwdSBkZXZpY2UgcG9pbnRlcgo+ID4gICAqCj4g
PgoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpTZW5pb3IgVGVjaG5pY2FsIExlYWQgLSBEZXZl
bG9wZXIgU2VydmljZXMKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFy
bSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
