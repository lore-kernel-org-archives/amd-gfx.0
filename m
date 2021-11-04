Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291D2C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED2BD61106
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED2BD61106
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 056367378B;
	Thu,  4 Nov 2021 20:52:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96FB736AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeGVuFHqLop7THR/OUjvIHgcuUfqJjfebjUSt7nIiw1P6U2BOfou7Sj8R6Qo12pfLr9M7ByJdodT3kBiwb5on73M2I7k1nHfYmbIbUNewpwE0lecmH5GZmbCvpePndNLf/yHWY6Fvb+Igk+4+V7hjb5rThCgB+Jn+vXnv771Y5VXwLiTRUkvIMyQkIicOCJtxnOLXJNrNoGAJ2Q6VZmmFGY68bw1tvZen0XtGZwuTCIkvwuHcA2Rl/yGca9i711TgkXWFKKCmMGvAbPOAv/vsg9PUfv2bxp/GD6cCk9O7yhsqvQVEAPxDWahPqV2RgFLADKu7ezSFNKInOEhOetWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cKjoFwMtTf9ofaB5BbdnAhEMIFR/KFzhY+zjsYXLA0=;
 b=n2S6UqHFAsQyBe0BYN9KVju8XqZbdIRFQUwNMSumFJ6Da2WRFia4o7EFLd9aXNE+xlwcjydlX3hk5sbYd5EMGZkb64omm3Vp3b6heaISqHpnaASOzd5BMpFMsk7ynA5MaP/Qv52Q6+m4SAm22wsK1s0Ij0YBiL0x+ubMNURYHF154N1h5nirRa4eCO4p6u2vSmp2Iu81jUKQ3NDWH9dVanXmAL86ubHT7Ht+jON4QCkLzj4Aob9rzbj1KZS6UW8fTNE5JJg6wasWFOoFdxpacPIYSr6kJv+h4BIjaBNzTuVFdwAtXKSK1cxFv+ECRsJF+ASoPvh5yaoSgD+qsPLlng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cKjoFwMtTf9ofaB5BbdnAhEMIFR/KFzhY+zjsYXLA0=;
 b=gGfthEoUMGK9QQBo68vINOylK0vaxngRzAzUbVNqv9EQ1Z0qQqdVJGV3Li5B3G5b2a1PymSKnvbWDm0QHULLseLqXlTWu+Wm1+vOBPFJVOSCpDHJVyC9yLaSeiOAd68oLX2YrVGF6bYo/tNbIZiHOni58A5dadjvp6xUOLeGrss=
Received: from DM6PR05CA0037.namprd05.prod.outlook.com (2603:10b6:5:335::6) by
 MN2PR12MB4606.namprd12.prod.outlook.com (2603:10b6:208:3f::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.19; Thu, 4 Nov 2021 20:52:30 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::63) by DM6PR05CA0037.outlook.office365.com
 (2603:10b6:5:335::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.5 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:29 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 13:52:27 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:26 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/22] drm/amd/display: Fix detection of aligned DMUB firmware
 meta info
Date: Thu, 4 Nov 2021 16:52:00 -0400
Message-ID: <20211104205215.1125899-8-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47be0597-a27d-4806-ed66-08d99fd503ea
X-MS-TrafficTypeDiagnostic: MN2PR12MB4606:
X-Microsoft-Antispam-PRVS: <MN2PR12MB460623373426A5CE496E269FEB8D9@MN2PR12MB4606.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LipB8vS/tWgVGTWIhVPnKQfV8cfOUIbiPEI4kpwgn4bbJeSZMs51Y9XYs8QMjKgVmA66td5MRpMxcpE29H6MOld0ZDE0V9qWelLelGHd+IHVapRuBCCCYmBCux6xAb2mZhhYal8wqvFj7cqnLV3JC2BvHntE0UXB169vSWmra1HAIek+ZUYIjHpWmP65UXMpyezxLB3PE02Jq9gTxGIJiU3TdQqMmPXoILEwWfeivFmA8i4JoxbrcKUnX0coTk+LCZDYzAqhkDlvJFNcDX7P0sv+wejBLChTDR1vAXJnEwUM6GyP9dhku8bcDbbBCGfJ2wuuObkNZiCNnGGVM1XYuAlys+pPr9umMC4IWNxrZUQj/zXk7oerkg7zQVCrpQpAFSHoY0JXU0kUOsy8t9sL4LyC7nZRBnPZScshFKbtqMxG9WJUIC4cno508muMEvWhTtE8CsBUiw81W95g7BvY8tWSYL6QrJc9axZMxdLcMtxQ2FLcaZoIPcqIIes9g/rjOJvHvdNMw+xxNgd9ay9ix1MMspECbXkRGJzQ14VpBRz4lBzvVZG1rR6kC4gTxOnpvHqs3D+NQjK783LAlrFWKL10uH+LYMNDpddOfqAWz5uXl03dYsBp/3UsBltnmsWz6pL8qxxIFikoF3kEAthOWlLeIR79q5nRh0CC2Z63WRZlQtTsFyoyACGHYLfA17GNW8siFAXd6fOLTVca+GYBdo0dZNM/AB//TkYwKWdvHI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(2906002)(86362001)(54906003)(426003)(186003)(82310400003)(70206006)(26005)(7696005)(8676002)(6666004)(36756003)(2616005)(4326008)(508600001)(81166007)(316002)(336012)(8936002)(6916009)(83380400001)(70586007)(5660300002)(47076005)(356005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:29.1304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47be0597-a27d-4806-ed66-08d99fd503ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4606
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
A built firmware binary may be aligned to 16-bytes with padding at the
end as necessary. In the case that padding was applied the meta info
will not be detected correctly and we won't be able to allocate the
appropriate firmware and tracebuffer sizes.

[How]
To maintain compatibility with already released firmware where this
occurs we need to try every meta offset from 0..15 inclusive.

Extract out the meta info checker into a helper function that's called
for each of these offsets and exit early when we've found it.

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 43 ++++++++++++-------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 56d400ffa7ac..4a2cb0cdb0ba 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -100,24 +100,9 @@ void dmub_flush_buffer_mem(const struct dmub_fb *fb)
 }
 
 static const struct dmub_fw_meta_info *
-dmub_get_fw_meta_info(const struct dmub_srv_region_params *params)
+dmub_get_fw_meta_info_from_blob(const uint8_t *blob, uint32_t blob_size, uint32_t meta_offset)
 {
 	const union dmub_fw_meta *meta;
-	const uint8_t *blob = NULL;
-	uint32_t blob_size = 0;
-	uint32_t meta_offset = 0;
-
-	if (params->fw_bss_data && params->bss_data_size) {
-		/* Legacy metadata region. */
-		blob = params->fw_bss_data;
-		blob_size = params->bss_data_size;
-		meta_offset = DMUB_FW_META_OFFSET;
-	} else if (params->fw_inst_const && params->inst_const_size) {
-		/* Combined metadata region. */
-		blob = params->fw_inst_const;
-		blob_size = params->inst_const_size;
-		meta_offset = 0;
-	}
 
 	if (!blob || !blob_size)
 		return NULL;
@@ -134,6 +119,32 @@ dmub_get_fw_meta_info(const struct dmub_srv_region_params *params)
 	return &meta->info;
 }
 
+static const struct dmub_fw_meta_info *
+dmub_get_fw_meta_info(const struct dmub_srv_region_params *params)
+{
+	const struct dmub_fw_meta_info *info = NULL;
+
+	if (params->fw_bss_data && params->bss_data_size) {
+		/* Legacy metadata region. */
+		info = dmub_get_fw_meta_info_from_blob(params->fw_bss_data,
+						       params->bss_data_size,
+						       DMUB_FW_META_OFFSET);
+	} else if (params->fw_inst_const && params->inst_const_size) {
+		/* Combined metadata region - can be aligned to 16-bytes. */
+		uint32_t i;
+
+		for (i = 0; i < 16; ++i) {
+			info = dmub_get_fw_meta_info_from_blob(
+				params->fw_inst_const, params->inst_const_size, i);
+
+			if (info)
+				break;
+		}
+	}
+
+	return info;
+}
+
 static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 {
 	struct dmub_srv_hw_funcs *funcs = &dmub->hw_funcs;
-- 
2.25.1

