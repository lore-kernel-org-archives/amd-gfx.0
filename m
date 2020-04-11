Return-Path: <SRS0=mFKL=53=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00637C2BB85
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2020 09:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27272084D
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2020 09:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kidsYL9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27272084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DED66E2DA;
	Sat, 11 Apr 2020 09:50:34 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4FC46E2DA
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Apr 2020 09:50:33 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id e26so4686215wmk.5
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Apr 2020 02:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=jmD4OJMIg2Eu5myhnxXh0dywC1gIyskATniN6okPcaQ=;
 b=kidsYL9rJZFzsPwsYB8YONMMU+ihoSRq31jlEQ97Q5ZuJ41lssQRz9RQWdVLCZpUE9
 rS9NKG0MhA2VEZzvLzXQT3n7/kkMGjYgh+LKU4HajlFJoyI79NtfZSa6MqPZ0dM+2xGh
 6VZKka9nHByg+DnYncjINEIJWJvZq4FDNvUHPR0qD29Mrm12voCss+yS6zXRDjxyUldk
 olN+B4e4mZSTVm0B1RMkjR4786o6on8Ig/3esLj/ymDagPMhGv2jITJxU3LT346q8pYF
 HDkTNseT8T0DHC9Clex0tSUQiqlrQFW/qJHdwosexLtjIuKyprsGRSbZdKhYB5S8tWLb
 l3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=jmD4OJMIg2Eu5myhnxXh0dywC1gIyskATniN6okPcaQ=;
 b=KCWMqqS5Vjoww8L5CH0bcws25Wq6kgU5Kj43l4BAnQ20r4E1WhZR68/9LQIIHCaLw2
 R/E0Q53xvG14mpAVYitQJcx1x0vsptHN5CBrXMmxCs/Ewyj6abKoaYnpOflxR8qGP3bw
 GvvoYgpAdqBrsSS4KZrwZvGCAqyTh0uTbqVTw6o6UAAqgeQCbxKPeOn7NwqoQtC2dy0j
 /bWdlBLZD5Om7KgMgDGeHC8DB8NfHqj+DtdzhxzNaafrkGW2y4JgDoEQXZfoPDJrkzCs
 KHzuqcS0BQiRDlbnyTYQX3WXfD1+DK2ON7h/xsl9yXhYg7NfMCuTiaczdl0ICODmN2Am
 WRXQ==
X-Gm-Message-State: AGi0PuYsoHTfQZFX0kDWJgQLHikbEzlaHC0gt4R0yHguaKOV9Mok6gNK
 RPFr2eB/utT3Ea7rq/8Zpty/iszG
X-Google-Smtp-Source: APiQypLdNemzSXadXO/uX/q5YslkQy7T6CDPivwAzthBNE4hjBogPom9Tn+TYpmWUoltMHL3boIb0Q==
X-Received: by 2002:a1c:1bcb:: with SMTP id b194mr9651547wmb.4.1586598632009; 
 Sat, 11 Apr 2020 02:50:32 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id i97sm6786200wri.1.2020.04.11.02.50.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 11 Apr 2020 02:50:31 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: pass unlocked flag to params at
 amdgpu_vm_bo_update_mapping
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200410172829.8481-1-alex.sierra@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d8ff5bb4-1759-f6e7-2de9-beca5ab09a5e@gmail.com>
Date: Sat, 11 Apr 2020 11:50:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200410172829.8481-1-alex.sierra@amd.com>
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

QW0gMTAuMDQuMjAgdW0gMTk6Mjggc2NocmllYiBBbGV4IFNpZXJyYToKPiBQYXNzIHVubG9ja2Vk
IGZsYWcgdmFsdWUgdG8gYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMudW5sb2NrZWQKPiBzdHJ1Y3Qg
bWVtYmVyIGF0IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZy4KPgo+IFNpZ25lZC1vZmYtYnk6
IEFsZXggU2llcnJhIDxhbGV4LnNpZXJyYUBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDEgKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IGlu
ZGV4IDRjYTRmNjFiMzRjYS4uYWNjYmIzNGVhNjcwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtMTU5Myw2ICsxNTkzLDcgQEAgc3RhdGljIGludCBhbWRn
cHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJ
cGFyYW1zLnZtID0gdm07Cj4gICAJcGFyYW1zLmltbWVkaWF0ZSA9IGltbWVkaWF0ZTsKPiAgIAlw
YXJhbXMucGFnZXNfYWRkciA9IHBhZ2VzX2FkZHI7Cj4gKwlwYXJhbXMudW5sb2NrZWQgPSB1bmxv
Y2tlZDsKPiAgIAo+ICAgCS8qIEltcGxpY2l0bHkgc3luYyB0byBjb21tYW5kIHN1Ym1pc3Npb25z
IGluIHRoZSBzYW1lIFZNIGJlZm9yZQo+ICAgCSAqIHVubWFwcGluZy4gU3luYyB0byBtb3Zpbmcg
ZmVuY2VzIGJlZm9yZSBtYXBwaW5nLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
