Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265A2C4345B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FAA223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRpyvNnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FAA223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 932A06E849;
	Tue, 14 Jul 2020 18:24:47 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A546E849
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:46 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id b25so13615539qto.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2yF5cqyJl+3h937i34EYxLObgylIQNKk9AnFXX/kuyE=;
 b=TRpyvNnksITxJkfr1TD2tPvaxM4rrDFWiiYfnzUdJaFbfeefNFQpCmBKNrf69NuaQb
 dwAQRyHnuczlh959TC/rn0SjGaK064qHOWjYufKIsGNxjl4CYDFDDav78R1y6QOEucts
 aegDtusrpoixIjIB1olDcuYFojzqb1YWZJXu/a0dG3DZ8NlYSzsFESlDVP5Jh8A61YpI
 wGrzNoEd51xRZpn1HKeBMj/vIW6cvbnm5nC9um5/Mf8fItLAFevMnQ1/slcc9sZpG/Pk
 h/jcOJddNdc0V7JAWoggzAeutNBt+PKvClemtUkGJZqxKyRchoPqZ9S2okAHLfw8L6p/
 Xm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2yF5cqyJl+3h937i34EYxLObgylIQNKk9AnFXX/kuyE=;
 b=bX5MonR20mg1Idw03J7fNV2D76srkeunCoZ+0p6njq1WvlK4JpPmXVdg51IOo5wZlC
 h7nzjvFx1lUR+I5EVtU/OCcip6p+IEESO0yWWdk22YnO8P1QBVbB0fWNyzB6ot1sO8Ha
 OtOhow7L4FemzJ3SRWZA7AN4ALyS+w3Y6vpmvHYt4pHCF0f1Ta0yLwf5M1sbUnlsFRYY
 yqIiP99Zo6YGRtCDHKyOfWfwymtYGJZbdTSjlnXP5BHj0uJiM9bmZK4Qk4ASIwpRThvZ
 UtlTM/olOX7YKBUTEC+5JkthseHMiS/ohqHljL3B4UQ+2NdJcr4VqGmYDAhBc7vJ943d
 UHEQ==
X-Gm-Message-State: AOAM530hGXwq4sY4sl8DEBBmp5iRtaZ2GqFB8EmFMMfNd/fiQpEw+87V
 /RVj9WN8umGWaLD2pTAHFqdZr8nR
X-Google-Smtp-Source: ABdhPJxxdtDMzawTyQjXnVouBxrzMvJ8Yl7zZTLGB2++3XCq/7gOUfl6yvp7fueA02vCO59LBcJIPA==
X-Received: by 2002:aed:222e:: with SMTP id n43mr6214460qtc.123.1594751085968; 
 Tue, 14 Jul 2020 11:24:45 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:45 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/42] drm/amdgpu/gfx10: add gc golden setting for
 navy_flounder
Date: Tue, 14 Jul 2020 14:23:39 -0400
Message-Id: <20200714182353.2164930-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

Add gc golden setting for navy_flounder

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2957bf780d79..ad9b5969c3b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3121,6 +3121,48 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_sienna_cichlid[] =
 	/* Pending on emulation bring up */
 };
 
+static const struct soc15_reg_golden golden_settings_gc_10_3_2[] =
+{
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_PS_CLK_CTRL, 0xff7f0fff, 0x78000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL, 0xff7f0fff, 0x30000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA1_CLK_CTRL, 0xff7f0fff, 0x7e000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000200),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL, 0x7fff0f1f, 0x00b80000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGE_PC_CNTL, 0x003fffff, 0x00280400),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CM_CTRL1, 0xff8fff0f, 0x580f1008),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL3, 0xf7ffffff, 0x00f80988),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_CL_ENHANCE, 0xf17fffff, 0x01200007),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xffffffff, 0x00000800),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0xffffffbf, 0x00000820),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL_1, 0xffffffff, 0x00070104),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_START_PHASE, 0x000000ff, 0x00000004),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_CONFIG, 0xe07df47f, 0x00180070),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER0_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER1_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER10_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER11_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER12_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER13_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER14_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER15_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER2_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER3_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER4_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER5_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER6_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER7_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xffffffff, 0x010b0000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a00000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmVGT_GS_MAX_WAVE_ID, 0x00000fff, 0x000003ff)
+};
+
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
 	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
@@ -3309,6 +3351,12 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_gc_10_3_sienna_cichlid,
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_3_sienna_cichlid));
 		break;
+	case CHIP_NAVY_FLOUNDER:
+		soc15_program_register_sequence(adev,
+						golden_settings_gc_10_3_2,
+						(const u32)ARRAY_SIZE(golden_settings_gc_10_3_2));
+		break;
+
 	default:
 		break;
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
