Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0C0C10F27
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 15:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF24206C0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 15:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjM5k32r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF24206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FEAA897FB;
	Wed, 11 Mar 2020 15:13:36 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E6C897FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 15:13:34 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id n8so2500730wmc.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 08:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=VJNw/LeIfv9qAYfGnF8jdotkHV7lT867UfCaVyWPefE=;
 b=TjM5k32rSUtf46bZj7tQS72VU2qfp5SAOxSaBIWg5pOa0HEi8cNgHIM+fI+iVijLHD
 smfSSOsapMQW2evnOCRGUehXsYyd3+eoS3K65KxKLAdKvhOAZRJ6qwLUBz/2Aij5Xnq/
 mO68Qq+rdJtZi/d0XkCfS0zsQzbxpLNQ+IgUsMQrDZT+WD6729nCJVjCpTaDlwsEsn/L
 iLL4VKzEHPv0UWgHo/T8q4sMB5rFRuF8Vw4vAEhRtT+prS8gxJg54A83+qLwgZipWOeD
 36uCnKtSkB37LMnF3MXU/OKDXJJSQhHVi3DC0C8ad6KkCMU/AOJUpsgGFJtyJ8gVr2Uf
 YOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=VJNw/LeIfv9qAYfGnF8jdotkHV7lT867UfCaVyWPefE=;
 b=I5tmQqqbZhhfgHq/gcYOO3ED+MlDyCMFDhP+nqPWzO2H1PeZUCqfIhcD42IwzoFFky
 zSVquLxOcSo0ieA/WIi17NKsyknF5YQnQ6xWSzfKQ9S00+yRgx+zelj52hyDOx9vV3p1
 GpQy78JBE2Trmz5wijTE3np/Eznv7XPgVESG+Si5ruxG6I6NJ0O+ixQ9TfBjmg3YpUxf
 jE5Vr1zVfF92WaFGAqdiq5epyT2bBpDEUnIeDcIgerx8EOlihH4DqybZ8WrHn0Rhpg56
 2BfskGzdNnlSKexvI0cgM8bt6n33azaisUaPXtN4HCGsb3CPQAOX/Q25nKZ+f0KL644I
 1/5w==
X-Gm-Message-State: ANhLgQ3AGJO6nkjBzr+xLcqKsEL7HdJzCki/aRL2y5LmC0RWPiu78AKC
 kP0e4+jRqV2C9LWu1hnw1zh3r0F1
X-Google-Smtp-Source: ADFU+vu7JD5n5sICoqftWbTQ4ZeCHGufsxTQNIK81mGarrTbhESYHiNuYxyAZ+/T1als/mPO+quyHA==
X-Received: by 2002:a7b:c159:: with SMTP id z25mr4306544wmi.102.1583939613617; 
 Wed, 11 Mar 2020 08:13:33 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id l17sm9794313wmg.23.2020.03.11.08.13.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Mar 2020 08:13:32 -0700 (PDT)
Subject: Re: [PATCH v5 1/4] drm/amdgpu/vcn: fix race condition issue for vcn
 start
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
 <1583939048-3354-1-git-send-email-James.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2094787f-8918-5d56-526e-fdbd60e2ee5a@gmail.com>
Date: Wed, 11 Mar 2020 16:13:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1583939048-3354-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: jamesz@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTEuMDMuMjAgdW0gMTY6MDQgc2NocmllYiBKYW1lcyBaaHU6Cj4gRml4IHJhY2UgY29uZGl0
aW9uIGlzc3VlIHdoZW4gbXVsdGlwbGUgdmNuIHN0YXJ0cyBhcmUgY2FsbGVkLgo+Cj4gdjI6IFJl
bW92ZWQgY2hlY2tpbmcgdGhlIHJldHVybiB2YWx1ZSBvZiBjYW5jZWxfZGVsYXllZF93b3JrX3N5
bmMoKQo+IHRvIHByZXZlbnQgcG9zc2libGUgcmFjZXMgaGVyZS4KPgo+IHYzOiBBZGQgdG90YWxf
c3VibWlzc2lvbl9jbnQgdG8gYXZvaWQgZ2F0ZSBwb3dlciB1bmV4cGVjdGVkbHkuCj4KPiB2NDog
UmVtb3ZlIGV4dHJhIGNvdW50ZXIgY2hlY2ssIGFuZCByZWR1Y2UgY291bnRlciBiZWZvcmUgaWRs
ZQo+IHdvcmsgc2NoZWR1bGUKPgo+IFNpZ25lZC1vZmYtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1
QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
Y24uYyB8IDIxICsrKysrKysrKysrKysrLS0tLS0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Zjbi5oIHwgIDIgKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0
aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdmNuLmMKPiBpbmRleCBhNDEyNzJmLi42ZGFjZjc4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+IEBAIC02Myw2ICs2Myw4IEBAIGludCBhbWRncHVfdmNu
X3N3X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJaW50IGksIHI7Cj4gICAK
PiAgIAlJTklUX0RFTEFZRURfV09SSygmYWRldi0+dmNuLmlkbGVfd29yaywgYW1kZ3B1X3Zjbl9p
ZGxlX3dvcmtfaGFuZGxlcik7Cj4gKwltdXRleF9pbml0KCZhZGV2LT52Y24udmNuX3BnX2xvY2sp
Owo+ICsJYXRvbWljX3NldCgmYWRldi0+dmNuLnRvdGFsX3N1Ym1pc3Npb25fY250LCAwKTsKPiAg
IAo+ICAgCXN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7Cj4gICAJY2FzZSBDSElQX1JBVkVOOgo+
IEBAIC0yMTAsNiArMjEyLDcgQEAgaW50IGFtZGdwdV92Y25fc3dfZmluaShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKPiAgIAl9Cj4gICAKPiAgIAlyZWxlYXNlX2Zpcm13YXJlKGFkZXYtPnZj
bi5mdyk7Cj4gKwltdXRleF9kZXN0cm95KCZhZGV2LT52Y24udmNuX3BnX2xvY2spOwo+ICAgCj4g
ICAJcmV0dXJuIDA7Cj4gICB9Cj4gQEAgLTMwNyw3ICszMTAsNyBAQCBzdGF0aWMgdm9pZCBhbWRn
cHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiAgIAkJ
ZmVuY2VzICs9IGZlbmNlW2pdOwo+ICAgCX0KPiAgIAo+IC0JaWYgKGZlbmNlcyA9PSAwKSB7Cj4g
KwlpZiAoIWZlbmNlcyAmJiAhYXRvbWljX3JlYWQoJmFkZXYtPnZjbi50b3RhbF9zdWJtaXNzaW9u
X2NudCkpIHsKPiAgIAkJYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCB0cnVlKTsKPiAgIAkJYW1k
Z3B1X2RldmljZV9pcF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwgQU1EX0lQX0JMT0NLX1RZ
UEVfVkNOLAo+ICAgCQkgICAgICAgQU1EX1BHX1NUQVRFX0dBVEUpOwo+IEBAIC0zMTksMTMgKzMy
MiwxNCBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKHN0cnVjdCB3
b3JrX3N0cnVjdCAqd29yaykKPiAgIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3VzZShzdHJ1
Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYgPSByaW5nLT5hZGV2Owo+IC0JYm9vbCBzZXRfY2xvY2tzID0gIWNhbmNlbF9kZWxheWVkX3dv
cmtfc3luYygmYWRldi0+dmNuLmlkbGVfd29yayk7Cj4gICAKPiAtCWlmIChzZXRfY2xvY2tzKSB7
Cj4gLQkJYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxzZSk7Cj4gLQkJYW1kZ3B1X2Rldmlj
ZV9pcF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwgQU1EX0lQX0JMT0NLX1RZUEVfVkNOLAo+
IC0JCSAgICAgICBBTURfUEdfU1RBVEVfVU5HQVRFKTsKPiAtCX0KPiArCWF0b21pY19pbmMoJmFk
ZXYtPnZjbi50b3RhbF9zdWJtaXNzaW9uX2NudCk7Cj4gKwljYW5jZWxfZGVsYXllZF93b3JrX3N5
bmMoJmFkZXYtPnZjbi5pZGxlX3dvcmspOwo+ICsKPiArCW11dGV4X2xvY2soJmFkZXYtPnZjbi52
Y25fcGdfbG9jayk7Cj4gKwlhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIGZhbHNlKTsKPiArCWFt
ZGdwdV9kZXZpY2VfaXBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsIEFNRF9JUF9CTE9DS19U
WVBFX1ZDTiwKPiArCSAgICAgICBBTURfUEdfU1RBVEVfVU5HQVRFKTsKPiAgIAo+ICAgCWlmIChh
ZGV2LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQT1JUX1ZDTl9EUEcpCXsKPiAgIAkJc3RydWN0IGRw
Z19wYXVzZV9zdGF0ZSBuZXdfc3RhdGU7Cj4gQEAgLTM0NSwxMCArMzQ5LDEzIEBAIHZvaWQgYW1k
Z3B1X3Zjbl9yaW5nX2JlZ2luX3VzZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4gICAKPiAg
IAkJYWRldi0+dmNuLnBhdXNlX2RwZ19tb2RlKGFkZXYsIHJpbmctPm1lLCAmbmV3X3N0YXRlKTsK
PiAgIAl9Cj4gKwltdXRleF91bmxvY2soJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7Cj4gICB9Cj4g
ICAKPiAgIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2VuZF91c2Uoc3RydWN0IGFtZGdwdV9yaW5nICpy
aW5nKQo+ICAgewo+ICsJYXRvbWljX2RlYygmcmluZy0+YWRldi0+dmNuLnRvdGFsX3N1Ym1pc3Np
b25fY250KTsKPiArCj4gICAJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZyaW5nLT5hZGV2LT52Y24u
aWRsZV93b3JrLCBWQ05fSURMRV9USU1FT1VUKTsKPiAgIH0KPiAgIAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdmNuLmgKPiBpbmRleCA2ZmUwNTczLi4xMTFjNGNjIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaAo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaAo+IEBAIC0yMDAsNiArMjAwLDgg
QEAgc3RydWN0IGFtZGdwdV92Y24gewo+ICAgCXN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqdmNu
X2RlY19zY2hlZFtBTURHUFVfTUFYX1ZDTl9JTlNUQU5DRVNdOwo+ICAgCXVpbnQzMl90CQkgbnVt
X3Zjbl9lbmNfc2NoZWQ7Cj4gICAJdWludDMyX3QJCSBudW1fdmNuX2RlY19zY2hlZDsKPiArCXN0
cnVjdCBtdXRleAkJIHZjbl9wZ19sb2NrOwo+ICsJYXRvbWljX3QJCSB0b3RhbF9zdWJtaXNzaW9u
X2NudDsKPiAgIAo+ICAgCXVuc2lnbmVkCWhhcnZlc3RfY29uZmlnOwo+ICAgCWludCAoKnBhdXNl
X2RwZ19tb2RlKShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
