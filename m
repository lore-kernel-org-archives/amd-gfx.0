Return-Path: <SRS0=Eo1a=4F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B3CC3B185
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 11:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 672802070B
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 11:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaVGB1cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672802070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B7E6E920;
	Mon, 17 Feb 2020 11:06:54 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 664376E920
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2020 11:06:53 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id p17so17965275wma.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2020 03:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=uzwmR8jOU1vNlOh6DVVnEky67K92y/AaMIhJtMU1Ygc=;
 b=TaVGB1cz++ATeOCfi75KH02KGog3P13yax4Q0ygSJORUlGl+xfddkfSH9NZ/AgTFNb
 IoCKisDuS6H+IBm3/w6N4BnFXss32pZ2HXZrHr0yHtDJKmX3yAU2zxvOyPOWGjbOlFYY
 3D0dpiDa/wTOixLYRz38t3JEkqfgxEHMkOQtvuoIHDCpQMbOa8zmq29EckdV1jyKTbWN
 h5amDQ5UMDczcP8eV4s7qEQ6EJ3sRDm9vuuwbFndGzcRM7hK5d+OSlNK3uvotLWyXU42
 qeC9Mqnyl5ukIPgfodeu1JNJVX5pPvNLvLtNZSxMorsE3i2sWAzJBmNpc6fgKpFq54T9
 sJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=uzwmR8jOU1vNlOh6DVVnEky67K92y/AaMIhJtMU1Ygc=;
 b=pDFZj9QUhliMAwBvquqxd8itz+7wI0c5cAruAl25dXVA01ZCqW2ooxQHuw3pbW+Elh
 Pg8zihsrFzpWsZKMG2Tfhx44GhwGwFxihB5wT50SEyYY92RSZb88gbpAPz90K8kX/XIH
 J8rlDyxzUafszPbhrOeLVyuDsjR7e6baL4b3lh/3isVkOPQavj7ND5SnK+vcIeuyyg5X
 yKGOwrwLF3yr0J4YGN/14M7yh9VVtY2z5acGFPkldZExIjOKak4vpslgRyGZkWXHZzZZ
 RB+ZQXC2qKp020P5s0cMVeiguxVigSq8GXQat2CkHro7AXy0Kq7InFh+mh9Zm0Ju+sYd
 Rdmg==
X-Gm-Message-State: APjAAAXF1hiolzPhRDuILBcxCFrLuAwuJtskKJVrKRLXcbgI0CAX+HtK
 x0qXn8T1hP1x1OcS5N1M0YsQ4P4K
X-Google-Smtp-Source: APXvYqycQYLBVJnULxVay2VgjAdiJqIJhOMows/VmFqYGKDhw2hJ9s3suyKCV5IpW07hzEyHKtYwpw==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr20701525wmi.149.1581937611733; 
 Mon, 17 Feb 2020 03:06:51 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t12sm405180wrq.97.2020.02.17.03.06.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Feb 2020 03:06:50 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: drop the non-sense firmware version check on
 arcturus
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200217103236.23783-1-evan.quan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b090e0fa-5faa-626f-49bc-995b9351b898@gmail.com>
Date: Mon, 17 Feb 2020 12:06:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200217103236.23783-1-evan.quan@amd.com>
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

QW0gMTcuMDIuMjAgdW0gMTE6MzIgc2NocmllYiBFdmFuIFF1YW46Cj4gQXMgdGhlIGZpcm13YXJl
IHZlcnNpb25zIG9mIGFyY3R1cnVzIGFyZSBkaWZmZXJlbnQgZnJvbSBvdGhlciBnZng5Cj4gQVNJ
Q3MuIEFuZCB0aGUgd2FybmluZygiQ1AgZmlybXdhcmUgdmVyc2lvbiB0b28gb2xkLCBwbGVhc2Ug
dXBkYXRlISIpCj4gY2F1c2VkIGJ5IHRoaXMgY2hlY2sgY2FuIGJlIGVsaW1pbmF0ZWQuCj4KPiBD
aGFuZ2UtSWQ6IEkwNGFiMGU0MzViNmZmOTcxMmJlNTAyZTZlYmI4ZDZlMWYwYTc3NmQ4Cj4gU2ln
bmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KCkFja2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyB8IDUgKysrLS0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV8wLmMKPiBpbmRleCA5YjdmZjc4M2U5YTUuLjFjN2ExNmI5MTY4NiAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+IEBAIC0xMTA2LDEwICsxMTA2
LDExIEBAIHN0YXRpYyB2b2lkIGdmeF92OV8wX2NoZWNrX2Z3X3dyaXRlX3dhaXQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJYWRldi0+Z2Z4Lm1lX2Z3X3dyaXRlX3dhaXQgPSBmYWxz
ZTsKPiAgIAlhZGV2LT5nZngubWVjX2Z3X3dyaXRlX3dhaXQgPSBmYWxzZTsKPiAgIAo+IC0JaWYg
KChhZGV2LT5nZngubWVjX2Z3X3ZlcnNpb24gPCAweDAwMDAwMWE1KSB8fAo+ICsJaWYgKChhZGV2
LT5hc2ljX3R5cGUgIT0gQ0hJUF9BUkNUVVJVUykgJiYKPiArCSAgICAoKGFkZXYtPmdmeC5tZWNf
ZndfdmVyc2lvbiA8IDB4MDAwMDAxYTUpIHx8Cj4gICAJICAgIChhZGV2LT5nZngubWVjX2ZlYXR1
cmVfdmVyc2lvbiA8IDQ2KSB8fAo+ICAgCSAgICAoYWRldi0+Z2Z4LnBmcF9md192ZXJzaW9uIDwg
MHgwMDAwMDBiNykgfHwKPiAtCSAgICAoYWRldi0+Z2Z4LnBmcF9mZWF0dXJlX3ZlcnNpb24gPCA0
NikpCj4gKwkgICAgKGFkZXYtPmdmeC5wZnBfZmVhdHVyZV92ZXJzaW9uIDwgNDYpKSkKPiAgIAkJ
RFJNX1dBUk5fT05DRSgiQ1AgZmlybXdhcmUgdmVyc2lvbiB0b28gb2xkLCBwbGVhc2UgdXBkYXRl
ISIpOwo+ICAgCj4gICAJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
