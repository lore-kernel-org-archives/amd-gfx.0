Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2A7C32771
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 11:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A3220656
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 11:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0WAfZ+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A3220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C7E6E8FC;
	Thu,  9 Jan 2020 11:11:10 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1561E6E8FC
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 11:11:10 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id g17so6964675wro.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2020 03:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e1fv3pyPwdgR9YD7bygWUQUrB5fLS6/OeXepJ5OusQw=;
 b=S0WAfZ+ygjRLy6jvp2ll3ZmJWUMZpCPet/hcts5cGW1yU/9iVSCvZJrGebIuvjGWcu
 HqM+e2oMbLf6y12XLQ/3UgMHVAzgJt6yk82EkB19z++FVEw4gmfEqg/EDii766EZRylT
 e4vQXZqAmPEohjH6aZnCp0o2K1Ljy+CyCEVkqEzR6lWAN5TKjqFK2PyQTHc+jaxNfO/V
 cxCx7L7FesyrM/4go64MwxhGQQJi2MBL6FQBKu8dMv0nti5ch3PIW/xP+/NPw704mp4u
 FGeAkf05L6Akp9etNB11KTJqrgsiDZbDOlRbFFPa25fsiJFQiGC0wksV6T0MbBq5AMN7
 xceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e1fv3pyPwdgR9YD7bygWUQUrB5fLS6/OeXepJ5OusQw=;
 b=FTcE8bdhOWDKo7HL0Qj9KNjrkYvOta/MDIdKtDPXkP4qTxAJhgrX90/m1a7H+6Ywlc
 zxWLnw7Q5Dv1MA8i3H5ZM2BTGT0tMqayY4Uv5Z5WiAfYJOMoT2uNK2+9UwGS/+k0WWIX
 PNGA4s8OWP4ngXr8fEGztyIKQRHnsbqYbsHSNvvW1w9DPr7772Q+BA/Ae6v3sVyPTwX0
 9Me84uHqEATNzO5b05ElXhAaWyscjf/+5Is0j2JTct+YYxR3PmkmkkOy8nbMG745qdCq
 IFQzlbK0Ug1oQ7qXA+arNQlA0mi9+7fAq5O7aDwmuilOdhF2dsCu0a1TOK5RFyPHsMo3
 nWTA==
X-Gm-Message-State: APjAAAUpd8299PNnez1uR7oYaUy2dau1y57JCsBdHMpuhfQb+JuoT+Dn
 VNe335hUHFwzAGA+6wmN+cyPhep7jNgq8Dpr
X-Google-Smtp-Source: APXvYqw3O0fkAk14C45zFHYuNBRAGmsAeULj7EtsUUdCMHcgXxPb+E7kXRuxA9BL5DfYiNJQV8OU0g==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr10066621wrp.111.1578568268389; 
 Thu, 09 Jan 2020 03:11:08 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2F7000EF398E6A7C8DDE3A.dip0.t-ipconnect.de.
 [2003:c5:8f2f:7000:ef39:8e6a:7c8d:de3a])
 by smtp.gmail.com with ESMTPSA id f207sm2821340wme.9.2020.01.09.03.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 03:11:07 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: error out on entity with no run queue
Date: Thu,  9 Jan 2020 12:12:01 +0100
Message-Id: <20200109111201.34613-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.1
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disabled HW IP's entity initialized with NULL rq. We should not
process any submit request from userspace for a disabled HW IP.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 614919f265b9..943e6075bdf9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -913,6 +913,11 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
 		if (parser->entity && parser->entity != entity)
 			return -EINVAL;
 
+		/* Return if there is no run queue associated with this entity.
+		 * Possibly because of disabled HW IP*/
+		if (entity->rq == NULL)
+			return -EINVAL;
+
 		parser->entity = entity;
 
 		ring = to_amdgpu_ring(entity->rq->sched);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
