Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35738CDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF4BF10F08A;
	Wed, 24 Jun 2026 18:09:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VtuECzBh";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011035.outbound.protection.outlook.com
 [40.93.194.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E280810F087
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYQ6kR3Yyiq+Qb01TVUuEZzmEPJGYmaMMyAWeP62/hJycohc+R96+BQEF6H3H7pX/doplQylRRb/GTLFJcjS2L+9WlVvW46Bt3L2piqL2W0gemw7nX1upIlebWCQd2gg9bRY61cBzBDp98JbuBkHIuTrIXhXS/Id3hEemNRKWZajN2t2kuw28mJ9ycJ7bdwJkPeAiXA0eOFmRiFKyLEatwiRqwnbUsG47+Gt20ADcn5mK2CvEq/5UHMmSV7oQD+YwRoblUgpQLi1SsV2GLGf4NANLhOGvscs7WcvlB3+iUbHuY2tguJRFPb/X6H2nuM6HuhLGNF4zq+IoWfKHrfD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J462PgV3n+ETHWu+1cFoqFSj6i17KAWmKGjW+FEfRuo=;
 b=GBYgyMUiQ6KOLYhEpW7Tb/W7RZ9ozOmQMmJCpFPe5PkOnqsULer/G3CyF0LKpgBZmA8eQK2gMaHpU/y+pFm7kW/hSM/FQDx4S1LKlHJ9INlQ2VX4U2scTXHcc1GaLIxx2SuI7ClPrIni5ogRns9OKknIfeWGYqv8Qb01vLYkfsIJJ8Xtw7coG56wrC0ZTsRd7/sMNK5Nu7P7dC+m8ZBSwi093KsspB8h0b5C7FomkRASY+GlU0GTbFdxiiGRvs0sgY8DwrLloZEoAkkoHILwZ0uzQLwdBob93cXM6mJQDJ0UZr8fyXXdJI2nBt8e8LCAXvBTO4tK6jKR9HxkdQUTsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J462PgV3n+ETHWu+1cFoqFSj6i17KAWmKGjW+FEfRuo=;
 b=VtuECzBhGcMbL6NY3EEcC3SUxGTzya4W0AfB+JCU7rGkDp21NKOP7l9/jCG/pkAYT1eHWjnCwdgbavrZRygfK13oXj0DP2hYm1EXUneR1UNwYQs2THac3HfyiND7iIQK2KZWx5Cwv0EB9g5QSTytXOzktX6EIsYpdictH9xoDXk=
Received: from SJ0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:33a::14)
 by SJ2PR12MB8928.namprd12.prod.outlook.com (2603:10b6:a03:53e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Wed, 24 Jun
 2026 18:09:14 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::aa) by SJ0PR03CA0009.outlook.office365.com
 (2603:10b6:a03:33a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Wed,
 24 Jun 2026 18:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:12 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:11 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chen-Yu Chen <chen-yu.chen@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 06/28] drm/amd/display: Simplify boolean checks
Date: Wed, 24 Jun 2026 14:03:04 -0400
Message-ID: <20260624180829.4775-7-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SJ2PR12MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 86221b44-ad1c-4ac6-4d3f-08ded21bb250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: xMcAHIz2PSSxt7TZWjGghfL6XwRVsHoJmJElJRkTD9blpyyBdv0njqD3WijDvnaiMUPebMQjyLJsy5Rfzn/ZbMmMpKP4RfhoOQP+shS46juFqyUrvk+jym8DGroSs3nGB0ToPB0fCcWBpIDeL9EHn2RGENd/a0vSt+XZE0gFM9K30uZ1d+gXiNUJaIP9Ls70jCPpUclwIlQ1rwuNKexH3PNiD5TyaYtbqh5cG3zyqzJaYYYw0xUgNx6PD7w2ZvgdsN/Nvk6NutHIBLSiLE5WyXZakvUaIspudqxZqHlXtkBE59+bNFTNoasqe2AdlgS9sQnLM+wSrU0RVYJSALIBFv3BhnYxv2vsLJ9yt3EMI63xfPZ/83CRU4zUAyuswr3jcLwQI2LAj5ojWHMvnz3dThNgcM0jV5BVeyqDvKE9iZcv8Y1RgnHWBOnSgilQisBi3cUA2Wahwe9ClgxgvSTXKKAxXQF5JzTj2fISB2Q5Ebd0MGvfpCNXj0gQwT980whYkrKQQtdLXJJeA5bLxgXAXHt0pQ53EEzxmijvmS5GVLyV1kTXp9rDPrq9TYXNcrYXEWj47oHwIiaah4SN+tgV7Wvr91IclZDKS+pKAbRYcz6cQwpDoDHeB/vabFLcT31N/ZxS8I6xWW/Bwk6cvATpgZpmscE/+4q6jSP9M7demoSMjW9Q/jkZC9kDmnIhoPVAuuo7Y/KybEiaE+nHI5YsEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J1c/XEqaYZTAmmoA6QDNJOT1n7V5y/3dT910yO2hdGLulmGBPMyQ1W8m4SlHbPAjG3tVuIg7tYzCD523vb3MOD0oCqf2CLW4J72EHvar5lbRsXmxz40Djv0sJmLG8ubX+ZPM3hZlXXGmKl1erQwqxKuhsFFPrDZTZTQK0QI1QeC8mYID/7TY8JZoyqbRwLnBjvNlC/gdxV+AKxAFdJKkfFNXfl1oHw/A6n3HepflOU0/2ChCLudJRLrd9LbxPDpjk1pKKj22fUrITVR7jxcbrZTsTFmItgun4LxOEwp3Nzezo2Ec4F6kpHc9Dmx567ofVNVbqiIvYCgSmXjln+Zw3jY48xgcaww3F553+g9Pnp8IdWQqUPNU2dG/6PsdCjPRUfqZ4bXHxW1dpJVFVk5RpRIQ9A1xmHuRZORBQb/Gc0EGNhw2Wyr4LA7AQiYSSnAe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:12.9922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86221b44-ad1c-4ac6-4d3f-08ded21bb250
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8928
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Use direct boolean in connector and IRQ code paths. This removes
redundant comparisons around MST state, IRQ validation, handler
removal, and DMUB notification offload without changing behavior.

Assisted-by: Copilot:GPT-5
Reviewed-by: Chen-Yu Chen <chen-yu.chen@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c   | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c     | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 6143cdcf2a32..d85f3eed5387 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -466,7 +466,7 @@ void amdgpu_dm_update_connector_after_detect(
 	struct drm_device *dev = connector->dev;
 
 	/* MST handled by drm_mst framework */
-	if (aconnector->mst_mgr.mst_state == true)
+	if (aconnector->mst_mgr.mst_state)
 		return;
 
 	sink = aconnector->dc_link->local_sink;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 85711a2f2ae0..a821183c076b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -188,7 +188,7 @@ static struct list_head *remove_irq_handler(struct amdgpu_device *adev,
 
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 
-	if (handler_removed == false) {
+	if (!handler_removed) {
 		/* Not necessarily an error - caller may not
 		 * know the context.
 		 */
@@ -326,7 +326,7 @@ void *amdgpu_dm_irq_register_interrupt(struct amdgpu_device *adev,
 	unsigned long irq_table_flags;
 	enum dc_irq_source irq_source;
 
-	if (false == validate_irq_registration_params(int_params, ih))
+	if (!validate_irq_registration_params(int_params, ih))
 		return DAL_INVALID_IRQ_HANDLER_IDX;
 
 	handler_data = kzalloc(sizeof(*handler_data), GFP_KERNEL);
@@ -392,7 +392,7 @@ void amdgpu_dm_irq_unregister_interrupt(struct amdgpu_device *adev,
 	struct dc_interrupt_params int_params;
 	int i;
 
-	if (false == validate_irq_unregistration_params(irq_source, ih))
+	if (!validate_irq_unregistration_params(irq_source, ih))
 		return;
 
 	memset(&int_params, 0, sizeof(int_params));
@@ -2188,7 +2188,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 					dmub_notification_type_str(notify.type));
 				continue;
 			}
-			if (dm->dmub_thread_offload[notify.type] == true) {
+			if (dm->dmub_thread_offload[notify.type]) {
 				dmub_hpd_wrk = kzalloc(sizeof(*dmub_hpd_wrk), GFP_ATOMIC);
 				if (!dmub_hpd_wrk) {
 					drm_err(adev_to_drm(adev), "Failed to allocate dmub_hpd_wrk");
-- 
2.53.0

