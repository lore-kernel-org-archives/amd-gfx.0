Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4FCC33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 20:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F4C2072C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 20:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgyoCWME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F4C2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB036E511;
	Mon,  6 Jan 2020 20:22:53 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 982036E511
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 20:22:51 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id t2so51232523wrr.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 12:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=RmPvYiRS1tz+XK4F4YlZP0GeIE6s8y/fsQjO8vHleT8=;
 b=NgyoCWMEBCpczC0w5hjivN0L5NbUd5+T78YD38eZ+ifiyrye+hC7dX9eSMIdSq7GB+
 uGMXae1hoHTzBVEKgDV18TTNmtLyhlaoZKGAZSw3Uo9nJqwXFpBXLhjzzWSatOaSo16T
 Yee5bWzPn131tK8TMwHR5Sv8gIFriSN4PTc9Bu3y3JQLG7TlYICGFokqo8MLGQLPERvY
 k1e3+4quvhhW/WyQlV+xxp/ceZiL+rlo/H8x97dzeW0P12oFBOrEN+3N/q13A8dbc1wO
 C1babh7xMpzPvEHqcF4C4ZK8dNz7CCk7fuW5GBXj9+DpMZx8XSMpTbj67uUZMw6/QAET
 uhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=RmPvYiRS1tz+XK4F4YlZP0GeIE6s8y/fsQjO8vHleT8=;
 b=CYp0ZvGvDwKjFpprFTTF2b2q6dBrfjyKcEMHLkQPfK9TnJQSAnLWhBNuv/GmPJEvgE
 rle7ub87HdOBXlpMoMSumEDidz/vwhNCY6D4QaoIHvsHOvCf+MPZ6bEm7DoVetpNvUnx
 0m3WbvoCMhDaYMktKrcaTHRDOVL/bRqeFgEkFrcwcfYaBonaKODGqfB+Pfc6pSKNAdwf
 9Rw3saifLPvwiUj88KCNuOt4RRwkPnyctKEC3XqQu97h9ckhuhSzAO3nrJhJwkMgnVVq
 vpFVhLuS4ex7SAzQKey6bv9kmkS3XHg8/BYXACqssFLJK8kZZv8Id/iEEPE8bk2PsU6/
 M74g==
X-Gm-Message-State: APjAAAXZP3GwbL5doYmjsDF/jlaGG74QvPBwjgydwCTthsKSRfdJeqto
 tBgcT5MoHXCsAuAdhNH0zzWD6+UM
X-Google-Smtp-Source: APXvYqwHt/BWqYk9Et079cBm3v+mnwTEr1pG8S3niB+2m3qGV8h78tZryCeOvGik4wZnEuSxFe0WdA==
X-Received: by 2002:adf:db41:: with SMTP id f1mr107679098wrj.392.1578342170334; 
 Mon, 06 Jan 2020 12:22:50 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id x17sm73641194wrt.74.2020.01.06.12.22.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jan 2020 12:22:49 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu/gfx: simplify old firmware warning
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200106195842.716709-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6227abb8-c16f-11a0-6598-54495a551ed2@gmail.com>
Date: Mon, 6 Jan 2020 21:22:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200106195842.716709-1-alexander.deucher@amd.com>
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

QW0gMDYuMDEuMjAgdW0gMjA6NTggc2NocmllYiBBbGV4IERldWNoZXI6Cj4gUHV0IGl0IG9uIG9u
ZSBsaW5lIHRvIGF2b2lkIHdoaXRlc3BhY2UgaXNzdWVzIHdoZW4KPiBwcmludGluZyBpbiB0aGUg
bG9nLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAu
YyB8IDMgKy0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jICB8IDMg
Ky0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gaW5kZXggNWIwNTMzNGEy
NTQ4Li4zNzllNDZjMWI3ZjYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMF8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEw
XzAuYwo+IEBAIC01NzcsOCArNTc3LDcgQEAgc3RhdGljIHZvaWQgZ2Z4X3YxMF8wX2NoZWNrX2Z3
X3dyaXRlX3dhaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJfQo+ICAgCj4gICAJ
aWYgKGFkZXYtPmdmeC5jcF9md193cml0ZV93YWl0ID09IGZhbHNlKQo+IC0JCURSTV9XQVJOX09O
Q0UoIldhcm5pbmc6IGNoZWNrIGNwX2Z3X3ZlcnNpb24gYW5kIHVwZGF0ZSBpdCB0byByZWFsaXpl
IFwKPiAtCQkJICAgICAgR1JCTSByZXF1aXJlcyAxLWN5Y2xlIGRlbGF5IGluIGNwIGZpcm13YXJl
XG4iKTsKPiArCQlEUk1fV0FSTl9PTkNFKCJDUCBmaXJtd2FyZSB2ZXJzaW9uIHRvbyBvbGQsIHBs
ZWFzZSB1cGRhdGUhIik7Cj4gICB9Cj4gICAKPiAgIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYwo+IGluZGV4IDM1Mzg0ZjU0MzY2NC4uMWNhZTM1NmIxYWUwIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gQEAgLTk4OCw4ICs5ODgsNyBAQCBzdGF0
aWMgdm9pZCBnZnhfdjlfMF9jaGVja19md193cml0ZV93YWl0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQo+ICAgCSAgICAoYWRldi0+Z2Z4Lm1lY19mZWF0dXJlX3ZlcnNpb24gPCA0NikgfHwK
PiAgIAkgICAgKGFkZXYtPmdmeC5wZnBfZndfdmVyc2lvbiA8IDB4MDAwMDAwYjcpIHx8Cj4gICAJ
ICAgIChhZGV2LT5nZngucGZwX2ZlYXR1cmVfdmVyc2lvbiA8IDQ2KSkKPiAtCQlEUk1fV0FSTl9P
TkNFKCJXYXJuaW5nOiBjaGVjayBjcF9md192ZXJzaW9uIGFuZCB1cGRhdGUgaXQgdG8gcmVhbGl6
ZSBcCj4gLQkJCSAgICAgIEdSQk0gcmVxdWlyZXMgMS1jeWNsZSBkZWxheSBpbiBjcCBmaXJtd2Fy
ZVxuIik7Cj4gKwkJRFJNX1dBUk5fT05DRSgiQ1AgZmlybXdhcmUgdmVyc2lvbiB0b28gb2xkLCBw
bGVhc2UgdXBkYXRlISIpOwo+ICAgCj4gICAJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKPiAg
IAljYXNlIENISVBfVkVHQTEwOgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
