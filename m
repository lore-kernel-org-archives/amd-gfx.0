Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177A1C9831E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 12:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C7DA10F4FE;
	Thu, 24 Sep 2026 12:46:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="juJW0Oca";
	dkim-atps=neutral
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B4D10E8F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 14:50:18 +0000 (UTC)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469a34908so717573b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790175018; x=1790779818; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+9dAfw6j+gd4CFGZQW7IESgJBRKBFJ7eBXdntcdN5b4=;
 b=juJW0OcapCbSTx5/oG3wuzIi+/r7VUoETlij5NGpeFl9GKGwPUplYM6dw2FdZNqcR7
 wtxxhMcPu7XjRMtGL2NRgUudNq414hmZJcBSkUHsDGfx+ESIDCKQPlr31n/KfzQHjX9C
 I7IUyqlZ57vMnavspPF5Wmb/sPMT4ZZEsUxl44ANWBwdELhEp4qEK+AM2bUejzCxCoGe
 bCktjW9KVbAjYspJizs5lJ1tblT4XTR5kY7dcZrZmkuhihxCl6YH//DpogTGPvsA+Oka
 6wkQSHzkhA3Uez4lHS85dLRxITIZ9JXu0OQSxe9TtS5eIs/aKpJwcqj++WWnpH3Js71U
 MSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790175018; x=1790779818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+9dAfw6j+gd4CFGZQW7IESgJBRKBFJ7eBXdntcdN5b4=;
 b=qdTLCH68UlfBHAtcStSfhhUhN3RLsYxevOATTKUHqDoF7jbLLWoqQP4y9FUSe/710e
 2GaQO3luFX28X2GDzR0v4jhSpVF0flkDSsmmWRQmMHB0EVwV4yYUb6dtE68xePdcinSG
 rQwLTfO/YwdK8RHak3UYCGQG5zJwJr0cq1cgofOtko1HLou0iiAVIRmK7f/HmCBXpNF+
 7JwiiZs1LM/2tkdCA56OG3b+Li1BalGskr5oaRdDY6m8+fVfvGI6BS4qW5mKGif4juJi
 sXBqOUppDGASW7lCLYBcHgV6349Hukl7lPXgqbtICUhNQ4YWkL1xOfcxu1ao3+ZIorkg
 jUfg==
X-Gm-Message-State: AFuF++kpE5h/BusJLWtMouwWOoFdNpAtdItup3iUIu5TWjraACbbyN+u
 brILjGUxNd+UxW7VZJx8Fsr3tuHR+3s1rnovHJuANVxFmuq1x9t8GQ1t
X-Gm-Gg: AYBFou0kJz+XJcd3w7hQcultX4GsCjiq/szDKOY0rvq7fa4WBMisk7j2co/YQvV/O96
 iW4NGG0UgUuT83HPfnRpcoWpAhLa8jmdFgRBVeGxbqJo3+F8gfAWb/DEmnWbdW9ZvD0w98MzR4G
 cZpgnFHDC5RrWkmr9r5LH+dabd1oIY/aIDnZIKMGGZRDNy64CMPouOoh0WT8UFTNFd+e/Ka0tRz
 GHnrMv08UIIBd2lFj1PX1irH8Vm+BOzNzWS8N5Q1jr8A6NGeBEvzwhcCLN9gCx7TcmFC3Yv8fx0
 9ZZ68MjyRxntrd0JJR18ItYk8a2ph8eVbqhHZ2AbDIKxNJUELQ9X+TDPl2OJrsz5e5iBH0srmSU
 SLEvOysL2rY/yeQmb2FIoSmv6Pi3ZY7mSfPVww2d8ir99ma9G+CDnei9aKvvuoO9U1cNriunycB
 8z2sNqc9mOxiNbJqYuONozsp18Z+ucbW1HmPFL68f7uh1COPcOMQrclQW1bJdrWAjK
X-Received: by 2002:a05:6a00:13a6:b0:878:34d7:6987 with SMTP id
 d2e1a72fcca58-87d1c9c6e01mr2838923b3a.53.1790175018176; 
 Wed, 23 Sep 2026 07:50:18 -0700 (PDT)
Received: from beelink.. ([187.13.30.172]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1d4c483asm1453655b3a.21.2026.09.23.07.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 07:50:17 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] drm/amdgpu: prevent parameter-space underflow in nested ATOM
 table calls
Date: Wed, 23 Sep 2026 11:50:01 -0300
Message-ID: <20260923145001.1244517-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Sep 2026 12:46:10 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

atom_op_calltable() invokes a child ATOM table, forwarding the
parent's parameter space with an offset:

    amdgpu_atom_execute_table_locked(ctx->ctx, idx,
        ctx->ps + ctx->ps_shift,
        ctx->ps_size - ctx->ps_shift);

ctx->ps_shift is derived from the child table's PS byte count
(ps / 4) in amdgpu_atom_execute_table_locked(), while ctx->ps_size
carries the remaining capacity from the parent. A malformed ATOM
table chain in the VBIOS (or a GPU that reports corrupted table
headers) can produce ps_shift > ps_size, underflowing the
subtraction to a huge positive value passed as params_size to the
recursive call. The child table then reads and writes far beyond
the stack-allocated parameter buffer.

Reject the call when the shift exceeds the available size.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e0e585f..638bd18 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -646,8 +646,13 @@ static void atom_op_calltable(atom_exec_context *ctx, int *ptr, int arg)
 		SDEBUG("   table: %d (%s)\n", idx, atom_table_names[idx]);
 	else
 		SDEBUG("   table: %d\n", idx);
-	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
+	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx)) {
+		if (ctx->ps_shift > ctx->ps_size) {
+			ctx->abort = true;
+			return;
+		}
 		r = amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift);
+	}
 	if (r) {
 		ctx->abort = true;
 	}
-- 
2.43.0
