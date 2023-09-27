Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA4DE743C9
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 22:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0101810E052;
	Thu, 28 Sep 2023 22:09:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7756A10E052
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 22:09:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YECkdIXtkgyun0FTmra6n3rr7HLnCB5WlzXE5OYw94+qT5rUVKIGY0Uz/2lkhHTf3v/Yy3bJrV4pQdhrNQMmSlFeSuUTupkuMusU+THwQbcbBGLLejQ6wMUBH6AfYaHj9UYq70LjdOFkGzKkh34Hlt6CEldvTOsrLMhDjsXkb0nWGRzhWgCzBiygc5IrI8n6hcvDxv5+DAxNACG6HjQYrVLkVgGoQ8XE8/+v1zw9xrFUUK4nzdlEaBQ/Wmh/q9JvOoEPAXhedic6ypovSouMLQ2amQz+SnyriTPyap0GoomXaMXQbTu5r1PhRLb49pyqPb4WyNMBDN9ghUrKCJlnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaQfH4d/BMXjGIT242AcWkGsAOfDAlyR2R4szslOWP4=;
 b=Gh1JK3O+5KbwZTBMCRHNBi3sGcLoN+ifatKF7PmeUF1g/T7lWwX2dagX3Svtwm3PZ3w1dqaccT+IdHpUyhfnrviD4oAqLhrB1jKZNp5dECOolaubdTN8wqWv0/bBO/bP5nXbwjDKH/tCZslyBgLWHLsvo0sJNIWkdAVNaqQb1f1N2vg5hpiLgmUPukY73P8WC0zDv2zCLJwIoS9NPVBYhwHnqiUi+mk5ONKgErPF7FiXM4Dxy5esCND25XkyusdmZ3SBRxZJUGPYVscLK4l9lz5RrlYTo3wyylbM9UbpwocM2s8AaADxtRs1OSRWRoBreqkkDFK5qVFcfpOHRdP7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaQfH4d/BMXjGIT242AcWkGsAOfDAlyR2R4szslOWP4=;
 b=cE3oiC18BA+pV3K6VSdOTCi6j4wyLfxrcC9Kyxdc2UMCaWwRvgrXdmigmUMSFxDMmD0kyR9/YhErKjL9EidrMMEcuV7SOVpwXTLwGw8sC+r0Y1NtHYG496sK3zxpmUjgarQCmUOmC+QVrDRgfuVnbLA6FtJRVPbzEv2ga5N3Icw=
Received: from SN1PR12CA0050.namprd12.prod.outlook.com (2603:10b6:802:20::21)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 22:09:41 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::16) by SN1PR12CA0050.outlook.office365.com
 (2603:10b6:802:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Thu, 28 Sep 2023 22:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.21 via Frontend Transport; Thu, 28 Sep 2023 22:09:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 17:09:40 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Fix logic error in
 sienna_cichlid_update_pcie_parameters()
Date: Tue, 26 Sep 2023 21:07:43 -0500
Message-ID: <20230927020743.387802-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|BL1PR12MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 2305f7f4-5e3a-48ad-ab4e-08dbc06f9d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLs8eJUTMnc1UVHvBvlTcqLWNeTnTtQ8aQnZjAdTo1qbdKzQlaCjYTQTiPJVJyOLc1uyEAiCcGcghyfDb3tKkHfF7R5uKMVmuhY8pT3vT6qcTNB/QeXw4gx3DC+JOvAfZSE07HNMG8WUAJUQB25mtwDD0Pbb+205aEBBX8yf1+lOZOg2GNyvunqxffC5i4TqAjdASDIJVU3XhI4mahJmcjv6XvKIYl8e3yKxdnleC7YpkdR3ggmyKWiNQ2rLGYF381fmJVlenFHWHKYMtLLR19UfiJL+TiB2aJGi37YuOYVGoMItECrArkabSeV6Xzmuw4axXbTdOal4TFySJPgUfnvpujLvgQcl7jFEDxNjKGUPRh2HJupF38xst1zc9yd8mt0v6nbGbsNwY6279xeoUZpobJLln5ilikHYgpiLKO8LjEQBNbtdwZtw+br6ctv3S8pRcJsPhqh3uJeWtWn9Djf4ZNQI9hMk5Ul2r7+oXUNMIpfOjIVdA0lj3Pm41zO0+NmlEq/ESX5JpMZ+FpaU+bfm93Us1guJJODPWF+vp9lIMGZhvNjl+N+02NA10sEvcAdwKWx5PK++25Q/FOhvy4c2zntaY5w5D/FgD7OVI0YaIbrX2E5EbyATogfNbUl7zBBKe0ZB5Opm7N2be3UOWpJW32gNb7ZuzwOnhKzfTpQI611Bdw3uDvrO+1HNbdwgkKOtnZVJq9e+6bIw4Avw63ZHz6pHmp0YlX+SFfDeTTIFb2G14XPeTZTTnI1SD19e
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(46966006)(36840700001)(40470700004)(44832011)(8676002)(41300700001)(8936002)(40480700001)(26005)(16526019)(2906002)(5660300002)(316002)(70206006)(54906003)(70586007)(4326008)(6916009)(478600001)(966005)(7696005)(40460700003)(1076003)(47076005)(36860700001)(2616005)(336012)(426003)(83380400001)(81166007)(36756003)(86362001)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 22:09:41.4858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2305f7f4-5e3a-48ad-ab4e-08dbc06f9d44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
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
Cc: coelacanth_dream@protonmail.com,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

While aligning SMU11 with SMU13 implementation an assumption was made that
`dpm_context->dpm_tables.pcie_table` was populated in dpm table initialization
like in SMU13 but it isn't.

So restore some of the original logic and instead just check for
amdgpu_device_pcie_dynamic_switching_supported() to decide whether to hardcode
values; erring on the side of performance.

Cc: stable@vger.kernel.org # 6.1+
Reported-and-tested-by: Umio Yasuno <coelacanth_dream@protonmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1447#note_2101382
Fixes: e701156ccc6c ("drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters implementation with SMU13")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 41 +++++++++++--------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index f0800c0c5168..9119b0df2419 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2081,36 +2081,41 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 	return ret;
 }
 
+#define MAX(a, b)	((a) > (b) ? (a) : (b))
+
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					 uint32_t pcie_gen_cap,
 					 uint32_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
-	u32 smu_pcie_arg;
+	uint8_t *table_member1, *table_member2;
+	uint32_t min_gen_speed, max_gen_speed;
+	uint32_t min_lane_width, max_lane_width;
+	uint32_t smu_pcie_arg;
 	int ret, i;
 
-	/* PCIE gen speed and lane width override */
-	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
-		if (pcie_table->pcie_gen[NUM_LINK_LEVELS - 1] < pcie_gen_cap)
-			pcie_gen_cap = pcie_table->pcie_gen[NUM_LINK_LEVELS - 1];
+	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
+	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
 
-		if (pcie_table->pcie_lane[NUM_LINK_LEVELS - 1] < pcie_width_cap)
-			pcie_width_cap = pcie_table->pcie_lane[NUM_LINK_LEVELS - 1];
+	min_gen_speed = MAX(0, table_member1[0]);
+	max_gen_speed = MIN(pcie_gen_cap, table_member1[1]);
+	min_gen_speed = min_gen_speed > max_gen_speed ?
+			max_gen_speed : min_gen_speed;
+	min_lane_width = MAX(1, table_member2[0]);
+	max_lane_width = MIN(pcie_width_cap, table_member2[1]);
+	min_lane_width = min_lane_width > max_lane_width ?
+			 max_lane_width : min_lane_width;
 
-		/* Force all levels to use the same settings */
-		for (i = 0; i < NUM_LINK_LEVELS; i++) {
-			pcie_table->pcie_gen[i] = pcie_gen_cap;
-			pcie_table->pcie_lane[i] = pcie_width_cap;
-		}
+	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
+		pcie_table->pcie_gen[0] = max_gen_speed;
+		pcie_table->pcie_lane[0] = max_lane_width;
 	} else {
-		for (i = 0; i < NUM_LINK_LEVELS; i++) {
-			if (pcie_table->pcie_gen[i] > pcie_gen_cap)
-				pcie_table->pcie_gen[i] = pcie_gen_cap;
-			if (pcie_table->pcie_lane[i] > pcie_width_cap)
-				pcie_table->pcie_lane[i] = pcie_width_cap;
-		}
+		pcie_table->pcie_gen[0] = min_gen_speed;
+		pcie_table->pcie_lane[0] = min_lane_width;
 	}
+	pcie_table->pcie_gen[1] = max_gen_speed;
+	pcie_table->pcie_lane[1] = max_lane_width;
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
 		smu_pcie_arg = (i << 16 |
-- 
2.34.1

