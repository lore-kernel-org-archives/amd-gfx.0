Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1795C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 10:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A72421E92
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 10:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A72421E92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEDAA89B8F;
	Mon,  4 Jan 2021 10:30:06 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C066A89B8F;
 Mon,  4 Jan 2021 10:30:05 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id b73so26781089edf.13;
 Mon, 04 Jan 2021 02:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=jAhrbtwG+6ed+DNQFu7tc1nkJ8bzBT1BIhV7/2UdB10=;
 b=l04tFPwzaoF0zdTU7cz/VYnZwFenJvq+6H2844tIXzDoJXbZHx9j88yn0WiYBUYhyI
 g/5KR4LIhTq1qvXRadGko2OM2/rAf+Ay+PsNxYI380Z+19LFl5NaDvB9RDbf6HZO5j4L
 AikIzMyVojiH6DByDfdZBL5FdA+a49Juw87c8DkrcXzZANFiHQQma9UIU7a9+slbIxyy
 SuTcmRMAjsmmXMfwfZGQpgbrQ0tdwszPYruUQ4IEAvEQYsVwzU2Iv/cK1jByXbT3apvW
 0r0VCsrrO/BxiiAa1DXNGwd6OslZNm5FRle/SCeJugN1w1cBND9/p3IwNQ/pCMnYqq42
 e+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=jAhrbtwG+6ed+DNQFu7tc1nkJ8bzBT1BIhV7/2UdB10=;
 b=YWS0UvhzyhOb9O/GVYwwJ4D4pfUlkAvXXbSYbDEnXSjTvXWe+DwdTcwM8fGqs0XhbY
 JBju+MhaCkC9rA60Rt+tba1iQxbt54lFCi7l/gJKdXtoHaabP+zCQWZorWfJ5TceMDao
 MMN2uoGs67UNEQ9oZn8P5W1VcSfJTmOL+c2FY+xQFJ2NlM5ptwde4C5y1qdSdXN46/lg
 haTSgPFnFJHlO6w1a6NYksSZ0xfwZAQZG5tpaGCVnJFJfg8q/orrqIdlVt2zXusCCk1o
 G8kTSmM7tcGH7m8GROPABuRf+tOrGjl/OI5LYHH5acD1whhP2J+Wc+QmUj6MpkyfSpNK
 3m0Q==
X-Gm-Message-State: AOAM533p/9wMxHlsikgZtk1UbmrIb+3MR/cWP3AKvl8dRDjY10dsocIo
 nO+DSVMv/cVxNWtkPGFSVgpSHdqYWxY=
X-Google-Smtp-Source: ABdhPJxlAHsRyzbqfkpxBlPhMpweSghzFeOZhDyg/PLSiYniV5RQenWYKGpTMH1D6wgWLiQgPtj9VA==
X-Received: by 2002:a50:d552:: with SMTP id f18mr65083171edj.168.1609756204494; 
 Mon, 04 Jan 2021 02:30:04 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a20sm44145107edr.70.2021.01.04.02.30.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jan 2021 02:30:04 -0800 (PST)
Subject: Re: [PATCH] drm: Check actual format for legacy pageflip.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 dri-devel@lists.freedesktop.org
References: <20210102140235.514039-1-bas@basnieuwenhuizen.nl>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <70bdaf24-8a05-f28c-9cbf-6709a5e35c6b@gmail.com>
Date: Mon, 4 Jan 2021 11:30:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210102140235.514039-1-bas@basnieuwenhuizen.nl>
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
Cc: mario.kleiner.de@gmail.com, daniel.vetter@ffwll.ch, zhan.liu@amd.com,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 nicholas.kazlauskas@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMDEuMjEgdW0gMTU6MDIgc2NocmllYiBCYXMgTmlldXdlbmh1aXplbjoKPiBXaXRoIG1v
ZGlmaWVycyBvbmUgY2FuIGFjdHVhbGx5IGhhdmUgZGlmZmVyZW50IGZvcm1hdF9pbmZvIHN0cnVj
dHMKPiBmb3IgdGhlIHNhbWUgZm9ybWF0LCB3aGljaCBub3cgbWF0dGVycyBmb3IgQU1ER1BVIHNp
bmNlIHdlIGNvbnZlcnQKPiBpbXBsaWNpdCBtb2RpZmllcnMgdG8gZXhwbGljaXQgbW9kaWZpZXJz
IHdpdGggbXVsdGlwbGUgcGxhbmVzLgo+Cj4gSSBjaGVja2VkIG90aGVyIGRyaXZlcnMgYW5kIGl0
IGRvZXNuJ3QgbG9vayBsaWtlIHRoZXkgZW5kIHVwIHRyaWdnZXJpbmcKPiB0aGlzIGNhc2Ugc28g
SSB0aGluayB0aGlzIGlzIHNhZmUgdG8gcmVsYXguCj4KPiBTaWduZWQtb2ZmLWJ5OiBCYXMgTmll
dXdlbmh1aXplbiA8YmFzQGJhc25pZXV3ZW5odWl6ZW4ubmw+Cj4gRml4ZXM6IDgxNjg1M2Y5ZGM0
MCAoImRybS9hbWQvZGlzcGxheTogU2V0IG5ldyBmb3JtYXQgaW5mbyBmb3IgY29udmVydGVkIG1l
dGFkYXRhLiIpCgpJIGRvbid0IGtub3cgdGhlIGRldGFpbHMgb2YgdGhlIGNvZGUgYXQgYWxsLCBi
dXQgZnJvbSBhIGhpZ2ggbGV2ZWwgcG9pbnQgCm9mIHZpZXcgdGhhdCBtYWtlcyBtdWNoIG1vcmUg
c2Vuc2UgdGhhbiB0aGUgb3JpZ2luYWwgcGF0Y2guCgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9k
cm1fcGxhbmUuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fcGxhbmUuYyBi
L2RyaXZlcnMvZ3B1L2RybS9kcm1fcGxhbmUuYwo+IGluZGV4IGU2MjMxOTQ3Zjk4Ny4uZjUwODU5
OTBjZmFjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fcGxhbmUuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9kcm1fcGxhbmUuYwo+IEBAIC0xMTYzLDcgKzExNjMsNyBAQCBpbnQg
ZHJtX21vZGVfcGFnZV9mbGlwX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCj4gICAJaWYg
KHJldCkKPiAgIAkJZ290byBvdXQ7Cj4gICAKPiAtCWlmIChvbGRfZmItPmZvcm1hdCAhPSBmYi0+
Zm9ybWF0KSB7Cj4gKwlpZiAob2xkX2ZiLT5mb3JtYXQtPmZvcm1hdCAhPSBmYi0+Zm9ybWF0LT5m
b3JtYXQpIHsKPiAgIAkJRFJNX0RFQlVHX0tNUygiUGFnZSBmbGlwIGlzIG5vdCBhbGxvd2VkIHRv
IGNoYW5nZSBmcmFtZSBidWZmZXIgZm9ybWF0LlxuIik7Cj4gICAJCXJldCA9IC1FSU5WQUw7Cj4g
ICAJCWdvdG8gb3V0OwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
