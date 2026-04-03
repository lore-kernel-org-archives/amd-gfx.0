Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070E5E7E35C
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 09:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9078010F483;
	Fri,  3 Apr 2026 09:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c6oJoali";
	dkim-atps=neutral
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9F110F3C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 08:22:28 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5a0faa0d15cso2001786e87.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2026 01:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775204546; x=1775809346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YpDlKi8KTsQjgbsGCm7tac5gEEEqVyIzql0pN8aHQYU=;
 b=c6oJoaliBbjU/A1Mu5ObDa83jgCd4LESl6BvrjrJSoFAA7E3MNBmusKP6gHq+toQcW
 p3qHKPW2kThfKNThOzcTAeFqEg054jfM7VKTZoKex1SHXkNW5vqm4IXGVKK2xnyg4UG/
 3XtAqjM4sk+Wo2TuN97LvuVZGkCwkJnRU3Ca+pZ3AvEdDAQU4Jd+714wBfwZfW3c53bI
 +a8KQtL3mVWfVmHvRnSFeoxw5Cnq8ctaf/zXJr8/Cxs+rg96XnThc/0QR2URNR6u2n10
 KfKRKQjbAMFfwoQY/RP+7y3ZrQ9/dXlHar4Ru0eppCmZn5oYTf5Ypb80dYdH6SLajRwi
 BddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775204546; x=1775809346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YpDlKi8KTsQjgbsGCm7tac5gEEEqVyIzql0pN8aHQYU=;
 b=f3HMKY+jeWTZCyD6wPI1c+zMRCWpa57dpREl3MHYX0LouIJpYSs9wPJ1X8mBk4gr3X
 TcJExX1No6uDyLIY6UO070+uiyPJDssHNquDTTs0yz+wBt2UC64ZPb7FO516ikmdSrFJ
 rsW3YPsghR5zfSBB+Q0VboXHWsUbBXzUT19pqiNVMhhUDEz704qS/C6dPeKMJ4TAfupY
 GZV/UogmLSftoh1TdDG3q97rzOTj00QjW3qTgGqeBLy39agCFf2Op/VOKLi66e+jKUgo
 KvnfL85bB5qwXWQyisuAtUWDHw+BFQiDfEJoFVMs8zDTKg4L3VwonztJVgl2DyFKNjYE
 LBEw==
X-Gm-Message-State: AOJu0YxcP43vTxJKUhuwZz4hsLRZcCf73LTVXJDtxdxjBcK10ito3Q6I
 RNvMvgrv1bVF1pEnL2KVqvYglYKy92trWXX+VdQcy21tqayAtbAF/xMR
X-Gm-Gg: AeBDiesLmead/vCam+lhXR71zJO7JQLr8NMuUdmDBMlxO/FTe5kqxMj/pDd+Mtop9Mb
 olUuxXf9xIKA0tAJ6+4gNVFfSgbm2iVxCqZ9LyfnmngFNvM7gFIgdLAKhgn2M7lodIFE9lgsZsq
 9pjDeHNkbuzX/GfHL6mAijwps06Pm44WAR6rijZhfA1rwR0gbpDuXe2j5Ox4MzLUEpW+2X8mOVr
 6yfbOcuLQM2RGqTX1VSPzHfMgrhndQ5gMX5MM1hrFRE+iEfku/GvpgsS/JX70pPXaDgLOQJ3LtE
 d9mwQAOzLlF+pmor8mPYbDiS95TNDaCu1fKuDy/cc8quD6+cFYRKUoRUtLLBjtVtyizXBKAu9Nz
 qcR9vl/fQU0W62vU/tZeLrQkqe9o+niwZKAGNOtxl4u3zPfEllF6kbGzgOWkClZgx+Y7tf3ll39
 EKmQcr3mw9y2Qg8dsorJ29qzQ0woQGlARVYkes3527Sepwqmg/Z9R4jKug60BdmHc=
X-Received: by 2002:a05:6512:3981:b0:5a2:bedb:2119 with SMTP id
 2adb3069b0e04-5a337580564mr673418e87.26.1775204546098; 
 Fri, 03 Apr 2026 01:22:26 -0700 (PDT)
Received: from localhost (94.191.136.33.mobile.tre.se. [94.191.136.33])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6c957dbsm1266019e87.1.2026.04.03.01.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 01:22:25 -0700 (PDT)
From: Linus Probert <linus.probert@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linus Probert <linus.probert@gmail.com>,
 "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [PATCH 2/2] drm/amd/display: Remove unused NUM_ELEMENTS macros
Date: Fri,  3 Apr 2026 10:22:07 +0200
Message-ID: <20260403082207.1533450-3-linus.probert@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403082207.1533450-1-linus.probert@gmail.com>
References: <20260403082207.1533450-1-linus.probert@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Apr 2026 09:29:14 +0000
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

Removes unused NUM_ELEMENTS macros. Discovered while removing cases
where ARRAY_SIZE from the header <linus/array_size.h> can be used.
This also aligns with the array_size.cocci coccinelle check.

Suggested-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Linus Probert <linus.probert@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   | 3 ---
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c | 3 ---
 drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c      | 2 --
 drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c      | 4 ----
 4 files changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
index f8f6019d8304..2bdd063cc1e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
@@ -49,9 +49,6 @@
 #define FN(reg_name, field_name) \
 	dpp->tf_shift->field_name, dpp->tf_mask->field_name
 
-#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
-
-
 enum dcn10_coef_filter_type_sel {
 	SCL_COEF_LUMA_VERT_FILTER = 0,
 	SCL_COEF_LUMA_HORZ_FILTER = 1,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
index 62bf7cea21d8..7b7a0c660d47 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
@@ -49,9 +49,6 @@
 #define FN(reg_name, field_name) \
 	dpp->tf_shift->field_name, dpp->tf_mask->field_name
 
-#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
-
-
 enum dcn401_coef_filter_type_sel {
 	SCL_COEF_LUMA_VERT_FILTER = 0,
 	SCL_COEF_LUMA_HORZ_FILTER = 1,
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
index ea73473b970a..fa600593f4c1 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
@@ -43,8 +43,6 @@
 #define FN(reg_name, field_name) \
 	mpc20->mpc_shift->field_name, mpc20->mpc_mask->field_name
 
-#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
-
 void mpc2_update_blending(
 	struct mpc *mpc,
 	struct mpcc_blnd_cfg *blnd_cfg,
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
index 6bfd2c1294e5..ec2181d9f20b 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
@@ -40,10 +40,6 @@
 #define FN(reg_name, field_name) \
 	mpc30->mpc_shift->field_name, mpc30->mpc_mask->field_name
 
-
-#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
-
-
 void mpc3_mpc_init(struct mpc *mpc)
 {
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
-- 
2.53.0

