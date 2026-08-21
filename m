Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660EBC5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 081B710F494;
	Fri, 21 Aug 2026 19:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n6jPLCXw";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC19C10F494
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwE9xRNEtKAZ4O+3sWf69Nu4uiPQfCAlfOohI4FZiV8m1Kptf8CleERRrdJVH5GTutOIG3GMKTnWN0QqvGCsM96A+qtdXCl3M9zFDDZPYVaH94wPQ4tXyTvc245UNDqXd3zR28DXHDKnHmWjDHoQml/2p9ft1eM3o7HLnUSoZEyquXwFTGwAj+WlwDwORsnPlMMbmRknRiFkA/qMYAwKQwtPaH7s326odEduN4HcpDsNFhqd3YTC2jyzFA4bbGGgQ/0tzioG4L80OJmo6Q4AOstgPEk1SQOWTkSGZB+IRlbBuVwPYmFnEh4XK+p/u+V8ProwLcgXc11bGrIlF1E1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9sCHTcUDf6I1tO04koPk4QoXQTkPMUMvqK98uDr2Wc=;
 b=kU998Kzamj54rlZbNysEEBE4iysZ76ZWBpdMzX/6DekkiBDlVeQAlTCu6kgclLFMNTfhogigWjrfHOHIWHwu++wG4uhYrssWkWcFwOM7VLufbASGounI+sHBye1tV3gh6vFoV2MhQygC8Fs5LTxKIesXlXWP3WTGl2kzpU5Hkh/VYdmUo4MDD9iNbWdcsWnfYl6LfhAKJCyYR5wYjYZPu2vrK3dWm1J4zzIc57/AbG5F25+K7UkjjJDFY7x4JcKahZhbBX4huFI4EV7uCkQAPvsPMfa7lgEzQDp87RbyYm2x+LgU2TUX28VDXPCqbi/ih1fcDRSsQrd/cW/LBdxQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9sCHTcUDf6I1tO04koPk4QoXQTkPMUMvqK98uDr2Wc=;
 b=n6jPLCXwPapboL4l801H6+xphmLoWrY8CnJUkhacA12PkEd13M9Lt3AQ1ktbze2aWN8b8VBSOEMWboZ7wRMLJlhjLFoaNoauYaQLDW5ZFm+nEXJMIvtueyS2LBO/vxZ83GxspLnDWaYsI315n3mYRYHrvnCVPgCwQQtpHuMcAoo=
Received: from CH2PR12CA0024.namprd12.prod.outlook.com (2603:10b6:610:57::34)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.11; Fri, 21 Aug 2026 19:36:05 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::56) by CH2PR12CA0024.outlook.office365.com
 (2603:10b6:610:57::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 81/95] drm/amdgpu: Add handlers for ualink notifications
Date: Fri, 21 Aug 2026 15:34:44 -0400
Message-ID: <20260821193458.808626-82-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4dd2c5-6f49-48fb-33b0-08deffbb70c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|22082099003|18002099003|3023799007|56012099006|10067099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: u1E6wVCK3hQgsZn28riDAsnQEltOhI4iyyOXNd5iPIPYImJ80poyJv9BqnBaP0C4mCSdnQukRsFftxys37oxcByLo4LCZBK2UK67/+F0miH4DtbK7dIqQ6/f6ffR20M5jsGgJTmCZnfPgF74uVaZntucpJOxtHl0h3Mtdeq7gjfPKB1FYM3HQk/gvgdgGkAN/5uQwqjwTSJllLrQcNrp3+m9YygxZjGZ3ZUdXjfYjQohnKFK3F2EZ327U7lyjCa/kPrx5gZTc2mRAU48iwaF2embM7FADW5Dr9g2jv41HJeVY4ajFFGY95pMHy2Z0ItPh++o0XWl6/iBb9hgAL4C61KUDv1UnvqlU5y4qjxcyBnfEwbFXpY102ZsbZKvLosTBOrXaFpGwjBdP/JE8OVOrwYmNDAT57jXmkL+YpzFt8UHQRvD1544lZoxspzf4GA5fTaK3S6PJ6Odn4aWZLGeBq3zjF2WW7oIYeuWbHBP8hpwtB+oJg8H8WJHCTc/NG+IixtFqjLISTXHpvec8yseIEOBjFUj5dhHZEvFnEUGVFLGJNsAaniZyyiSM25lg+7O5bRQAQuIu2BFS3oploB/PjJUuTiqywOSnAMF0gqpD9RJPBjqb5rTZl93IGvz2gVK4oha3VH1lwmaKAUe/tfzfRsfYNr/uNwlALZArUJfgAyd1Ii4HE9NQI4dWVjA6jNvUwx/dOz55W3PE7fnGU4ucA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: djnaNnEQcfa03sPUVNvKaH50R8CKNLMxGbicps72q3RySQyFRZarzUMp1yCfgrcaL6sMzkHt+G42hXSXd8LsSdgvpw3yjA4V0RSZ2JCz28TzK1Vot70S7qHWlLjpvSf9anUIpOvgbZMnmoSQRa3MQ1iXBP+FnxA82qWI9Ab9VSld3USLpuvrfPV1QHrdbMtquVfBc9gsAmZcg/6EpvZIJwBYjuVU0gyXyCEfw/wrAQlAGoxu6v1Gj8M7+t6uNBe/FAhrvUIsif6H945rSjrXufxub2vfPaTymnlqddYfmv6StwXp9F3lg1BUxLGjRF2g0HaTnNAQu811JzWzWe2Ip/tNAGdaRwh1nH5B657wPwVyrdKesM63MmNx/n+JcZDAn+wcGOKlooolqFo9MaKyBrqL9EsygfEAQnGoPFmp2BLa1M/iX14DvrKMTZclfo2a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:04.9061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4dd2c5-6f49-48fb-33b0-08deffbb70c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add handlers for ualink notifications from ASP. Pause/Resume
notifications are not handled currently.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 64 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  3 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h    | 34 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c   | 48 +++++++++++++++-
 4 files changed, 143 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 4c923f907f275..8b3aff3dc31f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -204,6 +204,70 @@ static int amdgpu_ualink_query_info(struct amdgpu_device *adev)
 	return 0;
 }
 
+int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev)
+{
+	int r;
+	u32 status = 0;
+
+	/* TBD: Stop ASP interrupts if driver faced an issue */
+	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE) {
+		dev_dbg(adev->dev,
+			"UALink not initialized, skipping config update\n");
+		status = !!(adev->ualink.mgr_state == AMDGPU_UALINK_INIT_ERROR);
+		goto out;
+	}
+
+	/*TBD: find the right value of status to be sent to ASP*/
+	r = amdgpu_ualink_query_info(adev);
+	if (r) {
+		dev_info(adev->dev, "UALink config update failed %d\n", r);
+		status = 1;
+	}
+
+out:
+	return psp_ual_send_completion(&adev->psp, adev->ualink.psp_if_ver,
+				       PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID,
+				       status);
+}
+
+int amdgpu_ualink_pause_handler(struct amdgpu_device *adev)
+{
+	u32 status = 0;
+
+	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE) {
+		dev_dbg(adev->dev,
+			"UALink not initialized, skipping pause update\n");
+		status = !!(adev->ualink.mgr_state == AMDGPU_UALINK_INIT_ERROR);
+		goto out;
+	}
+
+	dev_dbg(adev->dev, "UALink pause command is not handled\n");
+
+out:
+	return psp_ual_send_completion(&adev->psp, adev->ualink.psp_if_ver,
+				       PSP_GFX_INT_CTXT_UAL_CMD_PAUSE_ID,
+				       status);
+}
+
+int amdgpu_ualink_resume_handler(struct amdgpu_device *adev)
+{
+	u32 status = 0;
+
+	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE) {
+		dev_dbg(adev->dev,
+			"UALink not initialized, skipping pause update\n");
+		status = !!(adev->ualink.mgr_state == AMDGPU_UALINK_INIT_ERROR);
+		goto out;
+	}
+
+	dev_dbg(adev->dev, "UALink resume command is not handled\n");
+
+out:
+	return psp_ual_send_completion(&adev->psp, adev->ualink.psp_if_ver,
+				       PSP_GFX_INT_CTXT_UAL_CMD_RESUME_ID,
+				       status);
+}
+
 int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 18096bdf1272a..d7bde8ab77d77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -387,6 +387,9 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
 
 int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
 
+int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev);
+int amdgpu_ualink_pause_handler(struct amdgpu_device *adev);
+int amdgpu_ualink_resume_handler(struct amdgpu_device *adev);
 
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 77be21c3eada3..0803cfc445dc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -400,11 +400,35 @@ struct psp_gfx_cmd_req_perf_hw {
 #define PSP_GFX_UAL_MAX_STATIONS_V1     64       /* max UALink stations */
 #define PSP_GFX_UAL_MAX_ACC_BIT_MASK    32       /* max accelerator bit mask 32*32 */
 
-enum psp_gfx_ual_npa_address_mode
-{
-    PSP_GFX_UAL_NPA_ADDRESS_MODE_SOURCE_ALIASING = 0,
-    PSP_GFX_UAL_NPA_ADDRESS_MODE_SOURCE_IDENTIFICATION = 1,
-    PSP_GFX_UAL_NPA_ADDRESS_MODE_MAX
+/* Interrupt category identifiers (upper byte) - ASP interrupts to Driver */
+
+/* Commands from ASP */
+#define PSP_GFX_INT_CTXT_UAL_CAT_CMD 0x01000000
+/* Mask for Command bits */
+#define PSP_GFX_INT_CTXT_UAL_CAT_CMD_MASK 0x000000FF
+/* Notifications from ASP */
+#define PSP_GFX_INT_CTXT_UAL_CAT_NOTIFY 0x02000000
+/* Mask for category bits */
+#define PSP_GFX_INT_CTXT_UAL_CAT_MASK 0xFF000000
+
+#define PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID 0x00000001
+#define PSP_GFX_INT_CTXT_UAL_CMD_PAUSE_ID 0x00000002
+#define PSP_GFX_INT_CTXT_UAL_CMD_RESUME_ID 0x00000003
+
+/* Command interrupts from ASP (GIM must execute action) */
+#define PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE \
+	(PSP_GFX_INT_CTXT_UAL_CAT_CMD | PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID)
+
+#define PSP_GFX_INT_CTXT_UAL_CMD_PAUSE \
+	(PSP_GFX_INT_CTXT_UAL_CAT_CMD | PSP_GFX_INT_CTXT_UAL_CMD_PAUSE_ID)
+
+#define PSP_GFX_INT_CTXT_UAL_CMD_RESUME \
+	(PSP_GFX_INT_CTXT_UAL_CAT_CMD | PSP_GFX_INT_CTXT_UAL_CMD_RESUME_ID)
+
+enum psp_gfx_ual_npa_address_mode {
+	PSP_GFX_UAL_NPA_ADDRESS_MODE_SOURCE_ALIASING = 0,
+	PSP_GFX_UAL_NPA_ADDRESS_MODE_SOURCE_IDENTIFICATION = 1,
+	PSP_GFX_UAL_NPA_ADDRESS_MODE_MAX
 };
 
 enum psp_gfx_ual_ports_per_station
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
index 85857b747bd46..dcfc9be269b07 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
@@ -428,6 +428,48 @@ static const struct amdgpu_irq_src_funcs psp_v15_0_8_irq_funcs = {
 	.process = psp_v15_0_8_irq_process,
 };
 
+static void psp_v15_0_8_ual_cmd_cfg_update(struct amdgpu_psp_irq_mgr *mgr,
+					   u32 event_id,
+					   struct amdgpu_iv_entry *entry)
+{
+	struct amdgpu_device *adev = mgr->psp->adev;
+
+	amdgpu_ualink_config_update_handler(adev);
+}
+
+static void psp_v15_0_8_ual_cmd_pause(struct amdgpu_psp_irq_mgr *mgr,
+				      u32 event_id,
+				      struct amdgpu_iv_entry *entry)
+{
+	struct amdgpu_device *adev = mgr->psp->adev;
+
+	amdgpu_ualink_pause_handler(adev);
+}
+
+static void psp_v15_0_8_ual_cmd_resume(struct amdgpu_psp_irq_mgr *mgr,
+				       u32 event_id,
+				       struct amdgpu_iv_entry *entry)
+{
+	struct amdgpu_device *adev = mgr->psp->adev;
+
+	amdgpu_ualink_resume_handler(adev);
+}
+
+static const struct amdgpu_psp_irq_handler psp_v15_0_8_ual_irq_handlers[] = {
+	{
+		.event_id = PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE,
+		.callback = psp_v15_0_8_ual_cmd_cfg_update,
+	},
+	{
+		.event_id = PSP_GFX_INT_CTXT_UAL_CMD_PAUSE,
+		.callback = psp_v15_0_8_ual_cmd_pause,
+	},
+	{
+		.event_id = PSP_GFX_INT_CTXT_UAL_CMD_RESUME,
+		.callback = psp_v15_0_8_ual_cmd_resume,
+	},
+};
+
 static int psp_v15_0_8_register_irq_handler(struct amdgpu_psp_irq_mgr *mgr,
 					    struct amdgpu_irq_src *irq_src)
 {
@@ -443,7 +485,11 @@ static int psp_v15_0_8_register_irq_handler(struct amdgpu_psp_irq_mgr *mgr,
 	if (ret)
 		return ret;
 
-	return 0;
+	ret = amdgpu_psp_irq_mgr_register(
+		mgr, psp_v15_0_8_ual_irq_handlers,
+		ARRAY_SIZE(psp_v15_0_8_ual_irq_handlers), NULL);
+
+	return ret;
 }
 
 static const struct psp_funcs psp_v15_0_8_funcs = {
-- 
2.55.0

