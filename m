Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B11FC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 08:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D415261104
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 08:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D415261104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F376E125;
	Tue, 20 Apr 2021 08:34:23 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E5B6E125
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 08:34:21 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id bx20so42877529edb.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=2bc+9ry1XeysQBOD3g0MUZbZYXMTZRr0PwCzY9xU2GU=;
 b=h2PwYlcmMUwuho+Tk+2hISAl2hxujYmie1/XVy7+CJBfA+/yIShZb+H8IYG+5kUCpN
 zCg6SXg2XIPxwEFQSN4FdMlSryMhOeBeHOXos2HvTquzafXgE701odzdB2IqR+ffUdNJ
 +Y5P+Ztw1g56Lh9hOQ3601KjpUu+/DyGku9Ec5KqC/sLANDPzrXA4jmgVjXNsf1rbT08
 DqxL0pWvxyrbHIArD30Q63VmG2okW/ns3H7vzoxzvjpmr/s32EL5NMKpOf1rt/Rx4fI9
 lN59Y4ZL8RY+B84QQ0PQub9mItu8NvPqjNhYcCz5DQgYh//uivNCOnHaev4TEPYvG9tw
 lRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2bc+9ry1XeysQBOD3g0MUZbZYXMTZRr0PwCzY9xU2GU=;
 b=bqB9lmO66uudnm+byMaf886xxN+tvKXHTCY8tUBl27js1yGDzAvkw4XLVUy6qM2kZ7
 +k9H+dj5+/kMZtryQ+E/aYDklLYncNRBFDu/Olm8GNc/AXz6N7gkZ6L4x/eyqzwood2x
 rlij/7biJD2HbMgY/mcvtHgvw4772u/felXkjSYW57hS8dTKM1DPMRMLTjQGvIhQjNOZ
 iLC6v2sbbnXfF+YmjcG3Gg5dhpmlT2qbtBpknBwqpgIfoI1nweKxY2QE8ULYmTQdOxKP
 kU+RJiKuXueE3tDlxW0L/ZaT3jw9mQ62BscH8jKdLgGIV5Ygn0s9bGJtuGI9SgKCkq9k
 2xPw==
X-Gm-Message-State: AOAM533aS6u/nJyECk67UTesmoQCJczIeBF7pIOghukcNSlrReyawpM+
 BnvWFkVvyrzQ+AfuA/c12h8=
X-Google-Smtp-Source: ABdhPJzWAMkFMIAJj0ljFnWu3q9FqOxCcsHbv1yxCFL9+XitVdKzcIUzoRhuwKyN+O0+2v/9FC5Zsg==
X-Received: by 2002:a05:6402:40d5:: with SMTP id
 z21mr31178677edb.20.1618907660043; 
 Tue, 20 Apr 2021 01:34:20 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:3caf:a441:2498:1468?
 ([2a02:908:1252:fb60:3caf:a441:2498:1468])
 by smtp.gmail.com with ESMTPSA id v4sm5446114ejj.84.2021.04.20.01.34.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Apr 2021 01:34:19 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Add mem sync flag for IB allocated by SA
To: Jinzhou Su <Jinzhou.Su@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210420082730.393818-1-Jinzhou.Su@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <31fd0d4e-2dc5-f9bf-2a71-4e90cde52151@gmail.com>
Date: Tue, 20 Apr 2021 10:34:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210420082730.393818-1-Jinzhou.Su@amd.com>
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
Cc: ray.huang@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAuMDQuMjEgdW0gMTA6Mjcgc2NocmllYiBKaW56aG91IFN1Ogo+IFRoZSBidWZmZXIgb2Yg
U0EgYm8gd2lsbCBiZSB1c2VkIGJ5IG1hbnkgY2FzZXMuIFNvIGJldHRlcgo+IHRvIGZsdXNoIHRo
ZSBjYWNoZSBvZiBpbmRpcmVjdCBidWZmZXIgYWxsb2NhdGVkIGJ5IFNBIGJlZm9yZQo+IGNvbW1p
dCB0aGUgSUIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBKaW56aG91IFN1IDxKaW56aG91LlN1QGFtZC5j
b20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYyB8IDIg
KysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9pYi5jCj4gaW5kZXggMTQ4YTNiNDgxYjEyLi5hMmZlMmRhYzMyYzEg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+IEBAIC03Niw2ICs3
Niw4IEBAIGludCBhbWRncHVfaWJfZ2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1
Y3QgYW1kZ3B1X3ZtICp2bSwKPiAgIAkJfQo+ICAgCj4gICAJCWliLT5wdHIgPSBhbWRncHVfc2Ff
Ym9fY3B1X2FkZHIoaWItPnNhX2JvKTsKPiArCQkvKiBmbHVzaCB0aGUgY2FjaGUgYmVmb3JlIGNv
bW1pdCB0aGUgSUIgKi8KCkVpdGhlciBkcm9wIHRoZSBjb21tZW50IG9yIGNoYW5nZSBpdCBhIGJp
dC4KCkUuZy4gbGlrZSAiLyogSW52YWxpZGF0ZSB0aGUgY2FjaGUgdG8gbWFrZSB0aGUgR1BVIHNl
ZSB0aGUgbmV3ZXN0IFNBIApjb250ZW50ICovCgpXaXRoIHRoYXQgZG9uZSB0aGUgcGF0Y2ggaXMg
UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgCjxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
CgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+ICsJCWliLT5mbGFncyA9IEFNREdQVV9JQl9GTEFHX0VN
SVRfTUVNX1NZTkM7Cj4gICAKPiAgIAkJaWYgKCF2bSkKPiAgIAkJCWliLT5ncHVfYWRkciA9IGFt
ZGdwdV9zYV9ib19ncHVfYWRkcihpYi0+c2FfYm8pOwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
