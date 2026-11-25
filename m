Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEC5606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hTwY56Rb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D2FE10F541;
	Wed, 25 Nov 2026 06:56:29 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012063.outbound.protection.outlook.com
 [40.93.195.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E851710F541
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufbxdSPrsnoEhzKft6givWwN5SlnzatJcn1fwoi+b5vHZfXl1HMkJO2Q6xhUMKUmUChRfWVVZs2gi8RQ9NHTB3EsvxtSiKRHYMahP/vjvYkihwysh/Fg4AaAVMLzGrEntmp69Adicx2ykg1g0jn5tI7ciB8/ISXYe/5muFHXMcK9T1Z0EgRUJgUGUM6oDdE9G+MXPaZkN1LwcKFyl9CqURkmV5S8bMFGcpPJn26cz/PLQHwL1Zsi3BasoiX1IiVxeTqCDZSyxFTsn62ojSivmkR4chz/PcmSR276mLx8fWZjPXYS08YJjJH3iNVDpiqvMu6+TQqODx3AgZwZiTEBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcSKahmXL0QRzkC67Yoge+sUTezwiqqAstUHpaR0F78=;
 b=tkI1VKK4RSIqujpYDUGtUhY19pEKgsY0kN4R3HFBch7zH8VeOX4dXDALNkTFnzKz/01ylxaZ6+euAcN8NPOWoV7twaZpT7bMrzbYUr1JlKFQDvfl8+KyN/n2GCDF1CmfEG4wUxsfMib5SpKJ78Lqht2cVqsbwVyj/vKaBtgjE2Q4jNfIpDeeuIMUJP6GMKGjdxBq1KoIm4I86m1EWsO2liw4+EtPml1OJ1XXAtxQQTXPPHLErgyGC+oBQ47viYNLFweZzoURZwyidp8NW0a/UJZP2KKoUocZg0ZLtnQGNRNGhCd0MQfgbmghB6Ay2y3vPThYCsiscxltTz9f6fG25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcSKahmXL0QRzkC67Yoge+sUTezwiqqAstUHpaR0F78=;
 b=hTwY56Rbzqoba+RFW+JMnz/h3BiHvtIOsLTWdu07FwpWPGieeBdjtK95kG8iJXx5wnZa+MXcDXscw5iOJfwR6c+VJf1EJq8RgqkV5ry6LZW/DKeJrBuELqUXbxWpjZhvfpGXzQVUxgpVWfHtQy/JmBVfJ3zx+vOht3zOT60D/7A=
Received: from SJ0PR13CA0110.namprd13.prod.outlook.com (2603:10b6:a03:2c5::25)
 by DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 06:56:19 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::30) by SJ0PR13CA0110.outlook.office365.com
 (2603:10b6:a03:2c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 06:56:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:56:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:56:14 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:56:13 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:56:05 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 07/27] drm/amd/display: Expose per-CRTC pstate method in
 connector debugfs
Date: Wed, 25 Nov 2026 14:54:56 +0800
Message-ID: <20261125065631.3889665-8-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: ad37db64-66af-4092-e020-08df4ac134f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|10067099003|11063799006|56012099006|261009223027099003|261021121427099003|261102123227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 22DPDdE/n/KRA17mHq5zeegvgpEVy7Xf290yk90D7Nb7qZHyNCzuo8je5jcqwMhiQyPppMbiBUIeIgr7Rwi9yTyrAwFcz0NMinh3EzOD1ad5og6BLYNbjreJnpv5Ghqisu9ezF/XOxM7pFhIit9iTUJ8r9lHUH86orUMiHNp41QCf66TM/6Fms9xykd/gKWTuvkWwrUIpxFBQIXnGQ2kGetAYAMW6S85MhDekK48t52x+6y2Ubb0dQj8xJ56/q5UcKwfj/0VSo+CaxaWbb3Yommjk8bKMzIwlHcKjZ0/5jNe3h3MSROChpLfSZpDIz3PUrAYuJtzfFzBI2+OBIz8W09NP68BYNebVqwg3kUXcOMkpm85XSTWcLw9/CSu4AZq49qlGVhe19R3JtCH9l/edC85U440LZiXv/q53QCSpfgm7HhG6nOsnII+hGkmU6YQrNTVhucbrmdulxp+akRUCpnXhqCuGgCRD3ctSLyhAonm4/sD/Q9FYFGYu4JIjydS/pHwYgWtUTp1DqybxYaLVMcFrPY836NTN1ApW9rLrNdBxehgM9SWugNAv1+Y+uT7EjHcnQp75kQciyY53EjJxYeJsjXu1jy2cWC+Kguq/b6SreJEJtQ3npLKmJ1Cn42+S0eBBz+qmWFUGfDN5WT7d71gFuqQK1Fm5+iKwpDvpRvPIYycJKBmH24OiMFuIlIFQysMBcZJzA9eqYfYC1FnYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261102123227099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NvWdNEuGsUW/YoeFiIcrknHP2uRP2h9L3p3FSkN2XZuUuP/+7A7vXt8AH5sewnVW8Zdr4q2ikrHac5mW+MApyLl34E4pyn5vTPe/E/yvjlWtPYgoxb4OU6jkVlIuLuTS0QlpqO5NzTy9zdDkR1TXKjXa0sUYuuCW0Hf/paF4oY7ExBC1q0Yr+3F+Rp86ZLmRUBUOMXXlIWD7CWBpzKlkryBqsVSxpGXv/pQZ3iSZH9Sd6nIEovT/CK4R1W5hpARXjmkdOfgAfbHrb9WO2zUyJMZb6rjuqosnPjRL+oumGaALFKuk6r6ePr75EIWyuF3uyf8ODlkSGsGouI4xYyg3oDQ5SAvLgpEf+eeIrnkQDXPftdfos3ahGfs6AV6opJBs0GaoTIoi4i8Oykc1bS+v4B2YcgXqQvyxxYuMVQ8mBNpgoT83NIVfW3dMkHvx33jr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:56:18.6605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad37db64-66af-4092-e020-08df4ac134f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
Other than visualconfirm, which is not always accurate, there is no
reliable way to get the currently used pstate switch method in runtime.

Expand debugfs to output the current pstate switch method per connector.
Resolve the connector's current CRTC stream and report the matching pipe's
p_state_type, or P_STATE_UNKNOWN if inactive.

Cc: George Zhang <george.zhang@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 68356cb8e4de..dc7d5c19eb6c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3739,6 +3739,37 @@ DEFINE_SHOW_ATTRIBUTE(cacp_ace_curve_area);
 DEFINE_SHOW_ATTRIBUTE(ips_status);
 DEFINE_SHOW_ATTRIBUTE(ips_residency);
 
+/* Reports the pstate method of this connector's active CRTC. */
+static int pstate_switch_method_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_dm_connector *connector = to_amdgpu_dm_connector(m->private);
+	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
+	struct dm_crtc_state *crtc_state;
+	struct dc_state *context;
+	unsigned int i;
+	int method = P_STATE_UNKNOWN;
+
+	if (connector->base.state && connector->base.state->crtc) {
+		crtc_state = to_dm_crtc_state(connector->base.state->crtc->state);
+		mutex_lock(&adev->dm.dc_lock);
+		context = adev->dm.dc->current_state;
+		for (i = 0; i < adev->dm.dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+			if (pipe->stream == crtc_state->stream && pipe->plane_state) {
+				method = pipe->p_state_type;
+				break;
+			}
+		}
+		mutex_unlock(&adev->dm.dc_lock);
+	}
+
+	seq_printf(m, "%d\n", method);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pstate_switch_method);
+
 static const struct {
 	char *name;
 	const struct file_operations *fops;
@@ -3907,6 +3938,9 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 	int i;
 	struct dentry *dir = connector->base.debugfs_entry;
 
+	debugfs_create_file("pstate_switch_method", 0444, dir, connector,
+			    &pstate_switch_method_fops);
+
 	if (connector->base.connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
 	    connector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
 		for (i = 0; i < ARRAY_SIZE(dp_debugfs_entries); i++) {
-- 
2.43.0

