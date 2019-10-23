Return-Path: <SRS0=+G2B=YQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE629CA9EB6
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 12:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F74214B2
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 12:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F74214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889236EA7D;
	Wed, 23 Oct 2019 12:39:02 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C0BD6EA7D
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 12:39:01 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id s1so13162512wro.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 05:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=qSGApLGus4H1I7hduVHaPRCKsjFwV8jn8V/mmtjlu5w=;
 b=MGKwPtZAaB8CetQVLiQuT0CPoqpvX6nNfD//OHeYn6jzrtcxUADSPJey6wE22ehnvi
 NwmJzveFwpi5mfIvw0phweKz/TZEEDsen72vemR42846FtpMHU8kIn9bDjicVgHzLkXw
 w3wi7Y43CrBb0aBvIGQm8G0RcoOpILMZIOjYWAwlhWA50elypDwd4sOedPVkzn/dlRx0
 0mb09lFg8Rvpd1rVTngnYzZqAp8JT8QHFa1G6IU1SANLQE3sbNsgN2dsh07YTMKcNhDd
 00XimjHLOQbA8nlgjr68ZdfFe3prVgrtJWp/KnfAnH5Zn3jlgnGmMQoJdLKTDkbFe7Ln
 rINA==
X-Gm-Message-State: APjAAAUjfn4/UHuV9IjQU3P0tSEe5uAJqW2yyrbrce75pgcxxx9577oq
 MKIc+LgsXnoyUGntfD6RHPFbGI8U
X-Google-Smtp-Source: APXvYqz8sb34dXuEB1qIMv1mu5/ZEtXpLPqBv149f689Cw3otnkr6zwaMkVnCY26H5Xl/89QGg5amQ==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr8550921wrn.334.1571834340001; 
 Wed, 23 Oct 2019 05:39:00 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u10sm12467482wmj.0.2019.10.23.05.38.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Oct 2019 05:38:59 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: call amdgpu_vm_prt_fini before deleting the
 root PD
To: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191023120221.13537-1-pierre-eric.pelloux-prayer@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <732293f7-931c-5d9e-d98c-43bbe241d80b@gmail.com>
Date: Wed, 23 Oct 2019 14:38:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023120221.13537-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=qSGApLGus4H1I7hduVHaPRCKsjFwV8jn8V/mmtjlu5w=;
 b=uKRqJ2kxxEjrfZx3rHiiRlAN1LUzIMeU39L75EPqnDifw5BBXpddIQWNTQqNaC2fVi
 M7CHP/+NmBpgGvvjfzUk12UMqm8B14n8Adro991ZUYHgSa561lzj2phUpJ0Ng2gpIgSi
 q19PsmuHU+7FAyp5HAyedWL2+BjAYBD5RSw+obOv8e4QWNZf4pUtR6A5TXImwRn85UII
 93ZnEceUVYltKl7Sry7AcVonZpSu/E1J2vy9MKCFPjIsdgsi5dM8EZHJ7dMkrXB7h1Mu
 zvnj9GoqZz8shOdwcdlv2HK5ANODddv6pkMVU2/D3cRSuO3T/DIoH6fN46PBZQBagarM
 ZiEg==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Message-ID: <20191023123858.WitUyA-ESgedHJZa1V1sjTKW9kIVt7ioZC6Yb1sDP_s@z>

QW0gMjMuMTAuMTkgdW0gMTQ6MDIgc2NocmllYiBQZWxsb3V4LXByYXllciwgUGllcnJlLWVyaWM6
Cj4gYW1kZ3B1X3ZtX3BydF9maW5pIHVzZXMgInZtLT5yb290LmJhc2UuYm8iIHNvIGl0IG11c3Qg
c3RpbGwgYmUgdmFsaWQgd2hlbgo+IHdlIGNhbGwgaXQuCj4KPiBGaXhlczogYjY1NzA5YTkyMTU2
ICgiZHJtL2FtZGdwdTogcmVzZXJ2ZSB0aGUgcm9vdCBQRCB3aGlsZSBmcmVlaW5nIFBBU0lEcyIp
Cj4gU2lnbmVkLW9mZi1ieTogUGllcnJlLUVyaWMgUGVsbG91eC1QcmF5ZXIgPHBpZXJyZS1lcmlj
LnBlbGxvdXgtcHJheWVyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jIHwgMTkgKysrKysrKysrKy0tLS0tLS0tLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IGluZGV4IGQ5YmVjZTk4N2U2MC4uYzhjZTQyMjAwMDU5
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtMjk3NSw2
ICsyOTc1LDE2IEBAIHZvaWQgYW1kZ3B1X3ZtX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtKQo+ICAgCQl2bS0+cGFzaWQgPSAwOwo+ICAgCX0KPiAg
IAo+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKG1hcHBpbmcsIHRtcCwgJnZtLT5mcmVlZCwg
bGlzdCkgewo+ICsJCWlmIChtYXBwaW5nLT5mbGFncyAmIEFNREdQVV9QVEVfUFJUICYmIHBydF9m
aW5pX25lZWRlZCkgewo+ICsJCQlhbWRncHVfdm1fcHJ0X2ZpbmkoYWRldiwgdm0pOwo+ICsJCQlw
cnRfZmluaV9uZWVkZWQgPSBmYWxzZTsKPiArCQl9Cj4gKwo+ICsJCWxpc3RfZGVsKCZtYXBwaW5n
LT5saXN0KTsKPiArCQlhbWRncHVfdm1fZnJlZV9tYXBwaW5nKGFkZXYsIHZtLCBtYXBwaW5nLCBO
VUxMKTsKPiArCX0KPiArCj4gICAJYW1kZ3B1X3ZtX2ZyZWVfcHRzKGFkZXYsIHZtLCBOVUxMKTsK
PiAgIAlhbWRncHVfYm9fdW5yZXNlcnZlKHJvb3QpOwo+ICAgCWFtZGdwdV9ib191bnJlZigmcm9v
dCk7Cj4gQEAgLTI5OTQsMTUgKzMwMDQsNiBAQCB2b2lkIGFtZGdwdV92bV9maW5pKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSkKPiAgIAkJbGlzdF9kZWwo
Jm1hcHBpbmctPmxpc3QpOwo+ICAgCQlrZnJlZShtYXBwaW5nKTsKPiAgIAl9Cj4gLQlsaXN0X2Zv
cl9lYWNoX2VudHJ5X3NhZmUobWFwcGluZywgdG1wLCAmdm0tPmZyZWVkLCBsaXN0KSB7Cj4gLQkJ
aWYgKG1hcHBpbmctPmZsYWdzICYgQU1ER1BVX1BURV9QUlQgJiYgcHJ0X2ZpbmlfbmVlZGVkKSB7
Cj4gLQkJCWFtZGdwdV92bV9wcnRfZmluaShhZGV2LCB2bSk7Cj4gLQkJCXBydF9maW5pX25lZWRl
ZCA9IGZhbHNlOwo+IC0JCX0KPiAtCj4gLQkJbGlzdF9kZWwoJm1hcHBpbmctPmxpc3QpOwo+IC0J
CWFtZGdwdV92bV9mcmVlX21hcHBpbmcoYWRldiwgdm0sIG1hcHBpbmcsIE5VTEwpOwo+IC0JfQo+
ICAgCj4gICAJZG1hX2ZlbmNlX3B1dCh2bS0+bGFzdF91cGRhdGUpOwo+ICAgCWZvciAoaSA9IDA7
IGkgPCBBTURHUFVfTUFYX1ZNSFVCUzsgaSsrKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
