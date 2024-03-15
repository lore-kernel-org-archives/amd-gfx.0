Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15D1C54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 05:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 442DF10F51E;
	Fri, 15 Mar 2024 05:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a6nWtR92";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6CEA10F51E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 05:42:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOBIzgBGpMftwo7Qr2Lenxuu68/N8jiQ84ZwTqAmnUWGqgNYjE6bnIuySXf/JqINyhP4gA2urtl8B37x22IBPgaJeaRjai5V7V/b8a8orwUVj/+w/xJ5NYeLPDe+H5A8NyNUkRDqTo/v0WmT3gugdvKhCUWS/Q1D2HCoxdLnsEGbk1aI8m3EfDBElf7h52j9i4cR7gQTf/wp7XdL6wyEllaNlLKYTTkn5JPe9Ml4h/O0ANwGt8h4IRuuJmGtzkTW/qjjewWpa3+0lxwvnIzOWxoGFUORROoVQpgJRR+3mIZAnnNBvP2Ge5fl4bpncU3zjNYp+d1hMUAuPXXVvbdnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HoBKKlPiafse1qdAPR4deEu+tLEwpkCm1T1W+V3MaU=;
 b=hVENaCeWu4hHrzWr06mmdV6ZK+/oxYSwX4r3K/y1uy9lGXHflztth2iAUF000wX3fZh8sF/c8WJYQOaZkjamvSNEIqvNUyYmB2XICK/VmyAdueP1yBSnJGq/Q+zHy5AbbYy6EBr3NhH0jmH/gyxaXvaC+nDMErFIJRukAmFvCnMRmY7jhYv5o5KJ770eOtwCbruVAZOAh0tm3Wx5p+Fgn5zJigt+O8y9hmMmhLbhyNG6lvoCRw1p+7LuWKnGx87+y4KujlcgxrcDqOdCzPo2B39LdeOBCNHJnFu6GZexx5laDBEDwuJ6BMCeyaJEE7B2LpVSUIZSDP5cE/uqAYbyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HoBKKlPiafse1qdAPR4deEu+tLEwpkCm1T1W+V3MaU=;
 b=a6nWtR92Of4PiEmwxyr9b+c1quULk7TqrUkpS4huYND04odyURdwY4O/JYPQ/bpQhSvTZDgwZ09kMlnnTdjrVcLSOOm/T1lPHFUURVyUpSL36fCR/WDLFSXaH8IC8XQAp6I2J0CdU240BVS6kkMrbyiwx+PrrmAsHtg2ybpHzos=
Received: from BL0PR02CA0122.namprd02.prod.outlook.com (2603:10b6:208:35::27)
 by LV8PR12MB9357.namprd12.prod.outlook.com (2603:10b6:408:1ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Fri, 15 Mar
 2024 05:42:09 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com (2603:10b6:208:35::4)
 by BL0PR02CA0122.outlook.office365.com (2603:10b6:208:35::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.20 via Frontend Transport; Fri, 15 Mar 2024 05:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 05:42:09 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 00:42:05 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>, <charis.poag@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Use metric table for pcie speed/width
Date: Fri, 15 Mar 2024 13:41:49 +0800
Message-ID: <20240315054149.3259906-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240315054149.3259906-1-asad.kamal@amd.com>
References: <20240315054149.3259906-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|LV8PR12MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d35b8c7-6d3b-4b91-4529-08dc44b2a823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GH1swfXF/MrUTMsMuMJxVlhCfFWEWqIKRw3HSpE+hODVZwwpPoMRiNaSdM0NFReOcktdyMlCAIKIKYUxqpbdnMQbvMnPyNskWHY0SAuZc5E8QMnoJMVucX+9DcJjzxITrpPPkAuhfkeCK5eg4ji6yioRrv3Q4PmN+4bnsYL8iiXF31/dVnyZTe8pk5pa7dWdnaHvZPJZ2UQJ9HTpKCQZAr0t0HRevQY/YaEjAgrFjwDtls5ZdwJFEalCk8nXEpp5upX7hIF5tnlgEyGRJKJ8JxJw69+pSSf4wWBIO82HKeaJIA1ow579Hb0Pk0Zm3ikfGyt0o7jp4610E7BgbAKehC12r1O1QVhuR8wEMpu9Gvp/9bDrFFfujmDPeUSqWj/2VsgPrjl5ad/8BvYwprruNB4RSTh76jBzk6ce2MDj0EM+4NmfY/nGsCDJBEQfy2Fi/UeUkwVH6aFxZpJtI43retfp5PylFbPF2K3HYOacNZ/71FSdrBHkXSmWC52AWBU6g9yowXDcfmsVfM+Z4L7URBly7PDTSqIFTkW6/xF1uMMfpGJCfMC15b53buudmP+vD0k7FlZ/pd3VsCE1UmxgN3Agcsx0F2XeAc+N9XIgT4ApXZ0+sMiWknC/4ZWYD9YBuq8fQpNvtNtezki56oIYC7hKbwEL/LvTjZN1JPa5Nh/sNg1IA23dPl+piQtaYNrbeiQLAXusn8JwziIirLjQsSybzFQhAY6bauNHZxph66droE7KEvmGpIx3M1Xf/edw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 05:42:09.5206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d35b8c7-6d3b-4b91-4529-08dc44b2a823
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9357
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

Report pcie link speed/width using metric table in case
of one vf & if pmfw support is available, else report directly from
registers in case of pf. Skip reporting it for other cases.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 744c84f3029f..2a934864b5eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2167,6 +2167,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		(struct gpu_metrics_v1_5 *)smu_table->gpu_metrics_table;
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, xcc_id, inst, i, j;
+	enum amdgpu_sriov_vf_mode mode;
 	MetricsTableX_t *metrics_x;
 	MetricsTableA_t *metrics_a;
 	u16 link_width_level;
@@ -2229,7 +2230,17 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak) >> GET_INST(GC, 0);
 
 	if (!(adev->flags & AMD_IS_APU)) {
-		if (!amdgpu_sriov_vf(adev)) {
+		/*Check smu version, PCIE link speed and width will be reported from pmfw metric
+		 * table for both pf & one vf for smu version 85.99.0 or higher else report only
+		 * for pf from registers
+		 */
+		mode = amdgpu_virt_get_sriov_vf_mode(adev);
+		if (smu->smc_fw_version >= 0x556300 &&
+		    mode != SRIOV_VF_MODE_MULTI_VF) {
+			gpu_metrics->pcie_link_width = metrics_x->PCIeLinkWidth;
+			gpu_metrics->pcie_link_speed =
+				pcie_gen_to_speed(metrics_x->PCIeLinkSpeed);
+		} else if (!amdgpu_sriov_vf(adev)) {
 			link_width_level = smu_v13_0_6_get_current_pcie_link_width_level(smu);
 			if (link_width_level > MAX_LINK_WIDTH)
 				link_width_level = 0;
@@ -2239,6 +2250,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 			gpu_metrics->pcie_link_speed =
 				smu_v13_0_6_get_current_pcie_link_speed(smu);
 		}
+
 		gpu_metrics->pcie_bandwidth_acc =
 				SMUQ10_ROUND(metrics_x->PcieBandwidthAcc[0]);
 		gpu_metrics->pcie_bandwidth_inst =
-- 
2.42.0

