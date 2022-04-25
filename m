Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AD7C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 02:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75A410E088;
	Mon, 25 Apr 2022 02:25:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF9B010E088
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 02:25:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBn72WBFDZ9oWUjVNY87ke9t00YwKGaBWaHctI743iK65ZYLnOvPWwS2nLafRqopKmAwe46RRYvFVExxxr2xxbpn8GVewV6cevofA0OMAcxs5D42hNTUh6bopUV1KTYSn2e2QUJHuVkK76rVSNQBBI+MjEKas+EyZTn070SSY+zaLKdIFT19Ons1hSfMCbEHryXjKk4p4zptWWY4W/npxThaU/haKxHa8D2o97KKWVv3iHEximK/gsJ7jLHb018/OC4t46J1et5cSBBMaELkwStcE6tBQVyIY40ikxzNZwt5WpsoCRB6Wl5atDI7PhwtAHhxpywyCyTmOOuP7KwMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qn+7IK17rvZFZcrnoDE7IVpLIonl994WYZjTj1gsPtU=;
 b=Q6ABbp4BUscsdIFGdYKFgHQzVI3JxdoIstSNOBCninjAsTyw/j3vYr8eHhThzsbV8U5UpVSu6bbbtGlJguBeFBRWaH+IeokOjnAIKHhXpQe46pH6qpNz6jQYXOl71N/LrPh+qpEmURK5U1nalAUIkj/O9C/DvACNROhZ/svg7Ssz6zEo1gyLIqcADESDgcRCzXoMhJV831id71MpZAp9jESm3o7MPY1KohnhMboMzlgljen8xPaTZr/RLRBRqtE44zTHG+Y/GN+667En8vE75YisnH5wriCz+jT7IiaZM5Q9vm5kc0q2IUPYOT2gm9wMO4ymZpVNJTMX/fhbiqOM6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn+7IK17rvZFZcrnoDE7IVpLIonl994WYZjTj1gsPtU=;
 b=aSJ1dFaez3Jva9ChqLFwQ63QRaiGyIiVXikVRTJy/DMc0S7WIz24Q3SZGYOXwIXYhICbghn22AqAcNkdSHmAcmr5qla86yYeSu8wFoOuXWjTlRi8xxuuI/3RIIGPeIJpySzNXlHAxDHluPsi8Fysp+Gt5qb9O86LuyHEcN6GsdY=
Received: from MW4PR04CA0186.namprd04.prod.outlook.com (2603:10b6:303:86::11)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Mon, 25 Apr
 2022 02:25:32 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::9c) by MW4PR04CA0186.outlook.office365.com
 (2603:10b6:303:86::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Mon, 25 Apr 2022 02:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 02:25:30 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Apr
 2022 21:25:28 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix the compile warning
Date: Mon, 25 Apr 2022 10:25:08 +0800
Message-ID: <20220425022508.75434-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 408531d7-5235-415f-dbc0-08da2662dea7
X-MS-TrafficTypeDiagnostic: DS7PR12MB6213:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB62130966AC36C7AF3D5A138FE4F89@DS7PR12MB6213.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ll1Bhs5BYUXe6qRip4k6ziftdyifJWCCK5Wor0NW8wymS40s8oy2tAZMmmaFbNX9FHQh7ZI/iE3krqGy85aFANCTIB3j/mre9aAYIUWdUownke+QKO7U2oQs4ZAVgW0ANsJ7M6uzZ+3GMQzkpcnku0HbDJZRZvnWDq5KHhOzHB4WU//8n8eOuF47Fd4yODRF0PklvkvyjYThEOyxbyrVV7tDyEodDd6WksGPd7JgZdBEIpAufENr1sxeqrsqZPrlKpxFKwPdKA0HAAYKrfm/F+MiIAO67CCO/H5nC4y3WcsFvq/J4F5BWwpYOmm3RZcuAw4IC+RnLJ/opBmagC0LwsAsINC7Us7Ccxj8LzA3ZLdMzAScWLLTnwfu+arkNbq0mRh+AZzNQekMAmY9yNI5O3LwNac8aaOifNZ9PJxVHNnU8TMZ19J4C8V8QI0Vr/FBwvkPbVSnhCiZltVPt+Ma5+oFlBP3q2xBcxpL3gMQpY57F2qGiIcwMbkjl4iYbH9LEQNYR7hGe3PORopGGBgqan8svkB1pz9jrouTGI2SuH6g+5hWm6iNp92AOI/0tmlLDkvnpJim+1c7lSzZs2RU2cXFbaLN+9vr95j55lbVE4xT2f+82ShXaaDZEDMJOjLxSvhFB9rMsgADrre+/1kDJ2/+iDj+B62lM27E2o84/tQ9vGQ5Hu2oDu2xbNHm/xj69X3S2ox3IlPSwy9ixOpxBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(83380400001)(70206006)(2906002)(508600001)(36860700001)(26005)(186003)(16526019)(70586007)(44832011)(40460700003)(4326008)(8676002)(81166007)(356005)(82310400005)(36756003)(2616005)(1076003)(5660300002)(54906003)(7696005)(8936002)(6916009)(47076005)(426003)(336012)(316002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 02:25:30.8664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 408531d7-5235-415f-dbc0-08da2662dea7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the compile warning below:
drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/kv_dpm.c:1641
kv_get_acp_boot_level() warn: always true condition '(table->entries[i]->clk >= 0) => (0-u32max >= 0)'

Reported-by: kernel test robot <lkp@intel.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: If4985252017023d6711b4d7eb1192a397baff813
---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 8b23cc9f098a..cab948118d4b 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -1623,6 +1623,7 @@ static int kv_update_samu_dpm(struct amdgpu_device *adev, bool gate)
 
 static u8 kv_get_acp_boot_level(struct amdgpu_device *adev)
 {
+#if 0
 	u8 i;
 	struct amdgpu_clock_voltage_dependency_table *table =
 		&adev->pm.dpm.dyn_state.acp_clock_voltage_dependency_table;
@@ -1636,6 +1637,8 @@ static u8 kv_get_acp_boot_level(struct amdgpu_device *adev)
 		i = table->count - 1;
 
 	return i;
+#endif
+	return 0;
 }
 
 static void kv_update_acp_boot_level(struct amdgpu_device *adev)
-- 
2.29.0

