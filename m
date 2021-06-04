Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462B4C4743D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 20:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0698A61404
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 20:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0698A61404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73FE6EB1F;
	Fri,  4 Jun 2021 20:59:24 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0AF06EB1F;
 Fri,  4 Jun 2021 20:59:22 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id x196so10631138oif.10;
 Fri, 04 Jun 2021 13:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hcL1duf2cmVS2FFozNPUZ6B5aiW4MPId9J+rVmkQUYk=;
 b=Y3QUX1ZAvnl/3ato47zA/tKEluRFWys/uYy3LhRgHryxJy2v3HpkGSBbNRtRMeFYv/
 ygX8EevDFP1KKbg1U2360M0YCC720fLNFdPjNlRkeqlJs1HSqOFPDZRYpiLcy+j2K5+D
 3vcB/6sobewdj640tdMhp4agMFL8k3XJzAE8zJS75Z/gEBQ2vhZeg4dzDb54oBcKxnHt
 OSPTZ0/CaLJlC0rZRtm9tWghIbGTcd8B3KSN+0oTMRrkqzTwqmrIEaOQLT2vgDfkfTeE
 hWPaCj0fH+m2+XE5/THM8CXTNPd73SeWW9RO1wE1eLKtsGrmDRR9bNZ3AV0cZj2ZZ173
 RY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hcL1duf2cmVS2FFozNPUZ6B5aiW4MPId9J+rVmkQUYk=;
 b=A+h+rLspNZxQ3HCxycHKsX5buCu0t6N8jyl8pAH9pdAP9jIVkJ/l2OVjG4BDLbXGzS
 SH5+2WX7czZid/D3PWqls4UIcBoAFZM2fmUaQP0KKUXa3EdpFEOcYqvwTDD14dWfTcJP
 JWUlKKGUZSbyB3PdWXdWS531qdb62lb4seZAaLA6PL2q+rQ3C+XwuAgGHrD1APC77Mws
 lktc/v7ziP+UGEgYsPw17az3H3THb3Ihu2IZuNOuAGfjHGGAL8kHRC9Gw/bVNkSQwH5U
 lObbM31jacoCGtPEJ5O6kFk3AXaDZFjTbnRDOTJVpgWVnlbaUtMcltVbSoaRTJ6oL6e+
 7ZGQ==
X-Gm-Message-State: AOAM532M4yyGlzOLjP+80lfmzudi2Cv0YrD6iP8spb7Z8AgvYYgo4+gV
 bSytNESTLrEa5PZbA/o3Chtz5mYj7mK4/xXJuYc=
X-Google-Smtp-Source: ABdhPJw4eES4VW3g/ubIWR4XRCfecTT650bw+GiTjrYM4m9lJI5z15zWHzNxpYjZfQXlqa9fMW8UX3Esa/xQxythEUs=
X-Received: by 2002:a05:6808:206:: with SMTP id
 l6mr11541621oie.5.1622840361985; 
 Fri, 04 Jun 2021 13:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210603160928.3854180-1-Liam.Howlett@Oracle.com>
 <4d2e62c7-af4c-b977-a05c-97b664b532b3@gmail.com>
In-Reply-To: <4d2e62c7-af4c-b977-a05c-97b664b532b3@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Jun 2021 16:59:10 -0400
Message-ID: <CADnq5_Nc_ifTV9mREwnQuNsH8r2LuYELvY3B9SU0Pir+HTQD8A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use vma_lookup() in
 amdgpu_ttm_tt_get_user_pages()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Liam Howlett <liam.howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBKdW4gNCwgMjAyMSBhdCA3OjExIEFNIENocmlzdGlhbiBLw7ZuaWcKPGNrb2VuaWcu
bGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPgo+IEFtIDAzLjA2LjIxIHVtIDE4OjA5
IHNjaHJpZWIgTGlhbSBIb3dsZXR0Ogo+ID4gVXNlIHZtYV9sb29rdXAoKSB0byBmaW5kIHRoZSBW
TUEgYXQgYSBzcGVjaWZpYyBhZGRyZXNzLiAgQXMgdm1hX2xvb2t1cCgpCj4gPiB3aWxsIHJldHVy
biBOVUxMIGlmIHRoZSBhZGRyZXNzIGlzIG5vdCB3aXRoaW4gYW55IFZNQSwgdGhlIHN0YXJ0IGFk
ZHJlc3MKPiA+IG5vIGxvbmdlciBuZWVkcyB0byBiZSB2YWxpZGF0ZWQuCj4gPgo+ID4gU2lnbmVk
LW9mZi1ieTogTGlhbSBSLiBIb3dsZXR0IDxMaWFtLkhvd2xldHRAT3JhY2xlLmNvbT4KPgo+IFJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4K
CkknbSBmaW5lIHRvIGhhdmUgdGhpcyBnbyB0aHJvdWdoIHdoYXRldmVyIHRyZWUgbWFrZXMgc2Vu
c2UuCgpBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoK
PiA+IC0tLQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCA0
ICsrLS0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gPiBpbmRl
eCA3Y2I3ZmZkZDE5MDAuLmRmYjVjYTNmOGRhOCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gPiBAQCAtNjgwLDkgKzY4MCw5IEBAIGludCBhbWRncHVf
dHRtX3R0X2dldF91c2VyX3BhZ2VzKHN0cnVjdCBhbWRncHVfYm8gKmJvLCBzdHJ1Y3QgcGFnZSAq
KnBhZ2VzKQo+ID4gICAgICAgICAgICAgICByZXR1cm4gLUVTUkNIOwo+ID4KPiA+ICAgICAgIG1t
YXBfcmVhZF9sb2NrKG1tKTsKPiA+IC0gICAgIHZtYSA9IGZpbmRfdm1hKG1tLCBzdGFydCk7Cj4g
PiArICAgICB2bWEgPSB2bWFfbG9va3VwKG1tLCBzdGFydCk7Cj4gPiAgICAgICBtbWFwX3JlYWRf
dW5sb2NrKG1tKTsKPiA+IC0gICAgIGlmICh1bmxpa2VseSghdm1hIHx8IHN0YXJ0IDwgdm1hLT52
bV9zdGFydCkpIHsKPiA+ICsgICAgIGlmICh1bmxpa2VseSghdm1hKSkgewo+ID4gICAgICAgICAg
ICAgICByID0gLUVGQVVMVDsKPiA+ICAgICAgICAgICAgICAgZ290byBvdXRfcHV0bW07Cj4gPiAg
ICAgICB9Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
