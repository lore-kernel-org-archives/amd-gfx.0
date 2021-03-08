Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9A5C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 14:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A81864EDE
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 14:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A81864EDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D08CC6E3F0;
	Mon,  8 Mar 2021 14:39:00 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C58786E842
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 09:19:37 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id l22so5598904wme.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Mar 2021 01:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=hEOGgoBFFfBcRYu8R+ZFzD5oTYtm/qga63LL53Ov/bU=;
 b=evLEsiqayrflm8/aMCMFF1KGm9tCqy5TgmLozN1pf5OV8v3XOrrOZ7dusez6ueByqx
 QbfNJbn3Tb6TelmwrFWDd4WHxalQui+FvvMLcnchyO2FEC0WH66rXpO7Bg5MqXxBzX+Z
 cc9Pr7PgNkEy1bM1xcbTqIIGCmKoaS4GNgx3Ck/1lpofYRw8U2M/EjDO4iJe0z6SkwP7
 NEfv8QFCktFfq07V+8oK+WYbUu5K7JfqkfwOCUZH8ZfaC1XQzqb4v836tecMta/an5NF
 q1zYSc8uWIE/dnLOv0rAgqCp8RZ+/3Pe/2mlOOfPdm/KIfJDoR0E3DqxqFiDR11IYcOx
 uh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=hEOGgoBFFfBcRYu8R+ZFzD5oTYtm/qga63LL53Ov/bU=;
 b=c8RVUmc5/dvmPN0IENkpBt0IZFqsO8kzvckBu1fvwomo+xzB+GvXC6FI1VPUD0NQyg
 FjIW6Qx6Fhu4/vnThk73kSR7jtvekkXalMlXegJigjLhDGMz26I/ZVAzWtRIw7OZySEV
 JDsNfeshUqddhmCQhH1q4IYkO5kq6Ueh1kltC4o237kwzhN4uLvnXU1E4TaAia6280GQ
 WE6n6jGxml+aj2Ryk8WBNVJjZECcBj8IbsG09/JIWFQP2swJozbCma+u5kG2H5GnlYN6
 ZCqjdQEx9BRySjCuWsyWQhbnwfQrfQbgjLe1KxafLhz1W5/M79vh5nGwpHqQMYXBYBqd
 OsuQ==
X-Gm-Message-State: AOAM533qUl5BzJQYvuUVFmMpi+iCx/q0LqmkTKiuQTLYkGMGcs5oOaP8
 R9ECdLDdzRe66Rrt3FhqPGhEEQ==
X-Google-Smtp-Source: ABdhPJySpXzmJ3MCPU31zc4PaUGqi7NmkyvQv0pK/pj0WvYnEHQRAY6VwjmHVQ6JfBzbPkybjDafLg==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr20979920wma.167.1615195176468; 
 Mon, 08 Mar 2021 01:19:36 -0800 (PST)
Received: from dell ([91.110.221.130])
 by smtp.gmail.com with ESMTPSA id i11sm17599389wro.53.2021.03.08.01.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 01:19:35 -0800 (PST)
Date: Mon, 8 Mar 2021 09:19:32 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Roland Scheidegger <sroland@vmware.com>
Subject: Re: [RESEND 00/53] Rid GPU from W=1 warnings
Message-ID: <20210308091932.GB4931@dell>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
 <16d4300e-bf29-1e85-317b-53d257890cb9@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <16d4300e-bf29-1e85-317b-53d257890cb9@vmware.com>
X-Mailman-Approved-At: Mon, 08 Mar 2021 14:38:59 +0000
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
Cc: David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Qinglang Miao <miaoqinglang@huawei.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Jeremy Kolb <jkolb@brandeis.edu>, amd-gfx@lists.freedesktop.org,
 Rob Clark <rob.clark@linaro.org>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@redhat.com>,
 Harry Wentland <harry.wentland@amd.com>, linux-media@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>, Leo Li <sunpeng.li@amd.com>,
 linux-arm-msm@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, linaro-mm-sig@lists.linaro.org,
 Sean Paul <sean@poorly.run>, Kuogee Hsieh <khsieh@codeaurora.org>,
 linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Colin Ian King <colin.king@canonical.com>, freedreno@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Zack Rusin <zackr@vmware.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCAwNSBNYXIgMjAyMSwgUm9sYW5kIFNjaGVpZGVnZ2VyIHdyb3RlOgoKPiBUaGUgdm13
Z2Z4IG9uZXMgbG9vayBhbGwgZ29vZCB0byBtZSwgc28gZm9yCj4gMjMtNTM6IFJldmlld2VkLWJ5
OiBSb2xhbmQgU2NoZWlkZWdnZXIgPHNyb2xhbmRAdm13YXJlLmNvbT4KPiBUaGF0IHNhaWQsIHRo
ZXkgd2VyZSBhbHJlYWR5IHNpZ25lZCBvZmYgYnkgWmFjaywgc28gbm90IHN1cmUgd2hhdAo+IGhh
cHBlbmVkIGhlcmUuCgpZZXMsIHRoZXkgd2VyZSBhY2NlcHRlZCBhdCBvbmUgcG9pbnQsIHRoZW4g
ZHJvcHBlZCB3aXRob3V0IGEgcmVhc29uLgoKU2luY2UgSSByZWJhc2VkIG9udG8gdGhlIGxhdGVz
dCAtbmV4dCwgSSBoYWQgdG8gcGx1Y2sgdGhlbSBiYWNrIG91dCBvZgphIHByZXZpb3VzIG9uZS4K
Ci0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KU2VuaW9yIFRlY2huaWNhbCBMZWFkIC0gRGV2ZWxv
cGVyIFNlcnZpY2VzCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBcm0g
U29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
