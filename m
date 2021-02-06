Return-Path: <SRS0=JyXF=HI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B417C433E0
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Feb 2021 18:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE94B64E42
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Feb 2021 18:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE94B64E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D8B6E4A1;
	Sat,  6 Feb 2021 18:17:54 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6FB76E4A1
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Feb 2021 18:17:52 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id v15so11245264ljk.13
 for <amd-gfx@lists.freedesktop.org>; Sat, 06 Feb 2021 10:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=C3kW/OiocyuN5yeAHAEJeasO9MZwA+lBdOwDSAKHBuc=;
 b=SE7/tuijX1BBe8zH/TW7teE8Ptqy7ye54UMQbg1MHpWv/aBf7Q/fFl3UFmEAwx/gtG
 oFCJndgqgYYyGR7pe0TfpxBHORxejgq3O7mIKBMSE57RHgi6jrZhtlE4NASYh1HtvHLy
 5l7iz82kZkRERsNQlKf1jdctFP3erN2/GtO5zkHfgGFtta9lnVy2Yw47j6OBfqqyGC1j
 obgXGSQ3PwDnxgg+NMNV3OGncp2Jdcu0tNgR3bXR7uR+uR7DzqmfJwfuH4LqaD2SyP23
 s3bcstrMKsry8QkalfOrV6ICOB3PSmGCmxQHNkGRSfbCVKaatwZGxr8o5Hiv/TIHC7+q
 Ln1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C3kW/OiocyuN5yeAHAEJeasO9MZwA+lBdOwDSAKHBuc=;
 b=KNlE2BsPzmm5cqa5FpZ1s8wVfM27RtzRF2+dlwhS8UQOWOxHSRY+yImR+jOM08BTAM
 kt1Lg71FeqHCZIEEEonGNTrrpp7jExg6eZpYqlm9t5tfFRbS44SAewee3y90DBfJbFEm
 Gx3GSQ0hRkhkF600vdIfhjh4rmFBOKJosVlrYjtSYv06ap8I9aikKS6SeA6iqqPLIWY0
 /ldmKSs9fWhebt6klMAAyNRX9hf4e6oRGYOQkGcJL0u4hGBkPKsIiv0Kn9GT8LkCHHpy
 ZC+ZQz90qcnvCLeMkFPomQ5msmym6hAkF1HzoQOh0i4gsutN1QhV9x1blSuvA08oBnxE
 /AKA==
X-Gm-Message-State: AOAM531MSJjnwJnKXD8aSUKsF4o8J+n2WjLeclWLLEAYBJielJdCGEvv
 ol0wQnonxoBL+8t7TjW20665NtI4kaQjqJ6TbuU=
X-Google-Smtp-Source: ABdhPJwllXfo1tC3xj9MM7zF5DWer57G6Byon2hOX+uVkyl1vsYZEr681ocSwQFwny/3uUsEmmuC0wYHTpqRqZBggCI=
X-Received: by 2002:a2e:b165:: with SMTP id a5mr1728142ljm.81.1612635471207;
 Sat, 06 Feb 2021 10:17:51 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNazWZQGfSnFgQ_K5_H9uBQ=8gBdFORXrU1FEMGMohO2w@mail.gmail.com>
 <4ce29a7e-f58a-aeb4-bef-34a7eada70d0@google.com>
 <e0c2c823-5f-efe8-cd87-6dd6cc33a33@google.com>
 <7a677c89-1974-0676-ba7d-b057ad2cab3f@gmail.com>
In-Reply-To: <7a677c89-1974-0676-ba7d-b057ad2cab3f@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 6 Feb 2021 23:17:40 +0500
Message-ID: <CABXGCsPnGVAGWETYD-dfrqxhciHA0NKBG2EWueOtFzL5xF9z3g@mail.gmail.com>
Subject: Re: [bug] 5.11-rc5 brought page allocation failure issue [ttm][amdgpu]
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gU3VuLCAzMSBKYW4gMjAyMSBhdCAyMjoyMiwgQ2hyaXN0aWFuIEvDtm5pZwo8Y2tvZW5pZy5s
ZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4KPiBZZWFoLCBrbm93biBpc3N1ZS4g
SSBhbHJlYWR5IHB1c2hlZCBNaWNoZWwncyBmaXggdG8gZHJtLW1pc2MtZml4ZXMuCj4gU2hvdWxk
IGxhbmQgaW4gdGhlIG5leHQgLXJjIGJ5IHRoZSB3ZWVrZW5kLgo+Cj4gUmVnYXJkcywKPiBDaHJp
c3RpYW4uCgpJIGNoZWNrZWQgdGhpcyBwYXRjaCBbMV0gZm9yIHNldmVyYWwgZGF5cy4KQW5kIEkg
Y2FuIGNvbmZpcm0gdGhhdCB0aGUgcmVwb3J0ZWQgaXNzdWUgd2FzIGdvbmUuCgpbMV0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMDEyODA5NTM0Ni4yNDIxLTEtbWljaGVsQGRhZW56
ZXIubmV0LwoKLS0gCkJlc3QgUmVnYXJkcywKTWlrZSBHYXZyaWxvdi4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
