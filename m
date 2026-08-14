Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16382C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 321E410F724;
	Fri, 14 Aug 2026 21:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vp0NWOV1";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 768A710F713
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSjBRrAiHecpJ9j8RADhXgkXSG2T8hfvZGL0HsXs06lGBSlNUzqMINAlzdDnW/649iPTxUkLyx9UrUpCac2S186aTrFzajrDqbRUPJmuCDlPLU23S101rdUzJg+xqix32tdDD9rj5PINy2M6OfrHWC/NmkHCh33oIBYWSEug2MkO9Xv9bNO4fR9ocA4TSdfI6fJRaluLuVT9vA9NbHu8soCFfJFPBZIsXUuX883s8qGfne/oGyMLW/J3dZIzaVXK5Tmk8sOHXgGfIUa3biWs6dUyXYpeZNKWggERpb8LFnq62J0dengTDs9gr8ie4qiEEh+UGd8iYeb9nSJuwqFs1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLlpQCvv5/IDYT6+DMcGT9yWsx1QDvhNoM4EJSKyxpE=;
 b=Y17QwNPiO6ytwZbeoj3hlLyl8310uHf2DOjVmEkXQwLtVgW50rjQf0kS7RaHSbA6BZ2gQc/xRhX3r8Ok6bOzWMeQJ5t49Ut9S92SePVBA8ZdaW2ysBbk7u2lrLcv8Pviq+KVdrmiwjg432CoLyD6dyzo7sv1HATGtDJo+N/Qg80PH/KaCcoAJNVWH4uhbpaJO+VKdFir0M7400O9ohffkYk3ydKp0kzQQtGbpJOPG2WO564j7oXcYj8lGpbk18VoqMu6cpCSAtoRzOclrExMfJFFSyFi9e5VGaxZLyo84BRxz10i9CfHwufR/WS2qAh0+vpQ5h+MXJLqrEeD7FA/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLlpQCvv5/IDYT6+DMcGT9yWsx1QDvhNoM4EJSKyxpE=;
 b=Vp0NWOV1w0YSdDGf6f1ZfnGSGA6nwWhYP/fiEG1rnqbAdkTxsxUEhiiWeBBdS3ZF6IORVTMua4LMOo38ok5l/0ETlgvHtOKR4o+4qSaj98ZxAKAylm4ln3MnnytJPNP8+Rt24+fy++2yjU02TtwiW5RbMFet+1Ileen/v6QYvQM=
Received: from SJ0PR13CA0183.namprd13.prod.outlook.com (2603:10b6:a03:2c3::8)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:43 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::76) by SJ0PR13CA0183.outlook.office365.com
 (2603:10b6:a03:2c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.6 via Frontend Transport; Fri, 14
 Aug 2026 21:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:36 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Yang Wang <kevinyang.wang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 064/109] drm/amd/ras: update mp1_v13_0 to use smu ras
 multi-parameter interface
Date: Fri, 14 Aug 2026 17:02:01 -0400
Message-ID: <20260814210246.3067612-65-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad19ca2-599e-462a-d0a4-08defa4785f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|10067099003|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WrepqWYFj0Ntmqmc2QH+SbbfX2teuiUwbvIkkDklUDIXw24pxJaOamireck17E42X5wh5c4kr1Wl9INpUGuhBSAWLF+xjRC3/LutiJ7eXRQ8XGSy9O+LTvW2eoMgXOwIYZTB+esYNl/frjcb8Njwi0L1hnUBhfPCKcihpW3+JYQbLZkV8akxncQ5C7CLvJJJKbBH6cB8Zi0JwCMxwW4YpWMp4GLLxOhXHc1nrO4iFVIqHmr8+7PRKUhlGn5X3jVmPK4LYvrAmHaeg7iX3MC26CqOLN4kA+ic0OAbXrlu5kxs8lT/eXhbYxM7by6DFUO4NSi0XrXB//DzPDYgDoe6Kk5j7i1F8UY47CM7qpbsHoBxKR4fmDoFnSx0BmC6lWtqzDT1X4GtGZJJamzKSx20LYGL6Kf5qYYGwDEukCiVCBpXJBWCS2Y9+QcYU+Rtbp6Fqbybmv7DsoR2C0ckJ+lSYOxprEiFH1xtEOBIxEWJ5QAx8cS8pM26i3DAv9UDTyETz7G6Fe1yGzFTX73Xy4GJ715fFwm1pSHEZz6rAK2KfL8Jv8mZq5VsPnpqGVzEEh7K2531QZIhu/A5tDNw1qmIHVZXD7VY1ZB+nwk1YL4hcsuj1kUaHI5eCqQiUug4FLITUHdYo9SAnFLFtrw7A9+alTexxc0TykVbnMFr3KwQ5uACxZ99EvboR3+TCChQ+ZmrYllSJYUFTc6WTMB4O6I2pA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(10067099003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aSjdD4MJ9hBQqJn9lnQ4Rq0JVHvzduhUl1vkIqNSHN6Xl1qhFN/OsueTURxlB1uBwwvvA5r0m8r/woxCizqGVyokZY6oW+GANrb0GINfXGge2K3Uhgo+kaOxQBv3NQZ7GFomb7TDGO8wyeY9lizSfrkvzMGb7Dlx2LEBlk48+BLcKGhoYghOdCnnztsf+PSdO4XftnXUP6UF1Cufx/hZDQ9Upow+X21sn1W4a5jE2SdV57DLd+iGoS46XG+hm6J5OaTbI0SG4QqNtgBAWWMDNkOqe4DNzUslLPx3Nr1Tjf2WOrcsTpOeEkurtSh7i+KUVlwnfR8jCCsDAPw8rBTHYOjqrALbnduaqtR4gdnNsHcD/uMn1FtuRbKLea7dPAAhCFdEB6YxauEcSiG9CC5W/YHYxxkHaqD2XsmLEWOo3OxJXSR1wtQKqKagxDI7WdAt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:42.9410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad19ca2-599e-462a-d0a4-08defa4785f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

update mp1_v13_0 to use smu ras multi-parameter interface.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c    | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
index bc89a2ad75ef1..7aa818a433f6d 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
@@ -39,6 +39,12 @@ static const enum smu_message_type pmfw_eeprom_msgs[] = {
 	[RAS_SMU_GetBadPageMcaAddr] = SMU_MSG_GetBadPageMcaAddr,
 };
 
+static int mp1_v13_send_smu_msg(struct amdgpu_device *adev, enum smu_message_type msg,
+			uint32_t param, uint32_t *read_arg)
+{
+	return amdgpu_smu_ras_send_msg(adev, msg, &param, 1, read_arg, read_arg ? 1 : 0);
+}
+
 static int mp1_v13_0_get_valid_bank_count(struct ras_core_context *ras_core,
 					  u32 msg, u32 *count)
 {
@@ -53,7 +59,7 @@ static int mp1_v13_0_get_valid_bank_count(struct ras_core_context *ras_core,
 			SMU_MSG_QueryValidMcaCeCount : SMU_MSG_QueryValidMcaCount;
 
 	if (down_read_trylock(&adev->reset_domain->sem)) {
-		ret = amdgpu_smu_ras_send_msg_legacy(adev, smu_msg, 0, count);
+		ret = mp1_v13_send_smu_msg(adev, smu_msg, 0, count);
 		up_read(&adev->reset_domain->sem);
 	} else {
 		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
@@ -80,8 +86,7 @@ static int mp1_v13_0_dump_valid_bank(struct ras_core_context *ras_core,
 		offset = reg_idx * 8;
 		for (i = 0; i < ARRAY_SIZE(data); i++) {
 			param = ((idx & 0xffff) << 16) | ((offset + (i << 2)) & 0xfffc);
-			ret = amdgpu_smu_ras_send_msg_legacy(adev, smu_msg,
-					param, &data[i]);
+			ret = mp1_v13_send_smu_msg(adev, smu_msg, param, &data[i]);
 			if (ret) {
 				RAS_DEV_ERR(adev, "ACA failed to read register[%d], offset:0x%x\n",
 					reg_idx, offset);
@@ -106,7 +111,7 @@ static int mp1_v13_0_eeprom_send_msg(struct ras_core_context *ras_core,
 	int ret = 0;
 
 	if (down_read_trylock(&adev->reset_domain->sem)) {
-		ret = amdgpu_smu_ras_send_msg_legacy(adev,
+		ret = mp1_v13_send_smu_msg(adev,
 			pmfw_eeprom_msgs[index], param, read_arg);
 		up_read(&adev->reset_domain->sem);
 	} else {
@@ -136,12 +141,13 @@ static int mp1_v13_0_get_ras_enabled_mask(struct ras_core_context *ras_core,
 static int mp1_v13_0_set_debug_mode(struct ras_core_context *ras_core, bool enable)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	u32 param = enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK |
+		ClearMcaOnRead_CE_POLL_MASK;
 	int ret;
 	u32 smu_msg = SMU_MSG_ClearMcaOnRead;
 
-	ret = amdgpu_smu_ras_send_msg_legacy(adev, smu_msg,
-			enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK |
-			ClearMcaOnRead_CE_POLL_MASK, NULL);
+	ret = amdgpu_smu_ras_send_msg(adev, smu_msg,
+			&param, 1, NULL, 0);
 	return ret;
 }
 
-- 
2.55.0

