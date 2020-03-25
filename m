Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A8CC43331
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 14:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651B02070A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 14:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cPWpok6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651B02070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF416E86E;
	Wed, 25 Mar 2020 14:30:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44BD26E86D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 14:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNwOuLpq/79mTC9DuLmpb1Hu6ltOOKx1xjI2ZoVKN/wDrCTD3B6ZJPqktedtdTQSAgo1aMhR3LvLc011Gapyc5kOeP+mXgicskP3j8UE+jwbuMT72LHnj35rayiHz/TPhyGARXtNodE/v+3K+GYH+MEkBllDsNeiDHzBvdR1RKqCrWivti/pJlw/rqzpVlsvPtJGZkXzCjSsynEBavYrZUSeW5yAP0St7gOmrGVnlxI5uzB+5Ch1EngAsNeRgXnf6rfqSC3ffM4lD7hbKLx55NQ+3Xdz/mrEY6c8XGiw5k4IArmc5WqnkDeZuRgAdqlXEGjFckSy2jE5/meOc12f5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjlwyejwiQ8aHaj/sA24iBcrnBHTrakM+9R8RsEWMv8=;
 b=Tr2iBB0l11Y8K9/7+t3xAoe6lJZ9krnLrey6Q5HGIqcsX890hQAMLmgdyQq5KEpSukwZDAvDSHXiW7QWT87SnquFdNaBK3TXFy8UJXEhjBGqaK/UrHpheo0e5zp/4X9KAXYXv+Jb8Ar9Qbf1LtCJpDIawUDFr9p7stqvn7dvtQc6B+LKoP5wV7MlXa9CxlCUt14ruZiw0b22GWsjN3o1Rw2BgeqM0NMSb4Owx9vmpkur8XCxHXzfaIHgUwk2yFQwUcm8Q6/k6BTs/cbn0DgrPBawflBIbwOF9MMuVtqHar3LTzdBMlx2+/YmK4HHcsgiPOX4YXoqMrLo4c+kh+Cdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjlwyejwiQ8aHaj/sA24iBcrnBHTrakM+9R8RsEWMv8=;
 b=cPWpok6A1x1U0eP5SEWPRRpnYJ5XZmVUFWtxWQHqsc7RX4pi9mZO4DUKJ1sXkJAG4gp1cvIQ5Y7MJyDlcaGvLBoUMe33s+0GfEJ+uvIOlyZo10j4cOCXb9gUV3WHLFaiB+a3xdL1xe+UzT+tw1jKLk92Ai13fhGlSP1R6CzMx+0=
Received: from BN6PR16CA0028.namprd16.prod.outlook.com (2603:10b6:405:14::14)
 by MWHPR12MB1662.namprd12.prod.outlook.com (2603:10b6:301:11::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 14:29:53 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::ca) by BN6PR16CA0028.outlook.office365.com
 (2603:10b6:405:14::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Wed, 25 Mar 2020 14:29:53 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 14:29:52 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 25 Mar
 2020 09:29:51 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 25 Mar 2020 09:29:50 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: Add AQUIRE_MEM PACKET3 fields defintion
Date: Wed, 25 Mar 2020 10:29:38 -0400
Message-ID: <1585146580-27143-3-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585146580-27143-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1585146580-27143-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(428003)(46966005)(70586007)(70206006)(6916009)(86362001)(2616005)(81156014)(8676002)(81166006)(54906003)(2906002)(356004)(5660300002)(44832011)(6666004)(26005)(8936002)(478600001)(186003)(316002)(336012)(82740400003)(36756003)(47076004)(7696005)(4326008)(426003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1662; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 979666b3-5e50-4135-5f74-08d7d0c8fb7f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1662:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1662967E8BC1C1F97C60CC59EACE0@MWHPR12MB1662.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:316;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: taooVsNqucHT1adkkSWT6wnyOEkQ3jpJvQQihesnvPolagWPljEj9jTS1wqtuKjtz4pUkAOSzvBJuSYpB/CCEzV3/GMGIg10q9fUc2NPhrurepDc4oUbroGYXqpb/VOu0ydBMDTf1bCb98387f1B4cMzuzitmDU8gT9vQB1C2JSTYCFyOlrWwv6OF72Mng1nWQEokC5EGlj9ax0fCR/M19IO7Mpiybe4KxgqN+Do9w7gBVVmRaRaC0pCFcqpYqSP7bbw/RHis96pFRAOYAQt6sT8O6f3ZI8DrMgxbQI61h2WxjomA/6TPInF4nMgILBoPKX9SLQ6XIlQgqjiFDmysN9xSW9SOeOv0dQpc4A+5kHL4XV8Gw1lfD0pUe7b8NIOcLM43ISl8bbkerLe1cRmRKU4JiYh8doTcm+hxFlUEqMWfbwvz+K8T7CGHiKy0ErOwtVNgHsjyaBHbr+EZguO3GEe8xBSUUHkDMR5glrczei9R7ko478kYLB0OPjMZlXZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 14:29:52.7230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 979666b3-5e50-4135-5f74-08d7d0c8fb7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1662
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
Cc: Ken.Qiao@amd.com, Marek.Olsak@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add this for gfx10 and gfx9.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nvd.h    | 48 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15d.h | 25 ++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
index f3d8771..7785ea5 100644
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
+#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GLI_INV(x) ((x) << 0)
+		/*
+		 * 0:NOP
+		 * 1:ALL
+		 * 2:RANGE
+		 * 3:FIRST_LAST
+		 */
+#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GL1_RANGE(x) ((x) << 2)
+		/*
+		 * 0:ALL
+		 * 1:reserved
+		 * 2:RANGE
+		 * 3:FIRST_LAST
+		 */
+#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_WB(x) ((x) << 4)
+#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_INV(x) ((x) << 5)
+#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_WB(x) ((x) << 6)
+#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_INV(x) ((x) << 7)
+#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GLV_INV(x) ((x) << 8)
+#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GL1_INV(x) ((x) << 9)
+#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_US(x) ((x) << 10)
+#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_RANGE(x) ((x) << 11)
+		/*
+		 * 0:ALL
+		 * 1:VOL
+		 * 2:RANGE
+		 * 3:FIRST_LAST
+		 */
+#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_DISCARD(x)  ((x) << 13)
+#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_INV(x) ((x) << 14)
+#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_WB(x) ((x) << 15)
+#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_SEQ(x) ((x) << 16)
+		/*
+		 * 0: PARALLEL
+		 * 1: FORWARD
+		 * 2: REVERSE
+		 */
+#              define PACKET3_ACQUIRE_MEM_GCR_RANGE_IS_PA  (1 << 18)
 #define	PACKET3_REWIND					0x59
 #define	PACKET3_INTERRUPT				0x5A
 #define	PACKET3_GEN_PDEPTE				0x5B
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
index 295d68c..8983871 100644
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
+#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_NC_ACTION_ENA(x) ((x) << 3)
+#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_WC_ACTION_ENA(x) ((x) << 4)
+#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_INV_METADATA_ACTION_ENA(x) ((x) << 5)
+#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TCL1_VOL_ACTION_ENA(x) ((x) << 15)
+#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_WB_ACTION_ENA(x) ((x) << 18)
+#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TCL1_ACTION_ENA(x) ((x) << 22)
+#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_ACTION_ENA(x) ((x) << 23)
+#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_CB_ACTION_ENA(x) ((x) << 25)
+#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_DB_ACTION_ENA(x) ((x) << 26)
+#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_ACTION_ENA(x) ((x) << 27)
+#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_VOL_ACTION_ENA(x) ((x) << 28)
+#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_ICACHE_ACTION_ENA(x) ((x) << 29)
+#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_WB_ACTION_ENA(x) ((x) << 30)
 #define	PACKET3_REWIND					0x59
 #define	PACKET3_LOAD_UCONFIG_REG			0x5E
 #define	PACKET3_LOAD_SH_REG				0x5F
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
