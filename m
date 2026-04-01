Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F01610F6FDC
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 16:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABDD710ED0A;
	Wed,  1 Apr 2026 16:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j5trTI0A";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010002.outbound.protection.outlook.com
 [40.93.198.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE06B10ED0A
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 16:37:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L53OjFpmlgLAvGty6mPckkfJxe95nJLyEfWPSVCqOSl3jktWK84OxDk6KyaID6G8W/ZgCj7avL8kN/w6Q+ArbuiiJd0nNaDOlpX1CpHcJcZw6ubTYkel8RJR1dIQQ/9w2eSXMFl++cmj6wxTZciJBqCl950ER1ETebDTb3imBWF/4Yp7CQBxTMA5YOB0lVzZIw36OW9CGy+yQwNQDoVeV5J24LZ3mgPOF/aTZ7lM/LZAsn2UhG06kKaGKmBBL8er0t2IqLOn11A7/700c5ChzYoYg9jUeqGitDQsX3Kknep99/HYvlI6nR0GjqAV3+pKNnInOsJ+k11eDrXTjsJasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrRiWDkcLA5jVz87kjbm1k2OCm7slw0uz7rtYheuknU=;
 b=QZOrzDHi8VpdAwjnZj1YIXyjX/THGCxr+7kdNOL0JncESf7352xKhgKLjgi+LST7/IEnoQGFZWn0xp5qvYp1GHtejoR9XBR8iUZFQete2k8xB9twmJqznas85tLoz70Klkl4teWq7UAg00ewvFwLYI9zhq4bycj3BGtUWFWKQ2MSDYovjZPFhSXOLCgjU+po7BIVrurQK9CsUudJOKdjNk1dbXx/pLGQJ4DeSNbZgyD3T8bW81s4d86ogeFhsdutjXzUm31IzVpAzW6WvDJ6Q+uFJ5bSR8p3uZtO7eu7WHCmXyjYR0OL05piT+6BXVPA4roOuuHFwpYaTl6ur0RLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrRiWDkcLA5jVz87kjbm1k2OCm7slw0uz7rtYheuknU=;
 b=j5trTI0A6awdgwFh70FUsNDKaSfqi++l0ReW3Im55/UDX62EinY+yW8R7vSCcT2Ij3YNf9MSEdcG/EtKu5UCgCjwr46Fy/Nl5l4jDMh/inlgEwyuppKrnhYFUGdBhG0pilpO8Cs1oouT/0MorIkzH4YaNf3blPytuGbpR9N1X5A=
Received: from BN9PR03CA0318.namprd03.prod.outlook.com (2603:10b6:408:112::23)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Wed, 1 Apr 2026 16:37:47 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::a2) by BN9PR03CA0318.outlook.office365.com
 (2603:10b6:408:112::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 16:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 16:37:46 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 11:37:44 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Restrict NPM data to primary socket for
 smu_v15_0_8
Date: Thu, 2 Apr 2026 00:37:26 +0800
Message-ID: <20260401163726.3811578-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c63d9a-ba4d-436e-3045-08de900d019d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CaMtU77VWwgl3J79X/OGhbQEb6gx4r0S7ovdU9jBztpMc5o2EJ/6EANkQ4I4ckYjg4VOsI1cSK4qkZ4B4P3LRjBEz4frUQtRDiSdjhw7phP0AXkHfT1HZ9puMkHVzcoljo5YXbitTL3NnX3Vuo4Vll/4n0T5gnyJawumz7hw9EK6wFB8CaU/CFGwoWyu3zuQlsbyHRrfv+thTyOWw1LSTtST+pxrFvZPcOW/FvxBmc/4NNBdSciRyJhDo/60VzbGdTct9EzyJsR4ar5V+af5xhFhRJyMDDdUJgpX6AYZjgjAwxMggedcQqPPrw91uaPxcUqDFpshgsz8RUMPG/b6h99UJc9OY8RAlr8U2MvJbAAbwrtnZ0fUGv1ZxLrWEfE8Jsk7Bvd/elwOuRsbEUUNGArResyeiEWL0NbH9tPaj2UQUIsvjXJkwjDAK1m+bBg5mLh8QCmOVUpqZeMP5rZTfkRF1eR+x+P7fRzpENcGLTOr2DdWAtckAeAfpVCQs3cH2orOPclqBSb43REm20pneq1xTEFHqLthYz/W+zttu6LOgeC/KPhGaIaoslMLB36mZEuSpm0L4Rcrq+1MQyGQoDGk6cr0ooE4hoX6CkOxc0MqVbEZm4zJf3sGhQeucIqQoVzU/r7F2LFrW+41teGFnkoG6Je3p+uj/tPVtVOdrzObchBJchtse7TkAGowxouCHyFvq+q3fRxX6r1FOh+Lq2HkKbUmhJ+mpGk62ar0yCM6tor/KS4JdKpj9SJSVZW0027HoIXe07/tvelIYIITsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4w1HdilG+j0pz1OtrjKtZtBg8gjO8aG6z7qUSuuypgikZnoUF5scXm0tmAS18O907sXdQr4QY8DZKdAfmyz8sR7HSFf93WIOAO2BWx3/Ns5v4bjHa+/fPUcFYTFS42+rqUYY19wjrkZ22EkOlWQ6IM8YvSAmoW76iLPM9d/Qx31oyd8Y2v1JtzpBFaPm51V/Ef/jdBuSmxwRHSjjQ+7jG53kLMh8pkSMeUs7OoLUXmQ7hU37zPEtkG/xDJCboGdWpOt5dCaBvvff6s673S0V+7G3+8aOUir3ycoHZPc75uRPOMLLj1eCt8lMfTiTWplFt2hKT5ppkWo6MjVdimS6QpKAgFteZDs20Icg5uJ4jraUXT5JTaSYcXuoHuIqTuUYfxamv1NmyxkhJpQhrXmMaB17eo6evb2NLiyWUws8b+3aGR9fE9l5TCvPriHEWBOe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 16:37:46.8851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c63d9a-ba4d-436e-3045-08de900d019d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
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

NPM data is only defined for primary socket. On secondary nodes, return
-EOPNOTSUPP instead of continuing, thereby exposing npm node
only for master socket.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 756cf4ac00fa..b0faf57b0655 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -578,6 +578,9 @@ static int smu_v15_0_8_get_npm_data(struct smu_context *smu,
 	struct smu_table *sys_table;
 	int ret;
 
+	if (smu->adev->gmc.xgmi.physical_node_id != 0)
+		return -EOPNOTSUPP;
+
 	if (sensor == AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT) {
 		/*TBD as of now put 0 */
 		*value = 0;
-- 
2.46.0

