Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BD0CEBF92
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 09:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8454D10E14E;
	Tue, 18 Nov 2025 09:17:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rn6L5G7h";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012065.outbound.protection.outlook.com
 [40.93.195.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A28CD10E14E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 09:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HavwzKL1A9xUPGscuxjM6aj2GqOzpYfNt3QBuWMD8lkIIgji7hpbktKtNzQOvSOoWV/lMs7Y49QX+r7cKfPo6VxbBP1eLg7gp6QrC8WXVV1LqgDKB2a9lTkkCtHoDtxWdsc/EE7IbBnnMrvImr772rrGOK2zB8JgGmH+cR4U2rX01WiMk/AYn+3vlSQrXdmnWjCid/CxM8aztUz0mvXQksQbtLUxF/Wpv4/ANKzT3VGFrsIgsXo1aJnHDBHmGGXEYtiLuqTWEFJUQhl/rX/WgYWHraZw7BuCzufWkWIFDwMTvB2RduJDhQVvn3OfOP2vlyjQ6wXvmxBPSq+m2u+1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jM0BDrDpYcE01s5gjXiNlbc7ZFSeQQPYFlKfwK67TSk=;
 b=JFI//Y+Fk4QuVjNfVIQEalI36ll9zxe3cpPGKKCisEWFo2glZ4Pdeqwi0hZlOJuWV+XX1CPfDDWzy9HOfdb/LU99g2HnaBXaHKGrBAURjgvIpOj9psU795N5G8FTf9ydfv9nFsqh03NRiqPU4jDees3lBFMw50Uptz1VyDNvS3jYnsG4HNp6m9h+q1lSznjDvecACzPMiYB/f9lPA229EqUJI0Z9FtHORNN3g+CgWYsoqlr4R3HtSr7JGdmcPR74NSyg1FpxlL+RRWg70jYqX5S+j1gxTxmHlc/tVBPutm2TI6q7+iAKFX5o1Udw56VJyhRxsi/ael4OmKaZQ51bBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jM0BDrDpYcE01s5gjXiNlbc7ZFSeQQPYFlKfwK67TSk=;
 b=rn6L5G7hkm8lUhzVA5WICHgIFqh3AHw5Q60xv52/WOlCh4JkfjLClHx44PgdLhXHzHYScJLEYYH8/JlGx+LqwoayEMGsga9v2700PV6f8+4Nf3MkiVDlPqGY/Fs7tA1ZHHFr878NG09Ub0zcLfN5+osICfvxsJ2pjicpWHyesgo=
Received: from BL1PR13CA0317.namprd13.prod.outlook.com (2603:10b6:208:2c1::22)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 09:16:58 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::dc) by BL1PR13CA0317.outlook.office365.com
 (2603:10b6:208:2c1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 09:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 18 Nov 2025 09:16:58 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 01:16:56 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/7] drm/amd/ras: sriov supports handling VF ras commands.
Date: Tue, 18 Nov 2025 17:15:54 +0800
Message-ID: <20251118091559.959683-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118091559.959683-1-YiPeng.Chai@amd.com>
References: <20251118091559.959683-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 7665c62f-464f-4670-be4c-08de268339fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jDTsDMdEJ2GFAOG2U19Y5TGd5Gbt37Hc6S01jgMWwEM4yNZeOtxFN3P9ZzEn?=
 =?us-ascii?Q?ZCGY23plOl+6wKq8Y6iq4qouIxI0muPttS6fDw4YEkPdBTaINC7Y0ptgjYTj?=
 =?us-ascii?Q?2U0i7WjJCqNKbWeK8fySu5k5oyw7slicuaGlB7A6ZNNA6k6L+JOV4CK5CerQ?=
 =?us-ascii?Q?m4d3HVjL/Vnx6qAvOEMao7Vrode/WL1XYiSC8fZmeW+QZufVq1TahFXiICoc?=
 =?us-ascii?Q?GNXDSDREBseSLey0NJ2VR4X34gNoSzpKTmvf3aun+NxY8sdSnoCYMUxbhFMv?=
 =?us-ascii?Q?O3Uw9Q+UL/x9U9K8NrxYPjXE0YStppdemGlj2XbytcKtePHEfafK0TpH9ifS?=
 =?us-ascii?Q?BasxJiHpRyPriUOliAC7tzEJxyaTx/y/SFftf3AxusMe66nA5u9rk6WIwN3h?=
 =?us-ascii?Q?Swp0kMnRhWnFp/xZAbA8KW18ciEfoQzvteLHJ3Jl208Aj3fSWXouojnQfiL7?=
 =?us-ascii?Q?LpHfBTVzGl/vm2CjX8HnRlXC9CJj7DqKDREuvbX9DuUaBXTsrRELK3U6ErZJ?=
 =?us-ascii?Q?5UXKRfxU2zmW9f5PEIe4vUHfRpSRyE/f9EvKEhN4M56ykzZmUJ3LEyqZHeSj?=
 =?us-ascii?Q?mS/j7hziU71pAbvlda7ZGbuFgYPBXBDE6jXRObXo16Y9if46H1c7tfhs7P0s?=
 =?us-ascii?Q?y491CsnNYL8F4Rj+/gE7jc2FTTfkAhs85ttH4TAfAo6cw00r3jc7nSL+Cn84?=
 =?us-ascii?Q?fCO0/zCBOvSHwv+KtUNypkS+q2I/reA3JLSiZQlMoND8EMBQ7B6jiHmNJpj/?=
 =?us-ascii?Q?6mLh0hLUsgoyVt/MuzmMy9bUDJdSbMTjWkk5cGZnB/OxqGv7RKMVH7TQvuEC?=
 =?us-ascii?Q?gsUQd89sUaGFn4FSEwjhrUrbh9acbPvpO6gF8nZ0ExDBsjw/mz8Ect2aSkdO?=
 =?us-ascii?Q?L5HNQpyk6EJ7mzAAs4pK/nzRXw/pb6yatx6bTYZH75Cs8fk+vhfeFd9c1JSQ?=
 =?us-ascii?Q?M7CPAsd1OSt8A7X2c9gnoD9nUpEr7MB0ZWC4dQKutlbcezzGsxl8X36A7okf?=
 =?us-ascii?Q?5+jqkE3mbzKWwtGWhklJ5dIqSSCbnBf0iBHD6cLGXsljganP1PLbh1f9DQt+?=
 =?us-ascii?Q?nMtSFHtc1RLRPGsmGfbF4z30CfP2aw8Stiv7u81Lpb2aB2meW3knHh+auIG9?=
 =?us-ascii?Q?0DPh1d8rTdOgd3zPDHav3nyq7CZtYIUJIlYfq3MUiwgi6+XnQzzZvHuD0RS2?=
 =?us-ascii?Q?ZPaeVB9jEHdLlnUXZelQqegFaY5HimH1D0rS2tA0etdcg9QjlBHnWpltMMWO?=
 =?us-ascii?Q?bPyZL9RnKTobP+10hDgzXX+HHwxl5QU/L5h3oVUdqssm0Oj9f4IlHVGaLM2B?=
 =?us-ascii?Q?5LQ729B78rH7YWV7oMHRSjmPaGX0EOls0hyfUaD2o/yiwiCStVDwX3oGL6KM?=
 =?us-ascii?Q?TqmG3LFpaoxtKweepliS72apFPIm1UYgdsOgoLd41tkGTgQGGazOtdBlYHHs?=
 =?us-ascii?Q?njeTsXAYmd6MvVBKqn2/ppl9iYT+ykoV8hZbkaK58qHdRd+fuVnsxTMN3JnO?=
 =?us-ascii?Q?Tt9zSfcEMZ1dJCGu47F5uolsIA6NQs8XfpAYqNfnRt0c7t5k1sewcD1FHyDP?=
 =?us-ascii?Q?V6nO9sBhZUwxbmWv99k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:16:58.7999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7665c62f-464f-4670-be4c-08de268339fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
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

Add basic framework code to sriov to handle
VF ras commands.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/Makefile      |   1 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  |   5 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  35 +++--
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |   1 +
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 137 ++++++++++++++++++
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h |  38 +++++
 6 files changed, 207 insertions(+), 10 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile b/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
index 5e5a2cfa4068..6759635aadc2 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/Makefile
@@ -23,6 +23,7 @@ RAS_MGR_FILES = amdgpu_ras_sys.o  \
 		amdgpu_ras_eeprom_i2c.o \
 		amdgpu_ras_mp1_v13_0.o \
 		amdgpu_ras_cmd.o \
+		amdgpu_virt_ras_cmd.o \
 		amdgpu_ras_process.o \
 		amdgpu_ras_nbio_v7_9.o
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index 78419b7f7729..cb6498c30834 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -28,6 +28,7 @@
 #include "ras_sys.h"
 #include "amdgpu_ras_cmd.h"
 #include "amdgpu_ras_mgr.h"
+#include "amdgpu_virt_ras_cmd.h"
 
 /* inject address is 52 bits */
 #define	RAS_UMC_INJECT_ADDR_LIMIT	(0x1ULL << 52)
@@ -252,6 +253,7 @@ int amdgpu_ras_handle_cmd(struct ras_core_context *ras_core, struct ras_cmd_ctx
 
 int amdgpu_ras_submit_cmd(struct ras_core_context *ras_core, struct ras_cmd_ctx *cmd)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
 	struct ras_core_context *cmd_core = ras_core;
 	int timeout = 60;
 	int res;
@@ -259,6 +261,9 @@ int amdgpu_ras_submit_cmd(struct ras_core_context *ras_core, struct ras_cmd_ctx
 	cmd->cmd_res = RAS_CMD__ERROR_INVALID_CMD;
 	cmd->output_size = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return amdgpu_virt_ras_handle_cmd(cmd_core, cmd);
+
 	if (!ras_core_is_enabled(cmd_core))
 		return RAS_CMD__ERROR_ACCESS_DENIED;
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index afe8135b6258..4ce337b6e0e8 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -27,6 +27,7 @@
 #include "ras_sys.h"
 #include "amdgpu_ras_mgr.h"
 #include "amdgpu_ras_cmd.h"
+#include "amdgpu_virt_ras_cmd.h"
 #include "amdgpu_ras_process.h"
 #include "amdgpu_ras_eeprom_i2c.h"
 #include "amdgpu_ras_mp1_v13_0.h"
@@ -316,6 +317,16 @@ static int amdgpu_ras_mgr_sw_init(struct amdgpu_ip_block *ip_block)
 	amdgpu_ras_process_init(adev);
 	ras_core_sw_init(ras_mgr->ras_core);
 	amdgpu_ras_mgr_init_event_mgr(ras_mgr->ras_core);
+
+	if (amdgpu_sriov_vf(adev)) {
+		ret = amdgpu_virt_ras_sw_init(adev);
+		if (ret) {
+			RAS_DEV_ERR(adev,
+				"Virt ras sw_init failed! ret:%d\n", ret);
+			goto err;
+		}
+	}
+
 	return 0;
 
 err:
@@ -335,6 +346,9 @@ static int amdgpu_ras_mgr_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (!ras_mgr)
 		return 0;
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_ras_sw_fini(adev);
+
 	amdgpu_ras_process_fini(adev);
 	ras_core_sw_fini(ras_mgr->ras_core);
 	ras_core_destroy(ras_mgr->ras_core);
@@ -359,9 +373,13 @@ static int amdgpu_ras_mgr_hw_init(struct amdgpu_ip_block *ip_block)
 	if (!ras_mgr || !ras_mgr->ras_core)
 		return -EINVAL;
 
-	ret = ras_core_hw_init(ras_mgr->ras_core);
+	if (amdgpu_sriov_vf(adev))
+		ret = amdgpu_virt_ras_hw_init(adev);
+	else
+		ret = ras_core_hw_init(ras_mgr->ras_core);
+
 	if (ret) {
-		RAS_DEV_ERR(adev, "Failed to initialize ras core!\n");
+		RAS_DEV_ERR(adev, "Failed to initialize hw_init!, ret:%d\n", ret);
 		return ret;
 	}
 
@@ -385,7 +403,10 @@ static int amdgpu_ras_mgr_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (!ras_mgr || !ras_mgr->ras_core)
 		return -EINVAL;
 
-	ras_core_hw_fini(ras_mgr->ras_core);
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_ras_hw_fini(adev);
+	else
+		ras_core_hw_fini(ras_mgr->ras_core);
 
 	ras_mgr->ras_is_ready = false;
 
@@ -423,9 +444,6 @@ int amdgpu_enable_uniras(struct amdgpu_device *adev, bool enable)
 	if (!ras_mgr || !ras_mgr->ras_core)
 		return -EPERM;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EPERM;
-
 	RAS_DEV_INFO(adev, "Enable amdgpu unified ras!");
 	return ras_core_set_status(ras_mgr->ras_core, enable);
 }
@@ -437,9 +455,6 @@ bool amdgpu_uniras_enabled(struct amdgpu_device *adev)
 	if (!ras_mgr || !ras_mgr->ras_core)
 		return false;
 
-	if (amdgpu_sriov_vf(adev))
-		return false;
-
 	return ras_core_is_enabled(ras_mgr->ras_core);
 }
 
@@ -603,7 +618,7 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
 	uint32_t ctx_buf_size = PAGE_SIZE;
 	int ret;
 
-	if (!amdgpu_ras_mgr_is_ready(adev))
+	if (!amdgpu_sriov_vf(adev) && !amdgpu_ras_mgr_is_ready(adev))
 		return -EPERM;
 
 	cmd_ctx = kzalloc(ctx_buf_size, GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index 8fb7eb4b8f13..080ac84fc5a5 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -50,6 +50,7 @@ struct amdgpu_ras_mgr {
 	struct ras_core_context *ras_core;
 	struct delayed_work retire_page_dwork;
 	struct ras_event_manager ras_event_mgr;
+	void *virt_ras_cmd;
 	uint64_t last_poison_consumption_seqno;
 	bool ras_is_ready;
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
new file mode 100644
index 000000000000..8c4be1af76b2
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include <linux/pci.h>
+#include "amdgpu.h"
+#include "amdgpu_ras.h"
+#include "ras_sys.h"
+#include "amdgpu_ras_cmd.h"
+#include "amdgpu_virt_ras_cmd.h"
+#include "amdgpu_ras_mgr.h"
+
+static int amdgpu_virt_ras_remote_ioctl_cmd(struct ras_core_context *ras_core,
+			struct ras_cmd_ctx *cmd, void *output_data, uint32_t output_size)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	uint32_t mem_len = ALIGN(sizeof(*cmd) + output_size, AMDGPU_GPU_PAGE_SIZE);
+	struct ras_cmd_ctx *rcmd;
+	struct amdgpu_bo *rcmd_bo = NULL;
+	uint64_t mc_addr = 0;
+	void *cpu_addr = NULL;
+	int ret = 0;
+
+	ret = amdgpu_bo_create_kernel(adev, mem_len, PAGE_SIZE,
+			AMDGPU_GEM_DOMAIN_VRAM, &rcmd_bo, &mc_addr, (void **)&cpu_addr);
+	if (ret)
+		return ret;
+
+	rcmd = (struct ras_cmd_ctx *)cpu_addr;
+	memset(rcmd, 0, mem_len);
+	memcpy(rcmd, cmd, sizeof(*cmd));
+
+	ret = amdgpu_virt_send_remote_ras_cmd(ras_core->dev,
+				mc_addr - adev->gmc.vram_start, mem_len);
+	if (!ret) {
+		if (rcmd->cmd_res) {
+			ret = rcmd->cmd_res;
+			goto out;
+		}
+
+		cmd->cmd_res = rcmd->cmd_res;
+		cmd->output_size = rcmd->output_size;
+		if (rcmd->output_size && (rcmd->output_size <= output_size) && output_data)
+			memcpy(output_data, rcmd->output_buff_raw, rcmd->output_size);
+	}
+
+out:
+	amdgpu_bo_free_kernel(&rcmd_bo, &mc_addr, &cpu_addr);
+
+	return ret;
+}
+
+static struct ras_cmd_func_map amdgpu_virt_ras_cmd_maps[] = {
+
+};
+
+int amdgpu_virt_ras_handle_cmd(struct ras_core_context *ras_core,
+		struct ras_cmd_ctx *cmd)
+{
+	struct ras_cmd_func_map *ras_cmd = NULL;
+	int i, res;
+
+	for (i = 0; i < ARRAY_SIZE(amdgpu_virt_ras_cmd_maps); i++) {
+		if (cmd->cmd_id == amdgpu_virt_ras_cmd_maps[i].cmd_id) {
+			ras_cmd = &amdgpu_virt_ras_cmd_maps[i];
+			break;
+		}
+	}
+
+	if (ras_cmd)
+		res = ras_cmd->func(ras_core, cmd, NULL);
+	else
+		res = amdgpu_virt_ras_remote_ioctl_cmd(ras_core, cmd,
+					cmd->output_buff_raw, cmd->output_buf_size);
+
+	cmd->cmd_res = res;
+
+	if (cmd->output_size > cmd->output_buf_size) {
+		RAS_DEV_ERR(ras_core->dev,
+			"Output data size 0x%x exceeds buffer size 0x%x!\n",
+			cmd->output_size, cmd->output_buf_size);
+		return RAS_CMD__SUCCESS_EXEED_BUFFER;
+	}
+
+	return RAS_CMD__SUCCESS;
+}
+
+int amdgpu_virt_ras_sw_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	ras_mgr->virt_ras_cmd = kzalloc(sizeof(struct amdgpu_virt_ras_cmd), GFP_KERNEL);
+	if (!ras_mgr->virt_ras_cmd)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int amdgpu_virt_ras_sw_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	kfree(ras_mgr->virt_ras_cmd);
+	ras_mgr->virt_ras_cmd = NULL;
+
+	return 0;
+}
+
+int amdgpu_virt_ras_hw_init(struct amdgpu_device *adev)
+{
+	return 0;
+}
+
+int amdgpu_virt_ras_hw_fini(struct amdgpu_device *adev)
+{
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
new file mode 100644
index 000000000000..7e3a612eaeb0
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __AMDGPU_VIRT_RAS_CMD_H__
+#define __AMDGPU_VIRT_RAS_CMD_H__
+#include "ras.h"
+
+struct amdgpu_virt_ras_cmd {
+};
+
+int amdgpu_virt_ras_sw_init(struct amdgpu_device *adev);
+int amdgpu_virt_ras_sw_fini(struct amdgpu_device *adev);
+int amdgpu_virt_ras_hw_init(struct amdgpu_device *adev);
+int amdgpu_virt_ras_hw_fini(struct amdgpu_device *adev);
+int amdgpu_virt_ras_handle_cmd(struct ras_core_context *ras_core,
+		struct ras_cmd_ctx *cmd);
+
+#endif
-- 
2.34.1

