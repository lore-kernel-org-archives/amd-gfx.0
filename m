Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01286CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EC321734
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EC321734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD346E896;
	Mon, 28 Oct 2019 14:03:10 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C67D6E891;
 Mon, 28 Oct 2019 14:03:09 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id g7so9588942wmk.4;
 Mon, 28 Oct 2019 07:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rJWcxYoQBw9FC5bU2SEpgmxglktki3/N2UJx+E1uoHc=;
 b=lxa9CVnAZ51jm46qoF6QJmVqDQbwfapCgOhRYqoj5Eci2nBq8BRCgd1xRNRP5hxp8L
 kW+q23iZMQdvVS2mY+smuXgPUwv+GWEC4cgKzFsJJ64oIgE5WhIJ12Ie8uB+vi/xj9xs
 HTMApdV3eQkiqMpjNn8SgmHQan2TEgjMfVnj/QJ6LnDBmP1OROAZNakJMDT9T8i8kyT4
 FZ1rnfwxMwNm0NnOL8+8DF/MP738g1NhoXUQH7JTocotWmRovSQ5RV3OacmvMy81q6jK
 Uzh8z+tsRCLV3hT7v3pPAUI/vM62WARqGL5K36FnjnF6isdbW6jeODqCzLqBAVo7xrJm
 rRNg==
X-Gm-Message-State: APjAAAUmEyf4/WCsEaloVUkhcELwNop/VJ75AbGwsRTim3idGYSMW+FR
 B9k882drd9jE5Ced1+Pob9vPyqdx/RG8CYs47A5FTQ==
X-Google-Smtp-Source: APXvYqzTcpDANF0xCHv5oY8VRV1/vSnNLjz/Lq4qlStLKG0XmYYPuKxqosYZHm6ZF4EgQwtb4EEs/MBIX4kXxxrE4I4=
X-Received: by 2002:a05:600c:24cb:: with SMTP id
 11mr99575wmu.141.1572271387834; 
 Mon, 28 Oct 2019 07:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191028092005.31121-1-wambui.karugax@gmail.com>
In-Reply-To: <20191028092005.31121-1-wambui.karugax@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2019 10:02:55 -0400
Message-ID:
 <CADnq5_P7spc_po3rCYCVHwqCRp4x1CX60yTX2CXQcYCt9FXDqg@mail.gmail.com>
Subject: Re: [Outreachy][PATCH 0/2] sparse warning cleanup
To: Wambui Karuga <wambui.karugax@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=rJWcxYoQBw9FC5bU2SEpgmxglktki3/N2UJx+E1uoHc=;
 b=DanefYv1nIEQfdUnfpue30LOoTxTvjUO5ceGUpcB0pjWXEVXGaoLDGqmzz1V/0GsbN
 4Aa1JZu7SxLgnmJDauSoR3WjisKMPOD/YjE5iZ7c6ZEOa8HMj5gtNPIQ/iM7xr/jhPmm
 3wTOXCVHpBZ0FG6f2Qo1g3R2fYzpI8Wy3hpsWoRJ0r+7NZ/wXB7NuNDa/fhqXjyG0AYU
 fdGyxvG6tb9xhM+ISjrWEepXeGS7MXlYw6qGlBExSPJfzXP0cyk4nlmnNMC3doTn5b7Z
 qGJJVt34VE/LK+gG95dBHx87hWDY5/UJdBZ2bh7Jqn5HjJLmav+IRJAEzP2I7vR8+8kn
 2jfg==
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 outreachy-kernel@googlegroups.com,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028140255.pHnE-c5R64i3laW84T-EEtNV01qjMOR2352cP4kbsPI@z>

T24gTW9uLCBPY3QgMjgsIDIwMTkgYXQgODo0NyBBTSBXYW1idWkgS2FydWdhIDx3YW1idWkua2Fy
dWdheEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gVGhpcyBwYXRjaHNldCBhZGRyZXNzZXMgdGhlIHNw
YXJzZSB3YXJuaW5nIGFib3V0IHRoZQo+IGBhbWRncHVfZXhwX2h3X3N1cHBvcnRgIHZhcmlhYmxl
IGFuZCBjb3JyZWN0cyB0aGUgbWlzcGVsbGluZyBvZiB0aGUKPiB3b3JkICJfTEVOVEgiLgo+Cj4g
V2FtYnVpIEthcnVnYSAoMik6Cj4gICBkcm0vYW1kOiBkZWNsYXJlIGFtZGdwdV9leHBfaHdfc3Vw
cG9ydCBpbiBhbWRncHUuaAo+ICAgZHJtL2FtZDogY29ycmVjdCAiX0xFTlRIIiBtaXNwZWxsaW5n
IGluIGNvbnN0YW50CgpBcHBsaWVkIHRoZSBzZXJpZXMuICBUaGFua3MhCgpBbGV4Cgo+Cj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICAgICB8IDUgKysrLS0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgNCArKy0tCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyAgICB8IDIgKy0KPiAgMyBmaWxlcyBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiAtLQo+IDIuMTcuMQo+
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
