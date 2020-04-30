Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6B7C47247
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 14:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B12C2076D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 14:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueLJ7/J1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B12C2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DA16E927;
	Thu, 30 Apr 2020 14:55:52 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C1296E926
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 14:55:51 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id r26so2275911wmh.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pQjE7f7589kt0iGBiRIyizNt8qpdDUJKOJWm3F287So=;
 b=ueLJ7/J1d+BQYGt9WsdiZqAVGWPMHTBSpWA4/5TuB2T0b/iWky766sU+ii5pyNZSpF
 943/NY0uhfZAdIHtnIFTWcbkXnetX1zS8XRB89DLXZfE1ftTAz500SaEqKHX1r0KWvDy
 yCIpD1gUKKxE/9xjhWsjW+mre/+4Mm/6chhA1dB0tRPvj7bf9rdX6sLuDgP+aFMDBdtv
 lnEfI+HZyp4B5EruSSNu3uAFnxGU9KRI3quNJkq59t8IR/gkaC3nKxGYV5SZkyFhtYQu
 kTYqg+ocPD6e7VuPa1bZFpNKWVFCI2gpajeNArmXLRcvgBDlH0z5qT7aCDsmYCOw+4VB
 VL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pQjE7f7589kt0iGBiRIyizNt8qpdDUJKOJWm3F287So=;
 b=a2NOvhGRNMhGJpYN4JczMulZKke245cRvq1jFZ11umi8RIY7OFEQh0FWMZsNyfZuFU
 DdBHisXRh/hBV9i36IJ4rLHlNHio3rhCKv+TBIHOy86/fOwuGPyi5X2qaxcJlirSW07e
 WaoaCpaJooLcB6I75B2A45dmoxAAP6+Lo5ui4O5k0dk102fIVCNuGzRtmi9wsmdy63hO
 FMdufvjrBTAKK4mcJPbY5Y6YaJmm6WscnAFBwQnR4H3EbpMARgcc68dHPV0IyWY8Y9TL
 ABkMyONMh/Kcu7/n2RL/OPOG6JMYTRLAExCVYcbkdwsO9gpJ0Z0FnWofvaoWnoCSJU1Y
 r26Q==
X-Gm-Message-State: AGi0PuYkoBUOnDhpftIWrNmKy7REDOTv++Tg9G2mRwu2qsD3h9uITiye
 kQQ+b+w5hi7ViY/Ha2GmWrMpQXs3iy+sjtin7D48hA==
X-Google-Smtp-Source: APiQypJG1CU0+GP3uZ8u5y7MxvsZ8rrp+QPv3/TWXplUAFMaO9EAombBq0/Vmpi9RVZzXR5At3DD5yk/zxiUkrVkooI=
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr3424747wmh.39.1588258549891; 
 Thu, 30 Apr 2020 07:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200429162801.18598-1-michel@daenzer.net>
In-Reply-To: <20200429162801.18598-1-michel@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Apr 2020 10:55:38 -0400
Message-ID: <CADnq5_Oh9n-tfJM4dpoSmczkRtSMpdhey=CP5E4qW9vJtYA68g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dc: Use WARN_ON_ONCE for ASSERT
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBBcHIgMjksIDIwMjAgYXQgMTI6MjggUE0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBk
YWVuemVyLm5ldD4gd3JvdGU6Cj4KPiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWRhZW56ZXJAcmVk
aGF0LmNvbT4KPgo+IE9uY2Ugc2hvdWxkIGdlbmVyYWxseSBiZSBlbm91Z2ggZm9yIGRpYWdub3Np
bmcgd2hhdCBsZWFkIHVwIHRvIGl0LAo+IHJlcGVhdGluZyBpdCBvdmVyIGFuZCBvdmVyIGNhbiBi
ZSBwcmV0dHkgYW5ub3lpbmcuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWRh
ZW56ZXJAcmVkaGF0LmNvbT4KCkFwcGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvb3NfdHlwZXMuaCB8IDIgKy0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL29zX3R5cGVzLmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvb3NfdHlwZXMuaAo+IGluZGV4IGMzNGViYTE5ODYwYTMyLi42ZDdiY2E1
NjJlZWMwMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvb3Nf
dHlwZXMuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9vc190eXBlcy5o
Cj4gQEAgLTEwOCw3ICsxMDgsNyBAQAo+ICAjZGVmaW5lIEFTU0VSVChleHByKSBBU1NFUlRfQ1JJ
VElDQUwoZXhwcikKPgo+ICAjZWxzZQo+IC0jZGVmaW5lIEFTU0VSVChleHByKSBXQVJOX09OKCEo
ZXhwcikpCj4gKyNkZWZpbmUgQVNTRVJUKGV4cHIpIFdBUk5fT05fT05DRSghKGV4cHIpKQo+ICAj
ZW5kaWYKPgo+ICAjZGVmaW5lIEJSRUFLX1RPX0RFQlVHR0VSKCkgQVNTRVJUKDApCj4gLS0KPiAy
LjI2LjIKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
