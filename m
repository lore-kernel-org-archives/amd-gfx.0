Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F46C48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 08:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6286610EA
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 08:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6286610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EAEF6E532;
	Wed, 16 Jun 2021 08:45:34 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0CD6E532
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 08:45:32 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id r7so1582820edv.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 01:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=azvGVbm8bOQGZ/rFa4sRmAf1u4rxAYOlQMVYLoobmAE=;
 b=oXbXA+R80hfzpUVqnDsKbwg9OuLPmdswks4KpbnpHGa4p9PTRV5zl0VOffY2a7Eeso
 pmB8uyrYu3BhJ2DfxlcxDvnPz6DCMIAUMv2mVhLV66kF6T2cB7Sae9TvRU8v929sDEQq
 gCxh9qN4d9HA6u1jDPVfhfR0ekSryz9OXA0lR+yE+nqkdwohDCZsmq8spLOr7i8zXccO
 ipj98PX2oi5wOenTmpk15lMopumxiFz8x964lwp1dipm+3IleKPlvpDvr7yobWip6eJ6
 7kKWn9WDwuCEwThIEeAtN5LiwP/bazYbM05u3qY3tXN72vfRRwHEhMYiEBhqZrIamGNX
 syaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=azvGVbm8bOQGZ/rFa4sRmAf1u4rxAYOlQMVYLoobmAE=;
 b=HC1uSYEG05wPI+2ib+pcZ5mt2KtMTIHnfrYHk1vSoDby38+7Ggiad2+HIdQAImDNl4
 y97f/I2htGlGsUaYuYknR9xoKWgRFIeVKo9X52HlTBJs6ILSQtmymp+yEziOrnFoAIqq
 xtTul+5uelU3lN5mgX8n0UPiCRR9Mu5zZl+fa0r6fcSpkXLrV84cn/8IBgumsEA+jP7l
 Y7OJ4UqkYSTYjTPv8+cD1ZhKksU05j514lq43utYTO7ZAI6YtUKcMSs2zpGaYk62sy0T
 iaztxmtqhr+6ii6vKA/pDImg+Tyz0S9mL+7l+LyA8rDK1bx9UDefC2dp+5Nq5pHwuusI
 hWIQ==
X-Gm-Message-State: AOAM532Yhh8njPWKujDFiycEC6J8OQHAqbxpwvrvkobVhB4/M1fS0e5p
 Hg35e330V928SlU5I2/bdRk=
X-Google-Smtp-Source: ABdhPJwQ0HgiZXRbc04CLWQVLIUTOheSnYVgkW+K+sFOiACBQHhy9a/4tm+jIbgsn2ySCE/7uPmtEA==
X-Received: by 2002:a05:6402:510e:: with SMTP id
 m14mr2784365edd.225.1623833131537; 
 Wed, 16 Jun 2021 01:45:31 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:afc4:3771:10a6:8a6d?
 ([2a02:908:1252:fb60:afc4:3771:10a6:8a6d])
 by smtp.gmail.com with ESMTPSA id d24sm1200343edr.95.2021.06.16.01.45.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 01:45:31 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Set TTM_PAGE_FLAG_SG earlier for userprt BOs
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210616083632.2712-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4b5e9f4e-5c83-8c19-45e9-7ac90cbbaac0@gmail.com>
Date: Wed, 16 Jun 2021 10:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210616083632.2712-1-xinhui.pan@amd.com>
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTYuMDYuMjEgdW0gMTA6MzYgc2NocmllYiB4aW5odWkgcGFuOgo+IEJlY2F1c2UgVFRNIGRv
IHBhZ2UgY291bnRpbmcgb24gdXNlcnB0ciBCT3Mgd2hpY2ggaXMgYWN0dWFsbHkgbm90Cj4gbmVl
ZGVkLiBUbyBhdm9pZCB0aGF0LCBsZXRzIHNldCBUVE1fUEFHRV9GTEFHX1NHIGFmdGVyIHR0X2Ny
ZWF0ZSBhbmQKPiBiZWZvcmUgdHRfcG9wdWxhdGUuCj4KPiBTaWduZWQtb2ZmLWJ5OiB4aW5odWkg
cGFuIDx4aW5odWkucGFuQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90dG0uYyB8IDYgKysrLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90dG0uYwo+IGluZGV4IDA4ODc5NDJiNDYyMi4uOTdjODMxNjRjZTM4IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IEBAIC0xMTQ3LDggKzExNDcsNiBA
QCBzdGF0aWMgaW50IGFtZGdwdV90dG1fdHRfcG9wdWxhdGUoc3RydWN0IHR0bV9kZXZpY2UgKmJk
ZXYsCj4gICAJCXR0bS0+c2cgPSBremFsbG9jKHNpemVvZihzdHJ1Y3Qgc2dfdGFibGUpLCBHRlBf
S0VSTkVMKTsKPiAgIAkJaWYgKCF0dG0tPnNnKQo+ICAgCQkJcmV0dXJuIC1FTk9NRU07Cj4gLQo+
IC0JCXR0bS0+cGFnZV9mbGFncyB8PSBUVE1fUEFHRV9GTEFHX1NHOwo+ICAgCQlyZXR1cm4gMDsK
PiAgIAl9Cj4gICAKPiBAQCAtMTE3NCw3ICsxMTcyLDYgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3R0
bV90dF91bnBvcHVsYXRlKHN0cnVjdCB0dG1fZGV2aWNlICpiZGV2LAo+ICAgCQlhbWRncHVfdHRt
X3R0X3NldF91c2VyX3BhZ2VzKHR0bSwgTlVMTCk7Cj4gICAJCWtmcmVlKHR0bS0+c2cpOwo+ICAg
CQl0dG0tPnNnID0gTlVMTDsKPiAtCQl0dG0tPnBhZ2VfZmxhZ3MgJj0gflRUTV9QQUdFX0ZMQUdf
U0c7Cj4gICAJCXJldHVybjsKPiAgIAl9Cj4gICAKPiBAQCAtMTIwOCw2ICsxMjA1LDkgQEAgaW50
IGFtZGdwdV90dG1fdHRfc2V0X3VzZXJwdHIoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibywK
PiAgIAkJCXJldHVybiAtRU5PTUVNOwo+ICAgCX0KPiAgIAo+ICsJLyogU2V0IFRUTV9QQUdFX0ZM
QUdfU0cgYmVmb3JlIHBvcHVsYXRlIGJ1dCBhZnRlciBjcmVhdGUuICovCj4gKwliby0+dHRtLT5w
YWdlX2ZsYWdzIHw9IFRUTV9QQUdFX0ZMQUdfU0c7Cj4gKwo+ICAgCWd0dCA9ICh2b2lkICopYm8t
PnR0bTsKPiAgIAlndHQtPnVzZXJwdHIgPSBhZGRyOwo+ICAgCWd0dC0+dXNlcmZsYWdzID0gZmxh
Z3M7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
