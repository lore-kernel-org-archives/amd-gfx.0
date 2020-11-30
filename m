Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B67C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 20:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42304206ED
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 20:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QplBAxuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42304206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD2989F92;
	Mon, 30 Nov 2020 20:30:45 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B01189F92
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 20:30:44 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id b2so5935066edy.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 12:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=JECj/yI78zLpybMoiPFpuuYD6WHNkzOEgpRQR8Bqw5E=;
 b=QplBAxuNb8tSu7/S9fjqergQSUu7tu8mvPjn416wp1vXgflv/9rcNyzN9lrgAB9Mz0
 tUU1GO9NP13rERggWMoUtN9+NzAMrxKVVH8+ed2gSOFBRoTt/S9t8T3SEYVVQu1UrQQr
 92C5AuB56MfiwB6nT33W2sTJEWH9UvvekJrfciOLsBvEG92AAE0GSNrO3WSLwg90PQjQ
 /1UMWIok9B6BjimfSQ1oPp2fLqEhNQwFxZLTygFMqliodXiuiec3o/XFtSEYMwsgOtWq
 SD3PCMb0eB8KGoJgxyOLaT8bQvfnB08ntYm2wwQ9UeEnlP9FsYl/BiK+SUau+Zmp2jHF
 i1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=JECj/yI78zLpybMoiPFpuuYD6WHNkzOEgpRQR8Bqw5E=;
 b=Sh03iJecideZdjq8LdNWRZERyj9DvyEA8AuCAeaE3wUedgntwFJBHSjaxn46Bl0+J1
 ll2zAEhgv8i7DRjfSxj/09SZLmtl5YAPHhdcp8HEwaMutnIWd09LR2jtFt/N9w7h+gg5
 I9JIf4UMhliDjFH0fQAxq1toWt5akLdKCTxYnV+HAPv7Qp5U9OFUydqXK5/XSVaiWJj4
 J4d/bGLqCXHrhIbqiRboEEah5Xsr2xsq+een7qQSWBIWHOkPBAJTJFFbGMIxy3rG31wC
 rQs7YW0VtV9jWVmBI34DWGKz9sNa9dgJUFBCqHHAwGp7/JIvaR1g1khg7mN9cdgKNB1D
 x7bQ==
X-Gm-Message-State: AOAM531/edhhkTR409XpqFmma+ZitM4DvlMWpJdzTd48qX1WPwyuqnaa
 tILSivZ1oa+nw/RtwnShj+A=
X-Google-Smtp-Source: ABdhPJzkNYbTo792fBH6qKyrgHFHBMv+cTcsZRpf1jm/QUORWTC4F/QZBXg8/eOlX9wZ9m9UQHslmg==
X-Received: by 2002:aa7:cd84:: with SMTP id x4mr21303083edv.192.1606768242845; 
 Mon, 30 Nov 2020 12:30:42 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id dx10sm2737387ejb.35.2020.11.30.12.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Nov 2020 12:30:42 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: default noretry=0 for navi1x and newer (v2)
To: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201130192515.305306-1-alexander.deucher@amd.com>
 <9075d858-0008-2583-974d-08cc4ae31fed@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b0d69a06-e998-920f-986b-96d967105d07@gmail.com>
Date: Mon, 30 Nov 2020 21:30:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9075d858-0008-2583-974d-08cc4ae31fed@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMzAuMTEuMjAgdW0gMjA6NTIgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIwLTEx
LTMwIHVtIDI6MjUgcC5tLiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPj4gVGhlcmUgYXJlIG5vIHBl
cmZvcm1hbmNlIGFkdmFudGFnZXMgdG8gc2V0dGluZyBpdCB0byAxIGFuZAo+PiBpdCBjYXVzZXMg
c3RhYmlsaXR5IGlzc3VlcyBpbiBzb21lIGNhc2VzLgo+IFNlZSBteSBsYXRlciBlbWFpbCBvbiB0
aGUgb3RoZXIgdGhyZWFkLiBUaGVyZSB3YXMgYW5vdGhlciBjb25zaWRlcmF0aW9uCj4gYmVzaWRl
cyBwZXJmb3JtYW5jZS4gSXQgaGFkIHRvIGRvIHdpdGggcmV0cnkgZmF1bHQgaGFuZGxpbmcsIHdo
aWNoCj4gZGVwZW5kZWQgb24gYmVpbmcgYWJsZSB0byByZXJvdXRlIHRoZSBpbnRlcnJ1cHRzIHRv
IHRoZSBJSDEgcmluZywgd2hpY2gKPiB0aGUgc2VjdXJpdHkgcG9saWN5IGRvZXNuJ3QgYWxsb3cg
b24gbWFueSBib2FyZHMuIFdpdGggQ2hyaXN0aWFuJ3MKPiByZWNlbnQgY2hhbmdlcyB0byByZXJv
dXRlIHJldHJ5IGludGVycnVwdHMgdG8gYSBzb2Z0d2FyZSByaW5nLCB0aGlzCj4gZGVwZW5kZW5j
eSBpcyBnb25lIGFuZCBpdCBzaG91bGQgbm93IGJlIHNhZmUgdG8gZW5hYmxlIHJldHJ5IG9uIG1v
c3QgYm9hcmRzLgoKSXQncyBub3QgdGhlIGJlc3Qgc29sdXRpb24gZnJvbSBhIHBlcmZvcm1hbmNl
IHBvaW50IG9mIHZpZXcsIGJ1dCBpdCAKaW5kZWVkIHNlZW1zIHRvIGdldCB0aGluZ3Mgd29ya2lu
ZyBhcyBleHBlY3RlZC4KCj4KPgo+PiB2Mjogc2ltcGxpZnkgdGhlIGNvZGUKPj4KPj4gQnVnOiBo
dHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8xMzc0Cj4+IFNp
Z25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBS
ZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpSZXZp
ZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPgo+
Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyB8IDUg
LS0tLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNSBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+PiBpbmRleCBmZWRlODQ1MDlkYmMuLmIwN2M0
N2NhY2QyOCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dtYy5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+
PiBAQCAtNDIyLDExICs0MjIsNiBAQCB2b2lkIGFtZGdwdV9nbWNfbm9yZXRyeV9zZXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+ICAgCj4+ICAgCXN3aXRjaCAoYWRldi0+YXNpY190eXBl
KSB7Cj4+ICAgCWNhc2UgQ0hJUF9WRUdBMjA6Cj4+IC0JY2FzZSBDSElQX05BVkkxMDoKPj4gLQlj
YXNlIENISVBfTkFWSTE0Ogo+PiAtCWNhc2UgQ0hJUF9TSUVOTkFfQ0lDSExJRDoKPj4gLQljYXNl
IENISVBfTkFWWV9GTE9VTkRFUjoKPj4gLQljYXNlIENISVBfRElNR1JFWV9DQVZFRklTSDoKPj4g
ICAJCS8qCj4+ICAgCQkgKiBub3JldHJ5ID0gMCB3aWxsIGNhdXNlIGtmZCBwYWdlIGZhdWx0IHRl
c3RzIGZhaWwKPj4gICAJCSAqIGZvciBzb21lIEFTSUNzLCBzbyBzZXQgZGVmYXVsdCB0byAxIGZv
ciB0aGVzZSBBU0lDcy4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
