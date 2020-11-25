Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21156C5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 13:16:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95395206E5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 13:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If0D5tnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95395206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 217F26E3BB;
	Wed, 25 Nov 2020 13:16:05 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B13766E3BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 13:16:03 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id o9so2983749ejg.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 05:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=HZEEXwXXrKpbJJjVMVqAfFqxjN4ZzLeJuayN89Gm6SY=;
 b=If0D5tnhSfXyRxWizYWAIlJGMuqtYVziLZv0VNq0k4LoKUq6TvxYLM8ks8E7ppJaxZ
 zv4/61upyzPxcZNsVETtb16bPPFiio8qxUqVrhokQNHcGUJGy09uedcSppkf8fnfkD0s
 eNBsx938TCNd0X6dhmdBnTfsCdIN9DABQOj/CMv9AVxr+6J16CV8tOQTdTcALlHebBp7
 jdODDVMJJAlvo715yqGClfTFiQhlBhCCW5WKMBonyOYHJKAquGul+Z33NKP9QlCl7sj8
 2RjS7UxciiJkuzSuvEdUevK8n56DNSpyPpCRVKKTdl6Z8mTqA9Nxo+X67a4lv9RrQbbG
 H9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=HZEEXwXXrKpbJJjVMVqAfFqxjN4ZzLeJuayN89Gm6SY=;
 b=t7x8QsEJbXmo7QqcHK5keGOEYvCXb8eKM671HhGAYiXj59dNqAP1WEPaWY7nF1zlZm
 EVleIl9rP4FZlCFCGsbvHODRAKjY2lLDS5C4+k9qtwGNvFoespiqPDzfG51/V/EDnfVC
 EeIKTy4U5XfxEWUmrkXugASnnYaimdoMc2wWF+SPaOp2hcGJfhOJxNmDftp+GjSj8NlP
 UgWsVKqtHE71d5VLIixAvFx7OeibtoY+X199jLFYTnpiyCTE22nkHHECqWohfka4QDpg
 TiVSeZp1UmNvB6ungHfLBDZiThnS4R+9gBxhpwjX/snKwSwCC8flAOnlJiRiWP4rfRsG
 zBrQ==
X-Gm-Message-State: AOAM5323kwpNJyjKrDib52ekmjbC3GF9/sYaaMk9MdXpSxCS5cAKq2eg
 9wC1ijaYjh7EJxL+JaCa7ps=
X-Google-Smtp-Source: ABdhPJwYJrXfMwzUsiT52OCmLsYpp193fvnbfduiUcs5ZNKIHYg/RGVxuYeERLhSYcMjtsNcRDoKsA==
X-Received: by 2002:a17:906:46d5:: with SMTP id
 k21mr3005103ejs.495.1606310162353; 
 Wed, 25 Nov 2020 05:16:02 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id f24sm1022232ejf.117.2020.11.25.05.16.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2020 05:16:01 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: increase reserved VRAM size to 8MB
To: Likun Gao <likun.gao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201125131203.224292-1-likun.gao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f9ed9ccb-bce5-9b14-0c82-60d5dde7a12f@gmail.com>
Date: Wed, 25 Nov 2020 14:15:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201125131203.224292-1-likun.gao@amd.com>
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
Cc: Hawking Zhang <hawking.zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjUuMTEuMjAgdW0gMTQ6MTIgc2NocmllYiBMaWt1biBHYW86Cj4gRnJvbTogTGlrdW4gR2Fv
IDxMaWt1bi5HYW9AYW1kLmNvbT4KPgo+IDRNQiByZXNlcnZlZCBWUkFNIHNpemUgd2hpY2ggdXNl
ZCBmb3IgcGFnZSB0YWJsZXMgd2FzIG5vdCBlbm91Z2ggZm9yCj4gc29tZSBjb25kaXRpb24sIGlu
Y3JlYXNlIGl0IHRvIDhNQiB0byByZWR1Y2UgcGFnZSB0YWJsZSBjb250ZW50aW9uLgoKV2hhdCdz
IHRoZSB1c2UgY2FzZSBoZXJlPyA4TUIgaXMgYWxyZWFkeSBwcmV0dHkgZXh0ZW5zaXZlLCBJIGRv
bid0IHdhbnQgCnRvIHJ1biBpbnRvIHByb2JsZW1zIHdpdGggQVBVcy4KCj4gU2lnbmVkLW9mZi1i
eTogTGlrdW4gR2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4KPiBDaGFuZ2UtSWQ6IEliYmMwYzE0YTc1
YmQwZTU3ZDc3ZTMwYjcxNDBhMTQ0ZjQwMzAxMTRhCgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uaAo+IGluZGV4IGZhN2QxODE5MzRlNS4uMWVkMTMwZDUxOGEwIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKPiBAQCAtMTA0LDcgKzEwNCw3IEBAIHN0cnVj
dCBhbWRncHVfYm9fbGlzdF9lbnRyeTsKPiAgICNkZWZpbmUgQU1ER1BVX1ZNX0ZBVUxUX1NUT1Bf
QUxXQVlTCTIKPiAgIAo+ICAgLyogUmVzZXJ2ZSA0TUIgVlJBTSBmb3IgcGFnZSB0YWJsZXMgKi8K
PiAtI2RlZmluZSBBTURHUFVfVk1fUkVTRVJWRURfVlJBTQkJKDRVTEwgPDwgMjApCj4gKyNkZWZp
bmUgQU1ER1BVX1ZNX1JFU0VSVkVEX1ZSQU0JCSg4VUxMIDw8IDIwKQo+ICAgCj4gICAvKiBtYXgg
bnVtYmVyIG9mIFZNSFVCICovCj4gICAjZGVmaW5lIEFNREdQVV9NQVhfVk1IVUJTCQkJMwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
