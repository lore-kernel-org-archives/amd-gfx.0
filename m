Return-Path: <SRS0=dnVN=F7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626ECC433E0
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Dec 2020 09:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6DB207AB
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Dec 2020 09:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6DB207AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59BFA895C8;
	Sun, 27 Dec 2020 09:38:42 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D020E895C8
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Dec 2020 09:38:40 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id c5so7865203wrp.6
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Dec 2020 01:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=IT/f2zx/XApAI9z1fzkiv5FwnGTd6NliJ+KOL+a/iKk=;
 b=okUcbM0kE+lpFBtrc2u2qRWfbZjvW02ULIQHXMjUQI/Ksu1UbryyZ9n6lUYvBvnbWv
 j+gj3QJ8sa8hJUTKWaTr56YeB6ugu7vsGPYhb1BB7r5SYcPKdSKisvzGhYTzZEi7qtLK
 /ER9KnX9zUa0QcJXNRNMDfG2L1XTf27g+f11XEvRdqRnTS9dLyn3nGeiqnR586ihuzut
 pN7nMXNXczI4V/0yEJcEIEXal9iBjllTZbSvf2P0HcpOYZkQ1a11DVCxVVUCZ+tWS5Yd
 u5Tb+LL4CmL9mT06JhY2+dBLWCYW9/N+dWYWLTnf2i+n7t7qeyjFAv9tsVsqfE6RLpet
 JSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=IT/f2zx/XApAI9z1fzkiv5FwnGTd6NliJ+KOL+a/iKk=;
 b=adTBJsYqiVPCZq9ppk43n8Vg31SYj9z5TCkihDU2oCgMiYkorPGtu3fuypZAhItNSf
 +Q5JEa7tL/62KfnYLLkOHz95PcwKAjGdvLq8lFF1dxlCbYzqa5FVuu6U7+UYZQKofG0s
 otfxY0Ky3hNjAW8V2hjGOfnfVWDUxIdMtxb28ZM8CFUHiBcAU39zaRoZbdHP0vMETG0Y
 +YDOsf0O0G3nZWurLf+IoumQrrsgNSHzNv9c9nXbSKF42dUzlYFln+UYzChkg3XGIuNG
 ophRPgMYrbrbLgaFzTtIo2pdDdrkb5Y4SwfcWXDZ64L9zZUn7nsdTXyH6C2FQqnXEPR4
 LKxA==
X-Gm-Message-State: AOAM533BE710OoahQkbdPqeyKYuBAyUk4e5/gB6PgfQ3J81qjb6gbUA2
 5Qa3KEPVs6Z3Fru7ockD6tA=
X-Google-Smtp-Source: ABdhPJwI8wZci+yYa7bzRW+Nfw4r+0Y4EdO6BGUDjDHiiZJu/NOxTid+qCqvHJ/mr5EsjA1veuuF1A==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr46146482wrv.37.1609061919526; 
 Sun, 27 Dec 2020 01:38:39 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id g192sm15039064wme.48.2020.12.27.01.38.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Dec 2020 01:38:38 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Fix macro name _AMDGPU_TRACE_H_ in
 preprocessor if condition
To: Paul Menzel <pmenzel@molgen.mpg.de>, Chenyang Li <lichenyang@loongson.cn>
References: <20201226085607.155289-1-lichenyang@loongson.cn>
 <1898b3da-9958-ebd9-dc58-26168ee67653@molgen.mpg.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9dd7dbb4-cea0-da1d-042c-a2b5e69ef1bd@gmail.com>
Date: Sun, 27 Dec 2020 10:38:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1898b3da-9958-ebd9-dc58-26168ee67653@molgen.mpg.de>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Chen Guchun <Guchun.Chen@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjYuMTIuMjAgdW0gMTQ6MTYgc2NocmllYiBQYXVsIE1lbnplbDoKPiBEZWFyIOadjuaZqOmY
sywKPgo+Cj4gQW0gMjYuMTIuMjAgdW0gMDk6NTYgc2NocmllYiBDaGVueWFuZyBMaToKPj4gQWRk
IGFuIHVuZGVyc2NvcmUgaW4gYW1kZ3B1X3RyYWNlLmggbGluZSAyNCAiX0FNREdQVV9UUkFDRV9I
Ii4KPj4KPj4gRml4ZXM6IGQzOGNlYWY5OWVkMCAoImRybS9hbWRncHU6IGFkZCBjb3JlIGRyaXZl
ciAodjQpIikKCldlbGwgdGhpcyBGaXhlcyB0YWcgaXMgc3VwZXJmbHVvdXMvbWlzbGVhZGluZyBh
bmQgc2hvdWxkIHByb2JhYmx5IGJlIApyZW1vdmVkLgoKV2h5IHdhcyB0aGF0IGFkZGVkPwoKQ2hy
aXN0aWFuLgoKPj4gU2lnbmVkLW9mZi1ieTogQ2hlbnlhbmcgTGkgPGxpY2hlbnlhbmdAbG9vbmdz
b24uY24+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJh
Y2UuaCB8IDIgKy0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdHJhY2UuaCAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2Uu
aAo+PiBpbmRleCBlZTk0ODBkMTRjYmMuLjg2Y2ZiM2Q1NTQ3NyAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPj4gQEAgLTIxLDcgKzIxLDcgQEAKPj4g
wqDCoCAqCj4+IMKgwqAgKi8KPj4gwqAgLSNpZiAhZGVmaW5lZChfQU1ER1BVX1RSQUNFX0gpIHx8
IGRlZmluZWQoVFJBQ0VfSEVBREVSX01VTFRJX1JFQUQpCj4+ICsjaWYgIWRlZmluZWQoX0FNREdQ
VV9UUkFDRV9IXykgfHwgZGVmaW5lZChUUkFDRV9IRUFERVJfTVVMVElfUkVBRCkKPj4gwqAgI2Rl
ZmluZSBfQU1ER1BVX1RSQUNFX0hfCj4+IMKgIMKgICNpbmNsdWRlIDxsaW51eC9zdHJpbmdpZnku
aD4KPgo+IFJldmlld2VkLWJ5OiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPgo+
Cj4KPiBLaW5kIHJlZ2FyZHMsCj4KPiBQYXVsCj4KPgo+IFBTOiBOZXh0IHRpbWUsIGZvciBwYXRj
aCBpdGVyYXRpb25zLCB5b3Ugc2hvdWxkIGluY2x1ZGUgdGhlIHZlcnNpb24gaW4gCj4gdGhlIHRh
ZzogUEFUQ0ggdjIuIFRoZSBzd2l0Y2ggYC12YCAoYC0tcmVyb2xsLWNvdW50YCkgaGVscHMgd2l0
aCB0aGF0Ogo+Cj4gwqDCoMKgIGdpdCBmb3JtYXQtcGF0Y2ggLTEgLXYgMgo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxp
c3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
