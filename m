Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5370CC77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 07:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9A5510EDB0;
	Fri, 21 Apr 2023 07:30:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12D210EDB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 07:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrRdjvIpF4gk81xkeXdHb00NprrqJzv7BB2OQo9pHmqVJvyvJV/vfh1UOLTOVcYOLknck8MU9gXnEaH3vP3nFHZLYc1pzbqUB+dw4qKnv2jyqdQOnvZo7RZcnnMh7BiXKQ9nlJaxnRg792rImfBXrP3loi+dN5GslUPPhlRt+claAVqFO2j0SvMQjmaKEPk5k3cshmkVx16KCdocOHoXW6ZSZ8URcNweyjySF5xlVhWDcWUiRGmZcn9WSTKXPSyTMGjiK9mGwF2iZs1TPctZ9Hp2lJmcSBA0Td77od9T60MTAbmEURtyBWdjNySD14wbs+hj9ZaNflBj6ZR7DbN4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6Ee/dxY9zrfxpd5VRRoVSKEtpq22PNxgoiXFiptTLg=;
 b=A6cn/7QkpSGH398lWIeb1iLFUqLElKFWOHx+GH9DseVQ7pCvEqA/09l29fVyNeDe47uGrshC4WbG+WDzfLUeOynfphnlSfD+//6oK5YqAkp9lHLrg+2etP2d0zA1DWSLKL9IAvuiCPqCjPnu5WHcCbcwej2r5k4XvChX+fD3BHcCruftVuSL0PXb+4xf6RwDVIYNXDc6yIbp/82sPHwl30yQ2tszvgdb8SnK4e6YwHDPTP/rArTpiLaWQfUH/vs70GEqnX/G3sOF1xMfWDp41HxgvkYJy3YcN5bZkmUh7985UsyilyOwgGLYk/OfurPhUxVjwTRoY+vNapYyppyMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6Ee/dxY9zrfxpd5VRRoVSKEtpq22PNxgoiXFiptTLg=;
 b=1mYKQekPEO4FyGcyemh5vG3fUTYQEwqBvbxt8POigYJkS149QzNt7CYd1tcPoE+Mj/gcQgcM2jaz2HeUoXX9Z5zsb55TdVaMt510Y6EBZToGRMQvstTjoHT95RQ/WKMr15ptwUBlI0lB7V4eU6oC6P3ReEPPhdooZxM+CNakexw=
Received: from MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::22)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 07:30:37 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::b7) by MW4P223CA0017.outlook.office365.com
 (2603:10b6:303:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.27 via Frontend
 Transport; Fri, 21 Apr 2023 07:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.23 via Frontend Transport; Fri, 21 Apr 2023 07:30:36 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 21 Apr
 2023 02:30:34 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: conditionally disable pcie lane switching for
 some sienna_cichlid SKUs
Date: Fri, 21 Apr 2023 15:28:35 +0800
Message-ID: <20230421072835.842112-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: c621e87d-c395-4cc1-93b8-08db423a4ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3JPpIYNjYS1WhmdE3m8NsB10xfrKGLBMQ3O9n21rv25dYEeye4uv+EWe/PwIzVa2y7fPYdOWpta+zuUcDQngNvAvH8u+mNBheGkZ7zgHhW2su81JlBfy6jyIZabN3WXBkp+R8yKF9o6zq5lIk7JWq3AYSB1ejKG9yJhg0cXO3QrFDLQdWmsxnn3GOMlB7saAdQ2bGMGb9vAWz+WohrmVMgzAWU6XVyclU9Y2tfLzNc2vBaitDfIovc1/oZ5qKt9Y6ynVk4Zgrbz/miA7JbkGYPUU+uOyYGB3IqlOc+kYy8SFoyPM5wx3TO+xfkhpLLFgenz9FZljxfBS8I1ImVEzIaV3xmwkB2QifPe2SE2D0a6eLv/la9JPuoNDbLrUd8nMMxqGROP6Ed12YA/OkzzorFVxWkxzM+4LsxNV70+TuvAC51WaeCCfYtQ0/VD705EXKPVlOXzu5n6wcyrVzIhZAPoX+FpYmohO3MHmcD5lhcETHD6yMU6eFlZ6YKUJzdZYP9lW7OV/x7j6iQL1FK9yR/64NQcymc3nibckBtdqVXhzWKb8bBseofcPCyZ+E6m1BaUMMRe8CvddjmZDXmFBTSrkHs+qMpySzeH1RDsAsehXr6aHbR/8GxJT9voyYSW/S/P9ONA9ZoSgbFUDVpvjaLUnZRTsjBdqprDQ7005VsrNdJAcJtNhDYxWilZsSOJ6cEXAzAvhOGO1XJc4WNxlyBK6ye9rCVnoiCNreAwj3A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(82310400005)(1076003)(6916009)(316002)(26005)(186003)(16526019)(36860700001)(47076005)(336012)(2616005)(83380400001)(41300700001)(426003)(478600001)(4326008)(40460700003)(54906003)(82740400003)(356005)(70206006)(7696005)(70586007)(81166007)(86362001)(36756003)(44832011)(8936002)(8676002)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 07:30:36.7513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c621e87d-c395-4cc1-93b8-08db423a4ced
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Mario.Limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disable the pcie lane switching for some sienna_cichlid SKUs since it
might not work well on some platforms.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Iea9ceaa146c8706768ee077c10e5d33bce9bc1c2
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 92 +++++++++++++++----
 1 file changed, 74 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 4b91cdc3eaa0..e7223513e384 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2067,33 +2067,94 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 	return ret;
 }
 
+static void sienna_cichlid_get_override_pcie_settings(struct smu_context *smu,
+						      uint32_t *gen_speed_override,
+						      uint32_t *lane_width_override)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	*gen_speed_override = 0xff;
+	*lane_width_override = 0xff;
+
+	switch (adev->pdev->device) {
+	case 0x73A0:
+	case 0x73A1:
+	case 0x73A2:
+	case 0x73A3:
+	case 0x73AB:
+	case 0x73AE:
+		/* Bit 7:0: PCIE lane width, 1 to 7 corresponds is x1 to x32 */
+		*lane_width_override = 6;
+		break;
+	case 0x73E0:
+	case 0x73E1:
+	case 0x73E3:
+		*lane_width_override = 4;
+		break;
+	case 0x7420:
+	case 0x7421:
+	case 0x7422:
+	case 0x7423:
+	case 0x7424:
+		*lane_width_override = 3;
+		break;
+	default:
+		break;
+	}
+}
+
+#define MAX(a, b)	((a) > (b) ? (a) : (b))
+
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					 uint32_t pcie_gen_cap,
 					 uint32_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-
-	uint32_t smu_pcie_arg;
+	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
+	uint32_t gen_speed_override, lane_width_override;
 	uint8_t *table_member1, *table_member2;
+	uint32_t min_gen_speed, max_gen_speed;
+	uint32_t min_lane_width, max_lane_width;
+	uint32_t smu_pcie_arg;
 	int ret, i;
 
 	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
 	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
 
-	/* lclk dpm table setup */
-	for (i = 0; i < MAX_PCIE_CONF; i++) {
-		dpm_context->dpm_tables.pcie_table.pcie_gen[i] = table_member1[i];
-		dpm_context->dpm_tables.pcie_table.pcie_lane[i] = table_member2[i];
+	sienna_cichlid_get_override_pcie_settings(smu,
+						  &gen_speed_override,
+						  &lane_width_override);
+
+	/* PCIE gen speed override */
+	if (gen_speed_override != 0xff) {
+		min_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
+		max_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
+	} else {
+		min_gen_speed = MAX(0, table_member1[0]);
+		max_gen_speed = MIN(pcie_gen_cap, table_member1[1]);
+		min_gen_speed = min_gen_speed > max_gen_speed ?
+				max_gen_speed : min_gen_speed;
 	}
+	pcie_table->pcie_gen[0] = min_gen_speed;
+	pcie_table->pcie_gen[1] = max_gen_speed;
+
+	/* PCIE lane width override */
+	if (lane_width_override != 0xff) {
+		min_lane_width = MIN(pcie_width_cap, lane_width_override);
+		max_lane_width = MIN(pcie_width_cap, lane_width_override);
+	} else {
+		min_lane_width = MAX(1, table_member2[0]);
+		max_lane_width = MIN(pcie_width_cap, table_member2[1]);
+		min_lane_width = min_lane_width > max_lane_width ?
+				 max_lane_width : min_lane_width;
+	}
+	pcie_table->pcie_lane[0] = min_lane_width;
+	pcie_table->pcie_lane[1] = max_lane_width;
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
-		smu_pcie_arg = (i << 16) |
-			((table_member1[i] <= pcie_gen_cap) ?
-			 (table_member1[i] << 8) :
-			 (pcie_gen_cap << 8)) |
-			((table_member2[i] <= pcie_width_cap) ?
-			 table_member2[i] :
-			 pcie_width_cap);
+		smu_pcie_arg = (i << 16 |
+				pcie_table->pcie_gen[i] << 8 |
+				pcie_table->pcie_lane[i]);
 
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 				SMU_MSG_OverridePcieParameters,
@@ -2101,11 +2162,6 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 				NULL);
 		if (ret)
 			return ret;
-
-		if (table_member1[i] > pcie_gen_cap)
-			dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pcie_gen_cap;
-		if (table_member2[i] > pcie_width_cap)
-			dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pcie_width_cap;
 	}
 
 	return 0;
-- 
2.34.1

