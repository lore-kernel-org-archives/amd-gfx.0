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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4494AC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18DF12073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qv7E+gqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DF12073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7BAD6E31E;
	Mon,  1 Jun 2020 18:21:52 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E90A16E30D
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:51 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id f18so10054144qkh.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P6N7qP6GvV6E0jmgTGYHFm7INHg3Fm+ETvuTkhQSqcY=;
 b=qv7E+gqArCrTXvSbYP6OnqWpMFfmrW6whR6qc0vXr8v+uYcRjFxq/RWzXDxxQuIbSY
 SkHCbrXb9cNqMDLa1Lt4f4ONHdwVO6aFr/I8sNeHwcr5dGRQDrn+v6beSXVwgriWjfFE
 iUoRzwN/0+YWtOeU2Lw5dOeAqorZAfmRWqZzTmV1FqYbS0KnjmZTbaz7zxfrY3Gjj+pR
 TMPDw+k2m5jnvZZhgHAeaUpFd1h4nR3oLoHlsS4HTMeBs3C3KSpLmY5rbScfv6KGTxnU
 Ire3J8iUvji5yFZwn3TwNPE37tmnzLEym8xOTtBT8zbcQE99CS6SCHeU6nGJ/n7SEeW6
 pMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P6N7qP6GvV6E0jmgTGYHFm7INHg3Fm+ETvuTkhQSqcY=;
 b=S9eo4/1oHEuJ7lPygcz4IVTFV+syh0WAHEhv6cXX/soWEnCwF6lc6DLG5zp8/hRS57
 izfuiNJqFFyxCiLztm570ZZJh3/6RbjuR8hhgxA98vW0Qg/GZhUXQM87Uo1oYbFyu5G5
 SV4att8Kc7g/q2/6V/5F5t793bYK0WJG5WtbsF+fj05ujWcjqAlVnLMNDnKJI2k7Wm4i
 IMPkMR/DXIiI7px7/FqJKHeEGe4GVlFd17fu+LQi0I52YdGsyRWJox20Oehpegg2f2Wa
 HZomP+T7HUFpa6bjmjX5vnBZSJfRTflFaeSGZDfu4Os5Gc3l9K8KukGASh83ICvqdqA0
 k1xg==
X-Gm-Message-State: AOAM531NGr5wjDTi3s2fqVmzi1UNqMk9YchzBKddlOqDVFXLjrshGrc/
 Xny/kj0XE3vrWhArjcG9rsGGk6Ww
X-Google-Smtp-Source: ABdhPJzavE/VVUMMLlCJr2kELhcGmbMRG83g1NBGgJuwF6Wt93LVBm+7DOCOXolTrmL1qCakpFqFGw==
X-Received: by 2002:a37:8d85:: with SMTP id p127mr19652801qkd.35.1591035710944; 
 Mon, 01 Jun 2020 11:21:50 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:50 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 125/207] drm/amdgpu: Sienna_Cichlid don't enable SMU for SRIOV
Date: Mon,  1 Jun 2020 14:19:32 -0400
Message-Id: <20200601182054.1267858-36-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: shaoyunl <shaoyun.liu@amd.com>

SMU firmware already been loaded from host, don't enable it for now.
May need to re-work it if we want to enable the SMU for guest in the future.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 89c3727b7a8e..f4d4d91ebee2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -493,7 +493,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
-		    is_support_sw_smu(adev))
+		    is_support_sw_smu(adev) && !amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
