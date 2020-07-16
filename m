Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30349C433F1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016D420787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBqQO/33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016D420787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BC796ECF1;
	Thu, 16 Jul 2020 21:23:25 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FCC56ECF4
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:22 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id b6so8601123wrs.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Fpm7TK8PS9glbLkp3Ggfkqp/Av0kPLC0aRBf+/rKVlg=;
 b=DBqQO/33tlFak9uWwrcso2lM/w2F9McBOaLDnl1Rp09+lHp+SR0k2MTGCoFK1IYO5s
 8/2+M2GwkCUjJuRJX6SHTpjWfHNbL3oN+1Mz8jGXjhWVfyTj9e5QsS520XYzsxzUt5ld
 ISLNw/p5nMVv01fJOclZ0BDnGMpDosAKzx8DmXiDqKzEpzsUcoVNZxCb9Z44glAoBpea
 MDW6GdZG+p2J38kYKkhg2NzaaFga6FCSstRUmZwe6yBMD1jA3yyxx60qbDpri9z4PBmR
 sgdsjDL/BWLSpUPw5Vk69Eu+YDuGaoJyMFqEk5/D8pJzIXQ2MShPGzmRjGwzQ0qo7Pu6
 Ob5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Fpm7TK8PS9glbLkp3Ggfkqp/Av0kPLC0aRBf+/rKVlg=;
 b=C+jawYdjn9QKm4Q+NdcjYA7Gnm4ruLq3bZqIFTzLBTry1FsGdExpGVAxlCsCc55lzR
 MieCjDw6G0wzllQifWJlLRiawsLxCZ2el9CtHI/T8O3P6IrgIyL8Lhy2+7l9n5D9bQMV
 aWrlQ2wrF4GioAoH+x0klCO9CFAHrxd3yxDm9XEC/z+xkBDaZG7FvoF8B1nAxq6fkrsB
 xcNvCatrl2amaNHMvsG/3im6lY0BlxK12/uMCKecn/p8JRZpfLlpEP0vipO7oPqNHLnY
 iigXmTXbxfkw1m5GVgNtmnwKZtc92Gd7a+pBCYeEs8qD4YoOpWPhW10jgmQg6DdvDpd6
 Dhlw==
X-Gm-Message-State: AOAM531jrUJqp4VpcqkxlQR9hWXya1yRliBKYu+oejCh/MpoKuxBJmxA
 WIpMFIARAxjhG3og9Bm1Kvs6Q7del2o=
X-Google-Smtp-Source: ABdhPJxRbdHOylhEY4VZ2/qtvAEMwj3cjeCOSoGiPAgsLpuwAwLcHknKyfGcJTJeXJkzCQgjo1sfvA==
X-Received: by 2002:a5d:658a:: with SMTP id q10mr7469073wru.220.1594934600634; 
 Thu, 16 Jul 2020 14:23:20 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:19 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 12/27] drm/amd/display: dce_dmcu: add DCE6 specific macros,
 functions
Date: Thu, 16 Jul 2020 23:22:36 +0200
Message-Id: <20200716212251.1539094-13-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
DCE6 has no SMU_INTERRUPT_CONTROL register, but it's used for DCN10 and later

[How]
Add DCE6 specific macros definitions for DMCU registers and masks
DCE6 DMCU macros will avoid buiding errors when using DCE6 headers
There is no other change needed in dce_dcmu

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
index 5e044c2d3d6d..93e7f34d4775 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h
@@ -46,6 +46,24 @@
 	SR(SMU_INTERRUPT_CONTROL), \
 	SR(DC_DMCU_SCRATCH)
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#define DMCU_DCE60_REG_LIST() \
+	SR(DMCU_CTRL), \
+	SR(DMCU_STATUS), \
+	SR(DMCU_RAM_ACCESS_CTRL), \
+	SR(DMCU_IRAM_WR_CTRL), \
+	SR(DMCU_IRAM_WR_DATA), \
+	SR(MASTER_COMM_DATA_REG1), \
+	SR(MASTER_COMM_DATA_REG2), \
+	SR(MASTER_COMM_DATA_REG3), \
+	SR(MASTER_COMM_CMD_REG), \
+	SR(MASTER_COMM_CNTL_REG), \
+	SR(DMCU_IRAM_RD_CTRL), \
+	SR(DMCU_IRAM_RD_DATA), \
+	SR(DMCU_INTERRUPT_TO_UC_EN_MASK), \
+	SR(DC_DMCU_SCRATCH)
+#endif
+
 #define DMCU_DCE80_REG_LIST() \
 	SR(DMCU_CTRL), \
 	SR(DMCU_STATUS), \
@@ -104,6 +122,25 @@
 			STATIC_SCREEN4_INT_TO_UC_EN, mask_sh), \
 	DMCU_SF(SMU_INTERRUPT_CONTROL, DC_SMU_INT_ENABLE, mask_sh)
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#define DMCU_MASK_SH_LIST_DCE60(mask_sh) \
+	DMCU_SF(DMCU_CTRL, \
+			DMCU_ENABLE, mask_sh), \
+	DMCU_SF(DMCU_STATUS, \
+			UC_IN_STOP_MODE, mask_sh), \
+	DMCU_SF(DMCU_STATUS, \
+			UC_IN_RESET, mask_sh), \
+	DMCU_SF(DMCU_RAM_ACCESS_CTRL, \
+			IRAM_HOST_ACCESS_EN, mask_sh), \
+	DMCU_SF(DMCU_RAM_ACCESS_CTRL, \
+			IRAM_WR_ADDR_AUTO_INC, mask_sh), \
+	DMCU_SF(DMCU_RAM_ACCESS_CTRL, \
+			IRAM_RD_ADDR_AUTO_INC, mask_sh), \
+	DMCU_SF(MASTER_COMM_CMD_REG, \
+			MASTER_COMM_CMD_REG_BYTE0, mask_sh), \
+	DMCU_SF(MASTER_COMM_CNTL_REG, MASTER_COMM_INTERRUPT, mask_sh)
+#endif
+
 #define DMCU_MASK_SH_LIST_DCE80(mask_sh) \
 	DMCU_SF(DMCU_CTRL, \
 			DMCU_ENABLE, mask_sh), \
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
