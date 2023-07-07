Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9C2EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 19:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFF7210E14F;
	Fri,  7 Jul 2023 19:32:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E8D10E14F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 19:32:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tmkk7j9rOm8BfZUHmJ4Un4jXpNy6gUx1i4kl7bpSCMXypl2r+PtnSktussZPM4SLnrU77oO1zMs9LDnH9XpachYVPg34/4TnYOCyxM8A4kQxPQiHeJsgLHhfveGhz+B+iQm9Nv7RKeuIE6Tpab28rnY5A3JmrG/GY9IdHG24SLdLmMoxSoStQR6z4W+aKD4fB4WoOUu8vaN05WdLrWoGXfOPJy9QODp9PN6g/oRBRvscyLC5HyEbjI/gevM1PYhv5SeYbAZIVbZ9s40wJQoDyuJAA/peuZCvEdr8cvqZa6j/N1sycbWagiqFzZXkoLhwX6EXLG3mS5EvVGHGqb0zpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CSkOXO2JI12/H++cSOkHbM478cQvrswr9pcrz0Xx0I=;
 b=Sx7qr1A9ZLU2i99P6ITK/vw3jqSRErvhnwQ3A0vjrR3nGnLiDR82vOUK3KF0QnE963lL8SoCg4F8pk1/tayF9BZN8xBQKLniDAdILJ0cQbfQ00Kf0I64lBiP9gS23sL6CSvDveK6gdDFDFJgJUNXc/0wLGV5O8eu107SGVFElXwQ7XmTBSmBn2gFqg7hz3iNnVE11K3eNXP2QVVi6XUv2nVNJV4zLdHapL9CNQW/ivu7lLiMstrcaTJZrvSG3Oued2Y/6Sj87rt4rmbjT3Cp/82oLdvOVnlA4qW3WjBX4P43xq8n734XdmjRHITOb6Lk4HsgA7w4KWpbjUmMCmkP5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CSkOXO2JI12/H++cSOkHbM478cQvrswr9pcrz0Xx0I=;
 b=TaCVPbDtpRhK0qhGtND6X9OT6zG8vSYV0LYrcu/ZUzblRFalKMmmNI8qdmPHWt1xzWiO4GZ6EQ09//otMpgTUb0XNDz3mI0d0mMQc62lKLWKMhI95OiGIaQXiwzks/gTFwU5zqIXNzbA1j1n39cZGZc8oozIcN205LIkO1Rq0hw=
Received: from DS7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::15) by
 CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.26; Fri, 7 Jul 2023 19:32:01 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::bb) by DS7P222CA0012.outlook.office365.com
 (2603:10b6:8:2e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 19:32:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 19:32:01 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 14:31:57 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: conditionally disable pcie lane/speed
 switching for SMU13
Date: Fri, 7 Jul 2023 14:31:35 -0500
Message-ID: <20230707193135.16716-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230707193135.16716-1-mario.limonciello@amd.com>
References: <20230707193135.16716-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|CYXPR12MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: eee159e4-96f2-4e3c-9e2e-08db7f20d63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcutiNHUQw4gDkkOdQnKOIKFWolBEbIh1ZkBzdwG+78wWsbZt0NyPedLbMEmSF3+nc3A3fZonJSTJNL3uyhhxI+wdNRbWsqnfAfgQGQufYqL4BclYXL87oMbDpsIlBkwINgOzHanBmrbv2By7k64kCCcoyQh4HjGc2kpLF5mIpdR2Il7jx7ivhq5rL+i3T8Q9r0OnqWtyVyEeUCmn1uRXGmusYpB5WfEfvg0CTauKKnwu2Tb3zvg++4R+MY4/WgERgfrR9jzCz0Po5wlE6BM5oNpJQdyd1zUygFZ9JqEHqMzBVsSPRNkAavQ/bQB7GN3iBL3nkgWmZZt+7N2mfNUJx1NfDUHgD9ND0ME59nNiOF5TA+hmsqU1LVeHkU2KXiyt3EBikqof0pTwhI33n4M8DGBbABgHHed0gxmHiuVYPAUjq4u8HkCSfZ5bTsgsRw/PoC9+ZrP+HDCbGD6bVRLbD47HlxhgrR7H20MkkM3L66ps12R4rGzHHdCj6eJa8wW1M+lyMG9Xg6+IJqQUuuyShUvGS+E3j9i8uipDvgD2UN/DGMWzS0fb+LfzY0x0hVobows5dWpAL61xa/jfNzyukw+Is9JFuif5CxPsN3FsO9Y2HNYYUyKMVXiUrA68rBe83KTPX1b/1MYJ5pYFpDQ1XheGOHwvHLb/6Sal+kXEpsb/kjuKvR17uGrhlbnOGewLEUOTzNwUSK27E4BtuWl/xApITNhpUDwnqnOvn6AagG4cNXX7mjzWvABXyEHlWH9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(26005)(1076003)(16526019)(186003)(966005)(36860700001)(5660300002)(83380400001)(2616005)(336012)(426003)(41300700001)(4326008)(47076005)(2906002)(316002)(44832011)(6916009)(8936002)(8676002)(7696005)(478600001)(6666004)(70206006)(70586007)(54906003)(40480700001)(36756003)(82740400003)(81166007)(356005)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:32:01.2253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee159e4-96f2-4e3c-9e2e-08db7f20d63c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427
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
Cc: Evan Quan <evan.quan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Intel platforms such as Sapphire Rapids and Raptor Lake don't support
dynamic pcie lane or speed switching.

This limitation seems to carry over from one generation to another.
To be safer, disable dynamic pcie lane width and speed switching when
running on an Intel platform.

Link: https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2663
Co-developed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 42 +++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 2ef877c2cb590..cf7e729020ab6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2425,6 +2425,25 @@ int smu_v13_0_mode1_reset(struct smu_context *smu)
 	return ret;
 }
 
+/*
+ * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
+ * speed switching. Until we have confirmation from Intel that a specific host
+ * supports it, it's safer that we keep it disabled for all.
+ *
+ * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
+ */
+static bool smu_v13_0_is_pcie_dynamic_switching_supported(void)
+{
+#if IS_ENABLED(CONFIG_X86)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		return false;
+#endif
+	return true;
+}
+
 int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 				     uint32_t pcie_gen_cap,
 				     uint32_t pcie_width_cap)
@@ -2432,15 +2451,32 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_13_0_pcie_table *pcie_table =
 				&dpm_context->dpm_tables.pcie_table;
+	int num_of_levels = pcie_table->num_of_link_levels;
 	uint32_t smu_pcie_arg;
 	int ret, i;
 
-	for (i = 0; i < pcie_table->num_of_link_levels; i++) {
-		if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+	if (!smu_v13_0_is_pcie_dynamic_switching_supported()) {
+		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
+			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
+
+		if (pcie_table->pcie_lane[num_of_levels - 1] < pcie_width_cap)
+			pcie_width_cap = pcie_table->pcie_lane[num_of_levels - 1];
+
+		/* Force all levels to use the same settings */
+		for (i = 0; i < num_of_levels; i++) {
 			pcie_table->pcie_gen[i] = pcie_gen_cap;
-		if (pcie_table->pcie_lane[i] > pcie_width_cap)
 			pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
+	} else {
+		for (i = 0; i < num_of_levels; i++) {
+			if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+				pcie_table->pcie_gen[i] = pcie_gen_cap;
+			if (pcie_table->pcie_lane[i] > pcie_width_cap)
+				pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
+	}
 
+	for (i = 0; i < num_of_levels; i++) {
 		smu_pcie_arg = i << 16;
 		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
 		smu_pcie_arg |= pcie_table->pcie_lane[i];
-- 
2.25.1

