Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD107CD1284
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 10:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E1410F4EE;
	Tue,  2 Apr 2024 10:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nAXDAUbS";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 074A110F4EE
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 10:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuV+k+D/u/cjnRNDbQo4WjAtyUpmOEO7q9rPPj6e5pAdAiJ2KCdoOpfCWVQ57t6vkkoWznWFbfAk+rwWqe9YIoYKhR0WjJyxxRVlRzyvT4ZgGtAlW8lO7ZL2gQZGJfHs+RDtG6WNLMivPrp+2M668tqBxKRq5cDX/XWw2TZjpHnlt4Ig+yn53aieRvwYBTBzhnfcwM15/x/KEN3VMnGLpCIWlYdRsIqR1zvVdUYM4U5SPeFFd5qAw1yliC/xF/QglxbG4BOF/gCH8zgn1eGVRQzEHK1o3R1TkCUw7icOgbiM+p/okXAszTxXHveUYjHR7c1BykyzWB6zQBx/15DMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm8ydX/RRsiNSOgzYrqeO2zgZZoATLMlnPJZbQ7G4ks=;
 b=c4P3VgTX1iXLyBo6CkXmNMP86SgoXBVEoE5t26I1zhFpZ1TyVUa0CwU5cokCzHMKaRT7JnofU4mnWl0ivPOdfXQaQ+Fygcfmhxb/WJCsM6lsv4pbDq9CTZs/QrMOupVZoXAw1dg6ABvFZ34s+hNSpIkgJ1omZklcD9HIa/1w8lgrRIkkhapak1Et6YkWsBXQeF2i/CjlGqE7t3pc5cupgdQZ16RCuTIGnd9oFV9crmxJ3yLOPy8VO9o3fDruamKEuXUI6pcUbFOP4QNpm2+jtOm4+mMRR5tdash0GIaEYgKr8O5dyoqCZWKLHoPAwzrNbbJBrSXBblajRe6W2MtTXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm8ydX/RRsiNSOgzYrqeO2zgZZoATLMlnPJZbQ7G4ks=;
 b=nAXDAUbSkprBo0B/z2B8FupNPN3opjpLTSv5jEPJSLhc28VKOF+ZPZ8HDZeXHcigX1cw3Z1AXXAKe1g4C4cXuEbETzDwYe8Ufbw2H9VGbzKm2jzb/Qs1dRSWMId4KY75FVRTgfxtwLjiAS2QomRaBnQGdzhZtwW8vGSkGpDIaQ0=
Received: from BLAPR03CA0121.namprd03.prod.outlook.com (2603:10b6:208:32e::6)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:23:04 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::2b) by BLAPR03CA0121.outlook.office365.com
 (2603:10b6:208:32e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 10:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 10:23:04 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Apr
 2024 05:22:59 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>, <charis.poag@amd.com>,
 <Shuzhou.Liu@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Update uclk/sclk limit report format
Date: Tue, 2 Apr 2024 18:22:44 +0800
Message-ID: <20240402102244.3374108-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240402102244.3374108-1-asad.kamal@amd.com>
References: <20240402102244.3374108-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ecb7d2-8d88-49d5-309c-08dc52fee1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjgOfPqiZ5fSgVtn2LGH/JF3r+W3mzU5KhVkgXuhITtVe1DY8i4MjAsnX8HeV+k/ReYgZbZTQMDl2DiSh618AeHTSAbfcDc71lluyGQCnDyre2hx90A0tzXG2cjcqg0bcPTgDp9GAIx24m9wWomDBwVmKpFZa0bIg8Q6y+bkTGCOEyLq85VGMEQnFeCbItTzCS0YA0vAvqeHIn0z9QCgkkCsdyKkD/18J3XX5/sGo0v9KzQDM/fiFX0kE3yFuF6Auf70itOt6B7QQloWgF8bAzFTGJq51ZfGNH50O3utiAy4QO8IBQXOgHE3e6C6bP6acyKmQMLLiya//6y26bAnsHjL7FROLYsYwyx5NybFUpphFIpNOYXh8Ffw9QlhsZMhB5tAUHu0eRZ8WE6A/s4+iyFVeSi5mdzRQhAYCKgXko4iY8rkucKRqQ25G1KDDENYmGpP4G0S87nsUolONWdAEodqur/USZCWo1x7w8l6UwoVZHsd5Tyn+yz/k7gybVYkHovPCMy9X7k3XJta4pZKdtgv4KNVhK7j7yj8tIKFmcUeZtQcGyDK2Mtbi3JmYjEm4WdHukhrJQ0cc0hm2eep7HaaT/KVpLKjPFGQoVrb5xnH9YZW2MwhGOnyJdSdKVPPYzxC2Jhj8ZfR8DalQ9J6svAS61ny9ibKKWDNENGVYhIj7ap4f3IGjmbdoh913W6Pqql7oHNLmzLjP1aZiSVEPPgCcsGfoc9c2oMpAMipz54LbVsx6MKcijFV2juH4HOi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:23:04.4585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ecb7d2-8d88-49d5-309c-08dc52fee1e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255
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

Update max set uclk and sclk reporting format for smu_v_13_0_0

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index f4b31b86e2a4..6f0d7602d2a8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -759,8 +759,11 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 	switch (type) {
 
 	case SMU_OD_SCLK:
-		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "GFXCLK");
-		fallthrough;
+		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "OD_SCLK");
+		*offset += sysfs_emit_at(buf, *offset, "0: %uMhz\n1: %uMhz\n",
+				      pstate_table->gfxclk_pstate.curr.min,
+				      pstate_table->gfxclk_pstate.curr.max);
+		return 0;
 	case SMU_SCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &cur_value);
 		if (ret) {
@@ -788,8 +791,11 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_OD_MCLK:
-		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "MCLK");
-		fallthrough;
+		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "OD_MCLK");
+		*offset += sysfs_emit_at(buf, *offset, "0: %uMhz\n1: %uMhz\n",
+				      pstate_table->uclk_pstate.curr.min,
+				      pstate_table->uclk_pstate.curr.max);
+		return 0;
 	case SMU_MCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_UCLK, &cur_value);
 		if (ret) {
@@ -850,7 +856,6 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 	}
 
 	switch (type) {
-	case SMU_OD_SCLK:
 	case SMU_SCLK:
 		for (i = 0; i < display_levels; i++) {
 			clock_mhz = freq_values[i];
@@ -863,7 +868,6 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 		}
 		break;
 
-	case SMU_OD_MCLK:
 	case SMU_MCLK:
 	case SMU_SOCCLK:
 	case SMU_FCLK:
-- 
2.42.0

