Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4C8C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2331F2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep6eT++f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2331F2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D81C56E34E;
	Mon,  1 Jun 2020 18:22:26 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E976E34E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:26 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id w1so10017822qkw.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ybfJ2ccY1YEVHYYJ4YVqwQFJWjyqwOsiCg0IcjRjP7c=;
 b=Ep6eT++fxmxUDB/Bp7UICqK8iXOww7DWhgNq363SDJPU0RXyCWBS9p4aTi80paP3+2
 QSepD33MmIXigPyNHfD3iJLDNZKtWJGlSU6y+Tv1qElDUMiRnJEP3igKSGmaTBTExsg3
 E6Th2EHvOenUZ/9bEtuOX++hZ9KBWaatC+pwZViiW1HV11CcjGiQWo9MWSDr6if9YI0C
 D1ylLU4ldUhCqbKtGIbPXkpZAyQ8yud3aN8rj6VUshT8Q5US+utSC9nPc9LE/ZRqZ4mV
 wF44xLaTYnX1zPwbHwXfn5PmYKd8RSJEayLTUpcjcGPfrPvSUMvcJjthnng1fDFU6P0U
 EKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ybfJ2ccY1YEVHYYJ4YVqwQFJWjyqwOsiCg0IcjRjP7c=;
 b=XeyIREgzewd8gVWvxkoJVkY1DG7+4VnT2vufO1ga79uwbPlSzcU3Uz/XxHENrKjOpa
 BYtHimQ2/ZmCoq84EZCQF4bOqeJeuOH0AeL4bTyurZ0Ds3Pin7ttI497QrEImVYqxxDm
 Z+7I0hiwJxFRn2hCWLMaFKjSnbxUulG3ddyWL/MQ7qHYypCpldN9XAyp7bGy0docmKAV
 YZVAhhXiZGCQuJE2bIONlGfFWzCnlwZ/jwAs6eZLSHDy0+kcWa5oets+aUJepgbkiRsv
 9oTVwSGpVP+lxdqpZA96RWOCBR6dYXM2+JeS2EUtWBtbBh6BCvRbMjZAE6/cOgwExE/k
 gWiQ==
X-Gm-Message-State: AOAM530hMdC8mH+IeAXyc2Rc94HPMljBzddidas+YlUoD5IA/6PO2QUr
 klvnreiFAGVDu2oaqHhmIEgNfdSh
X-Google-Smtp-Source: ABdhPJzSrZ78NrS3dEPZYerN2/ui+ffb67K6w3EhjZBUxwMKzO87WZ9QRLIXXXbCAG6qglwD//e4hg==
X-Received: by 2002:a37:9c57:: with SMTP id f84mr21155864qke.128.1591035745175; 
 Mon, 01 Jun 2020 11:22:25 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:24 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 152/207] drm/amdgpu/vcn3.0: schedule instance 0 for decode and
 1 for encode
Date: Mon,  1 Jun 2020 14:19:59 -0400
Message-Id: <20200601182054.1267858-63-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VCN3 has 2 unsymmetrical instances, i.e there're less codecs
on instance 1, we use 0 for decode and 1 for encode for now

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 875bdc877c3d..2497f29bbb35 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -167,6 +167,8 @@ static int vcn_v3_0_sw_init(void *handle)
 		ring = &adev->vcn.inst[i].ring_dec;
 		ring->use_doorbell = true;
 		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
+		if (i != 0)
+			ring->no_scheduler = true;
 		sprintf(ring->name, "vcn_dec_%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
 				     AMDGPU_RING_PRIO_DEFAULT);
@@ -183,6 +185,8 @@ static int vcn_v3_0_sw_init(void *handle)
 			ring = &adev->vcn.inst[i].ring_enc[j];
 			ring->use_doorbell = true;
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
+			if (i != 1)
+				ring->no_scheduler = true;
 			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
 			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
 					     AMDGPU_RING_PRIO_DEFAULT);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
