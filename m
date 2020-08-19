Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4912C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 20:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16B6207DE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 20:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMql9Njw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16B6207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 349AE6E817;
	Wed, 19 Aug 2020 20:17:22 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E004E6E817;
 Wed, 19 Aug 2020 20:17:20 +0000 (UTC)
Received: by mail-ed1-x543.google.com with SMTP id w17so19145163edt.8;
 Wed, 19 Aug 2020 13:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fysIesqLJiT9tUfxjxdvGBpqbkI0m8o2fdFq4NMZSso=;
 b=eMql9Njwr779SGLRXR0PT+Faja+HDfyeMYnvQlfnxzqi52SdtySrAn6XQZzYaO8f3w
 XSjh5MEf/vjed9Kg1EgKzo00fpxc4aGQ/S3H7bG1dkLHStIjX+fkMAe6hE5yeepZ30F7
 DruGcxuiHl0oNIj64Tb5XGXZ8pvJDPIkNyjdt0pDMBw/5hcHPeSNGKJbTHFIGQwHvJlb
 v7bVL6TLHj3jQSmEpiilZVM8vrtCUcyvLjubHaxadBSzuzyeguTb589PA5djQGJjQ7Dh
 MPE9Gbg9MX2AaDa6gVP9kOvLrpZsWbjYgkJ9hAFhAtttTPXc2gzRnAJ5ib8lHNocRFbT
 lbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fysIesqLJiT9tUfxjxdvGBpqbkI0m8o2fdFq4NMZSso=;
 b=JvNXriO7NOsAkOzpR9zOeITytZbB1xItImV5JGlHzSbqUAK7NY3CFF9HsJMs5ujma+
 O2BwDRMPz4hXryn0dKU/ACXwc2pZinON/zgb3aODzXf+m2rnwH6ji09NRLuGv7A4GAsW
 uLwFSO6StdLqCabcUBQGJW06BdQxOv06e6z/WSkw8h255x6YkqaIhT4nHJzQswyCoxUw
 BGCb5eoEsk4AfufTLOxXXJ8ISEddaiSfB0yPgI0yMfR+XhzelOineSX1nRzW0muS58eq
 x0Hj9P7vXSukaD0PZtSmbw/WK43UXJZzJ2QBO5rLLu4g99TlPj2/S3SBb0J/LDdwMxOH
 qB2w==
X-Gm-Message-State: AOAM5323C4DUSJBCE7jEZ2iqtWRWsrulKOmniFd6M4hoPaDJSR9FlpxO
 wCtd/1jKdhmexadVaD8G0dbw0yiQbSW9bglhqgM=
X-Google-Smtp-Source: ABdhPJzIyVYn8F4eoIN3DBF533pFAAVMubGO5ir9js4F/3H3e0CgUmktzu1+MhLKl3UeAz4cXxJpfDX0L9QBhZyNayw=
X-Received: by 2002:a50:f396:: with SMTP id g22mr26666451edm.220.1597868239564; 
 Wed, 19 Aug 2020 13:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200819134419.2054-1-christian.koenig@amd.com>
In-Reply-To: <20200819134419.2054-1-christian.koenig@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 20 Aug 2020 06:17:07 +1000
Message-ID: <CAPM=9tyQpeEQ4PPDWoCC2osWv5xcf+6avBni49hF86zgE15zig@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: fix broken merge between drm-next and
 drm-misc-next
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCAxOSBBdWcgMjAyMCBhdCAyMzo0NCwgQ2hyaXN0aWFuIEvDtm5pZwo8Y2tvZW5pZy5s
ZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gZHJtLW5leHQgcmV2ZXJ0ZWQgdGhl
IGNoYW5nZXMgdG8gdHRtX3R0X2NyZWF0ZSgpIHRvIGRvIHRoZQo+IE5VTEwgY2hlY2sgaW5zaWRl
IHRoZSBmdW5jdGlvbiwgYnV0IGRybS1taXNjLW5leHQgYWRkcyBuZXcKPiB1c2VycyBvZiB0aGlz
IGFwcHJvYWNoLgo+Cj4gUmUtYXBwbHkgdGhlIE5VTEwgY2hlY2sgY2hhbmdlIGluc2lkZSB0aGUg
ZnVuY3Rpb24gdG8gZml4IHRoaXMuCgpXaGVyZSBpcyB0aGlzIHByb2JsZW0gbm93PyBvbmx5IGlu
IGRybS10aXAgb3IgaGF2ZSB3ZSBiYWtlZCB0aGUgYnJva2VuCm1lcmUgYWxyZWFkeT8KCklmIGl0
J3MgYmFrZWQgdGhlbiAnUmV2aWV3ZWQtYnk6IERhdmUgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5j
b20+YAoKSWYgaXQncyBub3QgYmFrZWQsIHRoZW4gcGxlYXNlIHVzZSB0aGUgZGltIGhvd3RvIHRv
IHB1dCBhIGZpeHVwIGluIHRoZQpyaWdodCBwbGFjZS4KCkRhdmUuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
