Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900F9C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 08:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB9A2074B
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 08:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8DWuDe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB9A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27EE589904;
	Wed,  3 Jun 2020 08:17:57 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5C3589904
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 08:17:55 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id u13so980561wml.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jun 2020 01:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=aCBpe4JMC4BzKoebagoNwsfsnzACy+cGXmUsaecXLN4=;
 b=c8DWuDe8eHUVdgn9oLnQegU5NCbgf34W2y6z4F8HiwFEbTonL0WjnZPGzaDcj/Bo1M
 sdJEiRpkWYdyTIlt1FD3ERW1mChxQZ571ouNxd43YcpgHOXgd5kDL9JUj5OuQeMQ/FTi
 VJR2Z93iwPNhtPrvPRXC1w37I2Nk2nBqffu7PQiQo6fSxEFx3vR1/r82LURWdDYUtU8s
 /kdFtUhnb9e88dxHALXGppMGfckC/e5WUZUpKR7fwUtKFXGZ8Aqth+PbdDFSp3xdsZeT
 knQT0dc7JKojr3T3Ay/Ylpr2/C0xhc+avXqw8F+XFwJltxu2rq+Am6zko3eWXyE9tvAv
 t95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=aCBpe4JMC4BzKoebagoNwsfsnzACy+cGXmUsaecXLN4=;
 b=BQhWbaA6kks5cxHrHkMwkCoPgZRirThEyhbvNnk5xOzCzmmolObothpDrOfSfz/D7u
 GLCZ2abUxRSgUb+3vLaqERmrBgmfit9Tx3qBQlzdLjPzMCtgzLV741qr8kp/eL9l83zK
 oGofC/HYMD7OxWDQPTXts9U0Y3WUvXZWEKfMmxRXVx0Xlk0AYkRjqKaEbLYVoC76bscE
 dfVMX8aa+GGxZrkvzd0urToTqoJ9bb0GAfmAhjD8Cdi66EHWVqwwPtHBhzcT48LqCFSt
 2iwEnXOJnoAhTd42gvHvu14SpZ2kpP2RmFKNjHlhsRVfvc9kwaQ3fezQQnz1coHiKr33
 nNAQ==
X-Gm-Message-State: AOAM531PX8R2iNt4IYjTfNEEOAo1sgLMmVsFeawS2rm2dMimhEpf/mtq
 PuDEN/ewD7tPaz858b5XewA=
X-Google-Smtp-Source: ABdhPJyvw1uxPVeL2+ewBZUFkNYvXZAlvyqcFv4wPZP9W30Zc4XxW1AzG4HlP6d+yR7ws2LqWvrS8A==
X-Received: by 2002:a7b:c046:: with SMTP id u6mr7202981wmc.57.1591172273433;
 Wed, 03 Jun 2020 01:17:53 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u130sm1908358wmg.32.2020.06.03.01.17.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2020 01:17:51 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/fence: use the no_scheduler flag
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200602185327.1303384-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b3154abf-2702-de52-9e0d-99b9923b28f6@gmail.com>
Date: Wed, 3 Jun 2020 10:17:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200602185327.1303384-1-alexander.deucher@amd.com>
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

QW0gMDIuMDYuMjAgdW0gMjA6NTMgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gUmF0aGVyIHRoYW4g
Y2hlY2tpbmcgdGhlIHJpbmcgdHlwZSBtYW51YWxseS4gIFdlIGFscmVhZHkgc2V0Cj4gdGhpcyBm
b3IgTUVTIGFuZCBLSVEgKGFuZCBhIGZldyBvdGhlciBzcGVjaWFsIGNhc2VzKS4KPgo+IFNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmll
d2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0t
LQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgfCA4ICsrKyst
LS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPiBpbmRleCAwY2U4
MjY4NmM5ODMuLjg1MzdmNDcwNDM0OCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZmVuY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9mZW5jZS5jCj4gQEAgLTQ2OSw5ICs0NjksOCBAQCBpbnQgYW1kZ3B1X2ZlbmNlX2Ry
aXZlcl9pbml0X3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+ICAgCWlmICghcmluZy0+
ZmVuY2VfZHJ2LmZlbmNlcykKPiAgIAkJcmV0dXJuIC1FTk9NRU07Cj4gICAKPiAtCS8qIE5vIG5l
ZWQgdG8gc2V0dXAgdGhlIEdQVSBzY2hlZHVsZXIgZm9yIEtJUSBhbmQgTUVTIHJpbmcgKi8KPiAt
CWlmIChyaW5nLT5mdW5jcy0+dHlwZSAhPSBBTURHUFVfUklOR19UWVBFX0tJUSAmJgo+IC0JICAg
IHJpbmctPmZ1bmNzLT50eXBlICE9IEFNREdQVV9SSU5HX1RZUEVfTUVTKSB7Cj4gKwkvKiBObyBu
ZWVkIHRvIHNldHVwIHRoZSBHUFUgc2NoZWR1bGVyIGZvciByaW5ncyB0aGF0IGRvbid0IG5lZWQg
aXQgKi8KPiArCWlmICghcmluZy0+bm9fc2NoZWR1bGVyKSB7Cj4gICAJCXN3aXRjaCAocmluZy0+
ZnVuY3MtPnR5cGUpIHsKPiAgIAkJY2FzZSBBTURHUFVfUklOR19UWVBFX0dGWDoKPiAgIAkJCXRp
bWVvdXQgPSBhZGV2LT5nZnhfdGltZW91dDsKPiBAQCAtNTQzLDcgKzU0Miw4IEBAIHZvaWQgYW1k
Z3B1X2ZlbmNlX2RyaXZlcl9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCQlp
ZiAocmluZy0+ZmVuY2VfZHJ2LmlycV9zcmMpCj4gICAJCQlhbWRncHVfaXJxX3B1dChhZGV2LCBy
aW5nLT5mZW5jZV9kcnYuaXJxX3NyYywKPiAgIAkJCQkgICAgICAgcmluZy0+ZmVuY2VfZHJ2Lmly
cV90eXBlKTsKPiAtCQlkcm1fc2NoZWRfZmluaSgmcmluZy0+c2NoZWQpOwo+ICsJCWlmICghcmlu
Zy0+bm9fc2NoZWR1bGVyKQo+ICsJCQlkcm1fc2NoZWRfZmluaSgmcmluZy0+c2NoZWQpOwo+ICAg
CQlkZWxfdGltZXJfc3luYygmcmluZy0+ZmVuY2VfZHJ2LmZhbGxiYWNrX3RpbWVyKTsKPiAgIAkJ
Zm9yIChqID0gMDsgaiA8PSByaW5nLT5mZW5jZV9kcnYubnVtX2ZlbmNlc19tYXNrOyArK2opCj4g
ICAJCQlkbWFfZmVuY2VfcHV0KHJpbmctPmZlbmNlX2Rydi5mZW5jZXNbal0pOwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
