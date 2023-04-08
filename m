Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B069EC77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 08:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B76B10E230;
	Mon, 10 Apr 2023 08:05:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A49810E0D2
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Apr 2023 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680961437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cWTGZwUDsK+ArhfUvsnQDdChpakeTyXMHjj4Kv1VcJU=;
 b=KieWFbmq1WnBk97p4I8uENpESW6+/s8uiTVC42y5gP72em1Vn7xFpV6eg5aMaSOKX0liEo
 i9EEIPkb/gWHyyC7RUfWZM7iCJxPwT38ErDCEQzzXmn1raOr/3ajLdAwrhVdx6i+ijkd6q
 y7wYwoSDXp5ajwqIVAcnVBVsq44n2RE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-kcE3p8CIPRC6Di1NGJs7sg-1; Sat, 08 Apr 2023 09:43:54 -0400
X-MC-Unique: kcE3p8CIPRC6Di1NGJs7sg-1
Received: by mail-qv1-f69.google.com with SMTP id
 o14-20020a0cc38e000000b005e62747d93aso3413314qvi.11
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Apr 2023 06:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680961433;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cWTGZwUDsK+ArhfUvsnQDdChpakeTyXMHjj4Kv1VcJU=;
 b=gyZCZX40xa3g3bu1o7tT4SPbsy655oUOkEArnPvLzmUqCMU/1c9M5tPpEicvutWSKI
 sKtjJfJDPxRDceWaPZuIcqBs1dNeOdGa3n6dRbAGrbYxN1oit8B41IaDOu3WbOIVrTMY
 8zM15JVBc7EdSG+L6gfOet5CyWFJFHnSi37XtUC6sC0xc0nhW0FGp5WxkP34EiHT/ltE
 /KrjrnIn98Ebi/lvgTSpk7LqMMX0EBpl3UQyxW455Q9xubuPzpoPYe6hBuiW+1XfW5qN
 8gcjNCKlCoNYy8TiQtKucheN0W+StNmQWCojCv8kn/Df1F5XKoGH5BUqQO6d4W89I0gA
 Cq8A==
X-Gm-Message-State: AAQBX9dpExsRFxxwyfSe7GdIOU0FtgpHXSN/ppttitx3kgVQqJyvSnZJ
 K81Hy1ONp+a1csk6j1f0HbJfyGHyJ+Tx1KX4/QEOuHt/HlcRdKRWeqYApUGi+bejk9IOtcI3lT6
 0BnSJIjAnAny+Z07BMxFyjuZzMA==
X-Received: by 2002:a05:622a:1ba4:b0:3e6:6d82:3fd8 with SMTP id
 bp36-20020a05622a1ba400b003e66d823fd8mr3795517qtb.17.1680961433686; 
 Sat, 08 Apr 2023 06:43:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350YDlN+3ZRDKytX5Na9sWA4wfmdLE+QkD9JBOEgqvZpj+T/K9mAWJXM0MJJelMtg0nudO6TROA==
X-Received: by 2002:a05:622a:1ba4:b0:3e6:6d82:3fd8 with SMTP id
 bp36-20020a05622a1ba400b003e66d823fd8mr3795488qtb.17.1680961433420; 
 Sat, 08 Apr 2023 06:43:53 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 h22-20020ac85056000000b003e302c1f498sm1833122qtm.37.2023.04.08.06.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Apr 2023 06:43:53 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Pavle.Kotarac@amd.com, Jun.Lei@amd.com,
 nicholas.kazlauskas@amd.com, Charlene.Liu@amd.com,
 aurabindo.pillai@amd.com, Dmytro.Laktyushkin@amd.com
Subject: [PATCH] drm/amd/display: set variables dml*_funcs
 storage-class-specifier to static
Date: Sat,  8 Apr 2023 09:43:48 -0400
Message-Id: <20230408134348.2703105-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Mon, 10 Apr 2023 08:05:26 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smatch reports
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:44:24: warning: symbol
  'dml20_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:51:24: warning: symbol
  'dml20v2_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:58:24: warning: symbol
  'dml21_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:65:24: warning: symbol
  'dml30_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:72:24: warning: symbol
  'dml31_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:79:24: warning: symbol
  'dml314_funcs' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:86:24: warning: symbol
  'dml32_funcs' was not declared. Should it be static?

These variables are only used in one file so should be static.
Cleanup whitespace, use tabs consistently for indents.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../drm/amd/display/dc/dml/display_mode_lib.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
index 4125d3d111d1..bdf3ac6cadd5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.c
@@ -41,51 +41,51 @@
 #include "dcn32/display_rq_dlg_calc_32.h"
 #include "dml_logger.h"
 
-const struct dml_funcs dml20_funcs = {
+static const struct dml_funcs dml20_funcs = {
 	.validate = dml20_ModeSupportAndSystemConfigurationFull,
 	.recalculate = dml20_recalculate,
 	.rq_dlg_get_dlg_reg = dml20_rq_dlg_get_dlg_reg,
 	.rq_dlg_get_rq_reg = dml20_rq_dlg_get_rq_reg
 };
 
-const struct dml_funcs dml20v2_funcs = {
+static const struct dml_funcs dml20v2_funcs = {
 	.validate = dml20v2_ModeSupportAndSystemConfigurationFull,
 	.recalculate = dml20v2_recalculate,
 	.rq_dlg_get_dlg_reg = dml20v2_rq_dlg_get_dlg_reg,
 	.rq_dlg_get_rq_reg = dml20v2_rq_dlg_get_rq_reg
 };
 
-const struct dml_funcs dml21_funcs = {
-        .validate = dml21_ModeSupportAndSystemConfigurationFull,
-        .recalculate = dml21_recalculate,
-        .rq_dlg_get_dlg_reg = dml21_rq_dlg_get_dlg_reg,
-        .rq_dlg_get_rq_reg = dml21_rq_dlg_get_rq_reg
+static const struct dml_funcs dml21_funcs = {
+	.validate = dml21_ModeSupportAndSystemConfigurationFull,
+	.recalculate = dml21_recalculate,
+	.rq_dlg_get_dlg_reg = dml21_rq_dlg_get_dlg_reg,
+	.rq_dlg_get_rq_reg = dml21_rq_dlg_get_rq_reg
 };
 
-const struct dml_funcs dml30_funcs = {
+static const struct dml_funcs dml30_funcs = {
 	.validate = dml30_ModeSupportAndSystemConfigurationFull,
 	.recalculate = dml30_recalculate,
 	.rq_dlg_get_dlg_reg = dml30_rq_dlg_get_dlg_reg,
 	.rq_dlg_get_rq_reg = dml30_rq_dlg_get_rq_reg
 };
 
-const struct dml_funcs dml31_funcs = {
+static const struct dml_funcs dml31_funcs = {
 	.validate = dml31_ModeSupportAndSystemConfigurationFull,
 	.recalculate = dml31_recalculate,
 	.rq_dlg_get_dlg_reg = dml31_rq_dlg_get_dlg_reg,
 	.rq_dlg_get_rq_reg = dml31_rq_dlg_get_rq_reg
 };
 
-const struct dml_funcs dml314_funcs = {
+static const struct dml_funcs dml314_funcs = {
 	.validate = dml314_ModeSupportAndSystemConfigurationFull,
 	.recalculate = dml314_recalculate,
 	.rq_dlg_get_dlg_reg = dml314_rq_dlg_get_dlg_reg,
 	.rq_dlg_get_rq_reg = dml314_rq_dlg_get_rq_reg
 };
 
-const struct dml_funcs dml32_funcs = {
+static const struct dml_funcs dml32_funcs = {
 	.validate = dml32_ModeSupportAndSystemConfigurationFull,
-    .recalculate = dml32_recalculate,
+	.recalculate = dml32_recalculate,
 	.rq_dlg_get_dlg_reg_v2 = dml32_rq_dlg_get_dlg_reg,
 	.rq_dlg_get_rq_reg_v2 = dml32_rq_dlg_get_rq_reg
 };
-- 
2.27.0

