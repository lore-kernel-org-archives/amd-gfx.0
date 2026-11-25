Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772F2606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gLMMVdQV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1583B10F636;
	Wed, 25 Nov 2026 06:57:44 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D535B10F643
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:57:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9l0OcsFzvLoox5xiLPpMJRTUB72rXbLpP6r7AP/9KKMa6vV1xRrlqMzah5PczSwHa3QBzvL9Wak3wOTBjPHbr3hM7t/NWMuXckRp1y3U6dk19Sx3k4QCW5IVn3bAGIzSg3kP1/C52sh4yOx+aJNrMEqqCllPsiN75ZSNNbaP4iYSNLQcnNwX42CcGnEupq5nuOiDhZSiUWqj3kv86CNvrcMyaDrfRqAktNJ3qriztnn750MdCmv2sIza1YPtsbejBl+Vn09K7tYjUii8Qledi2VdLIQQjpmiJSN+JaGRiQ2zcW/SyZc6GNxiLvajwUcTGFfr9um18BApq8iXZ6EQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/vf/6Gnfqe8EneLpyj67hFzzo/VfVbJ/YQA+cpdaTE=;
 b=wrX4ZN7BN3WY/YWcs3FPLG3JLP4qnrZcCV2qMq8Z1qBBsl9cyr5DJifGLh3nw/T/XHRVGaNKnNu46VeYElyT177uyZ49Yo8zkYh+StoDHmHW9/mLv+M5DhOwFqD9jbanFOKByLGGP27FSBIMBuma4AOnxPoY0Dr+RLy+tQ42lXHfuPW4lnReDnlOcoZlW5HJBTk/11PTaCVOD+/Dmvd4rNfhlsLAN6dLcKYlCleZ6xAw8y0oLCzT/ToEql85buc97rBZHrVZRQdpojGlJSgH8NtMzMGukNV+Wwp+5pbUoQHj/L4VtayYgxEuHJ+wzoAVBXO6QjSNn8sYPQuvLq7edw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/vf/6Gnfqe8EneLpyj67hFzzo/VfVbJ/YQA+cpdaTE=;
 b=gLMMVdQVNlMD5DMeoP73xeurJRrM8ntN591lj9iWwgUcMOxPvm1HZdzwwmiCsEvlh8yD/Ewg86O97GAzLfslp+lt54A9WX4tDSXZgdQD7ruZcWxiLAx25fEnemk+0MZC3S6p/wL/xTsmZ4+JYEh8tWL8eyXKn06NghWPDk/AMXA=
Received: from PH8PR07CA0008.namprd07.prod.outlook.com (2603:10b6:510:2cd::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 06:57:33 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:510:2cd:cafe::aa) by PH8PR07CA0008.outlook.office365.com
 (2603:10b6:510:2cd::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 06:57:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:57:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:57:31 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:57:31 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:57:18 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, James Lin <pinglei.lin@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 15/27] drm/amd/display: Guard connector I2C transfer without
 DDC pin
Date: Wed, 25 Nov 2026 14:55:04 +0800
Message-ID: <20261125065631.3889665-16-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c8f292-f8e4-46f8-b00b-08df4ac16102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|22082099003|261009223027099003|261021121427099003|261021123027099003|261102123227099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: fgWtQSm0objmvKVhVVlFf+fyENPqIobw593cVHZn3RP2qvt3qaBmaV0TxnvXzLjkyPCtGjlcVj+rFPuSi1wX7ut1hq4C8EXuBM7hZC/pHc/GSMw5+egPOTXfb/DqlIavwNt8DzTTGHI/ciYpquPnJ+y/eS5SeB3CuzE1CvGBgI4H5wPgAXQwzOgxnvcPzbtWC0L+ScHb3gHd/oePDdYgukcq352x5e+/gNespU77H4QYAoKkFlzK9U+BI9B+FFK+Cl7CxHzARAZk2q0sFdR2g15EULaYakcGZWa48zWbDByQNjx6cu+BBDjt45fbC7+CuU7aXOBg4O43kjfjUnPbHqD9bRt2B1L1u6iMUI0jmCA2bxiCDaoil98Z/IKvIt2mJcodeDu2Kg+5TIpZI5miFEGfFuvl4jUnZNgcogFjQlZZcB6I/0Enc5yMDhkizx9j9iHz310d8qZ8f5UP3qKniwQXTp5j/AcvPMWUM81aO5BLxV8/wwrDHOUK6SmCVYu+ZxlAeC3Q98U40AY1HeEfHt9Day4fbSUEFMVxhvJ7uH/ECM/aQ19rQg4UmiPdyMKAh7zlj5HG4q8bM65ard2Zofk3WfmoM3nyaAi4zo63wFtQi5Xkb4JlZMMEki2Hj2ahQviqhdZ2keHS6cLdEjFpMAM//vK7WbpeA862Mrr7OWXk1uc5bBZ/p9GfeQ+FWIYZYTpagK4xW4ib9L5P/Dc5Tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(261009223027099003)(261021121427099003)(261021123027099003)(261102123227099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jG/wziLvKd2GOu4G7FDWw/IzHuj5wXkT3GAuEejRCKLPtLlvp2WEQABKds/i/9u9q+T4Riw75VunbMYEc+REBYKnKcSkvChvEMl7Q66w/Byfc7tKgKGlxw44rVxe4eOF3EA0pqnxej7uoC0/ujmgfrhk8Os1A5yP9mNaqeKUixrA/I3whekfKnAc0Bcr3fuOPU7BVxPo7TMO3eIErNVF37MEzcaF7DCgHBElRHFQbzgkTrCAaE5ozsgHsarUVXt3Aq/FANIjumEYdiIKDyHam7hI3jR1VncvhxbocCwM6YIwHpKVmfYgpVpv1rTBhgg4RYsFY36TlYzohQMoq3WaFtPKWvACwd0d0kuFHAKi0PSRMNdFYLd0IoD5WzVbYnnUfKQywHWUUF2fNt6aRMIeQzhRTbWOoE07H5GiTDGZNTIQv58bUS3hSzOAKVmi1SFY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:57:32.5362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c8f292-f8e4-46f8-b00b-08df4ac16102
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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

From: James Lin <pinglei.lin@amd.com>

[Why]
amdgpu_dm_i2c_xfer() checks for a missing DDC pin only after
considering the native DP AUX transfer path. A connector without
a DDC pin can therefore reach that path before the check.

[How]
Move the DDC pin check to the beginning of amdgpu_dm_i2c_xfer()
and return -EIO before selecting an I2C transfer path.

Cc: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 41fc641b1b60..1acc2b44c968 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3442,6 +3442,9 @@ STATIC_IFN_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i;
 	int result = -EIO;
 
+	if (!ddc_service->ddc_pin)
+		return result;
+
 	if (!i2c->oem) {
 		struct dc_link *link = ddc_service->link;
 		struct amdgpu_dm_connector *aconnector = link->priv;
@@ -3458,9 +3461,6 @@ STATIC_IFN_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 			return i2c_transfer(&aconnector->dm_dp_aux.aux.ddc, msgs, num);
 	}
 
-	if (!ddc_service->ddc_pin)
-		return result;
-
 	cmd.payloads = kzalloc_objs(struct i2c_payload, num);
 
 	if (!cmd.payloads)
-- 
2.43.0

