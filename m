Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED486C2D0E5
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD94206E6
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wdho+jOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD94206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77BEF6E922;
	Thu, 26 Mar 2020 20:03:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44FC6E922
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 20:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4ySphkUt2GIRk6sgADW6TG1n1B2a2TkxvcxIwORV7qCYJsbY91uX4xCo7yLWnJMczYy+cQemXVcpglm7DJgM8AXlQNt+M3rQMOPhYVE2UxBSoco99VQTk+3TmFVHcLfwcqb2shiHZgVxDarSQ4JBhExJJQI9KL6KRVFp59EwDxr5MdG5i1eMKcifIfdjNjFD2sRSJ128kIk/kcHSsC+NctEOtms2bXzQhuyIV3uFFO7PxOTYbsXJTtKApOhZFQGpEdNx8Kcgb3JPNOBYsV76aLY0DAsp2+vxdtVDq7kaeE/9SqswotErafG7yeP4ZaAc09HNei1VXSUd3PUgjcFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wz/VTC3BkeJJ9vxRdU9CZGSGWEGW8BWOLuEg3htzVS8=;
 b=lg/m5QVS3J5iwmGfWTC5WxRpACwSc0IFgftUyv0d/VGMzbaaOxy6FMvtjagOsecjI1JmFaCOC5725+pSJKKHXi+6oaGean5lUh1Ad2K0cKqPh0Ul258awaepkFrnAxfCegmgBv/oL4o/YjQIsMT1hVnnj//B7Fy/2x+NU56MSdXOO6SKlzgYWsaLaOdj9ZUKu9Pp9L5T62aAUM3NQBI+FpoBjxGDYyE2W1iZ/34hI6glRaHaoqHUs5T9dPpQ8e7abQbTMyYSXbqwPCEIQnVWqo7gKqxR4zVoquI0URw2v3K8cFvwFTUb5Jx34+mKh34tFc93rRwYAxZdcPVyv8RR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wz/VTC3BkeJJ9vxRdU9CZGSGWEGW8BWOLuEg3htzVS8=;
 b=wdho+jOwOCQDFOFx2JL+VlHeoBntOVnY/Kw45SmTKBRoD1to5TLR3GRh8Eucxzu5a6u+sEK5WeLCd4SAqu3Vvlpw0L9j6QeZ4LQLb0cdVdvzJ2DZmQKvHrNpqwIaKeOUHvXxffXG6T/kDGhEnmH4jrZjfakZjFICQhEJ8MfICLg=
Received: from MWHPR15CA0040.namprd15.prod.outlook.com (2603:10b6:300:ad::26)
 by MWHPR1201MB0109.namprd12.prod.outlook.com (2603:10b6:301:52::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 26 Mar
 2020 20:03:04 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::b0) by MWHPR15CA0040.outlook.office365.com
 (2603:10b6:300:ad::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend
 Transport; Thu, 26 Mar 2020 20:03:04 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2856.19 via Frontend Transport; Thu, 26 Mar 2020 20:03:04 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 26 Mar
 2020 15:03:01 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 15:03:00 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/4] drm/amdgpu: Add AQUIRE_MEM PACKET3 fields defintion
Date: Thu, 26 Mar 2020 16:02:46 -0400
Message-ID: <1585252968-1218-3-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585252968-1218-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1585252968-1218-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(428003)(46966005)(70206006)(26005)(86362001)(70586007)(6666004)(186003)(356004)(478600001)(81166006)(81156014)(8676002)(8936002)(54906003)(6916009)(316002)(7696005)(4326008)(336012)(2906002)(47076004)(82740400003)(426003)(2616005)(5660300002)(36756003)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB0109; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55fc50fd-da53-48a4-753e-08d7d1c0b1da
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0109:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0109F1D9F01AABDD02A06615EACF0@MWHPR1201MB0109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:316;
X-Forefront-PRVS: 0354B4BED2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5lkc+8iqV4JHO/R00YH5vfkvXSL22qZx0vl0yi9ItyHgjWlRFpszvPKUD+UcNzr+KqAhBtRAiW8yBZoWKva6wVk8nD1IP9KyU6uKRdKnhv2bnA/y71iXLMleq7+NP6kLX9G18RZewq7sUyrMoeRb4IMEMRPv58rs6KqVw9xNuZzn2jVO/cDxj18ZJmShDWGo34lwKolDBoHjGHjdJJ//yuVWX2N/Q4/GLQvZAbtnBTbVCorkrOn/GY1LlEGnFl/CArkVmhTca1W63PGwWvx22IYEZSdN2jjkFjqBgaHZYXuyhe+ZBurbJzDQ/orLgW5ZyOmNHf2IHVRR64iEbPI6oJHMuy/wRTZs7O8Kvfrayoyd+OTSFY4AjCN68WiLE8KJZmuYGIWC5iLcV7CaSlbW4b+aYJt7yi8Qb5hZlLW2Q+jzgyHcpRku2kCSFhwETjZwoPCMXZBZNjWXYRzPyDjfm69Ea7lmLGWqgGzc8IIRsgNbPLDAwJ4xNirydsUC7GC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 20:03:04.2285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fc50fd-da53-48a4-753e-08d7d1c0b1da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0109
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 ckoenig.leichtzumerken@gmail.com, Marek.Olsak@amd.com, Ken.Qiao@amd.com,
 luben.tuikov@amd.com, alexdeucher@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add this for gfx10 and gfx9.

v2: Fix identation

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nvd.h    | 48 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15d.h | 25 ++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
index f3d8771..fd6b582 100644
--- a/drivers/gpu/drm/amd/amdgpu/nvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
@@ -256,6 +256,54 @@
 #define	PACKET3_BLK_CNTX_UPDATE				0x53
 #define	PACKET3_INCR_UPDT_STATE				0x55
 #define	PACKET3_ACQUIRE_MEM				0x58
+/* 1.  HEADER
+ * 2.  COHER_CNTL [30:0]
+ * 2.1 ENGINE_SEL [31:31]
+ * 2.  COHER_SIZE [31:0]
+ * 3.  COHER_SIZE_HI [7:0]
+ * 4.  COHER_BASE_LO [31:0]
+ * 5.  COHER_BASE_HI [23:0]
+ * 7.  POLL_INTERVAL [15:0]
+ * 8.  GCR_CNTL [18:0]
+ */
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLI_INV(x) ((x) << 0)
+		/*
+		 * 0:NOP
+		 * 1:ALL
+		 * 2:RANGE
+		 * 3:FIRST_LAST
+		 */
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL1_RANGE(x) ((x) << 2)
+		/*
+		 * 0:ALL
+		 * 1:reserved
+		 * 2:RANGE
+		 * 3:FIRST_LAST
+		 */
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_WB(x) ((x) << 4)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_INV(x) ((x) << 5)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_WB(x) ((x) << 6)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_INV(x) ((x) << 7)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLV_INV(x) ((x) << 8)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL1_INV(x) ((x) << 9)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_US(x) ((x) << 10)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_RANGE(x) ((x) << 11)
+		/*
+		 * 0:ALL
+		 * 1:VOL
+		 * 2:RANGE
+		 * 3:FIRST_LAST
+		 */
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_DISCARD(x)  ((x) << 13)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_INV(x) ((x) << 14)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_WB(x) ((x) << 15)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_SEQ(x) ((x) << 16)
+		/*
+		 * 0: PARALLEL
+		 * 1: FORWARD
+		 * 2: REVERSE
+		 */
+#define 	PACKET3_ACQUIRE_MEM_GCR_RANGE_IS_PA  (1 << 18)
 #define	PACKET3_REWIND					0x59
 #define	PACKET3_INTERRUPT				0x5A
 #define	PACKET3_GEN_PDEPTE				0x5B
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
index 295d68c..799925d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
@@ -253,7 +253,30 @@
 #              define PACKET3_DMA_DATA_CMD_SAIC    (1 << 28)
 #              define PACKET3_DMA_DATA_CMD_DAIC    (1 << 29)
 #              define PACKET3_DMA_DATA_CMD_RAW_WAIT  (1 << 30)
-#define	PACKET3_AQUIRE_MEM				0x58
+#define	PACKET3_ACQUIRE_MEM				0x58
+/* 1.  HEADER
+ * 2.  COHER_CNTL [30:0]
+ * 2.1 ENGINE_SEL [31:31]
+ * 3.  COHER_SIZE [31:0]
+ * 4.  COHER_SIZE_HI [7:0]
+ * 5.  COHER_BASE_LO [31:0]
+ * 6.  COHER_BASE_HI [23:0]
+ * 7.  POLL_INTERVAL [15:0]
+ */
+/* COHER_CNTL fields for CP_COHER_CNTL */
+#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_NC_ACTION_ENA(x) ((x) << 3)
+#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_WC_ACTION_ENA(x) ((x) << 4)
+#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_INV_METADATA_ACTION_ENA(x) ((x) << 5)
+#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TCL1_VOL_ACTION_ENA(x) ((x) << 15)
+#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_WB_ACTION_ENA(x) ((x) << 18)
+#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TCL1_ACTION_ENA(x) ((x) << 22)
+#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_ACTION_ENA(x) ((x) << 23)
+#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_CB_ACTION_ENA(x) ((x) << 25)
+#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_DB_ACTION_ENA(x) ((x) << 26)
+#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_ACTION_ENA(x) ((x) << 27)
+#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_VOL_ACTION_ENA(x) ((x) << 28)
+#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_ICACHE_ACTION_ENA(x) ((x) << 29)
+#define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_WB_ACTION_ENA(x) ((x) << 30)
 #define	PACKET3_REWIND					0x59
 #define	PACKET3_LOAD_UCONFIG_REG			0x5E
 #define	PACKET3_LOAD_SH_REG				0x5F
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
