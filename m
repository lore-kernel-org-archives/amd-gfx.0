Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17C2C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 16:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE7364FBB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 16:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE7364FBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qtec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B7036EA51;
	Wed, 10 Mar 2021 16:37:07 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D3D56EA56
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 16:37:06 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id e20so7314063ljn.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 08:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtec.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IkmW2GvjqGWts2vPAfis7GUqTOxPlIzb1CZYJYGpMME=;
 b=GODj3reE+EBC+KyzxwypFssgDByJDM+onjtNQHeM27vWvLdCqxABZeo4InGHNq29CH
 s4xAf/jsadcR28qkpE9OKvbOoEN06BXkj5tT/O5gJj88sibReqzJMxkjJIR0bbmC8/ur
 P7sCIgK4eKNLw81XGdRKs6WZ0jD38AdhrxSeWq1p9mE8AO/AKD+aatuDOOpLX4/MW9m6
 g1NYzb2lF3pr0SmKbpDQofzv+ZdyCOFJWR6TboyexTyCaHFS9z/GHq2Uz+YEgVVfpklD
 lZiKygPz4Klu1svIlHFgfq0VD/IAgQupazGb1mtXY0nfNxCs6KH8xfkM5FkdvWL3SuBQ
 k1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IkmW2GvjqGWts2vPAfis7GUqTOxPlIzb1CZYJYGpMME=;
 b=QSLxpV77Vu3TINjgTl3H/iOvPu6XBzgjDtBIAJSrukjPHUaxS1Q2kzMQDk6njr3Hcv
 iewmIj/QS6CdXb6ESBiUn5lNsZch7BVcBkajN8VJUFKnZOBG/b9g/VjWNYI3MH/WiIe9
 XW8FXYXF27oHp2hSU+a/KHiVzGM8cAVdu6O2DNxWZW4OdebjZYcFiSX0FA1RPAqtC61y
 nrEsBUfcI23LxM81XDqB6LzNFpczyQcm2iLnYriLPhE3y9uw9uOHOIP0FjZm5Ja1Fg4C
 vMEad0bmyAyrh//uYu18BkaXrjfZySlWHwSC60Dnvw1zcuk1+QJZy6DRaVUkPIl/moYu
 1eDA==
X-Gm-Message-State: AOAM532IGxC2HURGfHh6eGXtWG+glwSIpjggNk/jv8GyqQ51Cw8cRptq
 aB/IvKOmcQkiW6sMmOBRp4EJoA==
X-Google-Smtp-Source: ABdhPJy/e5j6tJye7L9eF/hLH4FCYLVMSzfrfMtWZuFThVQR3RMJkkYsQZ7O3gNjRWcN3Ff6vXuUTg==
X-Received: by 2002:a2e:9d8f:: with SMTP id c15mr2289953ljj.494.1615394224788; 
 Wed, 10 Mar 2021 08:37:04 -0800 (PST)
Received: from localhost (80-167-86-46-cable.dk.customer.tdc.net.
 [80.167.86.46])
 by smtp.gmail.com with ESMTPSA id q17sm1846587lfm.168.2021.03.10.08.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Mar 2021 08:37:04 -0800 (PST)
From: Daniel Gomez <daniel@qtec.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Huang Rui <ray.huang@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Yintian Tao <yttao@amd.com>,
 Guchun Chen <guchun.chen@amd.com>, Evan Quan <evan.quan@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH]] drm/amdgpu/gfx9: add gfxoff quirk
Date: Wed, 10 Mar 2021 17:36:52 +0100
Message-Id: <20210310163655.2591893-1-daniel@qtec.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
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
Cc: Daniel Gomez <daniel@qtec.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disabling GFXOFF via the quirk list fixes a hardware lockup in
Ryzen V1605B, RAVEN 0x1002:0x15DD rev 0x83.

Signed-off-by: Daniel Gomez <daniel@qtec.com>
---

This patch is a continuation of the work here:
https://lkml.org/lkml/2021/2/3/122 where a hardware lockup was discussed and
a dma_fence deadlock was provoke as a side effect. To reproduce the issue
please refer to the above link.

The hardware lockup was introduced in 5.6-rc1 for our particular revision as it
wasn't part of the new blacklist. Before that, in kernel v5.5, this hardware was
working fine without any hardware lock because the GFXOFF was actually disabled
by the if condition for the CHIP_RAVEN case. So this patch, adds the 'Radeon
Vega Mobile Series [1002:15dd] (rev 83)' to the blacklist to disable the GFXOFF.

But besides the fix, I'd like to ask from where this revision comes from. Is it
an ASIC revision or is it hardcoded in the VBIOS from our vendor? From what I
can see, it comes from the ASIC and I wonder if somehow we can get an APU in the
future, 'not blacklisted', with the same problem. Then, should this table only
filter for the vendor and device and not the revision? Do you know if there are
any revisions for the 1002:15dd validated, tested and functional?

Logs:
[   27.708348] [drm] initializing kernel modesetting (RAVEN
0x1002:0x15DD 0x1002:0x15DD 0x83).
[   27.789156] amdgpu: ATOM BIOS: 113-RAVEN-115

Thanks in advance,
Daniel

 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 65db88bb6cbc..319d4b99aec8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1243,6 +1243,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	{ 0x1002, 0x15dd, 0x103c, 0x83e7, 0xd3 },
 	/* GFXOFF is unstable on C6 parts with a VBIOS 113-RAVEN-114 */
 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
+	/* GFXOFF provokes a hw lockup on 83 parts with a VBIOS 113-RAVEN-115 */
+	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0x83 },
 	{ 0, 0, 0, 0, 0 },
 };

--
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
