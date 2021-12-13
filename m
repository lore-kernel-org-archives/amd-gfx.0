Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A196EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 14:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2741310E771;
	Mon, 13 Dec 2021 14:51:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62AC010E771
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 14:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiQt8sTX1yJlk+JOIxmJxmjrAqfG8RcnlcRoJIPjZffAGBMm9drQpMen8uPwfxLWXzfeEWrJqefS4FemFEOEROkS9rAaJQGEji7Jezrrid1gCjjA6RwfTjx//wr7NtAXjESNkokRsWcQQJduZDsF/Y4fvIc/sO/gxCBPJAO2SqS60KBhaGwsAAHqa4aulQhmnnqbcwb+swItPP0ONaL5GPv0tmTM1khxBi1o1E2uyGy3KvKSj3bLCF5q0edisRYDz+//SzA3GrRqCqmd9EE84bJ2fxaThFPu9TxQavHsr4gBTFobabkmhijpISJJdqdaMrd5wIbCX8eASosJUl+Vlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjSydXsJnby840fZ6+HMICYWOr/SbG9Ayb4Ub8O1rkQ=;
 b=Ow+f9AztFZQSAlhMb6DUIEzDaevcp1of3tl9F9oyA/gceKpvbXnvMi1Hzw0L0uQPUDy4VkH/G6y0O1dZKSjOuWib/qOBPsy/TY00/qa0UBMUIDoLw8tMdywKnb0ab513+A4Yrkx+/3aR+B6yyIaYfQ9gsvvfl4I8XxOIsfOiuLGlYTzlYmt7pB6ROmZq6K3KX9vwRPoTQerDugBOoiePFRyUsjl9Z/kSCUJ8ovPFKhjif8lTVD9lOmNx3ThVCuWJyNOiSMDsprlNCcR8Psub+38Sff0iXHv+cfeQ9YggyzxqcodvEkS1eOBBrzTyAj7DYa8C/eiX3xijnRk3XAXMzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjSydXsJnby840fZ6+HMICYWOr/SbG9Ayb4Ub8O1rkQ=;
 b=ftBvQFRoR6LhbDfQV07bXRuVW0M6M/6mwRy5GTt24hC2GtZryPO3CiOzo2xyBATumGbZmJWVZhSoutI+kWLueyRsrCc2kA/+jI/MoQ4rPTsTgFE0kCjNfycr8HY/tvb4FnKGzsIunD8IzkC9W8lIw1NJnBYmaymTym4Ih4D6USc=
Received: from DM6PR06CA0027.namprd06.prod.outlook.com (2603:10b6:5:120::40)
 by BYAPR12MB3240.namprd12.prod.outlook.com (2603:10b6:a03:136::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 14:51:12 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::44) by DM6PR06CA0027.outlook.office365.com
 (2603:10b6:5:120::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Mon, 13 Dec 2021 14:51:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 14:51:11 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 08:51:11 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 06:51:11 -0800
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 13 Dec 2021 08:51:10 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Guard debug option for dp_force_sst_set
Date: Mon, 13 Dec 2021 09:51:10 -0500
Message-ID: <20211213145110.910626-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2821f6a-46e7-4530-bcf0-08d9be48015d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3240:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3240539C76D2B4BE389B71668B749@BYAPR12MB3240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3L7xLRzsUXWHvyxNjqsAdU17QJ1+yO5aW4uRhnaFClWQak7t7H/xw7dY6kpp/3ZXiNwdoxbbyrG6vZpWJnLMdSsX++L+ZMW3V+oPg3rHig4Zb7/CqTuufpIXVUGZJc5FXDdryIypAZ73S5yo6pDUDOhu9FceA74jzGQ1HV56jliHCaXUC738M2aFWpeLDQG6bXEe3XWUC0601aAFywB1uurepCU34eIJYvI3nLPNehtt500d5cJ6odkbz/rNq74zgV5ky3Gx5PZzhdigfezLinPZT+uqAnOk+LCLR4O6pzZDdDRxEhqpXybhvyHL+EFLvwGtAukpOJ7cr4kPhuqV++oN4uDJTk5njcyxsMFQXRb/iw8/jBMgqZq/viPa4RjFDIPNsMW7pxe34Hpai1T2eZb5iN9iO7+bBf2l0VOTJkRjT58XYTLgYUeD3df56/IsNGGZ18r9DjoctARUJzPOCaoIck/UC1LQaQvqaEVTY/CRVp9EVUGJkvqpRxMWLHgxnp3vRlXcyr6eIVXYfYeeIg3XLV+wHqcAfS68QJGAnnrFSCk/ZQm4q3aWksKJC3hwzmcfLo8KdiLAExuk31PRpCslh1CJNSr4tZUVZPq5KQq8sqSYjEpUQm1CxsTakOUSttGlvZ07dCB6qg3RnSFkgUiEe2d5IO2sLCPtaSuoJuBt6cwE5eOYJlCud48nH18vFpQoI78MN8I2f4sGcJK0u5o+VT62K61PRQ3Hif2bnXYzGwZ9Zzlq9UifmZP/WE9f+ywUuAPymypkR16gCmYxpi9OZHvt1TBMTxl0yVjRPLYe/6xDjwNBxuzWszBCHaOd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(356005)(426003)(83380400001)(316002)(508600001)(70586007)(36860700001)(70206006)(5660300002)(44832011)(36756003)(4326008)(54906003)(1076003)(2616005)(82310400004)(8936002)(8676002)(47076005)(6916009)(86362001)(40460700001)(26005)(336012)(2906002)(186003)(81166007)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:51:11.8697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2821f6a-46e7-4530-bcf0-08d9be48015d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3240
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
Cc: alexander.deucher@amd.com, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Debug option for forcing SST mode when using MST capable receivers is
guarded under the config option CONFIG_DRM_AMD_DC_DCN. Hence the corresponding
code exposing it in debugfs must be guarded as well, to prevent compile errors
for non DCN builds.

Fixes: ad9601f00 (drm/amd/display: Add Debugfs Entry to Force in SST Sequence)
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 1779c7daaf72..fae3c74a2885 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3237,6 +3237,7 @@ static int disable_hpd_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
 			 disable_hpd_set, "%llu\n");
 
+#ifdef CONFIG_DRM_AMD_DC_DCN
 /*
  * Force sst sequence in mst capable receiver.
  * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dp_set_mst_en_for_sst
@@ -3260,6 +3261,7 @@ static int dp_force_sst_get(void *data, u64 *val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(dp_set_mst_en_for_sst_ops, dp_force_sst_get,
 			 dp_force_sst_set, "%llu\n");
+#endif
 
 /*
  * Sets the DC visual confirm debug option from the given string.
@@ -3370,9 +3372,10 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 			    adev, &mst_topo_fops);
 	debugfs_create_file("amdgpu_dm_dtn_log", 0644, root, adev,
 			    &dtn_log_fops);
+#ifdef CONFIG_DRM_AMD_DC_DCN
 	debugfs_create_file("amdgpu_dm_dp_set_mst_en_for_sst", 0644, root, adev,
 				&dp_set_mst_en_for_sst_ops);
-
+#endif
 	debugfs_create_file_unsafe("amdgpu_dm_visual_confirm", 0644, root, adev,
 				   &visual_confirm_fops);
 
-- 
2.30.2

