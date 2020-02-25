Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26BFC35DF5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 10:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C7220726
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 10:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc+hah9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C7220726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4719189F1B;
	Tue, 25 Feb 2020 10:36:23 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B871989F1B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 10:36:22 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id w12so14101064wrt.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 02:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JMJz0yObESj9ku0XvHMC04ezWE1ieEuIhshkgi3NaIk=;
 b=Rc+hah9Y/2iNh+h84JE85IY9RlZ7F5JJh77YOmZyTYkcZgXKa5CjGn79NSKqEOQ8EZ
 pKvwyvYru7jIAZX45HnWk2guXiS2/57ziSvNIJ9JJObKXei3oPqwE3e4uSjwLVpQ+Vh9
 wsPUmNJ8dg4/glrSJFXJDV8xu+CMELc2z0Tww7Ll+FeFYyzbTdIKM/331l/Xus/3Zovw
 6BBaTLxmsOUSBP+u/J0KzUDxOwewfEntstGmr4Xl1Q1Y5oo4ZtGUTQJAcOJxQvChVPxa
 aNbIy0IdYe4KnKSu5faNdr1dBzNhCoKgeGAYL3BIYxpL1BG2Brx5l9fPj0P9rrUROHmn
 Zk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JMJz0yObESj9ku0XvHMC04ezWE1ieEuIhshkgi3NaIk=;
 b=tl79wH/i0wKAXU+YFEJCN3BP3N7nyPmLvZT40mxadH8ZLbuREnF09eHRug4M9IN3u5
 QbMMBgDje1MttgeFOA4f89+oQ7sykd3XRSTvxP60x7ZFzxNziVRiDwrvtJyK6wGcJMT7
 FAs/vUh4A4IIRvpu2C5r40AItH4jFBwlb62vsfETfrQXdcmrOdWz2e2acmm3w3cWpS9i
 wHN/Nn8X0fxY7vdrMKEhDwjgtd29SoUmojqL8sMJnGjcFWlkwRqApBrmZvWfx9be29jO
 1hh4tqroM1+zizFFiVDC1Ms1XBwmJI9bTdguP3xIQ8UP0WR5OBL+/dpRxfqek43RfiFI
 MKMg==
X-Gm-Message-State: APjAAAW1crG4sq/MYCJw1u3JlnfdPpJLXR5XDz/Cod5pN9Wn4eBul1Pu
 Zif+KtH+Yh4xeB25aPZzHxpAEuUKVR/FNw==
X-Google-Smtp-Source: APXvYqwiN+Ugu/1qYyCV42oqk3XUsb5rKfppztQvwVTixX1ADcajSy2OboRMJKJ6obmHzGPRSvJa3Q==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr71151729wrj.261.1582626981061; 
 Tue, 25 Feb 2020 02:36:21 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2CDD00254CE01175F766E4.dip0.t-ipconnect.de.
 [2003:c5:8f2c:dd00:254c:e011:75f7:66e4])
 by smtp.gmail.com with ESMTPSA id p26sm3447085wmc.24.2020.02.25.02.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 02:36:20 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: do not modify ring before doing ring validation
Date: Tue, 25 Feb 2020 11:39:19 +0100
Message-Id: <20200225103919.10158-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

changing ring->sched.ready should be done only if the ring is initialized

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 539be138260e..18e11b0fdc3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -344,12 +344,13 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
  */
 void amdgpu_ring_fini(struct amdgpu_ring *ring)
 {
-	ring->sched.ready = false;
 
 	/* Not to finish a ring which is not initialized */
 	if (!(ring->adev) || !(ring->adev->rings[ring->idx]))
 		return;
 
+	ring->sched.ready = false;
+
 	amdgpu_device_wb_free(ring->adev, ring->rptr_offs);
 	amdgpu_device_wb_free(ring->adev, ring->wptr_offs);
 
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
