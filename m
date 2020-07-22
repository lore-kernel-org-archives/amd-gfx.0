Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D142AC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 17:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C16206D7
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 17:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlqBE//y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C16206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF0F56E83E;
	Wed, 22 Jul 2020 17:13:04 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A6A26E833;
 Wed, 22 Jul 2020 17:13:03 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id a14so2639847wra.5;
 Wed, 22 Jul 2020 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vgWD6rc73noc9ansR89xUuntE5QV4DpEgoUGQZ2KSKg=;
 b=GlqBE//yHDWE2H/gnqInI1pnF2XdQ1j4UlyzZdS5T+hczJpShgcm7BeHsTiU07BH4R
 V4+j/tI6gHRYeF0FMlFvgkEKIThHzhQV11z6l7rHjS8jWFFGKZlenX/HvB+JwvfpGOjt
 tVJ/LoVjC+6KJ7y0rD3DmS7c32sNe2iYa98BWX/JHx67lkyo45h+dxxoIyOKrO06ld5p
 9T3WpmHtV6pg8C4QRRt3qslipSKSET9y59CGikbeCmpsHc2/rz5CWiZrhmNNef1xVqdz
 cIDmfdeOsZ5vAsBVZrLP3BleI7UnmM6ClaT4QPI/rQzYRyhZ3P/94iJIrrgakYul+FWE
 U18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vgWD6rc73noc9ansR89xUuntE5QV4DpEgoUGQZ2KSKg=;
 b=FxCRMLMu0L8K5xdK6J68+vcwLJpH2VeGN0RqJAVxeGvrZWnIMhWEh4xMs8HsRMio1o
 ZJQDwbDGZ8guTNtV/YHRmpSK4deGvfZx72+EMhrjXon6/CRPCs+cSE2DvnWJR4MIe5R5
 PO2EfopNX9uUb06S1QOANF7ROCYpiIKhxTzVzl/3bC6JGYu2Qh0Ez57RZyPXJPhbfD7T
 /99mxfe8ie9avJ5qnddTqLovblwaX4E7y4HjGqSvo4wGVGO2uBNomOsiXQUmkuvbAS1i
 ILFtDam/7nOEi1nh0VR9JYsgdS7J7OfrrkjiDn4E6X2vCq+IjJQhgNNfe24DHssmJCuF
 p0LA==
X-Gm-Message-State: AOAM533mxyiySzDqweaVnYvW/Y1d7luBezOsKmk6DEj9F6ETyLSqBloU
 Px/e5I9H9D+T30GwrlDxz7MPcIcYz6pO5zJjzNE=
X-Google-Smtp-Source: ABdhPJyiC3xKszgflJ5SZNcQjVF2dtUFsnNzKyfYOtek3MfFjKqnlZRxivLY9+oG+Qzrmu7He55VfLdKkRFQm86kZOo=
X-Received: by 2002:adf:a351:: with SMTP id d17mr477993wrb.111.1595437980546; 
 Wed, 22 Jul 2020 10:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200722123813.721041-1-michel@daenzer.net>
 <CAKMK7uGO3K0P1yJsdT0urEXOVyBCU_Gsm8JaAW3R0TrBkueYNg@mail.gmail.com>
 <c1bed91c-aa9d-140e-701b-6946995cf24f@amd.com>
 <46b17209-09f6-d5a8-1335-0ff5371659f6@daenzer.net>
In-Reply-To: <46b17209-09f6-d5a8-1335-0ff5371659f6@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Jul 2020 13:12:49 -0400
Message-ID: <CADnq5_MWoNt5LR3-E8eMbXhXNFS_ccbqev+96BJphzzeKi16nw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dc: Simplify drm_crtc_state::active checks
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
Cc: Leo Li <sunpeng.li@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKdWwgMjIsIDIwMjAgYXQgMTA6MjUgQU0gTWljaGVsIETDpG56ZXIgPG1pY2hlbEBk
YWVuemVyLm5ldD4gd3JvdGU6Cj4KPiBPbiAyMDIwLTA3LTIyIDM6MTAgcC5tLiwgS2F6bGF1c2th
cywgTmljaG9sYXMgd3JvdGU6Cj4gPiBPbiAyMDIwLTA3LTIyIDg6NTEgYS5tLiwgRGFuaWVsIFZl
dHRlciB3cm90ZToKPiA+PiBPbiBXZWQsIEp1bCAyMiwgMjAyMCBhdCAyOjM4IFBNIE1pY2hlbCBE
w6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOgo+ID4+Pgo+ID4+PiBGcm9tOiBNaWNo
ZWwgRMOkbnplciA8bWRhZW56ZXJAcmVkaGF0LmNvbT4KPiA+Pj4KPiA+Pj4gZHJtX2F0b21pY19j
cnRjX2NoZWNrIGVuZm9yY2VzIHRoYXQgOjphY3RpdmUgY2FuIG9ubHkgYmUgdHJ1ZSBpZgo+ID4+
PiA6OmVuYWJsZSBpcyBhcyB3ZWxsLgo+ID4+Pgo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoZWwg
RMOkbnplciA8bWRhZW56ZXJAcmVkaGF0LmNvbT4KPiA+Cj4gPiBMb29rcyBmaW5lIHRvIG1lLiBU
aGUgY2hlY2sgaXMgc3VmZmljaWVudGx5IG9sZCBlbm91Z2ggdGhhdCBJIGRvbid0IG1pbmQKPiA+
IHJlbHlpbmcgb24gdGhlIGNvcmUgZm9yIHRoaXMgZWl0aGVyLgo+ID4KPiA+IFJldmlld2VkLWJ5
OiBOaWNob2xhcyBLYXpsYXVza2FzIDxuaWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20+Cj4gPgo+
ID4+Cj4gPj4gbW9kZXNldCB2cyBtb2RlcmVzZXQgaXMgYSBiaXQgYW4gaW5nbG9yaW91cyBuYW1l
IGNob2ljZSAuLi4gc2luY2UgdGhpcwo+ID4+IHNlZW1zIHRvIGJlIGdsdWUgY29kZSBhbmQgbm90
IHBhcnQgb2YgY29yZSBkYywgbWF5YmUgcmVuYW1lIHRvCj4gPj4gZW5hYmxlX3JlcXVpcmVkL2Rp
c2FibGVfcmVxdWlyZWQgdG8ga2VlcCBpdCBjb25zaXN0ZW50IHdpdGggdGhlCj4gPj4gd29yZGlu
ZyBhdG9taWMgaGVscGVycyB1c2U/IERDIGFsc28gc2VlbXMgdG8gdXNlIHJlc2V0IGZvciBhIGxv
dCBvZgo+ID4+IG90aGVyIHRoaW5ncyBhbHJlYWR5IChzdGF0ZSByZXNldCwgbGlrZSBhdG9taWMs
IG9yIGdwdSByZXNldCBsaWtlCj4gPj4gZHJtL3NjaGVkdWxlcidzIHRkX3JfKSwgc28gSSB0aGlu
ayB0aGlzIHdvdWxkIGFsc28gaGVscCBjbGFyaXR5IGZyb20gYQo+ID4+IERDIHBlcnNwZWN0aXZl
Lgo+ID4+Cj4gPj4gUGF0Y2ggaXRzZWxmIGlzIGdvb2QsIGFib3ZlIGp1c3QgYW4gaWRlYSBmb3Ig
YW5vdGhlciBwYXRjaCBvbiB0b3AuCj4gPj4KPiA+PiBSZXZpZXdlZC1ieTogRGFuaWVsIFZldHRl
ciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4KPgo+IFRoYW5rcyBmb3IgdGhlIHJldmlld3MhIEkg
YXNzdW1lIHRoaXMgd2lsbCBnZXQgcGlja2VkIHVwIGJ5IGEgREMKPiBkZXZlbG9wZXIgb3IgQWxl
eC9DaHJpc3RpYW4uCgpBcHBsaWVkLiAgVGhhbmtzIQoKQWxleAoKPgo+Cj4gPiBUaGF0IHNvdW5k
cyBsaWtlIGEgcmVhc29uYWJsZSBpZGVhIHRvIG1lLiBUaGVzZSBhcmUgdXNlZCBtb3JlIGFzIGEK
PiA+IHN0cmVhbV9jaGFuZ2VkIC8gc3RyZWFtX3JlbW92ZWQgZmxhZywgYnV0IEkgZG9uJ3QgdGhp
bmsgdGhlc2UgaGVscGVycwo+ID4gcmVhbGx5IG5lZWQgdG8gZXhpc3QgYXQgYWxsLgo+ID4KPiA+
IFRoYXQgY291bGQgY29tZSBhcyBhIGZvbGxvdyB1cCBwYXRjaC4KPgo+IFllYWgsIEknbSBsZWF2
aW5nIHRoYXQgdG8geW91IGd1eXMuIDopCj4KPgo+IC0tCj4gRWFydGhsaW5nIE1pY2hlbCBEw6Ru
emVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHBzOi8vcmVkaGF0LmNvbQo+IExp
YnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFu
ZCBYIGRldmVsb3Blcgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
