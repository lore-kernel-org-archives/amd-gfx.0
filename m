Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD11C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 08:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7199010E68E;
	Wed, 16 Feb 2022 08:09:08 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE83210E68A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 08:09:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTaN1PivCfwxDGCy7qn8RrlO0lnQPd9Ax1huNAIIP0S/FzchopksXw/KY3UrCLHgQvL9EmGLoObEcL/DqIqpTBlTctktE8uKsISaB7KyQU1wevWK0hhZDkzluHUrdV3oIbQgZVR239zjCpY/LVwyHDKu3UvdClYjp5Z+GzPfBKTx7wRPVkh3upY02jHGUBW8US6nOsnIqraG2a74h2pwblaRq7VWUzy/6dI7CyCw2SbDCht82HrrtIOjQZeHAeLIPOBOm551It1zttfkmRX8QzzamLiRw5XxEZWXtJBquzuz/d909ejj9Ke1eXXhutZlwmUJuATjWmtV6XAUy+1W3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5dXTTOIt3wkdXtVTkjaaq0yNSiZdL5ebYp0aoOSvoQ=;
 b=jK1nKVBEgBbZ6f8C844JaQyINc/Zi2AnfK63bi4aUUdeH6U1B9r2GJeIYbSnohplBkTBegbvq1xVc6y/GuMjkFdih5Hn6TiWPvZqNrZezedJJ3/wbQQvnNHFFCyahupwCi1BToSZfvosRtQdDqqqT1qBUubAyGuT523c6+YWNxkrp5GWy1Ej5T36Jz0qhS/syVr0s0DnH+ZVQ8EA8kikTaoykr3e2xOLg8d/TJuzgArO/Zw5/Xccv7B1kJgLyR1D8Fjh9SApDegV/aUNQuu9TEH1tfMdL6MsshHKqYEYtrixdBP+Ydgd9+tWCPWQlq/9tPFNjCTB1LvW+nWNkJ5sDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5dXTTOIt3wkdXtVTkjaaq0yNSiZdL5ebYp0aoOSvoQ=;
 b=q+74GhnAk4cHdAlHZg5jKlqRXFPHGt1lM/o93WDbKBjc5i94+TLmBf3jwwL1SSEkOvB2r8nyarN41lg4VGWoXMvKQEwcopqevWZ+gYQQc/YGQ6KY+8nGDSt+AiJYpugnE0V41WTvRW2Ty4VitQev7/8yO2JAhyt/Nm4+HxV4jhY=
Received: from MW4PR03CA0293.namprd03.prod.outlook.com (2603:10b6:303:b5::28)
 by BYAPR12MB3032.namprd12.prod.outlook.com (2603:10b6:a03:dd::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 08:09:02 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::d7) by MW4PR03CA0293.outlook.office365.com
 (2603:10b6:303:b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Wed, 16 Feb 2022 08:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 08:09:01 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 02:08:58 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/7] drm/amdgpu: Modify .ras_late_init function pointer
 parameter
Date: Wed, 16 Feb 2022 16:07:58 +0800
Message-ID: <20220216080804.3560484-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c30ea28f-bb82-41ab-f723-08d9f12397a3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3032:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB303263D6E165A28C47E27201FC359@BYAPR12MB3032.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:139;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCDZuzbsGRRuQMJ/GQtdsuniZ1vlGN/dcOmEhJrmjUD285+mXch813MLoWVlX/nzOVygYRjJQVDZvVWyZsUaWlYkrcytCkiGNWLQ5Bs9gCSU0aH5BRszZW3e56jrjZ8GL3rPvNEUGvBa0Dkb4iq2A4Iho9HgXstBF6YjTnKRoJW3mp/BSbJtgomtkj99ljs6Z5BwwIrPM+/2aqVOs/P98anA4VYHfdUTqYR0Yiv9+NeJo8WrW3lWmW2ejA19t0dkrKPhJigdNfdoGZYUc7eD3CLiykoKOSopc3FN2lypM80SpJBp79lYGcnOYN3nQZuSXRjN4YDfTHANHrFUK+CHLTqDBkv/FebVZ/4c9Gj7xfGUAhpve8zaC51xs5iFOfbbvvkH+UR+EeHLZwjsX+9P33cPVNjoN+2a8mZTZRm/MSjKO6z+yI064VJXTnLQ1l1FdxlxocK3OJAnvLxELpxz574b7T1sDIEWdegG3ayKmc/URy/6fl29gBt04yQeATApBkxrxlwjN1qXTatAoM21uPqS13Pl5LrkqF4UH2fDRkGbAN1yfSvGwuYddH9nCb0IJAo+dluZWxYSxTwCQ3C8b87BSCbXFBIRdjI+nL49YYa4e5jJX1RVBS+3B/2yBS+hsFScGeob6OUumkFAi31w8prOhWxe7IwsFcYOvVJ2brvkUebPkG1bW521DFthFa2afTRYvXNitVGAegIkMTLpXpYw5ON8nKd9hB4LP/TfxjYS/vPk+6RgS6wIWn3u8QTF4h4m9JoV+nS5X0wkdYWcyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(36860700001)(6916009)(54906003)(7696005)(82310400004)(508600001)(83380400001)(47076005)(16526019)(426003)(1076003)(2616005)(26005)(186003)(336012)(5660300002)(30864003)(8936002)(86362001)(70586007)(36756003)(4326008)(2906002)(356005)(81166007)(70206006)(40460700003)(8676002)(43062005)(142923001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 08:09:01.8172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c30ea28f-bb82-41ab-f723-08d9f12397a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3032
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modify .ras_late_init function pointer parameter so that
it can remove redundant intermediate calls in some ras blocks.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c     | 6 +++---
 15 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index fe392108b5c2..b7470ed7bc25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -622,7 +622,7 @@ int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value)
 	return r;
 }
 
-int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
 	r = amdgpu_ras_block_late_init(adev, adev->gfx.ras_if);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f99eac544f6d..ccca0a85b982 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -386,7 +386,7 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 				    int pipe, int queue);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
-int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, void *ras_info);
+int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_gfx_ras_fini(struct amdgpu_device *adev);
 int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index 21a5f884dd2a..70a096160998 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -24,7 +24,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
-int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	return amdgpu_ras_block_late_init(adev, adev->hdp.ras_if);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 4af2c2a322e7..aabd59aa5213 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -43,6 +43,6 @@ struct amdgpu_hdp {
 	struct amdgpu_hdp_ras	*ras;
 };
 
-int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, void *ras_info);
+int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_hdp_ras_fini(struct amdgpu_device *adev);
 #endif /* __AMDGPU_HDP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
index 2bdb4d8b7955..ede98db8c126 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -24,7 +24,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
-int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	return amdgpu_ras_block_late_init(adev, adev->mmhub.ras_if);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 7deda9a3b81e..75815106f2d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -47,7 +47,7 @@ struct amdgpu_mmhub {
 	struct amdgpu_mmhub_ras  *ras;
 };
 
-int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev, void *ras_info);
+int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev);
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index 89e61fdd3580..92fd4ffa7779 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -22,7 +22,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
-int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
 	r = amdgpu_ras_block_late_init(adev, adev->nbio.ras_if);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 4afb76d3cd97..f9546c7341b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -104,6 +104,6 @@ struct amdgpu_nbio {
 	struct amdgpu_nbio_ras  *ras;
 };
 
-int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, void *ras_info);
+int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_nbio_ras_fini(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 5de567c6a8f7..837d1b79a9cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -490,7 +490,7 @@ struct amdgpu_ras_block_object {
 
 	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
 				enum amdgpu_ras_block block, uint32_t sub_block_index);
-	int (*ras_late_init)(struct amdgpu_device *adev, void *ras_info);
+	int (*ras_late_init)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 	void (*ras_fini)(struct amdgpu_device *adev);
 	ras_ih_cb ras_cb;
 	const struct amdgpu_ras_block_hw_ops *hw_ops;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 242a7b4dcad9..594454dba4c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -87,7 +87,7 @@ uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
 }
 
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
-			      void *ras_ih_info)
+			      struct ras_common_if *ras_block)
 {
 	int r, i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index eaee12ab6518..8b226ffee32c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -117,7 +117,7 @@ amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring);
 int amdgpu_sdma_get_index_from_ring(struct amdgpu_ring *ring, uint32_t *index);
 uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring, unsigned vmid);
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
-			      void *ras_ih_info);
+			      struct ras_common_if *ras_block);
 void amdgpu_sdma_ras_fini(struct amdgpu_device *adev);
 int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 9f1406e1a48a..7abf9299e0d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -136,7 +136,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 	return amdgpu_umc_do_page_retirement(adev, ras_error_status, entry, true);
 }
 
-int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index ec15b3640399..e4b3678a6685 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -72,7 +72,7 @@ struct amdgpu_umc {
 	struct amdgpu_umc_ras *ras;
 };
 
-int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, void *ras_info);
+int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_umc_ras_fini(struct amdgpu_device *adev);
 int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 		void *ras_error_status,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index a785b1e088cd..91f788f6f6b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -732,7 +732,7 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 	return psp_xgmi_terminate(&adev->psp);
 }
 
-static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (!adev->gmc.xgmi.supported ||
 	    adev->gmc.xgmi.num_physical_nodes == 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index c442b34b9472..72ce19acb8bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -37,7 +37,7 @@ static void mca_v3_0_mp0_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static int mca_v3_0_mp0_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+static int mca_v3_0_mp0_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	return amdgpu_mca_ras_late_init(adev, &adev->mca.mp0);
 }
@@ -89,7 +89,7 @@ static void mca_v3_0_mp1_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static int mca_v3_0_mp1_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+static int mca_v3_0_mp1_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	return amdgpu_mca_ras_late_init(adev, &adev->mca.mp1);
 }
@@ -127,7 +127,7 @@ static void mca_v3_0_mpio_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static int mca_v3_0_mpio_ras_late_init(struct amdgpu_device *adev, void *ras_info)
+static int mca_v3_0_mpio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	return amdgpu_mca_ras_late_init(adev, &adev->mca.mpio);
 }
-- 
2.25.1

