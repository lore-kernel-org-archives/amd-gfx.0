Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034CAC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 10:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A3F61028
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 10:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A3F61028
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD7B6E223;
	Thu, 20 May 2021 10:56:32 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8915C6E223
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 10:56:31 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id l4so24536885ejc.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 03:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=nsQL4w12p0c0cMlr18VxCIqOpuAcpiLIjqmLEzcxn90=;
 b=ZgfLUyfntUorbuYNHjfBRbmbIiZW5nVDZdw5ErAxwrO2rcvO5G8qEEkOponaLF3zLU
 rDOMUNaecAQBMWEKuoa2ZVsH3L+jMNyIH+PuZLXWMjD7xRHagjMHsyfI1Ef3fYERVG7C
 2Bo8uG9odMlRInAiN/WME4wzyZPFbp92d0SkfEXk/mjiBHSKHn0qmxyEeo9FMURVp5Tn
 VKmqHLlMO/Pw1nbeUgNE/SGC3jlgr+jOr7k6hMsGhYBV7qU4maZsOdyM9cK41WIDaP3A
 jqQGyz4EpzeaywqoQKLcxfMDJiqZAa28Ln21V0YwWAGRp3URExseJOnOrN5NYFdNOI3f
 eBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=nsQL4w12p0c0cMlr18VxCIqOpuAcpiLIjqmLEzcxn90=;
 b=uPS0wWlXHxGVIqG5NZ+mv6cyOSXDvvN/4K242GQmW4LcugAMUGcXgoUmpDDntgra5k
 sSzdYor0VnacygC9a2frnGuYqaf3YeSru32SRvuBUzt4bFg9LPL1RtcqBjzQIJM0qzrA
 HJ2Cs6PBHqKXfr6mMK2nJYsSa6o6L0HSe9wxjHQtrySfkGOtO0jsJB1hHFDnj24+fDai
 FwZHfk2WYJ0SjehNqlA8R3gaC7C09PXDaeBhc/3IXzoHJao/v1IocmyoOuR3LWA88ecc
 nzKZXmuXxbhLITcGujW9dGVXhhnjTlStdGR8ojg0CIXzMKqjMdIMXW1CCJhlcDnnd/WL
 qUJg==
X-Gm-Message-State: AOAM532RCpv0FEPE24islE/sPiWkJK8soJYDRaxu2RI3qCxALzki5Fh+
 cmoYilu3IPNf0wCyFiL0tZNvlRUXCko=
X-Google-Smtp-Source: ABdhPJwn38x1Xy0rJt6ztfeDpI35QgDEFBMrEvwDZ3tfVSCs11rKil/E0KETBrlQDRsfnpGKgOkYWQ==
X-Received: by 2002:a17:906:e215:: with SMTP id
 gf21mr1111922ejb.59.1621508190131; 
 Thu, 20 May 2021 03:56:30 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:4635:589e:67a4:e02a?
 ([2a02:908:1252:fb60:4635:589e:67a4:e02a])
 by smtp.gmail.com with ESMTPSA id l19sm1307401edv.17.2021.05.20.03.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 May 2021 03:56:29 -0700 (PDT)
Subject: Re: [PATCH 1/7] drm/amdgpu/vcn1: add cancel_delayed_work_sync before
 power gate
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <80b6fd16-8be6-d2a5-1cb3-bd6a5e5f6e89@gmail.com>
Date: Thu, 20 May 2021 12:56:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTkuMDUuMjEgdW0gMTg6MjIgc2NocmllYiBKYW1lcyBaaHU6Cj4gQWRkIGNhbmNlbF9kZWxh
eWVkX3dvcmtfc3luYyBiZWZvcmUgc2V0IHBvd2VyIGdhdGluZyBzdGF0ZQo+IHRvIGF2b2lkIHJh
Y2UgY29uZGl0aW9uIGlzc3VlIHdoZW4gcG93ZXIgZ2F0aW5nLgo+Cj4gU2lnbmVkLW9mZi1ieTog
SmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciB0aGUgc2VyaWVzLgoKPiAtLS0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMgfCA2ICsrKysrLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92Y25fdjFfMC5jCj4gaW5kZXggMGMxYmVlZi4uMjdiMWNlZCAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYwo+IEBAIC0yMzEsOSArMjMxLDEzIEBAIHN0
YXRpYyBpbnQgdmNuX3YxXzBfaHdfZmluaSh2b2lkICpoYW5kbGUpCj4gICB7Cj4gICAJc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7Cj4g
ICAKPiArCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmlkbGVfd29yayk7Cj4g
Kwo+ICAgCWlmICgoYWRldi0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9SVF9WQ05fRFBHKSB8fAo+
IC0JCVJSRUczMl9TT0MxNShWQ04sIDAsIG1tVVZEX1NUQVRVUykpCj4gKwkJKGFkZXYtPnZjbi5j
dXJfc3RhdGUgIT0gQU1EX1BHX1NUQVRFX0dBVEUgJiYKPiArCQkgUlJFRzMyX1NPQzE1KFZDTiwg
MCwgbW1VVkRfU1RBVFVTKSkpIHsKPiAgIAkJdmNuX3YxXzBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRl
KGFkZXYsIEFNRF9QR19TVEFURV9HQVRFKTsKPiArCX0KPiAgIAo+ICAgCXJldHVybiAwOwo+ICAg
fQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
