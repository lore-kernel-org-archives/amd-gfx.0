Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072A5C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 18:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B1F21835
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 18:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDeR80YA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B1F21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F8036F876;
	Wed, 22 Jan 2020 18:52:30 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 045256F876
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 18:52:28 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id p9so187468wmc.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 10:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=4bEW5Z3QZysd09mlynMbOL2DZxv5p1pctJua4Q+b7B4=;
 b=rDeR80YA05th7FPF2MkRP5XAyyhjuUuTOnQ1U7DEBHT9HXKvIqjxUC0Kv32gAd7EXE
 B8Z6HIfzDBLBDXhYxCXiebJsKT2qgPPWS/WiGX7OjHNouIeDv/dirD23tBAtUknHwDBY
 kG8Wrg2Uz1NVjQTcTWDjal9DcpHbcZGLPQz6N3Tfunz6x/4kypaEZrpwO93ChtXxmBBz
 OWidu8px33AFcXiJpjJOSmkO7fdHTdoIpLutgk8FYd8+UvMSRLK6Q9a3PS/8ui9RMDpM
 HMm+VWl0+ArrSf5WintXQnAe78EW3UhPuHEyNARSjfsDb8yl01L/VvNFNXx95JEKE+ff
 aPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=4bEW5Z3QZysd09mlynMbOL2DZxv5p1pctJua4Q+b7B4=;
 b=gnD5pQHnw2fjGsbcNNo1U7ym4ievThGN0tYe9GUkDmjDUy59UFoElQYPLQNbqGakFn
 2gfg52yUnBR+/2TfA8AOqEcgI6DzjohLpy3JQSs2SN/uIymau/Ymr1g/ffoT8fpk+hpy
 A0cVm7/A7N7GLMYP0tIUX9asDOJ7DXUGTyrYqpDFH0I5TEg2l5/Dgd4sEGtFOcagqf6Q
 jzYHmZlQrcewFmXLkQdTg4PO/YH7dK+I/0kFcymAB82/sKrSouA1JKVRFpzmb+z3BjkA
 e2ODxMUkzHS972VpHecC0oRS8TRGIcnda0zkN4wXiQBtcCazWLqpphvbPt/nJgb4B/27
 /BYg==
X-Gm-Message-State: APjAAAXpHqcUPWN4sR3Hsbjy8bqg0FawS1Quu32uElUHp+K8oinU/h/k
 883SW/OOlpUC/FJ7UCq860yBJ15H
X-Google-Smtp-Source: APXvYqzX+FTkDWX8xJKPenor5UEmuh7W7nH5YLlYbtWUzqca+EIBM4Roj97UTt7ySV6Ct6J4enGBgA==
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr4572738wma.177.1579719147441; 
 Wed, 22 Jan 2020 10:52:27 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id k16sm60971920wru.0.2020.01.22.10.52.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 Jan 2020 10:52:26 -0800 (PST)
Subject: Re: [PATCH 1/2] drm/amdgpu: return EINVAL instead of ENOENT in the VM
 code
To: Luben Tuikov <luben.tuikov@amd.com>, tom.stdenis@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20200122140303.14411-1-christian.koenig@amd.com>
 <816d058c-cd19-a6c0-fe50-4fc84646c94a@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ce959351-cbb0-be90-a955-96c8c7a9e633@gmail.com>
Date: Wed, 22 Jan 2020 19:52:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <816d058c-cd19-a6c0-fe50-4fc84646c94a@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjIuMDEuMjAgdW0gMTk6MTEgc2NocmllYiBMdWJlbiBUdWlrb3Y6Cj4gRG8gd2UgaGF2ZSB1
c2VyLXNwYWNlL2xpYnMgcmVseSBvbiB0aGlzIGVycm5vIGluIHBhcnRpY3VsYXI/CgpObywgdXNl
cnNwYWNlIGNhbid0IGV2ZW4gZGlyZWN0bHkgY2FsbCB0aGlzIGZ1bmN0aW9uLgoKVGhlIHByb2Js
ZW0gd2FzIHJhdGhlciB0aGF0IGR1cmluZyBkZWJ1Z2dpbmcgSSBjYWxsZWQgdGhlIGZ1bmN0aW9u
IHdpdGggCmZpeGVkIHBhcmFtZXRlcnMgYW5kIHdvbmRlcmVkIGZvciBxdWl0ZSBhIHdoaWxlIHdo
eSBpdCBjYW4ndCBmaW5kIHRoZSAKdGFibGUgaW4gdGhlIHRyZWUgc3RydWN0dXJlLgoKVHVybmVk
IG91dCB0aGF0IHRoZSB0YWJsZSB3YXMgcGVyZmVjdGx5IGZpbmUsIGJ1dCBteSBwYXJhbWV0ZXJz
IGhhZCBhIDAgCnRvIG11Y2ggYW5kIHNvIHdhcyBvdXRzaWRlIG9mIHRoZSB2YWxpZCByYW5nZS4K
ClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBPbiAyMDIwLTAxLTIyIDk6MDMgYS5tLiwgQ2hyaXN0
aWFuIEvDtm5pZyB3cm90ZToKPj4gVGhhdCB3ZSBjYW4ndCBmaW5kIGEgUEQgYWJvdmUgdGhlIHJv
b3QgaXMgZXhwZWN0ZWQgY2FuIG9ubHkgaGFwcGVuIGlmCj4+IHdlIHRyeSB0byB1cGRhdGUgYSBs
YXJnZXIgcmFuZ2UgdGhhbiBhY3R1YWxseSBtYW5hZ2VkIGJ5IHRoZSBWTS4KPj4KPj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+PiAt
LS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDIgKy0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gaW5kZXggNWNiMTgyMjMxZjVkLi44
MTE5ZjMyY2E5NGQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
Cj4+IEBAIC0xNDc1LDcgKzE0NzUsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRl
cyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKPj4gICAJCQkgKiBzaGlm
dCB3ZSBzaG91bGQgZ28gdXAgb25lIGxldmVsIGFuZCBjaGVjayBpdCBhZ2Fpbi4KPj4gICAJCQkg
Ki8KPj4gICAJCQlpZiAoIWFtZGdwdV92bV9wdF9hbmNlc3RvcigmY3Vyc29yKSkKPj4gLQkJCQly
ZXR1cm4gLUVOT0VOVDsKPj4gKwkJCQlyZXR1cm4gLUVJTlZBTDsKPj4gICAJCQljb250aW51ZTsK
Pj4gICAJCX0KPj4gICAKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
