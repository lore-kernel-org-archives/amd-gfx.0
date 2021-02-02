Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7196AC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3014C64F55
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3014C64F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C545D6E4A2;
	Tue,  2 Feb 2021 16:17:41 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564826E4A2
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 16:17:40 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id h14so20356969otr.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Feb 2021 08:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IcGnydPu904qvRmRqpfwCfjXCo13ku2eEEHFgQt3ys8=;
 b=WP/xw9AOzc2wb7gjZmEpflJ64M8DH2x3Ht4si4aFtDLDNw6EFPDLBVVvcIrWfhyjVL
 pQmafUwHtz5ZLmJd16BjwfNXKCJa7HsQhNF3bNdTqJsucJ4nQVr2C0WYkyYIiL7OPiYD
 YKGV5GH3tvS5XGmcCtD3LcDt1C0QZWHvlANkkW2G2JRXtL+jj2nSDG882B+jCdAaCeMP
 UIce9yDRPK8n1wcHb1R7/t6OiZAc9bdWGp3SxtKiemIT1bbBleaq1vi0prPXnvD3n8IM
 SDxR5p42mLCf/szh88n+Os4TZzZLjYFlWVchuxfZLEUGFOIqX1c/R3DLa3+LyQrlR1QB
 Ap2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IcGnydPu904qvRmRqpfwCfjXCo13ku2eEEHFgQt3ys8=;
 b=Bkl5Ptd40ruSuoPUC5yGVgLE2MAUOMSMYwa0WDjpHWvmIAHEgkYYlGjbUbC2HCwAVp
 t/5mPNzvr7vMq7PRlk94duw7HYbsUHT7wc3wpQ2plnr/7zkLsfGLZxXJRVC9dDp1j/tk
 Nqi4C27L1WdGza891f06ZPWiZVXaF3ybE/c6WhLTO34YeGuYYKLeVN189GzQbtJdXyll
 hZ1RA6ZaHJwfKId0RDtgPeSC4ITmPUKW6jNO8592xeau0jA1ijPhpB2Xuex064wcp/w3
 6Zcvn6URCLUi575IIbTujL+R0a+ZlNPK2PLc5xYtoKd4CLhZDC/86RMwHHA7YquBNAFE
 +y4w==
X-Gm-Message-State: AOAM5310dlQCxKDzVyYet/rp/cj8taTT1qkN0NVh0dod5Dp7zMh4EsUb
 IpvlZlbFazhQInratg3iYcMj2YdST/CRFWSyzBg2Mlus
X-Google-Smtp-Source: ABdhPJx35F3JAkIU59JHqhqGH3hGQ2j+0B6KxiONRe5L6J7nvXPLZNjh5lH9LM+t2AJrAxjDynTFBCWsihEZm8aQrXs=
X-Received: by 2002:a05:6830:92:: with SMTP id
 a18mr16016615oto.23.1612282659698; 
 Tue, 02 Feb 2021 08:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20210130010002.21222-1-xinhui.pan@amd.com>
In-Reply-To: <20210130010002.21222-1-xinhui.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Feb 2021 11:17:28 -0500
Message-ID: <CADnq5_MHPZvKrjYXr66VotD_RRi336PyOOaEHW2-U24SM63-fA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a false positive when pin non-VRAM memory
To: xinhui pan <xinhui.pan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKYW4gMjksIDIwMjEgYXQgODowMCBQTSB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFt
ZC5jb20+IHdyb3RlOgo+Cj4gRmxhZyBUVE1fUExfRkxBR19DT05USUdVT1VTIGlzIG9ubHkgdmFs
aWQgZm9yIFZSQU0gZG9tYWluLiBTbyBmaXggdGhlCj4gZmFsc2UgcG9zaXRpdmUgYnkgY2hlY2tp
bmcgbWVtb3J5IHR5cGUgdG9vLgo+Cj4gU3VnZ2VzdGVkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVs
aXguS3VlaGxpbmdAYW1kLmNvbT4KPiBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5w
YW5AYW1kLmNvbT4KCkBLdWVobGluZywgRmVsaXggSSBwcmVzdW1lIHRoaXMgZml4ZXMgdGhlIHJl
Z3Jlc3Npb24geW91IG5vdGVkIGxhc3Qgd2Vlaz8KCkFsZXgKCgo+IC0tLQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgfCAzICsrLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gaW5kZXggMTM3ZjI3NWY5MGVlLi41Njg1NGEzZWUx
OWMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVj
dC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4g
QEAgLTkxOSw3ICs5MTksOCBAQCBpbnQgYW1kZ3B1X2JvX3Bpbl9yZXN0cmljdGVkKHN0cnVjdCBh
bWRncHVfYm8gKmJvLCB1MzIgZG9tYWluLAo+ICAgICAgICAgICAgICAgICBpZiAoIShkb21haW4g
JiBhbWRncHVfbWVtX3R5cGVfdG9fZG9tYWluKG1lbV90eXBlKSkpCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4KPiAtICAgICAgICAgICAgICAgaWYgKChiby0+Zmxh
Z3MgJiBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVMpICYmCj4gKyAgICAgICAgICAg
ICAgIGlmICgobWVtX3R5cGUgPT0gVFRNX1BMX1ZSQU0pICYmCj4gKyAgICAgICAgICAgICAgICAg
ICAoYm8tPmZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9DT05USUdVT1VTKSAmJgo+ICAg
ICAgICAgICAgICAgICAgICAgIShtZW1fZmxhZ3MgJiBUVE1fUExfRkxBR19DT05USUdVT1VTKSkK
PiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPgo+IC0tCj4gMi4yNS4x
Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFt
ZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
