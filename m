Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFAFC282D3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 09:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC1AE10E529;
	Tue,  4 Mar 2025 09:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="rlZZuBnk";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D1110E33D;
 Mon,  3 Mar 2025 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=txe/FCPWRDijIRM2J14dylswI3oOXHv8ky3SGbNbIgE=; b=rlZZuBnkzyt7ZRBK
 UJhcYmaIGcN34uExHJWZiEVDTy9IHDpVje+oEdAM8PhH79alsdHMRT+fVVpuaIE6DLYc5Sfjvm1kF
 4KnE766bfqoojTDSnSvfGxO3PvF9m81LqFUhnC0MzyJ5Nr4Jvz1zLkpDqlQD8siA2+MQ6GDv7t7gF
 weVDLqeVVmJ81AHpd+7B6nWuCReFEqgHK3VMuqtya3eXvRUmQojn2mqc8NNe8lg+SpBc1WsYkdL35
 ZnJLQcs8xYs9yYmVpxqj2tGOl5axCuxNh78fHJc5OEw4nyaZBpVGMEjNkOghGporvJ5NTH9uxq5VD
 O6QuHGamPTtU2PirEg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <linux@treblig.org>) id 1tp6x5-0028PG-1c;
 Mon, 03 Mar 2025 14:39:27 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 christian.koenig@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com, austin.zheng@amd.com, jun.lei@amd.com,
 kenneth.feng@amd.com, linux-kernel@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 5/6] drm/amdgpu: Remove unused print__rq_dlg_params_st
Date: Mon,  3 Mar 2025 14:39:21 +0000
Message-ID: <20250303143922.36342-6-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303143922.36342-1-linux@treblig.org>
References: <20250303143922.36342-1-linux@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 04 Mar 2025 09:21:05 +0000
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

print__rq_dlg_params_st() was added in 2017 by
commit 061bfa06a42a ("drm/amdgpu/display: Add dml support for DCN")
but has remained unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../drm/amd/display/dc/dml/display_rq_dlg_helpers.c   | 11 -----------
 .../drm/amd/display/dc/dml/display_rq_dlg_helpers.h   |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
index 412e75eb4704..12ff65b6a7e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.c
@@ -122,17 +122,6 @@ void print__data_rq_misc_params_st(struct display_mode_lib *mode_lib, const stru
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
 }
 
-void print__rq_dlg_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_rq_dlg_params_st *rq_dlg_param)
-{
-	dml_print("DML_RQ_DLG_CALC: =====================================\n");
-	dml_print("DML_RQ_DLG_CALC: DISPLAY_RQ_DLG_PARAM_ST\n");
-	dml_print("DML_RQ_DLG_CALC:  <LUMA>\n");
-	print__data_rq_dlg_params_st(mode_lib, &rq_dlg_param->rq_l);
-	dml_print("DML_RQ_DLG_CALC:  <CHROMA>\n");
-	print__data_rq_dlg_params_st(mode_lib, &rq_dlg_param->rq_c);
-	dml_print("DML_RQ_DLG_CALC: =====================================\n");
-}
-
 void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_dlg_sys_params_st *dlg_sys_param)
 {
 	dml_print("DML_RQ_DLG_CALC: =====================================\n");
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.h b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.h
index ebcd717744e5..2bc64c4081dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_helpers.h
@@ -35,7 +35,6 @@ void print__rq_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dp
 void print__data_rq_sizing_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_sizing_params_st *rq_sizing);
 void print__data_rq_dlg_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_dlg_params_st *rq_dlg_param);
 void print__data_rq_misc_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_misc_params_st *rq_misc_param);
-void print__rq_dlg_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_rq_dlg_params_st *rq_dlg_param);
 void print__dlg_sys_params_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_dlg_sys_params_st *dlg_sys_param);
 
 void print__data_rq_regs_st(struct display_mode_lib *mode_lib, const struct _vcs_dpi_display_data_rq_regs_st *rq_regs);
-- 
2.48.1

