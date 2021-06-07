Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F684C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 10:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B9F561205
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 10:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9F561205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B22BF6E8A2;
	Mon,  7 Jun 2021 10:46:18 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDA866E8A2;
 Mon,  7 Jun 2021 10:46:17 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 3-20020a05600c0243b029019f2f9b2b8aso9832912wmj.2; 
 Mon, 07 Jun 2021 03:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=KcIhVJsL3yrPFMmj6Xxxh1AoiEa6qKo1bMNhV5zzVU4=;
 b=nIfQIgvwVppIuEFSzUQVquUbbMHHEiotd+EFEBy2MJDMpTxLbCzIJy3aL/h4WE87Kn
 PZmaBHFFRSEyEXosjbP2EZuixX75V/ZhtvLfb3tXHHCLT8xBRROW5+nSD0zJLEcmoeVN
 No3BFvOuW2XoLcusEFKJVtfhw1/tV5mRmIZHmZJRb8Pp2eAcrbsrB0OQ5rgbeMGngY0n
 F5UJPn7xyZ2uBXdwMD5qm2oaerqyfBROtOylfHWUtzoeD5hz2o7dCgiBLTpn1poBCd0B
 DR0ZcEROaNyxZCGESxd5MgNG1KMlm08QE/eQ64AeQ500Wr/hrblXZHFYrAjA34LZIh3F
 1T6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=KcIhVJsL3yrPFMmj6Xxxh1AoiEa6qKo1bMNhV5zzVU4=;
 b=mAYnLcrDKufv2+/YRHOJr5yznvVm87reM7RniOrxbuLJ4L3QTyUlvW5P40uS3kJtiG
 kga3RCxJwvDYkfyGqm58oLH/aGOKwXUew6Ywkb2jMIA62cHSvPu5bgpQ+mnRaodSPQ06
 uUIDchB7ASSUFSqcQyyLCPuFQ/rTGcDSsZXno4ve4Y7/K/xGdVAlle7L+XzwNewwAY+C
 yS9kz0qIHvJ4VytAOY+StE8rAkJwzRewFuZU8A9q+P0zqPgg6d6bQamGu8SaU0Yym7sj
 Y+F63sCa+fndZkBix7WPTfptqNgMqwJlf4q/t8M4HNs7yiSYcTMYk0kYAxRW3NL6kfzr
 vRYg==
X-Gm-Message-State: AOAM533T81/4In1FMJ66+hBE1XEL9mcADeffAUbG9UbTeaLmsQdK/La5
 kqlcCSFtGgtollFYBSEZcL4=
X-Google-Smtp-Source: ABdhPJz5mNoADFlUvoQOZLVGYoQSWnoQIBz5yANTWqTzpJFPZOVBzoohGEELM71BXZ+Lolragqs//Q==
X-Received: by 2002:a05:600c:5122:: with SMTP id
 o34mr8135390wms.168.1623062776700; 
 Mon, 07 Jun 2021 03:46:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:ce67:4e4d:875d:ffeb?
 ([2a02:908:1252:fb60:ce67:4e4d:875d:ffeb])
 by smtp.gmail.com with ESMTPSA id v7sm17854646wrf.82.2021.06.07.03.46.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jun 2021 03:46:16 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Fix a a typo in a comment
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch
References: <ea7ecbef546a03ef71d65bfe82608bb347e6f3c2.1622883895.git.christophe.jaillet@wanadoo.fr>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <99a5eba3-2d2a-65a8-9b03-a3d4043c5ec5@gmail.com>
Date: Mon, 7 Jun 2021 12:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ea7ecbef546a03ef71d65bfe82608bb347e6f3c2.1622883895.git.christophe.jaillet@wanadoo.fr>
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
Cc: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDUuMDYuMjEgdW0gMTE6MDYgc2NocmllYiBDaHJpc3RvcGhlIEpBSUxMRVQ6Cj4gcy90aGFu
L3RoZW4vCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUu
amFpbGxldEB3YW5hZG9vLmZyPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfY3MuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPiBpbmRl
eCA4OWViYmYzNjNlMjcuLjE0NzYyMzZmNWM3YyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9jcy5jCj4gQEAgLTY2Miw3ICs2NjIsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9j
c19zeW5jX3JpbmdzKHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwKQo+ICAgICogQGVycm9yOgll
cnJvciBudW1iZXIKPiAgICAqIEBiYWNrb2ZmOglpbmRpY2F0b3IgdG8gYmFja29mZiB0aGUgcmVz
ZXJ2YXRpb24KPiAgICAqCj4gLSAqIElmIGVycm9yIGlzIHNldCB0aGFuIHVudmFsaWRhdGUgYnVm
ZmVyLCBvdGhlcndpc2UganVzdCBmcmVlIG1lbW9yeQo+ICsgKiBJZiBlcnJvciBpcyBzZXQgdGhl
biB1bnZhbGlkYXRlIGJ1ZmZlciwgb3RoZXJ3aXNlIGp1c3QgZnJlZSBtZW1vcnkKPiAgICAqIHVz
ZWQgYnkgcGFyc2luZyBjb250ZXh0Lgo+ICAgICoqLwo+ICAgc3RhdGljIHZvaWQgYW1kZ3B1X2Nz
X3BhcnNlcl9maW5pKHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwYXJzZXIsIGludCBlcnJvciwK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
