Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D092C021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07AFD10E569;
	Tue, 25 Feb 2025 06:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3i6euK6Y";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F078C10E569
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysAW32W5L039dcZTCOEigtPki0FhTtc8w41fdC7A8yW7B0mCwqm4eboWb0rBzUzwSsr+eIMZvJOP4+pfVhrZWritukpJNPWsR7vtxd6leMPsmA0yuSmLHaaIcI4DGyy/i1uz+CEYifaE41dYZ/Yyr8IrNJ8980YPMCUeTn89lnaLRdGITn/qpyj58kl3l4yNRZ8Ixbi9lL0b3IDBmjX9sClK67PMSH+G3M4qtUFfpYBzTTWNOE2tnF2kYS2zJlRiKoSoYI9Aj/MxWohogfucK3DMzKBrqwkAqhd2xYxxbjt0tdeSQP1zhv/k2xIaZI2dkjFs8ffLfnpqFSqV0K/j6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92buZ6QcVM0nKjTKlptKkoza2ASYEyjY8WsVKI7sKKs=;
 b=xpJbOInneQhl+rj892D2JbqcPZ+sbmKR+BTooqQVmDLawvcvgv++18PQq3+/21Kdu7CIPp3w6jCoWtTEsDd/Ydm/mZwd8ySNNngykBNdNSh3BIPF97AlNP6XRYNZyxi+Ou6VvtcuUXP3zdAFqKbaXK6AMiUem7nsJAd4El7NKqhv5a23X15HKA9IhoI0+SXhbvJBq2fTAscDW750QWpXEHAd4iiLOM+UwM4C+1Fj15vaaZS2DBk3PQOU3ibYiFNeKPZUp4yh4zEyGKjaB3RHnANcqlf9VqejbLQsaBLl2C3wvRCjHrc1gXyEhnQ2TguHfwoCuhlspnDhECQ8JqI4oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92buZ6QcVM0nKjTKlptKkoza2ASYEyjY8WsVKI7sKKs=;
 b=3i6euK6Y3H7Up3ehPrIxC1Lxt25S0nY9UqW8rozo86q4Xn+f958RaF3k/O4N6QIXnjdOCFnz25VSpUyt3NHdgekFElYmvzWAs2ym17pPB4BsX4aV37AYHBGdMlSD4DQAUNb0kg+Na5GZ7oEypSHhwtOr6h8Ey4SAVP088CzUVkw=
Received: from BN0PR04CA0146.namprd04.prod.outlook.com (2603:10b6:408:ed::31)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 06:38:06 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::74) by BN0PR04CA0146.outlook.office365.com
 (2603:10b6:408:ed::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 06:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:38:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:01 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:37:57 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 18/27] drm/amd/display: Use drm_err() instead of DRM_ERROR in
 dm_resume()
Date: Tue, 25 Feb 2025 14:36:01 +0800
Message-ID: <20250225063610.631461-19-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d05a071-3de3-4ad9-b5b6-08dd5566f5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZAMj9dcoFAHfL+Q2vzgUbujdgbznBCJkSMvt2oFIDyyhT58InYcXHcVb5Jfb?=
 =?us-ascii?Q?029NqV9DyJgYSHpI8e/sUDg75G8IYhpQt260WiHzyKytbAfRl5w3BmNL0Yc6?=
 =?us-ascii?Q?KJNBgTaVvZn84uoKD//djd96nCt7PWzg+IgvFp/aI0FMCQ57yGAl40Oqj2Rs?=
 =?us-ascii?Q?JPEZUouNvwUHXtBqJ0a1Gn51PjAtJ+ORm/fM+oefufTy1u2gO+/+rhi2lMlq?=
 =?us-ascii?Q?CK5h3YIqDEKxM8codF/67aocTSpxWAcTQMCX+oaooaonMpEYUi5feFTSFzop?=
 =?us-ascii?Q?W6mYVdZW0PdMuxj3Q4j8M536rhuXvs2l4n7ykPulMJ5x/6rXIOCtQiS1iiM+?=
 =?us-ascii?Q?/SP77B418KRI4ef6KAzUBr/y4g6XPYqW4jahKQ8tlql11tkpWGNE7ElhnPyP?=
 =?us-ascii?Q?dgrMuPtZx8qbS3A+TQsIjR1lSPB4Y4Nn3ZHvt6Dd3f0AUAz6BXus9QLu2dP2?=
 =?us-ascii?Q?D34ixqe64K1kE5lf5k0f8isfRrblhXkN0VbKpFfAC5GW414X5n2akN4BaGsZ?=
 =?us-ascii?Q?XuADW8Z4rSKnLz1a/aLNb/+g9/ZI/4QN+bhOv4vAcF5NBtjoFBoMovhikJ+U?=
 =?us-ascii?Q?m6NbrHysqNzZdWv2SZqxbqi/sDYYuUQbmZ5BYYtMU14/EmuLaM6qf/dps23K?=
 =?us-ascii?Q?Eayc5hV2ThSggZNysbnzAbZ7rD1p7fbN4LaWckOQvIm/X+PjzTeh42ZM3aVw?=
 =?us-ascii?Q?TaVjgwIA8Zz7BDKg4hJ0r5gCN2r5ZY176+D/KwoyJ4AcBQEDypAmPMzfo/Wv?=
 =?us-ascii?Q?UaSigKihdys8b8eJu6j0K2bpN2Ycm97JhBSjkmshqCGEa+PO8VKWGwFSNHcL?=
 =?us-ascii?Q?wngzo4Mg2/PtZnJt+jk/A3HfhzcHfsJmmdwsFDMz5CqvX1+Sf3jbwiuFfHEh?=
 =?us-ascii?Q?gVIQD2MTpwseB70tMiHG5n+nfABGbK05YuZSF/ppGIVqcLsQ6XtM3skYrenj?=
 =?us-ascii?Q?7mGyTfC2pxUobG/MlSKrzJrDHVk9ALZVZwvt9dj9ExL4Myyyh0NgLGXFLkhc?=
 =?us-ascii?Q?UTxPnyz7Kkq1oIFRp2w0NkF3bgoAA40+HBftDOrvv0ddSTx2NWQ3qViCweTH?=
 =?us-ascii?Q?+wWcO64adlk4bTeSWkSh1Ac9fGrQSe2fBmQcdrgRJjsAvPiVlV9LQr6uNiW+?=
 =?us-ascii?Q?1x/0EsNHhjNd5SWNxe0OL3/44dI9FHwm+LLG/lCTbq0jQdqkNPcO62taagjo?=
 =?us-ascii?Q?PdWtp8Im2Eld9KWpBwcBebwcRDKuXwqsQqWt5Ao1aLZLOeMDqYady7zzeQjo?=
 =?us-ascii?Q?kEkFTxaNbQsLg75WZPUOfIWE5wmhV1N+FngME9oy8OH/yp49OSNUkbhXAzXS?=
 =?us-ascii?Q?4JfwXj8TQ+GCq3SD40VkSgZnrY5yD/P80wiENP1ujbb5QFkYPoCrvs8Qy7xE?=
 =?us-ascii?Q?guc0jWCAOBqZ+Y866gJl/2TNf56rrvlKUpfG/ssyBmyf3JP/579BLLzW+CIz?=
 =?us-ascii?Q?HjS5SvcaXMc0v9VqFhOXsLqCMzbKqniCyql4aBcRQErilAKHBUdmyaQIJOWP?=
 =?us-ascii?Q?2rpNk2vr5lefzmU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:38:05.2237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d05a071-3de3-4ad9-b5b6-08dd5566f5ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
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

From: Mario Limonciello <mario.limonciello@amd.com>

drm_err() is helpful to show which device had the error. Adjust to
using this instead for error messages.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6e218e69f039..3bf09c17ce85 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3376,7 +3376,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 
 		r = dm_dmub_hw_init(adev);
 		if (r)
-			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
+			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
 
 		dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D0);
 		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
@@ -3469,7 +3469,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 
 		mutex_lock(&aconnector->hpd_lock);
 		if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
-			DRM_ERROR("KMS: Failed to detect connector\n");
+			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
 		if (aconnector->base.force && new_connection_type == dc_connection_none) {
 			emulated_link_detect(aconnector->dc_link);
-- 
2.37.3

